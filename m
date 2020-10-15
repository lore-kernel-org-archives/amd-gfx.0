Return-Path: <SRS0=r20P=DW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74A6C433E7
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 08:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1055C22249
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 08:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="01ziDxcz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1055C22249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 751BD899F2;
	Thu, 15 Oct 2020 08:29:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28D54899F2
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2020 08:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQ0DkCZT+2sjskpRVzKcQBXYgYWagjFm1JfewQYl1QRcRuxpCqfvbt/mo6318KQb2vqqM7EjTCXbH/BVAU12u9t5NWdnDF3yJAVfc3YGywZ4A6YdjaZm4ItIWPRxGzEb162qIZPBKXobT3bkWD5r0RfmSk8FYLSwTP3tNhoAAKDIMZVMWKtGgFLKOaXpgXFXjUi7TtuIHzivvktBWaxvFZxcGoOQwiKPFxIPLvGm8VpZfZWhGmdwZytEItNf05vMjvEx99MaeTvM7Us7J/PY9M8Kc3mxtXS59w44ZiZlwOBiWhZKBY58DsnSH1Isi41pvwDjbl+I5iYc3AkLebsSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pF8Q1gF7lE6DqCshApCoPsmT/P5LOpYVCOYDUdas4Ig=;
 b=g3vfC4V+AYawEjzCmwm7Fhkyv5fc4bKiiwt5Rt4PK4xpywUpscAqsj9b87HpKJkX65t8GDS3uUP7wlpdQKL0Q+uKi4UBYiZ93C8fkmvw2BDleZ5STNqxywjgMWcjGQymqpqfoXXCzr7U3vjrpH4q1Oui3pnA7ALhia5PkAljvnCcxgFkdihNE3BSBURLqjuHBJ3Xhx3EH0JqYs/J8crx+Lb1vhmxntgc0f0IgllcX7xMmzRu08ZHCBRtLZk9PPtbxQXuWNnj4tnKLvTorh2wDI+EpnG7S0w+d1JIifAHgtojNW/Nfx9ierO69DxHQ5drxwoi7nNd6BvCpod0PqFEiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pF8Q1gF7lE6DqCshApCoPsmT/P5LOpYVCOYDUdas4Ig=;
 b=01ziDxczDhZtRtteg09hTSplq+UAHOK0Gm+Dt66dGnGAzcsS6Q7d1dpbuGZrcBa61FhGL7xH9zHEs8f1ale+akW3q3SdDo0foFDaMoxLfgEtp+VMJjUhLOIbmEg2ZZNsVJqKL5l1hZwfz6IWwrK5OBcyb3YkTLeG6Ize3+moFqQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW2PR12MB2457.namprd12.prod.outlook.com (2603:10b6:907:10::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Thu, 15 Oct
 2020 08:29:33 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624%11]) with mapi id 15.20.3477.021; Thu, 15 Oct
 2020 08:29:33 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/display: fix the NULL pointer reference on
 dmucb on dcn301
Date: Thu, 15 Oct 2020 16:28:55 +0800
Message-Id: <20201015082856.215547-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR06CA0022.apcprd06.prod.outlook.com
 (2603:1096:202:2e::34) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.245) by
 HK2PR06CA0022.apcprd06.prod.outlook.com (2603:1096:202:2e::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21 via Frontend Transport; Thu, 15 Oct 2020 08:29:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7577b640-06e2-4dc6-d26c-08d870e47182
X-MS-TrafficTypeDiagnostic: MW2PR12MB2457:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2457E153B96493D00B21CBF5EC020@MW2PR12MB2457.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GYMT4Jat3Ix6OUxf6XQiQIgXezXO046PfHletFj1D0pmtx+AU6BzyXbIW/OQvWQBEJsh0cXrqaKOwC4sHHdwdPPFtfxHcY4funKdtOm4mPvkHK6qIGikGpY+N3AU4G+J3Rx7JYf0iYNSDxcj9knV25Hq3CDaWxyeF1YN7ltWYq3YzaBLM2b9trXts0pfvH3+fGZvMxymO6UE9UGksPEAajenbD/rIPvxUJ2X7GwO8MxOMpxbbiZ0wAaRF9/IU25w3mQFf89raE+dI17tvJ+EgiNzdOY7r6Sq5ml/ZmRdG8E8bigW4REInyFnWNYjeQLC9Rq+6gY0woMeqfB7njRCPp+qwA+vUiAKPXn4v+N7aXD/0okqtno29AsCyLmlyoYg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(86362001)(6666004)(8676002)(478600001)(83380400001)(4326008)(1076003)(956004)(6486002)(2906002)(2616005)(36756003)(52116002)(8936002)(6916009)(26005)(66476007)(316002)(54906003)(186003)(16526019)(66946007)(5660300002)(34490700002)(7696005)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: j/G3VbeBhmk1BrKHbS9pXnVB+eWnR0rjUWH6kYEGu28m9ChaYY5jKs2sbE1Og1ikFtNCrmt7uqz4E4mYiXUzX7dWo0K9yWIxkzzlKy+i1wCh0bpThEJmMW7fIOXE+b2zBbheCdMxHhIoZnvp/4nvQfe958ePy+j0/xGhTciV37qxUmuakoplHTDvviZeB6PtSXe2VnnlbgcGFLtD03ZqFt8ZUkdJv1hSgaHQHZiUTYyM8GnQ2lIkPhXrBFTkoOh3RRjy1Zkaq7b91b8I9tSjmJCnw1vCP/U1XXfm4Xno/eGkNTWa0mqCAX4OU7ZB1h7cEDpTH3f3KIaUQSqjVFbQVEDqKogvN2LTbuy6HfQFFNn3fWQLS9cN+6V/i+YQp+mv2aR1FCBDtyilEtKRFmMi2LENl6NR9bGRsjb2KTjfgWiUqCMW845xzKLK5RCJTJRGdqV2oh8RTMMQ0k9yLphZFQD7Oro0aIKydAVbXrN1pfF/T44SnBbwUCPu5YMRP5bTsZj0W6tn2wGpnTvVS113B6IMHqpifr2Y3sQo3jWlFQ+NPWdEtEKzk81l4o2LRzICJbLaaoWJsdLXdqXBmU5OV+o0B1zjE5KsDF8/+KY7eqfgSBmiiE3KgalafVBRLhqoMir4yBWX8E819qEjJdc8vg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7577b640-06e2-4dc6-d26c-08d870e47182
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 08:29:33.5567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzBGCxq6A6a7fWTRfade2mPBVKdQruJTZeaRvt5GhPi1by7lnjZV3FtGS9WRg6vtrjPrjJlKt+9+xr9kRTTtyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2457
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
 Harry Wentland <harry.wentland@amd.com>, Roman Li <Roman.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DCN301 needs to use dmub create abm instance instead of dce.

[ 1138.854204] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 1138.854206] #PF: supervisor instruction fetch in kernel mode
[ 1138.854207] #PF: error_code(0x0010) - not-present page
[ 1138.854208] PGD 0 P4D 0
[ 1138.854212] Oops: 0010 [#1] SMP NOPTI
[ 1138.854216] CPU: 6 PID: 1240 Comm: modprobe Tainted: G        W  OE     5.9.0-rc2-custom #1
[ 1138.854217] Hardware name: AMD Chachani-VN/Chachani-VN, BIOS BAerithA104 10/01/2020
[ 1138.854221] RIP: 0010:0x0
[ 1138.854224] Code: Bad RIP value.
[ 1138.854226] RSP: 0018:ffffc90001c4f638 EFLAGS: 00010286
[ 1138.854228] RAX: 0000000000000000 RBX: ffff88804f2b2800 RCX: ffffc90001c4f740
[ 1138.854229] RDX: 00000000000000e8 RSI: ffffc90001c4f640 RDI: ffff88805816f300
[ 1138.854230] RBP: ffffc90001c4f850 R08: ffffc90001c4f644 R09: ffffc90001c4f654
[ 1138.854231] R10: ffffc90001c4f72c R11: ffffc90001c4f740 R12: ffffc90001c4f640
[ 1138.854232] R13: ffffc90001c4f728 R14: 0000000000000000 R15: ffff888007296381
[ 1138.854235] FS:  00007f5f44d84540(0000) GS:ffff88805e380000(0000) knlGS:0000000000000000
[ 1138.854236] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1138.854237] CR2: ffffffffffffffd6 CR3: 00000000194f4000 CR4: 0000000000050ee0
[ 1138.854239] Call Trace:
[ 1138.854447]  dmub_init_abm_config+0x220/0x267 [amdgpu]
[ 1138.854654]  dm_late_init+0x197/0x1ad [amdgpu]
[ 1138.854846]  ? dm_late_init+0x197/0x1ad [amdgpu]
[ 1138.854999]  amdgpu_device_ip_late_init+0x6f/0x21b [amdgpu]
[ 1138.855148]  amdgpu_device_init+0x1b7f/0x1cfb [amdgpu]
[ 1138.855293]  amdgpu_driver_load_kms+0x2c/0x26e [amdgpu]
[ 1138.855437]  amdgpu_pci_probe+0x1c7/0x249 [amdgpu]
[ 1138.920489]  local_pci_probe+0x48/0x80
[ 1138.920492]  pci_device_probe+0x10f/0x1c0

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index cd69e2d2e463..fe46a0b911fc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1907,7 +1907,7 @@ static bool dcn301_resource_construct(
 	/* ABM (or ABMs for NV2x) */
 	/* TODO: */
 	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
-		pool->base.multiple_abms[i] = dce_abm_create(ctx,
+		pool->base.multiple_abms[i] = dmub_abm_create(ctx,
 				&abm_regs[i],
 				&abm_shift,
 				&abm_mask);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
