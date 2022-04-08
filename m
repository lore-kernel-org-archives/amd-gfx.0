Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AFCC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 08:10:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0119510EF1A;
	Fri,  8 Apr 2022 08:10:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B15F10EF1A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 08:10:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wf5j9yka91teErCrEiXtP+RiCOXOmlFGmZv6NP3CKc+i5vXfvI3KP06ftsuY4yzRsu9vY/BBBQvnOL1qfbSZLN9NrvLW3Zo7s+X4lkre+LDpNp/wgmlTduSxHOVP6hQ7+rSWezvCfaVqtsEKV0oQx0TY4onAzdQLK3z8GqSjYAtar1ivf0Nha6N1OIXstwT/Na96zpAHYR2jlayhT4oSnrheEkVlnkttYecgxvi/UkdbtbWWS7ZLpxLHBeDqjtVR1x2dK8avyw40q/6wRhEjBA3eMQHxDwCHnOfh4ruweaJaNtpXmTO/8jYmfjzwcAO/cCbyWvIyHeedH2oXMYn/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lTVmqLxFxHrdhIznfWlVZ4fhkHiLpkRqvi9V61T4YM=;
 b=Dza+foFx5OHmNKgpYHpyHakk0Pn3gvW6Lx94ANLqVfhOdICB3/ih7FVb6Uww8pvnNFc5zrpxsiPYOmDMJAObw+fD7C4otlkyTovzQhks0smx4MLg7iVMy8gYL+qcHQ61qQ3xOhnq/mVWCBjwS4EYVQcyYEAaVDcMQoECfKEk7F63hehMt4aT3set0tpEwl8lUB04VDGYMDh5pOtaxoc//jbO8c7/VhhTaq0RTEEt/PQG7fQDEE09C9h5zYkvnKk5dXrMb/xaFFhidbKWuIWRRyplSVfcyZkbB7sevv+m1n02eidw03SSoyYy+3WGESupVXa0/5lUi+PhLxMHXn3y9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lTVmqLxFxHrdhIznfWlVZ4fhkHiLpkRqvi9V61T4YM=;
 b=ZeDZqSEdqTUxm20jxZh+/3knJ3ogae4PtWr/3Ze0ZMEGFwyPnCPJeosx5cCvn4Lo7zlQ3O5G6H/D8dTF9EdvlzFJV1Uv0rzaBsnfEqw5kFuCvKBNfNR5yaoxXxoqVRwNA6+O15tZWi7VgeJ+oFtnTq0HQQzb/SamUVm115zTkSY=
Received: from MWH0EPF00056D17.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:1b) by SN6PR12MB4733.namprd12.prod.outlook.com
 (2603:10b6:805:ea::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 08:10:18 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::202) by MWH0EPF00056D17.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.11 via Frontend
 Transport; Fri, 8 Apr 2022 08:10:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 08:10:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 03:10:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 03:10:16 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Fri, 8 Apr 2022 03:10:15 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: add umc query error status function
Date: Fri, 8 Apr 2022 16:10:09 +0800
Message-ID: <20220408081009.31319-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef04433a-6828-4f72-85ee-08da19373819
X-MS-TrafficTypeDiagnostic: SN6PR12MB4733:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB473354FEAFD0F4066BA7D66D9AE99@SN6PR12MB4733.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +5ec4XHZZvG2VDiGAG2szUKm5i2et4K7k9bGOW73U47LojhusqvhYu+GZM8cSub4oqQMcl3WY/U+A8y8j+1HtU5hkg/45RlzHcZcX4kX+8/DrrQomvrMdEF16UBv4//JOFqay1wzzENv7I6Rh4Uat+5bDAl5MP5l51cGxEERIsh6mbE33qso+/MJCNPTp2ScWrvVqUMj0xh9kgjnB/ZO+15FsMjM3bovLwZiUAJ4Rz25ZXIu0ewIc1Be2D03NqfJbrLqIryI+q/8eZhBN9Op7fknA1n0qisAzZ5C9hTbRvIe5EhVmjgy3kHa/M72nx1wG2g0/QxfoskAessSBuc6zpvtIjovRu4qO8hpG3Ums07vRgGLYOv71lHy1y8I1TJM8biaBrx8JjfjmrDj8sHplcYLzNuzaVSTD+OPnaOp+VgMzzFndA8RRPwwastWZw4jZJ/+gSlOQ/9tjYo2k4t5RfFIBE1PGMp5Uq417MarbQzMnTZRerhBE/y2w9ZPMb4GZeWl5k+WquwpowIkEPPCiOZ0q0Bf7RlhjCizhG6fk4heGAp02KDK1dZ0B2f0BMaUrY5LADdrygTCpGDD8/sQQ+UXH42NGs/w/gvIYCtaxl1451e9BRCcmFY2UffZttyrhv2+B9cvUZxns/VcxSuMJVviL/NLEZDue7yIOfImM3fgL7JJ7+eRhusKWvy/5E5jeMLghZJ5ECwAUsDPy0tTRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(70206006)(110136005)(5660300002)(36860700001)(86362001)(508600001)(47076005)(8936002)(2616005)(186003)(26005)(82310400005)(4326008)(336012)(426003)(6666004)(2906002)(7696005)(6636002)(40460700003)(356005)(316002)(8676002)(70586007)(36756003)(1076003)(81166007)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 08:10:17.9564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef04433a-6828-4f72-85ee-08da19373819
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4733
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

In order to debug ras error, driver will print IPID/SYND/MISC0
register value if detect correctable or uncorrectable error.
Provide umc_query_error_status_helper function to reduce code
redundancy.

Change-Id: I09a2aae85cde3ab2cb6b042b973da6839ad024ec
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 106 ++++++++++++--------------
 1 file changed, 48 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index c45d9c14ecbc..9d3b54778417 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -64,21 +64,62 @@ static inline uint32_t get_umc_v6_7_channel_index(struct amdgpu_device *adev,
 	return adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
 }
 
+static void umc_query_error_status_helper(struct amdgpu_device *adev,
+						  uint64_t mc_umc_status, uint32_t umc_reg_offset)
+{
+	uint32_t mc_umc_addr;
+	uint64_t reg_value;
+
+	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1)
+		dev_info(adev->dev, "Deferred error, no user action is needed.\n");
+
+	if (mc_umc_status)
+		dev_info(adev->dev, "MCA STATUS 0x%llx, umc_reg_offset 0x%x\n", mc_umc_status, umc_reg_offset);
+
+	/* print IPID registers value */
+	mc_umc_addr =
+		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_IPIDT0);
+	reg_value = RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
+	if (reg_value)
+		dev_info(adev->dev, "MCA IPID 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
+
+	/* print SYND registers value */
+	mc_umc_addr =
+		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_SYNDT0);
+	reg_value = RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
+	if (reg_value)
+		dev_info(adev->dev, "MCA SYND 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
+
+	/* print MISC0 registers value */
+	mc_umc_addr =
+		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_MISC0T0);
+	reg_value = RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
+	if (reg_value)
+		dev_info(adev->dev, "MCA MISC0 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
+}
+
 static void umc_v6_7_ecc_info_query_correctable_error_count(struct amdgpu_device *adev,
 						   uint32_t umc_inst, uint32_t ch_inst,
 						   unsigned long *error_count)
 {
 	uint64_t mc_umc_status;
 	uint32_t eccinfo_table_idx;
+	uint32_t umc_reg_offset;
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
+		umc_query_error_status_helper(adev, mc_umc_status, umc_reg_offset);
+	}
 }
 
 static void umc_v6_7_ecc_info_querry_uncorrectable_error_count(struct amdgpu_device *adev,
@@ -88,8 +129,6 @@ static void umc_v6_7_ecc_info_querry_uncorrectable_error_count(struct amdgpu_dev
 	uint64_t mc_umc_status;
 	uint32_t eccinfo_table_idx;
 	uint32_t umc_reg_offset;
-	uint32_t mc_umc_addr;
-	uint64_t reg_value;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
 	umc_reg_offset = get_umc_v6_7_reg_offset(adev,
@@ -106,32 +145,7 @@ static void umc_v6_7_ecc_info_querry_uncorrectable_error_count(struct amdgpu_dev
 	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) == 1)) {
 		*error_count += 1;
 
-		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1)
-			dev_info(adev->dev, "Deferred error, no user action is needed.\n");
-
-		if (mc_umc_status)
-			dev_info(adev->dev, "MCA STATUS 0x%llx, umc_reg_offset 0x%x\n", mc_umc_status, umc_reg_offset);
-
-		/* print IPID registers value */
-		mc_umc_addr =
-			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_IPIDT0);
-		reg_value = RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
-		if (reg_value)
-			dev_info(adev->dev, "MCA IPID 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
-
-		/* print SYND registers value */
-		mc_umc_addr =
-			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_SYNDT0);
-		reg_value = RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
-		if (reg_value)
-			dev_info(adev->dev, "MCA SYND 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
-
-		/* print MISC0 registers value */
-		mc_umc_addr =
-			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_MISC0T0);
-		reg_value = RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
-		if (reg_value)
-			dev_info(adev->dev, "MCA MISC0 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
+		umc_query_error_status_helper(adev, mc_umc_status, umc_reg_offset);
 	}
 }
 
@@ -277,8 +291,11 @@ static void umc_v6_7_query_correctable_error_count(struct amdgpu_device *adev,
 	  MCUMC_STATUS is a 64 bit register */
 	mc_umc_status = RREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4);
 	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1) {
 		*error_count += 1;
+
+		umc_query_error_status_helper(adev, mc_umc_status, umc_reg_offset);
+	}
 }
 
 static void umc_v6_7_querry_uncorrectable_error_count(struct amdgpu_device *adev,
@@ -287,8 +304,6 @@ static void umc_v6_7_querry_uncorrectable_error_count(struct amdgpu_device *adev
 {
 	uint64_t mc_umc_status;
 	uint32_t mc_umc_status_addr;
-	uint32_t mc_umc_addr;
-	uint64_t reg_value;
 
 	mc_umc_status_addr =
 		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
@@ -303,32 +318,7 @@ static void umc_v6_7_querry_uncorrectable_error_count(struct amdgpu_device *adev
 	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) == 1)) {
 		*error_count += 1;
 
-		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1)
-			dev_info(adev->dev, "Deferred error, no user action is needed.\n");
-
-		if (mc_umc_status)
-			dev_info(adev->dev, "MCA STATUS 0x%llx, umc_reg_offset 0x%x\n", mc_umc_status, umc_reg_offset);
-
-		/* print IPID registers value */
-		mc_umc_addr =
-			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_IPIDT0);
-		reg_value = RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
-		if (reg_value)
-			dev_info(adev->dev, "MCA IPID 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
-
-		/* print SYND registers value */
-		mc_umc_addr =
-			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_SYNDT0);
-		reg_value = RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
-		if (reg_value)
-			dev_info(adev->dev, "MCA SYND 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
-
-		/* print MISC0 registers value */
-		mc_umc_addr =
-			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_MISC0T0);
-		reg_value = RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
-		if (reg_value)
-			dev_info(adev->dev, "MCA MISC0 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
+		umc_query_error_status_helper(adev, mc_umc_status, umc_reg_offset);
 	}
 }
 
-- 
2.17.1

