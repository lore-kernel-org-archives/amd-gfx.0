Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84234C2D0CA
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 22:36:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5855E22527
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 22:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmVkTx3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5855E22527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A98686E21F;
	Thu, 12 Dec 2019 22:36:02 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D00EA6E21E;
 Thu, 12 Dec 2019 22:36:01 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id d73so4161779wmd.1;
 Thu, 12 Dec 2019 14:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7ZC6V8vQF8U9+ro8xLo3meGZOer4fQgS0VnuTo8ZafQ=;
 b=gmVkTx3PNVS6vZfikSxq/vX+wmzj69MGa59qpbY2NWl3EvOhPqTOPWWmeGFZ4u5nNK
 k+iPsYmBoYn2jmm2gMhsL+DOW/p0+hBBLkXrXnl2Gue29VucKHDwHs9wXEOG4FlnXeCu
 EW2GY9uAHV3RCg5lDvrbeYFFf9HccOBVQuTXkk1gZi6N8LdmjxXF7vLXEawFXGUFcvNG
 7NXTmCHO45+OuRd9ORl3FDLdwoiGL4w6UPvATpFbP50hOGvBouxIXxhrGBYCM9Z2uDYm
 tIAXb3IKiLbvKEpArALrY0XijHMUTQ0ngJRjcTXkZlG0cVcURV/0mPSIlz7DRCqbc4HB
 NsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7ZC6V8vQF8U9+ro8xLo3meGZOer4fQgS0VnuTo8ZafQ=;
 b=ZObjfggwZeQOmvbcuPlJGruDWF4zKDhHpqGCLrjdvcLo0m/Wk8OgC8aMlavuZFv3Lm
 mBJkh+UrQwCryEnQRDlBgWohyddmuzR9z1alXvW+o4zQJWiggbXlqh96HDtxPgKDt5C0
 vFg71+r2oFcRo+k9iPq6UBaEd0I2a7mXSizeR9OSHJVbZPFT7u9yz/5SB4e0GPCN2vhR
 hltNHGFeXEau70QYwwYeGColOM/B+RD9hnQSRF7DM+3HagCUyUphqclo2eUdWdHShUlB
 4aoYCrDKtrMw5INfgLfUelcMWB10y8/SQi+4RBgsSDWg9QUGYmHM3DCCKJ63bsp52kDw
 r40w==
X-Gm-Message-State: APjAAAWSyVZhW46ODLv0y/xWe/xtQPFp27jyWp9jNTYryJhKP1TSPVOC
 kl0aSkwi+OFmNh+rucQTqGTS7EDO4eslbcY8/mk=
X-Google-Smtp-Source: APXvYqyLeeOFUEZADqvzUcHggdMQXLsgjtOr/m/4Zvbn8hRhUCgqU1csOP5xuGbzFDCXTv1TVSbMTLSXF/7P5SsNVSc=
X-Received: by 2002:a1c:6404:: with SMTP id y4mr4901765wmb.143.1576190160417; 
 Thu, 12 Dec 2019 14:36:00 -0800 (PST)
MIME-Version: 1.0
References: <20191212181657.101381-1-colin.king@canonical.com>
In-Reply-To: <20191212181657.101381-1-colin.king@canonical.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Dec 2019 17:35:48 -0500
Message-ID: <CADnq5_PXb035J7yyfX1gB3oNsVQb-L=KZHR31KxLEH-VUZfT8g@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/powerplay: fix various dereferences of a
 pointer before it is null checked
To: Colin King <colin.king@canonical.com>
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
Cc: David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
 kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Yintian Tao <yttao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 12, 2019 at 1:17 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There are several occurrances of the pointer hwmgr being dereferenced
> before it is null checked.  Fix these by performing the dereference
> of hwmgr after it has been null checked.
>
> Addresses-Coverity: ("Dereference before null check")
> Fixes: 8497d2bcdee1 ("drm/amd/powerplay: enable pp one vf mode for vega10")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/amd_powerplay.c |  6 +++---
>  drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c   | 15 +++------------
>  2 files changed, 6 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> index 5087d6bdba60..322c2015d3a0 100644
> --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> @@ -275,12 +275,12 @@ static int pp_dpm_load_fw(void *handle)
>  {
>         struct pp_hwmgr *hwmgr = handle;
>
> -       if (!hwmgr->not_vf)
> -               return 0;
> -
>         if (!hwmgr || !hwmgr->smumgr_funcs || !hwmgr->smumgr_funcs->start_smu)
>                 return -EINVAL;
>
> +       if (!hwmgr->not_vf)
> +               return 0;
> +
>         if (hwmgr->smumgr_funcs->start_smu(hwmgr)) {
>                 pr_err("fw load failed\n");
>                 return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
> index e2b82c902948..f48fdc7f0382 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
> @@ -282,10 +282,7 @@ int hwmgr_hw_init(struct pp_hwmgr *hwmgr)
>
>  int hwmgr_hw_fini(struct pp_hwmgr *hwmgr)
>  {
> -       if (!hwmgr->not_vf)
> -               return 0;
> -
> -       if (!hwmgr || !hwmgr->pm_en)
> +       if (!hwmgr || !hwmgr->pm_en || !hwmgr->not_vf)
>                 return 0;
>
>         phm_stop_thermal_controller(hwmgr);
> @@ -305,10 +302,7 @@ int hwmgr_suspend(struct pp_hwmgr *hwmgr)
>  {
>         int ret = 0;
>
> -       if (!hwmgr->not_vf)
> -               return 0;
> -
> -       if (!hwmgr || !hwmgr->pm_en)
> +       if (!hwmgr || !hwmgr->pm_en || !hwmgr->not_vf)
>                 return 0;
>
>         phm_disable_smc_firmware_ctf(hwmgr);
> @@ -327,13 +321,10 @@ int hwmgr_resume(struct pp_hwmgr *hwmgr)
>  {
>         int ret = 0;
>
> -       if (!hwmgr->not_vf)
> -               return 0;
> -
>         if (!hwmgr)
>                 return -EINVAL;
>
> -       if (!hwmgr->pm_en)
> +       if (!hwmgr->not_vf || !hwmgr->pm_en)
>                 return 0;
>
>         ret = phm_setup_asic(hwmgr);
> --
> 2.24.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
