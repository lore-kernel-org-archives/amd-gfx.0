Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1609AC07E8E
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:30:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A698112BF9;
	Mon, 22 Apr 2024 15:30:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="txQM0EgS";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33A1E112BFA
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:30:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yl6ch0QPoCqonks/Wz60NrhgSgI2lGj7KgYQRIXHtlHdFXPx4YT/gAEuWhjlRPj/EtUMnv/y8r8XvjD8PlqyoSfCAZsym5AIFE5YqeoBJsk/cgstnqAlBWCDlF61dZlWYM6RosYKl5F3Vx3NIbh+hvSef2330ab+UEEiy/fHAwwZTCFFFoyrxAP/BC1uf5h5s7og9EGyfG1PPxpCDCEN1topSKzeBzV0RGfEQWjVKSx7fCu4AxuPp+s6cQlfdi7Ev2WdkdLjdySe67gO/54po2oJkb+wADuCv1gDH4YEJ5dvu/c0E6Zx0dMcgBte+gvg2g1JzOqEVgFa7uTJDdZBpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNuA0H6SaqnL/aqi0+JXv6WIjcG916udUb7+hJhBdnM=;
 b=MO1bpD3WrmCJYfBju2ygaP6dl8fdImw11B00Swvhw3idgqlt43cThPGvxRJt5DEUv57C1EpBQ6xxtScYPbASV+6sR1eiTGbi6s532dqYfvD9RspBLQNlwvLFTTklNJmUmc37Ka9U/D6GKzlzNVUHScldmUEWv94PkVm/13KmNhwdyT/4BowvvMNjbkK9QLi0KdLd1dH62/7qVSovAfd7FgivvvglatBo7dF1ETTCt4IDBjP0qDi6ReIiz00PYanhzZBQnDl7XGOMjuRPMZQhKlLWILGG1CMevgdJ9ammHZtC/WDi5HcZGNlvKf9OS0gCamwlNgB+VZrNBH+pxC+qpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNuA0H6SaqnL/aqi0+JXv6WIjcG916udUb7+hJhBdnM=;
 b=txQM0EgSYoH4ACfQRexihTl3RSD0gKUkb72Wa0RBx3Gr8Z4Vo99WfUR1vmCY1z1YHi4RzeukZuDFAd6LMjfwMSsSktSFnnJfAQL2ogJqIcW3excea+3gxcvoohIi7A/xr1c4x9PaEWZX0YMvnGrlHqThYF9QFRXWHMtyJGpmYt0=
Received: from CH0PR03CA0067.namprd03.prod.outlook.com (2603:10b6:610:cc::12)
 by DS0PR12MB8320.namprd12.prod.outlook.com (2603:10b6:8:f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:30:25 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::48) by CH0PR03CA0067.outlook.office365.com
 (2603:10b6:610:cc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.31 via Frontend
 Transport; Mon, 22 Apr 2024 15:30:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:30:24 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:30:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 08:30:24 -0700
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:30:18 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, George Shen
 <george.shen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 22/37] drm/amd/display: Skip SST ACT polling when sink_count
 is 0
Date: Mon, 22 Apr 2024 11:27:31 -0400
Message-ID: <20240422152817.2765349-23-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|DS0PR12MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: 521641ea-d8ba-4e35-9c37-08dc62e12176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DRe2b00qlgVGSMWNucOobZHtu543tiQlKwaEIvLyAhQ7arhrbongJZEsH/kG?=
 =?us-ascii?Q?DyP8uFQjPkT9iYrfCdbdhAnVRnGr0R+G2ICJ97kmxuCfsYw73CIKhl7uQiIj?=
 =?us-ascii?Q?jWuKuADQraacF+Wiwr9Qk4PraQUJe8NIO3sPH0I9kKQnvczsdoxxUIRCu+dw?=
 =?us-ascii?Q?qf0nYFRQX5j7Vfs/jHyAeU7HGAszFZlve9y1caXb8kne8wXMTJXIdFOhWd6d?=
 =?us-ascii?Q?TDBr//iaUuKCr1iRMgln6W+9lDrqTye6IlFBpwAFcAHRCSQAhOyR/qVBhX8f?=
 =?us-ascii?Q?R2kKxlZhBJt4+j4051EaDGAl9QhKWq/xpa6dqe5KlYyjtkQiztK/iZSAkmBN?=
 =?us-ascii?Q?oYl/N0AbkRCY/opivgpA5XVGR0MFSU1Dsk6I7G9ykpU2WkfgnxIRcjMQPN/Q?=
 =?us-ascii?Q?w5Qo+7YV2ztbELs3tqjrH2cSbxnV+jYtVtuWknMArmr9LNFiN/v6R84GA6la?=
 =?us-ascii?Q?gIO+uIUMaG6BeNhRG4TOQbGYn8KLZG8UDA/hiDPGpLBKfjMQrICJ8TWZFPfs?=
 =?us-ascii?Q?FEZpWmmxMqtOG4I5deQmBWVVMF+BYD0hllrcr2hPwwzZiJz3RPq+/5Q+S/Qi?=
 =?us-ascii?Q?dq5Hqr5vmv8Tn6PTiBHIiVLWyMF7TSAPk72PniA8+HMQFzv2f3PU6YhN33Xw?=
 =?us-ascii?Q?ysmSwuKrj0vfXQszPpnanC4MCxVAl2eb5y/xgQM7xI+3jPGml/c7o4oWGQFr?=
 =?us-ascii?Q?6l2HCXiK9BID+pxZoXrOBguwR+NYzlwiSpJYKHSw2DoCvEDdTQHDr3rRYk5A?=
 =?us-ascii?Q?ZuA1Gm+FwABtgQPlpo3DmNWxn8e+EYP9qr8nqhXV6mAnx1IN8xzCBIQ1d16S?=
 =?us-ascii?Q?oGC4r0fgLmhidpwDA7ddWlWAyXOZG95C02D9EeALIpYwiS8r4+JYtwYbiVQU?=
 =?us-ascii?Q?nNvx5kmJc5YPauoHSoq6399FXzEvi22YqJhdSFZjfTm4d6iAnaljpRKqKIYT?=
 =?us-ascii?Q?EPiSllzV+7tHwpOcNYcGsR+WGiO4t1HcLjyrascMu3cojt8W53pn0Ajmbrsy?=
 =?us-ascii?Q?+GSdSuu2CjYJPPRHRZ5bC31lxkQ8IzJjAJpKCLvYdaVrT6okIYtzCEcwcukU?=
 =?us-ascii?Q?WiCO7gqGYiQy98g2uPBDN135gbN+3eMgk6YEdjCi+gGIPQFfb6+iuDDrehjO?=
 =?us-ascii?Q?3g6zZGp4WC+IobiZxxrqNVrt4D2Y/us75HB6XRvKPM/QS7XKwQVmWt/QcPiA?=
 =?us-ascii?Q?qyrR7ZOeGhHCcqqDOBG6MeCyQExrEMXzZebGjMc8gfYPtVY+kkmIvY/rn5oc?=
 =?us-ascii?Q?9IZowkMxocNPIkq0NQ712kg3FwODVWVlfhjKdTHLh792GUpkw8EX8iJfOtU5?=
 =?us-ascii?Q?461S0ttz0gb5S8gBR5gNLrLvvJIyLNeojCpiZXEcCAqOVyFwSkuGtRsFQgDe?=
 =?us-ascii?Q?TfYfsEQFi48zHk2E/FqQAz7pVhJH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:30:24.7727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 521641ea-d8ba-4e35-9c37-08dc62e12176
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8320
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

From: George Shen <george.shen@amd.com>

[Why]
Upon disconnecting a UHBR SST display, the disconnection and the
SetTimings to disable the display can occur such that link_set_dpms_off
occurs after the disconnection has already processed
(link->type is dc_connection_none). Thus, the AUX related
operations should be skipped when clearing the payload allocation table.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 938421e02770..087423be3151 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -1158,12 +1158,13 @@ static bool poll_for_allocation_change_trigger(struct dc_link *link)
 	int i;
 	const int act_retries = 30;
 	enum act_return_status result = ACT_FAILED;
+	enum dc_connection_type display_connected = (link->type != dc_connection_none);
 	union payload_table_update_status update_status = {0};
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX];
 	union lane_align_status_updated lane_status_updated;
 	DC_LOGGER_INIT(link->ctx->logger);
 
-	if (link->aux_access_disabled)
+	if (!display_connected || link->aux_access_disabled)
 		return true;
 	for (i = 0; i < act_retries; i++) {
 		get_lane_status(link, link->cur_link_settings.lane_count, dpcd_lane_status, &lane_status_updated);
@@ -1512,6 +1513,7 @@ static bool write_128b_132b_sst_payload_allocation_table(
 	union payload_table_update_status update_status = { 0 };
 	const uint32_t max_retries = 30;
 	uint32_t retries = 0;
+	enum dc_connection_type display_connected = (link->type != dc_connection_none);
 	DC_LOGGER_INIT(link->ctx->logger);
 
 	if (allocate)	{
@@ -1529,7 +1531,7 @@ static bool write_128b_132b_sst_payload_allocation_table(
 	proposed_table->stream_allocations[0].slot_count = req_slot_count;
 	proposed_table->stream_allocations[0].vcp_id = vc_id;
 
-	if (link->aux_access_disabled)
+	if (!display_connected || link->aux_access_disabled)
 		return true;
 
 	/// Write DPCD 2C0 = 1 to start updating
-- 
2.44.0

