Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46690C761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 16:56:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A496F10E42D;
	Thu, 30 Mar 2023 16:56:19 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5430310EF16
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 16:56:17 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 i5-20020a05600c354500b003edd24054e0so13804446wmq.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 09:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1680195376; x=1682787376;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rSWBz3mIBXBdxw6TcqTLatMi79mw1Y62Q64fcwwg5XQ=;
 b=gUhdOPd+Up9qPAdQUYDa8lvbClM59gdqiYAopfZpomdemOlRmBp0G8LVud1yU4blJO
 q6F8CoPwbjXxsTCLt6YRDgxoXLTI3wr23Jyf03ben6fb2JGQHZRO86B+0bAdLB+p0ZMd
 McLwYmfe+oy6rqzo9UCBUDwrg4WcKmyqqSsxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680195376; x=1682787376;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rSWBz3mIBXBdxw6TcqTLatMi79mw1Y62Q64fcwwg5XQ=;
 b=llR2s1cKpOqTEO25zgsgGo44sNkOQD/vNYKbAQwXDmylTVHxIi9Pqc7Qto69vEIRUr
 ps5Pf1e+5q6IN1PaS3fFzBEXLQwzYMDp+eunOxSLRHLpuEqsxCFTugXnGZYcHdYXGanN
 J+7igMNWuFm3P9Ab6VeCKHuVJUCl/Aj6/dVYvqrWYrtoq6ngVI/hToTIPz7jDxt0pT/q
 84GJBVEFiJDawW2wTE8E+3yqAzQ81+QrhyA9AxIFDCy229blNoSd7QMnIveoEWOm1jYz
 ebKsvVWnpDH4CGJ8y1zY5oaaUXCMKg8pBzLho5ySNDCA9DaumJVeWkhv6r/HRU+cqoc9
 PAHg==
X-Gm-Message-State: AAQBX9fLlkv523V2As25JnwlPnCS4c7wKlCZnJiPI5uvKngVEGqgvos0
 N6s79yylccyiZjyLy4N/+tR0uA==
X-Google-Smtp-Source: AKy350a0GUu3C0dSw3paeLQHDiulOYdP58SAJNcFfM1Hzo2BSLl88mMtdmXrVa72+MbPIRw0DbxW1g==
X-Received: by 2002:a05:600c:1550:b0:3ed:d2ae:9adb with SMTP id
 f16-20020a05600c155000b003edd2ae9adbmr2505251wmg.0.1680195375828; 
 Thu, 30 Mar 2023 09:56:15 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net.
 [212.51.149.33]) by smtp.gmail.com with ESMTPSA id
 k4-20020a05600c1c8400b003ee610d1ce9sm7005666wms.34.2023.03.30.09.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Mar 2023 09:56:15 -0700 (PDT)
Date: Thu, 30 Mar 2023 18:56:13 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [pull] amdgpu drm-fixes-6.3
Message-ID: <ZCW/LWgWX7+uBUuc@phenom.ffwll.local>
References: <20230329220059.7622-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329220059.7622-1-alexander.deucher@amd.com>
X-Operating-System: Linux phenom 6.1.0-6-amd64 
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

On Wed, Mar 29, 2023 at 06:00:59PM -0400, Alex Deucher wrote:
> Hi Dave, Daniel,
> 
> Fixes for 6.3.
> 
> The following changes since commit 197b6b60ae7bc51dd0814953c562833143b292aa:
> 
>   Linux 6.3-rc4 (2023-03-26 14:40:20 -0700)
> 
> are available in the Git repository at:
> 
>   https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-6.3-2023-03-29
> 
> for you to fetch changes up to 68dc1846c3a44d5e633be145c169ce2fd5420695:
> 
>   drm/amd/display: Take FEC Overhead into Timeslot Calculation (2023-03-29 17:21:06 -0400)

Pulled, thanks

> 
> ----------------------------------------------------------------
> amd-drm-fixes-6.3-2023-03-29:
> 
> amdgpu:
> - Two DP MST fixes
> 
> ----------------------------------------------------------------
> Fangzhi Zuo (2):
>       drm/amd/display: Add DSC Support for Synaptics Cascaded MST Hub
>       drm/amd/display: Take FEC Overhead into Timeslot Calculation
> 
>  .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 51 ++++++++++++++++++----
>  .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    | 15 +++++++
>  2 files changed, 58 insertions(+), 8 deletions(-)

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
