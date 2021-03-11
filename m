Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4339C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 06:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5884264EC6
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 06:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5884264EC6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD0B06EAD3;
	Thu, 11 Mar 2021 06:57:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C9746EAD3
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 06:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kq6DzTnXC9zDubjtASKmMg7l/3R1DzQD7hzLd8ATWf5/NNJNrzVIK8WBJavwGomWl4ALFF4wiEo0Gi8XdV6/VdpQvS1NA8uJ8ElLe+Qnk2ij3pS1I/yNWeJ4M2NOe6nhWtQS7fbxhSD6GHH9aRxJMXPKkJVk+/PqTX3SY2IKD4AW5bfrZml3NJtxT8OaYyA4S169sGZSdcFN/852qJ0RNLBnGgGicvtCB4rEtEuAhRvbhDVQ+cUPLU8RkQLeLuUTVyR9LmDQv8mOJdD/PZ+hLuTaO+ZimSPaKPCFWBeLZupiYpQcSLJguNOBPCp798T9SI6GSgYBIarR7RMFkNr17w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfSKNEGGGwGj7brzzPNaMlVD7BGhGkOOIIYdsfdpICE=;
 b=LNttiy80Wkh0Yadma+a2x9Ef0BImyn2PG8g7Hql5v3vdfhZFFLEuhBjYCzdLZfJls2l+v3yP9IBVoh70TbtYNmRACDR9bNbK4lGL8M06gjKWW1wiwoxwsjoaOE/8UsQuMsuYL9OAoh78Q3G+PxJxzk5sUHII56MaCCvC7ySvZkfDYMwOeeMT6Abhc9mqEnYSHVkyNNoAhLfWbtUDeWk8Rrn34WxzVwilaFv27I+ykF2EztZnABRKOVPQDFp6+NZApGGrzFf0p9j2MBpCR5WMzXPv9LoqZsIXQAjeMA2kFONqnoNSNQbLXtAaDr9VcKsn9gJhELyXhnuQSDoZ0nPnpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfSKNEGGGwGj7brzzPNaMlVD7BGhGkOOIIYdsfdpICE=;
 b=v/cq+2iuGY4SI38hMH4/6awUZpKhfBzZPlFGcLiifKM8kXoQlPVezuZ80b6vtCzd7jTS1IIq4w8qHC2Bj/3o6/H47gyTl7h+xOp8D3scxb9CGMq63zihPc8ZxqRCeKdd1+gMELulInSVn56Np+JxA1qAp4BwX4ejf4SYk+4miLs=
Received: from DM5PR19CA0002.namprd19.prod.outlook.com (2603:10b6:3:151::12)
 by BYAPR12MB3048.namprd12.prod.outlook.com (2603:10b6:a03:ad::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Thu, 11 Mar
 2021 06:57:44 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::6c) by DM5PR19CA0002.outlook.office365.com
 (2603:10b6:3:151::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 11 Mar 2021 06:57:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3933.31 via Frontend Transport; Thu, 11 Mar 2021 06:57:44 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 11 Mar
 2021 00:57:43 -0600
Received: from kenneth-u1804-kvm.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Thu, 11 Mar 2021 00:57:42 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/pm: workaround for audio noise issue
Date: Thu, 11 Mar 2021 14:58:40 +0800
Message-ID: <20210311065840.12080-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8989908-f25d-46f9-c535-08d8e45af8a0
X-MS-TrafficTypeDiagnostic: BYAPR12MB3048:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3048120640C9343500DEBEE88E909@BYAPR12MB3048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /pHpzOw4V1s8KhVeNU7yOn1CVqsSG3koPlSjo5NBDAFMTAASZOcazWSwIiJlqLuXbdBB81ZCz26HptoLpsI0Egs3OwC9PcWyzH+m1Yl4XEf1TbqGdoAx0EnCPTPeuzVqXAWWnMiivd5Oev2bKwt3weVgoIMI8ol1m3ZFFp2Z6CXhqqwiyYhU0yha6a4LZquQ31a55w9ffXauTxsViQAIal1D7YMJzguHeRImGFAwmkSkHLsMfkOzS+XpEwO8hyESeLmNCJZs+RiZDxf2JEChXALb56agKZopf7kVnYY9XHZgkh+7zz6VVexPdvRP1+s5vY4PS5xPzQpcVV5zdppAIlC9yyFqjW57Yyox0utCCqj3W5jk9w+coRqCyh6oSWSTuqPeh0/u21ISSD77VoWt+RmJM50/M+lh764DbUxNMB322QnrcnESSeQoRBGsNFDyTAJWa1qJ2d9pE5jt5L1WxhKFzuETFQdswaG7AfKSUL6t24ExiRxwR5YgMEOlFnZ241xWZP/UjpZSLMMq8hlUAyDAsoerCmjnLBvvkdGTzMmcvSljge1cbBKgYg9w0xppDw+G+2uzHh124Z5UkCn7gn+AQ0ZJ/Sjao7BTWg86fksHCSx1IoGVHhoSh/cI09IJaddFgYOMGRE3n3MVhb2OvOJij7DuON10/BXeV/3bUiuBoGdU9FG845FyRMS+82Jz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(36840700001)(46966006)(81166007)(186003)(356005)(47076005)(6916009)(8936002)(36756003)(82310400003)(2906002)(316002)(1076003)(44832011)(478600001)(70206006)(7696005)(4326008)(83380400001)(5660300002)(26005)(82740400003)(426003)(2616005)(8676002)(86362001)(36860700001)(30864003)(336012)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 06:57:44.1411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8989908-f25d-46f9-c535-08d8e45af8a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3048
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On some Intel platforms, audio noise can be detected due to
high pcie speed switch latency.
This patch leaverages ppfeaturemask to fix to the highest pcie
speed then disable pcie switching.

v2:
coding style fix

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 54 ++++++++++++++
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 74 ++++++++++++++++---
 .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 24 ++++++
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 25 +++++++
 4 files changed, 166 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index a58f92249c53..54bbee310e57 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -587,6 +587,48 @@ static int smu7_force_switch_to_arbf0(struct pp_hwmgr *hwmgr)
 			tmp, MC_CG_ARB_FREQ_F0);
 }
 
+static uint16_t smu7_override_pcie_speed(struct pp_hwmgr *hwmgr)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
+	uint16_t pcie_gen = 0;
+
+	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4 &&
+	    adev->pm.pcie_gen_mask & CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN4)
+		pcie_gen = 3;
+	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3 &&
+		adev->pm.pcie_gen_mask & CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN3)
+		pcie_gen = 2;
+	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2 &&
+		adev->pm.pcie_gen_mask & CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN2)
+		pcie_gen = 1;
+	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN1 &&
+		adev->pm.pcie_gen_mask & CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN1)
+		pcie_gen = 0;
+
+	return pcie_gen;
+}
+
+static uint16_t smu7_override_pcie_width(struct pp_hwmgr *hwmgr)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
+	uint16_t pcie_width = 0;
+
+	if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X16)
+		pcie_width = 16;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X12)
+		pcie_width = 12;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X8)
+		pcie_width = 8;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X4)
+		pcie_width = 4;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X2)
+		pcie_width = 2;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X1)
+		pcie_width = 1;
+
+	return pcie_width;
+}
+
 static int smu7_setup_default_pcie_table(struct pp_hwmgr *hwmgr)
 {
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
@@ -683,6 +725,11 @@ static int smu7_setup_default_pcie_table(struct pp_hwmgr *hwmgr)
 					PP_Min_PCIEGen),
 			get_pcie_lane_support(data->pcie_lane_cap,
 					PP_Max_PCIELane));
+
+		if (data->pcie_dpm_key_disabled)
+			phm_setup_pcie_table_entry(&data->dpm_table.pcie_speed_table,
+				data->dpm_table.pcie_speed_table.count,
+				smu7_override_pcie_speed(hwmgr), smu7_override_pcie_width(hwmgr));
 	}
 	return 0;
 }
@@ -1248,6 +1295,13 @@ static int smu7_start_dpm(struct pp_hwmgr *hwmgr)
 						NULL)),
 				"Failed to enable pcie DPM during DPM Start Function!",
 				return -EINVAL);
+	} else {
+		PP_ASSERT_WITH_CODE(
+				(0 == smum_send_msg_to_smc(hwmgr,
+						PPSMC_MSG_PCIeDPM_Disable,
+						NULL)),
+				"Failed to disble pcie DPM during DPM Start Function!",
+				return -EINVAL);
 	}
 
 	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 408b35866704..f5a32654cde7 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -54,6 +54,9 @@
 #include "smuio/smuio_9_0_offset.h"
 #include "smuio/smuio_9_0_sh_mask.h"
 
+#define smnPCIE_LC_SPEED_CNTL			0x11140290
+#define smnPCIE_LC_LINK_WIDTH_CNTL		0x11140288
+
 #define HBM_MEMORY_CHANNEL_WIDTH    128
 
 static const uint32_t channel_number[] = {1, 2, 0, 4, 0, 8, 0, 16, 2};
@@ -443,8 +446,7 @@ static void vega10_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 	if (PP_CAP(PHM_PlatformCaps_VCEDPM))
 		data->smu_features[GNLD_DPM_VCE].supported = true;
 
-	if (!data->registry_data.pcie_dpm_key_disabled)
-		data->smu_features[GNLD_DPM_LINK].supported = true;
+	data->smu_features[GNLD_DPM_LINK].supported = true;
 
 	if (!data->registry_data.dcefclk_dpm_key_disabled)
 		data->smu_features[GNLD_DPM_DCEFCLK].supported = true;
@@ -1544,6 +1546,13 @@ static int vega10_override_pcie_parameters(struct pp_hwmgr *hwmgr)
 			pp_table->PcieLaneCount[i] = pcie_width;
 	}
 
+	if (data->registry_data.pcie_dpm_key_disabled) {
+		for (i = 0; i < NUM_LINK_LEVELS; i++) {
+			pp_table->PcieGenSpeed[i] = pcie_gen;
+			pp_table->PcieLaneCount[i] = pcie_width;
+		}
+	}
+
 	return 0;
 }
 
@@ -2966,6 +2975,14 @@ static int vega10_start_dpm(struct pp_hwmgr *hwmgr, uint32_t bitmap)
 		}
 	}
 
+	if (data->registry_data.pcie_dpm_key_disabled) {
+		PP_ASSERT_WITH_CODE(!vega10_enable_smc_features(hwmgr,
+				false, data->smu_features[GNLD_DPM_LINK].smu_feature_bitmap),
+		"Attempt to Disable Link DPM feature Failed!", return -EINVAL);
+		data->smu_features[GNLD_DPM_LINK].enabled = false;
+		data->smu_features[GNLD_DPM_LINK].supported = false;
+	}
+
 	return 0;
 }
 
@@ -4584,6 +4601,24 @@ static int vega10_set_ppfeature_status(struct pp_hwmgr *hwmgr, uint64_t new_ppfe
 	return 0;
 }
 
+static int vega10_get_current_pcie_link_width_level(struct pp_hwmgr *hwmgr)
+{
+	struct amdgpu_device *adev = hwmgr->adev;
+
+	return (RREG32_PCIE(smnPCIE_LC_LINK_WIDTH_CNTL) &
+		PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK)
+		>> PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
+}
+
+static int vega10_get_current_pcie_link_speed_level(struct pp_hwmgr *hwmgr)
+{
+	struct amdgpu_device *adev = hwmgr->adev;
+
+	return (RREG32_PCIE(smnPCIE_LC_SPEED_CNTL) &
+		PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK)
+		>> PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
+}
+
 static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 		enum pp_clock_type type, char *buf)
 {
@@ -4592,8 +4627,9 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 	struct vega10_single_dpm_table *mclk_table = &(data->dpm_table.mem_table);
 	struct vega10_single_dpm_table *soc_table = &(data->dpm_table.soc_table);
 	struct vega10_single_dpm_table *dcef_table = &(data->dpm_table.dcef_table);
-	struct vega10_pcie_table *pcie_table = &(data->dpm_table.pcie_table);
 	struct vega10_odn_clock_voltage_dependency_table *podn_vdd_dep = NULL;
+	uint32_t gen_speed, lane_width, current_gen_speed, current_lane_width;
+	PPTable_t *pptable = &(data->smc_state_table.pp_table);
 
 	int i, now, size = 0, count = 0;
 
@@ -4650,15 +4686,31 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 					"*" : "");
 		break;
 	case PP_PCIE:
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentLinkIndex, &now);
-
-		for (i = 0; i < pcie_table->count; i++)
-			size += sprintf(buf + size, "%d: %s %s\n", i,
-					(pcie_table->pcie_gen[i] == 0) ? "2.5GT/s, x1" :
-					(pcie_table->pcie_gen[i] == 1) ? "5.0GT/s, x16" :
-					(pcie_table->pcie_gen[i] == 2) ? "8.0GT/s, x16" : "",
-					(i == now) ? "*" : "");
+		current_gen_speed =
+			vega10_get_current_pcie_link_speed_level(hwmgr);
+		current_lane_width =
+			vega10_get_current_pcie_link_width_level(hwmgr);
+		for (i = 0; i < NUM_LINK_LEVELS; i++) {
+			gen_speed = pptable->PcieGenSpeed[i];
+			lane_width = pptable->PcieLaneCount[i];
+
+			size += sprintf(buf + size, "%d: %s %s %s\n", i,
+					(gen_speed == 0) ? "2.5GT/s," :
+					(gen_speed == 1) ? "5.0GT/s," :
+					(gen_speed == 2) ? "8.0GT/s," :
+					(gen_speed == 3) ? "16.0GT/s," : "",
+					(lane_width == 1) ? "x1" :
+					(lane_width == 2) ? "x2" :
+					(lane_width == 3) ? "x4" :
+					(lane_width == 4) ? "x8" :
+					(lane_width == 5) ? "x12" :
+					(lane_width == 6) ? "x16" : "",
+					(current_gen_speed == gen_speed) &&
+					(current_lane_width == lane_width) ?
+					"*" : "");
+		}
 		break;
+
 	case OD_SCLK:
 		if (hwmgr->od_enabled) {
 			size = sprintf(buf, "%s:\n", "OD_SCLK");
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index 196ac2a4d145..b6d7b7b224a9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -133,6 +133,7 @@ static void vega12_set_default_registry_data(struct pp_hwmgr *hwmgr)
 	data->registry_data.auto_wattman_debug = 0;
 	data->registry_data.auto_wattman_sample_period = 100;
 	data->registry_data.auto_wattman_threshold = 50;
+	data->registry_data.pcie_dpm_key_disabled = !(hwmgr->feature_mask & PP_PCIE_DPM_MASK);
 }
 
 static int vega12_set_features_platform_caps(struct pp_hwmgr *hwmgr)
@@ -539,6 +540,29 @@ static int vega12_override_pcie_parameters(struct pp_hwmgr *hwmgr)
 		pp_table->PcieLaneCount[i] = pcie_width_arg;
 	}
 
+	/* override to the highest if it's disabled from ppfeaturmask */
+	if (data->registry_data.pcie_dpm_key_disabled) {
+		for (i = 0; i < NUM_LINK_LEVELS; i++) {
+			smu_pcie_arg = (i << 16) | (pcie_gen << 8) | pcie_width;
+			ret = smum_send_msg_to_smc_with_parameter(hwmgr,
+				PPSMC_MSG_OverridePcieParameters, smu_pcie_arg,
+				NULL);
+			PP_ASSERT_WITH_CODE(!ret,
+				"[OverridePcieParameters] Attempt to override pcie params failed!",
+				return ret);
+
+			pp_table->PcieGenSpeed[i] = pcie_gen;
+			pp_table->PcieLaneCount[i] = pcie_width;
+		}
+		ret = vega12_enable_smc_features(hwmgr,
+				false,
+				data->smu_features[GNLD_DPM_LINK].smu_feature_bitmap);
+		PP_ASSERT_WITH_CODE(!ret,
+				"Attempt to Disable DPM LINK Failed!",
+				return ret);
+		data->smu_features[GNLD_DPM_LINK].enabled = false;
+		data->smu_features[GNLD_DPM_LINK].supported = false;
+	}
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 78bbd4d666f2..213c9c6b4462 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -171,6 +171,7 @@ static void vega20_set_default_registry_data(struct pp_hwmgr *hwmgr)
 	data->registry_data.gfxoff_controlled_by_driver = 1;
 	data->gfxoff_allowed = false;
 	data->counter_gfxoff = 0;
+	data->registry_data.pcie_dpm_key_disabled = !(hwmgr->feature_mask & PP_PCIE_DPM_MASK);
 }
 
 static int vega20_set_features_platform_caps(struct pp_hwmgr *hwmgr)
@@ -884,6 +885,30 @@ static int vega20_override_pcie_parameters(struct pp_hwmgr *hwmgr)
 		pp_table->PcieLaneCount[i] = pcie_width_arg;
 	}
 
+	/* override to the highest if it's disabled from ppfeaturmask */
+	if (data->registry_data.pcie_dpm_key_disabled) {
+		for (i = 0; i < NUM_LINK_LEVELS; i++) {
+			smu_pcie_arg = (i << 16) | (pcie_gen << 8) | pcie_width;
+			ret = smum_send_msg_to_smc_with_parameter(hwmgr,
+				PPSMC_MSG_OverridePcieParameters, smu_pcie_arg,
+				NULL);
+			PP_ASSERT_WITH_CODE(!ret,
+				"[OverridePcieParameters] Attempt to override pcie params failed!",
+				return ret);
+
+			pp_table->PcieGenSpeed[i] = pcie_gen;
+			pp_table->PcieLaneCount[i] = pcie_width;
+		}
+		ret = vega20_enable_smc_features(hwmgr,
+				false,
+				data->smu_features[GNLD_DPM_LINK].smu_feature_bitmap);
+		PP_ASSERT_WITH_CODE(!ret,
+				"Attempt to Disable DPM LINK Failed!",
+				return ret);
+		data->smu_features[GNLD_DPM_LINK].enabled = false;
+		data->smu_features[GNLD_DPM_LINK].supported = false;
+	}
+
 	return 0;
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
