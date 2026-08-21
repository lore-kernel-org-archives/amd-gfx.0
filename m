Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7976CC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:46:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC42610F4C1;
	Fri, 21 Aug 2026 19:46:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r/veyjQ8";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F73410F4C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:46:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEO0I8KuyUWnfEmtiQXSJGvrhCvUz1lntpXIGlxBA07FZ/ukROpddwB1znmrKLVhpFqBuuWLYel1d1mmofDpRY9cQ/yT6+2M468Cd+bC8bqxHRLooiztZqN74n4RtiohaVi2d3o8EluKujf8xUiiuuPqEW71ErYpzJ4kRCLUNjI8sRJnTn90rNDYvo4+bIUMn2B5m3f8NaCKE2SiXwM39L3Pexi98EdIkANlCWANCGVyhOiMgLRFh+/DOicfv/AbCzhhr3X8aCRiSnJX1GEEY+FRa1nxOQGihyPLzVESalMNk8gRT2fKtKgZrAsfRTrOwTA8H8eBSbChc5YGBaRYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKjd2ExitzyU9HXPWzrnSDX9C63yR1JCWSf+WlseOmw=;
 b=XrVCwyIKN5FWBEqs7TpAJ0NSl+4lFwyMN4eFrC8vIHXUcuCEK9dnN+IFE2JfLRTdtqKyH3pvhhCFMiORkluKjN8g852dpkhG9iSSo+wR9Z/sVbY86rbL+lBCvJy5pIaRJq2JQP/GYMOcJH3rmNdPrupqx+w7oCVGwxv6gugBd2xts6RNoZO2sxnTHdLLkUUU6oCRniROEyaSx9RG2eNpl5PAP5QkTpEWeLtNELqXH3kG9qRA1kzzJYhhAoXpzzU8tFKa2eHbCd5R3Gj8O8xwzLMrvEn0MtAQfBbo5Cl1ZJH8suMqSz/98CwXVjjy/JoSdXPrJwwPUFoW3zpfXwncVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKjd2ExitzyU9HXPWzrnSDX9C63yR1JCWSf+WlseOmw=;
 b=r/veyjQ8+cc1OU+OkuEP3FfCr/473oKLCPchiGi0+NzJ5oBnQjOLEQF2VkPQP7QZihs9G+NiI85or43APeDjpWtMNYK7ggf8LYT4PJyO9v+x5lhAQ/bT2TOKM7BFFCCb9cyJmAFmP1FmXW8CgiIbBCs1O0BKu2GI+tHIEdSLrhc=
Received: from CH0PR03CA0418.namprd03.prod.outlook.com (2603:10b6:610:11b::19)
 by LV3PR12MB9439.namprd12.prod.outlook.com (2603:10b6:408:20e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:35:13 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::7f) by CH0PR03CA0418.outlook.office365.com
 (2603:10b6:610:11b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:11 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:11 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 00/95] Add UALink instrastructure series 1
Date: Fri, 21 Aug 2026 15:33:23 -0400
Message-ID: <20260821193458.808626-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|LV3PR12MB9439:EE_
X-MS-Office365-Filtering-Correlation-Id: 95585a4a-0ddf-4dae-3e24-08deffbb5123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|10067099003|11063799006|5023799004|56012099006|3023799007|13003099007|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: RUNncE5tLscmpcERIHBAaTq69pbYlGk359U6UtRmPhYUmDbTihBAG9pKIjfN2xfbsHysHG3v89caoyeC7LLsBKWiVpymxpV9OMGG0eD+cRwdGPWXJ3of0+cHDDMJ4G0oDlFnW+EG5a/O3z50tqgw5L05LEuErpb6wMYRPwgbf+ak5cHUK/twknUDLSRTwHAD4fP6VhMQsEhjCjZU0agXBWK6/n3O+bfv/I9j7EoNnzZXhXAuSwkOcoFZZHDrv9PcmFBUevsO5LZ3rCyH10HzbQ2lnxNJvYbFfjhHRVB9XSsJKIIlqD+8tMqnyFfHb6KgFjX7vlXwxlDRbj+UMkGOrqHMcxtkgdS67Wq1u677YRjnTOB1Bqr7nqvxYEKCzx6cyrskODuZdX9ZYEmO9+ygibdtZZv9/Ris7TbhgI1iaCi1hiJpltl5DKEb1zuQVBdGAp3Dp4WVvm9Wd3iXumewa868CS9cylb9dU2RiBZoM0bv0LDMmPH5r+znoMDZQJnF4v5N67N8ppnyW5pSHn+nq6IzJaijyvZCeLotUW/Dwd1bRtj2m3IsY5dV6rtd3fKXMrJKCA07XcWNs9WH71Mr9kZd/6Mm8c+usXEZF7VslvQhA0MjMuVs6fp5ddrFMof8nhUgaS4lDisJOPFQRD4Tz+SXph3GPJcNycrReBtSRBlaafjPl+h5J/uxLCb3btYQVileAi/GpDJckqIA71oXDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(5023799004)(56012099006)(3023799007)(13003099007)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JqKOAIo8AX7V7RUMSgR7AlUXVdK4e10ivlUHONNfwcZ38RJTd5ooN/xDIYOW/0DuLMe5UtfZf59iVZeBFrqzfJd9YZFyKX5KoP0rr65odRN+7T0MfwABLWJb73BZ/C2mYyB7qStSzjgb2XA/tumm+qGodSqgtDURueZxxytsdR+4MW+UVLLCmJJhbG6St5NIIQM5rVo9Ye6aSOFi0y32JS118OmTlM38fZAynsOBt88sZQy/UPFgBgSVG6ZrgoJMc2Ae3WZPGG8Wg3FBCM/+L3vcJiM8QgzBcz3Hb6OXl5/exA8IrAQCJPMlkcaLirYg4FvVdEqtey8WhDVwvaUChKg4Kymv8WBx7UDbw25YrEyCXRNZ8B9NQ20pEikBtbzYvU/lQ93QL2QMOSDCXP1tdCLEC6bZP0Jt1a8Ni0zhG7paRixp68PP5fcAEiyrsRml
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:11.7870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95585a4a-0ddf-4dae-3e24-08deffbb5123
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9439
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

This adds the core infrastructure for supporting UALink (Ultra Accelerator Link)
connected scale up pods. I've split this into two series, one to add the core
infrastructure, and one to expose the new IOCTL interface and add the
documentation to avoid spamming the larger audience with the implemenation
defails.  This is the first series.

This implements UALoE (UALink over Ethernet). An overview of the complete
solution can be found here:
https://www.amd.com/en/products/rackscale-solutions/helios.html

Overview

Connected GPUs in a pod can directly access the remove memory on another
GPU over UALink.  Unlike RMDA, there is no copy involved; it is direct
loads/stores over the fabric.  Shared memory can only be accessed by
a remote GPU if the memory was exported and the importer has been authorized.
For the memory to be shared, it must be part of a unified physical
address space shared between nodes.  This address space is called NPA (Nework
Physical Address) space.  This address space is partitioned between
the GPUs so that each GPU has it's own segment of the address space in which
to export its memory.  Each GPU maintains a dedicated set of page tables
for their NPA space similar to GPUVM.

Exported memory is not pinned.  The exporter may need to move memory
or make it unavailable to the importers.  This is handled via remote
TLB shootdowns on the exporter in the case of TTM evictions or MMU notifiers and
remote presense checks with retry on the importer.

To access remote memory, the driver can map NPA addresses into its per
process GPUVM page tables just like local memory.  Applications use
opaque handles to represent remote memory.  GPUs in a pod communicate
with eachother directly to exchange NPA addresses between importers
and exporters.  If a node goes offline or is reset, their peers will
clean up any remaining refrences that are lost when that happens.

User interface

Export Memory

To export memory, a handle must be created for an allocation
that can be shared with another node in the pod.  To do this
the exporter calls the GEM UALink IOCTL with the GEM handle
to the buffer it wants to export.  The IOCTL returns a
unique handle which can be shared with the remote host.

Import Memory

To import the memory, the handle from the remote node must be converted
from a unique handle to a local GEM object which represents the local reference
to the NPA space on the importer.  If the memory has already been
imported, it just returns a new reference to the existing object.  If not,
the importer queries the exporter to get the NPA address.  Once it has that
the importer can create a dma-buf to represent the NPA space used by the
allocation and that is returned to the application.

Alex Sierra (1):
  drm/amdgpu: log remote memory MTYPE for GC 12.1.0

Felix Kuehling (17):
  drm/amdgpu: Add sysfs API for UALink information
  drm/amdgpu: Add sysfs API for UALink physical pod setup
  drm/amdgpu: Add sysfs API for UALink virtual pod config
  drm/amdgpu: Add sysfs API for UALink station configuration
  drm/amdgpu: Implement PSP cmd UAL_GET_CONFIG
  drm/amdgpu: Query initial UALink config from PSP
  drm/amdgpu: Implement PSP cmd UAL_SET_PPOD_CONFIG
  drm/amdgpu: Set physical pod configuration to PSP
  drm/amdgpu: Implement PSP cmd UAL_SET_VPOD_CONFIG
  drm/amdgpu: Set virtual pod configuration to PSP
  drm/amdgpu: Implement PSP cmd UAL_SET_STATION_CONFIG
  drm/amdgpu: Set UALink station config to PSP
  drm/amdgpu: Implement PSP cmd UAL_SET_NPA_CONFIG
  drm/amdgpu: Enable/disable NPA address translation using PSP
  drm/amdgpu: Prevent double-free of drm_exec
  drm/amdgpu: Pin page tables in NPA VMs
  drm/amdgpu: Initialize NPA PT/PDs to noretry

Gangliang Xie (1):
  drm/amdgpu: add handler for nHT error

Harish Kasiviswanathan (2):
  drm/amdgpu: Add helper function to check psp xgmi ta
  drm/amdgpu: Add ual_config_state to ual_get_config

Jinzhou Su (1):
  drm/amdgpu: Fix NULL pointer issue during ualink init

Le Ma (1):
  drm/amdgpu: extend PSP command polling sleep range

Lijo Lazar (15):
  drm/amdgpu: Add psp ualink command interfaces
  drm/amdgpu: Fetch asp ualink interface version
  drm/amdgpu: Separate out ualink init sequences
  drm/amdgpu: Add ualink as separate ip block
  drm/admgpu: Seggregate ualink nht messaging
  drm/amdgpu: Assign accel state based on ASP config
  drm/amdgpu: Drop duplicate vpod check functions
  drm/amdgpu: Add support to send ASP completion
  drm/amdgpu: Add handlers for ualink notifications
  drm/amdgpu: Improve ualink state transitions
  drm/amdgpu: Use uniform logic for inband/sideband
  drm/amdgpu: Add name for ualink ip block
  drm/amdgpu: Move ualink ip version related changes
  drm/amdgpu: Add hw_fini for ualink
  drm/amdgpu: Expose ualink info under each xcp

Mukul Joshi (42):
  drm/amdgpu: Add UALink manager core infrastructure
  drm/amdgpu: Add a new NPA Address space
  drm/amdgpu: Add address allocator for NPA addresses
  drm/amdgpu: Initialize VM for NPA addr management
  drm/amdgpu: Rework VMID reservation logic
  drm/amdgpu: Reserve VMID for NPA VM
  drm/amdgpu: Use reserved VMID for NPA VM
  drm/amdgpu: Enable UALink Manager when pod becomes active
  drm/amdgpu: Create a drm client for UALink NPA BOs
  drm/amdgpu: Control NPA DMA-buf importing
  drm/amdgpu: Add ualink handle to BOs
  drm/amdgpu: Implement UALink handle export
  drm/amdgpu: Add connection state management
  drm/amdgpu: Implement UALink handle import ioctl
  drm/amdgpu: Implement mechanism to revoke exported memory
  drm/amdgpu: lock UALink import invalidation via drm_exec
  drm/amdgpu: Cleanup exported UALink handles
  drm/amdgpu: Cleanup imported UALink handles
  drm/amdgpu: Handle connection reset
  drm/amdgpu: Setup PTE mappings for NPA addresses
  drm/amdgpu: Add handling for remote interrupts
  drm/amdgpu: Send TLB shootdown on exported memory unmap
  drm/amdgpu: Handle local GPUs in UALink import
  drm/amdgpu: Add debugfs to drop UALink protocol messages
  drm/amdgpu: Temporarily disable sending remote TLB shootdowns
  drm/amdgpu: Temporarily Flush TLB on NPA mapping always
  drm/amdgpu: fix NPA-RELEASE race in UALink exporter cleanup
  drm/amdgpu: initialize UALink importer node list head
  drm/amdgpu: Fix initialization flags for UALink XAs
  drm/amdgpu: fix dma_buf leak in UALink exporter cleanup
  drm/amdgpu: Fix uninitialized fence in UALink NPA unmap
  drm/amdgpu: Use vm->last_update fence in UALink NPA unmap paths
  drm/amdgpu: always use MTYPE_UC for remote memory on GFX 12.1
  drm/amdkfd: program compute MQD coherent_aql_mtype on GFX 12.1
  drm/amdgpu: Fix GART and SDMA entity leak on vPod reconfiguration
  drm/amdgpu: Add UALink diagnostic logging for vpod commit/activation
  drm/amdgpu: Handle UALink vPod reconfiguration while ACTIVE
  drm/amdgpu: Cleanup UALink XA entries on manager stop
  drm/amdgpu: Handle concurrent UALINK handle import race
  drm/amdgpu: create UALink NPA import BO directly in the NPA domain
  drm/amdgpu: add mtype_remote module parameter
  drm/amdgpu: Honor mtype overrides for NPA remote memory

Philip Yang (15):
  drm/amdgpu: Fix UALink vPod double-activation
  drm/amdgpu: Add UALink remote state structures and API declarations
  drm/amdgpu: Add UALink NPA address layout helpers
  drm/amdgpu: Add UALink NPA address computation for ring buffers
  drm/amdgpu: Add UALink NPA VM mapping for ring buffers
  drm/amdgpu: Add UALink SDMA scheduler entities
  drm/amdgpu: Add UALink GART helpers for NPA address access
  drm/amdgpu: Add UALink ring buffer allocation and firmware init
  drm/amdgpu: Add UALink remote command packets and SDMA dispatch
  drm/amdgpu: Add UALink firmware writeback address configuration
  drm/amdgpu: Add UALink cross-GPU TLB shootdown and remote interrupt
  drm/amdgpu: Add UALink software init, teardown, and reset
  drm/amdgpu: Add UALink IH ring and enable interrupt
  drm/amdgpu: UALink use LSDMA to send remote interrupt command
  drm/amdgpu: Increase UALink soft ring size

 drivers/gpu/drm/amd/amdgpu/Makefile           |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |    5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   14 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   21 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |    5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |    7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c       |   33 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h       |   27 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h        |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c        |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |   17 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h       |    7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |   11 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |    5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  280 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |   27 +
 .../gpu/drm/amd/amdgpu/amdgpu_res_cursor.h    |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    | 6174 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h    |  421 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |   44 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     |   29 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c       |    6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h       |    7 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |    2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |    2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |    2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c        |   51 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |    2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |    2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |    2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |    2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |    4 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |    5 +
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   26 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c        |   98 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.h        |    1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |    6 +
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |    6 +
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |    6 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |    6 +
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          |    8 +
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h       |  162 +
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_8.c      |   48 +-
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         |    6 -
 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c      |  143 +
 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.h      |   30 +
 .../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    |    7 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |    8 +-
 drivers/gpu/drm/amd/include/amd_shared.h      |    2 +
 .../ivsrcid/mpnht/irqsrcs_mpnht_15_0.h        |   30 +
 drivers/gpu/drm/amd/include/v12_structs.h     |    2 +-
 include/drm/ttm/ttm_resource.h                |    2 +-
 include/uapi/drm/amdgpu_drm.h                 |    6 +
 58 files changed, 7782 insertions(+), 69 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.h
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/mpnht/irqsrcs_mpnht_15_0.h

-- 
2.55.0

