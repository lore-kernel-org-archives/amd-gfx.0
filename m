Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE436C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 22:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 566E010E710;
	Wed, 25 May 2022 22:02:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C1F10E710
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 22:02:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btTlTvcs5cL0h5a01NiSFIHx9s3TzOvGcNoF6dWBsiea3IUgwr4lRvUtaiR6deTLza0ZokGgKu3z/ibw00NtVuhqfyw7J588gA5DFU3MNE/NvfJdtPRXjVuxEZXblnsvOU2NLvlMIJYNLtRzsMVgWXdfnJ4YLnwMsAzZuPh+XEq2QtItL9EvpAE+eVyQPliEP1jXMrDlezXV5In/gZ2QFIPvIIKtHeEVE4gpFA2ERLKw70NzvrnNXnMPSQzKs1exRvyloaj+SIqEe7AF0AbW2lBg61uzmzEdVhBnQGXV/fITPA17fE3DleGXURcD8vptUxCRexHMwpGfLVarJnjGxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLk2x163sAryCQrryoL2ca6gjMlOrTrKTRHJnbKDle8=;
 b=PqG5vaKfGfE9J9rpWtFE5kVhAcgmnCF2l1Yb9+PyrZEiP8z8Duye8k5nXQlKwhcRnItHjA0SV15TvHm3cnFwVltJId2lSkIDJtfSlEXHbHpE0anlkeZSbh+bdVMGSlFv1WMr07CrSpgkT2K6lTqaBpDvxw3woSI+0Gjmzg5/6eyn39E4l9NKAO9p9SCHM25/+7EnSIgKV0CUZ5kUYrHUkwYV7xGNyYQBhJAjRC2Guw/2rL8Jtm3l3nAT4HXhfMoXpX0X8QzGEsi5HZj2uB6UJBGjDciWWUNEYdJNE+bAiUVxat0Sv4CRYNkegd5pAc8gqMUBgb3oTVW2n7W+1LCP3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLk2x163sAryCQrryoL2ca6gjMlOrTrKTRHJnbKDle8=;
 b=IdzcpvIDeAbbu9qsmkGbACTf4l2mVB+vfrC6R+i3paUB3UfZgliWOmtmL/Sp5A3OTICjIWB7f5LP1tpu3WYbyNrFs+nc6dfumkjvNXpzt9DDDMLXvia+Wsyw3cWRLOyfjAhKbu+AW2y+ania7Flg8lh0am3ogJE+NihYwh5Ftu4=
Received: from DM6PR11CA0050.namprd11.prod.outlook.com (2603:10b6:5:14c::27)
 by DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 22:02:51 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::22) by DM6PR11CA0050.outlook.office365.com
 (2603:10b6:5:14c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 22:02:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 22:02:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 17:02:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/43] drm/amd: Add GFX11 modifiers support to AMDGPU (v3)
Date: Wed, 25 May 2022 18:02:34 -0400
Message-ID: <20220525220234.2702378-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 289dbf4c-c468-4304-38d9-08da3e9a5048
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB5766C0E2164A786C00214089F7D69@DS7PR12MB5766.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rx56uOXpc3dYbuY79aky0Pppv1HZD7Gp0RlespVBRv8bhfXGcGPIPVeb1A2KuamLF/A6YgwTciS7Q+Vu9Tmpexz15jKRm7Q74yoXh7S1eZ/FmjkmXOLCe6q6H+11sVwuOX4m6zvJ+lki2RCpYEDJL3FgtkEWouA006K9OcpCwFevgTunsCe+7eYY0tdNwh7y8IswaiT15vM4XPvKS0ebAqcABIEZVe22qIMG6tADaqsCQ7TD3aaL6ewo+ngifYFMkLLc+R3zd7ORdR0q5NqIrnMUBSbTBnP8xnXL0XBQqk5W2IGpruK/hIuWEbWKEuq5ezvf/vJqsjIst/m3hx0pfoVx9e8vJM0Jv5rA4VnSZi4zecbKFGvpoOHUktHrtL8HoaRUHwl0x1398yG621cSPGLh4t00wfdXs8bOB8wsmjC3NFEo6gVrjZTIWiZTi7iFa1Y61w5xR0OCL06UbG/oman0rmhoy+P0W5DWQ6TlyOyKkwXGRjZYihaw+fMKhHAsVKQAK9SBnnlVG0yvtFN61hLCFJND0MpY5uFYSGb9LQeHXWBm8vL1TmvIPyzCAtq/RoEHzTiIoXVXN8rGRPlfuRSwPFenmuxT8VSgD/PoxS9cWThkXkuaMf+A1yqWQTN0Sv3r2bPZjn+j5IUa5laFjtSdo+6qPz07aNNgR6ShKlmD5JMAbSB89USnb1ZiSPyOPBZJ1S4BcwFGMDX2lLYG8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(83380400001)(508600001)(6666004)(7696005)(26005)(16526019)(316002)(186003)(82310400005)(1076003)(426003)(336012)(47076005)(2616005)(70586007)(4326008)(81166007)(86362001)(30864003)(40460700003)(54906003)(6916009)(8936002)(5660300002)(36756003)(356005)(2906002)(70206006)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 22:02:51.8205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 289dbf4c-c468-4304-38d9-08da3e9a5048
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5766
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
v3: keep Z tiling check

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 52 ++++++++++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 74 ++++++++++++++++++-
 include/uapi/drm/drm_fourcc.h                 |  2 +
 3 files changed, 116 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index ec395fe427f2..1a512d78673a 100644
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
@@ -706,19 +719,33 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
 		case 0: /* Z microtiling */
 			return -EINVAL;
 		case 1: /* S microtiling */
-			if (!has_xor)
-				version = AMD_FMT_MOD_TILE_VER_GFX9;
+			if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(11, 0, 0)) {
+				if (!has_xor)
+					version = AMD_FMT_MOD_TILE_VER_GFX9;
+			}
 			break;
 		case 2:
-			if (!has_xor && afb->base.format->cpp[0] != 4)
-				version = AMD_FMT_MOD_TILE_VER_GFX9;
+			if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(11, 0, 0)) {
+				if (!has_xor && afb->base.format->cpp[0] != 4)
+					version = AMD_FMT_MOD_TILE_VER_GFX9;
+			}
 			break;
 		case 3:
 			break;
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
@@ -752,9 +779,10 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
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
@@ -869,10 +897,11 @@ static unsigned int get_dcc_block_size(uint64_t modifier, bool rb_aligned,
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
 
@@ -965,6 +994,9 @@ static int amdgpu_display_verify_sizes(struct amdgpu_framebuffer *rfb)
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

