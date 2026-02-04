Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01496E8B394
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 03:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D06A10E34D;
	Wed,  4 Feb 2026 03:07:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5ZzVleI8";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012025.outbound.protection.outlook.com [40.107.209.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F49310E355
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 03:07:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAHb/q5BK0OH/cDqdnC2cGlvc2B8dcdiMFsUUA/HAEljRLsEBjZAFgRTcji8WjWTclUqxGrheyBwtOTlr4vKl6hzcX8L4SaUfSzzgt9q4mqmD70xbTCGMQXG9RBeaq3vGJonYxe/YPd37vBgvwSvsH5iuP0E5//N7lWtb/H1xWk9QugpQCj5PeTZ2Xssy7TPzsGEcSKi6ImQjNF7shUx0yl03FDwO+L5IlH4eGJc+LeW0wNQ+PPxlZ7yg50zqQ+mR4t3VR6JWAhrhMsNo3G23NIsV4KDE1q68/r0cVjr2F0figdQhRJcr42LyZoJa44/TaqWJGpaGwBk82cf9BtG6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q96ziwe5zhAyn5KFpkSQ8lOBmr+aBbavSDLV/ezzXII=;
 b=gHXbN09KBzwDK/lHG6CWM7TncPp971Zyp+OLkRCAMFqfyE2t5HRfNOv5PAjwEkF0pDJESL0nXXs1xD0yIPDmGP8fa+P6Z9e4qCuNwpT/V26d46nVvEx8k1MdfkHQlsY1DNK4MDzvK/prvFG8odxENl3BtErgUsH5Rr2WD2vWJI0X/deXLGio8y7OxJ0clDBxPWVOuYv2ocXlzgPAtHRXndlcC6lMhiCeof23damaqehoNkv+USb/SE3v1XO2nvTggONMXnH1GLqHB+GzqnoAA6F2WmbxyPwfT0se24MCdn4px7RZQQGPbaJOzCTw5WXUK+6P1P/zTcSsE9qbw3gbsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q96ziwe5zhAyn5KFpkSQ8lOBmr+aBbavSDLV/ezzXII=;
 b=5ZzVleI8TTcxyaUyprNj4XPNaxLn5jfI9c5+wShviZLPLt17FgKFMQi7/sIBfrIRSu8dOuz7tozVHrJO9Lj7NjtzoEsLgTXlrOv/pr/x1ZUeSGHOZVvA+oNKRvIU8CjsXtphsDqXJ9Q/e/Zv/1jy4qW13AfhjA6oo+ZWa+6DSCU=
Received: from CH2PR18CA0020.namprd18.prod.outlook.com (2603:10b6:610:4f::30)
 by SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 03:06:56 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::7d) by CH2PR18CA0020.outlook.office365.com
 (2603:10b6:610:4f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 03:06:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 03:06:56 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 21:06:54 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH 07/13] drm/amdgpu: Fix set_default_dpm_tables
Date: Wed, 4 Feb 2026 03:06:14 +0000
Message-ID: <20260204030621.33369-7-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
References: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd54776-d390-4d33-4d12-08de639a7468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xwxXl+Z7Y+pJTQ46tNmUDq6vC8PsYmwEEoFaXaE4UMWxRIYIWLVvvaOKxJ77?=
 =?us-ascii?Q?tG9Tlgjj6nzVZsrk9Qc7F1fzIKFdA4vJqSwS5tNxBhovbMlp25ziy6wKgrgp?=
 =?us-ascii?Q?72Ped7BYhqX/7CMueYOwnmCRr0fnmLf7P8SB6EYVLNGwqhOUC1rjSRIyZgQQ?=
 =?us-ascii?Q?oBnIMaywhnv0yoRjCfMuVvkt7ynJFpQpEq+fHgjPg5JAIzGETgelaaHKdxqD?=
 =?us-ascii?Q?OYGxvc81jTCI58aEku1NSRiVt/77Bm6TrgVS91uskyJPUQvlvuba7zukHdvO?=
 =?us-ascii?Q?WM/4euoydkpmH1Scy0L669VucyGPpspiJV6vQ4Pa4dHsYsCySqbiOTHAjhcz?=
 =?us-ascii?Q?v/TNXJ1bxd7Tnp/GT6CgpereMiCBovoL80fYQwINkWzjbp8Dgsf3QFeArBus?=
 =?us-ascii?Q?o7Anhwf9B9sVz55FkV4f1wJ16uiGK/6ZWzHYyvP1dpbfHphbSHaZazRz1Sve?=
 =?us-ascii?Q?g1DSM7yZyC65i/+0OnrCkkkS0LTAnsRTEr8g2NFu1XJmFpV6l+vtW/Ri0XX+?=
 =?us-ascii?Q?iSgUlPj35aj6UBQM0gLwADaUodZZy9Y1eKfwQKAXtDKTlNnXoUwenLos47c/?=
 =?us-ascii?Q?mKNa3lvY06xi1MtX7ZgVoRVWpdWM7pc+8V4YQbD0sHRW+QoRxIph7lS6W8qk?=
 =?us-ascii?Q?sOBYSLrA1DAE0Zw/NuYxn4eZ42coz3ypAyKuc56ddw1SGlJ/+X6kQ0bhYOyx?=
 =?us-ascii?Q?XuNCTEkrcrm7xKREFIa6shFjwVKrLnWvgGy7VEf7zUcOZthWL99q36me+DYj?=
 =?us-ascii?Q?6NTXhofzOG/mNw6OSE8QXphrPwUtqTBfLzG01klwvq57YkeDJSy37XR6Vq7O?=
 =?us-ascii?Q?CJtvsdgh9+jGmiEjUaDAvJYdxrXNoF5APo+d7XlKOmYheZPquZrl4XMFRR3U?=
 =?us-ascii?Q?YMnYWk3ojUQR91jWNX+oab3dHw8EPhUIZiKcJJ1poEw5U4buL8vqoXnfznrZ?=
 =?us-ascii?Q?GyBAIksEHUs4IAKgcge9xB6aGK46SbgtnciJ+T+otOPfRHNefwJHRAXUByme?=
 =?us-ascii?Q?OepUPzQGd2mmuoRTt9DoFR43Vd2OTSpEOnmOjRchJqJGn4yNQQskpEDw/feu?=
 =?us-ascii?Q?sczJiHCwq9vTzS99HImeMCoe3izYBIkK9RH8DJKqpOcDx1Y84ikhTlQNjzY9?=
 =?us-ascii?Q?zBaofC+OE1oGOKmCmyh/BhN3UocqaUZea7SkkZjywjvyHGNaR1/7NOZDftzq?=
 =?us-ascii?Q?zH/0ZzXX+j6Uud6PJbOdSZv/mjK6KSxczCwJsjQcDJZ37s1Qc3VpHhhydU4n?=
 =?us-ascii?Q?P9RsAzInQBtA6xKG5L5v3oBthfWhfgYGTkI093i+cFjU/EubSJAk2+hnWwio?=
 =?us-ascii?Q?lH4w6vj1jrsuIgpD3YBQUtGx/YFRb7wOd5hskElRXUhziS4471caq0AfByXl?=
 =?us-ascii?Q?xdhNbq0H8H0BY6TZii8nl6wiaLpVwRa4re8MiGWK9ylklLeb6ug8LfXzuwlL?=
 =?us-ascii?Q?ytPBy9NW/n0kUWZmaf8+UfyGfj3Z0ys6zmCLmBa+kKatidrTiuX+13bEyBjx?=
 =?us-ascii?Q?lLIEDUK8I4SN64bsO1ef+SCRgZpJEoVX/HmEeN5FqXb+G+1TFlcj2S+OTus8?=
 =?us-ascii?Q?wXaL4ZzDUBVzh7+8KFYDWzThQ3J0gRenmTb3+KvdLicVz8QtgFsIoVPkaXa6?=
 =?us-ascii?Q?IlW112TsQ0Etshvf8j3bvRwlnr0Vw++dDH7slNH0erhe7uGEKjjRQK9Pz0W7?=
 =?us-ascii?Q?+kxdOw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yZ7qH9vfKJwOq4IWtWuseqiV5Yr6FeAgx6gPEnNe93JeBj1TZqnxH7Hn1YVv7LSTWg2CKYwsHfZ7J8UREo/GnMbfMPb5qqsv9r7XWUm5BlBoy0gFKrs/mjW18emNxFD5AR9fsFt+y+85Y+7xLz/RGfL4HFiS/kIrfZKpdb/ff2i+rzRx9WEGCBNf+SlvBGPWKiDyRurH0DhJJIhou8dQzKAW37Pzl77sOOQfTLMNeatsC5WfD+WPvqn4kK0hXyt+XKXjzZBcXFiLZf984dhwr1q8tlb+dtJGA1H2VaqxLW3GHxfoow6Pi9bRmymcb0krhsgfxfRvqakyYyLOLa3+CZhrrhM9hrFxbDDB8pjvHm2+njK4SUDVViJa4yGMrfemhGKOgEUiS4aDFf0rH9hsb5ubG/3TmVclDMx9yPEiJiemXUdAutKPQWxAHiMYXKpu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 03:06:56.1757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd54776-d390-4d33-4d12-08de639a7468
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791
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

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 8d05d589c45e..3a66e635d244 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -1788,7 +1788,7 @@ int smu_v15_0_set_default_dpm_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 
-	return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0,
+	return smu_v15_0_0_update_table(smu, SMU_TABLE_DPMCLOCKS, 0,
 				    smu_table->clocks_table, false);
 }
 
-- 
2.43.0

