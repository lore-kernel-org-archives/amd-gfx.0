Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB8BC2BA80
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8219C20644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YWyPMMzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8219C20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66C656E218;
	Sun,  5 Apr 2020 20:41:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB40989FF6
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:41:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfGR43A6XAQOBhYsm2Da8do6ATm9uyLY4E78hxzgZGdzDRtVIzr2QZwurFLAp1VfYhN44tzoZ7shQABwji1BkSALhQslmLDZtQSi0tdeXmAFskf4oJpmhWBXFrYWTqzS/VPLhRyTFzzUCj9gKqes6EPO9Ebpg4EeyOSflvsMsD2Ey0KO9ikRk5waingKmKXDNedwTSdXoLrouloQk0i9P+9jf9b2Gq0XGROaeaReMxlobE3fzVMHMJePDI62L7la1DgpYHMc+5rwsw8B9wAVhr27HdKUVIR3kwU20A3pNQgPW56U0INchmnpUPafFuYr4mKJOrVA+ob1XQ5jDwFtlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaUKQMNVnexwbdDs+euUABaRTds7wwNxjP32SLHKEuQ=;
 b=YVO4V4Dxcl6ZYCN88DTUi7N9iPuB5vMdJ/7XcMK3ymty2NdirV6tJr/dllgELTsD0Hv7/KvUww7byL4DJs+djIBVYNGkIOctl/DxJNst2sh/cNybHRj7uhtFsWghP/t2S/mwLLzBa6BWO15paCv/tFDSAKYujKvqkQlcYZ0JnmzmKCaYvp4ooDt+4MWEQB6ST0Vk68yd3VYY4VgiLbKphIKY8/UThpt/LpNXx7sJeYZaTiKaixvk/VU6EetiZhvSM9W6rmIIzK4SzZW/1aVBeN0JEuaJfR265MeYwIBTNWVkzN6CSZtNHJv9LlHLyx2JdB/L6bQI/Jo03a9Blb/KLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaUKQMNVnexwbdDs+euUABaRTds7wwNxjP32SLHKEuQ=;
 b=YWyPMMzW4XiHfXBU8TpGHrST6wJSCvDZKVuCyc5zXEvFuQ8rK3f5UIL0FLEVkxb9E36gZ/lYjqaNBAEyfOQMJETOANZwDo5veI7vtYYmYN0l22AR0GH4Dw4vCMO3DAMcUpAaihCH+YRzB420im6zQeUHsNLmQ+lNgQlj6yuvYmM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:41:46 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:41:46 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/36] drm/amd/display: Don't change mpcc tree for medium
 updates on DCN20 hwseq
Date: Sun,  5 Apr 2020 16:40:47 -0400
Message-Id: <20200405204115.683559-9-Rodrigo.Siqueira@amd.com>
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
 Transport; Sun, 5 Apr 2020 20:41:45 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6287d30a-a445-4897-2239-08d7d9a1c20a
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB255575838D1D45EE2612BEE598C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(15650500001)(8676002)(6916009)(8936002)(6486002)(81156014)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rDcaJlKM1th1Yi+TmUlRMk2fx0Vne2oxl+9FpJWIrMxJm2lVm1tmXPCkpC1SMKwKW5NgP1X2incQ8iF5iLRxGEi3jetbrTK0IUcnE5brV2idYqpegXIhu7+1+Ruf1Zs/d1uHfFwHNlM78oCGNx+kIspM4BbaPPMJz99k40A8X9X09TGNRoeDKbLm3kZcMjwYKc2M63MhPq1uX6Yqc1TRX7lHXSWidRTPFpGrv4l0Hbqt1eS+pb3XCwRzeffOQagkpwqbeZ5DANmBmJH+svpjTykWBAqrVMt+ti3wZjoP98goJFRzQSWNvYeak7ZrI52zaK9ZYSB4ouSLbrh9c97lPr3lgCkRFJVCs+UiZ39DmQbKarNmzn1X5gYyL5aL1R8LcwVwESIZdhNZzLscEiTVL16I9oPIblJd3y+WkUEOwUSciLq+GNUir+85XI31gC3r
X-MS-Exchange-AntiSpam-MessageData: yhrfo5zKlndM99X5hEm9evkw3roXbsfn59qNXdHLyfQIqB7ppkARJWK0IdJJGlPX6Sr3jmPp2P27YTrUa4tpFvKapgbCUYjK+slmQMA91HxTchaVp+zUYuepRXretgYXXWXmZLeJyjnAiMmvEOoiGQu5+9VADjM57Owzr1vbwzM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6287d30a-a445-4897-2239-08d7d9a1c20a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:41:46.6479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQOSSbNQntqX4mNY234S9DyIhriA+yKIPpw/FMTJ0ONzDUZh1sXsNwWxyNlWUohlZszzUd7fx3M35SZQBviqtA==
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
 Chris Park <Chris.Park@amd.com>, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Overlay planes disappear when the plane's alpha blending mode or global
opacity is modified.

These are considered UPDATE_TYPE_MEDIUM and trigger the update_mpcc path
in the DCN hardware sequencer.

On DCN10 we have an "optimization" to avoid touching the blending tree
on these updates, but this is actually required behavior based on how
update_mpcc is structured.

For full updates we acquire a MPCC for the plane, remove it if it
already exists then reinsert it after with insert_plane.

The call to insert_plane can take an optional mpcc to insert the new one
above to preserve the current blending order. The update_mpcc hwseq
function doesn't do this so the overlay gets sent to the very bottom
of the tree.

[How]
Copy the check over from DCN10 to DCN20. The only time we need to
actually touch the tree really is the full update, so this is also
an optimization on top of the fix.

Fixing the logic for insert_plane is rather simple (cache the bot_mpcc
and pass it to insert_plane) but is a change that impacts most display
usecases.

For now stick with the optimization.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 233318260da4..674e4b8abdfb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2170,6 +2170,12 @@ void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	 */
 	mpcc_id = hubp->inst;
 
+	/* If there is no full update, don't need to touch MPC tree*/
+	if (!pipe_ctx->plane_state->update_flags.bits.full_update) {
+		mpc->funcs->update_blending(mpc, &blnd_cfg, mpcc_id);
+		return;
+	}
+
 	/* check if this MPCC is already being used */
 	new_mpcc = mpc->funcs->get_mpcc_for_dpp(mpc_tree_params, mpcc_id);
 	/* remove MPCC if being used */
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
