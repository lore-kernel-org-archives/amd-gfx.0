Return-Path: <SRS0=X6dN=BQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717AEC433E1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 11:50:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3832422D04
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 11:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W9jS9btI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3832422D04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 459CA6E151;
	Thu,  6 Aug 2020 07:02:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEFF56E151
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2020 07:02:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M49XDH3zbY6V6l6xT0u+Sc6xiIwSXcqKrptLmJ720RcPjwpqwqmAzHkm5Fal5TEcoGoIZLaT4cqYDJQxaewA/kh7gLOqKgoVwTT1LH4HoYiPiJngzRI0h285/XLZKvERGBZBYI/we2TP61ybNTY5xF8Er98sGebtDlCxhYRcV/+4dtgh81cxUd2z00u7Wq1bawLAS6B0CjvezGUA6V0vfesoc1Qt01f2mWYh5Jh/53RAlBH/xKP25hdrCirX5iLlZtPO6aV/0Y98r41AmwAMitrpP1HY7L6bZYRBk1HLbLlZY9cadkwiTxZOIcrGPKRgqP86z8RPIXrSbIIU3NvvLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3kqO4oEuYmGq8znx+5mO9PAyp2sbX9BihmnBSMxpw4=;
 b=j6xu+546bsOqwlNGHoqQB1OHQPJFtJvNgkYJvY0cT5TcB2QtDuTRoTgVC+UW1yXQe4iRDgVD+DqUrFrdfoCfrS5yDSOHLYQ8bk1hUkEuqluegGbKxBttNslw1/MfpkjJIIgN9nAfa7y+Cg7SlbFaJM7FQtwPQ+bRAJOkyTaIPyG3N2rmutlbmVslR17X42LoLWXU/fuX9ujAgYBD5Y9tTLNjNUYuZLLdmK8nL/Z2HRxzJyV1Px5Ho+TDdzJwNYBLlEc5TNpw/R1A1TDoOO+Xz5BykuF8uBVaPpkErQXws8mDGN5VW680IFJq9hMhCXYa2AvN3QOr8sAJxCwcXKjK4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3kqO4oEuYmGq8znx+5mO9PAyp2sbX9BihmnBSMxpw4=;
 b=W9jS9btIP0Hu2CVdTpdziwKeFreD7bvC4XeYt7Fgglga9YWW2UNy+l+3loY5MVzyVbPlN5yDEZ0115yYOaiPg22P83AMo1bupRnqAJ1Z05bPtA7By7g9Znjl5MrAiobB0QKje5GGvd3zDw//sugdFegxYqdfO6iwh3fY3ADorMo=
Received: from DM5PR15CA0060.namprd15.prod.outlook.com (2603:10b6:3:ae::22) by
 DM6PR12MB3996.namprd12.prod.outlook.com (2603:10b6:5:1c1::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Thu, 6 Aug 2020 07:02:52 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::92) by DM5PR15CA0060.outlook.office365.com
 (2603:10b6:3:ae::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18 via Frontend
 Transport; Thu, 6 Aug 2020 07:02:52 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3261.16 via Frontend Transport; Thu, 6 Aug 2020 07:02:52 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 6 Aug 2020
 02:02:51 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 6 Aug 2020 02:02:49 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: annotate a false positive recursive locking
Date: Thu, 6 Aug 2020 15:02:30 +0800
Message-ID: <20200806070230.21457-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a9ff189-06e8-4dbe-cd97-08d839d6bc87
X-MS-TrafficTypeDiagnostic: DM6PR12MB3996:
X-Microsoft-Antispam-PRVS: <DM6PR12MB399607ADFDE4EBCD2F1BB597ED480@DM6PR12MB3996.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yKVrfBvSFGrTtyNjGVEp8FwL1AXuI0c4WLTke3eTIyvR/oymoaNMtYk60+x1K9pomTpniK1d9fFZZAb/T2uikY3U7IwmD9anw4tgxXCP2ImaHiHmnZxhWVUjD2utdto1ez6bciqfbJosnX6tr0+O+xKudlgU3EGeZTs3e3f4+xMqeFg/xze4+Urub8EfQ12fYcM5XW0uTS3CDkydh1A+HLQ4ct0Gc+44UjFinQNp001GoYaTnuKrjbgDd9H6Q1lCcCHD+/FuO1PctQt8K8rlIg7pAXU3MEuk4rhx0v9wuLbm3rN8+g7smniX7YVzibN6tfNcJGy2PNaF5oHFU+q4SYATGEBjqh3kFvJMAcsV9drCf9PTF+MKc1U5vGczbwGpth3eA+eL3ou0Vl3LDLGcrAVSUO7nJyi34cJu5SXPtog=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(46966005)(110136005)(6666004)(82740400003)(82310400002)(86362001)(26005)(186003)(336012)(47076004)(478600001)(36756003)(316002)(83380400001)(356005)(81166007)(2616005)(70586007)(70206006)(8676002)(4326008)(426003)(8936002)(7696005)(1076003)(2906002)(6636002)(5660300002)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2020 07:02:52.0686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9ff189-06e8-4dbe-cd97-08d839d6bc87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3996
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
index 6c572db42d92..d78df9312d34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3037,6 +3037,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->virt.vf_errors.lock);
 	hash_init(adev->mn_hash);
 	init_rwsem(&adev->reset_sem);
+	lockdep_set_class(&adev->reset_sem, &adev->lock_key);
 	atomic_set(&adev->in_gpu_reset, 0);
 	mutex_init(&adev->psp.mutex);
 	mutex_init(&adev->notifier_lock);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
