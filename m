Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876B1C3DA6D
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 01:15:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B97410E597;
	Wed, 21 May 2025 01:15:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FgsSQ1Cp";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CCB510E597
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 01:15:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVax1evqPulK89ixsF/9H2C4GboKDHzzeDItNOTYqpHIQ0Xm/KnTpvS1Dxd0ySD+llUvtDint4PjKdlz78JqYPGQffj1herfW2NvXxaHeDJTHgpbiEPqdKHDbNWjk8bH9Kv0VnLO5J0ZJPn/fnTTtMgKWDf8P5I/32xpKSZnAcF/6q3Qk5aNiYwAAF1xN4id+9KSclOk/Y1MziWVbHPzdduwzlg40TDmjcKa+FiYvRTaHc8dxwTiH9wFMJuP2wKeV+XxFJ3f7smOB7tLzJozC93vMTDJpDWUqrQLqeWEjKLSnr27M6kJZd4kfM9XI93VjfDi25YQMZYH0lOkSgr/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tgg6/oAeyrELEfXIAu3HA2ZLoDbGgntIiKRLXkrFVIs=;
 b=Nd52i9A49yiS30RSfjsGWC0/hQF/sgZuTQI+5UYg2jrA7v12ENaeYCW1r9wYmMDYcP54erBtjNCHg/Z5YeIk187w1vsw8CHJark/UHJ0pPhFGUCtn+H2N8iAvPHbXdLV+H8t4zfJnhC0/TUmOAQ+eo/XzywL+J5LjxuQMG8vBeq64b164EaebztDyY5DQwS1Q0Iu7RKN4atDwc4VkQkZMQIr1/+X+TeqCrSrTrPMRkdah0YcW9biQPH28yxcFsJxMBWa34/YaOLObqxDbj5ZNW3QVtu3PFA9uShtlZtRiwMZzmohBB2+Q5Uh715I+Rzw0RVgjGzO8VXneWu/Pb/rbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tgg6/oAeyrELEfXIAu3HA2ZLoDbGgntIiKRLXkrFVIs=;
 b=FgsSQ1Cp8N/xNFupxTmd9HEL3rxpeHWnvGVBnpiOfdQVhaeEC6yp4E3p1Sf0dodHCP1Y/114CuazFg4QbbqfA6v5Psu6Rk62vLzihrRKLhlvNV+Uw7f4plMfAuzeEHzGaZWy//nTj3/CSoyvyZdmhnxhhB4WIVflGAA6+5YU/bg=
Received: from DM5PR07CA0080.namprd07.prod.outlook.com (2603:10b6:4:ad::45) by
 LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Wed, 21 May
 2025 01:15:36 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:4:ad:cafe::79) by DM5PR07CA0080.outlook.office365.com
 (2603:10b6:4:ad::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.27 via Frontend Transport; Wed,
 21 May 2025 01:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 01:15:35 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 20 May
 2025 20:15:34 -0500
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 20 May 2025 20:15:34 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH] drm/ttm: Should to return the evict error
Date: Wed, 21 May 2025 09:15:32 +0800
Message-ID: <20250521011532.17129-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a2ee99-89ab-495d-1bf3-08dd9804fd8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NEslTp325qF5Fk1iIAGC4EP982GS1duSHgT7JNVz3fEziC1wug6XCjuJdBKz?=
 =?us-ascii?Q?yhyjawxV1abOf+VOl6/UsZiXFMaEo53gEGEs5X0xT9n59O7QMcoNsOQY9CA/?=
 =?us-ascii?Q?myY8gf2q56o1rXVSAWX4WriAoqh4m52CF544HS0zcqsxQtAEOFv+cxWvwrLE?=
 =?us-ascii?Q?MpS6eSPXExGJfg4X11CAjIDKQly6UIePbqjrOJv1oWcOm65DsumQDJcBDKT5?=
 =?us-ascii?Q?zSXAnc78s+1CPBUZDFVTQnaOthdS2+F19gsLjwwAbqQYJwHJSJoVz9lvL1xe?=
 =?us-ascii?Q?eZS0yv2jyTLNxPXtcB3J4hB8e30CTLDT26reX7uCdVWgkHbx/t0aRrPv+2L3?=
 =?us-ascii?Q?erpwU7gnXDIwLzNEy9HUwrfqExovcPEzSPHZQ5LIkLrRRt1NSKfi8mccQGYP?=
 =?us-ascii?Q?1lZc8gmamjMOGk+9u6NSkCAqEyTnFjNeEuDqOGJz2Y6TNFaoYdJAyVCcEPR8?=
 =?us-ascii?Q?c/81yAc/2qWJbuaydgAJnhkiyEg/Ov0zCAZMGrMDOr/K0ooWjXMMK6XuFIMh?=
 =?us-ascii?Q?4pP3Pd3EoZYuwpNm+o3G0CBg86SL0NarCeXgBUZ+yrTtgTbBLHAlL1Mq8SL7?=
 =?us-ascii?Q?TANB312qKPZYtetKXf/8foc8ceHkCxE3aWvRy8qDlRCPDGFVXQ1vMfhhZL1a?=
 =?us-ascii?Q?N+LbuyUGQZJZZto/Cfx/FJSymkoehJcjyCf+SoIOBfExQiQElFnyAUXzmDIs?=
 =?us-ascii?Q?n550MLPTUm/6iW3oqQDLHWh5VMfUITAgJnu68xc4ty2zximyM964VGvdzOH1?=
 =?us-ascii?Q?m8jakM+vdThaEs+Q0wUWPE1zuIEQqIV1Fr+xUfw5xVXKdIV2Cu8UEI60NFKp?=
 =?us-ascii?Q?pHg8BIJ0tvW4lF895wUZv+s3WAh00xv+o9CE6GYgaF148N28uSEpv7PCbMVG?=
 =?us-ascii?Q?d5dpVEgxZvAZsoEyjfOplFXdE5vOxtlOcZPvKRPeC+BXf5C1Qm37gaZTxBzW?=
 =?us-ascii?Q?EnnomtKvgkfTV53vYF9oCwmwIqszcbdHgnRjbkVpsXYg/ty8F8WWlIIa1WPY?=
 =?us-ascii?Q?3kzgFG9srvHreECSib0ZJ2veFEye++3um1aP+ySO3imVopQgmlWYjZGQVIke?=
 =?us-ascii?Q?HxAEAHsKhrCh0WeFtIop7fmEP5S5YugM1S6Yf40aNdT4tzQz9KIebRwQwV+7?=
 =?us-ascii?Q?1Q793+lZc4pgvJEmM0elN59IlK9MaDWL6I+yd6HRMbWiZmmhq0wrJXptoPNe?=
 =?us-ascii?Q?8er8Gzc3rM/570HWj2ldADQCO1W5prI1cygL1lno9//f5WEohv0nme3pbc0A?=
 =?us-ascii?Q?RnKbFhvsxeRbgoROVuZUH5IqSLW4wUhHhf/qUXvxegbNL6Mg/HUxAk38TQV7?=
 =?us-ascii?Q?KDCShsBdr8f5Av5FaXGDsbqYBBjLueu0AjArM+g7ORxladY4HKZUYb35NFoZ?=
 =?us-ascii?Q?umJiTmiKU0dap+2O4/SrJWucU7+Qd4/GHrTl6LenNTDnwPX3vjAP8fsWIDTz?=
 =?us-ascii?Q?dPNdqGNYfy5BeYL5TSB6Y0QS3lSaWkB0BsVfEjFrlT9PAo3lT3qLzKvyz7UV?=
 =?us-ascii?Q?/MaXPHRN1to8GluJ+ZWZAWFYv4Eb5PiFRKdQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 01:15:35.6701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a2ee99-89ab-495d-1bf3-08dd9804fd8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166
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

For the evict fail case, the evict error should be returned.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/ttm/ttm_resource.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index 097716bd248a..57e275baa09e 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -511,12 +511,12 @@ int ttm_resource_manager_evict_all(struct ttm_device *bdev,
 		.force_alloc = true
 	};
 	struct dma_fence *fence;
-	int ret;
+	int ret, evict_ret = 0;
 
 	do {
-		ret = ttm_bo_evict_first(bdev, man, &ctx);
+		evict_ret = ttm_bo_evict_first(bdev, man, &ctx);
 		cond_resched();
-	} while (!ret);
+	} while (!evict_ret);
 
 	spin_lock(&man->move_lock);
 	fence = dma_fence_get(man->move);
@@ -529,7 +529,7 @@ int ttm_resource_manager_evict_all(struct ttm_device *bdev,
 			return ret;
 	}
 
-	return 0;
+	return evict_ret;
 }
 EXPORT_SYMBOL(ttm_resource_manager_evict_all);
 
-- 
2.34.1

