Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459FECAC597
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 08:18:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE49110E052;
	Thu, 18 Sep 2025 08:18:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r9Djwkav";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 099CE10E052
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 08:18:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJTVnPTMDHKgqzSpQkRWSWLdxvhjZ2GEcBH0DMaFKzcM3lyFkon6h9b1IavKfasET/MzBVHbI3n0U6PzvKkWFsxYUiVn7CFW85/2lUYJfDnhkeBOW1LLet4l9lVMKSh5lZEWNahtUyt/74P8b555WDu3xKqFtJRYm4kiwo3YZLJqlyJvIFAagMFWBRqfySQYjdvoJlfMJMDgGBmZNc9L+2CkE6g3HDUE6gJ+90tZNYuNIMWUzGs2YIeOvpIdvVDk0gIJ1DLok5cUJO0yXd4DiiBVOWpf4suCZ3hP9hBuaEW//UVNTOGf4pfRekos/f0hSIu/YRwzfy9T7xHg7KVlVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APr/eCauHem/I/k4ZIjskgAZLES6UPMN5uqb5SgVZzQ=;
 b=PwCZ6FfhQDypca/RJ3LcbobQ18JOYsTqZOp+nbrvlpVepVfQVFoaQv3Ik3f4dKeC52ahkLo9dTrSdeWko3Icuiq8D882Q7NC4qut9G08bwp4Rnw5usarj2Dq744D+d/ioKmk9ix1CcyJ4joYGKYNNNmbAxoUt4uu8lWRNr3EnkEDzB3/ehzb1DHikt7oUyo/MKuWDpJiQM8O1LErRG1NjYJTAxBpJYl/2ZQCsdg+rKGVbfR6kgRBQidf86cLwbOy6YpAmLmIcuPsZZ1xttIvM+wIDL8+8Ub9fIy47wh89bo/8ehmSfZ2P4N+Gh2/VDi2no5KoWWGrSSF38HDVc58Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APr/eCauHem/I/k4ZIjskgAZLES6UPMN5uqb5SgVZzQ=;
 b=r9DjwkavkYZJPFLQG4mWtCuqHIAVw1aFk8sHgG3HNkfe1RvLepMzFFldmPtHqRwuzcFENhdNxAk7wozQA0l73vTHtKiHP2etD0xFy9RXlI9w3limJChNSk+FWihJXW2OI7Gc5aPXW/ilmMmYPl6v+DbhVUK+ayraCMueYqoMD1A=
Received: from MW4PR03CA0256.namprd03.prod.outlook.com (2603:10b6:303:b4::21)
 by LV8PR12MB9359.namprd12.prod.outlook.com (2603:10b6:408:1fe::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 08:18:42 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::15) by MW4PR03CA0256.outlook.office365.com
 (2603:10b6:303:b4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 08:18:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 08:18:41 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 01:18:24 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v3 01/10] drm/amdgpu: add UAPI for user queue query status
Date: Thu, 18 Sep 2025 16:18:06 +0800
Message-ID: <20250918081815.2755437-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|LV8PR12MB9359:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b3d1682-63f6-4b9a-c43e-08ddf68bfa72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3ZYcHdCTWE1VU9uQkwzSHlRZ2lZMTgzL0NnREo1ZkF3b1p0RFlSYm1qNktY?=
 =?utf-8?B?WE5LWWFJcmtwa2ZucEJmYVcyZWRIYXh2WVAwaFM0RlhGa095QlZTK0pEc242?=
 =?utf-8?B?eGtlOHpxTnJVZldIUGJNSG5KTXYvS2ZuMGpCMVFUdVNNL3QxZ1poZUdBS2Nx?=
 =?utf-8?B?T2NYSTVqMVJ4Zm5ScHkvZkJKNnZGYzI4dTNoeHdRTnNJYXFDUStYY3p1czJY?=
 =?utf-8?B?K3ZLZGcwWitkVVQwN3IyYUtvY3M3eGg2QVVGaDFhTEg0Tnpya1h0MzRvSkpC?=
 =?utf-8?B?ZWlYZnI3d1pwSkxmSjZzemVHRzEzQ3djOXNVZ0JoZVg4UnQyY1hacEhMUEN4?=
 =?utf-8?B?NHkzWnR4NXU5Wit5bDcxeFdIeGt2R1g2eXpyQjlHd2tXMVhtb0hkVmlrOVRU?=
 =?utf-8?B?M0JCZzJlUXJjRDVkWEF3SldrcnQwT3JoSnMyRlJBVWEyY2JWU2NRS0pXcGZK?=
 =?utf-8?B?WTJBRW1BQ0xVRXlmOU52b3RWQnVsUjNRMElTaXJZdi9oSUExNG1BMGhkR2N1?=
 =?utf-8?B?dFNiMHRXRWI1ZHAzNGI5RUlMZUZMZmpjRzdSRSs4RTg0M2N3cWpoZkszNkxn?=
 =?utf-8?B?V1QrdU9lRUlNb1czRUJGZHFFMUdrNkNER2ViOUV1OXpUdU0yRllGL01QN1kr?=
 =?utf-8?B?UXA5MnE5ZVpBcWE5U1pHb0RCY1JVOENzU21oUVB0TWtEbHRzWktnazdOTXRO?=
 =?utf-8?B?R1kzLzFGV2h5SEJLVTJUV3ZKUkIzbkVOMWpSZ3phdFZMVWsyY0NQb0NpUXkr?=
 =?utf-8?B?Z0ZQbit4TzFjNUk1ZEh6NVcwWmErcFNmU1k0QW51RFpmanhrek1EZ2NmVUxC?=
 =?utf-8?B?eU4xZTZnV3haS2c5L1Z1amRpRG9rMC9tZnhyaHFULzJKTzFpMWZEWlFFWE9K?=
 =?utf-8?B?Qmx4VTcrYVVjQWJuY3VHc2hXRmMyNi9WSjhmbjluNlRyaEZvK2VnaEdqdjh6?=
 =?utf-8?B?eEVSSk1FUGFhUzRSQm5oNXB3a1lhMzBwSE94THBpeGtjeWZvQzNlamtBcFk1?=
 =?utf-8?B?N3pPUUV4WDNCMVB1WDBjaVhTSVJGUzVyaFJmelpuQURJRlJjTWNVSU9Ra05R?=
 =?utf-8?B?Uk9RU1UwbGZtRUhJU2oyNTUvWEdsMm1RSW5MZUpWTzhlSVVIUEhjQ2l4U0c5?=
 =?utf-8?B?THFsQSt4MXNDeituWmJ5cmtES1Q5RDJSdFNmaGxnY2xocjZ6TkYwcFRXdkZE?=
 =?utf-8?B?Q2NRZmtTbDlzU2VKRmljTGxTNzNVMWdLL2NkWlZJd0tpNmM1ZEZ4Q1ZIZC9B?=
 =?utf-8?B?RTVCQ0JueXpnL0J4c1d0Y3c0Z3k1VWVDSU9sNGg4V0dLeFlBQ3M0U2FZdHJI?=
 =?utf-8?B?bXJjSzdvbjRPNFRLbzY3WXEwYWYvUVlwU1pjdnZ0eEVmTUFVRGlrcVNXamYv?=
 =?utf-8?B?SmY2RldPemRnUGY4ajk5VjBuWVgyODdPV2xvMllUcUk1ZVdibkxBUFBMVXpF?=
 =?utf-8?B?NXdmRE0xb2JERjlDL3FPMDVCcnZLWUlXN0YyNTB2R25hbXFxTURKSllXazRE?=
 =?utf-8?B?WWExTjJ5UmpCMlFKYzBxUTlaMjFyRzYxcWNISjhKRUdtTEJBOXlzYXlsTTZR?=
 =?utf-8?B?b2dwKzRGdlA3SFM5RE8ycnFGcjQ2MFBOYUtNZCt0VVR2UGd1aHBIYUxES1Rl?=
 =?utf-8?B?QlN4TThIVWFTUS9zV3JjeFRwMGc0YS9abExpOUN6Qk9MeEdCTDMzNGpHdGZp?=
 =?utf-8?B?UXRJQ3JLdEY4NWNNNnBnQXNFN2d3dkdXTTFpbUovcU9WdkttdXcrYlRTOTBr?=
 =?utf-8?B?cWFRcm44UFBTa1ZuOFlYNFZjZUpRVnVRVDRIU2hVMjYvVDZxQlIyQXhhc1Np?=
 =?utf-8?B?c2c0SmlyNStBb3FranR2aVY0LzNHQ1UyclZlV0F2cDZYV3JUV3BrUkl5TDVx?=
 =?utf-8?B?aGJRZlBmTVN4UDBYaXhkTVBJZDdkMyt6a1NpKy85MTBZbmRqaXoxbU1WNDhM?=
 =?utf-8?B?dkd5U3lCeC95V01BNDRMZTJuQzFvRC9JZkFod2YxTExPcU5MdHozUFh6UVdi?=
 =?utf-8?B?QkJROWxQb3AxZ3Y3UVFtbWxEb1p5NlFRdHFIYVRXUit0cXNYTjZqY1o3djBP?=
 =?utf-8?Q?NuKjaI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 08:18:41.7855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3d1682-63f6-4b9a-c43e-08ddf68bfa72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9359
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

Add an API to query queue status such as whether the
queue is hung or whether vram is lost.

Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Prike Liang <Prike.Liang@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 85b3ca14f81e..7292f7bfcd13 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -334,6 +334,7 @@ union drm_amdgpu_ctx {
 /* user queue IOCTL operations */
 #define AMDGPU_USERQ_OP_CREATE	1
 #define AMDGPU_USERQ_OP_FREE	2
+#define AMDGPU_USERQ_OP_QUERY_STATUS	3
 
 /* queue priority levels */
 /* low < normal low < normal high < high */
@@ -346,6 +347,12 @@ union drm_amdgpu_ctx {
 /* for queues that need access to protected content */
 #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE  (1 << 2)
 
+
+/* the queue is hung */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
+/* indicate vram lost since queue was created */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
+
 /*
  * This structure is a container to pass input configuration
  * info for all supported userqueue related operations.
@@ -427,9 +434,16 @@ struct drm_amdgpu_userq_out {
 	__u32 _pad;
 };
 
+/* The structure to carry output of userqueue ops */
+struct drm_amdgpu_userq_out_query_state {
+	__u32 flags;
+	__u32 _pad;
+};
+
 union drm_amdgpu_userq {
 	struct drm_amdgpu_userq_in in;
 	struct drm_amdgpu_userq_out out;
+	struct drm_amdgpu_userq_out_query_state out_qs;
 };
 
 /* GFX V11 IP specific MQD parameters */
-- 
2.34.1

