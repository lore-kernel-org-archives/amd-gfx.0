Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D51C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 30 May 2022 06:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E43D10F09C;
	Mon, 30 May 2022 06:51:04 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2040.outbound.protection.outlook.com [40.107.102.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56AF610F09C
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 06:51:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uyrr71JAvhlehz/Lk1ZAqBSCgggGqN5z0uNwM0iGGpHvVv40+J7qMLCZ/rRTMMs8p3JzZ2LeoqhcUXFCsUq73hkYK0+Ndh3Yd8ih+qk5EB8X8tv2FvFHLJBppgZ9HpDl8qCAK1VuKO5iWTPpUGTdWe/CNQzci2wBvon/BpiRkMOUZvyCmlHY0lhxjLxN3n7stqaNr/iLqFxBCbSqyR2Bgqmm8jc3Nqi8Ifos0aNyTFvexmaGZhLnRpuVZ33PPp8Q8dxisQAB+opsv+3/kl6IiF+VlVtAliEXPmAyF8AAGrqKlUR6v3Ym1bSbBawgq2M1rV9X6o7UKOR1oVo56pHbDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLr4eswYzDR60LcybLDah0UqWGQvrTRDgz5WCl+vyz8=;
 b=X8c3SMcWtRiLXUyUhQO5PWhRb5tw3b8YJK5V5VhIuXmy6+X9wN9CHNOXZWhM148NUupZcElqKLsqtIt5fTEzIKdvvfYV0xX28dg1X0XuA+3VDf+ZsmtDPSG17+Kw5AtdZAOr5i2NbnDH0rPWyx3DZTnWv4nuxW1B19nEnBywPIXPUkT2S7SFXYs+52FH66pFUev4euDxBGFgQX3DOAqmhLlMaLB04nBp1tgd8eVrao5P0mwZI9iJaBMM7GLGajPLstip+kiqZVEUMjvECoVfwLmTa2qVUc9IhGEij9GV9ZyKA6+tONoy2ayHDTHMBpDKnfLMV/luQXDpSgW5nSgRtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLr4eswYzDR60LcybLDah0UqWGQvrTRDgz5WCl+vyz8=;
 b=OEaA4W8XHe0pgMxppjaVtsiy9F6DHPxRx4Vv9/nRwuXD+ieFN2awhqI62NsFX1UD5E90BhzjhwUnuaPL3KXLNBX/0KarQdCckTHT5mkRlV07pgyw6QYuhTZkh8tId9vvN2tpoZnSiXU4rX+WaF08gW+lQghQGZ+1AdnyQ8r7e2o=
Received: from DM5PR22CA0008.namprd22.prod.outlook.com (2603:10b6:3:101::18)
 by DM5PR12MB1673.namprd12.prod.outlook.com (2603:10b6:4:e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.15; Mon, 30 May 2022 06:50:57 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::63) by DM5PR22CA0008.outlook.office365.com
 (2603:10b6:3:101::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19 via Frontend
 Transport; Mon, 30 May 2022 06:50:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Mon, 30 May 2022 06:50:57 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 30 May
 2022 01:50:51 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: suppress compile warnings
Date: Mon, 30 May 2022 14:50:32 +0800
Message-ID: <20220530065032.677498-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7f4b60f-2ae0-49ea-c418-08da4208c02a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1673:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB16730FF076F7B165DB31F6B2E4DD9@DM5PR12MB1673.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q+HQqZ5HHTY+RHZGWnoPGTNE2LJDTq0BOk3Xnvb+ixi30iMe+BVuTrEGTqUvhEHdD0pwhaqbDFcyaZ+CWW8oCoFhH/QH3K0hDr7nyVdnMsKbMhZoBrjjxtDIrxr2zZIAhq3+3UHYkuukmCYNb9gIfgcVPWq8dyxShvQQA3KBjq/IV+j6JQS2pAf41ulCWRgKqtHXHvaH0sgwvwEvUB7Vq2mwW5VX+JctABgAQYv9dOsZRvGvqtDV+d+RGuaFFcEFUFDJ9r8ov/pC+5086k8C2iT97cPtOJoRAaPo57qCUfhGDqGMFWti4FGhk9gANEUHUkwrdd5Ih8Fdl0VxLIUflqv8KPm+S1vDmmelpjgHifHQwVCJsUOL0tIzqBwLZMBSZGFcx0XLvf+OdW0dO1/07EQpy2NkmaEK+LInJjH5pYhdQqFnSbxExdSX4WAd71pOQk/3/FJIR6f7j8hfoq2iwQffUzLirDa7zbJ0fzga8UdT5zVEJpzq4mGs9T1l/KkQ77DVAsyN0eD7iwVsXhxZkeld0kHWXrQmmPbBay9KZC8XibP23gMDFDvnh27xneOcE9P+1HrX2kGucmUtL4S/iGmJ0Do52+pjMzKuGJcvbc89S5F3wBxxTJb1IOK6TQaEJB7P6Hj0GMf93DRnvhMHQxWoGxkVuJyCqMYEW9oEUEtS+lPmES+UE8W4745jh6+4CODBpX842qplQuKlROV4sQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(508600001)(40460700003)(6666004)(356005)(8676002)(26005)(86362001)(7696005)(4326008)(44832011)(6916009)(316002)(5660300002)(54906003)(83380400001)(36756003)(36860700001)(16526019)(8936002)(2906002)(336012)(426003)(186003)(82310400005)(1076003)(2616005)(70586007)(70206006)(81166007)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 06:50:57.6452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f4b60f-2ae0-49ea-c418-08da4208c02a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1673
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Suppress the compile warnings below:

drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_7_ppt.c:1407:12: warning:
stack frame size (1040) exceeds limit (1024) in 'smu_v13_0_7_get_power_profile_mode' [-Wframe-larger-than]
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:1986:6: warning:
no previous prototype for function 'gfx_v11_0_rlc_stop' [-Wmissing-prototypes]

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I679436c91cb98afb9fcbef8942fd90a17e5234b5
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c               |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 8c0a3fc7aaa6..cb581cfc7464 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1983,7 +1983,7 @@ static int gfx_v11_0_init_csb(struct amdgpu_device *adev)
 	return 0;
 }
 
-void gfx_v11_0_rlc_stop(struct amdgpu_device *adev)
+static void gfx_v11_0_rlc_stop(struct amdgpu_device *adev)
 {
 	u32 tmp = RREG32_SOC15(GC, 0, regRLC_CNTL);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 4e1861fb2c6a..8fd7652ae883 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1406,7 +1406,7 @@ static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
 
 static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf)
 {
-	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external[PP_SMC_POWER_PROFILE_COUNT];
+	DpmActivityMonitorCoeffIntExternal_t *activity_monitor_external;
 	uint32_t i, j, size = 0;
 	int16_t workload_type = 0;
 	int result = 0;
@@ -1414,6 +1414,11 @@ static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf
 	if (!buf)
 		return -EINVAL;
 
+	activity_monitor_external = kzalloc(sizeof(DpmActivityMonitorCoeffIntExternal_t) * PP_SMC_POWER_PROFILE_COUNT,
+					    GFP_KERNEL);
+	if (!activity_monitor_external)
+		return -ENOMEM;
+
 	size += sysfs_emit_at(buf, size, "                              ");
 	for (i = 0; i <= PP_SMC_POWER_PROFILE_WINDOW3D; i++)
 		size += sysfs_emit_at(buf, size, "%-14s%s", amdgpu_pp_profile_name[i],
@@ -1426,14 +1431,17 @@ static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf
 		workload_type = smu_cmn_to_asic_specific_index(smu,
 							       CMN2ASIC_MAPPING_WORKLOAD,
 							       i);
-		if (workload_type < 0)
+		if (workload_type < 0) {
+			kfree(activity_monitor_external);
 			return -EINVAL;
+		}
 
 		result = smu_cmn_update_table(smu,
 					  SMU_TABLE_ACTIVITY_MONITOR_COEFF, workload_type,
 					  (void *)(&activity_monitor_external[i]), false);
 		if (result) {
 			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+			kfree(activity_monitor_external);
 			return result;
 		}
 	}
-- 
2.29.0

