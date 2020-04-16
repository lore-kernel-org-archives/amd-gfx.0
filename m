Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A05C2BB85
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEFA021841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EDM/2zOC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEFA021841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93FE86E334;
	Thu, 16 Apr 2020 23:41:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 390236E290
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdwjqWptnznwoOXh3xdHWCu1/641TV18hgD6i8u+p+Sbaj5w+U6niIDIybbZUIYuQ1d0BDhBzcA2s/Q+gDBkBIs6P60Zo2esJVxErYV/b6FSjchPkgeRjqBX8LyUp5AZD2qrVXfU4HbPnHHo7HZQWpD9/gNI0Q/EAYZLaDCbFht5OWXzuyGusidD4q1GrnGTBNsngqPwrPkvfH1fzBYpxDBYQlSLJnnjb1Bo9PQaSp89Ygf76IDmYfJx9Lo3Tl/gyRrCVY52qD5/NqfKWNNywBDPuerfVT0mvN6QF491WF181+miTEqArihdi+mVWin/A8MK+DpSpeK1Ps6idTP+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taodk3nwP9NpSrcC4ZmrdF19Z4b22KmjGPDrTOt3P5Y=;
 b=m0cFeBsJQAKqpfuDmLuzhOQgy8T9BoY19/AjE3nxm/xoBYmy6yY77Liy7RJYpJw7CbwO3DQKkanDXIM85+nfJsPNfqxeuTkzU6hTqv67u0ujzBeU6744v9I/UddG3/lcQkCmG3w/Q0vUzO4qEL0lF2G4INMiaye6iWPnVDdtSlWGWnlDWkYnEPonm3zQGthEa7ScJfCJfn40W0mtaJJoLs+Ut8CwFsKAs0g5Sepk6UBBLz19LjBkXKzSHdAq5EVgwVsEi0Yj00zvgOvv9y85v6mRZioibvLUf+2HNLHtYOwM51bXFMiV84C7lexYKYb0lKCpAc/ANIzwMa9py875xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taodk3nwP9NpSrcC4ZmrdF19Z4b22KmjGPDrTOt3P5Y=;
 b=EDM/2zOCIHmUbcWqZfOtXpP7KFYtghL8uTmDTurWPRGULd7uWh0EdSLdgwMILb/22PZNoic8AXs3SEUZmQ7OenXlBfdM4hYliqWot4U1DkDVovY50bztCsNrfbKwL/9CMt6K0WDBGGwN1qOtq2cpDW5cCTo+NICQIkXJc7Xfm9w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:39 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:39 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 21/35] drm/amd/display: Various fixes for PSR on DMCUB
Date: Thu, 16 Apr 2020 19:40:30 -0400
Message-Id: <20200416234044.2082886-22-Rodrigo.Siqueira@amd.com>
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
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:37 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 89015673-7aad-4ba8-aac1-08d7e25fb532
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB245959ED0B56960D342B57EE98D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
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
X-Microsoft-Antispam-Message-Info: dA5Hf3abOK2VYzxX0ryyhUBMVRx5M4ighlkz9/nrbpECYTzcB1lZT7Avu8yszKMLkHTdrBpYSxXiqV8EioyH2gVQiT7Ep5TdidFRWqX7EbB246zk2fvhc9ydqSu53m8T5rrz0GNzKU2s5xYFluXnSu9N4qKsZ19H99gXn4/46Rf1V2fLwuUr0K2u3QuacNW/Gzg7NPZI79vJ+naOk4A09lalbngukF0G9UHiyHx2Qrg+d3ATuTvPNA+3AP4ijz0JvBFFxDBRTbkH1H0xByfVi9mwL+jnLemtrfAX0PWGY1oF2n7Mz70xw2UMMQEGv8K1hFnQpsDkBDPSQW4UG2Rh5fnUa61pGnwhCT9vKQ2vD96iO6c1+ps8x3u24pWPYKHjNAXULp5DFhzRi6ZfQv8rq3Y3GgE8ye1RpIX+rB0PRrXckleMOjOHQaKhNQQw2coD
X-MS-Exchange-AntiSpam-MessageData: scw/7EAnLG8yGFEC3dgNmhuHvUE8ZOUEEAXi04HS7GXpVAY4PKEy9QO93uJ/WfR/2aRIjeD32ejI1Jkt8MQzKohI50rnwKR2RggaCEN4EK2JM+Oola0SmsEJG9LB67L21INZaOILYzuVKH2476ePJWv5b73j7Y9AeIqbhWjc1cQ=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89015673-7aad-4ba8-aac1-08d7e25fb532
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:38.8380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTPbg7czQrnZbUbgEFy5T+rHCeOJRUywC+Nd5tLWKDSNM+DGueggQEgB0MtMn0N8ygzCcbkpyyYY+bD9KPOLKg==
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
 Wyatt Wood <wyatt.wood@amd.com>, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
- Driver does not recognize new definitions of psr states.
- Internal tool is required for checking if psr is active.

[How]
- Parse psr state correctly so that driver will recognize psr state.
- Add visual confirmation that psr is active using existing mechanisms.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 45 ++++++++++++++++++-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  6 +++
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f9a2069ea30f..c46d4f8d4fe8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -241,6 +241,7 @@ enum visual_confirm {
 	VISUAL_CONFIRM_SURFACE = 1,
 	VISUAL_CONFIRM_HDR = 2,
 	VISUAL_CONFIRM_MPCTREE = 4,
+	VISUAL_CONFIRM_PSR = 5,
 };
 
 enum dcc_option {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index ccd40cffc26c..3b8a49e8e665 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -32,6 +32,45 @@
 
 #define MAX_PIPES 6
 
+/**
+ * Convert dmcub psr state to dmcu psr state.
+ */
+static void convert_psr_state(uint32_t *psr_state)
+{
+	if (*psr_state == 0)
+		*psr_state = 0;
+	else if (*psr_state == 0x10)
+		*psr_state = 1;
+	else if (*psr_state == 0x11)
+		*psr_state = 2;
+	else if (*psr_state == 0x20)
+		*psr_state = 3;
+	else if (*psr_state == 0x21)
+		*psr_state = 4;
+	else if (*psr_state == 0x30)
+		*psr_state = 5;
+	else if (*psr_state == 0x31)
+		*psr_state = 6;
+	else if (*psr_state == 0x40)
+		*psr_state = 7;
+	else if (*psr_state == 0x41)
+		*psr_state = 8;
+	else if (*psr_state == 0x42)
+		*psr_state = 9;
+	else if (*psr_state == 0x43)
+		*psr_state = 10;
+	else if (*psr_state == 0x44)
+		*psr_state = 11;
+	else if (*psr_state == 0x50)
+		*psr_state = 12;
+	else if (*psr_state == 0x51)
+		*psr_state = 13;
+	else if (*psr_state == 0x52)
+		*psr_state = 14;
+	else if (*psr_state == 0x53)
+		*psr_state = 15;
+}
+
 /**
  * Get PSR state from firmware.
  */
@@ -43,6 +82,8 @@ static void dmub_psr_get_state(struct dmub_psr *dmub, uint32_t *psr_state)
 	dmub_srv_send_gpint_command(srv, DMUB_GPINT__GET_PSR_STATE, 0, 30);
 
 	dmub_srv_get_gpint_response(srv, psr_state);
+
+	convert_psr_state(psr_state);
 }
 
 /**
@@ -158,7 +199,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	cmd.psr_copy_settings.header.payload_bytes = sizeof(struct dmub_cmd_psr_copy_settings_data);
 
 	// Hw insts
-	copy_settings_data->dpphy_inst				= psr_context->phyType;
+	copy_settings_data->dpphy_inst				= psr_context->transmitterId;
 	copy_settings_data->aux_inst				= psr_context->channel;
 	copy_settings_data->digfe_inst				= psr_context->engineId;
 	copy_settings_data->digbe_inst				= psr_context->transmitterId;
@@ -183,6 +224,8 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	copy_settings_data->smu_optimizations_en		= psr_context->allow_smu_optimizations;
 	copy_settings_data->frame_delay				= psr_context->frame_delay;
 	copy_settings_data->frame_cap_ind			= psr_context->psrFrameCaptureIndicationReq;
+	copy_settings_data->debug.visual_confirm		= dc->dc->debug.visual_confirm == VISUAL_CONFIRM_PSR ?
+									true : false;
 
 	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd.psr_copy_settings.header);
 	dc_dmub_srv_cmd_execute(dc->dmub_srv);
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 0a996e575b9f..7c7a3561b6aa 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -215,6 +215,11 @@ struct dmub_rb_cmd_dpphy_init {
 	uint8_t reserved[60];
 };
 
+struct dmub_psr_debug_flags {
+	uint8_t visual_confirm : 1;
+	uint8_t reserved : 7;
+};
+
 struct dmub_cmd_psr_copy_settings_data {
 	uint16_t psr_level;
 	uint8_t dpp_inst;
@@ -228,6 +233,7 @@ struct dmub_cmd_psr_copy_settings_data {
 	uint8_t smu_optimizations_en;
 	uint8_t frame_delay;
 	uint8_t frame_cap_ind;
+	struct dmub_psr_debug_flags debug;
 };
 
 struct dmub_rb_cmd_psr_copy_settings {
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
