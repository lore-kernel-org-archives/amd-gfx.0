Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0BF606A31B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=C7pPuHxc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF3EC10E264;
	Wed,  4 Nov 2026 15:55:12 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011044.outbound.protection.outlook.com [52.101.62.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF14910E264
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 15:55:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGpHLAsVzN8OwlKDAW6zzxtN91c+3xiXhq6QSO2fXV9IMNRcVzPNxHVOgQKqs/xSLajtwEUWPl+3YIShuNSH4umBwJeHg99JCDPj+VADlQRjNxLNI4aqS9Ue4Gc/zXmAwF5WA/3+Qu5uEIYoKIUHvqj2KSFE9pe1xikIh9vahpdv4yKJrv8hJmFv58t1VzUl+9eTeqhPR+uWk6mfB8ZcWt3LBPSknVLsdjv7KjgLUIEFwUgJPLUMjlUMJ4DIHJA7HuKPusWwoYiFtXsS3hD35C7yzrZbiNhfSlAyNeNNo3fGKgHqYygMeHqtr0EZEYqvQS5ofF3Q7ITnLZYW/aVFFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAmBEN6vrsL4UpP4pbV2ihJ34gaS6/3O1XVJNikeZI8=;
 b=yESIWlLe8h9fYt5V1cRb3hfBkBKRsaH4mgHDHmWcwOoutx0Jh5fb7mXBSXS1j6pb2PBQpbFXNjOWP48G8k4VRRdUSoJsi5zCIJ4XAVYeAJwdIX0OeGoJ9WSR95VFFYLGWjE70veLtD3qU+5vhPsO3F29Sv0gAXUB623tU56vrnEyLX3CwkEf+Dm6KazFE/o/7ESMXWv5yQa2VRM2KHj1eyjGv137YwVqf8xsAVJBfoCKNyfFb/zpwS7cSkC0XioWsAJMDFOJfiD0TKVeaIztv3ckYJdu2fv74EQJ9n9K9o6iuRECGw5imMKsHGg2tdezLTfNsD5gorvGOzK5oL7kYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAmBEN6vrsL4UpP4pbV2ihJ34gaS6/3O1XVJNikeZI8=;
 b=C7pPuHxcGWziLFrQ59ft8PNLqE9Z9QzxhSPWLGgNI1bejl72u8hoqNo7fdAUYXtS50MoS30nBM3u5W74oU1uz4SPC91i7Ynbvs2PwWu3Kq78wWKl7WDlb8fA43ZvIcB2HBLIYK+u0zX7TUJ7aP95HZJ90LuafddWSUHmPseORgQ=
Received: from BLAPR03CA0046.namprd03.prod.outlook.com (2603:10b6:208:32d::21)
 by MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 15:52:20 +0000
Received: from BN1PEPF0001806E.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::ae) by BLAPR03CA0046.outlook.office365.com
 (2603:10b6:208:32d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Wed, 4
 Nov 2026 15:52:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001806E.mail.protection.outlook.com (10.167.245.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 15:52:20 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 09:52:19 -0600
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, David Francis <David.Francis@amd.com>
Subject: [PATCH v4 2/2] drm/amdkfd: Acquire cwsr buffer during CRIU resume
Date: Wed, 4 Nov 2026 10:52:03 -0500
Message-ID: <20261104155203.3826257-2-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104155203.3826257-1-David.Francis@amd.com>
References: <20261104155203.3826257-1-David.Francis@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001806E:EE_|MN6PR12MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aaefa1a-2913-4e3d-9f8a-08df3a8b9c00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|10067099003|22082099003|18002099003|261022105027099003|261102123227099003|11063799006|261021121427099003|261021123027099003|261028144727099003|261026121527099003|261026140227099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: XO5l5fSnjTBV7B7mVzrkEGY+ypEU6x7xgpMH4kCpu0C69K2jhnR0AjfoT4oU9FXH2SUAQQSsQzkrGNqrN9LrbmInAOxySweCjakFi6MDwbxBLLrr4WDs7EfzJyLK1kevFI+5bl/q+U6tHw1EZi9tkvke020DolNqJdQRRpNQegG4zWzMP/H+Uf2fPK7iGwvzKI9Zuslnw4nlKe5rBpklJXs9rrGEgwQxNVbKdF6uWcBBjHfWzyqvDi+egnWNoiA7Inrm1l9lUGNOsIWnaUke0k6gw4ACyYUojVgRWSm8KV4GZ2WaWnLuH8U/FDJXBCRwBmC8COcmVnmvvGMU8M9g2BMY1YI+eDB/ILjqMS3S7BtHRmk7Lk8wTVuTFUPRZFruVnzdhFbg4kbBfZQgsBB2C/Uy6V2VW5eoxKEIOxPhutM+7Gvoqb0ck2rICzR/YK6pM2Vi+FARJjpGHI0VSlnPXxj6q0vbkLWXufzUt/smqHUoJwrEDMTu2actlD2m/h3cUOyZsdUOBzjPfcpKU1HZxcWbSwojWhY4EgA9Wt2rUuPTBZ2AOBHHX9MEg8Huri0OMA7W/ONJhPYURkNsx1CpcaIusHM/dDOpyiIZtr1v0kGjpbzuOixpyv3SFUSXVbJ6s9fv5chbTItgazOKuMHcKV7ER3VPfMNvOug95SzHtr3coEk4yPN3kySNVBdulpOIJkjWbHzMgCGQyXISRgiNqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(10067099003)(22082099003)(18002099003)(261022105027099003)(261102123227099003)(11063799006)(261021121427099003)(261021123027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0a5uwioyyQb1/LzjlkvfhSQ6OPCi/ETw+GHa+05eD0kmkyN6kyy06rdvXJyh13+Emt/ffvTMjcCKlsP7N6aNcqtO9OfJAwgdgwCGSGE8/c4AFPsE1CU11ngfFOr/9pNyXqzDNcuyiKSKowyiBxbvrI1lRicRHbveSEsYPQlbO/68XXq2qwpkFO99T3JiOspVOpojgkou8UkJLBo0ZmS/SLq9X0Wev6kNlLAt6o3L8ggObWj9LxzN6ayPvQ72Q1oq40YgAOBntH1hcFl1WvrzDaVpX965WpATuklzhBY86ooNhxg5g61yvguqHR+jR9zJrbUyM53+udxZnqdRwBmTk5yHEIAXxDkhEPGOGOIPJxLSFlNS4Vim2w1FNEyWBRBrC+4vlRJ0vot6N/Uc+DXjsHRiBASeZ1D4zGEWBNfp9SWiBXVjnnbmDCqvOWXVZTBN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:52:20.1618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aaefa1a-2913-4e3d-9f8a-08df3a8b9c00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001806E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In normal kfd queue create, a reference to the cwsr svm range
is acquired so that this buffer is not freed from underneath the
queue. We weren't doing that.

After svm ranges are restored in RESUME phase of CRIU, go through
all the queues and acquire a reference to the cwsr.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 ++
 .../amd/amdkfd/kfd_process_queue_manager.c    | 28 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |  4 +--
 4 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index d8233337b8d5e..6094a6dfdd90b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2861,6 +2861,8 @@ static int criu_resume(struct file *filep,
 		goto exit;
 	}
 
+	kfd_criu_resume_queues(target);
+
 	ret =  amdgpu_amdkfd_criu_resume(target->kgd_process_info);
 	if (ret)
 		pr_err("amdgpu_amdkfd_criu_resume failed for %i\n", args->pid);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index eb4d35a42e917..a502dc2f3c8a0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1371,6 +1371,8 @@ int kfd_criu_restore_event(struct file *devkfd,
 			   uint8_t __user *user_priv_data,
 			   uint64_t *priv_data_offset,
 			   uint64_t max_priv_data_size);
+
+int kfd_criu_resume_queues(struct kfd_process *p);
 /* CRIU - End */
 
 /* Queue Context Management */
@@ -1387,6 +1389,7 @@ void kfd_queue_unref_bo_va(struct amdgpu_vm *vm, struct amdgpu_bo **bo);
 int kfd_queue_unref_bo_vas(struct kfd_process_device *pdd,
 			   struct queue_properties *properties);
 void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev);
+int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size);
 
 struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
 		struct kfd_node *dev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 6e19be9e89f57..90e6cbb9cd2b4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -1124,6 +1124,34 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 	return ret;
 }
 
+int kfd_criu_resume_queues(struct kfd_process *p)
+{
+	int ret, i;
+	u64 total_cwsr_size;
+
+	for (i = 0; i < p->n_pdds; i++) {
+		struct kfd_process_device *pdd = p->pdds[i];
+		struct kfd_topology_device *topo_dev;
+		struct queue *q;
+
+		topo_dev = kfd_topology_device_by_id(pdd->dev->id);
+
+		list_for_each_entry(q, &pdd->qpd.queues_list, list) {
+			total_cwsr_size = q->properties.ctx_save_restore_area_size +
+					  topo_dev->node_props.debug_memory_size;
+			total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
+
+			ret = kfd_queue_buffer_svm_get(pdd, q->properties.ctx_save_restore_area_address,
+						       total_cwsr_size);
+			if (ret)
+				return ret;
+		}
+
+	}
+
+	return 0;
+}
+
 int pqm_get_queue_checkpoint_info(struct process_queue_manager *pqm,
 				  unsigned int qid,
 				  uint32_t *mqd_size,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 18d24ddb455eb..78de556da056c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -88,7 +88,7 @@ void uninit_queue(struct queue *q)
 
 #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
 
-static int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
+int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
 {
 	struct kfd_process *p = pdd->process;
 	struct list_head update_list;
@@ -182,7 +182,7 @@ static void kfd_queue_buffer_svm_put(struct kfd_process_device *pdd, u64 addr, u
 }
 #else
 
-static int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
+int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
 {
 	return -EINVAL;
 }
-- 
2.34.1

