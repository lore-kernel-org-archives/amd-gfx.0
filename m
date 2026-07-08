Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0262C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 12:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 724FC10E5CB;
	Wed,  8 Jul 2026 12:04:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z7KbPs4o";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C743B10E5CB
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 12:04:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1/CatDYcWSkTfPttYt/L8n06kFJPlKT7RHUSA/4JN7/NopLyPcYl0+Z/aE1BWrmj0nhziMDmUN2yFkv1YCbmWkwBXO07teFamn7oWR16QYfP8Wwhu+WktDG1GvyH+pwNqJezOza7crHriZKhtrda20rn6l6XXn57K/PaPrmKkYmsgaydhm/skw7ZyLiK5ju+WNg+xjLhffWxsZvPIXW3orcTchGz+rX3xnu3QePX6W1uvdNrhIdHwWMNZEkFWBP/0x1s00BVFETfEQsHsC9vErnDaGHQh6VAo90E1rULnROFkN3AZmRfRiX3tF/oBahBsgZtyaLItCSuQuecntudQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5d2tkXiTJ514NIMp+p1S2AOkNksjuNOCI6Oo+PXoPbk=;
 b=ZDtZ1kCuu9JAunbnbEg2Rv2GYH5Re6DpcF+jkgoZYNeELPOtVDwjnMcZCvLTkzoqJwYYNFw+AnJ6bxKyfahKib5blzELSWbVBCrEe93Qt4o3u5gIe+Klok7byzQM+EWl9y2W8dUIB4UTNgw9gsuib7gpgMU7gWOZmMf9tsWNo2xSBNY5m1hk52Z0eBa04cMMZ0j7M9PpBQpqIAQoPYN1C5bzCPbfunzwZuKYFboleYXAnc7wau0QgOgCmL2gIgsq8t5wo26ud0wL04zX72ThXdRpUAF1I2GtbSfsjgBsP5RMpu4xoev3pulYbv1n38LDL+2n3ZLcR4nQC7DeiQegGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5d2tkXiTJ514NIMp+p1S2AOkNksjuNOCI6Oo+PXoPbk=;
 b=z7KbPs4oKE/6J6abWj69TWxP4qA+XD5YH8VrajuflJB210Wp5Dj0V7lahPMTqW7ElPpIenFmSuoB9Hq9B4bVlwZ+HP20UeQTt292u0wa18MnD0QpLGx4xJL91hxalRB+eWY7g5K+K6nKche5T1t2EXMSbkhnUj4oYte6AKuTJtU=
Received: from SA9PR13CA0111.namprd13.prod.outlook.com (2603:10b6:806:24::26)
 by DS0PR12MB7746.namprd12.prod.outlook.com (2603:10b6:8:135::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 12:04:35 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:24:cafe::4b) by SA9PR13CA0111.outlook.office365.com
 (2603:10b6:806:24::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.3 via Frontend Transport; Wed, 8
 Jul 2026 12:04:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 12:04:34 +0000
Received: from stanley-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 07:04:33 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Kent.Russell@amd.com>, Stanley.Yang
 <Stanley.Yang@amd.com>
Subject: [PATCH V3 1/1] drm/amdgpu/ras: only check bad page for address-based
 UMC injection
Date: Wed, 8 Jul 2026 20:04:18 +0800
Message-ID: <20260708120418.376019-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|DS0PR12MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: fb3df90b-40ee-482e-89ef-08dedce913aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: M9hFVFYk/dLglmm/uKquSVEdp/xBCSVxNBPU2N/j2hMiojNsp93xiitgN/a2fgWM5n1tFyIEBP1jpvVbkZZ8w0y32IrVvn4iiPj0q7YcM7QBGbRc942jvKl1Hc1XO1xgbtuRsLUuPQ0pkQFrQenGPl1/ddmFMjAWx79vHB6QjVGafvjMrVgbB0vj3IkpsWiT0baGT4Xq/V2LUro2qAa7+hs6jmwVm5AodFZj26uTdQ+Iy69PBImqmG0bqNks8/Lvs7Yvvd4Qs6RFA2s2g4gssP9pxEGTDSb4hI0urKCyM0hN2gkPMMZhHHghgdZkDHOol5vh99gje2zGygG32HbwCNW333v5ljuTejQWZI9zrlUT8SBDKvv2meZeqPq/qalm3LHJgstCYISIcqzDJCupUwxxZwIVQdCUxX5x+zQFOvXjGqSu7/QX4Ykx/2X4ZMtgdx5eDdN7Re7zA5cR1j25sY31Xt+kaB9x5fc6JQblQevnd26Tr6At7hZuf25iwK66smhjSXgoDTEf/1e/PicwBm5G9FKKfh4VsSXK7adDH8iTj9iNIK4ARz3kwpc7F3MSgVRTy5iADtsbdwqxYzso59sAn78L/om7LPr4ns32REGCr2ffksf6xBHOwTk9hzBsvYJ70P4metyZzsA7j55lCyTEa1N2TB7zMYYndNWyGdSPQm6iEiPx1olNXnuTiEvY4p0QPNAhUyrSRsdg4WVOnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BKDCKDj+YVIX14hcuRj8qwjrvmxuFg9R/4dS09aU8s1f4V/xWG118xO7moEUCk6xQitNtu/vxPCrPAtwrPa8IgfjwGXGinp+GVgcUrGJatfOmfmCVPn6K/Nm7rYsE0Ne7OY03m8p5UpHEoN4R9CVHEcnrF5WLuHcR4a4cA/58Yc8d5odO1+F6SDc1hrnOFyctI5OXcCSeZfS8XNTPv6c+lziXYTT9yRoUNeO9jpaGd3b3ooGucSx82bAAGD4n3q9lVfnA3Fvj1oXxU1uLNsHaeR3cjhiN+RC5KdpcN6wZKZamnW90+SBtkehQEFTrbPY8AwLhWETvQ56uE4roUzRYipiHy00EZDAN/ryQTLSbtqzZZ+Jc10vSIVIh4+FQSWNnGUt2qyFbnyJ+33u5Zyk38P4v81/Sh3Hs+f1HbSVblT2VFvWFDcIbpjYCrsLxaOW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 12:04:34.8270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3df90b-40ee-482e-89ef-08dedce913aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7746
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

UMC error injection on MI300 series is dispatched by the RAS TA using
the injection method; only the "coherent" methods are address based,
the single-shot/persistent/ac-parity ones ignore the address.

The debugfs control path validated the injection address against the
bad page list for every UMC injection. On uniras (SMU v13+) devices the
address is now validated by the ras_mgr inject handler, so the legacy
debugfs bad page check only runs on the legacy RAS path; other ASICs
keep injecting by address.

In the ras_mgr handler an injection is treated as non address-based only
when userspace passes the U64_MAX sentinel address and the method is a
non-address method. In that case the address is cleared to 0 and the bad
page / range validation is skipped; otherwise the injection address is
validated as before.

Changed from V1:
	move address based checking to uniras layer

Changed from V2:
	Check umc injection address setting flag,
	simplify non address based injection judgment


Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 10 ++-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c  | 83 +++++++++++++++----
 2 files changed, 73 insertions(+), 20 deletions(-)

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
index bfbfdffbfbe6..c2285fde8b3c 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
@@ -82,6 +82,43 @@ static uint64_t local_addr_to_xgmi_global_addr(struct ras_core_context *ras_core
 	return (addr + xgmi->physical_node_id * xgmi->node_segment_size);
 }
 
+/*
+ * UMC error injection is dispatched by the RAS TA using the injection method
+ * carried in struct ras_cmd_inject_error_req. Only the "coherent" methods
+ * program an explicit injection address and are therefore address-based; the
+ * single-shot, persistent and ac-parity methods ignore the address.
+ *
+ * Keep these values in sync with the RAS TA.
+ */
+enum umc_inject_method {
+	UMC_METHOD_COHERENT		= 0,
+	UMC_METHOD_SINGLE_SHOT		= 1,
+	UMC_METHOD_PERSISTENT		= 2,
+	UMC_METHOD_PERSISTENT_DISABLE	= 3,
+	UMC_METHOD_COHERENT_NO_DETECTION	= 4,
+	UMC_METHOD_COHERENT_WR		= 5,
+	UMC_METHOD_SINGLE_SHOT_WR		= 6,
+	UMC_METHOD_PERSISTENT_WR		= 7,
+	UMC_METHOD_SINGLE_SHOT_CLEAN	= 8,
+};
+
+/*
+ * Return true when @method does not program an explicit injection address.
+ * Only the coherent methods are address-based; every other method ignores the
+ * address, so userspace signals them by setting the address to U64_MAX.
+ */
+static bool amdgpu_ras_mgr_is_non_address_injection(u64 method)
+{
+	switch (method) {
+	case UMC_METHOD_COHERENT:
+	case UMC_METHOD_COHERENT_NO_DETECTION:
+	case UMC_METHOD_COHERENT_WR:
+		return false;
+	default:
+		return true;
+	}
+}
+
 static int amdgpu_ras_inject_error(struct ras_core_context *ras_core,
 			struct ras_cmd_ctx *cmd, void *data)
 {
@@ -91,25 +128,35 @@ static int amdgpu_ras_inject_error(struct ras_core_context *ras_core,
 	int ret = RAS_CMD__ERROR_GENERIC;
 
 	if (req->block_id == RAS_BLOCK_ID__UMC) {
-		if (amdgpu_ras_mgr_check_retired_addr(adev, req->address)) {
-			RAS_DEV_WARN(ras_core->dev,
-				"RAS WARN: inject: 0x%llx has already been marked as bad!\n",
-				req->address);
-			return RAS_CMD__ERROR_ACCESS_DENIED;
-		}
-
-		if ((req->address >= adev->gmc.mc_vram_size &&
-			adev->gmc.mc_vram_size) ||
-			(req->address >= RAS_UMC_INJECT_ADDR_LIMIT)) {
-			RAS_DEV_WARN(adev, "RAS WARN: input address 0x%llx is invalid.",
+		/*
+		 * Only address-based UMC injections carry an explicit injection
+		 * address that has to be validated. A non address-based method
+		 * ignores the address, and userspace flags such an injection by
+		 * setting the address to U64_MAX. When both the sentinel and the
+		 * method agree, clear the address so the RAS TA ignores it and
+		 * skip the validation; otherwise validate the injection address.
+		 */
+		if (req->address == U64_MAX && amdgpu_ras_mgr_is_non_address_injection(req->method)) {
+			req->address = 0x0;
+		} else {
+			if (amdgpu_ras_mgr_check_retired_addr(adev, req->address)) {
+				RAS_DEV_WARN(ras_core->dev,
+					"RAS WARN: inject: 0x%llx has already been marked as bad!\n",
 					req->address);
-			return RAS_CMD__ERROR_INVALID_INPUT_DATA;
-		}
-
-		/* Calculate XGMI relative offset */
-		if (adev->gmc.xgmi.num_physical_nodes > 1 &&
-			req->block_id != RAS_BLOCK_ID__GFX) {
-			req->address = local_addr_to_xgmi_global_addr(ras_core, req->address);
+				return RAS_CMD__ERROR_ACCESS_DENIED;
+			}
+
+			if ((req->address >= adev->gmc.mc_vram_size &&
+				adev->gmc.mc_vram_size) ||
+				(req->address >= RAS_UMC_INJECT_ADDR_LIMIT)) {
+				RAS_DEV_WARN(adev, "RAS WARN: input address 0x%llx is invalid.",
+						req->address);
+				return RAS_CMD__ERROR_INVALID_INPUT_DATA;
+			}
+
+			/* Calculate XGMI relative offset */
+			if (adev->gmc.xgmi.num_physical_nodes > 1)
+				req->address = local_addr_to_xgmi_global_addr(ras_core, req->address);
 		}
 	}
 
-- 
2.43.0

