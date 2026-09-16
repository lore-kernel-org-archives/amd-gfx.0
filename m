Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD28C88E5C
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 09:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26C2210E1A0;
	Wed, 16 Sep 2026 09:27:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="34bJC3oh";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010038.outbound.protection.outlook.com
 [52.101.193.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B13610E1A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 09:27:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlglgwShO0fU8dmFnAFQEPzuBd4cU88H8DuUjVzU6VVbCQ2lrxJTQispuT4xpCNesbtZysYQUcD5iYTmVINLsr6LxxmbW2by8Xc+zWoZK7SGnrEfMJxGQxpO7KS6OvUHSBMCawUUaJ7ClWBfdLVlsw40rIV56aQXnS4bjbxPazbWkWFFmrxHMxk1afu5gtLI3CaMukv7wi7wCAXxUKOPld/ub+nPNebqVdEug2ARNHTcWdd4a3qotdK/4uMXUtyNYa7nlg8Rxm8GyInW+P6DPZh5O10wTg0jZajcYfNoAkyLfTkVzH80rD/xHStLKdZSHWOYJCQAfehYccYsK1c6dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4RZrt9Uyd4na9Yb6D7NkGvTIuUP6VUxJdfVhqujFwQ=;
 b=tJqSsM/6jVZtiU09OiJUvax2Jt2H1ZbX4CsDSHprYVB/GesUzHc4hSCXwM9VT9D8fDWG/BmBFtsbflRfbzyTKyWvjBhutPsIonb3hIjFXGDEeZqF93SMcnvSI0coBfnAOgfqzVGRU4SvX++HWaRSvYdCCu914Nmg4HrEvxkOZprxuxzvnazA7MPWWqo2G4rAb4xVGBrMehV5Xd9IfpYNq6+zdbFgGnUE/K7rm2CESJIp8O8Dh7RVd02iY1dm6RgBUH4VLvn0HDkk9JDl4fAyY3wneFBi2jKlTX9e5BmG7pJxiVcwbAfjD3rKN51FxcYsi6tBtlSLr1hwBC7JPUpwRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4RZrt9Uyd4na9Yb6D7NkGvTIuUP6VUxJdfVhqujFwQ=;
 b=34bJC3ohfhJTVAZPEnmQrIbAw31WDJKs/aPnNh7aUP2azf9ERAJxhVRZcRiulJAlOqgI2uUZ5wjVT5L4GS4hqzBhTsKnGtQqP26haFkWeZV67wawvHVlklvsIKK5OgnPf+4mNNTG8gckm2uZ46InX5rOszMg23QTYxOO5eBjm5w=
Received: from MW4PR03CA0020.namprd03.prod.outlook.com (2603:10b6:303:8f::25)
 by PH0PR12MB7814.namprd12.prod.outlook.com (2603:10b6:510:288::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 09:27:49 +0000
Received: from SJ1PEPF000037A6.namprd04.prod.outlook.com
 (2603:10b6:303:8f:cafe::8c) by MW4PR03CA0020.outlook.office365.com
 (2603:10b6:303:8f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Wed,
 16 Sep 2026 09:27:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A6.mail.protection.outlook.com (10.167.244.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 09:27:48 +0000
Received: from canli-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 04:27:46 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Thomas Chai <yipeng.chai@amd.com>, 
 Candice Li <candice.li@amd.com>
Subject: [PATCH] drm/amd/ras: enable UniRAS for psp v15_0_8
Date: Wed, 16 Sep 2026 17:27:32 +0800
Message-ID: <20260916092732.1054500-1-candice.li@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A6:EE_|PH0PR12MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: a49a4a03-313f-4841-78f0-08df13d4c5d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: JnD58mUnQ7/7ycmqfujHXbcNMl+PocjOyrB3T6z9sWRb1Wk+0dOwFUFDRnJ0k3k/zR93psfCZ8uXqNZ8YbVUrlqkUcC1f8vYXYnrNhAjpr/q8fL5je13Qb4XpUxRuVnIAw9dEtvaeagkncdaP1OABgvpoGTnRNyuRFCiUr0iMXbZt05YQvVdupKS51E0skwcqB8vTxX/hbN/JE8IjaPXK8JkymcmyqdZhD9PjTJMSBf83Ann9jVpakSmYcseuoAvYULEc2kYUBiI1gLckMtj5pXbtzjTHp30d3MyzgIO/0oUyP8M67q9xTK4GL4YHk8oJso8nNXzHUCdCQkCH7VzFrbG7WcxDU4CYgzZyzMmB/byKykivIp+ZcrHEwtGzhfTEb3Z+4ydcrTv5CkZWu7StalzNL88P0AiW7Bp22UKmCJB2TNbRMVJLpzWQhNmDLGd2tPB/KKM9Q9fdI3N1rmPNY7CO4ozgGMjkuhWELIIf6eiw+37fx6BxW3HGI9s6eJ4mQvEPYABcZqBqSya5Mvn2h2LoL7aRvkrZ9K87rumaIsFylXXQYb6suUXZgTSPCeJlVUq8Lrs+Z8+B6qPBsAfdhfxnzWbXRVTyRn5zMwasnBEI+6lXA6yVrSQVFoNtO2FNvjzIlf2mKH2frqM8DXlrddX6ZEbJcKuK+Ft1a75gygw2qEt1w58l1nVhPbrq4pT73g20JamEp2dz/qjbGiu7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nrYW7g75MsNiwfEAMMutv5yHWo0m+DcKGkc8Po8+nK55anL//KJHERmvRoFUzYt8oXp8YjDMSbcY0i+PPtJkUQaBMUbmvMhnS7niQgPPClwSO0CxV7bA2+cms3z3Hjx+TIusGAFbH8C1X12PcfU7lH4xgedU+D0s57VvUkZH5bzRYi7LyQENm7tUzShY1MP2qliHNMZ7IB7rjNR31fOkrP+Wo5H4DXiziHdB06pYu+J5bLPD8VDWO3H9XGBVv4u+vIpZO5OCStqkxn17VDjxaBeWNnoWTCnKa7iFkt7BJDmq4MbT0NTVrTtEfqjeiU3mqyKVyuA0pXCTtxAYN8+0Z57gvcHSSvYI5dvm1lseo2+XvwEJUnOp9fiEa9KUlq15YgGsFfXPtYxAbudgXqgDjydvC91tgQRK9Ig0lWayXCtiSQBKk1xuO4CAC+QNKPHY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 09:27:48.1705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a49a4a03-313f-4841-78f0-08df13d4c5d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7814
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

Enable UniRAS for psp v15_0_8.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index a02167397ce28b..e893d9901c08db 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -328,7 +328,8 @@ int amdgpu_ras_mgr_sw_init(struct amdgpu_device *adev, struct ras_module_param *
 		return 0;
 	else if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14) ||
 	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12) ||
-	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6))
+	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
+	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(15, 0, 8))
 		con->uniras_enabled = true;
 	else
 		return 0;
-- 
2.50.1

