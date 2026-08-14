Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494B6C5B572
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A68CF10F70A;
	Fri, 14 Aug 2026 21:03:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ongUJd7P";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70AC210F701
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lj/sVRCvSHalvDmXGk1VHCOYZfgJlmcSNeVzq6E6GoqO5E7CpmCmNmx+HBoeZpr4OZUQPbtgFspJN69KPSVRWmD5rtSqdjXi6nsi8RBgkw1oGXtpsqUaBo1K79fZR5kx4RC221kuPSbC5WS9ofT3xWpQrM9UvHDbxXnZQfkUPikIvDUyMvkbB0vRMdasjmOTe4bfZIATOVGCNvA3A5LJEjCZPJsul3UnL2+481Knp8bcp5SCpeqhFAU2ZvFEKwtjpYgIITf/VRpkmiy8EtRj2q/CqVHWQLn7jRwkXUMnaJg0K9Eheb1CFDpOa4sAvBhpU2/qKDsYdsZZneY/DelNnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pruXaSFVJeDlNFRL+6DmvLKeeFP/YjD3KTYNWlPGsM=;
 b=ZDRHzBVF3CxUJFK2DZHD0RAf13/+zOIu4sNDPwBYWyAmGSwpx8vRwIkak4QqpM2GkbdmBOoaFPlJwuIu71NgaxW1y9jgW1Dm1Eiu7KQG5mI5qR7jA0I/Ls7eihe8HNZpxlQImre6SuT5TceiC7145fI2HUo9IQm0zIWaz6Ju1V5lHYnWKvQzdsUBDkKOYZzBjt26E9LGDdjrgPdAyLHIukRvbaMjr8E4/LPGWBIz382bBeNvzx0BMjMzMmfRcQPBbXDD3diKBLq3YDmViuBpdg4VVukqxC7+9gLJ3AXa3zc9huLn4Jzf8kFXwWt91NJ9sxluF/BP2f0w3ZZPfamjfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pruXaSFVJeDlNFRL+6DmvLKeeFP/YjD3KTYNWlPGsM=;
 b=ongUJd7PPZAp9EflelWBW3QED3NAcdxqYM0ItCuxWLM66LWZhBWI8rSdaENNKQOpgkN7y2vQ8JAmVypm2ohksz5SgJvU225rYsS9k04NBxqtpNAEm4g6Y0rngq3P8ZLecDJTb1/rG+3rwCL++t56tPdxacomGCD+Rxmb8F1dbHk=
Received: from CH0PR03CA0340.namprd03.prod.outlook.com (2603:10b6:610:11a::28)
 by CH3PR12MB9171.namprd12.prod.outlook.com (2603:10b6:610:1a2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:37 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:11a:cafe::4a) by CH0PR03CA0340.outlook.office365.com
 (2603:10b6:610:11a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:37 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:31 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 056/109] drm/amdgpu: fix duplicate ras debugfs node creation
 on driver reload
Date: Fri, 14 Aug 2026 17:01:53 -0400
Message-ID: <20260814210246.3067612-57-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|CH3PR12MB9171:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f62658-05cf-413a-d3e9-08defa47827b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|56012099006|10067099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: gvn+X1x8WSv6wAQa6ucuBVBNLK9ueapVE0IddSvnU7NyvZp8Jbp1+smfQfPbseNOB7R7vunSf+If1Si1yA3vww4zeXOXY1lX1cGJEqcDKFrADW0Fr+bsHm51ocEWWXyN8ZiV5NYMpsZIEHI4mjdiUPGa+r8+rWzlVdO2q2qThxugNwgH7RMORKPbbrHCDTlu735YvE1wlsF1pCjcTzMi4B/Oxs9KPkEyaL/UT7wprn8RUuTWaGi1SlK2jA5gkjgmlg+pCDDuSmet754SW8vRd2BRqgfk0cJhG89jol95dF6Ce7j8D5K2lxPfmbz7NcounLO2oRb+9HZRPLIusb7Uj2QQfBEcxCxqLFb26q3SQVnOH/WxumT/vPa64s2g7EfjEwD1LG4p6Cz0Xeah98ZRqp2vMqKZkQEIlIanPpCGNSJPuXhPUVS4AHFmBBeIWBTZ+EkCtLfvCp+/esg3N8LyVs0IDVjGt2yRE+PoC6B8ZuCQ7HZMg2zL7dQCxQ5AE8tkzhoLLAHd00PjwvxcREPXwTOWHRyUVFD9EikMK+MCq9BBG991xFEYuSlpL15++6gZpqumgqLzo55HTG2w4Nb4ZFJN0P/fuOlrREIDRb8y0MiRJTjFo532/cS6XlkP43hXnSH5qst7fJ8Mrb9wowbSddHS+pjrHYYwzxzdnrCQYLg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XqPiF+AGbgYzXSmUWAlR23oULPZrKXQHHIhZPutyTVVBYzGmBNRssauVUyk2SpGJiq7mhzjNYlnDiWZQ4NPAumGbpCBk1NbgCNMp7hf7Ho9/xUfjJcJLboZF0+Uz+jzS11bWYSrQgKaPrP5K/Mgu0uhvi0b4Y1L65QHdWHzwWmg1pmQzHiPE9TsZxSwL4LWf6K+Ja+JnziS6lh6vsgV5J1OnP5XnfTTHzVSwO2pyvLAKLIvM65rguyBLTkUc3rDJmFe631+YZuBUe/dHoZWqjvYR5HuEEPpdSVjSjviLdx81G+VVOBiRwJsVtyCeyxHiWc6L5TO+9fnz+jVKXGShFZkIng6W42sSL7QelCCCUrkCLnMqborqKE1tMoy/M79X8Tmty6dkFpBzDcOd7U6XIDvI1swQNYR9JaIEcRMoxdqbWIkhYEIawBiLWW/gBM4N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:37.1699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f62658-05cf-413a-d3e9-08defa47827b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9171
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

On A+A, when ras_enabled is 0, the RAS debugfs node is
not deleted when the driver is uninstalled.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index d3872e4787460..13297b6f062b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2190,6 +2190,9 @@ static int amdgpu_ras_fs_fini(struct amdgpu_device *adev)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *con_obj, *ip_obj, *tmp;
 
+	if (!con)
+		return 0;
+
 	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
 		list_for_each_entry_safe(con_obj, tmp, &con->head, node) {
 			ip_obj = amdgpu_ras_find_obj(adev, &con_obj->head);
@@ -3985,6 +3988,8 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 
 	amdgpu_ras_mgr_sw_fini(adev);
 
+	amdgpu_ras_fs_fini(adev);
+
 	if (!adev->ras_enabled || !con)
 		return 0;
 
@@ -4007,7 +4012,6 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 		kfree(ras_node);
 	}
 
-	amdgpu_ras_fs_fini(adev);
 	amdgpu_ras_interrupt_remove_all(adev);
 
 	WARN(AMDGPU_RAS_GET_FEATURES(con->features), "Feature mask is not cleared");
-- 
2.55.0

