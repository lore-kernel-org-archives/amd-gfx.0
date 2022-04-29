Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F948C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E26DA10F64A;
	Fri, 29 Apr 2022 17:47:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DF3B10F28A
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvNsqMEHnvXpwOdWOsrEBkr6bF1G8hmgjwZ8CaQVKb9nGOq4ukbBtf3SzJLfXci1Ubi2aR1ROwjNKx9E9V4wD3WIWMaTzZ+AvACJJvE1aiDk44DaVSkWrpevxfigEkt3yZ8prJe8LSpaL+rBlQVgu4Eck+YtCYoDYmH2xmqzO3YdliFkOjjoSlLEowid2mNMocW9i+FT0HYEQyMK0Pvq7aAorm70TI2LmLDNRnPWOGznq2L7Yr9vp9oofWfjAVKvxko3ryCPid8fC3ky/N23P5gVIKLFATebVR1CGkrCVmoDZm7YKyltv1BFHI5rvOlArnYfYJt8QR486cS/SMHXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3tjZgsrNQXmHOUlLPWepRAyEW8HXAmApx26kErMY7A=;
 b=lUAC8OEUtANSLQtTU0izd7FhrOc5FIdyNhS7lZvz6srcDSDdKkRofZIcGlGXPXg+7u0tIb9MuPIQerTd+5c593/LK3cSLT2VLlyjT44H9dD95tPE496akGXO7kYa29F0hoDYdDNyYadoz9rZ+sW2gaxTm89AYhMtfCEDORqq4PZ13CB6QVs6V9EPNRK/pPFUMUReyMc/aBVKBCEUzeGjZfh+B1l4xvsPfJKS1TnR6dPlHiPgiTvqI8LXDBV3R24vLA7qG3wucZRdlNuSr5qmVsziuXDuGkVqX+NqjTQvirSSHrXBU485/x/hFR66SpbBDIXfSrxGIe3LhdGj7Dl00Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3tjZgsrNQXmHOUlLPWepRAyEW8HXAmApx26kErMY7A=;
 b=o6/2iYoYGGtJNVnXPR5wvOyJQQa989+1gD/i0YvdwXVsWsmx1gprU1NwC0XlroRsgzCqot8bzMKdL2w04t7LMYQaSlWGciCBBv0oBv1aXRWgCGD3nOXazGnIEap6KRNBkvFdRTvzEFnE2Ri1Ce6VMS1zbCpvp3LgDzlFVozw7/c=
Received: from DM5PR21CA0024.namprd21.prod.outlook.com (2603:10b6:3:ac::34) by
 CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Fri, 29 Apr 2022 17:47:13 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::68) by DM5PR21CA0024.outlook.office365.com
 (2603:10b6:3:ac::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.8 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/73] MES support
Date: Fri, 29 Apr 2022 13:44:23 -0400
Message-ID: <20220429174536.459313-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 085ff06a-9235-4100-b045-08da2a084ae4
X-MS-TrafficTypeDiagnostic: CY5PR12MB6084:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB6084A48490BEF4356ECA9048F7FC9@CY5PR12MB6084.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3+pl91D5tIYD5bj0z+IdKdM84fVhdaPDOJ5abLP5nnf/AEJoYW5GcglEpoDEU77/bRhPH8ndcGohmCghZMiGwg6HIQAqQssC+ZTVHVeKxcmEOgVPj5vv0P0q7uR1ULSyI0YX1xwmpj/Ge2KVtM9nlPRf/yY3k+AsBZMG620jG6FvyBV9N+SlEXptzsCOYNwHPof3dPs9scP1lpshz0Vb23YXm3Z759bChG4whzkiO9jkybcXmSH0/gFFDnc/DkEf1MnK1sDVZKD2Sa2PAc7X00Nc8exdU6zlD85aZSNlDemt0pFnAUemjgG5qq4RdGCPxi2qa6UD/Ok9gf4iWX3uqHIXnuRpF3zSoIfuxqizK2ilOCT4gpZTwYm71QBw+J9Kn+Znd8BqM0Cn5OQgyOFtNQjsY8Ze0o2zr1TWjfWrVT9GhMWhzfrVQk63nVSlABQ/Zhiujmt95d/WiiKr9Hxy3B8JVKvVjpQoSa9UVa4VfAX+SNv+CBYv2oMTfhEbZS/QWtEr/kX9hWYbE1a/QMCFD76NsDg5mQYfxkf/N7JOIwXveWYbvnu+EfhVzmGtA/nN9cRKVbPiFdUxV9Gg11fLUfE1paEZXg4XnFgZOKlJYK86fQxNDFaIBa/Xo5P1WutAE2aWDHSAcvdb4WGIbYUt5MKKbiuZ3Ne+vAkrwtH14dG8zXNQUTlIHkOeYiXg88Dt22eLk/vFu/gZhmSqcw/1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(426003)(8936002)(316002)(36860700001)(508600001)(336012)(1076003)(2616005)(16526019)(186003)(81166007)(47076005)(82310400005)(6916009)(40460700003)(83380400001)(5660300002)(26005)(356005)(6666004)(2906002)(36756003)(86362001)(8676002)(70586007)(70206006)(4326008)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:13.0015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 085ff06a-9235-4100-b045-08da2a084ae4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6084
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

