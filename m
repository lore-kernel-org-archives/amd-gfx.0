Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4208BC74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 16:05:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7CDA10EB61;
	Wed, 29 Mar 2023 16:05:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA2D610EB7A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 16:05:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqP1NVjCc3EAsIQNPg0wugYEa/MAhKbCI7nFqi/rJnB3j4wAi8ahWxz6Q0nYynkR8lGv0xl/cpv7yJzY0baSDZoP/Qg3XpWyaeTVgRuBsYpTW3DmLD4oNOWgQDQdGOixDgB1hn+yNl2EaxtvKok12cEkCythUas4Jzc/4LzRes27gmlIShWroFSdUc5WPFl5PYb7H+Y6nzlQscgqHeGincKQcclEAIf8txGcTWpW6NZo/2zir66F9cKnSsfDn7zyZ2stLeB541uG0dv0Xzl9gFh+4USxW2C39eC6n1FIv+Ma7qgg2kDIi+e2t6rPPkBCNRmm/jDD4fpXsUJMTxe4Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xN0Rgpl9bdLCiNJ03GaHY8IdXi+nIoQi13SFeqPCztI=;
 b=HC8pQig9RgWX5uOjQpKjIAUAJhIXUh+w6EM72ZkgbonDd+TGkjTXhHJmkNSA7Jc0U5/drf8q2RssgVU0B68wtGA8JW71C1OU8/KmM9SdTpDBDd1E3BtGeeH+vdGVtW3o9ReGlCSL7x5LcgIlfMlAwAgNVW1rOgRT+/4raAcdCtb4JPn0wP4oJ3BnGLuyKCwejJkHIFe5yiP7+kXMKLjEnOcNuZiXPsyJOzivAhac4mJYkkszPzNlWSghDC6spDKMLscHVv+tx06oNTKGGBmjRMHW+0IL0Ji5TMq5yb8Kl8afkfpJi1tdoERS9TT+e7dWgAL4XoTbqaOvVbCG410k+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN0Rgpl9bdLCiNJ03GaHY8IdXi+nIoQi13SFeqPCztI=;
 b=Y+y6MG7Ny8cq+86KLSQ8P2Hmnak27oRr1zfNu0TX3xUuJKcmcCHRTdUvnz6cd5MuybGgRkTAw18FlY1ntg1yYcAuIYDF4pkHcs9hy+8xe7wC69Dt7KfWKmGOc8BLmqj17tGX71tvLREhPmUm9DGCbTLD0YHI868r+3ILjyXKDRk=
Received: from BN9PR03CA0540.namprd03.prod.outlook.com (2603:10b6:408:131::35)
 by SN7PR12MB6958.namprd12.prod.outlook.com (2603:10b6:806:262::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 16:05:06 +0000
Received: from BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::ad) by BN9PR03CA0540.outlook.office365.com
 (2603:10b6:408:131::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 16:05:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT102.mail.protection.outlook.com (10.13.177.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.21 via Frontend Transport; Wed, 29 Mar 2023 16:05:06 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 11:05:05 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 0/9] AMDGPU Usermode queues
Date: Wed, 29 Mar 2023 18:04:36 +0200
Message-ID: <20230329160445.1300-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT102:EE_|SN7PR12MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 658efaf0-71ba-45a4-7715-08db306f5d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z6Z+mKLIl3HtlI+j3nN2xjl7xhi8IMc+3cou4SDQJe3U0IX3tvfciWjbrMxDwnopRSQl676ZiDG8mdALCxAPR+t2twriUCw2QACqBa+K6wMNOL5TiwSTphzHMnQdl8WhNE/2nKHky4FPx4j8YNZx9ZmBT6mwCeHeZhmI6av0En9c0SKsRBtOGgWUsBQ4ukL7CI5NuVYBJbeOCQDx6oN/qGP5yZZ4wngl7oIcm0Q4VHq1IUvqFKjybyTLIWE8pI6QPS7Mb35pzcLKkPMv1upUR31VoqPqCgNhwl+7CpA1A39OlbnNloa6TOqb0MxsuBHyUq/Ihzcayi3Vx06+6lnzlqR08k98cbL5ypqlSyQI5/NMypcEbdTicu0tLYtdrpaayKPwSD+7KWeZU9ZRRF40glykyoMevRlclzufMeofaWr+7PeE5myGHVAorHYWF/kvUBiV5xPx+7ua0kDfza8uyWVHr7cPhvaf4jm1Clz0MaIN67EapBbCglTmL//OsiL+Yrj8llP602Wk9DeRHpoZiBlQ81yM2WwNNZj1ehtkQ/WKUZsXmPOW72cvVvpuMHoaj5Lht5/ib16djjd7Re6AQ46dnVO3oksFDuTM/2K09rvqIxy3MKcDxAKw4xG8fjlDAdWRF2jARLKKaNv+Ui7kOSWIMoYAToRhna75uzPAyneM8hW4gJj4t0yrEKvmDvXg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(7696005)(70586007)(6666004)(26005)(1076003)(966005)(6916009)(316002)(54906003)(478600001)(16526019)(36860700001)(47076005)(336012)(8676002)(70206006)(426003)(186003)(83380400001)(2616005)(81166007)(41300700001)(356005)(8936002)(2906002)(4326008)(5660300002)(44832011)(40460700003)(82740400003)(40480700001)(86362001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 16:05:06.6360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 658efaf0-71ba-45a4-7715-08db306f5d3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6958
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
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
- The application picks a 32-bit offset in the doorbell page for this queue.
- The application uses the usermode_queue_create IOCTL introduced in
  this patch, by passing the the GPU addresses of these objects (read
  ptr, write ptr, queue base address and 32-bit doorbell offset from
  the doorbell page)
- The kernel creates the queue and maps it in the HW.
- The application can start submitting the data in the queue as soon as
  the kernel IOCTL returns.
- After filling the workload data in the queue, the app must write the
  number of dwords added in the queue into the doorbell offset, and the
  GPU will start fetching the data.

libDRM changes for this series and a sample DRM test program can be found
in the MESA merge request here:
https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/287

This patch series depends on the doorbell-manager changes, which are being
reviewed here:
https://patchwork.freedesktop.org/series/115802/

Alex Deucher (1):
  drm/amdgpu: UAPI for user queue management

Arvind Yadav (2):
  drm/amdgpu: add new parameters in v11_struct
  drm/amdgpu: map wptr BO into GART

Shashank Sharma (6):
  drm/amdgpu: add usermode queue base code
  drm/amdgpu: add new IOCTL for usermode queue
  drm/amdgpu: create GFX-gen11 MQD for userqueue
  drm/amdgpu: create context space for usermode queue
  drm/amdgpu: map usermode queue into MES
  drm/amdgpu: generate doorbell index for userqueue

 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 298 ++++++++++++++++++
 .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c | 230 ++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  66 ++++
 drivers/gpu/drm/amd/include/v11_structs.h     |  16 +-
 include/uapi/drm/amdgpu_drm.h                 |  55 ++++
 9 files changed, 677 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
 create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h

-- 
2.40.0

