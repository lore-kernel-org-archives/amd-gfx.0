Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1D4C54E94
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 14:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44DC710E922;
	Thu, 26 Jan 2023 14:46:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9007510E922
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 14:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3nEjpo6bBLbLt0tLzesC4iypMwPbRbB8ZGbtPxYrmMk8793jjUaqCkZ/ATZPwrqU9p9M7vB7513KnxxI1l4+Uiw/wodum/Vq40yNylfgtCKUSiltSn7vuaB1OAz1Vj57IPuWv/mZb0dJjEjY1pzGHd5shLC4IzA3xS1MlafA6xUEBZarXQU9knkAn3OJ5/XVv0b0Zx77TXQD2jLMtYAZ0v1XlLdQ23t4h14kt7Vgiv7u9uZv2NZHj6smHQumueKI3bSnW6yJ4acSJER3Mzs1EbfRGy0zNSYBw+sX5MWyoIq+UwI0BPOpeoPxThh0mrZiIceloeQQLDnPBaLQKxngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErwvoYmsVVG1xfeyvF9jhzS6SufWZeOA1mhCwq8wdpU=;
 b=W2XeKsFxy9F+9eispzeFAYSim9stAFx4yuCwqHEiH8VMZn9Ai5Z6ijff5XGpjOitRUaoJEHxbrs//4HvpgQKZ/OQokK3ve2McAFYqWUW+7hdaHR0wOStADJ/1VUkCdJrYX2i/KChRnlNNRRmwAYdYFaNDJ4VhsYlKjonBNqTbE1GRHvGU62yH6atoERVqpoQCAMxIrbiZhVH6hJDKWlWaDZMfidRuyth/IU6RCx/qQvm2opZ1AEpi7xqL1ej0EEaLloYVHUIl3w9KYfD+5reflt6XFWBIVsfN1xXROP6LhhafC/lu3hImuHN3zIZWi/AsV5pmvWP+zP13jdAujGxmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErwvoYmsVVG1xfeyvF9jhzS6SufWZeOA1mhCwq8wdpU=;
 b=pIhRSfxJG7Vc8mw/eMUr05AF/9HqGEzotfijpUi5CiwMphDibxO6LNU6sPD2nbE184wT05LNO25Q2ZBF89E9u4pXIUH8fB1ldvR28YddzN+1QuajFayDqoKOXPRapKnE3DISK6jAcBPFHKDYigMXKPVQjiMScfm4Nvu1SmDNac8=
Received: from MW4PR03CA0032.namprd03.prod.outlook.com (2603:10b6:303:8e::7)
 by DS0PR12MB8501.namprd12.prod.outlook.com (2603:10b6:8:15d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 14:46:42 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::68) by MW4PR03CA0032.outlook.office365.com
 (2603:10b6:303:8e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22 via Frontend
 Transport; Thu, 26 Jan 2023 14:46:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.21 via Frontend Transport; Thu, 26 Jan 2023 14:46:42 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 26 Jan
 2023 08:46:41 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 26 Jan
 2023 06:46:40 -0800
Received: from desktop-host.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 26 Jan 2023 08:46:40 -0600
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH 1/3] Revert "drm/amdgpu: TA unload messages are not actually
 sent to psp when amdgpu is uninstalled"
Date: Thu, 26 Jan 2023 09:46:31 -0500
Message-ID: <20230126144632.37532-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT018:EE_|DS0PR12MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: b2dc93e0-7020-4a0f-d9e8-08daffac2382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gDuNv7eaWAgx2IBfLE3/KRZ382X2JMs17cRIJElNovgTt3li6vlU6Wj/jV5N5Qp1/3y0fNfx1IBkimFiFcxOhna2mdblkQNP7wOybGrhJhiIenRaxrg+Imr9iBPKUGw+kQ6kFp24hXuPguv927ioTxrFvtkZs17pkR30oYeZb50NBywMkDL0VsAciTQhkHbmDT1WtkGsQFDtKqO8veJrgPywVVvuwG4kcAyFg2zz0KExFJy1p9805Yc2CRR7OMlvPkeSc0OXzrsIsqhWolYB7Fyw456v9usLjiu31cgDEiZMmtGMcp+6eOHKrUarJHEwpr+lL/IubfxJO0QJFO3ORCraxk7dUl/3xhnTlf7cw8KVcMl0/wXNvPSil6QoE89DyLrGv32NvCbN2+MG6MDkX2Queudyh8jK6m+VRMd57LlZC2VK1IY7ZSWvhfzkaMWxg/YxXAcf2x9Moq9ybdSfLm1SOP8EmO6kUpTxJnCajdcAQ3fDwzERPYA50ahsTzXOzrV5wBLFKZCX6DsKkEz9aDLoVL0pYSLBA2LI1ydZ1gzV7eBefIUcQ+aYZ45ENwFRrFgpysxJQAcjkTijqHldvn7thWDn3OBcuzb1mx4tVfSxpv4d1BdefwfBmt63wg1+7TnVsmMX/UlWrLwQHrnShV+9FOgBa/pniJLtN2ryvQdyIMssFBACfYtYeRcpkDCBP1hncd8VPeblAjhEBsO9tixdONyuAJzez4lgdH3JBLY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199018)(36840700001)(40470700004)(46966006)(8936002)(4326008)(36860700001)(83380400001)(70206006)(70586007)(8676002)(110136005)(86362001)(7696005)(36756003)(40480700001)(316002)(6636002)(478600001)(356005)(2616005)(81166007)(26005)(186003)(336012)(40460700003)(6666004)(5660300002)(1076003)(47076005)(82740400003)(426003)(2876002)(82310400005)(41300700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 14:46:42.0019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2dc93e0-7020-4a0f-d9e8-08daffac2382
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8501
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

This reverts commit fac53471d0ea9693d314aa2df08d62b2e7e3a0f8.
The following change: move the drm_dev_unplug call after
amdgpu_driver_unload_kms in amdgpu_pci_remove. The reason is
the following: amdgpu_pci_remove calls drm_dev_unregister
and it should be called first to ensure userspace can't access the
device instance anymore. If we call drm_dev_unplug after
amdgpu_driver_unload_kms then we observe IGT PCI software unplug
test failure (kernel hung) for all ASICs. This is how this
regression was found.

After this revert, the following commands do work not, but it would
be fixed in the next commit:
 - sudo modprobe -r amdgpu
 - sudo modprobe amdgpu

Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0f9a5b12c3a5..a10b627c8357 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4031,7 +4031,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 	amdgpu_gart_dummy_page_fini(adev);
 
-	amdgpu_device_unmap_mmio(adev);
+	if (drm_dev_is_unplugged(adev_to_drm(adev)))
+		amdgpu_device_unmap_mmio(adev);
 
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a75dba2caeca..7edbaa90fac9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2227,6 +2227,8 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
+	drm_dev_unplug(dev);
+
 	if (adev->pm.rpm_mode != AMDGPU_RUNPM_NONE) {
 		pm_runtime_get_sync(dev->dev);
 		pm_runtime_forbid(dev->dev);
@@ -2266,8 +2268,6 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 
 	amdgpu_driver_unload_kms(dev);
 
-	drm_dev_unplug(dev);
-
 	/*
 	 * Flush any in flight DMA operations from device.
 	 * Clear the Bus Master Enable bit and then wait on the PCIe Device
-- 
2.25.1

