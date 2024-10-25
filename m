Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C5BCE8E69
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 02:36:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03E7A10E9D1;
	Fri, 25 Oct 2024 02:36:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pivWAL/R";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEF7810E9CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 02:36:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgKynCHj5j7L6ClNuvsSzIZ3oB0/m7iAiVY6aclezTjXQ8/s+Na736OuCWw/weP/yANN3f1n9AaVjkEjg+AjCgiaDS8TEqXk44U0N9MV2Moq6bnezo1PMWyR0O9BVMaz9SsTh78m/+mtyEpnOgylWYMjiZKSDzSvzYOBWo96gmRD0WcOcJxEHPj0BAfCiguP8NGUEDZoqemkXB0PC7Z7yVPk12HOr414YY/76qWK0nFrZJnwunQ4PegkEktnJ5RCzFcMEmtkICMp56CLaz1vGzAy0WgnU15gwhOrXUXGw7GINNfKh/rvfgDtT5K5debO6LYbNk8nGpkFNlU57gS8dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOLkZW4Lb8bWdeZCeNvDe55HAzPaRZZL93rkKFHEAs0=;
 b=ejVTY15IPy1sB296T6klZZam7VuhLlgyF2PfwrCEP7u+neUmObzMf94hdIAM8ldAXOf89yQqGxYRdwEiCxYe5MUbjd+62qLJswFOyFqIJruGILB2MV30fkfvIRyWyH9Q0uyOOOX1PtQEMxEX7OvFXxRcWCc0sAjx4fPkydRjGqgUhSots8J/iZuEh+2kFQhHwlPtxr9ZfAqsA2xq1EmqUsg3+efPbAxI3IYeB9mwAwo+j9/wVwWQvlGZUTBV6+laCR4hOZ61+81ICSTgtRZGgwJ3DwK0NlZcjTiSX+MqiDNanVXIq01IfBeHSqcexSYTscE6TZeMqlWGJ49BMPAm1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOLkZW4Lb8bWdeZCeNvDe55HAzPaRZZL93rkKFHEAs0=;
 b=pivWAL/RebYRxEBdLnQWXdMLWD+EsizZ0QmqerECWL/x2c/8qvDru9UJFeviJH5/2ZnD8HuvSYEgUj5u5epIZ7/5mrzKBsJQPj0kl3ieY7MkuDbFTI8SoiOo7noquCqq891j95CZSHE3vbmFRvwoyrI0Wk6JrakFpY2JGUwa3CY=
Received: from CY5PR15CA0171.namprd15.prod.outlook.com (2603:10b6:930:81::17)
 by CY5PR12MB6525.namprd12.prod.outlook.com (2603:10b6:930:32::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 02:36:05 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::7d) by CY5PR15CA0171.outlook.office365.com
 (2603:10b6:930:81::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Fri, 25 Oct 2024 02:36:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 02:36:05 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 21:36:03 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 03/29] drm/amd/pm: add inst to smu_dpm_set_vcn_enable
Date: Thu, 24 Oct 2024 22:35:19 -0400
Message-ID: <20241025023545.465886-4-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025023545.465886-1-boyuan.zhang@amd.com>
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|CY5PR12MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: 8321ae0e-d532-40c2-c5e6-08dcf49dc65f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVFhcUZJWVQ1RVJaNVkxTUhqMytldDRTVUpITVFNM0lScE5hTzV0QzdhcEdZ?=
 =?utf-8?B?dHF1V1R0UEpmTE5rU3Q2Qm15bDR2WU1YRWRjY2UweFczaGR3aXFUMHpuTlhQ?=
 =?utf-8?B?THFlVDVmV04zN2tQMjhtM0lYRGluNVNyTzBzU0lTSFljVXViM0dyWThMVk9V?=
 =?utf-8?B?TysranNFQ0U2cEkydVIvdktJVEFDb2dxeXI3RFhEdHJGY280NjhnQmVZOUQ5?=
 =?utf-8?B?dG42a2txREhrOUZxZWs1Q2ZEVWhuUEtkaS84dk95N01vRWhGQS9yWm1HMGIv?=
 =?utf-8?B?cTBQZDRueDFUNUpBcE9VTjREemZ0UWRNZWdodnozc0cveks1eGQxYkFBSUdm?=
 =?utf-8?B?T0dBUGNsUmUwYzR3NU1zeFczODJHU3BDRDdHYmFzQWhzL2dkNmpQOU83MWlu?=
 =?utf-8?B?RG1oU21DK3hWQ0srd24wc3BUdW5GZ29nOFVlOGp0VHNhbGY1UWhmcUJpTEpU?=
 =?utf-8?B?OWNXUmpBZE9vdWs4TWpEOW5tZnJ1ZkE5SlJhK2RwajNMYS9GVFAxeHNkTXE2?=
 =?utf-8?B?aE5Scm1nQmxHL2gwZUt4UnptaDJBejRtZHg1NUhjUVpteHc4NmNKOGcwblVX?=
 =?utf-8?B?cEl0R243MjZHcCtudTRMNkJaMWczNFFrNkI3UFVtYWI0RUh2ME5wcEJBYVMv?=
 =?utf-8?B?anhibEdWak1BdTJ3TnpnMGtweGkybk4xQ29FSzJxSmR3L1N3UUtHQ0c1ZWZo?=
 =?utf-8?B?cXE5K21rbFlWT3JTb3d4NmRxZWlXTGtpN1ZzeitZaWxMTXlNVW1DOFNuTUtP?=
 =?utf-8?B?cmdiT1BkbkM2TkdqVVNYemg3OXE4Z1czZ2krcThuMGtZZ2xjdDJOQ3dhY2My?=
 =?utf-8?B?bDI1RUUzaHJ2TWRjVEZIb2xrTVJyWnZ3a1RSVjM0OXEvTldSb0ppVVpUdko5?=
 =?utf-8?B?NkYrUlVTU3QzcGlGaVY0SCsrRzUrRy9rd1diNmVVZlJJSWM0ZVlaamNKME54?=
 =?utf-8?B?U2E5Z1BoRFlUd3dBaTBPZDFpUEJnamorZ0xoVVZ2Rk53TDYwWFJDYm9kcERW?=
 =?utf-8?B?S0xySDhNdjN0ZzFBOTRiRzYyNnFNUE9TV0tPckR0emNnaFBjakxmT1o5cmRn?=
 =?utf-8?B?Y2pVWExoYm9Gb1BTYVg3TUJOS2JpUmc1OHJONHJQcDNzZWRLNms3bFp3aHoy?=
 =?utf-8?B?ZW9qSU5JNzRqVFNzYWNVa1dYWmpHOEdmdThFTy9BUkdESzlPM2lDQzIzQVFs?=
 =?utf-8?B?YkhjK0JSbW4vTmRyZEpDZjgrRFQwdGxWN0NNMWVmYU1yeHkzcFNKMUVCS2pM?=
 =?utf-8?B?emR2cCtPazRJTHhKcEV5dGJEVzZKOGFSSWwrekdsUW1BcXNNdytZdHJjQnV0?=
 =?utf-8?B?SVd5U21iUEtkNFVueWN4TitzVGsyaitRMHd2eWVjeFRGQzFNVnhvVE15Sndm?=
 =?utf-8?B?Ui9wK3hCKzQyM3dLc1FWOVUrUUxLaFl0V1p6NmwyamFUc3pTTFppdlJZVWpk?=
 =?utf-8?B?eEFFb3p0eGFjU1U3UkVBazMxVXYwTDdxVlk3T2RTTEk1SHFqd0w0MXBpR2Mz?=
 =?utf-8?B?a2V0aGVCWjV4UUJ3WG95NnVxdHVDZVRZNko2bE5WK2lZaVdLa201ZGYyZTJN?=
 =?utf-8?B?YkhhYzE0SlB5TDFaSFBmSXpRU3NxQlVJOENrZHNieTZzVit0RnFzN3l1Tkpl?=
 =?utf-8?B?M0YrSzRNamVmeVRHbmw1Z3pZbElvbzJSSWJXYnVDNVMwTDVQTmRKVU9RRTkv?=
 =?utf-8?B?Wmp5VVFMM1hUQUpROGhhSC9TSUhyUHhZRW1ZMzc0eDI5RVlIYWpvOHVhajR6?=
 =?utf-8?B?ZW1NWDhuRDlmQVRSZkVKenlQY3E0YXNoU3VFaU5jQkdaTDhERDhya1JwSkxl?=
 =?utf-8?B?SkRTbmZKR2dFcXFBRUthUFg1S1d2NzNkQk5sdDArQlZGUEQ4M0tIc3B3SlMz?=
 =?utf-8?B?ZDhIVnVRbmhCckhkWVE2T3ZDdHFHeXVKbEdERG9UVWZORHc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:36:05.2007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8321ae0e-d532-40c2-c5e6-08dcf49dc65f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6525
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

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 65 ++++++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +-
 2 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ccacba56159e..bb7980f48674 100644
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
@@ -359,6 +357,7 @@ static int smu_dpm_set_power_gate(void *handle,
 				  bool gate)
 {
 	struct smu_context *smu = handle;
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
@@ -375,10 +374,12 @@ static int smu_dpm_set_power_gate(void *handle,
 	 */
 	case AMD_IP_BLOCK_TYPE_UVD:
 	case AMD_IP_BLOCK_TYPE_VCN:
-		ret = smu_dpm_set_vcn_enable(smu, !gate);
-		if (ret)
-			dev_err(smu->adev->dev, "Failed to power %s VCN!\n",
-				gate ? "gate" : "ungate");
+		for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
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
@@ -1265,7 +1272,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 
-	atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
+	for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
+		atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
 	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
@@ -1832,7 +1840,8 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_block)
 		ret = smu_set_gfx_imu_enable(smu);
 		if (ret)
 			return ret;
-		smu_dpm_set_vcn_enable(smu, true);
+		for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
+			smu_dpm_set_vcn_enable(smu, true, i);
 		smu_dpm_set_jpeg_enable(smu, true);
 		smu_dpm_set_vpe_enable(smu, true);
 		smu_dpm_set_umsch_mm_enable(smu, true);
@@ -2035,7 +2044,8 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 		return 0;
 
-	smu_dpm_set_vcn_enable(smu, false);
+	for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
+		smu_dpm_set_vcn_enable(smu, false, i);
 	smu_dpm_set_jpeg_enable(smu, false);
 	smu_dpm_set_vpe_enable(smu, false);
 	smu_dpm_set_umsch_mm_enable(smu, false);
@@ -2949,6 +2959,7 @@ static int smu_read_sensor(void *handle,
 			   int *size_arg)
 {
 	struct smu_context *smu = handle;
+	struct amdgpu_device *adev = smu->adev;
 	struct smu_umd_pstate_table *pstate_table =
 				&smu->pstate_table;
 	int ret = 0;
@@ -2997,7 +3008,13 @@ static int smu_read_sensor(void *handle,
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_VCN_POWER_STATE:
-		*(uint32_t *)data = atomic_read(&smu->smu_power.power_gate.vcn_gated) ? 0 : 1;
+		*(uint32_t *)data = 0;
+		for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
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

