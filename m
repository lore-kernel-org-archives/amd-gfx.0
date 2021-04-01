Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC71EC433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A896D6138E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A896D6138E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DB756ECE5;
	Thu,  1 Apr 2021 16:46:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18E706ECE6
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 16:46:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNZt9KZ0XTIzurFWe8awTbGFzNgVQAOwm8GkMx07fwvaDAuHmDAFGbPamY4rhghvt9UdfgfAR9TkeHDwbE+x+JAgvvODa+MVFMHef02GfCtCiVnupIiUnutaiXExh8aYa43rngnJVUdaCXag8aa2jcNAa8ATvvE1kjsgAU/T2LZeIjL8+6L7Us2nYoRyi3fp3HzYI0tTHPJTP03EeGyCGiFgFaoEJM/u0V2u65iCjoGVIyEcMqRJM2dvjxdJqjA42DHeE9RFeSwRgrDyZCRfBhqZ7fi0hVHLuXt2Ip4ysDyObpJk2ycrq/pd63bfk8iCZG2k77qIlMjqHABbtYmZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6+ad16Ia1cy4A60gkIbCIp2XuXDUABybby6NEnps1M=;
 b=RvNPLeRaIcPSB89RBlWSaOuJIjWo0yCOuGe+s7i7Qa1CYwUMuWnmy6nhSmW4f3fFMtjIZFBakzyDrPjk/DShsbFfCcl41deUEB53JSa96Sk4s74tVOVyqprMyKNwGkK09HivtL18ZXU32PfuxpdCiSW2BjH6qRZtTVs6GDYcAcNwCjMiaQfQt5O3hCHuFF+0zTqWfdmfY6IsCisNgByeDutMwyVXes1iaREkkFYh42pVT5cXJV7Mubde2alDDvWV4ClgHTpkvRefUpDarR032ef5CUJppfZQmHDTHVWjoT3/nU2iWDAKPk+5f6iybOiKNM2r1SQ1HH6ngalVxUJnFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6+ad16Ia1cy4A60gkIbCIp2XuXDUABybby6NEnps1M=;
 b=XFV9KV+aoCEEn6ucZspAOHdkvJ2LdsPp/I6lbfKdDwT7W3AYwms/Fk52Ai3jIErWOt29MpnVFbRZkY3ptN06YuCMtS/bZDyOion6+rqEvk33HBsSxQ78YWA7efggE58sC+C8lnTw513nHfBG1WoAcWvS2UXJ3VQaWcdQNplQzpA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4619.namprd12.prod.outlook.com (2603:10b6:5:7c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 1 Apr
 2021 16:46:01 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 16:46:01 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/21] drm/amd/display: Added dc_edp_id_count to dc_context
Date: Thu,  1 Apr 2021 12:45:14 -0400
Message-Id: <20210401164527.26603-9-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210401164527.26603-1-qingqing.zhuo@amd.com>
References: <20210401164527.26603-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::19) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.32 via Frontend Transport; Thu, 1 Apr 2021 16:46:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0a19b33-d63e-4a9b-ec39-08d8f52da227
X-MS-TrafficTypeDiagnostic: DM6PR12MB4619:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4619E8741B7D524704939483FB7B9@DM6PR12MB4619.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GswBrZJBnVShwgYu8auHWZgI2z10quAzLUb8DITR5KMjpAntbeMn14zZordMGD4emi8dAbbE902hiGQ6BhEmXpDc9HazPzW3kfM6QsaRk4z8RF/wJSSQcxKd+HGgs1Mv9nh2QlCP/eOyI+30WXGrhcgU5QPfRJ+dHhN3GGy2gYghtvk56LQEaH10rMDZJfSwf9orvPqiIWc4ijZx1qB98zomB/aJTFbewwIpCN0/9BuJk3v+9mnrvtyzWm1Z2IXKxzIr/L3gpW3LtzWfcbvmvb6yd3xXlzkDMFvNXOOzAlZhqCQCxcxHwQpXYRKsj1+aZbT6hLhDxAu4f1f53UBufkBtKPMxmi+pmxxJYRdouCajgls+yV/65XJtFLyOvvfocLrm9lt8l0R8HHs8k7e8JYwEJkq778PcrfQ/x5BDr1U3IEY9QmISYaZXWcArlp7QCjZIupcKG7YGZRH72oFF0S92KAfjf285mVS+oGhWkN364vTkvsHpmuJ+T8R8jlmH4JmsDGLY0vqYwfww6e17g6zU7XD/k5D3i7IKlixpzNOtvxb19oMeTH3nQEKPmjzkDmF5cYfGCQ5zKdIdjQx9KPWKO1JMKWPUTjMF1mpKBQcf3rOvR6qEyPRPn+VVe0fCBQARxxRQ/E5X5/DPirrEUyzp/mYcYdJQFKCgPX96dxhcXe+sPaGnH7BXu5dEeA3+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(36756003)(69590400012)(66476007)(6666004)(478600001)(6506007)(38100700001)(16526019)(26005)(83380400001)(8936002)(8676002)(2616005)(2906002)(66556008)(6916009)(6512007)(4326008)(316002)(1076003)(44832011)(52116002)(956004)(186003)(86362001)(5660300002)(66946007)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RPZ2upIN9JHVBZTWqy6osXmRwVcoHCj+kBMhyNaBpM3fBYCVZ86HJNn8c5kR?=
 =?us-ascii?Q?VfpQ6vbRtrI0nRXp7SpkfKK6TcSz4iC+zB2athlQxCY2hGbgOekkPn8TD4hx?=
 =?us-ascii?Q?MKeiFnFbMY45BpcykhGOkM85Uk4k+l2KglDehYGXzIMquj8wharBHLh5HH8a?=
 =?us-ascii?Q?gXSzQGmDEVh5bXC3IRKGuHlWZITPxy7h3tWoiX+7g4P5Tma2sripPcyqpAJg?=
 =?us-ascii?Q?8DL4SqG9EMQVli54MnFcGUc/Mjs/SfIBr56/8OEHikThuTryuY/a7Cjb0Fdc?=
 =?us-ascii?Q?OTE4FG38GQ0JjRIowRK5/zuExZaIfNW02Azo/lVWwPCJR1cecqDcPToQzknh?=
 =?us-ascii?Q?N8GbNypsQKl41ncFYFLHq80ANxkKk3FLWO7AsJ96vYYm0WO1CxrgG5Mmrc+B?=
 =?us-ascii?Q?sqR5Ew6MgSE7pKhN6o1mq+5buS3g4NQefe+4vCcV28AJWpghn6gGdTJV/UUr?=
 =?us-ascii?Q?VQNDCBprUdeNruYYT9OeBXnVO2J+2vJstNuZ6CuJgzCNE1pg62e1cfOzO2aB?=
 =?us-ascii?Q?WLd6mgXm4YMeCZ0U6b+MCjO0exdOhNNZVXtkTwQlpkTJ/QfYXReKf7aez58b?=
 =?us-ascii?Q?MmwfYHGzX3TuVf9pXjOVQXAm7ZEYuYhEJlNkW6+vCfBu+OuRlS8lzJg3o4S8?=
 =?us-ascii?Q?ms4do4fBe3Wjuc4WWOwgU832DogCc5Pi5ubpkJrrVn8c8isz/6p3xmRWZ3ne?=
 =?us-ascii?Q?oSilotQZlR64M1o4E1Xpbn+nxGAIXBXqu/MCybW/4xFtW4ugGVORuDWjgTxV?=
 =?us-ascii?Q?5TsTq5vM8i5MOCTnh8gFbe13kWdPIYyoxburFNa2/H0W7BKrlOXUP2/pIBe7?=
 =?us-ascii?Q?AbSZ8SxGGVIZ7fRoAHHP3UDe5IJkSPrBeXVzH+dSUznBXGigzX3Q3ZVxhRv4?=
 =?us-ascii?Q?obk5b5XV6LMfr2KtYOJ5M/r6OUKkc9TQie8fMDYVYi9RL9qyypOhrPlt4bN1?=
 =?us-ascii?Q?bppNw16LsX885Yexn0FBoswuQ3WGSFZxppd0q8Tq3Lt33xVLWkNaSGiy9nR4?=
 =?us-ascii?Q?rEtuXp3vwKxuq8Kn8XOOOKnVIYQ4n0jO39jIED7/6imfLakv/BBwMtSz8dX0?=
 =?us-ascii?Q?fSc0HrQon5MxvD+bUra2hr/FkD3RjZL2lOKIou2oUNUXuNMcw26dbhxAGr+b?=
 =?us-ascii?Q?dLRje0z5twys+w6G21YRjFBQpUiliRj5GerY51QGJjg2tKy+8emgMAdPxShm?=
 =?us-ascii?Q?y2pdRcOgcSqhCbz+uHf0hzbFwZ3MtKVHsCx4cSaEfUQCYrTRnirUAY9g9wfa?=
 =?us-ascii?Q?DcA9SEo7ES5UytjA9owYV/SkVHb7n9uGajWrc/YpebHYpz/FKR82gh1eYZn1?=
 =?us-ascii?Q?g/HEK1pc6LjIYV1NBKFtij5r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a19b33-d63e-4a9b-ec39-08d8f52da227
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 16:46:01.7453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hz1eJ0u7SW4pgalYpwdHfqEQxQYtPidHObc/X7zMkFLZ/5X8zHqc8jsH9n66QUab
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4619
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
Cc: Eryk.Brol@amd.com, Jake Wang <haonan.wang2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jake Wang <haonan.wang2@amd.com>

[Why]
We need to keep track of the number of eDP links to
properly enumerate edp panel control instance.

[How]
Added dc_edp_id_count to dc_context to keep track of
number of eDP links.

Signed-off-by: Jake Wang <haonan.wang2@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 10 +++-------
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  1 +
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 719fc6b502b6..b2b6e26f160a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1386,8 +1386,6 @@ static bool dc_link_construct(struct dc_link *link,
 	struct dc_bios *bios = init_params->dc->ctx->dc_bios;
 	const struct dc_vbios_funcs *bp_funcs = bios->funcs;
 	struct bp_disp_connector_caps_info disp_connect_caps_info = { 0 };
-	struct dc_link *edp_links[MAX_NUM_EDP];
-	int edp_num;
 
 	DC_LOGGER_INIT(dc_ctx->logger);
 
@@ -1513,14 +1511,12 @@ static bool dc_link_construct(struct dc_link *link,
 		(link->link_id.id == CONNECTOR_ID_EDP ||
 			link->link_id.id == CONNECTOR_ID_LVDS)) {
 		panel_cntl_init_data.ctx = dc_ctx;
-		get_edp_links(panel_cntl_init_data.ctx->dc, edp_links, &edp_num);
-		if ((edp_num > 1) && (link->link_index > edp_links[0]->link_index))
-			panel_cntl_init_data.inst = 1;
-		else
-			panel_cntl_init_data.inst = 0;
+		panel_cntl_init_data.inst =
+			panel_cntl_init_data.ctx->dc_edp_id_count;
 		link->panel_cntl =
 			link->dc->res_pool->funcs->panel_cntl_create(
 								&panel_cntl_init_data);
+		panel_cntl_init_data.ctx->dc_edp_id_count++;
 
 		if (link->panel_cntl == NULL) {
 			DC_ERROR("Failed to create link panel_cntl!\n");
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index d8912a4de3b1..432754eaf10b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -113,6 +113,7 @@ struct dc_context {
 	struct gpio_service *gpio_service;
 	uint32_t dc_sink_id_count;
 	uint32_t dc_stream_id_count;
+	uint32_t dc_edp_id_count;
 	uint64_t fbc_gpu_addr;
 	struct dc_dmub_srv *dmub_srv;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
