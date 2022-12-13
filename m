Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BEC7C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Dec 2022 15:50:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A58C510E0CB;
	Tue, 13 Dec 2022 15:50:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9004C10E0CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Dec 2022 15:50:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAFwNXF48CjI+gi4tibp8e07ozml0Z1XNcvYTI7/YboLUqmcb9k4/MNGX8DXEvCzXmGY/oRxzQvttoJvcV1srNAhgfCONnuB9tmT3BIMOFthxDKgTgKsCpssYHxpC6boNyLDcEZH2yAiYTchoOlZ+PDpVkCvk7JsfIitVb3xpps7tEYgTVf/I6yLaefTqVAm7uv4hyorqBgFtLvyZFi+TpDUGVpB7REauqDngb0fy/UhU33ZV2svmLGNJYNgoAJGK5TlJJx5d9qCli6LLBuvPS3AAihjpt1Fa7el2p0Y8oVXjbv/W0CnOYTXrBl6U5nMgRyltpg/QR1YLzgci52itA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9q0gTzFLCu46f7/+pGqLQK2AfJzPhVzJPdfQe1O7oc=;
 b=hnoJ3rzLGRUKScxf/ESJ8sgppINcLbeCenwGltBU/C00oyhGnyBzUtgdNCVCDT0DwXbtRMKIUKoXVRRgcvCkAKpHb7nzO32mSQuJq/ppMSPR8DEYCr75k+VsVGXyqAwOniyDxlyqAYJvOTmjnr3f7CscyLfTJ6cwtqHf24oS1glrt1o12ncMmv8aHIS9tg3a7hqp87W6UFIOGIZKw9gARJN5vX3rKOunK66wOXcBX5NwMoa512ipVrRvzwfg+GUWeV28M29mdfMQrQI8UazJ2DK+rYuhfYPUcTd6moOIUBK92d1O86qF1WVThtcbWnKcfVUplOIcVg/T34QgTrYzqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9q0gTzFLCu46f7/+pGqLQK2AfJzPhVzJPdfQe1O7oc=;
 b=0oKIJrW+59TQyplmNER0vTomQfxEznktF/HULRQFELtXc6Vm3TOTOAGF27BjUGaViSFdfixwhgg7zhYqM5vijXMkI7Ejuz+qCuHfujz2QMYFUJJ4loUaYNE2iRAVta6LhmMiEj3hYJfHUs32qLsg7ZXNLNOm0//a18tcTU+btnU=
Received: from DM5PR08CA0043.namprd08.prod.outlook.com (2603:10b6:4:60::32) by
 DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.19; Tue, 13 Dec 2022 15:50:11 +0000
Received: from CY4PEPF0000B8EF.namprd05.prod.outlook.com
 (2603:10b6:4:60:cafe::e7) by DM5PR08CA0043.outlook.office365.com
 (2603:10b6:4:60::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Tue, 13 Dec 2022 15:50:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EF.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Tue, 13 Dec 2022 15:50:11 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 13 Dec
 2022 09:50:10 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: Fix double release KFD pasid
Date: Tue, 13 Dec 2022 10:49:10 -0500
Message-ID: <20221213154910.705-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EF:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 776ae6f8-6300-4e2e-0b5a-08dadd21b7e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H1JtdlOhR7C/qk4YMhsPAitzEHuzCMHTBZW72LdrV47OFpPS2dOS3XqXzbLQEKcU1sM8uxLoPDkUJ5SsvUHNFa7CdBo76Wt2Tk1TXS1o2yS/sTJtwReDebW8qrl3p4Maotw/YDCTFQ7FJapboI6P46vISiBy2jV2ohCTv17xbXSi7LjzhxkVekF1Uj4CJf6wHD8asCtgkJGM1qjgYveJCEJZXm09JzHDCS/+53FCrdhEOFaaoWJowNp2QCG6u0aCUPa/qOtzladywVfS7hz7fW11lyKmoE6XuENrXUEIckuCn2LV2O1FsBg2vtCMKEVnJQPWFH/io4tTCOvtwaZoFwNNzpYoTSBlfSFC5H6mTvHxSKr2gSPAP0i3UE1ssEorEUI7fP9Jyz/0WgEvf5oz+7kgko6r3hy7xJErGcK800j3+pQ/VBEwwJbc0FW2foqxXzjsKfUjbyZduYeaCX82QdB+vaSR8K/qJ3yrFQks/26GJkqLDiF26IWiay02AG8+XSiSgxm9FZeKc99JwnXORSQ2he/pR1Glws+FjVCJgRVSQD6nhCRZQtq7OMNHK5FNAvcVC/W2QvRwUQrIyQ2WfN+xjUyAB1h+TKD70ArYND5YKxEv2+MiKcjooIp9e6Qvqm+wvyR7lj3UAUuq5Y1ZvbCDTGoIxJMpX07IHk2aRR8VPgrxCqnL8WWOFiU5VQK1p0HxHPd05P73GtqH70iGGwnGmpbDWrP3+y/ctiN9sjg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(81166007)(82740400003)(356005)(36860700001)(86362001)(54906003)(316002)(4326008)(8676002)(70586007)(40460700003)(6916009)(70206006)(2906002)(5660300002)(47076005)(41300700001)(336012)(1076003)(8936002)(2616005)(40480700001)(83380400001)(16526019)(26005)(478600001)(186003)(426003)(7696005)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 15:50:11.4022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 776ae6f8-6300-4e2e-0b5a-08dadd21b7e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 kent.russell@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If amdgpu_amdkfd_gpuvm_acquire_process_vm returns failed after vm is
converted to KFD vm and vm->pasid set to KFD pasid, KFD will not
take pdd->drm_file reference, as a result, drm close file handler maybe
called to release the KFD pasid before KFD process destroy to release
the same pasid and set vm->pasid to zero, this generates below WARNING
backtrace and NULL pointer access.

For compute process, KFD manage pasid and drm close file handler should
not release KFD pasid to avoid double release.

 amdgpu: Failed to create process VM object

 ida_free called for id=32770 which is not allocated.
 WARNING: CPU: 57 PID: 72542 at ../lib/idr.c:522 ida_free+0x96/0x140
 RIP: 0010:ida_free+0x96/0x140
 Call Trace:
  amdgpu_pasid_free_delayed+0xe1/0x2a0 [amdgpu]
  amdgpu_driver_postclose_kms+0x2d8/0x340 [amdgpu]
  drm_file_free.part.13+0x216/0x270 [drm]
  drm_close_helper.isra.14+0x60/0x70 [drm]
  drm_release+0x6e/0xf0 [drm]
  __fput+0xcc/0x280
  ____fput+0xe/0x20
  task_work_run+0x96/0xc0
  do_exit+0x3d0/0xc10

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 RIP: 0010:ida_free+0x76/0x140
 Call Trace:
  amdgpu_pasid_free_delayed+0xe1/0x2a0 [amdgpu]
  amdgpu_driver_postclose_kms+0x2d8/0x340 [amdgpu]
  drm_file_free.part.13+0x216/0x270 [drm]
  drm_close_helper.isra.14+0x60/0x70 [drm]
  drm_release+0x6e/0xf0 [drm]
  __fput+0xcc/0x280
  ____fput+0xe/0x20
  task_work_run+0x96/0xc0
  do_exit+0x3d0/0xc10

Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index efc0a13e9aea..bf444c3f6656 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1244,8 +1244,14 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 		amdgpu_bo_unreserve(adev->virt.csa_obj);
 	}
 
-	pasid = fpriv->vm.pasid;
+	if (fpriv->vm.is_compute_context)
+		/* pasid managed by KFD is released when process is destroyed */
+		pasid = 0;
+	else
+		pasid = fpriv->vm.pasid;
+
 	pd = amdgpu_bo_ref(fpriv->vm.root.bo);
+
 	if (!WARN_ON(amdgpu_bo_reserve(pd, true))) {
 		amdgpu_vm_bo_del(adev, fpriv->prt_va);
 		amdgpu_bo_unreserve(pd);
-- 
2.35.1

