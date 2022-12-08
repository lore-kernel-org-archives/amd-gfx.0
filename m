Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E2BC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 11:33:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3142E10E1D9;
	Thu,  8 Dec 2022 11:33:08 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CB1810E1D9
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Dec 2022 11:33:05 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id h8so560874qkk.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Dec 2022 03:33:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w87TfVGn5PUwe/KKPd/uOeQcjUWN/xjtGNqcaxIYhMM=;
 b=y6jmWkUacmDvpR6Q9iJPq/cxcUVWMh873s2KPT5GzR+wbLnkdqpP73ZvsI3ZBh8nuD
 na6VhdnQjbWj9WI9SjCwq/cgJlVxpPG1NFwClb8fbn6Pff70yajSuWvRtmor+VUEwFkR
 swPGbSNH3V5RElOTz52oWlFRZgR6TubKdCnJld3CiT+N2V9nOGs1V8WYaTYAR/NX/txt
 8C3BoE/haXPUO3ULGdDwpAmNHM75aJwctj38A1MWYQS8KSaxb/5D/2e4vaO9qyRgF3w6
 1564aiK/XYzJYhQYsUfbHO3PRhCRmRirhoOdzXGi4hqaJ9cMBnosFdeYo5apYw3ql3FD
 o8qg==
X-Gm-Message-State: ANoB5plZyqOQFEDsS+g9G2Kgq7wYm6OgZerSDPVY3ntYUZ62F81lVf1W
 dBvVA0X5dklUUYSlv4liM6D0d7peq4i2puFu43I=
X-Google-Smtp-Source: AA0mqf76Ewz158N05kPTKneS5XKrQagYNX4mcsqZgDDBRvXGV9Q49RFdt3HYFqFsvWInKs66iky0iE3N7ayswexyNKo=
X-Received: by 2002:a05:620a:22fa:b0:6fb:c38e:e5dd with SMTP id
 p26-20020a05620a22fa00b006fbc38ee5ddmr82252364qki.23.1670499184625; Thu, 08
 Dec 2022 03:33:04 -0800 (PST)
MIME-Version: 1.0
References: <20221208010910.7621-1-mario.limonciello@amd.com>
 <20221208010910.7621-2-mario.limonciello@amd.com>
In-Reply-To: <20221208010910.7621-2-mario.limonciello@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 8 Dec 2022 12:32:53 +0100
Message-ID: <CAJZ5v0jZd=g_TM5OFiVq-WuaRykdtk-sV1VU6=izsvwGhGPALQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ACPI: video: Allow GPU drivers to report no panels
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: Daniel Dadap <ddadap@nvidia.com>, linux-acpi@vger.kernel.org,
 "Rafael J . Wysocki" <rafael@kernel.org>, amd-gfx@lists.freedesktop.org,
 Hans de Goede <hdegoede@redhat.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 8, 2022 at 2:09 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The current logic for the ACPI backlight detection will create
> a backlight device if no native or vendor drivers have created
> 8 seconds after the system has booted if the ACPI tables
> included backlight control methods.
>
> If the GPU drivers have loaded, they may be able to report whether
> any LCD panels were found.  Allow using this information to factor
> in whether to enable the fallback logic for making an acpi_video0
> backlight device.
>
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Cancel registration for backlight device instead (Hans)
>  * drop desktop check (Dan)
>
>  drivers/acpi/acpi_video.c | 11 +++++++++++
>  include/acpi/video.h      |  1 +
>  2 files changed, 12 insertions(+)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 32953646caeb..f64fdb029090 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -2178,6 +2178,17 @@ static bool should_check_lcd_flag(void)
>         return false;
>  }
>
> +/*
> + * At least one graphics driver has reported that no LCD is connected
> + * via the native interface. cancel the registration for fallback acpi_video0.
> + * If another driver still deems this necessary, it can explicitly register it.
> + */
> +void acpi_video_report_nolcd(void)
> +{
> +       cancel_delayed_work(&video_bus_register_backlight_work);
> +}
> +EXPORT_SYMBOL(acpi_video_report_nolcd);
> +
>  int acpi_video_register(void)
>  {
>         int ret = 0;
> diff --git a/include/acpi/video.h b/include/acpi/video.h
> index a275c35e5249..1fccb111c197 100644
> --- a/include/acpi/video.h
> +++ b/include/acpi/video.h
> @@ -53,6 +53,7 @@ enum acpi_backlight_type {
>  };
>
>  #if IS_ENABLED(CONFIG_ACPI_VIDEO)
> +extern void acpi_video_report_nolcd(void);

It looks like a stub is needed for the other case.  Apparently, things
fail to compile due to the lack of it.

>  extern int acpi_video_register(void);
>  extern void acpi_video_unregister(void);
>  extern void acpi_video_register_backlight(void);
> --
> 2.34.1
>
