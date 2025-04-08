Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FC1C369A2
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 16:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEF5B10E6E3;
	Tue,  8 Apr 2025 16:00:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ryjJ2wg+";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EB7010E6E3
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 16:00:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nq7Qahchvlg5/8mDNAJlmDo+g7Lw8xSLMAO0uQwn7MfJ0kjIKxOniWcJLDo2ZIkwmjJUJMdXfrH2WoN/VnzF01bCkXbwEHIyV4KPHmqjLr83Dmk4IVN+PXlOpj5y5IEhdFCmjp9+ykkQ+FPKl3J5x25ALSxL+nwp/7Y7mFRwbtDk8SBaSbCuYdS0y3Vo2wTvyKh7uhWfbE8x4zt3VvGd8wwFDIU5MFlh397vdsiZKhzBPUxf+KodhpMItCu/uBkqS2rpDFRU2tp9amKp8bXWyDUG80M67bCuBgNj4njhQAJ7mLfQF0FdgdJWPBps0pJ65Rms33r1vpANb9JYkaBRJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXSaRQ7pYDfR1TnefK+SAcTBQv8PQXH4FbwtptRdAS0=;
 b=RgTBxEVz6KAfBea+4+cioC0aOuCMghwh7W9imsqO2GN9I7ghC3rBLDvwHbV5vejN73Om8jj/63bnZ1Egy63dWOdTJPdj+uux3zeHZuGLgcN4XWCuEymKBN2V0cIdXxOdc6PeK6LrOGk7Jy2MQzV7C2ZAWqd2D9t6IJHoTju1OCqr558nl4tziu6dU7ZdjqYzU8vS/DCpNBNjWTqXaP9HGSmNYGKgL5j1RlDCHyWxLqPR3CAuwDo/4hDn9zdlj2DNm1iJnS9C31hRJMRV2gwooLwSwQanNG7x2H9e+8NRMxMgBdhTNuTJTzWSCBX9PzdELR+dST4pG7tlrRcKlFUgtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXSaRQ7pYDfR1TnefK+SAcTBQv8PQXH4FbwtptRdAS0=;
 b=ryjJ2wg+sD4PPfDuZdEeL8z0FcqVJXaRKF/sPOu5U0oY08Kh61p9s90tX7b2eVqC2nedxCeqHgM1aXhB4gF4O9+YqCOeiCu6mATX1VMnLVfuvDQEzMHkTH3MobYpyDK/AR6Ao/WG49NENwcV/XebBw62pp1oiAGzQaEloICkLKU=
Received: from SJ0PR05CA0078.namprd05.prod.outlook.com (2603:10b6:a03:332::23)
 by CH3PR12MB9430.namprd12.prod.outlook.com (2603:10b6:610:1cd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Tue, 8 Apr
 2025 16:00:17 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::72) by SJ0PR05CA0078.outlook.office365.com
 (2603:10b6:a03:332::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.10 via Frontend Transport; Tue,
 8 Apr 2025 16:00:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 16:00:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 11:00:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/mes11: use the device value for enforce
 isolation
Date: Tue, 8 Apr 2025 11:59:58 -0400
Message-ID: <20250408160000.3149409-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|CH3PR12MB9430:EE_
X-MS-Office365-Filtering-Correlation-Id: a81c8621-bfa7-4e4e-d71a-08dd76b6749d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dmCFgHuGaLqBcGaRz4xtAABGPA21y6b8xF1wmE9A1LMZnFfQakcenzHMVVN3?=
 =?us-ascii?Q?U9bm3GKOoGAmiA4bISldgpmZTo9Dr4nH9VEASlq25JMxZ3OmNX2z9CUOCo7q?=
 =?us-ascii?Q?Xu2zEJh3b6g99tGATn0JRWpWmk7h9m99XH53P8p4A9acI99KVZTJMORSY55E?=
 =?us-ascii?Q?v7PUsPGbACo7ViuNFUtq54EUA/TMplnC9sifVXWpGvZbHtI7T/UbaQXvbKEE?=
 =?us-ascii?Q?oIQDWVoGfieUf71qa9ikuhI6YowTAROiCIHKPxp6dI/KqVNLt63otArrSE6L?=
 =?us-ascii?Q?z9mmR9E4Cy/Oyyp86rtef7O5MZnxqle8LOIOls3E0yLCx6mNrEcPFBSSGFeA?=
 =?us-ascii?Q?6pYQ5SR9WfFVnMlRbj4k4Y0bZe73wXApkLn2tBlSdba2R13e5ky9lXFfIIc2?=
 =?us-ascii?Q?QW8Rp4AdHcnzZD2VsHxfvZGkoMPRhzALnWNFYbCSdS7GWkpwjKhJumQRArwH?=
 =?us-ascii?Q?QKzdF1YV2XEz6c7flGTd/i65XX1+jxzAUgZPga50EuHxTteuPYJii6mJyFUW?=
 =?us-ascii?Q?DvMLcW9ZtrXCTc0ndphhXtd76WYYGTpHWKOnul7JVEtfaTBY7Uu7EYYi7zCQ?=
 =?us-ascii?Q?EE7V4Q5Vkr7+vLhAkfLiGDJTVa4xdBBP4Ry6hPa0RFhbO+1y45/60ItV73S6?=
 =?us-ascii?Q?dryYfSXqpSIEWBFL/bYPlFW8qyBfX9QRMSuNuUMoUB4YPYU6MXLA5oVfpkOf?=
 =?us-ascii?Q?wQ9wS2NqycRfCsKlRL0/SxikOM5n7eMgWJ0VED8Fw/utnAvJiQjKOdgx8ebw?=
 =?us-ascii?Q?niRmjV6PIFuJOgK+i3X0L5kqlWOtqSPiXKVcJ8jJpWS0gVmC0pjHU8lNfemq?=
 =?us-ascii?Q?yjqldtozY0CrPSXz46dWETWneOd1xGdCO3zSADWofGbzMy297M6u2m69WBOe?=
 =?us-ascii?Q?K4LsIvKPID0kQpC/cjXWEzByx5Wwec5upvQebTTg8+D8tNNmg9w5Tnk2gLda?=
 =?us-ascii?Q?c8hQPTSqBwU915gamOw/Zu9wDDWV2mXokRcCcxLD2p4CzSUAkyeokN910ZOw?=
 =?us-ascii?Q?SvJ7cLpRuzEKqrS0wTE1O+Bv0bLSrf46i2vn4NzStHACqEI+DpYzVIzzxMLa?=
 =?us-ascii?Q?vOxsLPHxrTz/EcN2C6NQdw1xPZpBfiXdK9wope8bQjbPQWmPvi3Pk4gPTFCx?=
 =?us-ascii?Q?eBWFfrHhNQihbbj+SUalEjqIGBstqDgsd4LDVA1hAvZC1sZnCNhpuBNsewD3?=
 =?us-ascii?Q?3JDRm+XtzNDyr7Ktx1J+wMZMCDyvyGdbhV7Qi6GjgAVjm7Xb035hais2C45u?=
 =?us-ascii?Q?okWSPluDfDYasY/DEt5J9xaQaO0whhkMTyY00oBkdkSDQ3h6NfcnUCwdFkIm?=
 =?us-ascii?Q?TJhC3tLsdVwBoNH4RLvEsb1RbBFbjR7hANrZQhlqRj33wzkoyLEverZizgdQ?=
 =?us-ascii?Q?FlBHE325q6lFNye/KW6eiqx+3092qyV+ExGKL/ugBOjEezSRl2A00Hc7yum6?=
 =?us-ascii?Q?1+8+LiFkezq9OfcmiTmeYAd9mIb3bLLs1aS0xQrz7Gg1MXMAwZIKggXeFmet?=
 =?us-ascii?Q?bHcUeZlFhkvNjeeCLIfh12geYw4iJimVWKVH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 16:00:16.7230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a81c8621-bfa7-4e4e-d71a-08dd76b6749d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9430
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

Use the local setting rather than the global parameter.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 06b51867c9aac..344d32268c3cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -724,7 +724,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 					mes->event_log_gpu_addr;
 	}
 
-	if (enforce_isolation)
+	if (adev->enforce_isolation[0])
 		mes_set_hw_res_pkt.limit_single_process = 1;
 
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
-- 
2.49.0

