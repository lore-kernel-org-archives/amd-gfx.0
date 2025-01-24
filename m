Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0932EC0218B
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2025 16:06:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B33810E0FD;
	Fri, 24 Jan 2025 16:05:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="XR/YYgo+";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F00910E9D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 16:05:58 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-38a8b17d7a7so1129438f8f.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 08:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1737734757; x=1738339557; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=St4LcJGyWFKNwYckoM2A/fDp8BzZEsDfa0eW5apA5Gw=;
 b=XR/YYgo+YLEYrV27JKaQ61Y/vziR8XEZrqHssx1xSRSjLm9e6rHJfh9Q2+p69RQQo9
 rkXqAnX9bqyfCuNp9NojSgY5+3Q5tzwbqGR9V0ZudK4N3Yp78yus4UFb0LuNeBedCi59
 LeFqyraRrSNJBMyhtkctxuDBfT3B7rwhO/J/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737734757; x=1738339557;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=St4LcJGyWFKNwYckoM2A/fDp8BzZEsDfa0eW5apA5Gw=;
 b=KShax/xSR6ViWhaElyY5QWsZl1vDTrwJDMtJy2zD78/zkXyoBNZqtCv6Rck2IlNZUH
 V12Bl2X0sGV/VPksrQXmgYLAaVLVKZTdRPUIjMsfq2mSzNiCbylRu6NjGm37xHOQbeq0
 rgQQvtYTWBxZNuYQsfSqqE1yRAdJcFVeps428mowzLh0yaNboTPKFNlHP2D5p5S3WxJO
 RqcJ0FWJqGQjrzywwDS4wrkn/cbAszR/nnsoq1TK0pv3qaz+/G8qpXXQZ8Y4dm4MM0Om
 L9mbbdyAX6fprowMQ8rRPQV9Ck7kWXDhs8dBaObxqTzWEg2J/4KYDhLTwiHsSIvHTStM
 jQ6g==
X-Gm-Message-State: AOJu0Yyw1xF0OWPGcOKLJiwEPv7PpSUCSqqFv5LFJ25XtA0tGSzPkrbu
 D/kWyuZ8Skeviup2qkfZZLa/j4Ia/oXfzVx8HeoPJ3ypTTnW2PhL5nMgv6gKMco=
X-Gm-Gg: ASbGnct03EFL1m6spVD8nazzyqBkyZb8EAlet3M4Vm/CnCFrU/SWaRkKwsBLloJfmyt
 2rDcIj8A1dqqoQkmaSwd2eVfaUgPCijWWIc82Gov2cWjt20/plKE2RbNOf6FQR8zHvKusTfbOOO
 QnWcSz65enUDRouHgSkrlrYNO0Z1AUEBFADppDFTnnDsQw/78U1a1luaL4zgccqQs6Ja3iCDCQE
 USEi41UhMpcCSV11VxloKvMp+GPNtGyVd03myrUhbPzFFHIU/rnZJtCy70wD9rCsKGX0U9dKMv2
 d77KWGyrrDMswB10
X-Google-Smtp-Source: AGHT+IHUkUINQKk10BOYnvHHne8w/TREwPKoHAPm8S09qW0iVdgZRxjhUWXTJkTUC0FD4dCHMDTmWQ==
X-Received: by 2002:a5d:5888:0:b0:38a:4b8b:c57a with SMTP id
 ffacd0b85a97d-38bf57a6e78mr30912854f8f.44.1737734756872; 
 Fri, 24 Jan 2025 08:05:56 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a188d5dsm3201047f8f.55.2025.01.24.08.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:05:56 -0800 (PST)
Date: Fri, 24 Jan 2025 17:05:54 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, simona@ffwll.ch
Subject: Re: [pull] amdgpu, amdkfd drm-next-6.14
Message-ID: <Z5O6YmOfsNfS8Ng9@phenom.ffwll.local>
References: <20250124152153.3861868-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250124152153.3861868-1-alexander.deucher@amd.com>
X-Operating-System: Linux phenom 6.12.3-amd64 
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

On Fri, Jan 24, 2025 at 10:21:52AM -0500, Alex Deucher wrote:
> Hi Dave, Simona,
> 
> Fixes for 6.14 from last two weeks.  Fixed missing s-o-b.
> 
> The following changes since commit 24c61d553302ee49e9c21dd251275ba8c36dcfe4:
> 
>   Merge tag 'drm-msm-next-2025-01-07' of gitlab.freedesktop.org:drm/msm into drm-next (2025-01-13 11:14:07 +1000)
> 
> are available in the Git repository at:
> 
>   https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-next-6.14-2025-01-24

Rebasing/cherry-picking needs a bit more finesse still:

dim: aedf498a2c33 ("drm/amd/display: fix SUBVP DC_DEBUG_MASK documentation"): Fixes: SHA1 in not pointing at an ancestor:
dim:     5349658fa4a1 ("drm/amd: Add debug option to disable subvp")

Anyway pulled, thanks a lot.
-Sima

> 
> for you to fetch changes up to 024771f3fb75dc817e9429d5763f1a6eb84b6f21:
> 
>   drm/amd/display: Optimize cursor position updates (2025-01-24 09:56:28 -0500)
> 
> ----------------------------------------------------------------
> amd-drm-next-6.14-2025-01-24:
> 
> amdgpu:
> - Documentation fixes
> - SMU 13.x fixes
> - SR-IOV fix
> - Display fix
> - PCIe calculation fix
> - MES 12 fix
> - HUBP fix
> - Cursor fix
> - Enforce isolation fixes
> - GFX 12 fix
> - Use drm scheduler API helper rather than open coding it
> - Mark some debugging parameters as unsafe
> - PSP 14.x fix
> - Add cleaner shader support for gfx12
> - Add subvp debugging flag
> - SDMA 4.4.x fix
> - Clarify some kernel log messages
> - clang fix
> - PCIe lane reporting fix
> - Documentation fix
> 
> amdkfd:
> - Mark some debugging parameters as unsafe
> - Fix partial migration handling
> - Trap handler updates
> 
> ----------------------------------------------------------------
> Alex Deucher (4):
>       drm/amdgpu: cache gpu pcie link width
>       drm/amdgpu: fix the PCIe lanes reporting in the INFO IOCTL
>       drm/amd/display: fix CEC DC_DEBUG_MASK documentation
>       drm/amd/display: fix SUBVP DC_DEBUG_MASK documentation
> 
> Aric Cyr (2):
>       drm/amd/display: Add hubp cache reset when powergating
>       drm/amd/display: Optimize cursor position updates
> 
> Aurabindo Pillai (1):
>       drm/amd: Add debug option to disable subvp
> 
> Christian König (2):
>       drm/amdgpu: mark a bunch of module parameters unsafe
>       drm/amdgpu: always sync the GFX pipe on ctx switch
> 
> Emily Deng (1):
>       drm/amdkfd: Fix partial migrate issue
> 
> Gui Chengming (1):
>       drm/amdgpu: fix fw attestation for MP0_14_0_{2/3}
> 
> Jay Cornwall (2):
>       drm/amdkfd: Sync trap handler binary with source
>       drm/amdkfd: Clear MODE.VSKIP in gfx9 trap handler
> 
> Jesse.zhang@amd.com (3):
>       revert "drm/amdgpu/pm: Implement SDMA queue reset for different asic"
>       revert "drm/amdgpu/pm: add definition PPSMC_MSG_ResetSDMA2"
>       drm/amd/pm: Refactor SMU 13.0.6 SDMA reset firmware version checks
> 
> Kenneth Feng (1):
>       drm/amdgpu: disable gfxoff with the compute workload on gfx12
> 
> Kent Russell (1):
>       drm/amdgpu: Mark debug KFD module params as unsafe
> 
> Lijo Lazar (4):
>       drm/amdgpu: Add handler for SDMA context empty
>       drm/amdgpu: Refine ip detection log message
>       drm/amd/pm: Add capability flags for SMU v13.0.6
>       drm/amd/pm: Fix smu v13.0.6 caps initialization
> 
> Lin.Cao (1):
>       drm/amdgpu: fix ring timeout issue in gfx10 sr-iov environment
> 
> Mario Limonciello (1):
>       drm/amd: Clarify kdoc for amdgpu.gttsize
> 
> Shaoyun Liu (1):
>       drm/amd/amdgpu: Enable scratch data dump for mes 12
> 
> Srinivasan Shanmugam (4):
>       drm/amdgpu: Fix Circular Locking Dependency in AMDGPU GFX Isolation
>       drm/amdgpu/gfx12: Add Cleaner Shader Support for GFX12.0 GPUs
>       drm/amd/display: Fix error pointers in amdgpu_dm_crtc_mem_type_changed
>       drm/amd/amdgpu: Prevent null pointer dereference in GPU bandwidth calculation
> 
> Tvrtko Ursulin (1):
>       drm/amdgpu: Use DRM scheduler API in amdgpu_xcp_release_sched
> 
> Tzung-Bi Shih (1):
>       drm/amd/display: mark static functions noinline_for_stack
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |    5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  156 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   26 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c |    4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |   12 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |    6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   19 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |    2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h           |    1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c            |    2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |    8 +
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c             |   49 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c           |   22 +
>  drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h     | 2391 ++++++++++----------
>  .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm  |    4 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |   22 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |    8 +
>  .../drm/amd/display/dc/dml2/display_mode_core.c    |   12 +-
>  .../dml21/src/dml2_core/dml2_core_dcn4_calcs.c     |   12 +-
>  .../gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c   |   10 +-
>  .../drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c  |    6 +-
>  .../gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c |   10 +-
>  .../gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h |    2 +
>  .../gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c |    9 +-
>  .../drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c   |    1 +
>  .../gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c |    3 +
>  .../gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c |    3 +
>  .../gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c |    1 +
>  .../gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c |    1 +
>  .../gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c |    1 +
>  .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c   |   13 +-
>  .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |    2 +
>  .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |    2 +
>  drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |    2 +
>  drivers/gpu/drm/amd/include/amd_pcie.h             |   18 +
>  drivers/gpu/drm/amd/include/amd_shared.h           |    7 +-
>  .../amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h   |    1 -
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h       |    3 +-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h       |    1 +
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |  286 ++-
>  40 files changed, 1743 insertions(+), 1400 deletions(-)

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
