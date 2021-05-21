Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BC8C04FF3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 20:18:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AC3F613EA
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 20:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC3F613EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D19C56E0C9;
	Fri, 21 May 2021 20:18:30 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 098FF6E0C9;
 Fri, 21 May 2021 20:18:30 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id z3so20785055oib.5;
 Fri, 21 May 2021 13:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mjKGAxpjBYq0AerrBLJXQGl7oHmLTtndw0QsIzcd7Bc=;
 b=N5nQeWt3lHmSFZOZ3XymWrrgevcuWGIBSpKi806RX9Bij72lgH5wWKoXorvE3IFIuw
 U6wf8lFnam6bXRkGrPuenYUjkZebvV6hfRWKWSl+4uIf5vy1QC48p51au6XRwMEHM+cj
 FyDyFLr6qDtgfho4DnEqnrf7EgyoaxYWnr3dG2ZYtsiIoV7CPeCNR3IfDUF4sLJUUij3
 W9sxTWznvZmIQt2skrHCbGiSsOCBrpIzPPQF8TexTHYo6M0me2CCxVoKmJ7/DVyI9cBD
 4co1KMfKQD7T4R/2EPlEpov3tqgEoJtmhYsHYqyRincKJhxLdmsayhtLiaBizZPaAVVm
 0ylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mjKGAxpjBYq0AerrBLJXQGl7oHmLTtndw0QsIzcd7Bc=;
 b=MaaEkEKeQm6HZoKLe7QtaBpaaBLH3bvoO5gBBJs1iKQCiM25GhOxj4e4oB3/wjyOmb
 6250CLTQxopobstkTAXiBJltWwH0fYrnlTOsTZ4tgeIvtK/K7V+uWcnHMzJqDngP4A2C
 3nZI4jR5FYj9b2jX7o698xu0FxY/mXYxtjoe57epicaS8WE83fkbhjPUfnky4Q68//kI
 DyxKpiS7IAkNRu0B4lm4A6sVjbp12YRNDaGkqcomRqeaubkCZMHHTZVcKprI6ieE24kx
 FEyv25EuFEczsJT58MNKrzWRnA2r5eT79iJ83l1CCCEhaMxsjB/0HbcT7t7VLaTfOl+9
 mL6w==
X-Gm-Message-State: AOAM530o9ojSkRMb3qDNLx9MxTI/zZnSi4zIslSBmUOSyc/gPL4ECecz
 Z25W61i88gQ2W+vg795bDBIfu3lhT7GNEL6rSLw=
X-Google-Smtp-Source: ABdhPJwjQU1rq2vUudMes+RDRSnfshTdmv1Zff1MFj/vNHjA2L1hw5yG9Q5vBoj11RnA2C0c14GffZJnYYl0XNgCdeo=
X-Received: by 2002:a05:6808:1592:: with SMTP id
 t18mr3435810oiw.123.1621628309437; 
 Fri, 21 May 2021 13:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210521201412.746745-1-andrey.grodzovsky@amd.com>
In-Reply-To: <20210521201412.746745-1-andrey.grodzovsky@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 May 2021 16:18:18 -0400
Message-ID: <CADnq5_OVAVet7b614cDc0rS5fzwarjFtyP3nc9Ute3k5Hnbz1g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix crash when hot unplug in BACO.
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 21, 2021 at 4:14 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> Problem:
> When device goes into sleep state due to prolonged
> innactivity (e.g. BACO sleep) and then hot unplugged,
> PCI core will try to wake up the device as part of
> unplug process. Since the device is gone all HW
> programming during rpm resume fails leading
> to a bad SW state later during pci remove handling.
>
> Fix:
> Use a flag we use for PCIe error recovery to avoid
> accessing registres. This allows to succefully complete
> rpm resume sequence and finish pci remove.

Might make sense to create a preliminary patch to change the name of
this flag to something like no_hw_access since it's not specific to
pci error handling.

Alex

>
> P.S Must use pci_device_is_present and not drm_dev_enter/exit
> here since rpm resume happens before PCI remove and so the
> unplug flag is not set yet.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1081
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index d8db5929cdd9..ab95ebf56636 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1555,6 +1555,11 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
>         if (!adev->runpm)
>                 return -EINVAL;
>
> +       /* Avoids registers access if device is physically gone */
> +       if (!pci_device_is_present(adev->pdev))
> +               adev->in_pci_err_recovery = true;
> +
> +
>         if (amdgpu_device_supports_px(drm_dev)) {
>                 drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
>
> --
> 2.25.1
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
