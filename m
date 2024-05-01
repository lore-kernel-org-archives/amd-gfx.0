Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1AFC4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4C7610EE29;
	Wed,  1 May 2024 07:17:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JfhbmpZ0";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7157310EE29
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:17:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjwUSEWVOvOItJQkFKqmqxK/FBSgfHBtYpcW6AlhT7XmAwrw1fC98KtE9uvmspS/1sD1F0Nv60QYTL5rJ7gc7dQPmOxiy/j2W0CDTgk2B3GEKooMO9lhjrR9el0KThoatfZ7YDXBiCi+ajEwvjadwGAB1zOseF/+K8FxW8ztzZTIoW/eh/rbuZ1UYmptbcb9Aiy5Xzetz2TunEWfG1rCpSAI6lj0RgWXn4n9cEcOO6nZPP9SnsdRJBYKED7Rd13q4myQpsCAqbBQuLKN57RBGfW0FHeHIVNmM+tPYPluuA4orYS3JmH1LKQym/r2sx1bI7HBptdiwT4XYSMrcF6P4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwWBSJLoG84r4NeRR/Jr+9s3z7fqVvabACfI4X+a/Bc=;
 b=kcMKEN9mxB+Lwha/0QVk2Nuspu2DVr8no1foI5g6oqWTovPNyNtn/UbMnC2+2TO8RdA6QnUyFv5FzfAlx4Qmv2bX4MIM0ew5dxp3f4kX1Q+jNMq4EBBxKfm7TFPCjtRKqM3YUBrcQ06+cW/fSiUnjBW1q9FhF92yG6tUxlxcjNa6h1TSfgZBiosDBVbaMaHRLiO9Y0QvA0vAsyLfdmLF4H7DC9KYobIEYsIZfVulVNnYOqPIuCj49doyaLuWe4R2ghVdmoKKUI7F2xHLkhpA1M4ZY2G6pLObgf9fISd2PToQOrx2N5vqoui8D8jkjv/QIhtTyYcV0GXVAOtophKb5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwWBSJLoG84r4NeRR/Jr+9s3z7fqVvabACfI4X+a/Bc=;
 b=JfhbmpZ0yhr0NSxpDcRHM271IcCQ3cXQO1b4igNPChdvPsY/H9VjPlqCCV2tKDluISoGJF/NZ9/BQv9OKwcREbfNSblUcBHXmBUnkkbAYX/vhs0ok3GBCg+zv0ynktfSBBLp/SYJlTNdr5zd7ePHuxErI0gk+NdPJJ7xI5qkK24=
Received: from CH5P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::23)
 by LV3PR12MB9167.namprd12.prod.outlook.com (2603:10b6:408:196::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 07:17:52 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::ce) by CH5P220CA0024.outlook.office365.com
 (2603:10b6:610:1ef::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28 via Frontend
 Transport; Wed, 1 May 2024 07:17:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 1 May 2024 07:17:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:17:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:17:51 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:17:43 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 10/45] drm/amd/display: Check gpio_id before used as array
 index
Date: Wed, 1 May 2024 15:16:16 +0800
Message-ID: <20240501071651.3541919-11-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|LV3PR12MB9167:EE_
X-MS-Office365-Filtering-Correlation-Id: 2414a7ef-b6e1-4935-ffd7-08dc69aed05a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400014|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bHrViIabuEVpu/ukUgr874QNR6sxB2q55s5cU7yWNx5zkLyjn5oniUYvy3gO?=
 =?us-ascii?Q?mCvWuz7fkEwpTvmTb5/opobMYao0Xix2ckFHEgwOmaF7czuM60ClKn1ga3yu?=
 =?us-ascii?Q?LuG7fyMCQaTq+tH6GSUIexsSHWTSxuiUtAYxQBVYqeqPVPuX8zD8YI8m/gur?=
 =?us-ascii?Q?JNPTH1br6Dn/BfSwGPozObe9S3V6IkO1sPAYu+8wkfTbj4yw+Oc3qaZBlhps?=
 =?us-ascii?Q?WCRnvK+FtdZa8EHp/t4qlGA5jeC7jJZcGuAOJGlrmT7H47fM857r6QoF1Ib0?=
 =?us-ascii?Q?Zxt/T9aEl8lEzreWf8qxbA6UwMO6MavxcV0/RXeIrQohp49ehJpHbhS6a/es?=
 =?us-ascii?Q?s5FTSjho5QIUuMa7ka5Ui/8T3k5DrgZXpGvCCzLuEN/StXzLe6nFu/ewGZgk?=
 =?us-ascii?Q?v+Jj+9OHud3f3+ivYLHBaSInAKlBlpoCvUAjcAbZaZn9oNMvkTUFAkYxQ/BL?=
 =?us-ascii?Q?FcIjQwRqF4tGesBzQKZuVUpjD1MsUdxpqA6+Hi8QMCs5JHXxkeMuOfRwGlW5?=
 =?us-ascii?Q?Jaos85jYgqt+YHdcxEw+JrMGwNqkEU25b7kMUDGyS7XDvyPL4FZqG0cOuXxR?=
 =?us-ascii?Q?maSHDfY7BXGUVI5/dZeB+3/Z3FQ7FDnIMHu3RnKFdFZhequzfbZ9DqoQLQma?=
 =?us-ascii?Q?eqlBqsyjpd6yccYC9Lgbr8XPEFV4UjrgcbX5dvfKhmyEZFwQz/Ox1JrS0+Eb?=
 =?us-ascii?Q?a4fNqiqVHsjdxzgMLnewNmlKSXDtW4kPXJLcftxdiGuuU4TjwFW0B16V8UxI?=
 =?us-ascii?Q?H/4ZUodBmoO5Ng1252BXVbLOtq6qkKcYb4xHxeKAKPpw+9Y06ZHrsZPC3lMO?=
 =?us-ascii?Q?KpPYk2nekIMkbIye0eHJeB9iCEBJqEpNdhOOXxF5W38LCAymYRkUjIHBS6U6?=
 =?us-ascii?Q?PzAM/xy6jJlc1t2JH+O6ZaybCiaPvh0Rp8DNCORglYjyIOevBzXIqWzWKeUG?=
 =?us-ascii?Q?pM2MQ1BDo4UvO/Fl9BPp0p2VUZL8ZX6CFlF5UGWMXViouBid5WOkBpNhQXcD?=
 =?us-ascii?Q?4wjZD9Rx4TSXYzOvu94VYVawWD2nurrqRfXz2JAhIYl1ti6NML2tV60iappF?=
 =?us-ascii?Q?d0ar8M6/7RS0R1BcGy7TyyS124sxQLesbU1ljT188IU2gVOYdgcmtMTmPnAi?=
 =?us-ascii?Q?fr0EOq1EgULDd/k/eVQo+U/kcm+hitZm1G//y+HRY+7qf0KlBMKMgKigO37g?=
 =?us-ascii?Q?fVxFj7Tr/NJpr8XLkPKdv+lD5rjnzbyGDfNGNlVtOpou9QshpnmNU2dxh4JJ?=
 =?us-ascii?Q?aNi7kChyqXBCtb9WIiRgFVYnX/5lVh7tF7pp1ZEXTSSEongK6mkzwV9fWr29?=
 =?us-ascii?Q?+KW8AsP8ImbSPrWgdxGcp0piBk6m/gEAVK8uGWTwdp2XGCVdNeG1I+E7cm1R?=
 =?us-ascii?Q?/RU8wVIvOikig6rdSpwZViipDaAn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:17:52.0149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2414a7ef-b6e1-4935-ffd7-08dc69aed05a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9167
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

From: Alex Hung <alex.hung@amd.com>

[WHY & HOW]
GPIO_ID_UNKNOWN (-1) is not a valid value for array index and therefore
should be checked in advance.

This fixes 5 OVERRUN issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
index 663c17f52779..d19d5c177022 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
@@ -239,6 +239,9 @@ static bool is_pin_busy(
 	enum gpio_id id,
 	uint32_t en)
 {
+	if (id == GPIO_ID_UNKNOWN)
+		return false;
+
 	return service->busyness[id][en];
 }
 
@@ -247,6 +250,9 @@ static void set_pin_busy(
 	enum gpio_id id,
 	uint32_t en)
 {
+	if (id == GPIO_ID_UNKNOWN)
+		return;
+
 	service->busyness[id][en] = true;
 }
 
@@ -255,6 +261,9 @@ static void set_pin_free(
 	enum gpio_id id,
 	uint32_t en)
 {
+	if (id == GPIO_ID_UNKNOWN)
+		return;
+
 	service->busyness[id][en] = false;
 }
 
@@ -263,7 +272,7 @@ enum gpio_result dal_gpio_service_lock(
 	enum gpio_id id,
 	uint32_t en)
 {
-	if (!service->busyness[id]) {
+	if (id != GPIO_ID_UNKNOWN && !service->busyness[id]) {
 		ASSERT_CRITICAL(false);
 		return GPIO_RESULT_OPEN_FAILED;
 	}
@@ -277,7 +286,7 @@ enum gpio_result dal_gpio_service_unlock(
 	enum gpio_id id,
 	uint32_t en)
 {
-	if (!service->busyness[id]) {
+	if (id != GPIO_ID_UNKNOWN && !service->busyness[id]) {
 		ASSERT_CRITICAL(false);
 		return GPIO_RESULT_OPEN_FAILED;
 	}
-- 
2.34.1

