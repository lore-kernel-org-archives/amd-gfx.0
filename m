Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139D7C79F99
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 20:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6FB110E90E;
	Mon,  7 Sep 2026 20:33:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="enCu1P2l";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F62A10E90E
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 20:33:50 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so2730421f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Sep 2026 13:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788813228; x=1789418028; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GHdnGcOzQGec2My5rAo2DK6zn2woMH8xxldM5bW7k+k=;
 b=enCu1P2lmrLlyn7NrjDZ5iFXLaq1tiGRn6gpttxltt9Lsxsr/0dyfgQARPMrwqUUVt
 VK+2f4V5Zj7g6fXzk1ingYDv8L2OBJBl2kaekzfaz+DM9rwpqwsIT4VDScNSEhv/Touf
 iyrmmmf0JznGIY3jteK3Y90aI1MvygMvnFMnudUcRKDpN63w2GvcxPS0XZQyLoVliPAu
 eZi9MGkgkqDott1L5gdv2tWswjnqaL69PRHlL1xRty6TT2JMEnDkyy5UCAcdJkVrO8b7
 Awo/jHhjZ5iTcu6y2IIe2zSgHMP2PhvzYSHOYcpKJRgRjwFWJW8OKei4yIx8Xn0k30xB
 15zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788813228; x=1789418028;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GHdnGcOzQGec2My5rAo2DK6zn2woMH8xxldM5bW7k+k=;
 b=e6DxF2L0Sg6rOCPeuQ8ex1LNcI0cMyfPABs4p4Ya2iUV3KTTQpGzT49SX68q3UgiLH
 h6xk25qqwoA4zNoeCbDaVcbpPNv1LW/sRu+d+xcgFp+2BiLjwvoQh3+OxLzOQte2LFEm
 WbwPnb2ATWdGwZRNSX5QDtsr3i0mIzCA57lmZ4YrcPv8QWJ8TLAMVkUIt6K5gNPzeEFL
 rgJ2f54rcC9kP1vhnNwF3YYuxjim1R34lvgtG6XiRgm1VIRsj/BP701LKy8lQgaZhOi6
 DHU0nyhra95qFFRXvLAj0YqOVZjK5DQGjum5Rdm8K3ccWf3ScxFAf5o2CeO77vjdKbQ2
 s81w==
X-Gm-Message-State: AFuF++n7EB8nApGBFHlvlFBVJGm9pOcedzwHw723AY+YjUPmbhdubiJi
 GyYl1dpga/akGSLI2F3Xm7951OGg/veMJgzZBKfpkpB3tOLchTJ3SPIKCQOGVi3y
X-Gm-Gg: AYBFou3bMtajv3hnkH7f+QHOYpcX78QVYSh+AprKaHwn11N7RLST+vAJ9jq5Jqbq9/+
 9/OUrpvzGYSMyiABrLMeXp4uNzF3Eg/xqQEPUN60x/eYpJ1V3TmttnocvWbjAgHAyyJ2AWqZtrN
 8dl7KBGeyubhhHoMv7xe7+5zKh6KXLTUdnkxBJzRKUjW7B36SBckM1YQh1pxefoJoOfb+2haC8S
 1mdCjmM5lR6uP3paTtdsp2Q6kimVEXKE5Ke9As0sdWKlFt3jKAru460ACcMSWA1leLpLFQbmyOV
 2t6V2HsGKGkX0yu1kxGl2XJQECT51lhr7Cf5J2RM+mRkWM4tq6kBoWClSPt4v4+WUU0jVEF1S2k
 PVsHIPMX0b7w0veCoC7EphKc2QDVZCXgREbBF+grDmI9zdvEO6M7JtvAXPk0z5RtuN4TnI+GkLu
 7N/FCJDXdXi98/jwcUj1q6FparequH+VJ7GXtUXObU1fab1JA9U0rn/TdPhctI3/HlKawHFsOxN
 V3H8UsNpGhD3p3gZb3/
X-Received: by 2002:a05:6000:612:b0:485:8a47:5b89 with SMTP id
 ffacd0b85a97d-4858a475d2bmr24460020f8f.38.1788813228547; 
 Mon, 07 Sep 2026 13:33:48 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48594172546sm22191354f8f.15.2026.09.07.13.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 13:33:47 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 06/12] drm/amdgpu/sdma: Refactor SDMA v2.4 golden registers to
 be per-instance
Date: Mon,  7 Sep 2026 22:33:10 +0200
Message-ID: <20260907203316.159103-7-timur.kristof@gmail.com>
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

Refactor golden registers initialization to take the SDMA
engine instance ID as an argument and only program the
golden registers for one SDMA engine at once.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 43 +++++++++++++++++++-------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 0743b782527a..a771e9ab3a9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -61,16 +61,22 @@ static const u32 sdma_offsets[SDMA_MAX_INSTANCE] = {
 	SDMA1_REGISTER_OFFSET
 };
 
-static const u32 golden_settings_iceland_a11[] = {
+static const u32 golden_settings_iceland_a11_sdma0[] = {
 	mmSDMA0_CHICKEN_BITS, 0xfc910007, 0x00810007,
 	mmSDMA0_CLK_CTRL, 0xff000fff, 0x00000000,
+};
+
+static const u32 golden_settings_iceland_a11_sdma1[] = {
 	mmSDMA1_CHICKEN_BITS, 0xfc910007, 0x00810007,
 	mmSDMA1_CLK_CTRL, 0xff000fff, 0x00000000,
 };
 
-static const u32 iceland_mgcg_cgcg_init[] = {
+static const u32 iceland_mgcg_cgcg_init_sdma0[] = {
 	mmSDMA0_CLK_CTRL, 0xff000ff0, 0x00000100,
-	mmSDMA1_CLK_CTRL, 0xff000ff0, 0x00000100
+};
+
+static const u32 iceland_mgcg_cgcg_init_sdma1[] = {
+	mmSDMA1_CLK_CTRL, 0xff000ff0, 0x00000100,
 };
 
 /*
@@ -90,16 +96,29 @@ static const u32 iceland_mgcg_cgcg_init[] = {
  * buffers.
  */
 
-static void sdma_v2_4_init_golden_registers(struct amdgpu_device *adev)
+static void sdma_v2_4_init_golden_registers(struct amdgpu_device *adev, const u32 instance_id)
 {
 	switch (adev->asic_type) {
 	case CHIP_TOPAZ:
-		amdgpu_device_program_register_sequence(adev,
-							iceland_mgcg_cgcg_init,
-							ARRAY_SIZE(iceland_mgcg_cgcg_init));
-		amdgpu_device_program_register_sequence(adev,
-							golden_settings_iceland_a11,
-							ARRAY_SIZE(golden_settings_iceland_a11));
+		if (instance_id == 0) {
+			amdgpu_device_program_register_sequence(
+				adev,
+				iceland_mgcg_cgcg_init_sdma0,
+				ARRAY_SIZE(iceland_mgcg_cgcg_init_sdma0));
+			amdgpu_device_program_register_sequence(
+				adev,
+				golden_settings_iceland_a11_sdma0,
+				ARRAY_SIZE(golden_settings_iceland_a11_sdma0));
+		} else {
+			amdgpu_device_program_register_sequence(
+				adev,
+				iceland_mgcg_cgcg_init_sdma1,
+				ARRAY_SIZE(iceland_mgcg_cgcg_init_sdma1));
+			amdgpu_device_program_register_sequence(
+				adev,
+				golden_settings_iceland_a11_sdma1,
+				ARRAY_SIZE(golden_settings_iceland_a11_sdma1));
+		}
 		break;
 	default:
 		break;
@@ -469,6 +488,8 @@ static int sdma_v2_4_start(struct amdgpu_device *adev, const u32 instance_id)
 {
 	int r;
 
+	sdma_v2_4_init_golden_registers(adev, instance_id);
+
 	/* halt the engine before programing */
 	sdma_v2_4_enable(adev, instance_id, false);
 
@@ -871,8 +892,6 @@ static int sdma_v2_4_hw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i, r;
 
-	sdma_v2_4_init_golden_registers(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; ++i) {
 		r = sdma_v2_4_start(adev, i);
 		if (r)
-- 
2.55.0

