Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0461C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81B0720720
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aLk78SWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B0720720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5205D6EB6C;
	Fri, 10 Jul 2020 04:48:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A80346EB68
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 04:48:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlgXppVMe2Bj3IanQCc4p5PSprRAWcXLvjwQ8ogh25owcFWkm+oPxe58H9TxED3IPoNS0WdsuAI9Kqi1hiC0HME8VT7E24eV8FrSsxPCa1uW/+OU67P0KfrCAEymECi4ukVehBr+xjtYLl8sGED93ELXXFKwUc2S7xCyz69AFDbmNTDghiO4uuwBXMTUHzszPY2Ra/NnkOYGk0D+Sd5RP1JZe3AhUQvImQldarEfEluyZlq8ygFzTM+i2C3dn4GVtldK8uWMmVCXiG/yfE9c+mE08stxRqxPR7Yi0VqQuMrx+Qnn2dIVSodvqlaVoLJLpnOsEL+SXIEz1WrUa9od6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nxwHbgHNtS1viCALvKdE/xzaEsmFVTkLWLyd5HMXQY=;
 b=UbtCGNHhoG0xWayGmgrHXpt1y7c4ccRrSjtqji1pJ5hoCYl5gqLzcQvMSK6x06fBJ5TgyE6vFv6qY1X+80hdX0UvGG+XkLYHZc8weVuCq1mxZt8KaYFP3PRK2Lre4CFs11qc/4TaAs0FeZ9gXYrnayitQ0C2Wx+LdOqNeBXWDk2zQRInnFeoKoBujp06efu6P2iaBonai7/yuW7MYVwxsykHjD0wqlvXw9k/ZsVaOPife2St8RAcL2LU8YW9VPHiP5fRWJ2ZmjHZ21KiN7dG4p3QiZ7OBiWxdFBENUVLmtvGlt+nhvWi7XAXAnC89hwCVPrjIJ3RuZ756CVAZTjDTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nxwHbgHNtS1viCALvKdE/xzaEsmFVTkLWLyd5HMXQY=;
 b=aLk78SWq5wHmqTTosgvll2oz4OnOpCNUy6Pf+8wu4hcId6VJADAh/Am/WlW/4IlcCuVboKhpK2xCRSymlVVSWFrQIaMbbqAV9j0JmNy/98R6Seq02bDdv05bioe3/e9sRK/h8dNG8UUaluBNTX3dZ0UcwTlwo9dFxlQxOe6aBVE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Fri, 10 Jul 2020 04:48:30 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 04:48:30 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/16] drm/amd/powerplay: drop Sienna Cichlid specific
 set_soft_freq_limited_range
Date: Fri, 10 Jul 2020 12:47:42 +0800
Message-Id: <20200710044746.23538-12-evan.quan@amd.com>
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
 15.20.3195.9 via Frontend Transport; Fri, 10 Jul 2020 04:48:28 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 81dcbee8-88bc-4864-ddd3-08d8248c7dde
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB23602A1CFC26B50CC0531691E4650@DM5PR12MB2360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4STtBz+73ZCV7ff5n1ZEsZDPiBFJ3HUFFL2On/nDeWzgxrRLCPCVmEsUqxTTIH+2dFhiN6IR1LB1pma2pbj0kp7/q4SBn5wQ2jpsywWBj4t1pW+4HybzHlvVCxeUJtWZ5PfggZN3MTjUD7Twjrg8V0fs/O0Lq2MYowWTLLCIibESsxJLVrrzoo6AmqT2yGXBILbjD9IfpxbNcCMiApKl30PuiN82xIzbFVIdJ2PKkBTf2qeiZG0sjBf37MSz3TPPb72IAm4KNXwNyBta4ZaAwIoBVaFoBVGzeSI9UvCghgh8y7eZV1y9HKjT1RFThCV99DD3iX9xQuwAth/6mqOvzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(2906002)(4326008)(8676002)(8936002)(83380400001)(6486002)(44832011)(7696005)(52116002)(186003)(16526019)(956004)(2616005)(26005)(6916009)(316002)(478600001)(86362001)(6666004)(5660300002)(66556008)(1076003)(66476007)(36756003)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Ujix9NRwPyAactOpnstz3h180ZYXxcGRoq4chWMx7FjKZMFgTG0zSWdz6y9uDrHXQ5SnxPrVQITIzSOiLlNi4tp2iNThUpI+FdvIf7upCQ1+x1vrPSRyaZ+imTQh6epcJGWvwN7yiLmzGLOFdVFQEGNdKsMPm9+W3104mxMaBleSOiGlHrhjgORyfQNKaqx0MsG1zMfO5m1Nh6flshdT4Gh5MkM6ufCTusDA1Y4njE33+j31WMLQcAoX2XADsb2M+E4h3Qj/9W2snKctx0G1y/flbEuf07a8F0mJjdpurEAlx6CkOh7HV6jNvSS3WcB1KnMmgrXR3RAHulhjCX8Bu9rjPuasKP4Hj8QLZtUmsV4hT50wUYMxtgm16603y2ToiZnhMouGSdKovOWc0Sk1MRuqJLj6lj9JBCzgAPCZckUHgjCWix7dlQ2pfxmNtWql0Q5LPbE+NHGlOS0ieO1NlFMSnNarPBsRL2tztrBd0d2GISY56ACUJVLbM0KfcL4L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81dcbee8-88bc-4864-ddd3-08d8248c7dde
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 04:48:30.1073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V245LnF1TZZwl+VnYOtLHoYHcrY3qDJPmPr+JEL4FEakQ61qtbUhX0b6u27+It5K
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

Use the common smu_v11_0_set_soft_freq_limited_range.

Change-Id: I9f8772880b324ce9e741291751bb1b8ff4c36ea3
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 20 ++-----------------
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  1 -
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 20 +++++++++++++++----
 3 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 27f77bde184f..141944df97b0 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -1046,22 +1046,6 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	return size;
 }
 
-int sienna_cichlid_set_soft_freq_limited_range(struct smu_context *smu,
-				      enum smu_clk_type clk_type,
-				      uint32_t min, uint32_t max)
-{
-	struct amdgpu_device *adev = smu->adev;
-	int ret;
-
-	if (clk_type == SMU_GFXCLK)
-		amdgpu_gfx_off_ctrl(adev, false);
-	ret = smu_v11_0_set_soft_freq_limited_range(smu, clk_type, min, max);
-	if (clk_type == SMU_GFXCLK)
-		amdgpu_gfx_off_ctrl(adev, true);
-
-	return ret;
-}
-
 static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 				   enum smu_clk_type clk_type, uint32_t mask)
 {
@@ -1097,7 +1081,7 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
 		if (ret)
 			goto forec_level_out;
 
-		ret = sienna_cichlid_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq);
+		ret = smu_v11_0_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq);
 		if (ret)
 			goto forec_level_out;
 		break;
@@ -2566,7 +2550,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.baco_enter = smu_v11_0_baco_enter,
 	.baco_exit = smu_v11_0_baco_exit,
 	.get_dpm_ultimate_freq = sienna_cichlid_get_dpm_ultimate_freq,
-	.set_soft_freq_limited_range = sienna_cichlid_set_soft_freq_limited_range,
+	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
 	.override_pcie_parameters = smu_v11_0_override_pcie_parameters,
 	.set_thermal_range = sienna_cichlid_set_thermal_range,
 };
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 1c808ffe3ab1..91d3965bbe80 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -93,7 +93,6 @@
 #define smu_asic_set_performance_level(smu, level)			smu_ppt_funcs(set_performance_level, -EINVAL, smu, level)
 #define smu_dump_pptable(smu)						smu_ppt_funcs(dump_pptable, 0, smu)
 #define smu_get_dpm_clk_limited(smu, clk_type, dpm_level, freq)		smu_ppt_funcs(get_dpm_clk_limited, -EINVAL, smu, clk_type, dpm_level, freq)
-#define smu_set_soft_freq_limited_range(smu, clk_type, min, max)	smu_ppt_funcs(set_soft_freq_limited_range, -EINVAL, smu, clk_type, min, max)
 #define smu_override_pcie_parameters(smu)				smu_ppt_funcs(override_pcie_parameters, 0, smu)
 #define smu_update_pcie_parameters(smu, pcie_gen_cap, pcie_width_cap)	smu_ppt_funcs(update_pcie_parameters, 0, smu, pcie_gen_cap, pcie_width_cap)
 #define smu_set_thermal_range(smu, range)				smu_ppt_funcs(set_thermal_range, 0, smu, range)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index f96ff062eb64..c2779d0b51f6 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1745,9 +1745,12 @@ int smu_v11_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type c
 	return ret;
 }
 
-int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_type clk_type,
-			    uint32_t min, uint32_t max)
+int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
+					  enum smu_clk_type clk_type,
+					  uint32_t min,
+					  uint32_t max)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, clk_id = 0;
 	uint32_t param;
 
@@ -1755,12 +1758,16 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
 	if (clk_id < 0)
 		return clk_id;
 
+	if (clk_type == SMU_GFXCLK &&
+	    adev->asic_type == CHIP_SIENNA_CICHLID)
+		amdgpu_gfx_off_ctrl(adev, false);
+
 	if (max > 0) {
 		param = (uint32_t)((clk_id << 16) | (max & 0xffff));
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxByFreq,
 						  param, NULL);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	if (min > 0) {
@@ -1768,9 +1775,14 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinByFreq,
 						  param, NULL);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
+out:
+	if (clk_type == SMU_GFXCLK &&
+	    adev->asic_type == CHIP_SIENNA_CICHLID)
+		amdgpu_gfx_off_ctrl(adev, true);
+
 	return ret;
 }
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
