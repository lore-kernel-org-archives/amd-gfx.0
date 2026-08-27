Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51008C61DC4
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 19:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA49010F14B;
	Thu, 27 Aug 2026 19:00:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KLcq8ci5";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013028.outbound.protection.outlook.com
 [40.93.196.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98B9510F14B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 19:00:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3EjSoa0ndHCkZDxXd1DHzP8c0uBiKiqxtEsZftLC/9GxydnxfSD+GVZB/eeDmta/M53pkCWaM0MKhRk1La6DykUPvvF7AIWabSsuT8u/j3rr+Qkitn0e2vbUkZHQCmGc1WKTWZQSsXA3wz50KChIUJEE8F2pRgXeMQ58Vup5G61xD6Ltjw9fFITWdoKtLLXpfqwPHuXd1tcJwU0hhLOLIFRk6KLJ54lE6VRDOQLEwMlUSYdTT5shoC0Rc2YdL5K++2/MowR2wy+bg7GjqrZ1RvhtAcpOLPn/xcRfZbnolPeMiNbZnhurpt7Is5g8EHKz31NggtVbZNJvUszNOiGAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LayWcpI5IjvEKRGtezIqLBmT8ZSuYKvqv0uEXacs2ls=;
 b=gJoWx4sjmZNQuOlAhmBWMM7DeXVWYF8GqWqDvBQC/YtckrC9jjz/FVY3+1eumXvhABzVoZnVOy9HXpim0/kXbFFz/57X2/nBLavKdGdhB8CGQxB9MfXTrRMsMXB48ukU9mxY0nu3AAxtnRAhk/lwJwfsg2snP4udL7ameCIiD8Obds6D+FbQChYPzkFfmV4ttBi+OtKjqqinNDqqiI1OtgnCuQOyIJdJjRqB/w2wx4UyXAKNq7wQOcbbB84JzMPFAPiPYawaCcNH3pDvgNWaX5JwTkY1xggO4vAfRifEafdOEOJfOXTA6fBxzCte6N3r69pQFy8D5/pC0okH+Fj23g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LayWcpI5IjvEKRGtezIqLBmT8ZSuYKvqv0uEXacs2ls=;
 b=KLcq8ci5Gbjvy3Z90q1MsLfrLffEFKaF3s/ORyk1biCLQ58AK1qu3SC2JU4AKieuHMyb273Iny0Z13KBFTdhgJfQ39qdjOH0mSQBPyNUf8VNNPxskld8884iPQxGC43aQ+zjntAkn/CZKdfWbw/XTY/S/G+OJifxHPSwMWDui1o=
Received: from MN2PR20CA0058.namprd20.prod.outlook.com (2603:10b6:208:235::27)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 18:59:55 +0000
Received: from BN6PEPF00000076.namprd03.prod.outlook.com
 (2603:10b6:208:235:cafe::89) by MN2PR20CA0058.outlook.office365.com
 (2603:10b6:208:235::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 18:59:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN6PEPF00000076.mail.protection.outlook.com (10.167.248.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 18:59:55 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 13:59:51 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tvrtko.Ursulin@igalia.com>, David Francis <David.Francis@amd.com>
Subject: [PATCH v4 2/2] drm/amdgpu: Add CHANGE_ID option for USERQ ioctl
Date: Thu, 27 Aug 2026 14:59:35 -0400
Message-ID: <20260827185935.89623-2-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827185935.89623-1-David.Francis@amd.com>
References: <20260827185935.89623-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000076:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: b348adf0-21db-4440-9856-08df046d620b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|3023799007|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JmS3TjF085ztg84REtNcS6xdpB3W3Yuv9lac1ryAHsbepoOph7/s5CqIY0xibHppRwMoSAdATdO/doT8ibyLXPFMVqhiUYQyzg5HniU+8SRRyyPJt2oTsDNkPWFdxXTeCa2LGArAFK2TjINREjDcSwEcxpKWuA4OY2fEKN25RKiZEjTnw4f2LXxeCIbpMm7jKMTJP9fNkwDhL+0mwYExKt0OeH5O7djnKpqRQXBg4vTqli7MtHH2ovEf9aZih/pfi2zj7wtrzQ/+QxTID5dXw/MmUmzTkux/7BwGvYs/cXOgaENSb1BrMT6txXekQfmt6buziWustV+AAKrvHKdxgIdl1c7ThDlTcW76KwxEbKpcTd1QLqx8FZUXrxR//lMkf6nhHY010t4S3bk4N/h7nH4d8EZc7DqTHhG+ZiM0a5vg6haK3oXGVszmpOAf9xFJ44AaLyYtPuERPX01JofwqdlK+PRzQf/4u022oP1lLcDRHzFCniRAtiuj7VsShVMRhBrAOqqp7nSJvLWu6A3HPlYZ7Xw4oa2lZW6XGcjpHp/nx40pNEh+4VpCY7SNPlaakjGvimY+PNU0pX+eQART231sEFMWN8y6sLin/0/jy7gmw/95UQS2JPcKQPSFBHdn2DZ8zlfZv2LLJmG33g0nzLiEKezKVgY/LeQPlcJWTfQqgLBU3OZM3kAwmfngVcM2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(3023799007)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SVf8N0GBlcNpZWv0XlZrJBvuLdgn22Y5jMAOZmYs/V32jfRSmgMX2KV7xmaOHekm+M+OwkZg7rKQFxXVHzKecXsnVz1do03gzHdWzpM+5M/2julzZTvvq5Wx/NaklhPmUvw70usqvUBek0T0pKgkRn4c96hY6RP5oyahjcVwc3xBKkXcYFvRUHUvlfOJpepvubV06jOL7u24UyXpho2rvl5+ErLw6U33MX/frJy6GuOoxrRr5cTyzRfTrC5JwWBoGzdHQWZ99/WDt1MeXkj30Aqys3PTyNUXMytjUfJPJMNBMv7llTbmB+3LdyGIFUmW3pJ4wcfMtXqNvrzUtuH3QehB1q8TlUQuswjrW2NtJOh4bkhfUtYJtOZg7Z4wYRWY8o67gpZnIvjPyDq417KBreaTWNoefGRwTjHOiSrHd/UIfVHJ4HfBq24fTXYWVbTo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 18:59:55.2344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b348adf0-21db-4440-9856-08df046d620b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN6PEPF00000076.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627
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

Add a new option to the USERQ ioctl, which is called with
the queue_id of an existing user queue and an unused queue_id,
and changes that queue's id to the new value.

Calling with an invalid new handle will fail. Calling with new_handle
= handle will succeed if that queue exists but not do anything.

A poison queue object is inserted at the old handle during the
rekey to prevent concurrent FREE from destroying the queue or the
old id being reused mid-operation.

Performing this operation on a queue with signals or waits
outstanding is fine, as those hold not the queue_id but a
direct reference to the queue object.

v3: Poison queue and misc fixes

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 60 +++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h             | 17 +++++--
 2 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 32d1787aa7e2..699838042bda 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -35,6 +35,8 @@
 #include "amdgpu_userq_fence.h"
 #include "amdgpu_trace.h"
 
+struct amdgpu_usermode_queue poison_queue;
+
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 {
 	int i;
@@ -852,6 +854,11 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 		break;
 	case AMDGPU_USERQ_OP_LIST:
 		break;
+	case AMDGPU_USERQ_OP_CHANGE_ID:
+		if (!args->change_in.new_queue_id ||
+		    args->change_in.new_queue_id > AMDGPU_MAX_USERQ_COUNT)
+			return -EINVAL;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1010,6 +1017,51 @@ amdgpu_userq_list(struct drm_file *filp, union drm_amdgpu_userq *args)
 	return ret;
 }
 
+static int amdgpu_userq_change_id(struct drm_file *filp, union drm_amdgpu_userq *args)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	struct amdgpu_usermode_queue *queue;
+	int ret = 0;
+
+	if (args->change_in.new_queue_id == args->change_in.queue_id) {
+		if (xa_load(&uq_mgr->userq_xa, args->change_in.queue_id))
+			return 0;
+		return -ENOENT;
+	}
+
+	/* Poison the old handle so it doesn't get freed or reused. */
+	queue = xa_store(&uq_mgr->userq_xa, args->change_in.queue_id, &poison_queue, GFP_KERNEL);
+	if (!queue) {
+		xa_erase(&uq_mgr->userq_xa, args->change_in.queue_id);
+		return -ENOENT;
+	}
+	if (queue == &poison_queue)
+		return -EINVAL;
+
+	ret = xa_insert(&uq_mgr->userq_xa, args->change_in.new_queue_id, queue, GFP_KERNEL);
+	if (ret == -EBUSY) {
+		queue = xa_store(&uq_mgr->userq_xa, args->change_in.queue_id, queue, GFP_KERNEL);
+		if (queue != &poison_queue) {
+			drm_err_once(adev_to_drm(uq_mgr->adev),
+				     "Expected poison queue to remain untouched during userqueue change id");
+			return -EINVAL;
+		}
+	}
+	if (ret == -ENOMEM)
+		return -ENOMEM;
+
+	/* remove the poison */
+	queue = xa_erase(&uq_mgr->userq_xa, args->change_in.queue_id);
+	if (queue != &poison_queue) {
+		drm_err_once(adev_to_drm(uq_mgr->adev),
+			     "Expected poison queue to remain untouched during userqueue change id");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 bool amdgpu_userq_enabled(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
@@ -1046,6 +1098,11 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 
 	case AMDGPU_USERQ_OP_FREE:
 		xa_lock(&fpriv->userq_mgr.userq_xa);
+		queue = xa_load(&fpriv->userq_mgr.userq_xa, args->in.queue_id);
+		if (queue == &poison_queue) {
+			xa_unlock(&fpriv->userq_mgr.userq_xa);
+			return -EINVAL;
+		}
 		queue = __xa_erase(&fpriv->userq_mgr.userq_xa, args->in.queue_id);
 		xa_unlock(&fpriv->userq_mgr.userq_xa);
 		if (!queue)
@@ -1056,6 +1113,9 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 	case AMDGPU_USERQ_OP_LIST:
 		r = amdgpu_userq_list(filp, args);
 		break;
+	case AMDGPU_USERQ_OP_CHANGE_ID:
+		r = amdgpu_userq_change_id(filp, args);
+		break;
 	default:
 		drm_dbg_driver(dev, "Invalid user queue op specified: %d\n", args->in.op);
 		return -EINVAL;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 92738d630eea..37d0efd1eda4 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -330,9 +330,10 @@ union drm_amdgpu_ctx {
 };
 
 /* user queue IOCTL operations */
-#define AMDGPU_USERQ_OP_CREATE	1
-#define AMDGPU_USERQ_OP_FREE	2
-#define AMDGPU_USERQ_OP_LIST	3
+#define AMDGPU_USERQ_OP_CREATE		1
+#define AMDGPU_USERQ_OP_FREE		2
+#define AMDGPU_USERQ_OP_LIST		3
+#define AMDGPU_USERQ_OP_CHANGE_ID	4
 
 /* queue priority levels */
 /* low < normal low < normal high < high */
@@ -464,10 +465,20 @@ struct drm_amdgpu_userq_list_in_out {
 	__u64   entries;
 };
 
+struct drm_amdgpu_userq_change_id_in {
+	/** AMDGPU_USERQ_OP_CHANGE_ID */
+	__u32   op;
+	/** Queue id of some queue */
+	__u32   queue_id;
+	/** Queue id to change that queue to */
+	__u32   new_queue_id;
+};
+
 union drm_amdgpu_userq {
 	struct drm_amdgpu_userq_in in;
 	struct drm_amdgpu_userq_out out;
 	struct drm_amdgpu_userq_list_in_out list_in_out;
+	struct drm_amdgpu_userq_change_id_in change_in;
 };
 
 /* GFX V11 IP specific MQD parameters */
-- 
2.34.1

