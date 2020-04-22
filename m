Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F350C55189
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C80A2077D
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cvT6bsjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C80A2077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70FFD89F71;
	Wed, 22 Apr 2020 22:08:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65BCE89E0C
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 22:08:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpyNG1WIaYZpVj8Da2WWRlN2uhiV77SIu8HzH8AVOqJs5Y1i0nXg5Q7SrPLUVcoo1kX7u3UIg/bGV3YNpIABWLq2g3CcGegQ4NpGL8IceIB6FsCI3cePtwTgMnXe4fKJpVRdjMyfObSNXOr/kTrNL9srCzW3m8YHaqI3mMzRSnUFS+uGFJjSa1IoVEGFsnoVsR2NrjlLJWNFCfVB04UN8JIwNQRbpx9BgwAuISrLg1/LzgEtdx5rj50ieCpSZ0FZyN21pn+/WdLGkLGrcbQgz2SnF9rVo0xcL8hvipkIJqIiKexx6ZK2zSroDjm6KLV+A73ygTPVd/rDOCvWd+3uBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krrizDuGJPdE4aSqtwM7Ricnw5hZppJC0mJCC997eOk=;
 b=NbIf3BrZHLKhmAE4W8/IE47Y07b+VnvfoOSenCHyqfnDEBklxeTE9BW2gT6PKYFehfIi0cbO06j9jfQvKg6OhsPbYLq2fAyl87/YgIK2wvTkWIz4Tek931/Rt9KBv3AalfgrxMqwonpdI7c4w+6Bnyo2Cx50T6Vs1DtV95Kjgsf44B3NTjKQi7vP91lRHANdSMMZfAEYntZ3SaY1RjO2H+TD6B8GwHdsVVXEyx3mzydoC3RgpH+b6E/VxZcX+YbUcw+R0oj59geU4ejywRQPTfZWa4repdQxdkVMU4QsIgWpNxoh228m4iOPQQ2utZ0xubiiOaJQVc6HqiEfZoawLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krrizDuGJPdE4aSqtwM7Ricnw5hZppJC0mJCC997eOk=;
 b=cvT6bsjFXdmJQRlnP0FEsS4l8ZjmNdBQsom4H4yfEKIepeGqqT2z9SVSDg2WPLollAmxu1GKpYAxmUcEJoSgSX5CREXneVJGBy6jE2VI3WKxSL/uV9uvIVvyVqBm5PAY6ijeyje2U5HXBdDWp5LH7LV4P2Tqha2LslQ0ruZaftg=
Received: from MWHPR1701CA0018.namprd17.prod.outlook.com
 (2603:10b6:301:14::28) by MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 22:08:22 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::80) by MWHPR1701CA0018.outlook.office365.com
 (2603:10b6:301:14::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 22:08:22 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Wed, 22 Apr 2020 22:08:21 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:20 -0500
Received: from aes.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 22 Apr 2020 17:08:19 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/19] drm/amd/display: Defer cursor update around VUPDATE for
 all ASIC
Date: Wed, 22 Apr 2020 18:07:56 -0400
Message-ID: <20200422220805.15759-11-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422220805.15759-1-aurabindo.pillai@amd.com>
References: <20200422220805.15759-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(376002)(136003)(428003)(46966005)(316002)(6666004)(2906002)(26005)(5660300002)(82310400002)(4326008)(8676002)(356005)(2616005)(186003)(36756003)(478600001)(81156014)(47076004)(54906003)(82740400003)(15650500001)(81166007)(336012)(86362001)(70206006)(7696005)(70586007)(1076003)(6916009)(426003)(8936002)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c10e96e-9a3e-4506-1a2b-08d7e709aba0
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0192:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0192A811168B50DD259C47578BD20@MWHPR1201MB0192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03818C953D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iPmQv1nbrWDLp5+NBStRTe11K0AU/FfH+XOyUxPT9cdplNiQJkTB9od2vFAXXY9B1wb7lg2+hyZa/VBDS1GxIkvEmBRmy0pNnqtTYbQuC0uEaQZQ+MiVlE96FJ6XrhFT3Xn1vVuyqfBlcjCoPXzdis7U+GZ32xUSwS68omxZZMLnVJGHYJlJkkUJwluLi7GlIQFL3HHvzQyQiKZKbPuFrFB+qEZGtMCx7YoIxABr91dIg/zkhSXrLOOA8/SCCILo44O53sIH98pKNOwSaEmusyEQm8IgxLfJQPsDyvMlVzBb9cpqN6Kq286FUCJDXXN6FQNSopAflQSyQnYfSQo10XDr53r1EJA11UcUvnrtt0UrKy9uO5sUtu1PKJ13vgLxZS8s6ba3vka1s/GuWhGTGqBjif1TzaEi9QMZpNRDxgsy2W3vYzloCaDd6xdJ7F3cgdm1LW7A2jqnuCx9O9z+l07nS5v7XT754/xVTevRINSs9NrV3agYDX4pBAGi4iHM3IADKd+/C5utOgbHLGDVoA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 22:08:21.4713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c10e96e-9a3e-4506-1a2b-08d7e709aba0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0192
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com,
 Harry.Wentland@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Fixes the following scenario:

- Flip has been prepared sometime during the frame, update pending
- Cursor update happens right when VUPDATE would happen
- OPTC lock acquired, VUPDATE is blocked until next frame
- Flip is delayed potentially infinitely

With the igt@kms_cursor_legacy cursor-vs-flip-legacy test we can
observe nearly *13* frames of delay for some flips on Navi.

[How]
Apply the Raven workaround generically. When close enough to VUPDATE
block cursor updates from occurring from the dc_stream_set_cursor_*
helpers.

This could perhaps be a little smarter by checking if there were
pending updates or flips earlier in the frame on the HUBP side before
applying the delay, but this should be fine for now.

This fixes the kms_cursor_legacy test.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 6ddbb00ed37a..8c20e9e907b2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -239,24 +239,24 @@ static void delay_cursor_until_vupdate(struct pipe_ctx *pipe_ctx, struct dc *dc)
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	unsigned int us_per_line;
 
-	if (stream->ctx->asic_id.chip_family == FAMILY_RV &&
-			ASICREV_IS_RAVEN(stream->ctx->asic_id.hw_internal_rev)) {
+	if (!dc->hwss.get_vupdate_offset_from_vsync)
+		return;
 
-		vupdate_line = dc->hwss.get_vupdate_offset_from_vsync(pipe_ctx);
-		if (!dc_stream_get_crtc_position(dc, &stream, 1, &vpos, &nvpos))
-			return;
+	vupdate_line = dc->hwss.get_vupdate_offset_from_vsync(pipe_ctx);
+	if (!dc_stream_get_crtc_position(dc, &stream, 1, &vpos, &nvpos))
+		return;
 
-		if (vpos >= vupdate_line)
-			return;
+	if (vpos >= vupdate_line)
+		return;
 
-		us_per_line = stream->timing.h_total * 10000 / stream->timing.pix_clk_100hz;
-		lines_to_vupdate = vupdate_line - vpos;
-		us_to_vupdate = lines_to_vupdate * us_per_line;
+	us_per_line =
+		stream->timing.h_total * 10000 / stream->timing.pix_clk_100hz;
+	lines_to_vupdate = vupdate_line - vpos;
+	us_to_vupdate = lines_to_vupdate * us_per_line;
 
-		/* 70 us is a conservative estimate of cursor update time*/
-		if (us_to_vupdate < 70)
-			udelay(us_to_vupdate);
-	}
+	/* 70 us is a conservative estimate of cursor update time*/
+	if (us_to_vupdate < 70)
+		udelay(us_to_vupdate);
 #endif
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
