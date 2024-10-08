Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C63CF0438
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 21:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2488110E5EE;
	Tue,  8 Oct 2024 21:16:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w9XhEXNo";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1521E10E5E3
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 21:16:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcI3K0DgJMW7nvLjT8+KXaYIO1fbhQxlOa8YSnRrwVOhhPWApcfm9sp4ZP9mszey7w8PjGonH/bvhRAY96D0LIsTIhLTR+gj+UoRmT+n+mpGOdgtAwFBtl+JPjZ/bEGXsEKdcbOrjs/pEv/TXHgjLRgwPecjcJ+D+qeoL7keQy5jr0JrBrWeyfVMD2Y3urBSkauC8DJjCvCNVXRQMr3l83momckPNnFeYTgOTnThMvw5oesaDxnDUWVQpOo7mrpr3iq7KNrnwf9vxKNvLIem+07qp/q9p0K5Sm759sM6xoaLdbu2rbqqCZ+32B6G76wWwIwy7VQOOxIh/4otcoDYbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqI4nDVwjq9AdzBO1NoWgfmO8ILww9NydcnjscehSvY=;
 b=vudupPwhi/6fWZ9tcifMRV6KTr3hVorvD6gTWHYdyk33pT5beiJjkOaNP3z0/PwhrigPBgnywPw6EG6KGb0OQcFCijyJtA7SpVkLdLpHPl3OxskQwMNnBNzs9S6XyRVzfJLD8ExUqFw2PQMgrONYwqaQtbewr6UvrjmAg9KJg3lZG+rkLsdt4sRRpHbUQC1TeECTw7wkBVKOzWP2KCAvt0w6Wi5ySsIWSNde6hwmrS9VzQLrDbHeE/DGsyNTexDOOs6p1K3YmGY5OXmHFuA9pIQmcEft3ln5giR+sl8HogHm4TwKogVKL2W18o7LuOPetgQ/MX586j5fNzXmkRZojQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqI4nDVwjq9AdzBO1NoWgfmO8ILww9NydcnjscehSvY=;
 b=w9XhEXNo8gZdICgVuHOE7GrqlfD5tN0Hzw0NuCRDrDtp/8LuFXnWxtH/SKpm2Q7p9if02jb/1CFtsun16PB4eG3U5NU0qvUMm1TQTK5RvltOnueDgIfQviVsIMxh4tRgosY6NZ9VVvLVKRGOjZkiTdaC8kpTRPj2gjPA2v4MRdo=
Received: from CH2PR05CA0021.namprd05.prod.outlook.com (2603:10b6:610::34) by
 PH0PR12MB5679.namprd12.prod.outlook.com (2603:10b6:510:14f::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.23; Tue, 8 Oct 2024 21:16:35 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::f) by CH2PR05CA0021.outlook.office365.com
 (2603:10b6:610::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 21:16:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 21:16:34 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 16:16:29 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 29/32] drm/amdgpu: dump_ip_state for each vcn instance
Date: Tue, 8 Oct 2024 17:15:50 -0400
Message-ID: <20241008211553.36264-30-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008211553.36264-1-boyuan.zhang@amd.com>
References: <20241008211553.36264-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|PH0PR12MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: edde0903-8c83-400d-55c0-08dce7de7d3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AbWxJK6OnyrKl0S3tOX+gV/w4USxfmdzke2KiV/xCK/U2uLiJYseqy6l4Yno?=
 =?us-ascii?Q?sCdzEZNZRm8LIQBbxUDWy8K/svzruD51DXpgZblL0mcrNRwwt/BWGT9xqWU7?=
 =?us-ascii?Q?+a2J4hL1OOekQECAy8vPz1h7ATaGGbEPns2i/8GCJ47HF6j/XEoyMdLNJo7P?=
 =?us-ascii?Q?4oTqYNcNhoQkWKefkqjqYD3zsHMeZxTPNfMGXJcEgDCTQD3TNRnfnq2bAFIt?=
 =?us-ascii?Q?db/Bq6Ctxn6Z7fmEbZtwk3s5ULrmWn+NHCDhC37AKeYCiExBrDgu0lNp4N6Q?=
 =?us-ascii?Q?Z4jO1jWoEh4lTS4OZuuwmiWGcyTZdFH0TyDzXtjCXNFf9FRI22eshj57tA46?=
 =?us-ascii?Q?EW1WxUDwJZDcfvPJNaxuqv2xSqeFiALq9bWyzD2buszCfEvInrRXNRQFb9oY?=
 =?us-ascii?Q?1ppF4iCgsVLSwbHVSrHspBiEUukkltHvi37vmhU2SBLoDxWvgN3azpQiguqG?=
 =?us-ascii?Q?rg6DAifwx0M10g+iVmt2S9EDUhcrWqkefIMEtcyQkB4LRfAbEIa4a3OXkVRS?=
 =?us-ascii?Q?PNCoTziiTum39oefPJkBt59sU3BLsWf0cZ7WoKj9NDIBE4csSjWOb96AuTwH?=
 =?us-ascii?Q?ByrCqZHXw03mq9DLxnox5nUOumWRY+GCpuBSFU5fCGJnWle31g0uvC6+lx0A?=
 =?us-ascii?Q?yPO5J78If3sTyxdWlBHT2VIpuePDgy8g/aAEY8020y2DMFBc6dD7Xj9hj55R?=
 =?us-ascii?Q?gwdKh3ut7IQrcoQmyDD2xDtNAb7uEF1yE6dltEgzwETQFiUyYCtlYFcBbXAg?=
 =?us-ascii?Q?Ma4zZvI3b/z0RV5Q3u36/LJshtZEE6PyIzsNS1H+gtTDYRQOVU0HKFufG4oL?=
 =?us-ascii?Q?NLhKToIaY+pfDs8U9wxYnmfH0KHyU3UhmDqROOvfQ4nX33fJ183sXnWZt3jr?=
 =?us-ascii?Q?vatT0TfV41ObBE2FakPC+Bhr6Mwze1D9eOZQBmHmp+vGNymI+wxS5RWcWbxE?=
 =?us-ascii?Q?0e/ueAxeOIU7qX9Ka7BiLZ6M76dBkrSc9vfwaG7fs9XIdt3N1/rjvz1YBc0d?=
 =?us-ascii?Q?k79KsKdHGVq5T1HRlNS11Da0YsZcTcoHpf+YgMxkpxth5i3cw0HrDp5Xe2JJ?=
 =?us-ascii?Q?eiAp8ADISqSZJFS3Gmt1DMgBOkV0yVQj3sfBRa+yuK023zG9kP2X9WzZPHag?=
 =?us-ascii?Q?DDhL/BNGh9Fmm6sP7aIftIFlwWkxJQxWjowNKPtQ9B0BhGMf0aHBZ2Tq0MRg?=
 =?us-ascii?Q?a039FZyxFi47syhcdpYoPmbfB1WRuZq+4XBKatWbbOFbiUTCq+LgR0lzYVlj?=
 =?us-ascii?Q?mYw/yrhp18Dk80/FiTYbzukcjG1C1MJqeTs75yurrjv4DlrHftduGichf+bw?=
 =?us-ascii?Q?1kxSqrIss9OYmIF0apgvoID2v6YjgAzzqgCno6Eb9FmwgFw6H/JJaDHC6RqZ?=
 =?us-ascii?Q?SSTmzvA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 21:16:34.7795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edde0903-8c83-400d-55c0-08dce7de7d3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5679
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Perform dump_ip_state only for the instance of the current vcn IP block,
instead of perform it for all vcn instances.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 27 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 27 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 27 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 27 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 31 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 35 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 31 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 27 +++++++++----------
 8 files changed, 112 insertions(+), 120 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 9255bcfc6c3d..27e0f206c9dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1964,7 +1964,8 @@ static void vcn_v1_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 static void vcn_v1_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
+	int inst = ip_block->instance;
+	int j;
 	bool is_powered;
 	uint32_t inst_off;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_1_0);
@@ -1972,21 +1973,19 @@ static void vcn_v1_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	if (!adev->vcn.ip_dump)
 		return;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		inst_off = i * reg_count;
-		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
-		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
+	adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
+	is_powered = (adev->vcn.ip_dump[inst_off] &
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered)
-			for (j = 1; j < reg_count; j++)
-				adev->vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_1_0[j], i));
-	}
+	if (is_powered)
+		for (j = 1; j < reg_count; j++)
+			adev->vcn.ip_dump[inst_off + j] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_1_0[j], inst));
 }
 
 static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 94f000ed4895..665b749c5ac0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -2072,7 +2072,8 @@ static void vcn_v2_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 static void vcn_v2_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
+	int inst = ip_block->instance;
+	int j;
 	bool is_powered;
 	uint32_t inst_off;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_0);
@@ -2080,21 +2081,19 @@ static void vcn_v2_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	if (!adev->vcn.ip_dump)
 		return;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		inst_off = i * reg_count;
-		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
-		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
+	adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
+	is_powered = (adev->vcn.ip_dump[inst_off] &
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered)
-			for (j = 1; j < reg_count; j++)
-				adev->vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_0[j], i));
-	}
+	if (is_powered)
+		for (j = 1; j < reg_count; j++)
+			adev->vcn.ip_dump[inst_off + j] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_0[j], inst));
 }
 
 static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 7c9a0169215e..5332b2903ce1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1946,7 +1946,8 @@ static void vcn_v2_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 static void vcn_v2_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
+	int inst = ip_block->instance;
+	int j;
 	bool is_powered;
 	uint32_t inst_off;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
@@ -1954,21 +1955,19 @@ static void vcn_v2_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	if (!adev->vcn.ip_dump)
 		return;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		inst_off = i * reg_count;
-		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
-		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
+	adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
+	is_powered = (adev->vcn.ip_dump[inst_off] &
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered)
-			for (j = 1; j < reg_count; j++)
-				adev->vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_5[j], i));
-	}
+	if (is_powered)
+		for (j = 1; j < reg_count; j++)
+			adev->vcn.ip_dump[inst_off + j] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_2_5[j], inst));
 }
 
 static const struct amd_ip_funcs vcn_v2_5_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 061c958700d8..40a3d29d4e71 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -2269,7 +2269,8 @@ static void vcn_v3_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 static void vcn_v3_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
+	int inst = ip_block->instance;
+	int j;
 	bool is_powered;
 	uint32_t inst_off;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
@@ -2277,21 +2278,19 @@ static void vcn_v3_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	if (!adev->vcn.ip_dump)
 		return;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		inst_off = i * reg_count;
-		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
-		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, mmUVD_POWER_STATUS);
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-			      UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
+	adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
+	is_powered = (adev->vcn.ip_dump[inst_off] &
+			  UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered)
-			for (j = 1; j < reg_count; j++)
-				adev->vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_3_0[j], i));
-	}
+	if (is_powered)
+		for (j = 1; j < reg_count; j++)
+			adev->vcn.ip_dump[inst_off + j] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_3_0[j], inst));
 }
 
 static const struct amd_ip_funcs vcn_v3_0_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index fdf346bf3e34..3b2f4f1e0939 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -2177,7 +2177,8 @@ static void vcn_v4_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 static void vcn_v4_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
+	int inst = ip_block->instance;
+	int j;
 	bool is_powered;
 	uint32_t inst_off;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0);
@@ -2185,22 +2186,20 @@ static void vcn_v4_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	if (!adev->vcn.ip_dump)
 		return;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		inst_off = i * reg_count;
-		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
-		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, regUVD_POWER_STATUS);
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
-
-		if (is_powered)
-			for (j = 1; j < reg_count; j++)
-				adev->vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0[j],
-									   i));
-	}
+	inst_off = inst * reg_count;
+	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
+	adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, regUVD_POWER_STATUS);
+	is_powered = (adev->vcn.ip_dump[inst_off] &
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+
+	if (is_powered)
+		for (j = 1; j < reg_count; j++)
+			adev->vcn.ip_dump[inst_off + j] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0[j],
+								   inst));
 }
 
 static const struct amd_ip_funcs vcn_v4_0_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index daaf2fb6b3e5..be03d31cb206 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1757,7 +1757,8 @@ static void vcn_v4_0_3_print_ip_state(struct amdgpu_ip_block *ip_block, struct d
 static void vcn_v4_0_3_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
+	int inst = ip_block->instance;
+	int j;
 	bool is_powered;
 	uint32_t inst_off, inst_id;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
@@ -1765,23 +1766,21 @@ static void vcn_v4_0_3_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	if (!adev->vcn.ip_dump)
 		return;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-
-		inst_id = GET_INST(VCN, i);
-		inst_off = i * reg_count;
-		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
-		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst_id, regUVD_POWER_STATUS);
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
-
-		if (is_powered)
-			for (j = 1; j < reg_count; j++)
-				adev->vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_3[j],
-									   inst_id));
-	}
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
+
+	inst_id = GET_INST(VCN, inst);
+	inst_off = inst * reg_count;
+	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
+	adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst_id, regUVD_POWER_STATUS);
+	is_powered = (adev->vcn.ip_dump[inst_off] &
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+
+	if (is_powered)
+		for (j = 1; j < reg_count; j++)
+			adev->vcn.ip_dump[inst_off + j] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_3[j],
+								   inst_id));
 }
 
 static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index ff8db22b9614..43b1f3d06157 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1638,7 +1638,8 @@ static void vcn_v4_0_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct d
 static void vcn_v4_0_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
+	int inst = ip_block->instance;
+	int j;
 	bool is_powered;
 	uint32_t inst_off;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_5);
@@ -1646,22 +1647,20 @@ static void vcn_v4_0_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	if (!adev->vcn.ip_dump)
 		return;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		inst_off = i * reg_count;
-		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
-		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, regUVD_POWER_STATUS);
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
-
-		if (is_powered)
-			for (j = 1; j < reg_count; j++)
-				adev->vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_5[j],
-									   i));
-	}
+	inst_off = inst * reg_count;
+	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
+	adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, regUVD_POWER_STATUS);
+	is_powered = (adev->vcn.ip_dump[inst_off] &
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+
+	if (is_powered)
+		for (j = 1; j < reg_count; j++)
+			adev->vcn.ip_dump[inst_off + j] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_4_0_5[j],
+								   inst));
 }
 
 static const struct amd_ip_funcs vcn_v4_0_5_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index c83a5c09f410..65554c4e86cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1365,7 +1365,8 @@ static void vcn_v5_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm
 static void vcn_v5_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, j;
+	int inst = ip_block->instance;
+	int j;
 	bool is_powered;
 	uint32_t inst_off;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_5_0);
@@ -1373,21 +1374,19 @@ static void vcn_v5_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
 	if (!adev->vcn.ip_dump)
 		return;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-		inst_off = i * reg_count;
-		/* mmUVD_POWER_STATUS is always readable and is first element of the array */
-		adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, regUVD_POWER_STATUS);
-		is_powered = (adev->vcn.ip_dump[inst_off] &
-				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+	inst_off = inst * reg_count;
+	/* mmUVD_POWER_STATUS is always readable and is first element of the array */
+	adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, inst, regUVD_POWER_STATUS);
+	is_powered = (adev->vcn.ip_dump[inst_off] &
+			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
 
-		if (is_powered)
-			for (j = 1; j < reg_count; j++)
-				adev->vcn.ip_dump[inst_off + j] =
-					RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_5_0[j], i));
-	}
+	if (is_powered)
+		for (j = 1; j < reg_count; j++)
+			adev->vcn.ip_dump[inst_off + j] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_5_0[j], inst));
 }
 
 static const struct amd_ip_funcs vcn_v5_0_0_ip_funcs = {
-- 
2.34.1

