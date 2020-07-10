Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B965CC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8942920720
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sRgqZt8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8942920720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E6406EB66;
	Fri, 10 Jul 2020 04:48:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9F3F6EB67
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 04:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUXxCI/6biB9MYQax2yognvYgWylpRRSbrWI+wU6pjKl9pKqPL3BPKwMJq3HZiVAeNzZXJ2HDHFoB799qyt7NLLYEwDyBSOSSNdKwATCUQ3jODuySH9X/ZwGzr+Jq0X6QOxrJE+6cu8sEl2zsGMTuECaYhXH33ZY6jTTHMSDLAWK6tOdnuprVpS2nuKihVwngTxCk2nrSI181kLJFW8KqxgX/xtZyINnnsUB1/+sLlngcJhMFBkDgbZZbjR7l9D/BC56gZNfQJ4gBr9QWprjZpfmtSdjgK/sdaTR6rLDJ5ta5eBdfZghKQMtx9VawP1ZvNw7+7ZXOB3epYecSMZ2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfffdCre4PBRRBdTKWehwM6hAEVghycZyeFbrQ3cLYw=;
 b=bZ7DGVEn+bOhjEVSq+5+sLMss+OxpfkmRJKpVJZVSqH6CITvoXQ7n2oSwoIGIJx9iO0pLFreQ46gPvS0BrMGsOZlEfKC1ztnLlWX4PHqNZBKvKekHfdP8RsKFt6Es6lega7Vo7a2vQ2KcMK9WCro3IbKSnVxXeiDe8KueD7ikb/5N2cBxnDO8STBu0k5vGKC41ipfDdMsa+mNtqmuCydoFrh9NQrc8XUOwjlIVXYUciwT/SsDc2chz+2g6nTfudJ+1bGqh6qeHVV4Dyt3NxDuDYdkSo2s/GsVOV5VOVp+tmKIt2SE/0EEzEUiWRqpR4oagxe9Hio/4PEk8K5O2Iu5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfffdCre4PBRRBdTKWehwM6hAEVghycZyeFbrQ3cLYw=;
 b=sRgqZt8vu8Mr4QNt6LbXnexx+3DwgzRbI+oaMqgJtafLvUTriFBCXVxVVjf2VmmeiyTyTERbrgFjiUK29ByVffXn8EgI1P90+RVVTRHTEENrvVypgy3/fNdSM2HqqjKdnbxVu2G47Soe5M778fwa8pwqIeesPbvC1Jrvo3uK8m8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Fri, 10 Jul 2020 04:48:15 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 04:48:15 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/16] drm/amd/powerplay: update Navi10 default dpm table setup
Date: Fri, 10 Jul 2020 12:47:34 +0800
Message-Id: <20200710044746.23538-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710044746.23538-1-evan.quan@amd.com>
References: <20200710044746.23538-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR03CA0059.apcprd03.prod.outlook.com
 (2603:1096:202:17::29) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR03CA0059.apcprd03.prod.outlook.com (2603:1096:202:17::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Fri, 10 Jul 2020 04:48:13 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3a8214d5-6ddc-472f-ba38-08d8248c7512
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2360BBAD328967A8B7094CC3E4650@DM5PR12MB2360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1uxz8VBGhr5EsI7ZkIZFkeCyjYNjBzZ+Hks1fSQPEfqdtDjODcN2h2rezVGXrdm8cBihfyQaWCZTKdroNQdhbxIvCr7cLSvpZfgHTC2BB0Y7xGcLwDMXwwbvXRIPXgBcHWg8rq8woeTOfNMBeO6LgzMNDoueES2+wWZCLQ0mRJqMEVq5TyMVZA2Z5iT77sGQwgdUNRH92ZMEo+YQmN5rvBgRTIrz0Gm1RmJv00nIPp9xXCElASjKskI80Yz2V1UCt3fmIhBtN2ujK0NQW1tYMOz+YjC9VWJltQAwr6Uv9Lo4YYc9UicSMx1V2Rkk59M6eqMV1UrqTTwaAZDKKttqqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(2906002)(4326008)(8676002)(8936002)(83380400001)(6486002)(44832011)(7696005)(52116002)(186003)(16526019)(956004)(2616005)(26005)(6916009)(316002)(478600001)(86362001)(6666004)(5660300002)(66556008)(1076003)(66476007)(36756003)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: r9ZpaOXUVpLOcJEzxXAlFGxlrGQQrTEKLBgAV0lopW9FPNNeQTVfxH/LRr+w5vEy0REqRpr9kvliqg3jrbCtQZ7VP61H1h84MZghd4p6psjv9JSa69P6wSCJnkUDLKbcrUF15P7JDpXc9/82NUMSiSbuEi2sHmTlw3uelh1cmSVmjOo6I8Z02DtPu/taPO2t/PSi4y+2UjqIrHS/3uHoRjpBe14zZ6DcF5I9ktSI/lkTPD4Q8mbA/cn7Ni4NKwkQWQPceShmFnQXzhNRW6nrfsSjt4a655Jb9MUdMlHIgX6o6Hes0V0qY3tX9rHutISkASGkqb5dIaP6iNABMVxEXicXeH1Gc2JSthThVmgS0QieFCIhps5uKx2vUmDKjp94z4b5grl6ymB0ztqU10SPdWEbHeDK1egKtWUgH1SN+yVEA365M2I8giUBOtI3AwTlwK75/crLHIMeNry+52t0RONqPb1ZUCs/lsPGoX384zkaPipBc5/Tn+TSNecm7P5T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8214d5-6ddc-472f-ba38-08d8248c7512
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 04:48:15.3556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7gALrFrokWEQU7LK5/M/VT3/FfRP+eEaPwcek2+SDtkhJl2BoefvgOAgrMMPada
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
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

Change-Id: I8114cf31e6ec8c9af4578d51749eb213befdcc71
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 182 ++++++++++++++++++---
 1 file changed, 158 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index d96e8334b5e2..a022e93a487c 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -689,41 +689,175 @@ static int navi10_allocate_dpm_context(struct smu_context *smu)
 
 static int navi10_set_default_dpm_table(struct smu_context *smu)
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
 
-	driver_ppt = table_context->driver_pptable;
-
-	dpm_context->dpm_tables.soc_table.min = driver_ppt->FreqTableSocclk[0];
-	dpm_context->dpm_tables.soc_table.max = driver_ppt->FreqTableSocclk[NUM_SOCCLK_DPM_LEVELS - 1];
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
 
-	dpm_context->dpm_tables.gfx_table.min = driver_ppt->FreqTableGfx[0];
-	dpm_context->dpm_tables.gfx_table.max = driver_ppt->FreqTableGfx[NUM_GFXCLK_DPM_LEVELS - 1];
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
 
-	dpm_context->dpm_tables.uclk_table.min = driver_ppt->FreqTableUclk[0];
-	dpm_context->dpm_tables.uclk_table.max = driver_ppt->FreqTableUclk[NUM_UCLK_DPM_LEVELS - 1];
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
 
-	dpm_context->dpm_tables.vclk_table.min = driver_ppt->FreqTableVclk[0];
-	dpm_context->dpm_tables.vclk_table.max = driver_ppt->FreqTableVclk[NUM_VCLK_DPM_LEVELS - 1];
+	/* vclk dpm table setup */
+	dpm_table = &dpm_context->dpm_tables.vclk_table;
+	if (smu_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
+		ret = smu_v11_0_set_single_dpm_table(smu,
+						     SMU_VCLK,
+						     dpm_table);
+		if (ret)
+			return ret;
+		dpm_table->is_fine_grained =
+			!driver_ppt->DpmDescriptor[PPCLK_VCLK].SnapToDiscrete;
+	} else {
+		dpm_table->count = 1;
+		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.vclk / 100;
+		dpm_table->dpm_levels[0].enabled = true;
+		dpm_table->min = dpm_table->dpm_levels[0].value;
+		dpm_table->max = dpm_table->dpm_levels[0].value;
+	}
 
-	dpm_context->dpm_tables.dclk_table.min = driver_ppt->FreqTableDclk[0];
-	dpm_context->dpm_tables.dclk_table.max = driver_ppt->FreqTableDclk[NUM_DCLK_DPM_LEVELS - 1];
+	/* dclk dpm table setup */
+	dpm_table = &dpm_context->dpm_tables.dclk_table;
+	if (smu_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
+		ret = smu_v11_0_set_single_dpm_table(smu,
+						     SMU_DCLK,
+						     dpm_table);
+		if (ret)
+			return ret;
+		dpm_table->is_fine_grained =
+			!driver_ppt->DpmDescriptor[PPCLK_DCLK].SnapToDiscrete;
+	} else {
+		dpm_table->count = 1;
+		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dclk / 100;
+		dpm_table->dpm_levels[0].enabled = true;
+		dpm_table->min = dpm_table->dpm_levels[0].value;
+		dpm_table->max = dpm_table->dpm_levels[0].value;
+	}
 
-	dpm_context->dpm_tables.dcef_table.min = driver_ppt->FreqTableDcefclk[0];
-	dpm_context->dpm_tables.dcef_table.max = driver_ppt->FreqTableDcefclk[NUM_DCEFCLK_DPM_LEVELS - 1];
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
 
-	dpm_context->dpm_tables.pixel_table.min = driver_ppt->FreqTablePixclk[0];
-	dpm_context->dpm_tables.pixel_table.max = driver_ppt->FreqTablePixclk[NUM_PIXCLK_DPM_LEVELS - 1];
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
 
-	dpm_context->dpm_tables.display_table.min = driver_ppt->FreqTableDispclk[0];
-	dpm_context->dpm_tables.display_table.max = driver_ppt->FreqTableDispclk[NUM_DISPCLK_DPM_LEVELS - 1];
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
 
-	dpm_context->dpm_tables.phy_table.min = driver_ppt->FreqTablePhyclk[0];
-	dpm_context->dpm_tables.phy_table.max = driver_ppt->FreqTablePhyclk[NUM_PHYCLK_DPM_LEVELS - 1];
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
