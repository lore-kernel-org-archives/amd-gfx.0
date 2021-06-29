Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F76CC11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 14:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F35361DBF
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 14:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F35361DBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12D4E6E8A5;
	Tue, 29 Jun 2021 14:27:56 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 423D76E8A3
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 14:27:55 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 i12-20020a05683033ecb02903346fa0f74dso22833256otu.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fhIvr7i1DO8O5Cevtwj+WVwH3nXl+BRJsSVrheBFLRo=;
 b=bBDF/U1tyx0/LoPkx3EIbUcI00QYkzqgvWPIpIg2nam1xXgvI+fEECkSTtb4yBiRZF
 2Qtihuytx756naAFkJVaD0j3OWjCJpxecpuRmkzSxZ8DPqaCU4bDMyrv4o6Jfe6BbcMP
 18PRixncE7FBbFdAX8jBHxn6unA0MrvAgjgnYdPNByQQ4cZ3WqjHKjGRDQ6TVLfek31v
 7gIjPe1itncIvlgFuxaAHi6VTh20RiN09uPYe47Pk76TWPgZOZvSozgczSnMD4xfSs2x
 mqB+gZPadAI9v80E2Xv7zN6qPC3hAaBPNtvSb6oK53OQmCFYOyx1j7uIJRmsyTtL5wZV
 o3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fhIvr7i1DO8O5Cevtwj+WVwH3nXl+BRJsSVrheBFLRo=;
 b=VNRZw9D6315k6rreB+diBY1WyCJe4Ouees3VkiibgMxTtSgx1qau3rVQwnlT8Br0Kx
 d4fzTmyXUkr9zsyfUN01BCqN/vlJj5URUlQUIeunlkPXtp19kGcDSNn5eVKRy+d1a96L
 xaUvmE7PaXFR/G0UdaKxPlslak2WvUOeoUVk3Rl5/juZNDs0XOoWxzm0jkgPtMXoFo0F
 shpr6o7SIc1tjm1EFRvbktI4MaVZurq+gvqWNCT1jMCKRpOvOQVkdJEAGGpKaGz8sfvM
 rMoMLkSBm+NmfSXtSdOCJg7wuOS4waL53tswyXfpnNLQt7D7WOYEip08SHlmrUpu2SbD
 cfOw==
X-Gm-Message-State: AOAM531NdLYCaUJGpdmgrts2VZjULShCOn4/ASJ25M1m3noQ9RzYwWA0
 2a0x9ZEK399s1QjPA2VX5/9Wd1h0i3QXCAWBNz8=
X-Google-Smtp-Source: ABdhPJzArgLfCvLsbAO9KzRJ8CJ1URAsZ9YFNrvraEDA3Qnl7sFk4UALNuXVAV7Xa+dtwfYeDy5c/6SOcyYG6q57wak=
X-Received: by 2002:a05:6830:33ef:: with SMTP id
 i15mr4711712otu.311.1624976874599; 
 Tue, 29 Jun 2021 07:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210625064422.30590-1-PengJu.Zhou@amd.com>
In-Reply-To: <20210625064422.30590-1-PengJu.Zhou@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Jun 2021 10:27:43 -0400
Message-ID: <CADnq5_NYoJeuvX8GY3qvkZyErXBtuBKhv4LT4TFtmasibG5ioQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: Restore msix after FLR
To: Peng Ju Zhou <PengJu.Zhou@amd.com>
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
Cc: "Emily.Deng" <Emily.Deng@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 25, 2021 at 2:44 AM Peng Ju Zhou <PengJu.Zhou@amd.com> wrote:
>
> From: "Emily.Deng" <Emily.Deng@amd.com>
>
> After FLR, the msix will be cleared, so need to re-enable it.

Do we need to store whether we enabled msix in the first place and
then decide whether to enable it again in this case?

Alex

>
> Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 90f50561b43a..26e63cb5d8d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -277,6 +277,16 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
>         return true;
>  }
>
> +void amdgpu_restore_msix(struct amdgpu_device *adev)
> +{
> +       u16 ctrl;
> +
> +       pci_read_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
> +       ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
> +       pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
> +       ctrl |= PCI_MSIX_FLAGS_ENABLE;
> +       pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
> +}
>  /**
>   * amdgpu_irq_init - initialize interrupt handling
>   *
> @@ -558,6 +568,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev)
>  {
>         int i, j, k;
>
> +       amdgpu_restore_msix(adev);
>         for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
>                 if (!adev->irq.client[i].sources)
>                         continue;
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
