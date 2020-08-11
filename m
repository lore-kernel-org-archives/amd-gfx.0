Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C312C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 09:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F048B20756
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 09:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="n4gucbGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F048B20756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FCC76E4D2;
	Tue, 11 Aug 2020 09:32:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 786416E4D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 09:32:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKav6WwDFmnWK/KDg05/L8gLNYaXR7OQg3Df5u6kd8jPQyUQlNhq4fCtQ5RrD7ZQiuqKdR3Zg50dH9htp+WJ5Jlku+wCsaQvMDFbBYqW3gK1xvyrhLXQ417QSeNYq63ShrBrEwkUFtz8niajl615eQkJWWFG+mBRyQDIn+/H1JIjJF9uqy/TwPKjo0z2OTxkkanJvuHSq4yq8Lmu2SPiNSOgFjqYfdqC0vQucV2Ua54IgT4KHurp8Ju1FjOCrTsOLBK6U16K4KKjHW+r6VLh94fxd8cEURINilsoj72tugE7uH0LVEhCNfwnato34N5a3OZW8ozbAj1eOweth49vAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cigfCvgGm1KqRyJOQ41/6zECO2c1Q7jGyqgx12hWMUk=;
 b=ZzkD30MJP/GBYl0TiBc3WMCgDe7PMjjjsPOz+QqQ7sfnxaqbMIITSBpKRLmp932od6UVRnSyfM2/oizrsAeVmux/bH3byVkXyE7vICOeHYCychfIf+T8fGulmb/upAKc4FYB+8tjpUX1ViExNUIZyyS3YpW9wiLVSNLiwMn8RCi97wnI1suexyBs4qpVrSksBgES8KCA9/CLhoLjNqGvfVBS58Q0Iv/m2ACaKkdULbRs+vznmrknd14+zEe14EAOKVqekulMM8Xn0fGDcBn68QOM4576IdbIvwLBfZpTDDXOaiXMNQto0zWQsf6RKHpP70WfyQTEuq+y8Ceef8j5NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cigfCvgGm1KqRyJOQ41/6zECO2c1Q7jGyqgx12hWMUk=;
 b=n4gucbGRC1lhvyJcNnbo/uhVpdhQ4N9AHIDP948rbMRKIOydvzxxOzjcoM9f0j/OTFA4D0gjhybrOJ5xUP4bJoO7Cn7VtZ4qz8pnP3D0Ydxc/WpBQNaAOKUyMUfxQGMIlSBjy1FD3XwnF9gi5andU/9gO6xah4RxesAKpeeIxLo=
Received: from CO2PR06CA0066.namprd06.prod.outlook.com (2603:10b6:104:3::24)
 by BYAPR12MB2760.namprd12.prod.outlook.com (2603:10b6:a03:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Tue, 11 Aug
 2020 09:32:21 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::e4) by CO2PR06CA0066.outlook.office365.com
 (2603:10b6:104:3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend
 Transport; Tue, 11 Aug 2020 09:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3261.16 via Frontend Transport; Tue, 11 Aug 2020 09:32:20 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 11 Aug
 2020 04:32:19 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 11 Aug 2020 04:32:18 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: fix a potential circular locking dependency
Date: Tue, 11 Aug 2020 17:32:08 +0800
Message-ID: <20200811093208.13149-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a9875d6-cbe3-4a95-3295-08d83dd97282
X-MS-TrafficTypeDiagnostic: BYAPR12MB2760:
X-Microsoft-Antispam-PRVS: <BYAPR12MB27602A63B5AD544730C1BED9ED450@BYAPR12MB2760.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i1pgMMT0DIzXZmOMQHEG5Ct+rSc7mohJricLLqw0v482yBlDmgx5As1kR9ETBgdN6TIoT8+CVBZoIaNd9JN1Q33AdnH9Bv/u/bRDhhF/e2ovn9VoFioyUFyIaMMV6jAXGSkdCwqk1jPK0tO6UAU51VJ+ChlivCpctVlVyeVapOobjhQTRzuGU3oy3L/bBimyHBqdBuX/0bGZ27hrFHpZUrus+J8unP56FTGITY5mTx7c5qOEYAj4HPsJeW0cL/Qb8lUPmaAVPlX7HUipVmz2U57WOMEQAoVLVeuUvneFPiaQNzM8VghFQQsgXjzpSHjZ3T+zZLiGDB3I/COIlRUym0fQz0d326NNCpwuqKRBeH0xJom11Hn+icUsVSxx+Gzj1D9AYf1aCHMqDjYLHvMh+hqeQqjIfOigB7B5ZNGyORI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(46966005)(81166007)(70586007)(2906002)(5660300002)(83380400001)(6636002)(8936002)(478600001)(86362001)(70206006)(2616005)(426003)(8676002)(7696005)(110136005)(82740400003)(316002)(336012)(4326008)(1076003)(6666004)(186003)(47076004)(82310400002)(26005)(356005)(36756003)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 09:32:20.9339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9875d6-cbe3-4a95-3295-08d83dd97282
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2760
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[  653.902305] ======================================================
[  653.902928] WARNING: possible circular locking dependency detected
[  653.903517] 5.6.0-deli-v5.6-2848-g3f3109b0e75f #1 Tainted: G           OE
[  653.904098] ------------------------------------------------------
[  653.904675] amdgpu_test/3975 is trying to acquire lock:
[  653.905241] ffff97848f8647a0 (&adev->reset_sem){.+.+}, at: amdgpu_gem_va_ioctl+0x286/0x4f0 [amdgpu]
[  653.905953]
               but task is already holding lock:
[  653.907087] ffff9744adbee1f8 (reservation_ww_class_mutex){+.+.}, at: ttm_eu_reserve_buffers+0x1ae/0x520 [ttm]
[  653.907694]
               which lock already depends on the new lock.

[  653.909423]
               the existing dependency chain (in reverse order) is:
[  653.910594]
               -> #1 (reservation_ww_class_mutex){+.+.}:
[  653.911759]        __ww_mutex_lock.constprop.15+0xca/0x1120
[  653.912350]        ww_mutex_lock+0x73/0x80
[  653.913044]        amdgpu_amdkfd_alloc_gtt_mem+0xde/0x380 [amdgpu]
[  653.913724]        kgd2kfd_device_init+0x13f/0x5e0 [amdgpu]
[  653.914388]        amdgpu_amdkfd_device_init+0x155/0x190 [amdgpu]
[  653.915033]        amdgpu_device_init+0x1303/0x1e10 [amdgpu]
[  653.915685]        amdgpu_driver_load_kms+0x5c/0x2c0 [amdgpu]
[  653.916349]        amdgpu_pci_probe+0x11d/0x200 [amdgpu]
[  653.916959]        local_pci_probe+0x47/0xa0
[  653.917570]        work_for_cpu_fn+0x1a/0x30
[  653.918184]        process_one_work+0x29e/0x630
[  653.918803]        worker_thread+0x22b/0x3f0
[  653.919427]        kthread+0x12f/0x150
[  653.920047]        ret_from_fork+0x3a/0x50
[  653.920661]
               -> #0 (&adev->reset_sem){.+.+}:
[  653.921893]        __lock_acquire+0x13ec/0x16e0
[  653.922531]        lock_acquire+0xb8/0x1c0
[  653.923174]        down_read+0x48/0x230
[  653.923886]        amdgpu_gem_va_ioctl+0x286/0x4f0 [amdgpu]
[  653.924588]        drm_ioctl_kernel+0xb6/0x100 [drm]
[  653.925283]        drm_ioctl+0x389/0x450 [drm]
[  653.926013]        amdgpu_drm_ioctl+0x4f/0x80 [amdgpu]
[  653.926686]        ksys_ioctl+0x98/0xb0
[  653.927357]        __x64_sys_ioctl+0x1a/0x20
[  653.928030]        do_syscall_64+0x5f/0x250
[  653.928697]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  653.929373]
               other info that might help us debug this:

[  653.931356]  Possible unsafe locking scenario:

[  653.932647]        CPU0                    CPU1
[  653.933287]        ----                    ----
[  653.933911]   lock(reservation_ww_class_mutex);
[  653.934530]                                lock(&adev->reset_sem);
[  653.935154]                                lock(reservation_ww_class_mutex);
[  653.935766]   lock(&adev->reset_sem);
[  653.936360]
                *** DEADLOCK ***

[  653.938028] 2 locks held by amdgpu_test/3975:
[  653.938574]  #0: ffffb2a862d6bcd0 (reservation_ww_class_acquire){+.+.}, at: amdgpu_gem_va_ioctl+0x39b/0x4f0 [amdgpu]
[  653.939233]  #1: ffff9744adbee1f8 (reservation_ww_class_mutex){+.+.}, at: ttm_eu_reserve_buffers+0x1ae/0x520 [ttm]

change the order of reservation_ww_class_mutex and adev->reset_sem in
amdgpu_gem_va_ioctl the same as ones in amdgpu_amdkfd_alloc_gtt_mem, to
avoid potential dead lock.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index ee1e8fff83b2..fc889c477696 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -652,6 +652,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		abo = NULL;
 	}
 
+	down_read(&adev->reset_sem);
+
 	amdgpu_vm_get_pd_bo(&fpriv->vm, &list, &vm_pd);
 
 	r = ttm_eu_reserve_buffers(&ticket, &list, true, &duplicates);
@@ -670,8 +672,6 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		bo_va = NULL;
 	}
 
-	down_read(&adev->reset_sem);
-
 	switch (args->operation) {
 	case AMDGPU_VA_OP_MAP:
 		va_flags = amdgpu_gem_va_map_flags(adev, args->flags);
@@ -701,12 +701,11 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
 					args->operation);
 
-	up_read(&adev->reset_sem);
-
 error_backoff:
 	ttm_eu_backoff_reservation(&ticket, &list);
 
 error_unref:
+	up_read(&adev->reset_sem);
 	drm_gem_object_put_unlocked(gobj);
 	return r;
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
