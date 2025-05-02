Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1AEC3ABAC
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 20:59:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C7E10E1CE;
	Fri,  2 May 2025 20:59:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M3NC72WY";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CDCF10E1CE
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 20:59:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVZqzhDa6qPxq0V92PL1k04Y+1vMYsFk0T0bU5hzrQpS8Dg2jbnorvOo9uczUOoKKWw4uBtWqMiETw8/uk2VjQY5T/b5u2pmcknT78Xv/d4PzKs448gmk7DhVtSWEtzsYGUx+uc+x6EpuZHFGmvD6CHW1ubvxdl3sKhjkk7UUHB8bBKJ+KQvPP6XZJrB4OdZRDqd37R4/8oZ6AGr+KDWJRxAchHRr9oHJVeyEeYJkoqvRn6WAOFsDjm5KMlIpu5llkF2qMfkp4mEg1Ss1CAo+QsurZ+TUHSDgbr1IiblNEoxuzq8B+72C9/19deBNVeEjkIqdpuplWfTUPtLitW9Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IL9vSUp8ciqIWqKWWxLccM05E9k2bhzh8ipqqfYrWbY=;
 b=RgRdVvGciU06O1mgcwiJislNNrmwLGdO24XLfJqAgqa2ILgmcwZhU0rss+NB6Wy4TqydH4iWBn57sMdEN5YUud2jCoyWqgzL9th4X0c7iHekLcZy86r7WrDRZ+v4hatbf4vFDDwKJIPUzUkCJyLtlxcP6rAmrvuKGBM9ahrHil1sk0fxNzOBRIdm0fNy9i+RwZX81MU6NGUMVzTL7IOPNSKxpcPm0Lz1hViWs3PkRwrlxOib0rXYxmm30YeQ9AiCs5I0y1jSx/dqmbSiIOnKnXLwmXyHG2kojpGfCSID4CKZ2J4Kz7xKKSxqYI0ckZSSUxYRYjS9/RCJyCy2YtgEfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IL9vSUp8ciqIWqKWWxLccM05E9k2bhzh8ipqqfYrWbY=;
 b=M3NC72WYvGmNfkO/D66tX6TymZzBCX/5iV5Y5oGSA3aT9oYTuUz+xqEFjSNyNsdGVs1rY94R1iFBogpz65tXGMhEra74hYvp9WkvbjZXMrW9a60LDyNDmScc7BCclYf15+2/rnyCqyyr949G7aM/pnPsdTGLoa03nGQ8zQlwPmI=
Received: from BN8PR12CA0036.namprd12.prod.outlook.com (2603:10b6:408:60::49)
 by DS0PR12MB8200.namprd12.prod.outlook.com (2603:10b6:8:f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Fri, 2 May
 2025 20:59:42 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:60:cafe::de) by BN8PR12CA0036.outlook.office365.com
 (2603:10b6:408:60::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Fri,
 2 May 2025 20:59:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Fri, 2 May 2025 20:59:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 2 May
 2025 15:59:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] Documentation: add initial documenation for user queues
Date: Fri, 2 May 2025 16:59:24 -0400
Message-ID: <20250502205924.935319-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|DS0PR12MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f46675-1205-4992-f081-08dd89bc4246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mxKY8L+QzVJym24SDh/3ff1LOUBZi/pqZkD+0ej0rpr0bvrZ9lH1ZRQHgEvQ?=
 =?us-ascii?Q?mx5O6vf1RZYlU6sKeKNK4Y+t/UWKyBLKXJevhFQFoarSRomGJYJpeVaB32Kh?=
 =?us-ascii?Q?hZTKOz3lcRHCKSMXgPdnp6PduhN1NnXw8AHBIJCyOCYW93lOSIPF8OaMG+yq?=
 =?us-ascii?Q?va/c01T3HjtHUNn6ufGIufUrqf4QajGjvjimDgmaxpDJDQIWc0MYPm3MQPER?=
 =?us-ascii?Q?BJI2W7D2fLJeE/I7IZeevvKKnS/jLNo77JVgLbULBzpRxsDBc8KcgUfYqp6V?=
 =?us-ascii?Q?HiaqubC1HEiSL107imw3cIGIohPWC5p3vKAzFbEFDLcHswhxavejLN8DwcmE?=
 =?us-ascii?Q?9K5IPFgfv/U7eP5N9H9wpX8b38l30/ilAfQWE3KwBqBWpyXMgdesKwpPL7pN?=
 =?us-ascii?Q?v6cCaXeFNn+3t+p2k9AGCcay9itGFgjV6aM/sQbo5dgIDQE01VMgGCQewL3e?=
 =?us-ascii?Q?pcGwczLN7MQuOcC22Fl1uHR/5SXsWVohc4hSRFyg8cOe0nGgZ2QTeXni/IcV?=
 =?us-ascii?Q?SEr+r7yiQZqtVkThKEVGuRsSPYZG3H8ooo2J0sZg/vQMwYr48mr4QTghFgBx?=
 =?us-ascii?Q?hP8ZJwX8CaYs/VnmmNoAwQ74qbiIvDYqYx/1bAv2/WEhn8FF9XSaHpP2T22t?=
 =?us-ascii?Q?WpKOZM4uo4qoa67Z8On6QfGFR9jmZn4vdpYfkLoRig4HLeD+2fV9Xa5yAail?=
 =?us-ascii?Q?fsazVpLQLDpwrTleQZsoI5TyIM/GO0r2UScAMIPYm8B9wl9gTgNnyx4XCATx?=
 =?us-ascii?Q?ofh+wA6aXviVBoGfLPlI0lWB7IYLkGIjgd1J8D6fz7700hMdHwl7aBUPfeHM?=
 =?us-ascii?Q?uPKuWIvlavzg59gJChmCQpfXNBSVu8yYZOVA58DmRwtChr0z6Dnl9YuHbssU?=
 =?us-ascii?Q?uAoWA6/ZodXjGnGe04vvsGl0Yvfvz0sSDeJzwqE0DREMlvJfWQ+wwM45/0Lp?=
 =?us-ascii?Q?YTMLKEqxCdGR2dwkOnHpWXzRIXP/0k5fWA8nN5j8HIW1Wx3tWytAB/pAl+Oy?=
 =?us-ascii?Q?j6oNS7GHEVWVKpicNgsT/QDb65xl9wTy6mAoyq263aUL1UJCMbWB1XdLpVtS?=
 =?us-ascii?Q?U7tb2G0bnMBmEYg2UHgZulZB4R2s8C96IgtaoB1B5azOedkrd9fIcvX3tNlg?=
 =?us-ascii?Q?34xzOeBb8OxemlI8RyDZK2fcwSJVJMfmysJdcUzRExmv83qby7U+oEOu3+WF?=
 =?us-ascii?Q?bNKr7bjrMBhtp4t73jTVjwxFavV05pABKWDqPjQzu0SY7LSm7rq7I6pxoE5W?=
 =?us-ascii?Q?sYGnlzFstJbCoRJ7L63cY+szBIjYukvijn0V73VTJsYQjtzZdCBXupG0DLF0?=
 =?us-ascii?Q?sIJQKJ4kKACx1Obf9/Ud8B9Z38/86QEPmopdLxBgL2C6nscVkuUunuZz4HRY?=
 =?us-ascii?Q?FPIXYmNEqIy4U+lJuVhgbS4+gP4YCfD/kwI+oKWOkESdTRX8Nc928GDo2hvG?=
 =?us-ascii?Q?eGgDsgdkJ8aX1JJSU4Z2Iwfcv7sCAX18mwPJfR7gXyNENU/PJGXa4ZoMuJ9p?=
 =?us-ascii?Q?d22/oLteHlHfMbfE/dsOfrALCm9jxaJiZNx0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 20:59:41.4862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f46675-1205-4992-f081-08dd89bc4246
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8200
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

Add an initial documentation page for user mode queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/gpu/amdgpu/index.rst |   1 +
 Documentation/gpu/amdgpu/userq.rst | 196 +++++++++++++++++++++++++++++
 2 files changed, 197 insertions(+)
 create mode 100644 Documentation/gpu/amdgpu/userq.rst

diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgpu/index.rst
index bb2894b5edaf2..45523e9860fc5 100644
--- a/Documentation/gpu/amdgpu/index.rst
+++ b/Documentation/gpu/amdgpu/index.rst
@@ -12,6 +12,7 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA) architectures.
    module-parameters
    gc/index
    display/index
+   userq
    flashing
    xgmi
    ras
diff --git a/Documentation/gpu/amdgpu/userq.rst b/Documentation/gpu/amdgpu/userq.rst
new file mode 100644
index 0000000000000..53e6b053f652f
--- /dev/null
+++ b/Documentation/gpu/amdgpu/userq.rst
@@ -0,0 +1,196 @@
+==================
+ User Mode Queues
+==================
+
+Introduction
+============
+
+Similar to the KFD, GPU engine queues move into userspace.  The idea is to let
+user processes manage their submissions to the GPU engines directly, bypassing
+IOCTL calls to the driver to submit work.  This reduces overhead and also allows
+the GPU to submit work to itself.  Applications can set up work graphs of jobs
+across multiple GPU engines without needing trips through the CPU.
+
+UMDs directly interface with firmware via per application shared memory areas.
+The main vehicle for this is queue.  A queue is a ring buffer with a read
+pointer (rptr) and a write pointer (wptr).  The UMD writes IP specific packets
+into the queue and the firmware processes those packets, kicking off work on the
+GPU engines.  The CPU in the application (or another queue or device) updates
+the wptr to tell the firmware how far into the ring buffer to process packets
+and the rtpr provides feedback to the UMD on how far the firmware has progressed
+in executing those packets.  When the wptr and the rptr are equal, the queue is
+idle.
+
+Theory of Operation
+===================
+
+The various engines on modern AMD GPUs support multiple queues per engine with a
+scheduling firmware which handles dynamically scheduling user queues on the
+available hardware queue slots.  When the number of user queues outnumbers the
+available hardware queue slots, the scheduling firmware dynamically maps and
+unmaps queues based on priority and time quanta.  The state of each user queue
+is managed in the kernel driver in an MQD (Memory Queue Descriptor).  This is a
+buffer in GPU accessible memory that stores the state of a user queue.  The
+scheduling firmware uses the MQD to load the queue state into an HQD (Hardware
+Queue Descriptor) when a user queue is mapped.  Each user queue requires a
+number of additional buffers which represent the ring buffer and any metadata
+needed by the engine for runtime operation.  On most engines this consists of
+the ring buffer itself, a rptr buffer (where the firmware will shadow the rptr
+to userspace), a wrptr buffer (where the application will write the wptr for the
+firmware to fetch it), and a doorbell.  A doorbell is a piece of the device's
+MMIO BAR which can be mapped to specific user queues.  Writing to the doorbell
+wakes the firmware and causes it to fetch the wptr and start processing the
+packets in the queue. Each 4K page of the doorbell BAR supports specific offset
+ranges for specific engines.  The doorbell of a queue most be mapped into the
+aperture aligned to the IP used by the queue (e.g., GFX, VCN, SDMA, etc.).
+These doorbell apertures are set up via NBIO registers.  Doorbells are 32 bit or
+64 bit (depending on the engine) chunks of the doorbell BAR.  A 4K doorbell page
+provides 512 64-bit doorbells for up to 512 user queues.  A subset of each page
+is reserved for each IP type supported on the device.  The user can query the
+doorbell ranges for each IP via the INFO IOCTL.
+
+When an application wants to create a user queue, it allocates the the necessary
+buffers for the queue (ring buffer, wptr and rptr, context save areas, etc.).
+These can be separate buffers or all part of one larger buffer.  The application
+would map the buffer(s) into its GPUVM and use the GPU virtual addresses of for
+the areas of memory they want t use for the user queue.  They would also
+allocate a doorbell page for the doorbells used by the user queues.  The
+application would then populate the MQD in the USERQ IOCTL structure with the
+GPU virtual addresses and doorbell index they want to use.  The user can also
+specify the attributes for the user queue (priority, whether the queue is secure
+for protected content, etc.).  The application would then call the USERQ
+create IOCTL to create the queue from using the specified MQD.  The
+kernel driver then validates the MQD provided by the application and translates
+the MQD into the engine specific MQD format for the IP.  The IP specific MQD
+would be allocated and the queue would be added to the run list maintained by
+the scheduling firmware.  Once the queue has been created, the application can
+write packets directly into the queue, update the wptr, and write to the
+doorbell offset to kick off work in the user queue.
+
+When the application is done with the user queue, it would call the USERQ
+FREE IOCTL to destroy it.  The kernel driver would preempt the queue and
+remove it from the scheduling firmware's run list.  Then the IP specific MQD
+would be freed and the user queue state would be cleaned up.
+
+Some engines may require the aggregated doorbell to if the engine does not
+support doorbells from unmapped queues.  The aggregated doorbell is a special
+page of doorbell space which wakes the scheduler.  In cases where the engine may
+be oversubscribed, some queues may not be mapped.  If the doorbell is rung when
+the queue is not mapped, the engine firmware may miss the request.  Some
+scheduling firmware may work around this my polling wptr shadows when the
+hardware is oversubscribed, other engines may support doorbell updates from
+unmapped queues.  In the event that one of these options is not available, the
+kernel driver will map a page of aggregated doorbell space into each GPUVM
+space.  The UMD will then update the doorbell and wptr as normal and then write
+to the aggregated doorbell as well.
+
+Special Packets
+---------------
+
+In order to support legacy implicit synchronization, as well as mixed user and
+kernel queues, we need a synchronization mechanism that is secure.  Because
+kernel queues or memory management tasks depend on kernel fences, we need a way
+for user queues to update memory that the kernel can use for a fence, that can't
+be messed with by a bad actor.  To support this, we've added protected fence
+packet.  This packet works by writing the a monotonically increasing value to
+a memory location that is only the privileged clients have write access to.
+User queues only have read access.  When this packet is executed, the memory
+location is updated and other queues (kernel or user) can see the results.
+
+Memory Management
+=================
+
+It is assumed that all buffers mapped into the GPUVM space for the process are
+valid when engines on the GPU are running.  The kernel driver will only allow
+user queues to run when all buffers are mapped.  If there is a memory event that
+requires buffer migration, the kernel driver will preempt the user queues,
+migrate buffers to where they need to be, update the GPUVM page tables and
+invaldidate the TLB, and then resume the user queues.
+
+Interaction with Kernel Queues
+==============================
+
+Depending on the IP and the scheduling firmware, you can enable kernel queues
+and user queues at the same time,  However, you are limited by the HQD slots.
+Kernel queues are always mapped so any work the goes into kernel queues will
+take priority.  This limits the available HQD slots for user queues.
+
+Not all IPs will support user queues on all GPUs.  As such, UMDs will need to
+support both user queues and kernel queues depending on the IP.  For example, a
+GPU may support user queues for GFX, compute, and SDMA, but not for VCN, JPEG,
+and VPE.  UMDs need to support both.  The kernel driver provides a way to
+determine if user queues and kernel queues are supported on a per IP basis.
+UMDs can query this information via the INFO IOCTL and determine whether to use
+kernel queues or user queues for each IP.
+
+Queue Resets
+============
+
+For most engines, queues can be reset individually.  GFX, compute, and SDMA
+queues can be reset individually.  When a hung queue is detected, it can be
+reset either via the scheduling firmware or MMIO.  Since there are no kernel
+fences for most user queues, they will usually only be detected when some other
+event happens; e.g., a memory event which requires migration of buffers.  When
+the queues are preempted, if the queue is hung, the preemption will fail.
+Driver will them look up the queues that failed to preempt and reset them and
+record which queues are hung.
+
+
+On the UMD side, we will add an USERQ QUERY_STATUS IOCTL to query the queue
+status.  UMD will provide the queue id in the IOCTL and the kernel driver
+will check if it has already recorded the queue as hung (e.g., due to failed
+peemption) and report back the status.
+
+IOCTL Interfaces
+================
+
+GPU virtual addresses used for queues and related data (rptrs, wptrs, context
+save areas, etc.) should be validated by the kernel mode driver to prevent the
+user from specifying invalid GPU virtual addresses.  If the user provides
+invalid GPU virtual addresses or doorbell indicies, the IOCTL should return an
+error message.  These buffers should also be tracked in the kernel driver so
+that if the user attempts to unmap the buffer(s) from the GPUVM, the umap call
+would return an error.
+
+INFO
+----
+There are several new INFO queries related to user queues in order to query the
+size of user queue meta data needed for a user queue (e.g., context save areas
+or shadow buffers), and whether kernel or user queues or both are supported
+for each IP type.
+
+USERQ
+-----
+The USERQ IOCTL is used for creating, freeing, and querying the status of user
+queues.  It supports 3 opcodes:
+
+1. CREATE - Create a user queue.  The application provides a MQD-like structure
+   that devices the type of queue and associated metadata and flags for that
+   queue type.  Returns the queue id.
+2. FREE - Free a user queue.
+3. QUERY_STATRUS - Query that status of a queue.  Used to check if the queue is
+   healthy or not.  E.g., if the queue has been reset. (WIP)
+
+USERQ_SIGNAL
+------------
+The USERQ_SIGNAL IOCTL is used to provide a list of sync objects to be signaled.
+
+USERQ_WAIT
+----------
+The USERQ_WAIT IOCTL is used to provide a list of sync object to be waited on.
+
+Kernel and User Queues
+======================
+
+In order to properly validate and test performance, we have a driver option to
+select what type of queues are enabled (kernel queues, user queues or both).
+The user_queue driver parameter allows you to enable kernel queues only (0),
+user queues and kernel queues (1), and user queues only (2).  Enabling user
+queues only will free up static queue assignments that would otherwise be used
+by kernel queues for use by the scheduling firmware.  Some kernel queues are
+required for kernel driver operation and they will always be created.  When the
+kernel queues are not enabled, they are not registered with the drm scheduler
+and the CS IOCTL will reject any incoming command submissions which target those
+queue types.  Kernel queues only mirrors the behavior on all existing GPUs.
+Enabling both queues allows for backwards compatibility with old userspace while
+still supporting user queues.
-- 
2.49.0

