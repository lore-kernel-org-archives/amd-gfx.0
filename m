Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CEEC32771
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 02:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6F7310E455;
	Mon, 19 Sep 2022 02:03:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23A9310E44B
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 02:03:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIyMLOMbRM99FQaOjTyGLc0HezwRPYkv+QKOnmNL+n1YPCSXKLep7Sc3MWaZ1uqmCzJsZn9dWYrvOvR4z8fqRf7yi0rBSHwys1bNoODyQIaFsgDqZH9Da5KRXM9oMc+3YSgt7vWj30RaBfGptg4G+HBAwiYf6xqK7PI1Z6QfJRbab1v8bOzK276pZxKFYnJRZ5mNc3jbpzOVOlPqUL3kIhZYSMCDyRGawcDkWJk6HW8Ql0dV/YSaZ4jSho0551ktXpTgmJxkPbmXSDeQSaV+BleRWtYxM0vVYR1/cxyJXMpy2goIDAuKcZCMLRC8jIbnZIxcyw4+AH91VYgjlzowQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIwOC0HYQN2HtoRoXBVoxAQCFt3EjmM8/O86aEJlI+s=;
 b=EU/kqONnzbPFSZchJ0yBMY2EFx7PQDxa9yAxwGqceo5P94H/lxlv+ZUX+m+0gwrfGbrARCO4eTirvsaK9OwTvf/Y4l3le4UnLt7N8Zg9oEQQlc+8zjL+BouH7vTcv/g4TKwwr6Um0PR/DpWO4mjWuo/8gHNSRdzVFXgShyvd1CVKXJGIsKS4J3KVQJuF6NN1q0Q8btkyrV/7AFt3ZyK5Ns9xR/J5vqEUfmxbG2uvB9AEgVtTMMbnYTaF0kygU/WUTAvPuBj5pnGsNEyKh85eDIC9Hw/Ih3tl2qiFrOoXtxgpwb7uX7N69wqOjuXnLyTbMmlCxxIy1Wg/ZZNYa+RyXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIwOC0HYQN2HtoRoXBVoxAQCFt3EjmM8/O86aEJlI+s=;
 b=tC470jke433Sed67C0DBxtIBi8939Wso/X7KHiXo372/vWYJPPeZ0iRakPPNqgJYDsQuxM4nSfZItJ7nLq70KFxAvRGxI1+isVCSYefYkQ0NmXMz2sx0TEUuTd83JHfBqBPE7cxA1BpkjUM8BiQky/dW9W06hhqg1v9Y7bu+YYI=
Received: from MW4PR03CA0145.namprd03.prod.outlook.com (2603:10b6:303:8c::30)
 by BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Mon, 19 Sep
 2022 02:03:35 +0000
Received: from CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::28) by MW4PR03CA0145.outlook.office365.com
 (2603:10b6:303:8c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19 via Frontend
 Transport; Mon, 19 Sep 2022 02:03:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT081.mail.protection.outlook.com (10.13.174.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 02:03:34 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 18 Sep
 2022 21:03:33 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 5/7] drm/amd/pm: move SMU13.0.7 related pptable settings to
 smu_v13_0_7_ppt.c
Date: Mon, 19 Sep 2022 10:02:49 +0800
Message-ID: <20220919020251.7048-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220919020251.7048-1-evan.quan@amd.com>
References: <20220919020251.7048-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT081:EE_|BL3PR12MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: ae244f1f-5015-478d-7f42-08da99e328f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+llkWVdIdOLsLlHDMUuKyMXSSvZoa7Bucgu05uAll3UopsUKKSLTL69qZ86HIcfz66ZXicQTwVsIfagLqdHp5VikjVtxb0KNaeu7yniFPueCB1JpqstjewxyG/ZF6B0JZBt0MI3IpeDK8qhDepRegUdFTt+xe+S7VrDbGz7N5SbwpFhK0QzjJwkIi2NJu2MPj6WZzkb2WArx4lVemuV5HgQx7tdElYwWPoJEEcg9mfn6+qjrBpvOtsNL2t/Xm7cUwqTy9azmeryj4coiTTsrzFO1TUcYNsV13XruP8+uTofnPiYw8rm6MeIGDnwhVsYvrIEgLaObaaJIULbKTN6sHH/V1fScot33Pk5Oe9CfBqxMM9B/2goLCsV1LDgGjC7b/MOe44fwuMJ8lDG5ZkkJFmIumXQvPVJ8+t8AyXug+UEiXmLfT7II/x7qW+VOWmy9XEkHoOIZyt+gX0XjQOaCRk4d8e0BKWVUJSX7GS1TfjjjIHUFzIwO6vMcIWRCrfQRXaCOKGTaKbfSS8/lBuBcw6POtuyAbAxabD4s8ZiPCFyV/sATvhHpuw53cuAFeTIhTGXou6V0YiH8fs3KtMak6b3ePvvK5aQBXsGOwBVi+dSgSLxB7d61BLJ0NYa12urAQW2OUqtb8cPc7WgrEXtnnqTCOBrkloHwSB8IKTOFlv+5OrYgQ5JWk3SiywsWYX3MuYubgfXXJ8GL3D1S10J7nBfK+qxqw6gbjFBdUMRfJGmQGBeZ8KyYFUQOWGKlY0qAofEdDDn+Oo/hnuQzkD7+Cn9uucauBU3aaC2XgHpg+0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199015)(40470700004)(46966006)(36840700001)(82310400005)(36860700001)(40460700003)(36756003)(86362001)(82740400003)(44832011)(356005)(81166007)(2906002)(5660300002)(478600001)(4326008)(70206006)(70586007)(8676002)(8936002)(316002)(6916009)(54906003)(47076005)(426003)(336012)(16526019)(186003)(1076003)(40480700001)(83380400001)(41300700001)(6666004)(2616005)(7696005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 02:03:34.8471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae244f1f-5015-478d-7f42-08da99e328f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Separate those ASIC specific settings from common helpers.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Icbb7dc26d720562ce66c1d7240078a34bea1aae3
--
v1->v2:
  - update the comments to fit the latest code(Guchun)
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  4 ----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 22 ++++++++++++++-----
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 7adbdd3cc13b..24be318adf7a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1027,10 +1027,6 @@ static void smu_interrupt_work_fn(struct work_struct *work)
 static void smu_pptable_source_init(struct smu_context *smu)
 {
 	switch (smu->adev->ip_versions[MP1_HWIP][0]) {
-	case IP_VERSION(13, 0, 7):
-		smu->pptable_source = PPTABLE_SOURCE_PMFW;
-		smu->pptable_id = smu->smu_table.boot_values.pp_table_id;
-		break;
 	case IP_VERSION(13, 0, 10):
 		smu->pptable_source = PPTABLE_SOURCE_INTERNAL_HARDCOPY;
 		smu->pptable_id = 6666;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 0a6785eecfc6..d1b321cc0358 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -426,13 +426,15 @@ static int smu_v13_0_7_setup_pptable(struct smu_context *smu)
 	int ret = 0;
 
 	/*
-	 * With SCPM enabled, the pptable used will be signed. It cannot
-	 * be used directly by driver. To get the raw pptable, we need to
-	 * rely on the combo pptable(and its revelant SMU message).
+	 * For the latest SMU13 asics, the pptable carried in vbios is
+	 * properly signed. We have to rely on SMU to get the desired pptable.
 	 */
-	ret = smu_v13_0_7_get_pptable_from_pmfw(smu,
-						&smu_table->power_play_table,
-						&smu_table->power_play_table_size);
+	if (smu->pptable_source == PPTABLE_SOURCE_PMFW)
+		ret = smu_v13_0_7_get_pptable_from_pmfw(smu,
+							&smu_table->power_play_table,
+							&smu_table->power_play_table_size);
+	else
+		ret = smu_v13_0_setup_pptable(smu);
 	if (ret)
 		return ret;
 
@@ -1595,6 +1597,13 @@ static bool smu_v13_0_7_is_mode1_reset_supported(struct smu_context *smu)
 
 	return true;
 }
+
+static void smu_v13_0_7_pptable_source_init(struct smu_context *smu)
+{
+	smu->pptable_source = PPTABLE_SOURCE_PMFW;
+	smu->pptable_id = smu->smu_table.boot_values.pp_table_id;
+}
+
 static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_7_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_7_set_default_dpm_table,
@@ -1657,6 +1666,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.mode1_reset_is_support = smu_v13_0_7_is_mode1_reset_supported,
 	.mode1_reset = smu_v13_0_mode1_reset,
 	.set_mp1_state = smu_v13_0_7_set_mp1_state,
+	.pptable_source_init = smu_v13_0_7_pptable_source_init,
 };
 
 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
-- 
2.34.1

