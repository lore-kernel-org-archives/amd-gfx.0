Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4056C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:46:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14DFE10F10B;
	Fri, 29 Apr 2022 17:46:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 638E410F10B
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d642MSLlb+lZCJoMI9ikMKmccfswM96BlPYxmuVvh1/KJ4yrcCS6N3u4Ejt34MtDUfnndzlaf0+FIWFl/redbRU/ZM1+99AM48IWT5+5zjXbMfd70UI3h+xCYoiWgwuNRVQ5tXDkI5gxd/DmBgsl9RDExpfZ5N9GgFwCpZ5HXf+wj51lNJgGNBqIi1Ikzkdvjf7gPdQlpDMma5+rdI8FlL3AQMFw/dG2t4WPp08QQaksBLJI5mCDZVeBEZl2+3AAECvxoHyeMRBnLyEijivSKy+8jVgKrUj2Q4JUwrSdtjS+NuCiq71h9ZhFZwjZRrUMM+JDTqdsSlkbQqcSHkn9Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3tjZgsrNQXmHOUlLPWepRAyEW8HXAmApx26kErMY7A=;
 b=gBqG8QwGRxOEiNTGX2OBWxsgsefxw9zFyKaWYFxqgbg8MargzoP5NeY4Hcjmxm36t3BfNLOtXVb2juhBZEkM85uYQ3/SjO4bwuu6mLunNm6pyyYI7txYg22zP3uanVudRPbljQpFvtmf6mObY0OkxVO/dVqL1MHsImSvEa5b8w6YRpUOG1LRJoz1xVtqkmWmv4uzNFgLtqs0jucv96P3a3Ws6FrsMBASOP2r2lhV9iK54R95N1J+LTojI5za9csGbMthNp2l9y7oU3LpI3Rl0+dU2NXqL57FqM2pHymY4rShtOEKndhfllYM27v8JAnvP6PbhSOI1I8KHa9uJhoArQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3tjZgsrNQXmHOUlLPWepRAyEW8HXAmApx26kErMY7A=;
 b=RIOkeSEERvTre+0UZynjysAwxyrO65VzJCY5v2Dg0L1XhBh80/xQug/74NaIEN0Gvy7hFnEivEVfhetBscUzKyYh950fRXXeqkSBnFZGnbvPuMS9dc74VGvrRH7umXkN6HkvzIiO5sPT9TPqpKzmYz0WLJ0CxWGYtKuitDQYwak=
Received: from DM5PR08CA0055.namprd08.prod.outlook.com (2603:10b6:4:60::44) by
 BYAPR12MB3109.namprd12.prod.outlook.com (2603:10b6:a03:db::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.20; Fri, 29 Apr 2022 17:46:37 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::75) by DM5PR08CA0055.outlook.office365.com
 (2603:10b6:4:60::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/73] MES support
Date: Fri, 29 Apr 2022 13:45:11 -0400
Message-ID: <20220429174624.459475-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ea2e5d4-2293-4a31-5a60-08da2a0835a7
X-MS-TrafficTypeDiagnostic: BYAPR12MB3109:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB310908DE83A653B6E2F583C6F7FC9@BYAPR12MB3109.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ONOxBsB3GKKS5Nn7ofCOFfrOBWXuB5QscUc7VmKBvxZAtktyA5E11Xnc3dc/Dxks+Rv8vdmy/wiRaD6H6XtGByJq1HF/DATLJy8qB2QxoCLJawo1S1P0eVdqvIp3KoWUhrQ/0+mfQaN5ajIzhDhKn6lTynMI6fvVq/vB7t+D5/V97ZjudsGGOqJCQT4mHt/oW5N0DKVV4KEEsqyjzR7EJZL1JMLkRsIEXrxfGlmT5TdOe8cfyf42aLc1t1odmscyVetFkK3UCzCFmtVd1lZcBRJBuWlUyN8mx0/EljZGnVsUwu43jziC6SFHLdPug3Q3+B+8UNQcoU/KMTeD6l3UKRbjwKrWRg8Q/UzulGmpCnvhE+KrBLfG9AfXLGZWriFeEi53MdzpcAYZ1/RKO300m2r4+eD9j7QTqHoHTrlAIwwJWA3mrZSXc2I/cih6Sec4I21UqJ7tTEGZyfJ26Pfqwt6Wy6WSMEw9VZQOpa/YNynQTbqHeld59K48NszbsR/OA28Dn+hLl6QAvbTY9oT5QwewRT/cze5TFdh+SXSchNDSfk6gwIr1qQUyo+2xqbcv9BB9Pu7NErkOtS+F8YHIhWyr06JFb9ubNxeotyoMYvzgJVib7o8wDxEfhz8hzGNtitX/RHzt8PR5BXvbGRgPMeytWtZKjS6YVv3AgTKeQo42lQYsD19UjtIU5PbySCnrlOivJQNmUoc9X459fpBekQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6666004)(2906002)(7696005)(40460700003)(36860700001)(426003)(336012)(83380400001)(70586007)(70206006)(26005)(5660300002)(6916009)(36756003)(81166007)(1076003)(356005)(2616005)(8676002)(508600001)(86362001)(316002)(47076005)(16526019)(8936002)(186003)(82310400005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:37.3674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea2e5d4-2293-4a31-5a60-08da2a0835a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3109
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch set enables support for MES (Micro Engine Scheduler).  This
is similar the the HWS (HardWare Scheduler) on the MEC currently used
for KFD.  It's a scheduling microcontroller used for scheduling
engine queues to hardware slots.  This adds the basic infrastructure
to enable MES in amdgpu.

Jack Xiao (70):
  drm/amdgpu: define MQD abstract layer for hw ip
  drm/amdgpu: add helper function to initialize mqd from ring v4
  drm/amdgpu: add the per-context meta data v3
  drm/amdgpu: add mes ctx data in amdgpu_ring
  drm/amdgpu: define ring structure to access rptr/wptr/fence
  drm/amdgpu: use ring structure to access rptr/wptr v2
  drm/amdgpu: initialize/finalize the ring for mes queue
  drm/amdgpu: assign the cpu/gpu address of fence from ring
  drm/amdgpu/gfx10: implement mqd functions of gfx/compute eng v2
  drm/amdgpu/gfx10: use per ctx CSA for ce metadata
  drm/amdgpu/gfx10: use per ctx CSA for de metadata
  drm/amdgpu/gfx10: associate mes queue id with fence v2
  drm/amdgpu/gfx10: inherit vmid from mqd
  drm/amdgpu/gfx10: use INVALIDATE_TLBS to invalidate TLBs v2
  drm/amdgpu/gmc10: skip emitting pasid mapping packet
  drm/amdgpu: use the whole doorbell space for mes
  drm/amdgpu: update mes process/gang/queue definitions
  drm/amdgpu: add mes_kiq module parameter v2
  drm/amdgpu: allocate doorbell index for mes kiq
  drm/amdgpu/mes: extend mes framework to support multiple mes pipes
  drm/amdgpu/gfx10: add mes queue fence handling
  drm/amdgpu/gfx10: add mes support for gfx ib test
  drm/amdgpu: don't use kiq to flush gpu tlb if mes enabled
  drm/amdgpu/sdma: use per-ctx sdma csa address for mes sdma queue
  drm/amdgpu/sdma5.2: initialize sdma mqd
  drm/amdgpu/sdma5.2: associate mes queue id with fence
  drm/amdgpu/sdma5.2: add mes queue fence handling
  drm/amdgpu/sdma5.2: add mes support for sdma ring test
  drm/amdgpu/sdma5.2: add mes support for sdma ib test
  drm/amdgpu/sdma5: initialize sdma mqd
  drm/amdgpu/sdma5: associate mes queue id with fence
  drm/amdgpu/sdma5: add mes queue fence handling
  drm/amdgpu/sdma5: add mes support for sdma ring test
  drm/amdgpu/sdma5: add mes support for sdma ib test
  drm/amdgpu/mes: add mes kiq callback
  drm/amdgpu: add mes kiq frontdoor loading support
  drm/amdgpu: enable mes kiq N-1 test on sienna cichlid
  drm/amdgpu/mes: manage mes doorbell allocation
  drm/amdgpu: add mes queue id mask v2
  drm/amdgpu/mes: initialize/finalize common mes structure v2
  drm/amdgpu/mes: relocate status_fence slot allocation
  drm/amdgpu/mes10.1: call general mes initialization
  drm/amdgpu/mes10.1: add delay after mes engine enable
  drm/amdgpu/mes10.1: implement the suspend/resume routine
  drm/amdgpu/mes: implement creating mes process v2
  drm/amdgpu/mes: implement destroying mes process
  drm/amdgpu/mes: implement adding mes gang
  drm/amdgpu/mes: implement removing mes gang
  drm/amdgpu/mes: implement suspending all gangs
  drm/amdgpu/mes: implement resuming all gangs
  drm/amdgpu/mes: initialize mqd from queue properties
  drm/amdgpu/mes: implement adding mes queue
  drm/amdgpu/mes: implement removing mes queue
  drm/amdgpu/mes: add helper function to convert ring to queue property
  drm/amdgpu/mes: add helper function to get the ctx meta data offset
  drm/amdgpu/mes: use ring for kernel queue submission
  drm/amdgpu/mes: implement removing mes ring
  drm/amdgpu/mes: add helper functions to alloc/free ctx metadata
  drm/amdgpu: skip kfd routines when mes enabled
  drm/amdgpu: skip some checking for mes queue ib submission
  drm/amdgpu: skip kiq ib tests if mes enabled
  drm/amdgpu: skip gds switch for mes queue
  drm/amdgpu: kiq takes charge of all queues
  drm/amdgpu/mes: map ctx metadata for mes self test
  drm/amdgpu/mes: create gang and queues for mes self test
  drm/amdgpu/mes: add ring/ib test for mes self test
  drm/amdgpu/mes: implement mes self test
  drm/amdgpu/mes10.1: add mes self test in late init
  drm/amdgpu/mes: fix vm csa update issue
  drm/amdgpu/mes: disable mes sdma queue test

Likun Gao (1):
  drm/amdgpu: add mes kiq PSP GFX FW type

Mukul Joshi (2):
  drm/amdgpu: Enable KFD with MES enabled
  drm/amdgpu/mes: Update the doorbell function signatures

 drivers/gpu/drm/amd/amdgpu/Makefile          |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h          |   24 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |   42 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |   10 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c    |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c      |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c       |    8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c      | 1138 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h      |  168 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes_ctx.h  |  121 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c      |    6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c     |  193 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   22 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c     |   24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c    |   10 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c       |    3 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c        |    8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c       |  383 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c        |    8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c        |   16 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c        |   20 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        |   25 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c       |    6 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c       |    4 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c       |    4 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c       |    4 +-
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c       |  461 ++++---
 drivers/gpu/drm/amd/amdgpu/nv.c              |    3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c       |    8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c       |   16 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c       |   28 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c       |  169 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c       |  171 ++-
 drivers/gpu/drm/amd/amdgpu/si_dma.c          |    4 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c           |    3 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c        |    6 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c        |    6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c        |   12 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c        |   12 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c        |   12 +-
 41 files changed, 2619 insertions(+), 553 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mes_ctx.h

-- 
2.35.1

