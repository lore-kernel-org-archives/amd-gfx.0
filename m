Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BFA107BCF2
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 10:31:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E81C610E0E1;
	Wed, 18 Mar 2026 10:31:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nnBE2InN";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012050.outbound.protection.outlook.com
 [40.107.200.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DD8B10E0E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 10:31:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wphGxjX6X5VFuFURS7FfPAWglwVUng1OfiyL38l49yM4Qo79F3Zob0hxw57ho53fmqcMCC1QkkjOQMuKLgTyqxtb4Z3l09BnE/osUqR07spieekTaKz+KWGvFjV8X7cnEe616IjGhw4l2s7txFMnqDlvo1u0gX58C+WCzR6L0+l71QIZIEAKSESIfAgkk3j+GX+usHJTv5kWSgwn5j0LMf4OrbDxa2b7Ws2X9XoWCQkgABU+Jd53wPNZoHH0lkyeA+Cb9sBolAaZ1U73mKmjGa5/9L8wSimBbT2BzdG7Dt3zjuBRv+NaEcSM0FFwuGmpRK1zKE6QwoJ4leshngL1rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ySMpoFahziNnCrfNHq5uoQymHuA8FYe1OJEJp+qf0k=;
 b=VOCiBUUT6Syp5ftkrQ9xZNVSpkw5RP2VVsonhWjiyw2bG8laiexllqQ+K3tNjBr+6ctcGy9hGRq4mU40bcNE060iZMPQEQAUnLkDGNIdhvxiBGj4Iw4HiLOmq241xCmZR80IhNmB7fKiXfl039t+0Cphm/K3QGroN1lFmWF9ioBJDmNhmGecsVvC6nV7LQBpKTiC7wJ7gssETpkVXDP/V3Ws2C9D7oepXspe/pNNweBho7AJIHaZQM02pEL8XX7LGX1lHr0gmOKn7U/N21Ks2oO5PT4BIOk2FytUgumX0ZLsDHICZoR8LFvSSPIARpVbUs4o3Ufae1ks1bs931XZ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ySMpoFahziNnCrfNHq5uoQymHuA8FYe1OJEJp+qf0k=;
 b=nnBE2InNiy+I2qKmTPt68s0M6fN2zZQVcy9397QlO8+ptDulADZ9DEXCzUQTv3F0sHfhVJKeeXkBiRM+Y6GfUEQ7HYtSJHC9+GwvpRwOkpNeexRhOuRL+4NHi8AvEu8hBI+HdfXIoLXApHLA6OyLm94gwRDZSDiUS1ZTO7h3tl0=
Received: from PH7P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::31)
 by BY5PR12MB4113.namprd12.prod.outlook.com (2603:10b6:a03:207::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 10:31:25 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:510:338:cafe::bd) by PH7P223CA0026.outlook.office365.com
 (2603:10b6:510:338::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Wed,
 18 Mar 2026 10:31:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 10:31:25 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 18 Mar 2026 05:31:21 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v3] drm/amdgpu: Avoid NULL dereference in discovery topology
 coredump path v3
Date: Wed, 18 Mar 2026 16:00:59 +0530
Message-ID: <20260318103059.1976682-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|BY5PR12MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: 61614b03-96da-4f49-390e-08de84d981ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: svlUaqcv68kQCF5rfs2gIE6STOnkVoAUfL6K5K3vtxZoU23wbQdRwcuao2ghrH3aAeSU7XH+0WygYtasTjdIldrAFogz04Rq0XFhMGoTlx+rnaXNClvJUu+5NOfay4Q/iuBSrzf8NbtSBmLev4a5Hqszf3fC88aWG3gu2TwEvH0QILD2BLwHxoLCqrXSSXQ9kcH6nkpmZrLrISStIN4xwh0BCKpJ0gEu5Ii+pKkJpRTbcjvI7lrEk0amZsKoe1gOLWqgjpTvLhbZm5UPDwMOboBneK3MoA9bwy5whgXEENe7wwpbwYZZinS9IvZPX7t3dEPAFhiTHU6fSYWcXJut8Ay3pyihjt1lKqv7fCYoK5GioBNTxPeT3ABZt8dv95nXOAd9K4DGc15J03+9IW9hswF6lSIaJEnfYfDS+nbCIYbG+N/asp+R8wTWVS0T+ZnNpq0hTGRn2NtDQIFHdhOJJDX/8W78ysVpWH0hTh3l1ak0u39IxlMuAMBnd5MM8rX44T1DewQURyo+NOBMODkiLWxbkgj0txw9INt63X/UtAOY/6BuVy1Lrh8/EDHh4vIH01R8SLFEyy/Pj8fgfy5v/J2iNqKHrVPZD2Oh7uQvXyfKWYMnimvLhONB4Nc8W4vAsQq7LLNBo7QlhQCsq4R5cUSBZ9wKkPW+LAwqxgMBKtCyXbmjvelCbVlmhQZ2oph/KiEAFWhYl5U59FPo9tAABd/nlmu6TiYJ8vgLx8HDYidFRvOvdVF3600c9lqgUYyxORNo2eGTOgj5bWqAhVwZMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gr590XTHabhNvTv+QnJmsNqNZIZMh28frx1Iq/9d+I3+cM8/kuVBZVJCLig7juzBT81LpQ66sUeI7UAlgF3tlmnN5C9VYCt4lBhIa8QmoVY9u/tYsUojJsRf2ou/L4L70ZWDQ1L3sgsRQHdhD0xrncTLPuYqNDo/b9t1TbpgmYiBseoO5LHC48ZB8xGP3vJ8J16YjQpH1ai+mfJHORYs9tq0AET8Taff1jxzq+z2uAoLrzcJJ6nkB3smGlyVqq1IXztA0fBFIFr9PrQSvpyZx/YeC41j6SIio83cfgPRdrBPdHAXzqm5neGXH4lgwzwuDAOHuY8NQBFlGZd+/MAKfjrS3uLob+PzhDRC210zKrol2S9ZPZDjNZx2vdmhs07p2XjEcw0UUAw3Ffq4nDS9DInQ6E0jjNzn8NtffSWeEFHdeITfZ6T53BWdVEpv7c0e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 10:31:25.1320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61614b03-96da-4f49-390e-08de84d981ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
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

When a GPU fault or timeout happens, the driver creates a devcoredump
to collect debug information.

During this, amdgpu_devcoredump_format() calls
amdgpu_discovery_dump() to print IP discovery data.

amdgpu_discovery_dump() uses:
  adev->discovery.ip_top

and then accesses:
  ip_top->die_kset

amdgpu_discovery_dump() uses adev->discovery.ip_top. However,
ip_top may be NULL if the discovery topology was never initialized.

The current code does not check for this before using ip_top. As a
result, when ip_top is NULL, the coredump worker crashes while taking
the spinlock for ip_top->die_kset.

Fix this by checking for a missing ip_top before walking the discovery
topology. If it is unavailable, print a short message in the dump and
return safely.

- If ip_top is NULL, print a message and skip the dump
- Also add the same check in the cleanup path

This makes the coredump and cleanup paths safe even when the
discovery topology is not available.

KASAN trace:
[  522.228252] [IGT] amd_deadlock: starting subtest amdgpu-deadlock-sdma
[  522.240681] [IGT] amd_deadlock: starting dynamic subtest amdgpu-deadlock-sdma

...

[  522.952317] Write of size 4 at addr 0000000000000050 by task kworker/u129:5/5434
[  522.937526] BUG: KASAN: null-ptr-deref in _raw_spin_lock+0x66/0xc0
[  522.967659] Workqueue: events_unbound amdgpu_devcoredump_deferred_work [amdgpu]

...

[  522.969445] Call Trace:
[  522.969508]  _raw_spin_lock+0x66/0xc0
[  522.969518]  ? __pfx__raw_spin_lock+0x10/0x10
[  522.969534]  amdgpu_discovery_dump+0x61/0x530 [amdgpu]
[  522.971346]  ? pick_next_task_fair+0x3f6/0x1c60
[  522.971363]  amdgpu_devcoredump_format+0x84f/0x26f0 [amdgpu]
[  522.973188]  ? __pfx_amdgpu_devcoredump_format+0x10/0x10 [amdgpu]
[  522.975012]  ? psi_task_switch+0x2b5/0x9b0
[  522.975027]  ? __pfx___drm_printfn_coredump+0x10/0x10 [drm]
[  522.975198]  ? __pfx___drm_puts_coredump+0x10/0x10 [drm]
[  522.975366]  ? __schedule+0x113c/0x38d0
[  522.975381]  amdgpu_devcoredump_deferred_work+0x4c/0x1f0 [amdgpu]

v2: Updated commit message - Clarified that ip_top is not freed, it can
    just be NULL if discovery was not initialized. (Christian/Lijo)

v3: Removed the extra drm_warn() for sysfs init failure as sysfs already
    reports errors. (Christian)

Fixes: 7083eb8982fb ("drm/amdgpu: include ip discovery data in devcoredump")
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index f7f37d93d0ce..6be1f971a31a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1395,6 +1395,9 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
 	struct list_head *el, *tmp;
 	struct kset *die_kset;
 
+	if (!ip_top)
+		return;
+
 	die_kset = &ip_top->die_kset;
 	spin_lock(&die_kset->list_lock);
 	list_for_each_prev_safe(el, tmp, &die_kset->list) {
@@ -1419,9 +1422,15 @@ void amdgpu_discovery_dump(struct amdgpu_device *adev, struct drm_printer *p)
 	struct ip_hw_instance *ip_inst;
 	int i = 0, j;
 
+	drm_printf(p, "\nHW IP Discovery\n");
+
+	if (!ip_top) {
+		drm_printf(p, "ip discovery topology unavailable\n");
+		return;
+	}
+
 	die_kset = &ip_top->die_kset;
 
-	drm_printf(p, "\nHW IP Discovery\n");
 	spin_lock(&die_kset->list_lock);
 	list_for_each(el_die, &die_kset->list) {
 		drm_printf(p, "die %d\n", i++);
-- 
2.34.1

