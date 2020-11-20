Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD3DC2D0E4
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22F9722D0A
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oWhZ9X5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F9722D0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEA296E919;
	Fri, 20 Nov 2020 20:20:31 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680047.outbound.protection.outlook.com [40.107.68.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27C086E91D
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 20:20:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONd7rYvwrHImdgHUn4BH4Czo3QXHmrAYSYSoG2gIjAf9h+bmFnaRRM1BRe1wiIOdwu9HqDZTF/CMUZil8f0oZjMUzMXsRKKo03q2I6AZNT7PTFWEfHKi1c1TIyfzSpiAbFNGHC6XkqfwGlNPVR7npsS6qoQUguRCLtr+7F2MkgevjeQEr6VqP1y9/Z7u0XTm4FK2OlW3WL8AW8EP4Mq7SYzo3GjZr9Y4AvU6SFPMe4n5BfoWZa0N9ysyJ83U7i/RNu1mC5R9bmLTpzVqIHDIfsZ7tVH36GYLJptAeA6jll4yicOt7EVXRF7+YJ1lWrXtgS3mL+69Lpif1Pc1rm25Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E69F5vwmur5Vh+mRRhGPeVzNLY47JiX4a+DWrpNRoK8=;
 b=lg65bEWrXxfaiYvzwuqPfvapInJkSwCdLHMvgMc4Lhw7RIL2mnbmI4w2BoOJekIufX6arGlwLSI8ZwGBbqmClYWV1K53e0a/ti2EVhLjrtt3dKXF5cW+YtHqbpj5JBapQzfIhqxxpLDrTT8Fla8dj7tA4v7C42J5oinac+WhuqM36Srd8GZXk2/e/5R1Ij52/pvMnLI8EYFM3ri1wyMMIwBznktmMzwKM+N5O3S7jvpiu3o61GIugP+FoQjCY2CwBA77Pce7/cWTvh23jt4eb0FRo5mQWUxGQcIyJZuQGucMtzWL0KCWWU47KXVg9By0j1qRc4rHDN+FTmXvc1kdnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E69F5vwmur5Vh+mRRhGPeVzNLY47JiX4a+DWrpNRoK8=;
 b=oWhZ9X5f0zBYnkCBof8GZo20+DPV3jPY57YjWmL2FfE6REO1RUfAanwyOA3TZ+1SNWpoSxEkZvD2A3PuObH1cjCdyCdoxVz2WOqkxGPLzi/jciiP4LBWjUYkoRqtPcp0kAEyp8e9lGrzXM6Rgv8X/Jq/FslQSmfAE2ir0f1z8+k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB3717.namprd12.prod.outlook.com (2603:10b6:610:24::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Fri, 20 Nov
 2020 20:20:30 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa%4]) with mapi id 15.20.3589.024; Fri, 20 Nov 2020
 20:20:30 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/18] drm/amd/display: Add internal display info
Date: Fri, 20 Nov 2020 15:19:51 -0500
Message-Id: <20201120201958.2455002-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
References: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60::c908]
X-ClientProxiedBy: CH2PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:610:50::35) To CH2PR12MB3781.namprd12.prod.outlook.com
 (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::c908) by
 CH2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:610:50::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 20:20:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ffc558e5-5959-41f0-5c7e-08d88d91b9d0
X-MS-TrafficTypeDiagnostic: CH2PR12MB3717:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB37171F46FEC6B7E5988967D098FF0@CH2PR12MB3717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PqNbGQ/FF4zu25BSESfZb1kyoyF2QUna72QAsaUd/Jk3SCezQmZ+vIRsC+82vgNtpc//iBPeYsoHmCVjWKKtGjTY18BuQi0llYp+UqpuZVDQSX+2q/CNp+9F34kiq5+hqKtupZJIa365nTTwehfb1+2hZz8/yKGf6DWauHt+nhKBgqUoUAvak8q9+8sZ0NNPGkLNzaD/ykgE9SLDbNuE25kWenqrHzVEpwVowbBmkAt7BFz7+aXwP8JMeSzZfPLHWbKKe+uhdXWnUMnpFNHE35g2Andkeen8/JX+yC4NL0Iv47JGBpTvoKvGFlotovI9lt9CwF2PTVfQaGXrCv/5dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3781.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(86362001)(66476007)(6916009)(8676002)(54906003)(6512007)(8936002)(66946007)(52116002)(6506007)(16526019)(83380400001)(5660300002)(2616005)(186003)(1076003)(6486002)(36756003)(478600001)(66556008)(316002)(4326008)(2906002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: M8zGMaFxhApOBBW93WRdL0EulFY91qhwqa4DTuBbYtvWcmDLQ8XH8yz3lwKQOgOBTE00HNwUpMcNIIyi4mTdhUzIKx+b9kLcEN1Ujjg+tlPM7uTbSU/KckOmvDlWYKX8cnAtXciwi1GPB9tXsLFA6rwxQpF7MrZuecqjo5Nn4mxYB0ziPHtK0vp0oclwrJItgnbmrlEj5Kgn275M9rDrpvdaGdJLc1bxw0jZUrytKu2J2WgDTHKvOM7mOJGrk/Q92AD1zyyUPDNsC8VDDym0hjaxGOCJMHR7JtQHVhO5l+T9SGp9p2Q75fbT/dm33CvE4CiciIvusQ10+1mWFUiKyWWlg+fooBr3xVis6Y541SvSnrA1istSUy40lZD6SPcMN9YxSKhxaRv7ob9NCabs1UO+kFsAZ3azNTpnwVECpyZn6eE80FPAlV/c7c8W41/0q5PRJsGRDlbAhK9zOvEeVSR0wbLRQIvYGnnGOkxsPaCJB0haTKEWV3mesec3jX5l4oQb2ns6lt9KqRUwjjV1gXW7buMmUbZBhK+L9gFnf2i3lEvsj5E9tIjDjkXgpSrBTkirkd+SjRMaCViCow+BgtunB289IOmVNz0YgbvksZ5b3ZjM0Q9aY6/JM/dGqXEVtYtXS0+DctqMxgrRfD9eJ52TgH2pc6TBKjwlFiy1qUHUiMuDmmEUbSwFFCHzMm9f/uJR/0XKDQjwZislYmzMUANl6KA3WgLaIW/kBWj2wSFWD2KQOLz612+ddzzqwO7+JArm6IAST6YA3sMbYGDzxziSuMVMjd10EnU7ft2wGSZig+uojmgsqJOMUiWP+aIi368RtQcKsRr27xJuE/RAQ6dTvtRv6pU8NcIy5tTdD5/tg3RPjSeY5sP/QFFQrSUt8ezgn9y8TDb5OJ8sAvJI72klwb5JlHTVsGSXRFY8nhRaAif7GCjOS1vN8EJefpVX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc558e5-5959-41f0-5c7e-08d88d91b9d0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 20:20:30.2118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/GOqH+Z0xpBb/TRbx8k0HHV9MYu+Nr6EAGDloMPfeyuqiM+etlMHhozkVigG0xOqRNKEw13aj7roL+eH3t6KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3717
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Aurabindo.Pillai@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Yongqiang Sun <yongqiang.sun@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why & How]
Get internal display info from vbios and pass it to dmub fw to determine
if multiple display optmization is needed.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    | 73 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  7 ++
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |  5 ++
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
 .../amd/display/include/bios_parser_types.h   |  5 ++
 drivers/gpu/drm/amd/include/atomfirmware.h    |  1 +
 6 files changed, 92 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 43922fa358a9..bb6b546ec6d9 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -65,6 +65,11 @@
 	GENERIC_OBJECT_ID_BRACKET_LAYOUT << OBJECT_ID_SHIFT)
 #endif /* GENERICOBJECT_BRACKET_LAYOUT_ENUM_ID2 */
 
+
+//TODO: Remove this temp define after atomfirmware.h is updated.
+#define  ATOM_DISP_CONNECTOR_CAPS_RECORD_TYPE 23
+
+
 #define DC_LOGGER \
 	bp->base.ctx->logger
 
@@ -1453,6 +1458,72 @@ static struct atom_encoder_caps_record *get_encoder_cap_record(
 	return NULL;
 }
 
+static struct atom_disp_connector_caps_record *get_disp_connector_caps_record(
+	struct bios_parser *bp,
+	struct atom_display_object_path_v2 *object)
+{
+	struct atom_common_record_header *header;
+	uint32_t offset;
+
+	if (!object) {
+		BREAK_TO_DEBUGGER(); /* Invalid object */
+		return NULL;
+	}
+
+	offset = object->disp_recordoffset + bp->object_info_tbl_offset;
+
+	for (;;) {
+		header = GET_IMAGE(struct atom_common_record_header, offset);
+
+		if (!header)
+			return NULL;
+
+		offset += header->record_size;
+
+		if (header->record_type == LAST_RECORD_TYPE ||
+				!header->record_size)
+			break;
+
+		if (header->record_type != ATOM_DISP_CONNECTOR_CAPS_RECORD_TYPE)
+			continue;
+
+		if (sizeof(struct atom_disp_connector_caps_record) <=
+							header->record_size)
+			return (struct atom_disp_connector_caps_record *)header;
+	}
+
+	return NULL;
+}
+
+static enum bp_result bios_parser_get_disp_connector_caps_info(
+	struct dc_bios *dcb,
+	struct graphics_object_id object_id,
+	struct bp_disp_connector_caps_info *info)
+{
+	struct bios_parser *bp = BP_FROM_DCB(dcb);
+	struct atom_display_object_path_v2 *object;
+	struct atom_disp_connector_caps_record *record = NULL;
+
+	if (!info)
+		return BP_RESULT_BADINPUT;
+
+	object = get_bios_object(bp, object_id);
+
+	if (!object)
+		return BP_RESULT_BADINPUT;
+
+	record = get_disp_connector_caps_record(bp, object);
+	if (!record)
+		return BP_RESULT_NORECORD;
+
+	info->INTERNAL_DISPLAY = (record->connectcaps & ATOM_CONNECTOR_CAP_INTERNAL_DISPLAY)
+									? 1 : 0;
+	info->INTERNAL_DISPLAY_BL = (record->connectcaps & ATOM_CONNECTOR_CAP_INTERNAL_DISPLAY_BL)
+											? 1 : 0;
+
+	return BP_RESULT_OK;
+}
+
 static enum bp_result get_vram_info_v23(
 	struct bios_parser *bp,
 	struct dc_vram_info *info)
@@ -2461,6 +2532,8 @@ static const struct dc_vbios_funcs vbios_funcs = {
 	.enable_lvtma_control = bios_parser_enable_lvtma_control,
 
 	.get_soc_bb_info = bios_parser_get_soc_bb_info,
+
+	.get_disp_connector_caps_info = bios_parser_get_disp_connector_caps_info,
 };
 
 static bool bios_parser2_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 5790affc7d61..311a0decd005 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1368,6 +1368,7 @@ static bool dc_link_construct(struct dc_link *link,
 	struct integrated_info info = {{{ 0 }}};
 	struct dc_bios *bios = init_params->dc->ctx->dc_bios;
 	const struct dc_vbios_funcs *bp_funcs = bios->funcs;
+	struct bp_disp_connector_caps_info disp_connect_caps_info = { 0 };
 
 	DC_LOGGER_INIT(dc_ctx->logger);
 
@@ -1388,6 +1389,12 @@ static bool dc_link_construct(struct dc_link *link,
 	link->link_id =
 		bios->funcs->get_connector_id(bios, init_params->connector_index);
 
+
+	if (bios->funcs->get_disp_connector_caps_info) {
+		bios->funcs->get_disp_connector_caps_info(bios, link->link_id, &disp_connect_caps_info);
+		link->is_internal_display = disp_connect_caps_info.INTERNAL_DISPLAY;
+	}
+
 	if (link->link_id.type != OBJECT_TYPE_CONNECTOR) {
 		dm_output_to_console("%s: Invalid Connector ObjectID from Adapter Service for connector index:%d! type %d expected %d\n",
 				     __func__, init_params->connector_index,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
index e146e3cba8eb..509d23fdd3c9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
@@ -144,6 +144,11 @@ struct dc_vbios_funcs {
 	enum bp_result (*get_soc_bb_info)(
 		struct dc_bios *dcb,
 		struct bp_soc_bb_info *soc_bb_info);
+
+	enum bp_result (*get_disp_connector_caps_info)(
+			struct dc_bios *dcb,
+			struct graphics_object_id object_id,
+			struct bp_disp_connector_caps_info *info);
 };
 
 struct bios_registers {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 65b083e64131..66445e34fd37 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -101,6 +101,7 @@ struct dc_link {
 	bool aux_access_disabled;
 	bool sync_lt_in_progress;
 	bool lttpr_non_transparent_mode;
+	bool is_internal_display;
 
 	/* caps is the same as reported_link_cap. link_traing use
 	 * reported_link_cap. Will clean up.  TODO
diff --git a/drivers/gpu/drm/amd/display/include/bios_parser_types.h b/drivers/gpu/drm/amd/display/include/bios_parser_types.h
index 7c782924c941..76a87b682883 100644
--- a/drivers/gpu/drm/amd/display/include/bios_parser_types.h
+++ b/drivers/gpu/drm/amd/display/include/bios_parser_types.h
@@ -309,6 +309,11 @@ struct bp_spread_spectrum_parameters {
 	struct spread_spectrum_flags flags;
 };
 
+struct bp_disp_connector_caps_info {
+	uint32_t INTERNAL_DISPLAY    : 1;
+	uint32_t INTERNAL_DISPLAY_BL : 1;
+};
+
 struct bp_encoder_cap_info {
 	uint32_t DP_HBR2_CAP:1;
 	uint32_t DP_HBR2_EN:1;
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 6139d10f4289..c38635992101 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -725,6 +725,7 @@ enum atom_object_record_type_id
   ATOM_ENCODER_CAP_RECORD_TYPE=20,
   ATOM_BRACKET_LAYOUT_RECORD_TYPE=21,
   ATOM_CONNECTOR_FORCED_TMDS_CAP_RECORD_TYPE=22,
+  ATOM_DISP_CONNECTOR_CAPS_RECORD_TYPE=23,
   ATOM_RECORD_END_TYPE  =0xFF,
 };
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
