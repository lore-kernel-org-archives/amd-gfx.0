Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B821C352BE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 09:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0DFE2137B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 09:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rL6j22FO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0DFE2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D9AA6E109;
	Fri, 17 Apr 2020 09:22:44 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53CCB6E109
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 09:22:43 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id j2so2204576wrs.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 02:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=mTkXHhLO0xtYgDaHk3+DgffL9vzoEyNF7lxbByyNhCQ=;
 b=rL6j22FOJoEv5o0GQMo6YVOPobu2vtzqeZaHBH7oipoxX+/tJH1kbyVkgsvSMEfh0b
 DdyswoDB1+6EaVEQWxDS4d6aBgRsYuaD8oTGKo2PX1OYxo41geruece5bxNQCASmJYLI
 ZjO1QWLFBlPb8WZcoUcHaZRslzuUXG56/Bk3cMMOCY/c8JUGkawT+IysWWNyorVK73fn
 YavbCEGz0A6v1xNdjP6XjqY3s+Z+5vy8/jWTmGpjINtiZKCYPd0ICuNCw8+JvkIAgv1K
 adBIdlqtWut5MuCHPJSYG6sFZFAeA34PcjK/eHwQtVkuMDqZE/gNvSqB/JnDd/BbtlXl
 t77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language;
 bh=mTkXHhLO0xtYgDaHk3+DgffL9vzoEyNF7lxbByyNhCQ=;
 b=t4xfGs7Yf0wQzVyb3Pwp0u2Psw2dZWcEbwnpL3pdE0dsYJoQcpsLYJ8w/jndYeloYd
 YnNcy4zk+oSjMABR+HEZ8f6HK+yag/hXwIDRkGr9+KINHqNiAhUl7U0eTGAepnKbXt3M
 oJenGJxzKQHNwb32ZbS0Z8Ex+XxwmVlih96XNfq0oHAGjJsjsmIEUmsTrfqWfwIsik/d
 PEm+hyaJcYIoD1WRK3w4TykaiQx0B7wGHj4MIGv7gKA7D2I7rJqDQfqmI/x0uZ7sOEFN
 0Ow445cYNIut7Vzqq/OjQRG5/4zaH2dP/9ajwPvUwjYKKVpm1pAObu/HNPYWcPfyHBKd
 5Wpg==
X-Gm-Message-State: AGi0PubW02lwjWIkSI9R9twwN3e+/D0ME2U6hqa+OxdLeUZM7YTPxZJ1
 tqQlQXQT4nSNRDt8r3AgTW4=
X-Google-Smtp-Source: APiQypJyNrkn2OYZFeNMGxZkJhecGPch5sBax3x1AaSyEmtoOzkVBch7/DtGAmo3dNRJ1VGHXA1csA==
X-Received: by 2002:adf:ec09:: with SMTP id x9mr2846191wrn.364.1587115361968; 
 Fri, 17 Apr 2020 02:22:41 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id c20sm7482700wmd.36.2020.04.17.02.22.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 17 Apr 2020 02:22:41 -0700 (PDT)
Subject: Re: [PATCH 05/35] drm/amd/display: Remove byte swapping for dmcub abm
 config table
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
 <20200416234044.2082886-6-Rodrigo.Siqueira@amd.com>
 <MN2PR12MB4488B2003904110CAE92E166F7D90@MN2PR12MB4488.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c3f3fef6-6c35-7201-c75e-2a72dca42350@gmail.com>
Date: Fri, 17 Apr 2020 11:22:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB4488B2003904110CAE92E166F7D90@MN2PR12MB4488.namprd12.prod.outlook.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Koo, Anthony" <Anthony.Koo@amd.com>,
 "Wood, Wyatt" <Wyatt.Wood@amd.com>
Content-Type: multipart/mixed; boundary="===============2124057107=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============2124057107==
Content-Type: multipart/alternative;
 boundary="------------4800A9B6D3F1F6A1341DA7DC"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------4800A9B6D3F1F6A1341DA7DC
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Agreed, just wanted to reply as well since I think something is not 
correctly understood here.

The cpu_to_be16() and be16_to_cpu() functions work different depending 
on which architecture/endianess your are.

So they should be a NO-OP on x86 if everything is done right.

Christian.

Am 17.04.20 um 04:32 schrieb Deucher, Alexander:
>
> [AMD Public Use]
>
>
> I would drop this patch unless it only applies to APUs.  On Linux, 
> people may run the driver on big endian systems.
>
> Alex
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
> Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> *Sent:* Thursday, April 16, 2020 7:40 PM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry 
> <Harry.Wentland@amd.com>; Siqueira, Rodrigo 
> <Rodrigo.Siqueira@amd.com>; Wood, Wyatt <Wyatt.Wood@amd.com>; Lakha, 
> Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Koo, Anthony 
> <Anthony.Koo@amd.com>
> *Subject:* [PATCH 05/35] drm/amd/display: Remove byte swapping for 
> dmcub abm config table
> From: Wyatt Wood <wyatt.wood@amd.com>
>
> [Why]
> Since x86 and dmcub are both little endian, byte swapping isn't
> necessary. Dmcu requires byte swapping as it is big endian.
>
> [How]
> Add flag to function definitions to determine if byte swapping is
> necessary.
>
> Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
> Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
> Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>  .../amd/display/modules/power/power_helpers.c | 74 +++++++++----------
>  1 file changed, 36 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c 
> b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> index dd1517684c90..edb446455f6b 100644
> --- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> +++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> @@ -240,7 +240,7 @@ static void fill_backlight_transform_table(struct 
> dmcu_iram_parameters params,
>  }
>
>  static void fill_backlight_transform_table_v_2_2(struct 
> dmcu_iram_parameters params,
> -               struct iram_table_v_2_2 *table)
> +               struct iram_table_v_2_2 *table, bool big_endian)
>  {
>          unsigned int i;
>          unsigned int num_entries = NUM_BL_CURVE_SEGS;
> @@ -264,10 +264,10 @@ static void 
> fill_backlight_transform_table_v_2_2(struct dmcu_iram_parameters par
>                  lut_index = (params.backlight_lut_array_size - 1) * i 
> / (num_entries - 1);
>                  ASSERT(lut_index < params.backlight_lut_array_size);
>
> -               table->backlight_thresholds[i] =
> -                       cpu_to_be16(DIV_ROUNDUP((i * 65536), 
> num_entries));
> -               table->backlight_offsets[i] =
> - cpu_to_be16(params.backlight_lut_array[lut_index]);
> +               table->backlight_thresholds[i] = (big_endian) ?
> +                       cpu_to_be16(DIV_ROUNDUP((i * 65536), 
> num_entries)) : DIV_ROUNDUP((i * 65536), num_entries);
> +               table->backlight_offsets[i] = (big_endian) ?
> + cpu_to_be16(params.backlight_lut_array[lut_index]) : 
> params.backlight_lut_array[lut_index];
>          }
>  }
>
> @@ -587,18 +587,16 @@ void fill_iram_v_2_2(struct iram_table_v_2_2 
> *ram_table, struct dmcu_iram_parame
>          ram_table->crgb_slope[7]  = cpu_to_be16(0x1910);
>
>          fill_backlight_transform_table_v_2_2(
> -                       params, ram_table);
> +                       params, ram_table, true);
>  }
>
> -void fill_iram_v_2_3(struct iram_table_v_2_2 *ram_table, struct 
> dmcu_iram_parameters params)
> +void fill_iram_v_2_3(struct iram_table_v_2_2 *ram_table, struct 
> dmcu_iram_parameters params, bool big_endian)
>  {
>          unsigned int i, j;
>          unsigned int set = params.set;
>
>          ram_table->flags = 0x0;
> -
> -       ram_table->min_abm_backlight =
> - cpu_to_be16(params.min_abm_backlight);
> +       ram_table->min_abm_backlight = (big_endian) ? 
> cpu_to_be16(params.min_abm_backlight) : params.min_abm_backlight;
>
>          for (i = 0; i < NUM_AGGR_LEVEL; i++) {
>                  ram_table->hybrid_factor[i] = 
> abm_settings[set][i].brightness_gain;
> @@ -622,33 +620,33 @@ void fill_iram_v_2_3(struct iram_table_v_2_2 
> *ram_table, struct dmcu_iram_parame
>          ram_table->iir_curve[4] = 0x65;
>
>          //Gamma 2.2
> -       ram_table->crgb_thresh[0] = cpu_to_be16(0x127c);
> -       ram_table->crgb_thresh[1] = cpu_to_be16(0x151b);
> -       ram_table->crgb_thresh[2] = cpu_to_be16(0x17d5);
> -       ram_table->crgb_thresh[3] = cpu_to_be16(0x1a56);
> -       ram_table->crgb_thresh[4] = cpu_to_be16(0x1c83);
> -       ram_table->crgb_thresh[5] = cpu_to_be16(0x1e72);
> -       ram_table->crgb_thresh[6] = cpu_to_be16(0x20f0);
> -       ram_table->crgb_thresh[7] = cpu_to_be16(0x232b);
> -       ram_table->crgb_offset[0] = cpu_to_be16(0x2999);
> -       ram_table->crgb_offset[1] = cpu_to_be16(0x3999);
> -       ram_table->crgb_offset[2] = cpu_to_be16(0x4666);
> -       ram_table->crgb_offset[3] = cpu_to_be16(0x5999);
> -       ram_table->crgb_offset[4] = cpu_to_be16(0x6333);
> -       ram_table->crgb_offset[5] = cpu_to_be16(0x7800);
> -       ram_table->crgb_offset[6] = cpu_to_be16(0x8c00);
> -       ram_table->crgb_offset[7] = cpu_to_be16(0xa000);
> -       ram_table->crgb_slope[0]  = cpu_to_be16(0x3609);
> -       ram_table->crgb_slope[1]  = cpu_to_be16(0x2dfa);
> -       ram_table->crgb_slope[2]  = cpu_to_be16(0x27ea);
> -       ram_table->crgb_slope[3]  = cpu_to_be16(0x235d);
> -       ram_table->crgb_slope[4]  = cpu_to_be16(0x2042);
> -       ram_table->crgb_slope[5]  = cpu_to_be16(0x1dc3);
> -       ram_table->crgb_slope[6]  = cpu_to_be16(0x1b1a);
> -       ram_table->crgb_slope[7]  = cpu_to_be16(0x1910);
> +       ram_table->crgb_thresh[0] = (big_endian) ? cpu_to_be16(0x127c) 
> : 0x127c;
> +       ram_table->crgb_thresh[1] = (big_endian) ? cpu_to_be16(0x151b) 
> : 0x151b;
> +       ram_table->crgb_thresh[2] = (big_endian) ? cpu_to_be16(0x17d5) 
> : 0x17d5;
> +       ram_table->crgb_thresh[3] = (big_endian) ? cpu_to_be16(0x1a56) 
> : 0x1a56;
> +       ram_table->crgb_thresh[4] = (big_endian) ? cpu_to_be16(0x1c83) 
> : 0x1c83;
> +       ram_table->crgb_thresh[5] = (big_endian) ? cpu_to_be16(0x1e72) 
> : 0x1e72;
> +       ram_table->crgb_thresh[6] = (big_endian) ? cpu_to_be16(0x20f0) 
> : 0x20f0;
> +       ram_table->crgb_thresh[7] = (big_endian) ? cpu_to_be16(0x232b) 
> : 0x232b;
> +       ram_table->crgb_offset[0] = (big_endian) ? cpu_to_be16(0x2999) 
> : 0x2999;
> +       ram_table->crgb_offset[1] = (big_endian) ? cpu_to_be16(0x3999) 
> : 0x3999;
> +       ram_table->crgb_offset[2] = (big_endian) ? cpu_to_be16(0x4666) 
> : 0x4666;
> +       ram_table->crgb_offset[3] = (big_endian) ? cpu_to_be16(0x5999) 
> : 0x5999;
> +       ram_table->crgb_offset[4] = (big_endian) ? cpu_to_be16(0x6333) 
> : 0x6333;
> +       ram_table->crgb_offset[5] = (big_endian) ? cpu_to_be16(0x7800) 
> : 0x7800;
> +       ram_table->crgb_offset[6] = (big_endian) ? cpu_to_be16(0x8c00) 
> : 0x8c00;
> +       ram_table->crgb_offset[7] = (big_endian) ? cpu_to_be16(0xa000) 
> : 0xa000;
> +       ram_table->crgb_slope[0]  = (big_endian) ? cpu_to_be16(0x3609) 
> : 0x3609;
> +       ram_table->crgb_slope[1]  = (big_endian) ? cpu_to_be16(0x2dfa) 
> : 0x2dfa;
> +       ram_table->crgb_slope[2]  = (big_endian) ? cpu_to_be16(0x27ea) 
> : 0x27ea;
> +       ram_table->crgb_slope[3]  = (big_endian) ? cpu_to_be16(0x235d) 
> : 0x235d;
> +       ram_table->crgb_slope[4]  = (big_endian) ? cpu_to_be16(0x2042) 
> : 0x2042;
> +       ram_table->crgb_slope[5]  = (big_endian) ? cpu_to_be16(0x1dc3) 
> : 0x1dc3;
> +       ram_table->crgb_slope[6]  = (big_endian) ? cpu_to_be16(0x1b1a) 
> : 0x1b1a;
> +       ram_table->crgb_slope[7]  = (big_endian) ? cpu_to_be16(0x1910) 
> : 0x1910;
>
>          fill_backlight_transform_table_v_2_2(
> -                       params, ram_table);
> +                       params, ram_table, big_endian);
>  }
>
>  bool dmub_init_abm_config(struct abm *abm,
> @@ -662,7 +660,7 @@ bool dmub_init_abm_config(struct abm *abm,
>
>          memset(&ram_table, 0, sizeof(ram_table));
>
> -       fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params);
> +       fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params, 
> false);
>          result = abm->funcs->init_abm_config(
>                  abm, (char *)(&ram_table), IRAM_RESERVE_AREA_START_V2_2);
>
> @@ -684,11 +682,11 @@ bool dmcu_load_iram(struct dmcu *dmcu,
>          memset(&ram_table, 0, sizeof(ram_table));
>
>          if (dmcu->dmcu_version.abm_version == 0x24) {
> -               fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, 
> params);
> +               fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, 
> params, true);
>                          result = dmcu->funcs->load_iram(
>                                          dmcu, 0, (char 
> *)(&ram_table), IRAM_RESERVE_AREA_START_V2_2);
>          } else if (dmcu->dmcu_version.abm_version == 0x23) {
> -               fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, 
> params);
> +               fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, 
> params, true);
>
>                  result = dmcu->funcs->load_iram(
>                                  dmcu, 0, (char *)(&ram_table), 
> IRAM_RESERVE_AREA_START_V2_2);
> -- 
> 2.26.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Calexander.deucher%40amd.com%7C71bc54a1a7b7444439c208d7e25fab51%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637226772877797082&amp;sdata=sa4MJoUY%2FjVgW3f4Qx1N4KYpFY3QyqZPWVDbRoUmTxs%3D&amp;reserved=0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------4800A9B6D3F1F6A1341DA7DC
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Agreed, just wanted to reply as well
      since I think something is not correctly understood here.<br>
      <br>
      The <font size="2"><span style="font-size:11pt;">cpu_to_be16()
          and be16_to_cpu() functions work different depending on which
          architecture/endianess your are.<br>
          <br>
          So they should be a NO-OP on x86 if everything is done right.<br>
          <br>
          Christian.<br>
        </span></font><br>
      Am 17.04.20 um 04:32 schrieb Deucher, Alexander:<br>
    </div>
    <blockquote type="cite"
cite="mid:MN2PR12MB4488B2003904110CAE92E166F7D90@MN2PR12MB4488.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <p
        style="font-family:Arial;font-size:10pt;color:#317100;margin:15pt;"
        align="Left">
        [AMD Public Use]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          I would drop this patch unless it only applies to APUs.  On
          Linux, people may run the driver on big endian systems.</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Alex<br>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            face="Calibri, sans-serif" color="#000000"><b>From:</b>
            amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on
            behalf of Rodrigo Siqueira <a class="moz-txt-link-rfc2396E" href="mailto:Rodrigo.Siqueira@amd.com">&lt;Rodrigo.Siqueira@amd.com&gt;</a><br>
            <b>Sent:</b> Thursday, April 16, 2020 7:40 PM<br>
            <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Li, Sun peng (Leo) <a class="moz-txt-link-rfc2396E" href="mailto:Sunpeng.Li@amd.com">&lt;Sunpeng.Li@amd.com&gt;</a>;
            Wentland, Harry <a class="moz-txt-link-rfc2396E" href="mailto:Harry.Wentland@amd.com">&lt;Harry.Wentland@amd.com&gt;</a>; Siqueira,
            Rodrigo <a class="moz-txt-link-rfc2396E" href="mailto:Rodrigo.Siqueira@amd.com">&lt;Rodrigo.Siqueira@amd.com&gt;</a>; Wood, Wyatt
            <a class="moz-txt-link-rfc2396E" href="mailto:Wyatt.Wood@amd.com">&lt;Wyatt.Wood@amd.com&gt;</a>; Lakha, Bhawanpreet
            <a class="moz-txt-link-rfc2396E" href="mailto:Bhawanpreet.Lakha@amd.com">&lt;Bhawanpreet.Lakha@amd.com&gt;</a>; Koo, Anthony
            <a class="moz-txt-link-rfc2396E" href="mailto:Anthony.Koo@amd.com">&lt;Anthony.Koo@amd.com&gt;</a><br>
            <b>Subject:</b> [PATCH 05/35] drm/amd/display: Remove byte
            swapping for dmcub abm config table</font>
          <div> </div>
        </div>
        <div class="BodyFragment"><font size="2"><span
              style="font-size:11pt;">
              <div class="PlainText">From: Wyatt Wood
                <a class="moz-txt-link-rfc2396E" href="mailto:wyatt.wood@amd.com">&lt;wyatt.wood@amd.com&gt;</a><br>
                <br>
                [Why]<br>
                Since x86 and dmcub are both little endian, byte
                swapping isn't<br>
                necessary. Dmcu requires byte swapping as it is big
                endian.<br>
                <br>
                [How]<br>
                Add flag to function definitions to determine if byte
                swapping is<br>
                necessary.<br>
                <br>
                Signed-off-by: Wyatt Wood <a class="moz-txt-link-rfc2396E" href="mailto:wyatt.wood@amd.com">&lt;wyatt.wood@amd.com&gt;</a><br>
                Reviewed-by: Anthony Koo <a class="moz-txt-link-rfc2396E" href="mailto:Anthony.Koo@amd.com">&lt;Anthony.Koo@amd.com&gt;</a><br>
                Acked-by: Rodrigo Siqueira
                <a class="moz-txt-link-rfc2396E" href="mailto:Rodrigo.Siqueira@amd.com">&lt;Rodrigo.Siqueira@amd.com&gt;</a><br>
                ---<br>
                 .../amd/display/modules/power/power_helpers.c | 74
                +++++++++----------<br>
                 1 file changed, 36 insertions(+), 38 deletions(-)<br>
                <br>
                diff --git
                a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c<br>
                index dd1517684c90..edb446455f6b 100644<br>
                ---
                a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c<br>
                +++
                b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c<br>
                @@ -240,7 +240,7 @@ static void
                fill_backlight_transform_table(struct
                dmcu_iram_parameters params,<br>
                 }<br>
                 <br>
                 static void fill_backlight_transform_table_v_2_2(struct
                dmcu_iram_parameters params,<br>
                -               struct iram_table_v_2_2 *table)<br>
                +               struct iram_table_v_2_2 *table, bool
                big_endian)<br>
                 {<br>
                         unsigned int i;<br>
                         unsigned int num_entries = NUM_BL_CURVE_SEGS;<br>
                @@ -264,10 +264,10 @@ static void
                fill_backlight_transform_table_v_2_2(struct
                dmcu_iram_parameters par<br>
                                 lut_index =
                (params.backlight_lut_array_size - 1) * i / (num_entries
                - 1);<br>
                                 ASSERT(lut_index &lt;
                params.backlight_lut_array_size);<br>
                 <br>
                -               table-&gt;backlight_thresholds[i] =<br>
                -                       cpu_to_be16(DIV_ROUNDUP((i *
                65536), num_entries));<br>
                -               table-&gt;backlight_offsets[i] =<br>
                -                      
                cpu_to_be16(params.backlight_lut_array[lut_index]);<br>
                +               table-&gt;backlight_thresholds[i] =
                (big_endian) ?<br>
                +                       cpu_to_be16(DIV_ROUNDUP((i *
                65536), num_entries)) : DIV_ROUNDUP((i * 65536),
                num_entries);<br>
                +               table-&gt;backlight_offsets[i] =
                (big_endian) ?<br>
                +                      
                cpu_to_be16(params.backlight_lut_array[lut_index]) :
                params.backlight_lut_array[lut_index];<br>
                         }<br>
                 }<br>
                 <br>
                @@ -587,18 +587,16 @@ void fill_iram_v_2_2(struct
                iram_table_v_2_2 *ram_table, struct dmcu_iram_parame<br>
                         ram_table-&gt;crgb_slope[7]  =
                cpu_to_be16(0x1910);<br>
                 <br>
                         fill_backlight_transform_table_v_2_2(<br>
                -                       params, ram_table);<br>
                +                       params, ram_table, true);<br>
                 }<br>
                 <br>
                -void fill_iram_v_2_3(struct iram_table_v_2_2
                *ram_table, struct dmcu_iram_parameters params)<br>
                +void fill_iram_v_2_3(struct iram_table_v_2_2
                *ram_table, struct dmcu_iram_parameters params, bool
                big_endian)<br>
                 {<br>
                         unsigned int i, j;<br>
                         unsigned int set = params.set;<br>
                 <br>
                         ram_table-&gt;flags = 0x0;<br>
                -<br>
                -       ram_table-&gt;min_abm_backlight =<br>
                -                      
                cpu_to_be16(params.min_abm_backlight);<br>
                +       ram_table-&gt;min_abm_backlight = (big_endian) ?
                cpu_to_be16(params.min_abm_backlight) :
                params.min_abm_backlight;<br>
                 <br>
                         for (i = 0; i &lt; NUM_AGGR_LEVEL; i++) {<br>
                                 ram_table-&gt;hybrid_factor[i] =
                abm_settings[set][i].brightness_gain;<br>
                @@ -622,33 +620,33 @@ void fill_iram_v_2_3(struct
                iram_table_v_2_2 *ram_table, struct dmcu_iram_parame<br>
                         ram_table-&gt;iir_curve[4] = 0x65;<br>
                 <br>
                         //Gamma 2.2<br>
                -       ram_table-&gt;crgb_thresh[0] =
                cpu_to_be16(0x127c);<br>
                -       ram_table-&gt;crgb_thresh[1] =
                cpu_to_be16(0x151b);<br>
                -       ram_table-&gt;crgb_thresh[2] =
                cpu_to_be16(0x17d5);<br>
                -       ram_table-&gt;crgb_thresh[3] =
                cpu_to_be16(0x1a56);<br>
                -       ram_table-&gt;crgb_thresh[4] =
                cpu_to_be16(0x1c83);<br>
                -       ram_table-&gt;crgb_thresh[5] =
                cpu_to_be16(0x1e72);<br>
                -       ram_table-&gt;crgb_thresh[6] =
                cpu_to_be16(0x20f0);<br>
                -       ram_table-&gt;crgb_thresh[7] =
                cpu_to_be16(0x232b);<br>
                -       ram_table-&gt;crgb_offset[0] =
                cpu_to_be16(0x2999);<br>
                -       ram_table-&gt;crgb_offset[1] =
                cpu_to_be16(0x3999);<br>
                -       ram_table-&gt;crgb_offset[2] =
                cpu_to_be16(0x4666);<br>
                -       ram_table-&gt;crgb_offset[3] =
                cpu_to_be16(0x5999);<br>
                -       ram_table-&gt;crgb_offset[4] =
                cpu_to_be16(0x6333);<br>
                -       ram_table-&gt;crgb_offset[5] =
                cpu_to_be16(0x7800);<br>
                -       ram_table-&gt;crgb_offset[6] =
                cpu_to_be16(0x8c00);<br>
                -       ram_table-&gt;crgb_offset[7] =
                cpu_to_be16(0xa000);<br>
                -       ram_table-&gt;crgb_slope[0]  =
                cpu_to_be16(0x3609);<br>
                -       ram_table-&gt;crgb_slope[1]  =
                cpu_to_be16(0x2dfa);<br>
                -       ram_table-&gt;crgb_slope[2]  =
                cpu_to_be16(0x27ea);<br>
                -       ram_table-&gt;crgb_slope[3]  =
                cpu_to_be16(0x235d);<br>
                -       ram_table-&gt;crgb_slope[4]  =
                cpu_to_be16(0x2042);<br>
                -       ram_table-&gt;crgb_slope[5]  =
                cpu_to_be16(0x1dc3);<br>
                -       ram_table-&gt;crgb_slope[6]  =
                cpu_to_be16(0x1b1a);<br>
                -       ram_table-&gt;crgb_slope[7]  =
                cpu_to_be16(0x1910);<br>
                +       ram_table-&gt;crgb_thresh[0] = (big_endian) ?
                cpu_to_be16(0x127c) : 0x127c;<br>
                +       ram_table-&gt;crgb_thresh[1] = (big_endian) ?
                cpu_to_be16(0x151b) : 0x151b;<br>
                +       ram_table-&gt;crgb_thresh[2] = (big_endian) ?
                cpu_to_be16(0x17d5) : 0x17d5;<br>
                +       ram_table-&gt;crgb_thresh[3] = (big_endian) ?
                cpu_to_be16(0x1a56) : 0x1a56;<br>
                +       ram_table-&gt;crgb_thresh[4] = (big_endian) ?
                cpu_to_be16(0x1c83) : 0x1c83;<br>
                +       ram_table-&gt;crgb_thresh[5] = (big_endian) ?
                cpu_to_be16(0x1e72) : 0x1e72;<br>
                +       ram_table-&gt;crgb_thresh[6] = (big_endian) ?
                cpu_to_be16(0x20f0) : 0x20f0;<br>
                +       ram_table-&gt;crgb_thresh[7] = (big_endian) ?
                cpu_to_be16(0x232b) : 0x232b;<br>
                +       ram_table-&gt;crgb_offset[0] = (big_endian) ?
                cpu_to_be16(0x2999) : 0x2999;<br>
                +       ram_table-&gt;crgb_offset[1] = (big_endian) ?
                cpu_to_be16(0x3999) : 0x3999;<br>
                +       ram_table-&gt;crgb_offset[2] = (big_endian) ?
                cpu_to_be16(0x4666) : 0x4666;<br>
                +       ram_table-&gt;crgb_offset[3] = (big_endian) ?
                cpu_to_be16(0x5999) : 0x5999;<br>
                +       ram_table-&gt;crgb_offset[4] = (big_endian) ?
                cpu_to_be16(0x6333) : 0x6333;<br>
                +       ram_table-&gt;crgb_offset[5] = (big_endian) ?
                cpu_to_be16(0x7800) : 0x7800;<br>
                +       ram_table-&gt;crgb_offset[6] = (big_endian) ?
                cpu_to_be16(0x8c00) : 0x8c00;<br>
                +       ram_table-&gt;crgb_offset[7] = (big_endian) ?
                cpu_to_be16(0xa000) : 0xa000;<br>
                +       ram_table-&gt;crgb_slope[0]  = (big_endian) ?
                cpu_to_be16(0x3609) : 0x3609;<br>
                +       ram_table-&gt;crgb_slope[1]  = (big_endian) ?
                cpu_to_be16(0x2dfa) : 0x2dfa;<br>
                +       ram_table-&gt;crgb_slope[2]  = (big_endian) ?
                cpu_to_be16(0x27ea) : 0x27ea;<br>
                +       ram_table-&gt;crgb_slope[3]  = (big_endian) ?
                cpu_to_be16(0x235d) : 0x235d;<br>
                +       ram_table-&gt;crgb_slope[4]  = (big_endian) ?
                cpu_to_be16(0x2042) : 0x2042;<br>
                +       ram_table-&gt;crgb_slope[5]  = (big_endian) ?
                cpu_to_be16(0x1dc3) : 0x1dc3;<br>
                +       ram_table-&gt;crgb_slope[6]  = (big_endian) ?
                cpu_to_be16(0x1b1a) : 0x1b1a;<br>
                +       ram_table-&gt;crgb_slope[7]  = (big_endian) ?
                cpu_to_be16(0x1910) : 0x1910;<br>
                 <br>
                         fill_backlight_transform_table_v_2_2(<br>
                -                       params, ram_table);<br>
                +                       params, ram_table, big_endian);<br>
                 }<br>
                 <br>
                 bool dmub_init_abm_config(struct abm *abm,<br>
                @@ -662,7 +660,7 @@ bool dmub_init_abm_config(struct abm
                *abm,<br>
                 <br>
                         memset(&amp;ram_table, 0, sizeof(ram_table));<br>
                 <br>
                -       fill_iram_v_2_3((struct iram_table_v_2_2
                *)ram_table, params);<br>
                +       fill_iram_v_2_3((struct iram_table_v_2_2
                *)ram_table, params, false);<br>
                         result = abm-&gt;funcs-&gt;init_abm_config(<br>
                                 abm, (char *)(&amp;ram_table),
                IRAM_RESERVE_AREA_START_V2_2);<br>
                 <br>
                @@ -684,11 +682,11 @@ bool dmcu_load_iram(struct dmcu
                *dmcu,<br>
                         memset(&amp;ram_table, 0, sizeof(ram_table));<br>
                 <br>
                         if (dmcu-&gt;dmcu_version.abm_version == 0x24)
                {<br>
                -               fill_iram_v_2_3((struct iram_table_v_2_2
                *)ram_table, params);<br>
                +               fill_iram_v_2_3((struct iram_table_v_2_2
                *)ram_table, params, true);<br>
                                         result =
                dmcu-&gt;funcs-&gt;load_iram(<br>
                                                         dmcu, 0, (char
                *)(&amp;ram_table), IRAM_RESERVE_AREA_START_V2_2);<br>
                         } else if (dmcu-&gt;dmcu_version.abm_version ==
                0x23) {<br>
                -               fill_iram_v_2_3((struct iram_table_v_2_2
                *)ram_table, params);<br>
                +               fill_iram_v_2_3((struct iram_table_v_2_2
                *)ram_table, params, true);<br>
                 <br>
                                 result = dmcu-&gt;funcs-&gt;load_iram(<br>
                                                 dmcu, 0, (char
                *)(&amp;ram_table), IRAM_RESERVE_AREA_START_V2_2);<br>
                -- <br>
                2.26.0<br>
                <br>
                _______________________________________________<br>
                amd-gfx mailing list<br>
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                <a
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Calexander.deucher%40amd.com%7C71bc54a1a7b7444439c208d7e25fab51%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637226772877797082&amp;amp;sdata=sa4MJoUY%2FjVgW3f4Qx1N4KYpFY3QyqZPWVDbRoUmTxs%3D&amp;amp;reserved=0"
                  moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Calexander.deucher%40amd.com%7C71bc54a1a7b7444439c208d7e25fab51%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637226772877797082&amp;amp;sdata=sa4MJoUY%2FjVgW3f4Qx1N4KYpFY3QyqZPWVDbRoUmTxs%3D&amp;amp;reserved=0</a><br>
              </div>
            </span></font></div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------4800A9B6D3F1F6A1341DA7DC--

--===============2124057107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2124057107==--
