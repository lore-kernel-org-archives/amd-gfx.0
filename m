Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91A0C25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 09:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59EC810E577;
	Mon, 13 May 2024 09:21:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G8C7I3Y4";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0314710E577
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 09:21:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/uWBeEnDo+gvR3arkl07JT4nn/1keg5Bw3CM75RqcNJnFWma2+PgaQqq8aoTxAgvtjPzEELXM/iaAN76ZMaqvEGwu3PG8jNN5losi/5KEaIEVEbTddm+E1G1q2TJLKtg11qe8M65mPV9kxG/fBC280L+Ff84LbVs4gDRkZn5n+D6BZBxmj+xpUUURqx6k657mL1zmwwL67PjAtKZWRU4KOAPTycOAtxEjlxwJ+Oo+2HkzWJ1OE7MkT8ftrbGz3UT1yTou5TkpAO0uChpXrNQgrQBPaNxcaSLHdLXmNREqw/CL0VQVAkIjGD0j4BjS35Bv6GgMH19fSF9ElpReM47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqILLIcfsc9xuCf1NUqhMsQAmegzVeFUJ0dM92j0b3A=;
 b=FBQfsWqBN+D+OzqJ8IG71PT/nSIZUd0iMFF2qOxbLXqwrUJGz2aA79nw0CmPIvc1gO6bAR7kpITsrt29tOzbzJML3hQNz7Zzk9dRc6Hgk5Yyhu3SUn0ORvXmwntve1fymz0WbpNimcva6MMiOJ5ldn7F2xnhUK7aFJAl7hVzZzkclCpka4QN/IHGb+0pz87QGx0djNpioYcEu7MKXSYrtB4DoyhNWV8rN5a0qZTO2Ahe09YMhkjosjTCASU1xmm6JtVbLCrf/7SVQzCyOEqhkZNbrVwIdjKPQMypxWf4KdRHG6O9FSMMqVhrltlAXQkkoLVjcRb0yNHxmxxtFoseSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqILLIcfsc9xuCf1NUqhMsQAmegzVeFUJ0dM92j0b3A=;
 b=G8C7I3Y4W9ZfnxZssMocW+956+SxZEufoILeoVAa3dKBkimP3bUCX5lSc0jctyi7F+NcZqWJ83rCP5rQZ+5khrFqjpX3Y8+D3D87cJWswE85eF0Zt9QylAlw4T2a0zbpQ3iOImG5QmwCMx9JUssOpXco3WACKeDgj8neQ3RR6H0=
Received: from DM6PR06CA0022.namprd06.prod.outlook.com (2603:10b6:5:120::35)
 by DS7PR12MB5983.namprd12.prod.outlook.com (2603:10b6:8:7e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 09:21:42 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:120:cafe::ce) by DM6PR06CA0022.outlook.office365.com
 (2603:10b6:5:120::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 13 May 2024 09:21:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 09:21:42 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 04:21:39 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v3 07/10] drm/amd/pm: Add xgmi plpd to arcturus pm_policy
Date: Mon, 13 May 2024 14:51:08 +0530
Message-ID: <20240513092111.341168-8-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240513092111.341168-1-lijo.lazar@amd.com>
References: <20240513092111.341168-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|DS7PR12MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d038b99-11f6-4e4e-07e2-08dc732e1a01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P/wR1FIvriIHGC3037X0a8hlOmD3Rtj8ywxqyqBlDg0Vwbl20acz35BQqdb0?=
 =?us-ascii?Q?h/qO1EL1zkvmnKG4ugN+p79ERayKYr8j5kSGSR86Ns+/qPAbVqWzj5HPHNu/?=
 =?us-ascii?Q?q8DhCgKy/3Hq/dI01bO2I4tzwv0aQGOksh52oEN9pxodfHQgXfFNXWgXalGT?=
 =?us-ascii?Q?SPKdaqfzHIugbzT1JR3LewlMEvf88OuC9IBvBAF2m/7KA8iJ6pA6ck4h3MMm?=
 =?us-ascii?Q?H61I+2fxr5HB+8UIkUPW49FzCDe3SVgJwoWiQBCIResf5kmbeZjFf2tk4bln?=
 =?us-ascii?Q?+mP+S7UeScHRcj3FnqyOQqW7xh3BsIKU+AZ8aB55GSVDSn98LxK1sBhnyv1s?=
 =?us-ascii?Q?g36zGh+4Wt+dvxGOB/H7iueNMwr3rb++ItIc5/dhcNDs0CCGbenDAf/t1YmM?=
 =?us-ascii?Q?QhubRxwgTKwlsDqVfZi1s3wq6Tn+BQ5cKseEqVGtPlX5oqIZgztpWu26hflX?=
 =?us-ascii?Q?1txDM/9G48NNF4OGiRO2qjYWrXtIfY8LesBeAcSnYEkLMt+hnXlYXcU0xz9L?=
 =?us-ascii?Q?43n1f+F/E79/K85DHhfnJM8OmFmWVqnE1Q8qYNgXva5g5wdxIPdFqscpUWKD?=
 =?us-ascii?Q?5SGT6685SwBrP/duQVFdxT9NQlqLeJOzl0Nc64UT4Wwv/udhEChMlPXcGIyk?=
 =?us-ascii?Q?J+of+2OsI1DUogncOsJufSxX6+37VkNfus/BfX15nudSL0FhFUj5pUtK8Ghg?=
 =?us-ascii?Q?S7ZoI5NrH8l2cP2HDYtD0tHIn9ILzovcSTsVy66QuzmbQSPleHZKuIYgrR1s?=
 =?us-ascii?Q?vxWRjCEg748OHiW5AEbHycUZN4xFi6LgSodb/F3VgoyIQ1WOIs4QGFVOaTUP?=
 =?us-ascii?Q?tenNRmnyVQVYz6zv5gnzY66aQSfG1bnafzlLX+MsNSM7xsWW9XA14zQkgiCp?=
 =?us-ascii?Q?1oz9+LlprFznJzEO6u3OwMP8dhHq1BgnaNlC2dDY8AQtj8z2Hcd4mDwQrel5?=
 =?us-ascii?Q?H8390UArLXoc1LQT8S6Kfex1UiScU1dmM1tHARXzpXITuB7oqQEOCc2mFUpM?=
 =?us-ascii?Q?78JJI9kbdtYx+8XnJukFelL3tUf5gJY/T3AuwCR5qsqTfqL6to0AA/rK+q4O?=
 =?us-ascii?Q?bbBoLktlm++9VmYuCXEvCBg513+XPkysGY9ob8eHVGs0nSKOSoIkGKRtR6Pk?=
 =?us-ascii?Q?RSlvytThOf5pTH0gmq9Ozql2QSBhPzPBmP0LA3S5849LQYqUzNc+FQA8lLif?=
 =?us-ascii?Q?0FqcdLNcgQT7wRk/RpgFslhWhezxBTj0kO/waqV055BNzIXU4etFqsw3PMb1?=
 =?us-ascii?Q?HFURuRQ1gUCR5RfTr9fFROWd1k353lvlAiOu/KqF1mxeXAFH8XNqSnfva6Fm?=
 =?us-ascii?Q?witY9XZ0BK9QWptEkJq8UYQWGI1EUWZDW55cr9qd48bco7CFGy3vnwUoZHvj?=
 =?us-ascii?Q?PCYApx/8Cqsd2DGodZSYgM/SoYMV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 09:21:42.0951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d038b99-11f6-4e4e-07e2-08dc732e1a01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5983
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
index a8116ae4472a..a395967905d2 100644
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

