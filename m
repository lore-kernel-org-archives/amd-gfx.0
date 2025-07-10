Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C84C83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 13:17:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97A3E10E3A2;
	Fri, 11 Jul 2025 13:17:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WJVXqqL3";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3987810E98A
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jul 2025 23:43:07 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AJQtBS013136
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jul 2025 23:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=O6dneaoEJTU4dB5TWgOZwO
 yJvDGKlM6DOiO6ssR/9JM=; b=WJVXqqL30MlBFZimKymhYq0ZPOc2GjQ8kRGkbn
 JtTWjw2HfnXQ/+A8ZgY/nBlGV6LWs3MT4eznqJyTRJ0mPuDgkJUh02MyxpDVImIZ
 qeovXmX+ARKDOhbZy6WzJ87cIq3ST2EE5sv3e81NVl87WAsZCHO1kHlyjqDrDzqf
 Bxh04kzmwRYEUeHXHWk8Z+VLoT7H7E1nobaKLxxGdG8CtYHu5ZNJvK3ISjhDbwyo
 Vz9FgcJEeu9e2SbyjSMSxZxM5JgJkxpFeZA0eJTHuuvCodg/f4ZT2XAFpYi1Kavy
 lrb8n8KYvjUl5WLKyvqk7h25xWoagu/I/8ditp4+cWbM+9JA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pucna61b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jul 2025 23:43:06 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-235e3f93687so22063995ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jul 2025 16:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752190985; x=1752795785;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=O6dneaoEJTU4dB5TWgOZwOyJvDGKlM6DOiO6ssR/9JM=;
 b=WTXnRo2VqliA4woKh1G6DCQ66FkbDiV944mWtPeTYaxhuPJiKg+IiR3sAHFxPypimP
 8XYphhDFbwgUngaxdhFMtr20RkXUK3yagQvkwGYpm9vjEFVce4MenXGbWbQQALuixRHB
 FadBhiu3KzOnnqYm3a22LQ20T2eIkEpVbb3P0e8WvMu/qWYUI9RP1/l3xwcibnBcZxv5
 ng9X5wGQyC58fk3INyjpUaA6M5HFFzFMofM6cC70to05jnpn3Sky1p/iG3qYizh7Jv2w
 SWKA/y6/hgQWKKVVtymPp8dKv1KliccxpD+O+hpgl+/lJnlXX85wU6ruUdCyQj9cYOP2
 Xq/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4AWOJ1Jf2PG+ySkUxrGD36qbYQNwnsNqMM13HaMs2LJ3R/3YpisIUXDsw6yz0/PBYp0HuZdBV@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKh7z9xUA1cWKeopUv3TS2/saqJbUesmGgBSWofaeEYewT8uUo
 9JgUkr/Wby3xL6UjXMjJTuDUsBfqncAl0mc4I/PJQGkQeMpC5F/PaogPYJYPzQMIIgWfcpe6j9o
 ZeBDa4D5ztUcq6lWt3QhswdDwNATZJiHh0He2Lg5+aq0O1q7cWQ3VQFmAaHq8nlNaGWW0
X-Gm-Gg: ASbGncsGDhwly1Hu1yKwvyCWMQ94mtx8jZ5mpyoAJxlV7ZBsjUPUNj23WZi1eJIICrC
 l+Y09RsemrY9bz0XfUOdOrZhSvfSw+IO4ZUQzisZZNwYEViR1XoiGHE8YcXLEB6O7xQVIZnVbOe
 W8EaWTTk2iQ2qTqJqbOhww4nYICAtqWP2ErBD2rVYvxtFABQPfT6nWOqqbZau8DUaiG9WZHA4vQ
 5DpJap6NHQb4H0qQ9Sli/3JI2YjHmBfxmQQNIu3d2MlUwtU7pizs9KeSKvhXwHNEe5zyDQMZANe
 MxkM7TI+5kPpFEaLjAu4yZbitPkmEt1VB6e+X9uoLc+Th3jBeTDzHNkLuNbJblU/enDaWJnhulZ
 4cHQ3N9OUnZdcv4VBWjgl5xtq58hjX/Mc
X-Received: by 2002:a17:902:e947:b0:234:9092:9dda with SMTP id
 d9443c01a7336-23dede7d49bmr17258295ad.24.1752190984472; 
 Thu, 10 Jul 2025 16:43:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHND8BuRmtddpqtYLgCU+bPJQKH6MwPIq7BEDW2QdigNAgxlg8RW8yy15cqprrIb+/9yikrig==
X-Received: by 2002:a17:902:e947:b0:234:9092:9dda with SMTP id
 d9443c01a7336-23dede7d49bmr17257985ad.24.1752190983964; 
 Thu, 10 Jul 2025 16:43:03 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net.
 [73.202.227.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de4322e7fsm34742765ad.93.2025.07.10.16.43.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 16:43:03 -0700 (PDT)
Message-ID: <0a087cfd-bd4c-48f1-aa2f-4a3b12593935@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 16:43:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Linux AMDGPU <amd-gfx@lists.freedesktop.org>
Subject: WARNING: possible circular locking dependency detected:
 drm_client_dev_suspend() & radeon_suspend_kms()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GdQXnRXL c=1 sm=1 tr=0 ts=6870500a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=eMaqxZqQJXyQkHEHPUwA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: Aej3A53zrrv3PJzUwa6hDjUBcJ3R1ZCg
X-Proofpoint-ORIG-GUID: Aej3A53zrrv3PJzUwa6hDjUBcJ3R1ZCg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE5OCBTYWx0ZWRfX0rSjBdpPI1m+
 5B41df6guJJjV/cLrORaFCowpms+B9gm7kBOBIAXTEywjddc/AfrXj+o7JKKpmFLG17lYDZZaMP
 lGQSy0QsSPp6v6yTIXo+FffJOCgSuAQEq6eZUAxPTENPQoSgkmHFB5l2f/+TVXJpQFF/yoh/Z+s
 IdKlm39hMHGbKG5IswRyGANvfE2JAr9yOW/fPqpz7oB3p6saAmBpxD2dEMam43a4q5y6ASD/B5n
 3CCIZJQbCuHr59dklzdF/RMbYgiUn+P7rPx09vyDaR6UlkAJo5eTjrhSsNq4t1Ob3Rb28uhAB+f
 ttEd6wswxQXi5k8CfikxJUbrxW5ptjYjRuuiIo7ExbuOCQQlSpf37cX+FNIvE5smdhkAX62XgST
 ogdkELL+1MU57y3WRUQ610xZJHUILMFvmBTJ0+GpoNSwqY6+knjRC07l70FLLVmau+VzBI3V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_06,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1011
 spamscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100198
X-Mailman-Approved-At: Fri, 11 Jul 2025 13:17:28 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I'm trying to debug a hibernation issue with the ath12k driver, but to
establish a baseline I started with Linus' current tree. I have the following
enabled in my .config:

CONFIG_PROVE_LOCKING=y
CONFIG_PROVE_RAW_LOCK_NESTING=y
CONFIG_PROVE_RCU=y

As part of the baseline I observed the following:

Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: ======================================================
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: WARNING: possible circular locking dependency detected
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: 6.16.0-rc5+ #6 Not tainted
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: ------------------------------------------------------
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: kworker/u16:13/3787 is trying to acquire lock:
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: ffff8881113e0308 (&dev->clientlist_mutex){+.+.}-{4:4}, at: drm_client_dev_suspend+0x37/0x250 [drm]
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: 
                                           but task is already holding lock:
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: ffffffff8a2e4b80 (console_lock){+.+.}-{0:0}, at: radeon_suspend_kms+0x63b/0x7d0 [radeon]
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: 
                                           which lock already depends on the new lock.
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: 
                                           the existing dependency chain (in reverse order) is:
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: 
                                           -> #1 (console_lock){+.+.}-{0:0}:
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        console_lock+0x8d/0x130
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        drm_fb_helper_set_suspend_unlocked+0x10e/0x200 [drm_kms_helper]
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        drm_fbdev_client_suspend+0x24/0x30 [drm_client_lib]
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        drm_client_dev_suspend+0x138/0x250 [drm]
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        i915_drm_suspend.isra.0+0x74/0x260 [i915]
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        i915_pm_suspend+0x6b/0x90 [i915]
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        pci_pm_suspend+0x1e3/0x4f0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        dpm_run_callback+0xa0/0x100
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        device_suspend+0x41e/0xdc0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        async_suspend+0x1d/0x30
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        async_run_entry_fn+0x96/0x3e0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        process_one_work+0x86e/0x14b0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        worker_thread+0x5d0/0xfc0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        kthread+0x375/0x750
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        ret_from_fork+0x215/0x2f0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        ret_from_fork_asm+0x1a/0x30
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: 
                                           -> #0 (&dev->clientlist_mutex){+.+.}-{4:4}:
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        __lock_acquire+0x15b5/0x2ac0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        lock_acquire+0x154/0x2d0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        __mutex_lock+0x15f/0x12c0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        drm_client_dev_suspend+0x37/0x250 [drm]
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        radeon_suspend_kms+0x648/0x7d0 [radeon]
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        pci_pm_suspend+0x1e3/0x4f0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        dpm_run_callback+0xa0/0x100
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        device_suspend+0x41e/0xdc0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        async_suspend+0x1d/0x30
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        async_run_entry_fn+0x96/0x3e0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        process_one_work+0x86e/0x14b0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        worker_thread+0x5d0/0xfc0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        kthread+0x375/0x750
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        ret_from_fork+0x215/0x2f0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        ret_from_fork_asm+0x1a/0x30
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: 
                                           other info that might help us debug this:
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  Possible unsafe locking scenario:
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        CPU0                    CPU1
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:        ----                    ----
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:   lock(console_lock);
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:                                lock(&dev->clientlist_mutex);
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:                                lock(console_lock);
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:   lock(&dev->clientlist_mutex);
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: 
                                            *** DEADLOCK ***
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: 4 locks held by kworker/u16:13/3787:
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  #0: ffff888100dee148 ((wq_completion)async){+.+.}-{0:0}, at: process_one_work+0xe97/0x14b0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  #1: ffff88813f22fd30 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work+0x7f6/0x14b0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  #2: ffff8881049241b0 (&dev->mutex){....}-{4:4}, at: device_suspend+0x3bd/0xdc0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  #3: ffffffff8a2e4b80 (console_lock){+.+.}-{0:0}, at: radeon_suspend_kms+0x63b/0x7d0 [radeon]
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: 
                                           stack backtrace:
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: CPU: 0 UID: 0 PID: 3787 Comm: kworker/u16:13 Not tainted 6.16.0-rc5+ #6 PREEMPT(voluntary) 
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: Hardware name: Hewlett-Packard HP ZBook 14 G2/2216, BIOS M71 Ver. 01.31 02/24/2020
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: Workqueue: async async_run_entry_fn
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel: Call Trace:
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  <TASK>
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  dump_stack_lvl+0x5b/0x80
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  print_circular_bug.cold+0x178/0x1be
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  check_noncircular+0x130/0x150
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? 0xffffffffc1600000
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? radeon_suspend_kms+0x63b/0x7d0 [radeon]
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  __lock_acquire+0x15b5/0x2ac0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  lock_acquire+0x154/0x2d0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? drm_client_dev_suspend+0x37/0x250 [drm]
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_stack_trace_save+0x10/0x10
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? acpi_ut_release_mutex+0xba/0x150
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  __mutex_lock+0x15f/0x12c0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? drm_client_dev_suspend+0x37/0x250 [drm]
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? drm_client_dev_suspend+0x37/0x250 [drm]
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? add_lock_to_list+0x2c/0x1b0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx___mutex_lock+0x10/0x10
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? lock_acquire+0x154/0x2d0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? radeon_suspend_kms+0x63b/0x7d0 [radeon]
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? drm_client_dev_suspend+0x37/0x250 [drm]
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  drm_client_dev_suspend+0x37/0x250 [drm]
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  radeon_suspend_kms+0x648/0x7d0 [radeon]
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_radeon_pmops_suspend+0x10/0x10 [radeon]
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  pci_pm_suspend+0x1e3/0x4f0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_pci_pm_suspend+0x10/0x10
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  dpm_run_callback+0xa0/0x100
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_dpm_run_callback+0x10/0x10
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  device_suspend+0x41e/0xdc0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_device_suspend+0x10/0x10
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_async_suspend+0x10/0x10
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  async_suspend+0x1d/0x30
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  async_run_entry_fn+0x96/0x3e0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  process_one_work+0x86e/0x14b0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_process_one_work+0x10/0x10
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? assign_work+0x16c/0x240
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  worker_thread+0x5d0/0xfc0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_worker_thread+0x10/0x10
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  kthread+0x375/0x750
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_kthread+0x10/0x10
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? ret_from_fork+0x1f/0x2f0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? lock_release+0xc6/0x2a0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_kthread+0x10/0x10
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ret_from_fork+0x215/0x2f0
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ? __pfx_kthread+0x10/0x10
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  ret_from_fork_asm+0x1a/0x30
Jul 10 16:12:52 qca-HP-ZBook-14-G2 kernel:  </TASK>

This doesn't seem to be the cause of the ath12k issue I'm debugging,
but thought it worth mentioning since I only see one similar report
on lore, and that didn't have any apparent follow-up:
https://lore.kernel.org/all/20250202161048.373f89c0@yea/

/jeff
