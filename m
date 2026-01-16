Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59645D4A5F6
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jan 2026 04:53:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F364D10E010;
	Fri, 16 Jan 2026 04:53:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z/4Qtqdu";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012001.outbound.protection.outlook.com
 [40.107.200.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6851310E010
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 04:53:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlKN4+29Hw5RM7DHXxFav7tXKkn2Rkm0WqhehYw0WsDtHNYXh2qNV+CbApgGoCYvVhybkNlZWMeRckOsRNHzEPxpGDRKYIijTeQdk5aEOYANNmYdo12vqPvYn+G1z7yz5ZNjPqS8em6MNoxYgjh5RUHwyYD0xN49DtI31c7vT9WJakizl8L2RAuyFQ2i2akdQrgmzQrW2jBP1Sa5/sUw3ehszrtY/KrieouWup9ONU9tV2FxLM9JvAtSV5p7OZ7/3ILHym737RlaOLQszQ+gReM5fnfm8+6foulSxuDgoJ2L764U8GuW1PA8sT7N0pY7Dn4jQF2juMu/zbLdq3xhkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lPkKIQJ/qzuCXPzHsQDaEPanCT5HVtJp+YOBW2DM38=;
 b=RBLMYp9y4aMCgxlZ0TDKlHLyzjBRVBHMuEkeQomOOjAnpMm2CaZ+Z8Cz1lTTRHK0uPLwmkhjZUZuJ2pwrOQaaaekTghaC84vukL9ZhT9NPfLu23IMdu3IWmqnFeqtwrW8BvokA6tsIh3EdvvEKHs0ERd2Dr9nSznd44W1/QKvUBaZ8GCaCakkvHoX+neJCPyzO75+gJ1WHKxF5D7WkZLj8HFbBYTs+oB+CUGvzSiE/PQd4ji9yYS7mMIJtpL/n/1cgCLje5wQnAQuxwTMSx1aYffoeDrmVvZoTp81uIiP8TgcNEPL5BT2kLEPKSNkw+zGL1fCNjJFOV1g2FISdloLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lPkKIQJ/qzuCXPzHsQDaEPanCT5HVtJp+YOBW2DM38=;
 b=Z/4QtqduSkT2l2fDp0WECxHBqxWMmy+KMrfEfCcqxKQwEqmfvLdFYOHST/uMDKZOa+zDnpznTFAT7wr0uUkTU6Iyf/76RmcmfQzWTNngf6oB9dkaXeXyOMAta2y2Yk+2Myr7mbaQ//U8Ha8LLQTv5Cwr+S2vqF84xpWuKD4rfvI=
Received: from CH5PR04CA0008.namprd04.prod.outlook.com (2603:10b6:610:1f4::25)
 by MW3PR12MB4394.namprd12.prod.outlook.com (2603:10b6:303:54::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 04:53:42 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::e2) by CH5PR04CA0008.outlook.office365.com
 (2603:10b6:610:1f4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.8 via Frontend Transport; Fri,
 16 Jan 2026 04:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 04:53:41 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 22:53:39 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <victor.zhao@amd.com>, <Chong.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Avoid excessive dmesg log
Date: Fri, 16 Jan 2026 10:23:19 +0530
Message-ID: <20260116045319.773093-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|MW3PR12MB4394:EE_
X-MS-Office365-Filtering-Correlation-Id: ac9cf8da-613a-4c00-9beb-08de54bb387c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zX3iOV4k5Clr09GKcW1NfX6zWcX4jJ4j5DskO7zvwJXfrZH3nNOU9NrB1lnF?=
 =?us-ascii?Q?mBItD0Nu5fZz7QBu76RSHCcXoCjTSsbYOjJgiTj/F1S9npm/PRX2/5Nn1DMW?=
 =?us-ascii?Q?UZWAqxNvy2C5808lpEUHcvrNCl8CSeMfvCz6RH2h973sZsVoEI+k09o3eeFo?=
 =?us-ascii?Q?7LlWRMKfBgagO1hXyqraC1ZKB7+tGqGP79yH7yKUjT3bNxqsxxwNrlv9AhCK?=
 =?us-ascii?Q?swDIJrd2TDr8zf5Z5DAcLq/+hvPY/YHlBVf/F5sYi8g0sXjzKvgXEauOiLV+?=
 =?us-ascii?Q?yGsd0d7R3HJcw3kvxi8jp1+y7oM2VslMnESda1ZhxeRDBxpPZ9dnvhzVftHv?=
 =?us-ascii?Q?ZuCOefBxSYkRlmgMgw4rzPtBQDO0vfr+RjMTPrJyxFbrc3gaKx9HtDMhInaF?=
 =?us-ascii?Q?jKO60ufS94EGqOA1TUi0oSi17gZKzNAFK7O0iAGVm5mW5Lf0617KnGRn7Tuz?=
 =?us-ascii?Q?Wpc7lqQFwUDDuzUjjHJNhJKR832McPJAMYh9tZhWyNGxGXAAuCUnQR7xfn6k?=
 =?us-ascii?Q?MMrm/YbqZsSaTKNy3o+optiyHuRlus9S9T6aQ2SZzkK64UYJLKQeigManNbF?=
 =?us-ascii?Q?vMP79eqE/jiXoadpfNTkxi6sTru3PN210wCiqjr+W76VFkdvapD87ZptsfGT?=
 =?us-ascii?Q?Uj2reVJVaKVjzTwibBA9itA441yNXGsdxHENNQcqwk6wzfNaBQaD3bjMjmCp?=
 =?us-ascii?Q?Z5sg0aIQOk6uGIGZR62xX55tWku9yOWAbzZWG5Ena4hQpSYfx2DP+gztHweb?=
 =?us-ascii?Q?QUrNx3iz6t5kBQLkMfI3DwHz5JEJc0Y5pdbD62pTSent2IP0zrHdAOEKc4kT?=
 =?us-ascii?Q?YwDO+GJ/cB/WbcQJJk31znYJljFRXNxsc8pR+EagcZU13/1dq1Chn92+ye54?=
 =?us-ascii?Q?6ch+KhRJHFQ4cqKVn/KZFT4xoJ7d7kAU2aNecBy9RBBQpyHEv7gK8ijoTs5q?=
 =?us-ascii?Q?m/BAyQb0Aw02t4V3aA1Q1MrYZozC/IEDJ46nub4JYRtnYANVNIxvXt4s6UzB?=
 =?us-ascii?Q?FZO4Zhy/XIB12SMcCbhqEuug8QkvvwnWgjAC5c+Zpmyrxc8QcKxjyFi2GB2J?=
 =?us-ascii?Q?CBLWXdMqCpPa9G1AYy5G94b3w69+8E68Nd/kEU1iMnif64pfMI7lTEJshI7W?=
 =?us-ascii?Q?QL9sZW5b2yoApBQtwVFvJeBweG3WyOjTSngBp35ffqNS9m6PdP/0GjlwVqPM?=
 =?us-ascii?Q?JlOQQgffvQPVx6L2mKKBQUd1RNZ1vtDnxvxNgYptihE3K2/MRDpQ5xQso/ol?=
 =?us-ascii?Q?mZUxOX3Cs6lFZIlfQZ7i1q0ox0aBUv3WRXF7XnKHTS1NWqoYkuzphrYP1H4u?=
 =?us-ascii?Q?cIeyMG0GOOux3F/ls67+IqX+9+8tNqY9Yyspu6yLJCVP0kDTY22x9VwU3LX6?=
 =?us-ascii?Q?SCB3G7w51fYYKA16kvqn2zdIYARk9pxvAu6yTmgmd8UzuINzmsyj6WZdugNI?=
 =?us-ascii?Q?v6pqfIGllUpn7EYRjLycGlWvGm28r9qH52BQFb7JmeG9n9os+HK9E26OO7tY?=
 =?us-ascii?Q?qSROdZ3ETtu5jDFEYpEV5DMbu54zycrJk81V7lSIKmR1w7v8lxoXayR6Wc1I?=
 =?us-ascii?Q?bfYSawFmWsnEdb1XjJQTEiifZ7jrqrBY/MC3b10MuHvuH2WgTh2j2Zb71DbX?=
 =?us-ascii?Q?1MZrCGUn3H0PDMzvCOctgtbacoRFSWng+FKwwAkP8JP0CGO7xyMp23oChspq?=
 =?us-ascii?Q?LXAD3w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 04:53:41.5954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9cf8da-613a-4c00-9beb-08de54bb387c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4394
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

KIQ access won't work under reset. Avoid flooding dmesg with HDP flush
failure messages.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 6abe5103a78d..2bc305b9aa26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1298,7 +1298,8 @@ int amdgpu_kiq_hdp_flush(struct amdgpu_device *adev)
 failed_unlock:
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 failed_kiq_hdp_flush:
-	dev_err(adev->dev, "failed to flush HDP via KIQ\n");
+	if (!amdgpu_in_reset(adev))
+		dev_err(adev->dev, "failed to flush HDP via KIQ\n");
 	return r < 0 ? r : -EIO;
 }
 
-- 
2.49.0

