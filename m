Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C5FE77180
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2024 14:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C7C910E691;
	Mon, 16 Dec 2024 14:04:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.b="Q8X3uZbR";
	dkim-atps=neutral
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68E2010E5C8;
 Mon, 16 Dec 2024 11:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
 s=mail; t=1734348890;
 bh=JrDLH7p18msOukR2ZaEDeYMa++p2Hc53UfMP6H+bFkY=;
 h=From:Subject:Date:To:Cc:From;
 b=Q8X3uZbRg9FYXju4K4AV8wuHPp1Z5kkc+5QRYWmkiU6dDjuLFcyxH3J5phdv4cEQi
 poL+yaMJ/CxlEBDJnXlmaHuGfS5xmL8dq31N/GpSrH8tOIkkQgnZQb5r8ULpK83MZP
 Ovpz2ObDaOltbl6o0mLPn0CiRt4BxpFTbh1a1UP0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/5] drm: Constify 'struct bin_attribute'
Date: Mon, 16 Dec 2024 12:34:46 +0100
Message-Id: <20241216-sysfs-const-bin_attr-drm-v1-0-210f2b36b9bf@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFYQYGcC/x3MQQqDMBBA0avIrB1Iglbbq4hINJN2Fo1lJogi3
 t3Q5Vv8f4KSMCm8qhOENlZeU4GtK1g+Pr0JORSDM66xzraoh0bFZU2aceY0+ZwFg3zxOceuMyb
 4vn9AyX9Ckff/ehiv6wbk5oKRagAAAA==
X-Change-ID: 20241215-sysfs-const-bin_attr-drm-9bf7700da886
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Qiang Yu <yuq825@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 lima@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734348889; l=1344;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=JrDLH7p18msOukR2ZaEDeYMa++p2Hc53UfMP6H+bFkY=;
 b=Xj9EbjZgGe/b+nVilZvAUNOPjobV5Pr3zvNLYMijU+Cqt7GNooFVhGe8zr7suSEuHgTAadNxv
 EqLRPoJWl7iAGW/qiD88SXGLPYXJObEWP0Ve31yZ+iBZIN5+6wrMarN
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Mailman-Approved-At: Mon, 16 Dec 2024 14:04:38 +0000
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

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (5):
      drm/sysfs: Constify 'struct bin_attribute'
      drm/lima: Constify 'struct bin_attribute'
      drm/i915: Constify 'struct bin_attribute'
      drm/amdgpu: Constify 'struct bin_attribute'
      drm/amd/display: Constify 'struct bin_attribute'

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c             |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                | 14 +++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                | 13 ++++++-------
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |  8 ++++----
 drivers/gpu/drm/drm_sysfs.c                            | 10 +++++-----
 drivers/gpu/drm/i915/i915_gpu_error.c                  |  8 ++++----
 drivers/gpu/drm/i915/i915_sysfs.c                      | 12 ++++++------
 drivers/gpu/drm/lima/lima_drv.c                        |  8 ++++----
 8 files changed, 39 insertions(+), 40 deletions(-)
---
base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
change-id: 20241215-sysfs-const-bin_attr-drm-9bf7700da886

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

