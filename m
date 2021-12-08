Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD82C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 02:37:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 185DB6E079;
	Wed,  8 Dec 2021 02:37:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5BE06E079
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 02:37:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtAm/GEWW09D+rhHaWAkVoXzRDRx6BY5Oc+vcAv6SAkkZE7Z6ZVQvwJvsVJGVTGVPLU7bsVExrg6grfmrwT/jDXTn68WiMUvUVKZOyJOlP5MJAVcw50TXf2bWO9nhwz7JsekHS/BZCe12Qe6FdBTA3EUA4fko0fxEd96XaBMY5EhgADZ99by7pcu+z3uhjTcnTKRkv9yw4QE0KMz/w2sSGJ8ZzcL16YXQ03ZnO6rwgi0or2ysEibAEVetk1ngwIjAlkG0DxrOyEIfb/TgbLu+kmxEGH6bJvE1H2CXirLMJBqhZrzDQSqZElGQjw3W+F/ubfFZ9vFqJS3m+a7gB+r+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpBRHIKZkEXb6MmaaGhYrbuM1ytiCcfxB23vLqSIQjA=;
 b=YqcX8OEEF6ovHj3/804888TRIiAJpI/4Qcf+ul1ZmuQFZKBcgOhydirRWDLNHbGcq1SkBTvyz3s0yhCrvNJSmpzbhmcIcdFRwZzo0QqzkqarlFJE2m9XtJZgzONEbMMAvMZbbC1R9iku30kKlaVoCZxWLwzvpqSjxNQFJCRqbWDnuly7HVWZJYoukrIwrTmkyoVFuzgaQ745FF7SFVppe+NTB1rH1jzgMN8sgp3sdZuVSvCs+WmLcJ6LFay+oErmE8vbNwPEcdYwMhR9ReJQ3GMNm6vqwxwf0tspkGF74nqILVTpnpRnVxeka9znDEV0XfOe43TLcuaFYQonPYWiGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpBRHIKZkEXb6MmaaGhYrbuM1ytiCcfxB23vLqSIQjA=;
 b=ihQC1KyDIpfCnTAYGhMu4xRtnfGSSn99N/+8dMnQEvlyDp8Ls2Fz3Dc+YxvA2BrWhNzzhBop0sVKwHuafj87jTMmX4doHC0a8d5o8jk99dTsy41I/8gWEyLZLqZfTsTbpIRBiRyVxLMjZ8k5+3zpQXfBlEW6nvgLmkaJFifLV+4=
Received: from MW4PR03CA0204.namprd03.prod.outlook.com (2603:10b6:303:b8::29)
 by DM6PR12MB3833.namprd12.prod.outlook.com (2603:10b6:5:1cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Wed, 8 Dec
 2021 02:37:36 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::66) by MW4PR03CA0204.outlook.office365.com
 (2603:10b6:303:b8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Wed, 8 Dec 2021 02:37:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 02:37:35 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 20:37:33 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/7] drm/amd/pm: drop unneeded vcn/jpeg_gate_lock
Date: Wed, 8 Dec 2021 10:37:02 +0800
Message-ID: <20211208023707.1814122-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211208023707.1814122-1-evan.quan@amd.com>
References: <20211208023707.1814122-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bddef34-7107-4da9-3e93-08d9b9f3b1c1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3833:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB38335B59F2469DC9CF868465E46F9@DM6PR12MB3833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xSlVyev4LN7Xk/2AHuX1faY4wxdFvvWI++QzcCc1Gw4n67kQF29U1ZzM2dzUjPO7IidL8T8NtYy9UsYzMBx4HEsU9KDiFXBZ8aCDL3qlGKOV0De3u9uEtmpKJWZqADGNPsm1+KvMLefi9ekK8Qrz3AIs06kR4SmdmmHBX36uPX3xbqkIFyHSe1KyQGwbe2HWl1jWiweDeXpQTO6SoybZb0SyOtMLVeIaAi1mf9s8iT0qmGlHfSsNM/plTKapouJdB38FxnloVs0y8bWZgDgEIEsnWq1v2Zp7a/HgglRovYg/TEM8n+d/hqDcDX66FPbtxB6CdovpNaIb8rV+Dq/b8kZ7npMaCrg4V4y0BlFCgGb9iUI4kTrpVVMapUTamX/JqVFM48x4V5/6eWJv4C64Z/UmOUVe66VUhGR6FQmttQSE/GdynPGAUfC1zVgegIoOd1bMD7GZ2e01VMTgO2PMIrn0eoJ17U3EjJ5eLbKyeB5bzy/MD12QFcjy5CTQeUn9uV96gcz0oyHHecV3oyruzLK7Nvswg/KkYUGwgLB74gcL2k4ymA9qq3yM0yO8h9S65YQVi0pWDXGakcWo5QW4DyKZ2Errk8P2K8xbIU9zljGrU7AyorBvRM4TVGZvWz8YqjyGGFtvSxmtr9CT/cuzzu/hh8W8x0AfR78sba3t7eCSPGdjRijPtY53oBFufl/BR83I+nLBCc5jzQuT42nPPk/pCvXkPq+z9pg1g3Aa30zmvht3m+hlRy8RD11jKfpKUnYyjJ7TX/SPiC5MOov7noHrE6Fwck8oW7DYRBf5Mz4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(26005)(6666004)(44832011)(2906002)(54906003)(40460700001)(83380400001)(186003)(70586007)(86362001)(16526019)(70206006)(7696005)(356005)(36756003)(2616005)(5660300002)(4326008)(1076003)(81166007)(316002)(336012)(8936002)(8676002)(36860700001)(426003)(508600001)(6916009)(82310400004)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 02:37:35.8340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bddef34-7107-4da9-3e93-08d9b9f3b1c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3833
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As those related APIs are already protected by adev->pm.mutex.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I762fab96bb1c034c153b029f939ec6e498460007
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 56 +++----------------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 -
 2 files changed, 8 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index a4de15c0dbe4..a4fb6cf1413e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -158,8 +158,8 @@ static u32 smu_get_sclk(void *handle, bool low)
 	return clk_freq * 100;
 }
 
-static int smu_dpm_set_vcn_enable_locked(struct smu_context *smu,
-					 bool enable)
+static int smu_dpm_set_vcn_enable(struct smu_context *smu,
+				  bool enable)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
@@ -178,24 +178,8 @@ static int smu_dpm_set_vcn_enable_locked(struct smu_context *smu,
 	return ret;
 }
 
-static int smu_dpm_set_vcn_enable(struct smu_context *smu,
-				  bool enable)
-{
-	struct smu_power_context *smu_power = &smu->smu_power;
-	struct smu_power_gate *power_gate = &smu_power->power_gate;
-	int ret = 0;
-
-	mutex_lock(&power_gate->vcn_gate_lock);
-
-	ret = smu_dpm_set_vcn_enable_locked(smu, enable);
-
-	mutex_unlock(&power_gate->vcn_gate_lock);
-
-	return ret;
-}
-
-static int smu_dpm_set_jpeg_enable_locked(struct smu_context *smu,
-					  bool enable)
+static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
+				   bool enable)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
@@ -214,22 +198,6 @@ static int smu_dpm_set_jpeg_enable_locked(struct smu_context *smu,
 	return ret;
 }
 
-static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
-				   bool enable)
-{
-	struct smu_power_context *smu_power = &smu->smu_power;
-	struct smu_power_gate *power_gate = &smu_power->power_gate;
-	int ret = 0;
-
-	mutex_lock(&power_gate->jpeg_gate_lock);
-
-	ret = smu_dpm_set_jpeg_enable_locked(smu, enable);
-
-	mutex_unlock(&power_gate->jpeg_gate_lock);
-
-	return ret;
-}
-
 /**
  * smu_dpm_set_power_gate - power gate/ungate the specific IP block
  *
@@ -619,17 +587,14 @@ static int smu_set_default_dpm_table(struct smu_context *smu)
 	if (!smu->ppt_funcs->set_default_dpm_table)
 		return 0;
 
-	mutex_lock(&power_gate->vcn_gate_lock);
-	mutex_lock(&power_gate->jpeg_gate_lock);
-
 	vcn_gate = atomic_read(&power_gate->vcn_gated);
 	jpeg_gate = atomic_read(&power_gate->jpeg_gated);
 
-	ret = smu_dpm_set_vcn_enable_locked(smu, true);
+	ret = smu_dpm_set_vcn_enable(smu, true);
 	if (ret)
 		goto err0_out;
 
-	ret = smu_dpm_set_jpeg_enable_locked(smu, true);
+	ret = smu_dpm_set_jpeg_enable(smu, true);
 	if (ret)
 		goto err1_out;
 
@@ -638,13 +603,10 @@ static int smu_set_default_dpm_table(struct smu_context *smu)
 		dev_err(smu->adev->dev,
 			"Failed to setup default dpm clock tables!\n");
 
-	smu_dpm_set_jpeg_enable_locked(smu, !jpeg_gate);
+	smu_dpm_set_jpeg_enable(smu, !jpeg_gate);
 err1_out:
-	smu_dpm_set_vcn_enable_locked(smu, !vcn_gate);
+	smu_dpm_set_vcn_enable(smu, !vcn_gate);
 err0_out:
-	mutex_unlock(&power_gate->jpeg_gate_lock);
-	mutex_unlock(&power_gate->vcn_gate_lock);
-
 	return ret;
 }
 
@@ -1006,8 +968,6 @@ static int smu_sw_init(void *handle)
 
 	atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
-	mutex_init(&smu->smu_power.power_gate.vcn_gate_lock);
-	mutex_init(&smu->smu_power.power_gate.jpeg_gate_lock);
 
 	smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
 	smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 19b60a578144..8e7305d45b31 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -376,8 +376,6 @@ struct smu_power_gate {
 	bool vce_gated;
 	atomic_t vcn_gated;
 	atomic_t jpeg_gated;
-	struct mutex vcn_gate_lock;
-	struct mutex jpeg_gate_lock;
 };
 
 struct smu_power_context {
-- 
2.29.0

