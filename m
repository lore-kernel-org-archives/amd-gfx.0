Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C11C7EE33
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 08:46:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC77710E536;
	Tue, 24 Jun 2025 08:46:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4Rzygn2W";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1BC610E35D
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 08:46:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFrV7hYQ2Dx0LPUmdkRGygkJOmzFDDpxH+EfeaKMerY9UW/Ns06YhCiotuhrmPu7E7RHkdqO1/mHVc/Hhw3DkuAL/V6M9BU3TWqNaAUcUDEhM/Yr8t9FTkndLlO3J59aAu8cN8OkEN/gaK/3ulEYf40NyZcIqEMJ43Xf4A3DAvMtHlxOw4wnCN2oTZOL7wltJwcM25vyxeStzWWHSejGY/3nuWVjoeomkFTyykR/4NCURpiYOC98dbMynTFRVoa2Wykfw0wRd/Q9nnDdECDsWJeY84E8ZNOzBo5D6NQUA2Q07h6UWF46ipt8hjIspJ/yGwyuPQx1LB3NtWVhBJyMog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkTEIgN47MxgTLRkuzo9/XccMTOQDYykGWdM+YnA7m8=;
 b=UFy4zAPvx5Bu7T8Onyin55u3S2zGZymdwaiF0p65fJ0aHl/ZKW9blabKZEuWdj5j8S0wkvux+bW0OCZXguG9RN42i0WDgtEXS2gofgmmbo9qjlIDGF022gj87WTEcz4eyj7QDmsJ1EVwYOQsmUCkO3lblNNsoFZGKhkPJ2hdPbBwKGshr7MAh/1+TlSCKsT/0nb9W5yNOb5/LG01gwQraHQlE4i8sy/CPE3+o7Ieoc71UoVSXQL+se/ly+DKDo9HVRrsXmz51UMllwvodRuj5W5n8BIcaWl69+XaUD2X7gw9k3b63rP7exsPvIDNYRszvmSF6MEe3OMDjn00vKDKYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkTEIgN47MxgTLRkuzo9/XccMTOQDYykGWdM+YnA7m8=;
 b=4Rzygn2WP7fVDpAseoXpHrQDZkD4NQTZA7P1Xw66ssuJLtjGy+hJ3w6vZmDkhjilPyp/pnfry4xPDa0zG1QBYFd+hYYNY6zyCTEInx80H/bmqpN1elYPcHVGnCwx70YR65F/l2HAQqyOpVRQwSOAA8sf0/NRU2rLK1VCJj2YGBA=
Received: from CY5PR20CA0028.namprd20.prod.outlook.com (2603:10b6:930:3::7) by
 DS4PR12MB9819.namprd12.prod.outlook.com (2603:10b6:8:2a0::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Tue, 24 Jun 2025 08:46:02 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:3:cafe::4) by CY5PR20CA0028.outlook.office365.com
 (2603:10b6:930:3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Tue,
 24 Jun 2025 08:46:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 08:46:01 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 03:46:00 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v4 10/11] drm/amdgpu: only bound the eviction fence to userq bo
Date: Tue, 24 Jun 2025 16:45:34 +0800
Message-ID: <20250624084535.1178476-10-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624084535.1178476-1-Prike.Liang@amd.com>
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|DS4PR12MB9819:EE_
X-MS-Office365-Filtering-Correlation-Id: f25315ab-7842-4d88-3e41-08ddb2fb8c76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jTMy6jb9kCgyFHKelgxX2MNA5uiQteumKPu8k+phi0h+DiEvXL2Y2WFxuYMB?=
 =?us-ascii?Q?XBTpFSUgPTTHJBpIg6gk3qesujirhsICP8QP1syVenCUQPqXC8v9WfJbBE7K?=
 =?us-ascii?Q?WwI3R2MFOxfYepXQz+nfy4am6ymn6loTb6k3V17HUTd7hPVfVMrXo4gi8qih?=
 =?us-ascii?Q?BKCM20KEy0ZxYHJLTt9949XPzsrLWhkvyC4AYmEtgIm56g2HqhihbaInyi9G?=
 =?us-ascii?Q?eZD3G1y946H4kJBrYceY+Vw6f+hTsBT3HTIqZ3N5v6PV1HHz2qQXN4QOjiZi?=
 =?us-ascii?Q?gvx065NxOYlxN+7A3BIDxTALNDwn8I4CDmkgdYhLRbZkfxUgkGWMWSnlbz2y?=
 =?us-ascii?Q?s9d8NZUFFkz3sMaBF0sXPPUattR3cgqqclog9EFtHHcdWIsIcDSeAuQyHnWR?=
 =?us-ascii?Q?bzKPpv40H3W8peHEurAtxuLiK170fz94gmLGIlVnVUB2xeVzbZKGO1HREnOy?=
 =?us-ascii?Q?gouoGUBy6/ZuDoKje0gTKkD9xq1KTbvqFf5I73HM6eqpProRUV7YjNbuL/Bi?=
 =?us-ascii?Q?vwleXJFL3dtQOFzdz0UmZQbMwpHUs72x7M0hv/UAPCQnL2ZmarKR391J46zr?=
 =?us-ascii?Q?C6ENdb/kOnePJVf9a1iubJIHlct3WQkXbPxWx2EvzH/DEgEPk0lDskJuJRnW?=
 =?us-ascii?Q?uCVY22yIO5SrX31fKQBkBgKAkkZe930xFJfMXPLi7DeLI/gH3CPPdn/OTDO3?=
 =?us-ascii?Q?EHGjy2U6yD6lYaLuL5uvrBb+LEsGfDpQF14dwNTMOJ55+TistjtUm2EU4Qi/?=
 =?us-ascii?Q?bSUL65fSMFf2xepp5pXAdMDdxStJ9jCUzhEhUHafFSJ+uGUu5jbwo9f5Pyd4?=
 =?us-ascii?Q?gxLecIjxz0TN8mIggRBMPSIHYP4fkx87fDeV/Ub8znwBj2kJuyH8/NaenfzH?=
 =?us-ascii?Q?mSTNVjNAUM1RUXl7bGDAIekuJggfGLZUZ3vrbkF2WR+ii+OR/8BwXnnCX/Rr?=
 =?us-ascii?Q?o3otDkaR9r9I2wKRrAeSYrjAtune8TdRHj68q7DUQFpDj8z9FpsZ3b7Z8/rH?=
 =?us-ascii?Q?w7CcIUmkU4/baCCXcUfbyntE0TFjy4nndr/sjU2PRR+RtJHVGivkrrNdBcIT?=
 =?us-ascii?Q?eEyXoTwce8dAdopz/NhRoxCXFJb2Tm+rghPchv9zL4OPYWkAkyO/0gCig1Ov?=
 =?us-ascii?Q?xKB3HE+QI+RDClhCdXOITd3Jnc71VQd0WudLRe1gMQoJcH0JQfR26onl7Hfu?=
 =?us-ascii?Q?+ozFNSVHaimWJd+vf7DT8SUcNYYEHLX9SSsaIT4+EJGCNIY+FgLGrNcOJzfm?=
 =?us-ascii?Q?nL+wD8e4+zu/zVHoIvmXPHSDU3VJuOOi8YF1mtdw+KmqBAFbpoW3LGH4TIoP?=
 =?us-ascii?Q?S/WWjyncmO3exqwHW95H+2dQ4cSxRlXxWeBQ3j/UTi4ed1eDAVs7fW7t8MW4?=
 =?us-ascii?Q?DZVbHSxEOlLn0OJp5hlKVrVIUSY7jX4uZgKRBPlOu51waib/ltWuSCnVUpkC?=
 =?us-ascii?Q?z6+R8Q7G4GqSKTqmJ2y7OIlS1purQyXeY0k+CcglSfaOil9uDdJlTTgqWRFJ?=
 =?us-ascii?Q?6G6AwPNWf+rjIsDpN4OaTkkFYuJGamINGLrm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 08:46:01.8704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f25315ab-7842-4d88-3e41-08ddb2fb8c76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9819
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

It doesn't need to attach the invalid eviction fence
to non-userq's BOs.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 2c68118fe9fd..50356aa23a99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -294,12 +294,14 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 	else
 		++bo_va->ref_count;
 
-	/* attach gfx eviction fence */
-	r = amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
-	if (r) {
-		DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
-		amdgpu_bo_unreserve(abo);
-		return r;
+	/* attach gfx eviction fence when userq created*/
+	if (vm->is_userq_context) {
+		r = amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
+		if (r) {
+			DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
+			amdgpu_bo_unreserve(abo);
+			return r;
+		}
 	}
 
 	amdgpu_bo_unreserve(abo);
@@ -365,7 +367,7 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 			goto out_unlock;
 	}
 
-	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
+	if (!amdgpu_vm_is_bo_always_valid(vm, bo) && vm->is_compute_context)
 		amdgpu_eviction_fence_detach(&fpriv->evf_mgr, bo);
 
 	bo_va = amdgpu_vm_bo_find(vm, bo);
-- 
2.34.1

