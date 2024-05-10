Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E62EC25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 09:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B2A510E86D;
	Fri, 10 May 2024 09:42:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WUsa38wB";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DB4110E86D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 09:42:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Slkcb7tWxfiQbLl1617lrJ4QDhOtOS+FAQmxDsHWONmNIgMi9w3y8D9gd5bFY9/RgPtEgPDx+whlqnKCh7JhPHhw28GtVceVAObZ9ohTfsfn4yHTS48xM+cZGx+2T2OPUTr2G0f5NyYH3XZNmTJNHB1+uIX868I/5y//fwrOHUNn0vWZ0vrurDFYxH39WyMhtHSBpIm7sS7U/0y6viGa6Zv4G9ly+KgTGagiqFpgq2JG0GBNVhMVq4AZeKT5ZD8nAmve95b8ScuEoZEfJjFUIQuUoqcJ0kRO4bosjP+/BnEeAmHUa5nbpbop6CzunL8IHrnJtx1xR9EFvOL/bPPFDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqsjU+r+JGfcwuZHzV9e4yQSCkP3hPKCIt/9lACYkF0=;
 b=h3iL7C5z1E0p064YD0eTSsyKQtq9KZewuTD9YyEC/N/pQJNt3kdOwqyxoWYMWUA4OXmYGL2ZqmGvjNQ+OsPQG9CWsd7oWmBiFagm3f30kEtZVP4AlNgqA2cwFIIt2c0WDo4IA4up9hCiVkPdjWAPymdGHlalg/Gcu0TQNWUnrMQkl7tc1y0PnV2liZ5JkWTyFEijX3HlNG+u4uJUBdd7prQD7eT48rHHjjMo0Jvm9bgnDyGQ0Eg0fYog9IsKG83dEJ4x2PxmommFw5ee+30aaEYnMqA2mmC0ObZ51sBhQXkn/4x/th6eYcViwYVoCqcUrQOOqBFO2SP2r0cbp8qwSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqsjU+r+JGfcwuZHzV9e4yQSCkP3hPKCIt/9lACYkF0=;
 b=WUsa38wB+xE7vNIlDPG/x7cJDEanT9/TjQ3ZGTqOfLoT0YC+BQQJ0KOBuzBoZu0E4IHZcE00YW3ZAfuz/qzzNjIlZPLn3MMsYnS4Snsl0w8bkgex+l/4caQBuq3mWNNT3TLRGNjXa/PZOpyOjRXvNlDAkW1GbUypDGOrg8KxEgw=
Received: from CY8PR10CA0012.namprd10.prod.outlook.com (2603:10b6:930:4f::28)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.49; Fri, 10 May 2024 09:42:14 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:4f:cafe::e3) by CY8PR10CA0012.outlook.office365.com
 (2603:10b6:930:4f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Fri, 10 May 2024 09:42:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 09:42:14 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 10 May
 2024 04:42:12 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <christian.koenig@amd.com>, Ma Jun
 <Jun.Ma2@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/pm: Drop redundant setting code for pcie lanes
Date: Fri, 10 May 2024 17:41:15 +0800
Message-ID: <20240510094117.493726-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DM4PR12MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: ac1176f4-2aac-439b-6399-08dc70d57930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lSgjgPw8bD9KHGztLIt9S8e65tS9g71bwtxDHoRF+EOm3+evuLrNRVTxIVzm?=
 =?us-ascii?Q?QzWp/gE8OsG5SP/N+TUNFcap3qtrivq0sRjSUe/7RYJ5jjORc+pt9sljxxG9?=
 =?us-ascii?Q?tdGnlqJ8gA2GUcq9vl4sZUGZ7PE2rhY87thYE++TIyAx4bHj1lUzoJpF9HxX?=
 =?us-ascii?Q?O2Q+QE60jbMJ+Wi4i5i5rLR+ZAy2IEQWKwZWZBRckTLDuN80LfA5PVZRN67R?=
 =?us-ascii?Q?RxC7AbEwRkaqY4aC+dkrp4rKLSZAIBSKn2XMWiwmMcCslES/GBgVhBlDqFXF?=
 =?us-ascii?Q?wbLvnZO/tqqkmKJFPzTxttCW0b6t3CrsRG/Px80E9AAkTJPrWcaJulm+gQTs?=
 =?us-ascii?Q?c1sP2tgkcg8EhSNM+qusaQ0lWiQ7XPw1FlL6a23z0Qbcg+c4QCqjIXJjgpWX?=
 =?us-ascii?Q?KwIuQZGPB2EiXi1fPnKGyS6JNRsmssDXqKWeRsLDZeQqZntyw3GJxTOYONIk?=
 =?us-ascii?Q?wj+cIovy4BKcaRVl22jfL7iboPp7e0v0xCQRRZLiMJuDL+lPW4I4Gs3f/QrM?=
 =?us-ascii?Q?YRQ4RxAQn6nYK/SN+ajuW+dtcJQBry8tTabje9A1qMK2T3ZjegMi4ejX4Qi1?=
 =?us-ascii?Q?gGWVdz7em/6nVmWKiKLGZyPfqooieNKXh4gvbT2CGAfdA/5W5RiGjzuzJHGW?=
 =?us-ascii?Q?497uksuUhbGAF6vTeqEfMoLknhptdDveafCWFWcfcqAd4B7Bt1jzzUQ34b0w?=
 =?us-ascii?Q?yZ095Im8V9KYaLHG/tii01PAoMrtVz2OsqzE6xYgdQbHWv1JdJpCBEHZDZD+?=
 =?us-ascii?Q?DMN+tdMDA6FnFXBxrWKXuUN4QM87rS03xgVdCRVZY965Brkt1h2+FObSJBW4?=
 =?us-ascii?Q?rDSwkBFWMhTu5fRwi4nkunlKs3i8K+Knm5BFE4cJIPMk4aEXEMZe+2OID5mv?=
 =?us-ascii?Q?po8Qg+BWArNzNcv7+8bYSEYeA+ia/XXouwW8Kn/riYI4NJAsF7FR2aDBlVp9?=
 =?us-ascii?Q?yhQzBlPiLCpG6f92vG4+RxIR4HGVWwEKygJg65ZEQ4ncz+wjEbDYAl1tUJXG?=
 =?us-ascii?Q?dPzQjSrnvUikNgaUgf/A31deCwDi8mQ4GIH4NsfyC/InkmrLaP8okvJdfXRL?=
 =?us-ascii?Q?gDYHJiV70z4x42xolJPRFFCK15SVnPsCD6MD01PsxC9WZf+tngiAw7dZgRbb?=
 =?us-ascii?Q?klTZHEn4BYC26W9o8dK26LIhWTM0HW5cXmObs7uWicAqxqT6dnz6Q0YqQOpt?=
 =?us-ascii?Q?PRyHEJzeuVSYd1q8eARiH7SQJYNtBdYlHqCcbkYL+cUr+a2Ih8FzivgjrX+T?=
 =?us-ascii?Q?5IFmU3Spm9eOOagXFqGG1AcVfDtL2g9jVzXfp4Ld4xJZeFHrmJxm291FXNxz?=
 =?us-ascii?Q?Q8W3s5TzSXUxrfuKW860t+ZfMhM8bmbbX2/zNXGotcjItPkFSwZXeFp/Uw0x?=
 =?us-ascii?Q?4rcGg/EHavAbErmrnBSz7qxumrsz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 09:42:14.2233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1176f4-2aac-439b-6399-08dc70d57930
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820
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

Drop redundant setting code for pcie.lanes. It overwrites
the value get from pptable

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index 5794b64507bf..ca1c7ae8d146 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
@@ -702,8 +702,6 @@ static int init_non_clock_fields(struct pp_hwmgr *hwmgr,
 				ATOM_PPLIB_PCIE_LINK_WIDTH_MASK) >>
 				ATOM_PPLIB_PCIE_LINK_WIDTH_SHIFT) + 1;
 
-	ps->pcie.lanes = 0;
-
 	ps->display.disableFrameModulation = false;
 
 	rrr_index = (le32_to_cpu(pnon_clock_info->ulCapsAndSettings) &
-- 
2.34.1

