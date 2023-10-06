Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D823E92FF9
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 09:28:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0115810E09C;
	Fri,  6 Oct 2023 09:28:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 214D710E09C
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 09:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696584521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iqqrtgRGYVlX1KEa+4E1PTkE/wpFbYecOE/W+JuRQOY=;
 b=UAnpr7hExqRvcYhTCyzQV5bEJFWQmKnX/Nv+13rmehUDU4RJGQnujEhYdY6tOAZkQY77Qt
 KU504o2wEXTN0RKKFzdCOzU7y4bdMRnaAouSir1UmWWmroh6ilaCjUqAyngqUfHy0mhtqX
 WVaeSQH5EsztaAphXVuGZqCb7y3ife8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-fTi6hhJ_Ph2Wl_1ndJTnsA-1; Fri, 06 Oct 2023 05:28:29 -0400
X-MC-Unique: fTi6hhJ_Ph2Wl_1ndJTnsA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3217fdf913dso1444972f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Oct 2023 02:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696584508; x=1697189308;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iqqrtgRGYVlX1KEa+4E1PTkE/wpFbYecOE/W+JuRQOY=;
 b=D3qH57SHopOTY6GvNgq+2Kfmb2rB5RI+SmNI+ohJNTJh1hEzbVz3harSoEh5Ez4x2t
 bsj0eV3C0MQ4slupY871sblHNDncaQw4/PJvRlLpo3n9oHFbfgqBHy9UJzoFwBnByB73
 RmR9UgFo+n1gZ9PDqpVDgLD3s2dwgUahUhIt2vZJAYyob8orQupVO1WmpIJUAzsrluWK
 xjC98xj4+ozZCP3ZX4eSYVlSapK8O4qOrUO+VYZPLQpZEIlXqmTxdLO9w9jEKPYkK5vE
 RkIX1GkYzNbjVyNK93pQ0iSt3u5pKGv42Bs8Zqy1J6DHihiGsRSNrhxsNDZlJ0aLfnV1
 qYoQ==
X-Gm-Message-State: AOJu0YzI4esY6hri+1yLWY7jjuWikun3qKljeHChCHh64XdGrSKnJfLW
 I0m1PP4QjSswtGjaiHyNUx7k6sGy4lkX3XgHkjj+LWbfNohYu32PJCNcx3WQtN8gS8Tpt2dcIU5
 /pjzlAZgmkOHJV0U2fZpLYZrXfQ==
X-Received: by 2002:a5d:560a:0:b0:31a:e3ad:f30e with SMTP id
 l10-20020a5d560a000000b0031ae3adf30emr7094099wrv.68.1696584508344; 
 Fri, 06 Oct 2023 02:28:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMy76tdDBITQIMrlIRqBraXQBUwDmvF+SAE/DAdqnkDwn+/UlJvPLZlX8meMUQq9woUpIqqQ==
X-Received: by 2002:a5d:560a:0:b0:31a:e3ad:f30e with SMTP id
 l10-20020a5d560a000000b0031ae3adf30emr7094081wrv.68.1696584507952; 
 Fri, 06 Oct 2023 02:28:27 -0700 (PDT)
Received: from toolbox ([2001:9e8:89bc:cf00:7c0e:f203:f32:6eaf])
 by smtp.gmail.com with ESMTPSA id
 w15-20020adfcd0f000000b0030647449730sm1199337wrm.74.2023.10.06.02.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 02:28:27 -0700 (PDT)
Date: Fri, 6 Oct 2023 11:28:25 +0200
From: Sebastian Wick <sebastian.wick@redhat.com>
To: Melissa Wen <mwen@igalia.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v4 00/32] drm/amd/display: add AMD driver-specific
 properties for color mgmt
Message-ID: <20231006092825.GB400742@toolbox>
References: <20231005171527.203657-1-mwen@igalia.com>
MIME-Version: 1.0
In-Reply-To: <20231005171527.203657-1-mwen@igalia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
Cc: liviu.dudau@arm.com, dri-devel@lists.freedesktop.org, airlied@gmail.com,
 brian.starkey@arm.com, Shashank Sharma <Shashank.Sharma@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 kernel-dev@igalia.com, daniel@ffwll.ch, sunpeng.li@amd.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, sungjoon.kim@amd.com,
 Pekka Paalanen <pekka.paalanen@collabora.com>, Simon Ser <contact@emersion.fr>,
 Xinhui.Pan@amd.com, Xaver Hugl <xaver.hugl@gmail.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, tzimmermann@suse.de,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 05, 2023 at 04:14:55PM -0100, Melissa Wen wrote:
> Hello,
> 
> Just another iteration for AMD driver-specific color properties.
> Basically, addressing comments from the previous version.
> 
> Recap: this series extends the current KMS color management API with AMD
> driver-specific properties to enhance the color management support on
> AMD Steam Deck. The key additions to the color pipeline include:

Did you talk with the maintainers about this already? The last few times
driver specific properties, and even kind of generic plane properties
with a fixed position in the pipeline were proposed they were all
NAKed. Just putting them behind a define doesn't sound great and I don't
think there is any precedence for allowing this in. This is basically
just more burden for upstream without any benefits for upstream.

Maybe you can separate the uAPI changes from the internal improvements
to land at least parts of this faster.

> - plane degamma LUT and pre-defined TF;
> - plane HDR multiplier;
> - plane CTM 3x4;
> - plane shaper LUT and pre-defined TF;
> - plane 3D LUT;
> - plane blend LUT and pre-defined TF;
> - CRTC gamma pre-defined TF;
> 
> You can find the AMD HW color capabilities documented here:
> https://dri.freedesktop.org/docs/drm/gpu/amdgpu/display/display-manager.html#color-management-properties
> 
> The userspace case is Gamescope[1], the compositor for SteamOS.
> Gamescope has already adopted AMD driver-specific properties to
> implement comprehensive color management support, including gamut
> mapping, HDR rendering, SDR on HDR, HDR on SDR. Using these features in
> the SteamOS 3.5[2] users can expect a significantly enhanced visual
> experience. 
> 
> You can find a brief overview of the Steam Deck color pipeline here:
> https://github.com/ValveSoftware/gamescope/blob/master/src/docs/Steam%20Deck%20Display%20Pipeline.png
> 
> Changes from:
> 
> [RFC] https://lore.kernel.org/dri-devel/20230423141051.702990-1-mwen@igalia.com
> - Remove KConfig and guard properties with `AMD_PRIVATE_COLOR`;
> - Remove properties for post-blending/CRTC shaper TF+LUT and 3D LUT;
> - Use color caps to improve the support of pre-defined curve;
> 
> [v1] https://lore.kernel.org/dri-devel/20230523221520.3115570-1-mwen@igalia.com
> - Replace DRM_ by AMDGPU_ prefix for transfer function (TF) enum; 
> - Explicitly define EOTFs and inverse EOTFs and set props accordingly;
> - Document pre-defined transfer functions;
> - Remove HLG transfer function from supported TFs;
> - Remove misleading comments;
> - Remove post-blending shaper TF+LUT and 3D LUT support;
> - Move driver-specific property operations from amdgpu_display.c to
>   amdgpu_dm_color.c;
> - Reset planes if any color props change;
> - Add plane CTM 3x4 support;
> - Removed two DC fixes already applied upstream;
> 
> [v2] https://lore.kernel.org/dri-devel/20230810160314.48225-1-mwen@igalia.com
> - Many documentation fixes: BT.709 OETF, description of sRGB and pure
>   power functions, TF+1D LUT behavior;
> - Rename CTM2 to CTM 3x4 and fix misleading comment about DC gamut remap;
> - Squash `Linear` and `Unity` TF in `Identity`;
> - Remove the `MPC gamut remap` patch already applied upstream[3];
> - Remove outdated delta segmentation fix;
> - Nits/small fixes;
> 
> [v3] https://lore.kernel.org/amd-gfx/20230925194932.1329483-1-mwen@igalia.com
> - Add table to describe value range in linear and non-linear forms
> - Comment the PQ TF need after HDR multiplier
> - Advertise the 3D LUT size as the size of a single-dimension (read-only)
> - remove function to check expected size from 3DLUT caps
> - cleanup comments
> 
> It's worth noting that driver-specific properties are guarded by
> `AMD_PRIVATE_COLOR`. So, finally, this is the color management API when
> driver-specific properties are enabled:
> 
> +----------------------+
> |   PLANE              |
> |                      |
> |  +----------------+  |
> |  | AMD Degamma    |  |
> |  |                |  |
> |  | EOTF | 1D LUT  |  |
> |  +--------+-------+  |
> |           |          |
> |  +--------v-------+  |
> |  |    AMD HDR     |  |
> |  |    Multiply    |  |
> |  +--------+-------+  |
> |           |          |
> |  +--------v-------+  |
> |  |  AMD CTM (3x4) |  |
> |  +--------+-------+  |
> |           |          |
> |  +--------v-------+  |
> |  | AMD Shaper     |  |
> |  |                |  |
> |  | inv_EOTF |     |  |
> |  | Custom 1D LUT  |  |
> |  +--------+-------+  |
> |           |          |
> |  +--------v-------+  |
> |  |   AMD 3D LUT   |  |
> |  |   17^3/12-bit  |  |
> |  +--------+-------+  |
> |           |          |
> |  +--------v-------+  |
> |  | AMD Blend      |  |
> |  |                |  |
> |  | EOTF | 1D LUT  |  |
> |  +--------+-------+  |
> |           |          |
> ++----------v---------++
> ||      Blending      ||
> ++----------+---------++
> |    CRTC   |          |
> |           |          |
> |   +-------v-------+  |
> |   | DRM Degamma   |  |
> |   |               |  |
> |   | Custom 1D LUT |  |
> |   +-------+-------+  |
> |           |          |
> |   +-------v-------+  |
> |   | DRM CTM (3x3) |  |
> |   +-------+-------+  |
> |           |          |
> |   +-------v-------+  |
> |   | DRM Gamma     |  |
> |   |               |  |
> |   | Custom 1D LUT |  |
> |   +---------------+  |
> |   | *AMD Gamma    |  |
> |   |   inv_EOTF    |  |
> |   +---------------+  |
> |                      |
> +----------------------+
> 
> Please, let us know your thoughts.
> 
> Best Regards,
> 
> Melissa Wen
> 
> [1] https://github.com/ValveSoftware/gamescope
> [2] https://store.steampowered.com/news/app/1675200/view/3686804163591367815
> [3] https://lore.kernel.org/dri-devel/20230721132431.692158-1-mwen@igalia.com
> 
> Joshua Ashton (14):
>   drm/amd/display: add plane degamma TF driver-specific property
>   drm/amd/display: add plane HDR multiplier driver-specific property
>   drm/amd/display: add plane blend LUT and TF driver-specific properties
>   drm/amd/display: add CRTC gamma TF support
>   drm/amd/display: set sdr_ref_white_level to 80 for out_transfer_func
>   drm/amd/display: mark plane as needing reset if color props change
>   drm/amd/display: add plane degamma TF and LUT support
>   drm/amd/display: add dc_fixpt_from_s3132 helper
>   drm/amd/display: add HDR multiplier support
>   drm/amd/display: handle empty LUTs in __set_input_tf
>   drm/amd/display: add plane blend LUT and TF support
>   drm/amd/display: allow newer DC hardware to use degamma ROM for PQ/HLG
>   drm/amd/display: copy 3D LUT settings from crtc state to stream_update
>   drm/amd/display: Add 3x4 CTM support for plane CTM
> 
> Melissa Wen (18):
>   drm/drm_mode_object: increase max objects to accommodate new color
>     props
>   drm/drm_property: make replace_property_blob_from_id a DRM helper
>   drm/drm_plane: track color mgmt changes per plane
>   drm/amd/display: add driver-specific property for plane degamma LUT
>   drm/amd/display: explicitly define EOTF and inverse EOTF
>   drm/amd/display: document AMDGPU pre-defined transfer functions
>   drm/amd/display: add plane 3D LUT driver-specific properties
>   drm/amd/display: add plane shaper LUT and TF driver-specific
>     properties
>   drm/amd/display: add CRTC gamma TF driver-specific property
>   drm/amd/display: add comments to describe DM crtc color mgmt behavior
>   drm/amd/display: encapsulate atomic regamma operation
>   drm/amd/display: decouple steps for mapping CRTC degamma to DC plane
>   drm/amd/display: reject atomic commit if setting both plane and CRTC
>     degamma
>   drm/amd/display: add plane shaper LUT support
>   drm/amd/display: add plane shaper TF support
>   drm/amd/display: add plane 3D LUT support
>   drm/amd/display: add plane CTM driver-specific property
>   drm/amd/display: add plane CTM support
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  90 ++
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  34 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 108 +++
>  .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 821 ++++++++++++++++--
>  .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  72 ++
>  .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 224 ++++-
>  .../gpu/drm/amd/display/include/fixed31_32.h  |  12 +
>  drivers/gpu/drm/arm/malidp_crtc.c             |   2 +-
>  drivers/gpu/drm/drm_atomic.c                  |   1 +
>  drivers/gpu/drm/drm_atomic_state_helper.c     |   1 +
>  drivers/gpu/drm/drm_atomic_uapi.c             |  43 +-
>  drivers/gpu/drm/drm_property.c                |  49 ++
>  include/drm/drm_mode_object.h                 |   2 +-
>  include/drm/drm_plane.h                       |   7 +
>  include/drm/drm_property.h                    |   6 +
>  include/uapi/drm/drm_mode.h                   |   8 +
>  16 files changed, 1371 insertions(+), 109 deletions(-)
> 
> -- 
> 2.40.1
> 

