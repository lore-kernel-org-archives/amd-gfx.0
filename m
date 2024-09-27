Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5147DCDD1D0
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 17:01:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE64910ECF3;
	Fri, 27 Sep 2024 17:01:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dyxX0ZAQ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3196610ECF0
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 17:01:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SncEUWDXEG3xI/WUAj8EFL6ExTRmOFeArUkk7hw+MbSOU6iAfwh84RdzLL+Vgc9hJl98h0nDPTeM4705jDePXvDzq93ZmVEtlU3oHqgtUpG/DZa49xUK8vgjTkob04e/RFfCh7ewrzn9ROqWvhCskqiF5zv1t+EQqcyQd9e82Ag48u3ok8pn3stY+czBe8kbVcxMJNN57XGT4KfFRG+2UScGBaz8/TJwnscK1OFMwlVP3zJF5IC/uKbq1yfjF3Elz4IkHoiiWz3ymSB/CEZw6NedpCfYk/Dg9SObmFOI20EoiLwbM7P4P1Nxl1olyuf3YNuqSfjF/HQurvhT0sZhzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuI1ssIBImGsWvmQXxDSOoplOnmAiKWTbej3hLBpYFo=;
 b=UMxa9htnwXIWC7qxxWq5S518Sz5Gfj8wBapvveSACHsopiBqzPCLYWkHIm1y4P35n6Dw5FzHhfRhSvhMxP/wwEpzScHe4nzKClCjWaw392C/RZTyiKKIFhlszc9So29gIenF1xjZa08UEGRhiuM7TINCPM9ZaDVDOj1PNIteCs16AQVrNYMGv4peAWe1FSBlr+tz0Vx+ZQEga6E0vlCaT5e3NNtkuk3o1unFquUzEDj+oLaQ4WqVbKhq6yz4lYZ7W1MeqVhomY3CA3HACnrcYRctdS7b7R+sEwol2mxbfQDcQYmvCQY24xFr8ZnuptiNdlkwPYAO2wQHkWUtuToppg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuI1ssIBImGsWvmQXxDSOoplOnmAiKWTbej3hLBpYFo=;
 b=dyxX0ZAQDAzA0cEmhSg98uTmEIkUg8Gp9zIJ2HlkDP1SWCmOGixeHO6I5TUCDenkEiE4iz2UQzxWTtAUKYxcU3fj9hvTP7jcNNgELgoYHhXbzij5ZBdpiowQ92qsM+SlQwi62fLQalgwHLP29nRe3WIyPZN6V18iCPEAzzUQN1E=
Received: from CH5PR05CA0007.namprd05.prod.outlook.com (2603:10b6:610:1f0::12)
 by IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 17:01:47 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::e0) by CH5PR05CA0007.outlook.office365.com
 (2603:10b6:610:1f0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.8 via Frontend
 Transport; Fri, 27 Sep 2024 17:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 17:01:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 12:01:45 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 12:01:44 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 07/13] drm/amd/display: Remove always-false branches
Date: Fri, 27 Sep 2024 13:00:57 -0400
Message-ID: <20240927170103.102180-8-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927170103.102180-1-Jerry.Zuo@amd.com>
References: <20240927170103.102180-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|IA1PR12MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: ceffb7e8-f991-42ee-e000-08dcdf161260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XEgmF3AhE6H2ne6p4sdcbdpK74K2o36/FD3LhJP/BpdinUafBZKkL1dScqZ6?=
 =?us-ascii?Q?fkJIZrQq/Vh1pWXVTjGxYVjfsbNHaMv4MEkuQy+gsfDEUXs39p+RI3Vw1Ebg?=
 =?us-ascii?Q?HPFE0H+SfKx1DEFZpMKSNGnTF2Zy4xyhxwGqQOM37Nr7opFzDm7r+I2eB79s?=
 =?us-ascii?Q?NTNOOMhlrYqS1GhhyO3k/OnAMr3EqGjqwzd5XBVOWVkxHwnoSxqv74l7qXq9?=
 =?us-ascii?Q?4BvyFOQJjf42SJn5jkc3jRGMqVnL9P2HD9Ac6LYN0qm/egmhGy8pEkVZESSb?=
 =?us-ascii?Q?BiZjqft+WNJVHOcyUjak5Q2i9gTmEUa+fIcgeh85l0gqp9E8uXkkQ9HN+zDE?=
 =?us-ascii?Q?eH6Fxd3E3cjmgdYFOczi8Uz51aPWETldDwbdnz4Fa+GOyb6m4AXTt81W4T9D?=
 =?us-ascii?Q?O0w0h+BiT+/7JPlkbIPnLe2neCFr2JTvqs/0OmU8g96ivJeejxKGtT6rKD/s?=
 =?us-ascii?Q?6z+KzYfDcIiqlMLQ0wlk/u5dMPvqtuUR+xoWmZUDTXn4VNO9c/4eNkAAJRNU?=
 =?us-ascii?Q?SyxTRvXir1OZ/NZ7qw63C7go1ar0EIcWVZ5poqpaxBrcLtLiTl/Ftb4nfpPB?=
 =?us-ascii?Q?I3I7nyqT4flbMBPObhoT5ZYrYZGLGW+OLmTM9ajCwiuudXax5UUzPoMvCh+S?=
 =?us-ascii?Q?Bn+yaH+TtdsDkOfT5yTpt1EpkjQrVqWxNmeHpJeXM7pAw6cgA7HnjMlgld0F?=
 =?us-ascii?Q?UUi/bG4e7DSSHLUKdpJFJRJseJHd3eej0+2awG4Es6xOacNG9Pjk0z+T0U0S?=
 =?us-ascii?Q?1ktPgQjY8Se88PW0xM/ZHHQ/CQWOP3cBuQSOUy8K4rK/NuLme3AkfakmJkiw?=
 =?us-ascii?Q?xGO3fr9sgdfPYIS/ioHE3MDRsN/mWAOBAkSkbDxzBRLUnq7A5O2zo4gjqEUW?=
 =?us-ascii?Q?E5H2pmODrJ4RUWTv493zAL3OYRNLokiZLnMNcqeleYOTOrEsK3SLpppBLB+3?=
 =?us-ascii?Q?s8PbyoAR+/UDd9TJiSztX9PoHqMdBi0bCONztCZWLlabBkdB3xAsii83Yxcp?=
 =?us-ascii?Q?iNK37F1NxUrblrZAGcLldkkdp6AMAqiUmCaYRegaC6NGUSAj0nkQ6xa612mW?=
 =?us-ascii?Q?bV0M9HcZRJAIKHkdRUUBcSwfLeUXsKAYN9idDdZRkEtz1kwQC/lVJ+NxFfg/?=
 =?us-ascii?Q?ckIRokxIwPwO/GeWw1pLYqWPpRde2zK2IJvgRQBIvvvV1yYUFQdvSvoWZAD6?=
 =?us-ascii?Q?ZErAczKJg5HG/HeePaNn969WQbQA7QKaJiRaVTLTB/DksxzY911jwHAYHikG?=
 =?us-ascii?Q?btLGQF5yCM/ZYj8GP8o2lDs6hgxwSiDJRMDbVJlMniSBdlJAQRw0qEJUzEFG?=
 =?us-ascii?Q?PbQk3xI4MFfeIrtIjHXNgJCBIwvd+vXpTEmgf3xtqj96gFeDFpQldvfGPwUZ?=
 =?us-ascii?Q?LlIpBsQ+Zj0uiMUUXrG8iyBVhntF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 17:01:46.9599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ceffb7e8-f991-42ee-e000-08dcdf161260
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8405
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

From: Alex Hung <alex.hung@amd.com>

[WHAT & HOW]
MacroTileSizeBytes is set to either 256 or 65535 and it is never
4096. Its branch is not taken, and should be removed. Similarly,
mode_422 is always 0 and thus ppe will always be 1. The ternary
operator should be removed.

This fixes 2 DEADCODE issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c   | 9 ---------
 .../drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c    | 3 +--
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 1c10ba4dcdde..4822fad6ce3a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -1775,15 +1775,6 @@ static unsigned int CalculateVMAndRowBytes(
 		*PixelPTEReqWidth = 32768.0 / BytePerPixel;
 		*PTERequestSize = 64;
 		FractionOfPTEReturnDrop = 0;
-	} else if (MacroTileSizeBytes == 4096) {
-		PixelPTEReqHeightPTEs = 1;
-		*PixelPTEReqHeight = MacroTileHeight;
-		*PixelPTEReqWidth = 8 * *MacroTileWidth;
-		*PTERequestSize = 64;
-		if (ScanDirection != dm_vert)
-			FractionOfPTEReturnDrop = 0;
-		else
-			FractionOfPTEReturnDrop = 7.0 / 8;
 	} else if (GPUVMMinPageSize == 4 && MacroTileSizeBytes > 4096) {
 		PixelPTEReqHeightPTEs = 16;
 		*PixelPTEReqHeight = 16 * BlockHeight256Bytes;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
index d8bfc85e5dcd..88dc2b97e7bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c
@@ -559,12 +559,11 @@ static void get_surf_rq_param(
 		const struct _vcs_dpi_display_pipe_source_params_st *pipe_src_param,
 		bool is_chroma)
 {
-	bool mode_422 = 0;
 	unsigned int vp_width = 0;
 	unsigned int vp_height = 0;
 	unsigned int data_pitch = 0;
 	unsigned int meta_pitch = 0;
-	unsigned int ppe = mode_422 ? 2 : 1;
+	unsigned int ppe = 1;
 	bool surf_linear;
 	bool surf_vert;
 	unsigned int bytes_per_element;
-- 
2.34.1

