Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D486C28B28
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 01:02:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B507A10E1E6;
	Fri, 14 Mar 2025 01:02:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dl8ve8Y+";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E242710E23F
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 01:02:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjgJTyuFTPGW/GxQUUS++Na0n+LQ/DM0OgU0ZY9Mpa+hijrQnN3XqBm+/sZcfr7tU9yInMpbIrB4kZ7QIobwLcY1zpqkAneYHJWAJLElOOTKr6G2jRDzhrj9phI8sJzjXLHXJ2rBP74JAQW2Wgtq4C4WSfRMumMiBi79af8DdQVzXIMQzUIyQWFnT57mGC/cqiXgr13JJZi/y8uTR58042xPMIOR/cDVAgicxXU4U90FgcN7/lRYURK6yrUfX8nSxPe7VDId1oKrV9Jxb08Q023ZzLbTth8cYVxm6oSFzyeaIBKQMX1SbkIikk362wZ5eR3NyOXJ9GAwLCNUVb/9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9EertgGi+8Vu0P5DczT/fhzPE7ntBPvr6txSUxA5Qw=;
 b=sFuesU31NxAPLIaxR8Oa+NoxjfIQJrwhiiO0A6uqyxdzW+jKmfhp48RlB0eL+lkTnGOXPpQ3IU82QK3aXUVjDCdLFWCu136NY3A1kpUlSeRfF5eAmos5IGFGSCR1kG8udTQuV1mvTYPkUjB6t+r5uwwhywOiRoxNMWsyQGno8HFIIqm4khjwQwMW4gZ6VGdyHFILEOtLk8mYSLIpdRJ9LM+nB0b3cVvOLFyneFeOCHPE11IyrP3Ci2qTktOR3FnzDLjyWX6BW9ysKSoQVdN+/yna/zaYcjjQ9/SNgY+oO2n9sQdZt3gD8sfhT8l7mXBgMGLWXuj95YfaCU14jtltMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9EertgGi+8Vu0P5DczT/fhzPE7ntBPvr6txSUxA5Qw=;
 b=dl8ve8Y+CJMfh146inCJurgpa3syaPdHqNasCRSG3JLx4MaQyHEsOJKfItNDN4oMvsY45WmnRKegJTeDBVdcBHnZ8iElMF9hJAC8wFl2QTX1f+/vDqhl+HpZwl/VJE512iQ+1GEx+5wyDxnCrVthxn0Esuk94TsPivRXJrGGyq4=
Received: from CH0PR03CA0119.namprd03.prod.outlook.com (2603:10b6:610:cd::34)
 by CY8PR12MB7148.namprd12.prod.outlook.com (2603:10b6:930:5c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 01:02:06 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::6b) by CH0PR03CA0119.outlook.office365.com
 (2603:10b6:610:cd::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Fri,
 14 Mar 2025 01:02:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 01:02:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 20:02:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Kent Russell
 <kent.russell@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: drop drm_firmware_drivers_only()
Date: Thu, 13 Mar 2025 21:01:50 -0400
Message-ID: <20250314010152.1503510-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|CY8PR12MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c9c2835-efd3-4d43-c0da-08dd6293d676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l0gg2diisa3qo6hCjuPOMg5Oc3wHTgFeUizYl+UzGZApjAm0+e1anbOh2cUh?=
 =?us-ascii?Q?cq6CsjIUx3N+QVG4g0ZtIVTXh6R8pASJi6HX8ZqhfKxaw6A4lmDvmB4HeBfd?=
 =?us-ascii?Q?Eh0XRYdGyNyrfHuriAL2fQw50EBJsN2nxcs/f9rw0RK358CE1YpsjmNPL8t0?=
 =?us-ascii?Q?Gs7o2AkP+f8fQQP+pkJq7YuX3GVkSmghxNZI9r/ufIgWb6vvmLv5KTlQz54v?=
 =?us-ascii?Q?22+NznCgj2iWE/QtqZjMWMH6YgSmMje6VFvPVyZk17hjSEe1JWKaD78qu3tQ?=
 =?us-ascii?Q?lR+9bN10FFVCHahweaZClRdQXSAuNmqkK8C0Gsy6xmyH9DkZb8JBOKksoUpR?=
 =?us-ascii?Q?MmNYuTJJGhCmCqv0Ya2HAr8o9H4Fv5mvbgDdExTRI4lqv+4tTjIx/llbBd1E?=
 =?us-ascii?Q?gQVoNWK/1mAo77wckj4M0tNfS4X2oJChUZr6aH1vQLZ+hwpZ/OjQsBshWU9G?=
 =?us-ascii?Q?zZqMQgx0SojLy13RlWObFqP93TfE1L6zjgokV/tccuuXNHnih/X35JCBWuTz?=
 =?us-ascii?Q?fdymHRqbVH40hrMUtY9Ee2iE+Q7K9x4qqiDl03gAI3BkpoqjK6OF8bdq9Kgn?=
 =?us-ascii?Q?nXgxlEyLY5wnll+Qt1ttKuq7RlXJmd/Hu+WlsyJGvLQJPeOYjGn0EoxO+acH?=
 =?us-ascii?Q?3//1IAf3uDs6acMkUh4PiAnBvyF9yhAl6q5YVH08gsWBjlS6xOaznvm0T1R5?=
 =?us-ascii?Q?GcPjefKxSvNuWr5SvkK8YZFuYfirAznuJbr+c5/OwLH9MH0usNVIS90CjhOO?=
 =?us-ascii?Q?vSGcP1NPZ2B+G/q76WuS56IsVNgotZbUmr4r+WLmEWUUYXcQOWG6knHOx7IZ?=
 =?us-ascii?Q?XV5Qxcc9ENN2w7YGgLHuHDRSWtCUOBoi1FElo1G+t7dLs5URoBv8oAnTcYsq?=
 =?us-ascii?Q?TBzGo0M0byFu1HNmdR5nq+FQ8wPhIGdDpTEnXtIu2XIS0UpvMWjNo/5NZb+D?=
 =?us-ascii?Q?fNpZf+FFY90zxaSIJbetAbBvUKnQbWfjen85EXN5KEIKGzW8h9Os+aSUt/wo?=
 =?us-ascii?Q?8fV+LudzeIb8zffziHSZ6Fpohy6fzwt9b55/rjbh6ouQ2dcFhSCppX4TOUf8?=
 =?us-ascii?Q?rDoqdaCCiIgDnKrlQatBrFO2tEPkDlyShke45QoUFxH/jUWAPIaGIYqFGm3u?=
 =?us-ascii?Q?VaMZRqJoT19iqiXf7/FtfQNRub4i5cEcNJSa2RTpOU2V8/PsjzPkkYapzHyE?=
 =?us-ascii?Q?GOhclLXX/2t6MnngX4Bj512HkRM7TQJT+IZ7QTdl2PAY1SzeDdPGm8AvNMro?=
 =?us-ascii?Q?pDBWlYv+MX4eK77DzNsGFIlUNQv3uInIWLjzARLhEB7h/1hw6IfIq9cR2miS?=
 =?us-ascii?Q?e3E/TGLEbqRF4cE6PsBCXsT36NK/Zj8hC0yUdSLUQaqBG6HsdJF0UYIVViz+?=
 =?us-ascii?Q?wDpnxuGBSBhFNNkpg5NbHTVoo43IWIGFrC2vEbuFAe2ZDurS97fYUmW0Msub?=
 =?us-ascii?Q?3EuV/e/DxHeZ66JkCn3QWdisUMSGMJsnBOT+OsH1dAyuB0eSMrvzsLg5BenJ?=
 =?us-ascii?Q?LI+AF/kG8kr4RLU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 01:02:05.3518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9c2835-efd3-4d43-c0da-08dd6293d676
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7148
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

There are a number of systems and cloud providers out there
that have nomodeset hardcoded in their kernel parameters
to block nouveau for the nvidia driver.  This prevents the
amdgpu driver from loading. Unfortunately the end user cannot
easily change this.  The preferred way to block modules from
loading is to use modprobe.blacklist=<driver>.  That is what
providers should be using to block specific drivers.

Drop the check to allow the driver to load even when nomodeset
is specified on the kernel command line.

Reviewed-by: Kent Russell <kent.russell@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3b34fdd105937..dd86661153582 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3022,9 +3022,6 @@ static int __init amdgpu_init(void)
 {
 	int r;
 
-	if (drm_firmware_drivers_only())
-		return -EINVAL;
-
 	r = amdgpu_sync_init();
 	if (r)
 		goto error_sync;
-- 
2.48.1

