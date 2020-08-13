Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F9CC433E3
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D786020768
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Glabx438"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D786020768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FF866E142;
	Thu, 13 Aug 2020 21:35:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6ACF6E142
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 21:35:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Igv0HOh9amBReNsZKRiJ7/atIzpgcQcf8fG8KLpukljckKaXNl1yx0Ekn1jf1ND3zPzg5p8TuPPNZUCLQRPre1mAYYO2WCHxnpBabcjtpzlc49SHp+oa9l83dOckiGuZ7C5On5NhcLhBRn17FNaq21+beIH9p8BW42bFjyzO8zwD+EcCovELZjQoETsPZJM5KbYq5N4jc+waZIxZElAzOOhU+BfkqFLaXTyA1g0JMtvMxdLur/GYObCyQNfu1ms3QQfSnipE0puLNDcTcL/IAnvj2cbwR0G2Q0qA//JnmteAPKPh7mGEaFrFqxT7ZDzh16MwsYd3jzKOCH8XDK7HfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYxOncoxj0HCzXOfg5vuhpL4dgvW7BRd3OCm9ZEL/sI=;
 b=IQmqo6ITQjiHuJ2TLui/kzBv0BhAMEV4eossl5ZnqNjnrgAFS5YLnRCtKiRp4XTmlV41EmFdb1rH5nSrlDLNH3QQ1Cy2X7JbDp6sBStmgkOs6rZ8/U7/ZKRKR5s/NowtK2G/1MEabIxJoBmYU3aOS8Ebpq1BTgGUp0Lq5nDFHjpJfvGaNa9EXkwnb/pBeIvXt+zW9R3AZxR2c26FSBQeyAmCJ+KmBqY4fGDKhoenyQYcMJ5CfrNw573YYxLwkgVXcMfB6K/QutD7RxQq5dJxM3ZinVGhXVjRogynBsaJj45YncPvI0FMR0uDGYcL4irQcjDxAmymo2SbEjb/bXCgpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYxOncoxj0HCzXOfg5vuhpL4dgvW7BRd3OCm9ZEL/sI=;
 b=Glabx438q9itcK1uri5ZveEgUQqPDq7e9HN5+dWQr9eP+blbcbqL19VQilJOA1oPrdiKR9TxDwO6coVHUihbqiJBRkKvXwwPTn0BBv9MZl8xUqd+YHMzDm2WovF4cMvub06GQPTORcmlCxuapioBz0xgsKfPK95kmQ8eH9nFhzI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Thu, 13 Aug 2020 21:35:29 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7%9]) with mapi id 15.20.3283.016; Thu, 13 Aug 2020
 21:35:29 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/17] drm/amd/display: Change ABM config init interface
Date: Thu, 13 Aug 2020 17:33:45 -0400
Message-Id: <20200813213356.1606886-7-Rodrigo.Siqueira@amd.com>
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
 15.20.3283.15 via Frontend Transport; Thu, 13 Aug 2020 21:35:28 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2607:fea8:56e0:6d60::2db6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6e88e743-09dc-4c16-0d1a-08d83fd0cc65
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1355D2AECDF64E3D7AD5BA9E98430@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U0b6qniyg6dKq1rmIQpt8SgXJbv0C4iHXU0im8o4r26Wawu89cpAWQy+lchtFYEX6uDUfeCNkfwlZ3+vDhkYa6fh6blObR01sYW7ijbMOWI5ICab2S2wOmsTQ56oALXgAHD3e5UXme5p6f9Cbj+R+mArgnQuIx8cIEto19dN1WKnaLGhxXk64JlMvd7wLTh9FcxxeU4a0bvLXqOlDAmjDW7/35dzgwiL+f8KN2+jVB/rNsxqoQUBME5DnZ2d4TlzXgFR/HTWOvKnvMLlWAmu+G8Zc1STXERGpPmrp8YaMZz9erHk4EFwuHa/dz38DN84
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(2616005)(6512007)(83380400001)(6486002)(4326008)(316002)(478600001)(1076003)(6916009)(66476007)(66556008)(36756003)(52116002)(66946007)(2906002)(6506007)(8676002)(6666004)(54906003)(16526019)(8936002)(5660300002)(186003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ucISJC7xuuenDJjM9SyfOCCAJWkBRQclvzQ7l50KghNEKS56CvhawZ5IrDcRL7yT46iCgcu2xtqysqGI61zz5yL/pifZafTWc+1CRtTooobj+GPsxEit+SpX9vCOtjjxUVC8vW/kY8NX4KHDPcoxRLY4KNrV/7AzmN4j9jg2+v50xVlCRCESgAFigc19ky9rJ/60RrIvhQULhHgjueXRF0CCEB8KJBe+UZdwVrj2mOFfrPXIa7eRua05LNUiHx0/jOvYRzJbUZSbVMtkTDnfRjHNANcFGlZwQ4tHvcn/ZcV7FG9KtH91dAVsOUgTJOEXC91ma5oMoWD4d6/QGj5n09dwp+GS5KUX1TjQoqZ/4EK+W++NYIDjPaPTGdgE9TtPoaFhY/skzQmNoA6y61TIYmfU2+3ISObGImihC5+qqHhoHbP/2eBhtq3eKcX0+/8H90KqPi8FqSQDsyC/vshYY13jwv2DA8xxMRLfC6dfegvslKcEaym+zAakMnWu6ykuFRhF9nPPpUHMQeNQGZZSaGym82ODVVDSQwvN1g0GJSfYXtBcvirSDvkdRRoLof0LKA5kBNPm8iVn2wnTTtQzHEIWvMB31PuW+fiPr0kV5367Y7hsYs1O+slvGTKTGAj2x9VG/pyzfp1Id0r1LHFVEO7lKyk1S2PiNHpKGjN5chNNTapo1debfZXlSU9kVrk6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e88e743-09dc-4c16-0d1a-08d83fd0cc65
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 21:35:28.9818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZhrVVv7zOpuQqnBngM5gI7p2ZSsrkGZT8tSfhvsGTG2e9VnkgYKNDXi/Y7xWNjMGMlZ3dsaoyRSUkU6PZshljw==
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
Cc: Chris Park <Chris.Park@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why & How]
change abm config init interface to support multiple ABMs.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 .../amd/display/modules/power/power_helpers.c | 19 +++++++++++++++----
 .../amd/display/modules/power/power_helpers.h |  4 +++-
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ff5f7f7ceec6..6165bd51f5a6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1415,7 +1415,7 @@ static int dm_late_init(void *handle)
 	if (dmcu)
 		ret = dmcu_load_iram(dmcu, params);
 	else if (adev->dm.dc->ctx->dmub_srv)
-		ret = dmub_init_abm_config(adev->dm.dc->res_pool->abm, params);
+		ret = dmub_init_abm_config(adev->dm.dc->res_pool, params);
 
 	if (!ret)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 859724771a75..61497954e67e 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -657,7 +657,7 @@ void fill_iram_v_2_3(struct iram_table_v_2_2 *ram_table, struct dmcu_iram_parame
 			params, ram_table, big_endian);
 }
 
-bool dmub_init_abm_config(struct abm *abm,
+bool dmub_init_abm_config(struct resource_pool *res_pool,
 	struct dmcu_iram_parameters params)
 {
 	struct iram_table_v_2_2 ram_table;
@@ -665,8 +665,13 @@ bool dmub_init_abm_config(struct abm *abm,
 	bool result = false;
 	uint32_t i, j = 0;
 
-	if (abm == NULL)
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+	if (res_pool->abm == NULL && res_pool->multiple_abms[0] == NULL)
 		return false;
+#else
+	if (res_pool->abm == NULL)
+		return false;
+#endif
 
 	memset(&ram_table, 0, sizeof(ram_table));
 	memset(&config, 0, sizeof(config));
@@ -707,8 +712,14 @@ bool dmub_init_abm_config(struct abm *abm,
 
 	config.min_abm_backlight = ram_table.min_abm_backlight;
 
-	result = abm->funcs->init_abm_config(
-		abm, (char *)(&config), sizeof(struct abm_config_table));
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+	if (res_pool->multiple_abms[0]) {
+		result = res_pool->multiple_abms[0]->funcs->init_abm_config(
+			res_pool->multiple_abms[0], (char *)(&config), sizeof(struct abm_config_table));
+	} else
+#endif
+		result = res_pool->abm->funcs->init_abm_config(
+			res_pool->abm, (char *)(&config), sizeof(struct abm_config_table));
 
 	return result;
 }
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
index 46fbca2e2cd1..fa4728d88092 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
@@ -28,6 +28,8 @@
 #include "dc/inc/hw/dmcu.h"
 #include "dc/inc/hw/abm.h"
 
+struct resource_pool;
+
 
 enum abm_defines {
 	abm_defines_max_level = 4,
@@ -45,7 +47,7 @@ struct dmcu_iram_parameters {
 
 bool dmcu_load_iram(struct dmcu *dmcu,
 		struct dmcu_iram_parameters params);
-bool dmub_init_abm_config(struct abm *abm,
+bool dmub_init_abm_config(struct resource_pool *res_pool,
 		struct dmcu_iram_parameters params);
 
 #endif /* MODULES_POWER_POWER_HELPERS_H_ */
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
