Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A365AC4709C
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 755A961C39
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755A961C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40C946EDE4;
	Wed,  2 Jun 2021 16:51:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 508876EDDC
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:51:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pp1JZwOP0+Q3bfoKEeETw04+5E5pybZa/guUBCaqbv8btoyzjnxp4QgrzgYIPQKTdNwI6zysM8b8JZfQowPI/L9OEM7PTYFeDtjOex2/mcGXi+sQytAhzRzM3lIp9Youir4S3eCpqkYk10XcRfm9KlnByBvW4Bl7HTjyIW1Jtp4xuoh9C/zX088w6TazYx8wE5THfFbiW/gp7ZRULtAj7pJ84k5DDuw5y8aIRdOnueG1hSUbodFm87a/8fQxtiPOiShnfLqp2YpqZEPhAhUIsOefXFkUKpRKD6D1m9vF8YfOOYcRuiH3tCg1vqS9ERsetd9E+xWGzZsADW+fSNtI1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8seX4hb8cdeIKEbq7scrgN93gPOrNBIYmaBd+OxATzY=;
 b=iP2TRrw0/2fR1sN75afo2ng5A68lpSb8+LRurPJV9aWo9q2uIVjoV7QuQAAi7CamX7FBMreXJquoFFhDbgE4PJ/ubguMjWFmnCG+nVGMSechzy0q7GQUA/eBTX+sV3eSmTJj1eHZJyZJfO6VPkPHtkYAQohrgd2g1PVq+CLZeHM3zfpe1qWjhODeZED1itqKuFIK8mCcQ4bWVEPG6srfyxhoNFcsmA7ZwHUGunOEwKYKjZxS61uu01ZDlPubizZuh14IZWx5Irseez9P6T1D70wpUer8PT5YVwVfoOUMg5iQ2XL1rCKukqIj8UsjLtnt9sI2myVbkPtnUxRPHIrcmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8seX4hb8cdeIKEbq7scrgN93gPOrNBIYmaBd+OxATzY=;
 b=fJvuF8yWs9e1qIOZ6UR0Z/YWFdAY1Eun8GpX80tAqZtIztP7iNCXxJHHZCUoZ7THQGwWNxw0G7DaugOn/ymRztevPsAPO/2WrDVBdri3Jf7Um3oglcAyb6o8hY9pcA+GLAxGuYJJFwSgTY+9Oyp0Uu9dVTgSdTzvj17Eve4B7Ps=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2434.namprd12.prod.outlook.com (2603:10b6:207:4d::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:51:24 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:51:24 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 84/89] drm/amd/display: Add z10 restore checks for DC
 interfaces
Date: Wed,  2 Jun 2021 12:49:03 -0400
Message-Id: <20210602164908.2848791-84-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:50:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cca30a8d-7c52-462e-ca68-08d925e684f7
X-MS-TrafficTypeDiagnostic: BL0PR12MB2434:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2434D8FCBB3E85FC390721F0F73D9@BL0PR12MB2434.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fEKJf9CuFTnfqpdmocn+qtfZqBPCEEgWbfUMcqZ2e1nD08ml72pJGY4pAC7caghf3YRiOl2N8UXItxjyaebsyrQ2mt4KJ4E+o98CQOYPogrPXYe6wDaMhuMJpGcbbSJglBaYa2QoPHNHj0Oy8lILfsElCM1+MkQCUot19lm4tLw19X9rr7AGbEalkjNyyzrYvkCkhaWMB63p/ji5mSIonNFNUlx9dIxxBJEjuJQoVHAA25wPm+53CY6fno+m00npUw+/TNWpGZf5QfMPYp8/ikrtfzZ/19SFrvuTfjJlQUSFFY3fA1TjeJPeeLOr3L9anBa+wqjWco1T8efu2nRKFmH/633VEEnfAS99VAwbKy9qCjD1AqBWlbhqf85l7NR1DweMycCB0/63tRL6fkMvmTXVVJsTPLGiyRQklGQdDdS+eEa1tCEPU5ktwjVM8z5ryDdBPrKqpZom6Ct0DCI/De3oCYeU5OeMJFZjR5LEvArCTYR0JUNGmxtIrdEeRHLYqnzu6GzRZ+0fYCba6i8tHSdYrWC+evdXOFSQwqCQMLAKyyba3MoYHBAECu2ZS9wc//62dAXlQZGgr/GEYCT6jCgRjOnwPEQA4l3cMPQVTMlrfqSjzwjytx0jUC/OFdE3BenPYgJ7DoAkRsvwafFCBfwqLPgXYgI8Tc0hBrr8b+q8LDMRpmJUq5Qxz6lBCyeu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(52116002)(6486002)(6916009)(66476007)(66556008)(316002)(66946007)(36756003)(54906003)(86362001)(5660300002)(16526019)(186003)(6506007)(6512007)(26005)(6666004)(83380400001)(1076003)(8676002)(956004)(4326008)(2616005)(478600001)(38350700002)(38100700002)(2906002)(8936002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1Tyyo+SrX27H9IFe0lw2JsuZjtPJeKTIfs7N+aBRbdrDH26pST7k7+BDUNXL?=
 =?us-ascii?Q?ABRv5op4gX0IRMwrRgAvyygo1FkumEQEQ5BqJjoNg/qjiCu2W7ild6LSAEMY?=
 =?us-ascii?Q?auasgWTXNl9JlI0rx2rjulvySxxDTa/u8w9GbfIj8jFyft+Y2lW3OEZ8Yhrs?=
 =?us-ascii?Q?C7cfhY95Gb7A0ofxAqERnDTBGwTm9CK3huTB0SHQmlrEZAUqsfudqlcUjWzQ?=
 =?us-ascii?Q?nQHmMBZawM8TYvOhj9mGCqqzpLIGPmwICZHY5GB9mAaWTI0PlMKUI1qFDlhZ?=
 =?us-ascii?Q?MxKczrf7Wmdg1TUnNd7ObjAkxYJ78keLZVgIqR4OMpxEc/BKLn4lcuBfXlik?=
 =?us-ascii?Q?I0A4jSt3LeQyOKSX0RelXlkfodB3GWcpJzTlW5D8njjTkimnjY4eFivYzLLT?=
 =?us-ascii?Q?I0QtAf6RTj6naLqrZR2u8wjliQ3eu8KNezJ1jeCI0S49KHzENAgAiyR+ocsP?=
 =?us-ascii?Q?keQu5XT6wQbFHNpAuTPtMYOh9Vz0q4fNQoHH/TQ1zNmRNG2YEDd4lcNPrxbj?=
 =?us-ascii?Q?KU13C9eOhbBSWZlVM/3LGbq9tv2TOf7xD270DKdiKqeGO6qhWxYR7oDrRkUC?=
 =?us-ascii?Q?vqElwZ6IqbKe6qpEy59tUH5BWpr5T8vGt1/NfbT+ve7LaqApydTsn5XHU4NG?=
 =?us-ascii?Q?YBuFPS+lmoIz/5X60sNfLTATWWxn2DMO53DNGArVKPtnjSX58azE+K7Hai8d?=
 =?us-ascii?Q?EFjkde8/xajBd/kR0K1T/rfbsT3dEr0bKdIwA3oGSnnqa55PXiuQagUSXfrk?=
 =?us-ascii?Q?i8Lvnk4JoQ/IxSNJCyiPPNx478W+75QWLiYv064GU40673M20JFuSsAIVAIh?=
 =?us-ascii?Q?W0L0laUxIFgJJSlZKHE8YG/SxbSyr8g1morwqErCEuO1TnAaZkOeB7jMKYB4?=
 =?us-ascii?Q?8b5uBcan5IOLYiYEbXLxVJ4cQvJBdHtFkopYOmXjJkJvRgZRQbiiw3VdxTq5?=
 =?us-ascii?Q?S64bGVua/RVktuNc7G1nX5fTcJLADUVyWvNT45Cxo/h385pfGokDrCvB82ns?=
 =?us-ascii?Q?9yzIkiVNav3WBcoCbEIDHWZUjdR4cl5cW9ey374tptDKZL3nkd1vGNF1aVF0?=
 =?us-ascii?Q?N9UcLmwjEKfkX/Ce0p9pQ23xYF7zOviPcO7qJ29wOID8cM1KRU3rrwMgn+5q?=
 =?us-ascii?Q?VIc9ISfU0LFgDs+n15bk0vh7ky/kP5rHbxK6+031/AaqRRryKskHCX1KgSnv?=
 =?us-ascii?Q?7dF3pxXMERFLs+Y9GY1tWLlpQcPSReR1WvSp4wo7gP+EngLDe93KlbkTYlM/?=
 =?us-ascii?Q?amTzD43U8gk64Z1VuoH0XP9H6gmJQoUUX9Hbo3cSzLKA3v5ipqEEIOIRzQCo?=
 =?us-ascii?Q?u+ZUsgIJl6Jhx+zXQ2K2Lz4Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca30a8d-7c52-462e-ca68-08d925e684f7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:25.4845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rIP07/2E9BgnWU2kwjoSqj2OyA1ggqrLEL6CuP6uJm/dsmla5H3XWTtNgfrfzX6JXkTyYN9OKIdIrodv1uguQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2434
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

DMCUB has a deferred z10 restore process that needs signalling from
driver to occur. This needs to be done on any interface that programs
the hardware state or sequences where we expect to have the same
hardware state as before.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c        | 17 +++++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c   |  4 ++++
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c |  6 ++++++
 drivers/gpu/drm/amd/display/dc/dc.h             |  3 +++
 4 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f03889b3654b..7017db800718 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1482,6 +1482,13 @@ static uint8_t get_stream_mask(struct dc *dc, struct dc_state *context)
 	return stream_mask;
 }
 
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+void dc_z10_restore(struct dc *dc)
+{
+	if (dc->hwss.z10_restore)
+		dc->hwss.z10_restore(dc);
+}
+#endif
 /*
  * Applies given context to HW and copy it into current context.
  * It's up to the user to release the src context afterwards.
@@ -1495,6 +1502,9 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	struct dc_stream_state *dc_streams[MAX_STREAMS] = {0};
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	dc_z10_restore(dc);
+#endif
 	dc_allow_idle_optimizations(dc, false);
 #endif
 
@@ -2569,6 +2579,10 @@ static void commit_planes_for_stream(struct dc *dc,
 	int i, j;
 	struct pipe_ctx *top_pipe_to_program = NULL;
 
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	dc_z10_restore(dc);
+#endif
+
 	if (get_seamless_boot_stream_count(context) > 0 && surface_count > 0) {
 		/* Optimize seamless boot flag keeps clocks and watermarks high until
 		 * first flip. After first flip, optimization is required to lower
@@ -3024,6 +3038,9 @@ void dc_set_power_state(
 	case DC_ACPI_CM_POWER_STATE_D0:
 		dc_resource_state_construct(dc, dc->current_state);
 
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+		dc_z10_restore(dc);
+#endif
 		if (dc->ctx->dmub_srv)
 			dc_dmub_srv_wait_phy_init(dc->ctx->dmub_srv);
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 31ba40746a2f..6e93e6aed8ff 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2706,6 +2706,10 @@ bool dc_link_set_psr_allow_active(struct dc_link *link, bool allow_active,
 		return false;
 
 	link->psr_settings.psr_allow_active = allow_active;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	if (!allow_active)
+		dc_z10_restore(dc);
+#endif
 
 	if (psr != NULL && link->psr_settings.psr_feature_enabled) {
 		if (force_static && psr->funcs->psr_force_static)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 25fa712a7847..5420fda47bb7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -294,6 +294,9 @@ bool dc_stream_set_cursor_attributes(
 	stream->cursor_attributes = *attributes;
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	dc_z10_restore(dc);
+#endif
 	/* disable idle optimizations while updating cursor */
 	if (dc->idle_optimizations_allowed) {
 		dc_allow_idle_optimizations(dc, false);
@@ -355,6 +358,9 @@ bool dc_stream_set_cursor_position(
 	dc = stream->ctx->dc;
 	res_ctx = &dc->current_state->res_ctx;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	dc_z10_restore(dc);
+#endif
 
 	/* disable idle optimizations if enabling cursor */
 	if (dc->idle_optimizations_allowed && !stream->cursor_position.enable && position->enable) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ba47979c9cb0..05aae1419812 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1326,6 +1326,9 @@ void dc_hardware_release(struct dc *dc);
 #endif
 
 bool dc_set_psr_allow_active(struct dc *dc, bool enable);
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+void dc_z10_restore(struct dc *dc);
+#endif
 
 bool dc_enable_dmub_notifications(struct dc *dc);
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
