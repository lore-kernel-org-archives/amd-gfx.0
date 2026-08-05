Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC0EC55822
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A57910ED0E;
	Wed,  5 Aug 2026 06:41:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lGQDq+Ms";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011069.outbound.protection.outlook.com [40.107.208.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D845410ED0B
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yk90v27ELUYL8tx6vfepAZ7iBHWIPM4xFODPsCNIDFJoHs7P6PCrzUBAbbiP1RWv2WzZAxY79PMhB5YEvxhMeRO5lPv2NdKZHZY/x8XK5igiEoCJVOwdid6k2/MVUCwIiQcFHuzdZ4Bpj8kHIg6Oeuw2smYA61Z7XupPXxr/fB0hNPvBwLpS6uigoY8vFytkyiEpm9ibLRBu9CT6uj1cFVoVOqHdO7z75nCJ6TQFZwft+45FS6ef3O6CuJpNRQ7UBhaENm+3Y+foTNKvMdRczSQaZiucaRybo5t/mpyFNS6V5R1MJbSutSoFL769P8ZPeIyoiQUBTh/ueJcHXkbt5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzve9vOfergyohG34PTgk6lgHx37D1ci3OFEmzoaMkY=;
 b=T1lVa0Jv28Co5QJULNKP6yIOWeFrxn1EU1tOtQMJqq14XSvjvR4A6CwYfQPGSnjtHspZOAEs/d1C8WH9yJObVcSFduyg4GVKDHcSr8rSeIqysrFPu/SA+9URP+6sDHbEUl8K707lET85tCFz2gpAhQ/SrsyUaeLj1YRDbT5NDMPEXKonL79sGlx/KKaDOG1wqaXmEtiFZGXN4NhuqbUNSHCM/grM9P7bn0m+P+v1MwYsSGxi1cm8SV+XQc+r4eN8ThClU8AmgrXogrqz6gR4kF6npIz/PN9wdmXnF0jjSV9KoG7f4Ol89rpBHCK9AE0pFMKbQavtMREVNtyA20HiMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzve9vOfergyohG34PTgk6lgHx37D1ci3OFEmzoaMkY=;
 b=lGQDq+MsG9Q/wV9HDnG6DNdxmz5ogUZhN5/avFw0dQR6+/VLFdTGUVPk1/V+1Z4eGHmbI9GQEPMaP8F80jrcMMP6NKhpeb9dcyYCJ+1SXNZz2Pvxq1hsQWJT+RR5cfPW4O/BoM89vt3xUUGqSk9CBdAHDbDW9MDdc8F892TfGd0=
Received: from MW4P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::29)
 by CY8PR12MB7172.namprd12.prod.outlook.com (2603:10b6:930:5b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Wed, 5 Aug
 2026 06:41:14 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::22) by MW4P221CA0024.outlook.office365.com
 (2603:10b6:303:8b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.18 via Frontend Transport; Wed, 5
 Aug 2026 06:41:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:41:14 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:41:08 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:41:05 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Relja Vojvodic <Relja.Vojvodic@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 20/34] drm/amd/display: Update and revert FRL LT Timeout
 behaviour
Date: Wed, 5 Aug 2026 14:36:32 +0800
Message-ID: <20260805063937.2145774-21-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|CY8PR12MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: 00bda5b1-ee67-4836-e0b7-08def2bc8b89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|3023799007|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: jIxBy698xOSiCXH4rMSbYlJPHCG0MPeKD/AcK5wLwPbnBZXye4JJyAOWjKjEzORwc2E/JlhYtpdYE9t3Zlgo1bOUD19QLYKM57SJJaEcyCte/MWutkl/9JuWQ5oRrOHvqFbPoJ3FZzEg8WTlXqtCd/DBtbHsCm8v+IDEIyy7YNWdG3WtMT/cJ1sLjRWYYWh+lx6BNH2jhGC05G+LB3UZgcIlrvfiidEJ/clMM4F9UmAsMbDAQZEeVIeJjVdHsk03mLAfXZ14fdjy4nreo7/VgEt9jHqadTgMkA23ZHHmmpIUDdYEG/3Eq1c3Yxmop345Ol0C7rhtaoZ/y6zTWu8Rh8yWXLbnkT3nKSRkcLxq4L5ylfGcSnPLeTkSdP1bJgkSg9DhBJ2Yh/ileo9zPvtRA8YMJbT0aK0Nnzf9pzt1eKHIC1D/jQOmHjobLGbIUmYArUq44kNfKgCvQS1602YGUEHwqEDyl+OzeOnzPQsZUd98fDmNTxfSJxGC8NG8Uu6tDjjzE0l4HPq+JWOVOE1YXL0mFxxjC2bkA6/0QbQ6F81IuabuqFZl/nLbtgPccz5fl8mkJuQSeB19ABXSeccN++GyN7X0znBDnLMsPGUORZ2CRh023WfL8VsJkF6pvM+6138oZWcbHVE1xphuYqu9scIqGrM+oRLTmB7XfwHRevVsktPk9bHmWao0BB6sl4uO/3YXPTuIXD1twlWbYt4WrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(3023799007)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: J75S3lhYwFoHgJb5BgFrflUrvj/z2jRTJpvBEFA5cOaDR97tA1G7BFs8rrsW10UrrLmKEfZcc3d4crI74S8C+NBtfUPyPwnM5D5U0NG7QhlgxE0ObIi6sbCnpMMeivZg6YhUllIBqit41eNQ06PdvDajpNB9Ci3F9Tc+f3oLmM5dH6ibpcQ/kaJJbFl5aJRRk+s+OD2IlaIgAONBgp/tVlI6gMGg8OjpBjwLj3lU4b7LqVnTe1TRjrzFtvjdUjn2qRoJ/025u4yHJlOv89d3JD0TVEHwXlpNj+hdD4HJ8er3AwkOg+Y1J381CrFwg6F+j11wlQa2tEo85+iEK/KspZFNdYf4oMgEUMj2KrSx3T/LfQeua4oTKfQundlBCHlNAZuF67IiFj2HZdSVKx82c9Nt2iJcc2Wmg8uO/x8MOdniUR73dnMjWVBbCSYCi3N2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:41:14.1259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00bda5b1-ee67-4836-e0b7-08def2bc8b89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7172
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

From: Relja Vojvodic <Relja.Vojvodic@amd.com>

[Why & How]
- Revert logic to fallback to polling if LT no timeout is set
- Update LT timeout to 300ms for appropriate link rates

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Relja Vojvodic <Relja.Vojvodic@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../display/dc/link/protocols/link_hdmi_frl.c | 32 +++++++++----------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
index 714168e1ece6..7f930097da18 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
@@ -528,10 +528,10 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 
 		FRL_INFO("FRL LINK TRAINING:  Poll for FLT_UPDATE.\n");
 		/*LTS:3: Start Link Training*/
-		/*Start FLT Timer = 200 ms*/
+		/*Start FLT Timer = 200 ms, or 300ms if link rate >= 16Gbps*/
 		num_polls = 0;
-		if (flt_no_timeout)
-			max_polls = 500;
+		if (link_settings->frl_link_rate >= HDMI_FRL_LINK_RATE_16GBPS)
+			max_polls = 155;
 
 		while (num_polls < max_polls) {
 			flt_poll_cur_time = dm_get_timestamp(ddc_service->ctx);
@@ -572,7 +572,7 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 				FRL_INFO("FRL LINK TRAINING:  TxFFE = %d.\n", current_FFE);
 				override_FFE = false;
 			}
-			if (scdc_update.fields.FLT_UPDATE) {
+			if (scdc_update.fields.FLT_UPDATE || flt_no_timeout) {
 				offset = HDMI_SCDC_LTP_REQ;
 				link_query_ddc_data(ddc_service, slave_address,
 								&offset, sizeof(offset), ltp_req.byte,
@@ -680,21 +680,19 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 				/* Workaround for DEDCN3AG-111
 				 * HDMI-FRL Incorrect Serialization Order for LTP4
 				 */
+				if (flt_no_timeout) {
+					return LINK_RESULT_SUCCESS;
+				}
 			}
-
-		}
-		if (flt_no_timeout) {
-			return LINK_RESULT_SUCCESS;
-		} else {
-			FRL_INFO("FRL LINK TRAINING:  FAILED - Timeout waiting for FLT_UPDATE to be set by sink.\n");
-			write_buffer[0] = HDMI_SCDC_CONFIG_1;
-			/*FRL_RATE*/
-			write_buffer[1] = HDMI_FRL_LINK_RATE_DISABLE | (0 << 4);
-			link_query_ddc_data(ddc_service, slave_address,
-					write_buffer, sizeof(write_buffer), NULL, 0);
-			hdmi_frl_LTS_clear_Link_Setting(ddc_service);
-			result = LINK_RESULT_TIMEOUT;
 		}
+		FRL_INFO("FRL LINK TRAINING:  FAILED - Timeout waiting for FLT_UPDATE to be set by sink.\n");
+		write_buffer[0] = HDMI_SCDC_CONFIG_1;
+		/*FRL_RATE*/
+		write_buffer[1] = HDMI_FRL_LINK_RATE_DISABLE | (0 << 4);
+		link_query_ddc_data(ddc_service, slave_address,
+				write_buffer, sizeof(write_buffer), NULL, 0);
+		hdmi_frl_LTS_clear_Link_Setting(ddc_service);
+		result = LINK_RESULT_TIMEOUT;
 	} else {
 		FRL_INFO("FRL LINK TRAINING:  FAILED - FLT_READY not set by sink.\n");
 		result = LINK_RESULT_TIMEOUT;
-- 
2.43.0

