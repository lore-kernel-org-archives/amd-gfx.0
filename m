Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513F5C3DA60
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 19:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F11B410E3CB;
	Wed, 17 Jul 2024 19:41:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u/9ot9Nz";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A06F10E3CC
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 19:41:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiK2uOJerXrCWvfpSLhVPJMJreVjs+y+c/pp/cl7VUk8pJ6axbfN0c6tATb3uafxfIeQ6kF0d8svRCr2Se73qm2CBiioek4cC3mEyVuPJIj6yZRwWCKMbFEieUWpIk+GnSuQOX2DfrWBDsjQteQ596zPCOZ9L/oHjxeRH9FeFHwggS3scFD3HjbfNTL+s1Hce8K3Rr3IpG/v+MroacdSaCiAmP4T1W434GLSUmxC42tLEBiA4gh+ZKskezRum4iTH243SKqcHzZB0d+oYdBeExEq4mWfsmKJrRYiHb3iAyvxn80ksTMgFEBJjPqLEtYyO3EybssFODZtiFFfRfo9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuIZ1vxr8b0hRXOHwgSIMPIu8rRVdzG2FYlaltnE5MU=;
 b=j+x8ji1YQnPaVQENX76cKvyTWVdN4YviMqc2IohfoqTXTz8bgbrib7L6AOBWd1qIqbIeZ7ShROL0QoEE4SuO5It3Cx2tgipjJORdtyhosYn/XKDSp3FcFXvvSynjhJKI02wa030TzA/Pcba6kBwlY37uimXB0nWCDLZERndBXLSz2D2Wx709BI+2HjDuGS/69trn8RrpM1ml9S2Fy5Kek56iElxgzjMpm3Ygiw7NcAqpleqBGdvAqTdDLHL7DsOOhG1RtYViaRH1qrrEg+Ee9Y6WGi4fQc860mwDTEzXo1E2631f+paR4vfFQ2ze4J6inOZm/dVjR13LcXo+/Wefuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuIZ1vxr8b0hRXOHwgSIMPIu8rRVdzG2FYlaltnE5MU=;
 b=u/9ot9NzvGEVp0lTqF8UbWdf0g3BzGdxhA6tTJAn8iCtIImPsnti4TBKtEkzi7/eNZSII3RS9zq2H2Tlm2QaQnaadjd+frYPtnLJsDafiR6QkAsoS/Rm5wtfkjyhuw7N/FzBQ035dTZ06gYaO9djsTBHfm7Ep6Wzsop2v8H9QLs=
Received: from CH0PR03CA0359.namprd03.prod.outlook.com (2603:10b6:610:11a::19)
 by PH7PR12MB7869.namprd12.prod.outlook.com (2603:10b6:510:27e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 19:41:41 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::36) by CH0PR03CA0359.outlook.office365.com
 (2603:10b6:610:11a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Wed, 17 Jul 2024 19:41:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 19:41:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:41:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:41:39 -0500
Received: from debian.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 17 Jul 2024 14:41:34 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Aric Cyr <aric.cyr@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH 22/22] drm/amd/display: 3.2.293
Date: Wed, 17 Jul 2024 19:39:01 +0000
Message-ID: <20240717193901.8821-23-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717193901.8821-1-aurabindo.pillai@amd.com>
References: <20240717193901.8821-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|PH7PR12MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: 534628c0-8c38-4349-8b73-08dca6987b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P6Dmi5vtw5fpZNyZYO6EiVBuOmsFZREoh6c51H69ErC15y3ysglp5SZ28tU8?=
 =?us-ascii?Q?pwGpT6jhnHTN/8hzKU02ePpvSj6wPjPniVCHQlj7u3+lDlDpe84Ik9lcdn5k?=
 =?us-ascii?Q?qrFMYNUqN5JuGarZ9hW5O3mjZ2+wSxt32g4ibpR688SNjeaDjH7Dp3yaf6Gz?=
 =?us-ascii?Q?E8Prt+t/0KIb9d0twBq4Jn5imt8oT1TAedDAfYCCKUB/k0Aa2kGLmBXMXTgB?=
 =?us-ascii?Q?HFIZeDDDLQ6oXD7oO+2Vcj993EgR6BI7LImOYrYuinSq7djx8vDcuKzE8arz?=
 =?us-ascii?Q?uGhz+fvj+e9Msf5zRaYUJWMFF8+J9kvI+wFgiGkaMMfK/cUxal5HiMy3FC/v?=
 =?us-ascii?Q?sFdxtO0sd7WnSGwpiNxlKonR3Dtxk3rgXFIQZp+6ui8LlZoEI6NpmytNbQTP?=
 =?us-ascii?Q?JwTrAN823CaMnDVa13LKzhHizbjxUV6OlrHk/SUcQ6cdY08AWC5Dafhmwd9w?=
 =?us-ascii?Q?kCyLir4JWa/eCfBdT126uVxl/xQSAIhn+xSUHDxK1Qr9oP1qzNrc2idPolrD?=
 =?us-ascii?Q?DjVop9y1YSIVLp0PVjPh/UPZSf+IaA461gvB9vFxABljsUI4CFyRJuvDqRsH?=
 =?us-ascii?Q?aDYVFVCFjNGGEb0AWkqawWwfYDD6bKPZOZ2TbZcUNNy1HeOGJI9ocBlbQZOc?=
 =?us-ascii?Q?lhsDDiNiJF5v3q7yGMs+j91B71dhJ7rBU4FtBVQjKUH8nh8FwpyVLTXxqns6?=
 =?us-ascii?Q?c3Wbty6Imr9Q87EwIzAB/q7cHe8kVvh1DxjffaSaf5MDVenNKFsNJWdzKSJD?=
 =?us-ascii?Q?MXx/f3nQUntOt1c9bCB6tNDNA9gw3wr0aubkJ6n/o4CNb+c2quteFiyfPDFi?=
 =?us-ascii?Q?1q9Gjr4elP5jzcWJGKS8gvs/BgIGOiOxpmUQEOHsh+3Yg8vTx/INn0S45X1A?=
 =?us-ascii?Q?vlHVhHTmI9uGa7lEy1ITT8kPmzNJxxCxHi1Z1BNQXA6OBipuPVCCO9uKM3xU?=
 =?us-ascii?Q?Lb8J1IEXoLISajClFFbv+L8+lwzcPmI2O0iwdNAwpdnLH76OuMimlhDc6+E8?=
 =?us-ascii?Q?xcF20tdAKyyl9TPPHUm9QGU7tLYGZZ+LrIfGylD8aUYGaPmVlBjVXtrZeF3L?=
 =?us-ascii?Q?wTSO6d+MGkeNDWgVLI+oB1ea2oVquERgoP+qk2MrX08dzhbP79r3nouvLb3V?=
 =?us-ascii?Q?JOldRE+8a3+Le/VKMS5+vlWdDFvbVD+S4UF7aBNav44gKMn7Df+QVTrhxWXX?=
 =?us-ascii?Q?N7iBUv85keq5MRAoyXK5f3JIJ8h1VXC0wdaOchO6HFeGyFIwxjaMZ7XB71HG?=
 =?us-ascii?Q?VA1dnAFo2BvMXITVBzxzFUpcnHiFfeKRmAkdIr+4WyVMUpehiXXXSxGLqdWn?=
 =?us-ascii?Q?D/Z4JVrT4dkCdkcCDGO06IihX0IIkKC/5vDdSBPWRBkOuQPFiuAEavODu5my?=
 =?us-ascii?Q?pO6dXH9ZyfDTkRG9ToVPk2kskZU2ziRolFmy9GYN8K6emPMXTTl9tVrjWrPZ?=
 =?us-ascii?Q?qoQKx+obfz2Of6cZZFGbZTclMAKgDEJS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:41:41.0561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 534628c0-8c38-4349-8b73-08dca6987b2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7869
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

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 272ae1bdc57f..4077c1ddb9c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.292"
+#define DC_VER "3.2.293"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.39.2

