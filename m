Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F779CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 479C210E840;
	Wed, 10 Sep 2025 05:27:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F7nlOsBK";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EA6A10E840
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:27:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6h9/lKag2Bf3XR4br+2E5IYNwffTNBrd9Uxd1j2dln362ZoB9uCQvznpen/EKI6XAhnJxr7KtrOPCgLPOxL4nmB3ITR295urNNr9V1ovkjU7V4xNFPPW5p1oUrZP6Ipp+KDDwOkImB806WWJLT6yvodZ1cIvrWL9Jez2pG+dqTyIXaG5nh8XCbwSnJRvEfSlMy7mnG9d6MMfsaOFAVU36qELXqXSVQ0QF4hCUke3jkFSsxYTHEsGoBa48r/eOIveN/t9rNlVZuo80wPfjz+U4JfQcKKin7vHoe/UEk0LVpbtK5yglgpY+x/ZCjjzKQJ1hIF5gF3gr3KXf60gDOnHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6d1Y1WJolnMOWlQudyKl5vPfgJlicWcPAi5kGu4XIw=;
 b=W0Wglm/+T47FzkwnWqeLsgRJQ83/uFHph5rEKM1DPdsy/dWLlE1n9WK7zgMnJ2YklcPkoVcgXdfRX0odufVWVSqLQuG27uGoLpfwyGXCXoZvIIvglwkszjllfRoZ2FY06smrn8zE//IKDjZSgTsRoNAr9JOkHlSdSxMIZ2BHmn9Vjflr8t7p+aBHBh8XM++x0LBzFzDsXLt5+3Jd5SS2PuwxYGV6JE71J0f0Yz4pODvaCG2f6YGPtdJxEkEkbQ0rQEgMJuAf5NYSx3Al1JhGRyOny8ew2MpgMf//zCEP7D9D2yhDgmH06Mwh/YKhyS5qa1pXe90hAasm7MALfIzh6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6d1Y1WJolnMOWlQudyKl5vPfgJlicWcPAi5kGu4XIw=;
 b=F7nlOsBKvk0J2YUKIzrQlat1VFLNp02VK95wuQwvhZwYoKQK/1PKbJ+UtcWRlPDMHVtAq7X50iNb6q1rly0aWQxnjWiv/lbCucQRmfr56CBwM3IfZnaJrMS/QfQz9h8a+DQtLieG5fgKFdiH1u+IiyM/14DmDQ/WKgApOQ+t25Q=
Received: from MN2PR05CA0022.namprd05.prod.outlook.com (2603:10b6:208:c0::35)
 by CY1PR12MB9676.namprd12.prod.outlook.com (2603:10b6:930:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:26:56 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:c0:cafe::82) by MN2PR05CA0022.outlook.office365.com
 (2603:10b6:208:c0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 05:26:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:26:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 9 Sep
 2025 22:26:55 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Sep
 2025 00:26:54 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:26:51 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Sreeja Golui
 <sreeja.golui@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 03/15] drm/amd/display: Fix DMCUB loading sequence for DCN3.2
Date: Wed, 10 Sep 2025 13:22:05 +0800
Message-ID: <20250910052620.2884581-4-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910052620.2884581-1-ray.wu@amd.com>
References: <20250910052620.2884581-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|CY1PR12MB9676:EE_
X-MS-Office365-Filtering-Correlation-Id: d8763bb9-f63f-4ae1-8f09-08ddf02aa817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qHvfydP1OErpGHzQ2YuWrLmM1AlkDD1IBmEmJmakQXoby2dZcEaFyi/+Yfrr?=
 =?us-ascii?Q?kjBRkqTDZR296YUapjWTVlfNlGi1+gaFbpRVfpx+16QGs7wbdCbkD99SC/VJ?=
 =?us-ascii?Q?Ye7tkKgkCyCJY6kb0Z2sgrQYidrIP018wUy2OMWWsZtyQ4jGPkGNVH9oOTTg?=
 =?us-ascii?Q?X9uDT9SSv34t/Xq9M2oC4XeAqJM1/Hg4TJLRFNHoQRuFtYR9xTkXTuR1YZqx?=
 =?us-ascii?Q?yatvNE338v3XLoGMQO4/4DspByX5RUR91PLj4knp4NiwSvuREY5ZZmR7Tr//?=
 =?us-ascii?Q?m4bVBZLboMyS4mFMT+MxHFsgP4NdmvcAvt0A0N5kXjZ6be98X7B4GfT6vXJc?=
 =?us-ascii?Q?Zxaw5TX0+JTAasrZn/2wrQIqoMbamC/l19a5q6hEa0bI/OvKwe+uK/7FGyWR?=
 =?us-ascii?Q?CCwWyAOiacYColU1cVbJP1fP/o7l+WmhpPZEqO8gxlcYwzn6tqjzXec6uNRf?=
 =?us-ascii?Q?QX3UKkkFsw24afQIzVZIHN4mmG89HdEkwkXpm4Lnk5FmFOE68oBMQLjvKLSW?=
 =?us-ascii?Q?if6mVwVOJEeVyNcjxUXKxD8d++C951jgx427odvc9Fo81GGlMjEHK45UG6n/?=
 =?us-ascii?Q?L0zYWSQZlGpC+Fa8/XXCVdwgDNmkC/DTAQd4G836Nva3XXJVFAW3SLuWk4P+?=
 =?us-ascii?Q?8uNKfZb5T5URAV0JVBKNRFvxfysoiyOiNMDdaKGY1hDINQokMYkeYHKTAFzY?=
 =?us-ascii?Q?6x4B0otwBoRCeliu8F3BUpRDDHIfP+h1bB2XmUhIuk6CsVBjblghW0P02a4F?=
 =?us-ascii?Q?KDV3GJ3lSYoB4xTfoNamukatbb4HFnICOkMpVy+DJ6/MROhQALTydO5m/QeV?=
 =?us-ascii?Q?9Ohug2RN11dQD3/GONC1IK/FUEzWW63a11njlLvmtI4Ha+/c5ThZak/YWj1v?=
 =?us-ascii?Q?aSNjk8IOAxg2QFx1ojrnRM8IMq2CS9zjFl1CKPpUKbn6ratxc64RaKvZ0Q5r?=
 =?us-ascii?Q?vrt3YQjV8DgxUe3gSvQNbUwpa9Z4FPMtkzPGJXPuuyXkDgYryt4Ryqg7TBLI?=
 =?us-ascii?Q?gUfQC8WMvJisb6FhCOVDpFp/0k75Iu7YMgTAtBW6yNSW8et5EofEEOBhmnrY?=
 =?us-ascii?Q?JxZaK0dnA+jusvVSOeJSXQSXb8U5ZCpzCgKgo00obkVaxzwMOpkSCOB0yORp?=
 =?us-ascii?Q?TV8T7/FHJAJ1+w2Yje4mbZZgyNeoy70k6o5PgoHiapk8DY4lzqp/iYlaZMJm?=
 =?us-ascii?Q?w7gL1uOcaKTEMVVqEi9K+B9cyrwQQv9ZNUB/vy6a3uZastfENSw3eLG/xcFn?=
 =?us-ascii?Q?IcP1VsDwFJpj0FkRxWil9fFjBoM5/bVOKHvNTie4JaV2BX5QV22+98Z6oSMx?=
 =?us-ascii?Q?m9oiae93IzTE1Vv/mybi8EU0rO4p9PWkb+VderBLQlY0l+IQQ0GGgzF8KuZa?=
 =?us-ascii?Q?nrKmhbZodWcOO9tmiCzcDPzO8TuMNC4Rb9HZyD2+k6yAWVdmj+9XDIsvcU/S?=
 =?us-ascii?Q?LukuV1+oOLCcWlgvvnji/AFa7zqv9ZG2VtvFbrN2cY5BT8t1flNGN2fbp6WC?=
 =?us-ascii?Q?6BjB1wuZ8QEl6Ko5gKpK8yOlNZicv5pmhThh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:26:55.5444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8763bb9-f63f-4ae1-8f09-08ddf02aa817
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9676
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
New sequence from HW for reset and firmware reloading has been
provided that aims to stabilize the reload sequence in the case the
firmware is hung or has outstanding requests.

[How]
Update the sequence to remove the DMUIF reset and the redundant
writes in the release.

Reviewed-by: Sreeja Golui <sreeja.golui@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c | 53 ++++++++++---------
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.h |  8 ++-
 2 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
index e7056205b050..ce041f6239dc 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
@@ -89,44 +89,50 @@ static inline void dmub_dcn32_translate_addr(const union dmub_addr *addr_in,
 void dmub_dcn32_reset(struct dmub_srv *dmub)
 {
 	union dmub_gpint_data_register cmd;
-	const uint32_t timeout = 30;
-	uint32_t in_reset, scratch, i;
+	const uint32_t timeout = 100000;
+	uint32_t in_reset, is_enabled, scratch, i, pwait_mode;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &in_reset);
+	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_enabled);
 
-	if (in_reset == 0) {
+	if (in_reset == 0 && is_enabled != 0) {
 		cmd.bits.status = 1;
 		cmd.bits.command_code = DMUB_GPINT__STOP_FW;
 		cmd.bits.param = 0;
 
 		dmub->hw_funcs.set_gpint(dmub, cmd);
 
-		/**
-		 * Timeout covers both the ACK and the wait
-		 * for remaining work to finish.
-		 *
-		 * This is mostly bound by the PHY disable sequence.
-		 * Each register check will be greater than 1us, so
-		 * don't bother using udelay.
-		 */
-
 		for (i = 0; i < timeout; ++i) {
 			if (dmub->hw_funcs.is_gpint_acked(dmub, cmd))
 				break;
+
+			udelay(1);
 		}
 
 		for (i = 0; i < timeout; ++i) {
-			scratch = dmub->hw_funcs.get_gpint_response(dmub);
+			scratch = REG_READ(DMCUB_SCRATCH7);
 			if (scratch == DMUB_GPINT__STOP_FW_RESPONSE)
 				break;
+
+			udelay(1);
 		}
 
+		for (i = 0; i < timeout; ++i) {
+			REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &pwait_mode);
+			if (pwait_mode & (1 << 0))
+				break;
+
+			udelay(1);
+		}
 		/* Force reset in case we timed out, DMCUB is likely hung. */
 	}
 
-	REG_UPDATE(DMCUB_CNTL2, DMCUB_SOFT_RESET, 1);
-	REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
-	REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 1);
+	if (is_enabled) {
+		REG_UPDATE(DMCUB_CNTL2, DMCUB_SOFT_RESET, 1);
+		udelay(1);
+		REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
+	}
+
 	REG_WRITE(DMCUB_INBOX1_RPTR, 0);
 	REG_WRITE(DMCUB_INBOX1_WPTR, 0);
 	REG_WRITE(DMCUB_OUTBOX1_RPTR, 0);
@@ -135,7 +141,7 @@ void dmub_dcn32_reset(struct dmub_srv *dmub)
 	REG_WRITE(DMCUB_OUTBOX0_WPTR, 0);
 	REG_WRITE(DMCUB_SCRATCH0, 0);
 
-	/* Clear the GPINT command manually so we don't reset again. */
+	/* Clear the GPINT command manually so we don't send anything during boot. */
 	cmd.all = 0;
 	dmub->hw_funcs.set_gpint(dmub, cmd);
 }
@@ -419,8 +425,8 @@ uint32_t dmub_dcn32_get_current_time(struct dmub_srv *dmub)
 
 void dmub_dcn32_get_diagnostic_data(struct dmub_srv *dmub)
 {
-	uint32_t is_dmub_enabled, is_soft_reset, is_sec_reset;
-	uint32_t is_traceport_enabled, is_cw0_enabled, is_cw6_enabled;
+	uint32_t is_dmub_enabled, is_soft_reset, is_pwait;
+	uint32_t is_traceport_enabled, is_cw6_enabled;
 	struct dmub_timeout_info timeout = {0};
 
 	if (!dmub)
@@ -470,18 +476,15 @@ void dmub_dcn32_get_diagnostic_data(struct dmub_srv *dmub)
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
 	dmub->debug.is_dmcub_enabled = is_dmub_enabled;
 
+	REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &is_pwait);
+	dmub->debug.is_pwait = is_pwait;
+
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
 	dmub->debug.is_dmcub_soft_reset = is_soft_reset;
 
-	REG_GET(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS, &is_sec_reset);
-	dmub->debug.is_dmcub_secure_reset = is_sec_reset;
-
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
 	dmub->debug.is_traceport_en  = is_traceport_enabled;
 
-	REG_GET(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE, &is_cw0_enabled);
-	dmub->debug.is_cw0_enabled = is_cw0_enabled;
-
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
 	dmub->debug.is_cw6_enabled = is_cw6_enabled;
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
index 1a229450c53d..daf81027d663 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
@@ -89,6 +89,9 @@ struct dmub_srv;
 	DMUB_SR(DMCUB_REGION5_OFFSET) \
 	DMUB_SR(DMCUB_REGION5_OFFSET_HIGH) \
 	DMUB_SR(DMCUB_REGION5_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION6_OFFSET) \
+	DMUB_SR(DMCUB_REGION6_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION6_TOP_ADDRESS) \
 	DMUB_SR(DMCUB_SCRATCH0) \
 	DMUB_SR(DMCUB_SCRATCH1) \
 	DMUB_SR(DMCUB_SCRATCH2) \
@@ -155,6 +158,8 @@ struct dmub_srv;
 	DMUB_SF(DMCUB_REGION4_TOP_ADDRESS, DMCUB_REGION4_ENABLE) \
 	DMUB_SF(DMCUB_REGION5_TOP_ADDRESS, DMCUB_REGION5_TOP_ADDRESS) \
 	DMUB_SF(DMCUB_REGION5_TOP_ADDRESS, DMCUB_REGION5_ENABLE) \
+	DMUB_SF(DMCUB_REGION6_TOP_ADDRESS, DMCUB_REGION6_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION6_TOP_ADDRESS, DMCUB_REGION6_ENABLE) \
 	DMUB_SF(CC_DC_PIPE_DIS, DC_DMCUB_ENABLE) \
 	DMUB_SF(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET) \
 	DMUB_SF(DCN_VM_FB_LOCATION_BASE, FB_BASE) \
@@ -162,7 +167,8 @@ struct dmub_srv;
 	DMUB_SF(DMCUB_INBOX0_WPTR, DMCUB_INBOX0_WPTR) \
 	DMUB_SF(DMCUB_REGION3_TMR_AXI_SPACE, DMCUB_REGION3_TMR_AXI_SPACE) \
 	DMUB_SF(DMCUB_INTERRUPT_ENABLE, DMCUB_GPINT_IH_INT_EN) \
-	DMUB_SF(DMCUB_INTERRUPT_ACK, DMCUB_GPINT_IH_INT_ACK)
+	DMUB_SF(DMCUB_INTERRUPT_ACK, DMCUB_GPINT_IH_INT_ACK) \
+	DMUB_SF(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS)
 
 struct dmub_srv_dcn32_reg_offset {
 #define DMUB_SR(reg) uint32_t reg;
-- 
2.43.0

