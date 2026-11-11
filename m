Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE83606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jDDl/r6k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98DF510F8DC;
	Wed, 11 Nov 2026 01:43:16 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9D4110F8D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:43:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdaWfk+q6Bx3+2LpJlv10K8JXj+Gjm/+Rbhvg5kK1p8UdKGfow6xMY5kJzDCrf3P7iT61WszJMAZe0o0HEFrw3WkvM18Eqm5n6yDP8KU5qH/liQSfgX8c4V2bbajp9Kg4H0RiEjeWHKUtwL8eg1NH8iWMgKhMuwYTcbGIA3z6yZ/RDeGJzT8zS6cfxVfqCVFU8oSP+/WtiScTjQNuWiixeKwReea5OFDgh0PFYdU5pi7kLsbwjqgDI1yggr+Y9zyi4+5+spi54lhl654MztaQIfGeg4UhrfGBFb9E/x5HA6YCOeeEsBEKRy5uikMl7tAOfGA7/oklK1ktZ6M4RneFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3J5+jfSc56+8Y97AZOO0GFi8u1RFn6kByWGfYVS9fg=;
 b=vEpSXN2oijIAqz+AGhOsaNpvPWG//x+20NXOLrW0cCdA1thTH43annGaVC4ftLPluLo4bGMyQvM/1BfBGWYC2E7GFqX7H+15HW81LbTaauVcvXQrlPIfdz5IO/Nv3JNXBkYxofXJClKgkxJmDur6ctDZ4bYT3AZyLyvishimyptFYvu80zbabHDga7pQAV99VY/GGwewVa0KOaGvSlVFl5GSpSySq1ciwmPT1w5fsUeFt7PkLJy/5LkRpiaPIkfGRj5c2F9PjOeJyDsguK5qmji7uiniRhqXbMuMYm2EFk9NK2ikQ5wNAx0cPDQIMd7z+UPopEo6SvCY8rEp1mp97g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3J5+jfSc56+8Y97AZOO0GFi8u1RFn6kByWGfYVS9fg=;
 b=jDDl/r6kJItyi6R0We9rpkusLRqI2DKD6zL47BoQkFq+jcROap6YmnWWYM86mwSCnVLekXk7gyYYAZcZ3CInavthzh/6PmMvsUxXZtsf8qu+im9Zh5IPX/wbSHfqAon7Qq9HwVWjXQ6hatGJmHls1rZybCXUS7C7JUoEyNHCfls=
Received: from BY3PR05CA0039.namprd05.prod.outlook.com (2603:10b6:a03:39b::14)
 by SA3PR12MB214768.namprd12.prod.outlook.com (2603:10b6:806:53d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:43:05 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::7c) by BY3PR05CA0039.outlook.office365.com
 (2603:10b6:a03:39b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:43:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:43:04 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:43:04 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:43:01 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>
Subject: [PATCH 41/74] drm/amd/display: Increase the DCN42 DDR5 stutter latency
Date: Wed, 11 Nov 2026 09:28:47 +0800
Message-ID: <20261111014100.3596072-42-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|SA3PR12MB214768:EE_
X-MS-Office365-Filtering-Correlation-Id: 596b667d-cd38-4cf9-9bf6-08df3f952148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|261028144727099003|11063799006|56012099006|261021123027099003|261021121427099003|10067099003|261022105027099003|261026140227099003|261102123227099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: dQmvPulDs+SOkiFNcg1F75twroJmpaCAZ4AMSs2kbWxnkmDMH8uDad+yOIK19DYRpKsHA6Mf6hcjAKUTZ3Q9DEHSzDV8ZBwSSL1pkxmy6CsPaZoFuGsqh/tDpcKH3ALM42Haxv+6kqh1mHhZCnS0vgZdcowDsUiwQ8wUr6QbCant+46kR0wKVWlq1m9BQUwhifYzr5Z/Z4TUB2zLyzTKQXEl1EBQDm0NYhPtnIxrXbLufTZ/1kCaAiK/kGhwgzbj5FxF6RcLkcFkaHhpVv64TnGnpZgFWYpIjbDJryZy6/77kk3QE/TXGY/vjmfe1NqKS/dXs4s0NzJbvcHDU4vW1ht/FViPTKEVrUr+s+r32hEp3cM6SIOjC863eFYsBmW0hfssDbg7v0eO1HAmsbb3HYsvCKE/iB9E+a91rZzfI82qWPpk9UkQ379FkSc1z0SbACyBY5qgriZt+gupPQHJ6GZz6mYA+bx3b2Hjtonyd4sLrqYGgiIhBB8M0BlZ4PUHtC+JKTUpeGO9bAZSM29L55oV2oUBSeYjSBtc20uLXZcLks9wSNnYGDiYyPHZxnwz8KuvWBRnoJSL7ODWwtI1Azq9eXEc3hq5M8q/uH05T+MkWTbs5Ddb6qP0hyvo/8lP69Wk2WNan3iclkfguGAJtdthwBTc7kVqL/0Kpf9rpGplpDeGH0pxeTr6reVCTUmfiqnyztiwBvSyylSyfp1gcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(261028144727099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(10067099003)(261022105027099003)(261026140227099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sZvmOxleIfxRDQQFpZiCBDLGeUq3gCb0jjykMQNiBCs2ZYsqJlrMqOB766brLCwU7A3QedX32W8GDxg59TYX4Kkgt+kr5siSdYrJH+WK/FUy5zKpGerBFmyVTrODOrzJphKs3RMTrfskxPxIbf+mMXq8oQRQ3kpS3L8Kg5zGiApSh2+1aazIXZiarBYoQEKAS6ey++aQZKK9LVSKl1rFlNtXl8HcRTAEncmhQejoqUV14XEpXtoPvShBYFHS2R5rmQBy8nUzTVPCxDeqN6Y3BCBWUqK4e8zRzRaJKQqyeaRAw5E3fVS+w8hoR2osmOD+bUafWhQTJyfRk4eK9I0qnktYdGmHmwfAqeyG40ZGi4GmqsHdgppragNsEU0KU23Rstu88GPw09mB3sp9RpU6RHOcGk/OcK8V/4a9Toj3QZSz0aGpLi3ggV/sZj2/S2oK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:43:04.9689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 596b667d-cd38-4cf9-9bf6-08df3f952148
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB214768
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Charlene Liu <Charlene.Liu@amd.com>

Raise the DCN42 DDR5 stutter enter and exit latency so the bandwidth
model budgets enough time to avoid underflow.

Cc: Roman Li <roman.li@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
index 139e0152fcd6..876a6f1cad74 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
@@ -224,8 +224,8 @@ static struct dml2_soc_power_management_parameters dcn42_ddr5_power_management_p
 	.dram_clk_change_blackout_us = 36,
 	.fclk_change_blackout_us = 0,
 	.g7_ppt_blackout_us = 0,
-	.stutter_enter_plus_exit_latency_us = 25.0,
-	.stutter_exit_latency_us = 23.0,
+	.stutter_enter_plus_exit_latency_us = 28.0,
+	.stutter_exit_latency_us = 26.0,
 	.z8_stutter_enter_plus_exit_latency_us = 300,
 	.z8_stutter_exit_latency_us = 200,
 };
-- 
2.43.0

