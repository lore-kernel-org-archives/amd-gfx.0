Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFB9C04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 11:06:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B106C10E876;
	Tue, 14 May 2024 11:06:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zGukYkIF";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E91410E876
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 11:06:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8BejqRRvVwUW9KnoLnjddhQwxxQN9vYwX+gO9fvurBhrerRdzBiN+h4zpIusBH70PXb3fz7XjZ69o2YlPwhwj8IxGL13WIKg4GGuMDe0LDlTXkI+SHip8Os9zEDMguCIR/jEA0pKPIu+44hKydODbykVCZSSbubBGeNbj9P5ZOO1dVSN+3P/so1yOAvRYfEqmYgmogG1G6ALMMKGpKLoO/bmEYU5cq91H5bO8gA1OeE7j+jGfsuJgKKnReCbbnLmXybo7F6CSX9j8ZCsK6SzY1MwfrMbmIaqdQjjrbrdV9AQ2T93g8tJX51EPguZje5NKZnjp9VftMggeZuptQLDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9J4rsiFix35O3lpXedjTawyXBk4x8oqgefSLWD/WE94=;
 b=hwK/i4GZYGBZBoFeZidOlwMvfTCIz01cSP0sD0/amjXpunUDwYbIuiI3QIf6eqbhgMG1jx9cmxjRi/xanOdFJ1L40cXnuycAOpuHVLXlLiKOpWCn6N/kBdcSvWQ2ymHNS9bW3B73sdGssDO11G8k37eg3uLcE7f5wew3SiGhnq4F+nNEDHbrLW64Apfi5sNkywpteYV/HG3gJJbvdYpNXNdAq4BYge0vsRCBi4hcuCYdaa4HOqVp5/ca5KjhSFdFMA+b4tmszL/2mlusEubXflwn1VrE8yrgaSTbVRQZHFlQNRC9OZbv5oOKlDKsAqqpKoR3/r+H3DO6HLmA+INjlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9J4rsiFix35O3lpXedjTawyXBk4x8oqgefSLWD/WE94=;
 b=zGukYkIFhYxib4mVmt9cky26+HskpQyEjd872czqKC/l2igV9D9JMuX1fqs1II9/EwBRSncbLYOBNpoyGCqm3ZhfWKH1sC8M/RFbkpAsi0hEMXdsljR5ygmC7habb04nX9PzM9YEGXeHJJX9AOgFt7xBnJHKRKaqjXRiy2NMq9w=
Received: from CH0PR04CA0037.namprd04.prod.outlook.com (2603:10b6:610:77::12)
 by DS0PR12MB7897.namprd12.prod.outlook.com (2603:10b6:8:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 11:06:36 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::c) by CH0PR04CA0037.outlook.office365.com
 (2603:10b6:610:77::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Tue, 14 May 2024 11:06:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 11:06:36 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 06:06:33 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v4 06/10] drm/amd/pm: Add xgmi plpd to aldebaran pm_policy
Date: Tue, 14 May 2024 16:36:02 +0530
Message-ID: <20240514110606.396234-7-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|DS0PR12MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cab3e71-cd1f-442e-76a4-08dc7405ec56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DxV9eWiQIR+pQlYV7yUcDdKWI6GsaOkq+F3qH/jst3FeoODp52Saa9dAvNWa?=
 =?us-ascii?Q?keAKsnyFsqqjVQkv8QwL5E8NjHiBcbapNgFhvLWvUEhLbGqlOgOGSOk0MEmu?=
 =?us-ascii?Q?jdtTRn5stRNvY9kGGFlgDhP4zrViuareOkl5/fkz9fE9//LEJ0xyzFiHwYlG?=
 =?us-ascii?Q?WqCHXGE4z42Jm4g5jezYFwF2ygByB1aW12Tu7ezC2+wJzyLZ18BFxsZ/si08?=
 =?us-ascii?Q?0CADlzTCbIV5O29EnV4hr6jhphlIqcODCHozaL/FBVBE08CBlD+bexvjscUZ?=
 =?us-ascii?Q?VoVbfTL5HcLej/tmIxnszcGsSJN5BVEzRuxfO0oPqhBN24rpzsaVN3NuEeM1?=
 =?us-ascii?Q?e7mKK8pGcEg1ZuGshnUeqgtpajg52JQw4+BXgtYrybQDHqyifM9CbLuKr1OE?=
 =?us-ascii?Q?7hDZLxkDpP/wvqaTBeLXWTu7qOWBtAv3mDC5gSmeV6+NH7VtUdtuYhv1Wp+i?=
 =?us-ascii?Q?V3TPVqVPjRXuyLce9PgtZJX4c7TY2SXwUI3229yC1+anarEfCaoPt+27snob?=
 =?us-ascii?Q?3O4BFlibP8cSHOyrRXHULSXu7nDt7yo7nceDoNi7Eeg6PwqDYpesE/W0rCQl?=
 =?us-ascii?Q?qqY6Hd5H53s/NH6P4xW/5RNHVlc7zpGXIPugFjV+tSV25M4NTM8N21n1Aupy?=
 =?us-ascii?Q?Es+vgh8EzYP3xKqaDymkDf14iMEbSir5lo+6QKadR34cBu/Qt31s5eK0hBX1?=
 =?us-ascii?Q?KJ+3MPoBzpMdqY+mnKKXgXxRiqm44aliQPVNqptdZWUaUxZdJwoqKJanlgya?=
 =?us-ascii?Q?TJZr1fnGbzdFY0GfP2N8geWF4UR3UZyr4gkkwPBtHjwZ4pZ0j3Ps2RSP6Uz9?=
 =?us-ascii?Q?N/nydv9u0vOU7a6XTKg9QlMjoHXCqH4ABfGvV2rBMCqPEPsm+2TxkOtRtK0J?=
 =?us-ascii?Q?DVgW4VcXf+U8Ad/NeFLZmJwyZdNiPwXppUvcRLGLtisF3K0N/Ev3Z+2YisQA?=
 =?us-ascii?Q?MyMmqvN19f1QxAK7EnZxg2asVHZXOWXkiYjI2kjXXDj8CZZkEcn607lclDh1?=
 =?us-ascii?Q?OqbaOagrvT1FcyXikWejz04lEdphpXbUfeUP+1j/MsrZ0z+3wOuex4vFqtkj?=
 =?us-ascii?Q?R4GDuPrjjL5D9wsGDg7vXmFYgFEm3Bi+HZZ696pXUpBdz0eYZRwDTb3yG/ag?=
 =?us-ascii?Q?uWaqzX23fo+LM2T2DCqTMBCmC5fGMKwWhIw5llh2Pd/SLCxPIm8+sOcQWdor?=
 =?us-ascii?Q?q/sn4d1zWyvG7CI8ubZzr09nbyiDWseh91ikYUhLR6aSD+u/sYhEJpAfC+6E?=
 =?us-ascii?Q?NlMd7rWqwX1TlfLHis59DDb3JzpcFSt8YUafpj+MCvkeQPJuKNS//lFcCctj?=
 =?us-ascii?Q?nr67Enz+MSSTinrz4HmDgLAOZH0ynAy5R9n6i16Q+2jF3r/xiC1m8HWbFtX6?=
 =?us-ascii?Q?Z8LBUani0BkY8qQY2dXXHAspnUqy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 11:06:36.7890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cab3e71-cd1f-442e-76a4-08dc7405ec56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7897
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

On aldebaran, allow changing xgmi plpd policy through pm_policy sysfs
interface.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index a22eb6bbb05e..66d386ef1da9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -266,9 +266,30 @@ static int aldebaran_tables_init(struct smu_context *smu)
 	return 0;
 }
 
+static int aldebaran_select_plpd_policy(struct smu_context *smu, int level)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	/* The message only works on master die and NACK will be sent
+	   back for other dies, only send it on master die */
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
@@ -276,6 +297,20 @@ static int aldebaran_allocate_dpm_context(struct smu_context *smu)
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

