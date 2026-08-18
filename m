Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF03C5DF95
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3BCA10ECD1;
	Tue, 18 Aug 2026 20:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ouhwmcLD";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013004.outbound.protection.outlook.com
 [40.107.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1073210ECD1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSAl7P3+tTSVy+mya76vqSDPz+RefDyrd3CYjLJBqJ1ThqaflcaBKm10xkcnFG0KQ3ugrd7KE9S58NgXWg9LdLbXrQJ2usZbov5ihj+2D/vRs+QGHEiab7zyQ+9Or0Bpr8IzJF9RxN74ZQr05kTtU5mhxWp01HeuN3dbon6pyIIqoaD2BLTfIhTPkwKBzdYwTK2Ks7tL+h0LIyY+azB7RQVhN2bgrje+3k8TSf46EsZXF6D8/P05h+iWTccs6IU42wkLCL/ip2d5pDmiErgpLiOOUpB80MIRqfF2fNEK3/H8P9PcpfNXEtHlcOUIvHNfXprQPXCg3zL7ucxop2IYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LO22rFtuBdbsav7Gccf9XMtJ6kZU35u5my3jO+Y5LxA=;
 b=SJo/hLyP3w/gQO8F215kp8Tx81+ZLuhxBMyFFw0O+zo8yOcfVYz0VfdPfIZK/XRcgl4c1yr4JxGhc+KZNx0boBOrhL1QrMXNI4cGFDC3eKdZFpTR46VafCrljq7kxeSNPsKSpqz3kLeVo4B+OvG5q64Vt8MO4WRigUo9+Cs/3HltIO/tgsQc0Ejtqeo8OCP5MLaa0BzWkO3lRwGvzcKv9hWcvHhTg69cB1oaitcayUb8ynQK9sttfxgSFWZRseUOjziVoHxZvd74anPPRAzor6jAoJIse+QSbuRpZX7RcLwnKxzvvo85Lfa2ijaOeVDnpJuItcMIoLBRnZU2ZejArg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LO22rFtuBdbsav7Gccf9XMtJ6kZU35u5my3jO+Y5LxA=;
 b=ouhwmcLDJf4yeafUhUpqqo1GCIMPe200fDPk+vtbNrFcQtg3HtANMdibxtHG5lILt8HXpIycpyXRGjGZ8r75CP/E62Ikj0OgsDQAMveoatfzPMPS2L9Av8UnwdIACh3klya0xGOCk1d6/lbu4MlLIrGWQVVYVtz8oIzR49rrYaU=
Received: from BN9PR03CA0206.namprd03.prod.outlook.com (2603:10b6:408:f9::31)
 by IA0PR12MB8864.namprd12.prod.outlook.com (2603:10b6:208:485::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:54 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::94) by BN9PR03CA0206.outlook.office365.com
 (2603:10b6:408:f9::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:53 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:53 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:52 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Austin Zheng
 <Austin.Zheng@amd.com>
Subject: [PATCH 79/82] drm/amd/display: Populate vblank_nom according to
 bounding box
Date: Tue, 18 Aug 2026 16:16:11 -0400
Message-ID: <20260818202139.4172592-80-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|IA0PR12MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: 455a28ef-71b3-446b-6f34-08defd667bd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|3023799007|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0Rn7PJIlinzgM0jiuJN/UusIzCOtbWP0dInVY6u+Pz1Wl9jWaT8vYAcRvcpdsYCL97CZ1U6CRg2F0G69NBSJtTQw4MXOaG7cOcdAuQd3CPZcCQjcS8WzLL9X56vHzPvJhgSS0zIImXbtZzjFeWn0IOioGTSxTyUJ8smXgxCKiqjAf5cfW4MET+VD5OgbS816hMLOK7ZgZlYM6G4ixbUPV6HcoFOTKQG5f8jMkttMbNrkoNdR0gArJaXKqJ37qWmkFKZE/cW2sRgO1Bf88vXN60CL8iY1DLG4Lgz5+a6EojzZgppzzqc1BDX9qTeXd7EEE3ivsDuaHvdUKr7Q+reCKcJXOVHoDBkk8Up4CU5QpQil9wvsUfv/pIa21H3mZAA/oXfniOT85U4AjY7J+HSIezcEsdDgM0dzQAKFS8zMjXllPD3NZBfW+zmZCNRfV9CkiD0GoVLqig6pecXmRo5MTMXEtSGzhlaG+wx2bgJ5aSizKpfJQwZMItjUIzQIJ/KSwaaSWFl/tW7ESVGliDPL9ppP4rma6969PtCFhxuEh2WPIk0oi8qqZgyHjhhCAIQm7y6xhmS9XWa8IET6+9QZxpTglwIYT7+rfo6wgX7LLbpOzeV7X2vHPB2th8i66RxDw2yjwPiHVONjD2sUM8dQOR7DvNn6QsddQpxxh7qy5vvr2BpAMXGN+eDQbuNlv7qE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(3023799007)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N0CkZOV6J8YMfGdzd4eEijKq7BkoAIjlgqpL3kZ9s5gdFwx4rPbYdTOT69AbvVYu/FBvirOS2QOhQfOaakmb3HaHq20hOeaqMxLJfImIKqyioLmRR4yBguI+vZBY5AjPrpNQxgw0CUkTljl1/DfUZdRPb32Wolf8hU5Eqy7CH+GAmCZyScIwFnMwvMe9KmLRDMu3t/094xIitTAE2btKKxX7FwME0Wti4vUHfi8uHuSyHfa2Y6XZY1DyVYzWoZIHC3sg081BxuOWSbkbKOi8sQmdx/YG4eOmHXfrSQvH8jAjSnr6WcKzNE4M5G9C3vlGG70XW7qd/Hbm3cLOfvDnsBhMQsV2pd0X2X86/ZdCL0m/AFTcohDMxJATgBLs8qE0xKPghTNiT+O2f/3p2ec8Xoc3VbKwoOrp4mEAIZ7tBaQTORrv+4M0NkUH/IfHzABV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:53.8696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 455a28ef-71b3-446b-6f34-08defd667bd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8864
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

From: Dillon Varone <Dillon.Varone@amd.com>

[Why&How]
Wrapper currently populates the vblank nom as the entire blank for a
given timing. This should be constrained to a sane maximum but still
controlled by the caller's (wrapper) policy, which for now will be the
existing bounding box value.

Reviewed-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../dc/dml2_0/dml21/dml21_translation_helper.c  | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
index d456fb3d616d4..db78810f2b906 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
@@ -95,6 +95,20 @@ static unsigned int calc_max_hardware_v_total(const struct dc_stream_state *stre
 	return max_hw_v_total;
 }
 
+static unsigned int calc_vblank_nom_lines(const struct dc_stream_state *stream, const unsigned int default_vblank_nom_us)
+{
+	unsigned int vblank_avail = stream->timing.v_total - stream->timing.v_addressable;
+	unsigned int vblank_nom = (unsigned int)div64_u64((uint64_t)default_vblank_nom_us * 1000ULL, // vblank_nom_ns
+			div64_u64((uint64_t)stream->timing.h_total * 10000000ULL, (uint64_t)stream->timing.pix_clk_100hz)); // line_time_ns
+
+	if (vblank_avail < vblank_nom ||
+			stream->adaptive_sync_infopacket.valid ||
+			(stream->link && stream->link->replay_settings.config.replay_supported))
+		vblank_nom = vblank_avail;
+
+	return vblank_nom;
+}
+
 static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cfg *timing,
 		struct dc_stream_state *stream,
 		struct pipe_ctx *otg_master_pipe,
@@ -200,7 +214,7 @@ static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cf
 		break;
 	}
 
-	timing->vblank_nom = timing->v_total - timing->v_active;
+	timing->vblank_nom = calc_vblank_nom_lines(stream, dml_ctx->v21.dml_init.ip_caps.vblank_nom_default_us);
 }
 
 static void populate_dml21_output_config_from_stream_state(struct dml2_link_output_cfg *output,
@@ -1143,4 +1157,3 @@ void dml21_init_min_clocks_for_dc_state(struct dml2_context *in_ctx, struct dc_s
 	min_clocks->stutter_efficiency.z8_stutter_period = 100000;
 	min_clocks->zstate_support = DCN_ZSTATE_SUPPORT_ALLOW;
 }
-
-- 
2.43.0

