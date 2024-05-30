Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A84C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 21:49:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0097A10E0AB;
	Thu, 30 May 2024 21:49:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E0yRvaPW";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 963261134D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 21:48:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSatVklBVlDgO+GsNYz7W+7f+KNLTvMTDboVCcJI9Btnh5Ya+uwFOnvgseLowOrQSwVoiXLy4VSMgnFw7vY3FRXAEwaFlHVrv8cP/07t3Xz09YFeYoglfNBd/LmmvQL/U0aYt0IT9JLH9MKqy1VyZ9YIK3uCrV+4HXr4tDx7XYXTENHVa0a7RQszMCSf/lcpj5hTKcy9I0u5ay5U8ZYCOxqQfxpvVoexyjomZMSjZfGEn0XcnmUSZPROH4hnnnH5k2DKXr2mQGUGpIkY7HpDaZOky/W81al/yzksNVvuSH0WA0H5VueKAO7d8Mpf2eL+45WZHNnh4aay8qrd8i4RRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4NBV5fpByUIGom/8Vat+hgt32hlORkijOpUfTZP72U=;
 b=HJHwRwY/9d0Sd3CpNXMtyc9WvH4L1qkDHW4ueAshPJowyHPmza3yyUICCp+84MEdsXc3knojGR9rzfFqYAjA0BjRbEZTLcSNrDBFXB/QfIEbJbuDmPabrLRCsbG7xKCD6vmwxF75Y9cL0+YycmzaxULixBI9zzhaPhmo/GnL5NigE9EG4dYQp7Z5aM2lBnfzLF7wF39VDwDN+6dbJbaVcVS5fmSztxo6bQ/td1/TEzgDo/bV0Q1SXVJWIfJH1siT6alcXSHvt9tlHwXazBmRbYsl0DOH25y2Qsw6HUC866hwmxwaLek2kEjjYhX17MSvibTbgzJll/n9+TWa8KwgFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4NBV5fpByUIGom/8Vat+hgt32hlORkijOpUfTZP72U=;
 b=E0yRvaPW6PZfg4LU2nQZ4MZoOCw9XbhKN5AhuvnJLtlSwBOOLIARuUc+j3VQRFqdiOIU61vYJe2Brmx6X8ZxPTzapQ1ZgCpKrdGKkGFfUQ893/ouvWFIqEtUvth9JR1YY2hwNXUbEcwf6YLsBAaCiPMPbyA+7bRf0Ij+MUZgrQM=
Received: from SA0PR11CA0134.namprd11.prod.outlook.com (2603:10b6:806:131::19)
 by SA0PR12MB4464.namprd12.prod.outlook.com (2603:10b6:806:9f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 21:48:29 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::3c) by SA0PR11CA0134.outlook.office365.com
 (2603:10b6:806:131::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Thu, 30 May 2024 21:48:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 21:48:29 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 16:48:24 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>, <haijun.chang@amd.com>, <emily.deng@amd.com>
Subject: [PATCH v3 2/8] drm/amdgpu: fix sriov host flr handler
Date: Thu, 30 May 2024 17:47:59 -0400
Message-ID: <20240530214805.40970-3-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530214805.40970-1-Yunxiang.Li@amd.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240530214805.40970-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|SA0PR12MB4464:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ecb736f-8183-4e8d-1816-08dc80f23e22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bdh7/qdtxpjjjQFL1J9WKU0g7JTnxRZhswF50LdfYhsbcbm3Lh0pH2iKwrKz?=
 =?us-ascii?Q?ewPCBQxXJ7r/mVdxBe4+YgNy/ZAHbjuy2gK7MVlpTj9RNxs6KSfQ95uGHd42?=
 =?us-ascii?Q?SJgs1kEy43b4poSVfYqU56bqVNGwHtpB2/4I4ByTp3n4y40xRniYFqhcPA8S?=
 =?us-ascii?Q?GNrwsI6zsyX4RUiatEzeYnHXLGNiuJLOCyHRbTaQ/vLNYxl2kTiqafXbVmO4?=
 =?us-ascii?Q?4NAiFHuVUtwAXLenz0+zHYJhunaN7wzaUOGmNX6MP1qz21H5V1hN9Lm2fJXU?=
 =?us-ascii?Q?PDeX2YRFZ3690p7WPGWW6ngm1Vt7q9+oYJYZ5n1cMKkfeB1LkpspKiZ4/EHn?=
 =?us-ascii?Q?CU708ihgfb0qHeapsQE9V1qfFQkaNQLP+WsC5ACHFdfZ5NdKxY9IBP8ixa+B?=
 =?us-ascii?Q?hZssEBbqtzxWnUSwp9Wo5AGAQnEQ5DbpoPV4EW7KxEsrWDyyPdNgtmjlh9uH?=
 =?us-ascii?Q?srcMQ/akfZi8W2pmV0cLwin9TIakLzJCzXN7lMZS0BwXntIb84zwdxf20mz1?=
 =?us-ascii?Q?ryPd0biUO/Hl/OuDAK4lGmMRIWigVOX1B4Mr6A4ToDktzfMhpDswO85vOojp?=
 =?us-ascii?Q?vP/sYr+I6KcjtVWgDWBR3PodSRK0TLrDfiE1EIad9/0DMu9ssdo0IQIcRyS2?=
 =?us-ascii?Q?MY9UQzdK5K8xmS1MKbgQs2QzONNV6587E0bUL66MimgemgKM2UV8hdUnJORk?=
 =?us-ascii?Q?qU2eGnVP/oxSoSMDZ1kF16VzlQ2fOHWEpwFfH6prnDRd+drvH16PGnVVSIie?=
 =?us-ascii?Q?CrL2dthLaI+4eqy6Q1soKQ/4bbTFXtohHo8X+GKfZ+NhoOId9ENfyaIqzsYc?=
 =?us-ascii?Q?NNAZtS5UL9tLIlClGrQksG1RWqo91sp3PDN+VWYuzvwfIFUD3NTUVuniIRBE?=
 =?us-ascii?Q?g1eDVS3hgJr1TrapIiNoJCgzWNC+beW6tSM41UxJ/WcIFlPW2RH8KMd6/ipg?=
 =?us-ascii?Q?SgogLoehuknVhbrMwD0hSj7uRBP+3rF5IyCwCxBnW0evGdatUo+l6aeQefJP?=
 =?us-ascii?Q?m8gEnzV0nN3Y6gRlja8tP1AavvYFYjMsct7Kt20RKLUzR7UEcac8FgK5uCTG?=
 =?us-ascii?Q?l5SQ7L3rdt8KhWZJ3BcBfVSPlqb4KsTRrvB2EhyISA9Fkh6jDHSZITaFi8nY?=
 =?us-ascii?Q?44h79qMN6NRF87sgfZF+R2aF2Co+n8REyEEgIRDwI625tB/E7pi847VslXli?=
 =?us-ascii?Q?lRwxeodlI5lmUcWRyT9tWVV+ENJzM0MON2/F2eb9Ij/04d21y/32H2Xi04hO?=
 =?us-ascii?Q?EswVKXxYXI4cPET0SocKWB/htDoYGf1PCEgKPAw24LovraXURuBQgdrmN1Ae?=
 =?us-ascii?Q?yg6+kW5lVNID4WX9BKxd4n3O8GBlaeVxtoX8UVa3VPP4F2GJ6/BE1xk4bqQw?=
 =?us-ascii?Q?5YQdB+DaVaYbhO3Ob2ZudKvIVHrN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 21:48:29.2005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ecb736f-8183-4e8d-1816-08dc80f23e22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4464
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

We send back the ready to reset message before we stop anything. This is
wrong. Move it to when we are actually ready for the FLR to happen.

In the current state since we take tens of seconds to stop everything,
it is very likely that host would give up waiting and reset the GPU
before we send ready, so it would be the same as before. But this gets
rid of the hack with reset_domain locking and also let us know how slow
the reset actually is on the host. The pre-reset speed can thus be
improved later.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
v3: still call amdgpu_virt_fini_data_exchange right away, it could take
    awhile for the reset to grab it's lock and call this function in
    pre_reset so during this time the thread will read garbage.

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 14 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  2 ++
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      | 39 +++++++++-------------
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      | 39 +++++++++-------------
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  6 ----
 6 files changed, 50 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bf1a6593dc5e..eb77b4ec3cb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5069,6 +5069,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	struct amdgpu_hive_info *hive = NULL;
 
 	if (test_bit(AMDGPU_HOST_FLR, &reset_context->flags)) {
+		amdgpu_virt_ready_to_reset(adev);
+		amdgpu_virt_wait_reset(adev);
 		clear_bit(AMDGPU_HOST_FLR, &reset_context->flags);
 		r = amdgpu_virt_request_full_gpu(adev, true);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 3cf8416f8cb0..44450507c140 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -152,6 +152,20 @@ void amdgpu_virt_request_init_data(struct amdgpu_device *adev)
 		DRM_WARN("host doesn't support REQ_INIT_DATA handshake\n");
 }
 
+/**
+ * amdgpu_virt_ready_to_reset() - send ready to reset to host
+ * @adev:	amdgpu device.
+ * Send ready to reset message to GPU hypervisor to signal we have stopped GPU
+ * activity and is ready for host FLR
+ */
+void amdgpu_virt_ready_to_reset(struct amdgpu_device *adev)
+{
+	struct amdgpu_virt *virt = &adev->virt;
+
+	if (virt->ops && virt->ops->reset_gpu)
+		virt->ops->ready_to_reset(adev);
+}
+
 /**
  * amdgpu_virt_wait_reset() - wait for reset gpu completed
  * @adev:	amdgpu device.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 642f1fd287d8..66de5380d9a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -88,6 +88,7 @@ struct amdgpu_virt_ops {
 	int (*rel_full_gpu)(struct amdgpu_device *adev, bool init);
 	int (*req_init_data)(struct amdgpu_device *adev);
 	int (*reset_gpu)(struct amdgpu_device *adev);
+	void (*ready_to_reset)(struct amdgpu_device *adev);
 	int (*wait_reset)(struct amdgpu_device *adev);
 	void (*trans_msg)(struct amdgpu_device *adev, enum idh_request req,
 			  u32 data1, u32 data2, u32 data3);
@@ -345,6 +346,7 @@ int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);
 int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init);
 int amdgpu_virt_reset_gpu(struct amdgpu_device *adev);
 void amdgpu_virt_request_init_data(struct amdgpu_device *adev);
+void amdgpu_virt_ready_to_reset(struct amdgpu_device *adev);
 int amdgpu_virt_wait_reset(struct amdgpu_device *adev);
 int amdgpu_virt_alloc_mm_table(struct amdgpu_device *adev);
 void amdgpu_virt_free_mm_table(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index f4c47492e0cd..6b71ee85ee65 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -249,38 +249,30 @@ static int xgpu_ai_set_mailbox_ack_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
+static void xgpu_ai_ready_to_reset(struct amdgpu_device *adev)
 {
-	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
-	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
-	int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
-
-	/* block amdgpu_gpu_recover till msg FLR COMPLETE received,
-	 * otherwise the mailbox msg will be ruined/reseted by
-	 * the VF FLR.
-	 */
-	if (atomic_cmpxchg(&adev->reset_domain->in_gpu_reset, 0, 1) != 0)
-		return;
-
-	down_write(&adev->reset_domain->sem);
-
-	amdgpu_virt_fini_data_exchange(adev);
-
 	xgpu_ai_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
+}
 
+static int xgpu_ai_wait_reset(struct amdgpu_device *adev)
+{
+	int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
 	do {
 		if (xgpu_ai_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL)
-			goto flr_done;
-
+			return 0;
 		msleep(10);
 		timeout -= 10;
 	} while (timeout > 1);
-
 	dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL timeout\n");
+	return -ETIME;
+}
 
-flr_done:
-	atomic_set(&adev->reset_domain->in_gpu_reset, 0);
-	up_write(&adev->reset_domain->sem);
+static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
+{
+	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
+	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
+
+	amdgpu_virt_fini_data_exchange(adev);
 
 	/* Trigger recovery for world switch failure if no TDR */
 	if (amdgpu_device_should_recover_gpu(adev)
@@ -417,7 +409,8 @@ const struct amdgpu_virt_ops xgpu_ai_virt_ops = {
 	.req_full_gpu	= xgpu_ai_request_full_gpu_access,
 	.rel_full_gpu	= xgpu_ai_release_full_gpu_access,
 	.reset_gpu = xgpu_ai_request_reset,
-	.wait_reset = NULL,
+	.ready_to_reset = xgpu_ai_ready_to_reset,
+	.wait_reset = xgpu_ai_wait_reset,
 	.trans_msg = xgpu_ai_mailbox_trans_msg,
 	.req_init_data  = xgpu_ai_request_init_data,
 	.ras_poison_handler = xgpu_ai_ras_poison_handler,
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 37b49a5ed2a1..22af30a15a5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -282,38 +282,30 @@ static int xgpu_nv_set_mailbox_ack_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
+static void xgpu_nv_ready_to_reset(struct amdgpu_device *adev)
 {
-	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
-	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
-	int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
-
-	/* block amdgpu_gpu_recover till msg FLR COMPLETE received,
-	 * otherwise the mailbox msg will be ruined/reseted by
-	 * the VF FLR.
-	 */
-	if (atomic_cmpxchg(&adev->reset_domain->in_gpu_reset, 0, 1) != 0)
-		return;
-
-	down_write(&adev->reset_domain->sem);
-
-	amdgpu_virt_fini_data_exchange(adev);
-
 	xgpu_nv_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
+}
 
+static int xgpu_nv_wait_reset(struct amdgpu_device *adev)
+{
+	int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
 	do {
 		if (xgpu_nv_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL)
-			goto flr_done;
-
+			return 0;
 		msleep(10);
 		timeout -= 10;
 	} while (timeout > 1);
-
 	dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL timeout\n");
+	return -ETIME;
+}
 
-flr_done:
-	atomic_set(&adev->reset_domain->in_gpu_reset, 0);
-	up_write(&adev->reset_domain->sem);
+static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
+{
+	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
+	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
+
+	amdgpu_virt_fini_data_exchange(adev);
 
 	/* Trigger recovery for world switch failure if no TDR */
 	if (amdgpu_device_should_recover_gpu(adev)
@@ -455,7 +447,8 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
 	.rel_full_gpu	= xgpu_nv_release_full_gpu_access,
 	.req_init_data  = xgpu_nv_request_init_data,
 	.reset_gpu = xgpu_nv_request_reset,
-	.wait_reset = NULL,
+	.ready_to_reset = xgpu_nv_ready_to_reset,
+	.wait_reset = xgpu_nv_wait_reset,
 	.trans_msg = xgpu_nv_mailbox_trans_msg,
 	.ras_poison_handler = xgpu_nv_ras_poison_handler,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index 78cd07744ebe..e1d63bed84bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -515,12 +515,6 @@ static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
 	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
 	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 
-	/* wait until RCV_MSG become 3 */
-	if (xgpu_vi_poll_msg(adev, IDH_FLR_NOTIFICATION_CMPL)) {
-		pr_err("failed to receive FLR_CMPL\n");
-		return;
-	}
-
 	/* Trigger recovery due to world switch failure */
 	if (amdgpu_device_should_recover_gpu(adev)) {
 		struct amdgpu_reset_context reset_context;
-- 
2.34.1

