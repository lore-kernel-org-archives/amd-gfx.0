Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F9DFED3F2
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 19:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B46A10E00E;
	Fri, 24 Apr 2026 19:11:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1L6yetNs";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011029.outbound.protection.outlook.com [52.101.62.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81A4310E00E
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 19:11:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SO8SSxaaL4AUHJLd6VyeIYnK2L4J/m9GnifAtRbKDa1iunYHVsrnxXjf3FO7M8t3d9L+2DYWz73CtR3NPZccuajI6VhG3Tl/glkQebrlVUlioSVHZ2fMNEV5jttx1bM3rjkO/O4tqtVmoFv7LO/N8quhuo88XsyHpMSYFLin/MARf9y/4+5a3thElJTaa6qicLHuFHeIPs1c2JHeI4/euA7o4ewpuq9AHx6eYtctONpImrkg+lgbAcPY6CkofiykRzC+TB21Q9SZSWZmcLmEtOJsvdH/iElB20cAIOpHHV/XfaTQH9JwPn29i3nubccfaeQYQuIZ7vSKCcJh3/Y9XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7ddL6fRgoGNnwHIN3X3b4PdNZ6IVCpYtvqalglPtwg=;
 b=PxoOqx1JJSRZfy6MHWUN4hFPqforDZnk4BnJTZeIzivoIhJ7dLp3RS9q12AkZyQzFngcmZP6x1Ewt1orBwA9/0EvYQ6oiDFOd2tIFPgJ8xuF0vrRu6nHnb8C6WAm0nS29hGuOhyGW0MxaxJtbwwU/piUhbXcr3gLtHM3ovSN1XvaVsBx5hgcat0Bzs8s3jwquXy8XjuPUyhqqxuQEKIvpp6PPfG7ze6AoTdKsse7pd5KLSNsT1J5ijYQw9zujYCPWsVJegXLMHNwUBS2P6SyUOUKf/heCxCzCwHTw2mAktoFKENK+TElypF3i93M9OYaC2A20mF62tFsYuuG+a9Pqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7ddL6fRgoGNnwHIN3X3b4PdNZ6IVCpYtvqalglPtwg=;
 b=1L6yetNs93AOHWpV8D93zcMQg9znTG5426DhbXhHgSHo3IZWC9BNP1TAUdWQW14Fkbx1gaC233ER2wPL3/dEVBlwNCK6UmSzW51N9YezZGULk20KKYZLM2XL4Oe4JWUSiTOezO+7M4DkyI2HxN/YMmNBndHJb816+9iimMs2QX4=
Received: from MN2PR07CA0021.namprd07.prod.outlook.com (2603:10b6:208:1a0::31)
 by CH3PR12MB8972.namprd12.prod.outlook.com (2603:10b6:610:169::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 19:11:25 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:1a0:cafe::24) by MN2PR07CA0021.outlook.office365.com
 (2603:10b6:208:1a0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.21 via Frontend Transport; Fri,
 24 Apr 2026 19:11:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.4 via Frontend Transport; Fri, 24 Apr 2026 19:11:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 14:11:24 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 14:11:24 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 24 Apr 2026 14:11:24 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH] drm/amdkfd: Check if there are kfd porcesses using adev by
 kfd_processes_count
Date: Fri, 24 Apr 2026 14:11:07 -0500
Message-ID: <20260424191107.2146398-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|CH3PR12MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: 30232f81-1f4e-440e-ec80-08dea23547a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Gk+6OchSYAFTqK0uhiMiERCbuxXkU7mJ0WqGFkPrzVx2YsiBePolXtTi3/tN0F5dmxc5rcQGxU2uoyCV6iFqLhsuXcg3YxIPDPvWZk86jcLdkblcj4tgbFVBgrRIGBnGVdkaL7lY5QLdgWn77ZhqjI9sIwZGcAljuLmhj3wYytMEnCD2E1phG8uREew8Ig1e1gAEWY23sThHNaTHMStnyn+B9b2XGpVuH4U6naNh/HaxGW9O/do1ilNwfX5FI0ku5xRGYXHO7xhlPxRijixFat+Ce5Hyz3VZ9V3Mx0PQjgmsn7On3QylDai21AHEL8AwT/G5hrtue2X05iCBwl/gCJsxyqa+RM62cthsUJyoupqfWhoBK7t5y7wGCmdvCwn63mL157rN6hv/jdCnuK+gkxhB+VrFIQHcjTwd6B6HP3xZTC1QKxA/QOn54JONeL1iXtwsFry7Sdyoy9FXl1U8rXun25ovYfSXkKa1EJrM+JMx7iWn4x3W3LIXN4etASBLqRWxXDpGj4U6xsNBY2wLXLmFjkEcjVsWvPgG6BW6TpL7CmP4sBXSPOT4Vqd5nQTCVWI3J/13r2/dleR+tNL4Ws/TFEqtgvYJQtdgt4eUwAVeqGaMpUNuRh8Cb5E7w5l+fCGh49wiVr4N1MMZvyhdLoul4wuwuap1lfmaDaf8gYwjNhLsrrFZ7dtrR6IzQ1kPhcmTI4RzoMuKpKEUPYgltOZ93McF7UsUsqrEvrlBFL/tbT5tR5ohgyygT6p65AV5EPs6c7m0dCDp8ccKvsii6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ffJwbn+Z9pjwG8HHQ1PlWJWEb+jTw0ULHLJpR2S5p14l7/VPd2q2bT6aYBProyvyu0ZqdRJD/heSNnTeBpPDAXjmlRfyT9OwEP5naZoKT3z1FOEZJwLdHOry2GJLrILzJXkY7TXPIY4PNmSFf3AtD/aNC1rrUdM6Weq/cL4sCCocsSuKZfkgL+C8n2MWai5ZsdAuyN37xx7EXvk+WtFe2SMFqjWc5toAXVyWBxApf9cSxi1n4UFGVq3JLBp+nVxCzf1GGaPq8vwNvMKFIKnk0B0AT2Cqi9307WdDgUGTmX1FbTS9CWzJpKpRUUUn76J/b7y4AMDmDZqaD0nQAqb4fIQ5lzq26gxuh1JHJwcbShKV3qk1fwSNIAU5o/dGW5MEgDfqyuNqYoV+el1mY3RHniabNgCRow+D3l0BHuKdHNeSgozqSvnwUyzpC2a82xGF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 19:11:25.1775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30232f81-1f4e-440e-ec80-08dea23547a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8972
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

Fixes: 6cca686dfce7("drm/amdkfd: kfd driver supports hot unplug/replug
amdgpu devices")

During gpu hot-unplug need check if there are kfd porcesses still using the
being removed gpu before clean resources of the device. Current driver checks
if kfd_processes_table is empty. kfd processes are not terminated after
removed from kfd_processes_table immediately. They are still alive and may
access the device until kfd_process_wq work queue got ran.

Check kfd->kfd_processes_count value that is updated after kfd process got
uninitialized when its ref becomes zero.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 33 +------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 9a66ee661e57..71fd3b1d0b3a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1737,37 +1737,6 @@ bool kgd2kfd_vmfault_fast_path(struct amdgpu_device *adev, struct amdgpu_iv_entr
 	return false;
 }
 
-/* check if there is kfd process still uses adev */
-static bool kgd2kfd_check_device_idle(struct amdgpu_device *adev)
-{
-	struct kfd_process *p;
-	struct hlist_node *p_temp;
-	unsigned int temp;
-	struct kfd_node *dev;
-
-	mutex_lock(&kfd_processes_mutex);
-
-	if (hash_empty(kfd_processes_table)) {
-		mutex_unlock(&kfd_processes_mutex);
-		return true;
-	}
-
-	/* check if there is device still use adev */
-	hash_for_each_safe(kfd_processes_table, temp, p_temp, p, kfd_processes) {
-		for (int i = 0; i < p->n_pdds; i++) {
-			dev = p->pdds[i]->dev;
-			if (dev->adev == adev) {
-				mutex_unlock(&kfd_processes_mutex);
-				return false;
-			}
-		}
-	}
-
-	mutex_unlock(&kfd_processes_mutex);
-
-	return true;
-}
-
 /** kgd2kfd_teardown_processes - gracefully tear down existing
  *  kfd processes that use adev
  *
@@ -1800,7 +1769,7 @@ void kgd2kfd_teardown_processes(struct amdgpu_device *adev)
 	mutex_unlock(&kfd_processes_mutex);
 
 	/* wait all kfd processes use adev terminate */
-	while (!kgd2kfd_check_device_idle(adev))
+	while (!!atomic_read(&adev->kfd.dev->kfd_processes_count))
 		cond_resched();
 }
 
-- 
2.34.1

