Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295E2C3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 07:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C99DF10E441;
	Wed,  7 Aug 2024 07:57:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jx2DX0oR";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBA1610E441
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 07:56:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOwG5fDtUGj5hQd2iaHJ7ttMP/yoIIsTFktv5WNc77c/x9iHC/keQhYXTU/DHEz9QZ5GLB/A0RQPYuA/2RzUBNwZt9RFYvtwex8CLcPevDcDJwXpk5FwVi8kRIG5+WB9DZJeytaeeESvCUlTX+rrppVcxtV/E2brbQXbmjs+VvYQGGXBXHYRk/79BB/jT8O76rBq3aqiLUNAVesB498ps1pnWYVwgoozNrWEajSx5TYMGZ4UxTFICoo0udQRZjE3Up7zdzk3J4no/AjraOfjgQw90LwUObGWEG2cbh0KVxCZA7m5mgEnzxxd2unXtWIy/gAauXT1l76XiwGXkaSzCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nVceRLYQ7jj+w1xMLGBGl4UJD2/1nEcNK67yU3CUko=;
 b=WowJF6fxfATZy+EsVLzydsIDpj6du5pSgTplhVjjK3J6InsXE5ykLCVEFWtGIQJ/39We+8lCY05Aj1nkapmRYkasETsiPsE3v/GvqYGMMbc2H+DYMxPCwkFBLeSWuP0uWh8Ep3vXnQOW/nh+vlFM3Cghr6hUFYUtbX2fZ57saiOnoe6SBWDvDcHNdur2QSMm6j/oM2haLHp5m8gViBTeFM66+MQycQ+j/Gya7/g7NrJoDxHvKdtPo3+RXHhdb45uYWW44pREaMbE66nOC61UzPC4LLKkaVRSykLXBkTbM6j84gi0ozsZbSbVy2Mc1Cx5pBsTdwXBCSs1KUR8a4BxkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nVceRLYQ7jj+w1xMLGBGl4UJD2/1nEcNK67yU3CUko=;
 b=Jx2DX0oRUmFvMEW7pW28CRd13zS5uGed1oAH146HCoHtF/VTTnq9dd5jPLxKdQ2SHCQLrFCnXm0Gx0NEF0B/GYSCJyaD8Q05Y8MgS7TaDHvEcdxiRb+P9+Xe+j1ZVxqcL3sE+fGiZnZ5R6sL1es9A9b/DjKFe6C670A0lgWZBCA=
Received: from BN9PR03CA0251.namprd03.prod.outlook.com (2603:10b6:408:ff::16)
 by CY5PR12MB6432.namprd12.prod.outlook.com (2603:10b6:930:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 07:56:54 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::b) by BN9PR03CA0251.outlook.office365.com
 (2603:10b6:408:ff::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Wed, 7 Aug 2024 07:56:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 07:56:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:56:54 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:56:53 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 02:56:45 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Roman Li <Roman.Li@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 11/24] drm/amd/display: Fix print format specifiers in
 DC_LOG_IPS
Date: Wed, 7 Aug 2024 15:55:33 +0800
Message-ID: <20240807075546.831208-12-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807075546.831208-1-chiahsuan.chung@amd.com>
References: <20240807075546.831208-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|CY5PR12MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c76706-7c84-4e79-2d51-08dcb6b68125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WEx/UTqeBDVl6nTO7xggRKjpxxW68TGf0aVkLLQn8+mC9KdwLxbU78F2iRrY?=
 =?us-ascii?Q?2bPMpYTOtHcRAd4e4ZhrOmZ+Tso1QqFQtHd8tFyMPTVeoW9HEJHP5K7EtBlR?=
 =?us-ascii?Q?e3grwGsz1bPZRlGveY1HvyDatxHyCsiTrb34J0UX8Cos3+JUhvubZ8JgvknO?=
 =?us-ascii?Q?uqDDZcTO2AOFAv4Bn5xD7Pvg8EzK3WUZGmNVWvarLIq+hkesU8lHPHuZibq9?=
 =?us-ascii?Q?Edh0vwG7GttFou8lxQ6c4mDhB2Pvjuni2k+me5Vvvi/6ovjbiDrGxHWRmTKN?=
 =?us-ascii?Q?HFGN0Za41//nzq3VHy7ubIs1zKsG77fhQJTehQs8iLWsytX1b81ShWlCu5rD?=
 =?us-ascii?Q?yqWpAn8F6WBApqxCMOwtSsRUNiXZlmCI0tUrxlbQL179bbfCPOLQzpvjrCrh?=
 =?us-ascii?Q?x7fnwNSIVsWpKaqU7jmt5TV5enRX4d8IFuXzN+mF9QyUuYvZ/AvbSQ0uH8td?=
 =?us-ascii?Q?ib/KmwdfCBM4BI0BBt5afXu3G0c2EQOVNHmprWkS3RyZgiu8mos1jvg0BD3D?=
 =?us-ascii?Q?cLyu5X8zsJKuuZqsfWZSJTQ4aToocbQOmrQlmAEznNZmWopB8rs3WIpW424r?=
 =?us-ascii?Q?Z2J8Xf4MjFdT9V46JSpV1VzXx9DVDQzw9nglYMg1S44HVPlwl1H56JEd/o66?=
 =?us-ascii?Q?+sTCXe8NSHcsEV1mFYzoV5jzcNAmenp6SUJ5XsW8ZrHAtSuhSLxNiGMktP23?=
 =?us-ascii?Q?ye5amBZTO1kND/tXhV7cYhMcljNf0OvuolJIuJaG1iT6l2tsdqQdDC2i0wMu?=
 =?us-ascii?Q?64aF/CJvWjUsBaD2CDy5bOILoIw62atHSYUQdsXyY1975dvqtcuxmwaeUryn?=
 =?us-ascii?Q?LzJSQpqCKFGX0TmWiYwty4RmdnORc7y9dnxOcmQJm2Z25u8U153ELhSjFLmw?=
 =?us-ascii?Q?XBAFE0MLLSwkdep30DFGdlcWgsoh+T6z04AMRKGMF1xb53gaNdTzNVoTQK5/?=
 =?us-ascii?Q?yRP8HO2eNS715kWPQm7XZHIkLH2CkIGHOPqepTBMOh5/rvPzypgPH5Az/xnX?=
 =?us-ascii?Q?SIYal5qx0XeuSLEbd8zFf1OAVr8bHuagwMkN5w91J7EEH8Kp6IcU/hhfcL7/?=
 =?us-ascii?Q?ua0pwuWNgquPDNbcj9DS6whvAVGccrb4WQDfVk0bj1z1x/XCYCTKwUA6g20w?=
 =?us-ascii?Q?uBP74HKQgHBi00d9fSqFkegP6SvNVgp9XVE3jAgOJDWOyzFss9RIXsccZdiv?=
 =?us-ascii?Q?3fC9kiIOCDyWeas8+RBfwIUDVUMzYBTFTOgEKuaTXDiuvJlSFkRx7IYCFVeZ?=
 =?us-ascii?Q?o9pEeqejlSt/DTKNxPofXYChOb109eqKNqnfswgLh2gUCGT0IRBaeVDvPysU?=
 =?us-ascii?Q?3dUqiCrJCxP0ndVIxHLNvoKbsK1kqG+p49VGjnS8ycZDK1ZEOY2DfjQpfi4S?=
 =?us-ascii?Q?Ca4GX232U7p9QHJVy2qUVipwmaPshjTslctGrl3B/S8U34kxiHLttbwV8BrH?=
 =?us-ascii?Q?HsT3DdcQJHtH4vO8M7IsgKnjhSfGBDxS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 07:56:54.5674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c76706-7c84-4e79-2d51-08dcb6b68125
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6432
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

From: Roman Li <Roman.Li@amd.com>

[Why]
%d specifier is used for printing unsigned values.
It can result in negative values in logs for unsigned variables.

[How]
Replace %d with %u for unsigned.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 26 ++++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 41270fade5f2..b1265124608b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1285,7 +1285,7 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 		union dmub_shared_state_ips_driver_signals new_signals;
 
 		DC_LOG_IPS(
-			"%s wait idle (ips1_commit=%d ips2_commit=%d)",
+			"%s wait idle (ips1_commit=%u ips2_commit=%u)",
 			__func__,
 			ips_fw->signals.bits.ips1_commit,
 			ips_fw->signals.bits.ips2_commit);
@@ -1331,7 +1331,7 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 	}
 
 	DC_LOG_IPS(
-		"%s send allow_idle=%d (ips1_commit=%d ips2_commit=%d)",
+		"%s send allow_idle=%d (ips1_commit=%u ips2_commit=%u)",
 		__func__,
 		allow_idle,
 		ips_fw->signals.bits.ips1_commit,
@@ -1374,7 +1374,7 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 		dc_dmub_srv->driver_signals = ips_driver->signals;
 
 		DC_LOG_IPS(
-			"%s (allow ips1=%d ips2=%d) (commit ips1=%d ips2=%d) (count rcg=%d ips1=%d ips2=%d)",
+			"%s (allow ips1=%u ips2=%u) (commit ips1=%u ips2=%u) (count rcg=%u ips1=%u ips2=%u)",
 			__func__,
 			ips_driver->signals.bits.allow_ips1,
 			ips_driver->signals.bits.allow_ips2,
@@ -1393,7 +1393,7 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 		    (!dc->debug.optimize_ips_handshake ||
 		     ips_fw->signals.bits.ips2_commit || !ips_fw->signals.bits.in_idle)) {
 			DC_LOG_IPS(
-				"wait IPS2 eval (ips1_commit=%d ips2_commit=%d)",
+				"wait IPS2 eval (ips1_commit=%u ips2_commit=%u)",
 				ips_fw->signals.bits.ips1_commit,
 				ips_fw->signals.bits.ips2_commit);
 
@@ -1402,7 +1402,7 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 
 			if (ips_fw->signals.bits.ips2_commit) {
 				DC_LOG_IPS(
-					"exit IPS2 #1 (ips1_commit=%d ips2_commit=%d)",
+					"exit IPS2 #1 (ips1_commit=%u ips2_commit=%u)",
 					ips_fw->signals.bits.ips1_commit,
 					ips_fw->signals.bits.ips2_commit);
 
@@ -1410,7 +1410,7 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 				dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
 
 				DC_LOG_IPS(
-					"wait IPS2 entry delay (ips1_commit=%d ips2_commit=%d)",
+					"wait IPS2 entry delay (ips1_commit=%u ips2_commit=%u)",
 					ips_fw->signals.bits.ips1_commit,
 					ips_fw->signals.bits.ips2_commit);
 
@@ -1418,14 +1418,14 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 				udelay(dc->debug.ips2_entry_delay_us);
 
 				DC_LOG_IPS(
-					"exit IPS2 #2 (ips1_commit=%d ips2_commit=%d)",
+					"exit IPS2 #2 (ips1_commit=%u ips2_commit=%u)",
 					ips_fw->signals.bits.ips1_commit,
 					ips_fw->signals.bits.ips2_commit);
 
 				dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
 
 				DC_LOG_IPS(
-					"wait IPS2 commit clear (ips1_commit=%d ips2_commit=%d)",
+					"wait IPS2 commit clear (ips1_commit=%u ips2_commit=%u)",
 					ips_fw->signals.bits.ips1_commit,
 					ips_fw->signals.bits.ips2_commit);
 
@@ -1433,7 +1433,7 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 					udelay(1);
 
 				DC_LOG_IPS(
-					"wait hw_pwr_up (ips1_commit=%d ips2_commit=%d)",
+					"wait hw_pwr_up (ips1_commit=%u ips2_commit=%u)",
 					ips_fw->signals.bits.ips1_commit,
 					ips_fw->signals.bits.ips2_commit);
 
@@ -1441,7 +1441,7 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 					ASSERT(0);
 
 				DC_LOG_IPS(
-					"resync inbox1 (ips1_commit=%d ips2_commit=%d)",
+					"resync inbox1 (ips1_commit=%u ips2_commit=%u)",
 					ips_fw->signals.bits.ips1_commit,
 					ips_fw->signals.bits.ips2_commit);
 
@@ -1452,7 +1452,7 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 		dc_dmub_srv_notify_idle(dc, false);
 		if (prev_driver_signals.bits.allow_ips1) {
 			DC_LOG_IPS(
-				"wait for IPS1 commit clear (ips1_commit=%d ips2_commit=%d)",
+				"wait for IPS1 commit clear (ips1_commit=%u ips2_commit=%u)",
 				ips_fw->signals.bits.ips1_commit,
 				ips_fw->signals.bits.ips2_commit);
 
@@ -1460,7 +1460,7 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 				udelay(1);
 
 			DC_LOG_IPS(
-				"wait for IPS1 commit clear done (ips1_commit=%d ips2_commit=%d)",
+				"wait for IPS1 commit clear done (ips1_commit=%u ips2_commit=%u)",
 				ips_fw->signals.bits.ips1_commit,
 				ips_fw->signals.bits.ips2_commit);
 		}
@@ -1469,7 +1469,7 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 	if (!dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true))
 		ASSERT(0);
 
-	DC_LOG_IPS("%s exit (count rcg=%d ips1=%d ips2=%d)",
+	DC_LOG_IPS("%s exit (count rcg=%u ips1=%u ips2=%u)",
 		__func__,
 		rcg_exit_count,
 		ips1_exit_count,
-- 
2.34.1

