Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63A7C61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 08:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 520F310E101;
	Mon,  6 Mar 2023 08:04:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E477310E081
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 08:04:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0cv7pXm/DPycCuRkOJ4ocKGr6PkoVOyhEKkNzXYf+Iv/8/Jf9K/m+79TKK2VX2mBFPWeMikPoNopP0iy8xnNCjT1CXYZzTwsRnIT5HsdXHUiXyG3vd4ESud1oQ3xYfZC8GvVsVAjbIEKgK7JcGGH29Oen6IB/+vma4jTyT+d3bwUhTukIEQ/oMnBHCSuNr6tJK9LyDX+BVYOESvsZPzv5H2ehkcqY1qkDJL8hyNr3qfEWtjpOlf0ES9ya8CjS4oJewbYWDFKrleQ6aXYdMmI1gWSKl8IqhBHguVeomWHY2hzZP6FFSr/DnklAMTVOsLgqzZ+JluHFB7C4/SXlcEqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lbna4doQyd/uOIqltOksBl+sNgCHDhZDNepitAD3xNg=;
 b=Zb+vltEoDzDkflYNDyRVn4S+k5UeVBiRx5gEWcvSnLBqoZ72ZHGrKhFpxdJZEGYkkLlQl4x8RF0JwxzOuFg6vYQxvagkRbfwODGrjQl/k1aD4juazPtUCLOejDvkd0YW+1pkelVe1UpL+pa+wGB3KZMZXjREPk2DM+QzPzQCqfYAiXxTCwwSfsNDiYapl6Ncm97VAkaMfXQC2O59ydZWxrhECKSaapQg7iJh0OzO9F6L7ZJlm7ekFUbg9fdTDojVd+nG9X0w7GAOn0wYXZ0m/o8nGAs9r9tm4xzV5c0J4wkbBA5aW3EIwBwQ+r8rFKKcM011aiDdW/w/ncaGt6barA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lbna4doQyd/uOIqltOksBl+sNgCHDhZDNepitAD3xNg=;
 b=1bKNuKUySrJqx92se23askqKh06Z63QoXo0tmctR17T9vkhZPkAFxxkowrLffo/iJqPuZouiqkXw8MFLc2ef2iMNGaCP6ESKiUnjkis1fWd9jbvgDthMrTjoMWzb9ocbwVdRrmKzZve7c6Akg0gXk64z0JxLjcsBrWrK+sCYvZU=
Received: from DS7PR05CA0104.namprd05.prod.outlook.com (2603:10b6:8:56::16) by
 CH0PR12MB5217.namprd12.prod.outlook.com (2603:10b6:610:d0::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.28; Mon, 6 Mar 2023 08:04:36 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::f8) by DS7PR05CA0104.outlook.office365.com
 (2603:10b6:8:56::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.15 via Frontend
 Transport; Mon, 6 Mar 2023 08:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 08:04:35 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 6 Mar 2023 02:04:34 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Move to common helper to query soc rev_id
Date: Mon, 6 Mar 2023 16:04:01 +0800
Message-ID: <20230306080401.20501-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306080401.20501-1-Hawking.Zhang@amd.com>
References: <20230306080401.20501-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|CH0PR12MB5217:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a1e702-f145-4b7d-fdea-08db1e196d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QOPa5UBxfX+ZBatITM9fvLm5sj/9HdXezQXRrntEa/th47poRIUUMMtP5JnGnzZxY0Vlb4dLea5md4XK6/mUFfBVLrWP+0W0qusW8EMygg6+llHDvKUiDIn6h2N+QSiVMdgeSMbKnPs0oOI3kD5A4pPvmWDOYz9ntVIY5nPPSt4Y7ha1tYDuEzcGTDJIME1qWDl9dffaT4qqyfiVfUCt1dfU6AqdH1/rQn7XqLcsBB9Gu/zy7UUeC/8bL9WKlxuF1JWX0v6iNiM48+72IIMeEoTmYYz/gbLiSVVnH9v9Sju1MPd/93bdoPDelLN5cSMloUTw7/6C/5D+rDCfO2OzF7D6M1Xu46iCHhb7j674ZGWdsmC4dTWsLAGEVXIAcR0vUgUwImPTVqDjazeOMVq4XAvFEQXaBV7j2kALKUdnJEkPZIE/fqC0yR/Ty1nWZH4WjiZ15/7j1cMgnlMZ5771exsQm9OXhOO7ubnmx3+BdifFg3kmllQOMuUcyNkSJLIirPOfAPjpclWC4fgrcnr/DPRy3nZhX5RNPYL0LepebFHIBCMAoojnGHTTnT92bfXTuMG3H3Wl9bda+mwS8oWfr+yuxG9pSFYgzGjy7TNXuhzV49xLMhOkjusGNAHMpJYBD4REmqxg/WkSDZLh+XkUKbshkLC2VS3HO2/vIXdmcipXjDpH2DqJ30oX+fV6J/rpwwlVj1UmYj49Kq6vSt+q0b5fTZV0kMd4aVCF6IZUsS8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(16526019)(186003)(6666004)(81166007)(356005)(8936002)(36860700001)(8676002)(41300700001)(4326008)(82740400003)(2906002)(70586007)(70206006)(5660300002)(426003)(47076005)(7696005)(478600001)(2616005)(1076003)(26005)(336012)(316002)(110136005)(6636002)(36756003)(40480700001)(82310400005)(86362001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 08:04:35.8922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a1e702-f145-4b7d-fdea-08db1e196d4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5217
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace soc15, nv, soc21 get_rev_id callback with common
helper so we don't need to duplicate code when introduce
new asics.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/nv.c            |  7 +------
 drivers/gpu/drm/amd/amdgpu/soc15.c         |  7 +------
 drivers/gpu/drm/amd/amdgpu/soc21.c         |  7 +------
 5 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9387731afb8b..527795f921a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1149,7 +1149,7 @@ void amdgpu_device_indirect_wreg(struct amdgpu_device *adev,
 				 u32 reg_addr, u32 reg_data);
 void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
 				   u32 reg_addr, u64 reg_data);
-
+u32 amdgpu_device_get_rev_id(struct amdgpu_device *adev);
 bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
 bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b1b815dc69b3..13fa8a2709c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -807,6 +807,18 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
 	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
 }
 
+/**
+ * amdgpu_device_get_rev_id - query device rev_id
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Return device rev_id
+ */
+u32 amdgpu_device_get_rev_id(struct amdgpu_device *adev)
+{
+	return adev->nbio.funcs->get_rev_id(adev);
+}
+
 /**
  * amdgpu_invalid_rreg - dummy reg read function
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 60c10132ed32..492a8b148227 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -566,11 +566,6 @@ void nv_set_virt_ops(struct amdgpu_device *adev)
 	adev->virt.ops = &xgpu_nv_virt_ops;
 }
 
-static uint32_t nv_get_rev_id(struct amdgpu_device *adev)
-{
-	return adev->nbio.funcs->get_rev_id(adev);
-}
-
 static bool nv_need_full_reset(struct amdgpu_device *adev)
 {
 	return true;
@@ -712,7 +707,7 @@ static int nv_common_early_init(void *handle)
 
 	adev->asic_funcs = &nv_asic_funcs;
 
-	adev->rev_id = nv_get_rev_id(adev);
+	adev->rev_id = amdgpu_device_get_rev_id(adev);
 	adev->external_rev_id = 0xff;
 	/* TODO: split the GC and PG flags based on the relevant IP version for which
 	 * they are relevant.
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 6392d10e6eaf..2c37b49f5c00 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -653,11 +653,6 @@ const struct amdgpu_ip_block_version vega10_common_ip_block =
 	.funcs = &soc15_common_ip_funcs,
 };
 
-static uint32_t soc15_get_rev_id(struct amdgpu_device *adev)
-{
-	return adev->nbio.funcs->get_rev_id(adev);
-}
-
 static void soc15_reg_base_init(struct amdgpu_device *adev)
 {
 	/* Set IP register base before any HW register access */
@@ -907,7 +902,7 @@ static int soc15_common_early_init(void *handle)
 	adev->se_cac_rreg = &soc15_se_cac_rreg;
 	adev->se_cac_wreg = &soc15_se_cac_wreg;
 
-	adev->rev_id = soc15_get_rev_id(adev);
+	adev->rev_id = amdgpu_device_get_rev_id(adev);
 	adev->external_rev_id = 0xFF;
 	/* TODO: split the GC and PG flags based on the relevant IP version for which
 	 * they are relevant.
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 9d91e20a22bb..21e271877c4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -411,11 +411,6 @@ const struct amdgpu_ip_block_version soc21_common_ip_block =
 	.funcs = &soc21_common_ip_funcs,
 };
 
-static uint32_t soc21_get_rev_id(struct amdgpu_device *adev)
-{
-	return adev->nbio.funcs->get_rev_id(adev);
-}
-
 static bool soc21_need_full_reset(struct amdgpu_device *adev)
 {
 	switch (adev->ip_versions[GC_HWIP][0]) {
@@ -557,7 +552,7 @@ static int soc21_common_early_init(void *handle)
 
 	adev->asic_funcs = &soc21_asic_funcs;
 
-	adev->rev_id = soc21_get_rev_id(adev);
+	adev->rev_id = amdgpu_device_get_rev_id(adev);
 	adev->external_rev_id = 0xff;
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(11, 0, 0):
-- 
2.17.1

