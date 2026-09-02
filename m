Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646F4C624D6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 12:50:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0A8410E4F5;
	Wed,  2 Sep 2026 12:50:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0BuGstUd";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011056.outbound.protection.outlook.com [52.101.62.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E2FD10E4E3
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 12:50:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5WR/X7TzlHk9YsM2HuDuqkX+mLX+vvcCmyZe0MbNOG7ZgfaYb80QRb8IoLvC+yXx3T7Kvsx70umpQaDqeFrYDH8uEc1MD2R6ilpSJbtE++/H1lZfhBIjFl6GKPGT/hPPTzwFJpQt+vGCZKvSHDVlQLDFhi4xdXE7SRCytJvnvYC3Qc5w7HvkEPnz93eZAeLigAIEYb2/izCuH/HcBBymeAn7wiz1h+HUPcZLy9bhPkLrdm6zU8nNRxQZk+Z/LIHJK1qankIZ/jUtJpG8YJomfWJwEg8dBi7PJIsuXOa5z7rZUSwX+uViE/kxcdBY1TznKEIzxtumDuGacgINU1oVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76rbklMU1UsY0+9yM7Fzni29Qp9A4EWIpyRasY8kppw=;
 b=Heqvqkh/AkT9LV7yVVwgjjGtFm+5EcamxXrGhRoIIlzuiaUV4Tom0NS6ch0EkfcSmMlYTireLYvM60YCN3cB48q7DXgNRWsTNRLj8r3Fn8rCTS88E52XdDB4xwlXCvvvEpRLu/b3MNm1DfIGiSXbCYjrIwY+N9+j5LRAfnimpmdwCCYY1RoHsnErD4U9paHd1dLd9/xFzbD4aR80O7sN4sU4RVmD3s/W/AbcV6O1yKJ939E98o3PJfP5Q19OZ0S/mct0A4HvMg9iQE021AO+7M7Hg8ZUuQA8piCaRyveR5YD8wWx1CYrIfzrN708voPVMo2UK7n/yWsE0AHxY5BT9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76rbklMU1UsY0+9yM7Fzni29Qp9A4EWIpyRasY8kppw=;
 b=0BuGstUd9EZF1tG4bLhkPaVmWWOu6wLCa2Xfx2TCM6NuwtQIxav1wfuvt+5kesVHY2Q6C8YP119zvIXmTptWc67l2EKFgmJ0OwG+EL6RTpyDTQcrC6ZUfi3FA3lUjiauiMy48hWRJi0n0bF4fpnCF0V+lJLLR93EgPP5vS99Izs=
Received: from SJ0PR03CA0137.namprd03.prod.outlook.com (2603:10b6:a03:33c::22)
 by SAWPR12MB999164.namprd12.prod.outlook.com (2603:10b6:806:4e1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 12:50:24 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:33c:cafe::9d) by SJ0PR03CA0137.outlook.office365.com
 (2603:10b6:a03:33c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Wed, 2
 Sep 2026 12:50:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 12:50:24 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 07:50:18 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 06/18] drm/amdgpu: skip DRM internal suspend/resume for
 reseting VKMS
Date: Wed, 2 Sep 2026 20:49:49 +0800
Message-ID: <20260902125001.621629-6-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902125001.621629-1-Prike.Liang@amd.com>
References: <20260902125001.621629-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|SAWPR12MB999164:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b441896-6b02-4d16-c5ca-08df08f0c1c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: +ahW55r2jGctx2yr5Za52NWOYNrrjTWEi6tWZFlfr69+/4qN50XFBh+dWIQYlWSM3J7h0+Lzdpg2sDfDuS6JT6A5do/ZgAqGV9PbnA8Gmwad5bY/Y2XAQrVMUYiI2gs9C0geaxiAkz+k4ZautNEXSmwEVrj8k2vIyS5hGt7imxwE+sr6xkiM7Mqw5fpochrL12UR/12SxlPmBGE2vpqhwRl6Ju5rIFtRrRpWh1q7f3AEglXmLd63WhmKx7gXdfz5VRuqeVtXJ8Uno71os0XQ7MRPkJe0X0Gr5fc4FuHmsfPTPH5WM/m5foaEutG9qQIbkUiv7ZMfpRU9H3VVvYkQt+cokxkBYn7hc+ZpRezt8F2DsyqFJLjMt0+ENSywSQBJjwrbd4wkMHhNzukX0i4UJKNjBqm9vExGKcEhnf1Lrqgw8usJ7RrWBiTUBSAuhBpcb1xb3Ec5Xs/9mJQA32htxEmgaGTC2yoDnsjlBp3v3WTI/W0a44glKtb72JKa8N6RLc8UqpXtcT7+9a3HO1zpQogJbKSjt/cKifOTqsTg/j8lhnMftd+zPR/vXIzwmgTM72ngLOIPRJ0LlIeRkPqJxzCgO0/K2jGNQ9yblpRoCfX3PMzYYN2V2Hp2dNUMZ8SxQANkOVQ29RC63pJUzwqwTxKJAC7+ZJnFctAL8S+J9UOvC7IZz4bHGLCeGiElBKeNBBFr0u8lDR18iUzl9Q702Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U/2erDmKh3tx1Bw4FD/1/64vx7wLFltjDRKobrEApfyJw25Jt1ZP0TF+jSWfDxNmM1+a1ur/EgjTqPTSYe0b2XP/Kre2IcLM9HiG3lc0vj4RALjm3ZtaaXWVtxmlgeDYWEd06jVUU64QNAgy1RBIeWmFgDsfBxd9+FdqcPm+kTBqJNTv9QEcEeC4Qv25HuoipJyMJvOg2Y0rXbI3qHpr1NqRe5uGKHD9lBobkWlxplcvyt88UqmNI8eO1+zSk5lH8jr205ZUtmhVTqQmkxMuKoHttbwE+Ssdt5CQOFzVhJEX6qi4sD5Pn+lFgaopHwskPeIAEntlHEVGxVlwzIjj2AOdpbk5D97gwn5dkkBGlVKg0r1OldHAfUbFFKNnVm5cMus/28E01qih060UeufOh0pKK5IxIOH6YRxp6CPAmlrW7+dLD9p7BeJkU1eR0vtn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:50:24.4429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b441896-6b02-4d16-c5ca-08df08f0c1c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999164
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

Skip duplicate VKMS mode-config suspend/resume while an internal
reset is in progress. This removes the remaining reset_domain->sem
-> clientlist_mutex edge without changing the lock order documented
by amdgpu_lockdep_init().

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index d6b51b3f216b..a49c7dda4c4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -491,6 +491,9 @@ static int amdgpu_vkms_suspend(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
+	if (amdgpu_in_reset(adev))
+		return 0;
+
 	r = drm_mode_config_helper_suspend(adev_to_drm(adev));
 	if (r)
 		return r;
@@ -505,6 +508,9 @@ static int amdgpu_vkms_resume(struct amdgpu_ip_block *ip_block)
 	r = amdgpu_vkms_hw_init(ip_block);
 	if (r)
 		return r;
+	if (amdgpu_in_reset(ip_block->adev))
+		return 0;
+
 	return drm_mode_config_helper_resume(adev_to_drm(ip_block->adev));
 }
 
-- 
2.34.1

