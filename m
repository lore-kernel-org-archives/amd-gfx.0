Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687D7EB64DC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 18:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D21B410E489;
	Thu,  6 Jul 2023 18:19:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBD4E10E495
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 18:19:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+qyzp4+/Cc9hpoudDeUc6h1x8AFnET/YKQ0/AsvxIXpo43CHOgnFfT5zf72qyhlG+2+2FIkeRm0PgjV7sildPaZawLvufAX6BBisQ1pWPfnK9rCxkHkwLc4XBHRa395ppAsWbmW5dJKLhPZv4aF0Z8lPaI7OBCWStZXoMDxoeT5M5DLOs4LJwIoVmjIrh58F+N+GEhPe2Hewd05M3jXzzvOpYNPpwqMP6MF8WQIq2VWXQ5bAtvesFxCVsHSMuR8pdbdjh3BzMofJ9WbFTySmmZwfg7tad3MLRxWj7r2o8q21yfgIDzHCFI0bKjkaxzpoSRq9Ddv3wHu3sQR9bVwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKUwi9c34r6fXjoQFCGP6oaR7mKdV57DYJcL1uFMlVM=;
 b=HK+iGjqlCBW36jTfuhZXSDml4lgY4HRTIf/pV0SArWiIpcvxtus+BUzrIeuXexxFrn6ecr3xyQ/y66DPslgwTwitdjKFtLWk3Wi7NYxlX0Hr4j8qOHMdu0CMNjEF958cRiMmIHqt3R70vrCyg0Pol9w3/g7pMe1rJCw9K7J2a0HP6KF/XxGoeEY0MRqAo93fJAj86aqttQHj1dcvXPBAFWKb7i5ldpyAlrOj8GPxcE/fBgrlTAJSnVtZKdxHC72zj52tmPrgjozq+d5N1lhNkIHxvmkvzCZ7QNTVXUAsGzhKkrD5o1zhQ+6p0F6uPSXAP0JymaaRpZGP0YF+CCC5ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKUwi9c34r6fXjoQFCGP6oaR7mKdV57DYJcL1uFMlVM=;
 b=Xx4tv3vHQ7TEx4PVq4VJH4MCsTuC2Ye0SWqB84xaLO2SLzY+EUDG+y4iUNhRfMIGNFIh8w7Av+p3oxS4xXT1rlWU3WHwH3vwk8v6A6PIddpCAwVeAdqi/gWQIVYalXY3xjDW4M8u6POCv4tyCKmJKvxeRRU5TArgOrbOywxH/40=
Received: from MW4PR04CA0056.namprd04.prod.outlook.com (2603:10b6:303:6a::31)
 by SA3PR12MB7877.namprd12.prod.outlook.com (2603:10b6:806:31b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 18:19:38 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::3) by MW4PR04CA0056.outlook.office365.com
 (2603:10b6:303:6a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Thu, 6 Jul 2023 18:19:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 18:19:38 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 6 Jul 2023 13:19:37 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/6] drm/amdkfd: enable grace period for xcc instance
Date: Thu, 6 Jul 2023 14:19:16 -0400
Message-ID: <20230706181918.189722-5-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706181918.189722-1-jinhuieric.huang@amd.com>
References: <20230706181918.189722-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT049:EE_|SA3PR12MB7877:EE_
X-MS-Office365-Filtering-Correlation-Id: c78a1896-9923-4efa-002e-08db7e4d8f7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8oYWXbDl9uNrcriYxqtzpnqDdqg1Hry4UO/+WbWboYovR3uC13eWjYCK+Hmt8YHShW3AZT4V7iuDrftd6Hfa9m6MN3wm9KoNR1U2TAotcjtQt1WSeH/p20elPUPAynJrZ8Nd4qbUOOQjXgfxdz0unCXW0j9fmh81rtYlawc+lfLf8dlUmYojEaV1aTJDZ6V2cVd5K/f68m4x6vHyAVADRG3EthOfi5LQi9v9/3ePkgMzJUG/uxHhMWvXx0x2lQtweVPmRercZD7+jMu2x/hL9zd3WkE+rATNT/ax3Iv5G6+x/tA0G6eRCNg6LU4av3Vv5/Hcs2al3x/0yCr0IcoPxXiTCrLLA4mjTOC2WJjzmpAoe2hAA7wszIwQte5tfK5ZLFrJjgdyabUQ109s9cnytBOVba7yPBtglQ86I6vajGsPHb3+bb/l5uuMzRyidkaM70x66Bpyye8mffitzcw0i0C8PpFCWv7veshXJPBIMbHH7Z92+kpfYydqmksKiIqqVuyReK6Jda2UtWmZ0YpLmOdPa0yPOFIdyuDZNa8XQYSDh57e81lc8jufkBfbQR4ddvEiHd4dZIa4U6qGwStuw6vFuhIpO54yI1mYR/J1m9k7zVmvn0SSEqcRD9dz4Qrz0/aU4gxXOKu3cLQjIDVd3cMaqbzeBXhL0N2I3dv3RQ7/AReY6iOGoe9tJjJu71Iu+HwJ2bWgjEQHZtXn7YulzdG/GhyNQvi1JvyB5LX3f3vC8jrBLZsMRb6eTX2k1A7eUTbbP5jONMXci0LO9u58w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(6666004)(478600001)(7696005)(54906003)(36860700001)(47076005)(426003)(336012)(2616005)(83380400001)(40460700003)(36756003)(86362001)(40480700001)(70206006)(2906002)(82310400005)(26005)(16526019)(1076003)(186003)(70586007)(356005)(81166007)(82740400003)(6916009)(41300700001)(316002)(4326008)(8936002)(8676002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 18:19:38.6369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c78a1896-9923-4efa-002e-08db7e4d8f7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7877
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Jonathan.Kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

each xcc instance needs to get iq wait time and set
grace period accordingly.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  9 ++++--
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 32 +++++++++++--------
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  9 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
 5 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index a2bff3f01359..0f12c1989e14 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1606,6 +1606,8 @@ static int set_sched_resources(struct device_queue_manager *dqm)
 
 static int initialize_cpsch(struct device_queue_manager *dqm)
 {
+	uint32_t xcc_id, xcc_mask = dqm->dev->xcc_mask;
+
 	pr_debug("num of pipes: %d\n", get_pipes_per_mec(dqm));
 
 	mutex_init(&dqm->lock_hidden);
@@ -1620,8 +1622,11 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
 	init_sdma_bitmaps(dqm);
 
 	if (dqm->dev->kfd2kgd->get_iq_wait_times)
-		dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
-					&dqm->wait_times, 0);
+		for_each_inst(xcc_id, xcc_mask)
+			dqm->dev->kfd2kgd->get_iq_wait_times(
+					dqm->dev->adev,
+					&dqm->wait_times[xcc_id],
+					xcc_id);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 7dd4b177219d..62a6dc8d3032 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -262,7 +262,7 @@ struct device_queue_manager {
 	/* used for GFX 9.4.3 only */
 	uint32_t		current_logical_xcc_start;
 
-	uint32_t		wait_times;
+	uint32_t		wait_times[32];
 
 	wait_queue_head_t	destroy_wait;
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 401096c103b2..f37ab4b6d88c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -374,27 +374,31 @@ int pm_update_grace_period(struct packet_manager *pm, uint32_t grace_period)
 {
 	int retval = 0;
 	uint32_t *buffer, size;
+	uint32_t xcc_id, xcc_mask = pm->dqm->dev->xcc_mask;
 
 	size = pm->pmf->set_grace_period_size;
 
 	mutex_lock(&pm->lock);
 
 	if (size) {
-		kq_acquire_packet_buffer(pm->priv_queue,
-			size / sizeof(uint32_t),
-			(unsigned int **)&buffer);
-
-		if (!buffer) {
-			pr_err("Failed to allocate buffer on kernel queue\n");
-			retval = -ENOMEM;
-			goto out;
-		}
+		for_each_inst(xcc_id, xcc_mask) {
+			kq_acquire_packet_buffer(pm->priv_queue,
+					size / sizeof(uint32_t),
+					(unsigned int **)&buffer);
 
-		retval = pm->pmf->set_grace_period(pm, buffer, grace_period);
-		if (!retval)
-			kq_submit_packet(pm->priv_queue);
-		else
-			kq_rollback_packet(pm->priv_queue);
+			if (!buffer) {
+				pr_err("Failed to allocate buffer on kernel queue\n");
+				retval = -ENOMEM;
+				goto out;
+			}
+
+			retval = pm->pmf->set_grace_period(pm, buffer,
+					grace_period, xcc_id);
+			if (!retval)
+				kq_submit_packet(pm->priv_queue);
+			else
+				kq_rollback_packet(pm->priv_queue);
+		}
 	}
 
 out:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 8fda16e6fee6..a9443d661957 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -287,7 +287,8 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 
 static int pm_set_grace_period_v9(struct packet_manager *pm,
 		uint32_t *buffer,
-		uint32_t grace_period)
+		uint32_t grace_period,
+		uint32_t inst)
 {
 	struct pm4_mec_write_data_mmio *packet;
 	uint32_t reg_offset = 0;
@@ -295,14 +296,14 @@ static int pm_set_grace_period_v9(struct packet_manager *pm,
 
 	pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
 			pm->dqm->dev->adev,
-			pm->dqm->wait_times,
+			pm->dqm->wait_times[inst],
 			grace_period,
 			&reg_offset,
 			&reg_data,
-			0);
+			inst);
 
 	if (grace_period == USE_DEFAULT_GRACE_PERIOD)
-		reg_data = pm->dqm->wait_times;
+		reg_data = pm->dqm->wait_times[inst];
 
 	packet = (struct pm4_mec_write_data_mmio *)buffer;
 	memset(buffer, 0, sizeof(struct pm4_mec_write_data_mmio));
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d4c9ee3f9953..22c4a403ddd7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1400,7 +1400,7 @@ struct packet_manager_funcs {
 			enum kfd_unmap_queues_filter mode,
 			uint32_t filter_param, bool reset);
 	int (*set_grace_period)(struct packet_manager *pm, uint32_t *buffer,
-			uint32_t grace_period);
+			uint32_t grace_period, uint32_t inst);
 	int (*query_status)(struct packet_manager *pm, uint32_t *buffer,
 			uint64_t fence_address,	uint64_t fence_value);
 	int (*release_mem)(uint64_t gpu_addr, uint32_t *buffer);
-- 
2.34.1

