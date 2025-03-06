Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F997C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 15:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DEED10E242;
	Thu,  6 Mar 2025 15:54:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x8DxFCTW";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02EE110E9DA
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 15:53:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEkBQEMenctgv03Z01Tb+gMsTR+r5BmlyvjOSJ5F5RLQzjdsQs8KHPXH31ZwapgixoHJyqBNt4EJVZeTPnzZOipAELU/jwKG/DskpOElxKChwgIjMupBfTgB11E/Rw1Ua8a2BqS+0GDNWb3dLiptpHcLSjynoGDJpCzmOmV+1eSCVbP9XYSDRwg8myTN2K1s/AGR/Op+P/NoPANkYnrV5lvDpgNWsMWlAZE6CsmGn4yHF1mOhvpVX5NDMxqCM5xfH2KeVR3aGwIOQTOgM0k8siAIvzR1rgkegiVmXLQBwn2s7Q4T2GCEnKoHVUSfPbZ3/lY/kSHEkqkr9aBiKhyZ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1afTYno97MwSFbXqXYmkEVI0W/XbDgDYLel3p6Konzo=;
 b=Ee4UErbwyhSYGAvcVKRU9FgBPYeGVpV3sG7jMAbAnFO1o5a9oECPJEu45YYer65belWRGoL627rdQxqtB4E0vY7D+0GfQPa/si6YNMl3LpfaVXyTGonH0s87Zy67wUK072Tsr0X64WtPLLKGm8Zn8K89kL1OLOn9PPfUAkmSAeqg7BFVMR3ePkhbQIK0H4ACWo4JOwG+qScHuIG/AIYAowB5Bdi1F4bST3sX6BfKCipHkDBfCDRTzI6jralgLa0Jm9WOA/WJnhJ6hyjapiZQXb5UyDKlJnoPbyk1UGXTyIha/zq88PwdTG5D2nmITk9XOJxpmZoTVdLRiLriXZPzxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1afTYno97MwSFbXqXYmkEVI0W/XbDgDYLel3p6Konzo=;
 b=x8DxFCTWyTgajb/zZ9dCaAzhGWvo5oVgGf6XK7YpskBs+ZQl5RCsLg+S1Ol2QtEGpB5gM8kZQZnvCSaG0gRvtdV7zwoo4qdK6lxfSkwd9GYWN5BAD/gV58YQKRUaj2ke42ZP/JUT0QilCSE+mb375K3dl4+Qozhm8fAuetT5u3o=
Received: from BYAPR08CA0044.namprd08.prod.outlook.com (2603:10b6:a03:117::21)
 by SA1PR12MB6894.namprd12.prod.outlook.com (2603:10b6:806:24d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 15:53:57 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a03:117:cafe::da) by BYAPR08CA0044.outlook.office365.com
 (2603:10b6:a03:117::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Thu,
 6 Mar 2025 15:53:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 15:53:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 09:53:55 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add initial documentation for debugfs files
Date: Thu, 6 Mar 2025 10:53:41 -0500
Message-ID: <20250306155341.1770809-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|SA1PR12MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: f32c169a-189c-4b87-a7be-08dd5cc71a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d7lKORqo1iiX9xjoRgcbXnQ+9A7tAFrfsyPzw6sgwTbE0JkonlzKaGZj8jjy?=
 =?us-ascii?Q?v5SdP61v9eE+rnAKGCAgaGCKjjLmoJ14h239FJXB9FMF3wQfZ9X+sDoAVj0O?=
 =?us-ascii?Q?B9anl4atamGk1DziFjcun7z2uFqqwm2eeIlBKSwDJpWBCA36b5zMV74HAZRQ?=
 =?us-ascii?Q?MpeCc6SumBX1M4mh0M6Nz8BGYQbCPoDXOj/2BteTtf91bxU4GR2Syx2UTC1i?=
 =?us-ascii?Q?d3FZxg3W5Flp8SV1LDxI+46dJTyv2MmjWCLVgkDUf5AnHsA5y3VMv8KsLtSs?=
 =?us-ascii?Q?mqXptmYjgdxIOWFRbtMbSL03twv9NG/3m3edojshNFDpagv3Fvjv1vW7AzRJ?=
 =?us-ascii?Q?o9JgnI6yRpuold9fvktWSZ/HHe1uLMCDonk0XuQpj2F5YstZlm8W7GRZN/ax?=
 =?us-ascii?Q?eQHMoxRMA1Swy6y2kppD3NFfcFb9Gika1U49wDESMuh6ejiOtUMxQ9OIfL6s?=
 =?us-ascii?Q?vfbNzLaNBOfSG4d6Pm5vFw8PXO1zr9u5+r69TAcD1A/cBtT29OQeCkIYB857?=
 =?us-ascii?Q?kCyiw5+dmUD2eaJFOYavOTbtFrAeNiuI5HBLcFkL5rCOyd7uz+rw0WkImgBd?=
 =?us-ascii?Q?Ezs7BeyjOS4PU+VO7CxSrCiT5xxuG6puX+d6+1Ip8LCgfpAVHEP0BM+nvMZ3?=
 =?us-ascii?Q?bkdB9hHqC/iKxKGmDJFOnmWxWvp+0wkdOOig/iiLv4xqEG4KxHuLWeYFvnEQ?=
 =?us-ascii?Q?dpblZGefs8aKJFi0wxLcHJByoqsHUgJR47NPET01zbNsDHP9/q3Fwoo4xXz/?=
 =?us-ascii?Q?PNCRMBm5L2kFw1yIC4urPOrIJzLoM5W1+9Zi8X/PaGsu2L+SkGqR7Fu+4BKN?=
 =?us-ascii?Q?G/lws24mD6ypUyOSGv9Z4cqZ79+MXPkfva+tIUJXjZxKbSzOPz3tjFZwDs+e?=
 =?us-ascii?Q?Z54U8TygNdvqGpmHbGagClehHKTU+dG3nidtOZzhhb4fBRQ+ggnY8NYFsm4G?=
 =?us-ascii?Q?9WEaSjJlD7tZFqnuplQTA4+34rvofbV7YMQhl797XTCPfXMRL7em0YYCTiYl?=
 =?us-ascii?Q?zXplHPItQlqKoEI4BxHxGTV6tr5V0Ee5kfpr/5c/GkI7U7dhrS0ocyKnWlOq?=
 =?us-ascii?Q?rXCRZI5L3hwZLvL6ixigPd+Om4H6NQDzZlb0VOGY+rsyofILgb2tf8S3xgJH?=
 =?us-ascii?Q?Sr7l+2aWWYd28eSBcqJePXLN36+JO0tf0sRQ9GHczknbChwLwE4XZPhzNUaw?=
 =?us-ascii?Q?1Z34nMMIx4cL++IQ7qtpIP04PIJbOsJEuGP0FGXldABfPGbh99CTIvvVM+zL?=
 =?us-ascii?Q?dKqbP/E6HKALFpRT39aHZiZTK5J0A3RJgO8JAK2jni6htXU534uLkIYqFYiN?=
 =?us-ascii?Q?+vcbg8GN76CRjA4JhtX7mqyxe3Aypg5RHGAwZPmXmqwUfyYSrrlKf5y75GmB?=
 =?us-ascii?Q?kQ0BRbvPIalPJ/d+fmLbpZNxRmBzHiP9+82j7t458MZ+Jz4XCTStt8cJRQ1y?=
 =?us-ascii?Q?D9emWSB+YdOruwCJvR0nNqF/q9XYcHwVPSkiMXASioQnzqMx+Kb/cfsPa6Xo?=
 =?us-ascii?Q?Jt82/7IO6cmhDzs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 15:53:56.1944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f32c169a-189c-4b87-a7be-08dd5cc71a29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6894
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

Describes what debugfs files are available and what
they are used for.

v2: fix some typos (Mark Glines)
v3: Address comments from Siqueira and Kent

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/gpu/amdgpu/debugfs.rst   | 210 +++++++++++++++++++++++++
 Documentation/gpu/amdgpu/debugging.rst |   7 +
 Documentation/gpu/amdgpu/index.rst     |   1 +
 3 files changed, 218 insertions(+)
 create mode 100644 Documentation/gpu/amdgpu/debugfs.rst

diff --git a/Documentation/gpu/amdgpu/debugfs.rst b/Documentation/gpu/amdgpu/debugfs.rst
new file mode 100644
index 0000000000000..fdfc1a8773c72
--- /dev/null
+++ b/Documentation/gpu/amdgpu/debugfs.rst
@@ -0,0 +1,210 @@
+==============
+AMDGPU DebugFS
+==============
+
+The amdgpu driver provides a number of debugfs files to aid in debugging
+issues in the driver.  Thse are usually found in
+/sys/kernel/debug/dri/<num>.
+
+DebugFS Files
+=============
+
+amdgpu_benchmark
+----------------
+
+Run benchmarks using the DMA engine the driver uses for GPU memory paging.
+Write a number to the file to run the test.  The results are written to the
+kernel log.  VRAM is on device memory (dGPUs) or cave out (APUs) and GTT
+(Graphics Translation Tables) is system memory that is accessible by the GPU.
+The following tests are available:
+
+- 1: simple test, VRAM to GTT and GTT to VRAM
+- 2: simple test, VRAM to VRAM
+- 3: GTT to VRAM, buffer size sweep, powers of 2
+- 4: VRAM to GTT, buffer size sweep, powers of 2
+- 5: VRAM to VRAM, buffer size sweep, powers of 2
+- 6: GTT to VRAM, buffer size sweep, common display sizes
+- 7: VRAM to GTT, buffer size sweep, common display sizes
+- 8: VRAM to VRAM, buffer size sweep, common display sizes
+
+amdgpu_test_ib
+--------------
+
+Read this file to run simple IB (Indirect Buffer) tests on all kernel managed
+rings.  IBs are command buffers usually generated by userspace applications
+which are submitted to the kernel for execution on an particular GPU engine.
+This just runs the simple IB tests included in the kernel.  These tests
+are engine specific and verify that IB submission works.
+
+amdgpu_discovery
+----------------
+
+Provides raw access to the IP discovery binary provided by the GPU.  Read this
+file to acess the raw binary.  This is useful for verifying the contents of
+the IP discovery table.  It is chip specific.
+
+amdgpu_vbios
+------------
+
+Provides raw access to the ROM binary image from the GPU.  Read this file to
+access the raw binary.  This is useful for verifying the contents of the
+video BIOS ROM.  It is board specific.
+
+amdgpu_evict_gtt
+----------------
+
+Evict all buffers from the GTT memory pool.  Read this file to evict all
+buffers from this pool.
+
+amdgpu_evict_vram
+-----------------
+
+Evict all buffers from the VRAM memory pool.  Read this file to evict all
+buffers from this pool.
+
+amdgpu_gpu_recover
+------------------
+
+Trigger a GPU reset.  Read this file to trigger reset the entire GPU.
+All work currently running  on the GPU will be lost.
+
+amdgpu_ring_<name>
+------------------
+
+Provides read access to the kernel managed ring buffers for each ring <name>.
+These are useful for debugging problems on a particular ring.  The ring buffer
+is how the CPU sends commands to the GPU.  The CPU writes commands into the
+buffer and then asks the GPU engine to process it.  This is the raw binary
+contents of the ring buffer.  Use a tool like UMR to decode the rings into human
+readable form.
+
+amdgpu_mqd_<name>
+-----------------
+
+Provides read access to the kernel managed MQD (Memory Queue Descriptor) for
+ring <name> managed by the kernel driver.  MQDs define the features of the ring
+and are used to store the ring's state when it is not connected to hardware.
+The driver writes the requested ring features and metadata (GPU addresses of
+the ring itself and associated buffers) to the MQD and the firmware uses the MQD
+to populate the hardware when the ring is mapped to a hardware slot.  Only
+available on engines which use MQDs.  This provides access to the raw MQD
+binary.
+
+amdgpu_error_<name>
+-------------------
+
+Provides an interface to set an error code on the dma fences associated with
+ring <name>.  The error code specified is propogated to all fences associated
+with the ring.  Use this to inject a fence error into a ring.
+
+amdgpu_pm_info
+--------------
+
+Provides human readable information about the power management features
+and state of the GPU.  This includes current GFX clock, Memory clock,
+voltages, average SoC power, temperature, GFX load, Memory load, SMU
+feature mask, VCN power state, clock and power gating features.
+
+amdgpu_firmware_info
+--------------------
+
+Lists the firmware versions for all firmwares used by the GPU.  Only
+entries with a non-0 version are valid.  If the version is 0, the firmware
+is not valid for the GPU.
+
+amdgpu_fence_info
+-----------------
+
+Shows the last signalled and emitted fence sequence numbers for each
+kernel driver managed ring.  Fences are associated with submissions
+to the engine.  Emitted fences have been submitted to the ring
+and signalled fences have been signalled by the GPU.  Rings with a
+larger emitted fence value have outstanding work that is still being
+processed by the engine that owns that ring.  When the emitted and
+signalled fence values are equal, the ring is idle.
+
+amdgpu_gem_info
+---------------
+
+Lists all of the PIDs using the GPU and the GPU buffers that they have
+allocated.  This lists the buffer size, pool (VRAM, GTT, etc.), and buffer
+attributes (CPU access required, CPU cache attributes, etc.).
+
+amdgpu_vm_info
+--------------
+
+Lists all of the PIDs using the GPU and the GPU buffers that they have
+allocated as well as the status of those buffers relative to that process'
+GPU virtual address space (e.g., evicted, idle, invalidated, etc.).
+
+amdgpu_sa_info
+--------------
+
+Prints out all of the suballocations (sa) by the suballocation manager in the
+kernel driver.  Prints the GPU address, size, and fence info associated
+with each suballocation.  The suballocations are used internally within
+the kernel driver for various things.
+
+amdgpu_<pool>_mm
+----------------
+
+Prints TTM information about the memory pool <pool>.
+
+amdgpu_vram
+-----------
+
+Provides direct access to VRAM.  Used by tools like UMR to inspect
+objects in VRAM.
+
+amdgpu_iomem
+------------
+
+Provides direct access to GTT memory.  Used by tools like UMR to inspect
+GTT memory.
+
+amdgpu_regs_*
+-------------
+
+Provides direct access to various register aperatures on the GPU.  Used
+by tools like UMR to access GPU registers.
+
+amdgpu_regs2
+------------
+
+Provides an IOCTL interface used by UMR for interacting with GPU registers.
+
+
+amdgpu_sensors
+--------------
+
+Provides an interface to query GPU power metrics (temperature, average
+power, etc.).  Used by tools like UMR to query GPU power metrics.
+
+
+amdgpu_gca_config
+-----------------
+
+Provides an interface to query GPU details (Graphics/Compute Array config,
+PCI config, GPU family, etc.).  Used by tools like UMR to query GPU details.
+
+amdgpu_wave
+-----------
+
+Used to query GFX/compute wave infomation from the hardware.  Used by tools
+like UMR to query GFX/compute wave information.
+
+amdgpu_gpr
+----------
+
+Used to query GFX/compute GPR (General Purpose Register) infomation from the
+hardware.  Used by tools like UMR to query GPRs when debugging shaders.
+
+amdgpu_gprwave
+--------------
+
+Provides an IOCTL interface used by UMR for interacting with shader waves.
+
+amdgpu_fw_attestation
+---------------------
+
+Provides an interface for reading back firmware attestation records.
diff --git a/Documentation/gpu/amdgpu/debugging.rst b/Documentation/gpu/amdgpu/debugging.rst
index e75f97d0e4eaf..7cbfea0606e15 100644
--- a/Documentation/gpu/amdgpu/debugging.rst
+++ b/Documentation/gpu/amdgpu/debugging.rst
@@ -2,6 +2,13 @@
  GPU Debugging
 ===============
 
+General Debugging Options
+=========================
+
+The DebugFS section provides documentation on a number files to aid in debugging
+issues on the GPU.
+
+
 GPUVM Debugging
 ===============
 
diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgpu/index.rst
index 302d039928ee8..4c75567854cb2 100644
--- a/Documentation/gpu/amdgpu/index.rst
+++ b/Documentation/gpu/amdgpu/index.rst
@@ -16,5 +16,6 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA) architectures.
    thermal
    driver-misc
    debugging
+   debugfs
    process-isolation
    amdgpu-glossary
-- 
2.48.1

