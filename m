Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8E3C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Feb 2022 03:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACD8110EA83;
	Thu, 24 Feb 2022 03:47:40 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74E9310EA83
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Feb 2022 03:47:39 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 x6-20020a4a4106000000b003193022319cso1711757ooa.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 19:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G87esWkzbZRP9GiITdqxSywDotzpRJlio8CRb3b2BOk=;
 b=X9Vrxl9IX5QDIyQ4peJjlbLVbe8dGSz8ChS+PHIrj0kWuh4llvF1Hsbx/JyNzRJIgr
 b1WMMonOnNgHWylFml27JqRmn17dZJKdcSnbdESi8DboBJ7on5TanfnTycYkgWgyThDC
 u2lLhKzb7lV8cmqcML5QAHC9Xo6jikrG1Nwz7jVnA0cx+k1hk4h3Mvt+WREg0REfku29
 irT6aGlF3jhuVIoVyQUgE1UEHiw053Qpz6AZPMUi19ZmbMSuvdancmuZ5T73vh1FZg/w
 4yqaPrhxHGs52l3pNy3qCMi/ieM+k81/mTE/CYtxl3aGd3PcccXhrUU94lldBJzCKE6x
 KXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G87esWkzbZRP9GiITdqxSywDotzpRJlio8CRb3b2BOk=;
 b=v5cBtJxDsFlsLC1TsxE0bRerBsEzDCeOPaGUwNW6IU6HIPLM+aZdeijeODv2P3CiHz
 qJx6ZyIAf8/t08Fsbvh1wn2IXfa+uxW6B9CRFJWy6r9oqZZ9XiDZs3aUEQCM4FNZTuIi
 W4VfweZnb60CeinZ6n1mNpMfMuWoz32FpAprl29lPbnP5piWLWSv5lGcK5Cc7WKVxW7s
 x2AtVjDUSIhr3i67ySeDrCYyq/+v369IUPl9T5ZS/rShGHkg/K3WCMMSLHIE6NegVSxB
 uoPUStWj5p/bkRZGG8NdRSNBE1v2/0xIVsozP2pShDF+uvJYSO5+fGaTfxZO3u7qZqyc
 om9w==
X-Gm-Message-State: AOAM5322pGt/cQewepuHg4XBjbnNOksf/vbraEv/eCrUuckOR7J5nmIl
 gMDw1ZfmDe3e/0bmuESqA6aYOe/AL+kfSC1wWqtP4xxI
X-Google-Smtp-Source: ABdhPJyBBwMhW/u+p4eN5mKAQ9UEtLuoahHaHYdbLeP+mSVTYrNmcmdXc76lCEpXamaGwDXmgaIoHbPWqT5slYZ42zk=
X-Received: by 2002:a05:6870:912c:b0:d3:44be:7256 with SMTP id
 o44-20020a056870912c00b000d344be7256mr345169oae.73.1645674458695; Wed, 23 Feb
 2022 19:47:38 -0800 (PST)
MIME-Version: 1.0
References: <20220224034543.1631630-1-yifan1.zhang@amd.com>
In-Reply-To: <20220224034543.1631630-1-yifan1.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 23 Feb 2022 22:47:27 -0500
Message-ID: <CADnq5_NRKSB3rBXhDE2XNAt+6zjJ+mWz37BOFFiftx=7CW7r+g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix mode2 reset fail for smu 13.0.5
To: Yifan Zhang <yifan1.zhang@amd.com>
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
 Huang Rui <Ray.Huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 23, 2022 at 10:46 PM Yifan Zhang <yifan1.zhang@amd.com> wrote:
>
> SMU MSG index should be used as parameter.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> index 093b9144464b..8ee5bcb60370 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> @@ -245,14 +245,9 @@ static int smu_v13_0_5_post_smu_init(struct smu_context *smu)
>
>  static int smu_v13_0_5_mode_reset(struct smu_context *smu, int type)
>  {
> -       int ret = 0, index = 0;
> -
> -       index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
> -                               SMU_MSG_GfxDeviceDriverReset);
> -       if (index < 0)
> -               return index == -EACCES ? 0 : index;
> +       int ret = 0;
>
> -       ret = smu_cmn_send_smc_msg_with_param(smu, (uint16_t)index, type, NULL);
> +       ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset, type, NULL);
>         if (ret)
>                 dev_err(smu->adev->dev, "Failed to mode reset!\n");
>
> --
> 2.25.1
>
