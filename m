Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D15C43458
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Jul 2026 15:22:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7069210E4AD;
	Sun, 12 Jul 2026 15:22:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PV5cbjPT";
	dkim-atps=neutral
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com
 [209.85.160.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E48110F7C8
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 07:15:58 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-4472500e25fso311980fac.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 00:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783667757; x=1784272557; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+fIDApUl8o/a7RJvsO5rejRSVTDoHitdTXQIKacb5pA=;
 b=PV5cbjPT+3skrJxe+tJ4CtDXYyq+Vku1vot6gVI81L9uTkjTRYTKJuZa2ExdN1jGKX
 1VKB+AJ65yqM1o+awsmzXXR+Xz9R78QWK7++FNeb/05NEpS6nPtLHfEVr+Fn91hiz1WH
 PW7JmWaWXl1/plOd8IgbdEM7gMFSYr4+JU8pQcxrpxcD9VBv3KL1Zww/E+d4oXADgFnU
 RENLwvKIFXCW+rXpJqgQC0qpBfzAA0KQf7xbZx3/RJQoOSK17jvp/g+NVVtZfKX2a/l2
 f+bUJzc9HH1CW8PwVQgBEYJ1EDEBhAxQD0LCbVx1dUoAr3gIXt4D8ey+VTovQn4jG9kq
 EEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783667757; x=1784272557;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+fIDApUl8o/a7RJvsO5rejRSVTDoHitdTXQIKacb5pA=;
 b=EEm5v0c+mXA8tgYtyxP6lZS8uMYSeX2XrtI8UeO5JROcZJlGtEGEdEdWD4FY3zy5LP
 vZk+rYM3zg3Hjm1sDpNtdN5O1inbEZTqUbJ59XffKRiiXQmEz52sl8sHetQlPfstvSgs
 DheTGl7Q2+/WCC5/gf6W+GySNS8zsfuu+U+Sp1O4PiA50RMvmFk8eASqYjxVzd8uKMb0
 AGtzeIUNzeropCngbvGXKow6IHFPM9zxCTOuznChdgCibcaA/gl1MA7r1vGkmaoeiKDA
 3HakBd3mpxMr+xi+KO7yPjDe/rFOn5fopQTWWm+IT8miIej/a4rEvJjWq5U/npZqQyNz
 k4Yw==
X-Gm-Message-State: AOJu0YwkcCvDe6Lz4PdKkVR3u0yA8KKVKQWd/MsB0V0ZYtl6RyE8Sio2
 b68MbMBvfPtCMTxdLS9qvLpIAo2g+EU2A0PpfxkGGsQn9LEgyBs0Z+YV
X-Gm-Gg: AfdE7cnzaOmnnfwCpM/5xjfyVpc2E7u4N0OYT0uQVQM7inEwK+EDbV0ZOy/j/IfoaMg
 Qohvz4ZwVbMyaVWP6SpN6NAmKI0UScXnSM6tuhhpa6QB6dSQxk6F1T6wox0u2NDMVIraVeb9ZSN
 SVf2ifdGUXRMsQ4eLEJ0Gkma0JB4Dk0ptPZpKpaW9+BaDd5MgLm7ZZJ2uzDWOudOmnHKr3YfFlZ
 ufg50kEb1XFFuBYKx4kSvTWDNNx5icpWt7kB+KKsmklii6O9aFzmgenbFTs2GxLLzxhxYVsO6fR
 ng0CaBMvrFF128JYuae54lVlrKgBFhvAwGqfHOKwlzEbiCENLM+wM4bZqQONm+UA59eVLoiJlUZ
 MUDZfMSt2k8LoVvw8Llz5o0vjGYlGKfyx7d0u1vHPIRqRqDftjCw+hVpH7jpuhyRIU4K1Ua1IAE
 lRfHsC
X-Received: by 2002:a05:6808:c2fb:b0:495:97ef:b41e with SMTP id
 5614622812f47-4a2048e36cdmr7147858b6e.34.1783667757265; 
 Fri, 10 Jul 2026 00:15:57 -0700 (PDT)
Received: from localhost ([74.80.182.70]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a41f5b69bfsm39967b6e.17.2026.07.10.00.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 00:15:56 -0700 (PDT)
Date: Fri, 10 Jul 2026 10:15:50 +0300
From: Dan Carpenter <error27@gmail.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amdgpu: Implement "color format" DRM property
Message-ID: <alCcJmDeIYEE94Eh@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Sun, 12 Jul 2026 15:22:44 +0000
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

Hello Nicolas Frattaroli,

Commit 8a0343b03b98 ("drm/amdgpu: Implement "color format" DRM
property") from Jun 9, 2026 (linux-next), leads to the following
Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_connector.c:857 fill_stream_properties_from_drm_display_mode()
	warn: duplicate zero check 'connector_state->color_format' (previous on line 848)

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_connector.c
    801 static void fill_stream_properties_from_drm_display_mode(
    802         struct dc_stream_state *stream,
    803         const struct drm_display_mode *mode_in,
    804         const struct drm_connector *connector,
    805         const struct drm_connector_state *connector_state,
    806         const struct dc_stream_state *old_stream,
    807         int requested_bpc)
    808 {
    809         bool is_dp_or_hdmi = dc_is_hdmi_signal(stream->signal) || dc_is_dp_signal(stream->signal);
    810         struct dc_crtc_timing *timing_out = &stream->timing;
    811         const struct drm_display_info *info = &connector->display_info;
    812         struct amdgpu_dm_connector *aconnector = NULL;
    813         struct hdmi_vendor_infoframe hv_frame;
    814         struct hdmi_avi_infoframe avi_frame;
    815         bool want_420;
    816         bool want_422;
    817         ssize_t err;
    818 
    819         if (connector->connector_type != DRM_MODE_CONNECTOR_WRITEBACK)
    820                 aconnector = to_amdgpu_dm_connector(connector);
    821 
    822         memset(&hv_frame, 0, sizeof(hv_frame));
    823         memset(&avi_frame, 0, sizeof(avi_frame));
    824 
    825         timing_out->h_border_left = 0;
    826         timing_out->h_border_right = 0;
    827         timing_out->v_border_top = 0;
    828         timing_out->v_border_bottom = 0;
    829 
    830         want_420 = (aconnector && aconnector->force_yuv_pixel_format == PIXEL_ENCODING_YCBCR420) ||
    831                    (connector_state->color_format == DRM_CONNECTOR_COLOR_FORMAT_YCBCR420);
    832         want_422 = (aconnector && aconnector->force_yuv_pixel_format == PIXEL_ENCODING_YCBCR422) ||
    833                    (connector_state->color_format == DRM_CONNECTOR_COLOR_FORMAT_YCBCR422);
    834 
    835         if (drm_mode_is_420_only(info, mode_in) &&
    836             (want_420 || connector_state->color_format == DRM_CONNECTOR_COLOR_FORMAT_AUTO)) {
    837                 timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
    838         } else if (drm_mode_is_420_also(info, mode_in) && want_420) {
    839                 timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
    840         } else if ((info->color_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422)) &&
    841                    want_422 && is_dp_or_hdmi) {
    842                 timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR422;
    843         } else if (connector_state->color_format == DRM_CONNECTOR_COLOR_FORMAT_YCBCR444 &&
    844                    (info->color_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444)) &&
    845                    is_dp_or_hdmi) {
    846                 timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR444;
    847         } else if (connector_state->color_format == DRM_CONNECTOR_COLOR_FORMAT_RGB444 ||
    848                    connector_state->color_format == DRM_CONNECTOR_COLOR_FORMAT_AUTO) {
                                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
AUTO is handled here.

    849                 timing_out->pixel_encoding = PIXEL_ENCODING_RGB;
    850         } else {
    851                 /*
    852                  * If a format was explicitly requested but the requested format
    853                  * can't be satisfied, set it to an invalid value so that an
    854                  * error bubbles up to userspace. This way, userspace knows it
    855                  * needs to make a better choice.
    856                  */
--> 857                 if (connector_state->color_format != DRM_CONNECTOR_COLOR_FORMAT_AUTO)
    858                         timing_out->pixel_encoding = PIXEL_ENCODING_UNDEFINED;

So we know this is true and the else if else is dead code.

    859                 else if (drm_mode_is_420_only(info, mode_in))
    860                         timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
    861                 else
    862                         timing_out->pixel_encoding = PIXEL_ENCODING_RGB;
    863         }
    864 
    865         timing_out->timing_3d_format = TIMING_3D_FORMAT_NONE;
    866         timing_out->display_color_depth = amdgpu_dm_convert_color_depth_from_display_info(
    867                 connector,
    868                 (timing_out->pixel_encoding == PIXEL_ENCODING_YCBCR420),
    869                 requested_bpc);
    870         timing_out->scan_type = SCANNING_TYPE_NODATA;
    871         timing_out->hdmi_vic = 0;
    872 

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
