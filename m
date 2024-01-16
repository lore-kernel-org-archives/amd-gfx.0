Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AD7C47077
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jan 2024 20:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA9B410E5A0;
	Tue, 16 Jan 2024 20:35:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2512310E582
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 20:35:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/kaLEJGcnjCZaao0gqDV95XVRFwsfm5IFMVzo7HPwBUV3YNb4kvXFmTXYqdSAk81igvV4lq1Fv2GqkrCfkSuzkc26OHFVIXgf3Wne/tTycN0jTt+oiV3sjkyugd3A83EsPjfPv7RwIVUErdHF5EfEt/RW4aCDrwJmr8n+onUZTvyIdx/DJ/oDFwaCqeAGqUYdDhWZ19cVoO4iAUnP2K3exlEIbcv40K9UvU1XSkTZUGQ3dDvx00BkdoyB9wXLGfQsRw3ua4qpxTh6KFQggsQ06PB88oJSC4bz95lvNB3JgSO893thTMAG3QFWaaDrjbDglZdrahutjUvEaXAWC3ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSLdWm0TfLRAKAu/oRq7xQTKYbtuYpj3+4SI8+2cDM8=;
 b=GefDG5RJDguTguFBvM8Z15o/viw9IpUwWjl4h05D/ChCfFzEJK/0N/xUjfyqjuqPuIv18AIDzqNiBvbtZSRahZEN9FCzv+lHii4qa6u1/Z2sEZfRT8Rfdjlf2Rh0sO2STvIJC7F+5ywF9Ljsky9odp1t45YrBeIMjVprX85Of7cl6kcifaL4I305RrlPi1ci0pWQyhCVozu+Pn9B5z+bOlaZvOsAjZG1I0id2duoFumryE3P42qAWakoShFLKNDXoyUCN/uKqNGv1tgCW6o8fEobL9bseSe4Um+OSbSNiqqnsyw0um2WY3m4Fy1j1Bidm3oW3jRye9WNS75jLgysAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSLdWm0TfLRAKAu/oRq7xQTKYbtuYpj3+4SI8+2cDM8=;
 b=ANtpDrlYHiPvwXUNDSrimyuKbLzwZekIfQu+Hhjr1/0aoZM6D0Ybd6bRu5i5nTY22ZED7Jv6BsHzzpiNSsReQRVRo4l3dCyOPxhnLOtGTcUKLunV2lpjkD/drBO4LWino6U4PmwlZdWimWxOEy4xKkD7q4bG3hmwGNBOmdmuQnw=
Received: from DM6PR13CA0043.namprd13.prod.outlook.com (2603:10b6:5:134::20)
 by MN0PR12MB6104.namprd12.prod.outlook.com (2603:10b6:208:3c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29; Tue, 16 Jan
 2024 20:35:16 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:5:134:cafe::1b) by DM6PR13CA0043.outlook.office365.com
 (2603:10b6:5:134::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.22 via Frontend
 Transport; Tue, 16 Jan 2024 20:35:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 20:35:15 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 16 Jan 2024 14:35:13 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v8 3/9] drm/amdgpu: UAPI headers for userqueue Secure semaphore
Date: Tue, 16 Jan 2024 12:34:37 -0800
Message-ID: <20240116203439.802772-3-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240116203439.802772-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240116203439.802772-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|MN0PR12MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: bf0e3b78-17ff-4875-a245-08dc16d2a57d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m7QU9MIMBUmmlVbk6hoCEZODk7Hc1QkjJpgFk5teJHzgy3SDaFV3ipO/iMEAWbz8FKyOK6WJZ211ovwrn/TkYBs15ii8lxKT1REKhuIdVx0ooDyNYjkmrSUNHX7R4PHuCI5otshdcaAiJl40eELr1GQpCzV7Py5esK0ABbtse4YolUYFwBQmQ8GLfiuUkxiougaSONTaFPJBamcPcj5PQlVykPRK7mGC+A5LpICFC28V9nNZ4fNrLEQt7jedFpwN0/mcEp8yRs7a6kDpHtcUtVmX943S1y2Z0cL663YDLGJBhDk2EIYBVS+WkR7YRP7wlmp4yQdFB/2Efjae8mZMeTnGpj27dMYaUpFyiQgGZSxgyDHdpJHCLvux5T/WPiR44aoDT1lWOPHLo0pyGiylbC5uwB4rAhPs3ojRVGx3l6IHwfGIQ9u+Oe0ZyCaUK0PEaV8hJ8dK9tBq+vb4KPymKSl1GETVPdS1KA1SNT5h82HYQVXp0oBp06WnHYcOQ6yRDTH9sJ2PXYADxwq15orWGhfUGqJ+ZTRef1reCY1uu+QDPF/6xeLxUk2dYfqBpmPBJ7ujD8MHV2tKOhZpxr0sodUDko3WudT0kWS+aUBUsuvyTTEJVVb2f5Tev2wPszirRwKLRkPhMEXSnOSSKnNzQByHpc5kABm7s7YNz71XPL0sxXDNUPTUDm6FapO5yi+mMxX8tvgr0iPA9o+ljO9tD0NMM6W0RqnjRtyYNaMU3E1LGsOIycoCV7DmqXhZBqocjODtlDnlE7hSsCGSOH5BYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(41300700001)(82740400003)(47076005)(36860700001)(36756003)(86362001)(81166007)(356005)(70586007)(316002)(54906003)(6916009)(8936002)(2906002)(4326008)(8676002)(5660300002)(16526019)(2616005)(1076003)(426003)(336012)(26005)(70206006)(7696005)(478600001)(6666004)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 20:35:15.4091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0e3b78-17ff-4875-a245-08dc16d2a57d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6104
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Arunpravin
 Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add UAPI header support for userqueue Secure semaphore

v2: Worked on review comments from Christian for the following
    modifications

    - Add bo handles, bo flags and padding fields.
    - Include value/va in a combined array.

v3: Worked on review comments from Christian

    - Add num_fences field to obtain the number of objects required
      to allocate memory for userq_fence_info.
    - Replace obj_handle name with syncobj_handle.
    - Replace point name with syncobj_point.
    - Replace count_handles name with num_syncobj_handles.
    - Fix structure padding related issues.

v4: Worked on review comments from Christian
    - Modify the bo flags description.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 114 ++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 8cd3f3096769..58c54a7c0ba2 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -55,6 +55,8 @@ extern "C" {
 #define DRM_AMDGPU_FENCE_TO_HANDLE	0x14
 #define DRM_AMDGPU_SCHED		0x15
 #define DRM_AMDGPU_USERQ		0x16
+#define DRM_AMDGPU_USERQ_SIGNAL		0x17
+#define DRM_AMDGPU_USERQ_WAIT		0x18
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -73,6 +75,8 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
 #define DRM_IOCTL_AMDGPU_SCHED		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
 #define DRM_IOCTL_AMDGPU_USERQ		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
+#define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
+#define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 
 /**
  * DOC: memory domains
@@ -427,6 +431,116 @@ union drm_amdgpu_userq {
 	struct drm_amdgpu_userq_out out;
 };
 
+/* dma_resv usage flag */
+#define AMDGPU_USERQ_BO_WRITE	1
+
+/* userq signal/wait ioctl */
+struct drm_amdgpu_userq_signal {
+	/**
+	 * @queue_id: Queue handle used by the userq fence creation function
+	 * to retrieve the WPTR.
+	 */
+	__u32	queue_id;
+	/**
+	 * @flags: flags to indicate special function for userq fence creation.
+	 * Unused for now.
+	 */
+	__u32   flags;
+	/**
+	 * @syncobj_handles_array: An array of syncobj handles used by the userq fence
+	 * creation IOCTL to install the created dma_fence object which can be
+	 * utilized by userspace to explicitly synchronize GPU commands.
+	 */
+	__u64   syncobj_handles_array;
+	/**
+	 * @num_syncobj_handles: A count that represents the number of syncobj handles in
+	 * @syncobj_handles_array.
+	 */
+	__u64   num_syncobj_handles;
+	/**
+	 * @syncobj_point: A given point on the timeline to be signaled.
+	 * Unused for now.
+	 */
+	__u64	syncobj_point;
+	/**
+	 * @bo_handles_array: An array of GEM BO handles used by the userq fence creation
+	 * IOCTL to install the created dma_fence object which can be utilized by
+	 * userspace to synchronize the BO usage between user processes.
+	 */
+	__u64   bo_handles_array;
+	/**
+	 * @num_bo_handles: A count that represents the number of GEM BO handles in
+	 * @bo_handles_array.
+	 */
+	__u32   num_bo_handles;
+	/**
+	 * @bo_flags: flags to indicate BOs synchronize for READ or WRITE
+	 */
+	__u32 bo_flags;
+};
+
+struct drm_amdgpu_userq_fence_info {
+	/**
+	 * @va: A gpu address allocated for each queue which stores the
+	 * read pointer (RPTR) value.
+	 */
+	__u64	va;
+	/**
+	 * @value: A 64 bit value represents the write pointer (WPTR) of the
+	 * queue commands which compared with the RPTR value to signal the
+	 * fences.
+	 */
+	__u64	value;
+};
+
+struct drm_amdgpu_userq_wait {
+	/**
+	 * @waitq_id: Queue handle used to retrieve the queue information to store
+	 * the fence driver references in the wait user queue structure.
+	 */
+	__u32   waitq_id;
+	/**
+	 * @flags: flags to specify special function for userq wait information.
+	 * Unused for now.
+	 */
+	__u32   flags;
+	/**
+	 * @bo_wait_flags: flags to define the BOs for READ or WRITE to store the
+	 * matching fence wait info pair in @userq_fence_info.
+	 */
+	__u32   bo_wait_flags;
+	/**
+	 * @syncobj_handles_array: An array of syncobj handles defined to get the
+	 * fence wait information of every syncobj handles in the array.
+	 */
+	__u64   syncobj_handles_array;
+	/**
+	 * @bo_handles_array: An array of GEM BO handles defined to fetch the fence
+	 * wait information of every BO handles in the array.
+	 */
+	__u64   bo_handles_array;
+	/**
+	 * @num_syncobj_handles: A count that represents the number of syncobj handles in
+	 * @syncobj_handles_array.
+	 */
+	__u32	num_syncobj_handles;
+	/**
+	 * @num_bo_handles: A count that represents the number of GEM BO handles in
+	 * @bo_handles_array.
+	 */
+	__u32	num_bo_handles;
+	/**
+	 * @userq_fence_info: An array of fence information (va and value) pair of each
+	 * objects stored in @syncobj_handles_array and @bo_handles_array.
+	 */
+	__u64	userq_fence_info;
+	/**
+	 * @num_fences: A count that represents the number of actual fences installed in
+	 * each syncobj and bo handles.
+	 */
+	__u64   num_fences;
+};
+
 /* vm ioctl */
 #define AMDGPU_VM_OP_RESERVE_VMID	1
 #define AMDGPU_VM_OP_UNRESERVE_VMID	2
-- 
2.25.1

