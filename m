Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A6AC87FDA
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 08:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38E4A10E4F1;
	Mon,  4 Aug 2025 08:41:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Cy61CJy";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4051C10E4F1
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 08:41:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNi9kny2iySN0QdPSAgNyUwsFzsIRvJEBp+kwWz5yQSCqZtwBo3+ZpOuWxgvz2ZpRsvjeuQMtgq9NjmM8FRUL2+fRUr38hP6LYKu3BwrlCDANDhYyPndE2GPJChPl1e9uoKKp3fgxiLvbOM6rJ+03LLGhSob1ZwOR7Tx7hIRUmc1SKuBaOs1qly/LQk04dRRD64H/QVCFSAhLWeVbd+uEUT1bwyVdidWXqL+0OG1rvQNjtSsd2BADHkOZxS4L2uPnUHoa/4iODMBQtkQtt+ei2cy+2MX2Am20vYPW2Ruci+3UNedhgaqIuW0HkF8X5MFcEhHeq32TUeqiAeWSfnuLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdsTfCHUNqZvyGaRYC+QBT9ccuJqZaVDZj/SQZksYVY=;
 b=IzRb5Srb+yZ1Klpq0sZx/ZmtQE4X1Eq8N1e2C2Rntf48y/5TEJq175cU7ZCtGmR40aubD1L265nI9DsvtnBwfxfruZHvum55M35YiPfAfdsYG6QBSvoRjwEApbDBVApGSBFxhnTMvyxWCicRx2tAysIFh4j5fS/col3d6v3/v2DYAhGMuVq5Eil4pcvPi8/VAtuoMAnLX/cFrGVdmFtYsoev/2bNZ/olWpyNGzk1IJ+hwi9ynDmxUmjAVYoE3W5OFCvmSd6+NSOseVL88b+YePOPStI+cXuAEmkdMruUaP/96NwjHDR92mudtmgMn5PqGxvzmVuAgMuXZkOceuZmEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdsTfCHUNqZvyGaRYC+QBT9ccuJqZaVDZj/SQZksYVY=;
 b=5Cy61CJynaMUKdboqxe/ZrgbdFJA/oZxjbTOAdkk/lxTG2LT5YkdNaXHBW6mqtHK8lcdzLU5R4dC5p5Zzh/SQgYnVo7m8L9HhoGNoGkJ9lRdSIdO81zfLXe6iHpEHEV3hyT9P6amOC0k/kg6LIeGYw0cHkwY/NlMb0tdXCp2Apw=
Received: from BL0PR02CA0033.namprd02.prod.outlook.com (2603:10b6:207:3c::46)
 by DS0PR12MB7533.namprd12.prod.outlook.com (2603:10b6:8:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 08:41:29 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::b5) by BL0PR02CA0033.outlook.office365.com
 (2603:10b6:207:3c::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Mon,
 4 Aug 2025 08:41:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 08:41:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 03:41:28 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 4 Aug 2025 03:41:22 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v6 11/13] drm/amdgpu/userq: add force completion helpers
Date: Mon, 4 Aug 2025 16:38:29 +0800
Message-ID: <20250804084029.863138-11-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250804084029.863138-1-Jesse.Zhang@amd.com>
References: <20250804084029.863138-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DS0PR12MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: e285875e-c116-4aaa-87cc-08ddd332b4fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wkKlioI7EHBVTAVg1XqGMCZ4smy8xobllocAkxnNsklGZ2IXdswfEXQBsGig?=
 =?us-ascii?Q?bISjVs8U+TstVm5QFUudqgPsRD2dyTKfz6+rOVmOC43KkNXdVoYDYUwAQwkN?=
 =?us-ascii?Q?QoPpSeYjsDsCRU4THlrSOR0eUGYkZsR2nrh35OT7eVC1oguHrHxbYo7Wf4eZ?=
 =?us-ascii?Q?uRIf/H3mLd4ot4nbC9r6LKS9GW0nbw67HE7HZhw+j1BOjurmb2dyxDn3UdMo?=
 =?us-ascii?Q?lZ3ZfCFiDXsK1TjkDbGsZmvyDLL7lcmHzluyt1H8a3vS0pu6nK0uFC+gRaBM?=
 =?us-ascii?Q?nx//6BxdGpZRc269rgAefHjNM02pfyErNfiCEwJcfkrp+pJ/S/4QvVrpaiiz?=
 =?us-ascii?Q?snfMoiVTCw7ifZmBNQHW+YuExl46zHIclP9rzMRH7xsz+ks4rUjXKyt3Ds1x?=
 =?us-ascii?Q?ERAernVZYFK/IC4Hhl1qWeAQGhg99DF2idHeaF56uDpqGuhtV1zOQAJJp4rM?=
 =?us-ascii?Q?xd0GPPEtHU5jIqcHLFTy3xZt1rYezT3ph4LqMjxjI2Nwu0wvpDLIHWWpTOfH?=
 =?us-ascii?Q?yeIxNRbX1bkO6aZAtI3pk2ekdad2oCIoIBq5M8qmFMYUtFTcUcAdgq/mWd+g?=
 =?us-ascii?Q?yCIErEWTpZvv780Spx2XN1KyW3bwNN5CCYK9zxmqtHt4Z1HRRktev0Cm7Fsl?=
 =?us-ascii?Q?YIuxLre0vsfbmCoAebhcnOlQ/Du1D+OsQG7KxSQhVYt8QTmS1iznVG7WYM5d?=
 =?us-ascii?Q?Q2YSFEA2bq3inTr+2aBwziUVl4R9Yb4Y3L9fRkgKxt4k+ISIYsRfq9gPDAUx?=
 =?us-ascii?Q?NodOZn+ndc/5q8ZK7UfHh5QaPKnVXbejAckeNGNRvMato9stmQqT64L4eubF?=
 =?us-ascii?Q?uJHPRVcTPbhpRJJh+SMFdzQezpxb0nBuahvF40x7f8Agn1jyOtrZZDXxjf69?=
 =?us-ascii?Q?OPNOO0Xbfe7a7ta3V57oQ4eV5JwfI7tkSSwERiAXlklqtsXIBdH4LL08X0gT?=
 =?us-ascii?Q?zIQKsROzXifP8VQJ/KuAZDN97B0UuKVQ3Rfq1Z+4/48NltDZoH8VKtU2qo8H?=
 =?us-ascii?Q?B/p1sWAkRbqk3fas5HvrHbvxiIMM4dhnagLolyOCNoh8LnaHDXvPNp6oFrd/?=
 =?us-ascii?Q?/K69Ed/25PKQpXkWraXDDVpzQEDpZ+hB08Q1JKC2oAwBVvCZpasA6GAwUasC?=
 =?us-ascii?Q?ErSXlTiMh+gyA/ycdkhy0AD9YgwQjW/7dkUkkUIRMpKk15/8AB0smRZXyHBQ?=
 =?us-ascii?Q?7gUPevNyXsJmNHTSD3PapLmw+LNSuAGKUH9MbOfYRrnPEFdfgfhBW2U+zWgG?=
 =?us-ascii?Q?hyAIIHYcJR5WrLfLGym73gtJKT7q99EU8mhwzg1o8k2gdYw9I2ZQ5+YCrRG9?=
 =?us-ascii?Q?TC/XFfXTfvyNt2yeAwmIHzlESlWhIgTLfFRY0aVsiHzjN10/xZnuI5nwxiYl?=
 =?us-ascii?Q?utEr4tFQbqXCunQPkz6z0xwmquCn+ea7LKqVaxWP3ggZ7oIsn0gNEJobmhUm?=
 =?us-ascii?Q?8FQY4ph2FMW87x9p12xq0wC1u/zHJN3Tm4UkT/0hy36ucX0xLHGhZWOO/OrQ?=
 =?us-ascii?Q?BSjyu4lFRbnuokBjFF2CZ5KogJ4OZkuuViiV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 08:41:29.4447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e285875e-c116-4aaa-87cc-08ddd332b4fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7533
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

From: Alex Deucher <alexander.deucher@amd.com>

Add support for forcing completion of userq fences.
This is needed for userq resets and asic resets so that we
can set the error on the fence and force completion.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 42 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  1 +
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a86616c6deef..01688bbf3f56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -67,6 +67,14 @@ static u64 amdgpu_userq_fence_read(struct amdgpu_userq_fence_driver *fence_drv)
 	return le64_to_cpu(*fence_drv->cpu_addr);
 }
 
+static void
+amdgpu_userq_fence_write(struct amdgpu_userq_fence_driver *fence_drv,
+			 u64 seq)
+{
+	if (fence_drv->cpu_addr)
+		*fence_drv->cpu_addr = cpu_to_le64(seq);
+}
+
 int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq)
 {
@@ -409,6 +417,40 @@ static void amdgpu_userq_fence_cleanup(struct dma_fence *fence)
 	dma_fence_put(fence);
 }
 
+static void
+amdgpu_userq_fence_driver_set_error(struct amdgpu_userq_fence *fence,
+				    int error)
+{
+	struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
+	unsigned long flags;
+	struct dma_fence *f;
+
+	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
+
+	f = rcu_dereference_protected(&fence->base,
+				      lockdep_is_held(&fence_drv->fence_list_lock));
+	if (f && !dma_fence_is_signaled_locked(f))
+		dma_fence_set_error(f, error);
+	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
+}
+
+void
+amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq)
+{
+	struct dma_fence *f = userq->last_fence;
+
+	if (f) {
+		struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
+		struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
+		u64 wptr = fence->base.seqno;
+
+		amdgpu_userq_fence_driver_set_error(fence, -ECANCELED);
+		amdgpu_userq_fence_write(fence_drv, wptr);
+		amdgpu_userq_fence_driver_process(fence_drv);
+
+	}
+}
+
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index 97a125ab8a78..d76add2afc77 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -67,6 +67,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
+void amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_destroy(struct kref *ref);
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp);
-- 
2.49.0

