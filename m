Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EC1C4828F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Feb 2024 21:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22E3510ED86;
	Thu,  8 Feb 2024 21:06:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="bPVMvjuN";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3A6010ED8C;
 Thu,  8 Feb 2024 21:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kyFdaFZn5fxDlyBsRXk/mw238QRIyiO/3fj7J8kHjNw=; b=bPVMvjuN+0OiIcqtRCnCv2qXcQ
 VAxWA+DDjI9bpmt4CiVU4Ac8fEHRJSjJFrdbIdDiYNwvw3H0o8Pv4f1pKTXV7UjoGj0G4YjG1TqmJ
 dqqi1KNO7NkfPdDq0hmQYpsxDu5JNv9W4LALJCRJMzH836YDGu8j6wyOoOBjNeYP/09BEt+zJf/+o
 zA6fEfVqC41T22xFVkfqooE1CTg0k6fdXh6YaNTzuL/iyFFh6u6fVbQPo1+9PFSO+pQA4ToHWVLos
 nUvIIGaTBPedsneHdQjkWIa52dooBitg3MwbIqvEdV80ymjRMl/83Aas/Nb6sApw1MhbCajY44/qn
 hffwKQhA==;
Received: from [177.45.63.184] (helo=steammachine.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1rYBak-00FMBk-IJ; Thu, 08 Feb 2024 22:05:54 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: kernel-dev@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 Simon Ser <contact@emersion.fr>, Pekka Paalanen <ppaalanen@gmail.com>,
 daniel@ffwll.ch, Daniel Stone <daniel@fooishbar.org>,
 =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
 Dave Airlie <airlied@gmail.com>, ville.syrjala@linux.intel.com,
 Xaver Hugl <xaver.hugl@gmail.com>, Joshua Ashton <joshua@froggi.es>,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v4 0/3] drm/atomic: Allow drivers to write their own plane
 check for async
Date: Thu,  8 Feb 2024 18:05:39 -0300
Message-ID: <20240208210542.550626-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi,

AMD hardware can do async flips with overlay planes, so this patchset does a
small redesign to allow drivers to choose per plane type if they can or cannot
do async flips.

It also allows async commits with IN_FENCE_ID in any driver.

Changes from v3:
- Major patchset redesign 
v3: https://lore.kernel.org/lkml/20240128212515.630345-1-andrealmeid@igalia.com/

Changes from v2:
 - Allow IN_FENCE_ID for any driver
 - Allow overlay planes again
v2: https://lore.kernel.org/lkml/20240119181235.255060-1-andrealmeid@igalia.com/

Changes from v1:
 - Drop overlay planes option for now
v1: https://lore.kernel.org/dri-devel/20240116045159.1015510-1-andrealmeid@igalia.com/

André Almeida (3):
  drm/atomic: Allow userspace to use explicit sync with atomic async
    flips
  drm: Allow drivers to choose plane types to async flip
  drm/amdgpu: Make it possible to async flip overlay planes

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 1 +
 drivers/gpu/drm/drm_atomic_uapi.c                       | 8 +++++---
 drivers/gpu/drm/drm_plane.c                             | 3 +++
 include/drm/drm_plane.h                                 | 5 +++++
 4 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.43.0

