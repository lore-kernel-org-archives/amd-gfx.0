Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02C0CCD1A5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Oct 2025 07:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33AF010E56D;
	Tue, 21 Oct 2025 07:12:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="CkW4yjCX";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DE6110E52B
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 21:56:29 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-7a213c3c3f5so6270169b3a.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 14:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kerneltoast.com; s=google; t=1760997389; x=1761602189;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2MPYfq+Hg3zmBZGsNDyo6AU6sZdCHwwooncAejTQuIo=;
 b=CkW4yjCXDiyJjFYzGd3oVe6pYyrnzFI12Vlh2kouADn24+s5USCDkz/SAnyM8/Fc4H
 0CVZjBf3UtdsBkk3RAWtIv7CW11oMl1sPfnj5h9O3RKwpRZjSFoZQhPLuUZx1ZSlmQRM
 oicdPmY0xkbTKEtBFnFsn8PC6wFleZHq3ySjoO9gUZARsQ0oMMVLJLBTO2tNYuVOUmNz
 MMAWk7tjOPelhD8rf/7FyyoEyCACCeDP2ft092zgTQMYLurKPSGAUdxUlSlPVY8lquh/
 wTdtlENNhdERxRRUQv0ZzhiwE1EeDVWLf03zKub4+Koy1yzA9N3YPCvyIH6xHmGNZRxq
 qWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760997389; x=1761602189;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2MPYfq+Hg3zmBZGsNDyo6AU6sZdCHwwooncAejTQuIo=;
 b=PK31nZvUAp7iRLPzHpOjS0BIjX+ahZRQfVB2IBvJJi9UuEy1kSt1iRFPiXpk9CCr9C
 2qAvMChIfaZnmEy65t0FqSGQ+na7TFkigebHd8yYhgmIXU9rmI9bFkkZE3IULObUO690
 QyLazD8z3R8I9+K6b7gORzF7IE1BCeyOfOpbGf1rp7W9kag48TucvPIwNYU70357QY+6
 UJY8wCiJjf0kVQ8Et+g1q5/XUbSYFSgnNFDSAdw5c2QMvKN3rVgbtz4P4P+jQQaARXc3
 GnoUR16NmUBbe5nZ9tg5pYI/1jqJTB2736Y1FSu0pbS5R9yiZcGrNIo8cZtYW1qTa8SP
 yCkw==
X-Gm-Message-State: AOJu0YyAe78oLmW7M6Z6R4EZQ9go3duGdHlNW3cZQPdykrmI8/H8HE1R
 6ee+smrASZlLXjXMptbDHrajFsVyev6MM8jajUY8CoGWfB8StL9S+Mi8tnbv05TpJUrq
X-Gm-Gg: ASbGnctWbkL27kiyhoMg9cV+KNSiHHq7iF078cM9deqx8ZH/1aE7FvDWghBebiF1dHs
 QhjkzLZbu3Lj2SGpf92sx2v9QFgNzoHPivfjkrwq4AkiuFTdUcF82et5F04JjhqxO6dOhKyvN7W
 mZ2cCjsuoPVmPAUeYr/X073qEVHiYhFDN+NYryTdQlDPE85zkwtEIPnZTGTkPvkjIDR8lxjrVqI
 dyaYjm5ZTpvSDFnhsl1LLe57sps09h8tN5/G+GkeZy2ewGK6QAHgsWAsbxZ3cCjrph+rgNBGr+l
 QRxmMWejz300tyLR0k8CeSfOlnMiRI995hsZATd6vYCeTZ5dt+Ot4PcvqvvXZG4FLmLlxGoe+fv
 5C7zdV/cCn9vRMzYV2KjW3naX1qMAHFlT7wg31KU1BX6Y08ElFQlk/yVA6ka8BC7QAkzvxan68Y
 YpdzQ8Xg==
X-Google-Smtp-Source: AGHT+IGYhgFEJVyYrVIrv8FzKLtDLnPxGj5Ld2jqh3Md7ZU06dvyWTnskQv3oLnORLl3jh+q8ZlIGA==
X-Received: by 2002:a05:6a20:2590:b0:2f1:302d:1285 with SMTP id
 adf61e73a8af0-334a84cf1eemr20491860637.17.1760997388761; 
 Mon, 20 Oct 2025 14:56:28 -0700 (PDT)
Received: from sultan-box ([2607:fb90:a581:dbd:7adf:1ae2:91ed:6c74])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a2300f24fasm9277744b3a.42.2025.10.20.14.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 14:56:28 -0700 (PDT)
Date: Mon, 20 Oct 2025 14:56:25 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Peyton.Lee@amd.com
Subject: Re: [PATCH v5] drm/amd: Check that VPE has reached DPM0 in idle
 handler
Message-ID: <aPawCXBY9eM8oZvG@sultan-box>
References: <20251016185527.1796606-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016185527.1796606-1-mario.limonciello@amd.com>
X-Mailman-Approved-At: Tue, 21 Oct 2025 07:12:08 +0000
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

On Thu, Oct 16, 2025 at 01:55:27PM -0500, Mario Limonciello wrote:
> [Why]
> Newer VPE microcode has functionality that will decrease DPM level
> only when a workload has run for 2 or more seconds.  If VPE is turned
> off before this DPM decrease and the PMFW doesn't reset it when
> power gating VPE, the SOC can get stuck with a higher DPM level.
> 
> This can happen from amdgpu's ring buffer test because it's a short
> quick workload for VPE and VPE is turned off after 1s.
> 
> [How]
> In idle handler besides checking fences are drained check PMFW version
> to determine if it will reset DPM when power gating VPE.  If PMFW will
> not do this, then check VPE DPM level. If it is not DPM0 reschedule
> delayed work again until it is.
> 
> Cc: Peyton.Lee@amd.com
> Reported-by: Sultan Alsawaf <sultan@kerneltoast.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4615
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 33 ++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> index 474bfe36c0c2..f4932339d79d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -322,6 +322,26 @@ static int vpe_early_init(struct amdgpu_ip_block *ip_block)
>  	return 0;
>  }
>  
> +static bool vpe_need_dpm0_at_power_down(struct amdgpu_device *adev)
> +{
> +	switch (amdgpu_ip_version(adev, VPE_HWIP, 0)) {
> +	case IP_VERSION(6, 1, 1):
> +		return adev->pm.fw_version < 0x0a640500;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static int vpe_get_dpm_level(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_vpe *vpe = &adev->vpe;
> +
> +	if (!adev->pm.dpm_enabled)
> +		return 0;
> +
> +	return RREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.dpm_request_lv));
> +}
> +
>  static void vpe_idle_work_handler(struct work_struct *work)
>  {
>  	struct amdgpu_device *adev =
> @@ -329,11 +349,16 @@ static void vpe_idle_work_handler(struct work_struct *work)
>  	unsigned int fences = 0;
>  
>  	fences += amdgpu_fence_count_emitted(&adev->vpe.ring);
> +	if (fences)
> +		goto reschedule;
>  
> -	if (fences == 0)
> -		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
> -	else
> -		schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
> +	if (vpe_need_dpm0_at_power_down(adev) && vpe_get_dpm_level(adev) != 0)
> +		goto reschedule;
> +
> +	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
> +

Wait a second, there's no return here! My laptop kept getting kicked out of
S0i3 as a result when I'd suspend it, and I found my laptop cooking in my
backpack with its battery mostly drained. :-(

> +reschedule:
> +	schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
>  }
>  
>  static int vpe_common_init(struct amdgpu_vpe *vpe)
> -- 
> 2.51.0
> 

Sultan
