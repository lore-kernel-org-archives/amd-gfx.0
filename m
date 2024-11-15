Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C87D6DDF5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2024 12:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91FAC10E2CC;
	Fri, 15 Nov 2024 12:27:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V6mpgfDq";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57DCF10E2CC
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 12:27:14 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-432d9b8558aso10904015e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 04:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731673632; x=1732278432; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m5QLXQvq6nhHi/EsWScT0P21AyTD6RK+eCq14Hd1bIw=;
 b=V6mpgfDqxSAsRNzsswWWxv0lzcyBACfrBL2VScJrsg2RFCHnBsb4XCdacmhpV4IiKF
 HSW7yPehpFPvYYkCjKEj5/TtJ3CP9Tv2HpV8mnBKTOk/oCGba9v5Jgrd5TIgkNR3i5ai
 AlWYPCmGjx7c2apZ1+yo2Lv5Kg8/+wx9UEMOyzq4eks3vYA84UG4tm4sBbh/fX2ZpVH4
 XG7+dfqOUH9qseFlP/ydHf8kM4kX81h3rO8LKbaY/lFlqLzhfzX/Xkag7rZFk8sSMLxQ
 tYhMT+ynV7BLtW75GHonR3HW7L6O2Wyuu2FmvzdEZ28kWgtE7SYzQh+CN2qwlA+CX4W2
 qKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731673632; x=1732278432;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m5QLXQvq6nhHi/EsWScT0P21AyTD6RK+eCq14Hd1bIw=;
 b=jvbYu6DlWeIvpvQ8FpZVakCnRFXfye8wwdefsqOPNRCDP0NZcpqa0t7EV+t0O9bQyY
 eyR478vu8pnpd+GbXtw1pkZmilkabptjsgY7zhn8BIPfr0XcbTstu0FdtpP4dDWTyMgZ
 YH95Eazwxcm8PMhgog44qUYj3GK2S92RIDbbLam+AIxvv0mFMJldpiYFD/Jg5gyWjfFl
 SQ/8yIwyGY/9WdgnbY+UB8CREFPEvZKSnpLne0hHD3UTeE5feMO51GGOEGC5UR1n2H2z
 x3o0VCxlw1OmLwEzuRDkCYoRYmMsmroSHBm678aiFutCarpzN+Lx8pbOtmHHH5kHve7S
 vZDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgdpKZ+GcbilOv/OVYJMwPpMNa3Kxa97zbleZo/8HA2SmAP2yweYjZkVPqJ5dj7VRLVzbJJ3no@lists.freedesktop.org
X-Gm-Message-State: AOJu0YybHbnGRykp1YZ5M0RcChMbIotAJtcSWaOkBv0nUYUNkJmR6wta
 s7Z+DRKvWrssHZIrFyGjYH1cLwUBgGbjPUP7ktkgLDl7z4BkQ1Dy
X-Google-Smtp-Source: AGHT+IE59+yg5wduWxvHFQQPMeG5isGCOte6qYcQ9oKW/TSGpSas4onUICvhZQDb9jFFTVeEqvqGcg==
X-Received: by 2002:a05:600c:4f0b:b0:42c:b826:a26c with SMTP id
 5b1f17b1804b1-432d974b2admr64245695e9.8.1731673632286; 
 Fri, 15 Nov 2024 04:27:12 -0800 (PST)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac216a4sm52353155e9.44.2024.11.15.04.27.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 04:27:11 -0800 (PST)
Message-ID: <042c36ba-3a94-4d72-b2f1-5145d8fc623f@gmail.com>
Date: Fri, 15 Nov 2024 13:27:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] drm/amdgpu/vcn: update work handler for per
 instance powergating
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241113214453.17081-1-alexander.deucher@amd.com>
 <20241113214453.17081-16-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20241113214453.17081-16-alexander.deucher@amd.com>
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

Am 13.11.24 um 22:44 schrieb Alex Deucher:
> Only gate/ungate the relevant instances.

That won't work, that is the whole problem why we started this series in 
the first place.

Regards,
Christian.

>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 3383e4146c6a..24e9a3126763 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -418,8 +418,8 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   	fences += fence[i];
>   
>   	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
> -		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> -						       AMD_PG_STATE_GATE);
> +		amdgpu_device_ip_set_powergating_state_inst(adev, AMD_IP_BLOCK_TYPE_VCN,
> +							    AMD_PG_STATE_GATE, i);
>   		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>   						    false);
>   		if (r)
> @@ -444,8 +444,8 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   	}
>   
>   	mutex_lock(&adev->vcn.inst[ring->me].vcn_pg_lock);
> -	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> -					       AMD_PG_STATE_UNGATE);
> +	amdgpu_device_ip_set_powergating_state_inst(adev, AMD_IP_BLOCK_TYPE_VCN,
> +						    AMD_PG_STATE_UNGATE, ring->me);
>   
>   	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&

