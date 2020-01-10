Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6EDC282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D30C2082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R8UO/AH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D30C2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79DDD6EA3E;
	Fri, 10 Jan 2020 14:47:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B09476EA3D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwMmIGDlp1bnr0ZLVFtvBKm3jsLbi9izo596jWKTqpkdEqRnNLjg8KswbnxrVmYbuq5jGh/GY7TstrUUTT3gpsalQaOGJoEqmsoWXLQiCks7L1/xf1JrhODYko3539ZHsaC8Ay+5lcbAmixSdNL1Rf00Vws9ZbCXA+XyKH1QiofWO9VJrEqHNrDHp2Ra1Pj8OKjS1eAkZzblG/QqAF23XK78wUIZM7Zbt1mXAZMilzz+7McM6Hs3gq2uZXrhncQZ1y6v63VBl781bp+ircI2ij3MHcEWeLUZVcBRtwrz4zy13+Isjju6LW97Ud3MetxFfajU4c3JZGWqvtub25gOHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpnAXt7jF/w8h3b90gjxY8VnvZTNUp/kcn09LeLt0aY=;
 b=AXOdvC5N9zjK7KMK7koBnjgzmqljbp3HY2/h58tpWb0Xw384+G6/ryf3APvnvNRXQZPgldTmE/RVYtmBZnAm/eUUYj4SxgqgQZXCVH6fXKGCQT9vJJjvRBeIERHUN9tLhRjZq//w/0IZtvfNOXRgHGC3fFBtTGgrnyXuvKHFLGH2FpDHyaq5T0pX6QMKNiOu017Cxvh3jaeFJJJnBLu+Gm/mw1uUWU3+/pvNZO7lUIAEiYp/CjU/HI+d3+VznX8Vzya7zm+unJV1EKgIFMiHqgiRhW6hg5zs4QodozRPh82wNjx8csTgGpIi5JpQw6hBKqSMcfLDifB7YE4K855IEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpnAXt7jF/w8h3b90gjxY8VnvZTNUp/kcn09LeLt0aY=;
 b=R8UO/AH7Vc9y7BZtBVsQPHgciGLBQ0BBbwRtlwNSvvuCfkfDwHMzmfew/rgKN9aVStiH8ly7DPBvjEsnnx7MdFVzXfZxOPS81dPIC/nFOiP26xRYRaKrOyEIYHc23MBIBtAIedKxzpyiyDMo/A0vy70CkgOh8oozISNq7ty2aCo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 10 Jan 2020 14:47:33 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:33 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/43] drm/amd/display: Update HDMI hang w/a to apply to all
 TMDS signals
Date: Fri, 10 Jan 2020 09:46:26 -0500
Message-Id: <20200110144655.55845-15-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:32 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8174e299-5c05-4f89-60f9-08d795dc067a
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:|MW2PR12MB2524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2524F481A4FDD744446C048D98380@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(8936002)(5660300002)(6916009)(54906003)(81156014)(6486002)(81166006)(36756003)(316002)(1076003)(2906002)(6666004)(956004)(7696005)(52116002)(478600001)(186003)(15650500001)(2616005)(86362001)(26005)(16526019)(66556008)(8676002)(66476007)(4326008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2524;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J3OfeX1i3E1yV856KyfDpw1bPrCgfj5A6ZXym9w7T9NH6zN0dM6BREzxM7/VM9JCFhnaZovqvXEdlMqIZ9ZQdX7u5G6ge2dxyK3FdTPuNX97Ujj22NSWSsNBo+uv1H3nh9FU9CoBPxUWyUxFN97vxT9wkdqF0r7da4yWHSgQpVJIAJ6aAX+QTW/p3bUQ8MsSyP8VDxNtHqtA8EEIocuxpVcttIldGTN2O3MMuvkX6PepeCJIQkkBDECJwp/Z9oNedMmw8ZoUG+vuDgaudH9k6a9Nbnogg41bGSj4qLQxEnBZaM+RNwAoMItGuA93P4lMSYvSTdpHOnPzo2NBMvuqIDTfW6x5UgfxwS83HTK16UiPGNL00nR9RMhA5+IlbVqu4ysTFXFssjw+k906xNNoJemNUUFeNTfyWcoArJ/71Bt3Qr8FQzuAVxqxvvg0CsPx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8174e299-5c05-4f89-60f9-08d795dc067a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:33.1631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jaYXKwKrqUM5nAWyCdwC6W0rX7e5NsLDFPNJFB4FLZM9Xl0wVqnOdgRS5pDw5janXZ/ivFLetn3KUI210tiXsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2524
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Harry Wentland <harry.wentland@amd.com>, Eric Yang <eric.yang2@amd.com>,
 Michael Strauss <michael.strauss@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
48mhz turn off feature does not work on HDMI and DVI, but the feauture
was only blocked on HDMI, this change will apply the same wa on DVI

[HOW]
Apply workaround for all TMDS signal types (HDMI, DVI single/dual link)

Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index ffed7207c099..7ae4c06232dd 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -59,14 +59,16 @@ int rn_get_active_display_cnt_wa(
 		struct dc_state *context)
 {
 	int i, display_count;
-	bool hdmi_present = false;
+	bool tmds_present = false;
 
 	display_count = 0;
 	for (i = 0; i < context->stream_count; i++) {
 		const struct dc_stream_state *stream = context->streams[i];
 
-		if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
-			hdmi_present = true;
+		if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
+				stream->signal == SIGNAL_TYPE_DVI_SINGLE_LINK ||
+				stream->signal == SIGNAL_TYPE_DVI_DUAL_LINK)
+			tmds_present = true;
 	}
 
 	for (i = 0; i < dc->link_count; i++) {
@@ -85,7 +87,7 @@ int rn_get_active_display_cnt_wa(
 	}
 
 	/* WA for hang on HDMI after display off back back on*/
-	if (display_count == 0 && hdmi_present)
+	if (display_count == 0 && tmds_present)
 		display_count = 1;
 
 	return display_count;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
