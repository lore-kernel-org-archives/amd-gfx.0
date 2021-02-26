Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAADFC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 22:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B17464ED5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 22:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B17464ED5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED6026E454;
	Fri, 26 Feb 2021 22:37:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D22BC6E454
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 22:37:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLXulGMZ0BzVj6lAVGcmg7TRFAld5IQ+N6h5u1FvlS6R1DoCp0g7CHOXKYKwstO7WxeovlPUJysI+RTS/24QoFM/9OsvEMLI+hoN+qOxQIBC/bC+7/84U6cbJXx973qDMcUimJMmKPR53br2UXYPZvcbcM3NMH9cFSrOgeTT9DTAeFGAzbo7OG9MJW3Rvv+/DYyUPKjpFqtkNGh5OKx2QMdF6iEn8glSgbWeI1oihhLThSi31IlSe0bVEm/PaP1fpS2PD3/2DC7tY4OmJToDp+saTjT/THr029Xvgbe/mxqpI9p5IbxH1WVDDn1WhPHN+IuT68i+/wsInZRdCaPbAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zVfT6lq/UmOdsb0DxiXQLvvwe2BTgXHULcrUTWJVm8=;
 b=A4oocThpmv2kgHd432YZsIHqXzNfBgYMweKw8PaCTTE096jL01hdtm0oYaDjV0IslJW+spRyCwcgm3mrVf7ngWssJh35ivAevWkMAM4cgJsif7im+2dl26HS5fJsCux+2qkTIdxtqn5qkvuv0kg5jaoNZDgNTD1zEH5v2otoJMFBwbtXaQ2VpGggDDk/P9xIwdt1Kw4v/NbqffwK9nsXnPihximOHp1AVQl/eARgfuV0n92gzUf/SLlTxvvdhSV7yYLFJwBmIupw603ZWqlJI80UtWlispm0OcXalNu0amWuudNj1Bk9DYsmBBqT2qDzFAUQ1qDABHQlEE3ntxznRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zVfT6lq/UmOdsb0DxiXQLvvwe2BTgXHULcrUTWJVm8=;
 b=kQPGi1CkYt9/9FVIGs6glIj1T5q7b5M9/wDWn2HeEpepDpK7Ak6VJbRAqfBe1m9puLVxvEb7D+kId70ZHBN/eVqHVaVW1AeHmKjYlNmhMOvlyUTz80QY0iNDST3puuF4k2idYY92X7BWq9TcUiCOWdu9j0JB48cYcF9QVzXU+Xo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM5PR12MB1883.namprd12.prod.outlook.com (2603:10b6:3:113::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Fri, 26 Feb 2021 22:37:49 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%7]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 22:37:49 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/11] drm/amd/display: Implement dmub trace event
Date: Fri, 26 Feb 2021 17:37:00 -0500
Message-Id: <20210226223704.400472-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210226223704.400472-1-Rodrigo.Siqueira@amd.com>
References: <20210226223704.400472-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:acb7:edb9:ffaa:d7cf]
X-ClientProxiedBy: BN9PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:408:fc::12) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:acb7:edb9:ffaa:d7cf)
 by BN9PR03CA0067.namprd03.prod.outlook.com (2603:10b6:408:fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend
 Transport; Fri, 26 Feb 2021 22:37:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7aef51dd-0cb8-4edd-afad-08d8daa72502
X-MS-TrafficTypeDiagnostic: DM5PR12MB1883:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1883F22C74F621591A3D7D80989D9@DM5PR12MB1883.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BBNHbsHiEx99tyVzG+cM0eZABaSA0uuqrxYssvz77wATwxFi98fYDodCvn0Yi2Smn+V/0TP7VGCMnD57+kgJjEw295Ld3i6WT3nF/mnBokkWzvlSL7DlnYS+j8qO5wPSDj7vSP/pKBTadTFqcUyKrk1QqV3v0jCejNRMwe80xinEembCOm68Qn2Lohu4cDD8WfEK80HCKucBbu6FZk2l7XUuXcHgBqpppNRht0GuEPf1T6YZT7EwFKO8tsjT13pKa7AR4LdrR+1wE0YSEnkyAQhQzF2ijNCwYQfuiRj7JF+KRAAa2sF2eeOcJHm2grmm6ZOBYHfpYm3VmqTSJ0mulfowANcn7YCu2h8H2S9PTu7k5u1Chfgo0EXh0yvE/IH5QUL1Jd4i7MIGLnRdrfamZS2pGcFVxQe9byUf9z1IAtRYAv6lHI8+raYey3aafOxYSZ7NyMpKzwSXol6n1n3GlyRvy6wypH+Ugj6qDs0tiKeX7S8+dFaaIZU0aGFwZwuNNIIcn2ciQ5RhP/aguRhnVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(2906002)(6916009)(2616005)(5660300002)(66946007)(316002)(16526019)(186003)(1076003)(54906003)(83380400001)(36756003)(6486002)(478600001)(66556008)(52116002)(4326008)(6506007)(66476007)(6512007)(8936002)(8676002)(6666004)(30864003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8p25sTx0RtHjVs2sSlnM2rz/U3A5qzRrwkT/EO6slTdL5dQSZHUkZE4btYOB?=
 =?us-ascii?Q?e1QPccdA+jIijHCho2N1MSATfwClNVrdmd2w5pTyk6HtU54C6qysD2YMopdC?=
 =?us-ascii?Q?fRF2M7VzBU2Xd1zmp0ojAVnlRj17T4wINb3D7503zl/TjRDBRmpdrEORkaBG?=
 =?us-ascii?Q?Bff3NHkyIUMP2M6PvZJriMeBb8ME9lkhPVwm4gMYyb4hIpVQBAaF2LPMNYAX?=
 =?us-ascii?Q?L2FTTkOM89iF5NoVmT2R3iNqvDKhDdc3QZVBEjgsu+m9UVAi+eCdyS6rH50p?=
 =?us-ascii?Q?2lmecccDYT47hAxoexG4/OEBXAJzeDyqSAUUpor6j+Wj4JsTWFQxbIIREtsX?=
 =?us-ascii?Q?DBh4JPakxxrNNCwXs1gcojR3ok1eVurLUabWHsiPTVAejI7BCKlBFMvgSXJj?=
 =?us-ascii?Q?tPhrDlFawe9XQNXn0sxo5w07n3jZQQTb5EEUqTNHPr/PxjaW+lWdTr/Nyu6k?=
 =?us-ascii?Q?owS9XkDSAJdqp4fVYbA5LX3gbnhnJyFm0DEimu+eH/TNtAdwU1y4sVQ/+AhL?=
 =?us-ascii?Q?od6WE92kxUZ3yvxd6NPSNf2dLCQoLqB25ymoFVspQd2LPp1QzH32u99vsEhm?=
 =?us-ascii?Q?mQ0jYYB0/0pHD8DX0fBSLPSXqeGQeXUn0+I4Sz8TcU1vg4gjrKecl+U1EPJQ?=
 =?us-ascii?Q?c3WQH2jO18Tabo12xNj2GNJxLHibzwWhSEyQ0GBJIwZ1IidPw2qT/tjK82JF?=
 =?us-ascii?Q?amP0LopaJ+jfKRqCSURuQNwZNHsGF0zmlgjI3z0/9lpCaT1TqS27ObDoJy27?=
 =?us-ascii?Q?G4dZ2qpEpnu4wOzoAErR4YpRQhGSS3ON+tnN8YLda7qCQVSVfF/1FPYgvPAV?=
 =?us-ascii?Q?g8F2ep1J7lfHxnn4GeKmm/YX1wDc23vxmY+g4BscCyncXvOotYf358hYfWjb?=
 =?us-ascii?Q?bKvS6+5MLRgCXy6m88buTSUk3NorbkRgRHcoXB06autypGevQB4OWXrYEJZq?=
 =?us-ascii?Q?bznXd1fRtQODjKni5TKdmsXj07FHYnSbbgc7VtwiIzXqrx6CX2zL7ozmuX5m?=
 =?us-ascii?Q?E06u8bPdZh6CVkM+h2QH+IVySiSe+gGCMIXi7Jz8WpsQGtXE9e3Y0rfG0Wfh?=
 =?us-ascii?Q?GTTwn4DYFO3rqSCHzyLmSvdXXTA1xAKfQfv76WPjTxjw5txrco2zTeXeVxyg?=
 =?us-ascii?Q?RQfIjoTD/pnQxH1HUHcdLs+YCrLEcXM92L32n0u+9IMnOX6R4CGk4NMoU/+s?=
 =?us-ascii?Q?Gy1K5mE/aTvHc2yCBvE3QY4xrlDsws9JRfqHOOTHJklS06KsGDyk1+w1pX95?=
 =?us-ascii?Q?oNx75kBjw/+vRgxHEUzAaWDOVf5fxSgRa3UCEQz0f/EnczFLXsduOvQ2Lba5?=
 =?us-ascii?Q?j0NDn0C3hDtNQioWoS4zbdArydmsIEmsGP3VtVB2+6REjFunjSO+U20oQL8j?=
 =?us-ascii?Q?6l2vdNauIl6jmwZn1EwnQWJfVTDa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aef51dd-0cb8-4edd-afad-08d8daa72502
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 22:37:49.1550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWGBR97yjOMBUiasmDfs+qMiDpovhd6yD+4hTccoNGCKNt4LwceTXNlzLZ8/aOqsMcDaP5GRHf1cc3lZQNqGxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1883
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Yongqiang Sun <yongqiang.sun@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why & How]
DMUB FW send trace event via outbox0 interrupt.  Driver will handle it.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  6 +++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 16 +++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  6 +++
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  2 +
 drivers/gpu/drm/amd/display/dc/irq_types.h    |  1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 14 ++++++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  3 ++
 .../amd/display/dmub/inc/dmub_trace_buffer.h  |  3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c | 18 +++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h | 17 ++++++-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 48 ++++++++++++++++++-
 11 files changed, 128 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 5159399f8239..618c70f95573 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -663,3 +663,9 @@ void dm_helpers_free_gpu_mem(
 {
 	// TODO
 }
+
+bool dm_helpes_dmub_outbox0_interrupt_control(struct dc_context *ctx, bool enable)
+{
+	// TODO
+	return true;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 421af1a19dfa..b9d8cfef0a1a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -26,6 +26,7 @@
 #include "dc.h"
 #include "dc_dmub_srv.h"
 #include "../dmub/dmub_srv.h"
+#include "dm_helpers.h"
 
 #define CTX dc_dmub_srv->ctx
 #define DC_LOGGER CTX->logger
@@ -170,3 +171,18 @@ bool dc_dmub_srv_notify_stream_mask(struct dc_dmub_srv *dc_dmub_srv,
 		       dmub, DMUB_GPINT__IDLE_OPT_NOTIFY_STREAM_MASK,
 		       stream_mask, timeout) == DMUB_STATUS_OK;
 }
+
+enum dmub_status dc_dmub_srv_get_dmub_outbox0_msg(const struct dc *dc, struct dmcub_trace_buf_entry *entry)
+{
+	struct dmub_srv *dmub = dc->ctx->dmub_srv->dmub;
+	enum dmub_status status;
+
+	status = dmub_srv_get_outbox0_msg(dmub, entry);
+
+	return status;
+}
+
+void dc_dmub_trace_event_control(struct dc *dc, bool enable)
+{
+	dm_helpes_dmub_outbox0_interrupt_control(dc->ctx, enable);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index d76f9f2410cb..eefec9cc21a8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -30,6 +30,7 @@
 #include "dmub/dmub_srv.h"
 
 struct dmub_srv;
+struct dc;
 
 struct dc_reg_helper_state {
 	bool gather_in_progress;
@@ -60,4 +61,9 @@ bool dc_dmub_srv_cmd_with_reply_data(struct dc_dmub_srv *dc_dmub_srv, union dmub
 
 bool dc_dmub_srv_notify_stream_mask(struct dc_dmub_srv *dc_dmub_srv,
 				    unsigned int stream_mask);
+
+enum dmub_status dc_dmub_srv_get_dmub_outbox0_msg(const struct dc *dc, struct dmcub_trace_buf_entry *entry);
+
+void dc_dmub_trace_event_control(struct dc *dc, bool enable);
+
 #endif /* _DMUB_DC_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index 07e349b1067b..65704f46c79b 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -156,4 +156,6 @@ void dm_set_dcn_clocks(
 		struct dc_context *ctx,
 		struct dc_clocks *clks);
 
+bool dm_helpes_dmub_outbox0_interrupt_control(struct dc_context *ctx, bool enable);
+
 #endif /* __DM_HELPERS__ */
diff --git a/drivers/gpu/drm/amd/display/dc/irq_types.h b/drivers/gpu/drm/amd/display/dc/irq_types.h
index 125b9beb505a..ae8f47ec0f8c 100644
--- a/drivers/gpu/drm/amd/display/dc/irq_types.h
+++ b/drivers/gpu/drm/amd/display/dc/irq_types.h
@@ -151,6 +151,7 @@ enum dc_irq_source {
 	DC_IRQ_SOURCE_DC5_VLINE1,
 	DC_IRQ_SOURCE_DC6_VLINE1,
 	DC_IRQ_DMCUB_OUTBOX1,
+	DC_IRQ_SOURCE_DMCUB_OUTBOX0,
 
 	DAL_IRQ_SOURCES_NUMBER
 };
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 6e4f558fe97e..16d1976b041f 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -74,6 +74,8 @@ extern "C" {
 struct dmub_srv;
 struct dmub_srv_common_regs;
 
+struct dmcub_trace_buf_entry;
+
 /* enum dmub_status - return code for dmcub functions */
 enum dmub_status {
 	DMUB_STATUS_OK = 0,
@@ -272,6 +274,13 @@ struct dmub_srv_hw_funcs {
 
 	void (*set_outbox1_rptr)(struct dmub_srv *dmub, uint32_t rptr_offset);
 
+	void (*setup_outbox0)(struct dmub_srv *dmub,
+			      const struct dmub_region *outbox0);
+
+	uint32_t (*get_outbox0_wptr)(struct dmub_srv *dmub);
+
+	void (*set_outbox0_rptr)(struct dmub_srv *dmub, uint32_t rptr_offset);
+
 	uint32_t (*emul_get_inbox1_rptr)(struct dmub_srv *dmub);
 
 	void (*emul_set_inbox1_wptr)(struct dmub_srv *dmub, uint32_t wptr_offset);
@@ -295,6 +304,7 @@ struct dmub_srv_hw_funcs {
 			       union dmub_gpint_data_register reg);
 
 	uint32_t (*get_gpint_response)(struct dmub_srv *dmub);
+
 };
 
 /**
@@ -360,6 +370,8 @@ struct dmub_srv {
 	 */
 	struct dmub_rb outbox1_rb;
 
+	struct dmub_rb outbox0_rb;
+
 	bool sw_init;
 	bool hw_init;
 
@@ -655,6 +667,8 @@ enum dmub_status dmub_srv_get_fw_boot_status(struct dmub_srv *dmub,
 enum dmub_status dmub_srv_cmd_with_reply_data(struct dmub_srv *dmub,
 					      union dmub_rb_cmd *cmd);
 
+enum dmub_status dmub_srv_get_outbox0_msg(struct dmub_srv *dmub, struct dmcub_trace_buf_entry *entry);
+
 #if defined(__cplusplus)
 }
 #endif
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 63111351d1e3..7100089bf7df 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -79,6 +79,9 @@
 /* Maximum number of planes on any ASIC. */
 #define DMUB_MAX_PLANES 6
 
+/* Trace buffer offset for entry */
+#define TRACE_BUFFER_ENTRY_OFFSET  16
+
 #ifndef PHYSICAL_ADDRESS_LOC
 #define PHYSICAL_ADDRESS_LOC union large_integer
 #endif
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_trace_buffer.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_trace_buffer.h
index 6b3ee42db350..8a122ceabb3a 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_trace_buffer.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_trace_buffer.h
@@ -25,7 +25,7 @@
 #ifndef _DMUB_TRACE_BUFFER_H_
 #define _DMUB_TRACE_BUFFER_H_
 
-#include "dmub_types.h"
+#include "dmub_cmd.h"
 
 #define LOAD_DMCU_FW	1
 #define LOAD_PHY_FW	2
@@ -65,5 +65,4 @@ struct dmcub_trace_buf {
 	struct dmcub_trace_buf_entry entries[PERF_TRACE_MAX_ENTRY];
 };
 
-
 #endif /* _DMUB_TRACE_BUFFER_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index 071331bcc427..6934906c665e 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -319,6 +319,24 @@ void dmub_dcn20_set_outbox1_rptr(struct dmub_srv *dmub, uint32_t rptr_offset)
 	REG_WRITE(DMCUB_OUTBOX1_RPTR, rptr_offset);
 }
 
+void dmub_dcn20_setup_outbox0(struct dmub_srv *dmub,
+			      const struct dmub_region *outbox0)
+{
+	REG_WRITE(DMCUB_OUTBOX0_BASE_ADDRESS, outbox0->base);
+
+	REG_WRITE(DMCUB_OUTBOX0_SIZE, outbox0->top - outbox0->base);
+}
+
+uint32_t dmub_dcn20_get_outbox0_wptr(struct dmub_srv *dmub)
+{
+	return REG_READ(DMCUB_OUTBOX0_WPTR);
+}
+
+void dmub_dcn20_set_outbox0_rptr(struct dmub_srv *dmub, uint32_t rptr_offset)
+{
+	REG_WRITE(DMCUB_OUTBOX0_RPTR, rptr_offset);
+}
+
 bool dmub_dcn20_is_hw_init(struct dmub_srv *dmub)
 {
 	uint32_t is_hw_init;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
index df85c3b86607..de5351cd5abc 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
@@ -40,6 +40,10 @@ struct dmub_srv;
 	DMUB_SR(DMCUB_INBOX1_SIZE) \
 	DMUB_SR(DMCUB_INBOX1_RPTR) \
 	DMUB_SR(DMCUB_INBOX1_WPTR) \
+	DMUB_SR(DMCUB_OUTBOX0_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_OUTBOX0_SIZE) \
+	DMUB_SR(DMCUB_OUTBOX0_RPTR) \
+	DMUB_SR(DMCUB_OUTBOX0_WPTR) \
 	DMUB_SR(DMCUB_OUTBOX1_BASE_ADDRESS) \
 	DMUB_SR(DMCUB_OUTBOX1_SIZE) \
 	DMUB_SR(DMCUB_OUTBOX1_RPTR) \
@@ -102,7 +106,8 @@ struct dmub_srv;
 	DMUB_SR(CC_DC_PIPE_DIS) \
 	DMUB_SR(MMHUBBUB_SOFT_RESET) \
 	DMUB_SR(DCN_VM_FB_LOCATION_BASE) \
-	DMUB_SR(DCN_VM_FB_OFFSET)
+	DMUB_SR(DCN_VM_FB_OFFSET) \
+	DMUB_SR(DMCUB_INTERRUPT_ACK)
 
 #define DMUB_COMMON_FIELDS() \
 	DMUB_SF(DMCUB_CNTL, DMCUB_ENABLE) \
@@ -135,7 +140,8 @@ struct dmub_srv;
 	DMUB_SF(CC_DC_PIPE_DIS, DC_DMCUB_ENABLE) \
 	DMUB_SF(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET) \
 	DMUB_SF(DCN_VM_FB_LOCATION_BASE, FB_BASE) \
-	DMUB_SF(DCN_VM_FB_OFFSET, FB_OFFSET)
+	DMUB_SF(DCN_VM_FB_OFFSET, FB_OFFSET) \
+	DMUB_SF(DMCUB_INTERRUPT_ACK, DMCUB_OUTBOX0_READY_INT_ACK)
 
 struct dmub_srv_common_reg_offset {
 #define DMUB_SR(reg) uint32_t reg;
@@ -196,6 +202,13 @@ uint32_t dmub_dcn20_get_outbox1_wptr(struct dmub_srv *dmub);
 
 void dmub_dcn20_set_outbox1_rptr(struct dmub_srv *dmub, uint32_t rptr_offset);
 
+void dmub_dcn20_setup_outbox0(struct dmub_srv *dmub,
+			      const struct dmub_region *outbox0);
+
+uint32_t dmub_dcn20_get_outbox0_wptr(struct dmub_srv *dmub);
+
+void dmub_dcn20_set_outbox0_rptr(struct dmub_srv *dmub, uint32_t rptr_offset);
+
 bool dmub_dcn20_is_hw_init(struct dmub_srv *dmub);
 
 bool dmub_dcn20_is_supported(struct dmub_srv *dmub);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 6943bf679b42..eb9bf4da088a 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -31,6 +31,7 @@
 #include "dmub_dcn301.h"
 #include "dmub_dcn302.h"
 #include "os_types.h"
+#include "dmub_trace_buffer.h"
 /*
  * Note: the DMUB service is standalone. No additional headers should be
  * added below or above this line unless they reside within the DMUB
@@ -55,6 +56,7 @@
 /* Default tracebuffer size if meta is absent. */
 #define DMUB_TRACE_BUFFER_SIZE (64 * 1024)
 
+
 /* Default scratch mem size. */
 #define DMUB_SCRATCH_MEM_SIZE (256)
 
@@ -69,6 +71,8 @@
 #define DMUB_CW5_BASE (0x65000000)
 #define DMUB_CW6_BASE (0x66000000)
 
+#define DMUB_REGION5_BASE (0xA0000000)
+
 static inline uint32_t dmub_align(uint32_t val, uint32_t factor)
 {
 	return (val + factor - 1) / factor * factor;
@@ -162,6 +166,11 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 		funcs->get_outbox1_wptr = dmub_dcn20_get_outbox1_wptr;
 		funcs->set_outbox1_rptr = dmub_dcn20_set_outbox1_rptr;
 
+		//outbox0 call stacks
+		funcs->setup_outbox0 = dmub_dcn20_setup_outbox0;
+		funcs->get_outbox0_wptr = dmub_dcn20_get_outbox0_wptr;
+		funcs->set_outbox0_rptr = dmub_dcn20_set_outbox0_rptr;
+
 		if (asic == DMUB_ASIC_DCN21) {
 			dmub->regs = &dmub_srv_dcn21_regs;
 
@@ -400,9 +409,9 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 	struct dmub_fb *fw_state_fb = params->fb[DMUB_WINDOW_6_FW_STATE];
 	struct dmub_fb *scratch_mem_fb = params->fb[DMUB_WINDOW_7_SCRATCH_MEM];
 
-	struct dmub_rb_init_params rb_params;
+	struct dmub_rb_init_params rb_params, outbox0_rb_params;
 	struct dmub_window cw0, cw1, cw2, cw3, cw4, cw5, cw6;
-	struct dmub_region inbox1, outbox1;
+	struct dmub_region inbox1, outbox1, outbox0;
 
 	if (!dmub->sw_init)
 		return DMUB_STATUS_INVALID;
@@ -465,6 +474,10 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 		cw5.region.base = DMUB_CW5_BASE;
 		cw5.region.top = cw5.region.base + tracebuff_fb->size;
 
+		outbox0.base = DMUB_REGION5_BASE + TRACE_BUFFER_ENTRY_OFFSET;
+		outbox0.top = outbox0.base + sizeof(struct dmcub_trace_buf_entry) * PERF_TRACE_MAX_ENTRY;
+
+
 		cw6.offset.quad_part = fw_state_fb->gpu_addr;
 		cw6.region.base = DMUB_CW6_BASE;
 		cw6.region.top = cw6.region.base + fw_state_fb->size;
@@ -477,6 +490,9 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 			dmub->hw_funcs.setup_windows(dmub, &cw2, &cw3, &cw4,
 						     &cw5, &cw6);
 
+		if (dmub->hw_funcs.setup_outbox0)
+			dmub->hw_funcs.setup_outbox0(dmub, &outbox0);
+
 		if (dmub->hw_funcs.setup_mailbox)
 			dmub->hw_funcs.setup_mailbox(dmub, &inbox1);
 		if (dmub->hw_funcs.setup_out_mailbox)
@@ -499,6 +515,12 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 
 	}
 
+	dmub_memset(&outbox0_rb_params, 0, sizeof(outbox0_rb_params));
+	outbox0_rb_params.ctx = dmub;
+	outbox0_rb_params.base_address = (void *)((uint64_t)(tracebuff_fb->cpu_addr) + TRACE_BUFFER_ENTRY_OFFSET);
+	outbox0_rb_params.capacity = sizeof(struct dmcub_trace_buf_entry) * PERF_TRACE_MAX_ENTRY;
+	dmub_rb_init(&dmub->outbox0_rb, &outbox0_rb_params);
+
 	if (dmub->hw_funcs.reset_release)
 		dmub->hw_funcs.reset_release(dmub);
 
@@ -697,3 +719,25 @@ enum dmub_status dmub_srv_cmd_with_reply_data(struct dmub_srv *dmub,
 
 	return status;
 }
+
+static inline void dmub_rb_out_trace_buffer_front(struct dmub_rb *rb,
+				 void *entry)
+{
+	const uint64_t *src = (const uint64_t *)(rb->base_address) + rb->rptr / sizeof(uint64_t);
+	uint64_t *dst = (uint64_t *)entry;
+	uint8_t i;
+
+	// copying data
+	for (i = 0; i < sizeof(struct dmcub_trace_buf_entry) / sizeof(uint64_t); i++)
+		*dst++ = *src++;
+
+}
+
+enum dmub_status dmub_srv_get_outbox0_msg(struct dmub_srv *dmub, struct dmcub_trace_buf_entry *entry)
+{
+	dmub->outbox0_rb.wrpt = dmub->hw_funcs.get_outbox0_wptr(dmub);
+
+	dmub_rb_out_trace_buffer_front(&dmub->outbox0_rb, (void *)entry);
+
+	return DMUB_STATUS_OK;
+}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
