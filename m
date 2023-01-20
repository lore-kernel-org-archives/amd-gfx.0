Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92351C25B50
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jan 2023 19:36:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40DE310E39E;
	Fri, 20 Jan 2023 19:36:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 131E210E39E
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jan 2023 19:36:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qr9iNg/QkHlrJHTeE8kEJ3oyIoFlBpK3EwyTkD1FFnTnlMdG63B87FVAo6j9Ye4EP0eAICZ21j3UL3cgTfcVFZtJCPjXYo+b/dA/E0yqHFKXhyS8I97pX/dSn9BNHa/xt1e936qMM/hYzDPzKsLBBk7AxEiUms/kkkH+VKoDKHaTN3LSMJM44se8hqBr+1+O6t59NEhgt5jPbmhNjHdW7/d6fFJqbQ8Wcn1oVcSm/nPOQlhIXihEZM4iMg8oo+9a1ZEcMuh91MRGa3qbqKfEAKeejVMLA77piTEOMS6k9iVgAPRDA4AWYuHMFIuw1a/noaST4YeNpBfkmCB8Qvya/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/tGY86LmvhnYssSIjWtTXB0lmlkt9ZjdGC3pAeuSVY=;
 b=a4adMC+f9yF0BVGHtbEwuJmX0A0qmVh2HlLIQ1nhPi6sh+M3Y/oCh0aJaAHoeTpdlNkqxok9IzY2xiZCWIJ3WRrfe8V3w9pg1rs5BR1/q7GVXT8qUC8Q8/vKBOh8rtjS9ZTTQNMCG5Xh85DQQtSmFp/u6/0NNwlQlML0WUABn71IcsCpRz8lIOG+pS4CI6XAW1uQt4/pAdTZdUiXpV0EZS7HvMzWZogifPlGcmWyaHoLynbUJkovtamu+Rb6X410Yv97r93NA1g1KmQPd3rF66Pug94ALnMjZkUWHd1VecMfhe2uF1BSpfBIwhcb01Knd5dCkqlaAtAuB87ScLf3JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/tGY86LmvhnYssSIjWtTXB0lmlkt9ZjdGC3pAeuSVY=;
 b=XuZqz+XgPK99/zpjdvdHLxsPsmCsOsij5xEHtKwAgA/gLA58G1m59M5aX2Q9MSBGC5Qz/gqTDtepT9BJY5qt7BgJJhUwEdlNZzy/bXMcTNPvZ0wl+fLG5kWrepuMog2MDYVIpWPprOHUUuvSXfN6l3ZnsczhMqhvxnpSLNb7Jkk=
Received: from BN9PR03CA0962.namprd03.prod.outlook.com (2603:10b6:408:109::7)
 by CH3PR12MB8546.namprd12.prod.outlook.com (2603:10b6:610:15f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 19:36:21 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::e9) by BN9PR03CA0962.outlook.office365.com
 (2603:10b6:408:109::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27 via Frontend
 Transport; Fri, 20 Jan 2023 19:36:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Fri, 20 Jan 2023 19:36:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 20 Jan
 2023 13:36:20 -0600
Received: from desktop-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 20 Jan 2023 13:36:19 -0600
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH 1/2] Revert "drm/amdgpu: TA unload messages are not actually
 sent to psp when amdgpu is uninstalled"
Date: Fri, 20 Jan 2023 14:36:16 -0500
Message-ID: <20230120193617.47673-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|CH3PR12MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b5b748c-e31a-4f57-2d44-08dafb1d9b5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /oRzEbbkYJF2mMTZG4x5NOkxCnjYgNEfqbaC44QiNZoWL8HtpG/W77aVcaDyNqMpfLJMpifuAdC/8NMAxNQcjXUbNy1Le7845MrvgiCBqHjnqDjFZnRS4UVNYT/kavZyFURxdTb6THMpUYjl+JbcEkeeL9bffjYdzYHfVSywbJVQ+IhDr0lBPvt3XSqALIWQwJAl8/zEK5SF0j6XFaN8pdjaO4ZNj9XvEFJOFFck+O9W21poor6Jc0rVhSVtY7h2IvVoZrpKr/5TDTgRA8i2XZEY72ijWmTJbOtkKKs1irUZO4JsPi93DgSnT9sGVCfyzNlSSnxPVR8mv8d7SPzj5flkUuuVg0dnV2qVYjZGEyVsBm6H+lJ3y3f4FSHyBRwK+h8GhIZ/C8WmyZTtd/gUK2j1xVdSKFkmTpWG0cAUdHaQRxPsEg8b0i+bSQLrNnnT0wWsN1bBhll2k8ywouqk1NN3aMl1fCamkBUQybW+aDi4PqMK4bAPHQymAmILPbG2y7oB4HuUuixKY+7KevqrjzN2R7Ql2W6gzRXrqbhWzBibUWzVKInBcO/owJk6+llkeOPB/zFfoghKr+Nq6OBP6Oo+Va/4II27sYQixnWHmTpql70SAK4FV/whMab9BlWIDo1I1MqEZj4/sllb2Hs5Wmm3wIwW4jVOqdrwJ+fgpRu66cy7AHxCj18xFZfkubREwSwVCWNAR4BSwSf/WWDxuLtwN84XuS+NUZDH+6zS161/wfSCoMzvxuzooVWqTSMG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199015)(46966006)(40470700004)(36840700001)(336012)(5660300002)(8676002)(82740400003)(4326008)(316002)(1076003)(356005)(2616005)(36756003)(81166007)(40460700003)(41300700001)(8936002)(7696005)(36860700001)(6636002)(110136005)(6666004)(426003)(40480700001)(47076005)(86362001)(2906002)(83380400001)(478600001)(26005)(186003)(82310400005)(70206006)(70586007)(2876002)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 19:36:20.5076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5b748c-e31a-4f57-2d44-08dafb1d9b5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8546
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
 - sudo modeprobe amdgpu

Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Reviewed-by Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index efd4f8226120..58d445a0590f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4019,7 +4019,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
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

