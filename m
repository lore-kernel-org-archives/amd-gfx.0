Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E2BC43331
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 07:43:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C543206E6
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 07:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TvMwh5mi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C543206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2251B6E9BC;
	Fri, 27 Mar 2020 07:43:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A91CD6E9BC
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 07:43:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gR5w4jEglhDbZKXuq3T1tf9tKqyfepPkKVTbFDZEEr42mCju95X+cnHl3OsxxY9XPTSTp9IWveHVZMJGB59E/jM/h+tWKPze5EaAYyXS25mCTFn2CJ79qW9UEm6oTZsZSLOjPh7ztFBcMqi5mUj+18mc90l81sFSPWp5f+NgQ1l50cJn20Am7Z2xCS6vV3fpjU6tf+KXcYapHlgSBuo0sGE6NgoTDp+u+VwOeJcIrKvQ4Bj0mazSCs83cNiRB2hyg22AYyTlLIhYsZocoYDK7Tru/pUnjTZmRTiVlFtoUrnRjID46t9aLVgqf9/K2eA/S5McEH/4g6SE8/VkRRGO5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRcuimxIyNfF10hdLgNoXXkYoYNiz2VvxfBDNxIbrk4=;
 b=ZJ+zKLJiqsWAFQz5CfI3onRd3HGqLkAKzCkDR21yaFwVljxvAuiB4u+7Oq8E4+5OIp7Q7At3J2mtuioS9vzGPZQpwU3gXyLZbpe/NhjN0WYNYqD6aiRcUMtmTMC/D9rcdC8QIpq2ZXLoC+CXWFnrcIOd1mHpuye3Ugz59+sacg/X6zIfNCmEGloUPA+/v/AKZS6A3tQKAWkQ7TyBAhweKX4VRJQ0SmJL40Q1MtqCaHPsmO6sQfkRk896zBfixPsVqMzSmM19v7pLt0ZbQAp4+6Gmr9eMk0HMSa471hOkecTj9jYeAAeNVdwiAypE81XpDh0kawG+lusCl+zKuSjmIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRcuimxIyNfF10hdLgNoXXkYoYNiz2VvxfBDNxIbrk4=;
 b=TvMwh5miAeoWhTn1nVpXo8wo0NkeFZeJwUmEEiwZ+I4vKURX/9RDp1s1CvC/IyKVMKPaMVXXNhdXn2qiYCzRf/4qaTtGDySJRscEn0nxNL9tBdPAeqiCTgZzc4LPKpkX/KvB0qB4gKbJlKpapN1N+aQFOAFKFzSRLthJC8srfuA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Fri, 27 Mar
 2020 07:43:14 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2835.021; Fri, 27 Mar 2020
 07:43:14 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix non-pointer dereference for non-RAS supported
Date: Fri, 27 Mar 2020 15:42:56 +0800
Message-Id: <20200327074256.16761-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.0
X-ClientProxiedBy: HKAPR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:203:d0::24) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HKAPR04CA0014.apcprd04.prod.outlook.com (2603:1096:203:d0::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18 via Frontend Transport; Fri, 27 Mar 2020 07:43:12 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a9b7bd0-6838-42dc-28d5-08d7d2228145
X-MS-TrafficTypeDiagnostic: MN2PR12MB4301:|MN2PR12MB4301:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4301204D24B1B80967FCDCA7E4CC0@MN2PR12MB4301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:389;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(8936002)(5660300002)(26005)(186003)(16526019)(8676002)(44832011)(956004)(66476007)(81166006)(4326008)(86362001)(2906002)(66556008)(81156014)(6486002)(66946007)(2616005)(478600001)(36756003)(316002)(7696005)(6666004)(6916009)(1076003)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4301;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yUTYzJ7P7a3APjphW21pIiyynDgRLKvV00jjGIfhwbjCBHdVPpFVOsIRoXlGd3KZyBYsrHwJhfnOfzbzfBrL4PXkq6ZBgquXeXC+02CrxrNJR0o2PlC/6gTU4xeiEHnPHW5hMqZFRPI0yWUAKHxkpilkgI82J90Ml/PS78Iaiy318PqVz1jGn+28ZGIOUwCxkbtwvmqk97v4akYS8Nh3VAmwDANd+lOAYLI3hu9RvyM1FU6SxlcGbbQ19OymOkVpcCjobccbH4j2B5d1KGw0hREuISUMUJB1dc2QKtQORPwUSGL2MC61Quv6zJYidQvga+2Wl9Uw3AC8sMYjpRGv2VhxPb01ZJIFD1YvIoq1lpUzC4BKRRRN6wG9txGhNfBjv+wQkTLdRLqKDOQujVwrJXvH4yR/Dj06yVP2mQ7iy/a4OtMj//kdPL8wV8wcqTnw
X-MS-Exchange-AntiSpam-MessageData: v8cVvCl7scgjLWifd3wuiJiHkCi4n0wcOQ1V2/w2JtAK+5xQ7KUx2WLg4zML/GsDVvpO0lFqYVl6g++XTFXhNwm8JBV5a4CU2d3c326BQXKHypmanstGx4pw4mJZ5qeyNgGxzo+stPSHeAItNDtU/A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9b7bd0-6838-42dc-28d5-08d7d2228145
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 07:43:14.0825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGvwHkjWD7XNYJvvzg7Mln/nIbqgCBUlMzx6QaP3j8j+rb1wMa9q8BTD3mnHTB+1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301
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
Cc: Evan Quan <evan.quan@amd.com>, john.clements@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Backtrace on gpu recover test on Navi10.

[ 1324.516681] RIP: 0010:amdgpu_ras_set_error_query_ready+0x15/0x20 [amdgpu]
[ 1324.523778] Code: 4c 89 f7 e8 cd a2 a0 d8 e9 99 fe ff ff 45 31 ff e9 91 fe ff ff 0f 1f 44 00 00 55 48 85 ff 48 89 e5 74 0e 48 8b 87 d8 2b 01 00 <40> 88 b0 38 01 00 00 5d c3 66 90 0f 1f 44 00 00 55 31 c0 48 85 ff
[ 1324.543452] RSP: 0018:ffffaa1040e4bd28 EFLAGS: 00010286
[ 1324.549025] RAX: 0000000000000000 RBX: ffff911198b20000 RCX: 0000000000000000
[ 1324.556217] RDX: 00000000000c0a01 RSI: 0000000000000000 RDI: ffff911198b20000
[ 1324.563514] RBP: ffffaa1040e4bd28 R08: 0000000000001000 R09: ffff91119d0028c0
[ 1324.570804] R10: ffffffff9a606b40 R11: 0000000000000000 R12: 0000000000000000
[ 1324.578413] R13: ffffaa1040e4bd70 R14: ffff911198b20000 R15: 0000000000000000
[ 1324.586464] FS:  00007f4441cbf540(0000) GS:ffff91119ed80000(0000) knlGS:0000000000000000
[ 1324.595434] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1324.601345] CR2: 0000000000000138 CR3: 00000003fcdf8004 CR4: 00000000003606e0
[ 1324.608694] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1324.616303] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1324.623678] Call Trace:
[ 1324.626270]  amdgpu_device_gpu_recover+0x6e7/0xc50 [amdgpu]
[ 1324.632018]  ? seq_printf+0x4e/0x70
[ 1324.636652]  amdgpu_debugfs_gpu_recover+0x50/0x80 [amdgpu]
[ 1324.643371]  seq_read+0xda/0x420
[ 1324.647601]  full_proxy_read+0x5c/0x90
[ 1324.652426]  __vfs_read+0x1b/0x40
[ 1324.656734]  vfs_read+0x8e/0x130
[ 1324.660981]  ksys_read+0xa7/0xe0
[ 1324.665201]  __x64_sys_read+0x1a/0x20
[ 1324.669907]  do_syscall_64+0x57/0x1c0
[ 1324.674517]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1324.680654] RIP: 0033:0x7f44417cf081

Change-Id: I053089a8e44749db23ec882d14f876ded9c1332d
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 9e9e0f7747b7..8a78db648442 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -82,13 +82,13 @@ static bool amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
 
 void amdgpu_ras_set_error_query_ready(struct amdgpu_device *adev, bool ready)
 {
-	if (adev)
+	if (adev && amdgpu_ras_get_context(adev))
 		amdgpu_ras_get_context(adev)->error_query_ready = ready;
 }
 
 bool amdgpu_ras_get_error_query_ready(struct amdgpu_device *adev)
 {
-	if (adev)
+	if (adev && amdgpu_ras_get_context(adev))
 		return amdgpu_ras_get_context(adev)->error_query_ready;
 
 	return false;
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
