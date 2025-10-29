Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D2DCCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:56:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9720810E819;
	Wed, 29 Oct 2025 17:56:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yPMGbtKW";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95BCD10E819
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:56:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgHI7BGTT2mX8ydChEOYPMSmmz+hGMBFHkCUgFrcQkrLHHyVnsu11tFA8MzNRjYwtsI4ORNKdkmT4X4/Rid5DikrvwhYy9h4uvq0+Nw1lOydQZyOIgiwGUyhFxac6tNAmsuUfsl/uiEB5XplOsh8R4WfoPVj3QqhUQsOmuK/mVxbLt2NFkxSSFQCvM1EszQiTv5YEnbUXzTUpI3bFQXv1Zt4cmkcSuuwniY0HiYbnFEi+6vkw/2LXdzL/ny3SVvWMALclR3dRMhaOVoTGG7KUsPg+PpcqZQv9Or4+hasrNTT/CqQzw2p2uoIttxQ2DE5s7Bz7ZI7QkX6jm18HyCR1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/T90RAXj2IGuIsZhhYNJZm8+Tx63LSiKXzEz1MPLLo=;
 b=H7Bz26itjRPJb4U8Dj0J9WWSiXEGdbD1zG6eDHjXpZWkmpf/3qH4X7wEzUAc+9LQ3gvGxM2Fk4LtGdirPFKtLgwGH0hw3HiRKfnx89NehWH1QRk2Xsun7NcsvC7ENQcszt5leHEfEn4suhI+3crFV8A6Y8bt3bHX55UHJWYDFzxlUcBJMixKmaevkQM2QZ+M8ASY4HKLaxU4xiVkAvCkY2P0ICKLyin74EGggSKlYICgYEfiFgxAzk2NKcxnFhPfBwg0y34EteN1QgnvuvgPkThJeonmUMqUImIEK+wLVaQv/iCnJ0Aub3TPT9hDzmCwIETLa8FkCs7+anVuzWVQ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/T90RAXj2IGuIsZhhYNJZm8+Tx63LSiKXzEz1MPLLo=;
 b=yPMGbtKWie71/PbxKHIc1PXoL7GVpAXmZ0hmIqwy4ATIGrZS56+TAZds19OoitbQtjxGqgugiqu5zgzqJZJj4CKcOKaEKos/EgSV9jwmho/jPKxd8jlGzweVT7zep5oi60+mgXRFzTln0K+ZjCu/R6It4BbP09SymGLOnl3GSAA=
Received: from BN9PR03CA0652.namprd03.prod.outlook.com (2603:10b6:408:13b::27)
 by DS2PR12MB9773.namprd12.prod.outlook.com (2603:10b6:8:2b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 17:56:19 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::9e) by BN9PR03CA0652.outlook.office365.com
 (2603:10b6:408:13b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 17:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:56:19 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:56:14 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Feifei Xu <Feifei.Xu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 4/6] drm/amdgpu: Add rlcv firmware for frontdoor loading.
Date: Wed, 29 Oct 2025 13:55:55 -0400
Message-ID: <20251029175557.2862156-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029175557.2862156-1-alexander.deucher@amd.com>
References: <20251029175557.2862156-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|DS2PR12MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: 69672997-806d-4880-5351-08de171476a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MP2Y9XaesWe6tsuxFUoqFDSOcyRiciBKIkSwcb7Nfn08rwa8mT4x78Czs8wJ?=
 =?us-ascii?Q?Ce4JwT1JxT2bh8tW6mG7CbHB9rfOVtENyikEYr+pDRXCCct6kUB6DhC/CGko?=
 =?us-ascii?Q?fmGqqnqtgJHPqxOe6S5aZXCSLFUApijjYsvMpE3n8ciR549bHIJAoCOOT8yW?=
 =?us-ascii?Q?8Rb7J3+ADrtOQv6sJhlMTuNVlCCgTTwzSfbGzDDaium9kZoZnntLt7CCCDxY?=
 =?us-ascii?Q?5bYjEaKu39N2a9VH9K9zGRkLmZxnB82+agueGvLIeXmQnFx+JjiDZ7wu10vh?=
 =?us-ascii?Q?xNjAovd7YS1H/wr9+72PfknNiYdbDCqR0abWaJrwEpq2rRcJNTQb5EdL3u/1?=
 =?us-ascii?Q?RqD4+uR2sDYxa9xlz0NkaEf+6FeFPz2UENkgyY2W7FGwaIU8+qp3Ce0YciQ+?=
 =?us-ascii?Q?1E4HQgSC9t+A8ibZYFzkmZJSPp8S2bXoFK/ga5gH7rbzyJemRA94hmaBEWhr?=
 =?us-ascii?Q?Oxa6U2GLPVsgov3kzAtNqCXjpnIY1s9PI61T5zXGTtgWDmadoyHkytl3mFG0?=
 =?us-ascii?Q?rUDaX6jb/Oaew5o1zPC1DF6J+e6bGp2Vr0L8vjySWZkPCi4tvEaHvALNRoUk?=
 =?us-ascii?Q?oE/dCTfND0tlncdmUq7fQEk1SnfUGg7pxA3PpZV+cgMETRhalhBNCu1Xfa45?=
 =?us-ascii?Q?B6tJXl7N2Mp0ObTkfY9wE0E01zsB1OD1ODkaxrGS+DompYw1+WXinnqkJNEv?=
 =?us-ascii?Q?uNsXWm5aimwQxeBzzyQp6v3bMLmPyj9NKqVrmFWT/wQ5V50I9yjhuYcxedp1?=
 =?us-ascii?Q?CpAFraVUoJyRC7vIGOINmpzXKPY2wE7OlfLOIBoNAqx6slmAk4cRIGjpNzAs?=
 =?us-ascii?Q?Jz4uj4oUaS+poVdeg/+zUYeLfTu3rvrTtyAn2vpVX2ZbuC9+PvtIg0ehj7AC?=
 =?us-ascii?Q?JscOKJmOwK9ORsVTTJK5tmEzMWutXcfF43/YokhNgNeqFBmB1j8MpJig+F76?=
 =?us-ascii?Q?8Kg46jO8ps39UaqizgXLSlp733V7m7SCGO17SWI5PxJOnlM3faIJoxAiNYyM?=
 =?us-ascii?Q?iU3M6PCeoE5+aBOd1YOLYJBe/NEjl7B3HsbQqZMCgTq7n5BEnOFaat+oBQII?=
 =?us-ascii?Q?Ifz10tpys4U9mjX5ySn7AS6Qvad+X+z+yj/ppKa0UqFPzUv/z996kStoUwDN?=
 =?us-ascii?Q?zEkK5MQSFiXT64vDcds3+uoWG/5WgsMRu9JNRXAeQ31SB/OThvkIljSxenIT?=
 =?us-ascii?Q?kPstOMJwWbJWyClOLULbD1eyE+QWGCPjLW20OUCQho9ULrKnMlYoIUFJxLQt?=
 =?us-ascii?Q?kgHGWWv/aIqcll1gtxtVt3Jd+trBIPs7fwZ4IUKsmXsbipBJCtOJ0R9sjH8A?=
 =?us-ascii?Q?zAgg4f5WgmWoxGlF9xLej5oYF8LVq51ndbuUdhqmHk3qgP9zbbotyTdAsOHk?=
 =?us-ascii?Q?SKBrMXaShaBs/i37P5rZ8XsUzuVcAxBPGXe0G23SI8CMPGs5tUHpzSg95jla?=
 =?us-ascii?Q?QOS1AUn6cHgy8ocCZ6lboek2ouAvRsFcr2OTBW/bOX6ii2ev20FfynHCk7ZP?=
 =?us-ascii?Q?/arOr8LVrwYzzD5uNN8I0Wr355evr1UiicLtDHL990tP96V7rh4jcMwzd76F?=
 =?us-ascii?Q?KfZkxC4Cp6ypk4wWJ6M=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:56:19.0220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69672997-806d-4880-5351-08de171476a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9773
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

From: Feifei Xu <Feifei.Xu@amd.com>

Rlcv is required to be loaded for frontdoor.

1. Add 2 rlcv ucode ids:
    AMDGPU_UCODE_RLC_IRAM_1 and AMDGPU_UCODE_RLC_DRAM_1

2. Add rlc_firmware_header_v2_5 for above 2 rlcv headers.

3. Add 2 types in psp_fw_gfx_if interface interacting with asp:
    GFX_FW_TYPE_RLX6_UCODE_CORE1 - RLCV IRAM
    GFX_FW_TYPE_RLX6_DRAM_BOOT_CORE1 - RLCV DRAM BOOT

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   |  8 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c   | 37 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h   |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 34 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 12 ++++++++
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h   |  2 ++
 6 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index bf9a76289f537..b17004c190d90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2708,6 +2708,12 @@ static int psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 	case AMDGPU_UCODE_ID_RLC_DRAM:
 		*type = GFX_FW_TYPE_RLC_DRAM_BOOT;
 		break;
+	case AMDGPU_UCODE_ID_RLC_IRAM_1:
+		*type = GFX_FW_TYPE_RLX6_UCODE_CORE1;
+		break;
+	case AMDGPU_UCODE_ID_RLC_DRAM_1:
+		*type = GFX_FW_TYPE_RLX6_DRAM_BOOT_CORE1;
+		break;
 	case AMDGPU_UCODE_ID_GLOBAL_TAP_DELAYS:
 		*type = GFX_FW_TYPE_GLOBAL_TAP_DELAYS;
 		break;
@@ -2876,6 +2882,8 @@ static void psp_print_fw_hdr(struct psp_context *psp,
 		amdgpu_ucode_print_gfx_hdr(hdr);
 		break;
 	case AMDGPU_UCODE_ID_RLC_G:
+	case AMDGPU_UCODE_ID_RLC_DRAM_1:
+	case AMDGPU_UCODE_ID_RLC_IRAM_1:
 		hdr = (struct common_firmware_header *)adev->gfx.rlc_fw->data;
 		amdgpu_ucode_print_rlc_hdr(hdr);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index 5aa830a02d80b..572a60e1b3cbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -515,6 +515,40 @@ static void amdgpu_gfx_rlc_init_microcode_v2_4(struct amdgpu_device *adev)
 	}
 }
 
+static void amdgpu_gfx_rlc_init_microcode_v2_5(struct amdgpu_device *adev)
+{
+	const struct rlc_firmware_header_v2_5 *rlc_hdr;
+	struct amdgpu_firmware_info *info;
+
+	rlc_hdr = (const struct rlc_firmware_header_v2_5 *)adev->gfx.rlc_fw->data;
+	adev->gfx.rlc.rlc_1_iram_ucode_size_bytes =
+		le32_to_cpu(rlc_hdr->rlc_1_iram_ucode_size_bytes);
+	adev->gfx.rlc.rlc_1_iram_ucode = (u8 *)rlc_hdr +
+		le32_to_cpu(rlc_hdr->rlc_1_iram_ucode_offset_bytes);
+	adev->gfx.rlc.rlc_1_dram_ucode_size_bytes =
+		le32_to_cpu(rlc_hdr->rlc_1_dram_ucode_size_bytes);
+	adev->gfx.rlc.rlc_1_dram_ucode = (u8 *)rlc_hdr +
+		le32_to_cpu(rlc_hdr->rlc_1_dram_ucode_offset_bytes);
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		if (adev->gfx.rlc.rlc_1_iram_ucode_size_bytes) {
+			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_IRAM_1];
+			info->ucode_id = AMDGPU_UCODE_ID_RLC_IRAM_1;
+			info->fw = adev->gfx.rlc_fw;
+			adev->firmware.fw_size +=
+				ALIGN(adev->gfx.rlc.rlc_1_iram_ucode_size_bytes, PAGE_SIZE);
+		}
+
+		if (adev->gfx.rlc.rlc_1_dram_ucode_size_bytes) {
+			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_DRAM_1];
+			info->ucode_id = AMDGPU_UCODE_ID_RLC_DRAM_1;
+			info->fw = adev->gfx.rlc_fw;
+			adev->firmware.fw_size +=
+				ALIGN(adev->gfx.rlc.rlc_1_dram_ucode_size_bytes, PAGE_SIZE);
+		}
+	}
+}
+
 int amdgpu_gfx_rlc_init_microcode(struct amdgpu_device *adev,
 				  uint16_t version_major,
 				  uint16_t version_minor)
@@ -545,6 +579,7 @@ int amdgpu_gfx_rlc_init_microcode(struct amdgpu_device *adev,
 		amdgpu_gfx_rlc_init_microcode_v2_3(adev);
 	if (version_minor == 4)
 		amdgpu_gfx_rlc_init_microcode_v2_4(adev);
-
+	if (version_minor == 5)
+		amdgpu_gfx_rlc_init_microcode_v2_5(adev);
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 3e2d2e333907d..32408574548dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -311,6 +311,8 @@ struct amdgpu_rlc {
 	u32 save_restore_list_srm_size_bytes;
 	u32 rlc_iram_ucode_size_bytes;
 	u32 rlc_dram_ucode_size_bytes;
+	u32 rlc_1_iram_ucode_size_bytes;
+	u32 rlc_1_dram_ucode_size_bytes;
 	u32 rlcp_ucode_size_bytes;
 	u32 rlcv_ucode_size_bytes;
 	u32 global_tap_delays_ucode_size_bytes;
@@ -326,6 +328,8 @@ struct amdgpu_rlc {
 	u8 *save_restore_list_srm;
 	u8 *rlc_iram_ucode;
 	u8 *rlc_dram_ucode;
+	u8 *rlc_1_iram_ucode;
+	u8 *rlc_1_dram_ucode;
 	u8 *rlcp_ucode;
 	u8 *rlcv_ucode;
 	u8 *global_tap_delays_ucode;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index e96f24e9ad571..1ab61e7b35db6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -166,6 +166,8 @@ void amdgpu_ucode_print_rlc_hdr(const struct common_firmware_header *hdr)
 			container_of(rlc_hdr_v2_2, struct rlc_firmware_header_v2_3, v2_2);
 		const struct rlc_firmware_header_v2_4 *rlc_hdr_v2_4 =
 			container_of(rlc_hdr_v2_3, struct rlc_firmware_header_v2_4, v2_3);
+		const struct rlc_firmware_header_v2_5 *rlc_hdr_v2_5 =
+			container_of(rlc_hdr_v2_2, struct rlc_firmware_header_v2_5, v2_2);
 
 		switch (version_minor) {
 		case 0:
@@ -287,6 +289,26 @@ void amdgpu_ucode_print_rlc_hdr(const struct common_firmware_header *hdr)
 			DRM_DEBUG("se3_tap_delays_ucode_offset_bytes: %u\n",
 				  le32_to_cpu(rlc_hdr_v2_4->se3_tap_delays_ucode_offset_bytes));
 			break;
+		case 5:
+			/* rlc_hdr v2_5 */
+			DRM_INFO("rlc_iram_ucode_size_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_5->v2_2.rlc_iram_ucode_size_bytes));
+			DRM_INFO("rlc_iram_ucode_offset_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_5->v2_2.rlc_iram_ucode_offset_bytes));
+			DRM_INFO("rlc_dram_ucode_size_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_5->v2_2.rlc_dram_ucode_size_bytes));
+			DRM_INFO("rlc_dram_ucode_offset_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_5->v2_2.rlc_dram_ucode_offset_bytes));
+			/* rlc_hdr v2_5 */
+			DRM_INFO("rlc_1_iram_ucode_size_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_5->rlc_1_iram_ucode_size_bytes));
+			DRM_INFO("rlc_1_iram_ucode_offset_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_5->rlc_1_iram_ucode_offset_bytes));
+			DRM_INFO("rlc_1_dram_ucode_size_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_5->rlc_1_dram_ucode_size_bytes));
+			DRM_INFO("rlc_1_dram_ucode_offset_bytes: %u\n",
+				  le32_to_cpu(rlc_hdr_v2_5->rlc_1_dram_ucode_offset_bytes));
+			break;
 		default:
 			DRM_ERROR("Unknown RLC v2 ucode: v2.%u\n", version_minor);
 			break;
@@ -631,6 +653,10 @@ const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID ucode_id)
 		return "RLC_IRAM";
 	case AMDGPU_UCODE_ID_RLC_DRAM:
 		return "RLC_DRAM";
+	case AMDGPU_UCODE_ID_RLC_IRAM_1:
+		return "RLC_IRAM_1";
+	case AMDGPU_UCODE_ID_RLC_DRAM_1:
+		return "RLC_DRAM_1";
 	case AMDGPU_UCODE_ID_RLC_G:
 		return "RLC_G";
 	case AMDGPU_UCODE_ID_RLC_P:
@@ -911,6 +937,14 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 			ucode->ucode_size = adev->gfx.rlc.rlc_dram_ucode_size_bytes;
 			ucode_addr = adev->gfx.rlc.rlc_dram_ucode;
 			break;
+		case AMDGPU_UCODE_ID_RLC_IRAM_1:
+			ucode->ucode_size = adev->gfx.rlc.rlc_1_iram_ucode_size_bytes;
+			ucode_addr = adev->gfx.rlc.rlc_1_iram_ucode;
+			break;
+		case AMDGPU_UCODE_ID_RLC_DRAM_1:
+			ucode->ucode_size = adev->gfx.rlc.rlc_1_dram_ucode_size_bytes;
+			ucode_addr = adev->gfx.rlc.rlc_1_dram_ucode;
+			break;
 		case AMDGPU_UCODE_ID_RLC_P:
 			ucode->ucode_size = adev->gfx.rlc.rlcp_ucode_size_bytes;
 			ucode_addr = adev->gfx.rlc.rlcp_ucode;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 6349aad6da35b..f316776fe950a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -300,6 +300,15 @@ struct rlc_firmware_header_v2_4 {
     uint32_t se3_tap_delays_ucode_offset_bytes;
 };
 
+/* version_major=2, version_minor=5 */
+struct rlc_firmware_header_v2_5 {
+	struct rlc_firmware_header_v2_2 v2_2;
+	uint32_t rlc_1_iram_ucode_size_bytes;
+	uint32_t rlc_1_iram_ucode_offset_bytes;
+	uint32_t rlc_1_dram_ucode_size_bytes;
+	uint32_t rlc_1_dram_ucode_offset_bytes;
+};
+
 /* version_major=1, version_minor=0 */
 struct sdma_firmware_header_v1_0 {
 	struct common_firmware_header header;
@@ -449,6 +458,7 @@ union amdgpu_firmware_header {
 	struct rlc_firmware_header_v2_2 rlc_v2_2;
 	struct rlc_firmware_header_v2_3 rlc_v2_3;
 	struct rlc_firmware_header_v2_4 rlc_v2_4;
+	struct rlc_firmware_header_v2_5 rlc_v2_5;
 	struct sdma_firmware_header_v1_0 sdma;
 	struct sdma_firmware_header_v1_1 sdma_v1_1;
 	struct sdma_firmware_header_v2_0 sdma_v2_0;
@@ -512,6 +522,8 @@ enum AMDGPU_UCODE_ID {
 	AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM,
 	AMDGPU_UCODE_ID_RLC_IRAM,
 	AMDGPU_UCODE_ID_RLC_DRAM,
+	AMDGPU_UCODE_ID_RLC_IRAM_1,
+	AMDGPU_UCODE_ID_RLC_DRAM_1,
 	AMDGPU_UCODE_ID_RLC_P,
 	AMDGPU_UCODE_ID_RLC_V,
 	AMDGPU_UCODE_ID_RLC_G,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index 73f87131a7e9f..e8f768638fd59 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -299,6 +299,8 @@ enum psp_gfx_fw_type {
 	GFX_FW_TYPE_RS64_MEC_P1_STACK               = 95,   /* RS64 MEC stack P1        SOC21   */
 	GFX_FW_TYPE_RS64_MEC_P2_STACK               = 96,   /* RS64 MEC stack P2        SOC21   */
 	GFX_FW_TYPE_RS64_MEC_P3_STACK               = 97,   /* RS64 MEC stack P3        SOC21   */
+	GFX_FW_TYPE_RLX6_UCODE_CORE1                = 98,   /* RLCV_IRAM                MI      */
+	GFX_FW_TYPE_RLX6_DRAM_BOOT_CORE1            = 99,   /* RLCV DRAM BOOT           MI      */
 	GFX_FW_TYPE_VPEC_FW1                        = 100,  /* VPEC FW1 To Save         VPE     */
 	GFX_FW_TYPE_VPEC_FW2                        = 101,  /* VPEC FW2 To Save         VPE     */
 	GFX_FW_TYPE_VPE                             = 102,
-- 
2.51.0

