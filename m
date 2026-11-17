Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7202A606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QblezXlr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC0E610E45C;
	Tue, 17 Nov 2026 19:24:42 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013021.outbound.protection.outlook.com
 [40.107.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6972910F8C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 19:24:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pu4riI+sL9ulwotmVj4I0plvXcuibVxCJDPIM0y7BAKXEzpCgMYOZj5oM3ry3phWQurn+MwxM9DTn34Sa4xp2ur21pq7HQASrDR+XmrYkYWnYxjgGiZ3wzuIVLWqFev+xHHDoVpGuDiPhxpflp3fwJcUpiauTQEcNxY4XHc/W16T5e4CjQRX3MOhitX9o9zYUWf4qM4MvVpumGcJ+UPfHv0KyngSHd0XjkgXVo7WHmihRU4hv4ZJCWcuoLeRRJNgpcfuZCVRa6CPmQb8A/l4xJkU3xxIA2SJR3KsC4HmlU3lJl87/IpKZixPxEaDODaAy6TiSKeKO2u6lYLf2zz7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bI/dUJC1+Dsduax1/7N/PGzLePkEA+ocjknfHqbwjpE=;
 b=BCF4f6W8OGnP2V69hJkZd6JKJowNh40Ob8OgxaGRaWK1YN0VD7ZouzttWOrugrIV4JeWpM1nPto6dQSZ5Q3C97i0MDKNr+nf5XV1goACleaJ769DKHj9FvNk2bEngAJPQW5hlitkTWsn6LMgixEX3x60bgZHF1X+iv0YA/9GJeSTu4hvHQmVn9ihiUyTPEhdgRGY2MEFGLFdk3pGRP0qq3ghosGBHBM0mccHQnz+seOzCm0N4Ca9zIR82b3IUeQ9HBWp8+1rgeetMORAogTS5RjR++rpNmmULUKAvJ1N00uoYl2Yc6MhmKCnTaBGejoZGAjwEBgc9IZjbbe5BKb2VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bI/dUJC1+Dsduax1/7N/PGzLePkEA+ocjknfHqbwjpE=;
 b=QblezXlrqTVBN40K7N5MlToBoT7tAeO4GsLhqCeQAgC/sz6OFwE5LNM3TMME/A60LlfPxtzgFpZZVf1MnizkdMlcFRb3eVAFefRDZFuU6zIKRPdZva2vrynYEwr8cZtPWW0sBJedUlqvnYk/IYXtYCDKMj62I9ejIVqEYgO+fNg=
Received: from MN0P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::29)
 by DM6PR12MB4330.namprd12.prod.outlook.com (2603:10b6:5:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:24:32 +0000
Received: from BN7PEPF00000094.namprd03.prod.outlook.com
 (2603:10b6:208:52e:cafe::93) by MN0P220CA0001.outlook.office365.com
 (2603:10b6:208:52e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 19:24:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000094.mail.protection.outlook.com (10.167.245.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 19:24:31 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 13:24:29 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 13:24:29 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yogesh Mohan Marimuthu
 <yogesh.mohanmarimuthu@amd.com>
Subject: [PATCH 7/9] drm/amdgpu/userq: add handling for set_gang
Date: Tue, 17 Nov 2026 14:24:13 -0500
Message-ID: <20261117192415.810117-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117192415.810117-1-alexander.deucher@amd.com>
References: <20261117192415.810117-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000094:EE_|DM6PR12MB4330:EE_
X-MS-Office365-Filtering-Correlation-Id: 587eedc2-6c55-419e-51aa-08df44e067cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|18002099003|22082099003|261009223027099003|11063799006|56012099006|261028144727099003|261102123227099003|261022105027099003|261026140227099003|261026121527099003|261022075727099003|261021123027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: YFYgt/gTl/3HGSqfQ8U5bSdAr3LfmvGmsBuUCDjl1oPi/SNQUPDC+KDeherlXUmc/g1xBuB7ozmw8Do/4QCJztUbr+PVUJgmsdpKxumpmS5VSZZyBr1J8yaDyb/H8dx5cMzUgOlmKIqgZTPipiRvw59/5FGJtlKFb9Rh+ZHIuzknwjSF/+D09ROGNRCqIXaaTVU+OPsHjBkG+Cu/XLgxIDhagVIcgl9PVPxEb2taMJeBadHilOwxchMM2EkM8B3MTS0jwbo7YiXkoUrCV16djj7qriSXPFIt+R34kQ9Qbig1NvD9Ky/TnwL2ey+OwR20We8ynA44J1vZC2B8sf6hK7/QeR2y3kRDj8WrQzL3DCOk7XtEkjhtxdWQdGo4RQs1k+Mf4n05QSbH76vWJOB5n7n9yCytFLWjh2q4ky/vyBzjRA5VfQvYsJx2ubU/dx2z/RchqCI0WxnhHBrSW0vD8uZtPII1xZdbcJtRXAMoBt1OrJvecam8SNAGi8cQ/C1EQTF2/027feMp3nxqGSZiUkPTcPenJE1PnXedU4MPZ4jXuj7pQ5sjiAqvTm4VvOZxIrasXbl9nUo7GHE7BYmHPi6f9/qw2oLnlCA2bPBi8ip3TH23WcEjq8+AfC31/isG1t8tvDKo5D1Jtx6L0ouxZFO4twca/pxHKsYCOqLMiW4aD/ZTKmqiLrmVpgWjl06ZDScwsyJdukue4JyZbn3S5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261022105027099003)(261026140227099003)(261026121527099003)(261022075727099003)(261021123027099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uzFuESOS7xFLc1qI+ym6OCzA+vlXpasxm200/V5/ZZR5ti0hum3nUBcKxep535RWgbIXMv7psIKd1gVG/V7zWTK6f0iupryAbW4vU1PWjN5qvN8X56dFgh8jN3I5CAw+8CURHbzwWrJmBsL62Stg3FCPyZV230k391vKprTbscSoJ7ic4Y56RoqUhsYU1PvT342+mnz3AM9DdDRGwN5EU3Z8fTKvfodwETdfMiKFunimzpL9pWXMdJrTeTfiRaiVss5YZLBO+aHlEVwCwvj/o4kKfvbyKEwijcjGKPWUWyC+R6v0QEww+yLzwqVV3qjRTXMloRVNKv6+/jaGPKXDbfflIaKma9wdpe2YTd6K2VJUVu7/I7TKZFdAahULXoDsYofe/u0ov2KFh/xitoEfVpmhsVe70O5sY7zjRGRH75q+XASMs1hnllKGhvJWB5o+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:24:31.4219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 587eedc2-6c55-419e-51aa-08df44e067cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4330
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

Make sure the ganged queues are handled properly in
map, unmap, restore, and preempt.  Need to call
set_gang to make sure the queues are schedule together.

Cc: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 83 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  3 +
 2 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index ed6f3b67e8720..e41f0e10c8a36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -305,12 +305,16 @@ static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
 
 static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
 {
+	struct amdgpu_usermode_queue *secondary_queue = NULL;
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
 	int r;
 
+	if (queue->gang_primary)
+		secondary_queue = queue->gang_secondary;
+
 	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
 		trace_amdgpu_userq_state_start(queue);
 
@@ -324,17 +328,36 @@ static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
 			queue->state = AMDGPU_USERQ_STATE_PREEMPTED;
 		}
 	}
+
+	if (secondary_queue && secondary_queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+		trace_amdgpu_userq_state_start(secondary_queue);
+
+		r = userq_funcs->preempt(secondary_queue);
+		if (r) {
+			trace_amdgpu_userq_state_changed(secondary_queue, AMDGPU_USERQ_STATE_HUNG);
+			secondary_queue->state = AMDGPU_USERQ_STATE_HUNG;
+			return r;
+		} else {
+			trace_amdgpu_userq_state_changed(secondary_queue, AMDGPU_USERQ_STATE_PREEMPTED);
+			secondary_queue->state = AMDGPU_USERQ_STATE_PREEMPTED;
+		}
+	}
+
 	return 0;
 }
 
 static int amdgpu_userq_restore_helper(struct amdgpu_usermode_queue *queue)
 {
+	struct amdgpu_usermode_queue *secondary_queue = NULL;
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
 	int r = 0;
 
+	if (queue->gang_primary)
+		secondary_queue = queue->gang_secondary;
+
 	if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
 		trace_amdgpu_userq_state_start(queue);
 
@@ -348,11 +371,27 @@ static int amdgpu_userq_restore_helper(struct amdgpu_usermode_queue *queue)
 		}
 	}
 
+	if (secondary_queue &&
+	    secondary_queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
+		trace_amdgpu_userq_state_start(secondary_queue);
+
+		r = userq_funcs->restore(secondary_queue);
+		if (r) {
+			trace_amdgpu_userq_state_changed(secondary_queue, AMDGPU_USERQ_STATE_HUNG);
+			secondary_queue->state = AMDGPU_USERQ_STATE_HUNG;
+		} else {
+			trace_amdgpu_userq_state_changed(secondary_queue, AMDGPU_USERQ_STATE_MAPPED);
+			secondary_queue->state = AMDGPU_USERQ_STATE_MAPPED;
+			r = userq_funcs->set_gang(queue, secondary_queue);
+		}
+	}
+
 	return r;
 }
 
 static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
 {
+	struct amdgpu_usermode_queue *secondary_queue = NULL;
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
@@ -361,6 +400,10 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
 
 	/* The reset changes the queue state and the MES is unusable meanwhile */
 	guard(rwsem_read)(&adev->reset_domain->sem);
+
+	if (queue->gang_primary)
+		secondary_queue = queue->gang_secondary;
+
 	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
 	    (queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
 		trace_amdgpu_userq_state_start(queue);
@@ -376,16 +419,36 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
 		}
 	}
 
+	if (secondary_queue &&
+	    ((secondary_queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
+	     (secondary_queue->state == AMDGPU_USERQ_STATE_PREEMPTED))) {
+		trace_amdgpu_userq_state_start(secondary_queue);
+
+		r = userq_funcs->unmap(secondary_queue);
+		if (r) {
+			trace_amdgpu_userq_state_changed(secondary_queue, AMDGPU_USERQ_STATE_HUNG);
+			secondary_queue->state = AMDGPU_USERQ_STATE_HUNG;
+			return r;
+		} else {
+			trace_amdgpu_userq_state_changed(secondary_queue, AMDGPU_USERQ_STATE_UNMAPPED);
+			secondary_queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
+		}
+	}
+
 	return 0;
 }
 
 static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
 {
+	struct amdgpu_usermode_queue *secondary_queue = NULL;
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
-	int r;
+	int r = 0;
+
+	if (queue->gang_primary)
+		secondary_queue = queue->gang_secondary;
 
 	/* The reset changes the queue state and the MES is unusable meanwhile */
 	guard(rwsem_read)(&adev->reset_domain->sem);
@@ -403,7 +466,23 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
 		}
 	}
 
-	return 0;
+	if (secondary_queue &&
+	    secondary_queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
+		trace_amdgpu_userq_state_start(secondary_queue);
+
+		r = userq_funcs->map(secondary_queue);
+		if (r) {
+			trace_amdgpu_userq_state_changed(secondary_queue, AMDGPU_USERQ_STATE_HUNG);
+			secondary_queue->state = AMDGPU_USERQ_STATE_HUNG;
+			return r;
+		} else {
+			trace_amdgpu_userq_state_changed(secondary_queue, AMDGPU_USERQ_STATE_MAPPED);
+			secondary_queue->state = AMDGPU_USERQ_STATE_MAPPED;
+			r = userq_funcs->set_gang(queue, secondary_queue);
+		}
+	}
+
+	return r;
 }
 
 static void amdgpu_userq_wait_for_last_fence(struct amdgpu_usermode_queue *queue)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index efaa658a26a9a..3dd63d6b9c445 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -102,6 +102,9 @@ struct amdgpu_usermode_queue {
 	} userq_vas;
 
 	uint32_t	gang_ctx_array_index;
+	bool			in_gang;
+	bool			gang_primary;
+	struct amdgpu_usermode_queue *gang_secondary;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.56.1

