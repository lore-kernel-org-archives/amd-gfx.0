Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1F9C54E49
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 11:45:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8734A10E5D8;
	Wed, 28 Feb 2024 11:44:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YGq+nYRV";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84CB310E5D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 11:44:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/AvOa/u8S8llL3ONg19mYvwe2Qrr6hg1nvrJopaWCeBc8CfRENQP1gF5XH8b5+wWvC7cL7gT0mDTq7Sm4WC02EI969DNssQ+EhBq5D8eXEP0adxBc2zZXFCb2ibBR/RWNTFp7+jUNAbvsJT8kynrUkLwVGrwek7kv5vrwdequCfNiBGbETlNeL8ZMRoM5IUeFEDdzwuVPLEJwZKbt0/lzJABdiU8avKNk2PjrIkkK6xNjNRbwDSD2b1LofJb1L0dqZNbJobJWct1Ia/3iL5dt7/y+uMW7Yrwpn0NoV+PRVNN+aTWS9TH8m6Hz4fycq+alrjYh2YAEX6hTWU52x4kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37YCorYKenRnCZN/0I5pZjw38NB83uDEYcH9nzyUt3w=;
 b=i9AmniOFZ3hQBy8+HoG8ub3tMB6lYYNOWsGvnrrZfudsRG1I7nuO12Mjl38em2uXNkP/SN8xfKsOQDymcKe4nbtMuWyB65vJE707BithWqRVSqzX/jLHsGWzg7QDcN4AXVjNV2WPN+bWjfJoBFRnKoAScv3hH+RTl2OBj/QY8AfcCA5bvYdUlNTTuxvHkArOk0WqHnINquJyjF05N8pTzbJzdFxl5OsEI9zbKty/2f/NLOlOYvCyzhjxqz/pWasBeM2EUu5vwsboAos/hb9BL0xn+H1ER2AuH/j1Xc8vBRkdBfN+Dtq003QXkH8WPfyBmlbITv5LIAbZ8mU5MTUHCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37YCorYKenRnCZN/0I5pZjw38NB83uDEYcH9nzyUt3w=;
 b=YGq+nYRVuShKLs320WA6stGmxeMSWyzaoZkIoHNbsKiJM+jACByKR/Ty2zxY8y35cVZPSkSk8zvcumgZyBrIIG5E11dBlvOuF3P3u9uK5QwgixHBONYszFGGGezZ6PdNbFp1+uC3GqO+7YXY5+lmCC48iWQL/g3j4TAlhTiSC4Y=
Received: from DM6PR02CA0165.namprd02.prod.outlook.com (2603:10b6:5:332::32)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 11:44:56 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::a9) by DM6PR02CA0165.outlook.office365.com
 (2603:10b6:5:332::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 11:44:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 11:44:56 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 05:44:54 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
CC: Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Use rpm_mode flag instead of checking it
 again for rpm
Date: Wed, 28 Feb 2024 19:44:39 +0800
Message-ID: <20240228114440.1939084-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|DM6PR12MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: bb06ff54-1ef0-4fcd-5dee-08dc3852afae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e00CdIFTja4jfUxS1VXicYaKzxJsy8+GDDBm3j1UqvjbUtvFvmw6CQTD0VK34yXjKwGcf/GCVZKW4v/qvYMvTwLKE/eZOzk09uakAluclMkwmQlwW3y0+/IsCzdmHxMpoBmnyd4EgSl7BMD3Il2h8KhUyW8ZoFKqspjEoQ6E515bMcbV75B79Sw6q8qUYysDh1V+9Ch9zHHS8RE//g1+YH2F4JBX1rwnXzp1+KAC+WaI37R9t/tSc6jeC9cbcQS2izW+mgkTKounM9K4TqlE8J8or7TLs3xkAswjyzHA51L3kPwPhaPBZ28kTBeF3BvcCzjQ4vhp+bdXO2VjNLkYEHTRynmALwhNbGNiXNLpqsJ2t77N8wJq+fKgqdwq15TVaCTeBnFkkkix5EqMce5Q8rkhFyCA2eyLliYJpJoyyIFjxMZc8VDQs16XFnaRHRY+2R0zVymZz5Zzrs+isMkxgZ2hEsMaPswPcCctTA/r9iH87FXDvtwiSbqLA/VZaG/JLwOYQGJ3qV5USJv6stTUH0Ex0MQPlXGkkOtLmnVuOypqdtXVKz8a134vmGCP0NqLNJ3VpNMAyEnmOwAS4SDtmhOb6gYjhcbDfka4Q4W947LfILRZnB7i+Kel1mQRm8kUctJW1M70QMWzcDlzlqbeTqwqkiInivF1b54z+AOFAMVQNAFbrJ+cqG9Hdh8X2EjTU+yE79eZIxzuZ5f+HFDdmjdbmU0nO7Nfyf97AeZyG5365vKiSQ3nvcVEc4NBG+OJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 11:44:56.4744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb06ff54-1ef0-4fcd-5dee-08dc3852afae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369
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

Because the rpm_mode flag is already set when the driver
is initialized, we use it directly for runtime suspend/resume
instead of checking it again

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index af7fae7907d7..8b83c26dc018 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2666,7 +2666,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	}
 
 	adev->in_runpm = true;
-	if (amdgpu_device_supports_px(drm_dev))
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
 	/*
@@ -2676,7 +2676,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	 * platforms.
 	 * TODO: this may be also needed for PX capable platform.
 	 */
-	if (amdgpu_device_supports_boco(drm_dev))
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO)
 		adev->mp1_state = PP_MP1_STATE_UNLOAD;
 
 	ret = amdgpu_device_prepare(drm_dev);
@@ -2685,15 +2685,15 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
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
@@ -2702,9 +2702,9 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		pci_ignore_hotplug(pdev);
 		pci_set_power_state(pdev, PCI_D3cold);
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_DYNAMIC_OFF;
-	} else if (amdgpu_device_supports_boco(drm_dev)) {
+	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO) {
 		/* nothing to do */
-	} else if (amdgpu_device_supports_baco(drm_dev)) {
+	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
 		amdgpu_device_baco_enter(drm_dev);
 	}
 
@@ -2727,7 +2727,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 	if (!pci_device_is_present(adev->pdev))
 		adev->no_hw_access = true;
 
-	if (amdgpu_device_supports_px(drm_dev)) {
+	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX) {
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
 		/* Only need to handle PCI state in the driver for ATPX
@@ -2739,22 +2739,22 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
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
+	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
 		amdgpu_device_baco_exit(drm_dev);
 	}
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
2.34.1

