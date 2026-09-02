Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82E4C624D0
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 12:50:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E6CA10E4F3;
	Wed,  2 Sep 2026 12:50:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lzzAF9+v";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EAC710E4E3
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 12:50:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqVwCj0wFPpIobkw3CDrrK7xC5D5J53hDZlZe5WbUwAxdTgRkPzy4lmOD9SUAUZl4Z68GdfEsKoiU/Xm1Vs0fnSWM7H5vpqFAQ6Y6AQ2lBZP2DWGlFL2/G/Wwvq7OMat7mN4vn+ALGvnwWGNq5+KlBFkOgkOKTkZBZnBF+nqRIgSnekzVHw5d/lAXo56VgHDQ8GpBzs1RV2wly9ro8DIggtL2oH45uj15hPfkQ9gaKxodQYauhnoHWQgN43IfYeXWyxWNo7Y3BxNzZ3DFaXM/ftbXAekDc5MFm7LSpkhgEwed/FH3Jq22CflFmP4+19IpgpK9oznBHz5v9Hs53zJXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aM9QjaxRoUVsf933iUh5zpOv293aASX1SWW09lGWT/o=;
 b=mgXDmeLsS8YUyazgafHFn5bK+I6QKZRaT0B37oXzdmxa1dfACX2B6yvcRrgj626Z90kFrziMuGFcEqgGLzjEBwR5iB5s971sKujP7s6/Sl/UEIwFG3ERWUTpXFLU26io6G6Da5DmtHJ7elWOPOCtSGLaRF2bQhT1uFsaeEl1OoIKv2USIeRiR0xydNrnwiCVtv2qIwDwO8AjDZw3f13e1uzTmeq0J93N66BJdcE1+6P49QrMmesx5OKF6N6vXtbPc7SdV72JzBnpSv5SKy/QTXDxOAOZMFJwB2DnAzopN2da4G6xEggrImp/nNXAwpc7byBoUOZcRiDRpQN2iweU5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aM9QjaxRoUVsf933iUh5zpOv293aASX1SWW09lGWT/o=;
 b=lzzAF9+v6F/7ES2/MKa/YNUel2XemXzmmHk4pA58MfXz1yFE5XUKg+z3EnANH8xmIw5F6LfnTbQXjIx5vKscYMdyNin2q1G6D/nJt9nEinVq12IuPgmC/ENmWprVB70vJEUZ+3QrAcxMqCwWXVvWM1ZAG2qtnXkmSjwODZyrcXk=
Received: from SJ0PR03CA0184.namprd03.prod.outlook.com (2603:10b6:a03:2ef::9)
 by LV3PR12MB9233.namprd12.prod.outlook.com (2603:10b6:408:194::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 2 Sep 2026
 12:50:26 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::a5) by SJ0PR03CA0184.outlook.office365.com
 (2603:10b6:a03:2ef::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Wed, 2
 Sep 2026 12:50:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 12:50:24 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 07:50:16 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 05/18] drm/amdgpu: defer userq reset after eviction failure
Date: Wed, 2 Sep 2026 20:49:48 +0800
Message-ID: <20260902125001.621629-5-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902125001.621629-1-Prike.Liang@amd.com>
References: <20260902125001.621629-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|LV3PR12MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: bd470c31-c076-4031-5010-08df08f0c17e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|22082099003|11063799006|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: Lxw0t07meSCNynULqQSXTSzT1JCw87ZdPseRAJPtlLxcFpYvfEr76W2DIK2/lgfk6HgB4vEMLGI2MMB3XoLkRF3jMS8T4S0Xxudsx0V3oRmZNnjP4RYXCnEhBn+bNSGHWgx3HfLEqttHY3FzKRYUj7wduEMzKS6VQ/rRTb4LTO9mRwMKI4dtDsSJR6jteHfa0tf0SOAa2lFyUJ5o+aiq38mLfcSWTvqGAmJkxFNcXhlIlBbpPNOpYW43JgA6X/CTPscvQxz99XbNhYNmM5O0eN4uTDJL3Ycj4hs+sLJWPl3e+sXnG0dLz0WU50uuJcYyq4bD1bpu6fIG94wXxt/G5WEAnE+Hd6PHBCyA2VA2bVQcToDjt3eEshSZiUyDZOxGPAbY+fUhZoB8svrm1YBn8mQ4AdMaVAnXrFbXCBeXO8hb7EBJz/LhCHdPYypQ62+YUmeyLIUS7+iIQE7qiDhgLNb62BIDuT/7i42tTSj9zzzAporxeqQ5Fh05dhTeRsuBkAlkkV4QdMoKCxAs6WZGpuOk006bY0kyVJlv9ME2tIsHwCOjsTMVr5Lyi81oVMVBSLpkoQkSPkxzUCttah/BXIbd65lQ3GFP7jZSSCIWH+++DSlXxbv+RGPmjeaC5zSxeux3is7CU4S0Wl1eY1Nm5tuYs5Of2RizRHSUAWQMtWmh/qKPEzbRj+ruucm/4a/WJDdfrhuuQWHiHf32lo5V8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(22082099003)(11063799006)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E7/sOZyHKxduFyp6b2RkkU1wBBiPZ9Ypvb+U4A3M1hKTAMe6AgwuLY0AzKhWxCnkb66/zMYhLWXNSiYBV93f1tK2/jDQBFgtiL0tlawwvb12JqoSqyihMeKOhrH8imUXYC4Sjp8KCAyk0Yfzggz9sArF3+Ev2c3UbQb37WABac/2RR9zrOviCfi87vQ3UpoWikQfE8QCnZ5fgz5ItUZuJkdhACB9G1uTdnogQRzf1FgJzn6TVA9FNccoKzGRk+H2dCkecIETUK/SyLd1rbN9//X1UUHzpwAb0etaaCpx5Y4TU164YgaAwpZAGGBCHKHjrCMC7Af74WIudqkyUl9m3AbkSwh6FMQOHeefDXvHrkH5SfBVa8mxcQyfshGlSrfzFV8+XPPBdRi+Xd5F+hJC2E+FIb6pO8oFYNrV4RO7uXdQpa7PNlI2UYXH30qGNea+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:50:24.0332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd470c31-c076-4031-5010-08df08f0c17e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9233
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

When userq eviction fails, the eviction fence suspend worker flushes
reset_work while holding userq_mutex and from inside a DMA-fence
signalling critical section.

The reset worker runs GPU recovery, which calls amdgpu_userq_suspend()
and tries to acquire the same userq_mutex. The suspend worker therefore
waits for reset_work while reset_work waits for the suspend worker to
release the mutex.

Propagate the eviction error to the suspend worker, set the error on the
eviction fence and do not schedule queue restore. Signal the failed
fence, release userq_mutex, and then run reset recovery synchronously.
This preserves teardown ordering without holding userq_mutex across the
reset.

Fixes: c8ed2de0f2ee ("drm/amdgpu: rework userq reset work handling")
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 13 +++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  7 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |  2 +-
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index a0802012de49..2ea8553c82f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -65,6 +65,7 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
 	struct dma_fence *ev_fence;
 	bool cookie;
+	int r;
 
 	mutex_lock(&uq_mgr->userq_mutex);
 
@@ -79,7 +80,9 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	cookie = dma_fence_begin_signalling();
 
 	ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
-	amdgpu_userq_evict(uq_mgr);
+	r = amdgpu_userq_evict(uq_mgr);
+	if (r)
+		dma_fence_set_error(ev_fence, r);
 
 	/*
 	 * Signaling the eviction fence must be done while holding the
@@ -90,10 +93,16 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	dma_fence_end_signalling(cookie);
 	dma_fence_put(ev_fence);
 
-	if (!evf_mgr->shutdown)
+	if (!r && !evf_mgr->shutdown)
 		schedule_delayed_work(&uq_mgr->resume_work, 0);
 
 	mutex_unlock(&uq_mgr->userq_mutex);
+
+	if (r) {
+		amdgpu_reset_domain_schedule(uq_mgr->adev->reset_domain,
+					     &uq_mgr->reset_work);
+		flush_work(&uq_mgr->reset_work);
+	}
 }
 
 int amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index a7b68fd2360e..2534e4a1a530 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1265,9 +1265,6 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 	if (ret) {
 		drm_file_err(uq_mgr->file,
 			     "Couldn't unmap all the queues, eviction failed ret=%d\n", ret);
-		amdgpu_reset_domain_schedule(uq_mgr->adev->reset_domain,
-					     &uq_mgr->reset_work);
-		flush_work(&uq_mgr->reset_work);
 	}
 	return ret;
 }
@@ -1288,10 +1285,10 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 	}
 }
 
-void
+int
 amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr)
 {
-	amdgpu_userq_evict_all(uq_mgr);
+	return amdgpu_userq_evict_all(uq_mgr);
 }
 
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 488dc21d7c81..4dcf6151de6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -163,7 +163,7 @@ void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr);
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
 
 void amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr);
-void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
+int amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
 
 void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
 				  struct amdgpu_eviction_fence_mgr *evf_mgr);
-- 
2.34.1

