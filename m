Return-Path: <SRS0=+8vs=BO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3D8C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 20:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6843D20842
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 20:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arTwSqcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6843D20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 123B16E08C;
	Tue,  4 Aug 2020 20:42:13 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F12C56E08C
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2020 20:42:11 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id z18so35070769wrm.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Aug 2020 13:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L8gwaxJkBpkORq+gilMOrNJQX0Ly2m3f/Oy0HkuC0Hg=;
 b=arTwSqcTL1jAS2LOqziSMEWpqYYuoS9cYNt8V9qWTZqvw9lnILeGuSaDYanrY2zrq9
 chEXYn1fAtNxJyjixtAEXe+8PbLIOiTShHfms8xQa1wgPHVA3t2edJgJwVqzjkiZuCJY
 qmuyQ6ZCXGQN7jhwQLdaoTcwParJgyVNug/JnASZWI4GCwO8KI0MwgAXGR6QN33+VAdW
 2COwenRoFAdVp9IEMBfAtNEtW0psW/9IOT8YhxtAFLjAlOGOBzgO/KW19xc6isSfBQ7M
 X0mKPX5b1jFcDiABwItAzzVgFOJKtWCmyCwHVdivjtpLefwZywpHxZVCR0NKiAQ8zrhp
 GIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L8gwaxJkBpkORq+gilMOrNJQX0Ly2m3f/Oy0HkuC0Hg=;
 b=OE2jZoo4w1PUXISHd8aJW9tr/nRitBFu23oos3+RJqX+XmXKaseXLrboRb+35oxH54
 LjkFJNSVREBgwui6UwEeviK3OKMblHnhwIg4BKCx4L299uoQ6NBklmNIL4sYtdZtqQYb
 MI82fiFMkKiqSXQzXB3inLha4K8GLmN670CrNafkwNGiIOWmyve0ARo5mn0pjwU44HF6
 32XFUYhl6w2zsSV+nz0JAdBTk8v1EpmHWSfZlWfGS91cEvXXe+J+Ptp7HeSzB7RnOvBY
 bWGjqTNx4+SN2sgnrOidmYH/5NiuttUV1HKFSM0ufS1SdFkP1XzkGRuXH09y5mD7r646
 syfg==
X-Gm-Message-State: AOAM53112VNPBw8hZSEYHqbcZy5lE2PFsOAIy87kkCRLrEx7VHQAC7V3
 AgiJeRJCSqwKZ2SKoiCvy7LvW/qSZloDTNqBE0M2Ww==
X-Google-Smtp-Source: ABdhPJwGZcT1UHa99gYyX0mhrJYOinCGiVZYnpEnhlTZuyS9jNvnZI1l2bPFhkpzNa4Bsde0ZDOeG8eeME7Huvfarkg=
X-Received: by 2002:adf:fd41:: with SMTP id h1mr22393979wrs.124.1596573730631; 
 Tue, 04 Aug 2020 13:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200731024316.28324-1-evan.quan@amd.com>
 <20200731024316.28324-17-evan.quan@amd.com>
In-Reply-To: <20200731024316.28324-17-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Aug 2020 16:41:59 -0400
Message-ID: <CADnq5_N-mcV_d=NcrYUPY8PuPQV23f-mj-gdu-Lf5PLrHgCVKg@mail.gmail.com>
Subject: Re: [PATCH 17/17] drm/amd/powerplay: add control method to bypass
 metrics cache on Vega12
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Nirmoy <nirmodas@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Do we want the metrics cache at all? I can see arguments both ways.
Patches 12-17 are:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Jul 30, 2020 at 10:45 PM Evan Quan <evan.quan@amd.com> wrote:
>
> As for the gpu metric export, metrics cache makes no sense. It's up to
> user to decide how often the metrics should be retrieved.
>
> Change-Id: Ic2a27ebc90f0a7cf581d0697c121b6d7df030f3b
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  .../drm/amd/powerplay/hwmgr/vega12_hwmgr.c    | 29 ++++++++++++-------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> index 40bb0c2e4e8c..c70c30175801 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> @@ -1262,22 +1262,29 @@ static uint32_t vega12_dpm_get_mclk(struct pp_hwmgr *hwmgr, bool low)
>         return (mem_clk * 100);
>  }
>
> -static int vega12_get_metrics_table(struct pp_hwmgr *hwmgr, SmuMetrics_t *metrics_table)
> +static int vega12_get_metrics_table(struct pp_hwmgr *hwmgr,
> +                                   SmuMetrics_t *metrics_table,
> +                                   bool bypass_cache)
>  {
>         struct vega12_hwmgr *data =
>                         (struct vega12_hwmgr *)(hwmgr->backend);
>         int ret = 0;
>
> -       if (!data->metrics_time || time_after(jiffies, data->metrics_time + HZ / 2)) {
> -               ret = smum_smc_table_manager(hwmgr, (uint8_t *)metrics_table,
> -                               TABLE_SMU_METRICS, true);
> +       if (bypass_cache ||
> +           !data->metrics_time ||
> +           time_after(jiffies, data->metrics_time + HZ / 2)) {
> +               ret = smum_smc_table_manager(hwmgr,
> +                                            (uint8_t *)(&data->metrics_table),
> +                                            TABLE_SMU_METRICS,
> +                                            true);
>                 if (ret) {
>                         pr_info("Failed to export SMU metrics table!\n");
>                         return ret;
>                 }
> -               memcpy(&data->metrics_table, metrics_table, sizeof(SmuMetrics_t));
>                 data->metrics_time = jiffies;
> -       } else
> +       }
> +
> +       if (metrics_table)
>                 memcpy(metrics_table, &data->metrics_table, sizeof(SmuMetrics_t));
>
>         return ret;
> @@ -1288,7 +1295,7 @@ static int vega12_get_gpu_power(struct pp_hwmgr *hwmgr, uint32_t *query)
>         SmuMetrics_t metrics_table;
>         int ret = 0;
>
> -       ret = vega12_get_metrics_table(hwmgr, &metrics_table);
> +       ret = vega12_get_metrics_table(hwmgr, &metrics_table, false);
>         if (ret)
>                 return ret;
>
> @@ -1339,7 +1346,7 @@ static int vega12_get_current_activity_percent(
>         SmuMetrics_t metrics_table;
>         int ret = 0;
>
> -       ret = vega12_get_metrics_table(hwmgr, &metrics_table);
> +       ret = vega12_get_metrics_table(hwmgr, &metrics_table, false);
>         if (ret)
>                 return ret;
>
> @@ -1387,7 +1394,7 @@ static int vega12_read_sensor(struct pp_hwmgr *hwmgr, int idx,
>                 *size = 4;
>                 break;
>         case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
> -               ret = vega12_get_metrics_table(hwmgr, &metrics_table);
> +               ret = vega12_get_metrics_table(hwmgr, &metrics_table, false);
>                 if (ret)
>                         return ret;
>
> @@ -1396,7 +1403,7 @@ static int vega12_read_sensor(struct pp_hwmgr *hwmgr, int idx,
>                 *size = 4;
>                 break;
>         case AMDGPU_PP_SENSOR_MEM_TEMP:
> -               ret = vega12_get_metrics_table(hwmgr, &metrics_table);
> +               ret = vega12_get_metrics_table(hwmgr, &metrics_table, false);
>                 if (ret)
>                         return ret;
>
> @@ -2752,7 +2759,7 @@ static ssize_t vega12_get_gpu_metrics(struct pp_hwmgr *hwmgr,
>         uint32_t fan_speed_rpm;
>         int ret;
>
> -       ret = vega12_get_metrics_table(hwmgr, &metrics);
> +       ret = vega12_get_metrics_table(hwmgr, &metrics, true);
>         if (ret)
>                 return ret;
>
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
