Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37246606A320
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3MNNzFlj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E13E51124CE;
	Thu, 19 Nov 2026 14:41:19 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010063.outbound.protection.outlook.com
 [52.101.193.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3184B1124CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 14:41:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isb5oXxXb1BbsGhy8KE96JJUjNFgczz+utekhfzOYOYTIOT3Wdpg45ghIj0/DoVyle64Zv26wYLYrrhbZqWHlD+Wg4UZ0/k5MdteAp2DiSJDH5EtUZoHfjFM7qRILh0fRmN3bneICAyO1L1zNcSTFSR7rfd7JdYgM5on1p35ShpITNYS08yFYREYmz0aR3MI6YOErkfH/KSqV2WpgOm86mcqmgEUpvHp04/88fIuRTmUZOB9AOZc/UzVB3B4dSaoC8YpzfzaEcdXsHNSeO1YQI43GE6kQqsPym+3VQ/YN2+Ifr7yygNRxHPMFRJUNHzsrBVqhmy4sfvB41SORhVprw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czioEtVQ1iPMMCPgTvgHr1hOQXPRJILN9FiCey/AMOI=;
 b=RtkEJDS0/EklLfMph0+g2rk11fcLDGhzGh1xXhuURkwBA38cBCTpHGdpSph8y4sAShDyn5wBfF5urSD3KZL+eOtGPKoXZ0aReC0A8EmPwwL/fl2Avwf5fGMYgISL6zJhWeoE1L4S4x7muFf5qKX3ZBOC93UXA4tvoTTbcHlsRAsujwBVqQGQaBJroSMd5aetuR1wYuYx1NxYk8tx0Tt5q//m7+Y5ipTMf65KCzyRmfNqrvLmQzofkwow3T+xK6vJ/iKr//8l4zlf2Q3/841kIaFy6b+5cJgM5Cc6CQ6xtv6YFB349VpV5zdrccI55S9sATlqBkmKjF2IdMOIdGANEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czioEtVQ1iPMMCPgTvgHr1hOQXPRJILN9FiCey/AMOI=;
 b=3MNNzFlj3PbNVCQxtLfcCwtkm1OI53a7c6d8TJ5e98aeifx6ZHResp7kPmbpxtqnBsU2NdH4pSZ8LLJ3RETFQrX3uSsuaR9rNLqDPCt1ttPG0/xAay67bVD+HEgCrGLC1PHLk2EVSIo1pFiAbtQ6f59wGrsEY+GCkZ7hyiSG9tw=
Received: from CY5PR19CA0114.namprd19.prod.outlook.com (2603:10b6:930:64::7)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Thu, 19 Nov
 2026 14:41:05 +0000
Received: from PH3PEPF00059618.namprd05.prod.outlook.com
 (2603:10b6:930:64:cafe::6c) by CY5PR19CA0114.outlook.office365.com
 (2603:10b6:930:64::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 14:41:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH3PEPF00059618.mail.protection.outlook.com (10.167.243.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 14:41:05 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 08:41:03 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 08:41:02 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Shahyan
 Soltani" <shahyan.soltani@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v3 5/7] drm/amdgpu/vm: stop using amdgpu_bo_fence
Date: Thu, 19 Nov 2026 09:40:47 -0500
Message-ID: <20261119144049.2057674-5-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119144049.2057674-1-benjamin.cheng@amd.com>
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
 <20261119144049.2057674-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059618:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 024a9cd2-3f31-4ad1-a568-08df464b242b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|261102123227099003|10067099003|4143699003|11063799006|56012099006|261026140227099003|261021123027099003|261022105027099003|261021121427099003|261028144727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: K+KYp3UrjZXZDA0SK4zfBb9YK29LZysyxd7FqECf0b75hVF2oruck3KA5vjlY0WyZlIi/mMcFAP94xDLjN4iuHi0l88niR+9CV3mjpLTGLfA5ZV9QFTZLup/b+FMGgSZcRLY9bDSicy37qQqQvT7Jm9fRgyeQh3pJn6TMuLYnLmHkqfN41emjPeDbRNJj/ndsiP03lmtsFo4wH7vxy5qVM8do3PwgoHxeIqu7jCD5tcBoZCvXaSSNq5l44nsyf+0yVJWLZiV2jdbPWHP3/HwkU0fsCos3H2Zzft24jWFy8KGU/0RXtQEXh2HUuzi+6HU3n+QbP+nahM8yAlJbRetcazOnCMw4zP1yS6QmZMT5LCax6L1tU6SxtXp2xXfyEKUCNuDt0l973QPjoYNI7ZzPHeIbBTL0dCebLMjTziIgHc6trDxcYnFA6ywC2QClQTS2OJtMIZYpbXM6LKEKT5CwTUdk0UaoGGAqpP+QmcrnSzKOkas3BVAccgD2IcNG/dnRAgKRPdidTLf5MouP7CS+tOOi/TNX0N9Q9oYo8ZRJCR/wxWU9rJLPQhVcE3DN/frPznZqrIHYZRXRydkiFmk1fJZ0l3Opno4Qt0OlGLDDUAGrAsoQ+p+cQ4oZaMX287R4Ysog0rpS2gipyheUjHN5bPtKZJ/yfLLWHfDI857vggsqEIlaFUXi60F50n9KUTtBMXGniIfCcEPJYO0pZshLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(261102123227099003)(10067099003)(4143699003)(11063799006)(56012099006)(261026140227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MQUAxYLAa/p97LhlbVwvl9ONiYaGUft/zYn4aIuPG5zZlMuwknbW7d4QencsDwAA/Flh3jq2NooPzc6GuEvt5fMMH5IAfTzq5BcuQpUSkXe1C8MDTWvu9RlzoheNiChlINhlRBhQlFLnboWf/SPqlG4KHYn/YW/B87p9J0bpWFGHjFcNOqmN6vvBggyGbqmnPLTKmqJ9HlAer1H2irF4Yyv8JsadVsv7mhCjM4CAvf8VZ3ipSv01ESHFNgu80VwHfFQNAZReuBWc1fR4OGm6dWOtqow3+AzbZJemd1M6nl20eeQjOJhf6ASnA03r1Uvr0EwfGcbbFJvLkmAXFBZxrWWrCEQT+c8IsUNs4+jqoWFZKvKSnKPG+yr4Dhh6wesIAd0lbCDndwSlAugN9T1am+dsdMB7LWEhvYt1bTXNEeq/b4dqdb7hcYSdqbmNKjse
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 14:41:05.1990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 024a9cd2-3f31-4ad1-a568-08df464b242b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF00059618.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628
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

Switch to stop using this deprecated helper.

The original could be incorrect under certain circumstances, since the
amdgpu_bo_fence only reserves one slot, and at the time of calling the
SDMA commit and TLB flush fences were not added yet (the reserve_fences
is not additive). In addition this allows us to switch to use BOOKKEEP
usage.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b1d2779a2aee..55f75bad9304 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1215,7 +1215,8 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
 		struct dma_fence *tmp = dma_fence_get_stub();
 
-		amdgpu_bo_fence(vm->root.bo, vm->last_unlocked, true);
+		dma_resv_add_fence(vm->root.bo->tbo.base.resv, vm->last_unlocked,
+				   DMA_RESV_USAGE_BOOKKEEP);
 		swap(vm->last_unlocked, tmp);
 		dma_fence_put(tmp);
 	}
-- 
2.56.1

