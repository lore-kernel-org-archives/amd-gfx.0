Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBB0C021B6
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 009F110EAB4;
	Fri, 21 Feb 2025 15:43:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v44s0ikF";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5E2210EAB3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:43:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dY2p3C9if6AbcrDTtZTEtqgmXesgkKR9/DZSUIBr3IPk0znpkKsRtF9awJO7KzRHJc1/vL3HOy+5fiZFaFJ1GDYeKqzXMD5na9oKsM9EEMaLG2zxHBQvpTbNeHf2J/x/CMmGQvQ1CRZSwkH8WObrxBraCi+Dyii0z2lSxoO44ZycHH8nptADFZJjRGrsgUMu/S1cuiniT9LZOrzii/1CaPDWd9NyjWzxmentTYeWsxtCdCVDNnVgKi9Hrzw0h2EMWBEB6ARc12/h+Ke4lh7i82WTuW1uNzlyHp8fth3xodT5+T1Tr8K0nva0ya6rSlJH7kCsMKQAxdvsN3EJqxsZdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlm9Ji92P0mOSurXHseoOAGLeVWWIgw0pJ1LR88rhTc=;
 b=nsnj9M+T+SJUaxE81/5+Mz23xfPhhoIA+KRMngzm/2mVJGrfmA+o3fLZb0Nv0M6V29cgfWA3e4kHPcTq2z6lchacSjYgaqyWCpJtTQCuHxVPaaz8svxEZx5AMfEB1yKqwCTxNhBypyP1lTbGKGb6pPPeIejQuQ9o+IFjCI2uHRqWHYleziezilQ2k8p8E4zkpEP7tguj759B37D6bjxjvT0vl/OvPDxju1EX1FtyiY+WJJFU8ztclQyu12M1J2mKYqJsYfEIap0SKvlJVUL/GyXKTiYLTGIAg2dIKMkqTks8e7hipQJjFwhqaMVg0HXLPmHqwbCUU0ZsLNwb0BnRUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlm9Ji92P0mOSurXHseoOAGLeVWWIgw0pJ1LR88rhTc=;
 b=v44s0ikFeaAYSNGFyhkOb5MCQy+0yx8dSwTsaYYzm7FCRmABY4sXaeecDKobN35VgZDNExKcZ5E8Acq4zDENo5Aj/K0IO/AK3IBIUglQBE8HM18KcVQsN57noWhoFP1r06uksqIr6VIJqZD+4wOwgmxkDIz1kM5ILcUpIoe43+Y=
Received: from MW4PR04CA0109.namprd04.prod.outlook.com (2603:10b6:303:83::24)
 by CY8PR12MB9035.namprd12.prod.outlook.com (2603:10b6:930:77::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Fri, 21 Feb
 2025 15:43:42 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::76) by MW4PR04CA0109.outlook.office365.com
 (2603:10b6:303:83::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 15:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:43:38 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:43:35 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 03/24] drm/amd/display: update incorrect cursor buffer size
Date: Fri, 21 Feb 2025 10:42:51 -0500
Message-ID: <20250221154312.1720736-4-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221154312.1720736-1-zaeem.mohamed@amd.com>
References: <20250221154312.1720736-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|CY8PR12MB9035:EE_
X-MS-Office365-Filtering-Correlation-Id: ea6327d8-8e29-43ea-7ba6-08dd528e8294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rTMg8MvOkCjhelKjnYKkb9xMLYVtVwHwQJqElLkdDrjSZjf6ivzoeBFt1MX7?=
 =?us-ascii?Q?auIje2D5VXsfpIghXWFlTujYYQlQGvYKx/t9J6pbfTC4OZHEqonF+AiFk2u0?=
 =?us-ascii?Q?V8mNvbY+iwMN9wqejEtDllMOK40m1+rdZIr8GceAaw3Zs15NymqxJZhZR1OI?=
 =?us-ascii?Q?u9p19+nyaOBjwqlIQfMUpqrZlFc6JSDvmjTJCDfayOnVs4VVIDIP0ViEIn6m?=
 =?us-ascii?Q?YCj2RUzvEIBK0/IrLDBgyIYOzb8ezj4X0Ey9X11mPLVhLzPRcIZHP7spAni1?=
 =?us-ascii?Q?dO2ADTLpvBtMTq82xAgTFhnG5auucq4/Fp1EH8tKnuhsmojpC9err2QDdkTo?=
 =?us-ascii?Q?G16PTp5QzpO7hXag3G6dBXChk2SY+Kf9L8vA3dWlYr/IQsqqkGfiysvB4055?=
 =?us-ascii?Q?YIOdDMDXl5fJx8aSWY/ZPlCWKZNZL8OI8T5pqO/nwZJIQPDIub5LZNJuJjNi?=
 =?us-ascii?Q?oXJ+o5/QjsyDxLAFgu1HiVjDhH3694nYcvaILTOHTcJw3aScIMMIght8QNSJ?=
 =?us-ascii?Q?5GaBpmZwmtxjXgjqgdFxXB/7TNDMYS9p3cp4wWnzbKZFzD4bLcOGU4XdlX/W?=
 =?us-ascii?Q?1iw0p7BgvEcjWkxbDAMBDlUta0lVTQ19u20D8J9E320nZSL8eMM885Ar6dCd?=
 =?us-ascii?Q?u/xqewuWK74pYMQzn6ItRfDv2KlvJQc3WDSAJHTQensmNYI+8MXOMGorLqz2?=
 =?us-ascii?Q?NbdQsBexUBA4errW7B/JCsoIBj+cfdph9xlzPibIflQY/EgCk/f8MRyGIFIX?=
 =?us-ascii?Q?SLEVSHw5hipXrG6LCoCXDuvZLUwO4MwgyMsGqBfUtxXK0w/GcW7KNaqVkuO0?=
 =?us-ascii?Q?GCmeJGn2pqaPQ9X00eEY0cY1thrYroxJlGYdgXLUvqEctjqjqxIKBu2LXTho?=
 =?us-ascii?Q?Zofy1qGyXYeXiDtVxbFIGKwZ+lzcArWy1y1jA0SjE3Xxa787aL0QhcEFY06s?=
 =?us-ascii?Q?I3i4jcj+5X9PM7vVWbChOimlGFqM3qmT8dNWx3Vd76fWwKXu+dWGgY3/j0/2?=
 =?us-ascii?Q?iyqb9Q8myS5u5feJ+NO50JLkARBzRv3P13EdIZcfaHLUrnvcWuxHDJ5lAqsI?=
 =?us-ascii?Q?jBI6xy87ksY0XyIB4ZI/J4gF4ZGdxHxMC2Z6jLuzqT5L7Q6fB7rgrTPhaDcv?=
 =?us-ascii?Q?rMtKmMC1qM9MZKFrnQuwDor3MO07TgKL26xQacHcdVeFSWKPzQw+2uc9JDET?=
 =?us-ascii?Q?ISmNXAXVLsdKNJHDkuY6tb+gb/kyuX8qqXzcmpzx88V8TApPnHqTPHwvvfEQ?=
 =?us-ascii?Q?UGdMFOvzY5UoE447ooL+oVSj94UYOtlailZ2NJW2ajYRh9LIRcAyMu4RIrO6?=
 =?us-ascii?Q?5z/ncO5ujeNINI0204SqTPDy9dC5x9GQzVvef4ZVIYF91qZYPcXEiAQl2pi7?=
 =?us-ascii?Q?2+BYJ0f2AXhVskq/ZR+N7GxKbX6SiLpIzOGLFKDoTpa/IU4e90j5rPXyJxI3?=
 =?us-ascii?Q?gTnEezgF4xMLKD6YqrAQUdIN94ACEWE3bZyQzshT72hU+Cgyu5ULaJlRxX7M?=
 =?us-ascii?Q?6a+f30+R1zjRp0c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:43:38.4517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6327d8-8e29-43ea-7ba6-08dd528e8294
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9035
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

[WHAT & HOW]
Fix the incorrect value of the cursor_buffer_size.

Signed-off-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
index 3664980d1574..1020799a72ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
@@ -44,7 +44,7 @@ struct dml2_core_ip_params core_dcn4_ip_caps_base = {
 	.dppclk_delay_scl_lb_only = 16,
 	.dppclk_delay_cnvc_formatter = 28,
 	.dppclk_delay_cnvc_cursor = 6,
-	.cursor_buffer_size = 42,
+	.cursor_buffer_size = 24,
 	.cursor_chunk_size = 2,
 	.dispclk_delay_subtotal = 125,
 	.max_inter_dcn_tile_repeaters = 8,
-- 
2.34.1

