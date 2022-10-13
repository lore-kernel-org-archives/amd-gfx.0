Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AA8C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Oct 2022 08:29:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2CD210E1FD;
	Thu, 13 Oct 2022 08:29:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB06810E054
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Oct 2022 08:29:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XR9AzQYwIzCDRiydm3chYXRszaxDZQSg24WCFnJET7mXtjOEaqk9pHh0P2QUcQhnCUZ8oeie7aN/HrFXFKd5o6PicZCGebuFbY2ytTpN6uO36RWNMJBQ9XiqiEEy31EUBabSJ2oNxTVK24IDGKv9TEGmTCxgYNUdyDnmCg38Zpo1b6hZ7he7XIowOgosp6tpJGjKamYB6KcFvG3CXo97ggx0H1PlPdeM26eJla9T0FEF7Ajs5+UW/Kk+pNGppqZObjYXk2BVXH6VPtHML26VW+KLHFqhG6/+AmJ+HWYbRH+73LGY+FbF/AIjmavD/ethmgO7+QXAek/Xj4WHIY8wdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUTrNEYn8LrqX+S1nCYrbQoZYDDC9tpA4q+PN1EYmnA=;
 b=mlzuFjXT2FJwPckdPQ11HZZk1dheHfDgaMs/cLoN+mzQ+QiQ79bMu2Do02TpxY6878toskiXk5jUexF3Bc0Vcj05MTYDPSKiBc6sglogNLuZSz0uNVmnE0U6tdVA9ewoUjsvI1QXHRvirw4ET2Okc0TTJzZCmKZNhmoWQUM8DDvlcGXuKMNYP1OkRvmHasrXq2eLwezBKGzvplc9IdpHAaP+CPf76zeuNKs4OZMo+E2SAJZPc90IMJ0+/mvkGXqWzT+vl54MGlqLROEAr9e/ucBfTzdYZzNFUockcksmigCttq4fqRzqMOXX8N5+e678y9pw+EO0l7Of3vBREuh7hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUTrNEYn8LrqX+S1nCYrbQoZYDDC9tpA4q+PN1EYmnA=;
 b=HZ17n1GTntqeIEdoko7EYUVIsigcKFr6muxnxfNMQm6qjtSzHzf4+j5S4o+CquvX+wjjiPVIbI7iiE5ZVRe47lEuRe6LwrujptcYeiWQME6c9EfITQSL1mBtS0HRVthAoDc8WTymGSLttGZXx4eaupXRH2483mpwu8ySWcmKwWw=
Received: from DM6PR06CA0049.namprd06.prod.outlook.com (2603:10b6:5:54::26) by
 DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.24; Thu, 13 Oct 2022 08:28:59 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::13) by DM6PR06CA0049.outlook.office365.com
 (2603:10b6:5:54::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 13 Oct 2022 08:28:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 08:28:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 13 Oct
 2022 03:28:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 13 Oct
 2022 03:28:43 -0500
Received: from victor-test02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 13 Oct 2022 03:28:41 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] Revert "drm/amdgpu: let mode2 reset fallback to default
 when failure"
Date: Thu, 13 Oct 2022 16:27:44 +0800
Message-ID: <20221013082745.46143-2-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221013082745.46143-1-Victor.Zhao@amd.com>
References: <20221013082745.46143-1-Victor.Zhao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: 0671ddf4-6625-4ccb-b3c8-08daacf4f9fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8jkH1EPDsPuLc7iG8IZiNQP47CY6D0gRZ/KWEu4xXNpvI/Rcfh6F/mmqyW/zIoadvfq9b6ErVfx98BJquGXdXGO+z4JdzmV4wkqUIAB9dj3xmike94i5Y8oDgjjl6TaEPn0hTiNzJ8vCVCvYX5ezOel4EXbQCKU+tnHjA3U1oRIw2uFtusgn5OXXlUo++jrh0npa9++Ii0oKgA32fI+FVFNNlpY7RRUMhJ6LFaqSy003cAg8i9a+jne2d4O2DCcEppKZMkId7zIg5nlon52IQu6m3zVx00UPi2Rci54BAo1szMmPwsvOViUFLwhYtd923wAe+pQ2wdD1Y4oSEVhn6gz01sjVU1pMkYfY9yHhgrC/2KfUTdJG3nyXfcZipAMjZqTa4Xurn/N1hVA0cMYd8ebvRvUHI24++mj+cm1IUW9AFbfD1EkXMPzZvsvPKwF8ZWtu+KTIrZEgh29/Bm5KlrC7b1jaMVZIFJNHZTcj1HPINn1BKHx2O6RkrIBm3jCfgfFjzDAXtbP3aKfvpZ676TjHC6bQ8QSE5oqm7rLOXq5yGwGOcuTSxeRmLeCiQLZyFbfiNp2f7ISo0V/iWhZxa9A6DC41B3RYZ+h3wEWlg6RU7WsazfKVKgA0LPCeDZrZfZ3UnAmpO9EeFDccr5AwHK1CjEW070LiVdspjn8REQAzxLKbt9nD+n9rnYl3qbUrFSPL1L3Qy8L5SwaOe0U8Nb8fOeYdQnBci6yqUt6rAb3UCjwl8nw1qhfJhb9LUU71K6b9Av2JS/QpNuhU9t/rCRH7Knve+qnZvhB66qJWhAI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(46966006)(40470700004)(36840700001)(26005)(316002)(82740400003)(5660300002)(6916009)(54906003)(356005)(81166007)(8676002)(36756003)(86362001)(36860700001)(40460700003)(2616005)(47076005)(186003)(70206006)(478600001)(70586007)(1076003)(82310400005)(41300700001)(336012)(83380400001)(426003)(40480700001)(7696005)(4326008)(2906002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 08:28:59.1650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0671ddf4-6625-4ccb-b3c8-08daacf4f9fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
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
Cc: Andrey.Grodzovsky@amd.com, Lijo.Lazar@amd.com,
 Victor Zhao <Victor.Zhao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 3efc702897c54c95c332632157ab042e942512c7.

This commit reverted the AMDGPU_SKIP_MODE2_RESET as it conflicts with
the original design of reset handler. Will redesign it.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 6 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 3 +--
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      | 1 -
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      | 1 -
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      | 1 -
 9 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 03bbfaa51cbc..0561812aa0a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -134,7 +134,6 @@ static void amdgpu_amdkfd_reset_work(struct work_struct *work)
 	reset_context.method = AMD_RESET_METHOD_NONE;
 	reset_context.reset_req_dev = adev;
 	clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
-	clear_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
 
 	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ab8f970b2849..bb73fb420ffc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5210,7 +5210,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 	reset_context->job = job;
 	reset_context->hive = hive;
-
 	/*
 	 * Build list of devices to reset.
 	 * In case we are in XGMI hive mode, resort the device list
@@ -5337,11 +5336,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			amdgpu_ras_resume(adev);
 	} else {
 		r = amdgpu_do_asic_reset(device_list_handle, reset_context);
-		if (r && r == -EAGAIN) {
-			set_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags);
-			adev->asic_reset_res = 0;
+		if (r && r == -EAGAIN)
 			goto retry;
-		}
 
 		if (!r && gpu_reset_for_dev_remove)
 			goto recover_end;
@@ -5777,7 +5773,6 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	reset_context.reset_req_dev = adev;
 	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 	set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
-	set_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
 
 	adev->no_hw_access = true;
 	r = amdgpu_device_pre_asic_reset(adev, &reset_context);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 46c99331d7f1..cd968e781077 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -72,7 +72,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
-		clear_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
 
 		r = amdgpu_device_gpu_recover(ring->adev, job, &reset_context);
 		if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 2dad7aa9a03b..75f1402101f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1950,7 +1950,6 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
-		clear_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
 
 		amdgpu_device_gpu_recover(ras->adev, NULL, &reset_context);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 831fb222139c..f778466bb9db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -74,9 +74,6 @@ int amdgpu_reset_prepare_hwcontext(struct amdgpu_device *adev,
 {
 	struct amdgpu_reset_handler *reset_handler = NULL;
 
-	if (test_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags))
-		return -ENOSYS;
-
 	if (adev->reset_cntl && adev->reset_cntl->get_reset_handler)
 		reset_handler = adev->reset_cntl->get_reset_handler(
 			adev->reset_cntl, reset_context);
@@ -93,9 +90,6 @@ int amdgpu_reset_perform_reset(struct amdgpu_device *adev,
 	int ret;
 	struct amdgpu_reset_handler *reset_handler = NULL;
 
-	if (test_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags))
-		return -ENOSYS;
-
 	if (adev->reset_cntl)
 		reset_handler = adev->reset_cntl->get_reset_handler(
 			adev->reset_cntl, reset_context);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index f5318fedf2f0..f4a501ff87d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -30,8 +30,7 @@ enum AMDGPU_RESET_FLAGS {
 
 	AMDGPU_NEED_FULL_RESET = 0,
 	AMDGPU_SKIP_HW_RESET = 1,
-	AMDGPU_SKIP_MODE2_RESET = 2,
-	AMDGPU_RESET_FOR_DEVICE_REMOVE = 3,
+	AMDGPU_RESET_FOR_DEVICE_REMOVE = 2,
 };
 
 struct amdgpu_reset_context {
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index a2f04b249132..12906ba74462 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -290,7 +290,6 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
-		clear_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
 
 		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index a977f0027928..e07757eea7ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -317,7 +317,6 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
-		clear_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
 
 		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index fd14fa9b9cd7..288c414babdf 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -529,7 +529,6 @@ static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
-		clear_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
 
 		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 	}
-- 
2.25.1

