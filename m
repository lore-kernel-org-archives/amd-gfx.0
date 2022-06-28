Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1DAC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 20:25:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6C6610F105;
	Tue, 28 Jun 2022 20:25:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33D9310F105
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 20:25:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qu0rpb+agI3B2O5GUcym7t5kp/UCB3MPiaRFlDPj7T2IBJHoD6tnhDVr6gGPNfb1DH7Gu7aQ0Wx+2dwsm6V4NuM3F43Vwv1VqWv68eS+XJVQXbZv9FnavOqidm0s9otzA7bDOZoXtbFqh4fD/FtXAkHSjiVju1CUwfosud49/OyAvOXe6Xhyo5E0fWG6p8SMv8i6wYRZzsjsriSbF5TFeV0a4NK0kYOx+A5c2SRLQ+O4p7xKGF2+1n6+1hexluxN2hf67i4TFybC7wYIZAz1fwji1Yuh4Eg6Co3Fn/m+uiB30WBGZTbxnWAwo5RPZuK/EHQrVkwITwRR+p4VV2bLRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alrUeI29j5T4zu6JHraJsJ3tGgOXK+96noAXXQfYLrU=;
 b=EMBgdRQcTKx/k96PTT/htTDM1pDNj7gnxsL02gkIk1MOXoPsBj5p0Jk8zGzQXuKT96MRhrqEf4SoJBGQAs3IXKwABkjhMu11a+kPOTgepZGvpvjpr56DsWeesdmOd/PaQewh1goSHioFujyAKaLxFr8SJ34TdQcRddf6JKO9u7e7NKOnwWXc5e6dPBI7QwmJIu/U4/EhJjv3+tYbZpsA7j7qVpw8OGxX+/VR7MWHY7gSJsGV+ToVZJn4Z9GaWLmvwiZxhJrgiqV6pjPAAlyz4NlFZ+HulyHHLzVoqQOKNsYTterNudTRK4NAU40dXhHfzVQ/pT1R5OssQThxxBy/NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alrUeI29j5T4zu6JHraJsJ3tGgOXK+96noAXXQfYLrU=;
 b=SdI3lGhiT200cjbuWkrlz7oDegUEvMHlu15JmqiDiduT0hK+lzb+Y5UyyooL3skRdb/oz7guiAFtmGYyI5/klYOYO57uC6TlNme+52H1ymiCtiVdF7pregNZmIuwHlLBct1zgC6827PeqwsV2WC3DWzeguF8jpbLLKPyKJnL8Zk=
Received: from DM6PR08CA0038.namprd08.prod.outlook.com (2603:10b6:5:1e0::12)
 by MN2PR12MB4552.namprd12.prod.outlook.com (2603:10b6:208:24f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 20:25:30 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::3) by DM6PR08CA0038.outlook.office365.com
 (2603:10b6:5:1e0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Tue, 28 Jun 2022 20:25:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 20:25:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 15:25:29 -0500
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Tue, 28 Jun 2022 15:25:28 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <marek.olsak@amd.com>
Subject: [PATCH v2] drm/amd/display: expose additional modifier for DCN32/321
Date: Tue, 28 Jun 2022 16:25:28 -0400
Message-ID: <20220628202528.2218174-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38e85cb1-6b8d-4544-a821-08da59445844
X-MS-TrafficTypeDiagnostic: MN2PR12MB4552:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ds6mcr6Z8Ug2CL+VR4KjftDxKOT+Qmy+R6a26YyvDph1ogeD0wKbDcS/bfqkuaoeHehHxKgQe4bgaEMKYtzC4bklHbJRWYu+xQRy6alCSlPdTnl6xAKVpfpOEWfHKrhAGirSVTU+iXsiXK93e7y1FVWOslpsBPCT0+9nQtxoYgG7OeNFciV9URdEhVeH9a8UMqJesv67otsXxowFYcy7VvbxhMp2zTkM3LksQwMaayBYxXmoiaeSw4s0daXin3TaAe49TI9gatHmRW/PjI+uo+EGgDDN0DxP9/EFwkzFOQ0s3qObk7JdnPFMcwGdwShvYUuVbNze0olGdybmrh2UtYA6PunpOLR5X1XIQ71TuxuRSDKtYy5AoUKYeFzovYds7stMEOmd2pNgBsFxfptEkEsuAqOpQoC7nvh17pPEbntMDRJ40gTf+RdOWq/UKvsLLK7hnCED4Y79DQs3tUt8YbW0XgCIzLSOL/hSofCmIN14AJ+DAVVkBq/BL1xiziMw8zLhPQQmEyh98m4n5zlvsmA0O4Hc3a3pvoij4yWcMEOSTynY4gxkntXVyyHpD46QXrmTLIN/sZAW/0R36z93cokx11OHLrfdEoe9om+mY6JeC1NYNs49amfc55RY93Rzm6RZchz6qprJKFsNSPQaIycc7OmOHHYJwJhsZo4Nr/SMVRk7Pd//Zh5VARXZRHCNjOpfb2fEGION8uef9vpaJvDphcCYMGI/PLXJFFHTfTAzRllj0KaO0HJUYjdVciGpCWtExtwLzW1cpL//KCA46KGr16orR0hunfZLQ+D59jm6SXZHQDNn+H8cNXSEQAuUJK2oi+45lDZdyBF0z+8A9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(396003)(376002)(136003)(46966006)(40470700004)(36840700001)(86362001)(4326008)(26005)(70586007)(36860700001)(83380400001)(1076003)(70206006)(8676002)(47076005)(356005)(7696005)(81166007)(478600001)(44832011)(8936002)(36756003)(41300700001)(2906002)(82740400003)(2616005)(6636002)(110136005)(5660300002)(336012)(316002)(40460700003)(40480700001)(426003)(54906003)(82310400005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 20:25:29.8326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e85cb1-6b8d-4544-a821-08da59445844
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4552
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
Cc: alexdeucher@gmail.com, aurabindo.pillai@amd.com, harry.wentland@amd.com,
 bas@basnieuwenhuizen.nl
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
Some userspace expect a backwards compatible modifier on DCN32/321. For
hardware with num_pipes more than 16, we expose the most efficient
modifier first. As a fall back method, we need to expose slightly inefficient
modifier AMD_FMT_MOD_TILE_GFX9_64K_R_X after the best option.

Also set the number of packers to fixed value as required per hardware
documentation. This value is cached during hardware initialization and
can be read through the base driver.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 66 ++++++++++---------
 2 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 1a512d78673a..0f5bfe5df627 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -743,8 +743,7 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
 			switch (version) {
 			case AMD_FMT_MOD_TILE_VER_GFX11:
 				pipe_xor_bits = min(block_size_bits - 8, pipes);
-				packers = min(block_size_bits - 8 - pipe_xor_bits,
-						ilog2(adev->gfx.config.gb_addr_config_fields.num_pkrs));
+				packers = ilog2(adev->gfx.config.gb_addr_config_fields.num_pkrs);
 				break;
 			case AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS:
 				pipe_xor_bits = min(block_size_bits - 8, pipes);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 98bb65377e98..adccaf2f539d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5208,6 +5208,7 @@ add_gfx11_modifiers(struct amdgpu_device *adev,
 	int num_pkrs = 0;
 	int pkrs = 0;
 	u32 gb_addr_config;
+	u8 i = 0;
 	unsigned swizzle_r_x;
 	uint64_t modifier_r_x;
 	uint64_t modifier_dcc_best;
@@ -5223,37 +5224,40 @@ add_gfx11_modifiers(struct amdgpu_device *adev,
 	num_pipes = 1 << REG_GET_FIELD(gb_addr_config, GB_ADDR_CONFIG, NUM_PIPES);
 	pipe_xor_bits = ilog2(num_pipes);
 
-	/* R_X swizzle modes are the best for rendering and DCC requires them. */
-	swizzle_r_x = num_pipes > 16 ? AMD_FMT_MOD_TILE_GFX11_256K_R_X :
-                                              AMD_FMT_MOD_TILE_GFX9_64K_R_X;
-
-	modifier_r_x = AMD_FMT_MOD |
-		AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX11) |
-		AMD_FMT_MOD_SET(TILE, swizzle_r_x) |
-		AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-		AMD_FMT_MOD_SET(PACKERS, pkrs);
-
-	/* DCC_CONSTANT_ENCODE is not set because it can't vary with gfx11 (it's implied to be 1). */
-	modifier_dcc_best = modifier_r_x |
-		AMD_FMT_MOD_SET(DCC, 1) |
-		AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 0) |
-		AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
-		AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B);
-
-	/* DCC settings for 4K and greater resolutions. (required by display hw) */
-	modifier_dcc_4k = modifier_r_x |
-			AMD_FMT_MOD_SET(DCC, 1) |
-			AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
-			AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
-			AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B);
-
-	add_modifier(mods, size, capacity, modifier_dcc_best);
-	add_modifier(mods, size, capacity, modifier_dcc_4k);
-
-	add_modifier(mods, size, capacity, modifier_dcc_best | AMD_FMT_MOD_SET(DCC_RETILE, 1));
-	add_modifier(mods, size, capacity, modifier_dcc_4k | AMD_FMT_MOD_SET(DCC_RETILE, 1));
-
-	add_modifier(mods, size, capacity, modifier_r_x);
+	for (i = 0; i < 2; i++) {
+		/* Insert the best one first. */
+		/* R_X swizzle modes are the best for rendering and DCC requires them. */
+		if (num_pipes > 16)
+			swizzle_r_x = !i ? AMD_FMT_MOD_TILE_GFX11_256K_R_X : AMD_FMT_MOD_TILE_GFX9_64K_R_X;
+		else
+			swizzle_r_x = !i ? AMD_FMT_MOD_TILE_GFX9_64K_R_X : AMD_FMT_MOD_TILE_GFX11_256K_R_X;
+
+		modifier_r_x = AMD_FMT_MOD |
+			       AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX11) |
+			       AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+			       AMD_FMT_MOD_SET(TILE, swizzle_r_x) |
+			       AMD_FMT_MOD_SET(PACKERS, pkrs);
+
+		/* DCC_CONSTANT_ENCODE is not set because it can't vary with gfx11 (it's implied to be 1). */
+		modifier_dcc_best = modifier_r_x | AMD_FMT_MOD_SET(DCC, 1) |
+				    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 0) |
+				    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
+				    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B);
+
+		/* DCC settings for 4K and greater resolutions. (required by display hw) */
+		modifier_dcc_4k = modifier_r_x | AMD_FMT_MOD_SET(DCC, 1) |
+				  AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+				  AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
+				  AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B);
+
+		add_modifier(mods, size, capacity, modifier_dcc_best);
+		add_modifier(mods, size, capacity, modifier_dcc_4k);
+
+		add_modifier(mods, size, capacity, modifier_dcc_best | AMD_FMT_MOD_SET(DCC_RETILE, 1));
+		add_modifier(mods, size, capacity, modifier_dcc_4k | AMD_FMT_MOD_SET(DCC_RETILE, 1));
+
+		add_modifier(mods, size, capacity, modifier_r_x);
+	}
 
 	add_modifier(mods, size, capacity, AMD_FMT_MOD |
              AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX11) |
-- 
2.36.1

