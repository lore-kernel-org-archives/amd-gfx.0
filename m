Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8F0C61DD3
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 02:47:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42C6910EFAE;
	Wed,  2 Sep 2026 02:47:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CbxEEh+Y";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010003.outbound.protection.outlook.com
 [40.93.198.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2800E10EFAE
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 02:47:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjbDDhhkgmQrgjlTHJ/BNgtQIB03qPhM3WmbxKGUs8Dxb/NLT9E4EIB9rrCgU2VXgzB48bR2dgJCGwVASsqgQcnRK4gQjxtOuyEsbY2zNPOtvKTbHNNm/U5L5r10+GiS5Zr942GoRzYPDTpD49+ujtwi4N2Z7494RgNi5ls4D38GhUhfgNG5xb/+FNyTjlVkgsmGIMFLbcU3hNXLM0YqiZ6sAB5q3tXguqXcuI8o1pK2yqv+IFTN//P5Uo1OxqPdEShgDDR48SQLume7AarMjQPKUKmpLeRaxVqw7bMQMHscuN0kPlzvl7JLv4rc90cp0tl6xb1uFZCJnGBNSpyOQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOqQHIVaZ7P76xR4RVUmiW+thM4GnesQssKpbjMgRys=;
 b=R0y9M/oXQ73T09cpIBE8D73JW+ox3Tik+gBWGN8Niu/psQxxdsX3Aaro61MwMt25fSKVBY7jd2niKb8XVe8Cs0qRaO4cfGHQP1kA3x43ja8zMxJfZZ+lqGoX316jrVc+/xuzueO85Y3rVmxsVhe90AxzHnzUA8Mhc50G4yFZvovorerx1nGODrBolshgkHRbE9kd5mFrSU3Kyb7O6KL8be6TqMP6fMX03B4YQBn7zN8gKLek82IvmoZrNJqt13LXMBeDbvxakEylzuTZCgwXRi+Fg+B5CwtjLCDZMAUIYuBYrX8LdFvJhB2gY5Q3C2pnEQkaXCeCdKIm4alOHRO31g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOqQHIVaZ7P76xR4RVUmiW+thM4GnesQssKpbjMgRys=;
 b=CbxEEh+YJR2u3PvR3vQGaRkH8dIT5Ek5igkoxxvwaVbTy4KqDkqDDaK2rA9Y5dgBNcOfpqVHhQnHgfs7Nc2+WgNwJV85dYchDvXEpbb1S/tpIbrySrLfd/V6gHLxtl/Ac1HzQeR9WinM3LXC84rHfX299z58TNZFCMLcL/v+hGk=
Received: from BN9PR03CA0327.namprd03.prod.outlook.com (2603:10b6:408:112::32)
 by PHXPR12MB999258.namprd12.prod.outlook.com (2603:10b6:510:3ca::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 02:47:30 +0000
Received: from BN7PEPF000000A1.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::97) by BN9PR03CA0327.outlook.office365.com
 (2603:10b6:408:112::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 02:47:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A1.mail.protection.outlook.com (10.167.248.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 02:47:30 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 21:47:28 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <Yifan1.Zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH] drm/amdkfd: don't gate userptr cleanup on the owning mm
Date: Wed, 2 Sep 2026 10:47:15 +0800
Message-ID: <20260902024715.696381-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A1:EE_|PHXPR12MB999258:EE_
X-MS-Office365-Filtering-Correlation-Id: a0fea46d-16dc-4914-6028-08df089c8810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|10067099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: hebo6q3I640notYO+cW2OTiwR5RXAYtfAZbI5jzbEGgJVHj3QqQVLMbP6WSolsgNYRBmXmq9IenL5iFZYLh5zubRBCbatEb0NqttrQEDK98ZVwI+3sIlF5Fdddwo9YGLwecCkCJrlvtjn+ESjw8tNYbDhWW8xrsNQGRDmruL/1g8D7rLOFxXQ5573W1M+29FqjKlWHMh/4uZ15r4n1ZjUlnyk+Vidz3HYhRAHsQhCY6BoDA/JHYQ8Nhhh/PwQOAjJpnGMJGV1VBrrSKcQkgvfVDHgTnRWxQj23djVrtZ7KSErHZfejPQGKccEGjSSIjdfYuT/TNsjwbNj4eA6wbj+U6hywqL/TNCwlLyioT+D8iyZMhoomeDY8MirjI8pxUW7Ccfp+XeQKnKQCd5UUDkuv5T6jxt/rMKnm+OkZd7VumFFLrNcls6yo8ps6ytz8nJZw89JhehoMt7t7mfw/u0sUq+fGTJjgT7o5dM5vE7H12AeeDRo9b6tVjsYXejFSRB2bhVVOdnUkcjmLPl1cEEpjF0A3SiseRmkwcrsgxPGF8VvqqNulIBRcC+9SPihjYRFjiL6MdtkGxTgG2UgywEutVrbpa37dqgMOmLaJ+7e/QRZeQsGtSvwFU0NOaJDNLxL4c9YDOlzmlLSxoF1HdrAkVPC7mlBlnZfouhKEsKoKPdNekdKDYqYBzaNDoFe94Y
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(10067099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DwIYkCjGMmTOPS22K1JB7WJAysYlFYUWqS6VbsokvpBnG/PVS7aRR7Z4C5iPgprLBrOk4vVESQMXPYtYijcDH2aiT9Vgt//ZPxP3ADf9SsXUEYTvDWC4GJkc6wyzcU7TXmCAnqy+dDumrjYOXlq0dH6x6L9do2M/Ove1pinZfcZkvS83YW3/aCDhQeRMUlihPw4Ku6Rv7lAoW0ILp4jksJi01GVBYv/VivKMhuHzCue6DenxniWyjAy9Ukjw9dV9qULaLd6xVvYgShGViv7kxCC1Pbabt8kMYnjL1twoJaFhdIfJ60lyOTgzlXyw4lPcG5jlQXLppnmVIZ03FbaUhVdOy3FGuOeeQN0yDA2gsWMppmNjz+vFTp2zqgNmpxOng+PCPpBJv7eADrj6QnoC0aMo/2Cwvf/bWQKGlUpYQXQffHCqre91RqJ8wrVotwJ/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 02:47:30.0170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0fea46d-16dc-4914-6028-08df089c8810
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR12MB999258
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

amdgpu_ttm_tt_get_usermm() returns gtt->usertask->mm. By the time KFD
frees its BOs from kfd_process_wq_release(), the process has long since
run exit_mm() and that pointer is NULL, so the cleanup below is simply
skipped on process teardown. mem->user_pages then leaks along with the
page references it still holds, or mem->range on HMM builds.

Check the USERPTR alloc flag instead. It is set when the BO is created
and stays valid no matter what the process does.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Philip Yang <philip.yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 7882f1385248..a5d1d83ee5d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1954,7 +1954,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 		return ret;
 
 	/* Cleanup user pages and MMU notifiers */
-	if (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm)) {
+	if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
 		amdgpu_hmm_unregister(mem->bo);
 		amdgpu_hmm_range_free(mem->range);
 		mem->range = NULL;
-- 
2.34.1

