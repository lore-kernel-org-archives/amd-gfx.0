Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB709C38145
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 08:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D173110E3F2;
	Wed,  7 Sep 2022 08:10:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA7C710E3F2
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 08:10:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbs4s+qx7+tLfMgNWOAz99EXlC8p859SQbpGlQangJSG6enAiuNT/E6esq9o1nut6XOM4ODpAGI+udMm+zelm/gVZhxKAi0hqgkTT75TNQ13QlEfi/gy9oLOsmf9OdTh7fx7YrmuHuOKkYlBlXWHFfnSXryYkYcOpR0L8QQHSQPftdmdXg1jE7zULnZEoEmbT7lPwD1awshKlIqQJHgxMzR0KkPEorutUQwnv6OtNfpqFc0GDvk3eRzdTik85KnUPnn3O8bLQmfd/g6oYxy5plpZnJqAAUp2mY4LnvMSSps+a2K/NrNwI+xXaxixRNtIApnadeUBCrLcBpyF9/5ReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UcH6e81zVJkzmhlPjKpDX99Kml2eb0XcmKC+8Z71Mg=;
 b=UQPmhhu49hObvU0FcwU29s/kjy/zQa1IUjYgVYsZPrTAoALDCtKeUDJfZ0EJHV5EC8jkgJlkvavGk6uLGjG0sLEI90PdvOJ5/gdZ7duYe+WMAEuzuNbMX3sL6fUVmSASbajhp1ZJDxUzXErTEdFP/SlalzgQgHP7yVNptKQf0aiiTRlVkSzNcY4bjdNjYQdBTz/svu9A42Jm6BBpMp/ZPkfi3CAv6R1Q0f3LLC2apbTmv2oH8w9cDwHkci1D8iUXc3u+lRKIvhco1LyDZwtj3q6pCpRVJ+1IKLK3dp7mwCoEoA7CWnu7SOvbt0lG++efmUf7TvG3fsNXKvb3VhJuQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UcH6e81zVJkzmhlPjKpDX99Kml2eb0XcmKC+8Z71Mg=;
 b=sVmscLd/OgZHQ/KORwDHc2gGlQf77GnQm/S3A97OnBw0bkw8yAIQUv3x2d7LQwaW7GWrvDBobi7+s672RNrpKB+IdzbyLYP/SqCmP6GF+GlOYt4HZ1FQ/eLhikIp22PS1R/Q/N0Xxn5M5iZa8xg66/igb2aWIhd7AwUmGhmP7lo=
Received: from BN7PR06CA0060.namprd06.prod.outlook.com (2603:10b6:408:34::37)
 by BL0PR12MB5507.namprd12.prod.outlook.com (2603:10b6:208:1c4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 08:10:53 +0000
Received: from BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::b9) by BN7PR06CA0060.outlook.office365.com
 (2603:10b6:408:34::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Wed, 7 Sep 2022 08:10:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT116.mail.protection.outlook.com (10.13.176.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 08:10:53 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 03:10:51 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: rename KFD_IS_SOC15 to KFD_IS_SOC15_OR_LATER
Date: Wed, 7 Sep 2022 16:10:11 +0800
Message-ID: <20220907081011.143120-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT116:EE_|BL0PR12MB5507:EE_
X-MS-Office365-Filtering-Correlation-Id: 168bd6c5-ee11-43ed-c196-08da90a87c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zc/SaVWmX4ua+NlzqWdCMzD3xtcG8QAPRh3vqBujTrYcWzKQx2EaoIhAcyNqnyM64pAi5EUBvNoUzju01Dno+Wn68BmjlTG7I+7u+pKksCY/SAVgyKAcJuzlvk1EEucvHEwK586bXMAa8CVcKADJsv/J2A6Mn6KbJzDrT5YYQzN+vBSWr7w4NERzZEh4w9SlSY+F6WA4iNLBxXpyRoX2ORQTENY4XyJ6Arz8gPeVd6u1RGAgb7kX2Pp6lKPnDV7cllR9Z054SbdTvBgahV+sckaDJc62Z6DAiy5fVZXxXPvpfgsU4JiVJJjEmjKG2IpJB9D+/qmbVey6/B4LQhMKt1ffAjxHl5YAosgjEI0u01cAOwJfKByh9CgM+TrwHQgr1j8bCatmUqlAEWjKebMKVxOxIInfskIvoO9KizSH9BM8R0hDv6SpM1Oh8Kq67+JHhjWmk37TQsfWjDrBWTnESwlslCvWG9bA0Nrtf33F31hlfLcbPqiGTlzETg2QO2t5DGHdd6/E7OInPuYyJaZCnZjdWmxnU3XtcmSP8ZyanaTzsVDH4kx73MP1ZE+FAoh8cyTb7sBd0+IMRZ0ILpakGxXDPsJE+zDzqJpSfL2XnC979ntdSz7PfJkaT1OyN5CKcqrl1rNhGPUAZtrHpv/MRSJSTW7PUfItmsxNXOLa+jWn0Qw2GQSLAWwMSloc9dbgAxp/aQCcFU3i0HNDBWcSu6Sden5UrQDnJxhtR1VEnEV6Dy+QJ9nCjJeQ/lNhVl04w/zJn1ga3btT8cP6jc6mvOv2t8xcHooWI+lLXoATLhw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966006)(36840700001)(40470700004)(40480700001)(82310400005)(70206006)(5660300002)(54906003)(8936002)(70586007)(4326008)(316002)(6916009)(2906002)(41300700001)(478600001)(8676002)(6666004)(36756003)(356005)(186003)(1076003)(16526019)(336012)(83380400001)(82740400003)(7696005)(2616005)(47076005)(426003)(26005)(81166007)(40460700003)(36860700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 08:10:53.6362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 168bd6c5-ee11-43ed-c196-08da90a87c14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5507
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Felix.Kuehling@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The features protected w/ KFD_IS_SOC15 actually apply to SOC15
ASIC onwards (e.g. SOC21), rename the macro to avoid confusion.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c              | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c               | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c              | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c              | 4 ++--
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 84da1a9ce37c..a709684fdf4c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -385,8 +385,8 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 	/* Return gpu_id as doorbell offset for mmap usage */
 	args->doorbell_offset = KFD_MMAP_TYPE_DOORBELL;
 	args->doorbell_offset |= KFD_MMAP_GPU_ID(args->gpu_id);
-	if (KFD_IS_SOC15(dev))
-		/* On SOC15 ASICs, include the doorbell offset within the
+	if (KFD_IS_SOC15_OR_LATER(dev))
+		/* From SOC15 ASICs onwards, include the doorbell offset within the
 		 * process doorbell frame, which is 2 pages.
 		 */
 		args->doorbell_offset |= doorbell_offset_in_process;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index be7a0b5a2dbc..ce9c1281edc0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -175,7 +175,7 @@ static void kfd_device_info_init(struct kfd_dev *kfd,
 	kfd->device_info.mqd_size_aligned = MQD_SIZE_ALIGNED;
 	kfd->device_info.gfx_target_version = gfx_target_version;
 
-	if (KFD_IS_SOC15(kfd)) {
+	if (KFD_IS_SOC15_OR_LATER(kfd)) {
 		kfd->device_info.doorbell_size = 8;
 		kfd->device_info.ih_ring_entry_size = 8 * sizeof(uint32_t);
 		kfd->device_info.supports_cwsr = true;
@@ -490,7 +490,7 @@ static int kfd_gws_init(struct kfd_dev *kfd)
 	if (kfd->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS)
 		return 0;
 
-	if (hws_gws_support || (KFD_IS_SOC15(kfd) &&
+	if (hws_gws_support || (KFD_IS_SOC15_OR_LATER(kfd) &&
 		((KFD_GC_VERSION(kfd) == IP_VERSION(9, 0, 1)
 			&& kfd->mec2_fw_version >= 0x81b3) ||
 		(KFD_GC_VERSION(kfd) <= IP_VERSION(9, 4, 0)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e83725a28106..f4dff839950f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -330,7 +330,7 @@ static int allocate_doorbell(struct qcm_process_device *qpd,
 {
 	struct kfd_dev *dev = qpd->dqm->dev;
 
-	if (!KFD_IS_SOC15(dev)) {
+	if (!KFD_IS_SOC15_OR_LATER(dev)) {
 		/* On pre-SOC15 chips we need to use the queue ID to
 		 * preserve the user mode ABI.
 		 */
@@ -391,7 +391,7 @@ static void deallocate_doorbell(struct qcm_process_device *qpd,
 	unsigned int old;
 	struct kfd_dev *dev = qpd->dqm->dev;
 
-	if (!KFD_IS_SOC15(dev) ||
+	if (!KFD_IS_SOC15_OR_LATER(dev) ||
 	    q->properties.type == KFD_QUEUE_TYPE_SDMA ||
 	    q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
 		return;
@@ -439,7 +439,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
 
 	program_sh_mem_settings(dqm, qpd);
 
-	if (KFD_IS_SOC15(dqm->dev) && dqm->dev->cwsr_enabled)
+	if (KFD_IS_SOC15_OR_LATER(dqm->dev) && dqm->dev->cwsr_enabled)
 		program_trap_handler_settings(dqm, qpd);
 
 	/* qpd->page_table_base is set earlier when register_process()
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 373e5bfd4e91..53a7f239b212 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -979,7 +979,7 @@ int svm_migrate_init(struct amdgpu_device *adev)
 	void *r;
 
 	/* Page migration works on Vega10 or newer */
-	if (!KFD_IS_SOC15(kfddev))
+	if (!KFD_IS_SOC15_OR_LATER(kfddev))
 		return -EINVAL;
 
 	pgmap = &kfddev->pgmap;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index bf610e3b683b..4463916df493 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -205,7 +205,7 @@ enum cache_policy {
 };
 
 #define KFD_GC_VERSION(dev) ((dev)->adev->ip_versions[GC_HWIP][0])
-#define KFD_IS_SOC15(dev)   ((KFD_GC_VERSION(dev)) >= (IP_VERSION(9, 0, 1)))
+#define KFD_IS_SOC15_OR_LATER(dev)   ((KFD_GC_VERSION(dev)) >= (IP_VERSION(9, 0, 1)))
 
 struct kfd_event_interrupt_class {
 	bool (*interrupt_isr)(struct kfd_dev *dev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 951b63677248..b67ecef3a1b6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1324,7 +1324,7 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
 		 * support the SVM APIs and don't need to be considered
 		 * for the XNACK mode selection.
 		 */
-		if (!KFD_IS_SOC15(dev))
+		if (!KFD_IS_SOC15_OR_LATER(dev))
 			continue;
 		/* Aldebaran can always support XNACK because it can support
 		 * per-process XNACK mode selection. But let the dev->noretry
@@ -1450,7 +1450,7 @@ static int init_doorbell_bitmap(struct qcm_process_device *qpd,
 	int range_start = dev->shared_resources.non_cp_doorbells_start;
 	int range_end = dev->shared_resources.non_cp_doorbells_end;
 
-	if (!KFD_IS_SOC15(dev))
+	if (!KFD_IS_SOC15_OR_LATER(dev))
 		return 0;
 
 	qpd->doorbell_bitmap = bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
-- 
2.37.1

