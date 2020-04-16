Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF517C2BB85
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C62EA218AC
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4JHqSv89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C62EA218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3D1A6E20C;
	Thu, 16 Apr 2020 23:41:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11FB06E1AA
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5T+S/k054dwbLHhGAdRHSz9lZ+GE0mUtkMTHLtejnI1Yv6koMSL0oViP1MD3kMofcO2sw4wW7Ab1BvGk7DMpF8TEhKgIJUGHSHKBngxe4UYd8QLQiFhtXai397LCZR2u38mbWUWdt0CFZNJFjhnqdHo7mQng/oqrlgwVR8Cma3ADZIjANLBfIfw1W7S8PYP/oAn/8/+A5nGJWrzySCb83tvUs4Z6VzuOFY2Ov7ux41pTX0rlU1VOOgFTIscf23kBCBr4yJfHCpguiIWoFRiFdurDBAQc4DzcUBmOJbgQtWtJsQm16hT6x/CvAT4akuwq3AsuPawVQtjVitfzLnhYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FsYUnMuLI3QmFqRFKRLWt4WedocjrdYpdVAEn5Geds=;
 b=J7Fh3tHSm4eH6P1UrL5HRAZvGHjfnOxPbWIuExqHG9BuZFerUo1BPE1QY2S7YXw4Nk6IHe3kEXCk8XiApRN0gUAADK9syban3kLzxBu5PCZigPfMuu7mApi3JXIrkav/XO85SvyacRe68k/+QvZfWZs1z1S7iQ8+I99GvO8E4uSXU4+KEDX1PKKwlndOLk0gsCXyhZzfjXHZ/sWryXlK3IMr3pnUEmuUKBl8m5LF9EK2pRO1w47R9gjGNPEPX7ift/s0QmfzE6LfZfnYqOLzVdkxTaXSllBFqd3gZ59/72HwSPuqIfPDFOdYmtA6hLcPQ3vThwZ5CwMaeCGwTWklgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FsYUnMuLI3QmFqRFKRLWt4WedocjrdYpdVAEn5Geds=;
 b=4JHqSv89LxoSFZqzofEe/ldfEvVroktFlR1cs6OnDJEQP22By7+1XiCYOj12Td+4WENnyHdrIDbF7uvc5mu5VunyS2kbj9fnUSYknjre4A/SNoXXjPQQNpt18y6gcrF1hgZHThBEnjd8aomBqaQBCmFmTHIrsxgCib8fokgS5Sk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:22 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:22 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/35] drm/amd/display: Workaround to disable YCbCr
Date: Thu, 16 Apr 2020 19:40:19 -0400
Message-Id: <20200416234044.2082886-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN8PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:408:60::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN8PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:60::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:21 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f8445d67-c5b5-484e-7322-08d7e25fab8c
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2459B07707B3C6633D5EF22C98D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:494;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(6029001)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(2906002)(54906003)(36756003)(6916009)(6486002)(1076003)(478600001)(86362001)(81156014)(8676002)(8936002)(6512007)(66476007)(66556008)(66946007)(2616005)(5660300002)(16526019)(186003)(6506007)(4326008)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w05rq0wqlnBP2/QdReTYbGTPkVu+8TDE7ES+0vzsoH/q/CkuGOkGT4mXTcLXgltz67UaJEMHArW+mru4rQIrtdlhH6XMuYNMHYp/2ohkdHat5CFky0PQIyxlWQENn1zUkTAkWkbovahPeyoYLV/l7AdzFD5WdXTN9sXmNZlWU2cJ/xkB2vm8wBj/d+evrAgBSDT7YlQOd5DdJnPMaR2GFDVpMqVn69fne0NLaXL0+0TheuItbqAmeVBi94/Zt6YPrMzgGHucZDCG+HXEWN2DkLvKBBYVW7Y6CpOy6IGeWZh19So70GvMZ5qYYColxOvhIM/GbQf+vMnGvZvERTNjKawg9O0bLlDMmhmHa150P+978yJBtcVUf1WNTEVabWdjv9MjfW+VWIR0ZQkyZSXqmJxuuaSq7RoqkCPAWPBKfaM2BZ/xoTuEotXpFj9Wqe6h
X-MS-Exchange-AntiSpam-MessageData: 6nP/2K4E5ieT0VkaGLqXvBurcZtee1Jf9AUC8D/z0gByUnspCHFIw/0aae/wPA5o2lPi+tslilZUVZASAvTqLhvTWgYXWEOXfozea1gJfO4vN7Rl9Tc+UNC8moxzkILwHSPtIoIEuhwx157kYwcHlzzXFVZhoaHyCG4BX2llfSk=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8445d67-c5b5-484e-7322-08d7e25fab8c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:22.6462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyuTjp/dRgAhr8AZTM4XqWnbbJKPpwGcXFVzJkG//Vybtcq0eC8ZFpt8FKcwyo/tZak284hQzanbQUZJD4zRMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2459
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
Cc: Sunpeng.Li@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Jinze Xu <jinze.xu@amd.com>, Rodrigo.Siqueira@amd.com, Harry.Wentland@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jinze Xu <jinze.xu@amd.com>

[Why]
Some mst dock can't translate DP to HDMI properly.

[How]
Bypass YCbCr timings on specific MST device.

Signed-off-by: Jinze Xu <jinze.xu@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_sink.c | 1 +
 drivers/gpu/drm/amd/display/dc/dc.h           | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_sink.c b/drivers/gpu/drm/amd/display/dc/core/dc_sink.c
index a249a0e5edd0..9e16af22e4aa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_sink.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_sink.c
@@ -54,6 +54,7 @@ static bool dc_sink_construct(struct dc_sink *sink, const struct dc_sink_init_da
 	sink->ctx = link->ctx;
 	sink->dongle_max_pix_clk = init_params->dongle_max_pix_clk;
 	sink->converter_disable_audio = init_params->converter_disable_audio;
+	sink->is_mst_legacy = init_params->sink_is_legacy;
 	sink->dc_container_id = NULL;
 	sink->sink_id = init_params->link->ctx->dc_sink_id_count;
 	// increment dc_sink_id_count because we don't want two sinks with same ID
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1b30804f56db..89cce79c950d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1079,7 +1079,7 @@ struct dc_sink {
 	void *priv;
 	struct stereo_3d_features features_3d[TIMING_3D_FORMAT_MAX];
 	bool converter_disable_audio;
-
+	bool is_mst_legacy;
 	struct dc_sink_dsc_caps dsc_caps;
 	struct dc_sink_fec_caps fec_caps;
 
@@ -1106,6 +1106,7 @@ struct dc_sink_init_data {
 	struct dc_link *link;
 	uint32_t dongle_max_pix_clk;
 	bool converter_disable_audio;
+	bool sink_is_legacy;
 };
 
 struct dc_sink *dc_sink_create(const struct dc_sink_init_data *init_params);
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
