Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18637C25B75
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 11:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D67D10E902;
	Tue, 14 May 2024 11:06:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3sgf9M6K";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 711A010E8E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 11:06:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0/Eg+lX8TblCbyB3QZYNEM8d5VSOBTOl9DtqlAm2I21T9p3d4eBUYN50yqB7ANQ09VDBwNi0ULpOlVWz76Xw243L7M5VZG3pZbSqxwXa7quTROLpk0nQ+257ajXdUWyeTxtNgUjEarH2zp/M1gVKWzvz4Mze2IbzJ9aWy5wr1YpZ5G6ITZUhvo7kykD3mArHLCvGJ+5SK/p/jxD/8oehszir1akAZ+iOxyp5FDuE7Ur1opOEatdj7qayO7KZ2VN7+jY7WDs6GgEhc/5wEz/I0Rju7LHL3buT5aRw4T765tzU0o1Ds2+PFQGvT1GxKKiPJZ9y4tUAGZv+rSjcMTdww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bw/bFGqboGTGZ1ewrZzAEFI6dqkmqkEPp+83g972mJQ=;
 b=XMc8UN50Ko4L14R8phpkDBOoukUng5ROyPUXaE4HMAgmSMcJRDE0eZFAwZoP85BrYXzeooTacYd9KI+A6XXA5j0BtlaFC8LS8P3OmaQHHeA7igfET1Qr/yNCE+gMw+un5NQ7FLp3n2ogGtBUg7zppvqAcyYZ7GXmAyC+DgfhfjEij8AsKhcBRUxB/yUA9CIEMWy06MLpYVulGGC22edKLyjwBR1kzvaw0Eg9rIDWXiuWv+nBqxzkLv4Ap6AKHmDETJ4dAcvyRyA5VDyUSXOsd6dzBAdHfiHNM0FYfZfje6YiNbGCPQginxBKdAlPWQK34IkLVVty8BWZ6kp7Iho/8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bw/bFGqboGTGZ1ewrZzAEFI6dqkmqkEPp+83g972mJQ=;
 b=3sgf9M6KhWzVUPwqRlkx6PcQ52BX/3rQIVH0KaYJ1FOy8pw+xnOYlCpeiD1ZItSXzKdGxopwvkAw5YeQgrz14zOs3KTP05vwHtLkyRilaUkr/ySyc9OZ0dQNYXLKXFYoG36wygtFaeo/TBjZgv23Ayz0exv1eJ0+JMQSqFXEsvs=
Received: from CH0PR04CA0031.namprd04.prod.outlook.com (2603:10b6:610:77::6)
 by SJ0PR12MB5661.namprd12.prod.outlook.com (2603:10b6:a03:422::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Tue, 14 May
 2024 11:06:37 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::30) by CH0PR04CA0031.outlook.office365.com
 (2603:10b6:610:77::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26 via Frontend
 Transport; Tue, 14 May 2024 11:06:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 11:06:37 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 06:06:35 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v4 07/10] drm/amd/pm: Add xgmi plpd to arcturus pm_policy
Date: Tue, 14 May 2024 16:36:03 +0530
Message-ID: <20240514110606.396234-8-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|SJ0PR12MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: bb5340c3-bea4-4b6b-6109-08dc7405ec81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nFMsNDqm51s4Al7EJKCbOZgEOhf33oNdkDklARmTdVN5ey6751NCE4gVD8Vq?=
 =?us-ascii?Q?Z4jLhABQHbJpU7KN4VzR7mhaxhern7PYFIzZydkvQ/rfa/kdy5iL15dZ8h1e?=
 =?us-ascii?Q?0dgz08qex/+iJ1su9tueMdcW8WlWptrjsZCMIWWt11EKbTM8Rq5F8/oOALwq?=
 =?us-ascii?Q?ouKLqylHKak7gflMWJTq3JsZLeAOqEs2OT65b0mvYpFKssHp6mePPmdD6ev2?=
 =?us-ascii?Q?CoORnaOuulzzrYyVYXMSyzz7tomidsgAIVIwlfODjze2oUqjTN0PPUsaVu0W?=
 =?us-ascii?Q?SoprWkdkF+CeuPsatMsMU/MoFg6QILQZWapl5U6O2xDNnFNnW7fVlnm6p0/+?=
 =?us-ascii?Q?ojqePYgetmjG6MvxP+/RYZz1R9uEulIBgeDSPgZUos32Js6kNkyzMDgiUY4l?=
 =?us-ascii?Q?6hMk8yAxfIDQ2e3J2zVOwY4Mh8DRfl3lSjeKWyMpE3DX3E7Q0/9OHwFez9bN?=
 =?us-ascii?Q?blJGlpdEgiWQaMOCZlQ9QqfrKdfWSbQiLWvnpG8gQppomQeMabHgCpagC/Ao?=
 =?us-ascii?Q?3zKdT3JP1hreoYX+LMe1o2qIGq4hFXqMkYDaoLVNtu6hIra/2FMkhJoz4lfM?=
 =?us-ascii?Q?pk3aQ8AHBSviTnZR8/C5B6hABsBBNRBvVDhN/1NfFdQfwzWcYRlLa0jmrUbm?=
 =?us-ascii?Q?iL07fUt7yAvqtnZKq9pNWFvO+a64901qkYa83lQuU/W/gjGD1Otq9ZtVGKMy?=
 =?us-ascii?Q?ERj6ve8njb3th27Fcbka73hv7hes+GiW8Coje21mjvejwgtudBWFuPRjLjnv?=
 =?us-ascii?Q?O5vZkQSCjMm+8G3rLRos1mVz/izsBtYEvpJ38qF5GivxPXoWSltRIReieJuT?=
 =?us-ascii?Q?dBTyhztHmmFw7msW/IX0qwHmm8FTcTwsFwLt6LEuxzpySDrDm8nwGmANUDEo?=
 =?us-ascii?Q?UbR/qBVTwzWU47YiwsQB3lAuBquwfK7BzoAuUgPoErbjcmG52IgokgJygTIH?=
 =?us-ascii?Q?jbGl1nOQaocMtaLD75DexlIu+S/OblZecBdhQ4urpb1q8KnZSZr/k+MnrkQ4?=
 =?us-ascii?Q?/lq70yAIeW1cOPX6gvrC7Lgy+/JNcQ0bocnTdkW5XFIVXBuZiNT91qsV9uEC?=
 =?us-ascii?Q?g+BRDU+sRskj0rKLr2LHK1BoD+8jyJUdE3ultkt93UQ5v1NDpRXe3LtrkkQg?=
 =?us-ascii?Q?N8sALMdk5rDjTkNmE3DI7iQNDj4MCL6SHNEb1ZKkGvKG+HMnC1K3rXWpsLOm?=
 =?us-ascii?Q?I6mn6iK7c1o1YcAVdP0tD6BShFN/Os1FMd8cNAAvg99OcWPv66uQ+cTrffPX?=
 =?us-ascii?Q?+Zb1qZ6KBGDoovp83L9WR7tOc3rMwCOdikuviMcjgunc7aMl0E1UNELkT12S?=
 =?us-ascii?Q?0slX+iy2gba+8bpre+1IK0KPRwWwAdzQGFZqqZZNKHKb4ZcI6R+wT5TVa/Iw?=
 =?us-ascii?Q?usUPHHu5H8chFa7XUWoTUFZ0no1M?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 11:06:37.0703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5340c3-bea4-4b6b-6109-08dc7405ec81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5661
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
index 2a8d853e6346..48b867f4cf04 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1199,19 +1199,20 @@ static void smu_init_xgmi_plpd_mode(struct smu_context *smu)
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
index 623f6052f97e..84f7d4139bda 100644
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

