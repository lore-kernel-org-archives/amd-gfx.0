Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC63C61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F81710E1DE;
	Mon, 31 Aug 2026 18:28:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aHcDJzU6";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010066.outbound.protection.outlook.com
 [52.101.193.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 889FB10E1AE
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUG7p1qte/RdEfUCW7hcKCFCLi3ziZy/KxKMFb5otfjw8bsMW39sr0LlBPjP6nUJ1b9qfbRBofxYlv2rb+4wGCo91VgJMGLwrtpa4UF0pvjBcqfAUj8rgBAuWJErJfS/fwjD2Sd5py/PJOJlXhke1gsfnhyP/12ToePhTZtIVdEIQaaVPHMJn/+gvFhFpD5wA2Zzi+7KuTwKawyyP1tkZxF8zuWGLflaVCosAtZPmVnTM86bCm+hz4xisLuS2rs6KtlYs9uTDyF0zbklrjIyzSN0s4YIs8KO6kbSkdwsRfH9tVDGCy8wGwLUxfH98DIGJIQTtljW1mV5iiKIOoZZzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAbU+ewmb0aArPmkNcMW8jJoDmWqbczRgdKbIW9E5uE=;
 b=abE2KhhwOtwTNjGatJlnYwtrVIpBUsAc4VFqzWIdmEelWUE91pkysKtKKY2V0WH5InzSsxFJA2meuPDfhA9+Rmji7sTVwCwYRJgGDHMTT93awKjwapuKtM97rfmz7O9EUZN/Wmt0VLI6aZKSaDo37vFT0Em0kXmGm79VpYgs2uFRBdhR3eUHrn5PmpQUS1sHH3ENr2kDeZ6nPYAAlf1XMyMJQXTyM4lEu3omRX7h4DouzqzBAFN/AovmAPx2cso8rV9uO+zYBnaF2rmJxGY6L0ptxtmBYMXK5+LjU57MazHuoNUW0ze/hil98B21CdxEt2OuQwWKOTQNAKbm68m7xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAbU+ewmb0aArPmkNcMW8jJoDmWqbczRgdKbIW9E5uE=;
 b=aHcDJzU65wehu8h3P6GuQf6bxdnYV/G3j//y8Ol2WY7WKQxLvNR/P34r5n7wwv72s7F5BqR42Q26R9m+3Tm7/3tsech15nkwnCYc0TSFgi0AZ+YDWjEjvskQNkzAZJtNAm6IHdboquJv9bZYn4WQ4niz0I1QgfNu1bqzpykSWQw=
Received: from PH1PEPF0001330B.namprd07.prod.outlook.com (2603:10b6:518:1::1a)
 by IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:13 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2a01:111:f403:c801::2) by PH1PEPF0001330B.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:06 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V2 00/95] Add UALink infrastructure series 1
Date: Mon, 31 Aug 2026 14:26:19 -0400
Message-ID: <20260831182754.1089811-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|IA1PR12MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3e0cc7-5b31-4dc3-2658-08df078d9c75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|5023799004|6133799003|3023799007|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: TNduC43b5OJg/uVhlBSHxe2dP0Xtj81gPb4heUxN5aMD2OgNA2V+K+/I7hJjh/pftKrYNV9Dd7+W+gAPkouPQLq97KXwhUZ4N/SerxZnrkqiycFcvbAdP4lKfedASmefAebE9N0SkVNrN/r1Xef+qLzWPZPK3VZsTs1ArWiCq//i/wCMznuBIZlEW6P6xEerI+L+Js6LCpmoIkloqn0dknrWaVguJ41PIKaWPcCdHlsVdBi2nfYVNU6RI9PolODy7m0HFof3Bjb7r4QJYtH+QWz4hV5Onoyk5Jkml0DgE6QN7jJxCJiFpxbO571PtmXv7mElnkjv8fBMDDlxpYoOYj2/n99GiQfpQ9VdVP2TTlFj9zp+vFZvpLEC4FvsDSgEZsi7UsPUaFZC5yfv9KpvQXj+WaSHqAkiOItwzlwkij8n/taUhlDDb2RxA/x4Ss701bdaiUYomt6LL3KrcjJHgenMIoJnxsC4Ex0mljvPpdq+PWaGgXkTIviok6xJOO10PU36jWR1NfmwQ7AYtniKf6PPjvU+VO6SSLezon3bVGG8xhzOj3pIhZ1yZ/8qwYnsFQKcI5/XlwE2H01mZy/nGc0SnPlFpm56WhU7GwDXEyHZWlLgmtk5G6PEDO9R8QXq2cc8NSA/1Beonry8foHkBCw0zGts3aGSjsR2niChX8Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(5023799004)(6133799003)(3023799007)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E6kWpSoPruvn05cQFxpLQlMVSPck9/YN5lGlpds004OP/RL10CG9Vi3kbwE71QDNLlxcHERDIiAOCBC9KXEemv7GjsNOfBY0D5STYYa+C5WoTtpNuj3BIPOhdzjFMgDHc18unN0epuHcWrDUtqwPW+izvaFwUfLZXvaKA7kB4OavtOUm/e7c99gcj6wrm6WAYADGlZoIKZzfLb/DNCqSCGN7iLKI2B1Q2VLbz7jGANTOA3GQsWLfitu8gw5x3zi8FgCk4rB1ijyVXyFFQx3ehDrhOUUm1eAH+nwvZ2vjmrfNWZboCUOxxbDKmWXACD3nwR5TWQTfJEUgiy8vpYr2dkkr0rICZGqFuaxttPgkU3/nIKqpQp6+lx78hMUCWuhLd3nc8sohlMsX3epgxnyjyhb9MMZGkoMxRJXw2/tvk05l1vjEPcKw807OqUOJMMxZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:10.5985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3e0cc7-5b31-4dc3-2658-08df078d9c75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712
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

Exported memory is pinned.  This is similar to how dma-bufs in VRAM are pinned
for P2P access.  Remote TLB shootdowns from the exporter are used when the
exported memory is freed in order to remove access by remote GPUs.

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

This and the series 2 patches can be found here:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/ualink?ref_type=heads

V2:
- #ifdef the sysfs ualink configuration API.  It will be configured via
out of band tooling.  This code will be dropped in the near future.
- fix 32 bit build

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    | 6222 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h    |  425 ++
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
 58 files changed, 7834 insertions(+), 69 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.h
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/mpnht/irqsrcs_mpnht_15_0.h

-- 
2.55.0

