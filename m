Return-Path: <SRS0=75wA=7W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D8CC433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 20:34:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3718420737
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 20:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCzVd5FI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3718420737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAD6889E63;
	Tue,  9 Jun 2020 20:34:03 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BADD089E5B;
 Tue,  9 Jun 2020 20:34:02 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id u26so3130840wmn.1;
 Tue, 09 Jun 2020 13:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ck1C6EXNHUjnwGhraJCX8UhZ310w3SODnS0Nvhpy7Ok=;
 b=kCzVd5FILPb4egqErBHlATnOzfXPIbTWCRF8E98PDByFmSR91m7L94+UvwP+svZ4Dj
 6R4uQ6sjO1OcpaMoRA/A99bINYdE3a5QamoJEqb8pPN/gwku6piVEwr5omelIVFse3Xu
 YzarWMs7HObw6skg1BIbwg8ncKddn+/3xzWtyFtNdPnizy5iPTb3qrzqnPC5Q1v2tZKi
 ZWdq9W4KX5No9iMpALXa9dApY7lkCO5o5GoLj6o27jtI1+cBrmwVg6bVlFmMmZ/srBJG
 +PVMg0Vx68kelE+hzEkcFe8NZO9bQ1fknbV9Ro1zSy4Azu9o7KvCgzgvwjqqTKsmYWo6
 O8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ck1C6EXNHUjnwGhraJCX8UhZ310w3SODnS0Nvhpy7Ok=;
 b=FlIOuQa9ylV+s6rpKDGczHN8VTIkLVcjuT5UcjAEntPZg505VPH9wCuxDLC57OXr3F
 LZkeJCEXjSCFQAHnZYGI3wdpZ3rjHO2e//CHn9GorbQN1RZ2LeMGtYZ5O0gQ+J9ptXin
 Zrcda87zEtSl0JRDmTNG7DtMUGVGf4dOVWGyiROCKSeM8gc1klA4WAyXM7uD3J0xDkur
 LMKGRxWtbeUPRyoQS/5GQk/ijDwhS9b9kNNvDM408m9stQJRSyFtXFEOoo2udWNOuNx4
 II4kZEk7w8gZRE9qPhs6uFZL4ywV/CnoPY6VJPXxOccovUAHFK+ZyDa290gnaS1cXsCn
 ZG1A==
X-Gm-Message-State: AOAM532i4pkLrut5ufQmivjSdh3kHXfDc8uqzsBb8H7lgYFAVGGlzc2A
 qW99zEFtHdVlqxGn4sqlHRdiRq4iUVwXgPiHnFk0WQ==
X-Google-Smtp-Source: ABdhPJwihJefCyui3E30tzcKp6cIuhvys9g/LJ6hC/9nbSQ9EPyOHipcwlZJG5XUXe+Q9lkGOQXaHWSptAQdy7oGtqY=
X-Received: by 2002:a1c:541d:: with SMTP id i29mr438556wmb.73.1591734235174;
 Tue, 09 Jun 2020 13:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200609091148.32749-1-piotr.stankiewicz@intel.com>
 <20200609091804.1220-1-piotr.stankiewicz@intel.com>
In-Reply-To: <20200609091804.1220-1-piotr.stankiewicz@intel.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Jun 2020 16:23:44 -0400
Message-ID: <CADnq5_N95PjqU4nMgZBL_PoNKk8ourb_k9HLGvR_RN5FeZ3tkg@mail.gmail.com>
Subject: Re: [PATCH v3 07/15] drm/amdgpu: Use PCI_IRQ_MSI_TYPES where
 appropriate
To: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
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
Cc: David Airlie <airlied@linux.ie>, Linux PCI <linux-pci@vger.kernel.org>,
 Aurabindo Pillai <mail@aurabindo.in>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Sam Ravnborg <sam@ravnborg.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 9, 2020 at 5:18 AM Piotr Stankiewicz
<piotr.stankiewicz@intel.com> wrote:
>
> Seeing as there is shorthand available to use when asking for any type
> of interrupt, or any type of message signalled interrupt, leverage it.
>
> Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 0cc4c67f95f7..97141aa81f32 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -248,17 +248,8 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>         adev->irq.msi_enabled = false;
>
>         if (amdgpu_msi_ok(adev)) {
> -               int nvec = pci_msix_vec_count(adev->pdev);
> -               unsigned int flags;
> -
> -               if (nvec <= 0) {
> -                       flags = PCI_IRQ_MSI;
> -               } else {
> -                       flags = PCI_IRQ_MSI | PCI_IRQ_MSIX;
> -               }
>                 /* we only need one vector */
> -               nvec = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
> -               if (nvec > 0) {
> +               if (pci_alloc_irq_vectors(adev->pdev, 1, 1, PCI_IRQ_MSI_TYPES) > 0) {
>                         adev->irq.msi_enabled = true;
>                         dev_dbg(adev->dev, "using MSI/MSI-X.\n");
>                 }
> --
> 2.17.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
