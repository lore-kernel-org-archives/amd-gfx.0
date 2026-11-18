Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AFE60A2639
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=osYTN6tZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE9E210E0B8;
	Wed, 18 Nov 2026 22:37:43 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04E3B1120A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 22:37:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sySqqBr6ARRFPy/mO8hGehMMOLAApTS0hFkiBsTGooa1cykwaL24l7EjSnFS1FX48lU/5zmD4+RE/gKOdt31q5VXEmlx5A2uYLl/uFagTrHWebOcFytllbYQzhB5Yl/7DRFy5EZlUrEeru2V3zXAk6pbxMGYZfjocvEhJ15OvF39x9DHWMu4hrfypbhqbDdRElpl5tdIVvMncyp1oDJoOMjxlv8TRaXldaebAnaBPBFhWCGjNYVC4Sb1PjYYkT/Lb69tGZPCSo/VngMsAcwhu+tz1Se4P673WTQ619dGFaNA2/Fndr5smDYOjd1/MN8+0Pk8Uo2EtwvooJSrvfJHKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFHlibZhXnrZkKcPuHkGGTvXcPIfLWte0SW48S7JNvs=;
 b=kXy1ZBns93BEQcWoAQCRyNgcNxmIn5yjUC0TfYbZW5pJxkmQ6fQwUct1PMmV86CzuOmAvvWtRIPzzvutTlrbT55yJDVr/bpzbyww4BHHcbRVIhGCArpq+y4H1lYQde9Vkdf5h3ArXD7QzM0EIZf/b4IBPI8cJ4tw4OffXJVoC5VbCkmEMnIXz1LgVkE6BT71puSvFUhYXN5BAgBjXwg9f3ADqkTVtuccylDygLvtGDlo7Luh8LsMLovEbcraHLlYYzAs5KR/9R07LEsVcdEW7I/zw0ertUYWxhVWYcPff+kNWecee/P5lD3A3dIwl5vEw0YRKUiN3d99xaP/EP+sTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFHlibZhXnrZkKcPuHkGGTvXcPIfLWte0SW48S7JNvs=;
 b=osYTN6tZ/gx+jWQYJ/URGMwQSsro289kQpMWrhWZ7BgBe/2Z/j/UrwCrAsmXuzLOazDtpwsXN9DMe83fjXxdoBvJfZt0eqHRD5Uum/0NKlMUvMxklYuiiefD/rIKvIK6Jmp2+VdqBaPQisoT4owBrX5O+P3boVeHF9tjm3dytCQ=
Received: from BY5PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:1e0::31)
 by LV8PR12MB9333.namprd12.prod.outlook.com (2603:10b6:408:1fa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Wed, 18 Nov
 2026 22:37:31 +0000
Received: from EA8PEPF00000006.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::61) by BY5PR03CA0021.outlook.office365.com
 (2603:10b6:a03:1e0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 22:37:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 EA8PEPF00000006.mail.protection.outlook.com (10.167.249.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 22:37:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 16:37:28 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 16:37:28 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 16:37:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yogesh Mohan Marimuthu
 <yogesh.mohanmarimuthu@amd.com>
Subject: [PATCH 08/11] drm/amdgpu/userq: add handling for set_gang
Date: Wed, 18 Nov 2026 17:37:09 -0500
Message-ID: <20261118223712.2518580-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118223712.2518580-1-alexander.deucher@amd.com>
References: <20261118223712.2518580-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000006:EE_|LV8PR12MB9333:EE_
X-MS-Office365-Filtering-Correlation-Id: 614dc1a9-09c5-429c-8730-08df45c48828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|261102123227099003|56012099006|261026121527099003|11063799006|261026140227099003|10067099003|261022105027099003|261022075727099003|261021121427099003|261028144727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /zDenA7RbfABWqeMlulW9LILCjwoy4S2lUbKdMnyEEcUUi6TyEEZiqvdtKpT6MkC2CFevtQOAd47AOykOmHnzHe+Rapp8/WaZY9kqmePwBuRD7uyeOZMqGbZmP3jnfMDlFYvrqFrC2KZjc2b1JEAX2lFZy5WukKOmCf0n6FkfGeDrJbeTIOCTb+pRIESUl0a8vvBoqqwNmjjhmoEv8wo2UPpCyVFOAJtayrQ+NDerNfrk3YpaIzGClzxAS5zkN0oiyEPH60MQoLYu3kmOfAbjVaFhmT5QKyuxajvvrgj7aWhvH5l8Yv48uq5qyOqvUXuyXC/CaU+IgiFXQ7OpSxn8hjj2VMpVK8hETyJVcmSz9HrYp1xLdfZwLHK+6mj2da6NqqZQCXXAwO6yoPnRRZC4VjWJ2fFWlWDuMWpOLL+m+ZM7wuP/eM0bU+Pkt40TBM/ZjgG5CNbk5hsESdPhX6tbtY7CugjDwvz0QndrBqVXrdEkL1lX1Y/IiRAYq1V5l6lA2Idtn6n5Sz4/cymhwjVl68LCLR8usoOwNNGw8IiMnG1TipSljEya3ZyLDTDSmvrg55Vxv1cuGFR5he4cxlK/JO7C/M/WQeE8rqyYyL9Q7kfQ6G3Uec50PEUU7BkuOT+8FAMlVtLVLuhZjibp2mjflimnElAHlpAnvHl8QmmeVJVuydIVqdEqvB4fyYokjJckx6s8a4Iyz2nk4GPowEKIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(261102123227099003)(56012099006)(261026121527099003)(11063799006)(261026140227099003)(10067099003)(261022105027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AhANAveUA5dujGuBMG/+cZBcG6WAYQFCeV4B4s+DRQyNs1aWZayaYS4NlW1FvutRMAW7tw4MFBbEr/II8sw7we8OtR7Nc16IoOa7QEzfio5J87w5mUKwuM4pT0vois1i7FA5kWNTq1yVr2jDex2xDRZu1fwhQc0VnOi0wKZVVat6Kw6yGDSaxeexNt+vSfUz7N3V+pFutrhABIKsccUQUy8WErl81SGXNjuFZIkAtpb214NOGFVgGpxAslKTy39d4QB2oSkZePkvSevtyt2a+fsA31IumOa43oTydO7IzYL5N1w6lM+WCbwymgmRXL+4i3zG8YCRo3YUJNZcVH7OZgHPI4HaqUPrlEbsl0zUhUVz5lSgu4N7tbjMUSPwMu70CUc4cdYEQ620uWz2lRG4mG1KEjrgiCli3QwjJx/Rkpgn3BQyz8Oo4lTYwJn3zYOg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 22:37:30.8830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 614dc1a9-09c5-429c-8730-08df45c48828
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF00000006.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9333
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

v2: rework all of the logic

Cc: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 40 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
 2 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index ed6f3b67e8720..3afd17af28548 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -303,6 +303,27 @@ static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
 	return true;
 }
 
+static int amdgpu_userq_set_gang_helper(struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_usermode_queue *secondary_queue = queue->gang_secondary;
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_funcs =
+		adev->userq_funcs[queue->queue_type];
+	int r;
+
+	if (secondary_queue &&
+	    (queue->state == AMDGPU_USERQ_STATE_MAPPED ||
+	     queue->state == AMDGPU_USERQ_STATE_PREEMPTED) &&
+	    (secondary_queue->state == AMDGPU_USERQ_STATE_MAPPED ||
+	     secondary_queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
+		r = userq_funcs->set_gang(queue, secondary_queue);
+		if (r)
+			return r;
+	}
+	return 0;
+}
+
 static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
@@ -968,6 +989,11 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 		if (r)
 			ret = r;
 	}
+	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
+		r = amdgpu_userq_set_gang_helper(queue);
+		if (r)
+			ret = r;
+	}
 	mutex_unlock(&uq_mgr->userq_mutex);
 
 	if (ret)
@@ -1446,6 +1472,13 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
 		if (r)
 			return r;
 	}
+	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		uqm = queue->userq_mgr;
+		guard(mutex)(&uqm->userq_mutex);
+		r = amdgpu_userq_set_gang_helper(queue);
+		if (r)
+			return r;
+	}
 
 	return 0;
 }
@@ -1591,6 +1624,13 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
 			queue->state = AMDGPU_USERQ_STATE_MAPPED;
 		}
 	}
+	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		r = amdgpu_userq_set_gang_helper(queue);
+		if (r) {
+			dev_err(adev->dev, "Failed to gang queue %ld\n", queue_id);
+			ret = r;
+		}
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index efaa658a26a9a..145d53363ed2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -102,6 +102,8 @@ struct amdgpu_usermode_queue {
 	} userq_vas;
 
 	uint32_t	gang_ctx_array_index;
+	struct amdgpu_usermode_queue *gang_primary;
+	struct amdgpu_usermode_queue *gang_secondary;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.56.1

