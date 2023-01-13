Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C05C54EBE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 09:44:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9331810E9D9;
	Fri, 13 Jan 2023 09:44:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C35E10E9D9
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 09:44:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRbspAggS5rBN1xLGYz66OQR1nAZV0lONzGJvz2fPvfisxUqaQ+DD3hJ+uliWewM7sqlxRZOzVAsdsQOwM9grfXSHuVbA0Y7ugeXklMe96QPEX6svJgMBi4RGk8A8unEjTRA4CD14Z/vd5aKwac4Jf17MVP/FU4i47q4HK+HwmD2J/CQIRUs2ab0cSGYfnm274PsUCly36EKWT/QHgGHU3oueX00kGLib5yDQEaTx5Xds49/SUxPg5ZL5P7y/Noc+5HMbDMB38+QXFD8TE2un62ar6elWBqVxjA42SofhjTee0G8hygrsg2M3vuImd2+KRurRB+mveUS7pMnKJRCIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1/hWrIcey6476ryUjUDjJbP2FbVg1jb58j81cJIFA8=;
 b=n6d9yEDrOXRmkUReq/GbbtpZd4GneOtV4BNvzVxMhsOkoWiN+yF1m9jxw7s+ldmrhhz3TA0i9DEmOwfmZZxtvqUWVPpkttpDOZJ0wpw7ht9zKG72jYsHMwN7pomRFb1jsQrqEwecQ/pQIHVxZ8PgtpeGSt7PFYfjni/icpixPUW3HrcCLSRJSGNjZkmW+4BClerOAgIouS2hy9jtCWvcmQJOr8D0g2KyZ9au6OoFZqrOes0cC9x/AyB2BmNYOSUQrjquIHm7MNAAbI1VMeM/Ip7myvMZYgyfVYvcZZ46MaaZ8YKOuHtIFcD7qphva69Obj2JwBKeynm2H9pS68zqnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1/hWrIcey6476ryUjUDjJbP2FbVg1jb58j81cJIFA8=;
 b=K2w1r7ucgDHsm/8ey8TjM/d/ck+So+PtM5lpdpsKEPnnkUp2WMf/OwRrZYSsOA7n81wV7Y1VVgenO3FodGCj/4QyvWTVE6FESwgNTO7UQxkyhm0TVjBxt50ODelH0n0z9fQJYp9GaXMZC2X8aJupgbWSkpwIOIdz7/yXl98iB4U=
Received: from DS7PR06CA0044.namprd06.prod.outlook.com (2603:10b6:8:54::20) by
 BN9PR12MB5355.namprd12.prod.outlook.com (2603:10b6:408:104::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 09:44:50 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::7c) by DS7PR06CA0044.outlook.office365.com
 (2603:10b6:8:54::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.14 via Frontend
 Transport; Fri, 13 Jan 2023 09:44:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 09:44:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 03:44:49 -0600
Received: from desktop-host.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 13 Jan 2023 03:44:48 -0600
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH] drm/amdgpu: revert part of a commit fac53471d0ea9
Date: Fri, 13 Jan 2023 04:44:45 -0500
Message-ID: <20230113094445.5933-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT050:EE_|BN9PR12MB5355:EE_
X-MS-Office365-Filtering-Correlation-Id: d2741850-33d7-4f22-02a9-08daf54ad070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e6Q8AYgDj+40V6UP7LX35nO2VUg3Pv/iUqgDDpnP9jdLrysLxrHjYbYC+kQ6v8IA4YK3NVhz0yipszGkGk661uT37x3cfoVvy2omB5KmQMl9yOK9H4+wY48qE7d033W2UN2vd5wLc/U3LVh2N5fzJjtIABrzc4qWjKRCgqkZ5GeBzTY7RqkoCR0tifqrXP+oCZx9t9ISp+2HyXwSMhn6d7b1VdjvuvlRaKz/pLRXHx2ciO6JIkivHL7BhoyTaUCMv5WWYfERvYTfD+UHu7uPbCkqlmBqBs0TL+8k9s5CGdiPYdNtx+hZJ2zkSP38BhR70VkSkGl0XeJU5wQ2o7uXSGLFuK0r5mt8AfxVJvIxaSJXaKh7fDpuDFb+ok4iFVgo3sNQVBZivpeBfvF1z7BhS6GN7qAF2m+F4feMJ8eim4IZ8dNLKrKGB/vATWpkSJfpui3vgm85GfDoORlxGRUi6AekJLpx3bXOZFLFS2UbibiWl/mHJ/3JBT6GbJujwZxwDB7X9R6PH4yUhVgLupBbBgY8DBBSBD6ulu23kZ6rs+812zDjaquSBBEozUH1Lot+KlgieRo4vshBwjLy8VdKzUXINgD24656TTZY5k5f45XkEUAdjYQVhDkYh/w0Tz34s6gYF3t7mXKzg+JlGDGffVq7J4y2IjjjESbOdMpgt48BJ++i6GQbkpS7yi9BvRkEH3Hv4EwxoIjbgKMrulLKaZbn7dxLy60OehuY44T56Dc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(46966006)(40470700004)(36840700001)(4326008)(8676002)(70586007)(316002)(7696005)(110136005)(70206006)(81166007)(6636002)(356005)(8936002)(40480700001)(5660300002)(426003)(41300700001)(40460700003)(36756003)(36860700001)(186003)(86362001)(83380400001)(6666004)(478600001)(336012)(47076005)(2616005)(26005)(82740400003)(2906002)(2876002)(1076003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 09:44:49.9108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2741850-33d7-4f22-02a9-08daf54ad070
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5355
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
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

Revert the following change: move drm_dev_unplug call after
amdgpu_driver_unload_kms in amdgpu_pci_remove.
The reason is following: amdgpu_pci_remove calls drm_dev_unregister
and it should be called first to ensure userspace can't access the
device instance anymore. If we call drm_dev_unplug after
amdgpu_driver_unload_kms then we observe IGT PCI software unplug
test failure (kernel hung) for all ASIC's. This is how this
regression was found.

Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 06aba201d4db..8a1047224000 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2226,6 +2226,8 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
+	drm_dev_unplug(dev);
+
 	if (adev->pm.rpm_mode != AMDGPU_RUNPM_NONE) {
 		pm_runtime_get_sync(dev->dev);
 		pm_runtime_forbid(dev->dev);
@@ -2265,7 +2267,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 
 	amdgpu_driver_unload_kms(dev);
 
-	drm_dev_unplug(dev);
+
 
 	/*
 	 * Flush any in flight DMA operations from device.
-- 
2.25.1

