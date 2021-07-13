Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B8CC07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 13:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA4B2610CB
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 13:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4B2610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90F806E091;
	Tue, 13 Jul 2021 13:19:43 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA5366E091
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 13:19:41 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 o3-20020a4a84c30000b0290251d599f19bso5374211oog.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 06:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=giXfQI8LoI8gjqnAyMEpgZPb1ixyWGqHgQPaQeXMAjw=;
 b=uV+eu4UyhYdSiILnwFD/q6iBhrS6UY07Qm5xn74+yph+LC7+xDpekORVkcbv3YxVaX
 rbxSnVDk2kfs3GLR4/EgwSZnU26AEQpiaaXoxx30eatu5X/Y8r/r8c4aQr1bYSTaOGjY
 SFVf6npxZaTzbISEL8jLNoFbq1boa/QSvnMr1kchXM2qjxnwgqEK8Bx4LyxDBvOMAqZY
 qzLP/qYso8xSKmSVZ+ygIjYmECXFcitYNy9r8XkItzQuswa5wmqAzb+BM8oMbJR6ywzP
 vQ8L1SVL/HvJwwmZIojUMf8ln8WTsFW2OyhVA/cWqJLu4aCqbFk6OHAA2BY+kvDsdWRh
 QtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=giXfQI8LoI8gjqnAyMEpgZPb1ixyWGqHgQPaQeXMAjw=;
 b=PqhsQhmxJ5LM48MHtNr3/kVSuYG6CH3mb65j/li0ap+8OatbIIBVrxxrGYW/uMJF2J
 GTjQsLHI5iEp/GeHDqJy3Z6GK1W0jztvv13Z+5bJM9dNtbOt+zZ5q8flx2bPnMqqOpHH
 1MWv6Un9Q4DToqdT9xRRAA8JxnsAnT/sOxRDRVnbFYB9tOBdLhTL04VvPOuIPCa2tBoc
 UlcZIIZv/EJHacxTW176sTk0lV4jcNRABKgqmq8BYXOz+8oH1J4HVdzg3M45tLGQ3PEy
 b3vPcttizpOj1grS4NxkWi5zAPeiRMz660N+/cPVlS0Z3tMh2Ik7qi+gy/g0eC9F5UCH
 CD5Q==
X-Gm-Message-State: AOAM5325ozL7Jk1Q33cCNukCqcd3BgYvVF39FoM7cJYGTtJAwlGfy1fc
 bL0I4ECSiQY7c7puPwP7pMSFpbXbcLTMxObCmHs=
X-Google-Smtp-Source: ABdhPJyOHQsmH+XvubccEZw2YqF+XsCppWi65XNLjI5+Z3dU1sUAsc4PXxJkvUc3deud+ZXf7L5ngdSRhVLr49O0C2k=
X-Received: by 2002:a4a:be93:: with SMTP id o19mr3517867oop.61.1626182381296; 
 Tue, 13 Jul 2021 06:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210713020357.3075993-1-Jinzhou.Su@amd.com>
In-Reply-To: <20210713020357.3075993-1-Jinzhou.Su@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 Jul 2021 09:19:30 -0400
Message-ID: <CADnq5_O68de6N8D=gfHSv_6vkNegPnAqTmLdpt6p2DFhzSss2A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add another Renior DID
To: Jinzhou Su <Jinzhou.Su@amd.com>
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
Cc: Huang Rui <ray.huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, Jul 12, 2021 at 10:04 PM Jinzhou Su <Jinzhou.Su@amd.com> wrote:
>
> Add new PCI device id.
>
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 179f2d01a082..1db106b135f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1166,6 +1166,7 @@ static const struct pci_device_id pciidlist[] = {
>         {0x1002, 0x734F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI14},
>
>         /* Renoir */
> +       {0x1002, 0x15E7, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RENOIR|AMD_IS_APU},
>         {0x1002, 0x1636, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RENOIR|AMD_IS_APU},
>         {0x1002, 0x1638, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RENOIR|AMD_IS_APU},
>         {0x1002, 0x164C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RENOIR|AMD_IS_APU},
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
