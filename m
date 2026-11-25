Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36D5606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CRRDYHy/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57CF710E292;
	Wed, 25 Nov 2026 09:04:29 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012012.outbound.protection.outlook.com
 [40.93.195.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE19D10E292
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 09:04:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0pBdnxzNfKwADQ3Hyu506eQtaOqXPvc2JWpv6UXRDjHs8NfyuBsbjJgyMohpc2HP4qPvHgwelSMLWvWgJRvaUqfgY5WNf9vOkstEo/Vnd19hOrOt8dlAQKKnae5IF/Yz3ZKLtKsOQiHLtSwy9Z7AktQ/jrfNw2MhDkto1275QuL3817IVy7qLJABsCjYxsOvWts0LdNrMQ39flG7nI1mgA9DJCO6Vx/2PXYHlYsyuoJtuenL2BJ7aX/PNLFW/EYEWq8+eEf3ynNy4MX6kRAXenz33N0x5zybLTijjQTGGoCEN4IcJ7Ewe5aWSEsequplgzbL+jBx/sGlCh8TzZ93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4ke7itKfvH4WA2C8hZLBEzUlQKWZ80vm1/TT8/Kcuc=;
 b=VK4KPDAzIiA+PoOhhUN8/UR0VjojzU+qxfHdjw/XVkAmzz3l3y/KsFro9G46TQQbRr/GoM0ctXinYGn7+dMik9ov+SArtC4bAIbNmsL6YB0d89dsQr0MUdaZ50T/nJ+03rmm81+ewHd2/1O4ZB/K4c6BGGV7C0wVdozbjah1bHVgsy3NEtaTgzje6MUxt1JdFjzkQEP0GvFGrHjfzAyCZGVy+nBU7dUHKvEKAUXubrpWl6b5wZCBhzaGNRnHkF64axdYWDnM5eI1YP4qL+0ya+y18P+uNkD4HtdrxwWIicWlkmAhEpAsBbLivHbZFP407sx3Y7ivQOUAJiVfWXTqRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4ke7itKfvH4WA2C8hZLBEzUlQKWZ80vm1/TT8/Kcuc=;
 b=CRRDYHy/Cy8i4EgolORDU2hufmwmJf8UuoFCRqNv5NLjJdNqNKIuNstfVS/QMELOkdh/mwqvC1uFKVqpkuLTsAWloZ5ZTBImws6yFxq/eWemVEbDMzn4H/M/iL0zNdeps16JSfSlv4Kfl9YGnb3bqUTaNFoSr2HWuhCui8rAIZE=
Received: from PH7P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::14)
 by CH3PR12MB8306.namprd12.prod.outlook.com (2603:10b6:610:12c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 09:04:18 +0000
Received: from SJ1PEPF000037A3.namprd04.prod.outlook.com
 (2603:10b6:510:338:cafe::76) by PH7P223CA0022.outlook.office365.com
 (2603:10b6:510:338::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 09:04:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037A3.mail.protection.outlook.com (10.167.244.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 09:04:17 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 03:04:16 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 03:04:15 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu: unlink userptr bo_vas under the notifier_lock
Date: Wed, 25 Nov 2026 17:04:05 +0800
Message-ID: <20261125090415.3345401-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A3:EE_|CH3PR12MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: 36347b42-3ef5-4cbc-2a71-08df4ad315d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|6133799003|18002099003|261009223027099003|261021121427099003|261021123027099003|261102123227099003|261026121527099003|261022075727099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: zfyjqhFDz+kKKynq4ffFq3mzaSc4IlKd0otEeYP1NvZ/GiIwbQJ5bv5qewiwEAo3Rb7hVxW6hlz+VattHVoyg5XNJafwwMc02oI3XfFnr2sIN7P8iM1JZ1de4/xzouoeMXLjB3IZTRL5UhXokbBUpXuVzopME1uYp7vg2dQPUNLIklOeLI3kWa2f7EdMT9Eg8PjB2OVFo+Yz81WSKV77KPRfymNIbbLNWQTwxQmlN7d3h47tr63catDEk3YVb/d1zIOG0lvv7xeG4qYsFGiWkAldUShdqxbwIeoZGTlke4oX82+ZUfMxspR61Vyl12UFV7DL3Ua1MJf1FeThcu3DgaERJy6yv5YxJ3XkV7tuO8hwmuceIsSiSkYx+iUeSztiJIt95PGNduZts//TxeLQVcsYmn0hJnKeVQerLmLE6UuqexTj/va89dBezLfJi74Mdfov6yHP71bPEv6oNxWyttNCrywKgNedrMzBPu/xMANBsqtVZBhwUXCuY1uGjnetZKhIGrwDAIHXz8KW6j95pPZkhCZoFJ4rdo+dL5TKB/kFdCeSFvOmfUrjVK+wOe/gKYcKnkMmBXDd1jijEwE88jRenbCt9Eo4apUAownaKMJGrl7DD3IobfxDkAhAZ6qOpxsgH5J/KaxKSGlHtuL7jBBxNyXxzWMx6s+939zIfbik1/78F57oRUEDHhRhrj0HlyzchAN824t+DAS2h6w/Jg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(6133799003)(18002099003)(261009223027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261026121527099003)(261022075727099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YnDcVbTxVog4745+qyBgF5+O7z+xSrnXqzOQ8IJKZOAmRryKPuoKmp/atAU+2HXp8VsvXpjHhOFSCcaCnz0RpQe/bsLmqg4+KXhe8pKG7RpPlwO2ktxBJd7Q1gWjHMIBxMVyyaY+Kk6q84vEPnGtXBgtt9u/TyiSduTp/lPBlB3x/xwOLju7odZwH5JC74PxBC2G0SI6x3gzQlvSuMBD2zxHBIafdtEsvqKy+n0XY/KErGWHKroc8FdvsB6bcCQduguDsO7SAsaDcy2WKYIuEckVry8K+L7scTlOGk0ZS/f2NYGvadvFdMpr3tT1E63dKl0svCaan2oMq7/KJF/by3MAKl2QlWNPCieeDJstGWBphBhtgMIzaaDGOmJHjUwiRG/bBQjnsSAwKbVgzP4JyMpwTgaqPXZ6gktmcWerHo9zeFNSMOoxgScAzCpCsc7U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 09:04:17.3624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36347b42-3ef5-4cbc-2a71-08df4ad315d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8306
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

The userptr MMU notifier walks bo->vm_bo under notifier_lock, but
amdgpu_vm_bo_del() removes and frees entries with only the BO and VM
reservations held. Concurrent invalidation can access a freed bo_va.

On Navi48, racing userptr BO close with MADV_DONTNEED triggers:

  BUG: KASAN: slab-use-after-free in amdgpu_vm_bo_needs_update
   amdgpu_vm_bo_invalidate
   amdgpu_hmm_invalidate_gfx
   __mmu_notifier_invalidate_range_start
   zap_vma_range_batched
   madvise_vma_behavior

  Freed by:
   kfree
   amdgpu_vm_bo_del
   amdgpu_gem_object_close
   drm_gem_close_ioctl

Take notifier_lock when unlinking userptr bo_vas to serialize with
the notifier. Test for the task of the userptr rather than its address,
the GEM ioctl accepts a userptr at address 0 and registers the notifier
for it as well.

v2: check amdgpu_ttm_tt_get_usermm() instead of
    amdgpu_ttm_tt_is_userptr(), which is false for a userptr at
    address 0 (Sashiko)

Fixes: 1c824497d8ac ("drm/amdgpu: fix calling VM invalidation in amdgpu_hmm_invalidate_gfx")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ea8672451d98..5f9ed9cb18b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2279,10 +2279,18 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
 
 	if (bo) {
+		/*
+		 * The MMU notifier of a userptr walks bo->vm_bo under the
+		 * notifier_lock, it can't take the BO reservation.
+		 */
+		bool userptr = amdgpu_ttm_tt_get_usermm(bo->tbo.ttm);
+
 		dma_resv_assert_held(bo->tbo.base.resv);
 		if (amdgpu_vm_is_bo_always_valid(vm, bo))
 			ttm_bo_set_bulk_move(&bo->tbo, NULL);
 
+		if (userptr)
+			mutex_lock(&adev->notifier_lock);
 		for (base = &bo_va->base.bo->vm_bo; *base;
 		     base = &(*base)->next) {
 			if (*base != &bo_va->base)
@@ -2292,6 +2300,8 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 			*base = bo_va->base.next;
 			break;
 		}
+		if (userptr)
+			mutex_unlock(&adev->notifier_lock);
 	}
 
 	spin_lock(&vm->individual_lock);
-- 
2.50.1

