Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0830BC2BA2B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFA4521841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Lp9R1lhu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA4521841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DE606E15D;
	Thu, 16 Apr 2020 23:41:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E60D6E0EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ff0zMUh9Fhaqqqo7miBI3ljTFivIfWAKgIz9WwJefRSX5FOKiS2lHkUQXReLCNe7D+NCWeSajq+cctX9zli5scJYhZTNV0xyBdr/TE0PxGb/6NH9FiCKEZzlj7nvHPCl+yFWfckBtquqHGidVrjoW1JG2Qj4xsBVJJL3DwTbze44jFR+dKjyWl+SOSsWJe8AEuTBFGu+JQJY++4H6S06hAoaBGeybrRx8Mgeuq8s8w+rnoZue+w0z3dy1cFS1RMMRYxkXBbwVqI+nIFXimRxzChe+BIUsQ8Y+8qUxVau7VIaWm/fre+AgaBiI2h6E/fbQ0Eg0GqvEVdOxpKfMjZ4YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZvKK4HDwiTGGjUZIf2cASWaZr5TA6Fj+cz/PS8hX0A=;
 b=QlFjKET121ajgj9/tKw+aY6buXxC1rjwbV5S3mBKW5Ab+JV9bFSXooekrPSVAncjcf3I8tJI0dE5e0EVJwv9RqBQiZwxQPOvTPh4XS9L+AlixQrkrU7C+dmL5XLBW3WyOYKGteBT6nzBTfWMD1O2cxsAdN8UfWQmxOoEt2a+z79EPVRrmPGIgZh3BiwImL+KdOR2GgiTXNkZizlh08H1H3MPqw/BvHqKo3KQPjqq3bRKAzXUleOXWLHluxkdWIRAQYNmfGwrZAKkueXFmjLb9vW6/a2vroBAdTa35l/KDzsSfn3s4Rl+3Xk4TCHX/FYvoZHPicG0ZGkhpWm0YFnnbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZvKK4HDwiTGGjUZIf2cASWaZr5TA6Fj+cz/PS8hX0A=;
 b=Lp9R1lhucUuEJjDnXaIA95TJl+J+YVXneTSoLipGDWiosuEP0eN/xIbJibyEn4dfHIMaHNvgGQskO9ZvQtW7rqLO6eaDzxe3EmzhPR+0IfhsPGAprsiKOGqPQT1+Ajlq3a8r63klSYVBDWdRAI+XjL4OCKUD/59TymhktNgK9ZU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:12 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:12 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/35] drm/amd/display: Move enable fractional pwm call
Date: Thu, 16 Apr 2020 19:40:12 -0400
Message-Id: <20200416234044.2082886-4-Rodrigo.Siqueira@amd.com>
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
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:11 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 29e9cc19-2fb1-48a1-ea64-08d7e25fa583
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24592B17C92EA1F4C8BD5CB498D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(2906002)(54906003)(36756003)(6916009)(6486002)(1076003)(478600001)(86362001)(81156014)(8676002)(8936002)(6512007)(66476007)(66556008)(66946007)(2616005)(5660300002)(16526019)(186003)(6506007)(4326008)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PIzlQ2QC4UV+gteSASBtcB0rnPPK4D/RZIrhdwE4CwBjJrLAamTMFL51WHIUhoRujNJTb2OsfIDEzsQ3q6QWDR6lQzhSRhzibFXAuxIOL8mSWPft2m85krX7Td+DDZ3zM9Q5alBUea9iTsmpEMpDhiFv1N+C/9dHSmb5S1eCzHnikC3JHmaitrv8gJ6OBCtTsiCfnEmCmcFK/BzJru+XeBEFxlkzKZH6ZygAIlpDNfI0oCvqX1xsaFTshcFFAmCKEs1zfcOfA08KjgRBCuuxpINt3sX2SR0oexdE+24I8RzwqghJyKzKQfOpJ3S8r948ohvuql1KhHZWT9L3HSVGmMumilnhzHMIDnd7r+rsDZoSW/IiGTu/K7vLJ1FjHeg4hTKLULR2yVnnzSRgqpW3ObqDKMz1wDxNXftu0qxASy3FX6bGR0hAUcfVpDcVrw5Z
X-MS-Exchange-AntiSpam-MessageData: B2bCmFKS3hcz/yWsWmhYoy/h/L/AapeQd80svWAkpu/DPVP75a7hORBI00XjFZ7DiiKwdfcWKbtrmU+DkWFgpHeCYStWMoVozFGHCWyZ67fjbFdEv6+1K+tH1fBOaUsbSA+mDGlkGKRIGXevEKv1orEkpyYB/1AeqYHZbUyU4eI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e9cc19-2fb1-48a1-ea64-08d7e25fa583
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:12.5189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSTt6ukpPz7YWZ9OGkEtXYtRAqpRI2vyl72fSijFSUNLWy3vqKo3m8HQYDxwYvbezR6FJhtILaANE25CqL6iZw==
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
Dmcu init fw call has some logic to initialize abm values.  Since this
doesn't exist on dmcub, must find a proper place for it in the abm
sequence.

[How]
Move enable fractional pwm call.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c | 34 +++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index 59b2f0b621bd..8baebb594de5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -161,6 +161,21 @@ static void dmcub_set_backlight_level(
 	REG_WRITE(BIOS_SCRATCH_2, s2);
 }
 
+static void dmub_abm_enable_fractional_pwm(struct dc_context *dc)
+{
+	union dmub_rb_cmd cmd;
+	uint32_t fractional_pwm = (dc->dc->config.disable_fractional_pwm == false) ? 1 : 0;
+
+	cmd.abm_set_pwm_frac.header.type = DMUB_CMD__ABM;
+	cmd.abm_set_pwm_frac.header.sub_type = DMUB_CMD__ABM_SET_PWM_FRAC;
+	cmd.abm_set_pwm_frac.abm_set_pwm_frac_data.fractional_pwm = fractional_pwm;
+	cmd.abm_set_pwm_frac.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_pwm_frac_data);
+
+	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd.abm_set_pwm_frac.header);
+	dc_dmub_srv_cmd_execute(dc->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->dmub_srv);
+}
+
 static void dmub_abm_init(struct abm *abm)
 {
 	struct dce_abm *dce_abm = TO_DMUB_ABM(abm);
@@ -199,6 +214,8 @@ static void dmub_abm_init(struct abm *abm)
 			ABM1_HG_REG_READ_MISSED_FRAME_CLEAR, 1,
 			ABM1_LS_REG_READ_MISSED_FRAME_CLEAR, 1,
 			ABM1_BL_REG_READ_MISSED_FRAME_CLEAR, 1);
+
+	dmub_abm_enable_fractional_pwm(abm->ctx);
 }
 
 static unsigned int dmub_abm_get_current_backlight(struct abm *abm)
@@ -259,28 +276,11 @@ static bool dmub_abm_immediate_disable(struct abm *abm)
 	return true;
 }
 
-static void dmub_abm_enable_fractional_pwm(struct dc_context *dc)
-{
-	union dmub_rb_cmd cmd;
-	uint32_t fractional_pwm = (dc->dc->config.disable_fractional_pwm == false) ? 1 : 0;
-
-	cmd.abm_set_pwm_frac.header.type = DMUB_CMD__ABM;
-	cmd.abm_set_pwm_frac.header.sub_type = DMUB_CMD__ABM_SET_PWM_FRAC;
-	cmd.abm_set_pwm_frac.abm_set_pwm_frac_data.fractional_pwm = fractional_pwm;
-	cmd.abm_set_pwm_frac.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_pwm_frac_data);
-
-	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd.abm_set_pwm_frac.header);
-	dc_dmub_srv_cmd_execute(dc->dmub_srv);
-	dc_dmub_srv_wait_idle(dc->dmub_srv);
-}
-
 static bool dmub_abm_init_backlight(struct abm *abm)
 {
 	struct dce_abm *dce_abm = TO_DMUB_ABM(abm);
 	uint32_t value;
 
-	dmub_abm_enable_fractional_pwm(abm->ctx);
-
 	/* It must not be 0, so we have to restore them
 	 * Bios bug w/a - period resets to zero,
 	 * restoring to cache values which is always correct
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
