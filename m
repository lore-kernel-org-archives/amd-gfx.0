Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F39CC6B03
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57EA810F781;
	Tue, 13 Oct 2026 11:19:45 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011036.outbound.protection.outlook.com [52.101.57.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B40C10F790
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:19:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZljWLoNRgnCOYf59EydBf9pIPHoIi1VRp8P9XQqevb+8mGEzCbQbxbcJ/xQ7Lq662CIN8HsAJy/hJuYBEhXWSIBI+scL/JvYF9Nyf3H2fUZFy2tuPwhta4p+EkV0Rde5JKFV94O1Xp+I5UTDxg4HsF3f928+NIxGywb2u830bWYDCb6xwcb+VB7vGFB0K9mHyNEq8O7QxeaQhOWhIQAr2QyxBUh9PgOq/clpoLLaW+HVXn7ZrbnNImRoBKODz28+4hUFAS2BcgIjpxBZINX+8B2uCw698S8x5ST5ERrgNoXn+qy20rXGxaGI7sc4VzR/x1fKc23CZuHtREwHY9/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9inOgS43U1E0aFjTyZDhrdVXpHxp8s4GzD2sTbxMFA=;
 b=fNZvSvQAwJ7UF6GaM5+ySbX1o8+07BzFp27ZoR7snT891kNGqI2XHM40I4UiD0d0kjkViOUPN4XEhkA28FRTKsGl218nZbvsAxDBqfGu51LFlVhs/kbRW8I9i+pSg35Y0vruVy1tzpxosuncjrMYUcQ1Vwt4Cm/ypLbQbl7qu0g5QmWcI5yDORt28gy/DDb8T9DBPT5Hp1yO3PlwlbQVsfyMcRCYAzYr1z9K24y58bYoclWTjd3WOB3SmvFr3N4JMoM2AvMUGqXCMusSJueNCW2UbfiJ7jK94ohOZ6KpWahmllA4z3cYrP/dfDgLK2rqW+B8+zCINE/TSYBNvRjPRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9inOgS43U1E0aFjTyZDhrdVXpHxp8s4GzD2sTbxMFA=;
 b=xTNv5jyj5tI2cf5bWRlbTXMrstKG3P/6FLQvUyeDT9JfFilOSstNOLPFe5u8ATUGt1I4rZrz4Gd8KCh7b013HwRYFdqIU1mA4Bbo1aPZIVchuClA/yyiEU6C2Z1/iCtyYwzAvbyzsOu69VI891kD1chVdlyi+XPh8k7/8tyaUzM=
Received: from CH2PR02CA0025.namprd02.prod.outlook.com (2603:10b6:610:4e::35)
 by CH3PR12MB9025.namprd12.prod.outlook.com (2603:10b6:610:129::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Tue, 13 Oct
 2026 11:19:33 +0000
Received: from DM3PEPF000265C6.namprd03.prod.outlook.com
 (2603:10b6:610:4e:cafe::61) by CH2PR02CA0025.outlook.office365.com
 (2603:10b6:610:4e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 11:19:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265C6.mail.protection.outlook.com (10.167.23.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:19:33 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:19:27 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:19:18 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Relja Vojvodic
 <relja.vojvodic@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 23/30] drm/amd/display: set VRR_EN for inactive state
Date: Tue, 13 Oct 2026 19:08:10 +0800
Message-ID: <20261013111616.2267344-24-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C6:EE_|CH3PR12MB9025:EE_
X-MS-Office365-Filtering-Correlation-Id: f86d9bb8-2c27-4561-79e5-08df291bdbd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|3023799007|22082099003|18002099003|56012099006|11063799006|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: p9gR1cZpF8oAOxWQbItw3sg8PLOvrGZAFjx3OSe49HEmToP/43Jo9P1o9XHM33XrD4Efp4zI4v8+lSmwm4FNWwrvzDWfBGGwN2LhCsl0Oq9SF9F3YcMMwkwvhUYjfF/mNWNhbvylQLBaZYkSYQ5rOEZv7pLXXEEgfyY0vGN9ccn9mQx7gxae2inCyuyt+iU1yM4WwKUDBpad9YwrhWboigkND1AsVYacUzvG87Uf/A07HzeNd2LiopkNEcRQVXrnXY6K49gi6J9XoMqVVW/T/nIGImdnGs9KyhUyFdY4lss3MjAZTGcf5LZGpNpBAH3wBsc25P+v2w3ehwQBpIZZGStzc9HzaMT2tmohWvup7DaH0/Odh5CaEV4/W9r1gZfvZf3bUZuc3cd4zsIskNRQD9Eyfvdwtbo3sheHuTjKEmGq8H6jVl0YKm9K4A4XakWP7Kd9SmLNpaJauYRvHPtK5K6jPfDo5vgBRlyzseWcEU7Dd5qnJbfy6gU0BMDMxopzn2PJSq/UqNszBuIsPuV8GN70im3KkLpXOgApb4TLjGYcrJ3KzGDUNSfyxBMcUeht0GKNa+es+7d4zW+bwFQvzmZIr4LKuwoF8yVGKKkFXTiUgwyM8ZBttuTgDqTIzcZqL1rnrdp3AdhVHC2PJGbeY1IszTvm4BLhVm/kI1rz9yeeDTGYQm+Wzv55KYYel/bW24/C9qBazH1iTBhbZb1KMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +CGc3eEnAycucU9eFX2PNW5piO8CXhVo4TTD/NoAywFDfDvph7NlCesG2lO31NYSX8n+o9lrKnF+zki1xj5fqO28GdhRIkcjf+UC+9cN8V/zUAoo9zsMqH+zNZYCAnDi/Anwj0vAhvncMgRQIdSi8tgq+wkSeBs+3OEIL7EOX5lf71/jDjpJ/t7tSCTJud3xUDHJ3zlgENhBUYoOrbXUHBFbJQ1dmwW3c1f/diln2bdgwPmZylEXAdt8k80WIpINczSAmOOMssH5f8Jzcbt85okl0QvWa2Omc3nlKX6pMDyD+a9EmEqkhfECxtjhRoNYdutcM+siaZbxaHDzlpL2rY2u/x2Am5z/GVgob3ZfJ837/aBZdCd8sU9nEnMhMrxLR0Ap1Kg+ktZnZ52Q4rcFopX0Z7uX1k7nA+bsbdBe85SJ+lcMlzsqFDmQmRFB7xlQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:19:33.7982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f86d9bb8-2c27-4561-79e5-08df291bdbd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9025
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

From: Dillon Varone <Dillon.Varone@amd.com>

[Why & How]
Same as freesync, when VRR state is inactive, set VRR_EN=1 so sinks
react accordingly when VRR abruptly becomes active.

Reviewed-by: Relja Vojvodic <relja.vojvodic@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 48d0e164e62b..8dd9cec6aefb 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -669,8 +669,8 @@ static void build_vtem_infopacket_data(const struct dc_stream_state *stream,
 	set_field_with_mask(&infopacket->sb[VTEM_MD0], MASK_VTEM_MD0__FVA_FACTOR_M1,
 			(fva_factor > 0) ? (fva_factor - 1) : 0);
 	/* VRR Parameters */
-	if (vrr->state == VRR_STATE_ACTIVE_VARIABLE ||
-	    vrr->state == VRR_STATE_ACTIVE_FIXED) {
+	if (vrr->state != VRR_STATE_DISABLED &&
+			vrr->state != VRR_STATE_UNSUPPORTED) {
 		set_field_with_mask(&infopacket->sb[VTEM_MD0], MASK_VTEM_MD0__VRR_EN, 1);
 	} else {
 		set_field_with_mask(&infopacket->sb[VTEM_MD0], MASK_VTEM_MD0__VRR_EN, 0);
-- 
2.43.0

