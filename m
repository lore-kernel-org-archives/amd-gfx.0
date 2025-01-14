Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50404C02180
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 02:10:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC7B310E83F;
	Tue, 14 Jan 2025 02:10:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dQqdJV/r";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AEE310E83C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 02:10:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyHWYcT3MD/bEBK72pICtVOqNDJmwbzhDf6mw1lvcCT/fQnzJ5nk0gLEjSZPHu6cJPAWgg0Q8b6tjTuVKPAuuQd3nifM7fO/l9JVuqyncUdUR7S4Ff2hkvayJ2NgwlBgvnyQkeinKr+Egerwq8ddFTocATVW+BpgcQ8QgHzfMq6m8kFhbBSwKCthpUFn5wK2YUQGjhcaGyqcQcOqv0ZyvNAnCV1FjwdcyYOHL8gmUrefYpKw9daSL640c4+mI4OZDvX/SU/WUMysH6n/8+u/VCWiJgn1QzYRVviusCsn7xrxLbaUiV2XdooEFyx/ub8Hn7/MVB9v/R4Jn80sezHv8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLvSdhEKNQ+Wug6XqfgIn1b9kwjQyeYLsiQCBU5vtpQ=;
 b=S5HR58wv13XOShAc6/Imj9etHXWZOzmVyr/I8AZuxw3VvifdTjwURkf2y3Xja7R0NxjHLK7vS+/OAXlJT0lcMgOg0Ky5GhzzRhMc3weqIx5rj8eJb19u2v1ZovOL/gyhQJ3udje6Jhgvb1qKnlmYJ7pWHE9BDgbC1cFGYPBmyR/VAY2gxy7O4ZkWSa07ofEqOUj00gRnJimsHSohV3jEQQeL5QLLF/QQPROyj7W5NptIWH/memsyECBQb3SP01mbqW3M5y+HNBYE8pX6vUcCaA/95b3h17qCqy+Zrq2ZEkwwYfClGUZBwxp8dvidzO1N9aFzl/WN+T8UarAxIM0OSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLvSdhEKNQ+Wug6XqfgIn1b9kwjQyeYLsiQCBU5vtpQ=;
 b=dQqdJV/roYH7HrwQj/sLfc9+0umO5mipC87ucD0onMSwbL4c2EZp0q7yWLYxPDnjrg2XD6TA9hPk9oKSXr8ojAu+B/qmfANsh61ZFMv8Q3+0H1+AzBT1XXkOiSIfjwujNlg1BoLtEyw8W8Uw0Oqtb/rv4w0csXqI5lVPq0A7Vao=
Received: from BL0PR0102CA0038.prod.exchangelabs.com (2603:10b6:208:25::15) by
 DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.18; Tue, 14 Jan 2025 02:09:59 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::77) by BL0PR0102CA0038.outlook.office365.com
 (2603:10b6:208:25::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Tue,
 14 Jan 2025 02:10:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 02:09:59 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 13 Jan
 2025 20:09:55 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 13 Jan 2025 20:09:34 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ian Chen
 <ian.chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 03/11] drm/amd/display: Add AS SDP programming for UHBR link
 rate.
Date: Tue, 14 Jan 2025 10:08:52 +0800
Message-ID: <20250114020900.3804152-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250114020900.3804152-1-Wayne.Lin@amd.com>
References: <20250114020900.3804152-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f3a854-71bd-449e-6932-08dd34408c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jws94su1vJpsazefHApeP4HxhtAY9T4hpuFrb0+odfxzeQRmdVuyLYzYFQDj?=
 =?us-ascii?Q?cM4d8qOceF7uz3W3kBq6ucRfDKz91uFbKaZUkSje3g4TMMIS3BsUbxUYo1zq?=
 =?us-ascii?Q?4sy7qDoYi1KurXnkXTzdgWbtHq5Xom1T+C9KELfFLKbd5l5VaxM2XpDIn6En?=
 =?us-ascii?Q?CWDvHpfxcPFFBV9vHtNLgP1a5riR1o9fZFxec8Jef6D87uHsB0teABJe7BsR?=
 =?us-ascii?Q?Xfomhs8aVKcdMR3S7q/JTTS+pEWCU05sK/EmjCSRzeNV/oIIzU32NEUI0k9q?=
 =?us-ascii?Q?V6foGWJMrQBzAY2Wkkx5QsLkQjWAYiq/j7Rc6U5RbnLopcjh8sz8nqMqBcqZ?=
 =?us-ascii?Q?aWbeFa0kSGmYbd7wJYb5uZuiCgp2IQ6oyj5TjtNvCBlknr4AQ8QuOPGvSj8t?=
 =?us-ascii?Q?ykBtonM8Pz28cckE350MAQjIL6FIuEOh4qTgKNCnjTWla/axNMNIpfj8pQgk?=
 =?us-ascii?Q?ZZH3JTbdBSsR+Blput8h9rKoDRnCZzRB+mWEBHHx4Q7qIYxFBwIvuWMfNx2A?=
 =?us-ascii?Q?3F9Ts1pIgsqMmDhfWSTZSfLErxYTpzu64860lBNGGW8i9p2J7t5CLYvck0Uo?=
 =?us-ascii?Q?HyXja7kFSjzEy6D3xOOIw+5yVg5p2EqGb/HaLWKn4ApJMV3VSjkFCQnmqjUz?=
 =?us-ascii?Q?KRDWL6LATo4zuLuDL9ZSmCRSUBNdQG0vCF845yjNdxaQ3A20epMZppzMbfRI?=
 =?us-ascii?Q?9zVGvVP95YBbM/wpMGIYsgdSRE6b9wKuj5gBXzQX4vtZ7beQMl0v6TQTpHTI?=
 =?us-ascii?Q?EXmpDxQs8NMzlsW20mZhA2fLW29ClZ+j2D3Wd80fHrk0FglM2KEdlXWjfxiP?=
 =?us-ascii?Q?Dv4wz9m7XA9zG9YYjbiFw49uL/es+6VPu8fCNm1U/3UgZuPYKhdClVn+qOqC?=
 =?us-ascii?Q?Hk6f0+TYPpWYQE7q6FOvowgbfcavWW/ICf3iGseUaUln5UTp1pykYLWD7PXa?=
 =?us-ascii?Q?OPsxzqc4q66U6dfY+w/aN6v+gteVsQ3FJsukozMBJp+yB4/VtA3NPaUcRJRU?=
 =?us-ascii?Q?IqtHQnyO05bRA6bk1JmV+yXYd4EbUVg95e83umgHFzrWSSUeZu+D1B8hDOkH?=
 =?us-ascii?Q?tYOjYoq88kpj7JDGYAdu+vqCFYx30RtY/NoG5v4GTnnDwCLvG/YVRdJl8fdB?=
 =?us-ascii?Q?AgEK13uXC9mW37q4jl+BtLJEMq93GF1kASfuVDYa/CbEQCiWUKGTOk/KZ6sr?=
 =?us-ascii?Q?KXBt1hyOBsdAADmv52gAXMHn1Fj5dxoajaC9yTovN5LmLBoci3eYZe3CuQaX?=
 =?us-ascii?Q?ZjjLmV9ZCVWQuEEQc608Xtx6fWEtkyl5rPq2aSTGtm25jhP7PGFeahqAqnpz?=
 =?us-ascii?Q?UyuYTtco5mn0RPEMvenTS3JJ6qghvwCrTR/IHVKtcQlPRBFTRsDHPXIIkHr/?=
 =?us-ascii?Q?G8AqKqSF9QLZTpTmjQ4um4otTVccyc2+gtCzmOS2vbWFWLGnRu99r9MnW/aP?=
 =?us-ascii?Q?7DZzwmV5lgpOSuzwQ/29CztolYOOLAL5dmi5VR1LNn+WhcldbN4a46Mbcv4e?=
 =?us-ascii?Q?4BXZJur8CS/f/Cs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 02:09:59.0952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f3a854-71bd-449e-6932-08dd34408c3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207
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

From: Ian Chen <ian.chen@amd.com>

Add SDP programming for UHB link as well.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Ian Chen <ian.chen@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 03ba01f4ace1..f698062f1e90 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -396,6 +396,11 @@ void dcn31_update_info_frame(struct pipe_ctx *pipe_ctx)
 			pipe_ctx->stream_res.stream_enc,
 			&pipe_ctx->stream_res.encoder_info_frame);
 	else if (pipe_ctx->stream->ctx->dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
+		if (pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->update_dp_info_packets_sdp_line_num)
+			pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->update_dp_info_packets_sdp_line_num(
+				pipe_ctx->stream_res.hpo_dp_stream_enc,
+				&pipe_ctx->stream_res.encoder_info_frame);
+
 		pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->update_dp_info_packets(
 				pipe_ctx->stream_res.hpo_dp_stream_enc,
 				&pipe_ctx->stream_res.encoder_info_frame);
-- 
2.37.3

