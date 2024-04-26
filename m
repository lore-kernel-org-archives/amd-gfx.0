Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC9AC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 13:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3D3A1123FC;
	Fri, 26 Apr 2024 13:48:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w2ACwvdL";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C42A112405
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 13:48:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMZatjjGJ9YlQPFOfKh722Jrw6g1hfNyYGe+AwPEBx6fVSoQ9E2D1ETFsehgT40W7mmCRA345cuPVjsNpNhtIZXdykorTyvJK9wu2Hjk37XyBHQaGQUIC3JqyyU0qC1qg9iPPllxquESnID8LPtlE+4Hd3fTbMNoJ+mx7xSE6sO0qqAwI7ZjN66ZD+4DCVP18SyrWpD9UWrZxJv3rYrbDBVcK9b7yYU6o9fh3Zjiy+Wyh/7GFpRiB2abKlQp51wklcmQVQEa003sfJ3wtIGRJWrWU6AWUUrFNfPZgayV8iaUu/PnK0Tg5xvdEl2kS3dp1lkLCNR+Vy4RyqZ7bJr7rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwc4ybsq9wWdHfhxx/rB7pqeJyRnlFogy+fAzX2yAlU=;
 b=AAJJ2Ms8k0g7hHn+M9FIZs/DoXELpeJv/d/R8jchivIud8ZUC11AtjsbY2C+xNcXeD5FwvDBDU53NPZEp6oryKn7+JD7ar2/Rz30aV1FMP2vn4nlY8ONLgsMQl//CW8Wsva2BrOoIak+kVmakCxDAFYrcsHTpKvidrO0Sw7e9fjtOZ0lkGV7giE9mKCKzk8G7Umpwsplonw78P6BIEtJfYgUFSSxqlp2YQx4e4lSBYQsQkO6s6pUvQSh5IMC3pHhsTpodUcHRQxSy9JNxg7GQRlS9Tal+c4eleb0TJgQbKVmVIA+RuvPcfc85WUYecKVhHBKxoRPGhbjYqoTfmkFuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwc4ybsq9wWdHfhxx/rB7pqeJyRnlFogy+fAzX2yAlU=;
 b=w2ACwvdL6WMJOFqLE0o1K5lJCcKC93e/refDW01YUBytI2UrsazbbO5x0M/e0NOrU1RhP4zSP0vrxiTOR8shzytItHaRJOxU+DuEO4UUbMeLbG3Az427QViTxc5D4YrtAtPexwVQzjJ0h7JMBSqEv12v2hDcpcAjtW1NHbXA+7E=
Received: from CH2PR20CA0024.namprd20.prod.outlook.com (2603:10b6:610:58::34)
 by SJ2PR12MB9005.namprd12.prod.outlook.com (2603:10b6:a03:53d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.48; Fri, 26 Apr
 2024 13:48:38 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::79) by CH2PR20CA0024.outlook.office365.com
 (2603:10b6:610:58::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Fri, 26 Apr 2024 13:48:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 26 Apr 2024 13:48:37 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 08:48:36 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>
Subject: [PATCH v9 00/14] AMDGPU usermode queues
Date: Fri, 26 Apr 2024 15:47:56 +0200
Message-ID: <20240426134810.1250-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|SJ2PR12MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e19f27-60be-4330-636b-08dc65f792e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVJUM1huVUh5NkwxdFhaVldtOU5JZHZsV2pqdzZUZmdXcmh3cVM1REZkV0NL?=
 =?utf-8?B?R1lrbUdUY2hqOFptejNQTDFES1pHZ0t1ZzB2UXVseWtxeUQwNzQ0Tzc2cXBp?=
 =?utf-8?B?SXBtaEVsc25oMkNnbEwwZUo3UFV5WlZacmZlZkpucVNXSmhCYktlZzBHankw?=
 =?utf-8?B?SG1iMFpDcjUvZmdUVUdSUmZHcFFnd3ZWV1gxM3d0aWtzVVJweTJ0b21PU2lO?=
 =?utf-8?B?K2srOFVOK3ZITXZVSEs0dnJqZGJnNUNuT2hZdnk2RGxULzdxVVpDVkF2UG85?=
 =?utf-8?B?dFVOZU5ibGx2UnFsaFZYR1pmVVdwd1BiMXFiTmxJMW5wc1V4TGJyS0xwTzFV?=
 =?utf-8?B?cHFzR2VLSHAveVBGeTNoZ25HL2xNQURxcEN6VE9TMldZU09aYWJJVExtVlpV?=
 =?utf-8?B?RzlmK09IRjFwMjNFL2x5SDhkZFFDU0s3NGpCQzBCVE9YNUFubW1SaTVwWThl?=
 =?utf-8?B?enhVc1ZqKytLNHp1cElIeUliaHhPdW05MzhMVTdlTkdlYUdXUmFseEE2UkxD?=
 =?utf-8?B?WTJFNGFtK3dBRnBOSStucGt3Vld6dHA1WWJETFBOT3QrSmNLUUV4clpaMWZT?=
 =?utf-8?B?NTJOUzRVN3BuYkM3R0FHbFp0VENXek91UDZyZmpCOVZNREh5aitXOXFHRGQ0?=
 =?utf-8?B?eCtPWFVSb2I2eGNUYk1wZXJnL3FETWpTYjhzNEdGREMwdlpsdEUxYThja2hq?=
 =?utf-8?B?MXF2TkhMM0svWWsySFNWL0JGN0ZveGZUOGFpdlpLS0VnSWxCcTYvQ2tZK1I0?=
 =?utf-8?B?dkppamNHT3BzdVM3NHV3TFhUU1dGcGlhR1BrUkg5ak1RakJVRDMxaExmbnZF?=
 =?utf-8?B?azJQQUIwV3ppVUNoYkRRZXdmYXlIWmRySFYrR1Y5TmhRUC84MWZYM3Z5ZGpI?=
 =?utf-8?B?L1l5elBkaDN4ZUFsUGxNOHJ4SjIrZE5vWmdaa3NRN01sSWZSVTl6SXNQelEy?=
 =?utf-8?B?dWZSWXA2L24xWi9mZFZxeVVoUWg0TWVEL3hlQVdGYVgvcnM1VVl6ZDJ3Tlg4?=
 =?utf-8?B?YnUwelI3VnZKUFJJeDlERVk4SGJpT3lMNmJZQmJWaEhZYkU0T1FlT0hMYlZy?=
 =?utf-8?B?RFQ1YnZXTFNOS2FnWDhRd29VZ3ZPWlhjbGRJcGU0cjlGelRzaThvVHdnOWdG?=
 =?utf-8?B?dmhqTi85RmpackZzckQ5MkV2QThTbjVXL2YwakV2WGlqNXdQOC9Ja2MxUXBR?=
 =?utf-8?B?SzU1d0pLdXEyNDVHU0VkOStqUEFrcVlwNUl0UlFUZ2dORGpIa1lCU1lQaElH?=
 =?utf-8?B?L1N2dmRnSGxxWVkrcGRZd2l6SGxPdVRwQUY2dktVeW85MHRRN2xYSHJkdUpJ?=
 =?utf-8?B?NWUzZHhFWkFuSlpxRVJoTTVzSFMxZVM4VXUzVExNNHZ4SmVqNkFFYW5FZUgx?=
 =?utf-8?B?VTlLcWg5QURiV0wxWFp4S3ZRUnRSTU5CUmZEWWloS3k1OHFGK20zNkI2czRz?=
 =?utf-8?B?WW05UEdxOEdORHdmOXMxUUxoTzVKVGRKdnZaR0dOZFZOVUpiN05ISzIweWJ6?=
 =?utf-8?B?MFg4SU5DdDBDS2ZBeHRjd1ZYVUpmTzFla3UxM0Z3akc1ZHE1dGFjSkJpajRX?=
 =?utf-8?B?S1pLNmV4aHJ3T2pXQ1IwNzlGeXVLaFRKWjV1QjB6cXVMckVGc0J6dWc4NWYy?=
 =?utf-8?B?VHFtbnFsUHpndDN2R3lSVGtmKzY0Z21LZ2dYZHJxSlMraEUyZHVXMDlIZVpx?=
 =?utf-8?B?L0FGemdaVnNQd1d0dEVLMWsvS1RJS0NqRmFHcDYvRUtzS0JVcm1rSzMvblVh?=
 =?utf-8?Q?9TGM0F4+cHRLqLD6pQwUNp9E+s9+/Bc9rbQIN4Q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 13:48:37.4483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e19f27-60be-4330-636b-08dc65f792e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9005
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

libDRM changes for this series and a sample DRM test program can be found
in the MESA merge request here:
https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/287

Alex Deucher (1):
  drm/amdgpu: UAPI for user queue management

Arvind Yadav (1):
  drm/amdgpu: enable compute/gfx usermode queue

Shashank Sharma (12):
  drm/amdgpu: add usermode queue base code
  drm/amdgpu: add new IOCTL for usermode queue
  drm/amdgpu: add helpers to create userqueue object
  drm/amdgpu: create MES-V11 usermode queue for GFX
  drm/amdgpu: create context space for usermode queue
  drm/amdgpu: map usermode queue into MES
  drm/amdgpu: map wptr BO into GART
  drm/amdgpu: generate doorbell index for userqueue
  drm/amdgpu: cleanup leftover queues
  drm/amdgpu: fix MES GFX mask
  drm/amdgpu: enable SDMA usermode queues
  drm/amdgpu: add kernel config for gfx-userqueue

 drivers/gpu/drm/amd/amdgpu/Kconfig            |   8 +
 drivers/gpu/drm/amd/amdgpu/Makefile           |   7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |   3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 296 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  10 +
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c        |   9 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |   9 +-
 .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 317 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |   6 +
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  79 +++++
 include/uapi/drm/amdgpu_drm.h                 | 111 ++++++
 15 files changed, 859 insertions(+), 8 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
 create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h

-- 
2.43.2

