Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7B1D58B13
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Mar 2026 07:13:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C92DA10E4EA;
	Sun, 15 Mar 2026 07:13:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UmaQ7T4N";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012046.outbound.protection.outlook.com [52.101.53.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24CC510E4EA
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Mar 2026 07:13:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=coh/1qrIDPiUj7mq47sUZnWOGvWQAluBwcRiPZ1xnX/hRok4SBlGmiorlH+2brknUgHODvGx7hdii7n5R74ZMDNDFw88rEgtSMIs2go7ZVwXlzZcB0Vi8xFNbn9E+4RayVI2Iat2/Nm4L3WBQD+euw4j/gSveLygcUdyoeBsgez1JJ6qB2TLOKBWkAgZFfnzFQb2vb0IVkd3YpQXkeYKpsp46hoXvexk/Wo0y/DFfzj1Mwuozic2fPmy1dV3Ssz5EW7GZkGuOTvOxaLEnF0ngXXf98EhkFkhKHeM7fOSStxB1C4KdM0hgU6rIbOxMhTrmkkFLxKgGxj4RjTfSQ8yjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1Jld+A9fRLTT9mX12MwpocBiw72OTKSLvi9FIqKAnM=;
 b=ODUP4pHTBBDllwsPYOwzdVHsqSNtxH/+zcnTiybxPxZGelyXBSAxVPscYasgP3kUJv3jg6holptkjTkhT71ohSeYJfrzPJ6sh7OqkOcsS3YV6uWkSbgkjRdcnNtOgGm+eIVpi3t72dg9LYclx2KTzSKF5PN2yWyvH+BzwPEQvrlf6G0+OXIYA7DLvsl51gPvx2ZEMF31xMOmiTrOtA7Fq39EXi96rJIeie93vh36xPHvxBVRt965JzAROi9NmTtZ+ucqTxLpWz9W6WRLL8xg6Q6GnujSvJZfATtDjyDRFW+AxKsMc8ItG0aeQyYn15wt2Amtj2ngcp7ApFy7UFE2wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1Jld+A9fRLTT9mX12MwpocBiw72OTKSLvi9FIqKAnM=;
 b=UmaQ7T4NXGgfL7GQTsLvMdKjer/XlvAj+PC0rZFmHPAccZt9d/7lIh9JfiPKGjFc+yMZQpKJhJ7DrNvkeFH5Mv0KWW7F7kwGZx5F+gXCcaFXR2puaXiK8fjfhj6px5uhLYmC+RuiFW4Yt8BInDN56eCyhHPr+35LZ2oPBtOHGaM=
Received: from SJ0PR13CA0068.namprd13.prod.outlook.com (2603:10b6:a03:2c4::13)
 by CH1PR12MB9693.namprd12.prod.outlook.com (2603:10b6:610:2b0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.12; Sun, 15 Mar
 2026 07:13:48 +0000
Received: from CO1PEPF00012E81.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::42) by SJ0PR13CA0068.outlook.office365.com
 (2603:10b6:a03:2c4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.21 via Frontend Transport; Sun,
 15 Mar 2026 07:13:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E81.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Sun, 15 Mar 2026 07:13:47 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 15 Mar 2026 02:13:42 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>, "Dan
 Carpenter" <dan.carpenter@linaro.org>
Subject: [PATCH] drm/amdgpu: Drop redundant queue NULL check in hang detect
 worker
Date: Sun, 15 Mar 2026 12:43:24 +0530
Message-ID: <20260315071324.1933271-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E81:EE_|CH1PR12MB9693:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b44faad-b0e9-476d-677a-08de826266b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: n2n+NCvs1/90ePXFxxhFCGMXMUSa3MgxJ2OROeDSTZViurtM6H7qJkuu4wYJLqKdja67sztPPUWPdeR7oULGeDyP6nby/SFxhYZ17kMHvP3SjsQfqNcgJTfU96tlyIM6yOq1nuqmvMzI21pVlczB2wVwc1elGuTFXEu27cCIPVHL/ft6Koo48D3aist04FSrUyTxHBquFews8GcnJpEGp1nOcOlVHP5n+FOCgwgBcKFmdPeShgBpPIbRazRgUDV8ZURxIit8RDyEz9Ml4+AU9PJ6J+fqVy9YY7x5Cmctpyx9zFunfORgV85hQTx09CqJT1Xa6cBgpC7irnaUpBTORKqL0Y2u9uSylJ2yf15j57Wx16eTZszYlwVhHxMHWyeVaZg13R1bZZ1FAMysjSJiOj4mSSciYbq61doUoEtEAdfsEolHWenwr38VkcoQusJZQae49uXENptSTGnYTiHgdcb0/D7QqYVasrw8/wpAg17xYA7Wgai3DfJ/Y4PXmjvOzpT/wrOavJdXjeABhOiX6TyxtXhlBovi4UJivovrBC6O+BLeeMRBUSkozvVkwOCsqHeyyZfFxLK2mYGETTno064FM2khSjaK/MNCumjg8uIsFGca1r88O/lVwieL4r4Uj9PJJZs2xscMjI8USiB3ur6ztGcNyEtWcIQZhJfGnUrgN7mD3H0yII3Z/RupFTPV1pKT+Md3VEZaIk/OzoaTj8rcLpbtUci+VxgyBWLlT/hMjnLjBu/MRHniGUWwWgkax1xtqLR+Lzn6cKxCQYqc6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xNfcTl0mwvFtZSG6Qm7DYMirSLGN7dQ/DgN6CXC1MawIZhsc6lqJBHNZ2kOBp2f/HqxtOmAyxqh0BPw+hubE/WmM5v670WxhE5Chic3NC8Lh4sWa1FNI+3X+JTQsyWYOPGrClqiRrO9D0Ag8dD0oUJiVZSwAuyu4oqXUSGg8TjB2xpnz3I/o3nGhfEqmR+tqoUbYp0jvV2f7mclioFWTveOJEGPHPBQukP5xTYRwS56bUyb3hrUtpIy2SUkN/KZ7eENoliG0/KC6NLNRGRSAEt87jhBwhFosePOT/YbrjUx46kE633w/AksxFrwYbCLnByU34aaatniKW02Xa+/WIC7EG91+ymJvJL1Lh3klQ8fyjgVV5DEAu+ptRM4Sr7Vl3WkZ8a0QdcGc+yeCA+bWhnOJRbqWDOfJ7UEv95dEn0bR4Y/RTvLGJogiCEVAloSw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 07:13:47.3687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b44faad-b0e9-476d-677a-08de826266b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E81.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9693
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

amdgpu_userq_hang_detect_work() retrieves the queue pointer using
container_of() from the embedded work item.

Since the work structure is part of struct amdgpu_usermode_queue,
the returned queue pointer cannot be NULL in normal execution.

Remove the redundant !queue check and keep the validation for
queue->userq_mgr.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c:159 amdgpu_userq_hang_detect_work() warn: can 'queue' even be NULL?

Fixes: 290f46cf5726 ("drm/amdgpu: Implement user queue reset functionality")
Cc: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index cd599b4a9d75..6e0c366f3f00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -156,7 +156,7 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 	struct dma_fence *fence;
 	struct amdgpu_userq_mgr *uq_mgr;
 
-	if (!queue || !queue->userq_mgr)
+	if (!queue->userq_mgr)
 		return;
 
 	uq_mgr = queue->userq_mgr;
-- 
2.34.1

