Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89954C56202
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 257CF22283
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cawf1r8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257CF22283
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8529D6EDD4;
	Wed, 21 Oct 2020 14:23:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3A526EDBD
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nssjzd0hWKXjmsIZ9RoJlqksmZy0f8qCRL6reAL+GLWfigrE/mwJ2TanMDwIldczIOWf6XrJ6MSslBO+oBRU8bzlQ3/JrnnYYKc69xLhyadamvS9GPZsbaoLNElnEtQilHnO+wl6pFWx69hXTZC61uq8WI5o+21piSqNxsfBj9o7m8yPDvAxPz8YUZ8Zo00hOv2hqWRKlpNFlslIxQO/a1hRTbqDWDq0PsRNHw2z+mCq1rDjoGgPvx26r/QpUKjVLZBdZGbaXx+qJ/mFmCNUNnn8dUyGnulhGT6oRwjNJUEVtOkWHyReaNkKznGQgq0VV8Wsc6SNpcD+qODLEQbmzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaR/s3tjtpTjTKgC3t4Z875IxE/CIGnV4OoYAJBn3Vo=;
 b=CAStrWf+bLVDMEmArW6L8w+vUvdoLxPeTMdq/pW1VW7usFrkXkcMkyWm7P+vO/A4pQHO8WqkVMiz4bJrAk+FpZGcpJ5xh2+YAL4TlsVotQiAtBE7VjDg0mrXJwnbTSQcgp2qYNs4p+y3vBq6I5oUgWqmk35XEmzYLiMaDjPWDmPR48MXfGqj5W6b+iOtCBzCk1MscPLFKKe0GlGCHil0F6TOakX4EJsRUuMevtOcyvtEY5aUxzI93+DR/NF7/7MYFVuc6nzs9GJTEpPWRiN/4Px0Uojt3kA6QG1qEPEiuBzJJRw98QHgO1LeweJOMJAOZax/x5VcqjamBWIw/j5H7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaR/s3tjtpTjTKgC3t4Z875IxE/CIGnV4OoYAJBn3Vo=;
 b=cawf1r8NWpOfRulhfxykXQ/WlQUl0YmdrSwRdfvRJYMpRM4TX8ouK7TqYYZaZSNOkfuD2W9bx7lb/F+J52HAixapJuspSdleB6TCMVB2YdTsMmSE2Act2Pfnpa3rPyBZcqM286pnqcExRGIh6x695aeCG/XzQnczr/8JxOQWCdM=
Received: from BN6PR16CA0027.namprd16.prod.outlook.com (2603:10b6:405:14::13)
 by BN6PR12MB1538.namprd12.prod.outlook.com (2603:10b6:405:4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 14:23:30 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::e) by BN6PR16CA0027.outlook.office365.com
 (2603:10b6:405:14::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:30 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:30 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:30 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:29 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 32/33] drm/amd/display: Using udelay for specific dongle while
 edid return defer
Date: Wed, 21 Oct 2020 10:22:56 -0400
Message-ID: <20201021142257.190969-33-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8038ea4-051f-4213-0a23-08d875cce28a
X-MS-TrafficTypeDiagnostic: BN6PR12MB1538:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1538F3EA896D9AC2E58945BF8B1C0@BN6PR12MB1538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lu1hKCacaIonn4Bu06Svlcz/BrHqS5eLS0pKr6kVIau64HLYO9W85cIbtB4xsdXQPwKD5+JwbOhFOs3rdfic6Sr0/ogAo52nylGR/OpdaRQ8Li3hcBAvAqRzpLAjoSoCmWImW3CFZh3OGwfSAuuAPqrhTKDd/v7zefNG6bPJYmR29At4v/izvOfpA6dHJsYTgEVpWjNee8ZKKDYOkBRuAvmaiRX/OUEZnPGgXxKkrzDH2ktQX0vpqvrAe2tYOo2SnTc3s9xpUkaq+C4mf55Gk39yRwrzw44ASC0EQ3tBzT4hjUcZRUTt6FfaH8XucYGz5kEXEE9BSJbIHZIBAoT01VkqpJMCcFvJsKlzDAL0BMuc5yKh5j3UJd7o9RsIOjQnCIyX0AlF0ltksqPMT6qnhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(46966005)(8676002)(47076004)(82310400003)(8936002)(82740400003)(4326008)(86362001)(7696005)(26005)(6916009)(356005)(2906002)(478600001)(426003)(2616005)(186003)(336012)(83380400001)(1076003)(54906003)(44832011)(36756003)(5660300002)(6666004)(70206006)(70586007)(81166007)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:30.6960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8038ea4-051f-4213-0a23-08d875cce28a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1538
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 jinlong zhang <jinlong.zhang@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: jinlong zhang <jinlong.zhang@amd.com>

[why]
Some platform has a limitation of 2ms for udelay

[how]
Add 1ms udelay for specific dongle.

Signed-off-by: jinlong zhang <jinlong.zhang@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c       | 7 +++++++
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c            | 4 +++-
 drivers/gpu/drm/amd/display/include/ddc_service_types.h | 2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index dec12de37642..ef0f50db4907 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -39,6 +39,7 @@
 
 #define AUX_POWER_UP_WA_DELAY 500
 #define I2C_OVER_AUX_DEFER_WA_DELAY 70
+#define I2C_OVER_AUX_DEFER_WA_DELAY_1MS 1
 
 /* CV smart dongle slave address for retrieving supported HDTV modes*/
 #define CV_SMART_DONGLE_ADDRESS 0x20
@@ -287,6 +288,12 @@ static uint32_t defer_delay_converter_wa(
 			sizeof(link->dpcd_caps.branch_dev_name)))
 		return defer_delay > I2C_OVER_AUX_DEFER_WA_DELAY ?
 			defer_delay : I2C_OVER_AUX_DEFER_WA_DELAY;
+		if (link->dpcd_caps.branch_dev_id == DP_BRANCH_DEVICE_ID_006037 &&
+			!memcmp(link->dpcd_caps.branch_dev_name,
+				DP_DVI_CONVERTER_ID_5,
+				sizeof(link->dpcd_caps.branch_dev_name)))
+		return defer_delay > I2C_OVER_AUX_DEFER_WA_DELAY_1MS ?
+			I2C_OVER_AUX_DEFER_WA_DELAY_1MS : defer_delay;
 
 	return defer_delay;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 743042d5905a..cda5fd0464bc 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -652,8 +652,10 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 				} else {
 					if ((*payload->reply == AUX_TRANSACTION_REPLY_AUX_DEFER) ||
 						(*payload->reply == AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER)) {
-						if (payload->defer_delay > 0)
+						if (payload->defer_delay > 1)
 							msleep(payload->defer_delay);
+						else if (payload->defer_delay <= 1)
+							udelay(payload->defer_delay * 1000);
 					}
 				}
 				break;
diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
index 9ad49da50a17..c9be899cd25c 100644
--- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
@@ -33,6 +33,7 @@
 #define DP_BRANCH_DEVICE_ID_0080E1 0x0080e1
 #define DP_BRANCH_DEVICE_ID_90CC24 0x90CC24
 #define DP_BRANCH_DEVICE_ID_00E04C 0x00E04C
+#define DP_BRANCH_DEVICE_ID_006037 0x006037
 
 enum ddc_result {
 	DDC_RESULT_UNKNOWN = 0,
@@ -122,5 +123,6 @@ static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
 static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
 /*DP to Dual link DVI converter*/
 static const uint8_t DP_DVI_CONVERTER_ID_4[] = "m2DVIa";
+static const uint8_t DP_DVI_CONVERTER_ID_5[] = "3393N2";
 
 #endif /* __DAL_DDC_SERVICE_TYPES_H__ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
