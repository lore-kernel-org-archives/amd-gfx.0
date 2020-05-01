Return-Path: <SRS0=mrdw=6P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1753EC47253
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2020 16:37:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC69D20836
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2020 16:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFrFSU7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC69D20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C81D6ECE1;
	Fri,  1 May 2020 16:37:37 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F69D6ECD8
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 May 2020 16:37:36 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id s9so7062535qkm.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 May 2020 09:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AggaH6lajjrMpEeV4s3fHTOI4ZdkoD/8WuQfOmX+1BY=;
 b=AFrFSU7yxLVEBs3Bh5e6h5LmenWNIY2yH6izWil788FAr3sn05mO92c4oleLs+gxF+
 bLU2DIrkElvohWpqb7ggbwZ5K2qKiCQI+zQXpWPKXDPBSdSG0yAMVqmyTXnDu5j0aoTi
 1QAyRBjVttJIpw7pzm8mVUMttg6ml5Qpyx9W7B33IzTdr2cKCiWdSv0bEnuK8XuKeSz+
 EzcpHDEuQbaoF5fp44kdoMhkrToj92yXYXFMBYcatGYwLg3VQogg9SryPCPfRwhE4rVi
 je3+k6m74V6jcIT+JIFh3w8B0ftl3cICB7K/iJqJG5Z+TB9Tl2+ukxtkfov5jDNW+wko
 wohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AggaH6lajjrMpEeV4s3fHTOI4ZdkoD/8WuQfOmX+1BY=;
 b=e4ppekiajtM9zOVMGC2u5mlIBVmNfUx0DJGIeKsiH51rEi7FITGT2TL7XrBYIyOqWY
 bisyhXkv8UXitf5GIwASCSpPpH4SiKOTVD/cJKHI4cW6yX4s5FXwTP8qplebN2TtENUx
 eDi6tYyGy0ZocR/VtmQtvJX9l4x0YKRyNXBVgpDJCPicA0qUry3ee9+Vt7y3N4cG0QhD
 K0Hsr+UxboYtsMqLhGu1Qpcg1NLSSiwWarRpvNyGZ4MMlFlesAveUco2NWSmCE0ZaXDc
 3iG8nGOAqN2AkVMyyHcG10TkfJcM0N9ayp5ukczhRAVhs7NINAmjDi31bA5qQv4hWMkJ
 SDzg==
X-Gm-Message-State: AGi0PuarBGuDhg9E17ZqeobPB5QiG6lc19JROXx3h+EeQ9ri4J9n7fyt
 B9zg3WXEIWbzWnzAAmn5XCowxMXE
X-Google-Smtp-Source: APiQypK/ICIHqtN1iWqCt6/FsB7JoVr4v7YT/kS7vZkIB68qFzGgRfQ40pRrE0uHDubVFF8KdLJafw==
X-Received: by 2002:a37:4b0c:: with SMTP id y12mr4276250qka.43.1588351054875; 
 Fri, 01 May 2020 09:37:34 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id q17sm3000068qtk.84.2020.05.01.09.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 09:37:34 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix emit frame counts for compute mem sync
Date: Fri,  1 May 2020 12:37:26 -0400
Message-Id: <20200501163726.871246-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The frame emit counts were not updated.

Fixes: 0dd3baafb62c38 ("drm/amdgpu: apply AMDGPU_IB_FLAG_EMIT_MEM_SYNC to compute IBs too")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c  | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c  | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c  | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 3 ++-
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 7ff7e516b72f..ddb485e1e963 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8125,7 +8125,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		2 + /* gfx_v10_0_ring_emit_vm_flush */
-		8 + 8 + 8, /* gfx_v10_0_ring_emit_fence x3 for user fence, vm fence */
+		8 + 8 + 8 + /* gfx_v10_0_ring_emit_fence x3 for user fence, vm fence */
+		8, /* gfx_v10_0_emit_mem_sync */
 	.emit_ib_size =	7, /* gfx_v10_0_ring_emit_ib_compute */
 	.emit_ib = gfx_v10_0_ring_emit_ib_compute,
 	.emit_fence = gfx_v10_0_ring_emit_fence,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 05e94379c7b3..79c52c7a02e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3533,7 +3533,8 @@ static const struct amdgpu_ring_funcs gfx_v6_0_ring_funcs_compute = {
 		5 + 5 + /* hdp flush / invalidate */
 		7 + /* gfx_v6_0_ring_emit_pipeline_sync */
 		SI_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + /* gfx_v6_0_ring_emit_vm_flush */
-		14 + 14 + 14, /* gfx_v6_0_ring_emit_fence x3 for user fence, vm fence */
+		14 + 14 + 14 + /* gfx_v6_0_ring_emit_fence x3 for user fence, vm fence */
+		5, /* SURFACE_SYNC */
 	.emit_ib_size = 6, /* gfx_v6_0_ring_emit_ib */
 	.emit_ib = gfx_v6_0_ring_emit_ib,
 	.emit_fence = gfx_v6_0_ring_emit_fence,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 5d9226b871fa..0cc011f9190d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -5089,7 +5089,8 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_compute = {
 		5 + /* hdp invalidate */
 		7 + /* gfx_v7_0_ring_emit_pipeline_sync */
 		CIK_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + /* gfx_v7_0_ring_emit_vm_flush */
-		7 + 7 + 7, /* gfx_v7_0_ring_emit_fence_compute x3 for user fence, vm fence */
+		7 + 7 + 7 + /* gfx_v7_0_ring_emit_fence_compute x3 for user fence, vm fence */
+		7, /* gfx_v7_0_emit_mem_sync_compute */
 	.emit_ib_size =	7, /* gfx_v7_0_ring_emit_ib_compute */
 	.emit_ib = gfx_v7_0_ring_emit_ib_compute,
 	.emit_fence = gfx_v7_0_ring_emit_fence_compute,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 14790f80a8a9..1d4128227ffd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6927,7 +6927,8 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
 		5 + /* hdp_invalidate */
 		7 + /* gfx_v8_0_ring_emit_pipeline_sync */
 		VI_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + /* gfx_v8_0_ring_emit_vm_flush */
-		7 + 7 + 7, /* gfx_v8_0_ring_emit_fence_compute x3 for user fence, vm fence */
+		7 + 7 + 7 + /* gfx_v8_0_ring_emit_fence_compute x3 for user fence, vm fence */
+		7, /* gfx_v8_0_emit_mem_sync_compute */
 	.emit_ib_size =	7, /* gfx_v8_0_ring_emit_ib_compute */
 	.emit_ib = gfx_v8_0_ring_emit_ib_compute,
 	.emit_fence = gfx_v8_0_ring_emit_fence_compute,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index a4e95e03d97c..b98d91936b4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -6745,7 +6745,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		2 + /* gfx_v9_0_ring_emit_vm_flush */
-		8 + 8 + 8, /* gfx_v9_0_ring_emit_fence x3 for user fence, vm fence */
+		8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user fence, vm fence */
+		7, /* gfx_v9_0_emit_mem_sync */
 	.emit_ib_size =	7, /* gfx_v9_0_ring_emit_ib_compute */
 	.emit_ib = gfx_v9_0_ring_emit_ib_compute,
 	.emit_fence = gfx_v9_0_ring_emit_fence,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
