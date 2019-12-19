Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9952C43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 15:10:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BADC2072B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 15:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="v7s7EMz6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BADC2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E2DC6EC51;
	Fri, 20 Dec 2019 15:10:37 +0000 (UTC)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EEE66EBB2
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 23:33:10 +0000 (UTC)
Received: by mail-pl1-x642.google.com with SMTP id bd4so3272978plb.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 15:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=XkA3Ag1xZNcaUv5ig0ncH6ge+8P8NEi38UXcVKQ4TwA=;
 b=v7s7EMz6F475uFm82JRnKzFk78aFoLCZTTy0lM2CD7qS8AEl4BTZvbneoYwwp8M172
 vc4HjkY8cmpGvuHwr2t41pbR2jPe1QEfPuzLfKZCH2XKKgUUL+qHWWZIDQX6oaf8kB75
 kJrTkXjhOrQOJ9MGd8R6vQ9MlLYc6pRa4uIBDZIt8/PT2srbkLVoAVkQr8GyUfbUDdVK
 zIsDPGbYRQoGdDBdvkti+ZCnBVR9snqyIpTYNMktXlZ+ZgrCNlwvFQNVl+w9q7u5SCbD
 8/xDDqU58LIHgs6RVvqmhgBepPUs0vy71OoYfF3Z3kfasK7bvisd+ClVa9hOHDozn+t+
 xO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=XkA3Ag1xZNcaUv5ig0ncH6ge+8P8NEi38UXcVKQ4TwA=;
 b=COEEMev/mujlWwAPR35ez0AWqeJs/eRoPtC2F3KXJvQAjy8dHeJSC5bOtTfJ/77lr0
 R2gg/Tz3DJO2A7Q4VwNLxxsIvKBtJ/k88J01sgWshyeFi3md2UeK0mpBw5hKORv+WRK9
 N6mGv0zbsLA3sqOrYi/C76M7Yz0o2nS3QfK+JonHepV06IEVdHYnkpdEbS3lI2ECLifp
 l+gEO/YIMELLD9tGoV9bD69gxwhVscv9YqnHEi8MHM3DstNlYyWoHARtfVPgdHlB2HKB
 /1TrYgwYEwVqnobMB6gMwYWU7vvltClXsCx0As8a767aFQt6vAQezQZZOSnOO+kek3dJ
 G9mA==
X-Gm-Message-State: APjAAAXTN6fUvvLzDcFPIgOGh+qME7o36kWi3AGzartug+AmziL87ohQ
 Kn/5Yb7IFBXMhROT+4BWXy491g==
X-Google-Smtp-Source: APXvYqzYlqJkLdvsbUJyp3YSGgiYAdhSq6nsa2U4gRA/0IO+8qtfsLKllFDDPsKVZabbpkR4Fom7ZQ==
X-Received: by 2002:a17:902:6a87:: with SMTP id
 n7mr11349464plk.273.1576798389633; 
 Thu, 19 Dec 2019 15:33:09 -0800 (PST)
Received: from google.com ([2620:0:1000:2511:b34b:87b6:d099:91b0])
 by smtp.gmail.com with ESMTPSA id j21sm9239081pfe.175.2019.12.19.15.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 15:33:08 -0800 (PST)
Date: Thu, 19 Dec 2019 15:33:03 -0800
From: Tom Anderson <thomasanderson@google.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH v2] drm/amd/display: Reduce HDMI pixel encoding if max
 clock is exceeded
Message-ID: <20191219233303.GA131109@google.com>
References: <20191202214713.41001-1-thomasanderson@google.com>
 <20191210185924.GA20941@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191210185924.GA20941@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Fri, 20 Dec 2019 15:10:36 +0000
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
Cc: David Zhou <David1.Zhou@amd.com>,
 Mario Kleiner <mario.kleiner.de@gmail.com>, David Airlie <airlied@linux.ie>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping.  Is there any action required to get this landed?

On Tue, Dec 10, 2019 at 10:59:24AM -0800, Tom Anderson wrote:
> Friendly ping.
> 
> On Mon, Dec 02, 2019 at 01:47:13PM -0800, Thomas Anderson wrote:
> > For high-res (8K) or HFR (4K120) displays, using uncompressed pixel
> > formats like YCbCr444 would exceed the bandwidth of HDMI 2.0, so the
> > "interesting" modes would be disabled, leaving only low-res or low
> > framerate modes.
> > 
> > This change lowers the pixel encoding to 4:2:2 or 4:2:0 if the max TMDS
> > clock is exceeded. Verified that 8K30 and 4K120 are now available and
> > working with a Samsung Q900R over an HDMI 2.0b link from a Radeon 5700.
> > 
> > Signed-off-by: Thomas Anderson <thomasanderson@google.com>
> > ---
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 45 ++++++++++---------
> >  1 file changed, 23 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 7aac9568d3be..803e59d97411 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -3356,27 +3356,21 @@ get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing)
> >  	return color_space;
> >  }
> >  
> > -static void reduce_mode_colour_depth(struct dc_crtc_timing *timing_out)
> > -{
> > -	if (timing_out->display_color_depth <= COLOR_DEPTH_888)
> > -		return;
> > -
> > -	timing_out->display_color_depth--;
> > -}
> > -
> > -static void adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_out,
> > -						const struct drm_display_info *info)
> > +static bool adjust_colour_depth_from_display_info(
> > +	struct dc_crtc_timing *timing_out,
> > +	const struct drm_display_info *info)
> >  {
> > +	enum dc_color_depth depth = timing_out->display_color_depth;
> >  	int normalized_clk;
> > -	if (timing_out->display_color_depth <= COLOR_DEPTH_888)
> > -		return;
> >  	do {
> >  		normalized_clk = timing_out->pix_clk_100hz / 10;
> >  		/* YCbCr 4:2:0 requires additional adjustment of 1/2 */
> >  		if (timing_out->pixel_encoding == PIXEL_ENCODING_YCBCR420)
> >  			normalized_clk /= 2;
> >  		/* Adjusting pix clock following on HDMI spec based on colour depth */
> > -		switch (timing_out->display_color_depth) {
> > +		switch (depth) {
> > +		case COLOR_DEPTH_888:
> > +			break;
> >  		case COLOR_DEPTH_101010:
> >  			normalized_clk = (normalized_clk * 30) / 24;
> >  			break;
> > @@ -3387,14 +3381,15 @@ static void adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_
> >  			normalized_clk = (normalized_clk * 48) / 24;
> >  			break;
> >  		default:
> > -			return;
> > +			/* The above depths are the only ones valid for HDMI. */
> > +			return false;
> >  		}
> > -		if (normalized_clk <= info->max_tmds_clock)
> > -			return;
> > -		reduce_mode_colour_depth(timing_out);
> > -
> > -	} while (timing_out->display_color_depth > COLOR_DEPTH_888);
> > -
> > +		if (normalized_clk <= info->max_tmds_clock) {
> > +			timing_out->display_color_depth = depth;
> > +			return true;
> > +		}
> > +	} while (--depth > COLOR_DEPTH_666);
> > +	return false;
> >  }
> >  
> >  static void fill_stream_properties_from_drm_display_mode(
> > @@ -3474,8 +3469,14 @@ static void fill_stream_properties_from_drm_display_mode(
> >  
> >  	stream->out_transfer_func->type = TF_TYPE_PREDEFINED;
> >  	stream->out_transfer_func->tf = TRANSFER_FUNCTION_SRGB;
> > -	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
> > -		adjust_colour_depth_from_display_info(timing_out, info);
> > +	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A) {
> > +		if (!adjust_colour_depth_from_display_info(timing_out, info) &&
> > +		    drm_mode_is_420_also(info, mode_in) &&
> > +		    timing_out->pixel_encoding != PIXEL_ENCODING_YCBCR420) {
> > +			timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
> > +			adjust_colour_depth_from_display_info(timing_out, info);
> > +		}
> > +	}
> >  }
> >  
> >  static void fill_audio_info(struct audio_info *audio_info,
> > -- 
> > 2.24.0.393.g34dc348eaf-goog
> > 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
