Return-Path: <SRS0=jeuu=7X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F75C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 13:43:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ABAF20734
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 13:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pp3EeVHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ABAF20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3E9789DDF;
	Wed, 10 Jun 2020 13:43:18 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C26D289E98
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2020 13:43:16 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id p5so2319930wrw.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2020 06:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MGiunoNygRsunQkGEDNB1Dpke6Q2VDzZatyNof89Nx4=;
 b=pp3EeVHBhQiSvb1iSTWVF5FBeaWTmyfYIdpUcDdjYjMjl6lJuJ/PKTN6liq38vm4Fa
 oZniulmuAp4KP7gOtok8j/vb4gN0QvY/Rq1LakuktFEk63njNkNtSfgZeYuO5yDm/+bg
 +NcNA16YsYBg/yS0vrT3F5gx4DFrQjXBUGK3TiPVzUNY8hur6cwrkWPVfuTgMu+ElOCE
 Y9RL1HZcKmwSLWqlYGbcJtP5/G7R+rW+wpmkSOGnw+i9H5YjkxCHhj2ysdwwkceSFzbE
 0nBa93Obd2qaCNUX/K3O5hPymwCO1f/YG4Tqpftod98I/22Z+4yZ4IE+CEPyjO/TYqXA
 JnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MGiunoNygRsunQkGEDNB1Dpke6Q2VDzZatyNof89Nx4=;
 b=pMpcV+FAbTSQfc1H2OrAMmHuq101DAHJbVA3RpRyDoGFP7fTH00gszmBibVJaaP7Jj
 /xDyjkVJYd4pcRUqNazYgwciB550RjNvMQAyyyWJBGpQTTAMcs0ZMEfJWboFaFBN90Ud
 2YfZO13DFlBEh6aoZlum1Hym1yvAt82ybZR1EVQuoiH3FUGWCWthl79o+tGE+oBAZO8k
 ywxV71+dfOlSjwV2Q+NF23fTk20iTlxMim06bsdvDJXaiynHBGMZBXQYv3rvkmSACDV6
 /n/aA4xUp0IOBjSf+FV8DwGdZytANJEDO0sWvMJpLoPf2Vpl3E9VodyZptFsFa0BeWyP
 RQTg==
X-Gm-Message-State: AOAM530a7c9lyS3KTCyCmYMcNyKxqigIfMmzFXy0RH014N/vlrkvAxXd
 RnuQUFxHkIXNrR5nZ5/PRjyD52pFp2vZtiR7DLw=
X-Google-Smtp-Source: ABdhPJzroB5rIUeD5XLedtgcoY8LSAe954Oafhq9JfsSOBKO3gl98N5D5iaAxyGohadJBYsXRu5EM2aSL8gDA5N2igM=
X-Received: by 2002:a05:6000:1003:: with SMTP id
 a3mr3742901wrx.111.1591796595312; 
 Wed, 10 Jun 2020 06:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <1591356897-26869-1-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1591356897-26869-1-git-send-email-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 Jun 2020 09:43:03 -0400
Message-ID: <CADnq5_PBdXS9grsaSNxaFuE9x+WMR6w5wBsb9jFdKb1+Ss_Ufw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix the nullptr issue as for PWR IP not
 existing in discovery table
To: "Prike.Liang" <Prike.Liang@amd.com>
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
 Huang Rui <ray.huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Jun 5, 2020 at 7:35 AM Prike.Liang <Prike.Liang@amd.com> wrote:
>
> fix e467ab869f57 drm/amdgpu: use IP discovery table for renoir.
>
> This nullptr issue should be specific on the Renoir series during try access the PWR_MISC_CNTL_STATUS
> when PWR IP not been detected by discovery table. Moreover the PWR IP not existing in Renoir series is
> expected therefore just avoid access PWR register in Renoir series.
>
> Signed-off-by: Prike.Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 22943773..6b94587 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2856,8 +2856,8 @@ static void gfx_v9_0_init_gfx_power_gating(struct amdgpu_device *adev)
>                 /* program GRBM_REG_SAVE_GFX_IDLE_THRESHOLD to 0x55f0 */
>                 data |= (0x55f0 << RLC_AUTO_PG_CTRL__GRBM_REG_SAVE_GFX_IDLE_THRESHOLD__SHIFT);
>                 WREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_AUTO_PG_CTRL), data);
> -
> -               pwr_10_0_gfxip_control_over_cgpg(adev, true);
> +               if (adev->asic_type != CHIP_RENOIR)
> +                       pwr_10_0_gfxip_control_over_cgpg(adev, true);
>         }
>  }
>
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
