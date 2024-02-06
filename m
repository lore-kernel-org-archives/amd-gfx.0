Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C696BC4828D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 20:07:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72730112DC9;
	Tue,  6 Feb 2024 20:07:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cWCZbUHa";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E46F112DC8
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 20:06:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZuJyteRVC+RG+BlhE8prHbQ10uVHzP3yAmkf+ZiKgbn17ZEZNj3XvcFXyDPTJzN5ey2YqzKp5Qq+6wBckgEbYANBMGnZjioLpdc1i0BIRP4oRpatvA/sgIsiFemmAjUun2lsjAsujB4s1q50w8V4QpSawnffC7ke7iIpWTGTGBLzcv7XznkOdyEyQwJeTcRM4XDhvcf/x9NC7YwcpJbjlb/qxja0VH+9T3id0yDZ6Dev3PnW63A2SqZNveueOuVccCbkezbxhHbcR3ST1RfLTOuFhZr8+vnWG+hIaIAXhpVC1Oo62aVAU6XEsXV5p1rO/UHleesRL6i2UiSpi4srw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQESB5erRYjiU5m9+ozopvaDdEE8xpPKr4CDobmfVkg=;
 b=D3MG/LBhgt0F8XLLeWfc/jstZmpWlYfLgD+KigNOtHqHfgPG+QttSrRr4U2mfICYE0x0R1kGoPOiCuWPkJRH1b7L9NrRE6udBNGwfnsE/C1PnpRW71hAoGMMTv73tg4TIe/fL7lsXx0bgkR9Cmf67NEe1iLqirK8m2U17uH9O4LI8E1tPNuETNasO17selvRQJTakauIzY/ltUfyDUfz3QEOMxi8bPlkl04mKt51XKzKHHoYOxV5h9YoOrCP3u3uOZl0GXegeNmHgel33qQKeOTft2vsT82F7XlM1D56wAKAbMSVOxovUrIF1whU6tIiv/BK5xUOZr3mZy5/grTU7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQESB5erRYjiU5m9+ozopvaDdEE8xpPKr4CDobmfVkg=;
 b=cWCZbUHaXifYsx/DdJC2gtak6ghz04qzOFUWRfGA9Of/WmcQ/SKc3a3XN0HjBU6Se/V4sqsLE8YWjJB1ixQncOjDHOjcuAkIxpMD1LPl4X5yzP3ye0xecgwRpSzfO0gfuWBB4F7N5gSnnVld3luZZSTi8zA7ahFEKxJ6iaKD4VY=
Received: from SN7PR04CA0208.namprd04.prod.outlook.com (2603:10b6:806:126::33)
 by PH7PR12MB8825.namprd12.prod.outlook.com (2603:10b6:510:26a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Tue, 6 Feb
 2024 20:06:56 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:126:cafe::77) by SN7PR04CA0208.outlook.office365.com
 (2603:10b6:806:126::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 20:06:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 20:06:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 14:06:53 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Kenneth Feng <kenneth.feng@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/swsmu: add judgement for vcn jpeg dpm set
Date: Tue, 6 Feb 2024 15:06:37 -0500
Message-ID: <20240206200639.1670753-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240206200639.1670753-1-alexander.deucher@amd.com>
References: <20240206200639.1670753-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|PH7PR12MB8825:EE_
X-MS-Office365-Filtering-Correlation-Id: c29b759d-450e-469f-7caf-08dc274f2b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EZEGtDyGP47aR6rMygibZjU1G/cUkC90veJuGCF7D5Iz813j44MatnC387vzXq14oDbFH61NZ8k1izaLs+pqeS6ME2rIC789PxzGAlxhJEXGi2NS3QMIzBG0ZzD8NhgBImC3oaoJAo19HtGWSxIcCEhRMm5pI5PfDPFYWnGzZRW1j6tjZILdkpVLR51KrjzHGRVQDeVo1VjA1Tf3m6tDbJcpen0xzqTgakirDhnOBsjhzX0K855scAnTnIa+zfoUokpAxJvNVUNjAnL3mNtamY4vW0L171a1wvUKG+foU+3oPo3V0Sql9mGf+YgPqb3SOLqMv27dfhviPv0OWvVJ8n8BfbLSrgTh1ZZUgvkRbwYYc9KEbXDsR3Yzut7zxCIT7SHksXXL1G7D9/Yq8KllWBOQVmC+s6rz4QO959aBT8nwniIRz/Paxsu6uYxVGmbB1bRnvD09FCvVrs68a2FJdxjMQslArhodgqeOUWAPeG8MzVMTQ7Q3iymTrEg0qK69Aw29EY5TZHI73pk8Bxbi8Nl6x2Gw2HISKPE7qf4BoMp+HuQca9cg0Qt6sfL4UTMCQvCY4G0FleaP/BBwmL7f909u7qf/SvBK25MAEo0ga+wtDzuNW+ZhJZjVVypw8QlckJ512/V3BA4RA1vbpMJ6UHWK4DMvxmLqvl+0ryzo+7emBYb+DUVVVEV6Y0y0sWBgXCHTO7JedR2m0WohB7JlP5B0BV0ZVBe2Fb5MCHIdYUuu09r6VATCF1D1ahJxIkDzqWvxCieGCqSoK8H3oVwBvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(186009)(451199024)(82310400011)(1800799012)(64100799003)(46966006)(36840700001)(40470700004)(36756003)(5660300002)(2906002)(41300700001)(86362001)(1076003)(426003)(336012)(2616005)(83380400001)(47076005)(16526019)(26005)(36860700001)(40480700001)(478600001)(7696005)(40460700003)(6666004)(81166007)(82740400003)(356005)(70586007)(8936002)(4326008)(6916009)(316002)(70206006)(54906003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 20:06:55.9509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c29b759d-450e-469f-7caf-08dc274f2b2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8825
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Only enable VCN/JPEG dpm when VCN/JPEG PG flag was set
when smu set dpm table.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 30 +++++++++++++++--------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 0ad947df777a..3d72c945cf56 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -751,6 +751,7 @@ static int smu_early_init(void *handle)
 
 static int smu_set_default_dpm_table(struct smu_context *smu)
 {
+	struct amdgpu_device *adev = smu->adev;
 	struct smu_power_context *smu_power = &smu->smu_power;
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
 	int vcn_gate, jpeg_gate;
@@ -759,25 +760,34 @@ static int smu_set_default_dpm_table(struct smu_context *smu)
 	if (!smu->ppt_funcs->set_default_dpm_table)
 		return 0;
 
-	vcn_gate = atomic_read(&power_gate->vcn_gated);
-	jpeg_gate = atomic_read(&power_gate->jpeg_gated);
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN)
+		vcn_gate = atomic_read(&power_gate->vcn_gated);
+	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG)
+		jpeg_gate = atomic_read(&power_gate->jpeg_gated);
 
-	ret = smu_dpm_set_vcn_enable(smu, true);
-	if (ret)
-		return ret;
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
+		ret = smu_dpm_set_vcn_enable(smu, true);
+		if (ret)
+			return ret;
+	}
 
-	ret = smu_dpm_set_jpeg_enable(smu, true);
-	if (ret)
-		goto err_out;
+	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG) {
+		ret = smu_dpm_set_jpeg_enable(smu, true);
+		if (ret)
+			goto err_out;
+	}
 
 	ret = smu->ppt_funcs->set_default_dpm_table(smu);
 	if (ret)
 		dev_err(smu->adev->dev,
 			"Failed to setup default dpm clock tables!\n");
 
-	smu_dpm_set_jpeg_enable(smu, !jpeg_gate);
+	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG)
+		smu_dpm_set_jpeg_enable(smu, !jpeg_gate);
 err_out:
-	smu_dpm_set_vcn_enable(smu, !vcn_gate);
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN)
+		smu_dpm_set_vcn_enable(smu, !vcn_gate);
+
 	return ret;
 }
 
-- 
2.42.0

