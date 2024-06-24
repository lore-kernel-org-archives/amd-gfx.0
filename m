Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221CDC2BBCA
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jun 2024 07:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 143B910E296;
	Tue, 25 Jun 2024 07:06:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ZFYvTTq/";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BB3310E3B9
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 09:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719219650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qwzmRUQPsKQBeShL2OB+EDS/R27ivaae/oICxqvSPpk=;
 b=ZFYvTTq/N3ssEVmiu4Jh53DxjSIyvGPcJr2OeUlsdFdZEIzLvVL0OCDU8gO84cs0TfzDNN
 rtNUt4ENrKytqV9v/Zoit/NV7sowWwB9Vg2TgRaehfp2TzK+OBDb2C5cu39nYZAHpJVImd
 RZQ+OfemD1cfcg6wixIv6/cipOJSFz4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-k_iek2KPPUGVMOfx0TeaQw-1; Mon, 24 Jun 2024 05:00:48 -0400
X-MC-Unique: k_iek2KPPUGVMOfx0TeaQw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a7244d1b086so92951866b.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 02:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719219647; x=1719824447;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qwzmRUQPsKQBeShL2OB+EDS/R27ivaae/oICxqvSPpk=;
 b=jGYMSGmKZJQcrNZKsJ2xml8fZ7CjpPcKLKw2MW981klnO2hYlI9ueHv2gX9DRZvDOk
 PVM7EJIIk0yB5/5uTW4TdFyd/XWpXemx5XkKV1EmTDyoCOQ2oZXosP+FmPKmzIoYQu92
 CzFFxl4xIQxZm3DVtJagHA8tNMrxgSRFz34XF/aonXqeloOHG9jcMlBk4hpoOcdCuhY5
 BH33pzuToAoqaBZimwb7aurC0ehdcJJZAwEWC5fWn9ueyUEaTHhXD1mBKFD7ikIqXTyH
 WF6KSxv3SK1uXw+dF1UcTx5v8C6sIVmdsy5hOVeffm23y0g7/DYkFyIdxPEOq3sghBUz
 kIxQ==
X-Gm-Message-State: AOJu0Yzwc54xXOUFf/rz9ISCXNBCwAI3x+fdIYZ3Hn16aO49wg299vr2
 3uR5GDzHmu/RU4LJumYKmR/mFqQVuPhk+dssvYGsDoCwi2tXqgmh249C6fnEgOdTl9b6m49y2Ir
 qZU4PJA7W1PXpmh72p1uGxBVMDSPT5QZgCBtIqh0h9FWHoSNssrmKG5ezCV629V0=
X-Received: by 2002:a17:906:150d:b0:a6f:f1bc:21ce with SMTP id
 a640c23a62f3a-a7245c4837emr240508566b.47.1719219647542; 
 Mon, 24 Jun 2024 02:00:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuFDg4vMl4mXJj0YJkOY4Yu0h9QNLUUllyhO25TzJD0zz4pk3MzzNyFs/gus8N4uz64OpOug==
X-Received: by 2002:a17:906:150d:b0:a6f:f1bc:21ce with SMTP id
 a640c23a62f3a-a7245c4837emr240505366b.47.1719219647050; 
 Mon, 24 Jun 2024 02:00:47 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7250010f77sm125328266b.181.2024.06.24.02.00.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 02:00:46 -0700 (PDT)
Message-ID: <cee2effc-8295-4d96-b544-e225cd0d73fb@redhat.com>
Date: Mon, 24 Jun 2024 11:00:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm: Add panel backlight quirks
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Matt Hartley <matt.hartley@gmail.com>, Kieran Levin <ktl@framework.net>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dustin Howett <dustin@howett.net>
References: <20240623-amdgpu-min-backlight-quirk-v2-0-cecf7f49da9b@weissschuh.net>
 <20240623-amdgpu-min-backlight-quirk-v2-1-cecf7f49da9b@weissschuh.net>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240623-amdgpu-min-backlight-quirk-v2-1-cecf7f49da9b@weissschuh.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Jun 2024 07:06:21 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Thomas,

On 6/23/24 10:51 AM, Thomas Weißschuh wrote:
> Panels using a PWM-controlled backlight source without an do not have a
> standard way to communicate their valid PWM ranges.
> On x86 the ranges are read from ACPI through driver-specific tables.
> The built-in ranges are not necessarily correct, or may grow stale if an
> older device can be retrofitted with newer panels.
> 
> Add a quirk infrastructure with which the valid backlight ranges can be
> maintained as part of the kernel.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  Documentation/gpu/drm-kms-helpers.rst        |  3 ++
>  drivers/gpu/drm/Kconfig                      |  4 ++
>  drivers/gpu/drm/Makefile                     |  1 +
>  drivers/gpu/drm/drm_panel_backlight_quirks.c | 67 ++++++++++++++++++++++++++++
>  include/drm/drm_utils.h                      | 11 +++++
>  5 files changed, 86 insertions(+)
> 
> diff --git a/Documentation/gpu/drm-kms-helpers.rst b/Documentation/gpu/drm-kms-helpers.rst
> index 59cfe8a7a8ba..1998a2675210 100644
> --- a/Documentation/gpu/drm-kms-helpers.rst
> +++ b/Documentation/gpu/drm-kms-helpers.rst
> @@ -224,6 +224,9 @@ Panel Helper Reference
>  .. kernel-doc:: drivers/gpu/drm/drm_panel_orientation_quirks.c
>     :export:
>  
> +.. kernel-doc:: drivers/gpu/drm/drm_panel_backlight_quirks.c
> +   :export:
> +
>  Panel Self Refresh Helper Reference
>  ===================================
>  
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 959b19a04101..50ccb43315bf 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -443,6 +443,10 @@ config DRM_EXPORT_FOR_TESTS
>  config DRM_PANEL_ORIENTATION_QUIRKS
>  	tristate
>  
> +# Separate option as not all DRM drivers use it
> +config DRM_PANEL_BACKLIGHT_QUIRKS
> +	tristate
> +
>  config DRM_LIB_RANDOM
>  	bool
>  	default n
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index f9ca4f8fa6c5..6669913b907e 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -92,6 +92,7 @@ drm-$(CONFIG_DRM_PANIC) += drm_panic.o
>  obj-$(CONFIG_DRM)	+= drm.o
>  
>  obj-$(CONFIG_DRM_PANEL_ORIENTATION_QUIRKS) += drm_panel_orientation_quirks.o
> +obj-$(CONFIG_DRM_PANEL_BACKLIGHT_QUIRKS) += drm_panel_backlight_quirks.o
>  
>  #
>  # Memory-management helpers
> diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
> new file mode 100644
> index 000000000000..a89b5fd1940e
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/array_size.h>
> +#include <linux/dmi.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <drm/drm_connector.h>
> +#include <drm/drm_utils.h>
> +
> +struct drm_panel_backlight_entry {
> +	struct {
> +		enum dmi_field field;
> +		const char * const value;
> +	} dmi_match;

Matching on a single DMI string is not always enough to uniquely identify
a machine. I would change this to a dmi_system_id struct and then add
an array with 2 dmi_system_id structs in drm_panel_backlight_entry_matches()
and copy the struct to the first array entry + zero out the second entry
(terminator) and then use dmi_check_system().

> +	struct drm_edid_ident ident;

Hmm, what about DSI panels? These do not (always) have EDID info AFAIK.

drivers/gpu/drm/drm_panel_orientation_quirks.c is using a resolution match
so as to hopefully not match external screens, but that is also so that it can
be used from efifb / simpledrm and here you really do want to differentiate
between different panels by panel model.

So I guess that the EDId match is fine and if we ever need to match DSI panels
without EDID we figure something out then.

Thinking more about this I have a question about the approach as a whole though,
I'll reply to the cover-letter with this.

Regards,

Hans



> +	struct drm_panel_backlight_quirk quirk;
> +};
> +
> +static const struct drm_panel_backlight_entry drm_panel_backlight_entries[] = {
> +};
> +
> +static bool drm_panel_backlight_entry_matches(const struct drm_panel_backlight_entry *entry,
> +					      const struct drm_edid *edid)
> +{
> +	if (!dmi_match(entry->dmi_match.field, entry->dmi_match.value))
> +		return false;
> +
> +	if (!drm_edid_match(edid, &entry->ident))
> +		return false;
> +
> +	return true;
> +}
> +
> +/**
> + * drm_get_panel_panel_quirk - Check for panel backlight quirks
> + * @edid: EDID of the panel to check
> + *
> + * This function checks for platform specific (e.g. DMI based) quirks
> + * providing info on backlight control for systems where this cannot be
> + * probed from the hard-/firm-ware.
> + *
> + * Returns:
> + * A struct drm_panel_backlight_quirk if a quirk is found or NULL otherwise.
> + */
> +const struct drm_panel_backlight_quirk *drm_get_panel_backlight_quirk(const struct drm_edid *edid)
> +{
> +	const struct drm_panel_backlight_entry *entry;
> +	size_t i;
> +
> +	if (!IS_ENABLED(CONFIG_DMI))
> +		return NULL;
> +
> +	if (!edid)
> +		return NULL;
> +
> +	for (i = 0; i < ARRAY_SIZE(drm_panel_backlight_entries); i++) {
> +		entry = &drm_panel_backlight_entries[i];
> +
> +		if (drm_panel_backlight_entry_matches(entry, edid))
> +			return &entry->quirk;
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL(drm_get_panel_backlight_quirk);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/include/drm/drm_utils.h b/include/drm/drm_utils.h
> index 70775748d243..37cc6de1a01a 100644
> --- a/include/drm/drm_utils.h
> +++ b/include/drm/drm_utils.h
> @@ -11,9 +11,20 @@
>  #define __DRM_UTILS_H__
>  
>  #include <linux/types.h>
> +#include <drm/drm_edid.h>
> +
> +struct drm_panel_backlight_quirk {
> +	struct {
> +		bool pwm_min_brightness:1;
> +	} overrides;
> +
> +	u8 pwm_min_brightness; /* min_brightness/255 of max */
> +};
>  
>  int drm_get_panel_orientation_quirk(int width, int height);
>  
> +const struct drm_panel_backlight_quirk *drm_get_panel_backlight_quirk(const struct drm_edid *edid);
> +
>  signed long drm_timeout_abs_to_jiffies(int64_t timeout_nsec);
>  
>  #endif
> 

