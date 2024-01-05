Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95549C3DA6E
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jan 2024 03:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B447610E116;
	Fri,  5 Jan 2024 03:24:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFB7010E116
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jan 2024 03:24:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lswCSvckJhdyimK/0a+bvZgq/a7/OuTZloQ9t9p8FID6q7fC2PWDgcAZfo1Xv5IjNI27bDO1G8fRjmhTZbKFezkLHt8lw9HxQBsosCqQVaUJeinCqP0OJ9FbJ07UIiHBdkHgOIK/Fl7Oz8mSL1ogaHxX9wkfGykIFPDAdE4K7az+TTePOvEiTEQxsGpZOGnYji+EdiuDNzNC+sEBUOjjAQc7spG7zm3fYXuV0PFYSKz5fMQ7WQ8C0P6DefGIHULjyi0mu/j3mMvM0F0CxdJ29Vz1Let/srMmaurHkRXMLs8QAjbOIEjf3IZkR233fzwVxd2R2JOnHAAZ1002iIFlfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRw2WaF/zuV93i4G+UNecejsYBcoOUibEaX/+WIRG6k=;
 b=XJyvjoL01MNk4/m0NK+04TXJInqAXJvofAuHjNyY6uzZxhS2tFy/uuPnCwuxt6F2ZTyHKCIXHXGuGLbWwcxEjb9Sac5bIj+09cJz0akpMF9tOJPeaD4rHiT4CmU48CkdRD69KcvuacwABIeBlX0ClNUU6NLA64JC6IEx4AlcaE7IQS6CfWlK2lrKQWQWG/jKPSw/36E852V3mrCbF1/swKVYnYmNpPs/GUMigQk4MahwuevEWNop29axB+YGcb8Wkv1CZQLoF/mmx7WnCt2XSoefqxpYOv2wBxyChpDmr/ZEl7HsCf8QX3z6mKWJun2WIIlxYdbYytv+gZD5ENZH4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRw2WaF/zuV93i4G+UNecejsYBcoOUibEaX/+WIRG6k=;
 b=HZ04aV+FQZxwSp9MHWjg1HzJpRKGYSLQBbSkk9mtd3jCTPSAeiKNpgZhXHi7MSfuKQ53hw+wtQPeAfva6kviElqr07jgU/fdKeLo00dGNjitnfwV/5+jIeK5N8yc5Hcxa8G2Z/1OyYkwUSeEN/Ex24b7SHMpTkkwwYliOTk/m6k=
Received: from SJ0PR13CA0053.namprd13.prod.outlook.com (2603:10b6:a03:2c2::28)
 by BL1PR12MB5078.namprd12.prod.outlook.com (2603:10b6:208:313::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 03:24:01 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::8e) by SJ0PR13CA0053.outlook.office365.com
 (2603:10b6:a03:2c2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.11 via Frontend
 Transport; Fri, 5 Jan 2024 03:24:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Fri, 5 Jan 2024 03:24:00 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 4 Jan 2024 21:23:55 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix with right return code '-EIO' in
 'amdgpu_gmc_vram_checking()'
Date: Fri, 5 Jan 2024 08:53:26 +0530
Message-ID: <20240105032326.2643607-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|BL1PR12MB5078:EE_
X-MS-Office365-Filtering-Correlation-Id: 6afc5fae-b940-40c3-4876-08dc0d9dc2cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GZWkiIjr9rGNssgMiIvwaZD/zqnw7i1ZDMP7IyI4R/VVY0CGmSQIuQ6R2JiAjR4/zFW43hj6jhz3QvO/VM5DmFXKsa6tSywRQGoby3pgZrV5flBpX48b9r9d0nKZjz2Hg9N7+h0yvg271tyiF7f2zwXVH0AblVJ/cSQOyv/SF07vSnAmN3k7rD0/VCPo1idn9krOXsjmrpKzJ1dPduNQF2FnJ6jyTlMxuwHC85GEnbitz5eWX2T/iHx2BooFqCh4N1BSv82TPmdzBr/CKPC/TiF/3Bh/G2UIeOquRFsWkFHTUxGcmoAhu9iCDoSHlrv7iGyiaDQAFEhUpZf6kozj4DkPVxuXPWeN8TPtAv1NBuUmFQPwwOwNZyiQVWffLrryY4uDwwSTl9OtTwutTdui+JXL7q2H9/xvp8Mg2eHJvXEAvQ/46ihGftn9Cxikz8UDZWdGxONtzB+mrMhJlGAgVmBf22er3lgq5U0nKfLPMBtivJZ+Hs3vNd81fwK5Pa3poMoIIMatWkGd9kZk/YagSulSWb1HT2SmreB5A8RnNyvCgtt01pr0aijqtDwEMEf2FdCMXsK6WU/GfYF3Qki3xoAtG5UosQqrWJByZk2OydR70lvdyFCtxVk9pci9Bjf8j3Y1qclltdG1h9r8vo/DLGeq/oVkYL+LGhY3OsILt0cepdpUuEAs5u/c6L8z41/24sPT2rvRCvniQNnB4lUfOSkySJmdR0VuEJ1zW8ndmY5lgSh/e7YIjq5i0QIxQys2SNhTxD4TkcG1UsdBp5cStw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(46966006)(36840700001)(40470700004)(82740400003)(70586007)(70206006)(6636002)(47076005)(356005)(81166007)(6666004)(7696005)(86362001)(2616005)(1076003)(26005)(66574015)(16526019)(336012)(426003)(44832011)(5660300002)(2906002)(36756003)(478600001)(83380400001)(110136005)(54906003)(316002)(8936002)(8676002)(4326008)(40480700001)(40460700003)(36860700001)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 03:24:00.1527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afc5fae-b940-40c3-4876-08dc0d9dc2cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5078
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
Cc: Lijo Lazar <lijo.lazar@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Xiaojian Du <Xiaojian.Du@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The amdgpu_gmc_vram_checking() function in emulation checks whether
all of the memory range of shared system memory could be accessed by
GPU, from this aspect, -EIO is returned for error scenarios.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c:919 gmc_v6_0_hw_init() warn: missing error code? 'r'
drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:1103 gmc_v7_0_hw_init() warn: missing error code? 'r'
drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1223 gmc_v8_0_hw_init() warn: missing error code? 'r'
drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:2344 gmc_v9_0_hw_init() warn: missing error code? 'r'

Cc: Xiaojian Du <Xiaojian.Du@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---

v2:
 - release temporary buffers, if memcmp() fails (Christian) 

 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index d2f273d77e59..55784a9f26c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1045,21 +1045,28 @@ int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
 	 * seconds, so here, we just pick up three parts for emulation.
 	 */
 	ret = memcmp(vram_ptr, cptr, 10);
-	if (ret)
-		return ret;
+	if (ret) {
+		ret = -EIO;
+		goto release_buffer;
+	}
 
 	ret = memcmp(vram_ptr + (size / 2), cptr, 10);
-	if (ret)
-		return ret;
+	if (ret) {
+		ret = -EIO;
+		goto release_buffer;
+	}
 
 	ret = memcmp(vram_ptr + size - 10, cptr, 10);
-	if (ret)
-		return ret;
+	if (ret) {
+		ret = -EIO;
+		goto release_buffer;
+	}
 
+release_buffer:
 	amdgpu_bo_free_kernel(&vram_bo, &vram_gpu,
 			&vram_ptr);
 
-	return 0;
+	return ret;
 }
 
 static ssize_t current_memory_partition_show(
-- 
2.34.1

