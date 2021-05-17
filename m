Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0029C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 10:53:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 928A8611C2
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 10:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928A8611C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFE366E927;
	Mon, 17 May 2021 10:52:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED2406E927
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 10:52:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlBpdhXVQDYybVwXoxlk2TXyKyBnZJg7g7otYPaRISNb2PDb42n9ofkt9uTeEU39zKaqaAudT+sGXM0uxslmNOa0gG8f6a9sjE9/1xjftslkz2Tii1ryUI4WVxI7EtUOUEkpRAMaAHuDgeEa4NwixX/ZlcS6eirVGpvZI9lWQAQQcrnsn1/XVm+eaOkgGZsoQfuJN7u7KY1MK9h9mwJyj4ytQNw77z6keQHFOx9NwLixcv6iKUTWx2H7CQJaIkOPem8Xhk9NiM6MCPD1u58Xogdfccp6GDgFvvoejIMbtIMTFjAUMBmee+HXqRAPxzAwonZM7z6VM/xR5/qwmRweBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8+dZPlJixmy9pEtFJTW0VRssgQudG415MgpEZaJb1Y=;
 b=MGhC6lx3IXZNta+hDM/9VRkUf+3u3iw9gNl8owyDhSRR89n43MG09HsHRjEIEfoL1HSUdokmpSmFQeELlWYM9d+KSBwiXVnS6MZ14EYlP8o2QteaCJM1+QZ8FrfRSbSScaYezR7xbuV3sg3iv9CWhR1kA/hz6ouW/+w9TUYT+XUCi1zvem0zOW/FLvJSBvq3jg3pqtPAEzxlCTlT/l7Z33uL7jgPwgVnM1Ut4f5zvM13XETi2uAGKi/QLPbdHFthMZjpQ+wUzfoqPkZgYs0D6urvig8Yz5+b/V2Rr/KVTvzYIZIZ+WVK/cI361QNlvnB4qN7w4/RlURXfhhAinxPuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8+dZPlJixmy9pEtFJTW0VRssgQudG415MgpEZaJb1Y=;
 b=amYSU1uAI/YSTbr6homldlHPynXgzzVy6O7fhNV2qlDPP0+yZivp9ssXai1QklEdNybl2OrAPBctVbuImQCfWC75OIBT4XnX6zRizgnqXshIE1Pag0c+ySLs4Q/1PNHIPM5U2EpLNJ/NJxUnBoMu8NFJYWC+blMavJbAdDa+J9Y=
Received: from CO2PR04CA0137.namprd04.prod.outlook.com (2603:10b6:104::15) by
 BN6PR12MB1586.namprd12.prod.outlook.com (2603:10b6:405:f::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.26; Mon, 17 May 2021 10:52:55 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::de) by CO2PR04CA0137.outlook.office365.com
 (2603:10b6:104::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Mon, 17 May 2021 10:52:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Mon, 17 May 2021 10:52:53 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 17 May
 2021 05:52:51 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Grodzovsky Andrey
 <andrey.grodzovsky@amd.com>
Subject: [PATCH] drm/amd/amdgpu: fix a potential deadlock in gpu reset
Date: Mon, 17 May 2021 18:52:32 +0800
Message-ID: <20210517105232.7776-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a332687c-acfa-4c85-8af7-08d91921ec41
X-MS-TrafficTypeDiagnostic: BN6PR12MB1586:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1586EDA5870D1BF801FC3400FB2D9@BN6PR12MB1586.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3FSPWIhi2G29DSwmBMZxpef5zppQ4Mr/8AhXXHXivCGtjyX3MqaErdJyCzSeEfEp5ymi4DBlUB3xrtmlc5/lZYnHPkI2H8MwqqbADoHAq+0h+lmFixPkP/CyqjYhMkQwxBNoXBV3VJj2718hIPltJlllflKKTU4j/PAKRsHmHTGu5nE4Ea9jdn9zpX/8LmcI92e2kJurBwLxyJj7y5I0FaJ+LSWBe9yGvJ9sjlUI/zJL7xYJMCnIKvsTAdY3Myv5NottCJK6xcxDLhhM204egmsSVWOBbJNrYYV/nU85+4LXaWV+BMCMJAXBFkPw3PnNkH+zCD4EHA/Q+3LTrgztmEYn4Rmd0e0IBO4KMvZg1eneyexiDcQVnhWyOEyfpSCP8OLpKP4nfehJi//7PkhduiCWQfiIHBioPLP8QktGpKrjbuoy1gQBrBPWe99QixMb4cJkN1NaTjhUSH4T5ZNMSW0QMpYJf0FONaiwsX274vC53XJ9yTCcuq5cGNnmyjA7SBg1Ph3gqZcY0Jlny0EjGUwwDbgu6jEgyJtnGBdC/4XvuzJK0TNIn+C41GpgeF1k6BsasO6k4Vc1R/476doV/8M3z2JWUivwY8L8ROBRv/MPVxPseTT6l07bRzEDQ4zC8/8EWRYd4hfinyTxMyrEjwd7wU+0RYiiw1+invEk7fAFBrA5tCCs8yY2+odnZJaE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966006)(36840700001)(82740400003)(54906003)(7696005)(110136005)(356005)(81166007)(316002)(2616005)(336012)(36756003)(16526019)(186003)(8676002)(5660300002)(8936002)(478600001)(36860700001)(2906002)(26005)(1076003)(83380400001)(47076005)(426003)(6636002)(70586007)(6666004)(70206006)(82310400003)(4326008)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 10:52:53.6450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a332687c-acfa-4c85-8af7-08d91921ec41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1586
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

When amdgpu_ib_ring_tests failed, the reset logic called
amdgpu_device_ip_suspend twice, then deadlock occurred.

Deadlock log:
[  805.655192] amdgpu 0000:04:00.0: amdgpu: ib ring test failed (-110).
[  806.011571] [drm] Register(0) [mmUVD_POWER_STATUS] failed to reach value 0x00000001 != 0x00000002
[  806.280139] [drm] Register(0) [mmUVD_POWER_STATUS] failed to reach value 0x00000001 != 0x00000002
[  806.290952] [drm] free PSP TMR buffer

[  806.319406] ============================================
[  806.320315] WARNING: possible recursive locking detected
[  806.321225] 5.11.0-custom #1 Tainted: G        W  OEL
[  806.322135] --------------------------------------------
[  806.323043] cat/2593 is trying to acquire lock:
[  806.323825] ffff888136b1cdc8 (&adev->dm.dc_lock){+.+.}-{3:3}, at: dm_suspend+0xb8/0x1d0 [amdgpu]
[  806.325668]
               but task is already holding lock:
[  806.326664] ffff888136b1cdc8 (&adev->dm.dc_lock){+.+.}-{3:3}, at: dm_suspend+0xb8/0x1d0 [amdgpu]
[  806.328430]
               other info that might help us debug this:
[  806.329539]  Possible unsafe locking scenario:

[  806.330549]        CPU0
[  806.330983]        ----
[  806.331416]   lock(&adev->dm.dc_lock);
[  806.332086]   lock(&adev->dm.dc_lock);
[  806.332738]
                *** DEADLOCK ***

[  806.333747]  May be due to missing lock nesting notation

[  806.334899] 3 locks held by cat/2593:
[  806.335537]  #0: ffff888100d3f1b8 (&attr->mutex){+.+.}-{3:3}, at: simple_attr_read+0x4e/0x110
[  806.337009]  #1: ffff888136b1fd78 (&adev->reset_sem){++++}-{3:3}, at: amdgpu_device_lock_adev+0x42/0x94 [amdgpu]
[  806.339018]  #2: ffff888136b1cdc8 (&adev->dm.dc_lock){+.+.}-{3:3}, at: dm_suspend+0xb8/0x1d0 [amdgpu]
[  806.340869]
               stack backtrace:
[  806.341621] CPU: 6 PID: 2593 Comm: cat Tainted: G        W  OEL    5.11.0-custom #1
[  806.342921] Hardware name: AMD Celadon-CZN/Celadon-CZN, BIOS WLD0C23N_Weekly_20_12_2 12/23/2020
[  806.344413] Call Trace:
[  806.344849]  dump_stack+0x93/0xbd
[  806.345435]  __lock_acquire.cold+0x18a/0x2cf
[  806.346179]  lock_acquire+0xca/0x390
[  806.346807]  ? dm_suspend+0xb8/0x1d0 [amdgpu]
[  806.347813]  __mutex_lock+0x9b/0x930
[  806.348454]  ? dm_suspend+0xb8/0x1d0 [amdgpu]
[  806.349434]  ? amdgpu_device_indirect_rreg+0x58/0x70 [amdgpu]
[  806.350581]  ? _raw_spin_unlock_irqrestore+0x47/0x50
[  806.351437]  ? dm_suspend+0xb8/0x1d0 [amdgpu]
[  806.352437]  ? rcu_read_lock_sched_held+0x4f/0x80
[  806.353252]  ? rcu_read_lock_sched_held+0x4f/0x80
[  806.354064]  mutex_lock_nested+0x1b/0x20
[  806.354747]  ? mutex_lock_nested+0x1b/0x20
[  806.355457]  dm_suspend+0xb8/0x1d0 [amdgpu]
[  806.356427]  ? soc15_common_set_clockgating_state+0x17d/0x19 [amdgpu]
[  806.357736]  amdgpu_device_ip_suspend_phase1+0x78/0xd0 [amdgpu]
[  806.360394]  amdgpu_device_ip_suspend+0x21/0x70 [amdgpu]
[  806.362926]  amdgpu_device_pre_asic_reset+0xb3/0x270 [amdgpu]
[  806.365560]  amdgpu_device_gpu_recover.cold+0x679/0x8eb [amdgpu]
[  806.368331]  ? __pm_runtime_resume+0x60/0x80
[  806.370509]  gpu_recover_get+0x2e/0x60 [amdgpu]
[  806.372887]  simple_attr_read+0x6d/0x110
[  806.374966]  debugfs_attr_read+0x49/0x70
[  806.377046]  full_proxy_read+0x5f/0x90
[  806.379054]  vfs_read+0xa3/0x190
[  806.380969]  ksys_read+0x70/0xf0
[  806.382833]  __x64_sys_read+0x1a/0x20
[  806.384803]  do_syscall_64+0x38/0x90
[  806.386743]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  806.388946] RIP: 0033:0x7fb084ea1142
[  806.390914] Code: c0 e9 c2 fe ff ff 50 48 8d 3d 3a ca 0a 00 e8 f5 19 02 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
[  806.395496] RSP: 002b:00007fffde50ee08 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[  806.398298] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007fb084ea1142
[  806.401063] RDX: 0000000000020000 RSI: 00007fb0844ff000 RDI: 0000000000000003
[  806.403793] RBP: 00007fb0844ff000 R08: 00007fb0844fe010 R09: 0000000000000000
[  806.406516] R10: 0000000000000022 R11: 0000000000000246 R12: 0000555d3d3b51f0
[  806.409246] R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000020000

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7c6c435e5d02..ff341154394e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4476,7 +4476,6 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 			r = amdgpu_ib_ring_tests(tmp_adev);
 			if (r) {
 				dev_err(tmp_adev->dev, "ib ring test failed (%d).\n", r);
-				r = amdgpu_device_ip_suspend(tmp_adev);
 				need_full_reset = true;
 				r = -EAGAIN;
 				goto end;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
