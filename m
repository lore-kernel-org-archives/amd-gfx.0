Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0467DE74919
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 20:21:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C82710E243;
	Mon,  2 Oct 2023 20:21:36 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC5E210E243
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 20:21:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ly4L07WsycsXQLXPwF4cbcsXtyYwGyuf4I7w5721HTNuAWYGuic/r2XByhBDYQz+oIhaorM0bWjYix0FdhJK5CE1dfP5UI120KTJCF39Uflmq1+MPrRLk9uj/LVQ7I1iJ73VVlWEUEXSIt2SKAgOEG62TwAWXCUKs0LcDg2ok/8mfg67rUl3QrUl840+KJWzFroXrOQ9Tg6JJ5pthZ8Iwsd5xZMWxjTZdAPgpNU9WO+ia55UQCn+gFZkTTuMShsZ31tW8I0Pe/gkMVuug1Jdptra72RM+xj4/7Xy645LTiFlKB1O2xyUpmvAGngDTkJLMu0ZzJUuV8AKExG/Ntg27g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fh2GtbHQ01O2kl6xwXGHHxFCVGwq7wODlXeRuSnn7lw=;
 b=Ps0E//FEs/K3y8y1wOepgpmQYyg65ot08FGaF+nVSkq6Ko44HrcEaia+nY9cpNGhOdwgaAs9VkaTiz+qrKNGR0r8wRhJcmH6QPrZHLynqKRSOPo8JiB1bFCVnXiI1t1aGORVE+060BAqw3XoIR8vqowLjKMtctIIeD/irXFBnaGNKZxpNR7STNv8QILQ/IYdpSBsqM2NOLoR8E+0BYk6OysiaLtRmAlzlX18y/Vks9Dv0YvqIccNljOBkQgpn3h76O+hCm91Efy3RpLW5xBJVUXvX6tHq0TRqMadjRlnyjFcCmUmswOowpv5/AY3cAsdAqKBOfqHCoYml1z9XWk8GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fh2GtbHQ01O2kl6xwXGHHxFCVGwq7wODlXeRuSnn7lw=;
 b=U1+ZEFaBJ/BwE54RvDrkSn1MOz92Zk8OE7WatekQ2CqiZloz1CMHdbSzszztA/dO6mOhSNFQMCJTYqObSRrZ7QtBRhLAuvUqVGCKO6eyg2FEX3vFlMIWgvrP5E6FPE+JekIhx6QzF2V6S0RIUYWUVjFSNy5tZj4J8XvzbDlZSHo=
Received: from CH0PR03CA0074.namprd03.prod.outlook.com (2603:10b6:610:cc::19)
 by BL0PR12MB5010.namprd12.prod.outlook.com (2603:10b6:208:17c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Mon, 2 Oct
 2023 20:21:30 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::88) by CH0PR03CA0074.outlook.office365.com
 (2603:10b6:610:cc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.32 via Frontend
 Transport; Mon, 2 Oct 2023 20:21:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 2 Oct 2023 20:21:30 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 15:21:29 -0500
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [Patch v2 1/2] drm/amdgpu: Rework KFD memory max limits
Date: Mon, 2 Oct 2023 16:21:16 -0400
Message-ID: <20231002202117.2690645-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|BL0PR12MB5010:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d8fb0a5-75d3-4b90-ea46-08dbc38529e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CefCWlAGXBu4fmKe+c9uWq3wNFgcnrWinL+Kxvkt6ILcsKOjpMKA9uIjwrR2hKctPtmaw5Ky+0i9hHKsmHMi9AXt+A/AB4tqFRS+ql4Gar8Xapya2RMF4FB6mZ9ZBCg65a7Nf45ODb2gggsnyfy6PGW/Jvb64XeONWkRINBKduJzYHI7lGX8eD7CTvwd8DocuyVqjyUu5i6i6vnNLwMJ4rVkshE09D+lOQESxUy8B7PHtmu29PLElomgd0k7XXeVSN7AvCAuhvAjXkYw/A9rcLugw+xENSkX1q4nKw6T0dadQvgvBrVXPruiAUgdz0Nr5CS3KrIONoYd+HbWvoNmgKtBw3LHTENAf64aDoSdTEUaH5uuj95RSFUbdK6n8XfrZClAoj6KfCz5pf0j+u86SFGEdxhq1fZKK0HjKLs7FsVHDc32v+g2IYfC53t4TlEfnYcZI+0ZVpnkfNKaQFu3JvDCnbdlfst8Q+Ahj1z0MlzhEYKP8zWqmNSQfxLoygQDoTjn2tXl0Nq3AjQ3cirrDOGkbLQGEjfcOmRx/EhP/k3splvgDif1t/U3JcZLZ9Z6kzE8imyv3ur52J3kruDBfh32mHBBkw0ZzwMRmiiubaYAbQBOBpqPpRwWpdFbTkvOeb8V9fMxCdM0gbF39IcbfweHPxAtdcoHg+aXn+MIfeHGP6DLgjgg4hHlyn4Q6czSG2deHkqoxHnNzC5cqe+9zUnLpsYJiNamEyr6M5F3eipHO8xyt3/BQkIpq/78xR5w65FW+w/gZKil6pMauQ45zw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(7696005)(6666004)(478600001)(426003)(336012)(2616005)(26005)(16526019)(1076003)(83380400001)(70586007)(6916009)(316002)(5660300002)(41300700001)(44832011)(8676002)(4326008)(8936002)(70206006)(54906003)(36756003)(2906002)(36860700001)(47076005)(86362001)(82740400003)(356005)(81166007)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 20:21:30.3276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8fb0a5-75d3-4b90-ea46-08dbc38529e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5010
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
Cc: philip.yang@amd.com, Felix Kuehling <Felix.Kuehling@amd.com>,
 lijo.lazar@amd.com, christian.koenig@amd.com,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To allow bigger allocations specially on systems such as GFXIP 9.4.3
that use GTT memory for VRAM allocations, relax the limits to
maximize ROCm allocations.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index b5b940485059..c55907ff7dcf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -42,6 +42,7 @@
  * changes to accumulate
  */
 #define AMDGPU_USERPTR_RESTORE_DELAY_MS 1
+#define AMDGPU_RESERVE_MEM_LIMIT			(3UL << 29)
 
 /*
  * Align VRAM availability to 2MB to avoid fragmentation caused by 4K allocations in the tail 2MB
@@ -115,11 +116,16 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
 		return;
 
 	si_meminfo(&si);
-	mem = si.freeram - si.freehigh;
+	mem = si.totalram - si.totalhigh;
 	mem *= si.mem_unit;
 
 	spin_lock_init(&kfd_mem_limit.mem_limit_lock);
-	kfd_mem_limit.max_system_mem_limit = mem - (mem >> 4);
+	kfd_mem_limit.max_system_mem_limit = mem - (mem >> 6);
+	if (kfd_mem_limit.max_system_mem_limit < 2 * AMDGPU_RESERVE_MEM_LIMIT)
+		kfd_mem_limit.max_system_mem_limit >>= 1;
+	else
+		kfd_mem_limit.max_system_mem_limit -= AMDGPU_RESERVE_MEM_LIMIT;
+
 	kfd_mem_limit.max_ttm_mem_limit = ttm_tt_pages_limit() << PAGE_SHIFT;
 	pr_debug("Kernel memory limit %lluM, TTM limit %lluM\n",
 		(kfd_mem_limit.max_system_mem_limit >> 20),
-- 
2.34.1

