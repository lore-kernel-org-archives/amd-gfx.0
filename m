Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B317C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 188C864EEC
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188C864EEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5B276F508;
	Fri,  5 Feb 2021 22:03:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B50B26F508
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Feb 2021 22:03:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tw0tU0VKy9xOXS2txLXQDD3/3PJ6ctNQ3ReRD8RGiKjr31oECkahUisI2sinDgTH3OsV0XRaItpRF4EpGIdq16Ldaxqt48YTcEfoIsrrXB4WPCCgSrXQvWgPsaAYI6qdCMX+WhPmoGVJh0rm2/A0zTrsYjORa4d4L/aQBxKBsKNOyfgxvzooGorPHrKGBdXLhw2lhlW6s+2Z/RN9179XybeVwdiUSQwzMPcKQhXJyMBrPF9V4FPw19QD//etwd3LHSQQA64SCcpY2TVt6sFsG/L9od9kt8SyqKkwW8nn0K9EOewqJq3EWhp5m/rd1GVw+y6IB4fd7IGg7E060QkukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RLcoIPRQOFjDi3On0PYsc2V5JN6y1pbDhuZ8HPbY20=;
 b=UfRvzIXMTf5lGKosrVU87jdLWR6S2JtfxPkbSSQZaN/pDX3pDWN+47yQmF4AAAaROHI2E6ziOj6vaTXRkajPmGOWsA8KU3+9I33Zeydbh0bDNLHtNedpbwuYuOL1HvGP4Iu7CaIGiL2ItzOPCICmwag6UidiuAwhlgYUclReRYEMmTBYb45wISvIlgPtES4pycgpfXxFTCdlL9Ps/YAkmrii3XwPmZgbB3fZm/o7ERtkSlewLbEBzINluXHtlBKRWmhndJOD+o1LeoL1xuFZu1eBw9fbhC6zdb4uPl2wto035R+DbGXaJwE6EC54+xSTEDjYmFbby18CZhDrbhjKPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RLcoIPRQOFjDi3On0PYsc2V5JN6y1pbDhuZ8HPbY20=;
 b=4BVpvBvvliHdkUVOGJmAqFrtOSrZHhr0nYFYRuR8YitEXH2xgM8Go5iIM+Aj/VrWmT76Y1PpHo/Y/M9VCLl4HxVUt+9vsfkcW+Zet61D7npq5ouknpXIRN0SskcOESjeiEK69b5dK+P4e4q7iwq7s6iI/sW5NkTS8ekL3UixH6Q=
Received: from MWHPR2001CA0013.namprd20.prod.outlook.com
 (2603:10b6:301:15::23) by MN2PR12MB3903.namprd12.prod.outlook.com
 (2603:10b6:208:15a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.24; Fri, 5 Feb
 2021 22:03:13 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::c3) by MWHPR2001CA0013.outlook.office365.com
 (2603:10b6:301:15::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend
 Transport; Fri, 5 Feb 2021 22:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 5 Feb 2021 22:03:11 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 5 Feb 2021
 16:03:09 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 5 Feb 2021 16:03:09 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/11] drm/amd/display: move edp sink present detection to hw
 init
Date: Fri, 5 Feb 2021 17:02:44 -0500
Message-ID: <20210205220250.1871069-6-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210205220250.1871069-1-Anson.Jacob@amd.com>
References: <20210205220250.1871069-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06cd87af-6f5c-470a-55ab-08d8ca21d44a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3903:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3903827C13B0F4ABEA8562BEEBB29@MN2PR12MB3903.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:439;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVxb4Mj9rxaWrbKJyBa3HdHytjMyo3Z68LTYAAfeZbgzKHiVv70moFFFjZMkH4LhKICYlJm6xSvZXReOmTl11564/yFHKupyszDiXdWvDBwgLijxr7DyIMiPHu1rocxSag50A5coZcsJbdJ6cKO89o+YRbYaPICWW23vhkwEwO71u8hXyAUNFAKwKRiyCq047IkOY7iQE3w+ut9f3/FgYh1ueyD0cjPDCEpDbOXMMkgo3Pu/lOjnWAA4du9uazqjfabB6jCHFN+uRULQ7BPietF03bWFdTTEgn4c9rP71ZuYJiyPVR5FqazqB1AD4Ra6OxYa/eKVssYp1sjafw4Xh0faU5kXAxqfOa3AWBYlPCD89rKrThSWGF3ZMDf2d85Vx2Zk8/iGAa3ss00Sajp89IPczwFKXnzYqyuYGXazjn/XGL9Xb+fNv95fDr/oT9oxT7cKGbpAfwNjZfE87tynPNfw4ccDSW1HXhW7I/C02SiLtKGfwVT+6dp6WX5BVB6vq2O9juqdXHHyTRextEY2Va8lguliPcGxd15+eSzcf8BiGC7eGpX9FM9efLrcvbSdzXaPTB0ra4uFCOr2cE/9cQ8hVfnBtbj2npWELYwEbw9Mko6nNBF6qCvYheXv7s30MzLmVdbWv8z2Pf0pn0KfYSclYkvlnUbfaDhn3xap0/iu2NZ2FLD2GqthPPT5hzaw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(36840700001)(46966006)(86362001)(6916009)(1076003)(81166007)(4326008)(5660300002)(316002)(54906003)(47076005)(82740400003)(356005)(36860700001)(83380400001)(82310400003)(7696005)(70206006)(478600001)(70586007)(36756003)(8676002)(8936002)(186003)(426003)(336012)(6666004)(26005)(2906002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 22:03:11.5668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06cd87af-6f5c-470a-55ab-08d8ca21d44a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3903
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
Cc: Eric Yang <Eric.Yang2@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Yang <Eric.Yang2@amd.com>

[Why]
At SW init, we may not be ready to do detect eDP sink.

Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 40 +++++++++++++-----------
 drivers/gpu/drm/amd/display/dc/dc_link.h |  2 ++
 2 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8d5378f53243..c9aede2f783d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -205,27 +205,9 @@ static bool create_links(
 		link = link_create(&link_init_params);
 
 		if (link) {
-			bool should_destory_link = false;
-
-			if (link->connector_signal == SIGNAL_TYPE_EDP) {
-				if (dc->config.edp_not_connected) {
-					if (!IS_DIAG_DC(dc->ctx->dce_environment))
-						should_destory_link = true;
-				} else {
-					enum dc_connection_type type;
-					dc_link_detect_sink(link, &type);
-					if (type == dc_connection_none)
-						should_destory_link = true;
-				}
-			}
-
-			if (dc->config.force_enum_edp || !should_destory_link) {
 				dc->links[dc->link_count] = link;
 				link->dc = dc;
 				++dc->link_count;
-			} else {
-				link_destroy(&link);
-			}
 		}
 	}
 
@@ -1016,8 +998,30 @@ struct dc *dc_create(const struct dc_init_data *init_params)
 	return NULL;
 }
 
+static void detect_edp_presence(struct dc *dc)
+{
+	struct dc_link *edp_link = get_edp_link(dc);
+	bool edp_sink_present = true;
+
+	if (!edp_link)
+		return;
+
+	if (dc->config.edp_not_connected) {
+			edp_sink_present = false;
+	} else {
+		enum dc_connection_type type;
+		dc_link_detect_sink(edp_link, &type);
+		if (type == dc_connection_none)
+			edp_sink_present = false;
+	}
+
+	edp_link->edp_sink_present = edp_sink_present;
+}
+
 void dc_hardware_init(struct dc *dc)
 {
+
+	detect_edp_presence(dc);
 	if (dc->ctx->dce_environment != DCE_ENV_VIRTUAL_HW)
 		dc->hwss.init_hw(dc);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index d5d8f0ad9233..e189f16bc026 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -103,6 +103,8 @@ struct dc_link {
 	bool lttpr_non_transparent_mode;
 	bool is_internal_display;
 
+	bool edp_sink_present;
+
 	/* caps is the same as reported_link_cap. link_traing use
 	 * reported_link_cap. Will clean up.  TODO
 	 */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
