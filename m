Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1966C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 09:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C77910F6D0;
	Fri, 26 Apr 2024 09:52:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FupwnGeV";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9A5810F65D
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 09:52:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXA9RpZGpVAraoeo/8cld4VJzd7pa3n4+//c6SRW6FkrJmalhhAoMfu2jZ1InX2z4pBR13YLzzlV34oSMX5bZ2DX9fGPAiLD86cF7aAryBak66uNJjS17ASda90pe/wn//sE8vmThD0GfOgSOLTTbhYbuSLG+X5PsqoJYGT1FCyAYduiZknZngd+Btw12wPe/FBgJ0tZuZGtCeOKlqvsKFsxp3ssn7xltr4K5zXbVv3jyOnUQoco1ksfxootNOBveMnUNZrcLBC7Pf8HB7+UHpIShorC+x5fTIuizeS2BKJyQX7d1KPu670t2x2AMwS7nplgP4q2xDd6NWZrQ7111A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfVwcYZ3FekLHv/89HyhTKRfSqNO1VdGf2qC4MVFcZY=;
 b=ByUsodfZ8vCgjjiy5a3V7rKThUoiXm3uGRWipBx1jK4qlOttCYV4OVuJRnR4G0SmSZeKpuyFWPAr/NaJyWK6uz61axs1qc3ZckE7qp1CYuhLry4WbMJHkp231TTC+4uiS8s7VP70omKrkG63zt+CdX2cpcCTZaRgvwBlu51W4oozpksBoy3fKTuYtao0eBvW2hqr3HpSlZ7V30gGQ2Txvv4fGEcEg7TYZzrqwGRuhv+3Ttv1ZnBpaV4J5R+ds1pWS6nH7O1gQnEo+MCw2kKQIrncY0URtCy2UMfog5oXMJTX5Mdp0T/U/JJ/YGn9uV17HbpcR6dpr3E+SJLBVdy0Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfVwcYZ3FekLHv/89HyhTKRfSqNO1VdGf2qC4MVFcZY=;
 b=FupwnGeV+d3Rcwzrq9rVpzILwIhV0cIejvQ7azW3V36SoLJjnsozq3B8JtgVRpcgPByuRsUZdkYMEGY2PW1i9FJmNMhHZRsNrTg7306rwojTzF5FerA6kSVTQbLm+MJFOiIh/piHeXM36OT1K9O1Pe+eSMG7dwQjJOJ6EGMHWyc=
Received: from DM6PR02CA0049.namprd02.prod.outlook.com (2603:10b6:5:177::26)
 by SA1PR12MB8744.namprd12.prod.outlook.com (2603:10b6:806:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Fri, 26 Apr
 2024 09:52:29 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:177:cafe::db) by DM6PR02CA0049.outlook.office365.com
 (2603:10b6:5:177::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31 via Frontend
 Transport; Fri, 26 Apr 2024 09:52:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 09:52:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 04:52:25 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 26 Apr 2024 04:52:19 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: fix the uninitialized scalar variable waring
Date: Fri, 26 Apr 2024 17:52:18 +0800
Message-ID: <20240426095218.1075237-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|SA1PR12MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: bc4f48d7-0c8f-4a7a-af9b-08dc65d695ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|82310400014|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3wuIjK+mH/4ZQMErZIKEGRX6Q7kRAah4Tho58jgl5SMDyHa9CsDR9PouhgQn?=
 =?us-ascii?Q?nEhDV+GfnOBwKf9nMnUrVxAxxcCOW2quFhuhleLu1il8fojjEeW6zWQIGEMc?=
 =?us-ascii?Q?j9ea0+yMmnAWEBjAAdMxzP8KA3RSkxzcCGyR1A9YfLBMr+JbPY4FkTzm0YkL?=
 =?us-ascii?Q?2Dt5C0/TO5JMcyF8obs9mXNm596wPMBOZArQl4POBoiJ5lmCCyMZ6sPCv8cY?=
 =?us-ascii?Q?vR8ItSFFnx/0Mqrwe5F0Dql2NcISMgNwm2wvK+eonkEUAdzDm9f+tZlzJO2K?=
 =?us-ascii?Q?4dJFr2TObhYk4TnOkVfh8VfQMSMzG1Ko8OyL6vzoZDOHsxTnHXze5nlnF1eW?=
 =?us-ascii?Q?gwTlUDWPbBWzU5tGDuPIsL/dWUYdkYkezdsr65qcxSfmII2YrUqRq0oU6WB/?=
 =?us-ascii?Q?r7xWNSiL9wSEW/RPAFAVCuzt0yM+RCpZuE2zpvy/1wcM2lBUigz7csxnloyI?=
 =?us-ascii?Q?gpHJh1BuyffwhRQfHlUS6TM4UlFgvRwHe5Lbji/uLzFh5rz/isW8weffo28U?=
 =?us-ascii?Q?W2IwO8r37InzXu8YrUq/II77YLPtHOEnd4Yl0Bijg/tDR7r2lMmlOXuomPko?=
 =?us-ascii?Q?bra9FiF7AytIUtDpubfXqngIxLpvZTFOhyl5TM7/pgVnV/ZfVnqSSJB0Q5JG?=
 =?us-ascii?Q?rpoNfteKj0liUEboxHI326WWq52uLZhr80xYM2CTUntxUbpO/mUoRaDZTlfO?=
 =?us-ascii?Q?yRELrPfJNi+0/GGe978yUvOPnuDdJDG08j9+Hpzq+Wj7Qt4l4pIRjW7lGQU3?=
 =?us-ascii?Q?Gys/J4XwaqJCM8CsHCKI8aVW/HqT2NOEj3jDVqRiWATzPXFM2Aq1wgwaiSo4?=
 =?us-ascii?Q?z3sjD+64JXwg88mcyJZvEeU06yrp6wOCEEaPPA39IeT8b9FM/NZw5QEqSTH4?=
 =?us-ascii?Q?FEuGZ79/zBpFJZi0QJCn1C0/F/7V7v5lLKCUEUSNOPYrmJkIv4Pesd4c5c4y?=
 =?us-ascii?Q?GFjwgqj6GcJx5Y1Wy7tP+feDccnAJ57kWD0K3mZ43RcHsv35cUd+URDPgWxm?=
 =?us-ascii?Q?pPZNtafIYQhqhu35DHCwAWI+zBdBIGMDo91v8aT41fL5jOEnNh3HelbF5kWw?=
 =?us-ascii?Q?xXiEAi5ewwg7ncEM0OWGi9IQ2dJeEtLgUN0r3Ut8rrCPw4qm2Lzzs31W2LBx?=
 =?us-ascii?Q?ENmtc7WEEcP5ekfF0ArplvGN42eHyZTiSJ9S7tKUGN4rA323QpKOMI4RoYz+?=
 =?us-ascii?Q?i7oMcnkJ6Cw+kUG6jORk92BBaJJhRTlfYgC3OcrEStJhPlWnmuUGDLqmzA76?=
 =?us-ascii?Q?yDb9W+cSC/z3NQn5FkBkhM9gka92PCgtfSbCSAySfOiI1PJ1R3iAO5QQGGbg?=
 =?us-ascii?Q?LfdpLQNNqYYWxP31ohhXowI+C5XEiDtZxC653GaTCW1DbTSWUmw0Ih37o5K8?=
 =?us-ascii?Q?8hNn9JJBgZF+XjZzfQGZqupmRdE3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 09:52:29.2330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4f48d7-0c8f-4a7a-af9b-08dc65d695ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8744
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

Initialize variable size before calling
hwmgr->hwmgr_func->iread_sensor, such as smu7_read_sensor.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 5fb21a0508cd..ec2b6d0674ed 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -102,6 +102,7 @@ static void pp_swctf_delayed_work_handler(struct work_struct *work)
 	uint32_t gpu_temperature, size;
 	int ret;
 
+	size = sizeof(gpu_temperature);
 	/*
 	 * If the hotspot/edge temperature is confirmed as below SW CTF setting point
 	 * after the delay enforced, nothing will be done.
-- 
2.25.1

