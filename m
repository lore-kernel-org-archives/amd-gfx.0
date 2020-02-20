Return-Path: <SRS0=opbO=4I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9EBC11D0C
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 18:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A7B524672
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 18:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kI/JlNPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7B524672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4D016EE2D;
	Thu, 20 Feb 2020 18:11:27 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F235C6EE2D
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2020 18:11:26 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id p17so3084020wma.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2020 10:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=GQQ2PB8OZDCVtv/m9hZDOmwUL+eoIyV9J82fybGpquM=;
 b=kI/JlNPlfc/3aNcf7mJHDHmVeonrKZCX85dE4PnLxHIlLd1jqah7m4YSCAuegLXjDf
 ZRlZvfY+jhGZ3WxxQC1EempH3JY5KOv7elWlMDqimYijIaNN/4sUjCzKkhelZC9oHWIP
 b2buLRaOLaDu3MGy/QO7OzsHjIpyRoXMLkkYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GQQ2PB8OZDCVtv/m9hZDOmwUL+eoIyV9J82fybGpquM=;
 b=By4LksmrLS6F6URPeQ3iEuZ/YrkclXCnhfH+gS+0byJ2C6/R5KGC+IMz3adS7N4Y16
 WkKZGu79J9ks3B9EbsPLWMgponhCp/JFNNgutUP05HkcPp4zuri+Vl/ZNraOBY0s73MS
 XxVvGTlJnkGNjiR4HQoppOx/1w48v76HYNfg4AKDSDIN6Eiz/AowgUmSTNLHHDNqBY3n
 5Qs/eZtwAGvFfneu7liCrmUgjsZlsMwh+4qW5yVP+MGXYvlBWu7PRgerGUUmR5RLzyYH
 wgGVR5xTCHmZmkTQwfMp3xRKRh3OYi6Dwur1TkRjb4VgsGNEQgmeKBc6CIyqvG2NrQ/J
 PIHg==
X-Gm-Message-State: APjAAAUs9LKYhDre/O4Nym0QjDqQCOxj7Uhws1Hg6QZ16Dw/YTN4IQ1+
 9rkYUnVnxtC3QaGGIbf6A/LXXA==
X-Google-Smtp-Source: APXvYqxIqb+oUCljVbphtriJA3QySvJpWOVKPYSAEUVVzetfo1F/iD65IBk402Y7xmeO2vawMEO7dg==
X-Received: by 2002:a7b:c216:: with SMTP id x22mr5962038wmi.51.1582222285705; 
 Thu, 20 Feb 2020 10:11:25 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id c15sm452900wrt.1.2020.02.20.10.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 10:11:25 -0800 (PST)
Date: Thu, 20 Feb 2020 19:11:23 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Nirmoy Das <nirmoy.aiemd@gmail.com>
Subject: Re: [PATCH 7/8] drm/bochs: use drm_gem_vram_offset to get bo offset v2
Message-ID: <20200220181123.GU2363188@phenom.ffwll.local>
References: <20200219135322.56463-1-nirmoy.das@amd.com>
 <20200219135322.56463-8-nirmoy.das@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200219135322.56463-8-nirmoy.das@amd.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
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
Cc: David1.Zhou@amd.com, thellstrom@vmware.com, amd-gfx@lists.freedesktop.org,
 airlied@linux.ie, kenny.ho@amd.com, brian.welty@intel.com,
 maarten.lankhorst@linux.intel.com, dri-devel@lists.freedesktop.org,
 nirmoy.das@amd.com, linux-graphics-maintainer@vmware.com, kraxel@redhat.com,
 daniel@ffwll.ch, alexander.deucher@amd.com, sean@poorly.run,
 christian.koenig@amd.com, bskeggs@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 19, 2020 at 02:53:21PM +0100, Nirmoy Das wrote:
> Switch over to GEM VRAM's implementation to retrieve bo->offset
> 
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/bochs/bochs_kms.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
> index 8066d7d370d5..18d2ec34534d 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -29,16 +29,21 @@ static void bochs_plane_update(struct bochs_device *bochs,
>  			       struct drm_plane_state *state)
>  {
>  	struct drm_gem_vram_object *gbo;
> +	s64 gpu_addr;
> 
>  	if (!state->fb || !bochs->stride)
>  		return;
> 
>  	gbo = drm_gem_vram_of_gem(state->fb->obj[0]);
> +	gpu_addr = drm_gem_vram_offset(gbo);
> +	if (WARN_ON_ONCE(gpu_addr < 0))
> +		return; /* Bug: we didn't pin the BO to VRAM in prepare_fb. */

That negative errno in gpu_addr from vram helpers is kinda wild.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> +
>  	bochs_hw_setbase(bochs,
>  			 state->crtc_x,
>  			 state->crtc_y,
>  			 state->fb->pitches[0],
> -			 state->fb->offsets[0] + gbo->bo.offset);
> +			 state->fb->offsets[0] + gpu_addr);
>  	bochs_hw_setformat(bochs, state->fb->format);
>  }
> 
> --
> 2.25.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
