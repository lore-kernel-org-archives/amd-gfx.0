Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A97CF886D
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Oct 2024 20:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A5A210E283;
	Mon,  7 Oct 2024 20:48:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xks+ieP2";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5930F10E283
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Oct 2024 20:48:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAmvzm8px8Zce5FMrO5Q2EJy5hRJ4l4Rbj03xjNIYrHh4a2dMA6ervznmyCAGMyyRTdL5ejYdag+6YJY+iD6cLYsv14YPLmwE9ETDwZvF4Zwb7YJ+wot5O0vNHnOpNDSjeSR/B6woTPX3a5U30KQQ0SUuK81BaYxYoxGIdtRHHaxhTxfzxrbbezviC04F5VYkJ+5+rsROxTB9b1ovFvYB9xNMwETcv1QmDl7avoGnbmE7cTBkeaX4aWCKz46CjCbVIDoe32TWlyBlcGhehEO1Gg5l/hXU9BxI/duOAvYCLflbw9f6j9bJXBoVL9QM1b4oiQZXKkm09kAI29zKbQl6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OsF0ZJcCgf9d6toL3YkX6Kcm1UKEGDRhqfcRmQGE1k=;
 b=hjGT+Gg2eb8V9R2kxARKl//i+TbjoeONd2L8h4yGt54k1LZgs++ynCUiI++6PGdJJpxL3mF4AJI1Q2fxeCjtpBurbiPpVId6vNI1WzRHfHxesAKctyMlgJgIImE31iG8//mOJqWwD5kQwlw/yEEseR2oL5Bc5aomGzrz1kr9jKns85/XwkDPTCKuFociSDzPqgckJq/KtNEJLGu9lRyH+OqLcv7vARLqABo9jHlyzhrQOkTNrzJDqRC7rRHfXd0bQSreoC6NPSIlKyXPknZK/k/NSM1FxqkSYpsX/avU1KNi9e7ps2SpOMzsmZ+9mq19HNh5sltHGhNTVJOXha4P/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OsF0ZJcCgf9d6toL3YkX6Kcm1UKEGDRhqfcRmQGE1k=;
 b=Xks+ieP2COWQ+dw5Z0hp88p+1uAtZZWsJj/zKntJdoCcP3HU6ni2TMtCf0Vi25Gc3ipLr4QmKv4IFGAXUZa2xpsCAqCnMUd+utBULTWTii6R7n1R/ne7hp6HtJsxyTihggdpU8KAgrue3/UJzFLX74strzuwWceqQpURAs3pG8E=
Received: from MW4PR02CA0024.namprd02.prod.outlook.com (2603:10b6:303:16d::9)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 20:48:05 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:303:16d:cafe::98) by MW4PR02CA0024.outlook.office365.com
 (2603:10b6:303:16d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Mon, 7 Oct 2024 20:48:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 20:48:04 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Oct
 2024 15:48:03 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH] drm/amdgpu: Remove extra check for CPX
Date: Mon, 7 Oct 2024 16:47:48 -0400
Message-ID: <20241007204748.1622984-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: e7165393-735f-4b29-2a4d-08dce7115785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6e0D+bXD45ikxLVA8BuWqPgBFCT7XfAMepppH8LyWWLvnyzFAcMKdoBhAeCE?=
 =?us-ascii?Q?AhfgdBwzh74twc4JeqVsShRI9+E80giXR2XJUK9tA4/PBF6dIwxyYRaIjgSs?=
 =?us-ascii?Q?xCCSEgna5MUylKnKRLPQvB7J/VcVQNhNKDSj46wJUyWNfvkZL7V3slBB2LnO?=
 =?us-ascii?Q?AqVXQnKES0YkXl15qgCwBHiWLCTvR62kN7kUejOAwBP0JeZOdkeZrwoOV0ne?=
 =?us-ascii?Q?c9ytWHGHCwTQZzxDLE1EcO1zbuieCgK38TYXE99imHSL7j8vOM2FE75tA40e?=
 =?us-ascii?Q?uD3VNBUh4a22qtaDi4dn4LzcTrkIT7rsqURabZ3q3I8dkLSJ2Pn3of3f0DoL?=
 =?us-ascii?Q?RdH1Ir5CE/YYf1giDTodfLE10yKPQ0XHjzsM7Eauxy//9Es9o5r7TnoUjqgR?=
 =?us-ascii?Q?Pl/mYZgS4lCymp7mDb12WpVeOuj2N4jEEuiVNe2ugG2JTlNmqiA7EkO0qYan?=
 =?us-ascii?Q?KTOMgu270oyIZMiW6gs2moxCtp6GBJgs9hNdf7V0cioqUCY/PR4UkZb/oqGL?=
 =?us-ascii?Q?McvY26/TQRRBdxs4yjkrrQnhNH+K4f6yKilp7x+AGULwaoc2X57dqCh5KYfV?=
 =?us-ascii?Q?QYL1klO3fBpkfrKoMzeGdvOqZh/QzjWQfJtWVd7omDetuuOIoOAwUZ3QHLI3?=
 =?us-ascii?Q?noHaRDg8mtYL8+wBtDqSlrJJdSteRXZBcUco4ZnioHk97z2Xu3sc5f201aUP?=
 =?us-ascii?Q?Ro+15pBvdBHchKMWphQzPSbHmOR1UBqaVIwCm5aDsgqMLFyE3OfVxF7VUUZD?=
 =?us-ascii?Q?+KGsSVcRFXqAnuTxRUg5lVAPMxN+FW0zGGJfBcq/WRSmoPhti5qJMkxqH6k1?=
 =?us-ascii?Q?ql0ZLrckis+iXB+IGjY//iY9l5sAOM8gUcF1j7nSF4Ihpy8/vCktxv2P59cu?=
 =?us-ascii?Q?bq/TmOwcRXeaKs5wIPS9QDoXn6UDi/J/pxhPQ7hUccm3/DoVceq0Ib2m8OfJ?=
 =?us-ascii?Q?bDyibGVB869nJMuu7ZqA9IL3k/GKd7KdDezt+QIWfOB73V1SVFXfLSlWTIRh?=
 =?us-ascii?Q?PNt970B0s3QfZ1IHAFAIvolE5y6ANMHcLJTPY1V+17ADtiWJoPc7DHF19gDV?=
 =?us-ascii?Q?ZUukqzS2HBVxnNEGqaeE0KSRGqxmkUD1OUce7EmljuQ8fOjHcYoF4gr5R2U4?=
 =?us-ascii?Q?RKz/EmYuBS3At/a8p2KKVxYjQGNLbm8vKGwCgOvN26Okbf9rLr0nx5L/4nXG?=
 =?us-ascii?Q?zd9Umz99K+a4TbeagJJ4qF2q5bVf7wBWSGO7fYOcS1DgaNKSnDCip4VTpCvr?=
 =?us-ascii?Q?yYRnA4tS/zWp8rty/xw+STy0BZfjZ193NRGWT7wRoto3gnM7ZkOsMErr6BTl?=
 =?us-ascii?Q?edjQlbBOKjmddp7eHlNOloNsckpxrn7aZm1x3h8OmM2DA2lwMU+MhNeW07jO?=
 =?us-ascii?Q?veVlLQY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 20:48:04.7010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7165393-735f-4b29-2a4d-08dce7115785
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
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

(num_xcc % adev->gmc.num_mem_partitions) == 0 is not a requirement for
CPX. It breaks NPS4/CPX support on APU.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 890976b7ce77..c60831a072fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -549,8 +549,7 @@ static bool __aqua_vanjaram_is_valid_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 		       (num_xccs_per_xcp >= 2);
 	case AMDGPU_CPX_PARTITION_MODE:
 		return ((num_xcc > 1) &&
-		       (adev->gmc.num_mem_partitions == 1 || adev->gmc.num_mem_partitions == 4) &&
-		       (num_xcc % adev->gmc.num_mem_partitions) == 0);
+			(adev->gmc.num_mem_partitions == 1 || adev->gmc.num_mem_partitions == 4));
 	default:
 		return false;
 	}
-- 
2.34.1

