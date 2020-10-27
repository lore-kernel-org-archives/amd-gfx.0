Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D4CC63699
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB2421D24
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kpxbKOmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB2421D24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED8FE6EC69;
	Tue, 27 Oct 2020 20:53:08 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700055.outbound.protection.outlook.com [40.107.70.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A6776EC61
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 20:53:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Doj4dl6aKpVmnBzn5LgN8nX0H6bBbZmOkBJZJvHrtyljV6B6NNUmUjBktxfNRW9oyzSOAhkzXYCP/HpbyYeAQdTJpEwjKRpQTtvXGTcn3hngMJ+4x6PwUp5sfUWLDLZURX4Ye1itAzxJWA7NJH0ch46CKfg6GhwSdPWE+eETYe3dm5m4t25lWsKAsSUG9ep+saKKqNL013Dt71btAHN+pO4tpqMxFjFa1pOo0aHpzDGoBW69UFi1uUqBjZt/8IGskTAx7Fzqdns9S+6/6m9Ss6U1OTGS+fEi7QxHVg+asPYJYkbTMo3DXjc1i8PQGDDswcuga3Pu1gr1P6QAux0F2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIWSbkLGxHKKVRfyd0Pky9QjA5vtTcn6/1G6lN+yiJ8=;
 b=HUmdgOSrnyeHWU5BqU1KZCiEwyR53qcWE0zdhBo4GIcFTtZnzEgh8qeCAFPJxkg9atxXjreYDh9aYWl4lKfMVV1+c9+R9SvyjbsAg5O1sZac7D5nx/m+mzqptUh0pVNIE+GXVeoaIjWatVnErfhCTmNrrnWxTrv1FbfLYqvn/7ql5ilB2IKzqFDJaL9tCp/GHFYHTwLYu/PRw3diWFgUobShgnV6GzHFtge8fXqU0TxzK1UtODEr0lIlXeiAmKoD3AeIzSluvE4FWg6UhfNurkojWvw65HMWxCw7/MSHvyd83iHclUqlO9IyFQ08tYdH+N7LiTESs5tEYBmgBb0Ydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIWSbkLGxHKKVRfyd0Pky9QjA5vtTcn6/1G6lN+yiJ8=;
 b=kpxbKOmLBLLtsR/9x2CU7/vvrT6sK5FCvfRlWFTbg7qtxWc5lsULiO+FGkbdFVFcAN594+VMlYZN/gngI+74EppdtdCdHNTCXWZ00nnCiNgDUWJxJweGqP4N2Ago2uUHLHrzC4gtZ+2PZrUbVZIDKMSnZ4zymvPFAe0LppKpKeU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 20:53:04 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 20:53:04 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 18/25] drm/amd/display: Calculate CRC on specific frame region
Date: Tue, 27 Oct 2020 16:52:27 -0400
Message-Id: <20201027205234.8239-19-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027205234.8239-1-qingqing.zhuo@amd.com>
References: <20201027205234.8239-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To DM5PR12MB1884.namprd12.prod.outlook.com
 (2603:10b6:3:10d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 20:52:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 558a5651-f955-44be-651d-08d87aba4839
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB359501D1B7A442FC4FC6E780FB160@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OukNoqHzXzLHNIxtgS0/hAmEpmxXdV5qpPQ29Jgm8jTqy1T/r1lLpOa7K32/AeJ139SREJUsSYh0/1kB9kGzxLlT6sPRLktXSmQOsyYd7YJQVy8IVuLIVaegRuPB+NA/OeirAKpoelOGSibqcIMSa5CwOHWhoWYhUOTYXCVIsN9/YRKY07FRnSnleueGdzFHU0AqMDCZaWqbe6t9WDO2aav0Glnb6vVwRrHdZy5BKKsqqakKwiwKHNkaarxeysVztLyZnqoMhlg13t14DLqbGlWzMG+9E3rd4ZmZ3fktWctT7DxOTyxqS9en+IYSVOpZA8hdqYYP9lUHOcf97++lIMS1UoSkI4ORFV3HI/8DPEVFibfS19YrjOAIO0lLQPbK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(6506007)(2906002)(26005)(66556008)(16526019)(186003)(6666004)(2616005)(6916009)(52116002)(956004)(66946007)(316002)(1076003)(69590400008)(44832011)(8676002)(478600001)(66476007)(5660300002)(4326008)(86362001)(36756003)(6512007)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: VbZG/Q8hYueRETcfVhIu48D+Ej+EwavCExIvb9gaDmGU7njusEnNSI/83t6mpY3kcR3vDsZbweUk6SALa+aN4f++51OuA9/cMDEuNX/yjLgk1cJacbOdUXdoBJn+GYbxoB51p+RLIOMdwrfI1+m5+KwPyqJ3Tf4xSf2WAoFFrhzdcaAcxk5SCzO2IEf3Sk3XAkhSM9yxibpgYl/xRAiQLvgAnKXy8fJjrSWbhFny8WA/BxcFTAbfESwPr84ii4v5H05Hlen3utj+4oHZpyrKTELFsXzinwM5VE5WeTU/90QM+8XJ3jXgcR2zCETcc1LlVdG7XjcG8X+BHOra7phjZ0h2KNXgv0xblQqxcI9iRGzQ9C6KL0wboOCoJdDmibyR8HsYUjUgZFRlMC3ZonaoyzDcgig2J21H487uNL6lSZ1G+6qqZI74HuTm3iI8p34QYrhQys/3neq6IfE48daLTwzQ7/JcTX6DuTEO1ah30ExfP7BeWnqkobvu89kEIEweTApZmJ2V0VDkRyHvNGhvibCAWg7yf0Zxj4ZpXKjysCC27KtTRsCUtnU4L2hiTh+hND9ks2n0BM+HH6pMXSCECBPhKe5YRBjy6mdfWM68425DGw8+WY+gC8pG0XfT3nXkVoDV5LS54UTN7imrTUWfYg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558a5651-f955-44be-651d-08d87aba4839
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 20:52:56.9830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJjmzbwpo2bSaAPQfuEplUQEejycsQBCsilZSW2XQn99WPF9zeaPsvHrv9tVHG34
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[why]
Currently, we only support calculating CRC on whole frame.
We want to extend the capability to calculate CRC on
specific frame area.

[how]
Calculate CRC on specific area once it's specified from the
input parameter.

Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c          | 15 +++++++++++++--
 drivers/gpu/drm/amd/display/dc/dc_stream.h        |  1 +
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index d0699e98db92..c29dc11619f7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -115,7 +115,7 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 	/* Enable CRTC CRC generation if necessary. */
 	if (dm_is_crc_source_crtc(source)) {
 		if (!dc_stream_configure_crc(stream_state->ctx->dc,
-					     stream_state, enable, enable)) {
+					     stream_state, NULL, enable, enable)) {
 			ret = -EINVAL;
 			goto unlock;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 18154eea09f8..34e76fdc1334 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -346,7 +346,7 @@ bool dc_stream_get_crtc_position(struct dc *dc,
  * calculate the crc.
  */
 bool dc_stream_configure_crc(struct dc *dc, struct dc_stream_state *stream,
-			     bool enable, bool continuous)
+			     struct crc_params *crc_window, bool enable, bool continuous)
 {
 	int i;
 	struct pipe_ctx *pipe;
@@ -362,7 +362,7 @@ bool dc_stream_configure_crc(struct dc *dc, struct dc_stream_state *stream,
 	if (i == MAX_PIPES)
 		return false;
 
-	/* Always capture the full frame */
+	/* By default, capture the full frame */
 	param.windowa_x_start = 0;
 	param.windowa_y_start = 0;
 	param.windowa_x_end = pipe->stream->timing.h_addressable;
@@ -372,6 +372,17 @@ bool dc_stream_configure_crc(struct dc *dc, struct dc_stream_state *stream,
 	param.windowb_x_end = pipe->stream->timing.h_addressable;
 	param.windowb_y_end = pipe->stream->timing.v_addressable;
 
+	if (crc_window) {
+		param.windowa_x_start = crc_window->windowa_x_start;
+		param.windowa_y_start = crc_window->windowa_y_start;
+		param.windowa_x_end = crc_window->windowa_x_end;
+		param.windowa_y_end = crc_window->windowa_y_end;
+		param.windowb_x_start = crc_window->windowb_x_start;
+		param.windowb_y_start = crc_window->windowb_y_start;
+		param.windowb_x_end = crc_window->windowb_x_end;
+		param.windowb_y_end = crc_window->windowb_y_end;
+	}
+
 	param.dsc_mode = pipe->stream->timing.flags.DSC ? 1:0;
 	param.odm_mode = pipe->next_odm_pipe ? 1:0;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 82a35d008094..e37720344819 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -457,6 +457,7 @@ bool dc_stream_get_crtc_position(struct dc *dc,
 
 bool dc_stream_configure_crc(struct dc *dc,
 			     struct dc_stream_state *stream,
+			     struct crc_params *crc_window,
 			     bool enable,
 			     bool continuous);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
