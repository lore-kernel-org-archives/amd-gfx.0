Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBA2606A331
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 09:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TvSwnRec
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6736112235;
	Thu, 19 Nov 2026 09:57:06 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010001.outbound.protection.outlook.com [52.101.201.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCEC2112250
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 09:57:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjbZP/XFewoE7zkLbsxEkO2cGSSdFVEHvIwBAUoFmVXloBcnCrrNc4Of3Kzg3Cauz74ekhBPzT60kBsk//sEetFaF6907z8H/MTEBYV4G/oSwJV6CTLF81V6fsMpnuHJfESlde25mv/MtZzg4WLJt93eBpzyG/odOsVknMyOWivvE130HDCh4Px4LDCA9AOou2BVtIXguJEnieZIoJ9y7kcbu0QDpsG9hLnv5trbSxZHAZj6RDvvNUPFgOI2XQR76wgDIKG+vOBMdPUFlrvKEr+y5N4ZGOakKCeGuhi52F9dujt94BwJoDX8FtmVtDjAK4zXdU/HH/C2d/nih4zEhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIYMcG7+rQFBN7l4nOPB2ndwntqwKTISCFUkboHXhH0=;
 b=mNT19dq/aZjjfZlvuZkmy3kqLMrH3qTgvzhBGFVmgoknwmTfyFGACTtouqbWeNw8YpEUyFxR2K6TjCaEkSchjElHBZXaVwj2CMSZBix3U6NnOmH/DkRPI1I8dDDqDPrr94E0frvcmcskeGebNKISvRVPggLhwgioD3g0VNsD6jospQbrZQGcCgum7R4CRGNhRt7kjqdSOZYDvNRvBwbeEMaTN2jLw0D8k6mjLih5+Lqa66jrgjNUOJzOj7dO2PBojBb2qJGdHeLCbnjjEy2bIKJ4n8yPj8biIp0EHSwl42Wos7uAM1bT3tOCTYJ0CeUNcJJzUtEezh5l8Sz/pfNHAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIYMcG7+rQFBN7l4nOPB2ndwntqwKTISCFUkboHXhH0=;
 b=TvSwnRec7ZeTu6iIK/pbAfwLK3Vv/PwIS3Sk5fOryKODwFFoJ9X93bWPRsh51jRFNbMg4b64Zy+xjqINumuoKHpfDtFveJEtbpFJ8oAp28xYlTfJ46GvqVmfbWq3fisfPe3nZiuLgAjMEVz/q+t3yAJKo88lO9ekek6JBMfCXJY=
Received: from DS3P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:45f::15) by
 SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 09:56:56 +0000
Received: from DS2PEPF00007109.namprd05.prod.outlook.com
 (2603:10b6:8:45f:cafe::7c) by DS3P220CA0010.outlook.office365.com
 (2603:10b6:8:45f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 09:56:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00007109.mail.protection.outlook.com (10.167.23.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 09:56:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 03:56:55 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 03:56:54 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 03:56:53 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Sunil Khatri <sunil.khatri@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: reserve a fence slot before adding the
 eviction fence
Date: Thu, 19 Nov 2026 17:56:43 +0800
Message-ID: <20261119095652.3510341-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00007109:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f790a5-f846-4984-6bc5-08df462371e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|18002099003|261009223027099003|6133799003|11063799006|261026121527099003|261026140227099003|56012099006|261021123027099003|10067099003|261022105027099003|261021121427099003|261028144727099003|261022075727099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: iSbESOyn60HuhvKb8xyi6EmdbcCEF3e0nSLi07CGK15J9eIv3TVT2BhConI70x4MAIY5WpMFSlOumrFaoINv1ikbiPtE894lKrllDy4DHYOycCpMIzMjaetOwIQ/vIGHzKQAr/5AyDIRdlrSJPkg5Tci+b7h7QW409Jz0xID7kteF1+Tlq89+JI/RVnjvXA51lZDmJtZKxAugCYsQbqpdeps8Sw0LcIMZoyjeZH2a9a9sS9s6OsPZ00GdX71iH04L7Nm4N0xc2NXswO5ZMcv058oMyTkJotA3ZTM9VUnEkBgu0JaVwGPzLkZeSBHPmhyK14tavEFeehL5NcKV4b6ZgGkyfxW3gOanEVKTRxjg4ZwZaldsubJY6W1khnM47us92l0HH0O/DKSowjphaK/++CMzimdEjTvgt6S2fkdxCNtYRRVlAISOKXSl81YI14SqiL+Byw/Jf1cfhSJ77gnFQ/QV0QomhUO2z8rC/RY3FxijpV6ivJ2lI8aunfbGnHhpomQ7+tRYoevKx14gUsOd2MOrBp4vpr0Ev8jWyo5/p1+qGJ1aGwtVY00C/Kw50Ra/LxzdCBUh9pWC6H6n7t409lZEoBbkZa4pnkn+dPjzbu6++axN6su2vuR5BrJOQYvdBI/8fqyJafV2FCZPLg1zZ0aK47R+ISfEUGeqO329iPBLVtCQyrizj8Ps15Y/Y+QMGcKkGFJx92GIEVeAD5AVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(18002099003)(261009223027099003)(6133799003)(11063799006)(261026121527099003)(261026140227099003)(56012099006)(261021123027099003)(10067099003)(261022105027099003)(261021121427099003)(261028144727099003)(261022075727099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yUEezxvcxgvssUFL7vCt/mRpUaeilHshUJITNv3Eze7QmaQlyFDC3okjA8gzdA0zQTavrT4Ra1gDcw6PtS4wLFBf+R7PP34n4Bd5LVzL21CLeSHnVH3AQ3dkM58mWkPgYaoqKCvdnRKWXPfrQjriTrHJQ0kCJsaehlgpnOot0f6ThxTt4jACs6jCQQldOChNOfvxj8A8/G/eeni8LXTl+sLH1rUtoziWABVvw+gTbLNr9UU/QK1CSYTCOR0Di2l6TcCrMxkWY6VjHRdyhTdIlqyvTw42fWxSHPDyjcqZ3gZI1T3D4d9kBI1D8CCNMp7w62lFqG1BgshQSBPItgSC64Oek6fTGnUouaeybBl6++BESov3GgbPyf84+2cZiO2zEJyQoJKucUmhgi5iRjAawUK2bqhADs8qrXF0wRVWcTjOHzPm79GB0eVrMKr0qFKJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 09:56:55.7509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f790a5-f846-4984-6bc5-08df462371e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00007109.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313
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

After lock contention, drm_exec may retain a BO removed from the VM
during the retry. The BO misses caller-side fence reservation, but
rearm still attaches a fence to it. If validation needs no move, this
can trigger BUG_ON() in dma_resv_add_fence().

 kernel BUG at drivers/dma-buf/dma-resv.c:319!
      Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
      Workqueue: events_freezable amdgpu_userq_restore_worker [amdgpu]
      RIP: 0010:dma_resv_add_fence+0x833/0x920
       amdgpu_evf_mgr_attach_fence+0x2d3/0x4c0 [amdgpu]
       amdgpu_evf_mgr_rearm+0x279/0x370 [amdgpu]
       amdgpu_userq_vm_validate_and_restore_queue+0x166c/0x1dc0 [amdgpu]
       amdgpu_userq_restore_worker+0x6d/0x180 [amdgpu]

Reserve one slot before attaching the eviction fence.

Fixes: 2cd7284ba54b ("drm/amdgpu: completely rework eviction fence handling v2")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index f8652fd0525d..f01e08c4de4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -108,13 +108,21 @@ int amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
 
 		amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
 		ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-		if (!ret)
-			dma_resv_add_fence(resv, ev_fence,
-					   DMA_RESV_USAGE_BOOKKEEP);
+		if (ret)
+			goto out;
+
+		/* BOs prelocked by drm_exec may not have reserved fence slots. */
+		dma_resv_reserve_fences(resv, 1);
+		if (ret)
+			goto out;
+
+		dma_resv_add_fence(resv, ev_fence,
+				   DMA_RESV_USAGE_BOOKKEEP);
 	} else {
 		ret = 0;
 	}
 
+out:
 	dma_fence_put(ev_fence);
 	return ret;
 }
-- 
2.50.1

