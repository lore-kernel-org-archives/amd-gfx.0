Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51376C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA70564E00
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA70564E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84AA66EC30;
	Fri, 29 Jan 2021 21:28:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1E9D6EC2F
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 21:28:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrTGz7hado/ORdAU0BkfTRqh6VnT3WugO8tO8jCvQsh6RXi6gxLpxxMgWczNBMQTdMkGtJBorm+xxcqmJeJu0kcvgN7rsDJ9L/L9/zA74CsM4RBmtJLfPglPC3ova8mKEF4oRax9hCSO2ZdARWsMLICr693+LuoLAce/OVNlEuFpNw8qDjjT8A+VirpxRmZKut0yrDUQA4dmoa7d8Xqb8sIypzjyqV9KSUEJPu/WrnVis7cQ+OT2AsKSTKNHnrUyroXcpNh5wC0xRPJqDy9PYbdfwcKKM8rygrZnl1AbzLO/WhiIRC1yRVp15YoDz6JjMWguCdJvwpJ2mMbaL1tN2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clJs+vBaVfMzrA8MtVqQe2sherGU2DHPmaPOY4v91xQ=;
 b=ca5r98/julvb9IjoSX6YcsT9vnmBeMj/HTPyj9kQvXnmEdePoCwINvaFp5WptWnNsV3RKbf0yHTqBYbUE/xPAaB+fi8mbkwPq8S0eT/MgH9LeaK6wpEuwkiGXfJzK9JZKICdDYS4tNSFQ7DYl4kwYWfkjf6UYOFUph4XyyZ584IF3g82xJ4UheDc0nhPL3gVsvBiEKu+gcrDOeHNgTikz1LQIG2T2bgnEs6y0kn8Mgrvi0IjSQoLFwO2r7ECud8q3Xr4S6GF1TGeHTttD4r6bMWRaPV8aa9KxbyDAoOODu3Q74MreHOkRvD81oTmG9keLHAnd4BYXUX2E+8/Yhu4Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clJs+vBaVfMzrA8MtVqQe2sherGU2DHPmaPOY4v91xQ=;
 b=W+I6YKGcozHTbjEYhYN50jdBh5RhVyBBtj3gg0IQecQ5X25JzvcGmofnMMe3qmJPSWl88kI+sKRSMxggMwnE1XPftYYlsPefAXEIDS+76Ia8bsBoYTf23gHvy9ooK76MFXUs1y+FF2QVChG/S8qlQCvdqkEAFUuH64wCOknf8Z4=
Received: from MW4PR03CA0250.namprd03.prod.outlook.com (2603:10b6:303:b4::15)
 by DM6PR12MB2940.namprd12.prod.outlook.com (2603:10b6:5:15f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Fri, 29 Jan
 2021 21:28:28 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::9b) by MW4PR03CA0250.outlook.office365.com
 (2603:10b6:303:b4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Fri, 29 Jan 2021 21:28:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 21:28:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:26 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:26 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 29 Jan 2021 15:28:25 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/27] drm/amd/display: Workaround for some legacy DP-VGA
 dongles
Date: Fri, 29 Jan 2021 16:27:48 -0500
Message-ID: <20210129212752.38865-24-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129212752.38865-1-Anson.Jacob@amd.com>
References: <20210129212752.38865-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3f74036-411c-4190-f82a-08d8c49cd12d
X-MS-TrafficTypeDiagnostic: DM6PR12MB2940:
X-Microsoft-Antispam-PRVS: <DM6PR12MB29401C627F8BB824EEAA76A4EBB99@DM6PR12MB2940.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7fi1Z+h2aCuCNqhBr0eZouZMUkTLcsGhfsScRtxI4l1I6CiIbJslfYdHrofeX7rgXKoqvfjuMbIDTNdA/MvuefTV77SDfektkB8wptsFsUJl6TjFax9Go4twTyVNk3kO596f77dMqDaMWmGGffT2f47feaehqtbXhQbIm9ZmxhU+m0QtxeAzyittrfIqV09zWB/wBNnIpc4KiOFspH9dMAa6CbR5ku6ZBt/MvGFVNCw6RI7jJNijUNXv4Rmd7dqHE+Rts6d7F1ePuiG8HaJblFdnQqHSGjO2s8TQUFL8rp1+V1IqvxVkxOvbgIWMHt2faY9OQFusIMkR+ILvJz8Gyxb7O6OfqWVzXLUTTSA9R2xJgUFCmhAHqDjUwLxpRe84rbkd856szQJfsn4YRNI+JxCmZ2snNXqk/l6zotxAHO7N2K/T3Vfy5bBFOYERKMs8aDNFYzdlnitcUOn0lugvv5bXOifZeMJHXtVCFy2Inw3CUaYlTOx0JhSzI7wIAqEdpx7EJYhJ/Uz84wE/ueK+vfB4KWh/kHAk+pwtM4hWrGDyvKJ7ifg0WAZWFweeM/QhS2JJ68ulUjBvFvcOor67ZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966006)(81166007)(336012)(47076005)(2906002)(316002)(426003)(6666004)(86362001)(478600001)(1076003)(8936002)(83380400001)(8676002)(36756003)(70586007)(356005)(70206006)(26005)(82310400003)(54906003)(5660300002)(82740400003)(2616005)(7696005)(6916009)(186003)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 21:28:27.4689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f74036-411c-4190-f82a-08d8c49cd12d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2940
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Taimur Hassan <syed.hassan@amd.com>, Wenjing Liu <Wenjing.Liu@amd.com>,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <syed.hassan@amd.com>

[Why]
Maximum resolution is 1440*900 when connecting to FHD monitor via some DP-VGA
dongles. The display EDID reading fails over AUX/I2C via DP->VGA dongle, and
this leads to the maximum resolution 1920*1080 cannot be obtained from EDID.

[How]
Provide a workaround for some legacy DP-VGA dongles with a longer aux delay.

Signed-off-by: Taimur Hassan <syed.hassan@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index 26f3d5dd0453..ae6484ab567b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -39,12 +39,14 @@
 
 #define DC_LOGGER_INIT(logger)
 
-/*DP to Dual link DVI converter*/
+static const uint8_t DP_VGA_DONGLE_BRANCH_DEV_NAME[] = "DpVga";
+/* DP to Dual link DVI converter */
 static const uint8_t DP_DVI_CONVERTER_ID_4[] = "m2DVIa";
 static const uint8_t DP_DVI_CONVERTER_ID_5[] = "3393N2";
 
 #define AUX_POWER_UP_WA_DELAY 500
 #define I2C_OVER_AUX_DEFER_WA_DELAY 70
+#define DPVGA_DONGLE_AUX_DEFER_WA_DELAY 40
 #define I2C_OVER_AUX_DEFER_WA_DELAY_1MS 1
 
 /* CV smart dongle slave address for retrieving supported HDTV modes*/
@@ -292,6 +294,15 @@ static uint32_t defer_delay_converter_wa(
 {
 	struct dc_link *link = ddc->link;
 
+	if (link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_VGA_CONVERTER &&
+		link->dpcd_caps.branch_dev_id == DP_BRANCH_DEVICE_ID_0080E1 &&
+		!memcmp(link->dpcd_caps.branch_dev_name,
+		    DP_VGA_DONGLE_BRANCH_DEV_NAME,
+			sizeof(link->dpcd_caps.branch_dev_name)))
+
+		return defer_delay > DPVGA_DONGLE_AUX_DEFER_WA_DELAY ?
+			defer_delay : DPVGA_DONGLE_AUX_DEFER_WA_DELAY;
+
 	if (link->dpcd_caps.branch_dev_id == DP_BRANCH_DEVICE_ID_0080E1 &&
 	    !memcmp(link->dpcd_caps.branch_dev_name,
 		    DP_DVI_CONVERTER_ID_4,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
