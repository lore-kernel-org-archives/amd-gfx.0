Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A285C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D310510E759;
	Thu,  9 Dec 2021 16:53:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F06F810E116
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 08:50:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZ1D5MIHSDvwhoI8Xi77L5SeAIHVmZSamWA775B5GRX52wflApIn89ArgBE+4CyyD2i4U14uyI+zl80/HFgYEMD986E6V8YzVZ0TzU01gB/1hi0fkF4soxGlM6peT2aA/72Y6dy8kS2yDVQxrccquWyRKDWy0Y/8YIGmhOUfdqcLthuRrVXC2vvwGIri0YIrZbI7rqt6TIVxALJSQyghYBIb4dFaMg68zt/9EamskYMHbbz0vK9eFbZaggpo/2kvTMaVxpntOffH64yMyvYBnJBPkkTBPjv/prnwcN6oHqRkgNSuvuz+KbXjAapVMET1TnzoHe2gPTX3dVZ9spdoOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9MQowEzaHyLBAM6aMokbvlBb0r8WSiqXGWdP6bQz2w=;
 b=VsMgeEtSqyMea2WW8KBHUdutrJJOjZblG0iH8X6ZTR+BQowGpPKAHNA0OSlD2YBO7b4Zdkef/UjUmT6Rk66xpcl6eAo5O387oRJBCRIfT0YVMzycSoGxjShD/gsLOPLyjUmxxDwLx+fqyjBmVMDDEqz5zk9qSGnzinin+yBVUXfiOBYnLdo5Csrm6iu01H3B/e8bjj8N+zaj+LW2tAHlTFyEqEljWrC5nBm3I4DOBDMy4vIsN6VRxM0eyer3tNzj0P8zk4w18LuqtTcC6ZptlauKS+ivrBXb3H/lPw+dsRlzZylOXrVhedvAqIAPulUBRBku4Lgd5bXiHxtqN5yP+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9MQowEzaHyLBAM6aMokbvlBb0r8WSiqXGWdP6bQz2w=;
 b=FtX6iJE3BBapfMkEjXmF3P5PKWUTboQYudgzuZ7q6srLaMNVrp1wGSqLxGNNTnxl8sEsgZauwiGimCqrLkwPMfiqVczZ1PuaPRXaXH75+ELu0NbPOzhgDoah5YN3PaBPGuSB4uEFbTFzIJkeUi+RDutABnaXtMscC3YL2gOMAGY=
Received: from DM5PR19CA0005.namprd19.prod.outlook.com (2603:10b6:3:151::15)
 by DM6PR12MB4371.namprd12.prod.outlook.com (2603:10b6:5:2a3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 08:50:23 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::cb) by DM5PR19CA0005.outlook.office365.com
 (2603:10b6:3:151::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Thu, 9 Dec 2021 08:50:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 08:50:23 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 9 Dec
 2021 02:50:20 -0600
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: introduce a kind of halt state for amdgpu
 device
Date: Thu, 9 Dec 2021 16:49:13 +0800
Message-ID: <20211209084914.261889-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f24dc86f-b67f-494f-b9a6-08d9baf0f049
X-MS-TrafficTypeDiagnostic: DM6PR12MB4371:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4371DDAECACE6A1011014850FB709@DM6PR12MB4371.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pFyv5uxXEjMtzW0BXZaHPa2gXE/SqsnCmg0bYGos6CzyQtpUyZ4TdYCJju0jw54+7wiCPtYUDaSr86YYsQNew1kGJ46ubtC7HkYPGKn+M7A1KNasPCGsH8leLFa3QAL8zVQMxvLaorZAX1tUqSHL02V6/Ym9SdhdgsmsQ+NWxwaKYApKZz1Scz53RpJpEs13Z6UmZPpMKlnJg5pjP2Ld4A05NCMwY8JzW5XNSRgBu9Tj5q0csmxbSR3E9pthsRchlY3nuRM6tUhdsug1Knxcd4Ay5V46ckJ4bja7TDnN4lMDvl7F1URx6lkpsjEJsvwN21W1z3mXpHZyVK2KooWRSKZ+XvaFvFEdHGy1qWk9zsXQf8Az+w3ACHrMBL23VhYRUlDwpRebdoKlu1QvvWXwplqX4DDmiZVjj6V8sjLjCd1bL3Bq938/pX9cvK2pyQTse8HptDkyVBArOiFUtlqovd0gxzOfP6j0waY8rkBuAVoukk1jAYBvbkZr34Ki41YRi2MTicAD7+VaFpVlbvrROVsyITvvElFWzfO2YqlRxAXBOUqz9Yk514xofwMJIvXKfLs1ehnsbxsjhae7VJI7nJjMyzcy19OVPG+uR56GGW3hmXr9VmlENx2xGU2tVdcvlmDR1DCwtKpQaRxJzu0CMK8IlpXfly7nLaNSXR0nUlsNs97omIKs+gUDwIa0wHQpir4Llko3pdyJxIa3J4jxqDL9VTYOPXjhCax/09BBD1XfJF+g7GoRk5FGxHkxQXiUCERDAx2qR9bkSDphlB3+RZmbjUYDZ3FfkX+uqtET5CA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(83380400001)(44832011)(36860700001)(4326008)(82310400004)(40460700001)(81166007)(356005)(6916009)(47076005)(16526019)(2616005)(5660300002)(336012)(26005)(8676002)(36756003)(426003)(8936002)(70206006)(186003)(70586007)(1076003)(508600001)(7696005)(86362001)(316002)(6666004)(2906002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 08:50:23.4979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f24dc86f-b67f-494f-b9a6-08d9baf0f049
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4371
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Huang Rui <ray.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Lang Yu <lang.yu@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is useful to maintain error context when debugging
SW/FW issues. We introduce amdgpu_device_halt() for this
purpose. It will bring hardware to a kind of halt state,
so that no one can touch it any more.

Compare to a simple hang, the system will keep stable
at least for SSH access. Then it should be trivial to
inspect the hardware state and see what's going on.

Suggested-by: Christian Koenig <christian.koenig@amd.com>
Suggested-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Signed-off-by: Lang Yu <lang.yu@amd.com>
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
index a1c14466f23d..62216627cc83 100644
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
+ * 4. amdgpu_device_unmap_mmio() clears all MMIO mappings
+ * 5. pci_disable_device() and pci_wait_for_pending_transaction()
+ *    flush any in flight DMA operations
+ * 6. set adev->no_hw_access to true
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
+	amdgpu_device_unmap_mmio(adev);
+
+	pci_disable_device(pdev);
+	pci_wait_for_pending_transaction(pdev);
+
+	adev->no_hw_access = true;
+}
-- 
2.25.1

