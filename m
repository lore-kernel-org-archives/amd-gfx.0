Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759A9C761A6
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Apr 2023 15:31:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9E4210E9F2;
	Wed,  5 Apr 2023 15:31:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09A7610E9EF
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Apr 2023 15:31:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+nLdU0BoIKl9yW6fPn7oiw87k/KLymmlkSouwjFyWFvum4c1nlrpuPLU7w143IDFsfchAG59C0CbpZF5mYsQKfTM2dkNT4k9xWWF8ElHaRZUadPqcTwLuF624DOcLgD5qmCQPGo75mzBg2qhvoBAE0aDG+7neP35lM3A1KMuGMDmcZrOyBTd/9fLM1xY1/enolRpDzve2W7KVkaU9VetVAQevVJzMGFRI22YQqPqPZC/GVBq5T/tMMYZSOadVs5zzwEbkRCkGOJa11+3yCSCJo5ASSjeQJY8zRyEK3I+ovJAiZoZP0hq1QDK3q/I0gkzmn+1chX8h8hZj2SYbRdbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/P4csponoHuNz/VOoa1anRsWyLkppLsV2nhe2jcCD4=;
 b=euP+y0FF6lc5VsbcX0fmo8luUVT9zTvABT8Y+05aoK/pXpofpIjuM/Uu/3gBkWVd5/eNE48M8Dz6JIox5ZTubJkPQZSB4RslbeS9cPPWZjkDQ0XE3Fk5bcAy+lvvU6PGNKbxzr89EmTxLFDUtGQybeTZ3RojPSz7oboV/p3U9Hxm600oMT6xaprK/j23MqDtZJLIPaRUFn8e+lWviHOGw06U3fq/7TujQXP4aSYlYoNZ4TqSUiWLfKs8rU4XUJd6zeVqQINUdP3ISxyCurNCs/VapUc5ZIe5Drme52QATUGeoigK2WpgxJf1d0Xdg6VE79WBAJGXgwLxvRdCeetbSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/P4csponoHuNz/VOoa1anRsWyLkppLsV2nhe2jcCD4=;
 b=Ynvsi3E9LcnVXTncJ6U+NspCCf5mfmSyRVpyORv1d1RKOviiF0UXN4AIzOKhCkI/ps3dq0oO1wziCJWNnjCLt4JM9kv5d/KWW0AaZ9cv3xNqabO/xmIAasRx4DGXhwihGCMk3RYZmZ0tF+SyWipbG75nOpqi7qlUBSS1mvORba8=
Received: from BN9PR03CA0497.namprd03.prod.outlook.com (2603:10b6:408:130::22)
 by CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Wed, 5 Apr
 2023 15:31:36 +0000
Received: from BN8NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::74) by BN9PR03CA0497.outlook.office365.com
 (2603:10b6:408:130::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Wed, 5 Apr 2023 15:31:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT087.mail.protection.outlook.com (10.13.177.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.30 via Frontend Transport; Wed, 5 Apr 2023 15:31:36 +0000
Received: from shane-u20.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 5 Apr
 2023 10:31:34 -0500
From: Shane Xiao <shane.xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <felix.kuehling@amd.com>,
 <christian.koenig@amd.com>, <Philip.Yang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Add userptr bo support for mGPUs when iommu
 is on
Date: Wed, 5 Apr 2023 23:31:19 +0800
Message-ID: <20230405153121.3324620-1-shane.xiao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT087:EE_|CY5PR12MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e4fcd6-a1f9-4c2c-f519-08db35ead81e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6LgJdySSTNZpp4A6y6lAF3B1zn6QdKPkJrAG6NAF+TMUE3DobKwvNfKn91auji8LONuhyn/3zcQNbfzDxmhEQ3HJPWLYI+3WAHkqsSys1pimNwxZYnbtqgW8mG0iGqS9tGN91VoFnZE7l0foSonqY2Z3lUD3gQz/DUpJw47/C8+9xZvR/33rox6kKkaQCvRKvbzS/akWvgw0CusHDb04g/A0iYcVujQmh4RfNCF7dTlHnNMEYFU4jJRpWtIx/MzMQqpR98ANl0iSrW/lnNAlhPucRpzsKNQvqu4gsg7eV4q3WY3GA/eCVqejBhQcxVnKubpGZu3Xny28Ssdqu0EnLLrs8lXDfUsV6v1grG1f3QPN6drL37uPMBEnkZ3psMNn1ovLlYE+NL57ykdrFjMgR5DbPmzW/83a6DOZKH/OaME0mvt5AQPeTYibSes1/ahE89REBsQgGIJo9M/s2+Fjc8USzH+EkOFhO2sr2kEr0N/L8OGpLLN2ra8wCKTCt48hM2An0JS/TgnkQ6eCFPEV3DtYzHqoxfjM5yqJcOlKqkZApf5Ya2f6ll1mAyQJuSB0VYRX1F6GStmOazc6ZOA+QNgNhSdGDqz3VO/HRcNCKle+JQkx23nLFhTvF4nZv48UhSjJ3AyBLbVcWWe+TDc/um5n4GrBcR4ICf0WDL2lSW0efM6sytWsz5nVt3fAR5FZB8Z+cL2KaufIgFKvIdcpa/8oHssfy2igAsITvqAqBw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(41300700001)(40460700003)(36860700001)(70206006)(8676002)(82740400003)(316002)(6636002)(4326008)(8936002)(478600001)(356005)(81166007)(110136005)(54906003)(5660300002)(70586007)(16526019)(426003)(83380400001)(186003)(7696005)(2616005)(47076005)(6666004)(26005)(1076003)(336012)(36756003)(82310400005)(2906002)(86362001)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 15:31:36.7115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e4fcd6-a1f9-4c2c-f519-08db35ead81e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153
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
Cc: Shane Xiao <shane.xiao@amd.com>, aaron.liu@amd.com, shikai.guo@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For userptr bo with iommu on, multiple GPUs use same system
memory dma mapping address when both adev and bo_adev are in
identity mode or in the same iommu group.

If RAM direct map to one GPU, other GPUs can share the original
BO in order to reduce dma address array usage when RAM can
direct map to these GPUs. However, we should explicit check
whether RAM can direct map to all these GPUs.

This patch fixes a potential issue that where RAM is
direct mapped on some but not all GPUs.

v2:
  1. Update comment
  2. Add helper function reuse_dmamap

Signed-off-by: Shane Xiao <shane.xiao@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 27 ++++++++++++++++---
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index e7403f8e4eba..2fbb9db64ad5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -81,6 +81,25 @@ static bool kfd_mem_is_attached(struct amdgpu_vm *avm,
 	return false;
 }
 
+/**
+ * reuse_dmamap() - Check whether adev can share the original
+ * userptr BO
+ *
+ * If both adev and bo_adev are in direct mapping or
+ * in the same iommu group, they can share the original BO.
+ *
+ * @adev: Device to which can or cannot share the original BO
+ * @bo_adev: Device to which allocated BO belongs to
+ *
+ * Return: returns true if adev can share original userptr BO,
+ * false otherwise.
+ */
+static bool reuse_dmamap(struct amdgpu_device *adev, struct amdgpu_device *bo_adev)
+{
+	return (adev->ram_is_direct_mapped && bo_adev->ram_is_direct_mapped) ||
+			(adev->dev->iommu_group == bo_adev->dev->iommu_group);
+}
+
 /* Set memory usage limits. Current, limits are
  *  System (TTM + userptr) memory - 15/16th System RAM
  *  TTM memory - 3/8th System RAM
@@ -804,11 +823,11 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 			 va + bo_size, vm);
 
 		if ((adev == bo_adev && !(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) ||
-		    (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) && adev->ram_is_direct_mapped) ||
-		    same_hive) {
+		    (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) && reuse_dmamap(adev, bo_adev)) ||
+			same_hive) {
 			/* Mappings on the local GPU, or VRAM mappings in the
-			 * local hive, or userptr mapping IOMMU direct map mode
-			 * share the original BO
+			 * local hive, or userptr mapping can reuse dma map
+			 * address space share the original BO
 			 */
 			attachment[i]->type = KFD_MEM_ATT_SHARED;
 			bo[i] = mem->bo;
-- 
2.25.1

