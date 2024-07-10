Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C213FC3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:37:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77E8B10E865;
	Wed, 10 Jul 2024 19:37:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m9wZQiSv";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4A4A10E89C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:37:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVQh6VUNS9vnz59uxCBKHP0Av9oQLc0Ca8lN9NGTbV50WFTUjVB2F5ilROpof9L7+F8iVWvt1s7YTF0h9kll895kL8zVtXPHP585WBxsrGCPqxWDzHuACrXPL5BL6M48Ozn56P0anhzJa51JJskgy+yN/cvtXqaxBdjeEGWUnGvF76V/U71jCYrWCrpxb05oSkpqg+TtZlK4ASiwqNKI7PsaN4k8QVrNq/nsVP3bEWqa8PJA+GawRhRuLlKlRLYb+9wAC5N6bWbhZVISLdlhG+UQX31ML6qyQSpeqDF1IrAbja81Be4/Td2yVsvx9aZvp+VqSBLvPME33y1c9tw8OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBnKFbJP1cyFgRdvJz2fs9gCVezibWSOg2Tf3pdMWD4=;
 b=BrL54KtgoLgX/K4XQz/WuP7MRmqn+PEYBYezM2Qlkx4oR8KIpRy5apkPqAw3YujBg4QF5SIuhlLJl0iFNrgESDziXJRU4bBeCCzG15zbKM7uV9qPuX34A2lt1bbKj3Q62V0rIwGhZ6xRI5ksGc9V7zTLemSeQFbDhuWy0WK4wv3Dr45R+6sr2aECTPB2s8cbKnarobymsuVlXD9yVuoOTggW4Mu2b0i/Vgr1KKnORzTJLR4zVxAefF1yTK0GD9P9umi3mr/Xl5c4Y37K//5rylCtAqSH2N2WVxNnyADgwfK8Xp3TyGyE6xy5h/Y1vSRiYESEH9HWX77GLiBjSebyXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBnKFbJP1cyFgRdvJz2fs9gCVezibWSOg2Tf3pdMWD4=;
 b=m9wZQiSv5d/Tcs7e+tsmp1xuR0Ld/sCn/gG5NbnSl4a5eLVQyQtDuWZpW+cFiUbrLLZIKCi04zicNARvhFONtbn83+LuRe9drvOgg6vs6Vusj0uE00hEfq6/LHr6St4SDuVQ1Ozbwp7zexW43eMgpvGBkUsH1kBMAFvuaa+cDOQ=
Received: from MW4PR04CA0305.namprd04.prod.outlook.com (2603:10b6:303:82::10)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.41; Wed, 10 Jul
 2024 19:37:35 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:82:cafe::75) by MW4PR04CA0305.outlook.office365.com
 (2603:10b6:303:82::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 19:37:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:37:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:37:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:37:31 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:37:31 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Michael Strauss <michael.strauss@amd.com>
Subject: [PATCH 06/50] drm/amd/display: Replace assert with error message in
 dp_retrieve_lttpr_cap()
Date: Wed, 10 Jul 2024 15:36:23 -0400
Message-ID: <20240710193707.43754-7-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 5184234b-c924-466e-ac39-08dca117bfaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HnCQwB2moMviQUOnmbHygeUhGWn9uCMrAjFZSOzzFs6fVeVgg9i3TUHUV1gN?=
 =?us-ascii?Q?ksSSUqpp/XQ4Xsq42CSBYGRCZ+7jyccYGh+z9oljr1pETm3+rX2eJe9nHHzv?=
 =?us-ascii?Q?w7k6LOKgk9zJcCjGYqTt/3G6kj3T+U2RsZFycfFN53SrIfzwwQMGfEFFjEPi?=
 =?us-ascii?Q?UoqbAWIlWhwkVqCNK32ICflKmKLFi8Ub6BoO92QxzqylDn82oY07WdWtISiq?=
 =?us-ascii?Q?ajGqS7Ms/I/wJ9pwOU6bnahyWoqIRGS8DrvjWFEyjL6MFH6Zy7LwCkXBmrfv?=
 =?us-ascii?Q?W9mgudkjaG0Q+NhK9jH6KTD5Bazy2I+y7onFAIE4bB+97NChe/2CsXUb5zZx?=
 =?us-ascii?Q?fQK+8aBj7s6iIgnBNKk2ceNSqcgw5iNw+vdnxX2gk7BEjDSP/JYLVS9TPJ13?=
 =?us-ascii?Q?iEqnj+wVyyARuvVlzcQ/VdCXa8Q0jwJvijjNpF9YRi/c5UPq174k4F+sJlA0?=
 =?us-ascii?Q?8Asg3f2Sp2LM85bzyiPu3ygDKMEML2VvEKNN3muGy9dbuNa1oTVgtTIifJ8D?=
 =?us-ascii?Q?zs5Pd7S7DiHDQrnTCzH1Xo++0PPfUteGbDfh+kMtJ7ssjuKnKxzZdNklau04?=
 =?us-ascii?Q?HhlLIo09KAbwz1lWp6AUmE67wipqoD/GxeX47ly3lcUn3fW0zOJ1GkNfrx6g?=
 =?us-ascii?Q?WZo404Q/T15Kb4CeleWDmHN2Ueq/QuOtCGssfXW94oKdzSVQOUwuTi35O/b1?=
 =?us-ascii?Q?iJWdd5UhxQJ8WsGXruOOZ05YSyUOuKp+9aDs3Ws2gUc1mwHMZklVbj+SSxN1?=
 =?us-ascii?Q?zuf8nUwIwiFLeb3yhT2fvbvBPcEeCirRI9tpn90Onn33iavkJG8accX9aSBi?=
 =?us-ascii?Q?pTwGtPzzYdbDb/t9o4lhpwVipIIfG52UjANcpv8xij5kwyP1uPu6/1Tu6SK5?=
 =?us-ascii?Q?mC8ArU0HarPxZEa+IO2kK0yJ337kdZ3DfvyMuhDU8FXNTMWuufLciVU0U8AA?=
 =?us-ascii?Q?eLiYeZvGkWlfzrGK9bWZrOayFVDscRQyZNMzoMXORFIEN8Ots7Y63MPSbf66?=
 =?us-ascii?Q?3QxIN0vxVpkTdNXt/syDgoX/SG+oSso37gKujJ9VDXYA4ehW9vusLLEtYYFY?=
 =?us-ascii?Q?HGx/tQCRa6vU0mfMrC1rAWpbTFlWr/WmE+GRqTHWowKta8n+6bVexrHUu8qV?=
 =?us-ascii?Q?vuq1y9fgac+p4w4ZYT6xFzAPBZxdKo/HFGsIA/305zsGvPauC1xq7v8xifiI?=
 =?us-ascii?Q?nYvQOMBCjXWh/YPkvluyzKr1jutTXV4p9kOawi+PdLirrvnazgeWv+DkdeNq?=
 =?us-ascii?Q?WvRC24gqeIniz2bDEryz8bq2bXPBrdmS+wA4pZsHTWqiSotrMVblVIe6Neiq?=
 =?us-ascii?Q?y7mRLzIYWvUMU9ARSA95RSSYUWXWyWD6DNtzNvdiCO7XP+42kP9Y3+mXOcrm?=
 =?us-ascii?Q?MTmgrryefAvrtLlOGrYQpWsgONfvmW//9sn1D8axCboJUzfb2k1A7BBYmoLE?=
 =?us-ascii?Q?Kj1517qnIEHUWy5WzS+buCVByaNecfw0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:37:34.8767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5184234b-c924-466e-ac39-08dca117bfaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
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

From: Roman Li <roman.li@amd.com>

[Why]
When assert in dp_retrieve_lttpr_cap() is hit, dmesg has traces like:

 RIP: 0010:dp_retrieve_lttpr_cap+0xcc/0x1a0 [amdgpu]
 Call Trace:
 <TASK>
  dp_retrieve_lttpr_cap+0xcc/0x1a0 [amdgpu]
  report_bug+0x1e8/0x240
  handle_bug+0x46/0x80
  link_detect+0x35/0x580 [amdgpu]

It happens when LTTPRs fail to increment dpcd repeater count.
We have a recovery action in place for such cases.
Assert is misleading, an indicative error in dmesg is more useful.

[How]
Remove ASSERT and use DC_LOG_ERROR instead.

Reviewed-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../drm/amd/display/dc/link/protocols/link_dp_capability.c  | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 46bb7a855bc2..c257e733044a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1541,7 +1541,11 @@ enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link)
 	 * Override count to 1 if we receive a known bad count (0 or an invalid value) */
 	if ((link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
 			(dp_parse_lttpr_repeater_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) == 0)) {
-		ASSERT(0);
+		/* If you see this message consistently, either the host platform has FIXED_VS flag
+		 * incorrectly configured or the sink device is returning an invalid count.
+		 */
+		DC_LOG_ERROR("lttpr_caps phy_repeater_cnt is 0x%x, forcing it to 0x80.",
+			     link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
 		link->dpcd_caps.lttpr_caps.phy_repeater_cnt = 0x80;
 		DC_LOG_DC("lttpr_caps forced phy_repeater_cnt = %d\n", link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
 	}
-- 
2.34.1

