Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52BDC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3223510E677;
	Wed, 25 May 2022 16:20:30 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C96B10E70D
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jijErrpoKhTJD21gbzdJxCnTFeMfbPQG47ZC81Z2JrTECG/xsbulO3wh9XHPKHnIpxBbjLN7YfJEp8z92LDpiHmFs7bjgppmhhuJ5X2xaF83cnTbxN1zy/v5PGWg5xlQSbUOcji5JxqvV3Ss7IvTwDlLYKbhLl/QlkQptC3EBVFg8ydbOVMlTZU/BGfkLVC/dCxXUTrqpZ/WJUtF7QazPCWH7+IbMm6pyp1R2pT+Xm7qH6h9tRZH3pGD7jmNQAxlx9i58VbAWTLXQA23+vGdjfL6U6itCytQGC9marX4P/8ZtVa07rOVQ5ZSONHCQe7Gl2a1fpKmn92ekyd7hqp+vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxBGRYHudCxlZmUJCQzNnhjkvr10c7encI2oGxaGWLY=;
 b=TG09dBBXtUTEv80ZdyMlDOCGbrG+Ss4ixMHHV31ep6dPLAhRkGqRlVQeSINEbNKQlqKX35nCM3bYpKyjpw9fO1uHxi6VbsRc5xHWJevMS7PNfR3JHOanbfNZqGFEDYWMcYKiHiTR5l71D3ncx92R7ukHLron5z7+JUrefUqF385TgriamcGeTDHENc0lyqAM06Ej0wX0ynZ9YR8AQb6poy/IpAKiLqRkb0net8Vhu5UHUQNdNUI4e2gVddf49zjsEocGMFbOnEjH5eU3rkUU7r9oCb5sheuqsiVJtrBjgAXLZ7OIaMKMPAjgLCKNaywcAQLV1OLCs7cVz5a+/gQT/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxBGRYHudCxlZmUJCQzNnhjkvr10c7encI2oGxaGWLY=;
 b=WL1xJvi4lWhOrsVcJl6T9lGFIUuOuZMTgDI324s4A0mVIxJ8tbjDfzzLeyvXl/z/6ZhcqIzUlcbjml08b5U4AU3WxG9Q+wm76OvzumYPwoHF2xceKIKEsrSa+ArUWgs87R5SUZGBYchcntpYoyRoKJCUPdPKeRj+hLdVl00c2cc=
Received: from DS7PR05CA0101.namprd05.prod.outlook.com (2603:10b6:8:56::21) by
 CH2PR12MB3768.namprd12.prod.outlook.com (2603:10b6:610:22::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Wed, 25 May 2022 16:20:13 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::66) by DS7PR05CA0101.outlook.office365.com
 (2603:10b6:8:56::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 16:20:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/43] drm/amd: Add GFX11 modifiers support to AMDGPU
Date: Wed, 25 May 2022 12:19:12 -0400
Message-ID: <20220525161941.2544055-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 716c6b1d-4fa8-42b0-00a9-08da3e6a7241
X-MS-TrafficTypeDiagnostic: CH2PR12MB3768:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3768CE14B3E1810951FF4F0EF7D69@CH2PR12MB3768.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4hKB3MObjIDaiH/hoxM+1nw+cAwOYCO/OID6C5SsK4VMmoW/vrW5QgeTXHfCAlx+a98ObUHip+TD3wT7YH86Ihr1+LvMuyKZhA/9W2c+2VM3lM8i/AF8vMz29AkyuMSHIyKAegE6iU4s12G47eN+6ICzlVhq9hiz8Am9hVrxX8H2n6LRi5perL64wgMEUj41yyoC/Wqu3kv6hqAsrD4kPn6uJycYXdIzUUOiGs7iBiaOhFZoTvNl7rs3fy8W6N+ax52RF7cyuyfrmbhJdpkcoK4ApfPAAs1Tf4aUqIQimi/Ox4VOQw3JCF93slDbN4Pn9WFIXhhJ9P1w0oOu6kIcVcS9fFxVS25No/RJIrGtqu1zNtbXadQTyzsU+6nhCMnwIGtFW69yRud7V/hrsCA7Rm/SSKJQWlwk2m4P8FziEPhGA0PIBp927EicF+j6wexjS8BEwa8yazreGOSeOQw3nK0wVrurV075XT1Bqi1VAODXFleNuI2g7LLSzVYcF1kmhjQFCjTNbgtxX1GofQu0UrGsG3P7YaoEFAqLBxpUHRt0EdtBQCTYVQWPz6bLjG7L9wysZwlRSIHNdM46nocVLGSRZlrr9/D3jK5cWOsns78QMd2jfYYS40UnTdYXuEgMjSeG8QgMNlah7W65zpA8kpIuo3G65xTgI/8fMhh6bwkWJORvHUaNwKZff9qvbaJGzMNDT3xvDdMtgsPBlZcChw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6916009)(81166007)(316002)(356005)(5660300002)(426003)(54906003)(30864003)(2906002)(4326008)(70206006)(70586007)(8676002)(8936002)(7696005)(83380400001)(47076005)(2616005)(40460700003)(1076003)(336012)(186003)(16526019)(508600001)(26005)(6666004)(36860700001)(36756003)(86362001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:12.9570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 716c6b1d-4fa8-42b0-00a9-08da3e6a7241
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3768
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

GFX11 IP introduces new tiling mode. Various combinations of DCC
settings are possible and the most preferred settings must be exposed
for optimal use of the hardware.

add_gfx11_modifiers() is based on recommendation from Marek for the
preferred tiling modifier that are most efficient for the hardware.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 40 ++++++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 74 ++++++++++++++++++-
 include/uapi/drm/drm_fourcc.h                 |  2 +
 3 files changed, 108 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index ec395fe427f2..a54081a89282 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -30,6 +30,9 @@
 #include "atom.h"
 #include "amdgpu_connectors.h"
 #include "amdgpu_display.h"
+#include "soc15_common.h"
+#include "gc/gc_11_0_0_offset.h"
+#include "gc/gc_11_0_0_sh_mask.h"
 #include <asm/div64.h>
 
 #include <linux/pci.h>
@@ -662,6 +665,11 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
 {
 	struct amdgpu_device *adev = drm_to_adev(afb->base.dev);
 	uint64_t modifier = 0;
+	int num_pipes = 0;
+	int num_pkrs = 0;
+
+	num_pkrs = adev->gfx.config.gb_addr_config_fields.num_pkrs;
+	num_pipes = adev->gfx.config.gb_addr_config_fields.num_pipes;
 
 	if (!afb->tiling_flags || !AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE)) {
 		modifier = DRM_FORMAT_MOD_LINEAR;
@@ -674,7 +682,7 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
 		int bank_xor_bits = 0;
 		int packers = 0;
 		int rb = 0;
-		int pipes = ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes);
+		int pipes = ilog2(num_pipes);
 		uint32_t dcc_offset = AMDGPU_TILING_GET(afb->tiling_flags, DCC_OFFSET_256B);
 
 		switch (swizzle >> 2) {
@@ -690,12 +698,17 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
 		case 6: /* 64 KiB _X */
 			block_size_bits = 16;
 			break;
+		case 7: /* 256 KiB */
+			block_size_bits = 18;
+			break;
 		default:
 			/* RESERVED or VAR */
 			return -EINVAL;
 		}
 
-		if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 3, 0))
+		if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(11, 0, 0))
+			version = AMD_FMT_MOD_TILE_VER_GFX11;
+		else if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 3, 0))
 			version = AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS;
 		else if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 0, 0))
 			version = AMD_FMT_MOD_TILE_VER_GFX10;
@@ -718,7 +731,17 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
 		}
 
 		if (has_xor) {
+			if (num_pipes == num_pkrs && num_pkrs == 0) {
+				DRM_ERROR("invalid number of pipes and packers\n");
+				return -EINVAL;
+			}
+
 			switch (version) {
+			case AMD_FMT_MOD_TILE_VER_GFX11:
+				pipe_xor_bits = min(block_size_bits - 8, pipes);
+				packers = min(block_size_bits - 8 - pipe_xor_bits,
+						ilog2(adev->gfx.config.gb_addr_config_fields.num_pkrs));
+				break;
 			case AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS:
 				pipe_xor_bits = min(block_size_bits - 8, pipes);
 				packers = min(block_size_bits - 8 - pipe_xor_bits,
@@ -752,9 +775,10 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
 			u64 render_dcc_offset;
 
 			/* Enable constant encode on RAVEN2 and later. */
-			bool dcc_constant_encode = adev->asic_type > CHIP_RAVEN ||
+			bool dcc_constant_encode = (adev->asic_type > CHIP_RAVEN ||
 						   (adev->asic_type == CHIP_RAVEN &&
-						    adev->external_rev_id >= 0x81);
+						    adev->external_rev_id >= 0x81)) &&
+						    adev->ip_versions[GC_HWIP][0] < IP_VERSION(11, 0, 0);
 
 			int max_cblock_size = dcc_i64b ? AMD_FMT_MOD_DCC_BLOCK_64B :
 					      dcc_i128b ? AMD_FMT_MOD_DCC_BLOCK_128B :
@@ -869,10 +893,11 @@ static unsigned int get_dcc_block_size(uint64_t modifier, bool rb_aligned,
 		return max(10 + (rb_aligned ? (int)AMD_FMT_MOD_GET(RB, modifier) : 0), 12);
 	}
 	case AMD_FMT_MOD_TILE_VER_GFX10:
-	case AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS: {
+	case AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS:
+	case AMD_FMT_MOD_TILE_VER_GFX11: {
 		int pipes_log2 = AMD_FMT_MOD_GET(PIPE_XOR_BITS, modifier);
 
-		if (ver == AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS && pipes_log2 > 1 &&
+		if (ver >= AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS && pipes_log2 > 1 &&
 		    AMD_FMT_MOD_GET(PACKERS, modifier) == pipes_log2)
 			++pipes_log2;
 
@@ -965,6 +990,9 @@ static int amdgpu_display_verify_sizes(struct amdgpu_framebuffer *rfb)
 			case DC_SW_64KB_S_X:
 				block_size_log2 = 16;
 				break;
+			case DC_SW_VAR_S_X:
+				block_size_log2 = 18;
+				break;
 			default:
 				drm_dbg_kms(rfb->base.dev,
 					    "Swizzle mode with unknown block size: %d\n", swizzle);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a93affc37c53..badd136f5686 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -88,10 +88,14 @@
 #include "dcn/dcn_1_0_offset.h"
 #include "dcn/dcn_1_0_sh_mask.h"
 #include "soc15_hw_ip.h"
+#include "soc15_common.h"
 #include "vega10_ip_offset.h"
 
 #include "soc15_common.h"
 
+#include "gc/gc_11_0_0_offset.h"
+#include "gc/gc_11_0_0_sh_mask.h"
+
 #include "modules/inc/mod_freesync.h"
 #include "modules/power/power_helpers.h"
 #include "modules/inc/mod_info_packet.h"
@@ -4885,7 +4889,9 @@ fill_gfx9_tiling_info_from_modifier(const struct amdgpu_device *adev,
 	unsigned int mod_bank_xor_bits = AMD_FMT_MOD_GET(BANK_XOR_BITS, modifier);
 	unsigned int mod_pipe_xor_bits = AMD_FMT_MOD_GET(PIPE_XOR_BITS, modifier);
 	unsigned int pkrs_log2 = AMD_FMT_MOD_GET(PACKERS, modifier);
-	unsigned int pipes_log2 = min(4u, mod_pipe_xor_bits);
+	unsigned int pipes_log2;
+
+	pipes_log2 = min(5u, mod_pipe_xor_bits);
 
 	fill_gfx9_tiling_info_from_device(adev, tiling_info);
 
@@ -5221,6 +5227,67 @@ add_gfx10_3_modifiers(const struct amdgpu_device *adev,
 		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
 }
 
+static void
+add_gfx11_modifiers(const struct amdgpu_device *adev,
+		      uint64_t **mods, uint64_t *size, uint64_t *capacity)
+{
+	int num_pipes = 0;
+	int pipe_xor_bits = 0;
+	int num_pkrs = 0;
+	int pkrs = 0;
+	u32 gb_addr_config;
+	unsigned swizzle_r_x;
+	uint64_t modifier_r_x;
+	uint64_t modifier_dcc_best;
+	uint64_t modifier_dcc_4k;
+
+	/* TODO: GFX11 IP HW init hasnt finish and we get zero if we read from
+	 * adev->gfx.config.gb_addr_config_fields.num_{pkrs,pipes} */
+	gb_addr_config = RREG32_SOC15(GC, 0, regGB_ADDR_CONFIG);
+	ASSERT(gb_addr_config != 0);
+
+	num_pkrs = 1 << REG_GET_FIELD(gb_addr_config, GB_ADDR_CONFIG, NUM_PKRS);
+	pkrs = ilog2(num_pkrs);
+	num_pipes = 1 << REG_GET_FIELD(gb_addr_config, GB_ADDR_CONFIG, NUM_PIPES);
+	pipe_xor_bits = ilog2(num_pipes);
+
+    /* R_X swizzle modes are the best for rendering and DCC requires them. */
+    swizzle_r_x = num_pipes > 16 ? AMD_FMT_MOD_TILE_GFX11_256K_R_X :
+                                              AMD_FMT_MOD_TILE_GFX9_64K_R_X;
+
+	modifier_r_x = AMD_FMT_MOD |
+                            AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX11) |
+                            AMD_FMT_MOD_SET(TILE, swizzle_r_x) |
+                            AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+                            AMD_FMT_MOD_SET(PACKERS, pkrs);
+
+    /* DCC_CONSTANT_ENCODE is not set because it can't vary with gfx11 (it's implied to be 1). */
+	modifier_dcc_best = modifier_r_x |
+                            AMD_FMT_MOD_SET(DCC, 1) |
+                            AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 0) |
+                            AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
+                            AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B);
+
+    /* DCC settings for 4K and greater resolutions. (required by display hw) */
+	modifier_dcc_4k = modifier_r_x |
+                            AMD_FMT_MOD_SET(DCC, 1) |
+                            AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+                            AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
+                            AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B);
+
+	add_modifier(mods, size, capacity, modifier_dcc_best);
+	add_modifier(mods, size, capacity, modifier_dcc_4k);
+
+	add_modifier(mods, size, capacity, modifier_dcc_best | AMD_FMT_MOD_SET(DCC_RETILE, 1));
+	add_modifier(mods, size, capacity, modifier_dcc_4k | AMD_FMT_MOD_SET(DCC_RETILE, 1));
+
+	add_modifier(mods, size, capacity, modifier_r_x);
+
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+             AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX11) |
+			 AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D));
+}
+
 static int
 get_plane_modifiers(const struct amdgpu_device *adev, unsigned int plane_type, uint64_t **mods)
 {
@@ -5254,6 +5321,9 @@ get_plane_modifiers(const struct amdgpu_device *adev, unsigned int plane_type, u
 		else
 			add_gfx10_1_modifiers(adev, mods, &size, &capacity);
 		break;
+	case AMDGPU_FAMILY_GC_11_0_0:
+		add_gfx11_modifiers(adev, mods, &size, &capacity);
+		break;
 	}
 
 	add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_LINEAR);
@@ -5292,7 +5362,7 @@ fill_gfx9_plane_attributes_from_modifiers(struct amdgpu_device *adev,
 		dcc->enable = 1;
 		dcc->meta_pitch = afb->base.pitches[1];
 		dcc->independent_64b_blks = independent_64b_blks;
-		if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) == AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) {
+		if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) >= AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) {
 			if (independent_64b_blks && independent_128b_blks)
 				dcc->dcc_ind_blk = hubp_ind_block_64b_no_128bcl;
 			else if (independent_128b_blks)
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index fc0c1454d275..14cb2dafb0fa 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -1294,6 +1294,7 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
 #define AMD_FMT_MOD_TILE_VER_GFX9 1
 #define AMD_FMT_MOD_TILE_VER_GFX10 2
 #define AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS 3
+#define AMD_FMT_MOD_TILE_VER_GFX11 4
 
 /*
  * 64K_S is the same for GFX9/GFX10/GFX10_RBPLUS and hence has GFX9 as canonical
@@ -1309,6 +1310,7 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
 #define AMD_FMT_MOD_TILE_GFX9_64K_S_X 25
 #define AMD_FMT_MOD_TILE_GFX9_64K_D_X 26
 #define AMD_FMT_MOD_TILE_GFX9_64K_R_X 27
+#define AMD_FMT_MOD_TILE_GFX11_256K_R_X 31
 
 #define AMD_FMT_MOD_DCC_BLOCK_64B 0
 #define AMD_FMT_MOD_DCC_BLOCK_128B 1
-- 
2.35.3

