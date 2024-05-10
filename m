Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C720C25B4F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 08:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA37F10E648;
	Fri, 10 May 2024 08:51:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U82Q/qIK";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5FCB10E648
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 08:51:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImVv0Br3EpdAI3u+Eo35f/Ea92mhVOq7RKZ9RuejX8eOsa6OhYwBCv4/VHID/ML09UupF5bdfHO1tbJ9gC9qoTkFrS9lbumeAubstBI4IctAGVOaBLJo18YaNvUSuXuSofUQH4MPpXeWBjfUaY4zH/lJ9H/dcgEUx3DPXS0tkDMLBMS92of0yAPUgZdu6zXepdkXWA6cPOjGg1QnUlQGHoqudf1r44HyNEa/MZ0Qhe+QWVp+bebUg2L982/Xnh/RvveokM/zvkG/akL1AsVcGBNCclmixMb1e1yHOk7a+fgpDzYuUH5eUcgxGxox8djYykb1YNJHc8snIqHtvpt+mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1o7VCjjRpTJff7PCjwOcF3OY+v9VDE9iIyOJF4IPtY=;
 b=bE+mGwzLfog1UYgJk+xzBy1oLC4dH95JDaHOOfFdSvP9f17QgMIIwyEIB4B13+94PALi9EGjfVECTqQGYAYcXekYU4R3Byz0jjMJTt/Gkw+nNYwWFPLc+dCE2CilchB5PcfOW6C+Dsia9c33HTIbcBj7R+UMHD4JoUMZiY4zIp20Jey8ZfBIin9UEyq/X9zx3cQ/BT5JUK7GQqh0yJ5kCippZlyxKDLKE3UnXQh8eMbs+PlhqHZJqfuIuXsAHErkDTTfrQOILAdtPDV2ARMO34BMil17fwAx6AxGhyW2H/SVTSTFl4Sc2i/gBwie08gPJmK68YbxzAWyyp9vcLqnAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1o7VCjjRpTJff7PCjwOcF3OY+v9VDE9iIyOJF4IPtY=;
 b=U82Q/qIK3qj+Lys6g1MgHPXBgufKmWrCYdQSdZ5R4+6eMYMrVzevb9XMdQb+LQno4rqgxmvayH/t9u7KhNkVI5NkDDk7FmX6YWTscXIEgcsMbwd6+riCStq2zL4Bj2IYFxeWWErekfrVfdUTIZGx0JGwLpI0RBdkEj4zqrCr4y8=
Received: from CH0PR03CA0432.namprd03.prod.outlook.com (2603:10b6:610:10e::20)
 by CH3PR12MB7569.namprd12.prod.outlook.com (2603:10b6:610:146::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Fri, 10 May
 2024 08:51:21 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::92) by CH0PR03CA0432.outlook.office365.com
 (2603:10b6:610:10e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Fri, 10 May 2024 08:51:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 10 May 2024 08:51:21 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 03:51:19 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v10 3/6] drm/amdgpu: UAPI headers for userqueue secure
 semaphore
Date: Fri, 10 May 2024 14:20:43 +0530
Message-ID: <20240510085046.2718-3-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510085046.2718-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240510085046.2718-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|CH3PR12MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: f5522219-64d9-46c5-6703-08dc70ce5d80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGRuakR1QXhLak5QZGZKSXNXWUp2NU5IdVVJVWY5cllQZkpxS2RDK005bUVq?=
 =?utf-8?B?NVFPa0tDdHZWQytOUWpMa3dUTFo5YUg5VGJBMnRGM1lMS0U5VjRWbWNlVEhv?=
 =?utf-8?B?WUJPOGJnc2VXOXlXd0ZDcFN5c2wrQ2w4NTBNSVB1Y2QyZXVadHduU2I0UGpq?=
 =?utf-8?B?c3dCKzJpQVlQWG9xekdxNk9CMVBvZHN1SE1QN3RZWHByT1hBZWVMem5oQTRi?=
 =?utf-8?B?ZGZIMXFoVFFORjNpSWRzMzNSUkhraHRVUDhKVU12REZiendIeTZsWmd4OWhu?=
 =?utf-8?B?UDhObWkyd1JzWURtRlNhT0RLaVR2QjBSVEozZVJkODdQZkkrRkFobTFSeVJw?=
 =?utf-8?B?a3RKTXlra1MvTGRpRDZTV2dKYnN4SGsxOXNZdW4remQ5MnlCdWFYd0N0U0Fu?=
 =?utf-8?B?SlBFN3pObmRvNThrUlRJQmY2MmozV1NmNUJncWdSSmlSZ2IyVElGWDBvbm9M?=
 =?utf-8?B?ZDJRblI1NDB6ZWNTSDBEOFkxYmFXbE45aTdORUh6SkJucU1icHVwS2tWS3BL?=
 =?utf-8?B?WEduYUNrR3YwdlBiMW5XNkJDNnRITXVXTXI2K20wSUpacElSd1UxbWRDTWt5?=
 =?utf-8?B?WHp3b2dPY1Z5NmJWenB2TVIzcUZ6SUlSamxJb0lsanVZNnNOaE1Qdmc1SHhE?=
 =?utf-8?B?dTRWM09Idmd6TlhPL2lNL1F3OXJrQkFFZDJjUnBlZFFHRTB3Q3dCRlhWUGNp?=
 =?utf-8?B?UWlGQXE4MjBIY2UxUWpmcXUybUtWKzFnWHZXQWJRSTdXYmFtcmtqV3RDeUhF?=
 =?utf-8?B?c2dCbUc1M0Vldll3ekhMZVFUYkt2d0hUYU8yMlB3YjFYUjRTMTA5VXVTVFpX?=
 =?utf-8?B?VjFJNkJWbWt5UWlFMmplNFg4WURNWVVsYytuVHBxUlRBQkl2ZllKM3d3ckdB?=
 =?utf-8?B?TWgzUVRxS3NxNUdoRnE1R0tyVnI1TVB3VWtBKytuci9xZyswTUJEMEtPcW5V?=
 =?utf-8?B?VnM1M2Z0OHRYcTBHczFjS2toSGwzamF2b3hZcmhIS1lJQkhRSWRhMmJvYk5a?=
 =?utf-8?B?ODdURmIwQzFEMktwTzd1OHYyMmVzc3luSFBobGRVc0MzcFRYSDlrMUVvM1lW?=
 =?utf-8?B?Q2tRVklkSHpTUEJEV3IrUUEvVlA2Rjc1ZjdIbFZzY3BhUndPVEYzcURtN2tI?=
 =?utf-8?B?SlVvbnhmQTNIdThQa1JPMTBWQnB4ZlgxUDBiSjFXaERrSUZHekgzV1lMUnhT?=
 =?utf-8?B?dnIxb2N1UGJuc0JybU9OUHhIL1ZiY2dERmM0VndhTktzZzVrSTRHTkxiNWs1?=
 =?utf-8?B?YVEzZ25ZS1lMSHE2NS9pRmJQdWN6a3R4L3lnaUFVK3V0Mjd1eVdnRE1OVTNQ?=
 =?utf-8?B?TTVZOVFITDQ2cmh2Z0Uxc3BibGhGVnZiK0gwbE96a09pdFd1NFArYzg1ZW9C?=
 =?utf-8?B?REwwWGJQSTBjWHQxeFRTZm83NGtZaEQvQytBcU9TL09RWGYwNE51clV1eGhz?=
 =?utf-8?B?Rm1pVmFVQ3FjcXRNQ0JKSnVQTGJPOEZNb3owaUhKbUJJT0NKQmU0anEzWkZ4?=
 =?utf-8?B?d05oSzAyVkdzandkdUJqUFhrYXA4Yzhob0dMUTFZaVBZYTViNmhLUEovcUxX?=
 =?utf-8?B?b0pxQ3d5QnhNZEkxVVJDSHAyZHYvekcwT1RFSjRES2lCZ0JEWVA3TVgxWHl3?=
 =?utf-8?B?RkVFTDBMVDkxK2RWVTFNYmlTM3kvSlIvTkFrZU5IRFgwVzZQT05nYmZSdWhI?=
 =?utf-8?B?cW94SllWUGpNSjJlMFRYMnpTckIvYWNlMVo0UWlZQmZmZVZXZzd2KzRhcWk2?=
 =?utf-8?B?aVNnSlJMU3R3Nm92WjQwbzdtS0lLREVQR2lhbjAyRzJ4cWtkaHRBRTY2dXIv?=
 =?utf-8?B?UjN4UmkwaE5CaVRPQ1VBSVFmTS9PTEhhZTJ2cEZUdWFWckNWUkhsZFlVWVF4?=
 =?utf-8?Q?H79Srt8lBNs/0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 08:51:21.3412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5522219-64d9-46c5-6703-08dc70ce5d80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7569
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
 include/uapi/drm/amdgpu_drm.h | 110 ++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index def6874a588c..4ab965acfe06 100644
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
@@ -431,6 +435,112 @@ union drm_amdgpu_userq {
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
+	__u32	flags;
+	/**
+	 * @syncobj_handles_array: An array of syncobj handles used by the userq fence
+	 * creation IOCTL to install the created dma_fence object which can be
+	 * utilized by userspace to explicitly synchronize GPU commands.
+	 */
+	__u64	syncobj_handles_array;
+	/**
+	 * @num_syncobj_handles: A count that represents the number of syncobj handles in
+	 * @syncobj_handles_array.
+	 */
+	__u64	num_syncobj_handles;
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
+	__u64	bo_handles_array;
+	/**
+	 * @num_bo_handles: A count that represents the number of GEM BO handles in
+	 * @bo_handles_array.
+	 */
+	__u32	num_bo_handles;
+	/**
+	 * @bo_flags: flags to indicate BOs synchronize for READ or WRITE
+	 */
+	__u32	bo_flags;
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
+	 * @flags: flags to specify special function for userq wait information.
+	 * Unused for now.
+	 */
+	__u32	flags;
+	/**
+	 * @bo_wait_flags: flags to define the BOs for READ or WRITE to store the
+	 * matching fence wait info pair in @userq_fence_info.
+	 */
+	__u32	bo_wait_flags;
+	__u32	pad;
+	/**
+	 * @syncobj_handles_array: An array of syncobj handles defined to get the
+	 * fence wait information of every syncobj handles in the array.
+	 */
+	__u64	syncobj_handles_array;
+	/**
+	 * @bo_handles_array: An array of GEM BO handles defined to fetch the fence
+	 * wait information of every BO handles in the array.
+	 */
+	__u64	bo_handles_array;
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
+	__u64	num_fences;
+};
+
 /* vm ioctl */
 #define AMDGPU_VM_OP_RESERVE_VMID	1
 #define AMDGPU_VM_OP_UNRESERVE_VMID	2
-- 
2.25.1

