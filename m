Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29396C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 06:12:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C54EC10ECCF;
	Thu, 10 Mar 2022 06:12:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C987610ECD1
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 06:12:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7fGHxNGzwblMuXp/tTuA2YbKLWBQNZu4QrBXYFAP1//sQeJcDmKAfcgykJeAGsj2+AF7MdsaOVQS8rInDQGEA1J2Wj2Hrnce5BCuNCKnjkDCrNgq4TzgbUZsfIvtMa0R3OF+gX2Qo+E0XcA4/rC0AGcBks9uVUA/jSIi7pT5N8yY/cDtCro8+B3IzHmj06KFTWwkdj3Rhi63jcaEItJWOBBU2FJgiZJds+ubx45z3FtyJXpwVMv6GxFlpvTfjTl7FLd6qrSqNd3zW5iUrPXlZ6Ra8Xbhmpt+1AzxjezoqoiMHjkucuAfJSb9uMbM6sdP2v3sEYrx6IrEQ95TeMsHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2TsVCR8kYH7dLrLj6+hyoJKAxVPZIKkOvrwwPJtd7M=;
 b=kEGZyYRFZ5B3HnH5EU7zWYcQldZwLvUvmE0A4q681tqmUdUAE1kMUmK7k5ZECrM36B5lgCNGHrQjJVEeFly6w1K7fKrcZZo+PjOvEKcaBBj69jBUn2JwR7XiOAF8qCErEdUflAWgH9QEckHyrdrkW4vvpeNSonZpURzPYHB6di2ZhXaq45J9qvJ51hm51Sgb/Ot3oKUaAyKkvCi+/HuP9wJaAsWLpJcVGhnwy7K7LWCuWtqE8YjDgGy6LO9UHNMcbu6CbZ114FiwaiVWgat1xhb6P2D4vLB9mmyrH10QSy/0QIACMOzr0JCdcvMe5BMdnaCdu8+81On7rdjSQj3TbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2TsVCR8kYH7dLrLj6+hyoJKAxVPZIKkOvrwwPJtd7M=;
 b=w3JPsXN7u1lkdlvcfgo2ysOzDBZh4hzvIe1bKBPv+NjygfAvyr+1nPRJcURZURsamYMs4GviE0TgJxJnCxH0v7Z620vZPYqe6jLiIJWnCVkLVrQHh0DXEl2cvuQdBM2rhetBunsjRl4KHcRhQzfST7uemcG1MCz47hvaih99Yp4=
Received: from BN9PR03CA0507.namprd03.prod.outlook.com (2603:10b6:408:130::32)
 by BL0PR12MB5010.namprd12.prod.outlook.com (2603:10b6:208:17c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Thu, 10 Mar
 2022 06:12:29 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::dd) by BN9PR03CA0507.outlook.office365.com
 (2603:10b6:408:130::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.20 via Frontend
 Transport; Thu, 10 Mar 2022 06:12:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Thu, 10 Mar 2022 06:12:28 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 00:12:27 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 9 Mar
 2022 22:12:27 -0800
Received: from victor-test02.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Thu, 10 Mar 2022 00:12:26 -0600
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: add vcn v3_0 soft reset
Date: Thu, 10 Mar 2022 14:11:55 +0800
Message-ID: <20220310061155.39292-5-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310061155.39292-1-Victor.Zhao@amd.com>
References: <20220310061155.39292-1-Victor.Zhao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eeae2181-4f1e-4e89-1d50-08da025cf440
X-MS-TrafficTypeDiagnostic: BL0PR12MB5010:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB5010253319D93ADBA5469C7CFA0B9@BL0PR12MB5010.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZCF9jj73zXIkqUicfuZaKHL+KCPfYXo/qx8+h8SLJa6rhEjYJiL+QFrNFA95aIzRzHgLVJUY/8LYXJdaNvLychEoj8FG030yIxzTnfLOEDgCYWMjVGl4Sn45sUoeUnO93VGAYxuV80btcdPIUhKRonUtnGzTOD7N2FyYWGvBArXibN5cpwTTgE64RmK5zs5Qajs+oR9p7fnv4hsS5L8aPz6MuACyg5TzA86dxTaB30lVPrS7sTi9psOQ2vJ0JH4tsakf0kcE/Ho+4lt2Mh+dQYDJcTRXjXjfriH/RvBV0aP3P0lmQ+j4LVKHMO0xXtuj3spxANE2BQ9n3hcHaKIn6RRgXz86N0Mv6/dj3G+g7ewtZ9UmA9bsfITP/xq0mz8GfJH69H3OgNOGL/tdXoq/7Q89ru/jovDzehNFWRahy7Fko2Iey5cLaBzczcFlkEbfTdPMZv4oilzNnfOM1HuBMYmyRncABoRm3M2eFYBtO+sd5uQzq81bD3FlXUJWmU44s2j3AFV5XDnta71D6VBQi07YIejRRYp4a3NJKFpbu+HmFWGTHfXe54coCDa9D8bjHoZT5/OZjQsSxSSZWEd2818EU6j2mZpkaLoRZBd70T2ENxnCJ3DHx0XO9isi4lKy3easORxN+9dCGqcrAPF5HFCnE2xxq5xUADdPt0Km6sk84csH6AMgV+V79d4I0+oOTSks0O34zSOsC1G2Rb90Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(40460700003)(5660300002)(70206006)(508600001)(1076003)(8676002)(4326008)(2616005)(356005)(36860700001)(81166007)(47076005)(70586007)(86362001)(336012)(6916009)(26005)(316002)(36756003)(426003)(54906003)(186003)(83380400001)(6666004)(7696005)(2906002)(8936002)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 06:12:28.3810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeae2181-4f1e-4e89-1d50-08da025cf440
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5010
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
Cc: emily.deng@amd.com, Victor Zhao <Victor.Zhao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add soft reset sequence for vcn v3_0

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 87 ++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index da11ceba0698..8c9b1b84384b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -2247,6 +2247,89 @@ static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev)
 	}
 }
 
+static bool vcn_v3_0_check_soft_reset(void *handle, struct amdgpu_job *job)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int i;
+
+	if (job) {
+		if (!strncmp(job->base.sched->name, "vcn", 3))
+			return true;
+		else
+			return false;
+	} else {
+		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+			uint32_t tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS);
+
+			if (tmp == 0xDEADBEEF)
+				continue;
+			else if (tmp & UVD_STATUS__BUSY)
+				return true;
+		}
+		return false;
+	}
+}
+
+static int vcn_v3_0_soft_reset(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	uint32_t tmp;
+	int i = 0;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		/* disable LMI UMC channel */
+		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
+		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
+		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
+
+		/* block VCPU register access */
+		tmp = RREG32_SOC15(VCN, i, mmUVD_RB_ARB_CTRL);
+		tmp |= UVD_RB_ARB_CTRL__VCPU_DIS_MASK;
+		WREG32_SOC15(VCN, i, mmUVD_RB_ARB_CTRL, tmp);
+
+		/* reset VCPU */
+		tmp = RREG32_SOC15(VCN, i, mmUVD_VCPU_CNTL);
+		tmp |= UVD_VCPU_CNTL__BLK_RST_MASK;
+		WREG32_SOC15(VCN, i, mmUVD_VCPU_CNTL, tmp);
+
+		/* disable VCPU clock */
+		tmp = RREG32_SOC15(VCN, i, mmUVD_VCPU_CNTL);
+		tmp &= ~(UVD_VCPU_CNTL__CLK_EN_MASK);
+		WREG32_SOC15(VCN, i, mmUVD_VCPU_CNTL, tmp);
+
+		/* apply soft reset */
+		tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
+		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+		WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
+		tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
+		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+		WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
+
+		tmp = RREG32_SOC15(VCN, i, mmUVD_VCPU_CNTL);
+		tmp |= UVD_VCPU_CNTL__BLK_RST_MASK;
+		WREG32_SOC15(VCN, i, mmUVD_VCPU_CNTL, tmp);
+
+		/* clear status */
+		WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
+
+		/* apply HW clock gating */
+		vcn_v3_0_enable_clock_gating(adev, i);
+
+		/* enable VCN power gating */
+		vcn_v3_0_enable_static_power_gating(adev, i);
+	}
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		/* disable VCN power gating */
+		vcn_v3_0_disable_static_power_gating(adev, i);
+
+		/*SW clock gating */
+		vcn_v3_0_disable_clock_gating(adev, i);
+	}
+
+	return 0;
+}
+
 static const struct amd_ip_funcs vcn_v3_0_ip_funcs = {
 	.name = "vcn_v3_0",
 	.early_init = vcn_v3_0_early_init,
@@ -2259,9 +2342,9 @@ static const struct amd_ip_funcs vcn_v3_0_ip_funcs = {
 	.resume = vcn_v3_0_resume,
 	.is_idle = vcn_v3_0_is_idle,
 	.wait_for_idle = vcn_v3_0_wait_for_idle,
-	.check_soft_reset = NULL,
+	.check_soft_reset = vcn_v3_0_check_soft_reset,
 	.pre_soft_reset = NULL,
-	.soft_reset = NULL,
+	.soft_reset = vcn_v3_0_soft_reset,
 	.post_soft_reset = NULL,
 	.set_clockgating_state = vcn_v3_0_set_clockgating_state,
 	.set_powergating_state = vcn_v3_0_set_powergating_state,
-- 
2.25.1

