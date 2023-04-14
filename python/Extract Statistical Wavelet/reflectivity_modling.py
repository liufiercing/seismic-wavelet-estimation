def reflectivity_modling(N, modle_name, trace):
    import numpy as np

    # Reflection coefficient sampling point
    # modle one : one_reflectivity
    if modle_name == 'one_ref':
        ref = np.zeros((N, 1))
        ref[50] = 0.8
    elif modle_name == 'two_ref':
        ref = np.zeros((N, 1))
        ref[50] = 0.8
        ref[80] = -0.6
    elif modle_name == '500_ref':
        # Some parameter design
        num_ref = 2    # Number of single model pulses
        num_refk = 500    # Number of reflection coefficient models
        ref = np.zeros((N, num_refk))
        for k in range(num_refk):
            reflect0 = np.random.randint(8, 13, size=(2,))/10 * np.random.choice([-1, 1])    # 随机反射系数
            t = np.random.randint(0, N, size=num_ref)
            ref[t, k] = reflect0
            ref[-1, k] = 0
    elif modle_name == '1wedge1':
        # Wedge model
        # trace = 30
        ref = np.zeros((N, trace))
        ref[20, :] = 0.3
        for j in range(trace):
            ref[20+round((j)*1), j] = 0.3
    elif modle_name == '1wedge2':
        # Wedge model
        # trace = 30
        ref = np.zeros((N, trace))
        ref[40, :] = 0.3
        for j in range(4, trace):
            ref[40-3+round((j)*1), j] = 0.3

    return ref