Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C96C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 04:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E68D560C41
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 04:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68D560C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B97B89D67;
	Tue, 23 Feb 2021 04:21:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75ACD89D67
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 04:21:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htSDCp/8Jr+yj7xRzzhHifXb8wEkaq+JtpYls34FyIWx7h0/VlOJnRf1WlYqsh+I2XPz5MIBKz0SdlUFsCzV4k6JNgQInCsmrBi387DUQCMHRP+NMRxU9DLfhVC/ARlRxd2/TP+fVCz1EKvzV1wEZaj4PpshtPodzbXm1L5znwm2MYE+pG5tNIqRYIaK3WRBG+h9PPvSGmGEQC6K9kWYf4yihSgHPKIMdk4q+buGqC6HvWQpLRgTTuE7HbfM9+fuqjj9I0gLI7eNKj39u5hY8+Mbvv7XyFPLL1zuYpQPNJwbD9PILVVMgYvsYp9jfJ13waMY9i5vziyJCYyZsdtb+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwvmY+K5QYHkYXAovDTWQ6UruSJNc8rjgiaAQNEv3s4=;
 b=O61evHaKxSTeRLI9yy/gb2v2OpojCeiw1Mxdi98o/ZQQRc9pZgJ6qMsl5/VeV5KvITOm90Fvf/6GatugwS+rJlbnIvoc6JVRG+xVamGT/T/xRF+H7i8GRVohvM/V7LNwulFoAKT3MRksUAZUJXYJCEYlX5OaiIASuuTmzZHI8rwlEExM5hRc5C3GzFm2SNRPdO9RDwXJbnPNVp86saXFh3u4YC7uprByZ3w9gKRLXY2w9aPctPRMDnTK60oVzYYFED6KkI5s6LkhWWDps6c1MnUJQCyUN8w+XlIUnRWxsiYkFVRzQ3RG969Xe8nlVkwboBzAXbsx5ejUT+9G2MSlQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwvmY+K5QYHkYXAovDTWQ6UruSJNc8rjgiaAQNEv3s4=;
 b=LBY7gXHLj5cCGoWqOrvmLx2K2g4wgBpbOuPcCatEUjEp8IcqDoL6BizZdmQ7UHfe1w+Rx77g3ao/M4furQzh7F0XkdXFkD5AUTSn0RjRid45SmDRXb2eFJG7ISd9Cf0RsBFnjKPtVxdqfsFfTiBaAh8lCC0j+q8iwwOAh1t2cGQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM6PR12MB4515.namprd12.prod.outlook.com (2603:10b6:5:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Tue, 23 Feb
 2021 04:21:40 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1%3]) with mapi id 15.20.3846.039; Tue, 23 Feb 2021
 04:21:39 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/8] amdgpu/pm: Powerplay API for smu ,
 changed 6 dpm reset functions to use API
Date: Mon, 22 Feb 2021 23:20:26 -0500
Message-Id: <20210223042032.3078-3-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223042032.3078-1-darren.powell@amd.com>
References: <20210223042032.3078-1-darren.powell@amd.com>
X-Originating-IP: [142.126.154.129]
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.154.129) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.30 via Frontend Transport; Tue, 23 Feb 2021 04:21:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2e395dda-2adc-4ed3-4c0e-08d8d7b28447
X-MS-TrafficTypeDiagnostic: DM6PR12MB4515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4515CDE4599E5A8585421300F0809@DM6PR12MB4515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cTx+6y/uLyIB/frTCskNKa73k1vTRrUu5wl/98O+1iHj3VRPZkTt06t7bVLBQzYp/pUN4uhHNplEWc5+8+BsHjfGW6/VFUAwM2OV/MTiRvu1YjhiBOi56PRKGnL371YfVFAKhbNJS6IecF3/R0fppKkAQlcu7KTYPA3onG4hXhjWNV79y/u5/AhPTgD2JPNrc3R1+oNn9C9whK78BOgr9W4vstGDVujtUUgzJ7m5A2ODLRrz/dQjhVpYAwoDKcFOhX822JjmywRK3+5Z6/9fZgU3GRwSj85arsgOnP2Vb62tEniHuZRCCHPnTbNC8luBn44i1Gj6LoPJ+5zTDnK+r8AXuYPoXhTiZrkoQYs8ITux0XQgz3juWTTbYBplZ3O5yPwDCzbzM9lZ2AVkqV0gBLF+Riqlu5J0WqN+TbY8x2Oq7gCUw8jxbrxfYEBtSmHO7mmcSj/Dph5VmrqTGnqHJn8d0Ssxeu47886jyjMt0Pd6AyF7XOs/TmMzRp0JfGplMUHbOqYt+QMapt44xM2FbhEYLaFlI8KUHOIwcF1GeN5p5xEaGLZCddv4/fSvkqOTsFDj9snFKwrLFIVGdbGYOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(83380400001)(26005)(86362001)(54906003)(52116002)(5660300002)(66476007)(6486002)(66946007)(66556008)(69590400012)(478600001)(36756003)(1076003)(16526019)(186003)(6512007)(2906002)(6506007)(6666004)(8936002)(4326008)(316002)(8676002)(44832011)(956004)(6916009)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gzLMsFUbRu9quqV9l16Y1bARDkmMUMaf9IeGaLSi14Buwqp0WK3YAGHmWoT2?=
 =?us-ascii?Q?yeUIqs9WluYnpXV6+t5kdA9Z5J87ftE3e29K6utwEt3R1zhGai3qpbFb1y7G?=
 =?us-ascii?Q?9AZTgjq09pGqUrl/1lLWTznVZuacBwjKoxC5ySYvDoObIYi0u82pS3mtOIiM?=
 =?us-ascii?Q?/Sdi5/hS+QvDeaJCcYM7+btLLhkGy+cpg9r9Ue5GI6Im9Wi+3sz7chtD9/Ea?=
 =?us-ascii?Q?PEa+kQQ2SapyvBX8q9xOaKEapxRDXGFBPgc0rsI00q563xFvcODgzez/VHni?=
 =?us-ascii?Q?N5YCy/R9yx8E9SkbOtQAfo8OCRkou8OtIkifSBqVBs5GdNGpNLrxwXLVBdcL?=
 =?us-ascii?Q?dWsvCVqPwMbhzhpEitG2fDdIE09mb/KRQ/BXGrrufwSRY+Gc9GcsGsOmdbt7?=
 =?us-ascii?Q?7D7bvQIsNbFw95mH0QNYw4NqBUfqGXT6CS/PXUyGbz9DSZKMV3f6Pmwy+Thu?=
 =?us-ascii?Q?mscYnhILl3FDFqBkTAWTz+23nXlXEDAbhYkE4LJCWA5V6uhVW2bya+kAPECY?=
 =?us-ascii?Q?RarU838VdiQBFzbPJn1B8YTjxqSG9jxBMTqjccnRy6IA9S9+lGrY/xtRTquJ?=
 =?us-ascii?Q?tKSBXvgZvfDDflPe0xnxmJt+vLUnd89Vtnzq0Zlm5f2zYEmD92/ApJ5TLB2t?=
 =?us-ascii?Q?Cp4JpWgDHf19Xkl8txO5Om1N8Tv0PVVoY92K3ATq6c/QGBkZLLY+M/YzHsF/?=
 =?us-ascii?Q?Cz8QTZ2fvg8isOjuOup7TOGVWeFecCd9EhK3eKTntATfB6kH+VQPJvDnfWWS?=
 =?us-ascii?Q?VyDivKO3nxEUme5A/94XQ0bhQ0WgJXQJQVIRyXPl8WgwRebP1L4UJfEpThTn?=
 =?us-ascii?Q?mofy+peID3qj9MSEwGQbhESVy2o4fIymmjU/geQF8dnEIJkEXKU2jc1CWEwZ?=
 =?us-ascii?Q?ibfTEuizhWN0bT0RVcHHmkOjnCVV624+P/RZr7rRLSbN2XsJEVvAvY0G/9sY?=
 =?us-ascii?Q?EjQ5VT+x2zltNsTAcgMvIFJJc8rVmORuwueltL+8tVFOsMCoHCEyqzRmvgZT?=
 =?us-ascii?Q?3xVKbClLiDdj5Ijpe2mRwsxbEK9U75MM4ua9yCsUpK4LaqyCqkgne95DM6EN?=
 =?us-ascii?Q?CU8zgQ1Hn7xa57GU0k1jj9RyXjOXn85dMuuUoBsbsolfodzYthWSecSyTpj5?=
 =?us-ascii?Q?nir3H16C6dd4WBAds8t7kwEUzLFCtQYU6X826tpQv4pHHscUjTFPkVuCGz+I?=
 =?us-ascii?Q?hi/kiiieEsyaYmrkCpu6ya05ULd9IMELklYUgR1LDmytJZMjVfX61ajzfelj?=
 =?us-ascii?Q?N6JNn3aZetb/r7hgGomz1CRYoonNdY8JTKhvnaRBqq+Zt/Pldmf7Im0DJ9hK?=
 =?us-ascii?Q?+Nca9FW/J4r44xIU4KnA93or?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e395dda-2adc-4ed3-4c0e-08d8d7b28447
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 04:21:39.8679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wtaJrxYJaNrcMEjc/Ijb2NohHmO7zLsoqTcjWozAjiOvk5/11//huza9iGxig51Hw4wSOV0zSFOfYCV28EOZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4515
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Darren Powell <darren.powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Modified Functions
  smu_set_xgmi_pstate()       - modifed arg0 to match Powerplay API set_xgmi_pstate
  smu_mode2_reset()           - modifed arg0 to match Powerplay API asic_reset_mode_2
  smu_switch_power_profile()  - modifed arg0 to match Powerplay API switch_power_profile
  smu_set_mp1_state()         - modifed arg0 to match Powerplay API set_mp1_state
  smu_set_df_cstate()         - modifed arg0 to match Powerplay API set_df_cstate
  smu_enable_mgpu_fan_boost() - modifed arg0 to match Powerplay API enable_mgpu_fan_boost

Other Changes
  added above smu reset Powerplay functions to swsmu_dpm_funcs
  removed special smu handling of above functions and called through Powerplay API

Signed-off-by: Darren Powell <darren.powell@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c       | 46 +++++++----------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   | 12 +++---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 27 ++++++++++---
 3 files changed, 41 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 8fb12afe3c96..df5e7b573428 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1059,12 +1059,10 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
 			     enum pp_mp1_state mp1_state)
 {
 	int ret = 0;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	if (is_support_sw_smu(adev)) {
-		ret = smu_set_mp1_state(&adev->smu, mp1_state);
-	} else if (adev->powerplay.pp_funcs &&
-		   adev->powerplay.pp_funcs->set_mp1_state) {
-		ret = adev->powerplay.pp_funcs->set_mp1_state(
+	if (pp_funcs && pp_funcs->set_mp1_state) {
+		ret = pp_funcs->set_mp1_state(
 				adev->powerplay.pp_handle,
 				mp1_state);
 	}
@@ -1096,16 +1094,11 @@ int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	void *pp_handle = adev->powerplay.pp_handle;
-	struct smu_context *smu = &adev->smu;
 
-	if (is_support_sw_smu(adev)) {
-		return smu_mode2_reset(smu);
-	} else {
-		if (!pp_funcs || !pp_funcs->asic_reset_mode_2)
-			return -ENOENT;
+	if (!pp_funcs || !pp_funcs->asic_reset_mode_2)
+		return -ENOENT;
 
-		return pp_funcs->asic_reset_mode_2(pp_handle);
-	}
+	return pp_funcs->asic_reset_mode_2(pp_handle);
 }
 
 int amdgpu_dpm_baco_reset(struct amdgpu_device *adev)
@@ -1166,16 +1159,14 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 				    enum PP_SMC_POWER_PROFILE type,
 				    bool en)
 {
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int ret = 0;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if (is_support_sw_smu(adev))
-		ret = smu_switch_power_profile(&adev->smu, type, en);
-	else if (adev->powerplay.pp_funcs &&
-		 adev->powerplay.pp_funcs->switch_power_profile)
-		ret = adev->powerplay.pp_funcs->switch_power_profile(
+	if (pp_funcs && pp_funcs->switch_power_profile)
+		ret = pp_funcs->switch_power_profile(
 			adev->powerplay.pp_handle, type, en);
 
 	return ret;
@@ -1184,13 +1175,11 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_device *adev,
 			       uint32_t pstate)
 {
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int ret = 0;
 
-	if (is_support_sw_smu(adev))
-		ret = smu_set_xgmi_pstate(&adev->smu, pstate);
-	else if (adev->powerplay.pp_funcs &&
-		 adev->powerplay.pp_funcs->set_xgmi_pstate)
-		ret = adev->powerplay.pp_funcs->set_xgmi_pstate(adev->powerplay.pp_handle,
+	if (pp_funcs && pp_funcs->set_xgmi_pstate)
+		ret = pp_funcs->set_xgmi_pstate(adev->powerplay.pp_handle,
 								pstate);
 
 	return ret;
@@ -1202,12 +1191,8 @@ int amdgpu_dpm_set_df_cstate(struct amdgpu_device *adev,
 	int ret = 0;
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	void *pp_handle = adev->powerplay.pp_handle;
-	struct smu_context *smu = &adev->smu;
 
-	if (is_support_sw_smu(adev))
-		ret = smu_set_df_cstate(smu, cstate);
-	else if (pp_funcs &&
-		 pp_funcs->set_df_cstate)
+	if (pp_funcs && pp_funcs->set_df_cstate)
 		ret = pp_funcs->set_df_cstate(pp_handle, cstate);
 
 	return ret;
@@ -1228,12 +1213,9 @@ int amdgpu_dpm_enable_mgpu_fan_boost(struct amdgpu_device *adev)
 	void *pp_handle = adev->powerplay.pp_handle;
 	const struct amd_pm_funcs *pp_funcs =
 			adev->powerplay.pp_funcs;
-	struct smu_context *smu = &adev->smu;
 	int ret = 0;
 
-	if (is_support_sw_smu(adev))
-		ret = smu_enable_mgpu_fan_boost(smu);
-	else if (pp_funcs && pp_funcs->enable_mgpu_fan_boost)
+	if (pp_funcs && pp_funcs->enable_mgpu_fan_boost)
 		ret = pp_funcs->enable_mgpu_fan_boost(pp_handle);
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index f41be47fb125..d96692d9e794 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1271,7 +1271,7 @@ int smu_display_clock_voltage_request(struct smu_context *smu,
 				      struct pp_display_clock_request *clock_req);
 int smu_display_disable_memory_clock_switch(struct smu_context *smu, bool disable_memory_clock_switch);
 
-int smu_set_xgmi_pstate(struct smu_context *smu,
+int smu_set_xgmi_pstate(void *handle,
 			uint32_t pstate);
 
 int smu_set_azalia_d3_pme(struct smu_context *smu);
@@ -1285,7 +1285,7 @@ int smu_baco_exit(struct smu_context *smu);
 
 bool smu_mode1_reset_is_support(struct smu_context *smu);
 int smu_mode1_reset(struct smu_context *smu);
-int smu_mode2_reset(struct smu_context *smu);
+int smu_mode2_reset(void *handle);
 
 extern const struct amd_ip_funcs smu_ip_funcs;
 
@@ -1313,7 +1313,7 @@ extern int smu_handle_task(struct smu_context *smu,
 			   enum amd_dpm_forced_level level,
 			   enum amd_pp_task task_id,
 			   bool lock_needed);
-int smu_switch_power_profile(struct smu_context *smu,
+int smu_switch_power_profile(void *handle,
 			     enum PP_SMC_POWER_PROFILE type,
 			     bool en);
 int smu_get_dpm_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
@@ -1329,9 +1329,9 @@ int smu_sys_set_pp_feature_mask(struct smu_context *smu, uint64_t new_mask);
 int smu_force_clk_levels(struct smu_context *smu,
 			 enum smu_clk_type clk_type,
 			 uint32_t mask);
-int smu_set_mp1_state(struct smu_context *smu,
+int smu_set_mp1_state(void *handle,
 		      enum pp_mp1_state mp1_state);
-int smu_set_df_cstate(struct smu_context *smu,
+int smu_set_df_cstate(void *handle,
 		      enum pp_df_cstate state);
 int smu_allow_xgmi_power_down(struct smu_context *smu, bool en);
 
@@ -1349,7 +1349,7 @@ int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);
 
 ssize_t smu_sys_get_gpu_metrics(struct smu_context *smu, void **table);
 
-int smu_enable_mgpu_fan_boost(struct smu_context *smu);
+int smu_enable_mgpu_fan_boost(void *handle);
 int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state);
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 1c77444c75b5..ef1dfd1bb294 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1660,10 +1660,11 @@ int smu_handle_task(struct smu_context *smu,
 	return ret;
 }
 
-int smu_switch_power_profile(struct smu_context *smu,
+int smu_switch_power_profile(void *handle,
 			     enum PP_SMC_POWER_PROFILE type,
 			     bool en)
 {
+	struct smu_context *smu = handle;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 	long workload;
 	uint32_t index;
@@ -1800,9 +1801,10 @@ int smu_force_clk_levels(struct smu_context *smu,
  * However, the mp1 state setting should still be granted
  * even if the dpm_enabled cleared.
  */
-int smu_set_mp1_state(struct smu_context *smu,
+int smu_set_mp1_state(void *handle,
 		      enum pp_mp1_state mp1_state)
 {
+	struct smu_context *smu = handle;
 	uint16_t msg;
 	int ret;
 
@@ -1839,9 +1841,10 @@ int smu_set_mp1_state(struct smu_context *smu,
 	return ret;
 }
 
-int smu_set_df_cstate(struct smu_context *smu,
+int smu_set_df_cstate(void *handle,
 		      enum pp_df_cstate state)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2440,9 +2443,10 @@ int smu_display_disable_memory_clock_switch(struct smu_context *smu, bool disabl
 	return ret;
 }
 
-int smu_set_xgmi_pstate(struct smu_context *smu,
+int smu_set_xgmi_pstate(void *handle,
 			uint32_t pstate)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2589,8 +2593,9 @@ int smu_mode1_reset(struct smu_context *smu)
 	return ret;
 }
 
-int smu_mode2_reset(struct smu_context *smu)
+int smu_mode2_reset(void *handle)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled)
@@ -2701,8 +2706,9 @@ ssize_t smu_sys_get_gpu_metrics(struct smu_context *smu,
 	return size;
 }
 
-int smu_enable_mgpu_fan_boost(struct smu_context *smu)
+int smu_enable_mgpu_fan_boost(void *handle)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2731,5 +2737,14 @@ int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state)
 }
 
 static const struct amd_pm_funcs swsmu_pm_funcs = {
+	/* export for sysfs */
 	.get_performance_level = smu_get_performance_level,
+	.switch_power_profile  = smu_switch_power_profile,
+	/* export to amdgpu */
+	.set_mp1_state         = smu_set_mp1_state,
+	/* export to DC */
+	.enable_mgpu_fan_boost = smu_enable_mgpu_fan_boost,
+	.asic_reset_mode_2     = smu_mode2_reset,
+	.set_df_cstate         = smu_set_df_cstate,
+	.set_xgmi_pstate       = smu_set_xgmi_pstate,
 };
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
