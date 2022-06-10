Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904B0C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 16:06:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E99E710F730;
	Fri, 10 Jun 2022 16:06:12 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BEA710F730
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 16:06:12 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-100eb6f7782so2052401fac.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 09:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gxrSSybFx+Ubi/C2plJx/JcbKO6SA7Oj0NZdpcSPEJM=;
 b=DfUGd5hM2A2RNzoO1UToyxk4nYVZju5CCMKuzJAKWDBixLV/AFfAgl54HE7SePtWeb
 rEdHaAKfKUNvD2YAo+2FMnjccgu3qzuMqfrGaIZaaWqh4WayezM3vXGpDDqLOaS6ag6l
 QqTcBVc5ol+BPBR0hnNb9g6ujlbFnyCteoo8Ob6jmNZEH9YEr3kgNNimUQFTDl3OYkka
 e8S4C157eGYUFnVKeJKKthN9k6nptTYDBkZtdHfFONcA6u6adBn/OaaXgztNl8V9MS20
 kfo7C36BKl1O2FZmDH/f9Zv228rNd0STdceK3ICuKh71uSB6C5VDPi2TpG0ZIfZUIcv2
 rjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gxrSSybFx+Ubi/C2plJx/JcbKO6SA7Oj0NZdpcSPEJM=;
 b=148f/+R9Bunlz8TMntuavDQb542tbwIMk3GSULdm3mWXoTdf7YHX6yFayJjIjxNvud
 xlDZ4jcjJ+sNbWW6jMYOO6zPjGHdWoFBRncmbt4G4mPO/KOXUStRdcOLxxnmY4PFh/KI
 TfP1diioVXxoHT8BfnnofWSJYXgHN5zYASqge+whzTi0/RQjYbIOSsRtU7P5V58Jkvky
 O5rhOxnErJN0wPN2hsBGc8zYwppKc7Ob0dDhGi0CYw+meD2PhVePqF6HGixVEd4cU6nM
 vRE1F3ni9pd7zlE5clkyWDEnJIGxxl3+L/zrcJeDvJKqT2AOlMZ82W2DuPJ4AyRRjCCp
 KTjA==
X-Gm-Message-State: AOAM533bhHkQdi1L29b4lWZJ4wgR2yM8p0MYltuwp1DdZ7IOLXmfRgH6
 yawi+FEGiHE97BLnX79RHJa78me4WK+CVI0HjcA=
X-Google-Smtp-Source: ABdhPJwzxX0fgB6p7eV7HQ56/VxAa7Hc4HQ9eZBzutZaljgYHxn+go7lc9qwUN2AcjjDPCrXUgaNlxIL/aSrTrXIxTA=
X-Received: by 2002:a05:6870:3105:b0:f2:9615:ff8e with SMTP id
 v5-20020a056870310500b000f29615ff8emr274407oaa.200.1654877171316; Fri, 10 Jun
 2022 09:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220610062539.3666611-1-evan.quan@amd.com>
In-Reply-To: <20220610062539.3666611-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Jun 2022 12:06:00 -0400
Message-ID: <CADnq5_OcgNM9_J9_kXuZS96=qHea_XJ7HZdrVPkcsgP1cK61UA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: enable UCLK DS feature for SMU 13.0.0
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Likun Gao <Likun.Gao@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 10, 2022 at 2:26 AM Evan Quan <evan.quan@amd.com> wrote:
>
> The feature is ready with latest PMFW and IFWI.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> Change-Id: I0b1ea6a32bc092eec4b95118a1442597688ee8d0
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index fda89e309b07..495713e4ebd4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -306,6 +306,8 @@ smu_v13_0_0_get_allowed_feature_mask(struct smu_context *smu,
>
>         *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_FW_CTF_BIT);
>
> +       *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_UCLK_BIT);
> +
>         return 0;
>  }
>
> --
> 2.29.0
>
