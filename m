Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45B9606A320
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=S0bGFBpi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE1C21124D1;
	Thu, 19 Nov 2026 14:41:10 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A22351124C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 14:41:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXBNS5wNVI5pKzMyW0n4MCu8E8i4Ebnnhe1AtREs4b6/7ozHLf7vX7KEHgovkywvOjUdk+arHXE8MC/LtyQRbPBsNBXM42rMkUJlcqQh8bsunaZYu72HZYXs7krZ/jPFXLBHDCAcNlUkpaPm5CLNaUZajwOtviYewPbFTtZz4kzoEQNy7RPcVyjEisIAGB+sLhe6FzxbpNDF4YArkDNr746MRwcp10LDjr7vL/oAs8UHHyEhsB14yo1hpTZ6fOgOkqsRzohAW5NxAky4ao/FYspYU7cOXPUmS7Vjm5eYm4YUz9JwTRosmZMQ+s0ICJaj/iLKQjRH5xNqvce2Ida8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0jBmDsSWVPdN2tamvVHoqhueIljd3N37A9/MFTocqI=;
 b=fNnAFWxbREDSZmGo/4RmVXXAAZoeQf/4uC6HmFn+2aZ37Cr3oWms2l0+Auw1ploFP8yEPggFMcDl2zar2cBPqIRRwg3N8AjDKd6eva33/cgv7dJu31EMnKdQQusbph52svl4aC5rnUS0YvJ0j+W0eK+SHEfniBp1kXJMAyxSOTjlzb0NlPpcTvNbp81HfXxuHvaoakse1Kbz5vyh2ncgS+dka5nQH2atA8oIAQOBSfTdOE9RaQ6OcXs1/It9kykD0dMx0TraLn5hMDcsqUk9xhJh0sR8oc+cwJlYS2a3xWAx3fAjANNNjGk/rwl/9taMC92ITMWa0CiNxttEmqhD8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0jBmDsSWVPdN2tamvVHoqhueIljd3N37A9/MFTocqI=;
 b=S0bGFBpi5e9itYVPmc6966HwvkJk2n0FUHko0MUO7CttQmPfHHRbGuTEwAnMF3xuPyU43vZDGkT2PgXKuEuxQ5EvRXiJ+VWuEBm4eOzbr/WoFUKZ1TKTlsb2C+zCzel5dHIR49rhiFfSWHeR5tCa/6ire82P+K2bmuyiZRG4s8k=
Received: from BY5PR04CA0022.namprd04.prod.outlook.com (2603:10b6:a03:1d0::32)
 by CH8PR12MB9790.namprd12.prod.outlook.com (2603:10b6:610:274::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Thu, 19 Nov
 2026 14:40:58 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::4c) by BY5PR04CA0022.outlook.office365.com
 (2603:10b6:a03:1d0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 14:40:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 14:40:57 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 08:40:57 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 08:40:57 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Shahyan
 Soltani" <shahyan.soltani@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v3 1/7] drm/amdkfd: reserve TTM move fences
Date: Thu, 19 Nov 2026 09:40:43 -0500
Message-ID: <20261119144049.2057674-1-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118190735.1863676-1-benjamin.cheng@amd.com>
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|CH8PR12MB9790:EE_
X-MS-Office365-Filtering-Correlation-Id: c375a082-5328-4110-b181-08df464b1fd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|261102123227099003|261026140227099003|261028144727099003|11063799006|261021123027099003|261021121427099003|261022105027099003|56012099006|10067099003|18002099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: MSZswo9GrJ5g7rsJVHycMadr1G2LDDEJm3nQ9QwltCqOwIGpRlrritR1mzVODvBXrqiy7G5MeHA6BOwq1wDaYp8gDY8FSncXveXcpFrCRy030aEFBys2TqMMQ/gnoKYQmnwXp1AfoKl2AFeh6MNBxtxCKDYAxyv32O+okLBOJLxgxyLSdCQ4Puzkph2u8Bmk6SaFyPce2qdiIsRAJzSuELQBGtjTY0p5iNN++45MQLfzNSClFZc0kunMuPBs2YsrgTA0X6e9gg7ypnsPu4UQ+Q9mw/7diLX8zjALV3bW4TMoUTssidiG1+07kODVHI1W7Z7ag6ibphXcAwUQ1S577MDJpT7V6RCZ+q+LFIHe3TqG6yOMwr/wg1zp6i4K7AHoo1g5ikY2S9PzEQd6fgt0XewCd4cnNsWZREjwTuwfe4T5a48DSS8tNUd/dkolglqJ7ntpm58JD+KpEUFv4E7GGt9ZyIGgKX6S1sUhOEDYBHgo8mz6Hov4SzJ6GGFnCl2qLsx2YHQ0eWRhzQshMR3l+7ktl5XKXmMPQ+P7PdoF2M54aBxs0hMHld9RaSQJGrLmSgjSX8dE0IiFZyY/LmpedRP8u/mDOZ7aX95pTvjinVGVlMB2MbeTMo+pOWgXnj5cXp3WW+gzwX4UmRZOSPKazfy8auaVwdXbRCc1DTOiTSxl35XFp2amQqtvvFB0x1DlhATctCBNTwpCpM7QMqOGWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(261102123227099003)(261026140227099003)(261028144727099003)(11063799006)(261021123027099003)(261021121427099003)(261022105027099003)(56012099006)(10067099003)(18002099003)(22082099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yEfqsxo6JUKRT6KIWBVhQBrTWqqfF4CgkAzwjyrqqqEOxaSmWSSUKBZcJ+DGc9/0O9oMkKize+UcsawQNRnDd0C726b+Z61vdvkwJFTaKHAMVLcMchbBlAK5XUNulDA7vPeZ+TSo7a7w910u7yM0IwIpu9Xd94gsmP12+0dV3A0ANc0TduzXZSlj2R6Ly9hN7hvca0Bm0YEOq/bUPf/w0rHUXDcgxQmeUgJPy0WSbmCYxHfpf82RWyscUvYe/NrgGChPWvVd7ggncUhlqogAPf2yuXBZFT/8jmFPx2ijXX1xOVamax4hxg3XTJiqaGJSICbJ1634sGVv5ViHEGyXMu9xV60HgSP/fjIGPvABC270ZoSOkAsMDAEwWFEtG7+M1p5P1SrdAE5qvNRsbGzB1drop/TmtYsa4bvBHdXPDFN1/z5s2IM0S8azdD9v794I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 14:40:57.9720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c375a082-5328-4110-b181-08df464b1fd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9790
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

Validation of the BO can add up to TTM_NUM_MOVE_FENCES, so we should fix
that.

Fixes: 897ee11ec020 ("drm/amdgpu: create multiple clear/move ttm entities")
Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index f060b206c255..a6616447abc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -3009,7 +3009,8 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
 			struct drm_gem_object *gobj;
 
 			gobj = &mem->bo->tbo.base;
-			ret = drm_exec_prepare_obj(&exec, gobj, 1);
+			ret = drm_exec_prepare_obj(&exec, gobj,
+						   TTM_NUM_MOVE_FENCES + 1);
 			drm_exec_retry_on_contention(&exec);
 			if (unlikely(ret)) {
 				pr_err("drm_exec_prepare_obj failed, ret: %d\n", ret);
-- 
2.56.1

