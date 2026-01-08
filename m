Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FA8D1489F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 04:49:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA19010E67E;
	Thu,  8 Jan 2026 04:49:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KS+rMC6X";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28E9710E680
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 04:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEGk9gevPZ9jkGcwzonTPisRYkQob0yhs8NQrD6vwbyrsEhUiDHVERICLymbJdwkESWbepdemZCEsoDclvo1XGjjCLmGhE1OAcFQnU2mAkLtzJOoxL2shALqPqqdsaOf5Lotnnnjwc0rXhEoDBHXNoi819rFaibWDH2Q9KkoQY6y3nqs8Bx6UEbTWNbZvEjUjxXTQCLn8ftbX64aop8173OrsmVT7ytVtMIrPhvRd5ZC5J/lbENUKBFU4ZOTBHCj98zqDNUNxWBVfA0alMXvF1ertgZFAl9Jr2EVYRQwFBdQXqx2Jj174KUZnGZTd9+E9drqBZKVTx/lsEIvmDnZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwef30xxZjzBJeCxGEWJdpR4ws4WBh/SKFHUb0ph88k=;
 b=Vd1s9/OKuafnrJSDqwfOZk7ozTEit6j2BRl2hid3/ALZpSXxVxw6vpiEbpYg84lRYlgXTZnl9vJMVAvyHWcPoZTToBqk6m/UkPxb2clOdN6J5NkYKVMCYriOl3sR9go2YLxB7rmYS0hITNQ/fIDvWRSjWG+0FLfAs1ozAx5Ahp0NGPinfEdbHkWHbdJdNwhvgVHWIkbtq/A3nOmMAKReY3DBYRwgqmcYMoBF2oCcaCeMyTRr2wwG57BsN7c0hZncMM2fGCoB2Gh3fng02wu2z14z7QeYLavDievP6RgIJOtx/x326GftB8Xa/vKZmbNEHuvqFx6gjxNT45ly7TT7Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwef30xxZjzBJeCxGEWJdpR4ws4WBh/SKFHUb0ph88k=;
 b=KS+rMC6XEHMmNfwiaByIGwNUo3ypHx0+9Np3f5aKN3ZmGgUheNA+pXZX+4ytB6svkNyQRRDqFVCfhevrK4tK6ChqtSJsW5bhoT/khD9F8cVET4/drmOwIpmNdVnG+HaPpSkjC+XclRV+JDdaoornwJxkkzDbVbDdN+q6w8CztpE=
Received: from DM6PR06CA0048.namprd06.prod.outlook.com (2603:10b6:5:54::25) by
 DS7PR12MB6094.namprd12.prod.outlook.com (2603:10b6:8:9d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.2; Thu, 8 Jan 2026 04:49:33 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:54:cafe::8b) by DM6PR06CA0048.outlook.office365.com
 (2603:10b6:5:54::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 04:49:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Thu, 8 Jan 2026 04:49:33 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 22:49:30 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v3 09/24] drm/amd/pm: Replace without wait with async calls
Date: Thu, 8 Jan 2026 10:17:25 +0530
Message-ID: <20260108044839.4084279-10-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260108044839.4084279-1-lijo.lazar@amd.com>
References: <20260108044839.4084279-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|DS7PR12MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: 289b9841-cd67-4752-f1d5-08de4e71514a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KSajV4gyGoGchLw90bH4z5jwjRWYKoWFwRNp8isht7T3DIrmy/UBFtTnPfFl?=
 =?us-ascii?Q?Pw6gWiY1AU/YVW7425uPftZXcFAm2R9FHE7s+8/o+98go0hn+9l4p8XzIYYq?=
 =?us-ascii?Q?1fCzveelSMUQjwPGUvAUjGkDW/jqQ9GCmaCEo9MQcnxNY8LneX4F2Q/Ll0MM?=
 =?us-ascii?Q?11VP663QZQuOC2KVMNTR9m00PFDA3yJLHFyqAMZgkr8AlP6VoyJiOGfAz0OT?=
 =?us-ascii?Q?g7WyUYjapPTkTL0KRDvkcjLEKTiYJjNMR6av2puxRpEeHKfkGtGUGhc8J0XF?=
 =?us-ascii?Q?wu5dWcR6j82oNfxOURGOBm6llzLZlC9aDkBNFFo9gPm5JFDqdSraua1qS5VX?=
 =?us-ascii?Q?/kSsfikbP5hTnVroxTCmzApqBI0lr3sHih4aqVcddjJBjHMWWieLQpgvm1rH?=
 =?us-ascii?Q?2s2PYmcrUoSeROSOyO48xCIIgoiXNqSHIcjYwbiL7wXkOYLlIDSr9RMhC32C?=
 =?us-ascii?Q?BYoRFE9rxZj2DJj8OLUEXUNSk2brtyH9TUU+EwUQmX3N+uQpWbzTBiJa5UHG?=
 =?us-ascii?Q?6QJ4Lz8BxDISdNuYMN3V4bGzmZUdE82cMbgOQLD9OMaxvnJHeeoW0nNznMNb?=
 =?us-ascii?Q?vbtVbBATG3CaaGZPGAKvUHX5JlUrPqAW3jX0OfQEnuKuI4barZwPegPnLsQ6?=
 =?us-ascii?Q?ugweZVFKBcpAMhtfnphDscwomIDSkZpZKEREgVM4nLMO/SHdJcXGxf10cSAU?=
 =?us-ascii?Q?P7450c0nkj+SxyN1k+TmGld2ONHwdIdeuxer+4nCNNv52tAIt7lsGnlP3U/7?=
 =?us-ascii?Q?6U0Ae4QcIdh/1bCB65npxXFICNjneBcMXPxVY3pF038rjCy9ADRDB4j4NTaN?=
 =?us-ascii?Q?Li9SUQ6tddDzjxNkifqxWhPqVlTA+0FJQo+cvNChkA+qvtd8hp2JG5+Skuiu?=
 =?us-ascii?Q?f8XFur1qEwKTukmOZLbQyXGroXI3IJwQbmY0nNlMmM3N4KDdSEtlg9JPuREK?=
 =?us-ascii?Q?mM1L9j/wKBXL7i+Qy9ApoJtV02fIah5uFUlgWXNIaU4uZcCQ9VqTEFThp5i7?=
 =?us-ascii?Q?q4WSAT66SBRqZxij1chga3lbKRHih/Coz7XVT8Gvc6SFYsrtdka3zXjZO9cC?=
 =?us-ascii?Q?7XVZlPsA9ihD87gJc6UWEYdCE1auM0Dn0L41Si8sZL1II8nWSRrOmBgpjQ/D?=
 =?us-ascii?Q?6xegF/qJ+Llzs+B1mhVubvAOQaBEXGAsqAWJ8YnWn1bx6u4J1PEuvZLh+wDj?=
 =?us-ascii?Q?86u89ZpRskO/uuJnc/996ulsdBchFAJsDw4NL9d10B7v2FfxIpy/sZPu8MOA?=
 =?us-ascii?Q?s8ZV5Iy1wRUoC8TFWSl09ncpXmscB5P4tb3ZfHqAVtfkt4C+9Le0hrNMc+fY?=
 =?us-ascii?Q?HF4TBPYY+CoyEQ95q0Ty4daIzKDwbbUB0DFT9+FVYXdj+8oZXYA2iO+fxjQs?=
 =?us-ascii?Q?cPNlRT4TL9rAWfLdHg7j2TLIe70luar8LIlst6lMxYb0IPItiYZyD4jROtRe?=
 =?us-ascii?Q?JgY8FCdUCs0y7iqSXc5/ZImXFUxEZArr7PesmXbAeLbEjAfoVf3pHIjEcj9T?=
 =?us-ascii?Q?FbkfuUcEwgwRqULHPk7mxkjoc1QxkuoxsqEvvj4F8EOxN169huBUTOG443Ss?=
 =?us-ascii?Q?tK1X+JYoFy3kXbP3fdk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:49:33.4538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 289b9841-cd67-4752-f1d5-08de4e71514a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6094
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

Use the new async locked message function instead of without_waiting
messaging function.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 22 ++++++++---------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 16 ++++---------
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 24 ++++++++++---------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 13 ++++++----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 24 +++++++++----------
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 12 ++++++----
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    | 12 ++++++----
 7 files changed, 64 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 9ea6b0d1954b..087b4b6ce857 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3043,21 +3043,21 @@ static int sienna_cichlid_stb_get_data_direct(struct smu_context *smu,
 
 static int sienna_cichlid_mode2_reset(struct smu_context *smu)
 {
-	int ret = 0, index;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
 	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
 	int timeout = 100;
 
-	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-						SMU_MSG_DriverMode2Reset);
-
-	mutex_lock(&smu->message_lock);
+	mutex_lock(&ctl->lock);
 
-	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index,
-					       SMU_RESET_MODE_2);
+	ret = smu_msg_send_async_locked(ctl, SMU_MSG_DriverMode2Reset,
+					SMU_RESET_MODE_2);
+	if (ret)
+		goto out;
 
-	ret = smu_cmn_wait_for_response(smu);
+	ret = smu_msg_wait_response(ctl, 0);
 	while (ret != 0 && timeout) {
-		ret = smu_cmn_wait_for_response(smu);
+		ret = smu_msg_wait_response(ctl, 0);
 		/* Wait a bit more time for getting ACK */
 		if (ret != 0) {
 			--timeout;
@@ -3075,11 +3075,11 @@ static int sienna_cichlid_mode2_reset(struct smu_context *smu)
 		goto out;
 	}
 
-	dev_info(smu->adev->dev, "restore config space...\n");
+	dev_info(adev->dev, "restore config space...\n");
 	/* Restore the config space saved during init */
 	amdgpu_device_load_pci_state(adev->pdev);
 out:
-	mutex_unlock(&smu->message_lock);
+	mutex_unlock(&ctl->lock);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index a645094b029b..fe1924289040 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2272,18 +2272,12 @@ static int vangogh_post_smu_init(struct smu_context *smu)
 
 static int vangogh_mode_reset(struct smu_context *smu, int type)
 {
-	int ret = 0, index = 0;
-
-	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-					       SMU_MSG_GfxDeviceDriverReset);
-	if (index < 0)
-		return index == -EACCES ? 0 : index;
-
-	mutex_lock(&smu->message_lock);
-
-	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, type);
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+	int ret;
 
-	mutex_unlock(&smu->message_lock);
+	mutex_lock(&ctl->lock);
+	ret = smu_msg_send_async_locked(ctl, SMU_MSG_GfxDeviceDriverReset, type);
+	mutex_unlock(&ctl->lock);
 
 	mdelay(10);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index a3f4b25ac474..76edb54972dc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1828,26 +1828,28 @@ static int aldebaran_mode1_reset(struct smu_context *smu)
 
 static int aldebaran_mode2_reset(struct smu_context *smu)
 {
-	int ret = 0, index;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
 	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
 	int timeout = 10;
 
-	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-						SMU_MSG_GfxDeviceDriverReset);
-	if (index < 0 )
-		return -EINVAL;
-	mutex_lock(&smu->message_lock);
+	mutex_lock(&ctl->lock);
+
 	if (smu->smc_fw_version >= 0x00441400) {
-		ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, SMU_RESET_MODE_2);
+		ret = smu_msg_send_async_locked(ctl, SMU_MSG_GfxDeviceDriverReset,
+						SMU_RESET_MODE_2);
+		if (ret)
+			goto out;
+
 		/* This is similar to FLR, wait till max FLR timeout */
 		msleep(100);
-		dev_dbg(smu->adev->dev, "restore config space...\n");
+		dev_dbg(adev->dev, "restore config space...\n");
 		/* Restore the config space saved during init */
 		amdgpu_device_load_pci_state(adev->pdev);
 
-		dev_dbg(smu->adev->dev, "wait for reset ack\n");
+		dev_dbg(adev->dev, "wait for reset ack\n");
 		while (ret == -ETIME && timeout)  {
-			ret = smu_cmn_wait_for_response(smu);
+			ret = smu_msg_wait_response(ctl, 0);
 			/* Wait a bit more time for getting ACK */
 			if (ret == -ETIME) {
 				--timeout;
@@ -1870,7 +1872,7 @@ static int aldebaran_mode2_reset(struct smu_context *smu)
 	if (ret == 1)
 		ret = 0;
 out:
-	mutex_unlock(&smu->message_lock);
+	mutex_unlock(&ctl->lock);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index e5996162fd5c..b941ab24f823 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2244,18 +2244,21 @@ int smu_v13_0_baco_exit(struct smu_context *smu)
 
 int smu_v13_0_set_gfx_power_up_by_imu(struct smu_context *smu)
 {
-	uint16_t index;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
 	struct amdgpu_device *adev = smu->adev;
+	int ret;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnableGfxImu,
 						       ENABLE_IMU_ARG_GFXOFF_ENABLE, NULL);
 	}
 
-	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-					       SMU_MSG_EnableGfxImu);
-	return smu_cmn_send_msg_without_waiting(smu, index,
-						ENABLE_IMU_ARG_GFXOFF_ENABLE);
+	mutex_lock(&ctl->lock);
+	ret = smu_msg_send_async_locked(ctl, SMU_MSG_EnableGfxImu,
+					ENABLE_IMU_ARG_GFXOFF_ENABLE);
+	mutex_unlock(&ctl->lock);
+
+	return ret;
 }
 
 int smu_v13_0_od_edit_dpm_table(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index a9789f3a23b0..cf011fc3bb61 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2897,24 +2897,22 @@ static void smu_v13_0_6_restore_pci_config(struct smu_context *smu)
 
 static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
 {
-	int ret = 0, index;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
 	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
 	int timeout = 10;
 
-	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-					       SMU_MSG_GfxDeviceDriverReset);
-	if (index < 0)
-		return index;
-
-	mutex_lock(&smu->message_lock);
+	mutex_lock(&ctl->lock);
 
-	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index,
-					       SMU_RESET_MODE_2);
+	ret = smu_msg_send_async_locked(ctl, SMU_MSG_GfxDeviceDriverReset,
+					SMU_RESET_MODE_2);
+	if (ret)
+		goto out;
 
 	/* Reset takes a bit longer, wait for 200ms. */
 	msleep(200);
 
-	dev_dbg(smu->adev->dev, "restore config space...\n");
+	dev_dbg(adev->dev, "restore config space...\n");
 	/* Restore the config space saved during init */
 	amdgpu_device_load_pci_state(adev->pdev);
 
@@ -2932,9 +2930,9 @@ static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
 	if (!(adev->flags & AMD_IS_APU))
 		smu_v13_0_6_restore_pci_config(smu);
 
-	dev_dbg(smu->adev->dev, "wait for reset ack\n");
+	dev_dbg(adev->dev, "wait for reset ack\n");
 	do {
-		ret = smu_cmn_wait_for_response(smu);
+		ret = smu_msg_wait_response(ctl, 0);
 		/* Wait a bit more time for getting ACK */
 		if (ret == -ETIME) {
 			--timeout;
@@ -2948,7 +2946,7 @@ static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
 	} while (ret == -ETIME && timeout);
 
 out:
-	mutex_unlock(&smu->message_lock);
+	mutex_unlock(&ctl->lock);
 
 	if (ret)
 		dev_err(adev->dev, "failed to send mode2 reset, error code %d",
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 8f7f293de3d8..f85ba23f9d99 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1834,17 +1834,21 @@ int smu_v14_0_baco_exit(struct smu_context *smu)
 
 int smu_v14_0_set_gfx_power_up_by_imu(struct smu_context *smu)
 {
-	uint16_t index;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
 	struct amdgpu_device *adev = smu->adev;
+	int ret;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnableGfxImu,
 						       ENABLE_IMU_ARG_GFXOFF_ENABLE, NULL);
 	}
 
-	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-					       SMU_MSG_EnableGfxImu);
-	return smu_cmn_send_msg_without_waiting(smu, index, ENABLE_IMU_ARG_GFXOFF_ENABLE);
+	mutex_lock(&ctl->lock);
+	ret = smu_msg_send_async_locked(ctl, SMU_MSG_EnableGfxImu,
+					ENABLE_IMU_ARG_GFXOFF_ENABLE);
+	mutex_unlock(&ctl->lock);
+
+	return ret;
 }
 
 int smu_v14_0_set_default_dpm_tables(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 631bdf387163..6557085a7c72 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -1709,17 +1709,21 @@ int smu_v15_0_baco_exit(struct smu_context *smu)
 
 int smu_v15_0_set_gfx_power_up_by_imu(struct smu_context *smu)
 {
-	uint16_t index;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
 	struct amdgpu_device *adev = smu->adev;
+	int ret;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnableGfxImu,
 						       ENABLE_IMU_ARG_GFXOFF_ENABLE, NULL);
 	}
 
-	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-					       SMU_MSG_EnableGfxImu);
-	return smu_cmn_send_msg_without_waiting(smu, index, ENABLE_IMU_ARG_GFXOFF_ENABLE);
+	mutex_lock(&ctl->lock);
+	ret = smu_msg_send_async_locked(ctl, SMU_MSG_EnableGfxImu,
+					ENABLE_IMU_ARG_GFXOFF_ENABLE);
+	mutex_unlock(&ctl->lock);
+
+	return ret;
 }
 
 int smu_v15_0_set_default_dpm_tables(struct smu_context *smu)
-- 
2.49.0

