Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA50C433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 08:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F7BD60233
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 08:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7BD60233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A90C6E103;
	Mon, 22 Mar 2021 08:12:15 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2063.outbound.protection.outlook.com [40.107.95.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AF156E103
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 08:12:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsWYG31RYfbhB7tYfvl3Et4bPzJ7rqs244ZgP/1sTJXfD1EMHojFrdfrLpp4p06jJpF/3y3clfztL/CMtZZJGdTMIWxAAa+/pljlBKQWhUF77sLprctnMu6BjXplCFvjaqMZ9GHE6KnilYcAvFZLujkCgR/kNbM0ocbVfNVRnuwLdTMvzIw4y3fv1FaMiaVW+TpBMF4ztEmtN+ej5UoiHOiAOCQv8SzOgIeVLR/zr/fTC90VdHCWKI5ZRD25MIq+BBn7FyflV2t6TreNj8WUJDxzasMafDy7bJossg2G9bbyoe/eXmoXgY3k3MnDk56/Y+fbVJbvgVGz2UV9VggP0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+4X22nt5bTuGw8EGVTDUh+11iR5B3sf01BaYaUBbyo=;
 b=k0kuWZYPUxxBsa9ThCGYrOYsY/i0B/Cs3NrP4TcKGyn3Ys6boEN6W5tVvIqcxWZdy0tUUTmiqeF8ervqD93L1t4njLQT5pYDU+3O86nerjeLRhrdJKNB7WTMJcZG8+fQUufEI9VStV9xk07YWCXMjCX8jLbT8NFJ/SWVEDyFU22k98YtNb+B+M5KAWV9c/Vt33PFHqbkB4KAeKWQxs/I/p7jARAWxHAcq2NkpfuKcWgoZuaeQ+PDEJr41bQJPj+TRdxBcihpFl4V/4UcAQiurDy9j/TX+XwYqgleIfO3W8DoVGUR5yh3/2XE0he7LfgVw4g7yNTOnCWzJmN1/m1uvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+4X22nt5bTuGw8EGVTDUh+11iR5B3sf01BaYaUBbyo=;
 b=OuWqWkwrFhfxbiuDBZLMLlgUV1zlFz1FEGT2/7zhMaMQaHXmixuvJgS6ZMKTx54rlkmrgsaAtjd1grzKHKyLxngiMH+zXq0mt4tBrMZxa4vq3iRtqIEdREViLh5IW9fjini0Is1+wos3Mt8YGsZwDSEKgWsaf/wm/ldvQmMlHs4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Mon, 22 Mar 2021 08:12:12 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::292c:5927:cb7c:cffb]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::292c:5927:cb7c:cffb%7]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 08:12:12 +0000
From: Lang Yu <Lang.Yu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/dispaly: fix deadlock issue in amdgpu reset
Date: Mon, 22 Mar 2021 16:11:38 +0800
Message-Id: <20210322081138.3484804-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:202:2e::22) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lang-desktop.amd.com (180.167.199.189) by
 HK2PR06CA0010.apcprd06.prod.outlook.com (2603:1096:202:2e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 08:12:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f8ba1f13-1cae-48fe-ed7b-08d8ed0a322e
X-MS-TrafficTypeDiagnostic: DM6PR12MB2939:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB293953D0D4AEB60E4AB4B104FB659@DM6PR12MB2939.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3yEKvNEtBINgtSLJBqcOT1KXTZfnKmgZA+3TWyvxNZw/64ogf/ftwqDJhXlr9Y6TtP74SLMF8YUMV+y7sfJkLr+1/L8QNJN+yqvgLJTQRKIdTnyqluI6bz88dSqahXNL+fQsGLD5wCtfCxkRN7IBiLSZ6BAOx11BWzViKzRQzPOB2TIoeqDPWMq7hJNogSbrJbMka3mT5vxjDdSPkyT28Qbc/gJXL4VbugSi0TK0lM2iscaKz/lls5ezeWyiq2G2vjEsBTdwMrIjZL3J/aGmbmFJ93EBy0zDx6WNH5cXKuShhQn/1qFa3qI8dpt8CPqO5hKjjWF25PKUFDKEKAROeDiV5WD9087Khyi+Pqt01GMPVtpfdZ6lXw/SukOYUc1nl/yFaokzxVVw01kcNcES86QovTUrZNnkapJB0mFNtswGZFcY0NFuyJhbCm7DI8JCPoSUvKIqx9SypEBIjWFB6dySdyNvh7vxKQOpSBHcxm/qVUCwfuJInxK3RRuBSwAuD6jRXFyimnznJu+EI2qJIAV+kb2SUsUTvvo9Ye4hoT6bEXU8PBRiPG2b10g/XYYx6UAmiPWZCRU435+66lwZofQN4mpUQ1P80PWffHrDrFI5W6mhvDhOpCrySrrsq17v6h68fM5NHKRT8sWZS/zWWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(4326008)(1076003)(36756003)(66556008)(38100700001)(6666004)(6916009)(66946007)(83380400001)(66476007)(5660300002)(16526019)(186003)(26005)(8676002)(7696005)(52116002)(86362001)(478600001)(8936002)(2616005)(956004)(6486002)(2906002)(54906003)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?V1i+BUhTGqNsqiUWjE2Fa73dv/BUHFHLBd+mcClvX1o9Gljw5665uoQNVFyH?=
 =?us-ascii?Q?JkzJnCtxjCe6+jhBu0eMUvOS6mE8D1xJC61l2HGVxogsgUEVaGj4T0oFIyGs?=
 =?us-ascii?Q?AixPD3I5ygB3K/kjOjn3HxRtOyoNp1pXGjUJ5DTz4E565MrnGyLgOcmzWeHk?=
 =?us-ascii?Q?RbMbA9ypdPnxEK4wNnbcqZ8nSiH2CA4C0tHFW1uybE5T/ZLMLoMEA8p8k574?=
 =?us-ascii?Q?Gyn/IQAjx7A3fC5WA6osk1uuoBw91Eve8JaPllE2VK8c89/0VuDNeYgdgdYo?=
 =?us-ascii?Q?jX5f4PSBRRLB7BULghEWemE+I1udD7BAt65g9tG1Uoc/IQwK/66lVeKVDyAd?=
 =?us-ascii?Q?BaWzrwxt59U9z1RQBAsBcdiOmG9rm1VbD0WZDyYcHNd0VdJFZAyJAm8xYjYW?=
 =?us-ascii?Q?9UoKr5Bw0oQv29X5bgRcvezKexLGP6/j0k49qthr5gTMiXCAg2Z9AjlJCAs+?=
 =?us-ascii?Q?f+r+MZV72JwY50kdQb3wGDaIAalU5bhShVteXtoNpM0lqLsbuHEE5qwA9nKD?=
 =?us-ascii?Q?zpQ4L65MoOdyl36ngVKOwcCSlt4B+5fuegSJeXWlTh5F72JJprn8RwA+hcW3?=
 =?us-ascii?Q?vJk+v5GSGNkvGqVzoNhXHSRWC1qHITJtG7P91gfrN/TOsCwuoZW6PMaDS8Ds?=
 =?us-ascii?Q?y0vpQxA7mK0tttJWvsRPRI2L5hFgZFs5/JtkfIYYerd6f26XBxcqkEdxok0S?=
 =?us-ascii?Q?OLFC0/IQoNv9HZm58xiP2uvI3g6blnc637dzC5EYSSixv4dP97HIljWd4MRV?=
 =?us-ascii?Q?dwKK9fNt5yXqK15a2aMyXm2ZAWBB19QRGskGSStSlwSQJIbGr3+BLW8xatv+?=
 =?us-ascii?Q?JPIAmo/GmictQD65EJ0GVj2bBdQGb2PtN3x1gs1cFhQWvKAa7O/FZHepIEmU?=
 =?us-ascii?Q?g699JpisrBOnRt/DxMXa3htWaknuQKIxaWUR+aMfdT4shIJU7JazIT+Y7ms5?=
 =?us-ascii?Q?MMb8iWJEp2CJjML27tvk1lhiwTLavCdpED7BiNtBzEfmxmiuV52s4ysg1EHK?=
 =?us-ascii?Q?U7QahehCZa+mecvnG7rtiG0B5yPJ+wo4isLxzcUAWff4og9Zdh1dPfMhJFYC?=
 =?us-ascii?Q?dvNt1EL7xNmLDomKOnudYoFryKswwOTJ5ire9S2tigtGvhtVWeZUBOVGuDXT?=
 =?us-ascii?Q?Y7UEcGxQFkgXv0AcYLkrcyPvnqDxY5dOazc7ZNcXf/Wy/D9kfJw0D9xWMhhL?=
 =?us-ascii?Q?sLeAGzUCvCMT4pupf3tDu//K5jFosw8uUkYJfvqjq9qt9PcfmNUF6wdYcfQA?=
 =?us-ascii?Q?9f5ZikedoI07vl5MLP7Eq5DRZ+rhG/U5HwJxpx0BQrtnpCkmOldOAgE4A1vD?=
 =?us-ascii?Q?kFCtUZvXILkt9ReYhOVYtgIV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ba1f13-1cae-48fe-ed7b-08d8ed0a322e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 08:12:12.2925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRchRvBuusjTD04QOJMQo5dH0JGqunj6cocV1oV61kIAKO47/vCObd0WJqjH75TsEDw1B38EP6gQyhUrrMiTqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2939
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In amdggpu reset, while dm.dc_lock is held by dm_suspend,
handle_hpd_rx_irq tries to acquire it. Deadlock occurred!

Deadlock log:

[  104.528304] amdgpu 0000:03:00.0: amdgpu: GPU reset begin!

[  104.640084] ======================================================
[  104.640092] WARNING: possible circular locking dependency detected
[  104.640099] 5.11.0-custom #1 Tainted: G        W   E
[  104.640107] ------------------------------------------------------
[  104.640114] cat/1158 is trying to acquire lock:
[  104.640120] ffff88810a09ce00 ((work_completion)(&lh->work)){+.+.}-{0:0}, at: __flush_work+0x2e3/0x450
[  104.640144]
               but task is already holding lock:
[  104.640151] ffff88810a09cc70 (&adev->dm.dc_lock){+.+.}-{3:3}, at: dm_suspend+0xb2/0x1d0 [amdgpu]
[  104.640581]
               which lock already depends on the new lock.

[  104.640590]
               the existing dependency chain (in reverse order) is:
[  104.640598]
               -> #2 (&adev->dm.dc_lock){+.+.}-{3:3}:
[  104.640611]        lock_acquire+0xca/0x390
[  104.640623]        __mutex_lock+0x9b/0x930
[  104.640633]        mutex_lock_nested+0x1b/0x20
[  104.640640]        handle_hpd_rx_irq+0x9b/0x1c0 [amdgpu]
[  104.640959]        dm_irq_work_func+0x4e/0x60 [amdgpu]
[  104.641264]        process_one_work+0x2a7/0x5b0
[  104.641275]        worker_thread+0x4a/0x3d0
[  104.641283]        kthread+0x125/0x160
[  104.641290]        ret_from_fork+0x22/0x30
[  104.641300]
               -> #1 (&aconnector->hpd_lock){+.+.}-{3:3}:
[  104.641312]        lock_acquire+0xca/0x390
[  104.641321]        __mutex_lock+0x9b/0x930
[  104.641328]        mutex_lock_nested+0x1b/0x20
[  104.641336]        handle_hpd_rx_irq+0x67/0x1c0 [amdgpu]
[  104.641635]        dm_irq_work_func+0x4e/0x60 [amdgpu]
[  104.641931]        process_one_work+0x2a7/0x5b0
[  104.641940]        worker_thread+0x4a/0x3d0
[  104.641948]        kthread+0x125/0x160
[  104.641954]        ret_from_fork+0x22/0x30
[  104.641963]
               -> #0 ((work_completion)(&lh->work)){+.+.}-{0:0}:
[  104.641975]        check_prev_add+0x94/0xbf0
[  104.641983]        __lock_acquire+0x130d/0x1ce0
[  104.641992]        lock_acquire+0xca/0x390
[  104.642000]        __flush_work+0x303/0x450
[  104.642008]        flush_work+0x10/0x20
[  104.642016]        amdgpu_dm_irq_suspend+0x93/0x100 [amdgpu]
[  104.642312]        dm_suspend+0x181/0x1d0 [amdgpu]
[  104.642605]        amdgpu_device_ip_suspend_phase1+0x8a/0x100 [amdgpu]
[  104.642835]        amdgpu_device_ip_suspend+0x21/0x70 [amdgpu]
[  104.643066]        amdgpu_device_pre_asic_reset+0x1bd/0x1d2 [amdgpu]
[  104.643403]        amdgpu_device_gpu_recover.cold+0x5df/0xa9d [amdgpu]
[  104.643715]        gpu_recover_get+0x2e/0x60 [amdgpu]
[  104.643951]        simple_attr_read+0x6d/0x110
[  104.643960]        debugfs_attr_read+0x49/0x70
[  104.643970]        full_proxy_read+0x5f/0x90
[  104.643979]        vfs_read+0xa3/0x190
[  104.643986]        ksys_read+0x70/0xf0
[  104.643992]        __x64_sys_read+0x1a/0x20
[  104.643999]        do_syscall_64+0x38/0x90
[  104.644007]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  104.644017]
               other info that might help us debug this:

[  104.644026] Chain exists of:
                 (work_completion)(&lh->work) --> &aconnector->hpd_lock --> &adev->dm.dc_lock

[  104.644043]  Possible unsafe locking scenario:

[  104.644049]        CPU0                    CPU1
[  104.644055]        ----                    ----
[  104.644060]   lock(&adev->dm.dc_lock);
[  104.644066]                                lock(&aconnector->hpd_lock);
[  104.644075]                                lock(&adev->dm.dc_lock);
[  104.644083]   lock((work_completion)(&lh->work));
[  104.644090]
                *** DEADLOCK ***

[  104.644096] 3 locks held by cat/1158:
[  104.644103]  #0: ffff88810d0e4eb8 (&attr->mutex){+.+.}-{3:3}, at: simple_attr_read+0x4e/0x110
[  104.644119]  #1: ffff88810a0a1600 (&adev->reset_sem){++++}-{3:3}, at: amdgpu_device_lock_adev+0x42/0x94 [amdgpu]
[  104.644489]  #2: ffff88810a09cc70 (&adev->dm.dc_lock){+.+.}-{3:3}, at: dm_suspend+0xb2/0x1d0 [amdgpu]

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e176ea84d75b..8727488df769 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2657,13 +2657,15 @@ static void handle_hpd_rx_irq(void *param)
 		}
 	}
 
-	mutex_lock(&adev->dm.dc_lock);
+	if (!amdgpu_in_reset(adev))
+		mutex_lock(&adev->dm.dc_lock);
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 	result = dc_link_handle_hpd_rx_irq(dc_link, &hpd_irq_data, NULL);
 #else
 	result = dc_link_handle_hpd_rx_irq(dc_link, NULL, NULL);
 #endif
-	mutex_unlock(&adev->dm.dc_lock);
+	if (!amdgpu_in_reset(adev))
+		mutex_unlock(&adev->dm.dc_lock);
 
 out:
 	if (result && !is_mst_root_connector) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
