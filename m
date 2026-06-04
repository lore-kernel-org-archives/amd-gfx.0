Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE868CD6E74
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 17:20:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 794A011A1F1;
	Thu,  4 Jun 2026 17:20:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ecAiCtSK";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90BD111A1F1
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 17:20:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/ejNytoKSFJQLK4Fc9qvcoPHP7oJdqYbEXetBwHnTHaP9HwAuhVFtICWqZ6e5lXYMBdSIYPIvtOi/JqXxB6hWSn5mivz9UBfY079+psQaUQoVNXV3s5/dDi0pPwqVHneowAtvL8MuOlbEALlF0fb7oPaE2tKHDsWj6m+Npk1lf7qo7FWMz2xvPeIZPiG+o6t5yAasPSqKQXEsuR0oOaAgMDaytTkdbNC5ywYGTl4mhP0smHqplGPZ4YF/ZMgLRaRLiYvGBPIeskFtiYfj16OJFCxKQo8tt+zJevtJGux7DWdMtTd62GUrHLloWQXwIUJ3RDFRj5BxCajaQvLUARnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BMrLaHVwVp6rJZR8z9YuoRnOK+Ladu/w4LcQrw6/SY=;
 b=JZHd9MJPYSZ9SQHdpW5lmbjMNlMNKTTTeKxxJkCAEADHP6/gkCgss2NHr6SXqZDz9WX5qNyIkLh+YEuaTBV8KTJqT6vyC6vg9jh8F8dvYyI4FEEOL2BsIfEHocZ6IVpG7uyyZviP6J/nsMRzpX0GftJibMQp1ZgrrpM5Guzt9Y3DnrV0C7DrvykfY3biwWgF8aBGdvuM6g/erGGI3r6gnKus+/T6gj+yCe5CUusLa7ZMrMhCcr9uXgXcXwUbdx6OTvZkQn/k+KBn3EW9LWzhxdiMyY/2U2e2TPp8p5MsPI2DzBoGo8+3o225jVRW0xLEIGU6+3biROWsL+vCB5wOzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BMrLaHVwVp6rJZR8z9YuoRnOK+Ladu/w4LcQrw6/SY=;
 b=ecAiCtSKnHySaGxOcxwTogYlvCqal89IzuGrgjuSUO7Xgv/5cJ/FOsKcxkQR1AcP2BFOUuYnChEt07r3rZ4eICzNg+u86DHIHk1hVje42OSHvqkUeIMZyl5A+Y8SdoUaBu4T4SIaw29dpf6/PRoKuLDIvbzR3JL359rQ6HLUhOg=
Received: from DM6PR06CA0099.namprd06.prod.outlook.com (2603:10b6:5:336::32)
 by SJ5PPF665EE4E73.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::996) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 17:20:39 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:336:cafe::29) by DM6PR06CA0099.outlook.office365.com
 (2603:10b6:5:336::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 17:20:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 17:20:39 +0000
Received: from yunxiali-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 12:20:36 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: <Ramesh.Errabolu@amd.com>, <amd-gfx@lists.freedesktop.org>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH] drm/amdkfd: Avoid double-unpin of DOORBELL/MMIO BOs on free
Date: Thu, 4 Jun 2026 13:20:11 -0400
Message-ID: <20260604172011.1840130-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|SJ5PPF665EE4E73:EE_
X-MS-Office365-Filtering-Correlation-Id: c07446f0-7107-48fb-4506-08dec25d9947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: AfGvh87cHOQnMZ/yXDidxV4/mpMGKwZoSQ4OVJcTk27KMuBbC3vo7eTGS3/4Wa2T9NiZiv2M/AW7OBeRD90bSqa2O7H+LSICJR4h2p3Xw2qeFnPxQ1v870ONpikf8HBODx11lztUbxYiDFjF0AqD99yra5SKPK4ks/iOQizLU3ZshrPYXLZSaUivBsfG3SXudOUh2lXvPrSc74SXpFfNoCt5tvw8vGwo5Ke4MKqkii4KgPYpet7FNFmNhndakf3/Aw3SKIVK0emVEeodVoX5VQyHlfud1aQJL9OsyprG4eh8gKYGq9PM/061+q/dBdTFrZP0qbGaSQ0CcqB2wRA//CurdXH8EKYeoQJuPQPHvdS7phl6Lhn1RK0zssrWwBmjVYse1ce4fnlPt/vZaX5UbsGpB2UdvZOYJXIXZBfQiy682OGmiljkCMGI11MGG/FC+9Gp2ef98uNacqo9vzBfBcU8zDh7hL1/7/pWSw2BbEdpwZ1xcpKyLL4mzSCR+18ySdcUd/Q+m/yude0KbJC+tnnhHTQNWdJrzOrk2O7aMO8niJtiis6rKR1co6NbNKah6gm6Nr/e5966uTATxhlRT4x5DX/dvyGkgJWNgX9aUOOzBIAqIwAXLt5ZVTKoqHuyBKJkTV6tbOwK/AeIPGQwGyRRP5ykWX8+L7BenIJmY77g0mFGHQuZ7rlkKTXl5EN4TBQ8QUdezOR2l9oCTne4XC53l7h5DuGYCgp6stWj5po=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(6133799003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U9z9+t97qQVOd4p3sFyvJNMvtSzCjyHo6NAJv/LdNtIP0+SBiIPoCIf6FOLVleT5d7jgLXRbd9dENNx6KaJJxZVDXyz2I6VWam2SgCUY2WUaVK881U3pTMVOkOkceve81BCGOoCjfhB69kgBkWZ0nyT+MXR2j7c6c0bvEDa8cPWFEg596bOofl1byv+ROF74NI624rRLSSVtOlVVi+uPYsPd+U1NltEZcPNrfORdUTtzNV8nrBXzHEGSNBXQjTodRfKTNnltDFezo20NpPluolkXMtmBdFpeUbURdLW39xoBHDR3r3pRec2k9ejFMVy6AuDXsMIvCxW/fiHbXdiqFfp2ApyFHk74gHzZkewkLmYyRfDq1CRTb/esvkQ+nkmyd4VwahUZPg8B0YO8cW+qk3FcJqkA7C0OBbn8IGTLEREX1gK7luSZqD4cDfpKbCkm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 17:20:39.1887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c07446f0-7107-48fb-4506-08dec25d9947
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF665EE4E73
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

amdgpu_amdkfd_gpuvm_free_memory_of_gpu() unpinned DOORBELL and MMIO
remap BOs (which are pinned at allocation time) before checking whether
the BO is still mapped to the GPU. When the BO is still mapped, the
function returns -EBUSY and leaves the BO alive, but it has already
been unpinned. The BO is then unpinned again when it is finally freed
during process teardown, triggering a ttm_bo_unpin() underflow warning:

  WARNING: CPU: 18 PID: 15066 at ttm/ttm_bo.c:650 amdttm_bo_unpin+0x6d/0x80 [amdttm]
  Workqueue: kfd_process_wq kfd_process_wq_release [amdgpu]
  RIP: 0010:amdttm_bo_unpin+0x6d/0x80 [amdttm]
  Call Trace:
   amdgpu_bo_unpin+0x1a/0x90 [amdgpu]
   amdgpu_amdkfd_gpuvm_unpin_bo+0x31/0xb0 [amdgpu]
   amdgpu_amdkfd_gpuvm_free_memory_of_gpu+0x3bf/0x460 [amdgpu]
   kfd_process_free_outstanding_kfd_bos+0xd4/0x170 [amdgpu]
   kfd_process_wq_release+0x109/0x1b0 [amdgpu]
   process_one_work+0x1e2/0x3b0
   worker_thread+0x50/0x3a0
   kthread+0xdd/0x100
   ret_from_fork+0x29/0x50

Move the unpin after the mapped_to_gpu_memory check so it only happens
once we are committed to freeing the BO.

Fixes: d25e35bc26c3 ("drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT  domain")
Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 7c01492e69ddd..5bb3e28441a5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1914,13 +1914,6 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 
 	mutex_lock(&mem->lock);
 
-	/* Unpin MMIO/DOORBELL BO's that were pinned during allocation */
-	if (mem->alloc_flags &
-	    (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
-	     KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
-		amdgpu_amdkfd_gpuvm_unpin_bo(mem->bo);
-	}
-
 	mapped_to_gpu_memory = mem->mapped_to_gpu_memory;
 	is_imported = mem->is_imported;
 	mutex_unlock(&mem->lock);
@@ -1934,6 +1927,15 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 		return -EBUSY;
 	}
 
+	/* At this point the BO is guaranteed to be freed, so unpin the
+	 * MMIO/DOORBELL BOs that were pinned during allocation.
+	 */
+	if (mem->alloc_flags &
+	    (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
+	     KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
+		amdgpu_amdkfd_gpuvm_unpin_bo(mem->bo);
+	}
+
 	/* Make sure restore workers don't access the BO any more */
 	mutex_lock(&process_info->lock);
 	if (!list_empty(&mem->validate_list))
-- 
2.51.2

