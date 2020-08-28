Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E55FC433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 19:29:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12CE620872
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 19:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVluZL+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12CE620872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAFA16E51B;
	Fri, 28 Aug 2020 19:29:26 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BB646E527
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 19:29:25 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id f7so201948wrw.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 12:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NCoUjQA+Igmr2eE4vPXBWEKRkY2Ho9RKKqjDou/HAbY=;
 b=MVluZL+pm+OxSZb3z/PObR6gwoHKfYUVBZEHzSPFOjN/TnXE5AE9GPYXht4YEeOM6T
 7G8ARULXKyznKO0fJpJT6tQCo2YWbFdyYXw4Fj23VNH1TIs9YavKZ7DsO1CR2VswANsq
 ByR+W2T35LTCFWgy3/DS4HeMj1WII+L0R0hYlJgFqh95m0vNgIqI+wDlSPtbYgJ8i1Lu
 KELekZBb8+FkDKSIj0du77abu0ORWCxdLNwKyakVlWKpalUuEYqZ9H1EWJOIeqqsdRWH
 sffQbHgM7YqnhGscT51yi4NDJpqvLF8vI2pE53RSVzeZh57JM38pOUB14eo8erjyz1si
 AZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NCoUjQA+Igmr2eE4vPXBWEKRkY2Ho9RKKqjDou/HAbY=;
 b=JdDpPVSx+rqTek/6SMngH3rczFXpVJBqrCGvh1UuAyQFUZbV/5F9zXcgHsAGiGB7wp
 pI2INUdzqcdvXEFjcn8tbbvb9cvfsaOSrabv4jTe0/5Yukl5CdkzUAyFf8KXSirD3o5m
 SnOdIhdcsy0CmPPx470iadlGzgy+WZeI6lCgQLAkt8K81vdAcoN0ws8jR5neeqOZTebW
 lQjzECdSPYhYsITD/bhNHi5Ojm9i8YSLBGeM2F593SueWODfpZaZysaSd8oEsRHweOCY
 /8sv5nAzuzwmXfURPWuNePVgxybLIyM9CbdLmgVAuu6T87EbyVj8nl5QzcsUPulnLZJc
 MmTQ==
X-Gm-Message-State: AOAM5307WPAEIx+6MyT0DaoObmZku9WVk66F6lw3z4+X3aVO/j39N5Wj
 Va4l188ayycObTLXkiCjiYNQzCJCxyS3EtS/gJ0=
X-Google-Smtp-Source: ABdhPJwxLf5Q8DP/MMeRnNORG7UpoCkA4v/rFaMNA9nNp0mgOkvYmp7HJehzKx4aDhDBMbhR6yP3bFVUurGaTrwGyCk=
X-Received: by 2002:adf:edca:: with SMTP id v10mr485713wro.124.1598642964328; 
 Fri, 28 Aug 2020 12:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <1598630743-21155-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598630743-21155-5-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1598630743-21155-5-git-send-email-andrey.grodzovsky@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Aug 2020 15:29:13 -0400
Message-ID: <CADnq5_OMukMG3FzFx1HUN7vvpFgt2TXtB_BmKQ+Bm8SNhCmeiw@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] drm/amdgpu: Fix SMU error failure
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
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Aug 28, 2020 at 12:06 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> Wait for HW/PSP initiated ASIC reset to complete before
> starting the recovery operations.
>
> v2: Remove typo
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 9a367a8..06664a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4844,14 +4844,32 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
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

I wonder if other reset paths need this wait as well?
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>         pci_restore_state(pdev);
>
> -       adev->in_pci_err_recovery = true;
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
> +       adev->in_pci_err_recovery = true;
>         r = amdgpu_device_ip_suspend(adev);
>         adev->in_pci_err_recovery = false;
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
