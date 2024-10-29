Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13912D3A67B
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 17:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A35F510E6B0;
	Tue, 29 Oct 2024 17:43:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="srEpH3Tz";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D187910E6BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 17:43:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gj3O8mIjIMHp7cPunYkf+YtjTGMvEBgDVivhGbnJdXFZk7DRn3LbPGsMvegMSakYD5RBW5kxiVE/KIC0kIWO9+xqFOhZYE9Bab94fAQScGnvHn9efSOSu9PEJ4XZjR4SeMb7cCRtE1X/+IDEwxKegn8uEOJpFMr1QLLt37/SUTEJa33QtPA2Lj+s/C+4YtWyS2aH/X0D5ur0FihWmo5pI0cNxpamQVbYLcpXdZEcAVUUWErpxP3XEfVHPdujIHEYbFWfTLIsMCvmrOiz+rHA8hrcPDxPUTa5/8lSbGJP18H4Q44nV0HEbYumzgie5X9MA2pSD54bte21Ffm+rF8hRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lhSQSigvwe7sD7U1Opfa0omw736EFurehsaHHXgC90=;
 b=ghMg6uJUwHie9Sf5fZxCwaeKuupdCdPPdDF+bf5SdpuYZuHf9TenyELzphyNXy7p2b9jLS1mIpB1z6XAADMSk9a4YeeSesXZ4opRrLrpzGOZEI3KaAhaIdYKiUt/6LLX2zmSy8a6K5/fSqg53SgAsjmLqDj7oMm3D/zvF5Unq76sV7VQte7O+DDZkLezYW0am4kffQhh6K7B6/OPm3Q19lIoDAPEfej6zthJib+4GxFQb2Xeknwi0zkGtZgdzJ9TKgkfKWBBmRsF0tYyLkIQEXo3Yuq2Rqwu8Hmip5njkt5wwPSULjoDgSmim9fAypV/G9MWnlnEqOOOwKpcBSfdVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lhSQSigvwe7sD7U1Opfa0omw736EFurehsaHHXgC90=;
 b=srEpH3Tzi9D4qkU6anCX4dJjo5E5cWuHNqv+/7OFnRUw8di0K9s5rZrrYfGtHwoHkde6U+Bn3w4FvOh/LYri9mm2VSg//F0ZKmghaI71yJMvH46bgUFYElWZzkqUHXmWyDw0d9sis3APeufF3W39WmGMboZM/l6vMylC1huQHkU=
Received: from SA9PR13CA0121.namprd13.prod.outlook.com (2603:10b6:806:27::6)
 by DM4PR12MB6208.namprd12.prod.outlook.com (2603:10b6:8:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 17:42:54 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:27:cafe::18) by SA9PR13CA0121.outlook.office365.com
 (2603:10b6:806:27::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
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
Subject: [PATCH 02/29] drm/amd/pm: power up or down vcn by instance
Date: Tue, 29 Oct 2024 13:42:13 -0400
Message-ID: <20241029174240.682928-3-boyuan.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|DM4PR12MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: 376b3554-1933-4e4f-35f7-08dcf8411e31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnY3eERsM1NVbTZPN0FxV2Nka2l2aEpFQy9HTzBzZWV4TUVUS2I1MzJ6MWpo?=
 =?utf-8?B?QlZ0OWk3S25mSW5uMmwyTUNzTTYxaytucVZjVjlmaUhNQjZwQVFhMmVtQ0Mv?=
 =?utf-8?B?YXh1cXdXNHg0TWxjcWxBSC8yU09ydFkxU2Z3eWMwdUx4RkljZkhHUHEzUkxT?=
 =?utf-8?B?ZmNKMDVrZHcwSG9zVGJLU20vU1g2N2txa1pkQ1MrNGp5ZkQ5Y0p6T09HRlJD?=
 =?utf-8?B?NWMyWW9tcGVSd1ZXL2MrSDU0U0NXN0Mxb3FPcjVUVHVSZVpjb1RBOENMK1Z5?=
 =?utf-8?B?eGNZR0lwSnlsUnB5MU5rdmhES3E1MU5qSHFVWFZveEJ2N1FaTFdtOHZjZ1RZ?=
 =?utf-8?B?eHJ5Uzk0b0VZZk40UHBnTHlUQVljUGR4Rm1DUFZ2a1VjampnYWpDeG9Dczc1?=
 =?utf-8?B?VE9ZMGs0V095Z082MnJBbEtPMGYxTG0reTJQWEVOZlZxblpwSUpuMVcxVTlZ?=
 =?utf-8?B?WEEzZEZ1cUVCZWcwcGM0VnIzOTN2WlhWU3pYd3lOVFErYkZETTByN1p5aHRx?=
 =?utf-8?B?a1JLeElXZ1c4V1AvTTlML1dtSWtsT2x4ZU5iVFlvTzZuVDhKWHY0SGd5MjdP?=
 =?utf-8?B?UHhmRG1IdmFSbStidVNZUThsL1VKUkJUQzUraGhSdE1FeHRRZVh4dDl0TGdY?=
 =?utf-8?B?TWZFVTdja3JBN1FFdi9vUTd1ZE56a2Q3SjdiYWFhZGdGVGM2SThCc2tFN1hM?=
 =?utf-8?B?Um9aUkEvc0YxTVRqZHFLcDB5RnJycytZZFE2c2JEMzdiU3B2dTQvWFRuVzZY?=
 =?utf-8?B?U1FPdmZYclFZV1dCQ0E0KzlYbFUvdmNCNGJzMVNoK25tZTI3RDJQNVlFMU10?=
 =?utf-8?B?Y0NTNHZwUmtPalp3ZHEwbjBocUhyVmpDQkk3UW9IcVNDNmVKRUsxU3BFVm5v?=
 =?utf-8?B?bmI3OXZoQWcyd0lzWU1pcmVLWjBTM1dza0tickdLU3JzdVFYbVVNT1BPY0JQ?=
 =?utf-8?B?M3AzVzkySTFTUng1WFZxK2RJQXQxQyt4ZEwvZXI4aGZHUDFtWnE2bUVMY1pl?=
 =?utf-8?B?WUp6dkZKSVFBd29kWnFvOEZBWGhaQktPSXVVZGI1QUhoMzBBN0JlZnl6Nm9l?=
 =?utf-8?B?cU5QM3d6Z0dwQzVob1dtK2lFNXU1SE1UeXNSRmVYakg2S0JuSnp3YUNwV2li?=
 =?utf-8?B?Ni96ZERmSldBVXRCcDd6YmZYSWl5VHFJYjRtMlVla3pqUFlqZXJtNmcxd3JB?=
 =?utf-8?B?SXVoZFIrSm9JZi9qNVQxRUhIaCt3eGJzc3hQMmg3Q3p6SWdsbFRDQ0tGN0Zo?=
 =?utf-8?B?b1JWRjR1UmhqWENvbm5lVmxLR1R1WjVzeUYrblhxcGMrdUhhcjNQRmdGd29K?=
 =?utf-8?B?dy9xaS9CT21ZTXJQa3N3WCtuVXdWMEtrQWRqNlhta3hzYkU0SWcyNEJrS3Y0?=
 =?utf-8?B?cTZocVNjUmFhN2prRDF2aXlDMG91bE9aaXRva1JKZ0IvdnBzSk1SQzR0SHRN?=
 =?utf-8?B?LzhoT3lIMEw2cjhmRWhyQUpwb3pJZEhqRll4U08zM1lkeEVKQnhSTy9ZbWpt?=
 =?utf-8?B?THEwNmxTUHU1UE1DaGpvbTdET3VCWVBuc1IxeTR5ZDB6eFk3R0htM2R2cjVF?=
 =?utf-8?B?dFpqUlNWRmh4V1d5Tk0rWlh6emhGdmNEcVZVZFVYYUFUU1JJWFRsSTA5TjFq?=
 =?utf-8?B?UnhRQmttY0lISFV1NGMyODRmaXhGWll5WEEvVnVxT1NJODJldWN2OFpKaEJh?=
 =?utf-8?B?cnYwbUsrdE5tbjMrVmNKTTg0V29BMmlkL2lZSldhN2w4WEdTcDM2NThQSHNO?=
 =?utf-8?B?UjUrazIyOWxienB1WEp5NjFEbzZKcEphdmRlZStxTVdFVmY2bityRFBHemdo?=
 =?utf-8?B?UXpOU3FGWGl4Q1o4VnlBZHhZelBjbkd3REJkaGtlZDU3cFE2dWpFczFOT29M?=
 =?utf-8?B?NXN1Uk82bk5rYlBYMjBDK2tia0twc1I3QXVubHdMakdxaFE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:42:54.2090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 376b3554-1933-4e4f-35f7-08dcf8411e31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6208
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

For smu ip with multiple vcn instances (smu 11/13/14), remove all the
for loop in dpm_set_vcn_enable() functions. And use the instance
argument to power up/down vcn for the given instance only, instead
of powering up/down for all vcn instances.

v2: remove all duplicated functions in v1.

remove for-loop from each ip, and temporarily move to dpm_set_vcn_enable,
in order to keep the exact same logic as before, until further separation
in the next patch.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  9 +++--
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 20 +++++------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 16 ++++-----
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 35 ++++++++-----------
 4 files changed, 35 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index fe2a740766a2..ccacba56159e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -238,6 +238,7 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
 	/*
@@ -252,9 +253,11 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
 	if (atomic_read(&power_gate->vcn_gated) ^ enable)
 		return 0;
 
-	ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable, 0xff);
-	if (!ret)
-		atomic_set(&power_gate->vcn_gated, !enable);
+	for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable, i);
+		if (ret)
+			return ret;
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index a9cb28ce2133..24cf17e172f4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1157,19 +1157,15 @@ static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu,
 					      int inst)
 {
 	struct amdgpu_device *adev = smu->adev;
-	int i, ret = 0;
+	int ret = 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		/* vcn dpm on is a prerequisite for vcn power gate messages */
-		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
-			ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-							      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
-							      0x10000 * i, NULL);
-			if (ret)
-				return ret;
-		}
+	if (adev->vcn.harvest_config & (1 << inst))
+		return ret;
+	/* vcn dpm on is a prerequisite for vcn power gate messages */
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+		ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
+                                            SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
+                                            0x10000 * inst, NULL);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 2bfea740dace..bb506d15d787 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2108,18 +2108,14 @@ int smu_v13_0_set_vcn_enable(struct smu_context *smu,
 			      int inst)
 {
 	struct amdgpu_device *adev = smu->adev;
-	int i, ret = 0;
+	int ret = 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return ret;
 
-		ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-						      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
-						      i << 16U, NULL);
-		if (ret)
-			return ret;
-	}
+	ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
+					      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
+					      inst << 16U, NULL);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index ecb0164d533e..5460f8e62264 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1511,29 +1511,24 @@ int smu_v14_0_set_vcn_enable(struct smu_context *smu,
 			      int inst)
 {
 	struct amdgpu_device *adev = smu->adev;
-	int i, ret = 0;
+	int ret = 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return ret;
 
-		if (smu->is_apu) {
-			if (i == 0)
-				ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-								      SMU_MSG_PowerUpVcn0 : SMU_MSG_PowerDownVcn0,
-								      i << 16U, NULL);
-			else if (i == 1)
-				ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-								      SMU_MSG_PowerUpVcn1 : SMU_MSG_PowerDownVcn1,
-								      i << 16U, NULL);
-		} else {
+	if (smu->is_apu) {
+		if (inst == 0)
 			ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-							      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
-							      i << 16U, NULL);
-		}
-
-		if (ret)
-			return ret;
+							      SMU_MSG_PowerUpVcn0 : SMU_MSG_PowerDownVcn0,
+							      inst << 16U, NULL);
+		else if (inst == 1)
+			ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
+							      SMU_MSG_PowerUpVcn1 : SMU_MSG_PowerDownVcn1,
+							      inst << 16U, NULL);
+	} else {
+		ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
+						      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
+						      inst << 16U, NULL);
 	}
 
 	return ret;
-- 
2.34.1

