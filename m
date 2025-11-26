Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7275FD111B7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 23:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EF6E10E73F;
	Wed, 26 Nov 2025 23:06:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kzRiTSX7";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F27F210E73C
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 23:06:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6isZQ8oSKJhVFoQ1IAxtg5BeGnMQ0BRSW6vu5kOhdmepP4hZ5IiMluo0DtO7FTUeYNpPcCfWnAyL5woGkqC20SwYN4eJ5lO0TDir/bTjKwjIS84h0EOPUbwPI65dhUIFJQ6ko0ozcuK3IS8bcxDzfqbLRQ3XFF2+8bNl7F9fwPeF8T7U157rMFoezIDnciUZpn3l2wNaNkgAi4wekai9sVIi1+4WFQ29qC4czE9t4uzJuzt5NuGho+6oWwa8fvHgxfE518i6TipC/m6L63stRLeIwyxDfGj7rt7gFajErLysMyEtRDUYYwkQ0SfCs6tztdZyCD4sFS66Aw66R+pgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSLIHvfUP7jXo2rZ2pO8qUwFINB97/1E9UlIrq53qkM=;
 b=zWfhTKsalwp1Pa5YdTx2C37bV9Jv+T2X/ULBOCF1v/BoKRa7SaES78IyZGRwspvLI1pN8TfolXRbdBdGbNZYy2SCKS5jrXjk8f6OyK2Dfr6q8zBY95bZ3BXi8bZJFEKaoWFOqndBylzkxirVyiX8Z4hPTRROvAnLx3kVN3YirqYW5DEECff7/7JkYWZSIY/E8+cx0zZmeDrLpEUFzVffQxRwxmNfrdamdK51EdMYRT6Il3Fo5C3FfInA2QrKpYbvu0gJ1FNUz+58d4QzLLqD0pvRnLT9k5mMsNfW4gPJfdVVxYCVS7OkNLEsZ9NLq0lsLRxa69gZazb7s+CHluK8Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSLIHvfUP7jXo2rZ2pO8qUwFINB97/1E9UlIrq53qkM=;
 b=kzRiTSX79/9JwNRWVtKRmRtJfG8Yikkv65aQ56T0Y0XbLUqgc8LWjOdso02NamIJeFbtkl3sVp6WQLOHuvUi84w1DGza2e96K/umB8KAVQSFaCE/JQbcAeH1p9LUPIRxrWTt9ZrFBGNCqV/+Q9/QZPKl3YpRUgIyYJ1VSRSbKM0=
Received: from BL6PEPF00013E0D.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:11) by DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Wed, 26 Nov
 2025 23:06:43 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2a01:111:f403:f901::5) by BL6PEPF00013E0D.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 26 Nov 2025 23:06:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 23:06:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 26 Nov
 2025 17:06:39 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Nov
 2025 17:06:38 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 26 Nov 2025 15:06:38 -0800
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, "Sridevi
 Arvindekar" <sridevi.arvindekar@amd.com>
Subject: [PATCH 08/14] drm/amd/display: Guard FAMS2 configuration updates
Date: Wed, 26 Nov 2025 18:06:08 -0500
Message-ID: <20251126230614.13409-9-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126230614.13409-1-Roman.Li@amd.com>
References: <20251126230614.13409-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|DM6PR12MB4075:EE_
X-MS-Office365-Filtering-Correlation-Id: 91f4a7d3-e8e4-403f-e24e-08de2d40772d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7YXyFfk62zh3UKfd9im8KHWuHoofKzV5jB6Wf/RhKUVC3ifi4Cdi3WnhWCTt?=
 =?us-ascii?Q?jKOm0G0/etljKpZeA7q01aBcZptgQXTf3hZEdD+DAY+zZatZB88RhkCjp+Vz?=
 =?us-ascii?Q?HttUy76/PJnOrTz01yJSOi6/eU/z17gTN6ABb6FJN5MStNLhrjgV4pDcIt4o?=
 =?us-ascii?Q?sTuMM5m6INUsvM7vrjjbMDHkcYcpdYLM7LJLnlHEMgIpNHnirtSwtDyccmHC?=
 =?us-ascii?Q?/p6lxFzDuj3+sN5MHIGk+LIVM7A3blbYZtLNBax1MshDaiGT291dIKKz5At7?=
 =?us-ascii?Q?U02PSr3yp5ywImz1dlAC8lSCyaj5qwyWjlXZiRQ0p2kp9U27TCqf7k4vVChH?=
 =?us-ascii?Q?fgG2kqB3AmuhPIE+B1OwX4k9HDaE7KGnQBY8M70QXwpQa8LxdeCUtTfbcvP6?=
 =?us-ascii?Q?XRb79q5eYKIVCL/epu6QnT5TDwLqJZbui/Z/AlGVit31SVZE3w7oIGQrybpe?=
 =?us-ascii?Q?L7Mxy1FvB6YAEx3SSu8/r0sauEXICvVtVFZ2QposYNuh7hLlFFlSwMQGd9gq?=
 =?us-ascii?Q?xktyMeC2bY1RHms0Lcb5ggBiEavlo05Pu6mAZJr5Lo5MqTswba6zU+VG+dGx?=
 =?us-ascii?Q?7iJlgNsakVyXNfDpTnsU8VhjpRgki76mLQejPXnunH4WPlsWyP+BRiM0gtOz?=
 =?us-ascii?Q?Q+11jObBcbb6sPrlNKGrYxjh7cqcZOwfojDZOHVHkOmUXKTWX3PLN1rpkOWK?=
 =?us-ascii?Q?bnsoq/2sNay8e79fhSPMk21RrbJau1JmV7e7p8sVbOqazDkXMCgu+0AgR63L?=
 =?us-ascii?Q?+Q+NiSpIM4oH6J8On/mEy/cxsA5vEnFyIgRxoxHVIzcpROp/LDLfueK2olQ8?=
 =?us-ascii?Q?oAnnS2PnyPKhTLnwCiOol/NoxwzeuBdSiCGhW4pWRY1VobGCtri7FT7vqB9i?=
 =?us-ascii?Q?3gnfmX5dfNkXjSQuGPlk+LjO2T4VfPJi/LNuZZeRsAsjqIOu6mI4/831jKwO?=
 =?us-ascii?Q?Mtm/HgxWmJ/tBZqVnOcC0AI6rE3g7S+H1YWvJSuRBwVd1rrkYkiu3rIJAzBU?=
 =?us-ascii?Q?cG2DxspRZuVQs8m9M/C/egnMak5B+tqpnwCer+VkeN0fozNiqEJ91U0BbGNh?=
 =?us-ascii?Q?VAdZ5aVgOzysT/hv09eqtrS9OkCS4AcN9tVZ874p+C+qU+aY2gNJcn4Jduv7?=
 =?us-ascii?Q?DdICsDxMt+Dd1b8vyRK/FenOialOUJ6Qz01ZZEQ/t3DzvxCiV6w0BNQ2TPDr?=
 =?us-ascii?Q?hlsVR2KmrCZQtnIxbnY/k639ACAWBSVoYT8fSZYi5jrAHP0bhyFFNCEXjnLj?=
 =?us-ascii?Q?+zWf1Osj3byEFJaxwfo6zF6BmA/nR+cPd3KYS87sG6w1osQIQiqNN7QlfwJN?=
 =?us-ascii?Q?1g4Je/NoWFcbpPWmLNuhr3RNs/wgrtQyL1Yoy6aHx+V5c8NjCdmAKY1Udvg9?=
 =?us-ascii?Q?TVzwKuw9XWyGPABwzsAAibNbzFHm2K47jkcX4m1ODnbRDu2I/QUnkFRN6jbP?=
 =?us-ascii?Q?1c4yqd2+nnwDQziVPAmpvLXRfioFcm+SLPu0pORVIMFsHca5AyKzMl3eU7S0?=
 =?us-ascii?Q?m78OgH7GdMUwD2Stw5iPxI/uGS2RIlQe1KJhufHn9Dl0F5ipJS0H4xVmASRb?=
 =?us-ascii?Q?jCmtZw7Ht6jEc+FWovk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 23:06:43.3466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f4a7d3-e8e4-403f-e24e-08de2d40772d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
If DMCUB is not initialized or FAMS2 is not supported, the
interface should not be called.

Reviewed-by: Sridevi Arvindekar <sridevi.arvindekar@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 614d3e95de18..ce50e36a414b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1774,7 +1774,8 @@ void dcn401_unblank_stream(struct pipe_ctx *pipe_ctx,
 void dcn401_hardware_release(struct dc *dc)
 {
 	if (!dc->debug.disable_force_pstate_allow_on_hw_release) {
-		dc_dmub_srv_fams2_update_config(dc, dc->current_state, false);
+		if (dc->ctx->dmub_srv && dc->debug.fams2_config.bits.enable)
+			dc_dmub_srv_fams2_update_config(dc, dc->current_state, false);
 
 		/* If pstate unsupported, or still supported
 		* by firmware, force it supported by dcn
@@ -1794,7 +1795,9 @@ void dcn401_hardware_release(struct dc *dc)
 			dc->clk_mgr->clks.p_state_change_support = false;
 			dc->clk_mgr->funcs->update_clocks(dc->clk_mgr, dc->current_state, true);
 		}
-		dc_dmub_srv_fams2_update_config(dc, dc->current_state, false);
+
+		if (dc->ctx->dmub_srv && dc->debug.fams2_config.bits.enable)
+			dc_dmub_srv_fams2_update_config(dc, dc->current_state, false);
 	}
 }
 
-- 
2.34.1

