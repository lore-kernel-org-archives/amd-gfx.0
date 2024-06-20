Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3108C27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C22710EB21;
	Thu, 20 Jun 2024 16:20:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mNfywI9S";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 426B410EB1F
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:20:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/c+O3x77Hlz2h3I5fRo4A7ZT1TcOT5cymV936Nd2JR5++NOv6azHEbgO1i3kZPwdB5OyRcQ+uU/iCHhNCWbQbwN9jf9Y/nX1SE9a8cIGIXLXK21qCgak8h8bkTEdapqmZmIjKqYnC0Q4mYK9haVw0vwS/O7kNkf7po0ZZPoliL3cp2/BxLuNQaoijCSCp2OISrHyezXFBqIzO+3YLEzjJN6+F/BH3lIZF528oj+XFgiUhODSMgQQwrBd9xbUy6xi8Eh2bffFY7B6UH7QVCq7J17O8qXsjyw7DYQ+PE5crNKcjBjLrR0HZbAH8ZDZbqlH7xTFuUKaaC22vJ6ahhCMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HslNWqWLjqeILSf7aCXI1d+Chy0lHRw08obtjzBpqWI=;
 b=QBgPb2GOXAg5RLennX0yWg9LKJ6YED+cPpfNXv+UqjEwFf/NyLUDaQTG2pSZPibNm3BcZ2Rq8R4TMaLFuxl/qrVjxi5bTPdLJBff54dlaYlPpUUt6VMgXaAE694GLdXsfD75rysdUpadeGa1g1e+jr45UiVZ6Rt+O9IOMv27OTxZQe8KiO3GGs2rvRw8TghOAFmdW2gVFFfYcPV2h58KIYYGKLcCi+EvywV31PwXa7utM9PA/I0Ez8sC2BgJA2K1pu+IEV8jBUrlYKHNGr0rWoQizRIVbWZ0QdFPjYvs57V5sc6D6G59NyznisVv9WqaH6izg3IyKkHecap+ys6zKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HslNWqWLjqeILSf7aCXI1d+Chy0lHRw08obtjzBpqWI=;
 b=mNfywI9Sp96+lq4cYdZPc6oB0uVsbXJkN033uvXpiqZbLTxHMtdAac7cfQ+XNvjaIiqWVEoHQ9Zv98gR2idZHI7IVRyxmKfq9/ya0Q50n0TLjAnS3ihmIkJ2UfHlCw7kuAWkMzZ7TJvZ72MiVHGarmQeS0JToVhlvNvI6B86Zyo=
Received: from CH2PR15CA0001.namprd15.prod.outlook.com (2603:10b6:610:51::11)
 by DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 16:20:05 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::8f) by CH2PR15CA0001.outlook.office365.com
 (2603:10b6:610:51::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 16:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:20:05 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:20:03 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 33/39] drm/amd/display: Ensure curve to hw translation succeed
Date: Thu, 20 Jun 2024 10:11:39 -0600
Message-ID: <20240620161145.2489774-34-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|DM6PR12MB4188:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cfe6178-836c-4317-72ec-08dc9144d89e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|82310400023|376011|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AzSISENrhzUp0dvN2kXlfpOTUdgSSrZ/qpKKJkDdj/JFcTn5GCykVwYVTHrC?=
 =?us-ascii?Q?xOqIuGc39tYJvWmi/D9sliZDdFsUNIL73RY/Q1VskzWw3grtE71G4A2RaUKD?=
 =?us-ascii?Q?A7iIJx/qbBSLYHE5T2ROJt3nZAyYRjQwdGvzN0B3GQ1PVWGufEfZPj0L3Svn?=
 =?us-ascii?Q?NwnmQg3Yaaw2VOb/T6l8qX8jUIyWT6cWO9b9C9wxpraULdkGpwlv4YTBQkg2?=
 =?us-ascii?Q?6Mle5kN/JpKFo3movTxxcDObxN0q5cBef2CHsuXaIc1F7/npTYW4s/J9brYJ?=
 =?us-ascii?Q?X0p1ToRrZTiv4Sy4e/yp2uv4w0yuihjKXZm0r5+qCRyx4DLqSolRTcB/J+US?=
 =?us-ascii?Q?EMsyUxoOcRuIZVvP2bqwnURGtHDmYp36oV1O2NvVVyzB10W8zV6LxGq3rIFt?=
 =?us-ascii?Q?tfUYSaYtpMVTkE8h7DrynfsMFLIuMQov28lctAuR6eHUnpHbJ7mKYzGbdLpo?=
 =?us-ascii?Q?a/ojd1SS274gXpdzzKhHNNUiD4UcSGva/tbr7ZXcOxWwvW5u9hDhrTQwd+UX?=
 =?us-ascii?Q?c7r8CG7y2qEpwUY/dK1mQCFefQwfrCcPXbruQuD02Lh7LHYnLZ52kQDdO0us?=
 =?us-ascii?Q?6GDj5xHTCh8alJwLVsk5Kw/dznh1aa6PjCXDLyugpxaNKI/SinO1Nlj/DwqV?=
 =?us-ascii?Q?UYoXmil6zluKwnfCIxt2WeGZjURl5fYjD1MLZF5mUsUTfEwgp2wthkCapgge?=
 =?us-ascii?Q?iyHpkkyxR7Nt9ZJbXySXdL3QGZ/IXdImru6w7DLzk1INq9NnAk2uIh9Ip+th?=
 =?us-ascii?Q?aFLUSxyJ1z6qsvv+Z5NSeqgZBT2ofiSIywbwJ+SXKIZMEsUtyBMLq/Aqqods?=
 =?us-ascii?Q?AJO+iuIfdb57IaqXwPonFkhUtW0AqG5PFJiSOXfcyIsqSoFQm5H16lxkAFD4?=
 =?us-ascii?Q?j1y0fB82X0ZWAqiiOl+5vmSK1BxVGPr0yJdnAmsU0pphinhT0KWQBKqmqsrg?=
 =?us-ascii?Q?YfKeFTc75Lwh23N3uQE88prTdJPhBieWeu1EcIo4Et9e/9r9tuNg4sOoTNqB?=
 =?us-ascii?Q?aWIO53twAoSujt+VnIJV0UoUSMU7lGfjAJ8/tB7edd8PhewWxSQGQcllOy5g?=
 =?us-ascii?Q?ho9VosE6/41S8RuAW8wciAvt0BuFhgo6c76Xu3iEr4JQOYjUUu0aIMQTbRGg?=
 =?us-ascii?Q?ly6ezLovpEiYWbEo/ZQPlmfGk55MzcU8fT03FdtP9mM+Rno6d+N6tbGlo5SB?=
 =?us-ascii?Q?mxowEG5N0ar27OC39Jm7szFPbImzllg92ULmcxlyyTWFqCJrbz9NZ0TeBSvg?=
 =?us-ascii?Q?P+PQ4EPXE8hodCcacAz1WU7v+cOVN5ueHCVLaWi3F5M4NPbUUZxg/NVR8Va9?=
 =?us-ascii?Q?vE90ZN0vVg0o1ai4RNEZJnW1y5Zv9beEDMVSaFD/pgJpuo4kApVmJiw/gGEK?=
 =?us-ascii?Q?vVYYMpNwwyEuvH0OrtOJby0h/aT6ox0Na+Ub60Z74TZ6Yp0VTg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(82310400023)(376011)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:20:05.6896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cfe6178-836c-4317-72ec-08dc9144d89e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4188
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

[WHAT & HOW]
Check cm3_helper_translate_curve_to_hw_format runs successfully so the
regamma_params is valid and can be used.

Also revmoed two result assignments.

This fixes 2 CHECKED_RETURN UNUSED_VALUE issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c | 5 ++++-
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 9 ++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index bcacfd893cf7..eaeeade31ed7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -228,8 +228,11 @@ bool dcn30_set_blend_lut(
 	if (plane_state->blend_tf.type == TF_TYPE_HWPWL)
 		blend_lut = &plane_state->blend_tf.pwl;
 	else if (plane_state->blend_tf.type == TF_TYPE_DISTRIBUTED_POINTS) {
-		cm3_helper_translate_curve_to_hw_format(
+		result = cm3_helper_translate_curve_to_hw_format(
 				&plane_state->blend_tf, &dpp_base->regamma_params, false);
+		if (!result)
+			return result;
+
 		blend_lut = &dpp_base->regamma_params;
 	}
 	result = dpp_base->funcs->dpp_program_blnd_lut(dpp_base, blend_lut);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index fe62478fbcde..05d8f81daa06 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -483,11 +483,14 @@ bool dcn32_set_mcm_luts(
 	if (plane_state->blend_tf.type == TF_TYPE_HWPWL)
 		lut_params = &plane_state->blend_tf.pwl;
 	else if (plane_state->blend_tf.type == TF_TYPE_DISTRIBUTED_POINTS) {
-		cm3_helper_translate_curve_to_hw_format(&plane_state->blend_tf,
+		result = cm3_helper_translate_curve_to_hw_format(&plane_state->blend_tf,
 				&dpp_base->regamma_params, false);
+		if (!result)
+			return result;
+
 		lut_params = &dpp_base->regamma_params;
 	}
-	result = mpc->funcs->program_1dlut(mpc, lut_params, mpcc_id);
+	mpc->funcs->program_1dlut(mpc, lut_params, mpcc_id);
 	lut_params = NULL;
 
 	// Shaper
@@ -501,7 +504,7 @@ bool dcn32_set_mcm_luts(
 		lut_params = &dpp_base->shaper_params;
 	}
 
-	result = mpc->funcs->program_shaper(mpc, lut_params, mpcc_id);
+	mpc->funcs->program_shaper(mpc, lut_params, mpcc_id);
 
 	// 3D
 	if (plane_state->lut3d_func.state.bits.initialized == 1)
-- 
2.34.1

