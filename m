Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1454D3B7F3
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 17:18:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8976C10E4AC;
	Mon,  8 Dec 2025 17:18:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="likc6amk";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 579F110E4AF
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 17:18:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWWH4DJdA2phNs5fOxR71l+NKoDn/z+FeacebrGc6Qbb3XFkixJCHXrIwdQ/9kkurRiw22UcS8c80y164D0dz88gNYtLrLHqECKUJ4uVd261kculSHBMJVn3MX80vtkk/32ZyMevKNlsVDJySzj2KqxMhOmkujUnMi5w8TtPl6SPSwzZ7Ufdw9ue5DdgAkNLkPFSEnNxZEeCdhFr/iUA7/PV5AtU9RGmnSZWitdZpdFzbyFRcRCT+FpRdcMeyEJ1ppEVa4dbHrOaYiZcJZiSWatUJ3s0VjHIasvwx7Lm8vEFvyETNMcY6/gS+8yzSCKdN+2h5w14DiihkNbGh+FisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uAgXNWWOs86Cin+zXnmMUFJmCeOHv/a0C9/EMlB8w0=;
 b=D4IvZ4NJppkPignyn78WPTGez4qitfFLiHZplG4GgWzaAnDa7TGnomzPl2UgGBNXOj8kH2ywYhWaM6Enx+jCJ769tf/M60b+BuYmbaxBmw3Bl3LTbZ7kVtoMUimRgPKAKI+XnPa0tplDccFaitPNsv7l3lFJ15fNXVjXIaTUDiEpAQYNS5KMHpy9ylkG1Y/ADj27uit5+UgZGg7uGBGgvxZ7otU7shp3Y7nP8YYnPYuQDFiYRencorAYrp/rqY+SbIXqeX+oBc7X+e3Tb/UbAOMrS/CcAfjuprCi5wVDvSj575zA/4tOAKjLVDdAPURLCIq+Hg8g3wzIaI+V36boqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uAgXNWWOs86Cin+zXnmMUFJmCeOHv/a0C9/EMlB8w0=;
 b=likc6amkxyCU5eElBrLuyTmO53NbMXSzdv33BuMr8XU2XUeb7q2sIoQlPeYVGghuMKUhdsxdztnwDy0IIpa3++yRc5IplPSJmPcIh9pkpBeMXT3j6Bmmx5EEzUP+Ni4L1m6ftKQ7wwTq2Q/RfpluEhbjar2UgCoFtghHsJ8DzmU=
Received: from SJ0PR03CA0224.namprd03.prod.outlook.com (2603:10b6:a03:39f::19)
 by DS0PR12MB9040.namprd12.prod.outlook.com (2603:10b6:8:f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:18:02 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::f2) by SJ0PR03CA0224.outlook.office365.com
 (2603:10b6:a03:39f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 17:18:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 17:18:01 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 11:17:50 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>, Jonathan Kim <jonathan.kim@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/include : Update MES v12 API header
Date: Mon, 8 Dec 2025 12:17:18 -0500
Message-ID: <20251208171720.153355-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208171720.153355-1-alexander.deucher@amd.com>
References: <20251208171720.153355-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|DS0PR12MB9040:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a541bec-c142-4cdb-9b9f-08de367dbdc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ow5+ngT5NLqxO+HcflhkxrM0AZwAVhJ85WkFzMCS+PdOHNXPdVvfTpRCGeBi?=
 =?us-ascii?Q?20aqS6cfgPCAnblonr68VP1lE3snFGHwmJyXh7b4qkRSl8p9G6PxJZSTBqxJ?=
 =?us-ascii?Q?SIXAHns4gDvInurFWL8+pj1koiPvHiZfSNmcwqLiFS7IZvMdvvzRx/5dvQiv?=
 =?us-ascii?Q?chzFa36b/iDTkTl6h17yr4FR9zOViJp8NBgj/R0KjdW4EMF60+JjaTHb0T/X?=
 =?us-ascii?Q?tx2CaBQuST+gmRR5eoGsUfGJ1n2LyXnb9S2H4QSTDF9UeigrExXHSYFylZSv?=
 =?us-ascii?Q?7EVzD3PmHVgN0j61UldgxoVSvc007OPxgJ2G6w2sUWaS94WglhvT5r8f3JmZ?=
 =?us-ascii?Q?MTF91FD5nXtYRMFfRTbXBone8OK+AzjA5BbAvgPQu3gpTIK+FiPlZE1mMHh/?=
 =?us-ascii?Q?k37t91fYCKLxwfIRYNgsGCFRCxYWjYeyS2fcHedXr+K2QDtzUpj9qXsx/rqn?=
 =?us-ascii?Q?hcH6KZoEXTfthyobIXnkrCmqC6MyjYZj/KRF4OaNRDLWnG8fruorLA09JHWW?=
 =?us-ascii?Q?c1/IS3XFi0er05E0yABZ5E34oGm7w/TjHS0uOTqjK+nNuYyaSqe/gawXp0PT?=
 =?us-ascii?Q?xNUDxiiIPjsgKXLT6a/ggYGxFB48W1/UQoE5crQmbn7mu/+ZkMHPL4R5XMLc?=
 =?us-ascii?Q?nKj5qgCCa9RJuQWvXNa/VaSRjTDVEc5cNg4rDrPulFvo5q6kEaiSZaAA35PF?=
 =?us-ascii?Q?y+7fOGh4TTIjdH8vAqPgsinqT8FG2GwwZXHobibvx1om8TWn78jZ0inBKvLd?=
 =?us-ascii?Q?3VzuWO19HRQ3AEF0HbIidI1hsl49PA2QuelFgNqMvYr1nK1l7FtvIhQsveIh?=
 =?us-ascii?Q?Zh5BIIQEMVnjMJUtXCp9e83KMM1lzOod4VojH8X/MWB8g3sNTWBQIt3sDIRu?=
 =?us-ascii?Q?qJXXAXU1sZGdb4kJs1TECs8lTz5rKgsuB83TsJoWPcne2sDAWKU6Ylb5Hz+5?=
 =?us-ascii?Q?KW6+dFmkEiTxwI72vDXg1IzorMXIXeKV2TNIpFUidF6FmeI4F66tRxxU0PE9?=
 =?us-ascii?Q?KAl7WrqUeBvAzBg9xzbv2U4/q8fyyuv1k58ZeLpdqmdz4FmWfQkjkIo9qC2U?=
 =?us-ascii?Q?2Eig0AYfY+rmIXZSN9cDjE28tkoDsguZkVvh1NM5jZiaOrRIkzDeVY7MoRwZ?=
 =?us-ascii?Q?70wIEbO/uEylDFbZSwFfGZ9v9FQ1qFGs06M1I2o8AL7RI89rFoI9VU3a46Mf?=
 =?us-ascii?Q?rLbeE3OZ3r7mf/ZBvv8aEfJjbz6+cAeJOKQsQaA9YePW2AQVNCs3M661PEWc?=
 =?us-ascii?Q?wJjIbqKw+0eQFabBZ3ohwuSTN3O8qMdW/RI54VrAV9U/PvE+ol8See6M3csC?=
 =?us-ascii?Q?lZSzUhBikvWVFqtnlnFvlACzMDBo82B8fmwwGhpiAXOgZzkGY+A9gET4uu1g?=
 =?us-ascii?Q?Nya49qUfYDt06jS35/1DQSd0/ToCUayA7EwHaVYC5VQRd+Mrn+TCTPU0+gRm?=
 =?us-ascii?Q?Iimpxhk88x12flidNDoVAA6eDOdXeqMSV6JiJbCkR/0H97QYocsw+Df89u5f?=
 =?us-ascii?Q?EF15YeHgwM8bWqZep2Xk9PH5BwE82WLizFNP/1YTYq8XNsex+QvQb63/Bxuf?=
 =?us-ascii?Q?rZCu55+dyrAxDbZS4l0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:18:01.4574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a541bec-c142-4cdb-9b9f-08de367dbdc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9040
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

From: Shaoyun Liu <shaoyun.liu@amd.com>

Add LDS out of range reporting support in mes API

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/mes_v12_api_def.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index a9bbe3070a488..fdaf2e871e575 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -775,7 +775,8 @@ struct SET_SHADER_DEBUGGER {
 		struct {
 			uint32_t single_memop : 1; // SQ_DEBUG.single_memop
 			uint32_t single_alu_op : 1; // SQ_DEBUG.single_alu_op
-			uint32_t reserved : 30;
+			uint32_t lds_oor_reporting : 1; /* SQ_DEBUG.ADDR_OUT_OF_RANGE_REPORTING */
+			uint32_t reserved : 29;
 		};
 		uint32_t u32all;
 	} flags;
-- 
2.51.1

