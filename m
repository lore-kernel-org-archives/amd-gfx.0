Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF0DC282D2
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 16:50:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDF4F10E286;
	Tue,  4 Mar 2025 16:50:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="41S+RzD6";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3F2F10E286
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 16:50:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsDFW8yRgcDUwSq4PbFJtMHPCBNAUHtp1gm85y67u8aJGyEgAlYRKU0Hxp3j4JBDekEEJl5KsaFeaqSHv+YaEEIrrcc2bLFwJtMMsIsj1SjRh+ntG8FxHXPWOIm5hXsduA46V9oP+ayatwdN3tyDIWqkYskB9pnpXDsVn6YEkz1U3M3APt5LYe74SXxm2QLzZpTAjsQP85B7+8XgvZawCU2RRIkdgU1M0CgEXoSUDyTAy8aOZiWp6zsYwz4qaQK6NEq7MUZ9W+cAv5i71NW62mW5LTIXgVrkoIHo9C6ipBidnDjVlOU9wKnRt9gSZxA36CxxzGdtribnwhgYA393Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrAv+BSf1QVv/zEW1Y6GQcY8Jb9Pq8SH0794t0dKdyo=;
 b=f6txaePDrCgqQbOUDI+U3VUGzwcVO4rT4AGYCZZ4PmHdCflZf5L3pIe1RqaE6c6WLPzJKzgXEmYl8scoVQum0fAuqTRtejnxPtVCkXC+UbUIiNAwBuuhQd3susbYWLPO3q7sLFct5YSdGW/w2wZXt/hnPoPD1xUj/42UV9bpQLA4DpMN1DagyMfHYGtXWZA7a2zvG3OlqYIc+QWZBjc2sFQv92o1dd8P+honNZ2/EDRFTcgSSfL+R/P0/Ek4SHi/ghYhXrpmGA2yMR1vbz2hO1Krsqm/zG+2aaYrEEgaYWU1/1m9HSaCc8rj3auJN569KzFm7VclpYfv46KX/jCGhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrAv+BSf1QVv/zEW1Y6GQcY8Jb9Pq8SH0794t0dKdyo=;
 b=41S+RzD62H786KPSZRhiLpZOqxZvmdNrfu/Tis0kHgtI+oM22JHRPfoDWXLD7qGd/n/GDMR58H568ft9VJVej4TzSEj9QPd4AvlFGbm+NuIARO+K+diI9VqOXfL91JXnQPq/lZvHF30GwjPMaNv5kkZU15kKIpRgXBczCxQ61aM=
Received: from DS7PR03CA0148.namprd03.prod.outlook.com (2603:10b6:5:3b4::33)
 by PH7PR12MB7138.namprd12.prod.outlook.com (2603:10b6:510:1ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Tue, 4 Mar
 2025 16:50:43 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:5:3b4:cafe::45) by DS7PR03CA0148.outlook.office365.com
 (2603:10b6:5:3b4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Tue,
 4 Mar 2025 16:50:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 16:50:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 10:50:41 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add initial documentation for debugfs files
Date: Tue, 4 Mar 2025 11:50:24 -0500
Message-ID: <20250304165024.4040892-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|PH7PR12MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: 8352707d-f4ac-44e8-ae2a-08dd5b3cb3e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yMcKnYTuAkJqNRsqTedUitSTMqgbVHjeCfiJT6pVs+8nZetxqVA8rfC1cM03?=
 =?us-ascii?Q?RNkRlTSUQSrR6d/F/eTtzzE25rJ67oJhdDeJo08YM8WZJzP7g0655DYSQOZA?=
 =?us-ascii?Q?hxtSiXQhRnHpaP/qGyD7INhMUet/OpYuvw+KSqSzfNlYb2M88Bz0Qp/nYqhh?=
 =?us-ascii?Q?wADNR/PaWyYIuqGbYLBUkFBHKbstryAaKqC4cskJlHEZHWxHh62XJfbzV/uT?=
 =?us-ascii?Q?cq9H9QkmjFhgqiqFJlgshqO8rd3OrRBArunLJEfrdMVTBg82li5Fz8zztHL/?=
 =?us-ascii?Q?any5BvpAehz2t/MOnd3KBdIXXMSCIWpMCPr3AHwHs3cU6GW3iQm3CoTo7nSm?=
 =?us-ascii?Q?zgfiV/l/sU1Hhm9TfZK35zn59O7sj+Baep0YQ0mE8o6Y4h85Q5pdRqJXPh+i?=
 =?us-ascii?Q?DqOjJZGvxrGbNx/WJDI3nKSJ9lMTL1dB2CX9CbaxkbiP249+Hb0oTv3ZZ4b1?=
 =?us-ascii?Q?g2c0uqaw9/OB440vN34smgeDn+unTZnn9SzWxZM+aChv/w4BwYHO6AwwnjDL?=
 =?us-ascii?Q?nEibzgkfAElfIwt/uIPmVkfLHlWknQS1gSzPp2KJGkdgMmR+pnBPvi4oAGj7?=
 =?us-ascii?Q?NXH+8DJ+MJN+TVZG8vBpzkvozxJpCNg2/ll4fOTr6Rh0GUdhp+dAcGI9fAq4?=
 =?us-ascii?Q?UAsKVs92QE8xHYaWB7EVTn9PpTLDiva/2dkMufWYV5uhDGLazUOVWac/bKCX?=
 =?us-ascii?Q?1pPwlr82fu6mT+4cT5mIppLTZ0o8AG9gxoB1sI1vRdoWbnzLfkFI+df9o2KS?=
 =?us-ascii?Q?LY98gW1XoyVkkOKbMDMAn+jRau7EMW6JbuE5eo+n5UzOouqe/3u1f+9EEIUk?=
 =?us-ascii?Q?tcX+7abyVa8eVERmVGuISUmbuoTuGx84fGTJUfI3iBDskXeU3v1qg7u0lxLh?=
 =?us-ascii?Q?Ai2SdKNy7sDSRB8E3ShkJ+zghA10RyNdTAeBrykL0fclygTdxZn1onNWLwh8?=
 =?us-ascii?Q?R6HPj0hBTmstjvz+2eYDP6mbPMCJYkubf3/LUz14yUdUiAqCmqpqpvHsqcRx?=
 =?us-ascii?Q?CVyqMMR4nJcQq83U0ZWbInvoQga4mDzTEfjnlIGrQMn3nhtVePVR3ZDNwVv2?=
 =?us-ascii?Q?li5vYjLU5GLXIvih0vaIS9G8I6KjdvS9nnr4IWKqENrIwUKUbHFpcJpACvvk?=
 =?us-ascii?Q?ZnVbwYTeGuWEOrTaKGwQCx5AZcyCSvicuawDqkjEUhXk3dmp3mN+vp/WHdQB?=
 =?us-ascii?Q?ZuPfe/UqO6WzLMDeT7rt7aX8mQuw1cHJ2GbyVsopz5A+OLNrJihY9GKsL/JD?=
 =?us-ascii?Q?ebSmVmkv2qFG+GjZn0IPVV08A6cqe6d2Zn2klBSwS2o4PPF7pGWVjuRn9O4V?=
 =?us-ascii?Q?3lXiJldNZMFGucVu/u0StAMxfuhBxTEqJ0AEskkad7e0wHAvWTdFY+wNHdHD?=
 =?us-ascii?Q?1Z6hRz+GF+FL2KWHPydvRUlkdvyEM5Y9NCzPlVGAeeuK0VVQkTQodQ2q/LOD?=
 =?us-ascii?Q?UcKn2mDcmaGwzBf840dvMgVSkiQtvIeVLlYqrvIhCCxKGsFN20uNeM2zVYVD?=
 =?us-ascii?Q?3Xg64kbkMyc4cRo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:50:42.9552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8352707d-f4ac-44e8-ae2a-08dd5b3cb3e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7138
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/gpu/amdgpu/debugfs.rst | 202 +++++++++++++++++++++++++++
 Documentation/gpu/amdgpu/index.rst   |   1 +
 2 files changed, 203 insertions(+)
 create mode 100644 Documentation/gpu/amdgpu/debugfs.rst

diff --git a/Documentation/gpu/amdgpu/debugfs.rst b/Documentation/gpu/amdgpu/debugfs.rst
new file mode 100644
index 0000000000000..18bccb57c89fb
--- /dev/null
+++ b/Documentation/gpu/amdgpu/debugfs.rst
@@ -0,0 +1,202 @@
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
+Prints out all of the suballocations by the suballocation manager in the
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

