Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFD1C35266
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 04:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D6472075E
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 04:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFUwyLcE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6472075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 097A76E03A;
	Thu, 17 Sep 2020 04:31:02 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF77A89D58
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 04:31:00 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id e11so3547874wme.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 21:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JxOlGL7Wb1kx0+n+c5XJNImfPcrf/uLTFv5l0BFm7Oc=;
 b=tFUwyLcE2cLVblHVS0rNXzY2kSMOOx504tzL9VzXXVHZVfdBQ0BqcxnFYpN/npA5Qn
 ZP4w7ydY0CK1lpO3gaiRyScunMMIDDfLKeibhiPbM1fl5AFYZcXw1F1xQY+9FPN/nbRf
 cocH3oivmdlrp6lpdvOiDbceowwX4lyIRWH1YYBzvPFiDgxY1s8H3g/KicMPvzJIY9Py
 cZUL8bhmoLLDdfLu2GvIhdGIpyPf0//GrWj2aqCgCvZQfoKqZhDugSiZ0J4aklGSBQbs
 ug9cmQmtSvu07wBazIeVYnwfD/1w/bTt7hBDIH1tr081xyZXkVh8ABopV8kn35dPJ6Il
 pUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JxOlGL7Wb1kx0+n+c5XJNImfPcrf/uLTFv5l0BFm7Oc=;
 b=DIXydNSVbRnonsO8CsEKd+7N6BCgz4U6beeowoGOcsSOCR3jUrR8MDdBAvgPM1bwLY
 031Ed8fxzZgsyJF9vJvquXQK+1F8IpuQ1h0+gZR0j7HH5IkdHrH9mimcjm2xuJWZxK13
 nDsF5XNnYxICmY/4B6hjCOt0gf+5NbvokUhcqTSa7s348Kbw/TyOd740/LJEGst1RAxe
 SDrXLCmdtz92KlnBbEG+VrkVPBSFrDkKKWA8iWwhqhN8TH8v66a1n2UGQnmUuKrYNAqT
 TQMlrNroIoZCZANAwnktUT/k7vIiWwCFEGc4VGfg9ZeRZEHjAgjuhIfvxqGKA/lD7qvd
 YMaA==
X-Gm-Message-State: AOAM530uCCguDg1+Co7d1pBvM4EL7M/AiBGQlTZLwDstvrQbD5/0D+cq
 lXtqX2qzQU4lDTRT9nrN4vZNrPAUfWJ3OJgARqPxzQAI
X-Google-Smtp-Source: ABdhPJy1Ox+4f91q8TWChjZZZF/769ZkA1ugRjAiQSPBznLDswmiWoWfyKPXkmh3Q20p1CRubX2QB23kiyyDlu/yrvg=
X-Received: by 2002:a1c:e90b:: with SMTP id q11mr7750955wmc.39.1600317059283; 
 Wed, 16 Sep 2020 21:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200915182206.68607-1-alexander.deucher@amd.com>
In-Reply-To: <20200915182206.68607-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 17 Sep 2020 00:30:47 -0400
Message-ID: <CADnq5_PqwxWhjjfn4FHRcW2TKfPn0jZ0T8sPNRa5g9FPiD2JAg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove experimental flag from navi12
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Tue, Sep 15, 2020 at 2:22 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Navi12 has worked fine for a while now.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index d87d37c25329..6e4c860e8ae0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1073,8 +1073,8 @@ static const struct pci_device_id pciidlist[] = {
>         {0x1002, 0x1636, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RENOIR|AMD_IS_APU},
>
>         /* Navi12 */
> -       {0x1002, 0x7360, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI12|AMD_EXP_HW_SUPPORT},
> -       {0x1002, 0x7362, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI12|AMD_EXP_HW_SUPPORT},
> +       {0x1002, 0x7360, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI12},
> +       {0x1002, 0x7362, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI12},
>
>         {0, 0, 0}
>  };
> --
> 2.25.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
