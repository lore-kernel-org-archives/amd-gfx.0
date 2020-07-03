Return-Path: <SRS0=khk6=AO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E364AC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B71D020826
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CJxqeXme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71D020826
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70A556E1D3;
	Fri,  3 Jul 2020 08:33:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D9056E1D3
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 08:33:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnF1ZEWZx3hSlUYhcq/TStj7SZYcOUC8Toh0bosZ1n3uci19Hx+hgN/AYm0P6j14XfdeRj1wFQG3flmgwiiv7jeRIoZTdqQN/z07nn4FoNQjKOsuF643kh5KeNq44prM/JaUlxoRGm52fwGhFjG5VxWqndAfhgaGzvKNX5nvXBWotU5ee3UkTNZ9ah6M1m7Q7D+pysAxFdWCiODUoVjZ0wkOGkboOtN8zEdrtP6rJ7Sn3ytvrcqZvfdAqPr1ubMTcvwOde/OFykXnbGzLkIAnkQkNlBoVfE+ZZMHwGe2k4BrlYzg5a77ldqNCPPfpU9VQMGY+Yp8wtYxpszdTRr3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1q0mQkTqqmQ02leMDII5yCRA0zqqBbPpSoo+ZFqivU=;
 b=LGf472LmpJLgFHcUNAOLefb8+076NpLbVS4y51ovVx7KnqUQ2oEXo8w1ENHqvJyLAZzJwzpWcImVNmxzkACpYv4w9/tqFp/RcAJNc6AduiogzJih+epRd5QM3XrOHUS5DBuyR7wnqjxzfEqrEPjUJheWkg/TKw/Fjj96VF+BIY+7R2gNnP0FEjCZMviCZEltQYDf8WRS4eHg7x/AXQp76PWVMYzvx2H1MqqSgl3Anj8pdYdZHKteULFSRGqEsZc6sGPJAbkl29cUOU4eMe/P8Us3+TZCWQobBmbAKYWBDy+3fi5Ug3xudbEJTXUKUlrNmCgr0JT0TzimZNdd/GLRRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1q0mQkTqqmQ02leMDII5yCRA0zqqBbPpSoo+ZFqivU=;
 b=CJxqeXmeX3BuHGBpGFnSwdmnoW6HnblCj6spHWutnw4Q/00Um2dJCLBgKmvjSHqsdCPlBUMK8AprIieI7ArUDuA/quLjTvVk9AbggwWyoICeB74fY7YSSF/UZgh3jgM5TtBDiY/TVEna8wVltL834Rtjgsj+lp65yZNJan/1JnU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.27; Fri, 3 Jul 2020 08:33:42 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 08:33:42 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/14] drm/amd/powerplay: update Sienna Cichlid default dpm
 table setup
Date: Fri,  3 Jul 2020 16:32:53 +0800
Message-Id: <20200703083303.478-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200703083303.478-1-evan.quan@amd.com>
References: <20200703083303.478-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0139.apcprd02.prod.outlook.com
 (2603:1096:202:16::23) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0139.apcprd02.prod.outlook.com (2603:1096:202:16::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.22 via Frontend Transport; Fri, 3 Jul 2020 08:33:40 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 775b50d3-1edc-4f70-d0ea-08d81f2bcac5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3962D468605FFAE9BE985373E46A0@DM6PR12MB3962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aYh+ONhos5XWSAWrtpXmQNsPDuk3RnIotx5ZOPnb//iURRKFZJsJfRiVJ1nPfKGzAEY5woeAuhOd3EgKeh0cKqWinInv8Ilg3Y7xCEGObuVtvJHMXfb8sKXlA6A5XfYl7uWJUKMmK948vHFVQvJsAoYYHMF2jvyJj4ZAwf5MMW7WsFEKhw6YbryGUFb1qvqMsRuTA5q6ofIlSqIrq8OxixJMqyYP8tsspsadBpAINSiAEXIrUmNVRZESQU2Rgnj5hGeoftgA/DB++u5LFvfOT+cf5/TmQjVex/r7dVpZoEfoLNFjU85CsSnWVQ+GKXuD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(83380400001)(44832011)(4326008)(36756003)(8936002)(7696005)(956004)(2616005)(6486002)(52116002)(478600001)(6666004)(66946007)(16526019)(26005)(186003)(66476007)(30864003)(5660300002)(1076003)(66556008)(8676002)(316002)(86362001)(6916009)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 8emWPgrh76cjk9YELDSDhc5izb+q7Hg5C9flN13i86FbT/S5tWuoo34iwEYk30vBAxJd/gbu5cneHG9ndfl0BkhSJHxWwVW7BBKZk4yPWAmcQzDLiAaVX3Pl7xXSrXzFXvr4wcULz+Qq1+aO2Wg3Nnsf7K5RSL1EGmXTTNWSP8Cl3R7JRpTtw5OfLOUNv46b8xoCLKK4DyL6ynDj9itzEQ5Z4h6U5oGMY13cmExj0Q3gIvgHMUDUrU7ljUHgk0UcGu5p2l/qDNgsIDSNTdsz/erEyhnTVOJ6UlQWLLUnBSOKBE0MWyjZoYmqtB5sNCZYpV4TbcpoRPUdV5bWNXKeOEYN1Jaz8IdYSA5CHU3azFUag5Sk9Epwfo+Y/zDpLKlPSll3DFjyHeLqTBMPxW+8ZEtG2lq6dRgOIxBQTRQBCQC6PDUnQ1GQH19+wApgRO1bY3kHZrqwgNPp0mC7PYukq9oJuSJ2wZE5Ds+yxdazhPvufQJtImUCDykq6JCYx8lE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 775b50d3-1edc-4f70-d0ea-08d81f2bcac5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:33:42.2289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2VviM2BO4pi/BzuXXU/V7LzUEPFl2ht/LNLjbg0+pZ3JoegjOrSaKIw1RcViG8y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3962
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Cache all clocks levels for every dpm table. They are needed
by other APIs.

Change-Id: Idaa853356720e48ab3279f420ba1ae18bb7de4fd
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 234 ++++++++++++++++--
 1 file changed, 211 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index f2bbe56798d7..d750d06378e9 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -597,41 +597,229 @@ static int sienna_cichlid_allocate_dpm_context(struct smu_context *smu)
 
 static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 {
-	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
-	struct smu_table_context *table_context = &smu->smu_table;
-	struct smu_11_0_dpm_context *dpm_context = smu_dpm->dpm_context;
-	PPTable_t *driver_ppt = NULL;
+	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+	PPTable_t *driver_ppt = smu->smu_table.driver_pptable;
+	struct smu_11_0_dpm_table *dpm_table;
+	int ret = 0;
 	int i;
 
-        driver_ppt = table_context->driver_pptable;
+	/* socclk dpm table setup */
+	dpm_table = &dpm_context->dpm_tables.soc_table;
+	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
+		ret = smu_v11_0_set_single_dpm_table(smu,
+						     SMU_SOCCLK,
+						     dpm_table);
+		if (ret)
+			return ret;
+		dpm_table->is_fine_grained =
+			!driver_ppt->DpmDescriptor[PPCLK_SOCCLK].SnapToDiscrete;
+	} else {
+		dpm_table->count = 1;
+		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.socclk / 100;
+		dpm_table->dpm_levels[0].enabled = true;
+		dpm_table->min = dpm_table->dpm_levels[0].value;
+		dpm_table->max = dpm_table->dpm_levels[0].value;
+	}
+
+	/* gfxclk dpm table setup */
+	dpm_table = &dpm_context->dpm_tables.gfx_table;
+	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT)) {
+		ret = smu_v11_0_set_single_dpm_table(smu,
+						     SMU_GFXCLK,
+						     dpm_table);
+		if (ret)
+			return ret;
+		dpm_table->is_fine_grained =
+			!driver_ppt->DpmDescriptor[PPCLK_GFXCLK].SnapToDiscrete;
+	} else {
+		dpm_table->count = 1;
+		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.gfxclk / 100;
+		dpm_table->dpm_levels[0].enabled = true;
+		dpm_table->min = dpm_table->dpm_levels[0].value;
+		dpm_table->max = dpm_table->dpm_levels[0].value;
+	}
+
+	/* uclk dpm table setup */
+	dpm_table = &dpm_context->dpm_tables.uclk_table;
+	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
+		ret = smu_v11_0_set_single_dpm_table(smu,
+						     SMU_UCLK,
+						     dpm_table);
+		if (ret)
+			return ret;
+		dpm_table->is_fine_grained =
+			!driver_ppt->DpmDescriptor[PPCLK_UCLK].SnapToDiscrete;
+	} else {
+		dpm_table->count = 1;
+		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.uclk / 100;
+		dpm_table->dpm_levels[0].enabled = true;
+		dpm_table->min = dpm_table->dpm_levels[0].value;
+		dpm_table->max = dpm_table->dpm_levels[0].value;
+	}
 
-        dpm_context->dpm_tables.soc_table.min = driver_ppt->FreqTableSocclk[0];
-        dpm_context->dpm_tables.soc_table.max = driver_ppt->FreqTableSocclk[NUM_SOCCLK_DPM_LEVELS - 1];
+	/* fclk dpm table setup */
+	dpm_table = &dpm_context->dpm_tables.fclk_table;
+	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_FCLK_BIT)) {
+		ret = smu_v11_0_set_single_dpm_table(smu,
+						     SMU_FCLK,
+						     dpm_table);
+		if (ret)
+			return ret;
+		dpm_table->is_fine_grained =
+			!driver_ppt->DpmDescriptor[PPCLK_FCLK].SnapToDiscrete;
+	} else {
+		dpm_table->count = 1;
+		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.fclk / 100;
+		dpm_table->dpm_levels[0].enabled = true;
+		dpm_table->min = dpm_table->dpm_levels[0].value;
+		dpm_table->max = dpm_table->dpm_levels[0].value;
+	}
 
-        dpm_context->dpm_tables.gfx_table.min = driver_ppt->FreqTableGfx[0];
-        dpm_context->dpm_tables.gfx_table.max = driver_ppt->FreqTableGfx[NUM_GFXCLK_DPM_LEVELS - 1];
+	/* vclk0 dpm table setup */
+	dpm_table = &dpm_context->dpm_tables.vclk_table;
+	if (smu_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+		ret = smu_v11_0_set_single_dpm_table(smu,
+						     SMU_VCLK,
+						     dpm_table);
+		if (ret)
+			return ret;
+		dpm_table->is_fine_grained =
+			!driver_ppt->DpmDescriptor[PPCLK_VCLK_0].SnapToDiscrete;
+	} else {
+		dpm_table->count = 1;
+		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.vclk / 100;
+		dpm_table->dpm_levels[0].enabled = true;
+		dpm_table->min = dpm_table->dpm_levels[0].value;
+		dpm_table->max = dpm_table->dpm_levels[0].value;
+	}
 
-        dpm_context->dpm_tables.uclk_table.min = driver_ppt->FreqTableUclk[0];
-        dpm_context->dpm_tables.uclk_table.max = driver_ppt->FreqTableUclk[NUM_UCLK_DPM_LEVELS - 1];
+	/* vclk1 dpm table setup */
+	dpm_table = &dpm_context->dpm_tables.vclk1_table;
+	if (smu_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+		ret = smu_v11_0_set_single_dpm_table(smu,
+						     SMU_VCLK1,
+						     dpm_table);
+		if (ret)
+			return ret;
+		dpm_table->is_fine_grained =
+			!driver_ppt->DpmDescriptor[PPCLK_VCLK_1].SnapToDiscrete;
+	} else {
+		dpm_table->count = 1;
+		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.vclk / 100;
+		dpm_table->dpm_levels[0].enabled = true;
+		dpm_table->min = dpm_table->dpm_levels[0].value;
+		dpm_table->max = dpm_table->dpm_levels[0].value;
+	}
 
-        dpm_context->dpm_tables.vclk_table.min = driver_ppt->FreqTableVclk[0];
-        dpm_context->dpm_tables.vclk_table.max = driver_ppt->FreqTableVclk[NUM_VCLK_DPM_LEVELS - 1];
+	/* dclk0 dpm table setup */
+	dpm_table = &dpm_context->dpm_tables.dclk_table;
+	if (smu_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+		ret = smu_v11_0_set_single_dpm_table(smu,
+						     SMU_DCLK,
+						     dpm_table);
+		if (ret)
+			return ret;
+		dpm_table->is_fine_grained =
+			!driver_ppt->DpmDescriptor[PPCLK_DCLK_0].SnapToDiscrete;
+	} else {
+		dpm_table->count = 1;
+		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dclk / 100;
+		dpm_table->dpm_levels[0].enabled = true;
+		dpm_table->min = dpm_table->dpm_levels[0].value;
+		dpm_table->max = dpm_table->dpm_levels[0].value;
+	}
 
-        dpm_context->dpm_tables.dclk_table.min = driver_ppt->FreqTableDclk[0];
-        dpm_context->dpm_tables.dclk_table.max = driver_ppt->FreqTableDclk[NUM_DCLK_DPM_LEVELS - 1];
+	/* dclk1 dpm table setup */
+	dpm_table = &dpm_context->dpm_tables.dclk1_table;
+	if (smu_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+		ret = smu_v11_0_set_single_dpm_table(smu,
+						     SMU_DCLK1,
+						     dpm_table);
+		if (ret)
+			return ret;
+		dpm_table->is_fine_grained =
+			!driver_ppt->DpmDescriptor[PPCLK_DCLK_1].SnapToDiscrete;
+	} else {
+		dpm_table->count = 1;
+		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dclk / 100;
+		dpm_table->dpm_levels[0].enabled = true;
+		dpm_table->min = dpm_table->dpm_levels[0].value;
+		dpm_table->max = dpm_table->dpm_levels[0].value;
+	}
 
-        dpm_context->dpm_tables.dcef_table.min = driver_ppt->FreqTableDcefclk[0];
-        dpm_context->dpm_tables.dcef_table.max = driver_ppt->FreqTableDcefclk[NUM_DCEFCLK_DPM_LEVELS - 1];
+	/* dcefclk dpm table setup */
+	dpm_table = &dpm_context->dpm_tables.dcef_table;
+	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
+		ret = smu_v11_0_set_single_dpm_table(smu,
+						     SMU_DCEFCLK,
+						     dpm_table);
+		if (ret)
+			return ret;
+		dpm_table->is_fine_grained =
+			!driver_ppt->DpmDescriptor[PPCLK_DCEFCLK].SnapToDiscrete;
+	} else {
+		dpm_table->count = 1;
+		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dcefclk / 100;
+		dpm_table->dpm_levels[0].enabled = true;
+		dpm_table->min = dpm_table->dpm_levels[0].value;
+		dpm_table->max = dpm_table->dpm_levels[0].value;
+	}
 
-        dpm_context->dpm_tables.pixel_table.min = driver_ppt->FreqTablePixclk[0];
-        dpm_context->dpm_tables.pixel_table.max = driver_ppt->FreqTablePixclk[NUM_PIXCLK_DPM_LEVELS - 1];
+	/* pixelclk dpm table setup */
+	dpm_table = &dpm_context->dpm_tables.pixel_table;
+	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
+		ret = smu_v11_0_set_single_dpm_table(smu,
+						     SMU_PIXCLK,
+						     dpm_table);
+		if (ret)
+			return ret;
+		dpm_table->is_fine_grained =
+			!driver_ppt->DpmDescriptor[PPCLK_PIXCLK].SnapToDiscrete;
+	} else {
+		dpm_table->count = 1;
+		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dcefclk / 100;
+		dpm_table->dpm_levels[0].enabled = true;
+		dpm_table->min = dpm_table->dpm_levels[0].value;
+		dpm_table->max = dpm_table->dpm_levels[0].value;
+	}
 
-        dpm_context->dpm_tables.display_table.min = driver_ppt->FreqTableDispclk[0];
-        dpm_context->dpm_tables.display_table.max = driver_ppt->FreqTableDispclk[NUM_DISPCLK_DPM_LEVELS - 1];
+	/* displayclk dpm table setup */
+	dpm_table = &dpm_context->dpm_tables.display_table;
+	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
+		ret = smu_v11_0_set_single_dpm_table(smu,
+						     SMU_DISPCLK,
+						     dpm_table);
+		if (ret)
+			return ret;
+		dpm_table->is_fine_grained =
+			!driver_ppt->DpmDescriptor[PPCLK_DISPCLK].SnapToDiscrete;
+	} else {
+		dpm_table->count = 1;
+		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dcefclk / 100;
+		dpm_table->dpm_levels[0].enabled = true;
+		dpm_table->min = dpm_table->dpm_levels[0].value;
+		dpm_table->max = dpm_table->dpm_levels[0].value;
+	}
 
-        dpm_context->dpm_tables.phy_table.min = driver_ppt->FreqTablePhyclk[0];
-        dpm_context->dpm_tables.phy_table.max = driver_ppt->FreqTablePhyclk[NUM_PHYCLK_DPM_LEVELS - 1];
+	/* phyclk dpm table setup */
+	dpm_table = &dpm_context->dpm_tables.phy_table;
+	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
+		ret = smu_v11_0_set_single_dpm_table(smu,
+						     SMU_PHYCLK,
+						     dpm_table);
+		if (ret)
+			return ret;
+		dpm_table->is_fine_grained =
+			!driver_ppt->DpmDescriptor[PPCLK_PHYCLK].SnapToDiscrete;
+	} else {
+		dpm_table->count = 1;
+		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dcefclk / 100;
+		dpm_table->dpm_levels[0].enabled = true;
+		dpm_table->min = dpm_table->dpm_levels[0].value;
+		dpm_table->max = dpm_table->dpm_levels[0].value;
+	}
 
+	/* lclk dpm table setup */
 	for (i = 0; i < MAX_PCIE_CONF; i++) {
 		dpm_context->dpm_tables.pcie_table.pcie_gen[i] = driver_ppt->PcieGenSpeed[i];
 		dpm_context->dpm_tables.pcie_table.pcie_lane[i] = driver_ppt->PcieLaneCount[i];
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
