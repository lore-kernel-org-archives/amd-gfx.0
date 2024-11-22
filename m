Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91EDE6918F
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2024 19:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B98B10EC5A;
	Fri, 22 Nov 2024 19:06:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zcLcK2EE";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53ACA10EC58
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 19:06:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQyYjTDBo0aDKeiprW99l2nPlNzBUxxiim4jw+GW128CJq3APrefWEJ8B3oGR/Gs4UynEdcgb7OclK//cuiSF/SwPG9CuajflY24dlKls3oexQwS1PoSqHyMPX8A5qiO78HoUDVLbBWdVqjpTccOGjWgI2RncyocSYzXS4sytZYXMWLOTMgLhH46C3ZmV+qV7WVH0lUcrfSKFY4iVu9z5IDPhMcEPDzicTvf6ntmvV01K/4FphlcvynmExKOY6Ld5X8FF4w4e6mEeHcE2PvQqW6trIEYhm5LwlBDkGMJaeobV+HAz9w+U07VU+47sXP9L5lQtehzxAW/ypqSIjMtTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrrQL8yFN0OX7DF7rmQ49HHp9YmdNuSXm/YaUE+RBKo=;
 b=Dv3msu6Ys2lu5kAYaUyk8Pbe3E+Ie878E3sbQvGUB7hbT1HtjfuveZ9rnr2NtumiaMCibTkm22hQCGQ7VgJFImjMqmIjfrBGSWd0rqvWcXpapQflu7Gxo+MUwvHa6tTCaF1sBhHWgSoWirzmQtfTIAHa90U+Q8gjPo/WINOmCBPtYCugYjJjgAZ6KKOXe7jSgAwXKCBEo1Tzt2sP6pIN/6N6/2q1Bh9myWLmteBpTWY4G7OByL0eLpN9ioNz6+vL+aw4UaSRwCMLy95chCtFBa3kHHCp4ux+TIw5POMzBlnzWCC+9hdHKfh6kqbnWqkqHnVKqpPXw5JMEdt+T6da1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrrQL8yFN0OX7DF7rmQ49HHp9YmdNuSXm/YaUE+RBKo=;
 b=zcLcK2EE58F0wFFc32x6aklDM3v+eate4KKBpiQzN5nRjjwON7Q4ER4U9SeFEYmiOTS0HK4lFdzRLZJ0TxGLP9b/YxzWJUvQBzYTusF9+XGmQbBfCZYJMyjGmDpKOIjEmjbfm0e3H09L/20DyM2HUXbyPrCcIjdN6Ms5ZGHt6O0=
Received: from DS7PR06CA0046.namprd06.prod.outlook.com (2603:10b6:8:54::13) by
 LV3PR12MB9233.namprd12.prod.outlook.com (2603:10b6:408:194::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Fri, 22 Nov
 2024 19:06:44 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::a4) by DS7PR06CA0046.outlook.office365.com
 (2603:10b6:8:54::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17 via Frontend
 Transport; Fri, 22 Nov 2024 19:06:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 19:06:43 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 13:06:39 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 3/3] drm/amd: Drop needless call to evict resources in
 prepare()
Date: Fri, 22 Nov 2024 13:06:26 -0600
Message-ID: <20241122190626.19305-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122190626.19305-1-mario.limonciello@amd.com>
References: <20241122190626.19305-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|LV3PR12MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b29d5cf-583c-41f5-e675-08dd0b28cde9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SQYBt2LVRzTFahCBaGOHw51YXRnz7P8BBBie0i0BOL6SS5BdUAymB/Fg4zdr?=
 =?us-ascii?Q?e42yp4AeLOAuGRwjXNqgCGsvV6GcdGxo9gTUaeR5+RIxamJWEuktW22sB5GZ?=
 =?us-ascii?Q?HuowiNgVbI2BK89iksSSWAiChAIqVX6wIXiSAArGkPS/fiyWtKjPJuI/kv/Y?=
 =?us-ascii?Q?2tsMvg6cbhmlJ11tWMXi53Ea4TbEWm/0hK49qTpBdfUZdfmpbpCAIiEk8qZm?=
 =?us-ascii?Q?yh+6B7IgmrhmF7qo3HQi7t0VmFTctT4pIgv1QCLBsPTIYtPTSeORsOhJXdvI?=
 =?us-ascii?Q?d36On2XRYX4Li7Y0hvQOY2wLkLn6JqwLupolOEQolFQmxesTWc0JZmc3P0j+?=
 =?us-ascii?Q?RoPPgXJlTskv4D3pdk2z5GnTuekTzloVUR543U7SDoIln3D/47hpMU3v9bIW?=
 =?us-ascii?Q?264vc5x8LAstBVaEY96TGpfHU2qHivVu7qcCckJrvGulfvgNVC5brp7jq7d+?=
 =?us-ascii?Q?s4SNB1W7xlfq65ZyJMZRcZ0l9w1nQtBCe5Wox5WJGrpdFpI+xzQtOOirPzwU?=
 =?us-ascii?Q?tba0Ns7fbhzHyzjBSibx3WDtzzjqaKbaHg1FoL/rWX1wk7p9dfFhpHnI7UkT?=
 =?us-ascii?Q?hUXcK9+O6dELGMVvshYCrc3Qbr4i/NQth+tgdXqeViehGT0xHAsnA5iGIp+d?=
 =?us-ascii?Q?yOxyLTaH/TqYmWIToq7JiVOquw6czNy5DbzUE2wqOAZ2QmF4rKEFH0IxMMmY?=
 =?us-ascii?Q?ku+6KlIriSCBHm0BtcoJrYctEkUfyABBMEbUVz29cYdQs286LAVRxQX/RwzV?=
 =?us-ascii?Q?vCmU4oQsDawWzn3Fn5CF3ECuGf/s5IoI76LWLaXJIs31Oa4a1k39R68yZC4J?=
 =?us-ascii?Q?tmlgl54ZDPyGgEdh8G6F6fAv4JMLxTb4mX9GlE3n5ycgrpA27KEiDUDadgM9?=
 =?us-ascii?Q?YOej86mu3SoA0EQ2SiZnx/iHLbdLEB7ccyX5Rg11CBL8Aoy7CzBLISaTWOvG?=
 =?us-ascii?Q?EAZCyP2BcI9lZstq1cJlfBdNAhlO1LRb0Ayb4Iy7pSQlJoXO/3nDRynaJM6A?=
 =?us-ascii?Q?HN9FK2dDQs0XPTeDn//8Iy8s9b9wrf9d/quyjvihHiX1kLxDDyw/1893agna?=
 =?us-ascii?Q?GPs7/+Dyi6Ro+gOwgXmx5I+F7eAuqhpJuRdNPGCx99wBqRozKIEZ7ApmBSNi?=
 =?us-ascii?Q?FSLyJ0RZaAWlt4M+79fiNJiurLW2DcuoAfD59jpUMMwOJ1Rs6zqQfyupqUkc?=
 =?us-ascii?Q?R8sSqtgPEBwDVXVkRJ+r4XJgeKfwHv7pcn38SmqyZeqGgigKIR6NyKliv9JD?=
 =?us-ascii?Q?q0Ow1AodzP1Tl2/JKv9a9hDq85d2tp1s7cMUkOmWft61nDxIBeyu8CzHi7en?=
 =?us-ascii?Q?UgJ4BvFodJ2KrAAw0eNqrOefNw6fhq7B3+bLgZ9Lfdl8pio5CpEeh3mfUAjl?=
 =?us-ascii?Q?eBQroW5+AbgeH8dXhw9HT8ZljiHPQSaKoVjCGDFXesoSr/ivDiHjQe9eN5uB?=
 =?us-ascii?Q?ATIT+82kPgZeb6xJ2KTyoDOoIX75nDmq?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 19:06:43.6171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b29d5cf-583c-41f5-e675-08dd0b28cde9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9233
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

As resources are now evicted by the pm notifier chain, there is
no need to also evict them during the pm prepare() callback.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3:
 * New patch
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index be87491d1851..149a2fc8b582 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4816,11 +4816,6 @@ int amdgpu_device_prepare(struct drm_device *dev)
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
-	/* Evict the majority of BOs before starting suspend sequence */
-	r = amdgpu_device_evict_resources(adev);
-	if (r)
-		goto unprepare;
-
 	flush_delayed_work(&adev->gfx.gfx_off_delay_work);
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
-- 
2.34.1

