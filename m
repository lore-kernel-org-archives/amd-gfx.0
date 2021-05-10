Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D9FC433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 16:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78070611C2
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 16:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78070611C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1953289191;
	Mon, 10 May 2021 16:54:44 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D28B66E8C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 16:50:57 +0000 (UTC)
Received: by mail-lj1-x22e.google.com with SMTP id f12so9054854ljp.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qgFbiHp/bSX3McCCKvsYhvfQ22ZmuuQgO6MsPkvEgdU=;
 b=hPwjNWSp5oprNQ/c5Dw325mDi7/v80iUQAZwPf7Xr2VFv3ypZMf1Vt0+b0eaCwYvw9
 dX8dwirqEhQ7OgYXtkagip84Xw3fO/yd6TMzysem+VH6w+NNXe31/5p9DttZLPB957kO
 8q9pqs4OvecLaEhXrOeif9TbU46tkT9KELsWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qgFbiHp/bSX3McCCKvsYhvfQ22ZmuuQgO6MsPkvEgdU=;
 b=miX0K5tGniDn1n23Gt6sAStPlJNMUpeX/uVIkd9/qUsiu3LjJE8MSddHfHY/zieX8a
 kLAGADfDURA0CMXDTBfAWC4Yot+Gd9vLS/3QQuhYEnIlfN1KckHfJGvPVag3ann8oOHS
 8SMtndy4rKhazxxXCr0cT4Ma6O5mUhPLrcFzQZKQO9BAP94xJu/kcJGepeqjIGYoKZmm
 ZnQIrTVjUI4j7kQ1hFurXN74teF5K0Lg2Ff5rEVF3JlmoeZxES6Vu55kTfub7bu25byk
 ZFIHGpwxGSq4lexGDJ6jVucmHXZwv6uMAyCba5UYLa80axtoU0dQxe2Z1tCbCzb5FvrZ
 oeXQ==
X-Gm-Message-State: AOAM530Wz3xshBUMibJTP+MQkPiC1H9BsXnNFd2NiaFNt4ysEhD7OmF+
 VlNegJJwkGAQ8E97vSlynvHlST891tQHY+ZIqrX2IA==
X-Google-Smtp-Source: ABdhPJzFqVsmEmq1kpQI3PuQF5qMHXjieDIJuZ2o1dVkaB8x9PGpF2kHALzhmGe/6d13Ct0bvRiKSsgEvaW9pJtv1dQ=
X-Received: by 2002:a2e:b5a7:: with SMTP id f7mr20800298ljn.509.1620665455850; 
 Mon, 10 May 2021 09:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210414233533.24012-2-qingqing.zhuo@amd.com>
 <20210509121055.24728-1-youling257@gmail.com>
 <CADnq5_MF0y0sHH6Vz8KZH5j=iXToq3WPw7+kW=BqMk=oNZ=Ppw@mail.gmail.com>
 <CAOzgRdZf0R7mVY+spDZz_CG1Kpf7qmP6oGaOJ_XKauZA3ZhZeg@mail.gmail.com>
 <CAP+8YyEv3NPqeEVmFvQDoq_+=h8Q_goHUbgt7fNPUXJbR5AcKw@mail.gmail.com>
 <CAOzgRdYbmnA3M5d30i94TwGNtOWOviChBq9eEdhTjbfvGXaSfw@mail.gmail.com>
 <CAOzgRdaKpwd5ze8om4F22yq_DeREma1H6KUquqJ34dnSTvsjiQ@mail.gmail.com>
 <CAJUqKUoxKdp+U5y0gzi=_N94zs6b9DjUoYT3Mfn0-z-X0hCbMQ@mail.gmail.com>
 <CAOzgRdYEGELkhOOkkm=OOZsmrCrKjR+GKJ_ZyqVVjUURX+Szfw@mail.gmail.com>
 <CAOzgRdYgM6j8RKzTdy-MwrW+NeLaAn1fy0Q6-ACnvA5K=a-z3A@mail.gmail.com>
In-Reply-To: <CAOzgRdYgM6j8RKzTdy-MwrW+NeLaAn1fy0Q6-ACnvA5K=a-z3A@mail.gmail.com>
From: Mark Yacoub <markyacoub@chromium.org>
Date: Mon, 10 May 2021 12:50:45 -0400
Message-ID: <CAJUqKUrr_JWLSEf8djCqmoJw6WSYZBedKsRFh6F3as+BiomJEw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "Revert "drm/amdgpu: Ensure that the modifier
 requested is supported by plane.""
To: youling 257 <youling257@gmail.com>
X-Mailman-Approved-At: Mon, 10 May 2021 16:54:43 +0000
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
Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Wheeler,
 Daniel" <daniel.wheeler@amd.com>, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Alex Deucher <alexdeucher@gmail.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A userspace problem was due to the modifier used when you're creating
a buffer but this check renders it as invalid modifier.
Review patch 1 of this series and it will give you a good idea of a
userspace bug that was caught using the check in this patch and fixed
now.
An easy way to figure out what exactly went wrong so to debug the
kernel code and check which check returns false for the modifier
check. That will tell you exactly what you are missing wrt the
modifier.

On Mon, May 10, 2021 at 12:45 PM youling 257 <youling257@gmail.com> wrote:
>
> I use androidx86 nougat on amdgpu, these porting to androidx86 nougat.
> https://github.com/youling257/mesa
> https://github.com/youling257/llvm
> https://github.com/youling257/minigbm
> https://github.com/youling257/drm_hwcomposer
>
> 2021-05-11 0:32 GMT+08:00, youling 257 <youling257@gmail.com>:
> > what userspace problem?
> >
> > 05-10 16:23:35.438  1686  1686 I SurfaceFlinger: OpenGL ES
> > informations: format=0x1
> > 05-10 16:23:35.438  1686  1686 I SurfaceFlinger: vendor    : AMD
> > 05-10 16:23:35.438  1686  1686 I SurfaceFlinger: renderer  : AMD
> > Radeon(TM) Vega 11 Graphics (RAVEN, DRM 3.41.0,
> > 5.13.0-rc1-android-x86_64+, LLVM 12.0)
> > 05-10 16:23:35.439  1686  1686 I SurfaceFlinger: version   : OpenGL ES
> > 3.2 Mesa 21.1.0 (git-1a53901057)
> > 05-10 16:23:35.439  1686  1686 I SurfaceFlinger: extensions:
> > GL_EXT_debug_marker GL_EXT_blend_minmax GL_EXT_multi_draw_arrays
> > GL_EXT_texture_filter_anisotropic GL_EXT_texture_compression_s3tc
> > GL_EXT_texture_compression_dxt1 GL_EXT_texture_compression_rgtc
> > GL_EXT_texture_format_BGRA8888 GL_OES_compressed_ETC1_RGB8_texture
> > GL_OES_depth24 GL_OES_element_index_uint GL_OES_fbo_render_mipmap
> > GL_OES_mapbuffer GL_OES_rgb8_rgba8 GL_OES_standard_derivatives
> > GL_OES_stencil8 GL_OES_texture_3D GL_OES_texture_float
> > GL_OES_texture_float_linear GL_OES_texture_half_float
> > GL_OES_texture_half_float_linear GL_OES_texture_npot
> > GL_OES_vertex_half_float GL_EXT_draw_instanced
> > GL_EXT_texture_sRGB_decode GL_OES_EGL_image GL_OES_depth_texture
> > GL_AMD_performance_monitor GL_OES_packed_depth_stencil
> > GL_EXT_texture_type_2_10_10_10_REV GL_NV_conditional_render
> > GL_OES_get_program_binary GL_APPLE_texture_max_level
> > GL_EXT_discard_framebuffer GL_EXT_read_format_bgra GL_EXT_frag_depth
> > GL_NV_fbo_color_attachments GL_OES_EGL_image_external GL_OES_EGL_sync
> > GL_OES_vertex_array_object GL_OES_viewp
> > 05-10 16:23:35.439  1686  1686 I SurfaceFlinger: GL_MAX_TEXTURE_SIZE =
> > 16384
> > 05-10 16:23:35.439  1686  1686 I SurfaceFlinger: GL_MAX_VIEWPORT_DIMS =
> > 16384
> > 05-10 16:23:35.488     0     0 D
> > [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]]
> > [CONNECTOR: 78:DP-1]
> > 05-10 16:23:35.488     0     0 D
> > [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]]
> > [CONNECTOR: 78:DP-1] disconnected
> > 05-10 16:23:35.488     0     0 D
> > [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]]
> > [CONNECTOR: 85:HDMI-A-1]
> > 05-10 16:23:35.488     0     0 D         : [drm:drm_add_edid_modes
> > [drm]] ELD monitor HDMI
> > 05-10 16:23:35.488     0     0 D [drm:drm_add_edid_modes [drm]] HDMI:
> > latency present 0 0, video latency 0 0, audio latency 0 0
> > 05-10 16:23:35.488     0     0 D         : [drm:drm_add_edid_modes
> > [drm]] ELD size 28, SAD count 1
> > 05-10 16:23:35.488     0     0 D         : [drm:drm_add_display_info
> > [drm]] Supported Monitor Refresh rate range is 48 Hz - 75 Hz
> > 05-10 16:23:35.488     0     0 D         : [drm:drm_add_display_info
> > [drm]] non_desktop set to 0
> > 05-10 16:23:35.488     0     0 D [drm:drm_add_display_info [drm]]
> > HDMI: DVI dual 0, max TMDS clock 320000 kHz
> > 05-10 16:23:35.488     0     0 D         : [drm:drm_add_display_info
> > [drm]] hdmi_21 sink detected. parsing edid
> > 05-10 16:23:35.488     0     0 D         : [drm:drm_add_display_info
> > [drm]] CEA VCDB 0xff
> > 05-10 16:23:35.488     0     0 D         :
> > [drm:drm_for_each_detailed_block.part.0 [drm]] stereo mode not
> > supported
> > 05-10 16:23:35.489     0     0 D         :
> > [drm:drm_for_each_detailed_block.part.0 [drm]] stereo mode not
> > supported
> > 05-10 16:23:35.489     0     0 D         : [drm:create_stream_for_sink
> > [amdgpu]] Destination Rectangle x:0  y:0  width:2560  height:1600
> > 05-10 16:23:35.489     0     0 D         : [drm:create_stream_for_sink
> > [amdgpu]] Destination Rectangle x:0  y:0  width:1920  height:1200
> > 05-10 16:23:35.489     0     0 D         : [drm:create_stream_for_sink
> > [amdgpu]] Destination Rectangle x:0  y:0  width:1920  height:1080
> > 05-10 16:23:35.489     0     0 D         : [drm:create_stream_for_sink
> > [amdgpu]] Destination Rectangle x:0  y:0  width:1920  height:1080
> > 05-10 16:23:35.489     0     0 D         : [drm:create_stream_for_sink
> > [amdgpu]] Destination Rectangle x:0  y:0  width:1920  height:1080
> > 05-10 16:23:35.490     0     0 D         : [drm:create_stream_for_sink
> > [amdgpu]] Destination Rectangle x:0  y:0  width:1920  height:1080
> > 05-10 16:23:35.490     0     0 D         : [drm:create_stream_for_sink
> > [amdgpu]] Destination Rectangle x:0  y:0  width:1600  height:1200
> > 05-10 16:23:35.490     0     0 D         : [drm:create_stream_for_sink
> > [amdgpu]] Destination Rectangle x:0  y:0  width:1680  height:1050
> > 05-10 16:23:35.490     0     0 D         : [drm:create_stream_for_sink
> > [amdgpu]] Destination Rectangle x:0  y:0  width:1400  height:1050
> > 05-10 16:23:35.490     0     0 D         : [drm:create_stream_for_sink
> > [amdgpu]] Destination Rectangle x:0  y:0  width:1600  height:900
> > 05-10 16:23:35.490     0     0 D         : [drm:create_stream_for_sink
> > [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:1024
> > 05-10 16:23:35.491     0     0 D         : [drm:create_stream_for_sink
> > [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:1024
> > 05-10 16:23:35.491     0     0 D         : [drm:create_stream_for_sink
> > [amdgpu]] Destination Rectangle x:0  y:0  width:1440  height:900
> > 05-10 16:23:35.491     0     0 D         : [drm:create_stream_for_sink
> > [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:960
> > 05-10 16:23:35.491     0     0 D         : [drm:create_stream_for_sink
> > [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:800
> > 05-10 16:23:35.491     0     0 D         : [drm:create_stream_for_sink
> > [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:720
> > 05-10 16:23:35.491     0     0 D         : [drm:create_stream_for_sink
> > [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:720
> > 05-10 16:23:35.491     0     0 D         : [drm:create_stream_for_sink
> > [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:720
> > 05-10 16:23:35.492     0     0 D         : [drm:create_stream_for_sink
> > [amdgpu]] Destination Rectangle x:0  y:0  width:1024  height:768
> > 05-10 16:23:35.492     0     0 D         : [drm:create_stream_for_sink
> > [amdgpu]] Destination Rectangle x:0  y:0  width:1024  height:768
> > 05-10 16:23:35.492     0     0 D         : [drm:create_stream_for_sink
> > [amdgpu]] Destination Rectangle x:0  y:0  width:1024  height:768
> > 05-10 16:23:35.492     0     0 D         : [drm:create_stream_for_sink
> > [amdgpu]] Destination Rectangle x:0  y:0  width:800  height:600
> > 05-10 16:23:35.492     0     0 D         : [drm:create_stream_for_sink
> > [amdgpu]] Destination Rectangle x:0  y:0  width:800  height:600
> > 05-10 16:23:35.492     0     0 D         : [drm:create_stream_for_sink
> > [amdgpu]] Destination Rectangle x:0  y:0  width:640  height:480
> > 05-10 16:23:35.492     0     0 D         : [drm:create_stream_for_sink
> > [amdgpu]] Destination Rectangle x:0  y:0  width:640  height:480
> > 05-10 16:23:35.493     0     0 D         : [drm:create_stream_for_sink
> > [amdgpu]] Destination Rectangle x:0  y:0  width:640  height:480
> > 05-10 16:23:35.493     0     0 D         : [drm:create_stream_for_sink
> > [amdgpu]] Destination Rectangle x:0  y:0  width:720  height:400
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080i": 60
> > 74250 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
> > 05-10 16:23:35.493     0     0 D         : [drm:drm_mode_prune_invalid
> > [drm]] Not using 1920x1080i mode: NO_INTERLACE
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080i": 60
> > 74176 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
> > 05-10 16:23:35.493     0     0 D         : [drm:drm_mode_prune_invalid
> > [drm]] Not using 1920x1080i mode: NO_INTERLACE
> > 05-10 16:23:35.493     0     0 D
> > [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]]
> > [CONNECTOR: 85:HDMI-A-1] probed modes :
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "2560x1600": 60
> > 267810 2560 2608 2640 2720 1600 1603 1608 1641 0x68 0x5
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1200": 60
> > 267810 1920 2608 2640 2720 1200 1603 1608 1641 0x40 0x5
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080": 60
> > 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0xa
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080": 60
> > 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080": 60
> > 148352 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080": 50
> > 148500 1920 2448 2492 2640 1080 1084 1089 1125 0x40 0x5
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1600x1200": 60
> > 267810 1600 2608 2640 2720 1200 1603 1608 1641 0x40 0x5
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1680x1050": 60
> > 119000 1680 1728 1760 1840 1050 1053 1059 1080 0x40 0x9
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1400x1050": 60
> > 101000 1400 1448 1480 1560 1050 1053 1057 1080 0x40 0x9
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1600x900": 60
> > 108000 1600 1624 1704 1800 900 901 904 1000 0x40 0x5
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x1024": 75
> > 135000 1280 1296 1440 1688 1024 1025 1028 1066 0x40 0x5
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x1024": 60
> > 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x40 0x5
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1440x900": 60 88750
> > 1440 1488 1520 1600 900 903 909 926 0x40 0x9
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x960": 60
> > 108000 1280 1376 1488 1800 960 961 964 1000 0x40 0x5
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x800": 60
> > 267810 1280 2608 2640 2720 800 1603 1608 1641 0x40 0x5
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x720": 60 74250
> > 1280 1390 1430 1650 720 725 730 750 0x40 0x5
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x720": 60 74250
> > 1280 1390 1430 1650 720 725 730 750 0x40 0x5
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x720": 60 74176
> > 1280 1390 1430 1650 720 725 730 750 0x40 0x5
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1024x768": 75 78750
> > 1024 1040 1136 1312 768 769 772 800 0x40 0x5
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1024x768": 70 75000
> > 1024 1048 1184 1328 768 771 777 806 0x40 0xa
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1024x768": 60 65000
> > 1024 1048 1184 1344 768 771 777 806 0x40 0xa
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "800x600": 75 49500
> > 800 816 896 1056 600 601 604 625 0x40 0x5
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "800x600": 60 40000
> > 800 840 968 1056 600 601 605 628 0x40 0x5
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x480": 75 31500
> > 640 656 720 840 480 481 484 500 0x40 0xa
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x480": 60 25200
> > 640 656 752 800 480 490 492 525 0x40 0xa
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x480": 60 25175
> > 640 656 752 800 480 490 492 525 0x40 0xa
> > 05-10 16:23:35.493     0     0 D         :
> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x400": 70 28320
> > 720 738 846 900 400 412 414 449 0x40 0x6
> > 05-10 16:23:35.493     0     0 D
> > [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]]
> > [CONNECTOR: 90:HDMI-A-2]
> > 05-10 16:23:35.493     0     0 D
> > [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]]
> > [CONNECTOR: 90:HDMI-A-2] disconnected
> > 05-10 16:23:35.494     0     0 D
> > [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]]
> > [CONNECTOR: 94:HDMI-A-3]
> > 05-10 16:23:35.494     0     0 D
> > [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]]
> > [CONNECTOR: 94:HDMI-A-3] disconnected
> >
> > 05-10 16:23:35.502     0     0 D
> > [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]]
> > [CONNECTOR: 85:HDMI-A-1]
> > 05-10 16:23:35.502     0     0 D         : [drm:drm_add_edid_modes
> > [drm]] ELD monitor HDMI
> > 05-10 16:23:35.502     0     0 D [drm:drm_add_edid_modes [drm]] HDMI:
> > latency present 0 0, video latency 0 0, audio latency 0 0
> > 05-10 16:23:35.503     0     0 D         : [drm:drm_add_edid_modes
> > [drm]] ELD size 28, SAD count 1
> > 05-10 16:23:35.503     0     0 D         : [drm:drm_add_display_info
> > [drm]] Supported Monitor Refresh rate range is 48 Hz - 75 Hz
> > 05-10 16:23:35.503     0     0 D         : [drm:drm_add_display_info
> > [drm]] non_desktop set to 0
> > 05-10 16:23:35.503     0     0 D [drm:drm_add_display_info [drm]]
> > HDMI: DVI dual 0, max TMDS clock 320000 kHz
> > 05-10 16:23:35.503     0     0 D         : [drm:drm_add_display_info
> > [drm]] hdmi_21 sink detected. parsing edid
> > 05-10 16:23:35.503     0     0 D         : [drm:drm_add_display_info
> > [drm]] CEA VCDB 0xff
> > 05-10 16:23:35.503     0     0 D         :
> > [drm:drm_for_each_detailed_block.part.0 [drm]] stereo mode not
> > supported
> > 05-10 16:23:35.503     0     0 D         :
> > [drm:drm_for_each_detailed_block.part.0 [drm]] stereo mode not
> > supported
> >
> > 05-10 16:23:35.797  1920  2001 I EGL-MAIN: found extension DRI_Core version
> > 2
> > 05-10 16:23:35.797  1920  2001 I EGL-MAIN: found extension
> > DRI_IMAGE_DRIVER version 1
> > 05-10 16:23:35.798  1920  2001 I EGL-MAIN: found extension
> > DRI_ConfigOptions version 2
> > 05-10 16:23:35.798  1920  2001 D libdrm  :
> > /vendor/etc/hwdata/amdgpu.ids version: 1.0.0
> > 05-10 16:23:35.802  1920  2001 I EGL-MAIN: found extension
> > DRI_TexBuffer version 2
> > 05-10 16:23:35.802  1920  2001 I EGL-MAIN: found extension DRI2_Flush
> > version 4
> > 05-10 16:23:35.802  1920  2001 I EGL-MAIN: found extension DRI_IMAGE version
> > 18
> > 05-10 16:23:35.802  1920  2001 I EGL-MAIN: found extension
> > DRI_RENDERER_QUERY version 1
> > 05-10 16:23:35.802  1920  2001 I EGL-MAIN: found extension
> > DRI_CONFIG_QUERY version 2
> > 05-10 16:23:35.802  1920  2001 I EGL-MAIN: found extension DRI2_Fence
> > version 2
> > 05-10 16:23:35.802  1920  2001 I EGL-MAIN: found extension
> > DRI2_Interop version 1
> > 05-10 16:23:35.802  1920  2001 I EGL-MAIN: found extension DRI_NoError
> > version 1
> > 05-10 16:23:35.803  1920  2001 I EGL-MAIN: found extension DRI2_Blob version
> > 1
> > 05-10 16:23:35.803  1920  2001 I EGL-MAIN: found extension DRI_IMAGE version
> > 18
> > 05-10 16:23:35.803  1920  2001 I EGL-MAIN: found extension
> > DRI2_BufferDamage version 1
> > 05-10 16:23:35.803  1920  2001 I EGL-MAIN: found extension
> > DRI_Robustness version 1
> > 05-10 16:23:35.875     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 104]
> > 05-10 16:23:35.875     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 104]
> > 05-10 16:23:35.875     0     0 D         :
> > [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> > 05-10 16:23:35.876     0     0 D         : [drm:dcn10_program_pipe
> > [amdgpu]] Un-gated front end for pipe 0
> > 05-10 16:23:35.891     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 102]
> > 05-10 16:23:35.892     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 102]
> > 05-10 16:23:35.892     0     0 D         :
> > [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> > 05-10 16:23:35.893     0     0 D         : [drm:dcn10_program_pipe
> > [amdgpu]] Un-gated front end for pipe 0
> >
> > 2021-05-10 23:18 GMT+08:00, Mark Yacoub <markyacoub@chromium.org>:
> >> Like the previous time it was reverted, there is a chance it's a user
> >> space bug that's not passing the correct modifier.
> >> Are you able to check what exactly returns false in the code above.
> >> This will give you the greatest hint on what the userspace is missing
> >> and needs to be fixed there.
> >>
> >> On Sun, May 9, 2021 at 10:09 PM youling 257 <youling257@gmail.com> wrote:
> >>>
> >>> Revert "Revert "drm/amdgpu: Ensure that the modifier requested is
> >>> supported by plane."" is first bad commt.
> >>> "drm/amd/display: Fix two cursor duplication when using overlay" is
> >>> second bad commit.
> >>> they cause same problem, look the video.
> >>> i have to revert two patch for my androidx86 run on amdgpu.
> >>>
> >>> 2021-05-10 5:42 GMT+08:00, youling 257 <youling257@gmail.com>:
> >>> > error dmesg
> >>> >
> >>> > [  115.977746] [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> >>> > [  115.980406] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end
> >>> > for
> >>> > pipe
> >>> > 0
> >>> > [  115.993656] [drm:drm_mode_addfb2 [drm]] [FB:104]
> >>> > [  115.993694] [drm:drm_mode_addfb2 [drm]] [FB:105]
> >>> > [  115.993722] [drm:drm_mode_addfb2 [drm]] [FB:106]
> >>> > [  115.993750] [drm:drm_mode_addfb2 [drm]] [FB:107]
> >>> > [  115.993777] [drm:drm_mode_addfb2 [drm]] [FB:108]
> >>> > [  115.994215] [drm:drm_mode_addfb2 [drm]] [FB:104]
> >>> > [  115.994371] [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> >>> > [  115.997095] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end
> >>> > for
> >>> > pipe
> >>> > 0
> >>> > [  116.010298] [drm:drm_mode_addfb2 [drm]] [FB:102]
> >>> > [  116.010337] [drm:drm_mode_addfb2 [drm]] [FB:105]
> >>> > [  116.010366] [drm:drm_mode_addfb2 [drm]] [FB:106]
> >>> > [  116.010394] [drm:drm_mode_addfb2 [drm]] [FB:107]
> >>> > [  116.010422] [drm:drm_mode_addfb2 [drm]] [FB:108]
> >>> > [  116.010853] [drm:drm_mode_addfb2 [drm]] [FB:102]
> >>> > [  116.011018] [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> >>> > [  116.013694] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end
> >>> > for
> >>> > pipe
> >>> > 0
> >>> >
> >>> >
> >>> > normal dmesg
> >>> >  3464.827004] [drm:drm_mode_addfb2 [drm]] [FB:105]
> >>> > [ 3464.833405] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end
> >>> > for
> >>> > pipe
> >>> > 0
> >>> > [ 3464.833981] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end
> >>> > for
> >>> > pipe
> >>> > 3
> >>> > [ 3464.842396] [drm:drm_mode_addfb2 [drm]] [FB:104]
> >>> > [ 3464.842476] [drm:drm_mode_addfb2 [drm]] [FB:106]
> >>> > [ 3464.842550] [drm:drm_mode_addfb2 [drm]] [FB:107]
> >>> > [ 3464.842615] [drm:drm_mode_addfb2 [drm]] [FB:108]
> >>> > [ 3464.842679] [drm:drm_mode_addfb2 [drm]] [FB:109]
> >>> > [ 3464.842741] [drm:drm_mode_addfb2 [drm]] [FB:110]
> >>> > [ 3464.843748] [drm:drm_mode_addfb2 [drm]] [FB:104]
> >>> > [ 3464.843821] [drm:drm_mode_addfb2 [drm]] [FB:106]
> >>> > [ 3464.850026] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end
> >>> > for
> >>> > pipe
> >>> > 0
> >>> > [ 3464.850378] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end
> >>> > for
> >>> > pipe
> >>> > 3
> >>> > [ 3464.858841] [drm:drm_mode_addfb2 [drm]] [FB:102]
> >>> > [ 3464.858878] [drm:drm_mode_addfb2 [drm]] [FB:105]
> >>> > [ 3464.858906] [drm:drm_mode_addfb2 [drm]] [FB:107]
> >>> > [ 3464.858933] [drm:drm_mode_addfb2 [drm]] [FB:108]
> >>> > [ 3464.858960] [drm:drm_mode_addfb2 [drm]] [FB:109]
> >>> > [ 3464.858987] [drm:drm_mode_addfb2 [drm]] [FB:110]
> >>> > [ 3464.859609] [drm:drm_mode_addfb2 [drm]] [FB:102]
> >>> > [ 3464.859641] [drm:drm_mode_addfb2 [drm]] [FB:105]
> >>> > [ 3464.866353] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end
> >>> > for
> >>> > pipe
> >>> > 0
> >>> > [ 3464.866653] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end
> >>> > for
> >>> > pipe
> >>> > 3
> >>> >
> >>> > 2021-05-10 4:57 GMT+08:00, Bas Nieuwenhuizen
> >>> > <bas@basnieuwenhuizen.nl>:
> >>> >> It would be very helpful if you could enable drm.debug=0x4 and then
> >>> >> take the dmesg to figure out what modifier was rejected
> >>> >>
> >>> >> On Sun, May 9, 2021 at 10:51 PM youling 257 <youling257@gmail.com>
> >>> >> wrote:
> >>> >>>
> >>> >>> look this video,
> >>> >>> https://drive.google.com/file/d/1QklH_H2AlOTu8W1D3yl6_3rtZ7IqbjR_/view?usp=sharing
> >>> >>>
> >>> >>> 2021-05-09 23:52 GMT+08:00, Alex Deucher <alexdeucher@gmail.com>:
> >>> >>> > On Sun, May 9, 2021 at 11:42 AM youling257 <youling257@gmail.com>
> >>> >>> > wrote:
> >>> >>> >>
> >>> >>> >> I using amd 3400g running with android-x86, this patch is a bad
> >>> >>> >> commit
> >>> >>> >> when i use android-x86 on amdgpu.
> >>> >>> >
> >>> >>> > Can you provide more details?  What sort of problem are you
> >>> >>> > seeing?
> >>> >>> > Please provide your dmesg output.
> >>> >>> >
> >>> >>> > Alex
> >>> >>> >
> >>> >>> >
> >>> >>> >> _______________________________________________
> >>> >>> >> amd-gfx mailing list
> >>> >>> >> amd-gfx@lists.freedesktop.org
> >>> >>> >> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >>> >>> >
> >>> >>
> >>> >
> >>
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
