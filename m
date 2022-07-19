Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CEEC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 14:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9B8418B890;
	Tue, 19 Jul 2022 14:04:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AC8418B8E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 14:04:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mi9xQbuieMe+2+R8pdskkXFBFM13Jm0UNGuEDDA0WW0F3q93oOtUhlCoR1khPqrAe+Ks7h9dLSb9RLu+1aPwuLNXVIbvVlA9L9VEp6dWBudJ9S6EUpFfltOYQxTOxhBj7XVQdjB1rGK8JLsEUejKUlpIEFPwqKLfI10rGF+bS0G4B5th16CjOFda9De3rhu5c5fvBH8jcsm4BNUZMlWzyk8dxayjq5hzYqvcFpyv8qyANebs0wAU2J2E3/KizmExEjOpvEaskGPobyJLD+HxG2UB3NBSM3FXp8QVLNJTJn97DgTzZ75LgzdDwAeDntzT27mjxxTn7OU1BHG2GVI0Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOODT19tQYUiQrS2J2hPWYW78B9V1G51tbdufH9mAzg=;
 b=DrJwVEuWk3oz7VTYcqXoJ0IAEW9VkB2oUs8v1MzLkclW/xUCSxr/6J74q+Wh0NcahA0RuLoQyUZtlf6NYIFl3N0o9++f2SWDw76HkTqJXjgqt6t1F+jdcnQqK/BfsEVsVw2QzuZ1532vwAKI/URiTpbULxP5ouzYwgIHSBVY41xlBQ2nGtsk3uX2h7tJL6UHx2/LdVV5Bz7OwLKUJ6tQICyc7gDP+ahIxPyX+dsTWcrPIeSh6bo/g7wlFkUsFuFzSj9en108rAlrqRB5gcmbzIlh9hO6AuW2JKdqCjvYBCR9zm05TC6xCVfVTTA5RcG5uDaaSBxzHhsrCqoQczQPVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOODT19tQYUiQrS2J2hPWYW78B9V1G51tbdufH9mAzg=;
 b=JkFTY6r6kI+hjjHkNIiG5fQ1i7daYaWfHErIXKz2mFz35bNUiU/YcOzmAijhbzBlzl36WnhnKHZRlrNDLatu2ApYqGJAGzhPq9fVPtnGxPd0fHisKMf96//KAyYUsdYuHOusQCR09qKgheLjdHbzAhhsg3WTimmhDeOThPaMPxA=
Received: from BN9PR03CA0362.namprd03.prod.outlook.com (2603:10b6:408:f7::7)
 by DM6PR12MB2875.namprd12.prod.outlook.com (2603:10b6:5:15c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Tue, 19 Jul
 2022 14:04:35 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::99) by BN9PR03CA0362.outlook.office365.com
 (2603:10b6:408:f7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23 via Frontend
 Transport; Tue, 19 Jul 2022 14:04:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Tue, 19 Jul 2022 14:04:35 +0000
Received: from david-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 19 Jul
 2022 09:04:32 -0500
From: <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd/kfd: Add documentation comments to KFD
Date: Tue, 19 Jul 2022 10:03:37 -0400
Message-ID: <20220719140338.1644486-3-David.Francis@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719140338.1644486-1-David.Francis@amd.com>
References: <20220719140338.1644486-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8572b7ff-bd24-4dd4-eb69-08da698f9c7b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2875:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W9bc7o66oumbuaANvTw381UsDMKEI68cE7vBzKI50BekU4rUKyuh1XA2oGGtIg3Rsw+4Y01fFpxIavUeEvmtSJOf3oHP0s2tnqjgdbOANCWMsF1BE1c5TICBabs3+cJ0KZoKpVtffJSqwNEw2H7KsdRu2MIWP8J++eUQxi4uAx5HdpZlxGg4fiREMaUdc8NkvmCSU2Ww7JPb8dh2M+gGauWbc3OHc5fQ9D+tr89ZxcTnHod7nkkYEOJwq8sSxbggZRWDU6NKfg9O84/f2/qNrefHahEVDe7PGyrzOS3KgCgNfUBVnt6Kl6FriZ+HdoQjMC23DChXwVSqUc/J5Bl+TwJqOhf7MxFYe2iu+SmWUe5ImLMGP18C7tv2Zl6aD8rwuVPziFU2ui9805RfRCj/5y5vjIrqM6kpgNAmUOclNgQJDbMNTyIdF5YcaNYt6aYS2vdFWOxLY+PVfJgsApTbmajxu4+qpqUNOYqiWo8bOrly4L6dbRWeZI9v96x2ldo1XWCsK3UbqkoiVq7mFHM2Bm9YtG9mquPT0YuzbxI5VdYIwXO9sO3Bs4OTZ2KCMFN9egFvXI0ie63uyFNLr6X3eekh56pzAuuhrHRY3JGAIxMNKNWYAUdrMMhAjzvNeCbBdOXyLozNmwUjjiH++6coZZuWC1IYfhvmSGckWqtH2nNfNSoxtLV8YGd1djWFPZPxIHHj1B2SbuL7rCF+FSwYI1Ah//caERq6zalfqKBfyp2lz9pQzcvEUyB5jHOGxTzBjLEFWRjj/OClbG0CifES1UJrlZG+pGH4cLoc2GzHaTzJKW6fVVmfq29K6dVlKBblei8YksAzqMpqKyXfNVGqlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966006)(40470700004)(36840700001)(70586007)(70206006)(8936002)(30864003)(5660300002)(4326008)(8676002)(40480700001)(82310400005)(40460700003)(2876002)(2906002)(36860700001)(83380400001)(356005)(86362001)(82740400003)(81166007)(36756003)(478600001)(54906003)(316002)(6916009)(2616005)(1076003)(47076005)(426003)(186003)(16526019)(336012)(41300700001)(26005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 14:04:35.2171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8572b7ff-bd24-4dd4-eb69-08da698f9c7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2875
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
Cc: David Francis <David.Francis@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Francis <David.Francis@amd.com>

Add six long comments outlining the basic features of the
driver, to aid new developers.

Signed-off-by: David Francis <David.Francis@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c  | 74 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c   | 25 ++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c    | 57 +++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 33 ++++++++++
 4 files changed, 189 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 6abfe10229a2..ea25a47b62dc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1031,6 +1031,80 @@ static int kfd_ioctl_get_available_memory(struct file *filep,
 	return 0;
 }
 
+/**
+ * DOC: Memory_Types
+ *
+ * There are many different types of memory that KFD can manage, each with
+ * slightly different interfaces
+ *
+ * VRAM and GTT
+ * ------------
+ *
+ * VRAM and GTT can be allocated with the AMDKFD_IOC_ALLOC_MEMORY_OF_GPU ioctl.
+ * This ioctl returns a handle used to refer to the memory in future kfd ioctls,
+ * as well as a mmap_offset used for mapping the allocation on the CPU. VRAM
+ * memory is located on the GPU, while GTT memory is located in host memory.
+ * Once memory is allocated, it must be mapped with the
+ * AMD_KFD_IOC_MAP_MEMORY_TO_GPU ioctl before the GPU can access it.
+ *
+ * Doorbell and MMIO
+ * -----------------
+ *
+ * Each process is assigned two pages of doorbell memory used to signal that
+ * usermode queues have awaiting packets. AMDKFD_IOC_ALLOC_MEMORY_OF_GPU
+ * associates these pages with a virtual address. They must still be mapped if
+ * the GPU is to access them.
+ *
+ * There is one page of MMIO memory per GPU that is accessible to userspace by
+ * the same means.
+ *
+ * userptr
+ * -------
+ *
+ * userptr memory is user-allocated system memory, alloacted with malloc or
+ * similar. As with doorbell and MMIO memory, AMDKFD_IOC_ALLOC_MEMORY_OF_GPU
+ * does not allocate the memory; instead it registers existing memory for
+ * mapping.
+ *
+ * SVM
+ * ---
+ *
+ * SVM is a different memory-allocation API available on GFX9+. Like userptr
+ * memory, SVM maps existing user-managed memory onto the GPU.
+ *
+ * XNACK is an SVM feature that is disabled by default as it has a performance
+ * cost. When XNACK is enabled, SVM memory can perform recoverable page faults,
+ * allowing KFD to allocate memory without reserving physical address space,
+ * performing the physical allocation only on page fault. With XNACK, SVM
+ * uses the Heterogenous Memory Manager (HMM) to migrate pages back and forth
+ * between the device and the host in reponse to memory pressure and page faults.
+ *
+ * Scratch
+ * -------
+ *
+ * Scratch memory is VRAM memory on a GPU reserved for holding intermediate
+ * values during a shader's execution. A user (usually ROCr) can allocate
+ * scratch memory by allocating VRAM memory and then using the
+ * AMDKFD_IOC_SET_SCRATCH_BACKING_VA ioctl.
+ */
+
+/**
+ * DOC: Memory_Implementation
+ *
+ * The GPU page tables need to be kept in sync with the CPU page tables; if a
+ * page is moved, swapped, or evicted by linux's normal memory manager, a callback
+ * is made into kfd, which must pause hardware access to the memory while the
+ * operation is in progress.
+ *
+ * Compute shaders can cause thrashing if the total memory in use exceeds the
+ * GPU or system's memory limits. Because user command submission is via
+ * usermode queues, with no driver involvement, all memory must be physically
+ * resident at all times (this is different from the graphics approach, which
+ * can swap memory on and off the GPU as needed). KFD prevents overcommitment
+ * of memory by keeping an account of how much memory processes have allocated,
+ * and refusing to allocate beyond a threshold.
+ */
+
 static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 					struct kfd_process *p, void *data)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index f5853835f03a..76d1842c9333 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -37,6 +37,31 @@
 
 #define MQD_SIZE_ALIGNED 768
 
+/**
+ * DOC: Discovery
+ *
+ * There are two phases of initialization and topology discovery in KFD. The
+ * first, module_init occurs when the module is built into the kernel (on boot
+ * or modprobe). The second, device_init, occurs when linux discovers a PCI
+ * device that is an AMD GPU (on boot or hotplug).
+ *
+ * module_init begins when the amdgpu driver is initialized (amdgpu_drv.c),
+ * which calls kfd_init() in kfd_module.c. At this time, the chardev is created
+ * so that ioctls can be submitted, and the topology is queried, creating the
+ * sysfs layout. Some AMD APUs make their topology information
+ * available through a BIOS structure called a CRAT table. If no CRAT table is
+ * found, KFD will make one up with the information available to it. Discrete
+ * GPUs are not discovered at this time; only CPUs and APUs. At this
+ * point, AMDGPU registers itself as a PCIe driver.
+ *
+ * device_init begins when linux finds a device with a PCIe ID matching an entry
+ * amdgpu is registered for. If the device contains compute functionality,
+ * amdgpu will call kgd2kfd_probe() and kgd2kfd_device_init() in kfd_device.c
+ * (kgd2kfd stands for Kernel Graphics Driver to Kernel Fusion Driver) to set up
+ * shared resources such as non-compute doorbells and add the new device to the
+ * topology.
+ */
+
 /*
  * kfd_locked is used to lock the kfd driver during suspend or reset
  * once locked, kfd driver will stop any further GPU execution.
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 0f6992b1895c..3c1a2be18d4c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -25,6 +25,63 @@
 #include <linux/slab.h>
 #include "kfd_priv.h"
 
+/**
+ * DOC: Queue_Interface
+ *
+ * A process can create queues with the ioctl AMDKFD_IOC_CREATE_QUEUE, which
+ * returns a queue id used as a handle, the addresses of the read and write
+ * pointers, and the doorbell location. Up to 256 processes can have queues,
+ * and each process can have up to 1024 queues.
+ *
+ * A doorbell is a 64-bit memory-mapped register on the GPU that a
+ * process can write to to signal that the corresponding queue has packets
+ * waiting in it.
+ *
+ * A queue can be either an compute queue, used for computation, or an SDMA queue,
+ * used for data transfers.
+ *
+ * Most HSA queues take commands in the form of 64-byte AQL packets. Most
+ * commonly, this will be a kernel dispatch packet containing a pointer to the
+ * kernel to be executed. A kernel is a small program that performs an
+ * elementary operation such as a vector sum, matrix multiplication, or
+ * scatter-gather operation. A single user program may be made up of many
+ * kernels. Other AQL packets include barrier packets used for synchronization
+ * between shaders and PM4_IB packets that flush the cache, used for profiling.
+ * Packets in the same queue will begin execution in order, but can run
+ * concurrently. DMA queues are similar, but use a different packet format.
+ *
+ * A queue contains a ringbuffer with read and write pointers used to submit
+ * packets (the size of the ringbuffer is specified when the queue is
+ * created). To write to a queue, a process first atomically moves the
+ * write pointer forward. Then, it writes each of the packets to the buffer,
+ * leaving the headers empty so that if hardware attempts to consume the packets
+ * at this point, it will find them invalid. Then it writes the headers and
+ * signals the doorbell.
+ *
+ * In addition to the user mode queues described here, there are kernel mode
+ * queues used internally by KFD to communicate with various elements of the
+ * hardware; these work similarly.
+ */
+
+/**
+ * DOC: Queue_Implementation
+ *
+ * Although there may be thousands of queues attached to processes, the 
+ * hardware engines have a limited number of queue slots, usually 32 or fewer 
+ * compute and 10 or fewer DMA per GPU. The hardware will detect doorbell 
+ * signals directly only from queues mapped to an engine. The hardware
+ * scheduler will periodically poll for unmapped queues with work waiting and
+ * map them, unmapping empty queues to make room.
+ *
+ * Compute shaders can be interrupted partway through execution by the hardware
+ * scheduler. In that case, the shader's current state will be saved to a
+ * usermode buffer so it can be restored at a later time. These buffers are
+ * large, and each queue requires its own buffer, so queues are memory-expensive
+ * objects. The context save/restore process is initiated with a trap handler on
+ * the GPU. The trap handler itself is located in the driver, written in SP3
+ * assembly code.
+ */
+
 void print_queue_properties(struct queue_properties *q)
 {
 	if (!q)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 25990bec600d..8c2910b98ece 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -42,6 +42,39 @@
 #include "amdgpu_ras.h"
 #include "amdgpu.h"
 
+/**
+ * DOC: Topology
+ *
+ * The GPU component of an APU or iGPU, or a discrete GPU, is a GPU device. The
+ * CPU is also a device (known as "System" or "Host" to KFD).
+ *
+ * A node is a memory domain. Most devices are a single node, but certain GPUs
+ * may contain multiple nodes, depending on how they are configured. Each GPU
+ * node has its own L2 data cache.
+ *
+ * A GPU contains multiple Shader Engines (SEs). Each shader engine has its own
+ * sub-scheduler to divide up work within the SE.
+ *
+ * A Shader Engine contains multiple Compute Units (CUs). All processing in a
+ * CU will share all caches, such that two threads running in the same
+ * CU will be able to easily communicate and synchronize
+ *
+ * A Compute Unit contains multiple Single Instruction Multiple Data units
+ * (SIMDs). A SIMD can run programs that perform operations on 32- or 64-element
+ * vectors. A program running on a single SIMD is called a wavefront.
+ *
+ * In addition to the processing capabilities, the topology also includes the
+ * IO links between nodes. GPU nodes may be connected to each other or the
+ * system via XGMI or PCIe links.
+ *
+ * Topology information is available through sysfs at
+ * /sys/devices/virtual/kfd/kfd/topology or through symbolic link at
+ * /sys/class/kfd/kfd/topology. The generation_id field in that directory is
+ * incremented each time the topology is updated. To ensure a consistent view of
+ * the topology, user programs should read generation_id before and after
+ * checking the topology, and retry if the values are not the same.
+ */
+
 /* topology_device_list - Master list of all topology devices */
 static struct list_head topology_device_list;
 static struct kfd_system_properties sys_props;
-- 
2.25.1

