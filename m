Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6F0C433E2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62EFB2077D
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNcJfz5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62EFB2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28C686E2C7;
	Mon,  1 Jun 2020 18:04:26 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF5E46E2BE
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:24 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id w1so9956532qkw.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vhKoWP1JNFVyRsJmcqa5558wX8J9r5vi8sgRxuj9JeQ=;
 b=LNcJfz5O6LlrEiZP7sTGsGf7ANo8lP9gYU/onPUGK++NSXmzMSNQy8gYZ/hzpU+yU5
 9pL1ovwSCldyU+s6SR93dU9Fh/VYJ/TSg7PgxtqadnCJZJnlcR4iwNL7YfwWG5YnzGOw
 fwB+1Gz3jqDlyt109KtFb/+XGxNw9EHone4eyf0e6OpRI3nvrbY+1TRyApRr7FJ0kKBW
 RgRzhD6saWHMKxkD3GGKvNKvRQJss36yeGBoxqsQDWnJQ7Yztw7aU4fod3RFS59ZQhDb
 iLDvhC3k0ggHCjPOgxhmPUfcuUHyaHQZo8EBwEWEdxpYJaPS8kpR+FK3OyBq0qXleyEM
 J2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vhKoWP1JNFVyRsJmcqa5558wX8J9r5vi8sgRxuj9JeQ=;
 b=qyIntzExkbTxU87FVHXJXagLMxP0XX5EcluKEXcKkz4CKF21TPZQ6tKywb06JtXeq0
 frITWIDccIDF59Q/C9go/D6+vqRayc9mXcUU8kXomJ58QU4p1v3+Wsbh1ufGoqq7nFRI
 IKL5N5iW5lx6W4wLQKsmG2ySnVN1TUo7gX07YvNM1D4RO3Q94N0+C4/fgaOFQYQ6MgRk
 nv7+ppkNHePvfSZl5fykYMo/JSRZWaFub5DMTxLl37yNdQUDRQaHFxninILu8c7kK5Ha
 emi+WhCFBeGHFf5nT3cRLiPajcsCMAMtSODzJWbuFGS44reN/QsZ2m+UPdK/ixk+rUsi
 dmwQ==
X-Gm-Message-State: AOAM530R/sNBOajoB9g2j8s4aeywiNXJYV2/eJH4av59hcsiLucxpfJ7
 vsuOUMkCocG7vsNdhvyT41o4h1i5
X-Google-Smtp-Source: ABdhPJzCJKa6SrOtz3NfXRsOSTQ39WjPSJ8jcTOiQBfd8n1fh21hx6kCNuTJU9qSKA4BSAiljkbltw==
X-Received: by 2002:a37:9f09:: with SMTP id i9mr21346832qke.60.1591034663939; 
 Mon, 01 Jun 2020 11:04:23 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:23 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 068/207] drm/amdgpu/mes10.1: add the helper function for mes
 command submission
Date: Mon,  1 Jun 2020 14:00:20 -0400
Message-Id: <20200601180239.1267430-65-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

The helper function is used to submit mes command and poll waiting
for the command completion.

v2: replaced with amdgpu_fence_wait_polling to wait.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index da89b6a6507c..3ce77839468d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -78,6 +78,36 @@ static const struct amdgpu_ring_funcs mes_v10_1_ring_funcs = {
 	.insert_nop = amdgpu_ring_insert_nop,
 };
 
+static int mes_v10_1_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
+						    void *pkt, int size)
+{
+	int ndw = size / 4;
+	signed long r;
+	union MESAPI__ADD_QUEUE *x_pkt = pkt;
+	struct amdgpu_device *adev = mes->adev;
+	struct amdgpu_ring *ring = &mes->ring;
+
+	BUG_ON(size % 4 != 0);
+
+	if (amdgpu_ring_alloc(ring, ndw))
+		return -ENOMEM;
+
+	amdgpu_ring_write_multiple(ring, pkt, ndw);
+	amdgpu_ring_commit(ring);
+
+	DRM_DEBUG("MES msg=%d was emitted\n", x_pkt->header.opcode);
+
+	r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
+				      adev->usec_timeout);
+	if (r < 1) {
+		DRM_ERROR("MES failed to response msg=%d\n",
+			  x_pkt->header.opcode);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static int mes_v10_1_add_hw_queue(struct amdgpu_mes *mes,
 				  struct mes_add_queue_input *input)
 {
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
