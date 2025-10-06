Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5410CCA470
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Oct 2025 16:32:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7995610E41E;
	Mon,  6 Oct 2025 16:32:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lo/d9Df7";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE96010E41E
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Oct 2025 16:32:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYmqe7nr31ganzEkodDHZVO7rHm9aapI+P1ibpDO8hNo87JpV4I13+wcCqx2B7dkQ/5Ee9R3qwrIiiEoHdqw0OprbPpEDzhRdEK1R51STs5IqjMIxDYjFNezzCAC7Ufjj8TpMppa4SdLKonphTSBRDIGRt2KV3d20d7biS+B17pjm+nJibHiigVk7VnhIU/XyNTwXpszcY7nHeuEsNYywHuuGWP4RnQfZXZp6bfw4q0acKj4qHzUFxY8xtE9zw9RRLfls/hKnlI2lZuBBxJGnE4oL7HBkdmSx+zPfXbb7tQW8Pj5XO6rgEBpbhzOGvW3VRSiTgASvg5DPkUOJX76TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XySu4jpdUToG5WWhjvK3n9myZTLWXLu7qs+amYZmgRE=;
 b=hjhTBmpYEaIApkyairl0jstaBp0iaSj6syvbQjTwfylSJgaz6jFimCyZoXQIsfjtKWggavb2m6JHw8P23xA0ok9/J360He5nH1uVqx/ORtJfEhyBd1Z5KUMdIMjc+e1jOCJklwrCBLqaAU5PdW8CLOoGLnRU6bzNe4vqxNusAUJCA9/6yqozPdLvfmZcP2ymXA6reoc9BDcs5BChgPVg2ApzXHhKpzntp7XUc1lerkPkNlqPZ+90AM2YopTxnXCSDDP5WCOWwszCvN/WOFgtQSxIzze/sV3SLRLEyj+Xm4/fAhMH0apu8z+Bsf+KshFlS2P0op250U1XGwpFegJu4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XySu4jpdUToG5WWhjvK3n9myZTLWXLu7qs+amYZmgRE=;
 b=Lo/d9Df73tHCZwWGWnNipUnQe563u2evd1zhqPJ5x+M/TDIpi0r5EQwuDYZdjdxSmS2IrDx0S2rI3uPjtx5VdmualySGSwa4jCtzuJaU1hQt/OUC50RYUOvh+DFeTUup03pllzmeobuvPjVsvbKPz/fzhJWvgjeCzAwX51112ys=
Received: from SJ0PR03CA0118.namprd03.prod.outlook.com (2603:10b6:a03:333::33)
 by CH3PR12MB8281.namprd12.prod.outlook.com (2603:10b6:610:128::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 16:31:56 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::e8) by SJ0PR03CA0118.outlook.office365.com
 (2603:10b6:a03:333::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 16:31:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 16:31:56 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 6 Oct 2025 09:31:55 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 5/5] drm/amd: Adjust whitespace for vangogh_ppt
Date: Mon, 6 Oct 2025 11:31:38 -0500
Message-ID: <20251006163138.17489-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006163138.17489-1-mario.limonciello@amd.com>
References: <20251006163138.17489-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|CH3PR12MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 8677f4a2-7a15-42fe-c61c-08de04f5dd8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M4xULXlyNtf/7rgqaNu7ikCkSubD6TcqzSeP8MDD4pEkIWL+5Cr2acRtVaNx?=
 =?us-ascii?Q?bmfUmEqZOf3EpMXM5KB/66G5i84B0y3pBj0XlOjq2lsXoI/XDWKoh1ll9XrR?=
 =?us-ascii?Q?7MvvT44grzjde6OmGeBwO4vzpLKZeBeRHF3M4dIj63x675SCKthBynOMZRJ/?=
 =?us-ascii?Q?TIDDYYBGZBPVaMURPPEFPxzVp9tqgIF3n6V2iae+/nyTxn5uu5iw6OuMr3Vt?=
 =?us-ascii?Q?ttyZ3yPl2LX/Bu7gzf5YhBrgKEipz6jF+mTZ3qoAkbXcsqgyWr2jApcYA5JB?=
 =?us-ascii?Q?kQ1Ilk1bKbUzum0Jdg5wr5W2JM+Ozsx0xJZmvxLGyybRWq8F83IonZnJUFvQ?=
 =?us-ascii?Q?su7aaT4mpbDMhhoPrybbI74YUNYlmZMPjlQ30uTZ6laa5ZR+xxTJ/HyzZp8a?=
 =?us-ascii?Q?ctAvuh1p4zZAsxE8SLhSL4Vmk/RhB/C4NOuFpvsJjrsZzAyenegUlgaYThde?=
 =?us-ascii?Q?W7NC7n7buqFFDWmWx3wdEy0auNiCI8zCoYckl8+An+/LcrtHgxjiFnVd4Ukw?=
 =?us-ascii?Q?oVISy57rA/luAVGpP4YgQm77nMZvRhy1Z5b+47IUjw2MFBPZHpkRA3f+SuGm?=
 =?us-ascii?Q?lpoZNhSiEbKjDxrXceNLX8DtGLMljiXT6F6GmEY0a90BIwqBv9Uro1jy5POm?=
 =?us-ascii?Q?8VLZglvOnbHM0Ih/zT6FtgsTARhgWniyDnMLuePuX9u9qnyDIkSVpOLNM/TF?=
 =?us-ascii?Q?UlU6GEg0ZVbxiZbaR5mdaa06qgkP3tevKw7/HOq2ozuptyKd+cPbGRK5fTMj?=
 =?us-ascii?Q?mKmjyfwTea1ETJdCm/kh+IBbsaUwKeSyQpyYoJVTNwucE5jRrDUb4kYdEQP9?=
 =?us-ascii?Q?NRc3GSN8g5yMOZ4RM5L/7o6hSiJbgJVe3h7fXL6bLpseZYY8F0hsIzU/pRgW?=
 =?us-ascii?Q?wTwMn8wFBC6f0b+mbnk89hmltR/uPn1YUb1s+KpRlv12m50Tq7NW2emBMzXX?=
 =?us-ascii?Q?NIJqM6H13BWdrcHBuX6vf55OlweuvqXkuYrUPaZa0eD13d5lTpwxUzTcYFti?=
 =?us-ascii?Q?ZqiRDHIAaXN/27z9A3TnxoFfnfjRavRSBun7NWGOY2NlrxcPiQhw2P+9pYGP?=
 =?us-ascii?Q?kHtIAyonVYGpmD1ZC8SMrDGAObdEhBYA63HHrJnPoqUYxEIQN1wADjznfiqL?=
 =?us-ascii?Q?oZJtPZzYgorp3D7JgRx908X//msQzUHwHAsfH25KfwWtAYK6VMb3gliu+Bxn?=
 =?us-ascii?Q?hfsjqtVWhmg3RTgIZKvhSVqb0glAW+0/1Hof+8/mI9x22TB8lxadjSjERMwC?=
 =?us-ascii?Q?EY4SWu2jB/p7i7RWxkE7YGl+jjQaSX59rzKOZuFFt3npPkHpHHcqxx/a6XAj?=
 =?us-ascii?Q?kS+9lCKpZ5Im2aCu6jkTP52LB9Tq1bQF7Vk60ClncgVnmdMvt+s2tAkKUHaj?=
 =?us-ascii?Q?/ZZDtuCl1bOW/VYqRS8c/+bMqKe0cUbC7/e9ACfSc9nu0LFlp5xzYgLhY1wa?=
 =?us-ascii?Q?4KhpS2UyvOotXQTqAVkYPFFt09w9prO1v9cPdRo257t8Z0qzf4rNZBy+DjKT?=
 =?us-ascii?Q?5hg88SUHco4CzV5tsBh/dJrVmsX2Iw3CUi/EV/M9ieULoEYwkvTRHgdMeVs+?=
 =?us-ascii?Q?SjbeGCX7BYBxDiILYYs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 16:31:56.2851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8677f4a2-7a15-42fe-c61c-08de04f5dd8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8281
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

A few changes have more whitespace than needed.  Clean them up.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 81077a3969e9..1dcbf250f486 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2308,8 +2308,7 @@ static int vangogh_get_power_limit(struct smu_context *smu,
 				   uint32_t *max_power_limit,
 				   uint32_t *min_power_limit)
 {
-	struct smu_11_5_power_context *power_context =
-								smu->smu_power.power_context;
+	struct smu_11_5_power_context *power_context = smu->smu_power.power_context;
 	uint32_t ppt_limit;
 	int ret = 0;
 
@@ -2345,12 +2344,11 @@ static int vangogh_get_power_limit(struct smu_context *smu,
 }
 
 static int vangogh_get_ppt_limit(struct smu_context *smu,
-								uint32_t *ppt_limit,
-								enum smu_ppt_limit_type type,
-								enum smu_ppt_limit_level level)
+				 uint32_t *ppt_limit,
+				 enum smu_ppt_limit_type type,
+				 enum smu_ppt_limit_level level)
 {
-	struct smu_11_5_power_context *power_context =
-							smu->smu_power.power_context;
+	struct smu_11_5_power_context *power_context = smu->smu_power.power_context;
 
 	if (!power_context)
 		return -EOPNOTSUPP;
-- 
2.51.0

