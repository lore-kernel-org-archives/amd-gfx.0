Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59720CCD1AB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 11:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAB4A10EA43;
	Fri, 24 Oct 2025 11:35:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="SC+5rg2h";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E21B410EA43
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 11:35:18 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-63c21467e5bso3337235a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 04:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1761305717; x=1761910517; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OIxlQ1hqkHknPtfnzCZtsZMEBgGzvgvHKIMgwhafa/0=;
 b=SC+5rg2hFs/yaFUEPVdEt8f1D5ZAFbrdD8W5r9JRLfr//RKhsArOATdKHAis5sq7VP
 UmxjTBJijEY7wynxZhOFUpLc/t/dIrWVFS6OdqBOMNF47XZAgrz53VCmlmShI3W/8c/m
 Bls1n7AV31lJ0cZLi1RBXCUPFzMU9CPO/H6Tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761305717; x=1761910517;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OIxlQ1hqkHknPtfnzCZtsZMEBgGzvgvHKIMgwhafa/0=;
 b=TpNgCxJ9v7YalHWBfTltkBxE0w3YrCTuytV8I61A50pX6yGq4RA3L4apWStXBAce4o
 K83CEB8S4FhY5DKMG5f+C2MU4oM3iRlpd/0H7gdFQ6YR5p6KpyvNHYE99UlYJmQMjRFn
 XLMseJd1jNw0XFJHNltaTyBvpvJUiWPJPTsZwRbz6wJ7v37MJVnEtlhB/DaSbv9kzn1S
 EY2sP/a4mfv2LclyotnGQXnir2AVITZT37pxBZFvscFXNlznXcpTp2bM8bk/IaYXih4M
 QVdXan4gSENUwdMIyIJpofMVySYGnompURjQzr6PRp8UcBDhiMp/dkHl8/AVkxKPd//G
 wI/Q==
X-Gm-Message-State: AOJu0YxwKCns7TPOz9qFy+/hJY48LObzAM3KQ4rhU2bFl9cSr0zbui4V
 2w/wgwGmANyzDsLxz/BWFjT2VtC+ZeT/qjJlyZ5g66abzRdNDXm4dQgdggPyaM/50o9RE6sC4YQ
 ouqD9
X-Gm-Gg: ASbGnctB11xjOf7lh/walrqRD2TYqW2GkEIMsSmsFIvc5i3XqYQY38/G8/6GeAmLQQ3
 QcZfOrZpHJyCEP0ljS9PiTrcFgdAubEiGUS12dCHp7qTSvcVT4wsOycAvyKbrz4651yOY3u/i6k
 gNdtVNpCnBCtaLhU4EVv2wHPtBFoHGXH2DixtGFTxqAK3hN8WZgS6iWcaqVdyxVHPR1y5IhVweh
 srZ1twMKDxTSVaBUOLxB49xzXiQmdUAFPIuBBmFKL9VG9tkCtcBg8qgKLDgyheVY9HSp9QYS4/t
 jb1L8ImkyOfHpq/m8Sz4bknXQ2Rv+1tLDpf9X0FI4rfUle1lTDQfOd4233xwM40yb5aWsLaIReR
 P8X0nABWl5mRh2QoPF3c64XBoxhh1pF7K+YqTf4qDlXkBW3aNPK5fXZPsMmrgSKG41z+wYbtXdl
 4iXDR3JFMJJ/Q=
X-Google-Smtp-Source: AGHT+IErKfcmqmsjgZ9Th0ARnwnAhvBNtwh2neb3bsKb2pMw+qMPf+IO6pPmhy46i/K/4sELZECXrw==
X-Received: by 2002:a05:6402:13d4:b0:639:e712:cd6c with SMTP id
 4fb4d7f45d1cf-63c1f641d39mr26435203a12.13.1761305716471; 
 Fri, 24 Oct 2025 04:35:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e3ebcbe35sm4048386a12.12.2025.10.24.04.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 04:35:15 -0700 (PDT)
Date: Fri, 24 Oct 2025 13:35:14 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, simona.vetter@ffwll.ch
Subject: Re: [pull] amdgpu drm-fixes-6.18
Message-ID: <aPtkcs7Hn_SIFHpq@phenom.ffwll.local>
References: <20251022222005.1787211-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022222005.1787211-1-alexander.deucher@amd.com>
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

On Wed, Oct 22, 2025 at 06:20:05PM -0400, Alex Deucher wrote:
> Hi Dave, Simona,
> 
> Fixes for 6.18.
> 
> The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:
> 
>   Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)
> 
> are available in the Git repository at:
> 
>   https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-6.18-2025-10-22
> 
> for you to fetch changes up to 72a1eb3cf573ab957ae412f0efb0cf6ff0876234:
> 
>   drm/amd/display: use GFP_NOWAIT for allocation in interrupt handler (2025-10-21 09:52:06 -0400)

Pulled into drm-fixes, thanks!
-Sima

> 
> ----------------------------------------------------------------
> amd-drm-fixes-6.18-2025-10-22:
> 
> amdgpu:
> - DP MST fix
> - Fix DC max link count
> - DC interrupt atomic context fix
> 
> ----------------------------------------------------------------
> Aurabindo Pillai (1):
>       drm/amd/display: use GFP_NOWAIT for allocation in interrupt handler
> 
> Charlene Liu (1):
>       drm/amd/display: increase max link count and fix link->enc NULL pointer access
> 
> Meenakshikumar Somasundaram (1):
>       drm/amd/display: Fix NULL pointer dereference
> 
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c             | 4 ++--
>  drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c     | 3 +++
>  drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h             | 8 +++++++-
>  drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c | 3 ++-
>  4 files changed, 14 insertions(+), 4 deletions(-)

-- 
Simona Vetter
Software Engineer
http://blog.ffwll.ch
