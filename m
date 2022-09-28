Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53AAC6FA82
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:42:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E918E10E9EB;
	Wed, 28 Sep 2022 19:42:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 471AD10E9B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQlW/2fJ7rXiCAZUZ0CNLliWX4PtdRD2s8mDQoqU0L/MOZIp7Fx2TKwZPnqTc6lVDvyNFEYrif0Ot6KCli25P/xAxNiQnkl2U2cklRq6LWvg2VTUtASjDpx18q0iDihcfXHlJ4u9f18Ny50NpmFLFCmaGLUPwaryZutiEwvMhdLS1E55wdkSUdIVzxRKDclpCuBCsYkBgOyi6usekAG7LVNar/+NvKHqdL3+s8ScEmkYAC1BP4ngXH1eAW4xbyTiAGEmt2l0ED+x7huBti2YQ2vdU6kIFew10D5exBW/O1GUs0zGh0VNbJQG1M/BnW9O7ZIdHFuJuWXhYb3gt4k4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aM0puCX8nTbNglg/y+yWcvjBixpwMo3JLTIIQWWuerk=;
 b=CsbEaj4RiJlb8Ozk/KAKZrzTN1450PeBKjjiYYKsujwsGXMcvftgYaGQibcJtKqg+BtEB/m1jVm7WaFjmmwih5dkkCYR99qV1IYgnOk55Q3nmhX3xf1RpVOw8PzQ3ZE9dLfJkinanXQrEZxYs1QabFIg2y4vZWgVrsDwLXhoWU5HFYlnx11tGX571Ow2nO2N9dmbLNfsVfJ7zziMzCTL017aPRHGtdfSTxpx8gfQpNfDh1QQV34zD/bMYsrNLconZcXpZ9+NgPwCQG9NQwRHdGKzGejxoWiYZS2jlljZho6sKYz7wawLkKQGO7hgu30lbl9Hu9+2P1H9kHjWnX8iEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aM0puCX8nTbNglg/y+yWcvjBixpwMo3JLTIIQWWuerk=;
 b=gqBllxOzyFhucWWE/AY43YleF0sgJ9gD5czW/NRDCX+l9B5z3TJolYO8eNv207Xqz/MmCGq/uZOtFlvKZDMAp3CS9ThYh0Q8PFSJorUgTp0gMDmEOkLVwRVdfk/OGQ3oYaaLW52O0hEQDgnwW1EPFitk2IePufd0oglA7rdeHio=
Received: from BN9PR03CA0741.namprd03.prod.outlook.com (2603:10b6:408:110::26)
 by SN7PR12MB7321.namprd12.prod.outlook.com (2603:10b6:806:298::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 19:41:35 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::a8) by BN9PR03CA0741.outlook.office365.com
 (2603:10b6:408:110::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 19:41:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:41:35 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:41:32 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/36] drm/amd/display: Fix disable DSC logic in ghe DIO code
Date: Wed, 28 Sep 2022 15:40:19 -0400
Message-ID: <20220928194028.144879-28-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|SN7PR12MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: ad58ab5e-160f-420d-e12b-08daa18973d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gu8gE5AHcONfq7cWeYH4H2xTn1pTyXWBHYNDDclBfWxgjpb5RIWSdF9oHIDNC35UdBOuu6tqmGMBm2LEzW9Y8dyLj/HwspS3IdYLtSzBVuGGX6NDYwxO3ZpFuFk7tuS304/43tbL5hJUl1QWgPX9/VroBEMYd+Z6/kQO+ibMK1bWhm+iwaevQrH69fj1shjJFhldyj/4DjP6MnfgmCFCtIs+Yl+UrENx/0gDrca8xQT+ibWm2rEWTgUK93yTGaTitjg+oVuZ11n4WaMk5YqvQZBWcyFe3tyuJ+zGmR9HyNsepjU0crLLG5Q2i4rCQJfHETLc/5DrrFowBl0aYTe4ZUhFtcVIuVBUuMR+HQAJgQWEi4AcvagxBlw274DxrR4Z3Khmw8JvR5u9L+z5xTlPUHpTgH9IK+WYl/rnMOEXBPouwOwxXe1ErYsfDGws1mnil0y/POj2pyLPwx9T0tYBwXAHPgUvnvTzymO8nXjtzMFG8v5VQx7InXlv8vwORU4gi1e6TEgpdZzqG2OZ/wSsUZo7Rx/zf1Vj5C1x2nAbsyZjj21KapQxI4GjzhCvFPBy/WwC+TwlRVUeCAyzb4o3oGNxQgv2KNOyqGIrxyvD0dHbUAzHjitPXOBG1g8XEOUuNzu6uXnMaS/PodkJW+d3HWPpZC4qc3l3T7oxBC7FhJZ2LF4Vp6WznKFvGe8jD+68w6Gstd1ORZIaAtSC33guWn1k5jLfAV21z2pNsJvp6/N4Vs8oksEV/G4E7u/B5qNVMFykIO1rtf23XsmaUP52FLexPNeKv4GdM9MbwZ2wi7dK0cubNVx2YLKU8daKIU3TqKIgrmU5GOogmjHWTb3Rqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199015)(46966006)(36840700001)(40470700004)(2616005)(186003)(336012)(426003)(47076005)(1076003)(16526019)(83380400001)(4326008)(81166007)(8676002)(70206006)(70586007)(41300700001)(316002)(36756003)(40480700001)(478600001)(86362001)(36860700001)(40460700003)(82310400005)(5660300002)(82740400003)(54906003)(6916009)(2906002)(26005)(8936002)(6666004)(7696005)(356005)(44832011)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:41:35.1382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad58ab5e-160f-420d-e12b-08daa18973d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7321
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Eric Bernstein <eric.bernstein@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

[Why]
In DIO stream encoder, definition of DP_DSC_MODE is changed (only
enable/disable) In OPTC, OTG_SET_V_TOTAL_MIN_MASK_EN is removed (same as
DCN3.1)

[How]
In DIO stream encoder, update enc32_dp_set_dsc_config(). In OPTC, use
DCN3.1 version for function interfaces .set_vrr_m_const and .set_drr

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
index 40e713c4e172..d19fc93dbc75 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
@@ -388,7 +388,7 @@ static void enc32_dp_set_dsc_config(struct stream_encoder *enc,
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
-	REG_UPDATE(DP_DSC_CNTL,	DP_DSC_MODE, dsc_mode);
+	REG_UPDATE(DP_DSC_CNTL,	DP_DSC_MODE, dsc_mode == OPTC_DSC_DISABLED ? 0 : 1);
 }
 
 /* this function read dsc related register fields to be logged later in dcn10_log_hw_state
-- 
2.37.2

