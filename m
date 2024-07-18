Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8FCC3DA63
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 04:43:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEDE310E4FB;
	Thu, 18 Jul 2024 04:43:07 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFFE310E503
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 04:42:59 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 46I4gsap1822095; Thu, 18 Jul 2024 10:12:54 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 46I4grnu1822088;
 Thu, 18 Jul 2024 10:12:53 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 0/6] ip dump for sdma v4 v4_4_2 and v7
Date: Thu, 18 Jul 2024 10:12:44 +0530
Message-Id: <20240718044250.1822051-1-sunil.khatri@amd.com>
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
  drm/amdgpu: Add sdma_v7_0 ip dump for devcoredump
  drm/amdgpu: add print support for sdma_v_7_0 ip_dump
  drm/amdgpu: Add sdma_v4_0 ip dump for devcoredump
  drm/amdgpu: add print support for sdma_v_4_0 ip_dump
  drm/amdgpu: Add sdma_v4_4_2 ip dump for devcoredump
  drm/amdgpu: add print support for sdma_v_4_4_2 ip_dump

 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 102 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 102 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 113 +++++++++++++++++++++++
 3 files changed, 317 insertions(+)

-- 
2.34.1

