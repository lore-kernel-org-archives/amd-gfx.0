Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CD7C531DC
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 09:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04C5910E189;
	Mon, 12 Aug 2024 09:25:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="bRZqPhYa";
	dkim-atps=neutral
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2667310E18B
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 09:25:57 +0000 (UTC)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-52efcbfacb9so308176e87.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 02:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1723454755; x=1724059555; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PpE4MZG4dPxO0eI+LKyNHlvghK3FLqrgCxApywGKxvA=;
 b=bRZqPhYaD/Env17r8yuFzfqjZPDJ7EYpr9DtOpzsyPkE6k3PF9UwKy6zZW0HOiyS3e
 XAQ++3sgatbdb+OvSu9pP90IEGQ0C6mQNflxvX57MNSpmgeUcbDABSLAcYCVY3gWj38F
 P8v0TahsKZ/ouslzkyr0dYUeQ7NFibwa71p30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723454755; x=1724059555;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PpE4MZG4dPxO0eI+LKyNHlvghK3FLqrgCxApywGKxvA=;
 b=dsaqTc3FpQA4sZP9EmdgS2ESVLZM8WU1LRLvg0EYcNYjrXvB5dm13gV2d7i4G9C4YU
 0sSx2kxnhAIvvfAJ7U5prl5V78yn2XXU7R9WefqsptNiMakqHoM1tx+eH7dut5Zp4fja
 PWEb1Uo83MDBXk37icBreEI5CMySKCTjfe1sNq49E/GV/ZiNrzeu+pmWjSOxUNKKvJh5
 vB6uJRVrjcrWii3kN2qAw9ixRs8ApchUOxo+OTToCbsVoAxpjA1I0mxNaf7hFAsUkSeu
 +1CiJkjqG7wkD/kDmM+Yno035n87hA47Jv1lUt696aSwXaqD2URffW+gQlnPIerdMNmp
 RDpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ3oOdqeSMrSL21DNWq7cKDq3yfxZjmj+MLNeG4pXXysenHGswh1txz84G9wZU++2o0weloq5dDZFoP5V0f+Psa3u+mvXXo6e/oMtNZA==
X-Gm-Message-State: AOJu0YxX675wzFisF4PRXljfXO0furiJ6naOK8GjW4YdsKxhVPUjkK1b
 EX32FWv4T8CqS9Loj85VVKgtRcd6v5+yFeN2rSgrBgSBPC0e9C/VjSrEGH9UuXo=
X-Google-Smtp-Source: AGHT+IFyP3B+DPVgAk3XU47ipNAMHaOZwK7yNfgUMPbL6OG4/u4qG0twjjsRgz6cjZLh5u5fALIoHw==
X-Received: by 2002:a05:6512:3ca9:b0:52f:cf27:69f3 with SMTP id
 2adb3069b0e04-530ee97ad7dmr3513397e87.2.1723454754954; 
 Mon, 12 Aug 2024 02:25:54 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80bb24323dsm212069466b.214.2024.08.12.02.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 02:25:54 -0700 (PDT)
Date: Mon, 12 Aug 2024 11:25:52 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org
Subject: Re: [PATCH v2 7/9] drm/fbdev-helper: Remove
 drm_fb_helper_output_poll_changed()
Message-ID: <ZrnVINAxwc-FcjFR@phenom.ffwll.local>
References: <20240812083000.337744-1-tzimmermann@suse.de>
 <20240812083000.337744-8-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812083000.337744-8-tzimmermann@suse.de>
X-Operating-System: Linux phenom 6.9.10-amd64 
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

On Mon, Aug 12, 2024 at 10:28:28AM +0200, Thomas Zimmermann wrote:
> The function is unused. Remove it.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/drm_fb_helper.c | 15 ---------------
>  include/drm/drm_fb_helper.h     |  6 ------
>  2 files changed, 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index fe5667477839..29c53f9f449c 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -2003,18 +2003,3 @@ void drm_fb_helper_lastclose(struct drm_device *dev)
>  	drm_fb_helper_restore_fbdev_mode_unlocked(dev->fb_helper);
>  }
>  EXPORT_SYMBOL(drm_fb_helper_lastclose);
> -
> -/**
> - * drm_fb_helper_output_poll_changed - DRM mode config \.output_poll_changed
> - *                                     helper for fbdev emulation
> - * @dev: DRM device
> - *
> - * This function can be used as the
> - * &drm_mode_config_funcs.output_poll_changed callback for drivers that only
> - * need to call drm_fbdev.hotplug_event().
> - */
> -void drm_fb_helper_output_poll_changed(struct drm_device *dev)
> -{
> -	drm_fb_helper_hotplug_event(dev->fb_helper);
> -}
> -EXPORT_SYMBOL(drm_fb_helper_output_poll_changed);
> diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
> index 375737fd6c36..699f2790b9ac 100644
> --- a/include/drm/drm_fb_helper.h
> +++ b/include/drm/drm_fb_helper.h
> @@ -271,9 +271,7 @@ int drm_fb_helper_hotplug_event(struct drm_fb_helper *fb_helper);
>  int drm_fb_helper_initial_config(struct drm_fb_helper *fb_helper);
>  int drm_fb_helper_debug_enter(struct fb_info *info);
>  int drm_fb_helper_debug_leave(struct fb_info *info);
> -
>  void drm_fb_helper_lastclose(struct drm_device *dev);
> -void drm_fb_helper_output_poll_changed(struct drm_device *dev);
>  #else
>  static inline void drm_fb_helper_prepare(struct drm_device *dev,
>  					 struct drm_fb_helper *helper,
> @@ -401,10 +399,6 @@ static inline int drm_fb_helper_debug_leave(struct fb_info *info)
>  static inline void drm_fb_helper_lastclose(struct drm_device *dev)
>  {
>  }
> -
> -static inline void drm_fb_helper_output_poll_changed(struct drm_device *dev)
> -{
> -}
>  #endif
>  
>  #endif
> -- 
> 2.46.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
