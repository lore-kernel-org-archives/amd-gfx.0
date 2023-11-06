Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DFBC4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Nov 2023 01:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D487A10E10E;
	Mon,  6 Nov 2023 01:59:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 712AD10E10E
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Nov 2023 01:59:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDMK+9xlUfi869VzCx9utHYMyyUZfmA71HV17gkXgCOWEkCwFCHYaX3W+7rXK46UlsiGpjLLKoUeX7tSY8UfeuYh2xjES88TXjFOVeXfMr7IuFVSWbB/5mwFpBeyyhd+byZHN6tMNkb0/xZP8xeWM/AvgAriYdJm0N5pYTzQAQjBY/qeYkwX9Up6mztSo+7Ru5i91FyoIY1JNnTrvg8mDqEHBB+7AWluFaTGds4fcDC3WJEitYzDjD+SwNuBT3fbd7ImqkafjNW/oADAVJ+FqKP8Or/y1cdnPV6mqIbXdbwZoe+8yTt7UyroGDWtavPqUfiH32ObDzGEDy3SdOE0kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecIIPAzFDdUbyaOJDdoLYKWGndWAfhg9hRvHehOIf7Y=;
 b=H3MX0qmoDKLAKo1kH1lpLBycFExFCzpRuYlRY0atrCePT1yx12izx5foA+jHJ+vhA/vfQFwO9j+ODVzsxLVVltICkWMfhOesp0ghj2Xgnm7T2U8FRcXbRxRYN7gD1WXVNyb0Pd71RnUoOruLNH/C0+5ZouYJB9/rBpax+ksQ5ku/tmvh4XdoyXFcePhoWT40mmYSt19BQW33zeV40+olps+1rUG6sxAU5Dc9uAnYKsN5Qygj7rkNUS6Q8wBS9AzZ4AVMeQo8K4nBWrL9X4/RuSQ6tThEWJaobuG0g40C7AIZRCFxF+J9tAmglzONhmpk5wnOn5A7Q+4dOCH1t+n5Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecIIPAzFDdUbyaOJDdoLYKWGndWAfhg9hRvHehOIf7Y=;
 b=rk/eyouIxe5BjlsfPmBZHGKn0Cy0AVw2kilc3kHj1xCtq7vSw7c9YVVtPDurSa/sgmj+AQ+C9KWieKos1IqAcWCe2gxmXTR4ktQbGol7MbK0BR6Ts93JZMIntknFgGgblNMqiK+hjHHw81dwlNdMCiO6LWjlFLbI6lisJdBqoDI=
Received: from DS7PR05CA0091.namprd05.prod.outlook.com (2603:10b6:8:56::12) by
 DM4PR12MB5343.namprd12.prod.outlook.com (2603:10b6:5:389::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.27; Mon, 6 Nov 2023 01:59:35 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:8:56:cafe::99) by DS7PR05CA0091.outlook.office365.com
 (2603:10b6:8:56::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16 via Frontend
 Transport; Mon, 6 Nov 2023 01:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Mon, 6 Nov 2023 01:59:34 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Sun, 5 Nov
 2023 19:59:31 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Kenneth.Feng@amd.com>,
 <Alexander.Deucher@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2] drm/amd/pm: Move some functions to smu_v13_0.c as generic
 code
Date: Mon, 6 Nov 2023 09:59:14 +0800
Message-ID: <20231106015914.3426076-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|DM4PR12MB5343:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e00ba3-b10a-4f8a-e299-08dbde6c062d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hMnpde9/OyQReUDBIbzxUhhpdETc+gqQdvs3uuvGcucmp+xP+xqcPvTK+Aln83tIQTcwOJdZnFcAY9HloNqGI7ywoKulQAN6VNhM4A9qpKnq0w1QCQ5jV+RFOx/lTiVK4lun0vSaV+a3UKwgvycYgDp9MjvlQKACXM4hur8lr7y4itRTGfobRDLupLl9MRXUFN58fn/+VBVWPRcPCiuI5bbrgXJB0NhOKyHUPsrPbr3MAmysOh1Hd2hscPG0m9WKKS9BwVNnLL4ofUgV4pKFl/gE/G6DEnomiOvbIb4ShhT4jFV7SAhwWYxmeB0/GiiP1ky8yvZk8HX70PF42Gy0tSKIdAQtJVqF0mkWhUf19l7evAsRHJERkpt5qt6E1uI/9KPv6uZXXS+T7dWEls+tgkKkAxgMB11JXhXB2T2cuFDPUELGD7tjOuxuwbG34mzZZ11lgAt6wPjI93HB4+6NwfelHn42eAjNbxbBjg6FVcSj1FTgmBuAs/Gm8eYEaoOdLyV8wIlyfEY7kraEVeODEbtrgubb7qzX+EhJ4Hlve8LM8Cot3/nATvLAVOKjR6hfMk4EVlUEYcsqISdmQ9oNt5SLQq9Lv0ejFVRtEZZqJBRpfhiu4OYkMFCGvXH0EwW54YbTSSl8YoPWSzWL1VsKsTeF3LfL0aF33qEvxo3IZZzxWxkkRhalMlTsKeh4aOkd3+M0QztooeQ3tj4NPxt8IMVp9cUuJH0fqCNIehVsnlO6CcJhmBcZ0qm/ZXJBmQpeiNIiXcjn7EaZjqxVRs4klh6R/YeiS7pUuX24cSJnb6U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(36756003)(40480700001)(426003)(336012)(8676002)(83380400001)(8936002)(4326008)(16526019)(1076003)(26005)(6636002)(70586007)(316002)(70206006)(110136005)(5660300002)(36860700001)(2906002)(47076005)(41300700001)(478600001)(6666004)(7696005)(2616005)(81166007)(82740400003)(356005)(86362001)(41533002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 01:59:34.3155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e00ba3-b10a-4f8a-e299-08dbde6c062d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5343
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
Cc: Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use generic functions and remove the duplicate code

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 38 ++++++++++++++-----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 36 +-----------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 36 +-----------------
 3 files changed, 32 insertions(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 281c3cb707a5..438fd5d3ede2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2282,22 +2282,40 @@ int smu_v13_0_baco_set_state(struct smu_context *smu,
 
 int smu_v13_0_baco_enter(struct smu_context *smu)
 {
-	int ret = 0;
-
-	ret = smu_v13_0_baco_set_state(smu,
-				       SMU_BACO_STATE_ENTER);
-	if (ret)
-		return ret;
+	struct smu_baco_context *smu_baco = &smu->smu_baco;
+	struct amdgpu_device *adev = smu->adev;
+	int ret;
 
-	msleep(10);
+	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
+		return smu_v13_0_baco_set_armd3_sequence(smu,
+				(smu_baco->maco_support && amdgpu_runtime_pm != 1) ?
+					BACO_SEQ_BAMACO : BACO_SEQ_BACO);
+	} else {
+		ret = smu_v13_0_baco_set_state(smu, SMU_BACO_STATE_ENTER);
+		if (!ret)
+			usleep_range(10000, 11000);
 
-	return ret;
+		return ret;
+	}
 }
 
 int smu_v13_0_baco_exit(struct smu_context *smu)
 {
-	return smu_v13_0_baco_set_state(smu,
-					SMU_BACO_STATE_EXIT);
+	struct amdgpu_device *adev = smu->adev;
+	int ret;
+
+	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
+		/* Wait for PMFW handling for the Dstate change */
+		usleep_range(10000, 11000);
+		ret = smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
+	} else {
+		ret = smu_v13_0_baco_set_state(smu, SMU_BACO_STATE_EXIT);
+	}
+
+	if (!ret)
+		adev->gfx.is_poweron = false;
+
+	return ret;
 }
 
 int smu_v13_0_set_gfx_power_up_by_imu(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index a94b57e7c509..9be41a2b8659 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2558,38 +2558,6 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 					       NULL);
 }
 
-static int smu_v13_0_0_baco_enter(struct smu_context *smu)
-{
-	struct smu_baco_context *smu_baco = &smu->smu_baco;
-	struct amdgpu_device *adev = smu->adev;
-
-	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
-		return smu_v13_0_baco_set_armd3_sequence(smu,
-				(smu_baco->maco_support && amdgpu_runtime_pm != 1) ?
-					BACO_SEQ_BAMACO : BACO_SEQ_BACO);
-	else
-		return smu_v13_0_baco_enter(smu);
-}
-
-static int smu_v13_0_0_baco_exit(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-	int ret;
-
-	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
-		/* Wait for PMFW handling for the Dstate change */
-		usleep_range(10000, 11000);
-		ret = smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
-	} else {
-		ret = smu_v13_0_baco_exit(smu);
-	}
-
-	if (!ret)
-		adev->gfx.is_poweron = false;
-
-	return ret;
-}
-
 static bool smu_v13_0_0_is_mode1_reset_supported(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -3036,8 +3004,8 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.baco_is_support = smu_v13_0_baco_is_support,
 	.baco_get_state = smu_v13_0_baco_get_state,
 	.baco_set_state = smu_v13_0_baco_set_state,
-	.baco_enter = smu_v13_0_0_baco_enter,
-	.baco_exit = smu_v13_0_0_baco_exit,
+	.baco_enter = smu_v13_0_baco_enter,
+	.baco_exit = smu_v13_0_baco_exit,
 	.mode1_reset_is_support = smu_v13_0_0_is_mode1_reset_supported,
 	.mode1_reset = smu_v13_0_0_mode1_reset,
 	.mode2_reset = smu_v13_0_0_mode2_reset,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 81eafed76045..f5596f031d00 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2515,38 +2515,6 @@ static int smu_v13_0_7_set_mp1_state(struct smu_context *smu,
 	return ret;
 }
 
-static int smu_v13_0_7_baco_enter(struct smu_context *smu)
-{
-	struct smu_baco_context *smu_baco = &smu->smu_baco;
-	struct amdgpu_device *adev = smu->adev;
-
-	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
-		return smu_v13_0_baco_set_armd3_sequence(smu,
-				(smu_baco->maco_support && amdgpu_runtime_pm != 1) ?
-					BACO_SEQ_BAMACO : BACO_SEQ_BACO);
-	else
-		return smu_v13_0_baco_enter(smu);
-}
-
-static int smu_v13_0_7_baco_exit(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-	int ret;
-
-	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
-		/* Wait for PMFW handling for the Dstate change */
-		usleep_range(10000, 11000);
-		ret = smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
-	} else {
-		ret = smu_v13_0_baco_exit(smu);
-	}
-
-	if (!ret)
-		adev->gfx.is_poweron = false;
-
-	return ret;
-}
-
 static bool smu_v13_0_7_is_mode1_reset_supported(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -2628,8 +2596,8 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.baco_is_support = smu_v13_0_baco_is_support,
 	.baco_get_state = smu_v13_0_baco_get_state,
 	.baco_set_state = smu_v13_0_baco_set_state,
-	.baco_enter = smu_v13_0_7_baco_enter,
-	.baco_exit = smu_v13_0_7_baco_exit,
+	.baco_enter = smu_v13_0_baco_enter,
+	.baco_exit = smu_v13_0_baco_exit,
 	.mode1_reset_is_support = smu_v13_0_7_is_mode1_reset_supported,
 	.mode1_reset = smu_v13_0_mode1_reset,
 	.set_mp1_state = smu_v13_0_7_set_mp1_state,
-- 
2.34.1

