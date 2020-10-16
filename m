Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BFAC43457
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB554206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EBsjG55E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB554206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9025F6EA83;
	Fri, 16 Oct 2020 03:28:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD42B6EA83
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:28:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYcyM1IlNH3PXQTsikTahnCsOB+ri2I+TTPP3KUZdNTWc71CADVRLMUoLaNTaUtfdC9hiuJf9Kiz4J0cZFOckuqNHsaF7PBUfxnT/NVTakDexMv4bJPmpuLEQbEcAwdHg/srkZMLSXIRmf3qTB23qndq1silFCuNLuvFVyh/2q9POslCW30eU4ml5AbvrnQhufTC4DLoWcK5prWiUUi7ST8KLOOnSCYY8KUiNOTUyQQwBWtDHfLZzg56slbOvy7bh69pmQoV4KYyc9wSdc6gjH0mfwdTegV5EoXc57vYcW63MEGY+ELIBxsyhNTzt4Oh/ntUwdhm93RWP4H5UteQ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xyf66shcAw2tRBCTvOXnYm3mh/sLkEbIr4jkmLg6HiY=;
 b=l9TPluf3OLsaC996+sJD4ytWgL4ifAwx9bE+/DTCKi6YcCft+Ygdtj5OHGX/Qbcq7yEZqQCavqMD3+dHYpQe3FvKhIrY1JLXIy4Bhx5dnXk+xZbUWzOIrs+fYHdERsRkSrR6qNg1sj/3exIrUs+R1S2NHUOp0PUxDbsZnD9DLRkD6mTVfydElZ6przNQ97tnC2XEBGa7QQqaMDp9bAuJdHs8uaugbY6YMuCGLfpjZepKFqhBPYXUVCR+hKIadTjDKByS/+TaGozFi8gDtdxMIn27U3I/TOAXOyRqXQ1yeLkbdmzz6nHkUY891x9a1iPuB24X8WQZD0MRS2MRgXqGaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xyf66shcAw2tRBCTvOXnYm3mh/sLkEbIr4jkmLg6HiY=;
 b=EBsjG55EOpGL8q1o83vV8wtFZfZiIpCj+JqetJ0T35tq56WjUQPOuOyRsPBVaBOY0uqpHGSU0wos4txJ3tBmwpEutCRu6mVnEfvPqv//1nVpj9zPAVIHKhDesgYDEjcVinCPyBua+XPhCsx//G9TogOY9OdLQ6ySFqdvt0l1JiI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:28:18 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:28:18 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 26/40] drm/amd/pm: correct vddc phase control setting
Date: Fri, 16 Oct 2020 11:26:38 +0800
Message-Id: <20201016032652.507-27-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:28:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 72b1a35a-268c-4e32-6940-08d871838661
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1354BE7E7BDA9AE0C61DCA87E4030@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:142;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gYzLiIKYI6sFz0mdhM3ug4dOfLQPUNARsFR9eQjKtxKVBgvCIa0x2RrWcHg1y+BdhcUS6bZV45jQdaO5pgYTer8syM8uA8SHldMKmP40waotQsa5Bm4JDLJ9s7KipJWUAEYs9bdVzdR77Jd6ve287+A0wbZIzMyBILdEp7fwK8ID4gsbpwVL9oQuu7SGtozvJlO0MYEqkzP8Uh3xNzC8egZ5aeBT9X0GcSoopdnKkOChZO1B4XHZ9U5e9q4q+Kf/NCK3lynh9+myp52VDdXbU//WyCmgNaBkYkXbAeERwAlVX0nXwPLpCmCyWIyucwdId/lt+Qd5cMtNPltbswhtL/eBEPi1zJ3L8E7n8w1aJrvtobAfmo/xJBrHi+60bwU8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66476007)(66946007)(83380400001)(1076003)(8676002)(6486002)(5660300002)(8936002)(66556008)(6916009)(86362001)(52116002)(36756003)(7696005)(4326008)(2616005)(34490700002)(478600001)(316002)(6666004)(44832011)(16526019)(186003)(54906003)(2906002)(26005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: WFSaQJ3rk614pOZUFURqXyWDbQu+oQVMMGxaCLzxLbena/ylEAMaXPzXmpcI/VkLuN07cC+jFHRu2wG6gBpI8fAYdHvVsHEzJPyZdeQDaRUv9LCqGnB/TDlajWJm6BdC1rrSBlpkgBRR2XulAmyX76IEOGOhH0ZFWj3+X1YE0kOyn05CMzkQwrUr8PXMnpPnahILy3QnsVxN26kLApIsETaPT+ZMDqI5HzkKC07gpshB7Ugr4/9AYSXR/buIb3xrndxva9n7m4V2wLE8zfvXCH8pHX5X8V3Atd+oRBdUnb/pzQ85/GWe0uWEltTKZ+RDft2cmizRAmajH5N1NyEH0P0QcDrSEexnWpRDXyDEnlxZC2nd//9Y0zaJNqKL1MhExjGKC1WNRaoGdR8Xi5suDatXQZ17JJ159rcMxKMM6GUzY1z3EERxhCoBy8xcjOiO6Ui3ztYRQxfqGwqecN2E8W+zO+tgCgMw9dgelqhcOmqpg6skOBJlbPj2cwoiX0MBTgyKOb1EaKiFsaD+bO14hRx7EYCXT+i5JmPwK00dIKs7PW6phu1SKMoRu9v6pZEcg9fudJS0RgmzRj8jxg3TrXFDUKTWDAsbDfPfOXPyhTRkeHPBRgaw/Bbt+mGm9g86Ba3dNDMJ2yZZGytWZEy7qg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b1a35a-268c-4e32-6940-08d871838661
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:28:18.3759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5ex1+y5UFz9TSddz74rc1fIn4/VUB0PoCWK31mehzwhfJrdR4kiwP9de+LXx5O6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct Polaris10 vddc phase control.

Change-Id: I182bc46adb7900cad243eb3906450d86ae41975e
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 31 +++++++++++--------
 .../pm/powerplay/smumgr/polaris10_smumgr.c    |  7 ++++-
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 03a139f2c426..79dea9329b2a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -1664,6 +1664,8 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 	struct phm_ppt_v1_information *table_info =
 			(struct phm_ppt_v1_information *)(hwmgr->pptable);
 	struct amdgpu_device *adev = hwmgr->adev;
+	uint8_t tmp1, tmp2;
+	uint16_t tmp3 = 0;
 
 	data->dll_default_on = false;
 	data->mclk_dpm0_activity_target = 0xa;
@@ -1712,19 +1714,6 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 	hwmgr->power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
 	hwmgr->default_power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
 
-	if (hwmgr->chip_id == CHIP_POLARIS12 || hwmgr->is_kicker) {
-		uint8_t tmp1, tmp2;
-		uint16_t tmp3 = 0;
-		atomctrl_get_svi2_info(hwmgr, VOLTAGE_TYPE_VDDC, &tmp1, &tmp2,
-						&tmp3);
-		tmp3 = (tmp3 >> 5) & 0x3;
-		data->vddc_phase_shed_control = ((tmp3 << 1) | (tmp3 >> 1)) & 0x3;
-	} else if (hwmgr->chip_family == AMDGPU_FAMILY_CI) {
-		data->vddc_phase_shed_control = 1;
-	} else {
-		data->vddc_phase_shed_control = 0;
-	}
-
 	if (hwmgr->chip_id  == CHIP_HAWAII) {
 		data->thermal_temp_setting.temperature_low = 94500;
 		data->thermal_temp_setting.temperature_high = 95000;
@@ -1783,6 +1772,22 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 		phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
 				PHM_PlatformCaps_ControlVDDCI);
 
+	data->vddc_phase_shed_control = 1;
+	if ((hwmgr->chip_id == CHIP_POLARIS12) ||
+	    ASICID_IS_P20(adev->pdev->device, adev->pdev->revision) ||
+	    ASICID_IS_P21(adev->pdev->device, adev->pdev->revision) ||
+	    ASICID_IS_P30(adev->pdev->device, adev->pdev->revision) ||
+	    ASICID_IS_P31(adev->pdev->device, adev->pdev->revision)) {
+		if (data->voltage_control == SMU7_VOLTAGE_CONTROL_BY_SVID2) {
+			atomctrl_get_svi2_info(hwmgr, VOLTAGE_TYPE_VDDC, &tmp1, &tmp2,
+							&tmp3);
+			tmp3 = (tmp3 >> 5) & 0x3;
+			data->vddc_phase_shed_control = ((tmp3 << 1) | (tmp3 >> 1)) & 0x3;
+		}
+	} else if (hwmgr->chip_family == AMDGPU_FAMILY_CI) {
+		data->vddc_phase_shed_control = 1;
+	}
+
 	if ((hwmgr->pp_table_version != PP_TABLE_V0) && (hwmgr->feature_mask & PP_CLOCK_STRETCH_MASK)
 		&& (table_info->cac_dtp_table->usClockStretchAmount != 0))
 		phm_cap_set(hwmgr->platform_descriptor.platformCaps,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index 46c82bfa793c..72ca4bd2c2f3 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -779,6 +779,7 @@ static int polaris10_populate_ulv_level(struct pp_hwmgr *hwmgr,
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
 	struct phm_ppt_v1_information *table_info =
 			(struct phm_ppt_v1_information *)(hwmgr->pptable);
+	struct amdgpu_device *adev = hwmgr->adev;
 
 	state->CcPwrDynRm = 0;
 	state->CcPwrDynRm1 = 0;
@@ -787,7 +788,11 @@ static int polaris10_populate_ulv_level(struct pp_hwmgr *hwmgr,
 	state->VddcOffsetVid = (uint8_t)(table_info->us_ulv_voltage_offset *
 			VOLTAGE_VID_OFFSET_SCALE2 / VOLTAGE_VID_OFFSET_SCALE1);
 
-	if (hwmgr->chip_id == CHIP_POLARIS12 || hwmgr->is_kicker)
+	if ((hwmgr->chip_id == CHIP_POLARIS12) ||
+	    ASICID_IS_P20(adev->pdev->device, adev->pdev->revision) ||
+	    ASICID_IS_P21(adev->pdev->device, adev->pdev->revision) ||
+	    ASICID_IS_P30(adev->pdev->device, adev->pdev->revision) ||
+	    ASICID_IS_P31(adev->pdev->device, adev->pdev->revision))
 		state->VddcPhase = data->vddc_phase_shed_control ^ 0x3;
 	else
 		state->VddcPhase = (data->vddc_phase_shed_control) ? 0 : 1;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
