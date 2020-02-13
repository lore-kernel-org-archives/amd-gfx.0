Return-Path: <SRS0=YeOH=4B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3310AC2BA83
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2020 12:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 027692073C
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2020 12:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/qwFnev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027692073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E16346E05D;
	Thu, 13 Feb 2020 12:19:41 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E41F6E05D;
 Thu, 13 Feb 2020 12:19:41 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id s10so5992692wmh.3;
 Thu, 13 Feb 2020 04:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=DChaK8xA6PI1z8LO1wrFicDsQdGY7cV2AURNQvkwte4=;
 b=d/qwFnevl234mUzHUW1ZBcmp9vjzsdxI3ACVvilW+I4CC9fqI5vMFeMucB+nGvtrfZ
 DZzscRt1RFa30YD7hYB4C6TRr0StJ/8MVXmhvylZDvOVtL3yuMhu/d7bBhT2OPEkNIov
 7C1ESEgUzRioOGKMFqHmVi7ZhRjek8kdE/GdHphCGAee+6t2y29QAxjM2aUMUDQ66hDi
 ZEr7BhZ1beDb/xlAcqtrPBKS8LF1H/JQglvu33BsVAUopgKFLpwwTUj+ofFHSGJRNwEF
 wIyccpP3nWu3QMRtZGBX+M9tapxUBjKz3BBu2ZKbLYDvev1KFerBlVVRUg1ru8PXgVb4
 MwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=DChaK8xA6PI1z8LO1wrFicDsQdGY7cV2AURNQvkwte4=;
 b=peVke8TDv4YS8Ef4Tlry25kHBjARkkumbvSN68L6K+YiebR3d6cNL1vFX+nkze5Hw6
 fy6Wz432Osp6Ma3dyPhv3ZCvLwUrvws76mCSLCffBlUzWcx35qgDMU2H5tDDAcA//V/J
 eh2zNaxHuTRm84RiiLQdLx+HaTEKEvZ1i76Cfzj7yQlbZuwB+rJwWK9LPjd2iFNStKUY
 IhSxw8VrT4S7cnzvabPpuZlIG7AMarHMshEMbSPxjiwu7Y1ansHeEm5LCMZocB6YQWHa
 LuoNn+eyyM213lbCFELa8Er7IWl2oYgAO5ur7mVkLffCNXjT4fKc/Lyn9+SjSePuRI7O
 wK2Q==
X-Gm-Message-State: APjAAAXtWrijuHm4MxFXZmpcjmWOpmTXReGNInBI7rMxuwJmAn88s9x5
 cW7ZyMMxp4W9FaUcP97DfLw=
X-Google-Smtp-Source: APXvYqxsFm1LYM8+XXctYV4Bq8del7DfJb9Vh3k9OS5L5SGH7n8QTZ5WvBHyyM/RTng33ciKpGBdgQ==
X-Received: by 2002:a1c:6a16:: with SMTP id f22mr5447239wmc.53.1581596379714; 
 Thu, 13 Feb 2020 04:19:39 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id f12sm2759216wmj.10.2020.02.13.04.19.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Feb 2020 04:19:39 -0800 (PST)
Subject: Re: [RFC PATCH 0/6] do not store GPU address in TTM
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, dri-devel@lists.freedesktop.org
References: <20200213120203.29368-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <f21a8266-1ac1-c129-d9e6-f3158035be80@gmail.com>
Date: Thu, 13 Feb 2020 13:19:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200213120203.29368-1-nirmoy.das@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: David1.Zhou@amd.com, thellstrom@vmware.com, airlied@linux.ie,
 kenny.ho@amd.com, brian.welty@intel.com, maarten.lankhorst@linux.intel.com,
 amd-gfx@lists.freedesktop.org, nirmoy.das@amd.com,
 linux-graphics-maintainer@vmware.com, bskeggs@redhat.com, daniel@ffwll.ch,
 alexander.deucher@amd.com, sean@poorly.run, christian.koenig@amd.com,
 kraxel@redhat.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.02.20 um 13:01 schrieb Nirmoy Das:
> With this patch series I am trying to remove GPU address dependency in
> TTM and moving GPU address calculation to individual drm drivers.
> This is required[1] to continue the work started by Brian Welty to create
> struct drm_mem_region which can be leverage by DRM cgroup controller to manage memory
> limits.

Nice work. I wouldn't say that it is necessary for [1], but it is 
certainly nice to have that cleaned up.

Christian.

>
>
> I have only manage to test amdgpu driver as I only have GPU for that.
> I might be doing something really stupid while calculeting gpu offset for
> some of the drivers so please be patient and let me know how can I improve
> that.
>
> [1] https://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg272238.html
>
> Nirmoy Das (6):
>    drm/amdgpu: move ttm bo->offset to amdgpu_bo
>    drm/radeon: don't use ttm bo->offset
>    drm/vmwgfx: don't use ttm bo->offset
>    drm/nouveau: don't use ttm bo->offset
>    drm/qxl: don't use ttm bo->offset
>    drm/ttm: do not keep GPU dependent addresses
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 22 ++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 29 ++++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  4 +--
>   drivers/gpu/drm/nouveau/dispnv04/crtc.c     |  6 ++---
>   drivers/gpu/drm/nouveau/dispnv04/disp.c     |  2 +-
>   drivers/gpu/drm/nouveau/dispnv04/overlay.c  |  6 ++---
>   drivers/gpu/drm/nouveau/dispnv50/base507c.c |  2 +-
>   drivers/gpu/drm/nouveau/dispnv50/core507d.c |  2 +-
>   drivers/gpu/drm/nouveau/dispnv50/ovly507e.c |  2 +-
>   drivers/gpu/drm/nouveau/dispnv50/wndw.c     |  2 +-
>   drivers/gpu/drm/nouveau/dispnv50/wndwc37e.c |  2 +-
>   drivers/gpu/drm/nouveau/nouveau_abi16.c     |  8 +++---
>   drivers/gpu/drm/nouveau/nouveau_bo.c        |  1 +
>   drivers/gpu/drm/nouveau/nouveau_bo.h        |  3 +++
>   drivers/gpu/drm/nouveau/nouveau_chan.c      |  2 +-
>   drivers/gpu/drm/nouveau/nouveau_fbcon.c     |  2 +-
>   drivers/gpu/drm/nouveau/nouveau_gem.c       | 10 +++----
>   drivers/gpu/drm/qxl/qxl_drv.h               |  6 ++---
>   drivers/gpu/drm/qxl/qxl_kms.c               |  3 +++
>   drivers/gpu/drm/qxl/qxl_object.h            |  5 ----
>   drivers/gpu/drm/qxl/qxl_ttm.c               |  9 -------
>   drivers/gpu/drm/radeon/radeon.h             |  1 +
>   drivers/gpu/drm/radeon/radeon_object.h      | 16 +++++++++++-
>   drivers/gpu/drm/radeon/radeon_ttm.c         |  4 +--
>   drivers/gpu/drm/ttm/ttm_bo.c                |  7 -----
>   drivers/gpu/drm/vmwgfx/vmwgfx_bo.c          |  4 +--
>   drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c     |  2 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c        |  2 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c  |  2 --
>   include/drm/ttm/ttm_bo_api.h                |  2 --
>   include/drm/ttm/ttm_bo_driver.h             |  1 -
>   33 files changed, 99 insertions(+), 72 deletions(-)
>
> --
> 2.25.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
