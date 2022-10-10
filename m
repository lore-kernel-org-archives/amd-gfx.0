Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAE4C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Oct 2022 06:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D776410E45F;
	Mon, 10 Oct 2022 06:48:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C52910E45F
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Oct 2022 06:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2NR2dylLZEvKk3LY351dkf9eqYn2GrMLIj0ksbIDCCAm5Xn/Tb8xSbs/psStCe/ecpE5lBLF9Ar4MnPWD00bCN+Vn1GsIymiWvPnN003rF7UpySLf671lE5boP+f9Htc8B2I+iTAGBccEXbStpLIkYBuu8S2+xe57XdfxD+D6Zxa/Hh8iQL0i983SXxajORA6GUL4/YlV8KqmPFTQGoUaa63wKsdJxfWgHq6mFc12kVdtBsLdLRbwB5xc1Wzv5eRbpaCMv3lb19pmD52ZIrM/8b7Ceqwp3AS6WTAi5Pcnz2D90mWM324idCSv9697jKnTYRxEBvfh7nTl8jSv8+EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnfygYpViYcSwNsGOL+4hw5OyvXxhpbTp6WGRWLIxJM=;
 b=n2wPGmtevx+ZsxJ2aat8qEdmX9NMoFLctwPJkWt0eLlH+dkLKxvUJiPYar5fwOY2Q/P1DPHsOS5aU1UFR1TmIhYtF8GuTXn1T1Bkzy6fkTgFutRxTVVRJONI4cgXvQYpxKtIz1p083/pTIozNRGQmolnhJl2baUrzwTzWu41HCmNfq7B+/95dQyVeSyyyKjY9FBEvb5ijz13iZwo6xS8b09Tchu4+DAGz8gqVzB2QXosJc9g6q7oxeNaWe6VU+ZFZIgJSOSvRGneualG9mQwNYHZNiKOAmATU0z4I4XwmG1EkauWP4/PePg0lwQl1BK5Bw4MMIxD4daPB1AIGCHj4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnfygYpViYcSwNsGOL+4hw5OyvXxhpbTp6WGRWLIxJM=;
 b=AKfRGr3HhmygJ+bOqWLKJgaYndrmkaTonI3FsODRHr1rbnz1OtEUZdNCcIvVDUdzDe9NT7m6Hn0QTP2AhZQgQ8be9w/5AAltMPvV1bk4crnLsf0FF4yQHCyPCShFrGbYXQPn/YKXj/aDw+TdpnEeJoiLvo5HZjjFvHCCPe0S/eQ=
Received: from BN9PR03CA0272.namprd03.prod.outlook.com (2603:10b6:408:f5::7)
 by BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 06:48:14 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::9e) by BN9PR03CA0272.outlook.office365.com
 (2603:10b6:408:f5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 06:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 06:48:13 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 10 Oct
 2022 01:48:09 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Add poison mode query for umc v8_10_0
Date: Mon, 10 Oct 2022 14:47:07 +0800
Message-ID: <20221010064707.14459-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT009:EE_|BY5PR12MB4035:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f9b64a-54a8-4ab0-12bf-08daaa8b674f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +mjjKlpxL2inwyWjJjZ41OOwViUlm5b4UQ86vARW9RtrFz1uZLILxDvNs9xwwFm9883BT6FN0TqGe2QK35wZ3jHjerVBSvD090cv1GEe6U9WxyJfwkzdoYUU+XcAOmzUm4kMbfakbtIacLzCt1gLm3b/z0q6QD7UhMocsb3TZpuk3qxA3Yj8oy6evTGii3/b9b5lTH7wmMXZcr2hqGoSUO8JyoV+IrKIGhiV7THueII2UNkv4tbsQkNGtUNz1ONQIxjIgiKjTy5ihtwfbXT/deUfMqnKszg4Fz9wvUxWqG/Gdiq1EALQ9HWxbkIjDgjwST2j/UHUczcxXGRkw0qhBmqdbjs36JBMXEvGrX3tr253Chwo00/APe6yST79jyxvLXhUYONP2R6bTVTnmg5wZcR3s4GNeRR0jhkwvuYC7GwFlP5u3wvNeCSJjvbgr+KvH42EWArvoMl4T/V0bQ/+NOduEX8KLrre+8CyarEe8MSGncQmNO9Pzf1kshI+ghvA+YcXeHlTXO4lwQG7HnLTupAKpTSXUwQIbYiBI0haDBcRm8UYNOIXbn48KEv4TMFwg8QMyLcJnRyYh9dEf9ROBjJ2wPnxxY4Fz86TUkH2gkLD+2kiwRU0VxVao8aOGI02PS9aAnhrdzvloBYSECdeVWJiFqM9TJRhsyj7IzZw9XPZVr9/abl21YYJFbEQ+mDSafaui4C1/adf5NdeYGKikbC6oaBRl32lIjdqe4cn3I5zGVlknurknbOpk4g9+qUuC5D1h91PYdQ4IwGp+tWM9jH76rE72foRKYa4HJY0w11ECsSxQwMBtC0X90MaiG+b
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39850400004)(451199015)(46966006)(40470700004)(36840700001)(83380400001)(82740400003)(86362001)(40460700003)(81166007)(356005)(4326008)(70586007)(7696005)(1076003)(41300700001)(2616005)(8676002)(478600001)(70206006)(26005)(2906002)(6916009)(316002)(5660300002)(47076005)(186003)(16526019)(336012)(44832011)(8936002)(36860700001)(426003)(40480700001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 06:48:13.6445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f9b64a-54a8-4ab0-12bf-08daaa8b674f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add poison mode query support on umc v8_10_0.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v8_10.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
index 36a2053f2e8b94..0ba10d80c02536 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
@@ -344,6 +344,31 @@ static void umc_v8_10_err_cnt_init(struct amdgpu_device *adev)
 	}
 }
 
+static uint32_t umc_v8_10_query_ras_poison_mode_per_channel(
+						struct amdgpu_device *adev,
+						uint32_t umc_reg_offset)
+{
+	uint32_t ecc_ctrl_addr, ecc_ctrl;
+
+	ecc_ctrl_addr =
+		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_0_GeccCtrl);
+	ecc_ctrl = RREG32_PCIE((ecc_ctrl_addr +
+					umc_reg_offset) * 4);
+
+	return REG_GET_FIELD(ecc_ctrl, UMCCH0_0_GeccCtrl, UCFatalEn);
+}
+
+static bool umc_v8_10_query_ras_poison_mode(struct amdgpu_device *adev)
+{
+	uint32_t umc_reg_offset  = 0;
+
+	/* Enabling fatal error in umc node0 instance0 channel0 will be
+	 * considered as fatal error mode
+	 */
+	umc_reg_offset = get_umc_v8_10_reg_offset(adev, 0, 0, 0);
+	return !umc_v8_10_query_ras_poison_mode_per_channel(adev, umc_reg_offset);
+}
+
 const struct amdgpu_ras_block_hw_ops umc_v8_10_ras_hw_ops = {
 	.query_ras_error_count = umc_v8_10_query_ras_error_count,
 	.query_ras_error_address = umc_v8_10_query_ras_error_address,
@@ -354,4 +379,5 @@ struct amdgpu_umc_ras umc_v8_10_ras = {
 		.hw_ops = &umc_v8_10_ras_hw_ops,
 	},
 	.err_cnt_init = umc_v8_10_err_cnt_init,
+	.query_ras_poison_mode = umc_v8_10_query_ras_poison_mode,
 };
-- 
2.17.1

