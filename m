Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B21C531C7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 08:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F133510E548;
	Thu, 23 Jul 2026 08:23:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q6JAf/53";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010066.outbound.protection.outlook.com
 [40.93.198.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B905610E548
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 08:23:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkB6rgI6P6g4zyGWZ9uXzNQc1UvzgZEawXPhf6N0WHHEiPeYIgaPqHaY8Kl6sux3ZExRCi3V6wjFZscjXvH/CzAdoTTq4fwDejSYwYoWMF2teAeLTn5Dy/N2IXgyfvhq/xRde5kQ5GOpuTuSwgxOyCpWv1fswmbqMQwyJ5qbTSOVgomb7LdxgnGkwRycc4aRcch6mLyNQHZCprz11TjpYrmfwXwLpy3tRXD+ViKgp47lnNZh0mLrio56vkxfrjZLdpRRrdqyn6k78kkh0BTeOvtQdmol2SD4ytbzK3D95AXjPkMaNLJJGhetUUAtzkFjr+jxLzZQWwraRJQRAkQf2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVhfxXlSolgSkrL0PHcYWTE4XcpLREqIzRn4Sd2vopw=;
 b=Ugiy3HH05oyEyTN2ZIfHWQGckm6CTmD+/jT71I95LNBTLSBUPbLXEsnUyDcg0k2e8yX/2MfoU1mced8FlNfUYbpNTTTwwrN6VhQ2HC10RSejO3dx0pdUh2IxAopJbpa+glzKVh/d0I81/0uPUNJj1TdFfSK2zbzVQFoN7UwrpM0bgnIz+kWtZ5Yj6e84ox4Mup1BsFqeU2DDAHtogCpIPs+cXVlC7ttvz/JeCfAzQKPX7EoP2bmqq804oyGAGf67VqoxV7e1R0kc/8IGZ8JdmlC1aWsEm0j1lHoxKD5jjZSoKKI/cKn8Rk6Xla4ytxGMo/LIJWKks6/U0yWHIXMPOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVhfxXlSolgSkrL0PHcYWTE4XcpLREqIzRn4Sd2vopw=;
 b=Q6JAf/53wKPfoiLsZfephBIdrP1sTePLWmHkyvPbVQ0e5hY+Hl0rGhmkEoMpEkj+iOVIWdavs/608mOkQzw9L9S/dntOo4apNbqNFbkjQ44IG8jCLL4g0NchdF99KpoEZfuaGQowheztnU8O5u9INSPKfFpxBwOGvTMGrIXbhjs=
Received: from SJ0PR13CA0206.namprd13.prod.outlook.com (2603:10b6:a03:2c3::31)
 by LV0PR12MB999070.namprd12.prod.outlook.com (2603:10b6:408:32a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Thu, 23 Jul
 2026 08:23:51 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::e) by SJ0PR13CA0206.outlook.office365.com
 (2603:10b6:a03:2c3::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
 23 Jul 2026 08:23:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 08:23:50 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 03:23:48 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH] drm/amdgpu: ensure all userq VAs mapped before restore
Date: Thu, 23 Jul 2026 16:23:34 +0800
Message-ID: <20260723082334.606456-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|LV0PR12MB999070:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce973b5-5d9a-439a-3348-08dee893b9d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: Q7lmFM1J5d/sC46wLhf/cPKjnl4d0bVKSc9QAeGQRpeNEvE9gWlvZmN1/N5k/yCzZt+PxYXVJ3q0x8O4MhA8OUF+sHTleWl/WBUJT+6l8ZnQOo0Hid5YV0LtFFyqd2YnOyTgHuKenbQi+O7TJU4hMIlKRN36knJ0FnBgcFT34mPO3R18BZavA6JELmVRcpGhyiu67oGbwNpyG40OZRsA2bWAvokQXC/NbNPLynlYjXBSJAfMOMhW/hAPzDqm/u5Q+3YxuE0frj2F+YM6P56cBpQ9h+KjKh7eR7GXM0s7UAhdmswsoJIsCTtCjBh9dNvGz2oMgEpHbAL1znlP4DyHpbvDQdlX4IFe8z35M6K8kcILNA3PoepdgYSWU2Bnq7xCem1Iz/7AGYAdhkpTjZsbcTFF3Thu2pW1n7FM2hRHHzf9o4Z8MtiEzgWb88mXYKDriKZYXBnsYNy8PlosXU4+cgMuZrSb5UtW5+Ek8+oDopNt/5VKQBym9nDdnGZl0qmr/szODNxtP3k7NFgVnLdlBGFQHXVG8HH7ReTpLH5QB3aWNFKVgi7ZWkvQ7uNjz7tPR9P6y5Vwi9Fuc00VEKhszmR9uHkwze2l3iD63OIf4MSxZTov5ESb84MvPIpBIwlcNH9vF/A31jQpSjzboNHevPWNzlcFQVbL5cWLrKjs/0WQfELgp7pg6c4uPq+3Nt9juUNq9jSwleco7aR3JSRSkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RWnqlYGeBTwBkWACHzqKFpGbZreImpTzfAGVbS5HBNT6pp0NyNqgWGb/K84qO5xQoGzDBCjp2xTFqcAtscqKDYDetQ9hGXZIXUrCkvIOCb4jz5E3pCd1v681oSjvG5pA/yYJ0KAG6/1SCIvUVdtI3kUNJRz4On2ftkpuB7ZrDSsrxn3F/N+Q/wf7NakExvdEM8J7C1k2tl0KpzCmrXsnJCdDxePDpAVVL0mSUgJwo+ehr/Ox+RM7Ktdr3qTfSq97OZdZkI81PHdr9MPnomnIvXjqnparvktzy/sOFqbZslhZRRh4IyPqdsHDjzKT9WAqL7Fb2wFgQlFVtfHndgGRQ2HmM8O9ozI/tNiUKf0PuOAZUCBtOJPo7we75Y10Mbt/SgULyfr0yUy+XhKQGsn653AUlDhC037xyZRouFwg6yhU3abo1FNRRo9E6Xpy94Yx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 08:23:50.7433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce973b5-5d9a-439a-3348-08dee893b9d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999070
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

amdgpu_userq_buffer_vas_mapped() checks whether all VAs
of a queue are mapped before restoring it.
So that HW won't access any invalid addresses.

Currently, this function assumes all VAs are mapped if
any VA of a queue has been mapped, which is wrong.

This commit fixes this problem by examining all VAs of
a queue and reporting false if any of them is not mapped.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3fe10d6af757..2b3cb4ec4835 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -280,22 +280,24 @@ static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
 
 static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
 {
-	int i, r = 0;
+	int i;
+	bool mapped;
 
 	for (i = 0; i < ARRAY_SIZE(queue->userq_vas.va_array); i++) {
 		if (!queue->userq_vas.va_array[i])
 			continue;
-		r += amdgpu_userq_buffer_va_mapped(queue->vm,
+
+		mapped = amdgpu_userq_buffer_va_mapped(queue->vm,
 						   queue->userq_vas.va_array[i]);
 		dev_dbg(queue->userq_mgr->adev->dev,
 			"validate the userq mapping:%p va:%llx r:%d\n",
-			queue, queue->userq_vas.va_array[i], r);
-	}
+			queue, queue->userq_vas.va_array[i], mapped);
 
-	if (r != 0)
-		return true;
+		if (!mapped)
+			return false;
+	}
 
-	return false;
+	return true;
 }
 
 
-- 
2.53.0

