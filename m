Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24515E6B27C
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 13:50:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC82510E9CB;
	Fri,  1 Nov 2024 13:50:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XiVv8q0/";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25C9710E9CA
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 13:50:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rV/gMUfVS5nRHYlcHIuOqMujasShQS7EpclTZawUx/i4nOm4sTdHvzTrSZI42KyhZFNcZbj2HOAiVbDYnUWZ3tUUb01hy6jSzRYLaJVY41oulIMXE//MjOrsZCI11oE2jxyQH1usCqFcU8wJz66SVvgzI5pZvycbgxYBDHnnbP4wEOsPbXzoqpk0saVhUj9GKqZGnTeXv+z3OUCPMgFtlywN6eleX3FJRvVBcxfgbv69LujlwWNYlpVGHo/cAoPMQYVmQaVJvUFWXMwbRHGJ9Yuyt6SLjdoTGztdo0D7EQD/POEjbqCnXadDXO/sdWj1dYt/EIHD7qfOR/8rcMf/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4tae/wenp3LoAQaA6DM9AVMY5kd2DwitmtUzxmWXRo=;
 b=F53eI9uAC/Z8uvvFY8dUMbDE/2oFLcYdwYfQPfH08aMhMQSBsSL89BkTP1IIcxwvFrsA9VR3PG2AzTFZLkA9nnEDQJrmp3gmNe+HIgzw0L2Zen+61Ce8eASx0gHdxEqYQ0F1Zoy18WUgnHTG595OlG9LavGfTyIrqkmOophqJMCwtZygrBeKhIcazejMIUlcy/TE3zxs1fOqq8jw1+ljb+GeM6XKE/XfsSCP+AbapDIT7uHVUrG5oG6XcvY+Bt86PevirZivO26ENUinjYJjDlf5B8vuQA/HX7fmSJHeEhP/IfZ60YCYCwu/d37rpTyyfJ/FbGkm/VYjOG6pAQMBew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4tae/wenp3LoAQaA6DM9AVMY5kd2DwitmtUzxmWXRo=;
 b=XiVv8q0/1Rwpaj6FhH7z3LnqTu+e8tD0CJ6OwCAWqAKCBkJlz/m3xdGjIqy0gQBKF0qWMSbhHxei5uic1G53VYnB6GnH8yU+Q/h3ErxfA68BZ4Gq6kfsyLz6p1cQz3sYcJFIXXA8IhtZ+75K+oaVsjyLtMO+a/0Ex8ZnDxij4Vc=
Received: from BN0PR02CA0006.namprd02.prod.outlook.com (2603:10b6:408:e4::11)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.26; Fri, 1 Nov
 2024 13:50:08 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::5f) by BN0PR02CA0006.outlook.office365.com
 (2603:10b6:408:e4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Fri, 1 Nov 2024 13:50:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 13:50:08 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 08:50:06 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Ausef Yousof <Ausef.Yousof@amd.com>, Charlene Liu
 <charlene.liu@amd.com>
Subject: [PATCH 03/17] Revert "drm/amd/display: Block UHBR Based On USB-C PD
 Cable ID"
Date: Fri, 1 Nov 2024 09:49:26 -0400
Message-ID: <20241101134940.1426653-4-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
References: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|MN2PR12MB4269:EE_
X-MS-Office365-Filtering-Correlation-Id: 855422d5-74f0-4d31-4f09-08dcfa7c192b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|30052699003|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+t76CtKRfHWakpNlcsKt8hDW17jkwNhalwi4ZZnhkAF69i4wXoUG7fELygDc?=
 =?us-ascii?Q?SDNqU+XJFTuMyRwVawP0S6DzpNqL6WlcWMlvYt/wRRC1+/8JCAnhki1f6f40?=
 =?us-ascii?Q?eQXqOSyYeZJfPVoK50pFnFt3foEcTPICZfnDG4FIvdvZxxqMluekmTRonGRg?=
 =?us-ascii?Q?aQUb7sHs/UHWQO4Mo2oQdqUs4SnIxUXnrNCfMCRQGvQjrjY+crT0anuke1h+?=
 =?us-ascii?Q?+r3JWXUfIppkCYImDp0ny+Bqpr/8X9YN+G7XDZG0W0AxZsf46XtGM230qC13?=
 =?us-ascii?Q?gs6X0UJcVpXoqQiXtuu31FKb4cEkzw0xAI2VWS2Jnlh1TcNV+Hu2KZX02XW8?=
 =?us-ascii?Q?G8ShkjlnV1xGzOm5iFPQOKKP+UpSUq/FOu7X7DqKVIz3Hr+RZvPamwKTcCoO?=
 =?us-ascii?Q?F0ccqMiL71vhjVST+RMtmew8Hn3IAxzthq7dVh1rxhBC0yALU3DgGEWToNsE?=
 =?us-ascii?Q?URrEv46odohyd89/GR31sxt/hs/LGlonWTU2DBK/knBZr4S62+XyGQ7L1/xz?=
 =?us-ascii?Q?QyTkWeAHjEB2ao1/KSIhILUj1fx6Kud7QBPaZQ3/COjRToGqSbegPK8gJk9W?=
 =?us-ascii?Q?/0QmWZ84K5LPJL/X/sKL9MupaNjpTmPr/GXzvqSkHEHVl/KE8aOb+aZuMByf?=
 =?us-ascii?Q?AW8vaCIU98xr8MEBglpK4FUo5eGohopK/rl75Ffn8TcdWkpCE8mJemehL2kr?=
 =?us-ascii?Q?9gXEnfPsHqkk6iVRgJ1MDhtjaOOVbMfmbo5Evh6Ww0zpjtd1pa4jJDqnCYlH?=
 =?us-ascii?Q?p08T4UPAW+dDnlNDN7/4zl9CUGr/l2gb0orsFJb4jlLjOqIM2C74WClq/d8i?=
 =?us-ascii?Q?Mna1vUV3R+1Ir2tNsrp7C6Gh01Xlx7m/wUiabP1UQyZ9dvmR5lEMFoX3hDZy?=
 =?us-ascii?Q?Mc5av4WWcBt5IcYxdwleSoCUxNgL++Ua8VLmcOHzs4UfYPbImswRmWZjEOzW?=
 =?us-ascii?Q?DuqtKgeaI0wHXoXWv+Kjt00YRrJ7+wfuc4QLpCLCk1zcPBztmbWS9KYUqPo3?=
 =?us-ascii?Q?opL6OI8JlhDWI0gApe+kFUX+cgsyp2je0oCAeK+Wi9Smu6y89Y5Yc6RQgb6x?=
 =?us-ascii?Q?HIQDrnh14K5Kd6IBMdseFtIDWYfbQtA8e4/a78dTqfYKeLME0yX71SqBuj1t?=
 =?us-ascii?Q?va9sgBjSyLupzDpz1JI0ei+8Pcb7jv21XqfK3v6lxJMPaUcqxjW2zlifG4Rb?=
 =?us-ascii?Q?8NyyJ6olEI/IID94qndWgTq5igwPrVWtryuUQZIRLxLx3Sjxt4YuBxZquhoV?=
 =?us-ascii?Q?YXi38H99xAUBt5+858aCqePSvnuCp8zpyELeDJkT3814mhBiICwjYYPe236x?=
 =?us-ascii?Q?7KpAom4X8eKJ1lw/KofuSn04ilDMPyPp+xgsifaPvObBAdAv5/afkGgNN0dL?=
 =?us-ascii?Q?HKqsmyJZNNaYlxGKasLiJm8YkBRDNUxeoYLEf0l0Rf0U3ljb7g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(30052699003)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 13:50:08.4300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 855422d5-74f0-4d31-4f09-08dcfa7c192b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
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

From: Ausef Yousof <Ausef.Yousof@amd.com>

This reverts commit f767e41a6f6b70cd222edd24549c1fa753c550fc.

[why & how]
The offending commit caused a lighting issue for Samsung Odyssey G9
monitors when connecting via USB-C. The commit was intended to block certain UHBR rates.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Ausef Yousof <Ausef.Yousof@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../dc/link/protocols/link_dp_capability.c    | 22 +++++--------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 93b81918216d..72ef0c3a7ebd 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1417,8 +1417,7 @@ static bool get_usbc_cable_id(struct dc_link *link, union dp_cable_id *cable_id)
 
 	if (!link->ctx->dmub_srv ||
 			link->ep_type != DISPLAY_ENDPOINT_PHY ||
-			link->link_enc->features.flags.bits.DP_IS_USB_C == 0 ||
-			link->link_enc->features.flags.bits.IS_DP2_CAPABLE == 0)
+			link->link_enc->features.flags.bits.DP_IS_USB_C == 0)
 		return false;
 
 	memset(&cmd, 0, sizeof(cmd));
@@ -1431,9 +1430,7 @@ static bool get_usbc_cable_id(struct dc_link *link, union dp_cable_id *cable_id)
 		cable_id->raw = cmd.cable_id.data.output_raw;
 		DC_LOG_DC("usbc_cable_id = %d.\n", cable_id->raw);
 	}
-
-	ASSERT(cmd.cable_id.header.ret_status);
-	return true;
+	return cmd.cable_id.header.ret_status == 1;
 }
 
 static void retrieve_cable_id(struct dc_link *link)
@@ -2130,8 +2127,6 @@ struct dc_link_settings dp_get_max_link_cap(struct dc_link *link)
 	/* get max link encoder capability */
 	if (link_enc)
 		link_enc->funcs->get_max_link_cap(link_enc, &max_link_cap);
-	else
-		return max_link_cap;
 
 	/* Lower link settings based on sink's link cap */
 	if (link->reported_link_cap.lane_count < max_link_cap.lane_count)
@@ -2165,15 +2160,10 @@ struct dc_link_settings dp_get_max_link_cap(struct dc_link *link)
 	 */
 	cable_max_link_rate = get_cable_max_link_rate(link);
 
-	if (!link->dc->debug.ignore_cable_id) {
-		if (cable_max_link_rate != LINK_RATE_UNKNOWN)
-			// cable max link rate known
-			max_link_cap.link_rate = MIN(max_link_cap.link_rate, cable_max_link_rate);
-		else if (link_enc->funcs->is_in_alt_mode && link_enc->funcs->is_in_alt_mode(link_enc))
-			// cable max link rate ambiguous, DP alt mode, limit to HBR3
-			max_link_cap.link_rate = MIN(max_link_cap.link_rate, LINK_RATE_HIGH3);
-		//else {}
-			// cable max link rate ambiguous, DP, do nothing
+	if (!link->dc->debug.ignore_cable_id &&
+			cable_max_link_rate != LINK_RATE_UNKNOWN) {
+		if (cable_max_link_rate < max_link_cap.link_rate)
+			max_link_cap.link_rate = cable_max_link_rate;
 
 		if (!link->dpcd_caps.cable_id.bits.UHBR13_5_CAPABILITY &&
 				link->dpcd_caps.cable_id.bits.CABLE_TYPE >= 2)
-- 
2.34.1

