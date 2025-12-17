Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A37D65C51
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 13:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AE8B10ECCE;
	Wed, 17 Dec 2025 13:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lKGEQYTX";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4798310ECCE
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 13:55:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSS7+miZLTfrUSNmzuXOC2Y8NSO0/jVXXGa4m/ZrR9dujT0mH6TUDF5nIvfajp/KcG1FV6NlVkMwwcK6+/de/0zG4WzmxZNHTZqvNB000knCiLtR8INe5gjNWyje5y717yodbK+3lceSDteMpq+34BqAUajxHkDOA8NWMw+oAC4AAog1J6rxsyctRjZnCeeEDcdl3gxlvMjUvkJGNah5vH+C2pt9gyTCiJefWZssuLUtcd/jdzz/tTPB9jbPUbiDxbaVVEnqJCe56BGh7zwOtJBPgWq2WoWw3P6KfLy9XIZu0ATk1iUVXXQO9PAJfagLuW78heGyb2zaOu/+13uAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaU2GRE9sHOl7n+PYF3vsQJ8SuOSoGvIjrvK7AbS1rg=;
 b=WXultS6gBPqkHGwLLYxLqrEteUkLHQKxijxOVNcvnCw+se8FdvGyRT5ZQPz0msFOlsUyvMFT3HkMRPCwVpmvPeQTjsmACt2CuEDKz0hR66KsU9/TFByVENjVeIZiHMtXfZl6PCnkjQ8szAk9ja5os8Uh2NCZ50ph7SiUoLPmXntHdh/MeshdOoXVFeyIhWLpGZjVhUtYEnxlY9+K4Yarp87h4Kr7U82KZzA0Z6rdjmdm8G3UFKfmL2Pd+EltVZkSqNOhBFn7NMlrYtVGbnOnwF/3bsOD65EFaHUawdNm2bzFJaXZgBcSUVxqshDuWVVJrGj7eFxvS4Lx5pi/uKljvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaU2GRE9sHOl7n+PYF3vsQJ8SuOSoGvIjrvK7AbS1rg=;
 b=lKGEQYTXms+KQ7bjs3kSeQNRkR8JCauyhfX3djAXYhUIIFIxwCj5S6LEXhH5PyHWoe94T58Icg0niV56ZBQfi3FKA/nFLoh6H0OIn6yVRoVB956TkRgI8w9TBoQtEtv85SOqDZg0VbVpGyATP/y6ndvh/vyKYMOTG22qxwecTVs=
Received: from CH5P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::22)
 by MN0PR12MB6318.namprd12.prod.outlook.com (2603:10b6:208:3c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 13:54:58 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::64) by CH5P222CA0002.outlook.office365.com
 (2603:10b6:610:1ee::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 13:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 17 Dec 2025 13:54:57 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 07:54:56 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 03/21] drm/amd/pm: Add message control for SMUv12
Date: Wed, 17 Dec 2025 19:17:56 +0530
Message-ID: <20251217135431.2943441-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251217135431.2943441-1-lijo.lazar@amd.com>
References: <20251217135431.2943441-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|MN0PR12MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 26811554-4a74-4d8b-94a4-08de3d73dd88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u9t+Sjkxd9FxTtSlqXkSxi6ZG4lG3Yhqb9g6n56NYnoT+tnuptLN1ZyIkyUz?=
 =?us-ascii?Q?Sx8EyKkq0X+yR/iWLxmshyFonrCkHbc2c1Mfv0A/nJ1owDpE0k1ASs3HydMv?=
 =?us-ascii?Q?xXwqjklldGIjZ0V4gTMaoNWG5MKSQz64dQD44T2yuhW3NOYGOkBijLyEuATx?=
 =?us-ascii?Q?SAC2HCvrKjN4ccai4PU5cPuQ/1DaYhUq1982U9ike3fsGFbkH4pf2ZronBjz?=
 =?us-ascii?Q?FfNzWqDy2sQmVAAnRV9Jj+PsOlrj0+SKP+Ywfi+OzhAzuZnpwJCj6TkdBMCp?=
 =?us-ascii?Q?xUwbw7AnVMDZcn8XYwDta3a4exodOn+Qweavihj3qWcA2lcXf5NpwTwWDX40?=
 =?us-ascii?Q?UmBc0BaVSFXNeSzKkjjK3y5DXi0Y+8x9rLrg2uTM8sC1jtCz8Nc7CyEgDT58?=
 =?us-ascii?Q?kFWP2RJMBOEznDtcSNU0mbyJFKorky6/Se69iGK0qV0YeV9ba5PfVK14EbK2?=
 =?us-ascii?Q?U31GlIJzR+qKYFIY5tqEJ2lvHJ1o9j6CUji6vbPeVoOQ/Bzd5LJFVNN5zgOK?=
 =?us-ascii?Q?BuP3oEi7B1iSpTJp6R4tVFi0For49vfu9GNZ5ZBr0fVHq1iJqYLOoCqRffr0?=
 =?us-ascii?Q?9Y298tjtetx1wqRPbZj+JWzGH1o/b8YfINeAu+5icS7aB4VfsaifqfYEKa9j?=
 =?us-ascii?Q?VT4UA+yLGZpMZ6qlq8AthStS/u4r8pT0WTDWl2P/WalP5umS4Dio/SWM3qE/?=
 =?us-ascii?Q?osrKtK3uKBJhnTRqczKlTB62jO9LwdiFScwpGYNZs8UIS0+tcy3VvygjHvuh?=
 =?us-ascii?Q?i9xF1GB9XoSnuiM+4kKjzJMvtoEF7opCWdJkgqtVRRlGIMswqWcVLxPeFQpX?=
 =?us-ascii?Q?A43pHcsFUUjg/R6Dm453hRqSV+kQ44oH55Jzwpv8KrokLu4BVcQKsXNEfcnA?=
 =?us-ascii?Q?fmOnTBYY3TEzwgjAt28/WuMTX6NulQZHuY+vn1vXbMD76BO4BQIhWklSMjCH?=
 =?us-ascii?Q?NGbAN50yxnEOiAs9BqHpubY9D+RRNq2NICE4FNAEaazXwx1ebg6iGw/bZkI5?=
 =?us-ascii?Q?3TR9DZm7X2YOPFAGrXFSa2G+1VXYNLWG4WEGE2MJxoPdobnubor9pMsvvxH1?=
 =?us-ascii?Q?hdmjHbQQtPf6xCdWh95e/JztA4lgE3Q+K+wqtn22J9JPcg606ovwBogRz/qh?=
 =?us-ascii?Q?AQmOuYwQOV8Nre4YMcvMNFpkjmalsu2A2gWgUeSvRe8582qyXTbqPU2BByR9?=
 =?us-ascii?Q?+dXbdibSCyW2JnM4AbgIaGIHTndlotUL9KNUm82u40m3yTbqm7BfMMMS7haP?=
 =?us-ascii?Q?TdwJIawo5tVelfkKOfRwst70nUr2Eut9+nAcLygQtATaXu+tsRltSaar6+l+?=
 =?us-ascii?Q?JapG+a5/ho2oWGtHrgP/7FdoYWfyVNr1hkS6RB1kNDTsmZO6C6kLIjBkJMB3?=
 =?us-ascii?Q?sINsQoByJpXDQCy3JMaLBxZqzlx3jFr1hWo+eqVIRBeR9sFOr5yaJmaCOwb1?=
 =?us-ascii?Q?NKTKBRMjNwPvULPQCdq2wS1kMDhnRWdz2sBjyIX7gs8mvH/ZBHI82fVnS/NU?=
 =?us-ascii?Q?3vDC4/oV8VIKufBjtVgraiPU4jZlnAerPKc8DwqJKLx9s7kIJHZUymiFRQji?=
 =?us-ascii?Q?Xt1vcpjFj4ltV2RnwiQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:54:57.9915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26811554-4a74-4d8b-94a4-08de3d73dd88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6318
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

Initialize smu message control in SMUv12 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h    |  3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c  | 17 +++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
index 0886d8cffbd0..fd3937b08662 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
@@ -62,5 +62,8 @@ int smu_v12_0_set_driver_table_location(struct smu_context *smu);
 
 int smu_v12_0_get_vbios_bootup_values(struct smu_context *smu);
 
+void smu_v12_0_init_msg_ctl(struct smu_context *smu,
+			    const struct cmn2asic_msg_mapping *message_map);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index c72ddef3fce5..7e41991f140e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1507,4 +1507,5 @@ void renoir_set_ppt_funcs(struct smu_context *smu)
 	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
 	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
 	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
+	smu_v12_0_init_msg_ctl(smu, renoir_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
index 942bc3b0f700..2c20624caca4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -405,3 +405,20 @@ int smu_v12_0_get_vbios_bootup_values(struct smu_context *smu)
 
 	return 0;
 }
+
+void smu_v12_0_init_msg_ctl(struct smu_context *smu,
+			    const struct cmn2asic_msg_mapping *message_map)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+
+	ctl->smu = smu;
+	mutex_init(&ctl->lock);
+	ctl->config.msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
+	ctl->config.resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
+	ctl->config.arg_regs[0] = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
+	ctl->config.num_arg_regs = 1;
+	ctl->ops = &smu_msg_v1_ops;
+	ctl->default_timeout = adev->usec_timeout * 20;
+	ctl->message_map = message_map;
+}
-- 
2.49.0

