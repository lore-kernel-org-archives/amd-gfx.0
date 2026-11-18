Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C084B606A6C8
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 22:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PD1X0nDU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48F241120A3;
	Wed, 18 Nov 2026 22:37:56 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BB8111209E
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 22:37:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOaQdPuKBKsF2KMFOdi5x/QWA8IiWNHBxkkmUuAMyZXVM8BbWnt9HjPOHbBEl2kkmdMx+sHfgps8J35z1rr/5Hmx1jZMmtLNGY8V+O+k3Dhgtvg2EtMooIcq4o0TeMwQZwWdq5thIDcAJxG8rR5YkrwEKlJzIQPKCoxV7U04ZbugFcweanPCgFgmx1xZuUfKu/hTEtoz2SNf3ZimLYdR+TZin6Lm86lF4vjvnWXrIB/MkxiSPhhvJGGkGomlSQIz6mQApCd5SyQVE9V/+VOZZLhCKXGkS5jsk858jYcWm8kyTavf2aiRzWZh2rSUJLnv7JT++d0NZ40cXnpi05BihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4z1jHDfhRWu2zy3gkCQUAa+lb9sArSXvze971+rE64=;
 b=FUQRBRIwaHiwqZu2U2YWhZ4E7AIDWWoCpbJueaBgKsCF+SsH/x2ZRw/F6X7T3Dr0Q43+lrvKHYq2dmnW5hoE7Kz55PIADFE4j3zOmsIZMcHGBK0mG3CzWKZcbNYvC/GX5iQ1MQq41YtwOUOia4sJFHMTjmyytS1pkNYnFCrTrt15GFvwcXUApdwTP7ylWx85o/jz+aLCKbfJto5S+GLScLcR6iEXqZ+Au1XT+r185pYMA8JDNO49KWfKuDgd15RM8O2NYXGmaLnY/B/1pwqof4ZYPiUfo7EQ1clC1TDaGk0ivvA3HJODvJlIIPfQHihzEf5hGx7Y/ZoKj897hMdAdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4z1jHDfhRWu2zy3gkCQUAa+lb9sArSXvze971+rE64=;
 b=PD1X0nDUMIUMomypwo5MdIqod4rCJ2zUiL6JlBuG11RBUSzptxFHS9htRyW+54By7Ads7aOFin7doWXDyDeTpLkcl9scUWKpresMahDuMMX8Nx/D1fpXg8+2Lz3ISzfspmwr5tC38DWhZjXH0xuZloL1j2k0+HjdmEu0hq0b/Xc=
Received: from SJ0PR13CA0062.namprd13.prod.outlook.com (2603:10b6:a03:2c4::7)
 by MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 22:37:30 +0000
Received: from MWH0EPF000D8953.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::74) by SJ0PR13CA0062.outlook.office365.com
 (2603:10b6:a03:2c4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.10 via Frontend Transport; Wed,
 18 Nov 2026 22:37:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000D8953.mail.protection.outlook.com (10.167.249.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 22:37:30 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 16:37:29 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 16:37:28 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yogesh Mohan Marimuthu
 <yogesh.mohanmarimuthu@amd.com>
Subject: [PATCH 10/11] drm/amdgpu/userq: enable support for creating gangs
Date: Wed, 18 Nov 2026 17:37:11 -0500
Message-ID: <20261118223712.2518580-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118223712.2518580-1-alexander.deucher@amd.com>
References: <20261118223712.2518580-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D8953:EE_|MN2PR12MB4160:EE_
X-MS-Office365-Filtering-Correlation-Id: 481e710b-4b49-43fb-e3c3-08df45c487de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|10067099003|261102123227099003|261021121427099003|261021123027099003|261026121527099003|11063799006|261022075727099003|56012099006|261026140227099003|261028144727099003|261022105027099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Y3f8QT5s2Oi9LqKrpfEhDAg5fu+GYxdpqh+/JQ81o6hMuE5NNBTYkfPx62Yxda1Dt9w/jvCoz1mFl2yQoWbF86dnbee68cU2Gkfqh0R/hGUeLTZYOEFqfR4f5rnbEG91KkY/sfG5oEcEWolfKqMy7IV29FipfVhn4Z6BZppvvA8SWTJlSNG2DrYHopfMgQ2wNgzrExEJq/D7rSjs+RodVDCtAYckInYBEr3M4CRdHseuTTUKs77LCRSDZvjrxvEUyepcNFYz2YM7WbpoHWBF/vZKTQ9ThXQJdQbX0kdSZeMuVQMSU/FmjYKEKND5OUeRnRHBLj7vKxhHhNGHDuCVFlo6Gs+2JCOvgXGRh2TJB+gC2yi9NKwHo26apIvLRLnD/aoocd+UNvTYvZbG2QnR/QLSMmD+nb8kFuX2D+y0Nx3hxUccKHCGmX4BNFfLpKSbEeiMEahUWwni7Rh9ETmeSErpS+xghnytGgnt/FnGAe/j+9JJic23LOfv0qMzpBCP8goIM9GZ1RKi5l3q7sCO+kuOTvCmM9vd871Vm6Rc6Q0h87yROG1GNUQltg1fYlwgcL/aZn/n7ENXJBvR+gEgBrTTDxG9Kfrr80Mx0z8zxmfuaqRxBSDdu9qvXD6sBlYWdtJ/ihT7ckdJYuKIiOYw4alTidwVoIVnvXCMxYqXzwTbLycZ3chQ+3wpRP160d/yZ+5PbF3tMQIwP5oJAzlAyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(10067099003)(261102123227099003)(261021121427099003)(261021123027099003)(261026121527099003)(11063799006)(261022075727099003)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qVRqENat5Tvr0uZFB6S9ptM9+Ia0fpRfsc7dqONRe/D1yjQCZEhDctoWu7vZQfl28Y97YjQEo2/k2cNGnxSFl6YpNuJlFqHffDNI+vykh3PRTGBGggVuuwFT1sqUEGhALK4U/MpOXeC8nwfoPhSGa5GYsrs7Z3fABfhUOR/X6eYXAtZ1uds/Z+Q/RmHJbpNjGtdyyv2hW6cw5+inGaXudtCn83LslwaPYodWALAiPn6RQHHErLGWUjzEKS7aZ2vlhQi8z6FI2STTeZ/F8D1plL4sFE90otuPv4K1zqf+VT53uo10zIQU/NwZsBjJ6IxnxbL+j4rR98RYFsUZrhRquxHhof9aWiX1EMn3aiagVTaHqCD18p6Nhy4lxXvEvWeZQJ4VMcemxMcELgbB3Phbb0r61elwtV/+bEoBs1TaOTsYJH770akYQX1WdjMW9hEy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 22:37:30.3993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 481e710b-4b49-43fb-e3c3-08df45c487de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D8953.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160
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

Gangs are sets of userqs that schedule together.  You
specify the primary and secondary queues and the scheduler
will make sure they always run at the same time.

v2: handle setting up the gang again after unmaps
v3: split the UAPI part from the internal tracking
v4: rework

Cc: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 122 +++++++++++++++++++++-
 1 file changed, 121 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3afd17af28548..388385380d8bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -566,6 +566,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
+	struct amdgpu_usermode_queue *other_gang_queue;
 	int r = 0;
 
 	trace_amdgpu_userq_destroy_start(queue);
@@ -585,6 +586,17 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	debugfs_remove_recursive(queue->debugfs_queue);
 #endif
 	r = amdgpu_userq_unmap_helper(queue);
+	/* clean up gangs */
+	if (queue->gang_primary) {
+		other_gang_queue = queue->gang_primary;
+		other_gang_queue->gang_secondary = NULL;
+		queue->gang_primary = NULL;
+	}
+	if (queue->gang_secondary) {
+		other_gang_queue = queue->gang_secondary;
+		other_gang_queue->gang_primary = NULL;
+		queue->gang_secondary = NULL;
+	}
 	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
 	amdgpu_userq_fence_driver_free(queue);
 	queue->fence_drv = NULL;
@@ -838,6 +850,106 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	return r;
 }
 
+static int
+amdgpu_userq_create_gang(struct drm_file *filp, union drm_amdgpu_userq *args)
+{
+	struct amdgpu_usermode_queue *primary_queue, *secondary_queue;
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	const struct amdgpu_userq_funcs *userq_funcs;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	int primary_queue_id = args->in_cg.primary_queue_id;
+	int secondary_queue_id = args->in_cg.secondary_queue_id;
+	int r;
+
+	/* The reset changes the queue state and the MES is unusable meanwhile */
+	guard(rwsem_read)(&adev->reset_domain->sem);
+
+	mutex_lock(&uq_mgr->userq_mutex);
+	primary_queue = amdgpu_userq_get(uq_mgr, primary_queue_id);
+	secondary_queue = amdgpu_userq_get(uq_mgr, secondary_queue_id);
+
+	if (!primary_queue) {
+		drm_file_err(uq_mgr->file, "Invalid gang primary queue id\n");
+		r = -EINVAL;
+		goto out;
+	}
+
+	if (!secondary_queue) {
+		drm_file_err(uq_mgr->file, "Invalid gang secondary queue id\n");
+		r = -EINVAL;
+		goto out;
+	}
+
+	if (primary_queue == secondary_queue) {
+		drm_file_err(uq_mgr->file, "Trying to gang the same queue\n");
+		r = -EINVAL;
+		goto out;
+	}
+
+	if ((primary_queue->queue_type != AMDGPU_HW_IP_GFX) &&
+	    (primary_queue->queue_type != AMDGPU_HW_IP_COMPUTE) &&
+	    (primary_queue->queue_type != AMDGPU_HW_IP_DMA)) {
+		drm_file_err(uq_mgr->file, "Invalid gang primary queue type\n");
+		r = -EINVAL;
+		goto out;
+	}
+
+	if (primary_queue->gang_primary || primary_queue->gang_secondary) {
+		drm_file_err(uq_mgr->file, "Primary queue already in a gang\n");
+		r = -EINVAL;
+		goto out;
+	}
+	if (primary_queue->state == AMDGPU_USERQ_STATE_HUNG) {
+		drm_file_err(uq_mgr->file, "Primary queue is hung\n");
+		r = -EINVAL;
+		goto out;
+	}
+
+	if ((secondary_queue->queue_type != AMDGPU_HW_IP_GFX) &&
+	    (secondary_queue->queue_type != AMDGPU_HW_IP_COMPUTE) &&
+	    (secondary_queue->queue_type != AMDGPU_HW_IP_DMA)) {
+		drm_file_err(uq_mgr->file, "Invalid gang secondary queue type\n");
+		r = -EINVAL;
+		goto out;
+	}
+
+	if (secondary_queue->gang_primary || secondary_queue->gang_secondary) {
+		drm_file_err(uq_mgr->file, "Secondary queue already in a gang\n");
+		r = -EINVAL;
+		goto out;
+	}
+
+	if (secondary_queue->state == AMDGPU_USERQ_STATE_HUNG) {
+		drm_file_err(uq_mgr->file, "Secondary queue is hung\n");
+		r = -EINVAL;
+		goto out;
+	}
+
+	userq_funcs = adev->userq_funcs[primary_queue->queue_type];
+	if ((primary_queue->state == AMDGPU_USERQ_STATE_MAPPED ||
+	     primary_queue->state == AMDGPU_USERQ_STATE_PREEMPTED) &&
+	    (secondary_queue->state == AMDGPU_USERQ_STATE_MAPPED ||
+	     secondary_queue->state == AMDGPU_USERQ_STATE_PREEMPTED))
+		r = userq_funcs->set_gang(primary_queue, secondary_queue);
+	else
+		/* if the queues are currently unmapped, the gang state will get
+		 * updated when they get mapped.
+		 */
+		r = 0;
+	if (!r) {
+		primary_queue->gang_secondary = secondary_queue;
+		secondary_queue->gang_primary = primary_queue;
+	}
+
+out:
+	mutex_unlock(&uq_mgr->userq_mutex);
+	amdgpu_userq_put(primary_queue);
+	amdgpu_userq_put(secondary_queue);
+
+	return r;
+}
+
 static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 					union drm_amdgpu_userq *args,
 					struct drm_file *filp)
@@ -907,6 +1019,10 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 		    args->in.mqd_size)
 			return -EINVAL;
 		break;
+	case AMDGPU_USERQ_OP_CREATE_GANG:
+		if (args->in_cg.pad)
+			return -EINVAL;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -958,7 +1074,11 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		amdgpu_userq_put(queue);
 		break;
 	}
-
+	case AMDGPU_USERQ_OP_CREATE_GANG:
+		r = amdgpu_userq_create_gang(filp, args);
+		if (r)
+			drm_file_err(filp, "Failed to create usermode queue gang\n");
+		break;
 	default:
 		drm_dbg_driver(dev, "Invalid user queue op specified: %d\n", args->in.op);
 		return -EINVAL;
-- 
2.56.1

