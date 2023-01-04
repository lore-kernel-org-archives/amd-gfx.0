Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE48C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 14:32:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FB8210E0EB;
	Wed,  4 Jan 2023 14:32:11 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D27F110E0EB
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jan 2023 14:32:09 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 l8-20020a056830054800b006705fd35eceso20838237otb.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Jan 2023 06:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jPq1bDlnLKiy44Y5Vwf5RpdBPmkKUEUhfpq9xfKF39s=;
 b=B5qEtZkJAhGThcZWHz8cKKi21OgNcyxhMMEjOilVkxK5HZOziJeTOq1jaI66TZoz66
 VUCPc1bpCbpyPJpqw4TFAud/XKld3rI48U20GEn1Piry9PzodRRxspA9sYCu7HEeTPy9
 yA/tJlamKsMqZ6lRUeM75wIOdt6MN+hx+BbFoxs71gfO8aEW8ue+pygL1WSOWi5HwW5C
 5904ZrTI2LMg1gT5+WURDFMA48joc9jzC5zO8/OE4aQ7Q/5ibiRb9COMRHy0WELBQWr/
 l0pxMrohZdcRsrWhQHZxdMjssSnD8pvDe+UvISHBh/zKC8NpNX/CmZ+tY0uPqgu1JXKH
 S7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jPq1bDlnLKiy44Y5Vwf5RpdBPmkKUEUhfpq9xfKF39s=;
 b=hiqYn63SvDuo4ScKMiR9bLujWVwrj+md95JOTDHnyQgGTZpE6FzREi2UDdRIyiUILu
 81yW64jzgABEc69k/Mq4HnSud9jXtesFriT1q6h4ZKHlmlEgHItmt6lixmrzqEhjFJao
 qrY6SGpADYs7FnO1In/6ZUEEnw/5QCmoJ+fJdL0CzfdZNX3RzSd5CqbOQn1Jjl/zzUY7
 G+Xki/8G/Stgr1eVcLe/nh8DgCGPoMcJLrrECd2ML3x0vDVgSzuSJOv4087CflMDaAKY
 sgbrwZP4toMv0PyXWtRKy/S2g8OGxIHjbisXUrz2eYCqdF7iIUBt3NHEKkAd2Pfwpu8K
 1v0g==
X-Gm-Message-State: AFqh2kqRDkoQqBJTblXy3pi0TMNJsBqvcU8kQbcIhKsPzzSlthJd/r77
 9+WC0KC6uYr3uBjaa1m9/SbZuVxUMc/Mmp1Td7U=
X-Google-Smtp-Source: AMrXdXuJmTJi64qFcdwqgAhEsCq6ulFMyh6m4Pe4oN12dvQ/ntCjFWMgJ7uWSeMycLK80xzoIDDGzmdJZ3rfP8auefs=
X-Received: by 2002:a9d:62d1:0:b0:675:cde9:90b9 with SMTP id
 z17-20020a9d62d1000000b00675cde990b9mr3128717otk.123.1672842728961; Wed, 04
 Jan 2023 06:32:08 -0800 (PST)
MIME-Version: 1.0
References: <20230104063623.3674474-1-evan.quan@amd.com>
 <20230104063623.3674474-2-evan.quan@amd.com>
In-Reply-To: <20230104063623.3674474-2-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Jan 2023 09:31:57 -0500
Message-ID: <CADnq5_MsZK5ATAQ426PyB_e0z-YXSyXR8kD_UtfRLk-vAJCJXA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: add the missing mapping for PPT feature
 on SMU13.0.0 and 13.0.7
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

On Wed, Jan 4, 2023 at 1:36 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Then we are able to set a new ppt limit via the hwmon interface(power1_cap).
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: Ife80277f89065aa8405715e7ae21fb20be7eb706
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 1 +
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index aebdd9747c37..969e5f965540 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -213,6 +213,7 @@ static struct cmn2asic_mapping smu_v13_0_0_feature_mask_map[SMU_FEATURE_COUNT] =
>         FEA_MAP(SOC_PCC),
>         [SMU_FEATURE_DPM_VCLK_BIT] = {1, FEATURE_MM_DPM_BIT},
>         [SMU_FEATURE_DPM_DCLK_BIT] = {1, FEATURE_MM_DPM_BIT},
> +       [SMU_FEATURE_PPT_BIT] = {1, FEATURE_THROTTLERS_BIT},
>  };
>
>  static struct cmn2asic_mapping smu_v13_0_0_table_map[SMU_TABLE_COUNT] = {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 5c6c6ad011ca..e87db7e02e8a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -192,6 +192,7 @@ static struct cmn2asic_mapping smu_v13_0_7_feature_mask_map[SMU_FEATURE_COUNT] =
>         FEA_MAP(SOC_PCC),
>         [SMU_FEATURE_DPM_VCLK_BIT] = {1, FEATURE_MM_DPM_BIT},
>         [SMU_FEATURE_DPM_DCLK_BIT] = {1, FEATURE_MM_DPM_BIT},
> +       [SMU_FEATURE_PPT_BIT] = {1, FEATURE_THROTTLERS_BIT},
>  };
>
>  static struct cmn2asic_mapping smu_v13_0_7_table_map[SMU_TABLE_COUNT] = {
> --
> 2.34.1
>
