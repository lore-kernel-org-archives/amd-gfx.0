Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4CDC38A29
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BFB521841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QUV6JewB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BFB521841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27CC26E353;
	Thu, 16 Apr 2020 23:41:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2D226E357
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNVqxEVGSj/uTz9u3z4uEWKXmmeGve/gdliTtjUrcvtmcvF+dhpoTq5tg02uyhRyfhExGMYocoru2WfXuAB5JwKyy+12kII9iK6w0sY88jnLYndEv/Cpwcv2yuW69U12HjIwGDDEdtB7JUNRLSI/2zJq1gQNpV+YdndaFXgT5fGBFEjf4K18ckKG7901OWe8CkEgtehvmsxFtlMZV69zycGrEwZSFOMuMXGXMon5W1qwaHXtPgVjd0B8dkQGJ50HGdTiG+f+oaHHSLoTEGilpYd62C2qPCnl24M9YLQOdeJYZ7zZc6+/jcsbwsoEP+l2HEoFv30O3aT4SLndTUYf1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rBQlnMHoYyNNTjiEL7ZK/Gqx1MpHljjgdeyQX7NxwY=;
 b=gduEAs5d9P8ocP0ce7cBgWuCp7c51JdSDjtkcZS3fVcuGIrwsUPrNDVLnSljh+r5TEQ/vDYI0+X72TYHQIu25dJchwlp28uo2Gc6jNa7BRkWlUQxcQ12lHF4G2zkjvmS3dBI7LzJIjt2/V6wI/ewYVR1S0S3ZBa2g65Ep6AIw2Y2PFjNUyiwA1ZZd91EINB2DHzulwbZUx1Hi9wdH6ZMFgZy327ME6daswCa/MdJFAIFVMjBS/SuIncyPq1AIJjryCq1AEflinW21bjV/tlmy1AuEhRHpH3BQWZYoZVBQL9FbD+IezxzUKTNie3FBO2tqMBh30s19NmY/RyXUyPYLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rBQlnMHoYyNNTjiEL7ZK/Gqx1MpHljjgdeyQX7NxwY=;
 b=QUV6JewBlMlKFYVqUTD4JJdmFAzfZCQ63e7ZSJcDCgYrjMo+R6raCr2JTRgYEWNJpybvWrsA9Nxl5zeYucQGX8/vIlP02f92Z1NoB6FE+aA2FbTr1sNV2J/rMs7Pum4Xu0ItRIJ6GxneKpcQw6qlEm8C7x4S0WmbZU5z8zedzwc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:48 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:47 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 27/35] drm/amd/display: fix virtual signal dsc setup
Date: Thu, 16 Apr 2020 19:40:36 -0400
Message-Id: <20200416234044.2082886-28-Rodrigo.Siqueira@amd.com>
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
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:46 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5ebc350f-b100-4ac8-3fb9-08d7e25fba87
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24593477F8873B57329C1B2E98D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:142;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(2906002)(54906003)(36756003)(6916009)(6486002)(1076003)(478600001)(6666004)(86362001)(81156014)(8676002)(8936002)(6512007)(66476007)(66556008)(66946007)(2616005)(5660300002)(16526019)(186003)(6506007)(4326008)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CvXpUoykeHkCJSfkyksX8Nv45mYFWgGuzPo8ovRIWxBI3+/ih8+sQahCLlPaPsM8s7ajSfvXr7CrRRtMACECLCSWVSD09gqeXmvYdjT8JCiHX+Uej8zRIPP2f9XwOTEsXBFqlRDUL0lDWfKKw8/AFY9e98FnKmtUEVCsjGXudd9jAg4aYaT5e90j+WpUr/uIv5vnbC6vgGAjr0tue2iPzJaSb+FBiJiP1vOjYQLeyTVme0c5r0Le77cyKmWokpWFhqItGDxbnIXdfaOem7xdLfjU3XZqT4I44UdQ19Ou2rAaY3pa1KHqO0Ev57NaExSPc6dqnliCB9Z7euzhIMMeib/ulCmYB1TD3UnFrZZ8CxdSfJHBgD3nOvlUENklZVuzSqcJNCo9087Ysl6/4QLrMvTXmItVqYh1ODceVpdu5SpI0iGz2DeJzj9ZWc9jLIYX
X-MS-Exchange-AntiSpam-MessageData: MhYB5HGu+qfUjvFc3N5r4ltG24IbatElNVagjIYos0HJifRyj9bxWT8TaLS8rQOb4aUAXNAXgoGYgv1D8uZd8XdBt7IUiNW0UMly3zbI6mkLhDhy851ES1JcKxHeqJuN8+EQQMkjyFABF+aadY8wfuT4VipeNVmjPpwpAfjV7mU=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebc350f-b100-4ac8-3fb9-08d7e25fba87
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:47.8449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: knNX7WgIxDNK/cFktbESgHmKne4v273dJy8ODOlHGGD9fL8Ma0XrHvyNmnumEBshVwZn1UsNJ4r3qhafQtF8Ww==
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Eric Bernstein <Eric.Bernstein@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

This prevents dpcd access on virtual links.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Eric Bernstein <Eric.Bernstein@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 51e0ee6e7695..6590f51caefa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -400,7 +400,7 @@ static bool dp_set_dsc_on_rx(struct pipe_ctx *pipe_ctx, bool enable)
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	bool result = false;
 
-	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
+	if (dc_is_virtual_signal(stream->signal) || IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
 		result = true;
 	else
 		result = dm_helpers_dp_write_dsc_enable(dc->ctx, stream, enable);
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
