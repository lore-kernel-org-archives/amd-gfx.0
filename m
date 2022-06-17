Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D72C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D945410F3BC;
	Fri, 17 Jun 2022 19:35:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACF0310F383
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:35:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEh9v7RmB4mrunO7ufB9etp/czvZaC7YLvdiowjHm6ic1+s5sTUYoyCct3wMvo/hlRsEvHrl9GGDtcUZ65bM16YoresxtP3vglb9rFpDzMWRavG3YlFjaIB7PZIurjmfh+yR9RhxVGC9U/5b7kpunwp38KvJf69HmBtv5xuW0ziQhlwUrb1WRdozUezuXPN0wWeVfK9Gh1IxbN3NAOQyezQkgPsntObMeFMcye/4KExR6e7uv67kv/LWvPhCFV17W929MRsiwnc/upouN1iw8rmvjCX9CGUkRsnTtEItDhnE2kRZ6yZXEO9kWPYFvxOYHQEZs0o74vOaYdF9yfhKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+u09/mjqBzbudjla+9efOoCpDQs6nM/u/HH9TxKkj6A=;
 b=N5iUr6NoEf+kYuz2qkSA168q4Rdst04jZci07V1o6W0pX/ruSO93V2dLpnumaOhKwIPgOWrUIehafy5IconVGotAy4RpA6Xh78EUHPXkod+yjfCOhZT2BZ18yXrsP4Ga/Rn5+UwxYCuha0vJScnv1Wy1s7LI/xisxXHeBpSc/urAhVsOxHRo45GToXTFDWWtAG+cKT+cZPnuSkZiuvyX7BFLVAJIHGbo5TrmI7DEt4futOMpzxnUO7Qk7Ej6xdPIkQVozj2sgYBSE3miwFlm9H7LHgjdTiyN6e27ZZ5awQowykB8rqIekiqmUba+wCwVpsDGVh8dTP+MW8MYf/me6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+u09/mjqBzbudjla+9efOoCpDQs6nM/u/HH9TxKkj6A=;
 b=aQhZaxOpAG0ef3yNKgdGxTM9k8hqBt0Y+HyTvq271EdhgoqNDeaFStCCpF9yZpuJZ3013+AKUPS7xtC777oQGbizMj1djtTf4TOmMPr1LeYo0gJy2JymsMMm0lFJEcI46XswvKzahkS5G8e+hju3FJgUKyKe2hbVIO36GyYXEcw=
Received: from BN9PR03CA0134.namprd03.prod.outlook.com (2603:10b6:408:fe::19)
 by DM6PR12MB3804.namprd12.prod.outlook.com (2603:10b6:5:1cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Fri, 17 Jun
 2022 19:35:51 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::af) by BN9PR03CA0134.outlook.office365.com
 (2603:10b6:408:fe::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15 via Frontend
 Transport; Fri, 17 Jun 2022 19:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:35:51 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:35:49 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/31] drm/amd/display: Fix in overriding DP drive settings
Date: Fri, 17 Jun 2022 15:34:55 -0400
Message-ID: <20220617193512.3471076-15-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42865509-fde9-401a-854d-08da50989626
X-MS-TrafficTypeDiagnostic: DM6PR12MB3804:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB38044FBF1FE9622E5C684C5498AF9@DM6PR12MB3804.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FcJqrmjmnMyEsF7pFg4PRY5/+09XkIObG8uttLNMGYFcZDXlQ6ohhtRNe2lFSKLdVzVBzd7z2E9sNhFg9c3P+A7XBHssZ/XekzFQWPUOfzWTaDHHynO2HxNVHGwBof69amTz6rqmPz+mpdQGWp/trd4YYubRuFjFM+/evlYq5PH4Tqo/zaB2v3yjVP4/Z4/2T/fK7fIB/bjFdyK5L8MOiiZ8J+VKJa+Pm2a6E9YUcBepaBpX2aqR3lKPejI6tUl103PGpSZbS+MULMUrKTxKIKIZYVri0gpOchjcz1hnKUw/STr7OghpX2/ffqypanyO4pMhxceGF4YV12v+TJkNSLIJQBX+EA3Y9YRgUaOQcFsQsm3hIr6NlrS+Sma33kpK6Ht3/7uwxe7+IMbBIYfSZQVc6xEqm80hJuusUm6/L4VJtCvPozkYDBTKOvL8qor104mIv160MfzBTq3SVn9t0YG3jX8JDj9Mq0/clmFHsVgHkrRZZggAG8E/8Bj4AVd4YvZ+Q3fJbEHrDMBslJ5LzGzi7D6CZnc8Vcn5cZYRziMshFY/lbcPl1/lr04yVeGrnR36cJ3uOGe0FdO/D6uuvoalILcvft6LpMnKWSGr4rl6ZOr3YphzvfG9R0PE7QPus9uH3GUGUM4mM8Hy2D/ZRDcEYbiS9E3TAMp092sJGq/7JAoPAr2eTuqoFKo/IicK0ybMrIujN7uNbZIWhfStEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(6916009)(7696005)(82310400005)(8936002)(81166007)(83380400001)(70206006)(86362001)(36756003)(2616005)(54906003)(8676002)(316002)(2906002)(498600001)(70586007)(426003)(16526019)(5660300002)(40460700003)(6666004)(4326008)(26005)(336012)(186003)(356005)(1076003)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:35:51.0079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42865509-fde9-401a-854d-08da50989626
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3804
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <george.shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why & How]
Check always_match_dpcd_with_hw_lane_settings bit before
overriding the DP drive settings

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index ef771471aa39..9f873d2cdcad 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1674,8 +1674,9 @@ static void override_training_settings(
 			: POST_CURSOR2_DISABLED;
 	}
 
-	dp_hw_to_dpcd_lane_settings(lt_settings,
-			lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
+	if (lt_settings->always_match_dpcd_with_hw_lane_settings)
+		dp_hw_to_dpcd_lane_settings(lt_settings,
+				lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 
 	/* Initialize training timings */
 	if (overrides->cr_pattern_time != NULL)
-- 
2.25.1

