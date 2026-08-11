Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E959CC5B572
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 14:12:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64E0B10E248;
	Tue, 11 Aug 2026 14:12:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mRaFB0eE";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A821010E248
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 14:12:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kS+tsA6JcndVpt9h+hqALpSQj9qnE1pIrwT9llZZg8y52vQMe/KZu0ELkyUwmSSBiF+J1BXF0bqaHQwJJR1tVOUdyHewNbBcbyK7vLQE84VBc1oQCDYiqDLD01j0hfJccaBjIhGjzaGZchHllhDnvQw85dbigK/UYzsdfKn421cX40FK3MWS4SB1C0Ong+e3pC7+kr1gtJpERHbOwlDlWiyGmiYON3QX/uKnXmB7iP0EoN0NWhqlALa8s+uWnUaTBb6O6hlM6Zsk5SowYrmGC108qF5Avz+hYiA5ofngl0XPJfNutcHOFAmAQe/aA9SoDOhHz+pLP6x4OxYF2oai5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rd11u4s7MxHFg0YacYd48agGpkyPqG8EUx665JYn0ow=;
 b=vb/CqGHZW4Sr2CXs8+WpUpDXPpWQmMEoFA4hSnH24uanGwf/JrUX5LToBD0mCy2sfhLi96A3aZFT+Zk17Yp+jTXq/TUdegmzWdkA0036SBMF3i0hlttxjkl24IA9eg+lOqxcFOI8WBcaP12E5G7qAYLrL8HB8L2OWxA5MeSZu5W2wtWBygsmgMEXORqRUKpEYhwyhxmosPbjVVnUK0AdHyxT7CUL/fKwgn+0kcQtRX+/58e4Dr9SHu88MbwC9m0vrSCTCu3mHqe45E/1yZZmsVxUWy6fY4QgyoBl+7mb1yl+ymQz4O1NleY/OmH5YYUMJM/QtBXzsEuLsNWEASMtqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rd11u4s7MxHFg0YacYd48agGpkyPqG8EUx665JYn0ow=;
 b=mRaFB0eENo+5+kl944lqOyXAJpF+Xz0ItDCYe+EkmPN/rBaRcliE+P/fow2oBdj0keTm7RFiDTeuII1PAiST5PUEx1IYvFRXB6dO0JiC9csqy3Dqjr/wfgxhDmes0uhwiqNJ4O13hkyzkW0POhmYkNiMtJ1O016FlYKENx2AHi8=
Received: from CH0PR13CA0025.namprd13.prod.outlook.com (2603:10b6:610:b1::30)
 by SA1PR12MB8643.namprd12.prod.outlook.com (2603:10b6:806:387::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 14:12:20 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::a0) by CH0PR13CA0025.outlook.office365.com
 (2603:10b6:610:b1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 14:12:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 14:12:19 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 09:12:19 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tvrtko.Ursulin@igalia.com>, David Francis <David.Francis@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: Add CHANGE_ID option for USERQ ioctl
Date: Tue, 11 Aug 2026 10:12:02 -0400
Message-ID: <20260811141202.1633727-2-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811141202.1633727-1-David.Francis@amd.com>
References: <20260811141202.1633727-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|SA1PR12MB8643:EE_
X-MS-Office365-Filtering-Correlation-Id: 9baeb829-8659-4d25-eb8b-08def7b28e60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|22082099003|18002099003|11063799006|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: +Z5vsajWZaTXjxAMm8wwHi4/NQs9jbDQ3b88g9bFID7ldgIrOv5SxUmg8R16p2tCGGuL9osQqznGeDUmZn+EoJ31yKn13gA+jZ10+HGKSImaxqLMu+m68do2gSDuMr5lRAXehDEnR+N5x3Q/cyNuZbiiW5YNyIlpnIyhV3AT9nMkdkiKiUcBmK4xeRevL8Rh57JfnMDu6tQCiovI7cqLCMyGQecrLq1DSK0hG3fAYdOP4tTNX/UCsCspAG4zhvjxGq3qjLDwoZmdjTMPLxH9BL3cHxk9BDMi47pyi4apdVJWHXjpcg9cgN6yEaL2JgsPCbApwrLEvd4x/RZaCDVDehXULnzR7RbqL7TE+q1VJ+ghZedNvUivJ8IhPDmuPyYfjHpUCTSqPD/xagB43nhhhxn0phRW2BCgFc3xF2WaCyQYdCMovBioCctQBPeQPFTRT9X4/Sm7rVjX4Lw72n7HGwF6QJy90sbqcTs1VN/4Sezsvc6t6k6i5JjNZ54cM/IPIkw9h0z1Q0cBy3zKKAL7xL9Ps+m3HmTxmi3FzSuaobdlalGc9iJOHqObLYGJwBckg7kWawlwtaSxOpBa1KYJm7q4eHwPFblBsqQa8CKnNVFgaarxLtLp3ziGX1ZskFJa9KEk5hytGL5Aed9s5uI8NfZbG/DohOIWbnsolvPi2tLHDO2AheeYzTJj1UYkj55qQUMpO9OKIMISfWN2jPC61Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HZHFuDmIEXMIBws1ZQyEUSJHvxLzMuWeA/SWmdBGhWskmwZ+n3BnMsCbBk8X0Qbe4eNZycpUgj3HzLOMJBZD9fTqG5FRQF9YYDt4mKkAZcQpJxlUzWT9wldcKDKbmRCqpw3ht+d36ELQINsPkWhDw0se8IQqpVzKIXGtpJOP+na7w1hPj6A4EUwwa6prcZs8saKzDiEILudHOG46BoN6jgJ1L5BFM45TPt92FMOxmFiO0fx82HSzLpjkL8uf4eugFTgC149r5veITM+7i5GT9YoH7N7g0Ij0aQgberDH1hCeMoeN/xR+fG9FCIbG2sp6n/jUiYujaBG9e8jSQwrqZ+PiWvVWn1Re8RnPqEJhzQkCRmQetJ+0fmj8RyUM4uYxCyCprdqJI8THnGfWrNmdsU/FvPzG0MaE0JFgGIy4sAC5fqBAGtIwRR0sSFc66Zdd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 14:12:19.6539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9baeb829-8659-4d25-eb8b-08def7b28e60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8643
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
=handle will succeed if that queue exists but not do anything.

This operation holds userq_mutex and the userq_xa xa_lock for its
entire duration.

Performing this operation on a queue with signals or waits
outstanding is fine, as those hold not the queue_id but a
direct reference to the queue object.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 43 +++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h             | 17 +++++++--
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3c930425c1bb..b532ba0f4cef 100644
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
@@ -1012,6 +1017,41 @@ amdgpu_userq_list(struct drm_file *filp, union drm_amdgpu_userq *args)
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
+	xa_lock(&uq_mgr->userq_xa);
+
+	queue = xa_load(&uq_mgr->userq_xa, args->change_in.queue_id);
+	if (!queue) {
+		ret = -ENOENT;
+		goto unlock;
+	}
+
+	if (args->change_in.new_queue_id == args->change_in.queue_id) {
+		ret = 0;
+		goto unlock;
+	}
+
+	ret = __xa_insert(&uq_mgr->userq_xa, args->change_in.new_queue_id, queue, GFP_KERNEL);
+	if (ret) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	__xa_erase(&uq_mgr->userq_xa, args->change_in.queue_id);
+
+unlock:
+	xa_unlock(&uq_mgr->userq_xa);
+	mutex_unlock(&uq_mgr->userq_mutex);
+	return ret;
+}
+
 bool amdgpu_userq_enabled(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
@@ -1058,6 +1098,9 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
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

