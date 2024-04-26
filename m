Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318C5C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 09:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D88910F8C6;
	Fri, 26 Apr 2024 09:53:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4tKo+StG";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 595B010F734
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 09:53:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chpgv5i/47WK+I1qUHFedo4GSLtp0TooZsXZGl2aG/cw+TCAk4q8k+S6maCpp4fRAGT6eOM2H1MfYX2jCo2fHjZsAwSlT++ZxckMSBk4qPFJF6k30uKvqkwoDNMu3SH/NaNf0kTAFM76yXSOM1+rJPvPnE0qXKf8MRSUNTChBixgfrPbtM/2fLABkvbTGP/1yfXc5FJNw/WXqOaniGfLnCKvfEhkgBP1oKNl+bYwxaAtbBb8cVGnxIjnxttItFhpCXkp6zE8ZSIfMyWxvJfr2VZ0+1Czo9uMe2kGbupqN8+rZQ6V/hSTLSOsYwvZ91SEs+nUFkz5LkE2sevnjcyv6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xejLgAxM5/Flqp3sLxvPvbK3K5aG/die2nX82Du1Hpw=;
 b=XU51b8myC2HGWd3pgzP2NacNMwP4DEaG9pfiY7Ch3my9lhZwOG+JRLStxnYfVlKiMyGxetYDliUCW01Wgc0kQMENqQakr0Layqdz4xjpUi3nMtWmX98XUlwcVoW5lCSyd8Stv5XmQerw+Z7zwV67NOGWdSBE9jPzr7nT3Y5d/ChAM9woyg5cLELNUWf4/15TxXHQCfB6lnZp8DX2F3C4VxUgcQU4tnM4oUWjW7aIOw+I85cQN0c7F0UaORMNadUbA4ZiQkowCmGiolpRlett/eNOgmkDDmkZY4NKU8n3au40H7K2txnvdrHp3grjjxG7sO/k08DPaeWRSDJWGKDAqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xejLgAxM5/Flqp3sLxvPvbK3K5aG/die2nX82Du1Hpw=;
 b=4tKo+StG/61zmSQbt/7k8/2Fq3HC567keo1xkq8fJnEQytI/IeJBcYpae43NSprickWEbWssyzJFBSrTawW4zcaVGOnxswrJna5PyrUeHe8o5GSF4m3+ntHFpSYIaGsmO3SCX0bLdB0zglvU+5rnGxNz4VEm+sN+nA9aFOyROmA=
Received: from DM6PR12CA0028.namprd12.prod.outlook.com (2603:10b6:5:1c0::41)
 by DS0PR12MB8766.namprd12.prod.outlook.com (2603:10b6:8:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Fri, 26 Apr
 2024 09:52:56 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:1c0:cafe::33) by DM6PR12CA0028.outlook.office365.com
 (2603:10b6:5:1c0::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.29 via Frontend
 Transport; Fri, 26 Apr 2024 09:52:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 09:52:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 04:52:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 04:52:55 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 26 Apr 2024 04:52:48 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: fix uninitialized variable warning
Date: Fri, 26 Apr 2024 17:52:43 +0800
Message-ID: <20240426095243.1075290-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|DS0PR12MB8766:EE_
X-MS-Office365-Filtering-Correlation-Id: df581bdf-73c1-4967-db96-08dc65d6a65b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400014|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qtIp9sMhtd5or7dOxx9aSijDYSrWVXah26sZWYmb2dGsVhFuH55F+gzF/EPK?=
 =?us-ascii?Q?LuQkjS677IT0MQIoB6alXu70MbMJFL8sI4Z2etZAuOsIZXhkzXrIsRqr1uVH?=
 =?us-ascii?Q?LTOXvFGUqJh0/kwW7kl14OG1l/M7/VI/+XUAdluZcC334RatR1qHsl1APQ0m?=
 =?us-ascii?Q?8OR4qodnzgGSpjTdpD7Y++6ZB8r/48hCejN99pygryzx2xXFVc88MQJ8cbFu?=
 =?us-ascii?Q?wJVgFf5rNZHZ9iv+/Gk1eFk9IWqUGtRehYIkungjeKIU10GgNdEGHLDmgTg6?=
 =?us-ascii?Q?KpYBATyGGigNWTAIPwkwabZ9A0mTn8LRo5ZyvgC/EjvG845IUuuUvuh1JFP1?=
 =?us-ascii?Q?OIGNbxWtr0jMHUk370Goyp54hIdpHaYNZXIIH5WY4JtrGrpj4oLLkSmLNf9F?=
 =?us-ascii?Q?6DPdA7hv2uaaipgM09A6yPpWGBQoC1m1zPStd4g8Eoo4fBAdateTFkI1XlKI?=
 =?us-ascii?Q?fE9bhbwVo1T0hq3eK15qfDlP+DNh9gWQW7MT8EMeKdxf7YTqZEYTcdQ0c3dr?=
 =?us-ascii?Q?N/a8D/D+XOzJc6lXx3/HvZKh7dTX1iKJ0uezYoKIbJfmdUbpPHxdcEGB05fu?=
 =?us-ascii?Q?WNATUHNFuTkmYBtVHrRBnL4Z1bTEoj4fSRtn+PodeIDIkZilx16T4ot1h92m?=
 =?us-ascii?Q?Iq/qn3b/r+ungu/8VVz13DlbEgFWfgHu3B/FunjSlxsDt7HX9tnMt04Nr0GD?=
 =?us-ascii?Q?aYRsv+82s20CRpfP5Z46l/drVs/PnEn4f0/yEsq9RuwyeZjAusHAbgKLZtaO?=
 =?us-ascii?Q?SN7qv0eWYUSvZshtis59faJNH7MYDgISmmWjPNB65QFcYiFOYPMcx83KvD5j?=
 =?us-ascii?Q?iTIaODKVkEVQpyve164kgVq3IvVe0hi+bq8A3D/umcyl9ZbXo67qgNj7BS9y?=
 =?us-ascii?Q?68xN2grO4kic9VWTOB+fgaXdcOlZLTm14pXveaddyGV+CjOy8l+pLQbDLytP?=
 =?us-ascii?Q?VmhdNI38aeM/ffh8sKHskDhxZY5Lm68P4/Smhnbv7mrevOJQK9kaAcspC15d?=
 =?us-ascii?Q?enT/2Kvhv0SFPwBHu9vu0edf5DRjjV/DsMUZpICqALpEn5vr7zEH/fuTaw72?=
 =?us-ascii?Q?kMJzbkAhpvxje6Nfiz7v4Ij/Ny5os/5mmbfnGyjqvHXUda0/WigcYMqnLUd6?=
 =?us-ascii?Q?ET0JjJ94MkxXrimxbKKsjYXeSJYR4XJubMf/u1Cf5ZuOa2q0buln36WknSJP?=
 =?us-ascii?Q?YCrvSjVC4xt5LYUiJSFvK05wt1qvLpaiuDu/PhWc088pDjzzhDDpRN4EU5Fn?=
 =?us-ascii?Q?gXHtlA/TeCe36BQxuEwXq2cgU8ly3aOnN7RXLewp6GBbOOd+3FsvYSz1xRvF?=
 =?us-ascii?Q?dqm3YGL90ZnCIHFlFpUwZ/cfeIZMb5ACaioDI/g+HeHqdZcvfmUY++Qn+Y6Q?=
 =?us-ascii?Q?gYhANoQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 09:52:56.6962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df581bdf-73c1-4967-db96-08dc65d6a65b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8766
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
+		result;
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

