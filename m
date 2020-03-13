Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77269C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 13:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFD65206BE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 13:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gwfefdat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD65206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8829E6E29A;
	Fri, 13 Mar 2020 13:19:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 706B26E29A
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 13:19:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ky0gw3TooIow7w+xbe7Uc0h7jOSLFd/Og1D9Lgf+rQ2S8ofgzsEZ76kevJXesXG7Dr0TtTGpdU9fUHhhIzgMtpzMbGOV7S1XWrkAelk97OcZbt6EvmqJAuyGqgXMEYqw/EsIhSlBqjOzgk40xqZ0G6Ahy7vJT1ZU3iSsnspvLLQYqy1BDuki349DygnkIJVqyU0KrHi2Vt75XOatfJ1r4k2n51e6a8+QVclhbuVe8Hm9tnv8Zemi0+TYXpjiy+wb10lyyMwl/KCXqI6xdZ0xFqQj/2oDeTFk5/97sOtghavOIfKkfF/wa2F3ylS4vbOmY6vEhK6liMEeDVaRVj8EHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P97p5r4GbcC2UdMbRlApsPvCggkdOqrMMmVBCfb6MXo=;
 b=Mv0WiKO0PpSphjonVXoSShEV79L1qHIjdplvfB9D3bLzlRJtGkjjJJL09hP8NWbbTW4/f9bGMhlUk9kUQWjXBl7jxpDMyhErdRzdydaOZD8G0uMpmmcQWDjVZegiKexQyuWLekWsBlbqwEhXKvosuzICLnpCpGqUvsEQcGIEMF4BLFDDQa5hYNxa3OWvzhiBf7qI/P8GHfYEuai83HW6iJkd+WoJ6WPUZjzXUmbfEQDEwtv2sub6wmrrXUCyoigCRJFX2WAhTVfmMGlqPw+BaIDtl2Zu6mYHUd5Tk8lVFb13MFX3bvkwlT3dQ+KFO0QyoQabHbSNC4VOoeBr21XmuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P97p5r4GbcC2UdMbRlApsPvCggkdOqrMMmVBCfb6MXo=;
 b=gwfefdat+J68SQpYuY+gQVZH1K5d4aGifnzmW48A4wizOHmYkb2OyuDwiFhU7i3JKhD39cYMVXw/Ple/eU8aXjRp9MoKLY50yRow6Kkp7uJAQS35L5PEVoob28Z/qALvYzdXYosaNdlNYp7TISkJq2WOq3Wi5H5vbEKSx7PVAE4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2848.namprd12.prod.outlook.com (2603:10b6:805:77::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Fri, 13 Mar
 2020 13:19:45 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 13:19:45 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 0/2] fix gmc page fault on navi1X
Date: Fri, 13 Mar 2020 21:19:16 +0800
Message-Id: <20200313131918.29721-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0182.apcprd02.prod.outlook.com
 (2603:1096:201:21::18) To SN6PR12MB2800.namprd12.prod.outlook.com
 (2603:10b6:805:6c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK2PR02CA0182.apcprd02.prod.outlook.com (2603:1096:201:21::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Fri, 13 Mar 2020 13:19:43 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4e5305c2-b97a-477e-b111-08d7c751325f
X-MS-TrafficTypeDiagnostic: SN6PR12MB2848:|SN6PR12MB2848:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB28483F88585DB4B072AFFD9687FA0@SN6PR12MB2848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(199004)(478600001)(4744005)(66556008)(2906002)(8676002)(81166006)(26005)(1076003)(81156014)(86362001)(8936002)(6916009)(16526019)(186003)(66946007)(36756003)(66476007)(5660300002)(2616005)(4326008)(956004)(316002)(7696005)(6486002)(6666004)(52116002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2848;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6OxsBKTy/OVq9sVOiENXv5htM8WIBYG2XxP/R3YmaDLSK7Pdf1OaiCPsAEN3FG4x3Ln2bbsEbA3zx7l4EBaWffmGRF7HSis4VXUdGR+y0UHFoTJ8JpQoJ0MKx/iCulU+7tYVu+kWo0dfRTUfEehkgvufoRtT+SnvbGQxsxgS5iYCJrbLwbspc1942PBSaECSV5jkOY/nlMhaRGxYRu5UqBoVHqHRU5d/FCOHhOP4N1X1IKhu9HL4x96APOBwmmTerovlKHO7TTmAj/9Vsf9p/vZBD0HTancAZDdwrwz85XgMQKG1M7QGDUeK4CGNq6F7QLC1SVe7+znvFW2mBBQyw3P1ACBDNCk3ckqZj8YHt/IVVjELJYxyY2+h2zFEIPs7a4xtr8rAAw5ONXtjgNiNQz0gt32PE2pJ7IIGLdminlTm7Lsogvi352PGl8rMct9RXcQpHJTiX8mK1Otaedyakq63TOhdTn91p0Trx8trLi57jSlpqSNJXAQGKDZeZ49G
X-MS-Exchange-AntiSpam-MessageData: FTh8XN76suxU2ZOyPLXg8AcxIrdI1Lp3C2mCWSH+eIAO6a4qI8y1XEPjELEzEUpJ+h8S2bueTjr7pXdFOd1Q45s/w0xix6ZPo/rrk0PAj7CxPqoUMvWIdsb0oqAWtFb7XWhD74Zjcc2GGapvDowKsw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5305c2-b97a-477e-b111-08d7c751325f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 13:19:45.2072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1luJEErbN4IDYBpUt2cGJmDnUZsoudC8SgIlWIibNypm8RNk+CWQ06nmuvc3ssw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2848
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

change from v1:
fix rebase issue.

xinhui pan (2):
  drm/amdgpu: Add job fence to resv conditionally
  drm/amdgpu: unref the bo after job submit

 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 38 +++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  5 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  9 +++++
 3 files changed, 42 insertions(+), 10 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
