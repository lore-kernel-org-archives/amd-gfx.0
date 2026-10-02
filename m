Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D057CA5FDD
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 15:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0408910E4DA;
	Fri,  2 Oct 2026 15:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jAJJTbr/";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6238910E4DA
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 15:54:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cypjTanYTi7Q3dvR8clgHmjZoCxsdfZYlTBaTq7DsbQYQOGhL6pXH0KCEmELqKL9fOaA2h59JnCVYlXAWwC/KC2lJ9MzrIuwh3JucuqIzaNXDrJ0fxhWMx3pkA+1m/vjO9yU17rr17CXGwGatYWQf1UCoA011YmHHNi0+Lw+w3oJMdcY6L4Fh7QqpCXb9Rj1IFkPnKntigyqFpzPYDIZFO4Llyvea0hNUUyS2RuE1SwC+LXpuKNZRavbhoY933sUgZ9dZbY7QpEIOV2iOKN8v5nWGNpP7muaq5g6RsaNeoq0/I/UW4ZZl7mWZ7Fm9D/dl9S242Ij/LRNEDe5D17YeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tK8uISeRFzjZcCAeORuBD4pOR/d6EdmD9mbbX98qCcA=;
 b=a64qYAuwmvbHx8YO55WR8YV1VnrKC9BkXd/tvNAv5VDrEd7rie7gGEyajj5V2Sd1mpnwP7Ljb4z802kcvTp7lCbfxkzG0EgG+/YR0jXB/BICtmUu1zJb83aMySngHfW1zEva6g6oMsel5ticQx2Wxbp6lMUAgSQ0j/0VISJalEdEYU2IsvlcttU0FqilGOi58fRSqRmHIufzqGF6lA2gwK5No5hUk76vvheYhLUuDuCNl6Aa1DGKxwyq6Tx47IjxXXCY30tNr7Wkemy4HutNJhbenHun1E41Hfo5VskC2D671lQSblK6OnROw+1yvVT1EPZbQhPg4CDC/0eIkKR75w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tK8uISeRFzjZcCAeORuBD4pOR/d6EdmD9mbbX98qCcA=;
 b=jAJJTbr/2+9cMdR+huKPrs9lQEEhVSGUvJgibhDA7EJstqPHA9t+09QrXm08RgLsJxQzmPD9+UbD4tk/MT2k3I4mao8wbvtQIN3lPUtK2cKGVT7AmKnY9YBgHPJ1QLHJL1M4JSWTcg2E+7lEggzR0eLBbGOX8zyQO/5RZhiIpTs=
Received: from MW4P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::15)
 by CH3PR12MB8481.namprd12.prod.outlook.com (2603:10b6:610:157::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Fri, 2 Oct
 2026 15:54:12 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::58) by MW4P222CA0010.outlook.office365.com
 (2603:10b6:303:114::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Fri, 2
 Oct 2026 15:54:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 15:54:11 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 10:54:07 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Mukul.Joshi@amd.com>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdgpu: Reject UALink source-identification address mode
Date: Fri, 2 Oct 2026 11:53:54 -0400
Message-ID: <20261002155354.332801-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|CH3PR12MB8481:EE_
X-MS-Office365-Filtering-Correlation-Id: 09404863-aa21-41d9-cb1f-08df209d66c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: Yg3H+VNbcsyVXE8ZljpCIoyvmbDMnNy5b/SzBu0Xr2LXfbxvQuOofaYi6dUj9licBZNNvEvmGRVKL/JSY/1gngZoDo4STPC2d78lbJg5YLI0sePlZNyymsapl/dof8xOj7lNa2uP/YE5l4j8A6pbY9KGJoo8UHYNwyuHDl5o2Ymh0HM6ymvdCIr8VSeOnA1YWWJ9NUDVM2og3D9EPJRzRpyEXAt/yA9VQvrCZ/0Nj6RM/ASwfkCILqG4MA5r3JXkL5KmS2To4wp7u/KyAPw9LxdtluoXGyXa4OkgX/fZ10KAg7HaupWK+5YGSmPg9lLXlrTFEZYUzsXsmg5iXsf/QYRi3UsFrYloRQfCSO0P9Y8kNLtxpsq378haGasULAGZdDpVCRpi52eA8jqysV0VDD2Tr/82T7RvXBB3NT81yQKrnWcUciK/IJ9Ob6bHX5A6DJcMthQTNe7e6sNWyqNSnwxTQACJQ6MrXfhtxkjIawJUVJCMXbEwsFRGMy9cYGe+MKsULUIWt9lEBmiCsFPGuf3eFLnfoepYXQy3ns+oi3UTkTGWv3qDLtk+rw0sOtxNui6IflX7V+EcGmuobmbVWbDKLQxO0cOilf0CooZuc3mGgQqxtA6RjspvSY7pB1Kj7ueZ17Mv1FHShGXs4UV45XBOKFytrBKdSQMx69GbJNNA2Jw8zVxPnBGCLZ8M0iZ1jNVH691fCgFyYdwdqrjnmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: J9WWSHrJ/bEKURvcqVE7G6l7xv19oqb/YGTvtrhPi/9zI4bRkl8Yzf9QFO/O9TwASw4AhYl6kmLr+qKsUeuxAyv4Eyc67fTEVj/S2ov3iFCrbiSts0AOUBtHDCGydFaghbrhMQ3SYi4xm5x3fEHyaCFovIyl96goo1+Uf7pxXgbbYedcO4sVKZPmoRmyCxqsmuXyx4dmEp4cR90HxDYE13isXK/DjquEgfs4jfxcG5MUyUYOpi7bnaSCtj1V/rspXPJZD43yXs0fLaTyIQcZ4Ji1aPot48YzEkgWtuXYACfJP/O6k+TaQxVkmINJsat3kdugaC1P2KmalNuFY1IGGFlssyaUl52lbPQnNk5/kBYA8hui0CeacUZXrgeSBA5RLJ83CuJZiYyrdzFR4OcqrPRGbK6xMhOUlh3EQR95U3sDvhQqy8+7hBXCyA6Lf99t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 15:54:11.5557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09404863-aa21-41d9-cb1f-08df209d66c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8481
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

Source-identification address mode has never been tested or enabled, so
reject it in __check_vpod_info() instead of running with an untested
config. Both the inband and the sideband vpod config paths go through
this validation. The SOURCE_IDENT handling in the rest of the driver is
left in place for when the mode is enabled.

Also drop r from the vpod-commit error message, __check_vpod_info()
returns bool, so r is uninitialized there.

v2: use switch to check address mode.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 3051fadac50b..758265670340 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -137,14 +137,21 @@ static bool __check_vpod_info(struct amdgpu_device *adev,
 			 vpod->size, ppod->size);
 		return false;
 	}
-	if (vpod->addr_mode >= AMDGPU_UALINK_ADDR_MODE_MAX) {
+
+	switch (vpod->addr_mode) {
+	case AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS:
+		break;
+	case AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT:
 		dev_warn(adev->dev,
-			 "UALINK: invalid addr mode %u\n",
+			 "UALINK: source-identification addr mode is not supported\n");
+		return false;
+	default:
+		dev_warn(adev->dev, "UALINK: invalid addr mode %u\n",
 			 vpod->addr_mode);
 		return false;
 	}
-	weight =
-		bitmap_weight(vpod->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX);
+
+	weight = bitmap_weight(vpod->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX);
 	if (weight != vpod->size) {
 		dev_warn(adev->dev,
 			 "UALINK: vPod size doesn't match vpod_active_accels list: %u != %u\n",
@@ -1351,8 +1358,7 @@ static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
 	if (info->vpod.id != AMDGPU_UALINK_VPOD_ID_INVALID &&
 	    !__check_vpod_info(adev, info)) {
 		dev_err(adev->dev,
-			"UALINK: vpod-commit __check_vpod_info() failed: %d\n",
-			r);
+			"UALINK: vpod-commit __check_vpod_info() failed\n");
 		return -EINVAL;
 	}
 
-- 
2.50.1

