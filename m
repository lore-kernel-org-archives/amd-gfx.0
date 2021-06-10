Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36569C48BDF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09EE361263
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09EE361263
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FABA6ED9B;
	Thu, 10 Jun 2021 16:29:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA4516ED9D
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 16:29:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjNxq98ViG82YES0pdTdghryVjrVdRtmXKTMNs834amP4D4OKy1LVhiHteVE1cEF4HAYSSbU6cn4y4ndq0mgtV/lZpAye/d8xb/81t7dTDli+5rrYD6i/nSdO5csa1kD4BR8hTFJsZg5aURhIZFNxysH9RTdr8I82sEsVhIW0FwpMi5AsZmZnLME1X9hGiYs+KuBIEj+bp1hfah9VfYbue5BAQDhlUeqtSIu3QMyaddUPB2mk2Sr/lVRkLqZhGJH3hQHGV8ziPD2xrtgxfGMK8LOol3bfx1Rdv3NcztVFfMR654hFhY783xq/5ZlrXoZxFhcfw8qYkhUAsiSs8HXOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOx3xHnyAoJ87hoYDYEgs2lHm2iLIw6Q4fC9HfIp1Yo=;
 b=HFNNUBgQitJQgtAM2ScMwHKj5hoJv9kSUsIn514m8/YjxBfL2doRq8DHSSKSYUdJnF5rjwGmpe3Eq29tdMf4pjoWbEegpaoBNRho5AJKPTltlBMbf9tqS4SOEUYUvjMsGL0uG+crhFU+ftGPoZjnE7YebHyJdWU6EQQBTW+Aerupx5EIl6W50qCNSGgGF/Bez8t68cGsV/lZI/WeRQXJKiTUavGqL3wE/0RnzV30tSPrNDCnCZy3Xnrc+tDwpUHia89985tlDv2io6qVOgWAH1ZRAJDTlmhjWnEH4RQMhVCKUSrWzCR9R2Ca4hA8I4I0iGPKQ2gXhZBLFFsflSUaJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOx3xHnyAoJ87hoYDYEgs2lHm2iLIw6Q4fC9HfIp1Yo=;
 b=RK1EBKYWuEHwGMe6lIysQbw+W8y9wgSWadZmLZNSWOiUClw2z/AXWUxhD3XOvAK5FLcxmq2c9UYGROE+/fevThoPtMWyiD3Be9sHZ+6d6nFS78WM9+/37N0OeGm70QCLzeXsuZHIsp3uy3hbxA6oG+tpKhqaN1ISsYCgXb9eGLQ=
Received: from MWHPR15CA0059.namprd15.prod.outlook.com (2603:10b6:301:4c::21)
 by CY4PR12MB1781.namprd12.prod.outlook.com (2603:10b6:903:122::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 16:29:46 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::91) by MWHPR15CA0059.outlook.office365.com
 (2603:10b6:301:4c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22 via Frontend
 Transport; Thu, 10 Jun 2021 16:29:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 16:29:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:44 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 10 Jun 2021 11:29:43 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/24] drm/amd/display: Extend AUX timeout for DP initial reads
Date: Thu, 10 Jun 2021 12:28:38 -0400
Message-ID: <20210610162838.287723-25-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610162838.287723-1-Anson.Jacob@amd.com>
References: <20210610162838.287723-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14a43257-f3f0-4850-7184-08d92c2cf554
X-MS-TrafficTypeDiagnostic: CY4PR12MB1781:
X-Microsoft-Antispam-PRVS: <CY4PR12MB178138574683C93A0BB94C18EB359@CY4PR12MB1781.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+2+l6ogWRcrJdytqWb967E8wYPASeiL8s58mTPA2VaSbiJthVYnJ3vBY2DzTCQVvPwEdzXbbBtBGwkuKOV5umczt4g+xPK/vCL8oz2v2bBK9/tz8aCb7p48JoT6fBkIwCG1ApyYVjjMxzRNW/9GHt2IGQWaY5nm6OMmLlxLFOaWIPXvwgKMujaduLvIdbWOI6hkWu7n52rv0TbnWoDYMEtPmXorTY8VBf1sET5gC28DdSSxQ4Hg7UoY/J8Qf9s9XXUELQDBI4vMc/IPuja1Hak7yU1XnT6dw+VzFY5ensMPLjW8dwg6GjvI3YboZhfD/e4NqbkXmCBEOYhABCwm1LDCNizpOhs2H3UAC4zLGyuB/KUI0Qb3el8nLZLY8Q3DapN794ikP3nVcml2dDwPlhvr0ENxFe4QtR3CMPNu5x+KAlqfNBAZl0DGuf5i9a0QGL/AZi1vkQHvwYxOivW4wn8KD3UYhvNeNRIOPMD4c0u/peCv8oYeKou+vIVrzswvIctZQh6DdyreV0Teyu0U/bLJPzBb8lw3M+el0sFo0jK3y1mpU72Ia0x0jRygizur83EKNh/P8uNL/0wjfLhU6iwl9P34iP3XlWgsvgFaXnOjtD37M961cLH7XWmuB9YRuSprqp9OWxXQmIyhNS3UGfSDLwOBXdBUTnKGKgs3Fo/GLj0KrqeFsoCI2JfiENHO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(36840700001)(46966006)(36860700001)(81166007)(6916009)(4326008)(8676002)(36756003)(86362001)(54906003)(6666004)(82740400003)(82310400003)(8936002)(426003)(356005)(478600001)(316002)(47076005)(1076003)(2616005)(70206006)(186003)(83380400001)(7696005)(2906002)(70586007)(26005)(336012)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 16:29:45.4151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a43257-f3f0-4850-7184-08d92c2cf554
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1781
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
DP LL Compliance tests require that the first DPCD transactions after a
hotplug have a timeout interval of 3.2 ms.  In cases where LTTPR is
disabled, this means that the first reads from DP_SET_POWER and DP_DPCD_REV must have an extended
timeout.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 1b28b4a40f62..5ecbe525b676 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3750,9 +3750,6 @@ static bool retrieve_link_cap(struct dc_link *link)
 			LINK_AUX_DEFAULT_LTTPR_TIMEOUT_PERIOD);
 
 	is_lttpr_present = dp_retrieve_lttpr_cap(link);
-	if (!is_lttpr_present)
-		dc_link_aux_try_to_configure_timeout(link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
-
 
 	status = core_link_read_dpcd(link, DP_SET_POWER,
 			&dpcd_power_state, sizeof(dpcd_power_state));
@@ -3781,12 +3778,14 @@ static bool retrieve_link_cap(struct dc_link *link)
 			break;
 	}
 
-
 	if (status != DC_OK) {
 		dm_error("%s: Read receiver caps dpcd data failed.\n", __func__);
 		return false;
 	}
 
+	if (!is_lttpr_present)
+		dc_link_aux_try_to_configure_timeout(link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
+
 	{
 		union training_aux_rd_interval aux_rd_interval;
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
