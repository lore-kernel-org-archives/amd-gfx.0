Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942F8CEF173
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 13:35:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 454EA10E148;
	Tue,  8 Oct 2024 13:35:04 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A58A10E535
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 13:35:02 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 498DYw1N710103; Tue, 8 Oct 2024 19:04:58 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 498DYwTU710102;
 Tue, 8 Oct 2024 19:04:58 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v2 0/6] optimize insert nop operation on cpu side
Date: Tue,  8 Oct 2024 19:04:50 +0530
Message-Id: <20241008133456.710083-1-sunil.khatri@amd.com>
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

Sunil Khatri (6):
  drm/amdgpu: optimize insert_nop using multi dwords
  drm/amdgpu: optimize fn gfx_v9_4_3_ring_insert_nop
  drm/amdgpu: optimize fn gfx_v9_ring_insert_nop
  drm/amdgpu: optimize fn gfx_v10_ring_insert_nop
  drm/amdgpu: optimize fn gfx_v11_ring_insert_nop
  drm/amdgpu: optimize fn gfx_v12_ring_insert_nop

 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 22 +++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  5 +----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  5 +----
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   |  5 +----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  5 +----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  5 +----
 6 files changed, 24 insertions(+), 23 deletions(-)

-- 
2.34.1

