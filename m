Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4A3C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 06:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10F6011213C;
	Wed, 25 May 2022 06:11:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90DCC11213C
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 06:11:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6++YcHvrWxXCpWZHpaJbgJqhVuw+Tw+yqrZte3zghfPWZ6vNa555liiQ9Vrl3/OuCrc0PaHfFXE511Atts4MSqwYPmw3YPV+31mKTLQvy74MRcaG30yJYgMt0pUTv0zCgqc6G78FlJ5IZMg3gSnFklrHv7/+g3bSqYkjyTqAE92auG4JPYMJnVKAJ3ouPMpdrTvVpIVXijF/64U1PW0TWFru6NmI/SaM5ZP8SK6wzcyLnkHNShWenlGB+sVxSRbMQYJ35Fo2PHb/gKo5z9giCUt5DG3zsXztlE2GD6PTRkVEFUnVthgI/qtdzb/ErWVgEiVmfcsEY3z/YKAAPc9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6vBF/ZQLn/3A/W+9LE+Ar/XSr3hYUw82EVtyALFOWc=;
 b=j1++/T3tl2UwZrH6GAbZoLR82J4j27ceFTjMQT3LPnqnYcQ0IeRz+QdeJQQZoSowY0CcfY3XWzdqrx4OWn6bmZdhYlshEFyAX4iHqv7TXbNpMfGgLzUtNnrTIWH5BvgiTSmIb/xh6A/zZALdpxwbBAwoYnIdTuh5qKWFI2+N/ZBouF4QxXstXcDqazmdaXD8Vq1g6WOIxJV81UPIB1e6HRlmkYEx0XrnMAq6PF+uxRu2jIMMTQgduBqsrfWlTs1WxrjTy37jwr0mHUudL8TYsjiFsI6VLXvTtIISNDsOD/MJzt/Fwb+WwtITAYsmnOVbDSJJAq7SpF9VcPtIETWoYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6vBF/ZQLn/3A/W+9LE+Ar/XSr3hYUw82EVtyALFOWc=;
 b=b4sQzGGRF1Ci8/45F+dd5z11B2eNnM1qaLL3avsXLa94mGefDbE+rhHP2wh6AlEQrnuN52DBQJXgHQqmkQiA9WptwSYq7bs7YD4jJCtjRxeOgWTAO+G990xyex33nmbw+gxpbx9oOZ27lQTZ5wxDN4BLDWKXVCMLEn9Xnr0gmpU=
Received: from DM5PR2001CA0023.namprd20.prod.outlook.com (2603:10b6:4:16::33)
 by MN2PR12MB2959.namprd12.prod.outlook.com (2603:10b6:208:ae::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 25 May
 2022 06:10:59 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::c8) by DM5PR2001CA0023.outlook.office365.com
 (2603:10b6:4:16::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 06:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 06:10:58 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 01:10:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 24 May
 2022 23:10:57 -0700
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 25 May 2022 01:10:55 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <tao.zhou1@amd.com>, <evan.quan@amd.com>, <lijo.lazar@amd.com>
Subject: [PATCH Review v3 2/2] drm/amdgpu: print umc correctable error address
Date: Wed, 25 May 2022 14:10:47 +0800
Message-ID: <20220525061047.26529-2-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220525061047.26529-1-Stanley.Yang@amd.com>
References: <20220525061047.26529-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd698b45-401a-435c-9465-08da3e155630
X-MS-TrafficTypeDiagnostic: MN2PR12MB2959:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2959452911BD6A5EE30473A59AD69@MN2PR12MB2959.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NuXAWerU2In6DkdZMI9v1PnJZ7vyEfn6Tx4Tumj5PzOu7IsFSjsg3rcXQoH/b1TXVoK7ZD6F7qfbXajmtenQmb0TlVLVBQDcsxPpbJv1NTGt97NjN8GuO7U4MQL0JY/wZS3jSGUgy8ybrl/Go+a0byBraRyGa9cCcxzmwf49MYqyUNLfi+i4xQM88hUC6Sp1r/0KlTZZgDGIBP/dQ3JzsgjJGox3B9cZ2OSX4Q6oa3HTDwqQCbOEfCA7QIe7C5fUrhXCjphFfoBHOEeyBGuJPf6VTitXH/uu1hsCvReM0eLD0nQYnd8TlEvSLAHq0V0onhe3RZER9IP6Gk1AmmRZNqq7ZGH/VPhUqxKzcz2H1PGiQbobjm6Mg9ckRcZmSA8FlvZ5/6X9LQ5Cjz4z8EjItaVOlXhdBXjWOtFIH6NCmZJ3TK3V02u+FYzx5XKgnJ5vMXrhX1Lbaj7uFcRhBgUGwVmDiRjyXDKODu67WiGF+hzQJ7xzE3KOxvoN40QRqRhAveawSqT8VTqX1tF7+mpGg3a1UbBvCfeMyLS3lw1gmuR7V+KbX22b20nWigx0orYtsROah4OkbFciIgtKoyEsib+I/++dP4cIx2J54HIOJsRb7NPvIuG3iHhCFR2fkbIMD6z2BBRm5tm3EpMRECJq9iQrWBumIMIIqKWnhoAzYxZVVZlTVsSnKR/iJKmLIWP91XcgFQ4SQZ5JkV1orz2XAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(6636002)(110136005)(40460700003)(83380400001)(316002)(47076005)(8676002)(4326008)(82310400005)(426003)(1076003)(70206006)(186003)(70586007)(86362001)(2616005)(508600001)(26005)(336012)(81166007)(2906002)(6666004)(7696005)(8936002)(36756003)(5660300002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 06:10:58.6512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd698b45-401a-435c-9465-08da3e155630
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2959
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

Changed from V2:
	move record_ce_addr_supported to umc_ecc_info struct

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  5 ++
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c         | 50 ++++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  1 +
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 28e603243b67..bf5a95104ec1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -333,6 +333,11 @@ struct ecc_info_per_ch {
 
 struct umc_ecc_info {
 	struct ecc_info_per_ch ecc[MAX_UMC_CHANNEL_NUM];
+
+	/* Determine smu ecctable whether support
+	 * record correctable error address
+	 */
+	int record_ce_addr_supported;
 };
 
 struct amdgpu_ras {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index 606892dbea1c..bf7524f16b66 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -119,6 +119,24 @@ static void umc_v6_7_ecc_info_query_correctable_error_count(struct amdgpu_device
 		*error_count += 1;
 
 		umc_v6_7_query_error_status_helper(adev, mc_umc_status, umc_reg_offset);
+
+		if (ras->umc_ecc.record_ce_addr_supported)	{
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
@@ -295,6 +315,31 @@ static void umc_v6_7_query_correctable_error_count(struct amdgpu_device *adev,
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
+			dev_info(adev->dev, "Error Address(PA): 0x%llx\n", soc_pa);
+		}
 	}
 }
 
@@ -395,7 +440,8 @@ static void umc_v6_7_query_ras_error_count(struct amdgpu_device *adev,
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
index 9cdfeea58085..c7e0fec614ea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1883,6 +1883,7 @@ static ssize_t aldebaran_get_ecc_info(struct smu_context *smu,
 			ecc_info_per_channel->mca_ceumc_addr =
 				ecc_table->EccInfo_V2[i].mca_ceumc_addr;
 		}
+		eccinfo->record_ce_addr_supported =1;
 	}
 
 	return ret;
-- 
2.17.1

