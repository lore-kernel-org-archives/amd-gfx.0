Return-Path: <SRS0=bavc=6T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE41C47247
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 16:42:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4741C20746
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 16:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYRxOO1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4741C20746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 699136E804;
	Tue,  5 May 2020 16:42:28 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 172956E406
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2020 16:42:27 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id ck5so1314325qvb.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 May 2020 09:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1z32twyJTUhqPFg28PhJk5LiGew6M3IUTdAplLuxYG8=;
 b=rYRxOO1oJDnzl6xFOE+UlF6Na3RywUo7XaCD+G8l/OC7/yOh7k+CXrEBlYqV+52hy7
 NIkLVmHn3yXbpQv0NT/GNmXAxnFGxythaRlMVU54QNwT8kssDKRut0NcnZxKnf9X73Dp
 4w+8D1pwm51JCMmyzwtHKVOrr3S8PpnGsm7Dc1yE1987yHEZNncaci/i7Y+4tGV3Vakv
 hmODEc0X0IsB5WEtgcHPo0N2KTAMUcHQflEdTrgPuiAahH4soaCioC9okSTWt9mKAxZb
 lb1N2Uc1RunDniXtYp9d7PrMcwpziTL6na+XznrNzRxH8IW2IdS9uVVd1wiDtOnMuPWU
 Jfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1z32twyJTUhqPFg28PhJk5LiGew6M3IUTdAplLuxYG8=;
 b=IAZ3HQ0nwfUpe6nQxMYfa1zxi7HCwXKb2Mi+Ivumy7MjALoSsp5coUbSRDHxJtg3Vk
 /1MRVGI/ZSBkBVRKWnAeLkTcsxrzcxKjxXZRP6ByOpaBdQ4Swbjbemht7AuswA97D7jk
 dwQX+YPxd3MylzNzP7GbHwLtEHyFxhuvrIehp7calIPMQIp+TbJTFnCHSPXq9TONrJbm
 esf6a1hKyTkBT5Qi9Xl3wz790OJBiBcvZXcPJ5AyMP76cp32s0cbqFP14sL6N+3UK23H
 mIz0v7wX3GuwCXx/9bSaY9EpOpY/Ft8+d/K5ECZMQdCrHt/byr3aOsxP33CHq9C1lVKC
 eP2w==
X-Gm-Message-State: AGi0PuZECgr6rHrcMFRACeTB5YNUa2TxPLHypqe3poYzdAQMNL79Ldoc
 15GZRiEJQ19xgniej5nM2Xcot/CJ
X-Google-Smtp-Source: APiQypIVEWikffJvz/65FESvuXZVd/4Sny6TA/B148CZQJKJlfRJa8txka2b/zyKLPrRwNe2WFaFbg==
X-Received: by 2002:ad4:55a5:: with SMTP id f5mr3528529qvx.133.1588696945418; 
 Tue, 05 May 2020 09:42:25 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id u35sm2046055qtd.88.2020.05.05.09.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 09:42:24 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: implement soft_recovery for gfx10
Date: Tue,  5 May 2020 12:42:16 -0400
Message-Id: <20200505164216.138189-1-alexander.deucher@amd.com>
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

Same as gfx9.  This allows us to kill the waves for hung
shaders.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index ddb485e1e963..27c63a8f698c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7690,6 +7690,19 @@ static void gfx_v10_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 							   ref, mask);
 }
 
+static void gfx_v10_0_ring_soft_recovery(struct amdgpu_ring *ring,
+					 unsigned vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t value = 0;
+
+	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
+	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
+	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
+	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
+	WREG32_SOC15(GC, 0, mmSQ_CMD, value);
+}
+
 static void
 gfx_v10_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 				      uint32_t me, uint32_t pipe,
@@ -8105,6 +8118,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
+	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 };
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
