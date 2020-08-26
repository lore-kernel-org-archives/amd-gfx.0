Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F574C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 15:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5051F2074A
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 15:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X65rv+jK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5051F2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DF3C89FC0;
	Wed, 26 Aug 2020 15:10:54 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B55689FC0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 15:10:53 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id w13so2164260wrk.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 08:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NjAUaBb8nx9P+JuPo4uWCjAA05Du+GWRRE7sBObOXI4=;
 b=X65rv+jK6sYT0r3dg7YftOwB6O2BdmnNM0VvtREbukuVWwLsSLhZN/VjMKEuqDWWPO
 rdIBWAmGM/mYuV1x6cFPbpx5yIFS7PUUfeXSkwoSuvENc4MmCZgV3WhexgWIf+BFteaR
 tLDyL2hNQBf6/6a46MlcpvSae57SR37ETzC03wBrDLsLkEi/FIu2ARllPJXjsrYMZnGz
 XieALkt65Keq9//tNOa1tNsDRzWRi8u2liAPA5rXCBTalSS/jWPiczJcUwKWJA9NlmE6
 wqRUpAOWuZAoj9QPF1+vJQyu0mMvbS/fpujJ2o6ruWxE5OeKpcYGqQc5CfnSsYuaeyYw
 Cu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NjAUaBb8nx9P+JuPo4uWCjAA05Du+GWRRE7sBObOXI4=;
 b=hQ3k03UpcWi00kUoEAvXi53AVhDBEuyM0iLI2Z7h8gbbn5xJM1TxOnKvRPp0qxvL1M
 49gDmD7RUOBYKDheUI5sMcBa34FG0uf1b9XqU47zwelZYLauJMvp4URwNTtyLMzYm2ol
 3LSmu1CO7OQ1uAA1tSb01Fya94586/Z4/M4OV+fqCzhcWou2wTF7OVCLZbZkrH74rV9q
 R+bAbC7tRX7h9Tzw0sY/MiAEtAbaJSSfDwAa7VrZxt/79nNXHLrXdd1cqaW6a9vevktV
 bAjlZnqnnL92aGxUW84SgLifqjGRc/yLUKVFOl988F7TcfUB0wkxvectseb5dyoSBhZL
 cTYg==
X-Gm-Message-State: AOAM531fvwigcGvu+XUhdURdGIHoRjbBy5Zjtb2NJs9mjTTmEsULhFV8
 aBaMDh9eQjYnBYdfj0qVbP0O389LW+6YIhh5nFQ=
X-Google-Smtp-Source: ABdhPJzfuNcgIJDlYJs9jDX/mzbcxfx9gvXjgmnAI7R/vI58Ugj4VZgB6QSZhDAZ4gPMFcljfToC99M2HQqgEnf/0cs=
X-Received: by 2002:a5d:494b:: with SMTP id r11mr16794298wrs.419.1598454652112; 
 Wed, 26 Aug 2020 08:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598453182-6946-5-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1598453182-6946-5-git-send-email-andrey.grodzovsky@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Aug 2020 11:10:41 -0400
Message-ID: <CADnq5_NoQntOr6crNWVZDCuzy0waEjLUrvPT+x6Gfrbj+=KkFQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] drm/amdgpu: Fix SMU error failure
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, Nirmoy <nirmodas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Aug 26, 2020 at 10:46 AM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> Wait for HW/PSP initiated ASIC reset to complete before
> starting the recovery operations.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 0a2130b..d9e3994 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4846,13 +4846,31 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>  {
>         struct drm_device *dev = pci_get_drvdata(pdev);
>         struct amdgpu_device *adev = drm_to_adev(dev);
> -       int r;
> +       int r, i;
>         bool vram_lost;
> +       u32 memsize;
>
>         DRM_INFO("PCI error: slot reset callback!!\n");
>
> +       /* wait for asic to come out of reset */
> +       msleep(500);
> +
>         pci_restore_state(pdev);
>
> +       /* confirm  ASIC came out of reset */
> +       for (i = 0; i < adev->usec_timeout; i++) {
> +               memsize = amdgpu_asic_get_config_memsize(adev);
> +
> +               if (memsize != 0xffffffff)
> +                       break;
> +               udelay(1);
> +       }
> +       if (memsize == 0xffffffff) {
> +               r = -ETIME;
> +               goto out;
> +       }
> +
> +       /* TODO Call amdgpu_pre_asic_reset instead */
>         adev->in_dpc = true;
>         r = amdgpu_device_ip_suspend(adev);
>         adev->in_dpc = false;
> @@ -4882,7 +4900,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>
>         r = amdgpu_device_fw_loading(adev);
>         if (r)
> -               return r;
> +               goto out;

Is this a separate bug fix?

Alex

>
>         r = amdgpu_device_ip_resume_phase2(adev);
>         if (r)
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
