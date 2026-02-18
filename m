Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C203BE9A02C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 16:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54B2910E5F8;
	Wed, 18 Feb 2026 16:51:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dL7ZyXUH";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013034.outbound.protection.outlook.com
 [40.93.196.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBAE610E5F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 16:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAbb76NfvanhmxV59gYx1EgmWSOFmrFnMO8qGtJ7isAmxxF62DgYbg7rDK5WB+nxBn935VWF5arOj/EW2JejvWk0fr4mKGsOhmFgC/jckJs/1drwfRuRsFXshLEpWkWb5teMkf5AsMm+BC0WPAr49EFs9idCgEB2JGxVaajkSX+g3TmsnOP9Y1H3N3w9PyLXwJcfTnHtWf/j1BuEm6hdakaMqbIv2BDzNTpILGqFHWzmhUbttsx9VmHf7rvaqfZdtFUHnn0LablUNzAGa3vlJRG79sKISYLcsJz6EldzFHNY4WmUIPLatwogPNa3SPET16NMQEpwe764Toe7ZyNfmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7N21oNk+4UYEx0h9mreO90oQ/0WbBlOou+OSV89kNM=;
 b=wZcDOTUgwraUHllLJ9mh8aS06I4NG9OxG/VtuJVZhsgSjQ1GseMKC4Nz8WuMWPwsI7Bqgy1PwPnIv2p1JcURBDc/4l6F0AXrYkI00U1NmIC45Kg1kJ681L4xs8QoTucxmkChPhbrW0+wgp+ZDed7ktNLVVTopxHCj4KPcav6T+UdKVrlkgw3mZSrBE3AHkm+zsSV7JBrYKMz/w1xgCex85SCgcOo8sE6qcE7Jdbi8egRgLpcAWD5JbG7O29jW3pnPxIpyzTmom1uTJ7Xaw9kQwAwdqCs3oIM4iNOvJItXK2B323aVs1FR/j17lVlglBSQOp7Ycxijd02gE9+exsN0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7N21oNk+4UYEx0h9mreO90oQ/0WbBlOou+OSV89kNM=;
 b=dL7ZyXUHkaBuN12SNFHpIq2CUlCbFofxj0pt+agVcxedKUM1kipunP0eilNlHcpULdXQBU9l8ykdVmp7kJub5OLyDyFan2i34AkPZ84NkHdlmc7LJsFGnLOMrAr6AqTlB4eDWsFU2AthGBBbhBSccHqBHrQ7qn7TibkM2mP21zE=
Received: from BLAPR03CA0102.namprd03.prod.outlook.com (2603:10b6:208:32a::17)
 by BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 16:51:24 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::e4) by BLAPR03CA0102.outlook.office365.com
 (2603:10b6:208:32a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 16:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 16:51:22 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 10:51:22 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 10:51:21 -0600
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 10:51:21 -0600
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 1/9] drm/amd/display: Exit IPS w/ DC helper for all
 dc_set_power_state cases
Date: Wed, 18 Feb 2026 11:48:02 -0500
Message-ID: <20260218165116.155001-2-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218165116.155001-1-IVAN.LIPSKI@amd.com>
References: <20260218165116.155001-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: a2305d36-a91b-4ef3-770c-08de6f0df274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2drdt0g6AHyaeqd3vm+oXFNC5VCTChcYqdyaaC74WYxgPncQkzZr0PKjRJ0F?=
 =?us-ascii?Q?Yg2twpnQzmCp5Ady73Gek/58a/Sma9N9QzUpLqMJ6RCEhxphZ5xsM03Cgb7e?=
 =?us-ascii?Q?Mny3Uu6THmixToi0zcrBxf56ggi/xX/4ziYonbkKkkLGVsehPO9PDXR/FwWJ?=
 =?us-ascii?Q?6jZqarnsbzM5ByySSloFuE973OKDQM3P/Rg1TcVrSjEKo718LIQpGl4U0+YY?=
 =?us-ascii?Q?AKg/M8v9pZWpbTGHokunaNdX1a7TAUlmTbNAk5/zjYT/SL2NIkKPYYsGAaex?=
 =?us-ascii?Q?yLxWPsBihLiwE8ZMj2B3o2gaMvckpBjHFsbCGnHAxFnNAP9wbcUEmY214A5O?=
 =?us-ascii?Q?qW+jjvw3W2CZKR43hki8VAdoJFFbM1fs15W/Rl1wb9bru52pbKgLsJKIoZ4p?=
 =?us-ascii?Q?mXEqOjzqz7wJzi4oFYnIYua1oD7/8K5tClJnPfuECpXGSq2IyTF7Nz4QAddz?=
 =?us-ascii?Q?FLiZodCs6mmS9XOYgnu6FCQ2/XC3y0ik1Ue+Uxx8xH5SPVkkXD1pTno2hnie?=
 =?us-ascii?Q?65u3wXNlKIfFuiN7xk/907jquMe12aV1K6oLgZZq0fnrXIJUn0WDT/wuMDK0?=
 =?us-ascii?Q?xXKGJ6zCzHjcy7XxHdR9eF0kEkxDMDTANo0+4VFasMLOOZkVYOwiHZoXSoDg?=
 =?us-ascii?Q?HsoS45kqm1O5TOazU20c9sm+9pMeRaXIfHgfGVYBwUpCQ9ppjJayTpZzLiy5?=
 =?us-ascii?Q?Tp9pCM+WLPH4VO3fowPAQPBz6u8RXEI8t3iQyLeZvZnwZUFTffMwcMugw2Xt?=
 =?us-ascii?Q?doaArGhHW7OQUClZw90p68eN3qsBeVBrRseiiqMi7OkgddaTJ8Y2fCppPELh?=
 =?us-ascii?Q?YVP10DlYHnYuUxYPsH8bkQjRAZKtcO2NqF2TDeCWDKdCchATS03UgV6b+bF8?=
 =?us-ascii?Q?C3Og7GlsXPLS5N6A9BOh7LozzWP1D4kmyKWAOAdIi0Y4Vd8Vnocw4/3Eg80/?=
 =?us-ascii?Q?f+ztZw/qo5cQFSdz1EfF37yENCnTvbbqLOR91nZ7VUyufaKISOEmFliPrE/P?=
 =?us-ascii?Q?EQwkHlm7frkIE5d9Fg0PrSYtmpjK4mgY8jGkKvgs5cem0UYiMWQ2g9Z4c3OW?=
 =?us-ascii?Q?RqBQAj7LDGl2ARDyeT0ShMNz43884qqOvHZqXeHKww+xIbe6dpe++Fz7ACdR?=
 =?us-ascii?Q?djHR+kRAtQkwAa3ahPxPvJ2kydlwBk7VYO7uV2CFtZFNZlD2U8fVzk7Ocng4?=
 =?us-ascii?Q?oii21WaNMx9f/Aqf0H3fhnbmNichejcBi97JBdZ4o61WzUWmqOcxmZQtZWJ1?=
 =?us-ascii?Q?2w0/V9kiBBmaT2XxZviBgaBf5Qsti/GipeC6rx7gTjNU0x18YfhV19vHb1X2?=
 =?us-ascii?Q?RvzxBINhyzGapdjGq4me6JEh08yOljX6NPzjV11lZ2h/++SJ+WlArWHFBuX3?=
 =?us-ascii?Q?i0fk5BFRFMZGoPR46vjZFj3uQ9hMXa9fr9Fg8wagOqUZJgWxxifSANSaQ2O6?=
 =?us-ascii?Q?BHSwwtI3hizItYWy8lnKi+OSZc+Nw8ZofnIPWt5GKYBYIsl7uhVlsYByxpcS?=
 =?us-ascii?Q?An8si5doBYO7azGxeO3s+DPC4yFH0deZL5VxFdutPYOjqa6Mt3fJZ8y0yeLL?=
 =?us-ascii?Q?7PsFodYuHSVWsR+Q4KGlM74lqrBzxyKTAVLm9+vH5RptFXlvXtw6CrxaplNM?=
 =?us-ascii?Q?Bjb3BEoG+WV1ivQK6zcydhTZmbkGqvetfOCjkA2D8J3l?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eVpAtE4PC8HYuWXMUNG6xsrSr0DOCxpRkFVPSIgrEnrMluf8Rd5wo7PcG3yG5wmZKgNO1h2jy5gghlAKu8BBrPRlkQZMb2Pr65/ZQ8VR4yjVQHpMtd/hDB3/7GGUS9YrrfsU2gRRe0xgdy5v/BTzRkGlloW/Tu7k0BNA4mYquNKaOlLoIu8RHNAl+Oc6otyS5QBsucRzARvSc2atd+MNYOEctYDsN5k4gZCRpw8lqxpUn9M4mxE/4VUGUQQwf356fB8WLZsK6m/2HfnHDtZ4gZUNbV9E3eY9A5ykpV5PeaFtDw/8Vna4ErBo9z0o1wSQxamWN6cRqsyDMvp8dLO5UplL0GDfxlJN8sNx1HAmCjCEOnHqEceq3r8E87p7e1BVsjFPAHR3ycfryl9yBn3Fe21X04P3hy57tL/wO94cym4svEsEyKtt+Vx99CbLzfy/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 16:51:22.5770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2305d36-a91b-4ef3-770c-08de6f0df274
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729
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

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[why & how]
On D3 path during dc_set_power_state, we may be in idle_allowed=true,
at which point we will exit idle via dc_wake_and_execute_dmub_cmd_list
which doesn't update dc->idle_optimizations_allowed to false. This
would cause any future attempts to allow idle optimizations via the DC
helper to get skipped because the value is stale and not reflective of
the actual HW state.

Move dc_exit_ips_for_hw_access() to the top of the function.
Additionally ensure that dc_power_down_on_boot thread holds the DC
lock and only runs if there are 0 streams.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 984b4bc5f53c..6f39b903947e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5541,6 +5541,9 @@ void dc_power_down_on_boot(struct dc *dc)
 {
 	if (dc->ctx->dce_environment != DCE_ENV_VIRTUAL_HW &&
 	    dc->hwss.power_down_on_boot) {
+		if (dc->current_state->stream_count > 0)
+			return;
+
 		if (dc->caps.ips_support)
 			dc_exit_ips_for_hw_access(dc);
 		dc->hwss.power_down_on_boot(dc);
@@ -5552,12 +5555,12 @@ void dc_set_power_state(struct dc *dc, enum dc_acpi_cm_power_state power_state)
 	if (!dc->current_state)
 		return;
 
+	dc_exit_ips_for_hw_access(dc);
+
 	switch (power_state) {
 	case DC_ACPI_CM_POWER_STATE_D0:
 		dc_state_construct(dc, dc->current_state);
 
-		dc_exit_ips_for_hw_access(dc);
-
 		dc_z10_restore(dc);
 
 		dc_dmub_srv_notify_fw_dc_power_state(dc->ctx->dmub_srv, power_state);
-- 
2.43.0

