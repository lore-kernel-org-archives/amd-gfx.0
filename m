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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59726C8300A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 13:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DCC52082E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 13:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qA+PMiz8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DCC52082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECE776E890;
	Thu, 30 Apr 2020 13:13:04 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DAF96E890;
 Thu, 30 Apr 2020 13:13:04 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id g12so1838725wmh.3;
 Thu, 30 Apr 2020 06:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=N8o0WCkgmNcRVLVFgbGXJgHA8SmIuPpmu2c2tbvo+tw=;
 b=qA+PMiz8eAXBGH9BURIrD/1CrZpiAUC83W+MjER4hnqkuSfCzux0bA14WLnqH4D2Vt
 +zE0BWwQd6sqQGTHQ+M0MUU2oC2O7Ww1ywFxfqDsGtJgooVYxl4hvYUoV07WlaaSJukw
 Ex3+6dwRoq9OAOadSJ9TV8uwaglubeHUtzrvSWfq1mCHktlBxuFiUYvaPESZ2pnnQLaG
 bpMlH6fw3qUfaFl9wyLfc4OA7CLeKu3ddGPKdY1LZ+fuo71rY6E8beOIHxMknJCAsG9j
 vjJagusyKaqs2acIAjPFrCwXDzUAiXOfdBxdNNKBVW2bVxl3hdi/3NEyptJbcHxmQp1S
 QSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=N8o0WCkgmNcRVLVFgbGXJgHA8SmIuPpmu2c2tbvo+tw=;
 b=fX4mpGdCEhfwVilaq20IbI352+dHG3UrSShJr0qGJhXUAbyb45HrflaOTuno4Snxic
 vwahdioB6tl/RuagKCUABEIoYv3hRjTrJOFSfyP179eu+I4gHoCuo8mgGwwq0/3oUvMf
 3cBrG6y+mVqHkgLtGX9YgoHH1TISSIa61znHrWyV+mdXok9+yhkH6m0nLmsAwkJgB7K4
 BZckY0OBadEbeAmYgzMeqkTAclpYxzYFcTwbOFMBBHS+Tv6eGsXi/KIIq1rVonmD/Cot
 ldK8x8FGV8yDSkmTMSkNrW13COsu+d+kVwC++6Kglrf9e4j8mxUGkc3/lJxj0QuVgZF6
 /s0w==
X-Gm-Message-State: AGi0PuZwYH4juB/Sa++w3pZwJaVkCqANFo4oSrX9VnlcNGYfe7//XGhk
 mp1qOYA9iOfxaD872j6Ab4f6dXcrWOFYRCO7jWPldA==
X-Google-Smtp-Source: APiQypLRoWdeYknVupE+6N8yAi1xDxWATm+stncb9njAtDCMiRIWkFBmlcq9r4s+xdnKcd1PEPCOx2mPQcXe0iWsqp8=
X-Received: by 2002:a7b:cc8e:: with SMTP id p14mr2914876wma.70.1588252383121; 
 Thu, 30 Apr 2020 06:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200430085318.114894-1-jian-hong@endlessm.com>
In-Reply-To: <20200430085318.114894-1-jian-hong@endlessm.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Apr 2020 09:12:51 -0400
Message-ID: <CADnq5_MjWEj6UwNZnuz=s+w=Hru7Gyzn8_rWAEDMH16MQZOiDg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: drm/amdgpu: Disable [1002:6611] in radeon
To: Jian-Hong Pan <jian-hong@endlessm.com>
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
Cc: Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 David Zhou <David1.Zhou@amd.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@linux.ie>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
 "Tianci . Yin" <tianci.yin@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Linux Upstreaming Team <linux@endlessm.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Apr 30, 2020 at 9:08 AM Jian-Hong Pan <jian-hong@endlessm.com> wrote:
>
> The AMD/ATI Oland [1002:6611]'s HDMI output status is not synchronous
> as shown on UI after hot re-plug the HDMI cable, if it is radeon in
> used. The amdgpu module does not hit this issue.
>
> This patch disables [1002:6611] in radeon and enables it in amdgpu.
>
> Fixes: https://gitlab.freedesktop.org/drm/amd/-/issues/1117
> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>

Nack.  Amdgpu does not have support for VCE or UVD yet so you are just
trading one issue for another.  It would be better to figure out why
the audio is not updated properly in some cases.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 11 +++++++++++
>  include/drm/drm_pciids.h                |  1 -
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 8ea86ffdea0d..1ad6f13a5bc0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1017,6 +1017,15 @@ MODULE_DEVICE_TABLE(pci, pciidlist);
>
>  static struct drm_driver kms_driver;
>
> +static void amdgpu_pci_fixup(struct pci_dev *pdev)
> +{
> +#ifdef CONFIG_DRM_AMDGPU_SI
> +       /* [1002:6611] is disabled in radeon, so enable si_support in amdgpu. */
> +       if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x6611)
> +               amdgpu_si_support = 1;
> +#endif
> +}
> +
>  static int amdgpu_pci_probe(struct pci_dev *pdev,
>                             const struct pci_device_id *ent)
>  {
> @@ -1036,6 +1045,8 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>                 return -ENODEV;
>         }
>
> +       amdgpu_pci_fixup(pdev);
> +
>  #ifdef CONFIG_DRM_AMDGPU_SI
>         if (!amdgpu_si_support) {
>                 switch (flags & AMD_ASIC_MASK) {
> diff --git a/include/drm/drm_pciids.h b/include/drm/drm_pciids.h
> index b7e899ce44f0..57368a0f5b82 100644
> --- a/include/drm/drm_pciids.h
> +++ b/include/drm/drm_pciids.h
> @@ -171,7 +171,6 @@
>         {0x1002, 0x6607, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_OLAND|RADEON_IS_MOBILITY|RADEON_NEW_MEMMAP}, \
>         {0x1002, 0x6608, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_OLAND|RADEON_NEW_MEMMAP}, \
>         {0x1002, 0x6610, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_OLAND|RADEON_NEW_MEMMAP}, \
> -       {0x1002, 0x6611, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_OLAND|RADEON_NEW_MEMMAP}, \
>         {0x1002, 0x6613, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_OLAND|RADEON_NEW_MEMMAP}, \
>         {0x1002, 0x6617, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_OLAND|RADEON_IS_MOBILITY|RADEON_NEW_MEMMAP}, \
>         {0x1002, 0x6620, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_OLAND|RADEON_IS_MOBILITY|RADEON_NEW_MEMMAP}, \
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
