Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE5AFD2D7D
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 13:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EA5410E6C6;
	Tue, 10 Mar 2026 13:23:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LqorZECA";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011026.outbound.protection.outlook.com [40.107.208.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FD1D10E6C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 13:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=acn5NLQ2/W3HzqeJbC70pFWQKF4enhsGduggC9UG63pNwDIVV94kGPqV2Xeq8a6NvBT8eMZAUvVcci9S+++WOuR7CqSqnFFu0CZZfXO7oG5aTQyaRLZUPEC+u86x2G9+chHpfVJDT8tFKggDL/Twgl/dP+oNqQOvvfmwkGCDnZ/5cdUYv+nhLZpmLfoLiJgPb7buyZF98NkNYdLPtse7iP8KQUBFHoBONhWBOpIF2RUIrBIqybqUyoQiS4vxQM7w/KexUSvWQPQ/QJvk4VDonEuNEi+kLoRcvqqBiDEqq1/bp7LMnTGxPNmBD8DB/tH0liC8R4vgmJ+RwhdpeeSQ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omD3jNVu1MzsSHKcd+ZYUvKxPUio+WYyZ9LTvT1335s=;
 b=FRA9kbT6C/5eFXE5TlaRuXs4G0uAjTdj4Yk5gIgeebo5lnlKdyi2GeHYAqOIb7eukMqksv54nINMF5FrTazbEqCRrZ8CAuwojWImpiwY7s5lcHYCy+h/VHs/ZaOwFd/hQwzMt4+wut8J8rzgJd3M6pNEE/fqueGgKTjJ7fcWfFcz+QqW7es8i+lBIaoRdx3TfYslVwqmCwOzllCMeJZZwPTZ6pkvww9SbKo/6EoL/UE5C7Bd42ncXpgZz5dYZOk399VbDsS7lQU4K8OoYSLwIeEaRESfxwNYyJcrdE3HTJVoQQ45DafT37mGitUigBN7z5e/NssBeHkQHz0nEIK4Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omD3jNVu1MzsSHKcd+ZYUvKxPUio+WYyZ9LTvT1335s=;
 b=LqorZECAK5pS1ai2A0yYreCQRic8duwbxOnIo0Shya1YeBv9rggBOEOvQg8eTuFa4ZePLbhLZ6Icjr63uzE+P36IV6iKX8fwPzZHQLaRTVLwPKZjKlccRrTEBDD6LRH/ASHn7XzNRPKxnF/reeiTxR12EwBn4G1/W4Yk/5pTIa4=
Received: from BYAPR06CA0049.namprd06.prod.outlook.com (2603:10b6:a03:14b::26)
 by DS7PR12MB6310.namprd12.prod.outlook.com (2603:10b6:8:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 13:23:47 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::d) by BYAPR06CA0049.outlook.office365.com
 (2603:10b6:a03:14b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 13:23:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 13:23:46 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 08:23:44 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 06:23:43 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Mar 2026 08:23:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/pm: Update pm attributes
Date: Tue, 10 Mar 2026 09:23:30 -0400
Message-ID: <20260310132331.2867603-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310132331.2867603-1-alexander.deucher@amd.com>
References: <20260310132331.2867603-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|DS7PR12MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: f215801a-dabf-4a78-55fb-08de7ea8429d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|22082099002; 
X-Microsoft-Antispam-Message-Info: W71DimLxb5WJH/dkekJAMfPaBtxI3WGwbHPsjgkXRCKm4WH1ncxk+jZxHkBY8zAw0733klfTNht8y7wuumgq3urv7F+a5XRV6AzukK1zQ00NQMA90Wuu3FQgtBADKCwcYyK5l46Lir2AJ9juWFqMDtkKHEOo89vRC9vnmq0pqgh8FQ+M/RmP1r60y8mEiXvnjvDABHFjPIk1koSdybWNrxiBwiUS+V9/3mv+ZCTY8i7K38cg4zCpEEk3wreqv1kQVP+/HYpzWqCOO5Mc0Gl6GmOCPo+ICDBeD0XjxmrAzrGLMcpJGAEohAyPsX1aqRHVLswIw2kgU1UWzU4lW/z2H0j3GnBZ3kgAL5HGgOFKuQ2kQF2GaZLGvE0tZ0PKtww+Rx2CES3mSljX3n11iL4YOz+RoI3XdcNS4ugSH6qsazywTl6vChr9SNO2yIOCCNJD+VvJA/3DFXEWusyZxC9gMOH8ibyivQiqRRxkKbW4Q1zQdlX4K57zlZ6E7cquqCrC8hu32pLVPzblSZ++Hf1acGHopw70nArGfKjl3uc/eUaTDIV8V90Vhlwx/m07BzDUodueQC7+0aJJRkNKSGbOwRNYv4kzyACaZWerqNpITc4PP9acAfwW/5dk3af0mM9I36lUYPTcR/muN+jJrdm6qFUx9qmh3cCUpsZw5LZe8cgBCr1cv72zOgrGCkhmNGzcgDMib5bhoENNoL8i6NCOHdzB0x6m7wG3ss0VX/TWBAZHtdBbrsDKr0cq/OJ3dcyVgl8Lp7QY5JsGO12bnHAnpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: STPKCSW4KxWKD/DAs7DTju/wmoTBpW+BFOgRSjD3qrFxa8SkQXTFwkEHBrpyBd8JhOGKSWzMjcj41s7WqV5DT9aLMsbMZgza6cDTekJw0R6Gvv+/PxEO7n8lFKlP6O3Su/k5Trpm+sUnwa1eHgtmeM/MTPOXi9cZLemQrQQOHjsz8uv3g6KhxTPdmoG2ZWZg9yKppnevhaxbtfapHGo5iJu3v7ZJXLfhvDCRRWvHcw9kFAhRnxtFn+FokfUmMM6d1rOQTaofLPxluMP1mfarNpkhejGUFxIEyKDYxQZn0fjESHeh9MHhtlR7uq37WFtZNBofe1verTL/6icFJrfD6+eZjEziw1y55Fq6+D6cw18cCeCXGkmF0WX6YCk28CnA5h25O2CPih2ijUWw8P6J1PKGVjHTUk6WWcsaQmlZLO4g9hw/eYdEXnMSXZGhVrO3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 13:23:46.9036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f215801a-dabf-4a78-55fb-08de7ea8429d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6310
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

From: Asad Kamal <asad.kamal@amd.com>

Update pm attributes show/hide for gc_v12_1_0

v2: Use multi-aid check (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 36 +++++++++---------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 938361ecae055..a1c87f9710f40 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1910,8 +1910,6 @@ static int ss_bias_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 static int pp_od_clk_voltage_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
 					 uint32_t mask, enum amdgpu_device_attr_states *states)
 {
-	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
-
 	*states = ATTR_STATE_SUPPORTED;
 
 	if (!amdgpu_dpm_is_overdrive_supported(adev)) {
@@ -1919,10 +1917,8 @@ static int pp_od_clk_voltage_attr_update(struct amdgpu_device *adev, struct amdg
 		return 0;
 	}
 
-	/* Enable pp_od_clk_voltage node for gc 9.4.3, 9.4.4, 9.5.0 SRIOV/BM support */
-	if (gc_ver == IP_VERSION(9, 4, 3) ||
-	    gc_ver == IP_VERSION(9, 4, 4) ||
-	    gc_ver == IP_VERSION(9, 5, 0)) {
+	/* Enable pp_od_clk_voltage node for gc 9.4.3, 9.4.4, 9.5.0, 12.1.0 SRIOV/BM support */
+	if (amdgpu_is_multi_aid(adev)) {
 		if (amdgpu_sriov_multi_vf_mode(adev))
 			*states = ATTR_STATE_UNSUPPORTED;
 		return 0;
@@ -2000,9 +1996,7 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 		      gc_ver == IP_VERSION(11, 5, 0) ||
 		      gc_ver == IP_VERSION(11, 0, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 3) ||
-		      gc_ver == IP_VERSION(9, 4, 3) ||
-		      gc_ver == IP_VERSION(9, 4, 4) ||
-		      gc_ver == IP_VERSION(9, 5, 0)))
+		      amdgpu_is_multi_aid(adev)))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_vclk1)) {
 		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
@@ -2023,9 +2017,7 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 		      gc_ver == IP_VERSION(11, 5, 0) ||
 		      gc_ver == IP_VERSION(11, 0, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 3) ||
-		      gc_ver == IP_VERSION(9, 4, 3) ||
-		      gc_ver == IP_VERSION(9, 4, 4) ||
-		      gc_ver == IP_VERSION(9, 5, 0)))
+		      amdgpu_is_multi_aid(adev)))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk1)) {
 		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
@@ -2035,9 +2027,7 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
 		if (gc_ver == IP_VERSION(9, 4, 2) ||
-		    gc_ver == IP_VERSION(9, 4, 3) ||
-		    gc_ver == IP_VERSION(9, 4, 4) ||
-		    gc_ver == IP_VERSION(9, 5, 0))
+		    amdgpu_is_multi_aid(adev))
 			*states = ATTR_STATE_UNSUPPORTED;
 	}
 
@@ -2651,6 +2641,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		case IP_VERSION(11, 0, 3):
 		case IP_VERSION(12, 0, 0):
 		case IP_VERSION(12, 0, 1):
+		case IP_VERSION(12, 1, 0):
 			*states = ATTR_STATE_SUPPORTED;
 			break;
 		default:
@@ -3732,8 +3723,7 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 
 	/* Skip crit temp on APU */
 	if ((((adev->flags & AMD_IS_APU) && (adev->family >= AMDGPU_FAMILY_CZ)) ||
-	    (gc_ver == IP_VERSION(9, 4, 3) || gc_ver == IP_VERSION(9, 4, 4) ||
-	     gc_ver == IP_VERSION(9, 5, 0))) &&
+	     amdgpu_is_multi_aid(adev)) &&
 	    (attr == &sensor_dev_attr_temp1_crit.dev_attr.attr ||
 	     attr == &sensor_dev_attr_temp1_crit_hyst.dev_attr.attr))
 		return 0;
@@ -3815,18 +3805,14 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 
 	if ((adev->family == AMDGPU_FAMILY_SI ||	/* not implemented yet */
 	     adev->family == AMDGPU_FAMILY_KV ||	/* not implemented yet */
-	     (gc_ver == IP_VERSION(9, 4, 3) ||
-	      gc_ver == IP_VERSION(9, 4, 4) ||
-	      gc_ver == IP_VERSION(9, 5, 0))) &&
+	     amdgpu_is_multi_aid(adev)) &&
 	    (attr == &sensor_dev_attr_in0_input.dev_attr.attr ||
 	     attr == &sensor_dev_attr_in0_label.dev_attr.attr))
 		return 0;
 
 	/* only APUs other than gc 9,4,3 have vddnb */
 	if ((!(adev->flags & AMD_IS_APU) ||
-	     (gc_ver == IP_VERSION(9, 4, 3) ||
-	      gc_ver == IP_VERSION(9, 4, 4) ||
-	      gc_ver == IP_VERSION(9, 5, 0))) &&
+	     amdgpu_is_multi_aid(adev)) &&
 	    (attr == &sensor_dev_attr_in1_input.dev_attr.attr ||
 	     attr == &sensor_dev_attr_in1_label.dev_attr.attr))
 		return 0;
@@ -3855,9 +3841,7 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 		return 0;
 
 	/* hotspot temperature for gc 9,4,3*/
-	if (gc_ver == IP_VERSION(9, 4, 3) ||
-	    gc_ver == IP_VERSION(9, 4, 4) ||
-	    gc_ver == IP_VERSION(9, 5, 0)) {
+	if (amdgpu_is_multi_aid(adev)) {
 		if (attr == &sensor_dev_attr_temp1_input.dev_attr.attr ||
 		    attr == &sensor_dev_attr_temp1_emergency.dev_attr.attr ||
 		    attr == &sensor_dev_attr_temp1_label.dev_attr.attr)
-- 
2.53.0

