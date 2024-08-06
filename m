Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F770C52D71
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 08:18:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D44310E30A;
	Tue,  6 Aug 2024 08:18:38 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A241410E317
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 08:18:36 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 4768IVTR2422830; Tue, 6 Aug 2024 13:48:31 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 4768IUWB2422829;
 Tue, 6 Aug 2024 13:48:30 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 00/15] VCN IP DUMP support for remaining IP's
Date: Tue,  6 Aug 2024 13:48:10 +0530
Message-Id: <20240806081825.2422771-1-sunil.khatri@amd.com>
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

VCN IP dump support for
a. 1.0
b. 2.0
c. 2.5
d. 2.6
e. 4.0
f. 4.0.3
g. 4.0.5
h. 5.0

Testing is done on VCN 3.x 4.x 5.x only as older version of VCN targets
are not available but it should work as the methodology to read and dump
value in devcoredump remains same. All the registers are validated
against the IP and from windows program as much as possible.


Sunil Khatri (15):
  drm/amdgpu: add vcn_v5_0 ip dump support
  drm/amdgpu: add print support for vcn_v5_0 ip dump
  drm/amdgpu: add vcn_v4_0 ip dump support
  drm/amdgpu: add print support for vcn_v4_0 ip dump
  drm/amdgpu: add vcn_v4_0_3 ip dump support
  drm/amdgpu: add print support for vcn_v4_0_3 ip dump
  drm/amdgpu: add vcn_v4_0_5 ip dump support
  drm/amdgpu: add print support for vcn_v4_0_5 ip dump
  drm/amdgpu: add vcn_v1_0 ip dump support
  drm/amdgpu: add print support for vcn_v1_0 ip dump
  drm/amdgpu: add vcn_v2_0 ip dump support
  drm/amdgpu: add print support for vcn_v2_0 ip dump
  drm/amdgpu: add vcn_v2_5 ip dump support
  drm/amdgpu: add print support for vcn_v2_5 ip dump
  drm/amdgpu: add vcn ip dump support for vcn_v2_6

 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 129 ++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 145 ++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 148 ++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 203 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 204 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 203 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 204 +++++++++++++++++++++++-
 7 files changed, 1220 insertions(+), 16 deletions(-)

-- 
2.34.1

