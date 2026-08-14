Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16801C5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9486710F72E;
	Fri, 14 Aug 2026 21:04:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Got3XsA";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 931F610F724
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPDEoG1aWSzIEk5PuhH5SDc/PG7wd8jIYJDT4LwVHzyZojd0hywYBF4Ivzlcn0T5I129YfnleqEt7xOUGGEy7+nIi2dZy699EH6dS9cbpLX3ixdqv3aiZxUWaTwgLVQ2QYl5CtSgU2czmvhnV25JijIJdX2h2BKexVnEl+er7bJI5PgicT6AaMRFe9/Tb5yFwe40wwaKsYaFGv2Nvl74gunvvOhk1UMGocITQdrwzCa5MZpwBmQiHByKAPc3/NdH+3Pz0CvNqkAfTLOuNbUmtvNXL70R20kinUftHod+BNAjMV9R5Oc61ZOzjsM5ne5n/XqCG7FdIk0dGWRBbxW7wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/HK3ACqbN+7+72CIPQZSrXbzN3uJUB0stDRjAU1EX0=;
 b=pAE+Tv2ZN4XCqkbqcaH+Xe706Xj0QlTR8AQpViAibm0ii80QV0gHmctaLp5g+No6JOS1kNMtsr6LzGU6r6LBAmx81DjG2zuP9/HSDb/U2t6ZuvhyPWHNNstqsWI7lrRXe+BZwm1eufnhGjTMoLwyy/bVfMuIRaaSWZTVHYjYfbZciuGdErVMWwmGt6yzp8uCZ/qqF21+P0HZvhmAfJslYMioIK+0srFwAwCe4xmZ1N3bjC7h87XpEjtTGqUHO+m4x8UYnVtDx8e5+k4S3zN+QTdE3uZXShUS//Pze9HU1jYSHsArAPNGnlJ6iItSgUY4kveAk1qZiL7W4fGXvP1aCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/HK3ACqbN+7+72CIPQZSrXbzN3uJUB0stDRjAU1EX0=;
 b=3Got3XsASdOIzO1Q/txMHJjt1iMkjmVha9EPHU3Aijh46E5KkDTQZ4axpe1CChgP6MHv3gfSNFFhWomkKKnuOp+hI2Xg3rq3TVT0fLw2UZn1qoi56aSVRUaDIlVudwxa2cx31wdaCURpkwBTzNXKJvyinsFA8W+0fTP3rAhrorw=
Received: from BN0PR07CA0019.namprd07.prod.outlook.com (2603:10b6:408:141::9)
 by DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:51 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::ae) by BN0PR07CA0019.outlook.office365.com
 (2603:10b6:408:141::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:46 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 081/109] drm/amd/ras: resolve compiler warning for stack frame
 exceeding 1024 bytes
Date: Fri, 14 Aug 2026 17:02:18 -0400
Message-ID: <20260814210246.3067612-82-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: ff8b476c-6036-4fe7-2006-08defa478b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Y02XihpzOrhDoZBcSuBC/L+BLp1fbPlD11IulEjbdor+8kel2tfwL/+PkRzqKCrFY5LdSeZ9+ZsR+rNfaQvdWNW4ePwcrMP0E49ykLjxs+ms0vU1Kr63T57sFN3ll4hDeE6E3MOHrcl7igXy09rOfGiwqOvAtudgeQezP4Q4VzDwhOQ7WzEhhnjKC2D/8cl/KGc/sAp9sy1BzAzbrdeyQpupUKgbQAfLaEzNhLAzbnaqvXrCLefTsUqoutPbBEUJxOhIvEljm6ztnOh16ja7rtScP5TxAxFnRdUFv3KUyGEuqzCXQaJj6L6Cm2WsOfDfxY24fBOFQ0Nls/5DohRgoaA64pFWle+R+8MwKDHoSgeCgoaZke6Gc0Q4xV0toeh6xMFTksyjZDyD+Hjw51/iUWXRAcyeZ1XK1/EwQVX5RfsQRSb2Z8Op96zJDXRRTszNy9Rho5dEaLHuwalv1aczlHnED1vfJi8ZJ90fSfM+MCxbPASy7j1m3/HJQLWv3zNoQ31AbTqtvw3NF6RzP67SuFVNQw/cJ3BmSFkWmlxAj8xJSDDCKNpbCSGHZw/51VtKGBBeMKL6IcoB83CjopsU3yaNxiBOL8LYdmd3weG3yAAR3/QFQpLhnRX0c08u3hj3CDjS9/uLxr3OlKcHlC5hXTmh+TfOQKBITgl25PnSySr1xx2FTQm8GPYsL1xkrcDfHiA8xB8U5uYwmnP7BBBiRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B1cywOV6nP6MZ5CqD+9J6jMLqWWEjCvzazf7URnFclo4DmLCNeMtyKISZE02663qn7msfAggRGFMoWPgG9RIV2grtYF9vyllGl28r/cP+UJ0XG1+ooBIsUoOGyBqOuJNIEWJrftTFB2Sx9lxA5leuuKZAp7cCKfnhNhXETjqkI3RgU8lScE0KyXNtWEyVSgdRqMxyUuyKAp6F5if6WUXzzMtETcfrrGmDVLRuPAys1VutooAIw4V5k7x7FedgWIxxUQufmJKaFWtQjavuiC2Ko4WIOYa2Fl63dsOfvtW0Y0j4pJNmvSuZfDVuFuAVM0tSsnxxIjyrgVTdP7X/yUUU65bpO/PAeRdn9N9Nz8G1EQmZ1MHdiUMGTQG8/BugRrSAq83BSH8hZGffxUP27QFLioD5cxB/gJWrgeKyhV9FvUbxfN9YA/7e/iEm3eJhztb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:51.7124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8b476c-6036-4fe7-2006-08defa478b29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Resolve compiler warning for stack frame exceeding 1024 bytes.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 24 +++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index fd4eea8c3f7ba..f6b114d9d613f 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -441,27 +441,37 @@ int amdgpu_virt_ras_convert_retired_address(struct amdgpu_device *adev,
 			uint64_t address, uint64_t *pfn, uint32_t max_pfn_sz)
 {
 	struct ras_cmd_convert_retired_address_req req = {0};
-	struct ras_cmd_convert_retired_address_rsp rsp = {0};
+	struct ras_cmd_convert_retired_address_rsp *rsp;
 	int ret = 0, i;
 	int retired_page_count;
 
 	if (!pfn || !max_pfn_sz)
 		return -EINVAL;
 
+	rsp = kzalloc(sizeof(*rsp), GFP_KERNEL);
+	if (!rsp)
+		return -ENOMEM;
+
 	req.address = address;
 
 	ret = amdgpu_ras_mgr_handle_ras_cmd(adev, RAS_CMD__CONVERT_RETIRED_ADDRESS,
-		&req, sizeof(req), &rsp, sizeof(rsp));
+		&req, sizeof(req), rsp, sizeof(*rsp));
 
-	if (ret || rsp.retired_count == 0)
-		return -EINVAL;
+	if (ret || rsp->retired_count == 0) {
+		ret = -EINVAL;
+		goto out;
+	}
 
-	retired_page_count = rsp.retired_count > max_pfn_sz ? max_pfn_sz : rsp.retired_count;
+	retired_page_count = rsp->retired_count > max_pfn_sz ? max_pfn_sz : rsp->retired_count;
 
 	for (i = 0; i < retired_page_count; i++)
-		pfn[i] = rsp.retired_addr[i] >> AMDGPU_GPU_PAGE_SHIFT;
+		pfn[i] = rsp->retired_addr[i] >> AMDGPU_GPU_PAGE_SHIFT;
+
+	ret = retired_page_count;
 
-	return retired_page_count;
+out:
+	kfree(rsp);
+	return ret;
 }
 
 static struct ras_cmd_func_map amdgpu_virt_ras_cmd_maps[] = {
-- 
2.55.0

