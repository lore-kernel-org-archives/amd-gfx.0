Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC1AC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 23:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5052B1125F8;
	Mon, 17 Jan 2022 23:43:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1751E1125F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 23:43:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USFZyOrJavxKP0JildRL/aR0Mit2lyXloyw1Xu4IDfy2IC2zZFAHXmqzJzL0501WGSUEl3Bk3SL/+cq1jYyUEN8H2SqB5sJrFt3CF34jSCP72l6qcxVSdTd1/0HZ/s4MfT+LPZUacUZnYf6Ku13sR1BLLC5mJYJw4Bdrwv31WCxUZ8z3jrX/EXRsOhlLCoq0aMdUD9BWZLZujbveQXUcHsNmKPmi8/0yfawtIzHzfVdVExMwmnvl9rq2mzoBtzAW14uJWdS1iu9EfU92U1Hd8hnWCGKZyWxRyXCSOPO9JBiFccO02MEQ94hV7RZSccc/jRB678SBbcAkl/izGpMp9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNdmRILphJvEEm9UTFCCQbYvmGa2ND4wZFDUv/NB9Dg=;
 b=i4vY4zH4vHNrVWIULF2dZd1M2827QQMrvW/hneDdAajdNJxPVgsUn8W3M9WcV1faJ37wKs9IUiri2sjfKErFikcX/xUApS3cnBCSwuj3faOHja9iJQxA9QLPIKJnvGhWi0Kmk7WpuPh57vqlD5OwDtlp6FCzbAfPJMwzhU00egNvc+P0BA5X+Kp35RKu+lkyHgvL0wNqsPfEUOgD9FZ4loTl8tQmDSR4YQSafE6xjEE5xX91kFR1ExdDqYEq8cNm7MVwVtQ+h/sO3IX9YYRGXScJCJ3dFK8HzG28B+708RkRMtSL62UMP4ncZ/hXcsOsq3YputzByIkDgytAYyGOJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNdmRILphJvEEm9UTFCCQbYvmGa2ND4wZFDUv/NB9Dg=;
 b=rXJJ/vwSCu0wMQSZ51uh9OvRO3MNZC7+kdzMKuFK6+ZmWUQ/izxB9EsO2dzbKMRF3Vi7b2duJsaCZYncgSlbH2BNvKpllos+Gs/G9c7c2kReSVcz672xYPD2iEYSIlEBa0HttWRvyn+jPeOJtgKgr9iAHXsiytsUTDKBA9e3HCA=
Received: from DM5PR19CA0064.namprd19.prod.outlook.com (2603:10b6:3:116::26)
 by DM5PR1201MB0140.namprd12.prod.outlook.com (2603:10b6:4:57::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Mon, 17 Jan
 2022 23:43:17 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::b2) by DM5PR19CA0064.outlook.office365.com
 (2603:10b6:3:116::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Mon, 17 Jan 2022 23:43:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Mon, 17 Jan 2022 23:43:16 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 17 Jan
 2022 17:43:16 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: fix build up and tear down of debug vram
 access bounce buffer
Date: Mon, 17 Jan 2022 18:43:07 -0500
Message-ID: <20220117234307.3820143-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3886798-9949-4115-20e1-08d9da13229f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0140:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0140C1541B9ACCA625EFFB2385579@DM5PR1201MB0140.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PeLb8FLRx5T1rFPl9PJL294j2oW3uXXiHgz5dDpHt/2UJNFUA6pel94104/goVXrOlct9CkxtZ576yNO1hzjQ4pUYaRlXtz5QYPs1iZP9DXPVQFHSkZJ4FMqba1+ppuS5luxEA8F36KKyP+tG2RwsT90cyC3yupkaEwKyyoaUH5orrOg7c9ehQTBOWUi0lc9SZt7nkJoBR3aTsFlt47tW362K60Fha+jJAPYL9bjLNqUHfi+bmL/5Qs7kYPp7LGDFRVvnpqN+wLrWsIMSWcuPE1BuHmam7t3mdoavCzzl6HIORP1LoLwIT87fCdL6igoVO+DESGFIUNH3C6SU+xexBePY5ABZ65qaMsYgyzCATKHEWMqNk/8/LrU66BQCP+dSWzuVrnJbNQMIedSvFtGPPIl5Pd9kb8i+HeSgxIOJjbd14RJHaU3jKCTgdIb2O63j8vo+NFPNdATjzOsGR+b7pXGIqHvOvlEDhyQoU67P8qVKr6fLuMC51z+elB76T1OaOP1JHxNL/+CpfUfpOdA2KOwSOAqcveWpiRwV5Cp0ZhW92Vfgp02wh1l1qBoI+cXhYOtDe5TICFmMzD9v8HuZ9plRn9AqkAlU/DPz66ByjqGyoPX1svlpRRuRlto5nimuveHTWQsjqnwc+3JEsz2ekr7pvVcM1A7knNzWsyuGV/SBK72gFiVEbMLpK4qjFyy+BZAqCxCUWRvZT3QXgRmZkVBcXsG9FNZam+DLrN/s4Jus0F5MfBVVmQ43vvnojnni/Pfx5xQumSI8G+tM4yzCelWpDWnQvLA3Gr6lK8vfqg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(54906003)(2906002)(82310400004)(316002)(426003)(70206006)(44832011)(6916009)(36860700001)(336012)(40460700001)(2616005)(36756003)(47076005)(86362001)(6666004)(508600001)(81166007)(8936002)(1076003)(8676002)(7696005)(16526019)(83380400001)(186003)(5660300002)(26005)(356005)(4326008)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 23:43:16.8786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3886798-9949-4115-20e1-08d9da13229f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0140
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>,
 Christian.Koenig@amd.com, Guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move the debug sdma vram bounce buffer GART map on device init after when
GART is ready to avoid warnings and non-access to SDMA.

Also move bounce buffer tear down after the memory manager has flushed
queued work for safety.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  8 --------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index da3348fa7b0e..099460d15258 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2378,6 +2378,13 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (r)
 		goto init_failed;
 
+	/* GTT bounce buffer for debug vram access over sdma. */
+	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
+				AMDGPU_GEM_DOMAIN_GTT,
+				&adev->mman.sdma_access_bo, NULL,
+				&adev->mman.sdma_access_ptr))
+		DRM_WARN("Debug VRAM access will use slowpath MM access\n");
+
 	/*
 	 * retired pages will be loaded from eeprom and reserved here,
 	 * it should be called after amdgpu_device_ip_hw_init_phase2  since
@@ -3872,6 +3879,10 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	}
 	adev->shutdown = true;
 
+	/* remove debug vram sdma access bounce buffer. */
+	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
+					&adev->mman.sdma_access_ptr);
+
 	/* make sure IB test finished before entering exclusive mode
 	 * to avoid preemption on IB test
 	 * */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index b489cd8abe31..6178ae7ba624 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1855,12 +1855,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
-	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
-				AMDGPU_GEM_DOMAIN_GTT,
-				&adev->mman.sdma_access_bo, NULL,
-				adev->mman.sdma_access_ptr))
-		DRM_WARN("Debug VRAM access will use slowpath MM access\n");
-
 	return 0;
 }
 
@@ -1901,8 +1895,6 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
 	ttm_device_fini(&adev->mman.bdev);
 	adev->mman.initialized = false;
-	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
-					&adev->mman.sdma_access_ptr);
 	DRM_INFO("amdgpu: ttm finalized\n");
 }
 
-- 
2.25.1

