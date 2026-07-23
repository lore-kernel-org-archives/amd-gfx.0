Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12036C531D0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 18:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E03810E5C9;
	Thu, 23 Jul 2026 18:51:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gNLnwYQE";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011063.outbound.protection.outlook.com [52.101.57.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A70310E5CB
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 18:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e507lyQLDRiejqXD/MuBpDmD9DUHl6mbkpua1bx6JnZbwQPBdWEnCz4TRm1IhBOIa1Rp8oWtr/NyNWuldgHr/HWwKy/uYL3hhU9KcpCT3cGuVZrHtuDk4+5ACtbZ5Z8XzlyCeBHCxSL+kY2UgbDUg40Z+kySOiTrjbalTAOJyeGSE6jCq4PXGxIYTHho1vnLTl7wbnQ6RwzvtWTNuPxY5IRPPmJiUfHdo2/NZk3ntfuGKlvRGv9H6T6vcrUd2q2J4hBeCCnSq7QMifuyqt8bEk1IjTggDXue0gyIz5FRug+vxsMgZjOOULURochLmcxlddcWFlXsGVdmODDmCA05eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qz9lm2hkHZpC8K3cdPX47wcpxNoAsrl9BAuuRgdbD0=;
 b=LCXYwZtHLjNrsyLH7zEOHggeck7zOPOP7dxou372/t/GsttJEvmRVZfr9BYxOjO5aah+JlvtEyjxuk0RApftoq6g1bPWrTYK/9dxzLPIaYViCJskv5dT4YMFEiX3hPUsEVnIPD6hYBeyW1Ikdk2vflVgmQXt8eAJSvUJg1dUqCkyi/HP+DuPKSpT4mSp01dGOa4jOnowBsOjVFHMK8+AvqeDFQQEdwQIRbpSxb/lMT/JCyjlmih/ZmfzVkvLqspFSqfI5rkqW5AOU9gM+J49+YS86lEABnWmxovqEYuy3hknKxrGIg3sL3DJ62lBwa7vLGBqikqxdtASxUh+trjPZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qz9lm2hkHZpC8K3cdPX47wcpxNoAsrl9BAuuRgdbD0=;
 b=gNLnwYQEICqEYuG11y41h6OuMXha39QC7mLOJpf+zMw0a32M2sTZDbcpBGA3ll71L9fAo5dv+HtnF5Wyda82k2lNjDhnt/cgGh2+SiSQN+y01D6cRIUDwgATStgoeXlA5OmTiVhSJsTv1lvaU4vVrJomMw0nG7n+spcuO40TMwo=
Received: from SJ0PR05CA0143.namprd05.prod.outlook.com (2603:10b6:a03:33d::28)
 by DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 18:51:08 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::36) by SJ0PR05CA0143.outlook.office365.com
 (2603:10b6:a03:33d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
 23 Jul 2026 18:51:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 18:51:06 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 13:51:04 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tvrtko.Ursulin@igalia.com>, David Francis <David.Francis@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Add CHANGE_ID option for USERQ ioctl
Date: Thu, 23 Jul 2026 14:50:46 -0400
Message-ID: <20260723185046.1239011-4-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723185046.1239011-1-David.Francis@amd.com>
References: <20260723185046.1239011-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|DS7PR12MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: ea4a6a6b-4097-4a81-f605-08dee8eb5a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|11063799006|3023799007|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SM369z2ek3ZRR+6Dn0ElIC70L/LmkbWd7lmLPHvjZCGy6a/jz41ID/epOI+JBzn7uG+8q1Ik/Je7NS7uWaAb0Exew9M4LKFBMBsc4rl6Hr++dkbm0dr6VT+mB0sI5UeD1bV6cA18nVWJrVhyFTZTnFr4aJMOoFV3u9nnfhRMj2eaJpGnsbIsSufRQXixmRMm3o+tK0aDWt2eSYP/gB+zQlOjATFOLenq4Ay7baLjaP7uET7NasuQpM4jo/jYJKBM5rCXtnzaNyBpmhpRDXTAzn4AhdTlz+IgZthy20U46U6qDoTFfRCP5UX+UsxGxMsPgehaZ5rMwZPjF7d0d3oMyvP9vGteeOLFbnMzn2cOrHnDZ3TFLvMmkwO8+jGH8No5p3Gs58GHbDvuFu0qYBzku5nG1guQRaEu4kwGtoKX4hLhRQhRMmMs60Owq5GJ1yzFFlRp3gffH5jU7T3BtPuPDeDNfyqEso8U4Tr/S+yBJix7tjpCwwNg942J6V8uhhrjFWQDHa+90zkk0EEzrvsmeJ0idWoxSE0LXJEqcUmTUFgD/tDx2LqGdRxCz2bKMHP6VTSMN4fLyhJAmTLHGaL+WyFRwVrbvMZLYEUv5Ij1lte+uxGTKL0XJmMsDkkqvAGSJAOdKNRCpcKIe3aseC8YuaZbNAW2MIxQ9awE1XVWS3Frg+Az5Pfu4172ywblgzQ64TZFjiiARVHxgVv7lPHtrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(11063799006)(3023799007)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 98ph7Tocrf1COUoAA9iD1HrcGPUk/R48WRGRDbBvRdaLLKMgIeFrxlI0BZRxTcUqmCSP6jaJQwu+kpDl9wIkPhF+1BjGZUTSJEKmGenAUNpmbaQ7JZQFnAR6VstfFmUxe4uxKCI3Ku05AJnFzbtHcxHyd/20U1gJbk3YB11ez4UhPHETZ297w+/4rE72VHUuJi9IM8XF9gBz5z0VklHqMP1Gb57SW2Rrsbj2evKLEAURxxvSZQvHQW1MKJbVD+lh5L6V4nHTWnV+8BzInZExJT8B5QJcxN2Gx38keHaHqOozKSRDTBfVTuRUom3XrMU5khKMnNV6L7f689YBEKK9/B7sCQk1GF9+Ybb5BPrIuEoagTBuF5OSEq/hBRwyQH7XYLOVUGSKEWFtwT7Xr+U0arAfc8CvcqM10RQxV8GGVTUWB6J0PH1QScbzqEoQN3b8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 18:51:06.2344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4a6a6b-4097-4a81-f605-08dee8eb5a4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
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

Add a new option to the USERQ ioctl, which is called with
the queue_id of an existing user queue and an unused queue_id,
and changes that queue's id to the new value.

The operation is fully protected by userq_mutex to avoid races.

Performing this operation on a queue with signals or waits
outstanding is fine, as those hold not the queue_id but a
direct reference to the queue object.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 37 +++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h             | 17 +++++++++--
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index b13ed7f8be7f..ce084e2cfe53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -852,6 +852,11 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
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
@@ -1011,6 +1016,33 @@ amdgpu_userq_list(struct drm_file *filp, union drm_amdgpu_userq *args)
 	return ret;
 }
 
+static int amdgpu_userq_change_id(struct drm_file *filp, union drm_amdgpu_userq *args)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	struct amdgpu_usermode_queue *queue;
+	int ret = 0;
+
+	mutex_lock(&uq_mgr->userq_mutex);
+
+	queue = amdgpu_userq_get(uq_mgr, args->change_in.queue_id);
+	if (!queue) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	ret = xa_insert(&uq_mgr->userq_xa, args->change_in.new_queue_id, queue, GFP_KERNEL);
+	if (ret)
+		goto put;
+
+	xa_erase(&uq_mgr->userq_xa, args->change_in.queue_id);
+put:
+	amdgpu_userq_put(queue);
+unlock:
+	mutex_unlock(&uq_mgr->userq_mutex);
+	return ret;
+}
+
 bool amdgpu_userq_enabled(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
@@ -1060,6 +1092,11 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		if (r)
 			drm_file_err(filp, "Failed to get list of usermode queues\n");
 		break;
+	case AMDGPU_USERQ_OP_CHANGE_ID:
+		r = amdgpu_userq_change_id(filp, args);
+		if (r)
+			drm_file_err(filp, "Failed to change queue id\n");
+		break;
 	default:
 		drm_dbg_driver(dev, "Invalid user queue op specified: %d\n", args->in.op);
 		return -EINVAL;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 678f3d531df7..de9ae1296819 100644
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
@@ -463,10 +464,20 @@ struct drm_amdgpu_userq_list_in_out {
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

