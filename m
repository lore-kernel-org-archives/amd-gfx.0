Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF03DC2D0D1
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 14:08:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77E3D10E2B6;
	Mon, 24 Jun 2024 14:08:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ml0dyTq7";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09A4B10E45D
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 14:08:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSurbeBaDHh7Uj/GT+XNvjxd2j6DgPMBGonzmkxG0uGrcxDz9mYZLTdWsooK+9xs9q3fhoU5E7yZ4bak3zAULN5Xy33sMdGRsR1JUBvsmwV8Qem6pU98ftV09f7fVC/ymdGTFFjrehWaKG3QhF2VhBaay0kpPgKHWhgfi1uDa7aqddqiaJ8hvWvSl3KmFEWYaTFnSUfkbEIN1LUNLAprlvxo4a4tyJL35rLgeJcMFUpNPlaCBFp6In9jfn0AsuW8gxU/fjSNQyPeqyLUHJdHRyway7a07Ch4DPgvYBRtabVNT2VkKj1dRBge4OYT/WNVuchVIwbrY6ebaTkNlUG6GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93AtXMclhgUOnRDVnz1np531fP6OzU5lLaJe6Zf/7YQ=;
 b=LlH3+CTdwelGbn7OThEW7bVypnGQ8xLd4AIipNysgz9nEhiUrdlygfRsJllur6B2QZcZVd/vC9gIi08Vspruwns8OgAz8AvR8qEHGtmc+yw1KJ1fjsiLdQKA2WjvvDlAR9nDHUEQrqGLewdNB213SoLOVqxiPBhGnMCC00BcVj6WHFWsNi1jfuW1dXZUDxpDqUq3341YSecQNSz8hoL4bx+eD8BgAlAb30EuToNEyUZM0d/Wr7683TnmnbCgiFz5AtS8KOACXgsh4aWj04WMxijpR20x2NReFdZZYxvRal/H1S2+jl5YOeyaQXw1XUVir73A1D3L7/GySpVVO1j5rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93AtXMclhgUOnRDVnz1np531fP6OzU5lLaJe6Zf/7YQ=;
 b=ml0dyTq70WMPqO9+wiy/jSQxB5O3Kumnqf4DCmGnDFTRyUdmSRs244OkSYv+dDqOxO7YtnwBGLhKdhSLA51geXFNGtkuaOKLzWZpGEC9daRSjeOELMJBo9xKkSg+KSUURnMJBYmbYgd7eKusu4ldcDWpXi7z7KURxJlZyIBHgNM=
Received: from BL1PR13CA0020.namprd13.prod.outlook.com (2603:10b6:208:256::25)
 by CY5PR12MB6202.namprd12.prod.outlook.com (2603:10b6:930:25::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 14:08:31 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::c4) by BL1PR13CA0020.outlook.office365.com
 (2603:10b6:208:256::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.37 via Frontend
 Transport; Mon, 24 Jun 2024 14:08:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 14:08:31 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 09:08:30 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu: stop tracking visible memory stats
Date: Mon, 24 Jun 2024 10:08:14 -0400
Message-ID: <20240624140815.18085-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|CY5PR12MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f9331b-fede-40ee-5b2e-08dc945720e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|1800799021|36860700010|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LEQH4H02BoKyTZAHpNv7j5tG6+n4FDXRK3x+ySEt2iTngnNMUP7rxjBnjUEz?=
 =?us-ascii?Q?aFygy7hDNdK5CYNTYkh+yLaWT5RmA+6XzCDqpbqfuOSX+eqFuEXCo7QWtrts?=
 =?us-ascii?Q?eEfjHOzYJez9Kd9GExDC9+KYaTTVxmA81cYl8TfESYYyN4Qd3h1uwhN7y2pZ?=
 =?us-ascii?Q?WUCHgAZIe6MU+lHyUX4gz8ltnpsaH8g3qBPXTIzgdpcbLU67UoRJSyuO9JHI?=
 =?us-ascii?Q?5CNDqkxL5wD/Jd84/Cop6lTme1aSe136Wr45pABRRtljkcRXMsHyOIlw0o/S?=
 =?us-ascii?Q?z5dKAN7j6VIJ8Q1MdPxie5BCD3MicMJRqsb178wCfdGQa6Otp7MO6zIqjbhA?=
 =?us-ascii?Q?6m9IxcDqhLrOH+YJrozjs4jEVnYTsTaJnq2iHNtCy5zeyjWs+fCHxXbfSAU/?=
 =?us-ascii?Q?W4F6F7cInjqWUw0HGjZSZR48GzU4svzA5jhvNrkDU9RKN/3WaA1cU4YhD7yC?=
 =?us-ascii?Q?dAhhNrTu7ZTvAYQBc92H+YFvHh6rdBK0lg0Tgm/zDlnT92zWWyuYkyhPwHJX?=
 =?us-ascii?Q?ADdyTyBE8EGAxhbSQ0X0lDDEDoonLeL2jGIjuKvTRmzaa5eF3CRTGHMMslkd?=
 =?us-ascii?Q?kMzwbj9lV7UMrTEhSvT16cZvYKB86ver3bXPaIkNEUt2nMBe8LNIhjVz4BWP?=
 =?us-ascii?Q?xYqzaQloukSa461QE9EZ1wgquDX8xWOsbKYFDczgPbfqUla2ArbZTW668Ztg?=
 =?us-ascii?Q?9AykdWZlwIMgsmmKfmWcrOW6nyVfzrY1MLA8oIPUoBKUtQFFNoBXYf109gV2?=
 =?us-ascii?Q?vLlLmlGpH50KaDa+zZzWDLtpuAbG+jGfC9aRumlBU0R+K8yFmwGkoWGeDPHX?=
 =?us-ascii?Q?/3jgCs+CSrk+W7mhuNc9+vF39KI9CUYrqQYT1Ky5nAqDRIJvMKM2IT2nsZ8A?=
 =?us-ascii?Q?0TdXYhPJDcgiJ8eFiwgdg32Utv276LD5cXOoW3JO0H5Nh//qD1+6v3JKy/Me?=
 =?us-ascii?Q?qfCRbzc94+OJxmuu+WSWtd0rhYvZydFs513jxmAuEdrY/wjjgTShpBwy13I4?=
 =?us-ascii?Q?rJBCQfuXl5iwhbSHgLSILyAnB0iauvN1cQ7j7qu5fHuYPaMbK1iWkV6O1Mmv?=
 =?us-ascii?Q?dNOSJoTjB9IcGMDsXPOKjPsdfI8R2aPjVwaos356wMzbvYGWEMoH1U3aoxlV?=
 =?us-ascii?Q?95Bmo1aRy5m5Jk3dJ68cDeapcmyCaqTJKGDSWreG6v9ix4ZdpNUH2DZhK1Je?=
 =?us-ascii?Q?hNtkOBAECqgQoeoBeuNRZGIB3707FiBfEhtIxSlzYK8+PbYvts2tmBa4a/p7?=
 =?us-ascii?Q?5HCwlJff25Tm5l0wcKrZZredpCATiv+jGUvM7ZuIWJrXgnZqJAc1RWjP5FZ/?=
 =?us-ascii?Q?FYdi+6tYqGGK8sRpEGmoTGtlU6slN41OpyogoMJUZO1nB9qdLaJRFytf9DJU?=
 =?us-ascii?Q?IEYurJRWBUocmXUTY2abPIRkMuOxGAhjJ0z32XbxjtLX8AHW/g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(36860700010)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:08:31.3823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f9331b-fede-40ee-5b2e-08dc945720e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6202
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

Since on modern systems all of vram can be made visible anyways, to
simplify the new implementation, drops tracking how much memory is
visible for now. If this is still needed we can add it back on top of
the new implementation.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
v2: split into two patchs for clarity

 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  6 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 11 +----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 14 ++++----------
 3 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index c7df7fa3459f..9a40ff5c6dd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -85,16 +85,10 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 	drm_printf(p, "drm-memory-vram:\t%llu KiB\n", stats.vram/1024UL);
 	drm_printf(p, "drm-memory-gtt: \t%llu KiB\n", stats.gtt/1024UL);
 	drm_printf(p, "drm-memory-cpu: \t%llu KiB\n", stats.cpu/1024UL);
-	drm_printf(p, "amd-memory-visible-vram:\t%llu KiB\n",
-		   stats.visible_vram/1024UL);
 	drm_printf(p, "amd-evicted-vram:\t%llu KiB\n",
 		   stats.evicted_vram/1024UL);
-	drm_printf(p, "amd-evicted-visible-vram:\t%llu KiB\n",
-		   stats.evicted_visible_vram/1024UL);
 	drm_printf(p, "amd-requested-vram:\t%llu KiB\n",
 		   stats.requested_vram/1024UL);
-	drm_printf(p, "amd-requested-visible-vram:\t%llu KiB\n",
-		   stats.requested_visible_vram/1024UL);
 	drm_printf(p, "amd-requested-gtt:\t%llu KiB\n",
 		   stats.requested_gtt/1024UL);
 	drm_printf(p, "drm-shared-vram:\t%llu KiB\n", stats.vram_shared/1024UL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 6faeb9e4a572..bcf25c7e85e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1282,7 +1282,6 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
 			  struct amdgpu_mem_stats *stats)
 {
-	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct ttm_resource *res = bo->tbo.resource;
 	uint64_t size = amdgpu_bo_size(bo);
 	struct drm_gem_object *obj;
@@ -1298,8 +1297,6 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
 	switch (res->mem_type) {
 	case TTM_PL_VRAM:
 		stats->vram += size;
-		if (amdgpu_res_cpu_visible(adev, res))
-			stats->visible_vram += size;
 		if (shared)
 			stats->vram_shared += size;
 		break;
@@ -1318,14 +1315,8 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
 
 	if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
 		stats->requested_vram += size;
-		if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
-			stats->requested_visible_vram += size;
-
-		if (res->mem_type != TTM_PL_VRAM) {
+		if (res->mem_type != TTM_PL_VRAM)
 			stats->evicted_vram += size;
-			if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
-				stats->evicted_visible_vram += size;
-		}
 	} else if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_GTT) {
 		stats->requested_gtt += size;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index bc42ccbde659..218919fc13ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -136,12 +136,10 @@ struct amdgpu_bo_vm {
 };
 
 struct amdgpu_mem_stats {
-	/* current VRAM usage, includes visible VRAM */
+	/* current VRAM usage */
 	uint64_t vram;
-	/* current shared VRAM usage, includes visible VRAM */
+	/* current shared VRAM usage */
 	uint64_t vram_shared;
-	/* current visible VRAM usage */
-	uint64_t visible_vram;
 	/* current GTT usage */
 	uint64_t gtt;
 	/* current shared GTT usage */
@@ -150,14 +148,10 @@ struct amdgpu_mem_stats {
 	uint64_t cpu;
 	/* current shared system memory usage */
 	uint64_t cpu_shared;
-	/* sum of evicted buffers, includes visible VRAM */
+	/* sum of evicted buffers */
 	uint64_t evicted_vram;
-	/* sum of evicted buffers due to CPU access */
-	uint64_t evicted_visible_vram;
-	/* how much userspace asked for, includes vis.VRAM */
-	uint64_t requested_vram;
 	/* how much userspace asked for */
-	uint64_t requested_visible_vram;
+	uint64_t requested_vram;
 	/* how much userspace asked for */
 	uint64_t requested_gtt;
 };
-- 
2.34.1

