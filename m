Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85255C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 06:00:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A18B710E052;
	Fri,  3 Nov 2023 06:00:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3957A10E052
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 05:59:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avcb8sGzVgwSyGka6ETbcMxRDfpQIPxgHz1KbWUrj9siucz0rR737iuDjMFhYsgjgnk7ih6L/uRU4zJ90dSHjJzlPt6MkEoxG7oIgR7SCKdJVLjrDE+6IwT/2cjbvkeGitATvMOzuopTIo90ZBuNyKYzk8al11bWJCdr3As4eroTKipOEJGA+JVPwF6CuHkMPL+FYIXUcShwNZVhKEIrlH/0IvJkcF6A0Gjh/HvOQZnGfq1EMmywPCtNW2cx31X6pO66s4Hziotlabxzf21fpRDvRUxi2fDfVQNoW3JnpbvqHpcac5Mttym/SMvcAccYzJCwMtUv6r8HP7jn0lcsPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maESNMoNzA7KlbpgYMH2r3i+PMbK5AJRBAJ6+AmqYq0=;
 b=ClL0FW3v5sa93QuzxlLxB9HsHhg1NBPQuWH34KlnY/3JLEKEmM0EYOtH/SCmByXDwRQPmtZ9v3zS4Bh3082W30j7fj49aTCNsCLJArYp0XPsHnAe3WvUQ1lXVp1vrHputTOY5wbDH0mlWxHWVm7X6lFNmn2GAVhzq/cND81srJRC8N9x1ssCJ6cJNFMpli63OlMKN0JzvAcZ/kfn+hyRQiNjn5H9GiZd5ztudj5GTZaFJkXHbCKm4mcBvIpLZv0KQQCSazpuRmcsdOVCzGB5Kl+PERTbhY/QLoJmC/M+/DL2t85PCo+V1XAWBtyoYfORQo7TD5y4XFFSeihCL9DpkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maESNMoNzA7KlbpgYMH2r3i+PMbK5AJRBAJ6+AmqYq0=;
 b=2h3pd8tDlpvPkrxlvP6XG/2I/4vyozWQMB1nTR3bVl6cj6yvgg6QZDepkhnZDJYIVlzO4pzoFAcBqfbuvDw6b1+qK9VtOjerTh+O7te7ARNSjLHFAmQEfe3WdAJexvCSvpNxoUbyAHwNlwLHqqCoQK/f5xR8L2kD/6fShxWgR5Q=
Received: from CY8PR19CA0031.namprd19.prod.outlook.com (2603:10b6:930:6::16)
 by SN7PR12MB8789.namprd12.prod.outlook.com (2603:10b6:806:34b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Fri, 3 Nov
 2023 05:59:56 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:6:cafe::e4) by CY8PR19CA0031.outlook.office365.com
 (2603:10b6:930:6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21 via Frontend
 Transport; Fri, 3 Nov 2023 05:59:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 05:59:55 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 00:59:51 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: Hide irrelevant pm device attributes
Date: Fri, 3 Nov 2023 11:29:34 +0530
Message-ID: <20231103055935.481843-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|SN7PR12MB8789:EE_
X-MS-Office365-Filtering-Correlation-Id: ece68d80-128d-47dd-3ce5-08dbdc321ab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qxTDpVVnBwnzi1L5t/LcseFkXjeUEvVC6ulFy131vKrzb3JpkLX/RO1NUOyhfVnBXT0U4Lc3Ms+QgPOhI/cYTBF2rI782EA5l+QYloTff0hyL9cgXO3xIOaKZDYJgfzLNlWoJ5VrECqmqYY/F9QLKkJOu2/K60xi/Lucqy8ZrmUAAuAbb2ew6TKOeHVA50jRCwo9yiL9EM0pV2rWiUuTUSQgRDPC2O8sslQhkk1i5ZwHAcq4+/XBz0YIuKzeeVRy4yf01iuxno2Tigdl82P6QPLgeIXhVUQILrrg8DRM/AjynKDaqFHpL2sQeK45uNgsrkDeHIm4mxVEaS6LraAuNR+2sazAWncOee8VlYSWSq7WdMpTCxH57oIeKzMKu9bMPYK4wcq3iA7IIcdGmh6Oga8onmLinIXZ5UHQGOaqDvnTURVAG0cnqfqpctlmhNFeHbFBINDVbdW5BW7v/AZqOY6r0Dy73luB9Eu80a8yCjTwdCRjndLw8geiUmFcgto/yh6sp4YpzHpJEGS5kltzDMlnJmHmHXJy0hLRH80zNqnTLvbdqc8LmwWllylYnJhvBG6zxbw3Kig6rmmehrtY723rJIwdEXKmcCArdAGOaRDyH6qrzGcVCn/v0BLOoJwUihoolFPPjesUEKwUXOGxv2GjSjeDEF25VcqVySP7z0bka93zqK9kvDACPOBnApbcpFOxOYFjdNNOuK4XDSWnZYKcOBEj2nr7RyNXRgAp96Nz5LywGoR1xl5c8LzdzI/6g9mrKl6/+BDObbTreGIulA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799009)(36840700001)(40470700004)(46966006)(6916009)(47076005)(316002)(40460700003)(86362001)(2616005)(2906002)(1076003)(81166007)(426003)(336012)(83380400001)(26005)(54906003)(70206006)(16526019)(356005)(7696005)(478600001)(36756003)(70586007)(41300700001)(44832011)(6666004)(8936002)(4326008)(8676002)(40480700001)(82740400003)(36860700001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 05:59:55.6524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ece68d80-128d-47dd-3ce5-08dbdc321ab5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8789
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change return code to EOPNOTSUPP for unsupported functions. Use the
error code information to hide sysfs nodes not valid for the SOC.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c       | 12 ++++++------
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 12 ++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  4 ++--
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index aed635e2da9c..aed232d107b6 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -491,7 +491,7 @@ int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors senso
 int amdgpu_dpm_get_apu_thermal_limit(struct amdgpu_device *adev, uint32_t *limit)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = -EINVAL;
+	int ret = -EOPNOTSUPP;
 
 	if (pp_funcs && pp_funcs->get_apu_thermal_limit) {
 		mutex_lock(&adev->pm.mutex);
@@ -505,7 +505,7 @@ int amdgpu_dpm_get_apu_thermal_limit(struct amdgpu_device *adev, uint32_t *limit
 int amdgpu_dpm_set_apu_thermal_limit(struct amdgpu_device *adev, uint32_t limit)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = -EINVAL;
+	int ret = -EOPNOTSUPP;
 
 	if (pp_funcs && pp_funcs->set_apu_thermal_limit) {
 		mutex_lock(&adev->pm.mutex);
@@ -1182,7 +1182,7 @@ int amdgpu_dpm_get_sclk_od(struct amdgpu_device *adev)
 	int ret = 0;
 
 	if (!pp_funcs->get_sclk_od)
-		return 0;
+		return -EOPNOTSUPP;
 
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_sclk_od(adev->powerplay.pp_handle);
@@ -1196,7 +1196,7 @@ int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t value)
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
 	if (is_support_sw_smu(adev))
-		return 0;
+		return -EOPNOTSUPP;
 
 	mutex_lock(&adev->pm.mutex);
 	if (pp_funcs->set_sclk_od)
@@ -1219,7 +1219,7 @@ int amdgpu_dpm_get_mclk_od(struct amdgpu_device *adev)
 	int ret = 0;
 
 	if (!pp_funcs->get_mclk_od)
-		return 0;
+		return -EOPNOTSUPP;
 
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_mclk_od(adev->powerplay.pp_handle);
@@ -1233,7 +1233,7 @@ int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev, uint32_t value)
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
 	if (is_support_sw_smu(adev))
-		return 0;
+		return -EOPNOTSUPP;
 
 	mutex_lock(&adev->pm.mutex);
 	if (pp_funcs->set_mclk_od)
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 6ad957aaef3c..083048131bca 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2237,6 +2237,18 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	} else if (DEVICE_ATTR_IS(xgmi_plpd_policy)) {
 		if (amdgpu_dpm_get_xgmi_plpd_mode(adev, NULL) == XGMI_PLPD_NONE)
 			*states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pp_dpm_mclk_od)) {
+		if (amdgpu_dpm_get_mclk_od(adev) == -EOPNOTSUPP)
+			*states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pp_dpm_sclk_od)) {
+		if (amdgpu_dpm_get_sclk_od(adev) == -EOPNOTSUPP)
+			*states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(apu_thermal_cap)) {
+		u32 limit;
+
+		if (amdgpu_dpm_get_apu_thermal_limit(adev, &limit) ==
+		    -EOPNOTSUPP)
+			*states = ATTR_STATE_UNSUPPORTED;
 	}
 
 	switch (gc_ver) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 7fe32cdea5a8..6d6221024d7e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2747,7 +2747,7 @@ static int smu_read_sensor(void *handle,
 
 static int smu_get_apu_thermal_limit(void *handle, uint32_t *limit)
 {
-	int ret = -EINVAL;
+	int ret = -EOPNOTSUPP;
 	struct smu_context *smu = handle;
 
 	if (smu->ppt_funcs && smu->ppt_funcs->get_apu_thermal_limit)
@@ -2758,7 +2758,7 @@ static int smu_get_apu_thermal_limit(void *handle, uint32_t *limit)
 
 static int smu_set_apu_thermal_limit(void *handle, uint32_t limit)
 {
-	int ret = -EINVAL;
+	int ret = -EOPNOTSUPP;
 	struct smu_context *smu = handle;
 
 	if (smu->ppt_funcs && smu->ppt_funcs->set_apu_thermal_limit)
-- 
2.25.1

