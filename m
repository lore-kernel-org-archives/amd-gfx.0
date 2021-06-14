Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007D6C2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 22:07:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB836102A
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 22:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB836102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 526D7898BF;
	Mon, 14 Jun 2021 22:07:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6D85898BF
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 22:07:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPeRq6fTz5+ovoMEHAT3zhEel69pj7sHesV+DJGLTbtVkN8w6BGW955p4SfNoMoXRQRcGe0q0z5STkLVGANCFjeWNbvCqzXM69d2HuVhA0HxEqqn8g36AjJ6w10JPz+iuJBPNBKBqhPwSxCZyFDigNnIRRmW/s0NhbPMEf9q70HLeSLbbr5ocoZjLtsdM4Fy4EtG7Z5UeGKYqlT4HWQpve65oorZEUv/SokjfD+dHd8uH09oCBE4stKfwwmyKHr/A9xgcWodK8zpZ/QRkGvpiUM3PlcutwoFjvkJKCXJBQcqDb7jCSnvNlOLXXDZNLwqGKyHMBnah6u1ajWZSl9ffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtqzCmOmVgnjTesU6w5kVuAaJcu2Sl8WYiLN9fZ9v8g=;
 b=Mh2Vtdm3sc8bq5MZZHRiBDSxdXwL163L9/lHdsbte8qEZovrWo4E5vYKl9aEOCOpKekLUxksdribaedKTk2ovd5V9rP3qGsOvJthFkourC2ZkbbOTVqQotDHT/MY4qUJpFbV/Viijs6np4nyPc/knEyuHjJlyCviNLwsGkRG/gLce1w+fC1zah6lfYIiy9PcYstzT9SaPPgdIAaWaMAQvmX13p6HMmlXJmqyqtYRx2urqX+rKZDTyICXcDZEeAZl3FadJHEYfopK4YZXcD7Cbh3Hq12bz3gBLzqUZmzHsT1r/mB7Ul3seHlknd9luLIrA7vlCuESQidp+0we6ctUQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtqzCmOmVgnjTesU6w5kVuAaJcu2Sl8WYiLN9fZ9v8g=;
 b=FyJ+S6v5H9w0oLBgYuevA3BGPZnObcjK95NE2CQGNAcelQ+TaaTD8zfb7D19Eg52mLK7O39pcpara0W7f4Ncdpng4rkgX4MybI6Ze7hF5L5leUwmuqziJ4wqVuHpZIloYyaM4JI4vfVk8hV42JcUUDu4Fi+hLq3ZqTInz+8csa0=
Received: from MW4PR04CA0390.namprd04.prod.outlook.com (2603:10b6:303:81::35)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Mon, 14 Jun
 2021 22:07:14 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::f0) by MW4PR04CA0390.outlook.office365.com
 (2603:10b6:303:81::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Mon, 14 Jun 2021 22:07:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 22:07:14 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 14 Jun
 2021 17:07:12 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: Use spinlock_irqsave for pasid_lock
Date: Mon, 14 Jun 2021 18:07:02 -0400
Message-ID: <20210614220702.11246-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c6e6fb3-b945-4285-3e31-08d92f80c41c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4336:
X-Microsoft-Antispam-PRVS: <MN2PR12MB43366E8D4615862EB995209392319@MN2PR12MB4336.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LxnPDYFZ2/gR89zazXrrMo6cOAx2qd7kEU12ppdckUxWPffo3ESoJc+VsC80+Vxh7BnnoGeNXNVKJf/eum70jFIj19sa5Gd7v3u9bfweGx/+EPobu3RC/mUUyZ0fUoxBavu8N/n9P1jodMhCQwoiIWEmfaAN/A6nvHZLPdCvK5VAgfEDoaDvgBcTzadfm36absiXQvQRYB0S+Bqw6GTbHqpxXx4fiqA+tKhzHuJHfVMZuYoFaAWzOQmILr3GRIeLaZU3hJUoduYOryQaXQ236/b6T9JJDR/SxQHz1dOp88UnOuNcuvqs89KZkdYnt9ieEPad/NBzMF9ZP8t+N8JBzZpS0bG3u/3MHRDSZvW4TZyS7jzI9bNtGANNT4+u41+OHc2FIGXaK2bzZYDWaW6tifPR94I8CTNPwsr+f0mpsblcqTP7tWrYkC9ci488fOSruVusmtkmytbMJvcIGYRdtaxvneZ1ksOukCZi9TsVX5lTjK2vx+8NNZgX9f2ei6B1SNX3SePRbMpgO1KHClvSA/J280IZL0iZ3ihoweo9ehDlmPVrd9PwUNOpjW+pJi3y8LVdJQxFsk6N0BSioUMLzi67rBXf5YiZxIx9aTRfRa0M+JSdel92Gi8x0H9IP5psC0apjkEImitGGLOgtXjUK9qes+gb1syULwzkgtcfMxZxVULNT+wQQmH2GLvqY582
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966006)(36840700001)(2906002)(83380400001)(478600001)(1076003)(82740400003)(82310400003)(47076005)(6666004)(356005)(81166007)(316002)(8676002)(6916009)(2616005)(7696005)(426003)(5660300002)(16526019)(186003)(36860700001)(36756003)(86362001)(336012)(8936002)(26005)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 22:07:14.0591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6e6fb3-b945-4285-3e31-08d92f80c41c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This should fix a kernel LOCKDEP warning on Vega10:
[  149.416604] ================================
[  149.420877] WARNING: inconsistent lock state
[  149.425152] 5.11.0-kfd-fkuehlin #517 Not tainted
[  149.429770] --------------------------------
[  149.434053] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
[  149.440059] swapper/3/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
[  149.445198] ffff9ac80e005d68 (&adev->vm_manager.pasid_lock){?.+.}-{2:2}, at: amdgpu_vm_get_task_info+0x25/0x90 [amdgpu]
[  149.456252] {HARDIRQ-ON-W} state was registered at:
[  149.461136]   lock_acquire+0x242/0x390
[  149.464895]   _raw_spin_lock+0x2c/0x40
[  149.468647]   amdgpu_vm_handle_fault+0x44/0x380 [amdgpu]
[  149.474187]   gmc_v9_0_process_interrupt+0xa8/0x410 [amdgpu]
...

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3b6c0b48d0b1..0b63686fc31a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3394,11 +3394,12 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 {
 	bool is_compute_context = false;
 	struct amdgpu_bo *root;
+	unsigned long irqflags;
 	uint64_t value, flags;
 	struct amdgpu_vm *vm;
 	int r;
 
-	spin_lock(&adev->vm_manager.pasid_lock);
+	spin_lock_irqsave(&adev->vm_manager.pasid_lock, irqflags);
 	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
 	if (vm) {
 		root = amdgpu_bo_ref(vm->root.base.bo);
@@ -3406,7 +3407,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	} else {
 		root = NULL;
 	}
-	spin_unlock(&adev->vm_manager.pasid_lock);
+	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, irqflags);
 
 	if (!root)
 		return false;
@@ -3424,11 +3425,11 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		goto error_unref;
 
 	/* Double check that the VM still exists */
-	spin_lock(&adev->vm_manager.pasid_lock);
+	spin_lock_irqsave(&adev->vm_manager.pasid_lock, irqflags);
 	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
 	if (vm && vm->root.base.bo != root)
 		vm = NULL;
-	spin_unlock(&adev->vm_manager.pasid_lock);
+	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, irqflags);
 	if (!vm)
 		goto error_unlock;
 
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
