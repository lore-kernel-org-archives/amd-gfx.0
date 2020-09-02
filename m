Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39388C433E6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 08:32:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBE9620773
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 08:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q78gik/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE9620773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 602256E13B;
	Wed,  2 Sep 2020 08:32:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0BF36E13C
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 08:32:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tykz4ZDofsNHV3QlUUN5fAliZ2I7ex6HRIpwMnOAaXhn40U5i49izsJwjlhtzAiFZSZKyLAuDmhI62htD0Qjf7/8sq/OhP7PBSpGPTgR9T6TBm5H9kHtHbCz1dVgg4qctuTrFioLFUgEjPeFSHgVLjKy21q9utpK3YnmJ31kC+2RHm5aXWrBXxuc35yZfmIOym1PMzSaW53Co8j5Q1vt/JPaLcTmGE0AY4XPNNsKPz1Y/LXAaXyZhSQaOgP3jMF9P2gU0TvVzx02lWlpLE328oz/39e6A6/XshKoYnQ3g05l2kkqnNGP8tuoI5X1FZiAxE07peReZTRR6Vnus+p4vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2CRko+HA3691TXwsrXVQ1al2iIW3EqTNGadXmppcAI=;
 b=gu7EZPD3bN/tnGLmPEi27ZwapeRVpQicYTyrpk3abZHxtnXz6Q0KdfLRMucxuaveni05l4hekVC/7/xnn0G1jKgT//G/lzclatbMv5i/qg1i+5U+qloPkfl0ZwpunfQr2/c3D+jwdVXy+NJghs3Ge3AT4VgrEAconMyONBAnWUUml6+mUvdrQNw3ovU9GcuBI3IzofC+kbZIhssj6973W/ZJQ6hdXYbUefsWF94U0u8OrOS8vKzxqxhIsi4imiCzr+tljv5A6gQWQe5tvj5EzSGWWg2dACISOIXBbxpnG669VRhlc/8PuLJ93djs1Ym22U62pcc+hM/JOcQy7b/JBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2CRko+HA3691TXwsrXVQ1al2iIW3EqTNGadXmppcAI=;
 b=q78gik/4Ca7tlxheaVtx9KPFuZtw0gZVVWDN8fb4EW9xm/V6OqjzQjsbhk2mC1XJOOv8lJIbA/BP0SSLvQqtWES5aDkiICf1lZOJJxCCe+Lg/llZteGU7rd97IPy5kzefRZiW+FB9DaV07zY3uYETsPIVBFUR0yNJ6IksE2/5iU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3868.namprd12.prod.outlook.com (2603:10b6:5:1c8::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.23; Wed, 2 Sep 2020 08:32:06 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 08:32:05 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/9] drm/amd/pm: postpone SOCCLK/UCLK enablement after DAL
 initialization(V2)
Date: Wed,  2 Sep 2020 16:31:27 +0800
Message-Id: <20200902083134.25569-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902083134.25569-1-evan.quan@amd.com>
References: <20200902083134.25569-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR0302CA0004.apcprd03.prod.outlook.com
 (2603:1096:202::14) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 HK2PR0302CA0004.apcprd03.prod.outlook.com (2603:1096:202::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.7 via Frontend Transport; Wed, 2 Sep 2020 08:32:04 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 58f8756d-7685-4039-8edf-08d84f1aac80
X-MS-TrafficTypeDiagnostic: DM6PR12MB3868:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB38681A1CF887D64C27E45960E42F0@DM6PR12MB3868.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wN+lO+m7tufFS53CUYmUUkBYYoRc0w/L61YNi6nrtqcJLkRcwf+SeDbb9mNCqxb3w4+OdFKk4IoIIXoNWCcrTXeVvfPV3+uojiVvfTi7rW/7Q4+FjonC4IVE4J2G6CN+jajoAGwxjPcBYpDjH8249d7WOoki8f0X5LlWaQ3gmAbM/AjU+rEnUiuQqM4xkHRFdwvVhkxBgy/4EaYGSrGWCFYQnNkWi8APNK8XlAokVAuJ8lI65J+NP5w4xEa4amkLZAWNI62vjXhw/UNDjJzkuyG0pSJF9RxG2n5sdSYi1Osh/YsrdGR+zWa6aADetW6rrTWqczUSlJt7NrWFRohReQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(83380400001)(66946007)(2906002)(36756003)(16576012)(66556008)(4326008)(44832011)(316002)(186003)(66476007)(5660300002)(6486002)(8676002)(86362001)(6666004)(26005)(2616005)(956004)(6916009)(478600001)(52116002)(8936002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: oimqYNtbpgtFyiMssiOOozascWYc12aDfRlDp5Q31aYdUQQH2ueHUP9z2oEz09PCOPnFz2ehcYQvajdZVg7W6MaaTQcFe7VMzWlBnbtoMFNgTFVguNyyhlbdAmIEPy4lsK1Y08TXOXirvcDxDLW4r5rqRNvKQyYWzCkG7Af9EH3ulhOiUcXkMJtt9EPB5/+X9b72WLO4n4GouMf5Sc0inJ/J1NWvRYReotlj7gTjl0ExrTKZLTC9UZ5FJO2Sc7LkYolODIAmVSbO51kNSIek1ZWztTi9AormPTKSX6I6YDspIBqCYkC+CT/g5+VAcHaAbxGNdA8783G8kZ7mVxeEiSZO2QUHUoIRuu0JoKHkR7r5wCgkq/fRScv5SBd+I/EYswBMuVhtHf6t5oPCsvTBKN58iDHmPJnGXgPVGCvoQVgyfjqXp/waEyIvCIwICXd3E1CG0QC+B3//iExWgTsuSRJ04QM6FtfKlPGRQoYY8CsRSuL+/aKDPk7Br/v9gV4Ywx0UnZS7H1DUjOfBtP2Q+5JCGnWRl6nG9DjsnEngNpMLDIXIOx62/i3+vPjINyhHqzPiUT1IvWWFxmhLITxHS/NXpawTxJMf9x9i+7ORM81/ghFJp7EuGjgkiSxhA13+Dys0d1nJQI9xIg+65NNR7A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f8756d-7685-4039-8edf-08d84f1aac80
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 08:32:05.8703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUmGyGv23NXdge0WJnPkU8AI4w8JF2R0Ewaecnj1QF5Pb+fM2K6AEYLWfIYUakUA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3868
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

This is needed for Navi1X only. And it may help for display missing
or hang issue seen on some high resolution monitors.

V2: no UCLK DPM enablement for Navi10 A0 secure SKU

Change-Id: Id3965a638c2a238d52cf074f2111dc4bf2244a3e
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 60 ++++++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  6 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  4 ++
 3 files changed, 46 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 42d53cca7360..8180b7f99991 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -279,9 +279,6 @@ navi10_get_allowed_feature_mask(struct smu_context *smu,
 				| FEATURE_MASK(FEATURE_FW_CTF_BIT)
 				| FEATURE_MASK(FEATURE_OUT_OF_BAND_MONITOR_BIT);
 
-	if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
-
 	if (adev->pm.pp_feature & PP_SCLK_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT);
 
@@ -291,11 +288,6 @@ navi10_get_allowed_feature_mask(struct smu_context *smu,
 	if (adev->pm.pp_feature & PP_DCEFCLK_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_DCEFCLK_BIT);
 
-	if (adev->pm.pp_feature & PP_MCLK_DPM_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
-				| FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
-				| FEATURE_MASK(FEATURE_MEM_MVDD_SCALING_BIT);
-
 	if (adev->pm.pp_feature & PP_ULV_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_ULV_BIT);
 
@@ -320,19 +312,12 @@ navi10_get_allowed_feature_mask(struct smu_context *smu,
 	if (smu->dc_controlled_by_gpio)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_ACDC_BIT);
 
-	/* disable DPM UCLK and DS SOCCLK on navi10 A0 secure board */
-	if (is_asic_secure(smu)) {
-		/* only for navi10 A0 */
-		if ((adev->asic_type == CHIP_NAVI10) &&
-			(adev->rev_id == 0)) {
-			*(uint64_t *)feature_mask &=
-					~(FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
-					  | FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
-					  | FEATURE_MASK(FEATURE_MEM_MVDD_SCALING_BIT));
-			*(uint64_t *)feature_mask &=
-					~FEATURE_MASK(FEATURE_DS_SOCCLK_BIT);
-		}
-	}
+	/* DS SOCCLK enablement should be skipped for navi10 A0 secure board */
+	if (is_asic_secure(smu) &&
+	    (adev->asic_type == CHIP_NAVI10) &&
+	    (adev->rev_id == 0))
+		*(uint64_t *)feature_mask &=
+				~FEATURE_MASK(FEATURE_DS_SOCCLK_BIT);
 
 	return 0;
 }
@@ -2578,6 +2563,38 @@ static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
 					       NULL);
 }
 
+static int navi10_post_smu_init(struct smu_context *smu)
+{
+	struct smu_feature *feature = &smu->smu_feature;
+	struct amdgpu_device *adev = smu->adev;
+	uint64_t feature_mask = 0;
+
+	/* For Naiv1x, enable these features only after DAL initialization */
+	if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
+		feature_mask |= FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
+
+	/* DPM UCLK enablement should be skipped for navi10 A0 secure board */
+	if (!(is_asic_secure(smu) &&
+	     (adev->asic_type == CHIP_NAVI10) &&
+	     (adev->rev_id == 0)) &&
+	    (adev->pm.pp_feature & PP_MCLK_DPM_MASK))
+		feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
+				| FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
+				| FEATURE_MASK(FEATURE_MEM_MVDD_SCALING_BIT);
+
+	if (!feature_mask)
+		return 0;
+
+	bitmap_or(feature->allowed,
+		  feature->allowed,
+		  (unsigned long *)(&feature_mask),
+		  SMU_FEATURE_MAX);
+
+	return smu_cmn_feature_update_enable_state(smu,
+						   feature_mask,
+						   true);
+}
+
 static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_allowed_feature_mask = navi10_get_allowed_feature_mask,
 	.set_default_dpm_table = navi10_set_default_dpm_table,
@@ -2661,6 +2678,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.gfx_ulv_control = smu_v11_0_gfx_ulv_control,
 	.deep_sleep_control = smu_v11_0_deep_sleep_control,
 	.get_fan_parameters = navi10_get_fan_parameters,
+	.post_init = navi10_post_smu_init,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index a58ea08cd115..5fd98c1c3d7c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -343,9 +343,9 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
 	return ret;
 }
 
-static int smu_cmn_feature_update_enable_state(struct smu_context *smu,
-					       uint64_t feature_mask,
-					       bool enabled)
+int smu_cmn_feature_update_enable_state(struct smu_context *smu,
+					uint64_t feature_mask,
+					bool enabled)
 {
 	struct smu_feature *feature = &smu->smu_feature;
 	int ret = 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 6d00ad740c27..ab577be23c15 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -52,6 +52,10 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
 			     uint32_t *feature_mask,
 			     uint32_t num);
 
+int smu_cmn_feature_update_enable_state(struct smu_context *smu,
+					uint64_t feature_mask,
+					bool enabled);
+
 int smu_cmn_feature_set_enabled(struct smu_context *smu,
 				enum smu_feature_mask mask,
 				bool enable);
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
