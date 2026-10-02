Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77565CA5FDD
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 19:33:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3190710F9D2;
	Fri,  2 Oct 2026 19:33:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q+ofNpPz";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61DBC10F9D8
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 19:33:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2nbsSS8CfF6PRa60bHQGKhrUNry+CpnFdI4aEjeFZRF4cPX7cCLmsKMbAvaRHww771NI+4zf48kEgqOia9qZ8S+FlkquigYOMQTMiGUCqLtZ+AvefuJWu1QlUCCh26hsx2dMnuIDRgUdBU/lSbw3gNVFBGw4tYU/GChnFI7OJsQ/iWkLoqx+JPVyEGgezWBFYC+mLTLgQVra0px2GONgwzOZYBzTXeLGRLki9Nhg38ZLvw/vo+yg0VreUO0iymp16p1wE2bGLx8LR1LVdA2LbgqDneaXY/x2Qv0tDHuQPwZKCroKoaRPcfP0BGAPrs1ph1fB4x5DW3Zymwx+nTVGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEJhoQ4UYoRQfwt3+RGL8vi1Z90Ofrzf80x0HbG7PXk=;
 b=olMFEY0xev1paBDTBXxinPGaEGYXhX+2X1vpKGaMFhruinL8+9Cvpus92jf7j6K7Df21duMGfeFs45jrQpK3VjjvPtBJ+yxvamqKz9RbrefpWDXpRIwSe+HrIxsG3GmZxMDBKvXGAt1cpAzyMQQjvb03AHQA0aEPEWVPoH9WjbfVvMo8IultEASM93m4MTbk9KZcSXYZFKlo0IdNtgpg3FQOgxXykXzbpxaqkd1GKPV1xb01P2jlPn/by+II2M/F1bAujKyj0lOoO5Ro+ezoDDv7u7FkSXyotfoTK0uuyYnxSpiuz4MLqTWBgGKa6mNG4BSIXjtlqO/KqDKaWy0z2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEJhoQ4UYoRQfwt3+RGL8vi1Z90Ofrzf80x0HbG7PXk=;
 b=q+ofNpPzKmYuOIZ7QfAgcCMoNx4K9UhyPozHq8s2Wk0kIbwV+xrt330gSdMEAgRg+LKALcNCn4zB2TORubspdHpfcXEHIC/iiMtn5+FcN6k5q+O01Imr+JwwPivZ+l1PLe2u9nvFDfJTqvcc4La/z+yOKhJ8+9ynPSAfi0uHbdc=
Received: from CH2PR12CA0030.namprd12.prod.outlook.com (2603:10b6:610:57::40)
 by DS4PR12MB9707.namprd12.prod.outlook.com (2603:10b6:8:278::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 19:33:19 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::12) by CH2PR12CA0030.outlook.office365.com
 (2603:10b6:610:57::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 19:33:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 19:33:19 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:33:15 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 2 Oct 2026 14:33:14 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler
 <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, James Lin
 <PingLei.Lin@amd.com>, Chenyu Chen <Chen-Yu.Chen@amd.com>, Relja Vojvodic
 <Relja.Vojvodic@amd.com>, Chris Park <chris.park@amd.com>
Subject: [PATCH 11/17] drm/amd/display: Update link training no timeout
 behaviour on HDMI
Date: Fri, 2 Oct 2026 15:32:34 -0400
Message-ID: <20261002193240.3441018-12-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002193240.3441018-1-Roman.Li@amd.com>
References: <20261002193240.3441018-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|DS4PR12MB9707:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f8b16c-735e-41a1-e2ee-08df20bc0363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|22082099003|18002099003|6133799003|11063799006|3023799007|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: UJ6eCIEyI9+RyfypER/Af9Oy5OdRlVFTJnEMrp7UaioPfKplZKG68YkzTT04KVRbdRsV+z+s8zmjlsAxt0WgGb+fbpyocl9BYo2U9SUkbo4qLgnU/RFyK0YQi/VNfHHiV2VMKo4C0iqAuIzRnvCMFx1jCDQDeiyypX1x4ymLw5x+bx9nucuwJ69hkycATPjsip2RYu+lZcEQAI2UK2ZRLaXZiHti8Zkja3tGJV3gFmLpnEpny2D56eEdlyGdR9cGzcHlpzywzCgVNv+uyX+UQtlxSHigpZSa+z8jWhfZEtvfxGUdRewxS7q7FPmoRiilwrZuBFrvT5wgRk6SfZT8qXvRecFS6SNuY4swxyFcRC33lCUFfwP8S1ypm1+aO82L5vzBrHw01LG9fqPQDd0mj3C5SzIC+HL9DmcIR6p6jzL+K2fNrk0ao1A71B7giRZXIZwf6XGuaV8ST/75W2e383+WsegPLA+izj8OwCVbIQKcE8JgimaTFzYMqLJLGHmdcNRgwWmcTG3TU+1+yL+RfPBuIMywJCUJAgjLbtH/EkPFozCesuldFRcdNjpnjVPbrODIUHQ37+kPJ5AmxdH2eLViXF5CqYTvVcDiGENgv8e87c8N2AeK8vU1elNwa6PZSj0JkaTpUwtcxfSmWA9/6T6qgONkdPuI9P/UzeL42FgnFe36YDGcpOgP6D7QExTZuPD5Z9NKYL1DlYJ7mHtIrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(22082099003)(18002099003)(6133799003)(11063799006)(3023799007)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aDUqnBLX3qsmq2QR4b0FubY/bEC/tooXFhZFDIHbuRUKZv9szx6XLckiUsC/mTEbu2wUx50dPv7x9ieTcQuc33nSkJNNtD+mnDu52hStcD2UJEpl9EBcwgDGiSfT7J0AcHz9PNW9GjO2aVh9fugXiQfHn4kDlDY1TOnbLkJCj14DM3f9jpph6JXv04P/nWJ4pQdRZXNOd0zStHFTkr88g9OhoWB4TA7220Y3AAyia3Zsgy/1FX6mk9nvZzhRpnCSL/9Oaw/lqrvhf06YyPW1232iVxmekpoQMzMuKZKuufNmV7bMiQa5DvZgzB4KU0OHR8PT9Lls3lu/lbJNi6E9lKhEjHgDqmX1V/CMfKN/DWQQUf169BEMwMLGuydWNUWDzDs/Bs0pje4ykr0jn/aPHy6IdFHKDkuiwna3uiUlBu4y7E5fohfVIZD+HcR+NyNv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:33:19.2431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f8b16c-735e-41a1-e2ee-08df20bc0363
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9707
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
- HMDI link training compliance testing fails when no timeout bit is
set
- Update condition to skip some link training logic when no timeout
is set

Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Relja Vojvodic <Relja.Vojvodic@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../amd/display/dc/link/protocols/link_hdmi_frl.c    | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
index 2f1b8c0bc8f8..5e0979ac3dcf 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
@@ -561,6 +561,16 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 				prev_flt_update = scdc_update.fields.FLT_UPDATE;
 			}
 
+			if (flt_no_timeout) {
+				offset = HDMI_SCDC_SOURCE_TEST_REQ;
+				link_query_ddc_data(ddc_service, slave_address, &offset,
+						sizeof(offset), &test_req.byte, sizeof(test_req.byte));
+				if (test_req.fields.FLT_NO_TIMEOUT == 0) {
+					FRL_INFO("FRL TEST REQ:  FLT_no_timeout = %d \n", test_req.fields.FLT_NO_TIMEOUT);
+					return LINK_RESULT_SUCCESS;
+				}
+			}
+
 			/*Set TxFFE = TxFFE0*/
 			/*Program FFE_Levels - scdc_config has this field at 0 */
 			if (override_FFE) {
@@ -583,7 +593,7 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 				FRL_INFO("FRL LINK TRAINING:  TxFFE = %d.\n", current_FFE);
 				override_FFE = false;
 			}
-			if (scdc_update.fields.FLT_UPDATE || flt_no_timeout) {
+			if (scdc_update.fields.FLT_UPDATE) {
 				offset = HDMI_SCDC_LTP_REQ;
 				link_query_ddc_data(ddc_service, slave_address,
 								&offset, sizeof(offset), ltp_req.byte,
-- 
2.34.1

