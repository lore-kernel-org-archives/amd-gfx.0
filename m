Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A74FEC0EC
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 17:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8B3810E60B;
	Tue, 24 Mar 2026 17:57:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T2u0SL5i";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010012.outbound.protection.outlook.com
 [40.93.198.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB88C10E61F
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 17:57:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OF6uZsc06OGXGhHSXtF2bSdldlBtiBzIOCEtse+bMlvpH69akaaDvrw8gDraaTFXLo5vmcXZqMF3JfY105/hllohGY+3ANHynzoMSFG82jcaUj+9JPz2UYbtK4F1Fduuei4DMN0okUgeBQ1nVQEWIx8eUvszGxcidoKPy5Oxcgau+TAyPJSW6huusF9VznFepaat3+QZghOkWGW89MVHaTKtLjqAxwyy1OgIGl3kZqi6o5Kzd/KImzKdP62tSlVaF7poq/MH+mLqTYym0Y3i9+tWJzmxXXasipYOSPFcDVC33NDrLu6h3BiA88FAZof741fcr0B9BMtQuUNSwhLhmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYXskmD7BC4ic6+HOfTtHax+AuGibYBq4JZBRHGpD+I=;
 b=kUhFYCnWs9vyshzXptZ7t4f881iCmo4bNsdn0waMB165OcdvMOzJp4gvmVmd+9zegTDdljh6dsaoFO8+u4iEXzIREktvJ2rxu9tL01SlxriTopuRoOWxjIf0p2ygVNOn0vPyOb2Jcm90Bl91d7dASpnEalZ6iauXi37LdKGT9iYIB/NoS4XFHwc0OslSj/+w7YOX6BKuUn+huflYIau8am/3csV5zGUNohtn3HtvG2BVBR0sKLSmRV28cYnE4a7EzqUbtPQVVdKQ1omkRBFe5NQX9ZVBoPs+8AxMYqBVZf4WlILY9HD4pd7Z+z1MPKzhb7oUBREb3YkxGcuCy+A2aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYXskmD7BC4ic6+HOfTtHax+AuGibYBq4JZBRHGpD+I=;
 b=T2u0SL5i+ZnCqz0JTK5mgxoLVMNyV95JQMR/JXQENIRJI1w75xfwUTLkEGIQo7/3vWRkIXuh/m5XfS6lTxC7MoGYA9MUtQRo5AKgLejtZmKcil/hvvQfAgzT3qF2lBdXkyKoC6j1Vn5IJ+LrC/89arLrhPDFohsuQIqAyQrnNpA=
Received: from BY3PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:39a::26)
 by LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 17:57:41 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::fa) by BY3PR03CA0021.outlook.office365.com
 (2603:10b6:a03:39a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 17:57:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 17:57:40 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 12:57:39 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexdeucher@gmail.com>
CC: <Shaoyun.Liu@amd.com>, <Michael.Chen@amd.com>, <Jesse.Zhang@amd.com>,
 Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH 0/8] Support compute queue/pipe reset on gfx 12.1
Date: Tue, 24 Mar 2026 13:56:42 -0400
Message-ID: <20260324175653.1325754-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|LV3PR12MB9356:EE_
X-MS-Office365-Filtering-Correlation-Id: 75790cdd-6532-4d25-28e2-08de89ced756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4yIClN/gOuq/T9PQGpVPlNgD9txqevEUdB5QchqGAxU0aiEgfkypgc1NzQGX9epmPFQ5l915tcxx3sgnVcsE8Mhao5CtxPdnnsUlpsPFF2H7TsinBhilmeoFctiew/NaDnaliqQQTafRsKncc0mIwAlwA9K6ITx+5z1Nbr7ozp6+8G9zf1QqL/U9NoHayQLmi09U3Nykd5aTQDGT1BaCp2H5cg3PvwOEs048XKLic8tPir5DyVUZrgejvztJeNCSNcZDUPsQE6gb5uvY7HMpYBfxY2GyN8E3zCEpSxQ2AotEr64fCOIees/Dl/Wdewnz2Ogmgnph/ekc/YV3QP/90SwCvWAk8+PIOVnC9fF2Shu1ph3j1gBlYUyemTQoaHxx7GZPCOu4XovTRkS7gpn63IweLV10vX6nhKWj1F9QLhtPO+jn5UTcusWGnbWh5KjhuJluxbQvFUALs1fNPQe/1ymCzCL9TZ6fvrRGolrW726nWrsRdpH2UvRXxY5Be0Oy/dRczgJXyKa2U84X+ORyy6FdcprPnKkwEYOTqqOeFpF+/6L/Gyv+7d83MHeXN4bYXd7J9f0NEQqc1WY90U0BSOto5lAw0Gdx1mEb32nkf2BwWffl2uBrrFJ6/XV8GhB8v0PFJ+RvG1PEIFcsde5hcom66tz/y0EEw3ux9fuLUr35rrVikSabkDkk5oed/CPnRnZL2LlM/2qBP65wc41yw3SDM0YUeZyuSN5U86S1d3u2vludhaTeCu34s1yDiQs+RPZ9j8V9vmL4mA8aidtbJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HynqM9SlQExBhkVZE6MdZZ7i/TLn0o7OcZqsoET2W5GjLabOZwkI+loEw4leEJyb228trh915IZedUMZGTgk88J66jvdUOLKCpH9salEY1WUr428rBv8iE2k/l+FxDfaAXF9lrZUCiZqmTK8FEz9+wRrBGOMbgrVXwBSNhKbs76wk+L4YecZalLsGPzYcZq26Y2GP3vRDYQNo727BdQcYH6JiSi+IjCqOg052rxwIAiYis/VUnduqQ5P0nVwQpGNNRHH9kaGTpWdGvwK2F6UQfwPHuB277JSHWgWMa6aLEDXBrKVLmmCmkoSVZPOYdCJQGrYTVL4o0qEJk17AO2uv0KNF0HqPq9mLtm/Xf5Jj7rhkeoXfPwQLTvGD9nvEN4lhwR2oIF+7Y0A/QSgmKQU4P/hcm1JAw9PQh4wRWbljRz+1fvj3HNkeLsZ2SpZsfEr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 17:57:40.0797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75790cdd-6532-4d25-28e2-08de89ced756
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9356
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

Instead of MES does the detection and driver does the reset, this series
implements compute queue/pipe reset with detection and reset both done
in MES.

When REMOVE_QUEUE fails, driver takes it as at least one queue hanged.
Driver sends SUSPEND to suspend all queues, then RESET to reset hung
queues. MES will unmap hung queues and store hung queues information
in doorbell array and hqd_info for driver. Driver finds valid doorbell
offset in doorbell array and looks up hqd_info for each hung queue's
information. Next, driver cleans up hung queues and sends RESUME to resume
healthy queues. 

Amber Lin (8):
  drm/amdgpu: Fix gfx_hqd_mask in mes 12.1
  drm/amdgpu: Fixup boost mes detect hang array size
  drm/amdgpu: Fixup detect and reset
  drm/amdgpu: Create hqd info structure
  drm/amdgpu: Missing multi-XCC support in MES
  drm/amdgpu: Enable suspend/resume gang in mes 12.1
  drm/amdkfd: Add detect+reset hangs to GC 12.1
  drm/amdkfd: Reset queue/pipe in MES

 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  89 ++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  23 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |   2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c        |  98 ++++++++----
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 151 +++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |   1 +
 8 files changed, 306 insertions(+), 61 deletions(-)

-- 
2.43.0

