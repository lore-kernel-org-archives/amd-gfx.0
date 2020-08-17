Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CB3C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 07:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5A702072D
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 07:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Y2SEObkj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A702072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFDDF6E48B;
	Mon, 17 Aug 2020 07:49:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D78A6E48B
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 07:49:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMd10/fBmfX6gwt54Mf73H0co09sD8n520+iCgFxaU93g2MlWFW9m1ABIl6BvquR3MV0lrxjUumRi58SpLG4NEANL/MntkPwhMtt1+W5hEmx4CITh0p31kwDUpPP+JLkYuur7SLzYLhrAzSUZ/nzIWu8xNn++bZeSecpIZYmMpWMMciijKnAYIpU/RLxNGTEVdWti3SjMh9xzSOwdXUdKoIam53CqjKgrQoc/vHmVuWLoaJxqhqL4IxJxtNe/T/ipl6G7vCVK8CQilsgzbq4EwCITJMBWOjKT08VaFQzs8qCfCgVmFJIXIOU5K5zsjjWSExFgvcN/H5zhx+xnACE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbyCk5ShcN/NHnIP3En/JK/neAdBj75xyX/I6lechKc=;
 b=AwnvZnh0D9jVVDFzy8eGZRVQbgwsG9WnnpZa/dBFRCKXpy/aRv8/R/uc090NcBDzvE1SuGqLdTxqvGzzC8skQrmQ7cdGp8X428VSIY6GEJUekZeZDpf6uD11CzNi1s6LN0K+Oijkh4NBCj0QkNv9prJCZpHZqqXI07joch/IjGgSsH6hEn35RTW3VsJoxJOCbKDLuc3+NCG1vULp6gr3sZK6YriEHv6f4JOx7XRTqGxjujQYui/b2Z7JlDqv/jPxqBWR42y7e+gejzKiIkb4ZWyfwgCk4k78Bwk8od1FogdTRaXLfNxJqCzg9fHhPV8OA0gRk7ZyKiRi/aAV2nC1VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbyCk5ShcN/NHnIP3En/JK/neAdBj75xyX/I6lechKc=;
 b=Y2SEObkjqASyS8LZjfjfL/lr+XA8xPSVgPaBpu87L27ruATdqQsPjo6MUxwgFjoVq5KTLXw8f6N62HzlvxU/YaW6pG1Ci9iejQJk3oA5gO3OasgWn6XJF5l+zxgSnSLw0rmzbphSIiySqoVNuK1kjWsk6llo/k71xa/xw2dL05c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1452.namprd12.prod.outlook.com (2603:10b6:4:a::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.20; Mon, 17 Aug 2020 07:49:47 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.026; Mon, 17 Aug 2020
 07:49:47 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/5] drm/amd/pm: add Arcturus gfx ulv control interface
Date: Mon, 17 Aug 2020 15:49:15 +0800
Message-Id: <20200817074917.9607-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817074917.9607-1-evan.quan@amd.com>
References: <20200817074917.9607-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR0401CA0015.apcprd04.prod.outlook.com
 (2603:1096:202:2::25) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0401CA0015.apcprd04.prod.outlook.com (2603:1096:202:2::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Mon, 17 Aug 2020 07:49:45 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 065b498c-7fed-4a0f-8e7e-08d842821cdf
X-MS-TrafficTypeDiagnostic: DM5PR12MB1452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB145258EB81807B7CF64F707AE45F0@DM5PR12MB1452.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aa8z5iK0MOcwDu2vHB5VNqTltdXF/WsYSQr6M5oLTuU5rP2cbAxchj9MVz58vC6hIVMyBBrM0kERrCNRn6OILGBr1FR0oXMfLZB0ymxAmaf9cH8UV9yQ0f/hCdBZStngJLvdhY5Ymb/njU6kgPpVwcu14nSoaujBDiHMNzvF3PbfoP7jThWXclIPIsVLsU423or1LE3HnOQ/a2gnYeuccMen2AN8JSoa3kQFpVhH9KrHzIkaT82CJDvO/Z0GiPPOp/4O5rnRM3dIv3bOhYBvtRWybXoSkItmySTCN90sazZt8Q2YfPATG0uJ8fOTxeUMXenFQRiGUif+gcDBTADRUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(4326008)(86362001)(16526019)(6666004)(186003)(2906002)(2616005)(478600001)(956004)(8676002)(6486002)(5660300002)(66946007)(66556008)(7696005)(316002)(66476007)(8936002)(52116002)(1076003)(36756003)(26005)(6916009)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4AdnrQ7baXqaEgRlpRxx30SLrB+HlIwHpP+Cro9fUfUygDLeny2OF0WqVtTsfzHKAV/j/Dc3HbvmZ8N+SBQeZPnhfoNf6XbqTkx4RpfHqeW3zSCQJ55RzaMhEhiPLpiVUS+/SwC0UGP+PG33nSVkhMCthzHPnVdX7+UVYH+5Gq++LNUEhTJ+WFpjUEO/zIO+sjxEEVbl2VUG+RQkWBEHtJPzggJ0g9c7pU1ONBlLFAlW5PT0buN8P8/okV10jSlgHLDYRYfbyKnjKi3rEzuePFdZ+ux1iqS2yeOQG1hJHESqTmrVudXzyIJfQeI40raOMBiXvh4507ksxHf26ewru69q/k6qYBRURDirrbCcv4gCSJX1kjQqboLV9chwe4oxzBPzbLzIuec0CphmFC7FoxJCGt8bDklC6ZkuqTsvTfGy1wWMB+YB15ePFNwy+KF0GaSqH2uC3ZWVR4KQ0GRdT9p2o1UDxgNNA8VGAYAKF3LQ1h+K2tw9vFO+B4jQAuvh6AqjZnWVVtNFJRhkuSZWam5Nn9Teo9cHf6CrTIIlYAn1DFfRIQPYfMHZAzZGtP0vVNixr7YVvmwQSaX9IF4aGBWTWTTe1Ue1azkyOFTbhYmPsiQsLP77OY45YiaxMMU4GlUp1vk9QSeRaHbVFU9tEg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 065b498c-7fed-4a0f-8e7e-08d842821cdf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 07:49:47.3308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8r8fGyft2C7M/2mr1/Z5JrOtRIDT5b79+OYc9ksDWwGT+nsM/A/mkCo0MAUA+6b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1452
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is needed for UMD pstate switch.

Change-Id: I40e235add95d6abbf99186112673a411edf2bb39
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 81f43fea4d52..c82ef2872a50 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2313,6 +2313,17 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v1_0);
 }
 
+static int arcturus_gfx_ulv_control(struct smu_context *smu,
+				    bool enablement)
+{
+	int ret = 0;
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_GFX_ULV_BIT))
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_GFX_ULV_BIT, enablement);
+
+	return ret;
+}
+
 static const struct pptable_funcs arcturus_ppt_funcs = {
 	/* init dpm */
 	.get_allowed_feature_mask = arcturus_get_allowed_feature_mask,
@@ -2391,6 +2402,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.get_gpu_metrics = arcturus_get_gpu_metrics,
+	.gfx_ulv_control = arcturus_gfx_ulv_control,
 };
 
 void arcturus_set_ppt_funcs(struct smu_context *smu)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
