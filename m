Return-Path: <SRS0=wnxc=QD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D764C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 10:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB60663219
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 10:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CB60663219
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 383786EE52;
	Tue, 16 Nov 2021 10:30:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3F726EE29
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Nov 2021 10:30:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6aaVhFVU+KZpy6zjhCqcebkQ3q18HP9bzFzH8y1xLMDFISn10Xj7jEwfyFPXFQLKccN5hn6rVenIEsmxK0DqdESRQM+ZldhFOoketyr2gQJaHMyu5sDbH5a0zPFQ647mHfIDqKW0MegqvhgUbg9C/dIuk+9Dc6Na6J/Nu5bzBAfd89bLeZyDYctk+4W/QrXUHQt1+a/vX7eGfnvmRIhLBE0tpJYbsyDxqpJ4GBMwhAP76LUk3MiaBDESKxCdgXKB+7HzG8zHCe3cFqcCOT1R2o5VL5Nym6AkFU+TOsdD2ID4ehYb2Gc8Gpk4iUuBSLz1HoYlEpxM4RQoSOYJ+K51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKbBoSh4K8S0Zl7ozDCVC8HQmjKzODd/zl7Q5BURJlI=;
 b=FDYr9UiJWo4JUjJYAHb3zAA+GLa1CGGbnGSkDNAiZnmeH1pkMOxsSonoIvZ/pU24lCYi3rWkPzYeDu6elU8oTzyWJfu9jfoBFaZ0BDiSYWU7e20gFFKSyWemKsWLVf3pPT6OH93fT9hXTGcQQbBTI4z2XchMoUxNMPZfntz6nsFNZ14KAksaE0CQB9By3RdPKRHbdFFSJokoO5BXsERNeGg4T2fTXaJUd+J9Ycxmovrej0Q88QL7QUkA+EFdfTz8C3/SglqI/9OXzQUhUbBwFFY/35HToyE8fKQ8e2e5FHUzEuUELtMPrOsNerZGgA6oPoEW+avpTrf8Jrp38L/odQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKbBoSh4K8S0Zl7ozDCVC8HQmjKzODd/zl7Q5BURJlI=;
 b=Zd6awE5xUWUVYpmbt9hIVOfrrZuQM4uQQZiLJtqDZuCIz2if4wpa8hqvzFFhTtvXcFDseQSLZbHnBHEbA91UmDArW/9N1xjEU7+Zb7vrZpeMnUgk8hDb5swaW1uI1zOkNWdrK//YqCWgJOUGPs+wVjgk5gFuu1qbTZFqZwy/4g0=
Received: from DM5PR06CA0084.namprd06.prod.outlook.com (2603:10b6:3:4::22) by
 DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.26; Tue, 16 Nov 2021 10:29:58 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::ae) by DM5PR06CA0084.outlook.office365.com
 (2603:10b6:3:4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.17 via Frontend
 Transport; Tue, 16 Nov 2021 10:29:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Tue, 16 Nov 2021 10:29:58 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 16 Nov
 2021 04:29:55 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <john.clements@amd.com>, <stanley.yang@amd.com>, <equan@amd.com>,
 <Lijo.Lazar@amd.com>, <KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: support new mode-1 reset interface (v2)
Date: Tue, 16 Nov 2021 18:28:55 +0800
Message-ID: <20211116102855.3775-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a967026f-9f4d-4c8e-307d-08d9a8ec0a27
X-MS-TrafficTypeDiagnostic: DM6PR12MB4186:
X-Microsoft-Antispam-PRVS: <DM6PR12MB41862FDD4C3B587DBDCBC19DB0999@DM6PR12MB4186.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nbJ/4/EcQljlI09r/BFWExVPfYm3cjaCIJW/LGdGzg7T6ukughBzpijABxJIwPz0vMCmY6pBlfaYKWmCI5UgL4aqrEL7yo3QpTd7NQY93EkXsWKBzMRYYq0qOEJSxT4vXaojX3f1cRKsH7A6jwgkUlyy4U+wG7dDMA0LlkrnEKDgPQS3gnQyiU61sfrkm5Craf/MSpgFLfvaej1c3CB8cYi4Cf1ycjZ/LRI6BlXksEj6n4/pyNDCGYhWGRL5T11creeieIMQw5oc8Yo4lyDVzWLVVrTqoKtksWN/nxwTj038v3Q/pw3KcVdzRz+zsf7MRQU9XDb7koKd9Xtz6HWOTJYlFCgn8adAYofnA3bG0X3M53XE0uyrbnE2vK5Hq1rbvxY1A/LLBq/U4IXIbevltg4eaqjULB4ku/ZFFrjiIE3ibaK7JIO8MVLHP/KTN3HiXUFuvdGuJTJQ8/ddm1da+9wYpeZUzUABGbOiQ1IDq0l4q1azlz2ameNDnSjXafZRLUpHU0cpxYqbPP/CJQC/3K/XOwkHL7Xz3pKNgEfvSE4Pzp0uELCEFeyznhGMDQ3KeSGhspEFzY6mIdBKePzA5A6w0TG1R/Vd6aVNqybkMJsIk0yzd6HX55nCQu2QZK7SrQzz69qcnI495gVEPM2JmmeeNUeRx+KUwbmT5XtI4OAZS1gYMMeqjyYvPEu4trsLurORlFk4nJjzUzrr7ctTQ73ZvYxMJE2qpXQnY1cK8/Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(426003)(316002)(8676002)(2616005)(8936002)(83380400001)(508600001)(36756003)(26005)(70586007)(70206006)(1076003)(16526019)(356005)(86362001)(4326008)(186003)(7696005)(47076005)(6636002)(82310400003)(5660300002)(2906002)(36860700001)(336012)(110136005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 10:29:58.4655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a967026f-9f4d-4c8e-307d-08d9a8ec0a27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If gpu reset is triggered by ras fatal error, tell it to smu in mode-1
reset message.

v2: move mode-1 reset function to aldebaran_ppt.c since it's aldebaran
specific currently.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v13_0.h        |  3 +-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 36 ++++++++++++++++++-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 21 -----------
 3 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
index e5d3b0d1a032..bbc608c990b0 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
@@ -29,6 +29,8 @@
 #define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x04
 #define SMU13_DRIVER_IF_VERSION_ALDE 0x07
 
+#define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
+
 /* MP Apertures */
 #define MP0_Public			0x03800000
 #define MP0_SRAM			0x03900000
@@ -216,7 +218,6 @@ int smu_v13_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 int smu_v13_0_baco_enter(struct smu_context *smu);
 int smu_v13_0_baco_exit(struct smu_context *smu);
 
-int smu_v13_0_mode1_reset(struct smu_context *smu);
 int smu_v13_0_mode2_reset(struct smu_context *smu);
 
 int smu_v13_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type clk_type,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 59a7d276541d..e50d4491aa96 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1765,6 +1765,40 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v1_3);
 }
 
+static int aldebaran_mode1_reset(struct smu_context *smu)
+{
+	u32 smu_version, fatal_err, param;
+	int ret = 0;
+	struct amdgpu_device *adev = smu->adev;
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	fatal_err = 0;
+	param = SMU_RESET_MODE_1;
+
+	/*
+	* PM FW support SMU_MSG_GfxDeviceDriverReset from 68.07
+	*/
+	smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	if (smu_version < 0x00440700)
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
+	else {
+		/* fatal error triggered by ras, PMFW supports the flag
+		   from 68.44.0 */
+		if ((smu_version >= 0x00442c00) && ras &&
+		    atomic_read(&ras->in_recovery))
+			fatal_err = 1;
+
+		param |= (fatal_err << 16);
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+					SMU_MSG_GfxDeviceDriverReset, param, NULL);
+	}
+
+	if (!ret)
+		msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
+
+	return ret;
+}
+
 static int aldebaran_mode2_reset(struct smu_context *smu)
 {
 	u32 smu_version;
@@ -1925,7 +1959,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.get_gpu_metrics = aldebaran_get_gpu_metrics,
 	.mode1_reset_is_support = aldebaran_is_mode1_reset_supported,
 	.mode2_reset_is_support = aldebaran_is_mode2_reset_supported,
-	.mode1_reset = smu_v13_0_mode1_reset,
+	.mode1_reset = aldebaran_mode1_reset,
 	.set_mp1_state = aldebaran_set_mp1_state,
 	.mode2_reset = aldebaran_mode2_reset,
 	.wait_for_event = smu_v13_0_wait_for_event,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 35145db6eedf..4d96099a9bb1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -60,8 +60,6 @@ MODULE_FIRMWARE("amdgpu/aldebaran_smc.bin");
 
 #define SMU13_VOLTAGE_SCALE 4
 
-#define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
-
 #define LINK_WIDTH_MAX				6
 #define LINK_SPEED_MAX				3
 
@@ -1424,25 +1422,6 @@ int smu_v13_0_set_azalia_d3_pme(struct smu_context *smu)
 	return ret;
 }
 
-int smu_v13_0_mode1_reset(struct smu_context *smu)
-{
-	u32 smu_version;
-	int ret = 0;
-	/*
-	* PM FW support SMU_MSG_GfxDeviceDriverReset from 68.07
-	*/
-	smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if (smu_version < 0x00440700)
-		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
-	else
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset, SMU_RESET_MODE_1, NULL);
-
-	if (!ret)
-		msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
-
-	return ret;
-}
-
 static int smu_v13_0_wait_for_reset_complete(struct smu_context *smu,
 					     uint64_t event_arg)
 {
-- 
2.17.1

