Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD13C8300E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 13:24:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D605E208C3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 13:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cyrd05+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D605E208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09E326E17E;
	Thu, 30 Apr 2020 13:24:23 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CD656E17E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 13:24:21 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id d17so6857704wrg.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 06:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hqaKoXkVv7gxLnS1g0OfMkIsznMFb4vVVZ0vB54IW5M=;
 b=Cyrd05+sm35OCpx9vUJbQ9yX7Dk3gOn0yA8n612ymVbkzq220bLoMvdh2qwQIWEf4l
 jNTuSYJ4DjMa7DcnOoxh9+HLSzej0fRPrAs8sisJ0yn6XJo7lbPMAtezYKLHHyUb207i
 4GjuMkNLxcXPvKK20AR8PoQYGs65Jr/smPaV11b7G/H4YxUP2C+ZLtQHWTDheINi3nh7
 G8+QP7oO4MjlnwWj/8GvCcoSVdPNFBold/XgFN9BDP23JiKzrqKR+Kk0Wg2SCeW3fEZH
 Zy0d8l0Dh0xzftt90ZP7AaxFVLjCt+jmzb8yLLfukurHqs4bAYqENE5v1Z2vYjg71bZA
 q9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hqaKoXkVv7gxLnS1g0OfMkIsznMFb4vVVZ0vB54IW5M=;
 b=k23eMQ4SMjJXJp6WV+Hx7H5gY0mGBaQeYFGFP1J4bzrFoPjmmobsOvaxHM9ayTUy1g
 EqVrdBgPv9ars4iBecHRkYexqho7bzUuVKvIK8WvCvr+aytm2x1T5tqdWuXITBtrgHQE
 uqTb7ZfClzr9TqDygG3nUV9XjKbTuHtzHM2aNBO2I8DQrCJvlLJWS7jTYvSsqo0sG+G6
 ktGeciIHWpMo7RBjZh4IiGfxKd8M/JgaequUbecYDet9oSIABfDRMAFsxLJqCN7kgfE4
 MzV1kw/JgkbMww9eibuEmU23OPj5Oailk/aph/Akj2FA4pDSCy7VrQQnwY0mI7nSDuhI
 orDA==
X-Gm-Message-State: AGi0PualNJUldLbkjPLIQQWakV4xoSH1d3qbLMiLWJKaf+0qsZjh4sw+
 grVFcR9T5U70mb1VHBHDSA5WcDg0fZOCzjnODDM+7w==
X-Google-Smtp-Source: APiQypIaBr5QVn3i/Q4FIg1Jlxhm0BWsVf5BsGyzAizGQEI/O4zuoF26IgqX7Xdtms6rKFdwaTj8lBtEagLDM/jxj50=
X-Received: by 2002:adf:cd8c:: with SMTP id q12mr4087342wrj.419.1588253060005; 
 Thu, 30 Apr 2020 06:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200430064331.23502-1-evan.quan@amd.com>
 <20200430064331.23502-3-evan.quan@amd.com>
In-Reply-To: <20200430064331.23502-3-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Apr 2020 09:24:08 -0400
Message-ID: <CADnq5_MCX+ys00ezni7Ly6tNVhg=twryKticrj6qdJcpvqU2mw@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd/powerplay: perform PG ungate prior to CG
 ungate
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Apr 30, 2020 at 2:44 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Since gfxoff should be disabled first before trying to access those
> GC registers.
>
> Change-Id: I5bf0fbe01fa05c89bbb392ef40e11c07edfee039
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 6 +++---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> index fdff3e1c5e95..96c91bb70df5 100644
> --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> @@ -322,12 +322,12 @@ static void pp_dpm_en_umd_pstate(struct pp_hwmgr  *hwmgr,
>                 if (*level & profile_mode_mask) {
>                         hwmgr->saved_dpm_level = hwmgr->dpm_level;
>                         hwmgr->en_umd_pstate = true;
> -                       amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
> -                                               AMD_IP_BLOCK_TYPE_GFX,
> -                                               AMD_CG_STATE_UNGATE);
>                         amdgpu_device_ip_set_powergating_state(hwmgr->adev,
>                                         AMD_IP_BLOCK_TYPE_GFX,
>                                         AMD_PG_STATE_UNGATE);
> +                       amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
> +                                               AMD_IP_BLOCK_TYPE_GFX,
> +                                               AMD_CG_STATE_UNGATE);
>                 }
>         } else {
>                 /* exit umd pstate, restore level, enable gfx cg*/
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 12810fd81d5d..e6252bcaa641 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1780,12 +1780,12 @@ static int smu_enable_umd_pstate(void *handle,
>                 if (*level & profile_mode_mask) {
>                         smu_dpm_ctx->saved_dpm_level = smu_dpm_ctx->dpm_level;
>                         smu_dpm_ctx->enable_umd_pstate = true;
> -                       amdgpu_device_ip_set_clockgating_state(smu->adev,
> -                                                              AMD_IP_BLOCK_TYPE_GFX,
> -                                                              AMD_CG_STATE_UNGATE);
>                         amdgpu_device_ip_set_powergating_state(smu->adev,
>                                                                AMD_IP_BLOCK_TYPE_GFX,
>                                                                AMD_PG_STATE_UNGATE);
> +                       amdgpu_device_ip_set_clockgating_state(smu->adev,
> +                                                              AMD_IP_BLOCK_TYPE_GFX,
> +                                                              AMD_CG_STATE_UNGATE);
>                 }
>         } else {
>                 /* exit umd pstate, restore level, enable gfx cg*/
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
