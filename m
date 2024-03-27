Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55274CD1280
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Mar 2024 08:03:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C187A10F927;
	Wed, 27 Mar 2024 08:03:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OSdgTEHk";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D598010F91A
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 08:03:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFYPbIXcqjucUgOcZp6FJS2bOIVKhe4flts4KNOIJ0JJJG1R7wpOSYW8ujHd7TpQiF9yJtPzOegP3+dyG/0cbZMBaAAR6Lhn1jWngKSNagz+I1O9i/rvLa5ayLQZ7K3BClh29/MxHED3Uusli8oQjuRTB1whyJZEs+UahYFGciJ94SLdBg6EjLZ5Xb7ZELDVvPpkuN9TzNjH3ZjljlCwRsarIXQieb/y7i2pPCT3lUY3iSm1mIUWiSCbn+mBh/Tn1Gjfkaco8PdQ0ApLexlRGaDgnniNp+Cp16gN1WIguqBdJv/HduEJ6SLB3G2PnFXlWY3jGLezGgJfWbBy9CgUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZszhbwAL7QZcHC6u6AuDyBz1aHn8uNiUrjJfkV0Dhk=;
 b=LODywyF25c9BCEKzzrhNivYiGvPV1nVngR2fTag9TzViCW5FT7zzgeJONc33VQL+6c8YN+R/rOPjKH7lYzjKOyU855ZIzzrIdL9cn9MtwtnGOUK7Hd1M2imr+ubHrUpX+snyejAYcHceZ7UAaxDsUt2lGr8aSTQYm6xXprpYmKxBuoOcLk15VTaGem8oKmTGoitkEcJvhk08MNPlEL9fvvmmzbhOLg1mBBHnUB57O1XRM4o77tlcDruHm32JxLOJPYUZCgKVgcjX3ZleDyO+baPk/gsy1qnKGyvh5Y6Wbrcdq/iOz81VbcXy3EBziV5gPGZa/Y/JlDul3dwQiJy3Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZszhbwAL7QZcHC6u6AuDyBz1aHn8uNiUrjJfkV0Dhk=;
 b=OSdgTEHkH8b8MUKRHw1UUZXPObEMth6lZF0h/tZYp2fsZn2Ei531qo1GP80kDB+nh44Ylfcc9PfJlBB/fb2Gd653UplSF+e83ZJKuMNaPuEEpKrrmnTBWGUmFSSSboCdcZW9Z0v9tudNhE5xIkml7KYZiM0oJ4Ul1a1qaDcGTmg=
Received: from CH2PR02CA0024.namprd02.prod.outlook.com (2603:10b6:610:4e::34)
 by DS0PR12MB8072.namprd12.prod.outlook.com (2603:10b6:8:dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Wed, 27 Mar
 2024 08:03:25 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::f9) by CH2PR02CA0024.outlook.office365.com
 (2603:10b6:610:4e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 08:03:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 08:03:25 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 03:03:22 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v2 4/5] drm/amdgpu: Add support for BAMACO mode checking
Date: Wed, 27 Mar 2024 16:02:58 +0800
Message-ID: <20240327080259.2947891-4-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327080259.2947891-1-Jun.Ma2@amd.com>
References: <20240327080259.2947891-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|DS0PR12MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: 534e7e4a-620a-4266-fcb2-08dc4e3460eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mxnZxkqWC/cGLxnSfMHI51OmXAP0/QeKpP6stk6hoJo+zpQSTQRcxkNNqZd+Q0KSKZF9u+e7QPKMFTTtANAjuyARN5dPvlY0V3B5moePFNGgBaEeZMuMAUJ3PhVNK1hJREEnwOghzcJUO3GqVurh8Gvpa1aHh10gMfr/9wgOZHGwXWyUpRb3YPv72Y64FwJ7cybrDm9y4kPnWDw6z+zfnjdSeD6zqYHJQRZNs2OOXEIjuwFHDJyPSq3yp1RoumHeJsVNVUA1L6jBNVSk2K9tOY01eosZmom0rQGubYpS0lr/FdN+Q7X/qsPT6aIrT/Op+NVmyBCsqSGhgrVn3PilQ3eYmpzLNegpaFooHcETWYMGrOAVzh/YAaHzyHbfW+ThOfxQ7gQTCy+wW5EI1+Xq4JUxh1+H3C20svC0ihz7Yoz6bypbOGLmN8K/867F8x4fURwEVr7SBqm0/gt3TzfO0D5C7hRFAuxoxqkSSY6UGAzGy+3b76M0P+vh3IHXVH9ZG8DDIdqCWESbNntOdMw1C3KmVtz7EJWTGj+WKoNEI/r0+Ok2cph3DFNkjZ7DOXTaR0CqT9wjcioxREpLWLz8n6/FQMP2qoe07sV9yu2odgC5o3iKY8fdwBPBY3YUIdw1u2pha33fBdYJ+p74fVdCoF2hPnhjOyQzzznxMpOnBrCo6f3kVvoGZnkyiyym+ycJIgSf/gmanbKb1eEMVuXiDH/ywJ9On4RU6Yds+/RKV09L0rnTHwIJW8EDjDqsepZ8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 08:03:25.0487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 534e7e4a-620a-4266-fcb2-08dc4e3460eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8072
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

