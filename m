Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AE0E6917E
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2024 16:27:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5BD910EC0C;
	Fri, 22 Nov 2024 16:27:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bHPk/n1F";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 995FD10EC0B
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 16:27:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPAGwy78M6gUG1xqTtRuCTMHcUXdczyde3SV3g8gN7DAquvbneyBbqr8Jn0TaLpWP3dWsMCzQyL3LINtSJCoh8oQCnnjZJpXCfUypEEulbFYcIXE1Cgw82nQcOFQntHRw0VH7Q5oodh5yRPQ+JluOYVyk3FUGahqx+PYpP/HirBvlcgPjXC3mKFoRbcmPkVYPyn2pEKyBa69I8SK4FXBbMNiDJiDHKnaN+EolSahvnQWJWmc8NzRWgyX57cK12Hmyh3Yoz3oKHQbJqfTOwXQTP0NhFlK1i0EM9SaPSWWilgsyodhogmVS2YBK/pzaR93LVLleDh+rU4XOs80wH8qMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1EpGL3Lk4jHTZ9hlzvYcPgL1i4tG5NKAwf9MxdF8LM=;
 b=spsxh8cSd7huc0TK9yqgPV6p/yWhBnndITg5yQTlR2lcXSEQUZBEPM2gzWamDTefo5B0WLX4R6YbUUTy/ynofNnb2Er77jrsEpmhgewK8JITsyyCRDiKdA5z67nA5QUfE7gSG3+0BvnjqtybAEssQLGEL2DOypBWQRO3yKlChKh7zC2wrRHZ8o4Zdy6ofLlJxq61ZuUwuiN9CqaPyTQ/2sSuR8CCbDcyv2E4v1kwtRdrjWQ8NaTL7EC+h6B8bayl9SsRHmdudAzSyg9id9qNesQDoB2YPvxPJnbrAgTn7uqvDwJ8JwJOM3uFiY50muxAniPdm2aGXB0tnQ+xUfh+lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1EpGL3Lk4jHTZ9hlzvYcPgL1i4tG5NKAwf9MxdF8LM=;
 b=bHPk/n1FzgwMNc4RVfDwlVTefeRGcsQ6w77qPq7JcAVQecMq/Kd7NbKQPJbq8oMff7uNtkedgUdI2Y9j35D/2P2sxnPKgpaxHRmYXO299bD+MjDfJBxm8dks8TiWKAIrLm/6KkFowWrowdmMwlmIItEn6s4yt63KebDW6hjUR8w=
Received: from BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::11)
 by DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.18; Fri, 22 Nov 2024 16:27:21 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::5e) by BY1P220CA0011.outlook.office365.com
 (2603:10b6:a03:59d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.25 via Frontend
 Transport; Fri, 22 Nov 2024 16:27:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 16:27:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 10:27:18 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, David Belanger
 <david.belanger@amd.com>
Subject: [PATCH 4/5] drm/amdgpu/hdp6.0: do a posting read when flushing HDP
Date: Fri, 22 Nov 2024 11:26:56 -0500
Message-ID: <20241122162657.1056489-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122162657.1056489-1-alexander.deucher@amd.com>
References: <20241122162657.1056489-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|DM4PR12MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: f310d455-162f-43eb-41cc-08dd0b1289eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CIlEQf2mE28WDFF2rFA+ULu9z57gl2VyalorrU1C5d4IlblStggeq0tTjF7a?=
 =?us-ascii?Q?UMCx8/WTzDARYSE3C5u8vqFPHzJ1xX6atE4xGUgeAXk/jmVJLRNq19sitGVZ?=
 =?us-ascii?Q?Jqd8Tfa7jqktLD1nIaqx0PFZ+InS5b40YQRbhxBQQJj9Y7SbD4uinbinXUZp?=
 =?us-ascii?Q?LCcXu/0V2S+njit6pQpe+GYqGWXopRGRTYC28Vzj7KxUiSBRZe2RaO3aT4Yt?=
 =?us-ascii?Q?0dTiBdjBWAiEO+7r7wiqGqECnT127Gf5CZrX24g1H+swO9Xc1CwEe9+TeAND?=
 =?us-ascii?Q?OiILSMP7zSjSNBlJX9oYwfgLmASHoBM+Uc2P0nnzx1cbjY/VVJz6fANcvAG7?=
 =?us-ascii?Q?NWJIpw/+0ld1quGeVZEHt3KxjQnqWHJ5TEZKVf/y7YW1tSy5RCyUyV0V0aYL?=
 =?us-ascii?Q?V85BaM1GB1qgHlvvFiogNnQcVoWNvsphkEOlAg0IFUZBKIV7fs+gURkb1+Y2?=
 =?us-ascii?Q?PAcYzPOyQ/c5Tjq7k7p6e9dS9J/JFAKndY5NMXKbk5vMgP+ODJlOSAizq3FR?=
 =?us-ascii?Q?lmiw/8B6sYTq8i5aCO2ZMPnJpALdhQ4cGnsVMnLvf84RC4R9743M+5xJ12jx?=
 =?us-ascii?Q?VEEgattzTNHyKMaD8mkjabNUwW81E+BK0eYvDLT/9LB/n7HlVpVmtasRrZvs?=
 =?us-ascii?Q?2QjvjkQaYWGq8RUaS2ub542+y3R1U2rebq07MudVjsLf8EvS3WnNziRwFhqf?=
 =?us-ascii?Q?lPboS56gKjcDZH1aO5yJf9HOZe8eSG3jXNk9ptZYgzMzfqoAGgiDhjAwq3UC?=
 =?us-ascii?Q?KtbR934hhnH2k6XG8Mh/eatWSvntLC1wxtqYLKzN7AQtSXOha3DAnNMjykBt?=
 =?us-ascii?Q?7fGh8xemq3fXgTS3XifJsSr1ZUS/QETgtbAES9omkU32EyM7mYIl3IaHUF1x?=
 =?us-ascii?Q?cWEtLBT4xGoBa9olrALi3xy+ocPIdZ4ppvYAzsrGnzJ1qWOn4DWyMKCH12K3?=
 =?us-ascii?Q?/8ssx2TvEUq8dVRBOHkGMBG5Jmqx9tcRFzvnPNvTnoO1JRNiOSC9VjtpzEMR?=
 =?us-ascii?Q?Y6a7wSw6+oxGJ/4TU2uhrUrx+Y3XW72Kj+MXe7gYG6Z5E4TlHdAH/jAk9tY4?=
 =?us-ascii?Q?mkHRCN32Y2AARTwRJ8fTh3wWzvrSsfhoVCZ6JL2mnywqKD1611JDalCG/H8t?=
 =?us-ascii?Q?lZi8U+WhdhGEzfrcoAWdCNwPNLuVx8NtT2+5IzgFiGga3wdLNoU0V1nawbmW?=
 =?us-ascii?Q?MqO4D1yxuNQnV7eXtfsHYriGd3pvL8XTIYR+ZAzURK91pTUAYFmPH5/CJTKE?=
 =?us-ascii?Q?P6bDcajMl5Vo4cGQYooqItCunxBVrYvN8Lypqb0ogPNg2X6+2jlJfWSpgezQ?=
 =?us-ascii?Q?pTkJZeX7f18YJdDJVg5zWbGLqBRezlye+fs/eYBbygZmMfe3ljfy0Cbq2QO2?=
 =?us-ascii?Q?T01W5vLRHrz9SjvOzLlmDUMQJKYWlKpteksZh8IpDzUGYfSJua1kJIAAd/Ts?=
 =?us-ascii?Q?XFk39v93dAps7k4yfg+Hx9UnDZoAIQeQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 16:27:20.6129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f310d455-162f-43eb-41cc-08dd0b1289eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6592
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

Need to read back to make sure the write goes through.

Cc: David Belanger <david.belanger@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
index 33736d361dd0..6948fe9956ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
@@ -34,10 +34,12 @@
 static void hdp_v6_0_flush_hdp(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring)
 {
-	if (!ring || !ring->funcs->emit_wreg)
+	if (!ring || !ring->funcs->emit_wreg) {
 		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	else
+		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+	} else {
 		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+	}
 }
 
 static void hdp_v6_0_update_clock_gating(struct amdgpu_device *adev,
-- 
2.47.0

