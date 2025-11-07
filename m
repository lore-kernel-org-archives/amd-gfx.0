Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831BBCCFA05
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 10:22:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CD3B10EA74;
	Fri,  7 Nov 2025 10:22:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ldYytdHc";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010001.outbound.protection.outlook.com [52.101.56.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F89210EA6B
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 10:22:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKhqgocv+V+Kz54TktYVS3TDOu6kzEwE66Jv+UECrzez7FPv0I0dV1FGSrWQik1im7WK+rjobHa36jF9MkCYdpdWUhd4/npVyszHMHnjmlv53p+HJkSU2wt9Wm9Uhc3t5Bw5pJzCwLZxN9vVBD6RmaBBGDby+bJ4LeW26WIGNSqFCltkb+aAeR5hswCA5KbmM/5bcUsPCneys/Ajjh8zhDo1/x3pgtEckZxqZKqSLmmKy2xbH/PJR9ZpK2k3QZ7G/hqNiwixa7XlNL+eZzj4EJNN7g1aL8hE1wCRWxNKjS8bYIyAO/hP0kOetKxHxM09NoVMhIuD/TMcMSMioPhDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEYNoA4lzc9g+7hL7YvMzXGUyNcZvAdtALRVFvAMw7c=;
 b=xXv021BG3ppuNexaMSDIJQP/FEv3xtC6yGNinRabxylPnATtu26+qc1oCjVMtOfrEAWBhrHlwBq3J0Cvl0wUH2SMZKK6AqrzN6rDmplKvRwbriMbLsoMDMyRHaXSjkb/fdp8oOQQUqOVmymvpnAb3r/Zz7z0SaWaYM6XR+/qn8WxOhZLVg7nENCQQFYjtOj0NoHRFAq2FNmCwDMrI2KWQ3f0UtXZXbKBoVJpLqbZwLL8XfowQuGwOvZc39iaLHSACtn1bzInHjxWzVSGVram1jQ0k1/mYnG3I6B+OY2YEnkeBYUc3NcyYIlhB4S3+N3hJ3tlDYYpmjN/3E4uDjGj3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEYNoA4lzc9g+7hL7YvMzXGUyNcZvAdtALRVFvAMw7c=;
 b=ldYytdHctv5HlYYQpQ0Fq0uZJRC3wtCQkvFb0dftr7urKzV6+8eV+J0RP4eHxiHHwq/YhHvoArd2megMAPw3r3lDqNxU32Z6QlSiiEbI2wCahTFI2OQi7g1KkDIInfJ73PrJ/6Ue14q3+OoX/335ezUQBLtadxlrucuFRJLOAWs=
Received: from BN0PR04CA0179.namprd04.prod.outlook.com (2603:10b6:408:eb::34)
 by BY5PR12MB4113.namprd12.prod.outlook.com (2603:10b6:a03:207::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 10:22:36 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::f1) by BN0PR04CA0179.outlook.office365.com
 (2603:10b6:408:eb::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.13 via Frontend Transport; Fri,
 7 Nov 2025 10:22:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 10:22:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 7 Nov
 2025 02:22:34 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Nov
 2025 04:22:34 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 7 Nov 2025 02:22:33 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix lock warning in
 amdgpu_userq_fence_driver_process
Date: Fri, 7 Nov 2025 18:21:28 +0800
Message-ID: <20251107102232.4066722-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|BY5PR12MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: 812d9c69-b6a6-4448-dc65-08de1de791e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?54AztEFvuEoseyhqjQSXhv2umSHw98otyjuO2wE+rmz7x7mzqe+5558TRrxp?=
 =?us-ascii?Q?SVIolQ+cDc5un89wKk/EvIiCOmGZfIPCcEnohuaHp3iJnRAn/0uA/9LsKQom?=
 =?us-ascii?Q?MJm3EueaUVkPwrL2ERi1jTXaqdCMzlMaoDOUfEAF0cMPBtfAVz5V6oWTUYme?=
 =?us-ascii?Q?oRd9htvaPyzhGkF0ujyrJzmH4lj2BPsi47MsjCyUGv+LuLYsUvdXl0ZLPDSz?=
 =?us-ascii?Q?CnD1xLH4lgiFln9MwD35z7ugndi5vRGH2gwA3EqoovfA062/6cgjbc3Jm6lo?=
 =?us-ascii?Q?VuGoveUp3DhaRQIyNxTmPGSmfPIawXMtqSa9RMLLOJNTYyp2OFiRoI8Ssyrw?=
 =?us-ascii?Q?TD1szT/nIkMYh4xTLK+vZOkTVDGAQbJBjkmimyXeOUSCsSrPyz+w4H2SnKxB?=
 =?us-ascii?Q?ErbVGD21p2Iwxx/9NMFJZmyiVVuXQzVkXXVEBQFTeH+0+3PliYyU95YGyMcg?=
 =?us-ascii?Q?0unHPZiy8l/gq6efZ2AXz1raWGYxx7rB9e3bCvUIPLzpnTfBgs9l53fBI90+?=
 =?us-ascii?Q?J3BP89EMVibAozDHd+PEiy0dD7C2Fgsk7AdYBM1rWUKL0hn8wfIyVmkuew1Y?=
 =?us-ascii?Q?vFJfV7BeTt7eM5agN6yLu61cJSKENUPyr0RvavyCFppcczNMCu58OTHPiq++?=
 =?us-ascii?Q?7DEyAoeD6jmdALS5JQ9RWxVqdqg1Ga5+5U4NanoEEDNLFmuqelsdwoA73ui6?=
 =?us-ascii?Q?WM81nws1xBJ1PdAnzeU2VYpJp/+2YEegvGPfdjrpoQectjdvg5ivATFwcuHx?=
 =?us-ascii?Q?dtu+ixaquHO8H+c1FftkMb/2Vh6nmSOb+gV8bqTF79QgkYEkV/7uHvqb+pDB?=
 =?us-ascii?Q?JWFnu63aU3/i03C/qKmlEP0m7pZesZ74xKcPFCMm5Sx2cH122G4vN+YGUxBV?=
 =?us-ascii?Q?8C7dATu83bb7mQgNIKcsdd5881IL7gKB3qpGd6ywY5eqylcOvgahA21Y9RDN?=
 =?us-ascii?Q?1h2BqZ/aXtL9pbHr42B0tTCbUDnLtZqTxuUh6F3DHJ3vXg6gesmpdaQMO9nj?=
 =?us-ascii?Q?3z3g2u7smnedFwZN/ifFbHML0MX3EU/32EC1V/0AB/eeszl31gpGnnCNs2T9?=
 =?us-ascii?Q?GUKPAln+IqWZ88BCxDuv/nFKNXKuNK5TU7Hs5tYQ7QCK3iEwCKxlrafuRxJP?=
 =?us-ascii?Q?9oPgPVwXe1MIRRlIIU0TK3BJqHEBi+3toGam0C4cKAs83J/I2Qw/I6zF3KE8?=
 =?us-ascii?Q?4YAqlRE9TrMZix6TOJYrO1jkE+cda9JdtWorgOzRsCJAVDPI8EL6rQwJNyRK?=
 =?us-ascii?Q?33b/6/a1ImS4vbIA29t5QzfzIGeoIPTV6J9I7SZ41qOnXUwx0Ikc7dZF8od8?=
 =?us-ascii?Q?DDhS1VP0klkS9EnkA+WVJ9TldPqIVJmaaCWxF30qmBeL+9Z8awz1dpDUnc/d?=
 =?us-ascii?Q?I8Df0H4ofZjEoIF4M0x3mDDw41Id1KV9AdGGFN+2gP3v2ra6+/RYtSrK5jqM?=
 =?us-ascii?Q?XJESUKPFYxtE5O2SkbThyUdyVvSM+1n2BT9rbkwZxUTPxzK4fLCa3qMS+hMY?=
 =?us-ascii?Q?Trvd3T1rWNbfQ4TK2nqC0SCp9rNt6W4cmDLb0/Bu6aJWRotnQI9popK30KX5?=
 =?us-ascii?Q?etB6ktxUfa+spiJK2fU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 10:22:35.5165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 812d9c69-b6a6-4448-dc65-08de1de791e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4113
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

Fix a potential deadlock caused by inconsistent spinlock usage
between interrupt and process contexts in the userq fence driver.

The issue occurs when amdgpu_userq_fence_driver_process() is called
from both:
- Interrupt context: gfx_v11_0_eop_irq() -> amdgpu_userq_fence_driver_process()
- Process context: amdgpu_eviction_fence_suspend_worker() ->
  amdgpu_userq_fence_driver_force_completion() -> amdgpu_userq_fence_driver_process()

In interrupt context, the spinlock was acquired without disabling
interrupts, leaving it in {IN-HARDIRQ-W} state. When the same lock
is acquired in process context, the kernel detects inconsistent
locking since the process context acquisition would enable interrupts
while holding a lock previously acquired in interrupt context.

Kernel log shows:
[ 4039.310790] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
[ 4039.310804] kworker/7:2/409 [HC0[0]:SC0[0]:HE1:SE1] takes:
[ 4039.310818] ffff9284e1bed000 (&fence_drv->fence_list_lock){?...}-{3:3},
[ 4039.310993] {IN-HARDIRQ-W} state was registered at:
[ 4039.311004]   lock_acquire+0xc6/0x300
[ 4039.311018]   _raw_spin_lock+0x39/0x80
[ 4039.311031]   amdgpu_userq_fence_driver_process.part.0+0x30/0x180 [amdgpu]
[ 4039.311146]   amdgpu_userq_fence_driver_process+0x17/0x30 [amdgpu]
[ 4039.311257]   gfx_v11_0_eop_irq+0x132/0x170 [amdgpu]

Fix by using spin_lock_irqsave()/spin_unlock_irqrestore() to properly
manage interrupt state regardless of calling context.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 99ae1d19b751..eba9fb359047 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -151,15 +151,16 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
 {
 	struct amdgpu_userq_fence *userq_fence, *tmp;
 	struct dma_fence *fence;
+	unsigned long flags;
 	u64 rptr;
 	int i;
 
 	if (!fence_drv)
 		return;
 
+	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
 	rptr = amdgpu_userq_fence_read(fence_drv);
 
-	spin_lock(&fence_drv->fence_list_lock);
 	list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, link) {
 		fence = &userq_fence->base;
 
@@ -174,7 +175,7 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
 		list_del(&userq_fence->link);
 		dma_fence_put(fence);
 	}
-	spin_unlock(&fence_drv->fence_list_lock);
+	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
 }
 
 void amdgpu_userq_fence_driver_destroy(struct kref *ref)
-- 
2.49.0

