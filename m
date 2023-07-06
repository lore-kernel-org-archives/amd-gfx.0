Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4254EB64DD
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 12:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 368C310E427;
	Thu,  6 Jul 2023 12:36:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E0FB10E050
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 12:36:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBYc1eR26qn8DX6p8bhsSI7q4bt74oPZMkHJm96GmFiokglALA9ZUh9NMedbPfc3yvskDel+y9MK7W4vQQ+FfAcD28tNKCbUYzCEyO3Xrl9Ag4EIbSpSrrCwO76XUe+1Kcq/eitQi1V9yNDlpdxfQPLDyiYjHMHt5wtbjcabizmyQHvRb6X34cfjiXGCjdHzTRi9bqWNtLJsS8hVvQC5WKLWVPScGmE+xxMN7TlIN4mzooHso9oRSgj+qkvasnwyDKP6hXurhTN2zhE1OyKIqEogOcoYQ9IuJPE+FdO7tXpGQOBQ4xD2Lr+00Tjyy0+W6D3FmXjH9wu0uQhnm6w/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+NQNBi5ZiYPLXZQ8+3lR7scz1UBrOZBahmDzLg2gOY=;
 b=iedsrxym0mBtMlkPtTKYQ13i0q0bLXy1SPBkRU3DhQ6pV8s9ILR9m/T7eI8RsWxNyg2Xbb7LJxLs/P0csukqROrWD97SuozI/IzTr2BXMm8EPO1FphpF9+M6eTwcnQPuFNcYSOMVUz6GwpfuCr1JOVlb5NwkmDkyqaDg9F7M9anvnNqAOWaNiLdqQsBo6p2Zivm3W+uzGm6RRPwKovsTG2sRnJM7GECmr/2dKO5hOvgufRTyMzCkQ8wduJm4LJt0jGyQNYPQw4wlSrm6kaLtQf0Qsb+xtYln+YeVA+GcGR/Zq0pltvFgtKGTF0TnPTyO2LeKntg59E+M0Ixg7QElwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+NQNBi5ZiYPLXZQ8+3lR7scz1UBrOZBahmDzLg2gOY=;
 b=trOLb49dTDCmQiqAZtmIOmZ99U6io/2cwPtZRTawc/MPs8fPiZT9V9TFMxPWB7wc4T1Qo/KK3Q7zbtrU42zUdCVvYnfWBZopcIpIEdcT1ZqTYRd7hB/ZyN4eAueV3JjHmWJK8lxoUdrO5yB1laxVCmqLZJ+jHrf11P+Ygt03cJA=
Received: from DM6PR12CA0035.namprd12.prod.outlook.com (2603:10b6:5:1c0::48)
 by SJ1PR12MB6050.namprd12.prod.outlook.com (2603:10b6:a03:48b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 12:36:30 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::a8) by DM6PR12CA0035.outlook.office365.com
 (2603:10b6:5:1c0::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 12:36:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 12:36:30 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 07:36:27 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 01/10] drm/amdgpu: UAPI for user queue management
Date: Thu, 6 Jul 2023 14:35:53 +0200
Message-ID: <20230706123602.2331-2-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230706123602.2331-1-shashank.sharma@amd.com>
References: <20230706123602.2331-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT012:EE_|SJ1PR12MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c655775-b6fd-423a-37ac-08db7e1d9ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8pCCWec8XXo/z+OcjsmVW1Ix8/W3kX7z9kOpgi0XV36Ng+r72e7LWb+Cxd2vSZdHWMI93svWhGBxqHtWv18/h6cuojYWfHYiU3fzI6HYXCf13KOZjL4ENBUF7SDGBg7BXfQcBzO0ZZF2RBfdRHZTq+4Wrs/THNFkM1mAVDz9gWFGwpcuTpv/ZdZlBM5m2UnXxch0Rwmg1vgGLkRDdUlRjc79c5sQU1gBEgrVXQiW6Qe6GCYJITFvGTFvbOTYck41qDIUA7VBcfxKcEC88IBGCLKYWzZyi4X90vQv2QXcO2mjkiUkRwa4verWrutdPyrwZDXTHIY0pyTuKHTGrDRjKXDhMbfW6weVg1QFKY36JUAxHJ+XRIEAjeWcpb97lcgp/pCJwFfm4Y8HXQ6+b2HfC9BGxq3b6oZZLknwSCGCsaWXdRaVjh8A9V0YzWv8t+uftYEB+EjYCeGG3x/0ZUY/XLB7FvBpNtbknh0fDuf14mu1l8dXme4UtHtbqynaupoL3yFvjE9aWGofUvSGmyORIpwQXpuQmjKEBWdB4+WnbEcod4Kh7KL3q+zBzmp9uMWUuo1cPj/LWdTnTZHKyN5NSF7I9FA+WqvO7ETu57+fvLbncLYB/tWZuOl6gQZ+L/gHWLwN5LRN7yef94JLyz7206lnx1udMFIFYFrHBqqJCu3+dJ6hhsmqe7s1cRp7JjGhBSFiVFqvwkC302WsXNwNUMk4O6N70dkIAqTHacWh/lFYug0QgWlIKRZic8d3miZsXfuhQDpvh0sqZ78bBoSV5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(40470700004)(46966006)(36840700001)(66574015)(426003)(356005)(44832011)(54906003)(47076005)(70586007)(70206006)(26005)(1076003)(83380400001)(478600001)(36860700001)(2616005)(86362001)(82740400003)(81166007)(6916009)(4326008)(2906002)(5660300002)(7696005)(8676002)(316002)(8936002)(40460700003)(6666004)(82310400005)(40480700001)(186003)(336012)(16526019)(36756003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:36:30.5009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c655775-b6fd-423a-37ac-08db7e1d9ff4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6050
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
index b6eb90df5d05..4f1178c6ee34 100644
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
@@ -302,6 +304,114 @@ union drm_amdgpu_ctx {
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
2.40.1

