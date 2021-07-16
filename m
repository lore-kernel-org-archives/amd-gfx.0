Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1FBC12002
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 15:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EEC0613F9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 15:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEC0613F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 421AC6E9BB;
	Fri, 16 Jul 2021 15:37:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AEC56E9BB
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 15:37:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jgu/haB8urI9kU96x/fv0x8JunXRhcUYrzWewBbbQBGRmUo4PDZ/+rdxoM2zPooBk4vhxBT2StWeTg0nOAKyXF7jZJMuaV20EpWJsdQMl4aBPBKcD+PjtVH7DThH/3frta2p6MR6/KbahCsQOcXkIYnvqIdqjBYBR6/9KLV8VXIPjkOZinMa6UOahwCaZ0AP1apaA1jqD3FziWbEAf8/8rXIvVvNFqiLkhBi0ZIc0fMRd+UdzFt7102GzYB1iTY2EKS6CqdWJdwvsnrNpbJ+K121TgRm0eOedP7oVFXByoQG3OJ96iVLzL6Rv270QO1b6GAktiqVXz/wZFshF51D0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCfi2/+kstVDGGvZjaxE5Y+ryTWC9jb6QQqsCn5hIb0=;
 b=S32VDrqxFZu/1/iwYgE7I/xt+kdPMpxUFNoZkI18Me2CpNDseJG6L/FP5vEdK5oAtZNIbhETRb0vrq8M+7odV3iS8TBB9tjsLEuJWpXQJoV5yN4+FT0FFGyUMent0cU9wJ5oROfWMp2dqsJsvOHHQnfJ7wutaJ7iiOkaIQ6/XL/VmLIX1Ie2344GthkUXIglyt/Cbr0NvV9cl01q/OEd/VRT/j7KcFZx3d4HrlMsjhCvCAiKTyZfDOgXUdEqDV95bNEK+ymT6MIfxxgUQ4dGc5b7aZGtrMkpLlatmCzyW2nfdoEujLY2CrKBiyPnVbQG0noZVoV+9UOelptAVVxZIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCfi2/+kstVDGGvZjaxE5Y+ryTWC9jb6QQqsCn5hIb0=;
 b=gA3pFtV+27sx5QlGXXAsiCJCukv0A9B209h6FkZBygBKSDZnV03A3tRNr+iRW388yD8LeTj+Q5t9F7bMfnklJl0dS3/1HDEMZ24aV3x8166FVJIvKwza2fLceeEpKnIFkip6o/m1qXQeA8S+X8FUo8SGljECCqHN8FXZghRUurw=
Received: from BN9PR03CA0759.namprd03.prod.outlook.com (2603:10b6:408:13a::14)
 by DM6PR12MB2618.namprd12.prod.outlook.com (2603:10b6:5:49::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Fri, 16 Jul
 2021 15:37:02 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::d2) by BN9PR03CA0759.outlook.office365.com
 (2603:10b6:408:13a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 15:37:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 15:37:02 +0000
Received: from ozeng-develop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Jul
 2021 10:37:00 -0500
From: Oak Zeng <Oak.Zeng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdkfd: Fix a concurrency issue during kfd recovery
Date: Fri, 16 Jul 2021 10:36:50 -0500
Message-ID: <1626449810-18044-6-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626449810-18044-1-git-send-email-Oak.Zeng@amd.com>
References: <1626449810-18044-1-git-send-email-Oak.Zeng@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d25aa2b0-da80-47f0-159d-08d9486f8ea7
X-MS-TrafficTypeDiagnostic: DM6PR12MB2618:
X-Microsoft-Antispam-PRVS: <DM6PR12MB261884A8DDD2F18C373EE5F180119@DM6PR12MB2618.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6l35mWlcXj4NLIF+IJ75c0xeCTfT0dxWg7XGQX+wgubDtZ/ZuRaniGozbaq1nzEJvCRCTckJabSIs9PO3EVzKRvwG1H5LitKGaISzydPd89IkLMznOf6WNzUi9xjkG+b61PPVftoJKnjucXzcQSWGipnFoQI1bQOKnxxueTrO45e+P5SteYkwOl59F/stPfwRwruM7lghY0Nudr7X84yA7iDIztqWi3MA400JXz/fK3fyvKhDLtaeUm2jai4Qlq4IbwKagrS8i4Pj/j71vYjg18VZAQq8dID6hDmIZwUDlT4MVVEAS6Lm8wECvP/zC/y+zVrwYKubo2rCvX4zXWdveFovhR2r6aLonAqc4PFq2v1dHEYLoy6Mr5J0Gti533F209foZGCT8HAH1Ju0GTd0JDCuIsgf6IEMoli3A+s90wYNfZQxJ0YvHw/NujOma/DtZCDdEZEBKGcaZZpbxi1bgQjmdvGM8JhZ054GIWCjMC9JVG44AD8ImXM3dKmah4dnKm+VVdnwNRdSUHjtTsonzwF+jH1T1Ga4exsqwXaItvmMRJam+Ei7FjNUhi4HKdwePUb1EDCAMq3HHr7yEcZWkiRCFnmll52ShfH3eMIQ8hUqoX9DYUbb6MIKSZRNUP/ISoDkJ5vdckLgxJC6ZHckdf2DfG518WgBE6gdY7BWXiOvyIPJcRYm1XlpNm1qPxkoFnjwRKaYHaOAKW9EO/ef+3Emnck1mf4dEtiiJ8cJq0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(46966006)(36840700001)(54906003)(26005)(83380400001)(36756003)(82310400003)(86362001)(47076005)(5660300002)(2906002)(356005)(7696005)(8936002)(316002)(6666004)(82740400003)(426003)(4326008)(478600001)(81166007)(6916009)(336012)(2616005)(70586007)(36860700001)(186003)(8676002)(70206006)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 15:37:02.1000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d25aa2b0-da80-47f0-159d-08d9486f8ea7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2618
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
Acked-by: Christian Konig <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c               |  8 +-------
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 12 +++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c       |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 |  2 +-
 4 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 03875d2..56b5010 100644
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
 
-	r = pm_debugfs_hang_hws(&dev->dqm->packet_mgr);
-	if (!r)
-		r = dqm_debugfs_execute_queues(dev->dqm);
-
-	return r;
+	return dqm_debugfs_hang_hws(dev->dqm);
 }
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 6b2f594..6b89ca6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1164,6 +1164,7 @@ static int start_cpsch(struct device_queue_manager *dqm)
 
 	retval = 0;
 
+	dqm_lock(dqm);
 	retval = pm_init(&dqm->packet_mgr, dqm);
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
 	pm_uninit(&dqm->packet_mgr, false);
 fail_packet_manager_init:
+	dqm_unlock(dqm);
 	return retval;
 }
 
@@ -1211,12 +1212,12 @@ static int stop_cpsch(struct device_queue_manager *dqm)
 		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
 	hanging = dqm->is_hws_hang || dqm->is_resetting;
 	dqm->sched_running = false;
-	dqm_unlock(dqm);
 
 	pm_release_ib(&dqm->packet_mgr);
 
 	kfd_gtt_sa_free(dqm->dev, dqm->fence_mem);
 	pm_uninit(&dqm->packet_mgr, hanging);
+	dqm_unlock(dqm);
 
 	return 0;
 }
@@ -2099,11 +2100,16 @@ int dqm_debugfs_hqds(struct seq_file *m, void *data)
 	return r;
 }
 
-int dqm_debugfs_execute_queues(struct device_queue_manager *dqm)
+int dqm_debugfs_hang_hws(struct device_queue_manager *dqm)
 {
 	int r = 0;
 
 	dqm_lock(dqm);
+	r = pm_debugfs_hang_hws(&dqm->packet_mgr);
+	if (r) {
+		dqm_unlock(dqm);
+		return r;
+	}
 	dqm->active_runlist = true;
 	r = execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
 	dqm_unlock(dqm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index b130cc0..b33ebe8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -448,6 +448,9 @@ int pm_debugfs_hang_hws(struct packet_manager *pm)
 	uint32_t *buffer, size;
 	int r = 0;
 
+	if (!pm->priv_queue)
+		return -EAGAIN;
+
 	size = pm->pmf->query_status_size;
 	mutex_lock(&pm->lock);
 	kq_acquire_packet_buffer(pm->priv_queue,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 3426743..8a5dfda 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1194,7 +1194,7 @@ int pm_debugfs_runlist(struct seq_file *m, void *data);
 
 int kfd_debugfs_hang_hws(struct kfd_dev *dev);
 int pm_debugfs_hang_hws(struct packet_manager *pm);
-int dqm_debugfs_execute_queues(struct device_queue_manager *dqm);
+int dqm_debugfs_hang_hws(struct device_queue_manager *dqm);
 
 #else
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
