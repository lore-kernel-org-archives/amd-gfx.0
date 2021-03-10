Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F743C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 04:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B722264FEF
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 04:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B722264FEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C0CF6E9BC;
	Wed, 10 Mar 2021 04:50:33 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57EF86E9BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 04:50:32 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id 75so11927553otn.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Mar 2021 20:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QGjtIewv+cEYMZyoVFvCyIOmlFgnIZNdPP0YPaOmCTw=;
 b=NhwOZ00OCb0SSb/4QgalLnAqZTAIGQuTScxj1Tzj5TJl/+fa08tIHOY7HkRdhM+5gV
 nxaJW6FuhPtE/Oeq/XMu02cwbvGcM840Ojk+eiUPEXsdOyiqu/VLG3yaEdwzrxjLlqO6
 rWaeTaCf7J+zxxWIBVTXx4O+IdginZCJzRV1X/yIHHwH39WjqjJuir6UK5OfJYAkXbfV
 ICsq/vFWgjZ/JLjAMQEGuxu0QWtuhJiAyXQ0L9yYXXu4DgvbH69MjqcgLBP3QdqTnjFF
 0PT5CNsqJf0eHldMpYRlJ8k4x9cgpDHHm7lEzvOl5v8d8sqnpx+0CE30gmM2xBOGLeLv
 QDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QGjtIewv+cEYMZyoVFvCyIOmlFgnIZNdPP0YPaOmCTw=;
 b=pHKcNqR5Z8LwZ0pNUXY2kDX48UjsN3mnmqf4noYv78Dh5udBf9JusT/je3ZEACiR6c
 VI3nqRlUyuAq+MHo78C9Rn9wEmTR/IKY0gqh6/a/O6MK7BDeH80HYYbqjG4tmTUnpY9S
 J0M04XRaozAx+7UJgnqGUgUEu75d37VwS00mu6PZc1BV7ZWw59eA4EyyDlsRtPM1GrJf
 77V64+nL7fTa4TWq64cXGnSdIdOBH24vtFVkK6QHBTRJqGlkE/i6pNf648esqiKXmXCG
 X0UJEG1aWIeb9n3NhRRAMqK70GC9/B6jZ8BMScY1MPgC1YPZ4UZ9OKzemXgTB37lLzve
 qcbg==
X-Gm-Message-State: AOAM530EFKSGIwOi5Ko2A9YAKO+zJ7WQ65Y2ZcicTSs28LRVZ9cLdvsT
 37CEhNJ1/GPKGQWe/0DVBsUCJy2F0IpUpkExIMo=
X-Google-Smtp-Source: ABdhPJxAV2x+cQQ457menERgDG9L2IwR7mlcU+IzE7gSWfhrHb8/bXLpxZ3fs+9uH1a8FjGAcjGTFliO6XRTfrZping=
X-Received: by 2002:a05:6830:408f:: with SMTP id
 x15mr1345715ott.132.1615351831671; 
 Tue, 09 Mar 2021 20:50:31 -0800 (PST)
MIME-Version: 1.0
References: <20210310043807.2248045-1-Feifei.Xu@amd.com>
 <20210310043807.2248045-2-Feifei.Xu@amd.com>
In-Reply-To: <20210310043807.2248045-2-Feifei.Xu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Mar 2021 23:50:20 -0500
Message-ID: <CADnq5_P7gO4yW_7GZdJb4W7AvOJjio39+yxXrUp0Q2bcWGikTA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: skip query VFCT table for headless ASICs
To: Feifei Xu <Feifei.Xu@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 9, 2021 at 11:38 PM Feifei Xu <Feifei.Xu@amd.com> wrote:
>
> There will be no GOP driver to copy vbios image to
> VFCT table for headless ASICs. Thus skip VFCT.

I'm not sure these patches are entirely correct.

>
> Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> index f454a6bd0ed6..03739774beca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -427,7 +427,7 @@ bool amdgpu_get_bios(struct amdgpu_device *adev)
>                 goto success;
>         }
>
> -       if (amdgpu_acpi_vfct_bios(adev)) {
> +       if (!amdgpu_device_is_headless(adev) && amdgpu_acpi_vfct_bios(adev)) {

I would drop the first patch and just check the pci class directly
here, it's more clear what it's checking for, plus I don't know if
it's a good idea to mix the nv check in here.

Alex

>                 dev_info(adev->dev, "Fetched VBIOS from VFCT\n");
>                 goto success;
>         }
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
