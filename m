Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F2BC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 13:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA43710FC8C;
	Thu, 18 Apr 2024 13:58:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="roQPStK2";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBBB610FC8C
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 13:58:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqZeQTuncsiM5QW6kXJkqPmmsqm8zi3OkPFvMd1iL1F3yMyCeJMCoAaeW4JvhesczBlIjQkQnICStBFFUuS4beT6GevhIebAjN0mlx1SK2CXKo66ILBwy0GcLIvvckSt9dpeoUc3Yk7V91+n4q2oInMvRXy6Ssozcs8050XEEXY3j3bXtZ6Aumr453/kO0bA2M7ObnOSKjHdun8DAERn9bPmh1x8V/FboJTc8LFz95khr7i+qD50NOSPfJVoU27SlINYsM2iRHcXjnr9VFS/gYbuoCcOMrhNRYwglV/iIu1pibuvgPNVkv/QnJB2Uhzse5j45jCQvSdE+UXz1DK7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaZc3A56vKnOyJ6kv5fHSNffCB8bvRwuee6Nw7PNKuc=;
 b=IWAbMSBLR8OcEEG22Mz6qCrfrfKfetjvUXdmK7j691HwoUNkGVqJCrATT3fIjQBsRkGeLzQP884gVBA7yyoy21s6xu6egtS+mvzbCWs9h+C8/1DxCWDPOK3KmtS9Wb/Cfj1ZDwRqtyw/Lpr4y8kP9ONF3ajmCtnwlk5kF+Tz/uyRignC/8AO0w6dBv7BVO6zoZ5lCuN8ofZdcSxHB7cAkMorXst1l48W6BaqCpAorF1UIkj/P3h5BOlGh3Is8DPToPC1FeF4KZlnTkJ5nXGbLk3EFxbIgcWks1q/iKQ0dJQEsM8YHHve0CAGJZ+Fu5sweS+1XxYmG35IM/qssDMsRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaZc3A56vKnOyJ6kv5fHSNffCB8bvRwuee6Nw7PNKuc=;
 b=roQPStK28Ekm3bOFdKzOrbjSOy4vJZlEVaDtp13Gac3jT4Y13V0j9M/EY7q5LDBO+yyZW6n2qxSkJE3yYY0QorYLuS8MrBRhugh2yEpbVpnkYulEnFYlmOWJh9M0A/J3Q8z7um0f1sqfCCBkqwgXzwuFTFUZnetNo3bXy6Wj8EI=
Received: from BLAPR03CA0024.namprd03.prod.outlook.com (2603:10b6:208:32b::29)
 by PH7PR12MB9128.namprd12.prod.outlook.com (2603:10b6:510:2f7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 13:58:37 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::c0) by BLAPR03CA0024.outlook.office365.com
 (2603:10b6:208:32b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.23 via Frontend
 Transport; Thu, 18 Apr 2024 13:58:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 13:58:36 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 08:58:35 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 0/6] Best effort contiguous VRAM allocation
Date: Thu, 18 Apr 2024 09:57:57 -0400
Message-ID: <20240418135803.17365-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|PH7PR12MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: 89802e4c-a4af-4f1d-6ac2-08dc5fafa4e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kYyolmW6HFefSX1BrsDXhKk9AF0h9ofEm9S8HJvKQUmy64VAlIn9mqMunx2W?=
 =?us-ascii?Q?+w+FTE9FAhfJjBRtFFFftumMrxniWFkYwBkKFobsI3P/m57RyVnse/KsSKsD?=
 =?us-ascii?Q?FgdhR8zs4VQ6q2wmKTcARyft94TE4k5zd7DeOJ2AOTp84z1HNHyItOeEIWb0?=
 =?us-ascii?Q?Gasd88wq9wEnfG8y9WZP0JXLGPkjYimqg6xG7qoHQ8hOHFD+oYLFtZqWrnBL?=
 =?us-ascii?Q?vG/FXrq+Dt6RbGxLMIQ6+BpUNPVntxyUmKakBpI6n086wN2WfjALV+I43JGY?=
 =?us-ascii?Q?pZ73rNsrfZDG3nvHI632Qgojir0VNk763hZXMYL2oM6gVN60p64sMXFZLXhX?=
 =?us-ascii?Q?HJ58e3DcIYAbOLMwmz3FJPrYjeq2MeuiMS8Pq9pUfR3+FrAzxZsPnkRLLwbj?=
 =?us-ascii?Q?ALekG2pIQAsFTSF98OCVGvZc3Ijmv2xiAa+xPr/vII3VU4ebdJFqnC7m3PK6?=
 =?us-ascii?Q?Z10HdezIZq4eOCH2bJ2a/YUY6HQk9NfVxkCjLNuChf54jH7jRTE75+JErh2U?=
 =?us-ascii?Q?BzorCJ0eyBLIJ4MEwgXVM1DbMwOSWlxRfIN2HAVwng1D0KAmYzOS8XCpX22M?=
 =?us-ascii?Q?W467LxItmOLNH1+dWzaljAUvK6YqC3bocx4gnrs5bmbAH305+HhenwjjDqjX?=
 =?us-ascii?Q?5LSh8KB57/xDwFCnWELhDIh/Qf5IU+E2YSzO2Gv8zEHiq+CHOHhEmtODb3JO?=
 =?us-ascii?Q?oStroEvCiBlKfny1lIsRCOEfSrLo3I0kpv887s33pzf5uc0XR25vGo4Oskyf?=
 =?us-ascii?Q?CdfGnCwSMJt1q/UuFj7VhslAhX2PKxvUKHK4J3rEHKOyxHp/0X7z7yVFhEwz?=
 =?us-ascii?Q?p5E2WQLnMVDwFRWNNO+N6TSdJfCH/4n9oD6P2Eno1c331DXiHT0FMbL3Nk0t?=
 =?us-ascii?Q?sdBPV+wLcmcIFx3jQiMVIU88+biM2+pQZhPcXBp6O55gMlrbNQ+XDeovYnoB?=
 =?us-ascii?Q?eDNThUKsW4PDOmq+mIF8CqGDg+Sgc8bWOKcXfbnrfgHJRQ8kXNURNUiOWKlx?=
 =?us-ascii?Q?d3Kc2T17hupNo3Ylb9gZeXgkXSklbnF1UwJgmLsCwUieFSb2ylRn6HR5r/97?=
 =?us-ascii?Q?ySQzVJxW+2C9NCDejKLDdyD3wRNBpLDiZRauYn+FfBJWGigEfAn1UrwJZ5qC?=
 =?us-ascii?Q?rNcAR1Zarmo/RKm3jpfx7xa6tUjQDqBM+sCIbZEJthMArrOW5y3cWSy7PaXi?=
 =?us-ascii?Q?qKHjMmxKHew2Oh3EZAM/Co6efqKn6ItDX1qenXVe28iRjLDrob9OSaVq2evR?=
 =?us-ascii?Q?DrTQ7qNMQD44E7Q2lujVTGU/zxm2cbD/ZcmqhEfv59eSb8qVf/a/SJEv05kt?=
 =?us-ascii?Q?DSD1wpGQ6VkzpzOsSGdu2eqw/GsGw+QZuL3qi+fRkUKwc/A/31tmpSjmgE2K?=
 =?us-ascii?Q?q2eWpRFKV9pM+1gbejdBH6JGZuNt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 13:58:36.8200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89802e4c-a4af-4f1d-6ac2-08dc5fafa4e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9128
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

Philip Yang (6):
  drm/amdgpu: Support contiguous VRAM allocation
  drm/amdgpu: Evict BOs from same process for contiguous allocation
  drm/amdkfd: Evict BO itself for contiguous allocation
  drm/amdkfd: Increase KFD bo restore wait time
  drm/amdgpu: Skip dma map resource for null RDMA device
  drm/amdkfd: Bump kfd version for contiguous VRAM allocation

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 21 +++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  | 42 ++++++++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
 include/uapi/linux/kfd_ioctl.h                |  4 +-
 5 files changed, 52 insertions(+), 20 deletions(-)

-- 
2.43.2

