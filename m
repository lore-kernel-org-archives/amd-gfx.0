Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AA3C87FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 19:00:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B72F10E6C9;
	Wed, 30 Jul 2025 19:00:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="of/cCKAg";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D7B110E6CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 19:00:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rq9jbf7vz5GBMnKOYV+M3vPkOfcoDCKlQbpsZzAQgS7iTiFTmuWV/98s/K+Wt0m7N0X+cJp20jN20vx/abxRIfVjeZiZF0/FbovRMDQkIbLW3VatScoGU+r3PY2ZqNjJjs0pHXwltu6YStt25gqFiyoHIGgGVMwhHoJcIfbDWgKa1vddORhq4KTR0GKwmRJ5tNr43LVHQUcMgewhgQauyiBX1P1m7lloDkv+SeIJec3MW87E5wc6WrjurXmX1MNA7S6y30x7zPKafgm5xtU6dtWpsclvd3ZlXvrjfZ1EzeiPqynJHHAIlL2syqpS2Yb7qsX/HzT+gfDqrUre8GvyCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8zwv9cPtjFwlPjyzzrcO/+wSwpvx5CS5UtI3StCVtM=;
 b=Ney1mcOdH40ZwxyTZTDd8bEqVF6dWFRZO7G3DZ1IknvXlqtzCLtIM9b6rBGBdjk+gJAfisidnHTPxulT0+0npI4Y3ILHB7cGb57Cdm6ez8pbtEwoYpfavKm8zW4jEJ41XX2hEUxB0vyXYXXFYZD6h6cXlpvP2oQGL2ENMo7iAnIVU0mTM4qag50yCwz3jyzFG/JYkI/eW4o0z++NV0R31CzkfJS7CG/GavUfi/8Pct7Gv5ZsOUpEuhSHSi/rkchh7EyG4eibD+JY3AZGfYNAvqzlWexsl/D9245XUg5JJNk8Pvp7sgQ4rbKperXKmhySsTC8F+E3nTopbGShCpJgwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8zwv9cPtjFwlPjyzzrcO/+wSwpvx5CS5UtI3StCVtM=;
 b=of/cCKAgsFfuKQDpK1SsbhyKctXhpgUWkcyj+E6LryE5/vMR1MyQg39xawaKWLIwgskA7h+nPz7VE8pasyd/TIfQPyo6z2+vrEkvlThiIAWmpKbOBDUsD6IFzhZVHJxTpgJbO9M32sYm3ruzFh9EmqInp7w1T05rfAkSLBfg54Q=
Received: from BN9PR03CA0533.namprd03.prod.outlook.com (2603:10b6:408:131::28)
 by MN2PR12MB4439.namprd12.prod.outlook.com (2603:10b6:208:262::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Wed, 30 Jul
 2025 19:00:50 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::65) by BN9PR03CA0533.outlook.office365.com
 (2603:10b6:408:131::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.12 via Frontend Transport; Wed,
 30 Jul 2025 19:00:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 19:00:50 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 14:00:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 14:00:48 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Jul 2025 14:00:43 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, "Ray
 Wu" <ray.wu@amd.com>
Subject: [PATCH 04/12] drm/amd/display: more liberal vmin/vmax update for
 freesync
Date: Wed, 30 Jul 2025 14:58:55 -0400
Message-ID: <20250730185903.1023256-5-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730185903.1023256-1-Roman.Li@amd.com>
References: <20250730185903.1023256-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|MN2PR12MB4439:EE_
X-MS-Office365-Filtering-Correlation-Id: de474ad3-4ad1-44b6-3aea-08ddcf9b665b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YxqA+hIwBB0v5QRyYTetCHPjpHc+pSg3fN5+T0JWkuHEwuYSUAKPCtba7RPd?=
 =?us-ascii?Q?NGVm1Z/B7kjOYX9oh1aIO7BgCWVte+gp8bvfQOmUeBDk0cBszf1aaxaq/AxG?=
 =?us-ascii?Q?+CFQpTNJLtaqQcATy6a5bCEsOOWDgKeUYPk7z6LLe3v7PJC4QDlI8catff/+?=
 =?us-ascii?Q?qdkJZFnMaxh+RK1wBTTSjc+678+TXjcayHjuVs5+ECJqEbXBZ33T9Y8cG3W6?=
 =?us-ascii?Q?rIyt6Y714ybOGsGY0M5PoHh7iELbXhWV+3SjMcNLj+OYkJmJVCSAFQtZdVuw?=
 =?us-ascii?Q?oyRo9qJ1QTNIEKkq40ttNm+5GpYoyipgwAcRf0kgdo2Yk+XtuiXhyvm7JSy8?=
 =?us-ascii?Q?NAW1s0mEyCnmZhXaWDXti+V1F2FobyhYv0ZpwkXx3cJuN5NXLt6m1Tjywv8X?=
 =?us-ascii?Q?UvFTOU140brw9PGcj451oRO5QJHzsV0QOUPicv50oFsSfgP5jentJYFoWdx8?=
 =?us-ascii?Q?WpKzsil3z1DqI1e5B+Vn7TP+EtIbMVkFanwNVxRi5pLKKT2ewZ+FcYglm+dx?=
 =?us-ascii?Q?yBhfUMnkHvpFnY+fjZeEQA6u4BjsrfV6chrzpAdfxB1OnRl6Np66p/Iq77cx?=
 =?us-ascii?Q?ObzgRJhZ87mYWAkmxwz0PHPvqrP/iJqAGCFnpL5v0RqYyyeCSUpJ0A4miJIv?=
 =?us-ascii?Q?h5oOSPza2mWAKOpp4Iyr7p2JluJ5I5cLeGfbDdBiksrdz+Prv5zqXYdoD2SJ?=
 =?us-ascii?Q?7RtYW+bvEJ9RYNMPVsT7+w4SZGfHXRtdgyvQ2rDtasJei64MkrJtRZ7hf5Hh?=
 =?us-ascii?Q?pqYkqkDcNSQqqGoAlS6nVsvCxhCllHlcM2AERFnXm0EMofhxq7Iw236/75CZ?=
 =?us-ascii?Q?qOzH5MzAPLULei+lOso1FOWHdPo0z+kv0yHahanEw7W/Di1tJjnK5j79pGGv?=
 =?us-ascii?Q?pA+gEBpVUbpEGkCqQ5Is+WwqfyuT3L+R/vP7L2UJlvOGZIgZgMT0ouGO/DEl?=
 =?us-ascii?Q?ybiCU76ckBOTUBmzSQdS9MblVnsPcezfa3HkkWjXBAwM6/pLZdPaXZZlMX/o?=
 =?us-ascii?Q?6qkGbz4z04TLbocpBlpG6cqA/EIRtgHCl2A49O8giwAuVEEaCfZSJ1eYpcHv?=
 =?us-ascii?Q?enZfMXqjG2zWbvrAQ1+CeldYUSIDb6ZwL9hxj7E7cR8ZDHpJJqOKrxCps26p?=
 =?us-ascii?Q?GUpmwgHoYy+BHJuE/oftxTdHJ5PqUqnvUxO+tNQ1WF8KMBvBUHktBAFNxAm8?=
 =?us-ascii?Q?k+awK7CHsTFGQvoQ9/gvGn32GjgTG/rO6Lhxom7iWALGVQZpXW77/kk/JEAD?=
 =?us-ascii?Q?kQnyU2Tr/EPcatebJ7B0HQ2Zj2ygMrGMCanrD9udrL+TiSBk2H3BTL8+Zwja?=
 =?us-ascii?Q?bg7+tPRVZr6i3fnA51HlyqpfSmdPYK42BVInJUbGYdCPA4pMOC7J3fetnvWp?=
 =?us-ascii?Q?rwmr9RvFooY6cRI1M8D8OMy3iEeCj8k7GXaWmfsBsg4M5eriJN83104lJ0Gr?=
 =?us-ascii?Q?8WrbJzCUrCArdKB6PRMTxXlSHBhFuCEjnzZySZVjiq5NaKp4Bt2iZA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:00:50.0179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de474ad3-4ad1-44b6-3aea-08ddcf9b665b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4439
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why]
FAMS2 expects vmin/vmax to be updated in the case when freesync is
off, but supported. But we only update it when freesync is enabled.

[How]
Change the vsync handler such that dc_stream_adjust_vmin_vmax() its called
irrespective of whether freesync is enabled. If freesync is supported,
then there is no harm in updating vmin/vmax registers.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3546

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Reviewed-by: ChiaHsuan Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 28 +++++++++++++------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6762fc7de769..16347ca2396a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -612,6 +612,11 @@ static void dm_vupdate_high_irq(void *interrupt_params)
 		 * if a pageflip happened inside front-porch.
 		 */
 		if (vrr_active) {
+			bool replay_en = acrtc->dm_irq_params.stream->link->replay_settings.replay_feature_enabled;
+			bool psr_en = acrtc->dm_irq_params.stream->link->psr_settings.psr_feature_enabled;
+			bool fs_active_var_en = acrtc->dm_irq_params.freesync_config.state
+				== VRR_STATE_ACTIVE_VARIABLE;
+
 			amdgpu_dm_crtc_handle_vblank(acrtc);
 
 			/* BTR processing for pre-DCE12 ASICs */
@@ -623,9 +628,11 @@ static void dm_vupdate_high_irq(void *interrupt_params)
 				    acrtc->dm_irq_params.stream,
 				    &acrtc->dm_irq_params.vrr_params);
 
-				schedule_dc_vmin_vmax(adev,
-					acrtc->dm_irq_params.stream,
-					&acrtc->dm_irq_params.vrr_params.adjust);
+				if (fs_active_var_en || (!fs_active_var_en && !replay_en && !psr_en)) {
+					schedule_dc_vmin_vmax(adev,
+						acrtc->dm_irq_params.stream,
+						&acrtc->dm_irq_params.vrr_params.adjust);
+				}
 				spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 			}
 		}
@@ -708,15 +715,20 @@ static void dm_crtc_high_irq(void *interrupt_params)
 	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
 
 	if (acrtc->dm_irq_params.stream &&
-	    acrtc->dm_irq_params.vrr_params.supported &&
-	    acrtc->dm_irq_params.freesync_config.state ==
-		    VRR_STATE_ACTIVE_VARIABLE) {
+		acrtc->dm_irq_params.vrr_params.supported) {
+		bool replay_en = acrtc->dm_irq_params.stream->link->replay_settings.replay_feature_enabled;
+		bool psr_en = acrtc->dm_irq_params.stream->link->psr_settings.psr_feature_enabled;
+		bool fs_active_var_en = acrtc->dm_irq_params.freesync_config.state == VRR_STATE_ACTIVE_VARIABLE;
+
 		mod_freesync_handle_v_update(adev->dm.freesync_module,
 					     acrtc->dm_irq_params.stream,
 					     &acrtc->dm_irq_params.vrr_params);
 
-		schedule_dc_vmin_vmax(adev, acrtc->dm_irq_params.stream,
-				&acrtc->dm_irq_params.vrr_params.adjust);
+		/* update vmin_vmax only if freesync is enabled, or only if PSR and REPLAY are disabled */
+		if (fs_active_var_en || (!fs_active_var_en && !replay_en && !psr_en)) {
+			schedule_dc_vmin_vmax(adev, acrtc->dm_irq_params.stream,
+					&acrtc->dm_irq_params.vrr_params.adjust);
+		}
 	}
 
 	/*
-- 
2.34.1

