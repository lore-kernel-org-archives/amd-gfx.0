Return-Path: <SRS0=X6dN=BQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EB5C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 01:24:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 336C322B40
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 01:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nhQrPlt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 336C322B40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A4556E104;
	Thu,  6 Aug 2020 01:24:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2ADA6E104
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2020 01:24:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVgW+0Vxsd0VggXzlv5hkYs+6HUQpUy2vZrw6hYXr+uzc07HO6qC4XDMQFzbZ5dwlZauLi2m31cN29OIJwMg2pAfDWmO6gIZe57WUzm2S3Z6XRYjqqOHmPchYdARW4WhubOmI+/l9S+4o8a/6JQsrm0/zu2tH9siuLGeP/o/RpwJkNkSe8+ZS1eoqrH7jluG2WdVgp1VI7pzXGYsVHij89JAc8iYNsDmRrD7cFNwNjL9agWIgO63J3Mw74s4CSSWwwxUH4FPjgK3jbgYO6KphJB7eVVn2Nib8PDsB5HLkRI4O5YUDN930LgIEgyvLVjwc0mT/dWopO8xoUx5/E7N8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKQ287mtAiOwNeQwW1EX6CEKPnUcAth86WHcVo4fp6A=;
 b=odFmx+ymkRmrOlQmiVvFVXPEK+Mk/nY5wLR/BG2puxVOW9TZI09pDjAjmGKgYIkvyvvnGoBMFP3Zf9i0TMBSf+Go58iRB15h2BEaccHHxHqrH4/KaShx1mQvFFTBD960VHUQSkRKwVWE6+jEXxAqOu1dHpg2BmL0YLu8yhq5qL0F9EmwuhmMvqno5UmIHPflNOdQjudeBG67s3lZzKEqOxbijxnFEHm63+Wp/KIgA6YF4dvXw7zJ82CYzWWFYgm9gXJ7Upjk6szWJyVDLQfjK5eWaKTnRTEW+wUyPA0OgoOa4oxqnGVtA2IxBjsbHc6triojuWGUesIPtHiE11ODZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKQ287mtAiOwNeQwW1EX6CEKPnUcAth86WHcVo4fp6A=;
 b=nhQrPlt2EIWXaJY8OzWK75TOFUYxpziKtz7Geuw+t1Vb+I340FlfywBpgcjJsVNhKQrSvhQ84BxiDwE6erXAPb+9SMyfURI14AMXlrMC5NeuSKqjkJRw/Xomf7R9I5xFZShPGFZgYj8EZAwc8cSE6G4Pvo+uf9Z+lxOwfcheReE=
Received: from DM5PR08CA0029.namprd08.prod.outlook.com (2603:10b6:4:60::18) by
 DM6PR12MB2809.namprd12.prod.outlook.com (2603:10b6:5:4a::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17; Thu, 6 Aug 2020 01:24:18 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::c6) by DM5PR08CA0029.outlook.office365.com
 (2603:10b6:4:60::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend
 Transport; Thu, 6 Aug 2020 01:24:18 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3261.16 via Frontend Transport; Thu, 6 Aug 2020 01:24:18 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 5 Aug 2020
 20:24:17 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 5 Aug 2020 20:24:15 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Tao.Zhou1@amd.com>, <Hawking.Zhang@amd.com>, <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: annotate a false positive locking dependency
Date: Thu, 6 Aug 2020 09:24:04 +0800
Message-ID: <20200806012404.32353-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5e7e621-4bb1-4170-fea7-08d839a7707f
X-MS-TrafficTypeDiagnostic: DM6PR12MB2809:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28095FC31704E7AA68D16974ED480@DM6PR12MB2809.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G80oZnVK6qi9xzgFpEMpEUoQkmt5qwnEqFZ/GhmKsUBhHYb5AZ+lBrzNDWcYtwGeOb1hyrJLzpgm4E/YQIAGOr/BR4/frVQhURHI8DDRKC5m9A7ycwrBV+H8iRPL9L0JV2M7s88ZuTGDKV4y8JQYFctZJ277/Q6F1jwYXCYwb7KZl/nN/ZQiLvvybi7sDlAEEv3ghmo8U6/MHODV4m5FgfF9KSRQp2n/9KLNyEcWpDQ/7U0QlZajYSJLDyUqk+7ulprT0sW35nosT5HdD2o9eE8SBdplv5mPj6cyq0Er6bnC3hHX2XNV3w/rqIDLVl4JXlFD7bsSe95SEzNiic0uUeFvBqxyoaT0epe9mCw3ZjyoluNuEXChgF7NYbwYeGJVY7OI/jSs1D8P7kcKvXgZwdCEcgCj55jyHLeqDcAJGFY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966005)(82310400002)(26005)(81166007)(4326008)(8676002)(2906002)(356005)(186003)(6666004)(83380400001)(7696005)(2616005)(5660300002)(70586007)(8936002)(70206006)(478600001)(1076003)(336012)(36756003)(316002)(86362001)(426003)(47076004)(110136005)(82740400003)(6636002)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2020 01:24:18.1833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e7e621-4bb1-4170-fea7-08d839a7707f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2809
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

[  264.483189] ======================================================
[  264.483487] WARNING: possible circular locking dependency detected
[  264.483781] 5.6.0-deli-v5.6-2848-g3f3109b0e75f #1 Tainted: G           OE
[  264.484076] ------------------------------------------------------
[  264.484370] kworker/39:1/567 is trying to acquire lock:
[  264.484663] ffffffffc15df4b0 (mgpu_info.mutex){+.+.}, at: amdgpu_unregister_gpu_instance+0x1d/0xc0 [amdgpu]
[  264.485081]
               but task is already holding lock:
[  264.485670] ffff965fd31647a0 (&adev->reset_sem){++++}, at: amdgpu_device_gpu_recover+0x264/0x1030 [amdgpu]
[  264.486074]
               which lock already depends on the new lock.

[  264.487043]
               the existing dependency chain (in reverse order) is:
[  264.487710]
               -> #3 (&adev->reset_sem){++++}:
[  264.488400]        down_write+0x49/0x120
[  264.488783]        amdgpu_device_gpu_recover+0x264/0x1030 [amdgpu]
[  264.489179]        amdgpu_ras_do_recovery+0x159/0x190 [amdgpu]
[  264.489544]        process_one_work+0x29e/0x630
[  264.489910]        worker_thread+0x3c/0x3f0
[  264.490279]        kthread+0x12f/0x150
[  264.490649]        ret_from_fork+0x3a/0x50
[  264.491020]
               -> #2 (&tmp->hive_lock){+.+.}:
[  264.491764]        __mutex_lock+0x95/0xa20
[  264.492137]        mutex_lock_nested+0x1b/0x20
[  264.492553]        amdgpu_get_xgmi_hive+0x352/0x400 [amdgpu]
[  264.492972]        amdgpu_xgmi_add_device+0xb8/0x460 [amdgpu]
[  264.493387]        amdgpu_device_init+0x12fb/0x1e10 [amdgpu]
[  264.493807]        amdgpu_driver_load_kms+0x5c/0x2c0 [amdgpu]
[  264.494226]        amdgpu_pci_probe+0x11d/0x200 [amdgpu]
[  264.494617]        local_pci_probe+0x47/0xa0
[  264.494998]        work_for_cpu_fn+0x1a/0x30
[  264.495369]        process_one_work+0x29e/0x630
[  264.495746]        worker_thread+0x22b/0x3f0
[  264.496124]        kthread+0x12f/0x150
[  264.496504]        ret_from_fork+0x3a/0x50
[  264.496876]
               -> #1 (xgmi_mutex){+.+.}:
[  264.497596]        __mutex_lock+0x95/0xa20
[  264.497954]        mutex_lock_nested+0x1b/0x20
[  264.498346]        amdgpu_get_xgmi_hive+0x38/0x400 [amdgpu]
[  264.498741]        amdgpu_xgmi_set_pstate+0x10/0x20 [amdgpu]
[  264.499126]        amdgpu_device_ip_late_init+0x219/0x230 [amdgpu]
[  264.499506]        amdgpu_device_init+0x1401/0x1e10 [amdgpu]
[  264.499886]        amdgpu_driver_load_kms+0x5c/0x2c0 [amdgpu]
[  264.500264]        amdgpu_pci_probe+0x11d/0x200 [amdgpu]
[  264.500608]        local_pci_probe+0x47/0xa0
[  264.500945]        work_for_cpu_fn+0x1a/0x30
[  264.501276]        process_one_work+0x29e/0x630
[  264.501603]        worker_thread+0x22b/0x3f0
[  264.501927]        kthread+0x12f/0x150
[  264.502239]        ret_from_fork+0x3a/0x50
[  264.502541]
               -> #0 (mgpu_info.mutex){+.+.}:
[  264.503126]        __lock_acquire+0x13ec/0x16e0
[  264.503411]        lock_acquire+0xb8/0x1c0
[  264.503693]        __mutex_lock+0x95/0xa20
[  264.504019]        mutex_lock_nested+0x1b/0x20
[  264.504354]        amdgpu_unregister_gpu_instance+0x1d/0xc0 [amdgpu]
[  264.504691]        amdgpu_device_gpu_recover+0x360/0x1030 [amdgpu]
[  264.505029]        amdgpu_ras_do_recovery+0x159/0x190 [amdgpu]
[  264.505334]        process_one_work+0x29e/0x630
[  264.505617]        worker_thread+0x3c/0x3f0
[  264.505897]        kthread+0x12f/0x150
[  264.506176]        ret_from_fork+0x3a/0x50
[  264.506453]
               other info that might help us debug this:

[  264.507267] Chain exists of:
                 mgpu_info.mutex --> &tmp->hive_lock --> &adev->reset_sem

[  264.508102]  Possible unsafe locking scenario:

[  264.508664]        CPU0                    CPU1
[  264.508945]        ----                    ----
[  264.509221]   lock(&adev->reset_sem);
[  264.509524]                                lock(&tmp->hive_lock);
[  264.509818]                                lock(&adev->reset_sem);
[  264.510111]   lock(mgpu_info.mutex);
[  264.510401]
                *** DEADLOCK ***

[  264.511224] 4 locks held by kworker/39:1/567:
[  264.511499]  #0: ffff961ff5c1d348 ((wq_completion)events){+.+.}, at: process_one_work+0x21f/0x630
[  264.511793]  #1: ffffafa90e233e58 ((work_completion)(&con->recovery_work)){+.+.}, at: process_one_work+0x21f/0x630
[  264.512100]  #2: ffffffffc16245d0 (&tmp->hive_lock){+.+.}, at: amdgpu_device_gpu_recover+0xb0/0x1030 [amdgpu]
[  264.512450]  #3: ffff965fd31647a0 (&adev->reset_sem){++++}, at: amdgpu_device_gpu_recover+0x264/0x1030 [amdgpu]

Remove the lock(&hive->hive_lock) out of amdgpu_get_xgmi_hive,
to disable its locking dependency on xgmi_mutex.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>
Change-Id: I2d9d80ee23f9f9ac6ce9e1b9e5e1b2b3530f5bdd

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 62ecac97fbd2..6c572db42d92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2840,7 +2840,7 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
 {
 	struct amdgpu_device *adev =
 		container_of(__work, struct amdgpu_device, xgmi_reset_work);
-	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev, 0);
+	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
 
 	/* It's a bug to not have a hive within this function */
 	if (WARN_ON(!hive))
@@ -4283,7 +4283,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 * We always reset all schedulers for device and all devices for XGMI
 	 * hive so that should take care of them too.
 	 */
-	hive = amdgpu_get_xgmi_hive(adev, false);
+	hive = amdgpu_get_xgmi_hive(adev);
 	if (hive) {
 		if (atomic_cmpxchg(&hive->in_reset, 0, 1) != 0) {
 			DRM_INFO("Bailing on TDR for s_job:%llx, hive: %llx as another already in progress",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5680f7eafcb1..5cd42740461c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1514,7 +1514,7 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 	struct amdgpu_device *remote_adev = NULL;
 	struct amdgpu_device *adev = ras->adev;
 	struct list_head device_list, *device_list_handle =  NULL;
-	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev, false);
+	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
 
 	/* Build list of devices to query RAS related errors */
 	if  (hive && adev->gmc.xgmi.num_physical_nodes > 1)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 67a756f4337b..19fd5ce3e857 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -336,7 +336,7 @@ static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *adev,
 
 
 
-struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev, int lock)
+struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev)
 {
 	int i;
 	struct amdgpu_hive_info *tmp;
@@ -349,8 +349,6 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev, int lo
 	for (i = 0 ; i < hive_count; ++i) {
 		tmp = &xgmi_hives[i];
 		if (tmp->hive_id == adev->gmc.xgmi.hive_id) {
-			if (lock)
-				mutex_lock(&tmp->hive_lock);
 			mutex_unlock(&xgmi_mutex);
 			return tmp;
 		}
@@ -374,9 +372,6 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev, int lo
 	mutex_init(&tmp->hive_lock);
 	atomic_set(&tmp->in_reset, 0);
 	task_barrier_init(&tmp->tb);
-
-	if (lock)
-		mutex_lock(&tmp->hive_lock);
 	tmp->pstate = AMDGPU_XGMI_PSTATE_UNKNOWN;
 	tmp->hi_req_gpu = NULL;
 	/*
@@ -392,7 +387,7 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev, int lo
 int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate)
 {
 	int ret = 0;
-	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev, 0);
+	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
 	struct amdgpu_device *request_adev = hive->hi_req_gpu ?
 						hive->hi_req_gpu : adev;
 	bool is_hi_req = pstate == AMDGPU_XGMI_PSTATE_MAX_VEGA20;
@@ -515,7 +510,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 		adev->gmc.xgmi.node_id = adev->gmc.xgmi.physical_node_id + 16;
 	}
 
-	hive = amdgpu_get_xgmi_hive(adev, 1);
+	hive = amdgpu_get_xgmi_hive(adev);
 	if (!hive) {
 		ret = -EINVAL;
 		dev_err(adev->dev,
@@ -524,6 +519,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 		goto exit;
 	}
 
+	mutex_lock(&hive->hive_lock);
+
 	top_info = &adev->psp.xgmi_context.top_info;
 
 	list_add_tail(&adev->gmc.xgmi.head, &hive->device_list);
@@ -587,10 +584,11 @@ int amdgpu_xgmi_remove_device(struct amdgpu_device *adev)
 	if (!adev->gmc.xgmi.supported)
 		return -EINVAL;
 
-	hive = amdgpu_get_xgmi_hive(adev, 1);
+	hive = amdgpu_get_xgmi_hive(adev);
 	if (!hive)
 		return -EINVAL;
 
+	mutex_lock(&hive->hive_lock);
 	task_barrier_rem_task(&hive->tb);
 	amdgpu_xgmi_sysfs_rem_dev_info(adev, hive);
 	mutex_unlock(&hive->hive_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 61720cd4a1ee..ae3249c1aafe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -51,7 +51,7 @@ struct amdgpu_pcs_ras_field {
 	uint32_t pcs_err_shift;
 };
 
-struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev, int lock);
+struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev);
 int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_device *adev);
 int amdgpu_xgmi_add_device(struct amdgpu_device *adev);
 int amdgpu_xgmi_remove_device(struct amdgpu_device *adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
