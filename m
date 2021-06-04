Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233F8C4743C
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 18:16:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E02D16054E
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 18:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02D16054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97AC16F891;
	Fri,  4 Jun 2021 18:16:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 691716F890
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 18:16:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Py+gUKRUEy/M2BAz8TSBmbw+pexjc8OILqnAFhDQLDHfR6v/wYRxx9NQbMAxQUp1zDHZqRk2picBW48nreDBMpqn9d6S5ux8WhKJSorkQhgqfW4a/ziaR3pIq2WpUBx422L3eovmSTjCXo39NArxrQIWQ3Cuz1udYRP2xS6V2oWEvDFV+FFe6/fLJJ3fWlxuKxjL5hsMXRvCjWr18LQjKik3mWLkCZ7PeBkSrzxmO6WtJugsj71qe1IyRkfu7n5RFI91ZJRrBZ6iMa2E1L2G2b6spgQVPSGGEoYfQ83p6xWK5dpXNEsXx2ZkH1RCYjgiywPAFElUvRUzuVXJrIXYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdWQCxJhzgA3OCOnvvZomWCu7t5sWLt6v3V8Lu+m0Z4=;
 b=UAx/fzd74UPIiPlZ2lpArMk8Gncg8ou/oGOC4F9f5U0R2+5eU2gs3tozuGkuKmKVNHsWeGFD2DJ9NzrryTZ0E9EwBgT/Hy/GHv6FIEOcWzWxT/lJ0RT2l82f5/2DOnkNmbNjNlbgduZ22DjqhVkOX72tdiA36Z/C+L3JZdnSm+gCCUI+loK05gdgidiQN4gSz/NvUaiRLRzRylY9G7CMgQ70o280X3SBDm2dZEp8sbDc/3ICKKH3bYfjh7UB4eu+LrtxzuAkIMMZVKwB30nwEpYYmcrjInc2fe2QdWSAdA/WhrMlZVL+D+dk/greQgXq6cGy8EOs14FmLxV8FTRlRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdWQCxJhzgA3OCOnvvZomWCu7t5sWLt6v3V8Lu+m0Z4=;
 b=MRJ5+u/dEIFotX28QPa2cleS97c8MuaKRIn75vTYcBWKaRMNXPPTxRV9On/8ZBiW/clR8//49QoP2L0hpdyG1KbTJoulGpiGvVmeNGv56LnIdThQcYpkbrP0I8j9ouaFIo8BINbps40HgF3uK/HGkZzO4yWiHLrRaw0NCYGwiX8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 4 Jun
 2021 18:16:45 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%9]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 18:16:45 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/dc: fix DCN3.1 FP handling
Date: Fri,  4 Jun 2021 14:16:30 -0400
Message-Id: <20210604181630.1205152-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604181630.1205152-1-alexander.deucher@amd.com>
References: <20210604181630.1205152-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR19CA0013.namprd19.prod.outlook.com
 (2603:10b6:208:178::26) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR19CA0013.namprd19.prod.outlook.com (2603:10b6:208:178::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Fri, 4 Jun 2021 18:16:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcc2d5c4-077e-4d0c-f601-08d92784e925
X-MS-TrafficTypeDiagnostic: MN2PR12MB4488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44886E81415219763EECFBFAF73B9@MN2PR12MB4488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: afF33ljPipFbDNz1uMY8SJWzvSQux/UAM0hNnFp0eUKXt21YMK8h1ullpvaZvireeH2mKBkZSaFtgsJwkP85hLxdDWHXmDoYaILObMaTDkiu0z4qOZvKa6E4iPlO8DEh7QWVR5y5Tgmo0QrPjQYExFEMYHePjiPDrX6IxDTvLAB/t03JWFUiaCMqsN30VOS3XdYr8bpmZJiKJaXy35CGYmjmMuHLYVnVlZa5kLs7IHBNs93B9v8qAnsmXSt2XZgDqSe/vX5XyASWtwG0++CRGRXUIkiHCTDkSGQullYLSWz2x//lBbWfNtOgclNico4qoKrvIF5ITsZ5e8VthgNlUWm9L9XVNbc5727ToJydbdua3F4mqrIXlXPmI0yib105UPbi0fqqYVFzmxAfIfYxI9nGZVCW9WcByULKWn1rAMCYFAJ0IIkwx5EecbiUkBsBEfcXUZnw6rq7ZHhpX/pG2HbPLY42tZBKF9ZmdkxlFmYjfJpvHsD2fTQbaKH9D6OgZorJzLOxGTzM3EF9K7RK1K5hfGoZJUWCIccZq8H18RxnjuHrceQPg/hIscSPde7zW9tTbtQzfoSXdBG+96+gd6iATcfiE6yMWdVEC2ZS22+RKlY0aDMCA9xaRzOaJBedjMRAKZ5Tn/aZoKs2pbPShrQeek3DSJOfdYKRXB3PGqTF/+ITMdYm0k3mdZ48hq/E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(66556008)(6512007)(498600001)(38350700002)(38100700002)(8676002)(6506007)(1076003)(8936002)(52116002)(2616005)(956004)(16526019)(66946007)(83380400001)(2906002)(6916009)(26005)(186003)(6486002)(36756003)(5660300002)(6666004)(86362001)(4326008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?S7O4AspI1fKlhbjk5995D0xwNcMzk03ppJ6QQcpQS+ZHdiqGOoCnICyGGX+v?=
 =?us-ascii?Q?4w7qQ9Fziye6XUsgYFgu4zDfpE9boDNAinE2Sb00vIoyxKpiCmSfb5qB6Bb+?=
 =?us-ascii?Q?U7NuMHUdX80eovS+ZwB8gRXyJWWjDgm/OU/o9pd1M++7JzH78N7i/5uGe39N?=
 =?us-ascii?Q?wA9jusA/qoKoTEIu5zgCGCMosTybXNtVIIHw3uuc9nmXDoTvX1zmY5To3Fc+?=
 =?us-ascii?Q?+cHzJ2rbGmBy7pB6gBxCRcmZlmKJo5HX2IR/U7JsUR+sva7tSK9r9CHSJF83?=
 =?us-ascii?Q?4YrVHV8Gr6jFegoFFex6vpvnoKmibFRd22XoiDaaa/z+OwfAdZ2bPW2w1wkW?=
 =?us-ascii?Q?biJ04VfAv1LpLXakNTS3PPcuONWBYQq5km/WcOXEvhpp7ISlsHEOU0HM0GMj?=
 =?us-ascii?Q?NDGCmCwO9dA8Yt5FWD8QBMIeH+pkLU7KlyEwTT89ixL9YSOhU2ZN1wQ0o3Wj?=
 =?us-ascii?Q?RCEUmx7kF6MzXnaBad2TuuckbKG7/uh76Ea0HakFo7Cxou1TwOXzgCj4T+JC?=
 =?us-ascii?Q?oONr4DZCb8/bMk2ZDPbOQ7Eqc6ImdX73Jb7oIuyPbcHoHN73M1EedCurDXfc?=
 =?us-ascii?Q?nzHYdtIwRlWy9Pp9lKiHo7hHxzbHKoMTNQbKeuFoDvO3BIZlIWQGw+6PGUcK?=
 =?us-ascii?Q?F29TQ8uXKGb8bxNf+9sxo/2vpm3iLLRVuwH+OULKB2lLgL2xWrLaHvt9lm7y?=
 =?us-ascii?Q?zTi680PMrcNhGpuocnKwg8BgqZq4P+RnyGkZhN5D6VnKd1hmzkFdvpw2KWtC?=
 =?us-ascii?Q?BDQiAjUPpPmthW63S+K9nVUGH0AwTLl3MkT4Nbet3y2kNMg7Sv4V94yJ9KxZ?=
 =?us-ascii?Q?5T2890PD0Wu1CcyKbnLL8qtJccSd/U0ZLjRbwWqEnjZ1Igm5DGcCQdugxit5?=
 =?us-ascii?Q?17rMlGFGAjINbFhnce62dpuFho1tKNJxognd6qjIIPVk1BcqyxNO6DzEHWpE?=
 =?us-ascii?Q?7c6jkLIQXT7JMfO5+6KLTMjZ1mYyVmiTY52UkerLXbNuPWV6XOMQmbCVt4+X?=
 =?us-ascii?Q?sIVmqtFDjG4VnJrEpI2fKky/n/SuQV1mfCHY4njlmkkWxZ9RgnMJmUdgoaQg?=
 =?us-ascii?Q?Hxca6OxmClrX3gNOapnsYW/pSxjp92kZF9NAOc2QwCsfQyryHH80jtTCRzET?=
 =?us-ascii?Q?pDWQ/vU2xPOnPQfUeUahy7vQhOiyV1EoFf0eC5lo2RLJuArFLbDT8KswDyio?=
 =?us-ascii?Q?dg82wJ3hhuK+ya4e9pOnkq+5eOwJOiNkcdJmkwwORIJqKSEPm5uXtd4/fZkr?=
 =?us-ascii?Q?F8OhfKl719UFfW2kjJVumES77XtR+L2YJbu2W4Hz1tZIaUp1rSZa/59r+hYL?=
 =?us-ascii?Q?yGGVDg3iQA2o6MSR8YVhAmW0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc2d5c4-077e-4d0c-f601-08d92784e925
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 18:16:45.3109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhzXdPcko9+1M0CGaWRaScvXjxFDegpNB8wEgq4eu8/EOVDiLuprXmqdZ8FN7xjzLAL3VItFQRF8bJxXOucJ4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Missing proper DC_FP_START/DC_FP_END.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/dcn31/dcn31_resource.c  | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index af978d2cb25f..0d6cb6caad81 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1633,7 +1633,7 @@ static void dcn31_update_soc_for_wm_a(struct dc *dc, struct dc_state *context)
 	}
 }
 
-static void dcn31_calculate_wm_and_dlg(
+static void dcn31_calculate_wm_and_dlg_fp(
 		struct dc *dc, struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
 		int pipe_cnt,
@@ -1759,6 +1759,17 @@ static void dcn31_calculate_wm_and_dlg(
 	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
 }
 
+static void dcn31_calculate_wm_and_dlg(
+		struct dc *dc, struct dc_state *context,
+		display_e2e_pipe_params_st *pipes,
+		int pipe_cnt,
+		int vlevel)
+{
+	DC_FP_START();
+	dcn31_calculate_wm_and_dlg_fp(dc, context, pipes, pipe_cnt, vlevel);
+	DC_FP_END();
+}
+
 static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap
 };
@@ -1890,6 +1901,8 @@ static bool dcn31_resource_construct(
 	struct dc_context *ctx = dc->ctx;
 	struct irq_service_init_data init_data;
 
+	DC_FP_START();
+
 	ctx->dc_bios->regs = &bios_regs;
 
 	pool->base.res_cap = &res_cap_dcn31;
@@ -2152,10 +2165,13 @@ static bool dcn31_resource_construct(
 
 	dc->cap_funcs = cap_funcs;
 
+	DC_FP_END();
+
 	return true;
 
 create_fail:
 
+	DC_FP_END();
 	dcn31_resource_destruct(pool);
 
 	return false;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
