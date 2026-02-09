Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3ADEF070A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 04:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FEF010E292;
	Mon,  9 Feb 2026 04:57:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tbb3QYUA";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012067.outbound.protection.outlook.com
 [40.93.195.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4352C10E292
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 04:57:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHerl+CIG2v4AX53BX5rbbO54Nhw1PDATO6SqcrjchDSx2Jn83Xo19h2zJ9YVcMkqZMBpkuCCpFY5uNn+9Vnp1wbUgPmC9Qa7pXqBp0icGIlzURy9zMCuoVf0W7TzBNyE0k3bQO86A/jb75D/nc/v2m6wWRuufFxz1crnoIAarLjKFtKJps4fBq9kVI1olz5iB//VRlmkno/1/zoO0Yp9O7JGza6jPLX96rww9FqD6IozmvwR1t8agSzmiISFJ907IPcb6pfJyj2hwQxN/wSUuYSiZcuMJEOKj6UWQ55Aj29e560SnGYgUM8iUNpH8aCVxb57QR0cYYWuupPE79nBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdGBfM/XAbB6NC0deKXaytlgzTGiDyluB0cJyAfaXBk=;
 b=pIVBbrZdJ+uRsScIYhX+dhv2wkqyGUI0gHVr2O3k57ozwtCSd+tR6sNOF0OKoUP/x92n6tKsJtE0aGHN2pRBRKkO9Vvo/MrZRAEXnyUw1F88KcQXkbSBxHJppKFddM32wSpxBtO38C1rTcPk0OTeKL/VySMmMw2C13Omhjjv51zPpJ5V55i5s1LfMiqOxT9EdEP5212P5xSy9a+SrMV5Wyl3fLXHOzrtUOTBILcbrPjezDqi9MktGf7/e6Ne6BsxEMVzaHF1fX3SAqxJs1MveD7l2O4aGRfYAPhY6t7EnwKLovWgicLduZZlK7jmM13m3bSh4rpNQHCC+cqU1jqA0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdGBfM/XAbB6NC0deKXaytlgzTGiDyluB0cJyAfaXBk=;
 b=tbb3QYUAfttUroCk7aXFJpt5G50DNioGjI34lydyyFmQznEAFCQWFbk6X30EBbBzuzyVXDCHtsSJeMQtslA7//+wHV6VEJzuVU6VOWgiYt14AAkPN65XfAK8ORAVrw+dOnyWYqHR4BwuJ9IqBB6qt0x/are3ALjzToE7pFW1k40=
Received: from CH0PR04CA0040.namprd04.prod.outlook.com (2603:10b6:610:77::15)
 by CYXPR12MB9339.namprd12.prod.outlook.com (2603:10b6:930:d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 04:57:22 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::d2) by CH0PR04CA0040.outlook.office365.com
 (2603:10b6:610:77::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Mon,
 9 Feb 2026 04:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 04:57:22 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 8 Feb
 2026 22:57:20 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v6 08/11] drm/amd: Drop MALL
Date: Mon, 9 Feb 2026 04:56:46 +0000
Message-ID: <20260209045649.59979-8-Pratik.Vishwakarma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|CYXPR12MB9339:EE_
X-MS-Office365-Filtering-Correlation-Id: 967635a7-173f-4f42-9159-08de6797b62c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KdxjECqe+rOglHUWSTAFn0pwwpwQgHf1Qz2wsYnrRMeST3a/k1Fz8VbEejIo?=
 =?us-ascii?Q?T/eh6+hpnVzwvbj4SrZrv8oipIJE8J/bvVr7BSiajuYIbUTENQdWfu5Ch3xx?=
 =?us-ascii?Q?LGT7Gu0UFYE7js8ruLwRElSCG/62Q+kh+7Ojqvg4snJXG7G7seJTffOzdbDk?=
 =?us-ascii?Q?BJwdtvToVM6+NdpttbNcGF9H28zhhviuDqKNi59MkrlBowXXEyimhLZuvzmi?=
 =?us-ascii?Q?AcZ0l2HYFQBxt6aWKNK8UCg+xBpXvPj/iP0T3ynFVgztmgUwJ5xa6hrA5PpC?=
 =?us-ascii?Q?YT9o57CqLq6WlJrMAQsFQv8wbHS3vB3FEjSGorkOMZGwv4juMJVHeNZC/ma1?=
 =?us-ascii?Q?VoipMsEA39fx3eLg4/WUBXVezr22Sqkbor4HWjxLP7BYmA+RN9Z5Dc6GwrcC?=
 =?us-ascii?Q?dAXdfA5rGpBEFgUYy9fvcu4e1df6iNh9miq8VjVL68RcRcrTxwPPtywycVtz?=
 =?us-ascii?Q?h7VRIXJ1DmxOECkTPiRhSnItImhp6WMBNQIAdKb8+fvmWz/bCgyssuMQ3jB9?=
 =?us-ascii?Q?XfeemjRbhOpVyvJr9C1tayGvuxBaDzfn7ZFrXbPyu5+EvNALjrW2YYsXhfqI?=
 =?us-ascii?Q?O77WV/Q74yx4eTniv11lrYqXeSiA5A6plABWiJnVDgxuARSmHQjj+p3NYSKy?=
 =?us-ascii?Q?UzUcTb1qujrzZBIN/0T1k2cm9LL9hjNss9UOdhcbs5izkkRWzrJcmAORE/83?=
 =?us-ascii?Q?n4wkyUbXLeGtsKXD1MC0HIxtP8SdoQ0D4OCGy7IcBvyXq9fl0K6NMq6OmglW?=
 =?us-ascii?Q?f+exzp8Ir33EumwufsavMMX4PwJLA7fBv1fphEn65QSs1EOfiDnECHwvHNQd?=
 =?us-ascii?Q?MavcQwAWFLt4+2Lf8K1LHKVzYWeiaBKnFhENgJeZxufTcHjTaCpJqA2RUhUk?=
 =?us-ascii?Q?3yOhj60QMyvDRKuyjWSwao29e9ofK9jh9BZIXSUrFHIrrV9h7ziBip+eybxI?=
 =?us-ascii?Q?cTc8OpucRV+KE0tFfqNMrmPUHMhJAAjQ4POAvJLU1ZoTw3i/iDGLpZo1jDM8?=
 =?us-ascii?Q?E3rMo2/s82/r11ydg8C8c7n5UBCkwZi6S8MfTa9GZHc31voxM1AHu5fPEAKX?=
 =?us-ascii?Q?wQ9QMyjZz1R/YEEu8PHaw4C1rqG1mhqQIkswAum8JPUbiCVuyIhgLG2qLBRC?=
 =?us-ascii?Q?/HaZm5U8KwRvA9iyMNOCWlnlP+6lS+PcXydp2p/atvEyk6xdGawvxldCq4S/?=
 =?us-ascii?Q?sRp7K8u5D4zgJKcPYMp4uv+PQJuri0KvHmy9+ogFcgn+IwF2yQ0NpjuFO1yw?=
 =?us-ascii?Q?u6xsJW1V5OfCMd98biDqEA6HVQf4w9h2/Dh3wEtXE70UB65WVEO/3q81R6HS?=
 =?us-ascii?Q?xf9R9Mh3PoOXBieK0nC2z10KyOR3s361CucpoUDHdnxzMfXaahzusKPsL6lg?=
 =?us-ascii?Q?sVdiuwDhIiNvn1ByQJdE1K2lLm1XKAolZHNrY3L8SFRDKVVKerOKJ8kvTJHw?=
 =?us-ascii?Q?fk2yO+ds3Lee1w/JSR5UjofMCOYNnstHNpxbw5dpZuR25kGltSd5jITMPJL+?=
 =?us-ascii?Q?xw3SotywnQuOJRhQYuYeD57isQ3f5IJEJqI3gNIYeu6PpIDvrA2gCyB4pKul?=
 =?us-ascii?Q?2gtodfoo4wXKvbRMqks0RM2UJfFSFVkljsrVAQsM1cj71yq9WVHn9l1DCOXu?=
 =?us-ascii?Q?bGNFK9AEO+Z2seTamCyGP3zlr5UHE/p7pBoifOt0bBhOj0ClR+O90HSBWvhZ?=
 =?us-ascii?Q?qLYJ5A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nIuIryM+9wPmeJqXc+2Z8V+xPqMkz69GpAMc4jltLrr+3Y8odWi7XKYh27Lp7dhCEqV8uwosxhJj2dKmntd6TWfgPEnihcskXO1nzuUT/VUIPueQeLXWC51OC/T/q0Bqm7r2W1NNhUJKDx+vkTXQLc/cgJtk5E5LHQPn88y1r351gHr/4IB8VMuRU0uO3kMNnKMTO6is+sLEe+cgDg5R4mcsKy9Df72CQZ9fVG8wyYxuOWDczzUdPhiueHUE6sYdED0G95vPBXnmaUSrA+QQukk/LHY2l6Jgml2JTFz79K21OiHt49qWl3HK2NSpb/R9Q4hqTdtSubk9cqyqFekqsqBzsgh0bRdVnAB/zC15Zd9DgavEzJlYbrdHEu5DLEePA0n8pA5CX0SvE2MRYoLqLvACxvycz9884/q883Dm4bC0FbwbhjKxYqrrenstxJSx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 04:57:22.6759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 967635a7-173f-4f42-9159-08de6797b62c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9339
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

Not supported on SMU 15_0_0

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c    | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 5260de5344ae..72a78fc5c827 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -58,19 +58,6 @@
 #define mmMP1_SMN_C2PMSG_34                   0x0062
 #define mmMP1_SMN_C2PMSG_34_BASE_IDX                  1
 
-/* MALLPowerController message arguments (Defines for the Cache mode control) */
-#define SMU_MALL_PMFW_CONTROL 0
-#define SMU_MALL_DRIVER_CONTROL 1
-
-/*
- * MALLPowerState message arguments
- * (Defines for the Allocate/Release Cache mode if in driver mode)
- */
-#define SMU_MALL_EXIT_PG 0
-#define SMU_MALL_ENTER_PG 1
-
-#define SMU_MALL_PG_CONFIG_DEFAULT SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_ON
-
 #define SMU_15_0_UMD_PSTATE_GFXCLK 700
 #define SMU_15_0_UMD_PSTATE_SOCCLK 678
 #define SMU_15_0_UMD_PSTATE_FCLK 1800
-- 
2.43.0

