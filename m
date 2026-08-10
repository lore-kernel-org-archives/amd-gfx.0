Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F847C5B572
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 15:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A1DD10EC80;
	Tue, 11 Aug 2026 15:49:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W4ZJpcC/";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010064.outbound.protection.outlook.com [52.101.61.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56F8310EC90
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 15:49:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsZbfp8hgNcs2tU47LX/6apmshH4LxWbjF+8LrhznHv6v1U7YUX73LlmJ8YalY+Ygb53gpYLmY78Dhr3EZvW71BW4XBn44+Y1TYjGqQTWwH6vFPWtgKMmM0L5Ir9Qd/VwMLm84rDqh47b60N+V1zxxMn5mC3d72EX7jCebVdU22egB+Zbkw57CtltmKh8JYa4HtMS+m11hj4PX9rtNzIbMzw2/YfPIYMIHv9sbQB+vQttQQMgEC1YpWS1TWcSEDxyCeRF/ihOvXE8lARWalEVHmwcbsfuAmpaAysNm/nGCR9VpVYZCjEqVhsZG+Nq9kkyCXT2mRWXrKkm243djx/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHNfOyqfmTiRHCMgcW7hyqFH3WbY16x1J/XkYtw04MA=;
 b=ojz2ygtlOgr5EqJq3xldpFiBPoedZTTDYTqidb6sKAdL2sawuh9B6auKviFyCRpyHsHiuYRIGsE+Lbj15GBY/YbX7ptYINQqyK2TWAkKUrNOLEffJ1WlcdI+OARtqc6WZm2OP6m+cz4qevje8aQxdqTSq2Q+5OeJ/Sm2y5BRh28P/R02Qp4PXDk1IXxcjPKo7SmCZGVlM4TqizPD/PzcJDG9I8mfucTei8lQ5/u7AjIFKQpYG38AcmS9wJPBj0tQA43NM6rnQUQ5mcORcjj71Eh5vknFCt1t3gr2B8OQpY/To6PHbo6MKi22lf80wLUPr0wJ/vYnh3WttVshSiNSHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHNfOyqfmTiRHCMgcW7hyqFH3WbY16x1J/XkYtw04MA=;
 b=W4ZJpcC/UwhjiSsoXJhMp52z9xGjHF3a+EpoCH6t9Elb2lR4Sk9Vj6TWyE7e42OILShzppXVlwvPnSS2Tszc+5hBeqbpeSWhoYJhgchFDL+xFwF/AGdMip8MDuKCJzJyZ5pqVSw0hPXgPh5T/u9KZpcMsNirQSUrSYAdQWDDOwk=
Received: from CH2PR16CA0009.namprd16.prod.outlook.com (2603:10b6:610:50::19)
 by DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 15:49:17 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::88) by CH2PR16CA0009.outlook.office365.com
 (2603:10b6:610:50::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 15:49:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 15:49:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:49:14 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:49:13 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via
 Frontend Transport; Tue, 11 Aug 2026 10:49:05 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 07/24] drm/amd/display: Add DC_BLS command
Date: Tue, 11 Aug 2026 05:28:41 +0800
Message-ID: <20260810213010.1703162-8-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810213010.1703162-1-PingLei.Lin@amd.com>
References: <20260810213010.1703162-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|DM6PR12MB4403:EE_
X-MS-Office365-Filtering-Correlation-Id: b5364279-8d96-42cb-03d4-08def7c01903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|22082099003|56012099006|11063799006|18002099003|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: mB0603zvffFyZko/SBDi8vcA14qmiRvlqDU+atP/tA4dIgBy9KkTty3JBf9a0sLOChX6+hn/qOq//6kaRcigRkG3xDB+oxwf/cj/kkUm1SEyVXs+Bq+LrVqBgJKdj2iU0iQqyxcc5gPSK1KcokURCdcl9ZuUyx7YSNazfHRETXyxy9yu6ea46uwgLsuQaqvla6dg5Y8ItA7pN6swr0WBkDaP99agg0xfBd5x1RMeRU7+aY1nMau1LA4HSl6Hc8rnpEvnDQ+WrWXKSar63qzl1qaWotKfINu7WX+gSDEF3eTw3TlFz5zfhlEzHO2fJWN0WCjnZa+VrlJE99MuP+5uY/F1rNAOonIiKbimLekjPVGuT+ex2jdK+pXZAWgtNKAa+oSXZbtugdl5ZIp302CbM+/cCImJIWkTCQG2aHbANdqB+4N7hMIHmwnJ34TUHOGzah22qSjuRrAEcUQcOTUojX+PYveivjo0vXHuOPnsTevUelxr5fSQQPJRYRObhC2DyB5s3kJ/PDeBoQIKH+oyyjUTlK3Q2t3pmkuEgp3z6ixRt2bXrWrla6LOIDlSbIRu57hbtjbtZMvw6QPsavx105lsUmFUMvw6vUj60265RBEsG9nyY8/PUkoejUbuFHrwmTsgUKLNFmVqynxeWVTHyvTJxJf3C9rERr7RDdtyZX3UjSpHIyuGEbxWAkyRLihp6XrjihPlOi67G9Ncdb+1eA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(22082099003)(56012099006)(11063799006)(18002099003)(3023799007)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZoSLdbgHhYFl1wIrY6ylHoqfGLgPoJheTiAIDotsURZEKr4+KiTFDdlX71t5bnN7YYZXlEbP6U7xjz02+a607ATxjJrRfmHAHUQH6sdK9wHgz4bI5JSos02B2OsvG/I63XILZUJG1EoKV2pSBPF2RwJ79SNQkbhMjKbJXbZbWcKYtMZeBRNZLeoxktqm5Ajcr1fXCpGp6CNwAX7BDIHz+f2LimH85h8Fp+xPZ5E40q9D9tcFKosbdvRtC5YR6BI37ntHcoue5CL+i70uohX4pbHzZeE585KsPKJ77Gd7dvCZP0XgWGfomJNfw5k+rhfEs4rvsrwgmWUVdvQYNxWmK/PlovObdpDi6SnXJqDfcIzjrmSCptLN+rjbTfS1MLLodzwpFthLjoH4nJUnGWa64uBInDSDAK7aHtOvh/22nwwQ29JdUhNdd7jI73f2Q26d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:49:15.8270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5364279-8d96-42cb-03d4-08def7c01903
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403
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

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[why & how]
In the future, DC will off-load block-level initialization to DMUB.

In preparation, update dmub_cmd.h with the command for better tracking.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index f0231f355fa7..c273d97ec88d 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1169,6 +1169,16 @@ enum dmub_ips_comand_type {
 	DMUB_CMD__IPS_QUERY_RESIDENCY_INFO = 1,
 };
 
+/**
+ * enum dmub_dc_bls_command_type - DC_BLS subcommands.
+ */
+enum dmub_dc_bls_command_type {
+	/**
+	 * Placeholder for block-level initialization of the DCHVM
+	 */
+	DMUB_CMD__DC_BLS_DCHVM_INIT = 0,
+};
+
 /**
  * enum dmub_cursor_offload_comand_type - Cursor offload subcommands.
  */
@@ -2008,6 +2018,11 @@ enum dmub_cmd_type {
 	 */
 	DMUB_CMD__PANEL_POLARITY = 97,
 
+	/**
+	 * Command type used for all DC_BLS commands.
+	 */
+	DMUB_CMD__DC_BLS = 98,
+
 	/**
 	 * Command type use for VBIOS shared commands.
 	 */
@@ -2940,6 +2955,25 @@ struct dmub_rb_cmd_idle_opt_dcn_notify_idle {
 	struct dmub_dcn_notify_idle_cntl_data cntl_data;
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__DC_BLS_DCHVM_INIT command.
+ */
+struct dmub_cmd_dc_bls_dchvm_init_data {
+	/**
+	 * The value to program to rIOMMU PCTRL register. x86 cannot access this SMN
+	 * register, so the write is performed by DMCUB on the driver's behalf.
+	 */
+	uint32_t riommu_pctrl_val; /* r */
+};
+
+/**
+ * Definition of a DMUB_CMD__DC_BLS_DCHVM_INIT command.
+ */
+struct dmub_rb_cmd_dc_bls_dchvm_init {
+	struct dmub_cmd_header header;
+	struct dmub_cmd_dc_bls_dchvm_init_data data;
+};
+
 /**
  * enum dmub_idle_opt_dc_power_state - DC power states.
  */
@@ -7988,6 +8022,8 @@ union dmub_rb_cmd {
 	struct dmub_rb_cmd_panel_polarity_enable panel_polarity_enable;
 	struct dmub_rb_cmd_panel_polarity_get_bias panel_polarity_get_bias;
 	struct dmub_rb_cmd_panel_polarity_reset panel_polarity_reset;
+
+	struct dmub_rb_cmd_dc_bls_dchvm_init dc_bls_dchvm_init;
 };
 
 /**
-- 
2.43.0

