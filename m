Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4BCCD4F54
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 18:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7329010F56D;
	Thu, 28 May 2026 18:47:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CrmYwQrp";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012021.outbound.protection.outlook.com
 [40.107.200.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 425BA10F56D
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 18:47:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWDDG4vCBortutY5LdmO11KLmRNAx7Lcq3xmK1g+kVIwQPHSoqjRTi/4jb+BR2WOFHkAk92pyT9HmTFE9G1+rMRptiVD3u2YpEJ0y0XetgfQR2WShqbwqlxPbQhI3gnxNahqAXhC2gfQfz1sA5/ISda7MwbWyRfQT7Cp9if1NgOVLfQFJ0ihgfaTq69ZB+4lcHOoSa6qZHKGE8SM5Z2AdAVyccsOFSmXNZeeh6TDgmUkOiywOrPOBEww46RYhhY7KvlrPs6RXMcdmz295xdSdgKhwcmbk3r/hgPr3et+MwsY9qJwFcYDs2JMsImbvy3fYKMjoW7/XZ7FMQVFulizbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBa6PZIhnfPhld3CegVk3CdSywObu7w+H/hvMtcD0c4=;
 b=wmYt+QbbmE+DWtIb/6I4ppM+onXq/cELqDgMBQfOgvgMlwYep6W4CnG064m68ERsJqXUxnnbvLVujG18bOrdBiw9+Yy4itolUvX/p8a8IU1Rr4fkVB/qPzkwzkxccO0aMeewrik/lBL6TwNDEQG1YeUQq2vy8MnLqss9akBRN0ks3OX8fENHUjJQplr6g9L25035ZLkiLRLv9MtMcJlSF3pz4Wwv5Swp7DIsPCs06yHTTplsx0bymlied9s0285os0itkpS5lGD+FnFFD5QEh0LqjHhdsA9slA0ioRJUP3LcN8uNJNTM4U+lLPe/rZTN6LbYuHcqtHq5eZRaUm62WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBa6PZIhnfPhld3CegVk3CdSywObu7w+H/hvMtcD0c4=;
 b=CrmYwQrp85vujRJKR2R+k9F0fwcYiF3vIpfUD6bp/CGt6juN1ANiPSyvIDIRhETVgq4KfexX0fPgsKTqOiVy1NvZBcQuWKnD+KzXidxwQrzQqJN2jsVDOA9wTwkOfSGgdbT/Oz0+RlLCtKQMatGJDHRQSxxacnqbTB0zmV42mIY=
Received: from BY3PR10CA0003.namprd10.prod.outlook.com (2603:10b6:a03:255::8)
 by DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 18:47:24 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::46) by BY3PR10CA0003.outlook.office365.com
 (2603:10b6:a03:255::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 18:47:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 28 May 2026 18:47:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 13:47:23 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 28 May 2026 13:47:23 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH 3/3] drm/amdkfd: Use memdup_array_user to copy data from/to
 user space at kfd ioctls
Date: Thu, 28 May 2026 13:46:56 -0500
Message-ID: <20260528184656.123149-3-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260528184656.123149-1-xiaogang.chen@amd.com>
References: <20260528184656.123149-1-xiaogang.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|DS7PR12MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: 1203633f-5f56-4d8b-9dc5-08debce98e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: jip7xbN5LEiHHnOWHp2fvc6c94YuH0nLCV+bAlp/1SIArzh08YJPIDVKOMJxL2yc70uqFhmNp4Blk3kNCSgTwgOSmkr6uTaZuXV+EuI5lFSVQI8V6rwwNCodHF5e4ga+rec5RQVR9CRQdzRlfI/X08CRWgzRIPWN1dnuiQPO3jEL9yUnQmWYo8COypUxhTFb/gJvQFLs0/Ia+d4smekr9xbOiXF9UcLbQcd9d5q9Zz9rcFv3IrlEQ+u/RCl0JF3GhqrH1a2X3YopmCSPg6BUn7SBOWcNQOFf+Hg6rUWhIZzSO1AcFySDrVp6Iu/o+JdvntZ5fwIZCAtr1Wl1ymFU84RVODwXYwwnuRvry6tsAGupygzWQeRX9TiWD+9bEt9AblFqqtPtzAcyVyO8alTeSm4ztwxT4srUsCiv384vHn3BgdrmLbgApjYmhRGl/PblNtQpHLwVfws9rqRMJP6hBPASpNOTyJGxX86hZ/hXCOmHKpcL1k/Y1NrC+xkeISeARrCPOyVYGQnVeAuAEegUKSoBT5DUssYnmLwScsIF7/OZIbdQ5ihmgmcMCg51QmymlsrbDvji4bmI9Tn2EXGTzKzsAmxed1HIBIhT0f+c9G8u5L/efOWXyPa6xDiFIMNf7aWzN71mpRl8EGwuE4IRa1wNrWy5NSj1MZ6hv2QCjTpeJgMqQMznS/9Eyq6DLbGC1wbNHAfr5dZHNIL9RjSuRQmJVGH2wFNOy+yC1QgbBZw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U8VV3na5vjLukj7YP32TG6/p274Ag4qtuw+wt99bvdyaJ9NShZ8FEXxVCcGg3lrrt1Sh/AUnDaCHKBe1Z4qtBCIUq9LbdfDDA7KUjheixRH6D+k1BHrO0fC3l+49nSsvI1ja74HNWcHN77WtpKCMgNGQZV5xTpfd9ubgXRb3nglccf1JTrHuGX956FUTVpp3+vKJ03t0LK2P8OwMYA5mhyzKmws6Tpd0UjUUOHTaztZ5UJPEOLZ3xIzAUMMnicUg9tabln0ZwvpMEfpRxaHMp42NtLJ+WbWhTHU1Pt/Kmy0qKtezBoRUDqxXqtqGX8BroGCfEE6DpOdUrruQRSinxq+elQ51E5cxznqIeTQrANQOCete+7mR11gzaetzMAdJx5L4O9Q+c8e7NpR4HChuidNXZa6AjwScSOYAfkW11WJ2HL2ilsxtI0UcZYnpMMHS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:47:23.6982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1203633f-5f56-4d8b-9dc5-08debce98e85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8321
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

Several kfd ioctls need transfer array data from/to user space. Kfd driver
uses kmalloc_array with user provided size. That can oversize alloc or 32-bit
wrap with hostile value. Replace it by memdup_array_user that does overflow
checking and allocates through dedicated slab caches, also physical continuous
as kmalloc.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 46 +++++++-----------------
 1 file changed, 12 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index fc75d0009a57..bb4581f84f12 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1282,18 +1282,11 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 		return -EINVAL;
 	}
 
-	devices_arr = kmalloc_array(args->n_devices, sizeof(*devices_arr),
-				    GFP_KERNEL);
-	if (!devices_arr)
-		return -ENOMEM;
+	devices_arr = memdup_array_user((void*)args->device_ids_array_ptr,
+				       args->n_devices, sizeof(*devices_arr));
 
-	err = copy_from_user(devices_arr,
-			     (void __user *)args->device_ids_array_ptr,
-			     args->n_devices * sizeof(*devices_arr));
-	if (err != 0) {
-		err = -EFAULT;
-		goto copy_from_user_failed;
-	}
+	if (IS_ERR(devices_arr))
+		return PTR_ERR(devices_arr);
 
 	mutex_lock(&p->mutex);
 	pdd = kfd_process_device_data_by_id(p, GET_GPU_ID(args->handle));
@@ -1374,7 +1367,6 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 map_memory_to_gpu_failed:
 sync_memory_failed:
 	mutex_unlock(&p->mutex);
-copy_from_user_failed:
 	kfree(devices_arr);
 
 	return err;
@@ -1399,18 +1391,11 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 		return -EINVAL;
 	}
 
-	devices_arr = kmalloc_array(args->n_devices, sizeof(*devices_arr),
-				    GFP_KERNEL);
-	if (!devices_arr)
-		return -ENOMEM;
+	devices_arr = memdup_array_user((void*)args->device_ids_array_ptr,
+				       args->n_devices, sizeof(*devices_arr));
 
-	err = copy_from_user(devices_arr,
-			     (void __user *)args->device_ids_array_ptr,
-			     args->n_devices * sizeof(*devices_arr));
-	if (err != 0) {
-		err = -EFAULT;
-		goto copy_from_user_failed;
-	}
+	if (IS_ERR(devices_arr))
+		return PTR_ERR(devices_arr);
 
 	mutex_lock(&p->mutex);
 	pdd = kfd_process_device_data_by_id(p, GET_GPU_ID(args->handle));
@@ -1476,7 +1461,6 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 unmap_memory_from_gpu_failed:
 sync_memory_failed:
 	mutex_unlock(&p->mutex);
-copy_from_user_failed:
 	kfree(devices_arr);
 	return err;
 }
@@ -2336,17 +2320,11 @@ static int criu_restore_devices(struct kfd_process *p,
 	if (*priv_offset + (args->num_devices * sizeof(*device_privs)) > max_priv_data_size)
 		return -EINVAL;
 
-	device_buckets = kmalloc_array(args->num_devices, sizeof(*device_buckets), GFP_KERNEL);
-	if (!device_buckets)
-		return -ENOMEM;
+	device_buckets = memdup_array_user((void*)args->devices,
+				          args->num_devices, sizeof(*device_buckets));
 
-	ret = copy_from_user(device_buckets, (void __user *)args->devices,
-				args->num_devices * sizeof(*device_buckets));
-	if (ret) {
-		pr_err("Failed to copy devices buckets from user\n");
-		ret = -EFAULT;
-		goto exit;
-	}
+	if (IS_ERR(device_buckets))
+		return PTR_ERR(device_buckets);
 
 	for (i = 0; i < args->num_devices; i++) {
 		struct kfd_node *dev;
-- 
2.34.1

