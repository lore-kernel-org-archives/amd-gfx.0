Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF1ACCFA03
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 09:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE5D10E17E;
	Mon,  3 Nov 2025 09:05:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ve3lhZ+2";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5AD510E17E
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 09:05:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogp24aQb9PIH8O6hNMayjKmPTJG13TciY53pK6MtSF3G1YgaE5V9kU5ynDnTXNtwbqR239OzCfKPWHUOzJyYjUN/Y+XqC5gOIjUcpWd1lMRo6p/OdSA8uwikR7KBTwBmu+PRnNE0BzkPu18128urKXmb2sUNgqEtSVqFO3m4RRnZcths9SH9StwZEUyIortZCYVAiIscSQqRMO9Uu8wF1gIYU4+ltHGEe/8n0It8jvcSLapsHrRKyiycX5cy3rTJ4+B1eHLDA8K06ZwWAt88ZgG3CSPVkU/hTd0EezB0wNwgsNVL88f8lXj2WSVSFOpSCF3xsrsSpL3zuXzpwbbSSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4mqkBf1gRiMKsZ60MRf52gzD4+hqpbttcJwAe178rY=;
 b=TFIcrm7CA0su821vwuh+oOAf/80PYdYQ6ynElir/B5dBz50AJj7C6AAzfbSVdDY0WPqdqwX7qwQ4Jd/TKyyJk9VbL5eNEC+LsPtF1J2nSVjTwIBZSnODAqMcxdfbU9XnorbXjNq443Tu7nOXfZmlchrIojS43NJEzhoUYv4LB70DuBFQueLLixriqPvJ8JKuOIGaSIB2EvGEp6rUroUl1Mr/G3RMEgO0cXiJ2kS7++Z9dPD8dw+MhdiyytlIQrPxmu39zdJ36P9sfOGy5g/GLHPqOh8jk+H7ux+uXX5m0CeVjmQCVNnMuqWTWBeMEJj384VkacqwE3nue2jODI09AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4mqkBf1gRiMKsZ60MRf52gzD4+hqpbttcJwAe178rY=;
 b=Ve3lhZ+2GZdnGlP1tfepSIcbNIA72nSXTMqyxF/UwbEcevmFrW/8OIvlDy5ScA3pX76TnVmstad93mJ9ct31wRoiloKSMPxaoJ2qVnXM/R1SSHsvjyNYyao4nGd/h4k63BlCskF2bJI8Se6/58TBTtcSeOqADKK3cujs/xKggOs=
Received: from SN7PR04CA0064.namprd04.prod.outlook.com (2603:10b6:806:121::9)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 09:05:54 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:806:121:cafe::a3) by SN7PR04CA0064.outlook.office365.com
 (2603:10b6:806:121::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 09:05:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 09:05:53 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 01:05:50 -0800
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 1/2] drm/amd/ras: Add ras support for nbio v7_9_1
Date: Mon, 3 Nov 2025 17:04:56 +0800
Message-ID: <20251103090457.3036885-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|CH2PR12MB4056:EE_
X-MS-Office365-Filtering-Correlation-Id: c2ead186-5237-48fa-8688-08de1ab830fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2oCSSKN6mITYmbcE2Bev1SeeiX9KxMnrgR6Z7VR6psbsGOIIUrKIdYR/UGQS?=
 =?us-ascii?Q?8PuGm3zw+1rDGVGC1iQX9whhonMst5AyRPiOLVhCDzBPV9Nb8Nfjc8BJjb+f?=
 =?us-ascii?Q?IwYZx86WqDCt3UTFOJh+pcAumUEgwxVHU/Uhv4NHBMUbIKD28S9Qhb4DvhXj?=
 =?us-ascii?Q?A8RNBzW0Wrmhen8/7HciATlzooTwakbWjdkopq6eykujaQ+9l7tE/4aeGwKV?=
 =?us-ascii?Q?+G5TqFCC6QIF9JCJq99Di/NrZcq6eBJiTJ+Wiwwz/oIt6CqgOPTYNoDOkDRf?=
 =?us-ascii?Q?ruQdP5xmZGkROL8bNyFy9egff3IoyZYnBS8BMrlaSedUPTkzx+02bDR0qPsR?=
 =?us-ascii?Q?p3DHCtln3KfFsQ97B6LCA0OXVaIF49iHOwX03bhFdcCTDihF2K+19s/m1+1U?=
 =?us-ascii?Q?wVUSddEiNwx/A/y2EtM105bAsBqI9bidUPP2MWByfyKZpp9iwMTj5YJYPtfH?=
 =?us-ascii?Q?jGtTooMkikVNNsWPNuXYpXu3NPBwStDI7SoeZJhMTc0SQLNppwep9HbaAfJA?=
 =?us-ascii?Q?NyGYtQap+NbgF3UhuHcIjjUlDi/gtaExDmIAK5uluSwEzSMxc+F67yjhcK6h?=
 =?us-ascii?Q?bU2TjPQz4Mtw+xDhW7kPJ+Ml5WsXSJhvzbB/gJ1uXyEO9cvx0MIdwXESDPU2?=
 =?us-ascii?Q?sP6lFPKYjE/m1ygfcwrkKEpJ6wxdZXawpDKyMtp+Kw2MhUbsetSFZNFDRpDG?=
 =?us-ascii?Q?h+iYZXy+1Pff87L+988qFHd2FgqZRtPJT92yO/J4EfHkyoTE7quhV3FagQ6C?=
 =?us-ascii?Q?tibcrp7cOwzxeffI2FkAzfn2mGoC4Q4/VE9WMXnsnR2hX/SiumnQT4hj02bG?=
 =?us-ascii?Q?CFpx18tFznvdaIq2LcY9NCN6JlujkcwOyoXTFiYowQtG6SFlTZ/HP95WmPy7?=
 =?us-ascii?Q?wSPAPv8Pt4XROQRIAeR5Bc97MjMCcuP0ZleX9OO9249HvhtnOMUCzUkRuimc?=
 =?us-ascii?Q?8MSpq3ISQ3AhZO5XRDIDDCYsGfUvDVD5XckfmIgM7scir+MLyTqxZ7gHGdBp?=
 =?us-ascii?Q?7b1D3Yu8suhJzTf2RcOp+oquvv95iCNONAQ+HfLHBldX25x1Ez0XDpznnkWg?=
 =?us-ascii?Q?S87YHHBa5JafaDg/7P9m5bKCUCUJGuXVm2d9SteROJhwBfKU+Bg2YdDXO8t8?=
 =?us-ascii?Q?AmXwHnPGzDL0gCm61k8esI0cNfOSlDTgu/ltVYLdIuBpavKbS7zTviG5ZzJ+?=
 =?us-ascii?Q?C9mfA9+L2yOnIqAh+5XmC71zazYMBwylXoAcAJ+3rBtoH7X27RaIsXWxC4rA?=
 =?us-ascii?Q?rZ48FjWPHv4Vt1jpf8deTp1weCFYgB2F4Ptmh3c+obLo54tA+IxrHUO3Xpv5?=
 =?us-ascii?Q?oLAt/E4u2T2SbUkcM6cCbvLLMNKTt6hzcXvTCm5BUniJJnzwcKZ9GWfv10Tr?=
 =?us-ascii?Q?a+ncMt0X26SSkBIa/ZXV+Zaw9/Kqxnf1KvzCrueCrFYh3BMeCurc7nIO5kBl?=
 =?us-ascii?Q?I3IlUXu7AAwotrqnBP3XGHf/JtK+7rtNp6z24Zp2T/qsL3vlBAcubpo30akd?=
 =?us-ascii?Q?+ySF1tqxha1ENUAPjhE+EkkYM+ANpVUFvLVR2G8w5BzGg/qIMBPNFQ727eHy?=
 =?us-ascii?Q?nxbm/mjAsatLodBeioU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 09:05:53.0698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ead186-5237-48fa-8688-08de1ab830fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
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

Add ras support for nbio v7_9_1.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 3 ++-
 drivers/gpu/drm/amd/ras/rascore/ras_nbio.c       | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index e1f6db13c55f..b06aab25d4cc 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -172,12 +172,13 @@ static int amdgpu_ras_mgr_init_nbio_config(struct amdgpu_device *adev,
 
 	switch (config->nbio_ip_version) {
 	case IP_VERSION(7, 9, 0):
+	case IP_VERSION(7, 9, 1):
 		nbio_cfg->nbio_sys_fn = &amdgpu_ras_nbio_sys_func_v7_9;
 		break;
 	default:
 		RAS_DEV_ERR(adev,
 			"The nbio(0x%x) ras config is not right!\n",
-			config->mp1_ip_version);
+			config->nbio_ip_version);
 		ret = -EINVAL;
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_nbio.c b/drivers/gpu/drm/amd/ras/rascore/ras_nbio.c
index 8bf1f35d595e..bfddd104d548 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_nbio.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_nbio.c
@@ -31,6 +31,7 @@ static const struct ras_nbio_ip_func *ras_nbio_get_ip_funcs(
 {
 	switch (ip_version) {
 	case IP_VERSION(7, 9, 0):
+	case IP_VERSION(7, 9, 1):
 		return &ras_nbio_v7_9;
 	default:
 		RAS_DEV_ERR(ras_core->dev,
-- 
2.34.1

