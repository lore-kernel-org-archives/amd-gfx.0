Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48007C282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 21:51:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0C7110E697;
	Tue, 11 Mar 2025 21:51:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ax5FMDFD";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7875810E697
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 21:51:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVBAENfYMkPHV2/pQ03VRT61ACVwA0vAjJTsVXGkDzWsnt0kxSOOtq8Ds4KQ8fQfZGt40JkQuU7sz05B7gKxaeS4ipglLRiTwPrRJK0A5swz5W0EG/cfzUHhNB1WknkqFcXDt1YNbT1/Zb9H2SRQRtAvuokHpplNHfuJ4diTM61FqSaKTLttsRhh5l0pmJjIUTU9pxS8vFudqKps2E4obNovw3QevbrOoF6Ln/RC2C2cLCotw+xw3Y4PElOK/HOMGN+mQms9z06upxxzJQplmrTNmHu9yC0cMiqTyVZnMLbN+UtlKrrhEHjfey57pEz27TFjVkHNIH4qfLgY4+BRjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtRkN6/9LiZp0krYbqRedkKfcqWCRIMs6QAgCSAzWoc=;
 b=vJ153chCQTpzTwOdUO1EfS1fR/eRM/rwIPL+m1NcuoBoYixCC5U6PSaGO1rZU5YvY5EeSL3Nzo/MrFoa4GEf42ftDd42sVRpq0zAmPtvWw3l4SMhpeU9tgBeA/16btBkytCLlfCO+q3RaRmWjPQODaioqqOY1Em/3Ea9uqFTI1SoOKF36ke3NvF5OTgoOqMO18wu45HlkDKmlNcUt4b2lVr6vN4GJG27cWkPLhUhDiDFRq2faffmLQzqc//DylFWsECpyqqPOi8LJFESf/xzqWb0UbP/Uafk16btcxBwIdkIflb27H1Wf8ebsPKYFWjWwmWN1tCvxEm12WSSABpLMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtRkN6/9LiZp0krYbqRedkKfcqWCRIMs6QAgCSAzWoc=;
 b=ax5FMDFDZIa0e7plYjhjeDq55er0pjwsv58EsVrjcNC0Zkbkox92KRihlfo5zl1aWXpIt9d+0nqSZrgPa1A9UGW2f0vNLtNIAZByLa1icd7yPgoCBsUC1id9PRsJ7rUxP12MGngUO55F42e1PChW4xc1DGVZouc4IH8nGmN3vxs=
Received: from MN2PR07CA0021.namprd07.prod.outlook.com (2603:10b6:208:1a0::31)
 by PH7PR12MB7356.namprd12.prod.outlook.com (2603:10b6:510:20f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 21:50:56 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:208:1a0:cafe::6d) by MN2PR07CA0021.outlook.office365.com
 (2603:10b6:208:1a0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Tue,
 11 Mar 2025 21:50:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 21:50:55 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 16:50:53 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 09/11] drm/amd/display: Update static soc table
Date: Tue, 11 Mar 2025 15:42:10 -0600
Message-ID: <20250311214618.3106637-10-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311214618.3106637-1-alex.hung@amd.com>
References: <20250311214618.3106637-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|PH7PR12MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 85fbea18-4704-4e48-2a8b-08dd60e6cd07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uZeFv+h1rF9qHPyu92Luf93udyTtrMkVp2q24m5FBVU7OcFze8v0/m0EVR0J?=
 =?us-ascii?Q?4o9r0VY4HbZlk2qoFoqBTZy333LIW6gVDpQN0WJH+wdjJFDR0jCWjibWa17N?=
 =?us-ascii?Q?bdvoYd342CWNKdwUdT2SzW1LrDAPjBF7kQz4jbPfnE9cNh0wYGn+FSJ7h0/M?=
 =?us-ascii?Q?o8DoSsWO27yxxkwKNx1QE3OZm5Vlb5NKqSKmh5OczpfCv2JdPnCYMUsJAFZM?=
 =?us-ascii?Q?gFqjxRoJ77a652smKWAL1BAqeR0Cw15N2WPYAYoLbny9LE44H8Tgk0GRumcr?=
 =?us-ascii?Q?LKJMqzyBZ+4DpIZdQCz/Tjboa3UxMv+q5y2J5QPieSq8CObA9413iI/kp9BW?=
 =?us-ascii?Q?GnELGwclHxm9Ad+yQPRsNLqh+CNhw/rwOshiiR2p2KmGhWqNMnruTZbDzNXb?=
 =?us-ascii?Q?6mtB30lj297meA+bJncc3+b0YorV230415nzNnPkXOJRXPoXW9dn5xquMWss?=
 =?us-ascii?Q?vY7Ck7HDypniN+f0NJeleAyqpGy64rhna3xQoibluRYvllcPQui3X+SBvRwS?=
 =?us-ascii?Q?spsfIUyIWqrxAemptm3QeZzIBT+BZOeC7AOla33D/wSyL+GKkrJm2Gy7Piai?=
 =?us-ascii?Q?ZR1LN4ZWKGmy/27rUmzYkSsVXbEAHs6XfasDt/x2ZHuXK5KExtuXvk6Zdcql?=
 =?us-ascii?Q?o5hes6vAWJ9sqFkUq04cVbwTMwcMnKGPUZlX5933+dz3MUFFkXvvjO+Aqtyt?=
 =?us-ascii?Q?184VEYwzoN/O4pd3DIl1/t7kcnSEtT9W5gfafGTv0G+Mzj3oQps8CP4BK4Gn?=
 =?us-ascii?Q?iKmkume4bWAWoAZbsggeJjO6hCfKtLyiZzh/0zj+Hvwse432ym83QoS5vkTX?=
 =?us-ascii?Q?elkFu2F3wn+FJ50UChoYeGwAQGkVMcvElLgJnM3wFsw4hzMySlGuXfhw6jDE?=
 =?us-ascii?Q?vOOBfmsd/k/x4AjXobSKwyyUAPogxxLK3UQcNUQN7T6w9ro+L7hxzoTo+upW?=
 =?us-ascii?Q?IwBLH52MKe/Ehtk+/DKKIeyosqR8fnNgFUUNbyA1G8I+TrAi6iqbe/bR2LHt?=
 =?us-ascii?Q?EUhL19Ys6tqeCWanwah7HguijCqHxnY5/1qe9AN4X4N8Wis5dh9CRmVexL00?=
 =?us-ascii?Q?Jq5hfj89Tk5g/Cvecfy2G5uCeTsoPEpCqGQCLPZ9b+WgUwp/ttaY6mXY4RXe?=
 =?us-ascii?Q?RDj0SJrUloViCRD2nVjMJtPqIYFqSdJHC5LwFhBCKt/M9BexHC5EcQyhX4s7?=
 =?us-ascii?Q?TyuK7XqGjB8aLqdnxjX8Vb8hwkKnsHXezwMjKSRbmRntvczghg8G80KkQDEv?=
 =?us-ascii?Q?WHCmlxFc1anCoBFcbVMAJXPoxxl+30epGhl3UME8vg/4NCo1ukKGK7YycsRy?=
 =?us-ascii?Q?wJuiB+1coCDqQymF8wucmhFA3nUafwEnp9FL0H2nJO7KsxNmh4FG24jRLoFq?=
 =?us-ascii?Q?y2ki9v9Ppb+QmOhRjAVehWutfuYMq3ZBDStmyftRwYd8lRrrZTPqNN+fT4Oa?=
 =?us-ascii?Q?kmgWT8Qhl0wSZAEHmChn91SOFeUqy3Vcng3Xqop9QvvJX/JVMp/AQGzuN7gE?=
 =?us-ascii?Q?J3QwyC/dSLIRmSA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 21:50:55.4396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fbea18-4704-4e48-2a8b-08dd60e6cd07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7356
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

From: Charlene Liu <Charlene.Liu@amd.com>

[WHY]
Update the static soc table dcn3_5_soc.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index e8efffcc69a1..92f0a099d089 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -159,7 +159,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_5_soc = {
 			.dppclk_mhz = 1200.0,
 			.phyclk_mhz = 810.0,
 			.phyclk_d18_mhz = 667.0,
-			.dscclk_mhz = 417.0,
+			.dscclk_mhz = 400.0,
 			.dtbclk_mhz = 600.0,
 		},
 	},
-- 
2.43.0

