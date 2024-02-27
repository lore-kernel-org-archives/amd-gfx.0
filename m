Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A65C54798
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Feb 2024 16:35:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C74D010E3C7;
	Tue, 27 Feb 2024 16:35:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1+zVOYms";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6F1710E3C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Feb 2024 16:35:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ykq1/j1GcMPVTAnuYH9cGpzql/q3JoWl64nrCF/UPoSz/KIvW1Bmdm/Jer28/TslWMQ8f9zzKGKZ3rACP8AJMfpKesowo0mSj9MtK+dye6oV3eOEiBnPWMM32L8daPMdM9h8GjbNEGKlh9fwK8/R9VA7NWgd7x+ZjFwjl1zqSxAqO2/U8Wbxv8tVmjeXPj1EcaV4C6Wwjm4papT0v6MJyuehMK2StFQZpzfaF/4L7DO7s2mz1opD/7ihgzE1KwAkzgbW2xXEZG5x8F9LG8QCyVGrcnqVlwnKE25PcssgxnWdASygLM/2SAliqbBqfL3HZMSGS3RNipIwgZHNvVwhGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HE4uctGCH+TQrVMVsR6PbUVuPeYgaazCLr6nqPBzCMQ=;
 b=AhoC+R261kpGF/rFiYPgrX3s3zMiJTN9QN9SAcIVlAM+PdoCUFhihDcmvDN3qNt6T0JfILAnU1cS/g33qDR+Dir9jsb03pxc9oGK3qiicioMuGn32iJFqwW0IhKqIf9GCvMV3nuImVmfB8gU1YkUHrkjod6GQKs6ffm8lFaB6FFW6toUnBQ67OCF+nmmr/3pNIEri9V8dkJaJv+K3KHJev6kaUsrc4Cjrf9MyjpKMaA3JyoXaIeOhCGko83qd2ZWoPVtxuxxhqIo7UyxCaFMLoQ2MsJNfi+Dks9ns4sgRbKTMfVpXky3ur0GGLvh8SpAcd7j741BEQ+CpEN3tazXVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE4uctGCH+TQrVMVsR6PbUVuPeYgaazCLr6nqPBzCMQ=;
 b=1+zVOYmsnSEMFayiT/WBcZElq9RzM3Hch9zq1KFWUiDL+ekPwRKsX2+7uzfHC3Wa9u7ZcMurNNcDTV26f6zudVARLfrGgI+HVpfc5qc2bT2Pnffl7kJnt1EUBGb9RqcQ1RghVDV27716BEEI7K+JPepqLKMzOYarneqVMBMNqo4=
Received: from DM6PR02CA0124.namprd02.prod.outlook.com (2603:10b6:5:1b4::26)
 by SJ2PR12MB9244.namprd12.prod.outlook.com (2603:10b6:a03:574::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 16:35:26 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::41) by DM6PR02CA0124.outlook.office365.com
 (2603:10b6:5:1b4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Tue, 27 Feb 2024 16:35:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 16:35:25 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 10:35:23 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Fix multiple truncation issues in multiple driver
 files
Date: Tue, 27 Feb 2024 22:05:10 +0530
Message-ID: <20240227163510.2934013-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|SJ2PR12MB9244:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f29b2c-97a3-4a3f-2581-08dc37b219e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hlPn15BBB6damh685ox7B26923VzWf6fArSniF2UEmjpaCIymWZjS3K1P4+x3TIwqWhBKwtqmpJGqRdSwAwwkhtCOJV8SKuC2RVEXImppJe7mcFTQ0dYgkE+pHCQLnC+VFxs3BmDa/IO4wDcK7J3Lutj3/Oxru4ZCk/tH5FZ1g+4DzeuXyzmqmdZOzjl+NuVWFxE2McyYR0r335YEo/16ukM5pzCV9SdbVvHGleEcEMkMrhBwPjieIdJOtGVtcmEIyFYUuk9TAHLrDO99sF4uoiVRCx/A9VLYEXLCrTYm3gtlByay4uozRX+nh9VBweiflYpQD6m87Tc9Gx30L3AE+xyQfi1VvxqEvVuNgSFLvBDAQeqBKAhrlo615p3HfhaMaNRrcCReZlK8pQDQwR6pHV/fLXipqsYOCmxSGpD2RA1PQL3XwT096zxinaDuXuAAv5LFPaM5ImrG9DIZ58IW7Xp2Q0sp2S3ep0G+pfJWWbXC1PBgVycuYL5Rw4iWV8YVwId4qFpWNF4u+McQleUxDXA0eSCk+x7tRhEyFIofRGo3ZulnrZF0ndBnf4J8SKi+KAX5R1+qOHO3TcVU98L1yLU7uV9LEYr5rwiPaCNG6ghxE0Sv18gU2rzHponAACmcRbN03nSaL03YRxjbeiiTYj/pqaA2iDiKmR9aVYHD9QDm71or7HG5AcKDf3kCoT0GJFKFKIW2i4eRxxDU7KnlPa6JKpzJW/FOgLqdTNznT9nUU54rJY0z5V1iR+RRWCe
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(230273577357003)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 16:35:25.7180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f29b2c-97a3-4a3f-2581-08dc37b219e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9244
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

Fixes snprintf function by writing more bytes into various buffers than
they can hold.

In several files - smu_v13_0.c, gfx_v11_0.c, gfx_v10_0.c, gfx_v9_0.c,
and amdgpu_mes.c. They were related to different directives, such as
'%s', '_pfp.bin', '_me.bin', '_rlc.bin', '_mec.bin', '_mec2', and
'_mes.bin'.

The buffers sizes have been adjusted to accommodate the maximum possible
string size.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0.c:108:52: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:523:54: warning: ‘_pfp.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:540:54: warning: ‘_me.bin’ directive output may be truncated writing 7 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:557:70: warning: ‘_rlc.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:569:54: warning: ‘_mec.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3979:58: warning: ‘%s’ directive output may be truncated writing up to 4 bytes into a region of size between 0 and 29 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3985:57: warning: ‘%s’ directive output may be truncated writing up to 4 bytes into a region of size between 1 and 30 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3991:57: warning: ‘%s’ directive output may be truncated writing up to 4 bytes into a region of size between 1 and 30 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3998:62: warning: ‘_rlc.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:4014:58: warning: ‘%s’ directive output may be truncated writing up to 4 bytes into a region of size between 0 and 29 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:4021:54: warning: ‘_mec2’ directive output may be truncated writing 5 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1255:52: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1261:52: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1267:52: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1303:60: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1309:60: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1311:60: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1344:60: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1346:60: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1356:68: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1358:68: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1486:66: warning: ‘%s’ directive output may be truncated writing up to 1 bytes into a region of size between 0 and 29 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1481:66: warning: ‘%s’ directive output may be truncated writing 1 byte into a region of size between 0 and 29 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1481:66: warning: ‘%s’ directive output may be truncated writing 2 bytes into a region of size between 0 and 29 [-Wformat-truncation=]
drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1493:62: warning: ‘_mes.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c        | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c        | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c         | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c         | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c          | 6 +++---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index dd2b8f3fa2f1..cfe82f399558 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1471,7 +1471,7 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
 	const struct mes_firmware_header_v1_0 *mes_hdr;
 	struct amdgpu_firmware_info *info;
 	char ucode_prefix[30];
-	char fw_name[40];
+	char fw_name[47];
 	bool need_retry = false;
 	int r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index b2535023764f..8e8cf44acfcf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -92,7 +92,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
 int amdgpu_vcn_early_init(struct amdgpu_device *adev)
 {
 	char ucode_prefix[30];
-	char fw_name[40];
+	char fw_name[42];
 	int r;
 
 	amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 691fa40e4e01..c91283b38b02 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3961,7 +3961,7 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdgpu_device *adev)
 
 static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 {
-	char fw_name[40];
+	char fw_name[50];
 	char ucode_prefix[30];
 	const char *wks = "";
 	int err;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0d90d60a21d6..9cde763bbc3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -509,7 +509,7 @@ static void gfx_v11_0_check_fw_cp_gfx_shadow(struct amdgpu_device *adev)
 
 static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 {
-	char fw_name[40];
+	char fw_name[46];
 	char ucode_prefix[30];
 	int err;
 	const struct rlc_firmware_header_v2_0 *rlc_hdr;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 7669f82aa1da..ad2a5c6ecb93 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1249,7 +1249,7 @@ static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
 static int gfx_v9_0_init_cp_gfx_microcode(struct amdgpu_device *adev,
 					  char *chip_name)
 {
-	char fw_name[30];
+	char fw_name[46];
 	int err;
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
@@ -1282,7 +1282,7 @@ static int gfx_v9_0_init_cp_gfx_microcode(struct amdgpu_device *adev,
 static int gfx_v9_0_init_rlc_microcode(struct amdgpu_device *adev,
 				       char *chip_name)
 {
-	char fw_name[30];
+	char fw_name[53];
 	int err;
 	const struct rlc_firmware_header_v2_0 *rlc_hdr;
 	uint16_t version_major;
@@ -1337,7 +1337,7 @@ static bool gfx_v9_0_load_mec2_fw_bin_support(struct amdgpu_device *adev)
 static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
 					      char *chip_name)
 {
-	char fw_name[30];
+	char fw_name[50];
 	int err;
 
 	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_ALDEBARAN))
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 48170bb5112e..93a1b730726d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -92,7 +92,7 @@ const int pmfw_decoded_link_width[7] = {0, 1, 2, 4, 8, 12, 16};
 int smu_v13_0_init_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	char fw_name[30];
+	char fw_name[42];
 	char ucode_prefix[30];
 	int err = 0;
 	const struct smc_firmware_header_v1_0 *hdr;
-- 
2.34.1

