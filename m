Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276D7C4361B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 06:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D01FC233A1
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 06:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01FC233A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FD186E10B;
	Wed,  9 Dec 2020 06:35:56 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680047.outbound.protection.outlook.com [40.107.68.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9F156E10B
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 06:35:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yjgz7OA51w4cVivlOOEi5tyW9D2TFiQMmv6XT6ws2aWn7+iZ74l40artaVEDH0yKE2yscd/THjcqelt1mVXW71rgSWARXjUWEdIrVI+hjA2Dd7e0+RjP7Q/b6x/T4a3XbNhgIke2iQfXtei3tvS9iOOoaEIst/zpwdcGL/3Jo80g9aW4+y9QBqeg1r243rbiCvINw8wI0Y+90lu/F7qhx5OwcHZ65x843CEDJ3VLYWD4vaZ2aOVtNxf04nkrD654poAbrX0Yl2P8k1mhiNf3j2nv5CY2oSadnQACjzrZcoSI+hqAZEoASXXz7x+479LHui5LJPr0gbIVTuVruxHiSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LewQKRP5XJeeEYO50nI+6fCpFUCEV6Swei42BxS5UY=;
 b=hyq3WJLPt55hX4cgls/Uq8ZUhI+C3+tB4Ei4bTjQndKSXA+QQKnmt8PzBDlLOYziCO1ZKjOA8gt7I34PPnr8nDOxNZgk7So8ge10dI9Y94/svbjweJJMx9sIucD1IN7uqojG2sSmeT8x0Kt+s2skEW/j4K6C5PttW9MnLC+/DQtiEr/xdp2N2hejTx2cOlhXfZZQGtxXJDyvR32oi1Opx0xWj6EKKg5AoMjt/uUfZdlBuME+hCLTbn/R25ieEr6uVXsKBwtECuncPFI+EylbQVV2YrW8igvUcdRDHSFQ9qJYHi08NGRdZ+2ysrjucbqiIMs4ZQCXq1obUKkrXjH7TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LewQKRP5XJeeEYO50nI+6fCpFUCEV6Swei42BxS5UY=;
 b=2m5DISAhX3nvl/GYpk0Kq3qu7KZKSCYFR8j5tTRsdee+r+spSBDpojeMM78QgroiMAcNh/FBdKsMVH8YN9D1suOX/5mgRNwvkhNHLGwWw5j8GuQqCOMJsM2VMngYce9D6YeL95e3CwoGvBvV67QPI0xOlU06bSDTBYjhaE/fIjA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB2472.namprd12.prod.outlook.com (2603:10b6:3:e1::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17; Wed, 9 Dec 2020 06:35:53 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3632.021; Wed, 9 Dec 2020
 06:35:53 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: fulfill the sienna cichlid UMD PSTATE profiling
 clocks
Date: Wed,  9 Dec 2020 14:35:27 +0800
Message-Id: <20201209063527.147464-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2P15301CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::19) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2P15301CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.5 via Frontend Transport; Wed, 9 Dec 2020 06:35:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f990abc2-6d39-41ee-6e42-08d89c0cad2f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2472:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB24726E74AF4D49C3F2FEFC3FE4CC0@DM5PR1201MB2472.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H+coSqNRKnNlkqbs+CrWcKD+gTt0aKnl0F6Iw3Omq33klDIpxychzWJIAGUuoCij0PZyj+/xqw4c4JIDMwkOWCF/lhfmHbOxdQFptonBYn4tIH3whepbyKGU2R0MLaydvzUMRVqO0eh/0WhDiq/GGcDiW9O4il8i7brB4E4zYJuJg8zBMV4j0IRlE7WyBUjRnBin9rRIUs4kLScgpYpzrYPK/8wQBFD9cQh8ZtgW/dvLpK5AmkAO6+/YtFnH3Dd8nfYfseuVSW+nv5oO75tH1kcRWmXjt0v2znpHVDQU86y7uPtSr4wsmUcod6838Er7j+KvxRxS0PYHOZoWGY7Guh4EhZ011cWiJGHYfnoxvpcklFHvbXn6mCAS1jlsEtD6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(6666004)(508600001)(956004)(2906002)(66946007)(16526019)(66556008)(2616005)(44832011)(83380400001)(8676002)(86362001)(8936002)(6916009)(4326008)(52116002)(7696005)(5660300002)(186003)(6486002)(1076003)(36756003)(34490700003)(66476007)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ttbECTLi6Q2SgGO2oEL4QfdLL+T1Se6PmOuYVpmNlcACYekUbw9UTITWrC3v?=
 =?us-ascii?Q?XeiXS6+MU/60lOmVEEo9dMgeCtvUUQfFrN3bfAPkyzfI3eo+fjcSCZX0JLWv?=
 =?us-ascii?Q?5/6Ii+TRAKNE1ARziW7D4BcXyPaa47QedF+VvTm4bHN7JNHGYfhav7HdycDu?=
 =?us-ascii?Q?24ndju4F6WZzHb7Lo/TYt/43PukZz+RXfSbO9WIjpzIWf7zEEZ9mlZRJboyK?=
 =?us-ascii?Q?3q5f6oaud8eIktsl0GeJHgHdGUIUci6jWlYt3GvDblpwxRh+jAKwcoc3UN2V?=
 =?us-ascii?Q?VvZV9Ze5NlzZPuRJvXB4BrfhrjnFsj3Fj99r0N9RwEigYeOlGASeLlsNrX3s?=
 =?us-ascii?Q?f0CRZWQrjsFspXitGd0DRhJFuFXiwhKnH1f3DFY+/LeXTm7UbCW4Yx1nE8dL?=
 =?us-ascii?Q?RFs0huCzfdoZq1At9EAQJRpuKMAjGzSpmnUFjUAQ8US2q/RWdJNxA88JUHrk?=
 =?us-ascii?Q?15KumVkCpm91JhaOqdMUgQDdLNGfLr1epVcxLa0fokh4ei4hgZ1btv84qpck?=
 =?us-ascii?Q?/Y/cWrK64/e7J8gHEtf6AhG8FMtkPYAzHpX/R9h+SdBlRiBZ2I9TfMpI40Wv?=
 =?us-ascii?Q?yKxt103qiNZE3mQ0XrjTs5m5Z6SXWNBfOPBUo42h56RgECOBv+AIRPvGadL/?=
 =?us-ascii?Q?nu8futBUckyLyc2i2olfnMmKni5wuV+8408QnoJZckk6+V1t9xhc5/Yj0RdR?=
 =?us-ascii?Q?f0jHkirJB4bNrkwhq7A4GIi1uoT0X0BHbPoqnZqzw4BwcCNHFuXuaHs5iMNJ?=
 =?us-ascii?Q?ynssiRjkWSnPX8LsTp75sP54kMHNUXhoBnfId/2rnvf8jsuu5MniN89Jtum7?=
 =?us-ascii?Q?Nze+p1ODUC9hDEOASDT774G/9aKrijpPcdx06QHQ4aVsFF8163/DFtOwnBuU?=
 =?us-ascii?Q?A6iY6Et/Qf1LbMERJ9oUKN2yL4S2PAVG5NYx5BW7fMxgjRlq3VwUXfpetmoM?=
 =?us-ascii?Q?TTkvTVjqPvHAIhmNc8qYPL1CUdSWRTtHaUA9dLt202jcQzgWXo8J1fYleP1s?=
 =?us-ascii?Q?Ct7E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 06:35:53.0903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: f990abc2-6d39-41ee-6e42-08d89c0cad2f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXpkax9YnvrLx12wEfqLNOgcAlZeN/SqEKC4lPcIC2n94G4WYR0y3RUZzMOJPKzO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2472
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fulfill the UMD PSTATE profiling clocks of sienna cichlid.

Change-Id: Ib9078c73d3fbd786080449255645ae8b9f879092
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 6 ++++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.h | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 74cf027e4a41..3fb70cac72ea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1341,12 +1341,18 @@ static int sienna_cichlid_populate_umd_state_clk(struct smu_context *smu)
 
 	pstate_table->gfxclk_pstate.min = gfx_table->min;
 	pstate_table->gfxclk_pstate.peak = gfx_table->max;
+	if (gfx_table->max >= SIENNA_CICHLID_UMD_PSTATE_PROFILING_GFXCLK)
+		pstate_table->gfxclk_pstate.standard = SIENNA_CICHLID_UMD_PSTATE_PROFILING_GFXCLK;
 
 	pstate_table->uclk_pstate.min = mem_table->min;
 	pstate_table->uclk_pstate.peak = mem_table->max;
+	if (mem_table->max >= SIENNA_CICHLID_UMD_PSTATE_PROFILING_MEMCLK)
+		pstate_table->uclk_pstate.standard = SIENNA_CICHLID_UMD_PSTATE_PROFILING_MEMCLK;
 
 	pstate_table->socclk_pstate.min = soc_table->min;
 	pstate_table->socclk_pstate.peak = soc_table->max;
+	if (soc_table->max >= SIENNA_CICHLID_UMD_PSTATE_PROFILING_SOCCLK)
+		pstate_table->socclk_pstate.standard = SIENNA_CICHLID_UMD_PSTATE_PROFILING_SOCCLK;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.h
index 57e120c440ea..38cd0ece24f6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.h
@@ -29,6 +29,10 @@ typedef enum {
   POWER_SOURCE_COUNT,
 } POWER_SOURCE_e;
 
+#define SIENNA_CICHLID_UMD_PSTATE_PROFILING_GFXCLK    1825
+#define SIENNA_CICHLID_UMD_PSTATE_PROFILING_SOCCLK    960
+#define SIENNA_CICHLID_UMD_PSTATE_PROFILING_MEMCLK    1000
+
 extern void sienna_cichlid_set_ppt_funcs(struct smu_context *smu);
 
 #endif
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
