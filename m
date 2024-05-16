Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86922C25B77
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 12:43:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26C4210ECD7;
	Thu, 16 May 2024 12:43:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YyQb3U5F";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2A7B10ECE5
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 12:43:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqJihR3CsEClG317x1rzYHe+QYkwzL3wYKCoe0RGbF0e9drQxfbfdc2qmWY01/EB+j8Cn8Ec5SKVCUAiLYcKH5WEhoi9xse2NSx3UxWZgDcvIDc5eD1I0SCt9KWk0nrqR/aYH7YT0E8/f2VRAljaHF3vmWhvL/I9cpA0RwyqwAgiCUcf1Rxx39KjwHfepYN4vBK8WmF8t5wKPQlDSR8GhqUgghU2/M85J9ArXBs0QBj5YwsIADxbgwN+JaKsKSyDSuNrcjm/f2P9bI/ssRZvV7e3uQs95+rn4z+6X36xzEPOvC9Ux8nxEFHIBr7m8sy7XVGEdd/tpCIEW6hvhLljLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmbeJRDsYaJy5C572SDweTaEeAAB8m/VihoidZ8T6ic=;
 b=NIP8Av/9JmH/QjbT1CGiCzfPrC3+daotDlXmS/4Lz0LRCGS/cne8K/dZewU7VrdVg4l5VhcO6ENsUftXI3lgbM4Fx083NsDyEGIu+0mTBjW5TUw+3ArTAXHQ7jCZS5rZePFctajAGUInYs1JKxaBbnbV0Gno3FirLvrvdMZPjrMd2AMeHqwWRORzjPblgS/AHYZ0EFj8D7Zx3af93ef2VBZJ79mfEBPSPoInYruRX8VIuxgzBLJPBiW/87t8hlBhL2lmyfjZ3gtAHOHvDQqLw9CcH2HSh1WP50pa8TOdeDZTCboKwGQzf3MgIgzW5OwFapkY+5bTXR9RWNHCYbtkqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmbeJRDsYaJy5C572SDweTaEeAAB8m/VihoidZ8T6ic=;
 b=YyQb3U5Ft2PFXy2bI4L6Y9YoGkEtS0I8opnbOoSmvDVAmoArO46K37r7z9DfiMo2j+kRH6CZZBDYYJhfoPM+A9pW/P4aA0ADyPoFkB9aXleYACAxF71IZtMV9jAN71WG3C0fdDoBUEGuLCoVcfc8mGJjb4nzJCli+ba47sZ4EfA=
Received: from CH0PR03CA0236.namprd03.prod.outlook.com (2603:10b6:610:e7::31)
 by IA0PR12MB8205.namprd12.prod.outlook.com (2603:10b6:208:400::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 12:43:51 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::ee) by CH0PR03CA0236.outlook.office365.com
 (2603:10b6:610:e7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Thu, 16 May 2024 12:43:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 12:43:51 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 07:43:48 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>, Asad Kamal <asad.kamal@amd.com>
Subject: [PATCH v5 06/10] drm/amd/pm: Add xgmi plpd to aldebaran pm_policy
Date: Thu, 16 May 2024 18:13:14 +0530
Message-ID: <20240516124318.508785-7-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|IA0PR12MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: a7236d5b-5805-4356-3164-08dc75a5d6f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?svXlgrS0q3yNnXSXjJXzVLQZHCGZDiPCz943ymd1C/QeGPfCwPT2DLS5BGs6?=
 =?us-ascii?Q?/6QN5L7BPYcD7dGamHeYH/Us3aZCtEUu2b3gH5ml74Sszc10CC86JiNoJACR?=
 =?us-ascii?Q?/GPU09nITl5zx/7YzMC7IHPzKfnbRuQ4ZUwfMs2bBRyHRYEqBIeBQJkBGK+m?=
 =?us-ascii?Q?kqu3lWqtYODYRESrqotGQToHMM8BuPz5zEYKt1uquJuxLIKu0tZcliZZU2vc?=
 =?us-ascii?Q?lb4sVQeydqV8eqXUJsidOyS3F+O+1u08llg6x4DrMBfdHhPrgUpOicZmUbJa?=
 =?us-ascii?Q?6Q+u9a8jF1vFy580j0LGKohcjfQOinn2xI/hXdqQ6X26MrSjjpjlugzk6JXc?=
 =?us-ascii?Q?3+dKk7cdVJbhNLmNrUaeR5X1j92C+YGp+UAQJoxe3ktW/SfbsEJGetQedtt1?=
 =?us-ascii?Q?KVtCwsQXkiCPcsLIsZYx7nC6jKg9DidRSs75X0VCD2OuocqYCo0hxSROxtyk?=
 =?us-ascii?Q?x98yuAfl5hMwSKhyY75fsy1xME3nLDO/sOmt5XKpu84QfrLcbxuWbIn9/E9q?=
 =?us-ascii?Q?BOK9vAwXSw/QT5ra8/bsPrAseTOHl0O6ox/tc8UQJotLtCQOnXfl+M1kKiB1?=
 =?us-ascii?Q?Jcz7ovBAWWGsyBezxHRggcWREvdBrcLNgwq8peM2uaTFXwiOo272JHzVDy8p?=
 =?us-ascii?Q?U+4RRYRFIA8fXpLBYJImOSC1kxsMU+ssRdzmEYyAagNPBNtvwJswwRB+6BbH?=
 =?us-ascii?Q?Cgb/TxsmIcLqN353jJvJPrCaWTv9rsv6H+jALj3cJfOuOvjWtOA7YR4ksH7B?=
 =?us-ascii?Q?153JU1ATB+fhDUTsNtQEcauS99xX3Rw87uQ9z4wkNQIJZTmz6ETWmUPGP2W4?=
 =?us-ascii?Q?2UmdIeI3e+cs8WnXUrBJ5PbmF5p2rrMoZGZAp+4vAiHVJoRKkRwu9K4+Tpkr?=
 =?us-ascii?Q?ffpv/O09BHFeRAlPAOcPQjULxHriHjsonS/oEIO8O7d1af8YUe+o6NNwfjnN?=
 =?us-ascii?Q?72+GKCUAr/BHUpRn/Z3Fte0CD/CVCfL3pIxl0lg8dGJYMyCmyoi0NBS7p6Q2?=
 =?us-ascii?Q?V6pWoGGJwqDtvdRNkrVvofjdKOwZpJ6m/QIfKAXdrNRlI15NyCKw+WsjRDp5?=
 =?us-ascii?Q?FkxzgPoviK31YXDL6mvjsmPZJIHq3l1n5pcOnuDnamGZ3APAIayIBq4kD1AT?=
 =?us-ascii?Q?L0UAfyBeeWZYs3L8uGFYaq58JzDfUCA4A/Zs7ixMESy+UppeWx8cY+6iDc04?=
 =?us-ascii?Q?aNP1jH3rMpl0QjrRacv9tIFMsMY7B/sJWgPi/kI4+xdFkOPB/R1d9PG5Yz5A?=
 =?us-ascii?Q?B4GoXC4yQdAxvNGCs5+YZiq8sVFiI6GVy8xzRsNfI9iPCjeRexxOpnTDy/aO?=
 =?us-ascii?Q?8pFNYDrt0LCguVay62DLceE/GWQDYUsGzIoog8PwfYvGc9t/z8bGyulU9ohD?=
 =?us-ascii?Q?GOwuxTsSe4RZPhYWfgrZbQvvhlBE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 12:43:51.5367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7236d5b-5805-4356-3164-08dc75a5d6f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8205
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

On aldebaran, allow changing xgmi plpd policy through
'pm_policy/xgmi_plpd' sysfs interface.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index a22eb6bbb05e..66478cfb8b77 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -266,9 +266,31 @@ static int aldebaran_tables_init(struct smu_context *smu)
 	return 0;
 }
 
+static int aldebaran_select_plpd_policy(struct smu_context *smu, int level)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	/* The message only works on master die and NACK will be sent
+	 * back for other dies, only send it on master die.
+	 */
+	if (adev->smuio.funcs->get_socket_id(adev) ||
+	    adev->smuio.funcs->get_die_id(adev))
+		return 0;
+
+	if (level == XGMI_PLPD_DEFAULT)
+		return smu_cmn_send_smc_msg_with_param(
+			smu, SMU_MSG_GmiPwrDnControl, 0, NULL);
+	else if (level == XGMI_PLPD_DISALLOW)
+		return smu_cmn_send_smc_msg_with_param(
+			smu, SMU_MSG_GmiPwrDnControl, 1, NULL);
+	else
+		return -EINVAL;
+}
+
 static int aldebaran_allocate_dpm_context(struct smu_context *smu)
 {
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+	struct smu_dpm_policy *policy;
 
 	smu_dpm->dpm_context = kzalloc(sizeof(struct smu_13_0_dpm_context),
 				       GFP_KERNEL);
@@ -276,6 +298,20 @@ static int aldebaran_allocate_dpm_context(struct smu_context *smu)
 		return -ENOMEM;
 	smu_dpm->dpm_context_size = sizeof(struct smu_13_0_dpm_context);
 
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
+	policy->set_policy = aldebaran_select_plpd_policy;
+	smu_cmn_generic_plpd_policy_desc(policy);
+	smu_dpm->dpm_policies->policy_mask |= BIT(PP_PM_POLICY_XGMI_PLPD);
+
 	return 0;
 }
 
-- 
2.25.1

