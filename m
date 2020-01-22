Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71101C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 20:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ADDB21835
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 20:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jScAA0k2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ADDB21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 069696F630;
	Wed, 22 Jan 2020 20:41:53 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 028F76F630;
 Wed, 22 Jan 2020 20:41:51 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id z3so576716wru.3;
 Wed, 22 Jan 2020 12:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Qdw7JpRHyaMu3FUJiTZyQrT3wWOYBrtmMuNGKfuANjs=;
 b=jScAA0k2ZSjJRzVDFGf6AVQaoZ7/K1FY8CbHEEq90AxBjy8ekR+45JRmO/0ZKdk6Kg
 HolN58FsABXvX0tQf6WilrBiNniN3MpjjigZRCj1XWp6C3eoivzbOklHINFEi8OL27jA
 X/DcKqhcH06lbEgqyARvuwGz/wNp2nJtn9jaPeEOGrEQrf+Ydlpp0V8yOVIwDCgaIELO
 fpA+MMeLLeLdDrGVu+xkHENnXqBZId0cRJOm0Xf5hCxio4w+J/s2MGxiZytyw/V8RC11
 Q2TUAjl8j39xITxRmKmcsMj5v05+OEtLstxXpmGZ12q+ax31L0QUT09p9+gOBbolA1u2
 cosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Qdw7JpRHyaMu3FUJiTZyQrT3wWOYBrtmMuNGKfuANjs=;
 b=RYgJOOowGi5bdZdeXfakvZxOqCr7ZuZCfdQ54YKHq+R2POrG++TqlUgHllAGRVTb8s
 IhWLHI+FsCVO4KACjvg1jC0ehyVM8P3/QSkupTMxjNPpzGUeVxHklzpVf7DMt+3Zoz6G
 KaOb61ZskX4TqkFuXpKoEcOMixpOk3PQchFpI9dTqJL2QnxvFF+gPP+5ymKyAApAhC7j
 kofz6yZOi9qW4FVmI+ZmNzKpUyFvQhmDpBmAW2LHMaFC/9cKsa74T883k3JyFpMJsTyP
 lrPmwIrTI63F8cixdhwTktT5VZr/FQ8Gb9cLk96iAcISG8ylgmjksHjo8dRHmctD48wn
 d6Dw==
X-Gm-Message-State: APjAAAVm4U445rY4aeOOsIdZgedgLg5XO0MNOgyL6oaSxlA5YpBnZIis
 LTh25tQa5+VmOI/hZngSNj8X4Pjmqk1Pl6DYxtc=
X-Google-Smtp-Source: APXvYqyhX1wOGJFOsB5ufkPnKOsAev6KnrN0YHJmFBY/gUCypnbvRr913/FnV7MjADfTHjvVFEG82onnpl23B2MXdFE=
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr13775560wrn.124.1579725710701; 
 Wed, 22 Jan 2020 12:41:50 -0800 (PST)
MIME-Version: 1.0
References: <1579679591-116290-1-git-send-email-zhengbin13@huawei.com>
In-Reply-To: <1579679591-116290-1-git-send-email-zhengbin13@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 Jan 2020 15:41:38 -0500
Message-ID: <CADnq5_MOy+spK8MO8Sw96DOz6tstRBeDm-ZMGd8VNxN21sZBBQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: use true,
 false for bool variable in smu7_hwmgr.c
To: Zheng Bin <zhengbin13@huawei.com>
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
Cc: Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 22, 2020 at 3:22 AM Zheng Bin <zhengbin13@huawei.com> wrote:
>
> From: zhengbin <zhengbin13@huawei.com>
>
> Fixes coccicheck warning:
>
> drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c:723:2-50: WARNING: Assignment of 0/1 to bool variable
> drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c:733:3-52: WARNING: Assignment of 0/1 to bool variable
> drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c:747:3-51: WARNING: Assignment of 0/1 to bool variable
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> index d70abad..bf04cfe 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> @@ -720,7 +720,7 @@ static int smu7_setup_dpm_tables_v0(struct pp_hwmgr *hwmgr)
>                 data->dpm_table.vddc_table.dpm_levels[i].value = allowed_vdd_mclk_table->entries[i].v;
>                 data->dpm_table.vddc_table.dpm_levels[i].param1 = std_voltage_table->entries[i].Leakage;
>                 /* param1 is for corresponding std voltage */
> -               data->dpm_table.vddc_table.dpm_levels[i].enabled = 1;
> +               data->dpm_table.vddc_table.dpm_levels[i].enabled = true;
>         }
>
>         data->dpm_table.vddc_table.count = allowed_vdd_sclk_table->count;
> @@ -730,7 +730,7 @@ static int smu7_setup_dpm_tables_v0(struct pp_hwmgr *hwmgr)
>                 /* Initialize Vddci DPM table based on allow Mclk values */
>                 for (i = 0; i < allowed_vdd_mclk_table->count; i++) {
>                         data->dpm_table.vddci_table.dpm_levels[i].value = allowed_vdd_mclk_table->entries[i].v;
> -                       data->dpm_table.vddci_table.dpm_levels[i].enabled = 1;
> +                       data->dpm_table.vddci_table.dpm_levels[i].enabled = true;
>                 }
>                 data->dpm_table.vddci_table.count = allowed_vdd_mclk_table->count;
>         }
> @@ -744,7 +744,7 @@ static int smu7_setup_dpm_tables_v0(struct pp_hwmgr *hwmgr)
>                  */
>                 for (i = 0; i < allowed_vdd_mclk_table->count; i++) {
>                         data->dpm_table.mvdd_table.dpm_levels[i].value = allowed_vdd_mclk_table->entries[i].v;
> -                       data->dpm_table.mvdd_table.dpm_levels[i].enabled = 1;
> +                       data->dpm_table.mvdd_table.dpm_levels[i].enabled = true;
>                 }
>                 data->dpm_table.mvdd_table.count = allowed_vdd_mclk_table->count;
>         }
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
