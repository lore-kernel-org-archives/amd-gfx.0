Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534F6C3ABD7
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 11:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECDEF10E4FC;
	Tue, 13 May 2025 11:25:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RJTn6yBm";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4ED210E4DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 11:25:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOoIZlns9ezDGtE/opo73hYq4aZa4J5KEW0+jaZOQJWhXC/M27Wku2AzN/FR/jpngiuv7Yz3Z56zYKXCjrlE+qpxr+PaE68IFs0QjQqRrD/Xk4/r418wjnj71VxvkeXRYF460DPzTkaxxEueU/xc6QHytgJCsdF0IkKWxfbblVn418CblFNYQT8KN2RT8gXp56esBUieWfUaYPiyDmd3g0XAQSjg52C9MFgZSta2pMTVvwCp36D/rCXYQoYSrE71CsVGlkCCuPWfahGWcxXKFeQmOsqvJtNMOD1SgcdQZzf23JbXlX63gmvmh+gFrkA8BcjbUrtirkmsogPN97SXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1X9TcxEhNTZldUoDTXduYMXL7xs/IBZki3ywBkHp4PY=;
 b=jXGApmav51ezh90ZH47ECd8Agk/Gm7/MCVUk48mjVzW6FYD/ACDmKXz96VmaJ4BZJoMRuQqfOcSSV/LVLR+4P1vPTKgQdWt2xbS8AWAAKJVSNgcO57HEqnFSiPMdA7HUFG4AakExBeTEFFpYt18o2Tmpc7AnVnEQpEdwzBGwZocSvDwDoczBCntWaxjyps/8ooyiPRjC1bjrNwAK+A9qEMyDYJwA1Gdxpzb2fgY0O60Y2+HF0zNjEGHWse3Xg/inD0kt9+m130Qyz6I/FnGd9ClbRp38LRaQGsTAW601+uwsPQr2SvnGoNVkeq3UzR8XoQNN06awDkBQOwsEon0sVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1X9TcxEhNTZldUoDTXduYMXL7xs/IBZki3ywBkHp4PY=;
 b=RJTn6yBmZX0XHTKQTlAtVyNLSXbroRZ0i4KUGWM8OBGw8i+zvPmGTtXtBAWiBJnluqqKXjTxEgYQCPuvwPglyHoXwHWi+swnM8zTSypdkV5hAUXq3DWFovq1S0o2Ccf5fdvkS313nkFNEVic4eNoS5NzssCDbmHLSj9sQOex/MQ=
Received: from CH5P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::14)
 by IA1PR12MB8360.namprd12.prod.outlook.com (2603:10b6:208:3d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 11:25:19 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::b1) by CH5P222CA0013.outlook.office365.com
 (2603:10b6:610:1ee::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.29 via Frontend Transport; Tue,
 13 May 2025 11:25:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 11:25:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 May
 2025 06:25:18 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 13 May 2025 06:25:15 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 08/11] drm/amd/display: Modify DCN401 DMUB reset & halt
 sequence
Date: Tue, 13 May 2025 19:24:36 +0800
Message-ID: <20250513112439.2295366-9-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513112439.2295366-1-chiahsuan.chung@amd.com>
References: <20250513112439.2295366-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|IA1PR12MB8360:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e2c5d8b-1054-4539-2339-08dd9210d7b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q5TEnaYnfbfuXFClU8VT/kRiVv8VmrwYRNSy1bE5uT5WdgHoltlIbeVhgcxv?=
 =?us-ascii?Q?hc+AulENyyBt+T4K36kctILb94x4p6JWx/AoZ1qm0Q99rgmuAVHWY/PT9IIL?=
 =?us-ascii?Q?PzzclZzVvusr+219xymyTVjTPHsjbnuZOHnpHd/rL1GpMLd7yYuZK3Onoi7s?=
 =?us-ascii?Q?vVLxhsyocGGQ/5eBDwfzrGR+ASjWtgxmcpGe44Q5dc+8tjQeGcmzmM4SLvEP?=
 =?us-ascii?Q?Pixn/Rkkabm6Eie4Mb5wpPcTAKxjvm8lPqRLKqKsPjPiK/LHwZSUGxiK3UvS?=
 =?us-ascii?Q?M0LaqKzUHVBLI0JJOBve8YI14+HyvO6JYsuwvXWwzR3/+dEQCYTNqPvLHlxL?=
 =?us-ascii?Q?Z5eODXYUBFkenT/pBOlwmjHeES5gYMQhhFIOsA+qRATUAP2B86aRhEYcCvnA?=
 =?us-ascii?Q?RmqtqmxKxXFy27dlFy98qUZv9u1RKhD36FmSNmAzaI5B0NcHdoUJ4+XJB0g9?=
 =?us-ascii?Q?eYx2QBOSjImBwtOSadFoPs6xr1TUrbCW62a51x+TmYEm1mZSJRaAZn6Y7a2y?=
 =?us-ascii?Q?5CGzO5V1wao9Ka7KXV6BgIzXz4XKFEw4KAtgP5u4ktFOz3+2rVHItDcFmb/E?=
 =?us-ascii?Q?edmgjmR00kculhSqSUdhOdwEvfKe4RviGCB+eavefK7BW01SNXO56DcR5zgi?=
 =?us-ascii?Q?IWT1WYfv6fhrEDknwmC/yk9yfQnGlv3lAmR5DTw9iQCVT0rEZ0FNfmU1BfqM?=
 =?us-ascii?Q?ZNhD7OuInNAPTuKv1eNd0qEI5t/8Du+QU93YbjogkmWWI48DyuYjPK11/IUp?=
 =?us-ascii?Q?QWoV7K8UcXBjmvVGyimmS6ObkVWC7pFItwOWuL3yQMoJ2qbfjfgdg+Px81gL?=
 =?us-ascii?Q?p/j/C0jp2KKNlP1RWV+J9Wy63tgSrsB22wDA7EfmREs3adGDTAwtFISgE4eo?=
 =?us-ascii?Q?zb1vrILyfqIM5nS+x2wi/grARUDrHurfyydp94jUTgrHZqS8s8zvkDyPdwB9?=
 =?us-ascii?Q?2pl21wxhNBD6zB1L8gcOi/JVQE2QzAiZrrAo26C4SyL2gZMk9lwbQde5WAzq?=
 =?us-ascii?Q?SFCWBDiVJgq+L4Hn+dd7y4Pmt2xDJ0YR2q9hhF8vOsDvpL2cLmSQx/DGY7a6?=
 =?us-ascii?Q?jHlLE5HwIEeDBg1iCb0f33Kp19KO50Mamr7df6IS/w7eHC4s9lBz7NapmhDS?=
 =?us-ascii?Q?/SOxKkVYAH7SgEZp1mW6I2vov1e292gBV33ch6ez/cEB8g5BccUg0kNHM/Nw?=
 =?us-ascii?Q?9gp4/FI67kRTC/mtxbrgdQN16i7o4nH8Msfn7tvCMzfY7yRyetIXWtFe1k1I?=
 =?us-ascii?Q?RSGPzPBWs8MzbYG1sP8JHwQZqVKwK4TMW+nmpbx8Ri7jD9LE/GHMOukzwGUS?=
 =?us-ascii?Q?6CtByKp/nONJUKTjueaavxLyzLYXrmQculqWqzflq+e2TBVWNkefbIj1JCeN?=
 =?us-ascii?Q?x36EyZxoELpRYSCw+9sBK3I8Gp9aqFzrG+ddsq6MDzubnLPgi2xiAsJweJI1?=
 =?us-ascii?Q?FftRp/iOsB6n54gCN5B8l0LIvuTfvDJgenKY6u1OADViGo/eidL+AcfFlejH?=
 =?us-ascii?Q?a/1lODO3SiA5CtsxJvoNXvfwSTq5SHH4v4Nd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 11:25:19.1782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2c5d8b-1054-4539-2339-08dd9210d7b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8360
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
If DMCUB is already disabled or reset, no need to send the halt command
again.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn401.c   | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
index 731ca9b6a6cf..2575dbc448f7 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
@@ -66,24 +66,20 @@ void dmub_dcn401_reset(struct dmub_srv *dmub)
 	const uint32_t timeout_us = 1 * 1000 * 1000; //1s
 	const uint32_t poll_delay_us = 1; //1us
 	uint32_t i = 0;
-	uint32_t in_reset, scratch, pwait_mode;
+	uint32_t enabled, in_reset, scratch, pwait_mode;
 
-	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &in_reset);
+	REG_GET(DMCUB_CNTL,
+			DMCUB_ENABLE, &enabled);
+	REG_GET(DMCUB_CNTL2,
+			DMCUB_SOFT_RESET, &in_reset);
 
-	if (in_reset == 0) {
+	if (enabled && in_reset == 0) {
 		cmd.bits.status = 1;
 		cmd.bits.command_code = DMUB_GPINT__STOP_FW;
 		cmd.bits.param = 0;
 
 		dmub->hw_funcs.set_gpint(dmub, cmd);
 
-		for (i = 0; i < timeout_us; i++) {
-			if (dmub->hw_funcs.is_gpint_acked(dmub, cmd))
-				break;
-
-			udelay(poll_delay_us);
-		}
-
 		for (; i < timeout_us; i++) {
 			scratch = dmub->hw_funcs.get_gpint_response(dmub);
 			if (scratch == DMUB_GPINT__STOP_FW_RESPONSE)
-- 
2.34.1

