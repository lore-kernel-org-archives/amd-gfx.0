Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1557EC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Dec 2022 23:27:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D74D10E3E7;
	Tue, 20 Dec 2022 23:27:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6201010E3E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 23:27:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8xWaYHw+eaTV1T/sOHOkhxaBhC8cb21/aWlKfoFOLftW0qewV1TMer3B9++4JgzoK5Nb5Dx7F/kKqAsjB5/GHI5iYYW16f1Wur4czQ3al813i8PtQmdmkIsRXKwaoExLw5MKCQV3GT6D3Bix/6+PAIt0rNGPyxN/0Nf3Qa0HaCQ3PdDoCk5e/gKWPcS1mNQ3fb2XVAksOuvVZS0B6HI17MFy81UrjJMZcn1b0Hgw8tgjwZVk56ng+n7Wx2LXCIzIQujJRkQ+Qa2kjiIx/rj4ThBPr4fS4ZsQF69Qi3e8GUW+XXASzYwIOszK9gjhkdQZGEuoEIwT6VXw1qbfymXwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AkuT0Dv3LaPEvrKxnQpze3TZ11O0URw7DWZ9wt1vk4=;
 b=EtHcnyBoxOtowLJ/yY/0OpObPNEdzTkBiNIH7Ecg7mJV/2A/Zdl07VccAXV1s51tPGbEoyMaK1pxCtzeIakTe+eCiYGOcRInQ7/Dz4QHN0EKtvDiqubHFklKjSv0H2lMc6nAYREzH3a4A9RrbLZz7Phsm63Pt18lZsfESmvYbYB5M5EowZuTL10w+pjwYcSmHSobGnjCOPeB5gOc9g5ZSUkWV32ouUgDtFQC9DYFm7HfmoJmsB3WISxq8DYrL6YZom6/R8JG1fdd3TuZJaFuzeNAGcb/WlINvmVX1kbZJHTobP1S6fqwSqEW2/GU+VVQxtMo1rnRtyYzdB/MqmE2Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AkuT0Dv3LaPEvrKxnQpze3TZ11O0URw7DWZ9wt1vk4=;
 b=x8bRwzW/nDousegGMjYRWGzsdqo0gtMROptUGIG+6nzGV9rxrtaSNs68xMDHkOKIP+Mb5Wkw5UWlq36kRsctv6TkvpoQ37FZk2T6CJPQ+lhSFiIq2ub32NBGr3DxKW2DFR9pRKbFJoXS2ZKUtLcd4leRJiZVgb/fHxofmLyHtqA=
Received: from SJ0PR03CA0167.namprd03.prod.outlook.com (2603:10b6:a03:338::22)
 by BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 23:27:20 +0000
Received: from CO1PEPF00001A61.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::11) by SJ0PR03CA0167.outlook.office365.com
 (2603:10b6:a03:338::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Tue, 20 Dec 2022 23:27:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A61.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Tue, 20 Dec 2022 23:27:20 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 20 Dec
 2022 17:27:19 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC PATCH 1/3] drm/amdgpu: Add vm->notifier_lock
Date: Tue, 20 Dec 2022 18:27:02 -0500
Message-ID: <20221220232704.3394112-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A61:EE_|BY5PR12MB4321:EE_
X-MS-Office365-Filtering-Correlation-Id: 256da04e-24bb-4558-3c21-08dae2e1bdb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvhGnmu3BhIMkaMOC0xgYSGpu98jS/8xzoGiUMddLoEVEz/s28asIuyBVCdLCg7JOioiU884nzzM1bjjzvRL0JP7klU7qYF179/ixoG06QQ6K49N8Izwka+/rtQ6JwsSw0LKfVfRRFAWDqVD2+T57UL6wZi1bHruAYTcQxgFjQ4t1Qjk0uFC/Y28+f/klM2R2X/FRKsyl0oMeTPRTg/vrsjbzZld6A60pkF/7GDKt7HtVrDkEGvcXMNTlGlUAC/DOi6lQmYIWwJ5FvbDw8J9w14urv05EQi3eQMjik17Lw1sTLwuwOhWpKPaRwYfVkruVMKr5xQr0eAZD4ocJ+EFC6lSwG03tIvPcJ6KR4mo+rLBAkhIppX08H7U0cE45cT4vhT36u9AFnlEI6fIDDqBb+ygAWMKLBnkN2ok6mfrLMB9QNBQPJ1d3wyOb10ajfkUpTxAs/3pPPa1hn5qz/RfWjU0JrLkTkqIw5nVuKBDEFR1C68fROJvz84zIWCsoWFI3KxWWxEqL1hjO3Bb3OkfMK/Y/f8RDI2ubxDdOLzkkMg19MZv8QBcGAz8csyy4SJA2GkjEs91KOklpLnWmB9OUqHRlKvR9vE7XeoD0H574zpZ890yfrJjGbDLYTs5vbbvNLZCd691AXiA7JhoBvphb7SXy6wnoR3adWQY/iQ09mdA0E0flfk/qiS+7GfvOuyC58aUquwNZLSMAwc89osES/hmR0+YrFInqvYDMKPuDzA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199015)(46966006)(40470700004)(36840700001)(7696005)(82310400005)(81166007)(41300700001)(186003)(336012)(478600001)(40460700003)(16526019)(26005)(86362001)(4326008)(2616005)(8676002)(70586007)(36756003)(70206006)(82740400003)(1076003)(2906002)(316002)(40480700001)(54906003)(6666004)(5660300002)(36860700001)(47076005)(356005)(83380400001)(426003)(6916009)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 23:27:20.3034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 256da04e-24bb-4558-3c21-08dae2e1bdb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321
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
Cc: philip.yang@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This points to a mutex to serialize with MMU notifiers during page table
updates. For graphics contexts, the notifier lock is per adev. For compute
contexts the lock is per process.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h           | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index b15091d8310d..7aaa844a8284 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1325,9 +1325,12 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 
 		*process_info = info;
 		*ef = dma_fence_get(&info->eviction_fence->base);
+	} else {
+		info = *process_info;
 	}
 
 	vm->process_info = *process_info;
+	vm->notifier_lock = &info->notifier_lock;
 
 	/* Validate page directory and attach eviction fence */
 	ret = amdgpu_bo_reserve(vm->root.bo, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index dc379dc22c77..a04f7aef4ca9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2075,6 +2075,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	mutex_init(&vm->eviction_lock);
 	vm->evicting = false;
+	vm->notifier_lock = &adev->notifier_lock;
 
 	r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
 				false, &root);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 094bb4807303..07af80df812b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -251,6 +251,9 @@ struct amdgpu_vm {
 	bool			evicting;
 	unsigned int		saved_flags;
 
+	/* Pointer to notifier lock used when updating PTEs */
+	struct mutex		*notifier_lock;
+
 	/* Lock to protect vm_bo add/del/move on all lists of vm */
 	spinlock_t		status_lock;
 
-- 
2.32.0

