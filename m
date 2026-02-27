Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70655FD530E
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 09:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEA8510EA67;
	Fri, 27 Feb 2026 09:05:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="I9xZwIky";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2739110EA67
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 09:05:07 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4837f27cf2dso15377985e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 01:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1772183106; x=1772787906; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cZ22dQ880Yi0qwpC2jMnRRJGOCpn/SG0FBlt3qYJsYc=;
 b=I9xZwIkyofS0iffLKqRCD3Es9+byrn3RvjcLgr30IAzjYLvCsZpgmPB1t0KLS+Y3v0
 tawSiduwruhWDO1+xWrqcVbBFL+FLTY8XMBWxZxw71kv1GWJ4hb9OqWnDmIs/A4eWVE8
 z5/r218OLcNq9O56amE/8101rLCrswDVqOi34axT+8wuNLqHhOW7FH5GJteFGxLaC8Ha
 8S8KvpZETdTJDRwXML993wdDCaGRxvG57XdsNgFMn3Bc3Xor8thQNLXYQuOhhR8sYB0/
 edOiwK9MbpiFmaSafXaKYdluIlcEQTp7BlsWX6FEp3yVND/jJyjn18GCDYpdhmbCqujA
 k45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772183106; x=1772787906;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cZ22dQ880Yi0qwpC2jMnRRJGOCpn/SG0FBlt3qYJsYc=;
 b=fzNwLbvlUNNDMoEpL76tC+7vYJXUMZo/ZLwbpf8TCWmJDmwXf9+7wyFKeumZpFnnB5
 fL9FClJUyRd3v9wQXytKBgS+Wt1NfNdApEZs81yCljAOrc8VhoDiSMGJ3aHK6FV6gIwq
 DApcv996/LkhaFRhbdeuGUwh/FwF32xwMmQd2WElsb+RsQPAp3tMeirdTPoxqLNj4a0z
 WzxuumtCeFKNlw2ux4QE1Z0CuLPLH6vaZHkrWXaOwFKmQKKUqv88p3Z/BGqeQZhbni8q
 RdI6WTzG0IxuZYyxL+m0yZSPVX2FGZIO8wIyw9R3AM8zcKhXa2x1EGRBAK2nQ2smhwuI
 9pKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVphQMZoQLjLBMj9Q2DoYv//ZbuSwTtl5jdDWMmAr4yRNjS5MHmHd/8TonlCs7Jyzi0q7n1cxKk@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzsA0LggxD/bN8EnaP94kS6t66FJlz5BkD0LD9FYVLmzSyBATF4
 8FZU+kMmfki4rCAA6DdFt0l/2nio2HrnKWCRCwPqvp5EYJgOWXIlq6PwZ0jRlskihznqeYF1Ckw
 bhTncBgE=
X-Gm-Gg: ATEYQzzZ31UQej+Arn0PKYzibdYboRREXktzUMntsw2KDobQT4Omzyeh3CsfCdEJwap
 r7nj4+gnbBKX++fjhFwo1MK33RVnsCUR0MpfcXqLdrXO6xbkWA/KsSq6XSm7Q7a2J3EEwHqygCg
 F/hmlQrDQ3sa90yjSrxT3Ab34XWcckk+QBK6K11vdeDDGP6tTUrVSOu1gSfe5Qn04y3VOE0JIrT
 Bn7lomSmv3LgSxDLUyhFv9Vq9tJyqLHuUuYyyPz1Kwf1AyyevBR9UNW3A5kZSaeMnTSnzk2XOjt
 9vcDF2GiA4AW9G5qZdgmA3qvTwGqUcscwr1RLuz0EX35C4Iv6rRBU5QpbphGk6bMcQtCE0tlACV
 oMPqVvWs/Arh4BNacSSj7eFWaFOTteOjnGtBQAEdDPw2BpPvqSEUFGwwJwz4hpQpqlyaAgeGEBH
 sflyjm1c5+04fI3HqvAWXPYBwwQHRttkFZlf3EZ49AE6Kh
X-Received: by 2002:a05:600c:348a:b0:483:c35d:3659 with SMTP id
 5b1f17b1804b1-483c9c1ba8cmr26744075e9.18.1772183105124; 
 Fri, 27 Feb 2026 01:05:05 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb296bfsm72184545e9.0.2026.02.27.01.05.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 01:05:04 -0800 (PST)
Message-ID: <711f9a67-0323-47c5-a59a-81705af16d9e@ursulin.net>
Date: Fri, 27 Feb 2026 09:05:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix null pointer access in
 amdgpu_userq_signal_ioctl
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20260227085110.2865415-1-Jesse.Zhang@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260227085110.2865415-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 27/02/2026 08:50, Jesse.Zhang wrote:
> The amdgpu_userq_signal_ioctl function was triggering kernel page faults
> due to missing null pointer checks when accessing gobj_read/gobj_write
> arrays, and improper handling of memory allocation for these arrays.
> 
> The crash stack showed the failure originated from the ioctl path:
> [   64.977695] Call Trace:
> [   64.977696]  <TASK>
> [   64.977700]  amdgpu_userq_signal_ioctl+0x8e4/0xda0 [amdgpu]
> [   64.977830]  ? tty_ldisc_deref+0x1a/0x20
> [   64.977834]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
> [   64.977934]  drm_ioctl_kernel+0xab/0x110 [drm]
> [   64.977955]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
> [   64.978071]  drm_ioctl+0x2cb/0x5a0 [drm]
> [   64.978088]  ? ttm_bo_vm_fault_reserved+0x1ef/0x410 [ttm]
> [   64.978093]  amdgpu_drm_ioctl+0x4f/0x90 [amdgpu]
> [   64.978179]  __x64_sys_ioctl+0x9e/0xf0
> [   64.978182]  x64_sys_call+0x1274/0x2190
> [   64.978185]  do_syscall_64+0x74/0x950
> [   64.978189]  ? ___pte_offset_map+0x20/0x170
> [   64.978191]  ? __handle_mm_fault+0x986/0xfb0
> [   64.978194]  ? count_memcg_events+0xe7/0x1e0
> [   64.978197]  ? handle_mm_fault+0x1cc/0x2b0
> [   64.978199]  ? do_user_addr_fault+0x394/0x8a0
> [   64.978202]  ? irqentry_exit_to_user_mode+0x2a/0x1e0
> [   64.978205]  ? irqentry_exit+0x3f/0x50
> [   64.978206]  ? exc_page_fault+0x97/0x190
> [   64.978208]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   64.978210] RIP: 0033:0x7f3c08b24ded
> 
> Fixes: fd4fde1df18b ("drm/amdgpu/userq: Use drm_gem_objects_lookup in amdgpu_userq_signal_ioctl")

It is best practice to Cc the target commit author. ;)

> 
> V2: initialize gobj_write
> 
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 22 +++++++++++++------
>   1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 3c30512a6266..af934374df94 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -467,7 +467,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   	const unsigned int num_read_bo_handles = args->num_bo_read_handles;
>   	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>   	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
> -	struct drm_gem_object **gobj_write, **gobj_read;
> +	struct drm_gem_object **gobj_write = NULL, **gobj_read = NULL;
>   	u32 *syncobj_handles, num_syncobj_handles;
>   	struct amdgpu_userq_fence *userq_fence;
>   	struct amdgpu_usermode_queue *queue;
> @@ -597,13 +597,21 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   exec_fini:
>   	drm_exec_fini(&exec);
>   put_gobj_write:
> -	for (i = 0; i < num_write_bo_handles; i++)
> -		drm_gem_object_put(gobj_write[i]);
> -	kfree(gobj_write);
> +	for (i = 0; i < num_write_bo_handles; i++) {
> +		if (gobj_write)

I don't see a path go get here with gobj_write (or gobj_read) NULL. If 
number of handles is greater than zero drm_gem_objects_lookup() either 
fails or returns a valid pointer. What am I missing? What branch hit 
this? Before fixed drm_gem_objects_lookup() was cherry picked to 
amd-staging-drm-next?

> +			drm_gem_object_put(gobj_write[i]);
> +	}
> +
> +	if (gobj_write)
> +		kfree(gobj_write);

kfree() definitely handles NULL just fine.

Regards,

Tvrtko

>   put_gobj_read:
> -	for (i = 0; i < num_read_bo_handles; i++)
> -		drm_gem_object_put(gobj_read[i]);
> -	kfree(gobj_read);
> +	for (i = 0; i < num_read_bo_handles; i++) {
> +		if (gobj_read)
> +			drm_gem_object_put(gobj_read[i]);
> +	}
> +
> +	if (gobj_read)
> +		kfree(gobj_read);
>   free_syncobj:
>   	while (entry-- > 0)
>   		if (syncobj[entry])

