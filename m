Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266BDE9A047
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 16:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B068910E5FE;
	Wed, 18 Feb 2026 16:51:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pYT+Vux2";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010045.outbound.protection.outlook.com [52.101.46.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 348B110E5FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 16:51:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkHXhuzxisS6OBf0d55pHBSzi5cVEmOwroSx4UHDf6QerlYOF4UroilxbEX0takO1rGPCZitQzuMk9Xgc3kz5x8hMl4AUgwrbugi2aWi0anxNfOCg4SA6gdjiisOmB19DlUanti6589qkZqhD5UXs8makjn76doIB9YcZgPcU15a1ezW3Fhd6T6jjR4IW0keRK8X/23CQzwJ6uTUz4pwHDZkTFBjX5wrZVLwdum2MoPFsPjpfF1eFfZjBATn/k7ps8MwQ9iwwBCsaHjQHLoecmjL0sbGwgaE3dxp31/MpmAaWvNMA41iPE0P1y3OiBfPnXtcWdTo5gIB00aNfeW2lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSO0kWuHV3lb55hX7A+PV21w27+lx2K3R6Ke+r16iuQ=;
 b=yiC38LoD2iWQmvbl29i6wFBSIcc4p//P48GOXkWmiVm3Qb5Kzl4HVug+AUU9eKbiqd0n4jMkvXwICv/cD/+aVkh6j8+d4adqjtIOzER+rW7HAoAnBjeSIBfQpARavFsW5NN84P8QdAAs2TIpULIzWqnWc49LPMt3p4HaIMtmeDrHICxaY8XGyqfTz+/E7XcfniaG8nWD/t/gtppnzYlTUDz3EZ4RS/MyDP2p3VZhm4vbtC9d0iAL5a/yPQiFCeywkvJP//E/PSUUTWJJZmkYDz0677lEsj7X8UcHQIqniZjr+W11q2cpp5NWECovog45rllmukbt10gFK4EWv8nnqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSO0kWuHV3lb55hX7A+PV21w27+lx2K3R6Ke+r16iuQ=;
 b=pYT+Vux2eLNUvg811HXIbAeikhk4SpbjVcgAZm9jKm5QBMDg72ohArM5EnZpEkyq+jTZND2/cXxOp28lUz+P1rWseXWmX4tqHovE4KdJMgKkLnZanOmw3tlqjsPeRuZYnSGnQ+SXp7LD0lyPWfk0CZ6320I37IOXLaOPCq9tNoQ=
Received: from BN9PR03CA0186.namprd03.prod.outlook.com (2603:10b6:408:f9::11)
 by SA1PR12MB9546.namprd12.prod.outlook.com (2603:10b6:806:459::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 16:51:32 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::71) by BN9PR03CA0186.outlook.office365.com
 (2603:10b6:408:f9::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.15 via Frontend Transport; Wed,
 18 Feb 2026 16:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 16:51:31 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 10:51:25 -0600
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 10:51:24 -0600
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 6/9] drm/amd/display: Add missing clock types & fix formatting
Date: Wed, 18 Feb 2026 11:48:07 -0500
Message-ID: <20260218165116.155001-7-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218165116.155001-1-IVAN.LIPSKI@amd.com>
References: <20260218165116.155001-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SA1PR12MB9546:EE_
X-MS-Office365-Filtering-Correlation-Id: f513f101-cff2-4f5b-9f52-08de6f0df7be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wlE8Xz8lizJsXKVU+ZxzlcP9QnVXWeRWfK5qKZhxNHQM2p5VHAsykRDKB2/u?=
 =?us-ascii?Q?hvlJxcn1xffH0Mvaw8GD20c2TtsLYbyV2l7QTERKhyk2tpGSpIM6Df0JAbsX?=
 =?us-ascii?Q?WHFdDiDEzj0lIBM2m/8gQh1Pv7OH0BagFoHrQrNpqLO3Pt7qR66vIF0PBeD8?=
 =?us-ascii?Q?Vyj0/CvttqyzZUtt19n4YSNnL3j4HXxT2My8jvvICxbfFaJTn4uBjLSZv+iI?=
 =?us-ascii?Q?CcYPjZ5AdXo+jQsqb+HFtjJiNKogTdMrkGh0kfeOV+98W11Q7E6SfVuxZZZB?=
 =?us-ascii?Q?S7r9er2QEtayJlvH8FXrPWFJqzhZ9VxAjyBrvUdalhLYAYz17AQCdW4/kDsP?=
 =?us-ascii?Q?EpAii+4pXiDXMbnEpocfbQLKE3QClGMZ4aQPOI06nw8MumzFM4DCXD9APUxU?=
 =?us-ascii?Q?VmI7ggsnGnZEqbzUJ8h7nbfwRpEHABVccKhlvURybIDB33uKU/R+1S6LwPxp?=
 =?us-ascii?Q?g9LJrs9c4hfP7/dkNPM/ACUEaiHgm04Tb7oUA60BxU4S0GsLBc9AqWOxzJ/Q?=
 =?us-ascii?Q?+hvyy5uGyS8P6BP50kIXzUpv9QZWA728WR6NoBPFgASeUv99yi3J4FuFZahb?=
 =?us-ascii?Q?Gjchft9C717s0Nu4ueqeQ0IeeyYHp3ZFwE4Kzw+5nA3UUKPDiRF7B/Cbi9Wi?=
 =?us-ascii?Q?XY2ggE6FIfKk5B/Hqzw4KxTLM/ufODRwrzBYYtoxg2M5ozKyqmtdVDft5mFK?=
 =?us-ascii?Q?TyqDOUVZTWXnNmAKanlKUc0KRMjPFvmfkq1ICZxcYCKYPXGHXDPveEkLoalk?=
 =?us-ascii?Q?OFaB/qU7jv9rzvxOS+JkZI+FPghvbmhBVmOWRys6OUs9DTgGN8yxO0pS3Aek?=
 =?us-ascii?Q?mmFN2kixhb6ClcEBKceYXKQeVHS5RlvZFo3xua5IIA2DgzN1UbdESPhk4Va9?=
 =?us-ascii?Q?TvRtoCtXQM3TXLBejYuu6JJmUI+4Pgm+mMl5ZF/BmBdOzbOBl95ZoSv+CEkR?=
 =?us-ascii?Q?zhE00NtLEAKavX5NI5kVveF1ApaUCC/vLFRh9mdlTfKkS6CmkuN6lgoOCEWO?=
 =?us-ascii?Q?PsOWGz23dUTBq1mdN4eVWdBOxLbDTFJ2jdEf3R6lw+Tt4HCuJtZoZBzXZ2bi?=
 =?us-ascii?Q?Retem/K++oo396Fha+0ZxCVvoJL1873nVD+jdko5sW/biXIFZnA6a+nL2bAc?=
 =?us-ascii?Q?qr6ps1CBxnXsdizeWHcRjg5r4+1fIa9IT9li0RFpIUXe7JqQ3M2TCt2YgAjo?=
 =?us-ascii?Q?4NeMYlTNHpawfiwRtAgrywM022JIKbXc2ViksFckHCQCg23AYBMrUBYrafMZ?=
 =?us-ascii?Q?H0WDsZ3mqRG3rmkB8+TGQDM1kBvTyvA8ldWbhvrHt+wcAsE5y7fCYeupVTX9?=
 =?us-ascii?Q?U0Rv3sXtcgqK/EhzUxjGbTV37Ot+SF7JtA8ee4+ZGK4ajS5upzgHO2a+8JW6?=
 =?us-ascii?Q?SWq4bJitrmge58wBDpajYdrhLJqQ2EFGIRel4ykHnM506qTIWS2iLyq8GrJr?=
 =?us-ascii?Q?uDMlXzJkq4bqSF1KFkMlAL2oXfS6w+R6G5m46oY/98qhrthKmY4mdueFvwMq?=
 =?us-ascii?Q?2k0bR5+gwfDdwEabfsj0gEDwJtJtMl8t9MGnO58M/fGbIz9hTvcZuiGCQsMg?=
 =?us-ascii?Q?VSXFwNcRrRN2SF2QYf5SauY37ENQJ2IUtJ7sIQueNpvolsGJ0I5BF0dPsiq3?=
 =?us-ascii?Q?M5KyvKlOETemR2RFvZU10ghqu+vJZT4FZSwZj2JRDEt2Sj0ib65awEv/Keui?=
 =?us-ascii?Q?ELW5mw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ytHGFnC5m/PkvlukPfF57P+uCyTP9YhUGJr7mj+xR8cQOswtFIwydwkApPOibgiR90vja2PNbavhBV1+Da0DMgQ3uaYjBkPe3AbdWLn7I9f+9eYirec6xH3m7h8BV8CakFhuItCQmfBRZjlu46VxAXg6ZIqlAlbmeuNI7Ddqb4EWljO+VZcWJLvpyZGdeZSB4upAHlDqs1mLrwEEIRx6o7bcv1wVX6GM1FRxGkdBY8kYIYweZIVwwDWRTyQbLjS1PBIXYp+VQs5l1ROkIUTnOUeVbUsHYkVwjuEwVtVhJSfDZYwzBys8/0VZYCkH2O+PdOn3JtZ5s/r0GyEnsCuAG2PxOeNEx/Qss5+WVVWEoQCsA4qBOpIAik+wAbsb/9VlNGT33M0+j60obPh74xwkSZPHGNuRNIJxpWceXgZAvnvZ84R2uVy3loOHY6mVhkMe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 16:51:31.4484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f513f101-cff2-4f5b-9f52-08de6f0df7be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9546
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

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[why & how]
Add the missing dprefclk and dtbclk clock types to the enum.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h   | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index 8d694a3a7e07..9e53eacee3f8 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -290,10 +290,10 @@ struct clk_mgr_registers {
 	uint32_t CLK2_CLK2_DFS_CNTL;
 
 	uint32_t CLK1_CLK0_CURRENT_CNT;
-    uint32_t CLK1_CLK1_CURRENT_CNT;
-    uint32_t CLK1_CLK2_CURRENT_CNT;
-    uint32_t CLK1_CLK3_CURRENT_CNT;
-    uint32_t CLK1_CLK4_CURRENT_CNT;
+	uint32_t CLK1_CLK1_CURRENT_CNT;
+	uint32_t CLK1_CLK2_CURRENT_CNT;
+	uint32_t CLK1_CLK3_CURRENT_CNT;
+	uint32_t CLK1_CLK4_CURRENT_CNT;
 	uint32_t CLK1_CLK5_CURRENT_CNT;
 
 	uint32_t CLK0_CLK0_DFS_CNTL;
@@ -362,6 +362,8 @@ enum clock_type {
 	clock_type_dscclk,
 	clock_type_uclk,
 	clock_type_dramclk,
+	clock_type_dprefclk,
+	clock_type_dtbclk,
 };
 
 
-- 
2.43.0

