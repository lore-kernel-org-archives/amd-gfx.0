Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501F8C282EC
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 14:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFAB110E8BE;
	Thu, 13 Mar 2025 14:42:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L+nmfmlg";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABE5B10E8D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 14:41:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzFOZp68Jj4TLBDQMq99U/4v3Q2AemgQjFGbkqluYRjyHC28leLzR1GO3YCFHqfXpEvzXI7Ln4miIuidJ79tWBcvdELNSS0qqBdj0dA3q0trlgBBFDChit7sRYzHUFMsI4dRoBNwaHkeo20XZT22P28t0KTfVOBXKkFt6AZLjUjlc1rsIrveCQO6OW6oCQsIxD2AiMsMsSnNHnzJdcJ6cW/DI+WYrHWdbFHniY8K6rbS0oVQdO38Xi4xZ5QPKF3LxGv1pNGUhcuxmSq2PG9tJz2OoWheJTfpepIpBAT8NYZYa6L9MR/T3A81nu/loz3b+Pp94/GCbu+qHQSAI4wYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fv2ZKBoK0btsH0UbPRFMMD1I741cvpLaBYbKHIYt+6A=;
 b=dJXoBf7F6n5EXm41EwjD8Wf8UK9jNCOUken0v2K0Ejh6G8eeeY7KCU1xOPlyBBhRGGDEspL4yXxxK5LWL6ApbxacmroCrAZpSoLE8Ga5oG5JRfx0lPt0xPvcgANhPGlZcheT9z+txbzgOiZf5t5AeCZOPU+u2SkG8x4XCKb3AK/LeVC2NWB9aqWmhQLYAEHsjWAyp6WibWb7TypK6f2CNvYS9xwGGOI3zA07Ddzc6f4kAeJMxHFGZmqL3XS1Xbc9cdAanfYKXCUnMKYddlylm+zuSraYD+xPTtS0Dac9XPySC3kdvTYkwIWcOrs8xGiLwnz8DWgMshxTQIKfQ4gWDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fv2ZKBoK0btsH0UbPRFMMD1I741cvpLaBYbKHIYt+6A=;
 b=L+nmfmlgwM32grK0yGmVirxB35n9vjXiKvGewetAHE0koQpaN+904F2xw4f03lyI/KIScsIMPVnFLQuOJJKlYxZkuiDCmD9t+X4/yTy0E57QCtN1k80m3wyyupT+QpZ5iGDtIxSts+bNa96Wmi5ejRAWCSuaLNt+5vqd4ULksv4=
Received: from BL1PR13CA0229.namprd13.prod.outlook.com (2603:10b6:208:2bf::24)
 by MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 14:41:52 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:208:2bf:cafe::ac) by BL1PR13CA0229.outlook.office365.com
 (2603:10b6:208:2bf::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Thu,
 13 Mar 2025 14:41:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Thu, 13 Mar 2025 14:41:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 09:41:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V5 00/11] Add disable kernel queue support
Date: Thu, 13 Mar 2025 10:41:25 -0400
Message-ID: <20250313144136.1117072-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|MN0PR12MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: aada905e-16aa-45b6-0d72-08dd623d3202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xKYDIaiBiTCqvrFwQI8STfup6NY5C7B0KprZW6plgLcNaEOhxVAkJ73fF79n?=
 =?us-ascii?Q?io7r0epNY8wbMhcwmEdLH3QKXwEnE9/72pjZ4hRysUwxDSmBs/AQ9yZH1qOc?=
 =?us-ascii?Q?MaJfzlQbLxnput8dMLRIVRJvR3IMJKBI4UhPMS5lzrzHEVpMC4V9OQAGRkS2?=
 =?us-ascii?Q?pOGD+ZEF2TnwWQg/gPa3ytdvew+CtbG+NwqePyqLJ0j5OlPO4pZqwVPl3MAZ?=
 =?us-ascii?Q?bA116miSKPN1ZeHCG5n2GITn4iOVzp+MHhqbOPGMqmz3wHOFDHOwaPwVpp4L?=
 =?us-ascii?Q?HC1wsRCs1iScPvLgxtdd4sKNZbN6HEPesNRxf+v5Ib5rUqIJbdp15RdBu72e?=
 =?us-ascii?Q?lzWP8tIwk8LQY+JucWZNzt2zRUhTOrD6mcdjCpalFuL1/HCBfSFFA1d9jedT?=
 =?us-ascii?Q?x/vdfpL2xRNGH35jsI1pX7elpedEfnMpbTtHP6iM/+LFa8a/Ke+UUbnu7WIA?=
 =?us-ascii?Q?DuOLqn9jnSE68xVEYNxDOcZGpuXEL58wGF3TfOak/sgJMZ2DM7J/+Ncrp8/6?=
 =?us-ascii?Q?sfcKQwGbaB/KnyMnM8JJdLjccFiPPiMmqiY+B2b0F5xYi/cmOlp8u/Sn5AjB?=
 =?us-ascii?Q?D/8ts2n0oHRzcwNcAzZWUVhbeCbacWxME47TCmp8lrhYznBDJi1t0cfZXzYO?=
 =?us-ascii?Q?XxvkxIspzADDWca9l021Z1VF95e/5o1sm1bzNZgxKqzdjnEIDr0Boj1LUTQf?=
 =?us-ascii?Q?6uHA51+Q8cq3e/8I+7SNlSUbR1IxJdNQSNJNCdiw5YSpPuu4ILzQeO2mH+Cb?=
 =?us-ascii?Q?z5FJalERB9EXjOIE4ei/P8H6V0PohSe1v6Hq1s+4pyzR8JpMmfuXFmJ+Pb9r?=
 =?us-ascii?Q?D4PtuS3kn+4WmYECBZNAYHB8b172S78kuH6JoOBMtX1oGOToVccoJ9sau3LY?=
 =?us-ascii?Q?x4zXHXFED+AR0jUCDwwOj8KlPEIBm3GGGPH0pwYOUCV9aQ+ASmLlTbcTggVH?=
 =?us-ascii?Q?57eu3WZMGQ4LopvbKUnuwcr90ujkinZnwzBwJxoc67ARiT7v4wMtJCD2o05X?=
 =?us-ascii?Q?6hZkUS2ouXO1fgNQuruiUm3zB2fTNnQRapFLd1jU80ePkHftMoFSowPtuBe/?=
 =?us-ascii?Q?nEcEL7iIIA6WtWzzPRuCK/dLVtguEHG6Sz1QLoDarOdpaQ3hYs5PwFKJdhMC?=
 =?us-ascii?Q?h7KQWOBgioySDyDlj2lmENm0MjAGclWwUeLlZRjB9ddAoX9txMI7nBS9O4Hf?=
 =?us-ascii?Q?DCdyMXJ5H/rtTPFrOqHqJl9O6bIoOxfasgab2nby7+Jt1hPItN+Kt84IiBfl?=
 =?us-ascii?Q?x0Xd6s3Qh7ZOEaoa15mh8KyqYTB6kWb1PA6G7otvyLYZVzK8QcF4/jQOR6Px?=
 =?us-ascii?Q?7mxYu/PeC/xZH5y00RInTNPWW0IORDw3GB0QCN1n1Ao6mtno2t3sxGuVC68J?=
 =?us-ascii?Q?oNskNeVDyGnkyzx1xREcLCmFcjzVHW4KUZkgPmDEzHSbW7uXvP8VeEQZucoW?=
 =?us-ascii?Q?OVReBganD3P+8PPRAdk6wBZ/KpCAHoMm4xlV5/NIvXGqNQ2P2UOBsw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 14:41:52.7532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aada905e-16aa-45b6-0d72-08dd623d3202
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835
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

To better evaluate user queues, add a module parameter
to disable kernel queues.  With this set kernel queues
are disabled and only user queues are available.  This
frees up hardware resources for use in user queues which
would otherwise be used by kernel queues and provides
a way to validate user queues without the presence
of kernel queues.

v2: use num_gfx_rings and num_compute_rings per
    Felix suggestion
v3: include num_gfx_rings fix in amdgpu_gfx.c
v4: additional fixes
v5: MEC EOP interrupt handling fix (Sunil)

Alex Deucher (11):
  drm/amdgpu: add parameter to disable kernel queues
  drm/amdgpu: add ring flag for no user submissions
  drm/amdgpu/gfx: add generic handling for disable_kq
  drm/amdgpu/mes: centralize gfx_hqd mask management
  drm/amdgpu/mes: update hqd masks when disable_kq is set
  drm/amdgpu/mes: make more vmids available when disable_kq=1
  drm/amdgpu/gfx11: add support for disable_kq
  drm/amdgpu/gfx12: add support for disable_kq
  drm/amdgpu/sdma: add flag for tracking disable_kq
  drm/amdgpu/sdma6: add support for disable_kq
  drm/amdgpu/sdma7: add support for disable_kq

 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |   9 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  |  30 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c  |  26 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 191 ++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 183 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c   |  16 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   |  15 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |   4 +
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |   4 +
 17 files changed, 345 insertions(+), 155 deletions(-)

-- 
2.48.1

