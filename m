Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF83C83F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 22:46:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E23210E722;
	Tue, 22 Jul 2025 22:46:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LZymYV6E";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3127D10E722
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 22:45:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFJ+h/UsWPzuiDPIM9f0bikUP50+9EnzzbyiW3EiFJru/EtqdjEHojC5tnW8KyMMNpdscB2d827wjmeRBEODbGNsRcViXUBUlDlIvTwg0uf8Ty/ac6KBthNzRiMomODKKwgz1eVXOsn6kzPzSvSRS2FoIWewXJV7GJe+2ZY5K7yLESVxMiB/A/2mVWthE80P5ZVJ/6XB8//R//NWxGmtPJgFWV+0mNl9HZyjyk7ILC5wvx1hp+m7arP2e9zZJrR9l8u1YU/9koZq803OE15L2eSeXEsL1OG+UqKEPFM6sMT6lqtahATNSyEevRGfq/3lbQgFk9SeCfU8esezNeCG2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1G8iP8O1weSagJC2VItzxcoWtDPvXUXzbV30I5ZwnD8=;
 b=ctv+VhmvQBzpHSKc8VbyCgcxIMDSSKPR9HcxUnoY4UsCTXBuHize5AWfr0t5+618XBT8FDo+lOddwhb6Pw6gPIReiShQKX0CDS6puHbkLKhf3ky2FXCpgeyyW7rQzsvbgfNa5jkGDEBV/BpWKyzakLon3hap2lTGmTr2OQNzFSmTZe9yZXJoMUDFNWtpFCkw8TndQB1hT23G09z0Nsarul3J1MY4HdzTZ62nEi39z6XYVaDgRf8ZtgwUhxFH74Zqk0DOyzn0x6urlBUwIqh7x935P4E+YYZcb1Eo/a3Us+neP3rkRNm9wLsK5QC9O0v1jlMGpaU+EZGRnua5CobBQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1G8iP8O1weSagJC2VItzxcoWtDPvXUXzbV30I5ZwnD8=;
 b=LZymYV6E+RlVMz6KpOPC4airW0s488/BPsRrBwgAYNJnmQJQo0QoonmrTf0LAoM7QF0E6OpOGvhc8t5SEvsSszqbkXm60W0TVf8T+ArFAl+P3qZtpzgbKK6uztswOvCqVo4J0enQTANsloN+PuB1Z7HUk9SGI+0gDd1OC8lDn24=
Received: from SN6PR01CA0023.prod.exchangelabs.com (2603:10b6:805:b6::36) by
 IA1PR12MB8223.namprd12.prod.outlook.com (2603:10b6:208:3f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 22:45:54 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:805:b6:cafe::a2) by SN6PR01CA0023.outlook.office365.com
 (2603:10b6:805:b6::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 22:45:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 22:45:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:45:53 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 17:45:52 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Relja Vojvodic
 <rvojvodi@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>
Subject: [PATCH 16/25] drm/amd/display: Allow for sharing of some link and
 audio link functions
Date: Tue, 22 Jul 2025 18:44:25 -0400
Message-ID: <20250722224514.2655899-16-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722224514.2655899-15-IVAN.LIPSKI@amd.com>
References: <20250722224514.2655899-15-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|IA1PR12MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: 90377579-c4e1-4aa8-646e-08ddc97183c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7fe5WQGG7OEekQcPyNSbbhrYnWa/i60IACktvvF4fHqjv+Ew9bj5o9GMNiAp?=
 =?us-ascii?Q?uSDq3IRapYVll/XeqXf7tBkSX4sx/1IFi49HGq+2rujaJT+c4W2zjlwUiTrO?=
 =?us-ascii?Q?6VeK/4+GfRz/7D6l7MZ7bwHq7ilTRewC7H8R7bLEJHe+yBQmQkhIc8uMYuAm?=
 =?us-ascii?Q?9gY35N+cER/d2pDwuAWxVE7QZLt/+0MJdSLX+wUwpeX2afQgqfRl1ChgACFi?=
 =?us-ascii?Q?YHDJBn6afMQuHoHr558MMul9NGBbsyPhpLYhoWDM13EIh+v3in1+9lOenuRc?=
 =?us-ascii?Q?6QAdu6NyEE5YEE0MibsVsDUSvcfhyXUytbAcUvslqWx024uCI1VZilBDMZQe?=
 =?us-ascii?Q?KNCDqptujRM7dRxXCu5Kvp0QMG866M9tyXnhGToB/RrJAlI+0zcMQRpJzOip?=
 =?us-ascii?Q?iwrXFuzDcjxLad3kNzgG1iGOZL/OsnCAuUtvyz8ZonwFusqrt/3e9PQa3EC0?=
 =?us-ascii?Q?GIDTtxXGjtsbkTYmn76o7n+2nDBkH/5sqJ+/N+QvvbeGwCdLZhF+mWkxCXXU?=
 =?us-ascii?Q?ieYKaoI3xarSrb9OTVSKpPl1lpx7NMkLc/LGjigtitU7pZaI5xigqO30Dtxh?=
 =?us-ascii?Q?X8fOQf7I/tdxZDHWQ8wQ36KShF+398rFUqn83x0Wbtj9/IwGVEg2DQhMcr8l?=
 =?us-ascii?Q?6jEaJHtu0/0KgHHRcdTacIgD9O7JBReD3Bk6744QxvCBPQDgucQMbrkhtXDx?=
 =?us-ascii?Q?h0rii6swZdEBKIzMfRaakON7X6pxVVSzBgDHMLEl6p1V8FM+1rVi6EwZ9lWd?=
 =?us-ascii?Q?Cgv0vY/xolFEK5BStSKSXwwv37t69F2dciU/Ni+bGGxwnbKuJ7DKsHpODIB2?=
 =?us-ascii?Q?JVL8NT1MVaCj40oKvC1JjD0pHUW++14rxLM+ityGTEh1CDqb+JCZ2jSFjE6f?=
 =?us-ascii?Q?97tPt5B+8Twm9rlnoLueFLUTqVkJP2CmXfQ25wc0BhMSD/BMwSaZDLu79Lks?=
 =?us-ascii?Q?xBH8HHWEzSU38YTCEAiVuiMO3zGLU/m/1hnZN35gviBb5dkYFVTqQo3QjDc/?=
 =?us-ascii?Q?jRMmqNcoFeLStI3kPZicULYDAC7SQi9LqqeL5jPWajvOUpL01oXvJK36dP0u?=
 =?us-ascii?Q?8uRZMd83f9DIwXGyQwXsy6pLHZHVAxIMX8ghucL+Z25zAYlG56zkrmFyR+fu?=
 =?us-ascii?Q?xxqSgweheneBS54inkOiKu5Z5IblYeLaNtrtCV93dREgXJUwal5ErVtY/jQT?=
 =?us-ascii?Q?XJpFJse87PQgs2GPvMHQbABZLF7dznUoMSn1ySOFtD3VYdJm7YIb4QCLIBG+?=
 =?us-ascii?Q?OHSV9foq9vpp5UyyJCu6/3DzYqbredG3cevKfOC1svpDRARNLumQo2uOwMYK?=
 =?us-ascii?Q?JItN3DtToOeGaxfcyO+va6EcOlbjhBDhMvv4WHHqeTmcqOdLxfT6SPx+0MMx?=
 =?us-ascii?Q?6hC3MU56FNvBUpX77YjAAZLjI02zTuz4fezpw6f/c19sDI2JmED5lSuaCL6h?=
 =?us-ascii?Q?OOe0lrhhsLfGB4KzsMyD8xJmhj9zENkUw9tP4LvOJjK2bwTiXqwEBx5cXlCG?=
 =?us-ascii?Q?buA4w++uJyrSaJu4iHuouCI0Ns9KDOpaTiUl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:45:53.4990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90377579-c4e1-4aa8-646e-08ddc97183c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8223
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

From: Relja Vojvodic <rvojvodi@amd.com>

[Why&How]
Allow for sharing of some link and audio link functions by removing static
keyword from function definitions.
Expose those functions in the HWSEQ header.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Relja Vojvodic <rvojvodi@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 6 +++---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h | 7 +++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 62cdfee82956..b412419ee5b3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1270,7 +1270,7 @@ void dce110_set_avmute(struct pipe_ctx *pipe_ctx, bool enable)
 		pipe_ctx->stream_res.stream_enc->funcs->set_avmute(pipe_ctx->stream_res.stream_enc, enable);
 }
 
-static enum audio_dto_source translate_to_dto_source(enum controller_id crtc_id)
+enum audio_dto_source translate_to_dto_source(enum controller_id crtc_id)
 {
 	switch (crtc_id) {
 	case CONTROLLER_ID_D0:
@@ -1290,7 +1290,7 @@ static enum audio_dto_source translate_to_dto_source(enum controller_id crtc_id)
 	}
 }
 
-static void populate_audio_dp_link_info(
+void populate_audio_dp_link_info(
 	const struct pipe_ctx *pipe_ctx,
 	struct audio_dp_link_info *dp_link_info)
 {
@@ -2255,7 +2255,7 @@ static bool should_enable_fbc(struct dc *dc,
 /*
  *  Enable FBC
  */
-static void enable_fbc(
+void enable_fbc(
 		struct dc *dc,
 		struct dc_state *context)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h
index 7cd8c1576988..9c032e449481 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h
@@ -114,5 +114,12 @@ void build_audio_output(
 		struct dc_state *state,
 		const struct pipe_ctx *pipe_ctx,
 		struct audio_output *audio_output);
+enum audio_dto_source translate_to_dto_source(enum controller_id crtc_id);
+void populate_audio_dp_link_info(
+	const struct pipe_ctx *pipe_ctx,
+	struct audio_dp_link_info *dp_link_info);
+void enable_fbc(
+	struct dc *dc,
+	struct dc_state *context);
 #endif /* __DC_HWSS_DCE110_H__ */
 
-- 
2.43.0

