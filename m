Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAE3C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 21:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C24D710E3A8;
	Wed, 25 May 2022 21:26:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0660510E3A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 21:26:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGJrhvmUb0t2sIMDqub8PL+uyPPVOJln0+LL/3dZM8aMZrKG7/i4T1rgtip+EaOMc9BIsz/5fJ9QmipGF5+Hai8V/PywdHaKG01AAZ1PPrFFYOUQvDS7QG8g+ns+eU9Y46S0pOF4RWtNc5GI+UvtQhZfofa6XqDMH/u3QkvtEdFKSexfxckcNgSrOBb5pkBSUM3wBnHuzjMukkMr7WIGExw+tWZGLwcw+1rIdLv6l7ZWTTCMno/h+q4VEIFpAgR2d7n16eeCYuqq3jVGKwvOz1orHVvi2oygzEkUuaUowTo1K2O8iXuK1u0H8RUFJUDFXeM6lK37yFr4SEbmjTORVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUc2zoQegh5PZAL/CO9E+O9YN3H1vMF1VOHThOIOqHw=;
 b=i9GafKdNA7kkNMh5REvW57ZiBody8I7fbybBCYQK8yAFP0gUNLS+hInvR2rKTB55RebytRVKqJmza6yRsHYNLmJrQv3RLSn++RfLNp942NIq9/2tA8VmBc23KIQ8mcDLxmy+jWkC4t7uxXzZq0L00t0DcFJUiZgrAksKYWHH58aOM/bIC82SD5P44wF0jHM186kdsleGCzV4zfCVV4ypw681q0gjpRVJ03Rdu0HQiPW2AizVmwkk/SXpxXd/s013o4iJ1/lPTbG1lqPT+DNDvQHwrIzLpg9ixE+NO/WpiUkOqq/utZdjeeUMJwDro1Vn4SOYEEs1EowV2Hj0cJK38Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUc2zoQegh5PZAL/CO9E+O9YN3H1vMF1VOHThOIOqHw=;
 b=Dm+33Da+1NruCVnFnQ3v3gqIBU50FepLniuJ6N5Iq/XuVLJzHtHKHe6JG65KP+vEXSOwVdzCJhoyc2hQT8sg+5I0usOkJ0Ke8aUET+73Pps1fxNPVuwTu8HgcreCf9SCFSe23wIlct2gYG9cy3kEYFlc3ZMUgd53rMhxtLAQR4Y=
Received: from BN9PR03CA0449.namprd03.prod.outlook.com (2603:10b6:408:113::34)
 by CY4PR1201MB0007.namprd12.prod.outlook.com (2603:10b6:903:d4::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 21:26:07 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::78) by BN9PR03CA0449.outlook.office365.com
 (2603:10b6:408:113::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16 via Frontend
 Transport; Wed, 25 May 2022 21:26:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 21:26:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 16:26:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/43] drm/amd: Add GFX11 modifiers support to AMDGPU (v2)
Date: Wed, 25 May 2022 17:25:53 -0400
Message-ID: <20220525212553.2650477-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fc3c329-c142-4efb-2cbc-08da3e952e5d
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0007:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0007E89492D05F3E626C4710F7D69@CY4PR1201MB0007.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5CF+SFt81jrxWHkjLZkQ4ICNpSs6VBUsGwtUoywK+Y8Tx8ejEGxFPLfp+XX9N7GADpNXNxOK+/3WhlkR5BUdYij7MZXZfv6ZF8sz2OEUm8k0ZUyvcAi8pPPY2JLQGT2kymjetIJp1SMi30Ebkl1TaNmGpsY2hJZTkMFe6n7g/qIOImAQ9Y663ug9Hh6r+qeW+L7rJp4/j3sjOUKp8bJKnQLfkOiHHS89co6eZHZ+094lsDGiFS86EZ2r3lc6xf5GZGKqrdwoEC5Cr73pIBf2UnSRYV7yKq7ynms3OM470AsyZU0l4FipgCrT4hoNT5kHRsA5qFE+zaJzXkxVzDAOaqREw7sMHe7yhWQkavMiD8vdv6nT3KRl+7ODHKRKNpT36RKi77BEdswVqy3Dbt5aDZNNAC0XAz2u6B8HsJkEI8ex1TOVS2HFNT6dw5Og/aSAVBVaDHD1FypeL9hyF+LExN/T9zY1sNoDeUwvZ0sY0CWqRj4GNmgMD2rcXS5CtOMEOgujrFiGdd2IHEM9Hbnc7WuUedFNiJMBpkQHclzM1PvPbz4jPtEC/GC7xu+Jk53Byuds1UL8O7WfoLGo/aseOrU5FVSARBafrifzdO9npDqfl5H073gZcaaj7wtCcB6Nh8q6HukTdL5C1GeSjWDfYMv2idwhetHLRBZQ8bE7CPvY8/F5njzV+5M0QpvOp7snCMIJIas0kWb/CL5lljdV0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(40460700003)(86362001)(508600001)(2906002)(70586007)(70206006)(356005)(30864003)(4326008)(316002)(82310400005)(54906003)(36756003)(8936002)(81166007)(8676002)(47076005)(83380400001)(186003)(336012)(426003)(1076003)(2616005)(16526019)(6916009)(36860700001)(7696005)(26005)(6666004)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 21:26:07.4472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc3c329-c142-4efb-2cbc-08da3e952e5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0007
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

v2: microtiling fix noticed by Marek

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 68 ++++++++++++-----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 74 ++++++++++++++++++-
 include/uapi/drm/drm_fourcc.h                 |  2 +
 3 files changed, 123 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index ec395fe427f2..c90206dd6713 100644
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
@@ -690,35 +698,52 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
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
 		else
 			version = AMD_FMT_MOD_TILE_VER_GFX9;
 
-		switch (swizzle & 3) {
-		case 0: /* Z microtiling */
-			return -EINVAL;
-		case 1: /* S microtiling */
-			if (!has_xor)
-				version = AMD_FMT_MOD_TILE_VER_GFX9;
-			break;
-		case 2:
-			if (!has_xor && afb->base.format->cpp[0] != 4)
-				version = AMD_FMT_MOD_TILE_VER_GFX9;
-			break;
-		case 3:
-			break;
+		if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(11, 0, 0)) {
+			switch (swizzle & 3) {
+			case 0: /* Z microtiling */
+				return -EINVAL;
+			case 1: /* S microtiling */
+				if (!has_xor)
+					version = AMD_FMT_MOD_TILE_VER_GFX9;
+				break;
+			case 2:
+				if (!has_xor && afb->base.format->cpp[0] != 4)
+					version = AMD_FMT_MOD_TILE_VER_GFX9;
+				break;
+			case 3:
+				break;
+			}
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
@@ -752,9 +777,10 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
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
@@ -869,10 +895,11 @@ static unsigned int get_dcc_block_size(uint64_t modifier, bool rb_aligned,
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
 
@@ -965,6 +992,9 @@ static int amdgpu_display_verify_sizes(struct amdgpu_framebuffer *rfb)
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

