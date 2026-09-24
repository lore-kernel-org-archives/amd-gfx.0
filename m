Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A76EC98321
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B98AA10F72B;
	Thu, 24 Sep 2026 18:46:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Uj0Bxeby";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BB2210F730
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFOXMxrepIyY2+DhOGn7BWUhYhl//008jcxiut7mzmJs0NxubO4JMMEjpjA0mVXJWF4126QeeWgu2Z4knvhLMxJxKOCqQVa09zYYk8Z3yInNrba7UcJmEqhkndIXU4Rbt7JebWhLqG/5CbTcV23tUDi86jhTLYDxIIjSvNPeja6moII5AwiqAOjn8ypneaHot4/sj3CWIjGOEkitCsMGD2/eA0w2wg+lUZl2OSi4izB5Z48bGinxzkOK6u1PySf9HfjhO42cPO4DYJ8YXPTctN5ShnWfQ9gbb31BU1kiQZ7g2UVQ0iVL781zvB0bsQ9cRxL593bsZezvDBWhXxplbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3L0I5/Pm0eDioe7PdDBuiZMEgQdLW3nmf/PaA2WON+c=;
 b=rhnhBSK5j6ofZSni+bPEVvcx1gBBik5iJKw+Mqj+VY0PwOBDKCiwxAztMnT0k5Q1s2ZYDW+iD7VCK9q1lpv0yW8JQUhRzcjAIjuV8m0faVORa1um80XwvVMWlZR/o85274ATFN+ngYJmIOhdLv9fwjJ/egpdNI/ZZKT9rsNxh47KTkorSDuk00AAHS8zdgBWWR96/EOOePmoRTDWDIMU7OndLEHVayqohiBRVCfWCqiOBa0xs7babzFuAimtmNbjjzR+EqW26ir95SsYA/miEueAFCUf8NzI3MFycDcdIRXxl7rVoqw+762x0Hmd8fggpvYMUXYLWk/SbCB3MVriNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3L0I5/Pm0eDioe7PdDBuiZMEgQdLW3nmf/PaA2WON+c=;
 b=Uj0Bxebyb+5aDfs1B/2G7S2B0Bir1HymjIF5nhjyqIQJvxHsaKLtmTYpVP/dNcJ6mZOjmwA7p7OSzV/7/q/cieuLOu5XaPP48R6hu5KoTgNjNOqQYg/DrR55wy1pXNWw6ZNa0Le9tti2L6XsRju6Cs3bgeshUg2vYNEN59MWv5k=
Received: from PH8P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::18)
 by LV9PR12MB9830.namprd12.prod.outlook.com (2603:10b6:408:2ec::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:46:43 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::8a) by PH8P221CA0016.outlook.office365.com
 (2603:10b6:510:2d8::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:42 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:23 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 31/34] drm/amd/display: Update default clocks for DCN60 lite3
 variant
Date: Thu, 24 Sep 2026 14:45:44 -0400
Message-ID: <20260924184824.596894-32-jerry.zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|LV9PR12MB9830:EE_
X-MS-Office365-Filtering-Correlation-Id: b573eb07-79e4-4263-2c04-08df1a6c2d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|10067099003|56012099006|11063799006|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IL7gc7Eh0yJ2o/lwL3e80RaTRgyCLK51a2Ghs2Kd89etl5NgjjRILRbmMOL5AhfJ0FX0rBTqWklcnaOZb0D4LqG4OSzKCRwGUbCQxj6Y19BYEGVbbUNviK4VQjR4PoP9Du94xfoDDzm2fg7FcZ4/lzBELtpB2lXnxk4ytk+hVfp/TJZAUL4HJwne76W8Yc3wXmhUN5cfHXoSr34sw8uWNggHnVxQi4q8AeOFceGPBabNQdMqZponwuw/3ZFHNYlJ4xh/ltSdyqruWsHt9Z/jvfgXasG1UNG0ehGmm2IRjsCIUT+5GLSN5R7EtJntbb7HCWA8fhS//epAqpxiviB1JYOgsAmaxXqSSX18ywZwoXIaZBH3P/cuyz1DqSHcJS8R0IwUcmWGXn3Hy1Vna6RsLLsI1Kf7mqjmi0+EkIQIPhideTCQEkVTV698qNwbkgciZkXtJx4hyGcL+0F67HiE1TJPR/SpghNk1/sil6o1oJlMYgOSCOeoTJy0cMp2zu+P02q6sIBSE/q3li8k/onVzsQnFHZ8gNPzDNKThsnRRSvvvEqNAjAjyINXTSXZRIlf5tFBpggv2fia83pzoiR7hKuQAocNeQj+rRG8jDbAIPsJPAOpPhtMJTVKl8vZil+JigZ7ztjJ8dBYt9jV0qIRHfk1euPPxApFy5l1h0emLB/21Wa+DxTgpy3nvzRm75cMNXbNO3koU0hoTTMMEVvM0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(3023799007)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wN8uGWLrs4lRXacrcoY0Ew5YMDa2Iz363wnhJ38o1eg+jF6sdUXqsMftKwvD8i8X6yqLD2klsCsCxVFKbxRtf/lI0Z1qjZxJZs+VxoR1nltbpnxnAAJBA6AEv18FiEZOuhmM6d+LXeFiYVEmzgLhA8ZNSSlgV7pJcrASr1o/psNO/16eH3wbcP3Ge6N1pBKkZ9iEzSDZCxicmDHeE2QY+4A+zFjm0RXXoAlkZquEMkptpLsaVGwIE4yBOAO5Rhm0OddF/tb8sExIL5smrX/xc+4uWz1BwpmkZjTjh6rrNchPo3R/n1kU/8/FpCch/gjlY2algMi7IEa5bnsOxcy6qgNBiLlkf3mxxyykzusmb3ORmbmInKema+WJcTG8mgUteMtscQ0g5azkjAtcItDP4l8dfy3V5MpNxPFYmCnopRgdl+CloXIIS/TMQVAvYql0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:42.5631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b573eb07-79e4-4263-2c04-08df1a6c2d31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9830
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
These are important for getting correct DP and audio output.
The wrong pixel clock will be used otherwise.
[How]
Update the default clocks for the DCN60 lite3 variant.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
index 26972c220e34..9ce378b821dc 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
@@ -1804,6 +1804,7 @@ struct clk_mgr_internal *dcn60_clk_mgr_construct(
 {
 	struct dcn60_clk_mgr *clk_mgr60 = kzalloc(sizeof(struct dcn60_clk_mgr), GFP_KERNEL);
 	struct clk_mgr_internal *clk_mgr;
+	bool variant_clocks = ASICREV_IS_DCN6_VARIANT_LITE3(ctx->asic_id.hw_internal_rev);
 
 	if (!clk_mgr60)
 		return NULL;
@@ -1828,14 +1829,14 @@ struct clk_mgr_internal *dcn60_clk_mgr_construct(
 	 * dcn60_dump_clk_registers from 4 * dentist_vco_freq_khz /
 	 * dprefclk DID divider
 	 */
-	clk_mgr->base.dprefclk_khz = 720000;
+	clk_mgr->base.dprefclk_khz = variant_clocks ? 607407 : 720000;
 
 		/* integer part is now VCO frequency in kHz */
 		clk_mgr->base.dentist_vco_freq_khz = dcn60_get_vco_frequency_from_reg(clk_mgr);
 
 		/* in case we don't get a value from the register, use default */
 		if (clk_mgr->base.dentist_vco_freq_khz == 0)
-			clk_mgr->base.dentist_vco_freq_khz = 4500000;
+			clk_mgr->base.dentist_vco_freq_khz = variant_clocks ? 4100000 : 4500000;
 
 	clk_mgr->dfs_bypass_enabled = false;
 
-- 
2.53.0

