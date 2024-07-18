Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1F0C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C853910E076;
	Thu, 18 Jul 2024 14:07:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xnz+KyGn";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 440F410E076
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:07:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJdKQh7NmwUovRqqyzCWQ7XLuE944qpovH4A/y3Wxq2ZDUQliaIyBk7MYu9NnN1dWwO9cWZXM5KgpJelDgZtBT4PV+vIeKwin3OT+/dv5K3Z7sx554qjq6OejxHCQHlEq1ru/VLixgkcCCfgumRtFohmk/GHt2+mbPskyONKnSkurTH0VB+7QMQWoVGAgQ9lHJpPAvm+Z67LOvy9+xNHJ1nVbkW6x8kPCp/ocnFTZQbJzzKMkBKa2jXlaZT9gUEfxMiq3orwNki7pW99m12erOtR847IFg5k9DGpvWzKnDGzVOsVxHudNZkUJ0C8UZi6+LX82Qbp0p/bpV6p0FUWSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkGNJUs3CtQCkw431vk1x9U8LbBaV37lDxLX35DlkqI=;
 b=uhHEIVgp8l51g+gpS8ho1Tj+WPZMPHLzS3nK8ctJy9/F4mMajmArnm+kRl1R9mPFUix4E03BqQEhrAHaDcWQusHMmYMGo6QnH3X39QsS6WQ5wsmurKY2BdkajCekmZuxGjhZMJ60mrBaf5TwqSHdQ22En1qo1SrSwqrOSv8KVLAPtGXX84313dfMQkEVeK10N55xfw/HoFl+uRyMedLRsA6n9cOikdGHz94i4MZ79VhzHB7Nd7gjUG5DCikq2CsnpQ9c6NCjsAv98mzEXrdKenF6+CzFYjPF/7Em8FIbQa8A7vRt6t/7q5bM9txl9ugNLip3Us/gmjRpfSWb43oPBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkGNJUs3CtQCkw431vk1x9U8LbBaV37lDxLX35DlkqI=;
 b=xnz+KyGngvNXsKNA2sNenD9IGdgARCwGbdhyduETrR0Q3Y4g4kM6aejg+AdV+yKHVO0f8SLpWHGBqHtQYZS6SmSIb81S7NLfMhJIf5qZBRhVcctb3njIUj0WFtvksi6SLtC7ThJWo9kUyKPirjKkww1JXXQs4/JRFeq904NP+/o=
Received: from BL0PR02CA0011.namprd02.prod.outlook.com (2603:10b6:207:3c::24)
 by SA0PR12MB7090.namprd12.prod.outlook.com (2603:10b6:806:2d5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.33; Thu, 18 Jul
 2024 14:07:52 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:207:3c:cafe::55) by BL0PR02CA0011.outlook.office365.com
 (2603:10b6:207:3c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Thu, 18 Jul 2024 14:07:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:07:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:07:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 00/34] GC per queue reset
Date: Thu, 18 Jul 2024 10:06:59 -0400
Message-ID: <20240718140733.1731004-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|SA0PR12MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a67c49-a38e-4ee3-17f6-08dca7330349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RRGHdfAMqRFKQB++E6l9tPhC18rAtkpEAqnAHq5HkuxKjlPc8ozg2EIQaX8F?=
 =?us-ascii?Q?CU9o0AOx0s3T5HKduwzLRZ9oZXdOR2jJ7u7G95gEJEzp4JHq8wJjv+oDWXcL?=
 =?us-ascii?Q?PmA4Mhk96243L3AqUgUQmmdf5Po8tBtyfz1cxYBD1phnPyW+IftxdYyt4NXa?=
 =?us-ascii?Q?FAz3lsBqbJzH8yMqlkHISBRbf/bGUGoVvlgiOkmo1L8JzweMROAQyUGiFX4z?=
 =?us-ascii?Q?6rrItgTc3j0dOPi6eusgRct+eEIdvB3oePcpxzj7Eo1lL+XhHtd3QziZClYW?=
 =?us-ascii?Q?VvQLeFgAZq7x5valgD2ehzcmDTgha+At/YVsZFlVhaqMKRGrXfq+axHPv1w7?=
 =?us-ascii?Q?fd3h4Bgby5LkKxqgEXckpjhNAI8xg/1l9TfzM0ZLX8oYzi9LK80y2/RosZPo?=
 =?us-ascii?Q?4PZHePT3897vwSSWG6mct6NnzvoFmpOSGPDu/M9WwXgqyVkC2aKa04Ih8UPw?=
 =?us-ascii?Q?m96aq/IFskpmZVnjUsyJeixdqv1cGqjIql2s9FREoJNQriEf4iKxWNiAAEnc?=
 =?us-ascii?Q?GhqOIcAtYuyh9t7emuplFYW66kuf74neCOMj+xH7Lzq9Mcn2Db9qKJk11VoV?=
 =?us-ascii?Q?Hy0/C7B6PEjtT3z1N6TrR6eIbXbKFICBiHl4Nz1iAlXy2SM84Vnt26zawmV4?=
 =?us-ascii?Q?iFb/YEQMZxTd+Sk1gQaop1bARmJNwg4PhY6RMvBXfSonYh18OPChBgIfCGiK?=
 =?us-ascii?Q?BIyHe/iNKhXoy6DP8ZKC0XBYndfY+YentNz4se9eNFbrM++N2ahAAkuIP37E?=
 =?us-ascii?Q?TcFGKipCXgRG8XvCmtkwRGpGXHEZzrCFL2b7f+S9pyIXdpRFXBxHUf7SmNRg?=
 =?us-ascii?Q?OyvIy9dNy619nDMtJoVwlQdr3bBP7CQNZeSbZuFFYLiUTEjEknR/+FVMm+jK?=
 =?us-ascii?Q?3v8+pKcj85RiWyJyqsiPMTrmrqjH1vsjQU06J6FlJM3zNe8i5VnesUI/frWF?=
 =?us-ascii?Q?HXYicjLQcsI24nRaJE5nYlEO9GLMgRscQahiiYGW9ckTPK4jukdea9Ptqgdy?=
 =?us-ascii?Q?PlThEE3MflOugR9gYElW8xiqf3c89wUPksJzDsIPQ7AybMjsNe1sVYnGSDlc?=
 =?us-ascii?Q?IbIZOptEhXMLUNs7mbFz0XfbEN0VlbrhpaGED452aT8E9pm9yImlMiKirSC4?=
 =?us-ascii?Q?e0v6l6la8S29gssNUBMNAvYbshjzz8MCWTl1WAXQ00utL3Gv23MZUFkG7yFE?=
 =?us-ascii?Q?12O4zw086ZmdAv5grgINAe5IKIrOYuHpRKMWrp3ZcTEWFr3J9FtJGMyV9KA/?=
 =?us-ascii?Q?bffPppfBicc43s7n/KdBdIYir9n9+rgnyZpZQn0UuWRn1Gd5k7pBqoxbnvuS?=
 =?us-ascii?Q?U7fQF7iDjY63IZ3HQvac8Ap6Uz8a8W5WX2lY3pADXTcpMZTX0/KxqM8cShIK?=
 =?us-ascii?Q?37kvVuMAXg+WUrgjxLGkg36oGokzQfCtnOO4ZEzFHmqA0kvIHI/0Yp+7R9Je?=
 =?us-ascii?Q?KKaAex6+zSqayXst8IyDrfitIBD1RwO1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:07:51.9279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a67c49-a38e-4ee3-17f6-08dca7330349
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7090
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

This adds preliminary support for GC per queue reset.  In this
case, only the jobs currently in the queue are lost.  If this
fails, we fall back to a full adapter reset.

Alex Deucher (19):
  drm/amdgpu/mes: add API for legacy queue reset
  drm/amdgpu/mes11: add API for legacy queue reset
  drm/amdgpu/mes12: add API for legacy queue reset
  drm/amdgpu/mes: add API for user queue reset
  drm/amdgpu/mes11: add API for user queue reset
  drm/amdgpu/mes12: add API for user queue reset
  drm/amdgpu: add new ring reset callback
  drm/amdgpu: add per ring reset support (v2)
  drm/amdgpu/gfx11: add ring reset callbacks
  drm/amdgpu/gfx11: rename gfx_v11_0_gfx_init_queue()
  drm/amdgpu/gfx10: add ring reset callbacks
  drm/amdgpu/gfx10: rework reset sequence
  drm/amdgpu/gfx9: add ring reset callback
  drm/amdgpu/gfx9.4.3: add ring reset callback
  drm/amdgpu/gfx12: add ring reset callbacks
  drm/amdgpu/gfx12: fallback to driver reset compute queue directly
  drm/amdgpu/gfx11: enter safe mode before touching CP_INT_CNTL
  drm/amdgpu/gfx11: add a mutex for the gfx semaphore
  drm/amdgpu/gfx11: export gfx_v11_0_request_gfx_index_mutex()

Jiadong Zhu (13):
  drm/amdgpu/gfx11: wait for reset done before remap
  drm/amdgpu/gfx10: remap queue after reset successfully
  drm/amdgpu/gfx10: wait for reset done before remap
  drm/amdgpu/gfx9: remap queue after reset successfully
  drm/amdgpu/gfx9: wait for reset done before remap
  drm/amdgpu/gfx9.4.3: remap queue after reset successfully
  drm/amdgpu/gfx_9.4.3: wait for reset done before remap
  drm/amdgpu/gfx: add a new kiq_pm4_funcs callback for reset_hw_queue
  drm/amdgpu/gfx9: implement reset_hw_queue for gfx9
  drm/amdgpu/gfx9.4.3: implement reset_hw_queue for gfx9.4.3
  drm/amdgpu/mes: modify mes api for mmio queue reset
  drm/amdgpu/mes: implement amdgpu_mes_reset_hw_queue_mmio
  drm/amdgpu/mes11: implement mmio queue reset for gfx11

Prike Liang (2):
  drm/amdgpu: increase the reset counter for the queue reset
  drm/amdgpu/gfx11: fallback to driver reset compute queue directly (v2)

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  18 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    |  88 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |  37 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 158 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 117 +++++++++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.h     |   3 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  95 ++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 126 +++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 125 +++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c     | 132 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c     |  54 +++++++
 14 files changed, 930 insertions(+), 32 deletions(-)

-- 
2.45.2

