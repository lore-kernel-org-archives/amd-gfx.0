Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36CAE95A8F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 10:18:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4679810E1CB;
	Tue, 10 Oct 2023 10:18:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0553E10E1C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 10:18:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FB3Xz4fo6DluR5gVZpnOpUkksyJLy09AStSiGTJo8Q6QHtVJ8OIsB9TcH2O63ST0gXCDnb0s5vze8KfGTHYBPzZNNXuL4A4BpewHbgTava9g9gU7cQ04goeS623m0aqxTrel+rhRi93179pPRAFZGOVisjE/9Rc9TGNt+hIa+7Jr2ReV4NUshV3Usab5tG/TNnaym2KBHBXFna1u+gKxuimRRg4YetDKhnTSd1ZGOVDNRDIu90CVYcu6a5tz56royoYlWc5eX5qnX3e9KD3A5/H4Q69lKM/H5ygxfN4TPKSXHKUyctYeU3yHDADWbJ0gDLUuDDYHoDC9a+Y8VQXb3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8xIuQlHy8FMUP2Io14o+iRruuTqLJSl7bG7E9ROp0w=;
 b=nb4bDW4Yoruy7ppZktOUs8nZW2ff9RfLKo2yh2SvLlagmemPl7E1XWxTZy2XUgnJRIkj6rx29LLy4AppJLPPjdo69kdLlyvQJS4gyLCWoVli6CbQDpe8EHOgaQb/Zzj7xduj/Uq4clsQ5G0tsU5DtHpzTixnkTkOJxXAFn5a7hPE1NbdRno+0z2Fo0Lewfbc6ixeT1h5VsjSK5jOoOfFYTlSo7bztFojYqyJ+fCY/QmAJwb+LbIs3r4ZLBJ289pb5zv/0AzXj7t8n6EWSykf0gH8WG2CB3+ciq5mmc+6GC3VWcwyIqYwmvYWJ4A5aZ70I9P9ZTMILrzf9izk6sUwZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8xIuQlHy8FMUP2Io14o+iRruuTqLJSl7bG7E9ROp0w=;
 b=lg+n8yJZKrkBGMd0n9KlZVUMhqcGGmdfExVnciOG9X6GVIB53mGvPYyuPvigC+Q2TlWMg3tKu+N2Ad++FKzy5zkZjrnc9hGnVnB9qUWJBV6cvWx2xHidrPayd4t/3kId4W8zohKlJOxDOzU1J0iihoMhK47KkVkT3eLKZcgvag0=
Received: from PH0P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::7) by
 MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 10:18:22 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::39) by PH0P220CA0026.outlook.office365.com
 (2603:10b6:510:d3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.40 via Frontend
 Transport; Tue, 10 Oct 2023 10:18:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 10 Oct 2023 10:18:21 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 05:18:20 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v7 00/12] AMDGPU usermode queues
Date: Tue, 10 Oct 2023 12:17:40 +0200
Message-ID: <20231010101752.1843-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|MN2PR12MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: 22920192-dea0-49b8-32fb-08dbc97a3af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qvijgThX2AfPzvdwYcXFLBpPaV3WnUPZlT9OSv1Yj/lt7RBApOdZNk3FjLgI1oldnsUrhpBzpjO74GckBA1igBydxNFhSulpo/K1IoZtc2L4IWjB0a2ABzvJ9NZ5BuaQ9T7Iwc0hW3QTjX/3+0O0KaC3yPClIcM+1x/CJneQgaVNSQykZ5G60IbYMO/hut0FBwFfzLLYZ10DHAeZJ6CVWZ27xTmEFQEg/DV2FPgI6XT4WFzEX7v85VDyvTKNLI3CQJyZvEU2kz9ZBzOz/btMk8GztTVOLDCXp2JFTXHE2AHNGhq4aMPY6HdtIkkLebHJdPokY29PxiEXuEDBW7PWHD1g+otwDiaLdM9yuS66io0di92Q1WVOWEsOSl6Xncml/Dpn130ACdBKvdi3bN0C1z3YRt9QkJFBrI+EOrz0J0YYKge+KTwjEAQ1FToajol1huRCzEaYJsDJLNGO6ufsBXVeACDY0sRww9KCSoKWwOD+YFaPLuuw4Kf3TGLZCiBtzA4L74wPnsMbCm4CNIfT0qLxrBxxlgm2hScn8PdHPIRP9eMDWfLPQ8rFmFXsanZDQIdtEtJHkPFntGQ6pkSBaW/PTaH/M8NKpENGTvIqahv4+Y/3SM4ai9dA05e6dLjIqiIITfiRD4VlZi3X37rMQTsRdCZwET7iumD7nb02eZ14e/ATSjp9Dy3DJtAYx9Lpknv22fNDBXsQAODUzzjWlVEzxuXTqV4zqcM+bLda2Bb2pWCChxMK5FkmTgd5PpCg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(26005)(16526019)(82740400003)(1076003)(356005)(36756003)(81166007)(2616005)(426003)(336012)(44832011)(5660300002)(41300700001)(6916009)(54906003)(316002)(70206006)(70586007)(8676002)(4326008)(8936002)(6666004)(7696005)(2906002)(86362001)(478600001)(966005)(83380400001)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 10:18:21.5035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22920192-dea0-49b8-32fb-08dbc97a3af9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456
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
Cc: arvind.yadav@amd.com, Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch series introduces AMDGPU usermode queues for gfx workloads.
Usermode queues is a method of GPU workload submission into the graphics
hardware without any interaction with kernel/DRM schedulers. In this
method, a userspace graphics application can create its own workqueue
and submit it directly in the GPU HW.

The general idea of how this is supposed to work:
- The application creates the following GPU objetcs:
  - A queue object to hold the workload packets.
  - A read pointer object.
  - A write pointer object.
  - A doorbell page.
  - Shadow bufffer pages.
  - GDS buffer pages (as required).
- The application picks a 32-bit offset in the doorbell page for this
  queue.
- The application uses the usermode_queue_create IOCTL introduced in
  this patch, by passing the GPU addresses of these objects (read ptr,
  write ptr, queue base address, shadow, gds) with doorbell object and
  32-bit doorbell offset in the doorbell page.
- The kernel creates the queue and maps it in the HW.
- The application can start submitting the data in the queue as soon as
  the kernel IOCTL returns.
- After filling the workload data in the queue, the app must write the
  number of dwords added in the queue into the doorbell offset, and the
  GPU will start fetching the data.

libDRM changes for this series and a sample DRM test program can be found
in the MESA merge request here:
https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/287

Alex Deucher (1):
  drm/amdgpu: UAPI for user queue management

Shashank Sharma (11):
  drm/amdgpu: add usermode queue base code
  drm/amdgpu: add new IOCTL for usermode queue
  drm/amdgpu: add helpers to create userqueue object
  drm/amdgpu: create GFX-gen11 usermode queue
  drm/amdgpu: create context space for usermode queue
  drm/amdgpu: map usermode queue into MES
  drm/amdgpu: map wptr BO into GART
  drm/amdgpu: generate doorbell index for userqueue
  drm/amdgpu: cleanup leftover queues
  drm/amdgpu: introduce userqueue eviction fence
  drm/amdgpu: [REVERTME] block usermode queue IOCTL

 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 377 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 269 +++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  94 +++++
 include/uapi/drm/amdgpu_drm.h                 | 110 +++++
 8 files changed, 863 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
 create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h

-- 
2.42.0

