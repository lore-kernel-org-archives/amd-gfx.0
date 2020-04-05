Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60274C2BA2B
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D2620644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qcFD6mhb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D2620644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE1666E297;
	Sun,  5 Apr 2020 20:41:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 925596E297
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhmhgLB/o5DkP/asfG9BKTQTSpUISdszma87vTRppnA8+eNhDsHQVUXYwGIfXTevJafshRVUKV2L5BneSC4gkDVIykdVAVX9ghz+teRo3yMr4zu/bnJjDvzodExdqdhHQYGAVLAl254rBULpXs4ntr5P5RsjSgNZP5Z+9EohiGFqqwy+0vgCGp70xH31qLtuApQp/nRuAHj9xBTcc4omOC+wuVZ2dPti1GR6X29eB5sXHNKjLiP0Q3Wni2z4aIL/bOg9BdFbux+sx4wZ6jO11cy3bHb6TPxJK1lFajQtzboDbIVwYTodk9P3wax+NN9TaZp+jwVQIYwOAFp32ziTeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIjQfMYtVEyWKNreaDui+yU6bMEbcP6ZyL+YV3CS830=;
 b=UrMlf6Yrs7kIzerH+o3oH8HrI21TC9Dz3qUXJ9eRh/CbpntesX052oMGhXskts+SJIMhNE32f8bimbY1LwEWymivMhdwZyvplvKfF2dKmBok1hX6n5SlVzOfuGa8c9Lk4A3+J8F5kanwSIXsJaPZBPkFqvqm7fIu2bTubuHP85meCcPJxbz3htaHe4bpI9equ7Fc2UVom1lLJiaPzbfZYdW4PnWt53UbZvHqwHcqEQLnqY54TOINSbWlrSJJ8I9yyUci8UTUnFmm/sTflp9kFXQm5nTfVs/Z7YlseY3L+4wk/Eo9X7wLmft5pqRTgY5wkj/w96bGJVDdL724mjfgGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIjQfMYtVEyWKNreaDui+yU6bMEbcP6ZyL+YV3CS830=;
 b=qcFD6mhbiizDVuJTP/vp1VOMQndQXxPP7CzfkdR8v9Wkmnq83ypadqvVq9bk736dFfACp+nY1E5EiYEXu8rWNw50x4JvqbPXjbiGB0tZGUziDW38FXR5AOrRfDbKW3No8Glgn1QIt0MpRra7GeCd0NSIkimhj4suNxBo1XRpapQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:41:53 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:41:53 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/36] drm/amd/display: change default pipe_split policy for
 DCN1
Date: Sun,  5 Apr 2020 16:40:54 -0400
Message-Id: <20200405204115.683559-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Sun, 5 Apr 2020 20:41:52 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cf3ff786-7b75-4b9b-315f-08d7d9a1c633
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25553BE07C96BDE8C3367F2B98C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(8676002)(6916009)(8936002)(6486002)(81156014)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f65rm/0b9rPkXFqL2rTEiIII94QShsn0gIUtTCPTiC4i0GUtI52VkbtSNUCTN0KtKrqZRVRbM/8WcSyg3Kcgphob5r9dihA+p4c4A1Fvz8ahhNDOZQMQqVABca2EfimARSdj8iuFqvo9pXQKlQhMBTEbinSU/mz30I/anMDRiuWxYWBIAM7nHyeI0F8rislbdeXcwMJoaD8LjVMU+WFmdmAHHW248Kr4zvbiEiGah4r9UdH3pTD/E9DRvATJtH3xHD4adFbTmV8K2WyBJTheOR4Dpm2CXaPssaiEuP3Ebf7qU56V9Z1tLAWcV/35i62lumc1dG8NAa7QGtQAHaEpQ9yGaOIe0xTXD8RGSjTI29ktE7rJgncuWwpQGG8weO15aj5yYKKa+UbXeeNmSYsN6Kb1Mbivzt1gV6BZk5B6TVmuKMG6CHjQWJQkxRgeYuLy
X-MS-Exchange-AntiSpam-MessageData: O/us9TD5FaJraZKlc6mKNDr1vzq1V4lI+hVwMt9yCmR/vPAiCiiO1PSYfNv3Yx5zjgakrntLH+SivE3tKZHSOdC24XrruBbvbArCvTjr/kdTCmP9lWxhCKNnmGsOwpKE9bNHXv156fPsmpUzhMdEEcNkl/l5nfqJ38xIU2A/CJk=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3ff786-7b75-4b9b-315f-08d7d9a1c633
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:41:53.7108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bp6mAOpb/jJ3KuevRyIxycD8OqITXjMIXzPVuHh0SkjhVr6vyL7W713Pbre+xBdI3ReG6EJGIeV9NwXLa/Yo6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Harry.Wentland@amd.com,
 Eric Yang <Eric.Yang2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Yang <Eric.Yang2@amd.com>

[Why]
Changing policy to dynamic will allow 4k multi display configs
to be supported at DPM0

Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 8b7122249ddc..07265ca7d28c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -585,7 +585,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.disable_pplib_clock_request = false,
 		.disable_pplib_wm_range = false,
 		.pplib_wm_report_mode = WM_REPORT_DEFAULT,
-		.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
+		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
 		.force_single_disp_pipe_split = true,
 		.disable_dcc = DCC_ENABLE,
 		.voltage_align_fclk = true,
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
