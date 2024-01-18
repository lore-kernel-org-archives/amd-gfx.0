Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18221C4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 14:35:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E148E10E831;
	Thu, 18 Jan 2024 14:34:58 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 722B710E831
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 14:34:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/3rnuNZgo5NxOrDKV1DPAa2mJXWJmqScaFYVDpK1r8kZ9e+Gsbtk+DS6aaKsZ3/4OifC6FAEDi9sbNiHN0FtbvwoWCqCH5xwMpZ9cgws0Ol74g47v55tVPiqn1p2rlsNGXr63RJkj1cmWTPJ0bSAdDLhvWFGak4VAcKafH7TGoIqS9iy8rwuu6Bv8hCGwHkEKzZtYPIeUh7pnV6PlJ6ET3N9GQbTqTDywO5tBzwMo39i6lN9AuQ4oSvkiK3yzyUJf/yVuL0h1/W2rHWfeT5gFVh2DAXK58CAKVkK8sBkU3E1yGwpXWEDBx/liTyRihjlNVG57PPj4TrTeFm9PdL5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/w0xPjUxOZX8BBkpB+hffu+x/iODYm9+j/Ztgmy1XI=;
 b=DsORopD2fsHXMficKQj+aUXLiT6Xf5OJNdtlAy7Tftp3FVBdleUIQ4OchIL+wFUySCeVlx2H1c3V3RYS0L/Zao3uwMfvhaSk3w1FWsJhbEGBxgGtd7KsERZ3sRUpKlVwpEsyQxpKDY75zI+pWThEWQ6PJJJtADUTEAmdDe45w5RafUG342yu0g/iLk7kGwLvUySVDn4KwcFb+ogxFQKc1C/oMbO1IKGmFMD1Ro/QwYeB18AMLJZnTHyaaejhgqd7FeM5qdHo1OxQCJtxdaFYmXwTIOflKR17WnW8+P6jSTuGoD0S9/WdEel+tAKgwRpMz9PZyIojZTM8rcpCnXAlpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/w0xPjUxOZX8BBkpB+hffu+x/iODYm9+j/Ztgmy1XI=;
 b=LX5FJyXifPiRvk/j/T7ZYPsDZn1lgGdnu92Z6hlyNESX4tuOSqy4sBP0d6GvWgFJ6NjlJl/9q9Da8sMLpAGKuEeOJo+HSBzogyuawQia5C6xkM4pDpj7JW6hX+37re3odz5N0Vjoi7as+6RzkQDFE7GT20fUmhso4Ra2Ry028TM=
Received: from SJ0PR03CA0375.namprd03.prod.outlook.com (2603:10b6:a03:3a1::20)
 by CY8PR12MB8299.namprd12.prod.outlook.com (2603:10b6:930:6c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 14:34:49 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::ac) by SJ0PR03CA0375.outlook.office365.com
 (2603:10b6:a03:3a1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 14:34:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 14:34:48 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 08:34:42 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 18 Jan 2024 08:34:42 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/12] drm/amd/display: Revert "Rework DC Z10 restore"
Date: Thu, 18 Jan 2024 09:33:55 -0500
Message-ID: <20240118143400.1001088-8-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118143400.1001088-1-Roman.Li@amd.com>
References: <20240118143400.1001088-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|CY8PR12MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: e0117c63-def3-434f-8c7c-08dc18329fe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9F9Dzy2JkSy6shtOOylaqo5rGJJbGww1eUoRgfjX/hx1zueEyo+CYiIaQnyTbZhnmUektDMO5d4BToDmzSPc55xI+d7wq27CYLZeeHKhdmhcueCHYN9OP5W/SRUoyX/JCtd5lMaonChcajgz18m6P0E7z3KxUAGlztoyyaOAnqysgoSf8YOpspwd6x7LakNaH9j0/OThivXb+AGSwm+3jmpbbpvg+KQb8Fx5s9YGruUjgXYglooEv24mWzk/3Y7OQhTHkciJj65/b+IGAsJvvn9CfmGZzaUaU58VC1J06d+jm/+/81U4q86lIRaTOGurSg6mXCkmf5W5/i3S2DZ629hU3HJtcBJKiuX6iimtvHTfNptoKOOLrbC1B9+tZJcXeZMJJQqI9nvK7iLCl+osHOr63cM8x44qbTyKQHQ8HjImO+rn3j1vwYE0qL5g179nPUOSFRdj7TiLM9D3iMeSVuP98fkVtj7zyr80PnKb0JvMN7HQABCyIl7c5EVtSC3haAafsuR/bQm0xyA1uJqlsi0EeR9La8qWa9/f7OGw94Dlmm7GAi9Bi068ERf9APLzIIej4Z7uD/xRV1Q/hGMsXe9jsfw0+eZSiMCBodT8k78kPBPfXgdIBYiVk+W2i0tuUxRPcF1TXMuq7hbhuYq+tA2wytVm3/AZb75Gyw+xochrqtGmAbXCJyPb9k3LUIFVm2Y7r5iFg77GF3LJkfSyAaxwJESYSRNXVAAqJ/HpJcO1NStnN7uXtfEywgRcPtqxXEXNSZHHaiZ/JOjQorXmRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799012)(40470700004)(46966006)(36840700001)(36756003)(26005)(86362001)(356005)(81166007)(478600001)(40460700003)(2616005)(316002)(41300700001)(40480700001)(336012)(426003)(2906002)(2876002)(1076003)(6666004)(7696005)(70206006)(5660300002)(70586007)(54906003)(83380400001)(6916009)(82740400003)(47076005)(4326008)(8676002)(8936002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 14:34:48.8076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0117c63-def3-434f-8c7c-08dc18329fe7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8299
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
Cc: Charlene Liu <charlene.liu@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <charlene.liu@amd.com>

This reverts commit 080a7e9d7dc5a18401d0569a36d55e133ed10cf8.

It caused intermittent hangs when enabling IPS on static screen.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c              | 11 +----------
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c       |  9 ++++-----
 .../gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  2 ++
 3 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index af83ec23f3a0..aa7c02ba948e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1836,8 +1836,8 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	struct dc_state *old_state;
 	bool subvp_prev_use = false;
 
-	dc_allow_idle_optimizations(dc, false);
 	dc_z10_restore(dc);
+	dc_allow_idle_optimizations(dc, false);
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
@@ -3376,9 +3376,6 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 	int i, j;
 	struct pipe_ctx *top_pipe_to_program = NULL;
 	struct dc_stream_status *stream_status = NULL;
-	if (dc->caps.ips_support)
-		dc_allow_idle_optimizations(dc, false);
-
 	dc_z10_restore(dc);
 
 	top_pipe_to_program = resource_get_otg_master_for_stream(
@@ -3506,9 +3503,6 @@ static void commit_planes_for_stream(struct dc *dc,
 	// dc->current_state anymore, so we have to cache it before we apply
 	// the new SubVP context
 	subvp_prev_use = false;
-	if (dc->caps.ips_support)
-		dc_allow_idle_optimizations(dc, false);
-
 	dc_z10_restore(dc);
 	if (update_type == UPDATE_TYPE_FULL)
 		wait_for_outstanding_hw_updates(dc, context);
@@ -4692,9 +4686,6 @@ void dc_set_power_state(
 	case DC_ACPI_CM_POWER_STATE_D0:
 		dc_state_construct(dc, dc->current_state);
 
-		if (dc->caps.ips_support)
-			dc_allow_idle_optimizations(dc, false);
-
 		dc_z10_restore(dc);
 
 		dc->hwss.init_hw(dc);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 23f4f3c070cb..54670e0b1518 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -309,6 +309,7 @@ bool dc_stream_set_cursor_attributes(
 
 	stream->cursor_attributes = *attributes;
 
+	dc_z10_restore(dc);
 	/* disable idle optimizations while updating cursor */
 	if (dc->idle_optimizations_allowed) {
 		dc_allow_idle_optimizations(dc, false);
@@ -380,14 +381,12 @@ bool dc_stream_set_cursor_position(
 	}
 
 	dc = stream->ctx->dc;
+	dc_z10_restore(dc);
 
 	/* disable idle optimizations if enabling cursor */
-	if (dc->idle_optimizations_allowed &&
-	    (!stream->cursor_position.enable || dc->debug.exit_idle_opt_for_cursor_updates ||
-	     dc->caps.ips_support) &&
-	    position->enable) {
+	if (dc->idle_optimizations_allowed && (!stream->cursor_position.enable || dc->debug.exit_idle_opt_for_cursor_updates)
+			&& position->enable) {
 		dc_allow_idle_optimizations(dc, false);
-		dc_z10_restore(dc);
 		reset_idle_optimizations = true;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index da4f98de9b82..8b6c49622f3b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -708,6 +708,8 @@ void dcn35_z10_restore(const struct dc *dc)
 	if (dc->debug.disable_z10)
 		return;
 
+	dc_dmub_srv_apply_idle_power_optimizations(dc, false);
+
 	dcn31_z10_restore(dc);
 }
 
-- 
2.34.1

