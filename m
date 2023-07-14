Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1BCEB64DA
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jul 2023 09:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81F5A10E1D0;
	Fri, 14 Jul 2023 09:38:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC8FF10E1D0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jul 2023 09:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+ipvTq+nUis9C707pqEumDeA7oZis4VgyVFIoPJ5bky8NX/fSPUmyBxR//08LqZoC+ceEPFv+OLzTe8l4flo/mhrNqJdq+Yb1TZ7GjobypBcHF2sZyneweFZpY7ySSCqH9HLzj5AVynzp8/xGGcqyLNgRndbrBm5U/6t257ZKEFHoSFh10WHBYL73c2kif4ii7JxOFrgPC83cO1Xj38fJvMnLBA6Czl6m6ryQIaEo5KK3PHXm2kVYnNTEFs8OeEwRTPv/1YMCIIk1zLsPnUg7aOWXYkzID9tBmkXjUlTF58Kki01uBqyDZNXeR2+Bk5sDQJ7oQakmOD/93ZCsJDDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6pTp9fyXjXb6ef9sKI7JEBFifxm6RaZsjR6ZN+fSGs=;
 b=Dgi2SA+5ifwk91WgKIJMpUFzgqNWD+o30LSVTDa79Bg62oXzj4jPRugBKoTn7XlgCaP/hp/zleXn+zebHP8pr2Poj4BNX2Zu5Z9DsqtYBB6mCltkbmuZ6QX6jMAB/EUYrl6RqIqyOVcCm1KyRrT8S995O9f9GELVTo0/U96g8P4KrWaz36rPs8lH/Xc9TQvPiBw1Le9QTpqgOpNk7/VnAwC9m04UMpiSXLPNcKEoAKN73OWINIMwi7yVICliyyzIY2es1GEguq5PsG3lqjKBL1qVw6it1Hr9naq1seQKfLWk9Lb0ftoGKvl1GkaJi0xKs9ZgUVV+5qc9gQtOjsETkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6pTp9fyXjXb6ef9sKI7JEBFifxm6RaZsjR6ZN+fSGs=;
 b=5r1slugcookdxj5jm2MpUGGQpDmPc2RZOjLzRUzzRkVFJUe8fJvE6Tf8QHJ0Ezd4uEPSBBw+N+mbDshQAzxk8JfJsbfyHfy6ChFY4Fforfr0Q9YhKcABncJiq5Zp07PpPKC/j52ilSpe/JxhtswOYxJVpBLUgSO+UCz1gFNcPNg=
Received: from MW3PR06CA0001.namprd06.prod.outlook.com (2603:10b6:303:2a::6)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 09:38:14 +0000
Received: from CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::c7) by MW3PR06CA0001.outlook.office365.com
 (2603:10b6:303:2a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Fri, 14 Jul 2023 09:38:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT085.mail.protection.outlook.com (10.13.174.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.27 via Frontend Transport; Fri, 14 Jul 2023 09:38:14 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 14 Jul
 2023 04:38:13 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdkfd: enable cooperative groups for gfx11
Date: Fri, 14 Jul 2023 05:37:59 -0400
Message-ID: <20230714093759.3246343-2-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230714093759.3246343-1-jonathan.kim@amd.com>
References: <20230714093759.3246343-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT085:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d6a5498-9c48-4a78-0840-08db844e0bce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hFSON0Risx+FvM6VaRLANiJZvE/n5oyZOg6eaNEfJ5kUisFznzMS+k6zRovFYgfGiZCj76uk2NwJALWl2yRXCNkNlBiRdJiioyP8Oqrzc7vdFspCf1uQWZDmJD7/2syWAsncyPsBBgEnrfqL5du/ov232zLqOSWQQOnwgCDSKCXDXh4/p/3ya6nD88IvoA91Vs0VdWggDtLMe/Q4+YqppCxnD5lHD1Canli2pzciHVsZone7K8kwyQe/monqao53YsVeNOyS7Fnqw3CcFlD++gkG1OEGKJScxHYZeyAfaAXrTP3ibPnvPXHRVd29yQsa8S8fi1Ur7NENkJJAQbonANerRvQic5AIxfL3b59t+ug3C+o5GIc2+U5snagFYM0XE7cBqFzc4wwBzOnN2XJQxEd7bAzfclNU8NmYDyA3xJttBF3IOTjo7NHDIUdhPM+JlT+EelujmwyAIHE/wWkR1/Q075lacdPF7y4Q0SnlpbOazo9z7rezDaZ+EoP++Q4Df/ZciMf7Ck/IZaKtD9X+BIOuB+JRsdM2IvIhEPGrT2KWsjkd8d6iAizmvMoh6WB7ciEN1FISK6OeCrdwZs6R976aVSFo79by4YtfbiG5NsNbU47uvd134ezxwH8TpLMe49uyRP1N+olSxEfpM3m+ilu1sE3smmvFijE+rPto32hGP4/KiTxBcP3jn0EHj2y/61FWn07IzhvZtodzRX9pa941tL9RZh5HZcXU5F3NzLVnCnK89RvENHYzCIx5bnNXGNlHpleCDHGDb0DmAwu6EQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(82740400003)(81166007)(356005)(86362001)(82310400005)(36756003)(40460700003)(40480700001)(8936002)(1076003)(26005)(6666004)(54906003)(41300700001)(8676002)(44832011)(336012)(186003)(5660300002)(2906002)(2616005)(426003)(4326008)(47076005)(316002)(83380400001)(36860700001)(70586007)(70206006)(478600001)(6916009)(16526019)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 09:38:14.2018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6a5498-9c48-4a78-0840-08db844e0bce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MES can concurrently schedule queues on the device that require
exclusive device access if marked exclusively_scheduled without the
requirement of GWS.  Similar to the F32 HWS, MES will manage
quality of service for these queues.
Use this for cooperative groups since cooperative groups are device
occupancy limited.

Since some GFX11 devices can only be debugged with partial CUs, do not
allow the debugging of cooperative groups on these devices as the CU
occupancy limit will change on attach.

In addition, zero initialize the MES add queue submission vector for MES
initialization tests as we do not want these to be cooperative
dispatches.

NOTE: FIXME MES FW enablement checks are a placeholder at the moment and
will be updated when the binary revision number is finalized.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c               |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h               |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c              |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c                |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c               |  6 +++++-
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c |  9 ++++-----
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c    | 11 +++++++----
 drivers/gpu/drm/amd/include/mes_v11_api_def.h         |  4 +++-
 9 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index e9091ebfe230..8d13623389d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -638,7 +638,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 {
 	struct amdgpu_mes_queue *queue;
 	struct amdgpu_mes_gang *gang;
-	struct mes_add_queue_input queue_input;
+	struct mes_add_queue_input queue_input = {0};
 	unsigned long flags;
 	int r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 2d6ac30b7135..2053954a235c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -224,6 +224,7 @@ struct mes_add_queue_input {
 	uint32_t	is_kfd_process;
 	uint32_t	is_aql_queue;
 	uint32_t	queue_size;
+	uint32_t	exclusively_scheduled;
 };
 
 struct mes_remove_queue_input {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 1bdaa00c0b46..8e67e965f7ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -214,6 +214,8 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *mes,
 	mes_add_queue_pkt.is_aql_queue = input->is_aql_queue;
 	mes_add_queue_pkt.gds_size = input->queue_size;
 
+	mes_add_queue_pkt.exclusively_scheduled = input->exclusively_scheduled;
+
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
 			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
 			offsetof(union MESAPI__ADD_QUEUE, api_status));
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 40ac093b5035..e18401811956 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1487,7 +1487,8 @@ static int kfd_ioctl_alloc_queue_gws(struct file *filep,
 		goto out_unlock;
 	}
 
-	if (!kfd_dbg_has_gws_support(dev) && p->debug_trap_enabled) {
+	if (p->debug_trap_enabled && (!kfd_dbg_has_gws_support(dev) ||
+				       kfd_dbg_has_cwsr_workaround(dev))) {
 		retval = -EBUSY;
 		goto out_unlock;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index ccfc81f085ce..895e7f690fd0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -753,7 +753,8 @@ int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
 		if (!KFD_IS_SOC15(pdd->dev))
 			return -ENODEV;
 
-		if (!kfd_dbg_has_gws_support(pdd->dev) && pdd->qpd.num_gws)
+		if (pdd->qpd.num_gws && (!kfd_dbg_has_gws_support(pdd->dev) ||
+					  kfd_dbg_has_cwsr_workaround(pdd->dev)))
 			return -EBUSY;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 0b3dc754e06b..9f4f75fd2fb2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -508,6 +508,7 @@ static int kfd_gws_init(struct kfd_node *node)
 {
 	int ret = 0;
 	struct kfd_dev *kfd = node->kfd;
+	uint32_t mes_rev = node->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK;
 
 	if (node->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS)
 		return 0;
@@ -524,7 +525,10 @@ static int kfd_gws_init(struct kfd_node *node)
 		(KFD_GC_VERSION(node) == IP_VERSION(9, 4, 3)) ||
 		(KFD_GC_VERSION(node) >= IP_VERSION(10, 3, 0)
 			&& KFD_GC_VERSION(node) < IP_VERSION(11, 0, 0)
-			&& kfd->mec2_fw_version >= 0x6b))))
+			&& kfd->mec2_fw_version >= 0x6b) ||
+		(KFD_GC_VERSION(node) >= IP_VERSION(11, 0, 0)
+			&& KFD_GC_VERSION(node) < IP_VERSION(12, 0, 0)
+			&& mes_rev >= 68)))) /* FIXME: Placeholder version */
 		ret = amdgpu_amdkfd_alloc_gws(node->adev,
 				node->adev->gds.gws_size, &node->gws);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 761963ad6154..7e8bc7328a79 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -237,10 +237,9 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	}
 	queue_input.queue_type = (uint32_t)queue_type;
 
-	if (q->gws) {
-		queue_input.gws_base = 0;
-		queue_input.gws_size = qpd->num_gws;
-	}
+	queue_input.exclusively_scheduled = q->properties.is_gws;
+	if (q->properties.is_gws && dqm->gws_queue_count > 1)
+		pr_warn("Runlist is getting oversubscibed.  Expect reduced ROCm performance.\n");
 
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
@@ -250,7 +249,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 			q->properties.doorbell_off);
 		pr_err("MES might be in unrecoverable state, issue a GPU reset\n");
 		kfd_hws_hang(dqm);
-}
+	}
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index ba9d69054119..139c6b58bb7e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -123,7 +123,7 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
 	if (!gws && pdd->qpd.num_gws == 0)
 		return -EINVAL;
 
-	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 3)) {
+	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 3) && !dev->kfd->shared_resources.enable_mes) {
 		if (gws)
 			ret = amdgpu_amdkfd_add_gws_to_process(pdd->process->kgd_process_info,
 				gws, &mem);
@@ -136,7 +136,8 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
 	} else {
 		/*
 		 * Intentionally set GWS to a non-NULL value
-		 * for GFX 9.4.3.
+		 * for devices that do not require GWS but require the formality
+		 * of setting GWS for cooperative groups.
 		 */
 		pqn->q->gws = gws ? ERR_PTR(-ENOMEM) : NULL;
 	}
@@ -173,7 +174,8 @@ void pqm_uninit(struct process_queue_manager *pqm)
 
 	list_for_each_entry_safe(pqn, next, &pqm->queues, process_queue_list) {
 		if (pqn->q && pqn->q->gws &&
-		    KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3))
+		    KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
+				!pqn->q->device->kfd->shared_resources.enable_mes)
 			amdgpu_amdkfd_remove_gws_from_process(pqm->process->kgd_process_info,
 				pqn->q->gws);
 		kfd_procfs_del_queue(pqn->q);
@@ -455,7 +457,8 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 		}
 
 		if (pqn->q->gws) {
-			if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3))
+			if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
+					!dev->kfd->shared_resources.enable_mes)
 				amdgpu_amdkfd_remove_gws_from_process(
 						pqm->process->kgd_process_info,
 						pqn->q->gws);
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index 0997e999416a..b1db2b190187 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -275,7 +275,9 @@ union MESAPI__ADD_QUEUE {
 			uint32_t trap_en		: 1;
 			uint32_t is_aql_queue		: 1;
 			uint32_t skip_process_ctx_clear : 1;
-			uint32_t reserved		: 19;
+			uint32_t map_legacy_kq		: 1;
+			uint32_t exclusively_scheduled	: 1;
+			uint32_t reserved		: 17;
 		};
 		struct MES_API_STATUS		api_status;
 		uint64_t                        tma_addr;
-- 
2.25.1

