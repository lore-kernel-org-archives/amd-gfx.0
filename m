Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E767C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 040B820657
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fwTR5ddW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040B820657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0A256ECEE;
	Fri, 15 May 2020 18:13:42 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760084.outbound.protection.outlook.com [40.107.76.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 703566ECEF
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:13:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwIh5147LxQAnmdvNRc/YCH21Cii2BrIFel2Hfq2d0uMbO9Uln4OwltBzj+/eYh+NngxdCx0qkpowWD+1gAZEkgpaNb2Frtqx81piHAMV5xfXYgikiLfc0PtzM+KgLuinWM2EzK4yPQS17chCyn7xSI1ANZ5DcJ9BzWJdQzPVnGtiDpwXoRxLmtukKK/7rILuAWPdIvGot63NCLqYBB0gxZhoFpTPcC1dCm64JxDcNqRyFcRDGK5VSSuA1N7pv24ZtyelcAsZ9ERnIuNXbnGH3UEWTrrPgWbvjytue6UMswf4icjGHEHlKlXbjPZZKkkmC3yvT8j60HesBc0PVdEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdIlT5vbgBhiIIE4CQig7tO2I0Fp6WZbCMfZ3htmuMk=;
 b=BbHTlQHkd3eW3dDWgxYJ44yNlhvXIA1/Hp30CcXKdT5WN8FXDPTbYtoO1iJzR3OOKcDvNSaCsFGHvI0qo98+TgarrrIg/QlbAsJdPGOLoIv/1hAYkZluileyPVtle9AA6gOIwRKOc8YHfRDtT0vJtzy620JF2vW/lTgRjxFW6qK1J/hGmhVqi3V5sB1tdwOWVHScgUIhmmoKqs351na0gZ6DfyQUjNqKa8Wq+rkEde0MbO/ckGLC7STOkp8zVHqT5uq2baj9z46j/obv+iPShkHPTBpONx+WVN83TAC/2QhcCuCh2BLmpOGr2L2I9e9GgK/6AQS9updkqtJqdmpNcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdIlT5vbgBhiIIE4CQig7tO2I0Fp6WZbCMfZ3htmuMk=;
 b=fwTR5ddWo0Oh5mvMJpxQdQfb9PHy4PfiPtsCKT5XBrajBDu0CEoiTj0lqJN1Mj48bQa46SwrZRlCORRmJHAIT86jm+H9wfcVLYHz0nZM/h/xcKZO8u02YY1DpJbAAhmkb/9yA6mMIq70oYURn/jgk7jfEeq9MnG6KIK5miZjkaU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3848.namprd12.prod.outlook.com (2603:10b6:610:16::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Fri, 15 May
 2020 18:13:40 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 18:13:40 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/27] drm/amd/display: Handle persistence in DM
Date: Fri, 15 May 2020 14:12:50 -0400
Message-Id: <20200515181315.1237251-4-Rodrigo.Siqueira@amd.com>
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
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:13:39 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c1eeab44-e4b9-4770-ed5e-08d7f8fbb1e5
X-MS-TrafficTypeDiagnostic: CH2PR12MB3848:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB38483F87072B8CE7D32BD0EF98BD0@CH2PR12MB3848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OQv8Sc58t5ihQ7IpCsB7JUlDqOyqR5kjjoXHqbaua52tTJJ+rPmdYox1vvc6ThkYjD+icCozEdfQPgqW8saboHgso3sqssTgaGVoKaMMriJW88MCHL+BzQu2Azn8+iY0lqM2KEjFcvRJ9WbEKs+J9E2Wz2EcHn4xyB3AY1I63pYnFuCFiQhEmgPwgrrIrIJbfV9joLd57EN3/TtIvIFGQ1Vou6B53jTKu/jFbBAbHIHvtDvtdFZADO+BLwBgFWRUB6r9YkR4O0FEVo61GG14Z7IzqHm5uxDD+1EFfsigdZNrK4OZaJQlsdlz0+flIPKEzWNjHCG8/x8bvuMJXl2fh+O6SML4ruE1CDb77n0h3zPNtoz+EN6eQVp0Tm9eMuLspsAd53qajihNVqACYTq9rZYafnTvd5sNAUb3Pt74rG2/h2SP5cFUMAWw5SproAUi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(54906003)(86362001)(2906002)(186003)(8936002)(52116002)(6506007)(6512007)(8676002)(36756003)(316002)(5660300002)(16526019)(4326008)(6916009)(66556008)(478600001)(1076003)(66946007)(6486002)(66476007)(6666004)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: jeve85juPSxfezKUZ7C64N4DU1PQESSKXOpia7+9umj9NshiGwSZ1vdfVwhimbwqLlAmzaGmu9hwp3x4fmaj1UkdRPRUeEqQC4vjGpX9n7I3ML3GBZcxQRfQm7mIt5fpkYb+Bkx1qiREMpARGQV4A0bYlO2u6BCY8fp4V66afmPpQl5t5JKI0NqpB7SstfdmF/m6PrEr3UcV0qld/pnK/716Yj7K/nGaUznmhZ4o/hU6Yt3VlhieUc7eMmhxJN8C8i0zt6k8+MxBBH591A5cfOmzS7cgSjpifvYTRDzTF6dCDigTqjwHZZoCeHVZ5U0lYtFiA+6A4JeylAGNBSN2dCaUt4n2iW7EQlWGyvxX5Si6oLnudN6PKlIxGabY3my0+yPd8xSPYqpt2WI3E9fXzz9AWXCQy2drsOBaXavO2cDKrdyDbbSXc+HlFu46exEIl/QrSgDPh7T+gEDctbBuXCqGaqWD+altJhXlnyvUKG0pZx2j3/Y0m51f5hOhjlMVge4t8RraD4qWeMzBVkIeng==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1eeab44-e4b9-4770-ed5e-08d7f8fbb1e5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:13:40.3301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4Qp2LMO/r2CbaOmUwQQ4dOU6yIhukIYmH37HZ/EiElDSXpNK9VsiEufSHCyolYy/Z2cF7P2Ru22YImQCf/Jdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3848
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
Cc: Jaehyun Chung <jaehyun.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jaehyun Chung <jaehyun.chung@amd.com>

[Why]
Remove dm_write_persistent_data and dm_read_persistent_data as
persistence should be handled in DM.

[How]
Remove functions. Move read/write calls into DM layer while maintaining
logic.

Signed-off-by: Jaehyun Chung <jaehyun.chung@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_services.c    | 25 -------
 drivers/gpu/drm/amd/display/dc/dm_services.h  | 69 -------------------
 .../drm/amd/display/modules/inc/mod_stats.h   |  8 ++-
 3 files changed, 7 insertions(+), 95 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
index 022da5d45d4d..51f57420fadd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
@@ -47,29 +47,4 @@ void dm_perf_trace_timestamp(const char *func_name, unsigned int line)
 {
 }
 
-bool dm_write_persistent_data(struct dc_context *ctx,
-		const struct dc_sink *sink,
-		const char *module_name,
-		const char *key_name,
-		void *params,
-		unsigned int size,
-		struct persistent_data_flag *flag)
-{
-	/*TODO implement*/
-	return false;
-}
-
-bool dm_read_persistent_data(struct dc_context *ctx,
-				const struct dc_sink *sink,
-				const char *module_name,
-				const char *key_name,
-				void *params,
-				unsigned int size,
-				struct persistent_data_flag *flag)
-{
-	/*TODO implement*/
-	return false;
-}
-
 /**** power component interfaces ****/
-
diff --git a/drivers/gpu/drm/amd/display/dc/dm_services.h b/drivers/gpu/drm/amd/display/dc/dm_services.h
index 968ff1fef486..fdd1943c828d 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_services.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_services.h
@@ -261,75 +261,6 @@ struct persistent_data_flag {
 	bool save_per_edid;
 };
 
-/* Call to write data in registry editor for persistent data storage.
- *
- * \inputs      sink - identify edid/link for registry folder creation
- *              module name - identify folders for registry
- *              key name - identify keys within folders for registry
- *              params - value to write in defined folder/key
- *              size - size of the input params
- *              flag - determine whether to save by link or edid
- *
- * \returns     true - call is successful
- *              false - call failed
- *
- * sink         module         key
- * -----------------------------------------------------------------------------
- * NULL         NULL           NULL     - failure
- * NULL         NULL           -        - create key with param value
- *                                                      under base folder
- * NULL         -              NULL     - create module folder under base folder
- * -            NULL           NULL     - failure
- * NULL         -              -        - create key under module folder
- *                                            with no edid/link identification
- * -            NULL           -        - create key with param value
- *                                                       under base folder
- * -            -              NULL     - create module folder under base folder
- * -            -              -        - create key under module folder
- *                                              with edid/link identification
- */
-bool dm_write_persistent_data(struct dc_context *ctx,
-		const struct dc_sink *sink,
-		const char *module_name,
-		const char *key_name,
-		void *params,
-		unsigned int size,
-		struct persistent_data_flag *flag);
-
-
-/* Call to read data in registry editor for persistent data storage.
- *
- * \inputs      sink - identify edid/link for registry folder creation
- *              module name - identify folders for registry
- *              key name - identify keys within folders for registry
- *              size - size of the output params
- *              flag - determine whether it was save by link or edid
- *
- * \returns     params - value read from defined folder/key
- *              true - call is successful
- *              false - call failed
- *
- * sink         module         key
- * -----------------------------------------------------------------------------
- * NULL         NULL           NULL     - failure
- * NULL         NULL           -        - read key under base folder
- * NULL         -              NULL     - failure
- * -            NULL           NULL     - failure
- * NULL         -              -        - read key under module folder
- *                                             with no edid/link identification
- * -            NULL           -        - read key under base folder
- * -            -              NULL     - failure
- * -            -              -        - read key under module folder
- *                                              with edid/link identification
- */
-bool dm_read_persistent_data(struct dc_context *ctx,
-		const struct dc_sink *sink,
-		const char *module_name,
-		const char *key_name,
-		void *params,
-		unsigned int size,
-		struct persistent_data_flag *flag);
-
 bool dm_query_extended_brightness_caps
 	(struct dc_context *ctx, enum dm_acpi_display_type display,
 			struct dm_acpi_atif_backlight_caps *pCaps);
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h b/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h
index 3812094b52e8..4220fd8fdd60 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h
@@ -36,7 +36,13 @@ struct mod_stats_caps {
 	bool dummy;
 };
 
-struct mod_stats *mod_stats_create(struct dc *dc);
+struct mod_stats_init_params {
+	unsigned int stats_enable;
+	unsigned int stats_entries;
+};
+
+struct mod_stats *mod_stats_create(struct dc *dc,
+		struct mod_stats_init_params *init_params);
 
 void mod_stats_destroy(struct mod_stats *mod_stats);
 
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
