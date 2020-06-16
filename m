Return-Path: <SRS0=tiv0=75=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25344C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 15:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDD6F21501
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 15:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ml0YZ6M4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD6F21501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9506D6E903;
	Tue, 16 Jun 2020 15:51:35 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 808F56E903
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2020 15:51:34 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id b6so2163592wrs.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2020 08:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dUAgbw2wJYn9b55B4B9UM3TTdmDuXRBVtJ/HZuc2hX0=;
 b=ml0YZ6M4D5YUtxest+Ak6tqWNO7SQcC9TttAUkoeU1QERZobdQ3InA0YcCGYW9kzwe
 cux9W1QSSHdXMZs+09zafzwvwYdAq2vdCiESLhm4Itn2meXeKge3TefdrWvVt0A+MyfE
 WzPrkJAA0CYenUHkHIWwBKG20coFJ5YVyU2P2wer5fnejCkOHGdWMvBqM4VTG8mb1Pd3
 ExgwkuAKBnH7z2yF/j7hgOcW4orUOWxlq4RuEE3PWoTRdnPcB0R8wBZLMAGgBb10cHh5
 h5VvYQGLV7OboLGvfpxEvdTNik2rnPoOf7F8Fwd2FF8ZJBDUtPaf2CTXwoqz3bTdkoX/
 VjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dUAgbw2wJYn9b55B4B9UM3TTdmDuXRBVtJ/HZuc2hX0=;
 b=eTT0nvlnQpp7cUpYCMSS1rn8E5JZB3zEETWewuQwuU/Bb7R4vbiwos8SZYZ6C6WIQ7
 AI5b8Q0/lXE8oM1n97Wm2uKDKFf0hsi5BplSisMPTkJ5b2RMSKGNoFDwLQO3zI+0DjNI
 L0KtkPFoNpWz1H2yFOb+BWbMmnrk/Al0wk5RBbcRj1tgN95TXv73oeXJIfeeqmcOqNjp
 S83YaugFmU1dLwv++MVWdDjTtqPrcB0R+l2I1DiCYsnRzYs8dskhvVd+eku5d7+Ua/X4
 7oU/aTso8Dgj/4c+l//9e0ruNYc0E2BMQ0/Pz9Q6mAOTxmhPfWJQFbN5MVRihQwBe/BA
 OIaw==
X-Gm-Message-State: AOAM530NpAW1mwfVZfkMmCa9XvE/ycSvU66momWf7W1kuc1v3wdsZAyV
 UMeE0FGQ7tl+rwv6v7VXquhg8gPfVjwiaaO1x74=
X-Google-Smtp-Source: ABdhPJy/2wlrCy2COCX5THaGZQvJNQlfk2YnP3K6OJXVxqOWiLc/VaXm3sZcB6NRbFp+97kfgPF7bIJlWZ5KjY5k4nc=
X-Received: by 2002:adf:fd41:: with SMTP id h1mr3915802wrs.374.1592322693137; 
 Tue, 16 Jun 2020 08:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200616152557.2717634-1-tom.stdenis@amd.com>
In-Reply-To: <20200616152557.2717634-1-tom.stdenis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Jun 2020 11:51:22 -0400
Message-ID: <CADnq5_MuFuhfqTiXDQXRqDQjD6AD52Jz2+ONf-gB4=b4eoVA5Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix offset for SQ_DEBUG_STS_GLOBAL on
 gfx10 (v2)
To: Tom St Denis <tom.stdenis@amd.com>
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

On Tue, Jun 16, 2020 at 11:26 AM Tom St Denis <tom.stdenis@amd.com> wrote:
>
> Despite having different IP offsets the computed address of the register(s)
> are the same between gfx7..gfx10.  This patch fixes the offset relative
> to the GC block on gfx10.
>
> (v2): SQ_DEBUG_STS_GLOBAL2 is 0x10 higher ...
>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h | 4 ++--
>  drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
> index baac40fa70e7..18d34bbceebe 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
> @@ -21,9 +21,9 @@
>  #ifndef _gc_10_1_0_OFFSET_HEADER
>  #define _gc_10_1_0_OFFSET_HEADER
>
> -#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x0309
> +#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x10A9
>  #define mmSQ_DEBUG_STS_GLOBAL_BASE_IDX                                                                 0
> -#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x0310
> +#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x10B0
>  #define mmSQ_DEBUG_STS_GLOBAL2_BASE_IDX                                                                0
>
>  // addressBlock: gc_sdma0_sdma0dec
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
> index 0bde3b4e9567..05d1b0a5f6d2 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
> @@ -22,9 +22,9 @@
>  #ifndef _gc_10_3_0_OFFSET_HEADER
>  #define _gc_10_3_0_OFFSET_HEADER
>
> -#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x0309
> +#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x10A9
>  #define mmSQ_DEBUG_STS_GLOBAL_BASE_IDX                                                                 0
> -#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x0310
> +#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x10B0
>  #define mmSQ_DEBUG_STS_GLOBAL2_BASE_IDX                                                                0
>
>  // addressBlock: gc_sdma0_sdma0dec
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
