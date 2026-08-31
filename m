Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED44C61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 04:35:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF21C10E5D1;
	Mon, 31 Aug 2026 04:35:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xlCCqmOp";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76B7A10E5D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 04:35:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlZe03mouVXJGTIMyNUD3ppwBf8ErOkhYinb0mHwaIKm7e2VpUxI6o3Hk2hE0zfEnox6F5rnW1X80jLdnoxrp+WDTvfKVsUliqpRiXWlbT+X9OrOLb4sJ3qadwDvz41aLiDLpB7PBJIAk/g1zwDl8kT+TeIoKr+RGiAR4eLV4NOaar2kdlGFI0hcvq2hGWZjRLse1Mtwj3dqPy5bbn362hsrEvJPZIAjZYNbxV/xG5qjR8xqHsSA09Bk2LcMH4DhQTNdexiFaxRGN4KSp73BzrwuqiQuPv7PlPI5nP+H5UDN8O9bqadC8Sz/bfB/4qFzZccUF22azmTfMifeXwepBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cb0eVP6pzRwzXpWJxymUuFVo4U+38Ql13OPNN6+aKYo=;
 b=SO8TKWDTFlT0jBDn+mMN0zZplDBR/zgdB21+pi50kPuwLM1zN9ZbqgJGgxe9g+ZhRzsK6KtZId9Tcaeyy9Bo5cem+e05LT2YW9xBrq0O1coiVD2/2JRz8Gu1Of6YJi0v/kz2fGgf/D6pYBYMoLHpaGYsiRNZbySPRbVCuq2b8OzjwmGG2OVz4juvBh7cTbgtFp1dv2kbl79aZE9sonoRfHmnugRIQU3vGuosnFmJVru2oV4D8P0pRIYsaoqa9hkuAqz4FmN1tAj/jQJKV3UIxUonzONBNsW65hfdlvbW1bNfJ3qAEceg1VTYNAVYA9VnKDKjNZ4zg8DbteJ4jNiz3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cb0eVP6pzRwzXpWJxymUuFVo4U+38Ql13OPNN6+aKYo=;
 b=xlCCqmOpZW57Lpjrtj34Pqfu48mKCZv3IUn7ZlzI933ov+XLylmFoJUJcmDg5PTlKPpet07dDsm7VjY4uex3rn3Hiy/n2OA1JmS1CdJN2kVpG3sgFW4amrJ7wiS1uiEiZaKVS4DCBf8UHRH4lqYybfT5eZmJ311YHz2vLilWW/Y=
Received: from BN9PR03CA0578.namprd03.prod.outlook.com (2603:10b6:408:10d::13)
 by SJ2PR12MB9240.namprd12.prod.outlook.com (2603:10b6:a03:563::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 04:35:31 +0000
Received: from BN2PEPF0000A802.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::58) by BN9PR03CA0578.outlook.office365.com
 (2603:10b6:408:10d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 04:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A802.mail.protection.outlook.com (10.167.245.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 04:35:31 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 23:35:29 -0500
From: Kevin Wang <kevin.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 6/7] drm/amd/pm: stage od reset for smu 15.0.8
Date: Mon, 31 Aug 2026 12:35:06 +0800
Message-ID: <20260831043507.523599-7-kevin.wang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831043507.523599-1-kevin.wang@amd.com>
References: <20260831043507.523599-1-kevin.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A802:EE_|SJ2PR12MB9240:EE_
X-MS-Office365-Filtering-Correlation-Id: 94c85d0e-bf79-4da3-40b9-08df07194a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4Pb7qJTg7w9X9kJQHd7oMakPo/xEnH4jqzA3TecurQNldhp/pAjR/aDnXNZSyLwx+CyKLbj6uVysDkmJ8iJAVhUrB2c9TC5c8w3q82L4Vbsnb731FSEQVyUI2QJ50MOhGtvFvNJbsoH1wNXXPLOvJXGh2j57GblPDJYrcxa5m0Fd0Z6l29hsbUWIr142J5jWlPjKcg2tPBxxY/2XMzjW37sIi1D5lOn2URaxRnQXZRedROOr8sibvcan6NBjyCdHob7Bnn4IjfDeKgqvmmGEr1OYINozQClSnoBHxa1moZrLhrTjk3WHWCzO7wDHkCPkESmiaRZlg/WeBAGe1YTZIjpEfc9Vo27+C2/ev0ILLpXHAlWr5FW0XI9fnfh7fUf3Y6j9oU1lt8KmkDKumUHdKdDcH26NHCDMDN3Sy13lSviwvvJW0/nVqr1CKZkV6M1/Mpu/0nV0W6o4BKnn9h4SOzL4j3hDXsFRTLF5mm7l56HY4MvIT/uG3ulIAOuyVdYS4fOnJHcYSy7jWwyLANe/Raz2moyL4f9w8guUAb1ZURLaCcuoGwwVekUPR6GowPQzA6jXV8EBe8W29V+6ru4bHjDyeObjYzJok2Zn1sR5xBFBGhUyoHT4hTbXn2Q69sIVHV9uRZIm2/ek3m5svE4Mqk1Eln0yZGW3QmD+cTr9axqww2nyHHm6ML1eweN2u+9JVElqR/VJhFaf5Uqu8HZxOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: J2Je8W0zIfP2EdO/RPEzQnm+QghGWmErwBDadZu90bkXAGj7At2boWPLiIEHD+qoskNMI6mHnu6OvvjsP82vcLG8uj3EOfzTgVFfgBUuFlUJAGOmxM2+FIG97jqjA+/+O4MLkaFsm+nAc/6Hg26aUAkoddSFWVKL0V8kgMi/lFZgOpOCYfC3Tno1d/e0UpXythhbxcHwKhwO7Ig/p0vKVrPsm1i6LVpiJHKVPnV030w3gacA6B07fO9Znkl/WZB1F16yFY5zwU/E4LzxV3Ke8o5IYOI0IrWHB4Eu2w4m3GOi1s3JW9f6LrXL+dnKT3nE8kYHPq+mBQLpsFjfMXvzorfRiB8YUf19W/75/Vze8sua/XJNAgIBLSKK2SiOr+vebJkNbl3FGIma+0UcspLmBqaKYWcBj2l3hsKKcfdwusa7YlHeKcQ47Gf7EL8PnLIx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 04:35:31.0555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c85d0e-bf79-4da3-40b9-08df07194a3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A802.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9240
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

SMU 15.0.8 applies default GFXCLK and UCLK ranges directly from reset.
Stage the defaults instead, leaving c as the only PMFW update operation.

Only stage and commit UCLK when its DPM feature is enabled. This matches
the edit path and avoids sending an unsupported UCLK limit command.

Signed-off-by: Kevin Wang <kevin.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 50 ++++++++++---------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index db0e0733588d..0f7a8b4585d2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -2072,6 +2072,28 @@ static int smu_v15_0_8_set_soft_freq_limited_range(struct smu_context *smu,
 	return ret;
 }
 
+static void smu_v15_0_8_stage_default_dpm_limits(struct smu_context *smu)
+{
+	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+	struct smu_15_0_dpm_context *dpm_context = smu_dpm->dpm_context;
+	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
+
+	pstate_table->gfxclk_pstate.custom.min =
+		SMU_DPM_TABLE_MIN(&dpm_context->dpm_tables.gfx_table);
+	pstate_table->gfxclk_pstate.custom.max =
+		SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.gfx_table);
+
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
+		pstate_table->uclk_pstate.custom.min =
+			SMU_DPM_TABLE_MIN(&dpm_context->dpm_tables.uclk_table);
+		pstate_table->uclk_pstate.custom.max =
+			SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.uclk_table);
+	} else {
+		pstate_table->uclk_pstate.custom.min = 0;
+		pstate_table->uclk_pstate.custom.max = 0;
+	}
+}
+
 static int smu_v15_0_8_od_edit_dpm_table(struct smu_context *smu,
 					 enum PP_OD_DPM_TABLE_COMMAND type,
 					 long input[], uint32_t size)
@@ -2159,27 +2181,7 @@ static int smu_v15_0_8_od_edit_dpm_table(struct smu_context *smu,
 			return -EINVAL;
 		}
 
-		/* Use the default frequencies for manual mode */
-		min_clk = SMU_DPM_TABLE_MIN(&dpm_context->dpm_tables.gfx_table);
-		max_clk = SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.gfx_table);
-
-		ret = smu_v15_0_8_set_soft_freq_limited_range(smu,
-							      SMU_GFXCLK,
-							      min_clk, max_clk,
-							      false);
-		if (ret)
-			return ret;
-
-		min_clk = SMU_DPM_TABLE_MIN(&dpm_context->dpm_tables.uclk_table);
-		max_clk = SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.uclk_table);
-		ret = smu_v15_0_8_set_soft_freq_limited_range(smu,
-							      SMU_UCLK,
-							      min_clk, max_clk,
-							      false);
-		if (ret)
-			return ret;
-
-		smu_cmn_reset_custom_level(smu);
+		smu_v15_0_8_stage_default_dpm_limits(smu);
 		break;
 	case PP_OD_COMMIT_DPM_TABLE:
 		if (size != 0) {
@@ -2207,8 +2209,10 @@ static int smu_v15_0_8_od_edit_dpm_table(struct smu_context *smu,
 			return ret;
 
 		/* Commit UCLK custom range (only max supported) */
-		if (pstate_table->uclk_pstate.custom.max) {
-			min_clk = pstate_table->uclk_pstate.curr.min;
+		if (pstate_table->uclk_pstate.custom.max &&
+		    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
+			min_clk = pstate_table->uclk_pstate.custom.min ?:
+				pstate_table->uclk_pstate.curr.min;
 			max_clk = pstate_table->uclk_pstate.custom.max;
 			ret = smu_v15_0_8_set_soft_freq_limited_range(smu,
 								      SMU_UCLK,
-- 
2.55.0

