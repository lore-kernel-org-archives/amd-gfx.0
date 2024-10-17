Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96024D37485
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 13:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F02510E823;
	Thu, 17 Oct 2024 13:21:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eJ5u9tHW";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A697C10E81F
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 13:21:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oA5x15dqwwwskOM5+QfQ4j+V2GF1CMpT+Ulsg0mN9b5Hgy3fupC1VWPMn3Y/BeAPqfeezYFCP0HIzKrFtTDn1XxqeVSak+9fqZKxAiWVITTXhJiAk2MG+TOgYh0+zm70AXCGps8dxG5xyHecQWgP+MhOKnmT+NrHunGc53rxZxos6jXdDPg6o0vejTtdWL3EievyWbFXmtfXPTAtWkm7Fi0VEuw1/pmX0B1aUCvX4KiMIiv+AeU0+wImL4uBvZBZxzcK6Xo6Bzdepfq6ppbJyC1wt1NiSljxKFt9mFm/+v4Y0n+P+4FcwbxHQ8j/LDEHcLIciGthyHhKxE+UndPA4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfT02gJ5I/LIQ5ZwFI0kNN/eeCzip/MDKC7fWrsr+1c=;
 b=AkLMJhlahlADmsLXHUe3doeabAceyyF7WTqnkn3uQJPLGyF0dKy3FbsUE9Q9z4XlslXpytg3LBMT3TrWKqI1Cbo7rvzvuGrtBUX9e5/4ZXwsVdPSrMSE1lX113i7LNSKLYWI1vQLrDKWrMCgpwh0qqZaeMPoWjSoKLBtrDtyoQwCHV7ov2etEIcnwIBgkKVItTm0VEcsJ3rkxs4N4Gz5wdEuhRku3KnP5e+l4/MRoGucgE3IlbdR11kBEqpgry7XIpOiEL1ymQsyAYIqd3/dBEIyvpIQrD0H/L+Eb6lrugA4vtsg+EGfg4ttE46y54a+DlWaYx7m/D0O0I3q6y6dMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfT02gJ5I/LIQ5ZwFI0kNN/eeCzip/MDKC7fWrsr+1c=;
 b=eJ5u9tHWCZ7sxpq8ataotQ5R9UIhyt9as3EEGkyN1o0KOVgOzezo6FHT3b2yq65n8taCm3qlfQ0mQQUe97a4fxiyNzWlqeZ2+x1oEUKY4iddHgYyOSQv4r7jyDvJkg0MHM4Y4P4PvXq6YThzuk0RkGwQ4Ye1yV7UaKlgDiWcttc=
Received: from BN9PR03CA0158.namprd03.prod.outlook.com (2603:10b6:408:f4::13)
 by CYYPR12MB8871.namprd12.prod.outlook.com (2603:10b6:930:c2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 17 Oct
 2024 13:21:18 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::a3) by BN9PR03CA0158.outlook.office365.com
 (2603:10b6:408:f4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 13:21:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 13:21:17 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 08:21:16 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 02/32] drm/amd/pm: power up or down vcn by instance
Date: Thu, 17 Oct 2024 09:20:23 -0400
Message-ID: <20241017132053.53214-3-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017132053.53214-1-boyuan.zhang@amd.com>
References: <20241017132053.53214-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|CYYPR12MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: a31ef5ff-0d30-4b52-c858-08dceeae958b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Cr+hssKP+tKNZd+O3tO4xg2lSLiChr8xWMpPo8v5F8XCZcHqFPDQi8gShHqg?=
 =?us-ascii?Q?n5/q3meudqAoUGGuFgO2yXs9wV7kVH9ySuE0NQwwmC/1EtMeOpqj2BzQ735x?=
 =?us-ascii?Q?mCE9aAn56MiMMzW4QhSuwmVXAeHRvakdzgjJG3X4Ar6tXkYGCkkMwZ9K6Eep?=
 =?us-ascii?Q?NoTO9UoFl5KP9NUNm5vO2R7MI3RXPALy9AyUMHaL0bxJYoA7T7GuwbkCCwUe?=
 =?us-ascii?Q?yYIEYxomGkBEfcRlDDXGvfsNHhrBvP0a2SUik1HH36pV9vveWrrrTSD0g963?=
 =?us-ascii?Q?ZAAt8BTLmsUD5xT3FQtFFYunBx39GY8x3LHzqf+7oeXqvp04igO7/NkPpU3h?=
 =?us-ascii?Q?NGfDGc1eDNrK6JkPEjhPVxod/0fTRr7Eejdt9PoWAhBR7hFq7fWHujgHCI4r?=
 =?us-ascii?Q?0Sc23JgIrs1CbezAmVPZcQ2sUGg/RaLC8vW2L8/1PqM65HV1jjtdhu4t1lwX?=
 =?us-ascii?Q?s+UHgHbmmDX2+wuuMfr8ufunnSM2U/jT70T4RpGUi7QoNORH/z5xQTEkWs7J?=
 =?us-ascii?Q?StcFSfmJ8+HKKDzPKkV+FMASVH9nzE2gZCrQhcSq2ePDJvLMw/mxMUj9eMA2?=
 =?us-ascii?Q?TWNpBiWdmqU+ukDzTD2uwdTzZ9wksdMi5hWYt3N1IA5yknlGvRgn6QWAI79G?=
 =?us-ascii?Q?o7cIgwpSpB3x8G3NFUxjs+M6auerWI99qy4dWgyhAkpntI31ezduP5WWsXn7?=
 =?us-ascii?Q?RzTrc6fp7svaexgBI/5/Pu21Q49EZxzJ9fr4QjCj3rUcpUzVB2zfIlfKp/jX?=
 =?us-ascii?Q?vCS4bfGgQix0pzhWSP5BCICSFh2/Upx/B9ZHBOkzit4jmq+Eg+aTvH7g2ttb?=
 =?us-ascii?Q?3gj10tuNsTCQFZxGEDrqz6oR1AXGYy0c6oD0HL8HStivjKbzxgWOvQ6UYNwp?=
 =?us-ascii?Q?jhLJI+qMZB9orAAGLRI4VRwS0Gb2IqcV4JNTBLd9Nfx3Kt1H6c0uBl1KZTIG?=
 =?us-ascii?Q?6NNwKlwlvRpI89WSTBd+aw8UMmVsqAxK70e9Sv9brnuagOUJvvoUKWFoVapc?=
 =?us-ascii?Q?vbfUpWnzYNeOpnlaDRkl866iig0B8mkiW073M+3767v9pwrDc6y+FdjOq5Sq?=
 =?us-ascii?Q?/FcI/UM/LJhqmwNt9j0SoN6ctQI21OT3VohtyGDRp4GOzZAY/pAFjltn1Ndu?=
 =?us-ascii?Q?e4ZVNC+SmLw0ZJ7WKqcirfPX9VEl4p/2gqKJeEluKbCMud+ZwNQMapSCMlXz?=
 =?us-ascii?Q?F0VC9TMNPdNaXr/chfoYzmq+EIH3wjJ+aFMm3u/MjZV70i1J39PmsQG0y7zZ?=
 =?us-ascii?Q?qdS5HCKktWr24hHJqitHVgKJn6rHXesYnrVtVAeNaY+wrvvSvg3PORMv0Mb4?=
 =?us-ascii?Q?+MUacFsDSNNITdWl0YUnpvcjN1FEgwjLQ0HSbq7NKso4aqnoDO3dhU9ZM06l?=
 =?us-ascii?Q?Jtv0dmOZI+fMg558rEpKg5puRBSZo6njmb2no9Foj0/d8QEyJA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 13:21:17.9672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a31ef5ff-0d30-4b52-c858-08dceeae958b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8871
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
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  9 +++--
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 20 +++++------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 16 ++++-----
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 35 ++++++++-----------
 4 files changed, 35 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 6305fd7d2573..246f81d73bd2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -237,6 +237,7 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
 	/*
@@ -251,9 +252,11 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
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

