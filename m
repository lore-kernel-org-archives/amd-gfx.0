Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C128C7115A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 15:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F98D10E8CD;
	Wed, 18 Jun 2025 15:55:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kxASdFGi";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAB3C10E8D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 15:55:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RG+Oxt5sNGINUmsTojku5T5RehbCrWfY+KJDwOcpcQdpgk+rPF6iV1zWTJsekZDHzmVSEGIt0R/pQCwGQsA3jJXkR3O2E6M+db8XbHw5UAwea2FQE/A2E83Ml3EsWJ5cCvaxmvt6nZ6tC6l8QOxJgWKvMRDpfCwJwQUXJ/am5d4SzPSKMu0eLyDYFKnz2dvofYec8im/3t5M5K8XgtHmTyV9ov6QS940STkqCNHuckjqZdaW+PWWZv6zLifwVVIoDV/0akgGV58C/NBwT4jD7fE/SiZveSnaMuwNXv7l7nSFlfw8DgQuTXT9glV9fj6hgfltKRvC2GxRSLhQTVhvXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apctcTvgzwSR++Q/+37v1OBVqHLBzumMd9UzRy0qWHM=;
 b=lEvjIQeoOcXJCfpuyQl12KW5ZWdWAsDnl7PYGSkTGt9EkwIrHiYlarKiWmqULZQc/i+k3dhaKxRWccFUn3y1wAPSeg9uC0aF9MnBbKvEU6Ruth30JOwLFBjZpq348TSyTST1fJDhQCa5s1R/k9SGUzCez38sk2gdsfX//lMKHRFTSPkb1vca9l7ElovK742sxRc+PPjDyzUJmirexLakFL6/PojNld4h1tzUrTJafukcVXBwx8uEkky85XLhaanC6FHacc88+BInYo0i5B++2e1OIZaC0ZFXt0bmy3fSO0eXcERReG0x59Mls35ZBEhQIBI1SRg9ZV39agSrJP4dTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apctcTvgzwSR++Q/+37v1OBVqHLBzumMd9UzRy0qWHM=;
 b=kxASdFGi6pxON7+74QPwm885rcNqOHDoM61iCkCXLS12xSYn8kfvVb34CemdzVo0OGfdq+ziNxF2uz7jploa0FA6yw4cODb91UhsBQkb9JBg/AQqUJHKGzoFMUH0hivq89meOBW2+3+eCZQeoLrtSlqN/W2M3xjNPb/xB0OoGA4=
Received: from CH2PR12CA0020.namprd12.prod.outlook.com (2603:10b6:610:57::30)
 by SA3PR12MB7784.namprd12.prod.outlook.com (2603:10b6:806:317::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 15:55:12 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::ba) by CH2PR12CA0020.outlook.office365.com
 (2603:10b6:610:57::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.34 via Frontend Transport; Wed,
 18 Jun 2025 15:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 15:55:11 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 10:55:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 10:55:00 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Jun 2025 10:55:00 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Ovidiu Bunea
 <Ovidiu.Bunea@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 11/13] drm/amd/display: Add DMUB IPS command support for IPS
 residency tools
Date: Wed, 18 Jun 2025 11:33:59 -0400
Message-ID: <20250618153936.6472-12-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618153936.6472-1-Jerry.Zuo@amd.com>
References: <20250618153936.6472-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|SA3PR12MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ba1e502-953b-4275-6653-08ddae8081ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cSe5VSE/MuXVitldIwXFeFzUMT5oYvnM1dl1AoEc+OzPVDVSon444dymNsCH?=
 =?us-ascii?Q?hk8buiozVx4B2QX41QJBwm0T6/bY9OXwARHrP7AYcfrCPrSkOb8TGLI98ixy?=
 =?us-ascii?Q?a9teNJucr9ufk4WP+zkz73DMPXlYM31uqVUtVJWxpj+EId4WdKvDyp8exQ6E?=
 =?us-ascii?Q?xXNj98n+ssQMl6DAAZCi9BWWhnz4WnDSKqIQ8iHuFEpy2ii9fKGj+9AU9YN8?=
 =?us-ascii?Q?GevPz8szelQbLNtlX3jpsKtV2ZQDD+7Vwp34DE/zm8FUVpHCs8Ba9w42z9mY?=
 =?us-ascii?Q?Sw/TfCbeAwGILx89NdKWvXGw3yFtu25mx/92qa7qmtS1ggq/kiE1Ti2ZqBo5?=
 =?us-ascii?Q?SUC4op2U1B2Z6kZiRN3c3BM5No7xa3RUnrePeh/v+vz27XTNVRovONi21DTv?=
 =?us-ascii?Q?VXSj8JUsh/cQCBKQ/e/pcegM3lj2c5TnQoyjrhCcJSM7rGsCnFE+y+kg+jnF?=
 =?us-ascii?Q?gdDJ7WnJaDCeh3BQmy7NXwVikYCxpb07uIaK72UgaIZN0Vxx1LkO2fbkM3P0?=
 =?us-ascii?Q?MAd3NaRZRn2JH48drrGK3dB2abKC+IF4AwM/4RdF1CKe7O9QmjCNTxx4cKQQ?=
 =?us-ascii?Q?cdKui/IccMcramRzZ91jmE06P7jx921Rgq4iGhdIAKS0+OKvSLxd8MeNd9GL?=
 =?us-ascii?Q?QbUjU/qxKzv/+K9dKl3HrziK5e2FM+0nzM10Lr8E+rl9FAuBQ+SatPs9jL28?=
 =?us-ascii?Q?sg1pN/5h5y6L9M5pB1aojcXTbo502hGDtrP281UB70VclIgdEsxoISJUKwuL?=
 =?us-ascii?Q?iBk/IBlAeiObtY3D/qQIn+ORJZUcUzkoKbjHE8V5Zz3Av3J5kOmj4OvhpJXu?=
 =?us-ascii?Q?ZVqCjvW+xZ0H05RrkYHNgtmj9Q9mpZ3k/4teEZrQYBVdNkWbJvrwCuVv5KYY?=
 =?us-ascii?Q?ewCY5ah5gFeGridAVm32BkDhEanMi6UhKP3uFEXtka4ztFZ4lHKsw7xBcNAS?=
 =?us-ascii?Q?OW0/Rk373SAs3gB+Evl7ziYOqkhSqgKPJHS/np3Ximapcyy7djwGqUefb8g+?=
 =?us-ascii?Q?QHJ81uBssQKmRzhDVFuZ+WasLzQyfxBf5T9VzYmlgESeXK4QWx2XD9AL5vTU?=
 =?us-ascii?Q?3A663+nEcp3GJ4iAoVGyYqnko1y5tNcXiRCnvnduI3KNyqQ17RVKxDrq3jxZ?=
 =?us-ascii?Q?GapatGLvIwOtDPm5WcfVhhroZifxSPSp5dppgC4njRkXB2P1DmghkISHtV0V?=
 =?us-ascii?Q?CAbHQgxl5C4FhPPPVXYrfnGOZR0bTuHqO4s0TMpS2ClbkSRuA0yRnjkaoOTi?=
 =?us-ascii?Q?ym6T5QgQE8P+HZ2EhsEWrDl5G8ifZUPe52xocnQXMpgSBmXx0qwr3mSWAVh9?=
 =?us-ascii?Q?Kd/LZoueDV7goRR6B9O8MZFwXon/S3JJJ8P3SGy9TALa7936fI8SREY4ZJZW?=
 =?us-ascii?Q?f7BHPU4AG4uDGtSSlp8ZhXbakhfTV+vosHlXaSlkUG1o9zpgjoQqVtUaslRL?=
 =?us-ascii?Q?bW6ty58e9d1fiuyLUjtL0gsgfoGtwUkOSGdsaWKwykSQ9ErAlnHsrXaLSyAv?=
 =?us-ascii?Q?iqjgUpucW74egLzAZKk9VrKjbQxURpWwEd6X?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 15:55:11.4733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba1e502-953b-4275-6653-08ddae8081ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7784
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
Add DMUB IPS CMD interface for driver and
DMU to communicate for IPS residency tools.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ovidiu Bunea <Ovidiu.Bunea@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 102 ++++++------------
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  66 +++++-------
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   8 --
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  70 ++++++++++++
 4 files changed, 132 insertions(+), 114 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 1f685fc5c55a..0a47d1a3515b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1904,85 +1904,53 @@ void dc_dmub_srv_fams2_passthrough_flip(
 	}
 }
 
-bool dc_dmub_srv_ips_residency_cntl(struct dc_dmub_srv *dc_dmub_srv, bool start_measurement)
+
+bool dc_dmub_srv_ips_residency_cntl(const struct dc_context *ctx, uint8_t panel_inst, bool start_measurement)
 {
-	bool result;
+	union dmub_rb_cmd cmd;
 
-	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
-		return false;
+	memset(&cmd, 0, sizeof(cmd));
 
-	result = dc_wake_and_execute_gpint(dc_dmub_srv->ctx, DMUB_GPINT__IPS_RESIDENCY,
-					   start_measurement, NULL, DM_DMUB_WAIT_TYPE_WAIT);
+	cmd.ips_residency_cntl.header.type = DMUB_CMD__IPS;
+	cmd.ips_residency_cntl.header.sub_type = DMUB_CMD__IPS_RESIDENCY_CNTL;
+	cmd.ips_residency_cntl.header.payload_bytes = sizeof(struct dmub_cmd_ips_residency_cntl_data);
 
-	return result;
+	// only panel_inst=0 is supported at the moment
+	cmd.ips_residency_cntl.cntl_data.panel_inst = panel_inst;
+	cmd.ips_residency_cntl.cntl_data.start_measurement = start_measurement;
+
+	if (!dc_wake_and_execute_dmub_cmd(ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
+		return false;
+
+	return true;
 }
 
-void dc_dmub_srv_ips_query_residency_info(struct dc_dmub_srv *dc_dmub_srv, struct ips_residency_info *output)
+bool dc_dmub_srv_ips_query_residency_info(const struct dc_context *ctx, uint8_t panel_inst, struct dmub_ips_residency_info *driver_info,
+					  enum ips_residency_mode ips_mode)
 {
-	uint32_t i;
-	enum dmub_gpint_command command_code;
+	union dmub_rb_cmd cmd;
+	uint32_t bytes = sizeof(struct dmub_ips_residency_info);
 
-	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
-		return;
+	dmub_flush_buffer_mem(&ctx->dmub_srv->dmub->scratch_mem_fb);
+	memset(&cmd, 0, sizeof(cmd));
 
-	switch (output->ips_mode) {
-	case DMUB_IPS_MODE_IPS1_MAX:
-		command_code = DMUB_GPINT__GET_IPS1_HISTOGRAM_COUNTER;
-		break;
-	case DMUB_IPS_MODE_IPS2:
-		command_code = DMUB_GPINT__GET_IPS2_HISTOGRAM_COUNTER;
-		break;
-	case DMUB_IPS_MODE_IPS1_RCG:
-		command_code = DMUB_GPINT__GET_IPS1_RCG_HISTOGRAM_COUNTER;
-		break;
-	case DMUB_IPS_MODE_IPS1_ONO2_ON:
-		command_code = DMUB_GPINT__GET_IPS1_ONO2_ON_HISTOGRAM_COUNTER;
-		break;
-	default:
-		command_code = DMUB_GPINT__INVALID_COMMAND;
-		break;
-	}
+	cmd.ips_query_residency_info.header.type = DMUB_CMD__IPS;
+	cmd.ips_query_residency_info.header.sub_type = DMUB_CMD__IPS_QUERY_RESIDENCY_INFO;
+	cmd.ips_query_residency_info.header.payload_bytes = sizeof(struct dmub_cmd_ips_query_residency_info_data);
 
-	if (command_code == DMUB_GPINT__INVALID_COMMAND)
-		return;
+	cmd.ips_query_residency_info.info_data.dest.quad_part = ctx->dmub_srv->dmub->scratch_mem_fb.gpu_addr;
+	cmd.ips_query_residency_info.info_data.size = bytes;
+	cmd.ips_query_residency_info.info_data.panel_inst = panel_inst;
+	cmd.ips_query_residency_info.info_data.ips_mode = (uint32_t)ips_mode;
 
-	for (i = 0; i < GPINT_RETRY_NUM; i++) {
-		// false could mean GPINT timeout, in which case we should retry
-		if (dc_wake_and_execute_gpint(dc_dmub_srv->ctx, DMUB_GPINT__GET_IPS_RESIDENCY_PERCENT,
-					      (uint16_t)(output->ips_mode), &output->residency_percent,
-					      DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
-			break;
-		udelay(100);
-	}
+	if (!dc_wake_and_execute_dmub_cmd(ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY) ||
+					  cmd.ips_query_residency_info.header.ret_status == 0)
+		return false;
 
-	if (!dc_wake_and_execute_gpint(dc_dmub_srv->ctx, DMUB_GPINT__GET_IPS_RESIDENCY_ENTRY_COUNTER,
-				      (uint16_t)(output->ips_mode),
-				       &output->entry_counter, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
-		output->entry_counter = 0;
-
-	if (!dc_wake_and_execute_gpint(dc_dmub_srv->ctx, DMUB_GPINT__GET_IPS_RESIDENCY_DURATION_US_LO,
-				      (uint16_t)(output->ips_mode),
-				       &output->total_active_time_us[0], DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
-		output->total_active_time_us[0] = 0;
-	if (!dc_wake_and_execute_gpint(dc_dmub_srv->ctx, DMUB_GPINT__GET_IPS_RESIDENCY_DURATION_US_HI,
-				      (uint16_t)(output->ips_mode),
-				       &output->total_active_time_us[1], DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
-		output->total_active_time_us[1] = 0;
-
-	if (!dc_wake_and_execute_gpint(dc_dmub_srv->ctx, DMUB_GPINT__GET_IPS_INACTIVE_RESIDENCY_DURATION_US_LO,
-				      (uint16_t)(output->ips_mode),
-				       &output->total_inactive_time_us[0], DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
-		output->total_inactive_time_us[0] = 0;
-	if (!dc_wake_and_execute_gpint(dc_dmub_srv->ctx, DMUB_GPINT__GET_IPS_INACTIVE_RESIDENCY_DURATION_US_HI,
-				      (uint16_t)(output->ips_mode),
-				       &output->total_inactive_time_us[1], DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
-		output->total_inactive_time_us[1] = 0;
-
-	// NUM_IPS_HISTOGRAM_BUCKETS = 16
-	for (i = 0; i < 16; i++)
-		if (!dc_wake_and_execute_gpint(dc_dmub_srv->ctx, command_code, i, &output->histogram[i],
-					       DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
-			output->histogram[i] = 0;
+	// copy the result to the output since ret_status != 0 means the command returned data
+	memcpy(driver_info, ctx->dmub_srv->dmub->scratch_mem_fb.cpu_addr, bytes);
+
+	return true;
 }
 
 bool dmub_lsdma_init(struct dc_dmub_srv *dc_dmub_srv)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 178a71e3b7dc..1f1c155be30e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -210,45 +210,6 @@ void dc_dmub_srv_fams2_passthrough_flip(
 		struct dc_surface_update *srf_updates,
 		int surface_count);
 
-/**
- * struct ips_residency_info - struct containing info from dmub_ips_residency_stats
- *
- * @ips_mode: The mode of IPS that the follow stats appertain to
- * @residency_percent: The percentage of time spent in given IPS mode in millipercent
- * @entry_counter: The number of entries made in to this IPS state
- * @total_active_time_us: uint32_t array of length 2 representing time in the given IPS mode
- *                        in microseconds. Index 0 is lower 32 bits, index 1 is upper 32 bits.
- * @total_inactive_time_us: uint32_t array of length 2 representing time outside the given IPS mode
- *                          in microseconds. Index 0 is lower 32 bits, index 1 is upper 32 bits.
- * @histogram: Histogram of given IPS state durations - bucket definitions in dmub_ips.c
- */
-struct ips_residency_info {
-	enum dmub_ips_mode ips_mode;
-	unsigned int residency_percent;
-	unsigned int entry_counter;
-	unsigned int total_active_time_us[2];
-	unsigned int total_inactive_time_us[2];
-	unsigned int histogram[16];
-};
-
-/**
- * bool dc_dmub_srv_ips_residency_cntl() - Controls IPS residency measurement status
- *
- * @dc_dmub_srv: The DC DMUB service pointer
- * @start_measurement: Describes whether to start or stop measurement
- *
- * Return: true if GPINT was sent successfully, false otherwise
- */
-bool dc_dmub_srv_ips_residency_cntl(struct dc_dmub_srv *dc_dmub_srv, bool start_measurement);
-
-/**
- * bool dc_dmub_srv_ips_query_residency_info() - Queries DMCUB for residency info
- *
- * @dc_dmub_srv: The DC DMUB service pointer
- * @output: Output struct to copy the the residency info to
- */
-void dc_dmub_srv_ips_query_residency_info(struct dc_dmub_srv *dc_dmub_srv, struct ips_residency_info *output);
-
 bool dmub_lsdma_init(struct dc_dmub_srv *dc_dmub_srv);
 bool dmub_lsdma_send_linear_copy_packet(
 	struct dc_dmub_srv *dc_dmub_srv,
@@ -303,4 +264,31 @@ bool dmub_lsdma_send_tiled_to_tiled_copy_command(
 	struct lsdma_send_tiled_to_tiled_copy_command_params params);
 bool dmub_lsdma_send_poll_reg_write_command(struct dc_dmub_srv *dc_dmub_srv, uint32_t reg_addr, uint32_t reg_data);
 
+/**
+ * struct ips_residency_info - struct containing info from dmub_ips_residency_stats
+ *
+ * @ips_mode: The mode of IPS that the follow stats appertain to
+ * @residency_percent: The percentage of time spent in given IPS mode in millipercent
+ * @entry_counter: The number of entries made in to this IPS state
+ * @total_active_time_us: uint32_t array of length 2 representing time in the given IPS mode
+ *                        in microseconds. Index 0 is lower 32 bits, index 1 is upper 32 bits.
+ * @total_inactive_time_us: uint32_t array of length 2 representing time outside the given IPS mode
+ *                          in microseconds. Index 0 is lower 32 bits, index 1 is upper 32 bits.
+ * @histogram: Histogram of given IPS state durations - bucket definitions in dmub_ips.c
+ */
+struct ips_residency_info {
+	enum ips_residency_mode ips_mode;
+	unsigned int residency_percent;
+	unsigned int entry_counter;
+	unsigned int total_active_time_us[2];
+	unsigned int total_inactive_time_us[2];
+	unsigned int histogram[16];
+};
+
+bool dc_dmub_srv_ips_residency_cntl(const struct dc_context *ctx, uint8_t panel_inst, bool start_measurement);
+
+bool dc_dmub_srv_ips_query_residency_info(const struct dc_context *ctx, uint8_t panel_inst,
+					  struct dmub_ips_residency_info *driver_info,
+					  enum ips_residency_mode ips_mode);
+
 #endif /* _DMUB_DC_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index c627093bb849..0bafb6710761 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -607,14 +607,6 @@ struct dmub_notification {
 	};
 };
 
-/* enum dmub_ips_mode - IPS mode identifier */
-enum dmub_ips_mode {
-	DMUB_IPS_MODE_IPS1_MAX		= 0,
-	DMUB_IPS_MODE_IPS2,
-	DMUB_IPS_MODE_IPS1_RCG,
-	DMUB_IPS_MODE_IPS1_ONO2_ON
-};
-
 /**
  * DMUB firmware version helper macro - useful for checking if the version
  * of a firmware to know if feature or functionality is supported or present.
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 569644bea641..e6730e59d987 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -795,6 +795,17 @@ enum dmub_ips_rcg_disable_type {
 #define DMUB_IPS1_COMMIT_MASK 0x00000004
 #define DMUB_IPS2_COMMIT_MASK 0x00000008
 
+enum dmub_ips_comand_type {
+	/**
+	 * Start/stop IPS residency measurements for a given IPS mode
+	 */
+	DMUB_CMD__IPS_RESIDENCY_CNTL = 0,
+	/**
+	 * Query IPS residency information for a given IPS mode
+	 */
+	DMUB_CMD__IPS_QUERY_RESIDENCY_INFO = 1,
+};
+
 /**
  * union dmub_fw_boot_options - Boot option definitions for SCRATCH14
  */
@@ -1546,6 +1557,11 @@ enum dmub_cmd_type {
 	 */
 	DMUB_CMD__LSDMA = 90,
 
+	/**
+	 * Command type use for all IPS commands.
+	 */
+	DMUB_CMD__IPS = 91,
+
 	DMUB_CMD__VBIOS = 128,
 };
 
@@ -5856,6 +5872,56 @@ struct dmub_rb_cmd_assr_enable {
 	uint32_t reserved[3];
 };
 
+/**
+ * Current definition of "ips_mode" from driver
+ */
+enum ips_residency_mode {
+	IPS_RESIDENCY__IPS1_MAX,
+	IPS_RESIDENCY__IPS2,
+	IPS_RESIDENCY__IPS1_RCG,
+	IPS_RESIDENCY__IPS1_ONO2_ON,
+};
+
+#define NUM_IPS_HISTOGRAM_BUCKETS 16
+
+/**
+ * IPS residency statistics to be sent to driver - subset of struct dmub_ips_residency_stats
+ */
+struct dmub_ips_residency_info {
+	uint32_t residency_millipercent;
+	uint32_t entry_counter;
+	uint32_t histogram[NUM_IPS_HISTOGRAM_BUCKETS];
+	uint64_t total_time_us;
+	uint64_t total_inactive_time_us;
+};
+
+/**
+ * Data passed from driver to FW in a DMUB_CMD__IPS_RESIDENCY_CNTL command.
+ */
+struct dmub_cmd_ips_residency_cntl_data {
+	uint8_t panel_inst;
+	uint8_t start_measurement;
+	uint8_t padding[2]; // align to 4-byte boundary
+};
+
+struct dmub_rb_cmd_ips_residency_cntl {
+	struct dmub_cmd_header header;
+	struct dmub_cmd_ips_residency_cntl_data cntl_data;
+};
+
+struct dmub_cmd_ips_query_residency_info_data {
+	union dmub_addr dest;
+	uint32_t size;
+	uint32_t ips_mode;
+	uint8_t panel_inst;
+	uint8_t padding[3]; // align to 4-byte boundary
+};
+
+struct dmub_rb_cmd_ips_query_residency_info {
+	struct dmub_cmd_header header;
+	struct dmub_cmd_ips_query_residency_info_data info_data;
+};
+
 /**
  * union dmub_rb_cmd - DMUB inbox command.
  */
@@ -6177,6 +6243,10 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__LSDMA command.
 	 */
 	struct dmub_rb_cmd_lsdma lsdma;
+
+	struct dmub_rb_cmd_ips_residency_cntl ips_residency_cntl;
+
+	struct dmub_rb_cmd_ips_query_residency_info ips_query_residency_info;
 };
 
 /**
-- 
2.43.0

