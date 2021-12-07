Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E6DC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 15:31:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1927FEBCBF;
	Tue,  7 Dec 2021 15:31:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73F98EBCBF
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 15:31:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLqKCwZGfvO2EERmiqWWQO2s7oVYZVwuSBsCWCohkQo/081NrFCXlfr8aR+f/Pz94VFMLZ4HL1X8wloVtZsJjZrCP8WfViHX01AzUPIUbQ91uQC+4M4VQaZbWs4r9Vo+lUICa5AK1USolnxh9YEtGAYDRaoV3ZEH9dQxtTNrlZq/+R6r8XAN7FRtTu+TOeQUiDYc0J+gT2BeXbnhYbiP621mcwxP32hZWmzdPsi5/W8lfwJSKd4BZq7WwIjTjCjgb4ZJtS3UeIPd81wQZ3K6tk8thO2pD4lLvZFgYDdTyGJLWbMifhXlt+IJBhOwkxnKUC3z3dhaHhC57xl9H44Mbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNiHSFsNx9bYxgNBpE74m/vzoC+1SgqZsJGblWnvxIY=;
 b=WXcYdzaIuDApdOK4V0bYP6+njK/wG8QdCNkqy9AGNREgFyc1xhNxfQcdHqcOW+u1rtlFgC4bMURnP38UiPNODP0m+H5iBI3T2zLLCBiqqGfd44fB7t8Axbtk3jeqmVmgnqVJDL2ZqQEmyPhRqNzffGehDiOkNMo8pqsYRRCMQ8wkI70IoXKME7Y34PGVBzgNwA1GD+YfIP+tTEyEe+HV6yLGgkEm0zbuzp4VZB4WKLmcgObl/rRo6WT+1w/QYH5pD8bS2YjlY8tih/ib2umcp2DSa1TfNrxBvPK6VLWASdA0tGxYhAgEeLTOYuj3QlXDtTgiS1cavohY0lfeBwOM5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNiHSFsNx9bYxgNBpE74m/vzoC+1SgqZsJGblWnvxIY=;
 b=ZtKzokL8csTg0cTGyKj0u93vPjr6TB2ilR5wgX+GLMjqCyn0pLFu5VMEvCksYkOSUftdF52+7DgYXblJNQGBlpQKBZtzunHTeoiiFp5m4y18M4rCZyQ66Qh1yz2JOhRbl+yWbxbXXbaS4MJV4AOl1zt7tbJzJGsqUuAM9pfyy4g=
Received: from BN9P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::8)
 by MN2PR12MB3037.namprd12.prod.outlook.com (2603:10b6:208:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 14:59:45 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::57) by BN9P221CA0017.outlook.office365.com
 (2603:10b6:408:10a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14 via Frontend
 Transport; Tue, 7 Dec 2021 14:59:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Tue, 7 Dec 2021 14:59:45 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 08:59:26 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Reduce SG bo memory usage for mGPUs
Date: Tue, 7 Dec 2021 09:59:11 -0500
Message-ID: <20211207145911.2690-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211207145911.2690-1-Philip.Yang@amd.com>
References: <20211207145911.2690-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffac83a6-6710-43ee-1629-08d9b99234b9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3037:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB30377C6235735D072554A467E66E9@MN2PR12MB3037.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +2coLiXgGNSu2blHUmkbFiLKazV+3hlnZYH8A0zdAzGe1lR/sQRx78pGghdiBUvT01OrDIIyvQuF+zG6mAREcO6vfY9rsc68JPga4Vf3gvVKsWvme9B9IKZG83y9ry1w0M3utX2IJS0ajMRYCznSkH+CwrPWaCM1yMvLxU7ZC7XHO1TTW4Iq0yUKuKOtnZgP3TWQWvyBoYq+n7+mSdtWpQVnBEo+jN3XH1A2/xiSbrNuQiTzlW7MJrcM/fQ3GztUoTlmC0aGZj6JzNB0QkIugey92ISm6I7gUCSVIHK96OF60OOVLzLg3EKqsjswVlPY9yS5jckYnujub20vitPQby9VQmLeYslGUwZKVFlVaifbEoo9oV7letjxj6L4d6D1zjBMXy1Qa37ewjT7i5Y8nh8fK86Zzr49yxetRIuPsBghGFjGXGm/SF6pVRmldazwv5DrL4HAzefn2CFYJVc9rEh1jPw8UW3gQlmUh5M0D38mgcOeryxzSLtL1OAKqP5Z9qnjMVXtfROYBa7vW+2wqeAVCEpQqCVlXJuiuRdVfPMZ0zdru5eERTjgh3zv8ak4Eu7xzSGEx5PyuUMiLiWDYCeFd3rdyXN/O24MKNK7MFX/5n2GYW5uYckI/i7PO/FN44lfxqVaZr2G61daZfU1QZx35EV2kxbXbKUavtcb9tKEXg/qOTRtDJw7//1sud2pdJu5H95oYDYHYrVkHF+OrXbMrtT6FordXGO6xsVlUFM0uGnXO3yTuAGQehIMgsBQIvhdU9ZTNDpkfVs3uXW5uEjd6UIlIGKEjs0ZmhENXDA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(26005)(36756003)(47076005)(186003)(16526019)(8936002)(40460700001)(2906002)(82310400004)(426003)(336012)(2616005)(8676002)(356005)(81166007)(7696005)(83380400001)(316002)(54906003)(6916009)(70206006)(86362001)(70586007)(1076003)(5660300002)(36860700001)(4326008)(6666004)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 14:59:45.0075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffac83a6-6710-43ee-1629-08d9b99234b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3037
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For userptr bo, if adev is not in IOMMU isolation mode, multiple GPUs
use same system memory page dma mapping address, they can share the
original mem->bo in attachment to reduce dma address array memory usage.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index b8490789eef4..03807ed1f6e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -708,10 +708,14 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 		pr_debug("\t add VA 0x%llx - 0x%llx to vm %p\n", va,
 			 va + bo_size, vm);
 
-		if (adev == bo_adev || (mem->domain == AMDGPU_GEM_DOMAIN_VRAM &&
-					amdgpu_xgmi_same_hive(adev, bo_adev))) {
-			/* Mappings on the local GPU and VRAM mappings in the
-			 * local hive share the original BO
+		if (adev == bo_adev ||
+		    (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) &&
+		     !adev->iommu_isolation) ||
+		    (mem->domain == AMDGPU_GEM_DOMAIN_VRAM &&
+		     amdgpu_xgmi_same_hive(adev, bo_adev))) {
+			/* Mappings on the local GPU, or VRAM mappings in the
+			 * local hive, or userptr mapping IOMMU is not isolation
+			 * mode share the original BO
 			 */
 			attachment[i]->type = KFD_MEM_ATT_SHARED;
 			bo[i] = mem->bo;
-- 
2.17.1

