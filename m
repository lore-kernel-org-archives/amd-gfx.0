Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD19C79F99
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 20:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CD4010E90C;
	Mon,  7 Sep 2026 20:33:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ge6JPCBm";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83CA210E90C
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 20:33:39 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48441fa5c37so2898861f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Sep 2026 13:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788813218; x=1789418018; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/YSinDsUpYbxum8Q4rv2Lo152bcPnwjoqdUpIUTJXMY=;
 b=ge6JPCBmDEZfLSCE31g+YSDon1KoKodqb2omzq4Lz6O4UQAACuTSiDd9I0fWIg/vmP
 kEIvJxH0Z1jRXkfVIRxzvTuTsU7z9N8JM+3SfwXbGJ3G2BjapdbbQrhTH0lfq7NKz+n/
 MqrHVvH2NLyYrknRFz93VJOhd05O8evSuVKk1Gu5xjHZqbPQW8UQF8H5qwBi0H9tm8n6
 4atIXEKoxswi1NOGEwAbGiE55k9E9+HLnLeEfUA6RDESC0nyo0kGWsF9jD1Gq+l5heFF
 kgwWX5WG8vmdQp9WZF3594qOwvB4JFPhLMeiWAJz5EwR0915mMfBXz2s10BQgjkRFFEm
 TGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788813218; x=1789418018;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/YSinDsUpYbxum8Q4rv2Lo152bcPnwjoqdUpIUTJXMY=;
 b=REbvqu2JJgwCAUI+JJqumYgXMb6CRsjuehR3jNPJOFu8ja2vsbX65s9DYi9ROTc7pA
 lfktybBe/E6Q8Vpu+TXuWz9/ET8t1ZVLl0UNde+BTKQbemNSx4oRwxj7TL8vmac2U9pO
 080tLaZs4OgVF7cAWeWK9Q3dlvXbYKw01r4/rGU3KvS+Z+9fomoPS+QRoCzB4kJAFb49
 HGE5oA7H4VQZDF1GUa+YKssVOsKbjvotUO4Ilv3zY1kd/9rWVpotepvJXEO0pNqkgvK3
 Dtrr1Hm/UIxSTqhMuo9nHRhZNKBqlsPcprVBOWV8RBQMq3mS4pn+m98Yn1ycDgzYO4tm
 LE1Q==
X-Gm-Message-State: AFuF++mveYjVYWZQn/WpKLXbz7h7y0xlIFAc1mQuZANKNIDPhYGK9DM0
 XOS03dlmLtpGdz35ee32GNsIOd8fKkldIYw1WydS91PEs5enM9/n3dyIknqCV5fj
X-Gm-Gg: AYBFou227LGwbDjZHyxrJEkGB6k56NMd95HBEDjl5+HuJsGG06ZsoGe1njO79C2/WhV
 cryAe5XBnGhQ73nGbKnTtEqSjifON7b1bOqfZBNZ+BSC/bpTtEgD4fPigXAlc5aOs42XJ7zArC+
 HwF4OmyKNfXYxPXlarIaeIk98h/6q5jIkV2WLW2U2mUbQiBXzvFst1gLYBJOpe+EdTYwuNuqx8I
 uq317r8ObkKHypKPgzhoYOAwuDf5LH4hpwiyxzpl1wDaAfskoiHlp0dWEn2hgII4aoUoGTbqDFp
 zV+iO+V731WJazYJhJpPOCrmezNPXygt0YUTGZwQMKB5Mcc2tXf8FjDCDi5q1uNoHa7hyCsQwtf
 F5MJ67Q0zeuGJ6FABfyo6MSSJV+Fvt1uAr4tJ8mM2t5Hkf2Jzh+em41fzLGzy1PqxfBxFMDG5yn
 ndCjMMKseU0Wqoeq68sgQ4jgzzXRjq+THGxAFFENuIZ/lmOZT9ZQBk6LwfayfHp57f/ms9ID9v0
 dogHxgUfTZ47SlYwIi4XBf5oDSKojE=
X-Received: by 2002:a05:6000:2282:b0:485:8a46:b3c0 with SMTP id
 ffacd0b85a97d-4858a46b595mr24727458f8f.40.1788813217902; 
 Mon, 07 Sep 2026 13:33:37 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48594172546sm22191354f8f.15.2026.09.07.13.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 13:33:37 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 02/12] drm/amdgpu/sdma: Refactor SI DMA clock gating functions
 to be per-instance
Date: Mon,  7 Sep 2026 22:33:06 +0200
Message-ID: <20260907203316.159103-3-timur.kristof@gmail.com>
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
 drivers/gpu/drm/amd/amdgpu/si_dma.c | 63 +++++++++++++----------------
 1 file changed, 29 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 483a0cfb7c8f..fa67415acbc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -654,45 +654,40 @@ static int si_dma_process_trap_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int si_dma_set_clockgating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_clockgating_state state)
+static void si_dma_enable_mgcg(struct amdgpu_device *adev,
+			       const u32 instance_id,
+			       const bool enable)
 {
-	u32 orig, data, offset;
-	int i;
-	bool enable;
-	struct amdgpu_device *adev = ip_block->adev;
-
-	enable = (state == AMD_CG_STATE_GATE);
+	const u32 reg_offset = sdma_offsets[instance_id];
+	u32 orig, data;
 
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_MGCG)) {
-		for (i = 0; i < adev->sdma.num_instances; i++) {
-			if (i == 0)
-				offset = DMA0_REGISTER_OFFSET;
-			else
-				offset = DMA1_REGISTER_OFFSET;
-			orig = data = RREG32(mmDMA_POWER_CNTL + offset);
-			data &= ~DMA_POWER_CNTL__MEM_POWER_OVERRIDE_MASK;
-			if (data != orig)
-				WREG32(mmDMA_POWER_CNTL + offset, data);
-			WREG32(mmDMA_CLK_CTRL + offset, 0x00000100);
-		}
+		orig = data = RREG32(mmDMA_POWER_CNTL + reg_offset);
+		data &= ~DMA_POWER_CNTL__MEM_POWER_OVERRIDE_MASK;
+		if (data != orig)
+			WREG32(mmDMA_POWER_CNTL + reg_offset, data);
+		WREG32(mmDMA_CLK_CTRL + reg_offset, 0x00000100);
 	} else {
-		for (i = 0; i < adev->sdma.num_instances; i++) {
-			if (i == 0)
-				offset = DMA0_REGISTER_OFFSET;
-			else
-				offset = DMA1_REGISTER_OFFSET;
-			orig = data = RREG32(mmDMA_POWER_CNTL + offset);
-			data |= DMA_POWER_CNTL__MEM_POWER_OVERRIDE_MASK;
-			if (data != orig)
-				WREG32(mmDMA_POWER_CNTL + offset, data);
-
-			orig = data = RREG32(mmDMA_CLK_CTRL + offset);
-			data = 0xff000000;
-			if (data != orig)
-				WREG32(mmDMA_CLK_CTRL + offset, data);
-		}
+		orig = data = RREG32(mmDMA_POWER_CNTL + reg_offset);
+		data |= DMA_POWER_CNTL__MEM_POWER_OVERRIDE_MASK;
+		if (data != orig)
+			WREG32(mmDMA_POWER_CNTL + reg_offset, data);
+
+		orig = data = RREG32(mmDMA_CLK_CTRL + reg_offset);
+		data = 0xff000000;
+		if (data != orig)
+			WREG32(mmDMA_CLK_CTRL + reg_offset, data);
 	}
+}
+
+static int si_dma_set_clockgating_state(struct amdgpu_ip_block *const ip_block,
+					const enum amd_clockgating_state state)
+{
+	struct amdgpu_device *const adev = ip_block->adev;
+	int i;
+
+	for (i = 0; i < adev->sdma.num_instances; i++)
+		si_dma_enable_mgcg(adev, i, state == AMD_CG_STATE_GATE);
 
 	return 0;
 }
-- 
2.55.0

