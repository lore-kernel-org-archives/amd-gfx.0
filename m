Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A83CCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:52:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CE8510E21A;
	Wed, 29 Oct 2025 17:52:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="niW+XUfp";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013048.outbound.protection.outlook.com
 [40.93.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3704110E812
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:52:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fs8xtP+8Ffjxs1dwg5mufyGA60u8wf5X9xGNJbVzlJrVdJdBIGROJz443uv91PO4O4EjS6p3EN5QRoBwhfBWGjqyHHyn/XdHLuhSTXa/2mNblsA2cWZkuvb78cVme5XgROWqYYM2jGXvSWXahrts9NoP4uZw91QDPNEPAQkc5SgXWYS/BBBKS/5VOvJ4CtMTkLQiD5zx/aOFzBCYC/3SJFCKSwMOXm1srylLivFV3zVrrOKWLuULsBP1PjDzpO05NnVWVbZpWFy/npkSH60FWgTJ4SXB717HYUMTkIc0h2hQBRhu0zBZqSVxMEoTIbuJpui2dv9UEuWTbs8qHAgi/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+BJDeA2JVzQqbhC6O30tznN2E9y4MzYx81Pe/gfJNA=;
 b=m8r1IPnsxGeYGhX9RjkikjKbJZvX3zZi9euTEqCo6Fa5lhVvywFoO+3Rk+5wglP1Q2d8VoX5p6WwSol64ejvVU4oe5C6tNj4NheaGe1bEHkRWzAk7V56cMXgk67rTje8TJR1qJ7WNEtiK8McOleE91QSZmGcBmRcToPJGa5ab5tEkZvEUUlbj8mLGtM64j/BqyrY/5RAD7XY6GUqvem1Bc9FTmrXZTHae+trJR613IDapPR7UVtTbsQBktFLpw9h2VHM84wbRoN2day0aRqIPaBhVyhYy/o/p+qV9mMfils+r5R7LUdABGAFuN9dK2juHrmcg7ZeTzs3wDKb39NHyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+BJDeA2JVzQqbhC6O30tznN2E9y4MzYx81Pe/gfJNA=;
 b=niW+XUfp8m1ddoFdG9Am8KXuCI2fjHcSmD/c3VDHhf197H0Oc9NDLuYfweI05a72+0SbIbu6kOjcJNpKesvlN7kO8eRtZI4iW/7bqz/TQSFVc3rXC7wM9th+y0nAayU45njvb8PqKtaaBQBKjpeGTxa/LaAyPI7ylK4eXpyXQPk=
Received: from BN0PR08CA0020.namprd08.prod.outlook.com (2603:10b6:408:142::8)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Wed, 29 Oct
 2025 17:52:02 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::76) by BN0PR08CA0020.outlook.office365.com
 (2603:10b6:408:142::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 17:52:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:52:00 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:51:58 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: James Zhu <James.Zhu@amd.com>, Bing Ma <Bing.Ma@amd.com>, Gang Ba
 <gaba@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: refactor rlc/gfx spm
Date: Wed, 29 Oct 2025 13:51:33 -0400
Message-ID: <20251029175137.2861556-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029175137.2861556-1-alexander.deucher@amd.com>
References: <20251029175137.2861556-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|BY5PR12MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: d44b3d41-27bf-4efa-966d-08de1713dc83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Syjhj+WQbirMCXcKTBjnYDIV/K3PLSjnDQAK5S15QYbeNxUgQ0H+yAfEkGeM?=
 =?us-ascii?Q?lvfoW4dP6Zzrqpm/cvNoWPR35o6CIRZXGj2bH6CtK3E3PGV8ImSL9U2n05Zt?=
 =?us-ascii?Q?Qumb6WSKQ+FJaiPuQfCZFL7hS6VeH9os0DBKgOpmdu/0VYf6ymTYxJO6BY66?=
 =?us-ascii?Q?otSJ30LaRWHzlhu0LqK9iHvKmo6KXX4TxcYLhhqN62ArqkC57LKE2qkUd/AW?=
 =?us-ascii?Q?ARAEiyaTbRrlHOnq84BlJxDcMF4cQB4k4DLHV8Z3hWtTkFjIncL8wHCNUeYv?=
 =?us-ascii?Q?bN+aq2bSNOQCqxF0C5LZJ3v0O52uHeyvNqB3PrrGDBTRYh3IWiuJWYwZV2Ep?=
 =?us-ascii?Q?XI1LHh7TJigILC3025IF0n/wzxAfh5hkPbBm3/6lHxeezfBrZ5ReapiEnq3b?=
 =?us-ascii?Q?cgVrE52CUHUeb79sfHMusNjXk1ouKwjVsA3kbvlw31Ha0dRIWf4i+cBqp7MQ?=
 =?us-ascii?Q?Zqy7ZK8p4Lj9PXL0HGRjxvKo44WtSBaFRf3rbQYk9KLukvAl+ws+6WqqkI7+?=
 =?us-ascii?Q?x06QpMhLKNY6aldbEv1QeP5aBd2LL+5c6Fb3AF2WrlhkarUiwHxh4JDEcxEn?=
 =?us-ascii?Q?HXGLu3v4LqppV+jrAl7HW0IABG1lRLsIZKc8ybbPk27HJcmLq+jvKb00L8bz?=
 =?us-ascii?Q?RKpbgFS/hUSxriCkewYEPUAStenpjhS1mes8bV3rz62IpljF0W/J1/+y6Jq0?=
 =?us-ascii?Q?NWI7vq7P70Cbai+BUEoHr0VojpPIGBU/05xvw6VrCPKlNhmwebD6IVGHKGLj?=
 =?us-ascii?Q?EEOqEPc5eqBIGIdQfSQL1fxxD+Z/eMXzY1ttEH8ZM/WBgyUXOpohu6BSPt57?=
 =?us-ascii?Q?tZokxnit1pTu6QQqgGl4jlt5qaZ2QGT7pQ3TKAkS0IKykQJS5lsDr/SKpHgU?=
 =?us-ascii?Q?lrydDjSaG3LmtFZiaVfdF71LhjvhhDkqFxa1wkn2nSiUJsf3s07RWkYNjJ4N?=
 =?us-ascii?Q?IHNQ4KLiVDUcXcQyJl9NYOx+EBuVAayB4SPOGIF56bVshxf2qGL2xXNcY0hi?=
 =?us-ascii?Q?SVqnRpbM6d3jcgOpjaqb/5ojmpoNTXafz0GgIThslaZKkwPXpVQF26nZtkzK?=
 =?us-ascii?Q?pKILcWlcwDh/4fXiZNHFluqT0txw01S2rzdJffTZUxU/+iaPufca7N/Z4Oga?=
 =?us-ascii?Q?TQkhgVvriTpvJU0+z3kveEVMcj3nqTpTQW7MtFV/p3P3W4y2Il7PgYidYTu9?=
 =?us-ascii?Q?k8LTt3/anWEvG1YKq3HWxJvb9GacHswk/cFl1ZxnK67vG6u5HcGv4cUKl3fG?=
 =?us-ascii?Q?ff4+Pu0/2OTtl5TrJaIFkYvdelajJt4yzoUbgW7O9CigxXTWqDFc8uEGvy4I?=
 =?us-ascii?Q?caz1h3oWfKy6xggMEx0d5cxcQdEJqu9KgbsArC3moBUPax3PeEG22CN/eEhA?=
 =?us-ascii?Q?tDRNtmAlZH/T4jRjDDQkOILtLrQnEMkaVVennJwjrTVIKUf3TZswka2h7WnB?=
 =?us-ascii?Q?PziJfhgI3UXrphPCACz2p6XF503ISHvheGXgzYRWU1oVWanmHgwCJXubgEwB?=
 =?us-ascii?Q?nSh0hFHQlOGpHRvvYn4sO6gKcmXA7oDjoTcIMLwuYbOJn6mpzVXvP2d32hQA?=
 =?us-ascii?Q?XOkgzCc1m6GcSWxus5A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:52:00.4198 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d44b3d41-27bf-4efa-966d-08de1713dc83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130
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

From: James Zhu <James.Zhu@amd.com>

for adding multiple xcc support.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Bing Ma <Bing.Ma@amd.com>
Reviewed-by: Gang Ba <gaba@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |  5 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   |  5 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  5 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 12 ++++++------
 9 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 2ce310b319421..3e2d2e333907d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -257,7 +257,8 @@ struct amdgpu_rlc_funcs {
 	void (*stop)(struct amdgpu_device *adev);
 	void (*reset)(struct amdgpu_device *adev);
 	void (*start)(struct amdgpu_device *adev);
-	void (*update_spm_vmid)(struct amdgpu_device *adev, struct amdgpu_ring *ring, unsigned vmid);
+	void (*update_spm_vmid)(struct amdgpu_device *adev, int xcc_id,
+			struct amdgpu_ring *ring, unsigned vmid);
 	bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t reg);
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index db66b4232de02..1fab953e9a030 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -830,7 +830,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
 
 	if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring, job->vmid);
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
 
 	if (ring->funcs->emit_gds_switch &&
 	    gds_switch_needed) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d75b9940f2487..aaed24f7e7168 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8318,7 +8318,8 @@ static void gfx_v10_0_update_spm_vmid_internal(struct amdgpu_device *adev,
 	}
 }
 
-static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, struct amdgpu_ring *ring, unsigned int vmid)
+static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
+		struct amdgpu_ring *ring, unsigned int vmid)
 {
 	amdgpu_gfx_off_ctrl(adev, false);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0a7d495c62e92..ca4d4a1b109cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -918,7 +918,7 @@ static int gfx_v11_0_rlc_init(struct amdgpu_device *adev)
 
 	/* init spm vmid with 0xf */
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, NULL, 0xf);
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
 
 	return 0;
 }
@@ -5569,7 +5569,8 @@ static int gfx_v11_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, struct amdgpu_ring *ring, unsigned vmid)
+static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
+		struct amdgpu_ring *ring, unsigned vmid)
 {
 	u32 reg, pre_data, data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 9a18df0950373..f9cae66666973 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -762,7 +762,7 @@ static int gfx_v12_0_rlc_init(struct amdgpu_device *adev)
 
 	/* init spm vmid with 0xf */
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, NULL, 0xf);
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
 
 	return 0;
 }
@@ -3957,6 +3957,7 @@ static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
 }
 
 static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev,
+				      int xcc_id,
 				      struct amdgpu_ring *ring,
 				      unsigned vmid)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 2b7aba22ecc19..66a4e4998106f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3245,7 +3245,7 @@ static int gfx_v7_0_rlc_init(struct amdgpu_device *adev)
 
 	/* init spm vmid with 0xf */
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, NULL, 0xf);
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
 
 	return 0;
 }
@@ -3471,7 +3471,8 @@ static int gfx_v7_0_rlc_resume(struct amdgpu_device *adev)
 	return 0;
 }
 
-static void gfx_v7_0_update_spm_vmid(struct amdgpu_device *adev, struct amdgpu_ring *ring, unsigned vmid)
+static void gfx_v7_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
+		struct amdgpu_ring *ring, unsigned vmid)
 {
 	u32 data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 1c87375e1dd58..5d6e8e0601cb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1274,7 +1274,7 @@ static int gfx_v8_0_rlc_init(struct amdgpu_device *adev)
 
 	/* init spm vmid with 0xf */
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, NULL, 0xf);
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
 
 	return 0;
 }
@@ -5541,7 +5541,8 @@ static void gfx_v8_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id)
 	}
 }
 
-static void gfx_v8_0_update_spm_vmid(struct amdgpu_device *adev, struct amdgpu_ring *ring, unsigned vmid)
+static void gfx_v8_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
+		struct amdgpu_ring *ring, unsigned vmid)
 {
 	u32 data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 0148d7ff34d99..e6187be27385a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5171,7 +5171,8 @@ static void gfx_v9_0_update_spm_vmid_internal(struct amdgpu_device *adev,
 		WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
 }
 
-static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, struct amdgpu_ring *ring, unsigned int vmid)
+static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
+		struct amdgpu_ring *ring, unsigned int vmid)
 {
 	amdgpu_gfx_off_ctrl(adev, false);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index c4c551ef6b874..44b07785bf9c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1455,7 +1455,7 @@ static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
 {
 	/* init spm vmid with 0xf */
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, NULL, 0xf);
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
 
 	return 0;
 }
@@ -1666,12 +1666,12 @@ static int gfx_v9_4_3_rlc_resume(struct amdgpu_device *adev)
 	return 0;
 }
 
-static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev, struct amdgpu_ring *ring,
-				       unsigned vmid)
+static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev,
+					      int inst, struct amdgpu_ring *ring, unsigned int vmid)
 {
 	u32 reg, pre_data, data;
 
-	reg = SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regRLC_SPM_MC_CNTL);
+	reg = SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regRLC_SPM_MC_CNTL);
 	if (amdgpu_sriov_is_pp_one_vf(adev) && !amdgpu_sriov_runtime(adev))
 		pre_data = RREG32_NO_KIQ(reg);
 	else
@@ -1682,9 +1682,9 @@ static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev, struct amdgpu
 
 	if (pre_data != data) {
 		if (amdgpu_sriov_is_pp_one_vf(adev) && !amdgpu_sriov_runtime(adev)) {
-			WREG32_SOC15_NO_KIQ(GC, GET_INST(GC, 0), regRLC_SPM_MC_CNTL, data);
+			WREG32_SOC15_NO_KIQ(GC, GET_INST(GC, inst), regRLC_SPM_MC_CNTL, data);
 		} else
-			WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_SPM_MC_CNTL, data);
+			WREG32_SOC15(GC, GET_INST(GC, inst), regRLC_SPM_MC_CNTL, data);
 	}
 }
 
-- 
2.51.0

