Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1969FC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Apr 2022 15:16:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96ADE10E04A;
	Fri,  1 Apr 2022 15:16:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7025D10E04A
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Apr 2022 15:16:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtm6SzaWj4cccSb5YbE3hmXVRm9LkqS4KMcWZNBY7n/v10gRIN6MA2nrF57xGDJ24uKrjxbBUHMOoYrNEa/bdsjwJuR62cPLiljg/PIn7kJK9SJesvBL4UpczvbZd7qJ4qz2P+9DXk86il2IFrlMqtEuNDkIYir1PDYwRughk06kjfYNfYDr/1rVXURP7lskJUxcR7tlHUTwBx3GujJYB9OD+INcWJaWDFASpk9KEv5bUhtMiIGn4mPoNe5Aj0qPej2ubb5tRsOkbP6XeoPwli4TjU/7Fmdlw71Pg+pRBeoTc5ibgaaDexThM24ZjGykRR4vxPbTx5+UL+GeU2kvug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yYCbZfqDTVCKTaxCZFh2m12rY/UvHZvHGVLBdibSZY=;
 b=mLPYqtNTSclbDmpJ6rhrc7shwJ5WHuflXFQVRKmmz54rua7V9UWKh7N68BtZN86Q4eIP2mOk6RsjWqhe5sgs0yRRrQfQPndOtdM2UnttOh0/I3FC6ZJtUDu2v7cQG79/veUW98TVQ83TnePjru4XVyhWd+DZw/8PJIdD+y7WFoihBH6C6BCs96BlZ8WF/EFiYKChmWIUpWJu0RyNC+9EaXFPjVvAhLiA3EUP3QscalBCqLXzrd3OrKkmifLVKUl+k8BGAHwlYZO98SCLafnvsek1UpqfqSwtRV2NC9O/pErMVyGh3drL6tGDYUY9+T5Ov9nsixE5j4TOriq7+xQ1TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yYCbZfqDTVCKTaxCZFh2m12rY/UvHZvHGVLBdibSZY=;
 b=R02DySx9jfpUCJElAd2WCiYZg++GPUjrhtmVxD8FbVX46YwBvanxRDqhvnVnPkE4anJI01jU33RUGa0jiqPg4uv76wVU+VSnCfP59iD4eEHI+qh4pbtEQxcCBvcYbe2cbB/YeD9aChIVu3Xrdy8DnqY2cRJZe2qwUYSBoDHtoAQ=
Received: from BN9PR03CA0209.namprd03.prod.outlook.com (2603:10b6:408:f9::34)
 by MWHPR12MB1469.namprd12.prod.outlook.com (2603:10b6:301:10::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Fri, 1 Apr
 2022 15:16:29 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::75) by BN9PR03CA0209.outlook.office365.com
 (2603:10b6:408:f9::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.27 via Frontend
 Transport; Fri, 1 Apr 2022 15:16:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Fri, 1 Apr 2022 15:16:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 1 Apr
 2022 10:16:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/smu10: fix SoC/fclk units in auto mode
Date: Fri, 1 Apr 2022 11:16:08 -0400
Message-ID: <20220401151608.2910979-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 206b695c-fa7c-4a47-fd8f-08da13f298bb
X-MS-TrafficTypeDiagnostic: MWHPR12MB1469:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1469AE704BAA4605DF18100AF7E09@MWHPR12MB1469.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+DPFIiNGQdOTopoyAQFEyaTz8gZHhCC8jMEw0+AfhC+lfLSJxg7HiRkgKAmWPzKWW78f9cQ7Up/fzxms5ZoXmcvPyGZwv805kiwCnwxO1a+mB8MvZ/Wk635By1RQ+9CqhwgtenCG7M9F3zQZ1HZbl9PXtGMaSVy8i1TNtNYNIIccC7fFT7cqO69CjAgzkofRAk54WboXvV/i5y1OULFEkPRMVKick/94WPugfECeWdhmpBuLylzNWFPX2NNmZKJHPkfro4+NfU9M3INgGnKxhbxBXJzv049kq59XLMIFtE6e6k5PG7aWv9gPiSugbq1we9vQfm6X85mzw7lRKxOKmvBtD9nEiXMueiyR6eX8KnUr1uNwgY4JVkfztbwUaQmalaR2v3E/4tCGPHCBxF6bRkzomEhNqD3Dkc1XWvrmu8A/nRp18Y4LPhNsfDjjkOUhtk6vrPGl78MLioGwN9/cMEuXa5d+5qbT2eeh1kHFQCEjFalornDjmlS3iLSoNBVGYs40LwtIngBzGHTiEfGetYWJnrjmqNsJihG4JbSn7hpkHBc0/w9bAT+MTgmY9GPu1Y+ytpT9fsqU26n6SdjbRWHaX3M2gcgx99X0WQyRlIQFBwMHgEZcTHOV9euZgf43eUre7zxUHOd+ZtWfhiVZYqbnIqri3vCsNUx48rMxzqLMEhTHFuJXZjKQy/QaJ7bOxZ8hPHu1MGhUzVzQRWwtw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(81166007)(36756003)(40460700003)(356005)(6666004)(5660300002)(508600001)(8936002)(2616005)(7696005)(2906002)(6916009)(36860700001)(47076005)(1076003)(4326008)(8676002)(86362001)(82310400004)(426003)(16526019)(26005)(316002)(83380400001)(70206006)(70586007)(186003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 15:16:29.1191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 206b695c-fa7c-4a47-fd8f-08da13f298bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1469
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMU takes clock limits in Mhz units.  socclk and fclk were
using 10 khz units in some cases.  Switch to Mhz units.
Fixes higher than required SoC clocks.

Fixes: 97cf32996c46d9 ("drm/amd/pm: Removed fixed clock in auto mode DPM")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 9ddd8491ff00..545dd68a8c18 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -773,13 +773,13 @@ static int smu10_dpm_force_dpm_level(struct pp_hwmgr *hwmgr,
 		smum_send_msg_to_smc_with_parameter(hwmgr,
 						PPSMC_MSG_SetHardMinFclkByFreq,
 						hwmgr->display_config->num_display > 3 ?
-						data->clock_vol_info.vdd_dep_on_fclk->entries[0].clk :
+						    (data->clock_vol_info.vdd_dep_on_fclk->entries[0].clk / 100) :
 						min_mclk,
 						NULL);
 
 		smum_send_msg_to_smc_with_parameter(hwmgr,
 						PPSMC_MSG_SetHardMinSocclkByFreq,
-						data->clock_vol_info.vdd_dep_on_socclk->entries[0].clk,
+						data->clock_vol_info.vdd_dep_on_socclk->entries[0].clk / 100,
 						NULL);
 		smum_send_msg_to_smc_with_parameter(hwmgr,
 						PPSMC_MSG_SetHardMinVcn,
@@ -792,11 +792,11 @@ static int smu10_dpm_force_dpm_level(struct pp_hwmgr *hwmgr,
 						NULL);
 		smum_send_msg_to_smc_with_parameter(hwmgr,
 						PPSMC_MSG_SetSoftMaxFclkByFreq,
-						data->clock_vol_info.vdd_dep_on_fclk->entries[index_fclk].clk,
+						data->clock_vol_info.vdd_dep_on_fclk->entries[index_fclk].clk / 100,
 						NULL);
 		smum_send_msg_to_smc_with_parameter(hwmgr,
 						PPSMC_MSG_SetSoftMaxSocclkByFreq,
-						data->clock_vol_info.vdd_dep_on_socclk->entries[index_socclk].clk,
+						data->clock_vol_info.vdd_dep_on_socclk->entries[index_socclk].clk / 100,
 						NULL);
 		smum_send_msg_to_smc_with_parameter(hwmgr,
 						PPSMC_MSG_SetSoftMaxVcn,
-- 
2.35.1

