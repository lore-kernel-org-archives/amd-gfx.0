Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C80C433E6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1488A21582
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="g1UbAIaP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1488A21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF15D897F0;
	Tue, 14 Jul 2020 08:06:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2301B897F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 08:06:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClE5QzFiARxGMKwObILnxaZfYicbbt3Xro/Kl3cXeMpOOvO4P3d6HpQSychjSZ9DVu08Buzp0F/Exv9b3HUZc2+ykYSZUfN5TkVSooAoe1OXfoKbDr3zyvI+AHuar77tf4lF9bu1wRBQuQkkjrLj7ULZSEn8iAmAVK4cc7l7LnTP4UKD2GhFpOu6IXX8kworprutHHYaykUm8kClpNqc7UjB3mGXN/vMO21Q1SwoAyQKXsRp9l8xBF5eazy+swIOgCF2KLz8qG/Idef2kAUEY0gdvLAkNwOkwWqSi96caKMVmPi8YMBhmI+DdWmIhjWqUH75dX1Cw+yWlcOZNvxajQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeBrsQ7uJ/B1EtvlkKvhBcDpNrPi86YpqUqlXbK7Pe0=;
 b=OhYQd86P1hRyxDb7ZGilW+vZH8aCVgXCB704ok9r/MVyBYkSGxNgMIzpJJscBV/PXcQMpBPJRWHUvASX7GN9PtmHLHTX8L6d97LDGiZ55EIRAnatVwRnWvC7+6zChppnqhSNiuDFkz0gx001n1WdgjUA+3NfVJNCulknFoCAaNUoY3WDnzLIF/OxwkkI1c0l0N/6UFnc8zArau0VMfQ2ghlI8RGNSl/32Gs7+dTtoBAiO7VSsuSZsSOzizXMcPxMMLxcQL7KAM62xBxfXqjcM7yDbWtgC+6rw8D+buvTHA2QoiFj63u1ig/SMCcQoGa3ppBgnxQoyxTb8Boo+OQtSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeBrsQ7uJ/B1EtvlkKvhBcDpNrPi86YpqUqlXbK7Pe0=;
 b=g1UbAIaPTxSpj7EiluxEnETTVvCXi/Sx7iw+p7KcIE3AXwLKUNOwrLWD16PnpvTE1HvWnfpi3QVAU0vA8dZUghsAdkH3H0OUhEvZOY1zW0L/PZ+9vHPGk9T36ZrnL3R8giazdt35trLdw7Fo3rXjmnEduhfXSNiyckQFpUgIoZ0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Tue, 14 Jul 2020 08:06:47 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 08:06:47 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/17] drm/amd/powerplay: move dpm feature enablement checking
 to smu_cmn.c
Date: Tue, 14 Jul 2020 16:04:05 +0800
Message-Id: <20200714080416.6506-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714080416.6506-1-evan.quan@amd.com>
References: <20200714080416.6506-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR04CA0078.apcprd04.prod.outlook.com
 (2603:1096:202:15::22) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0078.apcprd04.prod.outlook.com (2603:1096:202:15::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22 via Frontend Transport; Tue, 14 Jul 2020 08:06:46 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 251ad41b-9d06-42d1-a104-08d827ccdae9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4355F37A846D29A03EECEAFDE4610@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:57;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vpy5bu0SdaisSE6RNhezKp7/JOeaYhOazmkdn77P8ioA+PVGapSfQTOWyCfaOiYSBDS5qzn1pCdaLFmvop9kGJUH3VWUSzVPLQJKeQYdvCMfQ2Tgv1aou1Tx0/Ahg3+GmnKnvHnjvmJt9sqfe6W/tNa6YGqWqmEnM+mWLze0+HEMiaaUSAk/+40Y4/mU+4aiStKJWxh4leM7PQ53zvUbE6s4ihL1U8xNWXJopWCWXcb1Hhf8QbDqPbi721LV2WDRAGjh0wPjKcpmlDn2+lDVUhVodID5Nt2eg+BhMAQdfYVwiPBPE8WCcNTMk4j9tFkELsDQWV4DOexVWvOywk1cRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(478600001)(83380400001)(316002)(4326008)(2616005)(8936002)(8676002)(36756003)(66946007)(66556008)(1076003)(44832011)(2906002)(956004)(66476007)(6486002)(5660300002)(52116002)(6666004)(186003)(30864003)(86362001)(7696005)(16526019)(26005)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: R1LB1Nvn6FygN62KnT4M+jWnon7XUJmDOtbvbpuNpbLG3MHp7iFKPXw9unhaEEC9zlsPrNWVctASrVcEyU7MrduWhp1tEazNOeK+XWgNbuL18Eu1v1eBRjJontLFhkgPAJzIvoo34biBwl75LhfDFseQXJyCHzUql9Fsh3+wp8eOFwB4uxqzNRuwy5vwCLbcxHkrMI9VFADGl9m7YktOlByJ3JseYKPNypuB01/qLwAxOqZNlzxmFNGGnUQyHbHcihdo6OeVAEL2ARaviksKcagK6G3jyDL3pVsqTMNRl62A5Hg/wQBHSF2BCjWm/9d4SOfklAjbkQW37eCX+pnr7EmDpLWoCN64VMLHbQ+QBkDrrnbughn1kBwrQkRm1gpDtr+4CoxH5pmfzh2wFnhhzhB9ZVaVzMhaB9TxGhZMb1IMnQ3WVC2kKIs8Je/QNrdVW2QOz1n30kShrxBTfx6TRvVhvmA96S9t2rUsZdWsuzKkQC/I32fibCnHK1DpR/tw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251ad41b-9d06-42d1-a104-08d827ccdae9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 08:06:47.7698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TLa62ETmrtZeAu0mH9jXYWUPjUxwfY48py1Pc30LgN9iFoembuWMTjKrCC5XeERB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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

Considering it is shared by all ASICs and smu_cmn.c should be
the right place.

Change-Id: I84a86c1ec20c582826860edaecd9e8a2731d9a82
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 23 ------------
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 29 ++++++++-------
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  3 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 31 ++++++++--------
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    | 11 +++---
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 37 ++++++++++---------
 drivers/gpu/drm/amd/powerplay/smu_cmn.c       | 24 ++++++++++++
 drivers/gpu/drm/amd/powerplay/smu_cmn.h       |  3 ++
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  1 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 20 +++++-----
 10 files changed, 95 insertions(+), 87 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 2e030a2c0910..820af154734d 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -527,29 +527,6 @@ static int smu_get_driver_allowed_feature_mask(struct smu_context *smu)
 	return ret;
 }
 
-int smu_feature_is_enabled(struct smu_context *smu, enum smu_feature_mask mask)
-{
-	struct smu_feature *feature = &smu->smu_feature;
-	int feature_id;
-	int ret = 0;
-
-	if (smu->is_apu)
-		return 1;
-	feature_id = smu_cmn_to_asic_specific_index(smu,
-						    CMN2ASIC_MAPPING_FEATURE,
-						    mask);
-	if (feature_id < 0)
-		return 0;
-
-	WARN_ON(feature_id > feature->feature_num);
-
-	mutex_lock(&feature->mutex);
-	ret = test_bit(feature_id, feature->enabled);
-	mutex_unlock(&feature->mutex);
-
-	return ret;
-}
-
 int smu_feature_set_enabled(struct smu_context *smu, enum smu_feature_mask mask,
 			    bool enable)
 {
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 7a9793663c61..baf02a74efb6 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -279,7 +279,7 @@ static int arcturus_set_default_dpm_table(struct smu_context *smu)
 
 	/* socclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.soc_table;
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_SOCCLK,
 						     dpm_table);
@@ -297,7 +297,7 @@ static int arcturus_set_default_dpm_table(struct smu_context *smu)
 
 	/* gfxclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.gfx_table;
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_GFXCLK,
 						     dpm_table);
@@ -315,7 +315,7 @@ static int arcturus_set_default_dpm_table(struct smu_context *smu)
 
 	/* memclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.uclk_table;
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_UCLK,
 						     dpm_table);
@@ -333,7 +333,7 @@ static int arcturus_set_default_dpm_table(struct smu_context *smu)
 
 	/* fclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.fclk_table;
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_FCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_FCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_FCLK,
 						     dpm_table);
@@ -649,31 +649,31 @@ static int arcturus_get_current_clk_freq_by_table(struct smu_context *smu,
 		 * We can use Average_* for dpm disabled case.
 		 *   But this is available for gfxclk/uclk/socclk/vclk/dclk.
 		 */
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT))
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT))
 			member_type = METRICS_CURR_GFXCLK;
 		else
 			member_type = METRICS_AVERAGE_GFXCLK;
 		break;
 	case PPCLK_UCLK:
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT))
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT))
 			member_type = METRICS_CURR_UCLK;
 		else
 			member_type = METRICS_AVERAGE_UCLK;
 		break;
 	case PPCLK_SOCCLK:
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT))
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT))
 			member_type = METRICS_CURR_SOCCLK;
 		else
 			member_type = METRICS_AVERAGE_SOCCLK;
 		break;
 	case PPCLK_VCLK:
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT))
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT))
 			member_type = METRICS_CURR_VCLK;
 		else
 			member_type = METRICS_AVERAGE_VCLK;
 		break;
 	case PPCLK_DCLK:
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT))
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT))
 			member_type = METRICS_CURR_DCLK;
 		else
 			member_type = METRICS_AVERAGE_DCLK;
@@ -819,7 +819,7 @@ static int arcturus_upload_dpm_level(struct smu_context *smu,
 	uint32_t freq;
 	int ret = 0;
 
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
 	    (feature_mask & FEATURE_DPM_GFXCLK_MASK)) {
 		freq = dpm_context->dpm_tables.gfx_table.dpm_levels[level].value;
 		ret = smu_send_smc_msg_with_param(smu,
@@ -833,7 +833,7 @@ static int arcturus_upload_dpm_level(struct smu_context *smu,
 		}
 	}
 
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) &&
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) &&
 	    (feature_mask & FEATURE_DPM_UCLK_MASK)) {
 		freq = dpm_context->dpm_tables.uclk_table.dpm_levels[level].value;
 		ret = smu_send_smc_msg_with_param(smu,
@@ -847,7 +847,7 @@ static int arcturus_upload_dpm_level(struct smu_context *smu,
 		}
 	}
 
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT) &&
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT) &&
 	    (feature_mask & FEATURE_DPM_SOCCLK_MASK)) {
 		freq = dpm_context->dpm_tables.soc_table.dpm_levels[level].value;
 		ret = smu_send_smc_msg_with_param(smu,
@@ -1836,7 +1836,7 @@ static int arcturus_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 	int ret = 0;
 
 	if (enable) {
-		if (!smu_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
+		if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
 			ret = smu_feature_set_enabled(smu, SMU_FEATURE_VCN_PG_BIT, 1);
 			if (ret) {
 				dev_err(smu->adev->dev, "[EnableVCNDPM] failed!\n");
@@ -1845,7 +1845,7 @@ static int arcturus_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 		}
 		power_gate->vcn_gated = false;
 	} else {
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
 			ret = smu_feature_set_enabled(smu, SMU_FEATURE_VCN_PG_BIT, 0);
 			if (ret) {
 				dev_err(smu->adev->dev, "[DisableVCNDPM] failed!\n");
@@ -2274,6 +2274,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.init_display_count = NULL,
 	.set_allowed_mask = smu_v11_0_set_allowed_mask,
 	.get_enabled_mask = smu_v11_0_get_enabled_mask,
+	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.notify_display_change = NULL,
 	.set_power_limit = smu_v11_0_set_power_limit,
 	.init_max_sustainable_clocks = smu_v11_0_init_max_sustainable_clocks,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 771a9b37265b..cc9822aaf535 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -533,6 +533,7 @@ struct pptable_funcs {
 	int (*init_display_count)(struct smu_context *smu, uint32_t count);
 	int (*set_allowed_mask)(struct smu_context *smu);
 	int (*get_enabled_mask)(struct smu_context *smu, uint32_t *feature_mask, uint32_t num);
+	int (*feature_is_enabled)(struct smu_context *smu, enum smu_feature_mask mask);
 	int (*notify_display_change)(struct smu_context *smu);
 	int (*set_power_limit)(struct smu_context *smu, uint32_t n);
 	int (*init_max_sustainable_clocks)(struct smu_context *smu);
@@ -723,8 +724,6 @@ extern const struct amd_ip_funcs smu_ip_funcs;
 extern const struct amdgpu_ip_block_version smu_v11_0_ip_block;
 extern const struct amdgpu_ip_block_version smu_v12_0_ip_block;
 
-extern int smu_feature_is_enabled(struct smu_context *smu,
-				  enum smu_feature_mask mask);
 extern int smu_feature_set_enabled(struct smu_context *smu,
 				   enum smu_feature_mask mask, bool enable);
 
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 1626c0dfdcd3..6d3ddb6203f8 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -600,7 +600,7 @@ static int navi10_set_default_dpm_table(struct smu_context *smu)
 
 	/* socclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.soc_table;
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_SOCCLK,
 						     dpm_table);
@@ -618,7 +618,7 @@ static int navi10_set_default_dpm_table(struct smu_context *smu)
 
 	/* gfxclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.gfx_table;
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_GFXCLK,
 						     dpm_table);
@@ -636,7 +636,7 @@ static int navi10_set_default_dpm_table(struct smu_context *smu)
 
 	/* uclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.uclk_table;
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_UCLK,
 						     dpm_table);
@@ -654,7 +654,7 @@ static int navi10_set_default_dpm_table(struct smu_context *smu)
 
 	/* vclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.vclk_table;
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_VCLK,
 						     dpm_table);
@@ -672,7 +672,7 @@ static int navi10_set_default_dpm_table(struct smu_context *smu)
 
 	/* dclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.dclk_table;
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_DCLK,
 						     dpm_table);
@@ -690,7 +690,7 @@ static int navi10_set_default_dpm_table(struct smu_context *smu)
 
 	/* dcefclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.dcef_table;
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_DCEFCLK,
 						     dpm_table);
@@ -708,7 +708,7 @@ static int navi10_set_default_dpm_table(struct smu_context *smu)
 
 	/* pixelclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.pixel_table;
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_PIXCLK,
 						     dpm_table);
@@ -726,7 +726,7 @@ static int navi10_set_default_dpm_table(struct smu_context *smu)
 
 	/* displayclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.display_table;
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_DISPCLK,
 						     dpm_table);
@@ -744,7 +744,7 @@ static int navi10_set_default_dpm_table(struct smu_context *smu)
 
 	/* phyclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.phy_table;
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_PHYCLK,
 						     dpm_table);
@@ -771,14 +771,14 @@ static int navi10_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 
 	if (enable) {
 		/* vcn dpm on is a prerequisite for vcn power gate messages */
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
 			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn, 1, NULL);
 			if (ret)
 				return ret;
 		}
 		power_gate->vcn_gated = false;
 	} else {
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
 			ret = smu_send_smc_msg(smu, SMU_MSG_PowerDownVcn, NULL);
 			if (ret)
 				return ret;
@@ -796,14 +796,14 @@ static int navi10_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 	int ret = 0;
 
 	if (enable) {
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
 			ret = smu_send_smc_msg(smu, SMU_MSG_PowerUpJpeg, NULL);
 			if (ret)
 				return ret;
 		}
 		power_gate->jpeg_gated = false;
 	} else {
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
 			ret = smu_send_smc_msg(smu, SMU_MSG_PowerDownJpeg, NULL);
 			if (ret)
 				return ret;
@@ -1248,7 +1248,7 @@ static int navi10_pre_display_config_changed(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
 		ret = smu_v11_0_get_dpm_ultimate_freq(smu, SMU_UCLK, NULL, &max_freq);
 		if (ret)
 			return ret;
@@ -1564,7 +1564,7 @@ static int navi10_notify_smc_display_config(struct smu_context *smu)
 		}
 	}
 
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
 		ret = smu_v11_0_set_hard_freq_limited_range(smu, SMU_UCLK, min_clocks.memory_clock/100, 0);
 		if (ret) {
 			dev_err(smu->adev->dev, "[%s] Set hard min uclk failed!", __func__);
@@ -2299,6 +2299,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.init_display_count = smu_v11_0_init_display_count,
 	.set_allowed_mask = smu_v11_0_set_allowed_mask,
 	.get_enabled_mask = smu_v11_0_get_enabled_mask,
+	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.notify_display_change = smu_v11_0_notify_display_change,
 	.set_power_limit = smu_v11_0_set_power_limit,
 	.init_max_sustainable_clocks = smu_v11_0_init_max_sustainable_clocks,
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 61560192e73c..1d40795b27e6 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -442,14 +442,14 @@ static int renoir_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 
 	if (enable) {
 		/* vcn dpm on is a prerequisite for vcn power gate messages */
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
 			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn, 0, NULL);
 			if (ret)
 				return ret;
 		}
 		power_gate->vcn_gated = false;
 	} else {
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
 			ret = smu_send_smc_msg(smu, SMU_MSG_PowerDownVcn, NULL);
 			if (ret)
 				return ret;
@@ -467,14 +467,14 @@ static int renoir_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 	int ret = 0;
 
 	if (enable) {
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
 			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerUpJpeg, 0, NULL);
 			if (ret)
 				return ret;
 		}
 		power_gate->jpeg_gated = false;
 	} else {
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
 			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerDownJpeg, 0, NULL);
 			if (ret)
 				return ret;
@@ -550,7 +550,7 @@ static int renoir_unforce_dpm_levels(struct smu_context *smu) {
 	};
 
 	for (i = 0; i < ARRAY_SIZE(clk_feature_map); i++) {
-		if (!smu_feature_is_enabled(smu, clk_feature_map[i].feature))
+		if (!smu_cmn_feature_is_enabled(smu, clk_feature_map[i].feature))
 		    continue;
 
 		clk_type = clk_feature_map[i].clk_type;
@@ -990,6 +990,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.fini_smc_tables = smu_v12_0_fini_smc_tables,
 	.set_default_dpm_table = smu_v12_0_set_default_dpm_tables,
 	.get_enabled_mask = smu_v12_0_get_enabled_mask,
+	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.get_dpm_ultimate_freq = renoir_get_dpm_ultimate_freq,
 	.mode2_reset = smu_v12_0_mode2_reset,
 	.set_soft_freq_limited_range = smu_v12_0_set_soft_freq_limited_range,
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index c785065da855..c91aec90ce32 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -512,7 +512,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 
 	/* socclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.soc_table;
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_SOCCLK,
 						     dpm_table);
@@ -530,7 +530,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 
 	/* gfxclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.gfx_table;
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_GFXCLK,
 						     dpm_table);
@@ -548,7 +548,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 
 	/* uclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.uclk_table;
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_UCLK,
 						     dpm_table);
@@ -566,7 +566,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 
 	/* fclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.fclk_table;
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_FCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_FCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_FCLK,
 						     dpm_table);
@@ -584,7 +584,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 
 	/* vclk0 dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.vclk_table;
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_VCLK,
 						     dpm_table);
@@ -602,7 +602,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 
 	/* vclk1 dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.vclk1_table;
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_VCLK1,
 						     dpm_table);
@@ -620,7 +620,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 
 	/* dclk0 dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.dclk_table;
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_DCLK,
 						     dpm_table);
@@ -638,7 +638,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 
 	/* dclk1 dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.dclk1_table;
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_DCLK1,
 						     dpm_table);
@@ -656,7 +656,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 
 	/* dcefclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.dcef_table;
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_DCEFCLK,
 						     dpm_table);
@@ -674,7 +674,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 
 	/* pixelclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.pixel_table;
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_PIXCLK,
 						     dpm_table);
@@ -692,7 +692,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 
 	/* displayclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.display_table;
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_DISPCLK,
 						     dpm_table);
@@ -710,7 +710,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 
 	/* phyclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.phy_table;
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_PHYCLK,
 						     dpm_table);
@@ -737,7 +737,7 @@ static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu, bool enabl
 
 	if (enable) {
 		/* vcn dpm on is a prerequisite for vcn power gate messages */
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
 			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn, 0, NULL);
 			if (ret)
 				return ret;
@@ -747,7 +747,7 @@ static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu, bool enabl
 		}
 		power_gate->vcn_gated = false;
 	} else {
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
 			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerDownVcn, 0, NULL);
 			if (ret)
 				return ret;
@@ -768,14 +768,14 @@ static int sienna_cichlid_dpm_set_jpeg_enable(struct smu_context *smu, bool enab
 	int ret = 0;
 
 	if (enable) {
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
 			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerUpJpeg, 0, NULL);
 			if (ret)
 				return ret;
 		}
 		power_gate->jpeg_gated = false;
 	} else {
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
 			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerDownJpeg, 0, NULL);
 			if (ret)
 				return ret;
@@ -1039,7 +1039,7 @@ static int sienna_cichlid_pre_display_config_changed(struct smu_context *smu)
 		return ret;
 #endif
 
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
 		ret = smu_v11_0_get_dpm_ultimate_freq(smu, SMU_UCLK, NULL, &max_freq);
 		if (ret)
 			return ret;
@@ -1357,7 +1357,7 @@ static int sienna_cichlid_notify_smc_display_config(struct smu_context *smu)
 		}
 	}
 
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
 		ret = smu_v11_0_set_hard_freq_limited_range(smu, SMU_UCLK, min_clocks.memory_clock/100, 0);
 		if (ret) {
 			dev_err(smu->adev->dev, "[%s] Set hard min uclk failed!", __func__);
@@ -2418,6 +2418,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.init_display_count = NULL,
 	.set_allowed_mask = smu_v11_0_set_allowed_mask,
 	.get_enabled_mask = smu_v11_0_get_enabled_mask,
+	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.notify_display_change = NULL,
 	.set_power_limit = smu_v11_0_set_power_limit,
 	.init_max_sustainable_clocks = smu_v11_0_init_max_sustainable_clocks,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.c b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
index f67e12fc95d9..24aabca5739e 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_cmn.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
@@ -138,3 +138,27 @@ int smu_cmn_feature_is_supported(struct smu_context *smu,
 
 	return ret;
 }
+
+int smu_cmn_feature_is_enabled(struct smu_context *smu,
+			       enum smu_feature_mask mask)
+{
+	struct smu_feature *feature = &smu->smu_feature;
+	int feature_id;
+	int ret = 0;
+
+	if (smu->is_apu)
+		return 1;
+	feature_id = smu_cmn_to_asic_specific_index(smu,
+						    CMN2ASIC_MAPPING_FEATURE,
+						    mask);
+	if (feature_id < 0)
+		return 0;
+
+	WARN_ON(feature_id > feature->feature_num);
+
+	mutex_lock(&feature->mutex);
+	ret = test_bit(feature_id, feature->enabled);
+	mutex_unlock(&feature->mutex);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.h b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
index 6e0bd711403a..c28ea4df4b32 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_cmn.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
@@ -32,4 +32,7 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 int smu_cmn_feature_is_supported(struct smu_context *smu,
 				 enum smu_feature_mask mask);
 
+int smu_cmn_feature_is_enabled(struct smu_context *smu,
+			       enum smu_feature_mask mask);
+
 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 729eb3895307..ee904811d31d 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -54,6 +54,7 @@
 #define smu_init_display_count(smu, count)				smu_ppt_funcs(init_display_count, 0, smu, count)
 #define smu_feature_set_allowed_mask(smu)				smu_ppt_funcs(set_allowed_mask, 0, smu)
 #define smu_feature_get_enabled_mask(smu, mask, num)			smu_ppt_funcs(get_enabled_mask, 0, smu, mask, num)
+#define smu_feature_is_enabled(smu, mask)				smu_ppt_funcs(feature_is_enabled, 0, smu, mask)
 #define smu_is_dpm_running(smu)						smu_ppt_funcs(is_dpm_running, 0 , smu)
 #define smu_notify_display_change(smu)					smu_ppt_funcs(notify_display_change, 0, smu)
 #define smu_set_default_dpm_table(smu)					smu_ppt_funcs(set_default_dpm_table, 0, smu)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 5f2e56f4dc35..f1880f257237 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -936,7 +936,7 @@ int smu_v11_0_notify_display_change(struct smu_context *smu)
 	if (!smu->pm_enabled)
 		return ret;
 
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) &&
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) &&
 	    smu->adev->gmc.vram_type == AMDGPU_VRAM_TYPE_HBM)
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetUclkFastSwitch, 1, NULL);
 
@@ -994,7 +994,7 @@ int smu_v11_0_init_max_sustainable_clocks(struct smu_context *smu)
 	max_sustainable_clocks->phy_clock = 0xFFFFFFFF;
 	max_sustainable_clocks->pixel_clock = 0xFFFFFFFF;
 
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
 		ret = smu_v11_0_get_max_sustainable_clock(smu,
 							  &(max_sustainable_clocks->uclock),
 							  SMU_UCLK);
@@ -1005,7 +1005,7 @@ int smu_v11_0_init_max_sustainable_clocks(struct smu_context *smu)
 		}
 	}
 
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
 		ret = smu_v11_0_get_max_sustainable_clock(smu,
 							  &(max_sustainable_clocks->soc_clock),
 							  SMU_SOCCLK);
@@ -1016,7 +1016,7 @@ int smu_v11_0_init_max_sustainable_clocks(struct smu_context *smu)
 		}
 	}
 
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
 		ret = smu_v11_0_get_max_sustainable_clock(smu,
 							  &(max_sustainable_clocks->dcef_clock),
 							  SMU_DCEFCLK);
@@ -1064,7 +1064,7 @@ int smu_v11_0_get_current_power_limit(struct smu_context *smu,
 	int power_src;
 	int ret = 0;
 
-	if (!smu_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT))
+	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT))
 		return -EINVAL;
 
 	power_src = smu_cmn_to_asic_specific_index(smu,
@@ -1089,7 +1089,7 @@ int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
 {
 	int ret = 0;
 
-	if (!smu_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
+	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
 		dev_err(smu->adev->dev, "Setting new power limit is not supported!\n");
 		return -EOPNOTSUPP;
 	}
@@ -1152,8 +1152,8 @@ smu_v11_0_display_clock_voltage_request(struct smu_context *smu,
 	enum smu_clk_type clk_select = 0;
 	uint32_t clk_freq = clock_req->clock_freq_in_khz / 1000;
 
-	if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) ||
-		smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) ||
+		smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
 		switch (clk_type) {
 		case amd_pp_dcef_clock:
 			clk_select = SMU_DCEFCLK;
@@ -1219,7 +1219,7 @@ int smu_v11_0_gfx_off_control(struct smu_context *smu, bool enable)
 uint32_t
 smu_v11_0_get_fan_control_mode(struct smu_context *smu)
 {
-	if (!smu_feature_is_enabled(smu, SMU_FEATURE_FAN_CONTROL_BIT))
+	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_FAN_CONTROL_BIT))
 		return AMD_FAN_CTRL_MANUAL;
 	else
 		return AMD_FAN_CTRL_AUTO;
@@ -1599,7 +1599,7 @@ bool smu_v11_0_baco_is_support(struct smu_context *smu)
 
 	/* Arcturus does not support this bit mask */
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_BACO_BIT) &&
-	   !smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
+	   !smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
 		return false;
 
 	return true;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
