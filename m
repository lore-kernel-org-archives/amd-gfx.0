Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BADC83F17
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jul 2025 21:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E41210E96A;
	Thu, 10 Jul 2025 21:30:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hhC8OskN";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A69010E969
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jul 2025 21:30:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6FFgn2s7OG5QStFWcmkIFiMZ27TU0QnnxbWEw62OZavRIlHYf9IGQPxwRjqbM8AYpKzqwQM04BKzTFTKm56oWp5F8T2JKtjGHdSHDkVdvHZzxY2ZKeBirLqB5A8XdbeMmdocdr+CyoFyGJor5PDgpGYtcEO7Wdad5/FsFv/FnKQTUaaWphJQjOAzqbJhSYZIxzzQCH+hIDO4FGgXkH05G4WjDWEUzjVcYxer+o0ahAhUumkGal0hNWp4kBtf/6DLBjwgQUeBekVxQqV+a4+vdF7aLxx2UNEkKHr2tliWnPUsnvZm9X4+/SmLjr6rhDTNO3a1Gh/FJNAdQE8p7IjFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUf0y78zHLtsQl74EhF8jDdeMnvLZKDKIncWbwInX20=;
 b=aH/82yXKGLbjkblzDr4VBbdT0vv7N1pl29udnZc9mMniKHORHpKwxTP4oPXViSbZ/9uRFjVdFWafImseypJTsRC7YrGUppJuzXy4RNfK3yjH8/QCalc3i9RY7i1hVtRS12EtTaDYG0MzRZtPwDd07pRAOPKY+gg5PCODrFhVBK2SLbyCPmFLaWQpOovhttgtbsh3Mm8QVP6SS2jyL/blCIiFab9t854RvJzGXw9apuXZLtGwlG5tlisRv8CJ/mcba3Ys+ySyQLVcyBAnNzOeS/kvAnR9CkM/SEXM5z7bfRl9vWp3Ci3Z8dqeNo0/w4picIAKQMqemxpOgmAmdJ/1dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUf0y78zHLtsQl74EhF8jDdeMnvLZKDKIncWbwInX20=;
 b=hhC8OskNp4cT+zNC1BJM7kX4c/XF6+4WmfDeP/d8t9KMRbrruqdIpKB4bbo+Z/coGuld10UL/GX1wEOADiHA17EhP28RBgtEgv/K3J1ijNFROuFt7cKmF5qXgLgFv6NGzVbLcThjBp1c6sPxTUZKxfAakyyk6Q1IrqiXUPcClxM=
Received: from SJ0PR13CA0208.namprd13.prod.outlook.com (2603:10b6:a03:2c3::33)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 21:30:54 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::f0) by SJ0PR13CA0208.outlook.office365.com
 (2603:10b6:a03:2c3::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.9 via Frontend Transport; Thu,
 10 Jul 2025 21:30:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 21:30:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:30:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:30:52 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 16:30:47 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Duncan Ma
 <Duncan.Ma@amd.com>, Duncan Ma <duncan.ma@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>
Subject: [PATCH 07/18] drm/amd/display: Notify display idle on D3
Date: Thu, 10 Jul 2025 17:25:40 -0400
Message-ID: <20250710212941.630259-8-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
References: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|IA1PR12MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ec76bea-38ee-4e25-0b7c-08ddbff90cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9aXInHsdM6cRk0OfkbtFBzae1N1wjS1XrLuxoqQsWUy19T3vmON3f2f2jpTG?=
 =?us-ascii?Q?97XfCzPbRk9Mt+tWxGUKBs5Vy4cqVB5Zy9wo131QMveCcY1I3sSWA1dDXd/b?=
 =?us-ascii?Q?cAI7UyOkarNH9NIJXpKPo0sxRVFnpi9mivV9MrLw/7bS+CCgvfJpqdDgMDyb?=
 =?us-ascii?Q?BKsflSMqUBWPakXJlHYx4LM+TkzW8zI4BunTAMVGmk96yIDKpl/UHhGN31Yd?=
 =?us-ascii?Q?BMFxDXR9IAEtvL2xZodRji9AglxhmtTDytIKjsxDc9HXGLKnRe9KZvrkp+Nm?=
 =?us-ascii?Q?48BydL2yHiNa/gR2P24D890c32ospN1jtu/wZD1T0wh5+dHHdCpsSvXDTJBA?=
 =?us-ascii?Q?sl+K6H+mqWuHU+5i1sPmTPofckox81mTs0+rg8eXyWZevlR8Qdmh0313MbMG?=
 =?us-ascii?Q?Snl9WSFvlsrrcDgI5m5LqASKI0INpEVcveJA0r+smwTc1LLM9TH4PzWiyza4?=
 =?us-ascii?Q?9GGsy+Umt6VUPLeg6BgJcZV7UPpzY4aDaudVe9sMFT8KIi7TmQmW4rToH2ta?=
 =?us-ascii?Q?Kzgv6Bce4hs6gK4pjSdSkrS/1PKmItFZ3c4+g3ZWQlbgG2GjBH/LRZKTzQxb?=
 =?us-ascii?Q?vQJ2gSWlfdwu7GX7X91kxSUvVzMX8fXbWiUNOPXtyuqLFFta3mE7ScXjRaxn?=
 =?us-ascii?Q?NIHpwF48NJVX30eOmw1BW4v59HMpJdyDoTjJ28w3/itZ86CAnJia7Nq+vSlW?=
 =?us-ascii?Q?9eHqmLZfyGnb1Y8tIgM7rjAtV6NTz1muaaHLOzrfzS00xt4cNEcRHwXBpGeL?=
 =?us-ascii?Q?Y58+/RTVL9imxwd0ygu/1h0d/rwK4Xjw8Fn/4fHHy/y2r733VlmUpMgZu5kl?=
 =?us-ascii?Q?bJzv2M2vbKHfDRlWWf3FfTAPBIcYlyGxaNxWfymj3DOM2mYNRMEUhq7lIm7b?=
 =?us-ascii?Q?O3/8XfDSk91MZngWqbmqBJRkdnVChDtqCmXCRdKg8lBtl3KPHAgr7oZDeu5f?=
 =?us-ascii?Q?9eHnxw2Yua8qKbdxdk6pM7JLw8qagzIHgPCDjoW3D/zPMLBI4geqUbvbM9Iz?=
 =?us-ascii?Q?ykdwgIstLOOL0PNlYGfEyPnO3XxGgVsUGx+JmBhmv226OUctZoLcXwZKG6pg?=
 =?us-ascii?Q?VsVFX9Zwp7erobI9B1EAMFe6Zum2SRqPOLuwE9jpDXxf7JVsrjPg0shKxAsR?=
 =?us-ascii?Q?q9ybqCec1aUhVEqHAL4/KZBNjHGQQ2CtfbwT+BG9KJND2mwkKnr/4A9aUlc5?=
 =?us-ascii?Q?+7iwmcKbcoNNxVW9qXZHXa05ZqbIRtmpFLedWPemxWoL/imhv6PUey4712vi?=
 =?us-ascii?Q?ZCWaF+hpCOdoeCK5XA6FNR+zD0zZL+Yc6c5IwoDxkjGQ+Un5+Y4WyQ+0naOZ?=
 =?us-ascii?Q?UPPka/OEMp+BnchxjMY9wgZer81hni0D6GD5149sfQgx0bEO2as+fHlVRqMA?=
 =?us-ascii?Q?MqNcYj+Ns6QTRb0n/NVs5KMHbDnyWDuyBUK2maMDlAB6pvYfFcATDlALeMnu?=
 =?us-ascii?Q?Ak9cDMN7XQgnRrtV4pMxN8IAs5eyDSaH09DkYupGiin1vE1in0kBWLOqAV8q?=
 =?us-ascii?Q?A01s8B8jWTRzFrjw2DHWNvYrVLpEn7kF6bAt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 21:30:53.8765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec76bea-38ee-4e25-0b7c-08ddbff90cdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484
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

From: Duncan Ma <Duncan.Ma@amd.com>

[Why & How]
Display idle notification shall
be sent by driver on D3 entry. Implement
notification to DMUB and PMFW.

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Signed-off-by: Duncan Ma <Duncan.Ma@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 9 +++++++++
 drivers/gpu/drm/amd/display/dc/dc.h      | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index cee45fe7cec9..c31f7f8e409f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5547,6 +5547,15 @@ void dc_set_power_state(struct dc *dc, enum dc_acpi_cm_power_state power_state)
 			dc->hwss.init_sys_ctx(dc->hwseq, dc, &dc->vm_pa_config);
 		}
 		break;
+	case DC_ACPI_CM_POWER_STATE_D3:
+		if (dc->caps.ips_support)
+			dc_dmub_srv_notify_fw_dc_power_state(dc->ctx->dmub_srv, DC_ACPI_CM_POWER_STATE_D3);
+
+		if (dc->caps.ips_v2_support) {
+			if (dc->clk_mgr->funcs->set_low_power_state)
+				dc->clk_mgr->funcs->set_low_power_state(dc->clk_mgr);
+		}
+		break;
 	default:
 		ASSERT(dc->current_state->stream_count == 0);
 		dc_dmub_srv_notify_fw_dc_power_state(dc->ctx->dmub_srv, power_state);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a160671d2a01..aa1b976cf40d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -311,6 +311,7 @@ struct dc_caps {
 	bool dmcub_support;
 	bool zstate_support;
 	bool ips_support;
+	bool ips_v2_support;
 	uint32_t num_of_internal_disp;
 	enum dp_protocol_version max_dp_protocol_version;
 	unsigned int mall_size_per_mem_channel;
-- 
2.43.0

