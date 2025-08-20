Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F72CA0EDC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 11:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5722A10E702;
	Wed, 20 Aug 2025 11:33:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1dq32emy";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92F9110E6FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 11:33:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tiBHpRxglRp/ZkgAD5NQBr/2oMoLHBpYl69GdsaeNXAixnK/mmVOBwQYxnlkKJNxM/4lbjcXb/DiEJhv1i2g9j1ZoM0DatXsG4IgIq2lcOu8IfDHaiwnFvpcIa64JHG8qBtQHql+Ol07+/bao4FuamtXLo9m0AvoGWcwDUTLpVIcljT4BkoMlrnZbieTMqBNPauKJBXFUwx5mxADOsdDoo17y9icuXlG9169j8T44jy8JmslEcCdNBexEP2se2UsyuxV0ndWrjG/LHVQw0GnxcmFv9PURksmvUfdydLjmgOHUDSG784b/8LFZtDr268LoiOC2Fhb6Tgjyw+fffzhdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3smjigzHDofLS4xCd7ua6f5tD05PSj/pnLO65l+4tY=;
 b=aKg3QrTIb0fc6soFfFUyMNS9cy4iNuglC9RhMEOBw6BCHgp3jXUOdiP/NCsOCHnCeTeWTtZFWSrFZOeQImR4wlxOM6CeIO2+cerVTCZeQ/i3EOz/FJdzmbIWVi9n54up46dvPxofBHtWR/mP4E8v2FGrKQnmEyT/iPsoKXuMZcp9OPR2ILoDXsIy86D8fyZ8TJaTQLtgCXeaztaS7weQpn85Yuul6qdpwYOoObXHGeHoECF6U5YXHJgPMoEpuAzc0BV75yv+5mIe6McGWp2pEV8fxUs8LMUwzIRvGOjQMyQEqrAzqrLB7TuP4pwn1MO2RMy2utJaeRI73L2CQaDm3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3smjigzHDofLS4xCd7ua6f5tD05PSj/pnLO65l+4tY=;
 b=1dq32emyDU/nxjKZVNdLYY0U/XlGHSD/9fD08HIHKEXAikm+PrBDxpBAj0hsR+C6UQ5YrBx1IfoTmGK+MsHRQdIwSoQfVHHftLkCK7ditjyofqGBxmfG9sTZzxdxwYl5AUOi4cqSAdKb4qEYtTItCiXAglxitnm74AZIdCnZvQ0=
Received: from DS0PR17CA0009.namprd17.prod.outlook.com (2603:10b6:8:191::9) by
 MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Wed, 20 Aug 2025 11:33:34 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com (2603:10b6:8:191::4)
 by DS0PR17CA0009.outlook.office365.com (2603:10b6:8:191::9) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14
 via Frontend Transport; Wed, 20 Aug 2025 11:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 11:33:34 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 20 Aug 2025 06:33:32 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH 7/7] drm/amdgpu: Return Handle to MMIO_REMAP Singleton for
 GEM Create
Date: Wed, 20 Aug 2025 17:02:54 +0530
Message-ID: <20250820113254.3864753-8-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|MN2PR12MB4269:EE_
X-MS-Office365-Filtering-Correlation-Id: c24c2427-922f-48b7-4005-08dddfdd65df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWR2ZmlrMzlRaWx1QnJPK1RxWS9SWmxiczV5TFdITldsalA4WjVVMFJreFNP?=
 =?utf-8?B?cEZieUFmUEdFUFRDc1BhZG9Xd0VQMlMwY3NUa1VrK1EzUE11d3ZqUVVNT3Zn?=
 =?utf-8?B?K3MweGtnWU1xWWgxZXRwcVJFSHFMcXlIb3ZtN3pobDZtUXpudmZtYThDNGZw?=
 =?utf-8?B?c1krdHdPUVlyOE8wZEdoL3oxSDZjQjg5MjJLQ3ZxWkg2M29tdFhCeXdZbXdF?=
 =?utf-8?B?UUUwdWFMb3A4QUNJRmR1cXc0MWkvNHhzSnFuUHJsc0VsYzNHOC9ocjZIMTdU?=
 =?utf-8?B?UGpOUzZUbDVsNXpjRCtSZlFrcFZsM3Y3Sm1SbGpURzM2dUtpOHZMR253R1FF?=
 =?utf-8?B?S1FBb1pnMitreUswVjN3Zyt3NjQxRnRNMGFuaTN3OVRvbWcvSEl2RW5WZTBB?=
 =?utf-8?B?ZTV3UVF6STJjc3ZjS1FsSDFmUTlaa1hjckxLZXMwc3ZGelYrQmtuSGVmOGlC?=
 =?utf-8?B?VEQ5UytiWW5mb3RHak5jNWRQcE5XRytxSTVyZjZVdVR5VnhzNy9Gc3lROStX?=
 =?utf-8?B?Y3FuNy92NkNPTXVHc3ZTdm9sa0F1NjFZMFVJVGFGbXJvMjdIbXhlSFdsVG43?=
 =?utf-8?B?N2F1Y08rYWkvSXVpcUhEb0grQ256VTE0R2ZmVVlWUUY4S1lpWndQK3VsU0gv?=
 =?utf-8?B?UlExTGRpWC9mTVIxc3htbTJRcm1OMnRWWFhyWGVOcmIrbTVYNU10QXRJOVEw?=
 =?utf-8?B?UjZmcko4bEhmZ2wxeGRkZHFpVjUzSWN0RGhJMDZFand1OEJMRU1nQVVrMWRY?=
 =?utf-8?B?SzRnZThoU2JFSWV1V0hXMElMOXMxTnpYN05rcWc2MmFhenJRWHFQMDJGRVFZ?=
 =?utf-8?B?QWMyU25NTWVtcWh0MmVQVm9TenFtcWVGb01XVVViTEF6WDVtWmlZTWcvRm0w?=
 =?utf-8?B?TEsyQWEzZWV2OHFOMkdqMEU4eU4xd3VnekxVeGh1cm5LSkNOZnRkNDdlcFd0?=
 =?utf-8?B?c01uajRCNVFaVGN4bHpmanF6RGcrUGJlTmpjNllJRUpWWU5nNEQ0MjZqeVhy?=
 =?utf-8?B?c1RBbkhhZjJoVDdjaWVxcytOR0t3WkJ6ZTJnWDNkRmovdjNYRk1rRDVXa2VF?=
 =?utf-8?B?YW5LZ053UGZjWFVSbGhSeVZ1aVlsN291U2RQcFBMeGx5aTFuSUtQSTN0Rk9B?=
 =?utf-8?B?aTNVS1VPT0NIMHJWNktiS3NzMEhsU3RvdVVwRUlobk9hMTcrdFdRajNmVEVh?=
 =?utf-8?B?R3g0RlJyTVp1bi9NY3hmeGZlcmFJWGE1Ymh3bGR4RjlMN0NKMWdRT3pkWmdP?=
 =?utf-8?B?UytINmJoVnNsUm9lazcxOVZzZFh2NzNPU0NLbm1Nb015OXk0K3RXVkt4bmNF?=
 =?utf-8?B?c1dVUUNLay84cUtXb2JUMTl5aWY4U1Z4NHZYbkgrbVRnWlRyWDJIV1FHdzNk?=
 =?utf-8?B?cU5DbFRpTFl1TWYyQkVMTjFDRzlGNVp4TG5CdHIzMVJYZTZDdnBHR3NGZ2sz?=
 =?utf-8?B?bEg1Nzl3bU5MbG53Z09YR2NVSXZ0OFNnVE5qY0JMd2VhUlVmRlc4cFU3cUJh?=
 =?utf-8?B?aHlvMTVRc1ZOcHNZNENLdG5xSnpWc2xpUEd0bFZ0ZXJuSk9KTjNJMGRZN2pl?=
 =?utf-8?B?MWJ0VDRaZ0Z6QXVnU2R5RkJjdmtSUGxxcjZHbGU2ZDVxM2FwK1NtWWV1U1NC?=
 =?utf-8?B?cHBpWlJmZ0J1RDVrYzM2NU9HdDgrcmlnZmVJL056SFNkcXREWHhKSUdBcmU2?=
 =?utf-8?B?Ty8xTHRXdmtwVmUvYWRROU5ublNHSGZGb25DNzBpZ3JwVjZRL0E0bDBvSHFn?=
 =?utf-8?B?dU5GR0JIeWRIdkthOVBCVmlSQ2JnNHZ3L1diWnBOSy8zSzVGMUt3SG1yLzll?=
 =?utf-8?B?RE8zNHFyOGpzMzNmK0hpa0JRT2gxd09ZZVZxMnMrR0ViWGtGODd2aG5HUkR6?=
 =?utf-8?B?b3FDMFlGeUFYZmJFckNBYTFSN1lSdlA2Qnh4NnFKMzE3WTQ0ZG0rekdzb04y?=
 =?utf-8?B?Wkh3d1ZwODBxd2FYQjBhWS9SQjFBMmk0YXFXK1U0ZWZwaE5XNjRJVVRxU3hq?=
 =?utf-8?B?R1FxYjVTei9PSGhldDVrVjJuWUFwaXlENEgyS1owVjFCTHorVXRaa1NxaXhQ?=
 =?utf-8?Q?ODjfTa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:33:34.5574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c24c2427-922f-48b7-4005-08dddfdd65df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
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

When userspace requests a GEM in AMDGPU_GEM_DOMAIN_MMIO_REMAP, return a
handle to the kernel-owned singleton BO instead of allocating a new one.

Validate inputs (exact PAGE_SIZE, alignment PAGE_SIZE, no extra flags)
and zero the ioctl out-struct on success for a clean echo.

This puts the userspace-visible behavior last, after all internal kernel
plumbing and initialization are in place.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 56 +++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index e3f65977eeee..1345e81214e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -424,6 +424,26 @@ const struct drm_gem_object_funcs amdgpu_gem_object_funcs = {
 	.vm_ops = &amdgpu_gem_vm_ops,
 };
 
+/* ========= MMIO remap (HDP flush) GEM handle helper ========= */
+static int amdgpu_gem_get_mmio_remap_handle(struct drm_file *file_priv,
+					    struct amdgpu_device *adev,
+					    u32 *handle)
+{
+	struct amdgpu_bo *bo = adev->mmio_remap_bo;
+	struct drm_gem_object *gobj;
+	int r;
+
+	if (!bo)
+		return -ENODEV;
+
+	/* Take a temporary ref; the handle creation will hold its own ref. */
+	bo = amdgpu_bo_ref(bo);
+	gobj = &bo->tbo.base;
+	r = drm_gem_handle_create(file_priv, gobj, handle);
+	amdgpu_bo_unref(&bo);  /* drops our temporary ref */
+	return r;
+}
+
 /*
  * GEM ioctls.
  */
@@ -465,6 +485,42 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	/* always clear VRAM */
 	flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
 
+	/*
+	 * === MMIO remap (HDP flush) fast-path ===
+	 * If userspace asks for the MMIO_REMAP domain, don't allocate a new BO.
+	 * Return a handle to the singleton BO created at device init.
+	 */
+	if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP) {
+		u32 mmio_handle;
+		/* Enforce fixed size & alignment (exactly one page). */
+		if (size && size != PAGE_SIZE)
+			return -EINVAL;
+		if (args->in.alignment && args->in.alignment != PAGE_SIZE)
+			return -EINVAL;
+		/* No extra domain flags for this special object. */
+		if (args->in.domain_flags)
+			return -EINVAL;
+		/* Disallow flags that don't make sense for a fixed I/O page. */
+		if (flags & (AMDGPU_GEM_CREATE_CPU_GTT_USWC |
+			     AMDGPU_GEM_CREATE_ENCRYPTED |
+			     AMDGPU_GEM_CREATE_DISCARDABLE))
+			return -EINVAL;
+
+		/* Normalize inputs (optional, for user-visible echo/debug). */
+		args->in.bo_size     = PAGE_SIZE;
+		args->in.alignment   = PAGE_SIZE;
+		args->in.domains     = AMDGPU_GEM_DOMAIN_MMIO_REMAP;
+		args->in.domain_flags = 0;
+
+		r = amdgpu_gem_get_mmio_remap_handle(filp, adev, &mmio_handle);
+		if (r)
+			return r;
+
+		memset(args, 0, sizeof(*args));
+		args->out.handle = mmio_handle;
+		return 0;
+	}
+
 	/* create a gem object to contain this object in */
 	if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
 	    AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
-- 
2.34.1

