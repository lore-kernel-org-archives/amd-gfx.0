Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DA8C2D0C7
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1942C2077B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UmOLh6Au"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1942C2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35B7D6EB83;
	Wed, 11 Dec 2019 15:33:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12FD26EB73
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkxWRneG+kUlBjrOV97PtheSS/wyHzXOypOC9QxVTkjsw6SqVoASj13RL3otrGAYtj0436yUwJ71wvoCeX2ny8nINZvX6W230+5UVDFOqhnPw7pckx5CsD9oDESMOyYr26EFo3UUWJHGMFbf4NtYeCPkpiLiHYncbRTwLNsBHZ4z5rZo1zm+p7NiPMf427U/5EuUalYNeWAQ860PqQrhGNCvr/TZJ7cQa71KrUFMa5XJxidWppf3dmWpTFcAdnE5HDvG8MHI5gEN/y5deu/pcIvBSDJgxI90E0SHyaYmF53gWBT4c65PAl6FaldtMteqflHYTSkf9UAled127FwREw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGOlKv/sPucqv9Eia1KDYgFodIxjSB2wLUT0Ce9Cj1U=;
 b=Ctt47bu2ku8qajg/Jv/ilnWrV1WbXTRjDvNTTCz6DGqC5JpYXjU+6Jx/tqRI1sQgrqOhOTOVwHAehh2XNAnSvn+ErhNJB1p/aD5jvKjFZ0vAYKp1OY0DTzNwiLFPXsyrv1rgoacBNMmJC2mdIFytGmg1Csu3oPjoSsOi+deBHRKD524vndf8x7vQuYvDB8+cLOM2enl4IC2iAuHl3Y95jiFVarWROsthzouzReX3a/QX37nfvetMXG3T2OuS3oyyZyVz28K0F1IJAxEU9WOGB6gneIN894zFBqsUtI8ennYYS0rQ06K3XFERTbaPdF55bQ1NXOaC+XBAwapyqa9rFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGOlKv/sPucqv9Eia1KDYgFodIxjSB2wLUT0Ce9Cj1U=;
 b=UmOLh6AukYJMR6ndY6WMlp2mMnpmN7LnrzOZuyzE6NATfnMlYZ4sfpknwqO3URTnDJqCCpkIs8+zTxq3eFe/5+ZcLSqQUA6fgePBZhxtUmoHRuu4Y/gDRxCRwEF6G63kJ+dkxf6JExjtiYE8XgWGYDITymVsTvj69HeFNseROhc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2426.namprd12.prod.outlook.com (52.132.184.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:26 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:26 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/39] drm/amd/display: Use pipe_count for num of opps
Date: Wed, 11 Dec 2019 10:32:25 -0500
Message-Id: <20191211153253.2291112-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ced886a8-b7b3-467d-f8ac-08d77e4f772e
X-MS-TrafficTypeDiagnostic: MW2PR12MB2426:|MW2PR12MB2426:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24267277CAF135D0DDE1D1DF985A0@MW2PR12MB2426.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(199004)(189003)(86362001)(6512007)(1076003)(478600001)(54906003)(4326008)(6486002)(66556008)(66476007)(66946007)(2616005)(316002)(2906002)(81156014)(8676002)(26005)(36756003)(52116002)(8936002)(186003)(6916009)(81166006)(5660300002)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2426;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OUB7WZHGsvfs/796ftKrRUVy0UUZPptvRmFQDd7XApIB9nVD36KWJwkgd9bWM7WBm77+lreza787gDPhvnPSu1LjJc8HjsOXkdOFY8MjQrnqLSSQP3MI1uep2oTcn2fP4IGg3mJPka13YXufRt8ooIPQe0+F63okGN038Qr3FttCOAibg7lv8FeLtDsAf9oADWgKLLVxeQwNUn/LJm4vJlRT6dyRcRy0pIJHHq0Sqe5zeTl6Uic06d9MMw8xkU663oEThLLxbCdyf63uCRNe3MRO8sVMLwEpx9v611sMWBGTzktgNIzgpmMhbsYcFJ7wyz6MiInnQlhZvZiXilObgFSj03iNMnPx0790iTN5p1MFwS5TjtRUFa/9AvIFdwI9n81+jrDzhSLz0olD1wDYtY4AmZIJemRrrkWUELhhSsYx94Wgban/S2zi+12j8kMB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced886a8-b7b3-467d-f8ac-08d77e4f772e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:26.6076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9vzhQoAJSa5uruAiMl0NE0so0pqMuPhPN3xsNpD/R+RUPrvQWrEgNoiQ8XwFS3zKGe8nuLjwNMK29xNlGlXXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2426
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
 Noah Abradjian <noah.abradjian@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Noah Abradjian <noah.abradjian@amd.com>

[Why]
There is one opp per pipe. For certain RN parts, the fourth pipe is disabled, so there is no opp for it.
res_cap->num_opp is hardcoded to 4, so if we use that to iterate over opps we will crash.

[How]
Use the pipe_count value instead, which is not hardcoded and so will have the correct number.

Signed-off-by: Noah Abradjian <noah.abradjian@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 32878a65bdd7..cafbd08f1cf2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1357,7 +1357,7 @@ static void dcn20_update_dchubp_dpp(
 		// MPCC inst is equal to pipe index in practice
 		int mpcc_inst = pipe_ctx->pipe_idx;
 		int opp_inst;
-		int opp_count = dc->res_pool->res_cap->num_opp;
+		int opp_count = dc->res_pool->pipe_count;
 
 		for (opp_inst = 0; opp_inst < opp_count; opp_inst++) {
 			if (dc->res_pool->opps[opp_inst]->mpcc_disconnect_pending[mpcc_inst]) {
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
