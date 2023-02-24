Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E933C64ED8
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Feb 2023 23:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEE2A10E04A;
	Fri, 24 Feb 2023 23:37:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF60D10E04A
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Feb 2023 23:37:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edOgzcHP63PSHkLKz8/BNpEUL7i9yXiatAjge1eyu9KARn39UvQr9eP52Z5d0SXModsm5fEG8Wr4wbItFvGKsfWDDKOnrzmhQp7Hk5BXInKEG60jqR2z31oaCvR0oggRkedfZQG1WSRXJrpBW3uZTYmqpLJtKfgNso0OeTK28LEbGQlgFm+s1D+maBo7koXBd156r95QinDKIY39ThebHAWEvAJalT4JIt6cn0iHO4SnlIF1RksM+K9ZaVrvxW8oh259TocdQNO/dFFPmQvc5P4FJbwux2pqtRJIDqtkJ7Pgt5Za2jc0wKZ1edhXPp67iRWR0ZOadE7SHwc863fSfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SL70S4dTzvOa4Prx0vY61TH5KEgcFfu9BCb9v+5QGRo=;
 b=DqZLpBPh6HJtA+RvUbuv8mcXaDv+s07ilPHvZMpyH8vOUWwI96BRQzFOBZvK0vWlTpfvBlhzxMd+b+Gf9lgbfQBys+PxPdROmv3wZryFWfoXGzNmQ9rhtqiEOYXnA5Ss1GUvsmClf87e9wEDp0VJbNdohu7F+urUevcxC+79Igqd52tA/bu9XLcFX2VjukB0P6GNH4KBIH/cvsut9EIJUPMkcEfKz+03hBatYQ3GHbYm+Y6mcagGp0t2AXQcmXosTjH8qwiyprt5aTOmhsZRIfspxj37LSRReVdxwGGxzH6TG+2qSA8dVb3+VAmw9XdF/cfsT69q4yPaHYILWxtK2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SL70S4dTzvOa4Prx0vY61TH5KEgcFfu9BCb9v+5QGRo=;
 b=eS3dgupOCIhertpVLHVkvmdh9lCYokr4Bly9+sFXFZqLUrlADwOHYkfak0mL4c1KoxRg4x7/umodbX4lJKp3+E4FwtsE7mWMqON4leNdrT/63SMHCZObj1LxnNio9cRlnfnP8Wof52cNmKe3EWlxk2mDSKrOkAnYLXPOZA+hkc8=
Received: from DM6PR12CA0027.namprd12.prod.outlook.com (2603:10b6:5:1c0::40)
 by DS7PR12MB6286.namprd12.prod.outlook.com (2603:10b6:8:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Fri, 24 Feb
 2023 23:37:19 +0000
Received: from DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::e1) by DM6PR12CA0027.outlook.office365.com
 (2603:10b6:5:1c0::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25 via Frontend
 Transport; Fri, 24 Feb 2023 23:37:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT095.mail.protection.outlook.com (10.13.172.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.24 via Frontend Transport; Fri, 24 Feb 2023 23:37:19 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Feb
 2023 17:37:18 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Synchronize after mapping into a compute VM
Date: Fri, 24 Feb 2023 18:36:47 -0500
Message-ID: <20230224233647.847647-2-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230224233647.847647-1-Felix.Kuehling@amd.com>
References: <20230224233647.847647-1-Felix.Kuehling@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT095:EE_|DS7PR12MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: 22740982-9d77-4905-74c1-08db16c01207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a9IbIpgpbRYL91x7AEDS9RgXp8Q902YiFQsBHjZ/NAUF0dUpgETih5B9J8zY79JL8jM2y+WGDCW2kEYvVuX9i0gJH2qZcrHY9EH0RsoqqdqmEjQmUGv0N3FOelpVfEm/rmtBZbnVbwB2XgsHB+yQZ/1CQGyTR8dWhgYxUqadNRv3ypBrHJdgY+tRZqkbPGBf0MCMhpGU8Axo/1Lv3q7NJa342027JTZc1ZbnvOrXbsY/Dxx/SUSjEwMJA/ZjPgxY5M6HLRfQ5qF6nYfqbosrKRafGM2KMSfyVTItI1w5QrFmkozT5f7wVHdEBUYI5RY1HKhXOm04+bkMc3ylkfu7mNftfXhPTkWtmeeEQzeuiPvnIeuRx/w6C/LTylFze74dq6q0kRcE0BzgKeUvwKP9i1YRNgSHxDXpQ6LuSu3MuhWzox1vR9Pfd4O06i0bXTf5tGbq47G/6vSM9440KXjdOQZb5TFKuGDI7JxoA8Vcb9TTIuQD9Z8RBZHrsw1gutF0AE+UjbL1XDQAjf8XqJKcqUI8R/XiJsGXuv+Rh+7Q+2Lcm/n3GSsfusQas3D/JohkxPR3Owg2Mr80CNIDyUcJUmYQrEty5rtKp+jMt0e6Abo3GSPhrX+Q7uXMA2cKLcx/RSy9+ZWM2q7LKTC8mUZ6UA9F+R8kENOEGyKRDwWIbjQvDDPaJzw6tkhEO2HtHv+7V9jfiFDzWa71j1Wcd7/V1MX1buztYEbLCi0r0fCMFbw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199018)(36840700001)(46966006)(40470700004)(2616005)(478600001)(336012)(7696005)(47076005)(426003)(1076003)(70206006)(54906003)(186003)(26005)(81166007)(70586007)(16526019)(316002)(82740400003)(36860700001)(41300700001)(5660300002)(4326008)(8676002)(6916009)(6666004)(2906002)(8936002)(83380400001)(86362001)(356005)(40480700001)(82310400005)(36756003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 23:37:19.4286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22740982-9d77-4905-74c1-08db16c01207
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6286
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
Cc: ramesh.errabolu@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Compute VMs use user mode queues for command submission. They cannot use
a CS ioctl to synchronize with pending PTE updates and flush TLBs. Do
this synchronization in amdgpu_gem_va_ioctl for compute VMs.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 6936cd63df42..7de5057c40ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -601,7 +601,7 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
 static void amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 				    struct amdgpu_vm *vm,
 				    struct amdgpu_bo_va *bo_va,
-				    uint32_t operation)
+				    uint32_t operation, uint32_t flags)
 {
 	int r;
 
@@ -620,6 +620,18 @@ static void amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	}
 
 	r = amdgpu_vm_update_pdes(adev, vm, false);
+	if (r)
+		goto error;
+
+	if (vm->is_compute_context) {
+		if (bo_va->last_pt_update)
+			r = dma_fence_wait(bo_va->last_pt_update, true);
+		if (!r && vm->last_update)
+			r = dma_fence_wait(vm->last_update, true);
+		if (!r)
+			r = amdgpu_amdkfd_flush_tlb(adev, vm,
+			    TLB_FLUSH_LEGACY);
+	}
 
 error:
 	if (r && r != -ERESTARTSYS)
@@ -789,7 +801,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	}
 	if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && !amdgpu_vm_debug)
 		amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
-					args->operation);
+					args->operation, args->flags);
 
 error_backoff:
 	ttm_eu_backoff_reservation(&ticket, &list);
-- 
2.34.1

