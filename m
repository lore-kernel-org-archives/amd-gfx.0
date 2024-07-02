Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE28C30658
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jul 2024 08:26:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F4C610E567;
	Tue,  2 Jul 2024 08:26:25 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A81D410E572
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jul 2024 08:26:23 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 4628QDuk3062661; Tue, 2 Jul 2024 13:56:13 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 4628QDa63062660;
 Tue, 2 Jul 2024 13:56:13 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 2/2] drm/amdgpu: fix out of bounds access in gfx11 during
 ip dump
Date: Tue,  2 Jul 2024 13:56:05 +0530
Message-Id: <20240702082605.3062592-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702082605.3062592-1-sunil.khatri@amd.com>
References: <20240702082605.3062592-1-sunil.khatri@amd.com>
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

During ip dump in gfx11 the index variable is reused but is
not reinitialized to 0 and this causes the index calculation
to be wrong and access out of bound access.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0d078d0db162..b49e4e85bddf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6401,6 +6401,7 @@ static void gfx_v11_ip_print(void *handle, struct drm_printer *p)
 	if (!adev->gfx.ip_dump_gfx_queues)
 		return;
 
+	index = 0;
 	reg_count = ARRAY_SIZE(gc_gfx_queue_reg_list_11);
 	drm_printf(p, "\nnum_me: %d num_pipe: %d num_queue: %d\n",
 		   adev->gfx.me.num_me,
@@ -6465,6 +6466,7 @@ static void gfx_v11_ip_dump(void *handle)
 	if (!adev->gfx.ip_dump_gfx_queues)
 		return;
 
+	index = 0;
 	reg_count = ARRAY_SIZE(gc_gfx_queue_reg_list_11);
 	amdgpu_gfx_off_ctrl(adev, false);
 	mutex_lock(&adev->srbm_mutex);
-- 
2.34.1

