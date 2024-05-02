Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99708C25B5C
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 16:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 076B710EDFE;
	Thu,  2 May 2024 16:32:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xsVsdCLp";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7699610E577
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 16:32:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQEcqgVoPhcqw+q0zoPHs1Bc7ltNTAnSEXPygsVH6InpX/1vzh4RFidnpha/eFgx0z+mLGpQfVEPpsVxHehofzwiZata7jWFgcew02gDKCcaamTt8Lj0GBCywXJZQRIl96fYWv69GhLk0wDeQ4QIX3XIOd0vanpxbxCGM2dtP4hyH/u1dzG4kkecCGOSPVF/6ms11RsR34Jc6Cuz8gC4eExCdfhHWK+hgkTOkY+RuppiL2bdfIxMcP+StN3oaWPn0XF0AItemWz1ZnBbciewaBJU8bw8YhNSwM3+msjbpTBNJq65q7NZJQS88VGTChqqKN88DOYAcCXvyzSbsVBy8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4cMIHYSpEMp0yGPGt4V1yOzySbsMGbyv1olRFl3kCo=;
 b=hYFWLrIXvy34l3t5iat9Yg6hPBF09+Ryo4QWrOkQRrCLvWojDfgxuFWXGDPb3hvRJNkC8IX9KwA7WDrZbW0RAbdKifptEl2j6HVpaA2F8JwOQDrlcy0+6hLK7gJmhhNoiS+ZfsIUnntDDwkWz6O+pgUVJvBZ0or0st8WJrNnbibcDYXfbAhc9mW9AkD/lcKvQVpqNob5vBHfsutiP2NxtgRrmYnqjr2kc1fkVdOk1ufGB088O74eB6Uj5ttC2p3Y/nuHBf4UmySjhrszUJz9YUeRl4+UFGOpUjwX6GXvWlUyNvW+1Q9Ho+HZw8l9pLtUYDAOP3QPEcQy2MLgshcUIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4cMIHYSpEMp0yGPGt4V1yOzySbsMGbyv1olRFl3kCo=;
 b=xsVsdCLpSBScssrvIVCbA7HS1NDpFl1LP/4e0AtPT/jrR5BnsS1RquuO6S+QKaIMCZChqmlfaFdF4oIgfDIl8+KulY+eEHGFM8Nl1cGKHjkvcA0Euhz5nmK+MQWivs25tjuqsELAWZikjhoUQcqRS19q8q8CvwZBodgoJEnUCVU=
Received: from CH0PR07CA0022.namprd07.prod.outlook.com (2603:10b6:610:32::27)
 by CY5PR12MB6573.namprd12.prod.outlook.com (2603:10b6:930:43::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Thu, 2 May
 2024 16:32:29 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:610:32:cafe::93) by CH0PR07CA0022.outlook.office365.com
 (2603:10b6:610:32::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Thu, 2 May 2024 16:32:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 16:32:28 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 11:32:21 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Subject: [PATCH v10 01/14] drm/amdgpu: UAPI for user queue management
Date: Thu, 2 May 2024 18:31:38 +0200
Message-ID: <20240502163152.1382-2-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240502163152.1382-1-shashank.sharma@amd.com>
References: <20240502163152.1382-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|CY5PR12MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f0123c2-7248-47df-dfed-08dc6ac57542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|36860700004|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzJabFVHK2I4eVlvTjVUSlo2VENwOWxMUFA0ZDRlRmluWitVdjN2dnJjQjFQ?=
 =?utf-8?B?UkNRenl3RFhKOGtoemdjTzRhMUVRWlcrU0N2N2lQR0dpZVFiMnZDeUFQN0R4?=
 =?utf-8?B?dHdzZ2piaGwwS0VnOWNxZWNaR3dObndZSDBhR21VYUlIY3ZDbkgvOXZ5OVZi?=
 =?utf-8?B?cHlRd2xDUDlHUWNYcGxjbFlCUW4rdHEzb3Z6ZkR0bEFIbnN4NEdCTzJObGdO?=
 =?utf-8?B?NDRJNGZISHZYM2JJU0NyeDNVSCtuRHdsN2hHSGVxeDYyZGlYeE5XaGRCNFBt?=
 =?utf-8?B?bjAzMElGcCt5ZlhTTUpxZFBlbDRiL0VtQjNQVTlxaW1KK0pOZnYyd3o5TXox?=
 =?utf-8?B?bmFUY2drMmx4V1lKRDllckZFTWI0RDZVVHpCT2tuTGx5SGw0NDE1VjZvRDBZ?=
 =?utf-8?B?bE91eUJ5WDFLMEtyQTR1STU3L3M3bVQ3Z0o2R1RHVmlscm9MZ2pST1QweWJL?=
 =?utf-8?B?T20raUY1dWJpRUhmQm1kRkxJR29nUk43ODhLeG5zbG9LaUE5UmprZFRRMkVv?=
 =?utf-8?B?OUpmTXJTZzkyTDd2dWcyQlREcjM4c3d1Rk1LYlhSYmppVHNoanlzUHNxS0M2?=
 =?utf-8?B?MWUrczc0a3cyL3A1cm5tSGxRK3pSNHhtdFBmTkI5Q21yWlRTTmp4aXk0VkhV?=
 =?utf-8?B?MFM2RDZETHVwZ3ZiYXU0U25CVXQ0Q3RaRlhHalBMK3ZrTlNQMTZ0S3NhUHdh?=
 =?utf-8?B?N2FkV3BBRERoTitxejVJQjQ5TytVeTN1YVdaT1VkRXJHb1pMQkxxSHA4SnBn?=
 =?utf-8?B?S1JBNFp5RzAxUm9pRS83WmRZTkw5RmozMnc0RE5ZOVRUNWQzSyswd0w0R211?=
 =?utf-8?B?aUxLeDhQbk4weG5VcWpVOGNDWFVvcHh4ajlQOGlvM3gyMS8rbGN0Y3JLdmUy?=
 =?utf-8?B?bC9vVHdSYTJtU01MdHZTNHJMTzlieXJJd3ByUlFtVFgwTTZPa2hBN0R2YlBa?=
 =?utf-8?B?b3REck5xZlYvVjlmOHZZRDdxU0FsQ0pmTmZMS1RKMFZhcENUcXA5UGtjSVAx?=
 =?utf-8?B?R01nclJOSFE5aWlRVlEyNmdtZUZlNzUzc0pVMWlrUHUvMWt6OWY4TWlTTjNa?=
 =?utf-8?B?NEJLbThldW9MTkdKQkFNSC9MOHBFdXBsZlQ0RkN4UXZPejBGbyt0TzFuM1NE?=
 =?utf-8?B?NDZrYU9ybzNIM1UzTFZsemFSUkhpcmxNRlFzTHRxNThaeU1TcU5JWXd4ZXNT?=
 =?utf-8?B?WEM5LzQvVjJNRGdQZmhCdTVOci9yVjBiRHc0SVdzOVgwWHN0MllsLzEvWWxZ?=
 =?utf-8?B?VGRpM2I2NjVMOHJKOHZPY0IranZ2cWpzbnhlMFRPOGNiZTVGdnVSTDhGVHFz?=
 =?utf-8?B?bk1mMVcxSFhPOVNlZHpsWkR0UEJFekZmb0JGOE1QRmRrYkNxZTJzM0p6TTht?=
 =?utf-8?B?UnRVcWg0Zkwyc0xNaXE3Z0R6eHdRVUphb21uUW9OVmQzVEV5OEc0WkMvTHY5?=
 =?utf-8?B?K3RRN0ZWNE1ZU2hDVWZHSnpCcWxFaURXQnNITzFOeXlGWTNDeGV0UERkZlZ0?=
 =?utf-8?B?MjhhUHVtOHZFeVNZdGVEQ01MeVJmcm5maVZmamlhSU9Bd1BJbmUzMitJcXJ3?=
 =?utf-8?B?VHhUSzlqU0owYVl6dktmQjJFMzZ1bGZTaEtGU2w3aFJEQ29mTlRjVkFrTGNT?=
 =?utf-8?B?RXd1ZTVkbXlJTHN1QktMTXJPdU1pTW42djJHSXcxUnNFRS94dU1BaWRqd2lC?=
 =?utf-8?B?ZVNMbWQxY0FIcXZzS2ZhWllMeUpBOVBmaXUxZzl4VmgzMytNV2xWdEJkeWNM?=
 =?utf-8?B?MjVUdFdGYlFsZTg4NDhXb0x3WlpYL0YzSmhFUHAxUko0aDNnbEhUZFVkQWdL?=
 =?utf-8?B?dW0xQmFDYTFrODdKdVg2RU5tMTNRalFtNTUxa0J0RjBFWFJEaXg2ZTZVODds?=
 =?utf-8?Q?ZiHnx8eRvb9m0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 16:32:28.6467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0123c2-7248-47df-dfed-08dc6ac57542
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6573
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
index 5b6c0055cfcf..f7313e576f06 100644
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
@@ -317,6 +319,94 @@ union drm_amdgpu_ctx {
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
2.43.2

