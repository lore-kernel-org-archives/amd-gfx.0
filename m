Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FF7C982D8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jan 2026 16:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78A3210E8D6;
	Fri, 16 Jan 2026 16:20:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xdnBEBx3";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C65310E8D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 16:20:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D052ju1yMV4mgX6/8PXD5JxbmxWSChhDovsTPqk+CWFPPxjUmfi0eZWlYjXcfLj/X97657VlHjvBjfTR+SnRs91GqY8uG1iDdvX/OcCu1GzjcjhB9mEBmedaMFKjfJZXsJYgl3h6SclKiDHS34LBYWjyykJRXfGP4clolJn33O3WJkak7Gj/OKnyWnEujooje5UheC+q+HZZ36ceClh2DmY6zV0PqYuirJr+uTkSOTDhfy8KB1aLrRlUbhY/uR4EGCcUqLNmIV3zK4ey9wURdPBZDM11lar+4s8viF5W9C3H4OKphymHo75vYQO16KkRv7HReo6UGao3dPmEaQxo3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CPb7+lhTPNVGk3hiBjGHasZJQtsLf9Rxeqq/29FBrs=;
 b=sqMpTpL/arGIyUGsnHuVYZmxVf9Ij7sssiwXxOokaciRxf4d9gpEglGkX9qyFcHY/f5Kh7537LHz/zpPzsIMjhTULVil+CrrMZ1zaO8Lzkqr/dn0CqRewJTt2RsszNmi1a5n236j0zjPWZppJPiFir37YSKy0CSV45J0FW8qvPqeT9EtnTPb4NyUynNpzIsKjA8CF/UKNy0DPqq/Nu4tVA89rj7Uojes19UI4CYhSr/0xmo++LsFZcojKnPO+K/7SIBjk5CEUyEDHGtihg4YGfehMQrPltwS8inSPAQNVBJO3ohZBA6CVUlCWnZ0xXLt2jSARNSc4hwgkQVGt03JJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CPb7+lhTPNVGk3hiBjGHasZJQtsLf9Rxeqq/29FBrs=;
 b=xdnBEBx3+TRR9rVsg2a1Sf9aMoyvh+UVuXt3sfC9qCj9RBhqXZMHUlMsVEKn1C6xaF65hZ/9AUOT7xbQyXhgcmb3dGSbAxb/K+AUWzB8+QPDKcHhrUgUd2jdFbt8u5Ed4enC9juuzcw5cTBKuXLf6RU9v7Hh1Ik7oYWbWFvT6i4=
Received: from BL1PR13CA0353.namprd13.prod.outlook.com (2603:10b6:208:2c6::28)
 by DS7PR12MB5958.namprd12.prod.outlook.com (2603:10b6:8:7d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 16:20:44 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:2c6:cafe::cd) by BL1PR13CA0353.outlook.office365.com
 (2603:10b6:208:2c6::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Fri,
 16 Jan 2026 16:20:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 16:20:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 16 Jan
 2026 10:20:42 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Jan
 2026 10:20:41 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 16 Jan 2026 10:20:41 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/10] drm/amdgpu/job: use GFP_ATOMIC while in gpu reset
Date: Fri, 16 Jan 2026 11:20:20 -0500
Message-ID: <20260116162027.21550-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116162027.21550-1-alexander.deucher@amd.com>
References: <20260116162027.21550-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|DS7PR12MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e028c3-0062-4938-3fb8-08de551b32f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lWLBemUC2MPot8FOMH1DTwGmRFC/22x5LHqntMhYrtviRBgQGfAQ2DOw3iQI?=
 =?us-ascii?Q?bwJct9HKGuL96OKq4eM+T7kZkO5rmYvMX23q4PszVFjSnVSEDxQ+ZKbXWuik?=
 =?us-ascii?Q?L5P21aZjabEcBKk7VUc4TQ52bNkDtisvtvdBnLyOtqajvqMbuy78+DhuKOvj?=
 =?us-ascii?Q?98ybwyTpxFpVIxr28Ek31kaIcQwhtcLdbtGJ/EaPLRi9tiQhVwwO9OqovTwR?=
 =?us-ascii?Q?YH284jfiDjHOedExqiElCNeWbB0sgS1igXZNl5G0mnEIdigaeS2LKLDuZpNt?=
 =?us-ascii?Q?gT1vwN/wXV/qlv3u2y6UQIeBszE4UUq+aEIGtSAHuhFsvnnTxE02NQMRz2M/?=
 =?us-ascii?Q?MazzA1iQ0U1rDeK8yjQNgYSbEwBu/08U+6uvT/ResF5TPKJcavPzm/UvL725?=
 =?us-ascii?Q?LSNljWXPfl2k7ZnnmVvqDu4ang2h1ABjRzNK7L40jP6PcbdYPS/phsKNmvXk?=
 =?us-ascii?Q?+qM5ihObGY0vjZg3kzOuyex7HilHwf1CLaIoHm02sxl6hA4RW9uuF+lpbMj+?=
 =?us-ascii?Q?qRQh2pz9NQVGncKGIgK9YTrYKM7elq8tvAj2GZq1u1CLOSDTbcE+57y92WUP?=
 =?us-ascii?Q?u4JVrztAbFKkVNe/Ae02dCs3lqV7lUTNED7oW81A9/mNiAYryTcm9055wAaQ?=
 =?us-ascii?Q?psyPNtRQzdCSBS1E21uh7jy5HO41p0bg3f4J4sWWJyfihqvCiU/OzrBdpHme?=
 =?us-ascii?Q?WngVpu8QOxbZ2gqIK8HOYCLuZ6l3Plwp88NF7zcWTADayFK8N7ta3zLn9SYC?=
 =?us-ascii?Q?5ZbqJKZTp+che+vFmsDlBysSe+uIA/xSlWGsRcKx96uruF3/uZPG0DbM3+7c?=
 =?us-ascii?Q?HUYbMc6Uyj7hK9MfY21xLGYsGlP7nCCC0GJFUsN/PxV2UOJVc2R/qV8I0HoH?=
 =?us-ascii?Q?Nz3b9/9sfSaS+UZRD9hziqMkm6r3tJHv0BYDkZ9a/862eURT02u/uGNynErP?=
 =?us-ascii?Q?2RnrnAPGzSPsWmBjc5SH05vLeIAjxU5gLpx7WS4d+DPJQiobOl/lQWOm3eia?=
 =?us-ascii?Q?6IZrnd07r8I0KYFVTESQAbEMjuvuBvHYJufjbOkiDn/Mh0GEnyCEfpXVEQhN?=
 =?us-ascii?Q?SCbffRJdUX/aycB/NkYceIZWnEsWWAou+b3RS2cFA2tZwTf3F2CH6fh2sOsO?=
 =?us-ascii?Q?VL/TLXo63UD4C4ocra1CSJctZqkz1osnhDkYk1C5DTB+4zDrr5Ilv7OLJnao?=
 =?us-ascii?Q?giRxwcEB5IZKeltZXoJTqk1+SmlgsQ/kL2DI8oyWaiA3lQPsu7dZetCjP2d+?=
 =?us-ascii?Q?aH9PV1rfAAVyLN8rPCkCqEnrLL5ToL/UJvgwJziI9WI6GyrYO3dKXzcebuS1?=
 =?us-ascii?Q?Aw+kA4ojOBxpiMfSmwIhDXiIUG0ZTzEqlM8eUDdvIq3hR6OszKbWOcZ9oNKO?=
 =?us-ascii?Q?yovnykfpbn0uLNh0AuWw0W9tN+ew17mZsYio2txwlhWa2Zj4EGQ90j4yPR4f?=
 =?us-ascii?Q?T9VyCoEmPEutG4Ha17UkCzbNtRh+K9/KuQmP4pm/L6/a7N/HxtDO8x7jZlvW?=
 =?us-ascii?Q?FTWLW2B8fnWuNZxn82iIlLXCWZ8IoVPDRpgE+uQJVYLgfQpDpWkLARbXojRK?=
 =?us-ascii?Q?VXA+w2cgbeycEkFOgFPnohQY+7HC36QOHO2n/D4XQVyhWfyWfDln9IhZV9oL?=
 =?us-ascii?Q?NJaQtw4+GJPxG+AXzFtriBA3mBRIO+YVH0LAsCQ2GUEfYYaSwGPlv6TSFW0B?=
 =?us-ascii?Q?OpIz2A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 16:20:44.0028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e028c3-0062-4938-3fb8-08de551b32f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5958
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

If we need to allocate a job during GPU reset, use
GFP_ATOMIC rather than GFP_KERNEL.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 9 ++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c     | 6 ++++--
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 72ec455fa932c..136e50de712a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -68,7 +68,7 @@ int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	int r;
 
 	if (size) {
-		r = amdgpu_sa_bo_new(&adev->ib_pools[pool_type],
+		r = amdgpu_sa_bo_new(adev, &adev->ib_pools[pool_type],
 				     &ib->sa_bo, size);
 		if (r) {
 			dev_err(adev->dev, "failed to get a new IB (%d)\n", r);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 1daa9145b217e..c7e4d79b9f61d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -192,18 +192,21 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (num_ibs == 0)
 		return -EINVAL;
 
-	*job = kzalloc(struct_size(*job, ibs, num_ibs), GFP_KERNEL);
+	*job = kzalloc(struct_size(*job, ibs, num_ibs),
+		       amdgpu_in_reset(adev) ? GFP_ATOMIC : GFP_KERNEL);
 	if (!*job)
 		return -ENOMEM;
 
-	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
+	af = kzalloc(sizeof(struct amdgpu_fence),
+		     amdgpu_in_reset(adev) ? GFP_ATOMIC : GFP_KERNEL);
 	if (!af) {
 		r = -ENOMEM;
 		goto err_job;
 	}
 	(*job)->hw_fence = af;
 
-	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
+	af = kzalloc(sizeof(struct amdgpu_fence),
+		     amdgpu_in_reset(adev) ? GFP_ATOMIC : GFP_KERNEL);
 	if (!af) {
 		r = -ENOMEM;
 		goto err_fence;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 912c9afaf9e11..7ee0cc46b4608 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -339,7 +339,8 @@ void amdgpu_sa_bo_manager_fini(struct amdgpu_device *adev,
 				      struct amdgpu_sa_manager *sa_manager);
 int amdgpu_sa_bo_manager_start(struct amdgpu_device *adev,
 				      struct amdgpu_sa_manager *sa_manager);
-int amdgpu_sa_bo_new(struct amdgpu_sa_manager *sa_manager,
+int amdgpu_sa_bo_new(struct amdgpu_device *adev,
+		     struct amdgpu_sa_manager *sa_manager,
 		     struct drm_suballoc **sa_bo,
 		     unsigned int size);
 void amdgpu_sa_bo_free(struct drm_suballoc **sa_bo,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
index 39070b2a4c04f..fc13969f8ef49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
@@ -76,12 +76,14 @@ void amdgpu_sa_bo_manager_fini(struct amdgpu_device *adev,
 	amdgpu_bo_free_kernel(&sa_manager->bo, &sa_manager->gpu_addr, &sa_manager->cpu_ptr);
 }
 
-int amdgpu_sa_bo_new(struct amdgpu_sa_manager *sa_manager,
+int amdgpu_sa_bo_new(struct amdgpu_device *adev,
+		     struct amdgpu_sa_manager *sa_manager,
 		     struct drm_suballoc **sa_bo,
 		     unsigned int size)
 {
 	struct drm_suballoc *sa = drm_suballoc_new(&sa_manager->base, size,
-						   GFP_KERNEL, false, 0);
+						   amdgpu_in_reset(adev) ? GFP_ATOMIC : GFP_KERNEL,
+						   false, 0);
 
 	if (IS_ERR(sa)) {
 		*sa_bo = NULL;
-- 
2.52.0

