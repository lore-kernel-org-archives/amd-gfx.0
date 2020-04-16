Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DBAC38A29
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D12C021841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dWEEr9sN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12C021841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B2576E0F2;
	Thu, 16 Apr 2020 23:41:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BE2F6E0F2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5Uip6JiGbkHClmrseM4hsNivgK9vuhu1T2DznRhMZ14HCiAO4+evRQ899P1m2JiJVicAiVZvhc9bPG/T9A74dihzYuv49Q/f2lRsP8E6BA0ElgcDIfroAQs1zZpHVPtHNPAcktJIBk/C304Mwgb+QMjaBpv3FR4ZUjKfs+iSOPIXJRJLy+ZSRzRuJSx70+I9Vhnpw5I5AMbwawkeAui2uPCavkBu1wcMyDFrxsMlcrZJKskSoGYYAbecxmwxzUIxVbBPXF5fzLKr5O5DZhz0p9emoBT2wO0lOTYOAZFARSYxonaZgkWf5OjqXa29gcD1poQTyWuF93f15e7XXgX7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcJj4c2bgKkArKWzP84IEmpQrLKGnLflpurssANwBZM=;
 b=HJ0sXSUzWTZ+7jM/lf8UEMXS272OV0v8iMTAtSyCjraZyewYmeXvx6MtoCvlKmUNfK/buUuesveInNcVkPT98atpElanSFHJeEUMsBTAtOr66gvxVA6LQMT/8IwE3lBGu1/IUuSEOL9LH9BU3+8JFyaTaUoRv1ORDNtRtCPufXFt2VXrXv+4zo2e0w1s0tKCgNQNHTEehlGDyc+YMdzwPPKqhEo0zzCGtWMGgbBTLpu7vuXIXa+fgDJF8w7Q4oqAj6r7mFskRuDQW+jnsl20T5b0PX0YszhX7jj0dTSqbtf6h8tC54UTqv5PQo+ypGo0R9BaVXuoQv2ltqADRcJxDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcJj4c2bgKkArKWzP84IEmpQrLKGnLflpurssANwBZM=;
 b=dWEEr9sNQI22lPNQVPpRfwSkM6pamqbn7ZU2DE3OnhWsGugBMUzG8zREskghVpzlh4d654moGXmq4cg9bpEC8Gmpj/3v/Act28vwKbCgnLl5rHUvZ9uPn8Rz1sOf6tpkA3XpXYT1lHwTh0JEYXkpHkK5rLl8NfoSKVOzPsShT6g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:15 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:15 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/35] drm/amd/display: Remove byte swapping for dmcub abm
 config table
Date: Thu, 16 Apr 2020 19:40:14 -0400
Message-Id: <20200416234044.2082886-6-Rodrigo.Siqueira@amd.com>
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
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:14 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 76a7c659-5d38-4e9f-ef3b-08d7e25fa735
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24592E413B6568528E1B3C8998D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
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
X-Microsoft-Antispam-Message-Info: 2+Rpkpv85jIk72/jWqvrNMqkeSv7dUbkDxkRNkQ8lkq3LRcs227lfINq0bS/5Ctt3levoHsmta6Ke2WJYEdAUPIoxRNPbuAPxJC5y8x+X64OubIzzoICrJNSQGvKfiQP5luqEbWWIVpS7D00Y/mrdYaIbMuTklDPQobCKxyGcBeKJ4eK0Iz2sCyJ/C/FcUfPRjdGnWQsdw0KXWx0Qwj+ytx1TnAUehaDnvMqvkdpF70P7BPgXiRKAck1Yo9eTXsLAZZAG0Y8FeoEVg7v+ycaGlKFEyuC4N0AeaeioCyAfTbRGguDE4fYrvqyskf9X0HixkC/DyPgc2Xqw0CfcIXiqw5AX4lSfe51m903RdNdtibYekwQfFgrJosjmfaruH49104pgjnrk83KLRVKBszMIvrNfjflnW2ZFrkShqtLIiCRyFHOQs2XdtuDL5Ui4u0x
X-MS-Exchange-AntiSpam-MessageData: 8qbhbuP3tKA0qXWrnLiVStcUXhnOSjenuZNeNJcn60n/VtDliOV6gX/1xbF9H6n7B5B0n69PuP1RpeVvr35lwF66fMj8Zu4Kj4HGIUzVqFoeIT6qyefIUTVF122mV+RFv3mxZtf5ioCp0icCdx0XmenFTyokUs+rAECjmqVSDKE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a7c659-5d38-4e9f-ef3b-08d7e25fa735
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:15.3763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CV+uNPD9Mv11aR1MuRYgRX6pzWuB+AIo+hdj2GCkab3MgE+IvQnPq4WcT12/2jSpbvqhPi+vyAH+9XBnpupBCA==
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
Since x86 and dmcub are both little endian, byte swapping isn't
necessary. Dmcu requires byte swapping as it is big endian.

[How]
Add flag to function definitions to determine if byte swapping is
necessary.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/modules/power/power_helpers.c | 74 +++++++++----------
 1 file changed, 36 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index dd1517684c90..edb446455f6b 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -240,7 +240,7 @@ static void fill_backlight_transform_table(struct dmcu_iram_parameters params,
 }
 
 static void fill_backlight_transform_table_v_2_2(struct dmcu_iram_parameters params,
-		struct iram_table_v_2_2 *table)
+		struct iram_table_v_2_2 *table, bool big_endian)
 {
 	unsigned int i;
 	unsigned int num_entries = NUM_BL_CURVE_SEGS;
@@ -264,10 +264,10 @@ static void fill_backlight_transform_table_v_2_2(struct dmcu_iram_parameters par
 		lut_index = (params.backlight_lut_array_size - 1) * i / (num_entries - 1);
 		ASSERT(lut_index < params.backlight_lut_array_size);
 
-		table->backlight_thresholds[i] =
-			cpu_to_be16(DIV_ROUNDUP((i * 65536), num_entries));
-		table->backlight_offsets[i] =
-			cpu_to_be16(params.backlight_lut_array[lut_index]);
+		table->backlight_thresholds[i] = (big_endian) ?
+			cpu_to_be16(DIV_ROUNDUP((i * 65536), num_entries)) : DIV_ROUNDUP((i * 65536), num_entries);
+		table->backlight_offsets[i] = (big_endian) ?
+			cpu_to_be16(params.backlight_lut_array[lut_index]) : params.backlight_lut_array[lut_index];
 	}
 }
 
@@ -587,18 +587,16 @@ void fill_iram_v_2_2(struct iram_table_v_2_2 *ram_table, struct dmcu_iram_parame
 	ram_table->crgb_slope[7]  = cpu_to_be16(0x1910);
 
 	fill_backlight_transform_table_v_2_2(
-			params, ram_table);
+			params, ram_table, true);
 }
 
-void fill_iram_v_2_3(struct iram_table_v_2_2 *ram_table, struct dmcu_iram_parameters params)
+void fill_iram_v_2_3(struct iram_table_v_2_2 *ram_table, struct dmcu_iram_parameters params, bool big_endian)
 {
 	unsigned int i, j;
 	unsigned int set = params.set;
 
 	ram_table->flags = 0x0;
-
-	ram_table->min_abm_backlight =
-			cpu_to_be16(params.min_abm_backlight);
+	ram_table->min_abm_backlight = (big_endian) ? cpu_to_be16(params.min_abm_backlight) : params.min_abm_backlight;
 
 	for (i = 0; i < NUM_AGGR_LEVEL; i++) {
 		ram_table->hybrid_factor[i] = abm_settings[set][i].brightness_gain;
@@ -622,33 +620,33 @@ void fill_iram_v_2_3(struct iram_table_v_2_2 *ram_table, struct dmcu_iram_parame
 	ram_table->iir_curve[4] = 0x65;
 
 	//Gamma 2.2
-	ram_table->crgb_thresh[0] = cpu_to_be16(0x127c);
-	ram_table->crgb_thresh[1] = cpu_to_be16(0x151b);
-	ram_table->crgb_thresh[2] = cpu_to_be16(0x17d5);
-	ram_table->crgb_thresh[3] = cpu_to_be16(0x1a56);
-	ram_table->crgb_thresh[4] = cpu_to_be16(0x1c83);
-	ram_table->crgb_thresh[5] = cpu_to_be16(0x1e72);
-	ram_table->crgb_thresh[6] = cpu_to_be16(0x20f0);
-	ram_table->crgb_thresh[7] = cpu_to_be16(0x232b);
-	ram_table->crgb_offset[0] = cpu_to_be16(0x2999);
-	ram_table->crgb_offset[1] = cpu_to_be16(0x3999);
-	ram_table->crgb_offset[2] = cpu_to_be16(0x4666);
-	ram_table->crgb_offset[3] = cpu_to_be16(0x5999);
-	ram_table->crgb_offset[4] = cpu_to_be16(0x6333);
-	ram_table->crgb_offset[5] = cpu_to_be16(0x7800);
-	ram_table->crgb_offset[6] = cpu_to_be16(0x8c00);
-	ram_table->crgb_offset[7] = cpu_to_be16(0xa000);
-	ram_table->crgb_slope[0]  = cpu_to_be16(0x3609);
-	ram_table->crgb_slope[1]  = cpu_to_be16(0x2dfa);
-	ram_table->crgb_slope[2]  = cpu_to_be16(0x27ea);
-	ram_table->crgb_slope[3]  = cpu_to_be16(0x235d);
-	ram_table->crgb_slope[4]  = cpu_to_be16(0x2042);
-	ram_table->crgb_slope[5]  = cpu_to_be16(0x1dc3);
-	ram_table->crgb_slope[6]  = cpu_to_be16(0x1b1a);
-	ram_table->crgb_slope[7]  = cpu_to_be16(0x1910);
+	ram_table->crgb_thresh[0] = (big_endian) ? cpu_to_be16(0x127c) : 0x127c;
+	ram_table->crgb_thresh[1] = (big_endian) ? cpu_to_be16(0x151b) : 0x151b;
+	ram_table->crgb_thresh[2] = (big_endian) ? cpu_to_be16(0x17d5) : 0x17d5;
+	ram_table->crgb_thresh[3] = (big_endian) ? cpu_to_be16(0x1a56) : 0x1a56;
+	ram_table->crgb_thresh[4] = (big_endian) ? cpu_to_be16(0x1c83) : 0x1c83;
+	ram_table->crgb_thresh[5] = (big_endian) ? cpu_to_be16(0x1e72) : 0x1e72;
+	ram_table->crgb_thresh[6] = (big_endian) ? cpu_to_be16(0x20f0) : 0x20f0;
+	ram_table->crgb_thresh[7] = (big_endian) ? cpu_to_be16(0x232b) : 0x232b;
+	ram_table->crgb_offset[0] = (big_endian) ? cpu_to_be16(0x2999) : 0x2999;
+	ram_table->crgb_offset[1] = (big_endian) ? cpu_to_be16(0x3999) : 0x3999;
+	ram_table->crgb_offset[2] = (big_endian) ? cpu_to_be16(0x4666) : 0x4666;
+	ram_table->crgb_offset[3] = (big_endian) ? cpu_to_be16(0x5999) : 0x5999;
+	ram_table->crgb_offset[4] = (big_endian) ? cpu_to_be16(0x6333) : 0x6333;
+	ram_table->crgb_offset[5] = (big_endian) ? cpu_to_be16(0x7800) : 0x7800;
+	ram_table->crgb_offset[6] = (big_endian) ? cpu_to_be16(0x8c00) : 0x8c00;
+	ram_table->crgb_offset[7] = (big_endian) ? cpu_to_be16(0xa000) : 0xa000;
+	ram_table->crgb_slope[0]  = (big_endian) ? cpu_to_be16(0x3609) : 0x3609;
+	ram_table->crgb_slope[1]  = (big_endian) ? cpu_to_be16(0x2dfa) : 0x2dfa;
+	ram_table->crgb_slope[2]  = (big_endian) ? cpu_to_be16(0x27ea) : 0x27ea;
+	ram_table->crgb_slope[3]  = (big_endian) ? cpu_to_be16(0x235d) : 0x235d;
+	ram_table->crgb_slope[4]  = (big_endian) ? cpu_to_be16(0x2042) : 0x2042;
+	ram_table->crgb_slope[5]  = (big_endian) ? cpu_to_be16(0x1dc3) : 0x1dc3;
+	ram_table->crgb_slope[6]  = (big_endian) ? cpu_to_be16(0x1b1a) : 0x1b1a;
+	ram_table->crgb_slope[7]  = (big_endian) ? cpu_to_be16(0x1910) : 0x1910;
 
 	fill_backlight_transform_table_v_2_2(
-			params, ram_table);
+			params, ram_table, big_endian);
 }
 
 bool dmub_init_abm_config(struct abm *abm,
@@ -662,7 +660,7 @@ bool dmub_init_abm_config(struct abm *abm,
 
 	memset(&ram_table, 0, sizeof(ram_table));
 
-	fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params);
+	fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params, false);
 	result = abm->funcs->init_abm_config(
 		abm, (char *)(&ram_table), IRAM_RESERVE_AREA_START_V2_2);
 
@@ -684,11 +682,11 @@ bool dmcu_load_iram(struct dmcu *dmcu,
 	memset(&ram_table, 0, sizeof(ram_table));
 
 	if (dmcu->dmcu_version.abm_version == 0x24) {
-		fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params);
+		fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params, true);
 			result = dmcu->funcs->load_iram(
 					dmcu, 0, (char *)(&ram_table), IRAM_RESERVE_AREA_START_V2_2);
 	} else if (dmcu->dmcu_version.abm_version == 0x23) {
-		fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params);
+		fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params, true);
 
 		result = dmcu->funcs->load_iram(
 				dmcu, 0, (char *)(&ram_table), IRAM_RESERVE_AREA_START_V2_2);
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
