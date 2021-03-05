Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06256C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 01:20:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4A8164FF0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 01:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A8164FF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E4306E0AD;
	Fri,  5 Mar 2021 01:20:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF0386E0AD
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 01:20:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ff+suxX2BygI/lrIt/vTOkDmzjCLKWCtHpnVXuDEcdiHozzEPudaVpgBn7i9uAqiu6MzLfUYewISgTBtSHIGkOlWvyi3D87kMefdFIaBp9DZu8FthTLP0uVF6Cqaz+HJyAbSqCMZhBL73iw1pyxGrwsnUfSdXVIT5wSF/1BfoRYrRhHm68pHNRpfAZbGdo3bSF9GqVsPb3h/KrhJHZVuAKaX1LjsPesrYWV5ovqzKmrdyyD1uRmdM+WSpgyX5ff8YZ0GLU3IUH3QCNB0XdEdacvIaOiH+wFyNOQ1/ADJIsazXaWHRURyCJnv0/L1pBnVl3aT4GmnnR2dro85hcrr1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZpOEYr5NcewAzyf89KfAMqHPBCH3XmRajGsGAuUchI=;
 b=ggWaRG/LAkL773wu0rVLpJ57z3Dw7uWanexXWkyMM0x7Vf93YOKrXP73u2pHna4xeHlyuclgnuawgRqbsGhc2CkkpjLrTunxG1Lb+HpXWUQNvfzgoVewgmQ2EArcYZNC87R+IwCfSRNzZKE7xxppAlrHSg6+WgDPCoVuvu8kACHajgsr2RJ4hZ0Q1gqXHLlPX3lld8y4ntw0t40jj+BwDcY8iWj52xu3K9C4a2LxdXRnysqSrXnvBme8/k3zyZGTJ8QDA/3eoz4AzOL+Xz63DuGvITHlyv0+0hOdzczGjcbrjP1m2aPyQ1FmIKxilhlwmhFXH/KfK/iBdPCTG1+NIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZpOEYr5NcewAzyf89KfAMqHPBCH3XmRajGsGAuUchI=;
 b=1EaphpN7eI6sxWvNtCGeP1zu782fRd8fba0eN8m/YvvxDsBLPpPBQ8kiv+T1M25TFGTnDxf7vqD07yXxmLRDvaR8kRkjIBygl8Pck3btQOC45uMPVIPMMhKEeNnGXRbr5xjXJj8OueIgu61MDtl0RMsWXT7AX8MmRBn76roUvYc=
Received: from DM6PR11CA0067.namprd11.prod.outlook.com (2603:10b6:5:14c::44)
 by CY4PR12MB1926.namprd12.prod.outlook.com (2603:10b6:903:11b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 5 Mar
 2021 01:20:22 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::c6) by DM6PR11CA0067.outlook.office365.com
 (2603:10b6:5:14c::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 01:20:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 01:20:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 4 Mar 2021
 19:20:20 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 4 Mar 2021
 19:20:20 -0600
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Thu, 4 Mar 2021 19:20:19 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix some unload driver issues
Date: Fri, 5 Mar 2021 09:20:19 +0800
Message-ID: <20210305012019.58196-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02b74640-b8ed-4256-6f10-08d8df74d867
X-MS-TrafficTypeDiagnostic: CY4PR12MB1926:
X-Microsoft-Antispam-PRVS: <CY4PR12MB192615A4266B541074F7581F8F969@CY4PR12MB1926.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UoGSY2fFcqo2yWz6hQNfj7DATbAH5HgJjnxvE3sY63BpsdH362/IggE8dd200RGXczPgKLZuqDdvZ+Bbbpav8GR4ierFXbjy/quVM0hBetOEEKkNRdaYW7aOOxdm4TWk51L9i5yWHKX1nZPs0Ajgz7OufFanUevzlhxWe6dA0sPokVkryFxO2KNCChCr7YQHfMs3pqVC74gOe7pJZ15ruVs+ArlDIVOqyAfjbaBsFWXBMqe9DWDFSxm8mhWOIcYzfM/V/l/cSFTFP4JuOj/WN5zaIm/eIjaP9yPumb18MY2OGUD0BOxWYTAEfSzPkxjrqOL9rOvULYebDUUCerFBDsu44N7S9Qx9LhRUoYi8y3XPC3AmhvcNCXx+kIbUCtuPgxxaQUEf3sh5cWHK+gp9IaXVtevj2UqPVhVZsCs1HxejdTApK/hI0CjLVLYMEfG9h+OLdZ8EhHIPurLHEnMXnnQeHeEXu1llfRNlh02aTik/R1uDUi3dkZCaX/B8rGN+TqbHtOUWOYn4QqlHteIOAoHMI0N+gImSa0F1I6FZb5ZIdwVI4h3y8w7qhwteV0Kz1fKaXYuTwyxC3Fb46GejjOO6CP7XpN4PKA1Ce2WSZGtPdXy5LuHYl0ki7rWFmQ9+dARkIHiKT9zO4q8VPpXA5hP5U4FAIKlz0laOvaxsKkJoyaUAzhiRh2tP1+r8ny0R
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(36840700001)(46966006)(70586007)(70206006)(86362001)(8936002)(83380400001)(336012)(2906002)(478600001)(426003)(81166007)(1076003)(5660300002)(6916009)(8676002)(47076005)(186003)(2616005)(82310400003)(36860700001)(316002)(4326008)(26005)(82740400003)(356005)(36756003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 01:20:21.1753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b74640-b8ed-4256-6f10-08d8df74d867
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1926
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
Cc: Emily Deng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When unloading driver after killing some applications, it will hit sdma
flush tlb job timeout which is called by ttm_bo_delay_delete. So
to avoid the job submit after fence driver fini, call ttm_bo_lock_delayed_workqueue
before fence driver fini. And also put drm_sched_fini before waiting fence.

Set adev->gart.ptr to null to fix null pointer when calling amdgpu_gart_unbind
in amdgpu_bo_fini which is after gart_fini.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a11760ec3924..de0597d34588 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3594,6 +3594,7 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 {
 	dev_info(adev->dev, "amdgpu: finishing device.\n");
 	flush_delayed_work(&adev->delayed_init_work);
+	ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
 	adev->shutdown = true;
 
 	kfree(adev->pci_state);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 143a14f4866f..6d16f58ac91e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -531,6 +531,8 @@ void amdgpu_fence_driver_fini(struct amdgpu_device *adev)
 
 		if (!ring || !ring->fence_drv.initialized)
 			continue;
+		if (!ring->no_scheduler)
+			drm_sched_fini(&ring->sched);
 		r = amdgpu_fence_wait_empty(ring);
 		if (r) {
 			/* no need to trigger GPU reset as we are unloading */
@@ -539,8 +541,7 @@ void amdgpu_fence_driver_fini(struct amdgpu_device *adev)
 		if (ring->fence_drv.irq_src)
 			amdgpu_irq_put(adev, ring->fence_drv.irq_src,
 				       ring->fence_drv.irq_type);
-		if (!ring->no_scheduler)
-			drm_sched_fini(&ring->sched);
+
 		del_timer_sync(&ring->fence_drv.fallback_timer);
 		for (j = 0; j <= ring->fence_drv.num_fences_mask; ++j)
 			dma_fence_put(ring->fence_drv.fences[j]);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 23823a57374f..f1ede4b43d07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -202,6 +202,7 @@ void amdgpu_gart_table_vram_free(struct amdgpu_device *adev)
 		return;
 	}
 	amdgpu_bo_unref(&adev->gart.bo);
+	adev->gart.ptr = NULL;
 }
 
 /*
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
