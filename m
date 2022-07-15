Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60E7CCA482
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:38:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E2D210F867;
	Sat, 16 Jul 2022 14:35:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 448BE10E1EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:18:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yr/f7Q/mIqGHKW8MB+LusPou3IYhbjUhDZK+RDxIf4Jfy5mJhsjdtiV/ZnCbzTExgIwJ/mcHbe2fo6qmzl4x4CwyPcFkhCo4LNsfPWD/IbVYA7qisDmRCHH+6FVi28lytlpOyPYiovo+i+fdd40sWpcuLqfuaBlFM5v5sR6dma14JNYvKl3CGVhR5dhZKek0hc+y0Y68sL1tv715tkTM6Qrf2xn5oD1gbc4hpobxDvhNpXPwWbLTzr2/COb1NxlZDvv41rLVnb5xcgbOKITfvJTyR8zTC2BXEwmNLS+Mvd1OaNRL9Te9Auh1Li0SCPr89fmZrRPIgX3sduNunCfgnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4/hwiftX48BrYbJTqxTwKD6kk/SjnyDr7erT8JRt04=;
 b=Uih1TA5/3Oj2flmUU/nNlnCr0mlTnWEhH8CIAf8XhsbSJKdZuhTddH1T+xELlthB1+2OM1vWNb1aBI+vUxFP5W8gW27KBfyFNFJkTiDDCTW0zvUX3xJ/Qpt0Cj8s20OJAzL5T43oH9t/PUnrZnctpV4J1y4K/yhXbPhr+y2BTLCmG9dRFyMl7hAwFY/EWNTv+emkxO8kOdB1zg95et+C4bU058AG3bgqbUOsSN8z4oCnIWjujwoEXG7iE2hVUKMEPRAY8EG7vwCsMGuWFbqEcXdjR0T8Pw+xlBJ7HLkD0e/MbPKW0mLtDTq002tVZW7MEUJtZHEXDI3mLyAhBWsZ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4/hwiftX48BrYbJTqxTwKD6kk/SjnyDr7erT8JRt04=;
 b=iBssBVcoJT+kmD/Nonp/9q+bfQhK7LsOZ/zf41WYebeyU1biWQCjszEVH6s3PJpJ/jeYpxT/CB2uvTGW8Wwq1zH+vPTCAV0QXvdlDL4kS1dHJixF3zDhrK9DgzR7BKWw/cj/pHJduTtf70fP+CS88nZG4UMgR41Lj38TpW8746Y=
Received: from MW4PR04CA0273.namprd04.prod.outlook.com (2603:10b6:303:89::8)
 by BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Fri, 15 Jul
 2022 18:17:58 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::10) by MW4PR04CA0273.outlook.office365.com
 (2603:10b6:303:89::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15 via Frontend
 Transport; Fri, 15 Jul 2022 18:17:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:57 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:56 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:56 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/31] drm/amd/display: Drop FPU flags from dcn32 Makefile
Date: Fri, 15 Jul 2022 14:17:02 -0400
Message-ID: <20220715181705.1030401-29-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0837760a-9937-451c-8cd1-08da668e5885
X-MS-TrafficTypeDiagnostic: BL1PR12MB5301:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2H09q+NftmWaCqag4MwWKK8xY5o6wDnAVM28EOzmU87hTMa3xay5DX7+oVfZe824T+mfAz2AvfsDFO7r8egKbpWfuJDLSYYayhvw/DIzMmjkAqPdZk8MyHrlPhwnKL7hGSawWgMnzasE8M7gQkYHCH59yIPCkw+BYgKVDSjYGjAkRgbTSLsWEeJQwCPU72CUI/RwmgrJ4f+nccw8cg7E9ej1cxAFYp6P2pUTYaAhuE6kQeav8p90NOXx44xBWKlo5tY9KcH+0KL0LfeZ/7juJq53yiMNskJXAd3Ong1TsRDJv/JRX2L7JhrjgHh0X7uCmXnBhwdx61qA0q5AAGSfd+fJTgRQ7KKCMbHyouA33Q96LioVD5GL9uOh1AiFpDwexq3z6gdNwu6phxOqWrqgtkADqcPlNyLQP7nPloQpEJOtgHaK4m58mwRTGUTH3hCtQyqakj9Y0SiM7HovqPBvpCdKZSoHruowNtd/Pt7xV9/ZVxIFpN3MvGpPu2XqEOxDs5qtJK1T+p1UkL0ec+wZFnyRUGV9WV1nGZm0/vESULvlCsAhvsCMYA+kyRrKpd+BBeit+qkykZt9PhGbzOUwhS61hrX/TjkReBN+Famg8EzOakk0d4NLAIRJjAiEB3SdzP7rQhX72IGotc45iL1rn9ATqYtX7sftX8IBgDex6r3F+GIcf+uedYDwyY45MqmRFiGQ8py1juAlfpsmc4WplFEQy66XjTpAeup7l4moHX+frNg3srUXvF3WsjRhZudfLAU4fBym+0iBO0xrf42Pj79hWbGqpYEVQyF62rHV3RBT3AQ1kCkFCLZEEpB8FqnQsZcDpkb5tZG9gZrM6baDzlVzPstSSw5e2l3O/QEZt18=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(136003)(346002)(376002)(40470700004)(46966006)(36840700001)(82310400005)(2906002)(36860700001)(5660300002)(47076005)(40480700001)(36756003)(26005)(40460700003)(8936002)(83380400001)(336012)(86362001)(81166007)(4326008)(478600001)(70206006)(8676002)(186003)(54906003)(82740400003)(1076003)(70586007)(316002)(6916009)(2616005)(41300700001)(426003)(6666004)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:58.1008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0837760a-9937-451c-8cd1-08da668e5885
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5301
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is the final commit from the FPU isolation for DCN32 and for this
reason we can finally remove flags related to FPU.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile | 28 -------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
index 932d85fa4262..e943b643ab6b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
@@ -15,34 +15,6 @@ DCN32 = dcn32_resource.o dcn32_hubbub.o dcn32_hwseq.o dcn32_init.o \
 		dcn32_dio_stream_encoder.o dcn32_dio_link_encoder.o dcn32_hpo_dp_link_encoder.o \
 		dcn32_resource_helpers.o dcn32_mpc.o
 
-ifdef CONFIG_X86
-dcn32_ccflags := -mhard-float -msse
-endif
-
-ifdef CONFIG_PPC64
-dcn32_ccflags := -mhard-float -maltivec
-endif
-
-ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
-IS_OLD_GCC = 1
-endif
-endif
-
-ifdef CONFIG_X86
-ifdef IS_OLD_GCC
-# Stack alignment mismatch, proceed with caution.
-# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
-# (8B stack alignment).
-dcn32_ccflags += -mpreferred-stack-boundary=4
-else
-dcn32_ccflags += -msse2
-endif
-endif
-
-CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource_helpers.o := $(dcn32_ccflags)
-CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o := $(dcn32_ccflags)
-
 AMD_DAL_DCN32 = $(addprefix $(AMDDALPATH)/dc/dcn32/,$(DCN32))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DCN32)
-- 
2.37.0

