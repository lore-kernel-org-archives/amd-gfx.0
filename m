Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4863C2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 754E22082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TLzkKycL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754E22082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EE5C6FC4D;
	Fri, 31 Jan 2020 22:17:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B9166FC4B
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqVXQVDH0k0nCajKRD2YagRiq74u7XZ4igPRUJdo6Hb+rND6paQ0P7uHzaS3/1jFuIYeE4MwMg9b5Qg9Mw8gTUdwtN/gnmRZDktPy+tpB+qOEf+4JFQBaeeXkcLorXCO1e0feSV01PZvfpoCCZOceQ7qQFZMD3dP32CasKu/7CpyROG/aN7e6buKwQlpVyJykpijXIH60crjK9cdGXLI1YWWxEUQNhNgfuO+Tj/tJhCcbGA1x7hOV6CWZhPtMIbSIKoCqzyttQgDDiuTcqX2QddpWnqfXnPChU6qEGKuzhwviomTeTISeFDj9gVGIaFGXdIklfnFeXSO1w8S3wTBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8RqSfJH7gG+J3REoGfv+C+Co4P6gByD6yG38TknIvE=;
 b=BCxGnu7bW4CQ2MmZ6zLQTHI0Z+tN869vxh3NMf98/43cNTE95mADRARwNYKoPFk9x/v2B8D9l5Y7tOMC9HYLXKnhWo6+QNUaBrVJyLUvRPjRGm8fBDUwfHSOYWFjoaG4wa9uEsDjbdBbXQw74j9lFaP8+6KgSs3xwh/QGR5g2LQVaRpE9O5sE2lZNk5Ng5/p2cG/9hedv4U1H0O1ZKrD96PQAyOHdDdFq1FbSLNFry11vgM5pJ0c52pTTyy02nQWXCTiXMlqkNazz6qoBDNDIYSgJ/T57/OVHAHXcEwXKOBmVNX0oSVbNQgwyBs5y2lFkMEq74cnQn6hEa0H1JiCPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8RqSfJH7gG+J3REoGfv+C+Co4P6gByD6yG38TknIvE=;
 b=TLzkKycL++i/zBJAHAWVxjhP6TzrZQwEDKlTtcNrj9/WgkqsUcCiLhmfLF+d9Dhbbhku2c+thjYbisk4qT4uq7+ObkTUOLJKiMF4txIVDjwIhCKRQQdEf8PshV2q2/GVBrde9dSv+FTi0295bPFyCtqgYlPOhvtlfJuIFTYxLnc=
Received: from SN1PR12CA0074.namprd12.prod.outlook.com (2603:10b6:802:20::45)
 by MWHPR12MB1199.namprd12.prod.outlook.com (2603:10b6:300:10::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27; Fri, 31 Jan
 2020 22:17:23 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::207) by SN1PR12CA0074.outlook.office365.com
 (2603:10b6:802:20::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:22 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:16 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:15 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:15 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 33/33] drm/amd/display: turn off the mst hub before we do
 detection
Date: Fri, 31 Jan 2020 17:16:43 -0500
Message-ID: <20200131221643.10035-34-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(136003)(428003)(189003)(199004)(356004)(6666004)(7696005)(186003)(70206006)(70586007)(8936002)(2906002)(86362001)(316002)(54906003)(4326008)(1076003)(478600001)(5660300002)(426003)(36756003)(81166006)(81156014)(8676002)(2616005)(6916009)(336012)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1199; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6f9eaff-505e-48e9-6984-08d7a69b57f2
X-MS-TrafficTypeDiagnostic: MWHPR12MB1199:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1199889F803A7FE5056573D7F9070@MWHPR12MB1199.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0XSlS7RhnZrMzuSdlaTDRTwX5/uy8zP7JqEHbfI1FAaPxhMPBREyBc8gB9TMczwae4+b+M4dItR/dSAdBiiREu2cFw2jfLC8QKF31vd6wauARCoqwD6QDxwn8yUmNl8UCjw6xGsh8PpjjPqjSkumG+BRtAfWbkSpsw2u9DS8waXBq9/yNixHQC1mVV2wlpk42XKOZhES4MeBtoMxAIwMijW532su4zeBL3XFqUPOLEoeke9dajv4WdenOvVNTAbWtbEdMQs03C66v2YTjPSOyFf/NJc6RKQGX1WuR6pw8gS7WhVjhBGcsOEKj5icN6y1o8CwNKUFxxTihDZ/VK0auHIxIM3Z9c1JWUWgUHepOvIF1UN5ZOErv2wxHI5+bX6Yr8IkvnBw6Cev3uAcPPQ0QbpoP9/8wvRq7oejAk/BTUmP/145WBk73iqDfOzaEHp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:22.1421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f9eaff-505e-48e9-6984-08d7a69b57f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1199
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 Joseph Gravenor <joseph.gravenor@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joseph Gravenor <joseph.gravenor@amd.com>

[why]
not turning off the mst hub before detection on reboot
causes us to not be able to light up displays with mst hook

[how]
on hw init, see if any displays are lit up. if so, turn them off

Signed-off-by: Joseph Gravenor <joseph.gravenor@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 0225f8d8bb82..42fcfee2c31b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -48,8 +48,8 @@
 #include "dc_link_dp.h"
 #include "dccg.h"
 #include "clk_mgr.h"
-
-
+#include "link_hwss.h"
+#include "dpcd_defs.h"
 #include "dsc.h"
 
 #define DC_LOGGER_INIT(logger)
@@ -1322,6 +1322,24 @@ void dcn10_init_hw(struct dc *dc)
 		if (hws->funcs.dsc_pg_control != NULL)
 			hws->funcs.dsc_pg_control(hws, res_pool->dscs[i]->inst, false);
 
+	/* we want to turn off all dp displays before doing detection */
+	if (dc->config.power_down_display_on_boot) {
+		uint8_t dpcd_power_state = '\0';
+		enum dc_status status = DC_ERROR_UNEXPECTED;
+
+		for (i = 0; i < dc->link_count; i++) {
+			if (dc->links[i]->connector_signal != SIGNAL_TYPE_DISPLAY_PORT) {
+				continue;
+			}
+			/* if any of the displays are lit up turn them off */
+			status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
+						     &dpcd_power_state, sizeof(dpcd_power_state));
+			if (status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) {
+				dp_receiver_power_ctrl(dc->links[i], false);
+			}
+		}
+	}
+
 	/* If taking control over from VBIOS, we may want to optimize our first
 	 * mode set, so we need to skip powering down pipes until we know which
 	 * pipes we want to use.
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
