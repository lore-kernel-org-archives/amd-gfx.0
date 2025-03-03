Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC06C282C6
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 23:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11C9810E155;
	Mon,  3 Mar 2025 23:02:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RLm/FGTx";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9395410E155
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 23:02:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLPRzMuh3uhOMazYZ3A9QkDqQ0zoD5r7syvKdMqwXlGLdqU+RVWQFWnM06TITIa2ZM3RjxTK8rrheJnhG7FifBt7jsPg/XjhWQnprIMQCNOXgf8HY4jKrxCBo/7ImUpPPUwYq/jZCai3KhhxM02qGC70EYctUl4+dS9n3JG+goL7/d0ZyoQDZJa2NdLKVAzGPRILTiVEvpNiNw5pb50dXu2ZKjMrlAta7tVVYcNbqAe1anVRjVl3PY8bBTJvr8grk2V9Zcczjy3Ow3K9wc2pIGYPkWCPOk2zGMSXsV4lXB4/kxJk/EbW7N+atnG4FcMztgFp7DJ8Zj0CjJSsKLCHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ur6lP4Bw/OBz9reqZXNfZU2fbIx0ZZXRXi2Eg1FNjs=;
 b=QUN6ZUzMwhv4wJuaFrNajdHv6ifMSCEKVk0FiU71Y9IJrHrvgVPkwO3DUd/Sbk7LVAI5WXb/ztJCyeZZI7EiWR95MazBZdbCoZqoU9WkzmccnUzHuNngqgzYRI6JXfJMGeYJvK8UwzSKfW3pu+zSLEtH0qnI1giMleNEtCVkKwmv+/zlUWJDCZJVwzkTfDqWwvg1HVRsD5G3WnyjyC25lhTZewRmTuj3gVOFk+HSmAmctRobPuXL9D5b475S6YwGVnOQUCp8cExV0zl++EMGmB6T15n7UYJR0BWHU3XDKGflTna6zxQg7lHd9BslF9u4PLJUuF+7EMYsaordTeAt6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ur6lP4Bw/OBz9reqZXNfZU2fbIx0ZZXRXi2Eg1FNjs=;
 b=RLm/FGTxuIudOBtVJiNMRnBMUVfNYxsvfuxb24QMJ4brRgJWH6C17tbmEnWQJLNKk2UwWOgztgTRHL/0y8QHX0m3Pa9hlZgnDfsNA1Dv8r35POUfC2T4GKRVFf/Kl2VMs86lMWWbnr61wMq/MERHe6mxyPSBlpt+fzH2t0YT24o=
Received: from BL1PR13CA0187.namprd13.prod.outlook.com (2603:10b6:208:2be::12)
 by IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 23:02:05 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::b0) by BL1PR13CA0187.outlook.office365.com
 (2603:10b6:208:2be::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15 via Frontend Transport; Mon,
 3 Mar 2025 23:02:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 23:02:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 17:02:03 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add initial documentation for debugfs files
Date: Mon, 3 Mar 2025 18:01:49 -0500
Message-ID: <20250303230149.3544994-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|IA0PR12MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: ced2ea8c-5dd0-43ac-9010-08dd5aa76ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FVR7L4eImOHQjbzHw6JqHb3Kh3Yyw33qEC90DiJBfl80U/z9iqUnmA+4bHrY?=
 =?us-ascii?Q?NCKfXHtTBF8naFyIDfXcntJsZcKDnYVNPvc8UyOHuLJPkypR8LZIo7ur9xy9?=
 =?us-ascii?Q?27vTrHqMvDOPhSnGdAiEMYilm/0SNr3yKXxQPciHkxNUZaZ2S33O7nLKpxkV?=
 =?us-ascii?Q?QphuOmDW9zdE3Bphai9jP8Li9CpzczAiBu0jXuz4C51pMzfIIG3EL3ABIobl?=
 =?us-ascii?Q?eE1YjO6kzgioj5uL5zVQcLHM2xgXvOYO4pbaHaJy0nZgeE+5bUJosR77BTaW?=
 =?us-ascii?Q?vVqICZ/k3sc983E1sw/jxMqHmPHIV+EjPOg+hEn3pnI9xlNjswg3R/qehivm?=
 =?us-ascii?Q?jhG7TDVvW08epTEvd9f7XVFXKThbOIs3MpAsgtLw1FdRa9273fcDtdiFEg2J?=
 =?us-ascii?Q?BF5fJOf6KuCB11WlpT1R/CqsEn7lUL7i2u8i9eUS+kiY2jSTJK+74OAkDnuT?=
 =?us-ascii?Q?ZzCh0FMdiiWywSrp2pU3Ufw9Tuk4wJifFIiI5b5NftGEDuWCQvP6A3tmok7N?=
 =?us-ascii?Q?FACWl0ie2nsqZQeT2EBa8n5qddOwqP5iRJTBQIHcjCFVdEcqLqEeycEuCPXk?=
 =?us-ascii?Q?mYZ+nNllBW6ImCo2mZwduEhQzY94XpKbdyPAjA6dv1FoLvTNlUX5gAj0Vz52?=
 =?us-ascii?Q?J8Yzcr833uTTMW3Jz0KiKjcbcnJzC5jfAgnfQr9Kl5M0KDFURpY/Q/4gfAaF?=
 =?us-ascii?Q?mqfODKocAKceyQfmVFwmzv9e+xqQP3gNS1mRm9YWmI5XKVKri+xaxMEJFF1/?=
 =?us-ascii?Q?zMLg8MYHPDU9rMZ33BBQt4n/7UJjf3+leZxtHS7VqXWEIPLoJZBxP/4cVxxi?=
 =?us-ascii?Q?fRSbC66fXHsIRffZT2wkvrGJNJOjUZkTGvBygC41npK5isYs+Qk01EE+JLRy?=
 =?us-ascii?Q?f2yu404NPHgGgMdyZAc9KWFN/OApGw03MlXWh3SvdOchUsCxCQy15ldx9iLo?=
 =?us-ascii?Q?C5/nKelynTx6fAHTBk2rGaS+Dv8CNOjYzeUdsKytPURbsxU4nUmpk71xogjq?=
 =?us-ascii?Q?X6pmMN1VvAl94k0oy1xp2+qvc99RnOWcaD9Lv+46VPfzzxWTeErGRi0sAIlm?=
 =?us-ascii?Q?TUu5/mVoJDNDhaHBgWJv5+igWdcRewgaNFZX2ssASAjQduV4/l44wCNdLYi6?=
 =?us-ascii?Q?uw+SI4S+cz1fCxhXNOYdY8VwUENINF2emR3OkjSjA4WucBzTvepCJ/PHPudb?=
 =?us-ascii?Q?cM/2P+4fgkkRK6kGhBhTSmnaUGw1Fl2mq/N55RS2e5Gyj7aLCWosWRoCWoY+?=
 =?us-ascii?Q?PY5bsJXkA7GrhWbMpqCHIzAHXsjqZCT+bMry9p+mMREsjUuPXBsUeQEYGBG8?=
 =?us-ascii?Q?fk8p/INWCsi1O4rXT/RczYoaI10usNExVDIBwIhXmaWuLFYOfFjZfs0dJUuf?=
 =?us-ascii?Q?DyJ/b1i0350c+aGzXlwVZtt+DKFX9xUEDcjhDetNzvVJvaPSCAMMnO7sPPCF?=
 =?us-ascii?Q?8eQJZI24yIkph1Wsb9sGzlufXcjbY0j3vg2W5pGHBHAZVzckCNnkVa0ua5uF?=
 =?us-ascii?Q?8dPDAE8FDTWE3xU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 23:02:05.2397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ced2ea8c-5dd0-43ac-9010-08dd5aa76ab6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8895
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/gpu/amdgpu/debugfs.rst | 201 +++++++++++++++++++++++++++
 Documentation/gpu/amdgpu/index.rst   |   1 +
 2 files changed, 202 insertions(+)
 create mode 100644 Documentation/gpu/amdgpu/debugfs.rst

diff --git a/Documentation/gpu/amdgpu/debugfs.rst b/Documentation/gpu/amdgpu/debugfs.rst
new file mode 100644
index 0000000000000..9d82c770c1e78
--- /dev/null
+++ b/Documentation/gpu/amdgpu/debugfs.rst
@@ -0,0 +1,201 @@
+==============
+AMDGPU DebugFS
+==============
+
+The amdgpu driver provides a number of debugfs files to aid in debugging
+issues in the driver.
+
+DebugFS Files
+=============
+
+amdgpu_benchmark
+----------------
+
+Run benchmarks using the DMA engine the driver uses for GPU memory paging.
+Write a number to the file to run the test.  The results are written to the
+kernel log.  The following tests are available:
+
+- 1: simple test, VRAM to GTT and GTT to VRAM
+- 2: simple test, VRAM to VRAM
+- 3: GTT to VRAM, buffer size sweep, powers of 2
+- 4: VRAM to GTT, buffer size sweep, powers of 2
+- 5: VRAM to VRAM, buffer size sweep, powers of 2
+- 6: GTT to VRAM, buffer size sweep, common modes
+- 7: VRAM to GTT, buffer size sweep, common modes
+- 8: VRAM to VRAM, buffer size sweep, common modes
+
+amdgpu_test_ib
+--------------
+
+Read this file to run simple IB (Indirect Buffer) tests on all kernel managed
+rings.  IBs are command buffers usually generated by userspace applications
+which are submitted to the kernel for execution on an particular GPU engine.
+This just runs the simple IB tests included in the kernel.
+
+amdgpu_discovery
+----------------
+
+Provides raw access to the IP discovery binary provided by the GPU.  Read this
+file to acess the raw binary.
+
+amdgpu_vbios
+------------
+
+Provides raw access to the ROM binary image from the GPU.  Read this file to
+access the raw binary.
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
+Read this file to trigger a full GPU reset.  All work currently running
+on the GPU will be lost.
+
+amdgpu_ring_<name>
+------------------
+
+Provides read access to the kernel managed ring buffers for each ring <name>.
+These are useful for debugging problems on a particular ring.  The ring buffer
+is how the CPU sends commands to the GPU.  The CPU writes commands into the
+buffer and then asks the GPU engine to process it.
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
+available on engines which use MQDs.
+
+amdgpu_error_<name>
+-------------------
+
+Provides an interface to set an error on fences associated with ring <name>.
+The error code specified is propogated to all fences associated with the
+ring.
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
+Lists all of the PIDs using the GPU and the GPU buffers that are they have
+allocated.  This lists the buffer size, pool (VRAM, GTT, etc.), and buffer
+attributes (CPU access required, CPU cache attributes, etc.).
+
+amdgpu_vm_info
+--------------
+
+Lists all of the PIDs using the GPU and the GPU buffers that are they have
+allocated as well as the status of those buffers relative to that process'
+GPU virtual address space (e.g., evicted, idle, invalidated, etc.).
+
+amdgpu_sa_info
+--------------
+
+Prints out all of the suballocations by the suballocation manager in the
+kernel driver.  Prints the GPU address, size, and fence info associated
+with each suballocation.  They suballocations are used internally within
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
+Provides an interface to query GPU details (GFX config, PCI config,
+GPU family, etc.).  Used by tools like UMR to query GPU details.
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
+Used to	query GFX/compute GPR (General Purpose Register) infomation from the
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
diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgpu/index.rst
index 302d039928ee8..5254f3a162f84 100644
--- a/Documentation/gpu/amdgpu/index.rst
+++ b/Documentation/gpu/amdgpu/index.rst
@@ -17,4 +17,5 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA) architectures.
    driver-misc
    debugging
    process-isolation
+   debugfs
    amdgpu-glossary
-- 
2.48.1

