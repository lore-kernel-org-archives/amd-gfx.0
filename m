Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C335DC4167D
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 06:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48AA610E6FF;
	Wed, 13 Dec 2023 06:15:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D24A10E6FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 06:15:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ap1ND4anp+SCV8vQ3x+yb+rx6VfuerTB4CzrXoEfYVGbU30EvWt+t7fCnFPAUMcFIXfu5ZkU3SxkKKGdGIlrxVLTokch2S9WSbIJs7PBRIeL4vDunhepzuAhAm3pDJN+iMxSNHFvfUx+D5tihQhK8+bVWyvIz/z8YIqu37FzzspzgTeCUNncmyVzh6s6ZScDYJRUS6FMKztLzAdhxAIZCs6JGfzvhIAcRvVe0OWAf9Xvftl2m6mnb+In6BJYXM6FuStU4odpYZTmakWDWLUOEpA0jMCOEbe6k1LUxMEP3gJnTXnwQRTw8wpgIyd/3eyiSV1mNgp6zOvKhAdYLJCXFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNZV64JuxVGmZSMcKsNHSEA61R6UcF5DvIHdB6dRwOU=;
 b=lMqC2hkmj9/osAThUEI8jUPKo10fnkeSaGS+bqo+yl71dM2gJf6ysTa0Kyhz2+WuaiFvaE1y5JsWcLodtoNz2xWxjOv0MUKuqgqrL+tqrkSrp7IU901kUtHLhixjIwb+F/V2jm+oUyC6T7xh1Bt2WrwSMTXopUACWzzaR4dJgjnT1skZq6Sk3VMdV4qmi6EfQeKu3lIK4m19+Qis90zmZxR/q3pvKwqjmG+WIkLkWpYnGGaP+dZdRgeGI2jlu3o1VMbYwUmepBW0m27Zy4Ron5GO0JOpEwrNE/boc9X3u+BYRNQT4yYd+kp0uq9FYMkNLrw2/Nz+6efP5ije6oZP4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNZV64JuxVGmZSMcKsNHSEA61R6UcF5DvIHdB6dRwOU=;
 b=FvELUCTUb/AepSOtc6xWpOtpBFgye8yUXPckXk8HVWcBgyY6vAaM0WdnbOvea+8AVTwSkzu7eDAT6LOA5/jybMzVEkmdtFtxSeKWKJdbHZQf1LOOY5OLRRvBFF+qalrn6YMFQRmbMwgv+7NozMrUf3h1TAC3svFnn89lN+kyO20=
Received: from SJ0PR13CA0034.namprd13.prod.outlook.com (2603:10b6:a03:2c2::9)
 by DS7PR12MB5958.namprd12.prod.outlook.com (2603:10b6:8:7d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 06:15:12 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::5) by SJ0PR13CA0034.outlook.office365.com
 (2603:10b6:a03:2c2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.25 via Frontend
 Transport; Wed, 13 Dec 2023 06:15:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 06:15:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:15:10 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:15:09 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 00:15:04 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/25] drm/amd/display: Fix hang/underflow when transitioning
 to ODM4:1
Date: Wed, 13 Dec 2023 14:12:24 +0800
Message-ID: <20231213061227.1750663-23-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231213061227.1750663-1-Wayne.Lin@amd.com>
References: <20231213061227.1750663-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|DS7PR12MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: 92b70619-9ff6-4b6f-ab43-08dbfba2dd77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y9+nhAXvQtOsLqJHWP3/gGEycFCFepeleFDkkTCBooi2JumRrjwaqs3X5cQrQMMgBoGh+Sq2DQ5jr0nY5qD63la89H3TkUoB4rbPZMDg2pLeZGen2muMLn7Xh7noxGPvtWfI2yaJYAt9INcL0p8D2yARiIE9rJLESQDqNOqlmu5VmfvwfIIv6UApb4qMhI5YN0L5Kq0WCJ1kDQ/c+R8Z4jHnsnFDnlGj+Tl3x7AkQI+o1drMehM4g9lt4zBOL2Ct7nWShI8OaNYcrRv7nmajZdMkSSJRMIh1rBre9LPlvinnckzyv5uYAmFq/K49JarFzYwvoubbIMW1MGNjNLiMCu90OeRaPZAyudhlNTqC4cS02RP0Xi8SIGXnReD+hOYiNoDpDrpfmlTb2UPgwXDMAL4Lx+v1VLgBeqoUaCuhjc8pWqPEiKyqu/AAwYREKy3OUcteg3t02HYQVIwtlkTUJ7JG3iUdJKuWZ7Z7ddU3T8l/Mgvv9PKaRgOan7meiROj7ZgGLvRQlfw3VZQF44k/c/XJ0EeGlE0mpncc/JCGbUiKvZUpbeZqqoYOlSYOBZeU93Ik6HSOGSW7HrRk/Ahmi8Y8m2bTDZrZuN3zUM7pqwOgN18j+a+gF31JVTPEQrJmHMD34cDSvxMhVZJO5rPOoPR9j34okTxg+FkSoqKw2MIr5JsCP3/TXe/gbF/ArAu5OMGzUDAr+Qe4KvNqzAXKCSqyHoGJ3lqXLj6WgTx3RJXW6QAsplrqwwlkQANhBt4bZLof4D7t7HbC/3WHTTHerQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(70586007)(70206006)(6916009)(54906003)(86362001)(82740400003)(81166007)(356005)(36756003)(36860700001)(47076005)(83380400001)(426003)(2616005)(1076003)(8676002)(7696005)(2906002)(6666004)(316002)(336012)(478600001)(26005)(5660300002)(41300700001)(8936002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 06:15:12.0219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b70619-9ff6-4b6f-ab43-08dbfba2dd77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5958
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
Cc: stylon.wang@amd.com, Ilya
 Bakoulin <ilya.bakoulin@amd.com>, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya Bakoulin <ilya.bakoulin@amd.com>

[Why]
Under some circumstances, disabling an OPTC and attempting to reclaim
its OPP(s) for a different OPTC could cause a hang/underflow due to OPPs
not being properly disconnected from the disabled OPTC.

[How]
Ensure that all OPPs are unassigned from an OPTC when it gets disabled.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c | 7 +++++++
 drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
index a2c4db2cebdd..91ea0d4da06a 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
@@ -172,6 +172,13 @@ static bool optc32_disable_crtc(struct timing_generator *optc)
 	REG_UPDATE(OTG_CONTROL,
 			OTG_MASTER_EN, 0);
 
+	REG_UPDATE_5(OPTC_DATA_SOURCE_SELECT,
+			OPTC_SEG0_SRC_SEL, 0xf,
+			OPTC_SEG1_SRC_SEL, 0xf,
+			OPTC_SEG2_SRC_SEL, 0xf,
+			OPTC_SEG3_SRC_SEL, 0xf,
+			OPTC_NUM_OF_INPUT_SEGMENT, 0);
+
 	REG_UPDATE(CONTROL,
 			VTG0_ENABLE, 0);
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index a4a39f1638cf..08a59cf449ca 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -144,6 +144,13 @@ static bool optc35_disable_crtc(struct timing_generator *optc)
 	REG_UPDATE(OTG_CONTROL,
 			OTG_MASTER_EN, 0);
 
+	REG_UPDATE_5(OPTC_DATA_SOURCE_SELECT,
+			OPTC_SEG0_SRC_SEL, 0xf,
+			OPTC_SEG1_SRC_SEL, 0xf,
+			OPTC_SEG2_SRC_SEL, 0xf,
+			OPTC_SEG3_SRC_SEL, 0xf,
+			OPTC_NUM_OF_INPUT_SEGMENT, 0);
+
 	REG_UPDATE(CONTROL,
 			VTG0_ENABLE, 0);
 
-- 
2.37.3

