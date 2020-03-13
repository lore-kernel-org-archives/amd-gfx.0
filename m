Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982A0C2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 14:08:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B6D52072C
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 14:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tIQlDF3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6D52072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 336CF6EBD3;
	Fri, 13 Mar 2020 14:08:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 162256EBCF
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 14:08:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIlTmSy8BgS4v/NQLtIMbOsZd30hpdiQwrLS/t5oxlLVQvX1pmcoY2Ey/srWHJaK6gTJGRJHMhn/YgJWzMaaQpaQbSZjh2xgl4AUPYbffZL5C/vbuPrUjWfjRUXsf/CmC35YGDXtyrfldso/+zyOldgdzsmNw6l2NZK71UwqA/luNQkNhy67Exl8hxgPkbjxC4XoaX6gHaheB1v+Aa+GXNg3jEat+Y28+x6SO/yMOLFuZWdoglr2sQbSBShelJT9KLdSNSrYUDh1Al6Wg+Q9pR4AYiy+ce8gSsxKMlqPczztrY2KRn834zkCV6Bu7yV40MTemRLiUd1OeyieEhZEKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rzVvb4dw/V9EebveMeTLZ0BWd1hSSle/j2Ic5wDUUM=;
 b=EiExuXNMiVRSxsIQTYBnBkQ6dL+CY1QxYyZByKKMaB1t9uh4ABwrRfcTiCYH2m188OOc0pt8YDA061jaovkrl41pbkgJUl9VuwsmeWn/1W5Cz4xxD8duVCTS55giwghdqS94o6hGo47i2Odm82NMS8TGBZOqtNt8b16s701L4siBWbUrhK9T0ED0PFHAH/YCXKZxq6d3WfsUt4bAM6l45H25MIpPYEUs1LpmmlzAWkxzwnumdbixOnDCZimD5EBSPnQuQNZJmsII7Z697LHo7MM/dzIoUg7/j7J2k23rMfayeyKcY+8mf+qjmG1RyvlxqOhQF6VHA5HQero41Hb0Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rzVvb4dw/V9EebveMeTLZ0BWd1hSSle/j2Ic5wDUUM=;
 b=tIQlDF3/etnidkafwoosqLr1F6ZRkPBs7Erm7BzdEe2uYYaHXOJCB16Y74Bw8sxUYe7iMVFv4U0LEhUPB4F8TR8O/pc4M9OjaNpZeDQp4taEgvmRNzfmU9GviUEP6yJ8UFeqLj98LKQTSq+1h2riWH9lPYKYjHrR/pgAJKyDVLA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2688.namprd12.prod.outlook.com (2603:10b6:805:6f::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 13 Mar
 2020 14:08:23 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 14:08:23 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 0/2] fix gmc page fault on navi1X
Date: Fri, 13 Mar 2020 22:07:56 +0800
Message-Id: <20200313140758.6607-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR04CA0083.apcprd04.prod.outlook.com
 (2603:1096:202:15::27) To SN6PR12MB2800.namprd12.prod.outlook.com
 (2603:10b6:805:6c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK2PR04CA0083.apcprd04.prod.outlook.com (2603:1096:202:15::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.16 via Frontend Transport; Fri, 13 Mar 2020 14:08:22 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6c24df9d-4e5f-451c-cee1-08d7c757fdb4
X-MS-TrafficTypeDiagnostic: SN6PR12MB2688:|SN6PR12MB2688:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2688CADF211E2C9C1DC131D487FA0@SN6PR12MB2688.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(199004)(2616005)(4326008)(86362001)(316002)(26005)(956004)(8676002)(2906002)(8936002)(81166006)(66946007)(4744005)(66476007)(52116002)(66556008)(7696005)(5660300002)(6666004)(81156014)(16526019)(478600001)(1076003)(36756003)(186003)(6916009)(6486002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2688;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KFFAtla2CBRTvYT2S7v8WlnYEm+rjC7+sacm8JjxT+LWJSIPSrZJuTlzXQfGTBmv6d1PtsYeDHLtwGMSY2YRIcM1d3IYaQI8yX6AA3mMwsz35ODgPkGN08nzoPKfRB1L8kQYvzK0Dl4Xo8b2L0qLtXBWdSk5AjAOSSolMhmM2/+juCtH8opU2BFj4DSRdyAp+2cHfP2FUcU5w7bPwBrresmo7IhacjlYECcJgP8ByT72PjYw88wLzyWCENCp3YkjHZTy3ZY2OIZlnv/0ps57+baLI79BF/BK841HXUwUhJ3kDm46wWV9M0JCHGUGZXKbbZ/TIe8APahwFvK2dTcM37ICie/aTdSbKoqwWUa3cCH4npNBSjJ++xBoiBaRYp29Lf/rXg6LEsIAKYO2RxlanqMU+b5JmvpRf6s2gi2r3ssYNDv69luhS0kEB81i3fwyPe8sexbcJ+cGZPJOeXn1kmHcEdhJs31EMNjTx5Y1f85WxArALmhXei06fh6+ETxq
X-MS-Exchange-AntiSpam-MessageData: CmpSzLq6yOieH8DQOkRr+7ZeJN2mqtbRUIsEl6s3RlNuNFZk3oqtpCXnEgAJtcbfD7e0YMY41XPtbGjiKPi+vpTPKGnZZSwAxbfZJ7k3NxegJd8QVv0YMf8SWTTvt+3ifmmRqA0rBivKI2lhDoi8Lg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c24df9d-4e5f-451c-cee1-08d7c757fdb4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 14:08:23.3269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZyVqmZaPgzef+LC7i2YjP1Ghrep3GJqPAt/t72QyL8EzXYKnJAHQ+O43PGbRTVP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2688
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

change from v2:
use the correct page table bo resv

change from v1:
fix rebase issue.

xinhui pan (2):
  drm/amdgpu: Add job fence to resv conditionally
  drm/amdgpu: unref the bo after job submit

 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 42 +++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  5 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  7 ++++
 3 files changed, 42 insertions(+), 12 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
