Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A0CCDB47C
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 03:13:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FE1110E15C;
	Thu, 25 Jun 2026 03:13:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5opaKFxB";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010042.outbound.protection.outlook.com
 [52.101.193.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22B6310E15C
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 03:13:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8qqQ/E9/xf51oK0GdBwZBDryoaIUVpqIK3hSebzwfWJ1W6F8LUyobx5ffYNI87+HNoJrbu2Rr8vt5Avvg8XuSONp1HBVNIZNatBrWlGHa5xFBUPptYQA8juqMaw04ml+f2Y4fpZOuZ0HVo5BK7iYM4t295jJwYGI4gaMdr0MoCZ3RNXWcUy7WmjnJNaSlGtAchzIUjiLkKgbfmAzVv8pptUViJDdFmFxLVi/dfRkWnCh1xWNgOB/cp/sSgoDu8EbDqyiJs2ppTpjic2PaSOmmNrignWNoh7cgCWw9zpFCNm2PPny8q8rUqil48QQb9akXuggSiVlk66r7VjyOppDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvURJQAHXfF9IqcJulOqcjUTrfE88pyhX4KjRam98eg=;
 b=HJwSOgFftrGlZlC/YgX4kLDkVWC207oFmMLZ3nJntlpPY2MtACzc/ze+KbcFLujD96zs0z42neE7HinmEPAdPN/9kecSXfa5x1pQTE7CzK3++NLwgomqC+kJ1Hir+rmN0ji3w2VJmhYaCTJXuo+b7ep6iNPIHUdAwNC6/6aDRt9lM21lil3SgfDrznFMGIJwMilsrPRFbmg1WrQtaiGt6PiRjgWRALu8NZXVoApLgXVFJWcZPpadtXhCfVoRbNFZw3CoeO7Omgvn1eJrkF3fVq/U6OGWn8Iu0n3EVgwqi51Mj51FSkNobPfIGGr3rBTf2zCCu6ozLWyI63g/g1HKOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvURJQAHXfF9IqcJulOqcjUTrfE88pyhX4KjRam98eg=;
 b=5opaKFxByRiZvZPiozuKkiFpZUvBPCwlhq8zkDLrWpfOsil5FN9R+p2gbJpt/sylCYu7A612jqVVl0hqYnf4IiWOAC+ADbUf7ZUV6BlK/EUkmqiAAeruuJ+/eU7HsUc4y3bRKoBsxuKtcPJJxRDxe2RgxPljDA9Nffalf/Es4PU=
Received: from SJ0PR03CA0236.namprd03.prod.outlook.com (2603:10b6:a03:39f::31)
 by CY3PR12MB9631.namprd12.prod.outlook.com (2603:10b6:930:ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Thu, 25 Jun
 2026 03:13:07 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::1b) by SJ0PR03CA0236.outlook.office365.com
 (2603:10b6:a03:39f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Thu,
 25 Jun 2026 03:13:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 03:13:06 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 22:13:04 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Shaoyun.Liu@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/mes12: set doorbell offset for suspending userq
Date: Thu, 25 Jun 2026 11:12:52 +0800
Message-ID: <20260625031252.298647-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625031252.298647-1-Prike.Liang@amd.com>
References: <20260625031252.298647-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|CY3PR12MB9631:EE_
X-MS-Office365-Filtering-Correlation-Id: 74515957-dd53-426e-b081-08ded267ad8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: q7ZDs7rHKDNnGwY9aqWK1QOCfkgsusVC0clx770C9Sn81xc9UWNhtfryYGv3MoBjAUJH+tiZwbUCeUHQuKu4bz0hwWPsDhiBb6khxMBF+iA/fZssLChnYf8hZy4cg0d1TYBZ0XuHYtw3RFyS5WIp/2te6ugdTL4lexJaeBDk0R5FC8sOzQi73EuYWFrXWYv1gHWyWbHIwH+GB7pBsJiHsqbDRUWoquDzrWFWvKuslEb4o84JvQPozFjWyCgYdm/xmLHtdfZMBhfnb9btXAyLFYDaH2P9hE9BLj4lEb2r3LEsJETDbVvyxRjKeKC1GCw+JIiKWKnQzEq1RFtFHxlzmoihYCHNgXI6RSHTQy8phvJPaSarBXUGRsFNpKU+tGgtirFeJaNwtOsRdxULWFlB3kC1uQ2+3T4xzV+m5+eOgPE2k9Lq7H/g/jdjNqLsAo+e9Mgro3+XxeU4vl2xm2OWCeT2jmwlt+0FNVftXRkTKWK/ZEfKGru8vfkHTAj9PuTIB+sR1c6m0OUKslDam8naqvEHMvr/A1zrwT0pws2ZZn3CFch7lbUIQhfMXdn40Zeas4NUpSZ4tQ4o1A8nYrMxDTFHB1UOqmfnm1rNEIrz4riymQ0Oc6Y+eMjm1N5qhGEITpBUJNk6fLGcrnYsumXNIQhSS828E3R5Zz6jEkspN9VC2/6FoxG0Sjd1UfyW4QDDwe4zlw8fQwkNfBV3CDmrug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C8lHdhngYvhRyL9k0xpal9e2gV95yme2eIsTIs4woScl6+QrZ4TYwjip5v1rttuj5Z+PU3QO9U4WYwZqrZpFJTJx4UlULIWhOx7LhHSNHy2zpghwg225uUVV1OwUvGRlbfoqdn+CeszM/FrfK3uvbSaIZGmDdmJZ/Q/UllAEk7CEiTmMNRhu4YUdEbpBdlBNGdsfXWKtSQ+SerazKIg8BgfgBDIzth5txCTms/1TAGl89+Q5WGmUU3LGXr4Y3sNiSu5TBLv1b3yPHjc8lQQsylk40ZzDGusYRWuR3JE/BISCCTM2UmUFjVbYXDj8b9d+QFgON4PFTLkliF5mTYgr1Uk6fViJGwxw3iXe0w4El3o76BtDc62r+w4zuCUHpwDygxxA51l47+PractxAWW1bHB8wl1t4t357R/+KwYX2Pl9PNVTNOJohRumPxakQTGI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 03:13:06.6846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74515957-dd53-426e-b081-08ded267ad8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9631
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

Updating the union MESAPI__SUSPEND and union MESAPI__RESUME to
add the doorbell offset for suspending userq.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 20f4fd57b1da..cd58ad79a377 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -792,6 +792,7 @@ static int mes_v12_0_suspend_gang(struct amdgpu_mes *mes,
 	mes_suspend_gang_pkt.gang_context_addr = input->gang_context_addr;
 	mes_suspend_gang_pkt.suspend_fence_addr = input->suspend_fence_addr;
 	mes_suspend_gang_pkt.suspend_fence_value = input->suspend_fence_value;
+	mes_suspend_gang_pkt.doorbell_offset = input->doorbell_offset;
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_SCHED_PIPE,
 			&mes_suspend_gang_pkt, sizeof(mes_suspend_gang_pkt),
@@ -811,6 +812,7 @@ static int mes_v12_0_resume_gang(struct amdgpu_mes *mes,
 
 	mes_resume_gang_pkt.resume_all_gangs = input->resume_all_gangs;
 	mes_resume_gang_pkt.gang_context_addr = input->gang_context_addr;
+	mes_resume_gang_pkt.doorbell_offset = input->doorbell_offset;
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_SCHED_PIPE,
 			&mes_resume_gang_pkt, sizeof(mes_resume_gang_pkt),
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 8007a6e69305..ae8af2d2dbae 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -494,6 +494,7 @@ static int mes_v12_1_suspend_gang(struct amdgpu_mes *mes,
 	mes_suspend_gang_pkt.gang_context_addr = input->gang_context_addr;
 	mes_suspend_gang_pkt.suspend_fence_addr = input->suspend_fence_addr;
 	mes_suspend_gang_pkt.suspend_fence_value = input->suspend_fence_value;
+	mes_suspend_gang_pkt.doorbell_offset = input->doorbell_offset;
 
 	/* Suspend gang is handled by master MES */
 	return mes_v12_1_submit_pkt_and_poll_completion(mes, input->xcc_id, AMDGPU_MES_SCHED_PIPE,
@@ -514,6 +515,7 @@ static int mes_v12_1_resume_gang(struct amdgpu_mes *mes,
 
 	mes_resume_gang_pkt.resume_all_gangs = input->resume_all_gangs;
 	mes_resume_gang_pkt.gang_context_addr = input->gang_context_addr;
+	mes_resume_gang_pkt.doorbell_offset = input->doorbell_offset;
 
 	/* Resume gang is handled by master MES */
 	return mes_v12_1_submit_pkt_and_poll_completion(mes, input->xcc_id, AMDGPU_MES_SCHED_PIPE,
-- 
2.34.1

