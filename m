Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3212C43602
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 10:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D08C10E2DC;
	Thu,  2 Jul 2026 10:33:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KDE/u78T";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6F4010E2DC
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 10:33:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V60moJIVwOVK4iCaCQpHGBaECDvD0ORY7TABhhFXy9qw+sDgxeVv0amUPrllKkKD7alckB4yYb9lgdDILBF2HUGVRNNRYBRnfGc7UA8HcLbVupVFMz/yRh65k+CUHCxAt2zBDfTsb9tbpOOBO17Ig2hysdGZhyuaUbU83TA18IVwn8k5encgKx1/It/rcz9OatYhp1JEAtMmcvPQyWoANcurxgwHGQRhR09AO9dpHNdHIcTQGE0ExX4YcEj8Tx0bpyqDhOuInmsOHXt0KcbzBcnslfa70dNJea/1hWGYgHlbseEQVVqtlPnOSLeASocZcQz63Z4Py82LPDiWZmeDuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2+eyKULZk1zGEijp85lmBL1L3JPbZF4RVdiepqXIzo=;
 b=kRuB7spGE1fJbz8dA26n22QDsGkb81T5QhxTerpRxuzwILdtjEJTnvwM0J8VYCbUNdeknMhQmp3csAIvclxQWEgBXO3oEsHnFMFtgkKzhWiAngTgXTPUefDs2wHvIDzDFq2gqcHeEnXRrNLrtaRmXqh9AGV8lDNFj3H8o6HX1f6WAre3ulxkSRLEsGTTt1mYN8Ivl3skt9hT5e90FPkRj7EIqzDodKZ+Vr3fEUe74fZ3FwRjw/KRJq7+LtVVtOKZoPwuHV00yD+hblnGrnItflHvtNlN/HWUvEqJAhX8/r5mRNoJZYZfu28vG0BMAxKECGApiWLnHQQBrsUSTEp+jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2+eyKULZk1zGEijp85lmBL1L3JPbZF4RVdiepqXIzo=;
 b=KDE/u78TOZzzMiL025qS9swQZ+vAS/76fiTs/gog+a0mJF9F/J3PqB7+jz94up54fE1NqZj2OdEuJaNFgKXy36HahHP9FhJFBhzThcBRZVW18YcH1WOSQEwuO5QHV5Lm5RrXswbBt2bgbBqP9krHP1eI2YcwQSqFIwoRdIJXo6M=
Received: from MN2PR16CA0053.namprd16.prod.outlook.com (2603:10b6:208:234::22)
 by DS0PR12MB8367.namprd12.prod.outlook.com (2603:10b6:8:fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 10:33:08 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:234:cafe::6f) by MN2PR16CA0053.outlook.office365.com
 (2603:10b6:208:234::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Thu, 2
 Jul 2026 10:33:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Thu, 2 Jul 2026 10:33:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 2 Jul
 2026 05:33:08 -0500
Received: from stanley-amd.amd.com (10.180.168.240) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 2 Jul
 2026 05:32:15 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH V2 1/1] drm/amdgpu/ras: only check bad page for address-based
 UMC injection
Date: Thu, 2 Jul 2026 18:32:01 +0800
Message-ID: <20260702103201.299749-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb10.amd.com
 (10.181.42.219)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|DS0PR12MB8367:EE_
X-MS-Office365-Filtering-Correlation-Id: cba85512-ec75-40c1-761f-08ded8254ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|11063799006|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: YmOmjUNBxLy5l/T4IN+sqzDTg11b5c2mFqq7pd2u2mTx+Zdq4huffDGPV1rATm0jniMUwjWh3kHuAYVsehP3fC1EJKZuD+Lc/W2anlCHpCFxUG6oWURrirXt3hcaDF/Z0PFd1gxPFGWfcyAkTFzV1xphLwkgmLcNbWfFlXCcfvdNuAPGW9e/DHKQgX63+nORou9wA1AKeKWg5EMgJs1dfULj+TE6eoLND3/FKqHHaRB52wBjyRJWy46AxrhnJdTd1F1AH+sEfQJ+KtiupjnUn8I3dE5dym+m6UmPlSdR4zxpKP78XvwhVFyNgd3MPE7Oj9Qk1Zu6cOXOLYMTM2FXuyuf8gc0plmv9tU+XTRjYSW+c26uCzQHfC/6GQaGQEJZUNn6yYFV1qVLFRINBY8XtOpwTNyjsrXDsH74okMbr5TeQRX3IPuOfdItsuq6HhfSeaoVHXUqTzOjYj5d4GqwqfVMvRW+qn2e32IhPmlactX174o8KZ4kIlO6FYP60BEauI4WGsyWD+Wja9XWS0Gyhyf2a47Yl5Bf3zciMAuUcpKvxPY8+HdomSV1rxYyXdeQ7tpXcWyEMctkDJVzLKTWjgW6rECp2drreqy5l2WStmhDtjvkcv70n8j+1BEq0iAK8J9Zyf783bNKwb3QMwFGMtrt2rgfoEj6O8g8WCYS8QJzSHSxhTD4kW/Qq3kU8D84G/vAtI1oyKBn8McYEkxWhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(11063799006)(6133799003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hl0tv7qdUGmy8UZJW4g7w9K7qWiZuTCaM0a6mIJzSLVw4GE3r/7UVfIqr1RUDHuBLKLXncE33kzlc4Z8Pbo1v1O9lXsz+4g2jIcP8+AV1qRrw7m1yJEccR3XJ9rsbDnnNwQGs/TCrkkZ2v91adn6jw7XyruFr/9OBDeZXrxG+CCeNQULjfolz72AAMZ2s1d83V6MREzfR39orpuRp+DYnDpzry26IR6ELNugy7gaYDDByOlmVo8bAbMAwalU725543VoauyAGRHt4YlaVQa1BYfYO3P1ZJUwBOBZ8nLSTpxMHtH8XIUE1exsNOEMZp4A0gXq4So4ev4BJyNXHgQejMB9+N4MUpx/owdtLElpPyYEQckkMoHihXvt6FmNrJ4RCTs+CsJVgOFJgmjaPZFwuJtvZ2wujSmEoxfxl+30GaRwRVp2Bw122jS2gTqlx/gN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:33:08.2121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cba85512-ec75-40c1-761f-08ded8254ee9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8367
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

UMC error injection on MI300 series is dispatched by the RAS TA via
the (sub-block, method) pair; only the "coherent" methods are address
based, the single-shot/persistent/ac-parity ones ignore the address.

The debugfs control path validated the injection address against the
bad page list for every UMC injection. Restrict that check to
address-based injections and warn when a non address-based one is
given a non-zero address. Other ASICs keep injecting by address.

Changed from V1:
	move address based checking to uniras layer

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 10 +++-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c  | 58 ++++++++++++++++++-
 2 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index af48dd2ebd16..f280a312b0a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -606,8 +606,14 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
 		ret = amdgpu_ras_feature_enable(adev, &data.head, 1);
 		break;
 	case 2:
-		/* umc ce/ue error injection for a bad page is not allowed */
-		if (data.head.block == AMDGPU_RAS_BLOCK__UMC)
+		/*
+		 * UMC ce/ue error injection for a bad page is not allowed. For
+		 * uniras (SMU v13+) devices the injection address is validated by
+		 * the ras_mgr inject handler, so only run the legacy bad page
+		 * check for the legacy RAS path.
+		 */
+		if (data.head.block == AMDGPU_RAS_BLOCK__UMC &&
+		    !amdgpu_uniras_enabled(adev))
 			ret = amdgpu_ras_check_bad_page(adev, data.inject.address);
 		if (ret == -EINVAL) {
 			dev_warn(adev->dev, "RAS WARN: input address 0x%llx is invalid.",
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
index bfbfdffbfbe6..063c7b0a7b00 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
@@ -82,6 +82,57 @@ static uint64_t local_addr_to_xgmi_global_addr(struct ras_core_context *ras_core
 	return (addr + xgmi->physical_node_id * xgmi->node_segment_size);
 }
 
+/*
+ * UMC error injection is dispatched by the RAS TA using the (sub-block, method)
+ * pair carried in struct ras_cmd_inject_error_req as subblock_id (enum
+ * error_sub_block_umc) and method (enum inject_method_umc). Only the "coherent"
+ * methods program an explicit injection address and are therefore address-based;
+ * the single-shot, persistent and ac-parity methods ignore the address.
+ *
+ * Keep the values below in sync with the RAS TA.
+ */
+enum umc_error_sub_block {
+	UMC_ERROR_CRC			= 0,
+	UMC_ERROR_SRAM			= 1,
+	UMC_ERROR_ODECC			= 2,
+	UMC_ERROR_PARITY_DATA		= 3,
+	UMC_ERROR_PARITY_CMD		= 4,
+};
+
+enum umc_inject_method {
+	UMC_METH_COHERENT		= 0,
+	UMC_METH_SINGLE_SHOT		= 1,
+	UMC_METH_PERSISTENT		= 2,
+	UMC_METH_PERSISTENT_DISABLE	= 3,
+	UMC_METH_COHERENT_NO_DETECTION	= 4,
+	UMC_METH_COHERENT_WR		= 5,
+	UMC_METH_SINGLE_SHOT_WR		= 6,
+	UMC_METH_PERSISTENT_WR		= 7,
+	UMC_METH_SINGLE_SHOT_CLEAN	= 8,
+};
+
+/*
+ * Return true if a UMC error injection using @sub_block and @method is
+ * address-based, i.e. it programs an explicit injection address that must be
+ * validated. The non address-based methods ignore the address.
+ */
+static bool amdgpu_ras_umc_inject_is_address_based(u32 sub_block, u64 method)
+{
+	switch (sub_block) {
+	case UMC_ERROR_CRC:
+		return method == UMC_METH_COHERENT ||
+		       method == UMC_METH_COHERENT_NO_DETECTION ||
+		       method == UMC_METH_COHERENT_WR;
+	case UMC_ERROR_ODECC:
+		return method == UMC_METH_COHERENT;
+	case UMC_ERROR_PARITY_DATA:
+		return method == UMC_METH_COHERENT ||
+		       method == UMC_METH_COHERENT_WR;
+	default:
+		return false;
+	}
+}
+
 static int amdgpu_ras_inject_error(struct ras_core_context *ras_core,
 			struct ras_cmd_ctx *cmd, void *data)
 {
@@ -90,7 +141,8 @@ static int amdgpu_ras_inject_error(struct ras_core_context *ras_core,
 		(struct ras_cmd_inject_error_req *)cmd->input_buff_raw;
 	int ret = RAS_CMD__ERROR_GENERIC;
 
-	if (req->block_id == RAS_BLOCK_ID__UMC) {
+	if (req->block_id == RAS_BLOCK_ID__UMC &&
+		amdgpu_ras_umc_inject_is_address_based(req->subblock_id, req->method)) {
 		if (amdgpu_ras_mgr_check_retired_addr(adev, req->address)) {
 			RAS_DEV_WARN(ras_core->dev,
 				"RAS WARN: inject: 0x%llx has already been marked as bad!\n",
@@ -111,6 +163,10 @@ static int amdgpu_ras_inject_error(struct ras_core_context *ras_core,
 			req->block_id != RAS_BLOCK_ID__GFX) {
 			req->address = local_addr_to_xgmi_global_addr(ras_core, req->address);
 		}
+	} else if (req->block_id == RAS_BLOCK_ID__UMC && req->address) {
+		RAS_DEV_WARN(adev,
+			"RAS WARN: non address based injection, ignore the injection address 0x%llx\n",
+			req->address);
 	}
 
 	amdgpu_ras_trigger_error_prepare(ras_core, req);
-- 
2.43.0

