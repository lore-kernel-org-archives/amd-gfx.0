Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025F4E77188
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 19:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8726710E47F;
	Tue, 14 Jan 2025 19:54:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QcaZsSmN";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52DF510E47F
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 19:54:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ek/6t3Cl/Kj7eCGFUbFht7BJ3/xn5qnutHw1NQA3FaVMzacS7ooT0BsQgyvWvQpyvj71Mhe6uCtMOF1SR+EKVfSjsoHPQHZOBmQk5j9FGy+FR7XRculTrwC2ntiIaZpgo2ilczJMtpss2uK1F7r6AEUHA1WGun9L9xdy3zVrkFrnpFcWxgch9fy0lhKrQEFurgXQrDUJXjVWQXXNEA6WgrmLIynkh2APbgbSDFtcIVWkfRwGquBV1DBJDfzVRdCtPSG5OLmOd83PR2HAzEK3o8nqHC6Rcie7QxIBzG7BNG4Y6IUJQkJJGydE9ovCHSZYAQYQrju61zrgXeCA2lEgSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wrj0FuMdrTEY6M2HUrPZqpAMWnHIBr//HnVV53lnjaQ=;
 b=rsWuH669nOeXZSOioUQMww2o6HwMwy76I8jh1WRg+NKCY3kfW4hBMbdtYwhI+OJRZJlICdB40WadPqqk7VjFLJmEsUROE1VTaBkw/h/73FIq1/LsvSxEV9u/UYEF++GjxLw86czF1MrqWBDO3loN8SQ8nZsllJt8LSkR+c9ZtyfoWR3LGZ5vR4esGdEfnheUelaaqlUQtYT0PTCz1Fe1Dgbu9OpGNLlh0Khnvtjv5XFRyAp97KQOd865DxLVz1UwTA2IZQFmQCH0IEY/PBT44i9Ggs6TZ3GotNLr74a/o/OPpb7trg8KI6S/VRaKWfU5CYAI42kby4l5hX/1Jys6QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wrj0FuMdrTEY6M2HUrPZqpAMWnHIBr//HnVV53lnjaQ=;
 b=QcaZsSmNGltpep0wqJS22zedf/oCHc3/IDTfObhZT/vgc/IFJBxcQiSI6LFih+iofNYmRghUA5ZUMduuxQCmB1beaU5vRzxGWmuV1oArm8rLsws+bcvy70Exc+OuwpnmXfqavnrGcrIchCYbf5s/2PlAbBh84kNj+shKsMiwvio=
Received: from MW4PR04CA0155.namprd04.prod.outlook.com (2603:10b6:303:85::10)
 by CH2PR12MB4247.namprd12.prod.outlook.com (2603:10b6:610:7c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 19:53:53 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:303:85:cafe::2c) by MW4PR04CA0155.outlook.office365.com
 (2603:10b6:303:85::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Tue,
 14 Jan 2025 19:53:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 19:53:53 +0000
Received: from elenaOnsiteDevTest.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 14 Jan 2025 13:53:51 -0600
From: Elena Sakhnovitch <Elena.Sakhnovitch@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <elena.sakhnovitch@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Elena Sakhnovitch
 <Elena.Sakhnovitch@amd.com>
Subject: [PATCH 1/3] drm/amdkfd: Use asic specific fn to configure grace period
Date: Tue, 14 Jan 2025 14:52:49 -0500
Message-ID: <20250114195251.42661-1-Elena.Sakhnovitch@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|CH2PR12MB4247:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc1dc7e-acf6-48c7-1726-08dd34d52c46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3TiJk49SiXgQ7iOlSR/GfNpziqeca9d0JKHdjfGg61iRy+v/1VPcGjDFBAhq?=
 =?us-ascii?Q?hA383xPbS6n9fmeXA6YDJyHLUz5zNIE5rs8O6o1NxbZZWXp6mQ9CnJ6Lsjow?=
 =?us-ascii?Q?hIcxe+/yPTKQwryT1BVTuSBWQd/XPDaRwV5KeYlawCrpN51XpoFTmadAbysg?=
 =?us-ascii?Q?Wm86EB/e+j8GgiPQKjWFyoAgb2qydMr/TGqwneb+UiJ6yxJqV2dgrAxwDCY8?=
 =?us-ascii?Q?5OGM+HwS8xYoEK/aXV6NKOphYDh2ODBj3UvejxAv9eT75qnVqKybYUfySmjk?=
 =?us-ascii?Q?kBMJHcewDJRXEIL9XwyEaTTWpFUSOlDF//rNwcnMe+1VBlbDNaQw950ui/fv?=
 =?us-ascii?Q?KuB+Vd8HYil8aHszsv3DN/IrX2VLCEQvK1NIMQFrUgW4rDUabTnpi7Mf1fxq?=
 =?us-ascii?Q?kdalg1quVTokc5o+lIIvgsALGpg6WQ5vbynGz4P51domXmUaU9vKgkFDdI6K?=
 =?us-ascii?Q?h+1Ld4yAntZuhtBy2xQwwjPDb7HGx1a6wGDHKyYJUw00/9u6HrLHLZoGKRs+?=
 =?us-ascii?Q?bMcNCDMPEEoW6unsWHemJfc8nUqdVHBs7c1I23Ue0rRhlZHjBbiEz3IFnapO?=
 =?us-ascii?Q?d5SHSiyGaD5Iav/oO4TR0s6iINCsYDAIA7+6YoBdy0KMsx7rQnw5qSM+e4Be?=
 =?us-ascii?Q?GNWfelxu8xhqw9g/E47n7A13lIGCCfju41iwar6kUj2EJJto9olT+qFcykCb?=
 =?us-ascii?Q?jzzEbzPAnbguYVpxDCRpuTgsgEmqTavCFPSRTF7sPkiiEP4iaYlJh0rZKiq9?=
 =?us-ascii?Q?8wAL5pYK+B4WBker2Bgb8wtQK4qizA/r0W5wrY7ZvDVn94nWdFPueOnAyw5Y?=
 =?us-ascii?Q?0f48xyLLyL5DebW1qjH/B9KaWgKEkYaWcw4K1NJRqt4CxG60rbrPCjGWykUj?=
 =?us-ascii?Q?Wbf3ieWrd8fhZ9xkxf9STYlpLGGSJt7n9Gff1mG9i0Id96J1Pf5JrGIXYlhZ?=
 =?us-ascii?Q?T+6Hb7o64iqLhzjWOKH0DwqHEtxomN2l9IoZuhw/eFrFxY2wxcnqzKb3yPN4?=
 =?us-ascii?Q?ZBcr+qUOTYlyaJCBlHg2VItj7EK9YetUCpob84OEoWdsgTeE+nfS8+VHCQNs?=
 =?us-ascii?Q?iFbaGvyfepLoGUHT9wYGvAlfa5loa2FBZdu9fNYt3QTKa1jPbAAdOLcypPbd?=
 =?us-ascii?Q?zxAVKprNeqn6LSzIC1uyKoWoVD8ljA6mtJ4XKnt3zT5tMUEzavYtuC5XBX+M?=
 =?us-ascii?Q?6bs55rKfp4nJAv7GsU04rL3UucuYOmYSk0xlqq1f7LhxitJewoTg5dK+p2KN?=
 =?us-ascii?Q?/29qTtlwcpjmTX/uu2MuMFnXihC5O+Izy/9JKdjtxZ9jJn31DgFqt9NURJ6z?=
 =?us-ascii?Q?feKXhXsecWlXb7k5yaKvs5xNGZRaB1QIGXLC6rwEcZFYZl2YO9haSGroSniL?=
 =?us-ascii?Q?BWhvbv7Ye4MRxe9Uh5B2KNTAco0NSNZo65HRQVN+mOBWEy0Qgaxm7b7ZYuoG?=
 =?us-ascii?Q?spovdo5rrK5HhleU3Ap6irpyZPy5H+MEKGGI6PLq67s0NoM7ljD6+uOuB6OT?=
 =?us-ascii?Q?FID7e/zyx1j+H8k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 19:53:53.0385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc1dc7e-acf6-48c7-1726-08dd34d52c46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4247
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

From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Currently, grace period is modified only for gfx943 APU. In the future
this might need to be set for other ASICs too. Either ways, asic
specific values should be handled by asic specific functions.

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Elena Sakhnovitch <Elena.Sakhnovitch@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 24 ++++++-------------
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  3 ++-
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  3 +++
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 10 ++++++++
 4 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f157494bfdb1..4369308a74e7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1859,26 +1859,16 @@ static int start_cpsch(struct device_queue_manager *dqm)
 	/* clear hang status when driver try to start the hw scheduler */
 	dqm->sched_running = true;
 
-	if (!dqm->dev->kfd->shared_resources.enable_mes)
+	if (!dqm->dev->kfd->shared_resources.enable_mes) {
 		execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
-
-	/* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
-	if (amdgpu_emu_mode == 0 && dqm->dev->adev->gmc.is_app_apu &&
-	    (KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 3))) {
-		uint32_t reg_offset = 0;
-		uint32_t grace_period = 1;
-
-		retval = pm_update_grace_period(&dqm->packet_mgr,
-						grace_period);
+		retval = pm_update_grace_period(&dqm->packet_mgr, SET_ASIC_OPTIMIZED_GRACE_PERIOD);
 		if (retval)
-			dev_err(dev, "Setting grace timeout failed\n");
-		else if (dqm->dev->kfd2kgd->build_grace_period_packet_info)
-			/* Update dqm->wait_times maintained in software */
-			dqm->dev->kfd2kgd->build_grace_period_packet_info(
-					dqm->dev->adev,	dqm->wait_times,
-					grace_period, &reg_offset,
-					&dqm->wait_times);
+			dev_err(dev, "Setting optimized grace timeout failed\n");
 	}
+	if (dqm->dev->kfd2kgd->get_iq_wait_times)
+		dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
+					&dqm->wait_times,
+					ffs(dqm->dev->xcc_mask) - 1);
 
 	/* setup per-queue reset detection buffer  */
 	num_hw_queue_slots =  dqm->dev->kfd->shared_resources.num_queue_per_pipe *
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 09ab36f8e8c6..fb3419993612 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -37,7 +37,8 @@
 
 #define KFD_MES_PROCESS_QUANTUM		100000
 #define KFD_MES_GANG_QUANTUM		10000
-#define USE_DEFAULT_GRACE_PERIOD 0xffffffff
+#define USE_DEFAULT_GRACE_PERIOD	0xffffffff
+#define SET_ASIC_OPTIMIZED_GRACE_PERIOD	0xfffffffe
 
 struct device_process_node {
 	struct qcm_process_device *qpd;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 4984b41cd372..518c6ec23a75 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -403,6 +403,9 @@ int pm_update_grace_period(struct packet_manager *pm, uint32_t grace_period)
 	int retval = 0;
 	uint32_t *buffer, size;
 
+	if (!pm->pmf->set_grace_period || !pm->pmf->set_grace_period_size)
+		return 0;
+
 	size = pm->pmf->set_grace_period_size;
 
 	mutex_lock(&pm->lock);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index d56525201155..fde212242129 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -302,9 +302,19 @@ static int pm_set_grace_period_v9(struct packet_manager *pm,
 		uint32_t grace_period)
 {
 	struct pm4_mec_write_data_mmio *packet;
+	struct device_queue_manager *dqm = pm->dqm;
 	uint32_t reg_offset = 0;
 	uint32_t reg_data = 0;
 
+	if (grace_period == SET_ASIC_OPTIMIZED_GRACE_PERIOD) {
+		/* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
+		if (amdgpu_emu_mode == 0 && dqm->dev->adev->gmc.is_app_apu &&
+		    KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 3))
+			grace_period = 1;
+		else
+			return 0;
+	}
+
 	pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
 			pm->dqm->dev->adev,
 			pm->dqm->wait_times,
-- 
2.34.1

