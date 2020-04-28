Return-Path: <SRS0=QpD2=6M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116DCC83000
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 16:00:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E2A20575
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 16:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOQ6m7xu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E2A20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D0F86E82D;
	Tue, 28 Apr 2020 16:00:05 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 961336E822
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2020 16:00:03 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id 59so8513595qva.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2020 09:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Bj6/AZ+/zhim3Wxoy8E/CzwrvSUjZFB4pcSVmdxkxEA=;
 b=GOQ6m7xucFS5irpP9/QmSfP/v4PbeMB3ndpNrZYo2a+2nJuDrrlE3pOlVSx/tCHHrv
 uYVt/d+N5kGHgvIC6ScAugBEdWixNlwiTfQM+AHy+67V5r6a3caIzZtO8ZSu4RLcRFzp
 eVY36VRfu9+sC0b0bJ/iWF288joPIKV5pGIQu536/B9Ivo2IkejaDgihBdVeyM4B6bWj
 eGOfbi3Gws8Ju+hmK7rMN+ICI47ekBmbKhiXlT0Rf9axk1Wb3BLVdFkEGdElbV5qmFeY
 CGNXX0q4jjCYmBNLZknYbNHiCSSHm3g0xR0IF7dQO6gy4f5C6CkMEZn3cxl3it7h6K15
 FoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Bj6/AZ+/zhim3Wxoy8E/CzwrvSUjZFB4pcSVmdxkxEA=;
 b=OMGGtGVezo+zt/ccvhIjwHNvBqmxf+svGBIWYeOiusy4e5pFVJHr1b0wrYb0ybKYC5
 fZ8M+N0GdvJ+emaKCTPjyEZCQOm1V1T/PRfkEI2jrWEoIpOUuxHSkRFWpcwqjYAUyOsS
 0Wr0gydA5uQ4jxm4aOmuCkB5Om/Uf7MgdumL/T+aFeOK6Ui5Vi1oXnry65v2u7yWSGTt
 /8gshpuJas9rrxNwodptNrE8uRmpBp0qxRzrkswv2BG9fv0BcSq6Sa0S0Obn0eY3+c0L
 Nvf3juGF+IeUAZeyQUDgGPgl++AN1BZGyqY35kYfLQ35s0d5MyZCBNzV8DEmiga6ahXF
 obqw==
X-Gm-Message-State: AGi0PuYYcAYqpfGbhFHn5RArdYsPxhTo1Z21I+jnYk+sgXnOAJo4ma42
 3McI6oiTYmAOtm1YI2I4w/xoxc43
X-Google-Smtp-Source: APiQypIipjM4DukVZefVMUjvXwSRb68+ulaNgvJGmAIFhsuP/bHWufK+9NtxR9M2mJ648UvQpgk+nA==
X-Received: by 2002:a0c:a98f:: with SMTP id a15mr28813979qvb.105.1588089602327; 
 Tue, 28 Apr 2020 09:00:02 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id i4sm8981633qkh.66.2020.04.28.09.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 09:00:01 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: align driver version with upstream
Date: Tue, 28 Apr 2020 11:59:52 -0400
Message-Id: <20200428155952.545150-1-alexander.deucher@amd.com>
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

We may not upstream the MEM_SYNC interface, so move that
after the SDMA L2 fix.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 76a6198f5b6e..89c4e9dde6b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -85,12 +85,11 @@
  * - 3.34.0 - Non-DC can flip correctly between buffers with different pitches
  * - 3.35.0 - Add drm_amdgpu_info_device::tcc_disabled_mask
  * - 3.36.0 - Allow reading more status registers on si/cik
- * - 3.37.0 - Add AMDGPU_IB_FLAG_EMIT_MEM_SYNC
- * - 3.38.0 - L2 is invalidated before SDMA IBs, needed for correctness
- * - 3.39.0 - AMDGPU_IB_FLAG_EMIT_MEM_SYNC also affects compute IBs
+ * - 3.37.0 - L2 is invalidated before SDMA IBs, needed for correctness
+ * - 3.38.0 - Add AMDGPU_IB_FLAG_EMIT_MEM_SYNC
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	39
+#define KMS_DRIVER_MINOR	38
 #define KMS_DRIVER_PATCHLEVEL	0
 
 int amdgpu_vram_limit = 0;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
