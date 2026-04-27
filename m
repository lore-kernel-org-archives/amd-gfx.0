Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E410FF8865
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 07:34:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0565C10E5B2;
	Mon, 27 Apr 2026 07:34:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G3JaGgeE";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9EBD10E5D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 07:34:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQmm8o1OrPY9ojqIBiaP61WUG5fYsuveI0g6O5b0KOKiJaL4xoEnN2I9DtEVx17BCX1IH2fTCgqBnPqLKZopIkNAxWxINhqTOlkhhEGhbC4C1zT7HZG+BiPAARZslF7EmItRoAiQW0Ek3ETgqPwJLyEiefzJqQtb8DHv2DrAMBBQdwLxp2U8YFWIJcxyepw3oQ05jWAEL45oqHX/SWbLsT1ufWD6p+MNfKxp37mM5nVXwAhlQCT55UMqGFA5+adJPM1IlSuNnfPLmeawbIHPfseSHeEiWwbWovYL/KPJMI1Wygjz3H7ytEmtZZ97sZHs8yMX7szayy+vXXlfuKET8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3et4FAs0TmYpGUaJ8SJsLk52z/YgtYhID+dNdFZRIto=;
 b=dEc3FQOIDFing42Cdr8PCgOpV2I4xWnpFA6WUsL1MnsSYe8bw1av6MFq3CvmNELmSkm4gjpUOzFhDMGLgyHtLchBaxBgHpuzIxyo2lKJKbeZSLNIUxdYE7KWsPhsGKaySCxGQIy+Wsm3HP9MknM4pjN6tNuefuoCTewHnEBBU++rIh0iRyPkcI7gxhjM/I08d43ZZeZYOcLhEeae21m1PMtzafe5iqPLAnnv4lJga7TgvbKyo2irNxYcfQH1z6kJ9dEWo2lyvquZO13tTJz0Pos0yoy06GLZhqlV6fztilCGpGWu6oba8W/NqzpRBvK3Ux16K5LC1Iu6SvAFSIGoRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3et4FAs0TmYpGUaJ8SJsLk52z/YgtYhID+dNdFZRIto=;
 b=G3JaGgeE+y8WhWcGHfGd8sP9UjdXc31Xc3zCA57PkzyEXzvo1eDYxOg8ZOBC2qPrOjih39C0WM4N8CTi9oUXPhHv1HcWvWo1cJEEc2i3or3bJhRLfGjWk0z9WRK9/3h49znhujDFkDPZ1nY5Xft3Br2mK04brODkXDqy4LuysL8=
Received: from PH7PR03CA0018.namprd03.prod.outlook.com (2603:10b6:510:339::15)
 by CH1PPF84B7B0C96.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::618) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 27 Apr
 2026 07:34:21 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::96) by PH7PR03CA0018.outlook.office365.com
 (2603:10b6:510:339::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 07:34:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 07:34:20 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 02:34:19 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 3/4] drm/amd/pm: use the SMU multi-msgs helper in smu_v15_0_0
Date: Mon, 27 Apr 2026 15:33:54 +0800
Message-ID: <20260427073355.3363500-4-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260427073355.3363500-1-kevinyang.wang@amd.com>
References: <20260427073355.3363500-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|CH1PPF84B7B0C96:EE_
X-MS-Office365-Filtering-Correlation-Id: 31a80499-07bb-4cc7-108c-08dea42f658a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3ZtRoAaG8fgoT8gkPLpFhaNgXKRaNml19UUP+sbUL6EN9Up9aGcE3UGJbcbcTEVnWOHBMV7enf4A5YRsO7qNsyhtmRw40J/51TF6aM5mzsvT7MIYppkKPtWc22/mcOs0LT0wM2rtPYenFy7LKTI5w5SJp6NOWsWXwQ7dUpRboyteN9mpf49tUaCFISrwRLS7W2QBUVE/BRVaduq5yuFpnSIFSvHFKrXNXx6NcQ2/SdPGGAfwK+xXN2MuYmEFWwxPfDVjTTlTGrGeKC+5TMXuI4NCJk8okqEBvDcPnwFFp0LynSUU+mh0mL0C9p7HjjKi2oPvk4RmXVple1XYrNG4Km2MnKQSsnhSAaW/kEtqr3w+MxOzQccSW8pHce5j2L++RP0T3LjBwxAvfOT+EjYroCrI5cyryUq7Vv3d+3MHCwIPksJqWdtNbaEVXW8nfGjLufBPN/dfXfCbT+ZKqxsSH6oEYxINAyo57wT014QoBv00wNHbhY+a0P1nLlckjZuFgHSTzdnEFSyrjuRRMz+Ql0ydCaQ7mem8yDxQ+TCsmPx2GFTKhAZ+RwjaftapSUeOz3PAG6U/KvJxgQA0sUlX+6+sNXk48b2ONWurFT+si2TZt1Slks9HRJ78ThTM3ZlRT4wYy7p2mu4RNkg+W0W27p1wtZoFqECwz1b3kmlrFStcGD30Fb4zzANUp8k4zUZ3X7/cRhyb1czojJyJOH0fhSOwBnbh2c73g8vGZn0oEYfPXFQ8UXD6/HwcC70Ixm9uaOI/A/IW1NAMT4PSk6e41Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NqdylPxnHsmyQgdnAzDjzKYXMJmzPumd5oce6zjzYGJpJ6t9QudGir7ppK4BT233/EtNnEK2mokZiYte+1TAc1jQOAsYYvWQbC9Ri5NUEpbS82rzWkBJoOJV2exHyS6yIYbkxPDH+3YUHsfmNNbs+0mvzqzI2CDVDRGV5FB2TXIAV7aJLAPOJAfYx2JNvhPOP/+kHRtKKZZ05hNK12GQDH33bqfk71vkldhLIr2mpETPXRKDiizxzc7yLg/wMMCOpeckAKItayRx0oTizl7kMiwc9zqxyNUcQHY+oupRM63KKzowJy5OCGbXpYpfggoAWNZ46C0e/lb9MfhcNJT1O8K6LOP4aDgmy5f8WV6++x+evplD4eA6UKpeq+d8rSFH2buAj5LFs+we3ZopCILoT/PUi0X17dOKYtSW1mMpbP13NQgPJpQx6pResB7U1+5x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 07:34:20.6312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a80499-07bb-4cc7-108c-08dea42f658a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF84B7B0C96
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

Convert the SMU15.0.0 table transfer path and enabled-feature query to
smu_cmn_send_smc_msg_with_params() so both paths use the common SMU
multi-msgs helper.

No functional change intended.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 38 ++++++++-----------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 9a4a5f482e75..4e7d6a602c6c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -248,7 +248,7 @@ static int smu_v15_0_0_update_table(struct smu_context *smu,
 	uint64_t address;
 	uint32_t table_size;
 	int ret;
-	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+	uint32_t params[3];
 
 	if (!table_data || table_index >= SMU_TABLE_COUNT || table_id < 0)
 		return -EINVAL;
@@ -265,20 +265,15 @@ static int smu_v15_0_0_update_table(struct smu_context *smu,
 	}
 
 	address = table->mc_address;
+	params[0] = table_id;
+	params[1] = (uint32_t)lower_32_bits(address);
+	params[2] = (uint32_t)upper_32_bits(address);
 
-	struct smu_msg_args args = {
-		.msg = drv2smu ?
-				SMU_MSG_TransferTableDram2Smu :
-				SMU_MSG_TransferTableSmu2Dram,
-		.num_args = 3,
-		.num_out_args = 0,
-	};
-
-	args.args[0] = table_id;
-	args.args[1] = (uint32_t)lower_32_bits(address);
-	args.args[2] = (uint32_t)upper_32_bits(address);
-
-	ret = ctl->ops->send_msg(ctl, &args);
+	ret = smu_cmn_send_smc_msg_with_params(smu,
+					       drv2smu ? SMU_MSG_TransferTableDram2Smu :
+					       SMU_MSG_TransferTableSmu2Dram,
+					       params, ARRAY_SIZE(params),
+					       NULL, 0);
 
 	if (ret)
 		return ret;
@@ -535,22 +530,19 @@ static int smu_v15_0_0_read_sensor(struct smu_context *smu,
 static int smu_v15_0_0_get_enabled_mask(struct smu_context *smu,
 					struct smu_feature_bits *feature_mask)
 {
+	uint32_t out[2];
 	int ret;
-	struct smu_msg_ctl *ctl = &smu->msg_ctl;
 
 	if (!feature_mask)
 		return -EINVAL;
 
-	struct smu_msg_args args = {
-		.msg = SMU_MSG_GetEnabledSmuFeatures,
-		.num_args = 0,
-		.num_out_args = 2,
-	};
-
-	ret = ctl->ops->send_msg(ctl, &args);
+	ret = smu_cmn_send_smc_msg_with_params(smu,
+					       SMU_MSG_GetEnabledSmuFeatures,
+					       NULL, 0, out,
+					       ARRAY_SIZE(out));
 
 	if (!ret)
-		smu_feature_bits_from_arr32(feature_mask, args.out_args,
+		smu_feature_bits_from_arr32(feature_mask, out,
 					    SMU_FEATURE_NUM_DEFAULT);
 
 	return ret;
-- 
2.47.3

