Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C227EC77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DE3610EDD7;
	Fri, 14 Apr 2023 15:54:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3E9110EDD7
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTSxBmpH3tSf2VyssSdQPReVFfb2MJS+5V734R6W9nZ4zrTjNMXQwCpDU9VA3kBMHqdTP+Hvgw2RgGil2Mpkl/AGkBurfbtKCKoHmc8727iVRx18Z4mCN6LpaeovA/6ywgds57fTWNxr9Eg7HFF1uS/oRK6S36VU4URTvSYiE7Yud+MdUUF5Xv/fF3q9egMTpYqlH+AqvdHGHm8vBdJ1yWnOltGkC0JuE5ck1m405FHxZzPhsljvwwOIfM2u9WkCK0ENh7zsDmkFd2GUb86Jf3jRNR0hkOmsRXl7HGS7S7mnyMvI8XaN2vHDDzLAiPsHI30+Mm4ugV3wYw3t+E3Xgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDEj3ui+hQHPxavdkP9dl7aJ8tZttXG+8lozZ1AUsHE=;
 b=J2yuI5BQdtXE9qA8Y//Ke2XeisU3ojesHfASMbwB2bKH8yfyaKwvSIU0Dd3UxzIvs11pUSfWAf7IUuJ3GEY1MNcPBVKxqnknurxopausy9zfiIRKPL42bilxIkxUe2d9E2n1wVsRU3C/8FAesnAvDPhh9PbZZYU17b+Ig1GEEcIZboM7lZxcyi4dHCF2vW6ALJBQwc4tNRW5jj6OGND5Q+KNRaAUnM9ahwgvHyAJHd/6HEC8tgEOwPDuqsqJ7BjUhDorD5ueWU7py8k3kd0q16i8GXBBHbwUvi99WsYwMs9vl0mSZ35C3PybRSTY9b51ixM2tAH0HkTZJJLsFnaGFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDEj3ui+hQHPxavdkP9dl7aJ8tZttXG+8lozZ1AUsHE=;
 b=xszT8gKtSFxWyyj8vV4BkjIFW9Y/rP1IaHzMDDlSWOwr1wR9PWu5pv5V6h1p71wdVrKUiqupn1r8n3EmqlPl3TCfOXUK567vOLP9XdQY8PiDgHNIgSH2+m/n6w3eJYKJg0GO1S1Z+e7q907satE4NroX0xItAY2cKnXQabEcmUA=
Received: from BN8PR04CA0034.namprd04.prod.outlook.com (2603:10b6:408:70::47)
 by CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:54:30 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::15) by BN8PR04CA0034.outlook.office365.com
 (2603:10b6:408:70::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.37 via Frontend Transport; Fri, 14 Apr 2023 15:54:30 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:28 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 29/66] drm/amd/display: Enable FPO + Vactive
Date: Fri, 14 Apr 2023 11:52:53 -0400
Message-ID: <20230414155330.5215-30-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT051:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b6de58a-94c3-4003-5e9b-08db3d0088a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oyBfc9V6LmBjlZFdhH+hQYpzTzPwHChaph5Qn3YErz8A0MTJ54nS6bbit03g+7ad++jJtAxjAui5/lUT7H3XvmS6kq3HdgiNzQRnRG022BmFIzEMI/eG3yO/JhQj2sxRsOu3cBVS/xAAP4qo0zgvQP+7ySmxwTLnPwCrJYPhdvjqKmAbRuMUHWLT36VW5oFx2tcUYRabHeOO4Gsn9ERG2dm+Xmdzc7pW9+GUuOvM4XDJE46l8GqR9d0+SXNVxLVa0sVBgXcOWGvf3q+bSPFJM4iKkKKmMTJIp9sR5eXfczD/QepspvMupQczRSJTSBWaGdcSr7usXTK3Mv3vB41rmwnf79xE+xC5ukCDbWdIIr72CxsqvbpjGqGC0rOfbn452yha3PxC/z9BZEzZjs7kNaYmSN/QOseS8tLrDTMc6dflWXTVnG/zL3Y+Bsl5vDXXTOFA7BhUwnGRncbpC/UA1DbuX39J4auEj3J1pG3frHNRYQMlDKULlZeaGkYfENKxRcv9YlldxC7Ygul8KUdr2w6hGM9z243wWp143revL8J8rFwBtDoFGRm7HC/BTQLu64ZxOJWw63DtIOuFG3jKtrVOHlV38CjSCV8nZWmN7Jei9X97eEOloDZIJ0D5ROtynjjW7HS0ZcmERr0V65+qHUU/OQnMnmmcPqgDmjQe6E8xJ4DOn+RQvBse82F4YLAJLKKAysjfqTHvNpzzS5IW7/fvLB3IWrPBN5zvabt0+Zw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(26005)(336012)(426003)(1076003)(54906003)(40480700001)(186003)(47076005)(83380400001)(2616005)(16526019)(36860700001)(40460700003)(6666004)(5660300002)(41300700001)(316002)(8936002)(82740400003)(82310400005)(8676002)(356005)(86362001)(81166007)(478600001)(70586007)(36756003)(4326008)(70206006)(6916009)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:30.4421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6de58a-94c3-4003-5e9b-08db3d0088a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, George Shen <George.Shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- Enable FPO + Vactive

Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index a876e6eb6cd8..4f8286ae699b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -726,7 +726,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.override_dispclk_programming = true,
 	.disable_fpo_optimizations = false,
 	.fpo_vactive_margin_us = 2000, // 2000us
-	.disable_fpo_vactive = true,
+	.disable_fpo_vactive = false,
 	.disable_boot_optimizations = false,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index e5ab7f3077c4..cf21b240fc55 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -725,7 +725,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.override_dispclk_programming = true,
 	.disable_fpo_optimizations = false,
 	.fpo_vactive_margin_us = 2000, // 2000us
-	.disable_fpo_vactive = true,
+	.disable_fpo_vactive = false,
 	.disable_boot_optimizations = false,
 };
 
-- 
2.34.1

