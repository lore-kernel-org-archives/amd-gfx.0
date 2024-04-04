Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06753CD1284
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Apr 2024 06:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFC2510E2FB;
	Thu,  4 Apr 2024 06:53:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3YwMCvGO";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7478910E2FB
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Apr 2024 06:53:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPCOS9SQu7F6Zw8tNt+suVn/AEeL7TkWH8MQn+ZwSH7y4MdInpk+A4d+D1wvA82ZishUbBl1CI8Eg8Tmg9RAO8oZd76Qdsy2low3fZaMpZsgcKEL7hkizc0JL4eARonzGrRCfXlKIdt6NdDodP9OwdunQsVCyxbFz8uFa5U3qFlGyzTKJeXGT2PIAoLoECmqyFDGXPTkGiQ4vjbFHljXqZvai6VnRV3R3FB3DgTXcNzSurRpWJ/JGj+aW6x05kO65pXoIQsgzHNZoXuaNrNX9vQ11cOe7uzDO8obsWrAuNpr/v8ghRFi/WqVQDw8YIbEjIidw0ptaG0+tGxm0SIWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7aibOAHDhlVrce8J5a8N30UbiB6B5+OykhbMRE7phM=;
 b=kSZsAcgqB99i9lUl061smdE1X0IrZoGj93tODOQC5jPSEROyQJJZwcTqjr1UTaYZqHUHEZqGuhx3nr2wwTpK9Y+B1TY9mpnRXMXJyXiwQOuB8ukbGC5CKelVp9C7I9H9o2e425ba8CpNCLDfbCApEbafxceZoaakLBF7dfNod8EBQi/23Zt54tnpXcsbDf5KDrZnvwoTfCYzqhN+Cb+kUQ0xWn39GEbWXa/mQwom0fQdPdNNy+hbdTB6qR+0IXuAUT9CRipr7Ysw/17J6ImULzb9FeOq3EvwGym2M4+ayXWcimNP1tvoDvdi+gtoCVMS19DLaYHWj2lBoUN+rgWmDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7aibOAHDhlVrce8J5a8N30UbiB6B5+OykhbMRE7phM=;
 b=3YwMCvGOhI1YsM0j3jRh5kitIYnAkX43S8cSwuPNUt+5+u4rbLwJMQkIVQTk237HwlmQaaj0YbtAxIAZOVTDZVYx3gleas5Uw8KBp73aUE4q5LDEWSGGanMLAgxpS2IBXTEw9fPmVxWBpK026Z62t+AAetZgjAWVm61W6CBQcGA=
Received: from BN0PR07CA0023.namprd07.prod.outlook.com (2603:10b6:408:141::6)
 by SA1PR12MB8093.namprd12.prod.outlook.com (2603:10b6:806:335::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 06:53:15 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::20) by BN0PR07CA0023.outlook.office365.com
 (2603:10b6:408:141::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Thu, 4 Apr 2024 06:53:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 06:53:14 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Apr
 2024 01:53:12 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amd/pm: Allow setting soft max frequency in VF
Date: Thu, 4 Apr 2024 12:22:56 +0530
Message-ID: <20240404065256.47765-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|SA1PR12MB8093:EE_
X-MS-Office365-Filtering-Correlation-Id: ca566ffb-af21-4c35-a9a5-08dc5473e6ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j9gJTavyRXHF6Cd3bAnT6dGTNUDuN7J04oJzEhITQSxwT9SiKJsZbfLJkqWPae14ObLWaZNk541fnc8alVqJBdp29LM3iipxRWejK1NsicS3w8u974u73TkBGgvAhYONZoLFESpXcLWfJRBh1nnEaGL8aTx0VxNaaa0Cv4r3lW8Uc9/FmLumpMTpCAJil1z2sWgKgVRuPrSW04b8Yf8rbT8irh1afb5rDMh7+dNiCuG3ZFNAVhTl1uYljnXjTpAgAf8TdMpykV43GBJsCui7dKV65uVrSIzkXJ6aq/r+sKsjuLbvItu0f3bNWMdzqHgEpqaQAxYNgnQcoorF3R/ca1EcEMlSxAFPq+DmkKG79aeb0hm1ymNv/c5xmiiHEOaAbx393mYHhAi6wNiAwPIFalostLVsnR9fj+83b/pgfYjbN8GhOCuyW1Fgp5IkV/bNqgYMdOeZIS6EnKKrYhdjkNv210nPPA8VgZIqY3cBaUPkHSpC8xbgJXAwSEOXWv6MfpjXnAQ3uqB99qdzFm3u8E/eBm0LH/dbaw9j7/YPAyPDRvoYxb3GNDKCb4YkgD0i1d25p9U1bIA4TKmkQ5qlspiu4QBQbcyFTtvVN/MU/bzEmlDX3LUArSw9EWFCkdksZMHik2INh9S8LbR1uaqWAhjJ2t00iPr2N+8yKF+503X0VH1wh14XgJRLHm0BAyeL8WaAfZpTxUrqc7TBL0oRWk/9itAyOgMRYOcea3HEgSS63zirJT9I7b8FNd4j4f9l
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 06:53:14.9691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca566ffb-af21-4c35-a9a5-08dc5473e6ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8093
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

Setting soft max frequency for MCLK is allowed in 1VF mode in SMUv13.0.6
SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index a09c89b3db96..d6d5be26e222 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -138,7 +138,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(SetToolsDramAddrHigh,		     PPSMC_MSG_SetToolsDramAddrHigh,		0),
 	MSG_MAP(SetToolsDramAddrLow,		     PPSMC_MSG_SetToolsDramAddrLow,		0),
 	MSG_MAP(SetSoftMinByFreq,		     PPSMC_MSG_SetSoftMinByFreq,		0),
-	MSG_MAP(SetSoftMaxByFreq,		     PPSMC_MSG_SetSoftMaxByFreq,		0),
+	MSG_MAP(SetSoftMaxByFreq,		     PPSMC_MSG_SetSoftMaxByFreq,		1),
 	MSG_MAP(GetMinDpmFreq,			     PPSMC_MSG_GetMinDpmFreq,			1),
 	MSG_MAP(GetMaxDpmFreq,			     PPSMC_MSG_GetMaxDpmFreq,			1),
 	MSG_MAP(GetDpmFreqByIndex,		     PPSMC_MSG_GetDpmFreqByIndex,		1),
@@ -1676,6 +1676,11 @@ static int smu_v13_0_6_set_soft_freq_limited_range(struct smu_context *smu,
 		if (clk_type == SMU_UCLK) {
 			if (max == pstate_table->uclk_pstate.curr.max)
 				return 0;
+			/* For VF, only allowed in FW versions 85.102 or greater */
+			if (amdgpu_sriov_vf(adev) &&
+			    ((smu->smc_fw_version < 0x556600) ||
+			     (adev->flags & AMD_IS_APU)))
+				return -EOPNOTSUPP;
 			/* Only max clock limiting is allowed for UCLK */
 			ret = smu_v13_0_set_soft_freq_limited_range(
 				smu, SMU_UCLK, 0, max);
-- 
2.25.1

