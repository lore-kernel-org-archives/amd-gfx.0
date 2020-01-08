Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5C4C282DD
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 21:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E05620692
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 21:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N62/E8B8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E05620692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8276B6E34B;
	Wed,  8 Jan 2020 21:37:02 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44D9C6E342;
 Wed,  8 Jan 2020 21:37:01 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id e5so4084641qtm.6;
 Wed, 08 Jan 2020 13:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Eqf/Rney/KXNkdohGRbIzL/r01lLtkHC8U7UmM5VOcA=;
 b=N62/E8B8ie/qFxeNUz5j9B3Og1MyM2s3eBoIQzlhU4QzLTGxlkODgQUw1JlYu56B6W
 zOUVF41ATVqOXQnqTuQtekmDeQjR/0tCdPOYLBCXft2hOY4WNV1ulQfeGGaHlYHFONWO
 N6zrs8YlsSq7zZZCAbNV+w4MSu0EhyUS9gUZK26Hbv7Dzy4fdz/hDegkbJoVl5Ic/tnm
 fXxq+AI1QxVuxltzxj+AZXgSxIUplkSTP/w9CCY2+s+Au8jnA97KsucfMbWdOzNZ0F4D
 7Of9RuFUvNTFfTEjcYSIS176VXT7FaGLMjgniHZYfkT8tKfiHhY+jua4QXXMeplilnqW
 oetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Eqf/Rney/KXNkdohGRbIzL/r01lLtkHC8U7UmM5VOcA=;
 b=trj6ulIVECuGc8VsMuJj+fxb11qNG8FvKC7CYa8FaspATHro5Q9ptTkwMG8J6MJmVF
 BM/lxTDYBFLXntjyEIMqNsvRAeneK1aHvr42HH4HaBAAvsHU/Xdr1hG0r4agS/2CPR1V
 eByIc5IZvUILUsuh79HVbAcwvEw75HqLgDt7FJ3B0rrZ504fvfxWmPgKei2lq6RBB+wG
 k6D4w2Om07T2Pex9i4HNi/7v0CddPer+59/H3nDwwQqL+2VoyGDpn9CGzjfpET04OG62
 mceQb77Z1XaBRi0pItfEvOZh/fSm/MoNaHlnetHfMywRO6fBPo4QPjz9KgPIWylV7O7S
 k0nQ==
X-Gm-Message-State: APjAAAX2x+zUnFNUJ95075taKtuGNFAV7tjjPH7tER+H0qpErqWhTIyY
 Rk2P0MOiz61IP1XMgQ/zvqnjhlW1
X-Google-Smtp-Source: APXvYqyc8/7vDzu9aeN273Pus8UY0yT56JbgLT3I8eymXGdPF1wkbwJk4YN1bLCdKjntIiWAyY8DtA==
X-Received: by 2002:aed:3c16:: with SMTP id t22mr5305742qte.92.1578519420170; 
 Wed, 08 Jan 2020 13:37:00 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id i6sm2017226qkk.7.2020.01.08.13.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 13:36:59 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, daniel.vetter@ffwll.ch
Subject: [pull] amdgpu drm-fixes-5.5
Date: Wed,  8 Jan 2020 16:36:49 -0500
Message-Id: <20200108213649.5485-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Dave, Daniel,

A few minor fixes for 5.5.  This also enables DRIVER_SYNCOBJ_TIMELINE which
has been implemented for ages, but was awaiting Khronos which has since
happened.  The relevant amdvlk code is in:
https://github.com/GPUOpen-Drivers/pal/blob/dev/src/core/os/amdgpu/amdgpuDevice.cpp

The following changes since commit a6204fc7b83cbe3398f61cf1742b09f66f0ae220:

  agp: remove unused variable arqsz in agp_3_5_enable() (2020-01-03 16:08:05 +1000)

are available in the Git repository at:

  git://people.freedesktop.org/~agd5f/linux tags/amd-drm-fixes-5.5-2020-01-08

for you to fetch changes up to db4ff423cd1659580e541a2d4363342f15c14230:

  drm/amdgpu: add DRIVER_SYNCOBJ_TIMELINE to amdgpu (2020-01-07 11:33:32 -0500)

----------------------------------------------------------------
amd-drm-fixes-5.5-2020-01-08:

amdgpu:
- Stability fix for raven
- Reduce pixel encoding to if max clock is exceeded on HDMI
  to allow additional high res modes

UAPI:
- enable DRIVER_SYNCOBJ_TIMELINE for amdgpu

----------------------------------------------------------------
Alex Deucher (1):
      Revert "drm/amdgpu: Set no-retry as default."

Chunming Zhou (1):
      drm/amdgpu: add DRIVER_SYNCOBJ_TIMELINE to amdgpu

Thomas Anderson (1):
      drm/amd/display: Reduce HDMI pixel encoding if max clock is exceeded

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           |  7 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 45 ++++++++++++-----------
 2 files changed, 27 insertions(+), 25 deletions(-)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
