Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DE6C433E4
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB6C1206F0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wc/u+gR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6C1206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAD566EA0C;
	Fri, 24 Jul 2020 21:07:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E384E6EA0C
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 21:07:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vsfuk4ywi+0nhA9QLkN++hACEUGJm6cnFP5pASKCKk/1BULnqUCOpSELVuzVTbQF39y6Be1OLonIMjkUs4Itss3wG+yyGYVWRNKcs/pXeglOOQ50r7zX6QYi+0UnIvecg+ROZt19yNJuTKVbhJXFmNzmzVFafxQbDwHg20vGMpXj5L1Yr0ntLgkocGhRCGhMV81K1rE9I+Mg4IgS+GoslAhf6fbaK8610jRZMpxlT2MDer1CYD8soJM7SJvKRhLPGHkSZTjuMz0dd8j0UN/QdDiImiTLHMMThmNseB0FzqONRxch8UWEAWPhEaY98PHUG0xJHj9B4vL9Ni4M7DosGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKflP0WSWpwsggJ8+F1s1i1aWLLLuP7u4ZKE4P1K1IU=;
 b=PvoTjs/ED6l6mEDYDVABkV3jash2bAo3a98L51EZ6BWRFxxrdplcQJWuVvA4kZqAwkKnwltmb3lsAyV3X4iNJAhWRmYJ1m+r5yS4U2iwPEI2QD7/16hlpp1x00oKQM/IoNoq92IlBXNCajE6st6yOTHpL6DwJxEES5QkL7KHEAFPQIZ7l31wCSwj7g94eceYpstxwebe36m+SCDV6Gtm7g0afo4MVZwf1ToiQR9drlf0TAbwYAHbJFZ5ofFap0RmIkpdtwoMquV8oGm7zAxk0cRb19nFOUupW51haLq9gns5JwaDxUcaRiqD5Z+tfMggSuIWf8du2LaqITgblYi9gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKflP0WSWpwsggJ8+F1s1i1aWLLLuP7u4ZKE4P1K1IU=;
 b=wc/u+gR6fii+YWmJCpuyGcJXfW4ibweaFZB2EMdNxPGJqRixq1bTDMjXhdAGG/yv/zgH6xAEqEwgHExgRY/MhCXQC0PJkoDOlGftyKH6b7UrZpb21dYCWGmCti737XREP0X6f8yfI2WK1kTYDPoeko3yhL0PcXG/tr6nisudyGk=
Received: from BN6PR2001CA0047.namprd20.prod.outlook.com
 (2603:10b6:405:16::33) by DM6PR12MB3084.namprd12.prod.outlook.com
 (2603:10b6:5:117::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Fri, 24 Jul
 2020 21:07:33 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::4f) by BN6PR2001CA0047.outlook.office365.com
 (2603:10b6:405:16::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Fri, 24 Jul 2020 21:07:33 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Fri, 24 Jul 2020 21:07:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 24 Jul
 2020 16:07:32 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 24 Jul
 2020 16:07:32 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 24 Jul 2020 16:07:21 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/15] drm/amd/display: Disable idle optimizations before
 programming DCN
Date: Fri, 24 Jul 2020 17:06:10 -0400
Message-ID: <20200724210618.2709738-8-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724210618.2709738-1-eryk.brol@amd.com>
References: <20200724210618.2709738-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a783621-7e8a-4b5a-4f44-08d830159530
X-MS-TrafficTypeDiagnostic: DM6PR12MB3084:
X-Microsoft-Antispam-PRVS: <DM6PR12MB30843F1D624BE38F25139947E5770@DM6PR12MB3084.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YXucNV1l7OWMGlLFItld/+cW6qIBceKmNyWM1CcA2C6bgATWGt9Jbd4pyBUCHC3jiqm+TZwq52CUrQMoLnvitC/PVycJr+szfpn/tEZvOB8jU6Iy3BI0MrfpKyc4LiAzdL4F1lawX4arrp5sbeQNC/+/DMB59vzOKwQ7QeKOk83/wYa5TXWqBlXwh/uRvE0qsUTsk7o7aQRbeckH2HL7ZaIESpQnKLW+HxwxQPImTkcOe7lBwJfOXZktywVyex9jtDsATpm95xLrGhY4FEe89dMgQtfZaGyhpd5cEyjRLWPFt/NawMmlnb0mGQ0GHLLFV/LFR9j52Xr8MzPKb5hoHErEmOC5y+7cV5nmzmgFMqcbQaj7+8VvJCi1ysfTMU4u0m9jqxoVZbnHt2xXyJSnUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966005)(36756003)(8676002)(83380400001)(186003)(70586007)(82740400003)(26005)(2906002)(47076004)(8936002)(44832011)(4326008)(1076003)(6666004)(426003)(336012)(2616005)(54906003)(6916009)(478600001)(356005)(81166007)(316002)(70206006)(5660300002)(82310400002)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 21:07:32.7923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a783621-7e8a-4b5a-4f44-08d830159530
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3084
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Jun
 Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jun Lei <jun.lei@amd.com>

[Why]
Programming DCN is explicitly forbidden during idle optimzations allowed
state. Existing implemenation relies on OS/DM, which is not robust. Instead
DC should sequence this.

Note that DC will not re-enter idle optimized state on its own, it is only
responsible for catching out of sequence calls. It is still DM
responsibility to sequence appropriate for optimized power, but this change
removes the requirement for DM to cover the .1% case.

[How]
 - elevate updates during idle optimized state to full updates
 - disable idle power optimizations prior to programming

Signed-off-by: Jun Lei <jun.lei@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ef0b5941bc50..92eb1ca1634f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1250,6 +1250,9 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	int i, k, l;
 	struct dc_stream_state *dc_streams[MAX_STREAMS] = {0};
 
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+	dc_allow_idle_optimizations(dc, false);
+#endif
 
 	for (i = 0; i < context->stream_count; i++)
 		dc_streams[i] =  context->streams[i];
@@ -1838,6 +1841,11 @@ static enum surface_update_type check_update_surfaces_for_stream(
 	int i;
 	enum surface_update_type overall_type = UPDATE_TYPE_FAST;
 
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+	if (dc->idle_optimizations_allowed)
+		overall_type = UPDATE_TYPE_FULL;
+
+#endif
 	if (stream_status == NULL || stream_status->plane_count != surface_count)
 		overall_type = UPDATE_TYPE_FULL;
 
@@ -2306,8 +2314,14 @@ static void commit_planes_for_stream(struct dc *dc,
 		}
 	}
 
-	if (update_type == UPDATE_TYPE_FULL && dc->optimize_seamless_boot_streams == 0) {
-		dc->hwss.prepare_bandwidth(dc, context);
+	if (update_type == UPDATE_TYPE_FULL) {
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+		dc_allow_idle_optimizations(dc, false);
+
+#endif
+		if (dc->optimize_seamless_boot_streams == 0)
+			dc->hwss.prepare_bandwidth(dc, context);
+
 		context_clock_trace(dc, context);
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
