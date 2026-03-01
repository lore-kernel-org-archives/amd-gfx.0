Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1109BD58E61
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 13:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D52F10E4E7;
	Mon,  2 Mar 2026 13:48:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QvqTk38m";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6899510E07F
 for <amd-gfx@lists.freedesktop.org>; Sun,  1 Mar 2026 09:49:15 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-c70c112cb61so2054317a12.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 01 Mar 2026 01:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772358555; x=1772963355; darn=lists.freedesktop.org;
 h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iCLOZRRXSXIjx7C97yXLhOFBL26dMS/YptDYJoFDbmU=;
 b=QvqTk38m1gm0oOPLagOV8uigg+PK1QhLv/yTPWYXK+Lk+A3/IV0e+GdsDWdQKe1N12
 82z4Q4WUJNjZrWznaUwKw0Knnz9D7ySPfB61mNi429/drXiz9VywkK0ypSHK+bvnx2SM
 FcHVKtIO6mdw4EhdBvl3X0ud/Xpbs9cJHvct4ii7uVl1n5fISrUpjC3besk6ZBkIpn3+
 jRdHcxjvbOwAy9cluwoRVQ9Cws8cNJDDw0k7zxEHvwM7odAYrJVxrrz2sCpGBDYrkR7c
 m0/cXt44RvVXD+FvL7yWSLyMjheg0nMXegJTFzRoeJVMmTpFFL32r8Y9zrDTPJEK5dsN
 OBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772358555; x=1772963355;
 h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iCLOZRRXSXIjx7C97yXLhOFBL26dMS/YptDYJoFDbmU=;
 b=BhzUhLIkC05Z1UEJdg89fsRnY+nWkUsVZ7BPjRo5B7xggVqXlRUaAmZo/LpmzLrtjY
 HtbLqM7UWaOVPk8f1peClRLl2w3MKtYbUfrd9J4fUSzZWhyLzYLRo5q7T4/v72yqe0R2
 B2a9JBW+qLPFgvrF+EUOk9nEn39TKGlOdByiY26w+yeuOzWxSFUjl3YmyyfcLy+iXkRQ
 l/vMFx21OMmHfwR7fd/q+jp3eNNGIUez2+1kMkKwUIJSIltE1VZ6nQ2MJD7BVG767Gm5
 tLq7wmp9tPYtChOVNtQmz2MfuGTS6MFiO9xUdshIBm5W19nC75ZqjJasEXNXWU6rd8uH
 gUTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFEW6YHAzxIZLbBbkc556Q+coKedySvIuPpiLiY8V3lP/H2jOzSRbFVvjlNXBucnJJrbjLawtB@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGpaaQZNoLOIqLKb+V7wqamaKBLb5nschF/SbwVRRGP91sPHUn
 6aU6NaxiRX5N6d4B6K/Kxxon8F0QZHWk+HG3IUuf4b5NLpRU3gyf41Iq
X-Gm-Gg: ATEYQzwSre9O7ZMDx5EGULkAQHAh6NEp2flgDevFo6cUV6r2GzBV++iQaxnvbvF50eD
 ZW7cHSdu7NrneksO58Rg6DxQ/ERtiD+L3bdrbwGr5yVG+ZZIMHyCHhbDK2RmYOA/l+0XTjCg5iv
 TC5KEUjDlFLNICvvZ58BJFRI23Q3VFs7lQhNeKzxEhj+EEruSX3wP63QYhLF1Tnuja8I65UbkAY
 mzdzyu8b/JzscVu2jADd7JsRMzUs2BAYOYxh0zZB3e3QX+jFgWbSKmcYvrCSJWoM6j72cHUBYrk
 pTvs+9uba5Nm8SPo2NwGmHL0oGfHXpyCO0ydYqdeXD0HFJF1H24XKR9ysRt7UznPK9danjP/+tp
 F5fW2/P1rjN7rahfkTuPrafEPvlPObRFpBXalEXap4/xL/HWRe9n94fjIpgIWDxeQZ1k4H+T5yt
 ZxQ0SMEeC8/QTlbB1p
X-Received: by 2002:a05:6a20:3d1a:b0:394:6344:e5c4 with SMTP id
 adf61e73a8af0-395c39ef08fmr8489416637.3.1772358554761; 
 Sun, 01 Mar 2026 01:49:14 -0800 (PST)
Received: from dw-tp ([49.205.216.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb6d1ba9sm111528955ad.76.2026.03.01.01.49.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 01:49:14 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 christian.koenig@amd.com, Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, donettom@linux.ibm.com,
 stable@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/6] drm/amdgpu: Change
 AMDGPU_VA_RESERVED_TRAP_SIZE to 2 PAGE_SIZE pages
In-Reply-To: <f6b7f3e49ea54fc9c5c3f8dae607382ba9d6f58e.1771656655.git.donettom@linux.ibm.com>
Date: Sun, 01 Mar 2026 15:06:10 +0530
Message-ID: <87seajj3hx.ritesh.list@gmail.com>
References: <cover.1771656655.git.donettom@linux.ibm.com>
 <f6b7f3e49ea54fc9c5c3f8dae607382ba9d6f58e.1771656655.git.donettom@linux.ibm.com>
X-Mailman-Approved-At: Mon, 02 Mar 2026 13:48:22 +0000
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

Donet Tom <donettom@linux.ibm.com> writes:

> Currently, AMDGPU_VA_RESERVED_TRAP_SIZE is hardcoded to 8KB, while
> KFD_CWSR_TBA_TMA_SIZE is defined as 2 * PAGE_SIZE. On systems with
> 4K pages, both values match (8KB), so allocation and reserved space
> are consistent.
>
> However, on 64K page-size systems, KFD_CWSR_TBA_TMA_SIZE becomes 128KB,
> while the reserved trap area remains 8KB. This mismatch causes the
> kernel to crash when running rocminfo or rccl unit tests.
>


#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << 12)
#define AMDGPU_VA_RESERVED_TRAP_START(adev)	(AMDGPU_VA_RESERVED_SEQ64_START(adev) \
						 - AMDGPU_VA_RESERVED_TRAP_SIZE)
#define AMDGPU_VA_RESERVED_BOTTOM		(1ULL << 16)
#define AMDGPU_VA_RESERVED_TOP			(AMDGPU_VA_RESERVED_TRAP_SIZE + \
						 AMDGPU_VA_RESERVED_SEQ64_SIZE + \
						 AMDGPU_VA_RESERVED_CSA_SIZE)

#define AMDGPU_VA_RESERVED_TRAP_START(adev)	(AMDGPU_VA_RESERVED_SEQ64_START(adev) \
						 - AMDGPU_VA_RESERVED_TRAP_SIZE)

In kfd_init_apertures_v9()...

	/*
	 * Place TBA/TMA on opposite side of VM hole to prevent
	 * stray faults from triggering SVM on these pages.
	 */
	pdd->qpd.cwsr_base = AMDGPU_VA_RESERVED_TRAP_START(pdd->dev->adev);


& In  kfd_process_device_init_cwsr_dgpu()...

	/* cwsr_base is only set for dGPU */
	ret = kfd_process_alloc_gpuvm(pdd, qpd->cwsr_base,
				      KFD_CWSR_TBA_TMA_SIZE, flags, &mem, &kaddr);


This shows that it expects KFD_CWSW_TBA_TMA_SIZE (2 * PAGE_SIZE) size of
region, from cwsr_base. However the AMDGPU_VA_RESERVED_TRAP_SIZE only
reserves 8KB. This would work on 4K pagesize systems but on non-4K
pagesize (say 64K), this would fail, since it could overflow into the
SEQ64 region.

Hence the fix in this looks right to me. Although I am not an expert on
the amd gpu driver side, so I would let the experts review this as well.

But FWIW - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


> Kernel attempted to read user page (2) - exploit attempt? (uid: 1001)
> BUG: Kernel NULL pointer dereference on read at 0x00000002
> Faulting instruction address: 0xc0000000002c8a64
> Oops: Kernel access of bad area, sig: 11 [#1]
> LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
> CPU: 34 UID: 1001 PID: 9379 Comm: rocminfo Tainted: G E
> 6.19.0-rc4-amdgpu-00320-gf23176405700 #56 VOLUNTARY
> Tainted: [E]=UNSIGNED_MODULE
> Hardware name: IBM,9105-42A POWER10 (architected) 0x800200 0xf000006
> of:IBM,FW1060.30 (ML1060_896) hv:phyp pSeries
> NIP:  c0000000002c8a64 LR: c00000000125dbc8 CTR: c00000000125e730
> REGS: c0000001e0957580 TRAP: 0300 Tainted: G E
> MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE> CR: 24008268
> XER: 00000036
> CFAR: c00000000125dbc4 DAR: 0000000000000002 DSISR: 40000000
> IRQMASK: 1
> GPR00: c00000000125d908 c0000001e0957820 c0000000016e8100
> c00000013d814540
> GPR04: 0000000000000002 c00000013d814550 0000000000000045
> 0000000000000000
> GPR08: c00000013444d000 c00000013d814538 c00000013d814538
> 0000000084002268
> GPR12: c00000000125e730 c000007e2ffd5f00 ffffffffffffffff
> 0000000000020000
> GPR16: 0000000000000000 0000000000000002 c00000015f653000
> 0000000000000000
> GPR20: c000000138662400 c00000013d814540 0000000000000000
> c00000013d814500
> GPR24: 0000000000000000 0000000000000002 c0000001e0957888
> c0000001e0957878
> GPR28: c00000013d814548 0000000000000000 c00000013d814540
> c0000001e0957888
> NIP [c0000000002c8a64] __mutex_add_waiter+0x24/0xc0
> LR [c00000000125dbc8] __mutex_lock.constprop.0+0x318/0xd00
> Call Trace:
> 0xc0000001e0957890 (unreliable)
> __mutex_lock.constprop.0+0x58/0xd00
> amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x6fc/0xb60 [amdgpu]
> kfd_process_alloc_gpuvm+0x54/0x1f0 [amdgpu]
> kfd_process_device_init_cwsr_dgpu+0xa4/0x1a0 [amdgpu]
> kfd_process_device_init_vm+0xd8/0x2e0 [amdgpu]
> kfd_ioctl_acquire_vm+0xd0/0x130 [amdgpu]
> kfd_ioctl+0x514/0x670 [amdgpu]
> sys_ioctl+0x134/0x180
> system_call_exception+0x114/0x300
> system_call_vectored_common+0x15c/0x2ec
>
> This patch changes AMDGPU_VA_RESERVED_TRAP_SIZE to 2 * PAGE_SIZE,
> ensuring that the reserved trap area matches the allocation size
> across all page sizes.
>
> cc: stable@vger.kernel.org

Cc: makes sense. So that the older kernel versions would get this fix too!

> Fixes: 34a1de0f7935 ("drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole")
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 139642eacdd0..a5eae49f9471 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -173,7 +173,7 @@ struct amdgpu_bo_vm;
>  #define AMDGPU_VA_RESERVED_SEQ64_SIZE		(2ULL << 20)
>  #define AMDGPU_VA_RESERVED_SEQ64_START(adev)	(AMDGPU_VA_RESERVED_CSA_START(adev) \
>  						 - AMDGPU_VA_RESERVED_SEQ64_SIZE)
> -#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << 12)
> +#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << PAGE_SHIFT)
>  #define AMDGPU_VA_RESERVED_TRAP_START(adev)	(AMDGPU_VA_RESERVED_SEQ64_START(adev) \
>  						 - AMDGPU_VA_RESERVED_TRAP_SIZE)
>  #define AMDGPU_VA_RESERVED_BOTTOM		(1ULL << 16)
> -- 
> 2.52.0
