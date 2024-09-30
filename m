Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E934CF6497
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 06:42:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A60F10E0C2;
	Mon, 30 Sep 2024 06:42:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HAFHlPeD";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9B8210E0C2
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 06:42:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRnLxOcoKiaVQx5kSzU9DZqTpoq8QNC7jnpeCbbYF7W4QxkVer+f4sHR33r/2EBfy1ySFaJAIz8I5dPmkufeCtnY67NcL+JbFl/ffvLhMaq/IeTb4b+Bj/H6yS5M8/gswqeBPKkc+4AeviYbhlrbvKkcNA490nEgt8uZvv9dWGFcaO/NvR5IZFECTB5MIbtARH2Xe5kwAuPRNEefMZT//c0nY4WXFOUOXBBW/3rl4Z4CHEsUtSbicnGGNgcGfZrkN0auqho+WjHXJ0CG8Rgj00UbMN+rng/McJcOzXCSEsmOfLQo+J61BGLj84STKMZ95r0z/6sEOOfaA23falMRtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tH67b4YMQvZE8tdmavpB7azEOkSttNa5CCAahYC9y8Y=;
 b=hCoP8K0ilGhSufwcjDDsZEung+Jc8rmXN+z3GQqSlAOaIY/fL9yd+F0S7M0cn0RpmOEQlKgxAZ94ud58gfsyvvJgs6B18FFrKzsBvAZvHq30YSfyQgCtd8fysq3pJc8X+6wudumY/m6kSSTj2Jos5ad8SNVyuVh556gyXT4a2LkJ/s0O1jgDJNpiqGjfVC4w6yMwL/PkcXHainizyCkyttg3xH1X80Cy+ky2HquJyL28tA6Cp/SeoK/RNv72S0twnj5uWfaaMCocgyJFH9cpJMRX9akwqVr+CNK7sV1egh4X9X2gLQGGE/BIvF2ZZLXQ7/behOgoYLjshBsQkK1kRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tH67b4YMQvZE8tdmavpB7azEOkSttNa5CCAahYC9y8Y=;
 b=HAFHlPeDnZZIHeFsOlPfV8z8rYGPGpd9nUMqxx03nrcB5IdJVOJwdTYFAoFRJLFlzTsi841Z8LdPuVdan0OZhGHSnMDnVE8dqa67mobcbT0HV3uMEisgYnDlUwLDmF23TiXldt80BHtXiHEJd6Bra0o4rYAym7X45p1U8KCSd/g=
Received: from SJ0PR05CA0134.namprd05.prod.outlook.com (2603:10b6:a03:33d::19)
 by BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 06:42:21 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::5d) by SJ0PR05CA0134.outlook.office365.com
 (2603:10b6:a03:33d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.13 via Frontend
 Transport; Mon, 30 Sep 2024 06:42:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 06:42:21 +0000
Received: from lang-maple.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 01:38:58 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <Felix.Kuehling@amd.com>, Lang Yu <lang.yu@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>
Subject: [PATCH v2] drm/amdkfd: Fix an eviction fence leak
Date: Mon, 30 Sep 2024 02:38:12 -0400
Message-ID: <20240930063812.22742-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|BY5PR12MB4211:EE_
X-MS-Office365-Filtering-Correlation-Id: d50fab01-8480-4fe5-4d6b-08dce11b091f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V6vit/YpCINiFH1xgCNdoiGRaMTfKPA5VU3orSqFYUgrCzLJYPP8SfonAMPq?=
 =?us-ascii?Q?iUK+2oKsNv1XuzoLy+xR8WOzzg02Ko/tb15bdipwAsJC9GNY70HY26MdnC/U?=
 =?us-ascii?Q?zM/fwXCJowmnLnfz76sbeoG5qdJZG7c/32tjb6fPyBh+cLXxf/tcyG2ZpHsF?=
 =?us-ascii?Q?vCOpQUyuOu+GGpqb5Vhjs5BPtgL6PGBjwfimc5IfP4eOkVBmbNJBwYVh1AE2?=
 =?us-ascii?Q?WvHye9nwfDeH7ghZaD3ew/86bfTTZ6O5Oj2fK8ZOQuhI2KAoKykZuIEw1qbK?=
 =?us-ascii?Q?XGinn75QqyhV1oHm3hy4GLzBx1hZKd6jBJvQ7w22M/EXuYhz6W5dfNlEu6wL?=
 =?us-ascii?Q?POkEXSiu4bFy8627M9ij9aBOO7UeUmcV4KZNLuqaZA/3jaYs/P2ewMVRChFo?=
 =?us-ascii?Q?KZalTaTsB5E13oHuYdT14Jwrz8AMtD5pBS+IyLNDN6cTECgu8XGEXX2QHgFU?=
 =?us-ascii?Q?lHlRw6wtL34Xk6/ZSdJD1vQLzC6WebRVXr2Q1sILo7eep6RvLTUzVarFNe8O?=
 =?us-ascii?Q?njYlp8fPzpbp+kVesBrP1v4UIuFPeLQj4bSLe+5DL+KgRv66aAYR9jh/4S5P?=
 =?us-ascii?Q?sPmPO+UyOS2NhGyjHb0AL25ufPhz19XoV6vGuOUqlCHHvGdst/C55IAux7V3?=
 =?us-ascii?Q?TyHEbGyIisL5ZvD/OTcvO9qiiT199foTd+2c2RYHodOt5vHSboAKfePk3VEh?=
 =?us-ascii?Q?DHGRvyZnVXGvxSnMoVivap3JTOFAUSO+Ro3NBxn4/Is7pdt9+XTmHWoe5n9U?=
 =?us-ascii?Q?ScUHg2sG3jucCmhF9H32G4FwJNSxOV/zNC+HQOzaUmsiYlyIDbs5l6G6K6g1?=
 =?us-ascii?Q?ONL6wpLgB9IaQPavYLuGRryUvru0EsBG9fHDL1Yx0QRGvEDqS7VeNjX6oj0l?=
 =?us-ascii?Q?dhFO7YUPSrJ+dWbY716ba9bBBfgAjO1+/+vGv17moO3aDJOdI7Wet/zm6IGK?=
 =?us-ascii?Q?R9t5oiW/oMANslCyvO4XLkLZfYkxfDtkBa/4eyQ3U5ALShdFuJW//FguVaqd?=
 =?us-ascii?Q?WpmsQHLjWbGyFNiuqsTtzULzIxbHdxtCB7geZ0R1aWiGAUPXVmMl3HGcmZ4J?=
 =?us-ascii?Q?F47S1EGocCvfoT39nBpLQDBfXaJEUh4vICdR084XCKt84I/pGh+ixctbdo3o?=
 =?us-ascii?Q?wcIS3c0eKUoIPc8GatZ4Tj/UwY878dN+uVJkn6e8f2ueAsDHOoj6z8BeKFXX?=
 =?us-ascii?Q?lJFlg349uKtOVLz7GJO4psJJnZWbcFPGbyN9lEiPtnsu5Y6zYGoPtQo6fwdM?=
 =?us-ascii?Q?ugmgDV0KH9yy6z+3Hut8tWilSSqylaYkVA+awUjHlB6orcd3sZkhsy5HLFvm?=
 =?us-ascii?Q?bWIXmdBVCtApAxotxBD87vaBJyXYzu95KYfChIw64vRmIGlATw6043SiUz+/?=
 =?us-ascii?Q?XVQk4+Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 06:42:21.1774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d50fab01-8480-4fe5-4d6b-08dce11b091f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211
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

Only creating a new reference for each process instead of each VM.

Fixes: 9a1c1339abf9 ("drm/amdkfd: Run restore_workers on freezable WQs")

Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_process.c         | 7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index ce5ca304dba9..fa572ba7f9fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1439,8 +1439,8 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 	list_add_tail(&vm->vm_list_node,
 			&(vm->process_info->vm_list_head));
 	vm->process_info->n_vms++;
-
-	*ef = dma_fence_get(&vm->process_info->eviction_fence->base);
+	if (ef)
+		*ef = dma_fence_get(&vm->process_info->eviction_fence->base);
 	mutex_unlock(&vm->process_info->lock);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d07acf1b2f93..d665ecdcd12f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1702,12 +1702,15 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 
 	ret = amdgpu_amdkfd_gpuvm_acquire_process_vm(dev->adev, avm,
 						     &p->kgd_process_info,
-						     &ef);
+						     p->ef ? NULL : &ef);
 	if (ret) {
 		dev_err(dev->adev->dev, "Failed to create process VM object\n");
 		return ret;
 	}
-	RCU_INIT_POINTER(p->ef, ef);
+
+	if (!p->ef)
+		RCU_INIT_POINTER(p->ef, ef);
+
 	pdd->drm_priv = drm_file->private_data;
 
 	ret = kfd_process_device_reserve_ib_mem(pdd);
-- 
2.25.1

