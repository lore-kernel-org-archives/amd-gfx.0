Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFC2C433E4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3E9D20768
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u5ncypvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E9D20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B2476E277;
	Thu, 13 Aug 2020 21:35:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82EAA6E25C
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 21:35:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0VHj5l+raskbQeNxkTb2IT1vO2+tQA/3h7BpkTqkgo7xtsLff0/eJsh3W1qHcagpmbaz3HQA8FAUC9L+FBnt0Yk/X6TVn1RyVhAKcG2WlB39WYzvEqVnmwLQ3t8HFURejGqizRuSBRm5+gU7JIGWtrrbz8AirKleTtWH0NrkaTe25U+ABR8KJ8DQa/GQsyab9f9v0KB67fFUHJU4TeCdDzLt04mEFUlU78/Z21nMfOHvt1Oyyqr+NDuo5I6stU1ATfcJZa5pVL7aihNw4eyjGIsKxlkgcplTVHE0JhE4as5cuFYyfWXjzZZOQz3ZUzoh24rD6BLjbxJ+or83U3reQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PP7jIf1pwnxhAYKRQ6MhQVC2gIR8IC7zT0UfTwYuYbA=;
 b=cauc5FOOqiwSjDhWbelrPJ9e7k0uW77D4grM3UFww3aRZkWnAKDH8M7OCiNfL1sCOvJaSPdJLDBlCNZw7OhuhFLeuuaCvkTz90yP+xvV1WGPI3at1YT2FWuelY7gJz7DKPgSKYMAKoey0ckHS9Txj8WUZEZ2Q+Srmoof+GBZtLJpFpQmHlMQUUiMpLVPV+poKkF1viHVHg1k2PzIgHVeMc61P4SNqon7KpZ+28i3DrLnB1rvp9pi+4TMK4GJnmW4gxESIPDNYxGY2+Ogt5Yg4xGfkfdCA6YVr09TpH6HZAfwzRqIAQKCkQULUfM0305EJrA1B/DLf4QQZ4W9Z5LGgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PP7jIf1pwnxhAYKRQ6MhQVC2gIR8IC7zT0UfTwYuYbA=;
 b=u5ncypvNUhro3Bx0plfCouYvVbXk7TYnEdKi0ySEAqfCGq8pUw2Od0WVybQv/zYZcgruPwhYI0z0bsq23IeG7QoKUbqWtwZeJDbc7mYsggtaA9YILqj6THa/T+gtret+rFeClWHCL0Lw3UOMIrK1rD3/Lzw0whXZfVQ2qSznVOI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Thu, 13 Aug 2020 21:35:31 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7%9]) with mapi id 15.20.3283.016; Thu, 13 Aug 2020
 21:35:31 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/17] drm/amd/display: Add read backlight interface
Date: Thu, 13 Aug 2020 17:33:48 -0400
Message-Id: <20200813213356.1606886-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813213356.1606886-1-Rodrigo.Siqueira@amd.com>
References: <20200813213356.1606886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::18) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::2db6) by
 YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Thu, 13 Aug 2020 21:35:30 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2607:fea8:56e0:6d60::2db6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0918f75f-6c86-42d1-ab83-08d83fd0cda6
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1355769E3AAC1B943E625F8F98430@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:312;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PTICSuiDM7bPYXwKnS20TK1QzDt6f7dQKBtDkIc0I1qXK6YZWrJO6uE8x268ZlA0EoBhSmEIHWNIWKfj4JDt4Z0rCyiqX7dzEBNlzD85zlNW2pdTvgqPxDY6SkmhPbhOjsznBKWdv+eG+s8HDDL9lsNdHpfy+CMtcxAaQYvOUeyQ+YPAH+qTgy+3lR/2BMcmf8Z2iXKx5DoVy25YD4hOyvCVzn8aMpiF8qaJMNR8A/VKPesUgGKNQmwe35t8JrOB9MdOruinDW6cSv0Ad6/4F7W5mHp3fdZm8yXj7xTMTJTSkPmSY7HXNOTCN4l54PAi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(2616005)(6512007)(83380400001)(6486002)(4326008)(316002)(478600001)(1076003)(6916009)(66476007)(66556008)(36756003)(52116002)(66946007)(2906002)(6506007)(8676002)(6666004)(54906003)(16526019)(8936002)(5660300002)(186003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: czW9+M/BubbhwqpoOT6qr+r3TmZwSUQKESHJfpcl8xE5yOm5U3hLkVagpjPjl5LlvVjujPSNfa1AL/6Dqvxsn6z21xVudJ7f8JkKVB/4rEGDSTgXFDGj6aBSsbz1mrsZ0WjORTgy1c5u7xozNPtvesW34Bcwnd3Z0mdfu1sVoFBT6Yy5qFNL+HZsuronKPQBNcs80yYd+S6zyVKuIHZgiH8hnLoIhiRvsg1AnuhM3HcZ/UrPV2tVN1asZCb0+vlH0ceBJziMDb7C/AnrmweaJV7j6Y/m5cIOe9b3nQ/S4AAV13KdsOpInZ1kf1NOYyQjLqIk/zJRt5j/bHe4Ap/Z5OILES5cIj7SB6th/l1UZCBjLPTmyNzLhoiPH5Ch50ZqDhFtZgipvUAmbUriQ8pr4cRlbvu/afeHh6mPvACJRyGvtk6ntm1sbAY8m9saCEdYXjQ925utiXcVWoDf9kLDTd9H3DY/1BWx7qEhykBSd4XbOX/qJhq3wx46axFixSxwiaTz6UQzpLNRCayTxojIlQclUUhi36IVgHERfPxzIUappgl9Lo0Epqro+rI0mlWM0rZADlOSGCPUv8xLw2vDalFywLmzyH60n+/5KJBvV+eMbGn5c2IPn464amtvopFIEdupuggZAu92HpeA+KhfkEHuv9r8BeyLW46K99E42rs4s5icsiBgU3P7IK1q+MHj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0918f75f-6c86-42d1-ab83-08d83fd0cda6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 21:35:31.0667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNd03Ks9kffb0BgEtcUi8vMNhHqLBXydlO/2+1NhRUuFQDXjIF3/3bevss0Wf5PoN5D5xJdJKLg7rzgIHem5FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Yongqiang Sun <yongqiang.sun@amd.com>, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why & How]
Add read backlight interface to get ABM data.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c      |  1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h         | 12 +++++++++++-
 drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c  |  6 ++++--
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h   |  1 +
 5 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 0257a900fe2b..f42a17d765e3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -708,3 +708,4 @@ void dc_stream_log(const struct dc *dc, const struct dc_stream_state *stream)
 			"\tlink: %d\n",
 			stream->link->link_index);
 }
+
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
index a44effcda49f..e84d21605854 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
@@ -46,6 +46,8 @@
 	SR(BL1_PWM_USER_LEVEL), \
 	SR(DC_ABM1_LS_MIN_MAX_PIXEL_VALUE_THRES), \
 	SR(DC_ABM1_HGLS_REG_READ_PROGRESS), \
+	SR(DC_ABM1_ACE_OFFSET_SLOPE_0), \
+	SR(DC_ABM1_ACE_THRES_12), \
 	SR(BIOS_SCRATCH_2)
 
 #define ABM_DCN10_REG_LIST(id)\
@@ -60,6 +62,8 @@
 	SRI(BL1_PWM_USER_LEVEL, ABM, id), \
 	SRI(DC_ABM1_LS_MIN_MAX_PIXEL_VALUE_THRES, ABM, id), \
 	SRI(DC_ABM1_HGLS_REG_READ_PROGRESS, ABM, id), \
+	SRI(DC_ABM1_ACE_OFFSET_SLOPE_0, ABM, id), \
+	SRI(DC_ABM1_ACE_THRES_12, ABM, id), \
 	NBIO_SR(BIOS_SCRATCH_2)
 
 #define ABM_DCN20_REG_LIST() \
@@ -74,10 +78,12 @@
 	SR(BL1_PWM_USER_LEVEL), \
 	SR(DC_ABM1_LS_MIN_MAX_PIXEL_VALUE_THRES), \
 	SR(DC_ABM1_HGLS_REG_READ_PROGRESS), \
+	SR(DC_ABM1_ACE_OFFSET_SLOPE_0), \
+	SR(DC_ABM1_ACE_THRES_12), \
 	NBIO_SR(BIOS_SCRATCH_2)
 
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
-#define ABM_DCN301_REG_LIST(id)\
+#define ABM_DCN30_REG_LIST(id)\
 	ABM_COMMON_REG_LIST_DCE_BASE(), \
 	SRI(DC_ABM1_HG_SAMPLE_RATE, ABM, id), \
 	SRI(DC_ABM1_LS_SAMPLE_RATE, ABM, id), \
@@ -89,6 +95,8 @@
 	SRI(BL1_PWM_USER_LEVEL, ABM, id), \
 	SRI(DC_ABM1_LS_MIN_MAX_PIXEL_VALUE_THRES, ABM, id), \
 	SRI(DC_ABM1_HGLS_REG_READ_PROGRESS, ABM, id), \
+	SRI(DC_ABM1_ACE_OFFSET_SLOPE_0, ABM, id), \
+	SRI(DC_ABM1_ACE_THRES_12, ABM, id), \
 	NBIO_SR(BIOS_SCRATCH_2)
 #endif
 
@@ -208,6 +216,8 @@ struct dce_abm_registers {
 	uint32_t BL1_PWM_USER_LEVEL;
 	uint32_t DC_ABM1_LS_MIN_MAX_PIXEL_VALUE_THRES;
 	uint32_t DC_ABM1_HGLS_REG_READ_PROGRESS;
+	uint32_t DC_ABM1_ACE_OFFSET_SLOPE_0;
+	uint32_t DC_ABM1_ACE_THRES_12;
 	uint32_t MASTER_COMM_CNTL_REG;
 	uint32_t MASTER_COMM_CMD_REG;
 	uint32_t MASTER_COMM_DATA_REG1;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
index 43781e77be43..a6d73d30837c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
@@ -46,13 +46,14 @@
 #define FN(reg_name, field_name) \
 	dce_panel_cntl->shift->field_name, dce_panel_cntl->mask->field_name
 
-static unsigned int calculate_16_bit_backlight_from_pwm(struct dce_panel_cntl *dce_panel_cntl)
+static unsigned int dce_get_16_bit_backlight_from_pwm(struct panel_cntl *panel_cntl)
 {
 	uint64_t current_backlight;
 	uint32_t round_result;
 	uint32_t pwm_period_cntl, bl_period, bl_int_count;
 	uint32_t bl_pwm_cntl, bl_pwm, fractional_duty_cycle_en;
 	uint32_t bl_period_mask, bl_pwm_mask;
+	struct dce_panel_cntl *dce_panel_cntl = TO_DCE_PANEL_CNTL(panel_cntl);
 
 	pwm_period_cntl = REG_READ(BL_PWM_PERIOD_CNTL);
 	REG_GET(BL_PWM_PERIOD_CNTL, BL_PWM_PERIOD, &bl_period);
@@ -150,7 +151,7 @@ static uint32_t dce_panel_cntl_hw_init(struct panel_cntl *panel_cntl)
 	REG_UPDATE(BL_PWM_GRP1_REG_LOCK,
 			BL_PWM_GRP1_REG_LOCK, 0);
 
-	current_backlight = calculate_16_bit_backlight_from_pwm(dce_panel_cntl);
+	current_backlight = dce_get_16_bit_backlight_from_pwm(panel_cntl);
 
 	return current_backlight;
 }
@@ -273,6 +274,7 @@ static const struct panel_cntl_funcs dce_link_panel_cntl_funcs = {
 	.is_panel_powered_on = dce_is_panel_powered_on,
 	.store_backlight_level = dce_store_backlight_level,
 	.driver_set_backlight = dce_driver_set_backlight,
+	.get_current_backlight = dce_get_16_bit_backlight_from_pwm,
 };
 
 void dce_panel_cntl_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index aa3ea6c79c27..3b4c356c5ba6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -340,7 +340,7 @@ static const struct dce110_clk_src_mask cs_mask = {
 
 #define abm_regs(id)\
 [id] = {\
-		ABM_DCN301_REG_LIST(id)\
+		ABM_DCN30_REG_LIST(id)\
 }
 
 static const struct dce_abm_registers abm_regs[] = {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h b/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
index f9ab5abb6462..48eac622c6a0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h
@@ -49,6 +49,7 @@ struct panel_cntl_funcs {
 	void (*store_backlight_level)(struct panel_cntl *panel_cntl);
 	void (*driver_set_backlight)(struct panel_cntl *panel_cntl,
 			uint32_t backlight_pwm_u16_16);
+	uint32_t (*get_current_backlight)(struct panel_cntl *panel_cntl);
 };
 
 struct panel_cntl_init_data {
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
