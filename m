Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B408CC072A2
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Nov 2023 11:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F90A10E74B;
	Fri, 17 Nov 2023 11:09:12 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3672610E745
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Nov 2023 11:09:09 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40837396b1eso1080165e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Nov 2023 03:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1700219347; x=1700824147; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qd+QmjFXL3FqK0Swp5Mq09yMTi11ELd3uXDtmtZHbiY=;
 b=DHpj45hH+oh+UXxNIIzMFzbslpLZr2S7dE3kRfZ808bwmGPOhKVwgmwX3KEHKhRjLd
 prkF7nczqJmHfjd9GFy1XJIUXJ1SNbcRKpvcp8Sotwvp8VBWcLLTCDIXDs56oZd0ZIhC
 UTJ9cLSD7edxdv9CL3/L4399s13iH1iPk7GTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700219347; x=1700824147;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qd+QmjFXL3FqK0Swp5Mq09yMTi11ELd3uXDtmtZHbiY=;
 b=J3QtZqQ7JOZuiA1EJ5HTpbECWgr2Uo6Kk/vAHK0lUIX+VAQAf1/dWjFF9HkZEVR+KX
 Imya+cqqggeT5sRMOpzDM0ex8gHjWcROELr40vWcPSWJeGj8ouzdvJp9H9LkmQCDIDEb
 wzs+A84+vY7y49FgO0eph8NTq1u7Q7XIU7FVi9s/Kew5noDZ1YrL1KhJAtJvpulSzjkb
 DzYC+Q8hDHi8WUFdL3MZ6NaN+zJKWxNr07GOazyDKMqtpN+bw8jyhXfd541aABkJ9TPy
 sQOM6IzmC27mPYUTycZga4VnlS5yqi3sS+uqCVBraPVGqg0tpPAK++BTpAlY28RvFrDQ
 pkew==
X-Gm-Message-State: AOJu0YxAarfpY7sp+HKl+/LWztcC8B3n3xy1IXUsA9CTPd5VWJsRJqNY
 p8kxzWQ2ijt7DSfnfODmbOo4C/9O6gQltMebShs=
X-Google-Smtp-Source: AGHT+IEYA5YA8BugdzBq3oCClsldoD9BbByOjT4yGSzv99fVEHxTdHDrWmEevZGrUBivhYNuLEc2Vg==
X-Received: by 2002:a05:600c:3b15:b0:409:72c6:8232 with SMTP id
 m21-20020a05600c3b1500b0040972c68232mr8271901wms.3.1700219347356; 
 Fri, 17 Nov 2023 03:09:07 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 je12-20020a05600c1f8c00b0040839fcb217sm2342272wmb.8.2023.11.17.03.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 03:09:06 -0800 (PST)
Date: Fri, 17 Nov 2023 12:09:04 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [pull] amdgpu drm-fixes-6.7
Message-ID: <ZVdJ0E-ND2NySCsO@phenom.ffwll.local>
References: <20231117063441.4883-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231117063441.4883-1-alexander.deucher@amd.com>
X-Operating-System: Linux phenom 6.5.0-4-amd64 
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
Cc: daniel.vetter@ffwll.ch, airlied@gmail.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Nov 17, 2023 at 01:34:41AM -0500, Alex Deucher wrote:
> Hi Dave, Sima,
> 
> Fixes for 6.7.
> 
> The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:
> 
>   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
> 
> are available in the Git repository at:
> 
>   https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-6.7-2023-11-17
> 
> for you to fetch changes up to e8c2d3e25b844ad8f7c8b269a7cfd65285329264:
> 
>   drm/amdgpu/gmc9: disable AGP aperture (2023-11-17 00:58:41 -0500)

Pulled to drm-fixes, thanks!
-Sima
> 
> ----------------------------------------------------------------
> amd-drm-fixes-6.7-2023-11-17:
> 
> amdgpu:
> - DMCUB fixes
> - SR-IOV fix
> - GMC9 fix
> - Documentation fix
> - DSC MST fix
> - CS chunk parsing fix
> - SMU13.0.6 fixes
> - 8K tiled display fix
> - Fix potential NULL pointer dereferences
> - Cursor lag fix
> - Backlight fix
> - DCN s0ix fix
> - XGMI fix
> - DCN encoder disable logic fix
> - AGP aperture fixes
> 
> ----------------------------------------------------------------
> Alex Deucher (5):
>       drm/amdgpu/gmc11: fix logic typo in AGP check
>       drm/amdgpu: add a module parameter to control the AGP aperture
>       drm/amdgpu/gmc11: disable AGP aperture
>       drm/amdgpu/gmc10: disable AGP aperture
>       drm/amdgpu/gmc9: disable AGP aperture
> 
> Asad Kamal (2):
>       drm/amd/pm: Update metric table for smu v13_0_6
>       drm/amd/pm: Fill pcie error counters for gpu v1_4
> 
> Duncan Ma (1):
>       drm/amd/display: Negate IPS allow and commit bits
> 
> Fangzhi Zuo (1):
>       drm/amd/display: Fix DSC not Enabled on Direct MST Sink
> 
> José Pekkarinen (1):
>       drm/amd/display: fix NULL dereference
> 
> Le Ma (1):
>       drm/amdgpu: finalizing mem_partitions at the end of GMC v9 sw_fini
> 
> Lewis Huang (1):
>       drm/amd/display: Change the DMCUB mailbox memory location from FB to inbox
> 
> Lijo Lazar (1):
>       drm/amd/pm: Don't send unload message for reset
> 
> Mario Limonciello (1):
>       drm/amd/display: fix a NULL pointer dereference in amdgpu_dm_i2c_xfer()
> 
> Muhammad Ahmed (1):
>       drm/amd/display: Add null checks for 8K60 lightup
> 
> Nicholas Kazlauskas (1):
>       drm/amd/display: Guard against invalid RPTR/WPTR being set
> 
> Nicholas Susanto (1):
>       drm/amd/display: Fix encoder disable logic
> 
> Paul Hsieh (1):
>       drm/amd/display: Clear dpcd_sink_ext_caps if not set
> 
> Shiwu Zhang (1):
>       drm/amdgpu: add and populate the port num into xgmi topology info
> 
> Srinivasan Shanmugam (1):
>       drm/amdgpu: Address member 'ring' not described in 'amdgpu_ vce, uvd_entity_init()'
> 
> Tianci Yin (1):
>       drm/amd/display: Enable fast plane updates on DCN3.2 and above
> 
> Victor Lu (1):
>       drm/amdgpu: Do not program VF copy regs in mmhub v1.8 under SRIOV (v2)
> 
> Yang Wang (1):
>       drm/amdgpu: fix ras err_data null pointer issue in amdgpu_ras.c
> 
> YuanShang (1):
>       drm/amdgpu: correct chunk_ptr to a pointer to chunk.
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            | 10 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  5 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |  1 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |  5 ++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |  7 +--
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c            |  6 +--
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 24 ++++++-----
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  5 +--
>  .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 29 ++++++-------
>  .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   | 18 ++++----
>  drivers/gpu/drm/amd/display/dc/core/dc.c           |  6 +--
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  3 ++
>  drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       | 10 ++---
>  drivers/gpu/drm/amd/display/dc/dc_types.h          |  1 +
>  .../display/dc/dcn35/dcn35_dio_stream_encoder.c    | 10 ++---
>  .../gpu/drm/amd/display/dc/link/link_detection.c   |  3 ++
>  drivers/gpu/drm/amd/display/dmub/dmub_srv.h        | 22 ++++++----
>  drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    | 50 +++++++++++++++++-----
>  .../amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h    | 10 ++++-
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 10 ++++-
>  26 files changed, 160 insertions(+), 84 deletions(-)

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
