Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974E8C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 02:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF932065C
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 02:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hTfl1CLT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF932065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 037D489CAA;
	Tue, 11 Aug 2020 02:12:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9C1B89CAA
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 02:12:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kjdcp3ToIonAH6zpXXHtpfA9SEea2HGlPMwESGdq6O8b/gZuWMjNT/XGi7I4lfPA06V9cAy8nPKWT92F1woBg5OnG7GcNH/xrSdz6HsZpb8/wMKWRQqIucmuj7nnHEKd+y2sGI+RcP+HmEPGfSrR0+7gndWj42BppE7BqsGkihNXA7aSEkQz2PJ1wwW1vP2WPnW1LMO6N5WB/2wUM7LJytTSdF9jWF8xMxfpHS5hqqiJ0IbkNRER8yqoOTb6TsKgFOzfoujfuoflEN+PnCMQ0z1Zu9/ctIeNoHUHeavkpWfci01iAPmkxHqWL6PRn1Nz+cmRnvjqLkVoX8PxF5rnFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4eKkflf0E5ASOakgv+ouWS8Xc5tvT+xJHm3UgySTf0=;
 b=nunEOejvhUXM/iNopbrAZ9IfWIdT5zqiO/0fZvWWlWs2OGzZdJg0CUmIaBnTFcz5kpRf3K5/HvP0K8r9fwXLYw3AhGuJF+TvRrNRqCKgYuOf7YVLXFPAxnR0H6MV67HG5Qqt7peSGyx8l3eI8TtDF6co69FVsrNq6kGwJG0/yx9mGXCmRsMO9fprtoa0It2Kn3DaKxKpJCcKGlGgM3TTfB+oDaTyLYXfpQtgrV+J5uaro/17ZirOVgAmxZH/8guy6ILO1XoYgkdHBgJI3t0WEvqnovkcOjHKuAMFa1Zbv7hIJBg9Naxmxkd1ZEFXEUTzUz8uIs6rD6Nrw1x2E0s0xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4eKkflf0E5ASOakgv+ouWS8Xc5tvT+xJHm3UgySTf0=;
 b=hTfl1CLT/u79toB1ainoe/1GoRTombATGmpHR2QIqlL0qfGUX7Xd87Wz8AucsYJuXTyK6rDIPtTpDRZhpsum9b25v71ju4AD9Umwy7auWqEmKYHFz23Qzeze+2uJs2SvpAmlRnOGy68TnjEJSG0fNSr43AGa69u8O0XhBHzhgH8=
Received: from BN6PR13CA0051.namprd13.prod.outlook.com (2603:10b6:404:11::13)
 by BL0PR12MB2465.namprd12.prod.outlook.com (2603:10b6:207:45::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Tue, 11 Aug
 2020 02:12:43 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::b) by BN6PR13CA0051.outlook.office365.com
 (2603:10b6:404:11::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.10 via Frontend
 Transport; Tue, 11 Aug 2020 02:12:43 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3261.16 via Frontend Transport; Tue, 11 Aug 2020 02:12:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 10 Aug
 2020 21:12:41 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 10 Aug
 2020 21:12:40 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 10 Aug 2020 21:12:39 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>,
 <christian.koenig@amd.com>, <daniel@ffwll.ch>
Subject: [PATCH v3] drm/amdgpu: annotate a false positive recursive locking
Date: Tue, 11 Aug 2020 10:12:24 +0800
Message-ID: <20200811021224.3688-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cf00378-7b80-4295-ace3-08d83d9c072a
X-MS-TrafficTypeDiagnostic: BL0PR12MB2465:
X-Microsoft-Antispam-PRVS: <BL0PR12MB24656BFFACBB0AEAD6AC0CC5ED450@BL0PR12MB2465.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4qTh42gLIi5lmgE4NAe0/EChEI+oxiqEieW1l5rmbRTw02LPVec8iRHSKClkArZgtSWAYMkc03OCnkO5+MC5f8D6AsYadecIwpwuxxQXHCLzKTfJJEKOkjHMIGyKby8bff2jhH+cp7v+tR0f5tu2uZ8Euu8eYSenLOrOSEey2jwgn8tLYh03uEv6SA7K1hNLueJJ+09ECwRBIdafsVorbE9lInZIsKhl+tSS0fMhGj6VEzzcXIk6J+VD6T4k0DceL+Y2ZESTHPyUc1c4tc/qCuxZVmhmIMygrJw7ISYrf/nXk0XSow073fHBMGnec6PkB4vBJxWcEwQAeK4s7B4X4Go5ddpT0WzcA40to1HO2mswlqPTb+jr7sy6BkKttzd2rlrJFvQ//jPSOskfGG6nKVF4drwzoWiFxJ/w2ufZ85c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(46966005)(8936002)(82740400003)(83380400001)(4326008)(7696005)(70206006)(8676002)(478600001)(36756003)(110136005)(5660300002)(47076004)(70586007)(86362001)(26005)(2616005)(186003)(82310400002)(426003)(6666004)(2906002)(356005)(1076003)(336012)(316002)(81166007)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 02:12:41.6915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf00378-7b80-4295-ace3-08d83d9c072a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2465
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

[  584.110304] ============================================
[  584.110590] WARNING: possible recursive locking detected
[  584.110876] 5.6.0-deli-v5.6-2848-g3f3109b0e75f #1 Tainted: G           OE
[  584.111164] --------------------------------------------
[  584.111456] kworker/38:1/553 is trying to acquire lock:
[  584.111721] ffff9b15ff0a47a0 (&adev->reset_sem){++++}, at: amdgpu_device_gpu_recover+0x262/0x1030 [amdgpu]
[  584.112112]
               but task is already holding lock:
[  584.112673] ffff9b1603d247a0 (&adev->reset_sem){++++}, at: amdgpu_device_gpu_recover+0x262/0x1030 [amdgpu]
[  584.113068]
               other info that might help us debug this:
[  584.113689]  Possible unsafe locking scenario:

[  584.114350]        CPU0
[  584.114685]        ----
[  584.115014]   lock(&adev->reset_sem);
[  584.115349]   lock(&adev->reset_sem);
[  584.115678]
                *** DEADLOCK ***

[  584.116624]  May be due to missing lock nesting notation

[  584.117284] 4 locks held by kworker/38:1/553:
[  584.117616]  #0: ffff9ad635c1d348 ((wq_completion)events){+.+.}, at: process_one_work+0x21f/0x630
[  584.117967]  #1: ffffac708e1c3e58 ((work_completion)(&con->recovery_work)){+.+.}, at: process_one_work+0x21f/0x630
[  584.118358]  #2: ffffffffc1c2a5d0 (&tmp->hive_lock){+.+.}, at: amdgpu_device_gpu_recover+0xae/0x1030 [amdgpu]
[  584.118786]  #3: ffff9b1603d247a0 (&adev->reset_sem){++++}, at: amdgpu_device_gpu_recover+0x262/0x1030 [amdgpu]
[  584.119222]
               stack backtrace:
[  584.119990] CPU: 38 PID: 553 Comm: kworker/38:1 Kdump: loaded Tainted: G           OE     5.6.0-deli-v5.6-2848-g3f3109b0e75f #1
[  584.120782] Hardware name: Supermicro SYS-7049GP-TRT/X11DPG-QT, BIOS 3.1 05/23/2019
[  584.121223] Workqueue: events amdgpu_ras_do_recovery [amdgpu]
[  584.121638] Call Trace:
[  584.122050]  dump_stack+0x98/0xd5
[  584.122499]  __lock_acquire+0x1139/0x16e0
[  584.122931]  ? trace_hardirqs_on+0x3b/0xf0
[  584.123358]  ? cancel_delayed_work+0xa6/0xc0
[  584.123771]  lock_acquire+0xb8/0x1c0
[  584.124197]  ? amdgpu_device_gpu_recover+0x262/0x1030 [amdgpu]
[  584.124599]  down_write+0x49/0x120
[  584.125032]  ? amdgpu_device_gpu_recover+0x262/0x1030 [amdgpu]
[  584.125472]  amdgpu_device_gpu_recover+0x262/0x1030 [amdgpu]
[  584.125910]  ? amdgpu_ras_error_query+0x1b8/0x2a0 [amdgpu]
[  584.126367]  amdgpu_ras_do_recovery+0x159/0x190 [amdgpu]
[  584.126789]  process_one_work+0x29e/0x630
[  584.127208]  worker_thread+0x3c/0x3f0
[  584.127621]  ? __kthread_parkme+0x61/0x90
[  584.128014]  kthread+0x12f/0x150
[  584.128402]  ? process_one_work+0x630/0x630
[  584.128790]  ? kthread_park+0x90/0x90
[  584.129174]  ret_from_fork+0x3a/0x50

Each adev has owned lock_class_key to avoid false positive
recursive locking.

v2:
1. register adev->lock_key into lockdep, otherwise lockdep will
report the below warning

[ 1216.705820] BUG: key ffff890183b647d0 has not been registered!
[ 1216.705924] ------------[ cut here ]------------
[ 1216.705972] DEBUG_LOCKS_WARN_ON(1)
[ 1216.705997] WARNING: CPU: 20 PID: 541 at kernel/locking/lockdep.c:3743 lockdep_init_map+0x150/0x210

v3:
change to use down_write_nest_lock to annotate the false dead-lock
warning.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 62ecac97fbd2..8a55b0bc044a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4145,12 +4145,15 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 	return r;
 }
 
-static bool amdgpu_device_lock_adev(struct amdgpu_device *adev)
+static bool amdgpu_device_lock_adev(struct amdgpu_device *adev, struct amdgpu_hive_info *hive)
 {
 	if (atomic_cmpxchg(&adev->in_gpu_reset, 0, 1) != 0)
 		return false;
 
-	down_write(&adev->reset_sem);
+	if (hive) {
+		down_write_nest_lock(&adev->reset_sem, &hive->hive_lock);
+	} else
+		down_write(&adev->reset_sem);
 
 	atomic_inc(&adev->gpu_reset_counter);
 	switch (amdgpu_asic_reset_method(adev)) {
@@ -4312,7 +4315,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 	/* block all schedulers and reset given job's ring */
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
-		if (!amdgpu_device_lock_adev(tmp_adev)) {
+		if (!amdgpu_device_lock_adev(tmp_adev, hive)) {
 			DRM_INFO("Bailing on TDR for s_job:%llx, as another already in progress",
 				  job ? job->base.id : -1);
 			r = 0;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
