Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25361C77B6C
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 08:40:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6008310EA73;
	Thu, 13 Apr 2023 08:40:22 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29E6D10EA73
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 08:40:19 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-505048d50aeso170048a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 01:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1681375215; x=1683967215;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4Sn6I/2jhJqlg6vW0pkj3/yLVKkEvtsNFjghnbHxyRY=;
 b=a5u97wJFGQvk3JCFTbLCXZZ+dkvUg1UOH8jaESwHobFcGa7A0CcWtLNaVgRjjUqJ2P
 LEBeE7c/uBdVt1dTasr9zK5oR/BMCWr/MLWNMZV90eyhygUO81f3zKZGQC07Db7z1G4t
 xA18f29TsWQHoFYd1Ooiw+KGQS8Uig9ijgeyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681375215; x=1683967215;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Sn6I/2jhJqlg6vW0pkj3/yLVKkEvtsNFjghnbHxyRY=;
 b=hzuBS+MohZMOElF8L5vePXJCWWhP1p5zTgOFM0DDgBX429VF7g1yqnIDCnH5NK2w4M
 t8u/n1MZEQMvBE9qndmJNjT7g2vwDepoaYYNAzxP6mwquz1MvGT0KytKjCMSpx4JDUz5
 KuCAcHNPsRk3SdHk3DstjkoXSETK7v+7tnQ77if3/RcqIYBvKQXy/6F35Q37BVOOMMyy
 OJ1USSHX7wFtoiiiaQffKxQGBRBulLtUbXAQD2dnYkaoVvzfoZ00lWXtNcy9hb2AMNIW
 nzSLFpYiTK2hUix92+iWlJHytuQe6FpcPDJZlfG4m0Cb+q3x+106vsNPnJfZD/xfnjjP
 6y7A==
X-Gm-Message-State: AAQBX9eAowVvfplCO/TuC5w3SXRwPsv4JHrMa+1YX3PJB8uCrhaIZ/lB
 sHeFAFUi4lQZhN+8G9pM8HJICA==
X-Google-Smtp-Source: AKy350Y1WB2NKyn1EDKtYPDDv7HEddLLg4ssQ6oLam5KmgAyRhPUNkIK7XnjcRmg60pRlX5Ub3n50w==
X-Received: by 2002:a05:6402:4305:b0:502:ffd:74a0 with SMTP id
 m5-20020a056402430500b005020ffd74a0mr1913423edc.2.1681375215621; 
 Thu, 13 Apr 2023 01:40:15 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net.
 [212.51.149.33]) by smtp.gmail.com with ESMTPSA id
 l11-20020a1709066b8b00b009475bd8f441sm644284ejr.60.2023.04.13.01.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Apr 2023 01:40:15 -0700 (PDT)
Date: Thu, 13 Apr 2023 10:40:13 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [pull] amdgpu drm-fixes-6.3
Message-ID: <ZDe/7WGGFeWmbynG@phenom.ffwll.local>
References: <20230412215637.7881-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412215637.7881-1-alexander.deucher@amd.com>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
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

On Wed, Apr 12, 2023 at 05:56:37PM -0400, Alex Deucher wrote:
> Hi Dave, Daniel,
> 
> Fixes for 6.3.
> 
> The following changes since commit 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d:
> 
>   Linux 6.3-rc6 (2023-04-09 11:15:57 -0700)
> 
> are available in the Git repository at:
> 
>   https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-6.3-2023-04-12
> 
> for you to fetch changes up to b9a24d8bd51e2db425602fa82d7f4c06aa3db852:
> 
>   drm/amd/pm: correct the pcie link state check for SMU13 (2023-04-12 16:11:22 -0400)

Pulled, thanks
> 
> ----------------------------------------------------------------
> amd-drm-fixes-6.3-2023-04-12:
> 
> amdgpu:
> - SMU13 fixes
> - DP MST fix
> 
> ----------------------------------------------------------------
> Evan Quan (1):
>       drm/amd/pm: correct the pcie link state check for SMU13
> 
> Horatio Zhang (2):
>       drm/amd/pm: correct SMU13.0.7 pstate profiling clock settings
>       drm/amd/pm: correct SMU13.0.7 max shader clock reporting
> 
> Wayne Lin (1):
>       drm/amd/display: Pass the right info to drm_dp_remove_payload
> 
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 57 ++++++++++++--
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h       |  6 ++
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  4 +-
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   | 87 +++++++++++++++++++---
>  4 files changed, 135 insertions(+), 19 deletions(-)

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
