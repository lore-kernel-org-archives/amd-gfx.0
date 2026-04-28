Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81740FF8868
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 14:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14EF910ED30;
	Tue, 28 Apr 2026 14:56:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FdzkSBAy";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AEB610ED2C
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 14:56:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6gQEZLWsjeYmg1VsSOcDs38cG+zMaA7ua+7pbtO9ZPxBo4BjjyPPc4iHdke9+rHTttzx1Gz/OdikcGRLnUGd9rL5wsZL1f11SHx9H+4IkrxcTnrhAkAkD8tXDJjh1VOOScyRopvYBOtyIRmfJl587S7iI/EcvFLrbaf5MalDN88xTZzZ7eoLgOm1UdXzjQysiiv/WCZj4wrFX5+R22b8gvb7GvO9DSTUeeLnZFQtpPfXFI0d4piZvqcLSBWWoXa80KhzD7q5R0oJ96FHgB/hxYeu34kwfH3rnkun3SkD4KkscWRw8GK0QmwUjguXrr3IYX8FET+ZYGE8+qRuv8JZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FzmATW0jLkt/r2uIQpWdESxrALefDGgZ9DHvQFc/II=;
 b=lfpVD8688na7wC/2UoFv/6UjjMmJLQtGEuAPgJaJULVkyi8CcwrRrzySMsisRBSV5jlxuWnZ4DWqiB1cJqsnK+nbHC+0DjCFk7gGTN2B7KmbRFjWVW6scjit3zVV4/RjnqMGSedY9yf++EdptGOILFxbj0JzW1FlhyzmoquCigjBZ7Cw6ZzgdMfRmjWYRqF3LyjZCoFmmEq51KyxJksdOuKf9WutJkAKVtU/145otlgXcGP9ZQucWW2L8MtsG6ihWPcRr4/XmC9QjHy3uPJXPqdl6ezmV+f+/6Bnv2u/2wjDebDfvJ/2iRwsZN77B5inBhSz7xmjBEQ9+mvWTcXdGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FzmATW0jLkt/r2uIQpWdESxrALefDGgZ9DHvQFc/II=;
 b=FdzkSBAy6mHtflSk7sjfjvlX6r0/DlcG67f7vi4UEj0DUkKPqVZNFJTeZdoDio0n7kdUJ0Kwu33yy50gL3NrwnMzDmthN3yMkfspQ188dEkNNalzqU+xlIzvEHI1x5GlwZ9P3ubN4ML1h+/v2jzjNVcMRq4vYxwPPtfU5gCOS0o=
Received: from DS7P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::17) by
 CYXPR12MB9340.namprd12.prod.outlook.com (2603:10b6:930:e4::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.17; Tue, 28 Apr 2026 14:56:45 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:8:1ca:cafe::ee) by DS7P220CA0003.outlook.office365.com
 (2603:10b6:8:1ca::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Tue,
 28 Apr 2026 14:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 14:56:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 09:56:40 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 09:56:40 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Apr 2026 09:56:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <timur.kristof@gmail.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/pm: align Hawaii mclk workaround with radeon
Date: Tue, 28 Apr 2026 10:56:19 -0400
Message-ID: <20260428145620.1480646-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428145620.1480646-1-alexander.deucher@amd.com>
References: <20260428145620.1480646-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|CYXPR12MB9340:EE_
X-MS-Office365-Filtering-Correlation-Id: e373421b-012e-40df-561d-08dea5365d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vO5UMiOz0lxQBikWFQ/H4/78pQy/1rLth9KeIJ6Z53v9lEoUEL8pUxGzBblcoeCyFuJQ4dz+HqI09ROlmanJAZQTqYPkyD2ycvEwAHpZtKl84gmCuRuIdqT26k7ZBjhR/yBb7dgEZb+eEJ+5Cb2fw1FOHmr65RTknstp0Gsvh0hxaP23HsgUO+AE/XOncCo93LkwHgTS3fYFGKSCGedO2mK82bwSoWAt2pm0c+8aEUTZFV0M3leBLSW+ahqz4Vi/NXVj0m8X1JA7wGtlqhed3NU5NepQVBsPa0T6/vQNS/fxmg+r1ueIyfeA+vDUIQAbneSdB+g1p746R9/GIvYyaw6Q3m06uNcLo4cKFd6gZGO6HUp6lCIdbD1e7QI5X8esKG1IfCUrYWSjh7Se5d+dxty+HQY0/92L5g2lWAAYb/NcxQqVNcN8zuBCPUpd1/gzoKFscODbKFZdazHw6W6A7A/yu4ZmpBqiw8N/UNe0MqehtnhiUiJJbGsprnAT03ftr0r6qG6AaVrH5Xb8jlym6o2JNTT9N/J0wa9S4jO7Zo5D2R1AM4MHXhAJjZ+ICx5xRIarmfEEKPgK8abZKa9iiRJ7zZRYrkm2qHVIR9ms+l29F1E/8NPcGhamWVtRp22GHKxiuivFGSV4SEtxBIZ1n5pWJzTM7/tAS0EJxi9J7u4NaoCDkXmUCFewIv5gMMtJRArhMB7vov0nsgz7dSLzWEIldNJtysSLdTvrKdPBeik=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(13003099007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: flOXQNw87CcpqqXyOOZcMs0JStbl1YDDmGhm7tX6az7kWvTqAG2+zT+v0XdnHtodpQjbUy5w+N2G9uK7ISUSDtLib8zoChHG5w7zt51KjuRguovqBduOuqb/DgYky2kuVpeTVJ7i1MNt+GLMVTJPVN+MEQYfGJECAWbs+3XlVKb2B/QdyG45Xiq/MbrbCcKU4jWi1SCWPxRTJfpu8KRXa4ebSQ6GiQe0dvQ1v7BxPuAELYRy0Y6Nk3gUZU+7a7PEHMnBWWq7PrGqJ/hB4TYtJmjoZ3JsU4gRGc4iJAc0pUdU8FNSO9Pi99JJoT+2mSZlD5a2W/0RtpEG7lSyzMCQ/kuFApNuwGU5UIytSZbYPWfzEJ7AJwrijXmAMSW/++xqValARu9IKtfL+Z4FDyh6V9NJ1YE5VMb5gq/rk20dykr9HAenvFsNJ3vLYKq62HXj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 14:56:44.6557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e373421b-012e-40df-561d-08dea5365d6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9340
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

Align the hawaii mclk workaround with radeon and windows.

Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/1816
Fixes: 9f4b35411cfe ("drm/amd/powerplay: add CI asics support to smumgr (v3)")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
index 6e89a032e3dcf..aea3ad523cc03 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
@@ -1336,10 +1336,10 @@ static int ci_populate_all_memory_levels(struct pp_hwmgr *hwmgr)
 	if ((dpm_table->mclk_table.count >= 2) &&
 	    ((dev_id == 0x67B0) ||  (dev_id == 0x67B1)) &&
 	    (adev->pdev->revision == 0)) {
-		smu_data->smc_state_table.MemoryLevel[1].MinVddci =
-				smu_data->smc_state_table.MemoryLevel[0].MinVddci;
-		smu_data->smc_state_table.MemoryLevel[1].MinMvdd =
-				smu_data->smc_state_table.MemoryLevel[0].MinMvdd;
+		smu_data->smc_state_table.MemoryLevel[1].MinVddc =
+				smu_data->smc_state_table.MemoryLevel[0].MinVddc;
+		smu_data->smc_state_table.MemoryLevel[1].MinVddcPhases =
+				smu_data->smc_state_table.MemoryLevel[0].MinVddcPhases;
 	}
 	smu_data->smc_state_table.MemoryLevel[0].ActivityLevel = 0x1F;
 	CONVERT_FROM_HOST_TO_SMC_US(smu_data->smc_state_table.MemoryLevel[0].ActivityLevel);
-- 
2.53.0

