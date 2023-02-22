Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105B2C64EC4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 04:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6428F10E1A3;
	Wed, 22 Feb 2023 04:34:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E71A010E1A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 04:34:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Js98bGHXHSUPssDm9os8unZ2vqAIIjDFyFDnbvZirVUjiiJT3qyHlXJj/Q9GSnYPhKUxFNWvEssRLfqIghU3wYthhqU7ANaQTe1RDQ9NQccwPBPSMSGJeJAynSctcF+xWA3M1DSdc7hqTHGs6S54NKmJvVwUczRaXR1rnSPcwkRlIAiJ+Bmn9GDR8CxFASIqrNV9ha2rGiLzTquRPJlZ6cImpihbFKsr242iW2h/rIO3o2pTxrEnmyGTfg3LuxAfYCywpKHeMOY/j6tTUtj+TvBThxRQegje2mWTZGNjdAAnO2fvou6fqbLG4zXVQIfJ24jhPb3D/El3Jlw8ifRyyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZAV85cF71GcAhshwXQG3622pSFzw3hY6HOvqBOWO18=;
 b=hZZbGjcDWEryssktyau4TGsVNYtltG1zyvIE1LFoc6zsRXSD7KD8XnTtqIa0ebYaE0NJgo36Z1rdX162cMtgoS0NIlFd3jqfkPOY6b0TAXUfXr2XUq8nfOq+oXbU0aNPPYbl2YEfBwl5AQbVj4ghleDopdTCYZsohFH5a8Z2HuKpUhSiAOqkyn/PHSp1Icm/q8D1qxcNE4ZrK8folS+KqpkYH4W9J0u7ShzVg9g8Vf5QS+D9e3aRa5zJJpXvdxKDsCtEOqrpwrj+4TmUogU4OHGZpwivi2EO4p5STNWghLnYAz/Thc7ct7FYFOfTOd8lr/TvrdYBHYci7F3C+1ySsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZAV85cF71GcAhshwXQG3622pSFzw3hY6HOvqBOWO18=;
 b=DK8qZb0wvhly0MaJi2k9GlZkiXitDZEwisSDF2lLljFIogyq3YF+aaEprWpxFip6byxBesoqDKek6NfV81/1uOPq03FG4VSzw63NbZtmyXB1RYVQnIoibSJWaZwNTaE6J67Lh3IOLPvxzlS9NhZIIRrWDBU8tFn0mp1cqhp5Jw8=
Received: from DS7PR05CA0084.namprd05.prod.outlook.com (2603:10b6:8:57::25) by
 PH0PR12MB8100.namprd12.prod.outlook.com (2603:10b6:510:29b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.21; Wed, 22 Feb 2023 04:34:26 +0000
Received: from DS1PEPF0000B079.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::b7) by DS7PR05CA0084.outlook.office365.com
 (2603:10b6:8:57::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.18 via Frontend
 Transport; Wed, 22 Feb 2023 04:34:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B079.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.14 via Frontend Transport; Wed, 22 Feb 2023 04:34:26 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Feb
 2023 22:34:24 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Add convert_error_address function for umc
 v8_10
Date: Wed, 22 Feb 2023 12:34:09 +0800
Message-ID: <20230222043409.25411-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B079:EE_|PH0PR12MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d069cf-4bb9-4ea0-9bb2-08db148e1446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XVt66M9B+c52KtWGzWuiXGUyeHO/n81v1d0NsDJT1KP8dLZovdWxuk+V+hXRuxxN8gHPDbYSBRp3t4kCJVh4XhnQ2CfmGAc+qZCuQfrhh6NXLZ4z/ucmihcrh+jQhmZL2wvcVH4mmi72Qxv5h7DZeAMspYuYGDns673XuAyJW4f0FGph0PvOxJ4SCFHDVk20cKqzTZdXFAkcQd/xnUUr/SCAnsuROCpqI/TVibunQt89zmLqYqiNEA9vy8u85a2QIh7JA8RMh5TOnkpwAtCnBalmttVu93cl8LlDO1wPbYFFZDqVY3/rIKJcG4jFrACIZlF3iF1o8/pv2mZJYGv2HOJovzIxY+71c+cJwKEf04qMyvT0uVBShufx9tBI2mT+6R9UZwr0wk5/GQbxFfrqhltCB8Q6pcP893rFWd3VDpjHGR4beUidoUaD+VOtwJ1YEhjBkeIbKEOLZm34LRzt4yw/dCdryweAPxFTeWZC7PDUMa6hffIKqwGRyClg/lxwPTfntgdyedMAzNzBJhR6SbApY0OyF34STfwN2MBdy6LTg60qgJ9jM+ZjAdfdg5pMTbRWQIOsZJs0qRPL3FvoU7+2ESn5qhveCUeaRM6NE4e5FMszoxY2bLjLsMrWWJl8IHZp94i6OTrtl684ppZHWQUnHVbfTqiIPIFk+8FKT8Ygyym/GocWc6/Gek0h3eYD4wQKCMoJVEaDJTzaqxm9c97ALrMzNcRv12LLbIWNhxQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(8936002)(41300700001)(2906002)(44832011)(4326008)(6916009)(8676002)(70586007)(70206006)(5660300002)(316002)(478600001)(36756003)(186003)(40460700003)(1076003)(6666004)(26005)(2616005)(16526019)(47076005)(7696005)(426003)(36860700001)(336012)(40480700001)(83380400001)(81166007)(356005)(86362001)(82310400005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 04:34:26.0359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d069cf-4bb9-4ea0-9bb2-08db148e1446
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B079.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8100
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add convert_error_address for umc v8_10.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v8_10.c | 73 +++++++++++++++-----------
 1 file changed, 42 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
index da394bc06bbaaf..293ba39c8a2fda 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
@@ -209,6 +209,45 @@ static int umc_v8_10_swizzle_mode_na_to_pa(struct amdgpu_device *adev,
 	return 0;
 }
 
+void umc_v8_10_convert_error_address(struct amdgpu_device *adev,
+				    struct ras_err_data *err_data, uint64_t err_addr,
+				    uint32_t ch_inst, uint32_t umc_inst,
+				    uint32_t node_inst, uint64_t mc_umc_status)
+{
+	uint64_t na_err_addr_base;
+	uint64_t na_err_addr, retired_page_addr;
+	uint32_t channel_index, addr_lsb, col = 0;
+	int ret = 0;
+
+	channel_index =
+		adev->umc.channel_idx_tbl[node_inst * adev->umc.umc_inst_num *
+					adev->umc.channel_inst_num +
+					umc_inst * adev->umc.channel_inst_num +
+					ch_inst];
+
+	/* the lowest lsb bits should be ignored */
+	addr_lsb = REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, AddrLsb);
+	err_addr &= ~((0x1ULL << addr_lsb) - 1);
+	na_err_addr_base = err_addr & ~(0x3ULL << UMC_V8_10_NA_C5_BIT);
+
+	/* loop for all possibilities of [C6 C5] in normal address. */
+	for (col = 0; col < UMC_V8_10_NA_COL_2BITS_POWER_OF_2_NUM; col++) {
+		na_err_addr = na_err_addr_base | (col << UMC_V8_10_NA_C5_BIT);
+
+		/* Mapping normal error address to retired soc physical address. */
+		ret = umc_v8_10_swizzle_mode_na_to_pa(adev, channel_index,
+						na_err_addr, &retired_page_addr);
+		if (ret) {
+			dev_err(adev->dev, "Failed to map pa from umc na.\n");
+			break;
+		}
+		dev_info(adev->dev, "Error Address(PA): 0x%llx\n",
+			retired_page_addr);
+		amdgpu_umc_fill_error_record(err_data, na_err_addr,
+				retired_page_addr, channel_index, umc_inst);
+	}
+}
+
 static void umc_v8_10_query_error_address(struct amdgpu_device *adev,
 					 struct ras_err_data *err_data,
 					 uint32_t umc_reg_offset,
@@ -218,10 +257,7 @@ static void umc_v8_10_query_error_address(struct amdgpu_device *adev,
 {
 	uint64_t mc_umc_status_addr;
 	uint64_t mc_umc_status, err_addr;
-	uint64_t mc_umc_addrt0, na_err_addr_base;
-	uint64_t na_err_addr, retired_page_addr;
-	uint32_t channel_index, addr_lsb, col = 0;
-	int ret = 0;
+	uint64_t mc_umc_addrt0;
 
 	mc_umc_status_addr =
 		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
@@ -236,12 +272,6 @@ static void umc_v8_10_query_error_address(struct amdgpu_device *adev,
 		return;
 	}
 
-	channel_index =
-		adev->umc.channel_idx_tbl[node_inst * adev->umc.umc_inst_num *
-					adev->umc.channel_inst_num +
-					umc_inst * adev->umc.channel_inst_num +
-					ch_inst];
-
 	/* calculate error address if ue error is detected */
 	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
 	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, AddrV) == 1 &&
@@ -251,27 +281,8 @@ static void umc_v8_10_query_error_address(struct amdgpu_device *adev,
 		err_addr = RREG64_PCIE((mc_umc_addrt0 + umc_reg_offset) * 4);
 		err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
 
-		/* the lowest lsb bits should be ignored */
-		addr_lsb = REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, AddrLsb);
-		err_addr &= ~((0x1ULL << addr_lsb) - 1);
-		na_err_addr_base = err_addr & ~(0x3ULL << UMC_V8_10_NA_C5_BIT);
-
-		/* loop for all possibilities of [C6 C5] in normal address. */
-		for (col = 0; col < UMC_V8_10_NA_COL_2BITS_POWER_OF_2_NUM; col++) {
-			na_err_addr = na_err_addr_base | (col << UMC_V8_10_NA_C5_BIT);
-
-			/* Mapping normal error address to retired soc physical address. */
-			ret = umc_v8_10_swizzle_mode_na_to_pa(adev, channel_index,
-							na_err_addr, &retired_page_addr);
-			if (ret) {
-				dev_err(adev->dev, "Failed to map pa from umc na.\n");
-				break;
-			}
-			dev_info(adev->dev, "Error Address(PA): 0x%llx\n",
-				retired_page_addr);
-			amdgpu_umc_fill_error_record(err_data, na_err_addr,
-					retired_page_addr, channel_index, umc_inst);
-		}
+		umc_v8_10_convert_error_address(adev, err_data, err_addr,
+					ch_inst, umc_inst, node_inst, mc_umc_status);
 	}
 
 	/* clear umc status */
-- 
2.17.1

