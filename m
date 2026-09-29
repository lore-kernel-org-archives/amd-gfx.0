Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A6ECA5FAC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 21:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71EAC10F0F7;
	Tue, 29 Sep 2026 21:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IMwnkg1u";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012040.outbound.protection.outlook.com [40.107.209.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34B3310F0DB
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 21:19:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrWPg4u1eo2IMFGYuA8uxkCdFzdfhy2d1KHOY/fydDrDswXgs69mJzoJGPISE6MwbMeO/+iphGwNWb095VrPP+Hc0tlW/utrtwxkJj2yJC4KNlIOsh3DlP9imFQOr0wxb2f3e4cUb6Z7TMloRuRxOWdukJpEO0cE1A6R5IAruDMKjE0PFDMONdBbXRWehw0pRQUAx0tYypsmIoebNno9DHJijgFLoplnSEHLieG3LNEdOSpQ/yVZTHtNUJByuye8FyKN4z1h1aIDE9XrL1WO8X9PUerX5tzJWY1IJC3EPvMC6ropg7VSL2RunOMwysqqoTthzJN66P57ZQLkQzSpFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDzb5NiPsrkOcUO1ppqldXbWJGk/ePeE2FIpiFSbojg=;
 b=XUFWL+O7hlcHnVYBP9/nwzDJdEqDEaqlD14qXyjATHA50goWvN0GqNePnuf/dJdli3wSu09Dp7yvHfdKvat8Sp40vq7nCCjfOIJZwbFsB3KE8aLorS9AsVJp64En3lkr8RNYVELY5NfbfePKiTLSmdSbMaw4wT9kO9GknsHp9BllDOeJ7x4OoIrazfcUy/pYjfAzjO8+g9mO0QbMfCZE4JpmIgwmu/2WiBB2ttMZlloEGSqwHka081ng92ovd/m76udMReybYPzU6HRX1EvLwb3sxqyA2Y6iwHoLDFgwv3MtuFfDQEUi0PE8qhiU49o8ytbTqpZWBKjDeLqXpRT6wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDzb5NiPsrkOcUO1ppqldXbWJGk/ePeE2FIpiFSbojg=;
 b=IMwnkg1uy8vmHS2E2x4tSDpRPDGTImo9AxxeE24X/4YqQ68DYrLQ/SInzXttCQwJdHIBy6/NEu6jDsdf5oNRevpi1SJ8utFESXP1VOX/S9dMgjg3nh+NlzcPDjXsyNW8ZlrR8L2kCAvJtcAsoDwx1xTnccOzcS6mcuon95HZpyU=
Received: from BN8PR04CA0039.namprd04.prod.outlook.com (2603:10b6:408:d4::13)
 by SA1PR12MB9471.namprd12.prod.outlook.com (2603:10b6:806:458::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 21:19:49 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::19) by BN8PR04CA0039.outlook.office365.com
 (2603:10b6:408:d4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 21:19:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 21:19:49 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 16:19:48 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, David Yat Sin <david.yatsin@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add SOC_V1_0_DIE_REV_AID() helper
Date: Tue, 29 Sep 2026 17:19:29 -0400
Message-ID: <20260929211930.2095058-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|SA1PR12MB9471:EE_
X-MS-Office365-Filtering-Correlation-Id: b1799efe-7c1c-4596-58f4-08df1e6f64c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|10067099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: Hejj0/6uEV94HQwIXfGBf7U/1lh4h+MHqAkuokmTeXOg8cYrqzKQfkc5Q+FTkG6XiqhX1413DgICvr5fkZhv7XU2l9bixLvoEvedGPYxFy88HRnyeRcnn9xD4a3k2ovLKyXGFrUpsO4hbM//oVTU9a1B6pIECf8ZpNYcl8MmuAua12q4ZcY8Qjg/mxeHDH6REvsU8DWJfIYt4GOfrMHf0pDIIbSlKnHOtal7djvWOnWKTFtcuSWt7NkIFwkeplOhvSmXFPGCOfTdkxA54Qhjp6g9glrNEltL/1cg1AaS2F9W60n5itxXeWzOGgBhCqTTL08y1Fylw8xpGf2UOBUFQlm9FZM5jBr2fv+0ooF9iE9zfA3VYInjQcdV2sXuseArP/p+J3aQu78ObqxFQO1houP7CFLh8A/h88XI5kvqwEUp+8n+LbbwVqv5GfApSTdfAcAjMqyx53wvru+dKsDJk0CRpVXdBNgJ/Pp0tkPYQk9oKkciWrB7w8jbidT1dI2iAz8l5GrdvfhTP+Cp0O0FDWG9vztZIiRurNhotzw+m1k5DrCLuc8ee5l1l28MOPd6MIXFuuOmX2TYF9+o8pTcbGMbXjQypYO2Ya7CTr3saV27RUWXjv/IsAXe9ZZXB07oAPBeZ2oH7C4xvBg8EiKo9xno53Qn1hD2h1V+Xnd3bsC/y9p1s3phRvMypEiVn+qdSZP8DRw3I8SLwCOKYLpUKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(10067099003)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DLVIszfziVZR5uDdGOivdouRJ/UWMSMCJeuHIDYUh/gvCGEuAW+miS8rZW7hapb74BeElx/MnzmBUmnUQR4NXjAWYf52lh7ZAWVrSt4PuvQeEz57cVuV5uTkefu+jZ4HrQcQ4ovNXTRCwAB39oiST5guUpTVbWHeTBuhDEQShimP+d4nyVBJqHmgvFPChcsaP09AKLEMpGakJsWx7PJ4tUdTQqIo5uCpVClDq7XDfuUOM5ia3VA40An4ebulZve9VrJzZqjN0UNx4Bk4mYk3M/gIb61ngDgTW5nd/6c/dnC5iy/bwwm5yKXK+jyhGANOcBeItksyC/Bv+cMgKgylTddw4NkqefSemrcsgtISdHRW/VM8QyNUkRHVlC8etzybV2wf7qMeGnpySlapObZugJ2IfRoy+xdRAeFfycNeEE9vgmFgMZWZ31UFj4qftn9B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 21:19:49.0390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1799efe-7c1c-4596-58f4-08df1e6f64c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9471
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

Add a helper to extract the AID revision from adev->rev_id, matching
the existing SOC_V1_0_DIE_REV_XCD(), and use it instead of open-coded
rev_id bit checks for AID A1 in gmc_v12_1 and kfd_svm.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.h  | 2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 3 ++-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 839d76183755..e056eb80b3a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -23,6 +23,7 @@
 #include "amdgpu.h"
 #include "gmc_v12_1.h"
 #include "soc15_common.h"
+#include "soc_v1_0.h"
 #include "soc_v1_0_enum.h"
 #include "oss/osssys_7_1_0_offset.h"
 #include "oss/osssys_7_1_0_sh_mask.h"
@@ -627,7 +628,7 @@ static void gmc_v12_1_get_mtypes(struct amdgpu_device *adev,
 				 unsigned int *mtype_local,
 				 unsigned int *mtype_remote)
 {
-	bool is_aid_a1 = (adev->rev_id & 0x10);
+	bool is_aid_a1 = SOC_V1_0_DIE_REV_AID(adev->rev_id) == 1;
 
 	/* Local memory: ASIC default depends on the AID stepping. */
 	*mtype_local = is_aid_a1 ? MTYPE_RW : MTYPE_NC;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h
index 9bff7cc60121..861862bd85b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h
@@ -46,6 +46,8 @@ extern const struct amdgpu_ip_block_version soc_v1_0_common_ip_block;
 	 ((xcd) << SOC_V1_0_DIE_REV_XCD__SHIFT))
 #define SOC_V1_0_DIE_REV_XCD(rev_id)          \
 	(((rev_id) & SOC_V1_0_DIE_REV_XCD__MASK) >> SOC_V1_0_DIE_REV_XCD__SHIFT)
+#define SOC_V1_0_DIE_REV_AID(rev_id)          \
+	(((rev_id) & SOC_V1_0_DIE_REV_AID__MASK) >> SOC_V1_0_DIE_REV_AID__SHIFT)
 
 void soc_v1_0_grbm_select(struct amdgpu_device *adev,
 			  u32 me, u32 pipe,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index a99dbedf3cd4..f99cb18e8e11 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -34,6 +34,7 @@
 #include "amdgpu.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_reset.h"
+#include "soc_v1_0.h"
 #include "kfd_priv.h"
 #include "kfd_svm.h"
 #include "kfd_migrate.h"
@@ -1341,7 +1342,7 @@ svm_range_get_pte_flags(struct kfd_node *node, struct amdgpu_vm *vm,
 		mapping_flags |= AMDGPU_VM_MTYPE_NC;
 		break;
 	case IP_VERSION(12, 1, 0):
-		is_aid_a1 = (node->adev->rev_id & 0x10);
+		is_aid_a1 = SOC_V1_0_DIE_REV_AID(node->adev->rev_id) == 1;
 		is_local = (domain == SVM_RANGE_VRAM_DOMAIN) &&
 				(bo_node->adev == node->adev);
 
-- 
2.55.0

