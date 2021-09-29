Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09576C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 12:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE63B61452
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 12:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE63B61452
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BDF06EA5F;
	Wed, 29 Sep 2021 12:01:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DB816EA52
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 12:01:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpofQLswTZB7SxRGas0jULC3KqEB3C6Lxp0GbgpA/onVTxDmQitQVgk5jxFtc8c5xu2rJf1KlESz60PjF88fvJqF5/2+C4u4q7ngFrqp2kTjQGPMhMIlciVebw5TE3h2gJkOsEECD8Oaz02T1XC8bFRndMRzWnomrf6x4mO9lPkTYc7SWnX5Ioa2S5bc0kglTjyUH5J6p1BnYAFkBFnhtfWxTPuSIvdNDYNfT8UZveKAqPVKCLbdDKFGGAMjAGJilJOXQsAZ58toiV+NrzHS94Kh/BiKxurCyYm12+pZtDglY9O+8QbyOmLhyFMyQK4yQP0wGpZ5ekRN73f/3Egh2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=e/npfvmHHPiCpYn+hiqbJbZcGwaPTMLjwsbf7qMK1M4=;
 b=L1ly2R2IZgFSIeosVxQIsFBys58jQEbdntjbGF8sfVzKYiVhrCxuz6gm7Y5uY0R4j1OjPT+QcRw/sYgn1aql9nG1aaJfeMyaAsVvxoMwUvk6nxj0XAvjlhAoWRrrwfIAEqWVr9VMufX2M10t+jYTndJpuE8TkmHOZD6SEAThQADxwcjBSZ3XX2ZRKccqUR/H+0LozXOgfWbq5vXc4Cz6Dh+xF51z+l526wk0kJNPUMl0v7r1t0r4ADpgAdwhfmTByTCpSRISSG7c0LOmZOGVTK3D6/8yEQ69CLys1h4BS8ysB8vu2zPD+8YO8Bl8cqwQKr1HJeS+AaqqgXM/hIFwCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/npfvmHHPiCpYn+hiqbJbZcGwaPTMLjwsbf7qMK1M4=;
 b=5OPchkbXbKX+64QH2c7ikj3/Sc96PMBpcksyKbup8hkZOtr+YQ/A597YTIa6/fD3DWUnzmVevBBb8y681jv6dOCqXSIIDkGnVRPoFFVty3jsKbfrl9zYoFj2HEZHvQQNazUnmBdBgbChg9FEZriVCqry7pLXY0Lgawp9yVpVr3A=
Received: from CO2PR05CA0060.namprd05.prod.outlook.com (2603:10b6:102:2::28)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 29 Sep
 2021 12:01:13 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::7) by CO2PR05CA0060.outlook.office365.com
 (2603:10b6:102:2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.7 via Frontend
 Transport; Wed, 29 Sep 2021 12:01:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 12:01:12 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 29 Sep
 2021 07:01:06 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Yat Sin <david.yatsin@amd.com>, Rajneesh Bhardwaj
 <rajneesh.bhardwaj@amd.com>
Subject: [PATCH v3 13/16] drm/amdkfd: CRIU dump/restore queue control stack
Date: Wed, 29 Sep 2021 08:00:35 -0400
Message-ID: <20210929120038.6485-14-david.yatsin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210929120038.6485-1-david.yatsin@amd.com>
References: <20210929120038.6485-1-david.yatsin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1bc38c9-a249-4e5d-8887-08d98340d536
X-MS-TrafficTypeDiagnostic: MN2PR12MB4471:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4471DF6C66D30E51BDBBBED695A99@MN2PR12MB4471.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:204;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9jBl4Y/8juuohzxF2chl+hfBXdvaCePRNWQE6O/GLb8ak+xRJjJqllgWpdk4x53SFICH7yAwto1rfIe9SL0HD0E/70/XL75T7aWG5RM+JSoxoxLdzNo+TIuge2uX7nIGu3QdnQRz51rCByANhUjL50SgL8/ryjyNyHpvv1HijHzuD42eu8iErcfUztzaZeg229pGcDDCQ5r0EqNEZ+oLS2vm7L4KqWoqYwgwD/IkZeulONy7f9Nw1/zuXYrnr5c35Xfqzu7xlgUiJYZeL+qYNHNNIzLRrfiiTbL5jnMffUlBJNRhL5CGEljhjMmbd0h2KESXxdvGymoYs4SlZE69Ln4M2hsZhP6wC5S+Kl25wHgOWC3oSD71yLP34aY1vW20FeOXVMLiSXcXeHz4EPBxxJp0GhaMMV2fi0S9qWmM+HfZSeYWtNxrdQHJOqMWwxjW1+HQ1zDFWWlKFZNUp6itOPfEW5mDRxgFDFTmCQKYX869WkXFBIKJnmJYZHxUUed5Nva1JHGl74RHHQxey9XYBBof0d0ypbB9AAg/8WZ/Hyc32vTsE9Rb21pHNJp3BKjnCs0nyV2FG3JNUpAWSDdEHDjwMr14338iAz2j2Qt2KxM3m+Gd39ARAm2YKxJAYg7PDVMK9hHl7YFZh5wCIIScFCXB3XHhaeNrNQtQsxiJnfLEoAebjDNhVBUyzRKnDT0qB2HqrtPq7rjT/mI9Mgp6Ppg6X9NOiY5HSYPg+XgHMiCjdbrzda7jOsmKINiD6ZducJ+aY43z83ywe1G3jWlf2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(7696005)(2906002)(16526019)(26005)(508600001)(70586007)(5660300002)(1076003)(82310400003)(186003)(70206006)(8676002)(47076005)(426003)(2616005)(81166007)(6916009)(36756003)(8936002)(6666004)(316002)(54906003)(336012)(83380400001)(30864003)(86362001)(36860700001)(356005)(4326008)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 12:01:12.6363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bc38c9-a249-4e5d-8887-08d98340d536
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471
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

Dump contents of queue control stacks on CRIU dump and restore them
during CRIU restore.

Signed-off-by: David Yat Sin <david.yatsin@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c       |  2 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 23 +++++---
 .../drm/amd/amdkfd/kfd_device_queue_manager.h | 11 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |  8 ++-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  | 10 ++--
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  | 11 ++--
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 26 +++++++--
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   | 19 +++++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         | 11 ++--
 .../amd/amdkfd/kfd_process_queue_manager.c    | 54 ++++++++++++-------
 11 files changed, 125 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index d2130c5a947e..e684fa87cfce 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -312,7 +312,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 			p->pasid,
 			dev->id);
 
-	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id, NULL, NULL,
+	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id, NULL, NULL, NULL,
 			&doorbell_offset_in_process);
 	if (err != 0)
 		goto err_create_queue;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
index c6c0cd47e7f7..3c29e60b967f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
@@ -185,7 +185,7 @@ static int dbgdev_register_diq(struct kfd_dbgdev *dbgdev)
 	properties.type = KFD_QUEUE_TYPE_DIQ;
 
 	status = pqm_create_queue(dbgdev->pqm, dbgdev->dev, NULL,
-				&properties, &qid, NULL, NULL, NULL);
+				&properties, &qid, NULL, NULL, NULL, NULL);
 
 	if (status) {
 		pr_err("Failed to create DIQ\n");
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 3e11111a6a9b..3f394e039791 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -333,7 +333,7 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 				struct queue *q,
 				struct qcm_process_device *qpd,
 				const struct kfd_criu_queue_priv_data *qd,
-				const void *restore_mqd)
+				const void *restore_mqd, const void *restore_ctl_stack)
 {
 	struct mqd_manager *mqd_mgr;
 	int retval;
@@ -395,7 +395,8 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 
 	if (qd)
 		mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj, &q->gart_mqd_addr,
-				     &q->properties, restore_mqd);
+				     &q->properties, restore_mqd, restore_ctl_stack,
+				     qd->ctl_stack_size);
 	else
 		mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
 					&q->gart_mqd_addr, &q->properties);
@@ -1342,7 +1343,7 @@ static void destroy_kernel_queue_cpsch(struct device_queue_manager *dqm,
 static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 			struct qcm_process_device *qpd,
 			const struct kfd_criu_queue_priv_data *qd,
-			const void *restore_mqd)
+			const void *restore_mqd, const void *restore_ctl_stack)
 {
 	int retval;
 	struct mqd_manager *mqd_mgr;
@@ -1388,9 +1389,11 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 	 * updates the is_evicted flag but is a no-op otherwise.
 	 */
 	q->properties.is_evicted = !!qpd->evicted;
+
 	if (qd)
 		mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj, &q->gart_mqd_addr,
-				     &q->properties, restore_mqd);
+				     &q->properties, restore_mqd, restore_ctl_stack,
+				     qd->ctl_stack_size);
 	else
 		mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
 					&q->gart_mqd_addr, &q->properties);
@@ -1783,7 +1786,8 @@ static int get_wave_state(struct device_queue_manager *dqm,
 
 static void get_queue_dump_info(struct device_queue_manager *dqm,
 			const struct queue *q,
-			u32 *mqd_size)
+			u32 *mqd_size,
+			u32 *ctl_stack_size)
 {
 	struct mqd_manager *mqd_mgr;
 	enum KFD_MQD_TYPE mqd_type =
@@ -1792,13 +1796,18 @@ static void get_queue_dump_info(struct device_queue_manager *dqm,
 	dqm_lock(dqm);
 	mqd_mgr = dqm->mqd_mgrs[mqd_type];
 	*mqd_size = mqd_mgr->mqd_size;
+	*ctl_stack_size = 0;
+
+	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE && mqd_mgr->get_dump_info)
+		mqd_mgr->get_dump_info(mqd_mgr, q->mqd, ctl_stack_size);
 
 	dqm_unlock(dqm);
 }
 
 static int dump_mqd(struct device_queue_manager *dqm,
 			  const struct queue *q,
-			  void *mqd)
+			  void *mqd,
+			  void *ctl_stack)
 {
 	struct mqd_manager *mqd_mgr;
 	int r = 0;
@@ -1818,7 +1827,7 @@ static int dump_mqd(struct device_queue_manager *dqm,
 		goto dqm_unlock;
 	}
 
-	mqd_mgr->dump_mqd(mqd_mgr, q->mqd, mqd);
+	mqd_mgr->dump_mqd(mqd_mgr, q->mqd, mqd, ctl_stack);
 
 dqm_unlock:
 	dqm_unlock(dqm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 90260a3e4037..1603d7af08fe 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -92,7 +92,8 @@ struct device_queue_manager_ops {
 				struct queue *q,
 				struct qcm_process_device *qpd,
 				const struct kfd_criu_queue_priv_data *qd,
-				const void *restore_mqd);
+				const void *restore_mqd,
+				const void *restore_ctl_stack);
 
 	int	(*destroy_queue)(struct device_queue_manager *dqm,
 				struct qcm_process_device *qpd,
@@ -142,9 +143,13 @@ struct device_queue_manager_ops {
 				  u32 *save_area_used_size);
 
 	void	(*get_queue_dump_info)(struct device_queue_manager *dqm,
-				  const struct queue *q, u32 *mqd_size);
+				  const struct queue *q, u32 *mqd_size,
+				  u32 *ctl_stack_size);
 
-	int	(*dump_mqd)(struct device_queue_manager *dqm, const struct queue *q, void *mqd);
+	int	(*dump_mqd)(struct device_queue_manager *dqm,
+				  const struct queue *q,
+				  void *mqd,
+				  void *ctl_stack);
 };
 
 struct device_queue_manager_asic_ops {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index e278b69d771e..e29f45eecab6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -99,12 +99,16 @@ struct mqd_manager {
 				  u32 *ctl_stack_used_size,
 				  u32 *save_area_used_size);
 
-	void	(*dump_mqd)(struct mqd_manager *mm, void *mqd, void *mqd_dst);
+	void	(*get_dump_info)(struct mqd_manager *mm, void *mqd, uint32_t *ctl_stack_size);
+
+	void	(*dump_mqd)(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst);
 
 	void	(*restore_mqd)(struct mqd_manager *mm, void **mqd,
 				struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 				struct queue_properties *p,
-				const void *mqd_src);
+				const void *mqd_src,
+				const void *ctl_stack_src,
+				const u32 ctl_stack_size);
 
 #if defined(CONFIG_DEBUG_FS)
 	int	(*debugfs_show_mqd)(struct seq_file *m, void *data);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
index 1d000252080c..acd68134018b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
@@ -275,7 +275,7 @@ static int destroy_mqd(struct mqd_manager *mm, void *mqd,
 					pipe_id, queue_id);
 }
 
-static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst)
 {
 	struct cik_mqd *m;
 
@@ -287,7 +287,8 @@ static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst)
 static void restore_mqd(struct mqd_manager *mm, void **mqd,
 			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 			struct queue_properties *qp,
-			const void *mqd_src)
+			const void *mqd_src,
+			const void *ctl_stack_src, const u32 ctl_stack_size)
 {
 	uint64_t addr;
 	struct cik_mqd *m;
@@ -309,7 +310,7 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
 	qp->is_active = 0;
 }
 
-static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst)
 {
 	struct cik_sdma_rlc_registers *m;
 
@@ -321,7 +322,8 @@ static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst)
 static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
 				struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 				struct queue_properties *qp,
-				const void *mqd_src)
+				const void *mqd_src,
+				const void *ctl_stack_src, const u32 ctl_stack_size)
 {
 	uint64_t addr;
 	struct cik_sdma_rlc_registers *m;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 13be01d1809f..c232d6512b34 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -283,7 +283,7 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 	return 0;
 }
 
-static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst)
 {
 	struct v10_compute_mqd *m;
 
@@ -295,7 +295,8 @@ static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst)
 static void restore_mqd(struct mqd_manager *mm, void **mqd,
 			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 			struct queue_properties *qp,
-			const void *mqd_src)
+			const void *mqd_src,
+			const void *ctl_stack_src, const u32 ctl_stack_size)
 {
 	uint64_t addr;
 	struct v10_compute_mqd *m;
@@ -405,7 +406,7 @@ static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
 	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->kgd, mqd);
 }
 
-static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst)
 {
 	struct v10_sdma_mqd *m;
 
@@ -417,7 +418,9 @@ static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst)
 static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
 			     struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 			     struct queue_properties *qp,
-			     const void *mqd_src)
+			     const void *mqd_src,
+			     const void *ctl_stack_src,
+			     const u32 ctl_stack_size)
 {
 	uint64_t addr;
 	struct v10_sdma_mqd *m;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index c07bea4026d8..db9f138e1135 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -338,22 +338,34 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 	return 0;
 }
 
-static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+static void get_dump_info(struct mqd_manager *mm, void *mqd, u32 *ctl_stack_size)
+{
+	struct v9_mqd *m = get_mqd(mqd);
+
+	*ctl_stack_size = m->cp_hqd_cntl_stack_size;
+}
+
+static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst)
 {
 	struct v9_mqd *m;
+	/* Control stack is located one page after MQD. */
+	void *ctl_stack = (void *)((uintptr_t)mqd + PAGE_SIZE);
 
 	m = get_mqd(mqd);
 
 	memcpy(mqd_dst, m, sizeof(struct v9_mqd));
+	memcpy(ctl_stack_dst, ctl_stack, m->cp_hqd_cntl_stack_size);
 }
 
 static void restore_mqd(struct mqd_manager *mm, void **mqd,
 			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 			struct queue_properties *qp,
-			const void *mqd_src)
+			const void *mqd_src,
+			const void *ctl_stack_src, u32 ctl_stack_size)
 {
 	uint64_t addr;
 	struct v9_mqd *m;
+	void *ctl_stack;
 
 	m = (struct v9_mqd *) mqd_mem_obj->cpu_ptr;
 	addr = mqd_mem_obj->gpu_addr;
@@ -364,6 +376,10 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
 	if (gart_addr)
 		*gart_addr = addr;
 
+	/* Control stack is located one page after MQD. */
+	ctl_stack = (void *)((uintptr_t)*mqd + PAGE_SIZE);
+	memcpy(ctl_stack, ctl_stack_src, ctl_stack_size);
+
 	m->cp_hqd_pq_doorbell_control =
 		qp->doorbell_off <<
 			CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
@@ -460,7 +476,7 @@ static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
 	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->kgd, mqd);
 }
 
-static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst)
 {
 	struct v9_sdma_mqd *m;
 
@@ -472,7 +488,8 @@ static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst)
 static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
 			     struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 			     struct queue_properties *qp,
-			     const void *mqd_src)
+			     const void *mqd_src,
+			     const void *ctl_stack_src, const u32 ctl_stack_size)
 {
 	uint64_t addr;
 	struct v9_sdma_mqd *m;
@@ -531,6 +548,7 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 		mqd->destroy_mqd = destroy_mqd;
 		mqd->is_occupied = is_occupied;
 		mqd->get_wave_state = get_wave_state;
+		mqd->get_dump_info = get_dump_info;
 		mqd->dump_mqd = dump_mqd;
 		mqd->restore_mqd = restore_mqd;
 		mqd->mqd_size = sizeof(struct v9_mqd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index 1fb5ddf82307..e7c492e9b888 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -303,7 +303,13 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 	return 0;
 }
 
-static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+static void get_dump_info(struct mqd_manager *mm, void *mqd, u32 *ctl_stack_size)
+{
+	/* Control stack is stored in user mode */
+	*ctl_stack_size = 0;
+}
+
+static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst)
 {
 	struct vi_mqd *m;
 
@@ -315,7 +321,8 @@ static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst)
 static void restore_mqd(struct mqd_manager *mm, void **mqd,
 			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 			struct queue_properties *qp,
-			const void *mqd_src)
+			const void *mqd_src,
+			const void *ctl_stack_src, const u32 ctl_stack_size)
 {
 	uint64_t addr;
 	struct vi_mqd *m;
@@ -338,7 +345,6 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
 	qp->is_active = 0;
 }
 
-
 static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
 			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 			struct queue_properties *q)
@@ -430,7 +436,7 @@ static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
 	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->kgd, mqd);
 }
 
-static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst)
 {
 	struct vi_sdma_mqd *m;
 
@@ -442,7 +448,8 @@ static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst)
 static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
 			     struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 			     struct queue_properties *qp,
-			     const void *mqd_src)
+			     const void *mqd_src,
+			     const void *ctl_stack_src, const u32 ctl_stack_size)
 {
 	uint64_t addr;
 	struct vi_sdma_mqd *m;
@@ -461,6 +468,7 @@ static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
 
 #if defined(CONFIG_DEBUG_FS)
 
+
 static int debugfs_show_mqd(struct seq_file *m, void *data)
 {
 	seq_hex_dump(m, "    ", DUMP_PREFIX_OFFSET, 32, 4,
@@ -501,6 +509,7 @@ struct mqd_manager *mqd_manager_init_vi(enum KFD_MQD_TYPE type,
 		mqd->destroy_mqd = destroy_mqd;
 		mqd->is_occupied = is_occupied;
 		mqd->get_wave_state = get_wave_state;
+		mqd->get_dump_info = get_dump_info;
 		mqd->dump_mqd = dump_mqd;
 		mqd->restore_mqd = restore_mqd;
 		mqd->mqd_size = sizeof(struct vi_mqd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index c7499b803758..ff8c4480add3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1131,6 +1131,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    unsigned int *qid,
 			    const struct kfd_criu_queue_priv_data *q_data,
 			    const void *restore_mqd,
+			    const void *restore_ctl_stack,
 			    uint32_t *p_doorbell_offset_in_process);
 int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid);
 int pqm_update_queue(struct process_queue_manager *pqm, unsigned int qid,
@@ -1153,9 +1154,13 @@ int amdkfd_fence_wait_timeout(uint64_t *fence_addr,
 			      uint64_t fence_value,
 			      unsigned int timeout_ms);
 
-int pqm_get_queue_dump_info(struct process_queue_manager *pqm, unsigned int qid, u32 *mqd_size);
-int pqm_dump_mqd(struct process_queue_manager *pqm, unsigned int qid, void *dst_mqd);
-
+int pqm_get_queue_dump_info(struct process_queue_manager *pqm,
+			    unsigned int qid,
+			    u32 *mqd_size, u32 *ctl_stack_size);
+int pqm_dump_mqd(struct process_queue_manager *pqm,
+		       unsigned int qid,
+		       void *dst_mqd,
+		       void *dst_ctl_stack);
 /* Packet Manager */
 
 #define KFD_FENCE_COMPLETED (100)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index c6e70ba7c1cc..8ca6deb82bfa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -210,6 +210,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    unsigned int *qid,
 			    const struct kfd_criu_queue_priv_data *q_data,
 			    const void *restore_mqd,
+			    const void *restore_ctl_stack,
 			    uint32_t *p_doorbell_offset_in_process)
 {
 	int retval;
@@ -274,7 +275,8 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			goto err_create_queue;
 		pqn->q = q;
 		pqn->kq = NULL;
-		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd, q_data, restore_mqd);
+		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd, q_data,
+						    restore_mqd, restore_ctl_stack);
 		print_queue(q);
 		break;
 
@@ -294,7 +296,8 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			goto err_create_queue;
 		pqn->q = q;
 		pqn->kq = NULL;
-		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd, q_data, restore_mqd);
+		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd, q_data,
+						    restore_mqd, restore_ctl_stack);
 		print_queue(q);
 		break;
 	case KFD_QUEUE_TYPE_DIQ:
@@ -533,13 +536,15 @@ int pqm_get_wave_state(struct process_queue_manager *pqm,
 static int get_queue_data_sizes(struct kfd_process_device *pdd,
 				struct queue *q,
 				uint32_t *cu_mask_size,
-				uint32_t *mqd_size)
+				uint32_t *mqd_size,
+				uint32_t *ctl_stack_size)
 {
 	int ret;
 
 	*cu_mask_size = sizeof(uint32_t) * (q->properties.cu_mask_count / 32);
 
-	ret = pqm_get_queue_dump_info(&pdd->process->pqm, q->properties.queue_id, mqd_size);
+	ret = pqm_get_queue_dump_info(&pdd->process->pqm, q->properties.queue_id, mqd_size,
+				      ctl_stack_size);
 	if (ret)
 		pr_err("Failed to get queue dump info (%d)\n", ret);
 
@@ -563,13 +568,15 @@ int kfd_process_get_queue_info(struct kfd_process *p, uint32_t *num_queues, uint
 				q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
 				u32 cu_mask_size;
 				u32 mqd_size;
+				u32 ctl_stack_size;
 				int ret;
 
-				ret = get_queue_data_sizes(pdd, q, &cu_mask_size, &mqd_size);
+				ret = get_queue_data_sizes(pdd, q, &cu_mask_size, &mqd_size,
+							   &ctl_stack_size);
 				if (ret)
 					return ret;
 
-				data_sizes += cu_mask_size + mqd_size;
+				data_sizes += cu_mask_size + mqd_size + ctl_stack_size;
 				q_index++;
 			} else {
 				pr_err("Unsupported queue type (%d)\n", q->properties.type);
@@ -589,11 +596,12 @@ static int criu_dump_queue(struct kfd_process_device *pdd,
 			   void *private_data)
 {
 	struct kfd_criu_queue_priv_data *q_data = (struct kfd_criu_queue_priv_data *) private_data;
-	uint8_t *cu_mask, *mqd;
+	uint8_t *cu_mask, *mqd, *ctl_stack;
 	int ret;
 
 	cu_mask = (void *)(q_data + 1);
 	mqd = cu_mask + q_data->cu_mask_size;
+	ctl_stack = mqd + q_data->mqd_size;
 
 	q_bucket->gpu_id = pdd->dev->id;
 	q_data->type = q->properties.type;
@@ -623,7 +631,7 @@ static int criu_dump_queue(struct kfd_process_device *pdd,
 	if (q_data->cu_mask_size)
 		memcpy(cu_mask, q->properties.cu_mask, q_data->cu_mask_size);
 
-	ret = pqm_dump_mqd(&pdd->process->pqm, q->properties.queue_id, mqd);
+	ret = pqm_dump_mqd(&pdd->process->pqm, q->properties.queue_id, mqd, ctl_stack);
 	if (ret) {
 		pr_err("Failed dump queue_mqd (%d)\n", ret);
 		return ret;
@@ -651,6 +659,7 @@ static int criu_dump_queues_device(struct kfd_process_device *pdd,
 		uint64_t q_data_size;
 		uint32_t cu_mask_size;
 		uint32_t mqd_size;
+		uint32_t ctl_stack_size;
 
 		if (q->properties.type != KFD_QUEUE_TYPE_COMPUTE &&
 			q->properties.type != KFD_QUEUE_TYPE_SDMA &&
@@ -662,11 +671,11 @@ static int criu_dump_queues_device(struct kfd_process_device *pdd,
 
 		memset(&q_bucket, 0, sizeof(q_bucket));
 
-		ret = get_queue_data_sizes(pdd, q, &cu_mask_size, &mqd_size);
+		ret = get_queue_data_sizes(pdd, q, &cu_mask_size, &mqd_size, &ctl_stack_size);
 		if (ret)
 			return ret;
 
-		q_data_size = sizeof(*q_data) + cu_mask_size + mqd_size;
+		q_data_size = sizeof(*q_data) + cu_mask_size + mqd_size + ctl_stack_size;
 
 		/* Increase local buffer space if needed */
 		if (q_private_data_size < q_data_size) {
@@ -682,9 +691,10 @@ static int criu_dump_queues_device(struct kfd_process_device *pdd,
 
 		q_data = (struct kfd_criu_queue_priv_data *)q_private_data;
 
-		/* data stored in this order: priv_data, cu_mask, mqd */
+		/* data stored in this order: priv_data, cu_mask, mqd, ctl_stack */
 		q_data->cu_mask_size = cu_mask_size;
 		q_data->mqd_size = mqd_size;
+		q_data->ctl_stack_size = ctl_stack_size;
 
 		ret = criu_dump_queue(pdd, q, &q_bucket, q_data);
 		if (ret)
@@ -807,16 +817,17 @@ static int criu_restore_queue(struct kfd_process *p,
 			      void *private_data)
 {
 	struct kfd_criu_queue_priv_data *q_data = (struct kfd_criu_queue_priv_data *) private_data;
-	uint8_t *cu_mask, *mqd;
+	uint8_t *cu_mask, *mqd, *ctl_stack;
 	struct queue_properties qp;
 	unsigned int queue_id;
 	int ret = 0;
 
 	pr_debug("Restoring Queue: gpu_id:%x queue_id:%u\n", q_bucket->gpu_id, q_data->q_id);
 
-	/* data stored in this order: cu_mask, mqd */
+	/* data stored in this order: cu_mask, mqd, ctl_stack */
 	cu_mask = (void *)(q_data + 1);
 	mqd = cu_mask + q_data->cu_mask_size;
+	ctl_stack = mqd + q_data->mqd_size;
 
 	memset(&qp, 0, sizeof(qp));
 	ret = set_queue_properties_from_criu(&qp, q_bucket, q_data, cu_mask);
@@ -825,7 +836,7 @@ static int criu_restore_queue(struct kfd_process *p,
 
 	print_queue_properties(&qp);
 
-	ret = pqm_create_queue(&p->pqm, dev, NULL, &qp, &queue_id, q_data, mqd, NULL);
+	ret = pqm_create_queue(&p->pqm, dev, NULL, &qp, &queue_id, q_data, mqd, ctl_stack, NULL);
 	if (ret) {
 		pr_err("Failed to create new queue err:%d\n", ret);
 		ret = -EINVAL;
@@ -921,7 +932,10 @@ int kfd_criu_restore_queues(struct kfd_process *p, struct kfd_ioctl_criu_restore
 	return ret;
 }
 
-int pqm_get_queue_dump_info(struct process_queue_manager *pqm, unsigned int qid, u32 *mqd_size)
+int pqm_get_queue_dump_info(struct process_queue_manager *pqm,
+			unsigned int qid,
+			u32 *mqd_size,
+			u32 *ctl_stack_size)
 {
 	struct process_queue_node *pqn;
 
@@ -936,11 +950,14 @@ int pqm_get_queue_dump_info(struct process_queue_manager *pqm, unsigned int qid,
 		return -EOPNOTSUPP;
 	}
 
-	pqn->q->device->dqm->ops.get_queue_dump_info(pqn->q->device->dqm, pqn->q, mqd_size);
+	pqn->q->device->dqm->ops.get_queue_dump_info(pqn->q->device->dqm,
+						       pqn->q, mqd_size,
+						       ctl_stack_size);
 	return 0;
 }
 
-int pqm_dump_mqd(struct process_queue_manager *pqm, unsigned int qid, void *mqd)
+int pqm_dump_mqd(struct process_queue_manager *pqm,
+		       unsigned int qid, void *mqd, void *ctl_stack)
 {
 	struct process_queue_node *pqn;
 
@@ -955,7 +972,8 @@ int pqm_dump_mqd(struct process_queue_manager *pqm, unsigned int qid, void *mqd)
 		return -EOPNOTSUPP;
 	}
 
-	return pqn->q->device->dqm->ops.dump_mqd(pqn->q->device->dqm, pqn->q, mqd);
+	return pqn->q->device->dqm->ops.dump_mqd(pqn->q->device->dqm,
+						       pqn->q, mqd, ctl_stack);
 }
 
 #if defined(CONFIG_DEBUG_FS)
-- 
2.17.1

