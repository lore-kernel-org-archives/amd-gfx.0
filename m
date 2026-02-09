Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE47EF070A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 04:57:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF06910E185;
	Mon,  9 Feb 2026 04:57:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gb6aPMUV";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010058.outbound.protection.outlook.com [52.101.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9695C10E185
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 04:57:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jw7DGUnUM+Y+jql986UDyTmybfSxFNd6Ak9PwPqHCNO2XTnC26Mv+o6I1mniBkT/G3EQY4DRiAcxZSD96ivhTHKS1S14JKKZ0lInnrIJvMSaj3JkRUCI6jIHD08lIQnVYu8pUsi/Xmi1Q1Bing54RA6p+7EZKrlUjRKe1Zq2xRgdUVDBJg4s3gaI7NaEu68GNaqEk5c1IwqXM96ltriImOFldru5z6l0vLC6GaZyICZMzPeGuHj2/UWGTc05oXZEwpxO5Qvpc7NMW7RvHPQcIsmS8baMR16Zv8nB84FuIaQc517ZTDFpmeLM26gPY84QvROlxRWnEDaWJKPe+DLnUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywNCvmPvFlJAhEs6D0pY+4wNZwfcvZAK+KlOlV/A5Q8=;
 b=XxHG+6iI0vO/eQSf3HqBt4YmxbdPGWAcl0F4bpwYGdH++RtblLSOm3+Q5FVkKpcV+J1fZsyGSdXFAmeFpcOWSFwjpBNdVn0CrAVxMnJCsldALqf9UOTYIi3REETrYD16e0ZiV96bS4jE4Hev4Z3RjCBCNJsVPhYvm7kEu+M32SldpOISeD0ub8nUsfy4WrlDVAJlgs+08oq0nN0XNnIwZ417GX/NHf4r6SqZtdQXwp6du9I8I5CerwBf4Hz0p53JoH0TR7ZpkY8kdqaY39hwNOPxeY/dJ0xon7mC1WfsxE8xVVg72PrnZoylhmxsEtMk4apgI5G+K7Pb/edELOV8QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywNCvmPvFlJAhEs6D0pY+4wNZwfcvZAK+KlOlV/A5Q8=;
 b=gb6aPMUVPHVVZht80bz9rUHkeH35MrpUqbmSmHvzRuP6INZm2z00/1WFYRQ83slZlFFd12aMOEzs/LHoaSCZs+/PR7rsWkhemSSLdfpCCsn8GhJaUEkMuTyV2igGF4dJVk0jnw5XBYvre7UoFqSX+TcE2JYZy4qmHd/D4vffbL0=
Received: from CH2PR05CA0072.namprd05.prod.outlook.com (2603:10b6:610:38::49)
 by DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 04:57:10 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:38:cafe::b1) by CH2PR05CA0072.outlook.office365.com
 (2603:10b6:610:38::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.5 via Frontend Transport; Mon, 9
 Feb 2026 04:57:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 04:57:09 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 8 Feb
 2026 22:57:07 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v6 02/11] drm/amd/swsmu: Add new param regs for SMU15
Date: Mon, 9 Feb 2026 04:56:40 +0000
Message-ID: <20260209045649.59979-2-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260209045649.59979-1-Pratik.Vishwakarma@amd.com>
References: <20260209045649.59979-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|DS0PR12MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: 50d16fee-ecce-4de1-8db0-08de6797ae7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m7p2WWgSjjW2Ndkp1hpXkkMgtQKjZhdgaegZ5Ry7SoauoYvy9uRBB602d1Lj?=
 =?us-ascii?Q?3QLMNjS/W9nJb7PaI/ujk4lE/4FcjeP38KMl79PvwmV55hOKfDywoe3RTrkw?=
 =?us-ascii?Q?BQ2zWF62EB7ikFpS8G2NnSJGWsFuOdSTZ+9wHgy9tqaCORWJrTGBHoPzEc0p?=
 =?us-ascii?Q?ImEMIV/XMGraG1bv6uWnXln7sUPSliyXhhXveyNqOrqf3FQWqXymRpmIbstP?=
 =?us-ascii?Q?T3xxHkeKOJ52o+eDRHPEqKajcohCQoEv+qaO2jTOz01Hz/tZ04zU6kC9Pntk?=
 =?us-ascii?Q?clYQDjf/+UB2gzbbjk3RkcdLG9TudiuibWNbYZ/SlGyCKXiNjJ6QYSBRJ66B?=
 =?us-ascii?Q?3tmI7cJXwZhYNBhD4owKn9wmdq+/HaEU6zScky1dH74EblMuoFzx5VlCskrC?=
 =?us-ascii?Q?DPiOTfENquHjZV02As4sZ7xpDo7jd5ke/DiAmNGIa4GaCURmrYpKZFZn84x4?=
 =?us-ascii?Q?TUyxZKA0N+fFTRAOr+na5ocgpbtok8Zr5sicMkAsZsq/s3uZEhhBaJiHihZZ?=
 =?us-ascii?Q?MsYLhN/r2CiHjUpXecIY6JVaRXEasGGsl2o0nfkZ08JnJVlVnHWoMTMPJQUz?=
 =?us-ascii?Q?kuT1rDGIljsHK4ybcXBSBHE1QUjTACjIBQysHmoTGiCPaxJjQGZzekAA3g+B?=
 =?us-ascii?Q?AJJSH6dBfTn2dtzOZF0EmH3nwjaXp15N1Bq40T+VncMORdTf76MmnwEDPUtR?=
 =?us-ascii?Q?Q4bHRylvVbz+jZo+O2QKs3j4PPwy5NiJ3MWZaQymb7U/GiHxG9qfvTvJjcmC?=
 =?us-ascii?Q?I2FloUUgYoGzA6XLxk6YSI2I+DF9AGxKpzzYr5Ly3mY2Dk2NYjs8FyqWXrc5?=
 =?us-ascii?Q?4ZADCqJJS8Ke2uJagtSNitSFmofD/OGCzqX/96GmdA69DRT+viqKxOQQFI4/?=
 =?us-ascii?Q?o9TF+70RdPAhwHWtQL25LJQvsiySPWOfR6ugNGYAB6fUsT7REmkcVfJCXsyV?=
 =?us-ascii?Q?vFYp4RoJLskVndJ7jnBN4jAsN2HHNfGvJU33eHB8j4sWNtjOFNxUbCB8KA/S?=
 =?us-ascii?Q?zaVgQ855+3RKbzcqu/NpHOY7gmupcHsdIDlW5JPqgDYH6TK9LGyahDhtElvk?=
 =?us-ascii?Q?NhySR4RA25AagUEk1ijPSEbUtsCajELmRCXmHeg3S8Ieefz8YIUZEF7MjyUo?=
 =?us-ascii?Q?CDoK1106TZ1phF/bdL3G2gTL9sALAmTdGIZtFGsbcjll4MjeibBB/QPAMRHN?=
 =?us-ascii?Q?eAXvd/imATlzkWpGHD54k3PHxL27jDQc4RTEANDnnYX2/HiHciP0cxsZBpNQ?=
 =?us-ascii?Q?+NgYl2GB3cMbD+YbbSXxeAS4+YuOsZXZIusPn/aiKZ+6lDYJZP05FDBq74Lr?=
 =?us-ascii?Q?DKvS6ERYbNRMSvz3jAN28Dp88Yu/erExbS7wSh45+PUmR4GZzZH0NnDLqiqK?=
 =?us-ascii?Q?fKb6jTVkDkf5E15sPoOrszejEKRbQ4gHybMPZCrqe2glb0bBXQbLFcZjTFtu?=
 =?us-ascii?Q?aZ3Oo2cD86yMTcD09mOGiC9GiP4SJCuS9Uszh/7opNxpn1xWlFeTHonTWC6S?=
 =?us-ascii?Q?jIWOTmd5b9v0zwNK6WdcOxcATkkxNmdxJ8ctmjJj5xOVmfppPsRg9k/46Fc3?=
 =?us-ascii?Q?65JLBZajxG0XoQgGPJgR2TTP2AV5DFt1z7uEsut1Hmm5lq/M9XS0o6mWgIP6?=
 =?us-ascii?Q?HO7Pzo3JmxxkZ2+iP7fJuzqJ4453/EhQvZDK1GeCahgCYw+67pPFn74XG8xp?=
 =?us-ascii?Q?CwEK1g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9MmTI6W0hrkRT2FBW/XfbN81CLHzpYttoZDRi/xSYolao3YPLtrXozsGhZF+v8T7tJNjKvSW6XRwuPaQmmcAhO6GPUWI2Wz7U5jxQJAjaAaF4uXQfjpkJp6qgmaOD7tWtNjsKj+Stdl0Snpz/jKpwS16rWYBnO0OuOfbTalfS10WFxmhgh+L46RmG3r3ozKztp/pRiurSGycD+VVBcA0sFbjQ4AZCHNcXc4csC8lrh8qYFuMC+ScmiZxuVi1ea6fu3Q/8HSLPgsrUrok/XrfDz/j1PZvmvLFyhKkO09Vjujm/ZTQhzZRIYHNt7D/x24t6Oah25f08WrayKYJ4+BiGLMXgCPvGm7dPGqeDCBg5KGZxu7Kzk4/hT+AsxYZvSFPNfcAkd/qwUtN/im8KJoj/A6oiPeL8SH2bkfT/zhJHK4EmEItQh+zWD1rNwIksYzO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 04:57:09.7684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d16fee-ecce-4de1-8db0-08de6797ae7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9273
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

Some SMU messages have changed to multi reg read/write
Initialize during smu_early_init

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index c3f22844ba2f..d58b0bc2bf78 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -52,6 +52,12 @@
 #define mmMP1_SMN_C2PMSG_32			0x0060
 #define mmMP1_SMN_C2PMSG_32_BASE_IDX		    1
 
+#define mmMP1_SMN_C2PMSG_33                   0x0061
+#define mmMP1_SMN_C2PMSG_33_BASE_IDX                  1
+
+#define mmMP1_SMN_C2PMSG_34                   0x0062
+#define mmMP1_SMN_C2PMSG_34_BASE_IDX                  1
+
 /* MALLPowerController message arguments (Defines for the Cache mode control) */
 #define SMU_MALL_PMFW_CONTROL 0
 #define SMU_MALL_DRIVER_CONTROL 1
@@ -1347,7 +1353,9 @@ static void smu_v15_0_0_init_msg_ctl(struct smu_context *smu)
 	ctl->config.msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_30);
 	ctl->config.resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_31);
 	ctl->config.arg_regs[0] = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_32);
-	ctl->config.num_arg_regs = 1;
+	ctl->config.arg_regs[1] = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_33);
+	ctl->config.arg_regs[2] = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_34);
+	ctl->config.num_arg_regs = 3;
 	ctl->ops = &smu_msg_v1_ops;
 	ctl->default_timeout = adev->usec_timeout * 20;
 	ctl->message_map = smu_v15_0_0_message_map;
-- 
2.43.0

