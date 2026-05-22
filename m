Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C1CCD5BAB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C7CE10F494;
	Fri, 22 May 2026 00:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CIVZ0Au7";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7EA610F487
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:22:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6TjbKLVCZrG7EhqxD3OPCzHFeoW1RNK1pttQfChljycbMxTKaSO7PMORxL3jETHHfU624xZOVUYPIQeH26gmh11hLRPRELn9vcmuHeVTVsmztbnSu9KgB8NM/1BCC2+N2VWNvTBpwf6ubKtRw8UcRN0Hog6UB2zlPHJJr4xo4JHOvlgZR+3cKUFU0m8vibHkodNgBMrsWNThobuyClRVBUwavVSgGiPwRHxTeV7ddmX72qwp24CO8RdF0XrLjmIsdOHQ/Wl6zRNQMNoBeWMypEc00PbUQw9c/uE0fOM6bBvrSpzOoIqcJ9YrhorxvbqSIkAZB7YDvRzYMrBLFHfiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNqkgS/Epx/ACaUq1pt6P9sib/Hfjo4BxaG+8zHgX8w=;
 b=kmuOHUa6ttLHjHF3cxW8bYy4L2ZNKuTg3Ig+yBffsTjlwurTVN+sMaIoRcoY6AvcUmQ3j+BrZoKmBL1OJRXKH/n0/og1HgJVbIKySoSOTyueJEbyXzavc5w5fFoxcQRCd4pTYETL/ol3+PKXwMAb7pHjTDZ+gsCvq1BEE+qRpfsvnOgf1cEM1tuEtUQpAo2ssmN/F6EUBCeNy3qSb2eO9c9nKfZKl8Yzf5CnHIxucObaVnw/kqFlwACy+vF0dbPqVTomLuH2NcZ2kbsTKquzFtU7/rdHNZ+HQSz6cb197WweUrafhu/Ye+2E3TITYTBNWwGobAqScSWvL/w9OEdDQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNqkgS/Epx/ACaUq1pt6P9sib/Hfjo4BxaG+8zHgX8w=;
 b=CIVZ0Au7xMscS9Mxc04udu1lombwVdAWtgDShSD8hI74ssnDcHcbQ0ERjwdMTmHBKHqetP53rMWLsN2hzBGdpzu8PZSWR+8kQqZVUoQ3MFEMQ67vv/DNFkjDOuejW8OI+oweVY1W18rz+whqXaYmkP8paHIUa2SoNFRhYPfU1DA=
Received: from DS7P220CA0065.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::29) by
 DS0PR12MB7535.namprd12.prod.outlook.com (2603:10b6:8:13a::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.17; Fri, 22 May 2026 00:22:22 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:8:224:cafe::c5) by DS7P220CA0065.outlook.office365.com
 (2603:10b6:8:224::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:22:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:22:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Thu, 21 May
 2026 19:22:11 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 May
 2026 19:22:11 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:22:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 35/42] drm/amdkfd: plumb a helper to reset a KFD user queue
Date: Thu, 21 May 2026 20:20:41 -0400
Message-ID: <20260522002048.98506-36-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|DS0PR12MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: b13063ec-980a-4e7a-4be2-08deb798311a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|3023799007|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Hr+7t2e/dXatdE0pJHvpM/yAWxvUGYHNDPSyyQIk5YCFWYd5wuYShhjK+PmqR0GskOo4SDCcz4HniXFZ0pz/ZDNRI8ye4Q4d2WB9hZZOws17E4TG0gLMslLDNpk16Umw5CqMldrHJ4psryDOr2k1qH1wBp4h6Z4f8Crofu5BQ9G/s4Z4bS2us3k9DRFAFGwna93i6Py0hiAUmtcl+QHgIHBfa5LL/XSTVR+fDI27a0tYEh1yoWArHaz5uS/rh0VrZoZJ/CLRn80lfMy/1wNpXlPKUAaJoUb3rtM5M355GCdUmBYMRxedUGNf5LsEL0oQxRAr+4XGkwdqxZR1akoaC5RX5RvAw0lnUSVA9fciZtwxnol/siAUk0ZVlJxI+9aIxe6qz75EXJmQFLHWlL0nL9IvjSr58Y06hgJqRgxmWwgkYdjEG1/bhauiWvV8e6vn1hcQoaPiLIDtDaEYfaJh0H5hXF30PTGaVI9a+FhY72MUJFiS1OX7hiKFZU8YzPzfem7vzpYV+BTIp4LeneKwu2RB5a7TWwMohkCxnotlmcfHwDDDnTt1PXU8ouTlJo+LP63ghbe40/FDIUDbaCEKo5635OeX4nzBk4qNnyffAaqD1bukysrNYn24CBH67D0Zu8LP8/ogdCrgyRzuPeBe1gWNxSYf5Bi+b8FVA0R+MRaC3yVDDxCVUkUc2W/At5tnkE+mEZcF1443tLK7vIOghe0r9+2HHg83iM5U+AIxEoo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(3023799007)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /4uin+reQHoKgh/LAisbiiBvf8uspDs5Czyjg4HXhkzNmqFE0CjUsHegMj6bZc6BJ6hpowYhXdN9XdPX0KODF8ftsZE6e/duqHTt4bDH0fZ6qysEiqonoe8MTjC19PkFg5/cSjg7rAJROaiXXl3U5z47WSYZANiVc74mG8SwwFYfScHaCPy3PtMtleUTtEIH+b3mYY0Z01Zv6qJWIBS1HgyZTq8sHxQDYLDdjfkWpuzL/7YAo9wfCZsRoHPvSxeHHD2/cPRJHvjMc1ytcHe420NbTwhOq4KuHAQ9wE8x5uSBpMT5FicItnLlUVRS2aNJYkgOptKtJ9ja47+Gx3Np1mTcV9Q4Bt42qIeN/EDA+N9CYg39Q7yoY6uf7abT1CjhV7aB01nJoeB1+BNQoUH2Bwyy1lx99/gySCYFKYnmJnFDB603jU/elvpxz1VB8GvC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:22:21.9159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b13063ec-980a-4e7a-4be2-08deb798311a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7535
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

Can be called from KGD.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 14 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 16 ++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 24 +++++++++++++++++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 11 +++++++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 ++
 5 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 0017d502d1692..ffd059089c56e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -942,3 +942,17 @@ int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, uint32_t xcp_id,
 
 	return r;
 }
+
+/* Reset an MES queue */
+int amdgpu_amdkfd_reset_mes_queue(struct amdgpu_device *adev,
+				  uint32_t node_id,
+				  int queue_type,
+				  int pipe, int queue,
+				  unsigned int db)
+{
+	if (!adev->kfd.init_complete)
+		return 0;
+
+	return kgd2kfd_reset_mes_queue(adev->kfd.dev, node_id, queue_type,
+				       pipe, queue, db);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 5333e052d56db..d403af5fb5526 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -275,7 +275,11 @@ int amdgpu_amdkfd_stop_sched(struct amdgpu_device *adev, uint32_t node_id);
 int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, uint32_t xcp_id,
 	bool core_override_enable, bool reg_override_enable, bool perfmon_override_enable);
 bool amdgpu_amdkfd_compute_active(struct amdgpu_device *adev, uint32_t node_id);
-
+int amdgpu_amdkfd_reset_mes_queue(struct amdgpu_device *adev,
+				  uint32_t node_id,
+				  int queue_type,
+				  int pipe, int queue,
+				  unsigned int db);
 
 /* Read user wptr from a specified user address space with page fault
  * disabled. The memory must be pinned and mapped to the hardware when
@@ -446,6 +450,9 @@ bool kgd2kfd_vmfault_fast_path(struct amdgpu_device *adev, struct amdgpu_iv_entr
 			       bool retry_fault);
 void kgd2kfd_lock_kfd(void);
 void kgd2kfd_teardown_processes(struct amdgpu_device *adev);
+int kgd2kfd_reset_mes_queue(struct kfd_dev *kfd, uint32_t node_id,
+			    int queue_type, int pipe, int queue,
+			    unsigned int db);
 
 #else
 static inline int kgd2kfd_init(void)
@@ -576,5 +583,12 @@ static inline void kgd2kfd_teardown_processes(struct amdgpu_device *adev)
 {
 }
 
+static inline int kgd2kfd_reset_mes_queue(struct kfd_dev *kfd, uint32_t node_id,
+					  int queue_type, int pipe, int queue,
+					  unsigned int db)
+{
+	return 0;
+}
+
 #endif
 #endif /* AMDGPU_AMDKFD_H_INCLUDED */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 9e77c4a842ef7..e87e1b78ca421 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1793,6 +1793,30 @@ void kgd2kfd_teardown_processes(struct amdgpu_device *adev)
 		cond_resched();
 }
 
+int kgd2kfd_reset_mes_queue(struct kfd_dev *kfd, uint32_t node_id,
+			    int queue_type, int pipe, int queue,
+			    unsigned int db)
+{
+	struct kfd_node *node;
+	int ret;
+
+	if (!kfd->init_complete)
+		return 0;
+
+	if (node_id >= kfd->num_nodes) {
+		dev_warn(kfd->adev->dev, "Invalid node ID: %u exceeds %u\n",
+			 node_id, kfd->num_nodes - 1);
+		return -EINVAL;
+	}
+	node = kfd->nodes[node_id];
+
+	ret = kfd_reset_queue_mes(node->dqm, queue_type, pipe, queue, db);
+	if (ret)
+		dev_err(kfd_device, "Error resetting queue\n");
+
+	return ret;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 /* This function will send a package to HIQ to hang the HWS
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 0a59a79ee28be..babf53b7b1bb2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -433,6 +433,17 @@ static int reset_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	return 0;
 }
 
+int kfd_reset_queue_mes(struct device_queue_manager *dqm, int queue_type,
+			int pipe, int queue, unsigned int db)
+{
+	struct queue *q;
+
+	q = find_queue_by_doorbell_offset(dqm, db);
+	if (!q)
+		return 0;
+	return reset_queue_mes(dqm, q, queue_type, pipe, queue, db);
+}
+
 static int reset_queues_mes(struct device_queue_manager *dqm)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index e0b6a47e7722b..2229f8b2f4462 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -333,6 +333,8 @@ int debug_refresh_runlist(struct device_queue_manager *dqm);
 bool kfd_dqm_is_queue_in_process(struct device_queue_manager *dqm,
 				 struct qcm_process_device *qpd,
 				 int doorbell_off, u32 *queue_format);
+int kfd_reset_queue_mes(struct device_queue_manager *dqm, int queue_type,
+			int pipe, int queue, unsigned int db);
 
 static inline unsigned int get_sh_mem_bases_32(struct kfd_process_device *pdd)
 {
-- 
2.54.0

