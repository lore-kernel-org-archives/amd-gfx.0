Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D60EE8019
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 16:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCFB310E08B;
	Fri,  8 Sep 2023 16:05:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24BA810E08B
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 16:05:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLjOr4XWphzZbzaHkvdMzFfzHYtwQor/dTIirWCdXl2yeoOoxd4oPCIMaRv3BtyM/iKIx40abxF97Ab9SKKxIH6x31I6LcGvTluuKtNuFs3l6ciWaERCkSRui6jy41dHNGWJ62Pczz2IWPfnFsglhOQ5gf4doUjYjaifkAN74NU4zusfWnyek3Nnz/iBKIANge0iKz/wRFLue0JEs4UEmRpUu6yulrOaCXskA+yQ/dlS1nIh6qtOsgwPujK0mCY0ZYFgeC7HV4I0J5gPM0YG6iSNha33ND90A1K/691ZFFvrdCAnqtnU/S/Fr5Bedid288yKD86L3mEYLao2GVdTGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJPLo697TqOL7VBt9P0BJT73kW4jB7TEu6yu9dFr9vE=;
 b=I/lCLUb8BWj/PdCP9wSN7PwKX/IDEHrYgqfweJt2Xx1g6NJCEDg5aBIiRrfvVI+AHSfaZ2WgQmqd0kPUmHfkqkLeD1gOFN/hEOfvAt/ykbn+HCYnK8a/oDl6DyYgzAj7+GxoCokjXFXhM7xXQ0duP5xgxVJk3dp/aX/qGP4hIT9By8OBOeTUGg5nR5vdGUMTvL/WB5+CNaZMkA4q4mMMwU3FDTigwd3jVChEotWKamH7SnDTo31R39kZwVrapHVMx1f3z7LPIcS2WZn7UbQ4LfRcy3zTOa31e6fQ2+SnqHIsm6Nq+rV2p7coAgbhI9wITofyes7tLa6SYIcAwDZkkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJPLo697TqOL7VBt9P0BJT73kW4jB7TEu6yu9dFr9vE=;
 b=iLh0fwSdVqBeOP8j8vK66jVgdr8bnPzE28+xDZX0J2DGioxbM2fjf2keXjiZUpJgQs+l+Z7glfTpY8IB4axhCJi/z/aiXZkE8qjg4c1TqYT4WNkXX9bS3503UCAGaUlLxIFZy2x1rV6c5UVssdaui0UfIpjqiP3T/y8QHmHfrho=
Received: from SA1P222CA0146.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::28)
 by IA1PR12MB8285.namprd12.prod.outlook.com (2603:10b6:208:3f6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 16:05:04 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:3c2:cafe::7d) by SA1P222CA0146.outlook.office365.com
 (2603:10b6:806:3c2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31 via Frontend
 Transport; Fri, 8 Sep 2023 16:05:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Fri, 8 Sep 2023 16:05:03 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 11:05:02 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 0/9] AMDGPU usermode queues
Date: Fri, 8 Sep 2023 18:04:37 +0200
Message-ID: <20230908160446.2188-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|IA1PR12MB8285:EE_
X-MS-Office365-Filtering-Correlation-Id: 75af9011-1a80-4748-58b8-08dbb0855cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rnfc42gBEUHPoVW6I9ZBlTez2HHhaq4qNJcsqberxUtNyYILvtv8mYq1brjCNvfcCkn8zudSkKBbUh67v1ZDthVb1OTJ9m1H/iy5JzZ8WHOvpbZl5YWYaSyD2JFRDQ/Cd4xFYHLz+ibNiGWPaqJwgZ9a+N7olTbatVmLAvE4bIz0LSScpp2ssS9IOSROvtrO/t+NqeeKWMJ+jbLS4bf52L5Gzm4vFVrl91tN40Co/lGt2Pz+h0iUzVxNtA/jzXsqcGjIuoc9Ze5kxDTKFsX9JK3HwSxGFCoY9WHwhTqZkCHzB+bNGLfEnieVHsNSvBNJw5aG8f5uIARpLUucRdoLB4djVEK5O0fjjGwM9hPqsr5UGiBqXLXtps8eL6UrCCah1QhxmukmfduGI8PjNERt3whkp3iaZQpXVrpUGcsqGJv2MuEzL4xbGU6Fnf6ee2kJz7YZUpSRIY1K5Zo/c/64tqzFA9FJzgmofaj0t8uuwZIIsO9qRCm35A5mCeF6Y+IVh7BUm0sof87OKoiq/SeKDHiwsfapJ0f0kSJc0ey8BOs1w7S5ZzBO4CiugYly14ELvhCPYPIWU91lX0lBldW83HFHtN1vI7o9ccj564BPdqsHsa9sfQ1pBZxHJkrnkwb0OIsCD5dikPj53CQUjKUCHLdBxCliiT7w3Chzv+J0HxZ5v7s1CcO/UVB2ilEIx5TmP6r65cxUFXKVFW0iW63OKPeQ2CPC6GBLwLnuxsQmq4IFtlO7bRQ6t7KbGUhplxnCLBrf+QVipH0QC9Jf4PxGFoKecmsKI0gMgVlvlTU0S9g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199024)(186009)(82310400011)(1800799009)(40470700004)(36840700001)(46966006)(40460700003)(966005)(478600001)(6666004)(7696005)(70586007)(70206006)(36860700001)(47076005)(82740400003)(81166007)(356005)(2906002)(41300700001)(40480700001)(83380400001)(336012)(1076003)(26005)(426003)(6916009)(2616005)(86362001)(36756003)(16526019)(44832011)(54906003)(8936002)(4326008)(5660300002)(316002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 16:05:03.6048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75af9011-1a80-4748-58b8-08dbb0855cc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8285
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
  - GDS buffer pages (if required).
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

This patch series depends on the doorbell-manager changes, which were published
here (targeted merged in V6.6):
https://patchwork.freedesktop.org/series/115802

Alex Deucher (1):
  drm/amdgpu: UAPI for user queue management

Shashank Sharma (8):
  drm/amdgpu: add usermode queue base code
  drm/amdgpu: add new IOCTL for usermode queue
  drm/amdgpu: create GFX-gen11 usermode queue
  drm/amdgpu: create context space for usermode queue
  drm/amdgpu: map usermode queue into MES
  drm/amdgpu: map wptr BO into GART
  drm/amdgpu: generate doorbell index for userqueue
  drm/amdgpu: cleanup leftover queues

 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 227 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 292 ++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  74 +++++
 include/uapi/drm/amdgpu_drm.h                 | 110 +++++++
 8 files changed, 715 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
 create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h

-- 
2.42.0

