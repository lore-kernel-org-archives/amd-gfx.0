Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74B5FCD0A7
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 04:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA32210E03A;
	Wed, 18 Mar 2026 04:49:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P7KGhBeU";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010026.outbound.protection.outlook.com [52.101.85.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A7F010E03A
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 04:49:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJl0VgQxncYt/s07A93Gh23yO0bOEmpTb9XyclzPYfIt8JaJs5BztGYABFd4QXoujeNjigGxfBW3O27ZOHvtbRJ+bsZnX7UBCGrFLJTV6lCylS4xVFKYYe2Jks6FOxq8fgWjLQtfVCEJpZwe77hXYe0CK6BRJ0PwRCgJ7wCNqKPRigeVIMsSznbnFW/dL85ROAEA15pNfhvaFHQd6qWpBkptLNnmSQgxwGyde2yTt5266dvANggr8rWnLs21+olSWSXx3WzMJwgst5LUQJzX9TGsBTYpd9IPbUx9MDIqOPuZ8RH/Cpe5KmpBZPkDs4gsHOiz1lVILZ0x4rudHX83qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWvMUIYaIRX8LJT1eisCtveBHZDjQlpYKpDsTRqYcM0=;
 b=kulR+Bmi9ygyELEU1U/UGpt5v196hlzP8OCty4w6n1uwWJjV80Q9JWrCGdfFCS9WQUChzKgLIonIEvLAamu/HWeX09zsJpP7RPLcI70+54hgyrX3sQo/SgNl7Uj+/FktyRGkK+5ijCXi4NDOY8361vCkAVevVZs1mDPq8/6XWGnnBHYmoOjgWDmbaZvl92pYlNhTyw4tkVimnEr2hElVAJ8iQKJoj+2Kzitt0G8ZV80F9Qsx7lHDCkhwXjEkTBdNI3fAocaBVO3XjsDgBjwItLjQ0eyRYwE3rVw1jK95ogKIT14JkzDoSWqcbPN0i3pMtJrAgI/wLPTKVLLjEvmupw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWvMUIYaIRX8LJT1eisCtveBHZDjQlpYKpDsTRqYcM0=;
 b=P7KGhBeUQ2Yk01zBjMKpLPnD5Ih+PwnySS78EkUjrxAzUxDqHdy4xdgolIm7wi82X6DOUPfp2a9dg12q1x+eHcMnyD9bo8ngCdVsQZetyXfUytZofsWXv9WsEuwb2vYFh0nhKKGzyz7iI+0WFTuh67lHk0B+nqgfCurHm85/tus=
Received: from SJ0PR13CA0030.namprd13.prod.outlook.com (2603:10b6:a03:2c0::35)
 by LV2PR12MB999098.namprd12.prod.outlook.com (2603:10b6:408:353::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 04:47:53 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::b0) by SJ0PR13CA0030.outlook.office365.com
 (2603:10b6:a03:2c0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Wed,
 18 Mar 2026 04:47:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 04:47:52 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 17 Mar 2026 23:47:50 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH] drm/amdgpu: Avoid NULL dereference in discovery topology
 coredump path
Date: Wed, 18 Mar 2026 10:17:34 +0530
Message-ID: <20260318044734.1975271-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|LV2PR12MB999098:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c541b5-99bb-496e-ea5b-08de84a9837c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: gfF7IF3kZhNbzxjf+IQiwXG8USCSfx6Et+l1EwoESexQt9cHAORwlVYi7yDZONMOeff3EVEflDAh6V301UW3L9Lr5QvQTJ3rgggDw2CWpZkRnuCrpsuqwF9YPFncZ8cx9lO56jyzdCY+vKpayyR9Yhky74D0k5qO3byt9uFWk3EZIbB9wdGCjbMA40KXqvj56lQl7/RlU4FsLlVpj9RC7mg0q70FBlhmrXGGNSmz1z06582VmT9CJgh1xnlndVSc/+f6r0nkZyJyuLjerZtYdziH1cyZW9Mijg0WRJ3dzj8UF4K913QYRBlRibRjaTRTxXAkR0QhDa8R4UuKWxoBC+SXrsi5k5B2J1yGubOsA0jSo7fHvrKzKuPJw+W706U9IQudWpvj/q0lzCCHLrZRJ550KYu8mC3Rl8O3BTD/HxsyMLzLEPqndlhIp1VTCapLHcif/nQrR3eUNPeEU8fE++mqcACNXup08YEKvMYDvubwQXlEzJTbGS8nSkcOT/ILb0RWCP+GKjmHTZ9uDYrU+nJ7+AV5UVHv98Kz8VGE+z27JybWaVkR00txyC7uc87EJOT4Yc4wo+gJ1tqrC3T10vUOj4sFPH2DtoERBVOHWiPUuRqgaVDSEe3PHEuE1EUYC9hIHZ2g/Ifue8D9bEwBcLeBlN+9fPY62lHRSxBLCJcwbzZ+X/IRI9TXmjotLpdprkMxPNyMtk2grn5qvhtgLGosduaw6AqP8hXxZpOCKGqrrMvACXqpNzCJhqY/MCscAgUEMF9eIpWOZ3dxLZuSkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GF0JMuVUQVY+/N2LffNHSpLBYSraCMEypEQq+pMrRO/FFB7Y4gx7Qex/dmC9Mxfa4sbf9WrPBWuoqfqaoH/pXHQiUbmq+QCsaOXIJvsWOeVYzHLBM6sFlYmG1eB+pgENpeE2uBkAkE3chVk2VW2FjJhBTAgT2ozOPY3BWS9QtUe2wBMcy6PtVD09jC/Xw5X6AZZh3eZKHSe5sQ6m4sC2ziCdfBdUDYR2zmzhvnwCgSk9quBCq08XMGVDlI6mTIO6HMufG64ChCm/vpk3VtmNlLoAt3F8Vmn2LLYUlsapfllMkvU1jAiH4YUZ+Hb0Y69oJOxD8qNmseUNTg1PvCNOk70HQneuUS2GvcBI4L4mOnXcVtl8iO286zSbxh1jShgz46U5zuYZwrbAyNr8+YDtMcLOonaNHmOnLrPZZZb0vSsCTBV+wyNKiE815jWAbgq3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 04:47:52.2152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c541b5-99bb-496e-ea5b-08de84a9837c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999098
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

However, ip_top is not guaranteed to always be present.

ip_top is allocated separately in amdgpu_discovery_sysfs_init(),
and it is explicitly set to NULL in ip_disc_release() during cleanup.
At the same time, devcoredump generation runs asynchronously in a
workqueue. This means the dump code can run after ip_top has already
been freed or was never created.

The current code does not check for this and directly uses ip_top.
So when ip_top is NULL, it crashes while taking the spinlock:

  spin_lock(&ip_top->die_kset.list_lock)

This leads to a NULL pointer dereference in the coredump worker.

Fix this by adding a NULL check for ip_top before using it.

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

