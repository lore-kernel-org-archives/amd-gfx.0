Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341FAC04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 16:12:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 597ED10E0EB;
	Wed, 28 Sep 2022 16:12:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C7BD10E0EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 16:12:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNNfng/svk+DCHVMqX+QJd1yQ2dHotoxmc6oS5s8mMEOrK5mTYXTU915U1uXMXxA0SCTUT2Ve2NHAP3VA93ivmNUG2oNz/fP+vgY1ke2LKbkX2BvhHBmbl1fSLHnffvcUDMJumAPlVEyQKGESI399wHGMUI+GvAtvZvWpuTUJu6jZR0VNTQ5D2gB6Fo85yo6DWpUrDVQgLQvBgPZ7Rqbllb86ttOW2pl4sb/bbhJA430iiWniIAC4i2DWcRTNWSJymNa3aehSWf6aT+hh5Jg24mBwk7ah6BDvYalZoBM0xB4s0bGghJ7nKTEyybiQXPkdHLj7WRjaoogp2PGRrscqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Zrk22lag3ids/c2hgX5DmIp2OPR5OH4nUI4dlUw40U=;
 b=KZBYoveRgUwzSqDFPBnNMal2u8jmJ7gqv+3XJoi3NWglgZVLHfTG2epx8rBI0e0SkfvXQEUJbYIT8ZXZZ5sOMQcNG/3czUxOb1IBzgZfB+O6On2TpWLtUMwwtyY+tL+Bq5aUQXKzEnt0NRAeP8g0cZ4YcVDsDLMYzj5EbAN1C+mvAxLkBqUX3ohebglQqVTkiirSuXHUb1bPuWmtuCHFYXVB+aRtNT2zBEQ3p5DifFEYFzXDqvMGIrP/gbhvtbN0JLgft5z2+MlBEP3n/cUHVJesQk11SACJTjdj4MrsAV+7kiX04zDe185QCvtj1TVH51ycR+ShO0EIwrO9ly47Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Zrk22lag3ids/c2hgX5DmIp2OPR5OH4nUI4dlUw40U=;
 b=psRbtgKsGk53bwxVdpgh7AvCj8/xnh+pEdASPXLLoaU31iWq+L8gTT6jKoPfLYbxkQ48dRHFX9dXYg+Op0DcvYeEy4ARk0a8yVziOI2GeUgrYQp+cNTklPxE5rjaiocT5d7mqbtxHsDJ94W2j2aidEphRPJB4qVj9PWeySvkS3g=
Received: from BN9PR03CA0549.namprd03.prod.outlook.com (2603:10b6:408:138::14)
 by DS7PR12MB6287.namprd12.prod.outlook.com (2603:10b6:8:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 16:12:16 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::46) by BN9PR03CA0549.outlook.office365.com
 (2603:10b6:408:138::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 16:12:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 16:12:15 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 11:12:11 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 1/1] drm/amdkfd: Track unified memory when switching xnack
 mode
Date: Wed, 28 Sep 2022 12:11:53 -0400
Message-ID: <20220928161153.17523-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT065:EE_|DS7PR12MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ad6e63-d10c-4a08-a23b-08daa16c3630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +iAxe+PUt7JelEceLUu3fr3mYEv4LpnVzEnWeocmYGlWnW8LJdRPJmVoCip0Vl2Y0Mv1Hx3R92x0XyNx2n1bslHLCl9/fgy6/c5jDJL+NRaZBwnCJMUKloO7vNsBCzot1o1AC0MQzARz858xQpICFsNltV+5GSTgQOCJsD7KCSl07CDztc+zxRkb0LTg5xMS5CbRW+voqPDzjG4wD90RJiBPjCJf65tpWEBrjEeFchte6ALitS275tBEsD8xVGKk5NKBiTFa8DTi8BwT3P7CEx+KSRBIjvqqJj8btRX7sZXDcUpJFzpwYlFDlxDLgpRM/pxMeqoNNf6mahnm+NQHNNtg9k3Adt6YYxFLIrkS7DAQjBdYx5/cBdKebsGQDsP9rPRYml0OZE2duiJ/MMPfRFMt0Ob8d7TEdwWhYzHg78ga60ceZnXIYFQ6v7fQgXGNgQTP3pNJ4Rpa+LFpnKKyKBP4wAtSe2/U89lG0fYMgWdWk6DRbbF1ep0OU5SvHrb+SBg3RYjd66OWLTYwpsdercUVu2lIgaBcDdKEiWKPK3PO5uDD+hl7lVQKOAvOsdpcRDA+4+3rEjcuRtA7kNa3fC2lYTxz6y0GhBIUbHie8FFyME3L1l8dgN5MQPFpqGpBeC1rfwoPLzqxf7bjp39qw+VeHBR+5L91adZiDvMxVuN47jH+zoGInR9Hc8kM7klKxSM5CV/SGht0Hfj+YUIYXAnsiKZm3UeHvmOCOmEyAmczz6GLFUR2nKohS38dFERlUXf+T/9KHkAIRJ6KAtRMWfsZ8eEAhmZ4y0kCPUGurfaD7AlX/Bx6n9DziNZpLWZQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199015)(36840700001)(46966006)(40470700004)(36756003)(82310400005)(40480700001)(40460700003)(26005)(47076005)(41300700001)(336012)(7696005)(186003)(83380400001)(16526019)(356005)(426003)(8936002)(2906002)(86362001)(5660300002)(54906003)(70206006)(8676002)(316002)(36860700001)(6666004)(70586007)(478600001)(1076003)(2616005)(6916009)(82740400003)(4326008)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 16:12:15.9043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ad6e63-d10c-4a08-a23b-08daa16c3630
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6287
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Unified memory usage with xnack off is tracked to avoid oversubscribe
system memory, with xnack on, we don't track unified memory usage to
allow memory oversubscribe. When switching xnack mode from off to on,
subsequent free ranges allocated with xnack off will not unreserve
memory. When switching xnack mode from on to off, subsequent free ranges
allocated with xnack on will unreserve memory. Both cases cause memory
accounting unbalanced.

When switching xnack mode from on to off, need reserve already allocated
svm range memory. When switching xnack mode from off to on, need
unreserve already allocated svm range memory.

v5: Handle prange child ranges
v4: Handle reservation memory failure
v3: Handle switching xnack mode race with svm_range_deferred_list_work
v2: Handle both switching xnack from on to off and from off to on cases

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 26 ++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 56 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  1 +
 3 files changed, 76 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 56f7307c21d2..5feaba6a77de 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1584,6 +1584,8 @@ static int kfd_ioctl_smi_events(struct file *filep,
 	return kfd_smi_event_open(pdd->dev, &args->anon_fd);
 }
 
+#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
+
 static int kfd_ioctl_set_xnack_mode(struct file *filep,
 				    struct kfd_process *p, void *data)
 {
@@ -1594,22 +1596,29 @@ static int kfd_ioctl_set_xnack_mode(struct file *filep,
 	if (args->xnack_enabled >= 0) {
 		if (!list_empty(&p->pqm.queues)) {
 			pr_debug("Process has user queues running\n");
-			mutex_unlock(&p->mutex);
-			return -EBUSY;
+			r = -EBUSY;
+			goto out_unlock;
 		}
-		if (args->xnack_enabled && !kfd_process_xnack_mode(p, true))
+
+		if (p->xnack_enabled == args->xnack_enabled)
+			goto out_unlock;
+
+		if (args->xnack_enabled && !kfd_process_xnack_mode(p, true)) {
 			r = -EPERM;
-		else
-			p->xnack_enabled = args->xnack_enabled;
+			goto out_unlock;
+		}
+
+		r = svm_range_switch_xnack_reserve_mem(p, args->xnack_enabled);
 	} else {
 		args->xnack_enabled = p->xnack_enabled;
 	}
+
+out_unlock:
 	mutex_unlock(&p->mutex);
 
 	return r;
 }
 
-#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
 static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 {
 	struct kfd_ioctl_svm_args *args = data;
@@ -1629,6 +1638,11 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 	return r;
 }
 #else
+static int kfd_ioctl_set_xnack_mode(struct file *filep,
+				    struct kfd_process *p, void *data)
+{
+	return -EPERM;
+}
 static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 {
 	return -EPERM;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index cf5b4005534c..ff47ac836bd4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -278,7 +278,7 @@ static void svm_range_free(struct svm_range *prange, bool update_mem_usage)
 	svm_range_free_dma_mappings(prange);
 
 	if (update_mem_usage && !p->xnack_enabled) {
-		pr_debug("unreserve mem limit: %lld\n", size);
+		pr_debug("unreserve prange 0x%p size: 0x%llx\n", prange, size);
 		amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
 					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
 	}
@@ -2956,6 +2956,60 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	return r;
 }
 
+int
+svm_range_switch_xnack_reserve_mem(struct kfd_process *p, bool xnack_enabled)
+{
+	struct svm_range *prange, *pchild;
+	uint64_t reserved_size = 0;
+	uint64_t size;
+	int r = 0;
+
+	pr_debug("switching xnack from %d to %d\n", p->xnack_enabled, xnack_enabled);
+
+	mutex_lock(&p->svms.lock);
+
+	list_for_each_entry(prange, &p->svms.list, list) {
+		list_for_each_entry(pchild, &prange->child_list, child_list) {
+			size = (pchild->last - pchild->start + 1) << PAGE_SHIFT;
+			if (xnack_enabled) {
+				amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
+						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+			} else {
+				r = amdgpu_amdkfd_reserve_mem_limit(NULL, size,
+						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+				if (r)
+					goto out;
+				reserved_size += size;
+			}
+		}
+
+		size = (prange->last - prange->start + 1) << PAGE_SHIFT;
+		if (xnack_enabled) {
+			amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
+						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+		} else {
+			r = amdgpu_amdkfd_reserve_mem_limit(NULL, size,
+						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+			if (r)
+				goto out;
+			reserved_size += size;
+		}
+	}
+
+out:
+	if (r)
+		amdgpu_amdkfd_unreserve_mem_limit(NULL, reserved_size,
+						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+	else
+		/* Change xnack mode must be inside svms lock, to avoid race with
+		 * svm_range_deferred_list_work unreserve memory in parallel.
+		 */
+		p->xnack_enabled = xnack_enabled;
+
+	mutex_unlock(&p->svms.lock);
+	return r;
+}
+
 void svm_range_list_fini(struct kfd_process *p)
 {
 	struct svm_range *prange;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 012c53729516..7a33b93f9df6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -203,6 +203,7 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
 void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
 
 void svm_range_set_max_pages(struct amdgpu_device *adev);
+int svm_range_switch_xnack_reserve_mem(struct kfd_process *p, bool xnack_enabled);
 
 #else
 
-- 
2.35.1

