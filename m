Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581BDC04FF6
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 12:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29A5610EDDF;
	Tue, 16 Apr 2024 12:58:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jLkrUvB3";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 933FA1126B5
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 16:04:04 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2a2dd2221d3so2435753a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 09:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1713197044; x=1713801844;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0q8sbp3Y1+9QAKNBKj5ZqirHCx85mywDMCySQTv0jxo=;
 b=jLkrUvB34uX8GrN6wmBBaLUsHHls30n2/Lsk65DbMgh1vI0zBo/pBnAovngqGTA9cD
 SzebwjrkMMDELXkKXkrSa1eu3f4k0ZrdRx2dkS1JHD9SZzWC48+bE3IhZF3xxmNvsGEk
 wXrtRXb8r3SHl//QI7McCB1MvzezmN7tclUU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713197044; x=1713801844;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0q8sbp3Y1+9QAKNBKj5ZqirHCx85mywDMCySQTv0jxo=;
 b=g33fLmShCwIoJfioBWuN2rsBPlJym2WruA0ucnFI4fB6j+IRIIytUnq+MVwqMsXUJ1
 hfcifxEDEQ1bZSnayb80AfzSVv89aK0H1xFRIGZkap3REVE2CGg2uW9mNKejDSORXbqD
 nHRZqjjZCkpZ9JnaB6LFpDbIGfNw7eJnSAM/loaGgFZEEJ0pVgzTMwj47XZ9Cu4M8C5j
 VspU1zrw9jwm+T9aOuK26QR2SFhqDiSJ3zbWpMzNzm9b5qQDAzun8VurTRodbVTxCBZm
 h6RNCr9utC57OCIrq4SaCtC1sJow+dm1ixmLZ4u8dEzNetl47sAxyMxJ7Jc86mMclGTS
 EuAQ==
X-Gm-Message-State: AOJu0YyKlTLGW8Twf98XBhlZoIQoCApjQTbpfep8QeC0MO0HtQ900Vuq
 dsW9ui8S8kwuCSgd0vfgNt+A39Lvv6eG+JR6yVPCjFUNd+o7awMDilVfSxi3EQ==
X-Google-Smtp-Source: AGHT+IFyPJpdLSUb+D9g1+F5zvvfq0oKyd7nXX5YfHYMRoAkLm8Otc/+da6xcYB5RyDvK8zWnGgtXg==
X-Received: by 2002:a17:90b:180a:b0:2a2:55de:93eb with SMTP id
 lw10-20020a17090b180a00b002a255de93ebmr7794960pjb.33.1713197043819; 
 Mon, 15 Apr 2024 09:04:03 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
 by smtp.gmail.com with ESMTPSA id
 42-20020a17090a09ad00b002a2a3aebb38sm8054366pjo.48.2024.04.15.09.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 09:04:03 -0700 (PDT)
Date: Mon, 15 Apr 2024 09:04:02 -0700
From: Kees Cook <keescook@chromium.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/radeon: make -fstrict-flex-arrays=3 happy
Message-ID: <202404150859.386B8EBAFA@keescook>
References: <20240415133816.1053794-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415133816.1053794-1-alexander.deucher@amd.com>
X-Mailman-Approved-At: Tue, 16 Apr 2024 12:58:46 +0000
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

On Mon, Apr 15, 2024 at 09:38:16AM -0400, Alex Deucher wrote:
> The driver parses a union where the layout up through the first
> array is the same, however, the array has different sizes
> depending on the elements in the union.  Be explicit to
> fix the UBSAN checker.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3323
> Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Kees Cook <keescook@chromium.org>

Yup, this looks correct to me. These were trailing arrays that were not
bounds checked prior to -fstrict-flex-arrays=3:

#define ATOM_DEVICE_DFP3_INDEX                            0x00000009
...
#define ATOM_DEVICE_DFP5_INDEX                            0x0000000B
...
#define ATOM_DEVICE_RESERVEDF_INDEX                       0x0000000F
...
#define ATOM_MAX_SUPPORTED_DEVICE_INFO			  (ATOM_DEVICE_DFP3_INDEX+1)
...
#define ATOM_MAX_SUPPORTED_DEVICE			  (ATOM_DEVICE_RESERVEDF_INDEX+1)

typedef struct _ATOM_SUPPORTED_DEVICES_INFO
	...
  ATOM_CONNECTOR_INFO_I2C   asConnInfo[ATOM_MAX_SUPPORTED_DEVICE_INFO];


typedef struct _ATOM_SUPPORTED_DEVICES_INFO_2
	...
  ATOM_CONNECTOR_INFO_I2C       asConnInfo[ATOM_MAX_SUPPORTED_DEVICE];

And these arrays had different sizes: 10 vs 16

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/gpu/drm/radeon/radeon_atombios.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
> index bb1f0a3371ab5..10793a433bf58 100644
> --- a/drivers/gpu/drm/radeon/radeon_atombios.c
> +++ b/drivers/gpu/drm/radeon/radeon_atombios.c
> @@ -923,8 +923,12 @@ bool radeon_get_atom_connector_info_from_supported_devices_table(struct
>  		max_device = ATOM_MAX_SUPPORTED_DEVICE_INFO;
>  
>  	for (i = 0; i < max_device; i++) {
> -		ATOM_CONNECTOR_INFO_I2C ci =
> -		    supported_devices->info.asConnInfo[i];
> +		ATOM_CONNECTOR_INFO_I2C ci;
> +
> +		if (frev > 1)
> +			ci = supported_devices->info_2d1.asConnInfo[i];
> +		else
> +			ci = supported_devices->info.asConnInfo[i];
>  
>  		bios_connectors[i].valid = false;
>  
> -- 
> 2.44.0
> 

-- 
Kees Cook
