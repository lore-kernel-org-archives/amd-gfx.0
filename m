Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858FA109E540
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BCEE10E939;
	Thu, 26 Mar 2026 03:01:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SB5pwCVe";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012008.outbound.protection.outlook.com [52.101.48.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7311B10E938
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:01:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUX85sRJuQARGyO7DycfEbz6lTAZx03jEfCh3Ptu3K9dipckZ6wXCQUcmyw+RLfEpn9LCjdBrW09O6+o4s4tdOtCVmePiSrim+lwX1v0kxK9EYGl1IemoYq+b8OREDdhuwt5M6m/5W/M6rrj/ODJIDJseBvdhj5bG6D52HbTOXuRjQpQAU8gF8vk7v3dJjytYvgo9MlB0ZJmXZnHEoz4ECXyoUshDj8Wd2ouNLsDBo/d2Z61RHE2yLd9ttziF6dyMb1jW2fwqfBl6rKPLpoXL5YrTZvfX2M+yqSzkcafgBkuzQYJH0DniNmmulX1b6Ihmdul9aYzou5puDgW79ZoNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9lxaO06EAltrr+hC7aZpjat76cT2d4+orPK6jrMP8Y=;
 b=WVxsU9rv83vnXv3HDUxp6ZoviwRtESUmF4ceaqwBf8zzfb6A0zod+2mHAWaD0lvlDGMt5E8fF2VPqAJiOmHyYnK6Akz2sH2BQsqpWj/uKAhKB30oCiaDAz7+qSoli7TgrefvotTn/fZ9z5WYxAXJjqUPbW5m+XA7GHHgd1zBQwrr3/3z3KkUYej1ZZpwdI87j1/hYikTRYGdk0Y1pPYxCInGp43N9EQ5ZkhQyl2l6+XLu1K6iiUnkLMJUmV5qppdvXnFrpekmTe66nO8IihcoIBOGOlHWmbU3vrR6vj2Rsb9hkJxAAtHw8FaNMVedzFscmz2vsQWmplPl9RnTnAEZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9lxaO06EAltrr+hC7aZpjat76cT2d4+orPK6jrMP8Y=;
 b=SB5pwCVeRq4WdUhqjcjy76Xt2ou19EuidiwclU4FL9feueDyeWTjB0HALT0KpO3jRPeA86DI8VU69yZ6FQd3JIt7QiYoGEAAPpMSBG0+dj5i7UiYMAbw+sgWxSTvgiD3I6y9QdKce79hAqsOx36xdyjSCzeGOnI3OJZ2WL3hzHc=
Received: from BL1PR13CA0174.namprd13.prod.outlook.com (2603:10b6:208:2bd::29)
 by SA3PR12MB9200.namprd12.prod.outlook.com (2603:10b6:806:39c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 03:01:27 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::69) by BL1PR13CA0174.outlook.office365.com
 (2603:10b6:208:2bd::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.20 via Frontend Transport; Thu,
 26 Mar 2026 03:01:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:01:26 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:01:22 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, Leo Chen
 <leo.chen@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH v2 15/30] drm/amd/dc: Disable PSR & Replay CRTC disable by
 default
Date: Thu, 26 Mar 2026 10:57:06 +0800
Message-ID: <20260326030153.406612-16-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SA3PR12MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: 18527a14-e208-454c-ad2c-08de8ae3f8ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: m5ywA6PGU85jXgfrNRKJhYVdAEWTZ9Om8P8eQSSrNEEH0jHX2JXJqzZLb3Wv+rzNGO1EzaZ+cnhy1ZGk3zSRMQ6IxcGSFsdWoGyoVDibGpRuzCXk/c3sCtjGHddGIhDoIePO/DqG4/LtJI9d4Hz+olAHvvYYYkZYYEzAgK01Q9MrTCyqKu7cCGPYK7QPiBPgbR8hdkKGcjikQeffEo+52qksAjhWyyXk5SlVQRfXcV//mktJej9+Tv0iwbHPvmElYif9rwuril24ECIfId2HaTz8opaa57war53or545eLp1Vv2Ski+mvSWDdf57TCh1FOJ+fvmg4f0C9+Yxjx5gd4VDQfK8YW8/wMn00Y0aiXsVLnA31qcWryPR8Iwd5Xbm2ByWLCcTgVlEid0ZhClR2rt7XNbddK6NOBpU6OMQYjPxN/kbcOrWiNC/wCnogHD4samL594dZMvC6lhaaEFPSb6KdxWCfFl1ZDBFxbORuOLBC6bPXc6tAOcV5idC8hSuMArRhD/PMKfHU8DujuSJ9KjAS8jhGhnwrBwcPhYvw9On68ThJqQSBHKLJFQj4DpeASZu2O/SMsPkrMmFeuSDytfhIj86OKDIcoPrv5gfl4iMMwln35+wj6N3zRtuEhj1vPkkD8Q5oI/b0eSAVjYc95dpX36il46a6DQUY5bmpNmzx0j7jJpx2uKTmA07zQoulXVZooi/cMzjx4KlY+8MVODhkCDFjrTs4h2TwIpJPVjVqeiuND/AmgW8WEuL6UxhKxpVRUvgbih7biCTKvXc1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ouitXlK+y73CWA+EGHq8fJCSyDnyT6vweCpD/BVeZfelpx1azJ6w/qoPURh3ukSng/YAoWxjq9ZOWT7l8tiZbsN24ipDNQlI7qotxNVH//Wvz95MrPbbx4BIwr2nd1V+h9W4I+8hHgGpt18L9DVLr/Q+GcOFVRr3SIb1qCpL27we4PaTIEscBYLwozrJd9zbtE9StLZQU/S782cEcE0cD6cVLVnLyNGHsWk42zrgCGeBObpn66bePqQEmKzYGzK8motqZYRLyeVV9LA/fS6eR/1DdFekr+Z066DvT9CKXI08ZFzpWY7JJk88tTsonWhmVse/mheRB3FedgDdkvYD5YU41slyuuWZ+sxdAzzY82bj8EmL+ZjXrnazCbxil8JG2AJZapRBe1y5zgRi+a1hzeXTGy2TH1Pi05hW9hEDzAEF+N52ZAcRZ/8ugP46P1kZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:01:26.8012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18527a14-e208-454c-ad2c-08de8ae3f8ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9200
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[why & how]
Let IPS FSM handle OTG disable.

Reviewed-by: Leo Chen <leo.chen@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index 11b302c4d06f..f2a6e260f061 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -761,6 +761,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.ignore_pg = true,
 	.disable_stutter_for_wm_program = true,
 	.min_deep_sleep_dcfclk_khz = 8000,
+	.replay_skip_crtc_disabled = true,
+	.psr_skip_crtc_disable = true,
 };
 
 static const struct dc_check_config config_defaults = {
-- 
2.43.0

