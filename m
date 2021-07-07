Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD21EC07E9B
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 01:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7603361A3E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 01:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7603361A3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 353EF6E804;
	Wed,  7 Jul 2021 01:59:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0EE16E808
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 01:59:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpC47VKs9n96vTBMCoG7DcyMefSr8ApvcPQ5nVjZ7UZjUvmkEzhggj6pwmGo7slnln8hkpv6oCPieMRhzL9CmC//BbbanWDz773lJ47JXnBZM26Cfx+uhkBz1nqYw0LQx8qz5qCgnJUINlTE7Gx1sCU8MU+hWtqihixeGpDtctaembSqoy89BsdW1sSImPjhLu1fRe0h5oz7WgdcDCo8neIzpCDl2VjCOkQxzheK4KSpROQFoIv3rfa8TOJLrZsSr/70lHVmZf2mtFwkE0wLx1O/fXozVT3o0PfCpsw+H8NMsEtKyyJxu5sc+gQ3G55MdJkWp+SCNp/hWetEJWJkjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSZYnVNBJH4j5CGrl5pVf95nGKuYmZOxg1h4PXYKMIc=;
 b=X5BbM8q68D9X7BVaZxgSnVfvhjBQCn6U8F+RLRQ6hrpATd9k+tSLt4DNxJFbnnXf95xhLu3IY5Z4KPadrje3+dZ1IAhAa4vywrDveTzuSl6jh1c5y4vXFzHRv+rgkCOs17Dls92NSuMScoLA9CpkyaXSIQyjAtzzoc57YclxDsisxB+4A1720uQSqoKi/mkGLRt7vjG2k3mpkOIi6zfD0kC2cEqp0g3V6Bfne/BNhFBGzM6bnjDscF8Io37/0Zi4tpAy98vb4Y90WMhhb+KkD+tQbSombHPmFCZOqZnbjjmG7ysRy0Ey+RwyXmrF5itoAv1KYOz9U1ypEREIpQfeaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSZYnVNBJH4j5CGrl5pVf95nGKuYmZOxg1h4PXYKMIc=;
 b=UZqpni7nEE7i7YyzfXkAqibERZmRTHN4inZ/4dKnM2qp0m2dmaZ8/zzlo/XuKCdYnZoISFMXOMyoT739lkOPcQNH0L+fhVlCTNTEJ/6SoMqKW4lUVmgzwgHtb8bnx/zXqZH9hvno89Vkr7qZWUCBFWQlafMtxIpmyYZpAPu4jgw=
Received: from DM5PR2201CA0008.namprd22.prod.outlook.com (2603:10b6:4:14::18)
 by BN6PR12MB1380.namprd12.prod.outlook.com (2603:10b6:404:1f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.32; Wed, 7 Jul
 2021 01:59:34 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::38) by DM5PR2201CA0008.outlook.office365.com
 (2603:10b6:4:14::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend
 Transport; Wed, 7 Jul 2021 01:59:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Wed, 7 Jul 2021 01:59:33 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 6 Jul 2021
 20:59:32 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/7] drm/amd/pm: correct the address of Arcturus fan related
 registers
Date: Wed, 7 Jul 2021 09:56:47 +0800
Message-ID: <20210707015647.139127-7-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210707015647.139127-1-evan.quan@amd.com>
References: <20210707015647.139127-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90b2c097-44be-4648-1685-08d940eadde4
X-MS-TrafficTypeDiagnostic: BN6PR12MB1380:
X-Microsoft-Antispam-PRVS: <BN6PR12MB13802B9FB7280312D63B76E1E41A9@BN6PR12MB1380.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wdCZLw65o6HpYVvRVRrcz/9VHBcN8colLTgggDJi1/GrRq10ukiRJZmXXnCtACqP2YSKo85va0vTHe0eahhyfYnLrK/3K6HZf9HFZ/bwNNlqYm4/WVuNMQylKu0f0Yr4869n2OUn3yQ2hSNq2rABeu3NVoHDbWuWCDXrG2/glVQBMBveMGDga9vY/RbiigyX0JjneVEumK+1avufguj3X5EETIhACr1zUbVohLGYO0eTkFb+FTyBHt3v7nuJvnYqM/eiTxK3fsx+xyMDshzTp3zPOh41TnXokSq9q7m5fVPtABK+jQpkmJzPwU8Lxwk45dCXeAXZXbUr+LzS3TUwJhJqbe22Rm/VCVEfGVDSeFabcGG71tanYuWsVtZ+R652NFdFOlINPHPcH54VZl+yNdlqTF4TAxqWPU55VDVsNBELquphdfbtSgbTgMiZgCyT/VyYt/CX9zR48XzF8lrQJ0fmroHYFu5i2pFseejwLh9vcQAKfHL0u2iHiiIQCppXXS3/I4WkkGFWJ8c/WJsEXhoIqToujJLKb7rMZ67Dy4/lw58261JIaE00+y//+sNG6CZUqN3IPgCtwgR9cwgWqywYhxnho2PEmhRnpkIcSLnSFJqDLgamAlo9CSrv8egbxdtKza7WlYwE/sttCOKyY6a0hroD9QJmd2sKwUb8sIJ1tX2EQzozwAR7eyUuGiAO9ouhxx7/JPBIGRcRrfMVBPS97w8pv/9EzIjCdkXwmjU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(36840700001)(46966006)(186003)(82310400003)(478600001)(316002)(83380400001)(86362001)(2616005)(54906003)(36860700001)(82740400003)(426003)(336012)(44832011)(6666004)(8936002)(2906002)(7696005)(5660300002)(6916009)(4326008)(1076003)(26005)(8676002)(70586007)(70206006)(356005)(16526019)(47076005)(36756003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 01:59:33.7804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b2c097-44be-4648-1685-08d940eadde4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1380
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These registers have different address from other SMU V11 ASICs.

Change-Id: Iaeb0438331eed9b0313933da25622f8e4c048fab
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 104 +++++++++++++-----
 1 file changed, 78 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 319bd7689df4..414c8674e32f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -79,6 +79,24 @@ MODULE_FIRMWARE("amdgpu/beige_goby_smc.bin");
 #define mmTHM_BACO_CNTL_ARCT			0xA7
 #define mmTHM_BACO_CNTL_ARCT_BASE_IDX		0
 
+#define mmCG_FDO_CTRL0_ARCT			0x8B
+#define mmCG_FDO_CTRL0_ARCT_BASE_IDX		0
+
+#define mmCG_FDO_CTRL1_ARCT			0x8C
+#define mmCG_FDO_CTRL1_ARCT_BASE_IDX		0
+
+#define mmCG_FDO_CTRL2_ARCT			0x8D
+#define mmCG_FDO_CTRL2_ARCT_BASE_IDX		0
+
+#define mmCG_TACH_CTRL_ARCT			0x8E
+#define mmCG_TACH_CTRL_ARCT_BASE_IDX		0
+
+#define mmCG_TACH_STATUS_ARCT			0x8F
+#define mmCG_TACH_STATUS_ARCT_BASE_IDX		0
+
+#define mmCG_THERMAL_STATUS_ARCT		0x90
+#define mmCG_THERMAL_STATUS_ARCT_BASE_IDX	0
+
 int smu_v11_0_init_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -1174,12 +1192,21 @@ smu_v11_0_set_fan_static_mode(struct smu_context *smu, uint32_t mode)
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	WREG32_SOC15(THM, 0, mmCG_FDO_CTRL2,
-		     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2),
-				   CG_FDO_CTRL2, TMIN, 0));
-	WREG32_SOC15(THM, 0, mmCG_FDO_CTRL2,
-		     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2),
-				   CG_FDO_CTRL2, FDO_PWM_MODE, mode));
+	if (adev->asic_type == CHIP_ARCTURUS) {
+		WREG32_SOC15(THM, 0, mmCG_FDO_CTRL2_ARCT,
+			     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2_ARCT),
+					   CG_FDO_CTRL2, TMIN, 0));
+		WREG32_SOC15(THM, 0, mmCG_FDO_CTRL2_ARCT,
+			     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2_ARCT),
+					   CG_FDO_CTRL2, FDO_PWM_MODE, mode));
+	} else {
+		WREG32_SOC15(THM, 0, mmCG_FDO_CTRL2,
+			     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2),
+					   CG_FDO_CTRL2, TMIN, 0));
+		WREG32_SOC15(THM, 0, mmCG_FDO_CTRL2,
+			     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2),
+					   CG_FDO_CTRL2, FDO_PWM_MODE, mode));
+	}
 
 	return 0;
 }
@@ -1194,8 +1221,12 @@ smu_v11_0_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
 	if (speed > 255)
 		speed = 255;
 
-	duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
-				CG_FDO_CTRL1, FMAX_DUTY100);
+	if (adev->asic_type == CHIP_ARCTURUS)
+		duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1_ARCT),
+					CG_FDO_CTRL1, FMAX_DUTY100);
+	else
+		duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
+					CG_FDO_CTRL1, FMAX_DUTY100);
 	if (!duty100)
 		return -EINVAL;
 
@@ -1203,9 +1234,14 @@ smu_v11_0_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
 	do_div(tmp64, 255);
 	duty = (uint32_t)tmp64;
 
-	WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,
-		     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL0),
-				   CG_FDO_CTRL0, FDO_STATIC_DUTY, duty));
+	if (adev->asic_type == CHIP_ARCTURUS)
+		WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0_ARCT,
+			     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL0_ARCT),
+					   CG_FDO_CTRL0, FDO_STATIC_DUTY, duty));
+	else
+		WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,
+			     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL0),
+					   CG_FDO_CTRL0, FDO_STATIC_DUTY, duty));
 
 	return smu_v11_0_set_fan_static_mode(smu, FDO_PWM_MODE_STATIC);
 }
@@ -1214,13 +1250,14 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
 				uint32_t speed)
 {
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t tach_period, crystal_clock_freq;
-
 	/*
 	 * crystal_clock_freq div by 4 is required since the fan control
 	 * module refers to 25MHz
+	 * crystal_clock_freq used for fan speed rpm calculation is
+	 * always 25Mhz. So, hardcode it as 2500(in 10K unit).
 	 */
-	crystal_clock_freq = amdgpu_asic_get_xclk(adev) / 4;
+	uint32_t crystal_clock_freq = 2500;
+	uint32_t tach_period;
 
 	/*
 	 * To prevent from possible overheat, some ASICs may have requirement
@@ -1231,10 +1268,16 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
 	 *   lower than 500 RPM.
 	 */
 	tach_period = 60 * crystal_clock_freq * 10000 / (8 * speed);
-	WREG32_SOC15(THM, 0, mmCG_TACH_CTRL,
-		     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_TACH_CTRL),
-				   CG_TACH_CTRL, TARGET_PERIOD,
-				   tach_period));
+	if (adev->asic_type == CHIP_ARCTURUS)
+		WREG32_SOC15(THM, 0, mmCG_TACH_CTRL_ARCT,
+			     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_TACH_CTRL_ARCT),
+					   CG_TACH_CTRL, TARGET_PERIOD,
+					   tach_period));
+	else
+		WREG32_SOC15(THM, 0, mmCG_TACH_CTRL,
+			     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_TACH_CTRL),
+					   CG_TACH_CTRL, TARGET_PERIOD,
+					   tach_period));
 
 	return smu_v11_0_set_fan_static_mode(smu, FDO_PWM_MODE_STATIC_RPM);
 }
@@ -1257,10 +1300,17 @@ int smu_v11_0_get_fan_speed_percent(struct smu_context *smu,
 		return 0;
 	}
 
-	duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
-				CG_FDO_CTRL1, FMAX_DUTY100);
-	duty = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_THERMAL_STATUS),
-				CG_THERMAL_STATUS, FDO_PWM_DUTY);
+	if (adev->asic_type == CHIP_ARCTURUS) {
+		duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1_ARCT),
+					CG_FDO_CTRL1, FMAX_DUTY100);
+		duty = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_THERMAL_STATUS_ARCT),
+					CG_THERMAL_STATUS, FDO_PWM_DUTY);
+	} else {
+		duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
+					CG_FDO_CTRL1, FMAX_DUTY100);
+		duty = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_THERMAL_STATUS),
+					CG_THERMAL_STATUS, FDO_PWM_DUTY);
+	}
 	if (!duty100)
 		return -EINVAL;
 
@@ -1278,7 +1328,8 @@ int smu_v11_0_get_fan_speed_rpm(struct smu_context *smu,
 				uint32_t *speed)
 {
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t tach_status, crystal_clock_freq;
+	uint32_t crystal_clock_freq = 2500;
+	uint32_t tach_status;
 	uint64_t tmp64;
 
 	/*
@@ -1292,10 +1343,11 @@ int smu_v11_0_get_fan_speed_rpm(struct smu_context *smu,
 		return 0;
 	}
 
-	crystal_clock_freq = amdgpu_asic_get_xclk(adev) / 4;
 	tmp64 = (uint64_t)crystal_clock_freq * 60 * 10000;
-
-	tach_status = RREG32_SOC15(THM, 0, mmCG_TACH_STATUS);
+	if (adev->asic_type == CHIP_ARCTURUS)
+		tach_status = RREG32_SOC15(THM, 0, mmCG_TACH_STATUS_ARCT);
+	else
+		tach_status = RREG32_SOC15(THM, 0, mmCG_TACH_STATUS);
 	do_div(tmp64, tach_status);
 	*speed = (uint32_t)tmp64;
 
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
