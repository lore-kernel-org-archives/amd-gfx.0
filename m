Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39105EA811B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 13:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0D4810E583;
	Tue, 10 Feb 2026 13:55:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OQO79i0J";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010063.outbound.protection.outlook.com [52.101.85.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CD6210E582
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 13:55:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1OOEtmZAgJRInzi3Vcjj7eNO8QtfwTCS8GsJuOn7fX9ImDi3DOwy+Zfjo/AK1srxhx+d7A6wkP6Sd+ZflxmRnoJYN2rXLxALnMzfE8b5qodTRs/L7Y68wrVMrZWX/LU/FasPmWrBDKAjxD5403f1uBEFQ3O30I248kbiyIy+lMPSlpOdJCsvjbEORZBWThI74CsGyS/tjKjU1AbphB/REn96SuLuMD/PdLyyTj8wRoI0Ne38F1RAz3yptrmVWmVa1sxQmpy9MhTYWaafNV4IHWl/AuT2Sb/nkuETcv/upEiz+neOOOKKNBip+9yh38w2zyWixYkZtDsKzOWBTi1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMOknIbkKhnaUGeh9IpJSXds65IEoyAZmLvpdABNvVg=;
 b=NU9Eb+1CEuLzmYBRaNcihtKiR+qLHhjlrrCDZHF6+ffZ3GN7XEi4YZ+U/Z+R+8zRYx32sGGqtEF2AVXyELdTtvLg9hvfYZZRWRI5oNmiXqrmYHSvz8AQqscOxs15ZqnslsU5B6u1ET5w9+SSD/KEqEaMmKmzjmaA2D+3tHSZf93+0jfme4Jfi5Jn7Hl80sPO3Es6OaLTid9OJ+VNQlDtMsaQH0zruN/aFFYM4RavFUNgyLuomBo8AX7xVZphYHwej9DfnqQaBTGTFSFkfiHKmYeaDoEeJqTlz+Urm952qv4qGvEsPMWLlWxnncRJEfIESbUwDyOd/j4HnuMHrIni2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMOknIbkKhnaUGeh9IpJSXds65IEoyAZmLvpdABNvVg=;
 b=OQO79i0JFCG1DVdUrpLpZT/7rStE/fOg64FWYyEoomcRwA7et0Zm7xzkBZ+zCTKgBFKpkgcB1aBLfnaLbgKoUwtNw9NP0Wd7xzD1Q2x65qEwScIXEpahGL+4cQDvnyBu7xlhv5N4nSWEIg4/Gc9g4nXHA+mVPJdZ77eYljZOK2U=
Received: from PH8PR22CA0002.namprd22.prod.outlook.com (2603:10b6:510:2d1::26)
 by BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 13:55:02 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:510:2d1:cafe::96) by PH8PR22CA0002.outlook.office365.com
 (2603:10b6:510:2d1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Tue,
 10 Feb 2026 13:55:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Tue, 10 Feb 2026 13:55:00 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 07:54:59 -0600
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Feb 2026 07:54:51 -0600
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Webb Chen <yi-lchen@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 05/18] drm/amd/display: Extend inbox0 HW lock support to DCN35
Date: Tue, 10 Feb 2026 21:49:58 +0800
Message-ID: <20260210135353.848421-6-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135353.848421-1-ray.wu@amd.com>
References: <20260210135353.848421-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|BY5PR12MB4305:EE_
X-MS-Office365-Filtering-Correlation-Id: c4900605-2225-4a61-7f96-08de68abfbe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?effgRqrzSlKzZgL9/1CFAtDCDuP4l4VoElsiEyoFpKEQruQXAWqmzSKQWk+j?=
 =?us-ascii?Q?V+hqrTIOKTqKN0PacsPc+0fZK1jIdb4Bi7/Pjc2kXVdbuhBVq1fn6rLh0/Ow?=
 =?us-ascii?Q?YcWsk16BLux9ZBmrzxw8Kf6fsf9acZITGgFUi4ZZVRYfkejTvq61WNBs2SoX?=
 =?us-ascii?Q?A/F5OlYRz4vOBMclB+v9rUpyrJd2Lo2NTxZ83db/OkP+FkvVN63dKMz4CM5B?=
 =?us-ascii?Q?hmL82tvCyRSPIUXHnYn00RgmOu3OyQsAyhk4VFWu0GcbaJmS7Vd2norb7yR9?=
 =?us-ascii?Q?KtRyJImZGhwx+yuexHr/beYSoDLDpu7IXak86AM+tJJcQAZ7xd+BuR9ueA0u?=
 =?us-ascii?Q?4cRueXA2PxWsXOyS+gprU8OJTW1hFE1fX20KEeCtvTQLyfGIDiDgSg6T7WLu?=
 =?us-ascii?Q?YMVmTxyuiyoOsMHEwjhDNIxWkHROmVjuIed2DMb1udDUTkaQBICAmEcpWo/O?=
 =?us-ascii?Q?Hr65UbmtDsTUwuhINmQsTCDLN7Umw+MsmI2d5olfrHZzKgYYcNeplKcqgS3G?=
 =?us-ascii?Q?XO5JtHpXlG8EHcdyxBB/ucbnsooh8nVArffGxgR1uWCU3FRqTYGH+ymHmdo+?=
 =?us-ascii?Q?SBEyH1v8g5GHeCYt7wVhW0hYkxDg+aGOPBnFAx64t5GZqMchCYNXUE0eZdlw?=
 =?us-ascii?Q?YLJeSMNA8DIlgxJkKD8AjnZFLAlihok/nLRWtWrp5LphM1wuSYja4VqmFehW?=
 =?us-ascii?Q?hwxRVvchGm2fRQoCfTyHg3QZkeq1beIG6yT9ksoMmpgXc+eyzsb39MMz86GO?=
 =?us-ascii?Q?xe/jPx5Xe9pXqBQgZR752u1tj4WpWqrhcKYWnyyOxmzjX3anaDKX6ublG/Sk?=
 =?us-ascii?Q?j+6UlEmJR7dC5CYcBR31Ow1v+kT0oRyF6JMJfSpwTdmm1zROC585c/fs6HAJ?=
 =?us-ascii?Q?mxYYNdqOe/Pe4fCKl2PsD/M4trUPskiGYlgrAGcCIUdADojDIOTgU2dIEX5W?=
 =?us-ascii?Q?6nStsnXp2zdaauZYubjJe2366lGUsh+F5EmCFfoeVcegnuozFUvCnueXZ2z5?=
 =?us-ascii?Q?asrJEGPEXuC3hgO6hzHqtZNcLzsWxT8vbJQa2Ke7nc7pNhsoOkcqzR60kki+?=
 =?us-ascii?Q?sP3yTaiWn6m6Pshn0W42NHXQP1qWluf1lGYEcSxxXPz+dZEuRwEylrchC1c9?=
 =?us-ascii?Q?mLKUOtB9Jiw8TYOCWt/0eu2nSIrdEU1CdcMcxYwTry5r66qPhEc2125yn3qO?=
 =?us-ascii?Q?t8JGjYEPLJKSHzcRlz8XzzsBhUqSOtgWmTjuGHLnrButpUcSGDtRtum2sJJ+?=
 =?us-ascii?Q?04YNjLT/xv09ZuGPcoiO8gN2ZSBlcBrTSvdHcFpOsy04q5kH2K6wKi+GQC44?=
 =?us-ascii?Q?x/qljIGY75pV/jk10YO5IBoe2HtAG0n4zH4hDxKm/drb3FxTlEsyd7nY7HmN?=
 =?us-ascii?Q?1QePBdVRMxrtuOWqk47/+yXNrEv1bQS+qldKjJCnQBI8C0TMKvSbbVSHq4yN?=
 =?us-ascii?Q?arx6qHsODpUvVMpyAiA6TadIhXFmQan66R5DJBMhtIRTJsponZOuRm0aac8V?=
 =?us-ascii?Q?VGTzfxJUrWNqi2zFf7cN+XTQGSazpEseJQpZ0Bvp/MMggaenKSeeQ0N8X8+m?=
 =?us-ascii?Q?Itie9Gg5CkbdM7In6w8/bKUVktE+ZArOUoPC/2/763QlfHqIftFwIUnc3EZt?=
 =?us-ascii?Q?6Xf66YMqhoozlIu676L/IxE4bzb6ptlsVTVbScwft8s+GheSXMbZv68Uqplu?=
 =?us-ascii?Q?5hXl6g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZMhjEWJ6dXb/MjgEeAS6rLKgwrzSYX1Jsq/Fj7QvR8pN+PNY87Y/ETdsd0FhxTV3UqAdLJ46JazzlWlyGU4AcD9brGXCtPyhDPYGe2wUvx2lsZsiVk1QLu5ZQ5X/KNH/2WiiioI4lgYmswctcZ913UGVS1hWZYX2/aa47t8tR0ubbPHrw3SnWaV9nz6uQJsoWe45TT1Fm7R5k3I0vcZXvc7yWXwSGWvhmWTQwZScEJsRGa6AFIdRwWGi2/T6DHlnveIG9VGSS0XGtBPNZ7xJNPq5tTDFR4mUKtoZP3vhWecj6ZNsSI2nrAGRsIGmq9cmiW9keb8tGhs19uGGoETEHSBXBGGKMVPWWd0Jr5ZiZeyGBE94YpX477tX3l3Q2kgS5tVRcb/SDIjNFB2jovxMbDjM3LbrIhm1eYZ9g7Aj6b0eLZyP0wksHO+sqWni0LoH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:55:00.6798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4900605-2225-4a61-7f96-08de68abfbe7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305
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

From: Webb Chen <yi-lchen@amd.com>

[Why & How]
It is a SW lock mechanism to prevent racing with driver/FW.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Webb Chen <yi-lchen@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |  5 +++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 45 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |  4 ++
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  2 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  3 +-
 6 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
index 7116fdd4c7ec..f68cb10ab38b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -105,5 +105,10 @@ bool should_use_dmub_inbox1_lock(const struct dc *dc, const struct dc_link *link
 	if (dc->ctx->dce_version >= DCN_VERSION_4_01)
 		return false;
 
+	if ((dc->hwss.dmub_hw_control_lock) &&
+		(dc->hwss.dmub_hw_control_lock_fast) &&
+		(dc->ctx->dmub_srv->dmub->meta_info.feature_bits.bits.inbox0_lock_support))
+		return false;
+
 	return dmub_hw_lock_mgr_does_link_require_lock(dc, link);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 0cbd75ab61a1..d757a0fdc62c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -48,6 +48,7 @@
 #include "dpcd_defs.h"
 #include "dce/dmub_outbox.h"
 #include "link_service.h"
+#include "dce/dmub_hw_lock_mgr.h"
 #include "dcn10/dcn10_hwseq.h"
 #include "inc/link_enc_cfg.h"
 #include "dcn30/dcn30_vpg.h"
@@ -1778,3 +1779,47 @@ void dcn35_disable_link_output(struct dc_link *link,
 
 	dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
 }
+
+void dcn35_dmub_hw_control_lock(struct dc *dc, struct dc_state *context, bool lock)
+{
+	/* use always for now */
+	union dmub_inbox0_cmd_lock_hw hw_lock_cmd = { 0 };
+
+	if (!dc->ctx || !dc->ctx->dmub_srv)
+		return;
+
+	/* if not support inbox0 lock, would not use inbox0 lock mechanism  */
+	if (!dc->ctx->dmub_srv->dmub->meta_info.feature_bits.bits.inbox0_lock_support)
+		return;
+
+	if (!dc_dmub_srv_is_cursor_offload_enabled(dc) &&
+		!dmub_hw_lock_mgr_does_context_require_lock(dc, context))
+		return;
+
+	hw_lock_cmd.bits.command_code = DMUB_INBOX0_CMD__HW_LOCK;
+	hw_lock_cmd.bits.hw_lock_client = HW_LOCK_CLIENT_DRIVER;
+	hw_lock_cmd.bits.lock = lock;
+	hw_lock_cmd.bits.should_release = !lock;
+	dmub_hw_lock_mgr_inbox0_cmd(dc->ctx->dmub_srv, hw_lock_cmd);
+}
+
+void dcn35_dmub_hw_control_lock_fast(union block_sequence_params *params)
+{
+	struct dc *dc = params->dmub_hw_control_lock_fast_params.dc;
+	bool lock = params->dmub_hw_control_lock_fast_params.lock;
+
+	/* if not support inbox0 lock, would not use inbox0 lock mechanism  */
+	if (!dc->ctx->dmub_srv->dmub->meta_info.feature_bits.bits.inbox0_lock_support)
+		return;
+
+	if (params->dmub_hw_control_lock_fast_params.is_required) {
+		union dmub_inbox0_cmd_lock_hw hw_lock_cmd = { 0 };
+
+		hw_lock_cmd.bits.command_code = DMUB_INBOX0_CMD__HW_LOCK;
+		hw_lock_cmd.bits.hw_lock_client = HW_LOCK_CLIENT_DRIVER;
+		hw_lock_cmd.bits.lock = lock;
+		hw_lock_cmd.bits.should_release = !lock;
+		dmub_hw_lock_mgr_inbox0_cmd(dc->ctx->dmub_srv, hw_lock_cmd);
+	}
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
index e3459546a908..f84409f678ba 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -27,6 +27,8 @@
 #ifndef __DC_HWSS_DCN35_H__
 #define __DC_HWSS_DCN35_H__
 
+#include "inc/core_types.h"
+#include "dc.h"
 #include "hw_sequencer_private.h"
 
 struct dc;
@@ -111,5 +113,7 @@ void dcn35_program_cursor_offload_now(struct dc *dc, const struct pipe_ctx *pipe
 void dcn35_disable_link_output(struct dc_link *link,
 		const struct link_resource *link_res,
 		enum signal_type signal);
+void dcn35_dmub_hw_control_lock(struct dc *dc, struct dc_state *context, bool lock);
+void dcn35_dmub_hw_control_lock_fast(union block_sequence_params *params);
 
 #endif /* __DC_HWSS_DCN35_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index 6ac8ad97cf13..b3b4b8cae138 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -134,6 +134,8 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.update_dchubp_dpp = dcn20_update_dchubp_dpp,
 	.post_unlock_reset_opp = dcn20_post_unlock_reset_opp,
 	.get_underflow_debug_data = dcn30_get_underflow_debug_data,
+	.dmub_hw_control_lock = dcn35_dmub_hw_control_lock,
+	.dmub_hw_control_lock_fast = dcn35_dmub_hw_control_lock_fast,
 };
 
 static const struct hwseq_private_funcs dcn35_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index 04c260015eec..a7006322cde4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -123,6 +123,8 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 	.calculate_pix_rate_divider = dcn32_calculate_pix_rate_divider,
 	.setup_hpo_hw_control = dcn35_setup_hpo_hw_control,
 	.get_underflow_debug_data = dcn30_get_underflow_debug_data,
+	.dmub_hw_control_lock = dcn35_dmub_hw_control_lock,
+	.dmub_hw_control_lock_fast = dcn35_dmub_hw_control_lock_fast,
 };
 
 static const struct hwseq_private_funcs dcn351_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 6f388c910e18..555e35e55b03 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -909,7 +909,8 @@ union dmub_fw_meta_feature_bits {
 	struct {
 		uint32_t shared_state_link_detection : 1; /**< 1 supports link detection via shared state */
 		uint32_t cursor_offload_v1_support: 1; /**< 1 supports cursor offload */
-		uint32_t reserved : 30;
+		uint32_t inbox0_lock_support: 1; /**< 1 supports inbox0 lock mechanism */
+		uint32_t reserved : 29;
 	} bits; /**< status bits */
 	uint32_t all; /**< 32-bit access to status bits */
 };
-- 
2.43.0

