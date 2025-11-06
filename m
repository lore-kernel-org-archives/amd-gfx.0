Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19BDCCFA03
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 06:16:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54C0C10E81A;
	Thu,  6 Nov 2025 06:16:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qRY2bhEJ";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012071.outbound.protection.outlook.com [52.101.48.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8B9010E81A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 06:16:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlZAjsaURf4Rff3+afL/fHGHxmlc21F7Uj1WdoJJjK7Z7+ZABAAb4i9MWME8wz/R9SdSznpBswN6UcCDV71VDuHPq0H7/qLdCUqWRWwY4HmfZIIf0GORQK7q74u0X8jcP7cgrku01PZ3+0JK3ijMZx/u/XPxvSug+croa3LcSCMwK40mnQZYs36cLOFSAagqbH4kquyQNMh8yl7GqWpVPpFIIqwkjkKB4C0CnB9drK7XMkvPcuJmiO+h/ytc8HsP9rmYdbrIBAT9wU4vWlIgV86zaOJOpd03GGOSYMBKnLoSos9CA+1Z2Vc+T2j292DHpa6oXAR7kuLs09SZAILNdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rp7e0tbijkD9Mefu3nTNSE4CSIqZJ41k5l7Bk5TNe6U=;
 b=Yqsi1Zr3YWg/wcatBUq0dCTcLMvI51HAxhWMCx3rkyRvneUrcRkj2RbltqLTruwsmiDMy7bhHHR1oKgCYPQzeuwB1Qpq7jQuLmuQH2SaqQ4MGDHCnyJExMSnYzSqdzOv2rcPuyhVETLaRO+n73+ktlDbpiY2PArCVTbmzLyiOGJUk8nqtf4RzGwgJVMmr17sPV8pWAXPP6GiS49uiKC0os2aVXLNh+WYtiiqU9wvbXgj0URL4ooQRHNlxRDXuP/gv3jvKsnCtyC6Xdy9QzfZI17bMeAgGlAO60+ZBjO3ezp/6qz87NHc9+YCfR7uaglc1fqGI9MMk20hiZuwdoK0QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rp7e0tbijkD9Mefu3nTNSE4CSIqZJ41k5l7Bk5TNe6U=;
 b=qRY2bhEJgJTFDQuTYzYGthShSnf2Ro+v6o3p6ufYvBIpzlUzvP4qeLabpVSfDP3qtkQRLUWJAIV8758d5Rq+oXwjbyQ7XsMxtIb17BBRvJX0dTeTDjyU94O2Tu+XeVY7+Dskkr18bcVdkvHlcGxdlkVEIOQ+bIA3oP5FiO85jfs=
Received: from BL1P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::24)
 by DS5PPFD22966BE3.namprd12.prod.outlook.com (2603:10b6:f:fc00::662)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 06:16:01 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::44) by BL1P223CA0019.outlook.office365.com
 (2603:10b6:208:2c4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Thu, 6
 Nov 2025 06:16:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 06:16:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 22:16:00 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 22:16:00 -0800
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 5 Nov 2025 22:15:59 -0800
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Aurabindo Pillai <aurabindo.pillai@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>
Subject: [PATCH] drm/amd/display: Enable mst when it's detected but yet to be
 initialized
Date: Thu, 6 Nov 2025 14:15:49 +0800
Message-ID: <20251106061608.361341-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|DS5PPFD22966BE3:EE_
X-MS-Office365-Filtering-Correlation-Id: 40973b3d-459f-4fba-cde6-08de1cfbf532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bTvIGkMcgkVfyuhJCq7rPOGjGwTsXod7DBtE188ewYeyAJLvKgWNskfB2fMe?=
 =?us-ascii?Q?9zy35nE8W2leuIi7I/5kJH740r3ZkBzv4vuZ1QJRjmFJD1JuZgmEvl5n1dMp?=
 =?us-ascii?Q?ReNfFNtWZAVitN/cuHKPjkwfBUUrtgl4n7x5tF64OmI1RUOpLT4p0DYbnPpX?=
 =?us-ascii?Q?R8k2ouqteMuY3LYB6i1DT1zzgyv+OaPnzf4QDA2UiiXo1bzT5yCvSomI1x+I?=
 =?us-ascii?Q?ht+0Bnv8+rS64F4zPoVw0PJUUYBEPBjdNNhOxYWfTnYac5Y8Dqw6X6qU0p6t?=
 =?us-ascii?Q?w6H3dleyRlyMjMZIkje1nkfLi/5fejqquZNtyD3nhbbc8rBs67BMXdHb3Z8e?=
 =?us-ascii?Q?DAsgN7yQra28iXY7tG9HFV6CDJvxFEqw8+gIxQEfeYyyU89YCgMSygPEX+hu?=
 =?us-ascii?Q?nQ1vz6P0roYJn96r/40BOtKbDXPMB/ARsUqs+cJv+MlqZlxAxVh9irrBoEnC?=
 =?us-ascii?Q?dUAxzS8Gp4WmeBBKBV0G1jYsrKD/p40NivR/JIT7DQjfIqWYo7/jvv9iflxj?=
 =?us-ascii?Q?qaW9vH1/pNbR+M678O1nYCEfG91wUyiSoKeIj2qnxfdHUUic80OwVUpiZv7W?=
 =?us-ascii?Q?I7kcIToBpEbaufWENXzxCani7PyAqpEEK8UERQOaOTPD3reoBcl8K1BMJ3EB?=
 =?us-ascii?Q?t+Xcg3yQyRw37ebKknNA0hOyPAJv9d5Ycf6HxXvTbXDBBVT8878qfZI//sfs?=
 =?us-ascii?Q?CG1eFdt/dlGe8YeC5pKpNzQUUi+sh8NaEVscaz8lZR6whwSuifPWqsTB1XUG?=
 =?us-ascii?Q?HePbD5YPBa5qADrpMrhZwuYLHmNqapjRvlGNuD8JYQ7ls5wPsX2IQJ5Y7Ilu?=
 =?us-ascii?Q?fUnBO6ZxdxmsJAFRyd6CfsJsHNusuOrJLjdo5JNN8MOsg09N92LR5ewPRC/D?=
 =?us-ascii?Q?dscPs7f6y4W5BmT3w7Zr47jVLpSaqj7vIiVaN9ZlkBZCos35AySh+uH1RsIF?=
 =?us-ascii?Q?nyAYtpGRg0UmN7r6CqpOWyS+EckbcGVCjon9eO1y2RDxfXkMWYp+C4JuLfd3?=
 =?us-ascii?Q?yCZLyTiAMPI3xRP3HEFjUdp9fk018xPV64pc5KXo6O/Cqy9aWuvjER6p1JPc?=
 =?us-ascii?Q?XIm3I2/nKi1gSjOpuHapUSvMbHy6up0pp6I1dX2ynOwSlwrglXgqjdsoJYSs?=
 =?us-ascii?Q?WhSdNtpg18pGJx2t8o1O+5HBnZrmdIw4ZH4mtBVCsl2qaxvMYCJU3+Nt8Ybe?=
 =?us-ascii?Q?bqDg4mgGwmdNTXHn+rBQNcMMEIImDsQyLEaOiwVUv/XY67ahx7gIs7mB/U/Z?=
 =?us-ascii?Q?iHNLpNIanr6Jn3p+2UbUVv8Pa1xDnJMSGoLcu1sy0SDHYY8sezojb42vVW0h?=
 =?us-ascii?Q?gEVBsxNUzpVFqxeJ6RCGZPTxRoWwrUJmRUzWujdSDcj3mb+ZFknHpnaeIwgr?=
 =?us-ascii?Q?fIAIRqb5lYyzh5d0vOElnAw2iOULXYhYVe636xlRtjWs8Le+KFsDDuHkOxuU?=
 =?us-ascii?Q?7B5IgaMlZ7qYQ5ZOwCcDLxHm+HY3FdaRCxC7HExhssjnIFpT4dSD+KKSe089?=
 =?us-ascii?Q?IAks7yzQveLKwrb4uKOn0aImd3Ldr1dlEnAGRkhiWabXyeGl6kOHNYjTkY/x?=
 =?us-ascii?Q?37QxkfZjDPy1ZbKIF2SpEBfrSieCoDTckdSIUekz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:16:00.8857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40973b3d-459f-4fba-cde6-08de1cfbf532
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFD22966BE3
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

[Why]
drm_dp_mst_topology_queue_probe is used under the assumption that
mst is already initialized. If we connect system with SST first
then switch to the mst branch during suspend, we will fail probing
topology by calling the wrong API since the mst manager is yet to
be initialized.

[How]
At dm_resume(), once it's detected as mst branc connected, check if
the mst is initialized already. If not, call
dm_helpers_dp_mst_start_top_mgr() instead to initialize mst

Fixes: bc068194f548 ("drm/amd/display: Don't write DP_MSTM_CTRL after LT")
Cc: Fangzhi Zuo <jerry.zuo@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: waynelin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 35566ac9232e..ba11421332da 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3624,6 +3624,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 	/* Do mst topology probing after resuming cached state*/
 	drm_connector_list_iter_begin(ddev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
+		bool init = false;
 
 		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
 			continue;
@@ -3633,7 +3634,14 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 		    aconnector->mst_root)
 			continue;
 
-		drm_dp_mst_topology_queue_probe(&aconnector->mst_mgr);
+		scoped_guard(mutex, &aconnector->mst_mgr.lock) {
+			init = !aconnector->mst_mgr.mst_primary;
+		}
+		if (init)
+			dm_helpers_dp_mst_start_top_mgr(aconnector->dc_link->ctx,
+				aconnector->dc_link, false);
+		else
+			drm_dp_mst_topology_queue_probe(&aconnector->mst_mgr);
 	}
 	drm_connector_list_iter_end(&iter);
 
-- 
2.43.0

