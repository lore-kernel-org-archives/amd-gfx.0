Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4DCC47DAF
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 09:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 869EE10E8A7;
	Thu, 11 Jan 2024 09:04:30 +0000 (UTC)
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
 by gabe.freedesktop.org (Postfix) with ESMTP id 09CA510E070;
 Thu, 11 Jan 2024 03:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=X7/hcIuRpwjcQd9lz0
 bnRT1q5+i9Qj9IDqkJ2j/QrPY=; b=Z2PZsadU1dI6DoCqXI2h/DRaptgIrAPtm9
 Q4txrSrI/PcIGLF/Dd0A8nrUG5cauJqcFrbFVuRmEHs9DGMBG/phCqmO6o+wNkXy
 GyAhNYAku9ah0QpMuLcqv1A1UOPcF3DJBnXeD1PRl7D5InITK3E5CpXERelxuyy+
 lt0F8Deis=
Received: from localhost.localdomain (unknown [182.148.14.173])
 by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wD33wLmWZ9lnk+dAA--.4894S2; 
 Thu, 11 Jan 2024 11:00:54 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: Xinhui.Pan@amd.com, airlied@gmail.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, daniel@ffwll.ch
Subject: [PATCH] drm/amdgpu: Clean up errors in navi12_ip_offset.h
Date: Thu, 11 Jan 2024 03:00:53 +0000
Message-Id: <20240111030053.6868-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wD33wLmWZ9lnk+dAA--.4894S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1DCF48Kr4kWryDJw47urg_yoW3KFX_Ca
 4xJ3s3WrWxWFn2qFsFkFWxZ34jka18uFn3Xw4rtFy5trsrAr18W3y5Gr47XrWruFnIgFZr
 Za1kWFy5XrnIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRR_OzPUUUUU==
X-Originating-IP: [182.148.14.173]
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiWQ5ixWVLYT6tKAABsF
X-Mailman-Approved-At: Thu, 11 Jan 2024 09:04:25 +0000
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
Cc: chenxuebing <chenxb_99091@126.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/include/navi12_ip_offset.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/navi12_ip_offset.h b/drivers/gpu/drm/amd/include/navi12_ip_offset.h
index d8fc00478b6a..e94d80ec8d92 100644
--- a/drivers/gpu/drm/amd/include/navi12_ip_offset.h
+++ b/drivers/gpu/drm/amd/include/navi12_ip_offset.h
@@ -25,13 +25,11 @@
 #define MAX_SEGMENT                                        5
 
 
-struct IP_BASE_INSTANCE
-{
+struct IP_BASE_INSTANCE {
     unsigned int segment[MAX_SEGMENT];
 };
 
-struct IP_BASE
-{
+struct IP_BASE {
     struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
 } __maybe_unused;
 
-- 
2.17.1

