Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA40EC35657
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB872067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pKJPLR1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB872067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 475636F497;
	Fri, 21 Feb 2020 16:03:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD5956F497
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:03:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njzoW6+BwFszrfM9XlWECYcx+XGlAiz+jxcAn9ZMTThvxE3eVjt+xxEecdBGnKCakEv/xiXcEnOVMA/pQMqAVSoTdk4FnyD8QwXHRNh8Egbd1ZEcrzzq73s29V0bCtIECwJy6uEiaOoMAc0pWRYjBLjXYXYvQrqEyTWd9doDiLTB5TF4mremwKfQ8VwRQ6mtc8Da1cyrMByswvM70tjhvmu1n+G6TcaXtL6DyCeo4qcffWKEhZ4dDbxVPJwEJesNZ2eDiegBvQmFxaqJFUPQ8k1dniiMQ/IpBVR6Tj/Thrh6xiU587vEe8EM85SIs/r+ykEIkbAsTqdtxqKvk0v1eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPPC7k5S1t/RnsohxaMP9IprA4u6azaannlD1KkhCP0=;
 b=kZlEm5QUG82UYj927dk4/mr7ZkuzEeiRa+Rtc7O/c6L4AYbaOm+E/d8YK0Ak6IkHpEyf1DUOxtrgbflF9i2hezGf2hT3nPn3nzDXMGRd/KtuLrmmrxe8J/q7A1xEgcfxb0QQKBlCF/XoshYSpZR6jySu8hV02T90nSCOAG8D+jqW0utyh8wIaxV9tP6s9W7NErIBfjXgpzdkXG/odJHlqTvr62xqWyGqTnRehpJtFrSqHc/S+LHFM+iJBFOJrrA30ZajNiScoXfuXuNN4BC/VHlVMXWeOFt+MGOdMMOIwmDlZMrbo8GTHg5lpR2hr55dlXSZfoQSEzep9ggll8939w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPPC7k5S1t/RnsohxaMP9IprA4u6azaannlD1KkhCP0=;
 b=pKJPLR1zHty+nzpXf0j0iU0wvfNHMo8kmmStLuiTTmx69l2dcWFJ9syluCFsTi2M/rdDjraqKXJUVviHpiAUHZMoEUPcmcHgfx5iA3/tmhBjIikAkV8LeuG5O9VtIrkUjUnn3aWkHCYy3SduEp4mMqJd+tdrVHX489QVMVePHn8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:03:49 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:03:49 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/35] drm/amd/display: Update TX masks correctly
Date: Fri, 21 Feb 2020 11:02:52 -0500
Message-Id: <20200221160324.2969975-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:03:44 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c13b2b19-8030-47cb-0b73-08d7b6e7a131
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25727F0D887FF4B3D87310CF98120@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:415;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(1076003)(5660300002)(36756003)(2906002)(8936002)(86362001)(8676002)(6486002)(81156014)(81166006)(7696005)(52116002)(4326008)(6666004)(316002)(186003)(26005)(6916009)(16526019)(54906003)(2616005)(66476007)(66556008)(66946007)(956004)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /NYIICB62AeEmmJeBt0rLYzjd9Pxmcs1zgyORvwUuOn1tH9LxohA+bXDPOmrZj2p4kaXhGuuA54nxdsCS726omVFNP1spPsdBvA+vq+XVN+mrYODHOQCfzQgtKKGlxI2Nee4I2PmWs3654l7eJmhlllLDBWB0WblyQ1FFngeoatxfV1bmZdFhj3X8eNTDAMsNTpjo4RzqfVQEjQq5B0+tD3KUXKPR5EGZTd6NpC1t4pfA1DeZvy3pK/LnwUwmTvuBnTgq6TOKiRMCB+Zy9/XeRXxj948pK1YK0XFUrWISfofbwnjNlIuYC2t4nxeNiHXXw6vVGvIz/gzBmDorH5+h+9wHvbLp8UdFqBpsD0HZQwz7CyMiWF7+LobGfNiJ4dps+DP9JVG9Uo3y5+vfvPxRy+VDyumAlnZOdsKY5BnCUCaNVAAF67r9Faoz4DJr0QA
X-MS-Exchange-AntiSpam-MessageData: 2lUHw7VWkzVUsPn7qjPqReVotj9r1uwBX2VDBuM0edtgx18eacJy6uGKCUOoQ0tSpVuC9iZep3+nO1ZCMUY7cuHWyjSTMEvT9hFhLIeCA7VInR/9xsy9hWmr5WYBeTdEGb+iKrZBgOMb7qh36S3zUA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13b2b19-8030-47cb-0b73-08d7b6e7a131
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:03:45.6509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sF7jA+gehYH8XWhg6ou8vdhSJH3Xf2V53VpVmwZIav99rpPxTpjHaeg4ae3szsWyMKWlD1mN+qnrUZInW6pQ6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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
Cc: Sunpeng.Li@amd.com, Harry Wentland <harry.wentland@amd.com>,
 Rodrigo.Siqueira@amd.com, Alvin Lee <alvin.lee2@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
Bugs occur when TX interrupt comes in when no USB-C on board.

[How]
Check PHY for USB-C before enabling TX interrupt in DMCU FW.

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
index 30d953acd016..f0cebe721bcc 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
@@ -378,6 +378,11 @@ static bool dcn10_dmcu_init(struct dmcu *dmcu)
 	struct dce_dmcu *dmcu_dce = TO_DCE_DMCU(dmcu);
 	const struct dc_config *config = &dmcu->ctx->dc->config;
 	bool status = false;
+	struct dc_context *ctx = dmcu->ctx;
+	unsigned int i;
+	//  5 4 3 2 1 0
+	//  F E D C B A - bit 0 is A, bit 5 is F
+	unsigned int tx_interrupt_mask = 0;
 
 	PERF_TRACE();
 	/*  Definition of DC_DMCU_SCRATCH
@@ -387,6 +392,15 @@ static bool dcn10_dmcu_init(struct dmcu *dmcu)
 	 */
 	dmcu->dmcu_state = REG_READ(DC_DMCU_SCRATCH);
 
+	for (i = 0; i < ctx->dc->link_count; i++) {
+		if (ctx->dc->links[i]->link_enc->features.flags.bits.DP_IS_USB_C) {
+			if (ctx->dc->links[i]->link_enc->transmitter >= TRANSMITTER_UNIPHY_A &&
+					ctx->dc->links[i]->link_enc->transmitter <= TRANSMITTER_UNIPHY_F) {
+				tx_interrupt_mask |= 1 << ctx->dc->links[i]->link_enc->transmitter;
+			}
+		}
+	}
+
 	switch (dmcu->dmcu_state) {
 	case DMCU_UNLOADED:
 		status = false;
@@ -401,6 +415,8 @@ static bool dcn10_dmcu_init(struct dmcu *dmcu)
 		/* Set backlight ramping stepsize */
 		REG_WRITE(MASTER_COMM_DATA_REG2, abm_gain_stepsize);
 
+		REG_WRITE(MASTER_COMM_DATA_REG3, tx_interrupt_mask);
+
 		/* Set command to initialize microcontroller */
 		REG_UPDATE(MASTER_COMM_CMD_REG, MASTER_COMM_CMD_REG_BYTE0,
 			MCP_INIT_DMCU);
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
