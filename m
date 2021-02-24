Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3D9C4332D
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3CFF64EDB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CFF64EDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E29616EBB5;
	Wed, 24 Feb 2021 22:22:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D74086EBA3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPwvKVyqeKBrzi3TfoSVgHo/8cY4fYIPK5vnceqlS3haS8WcPFeIs1TiudqqOsPqel5LpsP50LwVcHQMUvSpWsfnRJ2jNZ4y7A6Ar+W8uDVEu9XEYf8Zq59EjRzjlMTXMEygfO7IV/oX7xqCLncNH9REM3JQqb4dtvqNltS7FxeBHsAuwgA2UHGlxkzkBIATjg3p3THveHcdoCE/CNFV3vCP+uOoUsK3/MW+cNBGWwQoyQyO1TbnbQJqxp68ZYUdBZp8G9BGvecy+fazK/Vvt03pKjVZlIFo4RHhGLs0+kT4u2p0Of/HX9K1PSQGSr9/Z6os8bib0np6eI+hGQh3mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61wi2S64Nc5pqSw30cNEQnlpD4IHkXqto7aAFb10egk=;
 b=lAx1BmoTiQbTWRI0lW38J7EzLMUaccecjikvHHqdXZKmH+MGiIdyV73NbTBkH25K/BJalNMmweRassGoXEidb11oBzL2QN2q0a8vuAEkLbUIDewP8Xs9mUt33jiLWn3PrkvtO7DE80nQ1cvauo58i6DszKlR4jdO8Lh4h+w0IpTfv+LBBsC7SFc8PvuE8jyn7fbmUR2k1GdLjDt93FmKjZEIgWsKTJJamVW5uHXYZPWMcyn+u2bEnxy1ThwM5670iKS8VTA+Tcms+vW4LYs1uBwuUKaLDtq00f2ILRmQFA4DQYcudiobUK9+dfcJDGAsaNGXEb3Q09F4O4ieKwxd/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61wi2S64Nc5pqSw30cNEQnlpD4IHkXqto7aAFb10egk=;
 b=qhS5VKcWIjBYktUf0e4ZiGKdNs95q/URFlHKAd6udlGhe5fF4t8k5SwmHwbA8hD2d2jT6iPksqA6MNfZqr2QKVfdsGg0LbiYJ+6VtGCcxGLt2INEIIfPMxP9PUM74Jcbir6mhe3Wufg2oQwEEjhX0Ce0YCWmuGw6Eou7g5+HJPE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4722.namprd12.prod.outlook.com (2603:10b6:208:8c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Wed, 24 Feb
 2021 22:22:39 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:39 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 153/159] drm/amdgpu: refine ras codes for GC utc of aldebaran
Date: Wed, 24 Feb 2021 17:18:53 -0500
Message-Id: <20210224221859.3068810-146-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:21:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 999d1dc1-aab9-41ca-b637-08d8d9127a0e
X-MS-TrafficTypeDiagnostic: BL0PR12MB4722:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4722669C2E79178A953B104EF79F9@BL0PR12MB4722.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:211;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RxMrX07HqlQ2cMjCXgbRQuCjbELbOmVb96F+2wZTeF0O2QJptuzs1MyKBgk/63pEnTLItzWahUVdF4ruo/rxcgrS8zev+SuS7qs+PmjA4LwULu/4FLKWfGSXD1nVGrA9IR4vSoRlGfyixF++EZiL6LEqFpTgkZj+fysT7a0WNWhJ9gM4ZyXqFoEmihi3rz62hJJdP5mbgitrEZaTbIyrpzgo+Yhlzopu4U1Zo6j3EWOiunMCvz+B60C/E/cK5ueZN8VcSrh/a71v4F6dPOXeDl88PUcwv/uIw31faX7Fcpz8APegMysCtSuVvIqTpDYMcmo4Mpw+kFqOmT8VHcEx9PbHAgwE06aHwVLv+z22EkIZy0kvnUjUL05KnP5JRTqi1bseF0JW7S69zkFQtKLgWodsSRmQRNqIC/sl0S3k2fJoLEBbSD+rDazbYIhoxMofQnfU7m0aGYhYaPe49HiI1LAMwGrsO8oRv3ssx4JAbC8soBbBI2EcSpjGbAlwqDPCneBg7S4R119P77feMiAEK9BlZwqxXfgSigYn3vOyw0z/IjXlikYiVR5KQiVE8larQSF+qEmtb+JB7Jkjt4WbGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(8676002)(69590400012)(6916009)(4326008)(6506007)(8936002)(478600001)(66476007)(54906003)(6486002)(2906002)(6512007)(86362001)(52116002)(956004)(5660300002)(83380400001)(316002)(16526019)(1076003)(2616005)(36756003)(186003)(66946007)(66556008)(66574015)(26005)(30864003)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7MBH3eZub3s+Xe/zK46cIRO2UWgSjyS9p3rn8wZ0IWcF0++0TxinYYhIxBe7?=
 =?us-ascii?Q?WmTb68FtqKnIxtAVPMVucTuyq4Bo5XYwv6AoJv4RGqdMUySHDZfgcXZdxAnm?=
 =?us-ascii?Q?6OHNl5cso81ANPcWrcEyISsa6GL8y3gt5ky7H5a/48PiwvrVxztm7yh2PwGf?=
 =?us-ascii?Q?rTX5wEJcnrXcGZSzuRnT+GbokgcV7Y1ykABEPrDYMs9oQAXF+q1HPDvdJRc0?=
 =?us-ascii?Q?/FkNa8btWhYSh0yWPrp6BHDNX/mlEGJ7855t/MWGBMUFu9zWlbhOhmVA4b48?=
 =?us-ascii?Q?Jc6T7vNySjDgksbUKibByMS5BxqukMactJnlAjNnRfaGDaTid7z3ILob+coa?=
 =?us-ascii?Q?pojHTcBkAQoNJHuO9TbKm4//VtPPLGz8mxYvotvTHO1mV/owQotilXkAv7zR?=
 =?us-ascii?Q?3igLRpIpgpoZ7wM+kLbRAg6+sf/252/gdyl/cQD2zoC44NCqdIZQo1Zn46c0?=
 =?us-ascii?Q?w2+S+zzpLr8w69E85hqCgVzAmgVCI0nHPpRGjhvjKgbqIvdiUPd0xWPkMHp+?=
 =?us-ascii?Q?1fg4YXW39/MBqTfCMy/uqT+u+/7YyidvJEiQJ4Uf1qYth8e5Vxq223rl0Cij?=
 =?us-ascii?Q?gFvRbSj8u/jfZJ9R1kSp1l/GFiO+00qz3gGs9M+A6FP6qyZNZTzaZlegyJqD?=
 =?us-ascii?Q?pDrPXnYiNwUFY8GmOuk4okqaiKLBFJOwSoTCGzo+u3ZossTDp3RIEU1Q+2ww?=
 =?us-ascii?Q?aRfH+bRPupksirrk/nHUMM03wglOU5wbqrdBoyDdq6Jdfx76/3viOztvy+9e?=
 =?us-ascii?Q?BIYochtjiDp1TSFt7mH6w+MVgN0+MfriwhXYcZbWzSepCrkiLUckEv/Iibtv?=
 =?us-ascii?Q?etItI7Mbq8kALPm2Dz/FO+0X2r4+7qiq/IShFiPsVsdroMlIn+DqRGPW48u0?=
 =?us-ascii?Q?PV1MvX0jXKiRZfvSQ52J5RMI46aVm9pHKHQIu/me7TRWXilnfM8xBbwCg0Ux?=
 =?us-ascii?Q?9ESv9PsNCB0qc3InL4UYQKKf7RFXOG9j+g1rtE5GfQjArDVsdq3bwGwzxqrv?=
 =?us-ascii?Q?D6c7B50iU+o937jr5+J5/XpvDtGVPGcJeL8es4ppqgQ4OZdkKz8Bug66GkWE?=
 =?us-ascii?Q?g3QO9lCow9KjEgoyu5SWH/5ELOpIUnsgjJpLzFgiLKXtSSSyLaVroCtS9dRY?=
 =?us-ascii?Q?ogy81SR7ouKITru/beqUiuHqXB7fNN3B6j2M4foQdIM2v0nQPLDYsRwAuNuX?=
 =?us-ascii?Q?9brxA81U2e836RcbfHT2g7KpTOTFwDVvu8krPwtPOvhRjmLFTtflv8OR1ef5?=
 =?us-ascii?Q?8h2fN8cHIo+pBHFQ1SY15miVYBpFhehhX8+MH6zJPeZX7jWubm0QKXb04KSG?=
 =?us-ascii?Q?hL8WhU5P2lpN4LN7zXK+QqL9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 999d1dc1-aab9-41ca-b637-08d8d9127a0e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:21:05.5110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4SkDOJcG0oAR40w7dROU/nIyDNrL9evRa/YbkVSqrQiYT8z1u8hITvAD/5PppmEGlZfDTBCPcff6mEpIkl+tTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4722
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dennis Li <Dennis.Li@amd.com>

The bank number of both VML2 and ATCL2 are changed to 8, so refine
related codes to avoid defining long name arrays.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 269 +++++++++---------------
 drivers/gpu/drm/amd/amdgpu/soc15.h      |   2 +-
 2 files changed, 97 insertions(+), 174 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 1cf4f4999112..b2e2026c3ec7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -40,8 +40,11 @@ enum gfx_v9_4_2_utc_type {
 	ATC_L2_CACHE_4K
 };
 
-struct gfx_v9_4_2_utc_reg {
+struct gfx_v9_4_2_utc_block {
 	enum gfx_v9_4_2_utc_type type;
+	uint32_t num_banks;
+	uint32_t num_ways;
+	uint32_t num_mem_blocks;
 	struct soc15_reg idx_reg;
 	struct soc15_reg data_reg;
 	uint32_t sec_count_mask;
@@ -51,12 +54,6 @@ struct gfx_v9_4_2_utc_reg {
 	uint32_t clear;
 };
 
-struct gfx_v9_4_2_utc_info_map {
-	enum gfx_v9_4_2_utc_type type;
-	const char *name;
-	uint32_t index;
-};
-
 static const struct soc15_reg_golden golden_settings_gc_9_4_2_alde_die_0[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_0, 0x3fffffff, 0x141dc920),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CHAN_STEER_1, 0x3fffffff, 0x3b458b93),
@@ -756,38 +753,51 @@ static const struct soc15_ras_field_entry gfx_v9_4_2_ras_fields[] = {
 	  SOC15_REG_FIELD(GCEA_EDC_CNT3, MAM_AFMEM_DED_COUNT) },
 };
 
-static struct gfx_v9_4_2_utc_reg gfx_v9_4_2_utc_regs[] = {
-	{ VML2_MEM,
+static const char * const vml2_walker_mems[] = {
+	"UTC_VML2_CACHE_PDE0_MEM0",
+	"UTC_VML2_CACHE_PDE0_MEM1",
+	"UTC_VML2_CACHE_PDE1_MEM0",
+	"UTC_VML2_CACHE_PDE1_MEM1",
+	"UTC_VML2_CACHE_PDE2_MEM0",
+	"UTC_VML2_CACHE_PDE2_MEM1",
+	"UTC_VML2_RDIF_ARADDRS",
+	"UTC_VML2_RDIF_LOG_FIFO",
+	"UTC_VML2_QUEUE_REQ",
+	"UTC_VML2_QUEUE_RET",
+};
+
+static struct gfx_v9_4_2_utc_block gfx_v9_4_2_utc_blocks[] = {
+	{ VML2_MEM, 8, 2, 2,
 	  { SOC15_REG_ENTRY(GC, 0, regVML2_MEM_ECC_INDEX) },
 	  { SOC15_REG_ENTRY(GC, 0, regVML2_MEM_ECC_CNTL) },
 	  SOC15_REG_FIELD(VML2_MEM_ECC_CNTL, SEC_COUNT),
 	  SOC15_REG_FIELD(VML2_MEM_ECC_CNTL, DED_COUNT),
 	  REG_SET_FIELD(0, VML2_MEM_ECC_CNTL, WRITE_COUNTERS, 1) },
-	{ VML2_WALKER_MEM,
+	{ VML2_WALKER_MEM, ARRAY_SIZE(vml2_walker_mems), 1, 1,
 	  { SOC15_REG_ENTRY(GC, 0, regVML2_WALKER_MEM_ECC_INDEX) },
 	  { SOC15_REG_ENTRY(GC, 0, regVML2_WALKER_MEM_ECC_CNTL) },
 	  SOC15_REG_FIELD(VML2_WALKER_MEM_ECC_CNTL, SEC_COUNT),
 	  SOC15_REG_FIELD(VML2_WALKER_MEM_ECC_CNTL, DED_COUNT),
 	  REG_SET_FIELD(0, VML2_WALKER_MEM_ECC_CNTL, WRITE_COUNTERS, 1) },
-	{ UTCL2_MEM,
+	{ UTCL2_MEM, 18, 1, 2,
 	  { SOC15_REG_ENTRY(GC, 0, regUTCL2_MEM_ECC_INDEX) },
 	  { SOC15_REG_ENTRY(GC, 0, regUTCL2_MEM_ECC_CNTL) },
 	  SOC15_REG_FIELD(UTCL2_MEM_ECC_CNTL, SEC_COUNT),
 	  SOC15_REG_FIELD(UTCL2_MEM_ECC_CNTL, DED_COUNT),
 	  REG_SET_FIELD(0, UTCL2_MEM_ECC_CNTL, WRITE_COUNTERS, 1) },
-	{ ATC_L2_CACHE_2M,
+	{ ATC_L2_CACHE_2M, 8, 2, 1,
 	  { SOC15_REG_ENTRY(GC, 0, regATC_L2_CACHE_2M_DSM_INDEX) },
 	  { SOC15_REG_ENTRY(GC, 0, regATC_L2_CACHE_2M_DSM_CNTL) },
 	  SOC15_REG_FIELD(ATC_L2_CACHE_2M_DSM_CNTL, SEC_COUNT),
 	  SOC15_REG_FIELD(ATC_L2_CACHE_2M_DSM_CNTL, DED_COUNT),
 	  REG_SET_FIELD(0, ATC_L2_CACHE_2M_DSM_CNTL, WRITE_COUNTERS, 1) },
-	{ ATC_L2_CACHE_32K,
+	{ ATC_L2_CACHE_32K, 8, 2, 2,
 	  { SOC15_REG_ENTRY(GC, 0, regATC_L2_CACHE_32K_DSM_INDEX) },
 	  { SOC15_REG_ENTRY(GC, 0, regATC_L2_CACHE_32K_DSM_CNTL) },
 	  SOC15_REG_FIELD(ATC_L2_CACHE_32K_DSM_CNTL, SEC_COUNT),
 	  SOC15_REG_FIELD(ATC_L2_CACHE_32K_DSM_CNTL, DED_COUNT),
 	  REG_SET_FIELD(0, ATC_L2_CACHE_32K_DSM_CNTL, WRITE_COUNTERS, 1) },
-	{ ATC_L2_CACHE_4K,
+	{ ATC_L2_CACHE_4K, 8, 2, 8,
 	  { SOC15_REG_ENTRY(GC, 0, regATC_L2_CACHE_4K_DSM_INDEX) },
 	  { SOC15_REG_ENTRY(GC, 0, regATC_L2_CACHE_4K_DSM_CNTL) },
 	  SOC15_REG_FIELD(ATC_L2_CACHE_4K_DSM_CNTL, SEC_COUNT),
@@ -795,132 +805,6 @@ static struct gfx_v9_4_2_utc_reg gfx_v9_4_2_utc_regs[] = {
 	  REG_SET_FIELD(0, ATC_L2_CACHE_4K_DSM_CNTL, WRITE_COUNTERS, 1) },
 };
 
-static const struct gfx_v9_4_2_utc_info_map gfx_v9_4_2_utc_map[] = {
-	/* GPU VM */
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_0_BIGK_MEM0", 0 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_0_BIGK_MEM1", 1 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_0_4K_MEM0", 2 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_0_4K_MEM1", 3 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_1_BIGK_MEM0", 4 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_1_BIGK_MEM1", 5 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_1_4K_MEM0", 6 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_1_4K_MEM1", 7 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_2_BIGK_MEM0", 8 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_2_BIGK_MEM1", 9 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_2_4K_MEM0", 10 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_2_4K_MEM1", 11 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_3_BIGK_MEM0", 12 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_3_BIGK_MEM1", 13 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_3_4K_MEM0", 14 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_3_4K_MEM1", 15 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_4_BIGK_MEM0", 16 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_4_BIGK_MEM1", 17 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_4_4K_MEM0", 18 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_4_4K_MEM1", 19 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_5_BIGK_MEM0", 20 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_5_BIGK_MEM1", 21 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_5_4K_MEM0", 22 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_5_4K_MEM1", 23 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_6_BIGK_MEM0", 24 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_6_BIGK_MEM1", 25 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_6_4K_MEM0", 26 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_6_4K_MEM1", 27 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_7_BIGK_MEM0", 28 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_7_BIGK_MEM1", 29 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_7_4K_MEM0", 30 },
-	{ VML2_MEM, "UTC_VML2_BANK_CACHE_7_4K_MEM1", 31 },
-
-	/* WALER */
-	{ VML2_WALKER_MEM, "UTC_VML2_CACHE_PDE0_MEM0", 0 },
-	{ VML2_WALKER_MEM, "UTC_VML2_CACHE_PDE0_MEM1", 1 },
-	{ VML2_WALKER_MEM, "UTC_VML2_CACHE_PDE1_MEM0", 2 },
-	{ VML2_WALKER_MEM, "UTC_VML2_CACHE_PDE1_MEM1", 3 },
-	{ VML2_WALKER_MEM, "UTC_VML2_CACHE_PDE2_MEM0", 4 },
-	{ VML2_WALKER_MEM, "UTC_VML2_CACHE_PDE2_MEM1", 5 },
-	{ VML2_WALKER_MEM, "UTC_VML2_RDIF_ARADDRS", 6 },
-	{ VML2_WALKER_MEM, "UTC_VML2_RDIF_LOG_FIFO", 7 },
-	{ VML2_WALKER_MEM, "UTC_VML2_QUEUE_REQ", 8 },
-	{ VML2_WALKER_MEM, "UTC_VML2_QUEUE_RET", 9 },
-
-	/* SRAM_BLOCK_ROUTER */
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP0_VMC", 0 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP0_APT", 1 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP1_VMC", 2 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP1_APT", 3 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP2_VMC", 4 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP2_APT", 5 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP3_VMC", 6 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP3_APT", 7 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP4_VMC", 8 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP4_APT", 9 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP5_VMC", 10 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP5_APT", 11 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP6_VMC", 12 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP6_APT", 13 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP7_VMC", 14 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP7_APT", 15 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP8_VMC", 16 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP8_APT", 17 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP9_VMC", 18 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP9_APT", 19 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP10_VMC", 20 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP10_APT", 21 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP11_VMC", 22 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP11_APT", 23 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP12_VMC", 24 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP12_APT", 25 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP13_VMC", 26 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP13_APT", 27 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP14_VMC", 28 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP14_APT", 29 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP15_VMC", 30 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP15_APT", 31 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP16_VMC", 32 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP16_APT", 33 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP17_VMC", 34 },
-	{ UTCL2_MEM, "UTCL2_ROUTER_IFIFO_GROUP17_APT", 35 },
-
-	/* ATCL2-2m */
-	{ ATC_L2_CACHE_2M, "UTC_ATCL2_CACHE_2M_BANK0_WAY0_MEM", 0 },
-	{ ATC_L2_CACHE_2M, "UTC_ATCL2_CACHE_2M_BANK0_WAY1_MEM", 1 },
-	{ ATC_L2_CACHE_2M, "UTC_ATCL2_CACHE_2M_BANK1_WAY0_MEM", 2 },
-	{ ATC_L2_CACHE_2M, "UTC_ATCL2_CACHE_2M_BANK1_WAY1_MEM", 3 },
-
-	/* ATCL2-4k */
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK0_WAY0_MEM0", 0 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK0_WAY0_MEM1", 1 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK0_WAY0_MEM2", 2 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK0_WAY0_MEM3", 3 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK0_WAY0_MEM4", 4 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK0_WAY0_MEM5", 5 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK0_WAY0_MEM6", 6 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK0_WAY0_MEM7", 7 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK0_WAY1_MEM0", 8 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK0_WAY1_MEM1", 9 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK0_WAY1_MEM2", 10 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK0_WAY1_MEM3", 11 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK0_WAY1_MEM4", 12 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK0_WAY1_MEM5", 13 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK0_WAY1_MEM6", 14 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK0_WAY1_MEM7", 15 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK1_WAY0_MEM0", 16 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK1_WAY0_MEM1", 17 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK1_WAY0_MEM2", 18 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK1_WAY0_MEM3", 19 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK1_WAY0_MEM4", 20 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK1_WAY0_MEM5", 21 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK1_WAY0_MEM6", 22 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK1_WAY0_MEM7", 23 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK1_WAY1_MEM0", 24 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK1_WAY1_MEM1", 25 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK1_WAY1_MEM2", 26 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK1_WAY1_MEM3", 27 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK1_WAY1_MEM4", 28 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK1_WAY1_MEM5", 29 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK1_WAY1_MEM6", 30 },
-	{ ATC_L2_CACHE_4K, "UTC_ATCL2_CACHE_4K_BANK1_WAY1_MEM7", 31 },
-};
-
 static const struct soc15_reg_entry gfx_v9_4_2_rdrsp_status_regs =
 	{ SOC15_REG_ENTRY(GC, 0, regGCEA_ERR_STATUS), 0, 1, 16 };
 
@@ -1017,62 +901,101 @@ static int gfx_v9_4_2_query_sram_edc_count(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void gfx_v9_4_2_log_utc_edc_count(struct amdgpu_device *adev,
+					 struct gfx_v9_4_2_utc_block *blk,
+					 uint32_t instance, uint32_t sec_cnt,
+					 uint32_t ded_cnt)
+{
+	uint32_t bank, way, mem;
+	static const char *vml2_way_str[] = { "BIGK", "4K" };
+	static const char *utcl2_rounter_str[] = { "VMC", "APT" };
+
+	mem = instance % blk->num_mem_blocks;
+	way = (instance / blk->num_mem_blocks) % blk->num_ways;
+	bank = instance / (blk->num_mem_blocks * blk->num_ways);
+
+	switch (blk->type) {
+	case VML2_MEM:
+		dev_info(
+			adev->dev,
+			"GFX SubBlock UTC_VML2_BANK_CACHE_%d_%s_MEM%d, SED %d, DED %d\n",
+			bank, vml2_way_str[way], mem, sec_cnt, ded_cnt);
+		break;
+	case VML2_WALKER_MEM:
+		dev_info(adev->dev, "GFX SubBlock %s, SED %d, DED %d\n",
+			 vml2_walker_mems[bank], sec_cnt, ded_cnt);
+		break;
+	case UTCL2_MEM:
+		dev_info(
+			adev->dev,
+			"GFX SubBlock UTCL2_ROUTER_IFIF%d_GROUP0_%s, SED %d, DED %d\n",
+			bank, utcl2_rounter_str[mem], sec_cnt, ded_cnt);
+		break;
+	case ATC_L2_CACHE_2M:
+		dev_info(
+			adev->dev,
+			"GFX SubBlock UTC_ATCL2_CACHE_2M_BANK%d_WAY%d_MEM, SED %d, DED %d\n",
+			bank, way, sec_cnt, ded_cnt);
+		break;
+	case ATC_L2_CACHE_32K:
+		dev_info(
+			adev->dev,
+			"GFX SubBlock UTC_ATCL2_CACHE_32K_BANK%d_WAY%d_MEM%d, SED %d, DED %d\n",
+			bank, way, mem, sec_cnt, ded_cnt);
+		break;
+	case ATC_L2_CACHE_4K:
+		dev_info(
+			adev->dev,
+			"GFX SubBlock UTC_ATCL2_CACHE_4K_BANK%d_WAY%d_MEM%d, SED %d, DED %d\n",
+			bank, way, mem, sec_cnt, ded_cnt);
+		break;
+	}
+}
+
 static int gfx_v9_4_2_query_utc_edc_count(struct amdgpu_device *adev,
 					  uint32_t *sec_count,
 					  uint32_t *ded_count)
 {
 	uint32_t i, j, data;
 	uint32_t sec_cnt, ded_cnt;
+	uint32_t num_instances;
+	struct gfx_v9_4_2_utc_block *blk;
 
 	if (sec_count && ded_count) {
 		*sec_count = 0;
 		*ded_count = 0;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(gfx_v9_4_2_utc_regs); i++) {
-		for (j = 0; j < ARRAY_SIZE(gfx_v9_4_2_utc_map); j++) {
-			if (gfx_v9_4_2_utc_regs[i].type !=
-			    gfx_v9_4_2_utc_map[j].type)
-				continue;
-
-			WREG32(SOC15_REG_ENTRY_OFFSET(
-				       gfx_v9_4_2_utc_regs[i].idx_reg),
-			       gfx_v9_4_2_utc_map[j].index);
+	for (i = 0; i < ARRAY_SIZE(gfx_v9_4_2_utc_blocks); i++) {
+		blk = &gfx_v9_4_2_utc_blocks[i];
+		num_instances =
+			blk->num_banks * blk->num_ways * blk->num_mem_blocks;
+		for (j = 0; j < num_instances; j++) {
+			WREG32(SOC15_REG_ENTRY_OFFSET(blk->idx_reg), j);
 
 			/* if sec/ded_count is NULL, just clear counter */
 			if (!sec_count || !ded_count) {
-				WREG32(SOC15_REG_ENTRY_OFFSET(
-					       gfx_v9_4_2_utc_regs[i].data_reg),
-				       gfx_v9_4_2_utc_regs[i].clear);
+				WREG32(SOC15_REG_ENTRY_OFFSET(blk->data_reg),
+				       blk->clear);
 				continue;
 			}
 
-			data = RREG32(SOC15_REG_ENTRY_OFFSET(
-				gfx_v9_4_2_utc_regs[i].data_reg));
-
+			data = RREG32(SOC15_REG_ENTRY_OFFSET(blk->data_reg));
 			if (!data)
 				continue;
 
-			sec_cnt = SOC15_RAS_REG_FIELD_VAL(
-				data, gfx_v9_4_2_utc_regs[i], sec);
-			if (sec_cnt) {
-				dev_info(adev->dev, "GFX SubBlock %s, SEC %d\n",
-					 gfx_v9_4_2_utc_map[j].name, sec_cnt);
-				*sec_count += sec_cnt;
-			}
-
-			ded_cnt = SOC15_RAS_REG_FIELD_VAL(
-				data, gfx_v9_4_2_utc_regs[i], ded);
-			if (ded_cnt) {
-				dev_info(adev->dev, "GFX SubBlock %s, DED %d\n",
-					 gfx_v9_4_2_utc_map[j].name, ded_cnt);
-				*ded_count += ded_cnt;
-			}
+			sec_cnt = SOC15_RAS_REG_FIELD_VAL(data, *blk, sec);
+			*sec_count += sec_cnt;
+			ded_cnt = SOC15_RAS_REG_FIELD_VAL(data, *blk, ded);
+			*ded_count += ded_cnt;
 
 			/* clear counter after read */
-			WREG32(SOC15_REG_ENTRY_OFFSET(
-				       gfx_v9_4_2_utc_regs[i].data_reg),
-			       gfx_v9_4_2_utc_regs[i].clear);
+			WREG32(SOC15_REG_ENTRY_OFFSET(blk->data_reg),
+			       blk->clear);
+
+			/* print the edc count */
+			gfx_v9_4_2_log_utc_edc_count(adev, blk, j, sec_cnt,
+						     ded_cnt);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
index ea0469e45b9f..034cfdfc4dbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -97,7 +97,7 @@ struct soc15_ras_field_entry {
 
 #define SOC15_REG_FIELD_VAL(val, mask, shift)	(((val) & mask) >> shift)
 
-#define SOC15_RAS_REG_FIELD_VAL(val, entry, field) SOC15_REG_FIELD_VAL(val, entry.field##_count_mask, entry.field##_count_shift)
+#define SOC15_RAS_REG_FIELD_VAL(val, entry, field) SOC15_REG_FIELD_VAL((val), (entry).field##_count_mask, (entry).field##_count_shift)
 
 void soc15_grbm_select(struct amdgpu_device *adev,
 		    u32 me, u32 pipe, u32 queue, u32 vmid);
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
