Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B529C5DF94
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 15:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD36D10F2F7;
	Fri, 21 Aug 2026 15:29:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z/Oawo0B";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9269110F2F7
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 15:29:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agmg9+SYa5HKRN9QXxtTQWPKOdCALFSJrIlo+NVvjRVQEt1GxS5sU9+Km07fdMHeNJJol2mjeMsx1XY4I0Nb4imx65n45nH0aaRuO0eGqVbkeihJ/Gm3ri/yD19HvKO34z2odSggCj2bTvEcsLsIk/T0Ys8sT4NdQE0WFpBgd0lsEVc3qwEdF1oPA9d6wHYncH06xtByreJF3KDjrgwTbIaf/F93yy8iddtZ5Z0tifJrLDQgS4vOmc5vlAaOKDPuo9mlUIo326I77gVNWcCxdhSLDJF4phCkKc35tbdK98I6KKI17j8OEtAVad/b+PwxHg/hL0HWhk01iwBAeg+hHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/1PzUXLapWErvIyu2VgDmnXHL9Hw/n+ix+8Mqssd54=;
 b=iCHGouN/gdPg/0RagRZ2SughEMlsADzPzGDNf400J5hcM+8j3xpXIsRlnRbQhV+YjgFXhVJTw+9pc1FVYT/A/G/d8B2XpjlreMOhW6OgmcqF6SHLyZZlc/t2gCO8oYuF41+pIgkqpB4cPc+XLmzbmt8rm5oZVZDQPg3VNftKn7EJYmcpkqU+npDlXDPCttia5n/uHxXm8CZM52QuoHlf9+LdmROEVxBRinENyF+GP7quuXV8lqUigw5MylmNQ8huzbSQEJdo9EKZFhGFDzXV6xxaseZigaY2qQfikawZnZyQm1i5lq6cmGt142YFQIl+oQbN2Ed7vFYh40t58D1wFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/1PzUXLapWErvIyu2VgDmnXHL9Hw/n+ix+8Mqssd54=;
 b=z/Oawo0BZg8kaB7mUNpqzSjCitYUZBSPpaQOLs2D7qEZAJUCf3IfepM57AsBBH68YYBhDWhq8XyNmzTrwzD+cM/q7jx1HqboVg2Vzv9Iwm4zcqp7jKeJq+ffpYMbSKWe9kRHo5frnoccbLaxOuRaraIJrunVqXYL/lqJTf1WKBM=
Received: from PH8P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::10)
 by CH3PR12MB8933.namprd12.prod.outlook.com (2603:10b6:610:17a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 15:29:48 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::22) by PH8P221CA0005.outlook.office365.com
 (2603:10b6:510:2d8::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 15:29:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 15:29:48 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 10:29:45 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tvrtko.Ursulin@igalia.com>, <Christian.Koenig@amd.com>, David Francis
 <David.Francis@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu: Add CHANGE_ID option for USERQ ioctl
Date: Fri, 21 Aug 2026 11:29:31 -0400
Message-ID: <20260821152931.3493933-2-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260821152931.3493933-1-David.Francis@amd.com>
References: <20260821152931.3493933-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|CH3PR12MB8933:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8af345-f8e8-45fd-dd1e-08deff990940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|3023799007|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: w29vFa5xCx32/3oqvbx6ulQO4bOfd0JkTpXPppYM2PhX4uBi7n1vADKKaUlv8Rsbq2LOaKVrEC4isZQnKTKgFiLC03xiulSTEDs6Tg14exCezNxSsQN3g6AdAPGcm+9O0pxURjjtlXrzLtOSWSykso1AphMdIzzDLS0yQ0QsOwUv8ifbg1Pa30F91CC8XG8wS9fxfWH+f0VKCzJR48cmmR+l/3eys1ShtCQPY1m3XWOw8yfl+ExtYJ/P92RA86B9jYKExFjICDIxJmKmTrLs0+GoK9uSuBgkOmLvYbSWfiF7fjbNb6vlxnw3DC9sexH3YmBChrH3hkUaniAAXG8eJQ5Q4S6zp6hWZW56achf68ZegzML3d92yPZzeb7sgjqbMYsER9kF1HT6FKv7YAjwKf9cNaIn6gc2XWaOo3qRxBHk0NmuJkawz8Difu5NswQQ5x6LL8QYZXr0gQbjHoTH9oTt+XHRyjV53k2UOTcBDcR4q4cyB1VB65gX9BcmIFrhoc1TXVs3b8KefKIrY+G6MdnijpF7ZANF52rXkP3JMw9uPRac+XLAPytcCQfdlHR1XdpzDJ2C0uLpfLLXPFFcgE6i4KpafnXAMyHH+6zJQq1hvro4sl1m9LLKNsEW1JKrTivknvlf655ugU8NxiJj3/AfVkxK7I9QFjzpM+eFZSL6fOE8SAgVXRgYTx3AjWGkiAYuUaQcPBHmDLShMTppMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(3023799007)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6yJkTZ5jSGUvfGUTODLnLU4tCevuaKHFBckNX2XBBN7JFhU1gYJ1w76pwHwMeOAIcnzrQ5r3fRDP+o7Nho9w8hvMUKZuLTNhXsNebmHO1ndQITZdnVcjx4YI+hmUhAS1bNQAfYJS347uzcMVV18UYrguuf8Q54qlImIAYxC3OlpVautviGYxcpJRDAbFA22tgdD1/vsQPUwDEXQvXRDui0Qw0g1YLUR8FuKEZ5Q72z1pe433RjbVpPAD5lwbe+IPWpYrrhWEyUvLhGU/v1tji9FBDU0CKH5+1ByFHQZCuLw3wGElGsyWhrVqoAsF2La9oAfZfkavLyHekQ5fGgj0Jf44nrl6xkOBCdZFh4FO1U2dfAu0qSXUzPUHOJgq6ZYWgBPKN78y+sluCRySGQmL/9M29srdUYMAKaRDejfZlgkKr8j4I5P0MY6wEXoKvO5l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:29:48.2628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8af345-f8e8-45fd-dd1e-08deff990940
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8933
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 52 +++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h             | 17 ++++++--
 2 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 32d1787aa7e2..beeaa9e9c5bf 100644
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
@@ -1010,6 +1017,43 @@ amdgpu_userq_list(struct drm_file *filp, union drm_amdgpu_userq *args)
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
+		if (xa_load(&uq_mgr->userq_xa, args->change_in.queue_id)) {
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
+		drm_err_once(queue != &poison_queue, "Expected poison queue to remain untouched during userqueue change id");
+		return -EINVAL;
+	}
+	if (ret == -ENOMEM)
+		return -ENOMEM;
+
+	/* remove the poison */
+	queue = xa_erase(&uq_mgr->userq_xa, args->change_in.queue_id);
+	drm_err_once(queue != &poison_queue, "Expected poison queue to remain untouched during userqueue change id");
+	return 0;
+}
+
 bool amdgpu_userq_enabled(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
@@ -1046,6 +1090,11 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 
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
@@ -1056,6 +1105,9 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
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

