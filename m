Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7004C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Dec 2022 14:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E40010E0AA;
	Mon, 12 Dec 2022 14:08:38 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7575C10E0AA
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Dec 2022 14:08:35 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1433ef3b61fso8425558fac.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Dec 2022 06:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QtabaoijtdM+ClQpxzvyzm6Pvo4eTO1BPOVfXs1ZhyQ=;
 b=GFZscnkozAw7KQ+6JHUv5cV29wT5N8Zq+XVo7EOqtqlAa3IXG2V9BY2MqAlFiFqwXq
 Np2cxR2Z67GUe6U+Mcj7rRUp13UgOdYFYXESq0kvWqZugSW76svvX4gozsIb0IdBcqhn
 CCMRHOLWXV2gnIpCG5jHjoCfGQA0tqMbff2pn46U6gPlWfjPBTm9LFUbGbg3rkV1WfVU
 qWcGmk2pxpO6KJPMqNEF5831tyr6YBUM8ohJ10THT5EXHd4mR6qmHfFWfbpIEy9qCAL/
 rjrPic7bVA7Ex76zOyC+pUtIVKTWV37uvRNPw300L7Xu/T7doBG2hYadXhu9+2MCGRwD
 97lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QtabaoijtdM+ClQpxzvyzm6Pvo4eTO1BPOVfXs1ZhyQ=;
 b=MPDsiy1j3YLC0bNkCilrFJ5Y7wUDgdMZSwR+FrO5hd2GuUYnIrN0w4b0zSGtyzC396
 DWx69KOvd258d1uQzgPiMbKAOd7RpFZkqkrcy8zVtuas++qenr5Rf+2yjJkwDGtCaiVy
 l8JZoV9VkuR7hJGNqgC96ny/LJyAh/8neEJvtuX+dQ9OxvCCgSTlk9X8RGPY26fFV23N
 rfvnAqj417alzY/cdT/g7hLO04IarAf/NiV7kJQKgVuPcyyupo2IV6KtYhXeJeusrnLR
 lZqhMJ36ouK2OFZoAUj2P+pYxkHgJKGj2Ma6pqFbW4lV7Yy169oYAL4IBLYpLxEFcGnL
 FKsw==
X-Gm-Message-State: ANoB5pn/V8zEJAjliDSCJRasprE0Psm1izJcSCxPJ22UsbvTHxIJ6Ygr
 NmI71gSdPU06WQz4Ei9H+jGFBLyjh80UbzUf0xk=
X-Google-Smtp-Source: AA0mqf4GHNK7JMNQx1cBAMppdl/QlWwvFzGWGn2af35+jduZGd2sQCMX8cGIysq5LVUg4bMuCsS1Nc8P8A25QwpVuk0=
X-Received: by 2002:a05:6870:ac8b:b0:148:3c8f:15ab with SMTP id
 ns11-20020a056870ac8b00b001483c8f15abmr411771oab.46.1670854114586; Mon, 12
 Dec 2022 06:08:34 -0800 (PST)
MIME-Version: 1.0
References: <20221212084422.3850479-1-evan.quan@amd.com>
 <20221212084422.3850479-2-evan.quan@amd.com>
In-Reply-To: <20221212084422.3850479-2-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 12 Dec 2022 09:08:23 -0500
Message-ID: <CADnq5_OV_iVxDsDrnwfSFFsg7VEV7SjOpe3KBS-zt8iNwnMvPg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: add missing SMU13.0.7 mm_dpm feature
 mapping
To: Evan Quan <evan.quan@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, Dec 12, 2022 at 3:44 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Without this, the pp_dpm_vclk and pp_dpm_dclk outputs are not with
> correct data.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: Idef7d0b1778fc4b900945c9f221787b4fa5b730a
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 81036d57b598..5e937e4efb51 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -190,6 +190,8 @@ static struct cmn2asic_mapping smu_v13_0_7_feature_mask_map[SMU_FEATURE_COUNT] =
>         FEA_MAP(MEM_TEMP_READ),
>         FEA_MAP(ATHUB_MMHUB_PG),
>         FEA_MAP(SOC_PCC),
> +       [SMU_FEATURE_DPM_VCLK_BIT] = {1, FEATURE_MM_DPM_BIT},
> +       [SMU_FEATURE_DPM_DCLK_BIT] = {1, FEATURE_MM_DPM_BIT},
>  };
>
>  static struct cmn2asic_mapping smu_v13_0_7_table_map[SMU_TABLE_COUNT] = {
> --
> 2.34.1
>
