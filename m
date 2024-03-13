Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D07C54791
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 11:03:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1050610F705;
	Wed, 13 Mar 2024 11:03:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5eHDWY08";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5609010F4F5
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 11:03:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5tcky/k/IsffZHZgdt6wtWaWWEl8aBmsdwYdlhJgysPqU9RXM6M9+mLVfDxkzgwE4RVUjIkAF07zCHKI9cV8Lo6z4L3vNMxM4zUx7UpxLWPw894LXwaWl6djdwyUDwybBJNxpom6r4HmV5ft+1sDIQ3IBE1EZpKuGv+p5sEMReKURJXlouIheN/Jz89UeYfwPbJmDbJqkSRFvCebC16avs2xa3vNTqdVXow0wY0+hSPvotJmJdtnjM3ZUBh+T8VKhsT3lP+cJv2xUP91ivL+/biLDhzo40JMMW8AMAqFpmzB1ZnWs23/QfugkFMQyO8hwYJYmXDygBiaqyOm/yOLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NlUW6tTLPhAOnyRpfcrQB5bnkLZ7JiL5nBm08xCZDM=;
 b=kKMJ21lszhtQEVIYuMfGGeLcgps7p4QvHGyWBTeySh+ONmkTiio3dNLALrtsYKGyDEyA+e2tnasr954TX36pfBzVFMVXHuTxJUskIsBbWLmKhk5TcBjXOer9hOaMjBasIOWPhVxqHO+Up7MLKf+ASnGTZfeud9KefYDgSkTcwy0N6DtzzFUO0keijIYH7zxfl5x4KC+EMsz1CFGNlA3K5zvjTpS7dq4o6rlDO1gMaHeTScFVd2rqJN80p485D0V3rjyFRjvyfmJGIIRvWloUIWedBDPP4Gblsm2dKveZnSimWraJa+lrmvZd8aWo/2ALL+oBy81JlledcZPGxiUyyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NlUW6tTLPhAOnyRpfcrQB5bnkLZ7JiL5nBm08xCZDM=;
 b=5eHDWY082S/MdDd08HLOcJ8qtII/fZBZnCtxxGfP+LtvjBHZBg95t4quEByf2cUfyDb10escLG6A8J0dnKeGKQ36a7xCYEGhCWBsxBALN/k9eTza1e0nk1rgn3dGU+e/GSZTxBcjZ4XFDnN+GRrae01cz2m0hnEjz/R7tla2liU=
Received: from BLAPR03CA0049.namprd03.prod.outlook.com (2603:10b6:208:32d::24)
 by LV2PR12MB5919.namprd12.prod.outlook.com (2603:10b6:408:173::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 11:03:33 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::e3) by BLAPR03CA0049.outlook.office365.com
 (2603:10b6:208:32d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Wed, 13 Mar 2024 11:03:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 11:03:33 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Mar
 2024 06:03:31 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <shuzhou.liu@amd.com>
Subject: [PATCH 7/9] drm/amd/pm: Add xgmi plpd to arcturus pm_policy
Date: Wed, 13 Mar 2024 16:32:54 +0530
Message-ID: <20240313110256.669474-8-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240313110256.669474-1-lijo.lazar@amd.com>
References: <20240313110256.669474-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|LV2PR12MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a1cf4db-2256-4d68-895c-08dc434d3952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7n1WPyM3S0Zfx0KTdKWsy5vPd3++s0YrkGSIlxbA74ipo1k4fj+/uNVGZDvm+t065VG6/xXdrktm9jCE7mvP2QTjydpXzdMGIR0oBXhX+bHwDYlAAVuF5mw/h4qQrRMfPQYkQWAywPVXSoo9WCEgv8pa8Vv4H/ZR8Zn9jh+oZJn09H3fHRNKXk36ljxNIqGGOjh9mzPqXnLWECTdk8Wo88hDakURNm9KvwRBQjoKb4DveC5FRoeH+jnUMi+BaRRRBxvVKPAa8UJXzQaWpxsbBtYyFglRqjblnLRrQrz9xUJTUHEjG6NgJ6FStijmH4UX2ayj21FqXEdJ24dBZhlFcF64i3Z+X3o86QjtY/o4dcEPTeWtVFMboiM4Dbopzeb3usgelep+o4Q9/xUCUMsOQscgDrLTAnwnNnnDzIHwVd+8pxlUSY2fLtlQHdZuUQAC1HnH21SNkDuRrcNd/Jr3mVe2ncVnKQKu8W6AG1+UCUVyUzjrEeD0wp9RLvHS5Z57RLiS9VMmciJ/v+YvjDxtTBCXqKOXliZ8wQ8zm2yXs2ymnyM2xOUp/Bw+PoJo+Et9OaTFJ1ORNbOAuf+/b0YHyd5WaqBSMkDOmbr5ah8vKiP35g45CWfQ60Jd4yQvOvwir3aajZ1iM23O7LYn74+MNvtXsNvBMWfW3aTrHCFSCHqBIEJgDQ2bDc7wG0ecWzgl1240txE6ljr3qA1o41uv6KUbxmBM/3Px8CINkiBdHeHpWDnT1vZaVSq6LUqBh5bL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 11:03:33.2552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1cf4db-2256-4d68-895c-08dc434d3952
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5919
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

On arcturus, allow changing xgmi plpd policy through pm_policy sysfs
interface.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  7 ++--
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 42 +++++++++++++++++++
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 42d43da7de4c..1c24f2cc5b29 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1192,19 +1192,20 @@ static void smu_init_xgmi_plpd_mode(struct smu_context *smu)
 {
 	struct smu_dpm_context *dpm_ctxt = &(smu->smu_dpm);
 	struct smu_dpm_policy_ctxt *policy_ctxt;
+	struct smu_dpm_policy *policy;
 
+	policy = smu_get_pm_policy(smu, PP_PM_POLICY_XGMI_PLPD);
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 2)) {
 		smu->plpd_mode = XGMI_PLPD_DEFAULT;
+		if (policy)
+			policy->current_level = XGMI_PLPD_DEFAULT;
 		return;
 	}
 
 	/* PMFW put PLPD into default policy after enabling the feature */
 	if (smu_feature_is_enabled(smu,
 				   SMU_FEATURE_XGMI_PER_LINK_PWR_DWN_BIT)) {
-		struct smu_dpm_policy *policy;
-
 		smu->plpd_mode = XGMI_PLPD_DEFAULT;
-		policy = smu_get_pm_policy(smu, PP_PM_POLICY_XGMI_PLPD);
 		if (policy)
 			policy->current_level = XGMI_PLPD_DEFAULT;
 	} else {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 1d96eb274d72..943c52d8d0b2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -283,9 +283,29 @@ static int arcturus_tables_init(struct smu_context *smu)
 	return 0;
 }
 
+static int arcturus_select_plpd_policy(struct smu_context *smu, int level)
+{
+	/* PPSMC_MSG_GmiPwrDnControl is supported by 54.23.0 and onwards */
+	if (smu->smc_fw_version < 0x00361700) {
+		dev_err(smu->adev->dev,
+			"XGMI power down control is only supported by PMFW 54.23.0 and onwards\n");
+		return -EINVAL;
+	}
+
+	if (level == XGMI_PLPD_DEFAULT)
+		return smu_cmn_send_smc_msg_with_param(
+			smu, SMU_MSG_GmiPwrDnControl, 1, NULL);
+	else if (level == XGMI_PLPD_DISALLOW)
+		return smu_cmn_send_smc_msg_with_param(
+			smu, SMU_MSG_GmiPwrDnControl, 0, NULL);
+	else
+		return -EINVAL;
+}
+
 static int arcturus_allocate_dpm_context(struct smu_context *smu)
 {
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+	struct smu_dpm_policy *policy;
 
 	smu_dpm->dpm_context = kzalloc(sizeof(struct smu_11_0_dpm_context),
 				       GFP_KERNEL);
@@ -293,6 +313,20 @@ static int arcturus_allocate_dpm_context(struct smu_context *smu)
 		return -ENOMEM;
 	smu_dpm->dpm_context_size = sizeof(struct smu_11_0_dpm_context);
 
+	smu_dpm->dpm_policies =
+		kzalloc(sizeof(struct smu_dpm_policy_ctxt), GFP_KERNEL);
+
+	if (!smu_dpm->dpm_policies)
+		return -ENOMEM;
+
+	policy = &(smu_dpm->dpm_policies->policies[0]);
+	policy->policy_type = PP_PM_POLICY_XGMI_PLPD;
+	policy->level_mask = BIT(XGMI_PLPD_DISALLOW) | BIT(XGMI_PLPD_DEFAULT);
+	policy->current_level = XGMI_PLPD_DEFAULT;
+	policy->set_policy = arcturus_select_plpd_policy;
+	smu_cmn_generic_plpd_policy_desc(policy);
+	smu_dpm->dpm_policies->policy_mask |= BIT(PP_PM_POLICY_XGMI_PLPD);
+
 	return 0;
 }
 
@@ -403,6 +437,14 @@ static int arcturus_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
+	/* XGMI PLPD is supported by 54.23.0 and onwards */
+	if (smu->smc_fw_version < 0x00361700) {
+		struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+
+		smu_dpm->dpm_policies->policy_mask &=
+			~BIT(PP_PM_POLICY_XGMI_PLPD);
+	}
+
 	return 0;
 }
 
-- 
2.25.1

