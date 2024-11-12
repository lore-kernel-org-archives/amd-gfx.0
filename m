Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEC7D41D51
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 19:58:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAF7210E63B;
	Tue, 12 Nov 2024 19:58:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sr5cYZ+m";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BC8A10E63B
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 19:58:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ixrf62QoMM7P2ef4JivFL6u6+g4qnlLaYZBmKR7L85u7780YzmjU2+B4nYBEUYd5etlh2XOr/RHua1IPp87YE6soroG7F57pkH2GoCeXq/3hLeFcWtJ0I0gzWaf1hFFXQe2DDJ5R6BLT5o9jeFF3bKUGWfBupWoO+bZTd1wdMKaJ2LDMWS6Wk3Z8NRSEq2UnxmptDKO1usaFf4jrSBJfClk1Pr1hOshAeski6fsq5EuIU+PlMXqAIPnxUfSvkJRYp+wBl9rDOYXhp8bDNq339u6yYXSsmTqrb2TaEQmyvllK323mqpWSZU/cUEpH/THhPAUrhCDnA+gWSgpZ/jpWQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMxV7ru+th1VeZ9oXEiujJWuZXztF6W4kTF5gmg/LXg=;
 b=OC8z21TkIS9kIic3lS0r7AM4O4KlY2NcRdiFAfP5ujZBiv8Qe6ebPm7JMCE0RXNerwht/6OQDJlKenyyYIKCkqIu2Zk6PjCLW3NNFM5X288u7BFZaLdsKuoBJkLDugJigYMtBZr2SH5XBtWGJJPYxyQ7x1Zn7Or5NrrP6AwB2IRmbUaN4l8+sPUEJqQ+e35DG0HwBWpj1GFMXvJnEpkDO47iJ2FithfNiCCq63aRt5eBuGJyAivocPZ25rlVrbFWDr2y3LIZhT4VXJbBaDIHBnMg5K5ZDIDVFVkRE821ZA9IIoNq/uq5LWOQeqQEor89huiXEKDm+lBMYujiKIbXPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMxV7ru+th1VeZ9oXEiujJWuZXztF6W4kTF5gmg/LXg=;
 b=Sr5cYZ+m/3WoNQtyZyK1s+PXTKk4L22tK1yfec8ci2Ac/I5CfINLANsdoPhFf6lct/FxkBzsF27ARhvA5bwcQ9TDBbhK+EOLZgmtwzFK3CE141m+ni2emtQYVxSbIw3gRUakSpAGnOAtOUfAoA+/Sub3K6ogdi9Qtn0+BG/JG1A=
Received: from MW4PR03CA0298.namprd03.prod.outlook.com (2603:10b6:303:b5::33)
 by PH0PR12MB8100.namprd12.prod.outlook.com (2603:10b6:510:29b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 19:58:24 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:303:b5:cafe::7d) by MW4PR03CA0298.outlook.office365.com
 (2603:10b6:303:b5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Tue, 12 Nov 2024 19:58:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.1 via Frontend Transport; Tue, 12 Nov 2024 19:58:23 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 13:58:20 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Samson Tam <Samson.Tam@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 5/9] drm/amd/display: add public taps API in SPL
Date: Tue, 12 Nov 2024 14:56:00 -0500
Message-ID: <20241112195752.127546-6-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241112195752.127546-1-hamza.mahfooz@amd.com>
References: <20241112195752.127546-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|PH0PR12MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: ef955793-0d49-4d7b-99f9-08dd03545d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cs3p+Tw7XrECJUbW2FfkKy2jdL9WocAMKiAW53xIWsjCpHHptnkJhHD6lzzG?=
 =?us-ascii?Q?kn/r6bip0LXAQF8x/gbczac2jtxwKFNMqySuUN9HcG4HDcOWkB5K///07KmF?=
 =?us-ascii?Q?82JFLWzxgcbBnocLjsejN8b6juYpuwparXvioBeenl7rYAM4VA8YhCyK+Ee0?=
 =?us-ascii?Q?wB9W1J5yd13UWVWD9f+8bO9kmJTAt916ipGqPVvdKK8VGd5bQ2KZBSG3VqKe?=
 =?us-ascii?Q?697PsLLkdaFxtfzZWGP5E010g5Ub4dAeaFjN1YWXm0lNcfea6rFegV390HwZ?=
 =?us-ascii?Q?3oyP/3e5H9LRKMtXD9mkInEd2eSv9PKzA5dzJGhSqY2Mc5MdG/T2gtkvki6W?=
 =?us-ascii?Q?E2VjQCykQ114vIReImE9kFrycrju5J7lLOFB5rgVlyta24+0Ps66/12fCoxs?=
 =?us-ascii?Q?sCovpicqz3WgrydMzz+YEJDNeHc7/OUhhvgMqUPnUFVeDvixrx+Mo6Ml8nmr?=
 =?us-ascii?Q?lpVSVPYof9PY2+6JlobpHEvYOo9L9sz0+6Wjp1HUC9ihdhM1KBDPF+DRGon9?=
 =?us-ascii?Q?f0R6tnWRjYhj3w0OnSRT7H3rFgZEsnKzvb9bVcX6TN3Foy7UXU4NlGi1FtSU?=
 =?us-ascii?Q?HZZwTZFdhrVDZBlYWFFl45OUufPRHReURy1Y5QqwlEVHi2N39Y3o2kQ6XfEd?=
 =?us-ascii?Q?eG8BOYjuTaE/OdSYQcOKtsacGZPR9N6hOC4v3MU2QnjOBUv7kruN1Ho6MKEQ?=
 =?us-ascii?Q?UkvYp+2fSMy+83TdQeUEFE6aj5rtx4F+KXwyM9Sm7mU4Z+vKdWuyqTNwdoRn?=
 =?us-ascii?Q?DF/Yz6tsiGQ4aXtIWYlmmYBViBAIt+MWx04P9LUBvW2bUUhbGFCxKDBP2qHI?=
 =?us-ascii?Q?lksScLwYzRdE5GCdkxZ763sBPXCTDF0bkHjf3CKcvY/w/UWAFY1nxXuK7Bn1?=
 =?us-ascii?Q?zfXjczOBfiFjI8ysxCLgXBM08dfUtDQbtI/QHvWqVTd0zgTzfNCHRJOm8y7r?=
 =?us-ascii?Q?eT87F+M2wbiEDgQNjmjUqFws5lrzA/7QwuNFnTH33q7ywb9AxR/dWitX4XkL?=
 =?us-ascii?Q?hwASNCWFqYABZR9BGpCZZRTzotQGMsoqBl2Z2DwJGp27RzDJjXu7/9zarU3N?=
 =?us-ascii?Q?f8+/owODnQ1PnxTL99HYqaBIcJGr8/mwvPfZVtP6lklq0ltWs//pM1fkxNnZ?=
 =?us-ascii?Q?4ZT1b4Ea4awYHc+Aousc1IEju71NF6r7128AKuu4lClfT387KYEDLMZcou+C?=
 =?us-ascii?Q?Q4u5NC2rel/C/Pn9CbCgZxHfufSKZUcRoyIpZarzWBTqpJVmEpuK7ayz/89D?=
 =?us-ascii?Q?wJE+DPNYIc2UXzec8gE2cwfKVyezqw/pLkKOlTnUbq8njYAjmwgbJaZLS8mB?=
 =?us-ascii?Q?l+QusB1hAlLE3+6HHHtlNqtwmeU88ILBXi7sPMOLXN3gf0QDZNNrMeSs7Jvo?=
 =?us-ascii?Q?9XJEv8/EElt9p0AdfN3YHxtBBR2b/KfOO8ERlMGYIwLqvWUicg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 19:58:23.3694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef955793-0d49-4d7b-99f9-08dd03545d6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8100
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

From: Samson Tam <Samson.Tam@amd.com>

[Why]
Add public API to obtain number of taps in SPL.

[How]
Isolate function to calculate recout, ratios and viewport before
calculating taps. Call function in both public taps API call and private
scaling call.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c | 63 +++++++++++++++------
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.h |  2 +
 2 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index 614276200aa0..da477406a4b7 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -99,7 +99,7 @@ static struct spl_rect calculate_plane_rec_in_timing_active(
 	 *
 	 * recout_x = 128 + round(plane_x * 2304 / 1920)
 	 * recout_w = 128 + round((plane_x + plane_w) * 2304 / 1920) - recout_x
-	 * recout_y = 0 + round(plane_y * 1440 / 1280)
+	 * recout_y = 0 + round(plane_y * 1440 / 1200)
 	 * recout_h = 0 + round((plane_y + plane_h) * 1440 / 1200) - recout_y
 	 *
 	 * NOTE: fixed point division is not error free. To reduce errors
@@ -1746,6 +1746,32 @@ static void spl_set_isharp_data(struct dscl_prog_data *dscl_prog_data,
 	spl_set_blur_scale_data(dscl_prog_data, data);
 }
 
+/* Calculate recout, scaling ratio, and viewport, then get optimal number of taps */
+static bool spl_calculate_number_of_taps(struct spl_in *spl_in, struct spl_scratch *spl_scratch, struct spl_out *spl_out,
+	bool *enable_easf_v, bool *enable_easf_h, bool *enable_isharp)
+{
+	bool res = false;
+
+	memset(spl_scratch, 0, sizeof(struct spl_scratch));
+	spl_scratch->scl_data.h_active = spl_in->h_active;
+	spl_scratch->scl_data.v_active = spl_in->v_active;
+
+	// All SPL calls
+	/* recout calculation */
+	/* depends on h_active */
+	spl_calculate_recout(spl_in, spl_scratch, spl_out);
+	/* depends on pixel format */
+	spl_calculate_scaling_ratios(spl_in, spl_scratch, spl_out);
+	/* depends on scaling ratios and recout, does not calculate offset yet */
+	spl_calculate_viewport_size(spl_in, spl_scratch);
+
+	res = spl_get_optimal_number_of_taps(
+			  spl_in->basic_out.max_downscale_src_width, spl_in,
+			  spl_scratch, &spl_in->scaling_quality, enable_easf_v,
+			  enable_easf_h, enable_isharp);
+	return res;
+}
+
 /* Calculate scaler parameters */
 bool spl_calculate_scaler_params(struct spl_in *spl_in, struct spl_out *spl_out)
 {
@@ -1760,23 +1786,9 @@ bool spl_calculate_scaler_params(struct spl_in *spl_in, struct spl_out *spl_out)
 	bool enable_isharp = false;
 	const struct spl_scaler_data *data = &spl_scratch.scl_data;
 
-	memset(&spl_scratch, 0, sizeof(struct spl_scratch));
-	spl_scratch.scl_data.h_active = spl_in->h_active;
-	spl_scratch.scl_data.v_active = spl_in->v_active;
-
-	// All SPL calls
-	/* recout calculation */
-	/* depends on h_active */
-	spl_calculate_recout(spl_in, &spl_scratch, spl_out);
-	/* depends on pixel format */
-	spl_calculate_scaling_ratios(spl_in, &spl_scratch, spl_out);
-	/* depends on scaling ratios and recout, does not calculate offset yet */
-	spl_calculate_viewport_size(spl_in, &spl_scratch);
+	res = spl_calculate_number_of_taps(spl_in, &spl_scratch, spl_out,
+		&enable_easf_v, &enable_easf_h, &enable_isharp);
 
-	res = spl_get_optimal_number_of_taps(
-			  spl_in->basic_out.max_downscale_src_width, spl_in,
-			  &spl_scratch, &spl_in->scaling_quality, &enable_easf_v,
-			  &enable_easf_h, &enable_isharp);
 	/*
 	 * Depends on recout, scaling ratios, h_active and taps
 	 * May need to re-check lb size after this in some obscure scenario
@@ -1824,3 +1836,20 @@ bool spl_calculate_scaler_params(struct spl_in *spl_in, struct spl_out *spl_out)
 
 	return res;
 }
+
+/* External interface to get number of taps only */
+bool spl_get_number_of_taps(struct spl_in *spl_in, struct spl_out *spl_out)
+{
+	bool res = false;
+	bool enable_easf_v = false;
+	bool enable_easf_h = false;
+	bool enable_isharp = false;
+	struct spl_scratch spl_scratch;
+	struct dscl_prog_data *dscl_prog_data = spl_out->dscl_prog_data;
+	const struct spl_scaler_data *data = &spl_scratch.scl_data;
+
+	res = spl_calculate_number_of_taps(spl_in, &spl_scratch, spl_out,
+		&enable_easf_v, &enable_easf_h, &enable_isharp);
+	spl_set_taps_data(dscl_prog_data, data);
+	return res;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.h b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.h
index 205e59a2a8ee..02a2d6725ed5 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.h
@@ -13,4 +13,6 @@
 
 bool spl_calculate_scaler_params(struct spl_in *spl_in, struct spl_out *spl_out);
 
+bool spl_get_number_of_taps(struct spl_in *spl_in, struct spl_out *spl_out);
+
 #endif /* __DC_SPL_H__ */
-- 
2.46.1

