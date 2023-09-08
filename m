Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB070EE8019
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 16:05:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC47510E0F6;
	Fri,  8 Sep 2023 16:05:10 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F52010E0E8
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 16:05:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/HImxl1o8jczvXqzh3ZBcCU+Vs8iro8iaoUF1mqZv+eoUyaMuzNbzvCYAO2DHo3i3+KKEFrvo7MCniEi4DZkOM/1YXeTweE+tnzTRrKixSlybK/ZqJqeaTA7+3lhgmDakUJFtrIxv6chsSX0rU+tRPDvp32EYtZezW2mvJYBqR3KNb8G+GK0wGMcPferma5nq3Nprb8QIqI5XsyF8vswF1lD8MpsaITZtOoOZnItaqbgAu06/hZl7UCcwRBK1VVpnAmD9fOHaqPdcB7oZaZ6NGEisopZRdfk6a4tRh3Z1vhEKMZKA4Yz5xRyhIMXWbJ8jePJ7T0Z66mYzVNOUjQGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQceNQ8DbXdIs7TA7XiSNRxaEjGOdDuaRYgieGmp5iA=;
 b=K8lPz/v9yjh76M8Ve/m0ag/YaGsL7bgImRm4DWwaFTOKrzoD/UMPnzNdMko1tFkz7LUrFbPWn1VNAOwL530xvvI3BcC/nw3RJ0w1UZfJN/yOJrr4jyfrJp1134NvD5oxYdvnjad+WwkGGWh9F0nAf3YF0u23gLY6iWehHSIrHkQOzrWV9deKOb2nj6YMZiG0So2CsjDcexpkqU3nKv3v/0Qb/3xHldjhQoBMPUmmrrPw28kHXK95PcIeEh4Mz2pyvockS7Fich3ZqvllYJ23K41Y3oxphcB5pvgAXmJm/rXcsHPGueQeeEoUDw12UO0OvamK6dmKUuyb5zNmi9v8rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQceNQ8DbXdIs7TA7XiSNRxaEjGOdDuaRYgieGmp5iA=;
 b=CNDd4OOaUo7iiqgMfUPCRc19scsaZn3exdiM/H4vsx3TQo19epCUHY4zhwnJX0kIRsqaDNX26NnJXQzoSRfD+kIqTQ8QpSSoaGOHlRNbxoFQij6bJjw2Dh/Gy+Fgm8ooiU4vfqO0MrEty26VPel262EgLPaXM3F2ZPgsTY24gCg=
Received: from SA1P222CA0144.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::22)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 16:05:05 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:3c2:cafe::49) by SA1P222CA0144.outlook.office365.com
 (2603:10b6:806:3c2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31 via Frontend
 Transport; Fri, 8 Sep 2023 16:05:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Fri, 8 Sep 2023 16:05:05 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 11:05:03 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 1/9] drm/amdgpu: UAPI for user queue management
Date: Fri, 8 Sep 2023 18:04:38 +0200
Message-ID: <20230908160446.2188-2-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230908160446.2188-1-shashank.sharma@amd.com>
References: <20230908160446.2188-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: c0db09d0-3d2a-4583-4ba1-08dbb0855ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q3O/I+vxjJ5/aq1GBG6yAEhCDkqKOSKU0/4OsCDIcVLq+cwwK7iGxnKaDiVWkM6hExrq8AybIakLbjce3Qg5SKSN7skdtwIqP7yfek/3xl4i9vMCGfyJFJ4x2UxwKNcptvYePfmvuYqdZOCK3QA0+HzJUg3uhDs+0/3FWEp+oA0XHwI1Vw/88jp5c3qsgT5j7q1PLWbSEr4nzMLsiN00C7yEyPJDC3tV1f9EVJKz21uVVxBeF/P73IY5kaXgWhp6FmGfm5N6pdVplMMZKzTBRfG7U/tqwgZQeRhryUR9yjsa0f948AGJFoiqEqAq7lqlS1Z61hRJxhMA5/vYNup6n9rXjBtJUStEd5rA5AwFZDeBwnfZtnmhONTO8TBxWU8PBkUgixVi116GUIJFJfZwKmjM2SX0quqhYwjSXbWwn2TDKuEl626RlIZ1/jivifJ5fcIsa8hHWFy0Mrc5CblOyuhpYWTL1vOEtR7h3/2ut/k3pIqZH0YkcGmUUwOshPWK80fx+7ZTQrI4oIvnkN020tM/ESi4akexTH4B0Yr2B2L0LDmQ24knBUGmgboOotmMvAiWz2aeE8DHJM4YCp0ctBnZmv0q6yI/hu8e8w5wUP5yrK3WFooNiCCZzFrRDPXOLLqeYdJ/BZCcVXkeeq0xIFaHft1t6luYSbj2a8MNWgqkCEE72LL3X0U18GBQ7MA8HkjW6t9Hu9t329HTFEqmarKAwrNJa/NW7d1G6S+MSCoKKHzERE5GnfLyml+j/HIMWP/T/PXBBTq3us98o1/s+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(82310400011)(451199024)(1800799009)(186009)(36840700001)(46966006)(40470700004)(7696005)(6666004)(478600001)(66574015)(83380400001)(26005)(2616005)(1076003)(426003)(336012)(16526019)(2906002)(316002)(6916009)(44832011)(54906003)(70206006)(41300700001)(70586007)(40460700003)(8676002)(5660300002)(4326008)(8936002)(47076005)(82740400003)(86362001)(36860700001)(36756003)(40480700001)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 16:05:05.4486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0db09d0-3d2a-4583-4ba1-08dbb0855ddf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

This patch intorduces new UAPI/IOCTL for usermode graphics
queue. The userspace app will fill this structure and request
the graphics driver to add a graphics work queue for it. The
output of this UAPI is a queue id.

This UAPI maps the queue into GPU, so the graphics app can start
submitting work to the queue as soon as the call returns.

V2: Addressed review comments from Alex and Christian
    - Make the doorbell offset's comment clearer
    - Change the output parameter name to queue_id

V3: Integration with doorbell manager

V4:
    - Updated the UAPI doc (Pierre-Eric)
    - Created a Union for engine specific MQDs (Alex)
    - Added Christian's R-B
V5:
    - Add variables for GDS and CSA in MQD structure (Alex)
    - Make MQD data a ptr-size pair instead of union (Alex)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 110 ++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 79b14828d542..627b4a38c855 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -54,6 +54,7 @@ extern "C" {
 #define DRM_AMDGPU_VM			0x13
 #define DRM_AMDGPU_FENCE_TO_HANDLE	0x14
 #define DRM_AMDGPU_SCHED		0x15
+#define DRM_AMDGPU_USERQ		0x16
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -71,6 +72,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_VM		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_VM, union drm_amdgpu_vm)
 #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
 #define DRM_IOCTL_AMDGPU_SCHED		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
+#define DRM_IOCTL_AMDGPU_USERQ		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
 
 /**
  * DOC: memory domains
@@ -304,6 +306,114 @@ union drm_amdgpu_ctx {
 	union drm_amdgpu_ctx_out out;
 };
 
+/* user queue IOCTL */
+#define AMDGPU_USERQ_OP_CREATE	1
+#define AMDGPU_USERQ_OP_FREE	2
+
+/* Flag to indicate secure buffer related workload, unused for now */
+#define AMDGPU_USERQ_MQD_FLAGS_SECURE	(1 << 0)
+/* Flag to indicate AQL workload, unused for now */
+#define AMDGPU_USERQ_MQD_FLAGS_AQL	(1 << 1)
+
+/*
+ * MQD (memory queue descriptor) is a set of parameters which allow
+ * the GPU to uniquely define and identify a usermode queue. This
+ * structure defines the MQD for GFX-V11 IP ver 0.
+ */
+struct drm_amdgpu_userq_mqd_gfx_v11_0 {
+	/**
+	 * @queue_va: Virtual address of the GPU memory which holds the queue
+	 * object. The queue holds the workload packets.
+	 */
+	__u64   queue_va;
+	/**
+	 * @queue_size: Size of the queue in bytes, this needs to be 256-byte
+	 * aligned.
+	 */
+	__u64   queue_size;
+	/**
+	 * @rptr_va : Virtual address of the GPU memory which holds the ring RPTR.
+	 * This object must be at least 8 byte in size and aligned to 8-byte offset.
+	 */
+	__u64   rptr_va;
+	/**
+	 * @wptr_va : Virtual address of the GPU memory which holds the ring WPTR.
+	 * This object must be at least 8 byte in size and aligned to 8-byte offset.
+	 *
+	 * Queue, RPTR and WPTR can come from the same object, as long as the size
+	 * and alignment related requirements are met.
+	 */
+	__u64   wptr_va;
+	/**
+	 * @shadow_va: Virtual address of the GPU memory to hold the shadow buffer.
+	 * This must be a from a separate GPU object, and must be at least 4-page
+	 * sized.
+	 */
+	__u64   shadow_va;
+	/**
+	 * @gds_va: Virtual address of the GPU memory to hold the GDS buffer.
+	 * This must be a from a separate GPU object, and must be at least 1-page
+	 * sized.
+	 */
+	__u64   gds_va;
+	/**
+	 * @csa_va: Virtual address of the GPU memory to hold the CSA buffer.
+	 * This must be a from a separate GPU object, and must be at least 1-page
+	 * sized.
+	 */
+	__u64   csa_va;
+};
+
+struct drm_amdgpu_userq_in {
+	/** AMDGPU_USERQ_OP_* */
+	__u32	op;
+	/** Queue handle for USERQ_OP_FREE */
+	__u32	queue_id;
+	/** the target GPU engine to execute workload (AMDGPU_HW_IP_*) */
+	__u32   ip_type;
+	/**
+	 * @flags: flags to indicate special function for queue like secure
+	 * buffer (TMZ). Unused for now.
+	 */
+	__u32   flags;
+	/**
+	 * @doorbell_handle: the handle of doorbell GEM object
+	 * associated to this client.
+	 */
+	__u32   doorbell_handle;
+	/**
+	 * @doorbell_offset: 32-bit offset of the doorbell in the doorbell bo.
+	 * Kernel will generate absolute doorbell offset using doorbell_handle
+	 * and doorbell_offset in the doorbell bo.
+	 */
+	__u32   doorbell_offset;
+	/**
+	 * @mqd: Queue descriptor for USERQ_OP_CREATE
+	 * MQD data can be of different size for different GPU IP/engine and
+	 * their respective versions/revisions, so this points to a __u64 *
+	 * which holds MQD of this usermode queue.
+	 */
+	__u64 mqd;
+	/**
+	 * @size: size of MQD data in bytes, it must match the MQD structure
+	 * size of the respective engine/revision defined in UAPI for ex, for
+	 * gfx_v11 workloads, size = sizeof(drm_amdgpu_userq_mqd_gfx_v11).
+	 */
+	__u64 mqd_size;
+};
+
+struct drm_amdgpu_userq_out {
+	/** Queue handle */
+	__u32	queue_id;
+	/** Flags */
+	__u32	flags;
+};
+
+union drm_amdgpu_userq {
+	struct drm_amdgpu_userq_in in;
+	struct drm_amdgpu_userq_out out;
+};
+
 /* vm ioctl */
 #define AMDGPU_VM_OP_RESERVE_VMID	1
 #define AMDGPU_VM_OP_UNRESERVE_VMID	2
-- 
2.42.0

