Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC6EC25B77
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 12:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07B3910ECE4;
	Thu, 16 May 2024 12:43:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KVMYiCXm";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2530A10ECDC
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 12:43:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHk3elK6N27/aNcEuM2gBTLxtBl/G4UCzg9xUcy7skxhUx0H6wv/UBiAoZZCsIog80cE0ev73VGoj7R3knooAPVmppKzzZUYITUH0tvqF5YXNfORwp9MyAvRJ8L/V/8hP6p8FLfo6B5D/hKvjuuWKJOeOFxFLPtU/z5f5MIVVO0Epi5TplddsCVb3OlJuAtpR/fZKC0OuomYK8Z34DUMnbYSK1OFIF5lwqZbBKl5f+iW6/nWR2cz3XNczR0sooMLZ/QHyhkFHEHMY2WoyHDrfJAI+WNz80cNBqn6Nd4gX3Iubt6kPrmYV2KdQFDuUM7ylKF08RhntE1ZM01w1ACypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXs8O7Ii2o/R+IwY7x8joVg+GqGlXX6bX4+GFStG8mE=;
 b=c2/Oq2runNiAKbgd0WjYX9wny/ezATqtbKGcQsrPSzkf0O6y/6lrTOG2f1PMdzoz4VI0/8V/QAtdqcq7H7+O8o9JeJ6Adsf3UFzEUL2x0vCPMUGP0bc3CIhNTNZml4pr5ptxUK/odTixLkH+yZuUNn5YxudmsIMgppTCMvotJUNOnsmHfWOtcwZt1ghYhqDDNLPpr8m+BAB0hjBmTCwYuaHpxrQ5i3gkHWCX1PdIVDIzu12+1HCf5eHXUAfhiptGFbOJ8tqyQfluOJDVFnzTSLAcOPqN0MfU5tZhWxhDLsNMil7wb6WK5Sk0yfZ786QrcopblXagTAxFV0xDFIzoZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXs8O7Ii2o/R+IwY7x8joVg+GqGlXX6bX4+GFStG8mE=;
 b=KVMYiCXmXP+VvO6OPXj/2UGXX13EKDOSegibwHwUBjFvsZPdYK1FXW8vgPRCgPErD64RGhIRk8Z3dAwdV29Gaif0+lRXXgXd37svqrlF1QF2QsahFetH5wBTXf0s3ylRe4sb6629dpxb+rTUbt+aEE6pxc42vJ6ytvz/5dUmV+w=
Received: from DM6PR03CA0027.namprd03.prod.outlook.com (2603:10b6:5:40::40) by
 DS0PR12MB8563.namprd12.prod.outlook.com (2603:10b6:8:165::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.28; Thu, 16 May 2024 12:43:49 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:40:cafe::69) by DM6PR03CA0027.outlook.office365.com
 (2603:10b6:5:40::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Thu, 16 May 2024 12:43:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 12:43:48 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 07:43:46 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>, Asad Kamal <asad.kamal@amd.com>
Subject: [PATCH v5 05/10] drm/amd/pm: Add xgmi plpd to SMU v13.0.6 pm_policy
Date: Thu, 16 May 2024 18:13:13 +0530
Message-ID: <20240516124318.508785-6-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240516124318.508785-1-lijo.lazar@amd.com>
References: <20240516124318.508785-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|DS0PR12MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: b99665dd-c5cc-4bf9-ad31-08dc75a5d561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S/XGnuyVFKfNJHpX6Mwl4G2KkY4o3bx852Cuoc+p9Jjy+QIpe4vddu0Jaeyn?=
 =?us-ascii?Q?PemGqk7xWN89KexYoDMjOe0XzgAF1McLo2yT7Iff9RTzdKHjXNUNWxM9Ihz6?=
 =?us-ascii?Q?RMNcrpmjopAYwVqS7RhXmyguOVZSYA7Bnpp6B6U+KyWQ0C7MaQ5ALBgOyR27?=
 =?us-ascii?Q?cGms8Yt5OQ12z5VohZ8jBVhMqZFXwkuD1zO1eqKMDENlP/25zrdrWtNkFdWD?=
 =?us-ascii?Q?jiJtKD4Bmc3I8Q7lsYSvgFxOWV9oQ6zDFYpp4ZaLDT3gXFxSB7gdX693W2r0?=
 =?us-ascii?Q?vqPR6ZdeV1q8atiA+3Jp4lSJPuW1yO/MjA/xfc8lUk0KagQIBot/wGWZefyz?=
 =?us-ascii?Q?Mq57PnIv5+PCh+FEBxtYy7vuGhxj3DBD47gGVXHlkVvlfLzhuX80gui2ZuEM?=
 =?us-ascii?Q?MsiwE0mku+WvO2G/gdX3lBROYc6W8LiWMgnJOMpcU2gaOv7IRGYk91Wc9QY/?=
 =?us-ascii?Q?U8pTRkpUEBd53WrWoyD87UBogGOBbREdw3s61NbwTg6MDDiWC5UeMQN9rZl3?=
 =?us-ascii?Q?G/9+0TghSer54zEzAgEZwD7Gm8NPPPC7/MB6SzI4/aSvJfSbRtSqF6i8zF/7?=
 =?us-ascii?Q?/2PDJ1T2oTAFu4izOQQ54qc/S1QoLpYP4/3YHqTm6Np1Br02qu9/7TzXypW7?=
 =?us-ascii?Q?Isgw/dvlixFoADlegsH17Rh2FmQR1bw0gG0KOjUsXZHAkyOA3DqMsikXz19G?=
 =?us-ascii?Q?ii91s4gt3/NgM12sD6DqFd649j0GOZhcjRyhtVshxiuYN9nCP4uAAAruvKUl?=
 =?us-ascii?Q?UUuPiYBYjHG2JoHZwIH3Meoas+I+fVjVjiuLG75BDV+OmGAUm71CmOnGsXtl?=
 =?us-ascii?Q?45/OY184aZHlNBREz3O8EG2YDBmPcO5mGZU1heVgUTpxg+2X2Nagp3/+x4M8?=
 =?us-ascii?Q?+XKN0l1lyAlZEDwbK/mab9e2KzIm4HXAWkwGLTjiA3Gvg7qASm84FJeL8dy9?=
 =?us-ascii?Q?wzk1rPZhC1OIhP9HjS4CUaPM92iKegC7Kv34+t0lAO8VWn1ZMc8/02PHcIzf?=
 =?us-ascii?Q?2uLWXi3Gswd5RaARhw9ZyED7r8INnI6yvpHQyJygz6ShKKOZczyTHfUyHbgw?=
 =?us-ascii?Q?0vj8SfnQ5/W9l982uFpFDG7Tb3wVtIXLbIVX6/lvL+pnTI55Z0q7aBNnwQLY?=
 =?us-ascii?Q?gEZvVFhMZRlSOHo/vhDuxl3eGFzgJmguuGisXtfkmlhr4aqVGu6jNOSJHWtE?=
 =?us-ascii?Q?SFJ4BpBx6H5uGzRdN7Nbi55KZqvwotlIEu4qsGDi3miiW+W7i/a35nU7mnr2?=
 =?us-ascii?Q?D3e0l7jH2rHWdm/uwhBWHuRkvzvsdZ1mVQlAAJcRAqKSfzxMK3CihJJrdT+w?=
 =?us-ascii?Q?VvYdzXxvZY3hNCz79vSnImWfCSW9lrCATWlqB0tyC6aQsz4y4liVsbMtQTTu?=
 =?us-ascii?Q?niAsdqU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 12:43:48.8988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b99665dd-c5cc-4bf9-ad31-08dc75a5d561
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8563
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

On SOCs with SMU v13.0.6, allow changing xgmi plpd policy through
'pm_policy/xgmi_plpd' sysfs interface.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
v2, v3: No change
v4: Use macro for XGMI policy type name

 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 17 ++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 51 +++++++++++++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 27 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  1 +
 4 files changed, 90 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b7bce8c34634..14d712b0454d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1197,6 +1197,9 @@ static void smu_swctf_delayed_work_handler(struct work_struct *work)
 
 static void smu_init_xgmi_plpd_mode(struct smu_context *smu)
 {
+	struct smu_dpm_context *dpm_ctxt = &(smu->smu_dpm);
+	struct smu_dpm_policy_ctxt *policy_ctxt;
+
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 2)) {
 		smu->plpd_mode = XGMI_PLPD_DEFAULT;
 		return;
@@ -1204,10 +1207,20 @@ static void smu_init_xgmi_plpd_mode(struct smu_context *smu)
 
 	/* PMFW put PLPD into default policy after enabling the feature */
 	if (smu_feature_is_enabled(smu,
-				   SMU_FEATURE_XGMI_PER_LINK_PWR_DWN_BIT))
+				   SMU_FEATURE_XGMI_PER_LINK_PWR_DWN_BIT)) {
+		struct smu_dpm_policy *policy;
+
 		smu->plpd_mode = XGMI_PLPD_DEFAULT;
-	else
+		policy = smu_get_pm_policy(smu, PP_PM_POLICY_XGMI_PLPD);
+		if (policy)
+			policy->current_level = XGMI_PLPD_DEFAULT;
+	} else {
 		smu->plpd_mode = XGMI_PLPD_NONE;
+		policy_ctxt = dpm_ctxt->dpm_policies;
+		if (policy_ctxt)
+			policy_ctxt->policy_mask &=
+				~BIT(PP_PM_POLICY_XGMI_PLPD);
+	}
 }
 
 static int smu_sw_init(void *handle)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index aebc7713ce42..3fe158e3899c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -403,9 +403,45 @@ static int smu_v13_0_6_select_policy_soc_pstate(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v13_0_6_select_plpd_policy(struct smu_context *smu, int level)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret, param;
+
+	switch (level) {
+	case XGMI_PLPD_DEFAULT:
+		param = PPSMC_PLPD_MODE_DEFAULT;
+		break;
+	case XGMI_PLPD_OPTIMIZED:
+		param = PPSMC_PLPD_MODE_OPTIMIZED;
+		break;
+	case XGMI_PLPD_DISALLOW:
+		param = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (level == XGMI_PLPD_DISALLOW)
+		ret = smu_cmn_send_smc_msg_with_param(
+			smu, SMU_MSG_GmiPwrDnControl, param, NULL);
+	else
+		/* change xgmi per-link power down policy */
+		ret = smu_cmn_send_smc_msg_with_param(
+			smu, SMU_MSG_SelectPLPDMode, param, NULL);
+
+	if (ret)
+		dev_err(adev->dev,
+			"select xgmi per-link power down policy %d failed\n",
+			level);
+
+	return ret;
+}
+
 static int smu_v13_0_6_allocate_dpm_context(struct smu_context *smu)
 {
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+	struct smu_dpm_policy *policy;
 
 	smu_dpm->dpm_context =
 		kzalloc(sizeof(struct smu_13_0_dpm_context), GFP_KERNEL);
@@ -413,11 +449,9 @@ static int smu_v13_0_6_allocate_dpm_context(struct smu_context *smu)
 		return -ENOMEM;
 	smu_dpm->dpm_context_size = sizeof(struct smu_13_0_dpm_context);
 
+	smu_dpm->dpm_policies =
+		kzalloc(sizeof(struct smu_dpm_policy_ctxt), GFP_KERNEL);
 	if (!(smu->adev->flags & AMD_IS_APU)) {
-		struct smu_dpm_policy *policy;
-
-		smu_dpm->dpm_policies =
-			kzalloc(sizeof(struct smu_dpm_policy_ctxt), GFP_KERNEL);
 		policy = &(smu_dpm->dpm_policies->policies[0]);
 
 		policy->policy_type = PP_PM_POLICY_SOC_PSTATE;
@@ -430,6 +464,15 @@ static int smu_v13_0_6_allocate_dpm_context(struct smu_context *smu)
 		smu_dpm->dpm_policies->policy_mask |=
 			BIT(PP_PM_POLICY_SOC_PSTATE);
 	}
+	policy = &(smu_dpm->dpm_policies->policies[1]);
+
+	policy->policy_type = PP_PM_POLICY_XGMI_PLPD;
+	policy->level_mask = BIT(XGMI_PLPD_DISALLOW) | BIT(XGMI_PLPD_DEFAULT) |
+			     BIT(XGMI_PLPD_OPTIMIZED);
+	policy->current_level = XGMI_PLPD_DEFAULT;
+	policy->set_policy = smu_v13_0_6_select_plpd_policy;
+	smu_cmn_generic_plpd_policy_desc(policy);
+	smu_dpm->dpm_policies->policy_mask |= BIT(PP_PM_POLICY_XGMI_PLPD);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 50fe9feaf80d..f265a449c342 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1165,3 +1165,30 @@ void smu_cmn_generic_soc_policy_desc(struct smu_dpm_policy *policy)
 	policy->desc = &pstate_policy_desc;
 }
 
+static char *smu_xgmi_plpd_policy_get_desc(struct smu_dpm_policy *policy,
+					   int level)
+{
+	if (level < 0 || !(policy->level_mask & BIT(level)))
+		return "Invalid";
+
+	switch (level) {
+	case XGMI_PLPD_DISALLOW:
+		return "plpd_disallow";
+	case XGMI_PLPD_DEFAULT:
+		return "plpd_default";
+	case XGMI_PLPD_OPTIMIZED:
+		return "plpd_optimized";
+	}
+
+	return "Invalid";
+}
+
+static struct smu_dpm_policy_desc xgmi_plpd_policy_desc = {
+	.name = STR_XGMI_PLPD_POLICY,
+	.get_desc = smu_xgmi_plpd_policy_get_desc,
+};
+
+void smu_cmn_generic_plpd_policy_desc(struct smu_dpm_policy *policy)
+{
+	policy->desc = &xgmi_plpd_policy_desc;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index d135d984329e..1de685defe85 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -145,6 +145,7 @@ static inline void smu_cmn_get_sysfs_buf(char **buf, int *offset)
 
 bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev);
 void smu_cmn_generic_soc_policy_desc(struct smu_dpm_policy *policy);
+void smu_cmn_generic_plpd_policy_desc(struct smu_dpm_policy *policy);
 
 #endif
 #endif
-- 
2.25.1

