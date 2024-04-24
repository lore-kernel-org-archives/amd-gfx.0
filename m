Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CBBC07E8E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 15:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48E20113C12;
	Wed, 24 Apr 2024 15:29:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pOh+y71Y";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 165B1113C10
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 15:29:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VytT6Yp78gOdRPFfA5I3dvrW7oSaN0yaCEc6ZXo6Nbwtn9FrNTgQ+asqs+XB3N8D5SIoJvCKK99keLkxPtvMXBWCtnQAixa3DSY4pDbrR7fqSh/+7wOeXse8i4OVjZzUjCz8yMOrvDYvi3kQNkz828f3ZH+MnV8yYK1AR+9IrOW+3pq2h6m04lmS8G1y5ox2T5KIksDgXdAJ8XXbTCAE3kLvuG98r5QklQLyph6682XoE0TYH/rRbP8JHCIVXPekdBHzOVCT2qhDvvRdyzzHEsU2rhSb9fC1+uopMdeY0Pczc7F11/N9MFW7kpM4HC+mW26Sb9xtemiCOKY+mf2yyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7I5GirasgzJwVKpo3p6aHZU7MP53WBFTvufJwPZBofQ=;
 b=GCyu1qMOqVo3w3d3UgivzgXjXAeoMPq8Dv0k30Gx90JLP5qyaDBDJn2gudzXrTqNGEJ92xwQblez8SNVFRkvpjBoLLd8NxS/vy/sZLP/UBz3S40kGldR2qdk3IGnirbTulMtQo0QUI/SggMQ/z1e7JJT0e/smpxy/bM+M2sSJmIbp9okB/B8A8sKLoLQe2bh4fpaxOv/owu1fxdB3/qQx6+GxWaZgZlqhwp1POnsHd71l2NINbW/tpGN9hZOcy9L9S+a2TyDmY+ZGJqn0Df00wZiqx9yAPNU9BAe4ABX+qrD25VEn13/1tVYvULbyMah4nJIr05NE0GCY+OqbkIlIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7I5GirasgzJwVKpo3p6aHZU7MP53WBFTvufJwPZBofQ=;
 b=pOh+y71Yuwc6E/aGfcYm3HtZLBG5qkcLxeHWgyW/Lv3wIIyUqcbwmbx1SdlyH0GCcLuS52RnJ6xKKVvMsHCS6uAkSQhTvJpahegHwZXSlfmYHFbr0NyOrdWXvp8dw1qbcFLhlG07Dvn/kGXA8O2mAPdL5fIAjasFO7+H/Z7tha4=
Received: from BY5PR13CA0026.namprd13.prod.outlook.com (2603:10b6:a03:180::39)
 by SA3PR12MB8047.namprd12.prod.outlook.com (2603:10b6:806:31b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 15:29:29 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::1d) by BY5PR13CA0026.outlook.office365.com
 (2603:10b6:a03:180::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 15:29:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:29:28 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 10:29:27 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v6 0/5] Best effort contiguous VRAM allocation
Date: Wed, 24 Apr 2024 11:27:44 -0400
Message-ID: <20240424152814.9608-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|SA3PR12MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: b61f5eb1-5c81-4585-e473-08dc647354ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fFWJiURDcGDPKpq4CjcpDGq8Nh9H68921DjLOJtOFNsSMU9a+xPOqkA8Ijxd?=
 =?us-ascii?Q?AN2gxkS+m3vscl82ppmvqYY55jh/wRczrzKPsrZ4Ny6AuAm/c1dw4WPIbDOh?=
 =?us-ascii?Q?3AV8uI9caHQmTsJW6AqilPJrCzyv8Dk5YoQArGbSHNgRzshB2SxbjuD160Kp?=
 =?us-ascii?Q?l8QZn6zv5E+0zbNLVI3CpGEWelHEpJ18smXEBnxDd45fUwZ6prxPr7TfOZIw?=
 =?us-ascii?Q?HIFBbS8jDy6Es25F/aHwN96EkpR+BG/wm0bA5KxRGpr+0TQ03YIr49USHCif?=
 =?us-ascii?Q?IGAVZvYa1XGcDBRIP3vXKWhWQwezOeohx3v38SStOSUDSRx3ZmFmKE1TXtrN?=
 =?us-ascii?Q?dOfunfXz+oAV232AeOX0k99jAWItwasIp1ydVURPY7yfsHChLM9Gk1l6sdO7?=
 =?us-ascii?Q?Fsg1XnLzWPCCIddWWCYoZ0sJEKNg/3sX+uqIdHpYf4/d9vaSW/+mrjWQRG08?=
 =?us-ascii?Q?rDLEsFyemePbYKCSKbDoOzg0HeTwGUz7wobQp9mMXJNDMJl84xrCXeX2ylqd?=
 =?us-ascii?Q?KCof52+BcdmLS8c4g+OV3ixBcto+//+Qqb01q6KhT5dnQ3YNmxk/NpRa38nG?=
 =?us-ascii?Q?6W/caZYjclI++0dlFlvMbtjOFV+bp+UeegGIlIjyg7rYMKTArp5QKSmLC7wE?=
 =?us-ascii?Q?Kqo80Po5kxp4KlFPuhjt5CmNzxt6kumq+Uh4gRsgC6Seypw90+b0LoTowiJh?=
 =?us-ascii?Q?+BTRnXxOHkceSHyagfvgNdu/9OVVe+MV07kcpF89ppwXEZZ7J6syNh1u0Shw?=
 =?us-ascii?Q?4NTXmpb9CFvuRTCueF2PZ7mKXNsnETNlQswe1dOZv7ZELTe7JwiPQ5tTyLQS?=
 =?us-ascii?Q?DlgdY00zdeQYxWYSbMj8AVi8qSSjsU0Gv2KbTw3BrePUjWX63EiAS4Cn6L30?=
 =?us-ascii?Q?Mx9MU4aeea+iIlQb1KFuPkKCLIhAZa16CFdPYdkVy2o229DvHsq7Roe28xaB?=
 =?us-ascii?Q?c0XcUwGd2abJDTM6lut8kOd+wovrdc0PVtg9yIP2NF3E/mKmeNxdkSQgFpPD?=
 =?us-ascii?Q?p/buEq3U7D0DLmb2249fUFa/yCcpq6UXw4lVWFXB8tyD/+M7WM3zM79Vgt2r?=
 =?us-ascii?Q?3RQtvq2GdjGx2wu8AxOun26x5S02IsEXlUYWma3LbP9Rdjc8Nsq2iwTvNdNg?=
 =?us-ascii?Q?KKRU8rboLqhX9c52c3od4DbjJ/wAg/9O+tr9jGPY2eCCSHBaWIN5/5FSCRgQ?=
 =?us-ascii?Q?+/ZSVEhh6FU1Y93rELpP4Ki6On8AOlPLB94x/zJxs5rTYOzUneR+jax0Vniy?=
 =?us-ascii?Q?XwvVTq88KEgQPLRqbVlcjbIHSRIV7VfL5Ot7gip7Tph5b5AVM5t15pG6PKqm?=
 =?us-ascii?Q?vBXe8eqvpIFt4e0YtOx/ErywofhhpjqkAmmHIPaYNY4SDJCXhz74Tfs1J0N5?=
 =?us-ascii?Q?ZusnV9neG9jfjrcsyNg+vM40A9D2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:29:28.7345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b61f5eb1-5c81-4585-e473-08dc647354ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8047
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

This patch series implement new KFD memory alloc flag for best effort contiguous
VRAM allocation, to support peer direct access RDMA device with limited scatter-gather
dma capability.

v2: rebase on patch ("drm/amdgpu: Modify the contiguous flags behaviour")
    to avoid adding the new GEM flag

v3: add patch 2 to handle sg segment size limit (Christian)

v4: remove the buddy block size limit from vram mgr because sg table creation already
    remove the limit, and resource uses u64 to handle block start, size (Christian)

v5: remove patch 7 which is not for upstream, add AMDGPU prefix to the macro name.

v6: use shorter flag name, use interruptible wait ctx, drop patch 5/6 (Felix)

Philip Yang (5):
  drm/amdgpu: Support contiguous VRAM allocation
  drm/amdgpu: Handle sg size limit for contiguous allocation
  drm/amdgpu: Evict BOs from same process for contiguous allocation
  drm/amdkfd: Evict BO itself for contiguous allocation
  drm/amdkfd: Bump kfd version for contiguous VRAM allocation

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 23 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  | 12 +++++-----
 include/uapi/linux/kfd_ioctl.h                |  4 +++-
 4 files changed, 33 insertions(+), 9 deletions(-)

-- 
2.43.2

