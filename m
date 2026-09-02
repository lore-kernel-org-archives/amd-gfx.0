Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87A0C624D0
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 12:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37C6410F1B6;
	Wed,  2 Sep 2026 12:50:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YTOW0Uoa";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012014.outbound.protection.outlook.com
 [40.93.195.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D2110F1BD
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 12:50:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViczhxtFIjqUyFCA6vgdkD3GllfwiikKP5GZW6nxHfSNaImRvAZaZiYl1gD8mbWpilkawZYYyMi0S+TaW2yzT2VE+kWZJWA+YYJYa84YXBcOWqVzmTBg6Wb7KCjlIjIkbcbe9oI4Nr82+PmltsM6hQvpK+Y0Ro6c8ZcE31hNADZqoElWND2UPwmtmMkNdGDOSDaIw5ZzvD+hPEp4wvI5FfXk3egku10cOzfAxu9M9sHkwbQhUbUf95gZjoDMLB5ud+g9nYyt65pXu2b34wQT3WXWL04HBSJdaRvN00s6309eUJRy4y5AZqkIMwW0YmbXkucWkiSfLmvZxhiz1hspjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmclfCqvqJDHg4Hoo8+aG42GuHBFDp2zCgr/FoXWEyw=;
 b=G7n2thCDpR6LslZ1b/Oc4N8cR7M8ko2d1ocpqAcoiDJM+3nkKMys7U92f3WeyER0i5g2SDPkdEvyF7xV67m5TT1G6zHp4E9KTbR7lsXFsMU1En7cL38lrOT7H2d+OxyamT5ro+T1cR/cAw5GJ5ZsASwfQjHPDAqvjqamY1DZ5MzGI4QTdDV8IOmXO/IIfSs4G0UzxXaimM70DfAC3pwvJej+cx8ZyXwQjrHX8ul1Atbx7C+/ZQxykfE2KeXUlRhpEDqz3VRpGTlbIW68d+lKqn5VV09zYz11iojUSQF8v1JmSCFcfs6knMccpMPucpYcB+ralKjQN4FxdO6wcs8hOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmclfCqvqJDHg4Hoo8+aG42GuHBFDp2zCgr/FoXWEyw=;
 b=YTOW0Uoa3an2Jzq0rptF0BJVUQmOu99b23KiZXIZyOFTp3q5mgn7V7FvvAF3NwP8SrGiW0BDwc8TkkcxHhcKpbGr1hIUq6rD9kCaQUtE8nfuhmlT6Y6awEqDCOceSHkm3M/F7PE0z8q/mODOFD6gJbYVxF26aO3sqUJIdpH7rEk=
Received: from SJ0PR03CA0149.namprd03.prod.outlook.com (2603:10b6:a03:33c::34)
 by IA0PR12MB8694.namprd12.prod.outlook.com (2603:10b6:208:488::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 12:50:21 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:33c:cafe::27) by SJ0PR03CA0149.outlook.office365.com
 (2603:10b6:a03:33c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Wed, 2
 Sep 2026 12:50:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 12:50:20 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 07:50:09 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 01/18] drm/amdgpu: Remove separate guilty compute userq reset
Date: Wed, 2 Sep 2026 20:49:44 +0800
Message-ID: <20260902125001.621629-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|IA0PR12MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: c11d100b-9821-4701-0e0a-08df08f0bfaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: AQ4kWCs0QQHW7ziQ7LdiPVxotAfsWoDklm0ksjRZBS3R7nYF2n7VYOf5ujfnQaKTEBYrnYhxrA5fDe21SP5AucdH3OUfHtxS2k9M2d2oCn+wwRpDrZRjsHzDs8ceGdd0LbOvRjET0Bp+Dkug0PLzABoNqIYiuv0bWjamhWbfeO4jcKzCtXgQUabKKvGGJuGcT3Uf5K5AaF/BLsKIOd7IvqtHwKUqR0hlwtpG1MlZFGW1ZutZH5pB2Ib9PdnK3wYwKDIelz3g+YGaWi4VZUxhiJsFcJmiZ9UqzXYDTcWefowq8sfN40Qx0xglxZSSidOAQXm0owlB4GHsq7dH+oWQZSBWz3hgBcDU96hiBYaVZxAThRmwwlCrFeISjWLaf+HUS8SUS1GeV/RSBrXpTfqIFBwshJGt8BwF8DP0kIADqprtbA66C0Cjp8fTuxu2dNQFoIOs52PmTMicER3fXQYrIQFDEhO7h131ba5VQiYGdNAgnr/l/MvkEXW79mctPElU/LggWGbyYbSYTsUD03NGG//7gXDBPioiQxmF77S2ifmAb3MKJVc91Qu51TInIQfiP3qb3ufyirjm+RfQwc7ZiCWMxC2qClk1cHf5L+IrSbJtTSHMYoiF6r8/8y9k49MIO4WBE72MUHfFdoqAKtHnBSjc3pcKFtpQFNb/LiOosFcIRqg6K2r7VYsHIGT+J7TyeInlr5Vq3Ckb4MwCZpXUtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ulFR1czWcXmTrN3bpAdfwjJDcU/5JJu8nnxkd71HQob59Lx2CQ1fGnvbOJrUOsreeyBIbXJMNzP++YbxwABZGdrQQ0fEcC/aASGCYTk0M1WnKlM8xZ5jjF+0mseeaG403rGAnuC+g5TQMWamvrWFpmIF3d+uwvQnXGqPDrWC6gy1AntpV26xSzLaczrvi3b7yFthdwqXX4FzOadabOptBIxbL+0NBiG4r3FQIX7eItRznDU/IFw22Mre69gdlXqLI/0hb7SylPkOvoqS1qjNp9T/vVv6UUPFU9H/BWcdmCXca9z0yEfpDSf2Ym0WQhi1EWAD5fcycnWot+MRPv8Y+eD2JBEXo6RtBhHtl9T/7qjKo1Ezxky+4xTsCSMnYAAw9gzwd6Vc52/3UsGbgUng/z32LJJQbB0DBGvxmlXTXD94xnQSPeDVn2aIpBs1KBvn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:50:20.9711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c11d100b-9821-4701-0e0a-08df08f0bfaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8694
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

amdgpu_mes_detect_and_reset_hung_queues() already detects
the guilty compute user queue and resets it through
mes_userq_reset_queue(). The additional reset via
mes_userq_reset() is unnecessary, so remove it to unify
the compute userq reset.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 5 -----
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 2 --
 2 files changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a6f95ff47d24..5c3be851ac84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2384,11 +2384,6 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 		deferred_end[n_deferred].fence = guilty_fence;
 		n_deferred++;
 	}
-	if (uq) {
-		r = mes_userq_reset(uq);
-		if (r)
-			goto out;
-	}
 	for (i = 0; i < num_hung; i++) {
 		struct amdgpu_ring *hr = NULL;
 		struct amdgpu_fence *hf = NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 7f334f718cd8..83a438d8e117 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -249,8 +249,6 @@ int mes_userq_reset_queue(struct amdgpu_device *adev,
 
 	xa_for_each(&adev->userq_doorbell_xa, uq_id, uq) {
 		if (uq->queue_type == queue_type) {
-			if (uq == guilty_uq)
-				continue;
 			if (uq->doorbell_index == db) {
 				uq->state = AMDGPU_USERQ_STATE_HUNG;
 				if (use_mmio)
-- 
2.34.1

