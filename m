Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60574C624D3
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2026 10:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF94F10E5E4;
	Sat,  5 Sep 2026 10:06:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="do0bn8ph";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011042.outbound.protection.outlook.com [52.101.57.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3986D10E5E3
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2026 10:06:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjJBOcOmprLXETcxsj8yu9k1BQx9q8BHw09AyVFFBpbh/cZRqISG2dHj8pAH95S2EMwTWP7WCiY0gHYZvJ6xODltx+5w4aXiiMV+4hNXCTVdtEtOl+a+ytOCIkbXDY1C5YUANV5F7iZJzuJzEYKD5mqYaK58uuu/RYA1R8CtqbkxywUXHF94Nk+WHJ43oBZ9Ts+EI2ec//vXsQhn1sW+aCgageYmYYAdoEpB1N7UUPCggNdmtkTRl2Gt0XbCDD3RxOBn5hRVN20zJve0P4Md2UAMk66nd4VGr2f93+IHnFt5Zldt2fzRij7NN+FXyN0A6p9RCzbnfm0fLVpfkmH7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQEXO4O94yDynLsPM32C2z/pbHEkeVBYYZf96oHEekc=;
 b=FP7Wh60ab1JIIiirzzgs8q4EFzPuJVeUnDj826Q9FLDsjg8ANI+NLQ1vivS4DD4WjbzHMLijFcwLFXjqinsAmDsLs5K37JLpAtNuWV2ZUHwX3X+BnBNFDAxUD2fP6Ni2Yms3uKssq2DBZ5ZcHD/mZ0CcsTXQVcoKWtb7sosDrWGTK601K1IJ2tX3v9CypvWA1NDcccNdaDuIdBFXfDr2QdaVRhLxhLtiVobyJAIU4NvSw/sG5i58eoxNyl/2DzQ3QIEuJaa37dzMCZnFrHwJSizaqlcK6B3yHX7LxItqWOOqcSjGec17Yn3UIFsSOJbEUP9amrz9F0/wCC5510TnAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQEXO4O94yDynLsPM32C2z/pbHEkeVBYYZf96oHEekc=;
 b=do0bn8phESGCimqLzZnG3GR5udqc3JA3ZSTC+jJ+rVIXw4CvxI5xBAOHCo06Cs53/VdEdHJ153mFplaxdxl6CfrdmGQ+1FhmkHwy1/zpxuHar60hTHpCg8qV2UjZXmhLL8yGEeNqpd9//p8cVWkdI93XAcpTLymndtMeSpuc7Rs=
Received: from CH0PR03CA0382.namprd03.prod.outlook.com (2603:10b6:610:119::35)
 by LVUPR12MB999162.namprd12.prod.outlook.com (2603:10b6:408:3a2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 5 Sep
 2026 10:06:38 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::4c) by CH0PR03CA0382.outlook.office365.com
 (2603:10b6:610:119::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.14 via Frontend Transport; Sat, 5
 Sep 2026 10:06:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sat, 5 Sep 2026 10:06:38 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 5 Sep 2026 05:06:36 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 13/13] drm/amdgpu: Use common doorbell helpers in nbif v6_3_1
Date: Sat, 5 Sep 2026 18:05:38 +0800
Message-ID: <20260905100538.12877-14-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260905100538.12877-1-Hawking.Zhang@amd.com>
References: <20260905100538.12877-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb08.amd.com
 (10.181.42.217)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|LVUPR12MB999162:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f02aaf5-efce-4c6f-9b9d-08df0b356014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 676RvWQQg26TqBgDAXVIxY5BsSuGm5pma3z4Dqx3kdKVISVhvz9uGDZpxduSBwSH/WbjMZ4TJRs1/Q2JOWCUMRCmUEvKh1JEk533RhhHA5P2mzha+LFamoyiB5JSz+x1EgU8nC+ZaaLwOhZ8cRvSgRUnnzQzoV/5lh5UD7w0ko/gR8Rv2xjNk6ZhjNRpdoMuFRA1x1Kv6IXlnyE4evhxLudM+WMai+JpMZSMSH7G2qNSuEmwPK3al3eIucPeF9UVsolB0bjE9OklzvwQwL8ubi9cmXGTp4KgFHzqxApDisO1ZUEd2CzYd7BSy1GXrWJIqFUA5jYOHUtZpWZL6mNUi3gw+9M2cE0QnrBXTgUGcwhAaFz/P9wGO/maWKSShKNJZNjkqxp0VVoBvZN4yFhFOEg+Af5C6Ruuf4qZQ9LCmVyEWw9QNQp/rPJwWryPXz6mngL+YM2F1QSnJO6PW8qODilcmjyk1P7dmYZczA5JZRghMeuaTiUE4+XfjVzmgAw0yBAbuhTXjzI6xczpjxYj6UL3vXskRg+vbXGoK9oLqShR/n8IoUyicDMep24eY60LOCBn0Pg6jYyiH0AapIF34qf/uuMsGXb2CyV74WLqiEXcruEnjweLRLujMiwys90zHPlt6rCHysLHh6p9uTBAWzxFahcZIUqnYkzi/wVISy/QD6MfUrIWKZM8iUykd0+rpqVWtjAiihVjo5Gsr2rvLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: igmTqsnXm1iH51D5xqSgTgpCMqlkCLF2QHdpKxDt7XhOrhu2p+0VC+S8kJDEnCVpZ3gB1pzHJa9MVlDGcNVQjozXntMhirexuuHPlIe27JvvmnqzvBbJ7wdzTljrXIMe97kcns4ryXFkeBgpdzFQEnR7w3+2C+CLhDWwkuuKJ6b7yZ0Sz8WJqBHF/E5936zMgZ/BDeGhQrh6YQ8BXDocNNFrUPVpCotbWhuus8Xm0ECIqlgpFU5DXozUl0BE0KZEboHREbF48EQFW4TFVSp2wZpaNt/TZgWq6OdBoSeCsR4hqNtFCYgvbWxgOYozb2HQ8GcVV2+RK9Pj4kxY4nyxWndIJv+NhMQ6gXUybRqo2orjZwASdGeHYXlPXXQ/Xu22rUQGKW3EeLgd/qpekHEWqqV1v1uXKQ10EIqWRvBkm6IJ2cPpooFlUS4rWNXHPg0K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 10:06:38.2239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f02aaf5-efce-4c6f-9b9d-08df0b356014
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999162
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

Build and program doorbell entry control values through the common
NBIO helpers while preserving the existing nbif v6_3_1 client
routing and field values.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c | 317 +++++++++++++----------
 1 file changed, 187 insertions(+), 130 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
index 766cfbde55aa..ce05f40f548a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -30,6 +30,91 @@
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include <uapi/linux/kfd_ioctl.h>
 
+static const struct amdgpu_nbio_doorbell_layout
+nbif_v6_3_1_doorbell_layout = {
+	.ctrl = {
+		.enable = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_ENABLE),
+		.awid = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_AWID),
+		.fence_enable = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_FENCE_ENABLE),
+		.range_offset = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_RANGE_OFFSET),
+		.range_size = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_RANGE_SIZE),
+		.disable_64bit = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_64BIT_SUPPORT_DIS),
+		.deduct_range_offset = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_NEED_DEDUCT_RANGE_OFFSET),
+		.drop = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_DROP_EN),
+		.awaddr_31_28 = REG_FIELD_MASK(
+			GDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL,
+			S2A_DOORBELL_PORT0_AWADDR_31_28_VALUE),
+	},
+};
+
+static void nbif_v6_3_1_init_doorbell_entry_registers(
+	struct amdgpu_device *adev)
+{
+	struct amdgpu_nbio_doorbell_entries *entries;
+	u32 ctrl_base;
+
+	memset(adev->nbio.doorbell_entries, 0,
+	       sizeof(adev->nbio.doorbell_entries));
+	adev->nbio.doorbell_layout = &nbif_v6_3_1_doorbell_layout;
+
+	ctrl_base = SOC15_REG_OFFSET(
+		NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL);
+
+	entries = &adev->nbio.doorbell_entries[
+		AMDGPU_NBIO_DOORBELL_CLIENT_CP];
+	entries->num_entries = 1;
+	entries->entry[0].port = 0;
+	entries->entry[0].ctrl_reg = ctrl_base;
+
+	entries = &adev->nbio.doorbell_entries[
+		AMDGPU_NBIO_DOORBELL_CLIENT_IH];
+	entries->num_entries = 1;
+	entries->entry[0].port = 1;
+	entries->entry[0].ctrl_reg = ctrl_base + 1;
+
+	entries = &adev->nbio.doorbell_entries[
+		AMDGPU_NBIO_DOORBELL_CLIENT_SDMA];
+	entries->num_entries = 1;
+	entries->entry[0].port = 2;
+	entries->entry[0].ctrl_reg = ctrl_base + 2;
+
+	entries = &adev->nbio.doorbell_entries[
+		AMDGPU_NBIO_DOORBELL_CLIENT_RLC];
+	entries->num_entries = 1;
+	entries->entry[0].port = 3;
+	entries->entry[0].ctrl_reg = ctrl_base + 3;
+
+	entries = &adev->nbio.doorbell_entries[
+		AMDGPU_NBIO_DOORBELL_CLIENT_VCN];
+	entries->num_entries = 2;
+	entries->entry[0].port = 4;
+	entries->entry[0].ctrl_reg = ctrl_base + 4;
+	entries->entry[1].port = 5;
+	entries->entry[1].ctrl_reg = ctrl_base + 5;
+
+	entries = &adev->nbio.doorbell_entries[
+		AMDGPU_NBIO_DOORBELL_CLIENT_VPE];
+	entries->num_entries = 1;
+	entries->entry[0].port = 5;
+	entries->entry[0].ctrl_reg = ctrl_base + 5;
+}
+
 static void nbif_v6_3_1_remap_hdp_registers(struct amdgpu_device *adev)
 {
 	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
@@ -70,84 +155,59 @@ static void nbif_v6_3_1_sdma_doorbell_range(struct amdgpu_device *adev,
 					    int doorbell_index,
 					    int doorbell_size)
 {
-	if (instance == 0) {
-		u32 doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL);
-
-		if (use_doorbell) {
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
-						       S2A_DOORBELL_PORT2_ENABLE,
-						       0x1);
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
-						       S2A_DOORBELL_PORT2_AWID,
-						       0xe);
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
-						       S2A_DOORBELL_PORT2_RANGE_OFFSET,
-						       doorbell_index);
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
-						       S2A_DOORBELL_PORT2_RANGE_SIZE,
-						       doorbell_size);
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
-						       S2A_DOORBELL_PORT2_AWADDR_31_28_VALUE,
-						       0x3);
-		} else
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
-						       S2A_DOORBELL_PORT2_RANGE_SIZE,
-						       0);
-
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
-			     doorbell_range);
+	const struct amdgpu_nbio_doorbell_fields fields = {
+		.enable = true,
+		.awid = 0xe,
+		.range_offset = doorbell_index,
+		.range_size = doorbell_size,
+		.awaddr_31_28 = 0x3,
+	};
+	u32 ctrl;
+
+	if (instance != 0)
+		return;
+
+	if (!use_doorbell) {
+		amdgpu_nbio_program_doorbell_entry(adev,
+			AMDGPU_NBIO_DOORBELL_CLIENT_SDMA, instance,
+			NULL, NULL);
+		return;
 	}
+
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+				adev, &fields, &ctrl, NULL)))
+		return;
+
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_SDMA, instance, &ctrl, NULL);
 }
 
 static void nbif_v6_3_1_vcn_doorbell_range(struct amdgpu_device *adev,
 					   bool use_doorbell, int doorbell_index,
 					   int instance)
 {
-	u32 doorbell_range;
-
-	if (instance) {
-		doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL);
-	} else {
-		doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL);
+	struct amdgpu_nbio_doorbell_fields fields = {
+		.enable = true,
+		.range_offset = doorbell_index,
+		.range_size = 8,
+	};
+	u32 ctrl, entry = !!instance;
+
+	if (!use_doorbell) {
+		amdgpu_nbio_program_doorbell_entry(adev,
+			AMDGPU_NBIO_DOORBELL_CLIENT_VCN, entry,
+			NULL, NULL);
+		return;
 	}
 
-	if (use_doorbell) {
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
-					       S2A_DOORBELL_PORT4_ENABLE,
-					       0x1);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
-					       S2A_DOORBELL_PORT4_AWID,
-					       instance ? 0x7 : 0x4);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
-					       S2A_DOORBELL_PORT4_RANGE_OFFSET,
-					       doorbell_index);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
-					       S2A_DOORBELL_PORT4_RANGE_SIZE,
-					       8);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
-					       S2A_DOORBELL_PORT4_AWADDR_31_28_VALUE,
-					       instance ? 0x7 : 0x4);
-	} else
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
-					       S2A_DOORBELL_PORT4_RANGE_SIZE,
-					       0);
+	fields.awid = instance ? 0x7 : 0x4;
+	fields.awaddr_31_28 = fields.awid;
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+				adev, &fields, &ctrl, NULL)))
+		return;
 
-	if (instance)
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL, doorbell_range);
-	else
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL, doorbell_range);
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_VCN, entry, &ctrl, NULL);
 }
 
 static void nbif_v6_3_1_vpe_doorbell_range(struct amdgpu_device *adev,
@@ -155,47 +215,54 @@ static void nbif_v6_3_1_vpe_doorbell_range(struct amdgpu_device *adev,
 							int doorbell_index,
 							int doorbell_size)
 {
+	const struct amdgpu_nbio_doorbell_fields fields = {
+		.enable = true,
+		.awid = 0xf,
+		.range_offset = doorbell_index,
+		.range_size = doorbell_size,
+		.awaddr_31_28 = 0xf,
+	};
+	u32 ctrl;
+
 	if (instance)
 		return;
 
-	u32 doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL);
-
-	if (use_doorbell) {
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
-					       S2A_DOORBELL_PORT5_ENABLE,
-					       0x1);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
-					       S2A_DOORBELL_PORT5_AWID,
-					       0xf);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
-					       S2A_DOORBELL_PORT5_RANGE_OFFSET,
-					       doorbell_index);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
-					       S2A_DOORBELL_PORT5_RANGE_SIZE,
-					       doorbell_size);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
-					       S2A_DOORBELL_PORT5_AWADDR_31_28_VALUE,
-					       0xf);
-	} else {
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
-					       S2A_DOORBELL_PORT5_RANGE_SIZE,
-					       0);
+	if (!use_doorbell) {
+		amdgpu_nbio_program_doorbell_entry(adev,
+			AMDGPU_NBIO_DOORBELL_CLIENT_VPE, instance,
+			NULL, NULL);
+		return;
 	}
 
-	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL, doorbell_range);
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+				adev, &fields, &ctrl, NULL)))
+		return;
 
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_VPE, instance, &ctrl, NULL);
 }
 
 static void nbif_v6_3_1_gc_doorbell_init(struct amdgpu_device *adev)
 {
-	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL, 0x30000007);
-	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL, 0x3000000d);
+	struct amdgpu_nbio_doorbell_fields fields = {
+		.enable = true,
+		.awaddr_31_28 = 0x3,
+	};
+	u32 ctrl;
+
+	fields.awid = 0x3;
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+				adev, &fields, &ctrl, NULL)))
+		return;
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_CP, 0, &ctrl, NULL);
+
+	fields.awid = 0x6;
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+				adev, &fields, &ctrl, NULL)))
+		return;
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_RLC, 0, &ctrl, NULL);
 }
 
 static void nbif_v6_3_1_enable_doorbell_aperture(struct amdgpu_device *adev,
@@ -231,37 +298,25 @@ nbif_v6_3_1_enable_doorbell_selfring_aperture(struct amdgpu_device *adev,
 static void nbif_v6_3_1_ih_doorbell_range(struct amdgpu_device *adev,
 					  bool use_doorbell, int doorbell_index)
 {
-	u32 ih_doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL);
-
-	if (use_doorbell) {
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_ENABLE,
-						  0x1);
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_AWID,
-						  0x0);
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_RANGE_OFFSET,
-						  doorbell_index);
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_RANGE_SIZE,
-						  8);
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
-						  0x0);
-	} else
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_RANGE_SIZE,
-						  0);
-
-	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
-		     ih_doorbell_range);
+	const struct amdgpu_nbio_doorbell_fields fields = {
+		.enable = true,
+		.range_offset = doorbell_index,
+		.range_size = 8,
+	};
+	u32 ctrl;
+
+	if (!use_doorbell) {
+		amdgpu_nbio_program_doorbell_entry(adev,
+			AMDGPU_NBIO_DOORBELL_CLIENT_IH, 0, NULL, NULL);
+		return;
+	}
+
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+				adev, &fields, &ctrl, NULL)))
+		return;
+
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_IH, 0, &ctrl, NULL);
 }
 
 static void nbif_v6_3_1_ih_control(struct amdgpu_device *adev)
@@ -343,6 +398,8 @@ static void nbif_v6_3_1_init_registers(struct amdgpu_device *adev)
 {
 	uint32_t data;
 
+	nbif_v6_3_1_init_doorbell_entry_registers(adev);
+
 	data = RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2);
 	data &= ~RCC_DEV0_EPF2_STRAP2__STRAP_NO_SOFT_RESET_DEV0_F2_MASK;
 	WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2, data);
-- 
2.17.1

