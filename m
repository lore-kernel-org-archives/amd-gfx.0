Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE695C25B67
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEE9710E814;
	Thu, 26 Oct 2023 14:20:46 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38CF510E0CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:20:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndq6HX0Xm1fQkuvvGliZ9SjWJuaea5+RbMTogM9I3jQvzw4hjn3AHWoWAj8O16bzxhYXHhXsx8sN5qXSR+h/xH4ng4AiPAyT8u/7eAlrxmaeXKTJlzLsW+mwk2RUnfHTLLPcgigDBpCpKurrlbCv20vrbBJPdvoti/n9OjAf+gOhgl/j5d7eY50bYmu6NWh4z7fe9F0E80BFVncaUZuQkzjPlXDkcCEF+UuZJM3Bcne+s3g2v1o0UVq7LpMSzrG2eAqHzdcWguB95gqj8fSVj0GB7BaMRJOLU/TYZ6zmTAHuA0mQW27fucU1YSNjObI9zA39Hfi/1i/6lkuvnrjMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTc9C8C7ugZdaU7Mphu6+PmemtMwz0NeXyj2SN9CgVM=;
 b=nzPUApeBXJjbmuEVgE1BnojRuahF0XWZvPurndZ8T3n9HnKyTcOnHy+zq+cUYZaeetezRyog6rHfE4HGbbro3qaOhZ9G6FuvpI0VkRLo92DIQQxVkj2bWibVbOXVY50C3TMeheuLpFhUpPnCl/jN7gYwRQsC/nMHaqE/dFaCTxoEr5RU1Ix7q7TBCMhP6kvyHWTSS7QPuFM29/2DWc1LSgTNxnIxjtvojzv309+znIT0CHViAQZuqafRNwSFvTXngFT9+AzBpKZQuVldr2IIk06ZTJuLHTSpdoD9sEEeLngH3PUYxPN7K0CKWcEuhYJ7NkloY/bq8JsZrgd9Si7uJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTc9C8C7ugZdaU7Mphu6+PmemtMwz0NeXyj2SN9CgVM=;
 b=bOVD/YUJVpwcPwKZtuf2GIS3g24HHBxQD1EGDmh/bocdpsr2NgfBbORBNmIbsREcp3W2zrUtCaGlTe1SOC/SZH5iovOY9ccw0FlqvE1gKdY0WGWHMJ+dwDUVeiMoYguMVHlchRQhRLm2JrVc7n48ReF6cUSrnlvF2nuOZjOvt6M=
Received: from MW4PR03CA0071.namprd03.prod.outlook.com (2603:10b6:303:b6::16)
 by DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 14:20:32 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:b6:cafe::ab) by MW4PR03CA0071.outlook.office365.com
 (2603:10b6:303:b6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.35 via Frontend
 Transport; Thu, 26 Oct 2023 14:20:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:20:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:29 -0500
Received: from hersenwu-Majolica-CZN.hitronhub.home (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Thu, 26 Oct 2023 09:20:28 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/25] drm/amd/display: Fix blend LUT programming
Date: Thu, 26 Oct 2023 10:19:58 -0400
Message-ID: <20231026142020.67861-4-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026142020.67861-1-hersenxs.wu@amd.com>
References: <20231026142020.67861-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|DM4PR12MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b42fd1-01d3-49fb-3e84-08dbd62eb664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uinEINtsM+vvT+FVtr4yq5MP5NoCjAIZrbj1AQQZXqngXwC6oyAXvVEB4ayTa3XexzFc1qgSVPQj1JgYHwMN4381VeYVKI4qNE7UmgNHe/YlFnBGkP/juh+uNY2RMgfYmaQtHelPNaTlhcpivo6hqoEj9aLpHz7KtoyXz/EbnBRp6I4dNUys1fIMQVK0SP+YEp8W9Zlx/YhSyBDdZuPfC305JmRolSFc2ifTXqHotQV1uw+ClgjLIVVQA8o7pW4dMRs4bOtA3toum3+27kiq8MZ2T75OmKzOW2CUXDZTLoHBpA1upfW+cGW7ZCVuR1J886UvEYFHLCbySW3kLxTLs8E2uMFCdN3Z28RE4apkC4iNogWAbqHAaBQi5Bf2i+h/j2DQisTBDwGdUA5BzOhiWRz5NaYJOkJKO9jcdt2JVjM8QAQst8uy6ybhNOhksPgulkBCxIYqy8NPrDKg4TJPs5ODProLHRBl3D0y0GQgklNZNRHHEIGAfFHvH8UAV2SRGhklHEXPEy1+MWLLesXg8JIGaQo2Gq0/qCBW4S7O+OPQ3XxoXD5Z+cvggq7xCJ0EBp+TbCfmcn+d28MtekkNF+nBbAP2Vuzt5r34phzojpw/8Y9F9FxO5WY6z/bTYH1W3xIDbyC8ce2kLQ8DnsX54flPEp4EeZzw17um0i7tqEMI+J7cV4uI7ZiHZSXJM3xOIWvjKMmy5Cre4qbsfRMpLoqdyYNwg+OouSwqJ4iri8cc3E6OCGLsfJsUqIQxZUKI6f5iWiMFBsNG1ZFPsDw0tw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(26005)(86362001)(41300700001)(2906002)(40460700003)(36756003)(5660300002)(36860700001)(8676002)(8936002)(4326008)(2616005)(6666004)(478600001)(1076003)(356005)(70206006)(81166007)(316002)(82740400003)(6916009)(54906003)(70586007)(83380400001)(336012)(40480700001)(47076005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:20:31.8358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b42fd1-01d3-49fb-3e84-08dbd62eb664
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7646
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
Cc: stylon.wang@amd.com, Ilya Bakoulin <ilya.bakoulin@amd.com>,
 Krunoslav Kovac <krunoslav.kovac@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya Bakoulin <ilya.bakoulin@amd.com>

[Why]
LUT write index does not get reset to zero when writing the LUT values
for each separate RGB component, which results in wrong data for 2 of
the 3 components.

[How]
Reset LUT write index to zero before writing each component's data.

Reviewed-by: Krunoslav Kovac <krunoslav.kovac@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c | 3 +++
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
index 50dc83404644..11f7746f3a65 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
@@ -613,16 +613,19 @@ static void dpp3_program_blnd_pwl(
 			REG_SET(CM_BLNDGAM_LUT_DATA, 0, CM_BLNDGAM_LUT_DATA, rgb[i].red_reg);
 		REG_SET(CM_BLNDGAM_LUT_DATA, 0, CM_BLNDGAM_LUT_DATA, last_base_value_red);
 	} else {
+		REG_SET(CM_BLNDGAM_LUT_INDEX, 0, CM_BLNDGAM_LUT_INDEX, 0);
 		REG_UPDATE(CM_BLNDGAM_LUT_CONTROL, CM_BLNDGAM_LUT_WRITE_COLOR_MASK, 4);
 		for (i = 0 ; i < num; i++)
 			REG_SET(CM_BLNDGAM_LUT_DATA, 0, CM_BLNDGAM_LUT_DATA, rgb[i].red_reg);
 		REG_SET(CM_BLNDGAM_LUT_DATA, 0, CM_BLNDGAM_LUT_DATA, last_base_value_red);
 
+		REG_SET(CM_BLNDGAM_LUT_INDEX, 0, CM_BLNDGAM_LUT_INDEX, 0);
 		REG_UPDATE(CM_BLNDGAM_LUT_CONTROL, CM_BLNDGAM_LUT_WRITE_COLOR_MASK, 2);
 		for (i = 0 ; i < num; i++)
 			REG_SET(CM_BLNDGAM_LUT_DATA, 0, CM_BLNDGAM_LUT_DATA, rgb[i].green_reg);
 		REG_SET(CM_BLNDGAM_LUT_DATA, 0, CM_BLNDGAM_LUT_DATA, last_base_value_green);
 
+		REG_SET(CM_BLNDGAM_LUT_INDEX, 0, CM_BLNDGAM_LUT_INDEX, 0);
 		REG_UPDATE(CM_BLNDGAM_LUT_CONTROL, CM_BLNDGAM_LUT_WRITE_COLOR_MASK, 1);
 		for (i = 0 ; i < num; i++)
 			REG_SET(CM_BLNDGAM_LUT_DATA, 0, CM_BLNDGAM_LUT_DATA, rgb[i].blue_reg);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
index 1d052f08aff5..994b21ed272f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
@@ -237,16 +237,19 @@ void mpc32_program_post1dlut_pwl(
 			REG_SET(MPCC_MCM_1DLUT_LUT_DATA[mpcc_id], 0, MPCC_MCM_1DLUT_LUT_DATA, rgb[i].red_reg);
 		REG_SET(MPCC_MCM_1DLUT_LUT_DATA[mpcc_id], 0, MPCC_MCM_1DLUT_LUT_DATA, last_base_value_red);
 	} else {
+		REG_SET(MPCC_MCM_1DLUT_LUT_INDEX[mpcc_id], 0, MPCC_MCM_1DLUT_LUT_INDEX, 0);
 		REG_UPDATE(MPCC_MCM_1DLUT_LUT_CONTROL[mpcc_id], MPCC_MCM_1DLUT_LUT_WRITE_COLOR_MASK, 4);
 		for (i = 0 ; i < num; i++)
 			REG_SET(MPCC_MCM_1DLUT_LUT_DATA[mpcc_id], 0, MPCC_MCM_1DLUT_LUT_DATA, rgb[i].red_reg);
 		REG_SET(MPCC_MCM_1DLUT_LUT_DATA[mpcc_id], 0, MPCC_MCM_1DLUT_LUT_DATA, last_base_value_red);
 
+		REG_SET(MPCC_MCM_1DLUT_LUT_INDEX[mpcc_id], 0, MPCC_MCM_1DLUT_LUT_INDEX, 0);
 		REG_UPDATE(MPCC_MCM_1DLUT_LUT_CONTROL[mpcc_id], MPCC_MCM_1DLUT_LUT_WRITE_COLOR_MASK, 2);
 		for (i = 0 ; i < num; i++)
 			REG_SET(MPCC_MCM_1DLUT_LUT_DATA[mpcc_id], 0, MPCC_MCM_1DLUT_LUT_DATA, rgb[i].green_reg);
 		REG_SET(MPCC_MCM_1DLUT_LUT_DATA[mpcc_id], 0, MPCC_MCM_1DLUT_LUT_DATA, last_base_value_green);
 
+		REG_SET(MPCC_MCM_1DLUT_LUT_INDEX[mpcc_id], 0, MPCC_MCM_1DLUT_LUT_INDEX, 0);
 		REG_UPDATE(MPCC_MCM_1DLUT_LUT_CONTROL[mpcc_id], MPCC_MCM_1DLUT_LUT_WRITE_COLOR_MASK, 1);
 		for (i = 0 ; i < num; i++)
 			REG_SET(MPCC_MCM_1DLUT_LUT_DATA[mpcc_id], 0, MPCC_MCM_1DLUT_LUT_DATA, rgb[i].blue_reg);
-- 
2.25.1

