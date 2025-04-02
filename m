Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9960C3601B
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 16:13:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C8F410E834;
	Wed,  2 Apr 2025 16:13:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MeojKq6X";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45AA910E828
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 16:13:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YH1lLhpGMrtVqh1PyGbgnG17IlDi7YDvCkxzgcxb6lmyGvkVlMJ2nWmSg6AC7x5+Y+mFc7Wkzc4OqTdH0nkQ7T2suNPx85D9pdpYnAy2zIFJze5f8OV0qLhXl3N75411pkZdzTbTQofMSFoXGSp3Gx4E8+fyB4r/FyTXNSEIjAyjUS5sgpogA1PqYUZ7Mn0oZqLQsvVnX9hjYBc/mDICyu38G8teawGj/Nwo0iIJpd+5nAGFuQwzd5XGK728If6OiFeA8Jlit7WFUvs5EbZr3pGlq+yFGCyrL/vZ7bK/uR1NEGaQ6+lPr0Cy9yVTvD4cq0NaIP63suu33dcP8nSBYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNePyHOUmYR0lCspkUa5vNadzDbBdjOFfRs4MmhrRJ4=;
 b=pxduRybxngBiAgjzA9A81Jf4x4FEzOY5nrGz99V9aoV4AVzs8426Tj3ybt5paLR48RdHv10gGcCOxwutCRgoQUjTVdNPRQfYuSHtAiTVfIQgErQdSPraTQo6vMwHNYsG7woNOjmysAxfwRNuIasSt4kcv/R8TSjIqQhIt+txpklN3qmOBDccHP4poMgyGnSqp6XMvLCMuhBqDhT/6bEkQX63w8lUcuv/gZhuYmwUDgojlQy2Iv+J/fm5yqiTcCr/5UpTwRRdhs8JPjHviHLq1vHUeF2cF1Ym248Zoq2vO5Xq3dFj1IFUDStQFmPnmib27sO/1pf/y92aGp4EH0ehng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNePyHOUmYR0lCspkUa5vNadzDbBdjOFfRs4MmhrRJ4=;
 b=MeojKq6XQDTnKCZpg/Trd+xtpC2K7qxdtdRR4vUMcoyySKQM0/EqbNuuZkUX/QPvt5xmvG0UkhYd78gICoMuVYiPSFjEHCdWsomFceXTcTHyrtvdGMIkrIZBuFDd191bWQkgoWy0lvXM9JkQiYEc9mOS28fc+0Y2tSTWT4rIh64=
Received: from CH3P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::22)
 by LV3PR12MB9258.namprd12.prod.outlook.com (2603:10b6:408:1bb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Wed, 2 Apr
 2025 16:13:54 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::96) by CH3P221CA0008.outlook.office365.com
 (2603:10b6:610:1e7::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.41 via Frontend Transport; Wed,
 2 Apr 2025 16:13:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 16:13:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 11:13:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 11:13:50 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 2 Apr 2025 11:13:44 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Charlene Liu <Charlene.Liu@amd.com>,
 Charlene Liu <charlene.liu@amd.com>, Aric Cyr <aric.cyr@amd.com>, Jing Zhou
 <Jing.Zhou@amd.com>
Subject: [PATCH 12/16] drm/amd/display: turn off eDP lcdvdd and backlight if
 not required
Date: Wed, 2 Apr 2025 12:13:16 -0400
Message-ID: <20250402161320.983072-13-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250402161320.983072-1-Roman.Li@amd.com>
References: <20250402161320.983072-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|LV3PR12MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: 595247e9-b3da-437a-ac25-08dd72015d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lxi4aG0NhKdStAJtWo6EXQNE4cRGhLFZx/6W2JhF2G0uUuAJ980fAw8IGu3p?=
 =?us-ascii?Q?xZ7ojaZEpic1aZu4OIDegIKxpzWcyJEwMs1Z+hTvqqYVYC+2lnQaerTYril7?=
 =?us-ascii?Q?5lIQgGpG/Sfeyz9r8ON2k4zy0uupzdYJfTd9OaMu81bGJgB9c4heIKBUyVpG?=
 =?us-ascii?Q?0WwRSVVmOmIufzVfKHaJeXbC6KoWAQADOhSss4yvcwFDGuU0ZXkLOBX3OnE7?=
 =?us-ascii?Q?jNySRzMN23MRpgYGLulO7x/QZ0Qm0cq3FNS0jvUASx8Ajp2EcCtSpYeEsOl2?=
 =?us-ascii?Q?0OTAodYpUIm7lYixEIUx6NaPIbjS6Eod2NG5otTaoX7jCVbY1Ie8VmcqNYue?=
 =?us-ascii?Q?Zob4T2OOyKlBLKVt8C6NJEzo4AEbdRn8tDtBQ+an0X9+NkqmAWlWRAms1z4+?=
 =?us-ascii?Q?MD4XpedGvNuoKreVs4z/27KjHGzMMOoKd7FedgpM0F9IHjlcaMFlCqSK2gCh?=
 =?us-ascii?Q?hzc5YXBOS1ENMhXsBzA30KMq2+yfgH2flxOM/U31yJCfw9Yj0q6S2BLU/1qJ?=
 =?us-ascii?Q?vcr9OE43cn6VUTQ6YTAe01CDNA8o/cZ9D1C+fmA1mWKHF7OHXqgEb9dPPy+P?=
 =?us-ascii?Q?PNX0BL0rMVZlKEqWGTJtlfuH/wBmkyj+pGvWZkjlWhRWtdW1/ua7xXTzew3n?=
 =?us-ascii?Q?tiJaM8mbt55nZNzqdhiXb8LUph3iKB6ZBfyTipuNu/khParUi1yqq+x+bIAv?=
 =?us-ascii?Q?jIt+xjPoanM2utCtpY3OpBKstp84A0hyuMM2e/ZwJelbKeMJnQfmr5VttsS9?=
 =?us-ascii?Q?vAG9EwFwW/oHK2SM7w9V+yAtIgSlunqi5WeihzFlPIcDvizHA4+dpf0scfd/?=
 =?us-ascii?Q?8zNmVoTkys9KAe3Ev2LWS64fSLG/dZGCd6LfdUX695p8pbaX7jKm9ciZv6pY?=
 =?us-ascii?Q?JVrgOnohoUeJbI5KIjMpg9A46pk13g/3MDcOO/fpy7Vca6kz3iPq+GzDPZmj?=
 =?us-ascii?Q?Mv9hUhoQvt5R1+v4v3HS5Ggpj28b87gXUhQlTynM1ifuLNHlcVku9FZu5tUj?=
 =?us-ascii?Q?EksRklevBv/k0mTPSHERbXyQnE+2ZiB/fYTAcTo1k8HPMHmEBzppWmlWstd1?=
 =?us-ascii?Q?fJZ2HE10+g/g4XenTFc6GRR1XGzKytGaacKIb5+A+PT45EllbmSXfftxjLeJ?=
 =?us-ascii?Q?lKosxZj2Dk72rLDaeYNLUWT5mEq6u8YhRlVx07AkTkQUTTOc9ECvZYtZnTUg?=
 =?us-ascii?Q?+HZKldrUXWYlG9/e7OWLLfbmqvrsRzGni9rTxBpDd5J2kzO/1SRuI81Z/o1g?=
 =?us-ascii?Q?U82TZ7no8Ag7ZuHSfgrLK3Kn29Ug9KSymdZOepUUGQ+9Kr0onb+gGIeea6x7?=
 =?us-ascii?Q?qiJZ8x7o6MIyTDILQ65D1JFUbcufB7GpSnkVHsMSiARznQZ9skeGm9RZFQt4?=
 =?us-ascii?Q?06D4jcd+19pgmxN7vrOqHEgThzrkY5hj7Fzc1EPa5JtdSI8uazoW+rllICjw?=
 =?us-ascii?Q?cRg3wcYaDHXAbkvfVhBLye/DLQZbYEIaB9xVtOpz3L9AuXL+/Pp6UzGfT70q?=
 =?us-ascii?Q?MlMircMjQ5zyEfu9dzB6U2WjtlC1O+AlZUtF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 16:13:53.7629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 595247e9-b3da-437a-ac25-08dd72015d0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9258
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
A+N configuration, eDP on A-APU is off, extended display active.
Resume from s4, eDP's backlight is still on.

[how]
Turn off inactive eDP backlight and lcdvdd.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Jing Zhou <Jing.Zhou@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c                      | 4 ++--
 .../amd/display/dc/link/protocols/link_edp_panel_control.c    | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 636999fcaebb..66e23507eb82 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6298,10 +6298,10 @@ void dc_query_current_properties(struct dc *dc, struct dc_current_properties *pr
 void dc_set_edp_power(const struct dc *dc, struct dc_link *edp_link,
 				 bool powerOn)
 {
-	if (edp_link->connector_signal != SIGNAL_TYPE_EDP)
+	if (!edp_link || !edp_link->dc || !edp_link->dc->link_srv)
 		return;
 
-	if (edp_link->skip_implict_edp_power_control == false)
+	if (edp_link->connector_signal != SIGNAL_TYPE_EDP)
 		return;
 
 	edp_link->dc->link_srv->edp_set_panel_power(edp_link, powerOn);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index da74c2b5854f..f50c4dbc7553 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -393,6 +393,7 @@ void edp_set_panel_power(struct dc_link *link, bool powerOn)
 
 		// 3. Rx power on
 		dpcd_write_rx_power_ctrl(link, true);
+		DC_LOG_BACKLIGHT("eDP power and backlight: Power on");
 	} else {
 		// 3. Rx power off
 		dpcd_write_rx_power_ctrl(link, false);
@@ -404,6 +405,7 @@ void edp_set_panel_power(struct dc_link *link, bool powerOn)
 		// 1. panel VDD off
 		if (!link->dc->config.edp_no_power_sequencing)
 			link->dc->hwss.edp_power_control(link, false);
+		DC_LOG_BACKLIGHT("eDP power and backlight: Power off");
 	}
 }
 
-- 
2.34.1

