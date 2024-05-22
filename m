Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4D4C25B79
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 07:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AC0310F417;
	Wed, 22 May 2024 07:30:50 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B40E210EE15
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 07:30:25 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 44M7UJtV009389; Wed, 22 May 2024 13:00:19 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 44M7UI5D009382;
 Wed, 22 May 2024 13:00:18 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 00/10] ipdump support for gfx10 and gfx11
Date: Wed, 22 May 2024 12:59:40 +0530
Message-Id: <20240522072950.9162-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

With this support for gfx10 and gfx11 ipdump is complete.
Also added dev_info needed fields for devcoredump.

Sunil Khatri (10):
  drm/amdgpu: rename the ip_dump to ip_dump_core
  drm/amdgpu: Add cp queues support fro gfx10 in ipdump
  drm/amdgpu: add gfx queue support of gfx10 in ipdump
  drm/amdgpu: add prints while ip register dump
  drm/amdgpu: add more device info to the devcoredump
  drm/amdgpu: Add missing offsets in gc_11_0_0_offset.h
  drm/amdgpu: add gfx11 registers support in ipdump
  drm/amdgpu: add print support for gfx11 ipdump
  drm/amdgpu: add cp queue registers for gfx11 ipdump
  drm/amdgpu: add gfx queue support for gfx11 ipdump

 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  |  21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 220 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 323 +++++++++++++++++-
 .../include/asic_reg/gc/gc_11_0_0_offset.h    |  10 +
 6 files changed, 564 insertions(+), 16 deletions(-)

-- 
2.34.1

