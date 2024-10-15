Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A42CFC274
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 08:18:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F64B10E542;
	Tue, 15 Oct 2024 08:18:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pg1M5uxN";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D43710E542
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 08:18:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZFpcx4MAZAKedIordgeQue6SUWpCkySFj+uFnuTridjL85C4cx78eAWYuGw1PIwRx9KiB8MzERWjVp8b1NwAa687DLkYZyWFN9VTL8Dfq+H+zWfD7++20fm0AC3ndUBnCZPYHhqniwmVERhTGAL4PfUqTunBbTO4ekmx+43M+R7OIT/iCXW/lcdV2Yoo/n/aBUdKyN7KVPfGKayIE/XSQW6Kx53d9uI24pwofjPFVTRqtQGS5uxhsMRnZthyVsrCSofBxZVu6IQ+BDm6oiQNi7jMtqglUhZWQfw49hvCm9R6pGk4ZuIgsp0msaEeD76PH8lBQTAknPwMr9l/HvQPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5ruAtQkyBcPDdQ6QU4H2zHfd4MaKUeqSC5KhztBgIQ=;
 b=kTh21UFQQf5jh7RufDURDVyf31nWOBKLq7oK4gGJN4ytARvkAGJehDgtNCDpdGV6tCfKCLS3uEMQt7e4W7Z59gbBkrIufNuPAMGQNoNtIrA5ulFvcpjMLwZ7kprkhXWE8k8fBpX9XA6GigubVtZFjwK+MNL90YH7lAj8qmNa4VDzHTir2IRtnkRz121sB2htmUuisc9mhHqc0aOqnXHb3/GuZOZIj2f9dJgRCHjGqs0ZlO6NuqMrb/lC324yr0yiM1gKJURKgCFp8abfNgcB1uGD32GPKHVmB7Sj8SI2zKlW1lS2N0OzzpsGQKyuwK1rSItJ8vAIpIwkMTw/bV4RlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5ruAtQkyBcPDdQ6QU4H2zHfd4MaKUeqSC5KhztBgIQ=;
 b=Pg1M5uxNv6FOs2O9w1d1oaCT4CXorlo8Z/I9JVl5EeqsRbFH70kRhG6AGlVmsn7BBxUKEfu6X3kXjdI8iwukJlGSoTlpzg16ss6VkkKFmgZlNMrO7hQOiNPoNvrqDFNsq2pYWIcBr0FkDCvzckW3W8Px3ds9sIxd9xr+vDJa6kc=
Received: from DS7PR03CA0307.namprd03.prod.outlook.com (2603:10b6:8:2b::13) by
 MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 08:18:13 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:8:2b:cafe::75) by DS7PR03CA0307.outlook.office365.com
 (2603:10b6:8:2b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 08:18:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 08:18:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 03:18:12 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 03:18:11 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 15 Oct 2024 03:18:06 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Dillon Varone <dillon.varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 06/10] drm/amd/display: Recalculate SubVP Phantom VBlank End
 in dml21
Date: Tue, 15 Oct 2024 16:17:09 +0800
Message-ID: <20241015081713.3042665-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20241015081713.3042665-1-Wayne.Lin@amd.com>
References: <20241015081713.3042665-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa53063-43a9-4f4e-9b0d-08dcecf1e997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2OC7FP9e3SzJXaegz4dW6OS73u/30tSFBb+M7ZfnVfjvTXBYxXtCkoWG3rmg?=
 =?us-ascii?Q?bu/uFOlVtDZ0zCZteZsEwUKNlPxmP4yxJcyahp35zt+peMMWiMOIPVh8rXx+?=
 =?us-ascii?Q?KcZ5ZOZiQqtCMaQt/QnotHwdbRe6dZD+nEC+BipsVHVqWzfneZ7AvBa71q9j?=
 =?us-ascii?Q?W95qJuxda2LWAW042dTTsUuBQQmdiuymCIEuBkBpFIl9p/kb8oAzThDpVFG1?=
 =?us-ascii?Q?ExpeOm66hlbv1ZQeWjzthGdb/GyndO0xcTo/Jvm/u4+y96/3YQJ8BEqm16Bq?=
 =?us-ascii?Q?WR/NiPisiEIuFW8N3t6xLB73twEcUc+lGHw4+VUfK+1f/SG7PQ6iu6/CeXSk?=
 =?us-ascii?Q?lVfrY/XKj6n8Q/fPQzAMyu/a5KDGhkWCbC6UdOT6e36QJFr67tVxry+xMlIR?=
 =?us-ascii?Q?mfSr6y/RT7HDcOQ/ZOScgQM+wjNlDsqgSLzi33TWP41YwPvf1EHhkliiokYx?=
 =?us-ascii?Q?cSrA9+vAfIBLGEjwq1xDJTkFJ36QTi+ay7JRELc7DC6W0OVzqWuf1y0KbFEL?=
 =?us-ascii?Q?yZLvwTu1r0jKuO+DAbEKC07bPcfRodHLw7qm5RAJzAX9y590Mk5i263CMVXp?=
 =?us-ascii?Q?oJqNuUebkIMwJM9g8DivS4d4aAc22rJAyQlhVVejLXbhWPwmHs3X/B2/A6QZ?=
 =?us-ascii?Q?sX9z1/d9ayhoglCfJuesstodIqgbhBnXyt10xLr3Y4kfCfUcIp/Dpb/Fmsbg?=
 =?us-ascii?Q?D+jgAqBMg1/xDMY0JIU+MN39mIuxFG1/yu6R5QLxQgFTpE/C19AQR/azz7/X?=
 =?us-ascii?Q?rCpzPHqcY6sjFUaK+t8wNlfGOiueMun0u0CmzxUBCNh7Bgyl5807HAhOD/4A?=
 =?us-ascii?Q?+1IXENVe4IquuEtzuqUwH5tslL0RHjiCHEsDJaS4Bn78hLRa0n+hCzTf0yPd?=
 =?us-ascii?Q?/PXiR32hvSlloflAS7ptiQpi3AC3usWTyNNN5uchArT/QWAuA7KHjdVbzLkm?=
 =?us-ascii?Q?b1FLHojalpJFK68otrX8KdWorK+f0l+kouayoIrjhvMTDImfuiYDqmvW5hhx?=
 =?us-ascii?Q?KkknmuSlnZ9tv13NzTl3Zd6an1ocWoBFh7wytu7IZyMooAXLsL79XS1CMCdk?=
 =?us-ascii?Q?qvDLuHgur60PLjhIbqmkyLT4IchZc67ATy92LRbJvMCFeguj0ISLjLI/G4td?=
 =?us-ascii?Q?74E/DeAdlKFqvVu4cxa8nYt6tQs5zoBGEBGG1J722GI4xWSdgyorjlWFuakJ?=
 =?us-ascii?Q?h2LogbiL+mZBT1n4Fp4gbrELF8Kz9dfKB8rrGN849ZOwwG8FN387QZ08m6p2?=
 =?us-ascii?Q?s4VwzvsBC0bd2NcDxDzVbKAs0vajeUr5d8XqMGz+rhQ2BYoFR3U1h4f6+o55?=
 =?us-ascii?Q?Ofe6ofeMz15heTB8tkVTH/kMPgAZMUwmEfYCacGkMAIdzp4B8RUwG/LZOICG?=
 =?us-ascii?Q?4WDRi3s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 08:18:12.8505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa53063-43a9-4f4e-9b0d-08dcecf1e997
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY]
The phantom stream timing is copied from the main stream as most
parameters are identical, however some need to be recalculated.
Currently VBlank End is not recalculated and copied from the main
incorrectly.

[HOW]
Recalculate VBlank End for phantom stream timing.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c | 1 +
 .../amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_utils.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
index 0aa4e4d343b0..3d41ffde91c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
@@ -159,6 +159,7 @@ static void create_phantom_stream_from_main_stream(struct dml2_stream_parameters
 	phantom->timing.v_total = meta->v_total;
 	phantom->timing.v_active = meta->v_active;
 	phantom->timing.v_front_porch = meta->v_front_porch;
+	phantom->timing.v_blank_end = phantom->timing.v_total - phantom->timing.v_front_porch - phantom->timing.v_active;
 	phantom->timing.vblank_nom = phantom->timing.v_total - phantom->timing.v_active;
 	phantom->timing.drr_config.enabled = false;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_utils.c
index ab229e1598ae..714b5c39b7e6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_utils.c
@@ -425,6 +425,7 @@ static void create_phantom_stream_from_main_stream(struct dml2_stream_parameters
 	phantom->timing.v_total = meta->v_total;
 	phantom->timing.v_active = meta->v_active;
 	phantom->timing.v_front_porch = meta->v_front_porch;
+	phantom->timing.v_blank_end = phantom->timing.v_total - phantom->timing.v_front_porch - phantom->timing.v_active;
 	phantom->timing.vblank_nom = phantom->timing.v_total - phantom->timing.v_active;
 	phantom->timing.drr_config.enabled = false;
 }
-- 
2.37.3

