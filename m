Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1F0C7EE29
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 10:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F358810E67F;
	Fri,  9 Jun 2023 10:45:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9145510E67F
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 10:45:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZwUOPgU4eRYiTzuD9mBcN/kX9FI9nwVfmkvSOpBfuzXHKkVGKQ/zIK2k/OxD9xPh3l89EYhJwYhek6sAVFv8N4EDsFNjNpfc23hlc2m/koIAvds/24M3MxGidv0cotHe+wVs1AZhH2bO45IkXce1y1S+59MUiIWUXBgethxQ6/dQ0UPtWFLi22D0iVLlakBKusVZT4ubSFiyZ0rQEQmCP7K82tgdhEx+zQj5oVqpexpbbDjmmThgPiLiBXOaySi8uNHtDEcSAK6Zll+CyT24XhnCnmSunOmu0IkezGEZoTN3WQysSWpc6WJOP6T2GTmtozG7dx91Ga3xRGLz6F6tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loCge+KzNRunUvwUPNGkCdIgZfQFZj3ccxzxc68XNhk=;
 b=bQXU7/nlQyRyeP6thRYUwdRhYK1X1BIzCMR3lyn9vZnN09ApUrIohNmnNp6R9/7Bm3XtTap6tdNaLi7ARBdSXfPpQvxn03saU+QtdncNVfTeHkzvHzo0KOFpkqwVSXOEA1/mMdSc/K3Tg7xmVgSeKqL6px3lqmsBwjqNxOpyaqGCadzY0kMBXBNdU/y9gRqmnKIvXJBTM0/5+utcbgqRtqW32PBxEeVcpLkcq+mS4Ivg+SX0bKUy3oSpURpJqchfvQye1Hx6NRYl+pA93I1HKdw7LQFjXIs9e7qgvZ/agImnaoSWG0eU8EMurVN/peuJ3zUDENmDB7nI68r8IHNLYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loCge+KzNRunUvwUPNGkCdIgZfQFZj3ccxzxc68XNhk=;
 b=MSvqcK3uSrXC3Bz8iM8hxoK0aPL/w+b+WswyvNy9qSAf8p28kGx6wXTMNk4L64ezgMHR9UsiqUOfWF4bocp560IINmBVI1b17mDCH7OtSoz97upxbp7pT6xHO8rkhB4w0lA2shaGxejRoh/1Q3V/2k5nBUMNuoSTL+ugzzhNl54=
Received: from SJ0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:33a::19)
 by DS0PR12MB8247.namprd12.prod.outlook.com (2603:10b6:8:f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 10:45:14 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::92) by SJ0PR03CA0014.outlook.office365.com
 (2603:10b6:a03:33a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.27 via Frontend
 Transport; Fri, 9 Jun 2023 10:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.22 via Frontend Transport; Fri, 9 Jun 2023 10:45:13 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Jun
 2023 05:45:11 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amd/pm: fix vclk setting failed for SMU v13.0.5
Date: Fri, 9 Jun 2023 18:44:25 +0800
Message-ID: <20230609104427.636097-1-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|DS0PR12MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: 075746b3-ae4c-4ccb-6c98-08db68d69b48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ECT+NJZK883UwG2I8S+WXonMzsdhKVNeb7N21poNVOBSaFtYKC7Y37AroCd2iZyCXVnJs7e0FXTfZ/ggCuiDFd17xGV3UIm1xlWSe43B9yLD6oUHd1Sjc7CfN7jgBDXKKLzDKwl4CKhb/LHvoW26uU3xfOwpzwqnYSenBmIcnHbf1N4C+mIcptQiW6F0WzHwtIM41YeSlTssNW7BZpFpc7zkbht1wcpoXUoCd0TG4bL/chWBCknKcx+NtkkDU5OdEzai5iv9BhFYHcehBFU9MTIG6J50/tUdQWBKo8fulAK/HvCrdQmHazW1p8m09BkM0k/f79RAK1/WmRsJhPg64tHB6T94gILKJ6vCbSruSLkaqYn2nTq2CXbxfrky3QxLYNVAgiiTXP175yGTWNAPWWh9mQRt6fLNAaIu6g0HaAOJulvZvII8ym3rmjMeo3p8jvcbQ6XUMsjmAIRZLiaac0iEXsdEILSO+D9NRgxdz2v+oazRQ9ZozPMW2cKHI1ZLyW2+QM4SmQQKNzHg1J9oH/sWrTy4uoUuBwrpCHzgGy/8x8o7zrUZGE1vFmYDP06fuvPP8XJhjRN+UM2uFE4QgTpjLlX727jdSSclGPz23XtPnvfcCOnE/q03d4LFBO/Cpy62wMdT299CNduRNXqIUyrak1rALJ8nDj1FRKjXMlEiUCPq/SIdTC9blCUwB8D+h4aDFFuReyzRE2oj37FVd9NvhYEoo9oKf/SgSeCfaa5HC9XFMtTGowd+k3/iCaiyGe8cBxoKHGFqdwwHvWdVxCR/dsasU/kThp/cmWR7IvShNZpT3k1L6mJmffy9CCc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(7696005)(81166007)(6666004)(2906002)(82740400003)(70206006)(70586007)(356005)(54906003)(8936002)(5660300002)(36756003)(8676002)(86362001)(6916009)(316002)(40480700001)(4326008)(478600001)(41300700001)(40460700003)(2616005)(426003)(186003)(26005)(1076003)(16526019)(36860700001)(82310400005)(336012)(83380400001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 10:45:13.8999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 075746b3-ae4c-4ccb-6c98-08db68d69b48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8247
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, jesse.zhang@amd.com,
 Tim Huang <Tim.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PMFW use the left-shifted 16 bits argument to set the VCLK
DPM frequency for SMU v13.0.5.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 7c3ac535f68a..725c791ad3fc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -831,6 +831,8 @@ static int smu_v13_0_5_set_soft_freq_limited_range(struct smu_context *smu,
 							uint32_t max)
 {
 	enum smu_message_type msg_set_min, msg_set_max;
+	uint32_t min_clk = min;
+	uint32_t max_clk = max;
 	int ret = 0;
 
 	if (!smu_v13_0_5_clk_dpm_is_enabled(smu, clk_type))
@@ -851,11 +853,16 @@ static int smu_v13_0_5_set_soft_freq_limited_range(struct smu_context *smu,
 		return -EINVAL;
 	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min, NULL);
+	if (clk_type == SMU_VCLK) {
+		min_clk = min << SMU_13_VCLK_SHIFT;
+		max_clk = max << SMU_13_VCLK_SHIFT;
+	}
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min_clk, NULL);
 	if (ret)
 		goto out;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_max, max, NULL);
+	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_max, max_clk, NULL);
 	if (ret)
 		goto out;
 
-- 
2.34.1

