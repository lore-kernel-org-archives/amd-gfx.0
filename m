Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103EFC433E4
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 13:17:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D438520656
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 13:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fogiYOJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D438520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CBC86E971;
	Fri, 24 Jul 2020 13:17:33 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D1376E971
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 13:17:31 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id f18so8253731wml.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 06:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A970wSbMkPdQ0xw7/yi8Bhy3ensOyh7aM/PYRJhKPzQ=;
 b=fogiYOJNpd3GfgttdfjgLtakux5c25NU4JFx2VLk6OZ8D3lFtJ+vuvriMOMRankNnw
 E82p45CaB57/EgjNb6NvA/GgETyeXohIc8R2ynYbDSx3bD2JBvBN7Md1JkZzsjiE/YJs
 VoJLTw9+htuwIz1CHBczed60WMY36jKsvA1jsj99Yqo5SpZndzxTfacbj5/iHVhfQ/17
 CXphjcmAnv3CsX+r3m7IfN9gIlWKgL4lPu69HAqDWDVCH1zhWl3slPNGego5Z+hOL2hk
 fUA07cSNwlePYz/B3Ewc+dQ5IUtx4a0LRSKmEyGn7BhROKZITMby7ZSqCFqebPTB4Z/V
 ksuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A970wSbMkPdQ0xw7/yi8Bhy3ensOyh7aM/PYRJhKPzQ=;
 b=NdxjrDxdBHGPyl+Rzdg79JNr8YyqNhTESoWqrJxsz50kaBhlY8U0Od2p56KTS47Qse
 NJKgcAjJ7t6HXdnIjdWNGCF+ua/jfimG0NN+nb+dTVLjyXY3i+YWopwm3a/xGVZRphnm
 2MlzkEQWFyrCg5dDm0le9FHYe4GCMSCCzonWkOfILJf6oUBOsArJRipvSKROZtqdKfJZ
 U2Mq57YpoIRmtbUReEUNR+missJk6DT7T6cHO8MfibrbFH8qCnWM6o/HIG7zUzfvNN0H
 frCwfjcdIgIEXv9u/8vd7HV9GYsnU8QuzePEMJuXIggS/5pxSMAoYi7jJKsRlP6Dzd+h
 0SKw==
X-Gm-Message-State: AOAM533ePLqHMKf5N4ZN5lt0DK00Ou4MMj8BKxpxGPHL3jQu5c+oyEmb
 1VOBg3u3ha82mBRYwo+bSLf84N6b5UNpk6KS37BFtg==
X-Google-Smtp-Source: ABdhPJxBtGWcPLPedmaRoyQE4vbBWi/bxW7g/kBBbS7CGWOhJZdObXIY7FNl4AoqVKa3BeYJfb7WshZUDTcoa8G01II=
X-Received: by 2002:a7b:c05a:: with SMTP id u26mr8720392wmc.73.1595596650056; 
 Fri, 24 Jul 2020 06:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200714072703.4122-1-evan.quan@amd.com>
 <DM6PR12MB26194D468B2F6CD43C2C0866E4770@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26194D468B2F6CD43C2C0866E4770@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 24 Jul 2020 09:17:18 -0400
Message-ID: <CADnq5_N8TTFOJCymW8aKgOMbjtHBZf08eaFDkryPjy354AT7MA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: revise the outputs layout of
 amdgpu_pm_info debugfs
To: "Quan, Evan" <Evan.Quan@amd.com>
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
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jul 24, 2020 at 4:43 AM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Ping..

Whoops, missed this one.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Tuesday, July 14, 2020 3:27 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> Subject: [PATCH] drm/amd/powerplay: revise the outputs layout of amdgpu_pm_info debugfs
>
> The current outputs of amdgpu_pm_info debugfs come with clock gating
> status and followed by current clock/power information. However the
> clock gating status retrieving may pull GFX out of CG status. That
> will make the succeeding clock/power information retrieving inaccurate.
>
> To overcome this and be with minimum impact, the outputs are updated
> to show current clock/power information first.
>
> Change-Id: Iff762d47ef0cc9ed309e805b1709ec8cb293d21f
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index 20f39aa04fb9..2d379c00c138 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -3879,11 +3879,6 @@ static int amdgpu_debugfs_pm_info(struct seq_file *m, void *data)
>  return r;
>  }
>
> -amdgpu_device_ip_get_clockgating_state(adev, &flags);
> -seq_printf(m, "Clock Gating Flags Mask: 0x%x\n", flags);
> -amdgpu_parse_cg_state(m, flags);
> -seq_printf(m, "\n");
> -
>  if (!adev->pm.dpm_enabled) {
>  seq_printf(m, "dpm not enabled\n");
>  pm_runtime_mark_last_busy(dev->dev);
> @@ -3903,7 +3898,15 @@ static int amdgpu_debugfs_pm_info(struct seq_file *m, void *data)
>  } else {
>  r = amdgpu_debugfs_pm_info_pp(m, adev);
>  }
> +if (r)
> +goto out;
> +
> +amdgpu_device_ip_get_clockgating_state(adev, &flags);
> +seq_printf(m, "Clock Gating Flags Mask: 0x%x\n", flags);
> +amdgpu_parse_cg_state(m, flags);
> +seq_printf(m, "\n");
>
> +out:
>  pm_runtime_mark_last_busy(dev->dev);
>  pm_runtime_put_autosuspend(dev->dev);
>
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
