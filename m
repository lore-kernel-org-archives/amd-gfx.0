Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBA4CD5BAF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3993210F487;
	Fri, 22 May 2026 00:22:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pw+cJrDY";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011039.outbound.protection.outlook.com
 [40.93.194.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1908D10F487
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lgg4rxBu6Fr87L/PuJObop2+Gnq1+p1z+3AH0JX8TTs49QlVRvaYwjfV3qjU0M+gZfyRZXb2EYhactwann1assJWbRjCZBeEg2l7P+LMH/7Zim2sW7XYMUNgqk73Obd1LDQ2rLjpyiR85fwgbNGKdP1lokb3SACwXL/jlI3TtvFA06CfEiMqZgBAm27adqqJmPUpGTzfq2Fn+WRDCnDQ8ky9MJOgYsJxpYF1buLI2jSAVYoxHUa67rI2ox4l9ySUJ2kKaRkY2vpefGR6bWFpRcdRNRrhBsUuJUMpiULYv2gaQ2oS2KaVKlY7aow6O//rArgGtuJl32Bb8us49pBqPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aD4hCnqa84k1y0f4+ojhAeaP1zilg72m5KcTnpctO+g=;
 b=GHHUkMV/krtlviz2eO4CBQmICLMwRJA/e/y53rscHV97+zCGTWy1QsanO1EZR7bV5FCPFSGj5uSwPqJddaEWyOq/7sxsXjorytp/r9LhD3EBQru8MlTdVA6gvI1dEF63KVshefFKCQnb6y6rAh1yRaLB+R5x4kr4vkJj1/MtzjMiDU/lMVMFDeXQxssftvRlETULf4PMkxMRh0IjJqqVQ8r4Rs/3lrUpbtqHyQXnguf/fSeMH+2qwoTqAD5b7GWSHXjBjCvHfCkHssFutA6v/DGcRiyRFVO1XrOsPlEDd9D3MQvqlgae2TI9gBhZA1IfxJt/EisnCxOHgLA2N2l0nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aD4hCnqa84k1y0f4+ojhAeaP1zilg72m5KcTnpctO+g=;
 b=pw+cJrDYXZqlh3PGcQWIzjXfNDXKABeMVt6wkB3nroKNjhaqXcNoSZmEqz6GPQuL0ZtBsV0i2pGWrDo5W9dHCmnF2gVRmSAdNecvjSHZkg3Cpotj4PPTiDYFa1GYhWNJHlr+1C6aJdkTU+2cYgEGYLDMsD7rVMCffP7YC0OExmM=
Received: from CH2PR15CA0009.namprd15.prod.outlook.com (2603:10b6:610:51::19)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 00:22:26 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::c0) by CH2PR15CA0009.outlook.office365.com
 (2603:10b6:610:51::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:22:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:22:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:22:26 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:22:26 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:22:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 41/42] drm/amdkfd: Update queue reset support on KFD topology
Date: Thu, 21 May 2026 20:20:47 -0400
Message-ID: <20260522002048.98506-42-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|MN2PR12MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c4031f4-fab5-4b23-28ea-08deb79833f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|6133799003|11063799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: z5tqGRmE4LzkZQq6u9yvWGxBoIGJN4fu8Qwed9py1lK971RG5Di3yrIqBtyhTqDozmIHwzNu0HHMWEeNaGv9Q+TcwXxkdyahFmS0rMsMEOpJqhLBry5UAflCyOMFuRehSHiKLeptPIrcTsBtcHWh02CCKY6BjW9mbZ7UYkgjH7/9Lc4AwI3Q/7K7MEOTG7JePUrMGNGlIEtL3kcmW8vRCRfbj3gMnKanWMLGUqEKsOTv4yl51GJHZMAt3rnsGi90TYMcd18DylpgPpoWvt6g/heYXLLZxtA92mgoitwPq/QrobVv5fScqziX72KIn19Ez6OI3cCIUunjah3hLFLpnA6NqdHTDcV4fjHP/vpPuol5jNQ1NmbgYV1Rxca4tTht0jRKulcjd+0XP5oLS1G8KTu32lm8ErZhoZQdwmhXWNvzhLWYFeBBGh7KcS6nJGJyJgaMAahrTRV0+WpB11YxipQpyl8Oel9g0bes2TNfPm/D9MnnkLx0/z7zUH55DwFLXPUr2QAIeq8zbbXaEU5ExqTiQBfT0ScrpN/Nnz9azNxbQb68wwJYyBX+UY+GF2BiL+mbt9jD2tHEdYJwskMKVgft7arnli6E2HUTuWK4vH+QUOnHZF2pXXIKk93UbORHGplam6PoEFQ4JQOiEmiWyhnxDzodOYBFJc9bJ37BxWYYhIhYPiUksGX4+slmtrooKicQnGHagvKqk34r0s9avoxAnyYRVCXcCXiP34TobUQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(6133799003)(11063799006)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CyT+uUnL2ucgFFW99vielJn+vzI0tzslf8mP/w1Q4ECHqfzb8mzcvJ4G6a+p558KnSwQO/RpO9mmnrxj3f8por7tXImwMP99aGt8QEaKf9qLeiRdgnaaLrrtHsD5FDzPwqS1BWsbR5Ec/LScSXHz6C1xpuUCuWAFKPW7/vfhRWrn8+P76+lusNEmR0ZIWtnbDQvVpYPft7vWOeO/fLT6MC7V+89vqEN+MdI9vHGB8xvWM1j23HKB0+z34kKS4+xTkbtZ0S+TcaoRlHcCtAq3eIEN3cnDlCEIhDjrXhYpZSBNjsrmNNlUW/NsU/jehZaU46eDDhyAs9gvXcxtWsTBrsVSKd+58RxzkYey55fY0QGK1aDM3AlRqH3Ko2bdMLGzU05EdZ/IMbEMZTXtlTGy6o7Um1LvhY7TlJRvoIHo+bJE1vo7lJT42gy9+Lwz2ny2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:22:26.7750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4031f4-fab5-4b23-28ea-08deb79833f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472
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

From: Amber Lin <Amber.Lin@amd.com>

Enable user compute queue reset support on KFD topology for gfx 11 and
gfx 12.0

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index f37c2d3c84160..c46f153112e3a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2025,10 +2025,11 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 			dev->node_props.capability |=
 				HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED;
 
+		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(11, 0, 0))
+			dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
 		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(12, 1, 0)) {
 			dev->node_props.capability |=
 				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
-			dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
 			dev->node_props.capability2 |=
 				HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE_SUPPORTED;
 		}
-- 
2.54.0

