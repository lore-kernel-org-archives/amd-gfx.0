Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FB5D1CDC6
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 08:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 428FE10E4D6;
	Tue,  9 Dec 2025 08:58:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PIZ9nmKm";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012029.outbound.protection.outlook.com
 [40.107.200.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0EC210E4D6
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 08:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J71zlBXoFn98v/LUwvxCuu11VOvhwKoU0r/Ox1bL9iTIiC9TEdSyvN9dCiMMcfsWa9CUYk3eiwrTUaLByRFku+VhfqRVcbpgaVy3CeN0zVa87KS0ACd2nEQfycdHNmvAOTTuOiVuzn3pr4aDT9BnyKZwmlkLf9Ke6xW6sYzWrtJHh9MO7PoQPY4IDvHpBfdh5U8AXpmFUOp3ul02nMj/ubYlW/oWpGHPcL8B6RuJ4KqhPM5KJmZgpHhUGO04DsH9jEUkQhhU8qtiDlHZ69Kkzvrfqh/hA3oXVYSQRaxdc29YddoUokCL8QOnFi3aXQVzBgxdQ0SpZpxiWGjm56m/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZVR1zTb9B7q76mr+MFMmhTb73+tE6qGaH+e7QsNCh0=;
 b=y18XAuZWbAmAju7fs0dDocR8jAMkLkFiz6zy3ZBwgDzgnIxBlvAifpmGjOWME9b6sppwIiHpOV7bwvBIf64vNTgxUK4PGnG6G/8gAjfjjZ405lwHDFMrpThlJ5Z7lNh5x/8Ds5abxeQaMvod3Z1nbmw/6AAbZiCFvGMz5NsIlKTVRIMnr1MQWyn+jSYWDFReN3K1ximHTAeqFmL2temFm0In7bfEU9C1d7zyt28u5wdUMtb6eZUs7qhDoN7yPImMaTPpK6HThL+cbZ00YIiJzdDL0l0ddrmIPPnXZhC26lucwdHt6TtVtSoxu0YAXyOxLob3Hn/TTmaRiwDTZ+HoFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZVR1zTb9B7q76mr+MFMmhTb73+tE6qGaH+e7QsNCh0=;
 b=PIZ9nmKmR1l3Uz6uuGZa6RjnfEXggh6MPFWfUY4x8mgMMSiWNoY49vUrWwWKNjI/u56d5uIBjMJKvV3MOocBwpiE9hbKKPRrz5NairMagCv0yzBEe5rOrOxadLaJts1JDy2rHLtek8hOXm9ifOLFIvZSe5TnmwpHOTaAp1iSW7w=
Received: from CH2PR20CA0012.namprd20.prod.outlook.com (2603:10b6:610:58::22)
 by IA1PR12MB8261.namprd12.prod.outlook.com (2603:10b6:208:3f7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 08:58:21 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::e1) by CH2PR20CA0012.outlook.office365.com
 (2603:10b6:610:58::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 08:57:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 08:58:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 9 Dec
 2025 02:58:20 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Dec
 2025 02:58:20 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Dec 2025 00:58:12 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Fudongwang <Fudong.Wang@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Fudong Wang <fudong.wang@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 10/15] drm/amd/display: Set enable_legacy_fast_update to false
 for DCN35/351
Date: Tue, 9 Dec 2025 16:55:13 +0800
Message-ID: <20251209085702.293682-11-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209085702.293682-1-chen-yu.chen@amd.com>
References: <20251209085702.293682-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chen-yu.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|IA1PR12MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e127ac0-41af-4351-cb0d-08de37011a6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hTntALITS0etT20DX/u+gZGd1OUtfHUIpbrLDAdFzFnoNkxWf1VRSgR/iZ+m?=
 =?us-ascii?Q?b/XcSzVqGNKMmADV38vMhCdesNrNUAS6TtHo8ROYVjZEvChZgAEjQvapgzmk?=
 =?us-ascii?Q?PFf+B8ai5NBlANabHXraaZFagDw9KzlA9ilwgPVCs+YMg0slwGOzCKJlirye?=
 =?us-ascii?Q?0mPf6GiiuIyB5ky04qVsoaaSzyZK30IoBJiEO7cOQ+MJK6CC//K66kq3pp2K?=
 =?us-ascii?Q?Zw2GSBpDxi5J/zCJhITSN/y5XkxIGoWh1H0mrweijqXnNawnijXZgcmSHzeT?=
 =?us-ascii?Q?Lu+/i+EJIJDYErI8+R0PZ1SbYf23XU+HbOHy7GolJvh6mpbynh1KcB9cpHX1?=
 =?us-ascii?Q?Z55HbEKq+RpkP0pH11qW+9cP2YPdddj30ZQCl5WuDfVyULFTxjOmmtRK5qqX?=
 =?us-ascii?Q?ecAFVi7hFyUCKu+h5nI5sJzmMUqeTU+ZmR7hAvFyvpbOT+DSg4VroihX4VSK?=
 =?us-ascii?Q?q5uEUCF5/3i58H4EVV0gjwx048BhzgM46pySIfQaakYEkC2/HDod8c4p3ioa?=
 =?us-ascii?Q?iflLK1XzZw18Ak6PSjF76E910DkR+osXxev2oLP4UY2kGEXzqxsry/aNMgsU?=
 =?us-ascii?Q?dAU7suI/wqfBEL+Zki9Eh2GjI2O94l5VU6ZdIHcvq7k6usTPnYUrj3J5Q/9Y?=
 =?us-ascii?Q?e9SEeG5ofn9SAzRJDnAHeDiky+cVglzMXqF9PAxwHAqIdyCQlrPaACFE9kL+?=
 =?us-ascii?Q?8/PyDyWhslt3gsUF82D7H28s5vlZCkAHb8DAkkkWAWHJbsdM85AlA8YJJtFW?=
 =?us-ascii?Q?awpXrzqq6heUdywilleHMGlQTrStEYxj46KnUgtBT8lEgv7ACsoudy+pMH0C?=
 =?us-ascii?Q?YhR57Bmo6tqCQOxjGIfr4NnOm/xAhz1UUEKnu6dgnxMC0qazb5Su+TTIn+YE?=
 =?us-ascii?Q?A78OxooDgk/lwAYXT+ROmkesq25qbqWDAOw2bKKQXVNnOWwqoAHT8ZU1ALq/?=
 =?us-ascii?Q?c3gpZS0C/wpd5H08sgaPPih8HZZXx8jMw3N19H5+JKMg719m74KSUDdRd3Tg?=
 =?us-ascii?Q?D6gfOav+gzwSFKW9Z5WOyAIGF97kGZd1zkTuXe5WDTQGAvUcHFmGFoW631mu?=
 =?us-ascii?Q?VWlQaMe7iKieBxsqewhaK+XoYO2bkNPOZUejDSrAO7jZRSI915FkNN879j5k?=
 =?us-ascii?Q?dOeYhRovGf8gbCqn9J9BDATWcPK06eXTqbehyiDFdBPFmc13H/1L/H+jqtwu?=
 =?us-ascii?Q?iupbNqN28bAAwh1eC/bVU7Gmoa26Zqdpm/YGDEQL3o5z47oUPjrHTNW+ZsFg?=
 =?us-ascii?Q?gtq3Sg3aDtfNDd7qBF3/8E5ZdzhY2/ZTOommf7/Qe7D3Nx7ezi32Ysmlj5YV?=
 =?us-ascii?Q?nf59q/H7XZxcOTkyE42fLCe7okecgKtY1pDQgBoHH1g5tE/8lem91mAAsl06?=
 =?us-ascii?Q?bvKc/3revjZ+oqBpns7AR8kys4lgb0Mc12nye38pVuGn6slYqb/9fETG6URK?=
 =?us-ascii?Q?0T4TnekCFu/3lOi9VZC3N7dLAQdGpBucskumianVhQYV8l4eWB/+g4frxNrY?=
 =?us-ascii?Q?/xqZFqktjXcTFl2c/oJzRoztdHhMPqp7WVeajxI9LtXJr9HdRGoiAOp3hF4j?=
 =?us-ascii?Q?q/Jz8hFOEpbRKZ6SMdk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 08:58:21.0642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e127ac0-41af-4351-cb0d-08de37011a6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8261
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

From: Fudongwang <Fudong.Wang@amd.com>

[Why]
Existing logic will treat color temperature update = full update, cause
user color temp adjustment goes wait for update logic and fsleep in that
cause the adjustment not smooth.

[How]
Let DCN35/351 to follow DCN401 to set default value to false.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Fudong Wang <fudong.wang@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c  | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index d056e5fd5458..45454a097264 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -788,7 +788,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 };
 
 static const struct dc_check_config config_defaults = {
-	.enable_legacy_fast_update = true,
+	.enable_legacy_fast_update = false,
 };
 
 static const struct dc_panel_config panel_config_defaults = {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 9fab3169069c..e3c587165807 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -768,7 +768,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 };
 
 static const struct dc_check_config config_defaults = {
-	.enable_legacy_fast_update = true,
+	.enable_legacy_fast_update = false,
 };
 
 static const struct dc_panel_config panel_config_defaults = {
-- 
2.43.0

