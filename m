Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DD0C79F9E
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 20:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1761610E921;
	Mon,  7 Sep 2026 20:34:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c87xpslf";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C115C10E91A
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 20:34:08 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-484392e3d33so2741871f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Sep 2026 13:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788813247; x=1789418047; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DMb6YG7KLfCS/Cn1rFEzgZIC5pOi9438HkZuzLsvyf8=;
 b=c87xpslfr4BK8nlM+bNPzXi69TOIwMfUCE9MSaoIL76CkoRUZRNcbDDeaFnTDMopYi
 JXy888QLL9ShJU0Bo7olGd3dNuk2u70coR7k6fY8R0fV5xp6yLcUVjGn0s1YMLp9mDX3
 xswq/0UUuIQ/n4WTu10HdTgYBdT71aU6WjyIqhZzUTJjEVbzmFt94vI9qxyxzjjmonn+
 QgiXWA1dGhDrKwryD9dyegsKRehsgQljOZ2jid74wecCXbhAEJXgPXVGw6DJcRd78dga
 nKfQNgPhEOKAEsGhj+SWpuBStI3rHRQmRRFh6Js62YlCg4lqEHd81GU1L27vpG2fQua6
 wMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788813247; x=1789418047;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DMb6YG7KLfCS/Cn1rFEzgZIC5pOi9438HkZuzLsvyf8=;
 b=Rz20i42b9Xy+ZlDGQC333fYzWL0zsMIUpctLemFNN1S6xA8dVFp+rZvfzY4RJXY5Ig
 X0VDxq9qS/tVxBnoa5m51r0CDP+OTGTo9s0TKhXAqkvLhU2mwsztq0Cq9lIYQzljTO9G
 zbiRID113OugY5Os+3tFCKGUImg75P6SUgAl60ACGmigS/1KILu26hmNgJVWzL2AnywH
 KHUt3m19eQfu0JVcOQTokcu0fu5HSc+OJLpzJjHuzFcSmylm5tSkxvHpBxiJS6ggJdhm
 Wt7z8jXjauHF5HmT23W0dfvzaipTd8L8NNjBZFQp6v/Tgpg53IILjbZ4j004nvU886fj
 0lPA==
X-Gm-Message-State: AFuF++lOnjWtTfz8BzcAjeHQZ39sn+mRvP0Kspc2LZu7Fmqo9HkDsTzg
 FkxfXEOWWGQUAEvuk2qBxRuumhjFrYCDxTqsM63icae6e1cstGI4Csm28xXqnbod
X-Gm-Gg: AYBFou1L+UpzTgaX7i/yzUqXtis4lnxPkUnCTMq3jYa1f0w6TOGh6B0eAlwikPhiTXh
 HNApcW3MtR3thFTGfvmkCsJUBMmW3xupyYOMKk+05lW3uwe8+xpPnGntVoTL/ZWIaxDldFkDTcT
 OAKbdKB6nHRA4ClKqZqRByQl/73KFP/IDI7ZnMAUwETMA/CKN6eMeOVDSrQkEbMfm7K90+KbVBH
 NpAVWHI01BpPR3iv0RxXeODGUmMEwtrE2kFhP5j0CFe2dsmNYOckEe10ix4pVDPRScJ3lPMiiZq
 2evdmF/Bdkfrc9kThSTduqJFhuf5Qxp4UpVlZ3VlaF15o/HrwhXqfsN92lTC2pn+uEqlIJRxf8w
 m/xa7ldNYtNn9LE3uqrMwWYce4IXU4EXS/W2Jm7X8RuINxnUCdOmEJfay+tH4Be78+EpHkgZCi3
 kOcQGf8//9TKtU5vWUrRlMySm94kxxLlYsV6tNP/bWRx8y4BBrfmmkjrPAw6a0239oTiikh6mYv
 +AtfRFuGEag3PrY4Z/RaddOn/KElDw=
X-Received: by 2002:a05:6000:4909:b0:485:8c17:9764 with SMTP id
 ffacd0b85a97d-4858c179966mr21673192f8f.38.1788813247050; 
 Mon, 07 Sep 2026 13:34:07 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48594172546sm22191354f8f.15.2026.09.07.13.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 13:34:06 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 12/12] drm/amdgpu/sdma: Refactor SDMA v4.0 golden registers to
 be per-instance
Date: Mon,  7 Sep 2026 22:33:16 +0200
Message-ID: <20260907203316.159103-13-timur.kristof@gmail.com>
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
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 237 +++++++++++++++++++------
 1 file changed, 182 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 259857596cfd..ef9058dd1082 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -132,7 +132,7 @@ static void sdma_v4_0_set_buffer_funcs(struct amdgpu_device *adev);
 static void sdma_v4_0_set_irq_funcs(struct amdgpu_device *adev);
 static void sdma_v4_0_set_ras_funcs(struct amdgpu_device *adev);
 
-static const struct soc15_reg_golden golden_settings_sdma_4[] = {
+static const struct soc15_reg_golden golden_settings_v4_0_sdma0[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_CHICKEN_BITS, 0xfe931f07, 0x02831d07),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_CLK_CTRL, 0xff000ff0, 0x3f000100),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GFX_IB_CNTL, 0x800f0100, 0x00000100),
@@ -146,6 +146,9 @@ static const struct soc15_reg_golden golden_settings_sdma_4[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC1_RB_WPTR_POLL_CNTL, 0x0000fff0, 0x00403000),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 0x000003c0),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_WATERMK, 0xfc000000, 0x00000000),
+};
+
+static const struct soc15_reg_golden golden_settings_v4_0_sdma1[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_CLK_CTRL, 0xffffffff, 0x3f000100),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GFX_IB_CNTL, 0x800f0100, 0x00000100),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GFX_RB_WPTR_POLL_CNTL, 0x0000fff0, 0x00403000),
@@ -160,27 +163,33 @@ static const struct soc15_reg_golden golden_settings_sdma_4[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_UTCL1_WATERMK, 0xfc000000, 0x00000000)
 };
 
-static const struct soc15_reg_golden golden_settings_sdma_vg10[] = {
+static const struct soc15_reg_golden golden_settings_vg10_sdma0[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG, 0x0018773f, 0x00104002),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
+};
+
+static const struct soc15_reg_golden golden_settings_vg10_sdma1[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_CHICKEN_BITS, 0xfe931f07, 0x02831d07),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG, 0x0018773f, 0x00104002),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 };
 
-static const struct soc15_reg_golden golden_settings_sdma_vg12[] = {
+static const struct soc15_reg_golden golden_settings_vg12_sdma0[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG, 0x0018773f, 0x00104001),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104001),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
+};
+
+static const struct soc15_reg_golden golden_settings_vg12_sdma1[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_CHICKEN_BITS, 0xfe931f07, 0x02831d07),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG, 0x0018773f, 0x00104001),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104001),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 };
 
-static const struct soc15_reg_golden golden_settings_sdma_4_1[] = {
+static const struct soc15_reg_golden golden_settings_v4_1_sdma0[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_CHICKEN_BITS, 0xfe931f07, 0x02831d07),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_CLK_CTRL, 0xffffffff, 0x3f000100),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GFX_IB_CNTL, 0x800f0111, 0x00000100),
@@ -194,12 +203,11 @@ static const struct soc15_reg_golden golden_settings_sdma_4_1[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_WATERMK, 0xfc000000, 0x00000000)
 };
 
-static const struct soc15_reg_golden golden_settings_sdma0_4_2_init[] = {
+static const struct soc15_reg_golden golden_settings_v4_2_sdma0_init[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC0_RB_WPTR_POLL_CNTL, 0xfffffff0, 0x00403000),
 };
 
-static const struct soc15_reg_golden golden_settings_sdma0_4_2[] =
-{
+static const struct soc15_reg_golden golden_settings_v4_2_sdma0[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_CLK_CTRL, 0xffffffff, 0x3f000100),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
@@ -229,7 +237,7 @@ static const struct soc15_reg_golden golden_settings_sdma0_4_2[] =
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 };
 
-static const struct soc15_reg_golden golden_settings_sdma1_4_2[] = {
+static const struct soc15_reg_golden golden_settings_v4_2_sdma1[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_CLK_CTRL, 0xffffffff, 0x3f000100),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
@@ -259,73 +267,103 @@ static const struct soc15_reg_golden golden_settings_sdma1_4_2[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 };
 
-static const struct soc15_reg_golden golden_settings_sdma_rv1[] =
-{
+static const struct soc15_reg_golden golden_settings_rv1_sdma0[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG, 0x0018773f, 0x00000002),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00000002)
 };
 
-static const struct soc15_reg_golden golden_settings_sdma_rv2[] =
-{
+static const struct soc15_reg_golden golden_settings_rv2_sdma0[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG, 0x0018773f, 0x00003001),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00003001)
 };
 
-static const struct soc15_reg_golden golden_settings_sdma_arct[] =
-{
+static const struct soc15_reg_golden golden_settings_arct_sdma0[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
+};
+
+static const struct soc15_reg_golden golden_settings_arct_sdma1[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
+};
+
+static const struct soc15_reg_golden golden_settings_arct_sdma2[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA2, 0, mmSDMA2_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA2, 0, mmSDMA2_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA2, 0, mmSDMA2_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA2, 0, mmSDMA2_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
+};
+
+static const struct soc15_reg_golden golden_settings_arct_sdma3[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA3, 0, mmSDMA3_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA3, 0, mmSDMA3_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA3, 0, mmSDMA3_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA3, 0, mmSDMA3_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
+};
+
+static const struct soc15_reg_golden golden_settings_arct_sdma4[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA4, 0, mmSDMA4_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA4, 0, mmSDMA4_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA4, 0, mmSDMA4_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA4, 0, mmSDMA4_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
+};
+
+static const struct soc15_reg_golden golden_settings_arct_sdma5[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA5, 0, mmSDMA5_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA5, 0, mmSDMA5_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA5, 0, mmSDMA5_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA5, 0, mmSDMA5_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
+};
+
+static const struct soc15_reg_golden golden_settings_arct_sdma6[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA6, 0, mmSDMA6_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA6, 0, mmSDMA6_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA6, 0, mmSDMA6_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA6, 0, mmSDMA6_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
+};
+
+static const struct soc15_reg_golden golden_settings_arct_sdma7[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA7, 0, mmSDMA7_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA7, 0, mmSDMA7_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA7, 0, mmSDMA7_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA7, 0, mmSDMA7_UTCL1_TIMEOUT, 0xffffffff, 0x00010001)
 };
 
-static const struct soc15_reg_golden golden_settings_sdma_aldebaran[] = {
+static const struct soc15_reg_golden golden_settings_aldebaran_sdma0[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG, 0x0018773f, 0x00104002),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
+};
+
+static const struct soc15_reg_golden golden_settings_aldebaran_sdma1[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG, 0x0018773f, 0x00104002),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
+};
+
+static const struct soc15_reg_golden golden_settings_aldebaran_sdma2[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA2, 0, mmSDMA2_GB_ADDR_CONFIG, 0x0018773f, 0x00104002),
 	SOC15_REG_GOLDEN_VALUE(SDMA2, 0, mmSDMA2_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002),
 	SOC15_REG_GOLDEN_VALUE(SDMA3, 0, mmSDMA2_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
+};
+
+static const struct soc15_reg_golden golden_settings_aldebaran_sdma3[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA3, 0, mmSDMA3_GB_ADDR_CONFIG, 0x0018773f, 0x00104002),
 	SOC15_REG_GOLDEN_VALUE(SDMA3, 0, mmSDMA3_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002),
 	SOC15_REG_GOLDEN_VALUE(SDMA3, 0, mmSDMA3_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
+};
+
+static const struct soc15_reg_golden golden_settings_aldebaran_sdma4[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA4, 0, mmSDMA4_GB_ADDR_CONFIG, 0x0018773f, 0x00104002),
 	SOC15_REG_GOLDEN_VALUE(SDMA4, 0, mmSDMA4_GB_ADDR_CONFIG_READ, 0x0018773f, 0x00104002),
 	SOC15_REG_GOLDEN_VALUE(SDMA4, 0, mmSDMA4_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 };
 
-static const struct soc15_reg_golden golden_settings_sdma_4_3[] = {
+static const struct soc15_reg_golden golden_settings_v4_3_sdma0[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_CLK_CTRL, 0xffffffff, 0x3f000100),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG, 0x0018773f, 0x00000002),
@@ -513,64 +551,155 @@ static int sdma_v4_0_irq_id_to_seq(unsigned client_id)
 	return -EINVAL;
 }
 
-static void sdma_v4_0_init_golden_registers(struct amdgpu_device *adev)
+static void sdma_v4_0_init_golden_registers(struct amdgpu_device *adev, const u32 instance_id)
 {
 	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
 	case IP_VERSION(4, 0, 0):
-		soc15_program_register_sequence(adev,
-						golden_settings_sdma_4,
-						ARRAY_SIZE(golden_settings_sdma_4));
-		soc15_program_register_sequence(adev,
-						golden_settings_sdma_vg10,
-						ARRAY_SIZE(golden_settings_sdma_vg10));
+		if (instance_id == 0) {
+			soc15_program_register_sequence(
+				adev,
+				golden_settings_v4_0_sdma0,
+				ARRAY_SIZE(golden_settings_v4_0_sdma0));
+			soc15_program_register_sequence(
+				adev,
+				golden_settings_vg10_sdma0,
+				ARRAY_SIZE(golden_settings_vg10_sdma0));
+		} else if (instance_id == 1) {
+			soc15_program_register_sequence(
+				adev,
+				golden_settings_v4_0_sdma1,
+				ARRAY_SIZE(golden_settings_v4_0_sdma1));
+			soc15_program_register_sequence(
+				adev,
+				golden_settings_vg10_sdma1,
+				ARRAY_SIZE(golden_settings_vg10_sdma1));
+		}
 		break;
 	case IP_VERSION(4, 0, 1):
-		soc15_program_register_sequence(adev,
-						golden_settings_sdma_4,
-						ARRAY_SIZE(golden_settings_sdma_4));
-		soc15_program_register_sequence(adev,
-						golden_settings_sdma_vg12,
-						ARRAY_SIZE(golden_settings_sdma_vg12));
+		if (instance_id == 0) {
+			soc15_program_register_sequence(
+				adev,
+				golden_settings_v4_0_sdma0,
+				ARRAY_SIZE(golden_settings_v4_0_sdma0));
+			soc15_program_register_sequence(
+				adev,
+				golden_settings_vg12_sdma0,
+				ARRAY_SIZE(golden_settings_vg12_sdma0));
+		} else if (instance_id == 1) {
+			soc15_program_register_sequence(
+				adev,
+				golden_settings_v4_0_sdma1,
+				ARRAY_SIZE(golden_settings_v4_0_sdma1));
+			soc15_program_register_sequence(
+				adev,
+				golden_settings_vg12_sdma1,
+				ARRAY_SIZE(golden_settings_vg12_sdma1));
+		}
 		break;
 	case IP_VERSION(4, 2, 0):
-		soc15_program_register_sequence(adev,
-						golden_settings_sdma0_4_2_init,
-						ARRAY_SIZE(golden_settings_sdma0_4_2_init));
-		soc15_program_register_sequence(adev,
-						golden_settings_sdma0_4_2,
-						ARRAY_SIZE(golden_settings_sdma0_4_2));
-		soc15_program_register_sequence(adev,
-						golden_settings_sdma1_4_2,
-						ARRAY_SIZE(golden_settings_sdma1_4_2));
+		if (instance_id == 0) {
+			soc15_program_register_sequence(
+				adev,
+				golden_settings_v4_2_sdma0_init,
+				ARRAY_SIZE(golden_settings_v4_2_sdma0_init));
+			soc15_program_register_sequence(
+				adev,
+				golden_settings_v4_2_sdma0,
+				ARRAY_SIZE(golden_settings_v4_2_sdma0));
+		} else if (instance_id == 1) {
+			soc15_program_register_sequence(
+				adev,
+				golden_settings_v4_2_sdma1,
+				ARRAY_SIZE(golden_settings_v4_2_sdma1));
+		}
 		break;
 	case IP_VERSION(4, 2, 2):
-		soc15_program_register_sequence(adev,
-						golden_settings_sdma_arct,
-						ARRAY_SIZE(golden_settings_sdma_arct));
+		if (instance_id == 0)
+			soc15_program_register_sequence(
+				adev,
+				golden_settings_arct_sdma0,
+				ARRAY_SIZE(golden_settings_arct_sdma0));
+		else if (instance_id == 1)
+			soc15_program_register_sequence(
+				adev,
+				golden_settings_arct_sdma1,
+				ARRAY_SIZE(golden_settings_arct_sdma1));
+		else if (instance_id == 2)
+			soc15_program_register_sequence(
+				adev,
+				golden_settings_arct_sdma2,
+				ARRAY_SIZE(golden_settings_arct_sdma2));
+		else if (instance_id == 3)
+			soc15_program_register_sequence(
+				adev,
+				golden_settings_arct_sdma3,
+				ARRAY_SIZE(golden_settings_arct_sdma3));
+		else if (instance_id == 4)
+			soc15_program_register_sequence(
+				adev,
+				golden_settings_arct_sdma4,
+				ARRAY_SIZE(golden_settings_arct_sdma4));
+		else if (instance_id == 5)
+			soc15_program_register_sequence(
+				adev,
+				golden_settings_arct_sdma5,
+				ARRAY_SIZE(golden_settings_arct_sdma5));
+		else if (instance_id == 6)
+			soc15_program_register_sequence(
+				adev,
+				golden_settings_arct_sdma6,
+				ARRAY_SIZE(golden_settings_arct_sdma6));
+		else if (instance_id == 7)
+			soc15_program_register_sequence(
+				adev,
+				golden_settings_arct_sdma7,
+				ARRAY_SIZE(golden_settings_arct_sdma7));
 		break;
 	case IP_VERSION(4, 4, 0):
-		soc15_program_register_sequence(adev,
-						golden_settings_sdma_aldebaran,
-						ARRAY_SIZE(golden_settings_sdma_aldebaran));
+		if (instance_id == 0)
+			soc15_program_register_sequence(
+				adev,
+				golden_settings_aldebaran_sdma0,
+				ARRAY_SIZE(golden_settings_aldebaran_sdma0));
+		else if (instance_id == 1)
+			soc15_program_register_sequence(
+				adev,
+				golden_settings_aldebaran_sdma1,
+				ARRAY_SIZE(golden_settings_aldebaran_sdma1));
+		else if (instance_id == 2)
+			soc15_program_register_sequence(
+				adev,
+				golden_settings_aldebaran_sdma2,
+				ARRAY_SIZE(golden_settings_aldebaran_sdma2));
+		else if (instance_id == 3)
+			soc15_program_register_sequence(
+				adev,
+				golden_settings_aldebaran_sdma3,
+				ARRAY_SIZE(golden_settings_aldebaran_sdma3));
+		else if (instance_id == 4)
+			soc15_program_register_sequence(
+				adev,
+				golden_settings_aldebaran_sdma4,
+				ARRAY_SIZE(golden_settings_aldebaran_sdma4));
 		break;
 	case IP_VERSION(4, 1, 0):
 	case IP_VERSION(4, 1, 1):
 		soc15_program_register_sequence(adev,
-						golden_settings_sdma_4_1,
-						ARRAY_SIZE(golden_settings_sdma_4_1));
+						golden_settings_v4_1_sdma0,
+						ARRAY_SIZE(golden_settings_v4_1_sdma0));
 		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
 			soc15_program_register_sequence(adev,
-							golden_settings_sdma_rv2,
-							ARRAY_SIZE(golden_settings_sdma_rv2));
+							golden_settings_rv2_sdma0,
+							ARRAY_SIZE(golden_settings_rv2_sdma0));
 		else
 			soc15_program_register_sequence(adev,
-							golden_settings_sdma_rv1,
-							ARRAY_SIZE(golden_settings_sdma_rv1));
+							golden_settings_rv1_sdma0,
+							ARRAY_SIZE(golden_settings_rv1_sdma0));
 		break;
 	case IP_VERSION(4, 1, 2):
 		soc15_program_register_sequence(adev,
-						golden_settings_sdma_4_3,
-						ARRAY_SIZE(golden_settings_sdma_4_3));
+						golden_settings_v4_3_sdma0,
+						ARRAY_SIZE(golden_settings_v4_3_sdma0));
 		break;
 	default:
 		break;
@@ -1353,6 +1482,7 @@ static int sdma_v4_0_start(struct amdgpu_device *adev, const u32 instance_id)
 		sdma_v4_0_ctx_switch_enable(adev, instance_id, false);
 		sdma_v4_0_enable(adev, instance_id, false);
 	} else {
+		sdma_v4_0_init_golden_registers(adev, instance_id);
 
 		if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
 			r = sdma_v4_0_load_microcode(adev, instance_id);
@@ -1941,9 +2071,6 @@ static int sdma_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (adev->flags & AMD_IS_APU)
 		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_SDMA, false, 0);
 
-	if (!amdgpu_sriov_vf(adev))
-		sdma_v4_0_init_golden_registers(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; ++i) {
 		r = sdma_v4_0_start(adev, i);
 		if (r)
-- 
2.55.0

