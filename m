Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52A4E74ADD
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 21:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 556D710EB7C;
	Tue,  3 Dec 2024 21:41:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XylazEc1";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50DC210EB7B
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 21:41:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9DKqjDgFIAXvcxNERkUeTLEaPC0xwHlK3fxLwFeSC7bXGxRbDOVLJesyhFi/HnhMiri+abcXGeGyCdGPSzifQ8EnJqPWuY8riNvDlkeuzrxjbLqTzPgKa+KCDwf5UY+IR6+U8FYMbx4c8Cjq7iGE1uRJgKUoZJQpfmFNEeEnDFvDSLERFFqXb32rT/d3tNt7WQDpoj9h0Jm7saiuSEEgAAaYitBcFfmc8Ojk5PHZ/9mkyDA6qIoFJSWgYzzcs0rCN1u/8NllAAaZkFiwtBqT9UjA9GTrahla0lOzRQ8yiNW8CToLQWnn39jSNfrhmDQBdTwUvy3UiBQZcNYWZxfGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OE+cuiJ6ZNDDN8Mrc5t45rJzdlrJxV6HYCuw46doRA4=;
 b=a0ICrt3oqvU76v1iCIwX5QtMeAeQXsRoI2spriTRqIBWfGtaaY3IwIuF+vEbUfH3QoBCcdMhxCrX2FHkUOnUBoT+NBOzpJ/5R5BEhaBa2MKaOTB/65pnVGJ5vMqhlVFvj+NT87pgR8f7TQ7drf529V2RS46g+/n+dk006e0EPF74hfHMDspEkN7XyU3IlWGrTRDMSyAvZiC9yPPaDUcJlhhVA83MWvQKvW2fJNX9qKgFDu91VTlk/jQpO1dXc6IcF98UezeF8j2B08u2CeEB/Jpb7z3oENW1IB3C1lA5HBJQlpwfSoG/fWPSB7DkmnAFZU+cH4cyZShRr5ppZrtASA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE+cuiJ6ZNDDN8Mrc5t45rJzdlrJxV6HYCuw46doRA4=;
 b=XylazEc1NSoU2vF2mCOrGHXFwWgqXGW7d3So1XL+tnYyL7X/E2uxTSVy+6n6PoX+OAyE+Cuiucwb7gHKctyiir3SG2qMwLB/OeU07skmEt+UttQMLdhEKzXyRoi1DAVtKMfWOJiE0PRjYMNWaSd/6sEMCJ73AkVtBI6IPhUlPl8=
Received: from BN9P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::32)
 by PH8PR12MB7231.namprd12.prod.outlook.com (2603:10b6:510:225::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Tue, 3 Dec
 2024 21:41:48 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::cd) by BN9P220CA0027.outlook.office365.com
 (2603:10b6:408:13e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 21:41:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 21:41:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 15:41:46 -0600
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 3 Dec 2024 15:41:45 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Ovidiu Bunea
 <ovidiu.bunea@amd.com>
Subject: [PATCH 14/19] Revert "drm/amd/display: Don't allow IPS2 in D0 for RCG
 Dynamic"
Date: Tue, 3 Dec 2024 16:39:52 -0500
Message-ID: <20241203214120.1161810-15-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
References: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|PH8PR12MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: db6e3295-c65a-4f55-f6a5-08dd13e34a62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M/VqzNumc5SLIcJjGZsQV7I1MlSXZzx3XK/mDWuSuPTXclb4DS4d3wZ2rnsD?=
 =?us-ascii?Q?8hNaVn7HEMQcnYsvTQdAlDy4TpT+XilsENrF48AMJ5oOOeYQqZivt9ZhKLox?=
 =?us-ascii?Q?ufOk4WMdxOIz/VRwMRfmfhdAgbc+q6t3mGWEpW3KdYbHr+r0EN8ypkosWRz5?=
 =?us-ascii?Q?aN8LRcotVv2zkVrnH06NB20Dc8gvfe1xRlGUjCFFR2xHPLcVhtYP/pmlnMrx?=
 =?us-ascii?Q?FBHB0nFzYCuSXAu98Dn/2HWXtFeEXcp8rpmce1HsUTIraqZs0f7qumXUiYFL?=
 =?us-ascii?Q?MJDkpuBaIOXFvL9R5NihLBXmkwqCXeWoSw21mtqTRHbKxonBybujZkqkv4Tz?=
 =?us-ascii?Q?awj1m8tKGmSOV22WToDPtK5TAOw3aE8wazKKha6nWWv72x0CMYsvGTa3Wx49?=
 =?us-ascii?Q?xRzthbieIA9U/2OPL4IK+HvtO946rD34khS6B9o3ulskjbMGMnuZSaEv+NJF?=
 =?us-ascii?Q?bh4WAJNZN2bm6uMzuvJQWO5SrZ1nIDsLoCYTfKT+VN04PX53xIBoTYVF706S?=
 =?us-ascii?Q?GBNGWqw0wNs2RGGTxMEGD5A3Q0qotG/02lDjkWjO9DXCO7jyKC5Jsd931+a1?=
 =?us-ascii?Q?z2t0ooEHU5R18YZC3zzrbfuyfKwHknhoklNPuDAlloPnVwyER4RM5RLCh0Ev?=
 =?us-ascii?Q?eLiE9MPuhEEjxL6l74bXKgJqve4Beu0jMa1NPUIJejnKBrwKzC2sA69bWaU2?=
 =?us-ascii?Q?Ipu7myPBdaG9uQcLHAlDC+u8kY9JU1w2Ci+3Lrf+SjXGm6v/yO31a918oqcC?=
 =?us-ascii?Q?MiDNTLXu5iMeTnrqygHR1r3jyM4psAVInLI2IP7CDTvquPhTera7Wywgr3Du?=
 =?us-ascii?Q?jVuA74n/HIbHdpsF4MLeqaJwrFYZPjaA1TL/YU3NgdZDssWa2XD3EYp9HFPx?=
 =?us-ascii?Q?hK8aJnydsTuySpRfuZzJO0Rpbh5MZEpZ8ftIrK9aPnhUoZTSX8aztBUPu/0V?=
 =?us-ascii?Q?/vqrubon0WUwUQBHSM3p+dJXmD9YchTw3QAwo3zo02vJTcvKRt/zdbjeCq1n?=
 =?us-ascii?Q?kLo7nsBfsmcZHn+rvAXQTHhMdZtNk5cIOp1OXu2/st7MB9oDwxd+66hlaba/?=
 =?us-ascii?Q?rgvk/7VZ6ie1DYiZjTeh7ObZADJ/OB1BRf91atROopQ9VCGqp2+WYe16QOi2?=
 =?us-ascii?Q?8eaFZLUCUuNUfA6s7Ih6en2CcVV0n1igdxGTXKoPnHTacM0CluLusEVkcsga?=
 =?us-ascii?Q?Q0L5VRfkbeCcUI2ane9+HooUCy+KSK66kNnYuOLrJpO+9rTCW3cy/OJk12Hl?=
 =?us-ascii?Q?M9wUuWc4wghGU5SY9t7rDdeguv+zna4BRkPHbAPlwbLGcl4F81vkO29gzTG2?=
 =?us-ascii?Q?qNrdLoH1wXoMyq2hd6Dr2TqZBzucwtMphxLpM5JIRmI2WqTfBupxkgt/wVz9?=
 =?us-ascii?Q?Pv3gvI3OsWA9F3IxJzCLsTO4Fv2xhAy/D78k75UCmQdIbj0AsSxJisWSoPPM?=
 =?us-ascii?Q?84iZxIoi4N90Epw8BSg/BT/6oe05EfvV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 21:41:48.2200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db6e3295-c65a-4f55-f6a5-08dd13e34a62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7231
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

This reverts commit 4ac57a450da3.

In some test environments causes reporting failures for S0i3/S4.

It shouldn't actually block entry provided there's no race with the
last state being updated, but currently suspecting there's an IPS2
check that's no longer being met.

Fixes: 4ac57a450da3("drm/amd/display: Don't allow IPS2 in D0 for RCG Dynamic")
Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 5 +----
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 2c3672c41163..775c58637f46 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1313,8 +1313,7 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 			new_signals.bits.allow_ips2 = 1;
 		} else if (dc->config.disable_ips == DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF) {
 			/* TODO: Move this logic out to hwseq */
-			if (dc_dmub_srv->last_power_state == DC_ACPI_CM_POWER_STATE_D3 &&
-			    count_active_streams(dc) == 0) {
+			if (count_active_streams(dc) == 0) {
 				/* IPS2 - Display off */
 				new_signals.bits.allow_pg = 1;
 				new_signals.bits.allow_ips1 = 1;
@@ -1518,8 +1517,6 @@ void dc_dmub_srv_notify_fw_dc_power_state(struct dc_dmub_srv *dc_dmub_srv,
 	}
 
 	dc_wake_and_execute_dmub_cmd(dc_dmub_srv->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
-
-	dc_dmub_srv->last_power_state = power_state;
 }
 
 bool dc_dmub_srv_should_detect(struct dc_dmub_srv *dc_dmub_srv)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 4763e652c9c7..10b48198b7a6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -56,7 +56,6 @@ struct dc_dmub_srv {
 	union dmub_shared_state_ips_driver_signals driver_signals;
 	bool idle_allowed;
 	bool needs_idle_wake;
-	enum dc_acpi_cm_power_state last_power_state;
 };
 
 void dc_dmub_srv_wait_idle(struct dc_dmub_srv *dc_dmub_srv);
-- 
2.47.1

