Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B56BE9A04A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Feb 2026 16:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 388F610E6F7;
	Thu, 19 Feb 2026 16:02:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BAurBLLo";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010036.outbound.protection.outlook.com
 [40.93.198.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D59010E6F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Feb 2026 16:02:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+DtvY/MXPDqYGez1Xt7Jrp0AjOlegA0PI46M7sdvUuUVf1Ko7n65jjXH54FGo2jQx5z73iEr50yabvQJYPub0f2JZkObU1bqpdK/9b9cjj4ySRgnXCcafyp+nmZsxk4RRxGP5/oCCzO8Z5KOzdZ1AN53hdmnrz1TDJk6kXQTXQi7VDmX+k3iHPTfAP+sWyrG3qFv+wmpr5DmvHgOifCN5yFNxUVPoGonNvL6sH8W8dPpCf+6qAHQ8xB0KjDkh3K+2/UJCrvHi/yNxrg+R9nqWP91VFEGaNTOU5VUxcdTHXx08JJjDu96U82OaBSrop5R6MoavYKsF1afcBv66/byg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjNvwPIHZtens/fUu26YZddQU7XymWf/zO76OMFxNlg=;
 b=mA3JtvMV46QhxYjnJlFMKGasKHfX4xpMQnaHHULAl4IX59Cs8yj4i9FtBa5HJAdIc3z5Tqv4h/JjOh7/4AVDfHBjwFNs6YzVzKn8Ct57jA5t0t4y26EeGe6WWNZ3QMcvd9yO/RPvduPPfuPoUJ7Q6moD/3ATtX9kBfH4s3NRVLWrur4MLNLE4GNLO0moHO6DTb45yMNzp7UqKihBJaoAx0Gh95ziQuZ6m3E2cs01d87GBoJWstVj3bM7y2VyhHwo5T+v3EKL+A7ssaZPKLVuub7h7uKP1/BupqZH7UQDrOyoImaZEM9jfFEWGOM2AZBPQAiekve8GygbgW2J00/JTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjNvwPIHZtens/fUu26YZddQU7XymWf/zO76OMFxNlg=;
 b=BAurBLLoNbZxw244Nysgf2ydEzFs5YEUrtfOOcGEDNoeiW4S1H/AIjMtpp+FIu20GatT76W55MNoVrMghM7yrNN1JBkow+kHCJ08UYUPx2pAxWPi2kya2Q9NY9SbXmwUAafqdKXcOKyQGsyKHTTEAhkKx2amevlyarWYhfQDKFM=
Received: from MN2PR16CA0056.namprd16.prod.outlook.com (2603:10b6:208:234::25)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Thu, 19 Feb
 2026 16:02:38 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::51) by MN2PR16CA0056.outlook.office365.com
 (2603:10b6:208:234::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Thu,
 19 Feb 2026 16:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 19 Feb 2026 16:02:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Feb
 2026 10:02:37 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Feb
 2026 10:02:37 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 19 Feb 2026 10:02:37 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Vitaly Prosyak
 <vitaly.prosyak@amd.com>
Subject: [PATCH 1/7] drm/amdgpu/sdma4.0: adjust SDMA limits
Date: Thu, 19 Feb 2026 11:02:18 -0500
Message-ID: <20260219160224.1976043-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: fd6c3550-380b-4e8e-a35e-08de6fd04dbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9UJkRNz19Rnt2zMlSftOCHGdulQQgvc4d/mVV15ToB2k82RwA6Xa0QAA50gs?=
 =?us-ascii?Q?ciu0SKrqQtWSxMJ2B+8y8t1sNetyCngr8Cug5DeEWcao3igbpai3bT/+bOYM?=
 =?us-ascii?Q?8lIKw0IBAIM/tnFytUPayN2HMYNZH4DVdRL1TdElSEkaGPEtulyIcMpFfurt?=
 =?us-ascii?Q?H0QaDC+9mFAJ9toltz6UeQ7R7VCUaXyIJrzPKevT8dJo+gxuOfX0dCVaeF/c?=
 =?us-ascii?Q?QaQVdswd0jcC1Zdlu06Hg+rEkS1brkoqTe3a3sKWDuE+4a2HavT0f2Ne5rtw?=
 =?us-ascii?Q?F2Ke0yF9djmNG5xokjUwdPT4PnzEHJITq2mGiTQkO6VwIwav+eCMVHZAxNxQ?=
 =?us-ascii?Q?JmDc/ZS6W5zGvVC4KSChQz/xlztERFznZUpTsbsBOBM1b1/MUWN8AmjxLVL9?=
 =?us-ascii?Q?Jw9cL2mJS690klVTXg9dTvfYu0JLSI+S1gmchVWnBGfmDbdfCXN7CvjDO5qs?=
 =?us-ascii?Q?XziEGrw4JX8UxdV8WXOuE65QtxV7wTIukdoiDd6+bJUX5DaHMKnH2N32fjpA?=
 =?us-ascii?Q?Rttnd08LS8o2uyf1qJsU/5nmFD4zXfr4Kpk8BA7ho95AL5Ni8utensnKsRze?=
 =?us-ascii?Q?FcWhdCYrj/72xE69p6aumFjzmjAS06ENHsIDlB2cZqCWoI3Wjb2FuJOLMtDO?=
 =?us-ascii?Q?eqYsI5F/4hcDqTNS/3nB+HTKXmMCOxoISg/IPSklDa1UFW3VdrthgLit1dyL?=
 =?us-ascii?Q?4DL71vlgL+a8r6hVy+iQQjqAqHj/DpT9QwE0JOOQlsk2OyJdN9fBgqmT7y3g?=
 =?us-ascii?Q?abK8dtbHI2JcGZ2+3/DfxJO4kEnnPkPneh96dsDCDQuYcsAr0HGx8w2LpO/t?=
 =?us-ascii?Q?NdH3AyQrcuH5gErRjxU6bgRJ2TUfqvj6zBhG+5LDQTQpF/5C7zl2mCZw7X3V?=
 =?us-ascii?Q?OhNAfktgep6BV756mbjC0FmFB3thTmOA66qLDlKTdw8iOHgzqxwLW1zZO/Yp?=
 =?us-ascii?Q?GyKlflk2JMbbLeHTDqUmTrsyCnZDWL9825+iAnGNqBZYo3DbwCKF5C6SFYmc?=
 =?us-ascii?Q?j3+5yoztW1EKR89J8QMOHyMCvOWsscTbChVA/GAyBh6irzdzPcveZrLvjxCu?=
 =?us-ascii?Q?0Ay1+qnN5hSNpuDkAuQMVr6+AQuzTo+jqMP8ocIt+URrI0l5l9xU1GXDJ5Qa?=
 =?us-ascii?Q?3HScPK+lklQ9rrKc/PzQicGQOVjpsIR9szRqmeU3+lZFEj0J+vMrvOuDzbwz?=
 =?us-ascii?Q?bZqcGGsH//OBBWrjp7berla4egM+o0LnIvV/qS3MmxYF2ALy+XGTM10OuFEf?=
 =?us-ascii?Q?eha8cDnBDRq1IXWtF81BiyDyHCc+uAOp/ILw/vUHHYGg/KS6h+LrbWQrBrDH?=
 =?us-ascii?Q?CrrOAcpw2p2pYp1iujhKHUlGsSbY6A9rp7qOJBqCiAxGSmyI1yrubyCLJ9T7?=
 =?us-ascii?Q?5FvRbhDLvRgEKbbuHOp7ghYdb++AThAi1+Wfb/tbfSTCvbd2JzUgPPGU3qA+?=
 =?us-ascii?Q?h3jJkt9d54cPKfJW4q5/leMMknQM0+JO9JhEQLivJQe0snU9YBkY0YjntKyC?=
 =?us-ascii?Q?oS3eTO6UOICaRYrk2siJE2JpMN76cIZ7BY2HiDERlTxgbuH0J3ndVOFQldhb?=
 =?us-ascii?Q?aPbl5Z3EjdJS0NRdLj5lbVU3hkuC8QOdaisaZnmxUhjv0MP4zjfoA5REPe73?=
 =?us-ascii?Q?WpNh1xUvDNMKddqoLhYI5XfqWThith07ifw55RmN+gId+/VrIoUjy6P0TuaS?=
 =?us-ascii?Q?sI47xg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WSJz4v9TrYfHbbZ0HCgNWWVjpVuEiMk5Q+V3gVDIft+OYSlsFxqTmMgdPeW0lVzSKMX5YQEOlEl4XHJuSSh0ZSyKZPD50siICiUHCp7pPiQcqewZU18bUsKotMEQ0azhY12s91sqZl5uZR2+zf7jv3GXnjQQEP07bvNtsQQkZjgQ/SfoYQfYDC4mTy7sVVhCZ3d/O4bIrDkCf/s/FlZ4kwE4NTOyDK4oSxFnIi42rhHNqofzkwBQHqQ8p5utQjKl8s6rJp1M0HX5FJFALeaZbla7a+9hbTI4SZEZCtBrrVD+5TOvnkXwGq17jrUarpwF1V2mp9EhaftZLp9TqLrKpMoAgmRDg3+RbpxKpAv/O3375dugQr8QyZg4rw+nnWj9oWUjqC1jDHbb6aN2TH0F7Be7Yz5YZkxXUYRbDBP5GpxGHTRtETScpkTF95xhhGPu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 16:02:38.0836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6c3550-380b-4e8e-a35e-08de6fd04dbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
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

SDMA 4.4.x has increased transfer limits.

v2: fix harder, use shifts to make it more obvious

Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index a35d9951e22a9..44f0f23e11484 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2604,18 +2604,31 @@ static void sdma_v4_0_emit_fill_buffer(struct amdgpu_ib *ib,
 }
 
 static const struct amdgpu_buffer_funcs sdma_v4_0_buffer_funcs = {
-	.copy_max_bytes = 0x400000,
+	.copy_max_bytes = 1 << 22,
 	.copy_num_dw = 7,
 	.emit_copy_buffer = sdma_v4_0_emit_copy_buffer,
 
-	.fill_max_bytes = 0x400000,
+	.fill_max_bytes = 1 << 22,
+	.fill_num_dw = 5,
+	.emit_fill_buffer = sdma_v4_0_emit_fill_buffer,
+};
+
+static const struct amdgpu_buffer_funcs sdma_v4_4_buffer_funcs = {
+	.copy_max_bytes = 1 << 30,
+	.copy_num_dw = 7,
+	.emit_copy_buffer = sdma_v4_0_emit_copy_buffer,
+
+	.fill_max_bytes = 1 << 30,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v4_0_emit_fill_buffer,
 };
 
 static void sdma_v4_0_set_buffer_funcs(struct amdgpu_device *adev)
 {
-	adev->mman.buffer_funcs = &sdma_v4_0_buffer_funcs;
+	if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) >= IP_VERSION(4, 4, 0))
+		adev->mman.buffer_funcs = &sdma_v4_4_buffer_funcs;
+	else
+		adev->mman.buffer_funcs = &sdma_v4_0_buffer_funcs;
 	if (adev->sdma.has_page_queue)
 		adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].page;
 	else
-- 
2.53.0

