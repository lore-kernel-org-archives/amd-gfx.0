Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B57C7EE23
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 01:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DBD810E04A;
	Mon, 12 Jun 2023 01:33:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1495110E04A
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 01:33:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqc714eCaNGSqTSJkFyUnoB+JqRA9BoDmM46GeFlR+LV1Q+1k8uA2rteFQ/hWHvmvXCXWiYzof5TEDofL/NWTOk7iBhcXjfB9TCaK3LEis/aKuzWcoA5V4tIkGq2etR9FRbtZvSDCZTTDvy3/4vaIxsyY3t+QZr4Ggt0lfS7TGQUdIVhfPTicEQtOFKXWiM22DkhRrYmjEEUziRfzQbahW6xYTOkQCwaBPMK4G2A9Or73yCK5QHcltzsZLVtz6bpeyo/P3deij0HshEWPk5bilpAB81SiiYIfSCpqAO/3tssV/rDiBx6/k8czCibNYhfTtO80/ZuB6FssJdQlehyAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WxMC0NU9Nge35kZeU3oOlMN6d1QuFQNoP+s5Fr6hZc=;
 b=Gt53msDzcnIyaige93MdPVm8MQ6p81GTr95QP081dnXYo2loUA4QvMtwqEGNrMc6c3ckDpJb581u1R2s/9zlHiDus/9IP1eVqEShnFrBIyPXfyCJHGOyhcqpakKLRL3OP2GBmyl9n5ONFZLCZWD+/CAMSvIlW+dRqSIZ1/wJbMKr4kqCfPWfEcPoOTdXTJWwKxsWvrf7S59KfLxndgGSiw576HFdbEemDPm9stAdEG1VyJKybd/pY9wmjIv2Fn2KLuSDRFuDePRpZ71dy7HAZbE1EXFs0w1qHBWHfdzXaXwDqPG97pexLpGEuMmshUqZcWn4NIGf29njIZuuKWNxkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WxMC0NU9Nge35kZeU3oOlMN6d1QuFQNoP+s5Fr6hZc=;
 b=kj45EQo1Xku6cTd9EnKGxrqmaSiFxF8B7tRxbQgNouTVrvqid8Wmp/GbXLbxKhiJ4uuyklJvY93L6eb7fH+gneDb7ynLdJFu6bAT1NJ3I8usNcYA7B3GWc3tEdysMV4zEBXwIijiiB2nf1FbCy+2e3rFpBrlYI77ZmKHcDFjkgs=
Received: from BY3PR04CA0007.namprd04.prod.outlook.com (2603:10b6:a03:217::12)
 by MW6PR12MB8915.namprd12.prod.outlook.com (2603:10b6:303:23e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 01:33:07 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::55) by BY3PR04CA0007.outlook.office365.com
 (2603:10b6:a03:217::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.33 via Frontend
 Transport; Mon, 12 Jun 2023 01:33:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.22 via Frontend Transport; Mon, 12 Jun 2023 01:33:07 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 11 Jun
 2023 20:33:04 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Stylon Wang <stylon.wang@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Correct and remove excess function parameter
 names in kdoc
Date: Mon, 12 Jun 2023 07:02:49 +0530
Message-ID: <20230612013249.1486591-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|MW6PR12MB8915:EE_
X-MS-Office365-Filtering-Correlation-Id: 07fecb99-fce9-43e9-b9b0-08db6ae4f965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2JYTdoJ8lwUthkJ/YAJqCWKv9COH7xRZz70bh0EtOiLsDiAFI7fb0VkR5yVWeswyQdUfun9cZ0/ffS5FtOfQXpuV+wGDKCnxvsaRCm+UIJ4E374PKmbw90/Pla5lW/jcYCh4qgoh3QlDfyA0aUBXg+JEv6K7FsUEtkO+lo/PoDdlUo22N8NYjqXAusZdcI6urgOTx1qSxva6bwSZB5jAUjnKD1rDh3TKn6z7y/vNMsJSqe4rur/xelXulWKYUwVDJNqhz1K46Hs9HT4RyRBATqrkXfQ3VAGB4W9QvM6xoaDh46npXi5E/GczfLsTYSvuGbf2rqEI+zryKa46v/+sizsiR7tm4+XaG6vbK7Y0EZ4ayGv68binUx+gYUrSKZU4iylP9b4427DGBdF/mLzGs3d/fagqNkMKVr33M7cLzQYkZrXQo4Zr8XU8W0sed1s4jLaCAqMN9YfQ6d1nH97Lq6fciouwHqM8RJA3chm3DeNKrjdPWHDfLzaRAYwvhijVm3kd2vWxJ+enJreQJHQ/pIun04/dzBD5HFiW0y82ehFMFN1kjdxLyeptpVCcXCpua8XQgUiiJbuo6fzH4zyqHaaKiS+ipA3iIyaeTta+UyBCuz0nPTPy3phDw6Vb61yZ7b/jPc2aEhjAFrNC5ioiAfI8YBU/HM5UvRzFHtQhbunHvW/TxRD3RfATJ88sGERNXVtl37nLS7bqEViafxzed5HmWE6RY9xa1cOUS11dDNluM20QtC9DKrtfRgL2fIh08709MGH2nTaksSvptrW/rQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(316002)(7696005)(40460700003)(41300700001)(336012)(426003)(82310400005)(83380400001)(86362001)(2616005)(36860700001)(26005)(1076003)(186003)(2906002)(47076005)(44832011)(16526019)(81166007)(356005)(82740400003)(40480700001)(8676002)(36756003)(5660300002)(8936002)(70586007)(70206006)(478600001)(54906003)(110136005)(6666004)(4326008)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 01:33:07.0775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07fecb99-fce9-43e9-b9b0-08db6ae4f965
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8915
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following gcc with W=1:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:872: warning: Excess function parameter 'drr_pipe' description in 'subvp_drr_schedulable'
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:1030: warning: Cannot understand  * ****************************************************

Cc: Stylon Wang <stylon.wang@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 166123be4adc..e2bb2b9971f3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -854,10 +854,9 @@ static bool subvp_subvp_schedulable(struct dc *dc, struct dc_state *context)
 }
 
 /**
- * subvp_drr_schedulable - Determine if SubVP + DRR config is schedulable
+ * subvp_drr_schedulable() - Determine if SubVP + DRR config is schedulable
  * @dc: current dc state
  * @context: new dc state
- * @drr_pipe: DRR pipe_ctx for the SubVP + DRR config
  *
  * High level algorithm:
  * 1. Get timing for SubVP pipe, phantom pipe, and DRR pipe
@@ -1027,19 +1026,16 @@ static bool subvp_vblank_schedulable(struct dc *dc, struct dc_state *context)
 }
 
 /**
- * ************************************************************************************************
- * subvp_subvp_admissable: Determine if subvp + subvp config is admissible
+ * subvp_subvp_admissable() - Determine if subvp + subvp config is admissible
  *
- * @param [in]: dc: Current DC state
- * @param [in]: context: New DC state to be programmed
+ * @dc: Current DC state
+ * @context: New DC state to be programmed
  *
  * SubVP + SubVP is admissible under the following conditions:
  * - All SubVP pipes are < 120Hz OR
  * - All SubVP pipes are >= 120hz
  *
- * @return: True if admissible, false otherwise
- *
- * ************************************************************************************************
+ * Return: True if admissible, false otherwise
  */
 static bool subvp_subvp_admissable(struct dc *dc,
 				struct dc_state *context)
-- 
2.25.1

