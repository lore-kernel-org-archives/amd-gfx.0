Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74058C5DF6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B928910F709;
	Fri, 14 Aug 2026 21:03:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zX8eCSgN";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 722B610F6F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0RJdCnb4d2Ce72RhqZF0+YQJwFyK6E1JDIIPZkbZTrmXJloZLAoFU47zxp+HUftyN3fIxU65gv3W6ami+dBJYk5e9XY95X/zuDm3AZdzcZYcrsAiSJiWFFsBYppbx6Y0ADslxABcUQzNCYiUoNJgRXBDfuYEzYD1r45M6/CA8t4YYl3X47TFZBHSF+vMesF0qCID5v36/Jnqjg7J/aX4XGRCaBQ2/dj2LnNpSEycKL4ue7pKsoVOs5ro9w+qQVSuMUJgAvJ8ru/dnKwFiliUAZjQUr2RAQ++rnylHBdtwVzpZV30ZgesofEAJgVSEH7s+DcU4t82U1xqYAxF71UWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wi/HtnbGrP0pE16zpwCQjXmdhj4SJdYZz1pjlpH5P2k=;
 b=F3vyezt7ZsC6x0ccnkRZ04P5W8gpecgrCVRCt7RFw7ODwhkExHZTlaUzL15q2FAplC39J8vGAWj/qOpW0uiefTusIupGJUalDPSynw++p0neKbPr0CmUtYNlZiwW713RbaN76HJbn7AWdyMd0sVDbWsHsHE9VkAJuLCOvL4AuFR0gjCIQh4CgpwmWuAcYbSkqBJJKGHV5gwsDMJNgxUJuzrG2M4goUf1/avmO4pIUL7Hy5wssgpwNbQxRrsd2mYvwx0UhkcWnnnd2eb34zkC2wSqJsIuw2R3BGugfwW3RCyC3C7036cEKXse+YKl2VkIf4KTpjoTQayXwFuP86MP8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wi/HtnbGrP0pE16zpwCQjXmdhj4SJdYZz1pjlpH5P2k=;
 b=zX8eCSgNX+pXf4Ce5KUYyn2PQyGS0GVc0jC+2O3j+HUh9UY1RJuOyjJoYhxUbs5MlZwXDIhUqJR/r26Fjs5zAX42hY7RyynNwq2rcnY2YuWQxSoAnTBJvF/nVC48uJG+4iAXzM0hbo/n5/F614qrsWGGOZRiTXZLhjYDlqjdJ7U=
Received: from CH0P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::22)
 by PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Fri, 14 Aug
 2026 21:03:23 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:ef:cafe::ac) by CH0P220CA0026.outlook.office365.com
 (2603:10b6:610:ef::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:22 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:16 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 032/109] drm/amdgpu: update UMC active_mask to u64
Date: Fri, 14 Aug 2026 17:01:29 -0400
Message-ID: <20260814210246.3067612-33-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|PH8PR12MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: a0abdb66-48f0-4736-a057-08defa4779be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: FjGEdZEccMBVYJTDYv+NS7OJ2doup97S8d+OsGD7MKlGQezZuoZFWW4lu7b9ppyTyrX9QlFTTfdCNWXD+QMlaLF5A5OcvJM5MgRs+yA56x/XkmA44k6ZXQ5HZo5/Lq9FehulZlCQQOSAx47oJcohnfCgs4Un4NTveDh0G7SV0agGqupSZ0wXuCjd3Lxd/HXe6gdsI2dcb+IKy8FxZMAygXWjBmlsLvq6jc3Qb66EFhz6WFYC7Ic2wNUh/y4/V8fMqzcDdPf+nXnQY0QZiMUs2yaE54vG3OMrDUbU15A26R9o3GjcOXQ0OTdBscbf7OUIg5GcPneSXvsfpcCXtbfSrEpY2wCDLZAhv4o/MkzVG8zsaC8jdcROesKx2XyYEGXECCeseZ64IAdxhE0pTqdq0ZPm5hLnHB1AainJzCcjfo6esOcDxRw2gYpFiN9gKyg89xGU3XJEDRvxfmGQk693fh7B+PVG3FhlbQ0/eO0pl19Cv1UgMAf0gmEFcKqh7ErtJ4ZvoKV3Xb77Ku4DKYXQWkdc1BbCRYvi2YS69SISLjQ/Zf1DiAUjvYCVIXUGGzYuJ+/Drcll5yoPwKzMFb/nig1rgC/gS4OP1Gw2ibA3O/y8CoO1KBXNfDg69qCM14Pktwohzw0g6FAiM+SZ44Von1DnnRuWNKhXUXeRMvksIrA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c/9/+GDypQWUkG6W81X8u0Cl1Hu/5aXBaLE2tjh12PgajfqN2D08R1t+Xezre/76Dw0F0dEgt3I6qJirCBSAK0MXPI72KWoaqrc/f3ovE400GgCIiMwAWBdWj2G5NgOFj6BSoAMRBC7PbX82ZRKOxXl9AZEh+M2BeuqZqzXphjb8usvMenZ9141fvRna0nnV9rdR9Fbkm4uVg5niuxREQXb22itN4nP+e05PS04cEP9q1In68TaArvV4JB2pzyWQTDbJnjOnSKJhwmj9ZwxouwTXc1s8AftnM5teoExk18oOCG9KsPRsafzaxKKpCV+B1WbACi1TXRRDZvL4/STihCknv14TXXXw1bPQTTO4Su0QeYi9UXj75IVx5KsAEqJAyEjIQN7lFyfCx1KmiiWCQ3KevrmciNLR5d4jgFJ9oRVPHKUyHuDI/gOo+4P2eoxg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:22.4789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0abdb66-48f0-4736-a057-08defa4779be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159
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

From: Candice Li <candice.li@amd.com>

amdgpu_umc.active_mask is widened to u64 to
match 64-bit harvest masks and avoid LP32
unsigned long width limits.

Fix UMC harvest bitmask (drop le16 on u8, use 1ULL shift).

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 25 +++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  8 +-------
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 986f307630f61..34702e5cb1b6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -21,6 +21,7 @@
  *
  */
 
+#include <linux/bitmap.h>
 #include <linux/sort.h>
 #include "amdgpu.h"
 #include "umc_v6_7.h"
@@ -426,6 +427,7 @@ static int amdgpu_umc_loop_all_aid(struct amdgpu_device *adev, umc_func func,
 	uint32_t node_inst;
 	uint32_t umc_inst;
 	uint32_t ch_inst;
+	DECLARE_BITMAP(umc_bitmap, 64);
 	int ret;
 
 	/*
@@ -435,9 +437,10 @@ static int amdgpu_umc_loop_all_aid(struct amdgpu_device *adev, umc_func func,
 	 * umc.node_inst_num = maximum number of node instances
 	 * Channel instances are not assumed to be harvested.
 	 */
-	dev_dbg(adev->dev, "active umcs :%lx umc_inst per node: %d",
+	dev_dbg(adev->dev, "active umcs :%llx umc_inst per node: %d",
 		adev->umc.active_mask, adev->umc.umc_inst_num);
-	for_each_set_bit(umc_node_inst, &(adev->umc.active_mask),
+	bitmap_from_u64(umc_bitmap, adev->umc.active_mask);
+	for_each_set_bit(umc_node_inst, umc_bitmap,
 			 adev->umc.node_inst_num * adev->umc.umc_inst_num) {
 		node_inst = umc_node_inst / adev->umc.umc_inst_num;
 		umc_inst = umc_node_inst % adev->umc.umc_inst_num;
@@ -470,12 +473,18 @@ int amdgpu_umc_loop_channels(struct amdgpu_device *adev,
 		return amdgpu_umc_loop_all_aid(adev, func, data);
 
 	if (adev->umc.node_inst_num) {
-		LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst) {
-			ret = func(adev, node_inst, umc_inst, ch_inst, data);
-			if (ret) {
-				dev_err(adev->dev, "Node %d umc %d ch %d func returns %d\n",
-					node_inst, umc_inst, ch_inst, ret);
-				return ret;
+		DECLARE_BITMAP(umc_bitmap, 64);
+
+		bitmap_from_u64(umc_bitmap, adev->umc.active_mask);
+		for_each_set_bit(node_inst, umc_bitmap, adev->umc.node_inst_num) {
+			LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
+				ret = func(adev, node_inst, umc_inst, ch_inst, data);
+				if (ret) {
+					dev_err(adev->dev,
+						"Node %d umc %d ch %d func returns %d\n",
+						node_inst, umc_inst, ch_inst, ret);
+					return ret;
+				}
 			}
 		}
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index b2a3db60d231e..9e6d8681b0731 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -45,12 +45,6 @@
 #define LOOP_UMC_CH_INST(ch_inst) for ((ch_inst) = 0; (ch_inst) < adev->umc.channel_inst_num; (ch_inst)++)
 #define LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) LOOP_UMC_INST((umc_inst)) LOOP_UMC_CH_INST((ch_inst))
 
-#define LOOP_UMC_NODE_INST(node_inst) \
-		for_each_set_bit((node_inst), &(adev->umc.active_mask), adev->umc.node_inst_num)
-
-#define LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst) \
-		LOOP_UMC_NODE_INST((node_inst)) LOOP_UMC_INST_AND_CH((umc_inst), (ch_inst))
-
 /* Page retirement tag */
 #define UMC_ECC_NEW_DETECTED_TAG       0x1
 /*
@@ -117,7 +111,7 @@ struct amdgpu_umc {
 	struct amdgpu_umc_ras *ras;
 
 	/* active mask for umc node instance */
-	unsigned long active_mask;
+	u64 active_mask;
 
 	unsigned long err_addr_cnt;
 };
-- 
2.55.0

