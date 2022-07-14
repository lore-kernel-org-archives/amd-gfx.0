Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360F4CCA47B
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 08:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B62411BBF6;
	Thu, 14 Jul 2022 08:43:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 937A1113E03
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 08:43:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUg1g/oCDz+vma900h5WWJV/+AlelntXoDY4N251z5jt5VL1yyYewIEwbIEpJfAuUgYxx5eg0EIzErMY1oiZJ+FMpPeXcje/ISe7KToLXnGgOjpVTyJmfreXC5CyFDr+DuFVnY7U5Qfh/4FSJYz1/QgPBaOOME/HF+5BiKu0VjZ89OTG+kuEsAxTi/Uq1WQCzSUMeSEQiAaN54XSPIplZ+TrXaf2g7UH0UDG2q8OW95bqlneO0I/0NvbUw0j1BhbYMfGlDzKTNhh0KgUhq/7S+RTqVYoC16DsJ0NuPHuX7C0ZOLraU/lAlzM0xQ+nYVt3EDi4CdYfACXJpxFvYWDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TWU6BIpLkNLsuN+U+w/QdUgZuF2QWUrfH1VbDjLvNc=;
 b=Xmp5u2rfa7W/Kux/AZ3ZAWbDyu2GUQluity1Yp+C0+11K4ef7LSZeZMcLJgmpwwVcHB5Yd5DCB37xzWaj8tu+NDxZdQY5s/jYzOGEGnjpnwjuBoOBX/qfXzMDz5GsBspDduRuBwNxnkCeFpKdKoF2i/I9e6I96crGEatMFl8br+rTLZAGaAIXoz9bLCoRgw85oBjkjfCE94JskpK0c3z4Pj/MJx+IMi0Nsuj0na0QzOensQYBhF54HhhXTsHdnq9BbQY7+1qu4n3+gXeuVt7ghtGD1tf0/qjJbsEUNdTgfAtRzaGIEUzLSsOaUDWrMWxOPcciGQMgJx3STWNZN9J1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TWU6BIpLkNLsuN+U+w/QdUgZuF2QWUrfH1VbDjLvNc=;
 b=o+i6Ng7U336MQR8VDrVsP3NLSKb1eThjl0iPJxOLh81WgF4C1HYKRWN+hAWOmELJSUCcfCKGChGjQDGojgLtCBbd9NLPzuoTzbwbgAtryaln3hil/dEXBqwedifPYo1ApdyzFsMlWrEISVNTTt4hFyHdhM1DuIvG+u54u5mf4WM=
Received: from BN9PR03CA0296.namprd03.prod.outlook.com (2603:10b6:408:f5::31)
 by MN2PR12MB3743.namprd12.prod.outlook.com (2603:10b6:208:168::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 08:43:22 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::a7) by BN9PR03CA0296.outlook.office365.com
 (2603:10b6:408:f5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Thu, 14 Jul 2022 08:43:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Thu, 14 Jul 2022 08:43:21 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 14 Jul 2022 03:43:19 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: drop runpm from amdgpu_device structure
Date: Thu, 14 Jul 2022 16:43:05 +0800
Message-ID: <20220714084305.3191-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9943cec-009a-4422-386f-08da6574e879
X-MS-TrafficTypeDiagnostic: MN2PR12MB3743:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6+KdXNzjY6dLl+iBxHzm0tonEt6yGzqPjTqgvluIt3JlvSS1JiabPM+kY87VVHCYuwzo+i8/wJPLQt6nijuCSKLGuJrpoSP5ObsnSDwBRGTA5EbxFf/ldzFy2XF4L7kMip4wJ8gZ/boj/RR5VByuABtpMFmjVt1i5XWzKvuxHz/mWgCRcrqh6aH3SU3NnijQ+iMguhrKHA3SymKm467lSjXHL9uLQzee53EY209s427p8MTLwVJOBeDU2NE7tYu31YCyKrK59IJrUzAhELE8G7yTgfUNf1+MYTVZmw1X7AujncjWUo0UsDhYxZzz42/xHrq4+dEggkqxbUc1OXcLDVMz3MYPGT2AsGOUljb7xjvGk2OoJZB5hyUWNRXtQ/44qg8oVRIwlffM0EyqVxu9rBtBxsltJ3lA7RCrMkgilDob6QV2KQMbeM6wjrDNjDg12rRvz7QEd3jznSwnV3DFBATS3GDkhXRP/j/b+Z6GOOBXZERrhI5ZJHeqdQJIJkaX4waOOQImpJLjdBgPtr2tNLMyEDfBYFgjIZBXzoNvFkdtQV5SX0OSC6E7VMtnra9qYWCadjnX2nFuomuH/3VonYJkhYePVrmu470ULyhNOY+wT7Gqbaxz7O2HCVpt/8EXAIp92Xcjqs3Tn/9heOSkp2+JEpB7M/aplLrW1NNHt+F8AHJCkguNfYKibaPwif3DssNo9bnurOP2kMan7C4E/ki4xwGXnvvscVcd7wuwbpZnPMtGzJpzlINuYUIqE1X0c4zIwyFkhsaBFV8dG2TDa72lGToZyPJ3WqqzpTtMvcns9xQfoh5o6Ix6HY0JRI+H7WY2l4M4wicpKaPUxVgCxJs0J6QemwYkKI3LzYfNdTmkWeuZlxvVtRRYbfBB6kal
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(396003)(346002)(39860400002)(46966006)(40470700004)(36840700001)(356005)(86362001)(40480700001)(82740400003)(5660300002)(81166007)(8676002)(70206006)(47076005)(4326008)(426003)(336012)(70586007)(7696005)(478600001)(44832011)(41300700001)(83380400001)(6666004)(8936002)(2906002)(186003)(110136005)(36756003)(316002)(16526019)(6636002)(2616005)(1076003)(26005)(36860700001)(40460700003)(82310400005)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 08:43:21.6591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9943cec-009a-4422-386f-08da6574e879
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3743
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's redundant, as now switching to rpm_mode to indicate
runtime power management mode.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 23 ++++++++++-------------
 3 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 15f290c9523d..9f729a648005 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1011,7 +1011,6 @@ struct amdgpu_device {
 	uint64_t	df_perfmon_config_assign_mask[AMDGPU_MAX_DF_PERFMONS];
 
 	/* enable runtime pm on the device */
-	bool                            runpm;
 	bool                            in_runpm;
 	bool                            has_pr3;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 1cc9260e75de..70a7203a2916 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2118,7 +2118,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
 
-	if (adev->runpm) {
+	if (adev->pm.rpm_mode != AMDGPU_RUNPM_NONE) {
 		/* only need to skip on ATPX */
 		if (amdgpu_device_supports_px(ddev))
 			dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
@@ -2175,7 +2175,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 
 	drm_dev_unplug(dev);
 
-	if (adev->runpm) {
+	if (adev->pm.rpm_mode != AMDGPU_RUNPM_NONE) {
 		pm_runtime_get_sync(dev->dev);
 		pm_runtime_forbid(dev->dev);
 	}
@@ -2458,7 +2458,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 	int ret, i;
 
-	if (!adev->runpm) {
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE) {
 		pm_runtime_forbid(dev);
 		return -EBUSY;
 	}
@@ -2527,7 +2527,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 	int ret;
 
-	if (!adev->runpm)
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE)
 		return -EINVAL;
 
 	/* Avoids registers access if device is physically gone */
@@ -2571,7 +2571,7 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
 	/* we don't want the main rpm_idle to call suspend - we want to autosuspend */
 	int ret = 1;
 
-	if (!adev->runpm) {
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE) {
 		pm_runtime_forbid(dev);
 		return -EBUSY;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 9182e81e3135..a3744c0b632b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -147,14 +147,13 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		goto out;
 	}
 
+	adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
 	if (amdgpu_device_supports_px(dev) &&
-	    (amdgpu_runtime_pm != 0)) { /* enable runpm by default for atpx */
-		adev->runpm = true;
+	    (amdgpu_runtime_pm != 0)) { /* enable PX as runtime mode */
 		adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
 		dev_info(adev->dev, "Using ATPX for runtime pm\n");
 	} else if (amdgpu_device_supports_boco(dev) &&
-		   (amdgpu_runtime_pm != 0)) { /* enable runpm by default for boco */
-		adev->runpm = true;
+		   (amdgpu_runtime_pm != 0)) { /* enable boco as runtime mode */
 		adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
 		dev_info(adev->dev, "Using BOCO for runtime pm\n");
 	} else if (amdgpu_device_supports_baco(dev) &&
@@ -162,25 +161,23 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		switch (adev->asic_type) {
 		case CHIP_VEGA20:
 		case CHIP_ARCTURUS:
-			/* enable runpm if runpm=1 */
+			/* enable BACO as runpm mode if runpm=1 */
 			if (amdgpu_runtime_pm > 0)
-				adev->runpm = true;
+				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
 			break;
 		case CHIP_VEGA10:
-			/* turn runpm on if noretry=0 */
+			/* enable BACO as runpm mode if noretry=0 */
 			if (!adev->gmc.noretry)
-				adev->runpm = true;
+				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
 			break;
 		default:
-			/* enable runpm on CI+ */
-			adev->runpm = true;
+			/* enable BACO as runpm mode on CI+ */
+			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
 			break;
 		}
 
-		if (adev->runpm) {
-			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
+		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO)
 			dev_info(adev->dev, "Using BACO for runtime pm\n");
-		}
 	}
 
 	/* Call ACPI methods: require modeset init
-- 
2.17.1

