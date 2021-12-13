Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EC5C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 03:53:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18F9210ED54;
	Mon, 13 Dec 2021 03:53:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B55310ECFF
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 03:53:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfbRlKnHpaIfz9celBMruO4FehtZp+5DFi3Ru0hdV2SaFCc7cEQmniB3PyNesWeIdmLDJZwHR7YyE9XHIEc+GGFwW50etBF1nYcPceazL9W/ioYoMna7cD5dtF5G6XjDavtIlAL7vJn3weyjSDC/MzHlF6r26t+Rwc0tCT6c7yp9H1bhWwzLYFSE6aaUUOWJhZtw0pK1pb/arvW0at1J8Vm3DOB4lNw0McypfgFbZ/ppwKUauxw/vmiO4/FwxslcdFHvOGHIDJgHyMmBef810JqfMg0HhSxjPpyUowiUhp/7sCB2RCrMPcmGM5Fh9Qlwrnk4OYtmqNYd0iZ4ktXRVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJnMfaw/k9N/NvEmFU0Ta3Pdj0JzyFlP9Sdvzry5XjY=;
 b=CrVjmdns6vvK2IekA82Wl6iLruBSML8YB0RtV0HGwfCH3hYMLxVFdZakhCkfkF6BDOReYBOTDvtyx29kY0BiUwpZ47Gaq341e0JOLgHrs9LeffMCihyExqI/3E7iQ7f/yL4vQVzrtxZ16kkI8TVTpdXpoIjtMQ8PP+krcBmNIOtnn+PGykq868WRgR18AlFhW7iSq0l6vygGcGJ96hvTer7jKEzBPO9oCpJ987ODdUhs63oO8oGawNxKXQN/rqt1Osg16Jg6H2sHRB2w43xtnF1wRy/QDFgAcQyKvK8LYPh5mu+Xy/IksY6wM6Zrizys9rE7GKx0n35ymoaONxMALA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJnMfaw/k9N/NvEmFU0Ta3Pdj0JzyFlP9Sdvzry5XjY=;
 b=lzakQzYkOSsvxJwa0EavHVjT2QXs+fUHPmOpoRKsLvtd8saTj6OsKeL6I/o+hFUU52FbXtNpDSsWGNTLIlmprMGKhOFQJ4rqHFOASmEJeZvP4KEtIyxiUAdB8rOsApbpKgd9PE0t1tDWwyxqCEhCGlgwEtVAXR/0IPFuZ0q2bbA=
Received: from DM6PR10CA0012.namprd10.prod.outlook.com (2603:10b6:5:60::25) by
 CY4PR12MB1895.namprd12.prod.outlook.com (2603:10b6:903:11c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Mon, 13 Dec
 2021 03:53:05 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::34) by DM6PR10CA0012.outlook.office365.com
 (2603:10b6:5:60::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15 via Frontend
 Transport; Mon, 13 Dec 2021 03:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Mon, 13 Dec 2021 03:53:05 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 12 Dec
 2021 21:53:03 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V5 14/16] drm/amd/pm: drop unnecessary gfxoff controls
Date: Mon, 13 Dec 2021 11:52:21 +0800
Message-ID: <20211213035223.772700-15-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211213035223.772700-1-evan.quan@amd.com>
References: <20211213035223.772700-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1878a6a3-c0dd-48ad-1270-08d9bdec119d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1895:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB189536486F3133BAD590030DE4749@CY4PR12MB1895.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c+jhPu8/HOWWa/BLVjha6DYo7duV43XjGfyWaumUJ7YfYybXGE5DmQXpJ4SpywEy3JohR8DG1WHDhJDPwjk3e6L7JQxVJD/qw45SrW7QK/ojlDuZ8Ni4EIdLgiQOc1cDS7XYRT2lC9bh0hfHgpnj4O4WZRfbpVOq6KxAd4mGiPKCQgERPHBgHqOAgAv011DDXA1qLTLGz6l70hw0yECZ0z6i5g3FAcvrP3L4ozrRmYOQFiOQIUM0f3F8LZtb3v0vYUOoD9i7CXsre8+VUU+nqkkkhjKtQ9kzVey7p+7dnDgHarr66JHgfZyoxgyaoQcm60cSG7eY6Jv7WPgK0QAY17lqmLbJJbw3ZitzzotWOR8uEZPybbXPl9xPl6kEjl7vLRIAy8uQRfMNZqsSTQt7f2G9eThX8rUdxe9KK5gLIqwdO89mAs5883t8FBhs4OMFvwXYkULQwBiLZoUHX7seNf842cxd0dSgRmwKwMRja2/ZhyIXwCCs2v5021jHbfK8z/ZBFm5rE92hXZzR+EsUF9XFFDwDnZx8xm0BVnlD7AGkqRugfU5/WCevyoi1WHL3d/75aKrFoCfnab8I0tPWdFrM7OQ5Wxv7E8gavqvEge+daYWf/tJOhRbv/fnxaaHoI4QYlw4miSzxglNR7nBlwPBxsBfj+Vzz5JWAYJm2vzqfc6Orz/YHYQCJyplaWc2StrpMvelGFgpaLdrElZHTLxTLb2sgCvo97Xxx6NNWY3Al2DAPtzJ7Yduttn+t8/WrKQX4g/5zInqEfRPcH8x/ZsMZN34qQd/ui0SYYrzB884=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(6916009)(7696005)(44832011)(16526019)(6666004)(1076003)(83380400001)(336012)(186003)(36860700001)(2616005)(8676002)(47076005)(5660300002)(82310400004)(70206006)(70586007)(40460700001)(86362001)(81166007)(426003)(26005)(316002)(4326008)(356005)(8936002)(54906003)(508600001)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 03:53:05.4280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1878a6a3-c0dd-48ad-1270-08d9bdec119d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1895
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
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
index 3714518e21b4..b5fbad92738b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1536,8 +1536,6 @@ static int smu_reset(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	int ret;
 
-	amdgpu_gfx_off_ctrl(smu->adev, false);
-
 	ret = smu_hw_fini(adev);
 	if (ret)
 		return ret;
@@ -1550,8 +1548,6 @@ static int smu_reset(struct smu_context *smu)
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

