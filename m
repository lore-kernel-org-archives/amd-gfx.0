Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1504ECD1284
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Mar 2024 11:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69F1C10FA1C;
	Wed, 27 Mar 2024 11:11:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZRgwqXuo";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D191B10FA1A
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 11:11:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmwin1cAoD/UO0rnc49WElgcXDx8G0IXOn6GNkFYEXOFq+8EGls8SEf3xNRo40g8B8P2JUDzMVK5w6LKReZB1wxJ/M/i67cmFRZ/gR4l5U6y4N7STQgIHS99ymdN4R79vWikNuREIu4GW4F6RVlk2QK9FBTgwYe01sOA9kDYEulkHPsDCTGNlUlzTyiDdkJOpYhW1YdaSTZ2neWbbp2P/IB3wO0010VGsgn88m0PumjrTldwD/wUkLWmydMZjCqv9ZBFruRswqomhw5fw5LxyHAxhouG8/OsmXhZ8BE0e5Orh8N7PvKH3+TJCvyDFnpJVm2Jw5TJ9qGg4bGWwd179w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZszhbwAL7QZcHC6u6AuDyBz1aHn8uNiUrjJfkV0Dhk=;
 b=bGwDZbrIoA4Ft2PeA95iREfb6gGYgztKqR8e59Nx1e8OOXDjddf+Z7r8MvWIaOQdzZ9CRqThyxdyiHYROcEJfoPKPSUw8dOc/LYFWuIPoYHjoFxVSHX84d7ABHWIvMNNjlPIfkYlskN0BM1jDQtfSgXpNTy8l1UExiC3xbdrWqaBSKg7tsTL9Lz/ec0/9rh2ZP3x/qbj56wO9uO1anN+h6dsPAlEr+HU+Pyw5wJIhk9C3egNqM5rR2tHx6CnDe4+IFiVFNApQI2w6lFTgodv5QnQV5JYC1lx2/MyRFfMg0PS3zoGMJ/Qvzg//cv1/S+R0qYOEYav31hPGyS9xaFgEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZszhbwAL7QZcHC6u6AuDyBz1aHn8uNiUrjJfkV0Dhk=;
 b=ZRgwqXuoqfjcU0cEWayWa2J+uQdteHAWcMy4tQ9z+/0cgPCsNEtxbReZsUjfGK0jJguSaKC0GDHe6ZPCR1gcHRxzFyJTbBzjlfMb+cb7GFlrfGZ+8BD/wp1kvr9eph+RhBlpi8tavxU05nj+wfbU0XIFYsjaMsj2UWrPzh6ZPl4=
Received: from BN8PR12CA0001.namprd12.prod.outlook.com (2603:10b6:408:60::14)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 11:11:27 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:60:cafe::26) by BN8PR12CA0001.outlook.office365.com
 (2603:10b6:408:60::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 11:11:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.0 via Frontend Transport; Wed, 27 Mar 2024 11:11:27 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 06:11:23 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v3 4/5] drm/amdgpu: Add support for BAMACO mode checking
Date: Wed, 27 Mar 2024 19:10:08 +0800
Message-ID: <20240327111009.2994297-4-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327111009.2994297-1-Jun.Ma2@amd.com>
References: <20240327111009.2994297-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|DM4PR12MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 5327f902-048a-490c-0578-08dc4e4ea593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JhaP9UpLA+XpIfq2VYQ4rp1pNVUxgbYqVH32XAg8H5LsAfAn1vYaILtKj6NI50X0EK850sGci00PHDfERlkjn5l7JNbQrcxW0q4JzKOGCXWcnEcEXv4raVwKMkYU/zSbb5ZaeL7DMskggb2nWRivaLjMS+XP7Zp9Z9scfog8K17MSb9jv5MPKGPzpm/5kEHtJyE2d7PokPzdZiCfZoPNa/Tz0t63e8DgTBIKIdQ19PRrX+ZY+NEObIUKqHAnz6axEAjSnvgg93V9eoQeiQp27NziALVgi2SHVE9l5Njl5/ukTCoqiyaAmDYrsAalxPSWhGBV81gORwbpeIln8JKue7YnisUNLG4cIVUx/LGvE6MRTaQjrpnFwjh7dxZ3AGdy8ZC4i2ruiyzk58KfjYP2UPv+AIoEPtt/g8cuUnOD5Ie6KYFEjouC+njqr78rU3+2gqd47HP+atD7uUTXZbOfK+v5s/Lo3/Nt7lMKAndzSiMTLmYSDhcyNd0WMSa7GiTT+JnpM5jAt3UyUqbgg0P9gJegKqUsy06FuqHOV58YAC/b/zaEqWNjeLwUDeMXl4VR9SRavUnegx9X8MQgjBNyNH2E5AYCCjWUpMRfqR2SzC9DLYBb92gMf3SsuqwVrHLiR+D7uGD4Vx2Wz6XFLyfglb3dl1cbHHIMFY8H15adSRrApYqnwpNbVqQ6N+EWp+nfAIwVx12VEB90I9QrcMSO8+R0oQpRZ6P//rIVIecJFZaT3NC5WnDdKR2ZeSw7PubU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 11:11:27.1590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5327f902-048a-490c-0578-08dc4e4ea593
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573
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

Optimize the code to add support for BAMACO mode checking

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
v1->v2:
 - Fix the errors in BAMACO mode usage (Lijo)
 - Drop the refactoring of runtime pm mode check
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 23 +++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  6 ++++--
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 80b9642f2bc4..d12e6e2367e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2734,7 +2734,8 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_DYNAMIC_OFF;
 	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO) {
 		/* nothing to do */
-	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
+	} else if ((adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) ||
+			(adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO)) {
 		amdgpu_device_baco_enter(drm_dev);
 	}
 
@@ -2774,7 +2775,8 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 		 * PCI core handles it for _PR3.
 		 */
 		pci_set_master(pdev);
-	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
+	} else if ((adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) ||
+			(adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO)) {
 		amdgpu_device_baco_exit(drm_dev);
 	}
 	ret = amdgpu_device_resume(drm_dev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index a66d47865e3b..5d1b084eb631 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -133,6 +133,7 @@ void amdgpu_register_gpu_instance(struct amdgpu_device *adev)
 int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 {
 	struct drm_device *dev;
+	int bamaco_support = 0;
 	int r, acpi_status;
 
 	dev = adev_to_drm(adev);
@@ -158,8 +159,12 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		   (amdgpu_runtime_pm != 0)) { /* enable boco as runtime mode */
 		adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
 		dev_info(adev->dev, "Using BOCO for runtime pm\n");
-	} else if (amdgpu_device_supports_baco(dev) &&
-		   (amdgpu_runtime_pm != 0)) {
+	} else if (amdgpu_runtime_pm != 0) {
+		bamaco_support = amdgpu_device_supports_baco(dev);
+
+		if (!bamaco_support)
+			goto no_runtime_pm;
+
 		switch (adev->asic_type) {
 		case CHIP_VEGA20:
 		case CHIP_ARCTURUS:
@@ -178,10 +183,20 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 			break;
 		}
 
-		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO)
-			dev_info(adev->dev, "Using BACO for runtime pm\n");
+		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
+			if (bamaco_support & MACO_SUPPORT) {
+				adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
+				dev_info(adev->dev, "Using BAMACO for runtime pm\n");
+			} else {
+				dev_info(adev->dev, "Using BACO for runtime pm\n");
+			}
+		}
 	}
 
+no_runtime_pm:
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE)
+		dev_info(adev->dev, "NO pm mode for runtime pm\n");
+
 	/* Call ACPI methods: require modeset init
 	 * but failure is not fatal
 	 */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 94b310fdb719..78042eb707b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2617,7 +2617,8 @@ static int psp_load_p2s_table(struct psp_context *psp)
 	struct amdgpu_firmware_info *ucode =
 		&adev->firmware.ucode[AMDGPU_UCODE_ID_P2S_TABLE];
 
-	if (adev->in_runpm && (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO))
+	if (adev->in_runpm && ((adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) ||
+				(adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO)))
 		return 0;
 
 	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6)) {
@@ -2647,7 +2648,8 @@ static int psp_load_smu_fw(struct psp_context *psp)
 	 * Skip SMU FW reloading in case of using BACO for runpm only,
 	 * as SMU is always alive.
 	 */
-	if (adev->in_runpm && (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO))
+	if (adev->in_runpm && ((adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) ||
+				(adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO)))
 		return 0;
 
 	if (!ucode->fw || amdgpu_sriov_vf(psp->adev))
-- 
2.34.1

