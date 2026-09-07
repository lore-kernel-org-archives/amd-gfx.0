Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE1AC79F99
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 20:34:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B74110E913;
	Mon,  7 Sep 2026 20:34:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kyZK7fzm";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A81AB10E913
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 20:33:58 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so2730478f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Sep 2026 13:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788813237; x=1789418037; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v/idnI67QuTDkpRo905sTPSQ0atlYTGXH6zGHUxsaaA=;
 b=kyZK7fzm+Vwb2bNHMCCRyTAtwU4+PIUoy8Lb4iZBx2LTO/+h8/nScMWQJb2QueTdXO
 fTZL9uxjCdgCwLewKNyC7N6Lva0MZ0aPW/OEBW06Go76NnQF0XMhyT/11N1jxHWMdRWc
 O0ZLZzVno3ssJvzDuLj37IcKd5+SzO/A8+Zh1vLIt12w5AzhCdXvFI+KydfKPfU60jBX
 64edldC6W77NXp8udfxt9C54GVr9IRIar/byyZneegpU1P56THyW90Xne/+EFbG5wjfH
 XSk0xHAG3wCOt4I5Td18MVQ0gvxh5tPN5/hJvwBe+efW3gzn9gNMc6A/tOzmK3KDfvr+
 vhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788813237; x=1789418037;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v/idnI67QuTDkpRo905sTPSQ0atlYTGXH6zGHUxsaaA=;
 b=pMEv0zzTE3m7EyTz40HV2I6UnSD4ryezwGDh0WJQRJDizUB7L2BPuMYxZQlCbuCtpR
 7OJHDCTheZPYsKIu5ShcX48/BVVYFOPsTbhXQKy4Jcl2//gqP4oMUSBPzuWFnhACosaq
 p5cBA4XLLaUqrrMOP1TlW4Bx3qwJ8U0v4ToGklkzncs4jSmRAq9GzemsBAHw7FaBjl/y
 f7mMZM2KFe0eOgAzXLLNOjQDcc7clfjyJQmKymjxpb4tdrvRBcgQ2bVn2vo8944drmsa
 gEDvEw6hrPZuCWylFesqorzP5EYYUBw/Z0NlLtb0U4StjStLKZoCU0blziZ2F+UYPr0l
 hCug==
X-Gm-Message-State: AFuF++nUpEMBDhOacnZMiayvCATQ2w53rer60I/sJryGIM8pFAaJfP+e
 MGcx+xswk6gD9F7BDQoqogIbu2YUWTpzaT0j58N5Eh5E5LTLMIRKvUnBrQFOnJR/
X-Gm-Gg: AYBFou3SJ7jxvOLUDAziFT2+rPr3HFZYoV37/CYjK9htSZAgk1Soq90Arg43718Huuy
 Pei2kQktP3cirN4OG07QB5xS3nKZjrImqH9tPurgZHSBE3yqGW/kWV+HA6To1rP8gRl/3U2kojJ
 E5eKFhxMcKxxXC5nQqpAVlvQFJfvYqo7lBvQZ7I8OrETQlQJLDNosOpItW9pcRHiZyLy13Tenbi
 +I8gBMAA18csTet+/fdYf32DegSkDmFOGJqULLed2/DwAvE2aQgmUQToivrdIIrLCLQ90C8NLW4
 KSjPWe3GmZh4nBA8L3Mj4tFDJXXAMPxRi2YVWPw2I+F1Aoipv6LlQfY83ggBiZPSVKC2YVl5wm5
 XqiixOwgAxcxaoGkI6ryvlNEk/TYEy4/30692XHZ6wURCzM+VVvELxl4KqjfAppLf9MKoiohYcx
 jkDxzeyuO0ckE2UD338tfxKyS4BgTzwyam51nY/hD+e9FPshfvM8w8bpqMeeG2aBqDUizHdzM/V
 eIL2jAnpBxFWNP6x7V5Rg==
X-Received: by 2002:a5d:5f09:0:b0:485:8a47:5b81 with SMTP id
 ffacd0b85a97d-4858a475c55mr20664494f8f.30.1788813237001; 
 Mon, 07 Sep 2026 13:33:57 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48594172546sm22191354f8f.15.2026.09.07.13.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 13:33:56 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 09/12] drm/amdgpu/sdma: Refactor SDMA v3.0 golden registers to
 be per-instance
Date: Mon,  7 Sep 2026 22:33:13 +0200
Message-ID: <20260907203316.159103-10-timur.kristof@gmail.com>
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
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 182 +++++++++++++++++--------
 1 file changed, 127 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 3d0f94372e04..4e6fa9db9948 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -76,13 +76,15 @@ static const u32 sdma_offsets[SDMA_MAX_INSTANCE] =
 	SDMA1_REGISTER_OFFSET
 };
 
-static const u32 golden_settings_tonga_a11[] =
-{
+static const u32 golden_settings_tonga_a11_sdma0[] = {
 	mmSDMA0_CHICKEN_BITS, 0xfc910007, 0x00810007,
 	mmSDMA0_CLK_CTRL, 0xff000fff, 0x00000000,
 	mmSDMA0_GFX_IB_CNTL, 0x800f0111, 0x00000100,
 	mmSDMA0_RLC0_IB_CNTL, 0x800f0111, 0x00000100,
 	mmSDMA0_RLC1_IB_CNTL, 0x800f0111, 0x00000100,
+};
+
+static const u32 golden_settings_tonga_a11_sdma1[] = {
 	mmSDMA1_CHICKEN_BITS, 0xfc910007, 0x00810007,
 	mmSDMA1_CLK_CTRL, 0xff000fff, 0x00000000,
 	mmSDMA1_GFX_IB_CNTL, 0x800f0111, 0x00000100,
@@ -90,37 +92,45 @@ static const u32 golden_settings_tonga_a11[] =
 	mmSDMA1_RLC1_IB_CNTL, 0x800f0111, 0x00000100,
 };
 
-static const u32 tonga_mgcg_cgcg_init[] =
-{
+static const u32 tonga_mgcg_cgcg_init_sdma0[] = {
 	mmSDMA0_CLK_CTRL, 0xff000ff0, 0x00000100,
-	mmSDMA1_CLK_CTRL, 0xff000ff0, 0x00000100
 };
 
-static const u32 golden_settings_fiji_a10[] =
-{
+static const u32 tonga_mgcg_cgcg_init_sdma1[] = {
+	mmSDMA1_CLK_CTRL, 0xff000ff0, 0x00000100,
+};
+
+static const u32 golden_settings_fiji_a10_sdma0[] = {
 	mmSDMA0_CHICKEN_BITS, 0xfc910007, 0x00810007,
 	mmSDMA0_GFX_IB_CNTL, 0x800f0111, 0x00000100,
 	mmSDMA0_RLC0_IB_CNTL, 0x800f0111, 0x00000100,
 	mmSDMA0_RLC1_IB_CNTL, 0x800f0111, 0x00000100,
+};
+
+static const u32 golden_settings_fiji_a10_sdma1[] = {
 	mmSDMA1_CHICKEN_BITS, 0xfc910007, 0x00810007,
 	mmSDMA1_GFX_IB_CNTL, 0x800f0111, 0x00000100,
 	mmSDMA1_RLC0_IB_CNTL, 0x800f0111, 0x00000100,
 	mmSDMA1_RLC1_IB_CNTL, 0x800f0111, 0x00000100,
 };
 
-static const u32 fiji_mgcg_cgcg_init[] =
-{
+static const u32 fiji_mgcg_cgcg_init_sdma0[] = {
 	mmSDMA0_CLK_CTRL, 0xff000ff0, 0x00000100,
-	mmSDMA1_CLK_CTRL, 0xff000ff0, 0x00000100
 };
 
-static const u32 golden_settings_polaris11_a11[] =
-{
+static const u32 fiji_mgcg_cgcg_init_sdma1[] = {
+	mmSDMA1_CLK_CTRL, 0xff000ff0, 0x00000100,
+};
+
+static const u32 golden_settings_polaris11_a11_sdma0[] = {
 	mmSDMA0_CHICKEN_BITS, 0xfc910007, 0x00810007,
 	mmSDMA0_CLK_CTRL, 0xff000fff, 0x00000000,
 	mmSDMA0_GFX_IB_CNTL, 0x800f0111, 0x00000100,
 	mmSDMA0_RLC0_IB_CNTL, 0x800f0111, 0x00000100,
 	mmSDMA0_RLC1_IB_CNTL, 0x800f0111, 0x00000100,
+};
+
+static const u32 golden_settings_polaris11_a11_sdma1[] = {
 	mmSDMA1_CHICKEN_BITS, 0xfc910007, 0x00810007,
 	mmSDMA1_CLK_CTRL, 0xff000fff, 0x00000000,
 	mmSDMA1_GFX_IB_CNTL, 0x800f0111, 0x00000100,
@@ -128,13 +138,15 @@ static const u32 golden_settings_polaris11_a11[] =
 	mmSDMA1_RLC1_IB_CNTL, 0x800f0111, 0x00000100,
 };
 
-static const u32 golden_settings_polaris10_a11[] =
-{
+static const u32 golden_settings_polaris10_a11_sdma0[] = {
 	mmSDMA0_CHICKEN_BITS, 0xfc910007, 0x00810007,
 	mmSDMA0_CLK_CTRL, 0xff000fff, 0x00000000,
 	mmSDMA0_GFX_IB_CNTL, 0x800f0111, 0x00000100,
 	mmSDMA0_RLC0_IB_CNTL, 0x800f0111, 0x00000100,
 	mmSDMA0_RLC1_IB_CNTL, 0x800f0111, 0x00000100,
+};
+
+static const u32 golden_settings_polaris10_a11_sdma1[] = {
 	mmSDMA1_CHICKEN_BITS, 0xfc910007, 0x00810007,
 	mmSDMA1_CLK_CTRL, 0xff000fff, 0x00000000,
 	mmSDMA1_GFX_IB_CNTL, 0x800f0111, 0x00000100,
@@ -142,14 +154,16 @@ static const u32 golden_settings_polaris10_a11[] =
 	mmSDMA1_RLC1_IB_CNTL, 0x800f0111, 0x00000100,
 };
 
-static const u32 cz_golden_settings_a11[] =
-{
+static const u32 cz_golden_settings_a11_sdma0[] = {
 	mmSDMA0_CHICKEN_BITS, 0xfc910007, 0x00810007,
 	mmSDMA0_CLK_CTRL, 0xff000fff, 0x00000000,
 	mmSDMA0_GFX_IB_CNTL, 0x00000100, 0x00000100,
 	mmSDMA0_POWER_CNTL, 0x00000800, 0x0003c800,
 	mmSDMA0_RLC0_IB_CNTL, 0x00000100, 0x00000100,
 	mmSDMA0_RLC1_IB_CNTL, 0x00000100, 0x00000100,
+};
+
+static const u32 cz_golden_settings_a11_sdma1[] = {
 	mmSDMA1_CHICKEN_BITS, 0xfc910007, 0x00810007,
 	mmSDMA1_CLK_CTRL, 0xff000fff, 0x00000000,
 	mmSDMA1_GFX_IB_CNTL, 0x00000100, 0x00000100,
@@ -158,22 +172,22 @@ static const u32 cz_golden_settings_a11[] =
 	mmSDMA1_RLC1_IB_CNTL, 0x00000100, 0x00000100,
 };
 
-static const u32 cz_mgcg_cgcg_init[] =
-{
+static const u32 cz_mgcg_cgcg_init_sdma0[] = {
 	mmSDMA0_CLK_CTRL, 0xff000ff0, 0x00000100,
-	mmSDMA1_CLK_CTRL, 0xff000ff0, 0x00000100
 };
 
-static const u32 stoney_golden_settings_a11[] =
-{
+static const u32 cz_mgcg_cgcg_init_sdma1[] = {
+	mmSDMA1_CLK_CTRL, 0xff000ff0, 0x00000100,
+};
+
+static const u32 stoney_golden_settings_a11_sdma0[] = {
 	mmSDMA0_GFX_IB_CNTL, 0x00000100, 0x00000100,
 	mmSDMA0_POWER_CNTL, 0x00000800, 0x0003c800,
 	mmSDMA0_RLC0_IB_CNTL, 0x00000100, 0x00000100,
 	mmSDMA0_RLC1_IB_CNTL, 0x00000100, 0x00000100,
 };
 
-static const u32 stoney_mgcg_cgcg_init[] =
-{
+static const u32 stoney_mgcg_cgcg_init_sdma0[] = {
 	mmSDMA0_CLK_CTRL, 0xffffffff, 0x00000100,
 };
 
@@ -194,52 +208,110 @@ static const u32 stoney_mgcg_cgcg_init[] =
  * buffers.
  */
 
-static void sdma_v3_0_init_golden_registers(struct amdgpu_device *adev)
+static void sdma_v3_0_init_golden_registers(struct amdgpu_device *adev, const u32 instance_id)
 {
+	ASSERT(instance_id < adev->sdma.num_instances);
+
 	switch (adev->asic_type) {
 	case CHIP_FIJI:
-		amdgpu_device_program_register_sequence(adev,
-							fiji_mgcg_cgcg_init,
-							ARRAY_SIZE(fiji_mgcg_cgcg_init));
-		amdgpu_device_program_register_sequence(adev,
-							golden_settings_fiji_a10,
-							ARRAY_SIZE(golden_settings_fiji_a10));
+		if (instance_id == 0) {
+			amdgpu_device_program_register_sequence(
+				adev,
+				fiji_mgcg_cgcg_init_sdma0,
+				ARRAY_SIZE(fiji_mgcg_cgcg_init_sdma0));
+			amdgpu_device_program_register_sequence(
+				adev,
+				golden_settings_fiji_a10_sdma0,
+				ARRAY_SIZE(golden_settings_fiji_a10_sdma0));
+		} else {
+			amdgpu_device_program_register_sequence(
+				adev,
+				fiji_mgcg_cgcg_init_sdma1,
+				ARRAY_SIZE(fiji_mgcg_cgcg_init_sdma1));
+			amdgpu_device_program_register_sequence(
+				adev,
+				golden_settings_fiji_a10_sdma1,
+				ARRAY_SIZE(golden_settings_fiji_a10_sdma1));
+		}
 		break;
 	case CHIP_TONGA:
-		amdgpu_device_program_register_sequence(adev,
-							tonga_mgcg_cgcg_init,
-							ARRAY_SIZE(tonga_mgcg_cgcg_init));
-		amdgpu_device_program_register_sequence(adev,
-							golden_settings_tonga_a11,
-							ARRAY_SIZE(golden_settings_tonga_a11));
+		if (instance_id == 0) {
+			amdgpu_device_program_register_sequence(
+				adev,
+				tonga_mgcg_cgcg_init_sdma0,
+				ARRAY_SIZE(tonga_mgcg_cgcg_init_sdma0));
+			amdgpu_device_program_register_sequence(
+				adev,
+				golden_settings_tonga_a11_sdma0,
+				ARRAY_SIZE(golden_settings_tonga_a11_sdma0));
+		} else {
+			amdgpu_device_program_register_sequence(
+				adev,
+				tonga_mgcg_cgcg_init_sdma1,
+				ARRAY_SIZE(tonga_mgcg_cgcg_init_sdma1));
+			amdgpu_device_program_register_sequence(
+				adev,
+				golden_settings_tonga_a11_sdma1,
+				ARRAY_SIZE(golden_settings_tonga_a11_sdma1));
+		}
 		break;
 	case CHIP_POLARIS11:
 	case CHIP_POLARIS12:
 	case CHIP_VEGAM:
-		amdgpu_device_program_register_sequence(adev,
-							golden_settings_polaris11_a11,
-							ARRAY_SIZE(golden_settings_polaris11_a11));
+		if (instance_id == 0) {
+			amdgpu_device_program_register_sequence(
+				adev,
+				golden_settings_polaris11_a11_sdma0,
+				ARRAY_SIZE(golden_settings_polaris11_a11_sdma0));
+		} else {
+			amdgpu_device_program_register_sequence(
+				adev,
+				golden_settings_polaris11_a11_sdma1,
+				ARRAY_SIZE(golden_settings_polaris11_a11_sdma1));
+		}
 		break;
 	case CHIP_POLARIS10:
-		amdgpu_device_program_register_sequence(adev,
-							golden_settings_polaris10_a11,
-							ARRAY_SIZE(golden_settings_polaris10_a11));
+		if (instance_id == 0) {
+			amdgpu_device_program_register_sequence(
+				adev,
+				golden_settings_polaris10_a11_sdma0,
+				ARRAY_SIZE(golden_settings_polaris10_a11_sdma0));
+		} else {
+			amdgpu_device_program_register_sequence(
+				adev,
+				golden_settings_polaris10_a11_sdma1,
+				ARRAY_SIZE(golden_settings_polaris10_a11_sdma1));
+		}
 		break;
 	case CHIP_CARRIZO:
-		amdgpu_device_program_register_sequence(adev,
-							cz_mgcg_cgcg_init,
-							ARRAY_SIZE(cz_mgcg_cgcg_init));
-		amdgpu_device_program_register_sequence(adev,
-							cz_golden_settings_a11,
-							ARRAY_SIZE(cz_golden_settings_a11));
+		if (instance_id == 0) {
+			amdgpu_device_program_register_sequence(
+				adev,
+				cz_mgcg_cgcg_init_sdma0,
+				ARRAY_SIZE(cz_mgcg_cgcg_init_sdma0));
+			amdgpu_device_program_register_sequence(
+				adev,
+				cz_golden_settings_a11_sdma0,
+				ARRAY_SIZE(cz_golden_settings_a11_sdma0));
+		} else {
+			amdgpu_device_program_register_sequence(
+				adev,
+				cz_mgcg_cgcg_init_sdma1,
+				ARRAY_SIZE(cz_mgcg_cgcg_init_sdma1));
+			amdgpu_device_program_register_sequence(
+				adev,
+				cz_golden_settings_a11_sdma1,
+				ARRAY_SIZE(cz_golden_settings_a11_sdma1));
+		}
 		break;
 	case CHIP_STONEY:
+		amdgpu_device_program_register_sequence(
+			adev,
+			stoney_mgcg_cgcg_init_sdma0,
+			ARRAY_SIZE(stoney_mgcg_cgcg_init_sdma0));
 		amdgpu_device_program_register_sequence(adev,
-							stoney_mgcg_cgcg_init,
-							ARRAY_SIZE(stoney_mgcg_cgcg_init));
-		amdgpu_device_program_register_sequence(adev,
-							stoney_golden_settings_a11,
-							ARRAY_SIZE(stoney_golden_settings_a11));
+			stoney_golden_settings_a11_sdma0,
+			ARRAY_SIZE(stoney_golden_settings_a11_sdma0));
 		break;
 	default:
 		break;
@@ -745,6 +817,8 @@ static int sdma_v3_0_start(struct amdgpu_device *adev, const u32 instance_id)
 {
 	int r;
 
+	sdma_v3_0_init_golden_registers(adev, instance_id);
+
 	/* disable sdma engine before programing it */
 	sdma_v3_0_ctx_switch_enable(adev, instance_id, false);
 	sdma_v3_0_enable(adev, instance_id, false);
@@ -1162,8 +1236,6 @@ static int sdma_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i, r;
 
-	sdma_v3_0_init_golden_registers(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; ++i) {
 		r = sdma_v3_0_start(adev, i);
 		if (r)
-- 
2.55.0

