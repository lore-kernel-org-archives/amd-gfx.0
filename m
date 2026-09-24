Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE8FC98318
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94BEC10F722;
	Thu, 24 Sep 2026 18:46:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nOu/pakx";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011054.outbound.protection.outlook.com
 [40.93.194.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33F4010F720
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIeFhKlemMougRsHUfqAcuI6nIhNmNPDfQpUq1XN2/7BwWtgZokUWRGH2r104irCQnug338R1OBGBVyldNl74HPIHBdlfDzVU0yxTBuzjW1sK4zRysS4M8aTQnUXqwfdX5MMCLx5xNJbRfsAjQFrchCXC/eas//plpPJdPdNItybqLkW25y3aFaK9al1wF00DsWCcAzbuMtKy11UpIZHB/Y/e1IHBIBR7nyOa5pSl3cY6IIrDXmuJnVSWlGG9xy11NBSRmv7pE3NkjZooEYpY+ty7Hv3NQivyn85KHpJwguxiAP31ZPxwf8+8OFy3WXuCHGDvruEa5w0duUiu/3Lsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NwDvFNZPN4iEW8SlN57ByfnaXTWlHHZqHsduudj2YQ=;
 b=tj2j0fUUTtLFUOjkePHCuH8nawXnVMprpV4blKI0a0vjaer37nYZaMts3xf+mpVWoZqMGtlBGDlXHhfQBrGz0X1hgLeZ8Xk8qgOwPx7MjB6gX4fz/tTwoMLhQo0yY8fiF4NOehmHQ5vYpdg7zp6k2sGLdFaW94k37VaV83KY5M/Lq994AC6KKQP5yywMczlaHsvsolzBFCwPI3ybrEhoC3xP1MxOqA3NVe3EkB/Wx6yAb3xGM7MjlVTS853xzVXTbSGkmTRUzK/zfur9OW+aPwPebFgVjrx+GruktQx/5UVz+ycjS9UJbCN/N8+a/TftwkfPVHeg+ZDuGeg1QqSZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NwDvFNZPN4iEW8SlN57ByfnaXTWlHHZqHsduudj2YQ=;
 b=nOu/pakxRCQG2m77GcCch7IUU5H1gB3I10Ij+VVCvyqPExcc6cGsDF9hVn7h8OPIbY+xpkk9fqaarIveRKypIyYmvMiUJRAH1ktLIQdBllGkF9HugyRgApH6YmWK09yVVZGAEZk58QMbpmfaZgzBtkdUnWiGReY+dwigO1OQyoc=
Received: from SJ0P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::21)
 by SJ2PR12MB8978.namprd12.prod.outlook.com (2603:10b6:a03:545::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:46:15 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::8c) by SJ0P220CA0023.outlook.office365.com
 (2603:10b6:a03:41b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:15 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:03 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 04/34] drm/amd/display: Fix DCN60 UTM QoS override for invalid
 PMFW table
Date: Thu, 24 Sep 2026 14:45:17 -0400
Message-ID: <20260924184824.596894-5-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|SJ2PR12MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: f0af9ab2-ba5f-42b4-ceb9-08df1a6c1ceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|22082099003|18002099003|3023799007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: zw7JdPw97xLry4KRLCZq48c2usKaUf7IhpjK9xTaix0Wr6pyoLVxoqEOtYLbw9eQ4bKZUVxnWkb3E5A2wgiYZTkxF2X9LWwqv6v1cwrNEhJrkVfeGIy7cEuij/PczLuqmgSnYDezU1LXEAIiKLclEs+jx/jEsTHBqB9jAU2B782b5irkcRkcqb2/3ahVBnITgrbuB13YEro0Zs/we2ANfuziKNV+esUpQSqb3qomfD0ODI0dcF9hsQAiyTmNAnfcGagecMA8//HibILM2p0m5i/KxEG/uKiSM+sVsJI0ha6fQso6EtJpelkO+NVvW74K3kXTRywTiwAWS2H57b9hFKTMTcDPiRunUJKpxHNPsZfW5oBuaCmu6GSE21Vjv5ihXZbnUvLuNp2PI2sZZxG3Z3jlejuzIEFAgYHMkA9gPVNXuXvPdqYxZCV4zlO1d5xVRoPEwH7yDqiPMB1hRyIjoEfglNYyahjO7qI59tMJ55FjLHChClZ3oX2raD/hGh1B8fIjEwd0lAYgN0IMpc90b3KL4UI9cYV7u4faAoI2lAaFxvciVAj7SaM0tq5coPElW6nTKYKw6kMO5dt11/rT3WzHGrG0U15SBa3zfcld5LFa/ewCT18Date4qzx8w2nrbxqd2eJ9HLqqu8rcmEhV6oh3X5g98yesKekRL5ZKtxf6OLjKxVl4h0UL+vXLsBIFuH+t/lnddrlv6dplzZNgXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1XIRb/xuzS/z1GvIwKWD89mxSIee6Avb0HoJvDehPEQ7rCPNxfv6xKQB8Hy/JBo4lsbjgAQKI1p45nDZ6PPcjqe3OcfSAFHCO/oN36CiauL078qt/hsBAhmNw4Pv71UWu2okd1NjVk4Pl3NoVudk8DDdWDhbjuvRLe2bn1Kxz3rBo9mOzm1BlhL6LihibQKHQTGB3hMld7cDJ1VYVyWKlAeZ21BkBkvWeAsjrqubXnHxTgCvOwkPZJfhCPDaLXuwQi98C2aiTw8ukwcGfugNH1XqUBfHeHB4YeF1vjlgse+P8DGiIyewV7zB3hqoKDHERse4EAnl6s/xGCviZdp6gyiSADLQK9gWPxG3Is6nFD4HiE+nEybU+4Xr03q49qMiP8gq1nn0RgMZe/G5K8273etTx+Uh4jr+vvp1AYU+RE4h09mODn79L1Fzs321O4lj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:15.2601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0af9ab2-ba5f-42b4-ceb9-08df1a6c1ceb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8978
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

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
The QoS model override for a display IP block was silently
skipped whenever the firmware-populated table was invalid.

[How]
Always re-point the bandwidth params at the driver's own
persistent QoS model storage before applying the override,
instead of returning early when the firmware-populated model
is NULL.

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  | 20 +++++++++----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
index 4cca1db2a79a..04891ae776b6 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
@@ -706,20 +706,18 @@ static void dcn60_copy_utm_qos_model_to_soc_table(
 
 /**
  * dcn60_override_utm_qos_model - Override the UTM QoS model.
+ * @clk_mgr: clock manager instance
  * @bw_params: clock manager bandwidth parameters
  */
-static void dcn60_override_utm_qos_model(struct clk_bw_params *bw_params)
+static void dcn60_override_utm_qos_model(struct clk_mgr_internal *clk_mgr,
+		struct clk_bw_params *bw_params)
 {
-	struct utm_qos_model *qos_model;
-	struct utm_qos_model_dchub_v3 *dchub;
-
-	if (!bw_params->utm_qos_model
-			|| bw_params->utm_qos_model->version != utm_qos_model_version_v3
-			|| !bw_params->utm_qos_model->dchub_v3)
-		return;
+	struct dcn60_clk_mgr *dcn60_clk_mgr =
+			container_of(clk_mgr, struct dcn60_clk_mgr, base);
+	struct utm_qos_model *qos_model = &dcn60_clk_mgr->utm_qos_model;
+	struct utm_qos_model_dchub_v3 *dchub = &dcn60_clk_mgr->dchub_v3;
 
-	qos_model = (struct utm_qos_model *)bw_params->utm_qos_model;
-	dchub = (struct utm_qos_model_dchub_v3 *)qos_model->dchub_v3;
+	bw_params->utm_qos_model = qos_model;
 
 	dcn6_test_initialize_utm_qos_model_v3(qos_model, dchub);
 
@@ -735,7 +733,7 @@ static void dcn60_override_bw_params(struct clk_mgr_internal *clk_mgr,
 	dcn60_override_dc_mode_limit(clk_mgr, bw_params);
 
 	if (dcn60_should_apply_temp_utm_override)
-		dcn60_override_utm_qos_model(bw_params);
+		dcn60_override_utm_qos_model(clk_mgr, bw_params);
 }
 
 /**
-- 
2.53.0

