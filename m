Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A161C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 20:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07FD820836
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 20:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jG2Gutxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FD820836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C52466EBC4;
	Wed, 11 Dec 2019 20:07:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26E066EBC4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 20:07:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNSLjRIQYHOrtXDk86f5T44/YWggL/BI+1EIOgQvrZ+GgL8CIQJYBWt9idBtVSWDYGDMjfNEVTBjYGPLBMk5Ar5JttotodiVHjBThaKsUo5tzaVx1BALvAUpaPsvc65l/WAGIZtxSALxP2N/a3T5NSHO4XTVF5ZtemVIhPRIWsFWIPG/AHoz9atss6ccsRvyxaUhUwXNFefI7+0BeD0OHDglMPBwWPEK7xD8mln1tHc95kJbYIG5+R4+s2KR1t16U2U56MmNswpbc3C2MFF+fukoTlxlKDjAIx5Y9gnV9jOvTDPQLnHoK28z0bwwmz4YK1rn6vLZAD+1JF1S4tV4nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgUn9i8qZ47fjrSZL0crJUhQP0Epe52ppA+OgA4ALuk=;
 b=ntK+rO7hnn97MTjIrhecj/o17FLyJwEklZ1PQkB0quC4CooPWkz69yu3qnErDeGhXls8rdgZOsBxqI9DKKICR+nCwwhwj9/4HXZK+g1uwDre/+aJYP4tuNT5Z3oyu1rj+QGxorzGil5AhaoX0mn5OtfTDSzXRX/aRqQB/Fsv3+AnA/tDjHnTZ+Y7+ytqzR4F5S13S1+3/qUGCyQTunduKpV+cON4m9f/p/tG8QBs6jkahZQpP+wWMsNUWchZ+gRf0ar0vA60WoobGN75x7a6C5yTXWbDm3us7tZjlkT4KHJNL5LaEBVR5fHKBu3npKw0oVTXsIiqGB2QudwiFeI2Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgUn9i8qZ47fjrSZL0crJUhQP0Epe52ppA+OgA4ALuk=;
 b=jG2GutxtkOTvldwbHGDoVOQ2hWtQWzKSu+c/LQjyr/MzzedCCnPvo+hFUlHopK7b+5VYxPYJcW/iFWK1IvW3bShRmtx+Banphhr0QonNYYTmrisJod6K5Q6QApYpzlUqRe6M5loKLkaNLXyd3lRM+dSMFPZd7vAKg0EbbkJVJu8=
Received: from DM5PR12CA0072.namprd12.prod.outlook.com (2603:10b6:3:103::34)
 by CY4PR12MB1735.namprd12.prod.outlook.com (2603:10b6:903:122::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.17; Wed, 11 Dec
 2019 20:07:22 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::209) by DM5PR12CA0072.outlook.office365.com
 (2603:10b6:3:103::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15 via Frontend
 Transport; Wed, 11 Dec 2019 20:07:22 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Wed, 11 Dec 2019 20:07:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 11 Dec
 2019 14:07:21 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 11 Dec
 2019 14:07:21 -0600
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 11 Dec 2019 14:07:20 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] Subject: drm/amdgpu: Redo XGMI reset synchronization.
Date: Wed, 11 Dec 2019 15:07:08 -0500
Message-ID: <1576094829-2245-4-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576094829-2245-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1576094829-2245-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(39860400002)(346002)(136003)(428003)(189003)(199004)(4326008)(44832011)(70206006)(426003)(478600001)(2616005)(70586007)(36756003)(316002)(336012)(186003)(26005)(6666004)(5660300002)(54906003)(8936002)(356004)(7696005)(6916009)(86362001)(81166006)(81156014)(8676002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1735; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60427699-9d10-4970-c6fd-08d77e75bbe3
X-MS-TrafficTypeDiagnostic: CY4PR12MB1735:
X-Microsoft-Antispam-PRVS: <CY4PR12MB17352B71E00477B0105AF697EA5A0@CY4PR12MB1735.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PeZyuSepskYe7x4Vzxv+6RdesThu6v51BEisbFs3rwe1fLaEmnCG2vlkHOFG0vHY0hE9vtIrszIXLto4QcucL9gZ218DLbimTBNp8B1wSDyuloj+nvg5t1EdxOXEXSIoIEjMvQtlwTDuhpXwJWIG+KLPgWgJx9JZZrFcjM+RBGKk6Ie6Ghc8POfUJumxeEG8B5l4UBPb3pwFc+P3dNz/U/vj4DMYSMEmxDDU0Kuwx57Npzqb9BjkEv5g2pVLAqmmeIuubKQuLcMV7OCv7+vHe2m3/x7d4JdCe/0iNEAftj+gbWdc0o/urTkmtyWxz+6GXbnKyBFRsHiVtKmK1/pjOAaVoowJqQx1VnU+4pFQVt/6yXZt4uBghJytn5z/QMlYyEgpdVon9e4jYv2D54Q/z+uZN+yQLNbr7rD/bsetVrQQ9yP9Q8d8qa7wiuBAi37x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 20:07:22.3153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60427699-9d10-4970-c6fd-08d77e75bbe3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1735
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

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 42 +++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1d19edfa..e4089a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -67,6 +67,7 @@
 #include "amdgpu_tmz.h"
 
 #include <linux/suspend.h>
+#include <drm/task_barrier.h>
 
 MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
@@ -2663,14 +2664,43 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
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
+	/*
+	 * Use task barrier to synchronize all xgmi reset works across the
+	 * hive.
+	 * task_barrier_enter and task_barrier_exit will block untill all the
+	 * threads running the xgmi reset works reach those points. I assume
+	 * guarantee of progress here for all the threads as the workqueue code
+	 * creates new worker threads as needed by amount of work items in queue
+	 * (see worker_thread) and also each thread sleeps in the barrir and by
+	 * this yielding the CPU for other work threads to make progress.
+	 */
+	if (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
+
+		if (hive)
+			task_barrier_enter(&hive->tb);
+
+		adev->asic_reset_res = amdgpu_device_baco_enter(adev->ddev);
+
+		if (adev->asic_reset_res)
+			goto fail;
+
+		if (hive)
+			task_barrier_exit(&hive->tb);
+
+		adev->asic_reset_res = amdgpu_device_baco_exit(adev->ddev);
+
+		if (adev->asic_reset_res)
+			goto fail;
+	} else {
+		if (hive)
+			task_barrier_full(&hive->tb);
+
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
