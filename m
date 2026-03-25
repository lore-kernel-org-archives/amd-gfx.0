Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A030FEA814
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 07:08:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED33B10E794;
	Wed, 25 Mar 2026 07:08:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KgQb6WjE";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1919F10E794
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 07:08:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eypVkvcaYPp7nl8XOjXl72Im3aECM3f/49OWElH3nLtyPjiBvmpV4U7w1XDfd/iBGcWor83w0GqckXbjp3KZBul23We3hHF4CL5ZuIro5dTCoxDxi8tmfEAct8Eg4Jib8cM8PJMMbuEchQ1iAQzUV9zAkXyg1cHm5PPvZiXd9SAYR5zBo8rJjXRDkKMmtsFyu7y0me28nPLayFZkdxtwuWULoIVKTDXeGxCr4dVWBO2MTIDhIDzBb32ftbn/2+NLVq97dUobp+Z8Xas7imSXjO5QwIzRNZiz3l7/YT/LJv00CvQ8pt2fkMgtRRk6M1f7onjZOVF4n5duIVNtxZ3uOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpewwE/ncNEKwi9N9J94SfD6eQj22kOPQe2IsAaXqy4=;
 b=UNilrLuLMf2mGIkuDp19atwT3yJL06mTKgRy7rEEpOHugO+CiaZIwGhVdjV/xXJfjIb4rbP3dGyBwPh/4S0fzrPNpBW2emMUaNfhhhQ7u98hSi4ZcwcbLbQnTYCSA53kTzumGy/5X6RH16EF0TNRz6Fe/UQh5CBpwlUU7PHeeHQLQlcbc0iKoiQ4B+xqQaUzKQ1rA+wglgcM4FpFZXZbzwqFpaVp92haVN/i6N/UpWb8qxgqgsQ9Dr+yaww4BRrjJgTV509Uzkxe3qamogHDc4X0mM1vNz5ESnKRm4jlvSwdcl+JWbonWXlJJLZ4dKOJGi5L3eoY6xyVR868ZrAObQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpewwE/ncNEKwi9N9J94SfD6eQj22kOPQe2IsAaXqy4=;
 b=KgQb6WjEk5UKkGFRrf6tVqyLWOqNdCFMNqO0gIL1QVBAgAjA7crEGjvHpSChb8+23zotVxwIBJoo5KUVOWk+cJFQ+by2ook2dZ3su/V3Sptd4hQXAx0fRv+zDaARrooxrIf+DJ8q60XtON+NKVCOW9W8zB+iAEL+w3QIyqfl6yY=
Received: from MN2PR01CA0032.prod.exchangelabs.com (2603:10b6:208:10c::45) by
 DM4PR12MB6183.namprd12.prod.outlook.com (2603:10b6:8:a7::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21; Wed, 25 Mar 2026 07:08:43 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::54) by MN2PR01CA0032.outlook.office365.com
 (2603:10b6:208:10c::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 07:08:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 07:08:42 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:08:39 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 02/29] drm/amd/display: Should support p-state under dcn21
Date: Wed, 25 Mar 2026 15:06:08 +0800
Message-ID: <20260325071003.4022594-3-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
References: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|DM4PR12MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: a812af79-844e-4044-7f1a-08de8a3d594f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|18092099006|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: lVPK10ZopP5oZ6386kpJWW+yKfe4xBZA86VGD+ltBrTLpTwfBR3dIb9d+eV/JKuKRdSZeAgOT705o9kGwbPYe4ayFgPCiKmNaSrT/ha+6UwMkIpZBUDA3g9t40RQW2TUOmfrsQXir6hS4G/P6B6B4kQVJo6Dx53LInHdeE63GIfJjEHNuSUjMW7A+J84Se2INj7cW0p2zRLKDAoPOb5+L2X7c5MMwZ5ZhI1BAm8qAAR975g1rKwXuwiYn8jMXNtoX1ZLl2quzNT/RnqIO4fTKHCNVAXmLD1EYO1tPUbTC82cBDqwlRABxZL3xBWoFhWr1/G4rCF1JbuJoEKiMM0PT79143qqJCUDqxuyw03ygqRL/mfGi1MCTPcLrsEJYJIqzEGVhRTPRqeK8OFy/Q1tGmsZ7ew9BbgHzl5KBJP0bd8IOZ/GewSB5TpKvS2aIfXh3XGD97ICUoTMO72cMj/ojSNXESuccOf+m9sSRb6J6I8e0h7SYTIHJmyZwM+Ew5s2vL2o9eyHVlkUSHZGeTQ+/pgqyISGkF3NtAsQcGCtvB5O9hPtapuV4TpMaClBspbIbkDZwK+oSGfrNFdIjQUN04ncbueiwIrsbaNmdSq0Kzew+ppZlXc0HgN1W4PfMQSqJ73HV9p2Bd5N5w/dCnSGbb35RVzHTlDMHzaxhUNmKBCwgOrHkU5V0N48+RMoAEKt9tSe6Jqy9/QFYl71fP2ZW1fSLIvSyVAE7C4B8YfxsQCx1mAGFZZdJysk2UrWTd2uw7Y8av7Ci1Id+XEMaUybYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(18092099006)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KhI8837RdAwA7K/IkN96I4+AY+3UPFoK0HaZIkXBxvEi7lADVrUWkarx0TNixdxWjDSO8Nyf03y3RTqdltXcuFvN4XsZKQD0D4fDMGfhSoWWNyKnaY8h0oDmuv8pMPQjdNVy6fRICgwIOA/wNg3w6Rrg7zT1udUsL0Y2UKwAsw+jSPs7BncBgRcUL8amAtJ8G0LSGMbhCWi1dIrbngcijNiwMKhesiMyqmUdlb3a/4LSMReP2KvxyS5SKtFn9WFQxzYT895szcWw0SRjlHwRKcl80F79U33ckMARJc+cuhwGON56gK8gZg69tYjrxKVnH7m5vtopT4ldf3RT9ToKUSD/y8Tl994LdyjQlqtBsj1h9sB/v46/PwI38ZGVlyAB8cj4X1Vvjn0xjmyoorBVX0i1QY9IlKDXa5wmHm5XAA4Rr5rPNjl4ERSIg17HGuwk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:08:42.8775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a812af79-844e-4044-7f1a-08de8a3d594f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6183
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

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
Under DCN21, observe flip_done timeout issue while
running 3D benchmark under MPO case. Timeout is caused
by driver fails validate_bandwidth() during
atomic_commit_tail but passes atomic_check.

Under further analysis, indicates the delta of
atomic_check and atomic_commit_tail are
dc->current_state->bw_ctx.dml.soc.sr_exit_time_us and
dc->current_state->bw_ctx.dml.soc.sr_enter_plus_exit_time_us.

We set validate_mode as DC_VALIDATE_MODE_ONLY while calling
dc_validate_global_state() at atomic_check, but set mode as
DC_VALIDATE_MODE_AND_PROGRAMMING during atomic_commit_tail.
If dc_validate_mode set as DC_VALIDATE_MODE_ONLY,
validate_bandwidth() will skip the wm and dlg calculation.

During commit_tail, validate_bandwidth() is called with
dc_validate_mode set as DC_VALIDATE_MODE_AND_PROGRAMMING and
dc_state->bw_ctx.dml.soc.sr_exit_time_us might get modified
after the wm_calculation and stored into dc->current_state.
Which means dc->current_state->bw_ctx.dml.soc.sr_exit_time_us
might not aligned with the one stored in dm_state->context.
That causes duplicated dm_state->context not aligned with
dc->current_state, and might have bandwidth validation pass
in atomic_check and fail in commit_tail later.

[How]
When the issue occurs, it fails dml_get_voltage_level() with
the condition dm_allow_self_refresh_and_mclk_switch but pass
with the condition dm_allow_self_refresh. However, we should
support p-state. So we should not pass validate_bandwidth by
allowing self refresh only. Change the policy under DCN21.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |  2 +-
 .../dc/resource/dcn21/dcn21_resource.c        | 30 +++++++++++--------
 .../dc/resource/dcn21/dcn21_resource.h        |  3 +-
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 7aaf13bbd4e4..ae34982b1b1c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -2335,7 +2335,7 @@ bool dcn21_validate_bandwidth_fp(struct dc *dc, struct dc_state *context,
 	/*Unsafe due to current pipe merge and split logic*/
 	ASSERT(context != dc->current_state);
 
-	out = dcn21_fast_validate_bw(dc, context, pipes, &pipe_cnt, pipe_split_from, &vlevel, validate_mode);
+	out = dcn21_fast_validate_bw(dc, context, pipes, &pipe_cnt, pipe_split_from, &vlevel, validate_mode, false);
 
 	if (pipe_cnt == 0)
 		goto validate_out;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
index e57022af2c2a..a612c8932da9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
@@ -772,7 +772,8 @@ bool dcn21_fast_validate_bw(struct dc *dc,
 			    int *pipe_cnt_out,
 			    int *pipe_split_from,
 			    int *vlevel_out,
-			    enum dc_validate_mode validate_mode)
+			    enum dc_validate_mode validate_mode,
+			    bool allow_self_refresh_only)
 {
 	bool out = false;
 	int split[MAX_PIPES] = { 0 };
@@ -803,18 +804,23 @@ bool dcn21_fast_validate_bw(struct dc *dc,
 	vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
 
 	if (vlevel > context->bw_ctx.dml.soc.num_states) {
-		/*
-		 * If mode is unsupported or there's still no p-state support then
-		 * fall back to favoring voltage.
-		 *
-		 * We don't actually support prefetch mode 2, so require that we
-		 * at least support prefetch mode 1.
-		 */
-		context->bw_ctx.dml.soc.allow_dram_self_refresh_or_dram_clock_change_in_vblank =
-					dm_allow_self_refresh;
-		vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
-		if (vlevel > context->bw_ctx.dml.soc.num_states)
+
+		if (allow_self_refresh_only) {
+			/*
+			 * If mode is unsupported or there's still no p-state support then
+			 * fall back to favoring voltage.
+			 *
+			 * We don't actually support prefetch mode 2, so require that we
+			 * at least support prefetch mode 1.
+			 */
+			context->bw_ctx.dml.soc.allow_dram_self_refresh_or_dram_clock_change_in_vblank =
+						dm_allow_self_refresh;
+			vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
+			if (vlevel > context->bw_ctx.dml.soc.num_states)
+				goto validate_fail;
+		} else {
 			goto validate_fail;
+		}
 	}
 
 	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.h
index a017fd9854d1..23d3a36872bb 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.h
@@ -51,6 +51,7 @@ bool dcn21_fast_validate_bw(
 		int *pipe_cnt_out,
 		int *pipe_split_from,
 		int *vlevel_out,
-		enum dc_validate_mode validate_mode);
+		enum dc_validate_mode validate_mode,
+		bool allow_self_refresh_only);
 
 #endif /* _DCN21_RESOURCE_H_ */
-- 
2.43.0

