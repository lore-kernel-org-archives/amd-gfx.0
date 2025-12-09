Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A65BD3B7EA
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 09:06:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FD2610E4E5;
	Tue,  9 Dec 2025 09:06:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4/fI7KK3";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011030.outbound.protection.outlook.com [40.107.208.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 974C610E4E5
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 09:06:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lf9gFllBAHpjvrTJooJG1eayCnw1GMsSsaX6I8LLkepqqNaasWbxAp0rp8Q+MBPfHn2Vi4QI8AXrkyqLbNYCUw4yEqwnk0Ld8nLaQtxmDVWhAvwk+3Vp2o50DPrpLCV+mEfurCMg8gpopqkpPqnGGxWVVmUe4aga2p8ALgcqHixbrw5QUSHh1sW34p+NRHGSfliPk5mF3KaUaVrQfgwWdwQ3+DTjF0XdXypAHbpr/GOf9wOLleASRDkScGxuL6LreBqKlr9Bw6PcMbiVy7t6THzKqFYnIwAcQVf0EQQKMsRbiM/630hGJe0aI7Bh+3CZn8Li9keo7Z757RnE1UvSWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSwG0SJY6KHw6sTeJawRBdUIj5RGJjQAexAX7wqXOvs=;
 b=eEC/4KfR3S+tfzU2fp3l768AI0XCxSLVDhBxi2EdWWRQ5d5rDy+yc6AZ5MGaz/HXjqNhPyMgyG8SoSe+d2fVvjAIOL7ULPiURT8iZSva+QF4uxOI1a2OdbRwvBhxjCGecDvZ9BPAPjx6PReIwnzNzzdDrgMKMsmY8HUi2QHsb4jIycV7xyYdcrYJHOqUbIdrclcxTvvmSlswPv8mvFEXUhDGodRQgZ30kOQKeRm29ZNG5MRKkqBNmiwZcGvmq0YelbufDlOimmIo426wAJzySum8CqWuLLyzIGcW5qSv779wP+3ABvK3qMz3SfCFMnhFe3ok7NNoszj8Wn0+1n3YEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSwG0SJY6KHw6sTeJawRBdUIj5RGJjQAexAX7wqXOvs=;
 b=4/fI7KK3m+vzDhKEUoz5Lxt001CzMO/xj9Cffj2t2PxCzzwLrC/BgtF6MY/CiM8eKRkAdvmCYcXjA8czZLnUst146laA2W1OPWBPcDywtGX8LhLTrqhdfbI1oREYLgIBFxz5rH2QqZFfo06J5tggayohM1a60hA7n2D7VcJxdzU=
Received: from BL1PR13CA0392.namprd13.prod.outlook.com (2603:10b6:208:2c2::7)
 by IA4PR12MB9812.namprd12.prod.outlook.com (2603:10b6:208:55b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 09:06:29 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::6b) by BL1PR13CA0392.outlook.office365.com
 (2603:10b6:208:2c2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 09:06:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 09:06:29 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 03:06:28 -0600
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <emily.deng@amd.com>, chong li <chongli2@amd.com>
Subject: [PATCH] drm/amdgpu: fix issue when switch NPS1 to NPSX
Date: Tue, 9 Dec 2025 17:06:14 +0800
Message-ID: <20251209090614.1428589-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|IA4PR12MB9812:EE_
X-MS-Office365-Filtering-Correlation-Id: f7d52d1f-a265-41af-622d-08de37023d73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SrM14O2iCQTjnZLl8O82jblP1yryPoyns1BCaryQr2pAoYN8QwrmEF3ta4sU?=
 =?us-ascii?Q?+duF6q6ucvv1rAy/HBwCXecFzTLOvWmsdfBvDBPB2ZpOj1QwtzWkvCnzEfxU?=
 =?us-ascii?Q?8J7Z+oJNoYxJDYY6kqsSO2niJpGgRhfT7bpy2iXxgtbMRmXHjFCjnfJ+WUJ4?=
 =?us-ascii?Q?taFAbZ4ej5g1Tjqeadq9llGRCSlyllKrOpe39I19bD6HyTe6l2X01tFCZjHl?=
 =?us-ascii?Q?oRPSMzgy2+f9r1MiCXBxB02BhPP88fa8+Vvh/yzvXz4D6CZtnAkL/AVGU+8s?=
 =?us-ascii?Q?FJlUiMaJfWtVHdS/JREI+R419HJzXayWJvHpyd2xfB8jUShnROqnP4AWrLCS?=
 =?us-ascii?Q?LqY4PH3gxD33LdabpoaT2J1QA+CJejtC27VSkCHt4lstkhb/cINQwsTmw2Fr?=
 =?us-ascii?Q?Jft3j7T4bU81F8ba23crG9isl96LYJFcojCG23RrHx22msbqkrUJWBR0/vlz?=
 =?us-ascii?Q?nSwdRWdbj8EuwRQEul94KViox4Aia4nLkProFooKuEFXN+7yit5IhhKTnJxu?=
 =?us-ascii?Q?/54jWhwYWLkF7/d0BuRNVw6YI1aW8hUxKKFjzK2ULbs3tciQZBfOUww8qM1y?=
 =?us-ascii?Q?1xVNZNOZqcSCG0ndCPxfT90lxQDdr7Hms9nKq/iseMDnvCdHr5QeyWsElFCI?=
 =?us-ascii?Q?d8cKkVtQ4ZBAgXQdwP8mWhYq9N+XXiNOzHL6qEhmQKTfnq3jybD0jJ36T8s9?=
 =?us-ascii?Q?aftfXdRapsDeZYdMRWCgDI38doPxKCrwdhYZ40LdswBHmzcnVhbrRGgeoEHM?=
 =?us-ascii?Q?Nez/y5+VJYrdt8x5SVG20233JeC4E1BG9uWP3Es5gYnAt99SeiMgl9RjSE0z?=
 =?us-ascii?Q?EHYc/MNgNxSmcAXbcUtVPWmbCuqXQUX//h6+vAhsacryHd9BSVO+DvDWd/fz?=
 =?us-ascii?Q?Yl63a3fg6/l3c/x0mFPHkoj/tPJ9ww1t5F6Kjz/xl/Ss2UOQAMMr0/gP6lV3?=
 =?us-ascii?Q?FePcgvh+dWCs3jtyeQlaKTG9ciOfN2uiq7ewxvP7o6k9EjTTZJ8Awe4rnYwf?=
 =?us-ascii?Q?yNINF05dABB5bLIKYixWTOcGOrlgMZF8wEHD3qxNUL7ir7TwZXeNgapcTg5u?=
 =?us-ascii?Q?l14smeIjuzWGauFgHFs+wZnJb//YqLJfHJndsrrH5fBlpoJ5VR9XXE0zx+Dl?=
 =?us-ascii?Q?IlBuBxbEK3N5f7wpTgJlv9RLBxI7f8q21rpvzcu2eagvGTeAPPpHv6hS8cKf?=
 =?us-ascii?Q?nS4nycROJ9glSc72+dBq3hxI59I5djNIb0+VcruXlYtnsp6Nx5JfHfdFpdzf?=
 =?us-ascii?Q?0I14euOP8tRtZgINmM+OVf535pCbcA1OtJgNWkt0qCI9oCYpnnmlC9ixt/pm?=
 =?us-ascii?Q?zYFS3H0nun8mL17agqtCD8hBPLbIe6eFx3pA6+B1fdUZPUs7HC1cplFf0Epc?=
 =?us-ascii?Q?hU8jyq23wqZ16dbi2bbgHuUX47BCLvhC4+pXPRJE/AI+Q5s1QJFq/ZBgCFBr?=
 =?us-ascii?Q?6mzEq9pIX3fb47k8mtvN+Ywd2J4R0aJNzeGitCE0m5mxLTBKvpvr3r1tnzV/?=
 =?us-ascii?Q?sQf78d13kq0CcKmOZCPhvrNIiM2912E3YtkX/ltCy7hpGbLUBjinI9Osb4ki?=
 =?us-ascii?Q?CEaS3DrmrQneLJkYxrI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 09:06:29.3180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d52d1f-a265-41af-622d-08de37023d73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9812
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

fix the function execution sequence after removing
kgd2kfd_init_zone_device out of gpu full access region.

Signed-off-by: chong li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7a0213a07023..5939df918570 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4931,15 +4931,15 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		flush_delayed_work(&adev->delayed_init_work);
 	}
 
-	if (adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL_XGMI)
-		amdgpu_xgmi_reset_on_init(adev);
-
 	/* Don't init kfd if whole hive need to be reset during init */
 	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
 		kgd2kfd_init_zone_device(adev);
 		kfd_update_svm_support_properties(adev);
 	}
 
+	if (adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL_XGMI)
+		amdgpu_xgmi_reset_on_init(adev);
+
 	/*
 	 * Place those sysfs registering after `late_init`. As some of those
 	 * operations performed in `late_init` might affect the sysfs
-- 
2.48.1

