Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414B8C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 13:48:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0642112406;
	Fri, 26 Apr 2024 13:48:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CP8Ku0uT";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 055001123FC
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 13:48:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrnfMhvQpz6eoGoap8EwVYrj8OkLg7l/5fF8yjed09u7DEArGyZyHZYBE9uR3tPZGLeawMSIZYnI60A26/jOD/EnGA3M6nwsoW6kfNKR7FDNO7YyJ9Qjndb3xKSli/SlOcA555XeLmYY0POm+s6EU0bclaICqVfeJZs8QaBp4e6f9ib3IpCrISApzXWpyMlB2dLyzAla9AbN4cIuybz42/3+/c74foBWFcSSWveUXT1AfEKBcq8LOVwIyvL95rnn0CK+7PMNpP07FE2VMWkNX9zNU8nMNcNGUsYXEf7JZvghyiW2bCIVZ3b4DgvE0XVfkhGRDoNxyKrFPnnWJb6f1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hh3V2IVvkbXAjyIS0nnpz90o7XTRBqTKSvRlk7X1jGI=;
 b=VEz9L3i1ZNBEBvNHZfL9i4mp6yDRsFK4RWQ167WyXaSat66zR2UmzHR0nichNShrW2HWNFvY/pv0afyQHTEDto3R0GhFANrLZJ0ZfQ3hFw3WG33VFlyrlW3QlOtir25CqaZnlYNtVToSFd4YvaXCzGaU1wvvsadUUVSy+owrMBkBrDirQ3Hp9OsGNP1USPDGClOxE6MZotpfaHVXd/4eN+ZdrZ1dbZFwQgn7c0iwlJFyVZfPz+Cy+zeZG1tepMrVWYvRluxMhfttpWUIfnqxNWDE6jzWjZqvllvFWeWVteWjIZUxEg2joZ7C7WULp1B89c0CrXMsOEqIKWNFh4zmxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hh3V2IVvkbXAjyIS0nnpz90o7XTRBqTKSvRlk7X1jGI=;
 b=CP8Ku0uTRTWcBZZQr7dXgJ3EJcjZWLmYum/aF3gLNFng/YCTr4tNamWUeCiTti0F53M7in7bjOuoSFBMg0bMvv2bdreAcZFFjfqkpT1zSWm1JBP9h8p0lwbth0OpxiaG33sgaOUHhWcd+OYNjQZP/iXR3q8mdKmGzdabf74PSag=
Received: from CH2PR20CA0012.namprd20.prod.outlook.com (2603:10b6:610:58::22)
 by SA0PR12MB7477.namprd12.prod.outlook.com (2603:10b6:806:24b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Fri, 26 Apr
 2024 13:48:40 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::6e) by CH2PR20CA0012.outlook.office365.com
 (2603:10b6:610:58::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25 via Frontend
 Transport; Fri, 26 Apr 2024 13:48:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 26 Apr 2024 13:48:40 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 08:48:37 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Subject: [PATCH v9 01/14] drm/amdgpu: UAPI for user queue management
Date: Fri, 26 Apr 2024 15:47:57 +0200
Message-ID: <20240426134810.1250-2-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240426134810.1250-1-shashank.sharma@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|SA0PR12MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f5af485-113b-4bf0-29ad-08dc65f79473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400014|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STRGTUN4WG4rdGpxbkJDVTJiZXVNY05lTERWeWVtSjBlb0VGYTZXalNaeHdY?=
 =?utf-8?B?Q1NRbEFIUFRuaFNLb2Jtb0xzYkRUcnVTVGhoYXdtaHNkL1J5M1lSUE5HUWdp?=
 =?utf-8?B?NklvOHJNeC82d2NyWmtUUGVuS2hkeWt3MkRDclNXNkN5YmVqRmtlMDFrVFZq?=
 =?utf-8?B?ZFdpM1plOWNlYlNIMncvWUVFWktLUHdJT0pXVG13UnBlSllqVzh0T3NXZmVZ?=
 =?utf-8?B?bzBseDlmWGo5R1ErQURVNmhubEY1S09IZ0xuZTVXODJPK2dCUjFuZUFNdHph?=
 =?utf-8?B?WUlXcWZTa1pBeDVTdHNCOURNS0FDMUthUUZDSDcwaDlhcVVSa3l2S1lOMXZr?=
 =?utf-8?B?T0FNMUptWHNUcllVZm5XRFlBb2I3K3cxNGZnaHArQmdzQS9pekRWcXUyVk5C?=
 =?utf-8?B?aHgrZE14dUxzODRWbnFXNFplTTY5ZzZqYzdFeFJ6Tk5scytoSWhjVDJ0a2E4?=
 =?utf-8?B?UUx0Y1ZEQTcrUHJQb0pERTBzbWZKc2EwMHRIYTdoeEc5VWxsTGc3bkE5WEFX?=
 =?utf-8?B?SDh1MXhyQk5rZ2Y0M2tBdUpkV2J5aldGa1hFUmZNemNJaUpLY2wwN3N2bjVy?=
 =?utf-8?B?eDhwaUxFR045WlRxVnlnb1JaODM4cXNwbThLa2p1cG1vdnd3am9SNjVtd09S?=
 =?utf-8?B?d0xCTFJzQ0txYThscUJjR0YzZlZWazM1cUJjaXdHM0tZdzhId0pUYWpmYXVH?=
 =?utf-8?B?WXlrTndLNG8xQnJJTEVFZlJ3TUtqUmxqQ0kvWHNJcVBqUThwZGJIbEZrV1M3?=
 =?utf-8?B?ZlBzMk1CME5ieHFnazNGRksyc2xxVVBKcG1sY1k4T05iUnBjTUhlTTlRSXk1?=
 =?utf-8?B?VjdhMDFMaFU0Sk41ZFhUYzlubkJYSlNlUW1zRXRYbjhtNlpLbjBPRTMxOW9w?=
 =?utf-8?B?M25USjdTME5RREowa3RFT0QvWk42TDVmSjJrWnJLOFJwc2wySElIbnlqMGZS?=
 =?utf-8?B?cGZ1NDF1bDJEZlZpdGkyWTZMRC9rN2tQUEkrOHppaTV1bk1pRlF2RHA5c3dW?=
 =?utf-8?B?WndNRE5oRjNjSjZmbktlZE51TGgrZi9kODN3bElVa05kRFIzdjFaaUU4MU1W?=
 =?utf-8?B?bU9CWHpwR21EekYyUEpXWDFIVkszTHduUDNlSnhhUDlhVlNXMWNqOGR3OW40?=
 =?utf-8?B?K3Bta0R4QWkyMys5YXhJcXZON0ZCWDduUVlQNUhENHRFT3NMV0NTZzhUMmF3?=
 =?utf-8?B?elNRZ25aWjNNbk1tYkxzUm13N3FQb25iZkUyVzdPRkVvaXludmlCMlFhY1pp?=
 =?utf-8?B?UXF0WTJJQ05BMkExaFZ3Nmg5VzRhblJQclVjSTdHNERQR3hpNmtmSysvT3pY?=
 =?utf-8?B?bDd2V2oxVm45WUljdlo1SkxUU2VHcEZpOHVOcDl0TkN4ZmdtSy9OVnJpaFFJ?=
 =?utf-8?B?SVYrNmp4bHp4L2lyZkdaRUthdndmNmt0NSt6aUtQU3M3b2xCV0lZSEcxZjZt?=
 =?utf-8?B?NlRZNVBsRHBWaytZTUFPOEROdnBrS3hJbHJOUU92bzAza1gzRzdSMTBhcWI3?=
 =?utf-8?B?N2Z2Y0dXVFFWak0vNHcwZnE4TnlTUXA5UmR2MHZTTkRJS0N3NldBOWNWaUpX?=
 =?utf-8?B?UkNTdUpZVUtENTY5aGxBTEcwZXAzaFVERWJlblFOcUIzMlVLeXJBTDdybnhF?=
 =?utf-8?B?aVFQbWR6MVRxZGFCNWc2Z0ovWTZlMUZxY0lrTDNWZkRNWkdaK1hJNm1XTS9L?=
 =?utf-8?B?K1ZGN3VNc1hnR3l3eWZvalVPdzMyYkw3Yis3R0RTa1pWKzlLMTNOaUJYUnZW?=
 =?utf-8?B?S3J0bGs5b2o5OFFoc1d2Tm9aTGhSQk94QXBuLzZuLzluYzJSYXo2czZ5ZzVY?=
 =?utf-8?B?NzA0bHpnSHZlcGxNdkJzV3JmSGViU2paTG9jRWNNcjV3eXV4bGlIZG1LT2xV?=
 =?utf-8?Q?64KL9ozVgs1+J?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 13:48:40.0420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5af485-113b-4bf0-29ad-08dc65f79473
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7477
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

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 110 ++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 96e32dafd4f0..22f56a30f7cb 100644
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
@@ -317,6 +319,114 @@ union drm_amdgpu_ctx {
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
+struct drm_amdgpu_userq_mqd {
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
2.43.2

