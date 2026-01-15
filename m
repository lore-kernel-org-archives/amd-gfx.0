Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B77D4662F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jan 2026 21:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38EF510E079;
	Thu, 15 Jan 2026 21:47:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FDpMrOL1";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013012.outbound.protection.outlook.com
 [40.107.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EE8510E079
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jan 2026 21:47:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3dQBoQDUkdiCoOmdPc90VTuC9oUzZ27GPTPIMnLDmWwF0G9qoJxsNYG3cS7XZOSO0ULJYndt72fA8kucOle3/w2wh/lPL7ZmL4RLJoS3NvaBbYJ59sgbvR+ydy8A4SN/X0zIjOxEJI3OgMwKN0QI1nsl0dqQGS/KCyKGUWHuMpKunGFMBWNjz4LA5jQCeU4jh2Dg7A1eOTJGkeyjdIWB6zyBuAuMMDo3eh3jiRqOIM5w19AN2vTBEptXWk7hwMx5z2oeyK8S8M3DwEq20zZ9AR0wXFbijs7kCSXEDKrdXxIv5M4RUdNhKe+OevyWc/BKjtnDSQyvlV9voLCrBWi0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qnh6+pgv2goirVl3/KLsge86g81yMVCum/Kza2D0C4=;
 b=mQA20GFdqAX+FoZb6ZvWzvxQR1uFuXYgYevkcrlZAgIhEZfkeFiY4uqeCuUFhqq1b9c3jtdAFrXymDcjO+1uz190fkmgNFk4T/rxk7y87wA7AH9mGG4ofm2FV51T/dD3gwS5kuaYjqJRKJ+a5svcdTkQErSkDfYXU+IiS7Y0K3orOKj3l+9VVke3YLmUdyNgfuMCBiQia0cP1SEWTsif2ggctNXKm80dAZH1r9LVeab0UWbozyS22nBMUV8J5Ry7E3SrNWbSQvgduKsRBYN722OHnTwTGdih/dcSa7KoC97sChUmVO8JtXI5Y1uWKj1YcRo3MX0IWX58GrpbafH/Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qnh6+pgv2goirVl3/KLsge86g81yMVCum/Kza2D0C4=;
 b=FDpMrOL1CgRBcxS3kwjdJIvwSal7/ka6BbY76SVEhUwCW52IFjgzNFDHA9gBW9FHM6nBz8X7mt2AzoErLtApusWpmvOnW3PRLWsCvShn6iJRkbOGhnxKrye4BLu52NyYxU6IqiJWk9tM756Q09pbWs3JRB8oHJ1GkDHOaLz5Dpg=
Received: from PH8P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::18)
 by MW6PR12MB8736.namprd12.prod.outlook.com (2603:10b6:303:244::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 21:47:49 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:510:2d7:cafe::43) by PH8P222CA0003.outlook.office365.com
 (2603:10b6:510:2d7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.7 via Frontend Transport; Thu,
 15 Jan 2026 21:47:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 15 Jan 2026 21:47:49 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 15 Jan 2026 15:47:48 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd: Update IP versions for Gorgon Point products
Date: Thu, 15 Jan 2026 15:47:26 -0600
Message-ID: <20260115214726.900171-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|MW6PR12MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d48b4c4-98dc-4f57-657f-08de547fba30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Top9jzAs6Gfkty2/LiVSeYsqNjb+g9zULOpHClYnA33GsuAwa6R0oC6TJ6XH?=
 =?us-ascii?Q?3YCaWRMDXl+UVfIPd+uwVEwWKwSnpi6FBCry5iu39iksJ2T6hLCHUL96njPK?=
 =?us-ascii?Q?fpNSMUV5Pu1f8RWGAY4V4Qf9L7C+72JqUZUy7SqKyqxmLlFc6lzobZhChken?=
 =?us-ascii?Q?/QAlCBUw4PZJDMih0g9tiLJ7kqm6C8bEbG2RwrBmEBPeG7w9IJdlEixaFyY0?=
 =?us-ascii?Q?tQ8ntI++xNGVr8F+gCID8iUpHcCuxTe6aECRuyv8DWYT+p47o7xi4X1i1twc?=
 =?us-ascii?Q?hXfcaDo52QnzMW6sM2DxjLcKbILRQfHY8KxLHJrAHFSy+Ok4x30Pf5wnY1im?=
 =?us-ascii?Q?+zwaLLqUH4QuVXUyPkXp5E5jiiG9JEjaQuhhJaDtq/fjPwVtF2W/AhkHASpe?=
 =?us-ascii?Q?u3gkc6kTQlj+paJ3Jyh81EGZi72EByv/LUJnezY1leiG0tXgDXWUXdMoqkDS?=
 =?us-ascii?Q?VUc80r+9TW3wlBdCjnuTTzU2jiIwoL+2+yaFNbtLQ0Omjk5jgrZD1s+j17vD?=
 =?us-ascii?Q?lIjaBKYE5TRt08SA9kD+1bSN+EkVJbnVAisYT36rGukLxiniVMp+0yBAg8VR?=
 =?us-ascii?Q?LcGvl0eyr/nXSrWwGZIWjREjWPqijHgTU4a7VV7EfLRjaJitVa/Su0X5eJzm?=
 =?us-ascii?Q?AAQl0UpH2RVkQuwuPs8rdd9UmyTdlGEGKg8hUriizatk9dclnhwmDTsB4R6/?=
 =?us-ascii?Q?+MXGKZIlwPMpLFzVlTS5w6uW01YwitwYOKfIfjThRIB95neqy/ZM7xhU1fy0?=
 =?us-ascii?Q?DG35G8yt8gPTFI0ut1wxPohaqMKbxW4ouZcqQ2kXY0T/XwnOazuwbpuu7r73?=
 =?us-ascii?Q?HgsCVfEv2yOFR8dbpl94v1P4xsru2LIpTixZI51iTkaoXvKkhtXLm5Zncymp?=
 =?us-ascii?Q?ekuOfxoVF5T7T4Aq15b8POPPN0/5hbxVBr/pKo6+gL70O7ZDk3oTzpzf6W7I?=
 =?us-ascii?Q?51QvTTFy8BetJlB1SSc8ZOyxJjGMSysZnXLR4jasPQEkCoAD4khrXAvCVP1a?=
 =?us-ascii?Q?5+STELjuU5H4NByQ3adCIfR5JPb+matsHKNWB24Q9NeBupUb//8QERikD450?=
 =?us-ascii?Q?1yYSclEowQROiT37BKiA6J5xcN0bdED6HLwHCL5+AdIpZRAteH3eh9naEqLz?=
 =?us-ascii?Q?VmG/A3+9c2k/gMHzV4jiAknVgk7Wck3l8CvkTFoxW/H66aGZjvXpij5IWVqN?=
 =?us-ascii?Q?kC/4k4cW34hp1TZOZfDbWvhZ8EuFrJHQVXdDggjRS1SkAm4IiTo3W+FzVOtv?=
 =?us-ascii?Q?R52pAZMtDP1EjvnZPAAP5wMiWBQBEC3aiNrfd2o1Ye2Mi825sW55qUFv8dir?=
 =?us-ascii?Q?2dEMwNkKHcdWJ1lDlnx6bjsr1THFyU4qfRbLzwDRGr4EE2YxBTafgYiw0yH+?=
 =?us-ascii?Q?gxpeAA1Bbu9c34eHFMwAcgMWMcsr7f25LWQ/Jr7rlnAsBAKKjp3hSp8zGHaP?=
 =?us-ascii?Q?QYlxKW0KS9yBFgk3HADxmItORFwmDlfQxzohB6hUAdO1yyD913MXu3OnIEzH?=
 =?us-ascii?Q?0MVqTaF/tjgLAWPw3WSsXipujVTs4y6v48xjAMCOIwt/KyxZhF8/JN0Uvlp6?=
 =?us-ascii?Q?QiGUqQb6d1e3TMjtLVI1HuON59DnP5RClHhZo/kGqPm/X/CDpQrk5DQkKHg8?=
 =?us-ascii?Q?cxJKLjlzglmIfo11xTmYrQHZpny5AJyAzQofc6rx0dNx7LTw32Z0EDNAVFpF?=
 =?us-ascii?Q?ng6Hg39qhYXyIo1apuBdxQblQJc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 21:47:49.3859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d48b4c4-98dc-4f57-657f-08de547fba30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8736
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

Gorgon point products were announced. Add the IP versions for each
product.

Link: https://www.amd.com/en/products/processors/laptop/ryzen-pro/ai-400-series/amd-ryzen-ai-9-hx-pro-475.html
Link: https://www.amd.com/en/products/processors/laptop/ryzen-pro/ai-400-series/amd-ryzen-ai-9-hx-pro-470.html
Link: https://www.amd.com/en/products/processors/laptop/ryzen-pro/ai-400-series/amd-ryzen-ai-9-pro-465.html
Link: https://www.amd.com/en/products/processors/laptop/ryzen-pro/ai-400-series/amd-ryzen-ai-7-pro-450.html
Link: https://www.amd.com/en/products/processors/laptop/ryzen-pro/ai-400-series/amd-ryzen-ai-5-pro-440.html
Link: https://www.amd.com/en/products/processors/laptop/ryzen-pro/ai-400-series/amd-ryzen-ai-5-pro-435.html
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/gpu/amdgpu/apu-asic-info-table.csv | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
index dee5f663a47f..f4c0f93c0582 100644
--- a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
+++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
@@ -16,3 +16,6 @@ Ryzen AI 300 series, Strix Point, 3.5.0, 11.5.0, 4.0.5, 6.1.0, 14.0.0, 14.0.0
 Ryzen AI 330 series, Krackan Point, 3.6.0, 11.5.3, 4.0.5, 6.1.3, 14.0.5, 14.0.5
 Ryzen AI 350 series, Krackan Point, 3.5.0, 11.5.2, 4.0.5, 6.1.2, 14.0.4, 14.0.4
 Ryzen AI Max 300 series, Strix Halo, 3.5.1, 11.5.1, 4.0.6, 6.1.1, 14.0.1, 14.0.1
+Ryzen AI 9 475 / 470 / 465, Gorgon Point, 3.5.0, 11.5.0, 4.0.5, 6.1.0, 14.0.0, 14.0.0
+Ryzen AI 7 450, Gorgon Point, 3.5.0, 11.5.2, 4.0.5, 6.1.2, 14.0.4, 14.0.4
+Ryzen AI 5 440 / 435, Gorgon Point, 3.6.0, 11.5.3, 4.0.5, 6.1.3, 14.0.5, 14.0.5
-- 
2.52.0

