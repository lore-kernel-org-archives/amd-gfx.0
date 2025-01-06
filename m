Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDAAE77188
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 20:33:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0839810E281;
	Mon,  6 Jan 2025 20:33:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rGn5J9hD";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC5AA10E0F5
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 20:33:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psT9JrQ2QfISKhanI+Hn/bdWhl+zbHdNgTlJywlHoriCdMESNagkSHj4q9hmSOemxqpqsYYLD3mWxUyi/kXS/liSNPht/7JZefz2x2liBO4wIMgpVsH1iK3Klvsx3x5zYtSmGDrCnqJD076VpkrxPWey3B2oKmNI5zVIzBNUC6PZS/rDUbMvVi7y5MLG00VPSwxvSf11dZMKOjTc5D+kqnRqCALR+10M/KpTn9xKk2A+qmOk1psiuTUQUqdCFfzALlScfUNHcw9BrNYHKdwN7diSscmCRb4I+sCXgYMceRJ96ORqOqpRl6KSxHh7ozECsjIH/FvEFCHIN2XWMKHxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZST+bjRk4U05b1OBAc8vtFLhMZrjgb5wZy85vMlxozY=;
 b=mTx0lPwVlwFdjT0DdbhObhl+QwVjVlNdKGT3Nl5CIJQLTk7wwzU61xgR6UnKMjUPvPsHssCABcJRiAwAMwvgTYZUj1GBNlxiHf4iu4HOIPBP7SsRTnBT9nZ13HaDQZC66jrE9x3HYr8aypcb7zlWN/W2/QvLRg/pKBJSUcD92On2W6hr1V61dRinH/kPcn1GvO5GPAAdui51tnq/Zr7KcheC/Qm+xQjYoumTCtY+kptUhG0JBEF7+SzEIYgfAuREEwSSTGZM6XxDgeQ8rFW87VyiislgFaCtL3pAgPQ3Jz46UuTgECxDPaz8GIMSSopgCwvUnFRYvX2py5bzbR+RrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZST+bjRk4U05b1OBAc8vtFLhMZrjgb5wZy85vMlxozY=;
 b=rGn5J9hDcDVfN9CkMpAiMYFVrzVcTWm/aptni4qS4n1GxSvajoI8Aka0303z+58tN+nD0MDa2kMyL5EYXjaduJMd90n3IaKPyUO8oPB5NECtH/grZYd44cCmekbLMvgr8tb+csO2W70D7TocJlg3eqlZvzqryJEs3sg4D6yK8a4=
Received: from CH0PR08CA0024.namprd08.prod.outlook.com (2603:10b6:610:33::29)
 by MW4PR12MB6706.namprd12.prod.outlook.com (2603:10b6:303:1e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 20:33:27 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::a4) by CH0PR08CA0024.outlook.office365.com
 (2603:10b6:610:33::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Mon,
 6 Jan 2025 20:33:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 20:33:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Jan
 2025 14:33:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/10] drm/amd/display/dm: drop hw_support check in
 amdgpu_dm_i2c_xfer()
Date: Mon, 6 Jan 2025 15:33:02 -0500
Message-ID: <20250106203310.3349585-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106203310.3349585-1-alexander.deucher@amd.com>
References: <20250106203310.3349585-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|MW4PR12MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fcdcd35-1598-47e2-aa9e-08dd2e91601e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ce3mgc6Qeyr/lde5kIXicRqS33WYsPHpz1LS8zZHcFlVGDJ7Ia5X8AxNMkgp?=
 =?us-ascii?Q?YpOBVN9uKUROTljzXOp0+aurX7BG7f9x43gvzyE9TGi2KzAZY97GNDsV4jt3?=
 =?us-ascii?Q?+G3SA76kfyd9BU3b6TxIv8oEmGgdjKO1CSHvPdxtTEqsCg0xDcZrynwu+aQz?=
 =?us-ascii?Q?iX3oqQd5dB8utJLfe07woS1KIn1+jdPKfIZs/O6btB/+++VIf5RYJ1Ffr6O6?=
 =?us-ascii?Q?+s0xlaCiHASkm9FByxIiDiGVg8IcQkm4MfqKrYxjeF2hjxqYAjWBqJG5hmxq?=
 =?us-ascii?Q?Ll7iL4vzKBxCzfTeRLq7PlpViUjwv9im7XCtUIGH9iESpiAVEx6EfOYLH9O/?=
 =?us-ascii?Q?Ae2iAtVSs2EvXXNKaKqR8HdwawI7YyxW84ZxvbSIeRUqYQ88hyFbO35UbNUv?=
 =?us-ascii?Q?TgdVE+MYBQKQQqsAxqQx/kBwtwtqutpQjiN5Ty1yGouvF8hsssP19aKQ+hnp?=
 =?us-ascii?Q?9+BieEjwLkZlMh042C2UvmKh9ZdSlaDdWCLtSwc0Jk6kEzN540D0yHr9HJND?=
 =?us-ascii?Q?HA/2eoJvBsxzSHOxv9rCK5+qjCX/UNbsebOEyr0dEZudrezRqHVcLu7xVvGp?=
 =?us-ascii?Q?lVYnhkNlYPHu3Y0b7xYTPgOXOSsaa1Lcy6+BnfbcJhNBwaHJ1wHzpK1lF0WB?=
 =?us-ascii?Q?2/8f7QCWUjteYcYQ9fQdcDhgX49s5V0fv/mL8f/kbOu6od9jx35OTt/qYqbC?=
 =?us-ascii?Q?eZP3ULpJlCUqkBLpkAfdkra4G6CzRnG4U56PrbDULHhreW9qOmFHtAsd6WUD?=
 =?us-ascii?Q?qDKOMoq/e/Z9N+otdFZE+DQmKQw+oDxX7HkeO0THyM4AzbaIRgmE6rEOfP0T?=
 =?us-ascii?Q?Zi7Bs22kkpDAaK5k+GZLbvIoCeR2FDq5zj2gOfJXreeBu9vGXvqmSdsfaBCJ?=
 =?us-ascii?Q?MRJZKzOpK9yC5rz3JzxlPv9gmkalWyQfaWQeK70cIvdgrrDx9dCuXVHywlxd?=
 =?us-ascii?Q?B19mUQz4OkXir3hmrjC5l/KearsoCpkryfUc6uC1y/0Ci1Sgr1zk17EJdOmj?=
 =?us-ascii?Q?5k0NHvh4x1VdSadp9poOqe1+iLSQVXvQP4N4FUZ5h5FodgrSCBs/nGBx0n+4?=
 =?us-ascii?Q?0aZ9iCw99Go7YjapVOl8uQTcamfIKocfrdrmO3b0Qg3RovhACcgLYZYlPy95?=
 =?us-ascii?Q?aWNAwYN+yneAVIW3d+x3vIMwkF9RKGfpDNa5t2ZCorZ/mDcnKtgC3fXSxTAo?=
 =?us-ascii?Q?xj/Fr/JCkM13xJoZElVlgtX2U3NfaB5sy2HZ4lv3DmAhaAd/bspbZZ6uWitP?=
 =?us-ascii?Q?FaTYkfgXifBsBWI6pfaOCLJtADat/Znvm/X9b02JHnl+BMFlhP4HIuQHp0Qk?=
 =?us-ascii?Q?O97rNzWMFKpbFXsJkeVcQHRbqYDCTwdwMH3rUSrOjnFMxq0056AlJQsuZ8h7?=
 =?us-ascii?Q?Vt2wsAXbYGESVzsxOEvD0a8EIVrLUyzvggPAUL3iG+uxlHiC0gFdys/zAann?=
 =?us-ascii?Q?CaWdPzV+NHxhC7ZRaVG4qmCbMFoFAyOUmBTv1knUe1XPCLDMyynKfG4+DDEO?=
 =?us-ascii?Q?UQ3ujL8NLb8EvF8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 20:33:27.3455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcdcd35-1598-47e2-aa9e-08dd2e91601e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6706
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

DC supports SW i2c as well.  Drop the check.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 139f1a74f05d5..030edc6a29e12 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8216,7 +8216,7 @@ static int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
 	int i;
 	int result = -EIO;
 
-	if (!ddc_service->ddc_pin || !ddc_service->ddc_pin->hw_info.hw_supported)
+	if (!ddc_service->ddc_pin)
 		return result;
 
 	cmd.payloads = kcalloc(num, sizeof(struct i2c_payload), GFP_KERNEL);
-- 
2.47.1

