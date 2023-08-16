Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D15C001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 12:32:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 977F210E366;
	Wed, 16 Aug 2023 12:32:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D916810E364
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 12:32:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwrcxETFdfdoOOGOvSSGVHY9RCdXiaTxXIDyVKUVbogE5X6R234Jok1exfjRkIFxHvvTM+7l2yH3PTso8hFkHxL8OabT5EDhhRTvcbQffDiSpyGe7ynAkPuuSzZG0aDQbARVFPWNtoBMPnXTlgI3WnilvNH4FGIgk0Bdh51fDU0r5/BF5zCNl2B1GYm7OWwpmceu3S/NuSEbxQXHW0OzbUwEwNFpbiGgXSPI6hHyOQOCW3K+13HldOMC2aep1hDrT6uodQZCVwJcJj/1G2mBJvTNtRoFFfow4pt/pudvGQhKA08a29zAOjf/d/vc8RYUWqPN2PdyA1qsHXVeAn8bOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d879iNZTgH5c6xVmTH0Ykq5JS3g1zvKTvgGMe0A83K8=;
 b=YrFLMwskcVSFcOZ9KU+PAkGi3n0BvO9cfwtDgiNUaac6ZkOn9Wz30OcBp67eq/+wsL1qrheeZCX23jHsf6yTM/Mj6LsOMMbNXG/mjJo8A+8copP2WgV6ia9qiPC18HVIs9nkD+WpdR9a/AczAEGqCLxwjHVBe6NsJfwnNvypgMMSNLWRSVRp+Y62OI/3TAyI7DFC+ovZpMOZEDcISahbIyLoR6+aqYOP82+1dEyhE8NsrThfgWW9Rj5p/5Ff8ixVSFfkGNK704D3hbmnXOkoEwRkPZU7Vru+ln7n5z1VcMWTq/Hdl0+Z7Uls2LSQXLwUST9yPGQ5LRuzlpCm9IoVhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d879iNZTgH5c6xVmTH0Ykq5JS3g1zvKTvgGMe0A83K8=;
 b=GhXYhwmxudZNWqf3LmYsbZcqaO1tnk96HQnG8E6TALdQVA2SkIrt6Nctk58qtFuDbNNyt+cdWbhdle5FicfxvPAuj5pXQQYGJnJDx2Z1kGldxx+GxkYBS4AzWrpdsdnUSU5NINj2W6aMXwB7/UCFlnPyfC538xcBpfoD++zrm78=
Received: from MW4PR03CA0046.namprd03.prod.outlook.com (2603:10b6:303:8e::21)
 by PH8PR12MB7232.namprd12.prod.outlook.com (2603:10b6:510:224::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 12:32:25 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:8e:cafe::d5) by MW4PR03CA0046.outlook.office365.com
 (2603:10b6:303:8e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 12:32:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.5 via Frontend Transport; Wed, 16 Aug 2023 12:32:24 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 07:32:22 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amd/pm: Add critical temp for GC v9.4.3
Date: Wed, 16 Aug 2023 20:32:01 +0800
Message-ID: <20230816123201.1195066-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816123201.1195066-1-asad.kamal@amd.com>
References: <20230816123201.1195066-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|PH8PR12MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 455d5bdf-ff83-4f9c-87fe-08db9e54d888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sUAHdNiWfIG+7KpCZF4D34nWby3wbg+JFZ0PgTMDmROnpzy3wwzSs3A8h2JLXMl4FOU6nzL3SeuIezTRr2N2dPb3BNT6UuztJX3PYM/JhdqfUlxAl5HUtL9IwD462tGF66kknXH79AfgRcRbLs2zVQYydGYcXtvD6iw+J75SfXAiNemxRfvJSL2gQuHZdThcnDaqxXZpRiyr3TE6lnXosvMgDbCeZSeXCSKjW1VqlmkPFwgbkS98W1StWGh3e7XzU5x47AUFCxlv+jCCKrlJU8VkSn7K77j3griEYEzEar9onUa1tajaPXThKLJN2+9dVoOiJruafSbvOaEkZbhHnvuyqVr+w7sgomZgUPM8DwWYv0Ri6VVxnJ0aSlKsttJvtZDqKh9Zo8lSZ4kNVUfcMLyW61cMLbpp6mLZYf0VgsTFXWG2ArDraegKQDBik9LEzC/GqLaJ0mfoaIDaAKjc2Rrt9d1LEVc3KsVPIogvTSlOK6eNVfPZTA3laKhILNkg5dRNTvyeFpstksnHTnvMEKR5VGUFmaVYx55RChLiljuO6v/XAw/2pEnkEKRbUYSV1aOH1QFJM+co05eYVcVXAV1VLwo8Uo8nt/siMCR7y0biHPVYhgChbqx2a9ahQQ33AVy9M7tK8Wotl61P+l/ViPnKojHr9ypGIyoWhQ3E0E8mUmx6fsdwnLnwF4yjmJRJlTbHKhFOHvlor4xImQCgMffF8arpiNwQ2JiXkQJIejdyr5/ZJRkpistQyP7Pz31lyOo1ZARVBePBN/4Baawzog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199024)(1800799009)(82310400011)(186009)(46966006)(36840700001)(40470700004)(2906002)(40460700003)(83380400001)(86362001)(40480700001)(478600001)(426003)(336012)(7696005)(36756003)(2616005)(6666004)(1076003)(26005)(16526019)(5660300002)(44832011)(41300700001)(36860700001)(356005)(82740400003)(54906003)(316002)(81166007)(70206006)(70586007)(6916009)(8676002)(8936002)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 12:32:24.8918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 455d5bdf-ff83-4f9c-87fe-08db9e54d888
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7232
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
Cc: le.ma@amd.com, Lijo Lazar <lijo.lazar@amd.com>, asad.kamal@amd.com,
 shiwu.zhang@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add critical temperature message support func for smu v13.0.6
and expose critical temperature as part of hw mon attributes
for GC v9.4.3

v2:
Added comment for pmfw version requirement & move the check
to get_thermal_temperature_range function

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  8 +--
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 50 +++++++++++++++++++
 3 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 5b1d73b00ef7..f03647fa3df6 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3311,8 +3311,10 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	    (gc_ver != IP_VERSION(9, 4, 3)) &&
 	    (attr == &sensor_dev_attr_temp2_input.dev_attr.attr ||
 	     attr == &sensor_dev_attr_temp2_label.dev_attr.attr ||
+	     attr == &sensor_dev_attr_temp2_crit.dev_attr.attr ||
 	     attr == &sensor_dev_attr_temp3_input.dev_attr.attr ||
-	     attr == &sensor_dev_attr_temp3_label.dev_attr.attr))
+	     attr == &sensor_dev_attr_temp3_label.dev_attr.attr ||
+	     attr == &sensor_dev_attr_temp3_crit.dev_attr.attr))
 		return 0;
 
 	/* hotspot temperature for gc 9,4,3*/
@@ -3324,9 +3326,7 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	/* only SOC15 dGPUs support hotspot and mem temperatures */
 	if (((adev->flags & AMD_IS_APU) || gc_ver < IP_VERSION(9, 0, 0) ||
 	    (gc_ver == IP_VERSION(9, 4, 3))) &&
-	    (attr == &sensor_dev_attr_temp2_crit.dev_attr.attr ||
-	     attr == &sensor_dev_attr_temp2_crit_hyst.dev_attr.attr ||
-	     attr == &sensor_dev_attr_temp3_crit.dev_attr.attr ||
+	     (attr == &sensor_dev_attr_temp2_crit_hyst.dev_attr.attr ||
 	     attr == &sensor_dev_attr_temp3_crit_hyst.dev_attr.attr ||
 	     attr == &sensor_dev_attr_temp1_emergency.dev_attr.attr ||
 	     attr == &sensor_dev_attr_temp2_emergency.dev_attr.attr ||
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 297b70b9388f..c2904791fc6f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -84,6 +84,7 @@
        __SMU_DUMMY_MAP(SetTjMax),                     \
        __SMU_DUMMY_MAP(SetFanTemperatureTarget),      \
        __SMU_DUMMY_MAP(PrepareMp1ForUnload),          \
+       __SMU_DUMMY_MAP(GetCTFLimit),                  \
        __SMU_DUMMY_MAP(DramLogSetDramAddrHigh),       \
        __SMU_DUMMY_MAP(DramLogSetDramAddrLow),        \
        __SMU_DUMMY_MAP(DramLogSetDramSize),           \
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 6ed9cd0a1e4e..7d8af9b309b7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -132,6 +132,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(SetSoftMinGfxclk,                    PPSMC_MSG_SetSoftMinGfxClk,                0),
 	MSG_MAP(SetSoftMaxGfxClk,                    PPSMC_MSG_SetSoftMaxGfxClk,                0),
 	MSG_MAP(PrepareMp1ForUnload,                 PPSMC_MSG_PrepareForDriverUnload,          0),
+	MSG_MAP(GetCTFLimit,                         PPSMC_MSG_GetCTFLimit,                     0),
 };
 
 static const struct cmn2asic_mapping smu_v13_0_6_clk_map[SMU_CLK_COUNT] = {
@@ -2081,6 +2082,54 @@ static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
 	return ret;
 }
 
+static int smu_v13_0_6_get_thermal_temperature_range(struct smu_context *smu,
+						     struct smu_temperature_range *range)
+{
+	struct amdgpu_device *adev = smu->adev;
+	u32 aid_temp, xcd_temp;
+	uint32_t smu_version;
+	u32 ccd_temp = 0;
+	int ret;
+
+	if (amdgpu_sriov_vf(smu->adev))
+		return 0;
+
+	if (!range)
+		return -EINVAL;
+
+	/*Check smu version, GetCtfLimit message only supported for smu version 85.69 or higher */
+	smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	if (smu_version < 0x554500)
+		return 0;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetCTFLimit,
+					      PPSMC_AID_THM_TYPE, &aid_temp);
+	if (ret)
+		goto failed;
+
+	if (adev->flags & AMD_IS_APU) {
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetCTFLimit,
+						      PPSMC_CCD_THM_TYPE, &ccd_temp);
+		if (ret)
+			goto failed;
+	}
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetCTFLimit,
+					      PPSMC_XCD_THM_TYPE, &xcd_temp);
+	if (ret)
+		goto failed;
+
+	range->hotspot_crit_max = max3(aid_temp, xcd_temp, ccd_temp);
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetCTFLimit,
+					      PPSMC_HBM_THM_TYPE, &range->mem_crit_max);
+	if (ret)
+		goto failed;
+
+	return 0;
+failed:
+	return ret;
+}
+
 static int smu_v13_0_6_mode1_reset(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -2177,6 +2226,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.get_gpu_metrics = smu_v13_0_6_get_gpu_metrics,
+	.get_thermal_temperature_range = smu_v13_0_6_get_thermal_temperature_range,
 	.mode1_reset_is_support = smu_v13_0_6_is_mode1_reset_supported,
 	.mode2_reset_is_support = smu_v13_0_6_is_mode2_reset_supported,
 	.mode1_reset = smu_v13_0_6_mode1_reset,
-- 
2.34.1

