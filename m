Return-Path: <SRS0=GTlj=2G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEED0C43603
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 16:36:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91614206D3
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 16:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfPpOJkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91614206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F1356E81B;
	Mon, 16 Dec 2019 16:36:18 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DBC86E81B
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 16:36:17 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id q6so8049009wro.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 08:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DvWxOt1dQNZbbUdSFHc1KLFIoyp8zqUGRaYglIrLRM4=;
 b=hfPpOJkVOKxCQwN2qlKR12cnVUAsD47DdRxhHi5hRR5k1JJuV5JEY9yG81nc7k+btN
 fkbkhJ3UfL3pppaH0u3xSFmKRFzO4bTSwuiDkT7D1FteLdZUr/OcL+8zf2Ml40MBlNYA
 sugfEw0zRA1dSFElhe7G//DWUMhNd6iFGlRUOV0uTCmP+g6lEhpQMy+Wo0tmmOvzrMsr
 8I8xkQyr3uOvfwUFgqb2DsmlWDIOF8r/D3x1uZ1vHTgm8kndt2+zZeplW57ql20bJF4B
 Bm0MJX81zn51sirbHNLsPD+2OvIBE8ZZ96MxjG1KhPPgwShY3JzoU/ucJExisCeHkRgC
 LGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DvWxOt1dQNZbbUdSFHc1KLFIoyp8zqUGRaYglIrLRM4=;
 b=LDBikKbsdjSN5kxF3LpuKgpcjSA967EkwRaZ2PRnuZwLEH4k6SL5iB9/Aq/VrYGIZk
 EZv/FiPnS5xE4+h2BKAW3BEHlWiyKR0shzpzNo0CE/69AnBygPWZ1qoQG6ySxv8eZJVy
 xE8u+Ty9E0LMi5ad39GkcGM14W7xrf0fRs4YEdUmrYbQNRncD/RL8+QwuC0MkGB0NYh8
 +Z33vz8lBrse8BvCYX4dJ+FQGXyieGP0rEQA+Y0PwpFiPWu46mWJrz+IQPHE1kn3k9hS
 viLMF4pTpq7odtYDxLJVRj5MCMj+m4U3yUn9IpdT7PBldLgxFdDDjNh1QeKGpxNe+1NJ
 VKWg==
X-Gm-Message-State: APjAAAX9xxd7KukWMLCPWlUj+HX9fcKtYQbepcrGYsSlwpk694ti4Pgg
 R15eeFJHYAMMoRJdZM5CsWY4mJN2lC3jdIz+mUEqpqd8
X-Google-Smtp-Source: APXvYqwdoZsKrJ8wq6pzFW8QRmcdx5xy//6fUJ3wLW/OJhNkxZXMZv/6j9LH0OLRcFxDh1E8jlvUVPPsqxC5AWEBv1E=
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr31569323wrn.50.1576514175715; 
 Mon, 16 Dec 2019 08:36:15 -0800 (PST)
MIME-Version: 1.0
References: <20191216160543.13054-1-leo.liu@amd.com>
In-Reply-To: <20191216160543.13054-1-leo.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Dec 2019 11:36:03 -0500
Message-ID: <CADnq5_NyFmejzHKHztPmXU8achHWqxPVMzwv2=t-8McwroQcVA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: remove unnecessary included headers
To: Leo Liu <leo.liu@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Dec 16, 2019 at 11:06 AM Leo Liu <leo.liu@amd.com> wrote:
>
> Esp. VCN1.0 headers should not be here
>
> Signed-off-by: Leo Liu <leo.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index e522025430c7..371f55de42dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -25,19 +25,12 @@
>   */
>
>  #include <linux/firmware.h>
> -#include <linux/module.h>

Don't we still need module.h for MODULE_FIRMWARE()?

Alex

>  #include <linux/pci.h>
>
> -#include <drm/drm.h>
> -
>  #include "amdgpu.h"
>  #include "amdgpu_pm.h"
>  #include "amdgpu_vcn.h"
>  #include "soc15d.h"
> -#include "soc15_common.h"
> -
> -#include "vcn/vcn_1_0_offset.h"
> -#include "vcn/vcn_1_0_sh_mask.h"
>
>  /* Firmware Names */
>  #define FIRMWARE_RAVEN         "amdgpu/raven_vcn.bin"
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
