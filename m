Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D5AC5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3372010F33B;
	Fri, 21 Aug 2026 16:04:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VVe7w6Y2";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010009.outbound.protection.outlook.com
 [40.93.198.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 515C310F339
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8dLmbchd45NYF1mIN0vUqEzJYSoj0LhhKZzeKcRRb4VJs4j0He9DYbTBSinR0IKVjCMQv830QeK01e/3NxtwqjkhfPQbsVzV6WmpCH8rM6KQxQ8MiPZ1X9vU39tZyqnq2gH42ZPMCyUQcZppUrcABW4ZLOIsxL3fVou/aX3WIVt5+Nwz9lZ6B5yUvUCz073f2EmwA8MEG3xf/pTJMyzLPkp9mAfn/pUSh30Ksb/W7/MiiCGrLcVxLu+0C50dBvpRt3bnKFYuKOdnzzSDW2aWMyfmpfFhg67JYrtt1OCnkMjJthj077awHbF1TwI0koqn0r+9Kt4ufGsnsH5Gc3JTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0CFXAErGlFDfMZhioczH0K8+ieOSmZlDMcoaeOLXLc=;
 b=rHErz8yAAU2gX58CslmvNSZHdaUfJGbzfntFX7qR+b5m13m+QukZyH26cmhxA2I00XKTVBfHWE6YUKHvX2q0DRTB6yK5YBiMzflpDCORLDhVnk4JUY+xseJlNTBb38Uuk44k5/kSk2HehvDK6USNpOkv2CaVmTVAmBKd17HGZo6SnKoI9mjQvHOj+wIZ2T0OgyXuaPEnSvLmQiqFI6DfHeTltwH5P6+x/4fvPtO2f+SuCJ6nDrVrMrm1TQMZG6j4FV/erNnhHWEUx5AS3TJ9DqeQU3M5OD3/Fy5yZOzQENdE2IeDSlh/JWNAgowlJ8D5+OYmm19Kz8vsN4v/q/XlTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0CFXAErGlFDfMZhioczH0K8+ieOSmZlDMcoaeOLXLc=;
 b=VVe7w6Y2nWU0e2eY8pLZiwiKP3z9yuIPNng+golIOst0j7RpCLrOI7JKSrn7xBPdi+ysLg7EyHaonAjFmq9NQObsrSVzOlym90/MPPM4OW2e8UST3OSWIE9CBzhmOeuGVvrCbkyfMpWTihuJ8TzmyDiIJd+uOgdllcQn0HW9Fm0=
Received: from MW4PR03CA0106.namprd03.prod.outlook.com (2603:10b6:303:b7::21)
 by SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:04:05 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::38) by MW4PR03CA0106.outlook.office365.com
 (2603:10b6:303:b7::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Fri,
 21 Aug 2026 16:04:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:04:03 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:04:03 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:04:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Feifei Xu <Feifei.Xu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Disable SDMA Hang WatchDog in SDMA_v7_1
Date: Fri, 21 Aug 2026 12:03:53 -0400
Message-ID: <20260821160354.751604-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160354.751604-1-alexander.deucher@amd.com>
References: <20260821160354.751604-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|SA1PR12MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: 4733c6b9-d276-4464-0c95-08deff9dd243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HH9oDsCId17ei79Ix8J66EfZGDD18UNjXS56CVOHQWBTfnkpngkTFdietuTfyyOcNgCUsDZNUV5K1WwXVjEMQBvr7BvyBnAk4bwBqqCHp4eQfQkKhPq6X0jR/ej0UUxE3ECLmWwoDDb4L6QvU3hXrwv8NK50dyJvrTRTdUluaSr/wXIiZAQSAM1evtXeerJmzwFGniN6apLqRQCPAm+8z56mi1sTwDntfXo3tNoUzOKsDGrEqJBeSGJshOstmz40gAwn40KRnM3PuoV/pYFcjxkIMwG02roUXd1ApC7fJuoD5i0fXmCfS1tmrdj4gT5VJjuCpL5cF+1oD8unx85NfFs/JtQiW8pAbRoMdzam0ImX43kUiQGVx5SvzalLQyxKa6NAUzpBZhCLnnqIcisOP4qq440JSTGFnigiWGTY8wQP9Yg0BfeVBEU+SJEj01TIkeeody5UwoT2fyZUGmHlY/yQxG1xUytAtxSnvWODtMLIw7gDDZn6l+Zwf40BDTd/G+ckK1LyVKZLL7q6wAb+N5o0ro2IiI0tUjZYkbWSZo+7+EP7YaVwrMoIY5Dqe/+YTha9VmgxxLzSWAkDlHiOfvAzg1gq96qA+dg5cqNjSPDX4+BYtP/t0gKbem2xLZFqn4EDcUg/zL4tWRR7YiQlvh1cAHEMIyIxSruOLsW6mL/ziHJh55+huLSXiSWIku4yqS9t9uAsBVxZtaRBxb8fBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: at9/rRYBhVXm9El6I+TgdSsGq/3vTu0LT+3L4azomocCdIJZcJHktCFH+Y5aovVdg0uEpuZMmk6uodu7Vxb/edI/N16p6hLdc2vJw/dgQWYsv3lSRkG79STxkB2jgwtJORr5vig4A7ziRbymYVbOkUrz/2WZ6RwBeg3t3o3Am/HTN23OS/6TQkyM0GMif5f9rdnPJJndbU4HPo7iUhTtwQ/SC6YC4y+kDGvM3+xxl5paGym1aDTaLFkCCohpGonlKhSVQuR20FvJS2mdm4jqzU5ljecyxmIqzJIQ6RRXo053MzT2qvSBMAFbfd/HJUni28HHSz/9XwqG3mn5pCrdVPJwmr4+a2dPM9c+Pkj5BSnfYBZQ/HAPFmDtgO7dhlmNaccXZwjRzq04VVx9/ufOkwEoCyJLe/P99SwivNnxJ15ZnaM6fXuueetWgpUXbmb1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:04:03.4726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4733c6b9-d276-4464-0c95-08deff9dd243
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7272
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

From: Feifei Xu <Feifei.Xu@amd.com>

A temporary workaround to unblock usermode tests.
Will revert once issue resolved.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index 645f8b446652b..d1547b8e36fea 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -551,11 +551,16 @@ static int sdma_v7_1_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
 
 	/* Set up sdma hang watchdog */
 	temp = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_WATCHDOG_CNTL));
-	/* 100ms per unit */
-	temp = REG_SET_FIELD(temp, SDMA0_SDMA_WATCHDOG_CNTL, QUEUE_HANG_COUNT,
-			     max(adev->usec_timeout/100000, 1));
+	/* Disable sdma hang watchdog, need revist this when issue resolved.
+	Once issue resoved, the QUEUE_HANG_COUNT should be set to max(adev->usec_timeout/100000,1)
+	*/
+	temp = REG_SET_FIELD(temp, SDMA0_SDMA_WATCHDOG_CNTL, QUEUE_HANG_COUNT, 0);
+	temp = REG_SET_FIELD(temp, SDMA0_SDMA_WATCHDOG_CNTL, CMD_TIMEOUT_COUNT, 0);
 	WREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_WATCHDOG_CNTL), temp);
 
+	dev_dbg(adev->dev, "Disable SDMA Hang WatchDog, regSDMA0_SDMA_WATCHDOG_CNTL = %d\n",
+		RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_WATCHDOG_CNTL)));
+
 	/* Set up RESP_MODE to non-copy addresses */
 	temp = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_UTCL1_CNTL));
 	temp = REG_SET_FIELD(temp, SDMA0_SDMA_UTCL1_CNTL, RESP_MODE, 3);
-- 
2.55.0

