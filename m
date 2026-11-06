Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B38606A329
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LADRSMKq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E71810E92B;
	Fri,  6 Nov 2026 15:52:51 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8623C10E92B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 15:52:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrJpYiXKcIncrYsZ48EOl5+CF9thWtmqw8YzyUuK2YLOyxhMEkxvPsrPDvCn6dZku0vfJXNqz93pCSg7oGyBWaTaLjIxsFg/qvt4Ok54e6XAfKSyGihJ3llWtKYNu/ocF8cavLRIMm3wvm5UFlTTow0zMsGrXoHdy7Z+sBOLXoxUvRG2BpLigWGIPAJ8lsAomzL1ukejYaAw1SymlRCeofEE/8ow45nYCoV41G/sc1/grclnoIyGcTnI7Tpy1RTMzH0CIrntCVWWAgbZHHNzLQy+1UPOKCFFG+Cq4HDPmHOjZhqNS3KYjuyFPbMJe6CTGBTTJJzjlueIhQxOqtZqcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPCh/vIfQBdO5xUYGdCQAwFtMnt4lDX1H/gVG3piQEM=;
 b=qIIQdv4ZpKa8dIcoSbH+04tk25O8c0kX0IPG3RfVI0x1mQ8twjaUsegXDwOFXf//1ubLrdowvr2IEDe6DBKerkC66OUQnUfzjZhnI164vOXM5VULKr65CINcMaDwKxVJuekQvgX287mug7KNsQ96c6xllqA5Xyp3pVk81LHH+IlXg3NU2RhQWyu5arjvCVmHYzV91Ug4g5x+XpHpSyyk6bH7zE4HSaaz4p2eTXkOGVKWUzuzwF7uN6hPGaD7V7ltmb0YA14Y5hz+RMvgfRoaWHvTI5dX825Bp7s2cT/E7lZTtahftxfZIV1JNBZhdebiMucLlNodaeULcgC5MOCM3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPCh/vIfQBdO5xUYGdCQAwFtMnt4lDX1H/gVG3piQEM=;
 b=LADRSMKq2J23ZpTDHuOVllWfh5L4/whV+3HfhC9kuhQ7tXAOfnUjpQv/8dRJNUh+lZgb+Po3b2hYG/xMwo5tD92sTgsWK2AILrXywijAqnKRbkLF+xbA2NjYkOIXcMSKK/JCmrDBul0UmPt6dkP0Vk+BTnm7wSgCaJJbyD2MQ74=
Received: from MW4PR03CA0059.namprd03.prod.outlook.com (2603:10b6:303:8e::34)
 by SN7PR12MB6670.namprd12.prod.outlook.com (2603:10b6:806:26e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 15:52:39 +0000
Received: from MWH0EPF000D894E.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::9d) by MW4PR03CA0059.outlook.office365.com
 (2603:10b6:303:8e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 15:52:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000D894E.mail.protection.outlook.com (10.167.249.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 15:52:39 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 09:52:35 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 6 Nov 2026 09:52:35 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: reemit RLC SPM register in ring reemit
Date: Fri, 6 Nov 2026 10:52:19 -0500
Message-ID: <20261106155219.3329315-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106155219.3329315-1-alexander.deucher@amd.com>
References: <20261106155219.3329315-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894E:EE_|SN7PR12MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: be5e2a07-e891-4974-acf9-08df3c1dfc48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|22082099003|18002099003|6133799003|10067099003|11063799006|261026121527099003|261102123227099003|261021121427099003|261022075727099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: rSiC9tqdDiVYvHjo6KMxolw5uQX1zKXslNSKDYKDrwhxe/U6z1hKbWWBH1Rud9H1Zf+IJqhtOI94+CbFhsvD03Cxg0OOPaDT0BDVXKnaJhrZ9Zsyitz70f4S9AmqEZiHcMVpGEK+FvXQWdCGlK29RUxGhmzBaGa7KOaph9hh8Vv2v+3y1Zcy8L2aGs55f0+tNbJo9fyB4ixratDIn3O0Wxf415I1kSjAHMbgw2gsqSww8trZgi4HKK4wOu+1A71N7gPmkv5qDrl4yb08G/83mpf0L8OCEqhiQlqdd3k1gwl4k80T8dskWN2ZfXXimzvb1o6Artpz0gd/+eE6e6CLXS5Ccwbcrw26zHmvOqEMpSK26h+g1qe2xZ3ZT3V1Ffg8Kljbw5o3HP2bBICLxE5WWaSQLpbY3lHsYf/huOkDRkVXObk9qOgFkGHugGaPLUkD7H4RvIxWenzD7cY/Icmiil8CeHnd84iph7g2hYlUrcLlCsaPi6tMshMf4udb19e4xwRN+qod/z5nYuOtQs5Z1/iiMp2a1h/sttyCDPmBr+Ol1waKCtpMqBf509usz6gTgQle+djmrIbUPW2vQcFvbt//Pb+uFwrISAW4X47HIbqHaOFWCHUiOC3NAANZcrkN0MQBGNHt1YaS7KEkzLg9RROSP420rZC8n/8q/oV7rKBwVjIrFLYnTrgoADtMM0xLhBstXji4ZR/2brK7Eq8ajQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(10067099003)(11063799006)(261026121527099003)(261102123227099003)(261021121427099003)(261022075727099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4ygCDNcMqUlEu5t+k9X5VLbU7DkhHVA4oLbHFjl3OSnXbS6C+bNw1UbzTa3JlprI62PqPAPcPMzv0rN8g1b3s+yZaagr5pb1D4MD8+Bt9aFUqAO0uRNkRrT2kQio0ssXhu4aIuofkMwJN5iggjsmeew0s2Lx+edxTtwK+hc5VbZUxhtgr16scu1q9pFnhTdvYy9uOCZdtBi6PyzIlH71oGv63n6qgLIwIxLHPlQxieZSrvmc0ogtbF1qfR/9nlATb6ZMIqgye6huRKAzNKq9Kvo3q/0efd3jZB6e/sZGMbBCD4qtxMNONxgPxXbmanW5FXXe9AdGnQ310zy/W0mcRPo49e/4otya+UVZiKbLRB2/M+Jc4G/FLONHtomceKAJ3EQPDLmNyI/hRa677wTmfrR0bdPnevhEGnPPGdJYlHZsZQfukgXqWaV7miDbkQVC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 15:52:39.2899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be5e2a07-e891-4974-acf9-08df3c1dfc48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D894E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6670
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When we reemit the saved ring state after a reset, we need
to reemit the RLC SPM state as well since it's done via
MMIO.

Fixes: 2fb5a4572c76 ("drm/amdgpu: remove the now-redundant runtime SPM VMID update")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index c3f56253d3b87..324d25c77897a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -715,6 +715,9 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring,
 void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
 					     struct amdgpu_fence *guilty_fence)
 {
+	bool emit_spm_needed = ring->adev->gfx.rlc.funcs->update_spm_vmid &&
+		(ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
+		 ring->funcs->type == AMDGPU_RING_TYPE_GFX);
 	struct dma_fence *unprocessed;
 	struct dma_fence __rcu **ptr;
 	struct amdgpu_fence *fence;
@@ -746,6 +749,9 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
 	}
 	ring->reemit = true;
 	amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy);
+	if (emit_spm_needed)
+		ring->adev->gfx.rlc.funcs->update_spm_vmid(ring->adev, ring->xcc_id,
+							   ring->adev->vm_manager.spm_vmid);
 	spin_lock_irqsave(&ring->fence_drv.lock, flags);
 	do {
 		last_seq++;
-- 
2.56.0

