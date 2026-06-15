Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA22CD98E4
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6146510E768;
	Mon, 15 Jun 2026 23:57:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZScJVi9K";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011032.outbound.protection.outlook.com [40.107.208.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 825EF10E6F1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VW8lgJF1c9Mr2bMEWR373fix0SiQDHlu/SqBU6oAlZ36+3GliqwKgZZpTgIDH5ZsVt8Lh0YqDDjyzHbZCY3eVTXW0l/yu7H2lZhyv+DTqQXVGLjYN3pdyAKEm0koA1smCk2yyKU5qFsq3Ea5fiDtmjM5FbLOEvtkS8GxeLxbrNQ/WOjmGEWy34eX5RiCUi2y+yXpuS4qbeU1uRryylkFcpoqELk3sskxyp/6DSL5lR0ou7ejfEd9hERJkDG9CjG5CMRGjSZeErO58PIIeCnEJJ1brN0jwk9tBN0R6d7LptSI2jmb8VtOucT7k8hrj4KWkFg7TG6fDq9vIkfHYuCBhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zslBt2n8l4xtnc/6a50pIV8N31D9bqu68MrRf83TlmI=;
 b=ecnkw3S96ABUj7JbknTIaG2pXOftl+5+QsBdYe+OtrxskdNw2rKwGJ3QcFSrJwN8+2fvNaAFUsnIC7t0iE5ex+rGhZIqrARLzpowqmyhsxwZfv2H4UaUl1zbG0kDUkkaD6tQKL1tWXSznuPebLhfQDklEvb1zgSh3mkbIrnW7LtvOzIYOUeuaXS9/UGdHsSVCW91KIk1S2WF/SBILWXGB7qALY6ENk7T92VMcP1QiMl5FU4M2bKVnGeR0bF+rwaGy9CHXQa1ESuT5HSam6BIEsODARq+i4ihrUy7EQma89orJpEwtHCt4u7kuYG+Di2pmse1WHKYeI7BDfMaqnmWtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zslBt2n8l4xtnc/6a50pIV8N31D9bqu68MrRf83TlmI=;
 b=ZScJVi9KGx5pqtEupjZQQm2wCGkDrEh/xlV3PaYvzCTqkj2q0dTCav6QGaW1ojI4hj9aSg+7Mqw3AvMRBlYz4aVvgS+9tq38vdqV0dx7a4XOGgRs6VJXtAKgqVAkMctcmzuZBZYblvgaN0NQL4T3RQaonUyTaGlzi3+fqhEGIm0=
Received: from SN6PR2101CA0020.namprd21.prod.outlook.com
 (2603:10b6:805:106::30) by SA1PR12MB999086.namprd12.prod.outlook.com
 (2603:10b6:806:49f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Mon, 15 Jun
 2026 23:57:01 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::1f) by SN6PR2101CA0020.outlook.office365.com
 (2603:10b6:805:106::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.2 via Frontend Transport; Mon, 15
 Jun 2026 23:57:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:01 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:01 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:57:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 17/43] drm/amdgpu/gfx12.1: WARN() rather than BUG() for
 invalid SDMA engine
Date: Mon, 15 Jun 2026 19:56:19 -0400
Message-ID: <20260615235645.737189-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|SA1PR12MB999086:EE_
X-MS-Office365-Filtering-Correlation-Id: a96e9791-36e8-4aeb-63ed-08decb39cb66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: By9ZFmmr5TK1CiYwqEc77Fvhpy85DymusdJj64jhgYsiFrEutX3HA35mzNtqurFxmsJ7zE5dK1BR6TKt0fHuEQB1C/pChaEpn2Lmq4PVSFKqcD2Wecmcz1gSzdqjOaXOdp05KjJOHJexk3p+gtbCNojU1VU+AP9VpjtzyIQCIiOq3ICTsolLv0qZabJHgwOrZmm046FgnapVMdMoxa3cgBI8yboicLG8myFrCalfoa651FVEyhstRnBJEgLeWAkhb9bKfN7Vyl2/9N3N4hkd7fbQgD/XicYjkoaT4jCh/mqXQ5GufQIysvgvhkWwg86vDjfagngf8xbYAC8w5vpATWdP5jgBL6aIGR7Cg/yDJzWphh0I//IOQtTyt9ws2hFbNJulsUFczzsIhteV4q+ezomSVHksF+pZk/xUNjGCkJMXLFduULZqn6G+s/QWYM079zH08nrUb/zcli9H0+AaoO7oj40lUO57xEpFfSsIbinxM2+UWkgp/wD9o6r9GUkwgGmKKwAk4vXkYiqXNP7DUBGqQNRlSARpvg/z7doc/r2BQMpZQNxzsEfRPxpg2JQt9d4uDWQk5sbJd7S4gv+IKUlzXVi9Vwkz3H7sBA69cyTzabgZZAZodTXUrNJZpT93DmE0p8APLBB5zG07UzIkcRt+RoHLIgF3fgOBGEqrBV+Q/XecBNBI0ZExvZwJIL4DUYam5Cq8iCbYku7RuHuSLkqygFNRQ4/lxxGDbnudoM8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +9RNTOdBWcL4ky5C4Nc3GY8jVjHgJNIasWlo9I9+51l8R0fT5XMot42BPmFxos4ZXvRYIxadJVVh5CtJZXlaiD0dYhSCerkUTujmk9oSCQkybyLEBcRD23exLywB9QO6oV88ScvGOoAtaP/O7DXh6RzmA/wTXEwqMf5qR5erQcqHnNCW+T15dB+KjgBJi6XhuWA91ywBM5X2XyzeiCfR8/Izs1mAkFv2Dn0vJ7uHZjpHuCJ9kpasszHb+zQV16VpjRvPfU3AJfZCZGmFh+WtVLaHWxWG4Bi/M9jjmGPA23zsboSPeJkWyIyMWSo8aAZRzcgcazF65bO7fHGWW26vVcjLgqrc6+sh31NyWo5eR36pcK5KD/Wv6xNasJylBNiY5nSy/cf/cjxkMMHa55XmMMyigcXgYyTGMT3GJwXqtElLOY+fdIWIlkOB6PzEdgr6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:01.8597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a96e9791-36e8-4aeb-63ed-08decb39cb66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999086
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
index bcb180f9d3ff8..38ca1aea33b2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
@@ -93,7 +93,8 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
 				regSDMA1_SDMA_QUEUE0_RB_CNTL) - regSDMA0_SDMA_QUEUE0_RB_CNTL;
 		break;
 	default:
-		BUG();
+		WARN(1, "Invalid SDMA engine id %d\n", engine_id);
+		break;
 	}
 
 	sdma_rlc_reg_offset = sdma_engine_reg_base
-- 
2.54.0

