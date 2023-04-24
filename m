Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48609C77B78
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 17:39:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3C5910E070;
	Mon, 24 Apr 2023 17:39:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD0B810E070
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 17:39:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b52fUcYpJ75Ja3Q9QPbEVbEdRug5wryWPTSk550IFnnoGigrUmFFVnDxEnbm3pLFyeAA1ck5qtwKUgHVxraQEBHNgnUCtOnpCauM+6oTi6UNMy3pihdUQ8gmrzlmty1zguCsFdlHLMdwl8WIXmgV4HqfSEWz1rNLNxl8oFKL4Cs3vOaebqMWArluDAVVPqzKXiQ37U8eEhqUTx1S3XOBl7qKVP5wYBLbKqeF8K9R55dCQpuwxIMffyN5tiDZVVVZBPgwJLcopQ9R6U38fLj73OVj39/BzkJ59UvkMR3x0GbLwSB1TJwziP88nvUo/aSZ7vhnnwm5qYLIwpEuu5jDOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p286hAvftpijY2ShwoXc6sB0dI3Jyh1IUn69Mvts23c=;
 b=YLn/LMFpbXiuKvYT0A/SovZ/Xa9MtsWM7cx/wpoXXTVbEeTMFtRsvUzxD4io/zUoWzPZVbryp9H0788x+uHSGwPB0ODYnIenFqVBmjLdipa8pYZPLPuGu1VL57BIFVUWqpuyoKrZ4G+Nje3jV/GMSV5+aNuYwKjbcn35Q8vbLU+zbzp/mKQAlgJsVjbkQEFZXhYIl4VjGXIZX9hrm6VJCmZurNHzkey8j47k1E/kUWPpTVrLgVPsCJkjQXsAxV9sBMdm0epqHKKPHKNVXvO2/k5oOkc41qIPU7f2bcaewXdmyqTxzuODhWczx/vk4sBKJ2zczrGZ2AjkpHZ/BO/2UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p286hAvftpijY2ShwoXc6sB0dI3Jyh1IUn69Mvts23c=;
 b=Ump34CXBnHnWXStn/hZ3OdqzhhIgmN5zgq91ni83+3FblzaPSr9ici5LfiKUeqxXSnjz/gmxU7NhnK2lxBkFyKkZFO+UDQoDV+VmzNhOmihumOu1pCYjRLlJbox7FlyVggpcmr4U6dUJ+OjEBM6yK7O1ymexqP/DbhPjCyUl1gw=
Received: from MW4PR04CA0309.namprd04.prod.outlook.com (2603:10b6:303:82::14)
 by DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.33; Mon, 24 Apr 2023 17:39:06 +0000
Received: from CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::84) by MW4PR04CA0309.outlook.office365.com
 (2603:10b6:303:82::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 17:39:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT077.mail.protection.outlook.com (10.13.175.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.19 via Frontend Transport; Mon, 24 Apr 2023 17:39:05 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 24 Apr
 2023 12:39:03 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 01/10] drm/amdgpu: UAPI for user queue management
Date: Mon, 24 Apr 2023 19:38:26 +0200
Message-ID: <20230424173836.1441-2-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230424173836.1441-1-shashank.sharma@amd.com>
References: <20230424173836.1441-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT077:EE_|DM4PR12MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: 2029e472-0c2c-4fcb-e5b8-08db44eacd1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4AexLA04rZpT1htQClnci6/sAPxq9i0MjD06FzwarNAdt6oOgEg15yXqbhS5fpdronp6y0yQRO/667S22HQivzlmtiYUEAiphR8Ef+CxYZ36yABeUvmcC00NJI2d6BIKahQAlICYRvEJgsPj+Q2RNsHAt9u3d6U3MoFfShEhO42/XRhj9NhMrzQ+t52wCW+oLHIyx/8GIJT3BPyLrFUnTSjn7RiK9NckhpzvKeQSV3WctrjitQPl10ecOt1u49zxjUZxBglyuUQI+CEznj2BjsfExU1B0kgzdex/tKLhbb2iY+zrHvGo/jBaOuOHj2nRv3Q+4nwT0Dm0BJf96UbRKotqnbOvzPmfKhahqsokNj/dL3RDRT88HEC+W7qOZTVBe8L8yh8taaaa4umv/wgPEHmRNDoOjLLTI+7TlvtLH1OLHsJon+SBkhC8yDhKplvudL5c3V1i/EoBWRipOjqO0jYPqR7sg94q151Pe7/DuTOOp6MYC3uV24Hut6j60oT/o71GKxB+hgIe/JP2D727EaMnqpshf7E7QD+sW476A2fiSE7GTdR48zJhhaVoyxSXKlT0CwkuC/RmVM8SXzE/z2Nt8gPwQqzn0zr8l2bvxqbqz0jPUVPup8BhEASkEdKD3qypbRVzbrMtkb00m65tZPKZKG5hFON5dSsX734GKNDIR3+5ZYtA5QUTaJp9TBtKLQbvrSIbdywN7Tg1D307VIns1ZPZjslDrI+jtprBrRQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(40470700004)(36840700001)(46966006)(36756003)(8676002)(8936002)(54906003)(40460700003)(478600001)(4326008)(6916009)(70206006)(70586007)(40480700001)(356005)(44832011)(81166007)(316002)(41300700001)(82740400003)(2906002)(5660300002)(2616005)(86362001)(36860700001)(186003)(16526019)(336012)(426003)(26005)(1076003)(7696005)(6666004)(47076005)(83380400001)(66574015)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 17:39:05.6106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2029e472-0c2c-4fcb-e5b8-08db44eacd1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6351
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
Cc: pierre-eric.pelloux-prayer@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>, arvind.yadav@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, contactshashanksharma@gmail.com,
 Christian Koenig <christian.koenig@amd.com>
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

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 95 +++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 4038abe8505a..083a1df8e8ef 100644
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
@@ -302,6 +304,99 @@ union drm_amdgpu_ctx {
 	union drm_amdgpu_ctx_out out;
 };
 
+/* user queue IOCTL */
+#define AMDGPU_USERQ_OP_CREATE	1
+#define AMDGPU_USERQ_OP_FREE	2
+
+#define AMDGPU_USERQ_MQD_FLAGS_SECURE	(1 << 0)
+#define AMDGPU_USERQ_MQD_FLAGS_AQL	(1 << 1)
+
+/*
+ * MQD (memory queue descriptor) is a set of parameters which allow
+ * the GPU to uniquely define and identify a usermode queue.
+ */
+struct drm_amdgpu_userq_mqd_gfx {
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
+};
+
+ /*
+  * MQD can be different for different GPU IP/engine. This union will
+  * contain structures of MQDs corresponding to different engines.
+  */
+union drm_amdgpu_userq_mqd {
+	struct drm_amdgpu_userq_mqd_gfx gfx;
+};
+
+struct drm_amdgpu_userq_in {
+	/** AMDGPU_USERQ_OP_* */
+	__u32	op;
+	/** Flags */
+	__u32	flags;
+	/** Queue handle for USERQ_OP_FREE */
+	__u32	queue_id;
+	/** the target GPU engine to execute workload (AMDGPU_HW_IP_*) */
+	__u32   ip_type;
+
+	/** Queue descriptor for USERQ_OP_CREATE */
+	union drm_amdgpu_userq_mqd mqd;
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
2.40.0

