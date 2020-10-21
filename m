Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252A7C388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A645F2224E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sxI+IX6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A645F2224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F6E86EDC5;
	Wed, 21 Oct 2020 14:23:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE5DD6EDBA
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDEDnn2LDrzMz/oZbrl3FPi2bds+LuwsBDRaOtcNOo9G42lDvmJGjuO4CWEbTZl/EeOT3kk49bl+TOELlxSMAnxqHE/t46b1DgDFUKc4WskkMjQSh4Y4UXmBMgBYdSr2wbS4+wnignpFB+CAf9OlFAzyLJTdMg2fGWrSY/TE0Ilo31rUmwxOST2ENcb9jDPtRuyFRSFqxICqlMxy7zRI5XJht54KSwgyjDuZMJBMeYE5UqWPgVSXWIo2xo6Jw/+fdzyiQMvd3dPd+q2bjb1rIpXKV/WbnxWIxqhz/VPOK4M35/3WMLiIzzY4ai7o7PY2fO/+diSdgQASH/9z90yo4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYARfIoLAmV3o6+vniKqAj/TjRGlDHYtQE3poHn8BqE=;
 b=Y4y77q+fU7XmsuvPZLPKDSIONfECkI/cDZZ/C998w88aWXyA60evuSqsvAWuHr5ydJa5Qcy2Qwc90TPKGFn+mei3DgBBsxDaBTI7IPshLAVR+oefxw7bmwQBnZvPi9pqxEO2122O2JwiDj4mGEHb7ThjkbDdiPH8aqpjA9hyILzT/79WqxkzmX7TAaLNq4YzKlUUg9EaJ9mxKEeMCCRiMKXLFmYdCVxALtNrcUQiDdiIScGl+niWh3luJrfZvJ+VMEccpI5crheDyRxP10+r28JZnSndGiHrNqBCpojbrWeIdxH1ZKGdnO7B2VtDnvAg/INF4m+Vy5AW6TJeZHFDpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYARfIoLAmV3o6+vniKqAj/TjRGlDHYtQE3poHn8BqE=;
 b=sxI+IX6pbB/Pz5W2d0poM2P2FxTkKRrkOP6SvzmrRiZEWDAvXPhFBZTyk62FCjnufQo7ylZOiby42jxhdmfIMPPeJ46b8YGM3yMXbBf4xNLhn8Gjg7lcwKev4njWLC+RAynWU7HVdJ2W/X6G7I/pYWnU7HLCmRGsjI9myfrXRho=
Received: from BN6PR16CA0029.namprd16.prod.outlook.com (2603:10b6:405:14::15)
 by CY4PR12MB1814.namprd12.prod.outlook.com (2603:10b6:903:125::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Wed, 21 Oct
 2020 14:23:17 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::ac) by BN6PR16CA0029.outlook.office365.com
 (2603:10b6:405:14::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:16 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:16 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:16 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:15 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/33] drm/amd/display: skip avmute action
Date: Wed, 21 Oct 2020 10:22:39 -0400
Message-ID: <20201021142257.190969-16-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 028230bf-344c-4312-770d-08d875ccda3a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1814:
X-Microsoft-Antispam-PRVS: <CY4PR12MB18146323B3BC06B90D17A0848B1C0@CY4PR12MB1814.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NPSzU9+/rqVTNbku6oWCSfSZ04tZT+9IE8/cVq0neZiLxBfVKlcyy9wia1inH2SVGdMVP5JwGJfsDP+4zf3RFDEStvOQL29TccGH8H9rEIoTnm064uLLU3l9qJtrSBh/tQn2gT8LldasrFpeXR6v4LxBOvcgMSHgl/IzV0ScAsOq/wjDTer7brmxVGyf5d9+idCXjpCxy3+cYvndT2383bQa1qH6FkhOt4qxhe2psNLMIAF0UQMzriRNhhMEX0wMU5cBEDFDQka87OXP5WTT6qLDGt21kWD4Jva2nPU1b3V0AhbBcZnb00oFGzW0+U6JOi/J22O/O7Cc8IwIlXdP6MKqKvqLQ8pZMdgvjpS0fPFifrYwuQIA294CI4PQDZMef/l5aPNQhVbbvlzkge9+SA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(46966005)(4326008)(316002)(5660300002)(6666004)(356005)(82740400003)(81166007)(7696005)(83380400001)(82310400003)(47076004)(36756003)(1076003)(2616005)(2906002)(86362001)(44832011)(336012)(6916009)(8936002)(186003)(478600001)(26005)(8676002)(70586007)(70206006)(54906003)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:16.7538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 028230bf-344c-4312-770d-08d875ccda3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1814
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
 Brandon Syu <Brandon.Syu@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Brandon Syu <Brandon.Syu@amd.com>

[Why]
For some monitors,
they can't display under BIOS with avmute enabled.

[How]
Add monitor patch for skip avmute action.

Signed-off-by: Brandon Syu <Brandon.Syu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 5 +++--
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index fec87a2e210c..5652a072d9be 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3283,8 +3283,9 @@ void core_link_disable_stream(struct pipe_ctx *pipe_ctx)
 			dc_is_virtual_signal(pipe_ctx->stream->signal))
 		return;
 
-	if (dc_is_hdmi_signal(pipe_ctx->stream->signal)) {
-		core_link_set_avmute(pipe_ctx, true);
+	if (!pipe_ctx->stream->sink->edid_caps.panel_patch.skip_avmute) {
+		if (dc_is_hdmi_signal(pipe_ctx->stream->signal))
+			core_link_set_avmute(pipe_ctx, true);
 	}
 
 #if defined(CONFIG_DRM_AMD_DC_HDCP)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index c36f0daefd83..7ff8676daec9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -235,6 +235,7 @@ struct dc_panel_patch {
 	unsigned int disable_fec;
 	unsigned int extra_t3_ms;
 	unsigned int max_dsc_target_bpp_limit;
+	unsigned int skip_avmute;
 };
 
 struct dc_edid_caps {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
