Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3447AC02180
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 15:49:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D448810E6F1;
	Mon, 13 Jan 2025 15:49:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="WNVsjbnN";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D130D10E5DD
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 09:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736760353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Anfkmk5eIXHRBtHcAoLzGmn+FA7n8XKUaOMpxGXT8us=;
 b=WNVsjbnNFe49d26YdXLkcTiczGm2VmRM5HLl67nUh2Bo3v1VOaXdNB497pnE36aYlSva8O
 2YlB4QAUlacFk2ZaTteEltmXuAskkn8S0LF+l4dBaHuOc6XpvcCeZIlgiA7jeVF54GQPH1
 /r5MAdK0jHTOSTb4+lHPtK8zF86D/5g=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-sWkjfQHnNAee7OtxF23ssg-1; Mon, 13 Jan 2025 04:25:51 -0500
X-MC-Unique: sWkjfQHnNAee7OtxF23ssg-1
X-Mimecast-MFC-AGG-ID: sWkjfQHnNAee7OtxF23ssg
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5d3f4cbbbbcso3939744a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 01:25:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736760350; x=1737365150;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Anfkmk5eIXHRBtHcAoLzGmn+FA7n8XKUaOMpxGXT8us=;
 b=D9iF7v9irFA0y3wgpoWYlywU+xu0z4KDAnFqRWN7XKBuPXpLee5RyQ6G8lUTjvQpXz
 267XL4PfuJc2bfteqVXAmuE89BEQIBKPwackYYUHkuEaT/b7GglNockYK/Zyk8kDw+Ff
 WzjO/Ar7AMnpXn2XDGrx41pCYeE3VQkbVne3F2V7yEFVGjgzk0/fdgVNnGTgJNkChkjz
 JltUvoHA+hqkrp7V8bzyr4qz36KehS8xwrhD/qB8V1vR2qOuGuZd/HZjYVUtBJGR9Q5z
 vIysnBDOJWygwoGHkd/ZveMEQT036GVWssENaxIi/64KbkHeuWHpmIpfQwzhuNWTL3dN
 Kt4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXH3NBMkcUAbNvBVOLLpaQJoBpgprGuCpF8ygFSMgLVfeCXQE2o9m3UOQTqS63djZH5wimqo0H@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz9p7VzSPwSbqE95OdRKR2DGJpGok+3TeU14VaA1cOVnTBu2lfn
 ashkjrGVb/4mIPNzwtWRDZBA+/b3H6iS8O7kTcXcMAVAAMFsNqZwXKiH52Si/B5Buu4OQ/4/Gc0
 xVWPSvzdNva9n3qPRykJ4OfK6DzcJfzf8ChmcJGcUOWayCSG+nZL6ubVaJSaGe28=
X-Gm-Gg: ASbGncttW8iCuNG/KPJhah3/YHUmrMmBdeejPzfxI7Z1B8bEk8CiaRr6RGRMwKMtIGB
 MP272fWyH9j3KsPB0QeNHBuX7Hx7uw1KXBsGbru2g+ZZzuU++WceaYIxLg06Ezx30IOZUh36s+H
 NtHi+hNmgpnxZRjT64KFYyztfKSiT9sJRShSTixYXKlcWXVQ6ViHRagmJ2RMfqSV+pKZLAHoPZy
 8ZMhlX/TglDz1FfLhgU/+wPJDbOJwf7ntGAikeKD8j9eowHK/iBEgU2HdWt
X-Received: by 2002:a05:6402:360c:b0:5d0:e826:f0da with SMTP id
 4fb4d7f45d1cf-5d972e1683fmr19533139a12.16.1736760350249; 
 Mon, 13 Jan 2025 01:25:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG78H0pXhzhxaOz7jwatHbOLLwf8gzKXFnmuzkS+oexEXq4wWGsB1QoLdJwllz3q9jZAAjDsQ==
X-Received: by 2002:a05:6402:360c:b0:5d0:e826:f0da with SMTP id
 4fb4d7f45d1cf-5d972e1683fmr19533112a12.16.1736760349793; 
 Mon, 13 Jan 2025 01:25:49 -0800 (PST)
Received: from [10.40.98.179] ([78.108.130.194])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d990469ee8sm4720711a12.70.2025.01.13.01.25.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2025 01:25:49 -0800 (PST)
Message-ID: <809d617e-b0e5-4322-a6fe-00923babe5f3@redhat.com>
Date: Mon, 13 Jan 2025 10:25:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: video: Fix random crashes due to bad kfree
To: Chris Bainbridge <chris.bainbridge@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, alex.hung@amd.com,
 regressions@lists.linux.dev, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <Z2yQvTyg_MWwrlj3@debian.local>
 <b98f2fa5-fbe8-4958-bf20-fa5d28c5a38b@math.uni-bielefeld.de>
 <Z2yw_eJwR5ih1Npr@debian.local>
 <CAJZ5v0i=ap+w4QZ8f2DsaHY6D=XUEuSNjyQ-2_=DGOLfZjdn+w@mail.gmail.com>
 <Z4K_oQL7eA9Owkbs@debian.local>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Z4K_oQL7eA9Owkbs@debian.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uxImqMLK4ZSwnjWavi7ryRpGBZ9aGDf1_JXs7WRMhl8_1736760350
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 13 Jan 2025 15:49:32 +0000
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

Hi,

On 11-Jan-25 7:59 PM, Chris Bainbridge wrote:
> Commit c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if
> available for eDP") added function dm_helpers_probe_acpi_edid, which
> fetches the EDID from the BIOS by calling acpi_video_get_edid.
> acpi_video_get_edid returns a pointer to the EDID, but this pointer does
> not originate from kmalloc - it is actually the internal "pointer" field
> from an acpi_buffer struct (which did come from kmalloc).
> dm_helpers_probe_acpi_edid then attempts to kfree the EDID pointer,
> resulting in memory corruption which leads to random, intermittent
> crashes (e.g. 4% of boots will fail with some Oops).
> 
> Fix this by allocating a new array (which can be safely freed) for the
> EDID data, and correctly freeing the acpi_buffer pointer.
> 
> The only other caller of acpi_video_get_edid is nouveau_acpi_edid:
> remove the extraneous kmemdup here as the EDID data is now copied in
> acpi_video_device_EDID.
> 
> Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
> Fixes: c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if available for eDP")
> ---> Changes in v2:
> 	- check kmemdup() return value
> 	- move buffer management into acpi_video_device_EDID()
> 	- return actual length value of buffer

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/acpi/acpi_video.c              | 50 ++++++++++++++------------
>  drivers/gpu/drm/nouveau/nouveau_acpi.c |  2 +-
>  2 files changed, 29 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 8274a17872ed..3c627bdf2d1b 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -610,16 +610,29 @@ acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
>  	return 0;
>  }
>  
> +/*
> + *  Arg:
> + *	device	: video output device (LCD, CRT, ..)
> + *	edid    : address for returned EDID pointer
> + *	length  : _DDC length to request (must be a multiple of 128)
> + *
> + *  Return Value:
> + *	Length of EDID (positive value) or error (negative value)
> + *
> + *  Get EDID from ACPI _DDC. On success, a pointer to the EDID data is written
> + *  to the edid address, and the length of the EDID is returned. The caller is
> + *  responsible for freeing the edid pointer.
> + */
> +
>  static int
> -acpi_video_device_EDID(struct acpi_video_device *device,
> -		       union acpi_object **edid, int length)
> +acpi_video_device_EDID(struct acpi_video_device *device, void **edid, int length)
>  {
> -	int status;
> +	acpi_status status;
>  	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>  	union acpi_object *obj;
>  	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
>  	struct acpi_object_list args = { 1, &arg0 };
> -
> +	int ret;
>  
>  	*edid = NULL;
>  
> @@ -636,16 +649,17 @@ acpi_video_device_EDID(struct acpi_video_device *device,
>  
>  	obj = buffer.pointer;
>  
> -	if (obj && obj->type == ACPI_TYPE_BUFFER)
> -		*edid = obj;
> -	else {
> +	if (obj && obj->type == ACPI_TYPE_BUFFER) {
> +		*edid = kmemdup(obj->buffer.pointer, obj->buffer.length, GFP_KERNEL);
> +		ret = *edid ? obj->buffer.length : -ENOMEM;
> +	} else {
>  		acpi_handle_debug(device->dev->handle,
>  				 "Invalid _DDC data for length %d\n", length);
> -		status = -EFAULT;
> -		kfree(obj);
> +		ret = -EFAULT;
>  	}
>  
> -	return status;
> +	kfree(obj);
> +	return ret;
>  }
>  
>  /* bus */
> @@ -1435,9 +1449,7 @@ int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
>  {
>  	struct acpi_video_bus *video;
>  	struct acpi_video_device *video_device;
> -	union acpi_object *buffer = NULL;
> -	acpi_status status;
> -	int i, length;
> +	int i, length, ret;
>  
>  	if (!device || !acpi_driver_data(device))
>  		return -EINVAL;
> @@ -1477,16 +1489,10 @@ int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
>  		}
>  
>  		for (length = 512; length > 0; length -= 128) {
> -			status = acpi_video_device_EDID(video_device, &buffer,
> -							length);
> -			if (ACPI_SUCCESS(status))
> -				break;
> +			ret = acpi_video_device_EDID(video_device, edid, length);
> +			if (ret > 0)
> +				return ret;
>  		}
> -		if (!length)
> -			continue;
> -
> -		*edid = buffer->buffer.pointer;
> -		return length;
>  	}
>  
>  	return -ENODEV;
> diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> index 8f0c69aad248..21b56cc7605c 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> @@ -384,7 +384,7 @@ nouveau_acpi_edid(struct drm_device *dev, struct drm_connector *connector)
>  	if (ret < 0)
>  		return NULL;
>  
> -	return kmemdup(edid, EDID_LENGTH, GFP_KERNEL);
> +	return edid;
>  }
>  
>  bool nouveau_acpi_video_backlight_use_native(void)

