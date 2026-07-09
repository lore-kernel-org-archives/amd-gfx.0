Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04253C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DAA210F6CF;
	Thu,  9 Jul 2026 21:02:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hz+KtBTq";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1DDC10F6C5
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIUH0cJuqcl7iJu1+svHNVrlNyIIDSapeaGuWqwY/6YNZ+h/ptQf5qNPk1rnDFMLfsp4RoppNyipdYneBRLIfsWpNtXkflA5AyYDsbY7u4L6+Y+HevVjgvJgt4u4wGWX69MMLjnGh1ISeowfXn1iz5wFjvHxCsXGS+TBf4k4MsaaFrovM7RGDTXAkjCNfWNnmRznUEF+zQ3tEuCkE36GiG8xze+SxWsRBaCzTHX41yyLqqNesvonaepQtfrVR8ptelHoX/9FaQuLhy2FRRXzCtEpV1VB5qCT81jECP7/A6RjBGEOcBlzvF6LpxQ3H2NzEZUaFqbMZZt4Ji0z6uP+BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUPh/4bbyYXafIhGK9/G0C2DGzKz+jOKmKfK+ZI6/n0=;
 b=uy244XSGjt3ZJ1+qTpbm7uYQ8jSU38DOFUBbo0yAZIZOCLN388wJgm0tf6bcKnPzNckcOyDtKg+vy0520hNwI8ZuKBAI644+JqbFAEW2tY/TSSX5Sgi7R49P6lXW8gYsDXBT7hHdJCrgXSmJUXNXqy+gbz9p671xhCdUjMK1eYjG09OE8JQHhfOnQaeebrO4O+R05S+YBKh3VVI/sKmshDuQeMTahbKnjJs0p0D1qaR4Vl8OnVzK48paplzwGnhtWlSyIa7vkgZhkFsVYCuzLajLf4joZB+gOYc+CkH7E7R0wzUEtpsiIaZRlZq34IWtiES+pj+246Q556cPmAsmgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUPh/4bbyYXafIhGK9/G0C2DGzKz+jOKmKfK+ZI6/n0=;
 b=hz+KtBTqziondyH6FtuaYQkkncBmVasOIcw37CSjgVX8XQoTJh8ZAnpxysU9KIwTFqA/zGpcMrpNdDUBnX295sCvvFl2mnN5aFoHU+ajvgh+ZkDX6tBCWzWQveP+UIaoEMXrCm3OS82aSL1ofCiIWJ0CBMs6vKRSUDYWfNiQeSk=
Received: from MN2PR07CA0004.namprd07.prod.outlook.com (2603:10b6:208:1a0::14)
 by SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:02:14 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:1a0:cafe::77) by MN2PR07CA0004.outlook.office365.com
 (2603:10b6:208:1a0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 21:02:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:14 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:52 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dominik Kaszewski <dominik.kaszewski@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 21/80] drm/amd/display: Fix indenting of dpms on
Date: Thu, 9 Jul 2026 16:47:49 -0400
Message-ID: <20260709205936.5719-22-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: b21b90c5-5b79-4706-d895-08deddfd5a3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 27pQ3XfXDm0vWqBuWWA21r6GOLTTo2ZNuZko6epUBhPkZTg5JuvKNH0xnA0tN/4dXUi7N+xSoX6hVoyzqV5kPCYJMpu6jH4X14AxgM5UGJwJYwnSZdf9voi9c85Dl8oKgiDa60kjstJJw5n3Nfrq8MqIf7CJIx7GUD0S2wFEgkfHQEK9s9mlDr/8Ba7Bhj2l1OfdKkgNXe7DVVJ9TljnTOFvvVTKLGH0n+cW+72a4LpceDck1ewE/yO3ygJ3aYkUfJtQICKJ7nhhu6q9HhsigitBaTHBBOxxb5p8G26yAOwBT+5pJFr8xxibMqUCKg2Lo8lH7Cbos9I6sHFntbwew6AzgnJ3SUtSOtf5w6EOG7ru3wBDmWMLVoNTNPjJYGtu/2vFVOaHAy3pqDXUjRPq+IMQ+caAsQkZ176Je+RYG73B4cq8vqmC6xzbfKqeg5bBspXTfGtoS263VjTEDQOyFfje4npSW+W6VdHIw6B6mMKOlPb14o9cqrHfnL5eyKd/6poG7LwaZHZupgLgotxWpBYghDctoFo7iLDUYWU5Q0NL21Aq4692iPMEBd9esOOvlWVomZRs31xjbg94BMLNO1LKct17JFS5UthTjoIO8L7Whot/tr1Yl4MIQSwukWtr/av44EGSYoLgCbonajdVa2XXj83lPJ1V7Td8WKM8Uhq98y2+J+WdTMupIZBqOLdG6/RYZIID73QPd8/j3TC4iQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ayS7N5ub7HYhzFLjyk8m+i+YiKUGMY5re5Qv+UHdZkEIjYeg6QHe17slObgDrAyKAxssQuqiDuTA6Y3CuIAH9M7zru4AJTKDaenA3YGskjCJ4u8dpIpJ7rYX6qjKDI0JEFN67w9nGmYnpAjcDdT9xUaLRt4Wbz3BZvIQoN4NThZKbvSLGtHhFgDt+u7fOsJQ5iKZqY6UvAH2Q1i2MrPPDRM9u/8jdXUmDuSpZ6de6cCdS0SISwp1siPvxBkkzVFEaZTpn66M9D6VPXzO9d1b8PsS7zFmz5rTboevk+H7a8qJ3WggNP6DZDqMRHxWfcdldArPYOcHE9iNWUi61AvPfoXxOeLc/SvGtr5R1/S3LwTxg4s8Yj0Fe/8j8EJzlqrtTncTLX5lsJxTaQ9xhPZNTGdkxd8Q/SGD2/nXICkiWICQzAJSjWjcyjlicfYP7eRI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:14.3025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b21b90c5-5b79-4706-d895-08deddfd5a3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991
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

From: Dominik Kaszewski <dominik.kaszewski@amd.com>

[Why & How]
Cleanup for future refactors.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../gpu/drm/amd/display/dc/link/link_dpms.c    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 479a8fbfdc5d..335ae952ef60 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2610,13 +2610,14 @@ void link_set_dpms_on(
 	 */
 	if (stream->timing.flags.DSC) {
 		if (dc_is_dp_signal(stream->signal) ||
-		    dc_is_virtual_signal(stream->signal))
+			dc_is_virtual_signal(stream->signal))
 			link_set_dsc_enable(pipe_ctx, true);
 	}

 	if (link->replay_settings.config.replay_supported && !dc_is_embedded_signal(link->connector_signal))
 		dp_setup_replay(link, stream);

+	// TODO: Split DPMS-on into 3 functions at this point
 	status = enable_link(state, pipe_ctx);

 	if (status != DC_OK) {
@@ -2629,9 +2630,9 @@ void link_set_dpms_on(
 		 * show the stream anyway. But MST displays can't proceed
 		 * without link training.
 		 */
-			if ((status != DC_FAIL_DP_LINK_TRAINING &&
-					status != DC_FAIL_HDMI_FRL_LINK_TRAINING) ||
-					stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
+		if ((status != DC_FAIL_DP_LINK_TRAINING &&
+				status != DC_FAIL_HDMI_FRL_LINK_TRAINING) ||
+				stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
 			if (false == link->link_status.link_active)
 				disable_link(link, &pipe_ctx->link_res,
 						stream->signal);
@@ -2639,6 +2640,7 @@ void link_set_dpms_on(
 			return;
 		}
 	}
+	// TODO: Split DPMS-on into 3 functions at this point

 	if (stream->timing.flags.DSC && dc_is_hdmi_frl_signal(stream->signal))
 		//TODO: bring HDMI FRL in line with DP
@@ -2657,13 +2659,11 @@ void link_set_dpms_on(
 	if (!(dc_is_virtual_signal(stream->signal) ||
 			dc_is_hdmi_frl_signal(stream->signal) ||
 			dp_is_128b_132b_signal(pipe_ctx))) {
-
-			if (link_enc)
-				link_enc->funcs->setup(
+		if (link_enc)
+			link_enc->funcs->setup(
 					link_enc,
 					stream->signal);
-
-		}
+	}

 	dc->hwss.enable_stream(pipe_ctx);

--
2.55.0

