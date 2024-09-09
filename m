Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFA4ECE588
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 20:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAAF310E67C;
	Mon,  9 Sep 2024 20:07:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4+Jo8meE";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 571E710E67C
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 20:07:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrSMFDzsygfivJpPFJRt/RTth+vo0noAYddznTrA8DTrEczvtiUC/sPcYvCmTc1lw9LYiacFPlD6uGUHJ7aJ8UcSGlOtjEEQ6qVpnrzifTI9LD6gSHaTRbmV8NVLeF63l8A0S7gkN5TpRQ1mD3kT4irqQ8umLN2eAYGGZbUgs1v+KsiNNCX7+LROyBL+BLvvPnSv0iCQX8R0P2YzQVtmyqKrGD0goACuJJFiTNs1c5JJlTbCIe0REMRF8U6aUD5GEQe6ErrD1xRozelMLswEQi3FiNuDyuKwRkpRsNlxSmTiBaiiAVfQx5DfFB4F9DzgTFINLGWpQxRfG8t17laT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYXOqOefQ387QX4TWnpu6q1JHHossWkNjlafQR0KVIg=;
 b=SETMzytonXjIwIA9fmLJOiT62+3qtZWtjWMIk7IMjtfnzRw1QW/yb5hfdosgzBZPVw4zTHbh4MW6Y3YTpUzMYh1c/5N+hLOHgtm9P1aQr/N3CG13npywV9b+8BLeORWDtcyGMvaDOHJ65fEQ/vozFFDWkO+EQxtU8aqv7fhggzhNbySgtCHqSDgYgGHi/GnlR8FZLoJz6R+6PYO9ELZacznTCb7XC558aelYyXajcb1t3aeOMW61Y9DHo2XgtnmLgfC9V3P+c6xdppOYHqV7LJLJWN7CwD3Pb6NeiFHYxgVd7nXI7AxXA9aBLb9bG27UYrU3+h9NY7UJGLYKskUfSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYXOqOefQ387QX4TWnpu6q1JHHossWkNjlafQR0KVIg=;
 b=4+Jo8meEyNSLJl6Ot1TYA8y4KEcQVvPSo1CktkwrJsCbI4q5OlzfMLDYN1UxCYw/m2uP/TXM4TjBZ4ieIkq7Qalm7BXN9dOYSna4b+fTjLF8K3t0RU6Z+c7HQDzpFL06eRIjMn26l+38CQD+9ncwo7KNKGJ17GmIHTuf0/VRFcg=
Received: from SA0PR11CA0040.namprd11.prod.outlook.com (2603:10b6:806:d0::15)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Mon, 9 Sep
 2024 20:06:56 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:d0:cafe::59) by SA0PR11CA0040.outlook.office365.com
 (2603:10b6:806:d0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 9 Sep 2024 20:06:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 20:06:56 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:06:54 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Christian Koenig
 <christian.koenig@amd.com>, Shashank Sharma <shashank.sharma@amd.com>
Subject: [PATCH v11 01/28] drm/amdgpu: UAPI for user queue management
Date: Mon, 9 Sep 2024 22:05:52 +0200
Message-ID: <20240909200614.481-2-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240909200614.481-1-shashank.sharma@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b61611-7e5f-41d1-936a-08dcd10af488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkxZSFRpUnFXdzRKUGdNUWpSaXEwVzBPTDYvcFZZckdEMVd4S2hIMVMzeHlX?=
 =?utf-8?B?RlE2QTlkSkZrSmFWMjhWTTRGdmNVODNFVHgvRmFhTUc2blhjQnU1MktEM2ZH?=
 =?utf-8?B?MkYzV0FRK0dQVlF1R1Z4cXB2NG5NNDE5V0xGL1A0UlhpQTlHUzlCeEJQSXhY?=
 =?utf-8?B?WGdWcHlhSXd5RVpJcUsvNjRaUmJKcWxYVUFQeDNTVERxR3ByZVYxWTRqN1Zi?=
 =?utf-8?B?OU5wUzNhR2ZlNjJ2VlBpbDlZMU5KQ3daNDk1TStDcmU5MFhRejdweGk4bWFh?=
 =?utf-8?B?WWI3bkhxazcrQVl5RFFzM0dkUkRyVzcwOUVwYW1tdVBVYXErSTE4N1V1S0dt?=
 =?utf-8?B?TEdyMlVTMXVwVkp5QXZMRzhrblNCdEJUYTZiYlZ6WUs5TnJEaUFKWlJSWjhS?=
 =?utf-8?B?cjNSK3h1c3hWTmcyL25MVWlGSHRFTkljNHNNTjlYVHRVNmRvUUtRWmJYemVU?=
 =?utf-8?B?U2IwT1ZpZzB5ZzcvNTkrcFpVckYzcHVXZXQ3dnRDV1lQdU9rVDhZUk9oNENL?=
 =?utf-8?B?b1RlTEpwVElmVXh5MFZiQkF6Mmtwd1E3TngxUk9wZUJtN21VK0l1RitLRm9F?=
 =?utf-8?B?MDVrZExnak9HY2RPSVJtYkQ2UGhTcm96cThaaEJWaEZqZEMvZ0ROWHh2VWhm?=
 =?utf-8?B?TkM3UTJHVU53NDVNK3JKOXBzT1EvZjAya2xCTVkyNk9mTWN1cWVCMVhVemZm?=
 =?utf-8?B?ZEp6dUhOZnZKa1hjSUliSmVMQ2xqekFmQy9VcjIyUi9BUndsWWtPNEFVWER3?=
 =?utf-8?B?cGZDcEdWVUxOckJZNU5oMUZhcHBIbTBPMDZ3NENTUVZtSENCWWY3Sk5aK1Zl?=
 =?utf-8?B?dEpaK3owczMrUUxQcUxpdzFCK21CdzYwNXBFWVk1WHVOUFU1cE1vSWF3czh3?=
 =?utf-8?B?dm1XakQ0TkVtTnBBQWZRUEFVVnJrTGY4RS9nRDYxRHZmSmcvb0E4a1pUSmYz?=
 =?utf-8?B?NU0vV2xQYzQ0Q0lTM3JOU3pSc3M0d25aSGVQeUtzcEJjRFF1UU1RSVQwTi81?=
 =?utf-8?B?Mkp3bnZuNVNXajBqcExiaU9jSEM2U3N0b0svNkNYTnllRUh5YWFVSlIyeldm?=
 =?utf-8?B?Z05wcWRvSFpBRFkyY2lvQWNhK3JGWmYzdm5UTTRxeHQ3eUtJemozRzJoQWRN?=
 =?utf-8?B?eE5yUUVpY0lrNlYwTlVtaUgxSzNUZWpIR1VPYk9IWEhxR3pUVEpDQkh5TmdS?=
 =?utf-8?B?YWF1enB5VG0rendiRjZlbjNHa29xVFhmV0dxZTZBYmFEdFcvVGVlS1JDQWJL?=
 =?utf-8?B?VG9mbngrN1QrMzZjVzFMKzd6ZUsvYlB3Tmd0K2FKc283ejBXZFB5OVBTMDBK?=
 =?utf-8?B?VGJjVUFwZjNtODRpM0p5eVZMK2V6dm45Z2syOHFYT2YyMDlibDdEVVRYSkV6?=
 =?utf-8?B?SGdkTkZkUFcwQXkwTjJDWlh6MHhtaGdNeUlCaHE0a3BPMVA1NGc3T2ZjMEJ0?=
 =?utf-8?B?RURNVDhsRU1rR0NyYVhaNUhQWE1FYXZLcVB6VWpMLzBWWGxvM1hWS3ZNM0xH?=
 =?utf-8?B?dDRtSTBvZXVrTXhHdDRvU2Rza2xDa2lERDZXYTF4K1pDaTVBVzRzOHNzL05D?=
 =?utf-8?B?TXZSd1BqZkJ0TWUzN0ZTVXM3QXNDSnRuOUFmelprbXE4N0dPWXplWDFHVFNW?=
 =?utf-8?B?RGFZR0lLTysyRFlCQXA3VGJJY054OWhpZkFVU2hINnQrWHB2N1dRYmJIamJZ?=
 =?utf-8?B?RVBuamE2THp3OXVJKzBRby9uSGt4Y29YSWNKMFVvbEJqT3NJZ0YxbnlYRVVm?=
 =?utf-8?B?VVZwSS83QlRlWHhSdEFBZWZ4QnhGRUtnK3hXdlhJU1RaWHRTdnRqVWdSSEdQ?=
 =?utf-8?B?bTFaUkMxVGRueGVUeVNNU29NTllUZVhqdWlla1RndFZkQ3lDKzNudmU3L0Fr?=
 =?utf-8?B?ZnNJYUd3Mzg0RkZJYTQvV1NsVDNuK2Mzdi9SSFdReWorMVdJMFhGTkxkZnNv?=
 =?utf-8?Q?pAjK0bHxew3tJ8uABy2WP8DoCL1mjUL3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:06:56.1299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b61611-7e5f-41d1-936a-08dcd10af488
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
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

V9:
   - renamed struct drm_amdgpu_userq_mqd_gfx_v11 to struct
     drm_amdgpu_userq_mqd as its being used for SDMA and
     compute queues as well

V10:
    - keeping the drm_amdgpu_userq_mqd IP independent, moving the
      _gfx_v11 objects in a separate structure in other patch.
      (Alex)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 90 +++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 3e488b0119eb..bd8d47a55553 100644
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
+#define DRM_IOCTL_AMDGPU_USERQ		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
 
 /**
  * DOC: memory domains
@@ -319,6 +321,94 @@ union drm_amdgpu_ctx {
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
+
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
2.45.1

