Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DE5CD5BD2
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 05:17:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9527410F8B3;
	Fri, 29 May 2026 05:17:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z1n31H6B";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013039.outbound.protection.outlook.com
 [40.107.201.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76F6110F8B3
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 05:17:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jytuZIyG0uXQh5m+8AdJqD1qCRHgAwUtQ6GnPsqxvp1nvCgDVqfeuyKkjCeDw04EyjqtzYjqUOOdvAJQllDPkfbivuiO/pFqRtXBws+DhyWcOCehKx3TGL+eO2uwt6woCgiWi9wJetcCPtvLF4mIJyDuUeZQ1oZ5YuTG5fkAsZzhdA4tJrsyAtMq4U0k1f+d581JNhgia261V/oLndMW1+VRIIAU3GZOyoHFrIBjJXnRWdShw3drxITvuFnKebwvfzVoN80/sPHfjeAjHNtyAFhF14g4n+gSPDFTs084+iyPLw1VBVOSlzZsf25k1lRP4ONFhgIyffbwrZqUwZyKiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98TpvoGMfYkga9qBeY+3aWPtsBGYpQTqPnbwJ+LKSFM=;
 b=iXxG43KTZGG4/+qW3lc3wm3LmW9NTAXfqzvEpSM21wcunAHRJT/O1YUk6+S3seGHCnhcjgLoB7pCzwcu4Ot6iqfiO3U0+FBuyZaY/f4m6W8/BiKi/Q3vmq8p1NFve7NJnOsFotYEuwm7/feI2+ZUubs+XBBtajfIGQBCuYWCa1ckHvBYD5Z/tGGpFiDv/wM97P1hmVLWtNrUSSAMQfn3hJLe06fRPJoLE51pSnVwAfmPJIYsZQnNxqwEQiSuuzp1vLEXHF/S10fVJDx3HwAI4/MFPfaOQLjgaA7Iv4nvY74rU7oWBPIllfAk21pTTIqce8kFnA+QB6ITyrGLQXEmKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98TpvoGMfYkga9qBeY+3aWPtsBGYpQTqPnbwJ+LKSFM=;
 b=z1n31H6B3u9xlKh0rrAZBG/8h0bfylBgngR0O2oeOFMlPvbVgpBnG/GfpiEZDVtMiDXJNnGBs10ZfQ2mp5mS1KgDCMzqPMqIhxgKfoeJ+2qX9A3XURuGxvia/nkv5A7W2iYCH6+dZQ1hW1tYlOt/XtFVwjGG0q00sJiCfY19iQI=
Received: from BN9PR03CA0619.namprd03.prod.outlook.com (2603:10b6:408:106::24)
 by IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 05:17:43 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:106:cafe::b) by BN9PR03CA0619.outlook.office365.com
 (2603:10b6:408:106::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 05:17:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 05:17:42 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 00:17:40 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>, <asad.kamal@amd.com>
Subject: [PATCH v2] drm/amd/pm: set energy_accumulator to UINT_MAX for smu
 14.0.2
Date: Fri, 29 May 2026 13:17:31 +0800
Message-ID: <20260529051731.1398910-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|IA1PR12MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: a76d06cc-45ac-4b15-2049-08debd419c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 2Jfs0WK6BdimERY9V5uxnX8WVFlFkMyPaQLTQOv9nxnl4G0V39nt8GHBn5H53ftwoZPgKfCRHvNn9ZYuEaC89YOz4ncAh13Vt0aTQQYkSnNFLeL48WtywIG51i19iXmYxHmibpIm3s/xvj+OEWSySmdPt7b92C0+bbV/io54CntBeo/LP/wkneCq/LS6WzOYj2rNBqrwBmT6nkZsi5kIf+t4Z3oJLD+4d6szj0grX/NNqz7MICapIoxyrsMTwBzIxGTan+d/2u+FEdSjOWDcyBTZSafG/ZIsz/DSzi/Vyy0qCjbu0/UofysNcJodMruCd6EyZm9SI1g+PNx8qD9AJx0A4XU3qc93Uqi02egmTkAucbVzXafZJ0+yAuNFEsddCEtbLxWjIiC5N8PgF7cnS+fyd+V3tUSX9/2xkQ+1wkJ2xNP4LoxTFConC+lL2pHG6MPvnpOWzXxFTY/G9jWypdWBd29suQFBAriKMXqiHWAkRfhHaXQlhojWQjRibTTnvs2cGLWyIyFsyD5Xn+N2TE2L78GaA6orXQLqaLYPZ9LzyaGOwSP8HWavcf8LK0a2CE32xfya8YujGKLI+DFfsYVllK4cgCOyvDvey9a1wyV2nLiMmTDh6JQhpPwwnIj0Xu7WP96jeqYAxZEV6SIaoAAGGkbF0tyAI5gjlLePHu/XptMesCHNddg74R2pKtackIo+rrEH5ruFnyIcl4D12IcCMPjZA1DhmqFrSfsSz38=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +VEpuxyuaXd26TvpKYS0bEF6ptJVVo37Y2S8/S8XvkuBvxH0+ILjtgA7KlNmTAVGeKQb707lgFXW/7ZAN2ecsGp0s4e0djA6H0JO7aBzLhNENEEPhC2nXxVqW8mYYx3uwQ0iNypJlQ63eyu0sqzyrE1JOfjCnCEE39/Ber5qWoHwrw699qSF/aYaYd2eoA4pCJUwXTMmnHDtTEDepRvY0mFnlSR99XQKA41eqierse9EWkHJDCtrvtKgJNbk6SFnRplv3wnDvAP26LohQ/ryIIOwcL/dklJrMmSgrR+8D7LecFGsgeHr1juHNYfFWtIN6VY74R1SrNWAG0AUjiiex/rypo6CvSCXmlH2OxUDRJlol41QDgJ5McwEd2Z26ZnR2eLbW66pzi15AXi3LIyuxcTG2o9Y/buiienLZODPR31ntTQ22f/e9FeGmHdDH0BO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 05:17:42.6821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a76d06cc-45ac-4b15-2049-08debd419c60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6307
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

EnergyAccumulator is unsupported on SMU 14.0.2, mark it invalid.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 6b5aa4e514fd..e8c6bed781b3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2153,7 +2153,6 @@ static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu_context *smu,
 					       metrics->Vcn1ActivityPercentage);
 
 	gpu_metrics->average_socket_power = metrics->AverageSocketPower;
-	gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
 
 	if (metrics->AverageGfxActivity <= SMU_14_0_2_BUSY_THRESHOLD)
 		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPostDs;
-- 
2.47.3

