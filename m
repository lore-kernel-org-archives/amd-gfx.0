Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E92C04FFE
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 16:32:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C19910EB77;
	Thu,  2 May 2024 16:32:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GEA0KBiu";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 086C910E577
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 16:32:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H08oCO7oBv3jvGLvWJ/uU5dtfleQWgEiVTuuKH+6Y9yeh3JdiD7ooI5hOIS/kqiEcqVJZJoNNsQHd+Z1bZDIaLhQT33iWC0b0HvkuysjQlZfvXdkrivLiIsnL9qFyxKpFlbHoSvxM1BJl69NZ/CFZcIqm8rrCt97dLqUibAU4vJFP2HhrtY4gtCILQDeF3YDC3EAWfIaHjX7mcRpF+v6sZUQXrcmQ58+7TdCLFqF7GGTVPFQCG40cx5O0nOf5ZMhWvz2xcBHqDQOxyHn7L88ilQcYOgPUjWWVt0JvrEkzg3M22HyoWnRG1ghzNLlgHyU2UbQlD5JoaB3AIwJcMH2Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/EWXsenVeVIJPsCX/frytLisTs5IgyXXQ75uNJM3fU=;
 b=QUQBBSnIWDktJFS4ufF5J6yGwUeBpiHirLw4l6e8sEp/WpO+CqozN8g/k9LXxOMq+YSMGOEI6AUJKwpL6e4L77XCvD7zQi8AvE3jm5GR6iDScj0QIKzioHDf3LbfjUh+ArqVYLwG0hupDC6BV16XzQTCqfcp28nLx3NcjrpUmnsWhSt+15OV6FHNLf5LOfRaphEMCvbGydNv8XXW+C7H5tSUFBZsqaRObxYfIzLFve+Zec7kZLMhO+dgvjVpfN7gU48Awo1V0PobyHNfl64BIY4WZx/52aU3/kGv/0SQ4LV2LIXpGYUxo4+KOvs4TX37XAtHhdtmhnCfqFUq/mAbfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/EWXsenVeVIJPsCX/frytLisTs5IgyXXQ75uNJM3fU=;
 b=GEA0KBiux0Uxyr1Fo4goSJvuAghDIxj0EbL+pnFtubCBILOxWKy/BICHxwSLx+cSiFZoL65xsjIHZgokkJN6kheacdvdZxCgxvhsALTOq2csGqEzAH8TxSJsXJdZrWMLyKwYlav29rZYpFjDEA5xeLM5x3oM1gbedJT8m9B5Nmc=
Received: from CH0PR07CA0030.namprd07.prod.outlook.com (2603:10b6:610:32::35)
 by MN6PR12MB8566.namprd12.prod.outlook.com (2603:10b6:208:47c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Thu, 2 May
 2024 16:32:28 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:610:32:cafe::65) by CH0PR07CA0030.outlook.office365.com
 (2603:10b6:610:32::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Thu, 2 May 2024 16:32:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 16:32:22 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 11:32:20 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>
Subject: [PATCH v10 00/14] AMDGPU usermode queues
Date: Thu, 2 May 2024 18:31:37 +0200
Message-ID: <20240502163152.1382-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|MN6PR12MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 073e5983-3f6c-4813-f546-08dc6ac5718d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WG43eG1oL0hlTFVnUnpnTTZOZlpiVmJzRThlbkFFRnEzYWpySGhKekVhdXpY?=
 =?utf-8?B?RVIvNUJlNTJnSGJVZWhDV1lwaTFLMkpad3FpZ0ptMlNtc1JXcmhQaExRZHU3?=
 =?utf-8?B?eUVHZzJLQkJBa04wVWN5K2tNS3l5cFM5dlZIeWF4alE2S0dkUEpoWmhZWU9n?=
 =?utf-8?B?bmFUa0Rneis0V3B5czg4cTBvRmYxSkQxdU91T3l3QXlBUUFqQml3bmViUlNX?=
 =?utf-8?B?TnVuZklrR015MTFWNGdBVVBUZW5lc0RGNEFncWNWajFqc2F6Y3k2QkRvcUo1?=
 =?utf-8?B?ekx0T0dNYkVZcFA4MFpZbkFrWXNMVjc3T3IwaUxkRWFRaHIxSmMyT1ZZQzBa?=
 =?utf-8?B?VllGYzNsVkJ2NTc2ZVhpemtQcHV1L3FXMm54VnpRZ05EUDdJUjRiYjhRbkl3?=
 =?utf-8?B?OWl6VDVQTk1OblZKMHd6ZDN6ODE0clJVNnpWWDFDQVcyaDdYbHZlS2JCUGdQ?=
 =?utf-8?B?Y0xMbEVsSE1QQXF6c1h6RkRudWJtay9yV0dFa1FneUEwSFB3cGdqTXplRzRy?=
 =?utf-8?B?M2JQc0U1NEVJMmhCd2Z0ZW5sZEwrWmJERVBxLzE0Zk5yZ2VsOCtycmpoRUJR?=
 =?utf-8?B?ejJES0V6eGdUdHlBalBPK3ZaSlllUEhua25hNUE3eE9zM3dCZGQ5RDVuRDlP?=
 =?utf-8?B?NEloR0l2N3hHcTlvdWM5UVlXeFN0K2xVTmt0YVJLK1N3Q2dnWHJxRW4vZFNx?=
 =?utf-8?B?cmMvUHczVFpxbXcwVDlIWlN3TGdQVk5MK0Y2OVM5dDkzQVFjSWI5S1Qwcmxr?=
 =?utf-8?B?eEkrdHJPMWNweVNXZ3VkS2ZBMkx2MzVpVmdsVFcrQi9lekl4elZwQ3c2b0R5?=
 =?utf-8?B?Z2RLK3hQS1d3SkRadmtFUDdtZkQ4bzFXWGhyVWlsZWpnQ09Id1EwT1V3aU00?=
 =?utf-8?B?T3NGNGRQTXdhbXQ5OWl0MWxrM0hiRjI5V01oeTdjTWtuWWdIVGhzWmVqU0Jz?=
 =?utf-8?B?VWdWaFBIMW9MQURlak1wSFRocUdmeVVkNlNPZ3N4OEVIdnU2ZHhwa0lDVFBY?=
 =?utf-8?B?OVN5dFB5TWN4aXg0ZjloUDlyd0cyd2dueS94QU5LM1N3RkIrK3RJNyswWHRN?=
 =?utf-8?B?YXpnSHcwbmcyZ0VWY0NrVjlXL3Z2czhaZHV1TXNrTEN6ZHFDZjdUd29WQ2d1?=
 =?utf-8?B?dll5QU1KUzd2N24zeWJsbVA4dTdGR1lDWmltTUo4anRtRk1VRW5iemhjempP?=
 =?utf-8?B?UEFuNTlRSmFueTBnOEpiaEFlMkpKU0FsWVZwTDRQSVM4UVJVbVdWZ29BSDFS?=
 =?utf-8?B?TmtHNmFCTnM2VXFLWUI1WVhKd3Z5c2NkdGFsYWdZSGJYSmFTaXRFL2tKNXhk?=
 =?utf-8?B?c0pzSTVEdnVKTldnYmg1QnVzazFaRVFJSWYwUWxoSnAzT0RMdndtNnM4bEY0?=
 =?utf-8?B?N01hVUFpVm9uRCtWYWg0TDFUbnRwVWRubjY5d1JrT0N6VU5sT0FjTzhoVm5I?=
 =?utf-8?B?SHJlSjNIamltLzJVN0pmZGFmckY2d1AvVUFZUExsZ3cxNm5pdmNBS2pZYWg2?=
 =?utf-8?B?cldHdVZCMmkwbmdEV2dCSFBUOFAvRndVVzRXTk1oQmRISEhkdHEzcnh1TXgz?=
 =?utf-8?B?NzVtTTA0WTJualdnN21lMWRubmVNd09LTG9Kck8rVFRIeXcxekxhZkpqY0dM?=
 =?utf-8?B?d1BjZEVjUnJrWHRoMEN4UlVpSXV2b1dmeVhPV3BvaEh3QlVDcUVwRmhDVnhu?=
 =?utf-8?B?WmloUUZTQ2dHQmwyT1FuZjBHR1E4QUswL1RNKzdySnpIV1JXUFp1SVc2ZWFG?=
 =?utf-8?Q?wfX40Ejc4385o15XDLL8267Y6skgGB52ELLDUPR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 16:32:22.4279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 073e5983-3f6c-4813-f546-08dc6ac5718d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8566
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch series introduces AMDGPU usermode queues for gfx workloads.
Usermode queues is a method of GPU workload submission into the graphics
hardware without any interaction with kernel/DRM schedulers. In this
method, a userspace graphics application can create its own workqueue and
submit it directly in the GPU HW.

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
- The application maps the GPU buffers in process address space.
- The application can start submitting the data in the queue as soon as
  the kernel IOCTL returns.
- After filling the workload data in the queue, the app must write the
  number of dwords added in the queue into the doorbell offset and the
  WPTR buffer, and the GPU will start fetching the data.
- This series adds usermode queue support for all three MES based IPs
  (GFX, SDMA and Compute).

libDRM changes for this series and a sample DRM test program can be
found here:
https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/287

MESA changes consuming this series can be seen in the MR here:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29010

Alex Deucher (1):
  drm/amdgpu: UAPI for user queue management

Shashank Sharma (13):
  drm/amdgpu: add usermode queue base code
  drm/amdgpu: add new IOCTL for usermode queue
  drm/amdgpu: add helpers to create userqueue object
  drm/amdgpu: create MES-V11 usermode queue for GFX
  drm/amdgpu: create context space for usermode queue
  drm/amdgpu: map usermode queue into MES
  drm/amdgpu: map wptr BO into GART
  drm/amdgpu: generate doorbell index for userqueue
  drm/amdgpu: cleanup leftover queues
  drm/amdgpu: enable GFX-V11 userqueue support
  drm/amdgpu: enable SDMA-V6 usermode queues
  drm/amdgpu: enable compute/gfx usermode queue
  drm/amdgpu: add kernel config for gfx-userqueue

 drivers/gpu/drm/amd/amdgpu/Kconfig            |   8 +
 drivers/gpu/drm/amd/amdgpu/Makefile           |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 296 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |   9 +
 .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 338 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.h  |  30 ++
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |   5 +
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  79 ++++
 include/uapi/drm/amdgpu_drm.h                 | 122 +++++++
 12 files changed, 903 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.h
 create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h

-- 
2.43.2

