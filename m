Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31555C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0398F20720
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lo1zORc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0398F20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C69FD6EB6A;
	Fri, 10 Jul 2020 04:48:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 065576EB67
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 04:48:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9nypCjUI7UjktP/Eoxx4//IefPPk9uc8CiRy0moA5gv11Zrg5PbVmE1+BeX5LshX7jCqYd0ibB5Ghhr66/kGbJcmia1bm/k/h/aplAy6JIYT/r1FZDIFDLeY7Yj/f6QZ/ugUtD9t7VzKgoFScBDRWSQHjQxZ4EhEx3pyMSGSFYTmxuVRve0upsXEx+YuhDOW0wrqm+1h1tf9N7LO/CQjsXRpmmYZYbv/H2DAjpo/ceB6IQONPxG98ds/flSJHeUzb35KnAviigSqFpVc9zdCmvkpDY14qzyUG68/lmzERmtxW9J7z3+1/I17xN2yNv6ccqUBOK8EDNa9p+cxqfpDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atxGUP9TtV4krbUX14bA8SU5IHOPb9Y93slA6I5W3KU=;
 b=Mi8WNh/dNGtYzCthKtnyDLM190J+p529BXkmAZkBlqx3ZdlD4wWVxmqMbKgtTIt6x/OyBfUHL9vWFZlDe/HPkQ7TSlfhzMYZdrs2DFlKM1oVEklnXDzyJ+4Hry2yA7fnlm5o05oq2T7mfplKcbbu/8JMhe0+wgs7y4ckIYHtDvUxbiTP8w7Mjk2BLrC43dbmAKn9Pv0Zt0o8lX6ngC3AIrTcx9nx/iISpuhqV9klKPw5XRkszjdR2z/tRcPQCTGTlvuIXXaFjtbkBhFcmh/VJOCVTKf0ddu9TCO4fD5tkntY/jxRbSy7WNi040QB0/uoNTXbvQ8pwFRj0gsLQUd6Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atxGUP9TtV4krbUX14bA8SU5IHOPb9Y93slA6I5W3KU=;
 b=lo1zORc4rld5ZT5C2m3khtiGnOU3GI60a5F7iZKXenkCQA2m7TJ5L9QgAjKeOU/YYGRo51dCfgB+gH5ZiQdsmIC0VA45szdhgJZr/M+VkOFy3jLsJow5DhIernPFxC2rzL8V4bYX/Ldqk9sPaESiF/EQgbCsJbNt0D1EP8aI7TE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Fri, 10 Jul 2020 04:48:17 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 04:48:17 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/16] drm/amd/powerplay: update Sienna Cichlid default dpm
 table setup
Date: Fri, 10 Jul 2020 12:47:35 +0800
Message-Id: <20200710044746.23538-5-evan.quan@amd.com>
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
 15.20.3195.9 via Frontend Transport; Fri, 10 Jul 2020 04:48:15 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 090db089-4de6-4cf1-ce09-08d8248c7629
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2360AE1A26A25FBFF241813AE4650@DM5PR12MB2360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbqxTtQOc2D9Mvx75DfO11zRLcCDaei6J0JQKnrciI4f/EL5mnRpnn7G1lu7QZ6OPkwgPdmbkTKJfQakefkzHrIybTygegL35F+r0E6bjSRQTvp+AtlMBOL95BkxD0aexJwUVge69vVEvTReK6sT4zXeFPCRs4Ydpoo2A/GSKCRksYeG8161N61RuUiWOV+BmnArVhSQ7amwrS6lemutrcBGyP6UQbxirMBPz2Sq59A/ZRS+fcGdJITy8wce8+xtBwZwxwP6oIzoOHL+4WYJXeeE476zWgH9m4LZ94OgFRysm14OxydGRK1OeTx98tow
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(2906002)(4326008)(8676002)(8936002)(83380400001)(6486002)(44832011)(7696005)(52116002)(186003)(16526019)(956004)(2616005)(26005)(6916009)(316002)(478600001)(30864003)(86362001)(6666004)(5660300002)(66556008)(1076003)(66476007)(36756003)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: fsRbO1mLDqqlL34MTYzEttKpw12ktnnoSx8dhTBt3xVRlbJxUnRY0HSlczLB0F5Aj61E78Z0ql3d3vJj15Ie/580YKHQQcdI9QHeru/4AWKFts8uNHsxkWammLFMrnTzQKhm/x6gI6g91Zi+DNglhxRW/nuJcFI210lMPfHjoURaBBVmkWM6knxFjECie/Jm0oFfr1y1ZEYBluQ/aH6eGNUhYUKbhtKodXSE5MbNznUNIvmHZwqNbBZEZpXulLrGiMJcl50t4Lu8Gx/n7BqRssv1B5+XX/SL7V33C60vG0mqLnQXLAAWeFTxC4slpRfn98GIMsOE5UEa0VMnGue0E1DsWAYG55V2yeRcHsBaZyXon34IVETlzr9X5xvI2Ppor9Me5eC0jgdLBNC3V8apEVlIvC6lGkruW1IUJRsf931jYtjfEDhzbrptrWgUXsQoCJY/cT5Jq8uR8ehQyPtjMaPV0GkM2fBoTSDLZuCnK6HcO4bhZACPfh1m9POoH2Cs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090db089-4de6-4cf1-ce09-08d8248c7629
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 04:48:17.1556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y4YgHtJ35LRt3Q79/Ktt8TQrfacbPDLjn1Y1wiOqoxDAjj4uSghtu0Wr0O4R33gi
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

Change-Id: Idaa853356720e48ab3279f420ba1ae18bb7de4fd
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
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
