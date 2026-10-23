Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6056606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=34UesaoN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 748C2112A36;
	Fri, 23 Oct 2026 08:34:54 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FC3810E5BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 08:34:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9hiaTDFLjA40ydMjWC1IUvnoRX83fTYJWrLnuC2powhAsUEWnUlfy2s97VvuXLK6HwatoPp1AjhbrRkE5hhfOG+cttD8doCmuz7S9UBSv+4O95rc5s8lvlA8qyQeSa0ai9S2LkhCn55eLcEjzPYGmg6FNnoWZgBbJfD23v82QbZoLcqOKdIx4i/o8TRP+UFF6b9oKXLqBxAU0h3ZQ3YVxpMi6VdVcSlg4VNC9rEbTUD/ihLM1Rs+hWjlmPeVssiLXfVCqBmkXkTekX+sepok55VEQMZ9HrJJjMHe8sFJocVG3qA4GY9do5PFdpk5euzLFsZJFcSf7/hBaprX+QFiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlZHgXV+MLN1qZAZzEYX0PfblwPuoICEqg+vjt4P1Zw=;
 b=GzgMr31Ls9CkMcEmQ8fjFKgbSJrxTMC+EIDMPn1+KbyAY9L3UmQxZdtpbcgZ7Svz9GXeT5/3A9dhUepOJy1swTH2H0b/WkNRYa0T89XyeTstc5Py48zj+PcC9iasQVtYwgD07B5Ux62E6ah5++CddL9c0xkdABpGlDRTXlfGD6anJVL1Gflwn3/ez+/uXGlY3YygmqdTvBT4VfJeSPqoAbiJUmeoL4wVaTmlu0sQi12rZaHRGjw4UfHsneBm4xNTI5rtmP9L/1ZIMAb/lFOeW5jKQR+DVby+C5YXkbbD3aNpdHQ0F3Cfuk3iLSFtBpWVtDwKtmcRjTdTiEZYs58XaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlZHgXV+MLN1qZAZzEYX0PfblwPuoICEqg+vjt4P1Zw=;
 b=34UesaoNHHxrofIEh60zq+k0efZSX2JClm7Hq7FM4N38rvKo7ELnzCGtvQNS3mn/gLNJJ7AWdPKrQz9ZUxQadgXrQcCbZCSwXHk2jS2gU8ltUt62BTmUxnDfm7FUnL/iTcjdX6Jap1k9+GmTnTnA/TldTX2USzKM0X/pJHN+Ve8=
Received: from BY3PR05CA0013.namprd05.prod.outlook.com (2603:10b6:a03:254::18)
 by CYXPR12MB9317.namprd12.prod.outlook.com (2603:10b6:930:e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 08:34:42 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::15) by BY3PR05CA0013.outlook.office365.com
 (2603:10b6:a03:254::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.3 via Frontend Transport; Fri, 23
 Oct 2026 08:34:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 08:34:42 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 03:34:40 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait for the JPEG/VCN idle
 work
Date: Fri, 23 Oct 2026 16:34:19 +0800
Message-ID: <20261023083422.3049246-5-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023083422.3049246-1-Prike.Liang@amd.com>
References: <20261023083422.3049246-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|CYXPR12MB9317:EE_
X-MS-Office365-Filtering-Correlation-Id: 7979eee2-f97f-4a34-363a-08df30e07c68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|260925022911599003|260925021911599003|260925021311599003|56012099006|5023799004|11063799006|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223327099003|261009223027099003|261009221227099003|261009220027099003|261009221727099003|10067099003|18002099003|22082099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: +qP1F/zgUXq4ZUcT2bCdUpNLgh8euTTNjK3SKZA1UUQSee61ucvHeG58jtxyD6z9J9h5U66EG4JsBGHVxDev/ITUQa0HFs98NM1LqqVQtdLZBmshfFspzbWVFejXNysBwNvbDMmQFt2flT9PxepFupfLlJckftWN+kCV3ZZLtV0xkjkxZs/Z22YeJkMBVYNyAe5pdv/wqP6aG0q9j1gBF0rzw72j1PH0aIdMDmaVCxcJKDpzxGH2WKpU/JgsY7ks6Wed/9GTaKBqIWhSCfsumd41GpPkLybq3VFHauYajrXjEhfIMxGE/861sbmk6UODtMrFXrdfAWvUlE58/6rGTpd7edrlmYmAut6V/Z5VZ8iaeRjoYKSheaQf6kVJxuyqGOqrgHmc2j3sTWZtyC9UvTCG1FH9SETjzoxBpiD8hYiS/Mcdu1AjJxk1Sdq55EuZc8tgUL1yA/huVxPy4B0v3FqUxA0ZlDtO4vX9D3bzDmaVLNM4CFFPtlPZ9vRI0rz9Crd9i5IJRBJC2t49IJXlJ5Hg3geiiOc/2SzwiKwiVVacdntnb+EViGXB2sQ/S1yJnBYw+0skD6ZR4dGtKBXOg8xyybbccasTh/veX7tLf6oMJZouDkjIdmTvoYHqZMj69gvAwHcCwR9MQgzZeNAFMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(5023799004)(11063799006)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223327099003)(261009223027099003)(261009221227099003)(261009220027099003)(261009221727099003)(10067099003)(18002099003)(22082099003)(6133799003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5yRb64bb1ZMxrDz6v/4v3/N3qG6wIATEdrv0rBeUUFlae2Pipe7qf3rA+2VfFe783vxEqo4czFPifEFGS2LuxlaKUR7tQ88901L6ODaX72yx1XSoIKpMG/VmUF0VoCaFD9rtiY4BDbu5JXVK0C1mF9zzmZ0C802Wdf9CimszDfUpHTSNMs+ajkbvBuWG8avQ80e+fumYxv5z/oBMcBEXSlym0Rdn2oDn668i1f13QFqST4OYAMVlLe8tSYBiyapHY9L6VyfmfRwm5QbgwPcEwwpUWyNnYew81q4u+sdS1JCl0IhdeLNECuA5gbM47ZY0uuf/DauJo7FZ875ZHi4Rpy1ep9OZfqR8m1fIgVtyJxlARpGnveXNOXAEW7GOXLO698h2eZQCTCuWaulat5N2qCw+TkDSjUcmY5S1NWYGjHRpjqk/hxxJW6Ow+gSaSeDf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 08:34:42.7184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7979eee2-f97f-4a34-363a-08df30e07c68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9317
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The common JPEG and VCN idle workers program power gating and DPG pause,
so they must not run while a GPU reset is in progress. Recovery must not
wait for them either, since everything the workers depend on then
becomes a dependency of GPU recovery.

Make the workers take reset_domain->sem for read, so they wait for a
running reset instead of touching the hardware. hw_fini/suspend and
begin_use, the latter for the IB tests, run from GPU recovery as well,
so only skip waiting for the idle work when the reset itself calls them.
The reset holds the semaphore for write and would otherwise deadlock on
a worker blocked on it. Outside a reset the cancel stays synchronous as
before. sw_fini always cancels synchronously, it never runs with the
reset semaphore held.

Update versions: https://lore.kernel.org/amd-gfx/PH7PR12MB6000698A62D208E47BB358D7FB662@
PH7PR12MB6000.namprd12.prod.outlook.com/

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 20 ++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 18 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  |  2 +-
 23 files changed, 58 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 87f879a2e4f4..2bddef322870 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -74,6 +74,8 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
 {
 	int i, j;
 
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1U << i))
 			continue;
@@ -95,9 +97,18 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
 	return 0;
 }
 
+static void amdgpu_jpeg_cancel_idle_work(struct amdgpu_device *adev)
+{
+	/* The reset mustn't wait for the idle work, which waits for the reset */
+	if (amdgpu_in_reset(adev))
+		cancel_delayed_work(&adev->jpeg.idle_work);
+	else
+		cancel_delayed_work_sync(&adev->jpeg.idle_work);
+}
+
 int amdgpu_jpeg_suspend(struct amdgpu_device *adev)
 {
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_cancel_idle_work(adev);
 
 	return 0;
 }
@@ -114,6 +125,9 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
 	unsigned int fences = 0;
 	unsigned int i, j;
 
+	/* Nothing holding the reset semaphore waits for this work */
+	down_read(&adev->reset_domain->sem);
+
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1U << i))
 			continue;
@@ -129,6 +143,8 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
 		mutex_unlock(&adev->jpeg.jpeg_pg_lock);
 	} else
 		schedule_delayed_work(&adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
+
+	up_read(&adev->reset_domain->sem);
 }
 
 void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
@@ -136,7 +152,7 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (!atomic_fetch_inc(&adev->jpeg.total_submission_cnt))
-		cancel_delayed_work_sync(&adev->jpeg.idle_work);
+		amdgpu_jpeg_cancel_idle_work(adev);
 
 	mutex_lock(&adev->jpeg.jpeg_pg_lock);
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 34e1242d66ea..631f9471be1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -269,6 +269,8 @@ void amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i)
 	if (adev->vcn.harvest_config & (1 << i))
 		return;
 
+	cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+
 	amdgpu_bo_free_kernel(
 		&adev->vcn.inst[i].dpg_sram_bo,
 		&adev->vcn.inst[i].dpg_sram_gpu_addr,
@@ -459,6 +461,15 @@ void amdgpu_vcn_put_profile(struct amdgpu_device *adev)
 	mutex_unlock(&adev->vcn.workload_profile_mutex);
 }
 
+void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst *vcn_inst)
+{
+	/* The reset mustn't wait for the idle work, which waits for the reset */
+	if (amdgpu_in_reset(vcn_inst->adev))
+		cancel_delayed_work(&vcn_inst->idle_work);
+	else
+		cancel_delayed_work_sync(&vcn_inst->idle_work);
+}
+
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 {
 	struct amdgpu_vcn_inst *vcn_inst =
@@ -470,6 +481,9 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	if (adev->vcn.harvest_config & (1 << i))
 		return;
 
+	/* Nothing holding the reset semaphore waits for this work */
+	down_read(&adev->reset_domain->sem);
+
 	for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
 		fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
 
@@ -499,6 +513,8 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	} else {
 		schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
 	}
+
+	up_read(&adev->reset_domain->sem);
 }
 
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
@@ -507,7 +523,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	struct amdgpu_vcn_inst *vcn_inst = &adev->vcn.inst[ring->me];
 
 	if (!atomic_fetch_inc(&vcn_inst->total_submission_cnt))
-		cancel_delayed_work_sync(&vcn_inst->idle_work);
+		amdgpu_vcn_cancel_idle_work(vcn_inst);
 
 	mutex_lock(&vcn_inst->vcn_pg_lock);
 	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index bea95307fd42..a6438950854e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -526,6 +526,7 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev, int i);
 int amdgpu_vcn_resume(struct amdgpu_device *adev, int i);
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
+void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst *vcn_inst);
 
 bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev,
 				enum vcn_ring_type type, uint32_t vcn_instance);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 72069b77f6f1..b048fd4b8b59 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -177,7 +177,7 @@ static int jpeg_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 2968256d4cd7..f6a9258ae3ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -239,7 +239,7 @@ static int jpeg_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 564e40899df2..922711aa06a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -192,7 +192,7 @@ static int jpeg_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index b29ca3a49939..fe7ab9cb35bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -221,7 +221,7 @@ static int jpeg_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 	if (!amdgpu_sriov_vf(adev)) {
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 			RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 0343a64595f2..f4896ad9d1de 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -455,7 +455,7 @@ static int jpeg_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	if (!amdgpu_sriov_vf(adev)) {
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 4da3f9c995c1..87efc3c2b9e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -250,7 +250,7 @@ static int jpeg_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index dcdb089b4308..91968ad26f17 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -189,7 +189,7 @@ static int jpeg_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index f2debf6b6bd0..27116d1e9e64 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -326,7 +326,7 @@ static int jpeg_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	if (!amdgpu_sriov_vf(adev)) {
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
index dd0abce73687..7e068c2d4d6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
@@ -299,7 +299,7 @@ static int jpeg_v5_0_2_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	if (!amdgpu_sriov_vf(adev)) {
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
index 8ddd12740a04..16daeb61114c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
@@ -172,7 +172,7 @@ static int jpeg_v5_3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_suspend(adev);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 76793a5caa70..470d8f110799 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -150,8 +150,8 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	/* Override the work func */
-	adev->vcn.inst[0].idle_work.work.func = vcn_v1_0_idle_work_handler;
+	/* Own lockdep class, this work is still cancelled synchronously */
+	INIT_DELAYED_WORK(&adev->vcn.inst[0].idle_work, vcn_v1_0_idle_work_handler);
 
 	amdgpu_vcn_setup_ucode(adev, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 7d2b9e4b913a..ba451f2a2534 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -322,7 +322,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
 
-	cancel_delayed_work_sync(&vinst->idle_work);
+	amdgpu_vcn_cancel_idle_work(vinst);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
 	    (vinst->cur_state != AMD_PG_STATE_GATE &&
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 10ef5616b2f5..9dd4c313cbe7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -304,8 +304,8 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 		if (r)
 			return r;
 
-		/* Override the work func */
-		adev->vcn.inst[j].idle_work.work.func = vcn_v2_5_idle_work_handler;
+		/* Own lockdep class, this work is still cancelled synchronously */
+		INIT_DELAYED_WORK(&adev->vcn.inst[j].idle_work, vcn_v2_5_idle_work_handler);
 
 		amdgpu_vcn_setup_ucode(adev, j);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 0f4f4d66e2e4..3e85abd1e82c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -449,7 +449,7 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		cancel_delayed_work_sync(&vinst->idle_work);
+		amdgpu_vcn_cancel_idle_work(vinst);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 4b7f7bbe18da..5b47a643d725 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -374,7 +374,7 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		cancel_delayed_work_sync(&vinst->idle_work);
+		amdgpu_vcn_cancel_idle_work(vinst);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 3f39aa83c319..5aa09c3bd79b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -417,7 +417,7 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 
-		cancel_delayed_work_sync(&vinst->idle_work);
+		amdgpu_vcn_cancel_idle_work(vinst);
 
 		if (vinst->cur_state != AMD_PG_STATE_GATE)
 			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index f30f80c1b07f..9693950cd16d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -327,7 +327,7 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		cancel_delayed_work_sync(&vinst->idle_work);
+		amdgpu_vcn_cancel_idle_work(vinst);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 7b7c3bc9f046..0c189063a6ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -291,7 +291,7 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		cancel_delayed_work_sync(&vinst->idle_work);
+		amdgpu_vcn_cancel_idle_work(vinst);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index c9e990ab297d..3fa553fb41d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -364,7 +364,7 @@ static int vcn_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 
-		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
 		if (vinst->cur_state != AMD_PG_STATE_GATE)
 			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
index ed47ddd5b08c..eb13f792e25d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
@@ -279,7 +279,7 @@ static int vcn_v5_0_2_hw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 
-		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
 		if (vinst->cur_state != AMD_PG_STATE_GATE)
 			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 	}
-- 
2.34.1

