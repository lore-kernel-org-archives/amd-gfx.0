Return-Path: <SRS0=wwPX=2D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2DBC2D0CF
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 21:09:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1284A246A2
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 21:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SfdSW/Og"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1284A246A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A6726EB37;
	Fri, 13 Dec 2019 16:54:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5936F6EB20;
 Fri, 13 Dec 2019 16:54:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vhu4fvjFgfigeuGCeZfrZzBQO+EsF0QDlLFMpCr4Cspx+RIHTQY6C92NvOO44aAFblFf6rO7R2CpqOQRH/6wZocFDBGg5AnV76eG6yVs2EXDVutA3obwv3Om5WwqIxA90UPcypUJacjRvOI8iy1dWt1ebmgfb9LMvZfH/IpGrVl7EHfeNcVo/YZKa08OaFaiF58Wbx4MwQgI0s698pUo4jJ2ENh+kW7s/5EavJ79kPFSeNh1bCICS7v6gzHB/jB9j8rAP22Ai7jGTAziRA0jIdfIuCmPy4U7LxYC7dhFhhQcZV2xQ3IYeAjJRQg/lg/16dWgdmcZOLfyfGUCJtveqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNH2v+Pq0texW9HG5gKRtqnHAfB4p9nn4My1m3Yxh+U=;
 b=CxM2V/zEJwIqirFZ4EsWWJ9w2Vg8v08s17W2sTjhX2YOw2+TznDFubZBtWBq45tQDlRjnjPp873Y8ywbsWvvNve99prYblLolvHZJ5hstVV44xm79f2msXECnKXOQycAMkXdekcq0rHtFdMnMVux6BbOkmUh3W1usosww61MAPh7kEqOvtXAxiqv+F+/FBdUTLDbDt3MwVhSzqk/lPfWAei9+//leEUyoSSCQRJwbQlj0XLfCCPs19vlLbzdc8h3Fqf/Dd7gxWb7fuu3x6aCrZMHd04EZ52oLtFCfXWnhDi3UIO33WDD/WI3z9QtC1Iz2AJ/mSPX0aH/ggwQFreHrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNH2v+Pq0texW9HG5gKRtqnHAfB4p9nn4My1m3Yxh+U=;
 b=SfdSW/OgYmpDEwohLhkHp+fBWVv2vDH9LfVKc3DVdGJi1el0O15K72cIgtClEJV/BHva1mo6Fqrij+gDS/eP1jBB7DVRHQzPoWL8jdUuMBeZtkfnBG5XZ4rP1o6i+7rn9+KYvHW1pkdG1Ht2rr4niLli7Oo3Ew4DEs5YrbkDITQ=
Received: from DM6PR12CA0013.namprd12.prod.outlook.com (2603:10b6:5:1c0::26)
 by MWHPR12MB1581.namprd12.prod.outlook.com (2603:10b6:301:f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.14; Fri, 13 Dec
 2019 16:54:20 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::203) by DM6PR12CA0013.outlook.office365.com
 (2603:10b6:5:1c0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.16 via Frontend
 Transport; Fri, 13 Dec 2019 16:54:20 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Fri, 13 Dec 2019 16:54:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 13 Dec
 2019 10:54:18 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 13 Dec
 2019 10:54:18 -0600
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 13 Dec 2019 10:54:18 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 4/5] Subject: drm/amdgpu: Redo XGMI reset synchronization.
Date: Fri, 13 Dec 2019 11:54:08 -0500
Message-ID: <1576256049-12838-4-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576256049-12838-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1576256049-12838-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(136003)(346002)(39860400002)(428003)(189003)(199004)(26005)(54906003)(4326008)(86362001)(186003)(5660300002)(70586007)(70206006)(36756003)(316002)(110136005)(7696005)(336012)(8676002)(8936002)(2906002)(81166006)(81156014)(450100002)(426003)(2616005)(356004)(6666004)(44832011)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1581; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb1b9a88-0849-4efd-9063-08d77fed18d6
X-MS-TrafficTypeDiagnostic: MWHPR12MB1581:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1581C59F0D455ADDA53281A8EA540@MWHPR12MB1581.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0250B840C1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uM53W1D5HSGSgyU5kWNp+6L4BRMQYOL5IQMkD9N580Ci2NtzyiA2HFdYnjzRHmhCmK57RMmQrGjPIFkkHdLNLBG7xE/ygPxEQUlSoWje8H6lukZd7Obh4nh5QHQ7iFZiVqowPBtSPhy0UdrHxM1+09qj9atFVf3uNLxBR+YeFvOoiXccyvLlG/JhTpQJGlSTFO6arJYgWSyaqJNUVqqhl9PquK/uAQbK9nPYnU5KlaKB2KjRgxLY0HeEm3YwUi2hWgCKWI3vmgRo5bLlG0jchdGcGGS5q3KR8hJXv0RQ1lyHQVWA7ZT5FFABaauV1rdj4mQXR+Vf3jMHLoxm+TXilWvVP8F8Z08u0E0vNJArxj7TwAIeTSJOQrzft1ojteKAh3fBms3kMsbFSLpPLvUxCvE0ru2gf17yyuQSXgKmoWMssVQtwZ40+t/tGivA+nxh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2019 16:54:19.6473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1b9a88-0849-4efd-9063-08d77fed18d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1581
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Evan.Quan@amd.com,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use task barrier in XGMI hive to synchronize ASIC resets
across devices in XGMI hive.

v2: Retrun right away with a warning if no xgmi hive, update doc.
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 +++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1d19edfa..2ae944c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -67,6 +67,7 @@
 #include "amdgpu_tmz.h"
 
 #include <linux/suspend.h>
+#include <drm/task_barrier.h>
 
 MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
@@ -2663,14 +2664,38 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
 {
 	struct amdgpu_device *adev =
 		container_of(__work, struct amdgpu_device, xgmi_reset_work);
+	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev, 0);
 
-	if (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)
-		adev->asic_reset_res = (adev->in_baco == false) ?
-				amdgpu_device_baco_enter(adev->ddev) :
-				qamdgpu_device_baco_exit(adev->ddev);
-	else
-		adev->asic_reset_res = amdgpu_asic_reset(adev);
+	/* It's a bug to not have a hive within this function */
+	if (WARN_ON(!hive))
+		return;
+
+	/*
+	 * Use task barrier to synchronize all xgmi reset works across the
+	 * hive. task_barrier_enter and task_barrier_exit will block
+	 * until all the threads running the xgmi reset works reach
+	 * those points. task_barrier_full will do both blocks.
+	 */
+	if (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
+
+		task_barrier_enter(&hive->tb);
+		adev->asic_reset_res = amdgpu_device_baco_enter(adev->ddev);
+
+		if (adev->asic_reset_res)
+			goto fail;
+
+		task_barrier_exit(&hive->tb);
+		adev->asic_reset_res = amdgpu_device_baco_exit(adev->ddev);
+
+		if (adev->asic_reset_res)
+			goto fail;
+	} else {
+
+		task_barrier_full(&hive->tb);
+		adev->asic_reset_res =  amdgpu_asic_reset(adev);
+	}
 
+fail:
 	if (adev->asic_reset_res)
 		DRM_WARN("ASIC reset failed with error, %d for drm dev, %s",
 			 adev->asic_reset_res, adev->ddev->unique);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
