Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54446C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 07:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC12E10E316;
	Thu, 27 Jan 2022 07:04:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B0F710E316
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 07:04:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuVTYOufGyL1bw2uU2palY4AIJJkq7SwcWzlkodOnpBeEwaBoqnIqrfJ4sFX6oLbK6BFAc6O8DVkreQjmsLDyKp/zSiwWyijCHMoZr/sxxuFB8moVntVpHje/wLf7fYI8FPQsFhua90p8e/x2JpLPP+U1OMbe9YBVAIgX67RoCZRn/QuPhogs3GNqSPaOcIhKdEew2Nd2/PpOoMLmqUJh+b4J39R7fcWx6gbdxl95J1JtvvLd4IUREE/O1ixkrwoeTplP+KerXHPEbEkwl9D0jEvBftRnN+Yuxax49dK3pf/KnQfPppt2cBQLM5UgPLKYI7HFzhpmI8wStQ8gpLkBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rfMP80GRH+eJDZLRsdLQdVpfxtGJ0rOoG7/KFNBSwE=;
 b=CCG98UlUHudeOPHcv53pe79i9yEiMLcJNCBTpte7PgsyzDQjz/Jltptxiv0g8sA/l220upzLwrRCak8iEaWu857xmmzTI7FpzKBDzxE1TeH7k/Vw7s5Ct91iE/TbqEn+VKBEp4yt3lFh2KR8JYfDTkp9Q7Yo/hXnGmsVYQzNQBSdjx38TWM04SwmXi7wsh/Qq8evBmlYrfOyrG2l2ip++NvHgi49YqQSKrhmrH9ubZ4+T1cglZqWr5xR9ScvwAS1ZhoEXnbRnw+M43FPN6Fgl+tvIRbm/ORlG2XYoGHnUMyZFHA1lKgn5c6yfJCrX0OBaGKx8rKQHGRfUGnvjPvoRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rfMP80GRH+eJDZLRsdLQdVpfxtGJ0rOoG7/KFNBSwE=;
 b=WXLsJPb8ow6y8op7S9ywMSWXYlEkayWDmabLvC4/sHKTs2NWeolTOMaelSalfkWgFxJHUdTOWmge/5Ux+XhyDTHygzejLrr/s65oVJIEJCLwa+5e6XKIH9HftJ/Go1SSwN/pvvHFlNxOshP8wgnoVYpurifH+pEwXRrlwxoA+bw=
Received: from MW4PR03CA0330.namprd03.prod.outlook.com (2603:10b6:303:dd::35)
 by BN6PR1201MB0178.namprd12.prod.outlook.com (2603:10b6:405:55::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 07:04:20 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::ad) by MW4PR03CA0330.outlook.office365.com
 (2603:10b6:303:dd::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Thu, 27 Jan 2022 07:04:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 07:04:19 +0000
Received: from aaliu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 01:04:16 -0600
From: Aaron Liu <aaron.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: move GTT allocation from gmc_sw_init to
 gmc_hw_init
Date: Thu, 27 Jan 2022 15:04:03 +0800
Message-ID: <20220127070403.3029564-1-aaron.liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 693a636f-cfbb-4c01-322a-08d9e1633d73
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0178:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB017800D214D1BE2452497229F0219@BN6PR1201MB0178.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 26zDeVWYtIYdxow1C9W6VZm7kFtybRVK2xBHeA9/SQY+GSec95urVqNCgcOtyS3L4pckYYTvQpEcjrluUoWG76e8CJAT0AxCfUopRVozBgZq14ghli54d9vQBf++zdB2G17zMSarrR2Y1/yFzqDe2V4F8noTk1xxfXf1rLz9f1+VcV6T58ZQTc4CG66tRezd66iCG83o62KCCsCclKdBvmVHfn4GGHZnUjO68IG6Nl8+ieVuk3JpuRv2F+qUD5Pj+5EYzaX69JhP/ssVhLcpAtJHQA+Cs0hth/oE3Ju7HrgxPxsi52TxIH0GYguj4ux9phLVXJyvVD1fZZj7jRO7BCQzoXujAnGV6bOhSPqV06LlvcETH4AajdRAiCqJ930i+YxymAa0CTe5UwwvbYXDOGjDOkQH4OohGrz8rIgbytDnlsPutiNprQRf2LYQS+T7IfIvBeZ0iFhw2DB73Jo347fnrZwj+jk0jssh1G11YzFlJ5tbaK8CQ/bIZse58GZfHigy1P+iTbQayxYWjTpVnW6oXNeWn4rpI/uyNTYcw+n7aJHz7MrcL6gw9rYdVFdmepaIYXp2WVHeG0bBzo/7/jxmHYcPnbt1Yw0gVwiw8JTdp1pjo/29ud73K3Lfnp+yETSG/X9SL2FMjCpNSYHLM5kd92l7xs4iyDtLH/oS6egrVsvfGCu/rXW1/dhU3Y36umO1LzEZNNGsDZo2SguERw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6666004)(36756003)(40460700003)(36860700001)(54906003)(16526019)(2906002)(186003)(26005)(1076003)(2616005)(6916009)(316002)(508600001)(7696005)(4326008)(8936002)(86362001)(83380400001)(82310400004)(336012)(426003)(70206006)(70586007)(8676002)(47076005)(81166007)(5660300002)(44832011)(356005)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 07:04:19.6732 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 693a636f-cfbb-4c01-322a-08d9e1633d73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0178
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
Cc: ruili.ji@amd.com, jonathan.kim@amd.com, felix.kuehling@amd.com,
 Aaron Liu <aaron.liu@amd.com>, Ray.Huang@amd.com, Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The below patch causes system hang for harvested ASICs.
d015e9861e55 drm/amdgpu: improve debug VRAM access performance using sdma

The root cause is that GTT buffer should be allocated after GC SA harvest
programming completed.

For harvested AISC, the GC SA harvest process(see utcl2_harvest) is
programmed in gmc_v10_0_hw_init function. This is a hardware programming.
Therefore should be located in hw init. Hence need to move GTT allocation
from gmc_v10_0_sw_init to gmc_v10_0_hw_init.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 --------
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 9 +++++++++
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 3d8a20956b74..7ce0478b2908 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1823,12 +1823,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
-	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
-				AMDGPU_GEM_DOMAIN_GTT,
-				&adev->mman.sdma_access_bo, NULL,
-				&adev->mman.sdma_access_ptr))
-		DRM_WARN("Debug VRAM access will use slowpath MM access\n");
-
 	return 0;
 }
 
@@ -1850,8 +1844,6 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	if (adev->mman.stolen_reserved_size)
 		amdgpu_bo_free_kernel(&adev->mman.stolen_reserved_memory,
 				      NULL, NULL);
-	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
-					&adev->mman.sdma_access_ptr);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 73ab0eebe4e2..c560bdc2a93c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1062,6 +1062,12 @@ static int gmc_v10_0_hw_init(void *handle)
 	if (adev->umc.funcs && adev->umc.funcs->init_registers)
 		adev->umc.funcs->init_registers(adev);
 
+	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
+				AMDGPU_GEM_DOMAIN_GTT,
+				&adev->mman.sdma_access_bo, NULL,
+				&adev->mman.sdma_access_ptr))
+		DRM_WARN("Debug VRAM access will use slowpath MM access\n");
+
 	return 0;
 }
 
@@ -1082,6 +1088,9 @@ static int gmc_v10_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
+					&adev->mman.sdma_access_ptr);
+
 	gmc_v10_0_gart_disable(adev);
 
 	if (amdgpu_sriov_vf(adev)) {
-- 
2.25.1

