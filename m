Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9631FC25B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 11:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0286410E6D3;
	Tue, 14 May 2024 11:06:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZISK9HFV";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BA5610E83B
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 11:06:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odKj4rzctqSgeDSEzD8uAABTMl4RzOZoqerFDuJLCQe7skb1xKtzoaiIOZlWbtQYZuTp+Affx523q3bvVzgZ/I3bnd49CyiMSERVH17oEUf7V6G/ftUAGYwGly0SQsVbVfUXVe9KyH1h2vY8xAvvkc5Pxl7+BT+NlJ8NvuBOALrW4YE/iltxkwfagjR0WwUKgUwaiwVfqA3tX0DuOtnmpeUbLuTCxyMOL4kUC5ebxyRtGSEjrDTr1o0a1uRAgFn7CsBEWXTHQ0mYPsBrMdyUQFXmDfLhaoP6TA28uBhwyyZXSZDnX7T0kKGSQX0TUqwE2Alajf0uQoT0HFMIXFwafA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8IauSP2U5MT1DYGxwuLtBy03sQz8ipW2cPaCrPEsb8=;
 b=AUVBnOeDr5nKT49yguTe1N35R7cp1a0l81beJwOb9OyoDDhN6VY9oBXW9TRQopIAXd2awg4sDDJNIEd+ipk8y1L13aBlCaZOTZnAHSr+zRXRKtM+WRQI4Wx0IqIEeeOFHpciID/ovxBUgiR21ZNwk0v+5wpMeOmLhS/MoEPekXJU2NglLLMS+9lFLPuU1o+doKWl1HmQTf7Wiv4MBHoeHlnuZxcIwwo3CBYxw1NkxhsrcvwlwBqyHSqFKf7oVS5CfU7yK1zakhYLnFBkM4yyIEKUmLlXABQCX/XZjpLiTtkKilX5T2ePGsB+XbCFXUlHwk+tZVwBzbYqYXyQpMs3oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8IauSP2U5MT1DYGxwuLtBy03sQz8ipW2cPaCrPEsb8=;
 b=ZISK9HFV4R8KZDznseUSUZixTio3udZALfpbdknhZ5p7brFdQBWwd5SeZq40+VIAR1wNUJhXu2bsKLtndRRtvgrRozL80DJ/JEVlarc9cRHtua+wFViyw2maBGK40tthAmhGpsd/GCee+RTwCoZodMQHJmqh0zEYmIVVhLVpFG4=
Received: from DM6PR07CA0047.namprd07.prod.outlook.com (2603:10b6:5:74::24) by
 SN7PR12MB8146.namprd12.prod.outlook.com (2603:10b6:806:323::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.25; Tue, 14 May
 2024 11:06:29 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:5:74:cafe::20) by DM6PR07CA0047.outlook.office365.com
 (2603:10b6:5:74::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Tue, 14 May 2024 11:06:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 11:06:29 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 06:06:27 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v4 03/10] drm/amd/pm: Add support to select pstate policy
Date: Tue, 14 May 2024 16:35:59 +0530
Message-ID: <20240514110606.396234-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240514110606.396234-1-lijo.lazar@amd.com>
References: <20240514110606.396234-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|SN7PR12MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: 744d67fa-df78-45d5-72fe-08dc7405e80b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vuMyIUldECY0lbJ0rsKar8JEIT4qfoIgR9XAqPGjd/72WH1RuWUJqHkrbv/Y?=
 =?us-ascii?Q?QhabVwVAWq+uhrXmxa/RJiEO9PylW38/61N8GrCLBr6IR325cuiwoeU31hRN?=
 =?us-ascii?Q?ic+o//6cC6CcKTHyvncG8oITOb2riw31oQbyoVBrsbLnwiGrExbJ6/GrAOHH?=
 =?us-ascii?Q?L7yD+KuY55PlU0/jEFKDlcjzUmPMsVfox+O5/cHLWme+612roGSRHiiL3V94?=
 =?us-ascii?Q?rOaaVkc97t8xoeICCoullVFXQoJHuEN5Gk0PHDYCij8HA/0WLo9MzVkXMHNq?=
 =?us-ascii?Q?TZ2NrlHpIsTWVWZ3LWx42JMiySLD6IpXsRpSd89hnaFZWuuP8TJXgH8Pa7QM?=
 =?us-ascii?Q?KSk6BdtbfqEsgQJ/vaxhBWDq1/vwtuqWqYluUQ8v/qlE36RPNx6k3NR9zG1L?=
 =?us-ascii?Q?P+/j9htTy6HyBI0Lkwb9NYYYdutlFu/4krtK8vHruOmPsu8i7SeFX/7Pr6HV?=
 =?us-ascii?Q?FkmFKTkx0BTwKFznbXsSNTR37sFbyLLyFRdFOgwwUZVGmJWSEvPiiOzmfSeo?=
 =?us-ascii?Q?uHSR7S+nj+M/XMwTg+bKcSOsesNnpsGzhTuT8ht13yVT8dJ3lc13WJAgCVwo?=
 =?us-ascii?Q?gylA6zr7MtbSQfDBhG8lBMqM/8UONS/vA5qU5N1Q5Kx+PhwPGMlNMVTjuBGZ?=
 =?us-ascii?Q?FXTu+eAUg1yzkcX+2DL34T/j0KFSeM/zqjQ/jXjavQ3HoKlTsFKRH256V/tL?=
 =?us-ascii?Q?GxHVm7li0TqEVmsltxTnrdiW0J5IEM2IAajqgDCUwphVoDuViKEgeHMgWWKE?=
 =?us-ascii?Q?3A2jtd+rgprucecCBvu4ztq4oWNSLLzXR2tzLLJGDte6HfNE4URXlNfLrOBw?=
 =?us-ascii?Q?Xz44/4QAAj+jW0pLcQN+B/5JZ+KKBKgLHgn4A47SMFKUl1lka56rfV8VQ9n5?=
 =?us-ascii?Q?13Ie6pailu3bbOsHT7AqbM+aVTUtHwHdTjzzmNhiXstqT56oY6rt6OTX/lIf?=
 =?us-ascii?Q?sf38T3VkOXlPkc9G+ll/oGTRRAHouoGugQtkQRlgRYzZop/pyy+k3cYOFEOu?=
 =?us-ascii?Q?pSV2MEUUnAQhrPrj/pDZqcBqPvqTKARgBQvgJOOWhiwSCSuJlYuwOe/y9oA+?=
 =?us-ascii?Q?k+sjZA7Xqu5ljXD6eh6+Ooe4ngBxxts7fRRgJDyiSxIco1uZbyrIf0Rvy9RW?=
 =?us-ascii?Q?NBzMea0VewVd8RMnBCqQwTFzm8dAmGgKkETI3tbnWvyoTcRMHzZ+phXGldOr?=
 =?us-ascii?Q?PCPQ94wttbhs+Kc7S8eGLdgPObyQRkTJOG7rAP/pwobwhorXzLpyLZ/Drg/3?=
 =?us-ascii?Q?RzXGL201pDN05IHzlfA0DvGtll+zFxh0oNxwaTlq0qUY3Uiaeh40BWyUg8Ay?=
 =?us-ascii?Q?v/GqUg+OEW2f7W4GiqS26XF4OBzxxb6V2RH+LVudWMwXk0FDRi6Ury8Y7X6t?=
 =?us-ascii?Q?yN+Tf+U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 11:06:29.5865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 744d67fa-df78-45d5-72fe-08dc7405e80b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8146
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

Add support to select pstate policy in SOCs with SMUv13.0.6

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
v2,v3: No change
v4: Use macro for policy type name

 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  2 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 71 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 30 ++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  1 +
 4 files changed, 104 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 9c0445fa9f9b..3a50076e44f0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -531,10 +531,12 @@ int smu_v13_0_fini_smc_tables(struct smu_context *smu)
 	smu_table->watermarks_table = NULL;
 	smu_table->metrics_time = 0;
 
+	kfree(smu_dpm->dpm_policies);
 	kfree(smu_dpm->dpm_context);
 	kfree(smu_dpm->golden_dpm_context);
 	kfree(smu_dpm->dpm_current_power_state);
 	kfree(smu_dpm->dpm_request_power_state);
+	smu_dpm->dpm_policies = NULL;
 	smu_dpm->dpm_context = NULL;
 	smu_dpm->golden_dpm_context = NULL;
 	smu_dpm->dpm_context_size = 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ed9c4866b6e4..0ed0b5326d35 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -174,6 +174,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(McaBankCeDumpDW,                     PPSMC_MSG_McaBankCeDumpDW,                 SMU_MSG_RAS_PRI),
 	MSG_MAP(SelectPLPDMode,                      PPSMC_MSG_SelectPLPDMode,                  0),
 	MSG_MAP(RmaDueToBadPageThreshold,            PPSMC_MSG_RmaDueToBadPageThreshold,        0),
+	MSG_MAP(SelectPstatePolicy,                  PPSMC_MSG_SelectPstatePolicy,              0),
 };
 
 // clang-format on
@@ -369,6 +370,39 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 	return 0;
 }
 
+static int smu_v13_0_6_select_policy_soc_pstate(struct smu_context *smu,
+						int policy)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret, param;
+
+	switch (policy) {
+	case SOC_PSTATE_DEFAULT:
+		param = 0;
+		break;
+	case SOC_PSTATE_0:
+		param = 1;
+		break;
+	case SOC_PSTATE_1:
+		param = 2;
+		break;
+	case SOC_PSTATE_2:
+		param = 3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SelectPstatePolicy,
+					      param, NULL);
+
+	if (ret)
+		dev_err(adev->dev, "select soc pstate policy %d failed",
+			policy);
+
+	return ret;
+}
+
 static int smu_v13_0_6_allocate_dpm_context(struct smu_context *smu)
 {
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
@@ -379,6 +413,24 @@ static int smu_v13_0_6_allocate_dpm_context(struct smu_context *smu)
 		return -ENOMEM;
 	smu_dpm->dpm_context_size = sizeof(struct smu_13_0_dpm_context);
 
+	if (!(smu->adev->flags & AMD_IS_APU)) {
+		struct smu_dpm_policy *policy;
+
+		smu_dpm->dpm_policies =
+			kzalloc(sizeof(struct smu_dpm_policy_ctxt), GFP_KERNEL);
+		policy = &(smu_dpm->dpm_policies->policies[0]);
+
+		policy->policy_type = PP_PM_POLICY_SOC_PSTATE;
+		policy->level_mask = BIT(SOC_PSTATE_DEFAULT) |
+				     BIT(SOC_PSTATE_0) | BIT(SOC_PSTATE_1) |
+				     BIT(SOC_PSTATE_2);
+		policy->current_level = SOC_PSTATE_DEFAULT;
+		policy->set_policy = smu_v13_0_6_select_policy_soc_pstate;
+		smu_cmn_generic_soc_policy_desc(policy);
+		smu_dpm->dpm_policies->policy_mask |=
+			BIT(PP_PM_POLICY_SOC_PSTATE);
+	}
+
 	return 0;
 }
 
@@ -639,6 +691,15 @@ static int smu_v13_0_6_get_dpm_level_count(struct smu_context *smu,
 	return ret;
 }
 
+static void smu_v13_0_6_pm_policy_init(struct smu_context *smu)
+{
+	struct smu_dpm_policy *policy;
+
+	policy = smu_get_pm_policy(smu, PP_PM_POLICY_SOC_PSTATE);
+	if (policy)
+		policy->current_level = SOC_PSTATE_DEFAULT;
+}
+
 static int smu_v13_0_6_set_default_dpm_table(struct smu_context *smu)
 {
 	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
@@ -668,6 +729,16 @@ static int smu_v13_0_6_set_default_dpm_table(struct smu_context *smu)
 
 	smu_v13_0_6_setup_driver_pptable(smu);
 
+	/* DPM policy not supported in older firmwares */
+	if (!(smu->adev->flags & AMD_IS_APU) &&
+	    (smu->smc_fw_version < 0x00556000)) {
+		struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+
+		smu_dpm->dpm_policies->policy_mask &=
+			~BIT(PP_PM_POLICY_SOC_PSTATE);
+	}
+
+	smu_v13_0_6_pm_policy_init(smu);
 	/* gfxclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.gfx_table;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT)) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 602aa6941231..27e4a97411cf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1132,3 +1132,33 @@ bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev)
 
 	return snd_driver_loaded;
 }
+
+static char *smu_soc_policy_get_desc(struct smu_dpm_policy *policy, int level)
+{
+	if (level < 0 || !(policy->level_mask & BIT(level)))
+		return "Invalid";
+
+	switch (level) {
+	case SOC_PSTATE_DEFAULT:
+		return "soc_pstate_default";
+	case SOC_PSTATE_0:
+		return "soc_pstate_0";
+	case SOC_PSTATE_1:
+		return "soc_pstate_1";
+	case SOC_PSTATE_2:
+		return "soc_pstate_2";
+	}
+
+	return "Invalid";
+}
+
+static struct smu_dpm_policy_desc pstate_policy_desc = {
+	.name = STR_SOC_PSTATE_POLICY,
+	.get_desc = smu_soc_policy_get_desc,
+};
+
+void smu_cmn_generic_soc_policy_desc(struct smu_dpm_policy *policy)
+{
+	policy->desc = &pstate_policy_desc;
+}
+
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 81bfce1406e5..d135d984329e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -144,6 +144,7 @@ static inline void smu_cmn_get_sysfs_buf(char **buf, int *offset)
 }
 
 bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev);
+void smu_cmn_generic_soc_policy_desc(struct smu_dpm_policy *policy);
 
 #endif
 #endif
-- 
2.25.1

