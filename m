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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398D2C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132082077D
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Puy7PG1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132082077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B402C6E2BC;
	Mon,  1 Jun 2020 18:04:21 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B4EB6E2B8
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:20 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id y1so8403530qtv.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8pn61z/AZlCbW46Gle17K3TRBW4SV6Pv5/9zQKRYFNA=;
 b=Puy7PG1Ydf2rcr8zoYg7S3H4/Kac9Si9BKsSAgw4sUCENtyejDEN5hdJ2wROvEM+Uu
 WLFOg6FiP80SIqXGLLk3h3wzQD25/413NJn90f9F7q9IDlzFEqcI0ssc4tgOJmfEn6vj
 Rtfm5l14zZ/QtPOZeV5s0qqXmSownreJb+WId8Erl59rgw/zgLNgd9HF12saUkRRhfpu
 lwfesBl3vvpsuD8pm12h6O2IahYMw+c5qIpjSvStDXJp6cykgcNNneCckFU1ufXmEluD
 +8finLKVIE9kjPckBNogXyfAJPDIBXpo4/rEc+Nu2z+cU8r1y7BOCkO57DTXmvqxyNG2
 QgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8pn61z/AZlCbW46Gle17K3TRBW4SV6Pv5/9zQKRYFNA=;
 b=JgYbWUVqhK+u0vy0kDmhvAsnoPR7KOH635D0aaXhDI9LbtJdxZnWcbUdAlsjKmPfN9
 +QrpAKofWpnGXHG0MOaEq3DsY1pnWyP7Evk7JvKPUlJbtuKBA15SlAx8vzZoldbhP9P2
 6wX1r0ZIXxDi1USb+JKZ6wOezc44Xt0j1o0kNrzbwnJzuq7OLZJvAPo7Po+ovWrgYZX1
 Ds+eRxVOSo1t/rDtrFe+tdQGehqVs9tBIoMlevzIIWBDp36WEvK1qgz3ss4oFLLcH0kT
 BqlGYawz6UTdPnlgfXECFbdZzJ7Hc/4aboudyHJ4pZW6wLFYijJla8mWNmkz1A0O2IUi
 I8cQ==
X-Gm-Message-State: AOAM531hHx9MSZXb0VgTt8msdsqcFAt9N8u7H0shXFgiwbeiuCqDgzth
 uHo10U7rtH6K5YyyATyQxsu6wt3g
X-Google-Smtp-Source: ABdhPJxromzq2qQu/cmIvEs0Rh6vQWY7BNgooDIQ3JH9iTL38CI9WqMLGhraDYGDe6TvnnyQPtdLew==
X-Received: by 2002:aed:3169:: with SMTP id 96mr22135403qtg.211.1591034659435; 
 Mon, 01 Jun 2020 11:04:19 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:19 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 065/207] drm/amdgpu/mes10.1: install mes queue via kiq
Date: Mon,  1 Jun 2020 14:00:17 -0400
Message-Id: <20200601180239.1267430-62-alexander.deucher@amd.com>
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

Install mes queue via kiq. Disable it temporarily
until it's workable.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 02c7e4807a3e..31e8e7120640 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -542,6 +542,33 @@ static void mes_v10_1_queue_init_register(struct amdgpu_ring *ring)
 	mutex_unlock(&adev->srbm_mutex);
 }
 
+#if 0
+static int mes_v10_1_kiq_enable_queue(struct amdgpu_device *adev)
+{
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
+	int r;
+
+	if (!kiq->pmf || !kiq->pmf->kiq_map_queues)
+		return -EINVAL;
+
+	r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size);
+	if (r) {
+		DRM_ERROR("Failed to lock KIQ (%d).\n", r);
+		return r;
+	}
+
+	kiq->pmf->kiq_map_queues(kiq_ring, &adev->mes.ring);
+
+	r = amdgpu_ring_test_ring(kiq_ring);
+	if (r) {
+		DRM_ERROR("kfq enable failed\n");
+		kiq_ring->sched.ready = false;
+	}
+	return r;
+}
+#endif
+
 static int mes_v10_1_ring_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
