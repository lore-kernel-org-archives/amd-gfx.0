Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763BDC79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:43:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D1AD10EB7B;
	Tue,  8 Sep 2026 11:43:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XrAEOFZQ";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57D2810EB90
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:43:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6UkbWYOjd4KpHpJ4MQM4wk7R54i1I91Br9gsRkVsyMFyWyucuYibkWkxNwOINm3FCuspFDcVfxozMTZdXRgQeS2vRwb+tuWhFX+XZtw6EfmdJx6Pox2Q2LPNyJGXGjoTntq8aRvZANozDOOoAK7fDO+VwGbceoYTn9Uw5TcbFTXUda2TIjUFeXyINEf+HhS3YSnj0hkfGWGZDALVyvoJUeX6BGYuE5NG8mKvl2LA7bwMoUNUiPCe7M8OrNqFn9NpspFnY2mPyIepnEJXc1WMQBrH0+ZC0qsrxQS+Zd6UwIhEFiKzMvXXczEPa7KHLuixjZn0V8nWRNLYXTSG9iGLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amNRdbT0iPuc8vsmEOxc9dTInd/kzJ7RKOetQDyFRQ8=;
 b=xpvQSNAj7XQmWfEJopshre5mgzDeGhfmb4wOd/ZDdJ+IP9rEjoo3YtI/zHPXxKnn12RJFzkoR6XzcBzkhTHRAwpUhsMU0kwBflX5U1Wn/KSOBIWgc2HdHPdTF4EBzXDYYgaDlBdZEPxwuwZsQxYHCl694Bcrb21fubrGlngvYYrYAqy1wE4qPNmAtMvqdaTqO0l/wKHjfDeK+bPfzra4dU/nlGannfmdq5Ne+yzEbKNyTcYoALs0bAW5bJIgBNxoXUhHR/eEZ8RJBYjBZcnryIPmlox8L3FqYfmftYrIS/JiI/S9e3Wqegl8vpIY3zz+8mHjeBaRj9aLVdHD2dU8KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amNRdbT0iPuc8vsmEOxc9dTInd/kzJ7RKOetQDyFRQ8=;
 b=XrAEOFZQz1ePtqZ1d+LbaGf+QbNTB8siUELhb0qRnYVzMhpbcZZq6Thrhc7+ddvd5rgJH9ciKUVArS0noBCLNRPxFgGPTmhrOyfV/5oJfA0tlcf3Qq4WgFW2zC9LzbB4T0Ea9oo5h1q+cmSHiQbe49IwPcmtOLwO7/G8l2n+urQ=
Received: from BN9PR03CA0204.namprd03.prod.outlook.com (2603:10b6:408:f9::29)
 by IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 11:43:35 +0000
Received: from BN7PEPF000000A3.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::66) by BN9PR03CA0204.outlook.office365.com
 (2603:10b6:408:f9::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:43:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A3.mail.protection.outlook.com (10.167.248.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:43:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:43:23 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:43:23 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:43:14 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ilya Bakoulin <Ilya.Bakoulin@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 61/66] drm/amd/display: Fix HDMI FRL audio enable
Date: Tue, 8 Sep 2026 19:31:54 +0800
Message-ID: <20260908113338.2433445-62-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A3:EE_|IA0PR12MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: 42248878-5575-4f94-1c2e-08df0d9e6a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|6133799003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: pG+5E2wg+l0gohdH4JTMcCW22rpCkwSZ7vIZGv7H+XliKpFI5eUVh3asrzZi4keM8D6qmIVNiKqpZPDyGP5lVHjRG/Wk3erqsgT0oteVKFl67/fBiMGhy9dCkA5iOSF105WZCqSVxDNw/jiT4Kqrdd+KfBNELvwCDTLGgtsa7zbZqN48Gl5ceTDnexLi2Fm7WGIQeVzZTZreEe8ruO/5C+u3iqXaUMq8AlNxfvQrAsWf903MGlu4RgbnLTno6vmWLzQlK6494V/NW+491/vLHcuPP2IQ0VzvqeGZU4pvnNXlAVE5TmC7lWALhYR7Wpopx5G/4IXrgCCT5JBgVX4zMVWaze+hADAVR5k19fpl+usZrCDf1VsU+kSQufG16R+ijUl6F6CAJ6VvGydfoleP04jFfA67vR1m6sM909yiQFq0sjLz6rDSAMZZAWM2huQAWPOG38XzVJJOA4ZmwtPe4DpZWbuyPc2jyrA12UnE619HIyNEBOf4MHr4k1jEJwRkraTAA1yqS6iEYTJ8NoEwD8Ce5ltEEZ29+s8MijMEY42cjlnbT8vDcMuLLvkag8P91uL6V32K6WrHqcj23tP6+BlPbOY1Fc+Qlj4Adn1kLdgR1VPqbTGSKVJc9mPYe9vPLxT3YaxKAMxjnRZ1dCLV+9QhoCnmNmFw9Yz0pi2na8pVUYxaX48/Xein4uWj6G6ZB7YZTL0TyTlMksr9ofiK+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ISR2RPCvcbhu22mwKrfNQe0zChNJYwnYhN2ojEIJ8kM+bzagWus01HV8amea4YZ6V8fVrZJodePvx3Zxf/YnnoIAlNXHl5bqxYIxRGDdUl0v/Nt78RIzKd47UTWcqVa676zELVY9nQZ2KLTFWzOSbBhzmrMOzKxjecwg0MaUiSVZICqOrJI+mG7woYxEkcoj0zgll1J1EmNBFSv/sSzJPSmksfqsuZ2QMmJf+Mur/6aS1FlwpIz0fyo0damJfgBI+rAWSYhkhrAfqYD+U1+Wmrm4YiUeWUmgJxi0zyMSMp6HuB41aeswdJM5Mm2zw1NzKRuhXQWYYbQeeghOFpAvRbTne0pornZ7eXj23K8KI19Zq+O5chJrjA0BT8OnkPwiLXyKNFq+7R1cbmXrF7NH/TtjZkFHcG/QkuuLlilIzJCShAUZl+Zv9sSAJzbU+6Ss
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:43:35.4189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42248878-5575-4f94-1c2e-08df0d9e6a9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7722
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

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why/How]
The APG_CLOCK_EN bit can stay at 0 in some cases when going between
DPMS off and DPMS on.

Add APG_CLOCK_EN to audio_mute_control functions to make sure it gets
programmed.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c  | 9 +++++++--
 .../display/dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.c  | 9 +++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c
index d4f66e62c729..43870d84ca2f 100644
--- a/drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c
@@ -159,11 +159,16 @@ void hpo_enc42_audio_mute_control(
 	struct hpo_frl_stream_encoder *enc,
 	bool mute)
 {
+	struct dcn401_hpo_frl_stream_encoder *enc401 = DCN401_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
 	ASSERT (enc->apg);
-	if (mute)
+
+	if (mute) {
 		enc->apg->funcs->disable_apg(enc->apg);
-	else
+		REG_UPDATE(HDMI_STREAM_ENC_AUDIO_CONTROL, HDMI_STREAM_ENC_APG_CLOCK_EN, 0);
+	} else {
+		REG_UPDATE(HDMI_STREAM_ENC_AUDIO_CONTROL, HDMI_STREAM_ENC_APG_CLOCK_EN, 1);
 		enc->apg->funcs->enable_apg(enc->apg);
+	}
 }
 
 static const struct hpo_frl_stream_encoder_funcs dcn42_str_enc_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.c
index bded65896ef5..b5397d6760b1 100644
--- a/drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.c
@@ -36,11 +36,16 @@ static void hpo_enc60_audio_mute_control(
 	struct hpo_frl_stream_encoder *enc,
 	bool mute)
 {
+	struct dcn401_hpo_frl_stream_encoder *enc401 = DCN401_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
 	ASSERT (enc->apg);
-	if (mute)
+
+	if (mute) {
 		enc->apg->funcs->disable_apg(enc->apg);
-	else
+		REG_UPDATE(HDMI_STREAM_ENC_AUDIO_CONTROL, HDMI_STREAM_ENC_APG_CLOCK_EN, 0);
+	} else {
+		REG_UPDATE(HDMI_STREAM_ENC_AUDIO_CONTROL, HDMI_STREAM_ENC_APG_CLOCK_EN, 1);
 		enc->apg->funcs->enable_apg(enc->apg);
+	}
 }
 
 //Covered both, rounding up or rounding down from FRL Link Rate /18.
-- 
2.43.0

