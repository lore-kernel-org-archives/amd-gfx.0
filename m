Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5493C43217
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 23:30:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CCB610E8E5;
	Mon, 13 Dec 2021 23:30:39 +0000 (UTC)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B43E10E8E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 23:30:38 +0000 (UTC)
Received: from localhost.localdomain (unknown [88.120.44.86])
 by smtp5-g21.free.fr (Postfix) with ESMTP id 73C065FF67;
 Tue, 14 Dec 2021 00:30:36 +0100 (CET)
From: Yann Dirson <ydirson@free.fr>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 0/4] Enrich amdgpu docs from recent threads
Date: Tue, 14 Dec 2021 00:30:26 +0100
Message-Id: <20211213233030.6719-1-ydirson@free.fr>
X-Mailer: git-send-email 2.31.1
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Yann Dirson <ydirson@free.fr>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, linux-doc@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This series is basically bringing Alex' descriptions of the hardware and
driver internals into the doc.

Changes in v3:
* camel case in titles (Rodrigo Siqueira)
* link DCN description to DC doc (Rodrigo Siqueira)
* links to email archive in commit messages (Rodrigo Siqueira)
* acronym expansion in intro (Rodrigo Siqueira)
* new commits for kerneldoc content fixes

Changes in v2:
* fix typos (Harry Wentland)
* get rid of double headings

Yann Dirson (4):
  Documentation/gpu: include description of AMDGPU hardware structure
  Documentation/gpu: include description of some of the GC
    microcontrollers
  amdgpu: fix some kernel-doc markup
  amdgpu: fix some comment typos

 Documentation/gpu/amdgpu/display/index.rst    |   2 +
 Documentation/gpu/amdgpu/driver-core.rst      | 117 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   4 +-
 include/uapi/drm/amdgpu_drm.h                 |   2 +-
 8 files changed, 128 insertions(+), 9 deletions(-)

-- 
2.31.1

