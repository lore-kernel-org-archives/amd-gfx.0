Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4878DCCFA02
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 18:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0B6110E33A;
	Fri, 31 Oct 2025 18:01:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="LpfCJiI2";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E1A610E32E
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 18:01:13 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-63b9da57cecso4448974a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 11:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1761933672; x=1762538472; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bvx2q/qpWWnD2AL/TUvtdAJj1Z8NuqAZ56k2GFeft5c=;
 b=LpfCJiI2wSa3UGafAIeIzk3MdOMYu1YB1B284jBMKuZDXegAumWQCzuyg8kmqc4jIo
 g6ndFh+nRxGaN0RZwy9YmBJdtUCmJd4utJkAGO1s0PTNCgQoWPaFqUDhicu62d5yWTWj
 FPsJ7+E4GJ52ay5YvWP4Au+B4+T/1WerlbhaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761933672; x=1762538472;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bvx2q/qpWWnD2AL/TUvtdAJj1Z8NuqAZ56k2GFeft5c=;
 b=TK8nT7j8K9M0tdqa6Zy6JVJsTLy2Zdu1IjW+zFBi/EiV8hiwiFvh6YAT0DeGRvhJsS
 T9zy45tT4BKe3uvrpnqPNtUzw5c4aditGVvffVgfqONKCVH9Cyb0sOLJiwZz3XcfzFsS
 a9/lHEuv2FmDwv/jzG7r3UNSpQf3Bc/pH8buPi4zJX6Z0qbJt36V5oaLZovqs+Nh5Du7
 pHLFUlq1/AyW0TeM6aEXc0TPXJKmBQ+bJ8wjJhIzw2IGaZFqcT0OCwnDDISf4ngUeN0Q
 6vAYPXtFpd0pSZGeG+/PamMcRLDmdQTvUIPKdALHr6Il6GNjQdniBK3WycbCVOaNZNvf
 wj4Q==
X-Gm-Message-State: AOJu0YxNttcQSJHuNlGsc+lfdJV1ke/3LVJ/1Fmyd7ThcoyfsY96XtmT
 byEiKUiM31ixBhMiTq5QWdQDH0KtkKiroNSBQBkRtaWLtoy9PpSTxqZ4ihfWKRuzfqk=
X-Gm-Gg: ASbGncucsnwnKID5DHracJwrrlKIPdMJmn5waIThlMwoOqlPm99LuUg6uv7qe0/Vq9+
 ctl20Y0hqj6iOnSKZVy1pN7Ra4FrsUNBmbwTSPso66bDwcUjOkZ7UmHzDeE+17C3HdOsiYm0NLi
 sSTNzgGJMj5FILEmBdjPA9V4fQ63K8V/LfH4U7KVcdE68KU5Yi86DNWdAOypWrw7WWc1JHYSbQe
 Fyh1XXIuGKyngF5VWz31wg5O8d0dSDkTeoXg2F2UIh8vmBw+x/xfUmcrgiG6m5yz0flYueeXtZd
 dkXyxpwg5V/Puh8HAmZjnaWx7jlhOBI+p7WIwRujCZVsxRd1eZVQhD3pxsQNdhXXrO25VjQioWe
 KwFllUSmue3zCTB/jYqoFakhNmGLe52hwIt/2xP4HIvs/OHMpIDyxN/fUm082CCAMoSGYAfe+sO
 2bgRxK1NQlo0L/jAbg8jVXYg==
X-Google-Smtp-Source: AGHT+IGnuvmtngfSRhhWG6e6Zt9gF/mGUsNnRj335AoNqljZXx1jVNTi4/sA2lgkhKSYFEUtORjuFQ==
X-Received: by 2002:a05:6402:13c5:b0:640:464a:56ce with SMTP id
 4fb4d7f45d1cf-64076f66affmr3921012a12.2.1761933672043; 
 Fri, 31 Oct 2025 11:01:12 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6407b428079sm2125831a12.18.2025.10.31.11.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:01:11 -0700 (PDT)
Date: Fri, 31 Oct 2025 19:01:09 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, simona.vetter@ffwll.ch
Subject: Re: [pull] amdgpu, radeon drm-fixes-6.18
Message-ID: <aQT5ZcgCBYjzmCCO@phenom.ffwll.local>
References: <20251029201342.8813-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029201342.8813-1-alexander.deucher@amd.com>
X-Operating-System: Linux phenom 6.12.38+deb13-amd64 
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

On Wed, Oct 29, 2025 at 04:13:42PM -0400, Alex Deucher wrote:
> Hi Dave, Simona,
> 
> Fixes for 6.18.
> 
> The following changes since commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa:
> 
>   Linux 6.18-rc3 (2025-10-26 15:59:49 -0700)
> 
> are available in the Git repository at:
> 
>   https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-6.18-2025-10-29
> 
> for you to fetch changes up to b3656b355b5522cef1b52a7469010009c98156db:
> 
>   drm/amd/display: Fix incorrect return of vblank enable on unconfigured crtc (2025-10-28 11:05:47 -0400)

Pulled into drm-fixes, thanks!
-Sima

> 
> ----------------------------------------------------------------
> amd-drm-fixes-6.18-2025-10-29:
> 
> amdgpu:
> - VPE idle handler fix
> - Re-enable DM idle optimizations
> - DCN3.0 fix
> - SMU fix
> - Powerplay fixes for fiji/iceland
> - License fixes
> - HDP eDP panel fix
> - Vblank fix
> 
> radeon:
> - devm migration fixes
> 
> ----------------------------------------------------------------
> Alex Deucher (4):
>       drm/amdgpu: fix SPDX headers on amdgpu_cper.c/h
>       drm/amdgpu: fix SPDX header on amd_cper.h
>       drm/amdgpu: fix SPDX header on irqsrcs_vcn_5_0.h
>       drm/amdgpu: fix SPDX header on cyan_skillfish_reg_init.c
> 
> Alex Hung (1):
>       drm/amd/display: Add HDR workaround for a specific eDP
> 
> Daniel Palmer (2):
>       drm/radeon: Do not kfree() devres managed rdev
>       drm/radeon: Remove calls to drm_put_dev()
> 
> Ivan Lipski (1):
>       drm/amd/display: Fix incorrect return of vblank enable on unconfigured crtc
> 
> John Smith (2):
>       drm/amd/pm/powerplay/smumgr: Fix PCIeBootLinkLevel value on Fiji
>       drm/amd/pm/powerplay/smumgr: Fix PCIeBootLinkLevel value on Iceland
> 
> Kenneth Feng (1):
>       drm/amd/display: pause the workload setting in dm
> 
> Mario Limonciello (1):
>       drm/amd: Check that VPE has reached DPM0 in idle handler
> 
> Matthew Schwartz (1):
>       drm/amd/display: Don't program BLNDGAM_MEM_PWR_FORCE when CM low-power is disabled on DCN30
> 
> Yang Wang (1):
>       drm/amd/pm: fix smu table id bound check issue in smu_cmn_update_table()
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c           |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h           |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c            | 34 +++++++++++++++++++---
>  .../gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c   |  2 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 21 +++++++++++--
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  1 +
>  .../gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c   |  3 --
>  drivers/gpu/drm/amd/include/amd_cper.h             |  2 +-
>  .../drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_5_0.h  |  2 +-
>  .../gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c  |  2 +-
>  .../drm/amd/pm/powerplay/smumgr/iceland_smumgr.c   |  2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |  2 +-
>  drivers/gpu/drm/radeon/radeon_drv.c                | 25 +++-------------
>  drivers/gpu/drm/radeon/radeon_kms.c                |  1 -
>  14 files changed, 61 insertions(+), 40 deletions(-)

-- 
Simona Vetter
Software Engineer
http://blog.ffwll.ch
