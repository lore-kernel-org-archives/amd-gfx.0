Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAE0C47073
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 21:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 306F510E7B3;
	Wed, 10 Jan 2024 21:57:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C7E810E7B3
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 21:57:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KykK70YX2EPAm/dBB8IzU3uVLMhE48INhvDe1QQdbJIL0WNxZofumzVRyyZGzU5/x8SF94jNsGAfaAxIASsxGirxWgg+06hKXkYJVaKNd5p4/FWJC7F26RgdiCjnALcc19VRD4F32KalHhhH73wfQgbFJV3tDeiiONtUih+0q86l6bobbCS7lWsrlflgUs00uS0YYPg3fHQEzMrMaY+VsYuVlnPdgQdTqr94HXua/d6bGysJTKupWDlpnQ1R6yjfcQOOiGn3Ze9l9mh8Q+aCgdjERxFQKyehVe72SCWUjizaamO4NFbLPmd8OZUMN6dgBXiNb+WVQY4dXSAWNj8XUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBTNf+L6C8s6DOdhP/Ig07D8C/DfYaNPmqunvH06TLI=;
 b=avZTrxKgnqUnD03q6yM2QX/GYUgCI/4CbkWZ8U6jZg9R8jCY4IQjhWzJCXVAZdVmIkVTS14fszp+8GqBJ2nNNRSSB/Cqm5hgXUs5f0Dqpj5H7vdWOILk2gAJy7C4Ry/539oGIiBAZ88/GqdJ0NpKFp9oRifNy0Ef0p3qPmQ/COvBs5KricjTfg4qtGqKOko93t1Ky37C6GUsX3pw0xg00uMuXm8E6pasbKu5USePM6L/Kn0tZhGCE2ZeTfJ15jU+BjPouY5QUbJ2lR+VDFA1obyWnzotVAMoRN1vUTney8M0R2Ke8QJijs1P4nsrdSmVvkbeXRX0Qz+1XGzY/XIizA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBTNf+L6C8s6DOdhP/Ig07D8C/DfYaNPmqunvH06TLI=;
 b=qy+CfRilFLM1s3OUSOAtM3tAo3bjCbINAEH16x7pE2PYObp837IY2vzzkTXXSIbAYrTtbo3xyxEfagcXgvRfaRR5widez10ELHxfOyR4DrhM5BVg7/1WlCb5hdhga522Yd6fFtYG1PwlOMUKw5MFdx7aPXjnZENLkEKewSwnJPE=
Received: from CH5PR05CA0023.namprd05.prod.outlook.com (2603:10b6:610:1f0::25)
 by CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 21:57:32 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::45) by CH5PR05CA0023.outlook.office365.com
 (2603:10b6:610:1f0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 21:57:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 21:57:32 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 15:57:30 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/19] drm/amd/display: Rework DC Z10 restore
Date: Wed, 10 Jan 2024 14:52:58 -0700
Message-ID: <20240110215302.2116049-16-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110215302.2116049-1-alex.hung@amd.com>
References: <20240110215302.2116049-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|CY5PR12MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b4181c-2076-4478-7588-08dc12272576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+b+ug3JUqZZfqwLFI0wYOTHTU0RuTjtB3pwOpWsdsgogWkA2p8COMz+2EPQlhOmb4uwfD73F1rDCPBGKrsWnX3zZePO8qPIj1aGpJP7Op+6DOhzGVIa91ncYjZP4kBSmpN3KJSpfWR3Ded1l7Kzp4gnwsjYPqEO+ay7AQPfM0CFTiogO1CxJOE52DS6bP+8EbFHFIynWvrLvBgwbB9LyS7BJxtycVtg2FL+VyyVQeQIbtifo+cSGHJYbVd6EMS51Gh8HcGe/sI3A01Uid+r7oKlcE9pxqFU3xrfksLJGVPZDf2gMCURMuXbYRBx1x5O3K/xDl5+N3D+3XJIzKxwK65+0sU309F+rSNPCbxzrGCESIlyuljS9jIujZIU9oFusRjMk5W8cLT26a1Mid76H4DXDI/eM9qclqMbZos3jGa5Gjmsmc4LWZQAB9CvwKo7y4De++4BZv+aOmZTYeKLGjxm1MfSZ8y535fq2Dn3/eYg1IcbxFVXPNIRcndv5Zup3jGBlVNTXckyZNgJmNKK5isKwLBiIduMaHGD7PrzS+QFGZcHa/A+oPbGXDTzg1rDzORP/K5bZVDbB1GRP39Wv2sRjW7nctXt8nqwK+o+7EQYaQ16Ugt1w5mheO/cIUuaxEE6YPMFn6E+uW+quUWeC0Hd7aeO94PBFyuC4V3Gl6hkST0hFh0NAHCgx9kjs+pSn2wNthJvYmKdTVqekCREjCxlIWXfS8PpovO8AN5IRm2J/xfc4UQpvHsfO0zXJoIbUgPAYV0j45ZFycsrBtUj9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(186009)(451199024)(1800799012)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(426003)(26005)(2616005)(1076003)(336012)(7696005)(478600001)(6666004)(36756003)(86362001)(81166007)(356005)(82740400003)(47076005)(83380400001)(41300700001)(36860700001)(5660300002)(316002)(2906002)(44832011)(16526019)(70206006)(8936002)(4326008)(6916009)(8676002)(54906003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 21:57:32.0531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b4181c-2076-4478-7588-08dc12272576
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Yihan Zhu <yihan.zhu@amd.com>, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Alex Hung <alex.hung@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The call currently does two things:
1. Exits DMCUB from idle optimization if it was in
2. Checks DMCUB scratch register to determine if we need to call
   DMCUB to do deferred HW restore and then sends the command if it's
   ready for it.

By doing (1) we prevent driver idle from being renotified in the cases
where driver had previously allowed DC level idle optimizations via
dc_allow_idle_optimizations since it thinks:

allow == dc->idle_optimizations_allowed

...and that the operation is a no-op.

We want driver idle to be resent at the next opprotunity to do so
for video playback cases.

[How]
Migrate all usecases of dc_z10_restore to only perform (2).

Add extra calls to dc_allow_idle_optimizations to handle (1) and also
keep SW state matching with when we requested enter/exit of DMCUB
idle optimizations.

Ensure cursor idle optimizations false always get called when IPS
is supported.

Further rework/redesign is needed to decide whether we need a separate
level of DM allow vs DC allow and when to attempt re-entry.

Reviewed-by: Yihan Zhu <yihan.zhu@amd.com>
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c              | 11 ++++++++++-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c       |  9 +++++----
 .../gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  2 --
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index aa7c02ba948e..af83ec23f3a0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1836,8 +1836,8 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	struct dc_state *old_state;
 	bool subvp_prev_use = false;
 
-	dc_z10_restore(dc);
 	dc_allow_idle_optimizations(dc, false);
+	dc_z10_restore(dc);
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
@@ -3376,6 +3376,9 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 	int i, j;
 	struct pipe_ctx *top_pipe_to_program = NULL;
 	struct dc_stream_status *stream_status = NULL;
+	if (dc->caps.ips_support)
+		dc_allow_idle_optimizations(dc, false);
+
 	dc_z10_restore(dc);
 
 	top_pipe_to_program = resource_get_otg_master_for_stream(
@@ -3503,6 +3506,9 @@ static void commit_planes_for_stream(struct dc *dc,
 	// dc->current_state anymore, so we have to cache it before we apply
 	// the new SubVP context
 	subvp_prev_use = false;
+	if (dc->caps.ips_support)
+		dc_allow_idle_optimizations(dc, false);
+
 	dc_z10_restore(dc);
 	if (update_type == UPDATE_TYPE_FULL)
 		wait_for_outstanding_hw_updates(dc, context);
@@ -4686,6 +4692,9 @@ void dc_set_power_state(
 	case DC_ACPI_CM_POWER_STATE_D0:
 		dc_state_construct(dc, dc->current_state);
 
+		if (dc->caps.ips_support)
+			dc_allow_idle_optimizations(dc, false);
+
 		dc_z10_restore(dc);
 
 		dc->hwss.init_hw(dc);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 54670e0b1518..23f4f3c070cb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -309,7 +309,6 @@ bool dc_stream_set_cursor_attributes(
 
 	stream->cursor_attributes = *attributes;
 
-	dc_z10_restore(dc);
 	/* disable idle optimizations while updating cursor */
 	if (dc->idle_optimizations_allowed) {
 		dc_allow_idle_optimizations(dc, false);
@@ -381,12 +380,14 @@ bool dc_stream_set_cursor_position(
 	}
 
 	dc = stream->ctx->dc;
-	dc_z10_restore(dc);
 
 	/* disable idle optimizations if enabling cursor */
-	if (dc->idle_optimizations_allowed && (!stream->cursor_position.enable || dc->debug.exit_idle_opt_for_cursor_updates)
-			&& position->enable) {
+	if (dc->idle_optimizations_allowed &&
+	    (!stream->cursor_position.enable || dc->debug.exit_idle_opt_for_cursor_updates ||
+	     dc->caps.ips_support) &&
+	    position->enable) {
 		dc_allow_idle_optimizations(dc, false);
+		dc_z10_restore(dc);
 		reset_idle_optimizations = true;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 8b6c49622f3b..da4f98de9b82 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -708,8 +708,6 @@ void dcn35_z10_restore(const struct dc *dc)
 	if (dc->debug.disable_z10)
 		return;
 
-	dc_dmub_srv_apply_idle_power_optimizations(dc, false);
-
 	dcn31_z10_restore(dc);
 }
 
-- 
2.34.1

