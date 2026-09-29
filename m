Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1E3C9832A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 03:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C10910EC94;
	Tue, 29 Sep 2026 03:47:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pL5waGvY";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 508CF10EC90
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 03:47:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eB0npQX6Vpnhec1Q8P0wLZEtgXG0QIvel6bxay7XAcTrdqpR36ViW1PCbiIT+RoQrP7sInD2ghamMT16j/wgcyIQQuHw/U9kD+vhtXYvyECmZIupTbDI/BwJYeiAWWR91QnpJqdhOBFzsZb6e/OuxDJY/c1H+wxiAsi7tKytEaLShLPp93wfoneb+2CONB7VLgjpLSXglh9t8fO6j0G2cUGrFOJwcE+QQmJWR3Lsc7OGel1tMLUOIdJjyyEc8PwAPhwIfYNqPz0d9sCBqX+d7pGMP+o6pz/Bwk/GHONoauxc36ZEi3SGOi3eMBwiOlWrVrFsmbU0boKyr6c/77CEUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zh5WRGgwl89cAt5URkz4W0TU1INNUSCCLKhJeAKarQI=;
 b=t1XLEiDg+LVhTIVNbKMm5Po4tEYoFj4+jhm9nrrfvemJ/nYYCLaE8ToF4zCvLF1VCwp+zWhoar10IL6rFGa77yJBm8vLI3F5d+F4Ar6V5ANCOove7Nbq9fI7MlCMjT89h4tO9JWBXwxnE21xGCt6qT4fnlYPyoG1Hz7LWH1JmHIJyMMyJ9MUOWE3iW96MqGgw+5Po+Rz50gnH/tcDQaW+vkbO1Y1XATzC8Xa7WKb5h8Q9zegkzaCOnbjFsVQikQG0+I7kTpdV+ZHKqF9g8it09li/nYA1WzblOykB2ZCEVdmPxpQJDegqdjgplGwAmaJxztVfM/QRnEGfzW124svpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zh5WRGgwl89cAt5URkz4W0TU1INNUSCCLKhJeAKarQI=;
 b=pL5waGvYTvW4JQFk1LA5rFGM/o15O0ooUMLWELs6rVR9kMmDRNmULylpl/eyhSj3jirkYMSAi6YOaMGCrasUz5bg8XajkUHgu+0y9GPOGd5Yv0kgge1qdkQ8TSgYhFivWmvv8bU+Ad0A5ACpjIr+XutNa1QWXnULReJg4cz8BNE=
Received: from BN9PR03CA0085.namprd03.prod.outlook.com (2603:10b6:408:fc::30)
 by SA1PR12MB6848.namprd12.prod.outlook.com (2603:10b6:806:25f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 03:47:04 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::6a) by BN9PR03CA0085.outlook.office365.com
 (2603:10b6:408:fc::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Tue,
 29 Sep 2026 03:47:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 03:47:04 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 22:47:02 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2 03/14] drm/amdgpu: serialize userq eviction and restore
 with GPU reset
Date: Tue, 29 Sep 2026 11:46:39 +0800
Message-ID: <20260929034650.2393125-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929034650.2393125-1-Prike.Liang@amd.com>
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|SA1PR12MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d40c147-1fef-49d2-34b6-08df1ddc53ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: r6QESJjHn7AOwJdXJtBm52GDMV0Iw9HDmXaYb3MXdYuv8zdeioviSTS2VjSp97M+7uHQpa2KFgJ9XvOaCkL1te05Vo7IUbqIrPQfLvRkhAJiZggATO5nnoDuDYmN4A2WxqmssqE6UJwf+4byrsnbd5EVliyXZLoBc4xBeH+bttFEYBRok3w8sfY8nnbYIJlqNzGY9K0UDJ9ByMEpXldDARurwsSw16a2/itJnTlI8h6OhdF2B6zHU7E06MN1i7+QfXIdPpQTBDFrjR7oPgNuD2SDBGqQXE8oMAipSi3yLVVpdEoRM/v7BQSfod0KhWhWabo0Uaxv2Yu3Yeo+6oGXxrDCezfn+QPoW7DEj1vkHj96613+KBJy90c6s/AWVISbGe83DepDqHgMQqbUr2EEor5si4Vhnw1gMb7QVp/N0pARoJ3vhqUuNuIzU/bKrPtOsx5h+XCc2WNOhLFJZ5ZBEYsdlF2QMa3uYbL4SbZE9wnJxBWZQYbnGzu/zhBn23NRK45TdLPkHOAbi1rb49Wv+gYCX6dekjMTMlsMXWPrI5wc4XjUxM81Vyx/cXhVoH+DuHzRc5jEiPbCf24zxIT3j9R3w30hUC1r9X96dVmOAHm6RTd7AAUN9WddMmfZyMiOP9h34FUaKeszQmNhGZB1yHfz24exR3EdQy0GvmRN63YRvxj4LZaObkpePj95XoGs7HGVh8jG3eP1ffLXODo3Nw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wvYqxPJc6avA+Yl1gcrR0sjihDqJSb4bUKEm1sxoONDjYhxkP3jAtv/+l8YANA+u9WyA3Ok1k3nktE6c4tJMGnrHUg2Y2FCEhRUsh8TP2CfWbPla3pJ5paKhVkq5rFNI3fQkZ6oNmlAK6kCSNMsJ2XbVSmLp/fTMGmHdn9mUqixIINL5J1Xtp8WR5n/brLAGbAPXYxJfQcyLRrMTAbdT4rPnNtNqQ2DRUQ3MT0Wjh1kaRZzAdYV8FxLX1EMUXq3Dd3Xl4VQDNXyzJKmLq9QmzJ1Xo3xCt27E6TuBXhQz4M2kNj1SM8ODQqi7ehKklkrlJ6/GOzAe3blfE67eaZz2vZZXN0kMTMaMN6xe7BID4XJCbxTZjdkAJHKSLWKIcyf9V57Nb6v8pSAg3HQjBJ/Edh/FZRj0rDjfPHhtrwcI6c1Wty4wvWl5L2cyvqt1fRZb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 03:47:04.3238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d40c147-1fef-49d2-34b6-08df1ddc53ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6848
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

Hold the reset-domain semaphore for read around queue eviction. If it
cannot be acquired immediately under userq_mutex, release the mutex,
wait for recovery, and retry the queue and fence checks. Protect
eviction-fence publication and hardware mapping with the same semaphore.
BO validation can wait for evictions, so it must not hold the reset
semaphore across those waits.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 12 ++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 15897c3eacb7..f0cc49213c01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -67,10 +67,18 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	bool cookie;
 	int r;
 
+retry:
 	mutex_lock(&uq_mgr->userq_mutex);
 
 	/* Fence waits are not allowed in a fence signalling critical section. */
 	amdgpu_userq_wait_for_signal(uq_mgr);
+	if (!down_read_trylock(&uq_mgr->adev->reset_domain->sem)) {
+		mutex_unlock(&uq_mgr->userq_mutex);
+
+		down_read(&uq_mgr->adev->reset_domain->sem);
+		up_read(&uq_mgr->adev->reset_domain->sem);
+		goto retry;
+	}
 
 	/*
 	 * This is intentionally after taking the userq_mutex since we do
@@ -81,6 +89,7 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 
 	ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
 	r = amdgpu_userq_evict(uq_mgr);
+	up_read(&uq_mgr->adev->reset_domain->sem);
 
 	/*
 	 * Signaling the eviction fence must be done while holding the
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index fa8ffa060fa5..322c95201494 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1219,13 +1219,21 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 		queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(bo);
 	}
 
+	/* Back off without publishing a fence if recovery owns the hardware. */
+	if (!down_read_trylock(&adev->reset_domain->sem)) {
+		ret = -EAGAIN;
+		goto unlock_all;
+	}
+
 	ret = amdgpu_evf_mgr_rearm(&fpriv->evf_mgr, &exec);
 	if (ret) {
+		up_read(&adev->reset_domain->sem);
 		drm_file_err(uq_mgr->file, "Failed to replace eviction fence\n");
 		goto unlock_all;
 	}
 
 	ret = amdgpu_userq_restore_all(uq_mgr);
+	up_read(&adev->reset_domain->sem);
 
 unlock_all:
 	drm_exec_fini(&exec);
@@ -1252,6 +1260,10 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
 		goto put_fence;
 
 	ret = amdgpu_userq_vm_validate_and_restore_queue(uq_mgr);
+	if (ret == -EAGAIN) {
+		schedule_delayed_work(&uq_mgr->resume_work, msecs_to_jiffies(10));
+		goto put_fence;
+	}
 	if (ret) {
 		drm_file_err(uq_mgr->file, "Failed to validate BOs to restore ret=%d\n", ret);
 		goto put_fence;
-- 
2.34.1

