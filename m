Return-Path: <SRS0=7kRa=CY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02EEC433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 18:37:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25ACC20732
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 18:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjQLtHja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25ACC20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B550D6E8DA;
	Tue, 15 Sep 2020 18:37:32 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C82036E8DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 18:37:31 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id k15so4357498wrn.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 11:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nEw8rN+kw/jykmFPmRSiqBa9a8lkUJ1mfOUL1R9rzAI=;
 b=XjQLtHjaDx57TQjfPLNfAfOg2d44FMfnuOpWEx8tWpib0oAZ7riYOV2ULAuvPxHLt2
 gIhIo3fBzUlANJhMlABmuc3iSjF2TbiSl94yXE+GdskgDwXjam8MjvZkiVWGb5kz1wW+
 HU6BXn6JCXm5xWmDosS+eB0VLJjJdSISqDcGmCMJC4L1UTyXwa65CKcOjWp3CN8RUMkX
 JkVFdYj7uXXUF4dKNlDeELeC4WuxQIqNbm3ZCrgzFbkkKekR80LNcen57T77msY+EQJ6
 UccvSN35nwdlND7V7o4+HEisf2sk/paawENDgqQ0YFOYFV59sFvvZGMS/GOpa7lSzYBQ
 eCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nEw8rN+kw/jykmFPmRSiqBa9a8lkUJ1mfOUL1R9rzAI=;
 b=JMtPEkNekZ/mogMhkxQUolgYYzjUCSXjDwIim2CeBhSMai4HvcDFF4QkXTSYqlEp5n
 pKvVw+6xc+79bA/D/ac/4j+u7R15cSQu3/giRmV+XjPFzpNcPI9BFIZDpRcxvmHz2yy1
 LPq8/NpT450gqHD/cGZuTM9aMt5JDvMl95NOMdMO5L3oUV/HBNjCTXuo4bbefN75cH/z
 Fy7hMiZwND6aoP0p6MOgDrGMkGH98ztWhcBoTY96mXjBSynyiMSdqabJcEI4jlM+7bUY
 1cKekckzdvMl5JxX7Yc2kuHEgBMmf25j9Nm7gHI9//ddrWFZjWL9WjlWEmGbQeP719EL
 KNqA==
X-Gm-Message-State: AOAM531/iZda3krPznyR8/QGGOh18Cpo1dQHaBstGQN5YYRXAGPXxFdP
 RtBPUZlzMR1nWS37imB7ImxV9Yu1ADP3BnfJrY8kgrUg4Wo=
X-Google-Smtp-Source: ABdhPJyXdzTc1kRcuCs65+gZho/KraZrqoWsIofYIzl554jw0sPa0YbFVfbllyXY+EjKDHMxFQe+L3WAKioqdD2uwU4=
X-Received: by 2002:adf:f290:: with SMTP id k16mr24312102wro.124.1600195050452; 
 Tue, 15 Sep 2020 11:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200907090126.2542-1-evan.quan@amd.com>
 <20200907090126.2542-4-evan.quan@amd.com>
In-Reply-To: <20200907090126.2542-4-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Sep 2020 14:37:19 -0400
Message-ID: <CADnq5_MBNQarnHjt7UaEu=Ko8EJnvwcROVBqUCARdzE47cSrRA@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amd/pm: add Raven2 watermak WmType setting
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
 Huang Rui <ray.huang@amd.com>, Changfeng Zhu <Changfeng.Zhu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 7, 2020 at 5:02 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Which tells it's a nomral pstate change or memory retraining.

Same typos as patch 3.  With those fixed:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Change-Id: If55d6c3f1dfc28005c6d767154664feddcda6f5b
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Tested-by: Changfeng Zhu <Changfeng.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/inc/smu10_driver_if.h         |  3 ++-
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 11 +++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu10_driver_if.h b/drivers/gpu/drm/amd/pm/inc/smu10_driver_if.h
> index dea8fe93da63..c498158771cc 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu10_driver_if.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu10_driver_if.h
> @@ -54,7 +54,8 @@ typedef struct {
>         uint16_t MaxMclk;
>
>         uint8_t  WmSetting;
> -       uint8_t  Padding[3];
> +       uint8_t  WmType;
> +       uint8_t  Padding[2];
>  } WatermarkRowGeneric_t;
>
>  #define NUM_WM_RANGES 4
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index 9ee8cf8267c8..88792dba1759 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1181,8 +1181,19 @@ static int smu10_set_watermarks_for_clocks_ranges(struct pp_hwmgr *hwmgr,
>         struct smu10_hwmgr *data = hwmgr->backend;
>         struct dm_pp_wm_sets_with_clock_ranges_soc15 *wm_with_clock_ranges = clock_ranges;
>         Watermarks_t *table = &(data->water_marks_table);
> +       struct amdgpu_device *adev = hwmgr->adev;
> +       int i;
>
>         smu_set_watermarks_for_clocks_ranges(table,wm_with_clock_ranges);
> +
> +       if (adev->apu_flags & AMD_APU_IS_RAVEN2) {
> +               for (i = 0; i < NUM_WM_RANGES; i++)
> +                       table->WatermarkRow[WM_DCFCLK][i].WmType = (uint8_t)0;
> +
> +               for (i = 0; i < NUM_WM_RANGES; i++)
> +                       table->WatermarkRow[WM_SOCCLK][i].WmType = (uint8_t)0;
> +       }
> +
>         smum_smc_table_manager(hwmgr, (uint8_t *)table, (uint16_t)SMU10_WMTABLE, false);
>         data->water_marks_exist = true;
>         return 0;
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
