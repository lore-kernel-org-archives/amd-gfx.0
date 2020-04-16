Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD70C2BA2B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBB3E21841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hvepA0a3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB3E21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7122988C07;
	Thu, 16 Apr 2020 23:41:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 092AB6E1AA
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZhGYLRBFYnVZCcP7Ic+gsjFpiasLi8X1z2ntaYM4ht8A4KIcd5qif7P11FF6paMtwvr+veoWc1Go/xdPpAWPyqrje8cUeINPDFTCufqoenNYOLcR3aVByV2oUlyzTP/cwuP2c72p3YJok2Q5Iizz/tAYALHUocGDMZOxfs0bmX9p3NVNtZXUoMb8S56cn+PFKEVcxib5s1TL493kS2vviI3cEiKtUYRIUuAjeeF84tQ58y/j3jk+UvOAG1fwrEg2QPRYCPevKkJO9wNr/0dl/8IjBwd/SfvtCsUadqeD2LN8+9QEcaxO1306apqs0FZ8/zu73jbGHHFCKAF2yqUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUClnDWTa/OO23rva097cMKJ6X4Zr2MBKY9P+Mgbeo0=;
 b=Aot7PmllvsvFFgkwXmNrbGZ0K3JUYyebpVqD5NWKut8ngbtdCVse3cOIiAK25aSdaRHClUTXbf7MERX5uC9Wqy5/zP0xD2YmIkyQrse+2RTu1VKIfn9qIupgzyoCEaHe+WGUhMEmXWBOG31qJIcEHoC2vZ3ukic8nMXakWAhtFHsM/jLDm8B92uSoPt9hcymUVeLsaDHrhBZHaLlUHrvZT/7vnVBdA0PXolKQxwW1hdeZCrSx4k3/YUXBFT7ZHdEaookNToTZ1dmRD7rJNZN1EUixK+YaTTPghKtBlemONrKZ7O8jtSjlzIeSRIYtsYmu2qOhRvItG3yfQCxupVPWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUClnDWTa/OO23rva097cMKJ6X4Zr2MBKY9P+Mgbeo0=;
 b=hvepA0a3QD1PFsSVhlYTy/PIm1JY3aAziEHr30LYLTXvDtT5Kwgk8DVUJwRRccbnuToyLMKp4VcMBc7FPI93SIhMZwx9H9JdF4MamGsXIz2kNZ/cVjKvZ8JGe/lfmpK+cRA71ezZ5dmKsv9rx55oc55SyuZZb74yTaWND7lwiks=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:16 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:16 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/35] drm/amd/display: Add SetBacklight call to abm on dmcub
Date: Thu, 16 Apr 2020 19:40:15 -0400
Message-Id: <20200416234044.2082886-7-Rodrigo.Siqueira@amd.com>
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
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:15 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0fe71aad-4ced-4ed0-4437-08d7e25fa80d
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24597BA079D40CC3C80117CC98D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
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
X-Microsoft-Antispam-Message-Info: 5tgIeCTbSB/SN0659DsJ/zeqrclzBQTyfhz8Ia1w5ycMsCb78BqltN426Wlhzvu3iizWVCFPxLMuI7HmCbWyP+YHEZr4ibEBsfdGZzAm4VwWZOJaPSAWfKcpqYOz3wRA1xsEDuVfGz8n4F1aPEZTh5WBS2x1ocsNybZnFJau3yurSicPvcpxefOxPzS+EH2deTP1AcuD3II7wM/qo5+ytLTsQQ/sz0M0Amfj4jGpgm5OZpADRX/V83Fzu/y9TtRUmS/ThAsN4rcZhLlEVSDTNDkRiZBIpKW5pYl2MUWgeN3XwSmTNF/AQ3uZDgn45qHkxWSsjdOizJRRAGXzGhgXk/M4g28S0HQlwxjegH5u6lvw7sNU1piCH2Zh/hPK7yER+t9OLblIIvWe8mT7eLHlrtEI2Nk4Th2Lk7CBuzk/CYZJJEA6Dm58NwxWdfBpgCLH
X-MS-Exchange-AntiSpam-MessageData: inoVUpuEG+z8Ux55kL7jEnIWDTsAIvNOVKag4F/WSxfaSSTxf4L1v0iUwOTs28rvXpYT+bn9EFrXglcUfC0FAJ+YCMryLEWZhhTANsXNXNu34+dnIzy9IN+SDhh4vJC/3Hin+XR1MHjBWGZG/mBnveMDT83vPjW7K1zkaLQ31yg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe71aad-4ced-4ed0-4437-08d7e25fa80d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:16.7805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpAogxPyhydmSr7vmJRKbe9Wlc3k5fT2BqlnzV5Cqm5q1XJiiLOZVzaNikKwPfDa0AbIG9KGrgcE1LbWJS3O5w==
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
Set backlight calls to firmware are are being prevented by dmcu == null
check. Dmcu is expected to be null in this case.

[How]
Only prevent call if dmcu and abm are null.  Also rename variable
'use_smooth_brightness' to 'fw_set_brightness' as it's more appropriate.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 10 +++++-----
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c  |  4 ++--
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |  2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 00f70e43ed76..ef8184296a7e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2455,16 +2455,16 @@ bool dc_link_set_backlight_level(const struct dc_link *link,
 	struct abm *abm = dc->res_pool->abm;
 	struct dmcu *dmcu = dc->res_pool->dmcu;
 	unsigned int controller_id = 0;
-	bool use_smooth_brightness = true;
+	bool fw_set_brightness = true;
 	int i;
 	DC_LOGGER_INIT(link->ctx->logger);
 
-	if ((dmcu == NULL) ||
-		(abm == NULL) ||
+	if ((dmcu == NULL && abm == NULL) ||
 		(abm->funcs->set_backlight_level_pwm == NULL))
 		return false;
 
-	use_smooth_brightness = dmcu->funcs->is_dmcu_initialized(dmcu);
+	if (dmcu)
+		fw_set_brightness = dmcu->funcs->is_dmcu_initialized(dmcu);
 
 	DC_LOG_BACKLIGHT("New Backlight level: %d (0x%X)\n",
 			backlight_pwm_u16_16, backlight_pwm_u16_16);
@@ -2496,7 +2496,7 @@ bool dc_link_set_backlight_level(const struct dc_link *link,
 				backlight_pwm_u16_16,
 				frame_ramp,
 				controller_id,
-				use_smooth_brightness);
+				fw_set_brightness);
 	}
 
 	return true;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
index e345df621a6a..4dae9efebb6f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
@@ -420,7 +420,7 @@ static bool dce_abm_set_backlight_level_pwm(
 		unsigned int backlight_pwm_u16_16,
 		unsigned int frame_ramp,
 		unsigned int controller_id,
-		bool use_smooth_brightness)
+		bool fw_set_brightness)
 {
 	struct dce_abm *abm_dce = TO_DCE_ABM(abm);
 
@@ -428,7 +428,7 @@ static bool dce_abm_set_backlight_level_pwm(
 			backlight_pwm_u16_16, backlight_pwm_u16_16);
 
 	/* If DMCU is in reset state, DMCU is uninitialized */
-	if (use_smooth_brightness)
+	if (fw_set_brightness)
 		dmcu_set_backlight_level(abm_dce,
 				backlight_pwm_u16_16,
 				frame_ramp,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index 8baebb594de5..a19f359e45d7 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -338,7 +338,7 @@ static bool dmub_abm_set_backlight_level_pwm(
 		unsigned int backlight_pwm_u16_16,
 		unsigned int frame_ramp,
 		unsigned int otg_inst,
-		bool use_smooth_brightness)
+		bool fw_set_brightness)
 {
 	struct dce_abm *dce_abm = TO_DMUB_ABM(abm);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
index 0cae258a903e..0dd12c4fc23c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
@@ -56,7 +56,7 @@ struct abm_funcs {
 			unsigned int backlight_pwm_u16_16,
 			unsigned int frame_ramp,
 			unsigned int controller_id,
-			bool use_smooth_brightness);
+			bool fw_set_brightness);
 
 	unsigned int (*get_current_backlight)(struct abm *abm);
 	unsigned int (*get_target_backlight)(struct abm *abm);
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
