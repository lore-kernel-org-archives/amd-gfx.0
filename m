Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D703BEE2092
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 11:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B73A10E745;
	Fri,  6 Feb 2026 11:25:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kv7LPPD7";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012008.outbound.protection.outlook.com
 [40.107.200.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67BDC10E745
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 11:25:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVAlKOH8S3Xzfbl3p1e0AswbrmhROj+7kwMjg1I0DB2L8W4eORahwIQSM7TbDUnbe5hwm3YMsy7lpnPsWrdXk0dLYcxrrsmQENeDneOJtxWhUjNKmbB+y8/hUlRcG8umgzMJIplUd6wlfg0ht9fv+oD3+lq9FDMAhnF/Wx74ng3KRpOR83fZUHRA31yESY50N/W/838djT777mEIv1xMYJ51xhOiKC0Tgr2IOmF/S+hKKFg6aMSPDAK2daOuKZUi0cbV+2v6FMS4nVZDMd/sTDRo6vT2RLCAStnIAyxaOM+OHFLxw7Gctmxp8w4H5FAnmE+wZEbQF9h1Gx6kOiReTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHMBUt0dkIUzORAuJnpT83Usz1NNc1B7UOowJvkew5s=;
 b=tEofkiwUcbwpxyClObgc2pZajkQbwcyXpK0TBmjsWdXXyPNjFKPTSHbA/vZzI2k5ZPdoSlXT5+Bf3aBQK4+FsHt6BtzmMQ34uaLXZ9xpBiY1xdcw5A3191KLPd3e9/sYoflTxHbE3HGsxUWOGvlzndYx8ic+apn/+CilQlccsPqhJruP/ByCpvozZWOX9sxEXhXPxEilzWVntMpWuUXqN/G5zFQV+0TBYubWaXFkMo5OUIVUFCrUTqttHkbvooe28lNgxfisH8ut2/3qToYwBNJDxlrE9MAv/Q+2+HexMT9WB86novOjmAhW69CCp3ZnZdeB3CWdc20WLDZQbX/Plw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHMBUt0dkIUzORAuJnpT83Usz1NNc1B7UOowJvkew5s=;
 b=Kv7LPPD7mYhJRSoBhwxDn3MZm2jxcFspZFkOvAMc3zUNsYh3rxPYE0NSl8cAVXAYF+a3ngJAYfddx/qHJXAgqFqRztweKj+ipXtxT4Gg5OvhCSQQplfVbDcGeVG2xzjDhboVZSO0V7lCoNjjIQHMtzZ5N/4pKlxtys97DuHVcMA=
Received: from MN2PR06CA0011.namprd06.prod.outlook.com (2603:10b6:208:23d::16)
 by CH2PR12MB9541.namprd12.prod.outlook.com (2603:10b6:610:27e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 11:25:20 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::af) by MN2PR06CA0011.outlook.office365.com
 (2603:10b6:208:23d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 11:25:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 11:25:20 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 05:25:18 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v3 08/11] drm/amd: Drop MALL
Date: Fri, 6 Feb 2026 11:24:46 +0000
Message-ID: <20260206112449.45381-8-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206112449.45381-1-Pratik.Vishwakarma@amd.com>
References: <20260206112449.45381-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|CH2PR12MB9541:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ae189ae-25f6-4eb1-10a6-08de65726968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JfyXtzTVc69VV69XyUhpZ0TRl3RA0AVnG4+cbumNdbnJELBqkr6rH6XBSUZe?=
 =?us-ascii?Q?BUOO/e7UVcG0iB/Ks1QVDExk3NnD3gqyN1JOGAkE4IdIVvF3E6pHawv4esRW?=
 =?us-ascii?Q?GB2pVBOH5U1lDai47T9WrusjcdzvR3xnP1chSgPPR1ofRDwTia/2sUjE5P+t?=
 =?us-ascii?Q?hsiqvTIL23nPCPeXlaSdGiu/0lVaamuDythlrCuIUXKuzwgCTVAcExpxnVfn?=
 =?us-ascii?Q?p3N3FkSQm+D8qwp2wXi6e8L+kvi1S1rW4ityQW4YsPFIjNPblonXAK4QYJek?=
 =?us-ascii?Q?WzOhfi/EwS3NiyA98OKQzvWaBTbZbUCvGCcfgtLueDMZJgxx9CzgvJR048i4?=
 =?us-ascii?Q?zbfOnKucOZutIjv0E+cYR+Pr1x8HEXwPVr5UOCpQvYnGxDeCriidP9cGJC+t?=
 =?us-ascii?Q?NJM9ekbxtLpa2ksbv7vymog+JPrZH77Jv2wLO6JeWnQkYYf94ObvJ3Wf6qfr?=
 =?us-ascii?Q?hh/xx2KcNLpOru82dCHQM7yUOWm20uk0H4YvpxmfWJiVjSoV+R1RfQf6Ru2m?=
 =?us-ascii?Q?bsn7Ljd1/i7BYn0upTnMEi9rQP6fDbtJJsBYJqwAD09E0iMS2fGFRvwkWKfk?=
 =?us-ascii?Q?JpsZWCxmf3nnQNiRfsx2OzQE6xLMe+SDwTVnkfThebBPuikZAiBNSJ8giLgR?=
 =?us-ascii?Q?RbxEb9uyRBSNZv6vlIO27IoA20JAyecujwQf1eUfZ2J7bVfAW/87RNwtd8tm?=
 =?us-ascii?Q?wU0Ne+okkmK3u6Bw0C51jHbX87R4WXLcLSik7p9cbDF3OSqSuXAf4xoGWjkB?=
 =?us-ascii?Q?LS3Clg/nzHSnuPgjbfszH0cGYpZEPVH9XEYb/3bHXdrXT2HGyC9wk7FIpzZ7?=
 =?us-ascii?Q?ceajQd23iV4IxkBjTF6appl/lz1p+2fjK33M7RDnfy9VVJb7aM2JOOc33PxI?=
 =?us-ascii?Q?yCfqYIFcCAcu33FaPInHw9G9+SqeLSruq+wPLiqooqrl49NU8udk5Fahkb68?=
 =?us-ascii?Q?MMFBLD483wPwbFGpWjDx71xfbqGY8irgmvQRU6zJIIqmblrV+4rjgzr0/OV/?=
 =?us-ascii?Q?uJcnlnPocaZar1uSruM/AkrNQSCESyHsNAHA5UY+E1RuHaqWN466pwJR6FjZ?=
 =?us-ascii?Q?s31IU5z4nzrMZiZeGaFBtl21QC7FaBYcZAc3+U7/CpzpMzxjulTUeZ9802sa?=
 =?us-ascii?Q?YF1OncGd2lh34rhKV0DYzdB9BKbs5nAY+p9XQjsUiivS3iYaLuqRz9roTTJu?=
 =?us-ascii?Q?qtGAq1mHW9rDb6zkbq76jGQ2rD9qQ3jiFJNUpMcMFBWkTsp8q3Yq3OHQ8jaK?=
 =?us-ascii?Q?FVu71HLzdwzYy+309ZtmbHJlUP5wo+joOLbMIcVlz5QhZue4ICOHuRQKPMue?=
 =?us-ascii?Q?8zpyjLMleHkZsrBXFPs+4TKTfNfmG3SS3WY6/gylP3FYSYJt2Fb7x3s7AQdR?=
 =?us-ascii?Q?L2SohG6OLnfw47CixZWayP78HFmgGexmw1+cxf8TdhYmIIqimW7SJPk9CJrx?=
 =?us-ascii?Q?uAkF790wB2gKNDdkfSz5oLUH4UPNmcyCFfSVVXlioiADl5pVQjWJ6ZVo2mVk?=
 =?us-ascii?Q?0TwCJiak6Fin6Fo3onFCUNjDLxTOAswf0/NsQC7RyFD42PrDqnzAnk3xFoiD?=
 =?us-ascii?Q?wA/e4QsqUnQu0UQpLapJwz/vkF3ftyDrmScWQdHssxnX3xWdHUg7HnmvF+fp?=
 =?us-ascii?Q?bjsbCVhKU74yhKNHmCAK6ys9CmhAD60NJgK6ErXT+4bQZFSHK+sZjRylHMHY?=
 =?us-ascii?Q?8ujAsg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: neLyVfmFpljoIBnR1Voj0oEmzmHe3j42QqQ4A827SGoZBzrvmUpoyT8IR+USFIGw2Fr7TMCoXrEyTozYtbaBy8VSgtDtXI63oDnXktmBY5kwSBYC5C2pA1eApaCnSDLVM9n4a6CkaTuEuyrE8iAQFFss3SdLa48KGKLgDkrB+122XTCi74tTAytptxgy+twMP2iuVOTubstIblpyf9McPrUI3IU1FyacoxGD70c6SKXAh4FlBDpvduSvBAQgPJBkmRgFXuh3ggBdPS1eEKyWHzWDNtrAbJTvUdkjpMWkR8RWPMTgbgFDNvDheSEsKApV87L47JG5GBpreI1IG8QLLshMHL5O8IezHtpmYrgUFcvpk0/zln9CpAlal7yR0RYoieEiM5+raTluooJSRiTHnS1mhALCuQ8JCWioD4SqDUydMoh8REk9MjhmA3QtNkyM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 11:25:20.1921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae189ae-25f6-4eb1-10a6-08de65726968
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9541
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

Not supported on SMU 15_0_0

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c    | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 7331c7559454..140e5b8c0489 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -58,19 +58,6 @@
 #define mmMP1_SMN_C2PMSG_34                   0x0062
 #define mmMP1_SMN_C2PMSG_34_BASE_IDX                  1
 
-/* MALLPowerController message arguments (Defines for the Cache mode control) */
-#define SMU_MALL_PMFW_CONTROL 0
-#define SMU_MALL_DRIVER_CONTROL 1
-
-/*
- * MALLPowerState message arguments
- * (Defines for the Allocate/Release Cache mode if in driver mode)
- */
-#define SMU_MALL_EXIT_PG 0
-#define SMU_MALL_ENTER_PG 1
-
-#define SMU_MALL_PG_CONFIG_DEFAULT SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_ON
-
 #define SMU_15_0_UMD_PSTATE_GFXCLK 700
 #define SMU_15_0_UMD_PSTATE_SOCCLK 678
 #define SMU_15_0_UMD_PSTATE_FCLK 1800
-- 
2.43.0

