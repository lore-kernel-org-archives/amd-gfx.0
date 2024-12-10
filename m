Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C6DE77180
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 18:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D25C210E5DE;
	Tue, 10 Dec 2024 18:19:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dEN/7IXa";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A1A710E5DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 18:19:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUnyz1q1vgxyL5V0NFpErEZAHlkoSN6ELeRxNMTnzsdeFaWdYoQT0dOVMOe4bMop7pbqvC8voseBti/f1pKJj+HqfOrV80LK7rv4p5fZ/m8Gkfh7yKfqiqd7YNfpFmQt/hkJvUdOXdjKhuhmfFnl5+dFDmrDa0fwpEfMeKm6hUVPzKkMSHef+d9koBQOgxBArDsDPfsQrSppS+gz9bTSLHPGDLWD4iVpKbXqoNxODsyQ4xeL6VzPtvlMUEB4NUtsi0VEro2PL4YymvmnMpC5dT60fmjiT+3ow55dHy1A6C7dgIOqPQ5pFbL7taAbnXbjlo5RcX59YOdgcIREoHEwtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqKMp+q2rwzcW9p9WVj9BY9RZ9t6k2pOiZ3U2aFL/FY=;
 b=xJJuNyUUmOtNnzr4bKwIcPhb9LLUZPaFizOOKu90WLZaiuWtQEalxgcj/hwOQCvxAQm0oJQB7S2/q+DHzP2Dy+jkLzuPSEhVPCZPMaBNQmTcclWeW8JY9zM+AuQGQSso4HI5P5+L2JX2bVYVS8mxzcng4gRbQZAYI8rb2/r0usWYz4cWjeNOM8ybz3W3oa02IPzrrJ0MlaDJAMzrCVR1Q2wLi+sZ1AN2UZFjujzw4e5dcY+qrvNB85g9+ADo78vXxFrt5UoBrfd7LJHs8KV/KJOlzR7+IECPxf7cUWKACKV9hw3E2DKk1UXzqsUWitfY04ZBCgb6wFLORtUEVrJutQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqKMp+q2rwzcW9p9WVj9BY9RZ9t6k2pOiZ3U2aFL/FY=;
 b=dEN/7IXa9+7i28d1g5bS10GD5aLLpL6vzWVf9fblEljSs879JCxdcJrb6D1tcCWbfo7v4Vnc2YCbGkW1da4znHH8eKC1bEq8B8Kfah8WAXzwHC1LV9WHCcWlHYL1ukloZMoGHFPsvXE8ib4U5Hc9uTME+OOP/5Xaun+E2RjtYxw=
Received: from BN9PR03CA0231.namprd03.prod.outlook.com (2603:10b6:408:f8::26)
 by PH7PR12MB5711.namprd12.prod.outlook.com (2603:10b6:510:1e2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 18:19:20 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:f8:cafe::42) by BN9PR03CA0231.outlook.office365.com
 (2603:10b6:408:f8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Tue,
 10 Dec 2024 18:19:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Tue, 10 Dec 2024 18:19:19 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 12:19:18 -0600
From: Andrew Martin <Andrew.Martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <alexandru.tudor@amd.com>,
 <andrew.martin@amd.com>, Andrew Martin <Andrew.Martin@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: Failed to check various return code
Date: Tue, 10 Dec 2024 13:18:47 -0500
Message-ID: <20241210181847.2952314-2-Andrew.Martin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210181847.2952314-1-Andrew.Martin@amd.com>
References: <20241210181847.2952314-1-Andrew.Martin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|PH7PR12MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f41e26b-74a0-4649-80b1-08dd19472a0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k5Wx7wCr0PTEVW5QWSg4v8Sxgd7XN3PSVz+i359HuW1TV5CDGqfEtuXQhvEk?=
 =?us-ascii?Q?6UMgdMqkJ/UaChJf1XKFinNEJciG+N8wZXFJUqDWqEGOCR1hLSA/9jqj7lEd?=
 =?us-ascii?Q?JHdTki16prfHGSfsH/JNbhPTU5LMbyXyrTeSjhP7TOZpx6Bj/mJF5v+a97Ot?=
 =?us-ascii?Q?WaVCJSF/jD8Yy4mULJlmd+CcmDqpcdQfC7GsuxIz6zhj8NpxzF/LdGq7qMM7?=
 =?us-ascii?Q?qG269+ImrPyOjhrRo2mE6jJ+/aFPhzJInJ3qHUiMHGUnptJy7a8U+U86jYac?=
 =?us-ascii?Q?M2FWD5OBNTHckDU4TISFtqL3oJ3TaMnpWW83brgdxN1tHDlNni8Izh0K1qps?=
 =?us-ascii?Q?OF+84sGdIOYzJlOYhLP8PwYGO5tXEV5vplYO79UXQCLjsw9vwUKflCnVqnvK?=
 =?us-ascii?Q?ttI1fVHqEgxNRkxvyU96xBA2u/KSIfXfXSYzfg+lo+2levRk5KsQZO3/hHwP?=
 =?us-ascii?Q?hQbqiRoHv2jiGKlzRH16tSuANx1BHm2NuNa12O0YlK7eW9cUWyx5itQ2xPdJ?=
 =?us-ascii?Q?KLfF9GNcm1YJtmnJH3/rdH+jYZSDFU7b1IsgvMTK/fG7AVTkVOONsOtSmStG?=
 =?us-ascii?Q?DjOUKMplJyRorekHx0S7L2MpnBb+EUjJ9qs2x64mUrbp/MW24Wvk1U/egC4t?=
 =?us-ascii?Q?GXuqichlNeoPEn1YAHKYSiAt3zTrY+Oh9B7yR2/XuERZljUDbRywXDFvtMiL?=
 =?us-ascii?Q?wkkx80duYxN6LHwOXE2Mb/iseAVxUHuM9KsKewv27j5I7YSZ8OYZ9Riwc/uU?=
 =?us-ascii?Q?LEP2qWvjF1bewFnhsHkEGJLOayXv6FumQAC/wghgOS7vdvGP0+ydX3swc5A1?=
 =?us-ascii?Q?ytNnAFoBjD19YHSNykT2kSOJ3VsXpYjBAJNPW1vS3fibipJTH8OhNBc8H1Z+?=
 =?us-ascii?Q?YgpSgAayrbHxbojG73pWh+kBLsPoLNWgQL2vi+vya6raVlUKQNGz1/Lq8WQo?=
 =?us-ascii?Q?/K2qXShipAuwZympV11ZFRZ996h+z6zsHuay36n82DqHezBV/hMUZSu1i85z?=
 =?us-ascii?Q?WydEwhHaJAZOH0SYEr7VXgNwtCZSU/R4rrgkTn54NcI7WK0FqjWsqFMVRV+X?=
 =?us-ascii?Q?irAy8Rf9Tv/6+w4+8zb+j+yXY1K33a+lzF9bmGr3KCe4XSgtVWT4fAYO0LYB?=
 =?us-ascii?Q?QpJ3EaQcX8sMCVpIvfVtZQUlBhm5OEvVIMKZRsGrklpIJZaUYUFoCdjTNYYE?=
 =?us-ascii?Q?BSIZ0ahj/onxk1Wat5qZavbrr//X/fwNritIPNtZCWfLfRk6raFO/rqMT5JW?=
 =?us-ascii?Q?SbdDjefX8zjpnHHtE8LiXyKgP+PcFOsFq2PNXT0us8pZCsO7FMq1+w2XSevQ?=
 =?us-ascii?Q?MhrcUPypQsOxMRORjCUFcxb55Mm4++AsWL0CMXsJIZwWbe/MxeY2EFR2J4ar?=
 =?us-ascii?Q?YIJMNfRWfFtTeutRXcEc8feLjflvelOvu8j6wzkAoj4t5qvP4c7aVaBL6MyK?=
 =?us-ascii?Q?Lx4bUzndXjP5zRsMkRhOqC1EO6txLgZ1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 18:19:19.4663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f41e26b-74a0-4649-80b1-08dd19472a0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5711
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

Clean up code to quiet the compiler on us failing to check the return
code.

Signed-off-by: Andrew Martin <Andrew.Martin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 16b5daaa272f..1405e8affd48 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2388,6 +2388,9 @@ static int wait_on_destroy_queue(struct device_queue_manager *dqm,
 								q->process);
 	int ret = 0;
 
+	if (WARN_ON(!pdd))
+		return ret;
+
 	if (pdd->qpd.is_debug)
 		return ret;
 
-- 
2.43.0

