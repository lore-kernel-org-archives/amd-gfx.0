Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE47C61DD3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CE3F10EECF;
	Tue,  1 Sep 2026 20:10:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rpWsqBDu";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011012.outbound.protection.outlook.com [40.107.208.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B11AE10EECB
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:10:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F04AifNvEVsBHtMjPQ76d3pZMCgIu3YgGRa4jW6jVYZWGOFGs3cr/9W53DYYMotzCAOPw9bF3YG7+o5sAL8IiMvihFwLZLk2LILy2rBO+iLFEl8wLxZeVjtNdTWhmtrmQNRFAlaGBDmURmlRJ2dWT9tkdQ+R58R+Pi73hyexdgCOH5SjBom6K6cN04lErk0VJCHypttnix9C+XqL8VVaZHJoP/CscVEpgDc2Re9970LDcrP2C7a/TYrnfVzU1Z7147RNB9TTAj1ZOBrcuApTDl2OvsoOCYCjkY++R8tqLiFU205mR+7QGAfINGF2kXTZi4nIg6QGd9pr5vOH4dWhAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFsY7L8XcmJKdGANPk/jtcipKx6vnGBBb5TDqd7+AXA=;
 b=Vbp7OMuZcWJTi75C7ZQDNz4+YcJs6EnnlJuN0nF0FopeDw3VigHkqN5A8CClHZwRVJGMR0tMG4czd6g4oSo3jZVsfRS4XpxZFOAnpH6gU1KhA8DeWug8ZHmtr68DTl60QTx6iTwv+8uX9+/Wrjqb85MbS+SsDTYdH2Rt1kg+aSfoBYyGi5QCp0aptIxpsJCupyXTCckwQhghr7yNcyGWpqTUte8WFohVUbwK1j+LY9Gd2Z0hOI8LJeT5xrrnq3TYHKXyDDXCmdU5TD8fndfQC3gujxvFmUH3Ags06kztgSZU0TDjbRXPn3d2JKDcktodhuatR9aWfOl+o6srucn3dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFsY7L8XcmJKdGANPk/jtcipKx6vnGBBb5TDqd7+AXA=;
 b=rpWsqBDupzLfAAX/eTYcc13qs+SFx3aX6Zr454Dg2vmlJXihI4Ig6aFMtBg/WpBTL1M0PhMC0X/AFPrBMaJGhIVao7crsS8/ru9iOr9WIPm5Dfk6pnYKj4/DS0B6WGLauJZ2WYZL6M6mbwp57B/Q5tah8lxXio8cH3asX5wcC4E=
Received: from CH0PR13CA0051.namprd13.prod.outlook.com (2603:10b6:610:b2::26)
 by CY8PR12MB7436.namprd12.prod.outlook.com (2603:10b6:930:50::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Tue, 1 Sep
 2026 20:10:48 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::30) by CH0PR13CA0051.outlook.office365.com
 (2603:10b6:610:b2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:10:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:10:48 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:47 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:47 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:10:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V2 00/31] Rework GPU TLB invalidation
Date: Tue, 1 Sep 2026 16:10:03 -0400
Message-ID: <20260901201034.2960437-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|CY8PR12MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e7225b-f474-4095-3874-08df08651cf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: +Dp4585EpjXzrKIXwjSAVqsEBvOEfFO0viE1/YeP6b1Kr5zjnEaf+N4KmxyU6Xr57v08LsKf0rIRxaRlFZn7ew1WRtYfwFrfp2t+sjERZI8IytJb8ZZWuZueIOdax7SfQ8ax91dyvrHunyXJAC4hr0jhdI9Attuh/Rtj/5r1JbfRgrnL7geLnWS8a2w6ty2+SO8kE3cpD4fV7aDWy58Ni2i8WSG2nevBdFKlR70NM0UlSXvhnhh5l/3Gw4PyCRCZKpOl5rP9OfYoa4IXgikUipw6ZXqPx9rObv+fNdeuEft92TmIECfhDgg6UHKyqVM2P+q7Ju+p4I3HiHgQomsBxVehyvV+AraLVKoVVlDsGK602Pd5xS1OBXnUXVFBum8nsWgAhKvMOqZmaEfZYNT35M/FwVLjdcaKsZaGXw/V1kuO/IeF4er3ZIIxuIUdVw19Te4v+JWgWF2nSeNlxHsOv+5pdkB9xs1pANpubrl9oYhn2a4ollz3CcFggjmAVqfLUf4hXMNu2KgLvD0PZcZED86XNtGnfLJ4ODEk8B9xxAj1wrbhfSK8xoRNHSwrr0jAmuKGEaX9pCul7pAhVSfDqOyBZxeeR6R82BIwjLymq81E0VfwVIT0qU1UxjxEma5Hy/SBaFzNNnTaxZda1uFr2bMjTSoq2ozZY2e/mCvtSx4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NqCFv6p9Gj3bRofpIv6qTACJ51DFuCbO9UXnD2RleVV5xN4q7rgDLqM69l20C6mizPmr5nh2t+Mi5Q1AwILu3jxmD+tQthX0iaNrgk5/h4N7DauDyt7Hxy35Z0Pcl+bDdUsg3E34CoAJueFT8HHfzu276g0Ky9wVnyyW4fVOnggideKG/vQlw/EK/AYr9J1coa2k/fnO7BNo3iAEVIOEFoZlL67ovlpz5v6dl+H8wbB91qHSwLc1WJDvBCefeA0UirOEHJw1wuNY8Y6M3po7MIOwSnpAp4Xua1TMISfBGRleUyBmFLBmHUVliFIjvZ6wzhGHTqN5rcGbpJIEzvDdZvozIzWO0342PTPR+PPyhIeuU8SRUpmvUoUMG2zbJSnAjUnMfJ3Twr+tHreVTOs0qO7Vd9tuht6gRlTwHl5ndlqgqkMgS++NwrAjozAvBk4u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:10:48.0203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e7225b-f474-4095-3874-08df08651cf8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7436
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

GMC 9-12 use KIQ or MES for TLB invalidations to avoid using MMIO which would
require disallowing GFXOFF.  KIQ and MES are management queues however and if
they hang, they cannot be recovered by a queue reset since they are the
mechanisms which handle queue resets.  Since using KIQ or MES will exit GFXOFF
anyway, explicitly disallow it on the MMIO path and use that. Next, switch to
using SDMA for TLB invalidations.  SDMA 4.4.x and newer have special packets
specifically for this purpose.  If SDMA hangs while doing the invalidation for
some reason, it's easier to reset the SDMA queue than KIQ or MES.  Finally,
most of the TLB invalidation code between GMC 9 through 12 was identical, so
move it to common GMC helpers and remove the IP specific code.  If the SMDA
and MMIO pathes prove to be stable, the KIQ pathes can be removed in the future
to further simplify things. SDMA 4.x could also be updated to support PASID
invalidation via SDMA using either the new packet (SDMA 4.4.x) or via
REG_WRITE/REG_WAIT packets (SDMA 4.0.x).

Code is available on this branch as well:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/tlb_inv_rework?ref_type=heads

V2:
- Add missing hub callbacks in gmc9 hubs

Alex Deucher (31):
  drm/amdgpu/gmc9: disallow gfxoff around TLB flushes
  drm/amdgpu/gmc10: disallow gfxoff around TLB flushes
  drm/amdgpu/gmc11: disallow gfxoff around TLB flushes
  drm/amdgpu/gmc12: disallow gfxoff around TLB flushes
  drm/amdgpu/gmc9: set vmhub funcs for gfxhub and mmhub
  drm/amdgpu: add a gmc flag for using MMIO for TLB flush
  drm/amdgpu/gmc9: use MMIO for TLB flushes
  drm/amdgpu/gmc10: use MMIO for TLB flushes
  drm/amdgpu/gmc11: use MMIO for TLB flushes
  drm/amdgpu/gmc12: use MMIO for TLB flushes
  drm/amdgpu: add a buffer funcs callback for TLB invalidation
  drm/amdgpu/sdma5.0: add tlb invalidation buffer func callback
  drm/amdgpu/sdma5.2: add tlb invalidation buffer func callback
  drm/amdgpu/sdma6: add tlb invalidation buffer func callback
  drm/amdgpu/sdma7: add tlb invalidation buffer func callback
  drm/amdgpu: simplify amdgpu_gmc_flush_gpu_tlb()
  drm/amdgpu: add tlb invalidation method enum
  drm/amdgpu: plumb tlb inv method in amdgpu_gmc_flush_gpu_tlb_gart()
  drm/amdgpu: uplevel reset check in amdgpu_gmc_flush_gpu_tlb_gart()
  drm/amdgpu/gmc: add new callback to lookup vmid to pasid mapping
  drm/amdgpu: add a gmc callback for the inv semaphore
  drm/amdgpu/gmc: rework pasid flushing
  drm/amdgpu/gmc9: use SDMA for gart TLB invalidation
  drm/amdgpu/gmc10: use SDMA for gart TLB invalidation
  drm/amdgpu/gmc11: use SDMA for gart TLB invalidation
  drm/amdgpu/gmc12: use SDMA for gart TLB invalidation
  drm/amdgpu/gmc10: use SDMA for pasid TLB invalidation
  drm/amdgpu/gmc11: use SDMA for pasid TLB invalidation
  drm/amdgpu/gmc12: use MES or SDMA for pasid TLB invalidation
  drm/amdgpu/gmc12: drop MES tlb inv in gmc callbacks
  drm/amdgpu/gmc: add helpers for various tlb inv functions

 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 486 +++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  33 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  18 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |   2 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c |  33 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c |  33 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 202 +---------
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c   | 207 +---------
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c   | 250 ++----------
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c   | 225 +----------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 135 ++-----
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
 22 files changed, 943 insertions(+), 1015 deletions(-)

-- 
2.55.0

