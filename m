Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95274C32771
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 01:29:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50059214AF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 01:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QTzZbg+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50059214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1167D6EC45;
	Tue, 28 Jan 2020 01:29:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D57F26EC45
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 01:29:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvOtHLm8xy3S898o38XoCy9l/hqaD7caElFK5AKiAf8V5gpBGjrPRa0ZgvfP8SfKkvhNRqYKs9tMIf86Rh26QNExWTS54Zx+nbCaw858qVqGvSrz+/H1x82UOMo0TJAmYvRfb8qQhg2HbjIjKEq2re4MkZv1BeQbm+jAbUnZhaIt4xd3zARlIv1ZoO8lFlPOPozKJ4RrJ5vZtUelCQf3zTrts3emCNY8FLAkyoS7j4gn1KHQzKYq96hcfa59m0pHWV2MqBDMGYUHvdoaWhRPR1pC8p+c9Hx1PiSwCpSYIMfkQGJRey3gyI72o1PVZ937Otccc8rbyej4yrr+pEkiHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K95FSELfj4QyyynOCw76atvb6ijgQWaJK9gWGEboYn0=;
 b=CqbELfN5rd5FkJT/SnMw6WGNl55a0OKjuR70LGq3/OU1x9FdxHtuTMekyGizgRDTQFCJckgQ6MUpGjHrUqGiUS/FlK+JXRZRrcjeD3NMKKCiNFx/Rhktj1hk8EcplhFPbCVK59uEAkF4m/2YTFbXQgq/GKKXJKTn90vlD2MB0RH32XnRlOLwKCeVep+B0fi6HFkx8HCqJcBntLUC8K297ahjkxz31r4Fc2GjQdVKenA/1+A9qcGDkLRQBIJyhqeMcK9IFxUyhIipHIBhLE3jlImdIaYhVOkzba9oZ+Igs9zdTZ5LDHQYPBydSXILXh80w2Qo8LhBZYV9eAQbKTAdKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K95FSELfj4QyyynOCw76atvb6ijgQWaJK9gWGEboYn0=;
 b=QTzZbg+IWpoYpIlPfo2BEI4n5sc4/pBflX8NY9Cg0F2zoDJMQ9daePxaf0hpJsiESPfXuu0A0FVv2lRN6e1Ez1PyEM+4qIPpgJqHfOyi9//Afi9Vec6JfXM4EnHyxTopK1RLZi5jAHqpPns8cZdmn0b3NTWS7GTo/ZUVVmZmJvM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rajneesh.Bhardwaj@amd.com; 
Received: from SN1PR12MB2366.namprd12.prod.outlook.com (52.132.194.147) by
 SN1PR12MB2592.namprd12.prod.outlook.com (52.132.194.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Tue, 28 Jan 2020 01:29:56 +0000
Received: from SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::596e:6046:7bf6:9a80]) by SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::596e:6046:7bf6:9a80%7]) with mapi id 15.20.2665.025; Tue, 28 Jan 2020
 01:29:55 +0000
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [Patch v1 0/5] Enable BACO with KFD
Date: Mon, 27 Jan 2020 20:29:18 -0500
Message-Id: <20200128012923.25536-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::46) To SN1PR12MB2366.namprd12.prod.outlook.com
 (2603:10b6:802:25::19)
MIME-Version: 1.0
Received: from rajneesh-desk.amd.com (165.204.55.251) by
 YTXPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.21 via Frontend Transport; Tue, 28 Jan 2020 01:29:55 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 30ade9ab-126d-4cc2-99e6-08d7a39194c9
X-MS-TrafficTypeDiagnostic: SN1PR12MB2592:|SN1PR12MB2592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB259243DCD0990BBA945051F0FE0A0@SN1PR12MB2592.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 029651C7A1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(199004)(189003)(7696005)(52116002)(66946007)(966005)(4326008)(478600001)(6486002)(8936002)(44832011)(2906002)(5660300002)(6666004)(956004)(2616005)(26005)(36756003)(86362001)(81166006)(16526019)(1076003)(6916009)(66556008)(81156014)(8676002)(186003)(316002)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2592;
 H:SN1PR12MB2366.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kVecqzmm34FrHF4nRalolmIvkJBycI9lAw89nO05wnvhkQz3ubi+i1NesXgKOtZ3EUsn2RJNlLOFfsezP9xnougnDAl01cbEiCJv2HQ89YwLWcV1Hbvm15Ps5xSBC0MsEcHz552/2mYNU6FetCw7hR0SWFQ4KIDk12LvB6fMUhnWKXPNSojVPKzLZGki33+KfagJdURdr7ngB6neVzwtueHSKwuO6LVO1GJBDRRVs57Nt3mUN2998RhxKQGFFPp9OFFP7dNCdODo4JgW2MVonYBHtCSGeZmhRe5MDWa8UsGkLYJYAkmII0E1ef4Hw19XqUtpH2GBv9QFdj0tzmUImsL6T9s6eGLOOhvyweRTrmh68ozUdYclDh8wvKTqOj/7+E6iHcNw1TN+txITi8Am1OuK8PyKkucH5ksUQORPQEt2jAE9NvxOzawGB6BtD1d/Ix6aPO0lFJS1W5VX+p7bG5ZDKCRt5+JPHr6+iI0btZk=
X-MS-Exchange-AntiSpam-MessageData: 7IbVSI0G7AokfEO4edefiaReY33IlJeldyhk5us1Ek7Z4vNOwqRtKqFnek5VQ1yzPwKuhA/T8yzai0BUDMM4UpvwWp/GNpsKIS85nnSluKvcyBOLuyjAblieefQSgBK4ZSOw02CsmRNFy18EmYmSLQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ade9ab-126d-4cc2-99e6-08d7a39194c9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2020 01:29:55.9169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzLjWhKITgoiOCi9g9yvciH+4PdFbDzANfpLvU+63rMRb9TIy+VIY77Cj2G+9NIW4uAPwjH6F51aNSuVFBS/pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2592
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
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This series aims to enable BACO by default on supported AMD platforms
and ensures that the AMD Kernel Fusion Driver can co-exist with this
feature when the GPU devices are runtime suspended and firmware pushes
the envelop to save more power with BACO entry sequence. Current
approach makes sure that if KFD is using GPU services for compute, it
won't let AMDGPU driver suspend and if the AMDGPU driver is already
runtime suspended with GPUs in deep power saving mode with BACO, the KFD
driver wakes up the AMDGPU and then starts the compute workload
execution.

This series has been tested with a single GPU (fiji), Dual GPUs (fiji
and fiji/tonga) and seems to work fine. I have not seen but expect some
corner cases where for some reason a KFD client binds a process but is
unable to complete the task within 60 seconds. Ideally we should put the
runtime_put and auto_suspend code in some function which is logical
opposite of bind_process_to_device but during my experiments, it ended
up with random gpu hang, machine reboot etc so any comments for
improvement are welcome.

Todo: 

rebase on top of https://patchwork.freedesktop.org/patch/338037/

Rajneesh Bhardwaj (5):
  drm/amdgpu: always enable runtime power management
  drm/amdgpu: Fix missing error check in suspend
  drm/amdkfd: Introduce debugfs option to disable baco
  drm/amdkfd: show warning when kfd is locked
  drm/amdkfd: refactor runtime pm for baco

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 12 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  9 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  7 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  9 +++----
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c   | 27 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 31 +++++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c     |  5 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 19 ++++++++++---
 10 files changed, 91 insertions(+), 33 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
