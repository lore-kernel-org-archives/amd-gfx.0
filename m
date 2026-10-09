Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB02FCA6015
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 01:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BC5310E1A1;
	Fri,  9 Oct 2026 01:57:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wM4EcNen";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013020.outbound.protection.outlook.com
 [40.107.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 816B710E1A1
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 01:57:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXVASCL+ZvV/F9t63gxsAddHZYZfgdDmFTec0yndEYqiy9jNVw/HG4/JgPMR0+Kq1yuY2xuc9UFg9T8ccNFH7K+kop7De/G5KxFHw/A5ncY1oxZRvSS3b7Ql1vDDhqAl6F9N5Ih9WqJeC1rcjGRLk2/MwDXtQGmSWSqVbayejH6Mu6qGDcq0aKKvck5vh96LLt3Avy3LDOeBkCP101aC9dTqLWNitwDDfrChlqiRJw5Y8vS6ovBXEHKxPG7vkUfXpo81zZCJxRdpLP2m3Vx/1CWPGu/I05cySJz8haHYsttHqeSynHbA7gmREL3zVp1Lu/z6sUAQ2zvBDax4menaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tx2hD3+d1r+hQ5S+ReOWq2zKqHqz3OI0iAL047gEXy0=;
 b=q74RPy9Iqkamg9LVQhRTq+ZZ2PSB/WAR7s0u2RRotHKudIn2wu3n2CRyp2NEAGyMwL3UL01Q3MQ6rG5ViFtg1XLrno2K/54quKzu4pmPVZXeN0w7ncNotSlVcItA3fYXefq0GnNFstlRaFACLvCj8SGUrb6yjxzrazjTKy+Xwoup08vo4/7XH5dPjvrGa6rRGWFa9VCTUjwy1jhcUtwwG23FvfuZH/C3Kea25L5iMc4/cG6tLrNAWRuQVlJcpcjznPMLEHTBEcxQ/uEoOy+8ej2LqsExqUpJJ5gJU00xLp/8W10qlssLJ4jYwse/zzYhXvSRW0o0QYVK87z2TGduVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tx2hD3+d1r+hQ5S+ReOWq2zKqHqz3OI0iAL047gEXy0=;
 b=wM4EcNenMEsIG6MvMnSIaIOix7OXZ8txevz/srL42C+oO26NgzEp8ONZTe7Buq1bWP3PxXG+OZPI0cG1BCYrGRLaDDlIj/JgwxUvjjZrups4jOfKuz11dJFDoRUyrb1qhudM532gqJ6dSdW/Tmo81QR/I8k6M3KVKoIwqnime7E=
Received: from BN9PR03CA0913.namprd03.prod.outlook.com (2603:10b6:408:107::18)
 by PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 01:57:19 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:107:cafe::13) by BN9PR03CA0913.outlook.office365.com
 (2603:10b6:408:107::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri, 9
 Oct 2026 01:57:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 01:57:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 20:57:13 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 8 Oct 2026 20:57:12 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: fix the error path in amdgpu_vm_pt_alloc()
Date: Fri, 9 Oct 2026 09:56:46 +0800
Message-ID: <20261009015716.3935954-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|PH7PR12MB9174:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cdce6bf-2c00-4479-6a36-08df25a8a665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: Yz9ttC0EzkcS5oovLmeWKOATAXXFvGuXYyrnPvEovUE4/VgAQk6Muz3Qc6LfMUUL3KR1lCOjeOoArkCeMqEZqVoyibVTjVyA/0bPJSGtDHQmXmXpSpU8d0qEzwmaBQHwgD6PkbFAVp2QSz+EJEsferft6ouSq79vh7z+wzxDXTfLFX0TtvLlbyONk0toeeskjWvvlru15kY8fi48Kl0HJpKgH6fw04sFQenZMxGsGHbfa+yUraJkL8xQKhAO37r5TjyiQ4p9d6cC8Pb55zr94YlQZy1eYnYfwhX5usnn2n1RW3DEymi3x7v014LFMelp5r9EVcd0J3Uu8mRuv2P+uKtZS9CKJ/JZtEcKyqIWfGGZ50/EgKkXm5LMGw+5ujOM7VXMQpVQKyYvnvXEgwACb3dx4d9C5vj4Z06ISvAUcAyXUREj+a/Itwmmjb7g2jr89imxg2e9K34DmsO9gqquER/JEPuN3ZkWkWVn7Pxa1v3ixc2P+zyidUUDsw3y8uu5t6N3RWdl4DFerdASl+QEJzeuKxwN0FOwCOhrvye1Sphq+AHCbVFDf/IN9EYs4oMmxIXpnhIiVd8RehASa6ZQuteIBIPcoGi0YLcN53PrBgrrSjlm35eJcmt09CAQTpzit8tgo+CGkbiJ9dIsevzkDWCGh5zaVrWPYkLerwD0A7kXE/pH2Al5tsbcgIUQ6sxhqiqQU/10r67ljdDzjthV1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XvFLd6W0cfg8tqfW26Xfj+2RJ0QD09Mkczbj96OJwvjikTgiexAGSut+BjTu2p3EKJFlDUYXS3Myc7LGNp4OCps8MvjbNGVguV8HercBtASi70sjsnskRaNzQCCeEDzFTMafgEOQ4YfJrfKsM5+nmRRPV/bQqqbOagZY/84jU3C+j5Crp1ZtOAqGKgdSCdgsk8YRf9zaVvXCWcWCeKrrkqtuxiUM6XF0hW2uSq+5dtK/u0uA8f8C5K+ooZTSgPdgp3vyX2V+IwYnzsM2nvBOZh3GFksrny+5LBqz1T2va/bXw2+v3MZjHrcUuPAiRe7b6xp7E+Ia/TAuiLYQyh2x1tbJ0IEhv0d9aY1p4C7LSF3WvsbW6Kcveb3A0G8ODsrquspZ2RV5MhDBho5ECuJKoTPYynSayLbsQR06+NPjxgO+DIzCHrlHEycJNro1U8c9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 01:57:18.5880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdce6bf-2c00-4479-6a36-08df25a8a665
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9174
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

amdgpu_vm_pt_alloc() drops the eviction lock while it creates the new
page table. When the VM started to get evicted in the meantime,
amdgpu_vm_begin_critical() returns -EBUSY and we jump to error_free_pt
before pt_bo is assigned. That unreferences an uninitialized pointer,
leaks the new page table (still pinned for NPA VMs) and returns 0 since
r is the result of the successful page table creation.

With vm->evicting set right after amdgpu_vm_pt_create() (what
amdgpu_vm_evictable() does when TTM evicts one of the VM page tables in
that window), the first GEM_VA map that needs a new page table oopses:

  BUG: kernel NULL pointer dereference, address: 0000000000000460
  RIP: 0010:amdgpu_bo_unref+0x27/0x70 [amdgpu]
  Call Trace:
   amdgpu_vm_ptes_update+0xa4e/0xa60 [amdgpu]
   amdgpu_vm_update_range+0x2eb/0x970 [amdgpu]
   amdgpu_vm_bo_update+0x325/0x6d0 [amdgpu]
   amdgpu_gem_va_update_vm+0xdb/0x1c0 [amdgpu]
   amdgpu_gem_va_ioctl+0x86c/0x940 [amdgpu]

Assign pt_bo first, unpin and free the new page table and return the
error from amdgpu_vm_begin_critical().

Fixes: 1e0041e2ac56 ("drm/amdgpu: rework eviction lock handling into critical section v3")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index c03327f1242d..599c0085cdd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -531,13 +531,16 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
 	r2 = amdgpu_vm_begin_critical(p);
 	if (r)
 		return r;
-	if (r2)
-		goto error_free_pt;
+
+	pt_bo = &pt->bo;
+	if (r2) {
+		r = r2;
+		goto error_unpin;
+	}
 
 	/* Keep a reference to the root directory to avoid
 	 * freeing them up in the wrong order.
 	 */
-	pt_bo = &pt->bo;
 	pt_bo->parent = amdgpu_bo_ref(cursor->parent->bo);
 	amdgpu_vm_bo_base_init(entry, p->vm, pt_bo);
 	r = amdgpu_vm_pt_clear(p->adev, p->vm, pt, p->immediate);
@@ -549,7 +552,6 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
 error_unpin:
 	if (p->vm->is_npa)
 		amdgpu_bo_unpin(pt_bo);
-error_free_pt:
 	amdgpu_bo_unref(&pt_bo);
 	return r;
 }
-- 
2.50.1

