Return-Path: <SRS0=khk6=AO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6B7C433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC4A207FF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yr3l9dmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC4A207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5B8C6E192;
	Fri,  3 Jul 2020 08:33:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B22DA6E192
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 08:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FT/WB1yVlGb3eNwpBCQ8J3scL3gYKHrVDTfu9tquHNg1tdFp6UZARrwrmxmJ5TFxeb4hZ8aQ2aVMSixAuiykwaRALpl/zH4AOn38AqP+bScr44jE7E8rSC1l+qt2StcvzmRCkYwYD4+LiwZhxZtYXdMoXboqOoVyfBpb1cmMmCSNAd8eRCt1PFrQJWARcABuvpuovAiyLw086+vt6kHHscebTRT4In4oKKtNZbczPdNyXPhNr1cNV3PxxJU3lIXGYSTJfRfpDNwTq/hDWxVah5n3cZwLHz33sH1pYhnMQorIeQgngh+vMUUL2GJSouBVFABkxaDF3Ek7nQ3yH0Oa2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EC+ix2KFkp6gJEbOpE56+n3RW/gjEtxbIWavwumfgY=;
 b=dtIwxkWqmkva24g7RrwtqAbGU+ejTC/JdG+apP4KE39R5ld5Xvn5QQkf6xe7FwZfuHDd97uff+z1ogOUt+Uq+bN/KQ8+/8x9IeMe/oJXYBw/uuzQvnzVmtJSoyqP1eVz5Jtp14PsvbRW639opcOOCBk2yQIdaRwTuhitO4RmCcbx5gGXEHbLBxwGQua0m2lJubndISxK1+/R1dqhmp9vdVw2Ahy1jqeMq+sJNMBbr71ntqjAoysvx31Ju3iJXTljs/jDJKDbdsMwbpWvLAVSyOO51fK3uN6xfrDJXAYHpuyAa8PWu0n+Wzlj/XR9N6Y0v/KdcjUakS47be/jjvC7mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EC+ix2KFkp6gJEbOpE56+n3RW/gjEtxbIWavwumfgY=;
 b=yr3l9dmAKOBx0DrVcVEaIq1uWbSesyJ+lRqpHjidW7eWC6RiGNgLpFw5PwzT+h/FH8t87+4I3KmneQxUYt6zINi8ehHZZqNs3bls6tn8yJBo0TjO2rcy5SYE9Z4kgiOAdqzzl6g8VU7BluoAnw6pLShqeIxmIpStzlg342QLX60=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.27; Fri, 3 Jul 2020 08:33:39 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 08:33:39 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/14] drm/amd/powerplay: update Navi10 default dpm table setup
Date: Fri,  3 Jul 2020 16:32:52 +0800
Message-Id: <20200703083303.478-3-evan.quan@amd.com>
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
 15.20.3153.22 via Frontend Transport; Fri, 3 Jul 2020 08:33:38 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 155a26e1-d78d-42e6-538d-08d81f2bc940
X-MS-TrafficTypeDiagnostic: DM6PR12MB3962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB39625A3438A10FF4D365E238E46A0@DM6PR12MB3962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: crFIyh9EgVyt3F3SdvWf6bFX42K+OKvXfIUpbtpreEk+p8OFPle5+AirZqRbN41PC/S1xF52JkF9GQ2muy5ZqIm1cDQlcodeQp3VdHUja21WIFo4RcegXEVSfXUJP8a5Q/c9oB0drsvWWE1ROq2npu9jdDrxerDXdR8M+E/87nrMrUk5bYd8xiKWfEypC8AKocv4J9Co7UQacxDFvO9L74FSZxYljO2mwCno70hqHYtvBCwAr+fdrPNCQuu9/UdSHklSijGDUbJQvcqw9rUmy1aSs2Lz++JP9XlLJTED29V01ogjEOsuOhee4oD/SfvFz5Us397mjbX0Ufrlwbbi/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(83380400001)(44832011)(4326008)(36756003)(8936002)(7696005)(956004)(2616005)(6486002)(52116002)(478600001)(6666004)(66946007)(16526019)(26005)(186003)(66476007)(5660300002)(1076003)(66556008)(8676002)(316002)(86362001)(6916009)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /5LaB/k0zI1U/qiJFGFMaAj5qcRfNz0JUpWsqqEh8PZgrROcCZr+Bjza0Pbxf3eXXbX6wNGtRwNqhNNWOj9DibkNpUzzH/PDgFJN0BB+fVYxqHEALFJGJ/dlKVrxZ2HWkdURplwvL0H7z5BgHNedGT+nkDvhkXx+NYi9lzjPvLovcZVzi44vUVhCImUJt7cHI76j4ZGc+qIQDqE8HLU/UidEmP4BejYXJWI7lm+/23lvoysiFd2gP61r2oqPaxIppFuw+PgeL5s0Co8JSHh113kfOwkPMI05StQ8itzge4XzF32zdhct9lUAJyjijMc/InFgBYALKQ+xGrHGa8xEMjZx2ptzIABVfmdu1QdxabXFvE+r2+St0Vs9g3Hdi/4MAsCZh860pxC13GNrf0q8MVlakmRuV5iEP5/dBHhTZccVm7E+jaNynmll94vnYDxrhLdAeDEIR8DjozYn90YdwaR2+U2HM4pldP0si4AE1zlZO+l+F335H7/wOHgc9xNK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 155a26e1-d78d-42e6-538d-08d81f2bc940
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:33:39.5764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AR42MNJY85X+iXAZkZ3lkB7xpa/9Pc0g3uzZWXZaj+bZptPZR1Mz9wpgN2FiVmw
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

Change-Id: I8114cf31e6ec8c9af4578d51749eb213befdcc71
Signed-off-by: Evan Quan <evan.quan@amd.com>
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
