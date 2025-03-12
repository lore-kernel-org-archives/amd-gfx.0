Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8C0C28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 18:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD1EF10E161;
	Wed, 12 Mar 2025 18:57:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1TMCDFoo";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C88DA10E191
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 18:57:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byQKMMroSyDgGonHt5w1DpXTHlQD3rNAsHx4qdEGjhCH0L1A9dCbFB6ycaBAZ22NDFPEPoS5QJRC+T/UIrzY65S0jW/hRf4usdpmZPAQ8W9LvNYfAq+DffLW/h77NQ8lFNDa3tvrzhKO6lwtw+AQ/nUjgZOS9IlvGSG3ppC22+2QgTcQAcyM1/l/tBfro8ZhEDG9z4DLwMxFi5MDBpiZudmZbyb+g/iTaYBOf+irHopVeGjF4tAfsptz7Azjdwq0BW5o0cwkw7HGb3ZSFao5qXpRMW+Gl45Gc3QUptNw25JrsBDq6MkvoN6vSCt1VzEVSMTAm92vGNpBFEQXOSQyCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMkTru1v7lqHByn8T2Y3NKWgchWY9j8TQjhgoOJikOs=;
 b=IMPswDJ6Bqgz7EFD7dfMegqAM9qzZAQiwacTYCg3Rf9wUe8b6oEawvn2eW33jNljyxYZtCWO/bB3vJ3U8ZyFPEsNp4tH2qJtkB1AxZ4z3DkxKKKz+U1YXo+6qDg2TCXds5tYr+Cg4lg/ZV/LpSsRJmkFoVH+SkTFl8QL2+IMoNs8qWGNksw7x4UVVAF8ax6CF0jFPxxbvT94JB92DU1CnB4MTANlvK/YWTaEek76+hJh6rpfZ1139WK/wkGUepDDPndWT3pdwLgI0IkJlrkGZInJ6fPVAAJbd9KvvtYu5HFIiBI2UyF7tOZJCKT1VYjlf0kU9bjaXIy+8BQu7Hrdig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMkTru1v7lqHByn8T2Y3NKWgchWY9j8TQjhgoOJikOs=;
 b=1TMCDFoo7wCEQE46o+8DEV/wnL0/o9QWG4Ffdm/tx/B/C67dtjk7Um/OSa5saGGUX58H+QtKUpGYsZlMXew9pluoBjDJYTlJbdBlMe7pffzXzMvkeL1A9Lf+BpMBaPtqTGj/YrgMs+x4xoEfCbx5zPjOpB5Uakbctv3/Sf5p7DI=
Received: from DS7PR03CA0236.namprd03.prod.outlook.com (2603:10b6:5:3ba::31)
 by PH7PR12MB6659.namprd12.prod.outlook.com (2603:10b6:510:210::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 18:57:46 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:5:3ba:cafe::8f) by DS7PR03CA0236.outlook.office365.com
 (2603:10b6:5:3ba::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Wed,
 12 Mar 2025 18:57:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Wed, 12 Mar 2025 18:57:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 13:57:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V4 00/11] Add disable kernel queue support
Date: Wed, 12 Mar 2025 14:57:20 -0400
Message-ID: <20250312185731.211350-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|PH7PR12MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f110e79-698d-44ba-1939-08dd6197c67a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qVX5qavfPhD1fIojDjztEWQsOVrAHvSoT63XlgcBj94G0PGpJZQWyKiGluZ/?=
 =?us-ascii?Q?KTtsPyFZFOUsATf6t5OzY8GJemZtaeZgzyNOK1iNbIkdVlrpi/nGqVKTsTFr?=
 =?us-ascii?Q?NdybypQkF+rUvSPD79JOxMpf1XgFOj4HRhWHTkUMNd/oYPOOUIud+oQNsAMY?=
 =?us-ascii?Q?p543FrL7YIvAWyTYAmTecS+ZIJqjzXTiogALxIS1kbu9DQROgTlORzVvukLV?=
 =?us-ascii?Q?iIZG6n6yNNEwdiDwgFlJ/oTytCr/IhcnsEZ/fEDQKbPN6nONgqCEQTSiwjOE?=
 =?us-ascii?Q?I2q5OogjxM2hfat5jXGz76UGQW8HX1KCyFISbk6rxWhfbfxOALWgEK+it8xO?=
 =?us-ascii?Q?u84ifGsnHt9ydJa1Knk5Bq/yVseJmkxs+IOxjp4uw2UJuL/wmhrnLKs2fW5M?=
 =?us-ascii?Q?R+fgq1cAeWIJ764vRTlJ1csXzGgPEGafzkCAW0d88LRny70Jhj2CGeLkmojf?=
 =?us-ascii?Q?usw8OPQ1VnXW3gqBQGlrhcrTqq2rt5zk8SflHETop/uL9+vPlxNAXs6gAjMA?=
 =?us-ascii?Q?wwHO0sO55Qc5C8NRdU9vthNirQu883pavQJb5krD+JUJ1bviSc9A6KHZIv9E?=
 =?us-ascii?Q?yHzrE/dqBKSlxFXUILQW00aJ80sqYOyITokSPh1uDrqfbnVvbE3k4QO2sUMH?=
 =?us-ascii?Q?XnmWNm5InwT1MXGU39ilPOunHW7R6XqBhrfdDkHVhHiPjYkvfCcGd/PNwsEo?=
 =?us-ascii?Q?3cl0QLINstkLVUi/pVOqtgmSz3qSy4jH8XGjv4rG+HQVC1j2jmYTXSeXt8VT?=
 =?us-ascii?Q?riIMKMTEKWL2kGg5w9Y2x/Elc8qQOYEfKa64y1mAaJPLxcmp2XUEGkisQDMt?=
 =?us-ascii?Q?giy5gxcCMNENT1zsaDXis4Y9+zY191bkZ2L8BJBt2WtclQXftJyRkj+4IhFd?=
 =?us-ascii?Q?R+wl5BCIfDFui+hm0QFZ42pTK6ZRGyqh1kqYk/G6UEgno4ppQ+hFWbB5wP52?=
 =?us-ascii?Q?3iI8QsdzDnMJsUcuz3h5Mz3LK4OgsPz+husgC1wFq5jbn78IOV+zqVOfxEnN?=
 =?us-ascii?Q?3GhPmU/IzNguthBrAk1E5aWUpBVol34ohc2d2wQ7URNUYlAOMlJTUKaBljYA?=
 =?us-ascii?Q?hhOBBqijWXPtp+qUtfTknQp5NvtDPwVX6midjY92qyePiawnlmQcx7KodNV0?=
 =?us-ascii?Q?jjPnG3hAjzQ0/RNwdfP1bEw3yRx6pyREsZ538mDTL/Q2O68bM6zNWNbibM7T?=
 =?us-ascii?Q?B6yKLSPip2CLD8YnED1OoLB16CE3YbUDNSM7xlJCNomR/fZUb9O6z3yqilFp?=
 =?us-ascii?Q?3j3Z/nhVfSabvrmFJBIB/fKBNPQC4ieLzgcKMb5xX6QN+1hqUBGduTLbNCit?=
 =?us-ascii?Q?MqS2xa1ZRr8DR+vEerGENY7SnLxQe30zYPsY9LiWNRYsPJNLe11eZzGqIVsB?=
 =?us-ascii?Q?quGKZ9qnJ2ujqXkadMLvUAMrzWR3Ml9IsNShh2PX81TZmGSFjYvcTThkgGVC?=
 =?us-ascii?Q?tTZm88lP+CkSuDWe+SmuDMvFhbZVp5l+YR7PoH1Nc3GUXbBXoobNnj6KMgAZ?=
 =?us-ascii?Q?0tMeG+qOPy8jI5Q=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 18:57:45.3700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f110e79-698d-44ba-1939-08dd6197c67a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6659
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

