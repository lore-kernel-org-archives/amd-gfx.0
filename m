Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5477C07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 09:59:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 463CC6124B
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 09:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463CC6124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 084756F5F4;
	Fri,  4 Jun 2021 09:59:14 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2086.outbound.protection.outlook.com [40.107.101.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5C216F5F4
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 09:59:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEXSF4GRwnA4SlA1EsVvCBKt+jg9c1HOYpubR2KGLTVrtgCCUXIUYQeR3NJcQnZO+W19n9Tpa4A+C0lEBKCfmpLOS+YEjCLisWWt8MMBBsHVV14nMwR10Z5uHpgf4fXEvigblWfX8tTGu5Aocxz/2Hxe6Y79ODU8zvuMtK6cCBKTaffjnhu8k+EVe1ukWjrltkUoLYOhPH9Q6EZ3qeOrZH3rXlJgMIsqhD6oJEiPK3nf7WYXigbFDzUNwxj6IRTqx1sERqRKwYLVEPSvNe2rIVMpphAYnCDw5lsLKNsihXwqxVlJcR1v6W8FFgwczfiyxivKbUlTpxbiOuk/VC2/7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZekVOj0Kd0fWR1kJytDS8hTF5nc3bLgDca0q3WGJLs=;
 b=g3cPecRjHcvNaAnexCG412ATj2DHuv+Dh0cqLkRzhO4s/6CI4PVqAzXRVxok5UhBw85ZcObOre5MsQyTbCQJi5t4K+bVpc0/e/4YQMET5HIzIb0kSzcy5ogjWoPhlWF/vVX2YYx778Kt03X+SQDRMKrSV53Xa7hzPnH+sHWnhD1J6+EUwO5b+3L2P/YrmIt4K96EvbBkzt8eluw7Et2uIgb0119vN0gnNe8hdDqRXWHoNh6bhtrSt6nC6RVNCBWrch8Nbt0nb26zktaKQ3RmFcvVcH0Lr4jBC/uafzGIm4ad6bsrOl70u0vKrlZp0LfcjXQO7Wn7PIYQ9nUnMQAZEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZekVOj0Kd0fWR1kJytDS8hTF5nc3bLgDca0q3WGJLs=;
 b=SOxa8I9n5rZFGPYOOnBZrA9mKM8Fav4BG/uK1KMaAF0A70EvQHUxUJ/SfXhvmIp7mptNuZDfhjLpCGFQkn8TN+7rbLlIlkGauqjRWQycYW5XgPPD0DX1xXLfSxed275VarFdZf71JnHJ+FoUmQyEZQvghXJX218Dv4gEctWpqoo=
Received: from BN0PR02CA0006.namprd02.prod.outlook.com (2603:10b6:408:e4::11)
 by MN2PR12MB3552.namprd12.prod.outlook.com (2603:10b6:208:ab::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 4 Jun
 2021 09:59:11 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::23) by BN0PR02CA0006.outlook.office365.com
 (2603:10b6:408:e4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend
 Transport; Fri, 4 Jun 2021 09:59:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Fri, 4 Jun 2021 09:59:10 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 4 Jun 2021
 04:59:08 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 2/5] drm/amd/pm: correct the runpm handling for BACO
 supported ASIC
Date: Fri, 4 Jun 2021 17:58:20 +0800
Message-ID: <20210604095823.1403271-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210604095823.1403271-1-evan.quan@amd.com>
References: <20210604095823.1403271-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8860327-f4f9-481d-8993-08d9273f6685
X-MS-TrafficTypeDiagnostic: MN2PR12MB3552:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3552B17930393B98C8E7B2C5E43B9@MN2PR12MB3552.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rOgmzKdkbXJ3yAvsdT7Ei8wY/sIHF/mvrz/xdMbuHAMcGSB7CDYqo2aFZElBwUSyt7QuWC8kVkPnEcK7EJd+HzF4hRnblQyGDlKzwGUKLyIvgdoRkGedjxa5Pr4N78vExGCUEuaDME2opTcsW4C30jbQalYBTbkMLBVgIVtgJbtovmlUsrU6GY2fgsnZfolRVoSo4FF8ra0SWvs7JPr1ALheptFr/n0YvrTaztvNePu/o6orYXd+2vmrXPIURhozwhEBLUs3Qgowda20mZL87KRvsAOaVckVPye8Ibmv4RM/aaabQTytLqeJqDMj66aQ9VsUxIPEE+m+/apIDviOZcXAAEu0itbYNVOAg4V19921oX45camGFrASNX2MnwHXUExeX20irEXvmhGwuXihw0M1gv8S53PDJUpRZ5/hsGYfUSRTHpqJk6JqCXE7xBhB6toalsaiz23Q2gmC3ALPflQU9qkus3Q09MhMwFUEr6/LziBvMqxd1a+108UW4D4i8aFUF2OUPtLQjpvNpqFIcVSDnSFqiiqXZJ3wcCb+E6mT7/fCR2OO9SGVI8E8DkOkKktYkPVCznuAauFy4Twie7kMYnF2sgyOmbS2zRqwRTGhwUZk576L6KujIHo3gyTOCsSV1y0DdoSA6pAgFAh3p1f/7EEyd6lh1ojNT1OjOs+31pvnX/EY8vAlnxW+QmOD
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(39850400004)(346002)(36840700001)(46966006)(426003)(47076005)(8676002)(36860700001)(336012)(26005)(8936002)(478600001)(2906002)(186003)(16526019)(6916009)(70586007)(4326008)(6666004)(70206006)(5660300002)(7696005)(86362001)(54906003)(36756003)(316002)(82310400003)(2616005)(1076003)(44832011)(83380400001)(356005)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 09:59:10.5652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8860327-f4f9-481d-8993-08d9273f6685
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3552
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Via the fSMC_MSG_ArmD3 message, PMFW can properly act on the
Dstate change. Driver involvement for determining the timing for
BACO enter/exit is not needed.

Change-Id: Id9ab5e308ff1873888d0acd822c71b0a303fbb01
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
V1->V2:
  - limit the changes for Navi1x and Sienna_Cichlid which support
    the fSMC_MSG_ArmD3 message
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  3 +++
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 27 +++++++++++++++++--
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 27 +++++++++++++++++--
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 11 ++------
 4 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index a3b28979bc82..1962a5877191 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -244,6 +244,9 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 int smu_v11_0_baco_enter(struct smu_context *smu);
 int smu_v11_0_baco_exit(struct smu_context *smu);
 
+int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu,
+				      enum smu_v11_0_baco_seq baco_seq);
+
 int smu_v11_0_mode1_reset(struct smu_context *smu);
 
 int smu_v11_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type clk_type,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 32a52c1bea07..afd4bd850c63 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2240,6 +2240,29 @@ static bool navi10_is_baco_supported(struct smu_context *smu)
 	return (val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true : false;
 }
 
+static int navi10_baco_enter(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	if (adev->in_runpm)
+		return smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_BACO);
+	else
+		return smu_v11_0_baco_enter(smu);
+}
+
+static int navi10_baco_exit(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	if (adev->in_runpm) {
+		/* Wait for PMFW handling for the Dstate change */
+		msleep(10);
+		return smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
+	} else {
+		return smu_v11_0_baco_exit(smu);
+	}
+}
+
 static int navi10_set_default_od_settings(struct smu_context *smu)
 {
 	OverDriveTable_t *od_table =
@@ -3078,8 +3101,8 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.baco_is_support= navi10_is_baco_supported,
 	.baco_get_state = smu_v11_0_baco_get_state,
 	.baco_set_state = smu_v11_0_baco_set_state,
-	.baco_enter = smu_v11_0_baco_enter,
-	.baco_exit = smu_v11_0_baco_exit,
+	.baco_enter = navi10_baco_enter,
+	.baco_exit = navi10_baco_exit,
 	.get_dpm_ultimate_freq = smu_v11_0_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
 	.set_default_od_settings = navi10_set_default_od_settings,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 095492bd635f..b4a2bb0f3f4c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2106,6 +2106,29 @@ static bool sienna_cichlid_is_baco_supported(struct smu_context *smu)
 	return (val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true : false;
 }
 
+static int sienna_cichlid_baco_enter(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	if (adev->in_runpm)
+		return smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_BACO);
+	else
+		return smu_v11_0_baco_enter(smu);
+}
+
+static int sienna_cichlid_baco_exit(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	if (adev->in_runpm) {
+		/* Wait for PMFW handling for the Dstate change */
+		msleep(10);
+		return smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
+	} else {
+		return smu_v11_0_baco_exit(smu);
+	}
+}
+
 static bool sienna_cichlid_is_mode1_reset_supported(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -3881,8 +3904,8 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.baco_is_support= sienna_cichlid_is_baco_supported,
 	.baco_get_state = smu_v11_0_baco_get_state,
 	.baco_set_state = smu_v11_0_baco_set_state,
-	.baco_enter = smu_v11_0_baco_enter,
-	.baco_exit = smu_v11_0_baco_exit,
+	.baco_enter = sienna_cichlid_baco_enter,
+	.baco_exit = sienna_cichlid_baco_exit,
 	.mode1_reset_is_support = sienna_cichlid_is_mode1_reset_supported,
 	.mode1_reset = smu_v11_0_mode1_reset,
 	.get_dpm_ultimate_freq = sienna_cichlid_get_dpm_ultimate_freq,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 362696208fd8..0376bf67ee08 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1474,7 +1474,8 @@ int smu_v11_0_set_azalia_d3_pme(struct smu_context *smu)
 	return smu_cmn_send_smc_msg(smu, SMU_MSG_BacoAudioD3PME, NULL);
 }
 
-static int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu, enum smu_v11_0_baco_seq baco_seq)
+int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu,
+				      enum smu_v11_0_baco_seq baco_seq)
 {
 	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ArmD3, baco_seq, NULL);
 }
@@ -1578,16 +1579,8 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 
 int smu_v11_0_baco_enter(struct smu_context *smu)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	/* Arcturus does not need this audio workaround */
-	if (adev->asic_type != CHIP_ARCTURUS) {
-		ret = smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_BACO);
-		if (ret)
-			return ret;
-	}
-
 	ret = smu_v11_0_baco_set_state(smu, SMU_BACO_STATE_ENTER);
 	if (ret)
 		return ret;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
