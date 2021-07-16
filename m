Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E541C636C9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 01:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D36986115B
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 01:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36986115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64B696E8D2;
	Fri, 16 Jul 2021 01:25:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 704846E8D2
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 01:25:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJBllAmc/BFAfvTLqrs8Ozxh33sSY0o5E760OaxPdBhm7VkN/hfHYlTbTD8+3uKWWK5KmA/eY/62Gq/yO67hLim6wVlkoMBY5x3elEtCYByRUXN95zGRh1SjGQ1IdIstYU/xj4laG19xb1oYXh/2PQkqHk/UPY+vG28CduuZmkS9nhw3kumzleeVuoj6cDV0HpcRnOsbc6Y24HUgTWD4vD17ohW48UaJLYJCL6/NrLjrjbtDacV8pUH6X5y66X9QRsIUD24UON9Pr9/7Xr0PurKI7pFtV3IG1N9pLM1NLwljeKyVzuqHuzt7leY97gPGsvpNZEPx58GvDoOeMV0CPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+U1zSBTX7ENjDYSyrjo8B5M3ArkALt9f+0DU7kJzC0=;
 b=LPkwTaEuDAFbMgiBX33YetT5EJ2oerG63ULgjOYmBlHTLjMD50O+0bNEXFCJ3LQlyHfR+eGxgKBy0xsj4iRfY+ycz3Lgnykaia3uNDFDqCexAKPKyI2sXJIvJMtt6pjjjysufu6DsUZ2Ks/N/syQpsdVYFGtfYf7ho0Y64eSeiIvhH5GiFIxwwCxaF2RiHKB0IEfe51ah7Yz+BGk2iepzmjukO90PFZJEef+Bis7P+qpISarQEH22WAui6G+KDbTb4whEYWUe/0LOHZfALwMnvKMbIvfQenCB3PEyFtuuRKEbFFP3G4unhP9Dx+ooquw44tO5oOemaZDl+/3pn4z1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+U1zSBTX7ENjDYSyrjo8B5M3ArkALt9f+0DU7kJzC0=;
 b=AIf7F2O4y5IZ1yYHmino5bSglKSxiyooUTAWgMyaGsVtm1hOLoFdlcfUCxgNdQx2ebK9quRBf7f3AdaIpaybux45h4OPZgI7dDeULTDRABMfr255FrCkmYXOHScLIStg+1HUhz+rlCj3AmMFyVQYCzBkvNGYukguPM6T/f6R6Cg=
Received: from BN6PR22CA0035.namprd22.prod.outlook.com (2603:10b6:404:37::21)
 by BN6PR12MB1217.namprd12.prod.outlook.com (2603:10b6:404:20::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 01:25:22 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::84) by BN6PR22CA0035.outlook.office365.com
 (2603:10b6:404:37::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Fri, 16 Jul 2021 01:25:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 01:25:22 +0000
Received: from ozeng-develop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 15 Jul
 2021 20:25:21 -0500
From: Oak Zeng <Oak.Zeng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/5] MISC fixes
Date: Thu, 15 Jul 2021 20:25:10 -0500
Message-ID: <1626398715-6419-1-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7c2543e-5fd3-46a8-0c3b-08d947f894c2
X-MS-TrafficTypeDiagnostic: BN6PR12MB1217:
X-Microsoft-Antispam-PRVS: <BN6PR12MB12170C7F4C5C2896D1D4955D80119@BN6PR12MB1217.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r2aCbh7GglV39FDKB2dzQ7jgTl445k3S5+M3X95N4X48nBF10wcDFhA1Y1KkYMfBsupWHXFcIqQGKgir5IjMjFnaR8QlbPMPcXuXGSUDUDan3is9KKvqt86jJZAvQaSWTdAHqCLHjH7uHD6AzVRu6Mx1xLgb5aMxEtDAJTArelc6Cb3r3rD7/+yZw9Jb61COLimDdldEauutxdw56J5DmOqv9sQHRJy71IcQVbwXsTV0+6zrT+dEoKhQ3ulb1UNtCgEUkorvKmvDoNo1Yv8mZqIEvTDET+fQ9H1QUCt0axlUeZ9ivVFIv6uV7t/9ZE6omNqVUjpOQ1fRpKxrj6hzNASsTj6xjklciimHBIR3wifF71quD64GmCrbD2odXY6PnnuDJHTJAms8csc8ckAm0F0h73nnGksVJLOU4IDt4qQo/5ciaEdQzyG3re08eW/57JUyHdcuCKKEckeKybs1lyuZVOjBL3Go9DX2AsixT39CJYg3yv3byJzBILm/v8FVy3+46NSqPaBwumZHVv+0HtoPSX+mDAREK9Qu83LYFWoiYZZpGl4KzVa1hlllzW5PhB8r8DnGMJwjUwyQ0gC6zx+ZXQqgPoL5hzWQleBWfo21ZFaM69WfPHmC6OS5n1U/NMF4OOc1h2anSBjN6LkS+XtJ49msM000YrVOoxIZNye1gTKQoRdg8Pud7VQNWsHqg6jqHKhI5UABzQlvWy4blhcqIrGZCpQHl7NQl8jWFKU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(46966006)(36840700001)(82740400003)(5660300002)(356005)(4744005)(6666004)(83380400001)(81166007)(54906003)(8936002)(70586007)(8676002)(2906002)(70206006)(47076005)(336012)(2616005)(426003)(186003)(82310400003)(316002)(4326008)(36860700001)(478600001)(36756003)(16526019)(7696005)(86362001)(6916009)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 01:25:22.2292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c2543e-5fd3-46a8-0c3b-08d947f894c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1217
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
Cc: feifei.xu@amd.com, Felix.Kuehling@amd.com, leo.liu@amd.com,
 Oak Zeng <Oak.Zeng@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Oak Zeng (5):
  drm/amdgpu: Fix a printing message
  drm/amdgpu: Change a few function names
  drm/amdkfd: Renaming dqm->packets to dqm->dpm
  drm/amdkfd: Set priv_queue to NULL after it is freed
  drm/amdkfd: Fix a concurrency issue during kfd recovery

 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            | 16 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |  8 +----
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 36 +++++++++++++---------
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c    |  4 +++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |  2 +-
 10 files changed, 40 insertions(+), 36 deletions(-)

-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
