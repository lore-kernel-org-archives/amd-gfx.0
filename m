Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12812C98302
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 09:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B93C10EC20;
	Tue, 22 Sep 2026 09:34:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wD90u697";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010003.outbound.protection.outlook.com [52.101.85.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EFFA10EC1C
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 09:34:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0oUjHNfFfHehzatdIimZ5rwuKLP6TZtxGD7PQnGck9OmTqdKfv4c1oJ/oGaKGl6429RZI6WICZiSkoCkHKB51FX5GXWXRaA5UwczFRVTL/Us4gNaRixyA+fLKV3beL5MrTrq4abhwdq85L7+4McV76e02FPZcJknxqNscSXkx18a7Wf1LIdfexhCRvKEPk/cTqqpULwa9CFTI+2M2F9d8jloL1TErswbJzFW075ZZcS1XyXuI6EWBjrmZKvVY42ijHGBCS+gbYxC6jhiW/sveaokOhmEulc3644mR6AQFOK4f9YHmLn7D+PRQK/z/Qto5woR0Vk5U7Rc4+GqX5lOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3SiTno9Milot8YRQrFlkU8dwdfuvHLnGdC1JHzTJ/o=;
 b=r+tlgmxER8vMDCBXqBTbKIR1CWR7YuBhhXeeMHMkD01NYp7y04myfoYKOxXQ7uZ/LN46t0AoxGEFdqrMF/jw+SvVKbSguYcZKfW2063KFuIa2zbAiQdZqgM2DsiIBrI4RlDBaC47rkeNR+YBlXh4Jrs6Vd0SJdXsPi1dBCUbJO67/Rzh6nycPolwbNx0gvoqAtfxYiLIo+jXTyhN91jnM2yRkD8UnIcZHycs50pf718CF14RpvvmCLJPI7VP59kYwbpS4zsIKfe2yj6UCFicYa3RzQfvcBoS7vhsu/arX+QJokk7sRDf/NneBTSw6DOvgrMp3SHRoLNWjZKgSWVVsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3SiTno9Milot8YRQrFlkU8dwdfuvHLnGdC1JHzTJ/o=;
 b=wD90u697RBCgP3h/OFJSX9X8Tg4vITh2f5vy020TTa5DguGZssRAtgdwcuhPyZ+oLVwL28os83qbu8nu9F5eQ8dxvbP2Sqo1einrUy14BwV5e1UoOKPIUfz+6iE67I/16i+EFzvh0DFoobTD+Qrh6vy64gPoOCYaF3/e7Uqf0DA=
Received: from BN0PR02CA0021.namprd02.prod.outlook.com (2603:10b6:408:e4::26)
 by MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Tue, 22 Sep
 2026 09:34:25 +0000
Received: from BN7PEPF00000096.namprd03.prod.outlook.com
 (2603:10b6:408:e4:cafe::81) by BN0PR02CA0021.outlook.office365.com
 (2603:10b6:408:e4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 09:34:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000096.mail.protection.outlook.com (10.167.245.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 09:34:25 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 04:34:23 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [RFC 09/10] drm/amdgpu: implement device PMC handler
Date: Tue, 22 Sep 2026 17:34:35 +0800
Message-ID: <20260922093436.596947-10-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922093436.596947-1-lingshan.zhu@amd.com>
References: <20260922093436.596947-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000096:EE_|MN0PR12MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc6ef0e-806e-4814-8383-08df188cb126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0kiczE4KYYT76YwwtLAYoEYIjRJXbJKmGGoTQHUT0mlYb/8zItMvFQCPnf+iaCVjYw6GudkhPCGrUsnfqDsnR0/jmuKJ/NICammCVT5Zfv/IVAQCm1UMKZ8ONgUb/yneVxIJa3PVfwQ1D9uzF2FJdwTJO8JQRVhoLU2OuNFMBxOgQMJjRALt/FZYuXoMe8n2fEwa+muIlM1hIroBvHdtbVUyQyctA3d/+Vk/FZlDERi1657+SMUE6pWYX21Gj+e2nXRG6kV5APraZ0M0mtxJF5Jrd+ja8fE1QJSj7gTt9is8PdJIc1ADQAMswmOEvit5kF1U8tSgXyXfuUgZMVr558ctb8ZHbMk+SwcaYe+gCpJU9qRyee+CMpPyC6YxlkWxfkunyOlLD+8f+SraGzdprYLNNcbQd237PSn4mwVrLhNU4shVe3McKHcNDg3IHeWCycfS8hxSkXxdw2+M6LcJulusoeyNmaGi/fqjMiWevnowFLghZz57ZtZoZhwcJE4dsVNwCjl1KkEbXuF830QUGasOqZ+Fz4OMEqQwKZSrMeOmSSle680hXSGg0iqk2lKuJZtqvtrNZ70RlexVVnALYiy0VDv2hVWaUAvioUlLh49DfH/0OuxDfTOFa50DFSBTjd0JBsliBMfAgv06Ts1L0hzx5aKvYx0j3BIzyvsxGXJ2niyqFsmf4oor160OD2ioso0g/Y7MWR5Dmne8Vm8r3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XmWybgIohvM8dlYZGAeVY7K0LYB1S4y0gOuyJsFelOUWB3HFDpkOu3q7RjA7BIWz2I8cvf5x2Obz+vzA/Zi70AJ0HE4RjzUM/iukA0wai4dt8rv9rrg3C4ZrqJ6zF2Xt1DZnT4D6QlEWcTexMPdREdVk9CVGNzOqiDiPYUZX1miSKmnVYUHq9lp4X+NT/72lpwbFQ6JDoTZMhhOSyuKdEmqxxDVtEzhmE2rbEoIQiFYQQfItXoqys1sR25p9/8lg1nbFoQ/GpPf3kn5lZYj45Z0AECKRoIYBsCgs/5jorg1zpFw1PICaI8DzuyiQF5MXHAq0QH+pdkR7dwHmyTdfR5dmOWlvBkH7Cc6oAdUICIBQUEqHgW4F3w8TiEMSRFDvm9CR8lcCYOJc6njI/HkpWcYGK50iXviAO+yYkPmYhRmA41wPTe7tpDruvEhRowDR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 09:34:25.6088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc6ef0e-806e-4814-8383-08df188cb126
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000096.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762
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

This commit implements device PMC handler

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c    | 68 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h    |  2 +
 3 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
index 254fb8d77d80..f40c848331a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -95,7 +95,11 @@ int amdgpu_profiler_set_perfcount(struct amdgpu_device *adev,
 
 	mutex_unlock(&adev->pmc_profiler.lock);
 
-	return ret;
+	if (ret)
+		return ret;
+
+	/* no racings because the device was reserved by pmc_profiler.owner */
+	return amdgpu_set_perfcount(adev, enable);
 }
 
 static int amdgpu_profiler_check_access(struct drm_device *dev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 45e4225c0201..8a1f0841e8e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1541,6 +1541,74 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
 	return 0;
 }
 
+static void amdgpu_userq_set_perfcount(struct amdgpu_usermode_queue *queue,
+				       bool enable)
+{
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_mqd *mqd_funcs = &adev->mqds[queue->queue_type];
+	int r;
+
+	/* IP does not support PMC */
+	if (!mqd_funcs->set_mqd_perfcount)
+		return;
+
+	mutex_lock(&uq_mgr->userq_mutex);
+	queue->userq_prop->perfcount_enable = enable;
+
+	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+		r = amdgpu_userq_unmap_helper(queue);
+		if (r) {
+			drm_file_err(uq_mgr->file,
+				     "Failed to unmap user queue %llu when updating PMC\n",
+				     queue->doorbell_index);
+		} else {
+			mqd_funcs->set_mqd_perfcount(queue->mqd.cpu_ptr,
+						     queue->userq_prop);
+			r = amdgpu_userq_map_helper(queue);
+			if (r)
+				drm_file_err(uq_mgr->file,
+					     "Failed to map user queue %llu when updating PMC\n",
+					     queue->doorbell_index);
+		}
+	} else {
+		drm_dbg_driver(adev_to_drm(adev),
+			       "user queue  %llu is in state %d, skip it when updating PMC\n",
+			       queue->doorbell_index, queue->state);
+	}
+
+	mutex_unlock(&uq_mgr->userq_mutex);
+}
+
+/* set perfcount for every queue on the device. */
+int amdgpu_set_perfcount(struct amdgpu_device *adev, bool enable)
+{
+	struct amdgpu_usermode_queue *queue;
+	unsigned long queue_id = 0;
+
+	if (amdgpu_in_reset(adev))
+		return -EIO;
+
+	if (adev->userq_halt_for_enforce_isolation)
+		return -EAGAIN;
+
+	queue = amdgpu_userq_xa_find(&adev->userq_doorbell_xa, &queue_id);
+	while (queue) {
+		amdgpu_userq_set_perfcount(queue, enable);
+		amdgpu_userq_put(queue);
+
+		if (queue_id == ULONG_MAX)
+			break;
+
+		/* find next queue */
+		queue_id++;
+		queue = amdgpu_userq_xa_find(&adev->userq_doorbell_xa,
+					     &queue_id);
+	}
+
+	return 0;
+}
+
 int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						  u32 idx)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 4c9a71b56792..2fcde5955d4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -189,6 +189,8 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						  u32 idx);
 int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
+
+int amdgpu_set_perfcount(struct amdgpu_device *adev, bool enable);
 void amdgpu_userq_reset_work(struct work_struct *work);
 void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
 int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
-- 
2.55.0

