Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FA8C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 16:10:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A941206EB
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 16:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jnhhj4TA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A941206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A34CC6EBFD;
	Fri, 13 Mar 2020 16:10:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D09226EBFD
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 16:10:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUZVvdrUMW5ZDzVLrh2IGAg28ustSjT0pC9vcz8yuX32iWkIvANcckqgHyKqWP0g+OML+rqEAKkq2tb3Y5J7uGS5R0040tEc0BkbvUvkn8In6wUxVvqiMgm+Jeusltm5PuTI9Oc4YHlA7+8jKfEQojejVboq7fRd9wlg5PE0Z2V7lhzY3ZelWGxEjWmrWnwtgJV8vUF2lFA2safpWmZNTuuMj5FXlkBbUiIKytK/k2Hcy+7wV/oAkJ9do5n53T4IAU8vNwJF7vkRc186NOLh/Ru8qQn7BMxjIzCU+BPo8+fJAZxZeL2JwY0oBtf+MAhBNaGhvG4XhQcRtQIiH5NyBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxDGhL5pwE5R5i8rt2N5PqkBxQge7LLDcSzjxBvAaV4=;
 b=MohwSMkVxJNMixz5hrik8HB0nMb1r9j/VOtN5jjChcDAFPpme1imcuF1QOfw/gxhWL5cZb7sO8kKcxXJnY3zGQtQFEAGlyz5bybmiQE4r6y4katIgBjUb0fhMUKwPXECKHgwJaa2ia15PBhSRRFqXnhPckQalGR45aaU+N5JZlI0ScmhRbMj7NHbl76lrO/WaJysjEh0INs5ltG9ABI3I9ffMHzFQcw6A+beA2neyYmiFOy0XO4utyzk7GBAWdNOmIJmrydBq6tfzdlS+9GISsqt9/HoyYBTBDLaF1NuQTuPNGimaS9zo/u1PpAEBF1FxpCXyb0sDYrhsa+YIYlBSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxDGhL5pwE5R5i8rt2N5PqkBxQge7LLDcSzjxBvAaV4=;
 b=jnhhj4TAUODaihU6KdFtQRDXA6ZXLRnZgEQmEL6nWJ8eyNly6JUvwnqhJTB296Q/lhX1Inn5BhshmPaA64bUTk37QIxMBj5JlRSRQwaOCSDaZCJWcy9R7E23gCXlCb/oDT4G24OQNGLoPQTS2vSBmucL1doPIXKCOTL+KsIKynU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2703.namprd12.prod.outlook.com (2603:10b6:805:75::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Fri, 13 Mar
 2020 16:09:59 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 16:09:59 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 0/2] fix gmc page fault on navi1X
Date: Sat, 14 Mar 2020 00:09:31 +0800
Message-Id: <20200313160933.10394-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:202:2e::13) To SN6PR12MB2800.namprd12.prod.outlook.com
 (2603:10b6:805:6c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK2PR06CA0001.apcprd06.prod.outlook.com (2603:1096:202:2e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.16 via Frontend Transport; Fri, 13 Mar 2020 16:09:57 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: db3d4200-7998-4bbe-734d-08d7c768fa56
X-MS-TrafficTypeDiagnostic: SN6PR12MB2703:|SN6PR12MB2703:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2703E95A4E7D9EEB898A5BA687FA0@SN6PR12MB2703.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(199004)(6666004)(86362001)(36756003)(6916009)(316002)(6486002)(4326008)(16526019)(186003)(81156014)(956004)(2906002)(26005)(2616005)(1076003)(81166006)(7696005)(5660300002)(8936002)(52116002)(66946007)(8676002)(4744005)(66476007)(66556008)(478600001)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2703;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KwagYG0agDadA5dsiPuEeGZR19oEQUXXd9ZDlwZrG0KGn+2Cb2Vp3cThTj8Mr1iTUIxVuoFjCjsj04+iFeQik+cSpb3xhFzG9wK41hCGyOPG3FJmIAb8NeX3bptxHMdp8MEc4IN1z4ye/WscbI3HW+mkHI6v0xYAF1wfebOo8drgEk4Srj3V/RwXadkn2S00q8LpBAPVw47999X0LrCjX1TOjxMPe44psNzVNuq67dPu/eiXJfSVjZN2OzMaI0wk3YDg396dkIvZVwDwMYk1UTBtD4pyu1ZEQiWpcP8FKLfj74ry7liTgXLyFuSivil3mlmSpQNKhq6EvbXgM70EFP+0pdRrNMRNgTrigiTysRuv4cCfcpiJ4ojmM+DLqG3zU0EShvY3iS5CdG4heOKcZN2RfLLm8QKO4Z4ZZA3jUT4lZAZY6AHvLPWH/poSpsgmlZ05W6RZMOKyEj206aEs8eb2csDym52hkv63uhM34N22q7/KkEbOyajGfY1QLu0w
X-MS-Exchange-AntiSpam-MessageData: GsjAzYzcUKUZ8ll15Q4GSsZadkWmSFCGpyO/H3A9a0FQnIlSUyHfCVRLheJY9b8dn955LaNHFPrfgdj3duARmwdgkMramsQLcdUyOZMBUctkjQVNeItuxuCJSqWBdZrP3gbtuuCNSeby3M3n5yWP1Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3d4200-7998-4bbe-734d-08d7c768fa56
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 16:09:59.1287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FATWux5HXiotFCfJoQuihBex28k/0uEC8Vo8tdq8dQvDdhFhHF0ftXoihtTHNyvZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2703
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
Cc: xinhui pan <xinhui.pan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We hit gmc page fault on navi1X.
UMR tells that the physical address of pte is bad.

Two issues:
1) we did not sync job schedule fence while update mapping.
fix it by adding bo fence to resv after every job submit.

2) we might unref page table bo during update ptes, at the same time, there
is job pending on bo. and submit a job in commit after free bo.
We need free the bo after adding all fence to bo.

change from v3:
use vm to get root bo resv.
add vm zombies list head.

change from v2:
use the correct page table bo resv

change from v1:
fix rebase issue.

xinhui pan (2):
  drm_amdgpu: Add job fence to resv conditionally
  drm/amdgpu: unref pt bo after job submit

 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 24 ++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  4 +++-
 3 files changed, 27 insertions(+), 4 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
