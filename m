Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C9D10854D9
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 09:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9F8B10E774;
	Wed, 18 Mar 2026 09:23:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QPm37DBS";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011069.outbound.protection.outlook.com
 [40.93.194.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A073D10E774
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 09:23:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2x8wo5PgwKEWO8NhyEOrU5LDBfFmCOpHzuhUr7TUmPO31rmHxnw2wdWo95EoaWv8OP+fYNKIGvq249ddaqYJ7RGwQzLtCCl//bxP1zXg4NyOKLUqCJgMjJxWpcXVMbBYKROSjYh/Ysmul0uVRK2V1BHihWIVemCpzhNxUODJUWJQYmNb1V8jC88tuRbyIAKvFsJ5iOwpw6bW4arlo1ue6UiSl4RPC6WB8aVP7sLlk/IkZ4oH0iQIHKqCzzyZGlBR1k3E80Fei8GKyG8KdonedlCQlOygRC0o3lSsK2TwDlLMGUnWuoFGGwAG9PURS3XdMx0FvuEFtL3DrcMCDy5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnGect/s7fPswCuLHtVDg7MPaDTHDTDA5ymaIeRaxmE=;
 b=BaN8bxjBuivrabjc26W3fmTjnPNy+0VF/nPD5m1GxSbcEc8M5rv9rQCHUynx2jQT8OOVuaGCVYCD2N8Vqy0y0KxFfUI5dNZtglrQs/rNVtNgyVlzTQw31xrvAPoNVyTrejD3kAnOVQtNpJnSToHZJNUYa+2K/AUm/W61mC8MjKISxyM9rCuHF065cB91Fw5PAnlBpSytene+rOhnVELrEBeWDf2BRuTSZMrSkGakz/Wmzy1W0RVCrtdPiOx3DGWs60HRABlrAukZf9eH6KfFAW07R6UHBDyA5LuiJAoSKlVCE7BEVhM6qO1/sljms+RBzPz3Ocl59GPpFi1klbGIsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnGect/s7fPswCuLHtVDg7MPaDTHDTDA5ymaIeRaxmE=;
 b=QPm37DBS1UOC8NOhYrmaGp+bttWN7BM2rTgGDGS436IUClILfz3BITN9GXgEMDrXxUOl7A8kb3zSipbZInM64QbPXp3rLqN7gAULgj8RydslLK9k2VVcSXzP4fGo567nyN9eYYFL/tK83KmXcpS4XHmcNUyzxW+ASq8NqUsPiE0=
Received: from DS7PR03CA0073.namprd03.prod.outlook.com (2603:10b6:5:3bb::18)
 by IA0PR12MB8375.namprd12.prod.outlook.com (2603:10b6:208:3dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 09:23:31 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::f5) by DS7PR03CA0073.outlook.office365.com
 (2603:10b6:5:3bb::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 09:23:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 09:23:30 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 18 Mar 2026 04:23:28 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v2] drm/amdgpu: Avoid NULL dereference in discovery topology
 coredump path v2
Date: Wed, 18 Mar 2026 14:53:14 +0530
Message-ID: <20260318092314.1975879-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|IA0PR12MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: aea2e7a6-052e-43ac-4b1b-08de84d0054e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: SFt5uwHfvCANNeZrOyGjM8ORFWTLsYI7d53R9OdcaBXaF8SdaFYum2CswFgSkFfpZ3WPvXaA+lORPUUdBY7Xc3/ZXHqR2lbQIKb1L4BI3LPpPKwMashraKLtGZOPrecHYM3K70F/VoslPhipUuk1UPOz45RDtOGunOvAcN+F1TH+k5lGC2XoZVLpWsMMQsB6CPzEjrBC+dO1Pe5X0Pv+VNjOXDDHOhIaf2mhrIKHL9qdNgZc9ryO6HaOtCsiKoO51qZDKkBQcA0bU0oUCGa2nqlhUfES/oVQx/HacShysv0LJFK4KD2/oNmZqIPh0wdFOVCgAkaL3tmrR12f8qOTvTrs/lZLaxkmXeNAy1uxCMONGnWsUgxlQa3uz+CrNzisw1E2FIoM22pDXtJP7e8nBWqKvDdmk9DUjmVxkF0K1q3i8h+bEH1331Gp1cS1U+8XhFnGVOlCgz1MdZ5f0j+Z69v6Sx82wz5ajLQ5eVSeyl0sBBSZ6kb3wk8EjkP68DuTfOqDZZ0Jajqx/cA7KXaeAlL9mpYRbtUFX7oY+4iAlHH8Vs+JYWpDu0CBGhdUV1fB8dBU6kR+0V/TmatC0RlJ3+XHRKJcM8pHENOVTy13viiOCoZQO2+pAXX2TWXZ0jsISZ2EKCLuiLO9VEPP0O8qRF5dlraybjjqTWQIb06BQHofoTe2TPvgpa8q2OZ4FapKmln8YzsrPXG3X8CO60Ah+w9+AFS0dQ+L+k8joZTjXNlsrkT0boqmqagkkTt0zpNPP8DiLZih6F8M2VL7Ef12rw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LNbJTkRk0DCtyaf2tT+FMAA4MJ4PNO0mPIn+ZwUz19QE5Tl/gGYIt6yHKj9a9tnFWzumQSitAA7+Ufy7H/0tyVi09VvKr2TSXRZBIBkRXbVkX29ulEzYfVhgVhawSeg+g4hT5SMp1IeItFDKt7RwsJQ+aXzb6X3fh181eaXWo71mSgJc7+Yg1/J5BLxlDVXb1tXl7UoSRhCd6rWAeLMfOnfJuT9Dp2KLQ3RuMQwK75aYmmrhND4IoxnGrb7/EO9b/GYDHpBaudz0taYS6JPFh4T0eLQ13vvGEN4s7Nfm6jEJFA4akMc0pknEo7V8io1bNRBgrRr/I+sGTqMLWvqsFdt23XVTGN1MAtJf3Xe4h3ZOQbaKdXZwaVwqqRgqlpntv2unkZ9Foi34IspvSPutmqOVgbis5yvwhzsf6bNUE3zvVkzYnBBqA9cJe7nUJMtu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 09:23:30.9396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aea2e7a6-052e-43ac-4b1b-08de84d0054e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8375
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

Fixes: 7083eb8982fb ("drm/amdgpu: include ip discovery data in devcoredump")
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index f7f37d93d0ce..40ce95a604ff 100644
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
@@ -3028,7 +3037,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	}
 
 	amdgpu_discovery_init_soc_config(adev);
-	amdgpu_discovery_sysfs_init(adev);
+	r = amdgpu_discovery_sysfs_init(adev);
+	if (r)
+		drm_warn(&adev->ddev,
+			 "ip discovery sysfs init failed: %d\n", r);
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(9, 0, 1):
-- 
2.34.1

