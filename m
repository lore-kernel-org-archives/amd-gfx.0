Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77520C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 07:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E36410E4B9;
	Tue, 30 Jul 2024 07:20:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rOxstOOI";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E266510E4B9
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 07:20:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0uTrlZBdMnJ0+w3i6OjU8Td2aG8K4H9nG+eQSWhfQROknPSjx/FWOLu8PD4ZLxwPwZK66tqnK9sG7i5WwUakfInQfFZ0VmSnH/0XnHB9Z/yzqN6MYWc/vAkH6ImGQgdZlvry6Qy3+fhcWo01B9SjhWVjrALc23A58qAi6GVQEtabZxa+HSBV9VUNDXj04eRBC2JBPOAdfPLrmjXcFkO5uwYjpLQNvjceOngm0ft0coTmVwuPXL+2ry4SGOMngY5lMyWo3vVZ2KSVqJ0ZFmpvIZGU3uYAdVSt5fYxDsoNUBosUvULw0384YD6x/pzhe7AXrYX5Fu2w1TACJ9ITPIfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/zmNC2osxl5H1Nf3Tqcu7SqZnTxBXYEM5JJvMu8mCs=;
 b=rExpppJC2pnBj4xOnXO/YWnyt0Tg2CNj9D4qTDyvYANR6RGvGmaUm6OnDFCFfp50Q6ZHiYRE+SLBexjAx/gWlxUaqk27lYlk4knm53I7DbTh0gUkTrOGaDv21XO70EnkDIx2ghLaaFdSvmgdCMAD7wnQDAAyEHvbmZV5r35G2OTaiorfUw4ByiEQnYykMZ0BcLlGb5XfFTpFsEBdwQ5Rm/mzkkz5m/BFjzNfFKn2mNPb1zfO5rSasRmujzNMzBQsuuJZnK2HVrodtS6ijj/47dqdoGO2TcRbKvBKfP4FoHhTyiU/zcxtZ1IScxNGYFyNjVZDLl/UFyuOaznDJpJ3yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/zmNC2osxl5H1Nf3Tqcu7SqZnTxBXYEM5JJvMu8mCs=;
 b=rOxstOOIwBwWPJ8xaF69zM8fJdC5uVsewI+C5gYGy961SRyUP7ISpmj8q769zxW9nOd5LBw9XlCHNYZNJTNlMEqVp/Minpvm1EEFNa2ZTBQ2j9gDBNpjxBsqGYR9qABwRFjVXFrzTR1XSqOj/BFbngeLmNf8EBL9eKrxdw+PfsY=
Received: from BL0PR1501CA0011.namprd15.prod.outlook.com
 (2603:10b6:207:17::24) by SJ1PR12MB6195.namprd12.prod.outlook.com
 (2603:10b6:a03:457::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 07:20:33 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::e6) by BL0PR1501CA0011.outlook.office365.com
 (2603:10b6:207:17::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Tue, 30 Jul 2024 07:20:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 07:20:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:20:32 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 30 Jul 2024 02:20:15 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 09/22] drm/amd/display: fix a UBSAN warning in DML2.1
Date: Tue, 30 Jul 2024 15:18:30 +0800
Message-ID: <20240730071843.880430-10-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240730071843.880430-1-Wayne.Lin@amd.com>
References: <20240730071843.880430-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|SJ1PR12MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d86e4fc-cf21-4896-c574-08dcb068196f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vEcXy6KX6mnfe7IwyueJDytkBiwbVNyR8F/PxvSdwGaszCoewJd0XSg+XfM6?=
 =?us-ascii?Q?n8nuWYtvF8tabDUAExUU72jmporWUwlbJGCiwOQ1sT2FDqfhfnERyv/GyNfu?=
 =?us-ascii?Q?MfoFUu5YqF0xysUq5st64eUYTydWk99aeiIcEhmoeZyyCciKyJYsKiGeLLdg?=
 =?us-ascii?Q?6sQf4mqUpI6a6UF7xEtca3W6E4eiyuZX+3E7wr50VYyuL7X/QmSjLmNOenZh?=
 =?us-ascii?Q?Bvx6EoI7WoPEYLjU8vTpTLQ+3LQpuKULLqbs+aY7iMdEEpENgPhhOik8YYyN?=
 =?us-ascii?Q?+6drhsd+1vCTMswUASjNpmWRt0HkYtkdHVIg4mukEXK1/HQn+9OGmsfacFzI?=
 =?us-ascii?Q?b38olsxZ0CGQ+ENy7Yx3UR7d1F5GIuzCbEY4ZECzy22zk+/Ldg8/ROzcSG+F?=
 =?us-ascii?Q?sbNAbjoWMsGcOViycgjKGIaF6gTAkWNU3sMca6G1iVrcKJH53yRwbQb3e0BD?=
 =?us-ascii?Q?5mH/InxUUkHSqqFI+d8LCVpIBHDC7H8dhO9HE0/2pdfqT9JCrQ3bXNOP98vr?=
 =?us-ascii?Q?ls0zCIAtgrX3mJMWG03UI4hkGpKkplTg8Nm99pK0mfrAIfPKUgyNr6HVgs3K?=
 =?us-ascii?Q?AIZIw2t/lxaN0LXUYD+9SOE3txbWFpao/g5R1Ksv2DcyPRX+Y76CbMzWVIvd?=
 =?us-ascii?Q?ZW0ZPNysAKOoEWpau/Qp1I1ksbmC1qZmDqQCGGph8aZNbmXzNqeVSQhMI6EL?=
 =?us-ascii?Q?waJSXfRVDUkEE8E3y9gQo/zI5RKp0QZ2wM0Wa+NEF8rN09n95qeIiHJcNMtS?=
 =?us-ascii?Q?CgiTgAHdSYzHsB51GzZZv+c2MZjXAFg+lu7DBRDDi7rFIeMfQeyOjJL+hIgB?=
 =?us-ascii?Q?bISKx3Iuhm3+EuvCgYukiclymTJLHAR/PGDXhN8T75TMHkvNXUa5H2rBL+ZE?=
 =?us-ascii?Q?wA3sg73DHgGi7Y5FRjSD4/yCZ8eCcXCpRZkTfb5Re37xnXhDeZpdNRHNyzWc?=
 =?us-ascii?Q?3REZePpSbXhrkacdhA9h8a88K/3LCQEsEiBF4OoMcN2MrxtJd9m0D9E7NSKd?=
 =?us-ascii?Q?b4LQZZb3P/xi2iaDuD1NgHKgUyw4/CKGmO/j2RLE3v6vENodpbSvpZr6Owcu?=
 =?us-ascii?Q?aom/DeTXPgDzGAOQEht8+ZEQLH6bfgfc9XItb3X+I5P5yz2Nqa+OKCSNwiZU?=
 =?us-ascii?Q?+OvTD9o+O7EgZpiDZo1j+kzIID9Hueoynvs+MUk4Lv1+ckstbkfDdXNPuPLa?=
 =?us-ascii?Q?aSGWLPSXQjolMEiAB6fiJM0RyS3MEhw24RufR5ipB47+iK20Fr1tLNAYSbJR?=
 =?us-ascii?Q?2K/6+bVz9iHbOZ6KP0uVSp7mCmC/COSESiwtzmq5G8nyTww/JFJmdeHpfAzE?=
 =?us-ascii?Q?qdFpFWGYj9u6ZBgTmP2IpISFN3lFmS3bopspcPPln4jdSt07IiY72JV2KzGj?=
 =?us-ascii?Q?jaZzmfk2I24iFnwY85cfi/eBkVelxMVu3Eo5RhjrIMWLHYMNTN1bmqJG99BS?=
 =?us-ascii?Q?Xrt+GrtWumGG8FFP+M4NYx/UoXY6lGSb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:20:32.8829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d86e4fc-cf21-4896-c574-08dcb068196f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6195
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

When programming phantom pipe, since cursor_width is explicity set to 0,
this causes calculation logic to trigger overflow for an unsigned int
triggering the kernel's UBSAN check as below:

[   40.962845] UBSAN: shift-out-of-bounds in /tmp/amd.EfpumTkO/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c:3312:34
[   40.962849] shift exponent 4294967170 is too large for 32-bit type 'unsigned int'
[   40.962852] CPU: 1 PID: 1670 Comm: gnome-shell Tainted: G        W  OE      6.5.0-41-generic #41~22.04.2-Ubuntu
[   40.962854] Hardware name: Gigabyte Technology Co., Ltd. X670E AORUS PRO X/X670E AORUS PRO X, BIOS F21 01/10/2024
[   40.962856] Call Trace:
[   40.962857]  <TASK>
[   40.962860]  dump_stack_lvl+0x48/0x70
[   40.962870]  dump_stack+0x10/0x20
[   40.962872]  __ubsan_handle_shift_out_of_bounds+0x1ac/0x360
[   40.962878]  calculate_cursor_req_attributes.cold+0x1b/0x28 [amdgpu]
[   40.963099]  dml_core_mode_support+0x6b91/0x16bc0 [amdgpu]
[   40.963327]  ? srso_alias_return_thunk+0x5/0x7f
[   40.963331]  ? CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport+0x18b8/0x2790 [amdgpu]
[   40.963534]  ? srso_alias_return_thunk+0x5/0x7f
[   40.963536]  ? dml_core_mode_support+0xb3db/0x16bc0 [amdgpu]
[   40.963730]  dml2_core_calcs_mode_support_ex+0x2c/0x90 [amdgpu]
[   40.963906]  ? srso_alias_return_thunk+0x5/0x7f
[   40.963909]  ? dml2_core_calcs_mode_support_ex+0x2c/0x90 [amdgpu]
[   40.964078]  core_dcn4_mode_support+0x72/0xbf0 [amdgpu]
[   40.964247]  dml2_top_optimization_perform_optimization_phase+0x1d3/0x2a0 [amdgpu]
[   40.964420]  dml2_build_mode_programming+0x23d/0x750 [amdgpu]
[   40.964587]  dml21_validate+0x274/0x770 [amdgpu]
[   40.964761]  ? srso_alias_return_thunk+0x5/0x7f
[   40.964763]  ? resource_append_dpp_pipes_for_plane_composition+0x27c/0x3b0 [amdgpu]
[   40.964942]  dml2_validate+0x504/0x750 [amdgpu]
[   40.965117]  ? dml21_copy+0x95/0xb0 [amdgpu]
[   40.965291]  ? srso_alias_return_thunk+0x5/0x7f
[   40.965295]  dcn401_validate_bandwidth+0x4e/0x70 [amdgpu]
[   40.965491]  update_planes_and_stream_state+0x38d/0x5c0 [amdgpu]
[   40.965672]  update_planes_and_stream_v3+0x52/0x1e0 [amdgpu]
[   40.965845]  ? srso_alias_return_thunk+0x5/0x7f
[   40.965849]  dc_update_planes_and_stream+0x71/0xb0 [amdgpu]

Fix this by adding a guard for checking cursor width before triggering
the size calculation.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 93 ++++++++++---------
 1 file changed, 49 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index c54f1af1845c..cbecdc9f253a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -7247,10 +7247,9 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	/* Cursor Support Check */
 	mode_lib->ms.support.CursorSupport = true;
 	for (k = 0; k < mode_lib->ms.num_active_planes; k++) {
-		if (display_cfg->plane_descriptors[k].cursor.cursor_width > 0.0) {
-			if (display_cfg->plane_descriptors[k].cursor.cursor_bpp == 64 && mode_lib->ip.cursor_64bpp_support == false) {
+		if (display_cfg->plane_descriptors[k].cursor.num_cursors > 0) {
+			if (display_cfg->plane_descriptors[k].cursor.cursor_bpp == 64 && mode_lib->ip.cursor_64bpp_support == false)
 				mode_lib->ms.support.CursorSupport = false;
-			}
 		}
 	}
 
@@ -8111,27 +8110,31 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
 		double line_time_us = (double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_total / ((double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.pixel_clock_khz / 1000);
 		bool cursor_not_enough_urgent_latency_hiding = 0;
-		calculate_cursor_req_attributes(
-			display_cfg->plane_descriptors[k].cursor.cursor_width,
-			display_cfg->plane_descriptors[k].cursor.cursor_bpp,
 
-			// output
-			&s->cursor_lines_per_chunk[k],
-			&s->cursor_bytes_per_line[k],
-			&s->cursor_bytes_per_chunk[k],
-			&s->cursor_bytes[k]);
-
-		calculate_cursor_urgent_burst_factor(
-			mode_lib->ip.cursor_buffer_size,
-			display_cfg->plane_descriptors[k].cursor.cursor_width,
-			s->cursor_bytes_per_chunk[k],
-			s->cursor_lines_per_chunk[k],
-			line_time_us,
-			mode_lib->ms.UrgLatency,
+		if (display_cfg->plane_descriptors[k].cursor.num_cursors > 0) {
+			calculate_cursor_req_attributes(
+				display_cfg->plane_descriptors[k].cursor.cursor_width,
+				display_cfg->plane_descriptors[k].cursor.cursor_bpp,
+
+				// output
+				&s->cursor_lines_per_chunk[k],
+				&s->cursor_bytes_per_line[k],
+				&s->cursor_bytes_per_chunk[k],
+				&s->cursor_bytes[k]);
+
+			calculate_cursor_urgent_burst_factor(
+				mode_lib->ip.cursor_buffer_size,
+				display_cfg->plane_descriptors[k].cursor.cursor_width,
+				s->cursor_bytes_per_chunk[k],
+				s->cursor_lines_per_chunk[k],
+				line_time_us,
+				mode_lib->ms.UrgLatency,
+
+				// output
+				&mode_lib->ms.UrgentBurstFactorCursor[k],
+				&cursor_not_enough_urgent_latency_hiding);
+		}
 
-			// output
-			&mode_lib->ms.UrgentBurstFactorCursor[k],
-			&cursor_not_enough_urgent_latency_hiding);
 		mode_lib->ms.UrgentBurstFactorCursorPre[k] = mode_lib->ms.UrgentBurstFactorCursor[k];
 
 #ifdef __DML_VBA_DEBUG__
@@ -10608,31 +10611,33 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 
 	for (k = 0; k < s->num_active_planes; ++k) {
 		bool cursor_not_enough_urgent_latency_hiding = 0;
-		double line_time_us;
+		double line_time_us = 0.0;
 
-		calculate_cursor_req_attributes(
-			display_cfg->plane_descriptors[k].cursor.cursor_width,
-			display_cfg->plane_descriptors[k].cursor.cursor_bpp,
+		line_time_us = display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_total /
+			((double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.pixel_clock_khz / 1000);
+		if (display_cfg->plane_descriptors[k].cursor.num_cursors > 0) {
+			calculate_cursor_req_attributes(
+				display_cfg->plane_descriptors[k].cursor.cursor_width,
+				display_cfg->plane_descriptors[k].cursor.cursor_bpp,
 
-			// output
-			&s->cursor_lines_per_chunk[k],
-			&s->cursor_bytes_per_line[k],
-			&s->cursor_bytes_per_chunk[k],
-			&s->cursor_bytes[k]);
-
-		line_time_us = display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_total / ((double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.pixel_clock_khz / 1000);
-
-		calculate_cursor_urgent_burst_factor(
-			mode_lib->ip.cursor_buffer_size,
-			display_cfg->plane_descriptors[k].cursor.cursor_width,
-			s->cursor_bytes_per_chunk[k],
-			s->cursor_lines_per_chunk[k],
-			line_time_us,
-			mode_lib->mp.UrgentLatency,
+				// output
+				&s->cursor_lines_per_chunk[k],
+				&s->cursor_bytes_per_line[k],
+				&s->cursor_bytes_per_chunk[k],
+				&s->cursor_bytes[k]);
+
+			calculate_cursor_urgent_burst_factor(
+				mode_lib->ip.cursor_buffer_size,
+				display_cfg->plane_descriptors[k].cursor.cursor_width,
+				s->cursor_bytes_per_chunk[k],
+				s->cursor_lines_per_chunk[k],
+				line_time_us,
+				mode_lib->mp.UrgentLatency,
 
-			// output
-			&mode_lib->mp.UrgentBurstFactorCursor[k],
-			&cursor_not_enough_urgent_latency_hiding);
+				// output
+				&mode_lib->mp.UrgentBurstFactorCursor[k],
+				&cursor_not_enough_urgent_latency_hiding);
+		}
 		mode_lib->mp.UrgentBurstFactorCursorPre[k] = mode_lib->mp.UrgentBurstFactorCursor[k];
 
 		CalculateUrgentBurstFactor(
-- 
2.37.3

