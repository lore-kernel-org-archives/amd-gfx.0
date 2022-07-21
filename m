Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEFAC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 08:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAEB58B799;
	Thu, 21 Jul 2022 08:58:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 141D28B79F
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 08:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzrHAIabKvqAAlM6WL5Iy/dvDl+NhevLw62UtTVma03lKCGOS+J3vLWa6ZPEUQwtFEIRE2bnJxKE4VvnLOxdBLxa9f9VOHEOjOeynzGdOsMN+sUGozxrzYZKzuMrD3IEIoHIA6JQyVTCKbRN4alUdt5UX4N32sONW8g7b+zZsszJPA77/ABbWJ09q3mbQ0L+1iWOofn1QSotkTaKZkDFjOpp4+iklKVKmvlDWQY8VfUeTyUbmfL9cfwzXk2R2iN8idNlpsu0gg1DW39tsk8uIEGcytqY61y//7fEpOUhkUuJUQq6gZeGew9/te4Xp8n5IzczrmkkKzm6fJXNgP4unw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vRCm0KYyzjnG/qAZlkZtoHLLF8D1Ibaz1EgV6Xo9o4=;
 b=fKteeSwQYZl9qAM8N43QHtoGoZId+vrNq00LiXccMOYIbcF7KIAmLHoh0ze5bWjHzg+6WcA8GEfb+Y2HuwSL07PTVrnv8EF30HhodFKx4EMUvgSimBd+AI0KpwgjwPEI5Wmz6ruC5nHkAeG6tSgM0rsz+GJNsY7w32nkPBah6n4l7P4+j6fD/NWdDaCEMe+JsdYNomF/G9kXhbFP6XG4MlB6XGS8SpXbCZdu5UEX4MIaS5kRlnJshynpAkqSYhg5CJLjfWnFLhwHEoO9Qp5xh2ZNoxAfRiq9rKn7C6+a5rr0s7EKrne2Msw2JByGP7F1++B+8EfNIcZs86bat8RZYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vRCm0KYyzjnG/qAZlkZtoHLLF8D1Ibaz1EgV6Xo9o4=;
 b=h4NrDK5HO3mwriT4Mi2F95ILjfeHhgjxSYoWMXs4Wr5g7UO/7jJclZFtPFr4lbPZEBXhFRll9Zu2ldlX5B9xJf8QpdN5avlhXk3e0YQx5Ho+UbBFXJTe3q/MfDFKjJk3iDkavIISIDIq3LbghRe148tSXmRuQEm45A7vzbxxCJI=
Received: from BN9PR03CA0657.namprd03.prod.outlook.com (2603:10b6:408:13b::32)
 by MW3PR12MB4571.namprd12.prod.outlook.com (2603:10b6:303:5c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Thu, 21 Jul
 2022 08:57:56 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::5b) by BN9PR03CA0657.outlook.office365.com
 (2603:10b6:408:13b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14 via Frontend
 Transport; Thu, 21 Jul 2022 08:57:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 08:57:55 +0000
Received: from master-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 03:57:53 -0500
From: <shikai.guo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Add get_gfx_off_status interface
Date: Thu, 21 Jul 2022 16:57:38 +0800
Message-ID: <20220721085738.2528792-1-shikai.guo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 051214cb-2bbb-4603-4241-08da6af71a60
X-MS-TrafficTypeDiagnostic: MW3PR12MB4571:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lzahc6McQ6Mb2HsxdphCB/8eu4/bPZ4aFhHthsGUuIVBZfSIaPvsvvlW7Pu1m/HgQTqh5p70NgUt7synN97T1PsuDHLDPWLRIit3i8G02HAxxeRnxgamxtc6Fo1zDS+SI/DXGPBkYXpRbxR19lUhKs6V4R8Kwmgy8XvxhEBmst1J2cFi6pIHPhxD90mrMjSQpBIMSzHp2WAsvcQ/XRManvoXL4xU7p+1SrlVC+5hwkq+gSBBXk2YTCH0YQTF6z72dX8Uf37nRpllpKj2xmvSK3Y83JONnxYwc6R+jvWkUKFoSTKdIWpCbq2xIa66SfZFRUu++SRdlA/y7771D+39ZC1AoFPeZRNbv4Rbugu/+Zulc6K3wnTXikDD9sA+r0bhR6eo0VqGcZosBweNX084NyGkFao4KU28UkCT4XEuNcIeg2rZDL5nCrPKwiiKDaIMDB6P5zxoisvOu62XPZnwkd1GXCMYIyubkc1tpWqO1zliRbZlRH+/26ri0k0bkG5bR0GnedgfcUbTiWYAoIVnaerfipnO+D+4YKrs8ALla0/VEy8/G21gIAH2+EFcx83RcWHy65Tme17Z1BDGDDUlJZAN4tWH4YH3KSDN+9EnuvAbwTDez1udAPd+Q4jzbmvgSsbgIpQ+m0RM89srM9Op4StK1G5z4HR9+IuQU6Sl75NMf83/avNCxcrUu+QxzullBKXxtaO4t1R9rSpT2RvEolRuIRLN4u/hueUS+EzZUL6k3oap2jfQ5Ol4PbtR30iPbkbSqZPpwLgP4MSWPckd5/E3VMZkbP0tb3Sr37/DSH/Z9ZYp1CG6MJVmIiWTtebPObbkXMUPoZN0mH3dulwn/K/ImsGkoEZTJ/qrLHHbMvZI2N4PfJlDFa2rKyKzkRad
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(346002)(39860400002)(136003)(40470700004)(36840700001)(46966006)(8676002)(47076005)(70586007)(5660300002)(1076003)(86362001)(356005)(4326008)(81166007)(40480700001)(336012)(82740400003)(8936002)(16526019)(478600001)(426003)(70206006)(83380400001)(26005)(6666004)(82310400005)(316002)(7696005)(2616005)(186003)(36860700001)(40460700003)(2876002)(2906002)(6916009)(54906003)(36756003)(41300700001)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 08:57:55.7703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 051214cb-2bbb-4603-4241-08da6af71a60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4571
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
Cc: Alexander.Deucher@amd.com, prike.liang@amd.com, evan.quan@amd.com,
 Shikai Guo <shikai.guo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shikai Guo <Shikai.Guo@amd.com>

add get_gfx_off_status interface to yellow_carp_ppt_funcs structure.

Signed-off-by: Shikai Guo <shikai.guo@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 70cbc46341a3..2e39b629e7e6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -31,6 +31,7 @@
 #include "smu_v13_0_1_ppsmc.h"
 #include "smu_v13_0_1_pmfw.h"
 #include "smu_cmn.h"
+#include "asic_reg/smuio/smuio_13_0_2_offset.h"
 
 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -42,6 +43,9 @@
 #undef pr_info
 #undef pr_debug
 
+#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK		0x00000006L
+#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT			0x1
+
 #define FEATURE_MASK(feature) (1ULL << feature)
 #define SMC_DPM_FEATURE ( \
 	FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
@@ -587,6 +591,31 @@ static ssize_t yellow_carp_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v2_1);
 }
 
+/**
+ * yellow_carp_get_gfxoff_status - get gfxoff status
+ *
+ * @smu: smu_context pointer
+ *
+ * This function will be used to get gfxoff status
+ *
+ * Returns 0=GFXOFF(default).
+ * Returns 1=Transition out of GFX State.
+ * Returns 2=Not in GFXOFF.
+ * Returns 3=Transition into GFXOFF.
+ */
+static uint32_t yellow_carp_get_gfxoff_status(struct smu_context *smu)
+{
+	uint32_t reg;
+	uint32_t gfxOff_Status = 0;
+	struct amdgpu_device *adev = smu->adev;
+
+	reg = RREG32_SOC15(SMUIO, 0, regSMUIO_GFX_MISC_CNTL);
+	gfxOff_Status = (reg & SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK)
+		>> SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT;
+
+	return gfxOff_Status;
+}
+
 static int yellow_carp_set_default_dpm_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -1186,6 +1215,7 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_driver_table_location = smu_v13_0_set_driver_table_location,
 	.gfx_off_control = smu_v13_0_gfx_off_control,
+	.get_gfx_off_status = yellow_carp_get_gfxoff_status,
 	.post_init = yellow_carp_post_smu_init,
 	.mode2_reset = yellow_carp_mode2_reset,
 	.get_dpm_ultimate_freq = yellow_carp_get_dpm_ultimate_freq,
-- 
2.25.1

