Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B519C3ABC3
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 11:25:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3EB710E567;
	Tue, 13 May 2025 11:25:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vUzB+Nuy";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F385610E507
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 11:25:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGjz+BZRh7GyGdykFlULe0YdmjshjuKYFdnsxhOnaAFPCOp4OakINiKQtv5lkLQ/75ARpD/x72zejdBci6ACnCl3OpMjdoYtv0JI3nQVk1A95JKuuCY+F25lKd7qy4yEMgx/nAly+D0OOjcKF4a7TcifaJrea4ZXhynpm8GDfxjWfQcvXsSTChVknw9nri6/ffxQeCfcdpiBdFD+jXets/vLsJavgPA6ujGD+y3j5LAW8EHKL5X7hX0Tv6wIoWcL7aFqYPl7RSXmG8c9wMyFXrDUdq627B3nixhsFhSP+v9x/aXm3CFDI8k+88YdO27ugwQoFy4Li/Fo7ihpzdlmKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CASrvSlopDj+GmakLMFZBtW7JkOfGx8YfuO3myqpV38=;
 b=r1+IQ5IhU/1p4XtuzkzpDHOXUacX4VZDEkmZoDPLYsoxH0Pfb8x4jyVYH7Xr+5lwYVmldk64co8elXxj92CDUJIL2OV8pj1d8nGkq6CStjnlsyQgoUodSYdtpCX3G0dQ3w400SSKfOOJOYzVE5Yjtzx1NzaweGaFnpDgNEo4t2r+JM8geizUs07+TqJGEqBWo8ZRGj4Um6fcvNty7FJv2g6l1XgUG4c44EQb2dqOXuLijqoeldvvybdxhgqQP7nSYXz9A9QRuSnVrvngj6aqQNK9x2PfPT3S0nZUc8dFc67v2imuqidaJzIYmdb6ytyQdYYy+XVaLEYr6K8Oy+FSig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CASrvSlopDj+GmakLMFZBtW7JkOfGx8YfuO3myqpV38=;
 b=vUzB+Nuy+lfwAagHmRCkY53zFcRPu2dDsoKfKdBrKTjHcaY6EapwggaMPNdK6M8520yTQCQBd3AeHimrUynbD9zRqWjHbkBkxtWx/TLm9e/KlNslUabiSwkxCkOVVl1QFJcsm+SRo9pfTxHVZdB7lBDAj/0WBjL9Na5Dhkq9djk=
Received: from BN9P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::22)
 by SA5PPFCAFD069B8.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 13 May
 2025 11:25:23 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:408:10a:cafe::c0) by BN9P221CA0025.outlook.office365.com
 (2603:10b6:408:10a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Tue,
 13 May 2025 11:25:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 11:25:23 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 May
 2025 06:25:22 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 May
 2025 06:25:21 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 13 May 2025 06:25:19 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Ovidiu Bunea
 <Ovidiu.Bunea@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 09/11] drm/amd/display: Add GPINT retries to
 ips_query_residency_info
Date: Tue, 13 May 2025 19:24:37 +0800
Message-ID: <20250513112439.2295366-10-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513112439.2295366-1-chiahsuan.chung@amd.com>
References: <20250513112439.2295366-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|SA5PPFCAFD069B8:EE_
X-MS-Office365-Filtering-Correlation-Id: e84c93ff-2c74-45b9-8da8-08dd9210da0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yF3TDFGwNqR7Vwmd0AyOryxHIepL6xuBSX/lb/5CbjQDAKLOS1DQGyxNWsCS?=
 =?us-ascii?Q?mMgIer3t2iHktbefIeIUh5PuYgZtMosj6KnuvgdEXLk+BJ3mApSDkzGhkVv3?=
 =?us-ascii?Q?yj0q6oaoYIIISLnl3odNAb0iRLDFBJnkPkfITWThyI4mW6QnsRwtpv7Mio2I?=
 =?us-ascii?Q?xIuCriftCTYew1uPt/CXOxAYIgWRHh9OYMJP19M6DeEQhhBejapc8u7EdpQ9?=
 =?us-ascii?Q?gyl4KTL4GodgTwBh3xlXnZiwMnfJBBbojh4bPzWmlqvUZfJqFPIDDC/zvhu7?=
 =?us-ascii?Q?B39kNiysyhpuJgkzVTXWyPG2YYCRFboiMkO9blTZ1jXPwRTECf6h6YbiOF+w?=
 =?us-ascii?Q?db9wGPs7sSaFP6HxxO+fEbVBzPc7lX0Hynn/VFcvkoG4j2htkwcDB3COXMi7?=
 =?us-ascii?Q?jixmJDRvHCeN6m82rSwvdxJF6AJ+4uWzD9GgaXgLxKTnfpDp9NGZD7bEVE81?=
 =?us-ascii?Q?h6QOlX9+BMM6tBQq/smsiwIXKhgl557vBtdW2F//uUNzxO7/hKalqMZYF6f2?=
 =?us-ascii?Q?W6kFk8yjV0U9JSz8UOO5ei87BptnF8ECA0ggkezocAFaf66tXaeTv9ahP86z?=
 =?us-ascii?Q?77jih7/WFvyFKtU6yFYCC7/PRDq7Q2sH9vxUAhR6INlLFIwZxg8gbsbToOmp?=
 =?us-ascii?Q?PGfRUDQFWP64k9hwPoMsA2nbXxlOH6l6RKIlLwvzkCD+CS/Wotkuls5Xm0iZ?=
 =?us-ascii?Q?Gm55q/ezP+pT6zpqDB2UpG63hyoj1xPc3JyoG8cbVQq9qynrNAG3Q//kikIf?=
 =?us-ascii?Q?0uV8cNaO6W1JgE2llcTyKW48z5QaDpVganC7UobV9UmJtZxpwX2+tB3baXB1?=
 =?us-ascii?Q?f1VDQD9+4IFYpKeuVDvODyNwvZ5zeMON0Cgr3B3bOulzSsGEUp8iPiGVsE/v?=
 =?us-ascii?Q?HNfpUW9yS7yaGo9s51LkEDaRlzK1xdzDOEfTdynALDs5eIq9UeaWEK5vP5zr?=
 =?us-ascii?Q?vN6HTUymVNMQZtTNiH/U6t2UnMC8/UEeOVTsNMuY7L/L0mzBN3jC3kBjde7C?=
 =?us-ascii?Q?0+JsnHbOW3wYnGwqTr2XVSiGRsSsbqF35WZtTWQfXcxSugc7wh0HZd47xqZ2?=
 =?us-ascii?Q?3KiMeVXwdY1mH+XmMfwaVRFjEWeCsyGWLm1VHle4Zf1ewT9mBFoDf4eAI1U7?=
 =?us-ascii?Q?FnaHy8doa1gV7vLYrCyi9AShLbKG9CvRpZAOuSDDp8wOFBHmhjDHSF8q0aMY?=
 =?us-ascii?Q?nsqMHRBHMUlzXQqFRfeNXhgDPkIbYehzdIxIeGsFm6p/QZftSDd4iQQRjhIg?=
 =?us-ascii?Q?cjQrJZ1YcD1sHpSmHmS/C14sHZRbUmDfBFGTO/DOc7IjebB/fZiJzXvsWzpu?=
 =?us-ascii?Q?qxsLCZ/26ggRSW+2tzdQLBoVUyZ+ZX7u1TzVdSW+C3nVGWSxcw1pd9Oqs2qz?=
 =?us-ascii?Q?R4EQkRvcKv71XDxrxAgxJKfpdEwTsuhxXM/1AUgygVR9Z9AM3y6tDhMPck/5?=
 =?us-ascii?Q?/K6haLgyGwWBpy0tM84FB9g3XYcGgAiCc/ELueUmxZDqz7z5RCJmKdNTDneK?=
 =?us-ascii?Q?AiQxxOrlfF0i84s7CEMdG+ysyU7ELImYwXm+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 11:25:23.1259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e84c93ff-2c74-45b9-8da8-08dd9210da0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCAFD069B8
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

From: Ovidiu Bunea <Ovidiu.Bunea@amd.com>

[why & how]
GPINTs can timeout without returning any data. Since this path is
only for testing purposes, it should retry several times to ensure
data is collected.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ovidiu Bunea <Ovidiu.Bunea@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 1c6e71eaea3c..afbcf866520e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -39,6 +39,7 @@
 
 #define CTX dc_dmub_srv->ctx
 #define DC_LOGGER CTX->logger
+#define GPINT_RETRY_NUM 20
 
 static void dc_dmub_srv_construct(struct dc_dmub_srv *dc_srv, struct dc *dc,
 				  struct dmub_srv *dmub)
@@ -1888,11 +1889,14 @@ void dc_dmub_srv_ips_query_residency_info(struct dc_dmub_srv *dc_dmub_srv, struc
 	if (command_code == DMUB_GPINT__INVALID_COMMAND)
 		return;
 
-	// send gpint commands and wait for ack
-	if (!dc_wake_and_execute_gpint(dc_dmub_srv->ctx, DMUB_GPINT__GET_IPS_RESIDENCY_PERCENT,
-				      (uint16_t)(output->ips_mode),
-				       &output->residency_percent, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
-		output->residency_percent = 0;
+	for (i = 0; i < GPINT_RETRY_NUM; i++) {
+		// false could mean GPINT timeout, in which case we should retry
+		if (dc_wake_and_execute_gpint(dc_dmub_srv->ctx, DMUB_GPINT__GET_IPS_RESIDENCY_PERCENT,
+					      (uint16_t)(output->ips_mode), &output->residency_percent,
+					      DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
+			break;
+		udelay(100);
+	}
 
 	if (!dc_wake_and_execute_gpint(dc_dmub_srv->ctx, DMUB_GPINT__GET_IPS_RESIDENCY_ENTRY_COUNTER,
 				      (uint16_t)(output->ips_mode),
-- 
2.34.1

