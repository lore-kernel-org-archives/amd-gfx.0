Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9672AD7879D
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 17:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40B2110E9F5;
	Thu, 21 Nov 2024 17:23:08 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F3F110E9FC
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 17:23:03 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 4ALHMvOa2677511; Thu, 21 Nov 2024 22:52:57 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 4ALHMvG02677510;
 Thu, 21 Nov 2024 22:52:57 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 0/8] Fix comments warnings for vcn clock/power gating
Date: Thu, 21 Nov 2024 22:52:42 +0530
Message-Id: <20241121172250.2677489-1-sunil.khatri@amd.com>
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

Sunil Khatri (8):
  drm/amdgpu: Fix comment for vcn_v4_0_set_clockgating_state
  drm/amdgpu: Fix comment for vcn_v5_0_0_set_clockgating_state
  drm/amdgpu: Fix comment for vcn_v4_0_3_set_powergating_state
  drm/amdgpu: Fix comment for vcn_v4_0_5_set_clockgating_state
  drm/amdgpu: Fix comment for vcn_v4_0_5_set_powergating_state
  drm/amdgpu: Fix comment for vcn_v5_0_0_set_powergating_state
  drm/amdgpu: Fix comment for vcn_v4_0_set_powergating_state
  drm/amdgpu: Fix comment for vcn_v4_0_3_set_clockgating_state

 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.34.1

