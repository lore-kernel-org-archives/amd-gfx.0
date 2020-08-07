Return-Path: <SRS0=Hu2c=BR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4363EC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 07:53:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED214221E5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 07:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X7PZneYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED214221E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 858516E053;
	Fri,  7 Aug 2020 07:53:36 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam04on0608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe4d::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 819056E053
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2020 07:53:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/b2DbuHn7uZ0GkIOXlxjKXdbaGvZSRjQn35uRkoJ7YWiCjqJzBS6ZObMYp1pIvg12z0nP4CxWjgcvoB/O7nGmxpwO85vj6Wx2g4+EOhY2Cj4rIKGAdem+cNCS1LaN608BjadXp4uJluCY9Le+dML3NbpMcZaVTXzaxjeULdCRrypmZTldgO7Pi5ysdtUMgkEPxv9fpdjQBT5JtOCHFvpRH/DhWTnIBuYbZ7QMZXo67bM8TrjKuahc3GHFDCvRrK7cOhHwV98Fj0R4ip3EFE7luWFHlk1bZAq9D34VLfTrE8QiVyEDBM10i/iDwSJjD/PQDaNw3NCZKuLCF+FYdIyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0/ttBkANljb0IGvFtvp89LD7RUuc3ZrSNEVASX69AY=;
 b=eKyaGcLpwH4MIKrwIubQer1gS596uSoaLqY42ntUBW8jg08p9ryt8da2MvFF0nbcx6GTIypoWQTHwfJ48IsxWequTS6uTCrnCs5BNXrYLgL4mO5uVuhVxw+Bkqm09LdqE6W+aMphf9wOIVukr1yz2UwQwBKMLg3EGrHOeL7994A4WUjJNqFHUKY7j9XZBpsZgDffn1zZPfGmTzTigsKtvNjw1rQhuaxAbFdPfnhBSvKqIpQgYlH7zG7QE0koNFmrNA5I+n03i7FACMKYQmc0a7q83dvM/3vldJqY3SdSTwgP/M8+0m1x9tRXHDbEMdqFKmbuz6U5ygCeu9tG28fOkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0/ttBkANljb0IGvFtvp89LD7RUuc3ZrSNEVASX69AY=;
 b=X7PZneYlTRFwO5zoSvBQOslwp2HwshSim96XP8c7uO+Ku272/ctaNZIc6mpAq8w8Xo8HRHmsv1K3q5IAcEcbfGOWePL6f4ruLr6vrNi2DlDXd55oNuI3hvx7ptBGSIHR/S2fWjcxTJJy53yzmzSK/bFUOcc9ho2+/LAYQlIs1aE=
Received: from DM5PR08CA0048.namprd08.prod.outlook.com (2603:10b6:4:60::37) by
 MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Fri, 7 Aug 2020 07:53:33 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::f8) by DM5PR08CA0048.outlook.office365.com
 (2603:10b6:4:60::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend
 Transport; Fri, 7 Aug 2020 07:53:33 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Fri, 7 Aug 2020 07:53:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 7 Aug 2020
 02:53:33 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 7 Aug 2020
 02:53:32 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 7 Aug 2020 02:53:31 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v2] drm/amdgpu: annotate a false positive recursive locking
Date: Fri, 7 Aug 2020 15:53:22 +0800
Message-ID: <20200807075322.17254-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6252590d-478f-4fce-3b51-08d83aa6fbcc
X-MS-TrafficTypeDiagnostic: MN2PR12MB4048:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4048A5D1173FD12D914768A1ED490@MN2PR12MB4048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ERHMrRdzJn5EnHDbvskjUmdKgcN7R69a9VuC0oT8ylxMtpRGhq8w61/PgnMUJ3YvsWLW0TSJED3iRK5u/xxZTd1D8q0DjP0ngmpGGNp1mzTuzHQMHhBo4/WbCvPnuYkEBHEOsyFpLLPk61llKzhs+gtqqZSuxFykNOzid6ZoTZix68wFSP3yiHdMLVX3x38Zy8aGLMD6Fa9Uv0YQ9NnCLBXBDdQ6VRwmgVpYh8XLxuCxDEhdvQBK7AizbWR26vkyJNFfLfCUvqR3fKJS6X+w8wxs6i/mhLwDT4UBO0r3knHwx7gDGQeWGLmbW0HQUq5tgUhO+eFI4Hy1qou0b6tFv5LlJdVMoqzpJD9oFGe4KRfci/KXglyoZsFNPyDPaamMpjeXnQpHkJzqOOnS2vnSmaLj7YPBlRosm0E/oHhvpSk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966005)(6666004)(4326008)(70586007)(8936002)(426003)(70206006)(110136005)(2906002)(316002)(82740400003)(47076004)(81166007)(5660300002)(356005)(82310400002)(6636002)(86362001)(2616005)(186003)(1076003)(36756003)(8676002)(7696005)(26005)(83380400001)(336012)(478600001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 07:53:33.5543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6252590d-478f-4fce-3b51-08d83aa6fbcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
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

Signed-off-by: Dennis Li <Dennis.Li@amd.com>
Change-Id: I7571efeccbf15483982031d00504a353031a854a

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e97c088d03b3..766dc8f8c8a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -967,6 +967,7 @@ struct amdgpu_device {
 	atomic_t                        in_gpu_reset;
 	enum pp_mp1_state               mp1_state;
 	struct rw_semaphore	reset_sem;
+	struct lock_class_key lock_key;
 	struct amdgpu_doorbell_index doorbell_index;
 
 	struct mutex			notifier_lock;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 62ecac97fbd2..ae0a576f9895 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3037,6 +3037,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->virt.vf_errors.lock);
 	hash_init(adev->mn_hash);
 	init_rwsem(&adev->reset_sem);
+	lockdep_register_key(&adev->lock_key);
+	lockdep_set_class(&adev->reset_sem, &adev->lock_key);
 	atomic_set(&adev->in_gpu_reset, 0);
 	mutex_init(&adev->psp.mutex);
 	mutex_init(&adev->notifier_lock);
@@ -3411,6 +3413,8 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 		amdgpu_pmu_fini(adev);
 	if (adev->discovery_bin)
 		amdgpu_discovery_fini(adev);
+
+	lockdep_unregister_key(&adev->lock_key);
 }
 
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
