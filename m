Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6326FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 14:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 637C718B8EF;
	Tue, 19 Jul 2022 14:04:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB8AF18B8D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 14:04:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrhEfkNv/lioBJWP4AUKB/8Ex1Pojw9o+BVFTkq7lSxjLthz6FoTOp7AktAdqbLveFTrbg2JLoutAn3giD8R0v/IjKSUFXt+GfoVB08ZI3wysbyDR6sQ5pyGSBCbc5uY6F4hZN/+hQYq0yX+0yw8JvCildJE/rBy2Dm5BinMF8ar9tBoHSFACvRtrxrKGTHOw94uOvTrzp64r9ddVfH13IagR/R7+Z8hSvH7faxULAErj/gjjWrFM1cNmzzr5tPS1XYY89Vek9Ky5unrVjqZeFJVBToF3+P+Hj/uzchMJngPs6eGJeuPbRPNoITSPIGfMhWptt15GkNofrc8Pw8zBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxw8L7sncsVzki1Erj4COZeb8+KBN8CayXCrlEdVJKk=;
 b=EYqPCEKU0jVdRSstnuO3fQR73MN/Uqw2SwOgd59WKKDbRvSDft9eb+plUaRywB9cqXBB0MMml/RLNuDKTKiJJN4yRgkMBE7kQfcc5zJ3F6WVsCT69Ztr2oPZ8DcWg3rBVwm3cJ87t3g3rtD4jSCMoSDcAV6fzHGLacxhngFG5HxSN/4A8bjN58HebmEzjH6ae4wmEvbrbo7jOcVEpBZph/USCeFLASlcWUPAvJSzCWhAcnKIkqwM6Ki2+D0PFx6xXLL7jOWuotOs7KZvvWSVH4NT4Q0RqnAtjhxB8o3F/1RbF6u5eTfmNdDgsQnGaWtGDZAW3crlpBqjXYNHaZgc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxw8L7sncsVzki1Erj4COZeb8+KBN8CayXCrlEdVJKk=;
 b=BLRCBCKIZ8YR4pdeBi5J+5ZxLkDpE8cgASJJbyAeOSywmvNoSWpBEC2u9X7NOIz06UGOnrs2NReJnN1ADGzgRwpT5OyYSc+/nLwBMzhEJFVH9Ae7Bz27ttwJs53pRW/74IRyk4amkTrHIv9TkjoxTeSc/keOXcFdV4GORo+gv6w=
Received: from BN9P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::33)
 by BN8PR12MB3378.namprd12.prod.outlook.com (2603:10b6:408:61::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Tue, 19 Jul
 2022 14:04:32 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::b5) by BN9P223CA0028.outlook.office365.com
 (2603:10b6:408:10b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12 via Frontend
 Transport; Tue, 19 Jul 2022 14:04:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Tue, 19 Jul 2022 14:04:31 +0000
Received: from david-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 19 Jul
 2022 09:04:30 -0500
From: <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amd/kfd: Update documentation to match kernel
 standards
Date: Tue, 19 Jul 2022 10:03:36 -0400
Message-ID: <20220719140338.1644486-2-David.Francis@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719140338.1644486-1-David.Francis@amd.com>
References: <20220719140338.1644486-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 686749ed-3cb2-4580-49f2-08da698f9a80
X-MS-TrafficTypeDiagnostic: BN8PR12MB3378:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CY7Lo2pWaK818XnrDAY1z9YSkb2SOGxoj93faTqoC3XYMw+uRkaidid8vKdZTvElnzEi9USj+pyrxrSrTCl2UjryjN4j6oN3QtJtZmnYshfCyuEj10ojDF8EpxCsAtq+r4KVNPNfnCksXcWP00UytNLKoKnXKlHuOofZZLThXYrDk5p+SH8xpQ4YRofXokkh2TpZDEGQhBKSQ9MdgD762chkgD+xYi42qAXOW24qN81dCxLXWX+ktzBSarWlXYLVFaLhVBajFMVSuLoNhj9ehhspj/+izND3bDSknW+bfA2kJ5cmdWYMIe4ZuIZ3gh7jMZrHUN/3c0ylYZtCWpg1ILts9DRcsL0gJ+7Imvgcd6GQLqDMWISwJ4ssS7qV9RVNC/0z8vYEFVVpv9LmFsbqD0WOOhdURlFam3Mv+egNc4HkID3UqJBguZMOaVvZrbBwec96vgqnrGFKIj5ri7Hl4RmA+GWH/mzYOR/fHLol4rwdm6Oo71urcJTdEqFNRgev4a6pAy1KdneqCaHzxnlMWdirlj4Wsd0R4SYgX3OXgQFJtj2CSdcRHH3LvflnsQJW+TPK1/OGCJDbiPqbVUCpDPi+eTaabcD475ZyI3KHM7oKfI8diYFbBgvmkUpFwA7M3iovrKsDZvgJMkKK8azkxTXrrYrem74HQwtc7QxvQhg81uT82LdekDELjbDpGeNB2r4TcyA4WIAV0KRXdkbwe4XXleBGiKBGkAMCV5AIMPYvZhYXlDitaGYLuwsz0ovaE/BDBwHF/Fqc3qe3cbuafmOjcuZeazKXKDXpNRTkvYHKWrLYGzNKXj2Di0KTQVJcWA+6LsK4oCC1Rl+B66BUrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(376002)(36840700001)(40470700004)(46966006)(82310400005)(40460700003)(26005)(6916009)(16526019)(2616005)(426003)(1076003)(186003)(41300700001)(36756003)(2876002)(336012)(478600001)(47076005)(70206006)(40480700001)(36860700001)(54906003)(2906002)(86362001)(316002)(8936002)(81166007)(83380400001)(356005)(4326008)(7696005)(5660300002)(82740400003)(8676002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 14:04:31.6404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 686749ed-3cb2-4580-49f2-08da698f9a80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3378
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

The kernel documentation system requires things to be just so
in order to incorporate documentation into the sphinx system.

There were some comments in amdkfd which didn't meet that
standard. Tweak them so they do.

Signed-off-by: David Francis <David.Francis@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 27 +++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c   |  4 +--
 include/uapi/linux/kfd_ioctl.h               | 33 +++++++++++---------
 3 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index 8aebe408c544..075e4c80dd04 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -37,11 +37,14 @@
 #include <linux/mman.h>
 #include <linux/processor.h>
 
-/*
+/**
+ * DOC: Memory_Features
+ *
  * The primary memory I/O features being added for revisions of gfxip
  * beyond 7.0 (Kaveri) are:
  *
  * Access to ATC/IOMMU mapped memory w/ associated extension of VA to 48b
+ * ----------------------------------------------------------------------
  *
  * “Flat” shader memory access – These are new shader vector memory
  * operations that do not reference a T#/V# so a “pointer” is what is
@@ -55,6 +58,7 @@
  *
  *
  * System Unified Address - SUA
+ * ----------------------------
  *
  * The standard usage for GPU virtual addresses are that they are mapped by
  * a set of page tables we call GPUVM and these page tables are managed by
@@ -72,13 +76,16 @@
  * There are three fundamental address modes of operation for a given VMID
  * (process) on the GPU:
  *
- *	HSA64 – 64b pointers and the default address space is ATC
- *	HSA32 – 32b pointers and the default address space is ATC
- *	GPUVM – 64b pointers and the default address space is GPUVM (driver
- *		model mode)
+ * HSA64 – 64b pointers and the default address space is ATC
+ *
+ * HSA32 – 32b pointers and the default address space is ATC
+ *
+ * GPUVM – 64b pointers and the default address space is GPUVM (driver
+ * model mode)
  *
  *
  * HSA64 - ATC/IOMMU 64b
+ * ---------------------
  *
  * A 64b pointer in the AMD64/IA64 CPU architecture is not fully utilized
  * by the CPU so an AMD CPU can only access the high area
@@ -99,6 +106,7 @@
  *
  *
  * 64b to 49b Address conversion
+ * -----------------------------
  *
  * Note that there are still significant portions of unused regions (holes)
  * in the 64b address space even for the GPU.  There are several places in
@@ -147,6 +155,7 @@
  *
  *
  * “Spare” aperture (APE1)
+ * -----------------------
  *
  * We use the GPUVM aperture to differentiate ATC vs. GPUVM, but we also use
  * apertures to set the Mtype field for S_LOAD/FLAT_* ops which is input to the
@@ -160,6 +169,7 @@
  *
  *
  * General Aperture definitions and rules
+ * --------------------------------------
  *
  * An aperture register definition consists of a Base, Limit, Mtype, and
  * usually an ATC bit indicating which translation tables that aperture uses.
@@ -187,6 +197,7 @@
  *
  *
  * HSA32 - ATC/IOMMU 32b
+ * ---------------------
  *
  * For HSA32 mode, the pointers are interpreted as 32 bits and use a single GPR
  * instead of two for the S_LOAD and FLAT_* ops. The entire GPUVM space of 40b
@@ -196,6 +207,7 @@
  *
  *
  * GPUVM 64b mode (driver model)
+ * -----------------------------
  *
  * This mode is related to HSA64 in that the difference really is that
  * the default aperture is GPUVM (ATC==0) and not ATC space.
@@ -204,6 +216,7 @@
  *
  *
  * Device Unified Address - DUA
+ * ----------------------------
  *
  * Device unified address (DUA) is the name of the feature that maps the
  * Shared(LDS) memory and Private(Scratch) memory into the overall address
@@ -220,6 +233,7 @@
  *
  *
  * HSA64 Apertures for FLAT_* vector ops
+ * -------------------------------------
  *
  * For HSA64 SUA mode, the Shared and Private apertures are always placed
  * in the hole w/ a limited selection of possible locations. The requests
@@ -231,6 +245,7 @@
  *
  *
  * HSA32 Apertures for FLAT_* vector ops
+ * -------------------------------------
  *
  * In HSA32 mode, the Private and Shared apertures can be placed anywhere
  * in the 32b space except at 0 (Private or Shared Base at zero disables
@@ -239,6 +254,7 @@
  *
  *
  * GPUVM Apertures for FLAT_* vector ops
+ * -------------------------------------
  *
  * In GPUVM mode, the Shared/Private apertures are specified identically
  * to HSA64 mode where they are always in the hole at a limited selection
@@ -246,6 +262,7 @@
  *
  *
  * Aperture Definitions for SUA and DUA
+ * ------------------------------------
  *
  * The interpretation of the aperture register definitions for a given
  * VMID is a function of the “SUA Mode” which is one of HSA64, HSA32, or
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
index a9466d154395..d53ffff2635a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
@@ -21,8 +21,8 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
-/*
- * KFD Interrupts.
+/**
+ * DOC: KFD_Interrupts
  *
  * AMD GPUs deliver interrupts by pushing an interrupt description onto the
  * interrupt ring and then sending an interrupt. KGD receives the interrupt
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index afd8ff29c74f..248c4b2f85d6 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -367,7 +367,8 @@ struct kfd_ioctl_acquire_vm_args {
 #define KFD_IOC_ALLOC_MEM_FLAGS_COHERENT	(1 << 26)
 #define KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED	(1 << 25)
 
-/* Allocate memory for later SVM (shared virtual memory) mapping.
+/**
+ * struct kfd_ioctl_alloc_memory_of_gpu_args - Allocate memory for later SVM (shared virtual memory) mapping.
  *
  * @va_addr:     virtual address of the memory to be allocated
  *               all later mappings on all GPUs will use this address
@@ -396,7 +397,8 @@ struct kfd_ioctl_free_memory_of_gpu_args {
 	__u64 handle;		/* to KFD */
 };
 
-/* Map memory to one or more GPUs
+/**
+ * struct kfd_ioctl_map_memory_to_gpu_args - Map memory to one or more GPUs
  *
  * @handle:                memory handle returned by alloc
  * @device_ids_array_ptr:  array of gpu_ids (__u32 per device)
@@ -544,7 +546,7 @@ enum kfd_criu_op {
 };
 
 /**
- * kfd_ioctl_criu_args - Arguments perform CRIU operation
+ * struct kfd_ioctl_criu_args - Arguments perform CRIU operation
  * @devices:		[in/out] User pointer to memory location for devices information.
  * 			This is an array of type kfd_criu_device_bucket.
  * @bos:		[in/out] User pointer to memory location for BOs information
@@ -616,7 +618,7 @@ enum kfd_mmio_remap {
 #define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED   0x00000040
 
 /**
- * kfd_ioctl_svm_op - SVM ioctl operations
+ * enum kfd_ioctl_svm_op - SVM ioctl operations
  *
  * @KFD_IOCTL_SVM_OP_SET_ATTR: Modify one or more attributes
  * @KFD_IOCTL_SVM_OP_GET_ATTR: Query one or more attributes
@@ -626,7 +628,8 @@ enum kfd_ioctl_svm_op {
 	KFD_IOCTL_SVM_OP_GET_ATTR
 };
 
-/** kfd_ioctl_svm_location - Enum for preferred and prefetch locations
+/**
+ * enum kfd_ioctl_svm_location - Enum for preferred and prefetch locations
  *
  * GPU IDs are used to specify GPUs as preferred and prefetch locations.
  * Below definitions are used for system memory or for leaving the preferred
@@ -638,7 +641,7 @@ enum kfd_ioctl_svm_location {
 };
 
 /**
- * kfd_ioctl_svm_attr_type - SVM attribute types
+ * enum kfd_ioctl_svm_attr_type - SVM attribute types
  *
  * @KFD_IOCTL_SVM_ATTR_PREFERRED_LOC: gpuid of the preferred location, 0 for
  *                                    system memory
@@ -667,7 +670,7 @@ enum kfd_ioctl_svm_attr_type {
 };
 
 /**
- * kfd_ioctl_svm_attribute - Attributes as pairs of type and value
+ * struct kfd_ioctl_svm_attribute - Attributes as pairs of type and value
  *
  * The meaning of the @value depends on the attribute type.
  *
@@ -680,14 +683,16 @@ struct kfd_ioctl_svm_attribute {
 };
 
 /**
- * kfd_ioctl_svm_args - Arguments for SVM ioctl
+ * struct kfd_ioctl_svm_args - Arguments for SVM ioctl
+ *
+ * @op: specifies the operation to perform (see enum kfd_ioctl_svm_op).
+ * @start_addr: starting virtual address of SVM range
+ * @size: size of SVM range
  *
- * @op specifies the operation to perform (see enum
- * @kfd_ioctl_svm_op).  @start_addr and @size are common for all
- * operations.
+ * @attrs: a variable number of attributes to set / get
+ * @nattr: the number of attributes.
  *
- * A variable number of attributes can be given in @attrs.
- * @nattr specifies the number of attributes. New attributes can be
+ * New attributes can be
  * added in the future without breaking the ABI. If unknown attributes
  * are given, the function returns -EINVAL.
  *
@@ -727,7 +732,7 @@ struct kfd_ioctl_svm_args {
 };
 
 /**
- * kfd_ioctl_set_xnack_mode_args - Arguments for set_xnack_mode
+ * struct kfd_ioctl_set_xnack_mode_args - Arguments for set_xnack_mode
  *
  * @xnack_enabled:       [in/out] Whether to enable XNACK mode for this process
  *
-- 
2.25.1

