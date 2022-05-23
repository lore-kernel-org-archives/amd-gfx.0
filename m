Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D93FC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 23 May 2022 08:17:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97BC210EDD6;
	Mon, 23 May 2022 08:17:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CDE610EDD6
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 May 2022 08:17:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+xwm+gMGtOmdrxCPjGdugjzM9TDgopeUqNyf92RR5etkDa1XjDvMDLkA4zafXfigNAeN88CLgjxiegAVIVO8RJkg9IjcNRh2sbmgib9T/lkhkdLW26v5u/x+WcP8YsflUvGl5iJ61qF92Y0WKdXy2i6arbm+o/YcuTCqO0P4zJSDjsbzStw5ZIQ8jqiWMy22V7Mpw2ty8pxr2lM9TKKuej7Tn+cLoNrne0AA53KCoYZAEtWzNs75wU8PBUuL4sZ1KdmafCM3v+6TCHBFDLSIuuUOc4u/hk7CJY41JestHE+3w7c8bHG7Lb2c4oQEbo+v7UyUivtDg4UipcWkSDIiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdntuihrsPmmWT6Te+32UBsTawsv42D0pmbnKl054ig=;
 b=FI/svClp7IsEDnXUXJHtYFTF/Cuhx8vxdtO8BxrLwbr5OZne5eRrGCeEBj2MCJOWzT0B1efm3C2n7dd6SrKlGvtPrBDix3QsUSm6XbneTWUOadae/RBMHjk/eRYUY3JylXvxYWWB3EejAEL5lX3q7o+eB4Jgu0adGbf+6uwz1OfV+5E/pswmKq/7qq4C4pP+bzvwHxk8bbYD3WF0sPFEsy4OYRRue2zFZbI5yl/0NKbA9ZVfcyst1eNZrIoFQoDYvhVbkUw3cMPO5pZAOOo3AqJGzsqCAVmLy6AEut9jcbMUh/cJrdkxnIn7ex/0Hp8XkQHiKwYwezethrmrirHopg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdntuihrsPmmWT6Te+32UBsTawsv42D0pmbnKl054ig=;
 b=Dz/kKZrFh0aB6INVszVje+TPpYlsSLt62GGtvbydiU+aZZ4f7W8UpADeq2qWwTCNDkvdg/3VNtCPF0aj4wyqxFCHQbnex0HPxVWnI/hRPZ4FSYnQTd37g2FDby4xRFSal3G2yVIK6bcYWkKMl00dMP29iBLaMurzrWIqpG1W9Ok=
Received: from BN6PR11CA0009.namprd11.prod.outlook.com (2603:10b6:405:2::19)
 by BY5PR12MB5525.namprd12.prod.outlook.com (2603:10b6:a03:1df::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Mon, 23 May
 2022 08:17:09 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::97) by BN6PR11CA0009.outlook.office365.com
 (2603:10b6:405:2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.21 via Frontend
 Transport; Mon, 23 May 2022 08:17:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 08:17:09 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 23 May
 2022 03:17:08 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 23 May
 2022 01:17:08 -0700
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 23 May 2022 03:17:06 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <tao.zhou1@amd.com>, <evan.quan@amd.com>, <lijo.lazar@amd.com>
Subject: [PATCH Review 2/2] drm/amdgpu: print umc correctable error address
Date: Mon, 23 May 2022 16:17:01 +0800
Message-ID: <20220523081701.32456-2-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220523081701.32456-1-Stanley.Yang@amd.com>
References: <20220523081701.32456-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32d75d8b-63f8-4963-d55e-08da3c94a1b7
X-MS-TrafficTypeDiagnostic: BY5PR12MB5525:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB5525DE9EC96F4D28876FEF399AD49@BY5PR12MB5525.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XHWatIyuz8FsZSWu/Efq2gj9bg31joA7dT+uEoAxgJyfZpiBGXQh4jYwLcIIi7mUJYZAwkOUAfuGh3MnEIlDiTJ1rI1ImWosUnnY8ynyPpCGHU8tQ/d1d+dm+NG96pjur8oqEY+0Z+HJMikRp8UN+EsS6bFaJHeNPgXMyz6ZL7GM0J3MH0eHT+qVBUeer+G7ttY/FFTURdqDR1Sc07FvEvMHigO5Dl8cCcBGnUQEATaTCnJ8buBcmJ52kuu9bQce3fN9X5Xl4I7fhr+dJySHHmwfkLELE2sQJtkt4AQcL/WFJJ2WRW0JjePA/zPeCZHXlzguY0q+bVTpDr6D212hPoYpPXHbTu7sqRy8TFWGYLZUz/JwjX1Ikpp++EHzzrl+YwC2CluI7pprpatcDVvfHZQnlEsdK502Ff+r+lY63H24K8BIALofOP+i5HN8dQca6uIM374eHe/xLNKh920UJ91dm8u46dxseSsURBuzmUQ+MK0JcxZEVevSaBCAp2+tGHV3q9rCXvC79DQJ2u99eHqnmFK8A6YZFHWqtdhhRsaqWXdoEetRdlHcPrsLOEb9nDlELf/xvgqHvZL8ysRR+AxxxxM2ULSSenDgibWH9mb9DY3ugV94jCyqhXeBVYk3qa/YW25g8B7dC/W0t1tgTvPKfst/qau6DWem/0r3u1Lix/zFFlRfRyuEuGhLtZhRH1RoGL+A2c4fovzNVULhdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(356005)(1076003)(82310400005)(81166007)(36756003)(2906002)(6666004)(47076005)(83380400001)(36860700001)(2616005)(508600001)(70206006)(26005)(40460700003)(86362001)(316002)(7696005)(5660300002)(4326008)(8676002)(70586007)(336012)(6636002)(186003)(110136005)(426003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 08:17:09.1727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d75d8b-63f8-4963-d55e-08da3c94a1b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5525
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

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  5 ++
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c         | 55 ++++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  2 +
 3 files changed, 60 insertions(+), 2 deletions(-)

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
index 606892dbea1c..47bd39e52e9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -119,6 +119,27 @@ static void umc_v6_7_ecc_info_query_correctable_error_count(struct amdgpu_device
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
+			/* clear [C4 C3 C2] in soc physical address */
+			soc_pa &= ~(0x7ULL << UMC_V6_7_PA_C2_BIT);
+
+			dev_info(adev->dev, "Error Address(PA): 0x%llx\n", soc_pa);
+		}
 	}
 }
 
@@ -251,7 +272,9 @@ static void umc_v6_7_ecc_info_query_ras_error_address(struct amdgpu_device *adev
 
 static void umc_v6_7_query_correctable_error_count(struct amdgpu_device *adev,
 						   uint32_t umc_reg_offset,
-						   unsigned long *error_count)
+						   unsigned long *error_count,
+						   uint32_t ch_inst,
+						   uint32_t umc_inst)
 {
 	uint32_t ecc_err_cnt_sel, ecc_err_cnt_sel_addr;
 	uint32_t ecc_err_cnt, ecc_err_cnt_addr;
@@ -295,6 +318,33 @@ static void umc_v6_7_query_correctable_error_count(struct amdgpu_device *adev,
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
 
@@ -395,7 +445,8 @@ static void umc_v6_7_query_ras_error_count(struct amdgpu_device *adev,
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
index e58df9490cec..e182088b4ac8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1908,6 +1908,8 @@ static ssize_t aldebaran_get_ecc_info(struct smu_context *smu,
 				ecc_table_v2->EccInfo[i].mca_umc_addr;
 			ecc_info_per_channel->mca_ceumc_addr =
 				ecc_table_v2->EccInfo[i].mca_ceumc_addr;
+			if (!smu->adev->record_ce_addr_supported)
+				smu->adev->record_ce_addr_supported =1;
 		}
 	}
 
-- 
2.17.1

