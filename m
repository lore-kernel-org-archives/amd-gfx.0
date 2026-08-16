Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9741C5DF6D
	for <amd-gfx@archiver.kernel.org>; Sun, 16 Aug 2026 17:26:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80AF310E332;
	Sun, 16 Aug 2026 17:26:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fn8j21B5";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A74110E332
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Aug 2026 17:26:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KpULixzk2idZDMusMv+yesvx75EcW3Q9aaFqurF6ImyRyhV8BN1INcfSEarYIBxYwd1065u8BhgslV2oHZZAdbLsPMEcZdXljrFwQRxHrsFSeiyQjPNVbHzrvoGR9ZDthf0M6jsY1C60LFftjdCE+UGkmZkx6vxULnKoAZTU9z4L+l/nZCf/V0EgpA6FrEEQRAisdakVz638Wwob26g6YJI5ZsPdMXN/JhEdI+ty5BIjAzaGiiX+UyhZpzC4ypF8BuBl3SIPAuwCV/r/gxdBO+tUw644fBzcLi5UtxRfe6m+co+reKJdfjNzbsghbxtimyuWRIBGaNnghp6wwEULpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6LjGh3/Tb+jXtvEOal6cSn6/SJo/eq2wBqPXa2KFaM=;
 b=MebE1e34Hqa7xfK/IoPgAyqf5+8P/j+T0/RqZe0P7nMM0AaFbVKWYSxcnQdNH3wBJlJS5gbxjWgQ887DTw2EHUzxgBZDKauVgIUsQ1T6z6vT0enO1s4cF63Qc5xFAfquzTnC1Ug0KQIWIidlsju9/AchM9511xKt3LthvOZvI3C9tZ0cUMA56t0Ck5KSSD4qXOIchN/4zSjIxRegO8094e8AhyjBzJFOFrvHNfE5CDPBA4DbdIu4F0Xjd8+0JQ3QuV+pMljkZtpa+PDTaTe233EY8epSzK6GzyGYuCi+2rvd3AL8B2yOqlY5O3Zn6TvUfy/xkJELAQv02XipHHEVrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6LjGh3/Tb+jXtvEOal6cSn6/SJo/eq2wBqPXa2KFaM=;
 b=fn8j21B5lDze+Z9hrRfsyxcbzAmmgrIChWZQZEx0WXwIaJ+QqFTCcj2jyIccbOcL09bXyTM3WqI85Wd/vpX1wj1fYphePvq3cKFRJa5TGTJejw6R4UFZ8CeKdUwlzcFWQ1DnudwkY3aNdzFa7l16zvTAgyVVc6Ug1ULICz+qZKU=
Received: from BL1PR13CA0239.namprd13.prod.outlook.com (2603:10b6:208:2bf::34)
 by SJ2PR12MB8954.namprd12.prod.outlook.com (2603:10b6:a03:541::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 17:26:22 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::13) by BL1PR13CA0239.outlook.office365.com
 (2603:10b6:208:2bf::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Sun, 16
 Aug 2026 17:26:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Sun, 16 Aug 2026 17:26:21 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 16 Aug
 2026 12:26:20 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Sun, 16 Aug 2026 12:26:12 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Sunil.Khatri@amd.com>, <Felix.Kuehling@amd.com>, <Shaoyun.Liu@amd.com>,
 <Lijo.Lazar@amd.com>, <Mario.Limonciello@amd.com>, <Christian.Koenig@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v4 1/1] drm/amdkfd: Add TLB flush after MES queue
 eviction/suspension
Date: Sun, 16 Aug 2026 22:56:08 +0530
Message-ID: <20260816172608.14470-2-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260816172608.14470-1-Priya.Hosur@amd.com>
References: <20260816172608.14470-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SJ2PR12MB8954:EE_
X-MS-Office365-Filtering-Correlation-Id: 935af985-8823-41d7-f696-08defbbb7d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SLeIwPXES04JNDLDn+zMnh5G390iKFK7+ARtECAMT/3kBX8qts4exEV6Ru1VTRSct6lqb6qk2HmFSTs53XKhgj/6huFxXPyz5va9sWFjs4sRrD9TWQL2JdxTU71Za51jqFbgrz8RLhGmwop3rY0SpvtMgEjhFuKD6yrc5in3QlaCupJKbrCVq/1seL22rfYKRcesJ34gU75yHqIj3qME/Hf3Ol9A2U1wx+hr+LxqScX+0MvHPenMLy5VWeuxO4smKnivWdS4GoIm+aWmojibTSKO7SG5ms1YoZF4W1g9qaLiIWKQF9JM7bFtiXLoqm02xWBmxt8erHsk2Lp9tl3HifpYQK9NOUt4sPVACKwV9LtatQwzIZLFbQNIGOe0Gi6E8S7hXekJpl2ThXnUlWLa2wFitjOdIND2c7dHefL4IHrQh3MaJFkCIdzd0IvqNOApC/LuBxw5uF8BogUUO3qeKR/60UNWNBv3CqowOWVl40p46zY6GXdQiXDonNlk4tCSS6XE/TUpudiA/Sr4hcotBKD0njmpud/RsJpuyH24X86VjB7SdD3Wz/vWsQunMkPQePRdWLBwo1LPRA6wpR2EBXxJQLxnK19tnsFcc+x0k7Wv6gu9xuBOQ5XRhTTxyfMOT2LToby1NqZhgPbjoQ1bE2fNXpVzF5vYBQfIReWhADaUIugvL3QZmE3naubaYigWcLBZP4WjC9vf5tij2tX8Kg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C8f/E2U/yymox1zYI1Qn0fEynSEJDopeGUwevZEkNaFT3GRlHRXvsu9Dx7Wiqhzy8h9oz+Mdl+DHH6sfHtg4NvqAEvbOnaTyTHBhxrBNsHL2/dclqpJXvxzflfN1doO7B1EauU7o5GpEecUJf782MKMeZRGibQq95rxHtVyXe8SiaRoKPqIVnC9W5nqigIqT+OYSMKAMwQ2VAWS0ZxqSHG1lRq+qlfYj32cslryBTtRHGeRaKtBinqkbaXbY58/yiVObKiBGSQFoHSscK8cMJjRCGwiwEm3qyIKwzVoHdYh97vSxMgsJP5VlFhqBCx0mvYd87rjFjFuKpswesm4wcpIi5GQhDcweJuO6E5E6rQCBN6FaXb5+bH6WxKrnYyHFqPZDioU1EQZJ927QIOX+2iYH3kaZa2Fq2NneWLLM2Ms8FZtxkVGsmGkpag1OkBFv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 17:26:21.1615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 935af985-8823-41d7-f696-08defbbb7d40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8954
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

MES (Micro Engine Scheduler) does not perform heavy-weight TLB
invalidation after unmapping queues, unlike HWS which does this
automatically. This causes a race condition where in-flight DMA
descriptors can access memory that has been unmapped, leading to page
faults and GPU queue hangs during SVM page migration.

The issue manifests as KFDSVMRangeTest.MultiThreadMigrationTest
failures on gfx1151 (Strix Point) with XNACK mode 1 enabled - the GPU
compute queue hangs with packets submitted but never consumed.

Add kfd_flush_tlb() calls after MES queue removal in two locations:
- evict_process_queues_cpsch(): after all queues removed during eviction
- suspend_queues(): after debug/criu queue suspension (with mem_fence barrier)

This ensures all in-flight memory accesses from unmapped queues are
flushed before memory is freed or migrated.

Change-Id: Iaa884d4a7ad1199446bc45f4ad8a9a179ab386e6
Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c   | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index a23384571193..6002c8a65fbe 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1450,6 +1450,14 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 		dqm_evict_mqd_bo(dqm, q);
 	}
 
+	/*
+	 * Heavy-weight TLB flush after MES removes queues to ensure
+	 * in-flight memory accesses complete before memory is freed/migrated.
+	 * HWS does this automatically, MES does not.
+	 */
+	if (dqm->dev->kfd->shared_resources.enable_mes)
+		kfd_flush_tlb(pdd);
+
 	if (!dqm->dev->kfd->shared_resources.enable_mes) {
 		pdd->last_evict_timestamp = get_jiffies_64();
 		retval = execute_queues_cpsch(dqm,
@@ -3736,8 +3744,11 @@ int suspend_queues(struct kfd_process *p,
 		if (!per_device_suspended) {
 			dqm_unlock(dqm);
 			mutex_unlock(&p->event_mutex);
-			if (total_suspended)
+			if (total_suspended) {
 				amdgpu_amdkfd_debug_mem_fence(dqm->dev->adev);
+				/* Heavy-weight TLB flush after MES suspends queues */
+				kfd_flush_tlb(pdd);
+			}
 			continue;
 		}
 
-- 
2.43.0
