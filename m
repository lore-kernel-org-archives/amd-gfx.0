Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35AAC47DAC
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 09:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A32DA10E8A9;
	Thu, 11 Jan 2024 09:04:30 +0000 (UTC)
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
 by gabe.freedesktop.org (Postfix) with ESMTP id 7190E10E028;
 Thu, 11 Jan 2024 02:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=SALJLRmBOXzxBM8mcf
 sgEpWIGewiMx1rbO76aYGKWys=; b=IqhOuiAf9hGx6agbB6/LPBHc2iIGlyGfD9
 edcTWvkWsZI2jtKzWjJbu5asdpmnqV4Xw5hz/vjTwD0jCig6j0YIxl15oT0uteXT
 q7rGeqUW9EuQ0ZtAWD4FgYE9NlqgRYEU4H3iKDbO5O71Ls9g7MNsneqOB4WBRb/f
 0S9ArffuY=
Received: from localhost.localdomain (unknown [182.148.14.173])
 by gzga-smtp-mta-g1-5 (Coremail) with SMTP id _____wD3f1IHUp9lQUUtAA--.20942S2;
 Thu, 11 Jan 2024 10:27:20 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: christian.koenig@amd.com, Xinhui.Pan@amd.com, alexander.deucher@amd.com,
 airlied@gmail.com, daniel@ffwll.ch
Subject: [PATCH] drm/amdgpu: Clean up errors in amdgpu.h
Date: Thu, 11 Jan 2024 02:27:18 +0000
Message-Id: <20240111022718.6415-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wD3f1IHUp9lQUUtAA--.20942S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1DCF48KF1fuF4rZr15CFg_yoWkXFb_CF
 WUAF98Wr43GFnYqr13uw4fZ3yqvr1YvF1kWw1agF9ayr9rZrW5ArWDCryxXw4fua1xWF1D
 u39Ygr15C3ZakjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRt8nDUUUUU==
X-Originating-IP: [182.148.14.173]
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiHA5ixWV2zz6dAAAAsK
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
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, chenxuebing <chenxb_99091@126.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 616b6c911767..189bf62076f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -114,14 +114,12 @@
 
 #define MAX_GPU_INSTANCE		64
 
-struct amdgpu_gpu_instance
-{
+struct amdgpu_gpu_instance {
 	struct amdgpu_device		*adev;
 	int				mgpu_fan_enabled;
 };
 
-struct amdgpu_mgpu_info
-{
+struct amdgpu_mgpu_info {
 	struct amdgpu_gpu_instance	gpu_ins[MAX_GPU_INSTANCE];
 	struct mutex			mutex;
 	uint32_t			num_gpu;
@@ -140,8 +138,7 @@ enum amdgpu_ss {
 	AMDGPU_SS_DRV_UNLOAD
 };
 
-struct amdgpu_watchdog_timer
-{
+struct amdgpu_watchdog_timer {
 	bool timeout_fatal_disable;
 	uint32_t period; /* maxCycles = (1 << period), the number of cycles before a timeout */
 };
-- 
2.17.1

