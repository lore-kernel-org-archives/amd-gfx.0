Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2994BC352BE
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0006E21841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="M0GaB0J1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0006E21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE1076E290;
	Thu, 16 Apr 2020 23:41:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B95C6E290
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSJqbtmGGT1wv2gc3x+maOPR4sEPRlPUHJeyrFFicOIsgfumJ31FgOPRvOP5bqwz+kHv7JI2RlzGp/HhYZG1zjzqnTVE2MoMIwpw5M8TqUbtIjM21qxhfT0dqk80JUtrQS+RTA5MUouYoH4stfOV6Q/3vmjMHnGuKLt/oYdAXbHC7NYPeOj3dO/LxXrXIyOqBvdMTvbZDzgnKaK4TKBnkFEowWT4D7Bw1LtalJ7Ig9oY949xkD/KYRGmmbP+zTfzBSFrcywrMO7VAzB5jMpLdvr8++Y4IxiClU4gvMEjCEFCAuGOCelWDl55wqT4irHrGbVIujwm9bLl/3DvqPFEgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pbtlhyu2U18wNba+O5sBzR2d+iC+QNZrVGsFghRdyEc=;
 b=Irxr3AVtNgP7PwRXpCWXqvSBehsuE87HObhs8bvea5jnZw9+nhhtw6cNZgbyPzmGZF3lagA0uqtrpfVgnDbTwIPiGcYTJfwI8Fs7+A46qQIM1/IzPgeHvoXJwT5hrnATlAszcgGTLtJD3Szu8EO5+mPl9vkGEfxWWiAOdYp5H5GokAOF+0Wu0WszFyjH0JEtUPzoAtcTTkiXJi6ghcXc4CK1WvNonKlltteISyf1vxac9E2qiLjaDPLWWb2QX4BjPKb1WQUV21KLXiJGCvtvy5PaUHWkvezo2jSOmN2M9MebkBMbBiUZ4sQ4KZqSRkwgH4E3g0jFVmb2Dbuy34LDRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pbtlhyu2U18wNba+O5sBzR2d+iC+QNZrVGsFghRdyEc=;
 b=M0GaB0J1i0w5bZeg0nNMEKP7eHXDWLs2DyMlQP0bclZIUTCEE6Jp+bDGwP5uUr5/t+YZrImNca5TW0OZdkQFQtpY59UhJic5ENN38nJAP5EWq7BpRSBMoBDocHMwfZMOaNh0Pr3llJRW9wL+gt9YQgciXU2axL9FVJQ/9sqK5C0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:36 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:36 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 19/35] drm/amd/display: Update MPCC if requested
Date: Thu, 16 Apr 2020 19:40:28 -0400
Message-Id: <20200416234044.2082886-20-Rodrigo.Siqueira@amd.com>
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
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:34 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 353074f3-4df7-4d6d-35df-08d7e25fb375
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB245901A3BC918657CACC605298D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:331;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(2906002)(54906003)(15650500001)(36756003)(6916009)(6486002)(1076003)(478600001)(6666004)(86362001)(81156014)(8676002)(8936002)(6512007)(66476007)(66556008)(66946007)(2616005)(5660300002)(16526019)(186003)(6506007)(4326008)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tAloEcWiEIVIi8f2BDRk2FFmc3lgvrNILncFOgUv/Bz5yY9/evS/2i1h94pTcWjP8wzJ7P1svU7LOnussFRn0VWVvLDNWHTKK7ljPkLMaoS60e2/zZ+jzrwYTzakRcuTpsrpMl4ymFezs7t+MdnSd8mEe/hhFJgbi/xfGeY4eEYwI+VGx8gBdLvU0rZ+IM01ue4uwqAC6uDE40bzwG8eWe1itHAJKMgOI6F4HjVamtLHz4y7Ig8tDdhGxF2Vbq7M8Ud/FC+JDH4UuK7kF1VloIUz//GW/f6WR80OZdj3ucWqKqn1SK/FpP1nqeI1Z7yWyZgeB69Ar8omxvWp1wWm9PypRPV76xMOAkcr4IBn3ub0zyX/HnoCiRrSBzrNt+kBquA+BtMRFC67BuDDwGKWyTbduBjyoW6NQ4q59isYcuheOC9LHGWoZxmQsZ5C1C2t
X-MS-Exchange-AntiSpam-MessageData: FZBDXheRA+YsXHxybBi2O7ALDrWnPGtQn8Y/Dn/KYVwk1EgSZgFrqGDGRfEa/Ju+6mpYI/P/ecuO32HOpmb33rUle+oKzpWS+dQdHposZoKo0uuZIlRoz/yqzFZOKL7vQN3ThlCbufeV8y3UAykgBoMYRT7Dig3PHesDi6MCM0k=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353074f3-4df7-4d6d-35df-08d7e25fb375
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:36.0036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +U2FZEvh+KPxoH1I0XnZ6wtCt5CcJgKTOx7BOXD6w579hur+dor7edlOhv5tbm9IE8NHk1JdR+hzuxcr5I+bNA==
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
Cc: Joshua Aberback <Joshua.Aberback@amd.com>, Aric Cyr <aric.cyr@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Don't skip MPCC tree updates if requested.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Joshua Aberback <Joshua.Aberback@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index efc7fb4cf44d..6ad4ed7da629 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2175,7 +2175,8 @@ void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	mpcc_id = hubp->inst;
 
 	/* If there is no full update, don't need to touch MPC tree*/
-	if (!pipe_ctx->plane_state->update_flags.bits.full_update) {
+	if (!pipe_ctx->plane_state->update_flags.bits.full_update &&
+		!pipe_ctx->update_flags.bits.mpcc) {
 		mpc->funcs->update_blending(mpc, &blnd_cfg, mpcc_id);
 		return;
 	}
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
