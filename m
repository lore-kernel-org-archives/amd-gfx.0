Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EF5C2BA2B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D455421841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VtHE10ZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D455421841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 806EA6E34C;
	Thu, 16 Apr 2020 23:41:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 178456E334
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ED2MG16V3P1EkW+gkrTVxh1QYDvszFYCSAXIqWiiK+wwGqux5FIxEgfldmTyFI/K88ANjHIeJ/VnPJuRnsVNob98Z9JUwYi/PNr5+regaQ/jj8wIaxAvmHfPYipjwM1R/1PpTf9UEMm0ruDjyr9lM9agON1E0MGlljk8Z2Vos5+cM+Re9cqpyV47EC6/Rxk9MXaBDUiLPrOgZKohXVLwbjm/1t9NySAPhSxdyMKk7UpLmF4j0j2mWVLKhj7OH+2nDAsaMQZ1OPbWydPtPjQjvJ72KyYQw3oQPCSAzKMH4FSGm8XaQps1KtcN16QqyIIgp9h+85HwoaOyCzE0IpWnYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zybr3ds3lC4Fkkig8abGi7lvzCr8Yjl1SKuKbCut2BY=;
 b=Kzn9BSmJIG2h2A6jxMubGL7NpnWduDaR9S8a4IWxpMvt8P/Fz2jev/mb6763jUQ0uzBd9ZxSunROJyja1GEwfN85FM/qfBuJ1aq13XOhyxxD6VP4q46f/yHYu0ifqCqmr1a1Vu3s0MnmjyBl4IGMF0M5mTZ50HSrzcswEymI12UwxCk/bU05lGufgKRsW6Mysz6oMhyhhpS4BBnJ+06bb+BsDLM+BEp3y/hAVpkBvpX7PMLp9W9JVs292GIBzlcwjSe0f1IhDFxPDZ4vGAb4zIO9zbXrfcCDx6j5z6A+3vMhno3w9C6DcbNl1j8jbNJbryA7+LF2FgUIAnzgbHqgUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zybr3ds3lC4Fkkig8abGi7lvzCr8Yjl1SKuKbCut2BY=;
 b=VtHE10ZMYAohZ6YyZkqMEFZiLdMFoEmCrnDbMPyEgJQrCOdKenXjupxvGP84uKwodFw2cFR6eqYK0b7s1lbrDekO7RbILnelmEGUkdCYBH2GHU5LLwR3wcQzSMZbn8tX822igGGjPYlhBObwh7D93edgWyz4XK3cmWXySftB1ng=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:42 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:42 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 23/35] drm/amd/display: make all backlight calls link based
Date: Thu, 16 Apr 2020 19:40:32 -0400
Message-Id: <20200416234044.2082886-24-Rodrigo.Siqueira@amd.com>
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
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:40 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 17298cb0-efcf-49a1-c414-08d7e25fb6f5
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24591F3EB77246BBF5D8554C98D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:215;
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
X-Microsoft-Antispam-Message-Info: AzxBgkwfmgngDg0AgEXWRGsvgtwFsIbAwu1XHijsXEIb3m68Zf3WP0YwEECzBkdsNEVHgo61sIO7XeYDw0IDVZTGGkqvr4C9QjWsLyagMgl+ZdrkHyQr0fpB6ytZxhURyu9db/GICT5extTa/mHTKz4BS6Hcngz9a0CdvXGL9rdccK3M9u8QlX8RK0A8bICM/+ogPdUP+RBnKuVMTEwy6HLEvEm5dNgyRENZvTZZ77kvbll17/ETRDbI7EFeDN3mo2DAX7yOnEg7kKaf8siDNJHKYjYWq4oz28jz+nV++Q0KK4mMWhoLPyR7SjEJNI4x23CyxnCtlz8F1jm3PI6nn/PAwJgtebhrMDy+Vrq2y67TG+Lt8/UQerJol10r6pKzgYtWDFDlS31AOcOHbSqMpiGHKVsmdTIzlv4STi8QWy1sQHLOtdKKt8b8m6MdfwZ8
X-MS-Exchange-AntiSpam-MessageData: 5tKDqqsGQ91xGVd6QT3L1WhH1Kw83dU8ZvRthGIaYmveYRw/n/Vj8TgYESNFJez4ydVmFgub62tCzeEDw0nMBVhTQINE8HmylzOoytCHbybVwRpA6/k8OWncak3UIRAXn4ncxVRJQorymUHS2LvRpvF1H/QUvHrE0cui4KkAcuU=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17298cb0-efcf-49a1-c414-08d7e25fb6f5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:41.8083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onJ+c8FyNfnuBe8KhdpiX3fuaL60KQKkO1z5aa6EeMJRxhHgh7efwagdWRKc+ggl0xH8ZbZwMRtEqsBGg1eiGA==
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
Cc: Sunpeng.Li@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Rodrigo.Siqueira@amd.com, Harry.Wentland@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Why]
Backlight adjustment is tied to a specific display.  So make the calls
target a link rather than making it a global state.

[How]
make all backlight calls link based

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 10 ++++---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 21 -------------
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 30 +++++++++++++++----
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 --
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  2 ++
 5 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 4b695f6a80c6..b3b7efd973ca 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1228,8 +1228,9 @@ static int current_backlight_read(struct seq_file *m, void *data)
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *dev = node->minor->dev;
 	struct amdgpu_device *adev = dev->dev_private;
-	struct dc *dc = adev->dm.dc;
-	unsigned int backlight = dc_get_current_backlight_pwm(dc);
+	struct amdgpu_display_manager *dm = &adev->dm;
+
+	unsigned int backlight = dc_link_get_backlight_level(dm->backlight_link);
 
 	seq_printf(m, "0x%x\n", backlight);
 	return 0;
@@ -1245,8 +1246,9 @@ static int target_backlight_read(struct seq_file *m, void *data)
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *dev = node->minor->dev;
 	struct amdgpu_device *adev = dev->dev_private;
-	struct dc *dc = adev->dm.dc;
-	unsigned int backlight = dc_get_target_backlight_pwm(dc);
+	struct amdgpu_display_manager *dm = &adev->dm;
+
+	unsigned int backlight = dc_link_get_target_backlight_pwm(dm->backlight_link);
 
 	seq_printf(m, "0x%x\n", backlight);
 	return 0;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index d5ecf2031255..0f7810571be3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2646,33 +2646,12 @@ void dc_set_power_state(
 
 void dc_resume(struct dc *dc)
 {
-
 	uint32_t i;
 
 	for (i = 0; i < dc->link_count; i++)
 		core_link_resume(dc->links[i]);
 }
 
-unsigned int dc_get_current_backlight_pwm(struct dc *dc)
-{
-	struct abm *abm = dc->res_pool->abm;
-
-	if (abm)
-		return abm->funcs->get_current_backlight(abm);
-
-	return 0;
-}
-
-unsigned int dc_get_target_backlight_pwm(struct dc *dc)
-{
-	struct abm *abm = dc->res_pool->abm;
-
-	if (abm)
-		return abm->funcs->get_target_backlight(abm);
-
-	return 0;
-}
-
 bool dc_is_dmcu_initialized(struct dc *dc)
 {
 	struct dmcu *dmcu = dc->res_pool->dmcu;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index a926c1c3f57d..a784fd2078a8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2450,6 +2450,16 @@ int dc_link_get_backlight_level(const struct dc_link *link)
 	return (int) abm->funcs->get_current_backlight(abm);
 }
 
+int dc_link_get_target_backlight_pwm(const struct dc_link *link)
+{
+	struct abm *abm = link->ctx->dc->res_pool->abm;
+
+	if (abm == NULL || abm->funcs->get_target_backlight == NULL)
+		return DC_ERROR_UNEXPECTED;
+
+	return (int) abm->funcs->get_target_backlight(abm);
+}
+
 bool dc_link_set_backlight_level(const struct dc_link *link,
 		uint32_t backlight_pwm_u16_16,
 		uint32_t frame_ramp)
@@ -2507,14 +2517,24 @@ bool dc_link_set_backlight_level(const struct dc_link *link,
 bool dc_link_set_abm_disable(const struct dc_link *link)
 {
 	struct dc  *dc = link->ctx->dc;
-	struct abm *abm = dc->res_pool->abm;
+	struct abm *abm = NULL;
+	bool success = false;
+	int i;
 
-	if ((abm == NULL) || (abm->funcs->set_backlight_level_pwm == NULL))
-		return false;
+	for (i = 0; i < MAX_PIPES; i++) {
+		struct pipe_ctx pipe_ctx = dc->current_state->res_ctx.pipe_ctx[i];
+		struct dc_stream_state *stream = pipe_ctx.stream;
+
+		if (stream && stream->link == link) {
+			abm = pipe_ctx.stream_res.abm;
+			break;
+		}
+	}
 
-	abm->funcs->set_abm_immediate_disable(abm);
+	if (abm)
+		success = abm->funcs->set_abm_immediate_disable(abm);
 
-	return true;
+	return success;
 }
 
 bool dc_link_set_psr_allow_active(struct dc_link *link, bool allow_active, bool wait)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c46d4f8d4fe8..5432ca1657b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1139,8 +1139,6 @@ void dc_set_power_state(
 		struct dc *dc,
 		enum dc_acpi_cm_power_state power_state);
 void dc_resume(struct dc *dc);
-unsigned int dc_get_current_backlight_pwm(struct dc *dc);
-unsigned int dc_get_target_backlight_pwm(struct dc *dc);
 
 #if defined(CONFIG_DRM_AMD_DC_HDCP)
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 34c6527c7c3f..72b22dd50f0d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -217,6 +217,8 @@ bool dc_link_set_default_brightness_aux(struct dc_link *link);
 
 int dc_link_get_backlight_level(const struct dc_link *dc_link);
 
+int dc_link_get_target_backlight_pwm(const struct dc_link *link);
+
 bool dc_link_set_abm_disable(const struct dc_link *dc_link);
 
 bool dc_link_set_psr_allow_active(struct dc_link *dc_link, bool enable, bool wait);
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
