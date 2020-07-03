Return-Path: <SRS0=khk6=AO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D86C433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:34:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14992207FF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MDzvp1wp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14992207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3CB16EABD;
	Fri,  3 Jul 2020 08:34:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9C166EABD
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 08:34:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/NKNO25XToHwZMmAi1N/Om4He/Ty5LSlLGGPlUgKp8kUzD12QVlzWhui1gt9WOP1Vm/3dhD1CUBosecTTeI5MJbuUo23AoZlHeUWz6wZMXtwEHnQ23oWSrYCowPGjr2lNzqEyZxqX10QTgmMH4xtF9amQ75Lhizag9uM35jR7ycQX6+2MIG9fe8CCZXxPzUv2C9sSGWZ0wjLMNc5JKSG40bNFg9iyZRXHcc/8kvIFvYaQfYUkjHLgO6iOhZ6+pAzfUliluaTQH8sppUOziik/CgO5XyPsjMEIusGMqROq9tRngnaaVcGcBYkDpsVVI5vxTG1PM0g9EA1Jo0FXyynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hl8s4ZmQTfS12bbiku9riDD+IbyosljINY3Cn3z3b4M=;
 b=Gop6b0sMVVtYKjCOs4dHeVvtMSh0d024ONxWbm6I78f1TgNtpXX1jSATYP2DvJ50DU8vZGoc5i1mLRRQH14niT0QJ++8VR47pOo8RFfXMG2FlXK2BujtvukTWd1W/7O/slzRyLJcRtteEOy48kAOf2MYsn0cN1QFAgMyRaeqN+8ud8i1i4anzoc/qlFVkECwrW1MaRZBFZ/bx1vWU+3ccm8xb+VFQkT6NswNd1vHWqz4KDwz38JrWgXdd8YXaAgRrPbP9o3q+3sBcB88NjKkrNI/suURKGfKYitFBAU/LwxrzZSdFre7o27kTU/kiE04IMQJFBn/vEJzB+JqUzhIUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hl8s4ZmQTfS12bbiku9riDD+IbyosljINY3Cn3z3b4M=;
 b=MDzvp1wpMVaTAkS5Ne2CCW5g2bEXg2+HRiD9d5jrnBnGlK6h0uFhU9CuHBpEV08HZjYw70ikRl0Yd9kAWUpJOps5OLzznGnkB/TLLSM0gDOAiIOQo29EY18Acn2rvJqzogetMdFPkuLmzgyZEIy6rvgXu+dL/yNmvS1hWiN50ck=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.27; Fri, 3 Jul 2020 08:34:04 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 08:34:04 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/14] drm/amd/powerplay: drop Sienna Cichlid specific
 set_soft_freq_limited_range
Date: Fri,  3 Jul 2020 16:33:00 +0800
Message-Id: <20200703083303.478-11-evan.quan@amd.com>
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
 15.20.3153.22 via Frontend Transport; Fri, 3 Jul 2020 08:34:03 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b300efa9-391b-432d-2db6-08d81f2bd81c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3962066C9CB32BCC9D3A7A0FE46A0@DM6PR12MB3962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BkUhgD3nIZxz2EFOx38N0660Z9Qb1PlpWCYnmj9ZGAyamdFwawXcpE9GHwRuZqJhpChdce3aKaDlcrZ+f7zAHjdVlW+K+ejAJuhcjY9c1ncfQJb1w11Z/4/u/Rj0u078FcJIgflfTk77kmtoHu0/2PNV2NYC47dZg3d7ACmwjJr1RU4ZsjLH1njxUz8bXCehuTU5zPIcGpi+xqCPW0WyfUCfvnpcezYGTcUSbpygPZiNQH88aRzehyV8Zatu/Z96B0G8EVX4/EUmnUs2AU4C+UTaXNXxnjr1lQpp90X8j37ducMjARbvjcGxjAOVAfmdwsmEbPQ6qHOlehckTAtaBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(83380400001)(44832011)(4326008)(36756003)(8936002)(7696005)(956004)(2616005)(6486002)(52116002)(478600001)(66946007)(16526019)(26005)(186003)(66476007)(5660300002)(1076003)(66556008)(8676002)(316002)(86362001)(6916009)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Sypswj68+ulYUxKTvmc+SKwoBzPvZ2jmkk2R1+DBn1hXt+v7bLLErjaM0pL6oIHPXGUIZgVL7SPKpeouPLEXNtNl9eqX2sNP05uTAKyqk7opIOpRhiWHOALiIKXVxR7SL17dH8J5vxQCjDlXFSQ4CREfUIO21fRv+d/HiPh1RJWYGQaw+hRJCNOuDJBKcgKw32MxWNCs5dBjOcCt2sZAwZ/wW8jpwTgJ6tYvtDKprnrPIbsF1Ac2gEWZQ6Bn/pf/58cEQueAgfS+AQrtbArViLotaAHF28CbkVzDscxc+3XJB7AUfLptLBSkalEv4vPL4Tqo9oWP++b3zT+FGhkPuKNWlrX7r2bBBBHARvygFbhoCpy+igWlC5Gr00zT6vBklPxoeBFC1lvdL/9aL2VUPGW9HEqhVmncRqav/BHeAjJP+ROFE6CRNgLdMfSeSukISSSYl90KNr7BeVo/oo8yG1nzHPEt/KmijjTkLQhwX+xOkrQw9iYkvWILp88rb3rQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b300efa9-391b-432d-2db6-08d81f2bd81c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:34:04.4974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3abu9Hw/+5Ujn2lk1mJRzmaqyzIhms09zbFdcg5Lm/K1Ul+D50YaTv+zHczJC83
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
index 8fbfa0562007..1b357e349d1e 100644
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
index c2564df304f7..1ed5ac946c05 100644
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
