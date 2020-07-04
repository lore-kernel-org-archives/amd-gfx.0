Return-Path: <SRS0=iabP=AP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FE6C433E1
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jul 2020 01:15:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BE872075D
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jul 2020 01:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EpsoEV59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE872075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AA806EBE6;
	Sat,  4 Jul 2020 01:15:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A339B6E3D2
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Jul 2020 01:15:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+0xqFwJr04OR/DJ2xJSFAa/+4+R0iHS6/WrxWKmsP+WOB8lOT8tukCfMIN7TMTZrDwLAqWhBZO7Qc0rfk9ZBmBh5Uw6Pr6WDUdMYraPE8HL2/jmBQ09jHP1SAFhLwM9o6o63PRAS6S3kbL3lQHXKif7BskwvaQIXgSNgC8S+aP8w+SS9PGwkL5BrC5sP8ajv81+TRjwyaJYPzK+cKvx6ByWBOA2l9ojESzGJaScsdcUx+LovwcI4dOyTYalrUUtiTXhohDgQ2j5iHmOlC2XSzl4WQ7QlxqEX3eHIk6/7aNhCAyThynbEtcMtTiaKfMwHimHezWr9BoAvtBk8gnAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvNFpYuCdNVO01Re1v4GdHfy2aJfrmapbL/ISNjWo9M=;
 b=da8pmj7PA4cKKwPpRAN1QJwR9n96no2TN2AhQe0Bn/nUMz2xXfV0Yv3pKpAEXgWK8y9KLZ016mthNRuar+lGiKngFbN448HtJeulKM3ejhLU0x00Eew9CeZN8lnn09gy4amz7SB59RfMJlrr7Xv/rBOAjTo1XpWTVKeudyLBLfizWzVBeboUDoSpDsT7xt8UCEKKdw3YPocvPF1FzHFy8xnvPoeetDdLBzxKcYsEfmanhL+R2Fe1rDcmTaz7i+rJuYpjJlpvam4Bhr8ip/jK7PToYnNSw+fuctkDaFJxLaDCTqVfrd+6pvx3PDSXcwUkJn8KsxZu0q3kjP4SeaM1/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvNFpYuCdNVO01Re1v4GdHfy2aJfrmapbL/ISNjWo9M=;
 b=EpsoEV59UAs9fAPkEEmqe4AD8kLM4noeG5XbupJIgaf10qtdpfD5m/I5jEKT+3qrucHFRrInsQzmhr6XCRIuW3ZynLZ/ARf5Fn4Mk2zooR6yOeaONBmLdG+Fo3HYFJ+HPFpXbvy/PjtuO9sAtol6RHu4fX/0PurDYLx/GuYxjNs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3768.namprd12.prod.outlook.com (2603:10b6:610:22::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Sat, 4 Jul
 2020 01:15:25 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1%8]) with mapi id 15.20.3153.028; Sat, 4 Jul 2020
 01:15:25 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/8] drm/amd/display: Register init
Date: Fri,  3 Jul 2020 21:14:51 -0400
Message-Id: <20200704011457.2368241-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200704011457.2368241-1-Rodrigo.Siqueira@amd.com>
References: <20200704011457.2368241-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::26) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Sat, 4 Jul 2020 01:15:24 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4096a3bf-baa4-4df5-27a0-08d81fb7baf4
X-MS-TrafficTypeDiagnostic: CH2PR12MB3768:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB37686089188275840385B0DD986B0@CH2PR12MB3768.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 0454444834
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l2nYtsYQGp6h+AGXHkRTzCskam4smPKP71wzMzkPkQz0HKnCp1BXoD+yynul3MGloJzIMTjuclQ5cYBo/YOlExuBhgOEw+B8yqBh3hhYv1XeS40Rxf4BM1xhgtmaYj7y+E2XPz0mTamxZleK/lEUs2ufNW60+JqzkMTgSMK0/s9T2JervplzgLjyLujBZ8kEPScYWl46WfpT85FBxjRh2w55u8FAgux8Znzr1BpJTpriq02UygX6VieZKR18mCKpvrKFFy7xAN5B3Ch8MzDlVLSac5u0+fvkAvNHOTsdOFreTKpq37wDqOB9HbHdGzLR19qFqS6QB5OiV07IHQEQ9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(478600001)(8936002)(8676002)(6916009)(52116002)(6506007)(6486002)(316002)(66946007)(66476007)(66556008)(6512007)(2906002)(1076003)(36756003)(4326008)(54906003)(86362001)(16526019)(5660300002)(83380400001)(186003)(2616005)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Aj1GTomZi4TzBwDg6dlPY7uzszu/td4zfMt+fzvBuFXL0S/j9LSQ2SLL7SAzuIg6Eg4QJXNU4BQSZvHNj31F+jOXEUGWlKb61+JwYfT7VUiVlgKmYFlo8ydUvEweEhmTc+WA5Df0uygqi2y2/R57SjfpWE2O/b2Wo3sIbpUjk2fEOHuGUku8YSJf+ZOFV6H9Kntqb/py0Dw/vjOlxFeZVfliQTiqsBQI1BNZQToE60r4MtCHZtDtd90DWl6p0SWmHmLoE6Ov72M139L3nUMNcSsI/TfWfUQ+AFTuwTqZkyIbvES04GWPyDvcoIs9cZoKshOBXm4lSMVw9OXjBycUj2uLkQxnAnxb8j5TN19IoexB3Dm1yg4azUV6g+by55N7xX2QzcUo92SvKCuOrhyv8vIZKkQ5EcD9WHGmWK8sjYv/5P7aIMmvbG4TBig+FRhrvklXMo6VyCMXdDFChk0ErLaYF6scyANC1lni7EMYvcV+LyEmHuY3obe7YJ06BEqRAZENxSS/fsAsERm7U9wuvA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4096a3bf-baa4-4df5-27a0-08d81fb7baf4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2020 01:15:25.0776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2lnotX040Rh8PFIEyzvpKZdQxqV6Jqonqc1a1H+wIM1sCT3jyfdyCjeDNJNj2digfw/R0/KTd/VB0+q56O5Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3768
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
Cc: eryk.brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Igor Kravchenko <Igor.Kravchenko@amd.com>,
 aurabindo.pillai@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Igor Kravchenko <Igor.Kravchenko@amd.com>

[Why]
Driver re-initialize registers already set in FW

[How]
Transfer init to FW

Signed-off-by: Igor Kravchenko <Igor.Kravchenko@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 58 +++++++++++--------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index cb45f05a0319..6711ff908bcf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1255,6 +1255,7 @@ void dcn10_init_hw(struct dc *dc)
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	struct resource_pool *res_pool = dc->res_pool;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
+	bool   is_optimized_init_done = false;
 
 	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
@@ -1288,7 +1289,9 @@ void dcn10_init_hw(struct dc *dc)
 	if (!dcb->funcs->is_accelerated_mode(dcb))
 		hws->funcs.disable_vga(dc->hwseq);
 
-	if (!dc_dmub_srv_optimized_init_done(dc->ctx->dmub_srv))
+	is_optimized_init_done = dc_dmub_srv_optimized_init_done(dc->ctx->dmub_srv);
+
+	if (!is_optimized_init_done)
 		hws->funcs.bios_golden_init(dc);
 
 	if (dc->ctx->dc_bios->fw_info_valid) {
@@ -1323,7 +1326,8 @@ void dcn10_init_hw(struct dc *dc)
 		 */
 		struct dc_link *link = dc->links[i];
 
-		link->link_enc->funcs->hw_init(link->link_enc);
+		if (!is_optimized_init_done)
+			link->link_enc->funcs->hw_init(link->link_enc);
 
 		/* Check for enabled DIG to identify enabled display */
 		if (link->link_enc->funcs->is_dig_enabled &&
@@ -1332,9 +1336,11 @@ void dcn10_init_hw(struct dc *dc)
 	}
 
 	/* Power gate DSCs */
-	for (i = 0; i < res_pool->res_cap->num_dsc; i++)
-		if (hws->funcs.dsc_pg_control != NULL)
-			hws->funcs.dsc_pg_control(hws, res_pool->dscs[i]->inst, false);
+	if (!is_optimized_init_done) {
+		for (i = 0; i < res_pool->res_cap->num_dsc; i++)
+			if (hws->funcs.dsc_pg_control != NULL)
+				hws->funcs.dsc_pg_control(hws, res_pool->dscs[i]->inst, false);
+	}
 
 	/* we want to turn off all dp displays before doing detection */
 	if (dc->config.power_down_display_on_boot) {
@@ -1379,10 +1385,12 @@ void dcn10_init_hw(struct dc *dc)
 	 * everything down.
 	 */
 	if (dcb->funcs->is_accelerated_mode(dcb) || dc->config.power_down_display_on_boot) {
-		hws->funcs.init_pipes(dc, dc->current_state);
-		if (dc->res_pool->hubbub->funcs->allow_self_refresh_control)
-			dc->res_pool->hubbub->funcs->allow_self_refresh_control(dc->res_pool->hubbub,
-					!dc->res_pool->hubbub->ctx->dc->debug.disable_stutter);
+		if (!is_optimized_init_done) {
+			hws->funcs.init_pipes(dc, dc->current_state);
+			if (dc->res_pool->hubbub->funcs->allow_self_refresh_control)
+				dc->res_pool->hubbub->funcs->allow_self_refresh_control(dc->res_pool->hubbub,
+						!dc->res_pool->hubbub->ctx->dc->debug.disable_stutter);
+		}
 	}
 
 	/* In headless boot cases, DIG may be turned
@@ -1417,30 +1425,34 @@ void dcn10_init_hw(struct dc *dc)
 		}
 	}
 
-	for (i = 0; i < res_pool->audio_count; i++) {
-		struct audio *audio = res_pool->audios[i];
+	if (!is_optimized_init_done) {
 
-		audio->funcs->hw_init(audio);
-	}
+		for (i = 0; i < res_pool->audio_count; i++) {
+			struct audio *audio = res_pool->audios[i];
 
-	for (i = 0; i < dc->link_count; i++) {
-		struct dc_link *link = dc->links[i];
+			audio->funcs->hw_init(audio);
+		}
 
-		if (link->panel_cntl)
-			backlight = link->panel_cntl->funcs->hw_init(link->panel_cntl);
-	}
+		for (i = 0; i < dc->link_count; i++) {
+			struct dc_link *link = dc->links[i];
 
-	if (abm != NULL)
-		abm->funcs->abm_init(abm, backlight);
+			if (link->panel_cntl)
+				backlight = link->panel_cntl->funcs->hw_init(link->panel_cntl);
+		}
 
-	if (dmcu != NULL && !dmcu->auto_load_dmcu)
-		dmcu->funcs->dmcu_init(dmcu);
+		if (abm != NULL)
+			abm->funcs->abm_init(abm, backlight);
+
+		if (dmcu != NULL && !dmcu->auto_load_dmcu)
+			dmcu->funcs->dmcu_init(dmcu);
+	}
 
 	if (abm != NULL && dmcu != NULL)
 		abm->dmcu_is_running = dmcu->funcs->is_dmcu_initialized(dmcu);
 
 	/* power AFMT HDMI memory TODO: may move to dis/en output save power*/
-	REG_WRITE(DIO_MEM_PWR_CTRL, 0);
+	if (!is_optimized_init_done)
+		REG_WRITE(DIO_MEM_PWR_CTRL, 0);
 
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
