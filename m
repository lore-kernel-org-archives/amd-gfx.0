Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D003FC982FB
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jan 2026 19:27:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C16810E054;
	Fri, 16 Jan 2026 19:27:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="MihcfWZp";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DD8910E054
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 19:27:11 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-64d30dc4ed7so4566080a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 11:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1768591630; x=1769196430; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cjMTrYrBrzeKqdwskRII283z1dzc+3pWLLZSVhN1rL0=;
 b=MihcfWZpypk9dsVu6gHi1AGiyyLlxTN3w+fSJKhK90OgjrvQZ/X87XY0Vp0YBC6az5
 2hkC/g01ho5TVbbAr7FD5UDzko+Au9fkqkkGAXgjr31HqX4+y3xWvWcdboO9IBckH0SZ
 7DNcLim09aT4mwYzfqDExDG/UkjYtZcFynJMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768591630; x=1769196430;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cjMTrYrBrzeKqdwskRII283z1dzc+3pWLLZSVhN1rL0=;
 b=SUQOwLeTYGIxS40Jz8b1vSgvyR4oMiS9Tpe48oel+OnpJpsfrqaa687oA669wDkYk/
 GELXxge9kxSf2ijpNZ5kizLEpskqyStsK8UlJvSOX8QCsGq8V0ghjad2TD1lQzsh/w98
 G6BcSM5WhHXGhGfMRfW7eIE/lY5uYQLIe2rb5wJMUBw96r1Qyx9qcDbrXmrN37MdQup2
 IxzS6ozQRDgmjIXjuno0zJWaJqlCNenj8QURnd/fHwOamGifL4q8Dr66XkH6WVTx6JcQ
 zob8IQK6ZPZJgw3uMES3ZkfTW/QobKJXNSNVCFF8RmXJ+d/CPVSWZhvJI4BCNktyAtVM
 DRoQ==
X-Gm-Message-State: AOJu0Yzj2+svoY4sZ/vthaRvHmqEsuXdbVRgOiBqnB7ksKameLeiRcgS
 4pSldCyY/e6IJutnyODSadpzeh7TbJmOLco0oxi6T4AXuSySQ1RHbgTTSWxIAYpDDp0=
X-Gm-Gg: AY/fxX6ZMxTQ9ZzE+igeH7S7X+LhOzi3QC91gwkGuWwgZXWsuV3mG5dfrc5jQDoKQIk
 pvSOtqwmiU5nVZzAlqIfCSZt1IG/ilfDml+XnoiJbasAET5KDE3oaz2hcMqXKHamuETORzcI+1x
 l7UNkU8rmJXNtb7MKcbM4Zbb/hPT+zdUz3MmGqavjkaO1ZEQae7CWD5x+rNFZMrSkegmz+eo4xB
 g6do01YPLNmp8vvddVuCWJdrqApxMY0Xp9MYvk1fupycci1iyj4f5977QKZXFpNdzcJ37LkrYEw
 MTGbw02OJ4OLV8AYd4oe4a4bqo+SAbLmjq6mytfS+81vm99xeKDYKohlEqmx9xtQkqpUJ1wjeAI
 77xhiCQqBdNKNqL+UOvvFMowuNlCvNQ55vFUSJGqtOqNOUar/kWTSkgScb15fweRTznEgerbHEs
 NU0mNJjmCewMCHOaMmkcpZMyJmq1/wOxWMpg==
X-Received: by 2002:a05:6402:23c4:b0:655:ad4d:66a2 with SMTP id
 4fb4d7f45d1cf-655ad4d67eemr1941937a12.1.1768591629985; 
 Fri, 16 Jan 2026 11:27:09 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65452cdab55sm3233595a12.10.2026.01.16.11.27.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 11:27:09 -0800 (PST)
Date: Fri, 16 Jan 2026 20:27:07 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, simona.vetter@ffwll.ch
Subject: Re: [pull] amdgpu, amdkfd drm-fixes-6.19
Message-ID: <aWqRC3xvwpeW7I6t@phenom.ffwll.local>
References: <20260115205405.1890089-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115205405.1890089-1-alexander.deucher@amd.com>
X-Operating-System: Linux phenom 6.17.10+deb14-amd64 
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

On Thu, Jan 15, 2026 at 03:54:05PM -0500, Alex Deucher wrote:
> Hi Dave, Simona,
> 
> Fixes for 6.19.
> 
> The following changes since commit 0f61b1860cc3f52aef9036d7235ed1f017632193:
> 
>   Linux 6.19-rc5 (2026-01-11 17:03:14 -1000)
> 
> are available in the Git repository at:
> 
>   https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-6.19-2026-01-15
> 
> for you to fetch changes up to d04f73668bebbc5a44a2771ea92b6ec253148050:
> 
>   drm/amd/display: Add an hdmi_hpd_debounce_delay_ms module (2026-01-14 15:07:43 -0500)

Pulled into drm-fixes, thanks!

Cheers, Sima
> 
> ----------------------------------------------------------------
> amd-drm-fixes-6.19-2026-01-15:
> 
> amdgpu:
> - GC 9 PTE mtype fix
> - Non-DC display kernel panic helper fix
> - Merge fix
> - GART vram access fix
> - Userq fixes
> - PSR debugging fix
> - HDMI fixes
> - Backlight fix
> - SMU 14 fix
> - TLB flush fixes
> 
> amdkfd:
> - KFD node cleanup for eGPU disconnect
> - Memory leak fix
> - MES evict process fix
> 
> ----------------------------------------------------------------
> Alex Deucher (1):
>       drm/amdgpu: make sure userqs are enabled in userq IOCTLs
> 
> Haoxiang Li (1):
>       drm/amdkfd: fix a memory leak in device_queue_manager_init()
> 
> Harish Kasiviswanathan (1):
>       drm/amdkfd: No need to suspend whole MES to evict process
> 
> Ivan Lipski (1):
>       drm/amd/display: Add an hdmi_hpd_debounce_delay_ms module
> 
> Lu Yao (1):
>       drm/amdgpu: fix drm panic null pointer when driver not support atomic
> 
> Mario Limonciello (1):
>       drm/amd/display: Bump the HDMI clock to 340MHz
> 
> Mario Limonciello (AMD) (2):
>       drm/amd: Clean up kfd node on surprise disconnect
>       drm/amd/display: Show link name in PSR status message
> 
> Peter Colberg (1):
>       Revert duplicate "drm/amdgpu: disable peer-to-peer access for DCC-enabled GC12 VRAM surfaces"
> 
> Philip Yang (1):
>       drm/amdgpu: Fix gfx9 update PTE mtype flag
> 
> Prike Liang (2):
>       drm/amdgpu: validate the flush_gpu_tlb_pasid()
>       Revert "drm/amdgpu: don't attach the tlb fence for SI"
> 
> Srinivasan Shanmugam (1):
>       drm/amdgpu/userq: Fix fence reference leak on queue teardown v2
> 
> Vivek Das Mohapatra (1):
>       drm/amd/display: Initialise backlight level values from hw
> 
> Xiaogang Chen (1):
>       drm/amdgpu: Use correct address to setup gart page table for vram access
> 
> Yang Wang (1):
>       drm/amd/pm: fix smu overdrive data type wrong issue on smu 14.0.2
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  8 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |  7 ++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c        | 12 --------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            | 11 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c           |  4 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |  4 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 16 ++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |  8 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  4 +--
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |  8 ++---
>  .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 31 ++++++++-----------
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 36 +++++++++++++++++++---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  5 ++-
>  drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h     |  2 +-
>  .../gpu/drm/amd/display/dc/link/link_detection.c   |  4 ++-
>  .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |  3 +-
>  18 files changed, 116 insertions(+), 50 deletions(-)

-- 
Simona Vetter
Software Engineer
http://blog.ffwll.ch
