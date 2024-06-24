Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28ABAC2BD09
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 19:15:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84EE810E561;
	Mon, 24 Jun 2024 19:15:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XrE+NG63";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E52B310E561
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 19:15:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNZY10IIOtklFENJcZTPGEr0T2w3HH8RG0dohkZQ7/V/vcwoMzQ1hpTxbxO0kXZu5JQhQ65/F/vj3W4sGgDp+Pb0ZlzL03LUK0NZrLI8ojbqG/0JHgLw9TEXtG9ICNZV1aerQLABbjlHhx+J/J+HJPvJgOIvOEBDdSQZzIdAq81ua1zhGppwApLbDqgdqtJ1xF0p96RF2dULFAZFeuzZnMF7RuTKIoOJJPpwXAE1FQSVfX6K8+i4yLyvKykWXfIyQNbK6kdL6KpAN5ihHFvdg+OUAADNN71KzaCyIHehEoy7qzRmvFmNMyIfeKAsGBKvzH07zZvxzq3frIU5boi+Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3iVMNqW95TYH/thkqFhTonXTLoqwvjjowFhieYjRUQ=;
 b=mmYwxfBb21v2MLS5aLhO+uyirDL7hKQnOI8d+Q1yQXdDhgsQOp4sioYZPMqKdUkGoFMSHHvK4Tiqczv+LMA6Uln18qX4giZp+BR/326xkZ1deglDoHHnUSOb6jk40xA6/Lzn0shGtrvMjkadGGNPXwLIlo+2bYFOWcWdAW0kBBOi38eZSeQ2kfgoE99exYudb1GbuRs3k4AFUWZYxbyWOeZQQjW/sAGX4IzSsyGkBlYgYKjTF/gDCSPi5b0kCJqaaQYgL1KY0qJvIfgj4NFyIT2eRtXBtDIf3Jv+i5n2uTyZFcxCnUBU0N40Doi8VpJu5n0GysGIHR4E26RSZRb3Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3iVMNqW95TYH/thkqFhTonXTLoqwvjjowFhieYjRUQ=;
 b=XrE+NG63kq1syVYECdOQA03r6MwRq5vZy1Vwb0qnyxha8txGC6Uy8LeUAqrG0Den3N4NOcwU5pjNkRSCfLM5pUW0hh6dH6Xf5NjfI/jBsQnXRHdMakhuG+byLpgN+J/ATO3O4T5YnWu3NfBg8/tcHvbMTdqnq5ETs2wrJ9CvWJc=
Received: from BL1PR13CA0377.namprd13.prod.outlook.com (2603:10b6:208:2c0::22)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 19:15:40 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::b) by BL1PR13CA0377.outlook.office365.com
 (2603:10b6:208:2c0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.37 via Frontend
 Transport; Mon, 24 Jun 2024 19:15:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 19:15:40 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 14:15:39 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/2] Documentation/amdgpu: Add Ryzen AI 300 series processors
Date: Mon, 24 Jun 2024 14:15:24 -0500
Message-ID: <20240624191525.63787-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc142f7-e4f6-41f4-a45e-08dc94820965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|82310400023|36860700010|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MtN5B8o8gOoW7munhGnk4PbV+HI+Xxqnv3bzxdYytVrutp+T7P4RDLuaPMpA?=
 =?us-ascii?Q?bAhtECAxhdEXEUIGeyuDNt/nrENrGAx0kvWbSK9eqcjfYZ+h3auaQP0aRfJl?=
 =?us-ascii?Q?MvFV2Vcswr88qGGqoqOpgh4ueyj660FuaGwicQSfH2TAs1Sat+kBgCxjNtZ4?=
 =?us-ascii?Q?DV77CJGCarLtKyS6zyIXKDYoUHJx+T1yCR7TL/Hn4CRx2lqY7cJIBEdRbUEW?=
 =?us-ascii?Q?bJyP2f/WZve1ne8TErmEjmSVfKoOkXJEwbYNBeNlxVDv6f2BOiVFuifvxm9L?=
 =?us-ascii?Q?Q1KqeNiLoO/TzJI+yotXhi/PduijEeZKOcvzo6ntT6CkeAlfsMAuO5Cj82PS?=
 =?us-ascii?Q?iPMdFruVptwfBwritZ58ExE15iNWgItYEgdRwT+C20GKK6P2SDVvqYn0J4HL?=
 =?us-ascii?Q?fU+DQl4dX1Zepeuq9jd5ybHaiTxKiED5thKM73DzSXCcB5DO3AQ9bdHP7S3K?=
 =?us-ascii?Q?24LF9uBcWH6zG/xGQbqG2ZQADHW283Y4bAqr/N0SdPlbkeRP/X+lJMeBRtBr?=
 =?us-ascii?Q?k3nFy40Eo1dh7VOJiHcKvIi614t29djZcp5TRjvButw/pU+d6B90OqqEAKAo?=
 =?us-ascii?Q?As1o6GCmkrKnNRrkO/H2ILu9CyPEJDXaN8Mz0d6XFE/m8uK70eWiySL0Cceo?=
 =?us-ascii?Q?ET1uc7vyYw1NoFOyyEhXHcD7nWn162q3bYccNBoLTlFQOofkbg+DUgm9J9Cy?=
 =?us-ascii?Q?N2XHIYWKDRf+9+CNv4pSeL8eyRsp8r/DJMlj+9yqLzQtVbxrnTv3VJiuK6vs?=
 =?us-ascii?Q?l7nt5bCEseGZWfJpuip7BsGY0kSSlfU7uLEArzC8T0qWw3p0gVa+bPjvPN5b?=
 =?us-ascii?Q?GIwlC/MRIyqD7mWjFBVuK0IU4Wei+AbgmgypPv5PPfQzmtpurBbUTs6ZmgZ2?=
 =?us-ascii?Q?C1ZRT8BoUZOtiftsXC5/cxr3rXm2ehyje6iGBdeDFlysvzQb3OwVOA6PLAL+?=
 =?us-ascii?Q?jz169S4f/XMx9lRoQjiXlQFZQLA9j+uDZ7180HCHCWxf8PKg8SZXuZC8B50C?=
 =?us-ascii?Q?yzeeHn+bbuhZAOyfabKtjNh+SEEyd9JiaO2rgcPrjujCMBqCHrt+BxMSrmba?=
 =?us-ascii?Q?pWQ9mv0mBnGI9i6qO7NUEY2PmRh9QKqYVdz9dc67czGnrN/ZR5qNQjlBS2He?=
 =?us-ascii?Q?Mlc94OY10k8brewd1guzBTajqsK2+1dOScY86oJgUMjQrJOOvEjQ8Q9EdqZs?=
 =?us-ascii?Q?Kyu2UTFalUBHSYWYrI7fzqx+OimuIG27QM8eXI+mfyq3My+s7jtbN/OHAjjr?=
 =?us-ascii?Q?HBfpotrXJhS6MEj49Hmia3UNiqT4GqFuE/I8lXQg8rhWC52IRfBx5r92ns9T?=
 =?us-ascii?Q?UDMHKa1xsL/qJrYhEjEqc/NtNNhlzpwkOMZGk/sQs/xzPgg2d/UWRcWTe8DU?=
 =?us-ascii?Q?iBExiAc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 19:15:40.3458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc142f7-e4f6-41f4-a45e-08dc94820965
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320
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

These have been announced so add them to the table.

Link: https://www.amd.com/en/products/processors/laptop/ryzen/300-series/amd-ryzen-ai-9-hx-370.html
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/gpu/amdgpu/apu-asic-info-table.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
index 18868abe2a91..61140ba32793 100644
--- a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
+++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
@@ -11,3 +11,4 @@ Ryzen 7x45 series (FL1), Dragon Range, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5
 Ryzen 7x20 series, Mendocino, 3.1.6, 10.3.7, 3.1.1, 5.2.7, 13.0.8
 Ryzen 7x40 series, Phoenix, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4 / 13.0.11
 Ryzen 8x40 series, Hawk Point, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4 / 13.0.11
+Ryzen AI 300 series, Strix Point, 3.5.0, 11.5.0, 4.0.5, 6.1.0, 14.0.0
-- 
2.34.1

