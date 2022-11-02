Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C21EC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF53610E4DF;
	Wed,  2 Nov 2022 16:03:20 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F28810E4DD
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 16:03:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gop2F0ABeMxtaJtIkQlZZK+TP5SSrQQvIpq7g3rrycDbKz8sCzixGSUf2DfBN7Q1tFpqHaz6O5JOHZf7sqQ9/cATIAWvLPScal4qryD8I5Yez3G5urRHwqSWHLS9l4u9uhUrH87DylVdB9TymWXezd5w9VqeayT3y1/rb2gz1oWVFTq0UXA0U5mGheZokX830dV28ELUuuPrzO5wQ1wHlgVDIY5v+1gKgrDTQ8fro0N62f6dGDW/fB9YwM7ot6H7DTNjdhpCbiIoG0ywdk6A/hMQfygri5tE66pMXR6im9iYov2nrBjPFhl/lpibNuMDoKJaN6aKoaegzzlK1wIpaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syAa+VWevorWt+auTV2R7e+gCPRZ0msILappkodoJAk=;
 b=Ek0yia4BBWIGagj3W33KjnrcoidnGbiNJftXWxOOyHNfQDxhHhAhWRzf1af72MrcCYWA+kWCaMx5LBtgztPA4v+rgxyBgI2KZV5kpN5X0esLerSiXeGQgOqnyJpWaUuSMYOWvjd3Q6QczagMAVPBc4cadJNXVuXeQibX9/ejMwDFqZV7QvAsFfOP53LGQJ4yhDms3hw9M9Uawv+szY6yse2wkAjimdHx7K5CYd1r9Lrh1zHXJDRtvJ+4DFG2qJSlGW6Q+VEkPLKXAplgzbcCcBOoMpiH3qAbkG9zx6D3cJjd7JlEh3KHtx8P9bigy7gZkVgo2AaQnoLyWOodU85gLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syAa+VWevorWt+auTV2R7e+gCPRZ0msILappkodoJAk=;
 b=F24RscgQ9t/q2zZzm/8Qdjbbw5baEKRWb+678SoSp7sqbNyFUtns8eA1pOBqHcfW+q2rsd5MrT8HxXnmUZptslj6lkGKTkAaP7h8U7xkg4i7i5e/uhkeex5dKjigcE8dve4z/qEuNivzIrI3Ga68Z2qiNdd/k2u6ydwNzujWZ2Y=
Received: from DM6PR03CA0024.namprd03.prod.outlook.com (2603:10b6:5:40::37) by
 CO6PR12MB5475.namprd12.prod.outlook.com (2603:10b6:5:354::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20; Wed, 2 Nov 2022 16:03:13 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::93) by DM6PR03CA0024.outlook.office365.com
 (2603:10b6:5:40::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20 via Frontend
 Transport; Wed, 2 Nov 2022 16:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 16:03:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:03:12 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 11:03:08 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/22] drm/amd/display: Consider dp cable id only when data is
 non zero
Date: Thu, 3 Nov 2022 00:01:00 +0800
Message-ID: <20221102160117.506511-6-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102160117.506511-1-HaoPing.Liu@amd.com>
References: <20221102160117.506511-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT022:EE_|CO6PR12MB5475:EE_
X-MS-Office365-Filtering-Correlation-Id: c754ec08-cd91-4850-4eec-08dabcebbeeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sO9nn2x31Y2MfrYlCdQ3E9XIkF2k9r51Dwjf5tK8xDYeK/J2QoxkKidd5LD0EpWXJtnDfZG4RKlA21xFiUMcF7WIU41XhomwTPyGgJhUn2viRO4wxwq5f4QcKuEX1kLelJdONuZddJaycr10g4NkN9AKGIop0hAdcYtcn2z5b5Rs0zYz59Zr7aU0cA1cjI174exJphL8rBAf/A3x8aIg6tHW4GgUQLjaXmxtoJ8N+4G8weGTE/3bPIxGlSR5I4Mlv0eF8J0vxg0o7oPVVzBwi1n2EtL9cuzSVBrE+QBqERV0eaVUZ2w38d7JWKtH54/B65mJmQig0d/72xgqnkesFCEZUbMSwz1F/kM0enShCgjDu9BCnksAisM7uZQq5Cqo7ocazNW4lRsnW1dlpaQ//OPww0LufaZVIiUPDc3dDd24/3OXZ2EemgZ+zaluzqphilFhQPwzWnWzfi5RYCzshKm/gSajdiCk+Xjofr6Rpgj8lFsyg5YfrRcFPU5ASCedyxaNNiRMySpqiyMBfmXHl7x4+YlgwN+t6vMhp6i4+CLWB9/EAh3S+JAqopXnvhrrOWpUEYR98DY6liZTCaC3az2lv1527dBo/lrLyCWkZBBiXxX+Jy2Ogv/IbovvZmXQ9SISORznVXNfx12dYI/fivPZnvCGmROudGto5LqtNazY3WwvSK6u7fgKvObVkZ1RgRGYbDM3ye6Kpvbu+vvmLpdqoXoRLtv3G/kKCMvpHqbcVQ+XtZGBDHKMQdzeZurK9jbmDlxM3YH/ClP1QzjVzhHzNKEpGIg5nOFadDR6Qmjumkih7z4aBRGVWcfXWFxZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(426003)(83380400001)(47076005)(86362001)(478600001)(6666004)(7696005)(2906002)(40480700001)(356005)(82740400003)(81166007)(36756003)(40460700003)(26005)(1076003)(336012)(36860700001)(186003)(316002)(82310400005)(2616005)(4326008)(8676002)(70586007)(70206006)(8936002)(5660300002)(41300700001)(6916009)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:03:13.1993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c754ec08-cd91-4850-4eec-08dabcebbeeb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5475
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
 George Shen <George.Shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

Cable ID is a DP2 feature to identify max certified link rate that
a cable can carry. The cable identification method requires both
cable and display hardware support. Since the specs comes late, it is
anticipated that the first round of DP2 cables and displays may not
be fully compatible to reliably return cable ID data. Therefore the
decision of our cable id policy is that if the cable can return non
zero cable id data, we will take cable's link rate capability into
account. However if we get zero data, the cable link rate capability
is considered inconclusive. In this case, we will not take cable's
capability into account to avoid of over limiting hardware capability
from users. The max overall link rate capability is still determined
after actual dp pre-training. Cable id is considered as an auxiliary
method of determining max link bandwidth capability.

Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 22 +++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 4ea3c825f228..601f78b0b08b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3020,7 +3020,7 @@ static enum dc_link_rate get_lttpr_max_link_rate(struct dc_link *link)
 
 static enum dc_link_rate get_cable_max_link_rate(struct dc_link *link)
 {
-	enum dc_link_rate cable_max_link_rate = LINK_RATE_HIGH3;
+	enum dc_link_rate cable_max_link_rate = LINK_RATE_UNKNOWN;
 
 	if (link->dpcd_caps.cable_id.bits.UHBR10_20_CAPABILITY & DP_UHBR20)
 		cable_max_link_rate = LINK_RATE_UHBR20;
@@ -3083,15 +3083,29 @@ struct dc_link_settings dp_get_max_link_cap(struct dc_link *link)
 		max_link_cap.link_spread =
 				link->reported_link_cap.link_spread;
 
-	/* Lower link settings based on cable attributes */
+	/* Lower link settings based on cable attributes
+	 * Cable ID is a DP2 feature to identify max certified link rate that
+	 * a cable can carry. The cable identification method requires both
+	 * cable and display hardware support. Since the specs comes late, it is
+	 * anticipated that the first round of DP2 cables and displays may not
+	 * be fully compatible to reliably return cable ID data. Therefore the
+	 * decision of our cable id policy is that if the cable can return non
+	 * zero cable id data, we will take cable's link rate capability into
+	 * account. However if we get zero data, the cable link rate capability
+	 * is considered inconclusive. In this case, we will not take cable's
+	 * capability into account to avoid of over limiting hardware capability
+	 * from users. The max overall link rate capability is still determined
+	 * after actual dp pre-training. Cable id is considered as an auxiliary
+	 * method of determining max link bandwidth capability.
+	 */
 	cable_max_link_rate = get_cable_max_link_rate(link);
 
 	if (!link->dc->debug.ignore_cable_id &&
+			cable_max_link_rate != LINK_RATE_UNKNOWN &&
 			cable_max_link_rate < max_link_cap.link_rate)
 		max_link_cap.link_rate = cable_max_link_rate;
 
-	/*
-	 * account for lttpr repeaters cap
+	/* account for lttpr repeaters cap
 	 * notes: repeaters do not snoop in the DPRX Capabilities addresses (3.6.3).
 	 */
 	if (dp_is_lttpr_present(link)) {
-- 
2.25.1

