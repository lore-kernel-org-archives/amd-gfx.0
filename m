Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF96C2BB84
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD67620936
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qtZDqank"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD67620936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1FAE6EB1A;
	Wed, 16 Sep 2020 19:42:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD0846EB11
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 19:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqtL0wA9IEZ9qDq/OFu3H/YLgw0IvuhJgVxaQK+CfaBdOf2+eHOLPGGc311kPgNCR77lUO6ZLCaJZYwTvPGckGMKcfeP9VnzWeLKjSUWzBaLn4JIra4n1RGO8nGFc86stQ5PI2zWZiuoUrd1dwIu+sofc4E3sviwnuv21eyprRDahsVlxkC+n3vJen9otI8n8oqyTLmu3gvLme3w0yVg2du3+yp4Z20+uxb7mfowFkwMlu3iaVOVY3FfNHyitTLHA/zmlCzeiiUvw3dh80w1+FXE8NniLVXXQ/TDsmj8/NfmLhZUv2O5FHQjFcmneNd4b3HEv+4NiUqhXqGIuXb8Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grTVgqsqdE9F4Bf4ep5sPQkINXMGHRVNqrrK27Ybleo=;
 b=I1NcOzzYoyQtbyIe8uv7HiCVSczWiLlw7a39qrqwzAG+AUkph7ZNAyB6R5lHTbNaaNwH9JkajpizyBMOVToscY0vozL5429H32safvCo0JIEsp4QoTJkkl59hxhLrRBmAm5t286fSIwGNEDc7SLh1j54umQucYeC1QDDCRif15q60nNfVINC2ViUaCVGTAW2aYUhSERiz/tYC0exykNZ/e1O9Bafevab+32lCbBVyeRyNE1RSfg05nYHtNQUmfVjmOvglzdVHc31CTy6YpKL4k5eEREQQfY+4TA4FbQ/VOjF+xpxMNZDc2GlLDH+8jH9HJxDskioY/46HxoN1diy0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grTVgqsqdE9F4Bf4ep5sPQkINXMGHRVNqrrK27Ybleo=;
 b=qtZDqankF+9VWYFgDP91Y+tMCO1uA2PQCvI+e1CgrqIJxczu8drjtndd53pyvR3k11w41+xPwMd/NvE7ozPUTZRatH4/AFE10uS+UVloF5W4sy6AnYvUgIUn+WIu4p0ygWzlK7G7OjXAxBSWhAsMl6FTvcr4TT8tQBSjXmWQ1q8=
Received: from DM5PR20CA0023.namprd20.prod.outlook.com (2603:10b6:3:93::33) by
 DM5PR12MB1548.namprd12.prod.outlook.com (2603:10b6:4:a::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 16 Sep 2020 19:36:44 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::1d) by DM5PR20CA0023.outlook.office365.com
 (2603:10b6:3:93::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend
 Transport; Wed, 16 Sep 2020 19:36:44 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 19:36:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 14:36:43 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 14:36:43 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 16 Sep 2020 14:36:42 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/15] drm/amd/display: Implement PSR wait for enable/disable
Date: Wed, 16 Sep 2020 15:36:31 -0400
Message-ID: <20200916193635.5169-12-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916193635.5169-1-qingqing.zhuo@amd.com>
References: <20200916193635.5169-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6b7ff6e-1461-4b3a-ad37-08d85a77d7bb
X-MS-TrafficTypeDiagnostic: DM5PR12MB1548:
X-Microsoft-Antispam-PRVS: <DM5PR12MB15489C21820F29A61782B4E3FB210@DM5PR12MB1548.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hHQwz4Gb2n9LNrfDx0b3i2ENZDaCsLKt3yrVbsHgZJTGxr3zO5xmhNX/xjIsWfud3tP8CsKK/VlcPFeX/VsxOIyhyRZE0H3CJ3phWC6YxYTC2SbzqVleIOfFalgODLLG9A8Qmf/PaiKN0vqrEonmHvddv2oZ5M281fRBc5GzySxnLXWa0GmX7i2vvfGQopF077+AS7rfWOApU4S/qGQ4iSMhCRb3RePTr9E4eRFdzP492+iumRvscmdnrCTtdWLn2LCOSIty6Beoassb1oESXMe7LghFIMebO71nqud89AaPoPGAQw5qlh1YH4QtpCiByt+yPlK+M4TOgEKkm39Mh6JklkHdNTagb5BjFCgNSrUPrvTf2xr5CzpjW2wxcDOvX3e+/Ni09PjKiUD4IuOSIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966005)(426003)(36756003)(82310400003)(70206006)(83380400001)(5660300002)(4326008)(478600001)(6666004)(1076003)(316002)(8676002)(8936002)(2906002)(86362001)(70586007)(336012)(186003)(26005)(82740400003)(2616005)(47076004)(81166007)(6916009)(356005)(54906003)(44832011);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 19:36:43.9094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b7ff6e-1461-4b3a-ad37-08d85a77d7bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1548
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
 Wyatt Wood <wyatt.wood@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
For DMUB implementation of PSR, the 'wait' parameter,
used to determine if driver should wait for PSR enable/disable,
is not implemented correctly.

[How]
Implement wait for PSR enable/disable.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 27 ++++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |  2 +-
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 1871ff6119ae..f13396254b5d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2566,7 +2566,7 @@ bool dc_link_set_psr_allow_active(struct dc_link *link, bool allow_active, bool
 	link->psr_settings.psr_allow_active = allow_active;
 
 	if (psr != NULL && link->psr_settings.psr_feature_enabled)
-		psr->funcs->psr_enable(psr, allow_active);
+		psr->funcs->psr_enable(psr, allow_active, wait);
 	else if ((dmcu != NULL && dmcu->funcs->is_dmcu_initialized(dmcu)) && link->psr_settings.psr_feature_enabled)
 		dmcu->funcs->set_psr_enable(dmcu, allow_active, wait);
 	else
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 5167d6b8a48d..bf24f1029547 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -119,10 +119,11 @@ static bool dmub_psr_set_version(struct dmub_psr *dmub, struct dc_stream_state *
 /**
  * Enable/Disable PSR.
  */
-static void dmub_psr_enable(struct dmub_psr *dmub, bool enable)
+static void dmub_psr_enable(struct dmub_psr *dmub, bool enable, bool wait)
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = dmub->ctx;
+	uint32_t retry_count, psr_state = 0;
 
 	cmd.psr_enable.header.type = DMUB_CMD__PSR;
 
@@ -136,6 +137,30 @@ static void dmub_psr_enable(struct dmub_psr *dmub, bool enable)
 	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
 	dc_dmub_srv_cmd_execute(dc->dmub_srv);
 	dc_dmub_srv_wait_idle(dc->dmub_srv);
+
+	/* Below loops 1000 x 500us = 500 ms.
+	 *  Exit PSR may need to wait 1-2 frames to power up. Timeout after at
+	 *  least a few frames. Should never hit the max retry assert below.
+	 */
+	if (wait) {
+		for (retry_count = 0; retry_count <= 1000; retry_count++) {
+			dmub_psr_get_state(dmub, &psr_state);
+
+			if (enable) {
+				if (psr_state != 0)
+					break;
+			} else {
+				if (psr_state == 0)
+					break;
+			}
+
+			udelay(500);
+		}
+
+		/* assert if max retry hit */
+		if (retry_count >= 1000)
+			ASSERT(0);
+	}
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
index f404fecd6410..dc121ed92d2e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
@@ -36,7 +36,7 @@ struct dmub_psr {
 
 struct dmub_psr_funcs {
 	bool (*psr_copy_settings)(struct dmub_psr *dmub, struct dc_link *link, struct psr_context *psr_context);
-	void (*psr_enable)(struct dmub_psr *dmub, bool enable);
+	void (*psr_enable)(struct dmub_psr *dmub, bool enable, bool wait);
 	void (*psr_get_state)(struct dmub_psr *dmub, uint32_t *psr_state);
 	void (*psr_set_level)(struct dmub_psr *dmub, uint16_t psr_level);
 };
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
