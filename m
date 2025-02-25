Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D353CC021B8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:38:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E80510E582;
	Tue, 25 Feb 2025 06:38:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qvs1QY4q";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53EFB10E57E
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:38:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPkwvZ2qP4iTH7cdDjtN2GZOM8ep99RYDhyNZ8wvoR3SEefxFMG/6sPrseiqonXaYk6vwDtpux01h+wkzYrSsV4Ww9aEzk46HzyxC/TXnxH02tutRP0EDycMIi5SDxIp87YWKDwXji7yn33+9nlHadHMp4Z2xy6EXLbGy3FgzUDUUQErPKDMYMBbG9bKuBZHkb2sLN9Dr/994mM97+rZBXRlioPIYlD2pbeLo2LlISQ1amGT/qvaA3bBoQ5imPzqlwH11py8QhUKFjx4GiWUP/Ck3Qm9piTQyXPOZv3AlecdNIgg7aV74tNwApExJe7jKfb+AyGmTtpYVda9NUYE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAVFK+RU1BURhElswATWMTmXc8RsJA8ZMsGBh3rWSYM=;
 b=OWUiUUWOBYLdFkFMPxOT5Zjkrvoe3OEQyJdESOC/jGF+fVavTfbcVskrugom92X3BnYJZf7CILnI8zG5F5ysisyF8Yg8BoAt7Fc9GC2gld2lH2oKX6H8AMHd6v1JCLqqMVvvRJeKZRZQINe/Y/8dJfB+uA7nbF74v4gyn/nbt0hlcBvLgQS8BN+zcm8I5FUudbiF6glKVdDgJ830Qp/b3ih8fRfWGDziUezukN0ETnywrA5nCJFuG+cGHhc6NFqSVAvT5VKoh3GgMtBGxYL809wvsyM1NujTT52ArU/FBYkf8vpuZ9xLZxqa5Yz0XFOR2H3VBLdwFd1FiWMGYCVVcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAVFK+RU1BURhElswATWMTmXc8RsJA8ZMsGBh3rWSYM=;
 b=qvs1QY4q9LlgKH5Zyp0Td4PUEI8mlwsOlHYmMzyNWCi23rW96PUzErdwg7AIyxaoy6zsqm/wSTC6ROqRciqTJ4Xxwl4G8Xemt9cRg5NAyFR+nQLRIT1OpkOw2NuOUz1HaSAm5YMj7VVAzOiIDOiH7YNf/qjwuCIj9O8nxOk6LqU=
Received: from BY3PR05CA0037.namprd05.prod.outlook.com (2603:10b6:a03:39b::12)
 by MW5PR12MB5650.namprd12.prod.outlook.com (2603:10b6:303:19e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 06:38:18 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::d6) by BY3PR05CA0037.outlook.office365.com
 (2603:10b6:a03:39b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.15 via Frontend Transport; Tue,
 25 Feb 2025 06:38:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:38:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:38:17 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:38:16 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:38:12 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 21/27] drm/amd/display: Change amdgpu_dm_irq_resume_*() to void
Date: Tue, 25 Feb 2025 14:36:04 +0800
Message-ID: <20250225063610.631461-22-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250225063610.631461-1-Wayne.Lin@amd.com>
References: <20250225063610.631461-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|MW5PR12MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: 446fb22e-bad9-4852-8e8e-08dd5566fd4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9NlDIY2XPelmmz7Cyk6diHtHSEaEXOPA7zlJpH0t0U7BATYUmWoAh9kVFKAj?=
 =?us-ascii?Q?JKtPy0051BaXbVEuHwHvm3wSVSZ0QSdrAmCKJ1lQ4BlXHkIU33r6UeFhv3vM?=
 =?us-ascii?Q?AVQdRtTLQuDO3evfb8Hf9SonK6OZAKcgxeXDM14vxZeWpBKs/vRPurvn6w18?=
 =?us-ascii?Q?pCR7JPdH7QXXYabreW/GYs4KcxS0zuyvYn/0U4xaI28roI1pSZWdJ1zFyOHy?=
 =?us-ascii?Q?D4jbWweOCxKjPwjyPgxX3Hw0GahLtinAV+YLB5snznzhse0VHpl/qGYN5eM+?=
 =?us-ascii?Q?0mCyzXGmGjNmWYAdakojV1vdUf0IUjp/eUyP9Eelcz5QLSpRnPsZz0vfCg5t?=
 =?us-ascii?Q?V0xoGtwKo7xJZga3K5FUFm9Qqu+5DV7U+wMVcgm4txP1vHrlwvfnxE5LlvOT?=
 =?us-ascii?Q?SPzq6UZ8rgIsVqSZFpGgDebBznUptDPvrJCMmsMkx2a3DrRgrGahVXVTmki2?=
 =?us-ascii?Q?MusnDZTY4xmu86WMJ+R/OwECNXP/42feu3WcdUrU7jFqkD2YvYfvo4EWUaIh?=
 =?us-ascii?Q?APMBOvJOrpGNKuMVYczA35A9j3L7Aq7JtA2Wa4jHAwwSE7giJMKsevq6VQLB?=
 =?us-ascii?Q?6AmREXXofqOSnIeKDYhaRIglUTJLDU/P3kC5w3fmnH10majuLbY5c1IdAUZN?=
 =?us-ascii?Q?gF271Cu7iysSB4W6XoKdT60M2mK7D2Y893r4Hd3C0BNVvIYpzVHUP3a3cxFw?=
 =?us-ascii?Q?sDWV/3GWGKyKBcODib54y1VADd4yc3HjMC0NddiTRaV7/sh5ZVcPA6bG8KW/?=
 =?us-ascii?Q?L84b3EUDUWy+JRqQRKfHxiuVfzMRivbVjN2f6aChkq5mvR+lfdI3Op9Wl2Ec?=
 =?us-ascii?Q?nCVKmgMiHZAoM52vb5HleiWDRDhAfSKXz24abcMHHjAflIj2Y3lhLwrhq+Vv?=
 =?us-ascii?Q?M5jv3kvYCzImPQUMFxvf5raNdfqqQzX8kCtnU7C21Ke84Yxzsy9mFLtGKNEo?=
 =?us-ascii?Q?WzwqcOmE4uNXLxeoY/T+DQ5D6CEtilNLcmLNCvne7iDJbOQV+UyTwhhmrNzd?=
 =?us-ascii?Q?ogi+wYIl/LHNHXQAhK/VALzRuMRjs9ujPv/VH3yLqCfay3fP4Z2CSPfCfckp?=
 =?us-ascii?Q?XkGelkVrcivMcKDaYp7hN4wawKql1l6WpzGHmZCv2fyWPXCuMQ/TSzNzN8nR?=
 =?us-ascii?Q?XmxEQh6fuXUHZs5B8ktVhD7DWVriev8J2ZYvwum1hJG9oN7z4H8cV1C9eyM0?=
 =?us-ascii?Q?PlR5mI/yJMgKwsorTlPXrlwbyFh6+bDJOxPIkauPihcvkis1Qyr1+WcvYyLF?=
 =?us-ascii?Q?1fUdM32dLNqIAsXu9/eRnaFe+nKZpE2nVaK9U6d2gScEYJ/A4UlZC6aqphnn?=
 =?us-ascii?Q?NRPzW3FTb255LdEPoII+ohKVzWX8ui056MVgB59a4Oc09any4LWOJlyIQNOw?=
 =?us-ascii?Q?mFs8dap44/VyQ7h/ST22ApD9zkVZXnrlXjXdl6EtsQYWdy1jUbO+7pTy9PzV?=
 =?us-ascii?Q?jjj7nBns/859V2gHL5cdbSk7edoUPxh1kyOF3r0IUf1WwF8NySdOoS82d7LK?=
 =?us-ascii?Q?td3GNfploYFAsI0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:38:17.9634 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 446fb22e-bad9-4852-8e8e-08dd5566fd4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5650
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

From: Mario Limonciello <mario.limonciello@amd.com>

amdgpu_dm_irq_resume_early() and amdgpu_dm_irq_resume_late() don't
have any error flows. Change the return type from integer to void.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 7 ++-----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h | 4 ++--
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index adbbc43adde8..2b63cbab0e87 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -513,7 +513,7 @@ void amdgpu_dm_irq_suspend(struct amdgpu_device *adev)
 	DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
 }
 
-int amdgpu_dm_irq_resume_early(struct amdgpu_device *adev)
+void amdgpu_dm_irq_resume_early(struct amdgpu_device *adev)
 {
 	int src;
 	struct list_head *hnd_list_h, *hnd_list_l;
@@ -532,11 +532,9 @@ int amdgpu_dm_irq_resume_early(struct amdgpu_device *adev)
 	}
 
 	DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
-
-	return 0;
 }
 
-int amdgpu_dm_irq_resume_late(struct amdgpu_device *adev)
+void amdgpu_dm_irq_resume_late(struct amdgpu_device *adev)
 {
 	int src;
 	struct list_head *hnd_list_h, *hnd_list_l;
@@ -558,7 +556,6 @@ int amdgpu_dm_irq_resume_late(struct amdgpu_device *adev)
 	}
 
 	DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
-	return 0;
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
index c37bcd631e10..ba17c23b2706 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
@@ -97,7 +97,7 @@ void amdgpu_dm_irq_suspend(struct amdgpu_device *adev);
  * amdgpu_dm_irq_resume - enable ASIC interrupt during resume.
  *
  */
-int amdgpu_dm_irq_resume_early(struct amdgpu_device *adev);
-int amdgpu_dm_irq_resume_late(struct amdgpu_device *adev);
+void amdgpu_dm_irq_resume_early(struct amdgpu_device *adev);
+void amdgpu_dm_irq_resume_late(struct amdgpu_device *adev);
 
 #endif /* __AMDGPU_DM_IRQ_H__ */
-- 
2.37.3

