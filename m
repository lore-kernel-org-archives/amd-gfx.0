Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4332CC3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 12:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4859410E4DB;
	Wed,  7 Aug 2024 12:02:30 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A10110E4D8
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 12:02:28 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 477C2M8d2863966; Wed, 7 Aug 2024 17:32:23 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 477C2MTZ2863965;
 Wed, 7 Aug 2024 17:32:22 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 0/5] fix warning for condition check
Date: Wed,  7 Aug 2024 17:32:12 +0530
Message-Id: <20240807120217.2863917-1-sunil.khatri@amd.com>
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

*** BLURB HERE ***

Sunil Khatri (5):
  drm/amdgpu: fix ptr check warning in gfx9 ip_dump
  drm/amdgpu: fix ptr check warning in gfx10 ip_dump
  drm/amdgpu: fix ptr check warning in gfx11 ip_dump
  drm/amdgpu: fix ptr check warning in gfx12 ip_dump
  drm/amdgpu: fix ptr check warning in vcn_v3 ip_dump

 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c  | 2 +-
 5 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.34.1

