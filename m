Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A7BC433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 13:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 899CE10E2A2;
	Thu,  3 Nov 2022 13:14:54 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC56710E28F
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 13:14:51 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-13be3ef361dso2028522fac.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Nov 2022 06:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6VNAugAADT2j/yV6knAQZfnutvno6ph9XoP/8xfT7dY=;
 b=kR0L1qbd3+LFOaBw+GJRmetKU/6qB72DblC/ecITnjweNQVu/cZ0LPOHOvt+woQYpJ
 c07XgR45YPBOB1piM2exMi1pVWWTQSEKX4rqTmWb934GDI5qfg5KGdVwGTBqF6/TWyAP
 FDdT5fUZZetmZVqEF84OHM70FKmM3210++9qglRWF0l6ttA0PQYHHlWG7IXA6G3L5/AG
 JbqedQvPF/nuWPGgXECdzWyA9QIYMcDbgQa0rGoZkqw0tu44vY2TDenhb5bxgrGm7HjT
 PdIS/hsPc4qStEWN1aauKHytzUyFYqB8nhc2c7Xyg2HkgXV22gyujra1ylkTwC69AZmM
 0Czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6VNAugAADT2j/yV6knAQZfnutvno6ph9XoP/8xfT7dY=;
 b=0+f/eXGdaSJRxzhfA62oaMHm8n/YPPzHodAtxdybuB9wG8i0pad0o8GMX5tqndEHqd
 HZeyZaY26YkYDN45g2NSFOs7cTuNlIE5cbYjA2mO0CeDnBDdcj79ipQ/2BNdVQQ9roYR
 0uV7aZqOgQv06rFMvmKqNDVWUhUxW/zBo0JbCuWPi1SM5iI5XISAjTgVUHkcNTdJJqLX
 caq0ngf+pLILeFzFT+3drfn6zswlUO9lHosiTTViaM12ZXjeDPnhh4/fZEf9j0I6d3YQ
 +jUVUHr7kRCt5Iq3pa7AhhlwfTgu9V7dQZKECdMUAiUH227XVMaYriTyRoGkxvijIFXM
 wYDw==
X-Gm-Message-State: ACrzQf3SsOb7k2Ld5ardfq4po5NTAyqwQZ7OIapeWyWgo8i/5r4gei/w
 uif127qJ5AXAn1j7n8pHGVpWYjsSTHhiyf9SOo7yQ7CAlnQ=
X-Google-Smtp-Source: AMsMyM58KyRX2f8bxQ2TiVVMbpQ2bzOC2goa8gp467NxM34xvw7eCFh8UWvQfG+NX3Ma2S4m+SqaLFBVSYLw3R87M7I=
X-Received: by 2002:a05:6870:a116:b0:13a:f9de:6fd0 with SMTP id
 m22-20020a056870a11600b0013af9de6fd0mr27961936oae.46.1667481291066; Thu, 03
 Nov 2022 06:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221103062056.2162715-1-Perry.Yuan@amd.com>
 <20221103062056.2162715-3-Perry.Yuan@amd.com>
In-Reply-To: <20221103062056.2162715-3-Perry.Yuan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 3 Nov 2022 09:14:39 -0400
Message-ID: <CADnq5_PhdXH90vo01f8zbGnwzQzy-tBtJn_+J9eO+HXO-vsChA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/amdgpu: remove the DID of Vangogh from
 pciidlist
To: Perry Yuan <Perry.Yuan@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Shimmer.Huang@amd.com, richardqi.liang@amd.com, kun.liu2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 3, 2022 at 2:24 AM Perry Yuan <Perry.Yuan@amd.com> wrote:
>
> change the vangogh family to use IP discovery path to initialize IP
> list, this needs to remove the DID from the PCI ID list to allow the IP
> discovery path to set all the IP versions correctly.

As a follow up patch, it may make sense to remove CHIP_VANGOGH
entirely so no one accidentally tries to use it.

Alex


>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 429fcdf28836..9c323405e3bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1909,9 +1909,6 @@ static const struct pci_device_id pciidlist[] = {
>         {0x1002, 0x73AF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
>         {0x1002, 0x73BF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
>
> -       /* Van Gogh */
> -       {0x1002, 0x163F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VANGOGH|AMD_IS_APU},
> -
>         /* Yellow Carp */
>         {0x1002, 0x164D, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_YELLOW_CARP|AMD_IS_APU},
>         {0x1002, 0x1681, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_YELLOW_CARP|AMD_IS_APU},
> --
> 2.34.1
>
