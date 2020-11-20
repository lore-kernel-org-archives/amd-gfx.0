Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FB8C63777
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BAED22D0A
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vPoj7v5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BAED22D0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A4E26E91F;
	Fri, 20 Nov 2020 20:20:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29C106E920
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 20:20:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxwPHGpVzfjoSdZvM6owUIgOukw3rwh5KvV8Pj9eddSoiQzeldCsQ3qpIP9uXj4s3pFTZXU8WxAosz1Ku/vdayga+Zz9OZbJySTbXc3FPn02qOg8FORzasSF5gKcWD3AIlUgU/FQNi4qitfJ663ygZEd17tw8zW5GkwolllSa8/3Ml826uLRY2m5a9m1mOJtWHKUYTcMkEcypJ7SLSVO3tBqvhUBkzmEhZpgEftSpFGOc1iv6o7BHcQ8s3nZrXwtsrnsZAgMbPROZnRElNz2WHeMYb5vimlSSKGhFGYTkfRlq4pHbNohGE7GNPoxz6W4t1uxyvqbOi8xZHYAVWhsNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEDWsRbVSUltBkRmQUeGQyk7McknehBOMMBPeXmm8J8=;
 b=aD+kQ1QsYs3QTB1k+UVwdI+Low3ZvJsJ6BrtdIVrVXEwXYkyVzIdqLwkC8W0/C6i7s8LTGEM31Q2n4U2HmSL1DUz6hYibtbxtcwXQaIy3yAx3PCnWw0G9MT8fbkEj8Ec53Oiawn1d6ytvqSsJ7nWZOoHpnKI/YKPQIPDXfsF7oxdY50fpb3sKy9vcolSFkZ7VtVflRxBQqMA6CFiFO1PcJbbx4CnAbRPm9jG3bjsonhQCsf8t7Mda82A8f60D3yVHMwUVxJzThHq2riVeRzRT8sAVo+igFygpen/3lqBoRNFVY4MXX/Zv15a//7xHC96DhR+jFKaZSAGnFB0EiZ+iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEDWsRbVSUltBkRmQUeGQyk7McknehBOMMBPeXmm8J8=;
 b=vPoj7v5WwWm8Gd/dCdSODpGd3gH8p7EDY7+ujav654egVHpjrf3ZKrUgV354MGepa2rExlWeWrHIhcOyQ4Xjm1ZyS2srdyEhLZMyU4CEpaLZd9VrmMc2rb8gWDce5re9OHtPLoD8vLAfpbFeMJ9a6KjxjcHqdsArHJBqA+fMQoQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.24; Fri, 20 Nov
 2020 20:20:24 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa%4]) with mapi id 15.20.3589.024; Fri, 20 Nov 2020
 20:20:24 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/18] drm/amd/display: Enable stutter for dcn3.01.
Date: Fri, 20 Nov 2020 15:19:44 -0500
Message-Id: <20201120201958.2455002-5-Rodrigo.Siqueira@amd.com>
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
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 20:20:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7bb4971b-bab4-475b-a74c-08d88d91b670
X-MS-TrafficTypeDiagnostic: CH2PR12MB4261:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB42617CC953872A0C51BC97E098FF0@CH2PR12MB4261.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qD34nLINI04NL/VpcrhoPjMP5S8qY8JPl20Upy07/bPny1Ykztuh1Sa2TGRJgpoS0FZBqzlH+auSclXaxU2ePzbQcAAlGinlLCHe8rVI1uhrduWXObAUqa8ENA4GA2snmu3/nt6wxyO90F9Hrp9iA7nGrydPMdanKDaVxkBpg3zo4/qWdQwqklalr0yMB4FFKezRG2RtKKRC1dzNjOny8TsBxQnkn1uV3CR6GXcDEygqH9ScotpLSH5bT1Lr77ftwxw3ygwkm3JQaI33S4jPE6LHK+bqIEdXCFFKi0lHUguiVhhRxc5J6Ad7FFWpO3sT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3781.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(5660300002)(83380400001)(1076003)(6512007)(66476007)(66556008)(186003)(6486002)(66946007)(4326008)(4744005)(2906002)(16526019)(86362001)(6916009)(316002)(8936002)(36756003)(6506007)(8676002)(52116002)(6666004)(478600001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: SbN4OFggXQpmT1XQ9Ob8I0trbKVu6Wij3KOvFeoykMyW7wuKqCFBbsy6H2zHRfYF7MPs1vUz8SBnA4H6bHPYU9FONOAjNZAdOl/G+r7k1K8QW8XrvnKIfHvjpySAYrcp+NYnv/mi5o7LJD5TfnBNhG30o/sglzvl2S3FkNhuI+bcNcd4036erxM7B1PZmaZ6EjKjnCYKV+3f59glQg/7PD3RV0EppiEZxsgjPlR6kgT7F1x0HdBeVFeRi8capOV3aU4LI+aVlT+t5jYG3/wPSUv4Jqco2nlMbtMjvEYiI+LA+SpJ7V0YC1zZQq9gBJjtGH3l6U71bJvVAhN2Vd1dajPkoqBglrWsfKEdeIGLCC1km4YDKapdbnxbmSULASFdfiRrJ/WfuezFNXcInzDsw+ni8DWWMgaQF+MYa6c17HLu6DBwFQ5FJ6jdZbY6laeqrjgxOoP66qlytsshjkNVUODt5Wvswj3KKi9kv63ENzL+7pYR7lZGlW7QmJbkiDL/EJaOho9Okj8VixUUIAqKxXrOFQD40fEKUIJOfi0ECOTaCcebH6qHmGmDfWDXWX+UFIOEs4UMidUQBSShimnTF4JJ2UpPvfpz1TpueAFE/TbzpEtXKNSPqq3nMk9Qo2GdwlJwg5uAWlv5rF460MXlJBbOtjejuWsHtLWUgZcYs/Bi+YWM4G3rf06b89xC55r0HHSy6UC+SscWI/HZEwsOLbefyVycOVr7CVSktx+i2j10LlT1VUAxL1mVoMlJwr/oeJiT5VSl4nSZwGDVrEhQg4oqipM91miuggB6ginzbttRZCdxFkjT2cobYOosu0H3swpDyGoXslB6OBPnczs/T+tjIaMfSvdSL0cawvBoL0GLEr2hYiYIesN6MoucLMKejmLDxNNuZLj8Osj7pQ+d/a5thBlXFN8OCNQRZrf/la8zXWm4fr0MEDJeHfWilBRz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb4971b-bab4-475b-a74c-08d88d91b670
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 20:20:24.5284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPUdqD719yjU7yuoYV3zS9LJUve+ToetIsXigKn2q97qI/+IN3RslCX3zeYiS+Fsy8n0/1NfuMtM/anDTa/ccg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261
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
 Aurabindo.Pillai@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why & How]
Enable stutter for DCN3.01.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 9ce9d9603942..5f97808bb423 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -855,7 +855,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_clock_gate = true,
 	.disable_pplib_clock_request = true,
 	.disable_pplib_wm_range = true,
-	.disable_stutter = true,
 	.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
 	.force_single_disp_pipe_split = false,
 	.disable_dcc = DCC_ENABLE,
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
