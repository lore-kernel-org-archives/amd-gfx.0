Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA93ECE588
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 20:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F278010E67B;
	Mon,  9 Sep 2024 20:06:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MVc/nZme";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F2F410E67B
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 20:06:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJAGI3Md9XZQc48TgmamtL2EgCCiVNtVdJ4sj8ja7AT/XUm45LfXyDcbKpWIfCLr1mWoCqjwzFCnuwBi1HEuGpInFG1E6uf8IMWjGvscYZJw7LT2QEnWG1FzvDi8UjjjvrCgxSkNMB/wHxjCeHlnAgCnR7tFdQlBgV1bOaQXUeYcNmbZEwWjPlbfX/55z4jHsz6/tvfUwrm12bqEJBNImyeMkTHzBSyWl2iMbXjNpmtobSuiXit92W6FG6+L3L5H/mnzUeD5eDvuSs+mUPZjUttk/Faa9XwDXy2vUNR09dZdbdHJ9q4j5iitnga5W4Qfipe1JSqqo17GvGml22i1jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cx/7dBE7a5SZU8WCdZqPD/0991kQTdvr6a16yJaz/bE=;
 b=JRhKPyuiR3fMR6CRQftLIVrQMG6jI2sIlyXb6vke3RZcJNCEJJaV7gQt4qKIwS0DsnM8MQZFqfTchSFu2EjNfrY+UEuCBHtXdJSetJyX0KAoDIzLpWb76WN4UOTdT59YPPYJWzBux/65ss3YIuhJX/pJJIifwXM027PYPs/5thUF1oav8jebM2O2cTvOYR1WXfUHzBN31ktynfeeU6zERAL2eUYhO/p+SyM2z59f75Jg7wEmEn70BlCLB+F/0i6UpcO6D+VE0TPswVaRM5UQqHFcOzreVVR3XiPsfxU5RDuMys4SNRnx4iAy3Tqx7fTEEsEvlzkKCqi9vJY/94qZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cx/7dBE7a5SZU8WCdZqPD/0991kQTdvr6a16yJaz/bE=;
 b=MVc/nZmeQ7KNUqNIpx0f6i8QyACNzSU79/4Z8K7FCF95HgKsOKhXjeqLNBGkaJjO4UHnIfIdpmUFOSLf9Ny7o+9phqMbolhVi61kzg5+yzGz1kH8foAM+T2rAKSTkXPKrGk8MWPwVSkWOgumtghr6xN3Zh80OBEgAY0OnH3/jB0=
Received: from SA0PR11CA0124.namprd11.prod.outlook.com (2603:10b6:806:131::9)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Mon, 9 Sep
 2024 20:06:55 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::e1) by SA0PR11CA0124.outlook.office365.com
 (2603:10b6:806:131::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 9 Sep 2024 20:06:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 20:06:54 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:06:53 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>
Subject: [PATCH v11 00/28] AMDGPU usermode queues
Date: Mon, 9 Sep 2024 22:05:51 +0200
Message-ID: <20240909200614.481-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|SJ2PR12MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bbe7661-be1f-4f72-cc0a-08dcd10af3d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUNRQnBFOVRSWG9LU3Y0VUR0cXJhNlZlRDNCbGhYYkc0LzAxU0YwM3Y3d2tC?=
 =?utf-8?B?ZjFkUmtGWVFrTVBaUnlLRHV6bGVqbkUrbDNnQ3ppOW0wZGJVd0psQ29odFRh?=
 =?utf-8?B?RVRVK1ptdHk2THNpUmhCYWhpT0tmOE84S3NBRDJWRnBCS1QrK2x1SE9odDVo?=
 =?utf-8?B?UitCTG5EQzMxek5uMlJETXV3MWwzem1OalYwc2FLelMzczRwRW4yeUJDc2la?=
 =?utf-8?B?YjBMeit3UmF2QkhQc0Q5Y3k1SkRJUlN5RTVKS1cyVFZLYXNLckl5ZERHV21N?=
 =?utf-8?B?SVdiY3lXczgzVUg4M2xQT1JXOVhKZjZ4NDJqekF4c1hhK05aT1d5azlBVmUx?=
 =?utf-8?B?YTZEWVpzTkRwUUxNQVh6QXhra01FQ01JQk1lWEhIWXNGRnBHOHMrcDI4eXdG?=
 =?utf-8?B?UmErL0R6Vm5tM05jTGVxVVpLWVJFY21JWjlMcnFmMFBaSFpVWDFnNitnRytl?=
 =?utf-8?B?d3Q4SzAwRGJhV3Z3SHdBMkMzUXhPRGtsNi9RNkYzUWZ3dUhTckRBTzFlTTRa?=
 =?utf-8?B?M2lXMTV0cmxUandyaTRiZVh2UnRKeVk3MmVLd00zTHJHMDE4ZTJKV2wzSUxL?=
 =?utf-8?B?UkdsUktCU3NhKzdiTzlJR2xxOTlaQmpuc1h0NU02cHJsR3ZUWlU4LytQRnBY?=
 =?utf-8?B?Rk5oR3hrNHJHSnlPcncyd3VmRmJjNlBkWXVpSnFINTVDd1FRUjF5Q3M0VEVi?=
 =?utf-8?B?OENjRWEzbG5zMDNrUzdvWkg2K2RlblVkbGxid2l2aWhQYVc1RXByeDErcHRq?=
 =?utf-8?B?YUdIYXBidThIZ0d5NHZxRXM2aHJDOHFqbGdoY0ZMMUdidnJCZW1oMGd6eExv?=
 =?utf-8?B?UGdVL1lhdEM1dE5CSUJZdU5IOXVOaEVPQThCMmF3bk9XMk9hNjBLU2hacDBS?=
 =?utf-8?B?RzhBdHFRT21UNU8yTksxaGJOUmJtVFNFa25rU1g2QTh5V204SnVjTWkxZ0h0?=
 =?utf-8?B?U1pOZ2VwaVFBNDh5YzdkVzNBS1ByeGZmcXRYKzEwaWs4Ky9GdkZhc3M0d21D?=
 =?utf-8?B?VVNWSG1DQVRrTFVkbGRYZXJ4N3VGNUNLYWNPcUsrQlhqY2Z0MGRxdFJhSTR4?=
 =?utf-8?B?d2w2SlFxL1FSTFpnSUhYcE03TVFuQkdrb0NWc2hKQTBJMnNyNWU1alNIQTFW?=
 =?utf-8?B?cDh1aDZUbEczdXNFVFREaHpsTG52UUJmcVV2VjJWaHFQbGdvTzBJdXN1RnhM?=
 =?utf-8?B?Nk9MSUxrZXkxR2tIRVcxczZlNTdNY0ZQUjZOcE16T2VwdFVQZVBvbHZORnhl?=
 =?utf-8?B?ZFhzRjYwdEdWNU8zcnE2enhMOUZVSXNJdmM1RFFKQzh3enBFK0xoVVZUWTFo?=
 =?utf-8?B?ZXZ4c3ozTlFOOWZUYXJjcFRlaE8vU20zYmt4Z0tuNWgreERaVHZqb1VSOTJ6?=
 =?utf-8?B?aHlBcjJSUm81V2lobktxSFhKUDBJN1kwNEVwd1JtV0k3ZWU0bWFnYVZwak5T?=
 =?utf-8?B?WE1JT0VuV09DK2thcElEQzJ2NFh4WXhGeGc4eldTeHZBWkxlVjhpaXA5ZmJC?=
 =?utf-8?B?RC9KbUthblo1SlptYVd0aW5YV05VOVE4NVpabENpNURNR1l1NitHL0E2NlBJ?=
 =?utf-8?B?dmRzdGkwYjlLQUhxYUxaUnZ0TlJrcnRiazBRV2h4UXVjc2ZFRlFJMkEvK0Vj?=
 =?utf-8?B?VElDNFJiRzk4VkxsemhsbmQrTmVzQU41L3Z4dWlyNHJ5Q1ZXM1ZqMHMwcEo4?=
 =?utf-8?B?L0tOK1pBNGo0QjY0TTlyTnc1SUZMSWhEaWR5aXJUbHBLcjBCZHUwOHcwZDB3?=
 =?utf-8?B?OWo2eFI2U2dvYW85akNIRXo4WGl0SWN3MjNnYUdwdnJhYXFDNHVFNStjTUQ3?=
 =?utf-8?B?S25kcGloT0J5eEtNY0t1SWZ5L055UkxUZ1BsQ0xDbW1pQmNjNXNCUzZXVm5Q?=
 =?utf-8?B?Nm5BYWZVL3FGOUFJaDNCbGUwV2VzYWNNNWpkV0wrUGYvM2c9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:06:54.9648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbe7661-be1f-4f72-cc0a-08dcd10af3d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689
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

This patch series introduces base code of AMDGPU usermode queues for gfx
workloads. Usermode queues is a method of GPU workload submission into the
graphics hardware without any interaction with kernel/DRM schedulers. In
this method, a userspace graphics application can create its own workqueue
and submit it directly in the GPU HW.

The general idea of how Userqueues are supposed to work:
- The application creates the following GPU objetcs:
  - A queue object to hold the workload packets.
  - A read pointer object.
  - A write pointer object.
  - A doorbell page.
  - Other supporting buffer objects as per target IP engine (shadow, GDS
    etc, information available with AMDGPU_INFO_IOCTL)
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
  WPTR buffer. The GPU will start fetching the data as soon as its done.
- This series adds usermode queue support for all three MES based IPs
  (GFX, SDMA and Compute).
- This series also adds eviction fences to handle migration of the
  userqueue mapped buffers by TTM.
- For synchronization of userqueues, we have added a secure semaphores
  IOCTL which is getting reviewed separately here:
  https://patchwork.freedesktop.org/patch/611971/

libDRM UAPI changes for this series can be found here:
(This also contains an example test utility which demonstrates
the usage of userqueue UAPI)
https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/287

MESA changes consuming this series can be seen in the MR here:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29010

Alex Deucher (1):
  drm/amdgpu: UAPI for user queue management

Arvind Yadav (4):
  drm/amdgpu: enable SDMA usermode queues
  drm/amdgpu: Add input fence to sync bo unmap
  drm/amdgpu: fix MES GFX mask
  Revert "drm/amdgpu: don't allow userspace to create a doorbell BO"

Shashank Sharma (18):
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
  drm/amdgpu: enable compute/gfx usermode queue
  drm/amdgpu: update userqueue BOs and PDs
  drm/amdgpu: add kernel config for gfx-userqueue
  drm/amdgpu: add gfx eviction fence helpers
  drm/amdgpu: add userqueue suspend/resume functions
  drm/amdgpu: suspend gfx userqueues
  drm/amdgpu: resume gfx userqueues
  Revert "drm/amdgpu/gfx11: only enable CP GFX shadowing on SR-IOV"

 drivers/gpu/drm/amd/amdgpu/Kconfig            |   8 +
 drivers/gpu/drm/amd/amdgpu/Makefile           |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  10 +
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 297 ++++++++
 .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |  67 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  68 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  11 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |   3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |   2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 713 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  74 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 644 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  42 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  16 +-
 .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 395 ++++++++++
 .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.h  |  30 +
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |   5 +
 .../gpu/drm/amd/include/amdgpu_userqueue.h    | 100 +++
 drivers/gpu/drm/amd/include/v11_structs.h     |   4 +-
 include/uapi/drm/amdgpu_drm.h                 | 252 +++++++
 22 files changed, 2722 insertions(+), 45 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.h
 create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h

-- 
2.45.1

