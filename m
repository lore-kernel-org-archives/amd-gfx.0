Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8B5C3DA66
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Aug 2023 05:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45C3510E0D0;
	Fri, 25 Aug 2023 05:22:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A3BB10E0D0
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Aug 2023 05:22:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxguNg5AHqwAt55R2Os1N7+e9xmEFSM5yENaNz+/9Og6nfb/TsCKcvUGx53PsSFdZeCiMGQMA2qV3wudA2b53oEN+mir7gL7wTm2MQaIxXtiEkXZWEHFvqP3WC9dOc0VauoRkUG1hMalWOzlgcsmkukdUbsK/6hVnebI3v3rhLu3K6Wonz4FLNrReqxSh0J6QYUufgXiFH/XHwroKqGd2TVxLGHYuL2Szp/EKxMfGQr8TgJ/V+k1QvNZxoJaDs/jhY313hRo0iq0FFdiRVbjsql6sp2KezTwItiatED7/CNj/Q3FKK6Xyu3QQzyD3rVrrKZq2jhlGyNpJJyFp7f2gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktUMPVIZwSBj/KppnauBOHMhe74hBK1D2wHRByeQNTw=;
 b=LC1Ci0oRymLQK7980HMLV/Xo9eFn7KC/wdxnX57bNxpi8A/YJcX5WzLBRxkkxotR+mMww0DEhOum2wusBjhzzTxRprrkZNOHruDMWriqoGn/nPrXKCozb2Bn/Rm5sPB7qFjL6MgNO4jJ6wn9P29sxwpv+7t79Rmr6hHshfyz5BNxBLAUUDO8+iI/hd/42fuyxvRbGcgOhgGwZbE2kmnx/ozfxOob+4v5id1JFk37SnkVhyCgK/LtmoKK8BfcuWeBQ6ffTvqa9WVRwL6mWt5mCAlFVrMo1T09EHG2L2pY0DlGAkjJFP/jepdwPcikEf6JcB8ZoG67+mBpv+X/wfIkQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktUMPVIZwSBj/KppnauBOHMhe74hBK1D2wHRByeQNTw=;
 b=2HaEZRtLr5IRWSCTFnMR2gOu87qmZfzJG8vfDqfdFs5rjObKye6p6uVIynDb0HxcxjCFm3MY+ov0pNQv+nAY5Aeot91orlxxwRO/xO62VsHlk8rE3HBYRtH03Po7oc7hfVd0O3ghLWrf8DQCSnwkzoIEJ/jE5FyxOZd8oi5tBd0=
Received: from MW4PR03CA0142.namprd03.prod.outlook.com (2603:10b6:303:8c::27)
 by SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 05:22:31 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:303:8c:cafe::de) by MW4PR03CA0142.outlook.office365.com
 (2603:10b6:303:8c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Fri, 25 Aug 2023 05:22:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 05:22:31 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 00:22:25 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amd: Simplify the size check funciton
Date: Fri, 25 Aug 2023 13:22:04 +0800
Message-ID: <20230825052204.1315534-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|SJ1PR12MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: af9006d1-17f2-4cfd-6b20-08dba52b4804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /dwQyB1E8SHOPqOofqCNIxZNUEg3FVKpXFcKnxWcUm+8YL++M5YoWnVCsTmRpwB18/k5A1c90I7xOectRuZJ2CAwOjZsw8sO53dlQrLR6NVQXbgU50PLKbzhArW5dJp6RyDqFAMfX+zMzwqQtr8Ndo05qNwQ+nAsKybaYdMGLsaWH/HjV4w7STDfzjf5ysVjwvfjzWV8DxQs/Gns2k1TtbrIrN6F0EWYlkcj6zKb/gGlxdz1Ixut+xjYRApZQDyVdkLa4p0QXFfCEq6MW7jymt5niJ26cjkEVpdob5Epvy+E7cBc7Bt4lOylIZrmvLsmSY3+FrnFbmZ0BdwVe06720N+8YQMcVaxqoz+HkuTA6jW0sYA49E0HTPMi8KOmzdz6t/JVH/LY0BJHQSUJFe9Ip5H7I96QQyq8BD/cJ/ETK/naQzmsJDErasRfew/9cJ2W+mnUhDSn4gUamKmehuGAbAu9ZpdplneMFu0KNBKRrhynWur3kKFxU6MM72Jy42GHMEwO0GDMF7KCvKOW24znOgl7o8ntu3KSQgc45H7tZ3fIS875638KWTNQSMpyFbKObv0hgZdIPq1ISJDtiqjIrMvffP/zimhnubQAUXDhCUkpxaTOqtAGnU3DVDQPxvmpwGw6D0UKvjl/VDCb7vzynSiAUJwDdYdodUUezIYO2/3lDiXAF8PNiLOJjV5I83S8JWCG6fjb/oSU+SLxyG6v+oC7l9+Q6cqGKRFCSaIJJQzu4vhhJG4c5XKe6jtbbhTLS33mNnQkCnQjOUpk/LPgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(82310400011)(186009)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(1076003)(2616005)(40460700003)(5660300002)(8936002)(4326008)(8676002)(336012)(47076005)(426003)(36756003)(83380400001)(36860700001)(26005)(40480700001)(82740400003)(16526019)(356005)(6666004)(6636002)(70586007)(70206006)(54906003)(316002)(110136005)(478600001)(81166007)(41300700001)(2906002)(86362001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 05:22:31.1920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af9006d1-17f2-4cfd-6b20-08dba52b4804
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289
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
Cc: Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Simplify the code logic of size check function amdgpu_bo_validate_size

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 28 +++++++++-------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 807ea74ece25..4c95db954a76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -480,7 +480,7 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
 		*cpu_addr = NULL;
 }
 
-/* Validate bo size is bit bigger then the request domain */
+/* Validate bo size is bit bigger than the request domain */
 static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
 					  unsigned long size, u32 domain)
 {
@@ -490,29 +490,23 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
 	 * If GTT is part of requested domains the check must succeed to
 	 * allow fall back to GTT.
 	 */
-	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
+	if (domain & AMDGPU_GEM_DOMAIN_GTT)
 		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
-
-		if (man && size < man->size)
-			return true;
-		else if (!man)
-			WARN_ON_ONCE("GTT domain requested but GTT mem manager uninitialized");
-		goto fail;
-	} else if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
+	else if (domain & AMDGPU_GEM_DOMAIN_VRAM)
 		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
+	else
+		return true;
 
-		if (man && size < man->size)
-			return true;
-		goto fail;
+	if (!man) {
+		WARN_ON_ONCE("Mem mananger of mem domain %d is uninitialized", domain);
+		return false;
 	}
 
 	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU, _DOMAIN_DOORBELL */
-	return true;
+	if (size < man->size)
+		return true;
 
-fail:
-	if (man)
-		DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size,
-			  man->size);
+	DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size, man->size);
 	return false;
 }
 
-- 
2.34.1

