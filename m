Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF32C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76F971130D7;
	Wed,  1 May 2024 07:21:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="miLgQFf/";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E4B91130D7
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:21:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SS1DCPNVd77VE1DMwEZmTNFEu1FtbJcnU1moWwai/1vKZcUsxP8ppnk77brMkXdiUZqIx7bjRwTRlSF/6/nkfMDWipHFpuz+hmI41/FXtwsudIabNRqT30ItjW3vRuXEdLk5MPwV3YH3qnEMG7voDSi70qiJXSQbYmqBVdeikeM+8/iG5ZHqloNpt41MInQxtuZKCyAHWCTkD1nkkgPcJGmGSnpGzuvXtSw4/ZTFErcUDsHtQ/MuGevNqfx15tFMQNdOHT/jgaMIfW5ZF9tBpKQ2AG255h5xMqn0Sw7yykXsyrfR7GBX/QAgFC7xk9IQmcEtB9rRLIkuzy/nXsr1gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/i6uLLdYPw+DZYvPn4SZAmGly8HCin5bOLa+BUlw6g=;
 b=mT52S4ek2e825vxleOOG45Lt2EPWQbS9z5IBUMWPJgfbIalJNVOr4i8HJRaKtb2JIRWwkh3bBYp8eoMNvqF02jwTOGcd0hVrlRNYBvOns5oRTRKuOR3Es0PbDgn5ymD9uTw7g8BJlNjmdmcIi9foJWUQ8kCyWql5w+giulUrQf7y4wkju0xfxUnW7Hq+XWmKE7kVKpTmQJ4KTeWqM/cnrZCNsBdizZQMlN6mXsmaR7UHgYGAVk4PnIx+n2euZ/03yNZo+aEDGykYnfYEj1dpSpJUgP0mQ8ol/BNMRvIytYmNA/LBUU4VkwnMmrEcx67rZVd8X89PHZff054dj0SZKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/i6uLLdYPw+DZYvPn4SZAmGly8HCin5bOLa+BUlw6g=;
 b=miLgQFf/pISQVNUfLHQ1Jwe7xuWZOA6k71pMtG3Pb743X7kNzdIwQ/srtvteWl67+si0/tveGt/OoBsenUxumGl9EJZgyBMHoGDu6CbPSMXJg/nXcdpEBDoaI8y1Kn/meFPRpko1mLA7QcROfkjGfF/a5LnwJfueIN624rbsTQU=
Received: from SA9PR13CA0072.namprd13.prod.outlook.com (2603:10b6:806:23::17)
 by SA3PR12MB7879.namprd12.prod.outlook.com (2603:10b6:806:306::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 07:21:19 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:23:cafe::bf) by SA9PR13CA0072.outlook.office365.com
 (2603:10b6:806:23::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.23 via Frontend
 Transport; Wed, 1 May 2024 07:21:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 07:21:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:21:19 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:21:11 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 41/45] drm/amd/display: Fix Coverity INTEGER_OVERFLOW within
 decide_fallback_link_setting_max_bw_policy
Date: Wed, 1 May 2024 15:16:47 +0800
Message-ID: <20240501071651.3541919-42-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|SA3PR12MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e60662-1915-43ea-2576-08dc69af4c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|376005|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RQQi6bD/52xX93xAj6MSBoO1CwgpCy24Fio1t4WiK1Mtb5Sx5TEu4ZetYxNr?=
 =?us-ascii?Q?WYmVNyYzDTMRB9rRpko3IJmz0Q1WMux1AT71swQ/DZI5SRGyczccs4xwup4A?=
 =?us-ascii?Q?tA2M070khQEp3+7sk10TmQaRqWqhswMakSiQylEBQH5jD805w6KI4wNdpcr8?=
 =?us-ascii?Q?UldE6xyJU5eo05d+3Pm2kdFpQaXQ7pUWXTqx3WjSEij0eCtxsoLw49XOIE/1?=
 =?us-ascii?Q?xrQHTuw4q+6EJ/bVLAJcVGjTynLL2VEyHvdjLZWFp84ZgcqluofbJa6uZOYW?=
 =?us-ascii?Q?G9cj7/6wzGY+ULuJgPwbm5lL9XP/OV3bSUMQUBTXsrwr9F0LMrTyRrHHDAE0?=
 =?us-ascii?Q?qzacNIQYCxBc9JkqWM5PU9zPD+RR6A0iDyr7yOLLam2QPYxNc3kCIlPg/gvb?=
 =?us-ascii?Q?pa1sUOyQj3NjxisndWXEFk3jFvYI0FU4m9OnFM9dX0PCCh+9uC9o5haUHre5?=
 =?us-ascii?Q?ikyqXLdDougMlMvPoZrd95m73hELLH6lbMMNbQ8b8AoqL42fjPKFv8awj22d?=
 =?us-ascii?Q?xvYm1DH3vanbmPJQC7BBD/fh2C3kkMx6brENMP+DbrQ9eSJGOiyfhD8OsASX?=
 =?us-ascii?Q?x2UAHa6duK4GxBDUwF0WzOYMi8GpdlztQCPATMY4Mnz9uSd61uFQXA02dfu3?=
 =?us-ascii?Q?3ZFjxjiuaidTBnfonbPIX9IKGG1gGJlP8bFSyyfHEdc09XiwyPt8ovcgI40K?=
 =?us-ascii?Q?ZU54hYNNak78QPraWayZmUKn/XwfCxaRMXc9+DtHzz68nFFdbyGLMX0Mb4SU?=
 =?us-ascii?Q?bHTalsYSW6c6/Ch+FDOgpHp/gmAbudI97D0tEeNdoworu42NSYhmJoBJVRkp?=
 =?us-ascii?Q?TxO7n++aOcgwWXYB9MBLz1FBIdj1CI/E0c9MvkHa++IVti+T2voQh88NrYr3?=
 =?us-ascii?Q?K5xdfd2V44xt1a0GILrNQR8DfgsSAc34vOGC9hF+62CxdOjah1/rYIrFpmsM?=
 =?us-ascii?Q?kLF6wBTtgb7oZwIX+6NxjHuMWBDrNhuQom/kgHgDPSLXGRy2XJj+k6n6jD2Q?=
 =?us-ascii?Q?PuS4erq3NjcxaU30S52+bD5eievY6VcIVZtzoZUX2Z7hb240b2ANp8/B+XE/?=
 =?us-ascii?Q?wFIbJGE28a8BanxK06e5LFICxdUpCaGHIIY1xalNra3w6v2JCCUUllc/Knsn?=
 =?us-ascii?Q?lk2ypjZBqq5oS95pyXmxwoW45Fn8g/1Mnc/f8iTJwSqCmgRTm7UtzOkY4gLY?=
 =?us-ascii?Q?7vIIPYs5vWPOTfrhQPTeTaQa6zyCJwzeHJOHRO/r81bm9BqvmOVBlTOLVuUj?=
 =?us-ascii?Q?eA+XJENWqExHFjPCOu6FkjikKkfcPO+newJmmif1EVlHwLx3bRI/Wo1kIv7G?=
 =?us-ascii?Q?7sxRC827LsSaPaUqeCP6U1dejRUJuGvJHfkxdZrZ02K8iSyfT5T1tyKjrt8R?=
 =?us-ascii?Q?dKoaRyEfN2LSMlHUVyIa2OcHpzcC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:21:19.7690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e60662-1915-43ea-2576-08dc69af4c32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7879
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

From: Hersen Wu <hersenxs.wu@amd.com>

[Why]
For addtion (uint8_t) variable + constant 1,
coverity generates message below:
Truncation due to cast operation on "cur_idx + 1" from
32 to 8 bits.

Then Coverity assume result is 32 bits value be saved into
8 bits variable. When result is used as index to access
array, Coverity suspects index invalid.

[How]
Change varaible type to uint32_t.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index a01d0842bf8e..107b2cec572d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -534,7 +534,7 @@ static bool decide_fallback_link_setting_max_bw_policy(
 		struct dc_link_settings *cur,
 		enum link_training_result training_result)
 {
-	uint8_t cur_idx = 0, next_idx;
+	uint32_t cur_idx = 0, next_idx;
 	bool found = false;
 
 	if (training_result == LINK_TRAINING_ABORT)
-- 
2.34.1

