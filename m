Return-Path: <SRS0=ovQZ=MN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C82C6377A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 22:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D961361208
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 22:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D961361208
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A3D16EA31;
	Wed, 21 Jul 2021 22:18:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC5666EA31
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jul 2021 22:18:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ca5sn8Wqs5aXBoNGN0vxwaw/ntA1acsUQKVqGRKBhzsuNKiSNie39voTTClqTbizLNtlJLO2SPTx39LJVCQp3ZWENGeXIk7yTLeQkRY9rHqORCnflOBrpoAC7ZfcXwXaWYxRjotoeh1t1n1YXggFSx52EwXqfJlnbqQYFh+uyb+65ZyPo9On9Msp3VCwjOlE0d8xd9qcpHompb3Ou8okf48ozzfKN1u3SDpHuDKq/tbwfaprbqlDFkuIuiGWSR2Bo3jjeE2CjXJfE0jaOoJJalyGXYuf0tohkUrUzfujl6EEf96exReKXhHGrLWuVK6YIbBw+Bw8CLBuQR0LR1Z+iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Trj+N22bei5NlmfDocuMyTDInOmGit+NOKUnikiAlHo=;
 b=G10KgIYf/mWvny80AdJA9ANt3UTzBUao3/MWf9kzxEEN8+bpbcl9beMP9IqY/A28iuU2BPeVN56rqdracspJ6aFLRiiJ33DKlQ25x2oIhHqwreHVY7BH6LFSsiiVJt/eyPbhB/78CpjAyLOEF9wgMNL75LWq7IGSmPB7KZOzzZGxOoywxOf8B89/rJe3VpvoZAzSzqcFr81iHZvuVJJqov6PzVzOM5LRaL9Ol2oYyhIW38cp/WsqERfc2jqGRAV98es0x5gOUW9gMugQ6B123f5qo/3TcizZQV4dZFjFBGuMlpEOCOLNFDcLinW1RS9C3gVffF/NI17rYHjlQWkToA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Trj+N22bei5NlmfDocuMyTDInOmGit+NOKUnikiAlHo=;
 b=G2FiMtDX0+lqHFXjXfq17b5K78m5479EZHibC1DPmZcdFl4M9BR7a1Wwpnbo2SOjMRWpmKxO+LNXafkf35sSHEGTPDW1N8XiIO7t3xuEnqjLLV6j8RtjSwpL3Bb0s5sVW8hW/9+CoCzLVa/9qnB12Yj8sv1/7OLUDLTShGTJn7o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5080.namprd12.prod.outlook.com (2603:10b6:208:30a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Wed, 21 Jul
 2021 22:18:25 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4352.025; Wed, 21 Jul 2021
 22:18:25 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: only enable aux backlight control for
 OLED panels
Date: Wed, 21 Jul 2021 18:18:09 -0400
Message-Id: <20210721221809.216742-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-ClientProxiedBy: BL1P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::25) To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BL1P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.23 via Frontend Transport; Wed, 21 Jul 2021 22:18:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 024aaaf3-d05c-4630-20f5-08d94c957507
X-MS-TrafficTypeDiagnostic: BL1PR12MB5080:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5080EEDB81168886C83D0A1BF7E39@BL1PR12MB5080.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:469;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9dgR/+ur6Dl7eWlFs2J/Q+JjIM89WyyZejts7oSoJv2veHEh2jINwHWQzdqRhOO0N2RYiMILwaCtTW4uzg0JnQrgfiqTvNGuFUietvQfrz4s66Jn8JGwZW+Oy4J43AjDewjJw8BcBbNlgt+HLbnmmLPL/Cps8+8VXo13Fj9Lg1KErr0QLAr/LxQOQ1n2NdG4MU/hBasHPraXvZJ1RtRAzBqgJsgvLC4CNYSgu4946M2YJYRFxKHeS1Imm8rbezE1Cn4ovvwxqzCKca0Viu3E5chSP7rGTG1WSCxHG8fhd4aYqKGZo0Z+qL7LlHFqeRaWL7y98OZ87C8U2hfi6UC0oM1jAmVCBRs/mJh9ut4XhJbynbjHsmOteY31w+IWXqOx5bBALawT2S5YpSufXYdKb0oS+3F4JsAi50kcauZUXcOlAmMKCjqvh6yWF0gYqw2Ar64gbu3QlLJOXfPS3KLkt1x/R2EWYtp/hFfTEDlV45hz7X+XLsmEVfbC1GemszFmfCqpoWfk/1j7f/5m608k/vfUmBmWEiP8TxsnrCoI2zevVnwNfSl06gPJtBbRQu0yin7TPRfSLKWNAAH7dqxmxgErTAC209Oo16vwtyOgi3KvvC5oY9NSF24Quhz016yk7FGC4HANbssfdpk6A7YT1kK4COSzUdvFL9DlxfwenhNuIUYYdfPu1lVCDYtKCsOdmLutHwnVqB3T2hyM8XfaSMN0P4joNhsdDk5tWyCCGIxKq+E2R2F812IUg15/90V5C/QOvEeICTO/taNwmGTkWJFzBa0J/+MFVq2+m0QBcFE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(6666004)(956004)(186003)(478600001)(36756003)(1076003)(66946007)(8676002)(66556008)(83380400001)(2616005)(2906002)(6916009)(966005)(52116002)(66476007)(86362001)(6506007)(6486002)(8936002)(5660300002)(38100700002)(6512007)(38350700002)(4326008)(316002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/peHW+HXlq5vg1f4FTBBFA/i2swhhwJZgbaEUAA9OAgBb5Ywa2WPbmySkpTA?=
 =?us-ascii?Q?cLEX/ohpaRbO4/Ho783pfM6//sQKU/4kWactJ3Ipc0/ldvlXudV9HvnJsOAc?=
 =?us-ascii?Q?cmdimhiJYiB/4V4a6vJR55xXYCv7vjiZjQMzOi5mTOvpksUDji09ZJbGTo/h?=
 =?us-ascii?Q?ewmp2btdlS+KRcIeoekdDgvwELRy3XO4NG6Wzhtl4YLAuNj9GWIBkvabV6JQ?=
 =?us-ascii?Q?6en9riiPxv3+BmXfEGWzIjxaqwIvNcq3WkospzIy4xUa65u3JywVZa5OqJYV?=
 =?us-ascii?Q?egQRj8KxZ5BR2jkKTqQNofK5KjqaGZJulTIJpr7B/T+p8mIQpLIejMnSYred?=
 =?us-ascii?Q?gjpZ+8O95hEHj15N7N9SF2mocegeflpt1V4opAGdEnobv7lkxLe3i1+4/TSm?=
 =?us-ascii?Q?6lwr8nCC0NupZxJHInNhKa5DOmchO+I/1b7pLVqAO3a3/uz2iW7ui7FxQ1HB?=
 =?us-ascii?Q?oGTJ96ws0WdN84fGekN8UuBGz9JMQCCpadRW2y6WowxS99Ldbp/wyIIzEkU3?=
 =?us-ascii?Q?W5bH8BnDKix5VCsku050LQdVgBsco/vYab/hMOSw94lnijpU4eH560xYYCqI?=
 =?us-ascii?Q?Qs1UMCUhnkRUFwg7sEXrk65oJ/47GgqvP1f0rXa3AHd+/Ht+WWkV6OS80Yy3?=
 =?us-ascii?Q?GdrN3zK3Yf8FSXakDjvN5gKZqqgOel1d+CwXecO4WqC7tkNiVSaxWT/589K9?=
 =?us-ascii?Q?RPjXxD1UUGlVA4gOYErqWoQIF16jtIyMUvAlooPp3x8SGxCypvEs/2aSeDqA?=
 =?us-ascii?Q?zWg00SHA14DoH975AV0FeC1alh21KRm5nQvbHvH3gkHGCrbl55Vbf8VrkQPJ?=
 =?us-ascii?Q?NRT3oHklw3mi79cmQrUsyuh+Y1p0zkw4+M1NwPmRTLWac6KoleWYIK2JuaJm?=
 =?us-ascii?Q?GYergLFF+Bg8zJoRMsqCrjfgEhEqB+90XbLoKG7cDzKdYbXOcKOAGk5nD+oK?=
 =?us-ascii?Q?3nNHbSFkFydDqTsf3q5XQ3FxtwUjkowPg0hw/viMDyysCvMJSbc30HEMM/nA?=
 =?us-ascii?Q?2DOzxP6lXVxk94squW5APDuJeE2oQhrBDOt4lzUkBpYohvG7oVTQ4ccDR8bz?=
 =?us-ascii?Q?3JjOuc/jCONalycf01fag5Ay/K67K4qmu/Le/IZLuQR1dRivNadoaemyGBjp?=
 =?us-ascii?Q?Tj22eHRQTjGIsbKB7aErDiFEFWGRPeh+Gmc3UMWinWb3QBh4rFGgBp8oRVrn?=
 =?us-ascii?Q?nFO32G/L9KO1KDQywKP9vQVHlsAXTGzH68vKDlutfHSnWS1qHebJk64mLczZ?=
 =?us-ascii?Q?IME+PfLGs1zeFrKvoZxuP08A9yFVPrfzRWxVLe52Lf9oiI1vCrvXyPSH5mCr?=
 =?us-ascii?Q?FxBcrOSoQ41Ih5/QYAaX5GQQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 024aaaf3-d05c-4630-20f5-08d94c957507
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 22:18:25.2948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqGYEUbBC/zYyq8EWjkzHM9gGjLtZPVn08ltSZlx+oo9MuHbR/oBr3OD4Yc/GOr0UW2oZ3t4tKNdxpJmIaQTVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5080
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We've gotten a number of reports about backlight control not
working on panels which indicate that they use aux backlight
control.  A recent patch:

commit 2d73eabe2984a435737498ab39bb1500a9ffe9a9
Author: Camille Cho <Camille.Cho@amd.com>
Date:   Thu Jul 8 18:28:37 2021 +0800

    drm/amd/display: Only set default brightness for OLED

    [Why]
    We used to unconditionally set backlight path as AUX for panels capable
    of backlight adjustment via DPCD in set default brightness.

    [How]
    This should be limited to OLED panel only since we control backlight via
    PWM path for SDR mode in LCD HDR panel.

    Reviewed-by: Krunoslav Kovac <krunoslav.kovac@amd.com>
    Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
    Signed-off-by: Camille Cho <Camille.Cho@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Changes some other code to only use aux for backlight control on
OLED panels.  The commit message seems to indicate that PWM should
be used for SDR mode on HDR panels.  Do something similar for
backlight control in general.  This may need to be revisited if and
when HDR started to get used.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1438
Bug: https://bugzilla.kernel.org/show_bug.cgi?id=213715
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 12db13d2bce9..986c9d29d686 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2436,9 +2436,9 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 	max_cll = conn_base->hdr_sink_metadata.hdmi_type1.max_cll;
 	min_cll = conn_base->hdr_sink_metadata.hdmi_type1.min_cll;
 
-	if (caps->ext_caps->bits.oled == 1 ||
+	if (caps->ext_caps->bits.oled == 1 /*||
 	    caps->ext_caps->bits.sdr_aux_backlight_control == 1 ||
-	    caps->ext_caps->bits.hdr_aux_backlight_control == 1)
+	    caps->ext_caps->bits.hdr_aux_backlight_control == 1*/)
 		caps->aux_support = true;
 
 	if (amdgpu_backlight == 0)
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
