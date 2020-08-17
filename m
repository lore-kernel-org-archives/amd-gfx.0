Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7AEC433E3
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 07:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D372072D
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 07:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="L514+Dcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D372072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17BC26E4A2;
	Mon, 17 Aug 2020 07:49:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44CAC6E4A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 07:49:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1KRLytwDcNDh21zXdcJKzbhrB0DbU/fPahMumJCm0JPm8PQAT78A2CKTFOh9Kpx8Vd0gGWd9cwn9xuDAZ8dIuXj7f/2KVukVGF+H4XCO0LCnGVA4OsUnXW98NWJTgJLr44TfHKIzPw9U3IOfImzR7yzCx/pqRgWIdS8WXKMdgw0h7358KDrQm6hvRB8iMxaNxGagCQQAUg4ZE0YpOgcqnErWPM5W8RH6FhrOz+CjJnK2NAMlaB/WKdJYq8qUhciN/WuV86tjEEv3IeU6Q4cT3bOePB6fP/DwTb0MdDU5oeCllZz7LT3GdoNefAtq/0Sa6FRgLxctFXH2cQxL55hvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKKY6MXjLYocKe5mIxEI0zeI8zA3cVcPdoxiPJgEzCk=;
 b=gWr/cw2wEbf+0/NJRUCiMoQv4WgfOo8dMWkLA4RQzT9g4u3C6pAyKQ78GKLi0Qm1VGL+hgwjyb+jVW7+EIWRaDxe4eEsEYvdyJisI+We+IeHiDKfzwLFprcCsJirDqEYo44dtfx+JRT6jTogMsxhfmC/ABfdZXYTdt8dTLWYlwnPZoF1NEsv3xiuRHF3ZY8TpCLlGlomz4acm3pK9F10jP5nzYeQHE4P05u2BIbewpwoe12qvNZsfqMhFVkDTE2PEF8lnkWtgOSiORKI+CwPtrYH1E3HspY02/i67ONpCtd3uK4QmMmoLSpeslGA+hWSeb9q4TPVpe1ij207Pedc8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKKY6MXjLYocKe5mIxEI0zeI8zA3cVcPdoxiPJgEzCk=;
 b=L514+Dcj7T0Ic752JaXPJwACF+UPkkxp11JpMlmEwJxGeObupvUdchQs9XOkteYdr9JOK79rA1G5aripfVrf5PZVl/Srsk2dHqZijWTsXlmo54yLvMotxyql3710KbB69rkWltpdsP6iFVJqX9FkOuoVpacH2cad0omBAy4tDPo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1452.namprd12.prod.outlook.com (2603:10b6:4:a::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.20; Mon, 17 Aug 2020 07:49:54 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.026; Mon, 17 Aug 2020
 07:49:54 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/5] drm/amd/pm: widely share the logic for gfx ulv control
Date: Mon, 17 Aug 2020 15:49:17 +0800
Message-Id: <20200817074917.9607-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817074917.9607-1-evan.quan@amd.com>
References: <20200817074917.9607-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR0401CA0015.apcprd04.prod.outlook.com
 (2603:1096:202:2::25) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0401CA0015.apcprd04.prod.outlook.com (2603:1096:202:2::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Mon, 17 Aug 2020 07:49:52 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ba82b81c-6508-425a-fb2e-08d8428220ac
X-MS-TrafficTypeDiagnostic: DM5PR12MB1452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1452753E15720D1CDAEA0B04E45F0@DM5PR12MB1452.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BiE3BTP3EuC9kKAUzrXso6MD3SdX4GHZQYTqK5WmOra0WX77jtakxfKOGG31Whree0tHp0ta6nQovWUmvlq4OD6FuCRYHQcAXIGmDskHOfgKz6tfryeHC+gkGKt19ERz72qZksr/NWiIddkTI1KIYUt+bViY/JLR+7pDBCxrmaPDYJUg/bJnXCyxAOM07vV94BWS3ajKf+LMGvMO9J89FAHR89GFphyt623hoDs3/+xEfLwOnE2hX/B37uTSDRdOz9HzbdfdHSMBnHJYrALXMrqbqnl2HbXkT/ygtHU/TdyvekKz144jtf2w0Z/GTZyh1AQr1RFxlBeUwkpmxfeiSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(4326008)(86362001)(16526019)(6666004)(186003)(2906002)(2616005)(478600001)(956004)(8676002)(6486002)(5660300002)(66946007)(66556008)(7696005)(316002)(83380400001)(66476007)(8936002)(52116002)(1076003)(36756003)(26005)(6916009)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: v9m2wYtdMenFvciPLC9EwW3+RfXlkFqOD3inP8wGFttgUyvrH0tniChPiDdm2ZKn9zdz094itbLsqcRxDndraQjFk6mdH/IpNmnK8Ah+5If/ssG1Nfr6iyNQLDXHYT+461lWBwddZXPyFMOiG09y+gt4pKjec80B99Iry2q9mGk7AdWT0wUSEacM/5wkQkTRENU8DHXmVzhTnc9DLb8mobZeUFPai2X8GFiu9uLbRircYX/Fulw+yxd63SRDY90lKtMcPGjE/qSaWOD/HVmcS5GT1nkDnwQc8xVJh0QidLEDMYiPCSDfRqVDZNiu8YyzJ68gC5wORk1vqhs6IdNyVuBxtAPbscagTT9phBdOiSdFNhjNbCkF3UdBHT41YOIbY2MEo0cAnTqTa3RrDjf0JAjb8Eidz74d0BAGJ0bw7DfHfZcrKburo9KQbEZ1RJ1ws8kMryQEOz/zNywP/4t6Sj7nAcsTlEP454fs10A1cfF1UghC9h8FWjSD3ArourE+YIbQSjwhw2vy4WfBQi7H6eWBD4ul89UfLPX0Gcly9n2ooqp18GcZpDHd1C8ge7xLywMnypZDFYJB7jg3PlHAOkJ+JpAmdms+BMVJKGL8AVrjruZTxVQtEek0fiPONTennZuZMs0ZA8GGwHkRGmI9Cg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba82b81c-6508-425a-fb2e-08d8428220ac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 07:49:53.9741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLTvPhRppFeHjgp9PgpJbbWzplMSwpEQtIAfqD/ERXPJLrGJfAZhA+NQBXXOx3wG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1452
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

Considering the same logic can be applied to Arcturus, Navi1X
and Sienna Cichlid.

Change-Id: I16958d114afbb2433789ca350019fea9b50e1218
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h              |  3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c   | 13 +------------
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c     | 13 +------------
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 13 +------------
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c      | 11 +++++++++++
 5 files changed, 17 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 65363d56e3cc..89d70165ac44 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -274,5 +274,8 @@ int smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu);
 
 void smu_v11_0_init_gpu_metrics_v1_0(struct gpu_metrics_v1_0 *gpu_metrics);
 
+int smu_v11_0_gfx_ulv_control(struct smu_context *smu,
+			      bool enablement);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index c82ef2872a50..aab83b957246 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2313,17 +2313,6 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v1_0);
 }
 
-static int arcturus_gfx_ulv_control(struct smu_context *smu,
-				    bool enablement)
-{
-	int ret = 0;
-
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_GFX_ULV_BIT))
-		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_GFX_ULV_BIT, enablement);
-
-	return ret;
-}
-
 static const struct pptable_funcs arcturus_ppt_funcs = {
 	/* init dpm */
 	.get_allowed_feature_mask = arcturus_get_allowed_feature_mask,
@@ -2402,7 +2391,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.get_gpu_metrics = arcturus_get_gpu_metrics,
-	.gfx_ulv_control = arcturus_gfx_ulv_control,
+	.gfx_ulv_control = smu_v11_0_gfx_ulv_control,
 };
 
 void arcturus_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index c10119f29904..c968f05533d9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2578,17 +2578,6 @@ static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
 					       NULL);
 }
 
-static int navi10_gfx_ulv_control(struct smu_context *smu,
-				  bool enablement)
-{
-	int ret = 0;
-
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_GFX_ULV_BIT))
-		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_GFX_ULV_BIT, enablement);
-
-	return ret;
-}
-
 static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_allowed_feature_mask = navi10_get_allowed_feature_mask,
 	.set_default_dpm_table = navi10_set_default_dpm_table,
@@ -2671,7 +2660,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.get_gpu_metrics = navi10_get_gpu_metrics,
 	.enable_mgpu_fan_boost = navi10_enable_mgpu_fan_boost,
-	.gfx_ulv_control = navi10_gfx_ulv_control,
+	.gfx_ulv_control = smu_v11_0_gfx_ulv_control,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 3559b33da0c4..45b9defebd07 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2718,17 +2718,6 @@ static int sienna_cichlid_enable_mgpu_fan_boost(struct smu_context *smu)
 					       NULL);
 }
 
-static int sienna_cichlid_gfx_ulv_control(struct smu_context *smu,
-					  bool enablement)
-{
-	int ret = 0;
-
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_GFX_ULV_BIT))
-		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_GFX_ULV_BIT, enablement);
-
-	return ret;
-}
-
 static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_allowed_feature_mask = sienna_cichlid_get_allowed_feature_mask,
 	.set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
@@ -2807,7 +2796,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.get_gpu_metrics = sienna_cichlid_get_gpu_metrics,
 	.enable_mgpu_fan_boost = sienna_cichlid_enable_mgpu_fan_boost,
-	.gfx_ulv_control = sienna_cichlid_gfx_ulv_control,
+	.gfx_ulv_control = smu_v11_0_gfx_ulv_control,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 580889a02a94..f1130a288f1d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1985,3 +1985,14 @@ void smu_v11_0_init_gpu_metrics_v1_0(struct gpu_metrics_v1_0 *gpu_metrics)
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 }
+
+int smu_v11_0_gfx_ulv_control(struct smu_context *smu,
+			      bool enablement)
+{
+	int ret = 0;
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_GFX_ULV_BIT))
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_GFX_ULV_BIT, enablement);
+
+	return ret;
+}
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
