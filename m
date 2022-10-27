Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDC2ECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 18:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7402810E049;
	Thu, 27 Oct 2022 18:39:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39AE210E6C7
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 18:39:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHcVReLp043Eha5yZHLQ4i+/cmtX9QociXhJvGNtA1ska5ffH336Gd8rjqZGEKJeEb7ab9ZpofUUU1XopfUljnZGif4kiI5inlIzQFpZ++15Km0Co5/K3PWbIK0EU8K+X6IMHUbI6A2yQH3dTyeEUFT2tb4vJIsvQT2ieUpwz55m6VxMohXw8/KWOiY4C5ln+UA4jYPzUpZzGLKsY7otp76QkQ66Xup8Q52fsN6+jch9rgfxQVklVG9iGaahKu6kmudgI5bUiww+1Odq1Az4EzaEyLScs7f15dLrLROfaT3GCK6IF0xRK21aljGaQay4wLpOdyuqwatsS1gxGWbj5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SseEBnQJWKlWluMGPUcdel+UYTWM59IgFja/3MGSx5Q=;
 b=hUtOhjMoqKdQpuV+mRyHbhJFstNXcNmEmQ5ceS4UjWtQOD0MUM9D9su4vRogfZOc9rzNz4Hq4oakFg8hPWf7zG6yOwXD3p+5SxYhjNgOyUe61M09ffsL5LwWbh1zGEh6ShJFutXUhlmVdt1NH03TSwVUQQmweTkCyAfuv2kHV7TgSQL0D5ueuWcD+o8heNvWQsRVsRLMVyiJ7BTfnvQEq1J480Mn6C3NZ03Z5HXP3QSHLjkm9r2S0zg0PLJP+cpiOZj9RMMdZa3y443YCaYqNSniXm/RCzIr7NK5h7s6u3R4vWupMt6DgjPustmTEJV9mlIr4pRBE1WeBmIvL54caA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SseEBnQJWKlWluMGPUcdel+UYTWM59IgFja/3MGSx5Q=;
 b=HCEDfZE3CuX/q7dPJ0gkezurTjcSprezSHaT71VjBbvdD7zYiwtqWy+F+3kaaGZod66pIJFqeZ8KquNLd2VH2iU40eFb7WldNEqNtX+8pfnlIEHiKipnIBfuFwBx5LqBiY1USccxrokgYY9ZTNU/77Sa9vfpT54u9YHqDJbwVdg=
Received: from BN0PR04CA0200.namprd04.prod.outlook.com (2603:10b6:408:e9::25)
 by DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Thu, 27 Oct
 2022 18:39:24 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::e0) by BN0PR04CA0200.outlook.office365.com
 (2603:10b6:408:e9::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Thu, 27 Oct 2022 18:39:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 27 Oct 2022 18:39:23 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 13:39:21 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/18] drm/amd/display: Don't enable ODM + MPO
Date: Thu, 27 Oct 2022 12:35:28 -0600
Message-ID: <20221027183543.1117976-4-alex.hung@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221027183543.1117976-1-alex.hung@amd.com>
References: <20221027183543.1117976-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT011:EE_|DS7PR12MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: a620c2a1-bbd7-4238-d506-08dab84a91c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5wNbXp8RaG65909x5ZXbUORspoLGeEwL0xkw/hlzx12VkWg4LBAMnXbl5DTls6LFm/TRQgFzixfxcQW8kSgAOiuZb0IyKxvhP/qud1dfiECYnvXiRPloJLu1AwrxgkJnrp7oBmN2zUmy8sfCQFzqjxwTX703W5cOtQSyIYT2tNja2yX/ysKpqKul4wsLG/e7qoUhgphW8g7fRa2DKHFUF6qpeLgLtQUdqJ/IIrI22JWykdMF+cEuLjCXJtlSi+MpUd9SZ5lHQzKkVNWUWHyBkH+HHjCHB9R56hBIYsDIxb/BDm/7rZrgLOGezDa8G4vl07zasWWSsrVHWVohq5VLOB1Tm/ZKWaAObTytMOd7kHsLZJIAXOsngBbTrbl43L+81DlpN2n1tEKhY8w6aamxR+S9AH5BX9xV0Iflet0f5uxVFH/YjlN0VxfZa/NNs5s+35qRlGPPts5KtVBMfaJXdxh/rE1bUbHNunT25Jx4IF/nXRVLw+S1Ln6JWkJqN4/AZzamfoUM2vQG7YsYInbshhP/De3IPS1ySJGt2AB19mGk77feWeTZ1JexD40N9APG3O2GInHA9Yrujel7wEExdgQLHYIv+FuphfSMNT8JG4wflkXGU+dAiYSXi620cV5p+2d7qYBm0ZMVqBGXoyNoxiwK1pEHbGIkKlhuVXE5wiVyBsP5Dt6cO2PZZQu5k4n6p8puHONM2Oz/ebdMsHoNL7GF7zM6WpDggWgIYLec5wdOHXYYPowgzo8L6Ti10oXNBmzNeGcDGVXnTyY0vzcHOfQnDAW1JD9it+19SiKthtplTu5LdVOZqeO6at6YJSX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(54906003)(186003)(1076003)(16526019)(81166007)(8936002)(83380400001)(4326008)(5660300002)(36860700001)(47076005)(336012)(44832011)(356005)(6916009)(426003)(2616005)(82740400003)(41300700001)(2906002)(86362001)(40460700003)(8676002)(40480700001)(316002)(70586007)(26005)(70206006)(7696005)(82310400005)(478600001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 18:39:23.8892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a620c2a1-bbd7-4238-d506-08dab84a91c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6070
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
Driver doesn't support ODM + MPO

Reviewed-by: Dillon Varone <Dillon.Varone@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index aeb4822cebc8..5e0018efe055 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -989,10 +989,6 @@ void dcn32_init_hw(struct dc *dc)
 		dc_dmub_srv_query_caps_cmd(dc->ctx->dmub_srv->dmub);
 		dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
 	}
-
-	/* Enable support for ODM and windowed MPO if policy flag is set */
-	if (dc->debug.enable_single_display_2to1_odm_policy)
-		dc->config.enable_windowed_mpo_odm = true;
 }
 
 static int calc_mpc_flow_ctrl_cnt(const struct dc_stream_state *stream,
-- 
2.38.1

