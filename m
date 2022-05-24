Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58281C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 14:31:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5E7310E21D;
	Tue, 24 May 2022 14:31:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7189210E1C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 14:31:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsadjxzONvj2fbhmEPebo5eDX8k1pFu52jqOvue3OK/2BbzV1zd6GSvULwTL2olWp8nfmFipGDGLcY5NiPctCHYY4bWSgWI3LfYJLiCS/29RRW0gDlszBbP4EN/pviXTFyJnLuKGfmYh1ThFTjJocmk7FEfTPSDoeX5mYRTMIybExsqT4jWKuzV51wvf3cpfthWoCxLUj+K0x7WHHuDyArAL7cRVl9g4HafVnAiYk+8o49t8jaJlCi4GVmn1ImQU8CiIUDDz8Szo2DT2UoVXZWMA7XGQGEMmSPqLi2KillMNVdg+99BGiz7aCreOovCRz1sZ1/wgusE8D91DCxTucA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PvzNR7hb6JMqm4U9EyDcnSuPp02U75LUqTMuKCIX2U=;
 b=dSxADhMeAU3a9+ZVKCNj3nkmwGLkAfuMb1cl2JdU0GdeA44noZaYpCY7riQW9LB+inCyDCQGG1m72o/jAge8/SjUFZ/3OPKM+Me/ic4KfpUBD56xT+Ym0fHOOCHq45zUAV1hdyl/3ibVthpQYDqAeJJPA3fL3DJ37QuTLX+8awP/BwyEGrtGhBjZjMbnsHqoi5u41qkjGLGIu4LQ+VL6c7ZbrW5G88BMWQP9TrHbd/ZP43DXOAOMjG0n1hUloMJBbdwl55xs026sWEXpYLOjrbYZMaosqasBWrvM0+WXzWw2LfcD+rCe28l64l4LRrZJxu7R13rW4u/eanbO+wlOQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PvzNR7hb6JMqm4U9EyDcnSuPp02U75LUqTMuKCIX2U=;
 b=OpXlzkrzNsE/hdzHzMmHsXMb72oOZiZ+QdVxcx1Neq6hmT7+4RDSFvuNZ23Sf9L4Jsd4fWkqwGGUoz3YocaNFSDEfH6j4ul8mpcDHemC1x7cuQrsfjQim88xjybu2nt1dg8J/O0MF9ppCRGBKxTjn9+fHx2DZRpAcSSTvelt16g=
Received: from DM6PR11CA0012.namprd11.prod.outlook.com (2603:10b6:5:190::25)
 by BN6PR12MB1170.namprd12.prod.outlook.com (2603:10b6:404:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Tue, 24 May
 2022 14:31:03 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::93) by DM6PR11CA0012.outlook.office365.com
 (2603:10b6:5:190::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16 via Frontend
 Transport; Tue, 24 May 2022 14:31:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 14:31:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 24 May
 2022 09:31:01 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 24 May 2022 09:30:59 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <tao.zhou1@amd.com>, <evan.quan@amd.com>, <lijo.lazar@amd.com>
Subject: [PATCH Review v2 2/2] drm/amdgpu: print umc correctable error address
Date: Tue, 24 May 2022 22:30:55 +0800
Message-ID: <20220524143055.11723-2-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220524143055.11723-1-Stanley.Yang@amd.com>
References: <20220524143055.11723-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afd552ec-54e1-454b-91ae-08da3d9207f5
X-MS-TrafficTypeDiagnostic: BN6PR12MB1170:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1170E5F16D4E22275481F0FB9AD79@BN6PR12MB1170.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AooQ1yQ0kQo1eKSL1SlhNJOnCQZibupo5u2tYkm5anZJhP6+zLoHR0Nm2AYdq5jzWko4OAdffH5HEzRHw7IRXc/0edcvoV+/zLMiP9TrCiHII9kofgxRhfMAzEwu5TRwwLEUeTlAGgA8BiJ8kCzvWUbwfVts+Nx1fhj2e/Zl99Vw3H/lwn2L+ZJaYdzLyMW8IFcHWVzie1nMxuhSmaGXrtt9Ca83tD5a349cAoyIvWnYUDzEX1h2t8o/v8tsGlPDQ493Wdj9NlRoOHCkwW5Ark47kGDDRGEFvoWWJvwjw5xwAZOFrz93S3wIK0NgnrFQXQyC6cv3Y2BEfynTZ88nkODg1KS3FNrIz6Tqj76ishFwF/d/Zdr1Wo+6+RIdUtiXbLO5oWyo/F8L/e91XGD7r0kdq1AxA7w75Wo83AM6XWwln2AlVWonWuy+dbXD0bZvouAa2kqT/EP5xe6MwrGInpaqp6eJ7M57talKO0CNxjuFD8+NzMkCEVasE/x2xoHy1Tom2nQsmfFoKiMXY1OA6D//EnJqj6Eex2uhalkTRtnx8du/7yd61iK3n4lJNfWv07orbkhVEd5S0fS+id28btsolP3ODsmR2lL0KXytKxZtPssPwP5MC6gA+mpREVh2tMYlbrAp3/nz9/g6n0bDJFPuL+PFZAKRmlJCTtbSrEDGkOQoL7HjeomqyhSg1f3CymxS2y2S5qcuwVHCTJHxTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(81166007)(356005)(336012)(70206006)(5660300002)(8936002)(83380400001)(7696005)(86362001)(26005)(6666004)(40460700003)(2616005)(508600001)(1076003)(4326008)(426003)(186003)(70586007)(2906002)(6636002)(316002)(8676002)(47076005)(36756003)(36860700001)(110136005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 14:31:03.2681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afd552ec-54e1-454b-91ae-08da3d9207f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1170
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Changed from V1:
	remove unnecessary same row physical address calculation

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  5 ++
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c         | 52 ++++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  1 +
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3f23f9ad3249..985b8cddb5a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1108,6 +1108,11 @@ struct amdgpu_device {
 
 	bool                            scpm_enabled;
 	uint32_t                        scpm_status;
+
+	/* Determine smu ecctable whether support
+	 * record correctable error address
+	 */
+	int record_ce_addr_supported;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index 606892dbea1c..91bdc5e048c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -119,6 +119,24 @@ static void umc_v6_7_ecc_info_query_correctable_error_count(struct amdgpu_device
 		*error_count += 1;
 
 		umc_v6_7_query_error_status_helper(adev, mc_umc_status, umc_reg_offset);
+
+		if (adev->record_ce_addr_supported)	{
+			uint64_t err_addr, soc_pa;
+			uint32_t channel_index =
+				adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
+
+			err_addr = ras->umc_ecc.ecc[eccinfo_table_idx].mca_ceumc_addr;
+			err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
+			/* translate umc channel address to soc pa, 3 parts are included */
+			soc_pa = ADDR_OF_8KB_BLOCK(err_addr) |
+					ADDR_OF_256B_BLOCK(channel_index) |
+					OFFSET_IN_256B_BLOCK(err_addr);
+
+			/* The umc channel bits are not original values, they are hashed */
+			SET_CHANNEL_HASH(channel_index, soc_pa);
+
+			dev_info(adev->dev, "Error Address(PA): 0x%llx\n", soc_pa);
+		}
 	}
 }
 
@@ -251,7 +269,9 @@ static void umc_v6_7_ecc_info_query_ras_error_address(struct amdgpu_device *adev
 
 static void umc_v6_7_query_correctable_error_count(struct amdgpu_device *adev,
 						   uint32_t umc_reg_offset,
-						   unsigned long *error_count)
+						   unsigned long *error_count,
+						   uint32_t ch_inst,
+						   uint32_t umc_inst)
 {
 	uint32_t ecc_err_cnt_sel, ecc_err_cnt_sel_addr;
 	uint32_t ecc_err_cnt, ecc_err_cnt_addr;
@@ -295,6 +315,33 @@ static void umc_v6_7_query_correctable_error_count(struct amdgpu_device *adev,
 		*error_count += 1;
 
 		umc_v6_7_query_error_status_helper(adev, mc_umc_status, umc_reg_offset);
+
+		{
+			uint64_t err_addr, soc_pa;
+			uint32_t mc_umc_addrt0;
+			uint32_t channel_index;
+
+			mc_umc_addrt0 =
+				SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_ADDRT0);
+
+			channel_index =
+				adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
+
+			err_addr = RREG64_PCIE((mc_umc_addrt0 + umc_reg_offset) * 4);
+			err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
+
+			/* translate umc channel address to soc pa, 3 parts are included */
+			soc_pa = ADDR_OF_8KB_BLOCK(err_addr) |
+					ADDR_OF_256B_BLOCK(channel_index) |
+					OFFSET_IN_256B_BLOCK(err_addr);
+
+			/* The umc channel bits are not original values, they are hashed */
+			SET_CHANNEL_HASH(channel_index, soc_pa);
+
+			/* clear [C4 C3 C2] in soc physical address */
+			soc_pa &= ~(0x7ULL << UMC_V6_7_PA_C2_BIT);
+			dev_info(adev->dev, "Error Address(PA): 0x%llx\n", soc_pa);
+		}
 	}
 }
 
@@ -395,7 +442,8 @@ static void umc_v6_7_query_ras_error_count(struct amdgpu_device *adev,
 							 ch_inst);
 		umc_v6_7_query_correctable_error_count(adev,
 						       umc_reg_offset,
-						       &(err_data->ce_count));
+						       &(err_data->ce_count),
+						       ch_inst, umc_inst);
 		umc_v6_7_querry_uncorrectable_error_count(adev,
 							  umc_reg_offset,
 							  &(err_data->ue_count));
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 9cdfeea58085..e41a5b6fc64b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1882,6 +1882,7 @@ static ssize_t aldebaran_get_ecc_info(struct smu_context *smu,
 				ecc_table->EccInfo_V2[i].mca_umc_addr;
 			ecc_info_per_channel->mca_ceumc_addr =
 				ecc_table->EccInfo_V2[i].mca_ceumc_addr;
+			smu->adev->record_ce_addr_supported =1;
 		}
 	}
 
-- 
2.17.1

