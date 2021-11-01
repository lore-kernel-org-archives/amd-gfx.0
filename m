Return-Path: <SRS0=Z8rF=PU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210DCC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 21:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4DAE60F02
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 21:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A4DAE60F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8061089FD1;
	Mon,  1 Nov 2021 21:30:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AE2289FC8
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Nov 2021 21:29:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqsNY5qGV4fiGre+vVk9XNEV3Z+fPLxeOHlNemwoVOQzU+fa2ipMqO5sZZN1nFQmquTNq136Na2IHtLFfIQXvIG8bhFV2oXYpDlFK3EOt8AypN93Y8rZoI3rOBR/IPw4uGC9uTRG/L3FfwctvlPWLbusWB1MGM/hoI7PdfWV1T51EjD4C3DyYiX7mss/ieASqZ0jLlPTZ8ZCm/KI40G1kq2s3/mocj1mzpkKo9src8EEQILc9xzkFbSgJcPFSE8lxNDMNZL4sW9+qlX1LBqrSVxAOgqGRK/onjKUpRqUpMpW9DsRD6GTlB3UgTyKLJ71R4CnObywF0eJyZ1fBclNsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CihVvOJl9hZy7xyiiYP4fxPaBXq79ANfhDW/CgOcX/E=;
 b=odhox/vH/TqJIfmWpd9aS/NDnMmNUYIeKQzStuwfwJ9AN12rFaw6nb4MPei7SiLfsZlCks3RZfhsfdPwCHfsBMwiWnLNGPoB7bl90wzx8IsNjUxCF3qVCpwlamoQmdo/y8Uhg8jJFX/L8FeJxJLpLwURwlTvnxCa1YccSkkdyJq/zaFneQH2ksOe6hcI0OOG4p05Elx7hypbDnJkYesZuzrVeM+ZjQKN/CxuGlmMZby+5vsabNiss2EXRXpcz3A5Q1pDj0igJBYGLwlrZygod1Mi8VagfH0yOww9l+sc6IK0+BcrIKgaAucTKGVet0pKg/dQLYS/S3vJGB7YwQkbIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CihVvOJl9hZy7xyiiYP4fxPaBXq79ANfhDW/CgOcX/E=;
 b=itECxvwBUK1oVz3jCpjsKCbO6+Zj0uaGuUkNQWrrTv/tjXwRTG/JpLZELmecc30i8rXqr4bjvqgNAj2O6isA6JDIwzyAUrO5WkIqtIFNUv2dc7vSSJQGdKvUU1DXc5PCxfPDKTZxzaG4H4wWC6j9YD8sI2+MiuZxoZWa4rLd7t8=
Received: from MW4PR03CA0275.namprd03.prod.outlook.com (2603:10b6:303:b5::10)
 by DM5PR12MB1612.namprd12.prod.outlook.com (2603:10b6:4:a::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15; Mon, 1 Nov 2021 21:29:54 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::56) by MW4PR03CA0275.outlook.office365.com
 (2603:10b6:303:b5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Mon, 1 Nov 2021 21:29:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 21:29:54 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 1 Nov
 2021 16:29:52 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 3/3] drm/amdgpu/pm: Don't show pp_power_profile_mode for
 unsupported devices
Date: Mon, 1 Nov 2021 16:28:48 -0500
Message-ID: <20211101212848.20449-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211101212848.20449-1-mario.limonciello@amd.com>
References: <20211101212848.20449-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 669ab851-6ac8-49d2-4138-08d99d7ebf26
X-MS-TrafficTypeDiagnostic: DM5PR12MB1612:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1612FE0BD40F1C9CEEC621F9E28A9@DM5PR12MB1612.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /CElHugI3cMI7orfURPs0UxhRPf0Rld18Que59JoWESvcIN+EhnrJ363chUzHMpUDoFDmv1UBMsBS51zlPknoKQa1/jkQ6NW6dw2HTJiDEsAgb/qqLTjvDfLJ/At7ogKVUfCXPQvJkdFNLC9eZWKJoAkyBz00TV20l8O5cT6obZplPmNokF4YdsJ8ryM7teqrdakU/CIhmoyhStxtb+1+CrHeFezRCsDeUGMEp8tEVSaDkSuGgDaYhyj/jGt/WG+aM38a4b9T9/zxgUHqjT+dOfebj7oyrv0TtJBHjSEeOoQF4icbyyXefyFodBycDfhH8hkvwe7uXhapTs6mP7STzR6grDNGTU7mflq1qNfeczvbQZDGjAxIzJOTgxvjXjZtlki0TCMKfLutjorFOy4GIOnY7uSFu7ECskIw5B/4WGg1z5tUEBkFAyD5qE0sdwORSYAMbgLk7dl5dF2pOxe0zTUvuBykut9c3m44k+gCIUy3QpmjBbENtu2LJ51OI73Sb8C/V4FRUDHKwzh2tc8Q8KbulrToKos8tn/U5MuoMheYLBHvDaxWcsIGxfEQJxDmzjNfDT85DqkB+30DZrqJ5nwmTVoHhI23nrV2kri8m2zo7m6X+T98vgyWBgseTZZCbWQBoR10pMzbTvOMqnmnXRU9ozp5jWgSMqoDKAHEZkJzzvKP8J9t1OB85Z9PD/1zqn3dvLxWFy8zjfuQOsh4wgnC/CzI38z7G84wYrv6j8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(4326008)(8676002)(8936002)(44832011)(6666004)(5660300002)(86362001)(2906002)(70206006)(16526019)(508600001)(47076005)(70586007)(186003)(336012)(36860700001)(316002)(54906003)(81166007)(82310400003)(2616005)(36756003)(1076003)(26005)(426003)(356005)(83380400001)(6916009)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 21:29:54.6382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 669ab851-6ac8-49d2-4138-08d99d7ebf26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1612
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This command corresponding to this attribute was deprecated in the PMFW
for YC so don't show a non-functional attribute.

Verify that the function has been implemented by the subsystem.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes from v2->v3:
 * Handle powerplay to return this as well

 drivers/gpu/drm/amd/pm/amdgpu_pm.c               |  4 ++++
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 14 ++------------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 11 +++++++----
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 49fe4155c374..41472ed99253 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2094,6 +2094,10 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
 		if (!(asic_type == CHIP_VANGOGH || asic_type == CHIP_SIENNA_CICHLID))
 			*states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
+		if (!adev->powerplay.pp_funcs->get_power_profile_mode ||
+		    amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
+			*states = ATTR_STATE_UNSUPPORTED;
 	}
 
 	switch (asic_type) {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 79e565121206..8d796ed3b7d1 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -877,16 +877,11 @@ static int pp_get_power_profile_mode(void *handle, char *buf)
 	struct pp_hwmgr *hwmgr = handle;
 	int ret;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr || !hwmgr->pm_en || !hwmgr->hwmgr_func->get_power_profile_mode)
 		return -EOPNOTSUPP;
 	if (!buf)
 		return -EINVAL;
 
-	if (hwmgr->hwmgr_func->get_power_profile_mode == NULL) {
-		pr_info_ratelimited("%s was not implemented.\n", __func__);
-		return snprintf(buf, PAGE_SIZE, "\n");
-	}
-
 	mutex_lock(&hwmgr->smu_lock);
 	ret = hwmgr->hwmgr_func->get_power_profile_mode(hwmgr, buf);
 	mutex_unlock(&hwmgr->smu_lock);
@@ -898,13 +893,8 @@ static int pp_set_power_profile_mode(void *handle, long *input, uint32_t size)
 	struct pp_hwmgr *hwmgr = handle;
 	int ret = -EOPNOTSUPP;
 
-	if (!hwmgr || !hwmgr->pm_en)
-		return ret;
-
-	if (hwmgr->hwmgr_func->set_power_profile_mode == NULL) {
-		pr_info_ratelimited("%s was not implemented.\n", __func__);
+	if (!hwmgr || !hwmgr->pm_en || !hwmgr->hwmgr_func->set_power_profile_mode)
 		return ret;
-	}
 
 	if (hwmgr->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL) {
 		pr_debug("power profile setting is for manual dpm mode only.\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b06c59dcc1b4..821ae6e78703 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2534,13 +2534,15 @@ static int smu_get_power_profile_mode(void *handle, char *buf)
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
+	    !smu->ppt_funcs->get_power_profile_mode)
 		return -EOPNOTSUPP;
+	if (!buf)
+		return -EINVAL;
 
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->get_power_profile_mode)
-		ret = smu->ppt_funcs->get_power_profile_mode(smu, buf);
+	ret = smu->ppt_funcs->get_power_profile_mode(smu, buf);
 
 	mutex_unlock(&smu->mutex);
 
@@ -2554,7 +2556,8 @@ static int smu_set_power_profile_mode(void *handle,
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
+	    !smu->ppt_funcs->set_power_profile_mode)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
-- 
2.25.1

