Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62425C4345F
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Apr 2024 06:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52DC910E878;
	Sun, 28 Apr 2024 06:01:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x09VoLAf";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4457510E878
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Apr 2024 06:01:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxX7mKMbZD/r2NKU8GwRuJl9WI/GQKESO9A3xOGos0ohsfw6SsgMcHRwKM/u1p3ZHkkNIsZJWjTrdCs4fURIx5suqRMVUe12P+U55wNQl96m35tlsxU4TW31GY5H55pAhDS9DJlN78xB3okR+GbqTgI7A+TROrJFOLRFLJN46I/sS2msVAyBezUkkhxmPCio7KFuKqpyJoVRvCXx9s7MbGEjr1ecxieL1FiNxe9CsJjwuJ/R1T+PKDQ6cY7o38Gz9J5ZMBJPo6OEPgPVfDKA4vLaW0qDd3TKOaMNcu7Zcokwes9xIf0xPs08pgKc0EFhLSuOflegNusYJKicmQmwPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYpGTF9fS9z0vHyQR/sRh7g40iFtex+DdRM/+zVtQXU=;
 b=nGlG54lub95SIwduACO6YSeyZwImSdyPJDU6Gva+9S23w61fSo3/ONoKpmYiNq/78YUK+7C1QK13KDPhXQ6mWCLcKlc4mJEq7tkLXEfwCgiZnxMCNBQl032Da2SqMqGCQblurD3zWHw0+D8137Nud8xclYv5S6+afOAzISZJCS1WbFkeIaovh8Ei4mV1ZSn2VXrhTKyZ99wwzuSiOtNu0E68OPlAkjREBq0LCHGVA2qZtulOjnRJZ3ecajosYd9BoAQFT9H9wHThZDwoga992txkmkQlWLJy+x4rZRoZAGETO5cbF8bOwtMSC0LyjFvAs0vIrijHmFUM3ykBvwYC0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYpGTF9fS9z0vHyQR/sRh7g40iFtex+DdRM/+zVtQXU=;
 b=x09VoLAfmOyHhSJXx7JTFGpU222wrAhC0Okhixr61H06j6VuZUM8DYH+SFIhA7r9SPer3lmefYHmELPrvRrIdqpnAWtxsRH1x8Y0MAoxmMgpJygHDbdOSKO6oPIdBbf0Un8wIa6rGOAxumWzWTKnBHBN0ZyIqQCrhxG3y6a+fDo=
Received: from BL0PR1501CA0011.namprd15.prod.outlook.com
 (2603:10b6:207:17::24) by CH2PR12MB4072.namprd12.prod.outlook.com
 (2603:10b6:610:7e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Sun, 28 Apr
 2024 06:01:50 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::6b) by BL0PR1501CA0011.outlook.office365.com
 (2603:10b6:207:17::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32 via Frontend
 Transport; Sun, 28 Apr 2024 06:01:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Sun, 28 Apr 2024 06:01:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 28 Apr
 2024 01:01:49 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Sun, 28 Apr 2024 01:01:42 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 2/2 V2] drm/amd/pm: fix uninitialized variable warning
Date: Sun, 28 Apr 2024 14:01:41 +0800
Message-ID: <20240428060141.1575697-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|CH2PR12MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: 13418879-c50e-4967-efe9-08dc6748b1b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q/d8ihMMFwnt++kZT/eSNKakr8xPdihs+4L0aA/aWigsUIPwmCP7MGo95PL/?=
 =?us-ascii?Q?s999ndglPKkAbHRt4CuYYfIg+1RgSSR2BJlyFluBPX+FS+HjyFIVoGJZtJyS?=
 =?us-ascii?Q?k+u/MOT6ZwKTnWQpy7VDJgKQiFunSgba9nPS7AxajXjN5TpYGWpveXanKb1P?=
 =?us-ascii?Q?4/ZghC0ZP41xlMEuKxM4kH8gfTaz0BTtjlqt3nuVgS4iNDlfjgUVng6eFIjf?=
 =?us-ascii?Q?NpP2dnZUSDiJVnYe1PlIp9U2ODn+8yA9uv6a3BeK0wnduY3rqoMr2nlhzUo9?=
 =?us-ascii?Q?DlgRH2N0N17g0JVLKXqIiUoy1nhElLSbyi8wufY/DMJwF9aIpFciZpd7yxBC?=
 =?us-ascii?Q?BOKYjkk9ZUjFoRNp9brra1q6Fvuqzh2yoqRT3JL9jp/ZCx/ZiYr9HUDCxE00?=
 =?us-ascii?Q?CufeBqRZ9k2TPWMUsII5/ltlawGzutdMjSEcuSEQtDzCp8nbCnmW57EEw+0Q?=
 =?us-ascii?Q?n+W3e2/f91Kg4DlPD9q53wup4a27XtG5+2p6Q/lBDR2Ww5aFjcPXxzHA5PnP?=
 =?us-ascii?Q?v0VbWNd+g7HZq2phGDzl43rTsTzFJX0vkzXiyHgMjMrtayavJ37emx4HEEXn?=
 =?us-ascii?Q?G+/8dDJ73fkRKGuId/k82vqHLrcP1ncJm009IJ/MqXsmpFO5eSvPO4o0Z5nM?=
 =?us-ascii?Q?INeIxY78j8g4wO0CHmUKvPaDegan3KkxuV+QqbllZr1SticKE5SE2tWTxj3B?=
 =?us-ascii?Q?SWZZWKzt3p3RRIYR8XqP6vkNII8DgQhxODS3QxE0dDE9XiuAQlDLrqiurbc5?=
 =?us-ascii?Q?H9LhkVdT3pJCNZFnsXOzhMIpohHdEnmlvvcSilmICXXmPgeflSm511vYqwQ3?=
 =?us-ascii?Q?lJ7yKoy6K+dAT70FglydRDz2XNDpMLolLDT6xyRTcF2W2kLn52ybGS4WAQ4l?=
 =?us-ascii?Q?j43Zxro1AoGEkgenOKcsNuAZMwzeETLCvAEkK8vs0ZRPmC/73BFXPqQW3Qwu?=
 =?us-ascii?Q?NiQX5vNNe7ldjkOwImpwtaCVba4mDJQTRSgQRsqxnr1BqcnQMIX9O91j2qJi?=
 =?us-ascii?Q?av12mIHzeXWdV46X6rnFt4oF6dWhAcNJkGUpb5qO7D/dZUReCF+YwWy+sDkZ?=
 =?us-ascii?Q?SUJt0prYSU8DhLciZqomPOje5Uw7sQIIso49dbAJMqTzG9PCWkwVPH1jR4JI?=
 =?us-ascii?Q?DJhZ6w5ga2lD/93Z8MEwtFzOodXdEJJjUYJfg/Tx3/ifm9mVFe/vSn5N8YaC?=
 =?us-ascii?Q?XszMh34ps5F8r2JE5OCew7z8xURJBJhWqueHGSlMtq1xpcnY/K890ajzv2Rg?=
 =?us-ascii?Q?Nhlei2cY3s/cfL5bZ51wjoxFa8U2RZxvX8DVo0g4RsYnkYqwSsDSS50AI6Qp?=
 =?us-ascii?Q?LnPzwIvAdb5CO69GSy6u4wF0miYnvTpa8Qa19NonG5jacEVpYaIcFGM80pg2?=
 =?us-ascii?Q?fMzu9w8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 06:01:49.6227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13418879-c50e-4967-efe9-08dc6748b1b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072
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

Check the return of function smum_send_msg_to_smc
as it may fail to initialize the variable.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  |  8 +++++--
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 21 ++++++++++++-------
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 19 +++++++++++------
 .../amd/pm/powerplay/smumgr/smu10_smumgr.c    |  5 ++++-
 4 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 02ba68d7c654..f9f016cb60ce 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1310,13 +1310,17 @@ static int smu10_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 
 	switch (idx) {
 	case AMDGPU_PP_SENSOR_GFX_SCLK:
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetGfxclkFrequency, &sclk);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetGfxclkFrequency, &sclk);
+		if (ret)
+			break;
 			/* in units of 10KHZ */
 		*((uint32_t *)value) = sclk * 100;
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GFX_MCLK:
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetFclkFrequency, &mclk);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetFclkFrequency, &mclk);
+		if (ret)
+			break;
 			/* in units of 10KHZ */
 		*((uint32_t *)value) = mclk * 100;
 		*size = 4;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 1fcd4451001f..5c95eda6cbd2 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -4000,6 +4000,7 @@ static int smu7_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 	uint32_t offset, val_vid;
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
 	struct amdgpu_device *adev = hwmgr->adev;
+	int ret = 0;
 
 	/* size must be at least 4 bytes for all sensors */
 	if (*size < 4)
@@ -4007,12 +4008,16 @@ static int smu7_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 
 	switch (idx) {
 	case AMDGPU_PP_SENSOR_GFX_SCLK:
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_API_GetSclkFrequency, &sclk);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_API_GetSclkFrequency, &sclk);
+		if (ret)
+			return ret;
 		*((uint32_t *)value) = sclk;
 		*size = 4;
 		return 0;
 	case AMDGPU_PP_SENSOR_GFX_MCLK:
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_API_GetMclkFrequency, &mclk);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_API_GetMclkFrequency, &mclk);
+		if (ret)
+			return ret;
 		*((uint32_t *)value) = mclk;
 		*size = 4;
 		return 0;
@@ -4965,13 +4970,14 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
 	struct smu7_odn_dpm_table *odn_table = &(data->odn_dpm_table);
 	struct phm_odn_clock_levels *odn_sclk_table = &(odn_table->odn_core_clock_dpm_levels);
 	struct phm_odn_clock_levels *odn_mclk_table = &(odn_table->odn_memory_clock_dpm_levels);
-	int size = 0;
+	int size = 0, ret = 0;
 	uint32_t i, now, clock, pcie_speed;
 
 	switch (type) {
 	case PP_SCLK:
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_API_GetSclkFrequency, &clock);
-
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_API_GetSclkFrequency, &clock);
+		if (ret)
+			return ret;
 		for (i = 0; i < sclk_table->count; i++) {
 			if (clock > sclk_table->dpm_levels[i].value)
 				continue;
@@ -4985,8 +4991,9 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
 					(i == now) ? "*" : "");
 		break;
 	case PP_MCLK:
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_API_GetMclkFrequency, &clock);
-
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_API_GetMclkFrequency, &clock);
+		if (ret)
+			return ret;
 		for (i = 0; i < mclk_table->count; i++) {
 			if (clock > mclk_table->dpm_levels[i].value)
 				continue;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 9f5bd998c6bf..b47e1ab12430 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -2481,10 +2481,12 @@ static int vega10_populate_and_upload_avfs_fuse_override(struct pp_hwmgr *hwmgr)
 	struct vega10_hwmgr *data = hwmgr->backend;
 	AvfsFuseOverride_t *avfs_fuse_table = &(data->smc_state_table.avfs_fuse_override_table);
 
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
-
-	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
-
+	result = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
+	if (result)
+		return result;
+	result = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
+	if (result)
+		return result;
 	serial_number = ((uint64_t)bottom32 << 32) | top32;
 
 	if (pp_override_get_default_fuse_value(serial_number, &fuse) == 0) {
@@ -3924,11 +3926,16 @@ static int vega10_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 
 	switch (idx) {
 	case AMDGPU_PP_SENSOR_GFX_SCLK:
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetAverageGfxclkActualFrequency, &sclk_mhz);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetAverageGfxclkActualFrequency, &sclk_mhz);
+		if (ret)
+			break;
+
 		*((uint32_t *)value) = sclk_mhz * 100;
 		break;
 	case AMDGPU_PP_SENSOR_GFX_MCLK:
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentUclkIndex, &mclk_idx);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentUclkIndex, &mclk_idx);
+		if (ret)
+			break;
 		if (mclk_idx < dpm_table->mem_table.count) {
 			*((uint32_t *)value) = dpm_table->mem_table.dpm_levels[mclk_idx].value;
 			*size = 4;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
index 7eeab84d421a..ac9ec8257f82 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
@@ -185,10 +185,13 @@ static int smu10_copy_table_to_smc(struct pp_hwmgr *hwmgr,
 static int smu10_verify_smc_interface(struct pp_hwmgr *hwmgr)
 {
 	uint32_t smc_driver_if_version;
+	int ret = 0;
 
-	smum_send_msg_to_smc(hwmgr,
+	ret = smum_send_msg_to_smc(hwmgr,
 			PPSMC_MSG_GetDriverIfVersion,
 			&smc_driver_if_version);
+	if (ret)
+		return ret;
 
 	if ((smc_driver_if_version != SMU10_DRIVER_IF_VERSION) &&
 	    (smc_driver_if_version != SMU10_DRIVER_IF_VERSION + 1)) {
-- 
2.25.1

