Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95186C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 01:40:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21F641125B8;
	Wed,  1 Jun 2022 01:40:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EA4F112593
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 01:40:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+3QGEFhR0NImmRaX4JBSdoxvWJd4qDLm/i7mlvw9nxNI/rPzDLw1m7aPUN26k1zG02HJDJQcgGhuVmMRNp7thyHvsAVFTsnQQFRkNs1MhyiGRalpfFtvRp/IiCqdvKqzCVuKK1FGW3biD5biIH4CL0P1ZObvM2FtRnKooLTm5S9swFami19arl9o91XGmuUyDbgE5TzU9ON6dyzIxIqnVCuBPuWT6MWfejn9iiWV8/tJXxQUL7mzy8V+6pOxqD/a2T8qtjEYzVGU48YqpSyUXbwmfGSS1pmLBOw1avEAWXsq2CblIyA1jGwgMccKnc4Igczjls53Skz9CkK1Ot6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRq8Y/1QkO+3O4d9WsJS6IW//W2vPCMCM/jNBUJfcQc=;
 b=MpwsyRJpRQOfOsFVWxgzb9VUae7fuBIa7lo+DPgDbbSB0tGnyN3zl3Z7C67Rj9SEBKKcTzZyL13+I1kidhkyIh00OY3YShkqOfPeDn5Vt8LxobwWDS+TN40dbj81nxw7+cAF40YGAiS9GDo3lHhMSF+HwFzw7cYuCFW6fu9Twx5jbNhHnWgh2Of7zwqpTLzyOxN4Z/k8W/lsLPCsxdjHVgIbhwmZFBKScX4Z+pWyWEThtFGNCXy4ixgYHfxc2amKsZ5SMEPzUGzIAbPge0HaoT4cUbq5j+3JHEwaRvD4t7NTY/UjXdq3fd6Z+enNCaVLbx6rkBNHAv6/MAMcSuw2Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRq8Y/1QkO+3O4d9WsJS6IW//W2vPCMCM/jNBUJfcQc=;
 b=UEZoUp1M9aKfwn4TK1DvNSUi5h6SzDncnZ5QIZajPEE81i90EVpL45kd7Yka/AYdm4//qu2JYDGhu439/fE2nO/y9pFBT+eSeGdIMUkmFUgsBX5HE256EKSaHhL7kKp229BUFrqfMAUFooDyTatQMQKUSLBxDJg7df+RpYUhPn4=
Received: from MW2PR16CA0048.namprd16.prod.outlook.com (2603:10b6:907:1::25)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 01:40:05 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::e7) by MW2PR16CA0048.outlook.office365.com
 (2603:10b6:907:1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Wed, 1 Jun 2022 01:40:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 01:40:04 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 31 May
 2022 20:40:02 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: add pinned BOs to kfd_bo_list
Date: Wed, 1 Jun 2022 09:39:48 +0800
Message-ID: <20220601013948.1689628-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72fd1247-78dc-431f-60a0-08da436fa721
X-MS-TrafficTypeDiagnostic: CH2PR12MB4040:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB404093F8B6BF9E7703A71893FBDF9@CH2PR12MB4040.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hlpQyu5Dj4NHk3XHr4C8y4T4Fpf/8C3Ern5ARRCr10Q+87qBZoKFIQw53VoGRyf1PG5QRZBDp7ehBAZumDBW9rcYkiF1WOPRjlSe4f2x9HXR8knc/A5y1r27hPlog4V+sMRy4Tav9RpMu5PpnTfiC8DjzbDP57fxyNXrbqA6NhwHQYwK+wk8qED2jdbQrAriOkflkKU2GZFy/xDke3ZM3+vv3mv1HOFZxnaynow1qswJIoa0H7pE4+Ver2ePkkL7XopFFG0CttjWpSOVcpThz+PxhZ159xnrvXritJ1HCA1UjZuqrRek9neDGFZ9k+Ez8Kmh5D3Pg6z+W9Cc3fpqWq812j+tiPE3xgYbqy0l5UaJZwB9rPBlPJv+Epnx8dG5GRpFkIwAIkBhgSlMXhDufLU+qpiN3VNCxo2m7INlwL+Re+G/S1uy2FnFUhlc0GJ2N4d5ZG7jClREh3CiSknwXLpQaf/SGfMBwUkzDgMsymzX0LtPN7S2W5ddpLKVeXymB0G44NjojCjlnJ69puyBUerGmFqlqFisdF52vAJsQ5RwebjrRjvls3zLyaSRW3EDCb7Ltbt7fTiZnc1/+zOMPpvjr81P1uwuR5XTVYiDk7y6mCYcflaKbRUcy2vkUaFcp7lU7OgHC7wVAadgTVrwL42PihpeJ8pGBKIZ4yTpmLSLjBiZqwZYxIdVq2wMOFu6yU5TaMUxR7/zF2seq0KDGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(40460700003)(186003)(8936002)(16526019)(426003)(36756003)(47076005)(336012)(7696005)(70206006)(83380400001)(70586007)(4326008)(86362001)(1076003)(54906003)(6916009)(26005)(8676002)(316002)(5660300002)(82310400005)(356005)(2616005)(36860700001)(81166007)(508600001)(6666004)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 01:40:04.9041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72fd1247-78dc-431f-60a0-08da436fa721
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang
 Rui <ray.huang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The kfd_bo_list is used to restore process BOs after
evictions. As page tables could be destroyed during
evictions, we should also update pinned BOs' page tables
during restoring to make sure they are valid.

So for pinned BOs,
1, Validating them and update their page tables.
2, Don't add eviction fence for them.

v2:
 - Don't handle pinned ones specially in BO validation.(Felix)

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 34ba9e776521..054e4a76ae2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1953,9 +1953,6 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
 		return -EINVAL;
 	}
 
-	/* delete kgd_mem from kfd_bo_list to avoid re-validating
-	 * this BO in BO's restoring after eviction.
-	 */
 	mutex_lock(&mem->process_info->lock);
 
 	ret = amdgpu_bo_reserve(bo, true);
@@ -1978,7 +1975,6 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
 
 	amdgpu_amdkfd_remove_eviction_fence(
 		bo, mem->process_info->eviction_fence);
-	list_del_init(&mem->validate_list.head);
 
 	if (size)
 		*size = amdgpu_bo_size(bo);
@@ -2542,12 +2538,15 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 	process_info->eviction_fence = new_fence;
 	*ef = dma_fence_get(&new_fence->base);
 
-	/* Attach new eviction fence to all BOs */
+	/* Attach new eviction fence to all BOs except pinned ones */
 	list_for_each_entry(mem, &process_info->kfd_bo_list,
-		validate_list.head)
+		validate_list.head) {
+		if (mem->bo->tbo.pin_count)
+			continue;
+
 		amdgpu_bo_fence(mem->bo,
 			&process_info->eviction_fence->base, true);
-
+	}
 	/* Attach eviction fence to PD / PT BOs */
 	list_for_each_entry(peer_vm, &process_info->vm_list_head,
 			    vm_list_node) {
-- 
2.25.1

