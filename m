Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC28EC433E4
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 911EC20657
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aRkqECLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911EC20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 573246ED1B;
	Fri, 15 May 2020 18:13:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 174006ED1B
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:13:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jz3dog0n60N9Ux+bzilN/L/fdlkNQvMI+fNRfmtRKWgQZZk5fbP7CxT2KLRZRzXaip2Is9KZbE5AEp8P9QywHKzPCCkvqcJOOFMyEZYGQ7l9eZ4rcEDMMiDIqUT1XIlbe/DTXSM79yT4WMJ9fVeqvVoicXG3ga06LgIUKQR28A3+yrZ421WCjs51oBxB0BQvFV5UbTNzF5nRjVoRRjQ2+7E0xfVqxgErRV8GDQFbypWGeQ9DiT8/pfRH+1OzUwLkaYuzBm9sUq/cSIfn3qwQi6hPgiWbYBL8/stAbUL+oFgwx7FTBTo1s9WBozZiu66eDV3NlPFO4Y5M7C3I8Btv0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Q6Eb103hbRaBa1kp1H3vfI/kroKcmJ/XkPpCwIbFX4=;
 b=aCnTBPEeR/GGs8VdjuqGqfsa/rXdBpl1pV8auMdyLsfOKzvoF9iZBS/mrdwd+Nb7z4CBlAXtZDVxGACfu1DY/Lv9vECyfbRzDlOIIOVMbnjJDGPRrd8EM0LdHXRSUJgPYPrXMfCtCAUdk3AeFBFXRX+VTgsmkf7TZ7PQYgKroCoeDZKqDPdIoiAIGBWQbPggDrua7PtTwCBo7h3VKIa5k9PcL55Zdp/FIbr72o8opBXGEY8tyTZXBX/HutOoBHhTkKMXlctAGMFGwR6w3Q9jmKprT7mtv1AvKrl34pdap6bSKv3FvsWlho35rzlXmegpk+5jrD9/FIsBr6UaMLFofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Q6Eb103hbRaBa1kp1H3vfI/kroKcmJ/XkPpCwIbFX4=;
 b=aRkqECLglKjd0nk/SaFDyRp6NOE9pDAW/irGfuG5wIEykR61j9mDIi0H+LxRZqkie4jn6bPL662oX8vu1t/r9yrudp3CxB53ajfIFWy4pF3avJRIYveojselXFiuayvcuHaQuL6K2LEot3TToKktbl5o0es0svFoFBgKh7Roj/c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3974.namprd12.prod.outlook.com (2603:10b6:610:2e::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 18:13:48 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 18:13:48 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/27] drm/amd/display: Fix ABM memory alignment issue
Date: Fri, 15 May 2020 14:12:58 -0400
Message-Id: <20200515181315.1237251-12-Rodrigo.Siqueira@amd.com>
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
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:13:47 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d5444ac2-9caa-4925-9e99-08d7f8fbb6b0
X-MS-TrafficTypeDiagnostic: CH2PR12MB3974:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3974F4803346E26FDAFB13C698BD0@CH2PR12MB3974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: We8zEVaWd7U5YbxQ7FBb+yjgECBh02DMx+8hLwjpG3XTTbkkGkaSczRo1RxxeCbv6WU4LQXVzCpboOksu5FInL6+pG7/6EmQOchfyyjiJKFzx4QyBSMeNiagqIBUIe03DIwjTaX20Vj7Uo/lfZllCRSazAmuVgCSV0u7GwP3IDawPZ6+qv5AGAa9A9rAGWuMs+blxrNWMO2fZFz4lSm4i1GTbodT+FYyUOzPAsE/V01mbqb0Ik7Yg7ODIKA9i0ME3FtOpCKA9OyIzMx8WsPi/XLcneFoMqv0pfmzj1vPPfx56iXXBs6JS2z2UTJc3WG/qCf0iLfllnugNlwI6bGdfAczfb4E3DWozvilLG0X/QodC6hlUGrdixvrFvzmTNeeWZWdTT8SRYnkrpH7pMdtV14r6fPYm77xu3WP83848zV33Yt83lx6xYp+KTQDeXU1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(6506007)(316002)(8676002)(8936002)(86362001)(6486002)(54906003)(6666004)(5660300002)(6916009)(478600001)(6512007)(2906002)(36756003)(66556008)(1076003)(52116002)(16526019)(186003)(2616005)(66476007)(66946007)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: j2wkHspeXa0XPMW3SegvrmT/FUdW0bq3NoNiXuzyORW/+fHA1USHvWMDeFjvNgeAjRga0JCVHCPmTW4eOmart236mNRKatA2V9Dg9LfAqXraDg30hem10DbnZpJrPv7I2FBq6H8lYSohvTa4NNLacwu8qru4qwagdSyjdo6epIGSPGFh4dXHyRWszMg5KPhzIE7F1QIrZncjnxN791BtQxwmAqIDdf9v7cgza2BctKnJMpoBKAMAUdkftbMWqrVWk+M8IHHsOGb77tlhFkW23A3SV4jS9+bNviyFcBeJF5+kWv3oL82Qn2K2g8zPHJuRgFl8//foLs+Dkl7JqNwJ35IZvmz4dUfFdruwcnpowHTKhxQ94/TS3jJZJB9ozmZ4DgxqhQfmd0ObOPXOqoqZwzGf8pXayUiG+RHHSTIr6/7AO9Kqv3XlnIAYwIDUejDGU935zsDsaqCwCU1Zcb9+lV549AcKP2i0xh/XQD6LhXMPlv5EGPo2RoTvpijSNntR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5444ac2-9caa-4925-9e99-08d7f8fbb6b0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:13:48.3987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BrBfhkY5BRLwlPJ5GMM1apXATzFatMqTK1DDU9e9AOFUYZuhKtuaS0/cOdehr7YMzWEa+rxUxkE1DCC6UgIE4w==
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
 Aurabindo.Pillai@amd.com, Wyatt Wood <wyatt.wood@amd.com>,
 Bhawanpreet.Lakha@amd.com, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
Due to packing of abm_config_table, memory addresses aren't aligned to
32 bit boundary dmcub prefers.  Therefore when using pointers to this
structure, it's possible that dmcub will automatically align the data
read from that address, yielding incorrect values.

[How]
Instead of packing 1 byte boundary, explicitly pack values to 4 byte
boundary. Since there is a dependency on the existing iram table
structure on driver side, we must copy to a second structure, which is
aligned correctly, before passing to fw.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/modules/power/power_helpers.c | 45 +++++++++++++++++--
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 60b92f099af5..dbfdeed0b6e6 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -27,6 +27,7 @@
 #include "dc/inc/hw/abm.h"
 #include "dc.h"
 #include "core_types.h"
+#include "dmub_cmd_dal.h"
 
 #define DIV_ROUNDUP(a, b) (((a)+((b)/2))/(b))
 #define bswap16_based_on_endian(big_endian, value) \
@@ -658,17 +659,55 @@ void fill_iram_v_2_3(struct iram_table_v_2_2 *ram_table, struct dmcu_iram_parame
 bool dmub_init_abm_config(struct abm *abm,
 	struct dmcu_iram_parameters params)
 {
-	unsigned char ram_table[IRAM_SIZE];
+	struct iram_table_v_2_2 ram_table;
+	struct abm_config_table config;
 	bool result = false;
+	uint32_t i, j = 0;
 
 	if (abm == NULL)
 		return false;
 
 	memset(&ram_table, 0, sizeof(ram_table));
+	memset(&config, 0, sizeof(config));
+
+	fill_iram_v_2_3(&ram_table, params, false);
+
+	// We must copy to structure that is aligned to 32-bit
+	for (i = 0; i < NUM_POWER_FN_SEGS; i++) {
+		config.crgb_thresh[i] = ram_table.crgb_thresh[i];
+		config.crgb_offset[i] = ram_table.crgb_offset[i];
+		config.crgb_slope[i] = ram_table.crgb_slope[i];
+	}
+
+	for (i = 0; i < NUM_BL_CURVE_SEGS; i++) {
+		config.backlight_thresholds[i] = ram_table.backlight_thresholds[i];
+		config.backlight_offsets[i] = ram_table.backlight_offsets[i];
+	}
+
+	for (i = 0; i < NUM_AMBI_LEVEL; i++)
+		config.iir_curve[i] = ram_table.iir_curve[i];
+
+	for (i = 0; i < NUM_AMBI_LEVEL; i++) {
+		for (j = 0; j < NUM_AGGR_LEVEL; j++) {
+			config.min_reduction[i][j] = ram_table.min_reduction[i][j];
+			config.max_reduction[i][j] = ram_table.max_reduction[i][j];
+			config.bright_pos_gain[i][j] = ram_table.bright_pos_gain[i][j];
+			config.dark_pos_gain[i][j] = ram_table.dark_pos_gain[i][j];
+		}
+	}
+
+	for (i = 0; i < NUM_AGGR_LEVEL; i++) {
+		config.hybrid_factor[i] = ram_table.hybrid_factor[i];
+		config.contrast_factor[i] = ram_table.contrast_factor[i];
+		config.deviation_gain[i] = ram_table.deviation_gain[i];
+		config.min_knee[i] = ram_table.min_knee[i];
+		config.max_knee[i] = ram_table.max_knee[i];
+	}
+
+	config.min_abm_backlight = ram_table.min_abm_backlight;
 
-	fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params, false);
 	result = abm->funcs->init_abm_config(
-		abm, (char *)(&ram_table), IRAM_RESERVE_AREA_START_V2_2);
+		abm, (char *)(&config), sizeof(struct abm_config_table));
 
 	return result;
 }
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
