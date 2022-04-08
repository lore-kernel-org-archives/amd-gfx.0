Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68B7C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 02:18:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37D4810E306;
	Fri,  8 Apr 2022 02:18:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D132B10E306
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 02:18:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2839pkQecIRq4ajpMKIngN6qZx/kTiaLlW6RthSK0oayysNNf2jDNmy4FRdwTiaIR7rUfgzQMxhYk8pv+5VrvS0l2dl0yxcOyMWjnn3vOpfwatiJ7B1BZL8ZlnmmLpcy4hvmm1uA9pOvFKVQm0xCVLmLchHaNueWBesIH3ggiyQCLzXqBSBDmMdre0+OOUyUDarnWk5oIorH3bsC0ILNmYXVE+Sv0rpkMfG1r3sB8jBBCrCMy7lBEY3vYQYsiYTrpAMBiGQlK51pYmJ5wuL58RFkcAU2XF4cVbu5REZytQm1b6JVqRMoeyzJA5hgJqlh3twKirKFdg+ei+FL1LwQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8rgnySyVuNlch5NV8HwOHCSffzZYMtUbZs4tmsuC/w=;
 b=kBwBLVW3+M5ChsQGwmOgx5EmvbC1PZMRHjg0G/grVBV+Jw1yVz2/7tggqVbrCfI2jqnBmlSIysrBk3GBMKjg6lWcCtDwp7f2yGGZtfp9efl13VbKCB0hDEu4kxOZ8AlzU1nPL9kRYGBY69Ml92zcE8ozEMX7ydAFMcHIw9qBSVpmSgAtsa3xKz1kx1N6RJEk/2v6cDU/vuNYrTCG+rIVBUY5HDvBkqJh7NOB3kibDNLiYI42t3V/bZdnNB1Q8ejW3OZ+jQQ70PF5UmylNVJY+OM7Ej5uFe5yWsdPSaLi0MIwmy4t5ky1QXZ1LBTzcso+4bAKJjV6FniEbIl+pMrZGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8rgnySyVuNlch5NV8HwOHCSffzZYMtUbZs4tmsuC/w=;
 b=g3I73VWlNgvDsW7Zn9M/J13GbUgitsOxRQXtNb2AolCqNycCQeDXWkhaLXzI2BMo+FwXIwLnjAaenIafCGBOh0MtG0gMoItgSRqr0G6RNxJpmWr/5FaYqs02gqOhzoJpt950lFnLHSIZMZyhFU+CptSD3n6KB6V4JfAlvb2mYC4=
Received: from DS7PR03CA0257.namprd03.prod.outlook.com (2603:10b6:5:3b3::22)
 by DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 02:18:35 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::72) by DS7PR03CA0257.outlook.office365.com
 (2603:10b6:5:3b3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.25 via Frontend
 Transport; Fri, 8 Apr 2022 02:18:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 02:18:34 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 7 Apr
 2022 21:18:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 7 Apr
 2022 21:18:31 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Thu, 7 Apr 2022 21:18:29 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: print more correctable error info
Date: Fri, 8 Apr 2022 10:18:26 +0800
Message-ID: <20220408021826.12173-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc240a35-7009-4f8d-b72c-08da19061560
X-MS-TrafficTypeDiagnostic: DM6PR12MB5520:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB552030E1DC789BD580A4D5E89AE99@DM6PR12MB5520.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8F1SRm2/1BDKRO5saiTNgOihgsRSIT5PPjbchIuavMBKX9E5CfVgKrBFG00KQGekTdpAf7UNLMFGYH0+oljUY0TcZDVcNetQljWWfaHDtB2+a7IlfkaX8np8/L+0jCRilXoDH5ke4/ZIT/c2ZxVXvBuz4++/W3OpFBFgCrqFu7sAGSOmlYbVzprhlsqZIrsl2nvGfQ++lCzSBVQeB+3/trqtMXoDS2B7HKGl5yCLAeNXrkba+IsyrGl+jjBvDiroAeJP6SyOQuvBrMPmcD0LqxsM4pxHOEHV9/OvIudPOgfoT3M+Ujjk3JL0KkXzBdQJCE/vzip7ny+Hz9bsxgWZYwMirjf5IZQ6hwDCOyQE/uCeSvof7wzj8CNmLfGA5me6j22XG7sDlksOvWJem1RNHz2CnxmkmRGNUMBU4O7pW1tU1kUyAxKnUPghMjc111Tp2tOH0KC6D3QwvEATxLjFxm1GNqtdrtqyYBz4RGsgq+xMBzYvqucaZzQ7Mw6T5cVjOfpezZ2/PnePvUMZqeW7WeU597csNUgwqS20TQnNWDbBzfUlbYcv/QDpWyMCfE+tVcEH5FpaWixyyUekx++ttn2AqvN6RD5+QwtE1xh0KO+UkI4VsfPuiyfhA4nRbzBSxFjqb9x9CxVxWCk3h3t2uifYF/l5na6An77pnK5PjWp5iNgv6y8ufLxgBxY1XDwh/W2N5KDfSyrfUKfRwNZnYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(7696005)(6666004)(8936002)(36756003)(36860700001)(8676002)(186003)(81166007)(356005)(2906002)(508600001)(70586007)(70206006)(110136005)(4326008)(86362001)(316002)(83380400001)(47076005)(6636002)(40460700003)(26005)(1076003)(426003)(336012)(82310400005)(2616005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 02:18:34.4410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc240a35-7009-4f8d-b72c-08da19061560
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5520
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

Change-Id: I09a2aae85cde3ab2cb6b042b973da6839ad024ec
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 62 ++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index c45d9c14ecbc..803119f75e39 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -70,15 +70,46 @@ static void umc_v6_7_ecc_info_query_correctable_error_count(struct amdgpu_device
 {
 	uint64_t mc_umc_status;
 	uint32_t eccinfo_table_idx;
+	uint32_t umc_reg_offset;
+	uint32_t mc_umc_addr;
+	uint64_t reg_value;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
+	umc_reg_offset = get_umc_v6_7_reg_offset(adev,
+						umc_inst, ch_inst);
+
 	eccinfo_table_idx = umc_inst * adev->umc.channel_inst_num + ch_inst;
 	/* check for SRAM correctable error
 	  MCUMC_STATUS is a 64 bit register */
 	mc_umc_status = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
 	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1) {
 		*error_count += 1;
+
+		if (mc_umc_status)
+			dev_info(adev->dev, "MCA STATUS 0x%llx, umc_reg_offset 0x%x\n", mc_umc_status, umc_reg_offset);
+
+		/* print IPID registers value */
+		mc_umc_addr =
+			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_IPIDT0);
+		reg_value = RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
+		if (reg_value)
+			dev_info(adev->dev, "MCA IPID 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
+
+		/* print SYND registers value */
+		mc_umc_addr =
+			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_SYNDT0);
+		reg_value = RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
+		if (reg_value)
+			dev_info(adev->dev, "MCA SYND 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
+
+		/* print MISC0 registers value */
+		mc_umc_addr =
+			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_MISC0T0);
+		reg_value = RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
+		if (reg_value)
+			dev_info(adev->dev, "MCA MISC0 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
+	}
 }
 
 static void umc_v6_7_ecc_info_querry_uncorrectable_error_count(struct amdgpu_device *adev,
@@ -242,7 +273,9 @@ static void umc_v6_7_query_correctable_error_count(struct amdgpu_device *adev,
 	uint32_t ecc_err_cnt_sel, ecc_err_cnt_sel_addr;
 	uint32_t ecc_err_cnt, ecc_err_cnt_addr;
 	uint64_t mc_umc_status;
+	uint32_t mc_umc_addr;
 	uint32_t mc_umc_status_addr;
+	uint64_t reg_value;
 
 	/* UMC 6_1_1 registers */
 	ecc_err_cnt_sel_addr =
@@ -277,8 +310,33 @@ static void umc_v6_7_query_correctable_error_count(struct amdgpu_device *adev,
 	  MCUMC_STATUS is a 64 bit register */
 	mc_umc_status = RREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4);
 	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1) {
 		*error_count += 1;
+
+		if (mc_umc_status)
+			dev_info(adev->dev, "MCA STATUS 0x%llx, umc_reg_offset 0x%x\n", mc_umc_status, umc_reg_offset);
+
+		/* print IPID registers value */
+		mc_umc_addr =
+			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_IPIDT0);
+		reg_value = RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
+		if (reg_value)
+			dev_info(adev->dev, "MCA IPID 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
+
+		/* print SYND registers value */
+		mc_umc_addr =
+			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_SYNDT0);
+		reg_value = RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
+		if (reg_value)
+			dev_info(adev->dev, "MCA SYND 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
+
+		/* print MISC0 registers value */
+		mc_umc_addr =
+			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_MISC0T0);
+		reg_value = RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
+		if (reg_value)
+			dev_info(adev->dev, "MCA MISC0 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
+	}
 }
 
 static void umc_v6_7_querry_uncorrectable_error_count(struct amdgpu_device *adev,
-- 
2.17.1

