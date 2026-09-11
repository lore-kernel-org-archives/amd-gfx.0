Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDACC88E53
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 17:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4426910F208;
	Fri, 11 Sep 2026 17:56:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UlGxX/qH";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012030.outbound.protection.outlook.com
 [40.107.200.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83B2B10E4CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 17:56:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWW4DoOGP2tT8I5gnEvtbGsIsTmhart61DwXqim1Rec0wg6aB/acQVVpYDxZQQeepvHHc9wALjrhpelCdlcjiFQAYxUKYfsgFE1hPksSZtlwonXMUD0cR9xW6MbMvHzqhocFdL+uZAdCk5drwhi1ebFQlvLFi6jc69qaEtqJybllD9hRLm8mh9ubIOhuvb5yVF2HHQarOia83+y0O88iM7HWIMYptnbt3UuhSAFs9KzZkLRDGk7Zky+Qcf0iF25DVkCK1HHfCefcTyjvlbJJUqjgKPp/hhiiWhQjGPpKqRkmGqdj+DmSf43ID2mI02/rHFSc80K4kxEVGZ3TXng8Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLLN+hwS/anUnwEu+ltOr0gL7jRXd6/GriseW0816yg=;
 b=SjiVca3LUALkHhJbaMQyacnvibj4hiw/iu/isReqn8qjEUXwg/z9jdolhZetwfO33OPHQiFuiOVAQgDWPBSTEDqQRbikAXTv89hjM/KhmEvpmUmwkEpZPqDpd+byNtYXPmtxrEbe1FZFgFu4GWDCG+arQ9MkQxoz/g7vX8Scrh8aanpPe2NbIledZ9fSgWUj52yFDoED1Q9meP9xtP/OAXzor6h7M3Tv6TO1wsqmxKJ5yNiz+V6vhalY0Fnn1vVoFaDbCysibUKW/WfnBdWX91msquhUxfpPQZdEjU5AE610teqQ7J6KP3QNZbbYeZlKwTy/egwX9snWzoGNJqMePg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLLN+hwS/anUnwEu+ltOr0gL7jRXd6/GriseW0816yg=;
 b=UlGxX/qHSz6CZSLdJpfHuCaA6Jw2QdMaJzY1ln2ATTo578CKvqb0CXqZE/I+GtLjZxOGofTxtjgAb7oHEgGj3HuTI0WYD3AALGxrJVvsWtXZrYQWOywDyI7Nzc/V3GwWHuPZwePL4KzOnztfMPfeG2Dp/Tx9KIDw7Y8f5rqmqSM=
Received: from BN9PR03CA0152.namprd03.prod.outlook.com (2603:10b6:408:f4::7)
 by DS4PR12MB9611.namprd12.prod.outlook.com (2603:10b6:8:277::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 17:56:02 +0000
Received: from BN1PEPF00018071.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::1d) by BN9PR03CA0152.outlook.office365.com
 (2603:10b6:408:f4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 17:55:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018071.mail.protection.outlook.com (10.167.245.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 17:55:56 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:55:55 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 12:55:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V3 00/23] Rework GPU TLB invalidation
Date: Fri, 11 Sep 2026 13:55:21 -0400
Message-ID: <20260911175544.1314467-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018071:EE_|DS4PR12MB9611:EE_
X-MS-Office365-Filtering-Correlation-Id: a13e3929-d02e-40f7-2637-08df102deded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|13003099007|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: LwrVOnkOUU21GTkvJVKMyhoV4jv8nmFc5q1SQhIQ5PS4zHPcydRBel/yLjSZbYz1alMR33VUo3W+ifLaPO8dqslLTBpq638q4iND5kOblyk/Vwv0nPZ6lv33SXKYynJ8NQ18N50C4+7cn76tfxmbeMOKBWWgd4KhedgCZlJYBwSM8qrjXmaVUMIUi0+2O8OlubPIHFIuzvTxmTbPyYfTB9O4FrA17TGzAJkB3RVe7DLcyjR4+yLk3DnBOhlsl7S0E6g5v/VMzkqT8gjmzV58VqJq95q+gI7/Qt6Ms+iNr2+ZGDnSFNq2gNj9MuGx3Ey5uSe8qE6JyiMdKscMc4JgwCRZ9OQH7T9a4OF43pqvS4+3HL8sIQGIjob9/QqZjRG+YdDPlS/DWD0LX0F9yFF2I2RKFE6ao4a2gZCYF3F5Udgxo4NdwCnnPP1USHNMJnGQick5BMVVXW9lKjBHwhSSpi+IjWdeO5SYk9LmsvT93BoDUlSr1mrzLX0xphs+yrURFA0j6j0MHmlAG3HlHE8GU3tBHPDNBa0Wo2QE2hAldlzpZJZZtUKUBxN506d8O4iTJ3Dozkt7JV8t0LrOxFQqQl2pk0UQMC6n3agD8UBntE0aOVJAajrQz1tv/xmD6XVBsq2kwISyZLQ0t0NaTa8aYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(13003099007)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o64q9/mToy+5NXLA9ATaz659uG2gAUaridfPF7NP1DhhYv8A0qWIVr8cjfDCdrBZFi1gBzPdJMvyjGqa/1E1YM2mE97RHuWHBpipSWCsvPeZCcSyQ4nhs1/94kS2FEQx44cBX5nN5Hjajfh4+ev5UKrQs7WS2rWd3u3/Qm+jIFV8KSNzPrQ5ryzv7ZwW/NSyIqSIbMWuk5RuemQe39IXrdVfH9iL1F97EBklq3ON855nDZ67Mtl1+LBX844+ZggoRxFORA6e4bul4ZebwURS8tZUiSpFaHyJMOLkjXawbFdQM3GgziKQ/UmN0bFjHfypqaqljHvFss9+e/xY3rRUmYZVmgdVGNLXldZFwJq8Cx4lQ4EvSsezvd4UbmK4QsMaudrD1iNTQwr1p7UaucbRrqydicdHZNjjobqpvekuX7J4eJ3QqEsqC4EevAB2lcBk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:55:56.0791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a13e3929-d02e-40f7-2637-08df102deded
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9611
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

This departs a bit from the first two revisions.  This
series is split into two parts:
1. Patches 1-17: clean up the duplicated code across
GMC 9-12 and move most of it to common GMC code.  No
intended functional change.  It also adds an new SDMA
invalidation path which is unused until the second part
of the series.
2. Patches 18-23: switch to using SDMA (or MES) for invalidations
on GMC 10-12.  Conditions that currently use MES continue to
use MES.  Using SDMA for the other cases aligns with the hubs
team's advice and what other OSes do.

I think part 1 is a worthwile cleanup, part 2 is open to debate.

Code is available on this branch as well:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/tlb_inv_rework?ref_type=heads

V2:
- Add missing hub callbacks in gmc9 hubs
V3:
- Move the code clean up to the start drop
  most of the behavior changes.


*** BLURB HERE ***

Alex Deucher (23):
  drm/amdgpu/gmc9: disallow gfxoff around TLB flushes
  drm/amdgpu/gmc10: disallow gfxoff around TLB flushes
  drm/amdgpu/gmc11: disallow gfxoff around TLB flushes
  drm/amdgpu/gmc12: disallow gfxoff around TLB flushes
  drm/amdgpu/gmc9: set vmhub funcs for gfxhub and mmhub
  drm/amdgpu: add a buffer funcs callback for TLB invalidation
  drm/amdgpu/sdma5.0: add tlb invalidation buffer func callback
  drm/amdgpu/sdma5.2: add tlb invalidation buffer func callback
  drm/amdgpu/sdma6: add tlb invalidation buffer func callback
  drm/amdgpu/sdma7: add tlb invalidation buffer func callback
  drm/amdgpu: add tlb invalidation method enum
  drm/amdgpu: plumb tlb inv method in amdgpu_gmc_flush_gpu_tlb()
  drm/amdgpu: uplevel reset check in amdgpu_gmc_flush_gpu_tlb()
  drm/amdgpu/gmc: add new callback to lookup vmid to pasid mapping
  drm/amdgpu: add a gmc callback for the inv semaphore
  drm/amdgpu/gmc: rework pasid flushing
  drm/amdgpu/gmc: add helpers for various tlb inv functions
  drm/amdgpu/gmc10: use SDMA for gart TLB invalidation
  drm/amdgpu/gmc11: use SDMA for gart TLB invalidation
  drm/amdgpu/gmc12: use SDMA for gart TLB invalidation
  drm/amdgpu/gmc10: use SDMA for pasid TLB invalidation
  drm/amdgpu/gmc11: use SDMA for pasid TLB invalidation
  drm/amdgpu/gmc12: use MES or SDMA for pasid TLB invalidation

 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 474 ++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  27 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  18 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |   2 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c |  33 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c |  33 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 199 +---------
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c   | 204 +---------
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c   | 237 +-----------
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c   | 224 +----------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 127 +-----
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   |   4 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c   |   4 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c  |  33 ++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  |  32 ++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  |  32 ++
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c  |  32 ++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  49 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  49 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  49 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  48 +++
 21 files changed, 909 insertions(+), 1001 deletions(-)

-- 
2.55.0

