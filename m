Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519E9C5B572
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 15:51:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E41FF10ECAA;
	Tue, 11 Aug 2026 15:51:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z8J4XbSA";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010008.outbound.protection.outlook.com [52.101.46.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0C7010ECAA
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 15:51:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3gU4+Hq3xBTpjTrJT/u5I1qVtm7Hisw8nnJ4DLrNipm8kC58o5hoPiyIb57YWl+EUEso2S1W+y9c6m1MBYdV2MJK2zjpxdmvJrM4d3D0mvpejhbqDiwo2EUVMVZTrioGb1BGC2AReYFycsWI5ch2t2fb3wOQUksTsP+uoiueajnTkY3rIn/9m/gJvO37laHIP3PZwuQsYXUHIQba9e7xlueb+x0zkaSmr1ouVwQKLAxQOya114g+xLvcqc4b+DO3+dutqccl6suhbUIpbjvi6DIcRWHxT9o4Wr9CU/utTU4rDZmDXRtMpLMzMzdulvGeExo/Ay7lLtP2EV0MY+L8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPOoFkEU28GsxUYmGTozw0OBRvHBM6FOtq1Sry0rytc=;
 b=IctRReiIXdxAsXiio+zE/WbbKtu7ftjHRVU02K388Ni3/hGm+kSmmhrT7aHl1buXP7zyVzS/LvBdAISMRPV6Qo5R86GlMGEYWi/NCH9klIUGe6i1Y2m7yFpQ0p/PZwfvHFEkBFU6x2Py5fWhJ+0b3iM+y2u7beZO22PBCTYQIfBUAgeF+i5HIyvydaRbWbvwfCOAdvk8da5ROY544yQ6bJ91MyDKwnQGROahp4uW2j0cpyPSmc6WwFPdET2f/ZnzoBn2Yf2rGH41pgJJAf/EkZXIWAFLFfazzFZlJui+TvaaVfi8JL2NDp2dpGdHKLMKQDuPc0+DIRlIHZ2BcqO/sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPOoFkEU28GsxUYmGTozw0OBRvHBM6FOtq1Sry0rytc=;
 b=Z8J4XbSA6amnmJv4unN9ialt9fVcS8Wo2eHWsNiRmYRPM+zxCcorYYADb90haHy1+SjmQN1QPx5bFfKv+QED2meujtbXmUmqb71XmmZWKHtumiD4STzY+OxkSwLvMtvh6G4BgR3KNuniSDT/1MhYKbna5RWnR6+wigHekSHJt4U=
Received: from CH0PR03CA0233.namprd03.prod.outlook.com (2603:10b6:610:e7::28)
 by LVUPR12MB999135.namprd12.prod.outlook.com (2603:10b6:408:3a1::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 15:51:10 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::5c) by CH0PR03CA0233.outlook.office365.com
 (2603:10b6:610:e7::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 15:51:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 15:51:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:51:03 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via
 Frontend Transport; Tue, 11 Aug 2026 10:50:55 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 19/24] drm/amd/display: Update soc_and_ip_translator To Use
 Updated Per-DPM Derate Organization
Date: Tue, 11 Aug 2026 05:28:53 +0800
Message-ID: <20260810213010.1703162-20-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810213010.1703162-1-PingLei.Lin@amd.com>
References: <20260810213010.1703162-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|LVUPR12MB999135:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f9aaadf-0e47-4f74-9334-08def7c05cf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|11063799006|56012099006|3023799007|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LljVcRXoet30YI/5LOunEav94wlVgZ8JPI/AC9KFym+2VeU+URsPxMNDD4nwdNEKv7eVRL7YdHvAwcR5CL8STEQWzSxg32RtdU46LJaLdwJcaPesG3zasA8MejfuwDzLArLGUBQ6N538P3tKDMtlzKgqnMcubtnE+ghx3jYBVzDbbVFNbi7j3Dp4YZA7kDATial9h/fNe/e86MWaP7Px3OBRUTK0BllT+XIdqoTBjNbzzat1w/nAPCFb7q+OELR8I4m34xMSTFtI9AplORBCr0oGS6M5tnwzMqaH6mTxyI5cVplDE1bahNOrERr51E0v92AXomLYL0ncXKi3WdIIyUZj1pfSvBcnCQ0lVJ5p+e3Zxph7it8fiVc5mggnQynXbIqh8Qo0M5mQA60/1lH6b7vB5PJEsb3QxE/SQFrwrq2bjFZ9tBjUj4qc36v/7RrBpkTvNI7kwSEF+PZKcX69TsImO28dYsScZ98B1VyE1yObQiLeXuFUYUXDks7dMEd8e3l3FlT8VSW/ZP6HCC4fGWqZb6R47/AASj3oU6ZHeTruwB/yAOhnMqbWMHuOwvQQDzI5BaXXumoo2OR6tzYq7FDNmxTyX3wQeUP7sw5m2v5UYWB0PqPPpwybzYNynVuahwuDDwwj3TAmV0itgCqtYijnj6/zAP/g2qeXtEiVvq2ieuBhQ6mhTMC/lXxQvrQ8D4eOyWI4NSBI92aYuqifGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(11063799006)(56012099006)(3023799007)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8iviJWwmK2PzLMqyLIAeB8bE2kdw+J8sWUBblxBj6ZLxLj0aohMCf1FIxHEry+qz1Q4K7GOC0vU5ofKRIwv8o0GezuawkhcU8QiJqeLh4Gs6fCDdp2sw7238KR/5ZZckuNgGoaQJSAgJmRgi26dVKKZB21vyLTWgQ6VQLNOvTWRfS2UcpVI9SfIFeWiAyA/vqmDgQdRai88NL3L/6NgoHV6fTFYMJbTILF0f2tqtvMed7v0AG2y31QZmd9wfVt974apXKbadlO3GOjbmnY6/6jugAONTHgo6xUPkp/ujRB7eiyvwy7gswjZyZ4qMv8RovTpmNbCq0hUTS/yZdCO4Ga3ZNtwwxyu5oWVJG1Gu0cExxMJYF0l/L74L5LFN6qux41AomKTWNKxYmxRvxT0E8W02+zc9xcAn33p55c34a6zH+r0/rqtS4nNbwpRUcwhG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:51:09.8049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9aaadf-0e47-4f74-9334-08def7c05cf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999135
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

From: Austin Zheng <Austin.Zheng@amd.com>

[Why/How]
Transitioning to use the new per-DPM fields so the old ones can be
deprecated.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../dcn401/dcn401_soc_and_ip_translator.c                   | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c
index 0c8e652c3532..c3dfcf2a73e3 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c
@@ -278,11 +278,11 @@ void dcn401_update_soc_bb_with_values_from_software_policy(struct dml2_soc_bb *s
 	 *  bits 16-23: dcfclk_derate_percent
 	 */
 	for (unsigned int i = 0; i < dc->debug.dml21_custom_derate_num_dpms; i++) {
-		soc_bb->qos_parameters.derate_table_per_dpm.system_active_derates_per_dpm.dram_derate_percent_pixel[i]
+		soc_bb->qos_parameters.derate_table_per_dpm.dram_per_dpm_derate_pixel[i].derate_percent
 			= dc->debug.dml21_custom_derate_at_dpm[i] & 0xFF;
-		soc_bb->qos_parameters.derate_table_per_dpm.system_active_derates_per_dpm.fclk_derate_percent[i]
+		soc_bb->qos_parameters.derate_table_per_dpm.fclk_per_dpm_derate[i].derate_percent
 			= (dc->debug.dml21_custom_derate_at_dpm[i] >> 8) & 0xFF;
-		soc_bb->qos_parameters.derate_table_per_dpm.system_active_derates_per_dpm.dcfclk_derate_percent[i]
+		soc_bb->qos_parameters.derate_table_per_dpm.dcfclk_per_dpm_derate[i].derate_percent
 			= (dc->debug.dml21_custom_derate_at_dpm[i] >> 16) & 0xFF;
 	}
 }
-- 
2.43.0

