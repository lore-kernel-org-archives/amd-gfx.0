Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81B1CD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:55:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 645E9112DE2;
	Mon,  1 Jun 2026 05:55:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qsmmKy7n";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56E14112DE3
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:55:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYXajGOEL55wReUWcJdtxYzIApGRLZQomAIElQFM5+yRugu8+yykf86281811g3hS8qeBTQZV6+Xk8MWJZqsd+OvqVf7mJ3FMoITlznjI0dfufKbxjQH8tmk2jW7alXLJxpmc2jN20MapvnnIA1iQ5wkbUDrt1WZcfMv02oD6Gg9HWaMyH1ch5Wr098D4aSsx/grXxFoUa64YJjLyl3/x+3evPmOeFrxa8abEq/kWYgCtGyXIbu6akSHmAklaGV7U4JgRC+U0hfdYoo3aQQY6bW/CtlpE5BSuTLjbD7J1hyeqR1+IqNTT57bKYeHYr4bAYGlmOW6IraZ3p1uhWgndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSPVZzf7/C3U7ZTSDJb2ShuNuO7CbZ+TUczbKJoBhVw=;
 b=iuGgz0BmlKd0K07ZQbTsqtHREObaj7BEuEawyiAIpdPdl6xbDc2QzlG/kZbPR04BkTMqsqSk9TkQJ4psh3+F7PvWUBcydRUZmP7uKiFGSWGO72m0xhhwmF+wUJnewBD3AfHRD/fYtxkazvWx2DWdlK4UuMtoul4VG/75WzK3Goa1RGflHFx+B36w7iCYkaBQFwZz7UV9+Knn+ERKYEmdSAWc7i66ctGex4gBVUJ/SxZbFiqLCFpSTDWy1Nbummc5MbXpbq7J+xv7L5woyZJ2q0WfsOyjuGMuXg1DamH85cWudjjs98wuO0unLwO63iqqeN13m9365g5hZqxR1K7HxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSPVZzf7/C3U7ZTSDJb2ShuNuO7CbZ+TUczbKJoBhVw=;
 b=qsmmKy7nLPMr0hFDcWxKJ7zOfB9s0cbURqGtzu0CKvKc7yKbkhpqBf7uZAKlk+R55nvQb8ZC8V3EaxLyzScgFv+G+XJkl06+V5yZgPCztUJ5BWU8AAtbLRaBAMxE1skTknDGj/Z+BgoZfHhENpHiqAr7QMbU9xglIoJcPgLK23g=
Received: from CY8P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:47::12)
 by IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 05:55:37 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:930:47:cafe::b) by CY8P220CA0028.outlook.office365.com
 (2603:10b6:930:47::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 05:55:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:55:36 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:55:35 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:55:28 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Amber Lin <Amber.Lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 41/42] drm/amdkfd: Update queue reset support on KFD
 topology
Date: Mon, 1 Jun 2026 13:49:27 +0800
Message-ID: <20260601055034.3700921-41-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba36de4-0082-4e90-0db5-08debfa2672a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: VCkktY1YgoZByvJmlfaqrnFR6kgH4riviXe8aqXq2B2c/emOP3b+pOQFGPe1q+OJZQx+tp1zftHx1e0JHaDOSo7Ol8oO8fnerEFPUIrp31gYs9JCNDYLgU3UsfdDiY8yku6IBsYSijWxPb30FI3vi6awPIXOs7z9Bz1UDPtWkOjxY+xTkjFSdKwixqFfe34FDJsniPYBCuBTexY+k5h0KkunFw7eznIhKGyS5XZ3zCq8XqjipJ2LKuqbvEQLXam0rGi5Uk2AO6ILfo7s9L5CO2Oy8ElZgaJi5JyQVCPtd+mqZzFYeiBvpivBiT9rAMuMmiHbnXMBMz2uWIx7s/DoxUvhpmdQU6ZJV2ZkNJVw3yM8l/tZN74Ut6Y/9AS5Sd+d2cetVIFqmaNj9EF5UPNxBiYi2rkG5xza19X1h/aNZ+g3RJKJZCnMkr3Iyaw9qdGLFur4/p0Q6jZi4D4nyVoCEURw26prcTJGldGIdZOXuBcExqnTuuAy5hK6nyEGK0du9ALxvg6+9O03aBDlQtiXgmcY1fF6fe+kXGmcvqNauecSguuZlwfpy3ukjzMhJbSl+ihNNzM+An+yccsal9UjUemo5n1pyq8zEPdC/k/G8KRYvdkxX2mQhrgQnWx5HPbeqvMTCpBwhB8/iUJd7B1McT/5FZ+prTjX4qh2Cmyp3qHrmeWRIpLcI3racGcnKwGRUpqaTFa3SVwUw3OUu1Hh1yQolcQX7VRur7cTR45THB8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4rE7DbyuchRj0A05tUD9S+k9maRCag1hLA9lVo3hrNuc5tfs1cprkd5dDbTEUp08GoKaE2fF1wSa5AhYcL9ObV7WfrjwtDk6xy8RUmWX1pmNGD2XHBAeBundRMZrPRVI1AzTz4FaAQU9urkkBEEUDr3vYFlhkK2jm5oFdmVLhJYASOTetKd8hqv1uQzdSAveloXB9P9q30dRV3HMyFamvg2VucBLNFpFCTS7QA/Dl//716aIeoS0SeQjaqVNTe4AlVKa9cdnom5YxW9DrQU4/DmXNFnuig2QMk1YENdiXTAcJ9AnPwnVGTkgawVMCokKPRU1Mwbquk+dfRwpPKJ2xagkpYyHTkTpd6oaXwE90wnmm+0HkGTdysSB6PygB7y0rNbQ13J+FnPa7/M3ScdPrzNgSlbk6DnhOByTGGhJsUkobAF6IAH50tMI8l8Sv40E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:55:36.9033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba36de4-0082-4e90-0db5-08debfa2672a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089
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

From: Amber Lin <Amber.Lin@amd.com>

Enable user compute queue reset support on KFD topology for gfx 11 and
gfx 12.0

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index f37c2d3c8416..c46f153112e3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2025,10 +2025,11 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 			dev->node_props.capability |=
 				HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED;
 
+		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(11, 0, 0))
+			dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
 		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(12, 1, 0)) {
 			dev->node_props.capability |=
 				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
-			dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
 			dev->node_props.capability2 |=
 				HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE_SUPPORTED;
 		}
-- 
2.49.0

