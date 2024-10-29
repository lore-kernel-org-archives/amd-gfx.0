Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED32D3A679
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 17:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76D2F10E39C;
	Tue, 29 Oct 2024 17:43:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="elxZAvtr";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E29210E39A
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 17:43:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvRUDjC4wp7YRX49jMJHnXy1VjFufCxK2SP2r6X06hMCBjFPA8wDhMd3X84y75wAKVApdcqhjdtzv/ZoyTS78uXNXQOQjz2fiD3woLMzPCFwkm7gxjL/EqoN6bDh8Lvwhxpg/8B9M38McAJXFRVLV8+VubpX31ghkrjUhJ78pevkNHHfYwdAOSqXZ37eLlX0FFqPRRDEAcg1J+cdKvOfKle4v7RbMM722MMKMUgoYA8959VIDNU6z/JD2Sa0aFnUUC0fBB+207ACcsPiL4bPKGouq9FM/TdMfH9UIjVr/ipzGpiFI9A9gynYxMAJoKlHlskcQ4h7agFJvMzxVsnWNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GA1Ss7xzB4ufu0EzHfy3209C6IIEmTypdEP9V7lp+VQ=;
 b=mWgCGISh2v58gc1SCGv62SXEsVD2puxU+TUIyvGsVMsf9mnPNFBF4w4FeK+1uEhiwOYl/LuQcBI/Wnw8DF9+ndKA2Jdhq5/gymqqzRcjTqmNEkvtj98OFtEBYrMqpefr4ZYHlwgtkd6DQQuXP5jnxIrIQk0crSO6G+F6jTxjmNqj9ahNwQxws5znnqqzJ1NzmkMqCiX4hBwLmrReAmEakrR60K4JVDcmrKntgX13PNCxCF1BvtMd6ro7r6A64ZYlqFMsCSzDtuk51JM6i9j9hVbD7+I27stufwHp5JSuPzOzky9H8fSNQ1ry/dKljaQghFhYSDgtfHA/yDstPdwdXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GA1Ss7xzB4ufu0EzHfy3209C6IIEmTypdEP9V7lp+VQ=;
 b=elxZAvtrYzmjNmduvwVKEXXooKqKtP3HVEGlnZl9wZ2IotgSzU8cVo2zy9rHk2SRstvTfjMM5ZBRdWoNxwGoCxHBpfAmuvUVxyzDkDQKjb2CgCcj5boXH6hGOVrbLB7eed7rwROci0w39G539JSNXfHpX9+v09hlmWW9Cnt7O4U=
Received: from SA9PR13CA0137.namprd13.prod.outlook.com (2603:10b6:806:27::22)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 17:42:55 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:27:cafe::68) by SA9PR13CA0137.outlook.office365.com
 (2603:10b6:806:27::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.13 via Frontend
 Transport; Tue, 29 Oct 2024 17:42:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 17:42:54 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 12:42:53 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 03/29] drm/amd/pm: add inst to smu_dpm_set_vcn_enable
Date: Tue, 29 Oct 2024 13:42:14 -0400
Message-ID: <20241029174240.682928-4-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029174240.682928-1-boyuan.zhang@amd.com>
References: <20241029174240.682928-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: b3be5439-8fa5-4d46-6d78-08dcf8411e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zy9JelpwclY4Q3RIWEJZdk91MVhlc2dubUEvdTUzcnc5UE5NazZ3ci82bnR0?=
 =?utf-8?B?UnJoY2ZsUTZNNEJIcWo2eWJuYi9OVmxFYy85UXo5bisydGUyaTFKcjc2YWF3?=
 =?utf-8?B?c0psN2IvWXVMMVZ6SUVjL0U5bWVSV01MWEFUbGFCVVQwUkVzZVFBK05TOGtF?=
 =?utf-8?B?NjRXYjIydWNYNE50UDl4akxMNHJ4em11NDlNdUtGR2RtRVFoeTJHRDBuajg2?=
 =?utf-8?B?SW9KNml2UVZjSVpycG5YRjd1TEVkTDlRR3U1UVVndUtoenZJN0VPdzljSnR0?=
 =?utf-8?B?dlk2aERtZURldjZSKzJINHN6WDI1LzRTalZHT2hRcU13SE5sZmJQdnJJTFp1?=
 =?utf-8?B?Y1EyQ3hHWUY2Z0NENzl1dWc2cGQvVTFzWEMwYUl4YTZuYXpRVUQzcnFGYWpY?=
 =?utf-8?B?TDQrdXpnY2Q3NzhOcGxTcW5RMkFoOWZKZXdoMlBYeWtjWjRzWlNYZTVVdVhP?=
 =?utf-8?B?bUY5YXlDM1p2Kzl5M0QzNXdxbm0vRkM5alRjb0xFbmNRanZBVllxNTlJdTln?=
 =?utf-8?B?WHJRUC8rcXVCK1Q4L0lTUGVXamUwQk5DYytSdlk2VUNHTnJ5SlVTeTFXMXYr?=
 =?utf-8?B?T1F3QU1laWREZ1BNTU5qSDBZVU5VKzczd2RaTDJ4dWNXM29ONHlLTktwdXpz?=
 =?utf-8?B?TGRWMkF5RUduQlhvWnJ5N25oSFNWUnY0THMzUnFEWXQzQ1M2bEh4SW1oQTVG?=
 =?utf-8?B?Smp6R3BtUWFPTFdwS0lDOFprdFp4ZWU5UFBzeUlnN1VXcGpLbzVEZjREK3pD?=
 =?utf-8?B?SEl1YzdWZ3l4bVBnSEFDelN0SlIxOTdsNW5XYURyak5HUE10OEhMVm5sdkVG?=
 =?utf-8?B?TjNlZE04cDVkRGxaN2svd0N3TnpNZE85WnRMc2pGMDJjRlNkQjcvYUlJVFNT?=
 =?utf-8?B?WDJBNnJiMWNGN1FBSHltVlZKSXRUK0x3KzZWRFJCMXpCR1pmVHh6amg2RWVo?=
 =?utf-8?B?MUdRRUlvdGxla0Zaa2Q0OTM5MmR3MkpibitvT09waG1ISE9vWXFucTRxeWpp?=
 =?utf-8?B?Q3FvczNOL1MyQmYxbjVHcUFGb3BIbkFhNmMybndCWUpCZ0x1QXFUVU9uRERH?=
 =?utf-8?B?UzlsZ3FBSldZeXlkL2pBdFhwdXRSamwzT1VBWng0ZS9WN214V2tHaG10MXE0?=
 =?utf-8?B?aU0ySm8yZVFibjJPM1c0K2ZHajlRQ1ZtNjgyZUI5TEphYTFNbzVHb05pcGNm?=
 =?utf-8?B?Z3JuYzFYZDR1TWdjWEpUY3lkQ2dkZ2ljaWRVaXVFNzJ2eXNiTkpJY2I0YlFk?=
 =?utf-8?B?VTFKak95c2pqbUY1UmpMNlRBbE1oaG9mQmtKVHJFYWJFTUQyUlFLcExaY1pt?=
 =?utf-8?B?QVpDN3lnY1MxUkFONU1uVzEwRzZDOFB6c2xmOHhZclp3SUREY2JrVitWbXhN?=
 =?utf-8?B?d2ovamZiY0d6azJ2eUFkMFRUMkpxZHVGQWpJNm84aXVrTkVhemVJaWVpbm5E?=
 =?utf-8?B?M3owSUIvK29EcjRialVsaUNFemFwYm8vVUdaWHJJNjhBRERzMTduUUEzL0Jl?=
 =?utf-8?B?Q3V3UHF6bGtKL3ZiS2FnWER6amNaYTN5ZVU1N2VYSEJ3Sk4yQkpwQlBaZkpa?=
 =?utf-8?B?ZzJwNEZiczZOa1JhYVgyekVNZEFQMTVDdzZiOXdGeXZPVGMrTGRSSnFVWTND?=
 =?utf-8?B?bFFnVjVGakxKRlEranprNGFqNTdFMC9KdmgyQi9ldkNGeFptZVB6dVNiczlk?=
 =?utf-8?B?TkdqRGZoZElIN25hV25GODlkM0R1M1oydGZjckJxQjFES2YzWXRIOC9Pd01q?=
 =?utf-8?B?RU5XdWhjTVozcnNKeFVDRXdRWjJSd2Yzd0l0VTc5ZTh0MnVKWGtvcHNZZ1BM?=
 =?utf-8?B?S0lqQ1pvalpCTFlMaG52aG9NMW1MSGUyRS9tVUd1RnRUVzR4UTlvb05jRG1u?=
 =?utf-8?B?OFplQlhIL1VHQ3JaanozemQxL3k4YTB0NWJDVnBRNS9KRVE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:42:54.7872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3be5439-8fa5-4d46-6d78-08dcf8411e89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Boyuan Zhang <boyuan.zhang@amd.com>

First, add an instance parameter to smu_dpm_set_vcn_enable() function,
and calling dpm_set_vcn_enable() with this given instance.

Second, modify vcn_gated to be an array, to track the gating status
for each vcn instance separately.

With these 2 changes, smu_dpm_set_vcn_enable() will check and set the
gating status for the given vcn instance ONLY.

v2: remove duplicated functions.

remove for-loop in dpm_set_vcn_enable(), and temporarily move it to
to smu_dpm_set_power_gate(), in order to keep the exact same logic as
before, until further separation in next patch.

v3: add instance number in error message.

v4: declaring i at the top of the function.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 75 ++++++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +-
 2 files changed, 47 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ccacba56159e..dfbec2e2ec20 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -234,11 +234,11 @@ static bool is_vcn_enabled(struct amdgpu_device *adev)
 }
 
 static int smu_dpm_set_vcn_enable(struct smu_context *smu,
-				  bool enable)
+				   bool enable,
+				   int inst)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
 	/*
@@ -250,14 +250,12 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
 	if (!smu->ppt_funcs->dpm_set_vcn_enable)
 		return 0;
 
-	if (atomic_read(&power_gate->vcn_gated) ^ enable)
+	if (atomic_read(&power_gate->vcn_gated[inst]) ^ enable)
 		return 0;
 
-	for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable, i);
-		if (ret)
-			return ret;
-	}
+	ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable, inst);
+	if (!ret)
+		atomic_set(&power_gate->vcn_gated[inst], !enable);
 
 	return ret;
 }
@@ -359,7 +357,8 @@ static int smu_dpm_set_power_gate(void *handle,
 				  bool gate)
 {
 	struct smu_context *smu = handle;
-	int ret = 0;
+	struct amdgpu_device *adev = smu->adev;
+	int i, ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
 		dev_WARN(smu->adev->dev,
@@ -375,10 +374,12 @@ static int smu_dpm_set_power_gate(void *handle,
 	 */
 	case AMD_IP_BLOCK_TYPE_UVD:
 	case AMD_IP_BLOCK_TYPE_VCN:
-		ret = smu_dpm_set_vcn_enable(smu, !gate);
-		if (ret)
-			dev_err(smu->adev->dev, "Failed to power %s VCN!\n",
-				gate ? "gate" : "ungate");
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+			ret = smu_dpm_set_vcn_enable(smu, !gate, i);
+			if (ret)
+				dev_err(smu->adev->dev, "Failed to power %s VCN instance %d!\n",
+					gate ? "gate" : "ungate", i);
+		}
 		break;
 	case AMD_IP_BLOCK_TYPE_GFX:
 		ret = smu_gfx_off_control(smu, gate);
@@ -780,21 +781,25 @@ static int smu_set_default_dpm_table(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	struct smu_power_context *smu_power = &smu->smu_power;
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
-	int vcn_gate, jpeg_gate;
+	int vcn_gate[AMDGPU_MAX_VCN_INSTANCES], jpeg_gate, i;
 	int ret = 0;
 
 	if (!smu->ppt_funcs->set_default_dpm_table)
 		return 0;
 
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN)
-		vcn_gate = atomic_read(&power_gate->vcn_gated);
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+			vcn_gate[i] = atomic_read(&power_gate->vcn_gated[i]);
+	}
 	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG)
 		jpeg_gate = atomic_read(&power_gate->jpeg_gated);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
-		ret = smu_dpm_set_vcn_enable(smu, true);
-		if (ret)
-			return ret;
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+			ret = smu_dpm_set_vcn_enable(smu, true, i);
+			if (ret)
+				return ret;
+		}
 	}
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG) {
@@ -811,8 +816,10 @@ static int smu_set_default_dpm_table(struct smu_context *smu)
 	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG)
 		smu_dpm_set_jpeg_enable(smu, !jpeg_gate);
 err_out:
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN)
-		smu_dpm_set_vcn_enable(smu, !vcn_gate);
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+			smu_dpm_set_vcn_enable(smu, !vcn_gate[i], i);
+	}
 
 	return ret;
 }
@@ -1251,7 +1258,7 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	int ret;
+	int i, ret;
 
 	smu->pool_size = adev->pm.smu_prv_buffer_size;
 	smu->smu_feature.feature_num = SMU_FEATURE_MAX;
@@ -1265,7 +1272,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 
-	atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+		atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
 	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
@@ -1806,7 +1814,7 @@ static int smu_start_smc_engine(struct smu_context *smu)
 
 static int smu_hw_init(struct amdgpu_ip_block *ip_block)
 {
-	int ret;
+	int i, ret;
 	struct amdgpu_device *adev = ip_block->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
 
@@ -1832,7 +1840,8 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_block)
 		ret = smu_set_gfx_imu_enable(smu);
 		if (ret)
 			return ret;
-		smu_dpm_set_vcn_enable(smu, true);
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+			smu_dpm_set_vcn_enable(smu, true, i);
 		smu_dpm_set_jpeg_enable(smu, true);
 		smu_dpm_set_vpe_enable(smu, true);
 		smu_dpm_set_umsch_mm_enable(smu, true);
@@ -2030,12 +2039,13 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	int ret;
+	int i, ret;
 
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 		return 0;
 
-	smu_dpm_set_vcn_enable(smu, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+		smu_dpm_set_vcn_enable(smu, false, i);
 	smu_dpm_set_jpeg_enable(smu, false);
 	smu_dpm_set_vpe_enable(smu, false);
 	smu_dpm_set_umsch_mm_enable(smu, false);
@@ -2949,9 +2959,10 @@ static int smu_read_sensor(void *handle,
 			   int *size_arg)
 {
 	struct smu_context *smu = handle;
+	struct amdgpu_device *adev = smu->adev;
 	struct smu_umd_pstate_table *pstate_table =
 				&smu->pstate_table;
-	int ret = 0;
+	int i, ret = 0;
 	uint32_t *size, size_val;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2997,7 +3008,13 @@ static int smu_read_sensor(void *handle,
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_VCN_POWER_STATE:
-		*(uint32_t *)data = atomic_read(&smu->smu_power.power_gate.vcn_gated) ? 0 : 1;
+		*(uint32_t *)data = 0;
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+			if (!atomic_read(&smu->smu_power.power_gate.vcn_gated[i])) {
+				*(uint32_t *)data = 1;
+				break;
+			}
+		}
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_MIN_FAN_RPM:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 4ebcc1e53ea2..06d817fb84aa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -399,7 +399,7 @@ struct smu_dpm_context {
 struct smu_power_gate {
 	bool uvd_gated;
 	bool vce_gated;
-	atomic_t vcn_gated;
+	atomic_t vcn_gated[AMDGPU_MAX_VCN_INSTANCES];
 	atomic_t jpeg_gated;
 	atomic_t vpe_gated;
 	atomic_t umsch_mm_gated;
-- 
2.34.1

