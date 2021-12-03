Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32173C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 03:06:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AADC86EC0A;
	Fri,  3 Dec 2021 03:06:35 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2059.outbound.protection.outlook.com [40.107.96.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 252A66EBAC
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 03:06:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBULRskF1+ASyl1iTIR53Xjx+laXUeoe2EGRKevo14kfxiWeNVAxllkEO348jW2GSFy/z3PtvL/gDwEkfKJaps7tu42nWSd+2oAd+Mse2GNMTreMxGWm8/fsrvTdpJXhbXQ8/Ax/BK2+06dwtVj2yVxyfwwy/xfRDkcmuZHR4gfQIdinWzxOAjrpn+a0zor9UkBNT9SqcZGu6dC50fc68rB81QC85CulFocRoKWMDSScDklM72MCvIkUUML1cSyumQU1StnWoTra6fPYyzjsDmpM4il2KHhtGdQkkHVq0ibDWEGLKY6ENZMxrld/U7rc3RhuQGJDSje8laid0/oB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pypR1+vuPSp42o3+eIHIcEbEAXWpRUWqFeHzvJV+XO0=;
 b=EvRIRH+aMXm6w6t9QdzDFP7YJMEXVN3njqklHL+gzD5jVob2fPo2+v2dSjkEJT2lxhmeD22sOQHoXZYI0YpWXZEjNapFAwd6ACPq9eHiN5b4pBt0kTEv3Pk0uVjTc0Hzo2MNuzHN3vCwLLw+ngDTPeQNi9sgo5A8ajfQPss6o9LV9xyJgCLtw76uaueRUUkLfTXCLNLXsXQ1V+KfNa1Kf6XSG1KCpJAEfL30O9YjSn8d5hVb1iVu/lXYVksmYmCg+uqoIWxOjgUUBIybHCi71Cr4i7+BlwPaHDG8EWj5v2pupCBTrkVUYvlJa6dXO6CXC81eaDxAVmSneZ6rF/sN/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pypR1+vuPSp42o3+eIHIcEbEAXWpRUWqFeHzvJV+XO0=;
 b=nKz606xhK8NGFswhcAuiZ8fioYxra4tWytbBlacLyN7XgKEYe7/+frmas1I8vGYFy9YBgHxW4Gnh1C2CSG6QbAvk9J6x3fkkZW/TYxX5cdMU84FwMhSiw/gO6v81rEslG/MaE+vJAKAnW6qf/dnso9B3m31r35tFAxRX8qb63iw=
Received: from MW4PR03CA0086.namprd03.prod.outlook.com (2603:10b6:303:b6::31)
 by BY5PR12MB4903.namprd12.prod.outlook.com (2603:10b6:a03:1d6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 03:06:31 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::6f) by MW4PR03CA0086.outlook.office365.com
 (2603:10b6:303:b6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend
 Transport; Fri, 3 Dec 2021 03:06:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 03:06:31 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 2 Dec
 2021 21:06:28 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V4 15/17] drm/amd/pm: drop unnecessary gfxoff controls
Date: Fri, 3 Dec 2021 11:05:38 +0800
Message-ID: <20211203030540.1710564-15-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211203030540.1710564-1-evan.quan@amd.com>
References: <20211203030540.1710564-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 194a027b-0c02-4f25-d6bb-08d9b609e80a
X-MS-TrafficTypeDiagnostic: BY5PR12MB4903:
X-Microsoft-Antispam-PRVS: <BY5PR12MB490319231968E0B0F4A0E5E4E46A9@BY5PR12MB4903.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6MmaMGaGLtv1/F2/WwvqV9k+tRyqTe7t/N3lGYkX6Psdu7NXxjhOauQro/jmVAO6l7sUBXo8W/DQP81JkaADrfG4qzv70atnagTQcLQ7YTCs4b7nSrR2UCqIdtZThxBg2P1vTk0IvGFtqCRnaon0iYTTeQULaw63xm3TJkBQXqkIbQOPmXp7EsFJ2tHBVpjFsWEH1/k5qlU0rxTzZ5HBWKbzeZvEdRmy8RuVdNy3bw4zJZsTEEVcMdUBjU40D3n5HbkhuZTOtPU6idSIbLmTuSg64MWF76hcIT1H2mepAfBC4t6EN4Ei0XsKzr+8M9AHXDSpqH9Op9A+j2g7AIuLQng9rEZq1bzJrEd/hBXfnj5wyBG1B7VC+RD5sO5wiz1JS/rsK0bOc0IDZzHv/9CjJc5Lh8Eo+Mxl4HXbOuvdy9K8SCc0s741DqdeV1yI8IBwhc2j4MgjjqnkqZ7boS/wFTxufEXzhvScoT+waQVG9uWo6KUkzNwcXM5R/fW69szF+4X8qz4qLjjKc2iBAdUFQGrzAha0EnUcFTUhi+QBZ66UDXPgD3aQ325TMk5PWNkFDlnSsxopXoW7BaX+BK/258LdyA4Hhvu8+ZcHLFndu2naYN1QfHFWqXDdQ67pZ0AS4Bj3pbWlkQwyLUSuybP3PS70OJS2TUvemfEoPgHtJ6BS5ENZvTiles6cerqzWACHGeyhUqGQ0tW9MDDC6F8/BhI9/R0+o4wSx+vO5AHqGUSYwrrYmFSlhKRxqEx1ucspQWHAEvFPHRzfj0E03fOzfzkPix5Mowh8wtUcxWjM1WY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(508600001)(186003)(8936002)(6916009)(8676002)(5660300002)(70586007)(82310400004)(16526019)(36756003)(336012)(36860700001)(86362001)(54906003)(70206006)(7696005)(2906002)(47076005)(356005)(2616005)(1076003)(426003)(81166007)(44832011)(6666004)(4326008)(26005)(316002)(40460700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 03:06:31.2058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 194a027b-0c02-4f25-d6bb-08d9b609e80a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4903
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Those gfxoff controls added for some specific ASICs are unnecessary.
The functionalities are not affected without them. Also to align with
other ASICs, they should also be dropped.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ia8475ef9e97635441aca5e0a7693e2a515498523
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  4 ---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 25 +------------------
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  7 ------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  7 ------
 4 files changed, 1 insertion(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 70fc6bb00d1f..1edc71dde3e4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1541,8 +1541,6 @@ static int smu_reset(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	int ret;
 
-	amdgpu_gfx_off_ctrl(smu->adev, false);
-
 	ret = smu_hw_fini(adev);
 	if (ret)
 		return ret;
@@ -1555,8 +1553,6 @@ static int smu_reset(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	amdgpu_gfx_off_ctrl(smu->adev, true);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 6a5064f4ea86..9766870987db 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1036,10 +1036,6 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		if (ret)
 			goto print_clk_out;
 
-		/* no need to disable gfxoff when retrieving the current gfxclk */
-		if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
-			amdgpu_gfx_off_ctrl(adev, false);
-
 		ret = smu_v11_0_get_dpm_level_count(smu, clk_type, &count);
 		if (ret)
 			goto print_clk_out;
@@ -1168,25 +1164,18 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	}
 
 print_clk_out:
-	if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
-		amdgpu_gfx_off_ctrl(adev, true);
-
 	return size;
 }
 
 static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 				   enum smu_clk_type clk_type, uint32_t mask)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 	uint32_t soft_min_level = 0, soft_max_level = 0, min_freq = 0, max_freq = 0;
 
 	soft_min_level = mask ? (ffs(mask) - 1) : 0;
 	soft_max_level = mask ? (fls(mask) - 1) : 0;
 
-	if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
-		amdgpu_gfx_off_ctrl(adev, false);
-
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
@@ -1220,9 +1209,6 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 	}
 
 forec_level_out:
-	if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
-		amdgpu_gfx_off_ctrl(adev, true);
-
 	return 0;
 }
 
@@ -1865,16 +1851,7 @@ static int sienna_cichlid_get_dpm_ultimate_freq(struct smu_context *smu,
 				enum smu_clk_type clk_type,
 				uint32_t *min, uint32_t *max)
 {
-	struct amdgpu_device *adev = smu->adev;
-	int ret;
-
-	if (clk_type == SMU_GFXCLK)
-		amdgpu_gfx_off_ctrl(adev, false);
-	ret = smu_v11_0_get_dpm_ultimate_freq(smu, clk_type, min, max);
-	if (clk_type == SMU_GFXCLK)
-		amdgpu_gfx_off_ctrl(adev, true);
-
-	return ret;
+	return smu_v11_0_get_dpm_ultimate_freq(smu, clk_type, min, max);
 }
 
 static void sienna_cichlid_dump_od_table(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 2a53b5b1d261..fd188ee3ab54 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1798,7 +1798,6 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
 					  uint32_t min,
 					  uint32_t max)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, clk_id = 0;
 	uint32_t param;
 
@@ -1811,9 +1810,6 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
 	if (clk_id < 0)
 		return clk_id;
 
-	if (clk_type == SMU_GFXCLK)
-		amdgpu_gfx_off_ctrl(adev, false);
-
 	if (max > 0) {
 		param = (uint32_t)((clk_id << 16) | (max & 0xffff));
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxByFreq,
@@ -1831,9 +1827,6 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
 	}
 
 out:
-	if (clk_type == SMU_GFXCLK)
-		amdgpu_gfx_off_ctrl(adev, true);
-
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 4ed01e9d88fb..1635916be851 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1528,7 +1528,6 @@ int smu_v13_0_set_soft_freq_limited_range(struct smu_context *smu,
 					  uint32_t min,
 					  uint32_t max)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, clk_id = 0;
 	uint32_t param;
 
@@ -1541,9 +1540,6 @@ int smu_v13_0_set_soft_freq_limited_range(struct smu_context *smu,
 	if (clk_id < 0)
 		return clk_id;
 
-	if (clk_type == SMU_GFXCLK)
-		amdgpu_gfx_off_ctrl(adev, false);
-
 	if (max > 0) {
 		param = (uint32_t)((clk_id << 16) | (max & 0xffff));
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxByFreq,
@@ -1561,9 +1557,6 @@ int smu_v13_0_set_soft_freq_limited_range(struct smu_context *smu,
 	}
 
 out:
-	if (clk_type == SMU_GFXCLK)
-		amdgpu_gfx_off_ctrl(adev, true);
-
 	return ret;
 }
 
-- 
2.29.0

