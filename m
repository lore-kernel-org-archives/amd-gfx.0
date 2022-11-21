Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DA3C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 00:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3058610E02B;
	Mon, 21 Nov 2022 00:39:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C75DF10E02B
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 00:39:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9UknlHK/wjr6uBAU6CVNW9I0SL7VBJeDCCiqsM7ZUtfGMA1VjP2dinqmI9Zo5B2AjJ4rgyEtiDodhBmBAVaF3pcBEBP5zbJPapFLqRBTYFTrcqMh2LHqfpVvovhnG4G8jmIjrlDXjfnE6+4A78V7ir/405Kytm9Tt41fS73tmix9VpMKxTnhDuW2659xAyYLmVFRxc9/wPBD7QVt2nNJFEaU4kjK8Aaoq4DouFreMbG3XjHZPLdIe2Jw9/0Y6VjBPrRdpPPU2tNsJkyk1tciZx+cttxGa8nnVFhDADZmy+mMO0wURZvyIFqNcy7vi7x35WrB89dhyiqXm5Kw1YLKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTCkCfkBePA0DDCNrs+KL2DPaC83I8d+jgWl4fiUerE=;
 b=FL2NhaifjroFT4gV1taDcqE/o6fFJIZCMyD+q9yxyKFTzXLHhDTdBndncv/6RR7bSReoZHuJIdfJJV1UwaZ1fik4deUxXZrpx5hI9G0R7trGb96FXMUY71Ev+xWIb/+d85PzutzSC7VlsgBUP2d2jMb7/bzuQvRcQsFs3n9CBqD0vyL70t9GOFrEl54dpAKg5jHQbtuWDixLUcN5loFvpt4bhUilz7vBwoTpfsbUd4ouUfZOiLpT4x1/VZGM2Isp0qKwAkjciJVq9Y0/ZjYVEKj98QBEBWhltoRLfKLA20J7mKzf3xxsMX/EbGoDD2yKa2hCrGRWLFtr7gRHq/D+Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTCkCfkBePA0DDCNrs+KL2DPaC83I8d+jgWl4fiUerE=;
 b=meO+iwuNsjbiOKssiKZPuVQZCOrhDlehz6yGcXIxEbuGx1dsJia8yLo5uO0WbxKPuMqPnYA/GYbeqeRKL/+v9HENj34DpEi1RDySzmKoChYz4ybyKpzsWFm2UDlagxCTTeZVeXlW1avjbvp7nHEnj6YgmIU4OTfV9MzB5ssCSKI=
Received: from DM6PR08CA0052.namprd08.prod.outlook.com (2603:10b6:5:1e0::26)
 by MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Mon, 21 Nov
 2022 00:39:15 +0000
Received: from DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::a8) by DM6PR08CA0052.outlook.office365.com
 (2603:10b6:5:1e0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Mon, 21 Nov 2022 00:39:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT093.mail.protection.outlook.com (10.13.172.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Mon, 21 Nov 2022 00:39:14 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 20 Nov 2022 18:39:12 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: use rpm_mode as runtime pm check flag
Date: Mon, 21 Nov 2022 08:38:58 +0800
Message-ID: <20221121003858.3296035-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT093:EE_|MW4PR12MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e1d7254-b1ab-40dc-4d85-08dacb58d10e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mt8Jpy83ORwQXMtpaGW127fSpJCFY4fXfj21z+Lt9ZTI9MVzSNNZmIBPVjRvSIHM5/KbqqkGFLgFWpejePB1OiR4wZRk+8Gh7KqL7eZkt7Rlb910T66p5JX/tlqLQ50T7EMdZBgaR3LFcU71CszWgSnfMKuq80WgQJHViNFsgD2PEopKxA79DY4IRaLBqA9SiZSSUap1MGwUr/mMxZs35Kor9V7s6jR9ee0l6x+LeWpFfBEIUGdIf1tHN/fow88fDUOKh6wUOhDrR6qZDlpwmeH8yat/AS6JpIl1quW5FuqbE0XvT9/1G7ljYSZIP6mTjsA47FbuhvebRQAxCIvGzPfhPdpV0MhIKe7RgpNu3Jz352mHYoQJl+STzeFW3MD/4Oq6eVN/UIPriQO4kkQwr5uU1LTnWxrwIY7SY6BAqid62YRFsyjk6CIxsk+e6nBjmVHXId50rMnKN3/innjNHLyHLS/7IGPrkj9yNAtM6ar9+H6D76FdPukhKt09DLvdwxIVO28iRGwC9qNGazw2qRZeTidTJ5QD3CmQIS56o5LhmQMoE0ZPanLYXMH/ZYQdIkW/GpWf1LW4dFPxcETjQ73+EfZ66hMlZGRN0ywj/UWG9GGLo89iFnIbZOLn5GYaUlcm6Y+wuWsCAu2wDVMrCfkxA8JVDYaEnSxeLyVS8A+p42p2LNi209F45lGLa4Y7pN3nCRBJ7Av0KOK3ivuJpoAnzTs2eIE5BtOMuXN6B8AeIV7wBq1KLFHdZJrHDKQJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(36756003)(86362001)(81166007)(83380400001)(40460700003)(40480700001)(5660300002)(2906002)(36860700001)(44832011)(356005)(26005)(1076003)(186003)(2616005)(426003)(336012)(6636002)(82740400003)(47076005)(16526019)(7696005)(6666004)(110136005)(82310400005)(41300700001)(70586007)(4326008)(70206006)(316002)(8936002)(8676002)(478600001)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 00:39:14.9720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1d7254-b1ab-40dc-4d85-08dacb58d10e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7142
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

Driver was not calling BACO exit at all in runtime pm
resume, and it caused the timing issue leading to a PCI
AER error, as once system enters BACO, it's not reliable
to check runtime pm mode by talking to SMU. So use rpm_mode
instead as a general pm mode check to ensure driver executes
BACO exit in runtime pm resume.

Fixes: 8795e182b02d ("PCI/portdrv: Don't disable AER reporting in get_port_device_capability()")

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 25 +++++++++++-----------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ab8f970b2849..40af21040b47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5619,7 +5619,7 @@ int amdgpu_device_baco_enter(struct drm_device *dev)
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
-	if (!amdgpu_device_supports_baco(adev_to_drm(adev)))
+	if (adev->pm.rpm_mode != AMDGPU_RUNPM_BACO)
 		return -ENOTSUPP;
 
 	if (ras && adev->ras_enabled &&
@@ -5635,7 +5635,7 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	int ret = 0;
 
-	if (!amdgpu_device_supports_baco(adev_to_drm(adev)))
+	if (adev->pm.rpm_mode != AMDGPU_RUNPM_BACO)
 		return -ENOTSUPP;
 
 	ret = amdgpu_dpm_baco_exit(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3c9fecdd6b2f..be03f7b1cee1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2532,7 +2532,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	}
 
 	adev->in_runpm = true;
-	if (amdgpu_device_supports_px(drm_dev))
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
 	/*
@@ -2542,21 +2542,21 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	 * platforms.
 	 * TODO: this may be also needed for PX capable platform.
 	 */
-	if (amdgpu_device_supports_boco(drm_dev))
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO)
 		adev->mp1_state = PP_MP1_STATE_UNLOAD;
 
 	ret = amdgpu_device_suspend(drm_dev, false);
 	if (ret) {
 		adev->in_runpm = false;
-		if (amdgpu_device_supports_boco(drm_dev))
+		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO)
 			adev->mp1_state = PP_MP1_STATE_NONE;
 		return ret;
 	}
 
-	if (amdgpu_device_supports_boco(drm_dev))
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO)
 		adev->mp1_state = PP_MP1_STATE_NONE;
 
-	if (amdgpu_device_supports_px(drm_dev)) {
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX) {
 		/* Only need to handle PCI state in the driver for ATPX
 		 * PCI core handles it for _PR3.
 		 */
@@ -2565,9 +2565,9 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		pci_ignore_hotplug(pdev);
 		pci_set_power_state(pdev, PCI_D3cold);
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_DYNAMIC_OFF;
-	} else if (amdgpu_device_supports_boco(drm_dev)) {
+	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO) {
 		/* nothing to do */
-	} else if (amdgpu_device_supports_baco(drm_dev)) {
+	} else {
 		amdgpu_device_baco_enter(drm_dev);
 	}
 
@@ -2588,7 +2588,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 	if (!pci_device_is_present(adev->pdev))
 		adev->no_hw_access = true;
 
-	if (amdgpu_device_supports_px(drm_dev)) {
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX) {
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
 		/* Only need to handle PCI state in the driver for ATPX
@@ -2600,22 +2600,23 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 		if (ret)
 			return ret;
 		pci_set_master(pdev);
-	} else if (amdgpu_device_supports_boco(drm_dev)) {
+	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO) {
 		/* Only need to handle PCI state in the driver for ATPX
 		 * PCI core handles it for _PR3.
 		 */
 		pci_set_master(pdev);
-	} else if (amdgpu_device_supports_baco(drm_dev)) {
+	} else {
 		amdgpu_device_baco_exit(drm_dev);
 	}
+
 	ret = amdgpu_device_resume(drm_dev, false);
 	if (ret) {
-		if (amdgpu_device_supports_px(drm_dev))
+		if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
 			pci_disable_device(pdev);
 		return ret;
 	}
 
-	if (amdgpu_device_supports_px(drm_dev))
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
 	adev->in_runpm = false;
 	return 0;
-- 
2.25.1

