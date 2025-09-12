Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5167CAC582
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 08:07:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 481C710E183;
	Fri, 12 Sep 2025 08:07:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c1bndqxZ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B13810E183
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 08:07:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIslSACbPMtIUKFS6IcPsKZ6R6Jh3zNxv94xkmRAqFxyt+zLwsiFhyfSpZ2+qJ2a7IEk0A2F+tQwSYYhA8wHHgOCPPinV/6fZgYIIAtNLHmG01LtSM3Nj52FDJ/zCiBD6P2lvETgzMBTg2tEZY0A3frpIOmG1RbzSmrkkqc9Bf01p1RbisR2ENGI63AZeDh2D8/U8y//E8fCwKNiyhWZJhqK9C+bSrTeDe+MkLadwxLx5smi8Fu5qet4h2gC5w6LwI6Fkc6fllPwc9wlZWTW9Pi5UEl4anBubt59AbFpiqzhWz4bjd7/VsUoE9e9d1rm27hvfUUMk9t4qZF3FC7ByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UterCJFcWjqjan+JEV2yy0E/+HcJ87+5mOkUJqjnGWM=;
 b=NoJ6TLinKneETgSuJ2HkG9BEh5g+eRUwJtrhhjouLVqfYRn3fZLccuBWXE9y0zciibMjICi14vIel5z5Sedumhx4v9EEBfd7OJQQJL6Melzqebqt0ZFkCnwWNjli18JAubuh9AQk64h+PRL7JK9JkdBzL63rZgSPIhRuQP33S4J1w9rmTXPcLa8xYlPJv008yM8XOLqbsSogVk8H6a8JgKtkhCkrEAePKztDxDOz6bk3yj7qndm9wLn77K6H/Cw73AN4BS4sN/ypep5ZpcAc0ElotOBz/pnxbE/ISnXoO4P9QP5SIrddVs94apEwqYbS4VG5TanGfTtDGPtdhK8CIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UterCJFcWjqjan+JEV2yy0E/+HcJ87+5mOkUJqjnGWM=;
 b=c1bndqxZs6agjodTfZ89/Dov0L9oO1smVrbol/5j370MaRHNZ0ihCVLUCKpwvt7P20KFmMVTnhrKFpuH3xaF6qi5NPmSBMmRCgGS0j8Fr2ReuPJb1u+plCxKZc+k508NFFaaJX5ENDrcQp7uL5x4VGD09p7/pvSghUUP+0aJZT8=
Received: from MW4PR04CA0251.namprd04.prod.outlook.com (2603:10b6:303:88::16)
 by PH7PR12MB7870.namprd12.prod.outlook.com (2603:10b6:510:27b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 08:07:45 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:88:cafe::9f) by MW4PR04CA0251.outlook.office365.com
 (2603:10b6:303:88::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Fri,
 12 Sep 2025 08:07:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Fri, 12 Sep 2025 08:07:45 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 01:07:44 -0700
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: move smu ppt->post_init() into smu_hw_init() stage
Date: Fri, 12 Sep 2025 16:07:34 +0800
Message-ID: <20250912080734.3121325-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|PH7PR12MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df40502-60ac-4a9c-256f-08ddf1d374d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R9rTArsCccCl+rvNgZR4SMKH9VGGC7P4epKDDzfU1616UsVugPwHSVfWbYH5?=
 =?us-ascii?Q?rPUP2K3zM6iTTFpIdP2SaGu8+EA4YqxRkM/+GFh2YK1NUgzEUwwPR/YWzISn?=
 =?us-ascii?Q?Yx1x9hPStEvOfPkYSoHL+i9jlOiC+hIp7TEqrUDPFD5cUqsWHqpRF90kZebI?=
 =?us-ascii?Q?3Q/TtjfMO5jYQImqFMUrsqnoxUa0z886bSCez6+6hA9VzzfjvTLeLlT1lrF1?=
 =?us-ascii?Q?csuDPFDa8cZLFtLtWnfO9tek6QSq8kjh065YSXI1L4ESn86DqZnrPXLKImvn?=
 =?us-ascii?Q?YfKnyXbedCj8z0yPyo5s61bTlEvxMyW1fAM4gHs66J2aFtooQ0xHwSjCChXy?=
 =?us-ascii?Q?i/ska5fJIl6E/ZD2iBavrSn6baZUj5HQJJNjlX9mpHKyxTxFxuKqe9NIyRRO?=
 =?us-ascii?Q?JdJh/WdPMHXzlfg2QRE860sUtrjoXxarL54FtnazSsLISGxJk2t11JBfGxb5?=
 =?us-ascii?Q?wayp/GUPnjuEMmLxwwy8tRgfillLeH9keJdR2SIKUEgyL5IWyFpoEe4udULq?=
 =?us-ascii?Q?/v1kEA/CpaySix/+P/73PhbPwahgKwwCuZhb0aZu5wMh+z5feeE0BzlSJIgG?=
 =?us-ascii?Q?jZVqGF/WKdoDsEumLrqOi8HGTOQf4txocRmwywAw5AQNhgFyP/tPXbLOebe2?=
 =?us-ascii?Q?GQF7wcWjD7Poc2Oup77ZGTSDRLkO03Fs5kOE89U99RnplpX5lR9gcUaq2Wa0?=
 =?us-ascii?Q?Sp9UhyytuKbea1CgZKBZ7kbAYaR7okr3BXiX34CgOTHu5dNEjmvRgC7Q6kP2?=
 =?us-ascii?Q?0bjJIFZA+9tTghdNS8M9g5cVT50Is6m1/TVMdopHtiMqWnr7VXSXDkY0lZMq?=
 =?us-ascii?Q?k0Uwp2C8h2pwNEEU8goUV+Oy/fRoGEbZNP7Lbv3n6ddESoUqnToTaMnDBnM6?=
 =?us-ascii?Q?KbRBv571UoW4/SDG1KUWMkRUEA/qs/OMOjV1KrnIySniZy4ExD7xc4VrjuPf?=
 =?us-ascii?Q?CqLc1AFW1/4aYo49dhsT0u5vf1C5ljWv3O9aFlxQylE5SILBkps8SVMhZ24d?=
 =?us-ascii?Q?qR+CylrgSnRXRIHG3yXAh9JNRE39ZT/wkvGsvqPbX+hrCYueFSJgE+k4d5w9?=
 =?us-ascii?Q?SMY6s/vo4Pu4LdAwebCBFrpH05UPV/0bbsKgCpKhH3rR8CuR1Owq/K5bnENP?=
 =?us-ascii?Q?dR/w8CJl1EhNxjVy5ifKGk1kCdqH8qnNhAOHY1e2cl+Usjs4vvNoJb0ubf5Y?=
 =?us-ascii?Q?62sqDViuM9yP2qjwcNjrcrfX8dwqH3V2t7BPI0sik1oo9ekUB6lnziN3QRJ4?=
 =?us-ascii?Q?Ao91g0cEajE/HqyIrH7fjgWXOnpmoselnPpem5MnDhVcB7vaHtxz2QMh2KD8?=
 =?us-ascii?Q?IxXVBEDDnYjLN/nR6zw+bo2kM0Z3lA9e0sMjw94MJVewaXcO3o1b1Ht+9+SY?=
 =?us-ascii?Q?H8n/IxUKZksx0DJ83iA7x0WRxkezQzDTKgzIy1kx19T/hdYjWoQ+MDTHwkxJ?=
 =?us-ascii?Q?RolwS61tV/Gc0dKxYyKhX9EnuMP512c3x33IXyFvFlvAB6vD8xzTLnGuGaEH?=
 =?us-ascii?Q?baL+PqNQC3e3vSeuTP4AWTDR5whNGxwRZ+79?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 08:07:45.5794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df40502-60ac-4a9c-256f-08ddf1d374d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7870
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

it is more reasonable to move smu post_init() from late_init() to hw_init() stage,
beacuse the smu specific hw init should be done before call other ip block
late_init funcs.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b140f6fc50f6..f113b1b1b925 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -891,12 +891,6 @@ static int smu_late_init(struct amdgpu_ip_block *ip_block)
 	if (!smu->pm_enabled)
 		return 0;
 
-	ret = smu_post_init(smu);
-	if (ret) {
-		dev_err(adev->dev, "Failed to post smu init!\n");
-		return ret;
-	}
-
 	/*
 	 * Explicitly notify PMFW the power mode the system in. Since
 	 * the PMFW may boot the ASIC with a different mode.
@@ -1957,6 +1951,12 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_block)
 		return ret;
 	}
 
+	ret = smu_post_init(smu);
+	if (ret) {
+		dev_err(adev->dev, "Failed to post smu init!\n");
+		return ret;
+	}
+
 	adev->pm.dpm_enabled = true;
 
 	dev_info(adev->dev, "SMU is initialized successfully!\n");
-- 
2.34.1

