Return-Path: <SRS0=LN+i=D3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA410C388F7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 20:26:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2810722247
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 20:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKJfLsXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2810722247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F409A6E0FC;
	Tue, 20 Oct 2020 20:26:30 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF49C6E0D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2020 20:26:29 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id t20so1577078qvv.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2020 13:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JtZVT4vD1OWfXZAIt4IoXzXfslaoFhj9AiGhkQ+mkVo=;
 b=NKJfLsXoXp3SXzTwLhDjuvH8Z2W8t56Dxqi0lHB58URNWRF14dNvFheWXusN4yL3fg
 Yq92nU1IVd0CCxggqGCTy9z0j1FSULINW0XArckibaoBca0BvyfLoDCkeS5RK5II/3py
 8fRdFklK9nZ5feK7zLZlAxajIeyFQosUcMO0ABc+nLJ6IttSqUIxGkyRJ/F9beEK8cl7
 VvmImbyiiTKnl/fWhXfNibpz74WXlJa8bSLMzgJ08MHCbPI82BwmZtDqT9vHmpHtB5Lq
 q8kzzHVJFt35OgZ1NDOomfL5gAK+1/EyJsiB2/bTe9h94g5NxBseRKMtzgVqid09m9pv
 XVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JtZVT4vD1OWfXZAIt4IoXzXfslaoFhj9AiGhkQ+mkVo=;
 b=dOXAAt/qhJDqCxhdbMH5YGwOPnNNEaxLWuFlHK/aR4VZIq0uAgXEm7DJN3adW9Q5KJ
 37ipGcHaoT795HC6WH5QHE5tgzobEvmNTVmCuZYZqe7imCyRwT/cQsxbmU1szBICtMt5
 xHQeIb7qIofXzdbFeY+TW/Ud7vm6WeoAa8R29sY7Ir9OVt9vza/+WuTMJO0NWK+ylkKX
 pkSaLBD4ILERbWbOrTpr3eX6HE0uyZiaNdCUe7h6cTxDAtwrP1kzWs5gptEQJXpQS+Pl
 9Gg/BWCiehrnhCi41njhrnbhyLA0qneelqms2qAXINkZV/0DPB2n+S9+/MECnreFRB+5
 yVQw==
X-Gm-Message-State: AOAM533jm4PRZxHmo3ZHs2SDG2aHag/yuXnji+bj7WvMVd60MqQUKdoj
 KsJWz2hNo4GUjnwNqhHCIdD5eN2RwJE=
X-Google-Smtp-Source: ABdhPJwrCZTGJXS0XNl9dIMHwQqNAbi69lhEZB+0vOMqikKOPXAI2Y5kwQbj/V29UQvyDNvEJ+hf9w==
X-Received: by 2002:ad4:4512:: with SMTP id k18mr5262956qvu.5.1603225588558;
 Tue, 20 Oct 2020 13:26:28 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id e39sm1366909qtk.32.2020.10.20.13.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 13:26:27 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: add support to configure MALL for
 sienna_cichlid (v2)
Date: Tue, 20 Oct 2020 16:26:16 -0400
Message-Id: <20201020202617.2465215-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201020202617.2465215-1-alexander.deucher@amd.com>
References: <20201020202617.2465215-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Enable Memory Access at Last Level (MALL) feature for sienna_cichlid.

v2: drop module option.  We need to add UAPI so userspace can
request MALL per buffer.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 3 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index ffea3b89b9da..929d7cb92dc0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -76,6 +76,9 @@ struct amdgpu_bo_list_entry;
 /* PTE is handled as PDE for VEGA10 (Translate Further) */
 #define AMDGPU_PTE_TF		(1ULL << 56)
 
+/* MALL noalloc for sienna_cichlid, reserved for older ASICs  */
+#define AMDGPU_PTE_NOALLOC	(1ULL << 58)
+
 /* PDE Block Fragment Size for VEGA10 */
 #define AMDGPU_PDE_BFS(a)	((uint64_t)a << 59)
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 40af17610207..ef385a529013 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -486,7 +486,8 @@ static void gmc_v10_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned vmid
 /*
  * PTE format on NAVI 10:
  * 63:59 reserved
- * 58:57 reserved
+ * 58 reserved and for sienna_cichlid is used for MALL noalloc
+ * 57 reserved
  * 56 F
  * 55 L
  * 54 reserved
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 18eca0d4dbcc..ae6158456094 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -707,7 +707,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 		temp &= 0xFF0FFF;
 		temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
 			 (CACHE_WRITE_POLICY_L2__DEFAULT << 14) |
-			 0x01000000);
+			 SDMA0_UTCL1_PAGE__LLC_NOALLOC_MASK);
 		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE), temp);
 
 		if (!amdgpu_sriov_vf(adev)) {
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
