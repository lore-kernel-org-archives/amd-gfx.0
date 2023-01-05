Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB37C3DA7A
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 11:38:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D92DA10E6F1;
	Thu,  5 Jan 2023 11:38:26 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15C7810E6F1
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 11:38:24 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id bn26so16358530wrb.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Jan 2023 03:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hySCfKa8KIPpsvtDHCf0UU2LzfHTztsWXeMd0hZAN6s=;
 b=SBDyO3JqxiIHyVJhIoRYIzQUJA39wxzHw8VjJz/J6DQ9lboHktzyVKjgpebfYM2S89
 sSU4Yauado23dTeg9vvHaS5d2KrnS9QFtTfipDgdaf9nrJ92+UboJAkTwy+5d8URUoJc
 io4tFoeFYjw37mlqvTKZ7SXz7shCTJ9rYFEFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hySCfKa8KIPpsvtDHCf0UU2LzfHTztsWXeMd0hZAN6s=;
 b=KM2yk+Ak3zbNz5xDtLHkeXQOVvpZ6NrHsz9KEwof8amT+aifu1bFsXWtlswCj24BhU
 uBhKXxN4OirB30V8veOMAWoBKdwPJlHl6ya0NLHju8l9I6pTVXC9AsLxTVKfKy9SjgRN
 ApDXFZ310EXGjEMIQMb8NSjFeQEZFOOS6gbZJkKOaF7VnUzD0IRD8/bGvbxKVJ6P9WJ+
 O/aDR/gn35lxI8GTwpu7Quo8D1nKZzYpE7j0El9Chx9IgbcBdSWTTDoHUs2bVA4Hciq8
 3YSBf8aXueqGpZzsYQR/7OrrLe3MfTekDoKz3lsrB6LyS3KthagX0h2K8MwKj9F7T4WW
 0hoA==
X-Gm-Message-State: AFqh2kqdIBWl+ZHzyAv5hPAlqaHWCFM3ZPOXd8SSsPMhHYYDFlm2W8bj
 w29LoE9rutdmSaZ2QZWjlLoJEw==
X-Google-Smtp-Source: AMrXdXvDbpEuac3MV0JcmtO9XS0TsBXDkSWBSYFq9bukr4Yx8uwuI+1KqzdGMavbutLO7ruQ8Qwc5g==
X-Received: by 2002:a5d:51c7:0:b0:29d:7fe4:b70e with SMTP id
 n7-20020a5d51c7000000b0029d7fe4b70emr6323092wrv.7.1672918702605; 
 Thu, 05 Jan 2023 03:38:22 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 j13-20020a5d618d000000b002425dc49024sm36158674wru.43.2023.01.05.03.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jan 2023 03:38:21 -0800 (PST)
Date: Thu, 5 Jan 2023 12:38:19 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [pull] amdgpu, amdkfd drm-fixes-6.2
Message-ID: <Y7a2q3X44WiIKYX4@phenom.ffwll.local>
References: <20230105033839.23711-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105033839.23711-1-alexander.deucher@amd.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
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

On Wed, Jan 04, 2023 at 10:38:39PM -0500, Alex Deucher wrote:
> Hi Dave, Daniel,
> 
> Fixes for 6.2.
> 
> The following changes since commit c8de526215fdab9f2dd0d9675582cf9f1391a919:
> 
>   Merge tag 'drm-misc-next-fixes-2023-01-03' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2023-01-03 21:02:57 +0100)
> 
> are available in the Git repository at:
> 
>   https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-6.2-2023-01-04
> 
> for you to fetch changes up to 6fe6ece398f7431784847e922a2c8c385dc58a35:
> 
>   Revert "drm/amd/display: Enable Freesync Video Mode by default" (2023-01-04 22:29:32 -0500)

Pulled, thanks a lot.
-Daniel
> 
> ----------------------------------------------------------------
> amd-drm-fixes-6.2-2023-01-04:
> 
> amdgpu:
> - DCN 3.2 fix
> - Display fix
> 
> amdkfd:
> - Fix kernel warning
> 
> ----------------------------------------------------------------
> Michel Dänzer (1):
>       Revert "drm/amd/display: Enable Freesync Video Mode by default"
> 
> Mukul Joshi (1):
>       drm/amdkfd: Fix kernel warning during topology setup
> 
> Samson Tam (1):
>       drm/amd/display: Uninitialized variables causing 4k60 UCLK to stay at DPM1 and not DPM0
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            | 27 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |  2 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 12 ++++++----
>  .../dc/dml/dcn32/display_mode_vba_util_32.c        |  6 ++---
>  5 files changed, 39 insertions(+), 9 deletions(-)

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
