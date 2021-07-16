Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D43C636CB
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 01:25:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50606613C1
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 01:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50606613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C86E76E8DC;
	Fri, 16 Jul 2021 01:25:32 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2089.outbound.protection.outlook.com [40.107.96.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE25B6E8D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 01:25:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oACgM4hD/sGHdixw5FmUDanbmMSAAk1Mzh4e62ckpn86MBRYdVBz7pTTtE743CsJfn2FRU0yYRE/rfd+mWwYYQSFDon16GTBKo8svKVVo+jc2vZv2akHzkH0x0497j9UE7AEzJmorQy1b5l3uuhCeHsqHFOvR1DndIBLMjx0fczumtJifSrSd3ygor+I2lxadJDg7WHRx73n3ZCngyBP1gfG/Fay+KTDxEq8Zs3BKbkvuvpckw/2FCfeU5+Nf9VxGkKvQDW6xHz0w79l8bEWXzvbnQrIpwp5g3000OgDQ2Htj2O+YGEo1gPbZbNSqyNq6Aa+bZrXdkeLP0e9+ZZjuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/1q7sdaZbhOST/JZGGlo19iLkQIgHzU8/X2+k89nqU=;
 b=Tg1GnaRFzDZY2VTtUQ2T/kZq8/jddFKGfQzF4vn+BAbRphr5DNG1tNf/GdAdly669U6U2eyoFRgvk3ZzLxcCui3Dv/lozh6ahsM6Gisp3dy398rRRVzv8ag39q3x3D+lrja2sO6/8uSGjEekV4tOgYGMF+qr0TjWWuWn7yrjE0KCrLq8WAs6jRn/GFDL9Qga+Isfzcn22gbvuoH1xJzBPLSwGHJQ/ijwcviiVSf+DD88hdCKkZMeewnhIgfk1M6dUWqXvKJQKzWnbJus36lv3OkzK4Vr9z4nNn11hysOi2Sh0VY4TTd+vgYlnYAPA6FDXBl564ccGhTmC4idtwqZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/1q7sdaZbhOST/JZGGlo19iLkQIgHzU8/X2+k89nqU=;
 b=2XVYC2mxMyrmNvkMvG1W2wMp6soU9X3mdiRSTxXFYcNkxFCK5FPYpbqCuPnfrTgUGzym/slAhu32kODK5xn1JIFB18Nj1sO7f5VH6UUg6rPzgGQosztEHxadtPn0tJiMMkeon9lGXDhXV5Nvv3xvvMILStTqZxoDDfTXeer7rQM=
Received: from BN9PR03CA0256.namprd03.prod.outlook.com (2603:10b6:408:ff::21)
 by BL0PR12MB2466.namprd12.prod.outlook.com (2603:10b6:207:4e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.26; Fri, 16 Jul
 2021 01:25:27 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::43) by BN9PR03CA0256.outlook.office365.com
 (2603:10b6:408:ff::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 01:25:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 01:25:27 +0000
Received: from ozeng-develop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 15 Jul
 2021 20:25:24 -0500
From: Oak Zeng <Oak.Zeng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdkfd: Fix a concurrency issue during kfd recovery
Date: Thu, 15 Jul 2021 20:25:15 -0500
Message-ID: <1626398715-6419-6-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626398715-6419-1-git-send-email-Oak.Zeng@amd.com>
References: <1626398715-6419-1-git-send-email-Oak.Zeng@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9566df80-cf06-4433-0bec-08d947f897d4
X-MS-TrafficTypeDiagnostic: BL0PR12MB2466:
X-Microsoft-Antispam-PRVS: <BL0PR12MB246624AE2BE93DFCF415E3E980119@BL0PR12MB2466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kO0htDMOBPM1aBMAN2KIdOSrcTMi+6w/5QET0rb253QT4w+C2yKSoo40or93+2n9OxIbMjowRkG5MnteEF/ksZw2p1HNiLuf/UyY3qujZz5elk0Ym5VIDGdCE0ayxW/HkSBY2oOpM8F/mey98x4OOuxMhu2SmomLguZ3l1RkuBTfQZDtZzgkOKUiePxvwatLy3RbmXN6oJGALoM74BEOLQ4mQ5NkBw3yecJmJQ5EQVRAKIhvpqQkykTp1KZxxIusLzriyw62IIcE2197FqgJgDtB61QZfQwEqLayTrnSosJ8p9JdXRgKzGC6EV1K3WfWx4yg9rRkbPL2yiKfeuABd4v1xLlx978tJ1y/CK2Q17xqWAXjWfyNRgEpm1JDVKzUWmuNd8L0OEsaRFThnTw+u2sgXDQgv0OrgboYoNp0KjtFi6IqUcGqHAlCY3WhtM+jAnIC758R85rSiAt03YeXmErLKvyMM7JPzY8PLhEdm+yYUlk40k6KBTBSBHcWuUg3X769hpDBQ1XrNh0lPUBXr/PgaeBIkGtCSlS0301w85VCLuh3vloCBv/fyIWCGHkbJeqT1OeG52WwNTkhkR822T8pOxu97HlODMNasxtK44Im5rGRUh9OqimJYHv1DLkhGWtUdnLK+Ke7ZZbHRom4TEb18prLOcNbRmb/Ln3dPoxNf9I5pXfBrGglNoYlLAAecKVeyTCSI45iJrpfZg+4mAZjGuTOggkiRq0ytpyGpeY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(46966006)(36840700001)(186003)(6916009)(6666004)(82310400003)(16526019)(426003)(81166007)(356005)(2616005)(478600001)(54906003)(26005)(336012)(47076005)(36756003)(2906002)(7696005)(8936002)(4326008)(36860700001)(5660300002)(83380400001)(70206006)(82740400003)(316002)(70586007)(86362001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 01:25:27.3833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9566df80-cf06-4433-0bec-08d947f897d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2466
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
Cc: feifei.xu@amd.com, Felix.Kuehling@amd.com, leo.liu@amd.com,
 Oak Zeng <Oak.Zeng@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

start_cpsch and stop_cpsch can be called during kfd device
initialization or during gpu reset/recovery. So they can
run concurrently. Currently in start_cpsch and stop_cpsch,
pm_init and pm_uninit is not protected by the dpm lock.
Imagine such a case that user use packet manager's function
to submit a pm4 packet to hang hws (ie through command
cat /sys/class/kfd/kfd/topology/nodes/1/gpu_id | sudo tee
/sys/kernel/debug/kfd/hang_hws), while kfd device is under
device reset/recovery so packet manager can be not initialized.
There will be unpredictable protection fault in such case.

This patch moves pm_init/uninit inside the dpm lock and check
packet manager is initialized before using packet manager
function.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c               |  8 +-------
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 10 ++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c       |  3 +++
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index c51402b..adc2342 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1383,18 +1383,12 @@ void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t throttle_bitmask)
  */
 int kfd_debugfs_hang_hws(struct kfd_dev *dev)
 {
-	int r = 0;
-
 	if (dev->dqm->sched_policy != KFD_SCHED_POLICY_HWS) {
 		pr_err("HWS is not enabled");
 		return -EINVAL;
 	}
 
-	r = pm_debugfs_hang_hws(&dev->dqm->dpm);
-	if (!r)
-		r = dqm_debugfs_execute_queues(dev->dqm);
-
-	return r;
+	return dqm_debugfs_execute_queues(dev->dqm);
 }
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f2984d3..44136d2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1164,6 +1164,7 @@ static int start_cpsch(struct device_queue_manager *dqm)
 
 	retval = 0;
 
+	dqm_lock(dqm);
 	retval = pm_init(&dqm->dpm, dqm);
 	if (retval)
 		goto fail_packet_manager_init;
@@ -1186,7 +1187,6 @@ static int start_cpsch(struct device_queue_manager *dqm)
 
 	init_interrupts(dqm);
 
-	dqm_lock(dqm);
 	/* clear hang status when driver try to start the hw scheduler */
 	dqm->is_hws_hang = false;
 	dqm->is_resetting = false;
@@ -1199,6 +1199,7 @@ static int start_cpsch(struct device_queue_manager *dqm)
 fail_set_sched_resources:
 	pm_uninit(&dqm->dpm, false);
 fail_packet_manager_init:
+	dqm_unlock(dqm);
 	return retval;
 }
 
@@ -1211,12 +1212,12 @@ static int stop_cpsch(struct device_queue_manager *dqm)
 		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
 	hanging = dqm->is_hws_hang || dqm->is_resetting;
 	dqm->sched_running = false;
-	dqm_unlock(dqm);
 
 	pm_release_ib(&dqm->dpm);
 
 	kfd_gtt_sa_free(dqm->dev, dqm->fence_mem);
 	pm_uninit(&dqm->dpm, hanging);
+	dqm_unlock(dqm);
 
 	return 0;
 }
@@ -2104,6 +2105,11 @@ int dqm_debugfs_execute_queues(struct device_queue_manager *dqm)
 	int r = 0;
 
 	dqm_lock(dqm);
+	r = pm_debugfs_hang_hws(&dqm->dpm);
+	if (r) {
+		dqm_unlock(dqm);
+		return r;
+	}
 	dqm->active_runlist = true;
 	r = execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
 	dqm_unlock(dqm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index b130cc0..0123e64 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -448,6 +448,9 @@ int pm_debugfs_hang_hws(struct packet_manager *pm)
 	uint32_t *buffer, size;
 	int r = 0;
 
+	if (!pm->priv_queue)
+		return -EBUSY;
+
 	size = pm->pmf->query_status_size;
 	mutex_lock(&pm->lock);
 	kq_acquire_packet_buffer(pm->priv_queue,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
