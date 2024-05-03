Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765F8C25B5C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 10:00:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1084C10EDB2;
	Mon,  6 May 2024 10:00:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UFnZ/kdy";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6E0C113035
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 15:11:46 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-41bca450fa3so49369485e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 May 2024 08:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714749105; x=1715353905; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=24KooxCxQo5B4mkD0Xv8UXKV+DdaJkaLJTYBeX9a25Q=;
 b=UFnZ/kdyv2dc99NkZ4FTak1S/jgy+tjEzL8UgJQJ7BEw17UZ5mgBYUdIzQliDJWRxL
 re2vF6f33mH5DnpId0+qqc8evLS2Un5fkk4OkOnzaBsvzDpMCqF7Zf5I4WDWkq56YLPC
 VW0cXbtt0NEuley5byDRe+JylcXcHg3LPGFzBbDzmiyPl2so8fYcQwJGx87O73xldfM1
 oCgV8yVlkIdQZ6aHPB7iMKTl28p5U8FH7SH2zMG0T70p3/HG3myOkg8BTJsv4iwEgkPN
 XujJu5y2+x4RmUix4xHIbaidVLTJ/M8iyQhbarddmE+c6gIUZvpGVFYTyvk5W1iF6BHD
 BKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714749105; x=1715353905;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=24KooxCxQo5B4mkD0Xv8UXKV+DdaJkaLJTYBeX9a25Q=;
 b=NICJvVuma55apKUkwGgoGC/Gg85rLQXDxi1v4Q66kDFWoBcFgo8pm5ADiYQp5nJe7e
 G0Sz9EJDqMODbKb9TX81Pky2j3zmyYFbXV1DnT/7yjuDBuMiQi6pITcKCmdgWAf0iG3P
 gGqC6fP90gIMAE1+BmMzsYC1m/D0tlCkvfLpyt3/CkkrJKd/qx3V606ik0tj2MhbL3sx
 c/G3FUsQO6YLGld+/wd8km283Vp42UpOva3roi2d8zUTKG3vAd29t3a92Q3d+llsCeMG
 5CJQH5bbS2bwMtd4lHnO5/PsAk6iT7vbuywcF1nwHv51LqyBGzlz2YIpbk5iUge2aiUA
 U6AA==
X-Gm-Message-State: AOJu0YyeZmjZGxXBNWtdAZuRwJCuph4F4wiaSqVuEy4OMRPVJgcsHfq6
 tp9H21+5OrQsYWmtCzVez4vNNc37PDGNx1AIIZVSyuP5/YfBmnNMZVYZflWO2Uo=
X-Google-Smtp-Source: AGHT+IHlZuNVf1eRDniauHeSFsXqMZoOIAQNjHRHaTcHpQ7olDBueGR+XwYcb4QJOCOBy0zWBOCcWg==
X-Received: by 2002:a05:600c:4446:b0:41b:4de0:7bff with SMTP id
 v6-20020a05600c444600b0041b4de07bffmr2406465wmn.35.1714749104808; 
 Fri, 03 May 2024 08:11:44 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 b12-20020a5d4d8c000000b0034e65b8b43fsm1958936wru.8.2024.05.03.08.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 08:11:44 -0700 (PDT)
Date: Fri, 3 May 2024 18:11:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: harry.wentland@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [bug report] drm/amd/display: Do cursor programming with rest of pipe
Message-ID: <951e4058-ac52-4690-bb77-70929a7e3ce4@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 06 May 2024 09:59:59 +0000
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

Hello Harry Wentland,

Commit 66eba12a5482 ("drm/amd/display: Do cursor programming with
rest of pipe") from Mar 15, 2024 (linux-next), leads to the following
Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8433 amdgpu_dm_update_cursor()
	error: we previously assumed 'afb' could be null (see line 8388)

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
    8379 static void amdgpu_dm_update_cursor(struct drm_plane *plane,
    8380                                     struct drm_plane_state *old_plane_state,
    8381                                     struct dc_stream_update *update)
    8382 {
    8383         struct amdgpu_device *adev = drm_to_adev(plane->dev);
    8384         struct amdgpu_framebuffer *afb = to_amdgpu_framebuffer(plane->state->fb);
    8385         struct drm_crtc *crtc = afb ? plane->state->crtc : old_plane_state->crtc;
                                         ^^^^^

    8386         struct dm_crtc_state *crtc_state = crtc ? to_dm_crtc_state(crtc->state) : NULL;
    8387         struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
    8388         uint64_t address = afb ? afb->address : 0;
                                    ^^^^^
Checks for NULL

    8389         struct dc_cursor_position position = {0};
    8390         struct dc_cursor_attributes attributes;
    8391         int ret;
    8392 
    8393         if (!plane->state->fb && !old_plane_state->fb)
    8394                 return;
    8395 
    8396         drm_dbg_atomic(plane->dev, "crtc_id=%d with size %d to %d\n",
    8397                        amdgpu_crtc->crtc_id, plane->state->crtc_w,
    8398                        plane->state->crtc_h);
    8399 
    8400         ret = amdgpu_dm_plane_get_cursor_position(plane, crtc, &position);
    8401         if (ret)
    8402                 return;
    8403 
    8404         if (!position.enable) {
    8405                 /* turn off cursor */
    8406                 if (crtc_state && crtc_state->stream) {
    8407                         dc_stream_set_cursor_position(crtc_state->stream,
    8408                                                       &position);
    8409                         update->cursor_position = &crtc_state->stream->cursor_position;
    8410                 }
    8411                 return;
    8412         }
    8413 
    8414         amdgpu_crtc->cursor_width = plane->state->crtc_w;
    8415         amdgpu_crtc->cursor_height = plane->state->crtc_h;
    8416 
    8417         memset(&attributes, 0, sizeof(attributes));
    8418         attributes.address.high_part = upper_32_bits(address);
    8419         attributes.address.low_part  = lower_32_bits(address);
    8420         attributes.width             = plane->state->crtc_w;
    8421         attributes.height            = plane->state->crtc_h;
    8422         attributes.color_format      = CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA;
    8423         attributes.rotation_angle    = 0;
    8424         attributes.attribute_flags.value = 0;
    8425 
    8426         /* Enable cursor degamma ROM on DCN3+ for implicit sRGB degamma in DRM
    8427          * legacy gamma setup.
    8428          */
    8429         if (crtc_state->cm_is_degamma_srgb &&
    8430             adev->dm.dc->caps.color.dpp.gamma_corr)
    8431                 attributes.attribute_flags.bits.ENABLE_CURSOR_DEGAMMA = 1;
    8432 
--> 8433         attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
                                    ^^^^^                  ^^^^^
Unchecked dereferences

    8434 
    8435         if (crtc_state->stream) {
    8436                 if (!dc_stream_set_cursor_attributes(crtc_state->stream,
    8437                                                      &attributes))
    8438                         DRM_ERROR("DC failed to set cursor attributes\n");
    8439 
    8440                 update->cursor_attributes = &crtc_state->stream->cursor_attributes;
    8441 
    8442                 if (!dc_stream_set_cursor_position(crtc_state->stream,
    8443                                                    &position))
    8444                         DRM_ERROR("DC failed to set cursor position\n");
    8445 
    8446                 update->cursor_position = &crtc_state->stream->cursor_position;
    8447         }
    8448 }

regards,
dan carpenter
