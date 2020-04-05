Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E099DC2BA80
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B517320644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GU3cNcio"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B517320644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA1726E264;
	Sun,  5 Apr 2020 20:41:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 691026E264
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:41:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzUWpEFTs98B16fFkNrM6O5eTLHr6l15hb6LDnKMny96JgxuryH+nRdtEQQ9yuEC2Ymu6tyATg5LmzrWY/E51ClzfzwyiYEfNBYtQ9xHaC3WH4JcfPiSUli9PQl2ouIHESnRf5yljBWDyO7dDSqprh4D36IsXVFiRQA0JyTmLA6Zy7mY/+qJy1JPblGUI2v3JfhACEKUiq5RBJVZFwwYmzO5u+kC2ohZHWrBaNyagy9AMAz185GPZCOHIcgfusk8qXohC6RZbkKH/Ew2GQ0kS1400aUX8/hIbudUtWCcgOXh91m28AhYKFQcXo+yXq3uGr9LFcUiLJ34OT/ejFNOiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efloCEf5tCp1jIhrI7z8vuXT799WCd6mgMcX11/NTnw=;
 b=lpqfsnaEd/VNYtVIuIp1tAIS9Za7Spr9ufs16T2ZuRtlwJUsi7psyL7DUT68xPR0kau1yJ+3MGdlyCEvTDhyXo/ScX2I+79RjHqZUA9CgXMTGJ/TgeVktdZbMvERifHmdnYWODk3d7u8yFArdvll334zkcY6XzofdotZA5dIwe7G7vm5AN4yKsDu4ONiXzUJJYFvifCdFMdOob3qiGaba8idEGxQGwl4rt4fyhzbnXnKyoDPU+OsZbYpVJptBtWmQVSsQmwg91AJApuh5i9kG/6qx5xU7I33EUV3pgCbityGz0NYKu6zOKoZN+ONGEsgZtfzSTPZKdXRj7CZB4D3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efloCEf5tCp1jIhrI7z8vuXT799WCd6mgMcX11/NTnw=;
 b=GU3cNciogpmEN286gzLZrjm9/U+gpm4CLST91HIj+15inHxMEQf3Rh20s09GV6em3y1+puUIsfYq3YXsIljXnJLYvphDw0q05UHRUN9HEmxXQZcEf2sWcbEPEZrJAIhIbaU4uiJ69rhMsXIcOmEKd7qx21PuVQggSTpkzKoWFOI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:41:51 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:41:51 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/36] drm/amd/display: only blank dp stream which will be
 powered off
Date: Sun,  5 Apr 2020 16:40:51 -0400
Message-Id: <20200405204115.683559-13-Rodrigo.Siqueira@amd.com>
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
 Transport; Sun, 5 Apr 2020 20:41:50 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4ae0223d-9629-4881-b401-08d7d9a1c482
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2555365ED52142EACB4FE74898C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
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
X-Microsoft-Antispam-Message-Info: Jhb3WHK0WJg9GjHviI9Z5oCtUyjU068PecAZpFv35KaLbauWHOKZzMAcQSFt80yk58tbEx7gRU0AfulE36yc+w4zJn0V9Mz40omcowXcGMofM1c8EjHXNDJnDUb4auqs9MFRf909mH8YTUCM5b9x3BIRPagl1N9B/2qrdtEBEMCaEciIGlfLnW5ah5ZolFFQrUxyFsuN9L0fvZJ+WUPxnXGIrpuE8udsxkR5eY99wC0bK7dAqRwkn0TY+FpjucJR98Jioe3p78Cp4jcU5FGeictyjPGN/oOzpTx9sUvw/GTtiy467To8jVd3kzTRWhvddMzdB61f7knqt5B/Nc8/XYNMVxamXubaaJFwEyVokQxGx57DyHp9MvyoTfu6+7QkbkG/Pi293u4hkke17Vhy+zeWRC+cqJraDg4M6DTAA9IvGGFH49+1t5XhP7mRhB/1
X-MS-Exchange-AntiSpam-MessageData: yEEP2WRob3KYFAcBLfBw4i9pfYPjwbIHFbK94vX1ZH7uXsYVas29Nld1E8U6Me07mclOZsH6URXQSa9PtBlsC0ZgCDxdiT54NAvF/kfWW754XecusVzXh8E5XknsNXAyQf44muqLpGDdWHPGbgln6tokBybQlbyEc8MOwOmmZzE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae0223d-9629-4881-b401-08d7d9a1c482
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:41:51.0244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxrLMfHGyZ2BbjYLfbd6jPb+nrOaELTkIbqj3+JbaAWfC2fDfch8M5iYRggRXciqwGeco5bzCT74H2ZHPEzeFA==
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
 Xiaodong Yan <Xiaodong.Yan@amd.com>, Yongqiang Sun <yongqiang.sun@amd.com>,
 Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaodong Yan <Xiaodong.Yan@amd.com>

[why]
blank all dp stream would impact edp

[how]
only blank the one which will be powered off

Signed-off-by: Xiaodong Yan <Xiaodong.Yan@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 25 +++++++++++--------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 6086bbec94fe..ac133fac4dfc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1238,7 +1238,7 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
 
 void dcn10_init_hw(struct dc *dc)
 {
-	int i;
+	int i, j;
 	struct abm *abm = dc->res_pool->abm;
 	struct dmcu *dmcu = dc->res_pool->dmcu;
 	struct dce_hwseq *hws = dc->hwseq;
@@ -1328,14 +1328,6 @@ void dcn10_init_hw(struct dc *dc)
 		uint8_t dpcd_power_state = '\0';
 		enum dc_status status = DC_ERROR_UNEXPECTED;
 
-		/* blank all dp streams before power off receiver,
-		 * this should only impact DP
-		 */
-		for (i = 0; i < dc->res_pool->stream_enc_count; i++) {
-			dc->res_pool->stream_enc[i]->funcs->dp_blank(
-						dc->res_pool->stream_enc[i]);
-		}
-
 		for (i = 0; i < dc->link_count; i++) {
 			if (dc->links[i]->connector_signal != SIGNAL_TYPE_DISPLAY_PORT)
 				continue;
@@ -1350,8 +1342,21 @@ void dcn10_init_hw(struct dc *dc)
 				/* if any of the displays are lit up turn them off */
 				status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
 								&dpcd_power_state, sizeof(dpcd_power_state));
-				if (status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0)
+				if (status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) {
+					/* blank dp stream before power off receiver*/
+					if (dc->links[i]->link_enc->funcs->get_dig_frontend) {
+						unsigned int fe = dc->links[i]->link_enc->funcs->get_dig_frontend(dc->links[i]->link_enc);
+
+						for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
+							if (fe == dc->res_pool->stream_enc[j]->id) {
+								dc->res_pool->stream_enc[j]->funcs->dp_blank(
+											dc->res_pool->stream_enc[j]);
+								break;
+							}
+						}
+					}
 					dp_receiver_power_ctrl(dc->links[i], false);
+				}
 			}
 		}
 	}
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
