Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74203D1D467
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1869B10E75C;
	Thu,  8 Jan 2026 14:49:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sJqLRj6O";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012004.outbound.protection.outlook.com
 [40.107.200.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F9B010E759
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kO/5ZElLBQWCqzveDfb94qiGD4EVE8I6scqeNO8EEGzpW4kWSiJHo7OYLQm/VnP+sItqvDo9mYZtiukPpaAOWexS+chUZ00SFGP6F67YTSCJkE1QtpaThnzlbujx5od67mULM4yR6ir199JXWPLW2sFrSMhYyvnXC5/Dc7YwVj4BGC0v+LpiN6sYvxT0Isy9zhL/j6kRKZx7piiiwVLLE/ebio8+f75mmeB+ybpJAboIR3sdI6HVd2LE8ez2nouhBKIZ+yYAieoFRbNWHo/xeS8tB9pVcKFf1chj7FTeZ/SoZIdY/VnmQkFvi/v+gllGzM48QXml7jubEgYbiaW5Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F36CnR1b3whu42d5zZEIeIDhNaflrSbid++6NUlbi5M=;
 b=DwlxAMAreEo0/VU4tB+W77qgaii0r55Mpei5by1KJKMGAYoNit+vCMwU1EG5VrgaG4eeilKj/FJJ8WATMhSGXYZicQvFSNxxWYVzdiuPDRnl8ep7mKU327iuylEOYkwu9B6ZBZ9yzUEIZWl6LkWq1Fy391tsBJVg1GQqvIuUz+/L6+Jhp+3JrhsFeBejepDLJhGcky6VSPjnRGN56uB6keMOm8VAqaaRk0Z0z7l69fEO2QTSDOfz+CM9cR8p44oU3R5Tyb4EbFxXyDLnZQfZT12iQqhSoDhIGRimuFw1IgbGEKKG3rrV2G+bkqHOtKJcJtuM+noZoSfFmrgrVzytpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F36CnR1b3whu42d5zZEIeIDhNaflrSbid++6NUlbi5M=;
 b=sJqLRj6OYtf/tHqJKjXUtj2oxtIeTLRmqSpNHT8fLA/vCNmn6TWrxQrSgfQkARJYC/NQSZOWvp+u5RFnWEyTdmKeJkCSAc2R8+HTjvFi56YyDQdHbU38ZSrHG6Ddf+EPMRtC7plaUWnlnJq4+pm2y4+2uEqgc+IyG7vq+sn7lOE=
Received: from SJ0PR03CA0353.namprd03.prod.outlook.com (2603:10b6:a03:39c::28)
 by SA1PR12MB7039.namprd12.prod.outlook.com (2603:10b6:806:24e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 14:48:52 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::1b) by SJ0PR03CA0353.outlook.office365.com
 (2603:10b6:a03:39c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 14:48:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:48:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 8 Jan
 2026 08:48:50 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Jan
 2026 08:48:50 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:48:50 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 00/42] Improvements for IB handling
Date: Thu, 8 Jan 2026 09:48:01 -0500
Message-ID: <20260108144843.493816-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|SA1PR12MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ee7a6d-9138-412b-fd26-08de4ec509fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Uwj2Wsy741aAMnlu9iIXaEF8KH3rSt8E/LL2/FOKZnAYvRWpijfoO1dtCNnJ?=
 =?us-ascii?Q?Ih+hdlktK3HB8SQo5pfT8XAQJ6iQzuh0GOns+b/WaSUogUb4VlwdzB8rmGmZ?=
 =?us-ascii?Q?lnevEROfH/0dC7FpUDtRytBzRBOm587B3VmS+YvjMHyC2aa/aVsWZBSxyoRp?=
 =?us-ascii?Q?IDn7OKi4S3FUBRfA5WzgqACP+CFymH4v/0XXL52KNjQ2cFMa1GOuyVqF1+J8?=
 =?us-ascii?Q?gLWaIhU066VBmSFKpYcisWNBXlWg6WZ6BE7fjgtpZvJ+CYaSTgN7Zalit1lg?=
 =?us-ascii?Q?yxgi4MfJdnczNEQNlVMYmP5cAR7ucjmKbdgjRw1Mnj5wU9xfM+5BaEowzfcm?=
 =?us-ascii?Q?vdEtMJRKrvmQTG9pveHtxAXnkpIgnjLy575i0qyAImkdwWycYKSm9hWw0zb8?=
 =?us-ascii?Q?M0wyNIgEUsgSZW6VvggjKL0ERb1hrNinf7i1JExvoNZFVYE+PrQgZV/ov8Y2?=
 =?us-ascii?Q?n0jZ6KH1nMUcSMJ1rNIeTXwrJJgtpU8DSksz0oXSoXVqUETM+S62yfy83sHd?=
 =?us-ascii?Q?ZH5bUVGIsL55ufFZzlA82B7hOvdIzlMrqLzY/uQ5I2FOIrKV8M8Z5/4Gr7+h?=
 =?us-ascii?Q?LaclFZQqq8dlwIWpwPdKCRq96sn/oNpwYCr4IlcVpsfTTqifCrvVlUF+wRtn?=
 =?us-ascii?Q?rktc29P94UhhkH7k8+WvyNMK1/tgarxq5lvGUbymFZW440ExPk8F5PPTw7Fw?=
 =?us-ascii?Q?yPpYP2xhdLJI1USYSUSFzTG6JEQ5ShWmaxNg6oHJwxW4y7JcFpTAe5dstIKV?=
 =?us-ascii?Q?aQru+YG0oFIJ58I18sZ3Nt8xgpIRkqa4KGBRSz4rlMseQiHwNQqsZ535LFLr?=
 =?us-ascii?Q?ftwr1em3DqHdWM6OKjIwUf6eN2DXNbRJFCgKNq0oqwodSX0njtK51FiuWBan?=
 =?us-ascii?Q?hmcDh0UUxQbjSOS3uw9/lGsshrau3gPRIotaAKQGoKfB8Gz6K4Y3Y+cVG6JG?=
 =?us-ascii?Q?HpWbH/j4Y0nRp3pQognjs21zZY1771Amm7ZSXcGgMROyyU7D3zT5hilGmbJy?=
 =?us-ascii?Q?QpSb92ESm3DJhDz0tdOu9IVfZ4nmjZ1OUP7laI3iosAJFIzK6ZNcg9JkaytS?=
 =?us-ascii?Q?ihiv/o0JKnV/vVUhpGtkPM1Vsblv0OWZwIJQf37a3t1aXOsktTWyamHzW7vb?=
 =?us-ascii?Q?LJ8fRBNWU0v2VpDvJG4evcDS+7rlfSO8LOj/pGAQ+nxlnAI6h+G2pVw6rBgi?=
 =?us-ascii?Q?KtSZt4qIKXFzrekhW+LzxSx7ZU/PvepFKLVllC2I/eBTptXulR8eiayi3f+w?=
 =?us-ascii?Q?pZFr5utb6tKU7QZdFI0YNe/quKJR33wIci1qAWOgyTclU8YuUZRG2oH9ApXK?=
 =?us-ascii?Q?gmJkKhBQR6k6WJ0cRe3VO3lXO7iv0ermtPxawm8nHznG/Lrzv9b6gWl18zUZ?=
 =?us-ascii?Q?EZLIDIag2sCxNI01f1oHvLZltKxhrBG4j038Y17bsl/mDep0yXpaXbIofFW+?=
 =?us-ascii?Q?4DhrkwP4fqjbKUxGkndzXXaWnrsyD/tHe8PqOy4e9E7kdFxoW9WMYn103jf2?=
 =?us-ascii?Q?8gwCUuCaN6vnllCaaIDuXskh5G5yUQWwwpEw7yFexIUMZr/Z/ICjIBwZ+/0k?=
 =?us-ascii?Q?b0KrAqvt1dGzHNe92DY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:48:51.4791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ee7a6d-9138-412b-fd26-08de4ec509fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7039
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

This set contains a number of bug fixes and cleanups for
IB handling that I worked on over the holidays.

Patches 1-2:
Simple bug fixes.

Patches 3-26:
Removes the direct submit path for IBs and requires
that all IB submissions use a job structure.  This
greatly simplifies the IB submission code.

Patches 27-42:
Split IB state setup and ring emission.  This keeps all
of the IB state in the job.  This greatly simplifies
re-emission of non-timed-out jobs after a ring reset and
allows for re-emission multiple times if multiple resets
happen in a row.  It also properly handles the dma fence
error handling for timedout jobs with adapter resets.

Alex Deucher (42):
  drm/amdgpu/jpeg4.0.3: remove redundant sr-iov check
  drm/amdgpu: fix error handling in ib_schedule()
  drm/amdgpu: add new job ids
  drm/amdgpu/vpe: switch to using job for IBs
  drm/amdgpu/gfx6: switch to using job for IBs
  drm/amdgpu/gfx7: switch to using job for IBs
  drm/amdgpu/gfx8: switch to using job for IBs
  drm/amdgpu/gfx9: switch to using job for IBs
  drm/amdgpu/gfx9.4.2: switch to using job for IBs
  drm/amdgpu/gfx9.4.3: switch to using job for IBs
  drm/amdgpu/gfx10: switch to using job for IBs
  drm/amdgpu/gfx11: switch to using job for IBs
  drm/amdgpu/gfx12: switch to using job for IBs
  drm/amdgpu/gfx12.1: switch to using job for IBs
  drm/amdgpu/si_dma: switch to using job for IBs
  drm/amdgpu/cik_sdma: switch to using job for IBs
  drm/amdgpu/sdma2.4: switch to using job for IBs
  drm/amdgpu/sdma3: switch to using job for IBs
  drm/amdgpu/sdma4: switch to using job for IBs
  drm/amdgpu/sdma4.4.2: switch to using job for IBs
  drm/amdgpu/sdma5: switch to using job for IBs
  drm/amdgpu/sdma5.2: switch to using job for IBs
  drm/amdgpu/sdma6: switch to using job for IBs
  drm/amdgpu/sdma7: switch to using job for IBs
  drm/amdgpu/sdma7.1: switch to using job for IBs
  drm/amdgpu: require a job to schedule an IB
  drm/amdgpu: mark fences with errors before ring reset
  drm/amdgpu: rename amdgpu_fence_driver_guilty_force_completion()
  drm/amdgpu: don't call drm_sched_stop/start() in asic reset
  drm/amdgpu: drop drm_sched_increase_karma()
  drm/amdgpu: plumb timedout fence through to force completion
  drm/amdgpu: change function signature for emit_pipeline_sync()
  drm/amdgpu: drop extra parameter for vm_flush
  drm/amdgpu: move need_ctx_switch into amdgpu_job
  drm/amdgpu: store vm flush state in amdgpu_job
  drm/amdgpu: split fence init and emit logic
  drm/amdgpu: split vm flush and vm flush emit logic
  drm/amdgpu: split ib schedule and ib emit logic
  drm/amdgpu: move drm sched stop/start into amdgpu_job_timedout()
  drm/amdgpu: add an all_instance_rings_reset ring flag
  drm/amdgpu: rework reset reemit handling
  drm/amdgpu: simplify per queue reset code

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 136 +++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      | 289 ++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  40 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  13 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  67 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  37 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 141 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c     |  45 +--
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c       |  36 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      |  41 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  41 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      |  41 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c      |  33 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c       |  28 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       |  30 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       | 143 +++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 149 +++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c     |  26 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  38 +--
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c      |   3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c      |   3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c      |   3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c      |   3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c    |   6 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c    |   3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c    |   3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c    |   3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c    |   3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c      |  43 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c      |  43 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  43 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  45 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  46 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  45 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c      |  45 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c      |  45 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c      |  45 +--
 drivers/gpu/drm/amd/amdgpu/si_dma.c         |  34 ++-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c       |   8 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c       |   3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |   4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c     |   3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c     |   3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c     |   4 +-
 54 files changed, 952 insertions(+), 966 deletions(-)

-- 
2.52.0

