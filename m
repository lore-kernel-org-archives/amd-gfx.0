Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0016CCF8840
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 18:45:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A335710EA89;
	Fri,  4 Oct 2024 18:45:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C/vCyvV1";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DD0410EA88
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 18:45:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyZuFn/HbOssexF2YAORDWy7yAXExEngXKLd/jhrqLqSU+ZiqhgNXQY8zaduwXmB2bTzfKUqaoLnUuMsPZRjA+eI4ne14xW3WThitO3heEJ9+YRiyXAbhjpMr++lY419QL6VRqc3cdFdCHTahazlFIquwUJ2DNYgVPEvWHs4Ngabz8qWXBUA7ftBZzO1SQewt1SR5bZ7LNFnpvGwjbrWtsX2p/jP1oG3wkNV2g0WaS2bS+KzFH5eLCuSjAIUpi3im6EZeSC7EhEO92E6x0iCYcG0oNcYkTr9/2XqX/oxpES/TpWPCzDVAess2C3HAY0L/7crAaPuPB42LmQjzNnFYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNsDGILsOCaOO0XkBAToBz14jS0bM70Ovx2pOoxGJwc=;
 b=Dx8QIaryPTarff9uPDW/OTo6UkeRabYtUhLIh8zRjblyvRnhv+GUXmpo6nwgtxKBT9DShDl+le9v6vMiEqX0lUdGPO1QLw27qyvn3VawVgStjlAWagkrFgY+bVVfqXRnRqaq4IfvwaonYVeUD2mx/GQcHWbz1trRY+Cw0mZH4/L7Up7kMP2xQjHvrO9KlHqcuhHlobzPCKbsMkfYzyTGdyMEzImiBQD7IUZENB/jkP70TXy27wOOV8Vr7V2JbScN1eQHMrfhfVmxcq1ufZEaFIqg3/SLmGnXwGs1vkcpZBwtfWGmyVQF66EpoWL4nNHrYw7PyjGY+SXUynK94mS8PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNsDGILsOCaOO0XkBAToBz14jS0bM70Ovx2pOoxGJwc=;
 b=C/vCyvV1agqiMrxgqomr9fAi1p5zO3TS6WDuoIx2dMvvqmvIXE4MVe/D+IXbkRJIzeSxfjk+UyS1BCar5mHAb0XhiYYJyC2WpscvKVInwBPV7zrOFEnZJ0BRI+hTXPoQwED1M306ENOC0LX5Cj9ry6r7XYtueYj1Jhh1s6I8r3I=
Received: from MN0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::18)
 by DM3PR12MB9415.namprd12.prod.outlook.com (2603:10b6:8:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 18:45:03 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::c9) by MN0P220CA0024.outlook.office365.com
 (2603:10b6:208:52e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19 via Frontend
 Transport; Fri, 4 Oct 2024 18:45:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 18:45:02 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 13:45:00 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 02/18] drm/amd/pm: power up or down vcn by instance
Date: Fri, 4 Oct 2024 14:44:28 -0400
Message-ID: <20241004184444.435356-3-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004184444.435356-1-boyuan.zhang@amd.com>
References: <20241004184444.435356-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DM3PR12MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: c4be4f84-ec23-4dc7-74cf-08dce4a4a867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h8P1EV6BFAiC//LBF4MGmAKDKee80831WkZJ1/3LKtGZgAs13R/+WhEPaVdG?=
 =?us-ascii?Q?BJa92XRpntXVGU+MsHvk8ucc+ZBzi5sYyE6CtvmhhrcoHux0/mIiRYymZkFW?=
 =?us-ascii?Q?iW46NHotMH7Ud9GocLDyRKnR0gj+4fj5sSO/E+1nUrmXELmYf00TV3xMRaGi?=
 =?us-ascii?Q?/O9HfawskIV5+OYDU7OcOfv8dwtlWU5gYipZyNPw40IJwe/NIJV+3vpg2z6W?=
 =?us-ascii?Q?cZ2zO4E0vI5c+Un/u6WdG+ukjZj9jrG1rrA3X/1McpvnEG9oq4ffSE3/Pt2F?=
 =?us-ascii?Q?IYar6hnTUYAez/LDwn6O8iwSt2kXbEmfnqdOpZY9zebJGeceQgvEz3xlXlk+?=
 =?us-ascii?Q?7X0uwWCksXd3NF3aucxwTcEQyf4iNw3LVz4NYl1rznA9cM4JnqqNtwxCbJBp?=
 =?us-ascii?Q?5VOSL1Xq2YrZezo4VitgKD3CY0iT0/y/YCxW/kj/koy7AQHzoFFEtkeUqOSc?=
 =?us-ascii?Q?BCzuaTWWXfy6eMayhtjDsYHouLK/LhGvY6xRlo00t0Jre2tgKuE2RosJxOQ3?=
 =?us-ascii?Q?u7sJ3aN7ij89OtHyRSS+iTB5OTgroHWJuacMcz3qgmL1eakWIOjOHbDMLHcB?=
 =?us-ascii?Q?XClpuxsiJC3RzNGhX1LgCL+/2QIcmGIiDDzatPbapdK8uJ3LhQpC2WVpi00w?=
 =?us-ascii?Q?0DNGNFjRNGEyPmtFSRbet0HTbYMdKYE7pbPUA0vl8/N+uPYoWkX6wDFVMTpD?=
 =?us-ascii?Q?nTrgIy7+kDGvw+tYtHehLMIG/51UL/1pAnAI0XerTJcZBucCm2sYSAnAJE1S?=
 =?us-ascii?Q?V14zZ02A6iYf0qMDjhhhhIUn0lHSzDJRC1DurLXaA//6lbM19Q4tYs9p8Xl3?=
 =?us-ascii?Q?6SImBRBQRZClTE9Cl2sXkaqLrZSfkqEqVeneEKE8NZ7i2pUb98k0RxyeHHAq?=
 =?us-ascii?Q?/9OJLuXIOnX4mhvMHoeuiJ8PrINmsiHT3eI+0pH+B0wT9sbd/WCCp5iYx/zN?=
 =?us-ascii?Q?xdaWtpnEi5FoZsbSC1qFWvlFKjeNmjXGHMHHiSP2Cgp0mwF02mxpvU8XSNbN?=
 =?us-ascii?Q?7ZimWaHT7IRxFeljd8YDCPTuKhtcRL1HjwpcomXAnFqBJ5P2McLI3T8AID3h?=
 =?us-ascii?Q?TxfPpCN3N/1JqaxMjuH+RYiBQh04YUMHe4eNVO2jDEHtFrjudVbjBkZdd50a?=
 =?us-ascii?Q?Yvdc6g0FaaWlGdT2X0coZsVEjMT+yxGGO5DbR31vBVCOSjcn+fTCUdKVTsKj?=
 =?us-ascii?Q?CmmU0p/UXDpW4c4DjfaqMA4MKdZlsDNdq7kQVDa4JJhIrq/8tQMG4iU8yVPw?=
 =?us-ascii?Q?3vQGO5BDI/qi17ZSvsHN0hqT9Qerwf9YOiALWp5a0I+zetU5Ssu+uTfw9PDv?=
 =?us-ascii?Q?VN2rTYE2AyGYTUutzSste0xWUx/5KoraBcSSGRgvjW8jS9qJixG28awv8zOU?=
 =?us-ascii?Q?P3F3BPGFG3LfzAXwoAN44x6U+hro?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 18:45:02.9639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4be4f84-ec23-4dc7-74cf-08dce4a4a867
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9415
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
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  7 +++-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 20 +++++------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 16 ++++-----
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 35 ++++++++-----------
 4 files changed, 35 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 6305fd7d2573..410d5baedfbc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -237,6 +237,7 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
 	/*
@@ -251,7 +252,11 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
 	if (atomic_read(&power_gate->vcn_gated) ^ enable)
 		return 0;
 
-	ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable, 0xff);
+	for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable, i);
+		if (ret)
+			return ret;
+	}
 	if (!ret)
 		atomic_set(&power_gate->vcn_gated, !enable);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 2438f813d6db..f41d8fd09bce 100644
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
index 1d37b9e251d4..e57d4926250e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2092,18 +2092,14 @@ int smu_v13_0_set_vcn_enable(struct smu_context *smu,
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
index 5e1165ecdf7b..20822ac623c7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1496,29 +1496,24 @@ int smu_v14_0_set_vcn_enable(struct smu_context *smu,
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

