Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFDECCF9EA
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 03:10:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5C4710E6E3;
	Wed, 29 Oct 2025 03:10:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CJiAvngZ";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E152710E6E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 03:10:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwQCCtS/YCwPDZlGFz0A9LPkBkUaaoP9aCq1jx7E/wgiEspwIXuA+ASVE42KD9IQJu/DBv9OYnhjqAaU8qo0dNJPzmwcUssIm1iHSPFtbrQXilQPxQc6HsHkFkKfggpYBcaR3/bmKIta/nEJofz+k3plVqmqk1oD8iD3OB/Czuow+EbgtDLA7dfLTc2wzlb5pIILqOFZ1hfZUfQRiaNSq4F8c+JIHIEBvU4BV3pCoNdOyv3wYXTkr9Zd7OhNwtB3zbk3Ll3svbGNP1D7Y2SVqy1oSUeo+Y8ImT8RhjKvtWWSUgVV5ZoeJ6KSf+AxDhj5CGUbYj+cwNk1+Ha8v+UROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PArNdz/stQ7CLMOhrQBKSn4giyMtF5xLdvTXUd1NPDM=;
 b=aGx3+D+aCAIKyxnCfb3wPup/5Lr385qkfdlcLMdAXFPCCIxW6qMGedGQPkoq+JPuXghoUxuXLEo0NHD3tzWQkV65b0ZWOgMuTVzTz2CitnkIyflI9RPClprRUou5JVyICioVO83PFUfSors0u4fxuiafNYsm2WKu9rfi4G6d/W0BcLsOhf7b7jR2sCCTrp6XqlsIEbzETei1N2NVFvrHFC+d+YjWT/zrCt0deeWgfyntb3Utvcy1HOHAW974YQULrRJ4qNG26oZIWEJFdyVDMc730suyCHF08MhAS+JJUr5VcfpoMbFy3Is4GOraXfaUcQKzj/SpBf1ZaYtMhKUSkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PArNdz/stQ7CLMOhrQBKSn4giyMtF5xLdvTXUd1NPDM=;
 b=CJiAvngZRlhbWZE6BwK1TN4zJi9RYZhN4XUZERXhgVFwRqc1F0h30WrBVDLbGobiYxTqs1NwhxPG5QgM6HXT++3GtPysAM8t4cim9njgMysHY6XnumcNXMvHnR4rcMGOQojhN/fM0VlIBdKyHh7tyLqK9F4Ymnb6wJGGTpNVEUw=
Received: from DM6PR08CA0024.namprd08.prod.outlook.com (2603:10b6:5:80::37) by
 IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 03:10:31 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:5:80:cafe::a1) by DM6PR08CA0024.outlook.office365.com
 (2603:10b6:5:80::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 03:10:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 03:10:30 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 20:10:29 -0700
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Oct 2025 20:10:21 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Andrew Mazour <Andrew.Mazour@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 02/13] drm/amd/display: Extend inbox0 lock to run Replay/PSR
Date: Wed, 29 Oct 2025 11:02:50 +0800
Message-ID: <20251029030935.2785560-3-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029030935.2785560-1-ray.wu@amd.com>
References: <20251029030935.2785560-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|IA1PR12MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: 895d8fa1-8e2d-4a0f-d3c9-08de1698b77a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ve4QdYAFrv8w66MO7gnVo3+33GiLD4SD1QaEirI4rhL5Zhb85z4lJaJJndxv?=
 =?us-ascii?Q?pH/r5YbfUBPaQ/MHozpdmWVI+5kkN75Rz1I7AylMSAb8X3IhV/UYwtcTm0w+?=
 =?us-ascii?Q?BRZBWcCDpIzbmz2tUpEQcMMhUGYlZWG/sHdCnHne84bMr70MBOhRIEkyzVOI?=
 =?us-ascii?Q?B4w0fvo8oPGPwJTIZomUNp42LANW/lFXFArmvAXoRI7tX93V+rSx99OxSxhU?=
 =?us-ascii?Q?bWyH7iqvJLk+ZUSIHUUsdgxzzx035cVNlxZ77QOV8FJ/zsSk4IksWpdaweYZ?=
 =?us-ascii?Q?tGFFbAtSwaMSpUOv2Y2MpmFauFy/eWNk8lb/oItB/Z+Brp/+yPuHAu1woD7u?=
 =?us-ascii?Q?l9tGhWbB7D8kQBkGkNW32BcLfs1xQXQwcCa7BniGaFe7xkM6iRw183PQOkxH?=
 =?us-ascii?Q?Rfi76QC+1S0dGd7Psx5gFJ8cbcCwH1tJJPFl1vygupJoSC7gli4/rMIeT1ao?=
 =?us-ascii?Q?1c94xQFwIWbO9khveaoRe0LaFivJNzk3lIA1cYAs2Y7WXcy8ioSQJJLXmZXA?=
 =?us-ascii?Q?UYTzyebT0s9b0Cjn/r9PHM3Irw0BpL0y+Dj81Q4NnoDXvr15gPoxJLAc6Ig0?=
 =?us-ascii?Q?Q2DDoKP8IyUzlFrk7MLnx9Z6FQ53d5fnt0NbRKvJohgD4TglC6hjVnOMy2cR?=
 =?us-ascii?Q?gQ1Ba1hCJ2LCSdHEahuJIl0jpPHLoIck9pnfUjQvsCE3hTEtcKbiR6CRyf4z?=
 =?us-ascii?Q?iOi3cX3pbPMeVKkKPGG8O1H151OmCwJEQH3KJVprISwh3GOEJGLFkbIET9iq?=
 =?us-ascii?Q?Sjh+PARruSt0ZRQ6deUCmn1/oOtpTf9j1SKW8CtFSH/IS1uNCTGmbiKAYIAr?=
 =?us-ascii?Q?SFERlZgPcy8FbyEZ4jdnTj67qo05TFJA4wXjqQ+Vu4x1eVw8tJYEelFHFV9n?=
 =?us-ascii?Q?wEGjwvsxWTdBTAR+TmVmEPwJSxhQjHJRILc4AxcJjGsvk0lFMTRKxS7MqINJ?=
 =?us-ascii?Q?yMRLSoOYlqecSAckBeG3EAJcnQ/0i6V2JFQhdDUxJlxAJxjsd0r1xt5tXj4e?=
 =?us-ascii?Q?Ywf+nRDrMc8R2XNzmNTBgvWTQCImA9QyRJJsl8KasgUT8Es8zM8KEBcw9XMX?=
 =?us-ascii?Q?3vZ0z7eaW4KpiM+1VmVxJQ1P59aDOkIuDNKjrH1zw5lXBVKYzX3YUstrH7UM?=
 =?us-ascii?Q?gMSzdFDvAdx+SeDckVcvBOQ/mZpO5bKra2uU/VjOmBVio8tQI5Vq3tLoWiao?=
 =?us-ascii?Q?IQO5l+mBgNTQlJM/2sJmd2o9ripuqgx77WAy3nY7tb+6TSwNvGWhbfoxJmUE?=
 =?us-ascii?Q?DiYYrv8RZFcCU4xK15yFomgqaljUxxDPA9yf/r3Q4dyfOOOguZsRZud1WEJO?=
 =?us-ascii?Q?mgUCKZacaor58f6R/sKsciATaetN4DmmnR7BOUq8Iav9UCTjQfWCBTaUQ9kJ?=
 =?us-ascii?Q?7MIiI6NdARbjGM0vHIxdfuuJU/aJU1MaoZXi5LMbhR4YskII0WyMn0rYPZEM?=
 =?us-ascii?Q?1wRiwAodvDu85uMSeuja9ygQEA4+GliXVe302AG6WRHgRpXO1U0mwbyL+G2M?=
 =?us-ascii?Q?Yumpf/36l/5ruqVnpUQWNVFMFxvuWUWMYLxF1YZscsXZ6rXQ19uTO0SXhR1m?=
 =?us-ascii?Q?85c/RXU3+09MwmrQWvQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 03:10:30.1510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 895d8fa1-8e2d-4a0f-d3c9-08de1698b77a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543
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

From: Andrew Mazour <Andrew.Mazour@amd.com>

[Why]
The inbox1 infrastructure is deprecated, so to support display
power features requiring a DMUB interlock moving forward extend
the inbox0 locking conditions to also include Replay or PSR.

[How]
Implemented a series of changes to improve HW lock handling:
- Deprecated should_use_dmub_inbox1_lock() and guarded it with
  DCN401 flag.
- Migrated lock checks into inbox0 helpers and added PSR/Replay
  enablement checks to ensure correct behavior.
- Updated HWSS fast update path to acquire HW lock as needed
  using the new helpers.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Andrew Mazour <Andrew.Mazour@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  5 +-
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c | 52 +++++++++++++------
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.h |  2 +
 3 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index f95cb0cf4b8a..a7ec633b26c0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -38,6 +38,7 @@
 #include "dccg.h"
 #include "abm.h"
 #include "dcn10/dcn10_hubbub.h"
+#include "dce/dmub_hw_lock_mgr.h"
 
 #define NUM_ELEMENTS(a) (sizeof(a) / sizeof((a)[0]))
 #define MAX_NUM_MCACHE 8
@@ -764,7 +765,9 @@ void hwss_build_fast_sequence(struct dc *dc,
 	if (dc->hwss.dmub_hw_control_lock_fast) {
 		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.dc = dc;
 		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.lock = true;
-		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.is_required = dc_state_is_fams2_in_use(dc, context);
+		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.is_required =
+			dc_state_is_fams2_in_use(dc, context) ||
+			dmub_hw_lock_mgr_does_link_require_lock(dc, stream->link);
 		block_sequence[*num_steps].func = DMUB_HW_CONTROL_LOCK_FAST;
 		(*num_steps)++;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
index 39f5fa73c43e..5bfa2b0d2afd 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -61,31 +61,49 @@ void dmub_hw_lock_mgr_inbox0_cmd(struct dc_dmub_srv *dmub_srv,
 	dc_dmub_srv_wait_for_inbox0_ack(dmub_srv);
 }
 
-bool should_use_dmub_inbox1_lock(const struct dc *dc, const struct dc_link *link)
+bool dmub_hw_lock_mgr_does_link_require_lock(const struct dc *dc, const struct dc_link *link)
 {
-	/* ASIC doesn't support DMUB */
-	if (!dc->ctx->dmub_srv)
+	if (!link)
 		return false;
 
-	if (link) {
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
+		return true;
 
-		if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
-			return true;
+	if (link->replay_settings.replay_feature_enabled)
+		return true;
 
-		if (link->replay_settings.replay_feature_enabled)
-			return true;
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_1) {
+		struct dc_link *edp_links[MAX_NUM_EDP];
+		int edp_num;
 
-			/* only use HW lock for PSR1 on single eDP */
-		if (link->psr_settings.psr_version == DC_PSR_VERSION_1) {
-			struct dc_link *edp_links[MAX_NUM_EDP];
-			int edp_num;
+		dc_get_edp_links(dc, edp_links, &edp_num);
+		if (edp_num == 1)
+			return true;
+	}
+	return false;
+}
 
-			dc_get_edp_links(dc, edp_links, &edp_num);
+bool dmub_hw_lock_mgr_does_context_require_lock(const struct dc *dc, const struct dc_state *context)
+{
+	if (!context)
+		return false;
+	for (int i = 0; i < context->stream_count; i++) {
+		const struct dc_link *link = context->streams[i]->link;
 
-			if (edp_num == 1)
-				return true;
-		}
+		if (dmub_hw_lock_mgr_does_link_require_lock(dc, link))
+			return true;
 	}
-
 	return false;
 }
+
+bool should_use_dmub_inbox1_lock(const struct dc *dc, const struct dc_link *link)
+{
+	/* ASIC doesn't support DMUB */
+	if (!dc->ctx->dmub_srv)
+		return false;
+
+	if (dc->ctx->dce_version >= DCN_VERSION_4_01)
+		return false;
+
+	return dmub_hw_lock_mgr_does_link_require_lock(dc, link);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h
index 9f53d2ea5fa5..4c80ca8484ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h
@@ -46,5 +46,7 @@ void dmub_hw_lock_mgr_inbox0_cmd(struct dc_dmub_srv *dmub_srv,
  * Return: true if the inbox1 lock should be used, false otherwise
  */
 bool should_use_dmub_inbox1_lock(const struct dc *dc, const struct dc_link *link);
+bool dmub_hw_lock_mgr_does_link_require_lock(const struct dc *dc, const struct dc_link *link);
+bool dmub_hw_lock_mgr_does_context_require_lock(const struct dc *dc, const struct dc_state *context);
 
 #endif /*_DMUB_HW_LOCK_MGR_H_ */
-- 
2.43.0

