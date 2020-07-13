Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EC6C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 14:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F0620738
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 14:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCt1QmHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F0620738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97B2F6E0D8;
	Mon, 13 Jul 2020 14:49:16 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2141B6E0D8
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 14:49:16 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id q15so13590593wmj.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 07:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=N81rTeCSNesRP2sx44JYhGEs6k/cd3pAlDxj9uRzv5A=;
 b=NCt1QmHeER8zvW8PIsIckvsxcKXK2Es9IfGU45Co69xUMciefECkoQBHswFGss8VBd
 LfDgfMZqagMjIFglLYtXUvZQYnyhlKTmfg+V8Qs2GK9Tf6ZhEY7s+qaqGPXS4LCrp3Cj
 zmSBIwtKcW3q5zkgrP5fFnxQPZ2BtW8eydtDf0O8x13Jtk1ZWREOz8JFYrteKCyf1Ukd
 Klm9xfCR6xSTSuRfot9yULbdCZSeQhlorJvd/etYlvPrz9y0S51lPVTyM0N9LDtC5I1O
 nBI2sU6HawvOODzc6GbsXJPHtnSf7la0t59KUvW1sn6rnlXuoFNqV0Vy8TTHclXNlkcI
 NPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=N81rTeCSNesRP2sx44JYhGEs6k/cd3pAlDxj9uRzv5A=;
 b=HXSKO2yOlaaig/6jVhO1v3nUSVbta1zogvoOBZweTykniAyt+7XQn77j+zBZ0eZIG2
 CRAvY2MhY14+P9ahJ2Dpgq33gRqrfAAl9ajXI+0p7bNtBHC5HceGfmYFNxxqS30HypPD
 hatcqz9/I/3+6YkMcPSKEN3F55YuWkEQwyexO+kXNcnAiMC1abgObPrjcTlDrefHjsKe
 20AX6rE/kbNdLwEIa9E685BO7xADLnGHYdRur84LauDFJSn6SuMuWwH37L+6zJPVP6Jb
 pW01CM/D7lKN+SafpRYHyTcKuGrbaYiIgexdA6MZnz2rU59h3jj8A1iDAJP8NFuJLAPx
 kdOA==
X-Gm-Message-State: AOAM533KD+yNF3FBr9zr6532mmj05cw6swU/q8tEfsDwag01kFBLYmOK
 x4HRttKTT36ly63dsTQ8zwLIU9NcuKjISyaDkYg=
X-Google-Smtp-Source: ABdhPJxE4eZqZYy5Bq9ABHeISVrBHd1K1/VxtaZolMaULBVmAVLdErzvTTFkucHhPYs+TleT6676Q2cUnGllRIu6dJY=
X-Received: by 2002:a1c:dd09:: with SMTP id u9mr319866wmg.70.1594651754787;
 Mon, 13 Jul 2020 07:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200710044746.23538-1-evan.quan@amd.com>
 <20200710044746.23538-2-evan.quan@amd.com>
In-Reply-To: <20200710044746.23538-2-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jul 2020 10:49:03 -0400
Message-ID: <CADnq5_My6XQO03_ahWUWqEOFWKzF+x3T+Yrongyi+hya=cryeQ@mail.gmail.com>
Subject: Re: [PATCH 02/16] drm/amd/powerplay: implement a common set dpm table
 API for smu V11
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jul 10, 2020 at 12:48 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Maximum the code sharing around smu V11.
>
> Change-Id: Ice0a874f3f70457f1012ca566f9f784ff3e9cd94
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  4 ++
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 38 +++++++++++++++++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> index 289c571d6e4e..14d6eef8cf17 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> @@ -285,6 +285,10 @@ int smu_v11_0_get_dpm_level_count(struct smu_context *smu,
>                                   enum smu_clk_type clk_type,
>                                   uint32_t *value);
>
> +int smu_v11_0_set_single_dpm_table(struct smu_context *smu,
> +                                  enum smu_clk_type clk_type,
> +                                  struct smu_11_0_dpm_table *single_dpm_table);
> +
>  int smu_v11_0_get_dpm_level_range(struct smu_context *smu,
>                                   enum smu_clk_type clk_type,
>                                   uint32_t *min_value,
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 03be59492af1..7206b9f76042 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1951,6 +1951,44 @@ int smu_v11_0_get_dpm_level_count(struct smu_context *smu,
>                                                value);
>  }
>
> +int smu_v11_0_set_single_dpm_table(struct smu_context *smu,
> +                                  enum smu_clk_type clk_type,
> +                                  struct smu_11_0_dpm_table *single_dpm_table)
> +{
> +       int ret = 0;
> +       uint32_t clk;
> +       int i;
> +
> +       ret = smu_v11_0_get_dpm_level_count(smu,
> +                                           clk_type,
> +                                           &single_dpm_table->count);
> +       if (ret) {
> +               dev_err(smu->adev->dev, "[%s] failed to get dpm levels!\n", __func__);
> +               return ret;
> +       }
> +
> +       for (i = 0; i < single_dpm_table->count; i++) {
> +               ret = smu_v11_0_get_dpm_freq_by_index(smu,
> +                                                     clk_type,
> +                                                     i,
> +                                                     &clk);
> +               if (ret) {
> +                       dev_err(smu->adev->dev, "[%s] failed to get dpm freq by index!\n", __func__);
> +                       return ret;
> +               }
> +
> +               single_dpm_table->dpm_levels[i].value = clk;
> +               single_dpm_table->dpm_levels[i].enabled = true;
> +
> +               if (i == 0)
> +                       single_dpm_table->min = clk;
> +               else if (i == single_dpm_table->count - 1)
> +                       single_dpm_table->max = clk;
> +       }
> +
> +       return 0;
> +}
> +
>  int smu_v11_0_get_dpm_level_range(struct smu_context *smu,
>                                   enum smu_clk_type clk_type,
>                                   uint32_t *min_value,
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
