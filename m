Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84080CC6B0E
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 08:25:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E50A10F5FE;
	Tue, 13 Oct 2026 08:25:39 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011071.outbound.protection.outlook.com
 [40.93.194.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53A5410F602
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 08:25:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBOaHlWzCy408YFeTCcXtJi+ti/yeIQgQksJ1XHcETWukRzeYhjerYRFNpneLAZOl0BhjNccTetT3R4AIYguQ08LfIFwmQkJmRhRA0tkruaOljUtn8I9lz4jU+EY3QKYCtq31VMGUoxyFr66XRBXUh9BMcJKBUsA4x7m+CMl3HsdY7hO96tzhGqiJgg3J5ujzuTYjqdbtWhrKykWg5XB7qsdtfuM4BIZYD7HPZtYLY71OODNsro10W1hCBD7hAHvNPLYmQ1VJsLZc5smBzt97PmBZisJxjpr6VkbCNWMdGO3aYD70p9oRAE1Cex0PpobvMR/ugnSyEiyAQSYp9ZhtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNitmcsapJnxtCGXHNRM6elbAPiF/slP1p/OHXQomSY=;
 b=JJRFOHD7WERNflIvxh3LsyhqgXE0PNOgllDwVv+o6/t87lPOLxPPFaKkteUAnd6ioan57Q3KtfVgS5/agEMH9/1AyRi5z8rCCt+KmrDZDnE+ChRfau0p0YL/4b5A0bbs2F0HIlX1sXQxeQru0cJjSRu+1L6Pla15kUuZ56uPSsBzl+W3FH/czPyiIY0iLUNM2qyQXr8iHr3pTzvpFseEi6GK8vCXtTY5x6+XB6zmDVYAuRjsoL0+SQbWDyT2Mp9bjGyaNOn4hZFqd+lBqGKZqTi/gAP9V5AmcxeIRw2VP09PSsbgkSR7+fbQhQ0yvp/rrLfc90PTX9RetA3LGNQi1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNitmcsapJnxtCGXHNRM6elbAPiF/slP1p/OHXQomSY=;
 b=xO2f4q1C/9MYohJeGyuBtDrNzvTdOZV4B6aS96YEMebgMAw+D6fri1e3Y2J4pRqxDXoq8gtA9gNTaOGTtJuDA/u/DPXBgpxor4Y+tk26vAgxhl5ZMWlafWs7MIw1aLOTj4Wj+APrJ9blu9fHk21kAdQJbujXT8zrOaAyvxDbAyA=
Received: from DS7PR05CA0058.namprd05.prod.outlook.com (2603:10b6:8:2f::11) by
 PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 08:25:26 +0000
Received: from DS1PEPF0005344F.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::47) by DS7PR05CA0058.outlook.office365.com
 (2603:10b6:8:2f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 08:25:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0005344F.mail.protection.outlook.com (10.167.23.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 08:25:25 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 03:25:14 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 7/9] drm/amdgpu/userq: take reset_domain->sem before
 userq_mutex in destroy
Date: Tue, 13 Oct 2026 16:24:55 +0800
Message-ID: <20261013082457.2492273-7-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013082457.2492273-1-Prike.Liang@amd.com>
References: <20261013082457.2492273-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0005344F:EE_|PH7PR12MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: 53bd9616-a0b9-4730-f5b8-08df290387f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|10067099003|261009223027099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: mMFhMBalYmz6FYfkpFG/cTRVqrmMUYViZXvKyodbcEI0uRWAOkhViK7IpIB7h802q8wUpYa+PqIIID/E4h6kXFjBMnzSgbHmPe2WvIjfRCQlCaAmV+ncvP/pYdsNd7L/IAykS/in85pckzO0GplJ7jyS1EE08ZQEAIsuhdSxyu4oRzhk7XoQLg5rmEPwzA6lwekhGtRlzAK1kDCgPK2Z4T/+0rUWmLe23Xgum5ci5nEc2nFyjwr9C1E+0xoyqzgO1nK2+b0rcrnVXp/DPzJ8XoQGt8SsEJlMf0Y12WcNcAIVvzPBrkvZpdfHI+qbfn3Bo3HEBlzATWfK20iYwWJom7EB4sBYe9yIF+D4q5ZcN6De2DiUhJ9c9at4V1etzKYD7ZNFcbQNRBYtVF5vsRjYZHp2756+J64sgZc4GvfObiT2tTX4pkk4b8WGLA4lDTKG0i9kVn3ztCOMNtDHKnZBUBPfjaszU2fqV219coQYaYx0ee97CBinLdwLdkji7k1VaTv+ZAKtkGM0gjxJ2Rl9ZRt6rl47+xf+UOC9C8zTt9iSgVhEtc9KMOGk+L+pKG/MFc28b6OqX4MJ5pyFscIX711YWG4eulZJToHXFXxq/Puspq+jnyJzFz8J6gEl1L96oYLKSdoZUT6rjq4Lrhg7YDV3noXzstn2YEKCSmS6BoSqzVGIcX2E3IACZ8uD700mTnEzT888dl8U3/mO5bd/aQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(10067099003)(261009223027099003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 52+s9sdfVIEPvbwABhCS2gOi1Yrc1AVxzI5SiaUbHXrn+ITbCyANZ/nd9Mjyyq9VD5yFMJuf0CBHievDeXTbsORKTmOqS7O4ONJQpeHd3W1aLjw8DShZJRA+e8wnyjF+ANkn65V6xx+VIdH2ZDdctDb5iHifJ+itfBToTVOHTLQ37RthWRoN40psNu2qi4x1PpWyOu3hgK48Q+eTK2sVF6leB+Q/tkhTLTcsoqO11qEflqQJPs3QZwu0Nze77Jnmyr1JVL24lX1xDPJrjLtFE6ldkpg1yOthmNIc356beYQFKBgWjUS1pNiy+qJtVWS2X4/aCaegfSKxF+Lc8cH9A86ifUSCvT2VsrsR18ASpZUgA85++UAiL9KZZc+EOi128PhToQaJVyB4MI5J0h1mA9Qll1fNWKyoI7pul9N4/yCHZ2p3H2RR6zHsRYYwKTMT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:25:25.1628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53bd9616-a0b9-4730-f5b8-08df290387f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0005344F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5806
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

amdgpu_userq_destroy() takes reset_domain->sem for read in
amdgpu_userq_detach_doorbell() while holding userq_mutex. GPU recovery
holds reset_domain->sem for write and then takes clientlist_mutex in
drm_client_dev_suspend(), which already depends on userq_mutex through
the fbdev reservation and userq restore paths. Lockdep reports:

  Chain exists of:
    &dev->clientlist_mutex --> &userq_mgr->userq_mutex --> &reset_domain->sem

Keep waiting for the last fence under userq_mutex only, as the fence of a
hung queue is only force-completed by the reset, then take
reset_domain->sem before re-acquiring userq_mutex for the doorbell
detach, unmap and fence driver teardown. This also keeps the MES unmap
from racing with an in-progress GPU reset.

Fixes: f18719ef4bb7 ("drm/amdgpu: Convert amdgpu userqueue management from IDR to XArray")
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 5fef0cc7703c..a34ea8ecd700 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -415,15 +415,6 @@ static void amdgpu_userq_wait_for_last_fence(struct amdgpu_usermode_queue *queue
 	dma_fence_wait(f, false);
 }
 
-static void amdgpu_userq_detach_doorbell(struct amdgpu_usermode_queue *queue)
-{
-	struct amdgpu_device *adev = queue->userq_mgr->adev;
-
-	down_read(&adev->reset_domain->sem);
-	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
-	up_read(&adev->reset_domain->sem);
-}
-
 /**
  * amdgpu_userq_ensure_ev_fence - ensure a valid, unsignaled eviction fence exists
  * @uq_mgr: the usermode queue manager for this process
@@ -547,8 +538,12 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 
 	mutex_lock(&uq_mgr->userq_mutex);
 	amdgpu_userq_wait_for_last_fence(queue);
+	mutex_unlock(&uq_mgr->userq_mutex);
 
-	amdgpu_userq_detach_doorbell(queue);
+	/* GPU recovery takes userq_mutex under reset_domain->sem, keep that order */
+	down_read(&adev->reset_domain->sem);
+	mutex_lock(&uq_mgr->userq_mutex);
+	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
 
 #if defined(CONFIG_DEBUG_FS)
 	debugfs_remove_recursive(queue->debugfs_queue);
@@ -558,6 +553,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	amdgpu_userq_fence_driver_free(queue);
 	queue->fence_drv = NULL;
 	mutex_unlock(&uq_mgr->userq_mutex);
+	up_read(&adev->reset_domain->sem);
 
 	/*
 	 * A failed unmap means MES could not remove the hung queue and is now
-- 
2.34.1

