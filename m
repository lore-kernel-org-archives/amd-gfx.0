Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9320C4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFDDF61C53
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFDDF61C53
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BCCC6EDC0;
	Wed,  2 Jun 2021 16:51:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE4E6EDD4
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XT1Ej1qQEJZeaGaroLT++V8TRZj5k7MGnK/HwUwuSqiMQ8EQHhNBjQrZRZv/YLqeALaQkGeplpw2RIIC8f5CymI9RAIIRV5KmyrIIz9jhLuQ0OOGx2qnhs+yUDCkxqMgItNN95RVyhu0eL3ME0eLKw4t9rdoXhJjgv5Zvxm38kfcHTHDnaOv5i7ot8hMvTB/sjLxD10wfX7vXbwfQJg7VV2Zg64mJrpWL5o2fJE95QAZThg47pgS/a8C6e36DOYrezgutI0scmwD6eRExMxKpbCWznih6x6v0EaPD4JFl7tSM4spZNMPvzuv2pxIapW5R+tdeT82iv53m7nMqjtDSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBd5XwPbgxJfDXA7N/BH3pkxGtoFagHazgwlAiq43Ww=;
 b=lXkAQo6rrCWQgzwQGxXmfrKvzUOCcY+3HWYHfU01U/R/NdWhdrcvjhiA2FJuVsAWH2zAZJELQHfdE1K6QOZYKyL+DsYuS1oEUZLDOMzNortmucN93E8e7bZT78vETB5SnJUiCzoRX55EaaTpSofkoiq8gFqV//Zww/b1pbayCc9Klj4FC5nEDMVBcxqbJR9Qp/SVwRJUz7FKqWfUjljT89fiNVuGCB0Spyg2JptO4X7ttnhZH9TSs4R3woB3X7eHddW/movHFBoThH5dxPOf4yv4Vxt2m87Nw+40XlS0QmSBx3BJp9JP0m5FvtAn4hetshOxLmiYMNoKx3d9RGLbyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBd5XwPbgxJfDXA7N/BH3pkxGtoFagHazgwlAiq43Ww=;
 b=TbOUu73TsrLD/Pblgp02DHilLHNUdI+RBXgVU7gjgGmVlQKx1LkCkJY9vNMae7FA/LOUpucY7UpfbuMjaXOiaREfQi62WvD+UtDbKKa4TXSfSn9yKd0JHkYzQ2rV4pMrpW3R4YULsLghplmCash8g1RHIVlHdSuc1B/C6+C7LI8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:51:18 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:51:18 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 72/89] drm/amd/display: Add DCN3.1 DCCG
Date: Wed,  2 Jun 2021 12:48:51 -0400
Message-Id: <20210602164908.2848791-72-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:50:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6265edeb-ae4f-47d1-79a8-08d925e68028
X-MS-TrafficTypeDiagnostic: MN2PR12MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4534C21893DB6AF5F3298518F73D9@MN2PR12MB4534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0NCf+ljs/lwRr2X4xsMhESe9GS+TRNlhIXZ4zxml6TW4vT+uBSujnxN2tJBh4SKqTJjXoUtK70hx5o7AqHIJt3YKQqiUZhXB/lDuYmZktagtyzquE/IIabgCKDBMeXmvykqXwl3ZaVrqKmgC+tfURBez99YwxIoJk8iwrr3UuJ6Z+tTpG9R4T7oYzItVOghNtdmTFqI+QWLKCbstQ2sulzheXfeIbR7SmoPJZUp406wH5KOXP5BKzvOViUyF1hnKkMa5o0ItM8GVI7742KD2Jypw6vhRcvlaOeKd4GEsBVXuprOlrr1uTOlV4dcg+uJiKUNDm0A0DTeLq7xmwx6jojAsULchkk0fe9AcCTdw7gWuFYz/kv47zzuSqfi99BHAnahAdwONolvvAlTflOFnFMlTOzzIWQz0kXMqXElK9YzkkR8zPctUbJvZ/n39vgLDTOd3oFhldo3unMFRVhz8+uwq1OxFG1BEQ8AbX5vrB/wNh3jNSnAcXrKQOvXS9ZLGF24nUhZEZE01ZR5GIvs8fH5OBY+3oeIyl1KXuXysoIbsQSk+NmXRcQcd6jIAQ/bUpsBPHcD5OAcpLXJmKI6aX2/K9dK8yMiJeUg1LdnIW9jGpx5fHcd9LfjV3F4SMd4BbFat71Em3hm2cmEBf8Sq7mhYcTIYhO7Lrxv1Qb50vlCGUQ90Nv1DSjHr9D8W6Zj9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(30864003)(1076003)(8676002)(2906002)(8936002)(4326008)(2616005)(956004)(38350700002)(478600001)(38100700002)(83380400001)(66946007)(66476007)(66556008)(36756003)(54906003)(6486002)(52116002)(6916009)(316002)(6512007)(6506007)(16526019)(26005)(6666004)(5660300002)(186003)(86362001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4r2HXl5ro48Ht83PmGe700RdT2vdpJlNgzi2hm6Kk4l0+OzKUklce/akGEeH?=
 =?us-ascii?Q?rcU28HNW0HWCk/CA17c8b7SJmGMWJgzZkd4H8Ac37C+4yUzmxvPaMg0MfEN0?=
 =?us-ascii?Q?FkRQy2D2fwO/pgfU+qMGYngJHnk6zeXRt/JcjlTqnsQRJqYjmrO0HQjw1l1G?=
 =?us-ascii?Q?AITiVZ+WMM2iGnueJU/J4fnsfbF6KZVrdCbcdA3TWznL44dHIIxIM6rEkC5u?=
 =?us-ascii?Q?WOEACOo3QdtQ7twIv1NldGy5e7w8Zs4zDQ8YudbWFaN1+TLX1p2Fmmac0/Wk?=
 =?us-ascii?Q?2+HYOblx55Dx2a763mh8MyPM2ONmrQHYFZoeVf9BVGR66ASvXp/qhddX0hPf?=
 =?us-ascii?Q?u2sPCZ8+I5imHNe0Rm7yCyHddiFjKYJoREX5VLzzZzktXM6mQef1MErlEiZe?=
 =?us-ascii?Q?hSwvvTGFJ4iZj3GyKWeTGH/uo/CfRqYglqRiBMSBy838ab9IkMJR9X9coDph?=
 =?us-ascii?Q?kvWBLrjJxLMash2h9rwV+pEN1Zq2CPR12lpIATO1PsJgAYjWHuovFgyr60ss?=
 =?us-ascii?Q?cCdkWtNjWl0Xy1FqHB6N/x8H2VHsWAFMQ4tfzrHka0+uiYXH5Yj7D1MMbR0U?=
 =?us-ascii?Q?VZpP3wX1WCsuv+7tYs5E+kC2uNb7qhuKekj/3GQdWtvz7vfwOOo7jlrMoGHk?=
 =?us-ascii?Q?vZeGVIBl6TksDqBHTH2a2IYMnL0DMqJ5OY8dbBGhLz7rrLfoib/xOAJSDyZD?=
 =?us-ascii?Q?MQspVnRyLdnHBmmjA7TccvxAw7yEa+uD3F0IDAsqnqRz2asU3TBidCw77ALk?=
 =?us-ascii?Q?HFhsD75Axgq/yho1jOHEZz9uXEb4k6HnT/JuVZOGEmy385jx1nVUg3Ua2+5H?=
 =?us-ascii?Q?DxOA2vhETJ3DNQIhvu+1x2ltPWcqV/PLykwmUasRs7FbGnrUpFJ4VzFlmikn?=
 =?us-ascii?Q?wvzJ6PVzHxgLrNdCPc3kPTJWaOj2ZEozwLuZ9hoV6uDP3Moo11ipZZufx6J+?=
 =?us-ascii?Q?ZDPyyiaCdmwCvVBJe8VvehdGhxPdTc2zxJ2bN0Lg0rGn7GL1gUbjLyyQZY6Q?=
 =?us-ascii?Q?IdVpT7eza63wdxKBQvt/KbqP2oZoXbqgbVwoAlRhbx8EzoV/4UG9m8MiSerj?=
 =?us-ascii?Q?N3A35UgAjtc/Uk9ANwKv2q0L+J49DmzkJCswQp91DnuW0KOOx079N8IGjwVz?=
 =?us-ascii?Q?oLwwzEOLSEE38K0v9jpRdhh5jY9DxCuS46UTLmFHJCFrCo/Gyk5Wu6hJwAfl?=
 =?us-ascii?Q?j7eAYPL7AEf8Q2Vc71ut9HGZbQ8WzgYGF1fKwE7tXXFHvcC9NJ90MvfIKQmR?=
 =?us-ascii?Q?2/FTXa5ecJSOwjadJ0yRfDCjq40a5F+clBzCtZUkm0PQRtbvtmhyv1EYpctr?=
 =?us-ascii?Q?EoqtHiq2H7RWdDMjafBxALzq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6265edeb-ae4f-47d1-79a8-08d925e68028
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:17.4847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2aiuV/vS/0WQfaLV44MZuIbbwhqqdbkz28v6LdTnv13JksTyu6dO7+pYfn1Sv1UwTpM5yEpYxicx7vtPMTQfVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Add programming of the DCCG (Display Controller Clock Generator) block:

HW Blocks:

    +--------+
    |  DCCG  |
    +--------+

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |  54 ++++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c | 279 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h | 147 +++++++++
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  56 ++++
 4 files changed, 536 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
index d407f33308b9..e5aa2da3176d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
@@ -84,14 +84,53 @@
 	type PHYCSYMCLK_FORCE_EN;\
 	type PHYCSYMCLK_FORCE_SRC_SEL;
 
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+#define DCCG31_REG_FIELD_LIST(type) \
+	type PHYDSYMCLK_FORCE_EN;\
+	type PHYDSYMCLK_FORCE_SRC_SEL;\
+	type PHYESYMCLK_FORCE_EN;\
+	type PHYESYMCLK_FORCE_SRC_SEL;\
+	type DPSTREAMCLK_PIPE0_EN;\
+	type DPSTREAMCLK_PIPE1_EN;\
+	type DPSTREAMCLK_PIPE2_EN;\
+	type DPSTREAMCLK_PIPE3_EN;\
+	type HDMISTREAMCLK0_SRC_SEL;\
+	type HDMISTREAMCLK0_DTO_FORCE_DIS;\
+	type SYMCLK32_SE0_SRC_SEL;\
+	type SYMCLK32_SE1_SRC_SEL;\
+	type SYMCLK32_SE2_SRC_SEL;\
+	type SYMCLK32_SE3_SRC_SEL;\
+	type SYMCLK32_SE0_EN;\
+	type SYMCLK32_SE1_EN;\
+	type SYMCLK32_SE2_EN;\
+	type SYMCLK32_SE3_EN;\
+	type SYMCLK32_LE0_SRC_SEL;\
+	type SYMCLK32_LE1_SRC_SEL;\
+	type SYMCLK32_LE0_EN;\
+	type SYMCLK32_LE1_EN;\
+	type DTBCLK_DTO_ENABLE[MAX_PIPES];\
+	type DTBCLKDTO_ENABLE_STATUS[MAX_PIPES];\
+	type PIPE_DTO_SRC_SEL[MAX_PIPES];\
+	type DTBCLK_DTO_DIV[MAX_PIPES];\
+	type DCCG_AUDIO_DTO_SEL;\
+	type DCCG_AUDIO_DTO0_SOURCE_SEL;\
+	type DENTIST_DISPCLK_CHG_MODE;
+#endif
+
 struct dccg_shift {
 	DCCG_REG_FIELD_LIST(uint8_t)
 	DCCG3_REG_FIELD_LIST(uint8_t)
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	DCCG31_REG_FIELD_LIST(uint8_t)
+#endif
 };
 
 struct dccg_mask {
 	DCCG_REG_FIELD_LIST(uint32_t)
 	DCCG3_REG_FIELD_LIST(uint32_t)
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	DCCG31_REG_FIELD_LIST(uint32_t)
+#endif
 };
 
 struct dccg_registers {
@@ -102,6 +141,21 @@ struct dccg_registers {
 	uint32_t PHYASYMCLK_CLOCK_CNTL;
 	uint32_t PHYBSYMCLK_CLOCK_CNTL;
 	uint32_t PHYCSYMCLK_CLOCK_CNTL;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	uint32_t PHYDSYMCLK_CLOCK_CNTL;
+	uint32_t PHYESYMCLK_CLOCK_CNTL;
+	uint32_t OTG_PIXEL_RATE_CNTL[MAX_PIPES];
+	uint32_t DTBCLK_DTO_MODULO[MAX_PIPES];
+	uint32_t DTBCLK_DTO_PHASE[MAX_PIPES];
+	uint32_t DCCG_AUDIO_DTBCLK_DTO_MODULO;
+	uint32_t DCCG_AUDIO_DTBCLK_DTO_PHASE;
+	uint32_t DCCG_AUDIO_DTO_SOURCE;
+	uint32_t DPSTREAMCLK_CNTL;
+	uint32_t HDMISTREAMCLK_CNTL;
+	uint32_t SYMCLK32_SE_CNTL;
+	uint32_t SYMCLK32_LE_CNTL;
+	uint32_t DENTIST_DISPCLK_CNTL;
+#endif
 };
 
 struct dcn_dccg {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
new file mode 100644
index 000000000000..696c9307715d
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -0,0 +1,279 @@
+/*
+ * Copyright 2018 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "reg_helper.h"
+#include "core_types.h"
+#include "dcn31_dccg.h"
+
+#define TO_DCN_DCCG(dccg)\
+	container_of(dccg, struct dcn_dccg, base)
+
+#define REG(reg) \
+	(dccg_dcn->regs->reg)
+
+#undef FN
+#define FN(reg_name, field_name) \
+	dccg_dcn->dccg_shift->field_name, dccg_dcn->dccg_mask->field_name
+
+#define CTX \
+	dccg_dcn->base.ctx
+#define DC_LOGGER \
+	dccg->ctx->logger
+
+void dccg31_set_physymclk(
+		struct dccg *dccg,
+		int phy_inst,
+		enum physymclk_clock_source clk_src,
+		bool force_enable)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	/* Force PHYSYMCLK on and Select phyd32clk as the source of clock which is output to PHY through DCIO */
+	switch (phy_inst) {
+	case 0:
+		if (force_enable)
+			REG_UPDATE_2(PHYASYMCLK_CLOCK_CNTL,
+					PHYASYMCLK_FORCE_EN, 1,
+					PHYASYMCLK_FORCE_SRC_SEL, clk_src);
+		else
+			REG_UPDATE_2(PHYASYMCLK_CLOCK_CNTL,
+					PHYASYMCLK_FORCE_EN, 0,
+					PHYASYMCLK_FORCE_SRC_SEL, 0);
+		break;
+	case 1:
+		if (force_enable)
+			REG_UPDATE_2(PHYBSYMCLK_CLOCK_CNTL,
+					PHYBSYMCLK_FORCE_EN, 1,
+					PHYBSYMCLK_FORCE_SRC_SEL, clk_src);
+		else
+			REG_UPDATE_2(PHYBSYMCLK_CLOCK_CNTL,
+					PHYBSYMCLK_FORCE_EN, 0,
+					PHYBSYMCLK_FORCE_SRC_SEL, 0);
+		break;
+	case 2:
+		if (force_enable)
+			REG_UPDATE_2(PHYCSYMCLK_CLOCK_CNTL,
+					PHYCSYMCLK_FORCE_EN, 1,
+					PHYCSYMCLK_FORCE_SRC_SEL, clk_src);
+		else
+			REG_UPDATE_2(PHYCSYMCLK_CLOCK_CNTL,
+					PHYCSYMCLK_FORCE_EN, 0,
+					PHYCSYMCLK_FORCE_SRC_SEL, 0);
+		break;
+	case 3:
+		if (force_enable)
+			REG_UPDATE_2(PHYDSYMCLK_CLOCK_CNTL,
+					PHYDSYMCLK_FORCE_EN, 1,
+					PHYDSYMCLK_FORCE_SRC_SEL, clk_src);
+		else
+			REG_UPDATE_2(PHYDSYMCLK_CLOCK_CNTL,
+					PHYDSYMCLK_FORCE_EN, 0,
+					PHYDSYMCLK_FORCE_SRC_SEL, 0);
+		break;
+	case 4:
+		if (force_enable)
+			REG_UPDATE_2(PHYESYMCLK_CLOCK_CNTL,
+					PHYESYMCLK_FORCE_EN, 1,
+					PHYESYMCLK_FORCE_SRC_SEL, clk_src);
+		else
+			REG_UPDATE_2(PHYESYMCLK_CLOCK_CNTL,
+					PHYESYMCLK_FORCE_EN, 0,
+					PHYESYMCLK_FORCE_SRC_SEL, 0);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+/* Controls the generation of pixel valid for OTG in (OTG -> HPO case) */
+void dccg31_set_dtbclk_dto(
+		struct dccg *dccg,
+		int dtbclk_inst,
+		int req_dtbclk_khz,
+		int num_odm_segments,
+		const struct dc_crtc_timing *timing)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+	uint32_t dtbdto_div;
+
+	/* Mode	                DTBDTO Rate       DTBCLK_DTO<x>_DIV Register
+	 * ODM 4:1 combine      pixel rate/4      2
+	 * ODM 2:1 combine      pixel rate/2      4
+	 * non-DSC 4:2:0 mode   pixel rate/2      4
+	 * DSC native 4:2:0     pixel rate/2      4
+	 * DSC native 4:2:2     pixel rate/2      4
+	 * Other modes          pixel rate        8
+	 */
+	if (num_odm_segments == 4) {
+		dtbdto_div = 2;
+		req_dtbclk_khz = req_dtbclk_khz / 4;
+	} else if ((num_odm_segments == 2) ||
+			(timing->pixel_encoding == PIXEL_ENCODING_YCBCR420) ||
+			(timing->flags.DSC && timing->pixel_encoding == PIXEL_ENCODING_YCBCR422
+					&& !timing->dsc_cfg.ycbcr422_simple)) {
+		dtbdto_div = 4;
+		req_dtbclk_khz = req_dtbclk_khz / 2;
+	} else
+		dtbdto_div = 8;
+
+	if (dccg->ref_dtbclk_khz && req_dtbclk_khz) {
+		uint32_t modulo, phase;
+
+		// phase / modulo = dtbclk / dtbclk ref
+		modulo = dccg->ref_dtbclk_khz * 1000;
+		phase = div_u64((((unsigned long long)modulo * req_dtbclk_khz) + dccg->ref_dtbclk_khz - 1),
+			dccg->ref_dtbclk_khz);
+
+		REG_UPDATE(OTG_PIXEL_RATE_CNTL[dtbclk_inst],
+				DTBCLK_DTO_DIV[dtbclk_inst], dtbdto_div);
+
+		REG_WRITE(DTBCLK_DTO_MODULO[dtbclk_inst], modulo);
+		REG_WRITE(DTBCLK_DTO_PHASE[dtbclk_inst], phase);
+
+		REG_UPDATE(OTG_PIXEL_RATE_CNTL[dtbclk_inst],
+				DTBCLK_DTO_ENABLE[dtbclk_inst], 1);
+
+		REG_WAIT(OTG_PIXEL_RATE_CNTL[dtbclk_inst],
+				DTBCLKDTO_ENABLE_STATUS[dtbclk_inst], 1,
+				1, 100);
+
+		/* The recommended programming sequence to enable DTBCLK DTO to generate
+		 * valid pixel HPO DPSTREAM ENCODER, specifies that DTO source select should
+		 * be set only after DTO is enabled
+		 */
+		REG_UPDATE(OTG_PIXEL_RATE_CNTL[dtbclk_inst],
+				PIPE_DTO_SRC_SEL[dtbclk_inst], 1);
+
+		dccg->dtbclk_khz[dtbclk_inst] = req_dtbclk_khz;
+	} else {
+		REG_UPDATE_3(OTG_PIXEL_RATE_CNTL[dtbclk_inst],
+				DTBCLK_DTO_ENABLE[dtbclk_inst], 0,
+				PIPE_DTO_SRC_SEL[dtbclk_inst], 0,
+				DTBCLK_DTO_DIV[dtbclk_inst], dtbdto_div);
+
+		REG_WRITE(DTBCLK_DTO_MODULO[dtbclk_inst], 0);
+		REG_WRITE(DTBCLK_DTO_PHASE[dtbclk_inst], 0);
+
+		dccg->dtbclk_khz[dtbclk_inst] = 0;
+	}
+}
+
+void dccg31_set_audio_dtbclk_dto(
+		struct dccg *dccg,
+		uint32_t req_audio_dtbclk_khz)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (dccg->ref_dtbclk_khz && req_audio_dtbclk_khz) {
+		uint32_t modulo, phase;
+
+		// phase / modulo = dtbclk / dtbclk ref
+		modulo = dccg->ref_dtbclk_khz * 1000;
+		phase = div_u64((((unsigned long long)modulo * req_audio_dtbclk_khz) + dccg->ref_dtbclk_khz - 1),
+			dccg->ref_dtbclk_khz);
+
+
+		REG_WRITE(DCCG_AUDIO_DTBCLK_DTO_MODULO, modulo);
+		REG_WRITE(DCCG_AUDIO_DTBCLK_DTO_PHASE, phase);
+
+		//REG_UPDATE(DCCG_AUDIO_DTO_SOURCE,
+		//		DCCG_AUDIO_DTBCLK_DTO_USE_512FBR_DTO, 1);
+
+		REG_UPDATE(DCCG_AUDIO_DTO_SOURCE,
+				DCCG_AUDIO_DTO_SEL, 4);  //  04 - DCCG_AUDIO_DTO_SEL_AUDIO_DTO_DTBCLK
+
+		dccg->audio_dtbclk_khz = req_audio_dtbclk_khz;
+	} else {
+		REG_WRITE(DCCG_AUDIO_DTBCLK_DTO_PHASE, 0);
+		REG_WRITE(DCCG_AUDIO_DTBCLK_DTO_MODULO, 0);
+
+		REG_UPDATE(DCCG_AUDIO_DTO_SOURCE,
+				DCCG_AUDIO_DTO_SEL, 3);  //  03 - DCCG_AUDIO_DTO_SEL_NO_AUDIO_DTO
+
+		dccg->audio_dtbclk_khz = 0;
+	}
+}
+
+static void dccg31_get_dccg_ref_freq(struct dccg *dccg,
+		unsigned int xtalin_freq_inKhz,
+		unsigned int *dccg_ref_freq_inKhz)
+{
+	/*
+	 * Assume refclk is sourced from xtalin
+	 * expect 24MHz
+	 */
+	*dccg_ref_freq_inKhz = xtalin_freq_inKhz;
+	return;
+}
+
+static void dccg31_set_dispclk_change_mode(
+	struct dccg *dccg,
+	enum dentist_dispclk_change_mode change_mode)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	REG_UPDATE(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_MODE,
+		   change_mode == DISPCLK_CHANGE_MODE_RAMPING ? 2 : 0);
+}
+
+void dccg31_init(struct dccg *dccg)
+{
+}
+
+static const struct dccg_funcs dccg31_funcs = {
+	.update_dpp_dto = dccg2_update_dpp_dto,
+	.get_dccg_ref_freq = dccg31_get_dccg_ref_freq,
+	.dccg_init = dccg31_init,
+	.set_physymclk = dccg31_set_physymclk,
+	.set_dtbclk_dto = dccg31_set_dtbclk_dto,
+	.set_audio_dtbclk_dto = dccg31_set_audio_dtbclk_dto,
+	.set_dispclk_change_mode = dccg31_set_dispclk_change_mode,
+};
+
+struct dccg *dccg31_create(
+	struct dc_context *ctx,
+	const struct dccg_registers *regs,
+	const struct dccg_shift *dccg_shift,
+	const struct dccg_mask *dccg_mask)
+{
+	struct dcn_dccg *dccg_dcn = kzalloc(sizeof(*dccg_dcn), GFP_KERNEL);
+	struct dccg *base;
+
+	if (dccg_dcn == NULL) {
+		BREAK_TO_DEBUGGER();
+		return NULL;
+	}
+
+	base = &dccg_dcn->base;
+	base->ctx = ctx;
+	base->funcs = &dccg31_funcs;
+
+	dccg_dcn->regs = regs;
+	dccg_dcn->dccg_shift = dccg_shift;
+	dccg_dcn->dccg_mask = dccg_mask;
+
+	return &dccg_dcn->base;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
new file mode 100644
index 000000000000..706ad80ba873
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
@@ -0,0 +1,147 @@
+/*
+ * Copyright 2018 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef __DCN31_DCCG_H__
+#define __DCN31_DCCG_H__
+
+#include "dcn30/dcn30_dccg.h"
+
+#define DCCG_SFII(block, reg_name, field_prefix, field_name, inst, post_fix)\
+	.field_prefix ## _ ## field_name[inst] = block ## inst ## _ ## reg_name ## __ ## field_prefix ## inst ## _ ## field_name ## post_fix
+
+
+#define DCCG_REG_LIST_DCN31() \
+	SR(DPPCLK_DTO_CTRL),\
+	DCCG_SRII(DTO_PARAM, DPPCLK, 0),\
+	DCCG_SRII(DTO_PARAM, DPPCLK, 1),\
+	DCCG_SRII(DTO_PARAM, DPPCLK, 2),\
+	DCCG_SRII(DTO_PARAM, DPPCLK, 3),\
+	SR(PHYASYMCLK_CLOCK_CNTL),\
+	SR(PHYBSYMCLK_CLOCK_CNTL),\
+	SR(PHYCSYMCLK_CLOCK_CNTL),\
+	SR(PHYDSYMCLK_CLOCK_CNTL),\
+	SR(PHYESYMCLK_CLOCK_CNTL),\
+	SR(DPSTREAMCLK_CNTL),\
+	SR(SYMCLK32_SE_CNTL),\
+	SR(SYMCLK32_LE_CNTL),\
+	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 0),\
+	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 1),\
+	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 2),\
+	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 3),\
+	DCCG_SRII(MODULO, DTBCLK_DTO, 0),\
+	DCCG_SRII(MODULO, DTBCLK_DTO, 1),\
+	DCCG_SRII(MODULO, DTBCLK_DTO, 2),\
+	DCCG_SRII(MODULO, DTBCLK_DTO, 3),\
+	DCCG_SRII(PHASE, DTBCLK_DTO, 0),\
+	DCCG_SRII(PHASE, DTBCLK_DTO, 1),\
+	DCCG_SRII(PHASE, DTBCLK_DTO, 2),\
+	DCCG_SRII(PHASE, DTBCLK_DTO, 3),\
+	SR(DCCG_AUDIO_DTBCLK_DTO_MODULO),\
+	SR(DCCG_AUDIO_DTBCLK_DTO_PHASE),\
+	SR(DCCG_AUDIO_DTO_SOURCE),\
+	SR(DENTIST_DISPCLK_CNTL)
+
+
+#define DCCG_MASK_SH_LIST_DCN31(mask_sh) \
+	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_ENABLE, DPPCLK, 0, mask_sh),\
+	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_DB_EN, DPPCLK, 0, mask_sh),\
+	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_ENABLE, DPPCLK, 1, mask_sh),\
+	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_DB_EN, DPPCLK, 1, mask_sh),\
+	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_ENABLE, DPPCLK, 2, mask_sh),\
+	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_DB_EN, DPPCLK, 2, mask_sh),\
+	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_ENABLE, DPPCLK, 3, mask_sh),\
+	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_DB_EN, DPPCLK, 3, mask_sh),\
+	DCCG_SF(DPPCLK0_DTO_PARAM, DPPCLK0_DTO_PHASE, mask_sh),\
+	DCCG_SF(DPPCLK0_DTO_PARAM, DPPCLK0_DTO_MODULO, mask_sh),\
+	DCCG_SF(PHYASYMCLK_CLOCK_CNTL, PHYASYMCLK_FORCE_EN, mask_sh),\
+	DCCG_SF(PHYASYMCLK_CLOCK_CNTL, PHYASYMCLK_FORCE_SRC_SEL, mask_sh),\
+	DCCG_SF(PHYBSYMCLK_CLOCK_CNTL, PHYBSYMCLK_FORCE_EN, mask_sh),\
+	DCCG_SF(PHYBSYMCLK_CLOCK_CNTL, PHYBSYMCLK_FORCE_SRC_SEL, mask_sh),\
+	DCCG_SF(PHYCSYMCLK_CLOCK_CNTL, PHYCSYMCLK_FORCE_EN, mask_sh),\
+	DCCG_SF(PHYCSYMCLK_CLOCK_CNTL, PHYCSYMCLK_FORCE_SRC_SEL, mask_sh),\
+	DCCG_SF(PHYDSYMCLK_CLOCK_CNTL, PHYDSYMCLK_FORCE_EN, mask_sh),\
+	DCCG_SF(PHYDSYMCLK_CLOCK_CNTL, PHYDSYMCLK_FORCE_SRC_SEL, mask_sh),\
+	DCCG_SF(PHYESYMCLK_CLOCK_CNTL, PHYESYMCLK_FORCE_EN, mask_sh),\
+	DCCG_SF(PHYESYMCLK_CLOCK_CNTL, PHYESYMCLK_FORCE_SRC_SEL, mask_sh),\
+	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK_PIPE0_EN, mask_sh),\
+	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK_PIPE1_EN, mask_sh),\
+	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK_PIPE2_EN, mask_sh),\
+	DCCG_SF(DPSTREAMCLK_CNTL, DPSTREAMCLK_PIPE3_EN, mask_sh),\
+	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE0_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE1_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE2_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE3_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE0_EN, mask_sh),\
+	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE1_EN, mask_sh),\
+	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE2_EN, mask_sh),\
+	DCCG_SF(SYMCLK32_SE_CNTL, SYMCLK32_SE3_EN, mask_sh),\
+	DCCG_SF(SYMCLK32_LE_CNTL, SYMCLK32_LE0_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLK32_LE_CNTL, SYMCLK32_LE1_SRC_SEL, mask_sh),\
+	DCCG_SF(SYMCLK32_LE_CNTL, SYMCLK32_LE0_EN, mask_sh),\
+	DCCG_SF(SYMCLK32_LE_CNTL, SYMCLK32_LE1_EN, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, DTBCLK_DTO, ENABLE, 0, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, DTBCLK_DTO, ENABLE, 1, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, DTBCLK_DTO, ENABLE, 2, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, DTBCLK_DTO, ENABLE, 3, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, DTBCLKDTO, ENABLE_STATUS, 0, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, DTBCLKDTO, ENABLE_STATUS, 1, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, DTBCLKDTO, ENABLE_STATUS, 2, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, DTBCLKDTO, ENABLE_STATUS, 3, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, PIPE, DTO_SRC_SEL, 0, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, PIPE, DTO_SRC_SEL, 1, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, PIPE, DTO_SRC_SEL, 2, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, PIPE, DTO_SRC_SEL, 3, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, DTBCLK_DTO, DIV, 0, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, DTBCLK_DTO, DIV, 1, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, DTBCLK_DTO, DIV, 2, mask_sh),\
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, DTBCLK_DTO, DIV, 3, mask_sh),\
+	DCCG_SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO_SEL, mask_sh),\
+	DCCG_SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO0_SOURCE_SEL, mask_sh),\
+	DCCG_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_MODE, mask_sh)
+
+
+struct dccg *dccg31_create(
+	struct dc_context *ctx,
+	const struct dccg_registers *regs,
+	const struct dccg_shift *dccg_shift,
+	const struct dccg_mask *dccg_mask);
+
+void dccg31_init(struct dccg *dccg);
+
+void dccg31_set_physymclk(
+		struct dccg *dccg,
+		int phy_inst,
+		enum physymclk_clock_source clk_src,
+		bool force_enable);
+
+void dccg31_set_audio_dtbclk_dto(
+		struct dccg *dccg,
+		uint32_t req_audio_dtbclk_khz);
+
+void dccg31_set_hdmistreamclk(
+		struct dccg *dccg,
+		enum hdmistreamclk_source src);
+
+#endif //__DCN31_DCCG_H__
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 336c80a18175..f7aa703e3175 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -29,11 +29,44 @@
 #include "dc_types.h"
 #include "hw_shared.h"
 
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+enum phyd32clk_clock_source {
+	PHYD32CLKA,
+	PHYD32CLKB,
+	PHYD32CLKC,
+	PHYD32CLKD,
+	PHYD32CLKE,
+	PHYD32CLKF,
+	PHYD32CLKG,
+};
+
+enum physymclk_clock_source {
+	PHYSYMCLK_FORCE_SRC_SYMCLK,    // Select symclk as source of clock which is output to PHY through DCIO.
+	PHYSYMCLK_FORCE_SRC_PHYD18CLK, // Select phyd18clk as the source of clock which is output to PHY through DCIO.
+	PHYSYMCLK_FORCE_SRC_PHYD32CLK, // Select phyd32clk as the source of clock which is output to PHY through DCIO.
+};
+
+enum hdmistreamclk_source {
+	REFCLK,                   // Selects REFCLK as source for hdmistreamclk.
+	DTBCLK0,                  // Selects DTBCLK0 as source for hdmistreamclk.
+};
+
+enum dentist_dispclk_change_mode {
+	DISPCLK_CHANGE_MODE_IMMEDIATE,
+	DISPCLK_CHANGE_MODE_RAMPING,
+};
+#endif
+
 struct dccg {
 	struct dc_context *ctx;
 	const struct dccg_funcs *funcs;
 	int pipe_dppclk_khz[MAX_PIPES];
 	int ref_dppclk;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	int dtbclk_khz[MAX_PIPES];
+	int audio_dtbclk_khz;
+	int ref_dtbclk_khz;
+#endif
 };
 
 struct dccg_funcs {
@@ -44,6 +77,29 @@ struct dccg_funcs {
 			unsigned int xtalin_freq_inKhz,
 			unsigned int *dccg_ref_freq_inKhz);
 	void (*dccg_init)(struct dccg *dccg);
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+
+	void (*set_physymclk)(
+			struct dccg *dccg,
+			int phy_inst,
+			enum physymclk_clock_source clk_src,
+			bool force_enable);
+
+	void (*set_dtbclk_dto)(
+			struct dccg *dccg,
+			int dtbclk_inst,
+			int req_dtbclk_khz,
+			int num_odm_segments,
+			const struct dc_crtc_timing *timing);
+
+	void (*set_audio_dtbclk_dto)(
+			struct dccg *dccg,
+			uint32_t req_audio_dtbclk_khz);
+
+	void (*set_dispclk_change_mode)(
+			struct dccg *dccg,
+			enum dentist_dispclk_change_mode change_mode);
+#endif
 };
 
 #endif //__DAL_DCCG_H__
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
