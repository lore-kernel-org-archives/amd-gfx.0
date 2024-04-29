Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98F5C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 02:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19A4F112243;
	Mon, 29 Apr 2024 02:29:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zo1wDRdR";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0011112243
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 02:29:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXwyB5TK/GKoJtCjnGN1BynDZwesEWOQBmD9/pHeT/9MdNjMujwGrQnTgf37wN2IblCul3ZBLLs1xQCJmq4tsncmM7dh+BZVJzx/OBodbBS80nfRzEAfoTqpsyfQesHlUenWYxhk6kxrz2dmLNO/79Lv52NtzpTk5MlqYAaPM5r/gl2cVQkggAopMOxDbvCrQ0IueknjB93YsezyHZpJxw7j4wjaY2FNtbSaOVAFgnHQ2+I22MXICLsRVkeN63If28SqvWQUJtBIoR4waeajERXilcyH6Ct4Nc7ptbdYmCUNynexf0DzF3qV81VIxzcLlh5C1HX8UmEzaAxYdU8Bzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHFhcNXs4vmXraSDwaOJNVkRfipKbwNh4LC+RcG6e5Q=;
 b=EGlrp92m3omOwc2VylYrrjQxXYxxVKiWxAV5BfHT9QuGDRjBy3qLC/nxNjaexlGKqKSNaMPye8pTveOyQt+ctn/I/HgrP6CIF03nHCUwlEv8s9xcBBt1HJGpLX8d0hJFENdCNi4pRWsIKHsuo+f1CPVtJCtXdP1tY0NhVqcRnHn3BvlZaf6gJizAzxfQmXdCKnIaBUzsPx+hfYOb3UnImTdvUF+D0Kptf2KLqOEN4Qq3LX91JSe9zfZqiddiXCwejizq9nABZpfkuLRWbKLB4I4nodyVy+R2tldMWNi4lGzc2d5gx+LVqQbh9cW5E58nDcU59B+4XQSGLrerJuTolg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHFhcNXs4vmXraSDwaOJNVkRfipKbwNh4LC+RcG6e5Q=;
 b=zo1wDRdRmpUEyLI4ip53suBxgPohPFqYIglK48iCOV2Gt8Z+PYVvfVdK7W/wkqJhnE4n6vFauKMM6qoDh3jw1b3O3v/vZQnFFC5x6r+SOEzh23JCZGFy4WGa9LkoHSpA9GLmiw2afNTdpntWbgvqs9gRvtrr38yuoANcCTYfGlE=
Received: from MW4PR04CA0191.namprd04.prod.outlook.com (2603:10b6:303:86::16)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 02:29:03 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:86:cafe::75) by MW4PR04CA0191.outlook.office365.com
 (2603:10b6:303:86::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Mon, 29 Apr 2024 02:29:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Mon, 29 Apr 2024 02:29:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 28 Apr
 2024 21:29:01 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Sun, 28 Apr 2024 21:28:54 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amd/pm: fix warning using uninitialized value of
 max_vid_step
Date: Mon, 29 Apr 2024 10:28:54 +0800
Message-ID: <20240429022854.2060744-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee35f1f-9d42-4d39-dfbe-08dc67f4228e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZlbxKO9TXKzdCV68En4j7ysV8vE8rUlZd44aQyX4CvPgogreYDOWCgG4pIZR?=
 =?us-ascii?Q?R/Fn8t9GMd5zukwQjSryC0YNukxtIUAUCllLIMEx3vEDs2NQHlrXAJkLTCHJ?=
 =?us-ascii?Q?HFBbvbAucA784w3JbWz9nPqxP0LtUR7nvum8TiFfKo4IsZ5vj6xI0a04YcPj?=
 =?us-ascii?Q?vaM3ibqjMIy3foLd1iOa84QgDqEE4Ly6njvANDIhro+qkoOuJ5dEyPhijpXo?=
 =?us-ascii?Q?1C2gepbyE8G+oPxfpch9euxyLgi12ljnIIXNmz6cru+waNIwBZGPwSJGbfM1?=
 =?us-ascii?Q?eYrXn4yToEo8K4dzoXQJj2e6KJR4H9kI4kfoZ3tjyqM64goxoHm/jE2+bJmA?=
 =?us-ascii?Q?PSKRke0qFYL8jZPVjxotIY9xgAhRmAVOj9xi4o9gWx5dJVGyykSFRAvXKtbD?=
 =?us-ascii?Q?CT9Mlb4jjNbkzZkbOMbo27OlKqUz0v/WieJai8XBjK+d9yJ5gihUMk+6mNBh?=
 =?us-ascii?Q?dszu+OTBPreqBdTdtZhiGhXRKPg6tgow/cxtR9n1oN7eCUII6i9IH/iXdhmp?=
 =?us-ascii?Q?DG7qSjfmtMB43GAuo6/L1EOoazFYSuYcArGDhLPYuBCUHl7S6l8JXzUzMjrF?=
 =?us-ascii?Q?7aPgUr1tE2ehSNmrD64o2Y8OemWkflz+p+6qaoEshH/RbQupMjUgcAUVAQwA?=
 =?us-ascii?Q?5A1DTRqolV4K6tiG5WtycyaUNAVC1zEHpheu3QOvdmYLt3kbQphaWdohoHri?=
 =?us-ascii?Q?VYOZLodNMsDxxVdPY3+lJX1CSmikcQjtM7RJsDQ/DT8317hjvxnR/Q4Hrb7z?=
 =?us-ascii?Q?u2Cx2YIYTakGhYH+rRLE2GDKnkTAdtOqWjT1Rt6mVTGyya25wWPes0BH6my0?=
 =?us-ascii?Q?aYj2/WtG3uMpBwLryUeCckFspFTW4/fD4VMwy5Z22U7Kkj4cQgHTjIofHt/y?=
 =?us-ascii?Q?WxfdpVPNldFPT2bFR8Y7thuPkI9X8lWRAepf34SLUEl3FdnVT8m0FLJPdlpX?=
 =?us-ascii?Q?nWO6iC5kR3ua2L1hhY16SrAacrRtzMdE5RzL+7tP6hnWb9pfOUL3ZdBjmZyc?=
 =?us-ascii?Q?RHqCMzZ65ysQrUUQ5zXbHaYBNXtalrQHgb0HQm+CacJG69mqLRQApppBvx69?=
 =?us-ascii?Q?hA+eJ+trHL8tA6PdfmJcUILmOk4eyViUjwM9gYAtOiHlsYCH480ku7KnwRdW?=
 =?us-ascii?Q?TO6kvuVkQZA05r6bmFUr+hg5DYxEvXDK5wV+Sop1A8uGamrwhJV59wfI5X5q?=
 =?us-ascii?Q?OglZv948ZINmqOsKoj75aq1RD1gGMQ2rTnvTT+eWaqtz+FW5NyZAvyX43RdH?=
 =?us-ascii?Q?YImR5uVpCWjcWWvg9PSzJXC5Qvtjlq08B9NbiYzevN4LfYJ7ahQkubEMYaM6?=
 =?us-ascii?Q?ka00T2oSS1farVfPNINu5WYvO7fL4Oq0q//i18aCtGEJFCINX/WmCUlwNT7N?=
 =?us-ascii?Q?JiZSuhNBQyYFLwy8+8YwIEOCxXgb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 02:29:02.7831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee35f1f-9d42-4d39-dfbe-08dc67f4228e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341
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

Check the return of pp_atomfwctrl_get_Voltage_table_v4
as it may fail to initialize max_vid_step

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index b602059436a8..70c711cec897 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -2573,8 +2573,12 @@ static int vega10_init_smc_table(struct pp_hwmgr *hwmgr)
 		}
 	}
 
-	pp_atomfwctrl_get_voltage_table_v4(hwmgr, VOLTAGE_TYPE_VDDC,
+	result = pp_atomfwctrl_get_voltage_table_v4(hwmgr, VOLTAGE_TYPE_VDDC,
 			VOLTAGE_OBJ_SVID2,  &voltage_table);
+	PP_ASSERT_WITH_CODE(result < 0,
+			"Failed to get voltage tables!",
+			return result);
+
 	pp_table->MaxVidStep = voltage_table.max_vid_step;
 
 	pp_table->GfxDpmVoltageMode =
-- 
2.25.1

