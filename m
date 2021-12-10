Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C77C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 09:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4863F10E3BE;
	Fri, 10 Dec 2021 09:35:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D5D810E3CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 09:35:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0v9pqf6OrpAbuHg9mOUUcHdZFOhWj5fYtJ81jd+dXM8wL0wNrZ/Dk4ifW8K9b/Fd7VnmAp8GIGySh7z4qs2Cg6K2QS/18ihKNGl3AyfVsiw4gGmm0dDwn+NtGVKnxSTx0w36ZuqYWpRBtMzkrRVe3XnwI4UnJiAutI3fRY2kWcZpIv6+Yx25U8IviT4K3/JzuNcNN746UtUH6O2QKCB3B+dN/x8GtZS3cMnQf7D76Ogh9g4QSdgP1yqYEoEH8bH6WFM+amnHZHHMtg963wW5g3QkvDyZub+DMtDcTqdYnV9ATNdpC94KA/9pPowHO9EIH4KzHyKxZ1YLmhl4dMl9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKzpUR93Cn1ZjT7aa4xdo3BOtbrMCILKHi62P3kmCQ8=;
 b=eDcEGbYaxJQdehhVFYEq2/+jTeiS6sNg8Pb4Krdz7z6Qmg6KqKFjB2q8eYqSyYQ6bbAOgu8UsoQR4j58e93vxV2z1IKwHlnGQA/nh7rlxT+fdWvmVtK34wK9Q2sCkxh7GA2kDgYrjK9WuyYQKl31rG3fU+uOAwNl8aadZWwN/xmBHzG7rJ0RRHEA6T73Knr5vR992F6crp6kdMg1RR0oDFCDUABzdZwkbEQogAjR2py2pPni2jw2YL98k2VqzaOJLaErysxj1UQCmYefCh1hZw2lsvUpPAaID5vJfMXzAyTSXVif2u0/QjO+l/vcfVL8la8+kVuDaPY35y8XDAo7PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKzpUR93Cn1ZjT7aa4xdo3BOtbrMCILKHi62P3kmCQ8=;
 b=oEybG8QtZRvlJnhmKHLUmt5hNog4rImbnmkugUEA6tZR3uAlZ/WGK89USCFcN1BtW5wFmT7kSDqGklaoW8BH0xDMQQ06IiInRhvxb8bNrwkM33gWCxqFm5fmW6SymhvRc9yepS7i3gxtgrlzJaAkCepG392zCpVhkkt2MzU9r+k=
Received: from MWHPR22CA0050.namprd22.prod.outlook.com (2603:10b6:300:12a::12)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Fri, 10 Dec
 2021 09:35:20 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::e7) by MWHPR22CA0050.outlook.office365.com
 (2603:10b6:300:12a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Fri, 10 Dec 2021 09:35:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 09:35:19 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 03:35:17 -0600
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Andrey Grodzovsky
 <andrey.grodzovsky@amd.com>
Subject: [PATCH v2] drm/amdgpu: introduce a kind of halt state for amdgpu
 device
Date: Fri, 10 Dec 2021 17:35:01 +0800
Message-ID: <20211210093501.143523-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73feb374-b13a-4e41-493d-08d9bbc061f4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4095:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4095B7C9BB0407B999B58266FB719@MN2PR12MB4095.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Viw/jA2EiHx22eYdzu+nEyZLBGB132I+2nzL+glcC+B1MHhv9YO/SVBqyKPi/CSbhpa+o5BfE1THCz/cEGraSqXCaMqUQhoHAcSt/yH0QFlZTh8dna3JaIMEUfeYhosMbVRoao7ai0dCxtgYgJR7+cCeDXPX7UoZIs8N6CpltmjnYqbl7irI9hGCsBt80p1SHkfHxJvQzd7XBh7v1YjfmrnEpSOYVNdOjqKFZ7HKY0Fx8ynIujqxtjk/6ND1Yd3Lq7OQHndjuQ5Yzqe67j6wUFJHzlgw4Etqi73mFIX9GQTj3WKNibkJ+iqHAYOWso2FKPSv1YWPXK/GHZo33oF9lqmDxQ61kloIAXaoMo6a1xnqlyp96fEqb/Rgq1JRVgaIFSOCJE0QWAtgnLSkWqU0HFQvOgVps5OdTiJPL7Iv3w9RGup74kka8QCd99IB/tIgZL5NtBBGkwur2tuY0ixYbze9QQDey/zNU97TGkYHfPMDPPsnP+UO1riMIOPKvIIP30Xe7TXigNJzH7B2GsNuthAw5Z/5KAqG3WlwftWxhL+/T0phUrzQDhbevFURX3lsD5MW16ZMME/e7ALn12VjKtZsa8m5sD41XK76vOEmvBtBS8eywgyCmR0eDMqnCdXzI0O/T1REt++1YamtGdM/jv9HtEEntDQp+dY3XoeGyyDMRca23GjVSAEGhjk/vAmABrTWp6PnKnkd5XSR+60yQOotxNZxcO6Pln0gytWW3h5loeJTATy0x6hU15bLICwUTT1mHprJNMYUbuwnW675ihGOFLF8Rsv8SKuu4BYZRHc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(6636002)(1076003)(44832011)(336012)(70586007)(2906002)(7696005)(186003)(8936002)(316002)(508600001)(16526019)(70206006)(47076005)(54906003)(110136005)(82310400004)(26005)(36860700001)(40460700001)(2616005)(5660300002)(81166007)(8676002)(86362001)(356005)(426003)(4326008)(36756003)(83380400001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 09:35:19.9587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73feb374-b13a-4e41-493d-08d9bbc061f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <lang.yu@amd.com>, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is useful to maintain error context when debugging
SW/FW issues. Introduce amdgpu_device_halt() for this
purpose. It will bring hardware to a kind of halt state,
so that no one can touch it any more.

Compare to a simple hang, the system will keep stable
at least for SSH access. Then it should be trivial to
inspect the hardware state and see what's going on.

Suggested-by: Christian Koenig <christian.koenig@amd.com>
Suggested-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Signed-off-by: Lang Yu <lang.yu@amd.com>

v2:
 - Set adev->no_hw_access earlier to avoid crashes.(Christian)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 39 ++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c5cfe2926ca1..3f5f8f62aa5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1317,6 +1317,8 @@ void amdgpu_device_flush_hdp(struct amdgpu_device *adev,
 void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
 		struct amdgpu_ring *ring);
 
+void amdgpu_device_halt(struct amdgpu_device *adev);
+
 /* atpx handler */
 #if defined(CONFIG_VGA_SWITCHEROO)
 void amdgpu_register_atpx_handler(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a1c14466f23d..8fe7ea6cee18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5634,3 +5634,42 @@ void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
 
 	amdgpu_asic_invalidate_hdp(adev, ring);
 }
+
+/**
+ * amdgpu_device_halt() - bring hardware to some kind of halt state
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Bring hardware to some kind of halt state so that no one can touch it
+ * any more. It will help to maintain error context when error occurred.
+ * Compare to a simple hang, the system will keep stable at least for SSH
+ * access. Then it should be trivial to inspect the hardware state and
+ * see what's going on. Implemented as following:
+ *
+ * 1. drm_dev_unplug() makes device inaccessible to user space(IOCTLs, etc),
+ *    clears all CPU mappings to device, disallows remappings through page faults
+ * 2. amdgpu_irq_disable_all() disables all interrupts
+ * 3. amdgpu_fence_driver_hw_fini() signals all HW fences
+ * 4. set adev->no_hw_access to avoid potential crashes after setp 5
+ * 5. amdgpu_device_unmap_mmio() clears all MMIO mappings
+ * 6. pci_disable_device() and pci_wait_for_pending_transaction()
+ *    flush any in flight DMA operations
+ */
+void amdgpu_device_halt(struct amdgpu_device *adev)
+{
+	struct pci_dev *pdev = adev->pdev;
+	struct drm_device *ddev = &adev->ddev;
+
+	drm_dev_unplug(ddev);
+
+	amdgpu_irq_disable_all(adev);
+
+	amdgpu_fence_driver_hw_fini(adev);
+
+	adev->no_hw_access = true;
+
+	amdgpu_device_unmap_mmio(adev);
+
+	pci_disable_device(pdev);
+	pci_wait_for_pending_transaction(pdev);
+}
-- 
2.25.1

