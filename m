Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD79C4361B
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 17:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D2B123884
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 17:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2B123884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0166D6E83F;
	Mon,  7 Dec 2020 17:19:20 +0000 (UTC)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 280B26E83F
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 17:19:18 +0000 (UTC)
Received: by mail-ot1-x344.google.com with SMTP id 11so13152652oty.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Dec 2020 09:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vod8mxD8wqCmqMLZ1i+zcrDTaslXMyZsAXYMeHZPwbY=;
 b=XpiaoYrztYc0YaRUKduMGbvzDYveGPfatUOSvhch/E0qjjasYHZ2zVf5Xr2lkfNkZF
 i/KlrYTAUtAWy+jRiC7xm9mhAlrkON8kF8Ywt4VSOGwhkVgUHB5n0idWFwEvCRghf5ye
 Am9+emjuT915bHnD8u1ErPeXXfLxm0KAvPW8Xk3XBThZs/bfGn3sGRwx7bNWJ+yl1rgQ
 XshTjNnFSW/VTDPvs1wNfqLAkdJP8WWdtCelv4pxfehGmueaUKVisBtYdazXTe56e06q
 x9eplUOV4gbp77hC/aIbS7YdOlYhMSarB7k9DsFxaWjYPat1u2QngbRgxoDfojfyrskg
 79/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vod8mxD8wqCmqMLZ1i+zcrDTaslXMyZsAXYMeHZPwbY=;
 b=Xf1OkJigvLN0sJRCXYEQUnLkeqA1k2g9ZP/z0Yjlwk/RI35agLMQLAUvYYbsRTGePf
 BDZHTjy9VKbIMgYJaZv274v193wIk2gKcQeSGOSBp7DKnqAia0afkj/D1YI7T1s7YzK4
 gO8/8hvoFOtO3rHjDqrqxi9SO8sk3PtRe4jXObv3zSJ6RC4DrdYUdYb1TlO1sQzndxCX
 dEZt4n4TABkS9b3LLfjEyRYf8dui2ZXieR7k+gVF3pRsZuzFaFiNIGEnU3Iwhky0VZm9
 jLyFf7Affy4MehkxikN9heBvC8b772phhRhU3H6TPmg/ZKVzUNfLBIOhUTrZHmSP7LJG
 +fPQ==
X-Gm-Message-State: AOAM530dCfDwYxWJt4VxDWvQ5zum3IwQs8YQVp8QsS2XPe9YJOIlOGlJ
 tDUp0GtR1aRaVNhltORrJC7rIiWe0xxZbT94k/zw4PVr
X-Google-Smtp-Source: ABdhPJygOp5Yr8zExGihfOEbjJCZD4XgCmpykSqpnfw/5PP4yIDmdhgzInrd7SJ2f9lqKZ6zU9ylQYBhbv75t8I7mqU=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id
 d27mr11591064ote.132.1607361557545; 
 Mon, 07 Dec 2020 09:19:17 -0800 (PST)
MIME-Version: 1.0
References: <20201207060553.27981-1-tao.zhou1@amd.com>
In-Reply-To: <20201207060553.27981-1-tao.zhou1@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Dec 2020 12:19:06 -0500
Message-ID: <CADnq5_PnJMe54Le-7DNbL9s2VUtDhpH_JbS7pNZJO=hCi8m4eg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: update driver if version for dimgrey_cavefish
To: Tao Zhou <tao.zhou1@amd.com>
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
Cc: Hawking Zhang <hawking.zhang@amd.com>, Chengming Gui <jack.gui@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Jiansong Chen <jiansong.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Dec 7, 2020 at 1:07 AM Tao Zhou <tao.zhou1@amd.com> wrote:
>
> Per PMFW 59.16.0.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/inc/smu_v11_0.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> index c1cb472f8f0f..e5aa0725147c 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> @@ -33,7 +33,7 @@
>  #define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3B
>  #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0xC
>  #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x02
> -#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xD
> +#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xF
>
>  /* MP Apertures */
>  #define MP0_Public                     0x03800000
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
