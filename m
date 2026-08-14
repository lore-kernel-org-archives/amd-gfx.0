Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A76EC5DF70
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C96110F725;
	Fri, 14 Aug 2026 21:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GKPZifee";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010069.outbound.protection.outlook.com [52.101.46.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C849E10F701
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFeomhrP8g6lRH3kAO87/XKHoaE77LoPtiAOHRx3A11Ksl1lFnJ49lNTdRo8crVDVmkXPDKLuh3D9nyZoHHd9lyY+uUE67T9sORoHdHtCSSTVmSytiB8c1sDT1VeQUbQT9uVekut2/G4pbeVq8w0s7EZvtx7BD8xPNpva2yEUZzleIM64om4IkFXo38xXl7/CHrCSDyw9LEfXH4aoBQFHOFE0xA3rmcD0rRUGQf77sit5xnLYYZ/jPLBFDnAonhcjvMl8GYAg+CWJVfQCvjkCcNyqrTAlF3/EcYcniYHc2nxaViKInkMlQZMAVS1SFkCk+dcoyj3Wr3cb6U/fFW0Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBmC1FyXLp5Fl9EuVV4WK+dMQ738yrPhpSjZGN/N/90=;
 b=jZBpT8YLKtPhdaS9KTaerszbqpiGwVGPik7QTnBlYbZxFDY4s68zTbhi2aumpPzs2YpwXNtdpUsCIQNNZlqZGMRL9g2squKfvuJCTed+K6QzsTITnlHSt5erhWuYKtJvdDaWPeXrlmTUrHd8LwI3T+T+M3AfvugmA+6VL8BszdOubeAAOnf9/G8Ba/b/7Pwaqt3zFKBzaceSPzxA4QeQa9sxxiy+Lxi7vm/iDwjcjtkI8VxqKeLjlkAKocBzHUu8j8gQEknfoxAL+jD24ddHzElvS2butQ2ZS98M0I2drRHEtvR03J5zjaR8Hq6q+sDPPwZ6D1IPrqedod4uNlGkXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBmC1FyXLp5Fl9EuVV4WK+dMQ738yrPhpSjZGN/N/90=;
 b=GKPZifeeyas175wPvKueRm97a+/WsuTh7WLuPoeBjsd+gHvoVfwZjlu+OhhORWvdQ/wc2fE9rRP2m9vyIuPTUnNa8As4M7anlBsPFtHR4DdUZwEKNsrhNNt3XkTBUpaPpxlq37LqeyYmtX87AFcs8zr1AKJZg/+UhmeTACusI/A=
Received: from DS7PR03CA0310.namprd03.prod.outlook.com (2603:10b6:8:2b::9) by
 SJ2PR12MB9239.namprd12.prod.outlook.com (2603:10b6:a03:55e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.16; Fri, 14 Aug 2026 21:03:47 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:8:2b:cafe::2) by DS7PR03CA0310.outlook.office365.com
 (2603:10b6:8:2b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:47 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:42 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiang Liu <xiang.liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 074/109] drm/amd/ras: map boot log events to CPER type
Date: Fri, 14 Aug 2026 17:02:11 -0400
Message-ID: <20260814210246.3067612-75-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|SJ2PR12MB9239:EE_
X-MS-Office365-Filtering-Correlation-Id: 39017d0b-bd8f-4c09-b6d4-08defa478882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 8fkjRby3p7xc7GIp8yv3CI89feELJWgVldt4Xhs8iSAY7Mf2iMaK3CgXem1bi5RNN/4zocLgjuKnOszd4aQOPkY4rrdjpRgrSNIDSf2hdMSPagjOnk7TA+acc1NhMlzidL7yKnNQ8ChdQiMbcekbwV/KhNIsejetX1Nk0M6N80Fu5yLvC6SmJHpgXAkF2eboc5SMorQFLxXWYRMto+yaC+5a5L2+RH10t0lzynVZDoFCxstLdg0CoUUejIGL3bmkUC0UGSbO/ctThS8sMbJtPjX+70Twae/k8vBxTqA8eGht0Ao0rFAbwP6NMsTwB3KmaYXvGrganNyn6cvWt0p8M0lTWWWzrp9SaRt7G6WRnw2CEoCUtvqrk2KDdIYfpjyQGRLaLCqF3CLN9/rQ8czyykpCyn2FFs+wyIYrbpWBt7CSzu0TB5nnxhKD9Iv7rAMTfF243oIoiMzTJkfHxZ1AR8l254a+6oRltor5oZAYHPg5s2XOAU/LbChP0fZwB9k7Mdb2mMzumfEAhAlEMd4GKK2/140sWKI9V6vZ87BEbmSTrhS//1t8GvcdvcrjAd7cwIf5r/2MZiwTIWebFA3/s4XHnBE0ACb9LCazrugfWLUFjx837m8zBeLGR0QJQJw172w5hhYV4sWxeTl9GsYl0vKUmElaRm5X3hFIgqbGBkM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wIOJRb9lhHB/xKR4QceIbFUd5iIH1lW3o1usuNemRMp+5pBi2emjd3afZQkX5NaCXA7KvQ8QJw7xkZmPjq0O6JmUvD1NdNrbmjyOBT/U4YsgAqj0zP5I6XP+KEUOdYZjb3Y9Vh+1blDMrVZD07dv8R412BMCgZsxG7ZCb+kojciadbxI5IMNOF+ihvSSY9/ry/dr8oAjMhfu0u8ZSeaPva92ZL+jG5ncmILvTJWXfNs794trbgFwmuZ46ACFX6f7cTp010XaM3l0J465mgpme1K2aQYN/IaQXCUj4Z2B+h9ppUSBpNuEzlIp5a4FmfnK98aU6D1cOy/5CDCu5IBEEDRX/+AnWpKvGwfM6EafiWcDxXnqkHWgoomQk7aLES6UUYps81cuyyLWPk5aYJ09wm4gRLIxn+BQI8FjNuUX7GGC6K6i9mcFMgOM6xNq94WP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:47.2521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39017d0b-bd8f-4c09-b6d4-08defa478882
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9239
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

From: Xiang Liu <xiang.liu@amd.com>

Map boot RAS log events to the boot CPER type so records from
boot-time error sources use the intended CPER record classification.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_cper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_cper.c b/drivers/gpu/drm/amd/ras/core/ras_cper.c
index 82fd277c3552f..4047f9b0806e2 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_cper.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_cper.c
@@ -321,6 +321,8 @@ static enum ras_cper_type cper_ras_log_event_to_cper_type(enum ras_log_event eve
 		return RAS_CPER_TYPE_RUNTIME;
 	case RAS_LOG_EVENT_RMA:
 		return RAS_CPER_TYPE_RMA;
+	case RAS_LOG_EVENT_BOOT:
+		return RAS_CPER_TYPE_BOOT;
 	default:
 		/* should never reach here */
 		return RAS_CPER_TYPE_RUNTIME;
-- 
2.55.0

