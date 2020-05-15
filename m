Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40340C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17FAA20657
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wt70D5hb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17FAA20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D229F6ED1F;
	Fri, 15 May 2020 18:13:52 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700042.outbound.protection.outlook.com [40.107.70.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2DAC6ED19
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:13:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2svO8UvGtmackM79sveM/D+DPTXs28WkZ52s8N9xdlW2gfLJQa9lbbjHrNFVVpnmuOkhVvFJqsslrhuVfWRpJRaM8pHUInmxTLwkPQn/+E0pbxhn+71JlLT8rwvTKytm0qsLfNMHh/c+y6cd0giJleolSwDSqzuvXlxVDtN6Vf8umuCeYMehbJHb3+8sK1DhZZ+2q6ygm6vldV36Lm2U/fimjoCgoMkRwVYpJ1jO7QjCoqaHcKgCRU5UooZA8L72Rdaz3M9T8z/12BYOT5tyJP5uOH7LmxgS+TqhIRrTeYiEmEJBIwVAILkrF59BlQZ2wZSLXkOxiG3Haekj5seiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+1eL6uQj6YEEFQbwl/rvHOmWuQb3yqIUzymuSGe2zk=;
 b=GTGtG09SOOC3nhhkmJ81oxCM6lqqB5StiN/RJLdQmswBoc+NXyKLSE5wrqwHjnwsR8LqWeGhABs+NzPmP3ir6PBE6jrVy5Vto0mdSfn0USh1Rr3JtpJXyvy2fn/is+8TYni4+jXsmM3jXVcWHaa0Su4yAC31x/HqwZ0x/Xy0jgwJX3Gm0SaCw/3y4BFGCOX8M/TtCjfNaj2IiyNPYy5IB0JTbzr99xyiS4JH1rQjhHrXIKmOw/l62rkcmY8zSpN7S38U1Mh/qvAm17RrvPpF1ycTEYn3A2gwaxFbwU6AlucgyKZQaklB64Pw68+AcfBYEZodK3uT+cGDzIJBatzPCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+1eL6uQj6YEEFQbwl/rvHOmWuQb3yqIUzymuSGe2zk=;
 b=wt70D5hbMrJixqeCySknUaI2PbL4YJMM5zpxd9glEMbtCi8LNCRR5hkG4hfsoG7lQrFyagb3lLkm28IB4HeD+nS5ZlxKxfwCZ60DSe/eDDePYFFkAOQbRwP8lQLqKWdFro/mFPdYsCMW0Iz1mJ1/pi1TUvGS3/fzjHSSNKhlfuI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3974.namprd12.prod.outlook.com (2603:10b6:610:2e::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 18:13:47 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 18:13:47 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/27] drm/amd/display: FW release 1.0.10
Date: Fri, 15 May 2020 14:12:57 -0400
Message-Id: <20200515181315.1237251-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
References: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN7PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:20::47) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:13:46 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eda340e5-8298-49f5-5b38-08d7f8fbb61b
X-MS-TrafficTypeDiagnostic: CH2PR12MB3974:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB39743C69DB33D01D5EDC530C98BD0@CH2PR12MB3974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ytvvUCrQFXBkE0NlVNDZ7tvQwUeLRlURrIpcu4eyTgyWt8PNjm0bPRTBOq+wrBCLUAYvqoPxolKrFQ23mNFgTg9kYHd6enyCFXYxEbPrj1F0aPoJGzTRDgHeJwis0ocx12f1oM0DUqhNElevIkEAgEZHpXYFFZZLOs5hVWyn+SjOsNQfc8q1/qyRer5ggEoKMA5qsmO+XCifxSu1XdAKdsUAgW1tox9HZofGryxJNrqaCa63Ts12UCRfF73Mv4yke9pL4AvbiXYwyNgIFU8dq78vZDHNyoWhKfdVzpkSi9Sd+VgPuZeIqcMmbgmEv/E3Lp1kGFzOmhsHM4UPyo/pIbHqzIApXOkUrXdpAZPCZLY+rFXkYcptcmAOlHKascFbiUmzOtyrcMyzsugJiBti3V1JxWfOLot1+ZFtb2+5Z/oH/pjWBccpnV2bPeOFkVsF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(6506007)(316002)(8676002)(8936002)(86362001)(6486002)(6666004)(5660300002)(6916009)(478600001)(6512007)(2906002)(36756003)(66556008)(1076003)(52116002)(16526019)(186003)(2616005)(66476007)(66946007)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5RrpdHkIyyvm4T2giALQQX5tnQNVOkO4NDzEOyusIl7CcB8U/Bv7pqlzWu/sb6nSLERreqyaLczjFPgeqSCmllQMc9VNJsKdZ6Rrk96DgSo41OQT3ombfJHHKuSgMtzV2d6NbKqUZ+phEwwDP/jEw+45zOH/E1IG5rl9tXp8cM9NojKNF26Vbd0dCFyWuAJr8+W9RJ4ZchvzAsXh1d3s0DBafAq5ZW1rA9uR2xjooXe8/QtaRiPJcSAqVHlhxife9YaNj/5xIj90/YcOcr2WeQtB6Fb7re2WSBlHNnlX+HiLz66K00bqjtQhc8A0RIjD+blTlatYwwRbuItwTx+TtBRml0Hb6/yJKGd2P5JEsmrbA0n1IJodhgz4cpTmD7WF4hciYRKviL1RWXAu5RwRQ5IEytOCa8p0mNzAv53/yeuuXi2xvSbKpmW8vgmjKE3OTO4SYaNxNRiJ1jc7V5Cp9ziKR6ZOhaukBVEG9w4YMY1pKlsC1z0+5OEjl7TKds61
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda340e5-8298-49f5-5b38-08d7f8fbb61b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:13:47.4165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4MJ0D+FGPQypTRiZU4vSkTJTIccrDgwnAFwDE5Ccv3fhCQ45+E0UG2On2kUNJdQ2nYLHtOCIvyX1CkE5SUyZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3974
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
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 12 ++++---
 .../drm/amd/display/dmub/inc/dmub_cmd_dal.h   | 35 +++++++++++++++++++
 .../gpu/drm/amd/display/dmub/inc/dmub_types.h |  9 +++--
 4 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 044a0133ebb1..fd4e1021903a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -231,7 +231,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	copy_settings_data->smu_optimizations_en		= psr_context->allow_smu_optimizations;
 	copy_settings_data->frame_delay				= psr_context->frame_delay;
 	copy_settings_data->frame_cap_ind			= psr_context->psrFrameCaptureIndicationReq;
-	copy_settings_data->debug.visual_confirm		= dc->dc->debug.visual_confirm == VISUAL_CONFIRM_PSR ?
+	copy_settings_data->debug.bitfields.visual_confirm	= dc->dc->debug.visual_confirm == VISUAL_CONFIRM_PSR ?
 									true : false;
 
 	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index cbfde2706c18..7782b7fc1ce0 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -219,6 +219,7 @@ struct dmub_rb_cmd_dpphy_init {
 };
 
 struct dmub_cmd_psr_copy_settings_data {
+	union dmub_psr_debug_flags debug;
 	uint16_t psr_level;
 	uint8_t dpp_inst;
 	uint8_t mpcc_inst;
@@ -231,7 +232,7 @@ struct dmub_cmd_psr_copy_settings_data {
 	uint8_t smu_optimizations_en;
 	uint8_t frame_delay;
 	uint8_t frame_cap_ind;
-	struct dmub_psr_debug_flags debug;
+	uint8_t pad[3];
 };
 
 struct dmub_rb_cmd_psr_copy_settings {
@@ -241,6 +242,7 @@ struct dmub_rb_cmd_psr_copy_settings {
 
 struct dmub_cmd_psr_set_level_data {
 	uint16_t psr_level;
+	uint8_t pad[2];
 };
 
 struct dmub_rb_cmd_psr_set_level {
@@ -262,10 +264,10 @@ struct dmub_rb_cmd_psr_set_version {
 };
 
 struct dmub_cmd_abm_set_pipe_data {
-	uint32_t ramping_boundary;
-	uint32_t otg_inst;
-	uint32_t panel_inst;
-	uint32_t set_pipe_option;
+	uint8_t otg_inst;
+	uint8_t panel_inst;
+	uint8_t set_pipe_option;
+	uint8_t ramping_boundary; // TODO: Remove this
 };
 
 struct dmub_rb_cmd_abm_set_pipe {
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h
index e42de9ded275..3ed77b6f0e44 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h
@@ -26,6 +26,11 @@
 #ifndef _DMUB_CMD_DAL_H_
 #define _DMUB_CMD_DAL_H_
 
+#define NUM_AMBI_LEVEL                  5
+#define NUM_AGGR_LEVEL                  4
+#define NUM_POWER_FN_SEGS               8
+#define NUM_BL_CURVE_SEGS               16
+
 /*
  * Command IDs should be treated as stable ABI.
  * Do not reuse or modify IDs.
@@ -53,4 +58,34 @@ enum dmub_cmd_abm_type {
 	DMUB_CMD__ABM_SET_PWM_FRAC	= 5,
 };
 
+/*
+ * Parameters for ABM2.4 algorithm.
+ * Padded explicitly to 32-bit boundary.
+ */
+struct abm_config_table {
+	/* Parameters for crgb conversion */
+	uint16_t crgb_thresh[NUM_POWER_FN_SEGS];                 // 0B
+	uint16_t crgb_offset[NUM_POWER_FN_SEGS];                 // 15B
+	uint16_t crgb_slope[NUM_POWER_FN_SEGS];                  // 31B
+
+	/* Parameters for custom curve */
+	uint16_t backlight_thresholds[NUM_BL_CURVE_SEGS];        // 47B
+	uint16_t backlight_offsets[NUM_BL_CURVE_SEGS];           // 79B
+
+	uint16_t ambient_thresholds_lux[NUM_AMBI_LEVEL];         // 111B
+	uint16_t min_abm_backlight;                              // 121B
+
+	uint8_t min_reduction[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];   // 123B
+	uint8_t max_reduction[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];   // 143B
+	uint8_t bright_pos_gain[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL]; // 163B
+	uint8_t dark_pos_gain[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];   // 183B
+	uint8_t hybrid_factor[NUM_AGGR_LEVEL];                   // 203B
+	uint8_t contrast_factor[NUM_AGGR_LEVEL];                 // 207B
+	uint8_t deviation_gain[NUM_AGGR_LEVEL];                  // 211B
+	uint8_t min_knee[NUM_AGGR_LEVEL];                        // 215B
+	uint8_t max_knee[NUM_AGGR_LEVEL];                        // 219B
+	uint8_t iir_curve[NUM_AMBI_LEVEL];                       // 223B
+	uint8_t pad3[3];                                         // 228B
+};
+
 #endif /* _DMUB_CMD_DAL_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_types.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_types.h
index bed5b023a396..f61af26fc73e 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_types.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_types.h
@@ -63,9 +63,12 @@ union dmub_addr {
 	uint64_t quad_part;
 };
 
-struct dmub_psr_debug_flags {
-	uint8_t visual_confirm : 1;
-	uint8_t reserved : 7;
+union dmub_psr_debug_flags {
+	struct {
+		uint8_t visual_confirm : 1;
+	} bitfields;
+
+	unsigned int u32All;
 };
 
 #if defined(__cplusplus)
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
