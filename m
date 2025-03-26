Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82900C36017
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 19:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E62310E779;
	Wed, 26 Mar 2025 19:53:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3TwM20qm";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD6B010E735
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 19:53:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNQy8limlQHIDrFzuO8lO1BxTgMEe4hU2Y6upSLBJvsxooXgl1FFq7egBMINo5/8TnwQtvoVqr0Yqdq6i+68eCSOv2pj7g7Y3fi6RlVSE8pQ6qZ6EMPznXUnR7QUjGPpDL7EFEonBjlvoeNUAxeaJObB+ZRPI+Csxz7nBN0/69+6gPLkdX16AMd0EJ+z5YCGn0i95GdQTc/EO80I3DO2voSMLe1mL58xL2Zu8iY+Zbz4anBcOsWxa9Zh9OQaiDHcbhD9Yk3ALsTqXrUCwlq/fiBqzY7ABwBH1JaMjWUpq3briM91oFDrQNjKWOvTOtHBx2bTmYk3FMWhZ7a0sKeyOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9C0BVFODiCtB96e64hpzE+QghufClkh93ZxlusQVrc=;
 b=bPUjQkzK5f+5hY0iL1Y4gh4E6tvJ7LnJwlU+kXU2J9c+NBSrS5nafruKzIelKAYm33ijhNTc7zAKlFx6ZqOm93GTOVsAXFSzCTqgN2r8yFJYBLETmLcVAUMC5AXeuCRKoxjd8b+rvzU+gEFQHK0m9FEy714KKwT8Fml1P5FUd48kgX4i/6UcbKpS2UX8AZ/OUH0fQ3j7gurSTM7b+jUH0TGutRc0DnvKo4LZ2lGVS4ifWOfU8O1LWfz5DMhkrUA1A0myxaOZIB/Uteg7JuV42hiW3fB3qZoWtM+XhcbKvHNzYPUcannpA3ruWanf9N0mBPnK81pZy54s3b72wEBdgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9C0BVFODiCtB96e64hpzE+QghufClkh93ZxlusQVrc=;
 b=3TwM20qmXk0dW4+xkV2iAPfklcbf5rmgyYMvPCAoWeMGyjwICL/oRFYxc+0R3QuoclDOhJaUqV5fN/NanMyL5DjmpptKGoKA1OOelKweHx0W9zRXy2lywXpj2FbruWM1fr6pOIfS3g3uZg8Q1l99qti/1vopx/v7XnuCFKkJemw=
Received: from SJ0PR13CA0159.namprd13.prod.outlook.com (2603:10b6:a03:2c7::14)
 by CY1PR12MB9651.namprd12.prod.outlook.com (2603:10b6:930:104::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 19:53:14 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::7b) by SJ0PR13CA0159.outlook.office365.com
 (2603:10b6:a03:2c7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.27 via Frontend Transport; Wed,
 26 Mar 2025 19:53:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 19:53:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 14:53:10 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Mar 2025 14:53:10 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Joshua Aberback <joshua.aberback@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 06/17] drm/amd/display: Use meaningful size for block_sequence
 array
Date: Wed, 26 Mar 2025 15:49:03 -0400
Message-ID: <20250326195202.17343-7-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326195202.17343-1-Jerry.Zuo@amd.com>
References: <20250326195202.17343-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|CY1PR12MB9651:EE_
X-MS-Office365-Filtering-Correlation-Id: 91928aa7-b7b9-4109-9e6b-08dd6c9fd84a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EHMuTyG9EcGaMwxOmqS6Kv4CiERP2IzivMj3/sSIXtbr6Cx1S94jtzLeD+ej?=
 =?us-ascii?Q?73AL6mMaK0YTL9C6iQv8+0ALb8CNXTh8y46Jlo4Po6rY1LanMplB11oZhLz7?=
 =?us-ascii?Q?KhOGv/zi9/mXB9l2Gmghi6+1RguuVBFh21kMARcGaXUTo/LaArjiVGoDlJlK?=
 =?us-ascii?Q?4nG9wUFbfcXECD4jjH4sEDu7rAyG41n06g9QLq6CpjB6BM4+8OpIl+nFexBl?=
 =?us-ascii?Q?YuYOOD7wkFY7ulv3Guh0jlBlFjb0t82/9Z7SY32QCAJGoIrUac5hpri2a3sf?=
 =?us-ascii?Q?cQvmalpNYOSLKwspFncM3HOOGTiNaA11HrrIKUZHhbijfpA/8XSAyeoU2a+o?=
 =?us-ascii?Q?Swj8UTyOwY3jW0mhCVj2xaCn8O1jBZuwoBh4gPY0amACv3eqknPU46QO9Jld?=
 =?us-ascii?Q?H66QSOMNdBsOp2OwEqQY/A6H4Kg6rDaAn3iPjnxGp8rP77VPuxvqkHUG+ea7?=
 =?us-ascii?Q?N9f1AKPZuU//6tukAIGtnVh0a6qJhR36iVssGefBjqIzLkfKsRnatS7fYtjj?=
 =?us-ascii?Q?c8f169RJ7vfeR7U6prOJPx4az+GeFCwn2xMzkk5TYEGrog28UNu50uVY4w/w?=
 =?us-ascii?Q?ObzHXsT2Ap/hwIjDBiYZwYqEI+J4+wXFFh1kQQ/4a2ddqAANIOnXIDiIAZ/r?=
 =?us-ascii?Q?JMLhxPwSCj5NtMG/i0rATGUJAgIHghyCxBJkBlIri2yHGdsrEi5CcSqPsHpl?=
 =?us-ascii?Q?RYMkJf9gvUDtg+2ut0E27wf2wn3IzfRi50LEBM39hV5gzH70a27kPqBP88++?=
 =?us-ascii?Q?3EDnFtj/X6mjRh/pYrBPaMTdpZH6QNH8OeoanUKdLJzI8qaNj2dZun6wfSo6?=
 =?us-ascii?Q?x4b2h9ivuZZRvfTtNGzR9m7pR9LfVQDQ0ZFAMiFQVSKwYswze7bG3mR4Tvqq?=
 =?us-ascii?Q?7YB/4/kq07FMVTPxzHpsLXhHH8LKwOtJRBXcpL72eYmHZDzRcwCeeDasdDdK?=
 =?us-ascii?Q?CwG/ngp6l1LjQxo1KqSE/LCcaxa+k/E2cOqoDGF/G+DhwWabGiVbizbahhOZ?=
 =?us-ascii?Q?G1Tvh/aww2zPdLw/KUfXUDtNWK6CC49tpFymRNLzfdNpsDxNG1bkIE8XbVRQ?=
 =?us-ascii?Q?kvBuQU6pGo8/VObh/9RWdAiOv8YXOHeTdcodTO9mWA6H+2kBXEXCSCYCxvBr?=
 =?us-ascii?Q?fDr9re3J5ESGxKNllCwbs3EE5XGJuOK9DO5wRuUqky68lh4U/7s+NCjpVoPw?=
 =?us-ascii?Q?CM2rPj7qbEWFQQcKDfHSAMo74aUTJOBNNSxtRhVStfdOzl63ssPLVr380q2v?=
 =?us-ascii?Q?vI5wBfUusTSc9fetr2KCz9clWeX8hQl2IeEuNsDk+LXAO03rDlTXoYYvhfTc?=
 =?us-ascii?Q?RcAv0JufWkRwsfeo4EVeU5831dzsZ1KhSt48GkILssF4S/XzLenqY4abCyEI?=
 =?us-ascii?Q?j6bd19EWykHjRG4IFe6s876/jqtiOM9pOpzXtjo5K2kU8YdmxPtt0XBhDH3z?=
 =?us-ascii?Q?1+Q0OnOt10eUjJzB3uzTJSAx/HcTNXX6sabmfY2ejceu8Qh+hzkf1RWN/Kqx?=
 =?us-ascii?Q?zxYkEbBeeq6YMjQvVkWZvTh+epS471NN/3X0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 19:53:14.0222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91928aa7-b7b9-4109-9e6b-08dd6c9fd84a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9651
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

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
This array was initially defined as size 50. There were array overflow
issues so the size was increased to 100. To ensure such issues are
avoided in the future, the size should be set based on the possible
contents instead of an arbitrary value.

[How]
 - upper bound, assume every update occurs on max number of pipes
 - define array sizes for function parameters, for static analysis

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h    | 8 ++++++--
 drivers/gpu/drm/amd/display/dc/inc/core_types.h       | 2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 55b32dfbfdd6..7014b8d000bb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -697,7 +697,7 @@ void get_fams2_visual_confirm_color(
 void hwss_build_fast_sequence(struct dc *dc,
 		struct dc_dmub_cmd *dc_dmub_cmd,
 		unsigned int dmub_cmd_count,
-		struct block_sequence block_sequence[],
+		struct block_sequence block_sequence[MAX_HWSS_BLOCK_SEQUENCE_SIZE],
 		unsigned int *num_steps,
 		struct pipe_ctx *pipe_ctx,
 		struct dc_stream_status *stream_status,
@@ -896,7 +896,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 }
 
 void hwss_execute_sequence(struct dc *dc,
-		struct block_sequence block_sequence[],
+		struct block_sequence block_sequence[MAX_HWSS_BLOCK_SEQUENCE_SIZE],
 		int num_steps)
 {
 	unsigned int i;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index c8b5ed834579..3a0795045bc6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -195,6 +195,8 @@ enum block_sequence_func {
 	DMUB_SUBVP_SAVE_SURF_ADDR,
 	HUBP_WAIT_FOR_DCC_META_PROP,
 	DMUB_FAMS2_GLOBAL_CONTROL_LOCK_FAST,
+	/* This must be the last value in this enum, add new ones above */
+	HWSS_BLOCK_SEQUENCE_FUNC_COUNT
 };
 
 struct block_sequence {
@@ -202,6 +204,8 @@ struct block_sequence {
 	enum block_sequence_func func;
 };
 
+#define MAX_HWSS_BLOCK_SEQUENCE_SIZE (HWSS_BLOCK_SEQUENCE_FUNC_COUNT * MAX_PIPES)
+
 struct hw_sequencer_funcs {
 	void (*hardware_release)(struct dc *dc);
 	/* Embedded Display Related */
@@ -534,13 +538,13 @@ void set_drr_and_clear_adjust_pending(
 		struct drr_params *params);
 
 void hwss_execute_sequence(struct dc *dc,
-		struct block_sequence block_sequence[],
+		struct block_sequence block_sequence[MAX_HWSS_BLOCK_SEQUENCE_SIZE],
 		int num_steps);
 
 void hwss_build_fast_sequence(struct dc *dc,
 		struct dc_dmub_cmd *dc_dmub_cmd,
 		unsigned int dmub_cmd_count,
-		struct block_sequence block_sequence[],
+		struct block_sequence block_sequence[MAX_HWSS_BLOCK_SEQUENCE_SIZE],
 		unsigned int *num_steps,
 		struct pipe_ctx *pipe_ctx,
 		struct dc_stream_status *stream_status,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index c1c8742d4a58..338bc240e803 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -630,7 +630,7 @@ struct dc_state {
 	 */
 	struct bw_context bw_ctx;
 
-	struct block_sequence block_sequence[100];
+	struct block_sequence block_sequence[MAX_HWSS_BLOCK_SEQUENCE_SIZE];
 	unsigned int block_sequence_steps;
 	struct dc_dmub_cmd dc_dmub_cmd[10];
 	unsigned int dmub_cmd_count;
-- 
2.43.0

