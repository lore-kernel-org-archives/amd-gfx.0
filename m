Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E40CC7618B
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Mar 2023 07:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3D4E10E309;
	Sat, 18 Mar 2023 07:57:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D995B10E309
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Mar 2023 07:57:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmLJf/LU47Bq/xtxWrmrFTODZMlajTAJSeLpDWIb66mSObQvpsbJGrrOKNfQtpQ2x657LQRYOln6kNvD3MpubNbzVKg2VONVCe4ODcxbEliw2K0xrg+b1BdibxAmBaTMcsCFjePylwaY2ucwlhtWdEjOa5JAjLzHQEsKhpv/lIpW/TB9bETfS0ovHzpDDrSUZ/MRjPjKrb6MT6WTmy3rByZoL2iv43OwDXNX57hrPTl9glsMmUKLSMQqQFtEqlRAOA5lo45IVpIQalMmuwvijq3Ds8G7OvJcghXfi8NOW0MBY0SS+M0KYEu2b5XHIXkr3GV/scX98IAaK2AhzOR0gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7ODG3H7P9jmvt3O6yQ0pm1H7+/bUujyxH130Sxmhw8=;
 b=hrrgu1iNLu6z1cLspMJ5NxlfJ0kIHlWkoY3xI3JIBV+dEGY4gmB85KZU0xjtaIycTxssLfYpd/4Jx2++OoU+cQcTsRzckwn55P4sz9hKqHOdNIZrFToiIlpmc7XncgctFNmGFATMDv2IGJ48k5zj7FdEflo/eTSce0NBI7nfDXxT3uxr54QJ2AtqVLQueVvF+tdkC/HvYkIFmQH0ndkW5jJBVU9ZqM3VqG0hfoo3EId09UfxDy6Q3Boo30uESMjI3bfp8ZsLAG/gMn9Qgr5MBi2yS7qa6G+k7sefBG8rADP/YEjJn208YPh1zMB00eZ6734ydqxJKlOZRY0E+2Bf2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7ODG3H7P9jmvt3O6yQ0pm1H7+/bUujyxH130Sxmhw8=;
 b=m6Q90oG2s0NeXniiO81G4Lg3hpp1Z8N9KOHt0sSNd9YgrDVfoyU+jHki5d6vtDcw9zzcvHmbbtq6YWeJEi3Y6ejfyfvmX+a1DRL4nD++IXyddDLAHkYwTKugVijM+OmL+Ea1+eO8qkxaOxYWxM3sEMGaItT883J5vcXq2IEnQEc=
Received: from BN9PR03CA0512.namprd03.prod.outlook.com (2603:10b6:408:131::7)
 by CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sat, 18 Mar
 2023 07:57:11 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::57) by BN9PR03CA0512.outlook.office365.com
 (2603:10b6:408:131::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36 via Frontend
 Transport; Sat, 18 Mar 2023 07:57:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.10 via Frontend Transport; Sat, 18 Mar 2023 07:57:11 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 18 Mar
 2023 02:57:06 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/19] drm/amd/display: power down eDP if eDP not present
Date: Sat, 18 Mar 2023 03:56:03 -0400
Message-ID: <20230318075615.2630-8-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230318075615.2630-1-qingqing.zhuo@amd.com>
References: <20230318075615.2630-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|CH3PR12MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: d61cb28e-29d4-4b4e-8f7f-08db2786612e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mq69J0KzncCO9sPyBt1FShGO2ONkcMTPxCAE/khKUkyYQcghkvNInSTfbY660tyzWOtPjFfL71+RcxGaKOB1MtHrrQqco/KzduBCsbRvaX2k5lP9v8t2H3OCZvCJEi32dUrBW0lc3t/FxJAaHNb8mmwOSQ6/p+vLtzveugsaXg4v4B45fA7dVHvC04b48A+WhQ3LwxmFERHe57xMNJ4ohRsIpzCv3vvei4moUARv9wXTS5pkLduOZrTs4dGaJO5MYPnmup5pAwhZmmPlkttIaQTNWlYoIwlrqa2aNFE1xeYHhJtIE6Tu+Mxqi5UONulWA0jwf8851l8M1d9u84MiunYqnQRY8c7UuGBmrBnE+IVIOqymK3x/fY+v+VkfE6HVYAckNvGAjHb5mheZNO8tOh2uLD1NkcTAfEgNmUv/L4DlzCldZ34990n1M0J35Y7/rwKAOL6pQo9HBLLimj7ZbgRMvG73NHabRjk9pxREcXwpqLasLL0DKisfPhjMyVK7DO8UnskY6NHHBQyEh8ofyyQe6demMorAzYRe/1GsZbt22UOAL5b5g0cU4V18XKPaSLp42PKkTn1l7Nq5ecQtjQawmryLlrXI7Q1X7pPfXrh9iKIdONJqdh5iEWzVS4M1ZymGlSgvL9tmUoha1TLE3t0zPL2VRsrZa3+cQ4gqobcDfPlXny37PPIDfI/eTaj1F/Sodu0WZblZl1J3tTYMJ+AGRKz5ceOiXILCIm8JroA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(40460700003)(86362001)(356005)(316002)(36756003)(41300700001)(6916009)(4326008)(44832011)(8676002)(8936002)(5660300002)(54906003)(478600001)(70586007)(70206006)(82310400005)(2906002)(36860700001)(83380400001)(40480700001)(82740400003)(81166007)(26005)(6666004)(1076003)(186003)(426003)(47076005)(16526019)(336012)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 07:57:11.2130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d61cb28e-29d4-4b4e-8f7f-08db2786612e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8659
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
 Wenjing Liu <Wenjing.Liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Paul Hsieh <Paul.Hsieh@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Paul Hsieh <Paul.Hsieh@amd.com>

[Why]
When init, driver will power up eDP to check eDP
present or not. If eDP not present, driver doesn't
power off eDP VDD cause power consumption.

[How]
If eDP is not present when detection, power off eDP
VDD.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Paul Hsieh <Paul.Hsieh@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_detection.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index fee71ebdfc73..57cf6fa0de7a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1225,6 +1225,11 @@ bool link_detect_connection_type(struct dc_link *link, enum dc_connection_type *
 		/* TODO: need to do the actual detection */
 	} else {
 		*type = dc_connection_none;
+		if (link->connector_signal == SIGNAL_TYPE_EDP) {
+			/* eDP is not connected, power down it */
+			if (!link->dc->config.edp_no_power_sequencing)
+				link->dc->hwss.edp_power_control(link, false);
+		}
 	}
 
 	return true;
-- 
2.34.1

