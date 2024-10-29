Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47869D2AB3C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 13:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65F5F10E664;
	Tue, 29 Oct 2024 13:50:45 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AABB10E663
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 13:50:33 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 49TDoLQL2494514; Tue, 29 Oct 2024 19:20:21 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 49TDoLtB2494513;
 Tue, 29 Oct 2024 19:20:21 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Leo Liu <leo.liu@amd.com>, Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 0/9] update devcoredump for new VCN instance design
Date: Tue, 29 Oct 2024 19:20:11 +0530
Message-Id: <20241029135020.2494491-1-sunil.khatri@amd.com>
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

Sunil Khatri (9):
  drm/amdgpu: update vcn_v1 devcoredump on per instance basis
  drm/amdgpu: update vcn_v2.0 devcoredump on per instance basis
  drm/amdgpu: update vcn_v2.5 devcoredump on per instance basis
  drm/amdgpu: update vcn_v3.0 devcoredump on per instance basis
  drm/amdgpu: update vcn_v4.0.3 devcoredump on per instance basis
  drm/amdgpu: update vcn_v4.0.5 devcoredump on per instance basis
  drm/amdgpu: update vcn_v4 devcoredump on per instance basis
  drm/amdgpu: update vcn_v5.0 devcoredump on per instance basis
  drm/amdgpu: remove unused ip_dump from vcn device

 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 -
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 77 ++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 77 ++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 77 ++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 75 +++++++++++------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 80 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 80 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 80 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 77 ++++++++++++------------
 10 files changed, 298 insertions(+), 330 deletions(-)

-- 
2.34.1

