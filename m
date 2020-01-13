Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A4AC33CA9
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 02:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990EE21744
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 02:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="H4pNsqzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990EE21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47C3189BA3;
	Mon, 13 Jan 2020 02:34:54 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690064.outbound.protection.outlook.com [40.107.69.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75E2D89BA3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 02:34:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Du6DIlFqJBblvqIoP6BrNQH4yi57V84tuXld3mJTTInMIfVh4sQ7DgWIcuUPdCXK5epC/AlwgO70sHbKJGXdcRcc8eebHSPWf9gIpVRgPibctjK6nfWD/+oljBwtcECbttbAhjwp3jaERLhjWdkWbm+P0azLcSy5Wj8z/+brioW1shRyMAdyu5CKIwriE7hkAI/pxbzClQDITc2lxFp5ikRPCZ7g5tQ1233QZ1CKUsO0EpaY3wvokWfPfXvTvcpTiDnXb0vA+oi7c1QxALBSc4SqVEEH33HBSlDnhmn2QjgoJ7rRAkToW4A3h5GfIt61dnAmQ2hEu+aPgjI1tgacQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/3ATmw0w1KLB5QoSIDySsLytCfXsOq1XYSa5fSrH/Q=;
 b=N24ybhkN94Oot7C8TebCjvNq93VPaqMN1tqLmdHZfV3PJtbglDHNLwYf0DUzLMmHDxuMJi5fxy57/vMwh+CalDDRBhEak8++1Yxvm+Lvm3FPK15sJrZUj7fPw04Nn1X/JJf6GqoeGhh00msoz7xwaekDB5ORVX88GJyDtCitealDS4L1MI4KG4gAhgFevoAx9njk7wqI8NcZsxAbVW375NjwiRVw7cG3z4U8G7IqeEB+45Axnu81zbfMW2d6K8GW7EJCSs+i4uMLRKg9hxnPM3hcoJlTe7NQnATYHT+5Nb0+GKILJAEQuW5cYdBfZCv/vXbb9B2UKsYfB4Xqv3tjdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/3ATmw0w1KLB5QoSIDySsLytCfXsOq1XYSa5fSrH/Q=;
 b=H4pNsqzORaX70rGA24xR/ncsygMHrtDAbtb9tK/lqmvj9p8Qwzd29DsRQzwXgIH8v5cK2QAvm+z0khHrEPoSxb7T2ujDz3u3XxEXdd716TYrIOndR5jwHsjHpflZbAHaJzGEAZHHn5LYk32ehAlcwWogMp+CPw9RVV1Y1VXJjwA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB2941.namprd12.prod.outlook.com (20.179.80.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Mon, 13 Jan 2020 02:34:50 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 02:34:49 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: fix the null pointer issue on switching
 power profile
Date: Mon, 13 Jan 2020 10:34:30 +0800
Message-Id: <1578882870-22736-1-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK2PR0302CA0012.apcprd03.prod.outlook.com
 (2603:1096:202::22) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from hr-intel.amd.com (180.167.199.188) by
 HK2PR0302CA0012.apcprd03.prod.outlook.com (2603:1096:202::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2644.6 via Frontend Transport; Mon, 13 Jan 2020 02:34:47 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 81f1bd0b-d0f5-4748-d3a3-08d797d12972
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:|MN2PR12MB2941:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2941B53EBB99248CDC334E69EC350@MN2PR12MB2941.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 028166BF91
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(189003)(199004)(66476007)(16526019)(186003)(66556008)(66946007)(7696005)(52116002)(6916009)(4326008)(86362001)(478600001)(26005)(36756003)(5660300002)(6486002)(8676002)(6666004)(54906003)(956004)(2616005)(316002)(8936002)(2906002)(81156014)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2941;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l+5IdbbpydRFw1Pf/Og4UG0ajlFS8scebZqEyjvM7BwROwGeu6ETqHRAmB5LjtUAmxBXlSkK6FAXpf0Tp4ON5mjGstPYnJAA/Ph1P12AXI/+2B9KnbvLm+E6ucP1DEAPhYkpFSXTRrVxhVAZkPnFf6tDmudawFlzdjwr/xzbLrJomTptnPqyKrPk3jBBJKhXgcVN8yshEExSRWeay9z6dIrGi453lWBiSqNiGJRTS5zzPLEBnZ8m9w4Gx92JWX4FCLqPIAOSM+tTz8weJmuT1OfHAfsjzVEeMlE/5RbtNFyC6KqLjcQdD9HhlF9vB2N5IEr8wYjs9D1DUR+kovsajqqp0ToqCt0KRTwsS92RDqvVcW9i2I/7UMb1lN/qmQug1tgXgUva+ERdtFWpP8Cq8Ao2oTzWT34fCvSyLU0xF7TB0in+tjuUVHCTnnQ9K8cU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f1bd0b-d0f5-4748-d3a3-08d797d12972
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 02:34:49.7713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +0yoKEyoRwwHokho1pECW9lW6xXvUNV2Brqq85bIcWqFx/HceANP1VSwcPcBDr1smorxEFJz9f/6VG5CuQ+JUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2941
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the wrong input parameter of powerplay callback
amdgpu_dpm_switch_power_profile which is encountered by kfd test.

[  176.758381] BUG: kernel NULL pointer dereference, address: 0000000000000220
[  176.758409] #PF: supervisor read access in kernel mode
[  176.758424] #PF: error_code(0x0000) - not-present page
[  176.758440] PGD 80000003f6eea067 P4D 80000003f6eea067 PUD 3ce06c067 PMD 0
[  176.758461] Oops: 0000 [#1] SMP PTI
[  176.758473] CPU: 5 PID: 2621 Comm: kfdtest Tainted: G           OE
5.4.0-rc7-custom #1
[  176.758496] Hardware name: System manufacturer System Product Name/TUF
Z370-PLUS GAMING, BIOS 0612 03/01/2018
[  176.758593] RIP: 0010:pp_dpm_switch_power_profile+0x46/0x1ee [amdgpu]
[  176.758613] Code: 00 48 89 45 d8 31 c0 48 85 ff 0f 84 9f 01 00 00 48 89 fb 41
89 f4 41 89 d5 80 7f 15 00 0f 84 96 01 00 00 48 8b 87 78 02 00 00 <48> 83 b8 20
02 00 00 00 0f 84 ba 00 00 00 83 fe 05 0f 87 82 01 00
[  176.758663] RSP: 0018:ffffa530c12ebb50 EFLAGS: 00010282
[  176.758678] RAX: 0000000000000000 RBX: ffff9797c0b00000 RCX: 0000000000000000
[  176.758698] RDX: 0000000000000001 RSI: 0000000000000005 RDI: ffff9797c0b00000
[  176.758718] RBP: ffffa530c12ebb80 R08: ffff9797ce221548 R09: 000000000000036c
[  176.758739] R10: ffffffff94006a80 R11: 00000000ffffffff R12: 0000000000000005
[  176.758759] R13: 0000000000000001 R14: ffff9797fff4dda8 R15: ffff9797ce221548
[  176.758779] FS:  00007efe09cc3780(0000) GS:ffff979826940000(0000)
knlGS:0000000000000000
[  176.758802] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  176.758819] CR2: 0000000000000220 CR3: 00000003cdc70003 CR4: 00000000003606e0
[  176.758839] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  176.758859] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  176.758879] Call Trace:
[  176.758932]  amdgpu_dpm_switch_power_profile+0x4c/0x6f [amdgpu]
[  176.758995]  amdgpu_amdkfd_set_compute_idle+0x1a/0x1c [amdgpu]
[  176.759056]  kfd_inc_compute_active+0x29/0x2b [amdgpu]
[  176.759117]  register_process+0x11c/0x14f [amdgpu]
[  176.759177]  pqm_create_queue+0x20b/0x527 [amdgpu]
[  176.759234]  kfd_ioctl_create_queue+0x4aa/0x5e5 [amdgpu]
[  176.759294]  kfd_ioctl+0x235/0x366 [amdgpu]

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
index f7c0ae6..d3962e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
@@ -1123,7 +1123,8 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 		ret = smu_switch_power_profile(&adev->smu, type, en);
 	else if (adev->powerplay.pp_funcs &&
 		 adev->powerplay.pp_funcs->switch_power_profile)
-		ret = adev->powerplay.pp_funcs->switch_power_profile(adev, type, en);
+		ret = adev->powerplay.pp_funcs->switch_power_profile(adev->powerplay.pp_handle,
+								     type, en);
 
 	return ret;
 }
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
