Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5538EC19F53
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 06:44:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22A8D10FD86;
	Mon, 29 Apr 2024 06:44:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4QWqiTU9";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 584EB10F4B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 06:44:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIxN+ZuA1KiUZC1UqX5G7Scl/oTE5DQb07T67w7LF9XC0koNCIB07/5mFWkowchRieulWOR6Uk4TCC1PgkLP3D/UsYf+YQ3mKpIdpZK8ToBfwaSZpuM62hN9sSqJPymNIifwPUmzaURdpMJikNWBynoBNsGvw1nju9WwlRHH2JKEmij1Zoys+Ltmpx0XgZjmDloTSUb6veaEh1FoySEpNTqETLvIeq2RoOqqbT5XOwAvtS0Fy0WDx1dl/H5iLW4q0ntikOajLe6r/qth8CuiPou2q0e3x++7hCufJx2sNpGeQgr4uRpzMLwl6/weg0FJAE3saaMdrf0WiUn5a4C7xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLiESqElUKH9MRYTfz6dEPYXjW3WaZCcCMkeMVesdms=;
 b=n+wXPjRV9SRe1aDiT9BQ8p4TlWde5NDz/8tb1kCikFZo9ifi5vwu27/uN+pMK2rnsZ39TCQnkSpXUjuidnrWkPdofmRkZrEHrQYLiElkUcbTsWd5YqBnvc2OvAULdd9Ycu+3orZ+87Dz4PB4igfVRrU/C995h8ONB1Zx1+6tv6vXMW8Pgn/0qEtVO8FG1KcAdE4lUxG/qnGsk9mgXC2gCea4Ge8SVtT7B4IDmr0RVktiYn2kIW0GCPCxv5XkFAuEGfNs1wmQTr1+l+XDyK+qBRiJYbjn+DPkh8lXb2ioBioZzRcj64FTaDNzrx8ypjiGcjJxCz4UYbLDgXfFsCvDqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLiESqElUKH9MRYTfz6dEPYXjW3WaZCcCMkeMVesdms=;
 b=4QWqiTU91BjOMzlnT1ANPMcFy8wUF+loZOMjYGLMfezyb2eDt4k1pWkO8F6aXyOZ9hOObl2+exElXdyTwPUEU/QCdWnjqKF5lrJiCpBYFg/TvnHB1ac281KOfgrqac3iGqPzkaOjdLwFruU2RGRolvq4kakkp0R/Ou1KRbVNLPg=
Received: from CH0PR07CA0016.namprd07.prod.outlook.com (2603:10b6:610:32::21)
 by MW4PR12MB5641.namprd12.prod.outlook.com (2603:10b6:303:186::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 06:44:30 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::30) by CH0PR07CA0016.outlook.office365.com
 (2603:10b6:610:32::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Mon, 29 Apr 2024 06:44:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 29 Apr 2024 06:44:30 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 01:44:27 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v9 3/5] drm/amdgpu: UAPI headers for userqueue Secure semaphore
Date: Mon, 29 Apr 2024 12:13:49 +0530
Message-ID: <20240429064351.626929-3-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240429064351.626929-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240429064351.626929-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|MW4PR12MB5641:EE_
X-MS-Office365-Filtering-Correlation-Id: fa1105fd-6a08-48be-2e50-08dc6817d253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZEhWL0d0c1FnbGNWeHVSNHp1Nyt2Q1BxdnQ3MzM4a29zT0d3V095dXpaQTl3?=
 =?utf-8?B?SGxXa2FLNFo0WUYyajlEdlNMWlo4UmxPMDVKb1JTUlZtLzVrN2s1WXY1elBh?=
 =?utf-8?B?eHFPWm1naUs1U0xOWjFESU1GYjhHRytUTDM0ckZTaFo5TlArZldoRUFadU5h?=
 =?utf-8?B?Y216ZEgxYTV6RG1pZW43am9CakhEOGdBUWZiREJzb0ZjU3J5Y0NHYU5ZWFVB?=
 =?utf-8?B?bi9FNktVbWdJRVpRTWY0WXhrczNVOXhBRG9SQmtENEpxMDhxNzBRa05HWXIz?=
 =?utf-8?B?Zk5JNDc1KytYa1RGOXE3SWZTMklxYk5IK0dhdTk1NmhyWG4xMlZOaWprd05N?=
 =?utf-8?B?S2QxNVV3M21IZEVId00yQk1PeHdneVNSZVRjckhqN0JHRXdTMm9ZSEEvUm9T?=
 =?utf-8?B?QjlTc21LUWcrUHZXTjZEZkxhd1J4SmtPeW9GeEFJK0VNeE94ZHJOeU9LOEVy?=
 =?utf-8?B?R2N6SUhkRllsbjRkMWdrL2ZyTUdmN0h4WkdUZ3pDL1MwbjRnWmlBd0R4ZHBJ?=
 =?utf-8?B?ZFN6T2dFWlVVYnc3bUs3VndLRTNDaVkydytqanpOOGU0THg0K1BlazQ4S21j?=
 =?utf-8?B?dkxrZTEyMHhrOGd1bjlaK3FxdzBGV1JjTDZmdk9SZ2lJMWQ0c1pjKzlDbVdk?=
 =?utf-8?B?WFRIL0FKMytibXNZeEVPaHh5OVhSZVd0RGRhQlp4bWdCS3FlMmFHQVMvbkVa?=
 =?utf-8?B?NklhNUx6UEYzdlVZa2FGQkFJalpxaFFrcFJ4VUVhaGpTcU9HS1FIMDlEc211?=
 =?utf-8?B?RFU4R0pCa09iSXZnTmZBZVNKeW5JSlN0UkZTMDFHTGdSU2RxWVV1Z094Y3hs?=
 =?utf-8?B?K2FxRTl3SnVjdXRJOUEvb0x2NkJpcXArdmdxOUM1NFRkclpTSCtKTVg5djA4?=
 =?utf-8?B?ZUVlL05Uejc4UHVvbmh3WEVKaEVDNlVKWkN6UTEwSXR3MURHQXlIVVVWeDVy?=
 =?utf-8?B?WmhCSXMzWDg1M0V1UzAxRTA5ZHo5NTFlTXRPeG9XR29JSitWTk8yMlBIamR3?=
 =?utf-8?B?QVk5UTRJN1VxMmpSbnpZNDdod25vNTVqUlZoK2Uzc1gxMVltU1VoeThIMWhu?=
 =?utf-8?B?aFpqbWZORVhFZ1Y5QWl1UU1wZjlMOS9KT0xJaGZYZ2hlWktJSDFFYTZwNGcy?=
 =?utf-8?B?UFpJWnF1VG5pL0ZpaFJxU1N0cmJyVFhPY1c4dnhWUkpQWEd1d2dobTRVMnp1?=
 =?utf-8?B?UW93OERmMEIrTnJWNzR3OG5GN1ZjWFNRaW8xb0cyQlh1ajNpSnl3Ui9xZ2U3?=
 =?utf-8?B?L3BWTjl6cmIyRm5ZRDRkTmpxSUx5cmRUUWFRREFPMnloT2RCcVlsUThCSmI4?=
 =?utf-8?B?ZVFIQmtKUGdIVzJDNlo4S3BCbysydHpsTXduM21UZ01idzU4Y3BpQVVzdHBD?=
 =?utf-8?B?MFJHYlZqd2xzK01mL0NDQm5WTHN2QlM0ZDluc2NPeGNnb3V2UG11S0pDVTVy?=
 =?utf-8?B?TEtwL3hiU3hzUzRGYmI3UzlTTWVHQzVLUkpvNzcwOEs5Y2lmVXpuclZFNkN5?=
 =?utf-8?B?cjlmbWR6TFBqM0hwKzE1TnZUODRjV0M5K0pPOVNsQ2VXOHU2WDNuUEMvam11?=
 =?utf-8?B?ZVZibWluOWhNUi84aWNpWFRud0JPMVpJY3hzOFhYdEZLT1hvSnp0VUJXUWJl?=
 =?utf-8?B?WXFEMGFyemF0RDdjWktlQi9SdmFHWlI4cFp2b1lXajV1ZVVzdEc4Z1A4cFMv?=
 =?utf-8?B?TjBKUWxkZFhQSWFPTFp3VmtXYnI0M1EzYlZiaFo2SXl3ZmhvK3pJK1g5eGpq?=
 =?utf-8?B?UzY2NVVkZnhSbVc1OHBXb3BEM0t5dDVIVVJzV0d1bkd6SzVBUkV1Zy85ODA2?=
 =?utf-8?Q?PXnnU2D3gU+YL02YVSxmhhe00xCaPxSHp/Cpk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 06:44:30.1502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1105fd-6a08-48be-2e50-08dc6817d253
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5641
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
 include/uapi/drm/amdgpu_drm.h | 115 ++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index def6874a588c..1217ae30a8d8 100644
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
@@ -431,6 +435,117 @@ union drm_amdgpu_userq {
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
+	 * @waitq_id: Queue handle used to retrieve the queue information to store
+	 * the fence driver references in the wait user queue structure.
+	 */
+	__u32	waitq_id;
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

