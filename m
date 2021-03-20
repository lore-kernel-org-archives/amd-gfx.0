Return-Path: <SRS0=4T84=IS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C73DC433DB
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1699B61979
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1699B61979
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC5796EB2D;
	Sat, 20 Mar 2021 04:19:41 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750072.outbound.protection.outlook.com [40.107.75.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69B7D6EB2D
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Mar 2021 04:19:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEKig++rTJbtjBF0XLnSirLTKM7/jo3nG6F8AmW0Dx+1QeHOxlu01z0Cen4GxvRsovh/1TbU/oJJhxQUw4vzqeM46PRzZVJwwEu6aU8pFrz7pnEAqyPDK27mlSl1ZpUS33FgOf9iOPO3gWBm/IrZwUiZL6xo66EtCHFml183CYX16r1H5KVTJssyqd8YOJuzdxxTtbdZS9WP2udZIcdE+zgiCquzkFKuDRtLA8fzLS0qwOQo7C3pNI6JxGM9RC7CX8psFBe4kMzpP8UQaQKo3BguSJBUncuQwgcDmK5IEDYwkj1220/Qyzl05SZTUI05nNU5S8uPd+Ev04kdxqbtwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xaxJC7yryJSYMyWD9BL+e72T2xP8IFvpK3AJodX71w=;
 b=c/sousSKyXzFJIK8Y3YbbweQA4ZLeKDddul7aLYpZ8FxsrWzhEuaLBn5m6lLRrzPG4ViS3NR9Wvpu1YTuSQT4bPiVGaTwW7QqAH733G2wcLJNuG8Qxm2IJu243jU2SyYupejaSBAGimLraa39aF8Gj+GD6UWhlIz+kW6W0+FAgpZ7Ve7gdn2U3zvZL6brYEy4GLTdPY5RYGYzyX9rd40K/I/84UPwULFGkioyYiFinUqV6XHmKQJ20YThrvORV6VQP1N7SLVGy/RTw+ZEvgmMqA3CO45NG8RCD3RJHtqDtzABwQazWcsnlVfdQX4LnfAF8Vtrm2QT3ViCAZvcg6znQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xaxJC7yryJSYMyWD9BL+e72T2xP8IFvpK3AJodX71w=;
 b=xZzY/ukqqsuj0SkZ8pDZVyqNmZSMeNYqQDEI/1tHEvare7BXEsY7xItcdK2FwkRjdJY/nZtXhUypTU4HqR4enhUgFERUJGyzMV/J2BDt72QUcmTkePPeIDL9amCwaifuYcdAy4lxZZfGx6PWe8eNajPLYIOd8OY2ZHGY5x4CMc0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2605.namprd12.prod.outlook.com (2603:10b6:805:6a::11)
 by SN6PR12MB4704.namprd12.prod.outlook.com (2603:10b6:805:e8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sat, 20 Mar
 2021 04:19:38 +0000
Received: from SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1]) by SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1%6]) with mapi id 15.20.3955.018; Sat, 20 Mar 2021
 04:19:38 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/14] drm/amd/display: Use pwrseq instance to determine eDP
 instance
Date: Sat, 20 Mar 2021 09:46:55 +0800
Message-Id: <20210320014656.23350-14-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210320014656.23350-1-solomon.chiu@amd.com>
References: <20210320014656.23350-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HKAPR03CA0030.apcprd03.prod.outlook.com
 (2603:1096:203:c9::17) To SN6PR12MB2605.namprd12.prod.outlook.com
 (2603:10b6:805:6a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HKAPR03CA0030.apcprd03.prod.outlook.com (2603:1096:203:c9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.9 via Frontend Transport; Sat, 20 Mar 2021 04:19:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e96595c9-f9c3-4a4c-9e60-08d8eb576028
X-MS-TrafficTypeDiagnostic: SN6PR12MB4704:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB470460F54BC52FFD25E57E2597679@SN6PR12MB4704.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fFa5WqsF16GwGFpWtkd69XgkXqm2aieK5JOB5LGPvh+6TSMRszf+rd8RvIyL6gnnQasltNa5SzKnRBiIzMI88ntRFM+kKMB4X5S5QGIfxOM8oDpadKLfXEF6Iaj9p66OnLunWECSzeepad+fOuVuLk6m2QkqQiZbRlc0lKINxJ3tYjILPSfW4ct9XAefSrqevYSXZUDbg3EdJl5GQxrD8zE8L+FDdsBCHjLUUSJVNwf01cmKV4tG2ase78EQ+LYOMeCcIY59Qm7AJ1KQmVGmLqN2a0DVjF/LNqTVppV0za+wrSyLhfO/gghyPoNBNzdI4Ni9/MOPS+EkRM8VOx72kjHIJdz+wZV9CKMbjH3HqBGPyNbi9yVBEPt4RIQSQYLmlutEHLEldf1T2xct96olVNoHONdAFNheyfq9PU2lFDXOjDInNv8YbDOULzWs4y+DXGioOEtWcAhO6PAZbihyDVxFSR+2YNOffinZfJOrs2e1CL/wIAnaM9M01hrfleyLQj66hImxOcAH10Ad9sfjmnRJM0CeJmc357oueTtFRBQ6pTbESqhjhRJnUUlgqhVmdYakv7s0k9XpX9E+9vVg/aEd2mrZ+byvih2IyZ4PAX4kdooa7nN6O7gqDqL8VupULh1FbqYqJ1X5FBVJlNr8JjctJz08Bwwz+DlAyYrvsLQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2605.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(8936002)(6512007)(44832011)(6666004)(26005)(478600001)(4326008)(8676002)(52116002)(38100700001)(36756003)(316002)(86362001)(6916009)(6486002)(1076003)(2616005)(54906003)(83380400001)(5660300002)(66556008)(66946007)(186003)(956004)(16526019)(66476007)(2906002)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LnSTdog04+WwZkpccizQAMjTSuhjBo0l/N6ZCuUrE6kR+rkZSpJRizTi0bKl?=
 =?us-ascii?Q?54Hc20XxMdWvB2qqYd+/mQ3fkAGLlG+35v9QImXd0Iv7QXNZ7sl9Ld0tRtgD?=
 =?us-ascii?Q?mMnlj692Dz+5ZLXS/IXV1eRz2gVmTeaBKJRpfAvIcIAc62z/pFvAuz9i6h5j?=
 =?us-ascii?Q?1B3h04mboeexdycy7Rrwb5a517+C19fx/gqa3/l0dqQZ7OEke73dlgZK2DxX?=
 =?us-ascii?Q?Ft8ckaPW06ssEdfqEuIObw1zfkPntxoSyYMJxIpbuz7CPcNugjcrvt34rpyJ?=
 =?us-ascii?Q?H5Z/mjsIsmeZUSyjHTDPOzVEsSNGWdjP6Wh4755IWnSSWC8h5ogeIzGmWWz9?=
 =?us-ascii?Q?QZ/giZKws+6rgj6LMWXZHYbN9uU73JcSiu209eBPTiHjTbXwIpjH88p0sa2c?=
 =?us-ascii?Q?s9N2HWQgEUMlDbIvnYvTEs8Nq1OzNpwjf5QfR554bYZiDSQEb86WXOOGluk/?=
 =?us-ascii?Q?y4suzNhtiUusAXE91F4Ov/Yb5ykEj6z2F3TmLQ0zoYEfehVlV9SZRXmcXMUp?=
 =?us-ascii?Q?ggH9bNjt2/96oS+kEoWaWxix7V3Wr6MNfScHX9I0puQ7skRBXH65vfc8+/Vx?=
 =?us-ascii?Q?DVYRzDa4wM7CEjFK4084k6nNPXrAao3N2uCa8WjRN7YNrBqLBr4J/y1Y3X5h?=
 =?us-ascii?Q?KfmXZV2vbgOO+j6ouWYYqeaoVK41GNmjNui3uWwUup0jsa+I0ru1g9YObhua?=
 =?us-ascii?Q?5SUwXvUSlVudX7Lo1ZWLZ3X+pwYNmviasQqgem4GWU8ANAoOy0z31lNgQS2N?=
 =?us-ascii?Q?b8sdpKKYV6LsQSP8K6oCdU67yLD7A8FmYY+bwL3R8EWXTHVrYJGfpy+q0CcW?=
 =?us-ascii?Q?2CsyO+lFeQAD6GU6szI1Iax2MqA6FoaDHjE1DDHCLqd9ghICjp7VOI6BvZGv?=
 =?us-ascii?Q?t5+Mq/dT2HjYWn3LBj5ATT6ACqEXRDamTORz9Iba0ZekOe6TuSrG1zXv5wNQ?=
 =?us-ascii?Q?COIwg+69o+Ecp9y34CxXgWOJr9x5SW3Ibdznty6a3QmxugS3uB6UXoq7jLG8?=
 =?us-ascii?Q?2eIMMmv5jcYw1MAnza2oxm1R3JAR6q+V0sT+TvxqtGeUDbnzGOYHvQyzGB37?=
 =?us-ascii?Q?ASjegiA2IX3fF2S0fQkKHHkVWCcwIOblqlVCiNDrGrzQVfnnVYUkSfwdrJ1Z?=
 =?us-ascii?Q?f89GWhUkpqHN/O7dE0q9XsWwE+vYcDxw2biP30uwjC9Up93kLFc122j76RVG?=
 =?us-ascii?Q?bECnR0bPqh+0nd+ediX1khsBLclFTovGKlrHt8zb0Iw5WFdM9qpsPRWSEOSf?=
 =?us-ascii?Q?GGJLizN1gnNb4IPltdRNMzQ8kFnV4I/LmJgKrkQCOXw0weo3/1BF1EcrTKSw?=
 =?us-ascii?Q?e0ZSNayA1xhwgI+rtFEKxdg6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96595c9-f9c3-4a4c-9e60-08d8eb576028
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2605.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2021 04:19:38.4020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpZKXlkTGMdceyyUYRsSXJY7l0a9wxpaRkgkZePyy9im5CTms7t+NAJWrusO2aIekMLVCp2qbIOHAcf0TCdZ1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4704
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
 Harry.Wentland@amd.com, Qingqing Zhuo <qingqing.zhuo@amd.com>,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jake Wang <haonan.wang2@amd.com>

[Why & How]
Link index doesn't always correspond to the appropriate eDP instance.
We can assume lower link index is a lower eDP instance and set panel
control instance accordingly.

Signed-off-by: Jake Wang <haonan.wang2@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 10e34e411e06..e1e8a8bdf476 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1383,6 +1383,8 @@ static bool dc_link_construct(struct dc_link *link,
 	struct dc_bios *bios = init_params->dc->ctx->dc_bios;
 	const struct dc_vbios_funcs *bp_funcs = bios->funcs;
 	struct bp_disp_connector_caps_info disp_connect_caps_info = { 0 };
+	struct dc_link *edp_links[MAX_NUM_EDP];
+	int edp_num;
 
 	DC_LOGGER_INIT(dc_ctx->logger);
 
@@ -1506,7 +1508,11 @@ static bool dc_link_construct(struct dc_link *link,
 		(link->link_id.id == CONNECTOR_ID_EDP ||
 			link->link_id.id == CONNECTOR_ID_LVDS)) {
 		panel_cntl_init_data.ctx = dc_ctx;
-		panel_cntl_init_data.inst = link->link_index;
+		get_edp_links(panel_cntl_init_data.ctx->dc, edp_links, &edp_num);
+		if ((edp_num > 1) && (link->link_index > edp_links[0]->link_index))
+			panel_cntl_init_data.inst = 1;
+		else
+			panel_cntl_init_data.inst = 0;
 		link->panel_cntl =
 			link->dc->res_pool->funcs->panel_cntl_create(
 								&panel_cntl_init_data);
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
