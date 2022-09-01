Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B04FECAAD3
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Sep 2022 08:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2075F10E661;
	Thu,  1 Sep 2022 08:40:26 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFECD10E661
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Sep 2022 08:40:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrCm/s2iskQVz1LJGMssRGw0ojX8Y1TG8TkxFnNKGg+qtvfT+0FUIxevROAczinbMBbB+zjMkeGIFZ2YeFS+QsAKWxy4lABUzLP2ZtM3qhl8pvhXm5zkqUCw1Cnb3jnTw5JVkLQx+vKKYaNW04jwRMdMYI0lqs9IB9xq3XOpHb3yixyWVE9BU1vWluzkJJDIe5FTwUeSfoOenRQ4ChnYd2uCE2lasaCVY4eu1b1dhyLqFJCT26JUahGZ5YH+nczACROPs2bWHE3qO+beT/8oZuuJf0ronwq6tJs30fwUb9vyJA3ttag3fGrCAxRE8cl4sOPN4NwAyF+IsXh9ANz8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdTz9+9/lmjWCcOym+95qUwalGtw9rnJmuvJqjEz4F0=;
 b=MLrOoWXV7nPyNzCdZM7dlz7HJzJKX7798n24qRE+LHPLZ1lhH/Vg1JujHtQ8AMmIncZQ5mQ+W9ypRdazrvGVZ5rW8CFBCj+4i/TY6LekZ4wZMcRW21iQfnVMO2ElomoyGTXy2fD+L4yrizFR6dzJGmzFh1y+DMWjnYnBHkF+Rx+QUHUpJ/jY7ycOgsBYPNK1BleZgYcxmbhh41BoWwtexykl96NNXhR+0KKPveyk6hjboIY4jH3DC59n0yVZNKWabGOiH7svSNyJJqo98TFg1vDNMftLho0vn4yqkh9qGsEjkJzcHyAi49IvD1/XpW9p385SsQckxo6VK0Mz/XRXJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdTz9+9/lmjWCcOym+95qUwalGtw9rnJmuvJqjEz4F0=;
 b=0Zdtd5vkq7WrVh91D+q+ErKvMyDC7mDQmqVBMd1OcFN+dPCsU7hlAJgonGV6+yK3hDqedQ/9ebauNMMra+taKNPrBtK6drNmYEX7FzuC6CaZEVJMot9Re/mQtF6gtRJ2XMJt9hgqFhiI3BDiD2VLT7YWu7NhNvc8b7yW4W+8XrA=
Received: from BN8PR15CA0037.namprd15.prod.outlook.com (2603:10b6:408:80::14)
 by DM6PR12MB4547.namprd12.prod.outlook.com (2603:10b6:5:2a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 1 Sep
 2022 08:40:21 +0000
Received: from BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::91) by BN8PR15CA0037.outlook.office365.com
 (2603:10b6:408:80::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.13 via Frontend
 Transport; Thu, 1 Sep 2022 08:40:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT101.mail.protection.outlook.com (10.13.177.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 08:40:21 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 1 Sep
 2022 03:40:19 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2] drm/amdgpu: TA unload messages are not actually sent to
 psp when amdgpu is uninstalled
Date: Thu, 1 Sep 2022 16:39:55 +0800
Message-ID: <20220901083955.2696208-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c0db615-e8a3-406f-2958-08da8bf59b72
X-MS-TrafficTypeDiagnostic: DM6PR12MB4547:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KyHRn9YxZhmW5i7L6m625BrGmXHg495VBPPgYHuHEC3CGhU5Bi96naK33GFOLgh/zTh7O2FC5u1H++2IR+FzQ5H0ybcW7jpfx9jFfgxZ7mp7EtfJWkWv2bRX3FF8xZj8KjqXmXJHMQmhzm4oakzP2jB05oxRK9tRiu9Fn6F80qBmEnLw44lYOt34dCeO2b/j69arjsU/rheYfrSh8Eqv9OGspupgczp8K9Tjl4+Pd5fSz+A0LN6zD6I3F2fU/2GM7hC42sWDkCSExMFq7gGwe6cIFXb0c4mSLfgj6F8q7DLG7l4Sz/jxBsXaCdkDpfx/Zv29IdC5DwvCu2K34UYVmV5g2R3qwIsPJG/pG/nZkB8t0xNKAvevUCbmHnAxzdDoeE2D5xIlaMW2Npblh/4+YKwNaFvYkOt/y//2a5bNf2KLkJeSCuFkUY5Pi6zZYkUk0ep2iJA6/WHuvqSUZTVvkah4NMEl5oFKsFSql6JDo1wy0CxpEe7GD8stIez8g29pvwM77lPkUyBeSkm6Uqzyb0t+5nl5h1J2dwjfKn8dlyieQUeY5BinmsQSpf2ar6FI84H1wXM6fUEegtS7jJ2lRmDyIOItsmcdTfXf38GtnNhcttL9JN4K3iaQbSJTjkXXbN+a6+dz2yVz2QfFfxze1qpiEhtqstxzoj5rY6vLPds0Zc9g1pJdcRoheFiX0e7eMinnGIqQaj+2Hmzlg+KMHLs2madFCq2Gw1LI6id/zphe8kJZsVFvhgM4fwOMzkE535qc+L1EuaEmaXgbyn3RIk5c+tSAwhq0eLf0az1MRfeCthDSx8HnRVLhAKyutTfj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(396003)(46966006)(36840700001)(40470700004)(82740400003)(7696005)(54906003)(8676002)(4326008)(15650500001)(40480700001)(478600001)(6916009)(356005)(5660300002)(316002)(70586007)(81166007)(86362001)(8936002)(70206006)(47076005)(1076003)(16526019)(186003)(2616005)(83380400001)(36756003)(336012)(2906002)(40460700003)(36860700001)(6666004)(41300700001)(82310400005)(26005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 08:40:21.6763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0db615-e8a3-406f-2958-08da8bf59b72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4547
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, YiPeng
 Chai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

V1:
  The psp_cmd_submit_buf function is called by psp_hw_fini to send
TA unload messages to psp to terminate ras, asd and tmr. But when
amdgpu is uninstalled, drm_dev_unplug is called earlier than
psp_hw_fini in amdgpu_pci_remove, the calling order as follows:
static void amdgpu_pci_remove(struct pci_dev *pdev) {
	drm_dev_unplug
	......
	amdgpu_driver_unload_kms->amdgpu_device_fini_hw->...
		->.hw_fini->psp_hw_fini->...
		->psp_ta_unload->psp_cmd_submit_buf
	......
}
The program will return when calling drm_dev_enter in psp_cmd_submit_buf.

So the call to drm_dev_enter in psp_cmd_submit_buf should be
removed, so that the TA unload messages can be sent to the psp
when amdgpu is uninstalled.

V2:
1. Restore psp_cmd_submit_buf to its original code.
2. Move drm_dev_unplug call after amdgpu_driver_unload_kms in
   amdgpu_pci_remove.
3. Since amdgpu_device_fini_hw is called by amdgpu_driver_unload_kms,
   remove the unplug check to release device mmio resource in
   amdgpu_device_fini_hw before calling drm_dev_unplug.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index afaa1056e039..62b26f0e37b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3969,8 +3969,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 	amdgpu_gart_dummy_page_fini(adev);
 
-	if (drm_dev_is_unplugged(adev_to_drm(adev)))
-		amdgpu_device_unmap_mmio(adev);
+	amdgpu_device_unmap_mmio(adev);
 
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index de7144b06e93..728a0933ea6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2181,8 +2181,6 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
-	drm_dev_unplug(dev);
-
 	if (adev->pm.rpm_mode != AMDGPU_RUNPM_NONE) {
 		pm_runtime_get_sync(dev->dev);
 		pm_runtime_forbid(dev->dev);
@@ -2190,6 +2188,8 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 
 	amdgpu_driver_unload_kms(dev);
 
+	drm_dev_unplug(dev);
+
 	/*
 	 * Flush any in flight DMA operations from device.
 	 * Clear the Bus Master Enable bit and then wait on the PCIe Device
-- 
2.25.1

