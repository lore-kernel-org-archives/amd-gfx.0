Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CC6C0219E
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 06:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C227D10E14F;
	Tue, 11 Feb 2025 06:11:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VhhRPQxg";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92F8810E106
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 06:11:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2AwQ0AxyrULSpw+RVm0ZqQEtt2xgPw5jjfH6PoIJL56Q0QFaxhxvBj6SPhNiE59C4wW7vtjss3L49BhrTr8NrCWmi90rRGPla3vGYIuOE5ok19ZrysBeKwtnac/Iq+4y0gRDihoTnrKqiipWMelYPHtguoNovfsKR0LgfNsM3bRmrmgJBbDNhD2vjoZbdPJ49si5Q3eqbyziIGsidkxnJEV44aI8+zIjojt9JgL3OOKw4YO6Rq+VTxphNBtE+hexpje1LzhAoEiTNak90OMhHaL9H0AFNFE59DHsWifZx98AdJwwdqG8AO8V1f741UZHQARFh7xyZYzLHGPoVL3NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkGkM4V3gs1iOqK9Wy2486k5PQz777thWOxQCU7HQWY=;
 b=oG4CqtB6xqWQeXb1QMpfDvLIMIa9sywDBqaKf3NBxLQANS3/rRFlu3zcGC0JAymdNZQh0GyZODifvfMV40Y0tUbF5gxzIku7rxk6V44Y7JnlGnYctHCNIBKT2ZBXQOHRl5y3rLpovy+yBRJKgKei/Zz8WcCgr7YrR5ObdcJ8iNmp5l7Zd9v/Lj4myTeeDFE66bV91UPZjJK4v9p9qS8JUJiqDe1tComH8MsBcpGT9tL8ZuMao9jIT/5cCOl16u5Gx4waUq2FgfH1W7WETr/dtGQtdaMyB/dJXhokH5/LSNheu4FFeueHAaFV0NZPymwkh1AooPpL66zHAqn7tshkLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkGkM4V3gs1iOqK9Wy2486k5PQz777thWOxQCU7HQWY=;
 b=VhhRPQxgMogEvTuSVpRzhaPJY+aHxyuYCtxKMkmjtD0tjqJFb5bQjJw9rE7lisx+uT+pxj/atWf1pHFJpZ78dHQi7LzM4H1yPMBNLg69fsHSiT9Mua+LYiufpCS8oDbgMJmXxgVrhDmin8vxmZl14igsJK1sq/TiI7pxDnNX16c=
Received: from SJ0PR05CA0193.namprd05.prod.outlook.com (2603:10b6:a03:330::18)
 by PH7PR12MB6786.namprd12.prod.outlook.com (2603:10b6:510:1ac::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 06:10:58 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::94) by SJ0PR05CA0193.outlook.office365.com
 (2603:10b6:a03:330::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.9 via Frontend Transport; Tue,
 11 Feb 2025 06:10:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 06:10:56 +0000
Received: from arun-nv33.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 00:10:54 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH] drm/amdgpu: Modify the seq64 VM cache policy
Date: Tue, 11 Feb 2025 11:40:29 +0530
Message-ID: <20250211061029.3505-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|PH7PR12MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 3383d1ac-2b3b-4172-9c93-08dd4a62d942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?96ziKe/JPvKNK6eLwRbzcrjmJDCoGIa7pdXXZXowM+kLYJzGCA6cwqMGK+q4?=
 =?us-ascii?Q?TPcJ61+0zHwGohJomIxHsHvaDdkO2yOSurz6Ayqy3+1F1OTOBiSulYFOJNVN?=
 =?us-ascii?Q?uuoV0f73RnTDO8QmHniymtwYIvNkBKwC36THWI3YzVUqj79s6RY5iSEZ4FKt?=
 =?us-ascii?Q?g6zqMAQljLJa8NufJ+3V2Deql6h9gswdOfbNkrHmVMfrXFrEmxytuJl4UKOw?=
 =?us-ascii?Q?mpy1JLMJ/sAvpScQbTdn0KK1ILx5HGe5H8HZ0q/gL/LRe1ApYWSHi3zBVv8J?=
 =?us-ascii?Q?6aWlFJOOmt/Ob8hCaav/7CAeMsWlNScuzQy0JOnVFfEXbYH6UY04jP6u4RzH?=
 =?us-ascii?Q?gys1gs6Qg1ZX/TAp4CznssOxhcGl7eDgE6W7tD6xm7UbsAw92mXxD5BfgVXv?=
 =?us-ascii?Q?c2vBzBemXqyz7QH4ZzQa7nCLwUnuKLIEMstyybMVPtrNWZtfyKVBD4AlGlEj?=
 =?us-ascii?Q?/DDoWmjzwN5wE6VJ0vB6inwLHoCQihLpB7ImnWuhprQvawUFTx8hnAftmQFc?=
 =?us-ascii?Q?4j/Gs8RRhIvu2VSoQRIwjfAnqN+NXCykvwMyO7TfkQDcNfQeHwpy46eDZDIQ?=
 =?us-ascii?Q?1nYB0rF88BCZbAVkLdRBZeGJrmZjWdseW7i+SQ/BFN1ZjHf4BA0DrYfPjrz4?=
 =?us-ascii?Q?H0vyAj5Ej8VVA+ubSc8MNA3UOVeVlj/k7PTqN0Shal+6Vhp8jLC3BKk143Pp?=
 =?us-ascii?Q?loSmlzLuQGs0Uy483eJkcwGTcjDd3jQrCY4B9QG0ipn8J8UxT3prjvuMvTbQ?=
 =?us-ascii?Q?PJk6vcFliy826vuK3COz/oA4X7cxsVsubJkN791FOmm6mQWeqOsX83+d41PD?=
 =?us-ascii?Q?Uoxi4raAKGTGMm2nWWbjN0xAC0a/h0HnO6cANlktTOZ70Rlls43zW2M9Udio?=
 =?us-ascii?Q?RMsLzSfLMj5AxOrAST3/V//Xax6WgFfwPojFEHq6/90sUXoLllhVhJDXyYBz?=
 =?us-ascii?Q?tkbC3ckKB30Xx3dvOQcepomwCHbhrQPbfsuJ2uUn6kRGr2URf3iqYJ3c+s/1?=
 =?us-ascii?Q?BTDAxv2iEKAfbGWgM1OoLe5DV+ynrBcB/JPa4pIAczBsZ1vv+qIx3Iu2nhA7?=
 =?us-ascii?Q?FXtZCDkjR4JtMOGrLjZ81SC32qO5+Qp9mw4Vcer3coZFwlVeFwMqq5TRxmhS?=
 =?us-ascii?Q?YR52mRkh04AJRK6oOCTnle9NvOwoSfKLRXfRL6pA5Eslkh3Ff9+E+RF3OVmm?=
 =?us-ascii?Q?tgEuR92WWpmWoe0yD8kcuq2L+rkNoWqT7NbcrE7X2EWOxTBQM9QTPsGv05Bp?=
 =?us-ascii?Q?fgxV3Sx3hTP+IQJTYdrYKccyI4sok8m6BsU7//0da4v6CvvzSXu99MchR9+L?=
 =?us-ascii?Q?/RIj4c6ZKeHv4/4HD1y6AqKkjXLCkPJwq24z3wY7csA4Z6Bo7rj6YoOeCVJI?=
 =?us-ascii?Q?pQ5avgvFK/Vr3X2dnATOxLOIqo6OYEaIH1q700tlbK+OHKJGN+mMoRjPL1IL?=
 =?us-ascii?Q?qrCfxiWi1OeC8zKCygzjorfCqKOrTKV1q8em5pnShtPyxg/feexKmhRu5Psf?=
 =?us-ascii?Q?k4ULIPiv+6Gh0tY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 06:10:56.7187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3383d1ac-2b3b-4172-9c93-08dd4a62d942
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6786
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

The seq64 VM cache policy should be set to UC (Uncached) to
match with userqueue fence address kernel mapped memory's
cache settings.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
index 2de1a844282e..3939761be31c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -67,9 +67,9 @@ static inline u64 amdgpu_seq64_get_va_base(struct amdgpu_device *adev)
 int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     struct amdgpu_bo_va **bo_va)
 {
+	u64 seq64_addr, va_flags;
 	struct amdgpu_bo *bo;
 	struct drm_exec exec;
-	u64 seq64_addr;
 	int r;
 
 	bo = adev->seq64.sbo;
@@ -93,8 +93,10 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}
 
 	seq64_addr = amdgpu_seq64_get_va_base(adev) & AMDGPU_GMC_HOLE_MASK;
+
+	va_flags = amdgpu_gem_va_map_flags(adev, AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_MTYPE_UC);
 	r = amdgpu_vm_bo_map(adev, *bo_va, seq64_addr, 0, AMDGPU_VA_RESERVED_SEQ64_SIZE,
-			     AMDGPU_PTE_READABLE);
+			     va_flags);
 	if (r) {
 		DRM_ERROR("failed to do bo_map on userq sem, err=%d\n", r);
 		amdgpu_vm_bo_del(adev, *bo_va);
-- 
2.34.1

