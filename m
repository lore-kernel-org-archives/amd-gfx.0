Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AACAC61DB9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 09:54:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BBCF10E395;
	Fri, 28 Aug 2026 09:54:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ebP3I2HO";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012007.outbound.protection.outlook.com
 [40.107.200.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C64510E395
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 09:54:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHxe/QuOjkCm6jbFZs/obF2arj+O+mCzWhhiWoYJ/BwX0hSbAwDQabRv3KDaErCMovelZNZ70ACM99EH9oATax0N1l445Mqef1UPn33uaBEb5brO3IsiLJgCsEksxucQsKIVTUV+2jOMHzNWCO1R9F517QwnFH5qrMViTewhBVy806azB0oQrQ2qTxYzfWH+xaRFHLJdZbDxc0Xc9mA+rHnJm0AtHYyQSKhZLLoPMJDmKcSjWOI/pMlwpDMfw+6iY/3TBfP6x9Kjqg1xk9d8Ihs8ZlVciCAaRvdBzFBmIYmVA+hbOzrsYf0oNFi+y+XcPGIv+iZ/9Zs3q5+yC5ArAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vesjpXLH6oRPpbyshfIn2dBRGbVLLw6tnGuCZwCUyZ8=;
 b=CBoPKXHShC7iKUlztqELfczePQ4Ed9qchvUaKuV4BhCqo3uc/Q/+bxKx4+5MxIefQDkgv6gpbktVlPFaKp7U/ZKU/2i7tMekMhe16dfCCsMaHFmcV8KSsffgWU3Z5RNpiwTZ5w91Z//ToFFe43XSZYMIE3EVMvDBemt6o0cbPXrKfePzmlsu/fcs0lZQrnNpG2X7VHmkm/FbJwOHi6O+PTWiUTslb+O6aGxq+Mt0SD9LQa9PWuB3j59F4/O26i9QbE+2ZdMTT1KF2M+u4nBIlFbAcnuW+mnA8wrO+jaCldv2XwoGvjr44sWmh8WmHz+ydOQtBVZF7Lsz+Gy31Xr/OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vesjpXLH6oRPpbyshfIn2dBRGbVLLw6tnGuCZwCUyZ8=;
 b=ebP3I2HOODK15AIe91Br5T0tURqCmj6n/rBYrp2dnFR41xYTogG3i7TY8s3hlWkcVXFeVuIeoTAKecM41IF0A0BswxhBMVvgBqdf9KCE1KKpE4q4lFyWjHKiqjjSIJUUvGR0t1vG8ZPZ8d2Ny+25UpOdLwkTxN2dSEnEmKs4G2Y=
Received: from DS7P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25c::17) by
 SJ0PR12MB6902.namprd12.prod.outlook.com (2603:10b6:a03:484::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.14; Fri, 28 Aug 2026 09:53:58 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:8:25c:cafe::32) by DS7P221CA0025.outlook.office365.com
 (2603:10b6:8:25c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 09:53:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 09:53:57 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 28 Aug
 2026 04:53:55 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH 09/10] drm/amdgpu: free userq by kref_put when fails to create
Date: Fri, 28 Aug 2026 17:53:48 +0800
Message-ID: <20260828095349.9797-10-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828095349.9797-1-lingshan.zhu@amd.com>
References: <20260828095349.9797-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|SJ0PR12MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: d59f897c-5242-45b5-1c48-08df04ea4769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /oESWU27vrWm9Ih5cyyAlChkV3dmFeMRf3nNNUIWJg+GLV+UyT+CB5NtQEiavyBxe25INY7k0S9dI5kXkr9+9//Iy3SpffpSN+g5873rtYXB9r4h2baAOcCO/bGaRXe5asBUQU4I1vvD7jDZaAd5mZK3F59UjZHEzJDHKPwKiwK+3sEeiUL0PaqOOnCnb+FP1wfd6Vrt06ti63DC7Gpa03yBfdbCsJt8R0HuDum0XakaHwxw9aobGu6C7ktAkwTdf5Hn8O1ajw2UsaanERvTS2olwV6kfyuJl3tf0/646UM65NP2CtZnmdBziu4Pp7zQoB4aW5TYFq3zcFYXMnbDsh0r+Tw3l4gEtL2kgKkZv/I0U+b0JpBhmoD/4W6ngPZSXVUUCjamrS7gILYezsBY21/HHGezo8D2VSYZlK6Cp4UIn/XgpHqY9s5CWXEmpdOtnCmATO14HLxiN8lfvyrZ9ifXV9TjP7CZ+ZgKaQxeI5p3SmnvJ91O9mLFlbTJF/quZRAHNRfPqZsb+4Skm+mMOqFc9h2mSj9Hl3oEiDv0T9pP/UqryiUr1GXBy+JlGMhR0xDPimrG6Y7HoxuGm9bm1pRu1TDOeD+/YPeL9Eq3o7X7HezLLoVadsJYD+FJk0boXj2Q5uNsW5EuYAx/Zb1wICdqFfkXuuWSfMdYLDvD8hiPd1YC+B88eqJJnbftLNQFD7c0KeZi/E+3OPTfRrDFdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W9KCRL/0FWibufwGiz0FwVRoA3MjWJfhLsWgr24XoxyXuT09b0iisbHREbqqyY/6O029XhZv40kmYE/JwEM/1wMGUClQuwDlvooea6gz2XoZ0ZAmGXzzMRTlQJu+VtIqnfdFDVNBRPVwiWtSHVVIf4BNt+XV7ymcJEQVVTfjbTypj957pg40U/D8LKWPBTJvdEBxS7I4+QXX+0Mc6g00imGaED8Fa/ug5cRcPcOR60PhHux8iyrHlZle/ZsY4ucHdAafYrImMnOS9MMetd3np1BxdaA1SnYs03i2i7rrnJy9BWx4pc1a/FmnjcP5oZviAsEnf3MEc504hmAp5cZK4jhfp9s9nHclg8u9ucKXp/9TCj33SM0JZkUJjUosgD51oid2QzaDhDwzZBrwD/RqhRhngcMBikB95uKv5nL0A+c0in+uD7b2FdpeA2Ylu5w6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 09:53:57.6035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d59f897c-5242-45b5-1c48-08df04ea4769
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6902
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

In amdgpu_userq_create(), once the user queue is
published to userq_doorbell_xa, other threads could
access the queue from the XArray. But the queue
may fails to map the queue and kfree(queue),
this causes the accessor use-after-free issue.

This commit fixes this issue by properly
get and put the kref of a queue to maintain
the lifecycle of a user queue.

There are some minor improvements in this commit:

1) Early detach the doorbell of a queue when fails to map
a queue, because the map helper set the queue state to HUNG,
and the asynchronous post reset helper amdgpu_userq_post_reset
can find the queue from the XArray and remaps the queue again,
which causes a queue leaking because the user space
already receive an error code for the queue
from amdgpu_userq_create()

2) Use xa_cmpxchg_irq in amdgpu_userq_detach_doorbell().
Once fails to map a queue, the queue destruction process
is asynchronous (a delayed worker), and a new created queue
could re-use the doorbell, xa_cmpxchg_irq compares the doorbell
which to be deleted with the doorbell which @index points to,
so it does not detach the doorbell of the new created queue.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 0dab395ef0f4..21a9a2138fc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -424,7 +424,9 @@ static void amdgpu_userq_detach_doorbell(struct amdgpu_usermode_queue *queue)
 	struct amdgpu_device *adev = queue->userq_mgr->adev;
 
 	down_read(&adev->reset_domain->sem);
-	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
+	/* It doesn't alloc any memory here, so pass 0 to gfp */
+	xa_cmpxchg_irq(&adev->userq_doorbell_xa, queue->doorbell_index,
+		       queue, NULL, 0);
 	up_read(&adev->reset_domain->sem);
 }
 
@@ -836,6 +838,14 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	if (r)
 		goto clean_mqd;
 
+	/*
+	 * Once the queue has been published to doorbell_xa,
+	 * it could be accessed by other threads, so it has to be
+	 * destroyed through kref put. The destroy work decreases
+	 * userq_count, so we have to increase it here.
+	 */
+	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
+
 	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
 
 	/* don't map the queue if scheduling is halted */
@@ -851,12 +861,14 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
 			trace_amdgpu_userq_create_end(queue, r);
+			amdgpu_userq_detach_doorbell(queue);
 			mutex_unlock(&uq_mgr->userq_mutex);
-			goto erase_doorbell;
+			amdgpu_userq_put(queue);
+
+			return r;
 		}
 	}
 
-	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
 	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
@@ -877,8 +889,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	args->out.queue_id = qid;
 	return 0;
 
-erase_doorbell:
-	xa_erase_irq(&adev->userq_doorbell_xa, index);
 clean_mqd:
 	uq_funcs->mqd_destroy(queue);
 clean_doorbell_bo:
-- 
2.53.0

