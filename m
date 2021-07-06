Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36F4C07E96
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 21:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0DFF61C92
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 21:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DFF61C92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 987E06E5BB;
	Tue,  6 Jul 2021 21:44:45 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BD036E037;
 Tue,  6 Jul 2021 21:44:44 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id z3so107861oib.9;
 Tue, 06 Jul 2021 14:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=02NGKANC6bWRviktL9XwvAT8xDpibT4kcz5eISh/RS0=;
 b=Jr+EhbKVszQ7Dl4PYYZKnvaWVb/MSuomxwnEc1wXFqNiUUwIJFdeGCuVKV0BoTFVe4
 1gMXZ43NFBElK2Bha/35aW1zVuwUI40RpETpyPXISezds6jPxZWW/J8zKIp8e8hr0gL6
 gL3cBQ/kKYoRm43yP4kbMfwKEeuH8FuwohI1spoXtreMogVoacJv1LzcN+CT8ckhg4Fp
 W38vLGaVD/csV/Ob6zAgCn0UOORtuej0EzXjMSW1A+MEsZ2ukim95KMkJgBVPLzBXi9g
 l1ApVUqcP62AgYMPkRVI+E1NWiEOPg87QHTDjfnuNFgJq4GuUrOnUHQiT1sPgcgZC7QE
 Tw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=02NGKANC6bWRviktL9XwvAT8xDpibT4kcz5eISh/RS0=;
 b=qvbWaBdKN8q3+Wj/6OuoGcqMKAtvTzgc8kcXXqv5ztTFL90NS7/+JEtubdjkFif3XT
 ZyMMPeajmSQKfk08DJhXOGBuVcwL4Gynyw/e0kvvdLPv7uzjQPCqYrmQUc9ovcJehLut
 5UA0TC2aWGjs9ENw3jw34UQtH//KESZku8ybLBlqyWh2Yb3hOIW74LL41s4L9Qwkh0x/
 OqCsi86J5VIwKrfpadu4enGKQ/NbdTEew5Bp3ElkrgKOTqTrYTaVCHyn/OQ5KESHE7Jj
 XNr9ok3k7UFj53C0hgqDdeEvdoTkOwz55W74cmwBdcEak9o3Pee/GNwph0TtKUreOM+I
 u72g==
X-Gm-Message-State: AOAM530780rl2wdq/bbpi8m9i+kWj/XSw3ElPV4ULLnfcfsJItIoSehm
 UH/Oo1bkny5DYgBBV9MIvxmLK2ESygZi8qVR7IM=
X-Google-Smtp-Source: ABdhPJyJt9TJEJerAMmCKYsbved+w6V/cNsXV68GF6PloP4xXpQNkMpmSAMYxKqeYYk3SHLvNpM8HdrL6BTx20w4ZxY=
X-Received: by 2002:aca:ac15:: with SMTP id v21mr2045269oie.5.1625607883766;
 Tue, 06 Jul 2021 14:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210706111409.2058071-1-sashal@kernel.org>
 <20210706111409.2058071-113-sashal@kernel.org>
In-Reply-To: <20210706111409.2058071-113-sashal@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 Jul 2021 17:44:32 -0400
Message-ID: <CADnq5_ObmVRjwUB5Lw0bLZLL-+=CqvGkJZ+2DY5ZDh+uN-oo0g@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.13 113/189] drm/amdgpu/gfx9: fix the doorbell
 missing when in CGPG issue.
To: Sasha Levin <sashal@kernel.org>
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, "for 3.8" <stable@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 6, 2021 at 7:16 AM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Yifan Zhang <yifan1.zhang@amd.com>
>
> [ Upstream commit 631003101c516ea29a74aee59666708857b9a805 ]
>
> If GC has entered CGPG, ringing doorbell > first page doesn't wakeup GC.
> Enlarge CP_MEC_DOORBELL_RANGE_UPPER to workaround this issue.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This should be dropped.  It was already reverted.

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 516467e962b7..c09225d065c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3673,8 +3673,12 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_ring *ring)
>         if (ring->use_doorbell) {
>                 WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,
>                                         (adev->doorbell_index.kiq * 2) << 2);
> +               /* If GC has entered CGPG, ringing doorbell > first page doesn't
> +                * wakeup GC. Enlarge CP_MEC_DOORBELL_RANGE_UPPER to workaround
> +                * this issue.
> +                */
>                 WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
> -                                       (adev->doorbell_index.userqueue_end * 2) << 2);
> +                                       (adev->doorbell.size - 4));
>         }
>
>         WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
> --
> 2.30.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
