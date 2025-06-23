Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEA9C7115B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 14:48:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F99210E012;
	Mon, 23 Jun 2025 14:48:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P9zXmuzD";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 324FA10E012
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 14:48:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L904IeZEt24ZeYBlejaa7cqeGUtU+cwF+NpcWGhrSZdUQWTNMn0L/5rJL2E/OJH269fopLVd9UTn61utQf/KWxLbW4g9nes1vKfYVJEHFn3j25zrPA5OF9mrUSYmXUhVn+wDfCcOy1jLUXL6Hp3eE3t8zOOKdbbZn+Dq1XqtfSJuzDnT6164wMqcmJa63O7OqnsMvJ7AzIijurAs7Z+k2Dm5h78Lvb0ak8Dsg4ITHDE+ox5zkfT1ttqVpZiiI++VbJ3bGu79M6NbYeBEq9a6cBP6Te6MQMaKMWnL5UzuMIoKi9KLgfIXvfDpOBTwNNBMsty5TkKsNd8/+rAubAn7Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smYuT7Her6MjVT6hmKSlrV09R4HySb0MOazRpxuKNIA=;
 b=MJUIe8EbyD2CMx5QdOmYjNkNlT6+Uuw9H3K6n/B2FtTLgS208l/UfJ9FHRo8nzM9zzl+qMsg6i+9nDWAzwAUDlvyQdYD3FLEtgcB2Qae9NkdT6TiT4+ipMWFfQn5ZmL6qTOypq/2i2iyliqxnch0da0rPNp4BKKnLIKm3WVmr/socpQOafm7PEQrhvL/tbZnbkt2DsEa3AtDGEks8XeK4VfLaL2m2J332TjVdO4WmhXOiyQvitqfs794qs7TojciOh5EtdtJT0ogxMLHLB7g92Wjr4x+gHg+ugxXeA/L8Ddr31NlLX7RNfc77QCx6IrBqfGuffiExccQX+4mCb0Hig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smYuT7Her6MjVT6hmKSlrV09R4HySb0MOazRpxuKNIA=;
 b=P9zXmuzD4V+pJewpG9KgIHHqO5qrPo7UODRr75dBz59mx7gMszqZ4XE0kFw8wC+bZexXA5PnfWqHGRvX1fknUTPwnwNZrShSezCDS0voJ15n7aezggFQvfH9N8fbnR4De+OHP3tQkPP4BPT64OI1Z4QN42PD9tVlcgD1oeKjt4k=
Received: from MW4PR03CA0205.namprd03.prod.outlook.com (2603:10b6:303:b8::30)
 by CH3PR12MB9098.namprd12.prod.outlook.com (2603:10b6:610:19e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 23 Jun
 2025 14:48:39 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:303:b8:cafe::10) by MW4PR03CA0205.outlook.office365.com
 (2603:10b6:303:b8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Mon,
 23 Jun 2025 14:48:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 14:48:38 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Jun 2025 09:48:37 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix AMDGPU_MAX_BL_LEVEL value
Date: Mon, 23 Jun 2025 09:48:21 -0500
Message-ID: <20250623144821.745908-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|CH3PR12MB9098:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b451b9-978c-44cd-2cb8-08ddb2650a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?heF5tdZtO4pUWZ27zf9P8+hpsqW2zp9hwms13mrox8gOmni5mi4w5eQQ/T+y?=
 =?us-ascii?Q?qeBwKtM0qFsSBNhujB/ILpTHR07dkyCcHlBj8ujzcUdJqIvCsVPr3M4PpOky?=
 =?us-ascii?Q?YtXpQ2TuUMcCzmwPlHu8Y48SJQrzBHUo9QEOrvIQ9CHWjyPXtA/l/GFJS4k3?=
 =?us-ascii?Q?WLbP4ksVKd8S5+EIBB4dDIOfDW5XkQKtThpacpR7jbJcEP9/gWTbZYH0s9mU?=
 =?us-ascii?Q?QtIc/dMnbT6a+H/uFQ2v2oiel6H0nRTaiGcFc+DFGL7UftKrX2W8ZD80bEmq?=
 =?us-ascii?Q?/SU37G8G4kDaVw0ZLy6Y1U9IEM0+2gxyoLnmMjK6dxrPtp0jWDTYx3sjf/yP?=
 =?us-ascii?Q?vaBUPywffg4OGQRwdxVYCbXVBkz3MTf+SAZfqTmNgyPMvAhHoVKHmCNcvgCc?=
 =?us-ascii?Q?UJo8/ktBdHq9/0mIU1CGhtAkDFY8HKccKzvGh55a8qWw2t4wBkBRUxz+vOP4?=
 =?us-ascii?Q?FMBCrnUFsKjvKMZUVMcHpAqEcg6R4z05V5sgF2xWwDRS7LCx6fG4etImLVxb?=
 =?us-ascii?Q?61x9DlOoGA7bC8BgeY9uC9BvffxMNEtoeWPJdb5ONbUzH7IHmguHUIpr+A9f?=
 =?us-ascii?Q?wKCjc1PSOB8/QAsVN10jSSWIDOKU4BZo1G8QkV0nEnc24dAt4861qYtWVSSP?=
 =?us-ascii?Q?MfQNaQIJkl0Z7oZtNTGDp9kN5VSaIM4yaZ6J/mejLYUv6zc/urqC7PL62Gy2?=
 =?us-ascii?Q?4iKSSOcVA4zZMstWMZLpd/iUT7psVs0u56bI3h7PojnqpAkeQc0JQhRTk3md?=
 =?us-ascii?Q?O6F/vrMNaziVz0jemPuUYW47wBwFeYWvSYRTXxqXIWz6IgQugCi8QLc4N/v2?=
 =?us-ascii?Q?ligR+ax3l+E4HAKb8vQ4RsstvjLkOGpYYyYWunThozfv0UthHH2YDiPsmB+L?=
 =?us-ascii?Q?MqSTBrXSGbxMUOoWF8twM4d59NmCOkgplias6XBVOabFpK9HN6B1cFRo4kKn?=
 =?us-ascii?Q?/tEACTzGsis3CBI75ghYs5v4jHeluJMS48JfUg+PjWBNTv2RL1VbZcYVLAp8?=
 =?us-ascii?Q?x1iVxNJJGoZtMuHCRDLu+XQ8uw2eG+wX6CgcPHmGGNMzHtAUs3lZj1Cmsn5s?=
 =?us-ascii?Q?0Jbn4ZWcQcw11PO3jOj7P7XBiLuCsqXa24eTCIR2+VhyWHCcy3pBT9Tivgaq?=
 =?us-ascii?Q?TIpOAjcFSb1W+Jakn4COUsIfVdNdoEmuxJwugoKo6QId+Fv86OK2/31r0rHY?=
 =?us-ascii?Q?O12HVa6mgp0j5c8k3u2GVcNJKm3tAKu0vw6FknPdZ2PMPuVvpBBqrzgreBn9?=
 =?us-ascii?Q?cgKhTi89QEELLv1n0eneCn0OCMVUYCJembEeQNZE6xJgfj8+X+NErO2TljJ0?=
 =?us-ascii?Q?1Cr7lQSwYFVCVJq2mqa2ZZkCcOsBkHVwu5NLfO2cjsJG/TcAh5pxdWEr57l+?=
 =?us-ascii?Q?N/XmZ+z5/bw4fOtYBIh/vjrpGz9WwdayjYy/TzBzTIUR49ZeoRjq+vuqE4dU?=
 =?us-ascii?Q?cXlqh/1ejyqFZj7nUBP6AwdxZxMnkYneohaKtUB3UBNbbAcfmkqMeEyT7ZnP?=
 =?us-ascii?Q?1s/9RhYCvR38UMINiFNH26cUb+5NNhsWm01w?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:48:38.8231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b451b9-978c-44cd-2cb8-08ddb2650a3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9098
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

commit 16dc8bc27c2aa ("drm/amd/display: Export full brightness range to
userspace") adjusted the brightness range to scale to larger values, but
missed updating AMDGPU_MAX_BL_LEVEL which is needed to make sure that
scaling works properly with custom brightness curves.

Fixes: 16dc8bc27c2aa ("drm/amd/display: Export full brightness range to userspace")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index 6da4f946cac0..004450cc41c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -435,7 +435,7 @@ struct amdgpu_mode_info {
 	struct drm_property *regamma_tf_property;
 };
 
-#define AMDGPU_MAX_BL_LEVEL 0xFF
+#define AMDGPU_MAX_BL_LEVEL 0xFFFF
 
 struct amdgpu_backlight_privdata {
 	struct amdgpu_encoder *encoder;
-- 
2.49.0

