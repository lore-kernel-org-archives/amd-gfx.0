Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63782C52D7C
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Aug 2024 11:30:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 919B610E03A;
	Tue, 13 Aug 2024 11:30:48 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6269A10E309
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Aug 2024 11:30:47 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 47DBUalI768848; Tue, 13 Aug 2024 17:00:36 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 47DBUaNl768847;
 Tue, 13 Aug 2024 17:00:36 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, 
 Leo Liu <leo.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 00/18] VCN patches with updated register list
Date: Tue, 13 Aug 2024 17:00:16 +0530
Message-Id: <20240813113034.768804-1-sunil.khatri@amd.com>
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

Sunil Khatri (18):
  drm/amdgpu: add vcn ip dump ptr in vcn global struct
  drm/amdgpu: add vcn_v3_0 ip dump support
  drm/amdgpu: add print support for vcn_v3_0 ip dump
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

 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |   3 +
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 112 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 113 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 118 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 113 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 114 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 115 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 113 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 110 +++++++++++++++++++++-
 9 files changed, 893 insertions(+), 18 deletions(-)

-- 
2.34.1

