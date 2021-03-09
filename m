Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0B9C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 04:07:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA9EB6527D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 04:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9EB6527D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72B2D89F71;
	Tue,  9 Mar 2021 04:07:24 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 654A789F71
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 04:07:23 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id f8so6524050otp.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Mar 2021 20:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=svnYZs7DsS/z4G0aPlCD5RMBtRd5iKkPd+//7Ims+Hw=;
 b=fKOasdKhcHvlEGbyCK3fXwo+OhVf+pZBZWrDZd+aP40bhLKz3wFtiN3QxvYqrORx3q
 AB72LIL7SaaOy36A96jP01xAM0Tiq3p7YoGDLeB2gBov3rbRAUUKUBi+dPHC0QlGb8oG
 zGfS9pu2v8hre9tczcSlrYMt3BaUL1eUf5tGadQL2JTAwkKnPFx2pptJgNol479fCpVx
 BeKNv1aSBEJpGGIbTmzQzORY22pSsNK87rSwbbpynZ3HPwMfdrtxf7Gqe4LQrpH3YtNs
 OVJwxTTkHHA6L4a8LXe3jcyQSzENyADRd+K+CDG3QuGaDsWhvqAh1IGrrGZjmYysDsQ8
 1tSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=svnYZs7DsS/z4G0aPlCD5RMBtRd5iKkPd+//7Ims+Hw=;
 b=FCFu0wPK1cC6y9ggizwiRH9iFwuM2XEx8xvwPmUd+j35zgX7UZwOSaZj+I8upz3wl1
 /AePNVqtcf9HRxM16j3xMGiBpSvUzl0dLtMtY3Us6aPOXzuUBWhymamRmrEdh37viUAB
 nRWY1qQr+YzgawyYox3OPOJZKxe1v5OU9dV5CO/u2QCtBaXfQsTPspwhlImnplBd1+Ov
 4ZQs2L9H9eVb0d1bwMN7f3WJOr9mPQMI1cVkQliS9XZNe261suF3cFTLpEaVZdL1l8kK
 2lNsFEq3iZ/llnVdROPoRLXspYOjDdOGebNzAqnVJsA5bsgnPcLTWYrJ7v2gp6Q42vTg
 J0uw==
X-Gm-Message-State: AOAM530MHX0tIUUH8+7GyK8oNYsbp9L2OHU1xjDwWR8F7/SPIauJmlDG
 ErlnGeoFLPg1iWShxjK8Cn67oyp5B4H3VkSGjgE=
X-Google-Smtp-Source: ABdhPJzR3XaShPCkn/v9o068oiwSfgDSBcWImDSoA5bOcIvYwh61vpUhCink2ZoEi4QBTUlgPu6wNoIg5HTM0EkvsIk=
X-Received: by 2002:a9d:760a:: with SMTP id k10mr22789278otl.23.1615262842726; 
 Mon, 08 Mar 2021 20:07:22 -0800 (PST)
MIME-Version: 1.0
References: <1615261905-10482-1-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1615261905-10482-1-git-send-email-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Mar 2021 23:07:11 -0500
Message-ID: <CADnq5_MWkxBLBX-U0rv7NMSX-vmt+2aKO1dNYDTv2sVhyx6bzg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix the hibernation suspend with s0ix
To: Prike Liang <Prike.Liang@amd.com>
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
 Huang Rui <ray.huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 8, 2021 at 10:52 PM Prike Liang <Prike.Liang@amd.com> wrote:
>
> During system hibernation suspend still need un-gate gfx CG/PG firstly to handle HW
> status check before HW resource destory.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

This is fine for stable, but we should work on cleaning this up.  I
have a patch set to improve this, but it's more invasive.  We really
need to sort out what specific parts of
amdgpu_device_ip_suspend_phase2() are problematic and special case
them.  We shouldn't just be skipping that function.

Acked-by: Alex Deucher <alexander.deucher@amd.com>

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e247c3a..7079bfc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2683,7 +2683,7 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
>  {
>         int i, r;
>
> -       if (adev->in_poweroff_reboot_com ||
> +       if (adev->in_poweroff_reboot_com || adev->in_hibernate ||
>             !amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev)) {
>                 amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>                 amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> @@ -3750,7 +3750,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>
>         amdgpu_fence_driver_suspend(adev);
>
> -       if (adev->in_poweroff_reboot_com ||
> +       if (adev->in_poweroff_reboot_com || adev->in_hibernate ||
>             !amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev))
>                 r = amdgpu_device_ip_suspend_phase2(adev);
>         else
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
