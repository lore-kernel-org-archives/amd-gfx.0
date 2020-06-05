Return-Path: <SRS0=/kPV=7S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEF6C433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 11:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E1E1207D5
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 11:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CSZFZCLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1E1207D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 303306E8CB;
	Fri,  5 Jun 2020 11:04:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EB066E8CE
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2020 11:04:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WM+1PvyFJM1Zg8Xz8OwTxk9FmEdMTy74qvb4p+zYdkSR6112qkyr7qazlPf2x2W9NTXz7dG9yyBAIT2UlTxdL+xLGuaCxiWAX54oQnJaT3Idw3vwGu5lao6ukpljwPNJYP3nnYQHp5HIW0sPcF9ANuqki0kgXOWPy858j3RzvgQRUdaKX+yCqS240E+v5nWnJ9MVUzFkIs44ALkq0HvJLZbpRE1j6z3vqz1ZoUS8OsYm0d+5c1KiANo9Wny0sW5yCMDOjU9XIpUm2wqCNXRVehNB1n9qa4S7hnTphUuDR57sWcEXZRK0mg/isyn9U56OQGMdp7bcpKzCfwADY3stNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loJZIRpMKkoyuX7EG9qzZtlFLSPIfJa0/DMlVox+Kss=;
 b=LmpO/qpppO2vIP63Vub5baGrZbDk/b5WOl+5ihUOoYiHY5yMZ/GUcbLBcmOGQ7aoTqXnuCd6w+DmpSMkf+Ag4O1HMxcefSOH0LPf00jTKiwgZ/4bIfJn/HnkqRpogHkSq9IwchwFFZkG7TWe2+AvTovoC2t/EsR4Kph8x5lZPWqeEQClw3dSp2VpzvhfmYOAQIRF8c0Mpyuqmusry+vIBuE4VP0rEVYJ6Oj52hD6cejxArf+SqNCpZqgFhqusNN1jLOxOLW54DklnJfAnqwr8y0nNP/LwtMirldz7KIZ8Agxb5mT84b5fOxtoIKPBbR1NTW0rOunArgZ8utT73Wdzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loJZIRpMKkoyuX7EG9qzZtlFLSPIfJa0/DMlVox+Kss=;
 b=CSZFZCLXLQavLMBfB1GuDdlCPaAQjicMmt4dNlEjGRmwkH0zPKOqsSmYsdfJ09HJhq7MplnlrJ48rX2zvkiCmgNtZaGZJzgyYzz5j4HemggFq9g7lTEJaEI4qgoLJwx2LqM32Rqp80pEICJohHNtvcaoXqxzarTK0Z9OktFHp2I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2615.namprd12.prod.outlook.com (2603:10b6:a03:61::29)
 by BYASPR01MB2.namprd12.prod.outlook.com (2603:10b6:a02:ce::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 11:04:35 +0000
Received: from BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::4c16:1697:3e6d:9157]) by BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::4c16:1697:3e6d:9157%7]) with mapi id 15.20.3066.019; Fri, 5 Jun 2020
 11:04:35 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amd/powerplay: correct the APIs' naming
Date: Fri,  5 Jun 2020 19:04:11 +0800
Message-Id: <20200605110411.27302-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200605110411.27302-1-evan.quan@amd.com>
References: <20200605110411.27302-1-evan.quan@amd.com>
X-ClientProxiedBy: HKAPR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:203:d0::27) To BYAPR12MB2615.namprd12.prod.outlook.com
 (2603:10b6:a03:61::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HKAPR04CA0017.apcprd04.prod.outlook.com (2603:1096:203:d0::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 11:04:34 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6510c634-88d7-44fb-2d32-08d809403b89
X-MS-TrafficTypeDiagnostic: BYASPR01MB2:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYASPR01MB284750E196DB8C25CE8EBE4860@BYASPR01MB2.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:304;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uxCwfnfMfwlw1srAaqnYhVOEAp4GfwBz7eyaizzUDfIFUkRVpqaEH78hwuR/248lhp+Nb/ORoFqYncgagIpI9tgZ//JcGUbgANrITUEdzfO9WuqLv2og5/brvMEoGOF8dmearrggbvxXPKNsjSMs3XuSacKGa+mxEM+ynsJ+KQEqTdcL8kMLQ8Jjo1tk2vpAKrKnqC35Mk/2DynBtp69/84lwR2Tl1Bi8Dha11ykD3V5wV0Zh5MC8YPY9c4dACUJgEtdLJSjA8UQKACLjenLISfkCDFn/x6t0aP9JsWf4wss+VZiG/VCcHwpir4p1ODO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2615.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(4326008)(8676002)(83380400001)(2616005)(1076003)(956004)(8936002)(6486002)(186003)(6666004)(6916009)(2906002)(16526019)(478600001)(66556008)(66946007)(26005)(36756003)(66476007)(5660300002)(52116002)(86362001)(316002)(7696005)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1ubcaNdMS3EOakEMGWS9MxqStZJT9cGtz1xti8z43AKaRZJ+eBZDy3dv1VZsZxqhRO3/9Rx954UEou4eZzBmb6xjo++HhuIEpwKDGEGAfEebEOJyU06A488q8yW29BaVVAuQIEEuYaJqWkS7jqz0/LmUyng5qDFbncXTqmtozQqx3j8/aCfRRQ9MQi6r29+v9rg2pq0YOa9csNoPfT0kDLQs1L9TmA9fVaKd3OTiUh9gfpNqgdb0/CZRQaPnM1hY6N6NlopbbtbJRm/hVN7QdWjay81Zw+6usTX3ZUmIwgKyCEa488L+383h0jI9hSz67+4KkWu2qdM2sNm2sh4LPgNflUWzNS2lUTmVN1pQdnpNLiOur7PkcP+QlE/5wqd55+YTofRWX9hLxJChfD6VsmYDnYFD+sGl+7QIwhBMiKU7q8YclyPSCCLynIBnnvKftSD+ijqG4V68EEHqxYGc5bAYh8wl7S6XR/YYXivz0vwmFJU9xP2javJcRhMlPTwy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6510c634-88d7-44fb-2d32-08d809403b89
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 11:04:35.6623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9yBykNaFgXVL7H/z+L+H0Ftb8d7wjhns6U/eSiVkvsLj8IHO6g/1knNNtVeR0Twx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYASPR01MB2
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

'UVD' is a HW engine name for Vega20 and before ASICs.
For newer ASICs, the similar engine is named as 'VCN'.

Change-Id: I5f1b9500ed5d35e395a5da32b81a78eb87bffc68
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         | 13 +++++++++----
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       |  4 ++--
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h     |  2 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         |  4 ++--
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c         |  4 ++--
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c |  4 ++--
 drivers/gpu/drm/amd/powerplay/smu_internal.h       |  4 ++--
 7 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 8ea100b3187b..b84eabfc1976 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -455,10 +455,15 @@ int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
 		return -EOPNOTSUPP;
 
 	switch (block_type) {
+	/*
+	 * Some legacy code of amdgpu_vcn.c and vcn_v2*.c still uses
+	 * AMD_IP_BLOCK_TYPE_UVD for VCN. So, here both of them are kept.
+	 */
 	case AMD_IP_BLOCK_TYPE_UVD:
-		ret = smu_dpm_set_uvd_enable(smu, !gate);
+	case AMD_IP_BLOCK_TYPE_VCN:
+		ret = smu_dpm_set_vcn_enable(smu, !gate);
 		if (ret)
-			dev_err(smu->adev->dev, "Failed to power %s UVD!\n",
+			dev_err(smu->adev->dev, "Failed to power %s VCN!\n",
 				gate ? "gate" : "ungate");
 		break;
 	case AMD_IP_BLOCK_TYPE_GFX:
@@ -1328,7 +1333,7 @@ static int smu_hw_init(void *handle)
 
 	if (smu->is_apu) {
 		smu_powergate_sdma(&adev->smu, false);
-		smu_dpm_set_uvd_enable(smu, true);
+		smu_dpm_set_vcn_enable(smu, true);
 		smu_dpm_set_jpeg_enable(smu, true);
 		smu_set_gfx_cgpg(&adev->smu, true);
 	}
@@ -1460,7 +1465,7 @@ static int smu_hw_fini(void *handle)
 
 	if (smu->is_apu) {
 		smu_powergate_sdma(&adev->smu, true);
-		smu_dpm_set_uvd_enable(smu, false);
+		smu_dpm_set_vcn_enable(smu, false);
 		smu_dpm_set_jpeg_enable(smu, false);
 	}
 
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index b47b5f257671..e5ef279955d9 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2116,7 +2116,7 @@ static bool arcturus_is_dpm_running(struct smu_context *smu)
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
-static int arcturus_dpm_set_uvd_enable(struct smu_context *smu, bool enable)
+static int arcturus_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
@@ -2557,7 +2557,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.dump_pptable = arcturus_dump_pptable,
 	.get_power_limit = arcturus_get_power_limit,
 	.is_dpm_running = arcturus_is_dpm_running,
-	.dpm_set_uvd_enable = arcturus_dpm_set_uvd_enable,
+	.dpm_set_vcn_enable = arcturus_dpm_set_vcn_enable,
 	.i2c_eeprom_init = arcturus_i2c_eeprom_control_init,
 	.i2c_eeprom_fini = arcturus_i2c_eeprom_control_fini,
 	.get_unique_id = arcturus_get_unique_id,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 6f31485245bb..b731f9ab05fc 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -453,7 +453,7 @@ struct pptable_funcs {
 					      *clocks);
 	int (*get_power_profile_mode)(struct smu_context *smu, char *buf);
 	int (*set_power_profile_mode)(struct smu_context *smu, long *input, uint32_t size);
-	int (*dpm_set_uvd_enable)(struct smu_context *smu, bool enable);
+	int (*dpm_set_vcn_enable)(struct smu_context *smu, bool enable);
 	int (*dpm_set_jpeg_enable)(struct smu_context *smu, bool enable);
 	int (*read_sensor)(struct smu_context *smu, enum amd_pp_sensors sensor,
 			   void *data, uint32_t *size);
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 70d93a0fd3d0..f21abda8c182 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -727,7 +727,7 @@ static int navi10_set_default_dpm_table(struct smu_context *smu)
 	return 0;
 }
 
-static int navi10_dpm_set_uvd_enable(struct smu_context *smu, bool enable)
+static int navi10_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
@@ -2369,7 +2369,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_workload_type = navi10_get_workload_type,
 	.get_allowed_feature_mask = navi10_get_allowed_feature_mask,
 	.set_default_dpm_table = navi10_set_default_dpm_table,
-	.dpm_set_uvd_enable = navi10_dpm_set_uvd_enable,
+	.dpm_set_vcn_enable = navi10_dpm_set_vcn_enable,
 	.dpm_set_jpeg_enable = navi10_dpm_set_jpeg_enable,
 	.get_current_clk_freq_by_table = navi10_get_current_clk_freq_by_table,
 	.print_clk_levels = navi10_print_clk_levels,
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 7a4e1bd9bafd..6b5e60b4c039 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -349,7 +349,7 @@ static enum amd_pm_state_type renoir_get_current_power_state(struct smu_context
 	return pm_type;
 }
 
-static int renoir_dpm_set_uvd_enable(struct smu_context *smu, bool enable)
+static int renoir_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
@@ -929,7 +929,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.get_dpm_clk_limited = renoir_get_dpm_clk_limited,
 	.print_clk_levels = renoir_print_clk_levels,
 	.get_current_power_state = renoir_get_current_power_state,
-	.dpm_set_uvd_enable = renoir_dpm_set_uvd_enable,
+	.dpm_set_vcn_enable = renoir_dpm_set_vcn_enable,
 	.dpm_set_jpeg_enable = renoir_dpm_set_jpeg_enable,
 	.get_current_clk_freq_by_table = renoir_get_current_clk_freq_by_table,
 	.force_dpm_limit_value = renoir_force_dpm_limit_value,
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 4be244787fad..a1a91ca85326 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -720,7 +720,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 	return 0;
 }
 
-static int sienna_cichlid_dpm_set_uvd_enable(struct smu_context *smu, bool enable)
+static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
@@ -2542,7 +2542,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_workload_type = sienna_cichlid_get_workload_type,
 	.get_allowed_feature_mask = sienna_cichlid_get_allowed_feature_mask,
 	.set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
-	.dpm_set_uvd_enable = sienna_cichlid_dpm_set_uvd_enable,
+	.dpm_set_vcn_enable = sienna_cichlid_dpm_set_vcn_enable,
 	.dpm_set_jpeg_enable = sienna_cichlid_dpm_set_jpeg_enable,
 	.get_current_clk_freq_by_table = sienna_cichlid_get_current_clk_freq_by_table,
 	.print_clk_levels = sienna_cichlid_print_clk_levels,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index f9041f981daf..8ffc68ee43fe 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -157,8 +157,8 @@ static inline int smu_send_smc_msg(struct smu_context *smu, enum smu_message_typ
 #define smu_get_current_shallow_sleep_clocks(smu, clocks) \
 	((smu)->ppt_funcs->get_current_shallow_sleep_clocks ? (smu)->ppt_funcs->get_current_shallow_sleep_clocks((smu), (clocks)) : 0)
 
-#define smu_dpm_set_uvd_enable(smu, enable) \
-	((smu)->ppt_funcs->dpm_set_uvd_enable ? (smu)->ppt_funcs->dpm_set_uvd_enable((smu), (enable)) : 0)
+#define smu_dpm_set_vcn_enable(smu, enable) \
+	((smu)->ppt_funcs->dpm_set_vcn_enable ? (smu)->ppt_funcs->dpm_set_vcn_enable((smu), (enable)) : 0)
 #define smu_dpm_set_jpeg_enable(smu, enable) \
 	((smu)->ppt_funcs->dpm_set_jpeg_enable ? (smu)->ppt_funcs->dpm_set_jpeg_enable((smu), (enable)) : 0)
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
