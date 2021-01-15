Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7AEC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:30:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A579C20643
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A579C20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 170F689381;
	Fri, 15 Jan 2021 17:30:17 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B7E289381
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 17:30:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPq7AWnt4mJcbc4e7+PLxsUgune2S6f7AaeARTnI2QaZbLtP1DVKlLqLeXf5Asd29WteKhs91uOZs1/Gh1YAbDZ/9CrWv07Y6iUPjB06EiWhOOKRMOvQXj9znedA9lv4m/ZA6F16E8a+jE00xXxyCu5ZPvNdv6mpvVcDVtYxULPh/Ps+qYoht1klTWEi7DrLaiahm0Dldr1MaTsabb7WlUz++hJuww8FOtLNdGf9XhlobxaN2k+b1gSHupgDFitrqgfK6wSFnrna+PuWW3Hc+PXi+T+zRX67GhMM0zQO1qD4PhG4m8H0JzqWz5JF5u2KXWek11SgkwCd1DSS1yhglA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E95O/6dIbpJ4PcYriq9qPB8HZ2gY/llByBj8z0CCGTI=;
 b=ax46IWbMODZ60AacdOblXaPHwGZVv8ETzpJsG6Rtl9WRmO+C5akGcI4WfgdkIoYB9xoEyhq3uKBk7m+eD1HOz/0tgaCatwnaXMgL0Wndf1n+OQwLAaZmbpD3cBRBaGPlMSJtfqZo6iY4CYu4cC/SNNGzYZcATWh2/mXH/Me9h+HT7NmXKvBnaJCJjvUv6+qGXO1erddPS3QKkeZ/EMpFno6fjK6CKjLI65bKdK6kFH6tb1VufVJ/qwQ51xbTmfpfK/B0xZOdhEIVgDoSMcVW6K2MmV3karQzB0lUoIRfhn4sxGHxTzR+78pyFcZyYa0TzHkN03Qi2Eq1U1eh2mY0/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E95O/6dIbpJ4PcYriq9qPB8HZ2gY/llByBj8z0CCGTI=;
 b=vTnVlBzrY2iK4xcJgKYM1MgpcM8sA1WqUuPkrVLaY0hoLb2wDpWs1jkNK5hqUqgSFb6w5o7vc28dmKC+ETB0BOgyD7yh5lPkYVxd7SrQhZsSkFRBTrfcXU0xjkjk7WmbWcm+MXqMmcosPj/K6SmPugEntHzumsdO0wS2vP0RRRE=
Received: from DM5PR2001CA0004.namprd20.prod.outlook.com (2603:10b6:4:16::14)
 by BY5PR12MB3924.namprd12.prod.outlook.com (2603:10b6:a03:1af::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Fri, 15 Jan
 2021 17:30:13 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::ec) by DM5PR2001CA0004.outlook.office365.com
 (2603:10b6:4:16::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend
 Transport; Fri, 15 Jan 2021 17:30:13 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Fri, 15 Jan 2021 17:30:11 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 11:30:08 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 11:30:08 -0600
Received: from ajacob-ThinkPad-X250.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 15 Jan 2021 11:30:02 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/16] drm/amd/display: disable FEC while using eDP
Date: Fri, 15 Jan 2021 12:27:03 -0500
Message-ID: <20210115172714.126866-3-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115172714.126866-1-Anson.Jacob@amd.com>
References: <20210115172714.126866-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08c9d0e4-4b44-45da-d138-08d8b97b3623
X-MS-TrafficTypeDiagnostic: BY5PR12MB3924:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3924FA389520F30CB7B64CE0EBA70@BY5PR12MB3924.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PrflJAaCBtAiRrjOKFmKAUKltAS3QyZQMnofRCGsMtoO8NBiJVJ2jmfk8TJlVLJH5PmQ+eSnwiXrLZaLklDDLW+kOOfCprj3Q6Mzs+O4bA9wW65R057WdVwvSiXK6CThPwwvV1kmo3nQxOQgu7Vvx4eZOWS4hxGwXgPSJrVDomxlloiJSVvoakG/ZDOG6XrG/Z7A3G6sR0v+geEEgVfRHF4Febs39OEwDoWc/wWtG+Sn20vWpr99csslJl84l405MXON/Oib45XSFdPuZlUVm8aPR8qsvfl3Ow0EelXASsaJgU4zewKCMOYVjrC799KFdSuj20lolxD4e9yBupV8oKCvnnI17f6pL6ayB5wD/aQtqRWa1Z7D7xAOs7OgLClAndU1+GlaiunDDwWBaUv/oOxrPoAshIp2QhAL5VaRZ+7Q+WnI0n5BOI+XHJdCbzF1Qpx8oGBJm0AA7ny9Kyrps3Dz86qLVaeHroWK/ccKz7M31LRvOWgsl3Juv6cuancL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966006)(83380400001)(54906003)(6916009)(26005)(47076005)(86362001)(186003)(7696005)(36756003)(478600001)(5660300002)(82310400003)(8936002)(4326008)(426003)(1076003)(336012)(316002)(2906002)(8676002)(356005)(81166007)(70206006)(70586007)(82740400003)(2616005)(34020700004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 17:30:11.2428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c9d0e4-4b44-45da-d138-08d8b97b3623
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3924
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
 Nikola Cornij <Nikola.Cornij@amd.com>, Anson Jacob <anson.jacob@amd.com>,
 Aurabindo.Pillai@amd.com, Mike Hsieh <chun-wei.hsieh@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mike Hsieh <chun-wei.hsieh@amd.com>

[Why]
FEC over eDP support is incomplete.

[How]
Disable FEC over eDP.

Signed-off-by: Mike Hsieh <chun-wei.hsieh@amd.com>
Reviewed-by: Nikola Cornij <Nikola.Cornij@amd.com>
Acked-by: Anson Jacob <anson.jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 4f58a5c43548..c7d6ceb8fed8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3700,9 +3700,10 @@ bool dc_link_should_enable_fec(const struct dc_link *link)
 	bool is_fec_disable = false;
 	bool ret = false;
 
-	if (link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT_MST &&
+	if ((link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT_MST &&
 			link->local_sink &&
-			link->local_sink->edid_caps.panel_patch.disable_fec)
+			link->local_sink->edid_caps.panel_patch.disable_fec) ||
+			link->connector_signal == SIGNAL_TYPE_EDP) // Disable FEC for eDP
 		is_fec_disable = true;
 
 	if (dc_link_is_fec_supported(link) && !link->dc->debug.disable_fec && !is_fec_disable)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
