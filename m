Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EAE606A31D
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PYJYm3KZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4416310E5BA;
	Tue, 20 Oct 2026 19:50:30 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE7FC10E5BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 19:50:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnJlvMEC0LsvRtHb2w8H6sxhj3FnG+EuvNO7txIkIKLjtCWZ3yxnLxzr9Nur4kd+NCuiyDL/diWj/Z85U+9FQKSQW5ZilCRIB4K/00qTMJhAueT8gaSLd/6C+clkyYSYCxdCrgn3PSECfwttEC5dGYUkybs1X1BUgzr+eUEMpo3E/agdCaLY+yYtZOhRSOQu82K9fZufmIugP37Xjih5AIq33COFW8Qts2E2yupu8cGaMfhy3cP8e4y74FOaKgsKPjUlGWXP+QHctHVbNoeDTho5grS2ziWX9pSPTv7iYuQ/pYWBmBuqKjI8XZWs3UlZfpXO//QH/t/Yfl15gKl1jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjBHoJUG/Hi64b7KioqXRwkRQc3mnZ0HnIVyPszCPnE=;
 b=K725COIpBFJDeXh82v/VluqtiOr/bmLFCBB4KJw73LxCN7/ovWBX5+PGbZWBUqb5g8ES3Oq2CdMXREFM5dWosJt84IqztTjfooWd2N1qBs6TXXelIwAeTwUNFlX9ulWAmAyyhaWaVivkFsJoWbR50UXkWGrgemo+uDrOSEKO1bUgaegU2K3u5NI6r7+gOYC5Cki1u7kLbgdQDxDbf1CRzQ4IGZ48/vgB7tnrf8AIEzU0s/p3gpptOa/EpzfWPOMOjwhThP6XhMQlGQ8B+m8vTYDXnNVFe2s0B4q/7PTOsOteH7oiHvaWabO+XLYq9JO9HZMsrZsQIbqHUz1QfXuP/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjBHoJUG/Hi64b7KioqXRwkRQc3mnZ0HnIVyPszCPnE=;
 b=PYJYm3KZbjFH+UfF8WWnf09JhZHMePr+DkJWEsjv61/+VgWgrK7nHJYGi6GbwoblD4qMvGNJYhiefotv6RbVgN4bwf5UBiuhKGy3qLrgSI1yeCf2+KAsb+YSqwiKqWZn4hdyYTcvzKihWFiO+F57SMzWWcOZ+ld1/x0yzjCh/20=
Received: from DS1P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:44b::18) by
 IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 19:48:19 +0000
Received: from CH01EPF000BE94A.namprd02.prod.outlook.com
 (2603:10b6:8:44b:cafe::2f) by DS1P222CA0018.outlook.office365.com
 (2603:10b6:8:44b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 19:48:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE94A.mail.protection.outlook.com (10.167.244.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 19:48:18 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 14:48:17 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tvrtko.Ursulin@igalia.com>, David Francis <David.Francis@amd.com>
Subject: [PATCH v5 2/2] drm/amdgpu: Add CHANGE_ID option for USERQ ioctl
Date: Tue, 20 Oct 2026 15:48:01 -0400
Message-ID: <20261020194801.506382-3-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261020194801.506382-1-David.Francis@amd.com>
References: <20261020194801.506382-1-David.Francis@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94A:EE_|IA1PR12MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: 5734bd87-3dd2-4304-cd15-08df2ee31719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|10067099003|22082099003|18002099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: yr7XcgMTb9X7UNTzKVqBLi41gh8w4W/nk+imiLdh186PT2Usw5vmUdOmdEnUU0PWn1/VIkeHrOqw/oFYI8IcFqciPckgkOwF0XiGtyIHnsrCgVAz4mcst4Y3tOOMKk0UfumkwDfr6YKjYVv/Lv0YboDZQQxsN7z+aORHl8rrdkPxol8vPdZdE0a0TsfdiKHr7GkEmTt/ELhycNdH6BMIsnNvZPeTfhENO46H0DFsm0BEOoPQqpkoYaLxkG0RQ8dsnOZnNOyVSeFdlg0OzWlsSw8UmgKJeGMlUmCSoZdw8HeBON/7UQbtB62fq1LUMDJkjiROLfeECVAQMcWrM2C7LSbvdgW8GYaaEendLCKpHoknoQsWnKnmiWuqQ/b7ERzOWW7C9eVHG2KCzZpX8xrddIo+s47cmKJbjoG1iy42v9aiyEfXsh51XELiqN4PjcxHBGevbQt7QWQKSAg31i54VBbrjFCH8NkCC4fmyVAgFyO1ppC0sld14rH79HUtk0i9MKDqMg+HGZ0Bz8UVfIeg84COXYPzEuJeSELF1n9my9mb+UwRI477ZsIynXUivelRfj+/6r2VYxOWX+G2fK+pq0EeoAzF7ej4d5cntTbNpO7KZgX9rGHqk1LS7YWmxhdc56k6epO5yh5HEZrzAFT8g0gG7sK9vfL2PpI/5PdBEux7Crb/WE3LnHeqEoitsA6qKwz92Ag82gD7vE3TkB33/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(10067099003)(22082099003)(18002099003)(3023799007)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tYpUddr4gCm0oWxw0P5djn1wm579vi3g+9NUYShKgWi+YHk0vSiFMiIy6uBKvFrOCAtklGVwhmBJYEJ2PJkz4W1TJiT3RqHcW2zpPF8x4zxUxPtGLjxGDAvmxjiM0g+7ADD8chh3aCR7LteRw0kQNtdnUW65zWtjUg7BMdMI413nrWE9ee8h2T0fHVQpiCLAZAckz6fmJxE0xXeXy36J3DBg5bMrKGpSSq+2b3QnsDUspDsnNi+1AmRovg2BYyuMC2koFNUZGrmsKt5XtQRufoKBbdrY3trOsd4p8K2DkPohVtVt0wnDTznM/m79JR5aHEEP+wZlJWBmRZuKIBV4yYBPdRkXHJoahwZBqvFkyeg0YkEuxYJI8pGNCfdC1NSW1lvGm5TnIzYfj8NVZtnVHJXw2Xu6XL+jOZ5+9qQSUcxJeS6E5x7GRIJdKFFxD/M5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 19:48:18.9367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5734bd87-3dd2-4304-cd15-08df2ee31719
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE94A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a new option to the USERQ ioctl, which is called with
the queue_id of an existing user queue and an unused queue_id,
and changes that queue's id to the new value.

Calling with an invalid new handle will fail. Calling with new_handle
= handle will succeed if that queue exists but not do anything.

Performing this operation on a queue with signals or waits
outstanding is fine, as those hold not the queue_id but a
direct reference to the queue object.

v3: Poison queue and misc fixes
v4: Using xas interface
v5: Now with accompanying igt and criu changes

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 46 +++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h             | 17 +++++++--
 2 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 5aa53b2f4355..1310004ec63f 100644
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
@@ -995,6 +1000,44 @@ amdgpu_userq_list(struct drm_file *filp, union drm_amdgpu_userq *args)
 	return ret;
 }
 
+static int amdgpu_userq_change_id(struct drm_file *filp, union drm_amdgpu_userq *args)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	XA_STATE(xas, &uq_mgr->userq_xa, args->change_in.new_queue_id);
+	struct amdgpu_usermode_queue *queue;
+	int ret;
+
+	if (args->change_in.new_queue_id == args->change_in.queue_id)
+		return -EINVAL;
+
+	do {
+		xas_lock(&xas);
+
+		queue = xa_load(&uq_mgr->userq_xa, args->change_in.queue_id);
+		if (!queue) {
+			ret = -EINVAL;
+			goto unlock;
+		}
+
+		if (xas_load(&xas)) {
+			ret = -EBUSY;
+			goto unlock;
+		}
+
+		xas_store(&xas, queue);
+		ret = xas_error(&xas);
+		if (ret)
+			goto unlock;
+
+		__xa_erase(&uq_mgr->userq_xa, args->change_in.queue_id);
+unlock:
+		xas_unlock(&xas);
+	} while (xas_nomem(&xas, GFP_KERNEL));
+
+	return ret;
+}
+
 bool amdgpu_userq_enabled(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
@@ -1041,6 +1084,9 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
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

