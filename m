Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12BACA6002
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 17:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E0DF10F6E3;
	Wed,  7 Oct 2026 17:04:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w/y/4aDc";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013001.outbound.protection.outlook.com
 [40.107.201.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0D6C10F6E3
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 17:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aomp2+qNoMHYXY3ouY7YdiQ4s9esd7Lv0ILwD3bZy6wXbz8em+bI8SGhcp3u+Zcc/g1pmLIIN3RMEgNaeE32o7vNdchmB3wHWx0yDR7IGdEt8rE1YGyKgwR1Sc/38fqg61TjlD8dSW0TJtmwazCVBgXRfMWQuteS+3uYJuabq9almYlkv4wq/RqtZ2P73WcOpO8POOAOtcYgCdGAkGS+pSNVamYo0h0/kImHiZ/DeNJPev8dCb1oE783hLG6MDaacq7LeMD5H/2L+rH2i2BtZr0Ki7DpJeLPM/OCJMX8ytMSK47/2Et8I4RCUdM6KoVGT+yR8NBnE3bCZpodcHTOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/EPdyI0CSi7Uv57pmiAQOLAYkxkGagf/jAjy5pBSZM=;
 b=v/WkUIl0Qz7m4/yJ6pEF7HvKDffvQv/TxeiiWBaiQKRZs/9jlj4OK6NFxbwzf6UW+q0MRrHSDiv8+Z6v08554wyHOKcsofW/L8dg4RLztXMOIH9fO64Xlgjd50DSSb7nZMv135s/LL8ZcMap0d7JDd/0oLZAPxKxYRoEUjl9y/9S6+5F6BUaYKJ64ib7CAiSUd40ZlFNQD3XCeIC6lf7flTdk5bDLWnjdHmkNfhct4oK4IEy+fxDb/CK13xVa526PvgnYaXpPa9C6kYst/WeENjlzApWBKgEVUzsxiTirznIg9wwObPyb4rIGw5JhvxUlJKy1P/YlomQ32siPm5X0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/EPdyI0CSi7Uv57pmiAQOLAYkxkGagf/jAjy5pBSZM=;
 b=w/y/4aDcDaZe3uWagO/3kkxP6d+myxNGSCL1QDKgDwpXkz+FSHkzSRxFRZM77W31AO68trAlGeDc7T4d8fm5WYpbAD31AbEhKgnoNrXr19d87qci5HODKj4nvZLow84kvEC5U8YMk/9XQkw8yv/FvMMIRHJFxWSGmISl877/oY0=
Received: from MW3PR06CA0026.namprd06.prod.outlook.com (2603:10b6:303:2a::31)
 by PH8PR12MB7375.namprd12.prod.outlook.com (2603:10b6:510:215::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 17:04:42 +0000
Received: from MW1PEPF00018892.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::3d) by MW3PR06CA0026.outlook.office365.com
 (2603:10b6:303:2a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 17:04:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00018892.mail.protection.outlook.com (10.167.249.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 17:04:41 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:35 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 12:04:34 -0500
From: <ivan.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 18/19] drm/amd/display: Promote DC to 3.2.402
Date: Wed, 7 Oct 2026 12:59:51 -0400
Message-ID: <20261007170412.1898315-19-ivan.lipski@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007170412.1898315-1-ivan.lipski@amd.com>
References: <20261007170412.1898315-1-ivan.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00018892:EE_|PH8PR12MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ac3e63-0f4f-4cab-155a-08df2495144d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QwGUTepd1ONP9Hkkzhp3p7FmDH4HundA65+8U9q+/Sb7ef9RKws2g78ZEBlRgNLT7bLnFdqKVVJSh/65IQXgIIq3ExCylo7XQnh4+rtWiH1AyO1QRJ1x+NlSPFCqKeUcFlDZl7s38g6hKw6uI2c4g4xRwfk8Xp5dezy3/S3wcNOYCaX6qod6ch1Vn0clREg85zjUldS3mosayKfje7HEgcMLgOsgUmAKVJ15uF3slnzhFkuU7pdG+byxglx4EHF8Nc3+pnYjP0JAs0uwvDfH5WkCK8rZJGn9jYgKA14SuPdksrLoyT3OiXETF2ZETyNQno1RWhzV+gEaokumak2LErsLC20YGID4dnnV2mUbcn/i+m2OB104iOuX07GcGjfiPqW2hRxzSav+09QvT6yKQCaSrOpLToTvwAmSStqDeDjmasv3EtpJ6n4ltcAUi5OWmQkKkEBF4ybCMxiFgelw71mGJX6KWtzvq7JK/aXZsXqLTzhK468o5KLvkPmUrPPSK5Sfj0Iv+BMLBxM2T0ndUWgrSPHOqXl77Pdoyj7cgoSVijvZMXKLsVfP2fIYCPnZUwehLVAjiipytnwcT15V6BozP1/U2RUUsCuMjGtAtiTmIvTYaJKT6IB6Xv6Gm3vrx1zOc08YP61O9tCFuRUZSQSmppiXQn9RmY3BlYkFeybtpA3kcs7FWMYWF8BkAG5TG3vn0Lw4T8PBsZ+UOJVy9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DX05CDEfOIL/Wb423phataITLxli8pLkcNsnE0VPCJU787parpCdjZ7wl06vZt1DhRMgwd/PC24IxejtGaDpZnVz7VhtMhogSvrXIe/p/ul1wZqPbuW5hRYCcFvbZ/BgBWDlH2Q1f06FV8s1lW9bRSHD447AyPQqOt6jEaSzAzVZloKr++PCAQqQffOlKtBilTrVMECIePzuJEDHRgwSObmvCvwuacFgtuiavKuGnHODGDWYX63WZC0uRuC17BZ5gn8b/AgguBP98oI93RStg5VV9mqosnswHXTfnIuBJZxhxS9VL8/N/kUd64aIrT5BP5kUvz1O9ve9JZ0Oqe+kofNPMk2KzBxrJfVx1O8bcg47tO2Jaz9gSb4c3Pr9+qtDQZLHzN+2J5pHLRtmq4XMqnwCVS62Eq2AE41/92q2yauaJKfLaf7BmmHtFZOMdrFl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 17:04:41.8122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ac3e63-0f4f-4cab-155a-08df2495144d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00018892.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7375
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along the following updates:

 - Refactor DC IP request control in HWSS.
 - Fix rotate 90 degrees surface corruption issue.
 - Refactor DPP root clock control in HWSS.
 - Fix upsampling and linear scaling.
 - Use aux hw inst if no ddc pin exists.
 - Directly include compiler_attributes.h.
 - Fix frac_urg_bw conversion to correct U0.10 format.
 - Do full link training during HDR/SDR seamless switch.
 - Fix SPL format handling for linear scaling and upsampling.
 - Update DCN42 cstate latencies.
 - Invalidate the DRR shadow after a hardware re-init.
 - Program HDR visual confirm based on per pipe info.
 - Split link_set_dsc_on_stream into encoder and DSC components.
 - Add new config_dsc hwseq function for DCN60.
 - Program DSC prior to OTG enable starting DCN60.
 - Improve mandatory pstate optimization and check.
 - Disable HUBP/DPP power gating on DCN42.

Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d3c484f45333..9cc90c406d86 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -68,7 +68,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.401"
+#define DC_VER "3.2.402"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

