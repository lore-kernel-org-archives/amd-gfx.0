Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A1EC433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 17:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99998611C9
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 17:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99998611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F2289E69;
	Mon, 10 May 2021 17:43:21 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9B3D6E8CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 17:30:51 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 u25-20020a0568302319b02902ac3d54c25eso15166111ote.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=cmkhwQahBbJMqav8gT2yEOTMMFseZ1e2Nx5W2WbR5TQ=;
 b=YfUd77lvEQuJIWhhQw2fYGQdJL2CNFoN/qpLLjae+ECWxaQprQHQfhmO3TvJIKyFdw
 /DLLUM+oJZhvjycfU48X0silQ7CQLZZaVXlKOCEygwOCZIbyjjpFwJfl4vrZTWRVkPJT
 ZmBF/7ozmk7TPYsuTyBz31hJ6YQ+bPyy6u2IobKCtn4+4G7wF5zwfI1VCwASoHJLy9se
 e7SvYg34dxCzb2ZBFVCN10xuI0OqMcb3Ly+8hOz83JA9fR84o/aOqGac8hkTN5rM/XCm
 NRQfdaCJO7ej0qkQ83xPVKw0Mw+goYD9QDIGg0mv5+MN1MUHCt8mSSvAQrwALk29J2z/
 tREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=cmkhwQahBbJMqav8gT2yEOTMMFseZ1e2Nx5W2WbR5TQ=;
 b=nMQY2mvqrWNBN1FnFAU/fD05PhYrAWIt5XRQBqZcr7n5SRK7Kuik1ab5TKjriBrh40
 9alsRBwT4yJCubHNxCQbbR7mXDq5c42rYAeBodRmt6FMlPgXaIb+HyUZyIeRk35tekAv
 jv7mD/Ns3mZxYFX9ontFB3FjKkQ7B5YmOPHxj/yCyLjkrafm2CWjkpJL4nLgntZy1drO
 box8BhehOa72NHUR55xrv0AwXKGkIYoBSv6EMdn9qKDcxN0/V2+gRO1FmEnwfWWBI1XA
 WgnLLms3Ms9/+39hHOyuAWKpnyGxe924cR03EW4iirbjMBgsYkfoMoqujLduO2mDDSeQ
 zZmg==
X-Gm-Message-State: AOAM530+ZjbM+4BcqYUbJuJkHhaR3DQ1KC/tmoPG69QPWvQImaUeCjbB
 qPU6ffsFcQ4iDa3+kMD+Q9rVoYIj+T7fzgszU6w=
X-Google-Smtp-Source: ABdhPJyh8PYn+6hjNPZWNsdoubyIJw0/URUdbdH7NcOC/4r7wOIZreoJz8FDRqgO2+8EJs50E+WOfZQsZdUwOo73644=
X-Received: by 2002:a9d:70c1:: with SMTP id w1mr3141785otj.276.1620667850865; 
 Mon, 10 May 2021 10:30:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:4118:0:0:0:0 with HTTP; Mon, 10 May 2021 10:30:50
 -0700 (PDT)
In-Reply-To: <CAJUqKUrr_JWLSEf8djCqmoJw6WSYZBedKsRFh6F3as+BiomJEw@mail.gmail.com>
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
 <CAJUqKUrr_JWLSEf8djCqmoJw6WSYZBedKsRFh6F3as+BiomJEw@mail.gmail.com>
From: youling 257 <youling257@gmail.com>
Date: Tue, 11 May 2021 01:30:50 +0800
Message-ID: <CAOzgRdbHF7fuJ=rjAHsUbvyJk=BL54EBOkx2i4YUL-e_fwU07w@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "Revert "drm/amdgpu: Ensure that the modifier
 requested is supported by plane.""
To: Mark Yacoub <markyacoub@chromium.org>
X-Mailman-Approved-At: Mon, 10 May 2021 17:43:19 +0000
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

2021-05-11 0:50 GMT+08:00, Mark Yacoub <markyacoub@chromium.org>:
> A userspace problem was due to the modifier used when you're creating
> a buffer but this check renders it as invalid modifier.
> Review patch 1 of this series and it will give you a good idea of a
> userspace bug that was caught using the check in this patch and fixed
> now.
> An easy way to figure out what exactly went wrong so to debug the
> kernel code and check which check returns false for the modifier
> check. That will tell you exactly what you are missing wrt the
> modifier.

I can't find  which check returns false for the modifier check.

>
> On Mon, May 10, 2021 at 12:45 PM youling 257 <youling257@gmail.com> wrote:
>>
>> I use androidx86 nougat on amdgpu, these porting to androidx86 nougat.
>> https://github.com/youling257/mesa
>> https://github.com/youling257/llvm
>> https://github.com/youling257/minigbm
>> https://github.com/youling257/drm_hwcomposer
>>
>> 2021-05-11 0:32 GMT+08:00, youling 257 <youling257@gmail.com>:
>> > what userspace problem?
>> >
>> > 05-10 16:23:35.438  1686  1686 I SurfaceFlinger: OpenGL ES
>> > informations: format=0x1
>> > 05-10 16:23:35.438  1686  1686 I SurfaceFlinger: vendor    : AMD
>> > 05-10 16:23:35.438  1686  1686 I SurfaceFlinger: renderer  : AMD
>> > Radeon(TM) Vega 11 Graphics (RAVEN, DRM 3.41.0,
>> > 5.13.0-rc1-android-x86_64+, LLVM 12.0)
>> > 05-10 16:23:35.439  1686  1686 I SurfaceFlinger: version   : OpenGL ES
>> > 3.2 Mesa 21.1.0 (git-1a53901057)
>> > 05-10 16:23:35.439  1686  1686 I SurfaceFlinger: extensions:
>> > GL_EXT_debug_marker GL_EXT_blend_minmax GL_EXT_multi_draw_arrays
>> > GL_EXT_texture_filter_anisotropic GL_EXT_texture_compression_s3tc
>> > GL_EXT_texture_compression_dxt1 GL_EXT_texture_compression_rgtc
>> > GL_EXT_texture_format_BGRA8888 GL_OES_compressed_ETC1_RGB8_texture
>> > GL_OES_depth24 GL_OES_element_index_uint GL_OES_fbo_render_mipmap
>> > GL_OES_mapbuffer GL_OES_rgb8_rgba8 GL_OES_standard_derivatives
>> > GL_OES_stencil8 GL_OES_texture_3D GL_OES_texture_float
>> > GL_OES_texture_float_linear GL_OES_texture_half_float
>> > GL_OES_texture_half_float_linear GL_OES_texture_npot
>> > GL_OES_vertex_half_float GL_EXT_draw_instanced
>> > GL_EXT_texture_sRGB_decode GL_OES_EGL_image GL_OES_depth_texture
>> > GL_AMD_performance_monitor GL_OES_packed_depth_stencil
>> > GL_EXT_texture_type_2_10_10_10_REV GL_NV_conditional_render
>> > GL_OES_get_program_binary GL_APPLE_texture_max_level
>> > GL_EXT_discard_framebuffer GL_EXT_read_format_bgra GL_EXT_frag_depth
>> > GL_NV_fbo_color_attachments GL_OES_EGL_image_external GL_OES_EGL_sync
>> > GL_OES_vertex_array_object GL_OES_viewp
>> > 05-10 16:23:35.439  1686  1686 I SurfaceFlinger: GL_MAX_TEXTURE_SIZE =
>> > 16384
>> > 05-10 16:23:35.439  1686  1686 I SurfaceFlinger: GL_MAX_VIEWPORT_DIMS =
>> > 16384
>> > 05-10 16:23:35.488     0     0 D
>> > [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]]
>> > [CONNECTOR: 78:DP-1]
>> > 05-10 16:23:35.488     0     0 D
>> > [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]]
>> > [CONNECTOR: 78:DP-1] disconnected
>> > 05-10 16:23:35.488     0     0 D
>> > [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]]
>> > [CONNECTOR: 85:HDMI-A-1]
>> > 05-10 16:23:35.488     0     0 D         : [drm:drm_add_edid_modes
>> > [drm]] ELD monitor HDMI
>> > 05-10 16:23:35.488     0     0 D [drm:drm_add_edid_modes [drm]] HDMI:
>> > latency present 0 0, video latency 0 0, audio latency 0 0
>> > 05-10 16:23:35.488     0     0 D         : [drm:drm_add_edid_modes
>> > [drm]] ELD size 28, SAD count 1
>> > 05-10 16:23:35.488     0     0 D         : [drm:drm_add_display_info
>> > [drm]] Supported Monitor Refresh rate range is 48 Hz - 75 Hz
>> > 05-10 16:23:35.488     0     0 D         : [drm:drm_add_display_info
>> > [drm]] non_desktop set to 0
>> > 05-10 16:23:35.488     0     0 D [drm:drm_add_display_info [drm]]
>> > HDMI: DVI dual 0, max TMDS clock 320000 kHz
>> > 05-10 16:23:35.488     0     0 D         : [drm:drm_add_display_info
>> > [drm]] hdmi_21 sink detected. parsing edid
>> > 05-10 16:23:35.488     0     0 D         : [drm:drm_add_display_info
>> > [drm]] CEA VCDB 0xff
>> > 05-10 16:23:35.488     0     0 D         :
>> > [drm:drm_for_each_detailed_block.part.0 [drm]] stereo mode not
>> > supported
>> > 05-10 16:23:35.489     0     0 D         :
>> > [drm:drm_for_each_detailed_block.part.0 [drm]] stereo mode not
>> > supported
>> > 05-10 16:23:35.489     0     0 D         : [drm:create_stream_for_sink
>> > [amdgpu]] Destination Rectangle x:0  y:0  width:2560  height:1600
>> > 05-10 16:23:35.489     0     0 D         : [drm:create_stream_for_sink
>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1920  height:1200
>> > 05-10 16:23:35.489     0     0 D         : [drm:create_stream_for_sink
>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1920  height:1080
>> > 05-10 16:23:35.489     0     0 D         : [drm:create_stream_for_sink
>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1920  height:1080
>> > 05-10 16:23:35.489     0     0 D         : [drm:create_stream_for_sink
>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1920  height:1080
>> > 05-10 16:23:35.490     0     0 D         : [drm:create_stream_for_sink
>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1920  height:1080
>> > 05-10 16:23:35.490     0     0 D         : [drm:create_stream_for_sink
>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1600  height:1200
>> > 05-10 16:23:35.490     0     0 D         : [drm:create_stream_for_sink
>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1680  height:1050
>> > 05-10 16:23:35.490     0     0 D         : [drm:create_stream_for_sink
>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1400  height:1050
>> > 05-10 16:23:35.490     0     0 D         : [drm:create_stream_for_sink
>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1600  height:900
>> > 05-10 16:23:35.490     0     0 D         : [drm:create_stream_for_sink
>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:1024
>> > 05-10 16:23:35.491     0     0 D         : [drm:create_stream_for_sink
>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:1024
>> > 05-10 16:23:35.491     0     0 D         : [drm:create_stream_for_sink
>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1440  height:900
>> > 05-10 16:23:35.491     0     0 D         : [drm:create_stream_for_sink
>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:960
>> > 05-10 16:23:35.491     0     0 D         : [drm:create_stream_for_sink
>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:800
>> > 05-10 16:23:35.491     0     0 D         : [drm:create_stream_for_sink
>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:720
>> > 05-10 16:23:35.491     0     0 D         : [drm:create_stream_for_sink
>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:720
>> > 05-10 16:23:35.491     0     0 D         : [drm:create_stream_for_sink
>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:720
>> > 05-10 16:23:35.492     0     0 D         : [drm:create_stream_for_sink
>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1024  height:768
>> > 05-10 16:23:35.492     0     0 D         : [drm:create_stream_for_sink
>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1024  height:768
>> > 05-10 16:23:35.492     0     0 D         : [drm:create_stream_for_sink
>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1024  height:768
>> > 05-10 16:23:35.492     0     0 D         : [drm:create_stream_for_sink
>> > [amdgpu]] Destination Rectangle x:0  y:0  width:800  height:600
>> > 05-10 16:23:35.492     0     0 D         : [drm:create_stream_for_sink
>> > [amdgpu]] Destination Rectangle x:0  y:0  width:800  height:600
>> > 05-10 16:23:35.492     0     0 D         : [drm:create_stream_for_sink
>> > [amdgpu]] Destination Rectangle x:0  y:0  width:640  height:480
>> > 05-10 16:23:35.492     0     0 D         : [drm:create_stream_for_sink
>> > [amdgpu]] Destination Rectangle x:0  y:0  width:640  height:480
>> > 05-10 16:23:35.493     0     0 D         : [drm:create_stream_for_sink
>> > [amdgpu]] Destination Rectangle x:0  y:0  width:640  height:480
>> > 05-10 16:23:35.493     0     0 D         : [drm:create_stream_for_sink
>> > [amdgpu]] Destination Rectangle x:0  y:0  width:720  height:400
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080i": 60
>> > 74250 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
>> > 05-10 16:23:35.493     0     0 D         : [drm:drm_mode_prune_invalid
>> > [drm]] Not using 1920x1080i mode: NO_INTERLACE
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080i": 60
>> > 74176 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
>> > 05-10 16:23:35.493     0     0 D         : [drm:drm_mode_prune_invalid
>> > [drm]] Not using 1920x1080i mode: NO_INTERLACE
>> > 05-10 16:23:35.493     0     0 D
>> > [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]]
>> > [CONNECTOR: 85:HDMI-A-1] probed modes :
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "2560x1600": 60
>> > 267810 2560 2608 2640 2720 1600 1603 1608 1641 0x68 0x5
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1200": 60
>> > 267810 1920 2608 2640 2720 1200 1603 1608 1641 0x40 0x5
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080": 60
>> > 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0xa
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080": 60
>> > 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080": 60
>> > 148352 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080": 50
>> > 148500 1920 2448 2492 2640 1080 1084 1089 1125 0x40 0x5
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1600x1200": 60
>> > 267810 1600 2608 2640 2720 1200 1603 1608 1641 0x40 0x5
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1680x1050": 60
>> > 119000 1680 1728 1760 1840 1050 1053 1059 1080 0x40 0x9
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1400x1050": 60
>> > 101000 1400 1448 1480 1560 1050 1053 1057 1080 0x40 0x9
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1600x900": 60
>> > 108000 1600 1624 1704 1800 900 901 904 1000 0x40 0x5
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x1024": 75
>> > 135000 1280 1296 1440 1688 1024 1025 1028 1066 0x40 0x5
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x1024": 60
>> > 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x40 0x5
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1440x900": 60 88750
>> > 1440 1488 1520 1600 900 903 909 926 0x40 0x9
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x960": 60
>> > 108000 1280 1376 1488 1800 960 961 964 1000 0x40 0x5
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x800": 60
>> > 267810 1280 2608 2640 2720 800 1603 1608 1641 0x40 0x5
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x720": 60 74250
>> > 1280 1390 1430 1650 720 725 730 750 0x40 0x5
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x720": 60 74250
>> > 1280 1390 1430 1650 720 725 730 750 0x40 0x5
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x720": 60 74176
>> > 1280 1390 1430 1650 720 725 730 750 0x40 0x5
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1024x768": 75 78750
>> > 1024 1040 1136 1312 768 769 772 800 0x40 0x5
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1024x768": 70 75000
>> > 1024 1048 1184 1328 768 771 777 806 0x40 0xa
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1024x768": 60 65000
>> > 1024 1048 1184 1344 768 771 777 806 0x40 0xa
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "800x600": 75 49500
>> > 800 816 896 1056 600 601 604 625 0x40 0x5
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "800x600": 60 40000
>> > 800 840 968 1056 600 601 605 628 0x40 0x5
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x480": 75 31500
>> > 640 656 720 840 480 481 484 500 0x40 0xa
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x480": 60 25200
>> > 640 656 752 800 480 490 492 525 0x40 0xa
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x480": 60 25175
>> > 640 656 752 800 480 490 492 525 0x40 0xa
>> > 05-10 16:23:35.493     0     0 D         :
>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x400": 70 28320
>> > 720 738 846 900 400 412 414 449 0x40 0x6
>> > 05-10 16:23:35.493     0     0 D
>> > [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]]
>> > [CONNECTOR: 90:HDMI-A-2]
>> > 05-10 16:23:35.493     0     0 D
>> > [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]]
>> > [CONNECTOR: 90:HDMI-A-2] disconnected
>> > 05-10 16:23:35.494     0     0 D
>> > [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]]
>> > [CONNECTOR: 94:HDMI-A-3]
>> > 05-10 16:23:35.494     0     0 D
>> > [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]]
>> > [CONNECTOR: 94:HDMI-A-3] disconnected
>> >
>> > 05-10 16:23:35.502     0     0 D
>> > [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]]
>> > [CONNECTOR: 85:HDMI-A-1]
>> > 05-10 16:23:35.502     0     0 D         : [drm:drm_add_edid_modes
>> > [drm]] ELD monitor HDMI
>> > 05-10 16:23:35.502     0     0 D [drm:drm_add_edid_modes [drm]] HDMI:
>> > latency present 0 0, video latency 0 0, audio latency 0 0
>> > 05-10 16:23:35.503     0     0 D         : [drm:drm_add_edid_modes
>> > [drm]] ELD size 28, SAD count 1
>> > 05-10 16:23:35.503     0     0 D         : [drm:drm_add_display_info
>> > [drm]] Supported Monitor Refresh rate range is 48 Hz - 75 Hz
>> > 05-10 16:23:35.503     0     0 D         : [drm:drm_add_display_info
>> > [drm]] non_desktop set to 0
>> > 05-10 16:23:35.503     0     0 D [drm:drm_add_display_info [drm]]
>> > HDMI: DVI dual 0, max TMDS clock 320000 kHz
>> > 05-10 16:23:35.503     0     0 D         : [drm:drm_add_display_info
>> > [drm]] hdmi_21 sink detected. parsing edid
>> > 05-10 16:23:35.503     0     0 D         : [drm:drm_add_display_info
>> > [drm]] CEA VCDB 0xff
>> > 05-10 16:23:35.503     0     0 D         :
>> > [drm:drm_for_each_detailed_block.part.0 [drm]] stereo mode not
>> > supported
>> > 05-10 16:23:35.503     0     0 D         :
>> > [drm:drm_for_each_detailed_block.part.0 [drm]] stereo mode not
>> > supported
>> >
>> > 05-10 16:23:35.797  1920  2001 I EGL-MAIN: found extension DRI_Core
>> > version
>> > 2
>> > 05-10 16:23:35.797  1920  2001 I EGL-MAIN: found extension
>> > DRI_IMAGE_DRIVER version 1
>> > 05-10 16:23:35.798  1920  2001 I EGL-MAIN: found extension
>> > DRI_ConfigOptions version 2
>> > 05-10 16:23:35.798  1920  2001 D libdrm  :
>> > /vendor/etc/hwdata/amdgpu.ids version: 1.0.0
>> > 05-10 16:23:35.802  1920  2001 I EGL-MAIN: found extension
>> > DRI_TexBuffer version 2
>> > 05-10 16:23:35.802  1920  2001 I EGL-MAIN: found extension DRI2_Flush
>> > version 4
>> > 05-10 16:23:35.802  1920  2001 I EGL-MAIN: found extension DRI_IMAGE
>> > version
>> > 18
>> > 05-10 16:23:35.802  1920  2001 I EGL-MAIN: found extension
>> > DRI_RENDERER_QUERY version 1
>> > 05-10 16:23:35.802  1920  2001 I EGL-MAIN: found extension
>> > DRI_CONFIG_QUERY version 2
>> > 05-10 16:23:35.802  1920  2001 I EGL-MAIN: found extension DRI2_Fence
>> > version 2
>> > 05-10 16:23:35.802  1920  2001 I EGL-MAIN: found extension
>> > DRI2_Interop version 1
>> > 05-10 16:23:35.802  1920  2001 I EGL-MAIN: found extension DRI_NoError
>> > version 1
>> > 05-10 16:23:35.803  1920  2001 I EGL-MAIN: found extension DRI2_Blob
>> > version
>> > 1
>> > 05-10 16:23:35.803  1920  2001 I EGL-MAIN: found extension DRI_IMAGE
>> > version
>> > 18
>> > 05-10 16:23:35.803  1920  2001 I EGL-MAIN: found extension
>> > DRI2_BufferDamage version 1
>> > 05-10 16:23:35.803  1920  2001 I EGL-MAIN: found extension
>> > DRI_Robustness version 1
>> > 05-10 16:23:35.875     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 104]
>> > 05-10 16:23:35.875     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 104]
>> > 05-10 16:23:35.875     0     0 D         :
>> > [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
>> > 05-10 16:23:35.876     0     0 D         : [drm:dcn10_program_pipe
>> > [amdgpu]] Un-gated front end for pipe 0
>> > 05-10 16:23:35.891     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 102]
>> > 05-10 16:23:35.892     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 102]
>> > 05-10 16:23:35.892     0     0 D         :
>> > [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
>> > 05-10 16:23:35.893     0     0 D         : [drm:dcn10_program_pipe
>> > [amdgpu]] Un-gated front end for pipe 0
>> >
>> > 2021-05-10 23:18 GMT+08:00, Mark Yacoub <markyacoub@chromium.org>:
>> >> Like the previous time it was reverted, there is a chance it's a user
>> >> space bug that's not passing the correct modifier.
>> >> Are you able to check what exactly returns false in the code above.
>> >> This will give you the greatest hint on what the userspace is missing
>> >> and needs to be fixed there.
>> >>
>> >> On Sun, May 9, 2021 at 10:09 PM youling 257 <youling257@gmail.com>
>> >> wrote:
>> >>>
>> >>> Revert "Revert "drm/amdgpu: Ensure that the modifier requested is
>> >>> supported by plane."" is first bad commt.
>> >>> "drm/amd/display: Fix two cursor duplication when using overlay" is
>> >>> second bad commit.
>> >>> they cause same problem, look the video.
>> >>> i have to revert two patch for my androidx86 run on amdgpu.
>> >>>
>> >>> 2021-05-10 5:42 GMT+08:00, youling 257 <youling257@gmail.com>:
>> >>> > error dmesg
>> >>> >
>> >>> > [  115.977746] [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB
>> >>> > bound
>> >>> > [  115.980406] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end
>> >>> > for
>> >>> > pipe
>> >>> > 0
>> >>> > [  115.993656] [drm:drm_mode_addfb2 [drm]] [FB:104]
>> >>> > [  115.993694] [drm:drm_mode_addfb2 [drm]] [FB:105]
>> >>> > [  115.993722] [drm:drm_mode_addfb2 [drm]] [FB:106]
>> >>> > [  115.993750] [drm:drm_mode_addfb2 [drm]] [FB:107]
>> >>> > [  115.993777] [drm:drm_mode_addfb2 [drm]] [FB:108]
>> >>> > [  115.994215] [drm:drm_mode_addfb2 [drm]] [FB:104]
>> >>> > [  115.994371] [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB
>> >>> > bound
>> >>> > [  115.997095] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end
>> >>> > for
>> >>> > pipe
>> >>> > 0
>> >>> > [  116.010298] [drm:drm_mode_addfb2 [drm]] [FB:102]
>> >>> > [  116.010337] [drm:drm_mode_addfb2 [drm]] [FB:105]
>> >>> > [  116.010366] [drm:drm_mode_addfb2 [drm]] [FB:106]
>> >>> > [  116.010394] [drm:drm_mode_addfb2 [drm]] [FB:107]
>> >>> > [  116.010422] [drm:drm_mode_addfb2 [drm]] [FB:108]
>> >>> > [  116.010853] [drm:drm_mode_addfb2 [drm]] [FB:102]
>> >>> > [  116.011018] [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB
>> >>> > bound
>> >>> > [  116.013694] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end
>> >>> > for
>> >>> > pipe
>> >>> > 0
>> >>> >
>> >>> >
>> >>> > normal dmesg
>> >>> >  3464.827004] [drm:drm_mode_addfb2 [drm]] [FB:105]
>> >>> > [ 3464.833405] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end
>> >>> > for
>> >>> > pipe
>> >>> > 0
>> >>> > [ 3464.833981] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end
>> >>> > for
>> >>> > pipe
>> >>> > 3
>> >>> > [ 3464.842396] [drm:drm_mode_addfb2 [drm]] [FB:104]
>> >>> > [ 3464.842476] [drm:drm_mode_addfb2 [drm]] [FB:106]
>> >>> > [ 3464.842550] [drm:drm_mode_addfb2 [drm]] [FB:107]
>> >>> > [ 3464.842615] [drm:drm_mode_addfb2 [drm]] [FB:108]
>> >>> > [ 3464.842679] [drm:drm_mode_addfb2 [drm]] [FB:109]
>> >>> > [ 3464.842741] [drm:drm_mode_addfb2 [drm]] [FB:110]
>> >>> > [ 3464.843748] [drm:drm_mode_addfb2 [drm]] [FB:104]
>> >>> > [ 3464.843821] [drm:drm_mode_addfb2 [drm]] [FB:106]
>> >>> > [ 3464.850026] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end
>> >>> > for
>> >>> > pipe
>> >>> > 0
>> >>> > [ 3464.850378] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end
>> >>> > for
>> >>> > pipe
>> >>> > 3
>> >>> > [ 3464.858841] [drm:drm_mode_addfb2 [drm]] [FB:102]
>> >>> > [ 3464.858878] [drm:drm_mode_addfb2 [drm]] [FB:105]
>> >>> > [ 3464.858906] [drm:drm_mode_addfb2 [drm]] [FB:107]
>> >>> > [ 3464.858933] [drm:drm_mode_addfb2 [drm]] [FB:108]
>> >>> > [ 3464.858960] [drm:drm_mode_addfb2 [drm]] [FB:109]
>> >>> > [ 3464.858987] [drm:drm_mode_addfb2 [drm]] [FB:110]
>> >>> > [ 3464.859609] [drm:drm_mode_addfb2 [drm]] [FB:102]
>> >>> > [ 3464.859641] [drm:drm_mode_addfb2 [drm]] [FB:105]
>> >>> > [ 3464.866353] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end
>> >>> > for
>> >>> > pipe
>> >>> > 0
>> >>> > [ 3464.866653] [drm:dcn10_program_pipe [amdgpu]] Un-gated front end
>> >>> > for
>> >>> > pipe
>> >>> > 3
>> >>> >
>> >>> > 2021-05-10 4:57 GMT+08:00, Bas Nieuwenhuizen
>> >>> > <bas@basnieuwenhuizen.nl>:
>> >>> >> It would be very helpful if you could enable drm.debug=0x4 and
>> >>> >> then
>> >>> >> take the dmesg to figure out what modifier was rejected
>> >>> >>
>> >>> >> On Sun, May 9, 2021 at 10:51 PM youling 257 <youling257@gmail.com>
>> >>> >> wrote:
>> >>> >>>
>> >>> >>> look this video,
>> >>> >>> https://drive.google.com/file/d/1QklH_H2AlOTu8W1D3yl6_3rtZ7IqbjR_/view?usp=sharing
>> >>> >>>
>> >>> >>> 2021-05-09 23:52 GMT+08:00, Alex Deucher <alexdeucher@gmail.com>:
>> >>> >>> > On Sun, May 9, 2021 at 11:42 AM youling257
>> >>> >>> > <youling257@gmail.com>
>> >>> >>> > wrote:
>> >>> >>> >>
>> >>> >>> >> I using amd 3400g running with android-x86, this patch is a
>> >>> >>> >> bad
>> >>> >>> >> commit
>> >>> >>> >> when i use android-x86 on amdgpu.
>> >>> >>> >
>> >>> >>> > Can you provide more details?  What sort of problem are you
>> >>> >>> > seeing?
>> >>> >>> > Please provide your dmesg output.
>> >>> >>> >
>> >>> >>> > Alex
>> >>> >>> >
>> >>> >>> >
>> >>> >>> >> _______________________________________________
>> >>> >>> >> amd-gfx mailing list
>> >>> >>> >> amd-gfx@lists.freedesktop.org
>> >>> >>> >> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>> >>> >>> >
>> >>> >>
>> >>> >
>> >>
>> >
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
