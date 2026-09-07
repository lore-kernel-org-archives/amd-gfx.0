Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFACFC79FA0
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 20:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 885FC10E90D;
	Mon,  7 Sep 2026 20:33:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dyJuqlbH";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4201B10E90B
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 20:33:44 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-499ae1c6471so38132315e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Sep 2026 13:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788813223; x=1789418023; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IGx8a3CudQi/B8DhviV1bXyv86yb1mrPDnu4nNJHzn8=;
 b=dyJuqlbHyz6Dybfm/kFVh4QWEaRRhoJrn4bGCX5kuc0C+Xw5UL8lAB9WzB2kJe5yKZ
 awoKUkVqzxjjcRsAU3Zm33ha4sbZ2LmiedpQ1YPoxxJZ39yB1JE/fzCB8Enp0TZICitV
 mkrQiG/Wr5DcGx635hTvdjxJPivIs9/81yz85s0zj0qDkrlQ2QmukhcHeWgA6WfNdsRw
 dUyczUX8SghU67Z+eoqyb10RRy+MXQL7aHvuDg7oFGxykGWLLWna0J7Z7Kf6XdD5WIwv
 vLyzNB+cQGA5HKTZUc4cvrfC5loMuH0ipKteBBTsQ7MN0k/tFH+PuiUm+SZyntPvFjF6
 i9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788813223; x=1789418023;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IGx8a3CudQi/B8DhviV1bXyv86yb1mrPDnu4nNJHzn8=;
 b=APwBhXjFZtHO/vmxQbIjPhmkyl8oqDXrjtqh1kEzPr2B/JAUtoDNrEX3pkhOIiY/Ag
 aGE4pD1/tupJkWfq+FS5b+r15V2/zULKKWDGOcAoDIIRSC9ZqaIObtiABUNrUSxuFCCN
 dTGJ07UVxok4Lpm7cjKbijIQnfolUqkBbXvbBU3jWdi9GBgYDwtZj6LnbTS/vw9UXTdo
 PywYnV7ljIxYOG6siCcHMFRE4SOKTIOBzho/90zUJjlObA3cOqKrQtlIPkdXKkaGcq4I
 VBm9WDmuR8ON6Ff3hTnKImjBWNlM64t32GIVzG0vr75fclc1bDBSJX2jpJ5jXe7THKXC
 jsvA==
X-Gm-Message-State: AFuF++k5/BJDn4ygG18W1m4z5adKlT1/Eq3H9lrShcUD4nDbnREp9eNA
 TZZqaxdj7uce/z5h87H2zLhqldLa1xe3pj0MrRBShlN7PWa0zm0FYNwx6qOug/PW
X-Gm-Gg: AYBFou3wAOwlLX2BR8oNCkESiXIl6RJ7oZARurz6KaCno9wJ0eWbQ6CHw/5KLcnMCsk
 anePbbYgq7uvNprUF1e5avqwV2ilG9aiuvec6sZbxOB8WyFwBk0K5SlqJY0IA4bNC62qKnc6DKd
 SCj6lkA5b25P7oXAUIjDXM2qCINFs8TSVLWC6blXp7egCEniXP6VQ13MwpW2lHtR30lCLVL13bo
 sjaBvgglF72KEIT2HzPeop0cx2Ah/hfLn3NI169JU8Jl6bcvqlQrXxmJVqtfXm7yJxfCq/axqg2
 S+VqyGdeqY6DxdDUcFjm1GnMrBtjwkxwWx8PSX52CsKsj0PBzOLpdxWw4XQXTDJoUduHk6nsi2o
 YfFeWFLXAJvz7B4OP74KMzU3aA5QeZeIOaB2B9LV72P/OzHmwhL27dNG7u7nXB99yAYagJOk4E+
 iwSWxjae+L6RjPe3SaxAU0HpO7rdDlZVTMj/trk9MX0SD85pMBC8GR0ZePRDFsG570ZOMWHu5hP
 Jw77LGHrGMRcj3eiHxQ
X-Received: by 2002:a05:600c:3496:b0:499:b65d:1250 with SMTP id
 5b1f17b1804b1-49cf7fe62admr455392945e9.2.1788813222633; 
 Mon, 07 Sep 2026 13:33:42 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48594172546sm22191354f8f.15.2026.09.07.13.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 13:33:42 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 04/12] drm/amdgpu/sdma: Refactor CIK SDMA clock gating
 functions to be per-instance
Date: Mon,  7 Sep 2026 22:33:08 +0200
Message-ID: <20260907203316.159103-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907203316.159103-1-timur.kristof@gmail.com>
References: <20260907203316.159103-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Refactor clock gating functions to take the SDMA engine
instance ID as an argument and only affect one SDMA engine
instance at once.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c | 50 ++++++++++-----------------
 1 file changed, 19 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 78fea0621ed9..61ff76fb8fc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -854,51 +854,39 @@ static void cik_sdma_ring_emit_wreg(struct amdgpu_ring *ring,
 }
 
 static void cik_enable_sdma_mgcg(struct amdgpu_device *adev,
-				 bool enable)
+				 const u32 instance_id,
+				 const bool enable)
 {
+	const u32 reg_offset = sdma_offsets[instance_id];
 	u32 orig, data;
 
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_MGCG)) {
-		WREG32(mmSDMA0_CLK_CTRL + SDMA0_REGISTER_OFFSET, 0x00000100);
-		WREG32(mmSDMA0_CLK_CTRL + SDMA1_REGISTER_OFFSET, 0x00000100);
+		WREG32(mmSDMA0_CLK_CTRL + reg_offset, 0x00000100);
 	} else {
-		orig = data = RREG32(mmSDMA0_CLK_CTRL + SDMA0_REGISTER_OFFSET);
-		data |= 0xff000000;
-		if (data != orig)
-			WREG32(mmSDMA0_CLK_CTRL + SDMA0_REGISTER_OFFSET, data);
-
-		orig = data = RREG32(mmSDMA0_CLK_CTRL + SDMA1_REGISTER_OFFSET);
+		orig = data = RREG32(mmSDMA0_CLK_CTRL + reg_offset);
 		data |= 0xff000000;
 		if (data != orig)
-			WREG32(mmSDMA0_CLK_CTRL + SDMA1_REGISTER_OFFSET, data);
+			WREG32(mmSDMA0_CLK_CTRL + reg_offset, data);
 	}
 }
 
 static void cik_enable_sdma_mgls(struct amdgpu_device *adev,
-				 bool enable)
+				 const u32 instance_id,
+				 const bool enable)
 {
+	const u32 reg_offset = sdma_offsets[instance_id];
 	u32 orig, data;
 
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_LS)) {
-		orig = data = RREG32(mmSDMA0_POWER_CNTL + SDMA0_REGISTER_OFFSET);
-		data |= 0x100;
-		if (orig != data)
-			WREG32(mmSDMA0_POWER_CNTL + SDMA0_REGISTER_OFFSET, data);
-
-		orig = data = RREG32(mmSDMA0_POWER_CNTL + SDMA1_REGISTER_OFFSET);
+		orig = data = RREG32(mmSDMA0_POWER_CNTL + reg_offset);
 		data |= 0x100;
 		if (orig != data)
-			WREG32(mmSDMA0_POWER_CNTL + SDMA1_REGISTER_OFFSET, data);
+			WREG32(mmSDMA0_POWER_CNTL + reg_offset, data);
 	} else {
-		orig = data = RREG32(mmSDMA0_POWER_CNTL + SDMA0_REGISTER_OFFSET);
+		orig = data = RREG32(mmSDMA0_POWER_CNTL + reg_offset);
 		data &= ~0x100;
 		if (orig != data)
-			WREG32(mmSDMA0_POWER_CNTL + SDMA0_REGISTER_OFFSET, data);
-
-		orig = data = RREG32(mmSDMA0_POWER_CNTL + SDMA1_REGISTER_OFFSET);
-		data &= ~0x100;
-		if (orig != data)
-			WREG32(mmSDMA0_POWER_CNTL + SDMA1_REGISTER_OFFSET, data);
+			WREG32(mmSDMA0_POWER_CNTL + reg_offset, data);
 	}
 }
 
@@ -1184,14 +1172,14 @@ static int cik_sdma_process_illegal_inst_irq(struct amdgpu_device *adev,
 static int cik_sdma_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	bool gate = false;
+	const bool gate = state == AMD_CG_STATE_GATE;
 	struct amdgpu_device *adev = ip_block->adev;
+	int i;
 
-	if (state == AMD_CG_STATE_GATE)
-		gate = true;
-
-	cik_enable_sdma_mgcg(adev, gate);
-	cik_enable_sdma_mgls(adev, gate);
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		cik_enable_sdma_mgcg(adev, i, gate);
+		cik_enable_sdma_mgls(adev, i, gate);
+	}
 
 	return 0;
 }
-- 
2.55.0

