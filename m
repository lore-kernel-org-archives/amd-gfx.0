Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9538FFB44C4
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 08:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41C2510E3B5;
	Fri, 24 Apr 2026 08:20:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YU++nSxL";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011065.outbound.protection.outlook.com
 [40.93.194.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 579AA10E3B5
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 08:20:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKjDTjAxZzg5+3v6exgo2TmghLcphoec0zf9CoXE9I1qxiFUuErRazmkflcIYv/8woYBWRRj8hG67kTpneLJ4UQvwO9i9Dj/eEzDtWlJsVf+F4ZhAhjrx6KK9SViNazNGjep0ufpFYJrgHm2dR3KIOzxOdrFTNKp/zsVrVmQ/2QcwSBJyV+anv4ywAm73UI7Orb8glyN6eNVM52tSJ6MxnUWo1GFiD/2ruk8afFYR9MK3sx81fsK/+/OTLNujmY4lpUPo4kTOdtU+E+HfNccs0DdFbWEDy0DrAcAI9WS7TLs1CsoUZHH8P7QckccnuVuXYDQmRfIqXsVZ4zWtu7ifA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/Fe6cJeufeNsJdlK0qSpGLTZV/IpRXysq/tF/2iXFw=;
 b=Xi0qt+6xepuUr5Xc4OEE3lvrM7ClM2P9O1nqoFm3S4LIc/fhJohDTLQmillg1RNGGNzwTZQt58f8Dov+gxr499gLz795ui7VeN7rtGzZytkp6mIciZU/ekV7Bh6jyDYAnhe8GFaXc1DAZwhtH2PmOwFrdEjBn43mt6XfGWZuDXtGgedF8+jC/wMTh7l7Oa8T2iNdRREGM8TA2cB+XHu8OK6Tq8w09Th5wtYNPg9pUMFmO8aIq1aFZYLaEMNevRtxPV38u+eVEbDpIJoNeW+b+Fb09l1v8M+Xe31bK9OuRei2p0sa8i24dR3tfIa3Ulf0hNj1HgAE6Y/71gb9wBpjsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/Fe6cJeufeNsJdlK0qSpGLTZV/IpRXysq/tF/2iXFw=;
 b=YU++nSxLEaKUY2godi4hYfbzmQ5ZMGt2+54xxeCR1XFLQLMkC1l+NwgOll27jbngB4U5aukO7teZxjNeollKKJHDSewU/lujoxYOQ+tPPzfyzfNpoAymBerJ7lCzQIA37yCUtuFWwX8CoclwyJfLhqyqu+wluz4JUM+vN/4A1nA=
Received: from BLAPR03CA0169.namprd03.prod.outlook.com (2603:10b6:208:32f::21)
 by DS3PR12MB999218.namprd12.prod.outlook.com (2603:10b6:8:38e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.14; Fri, 24 Apr
 2026 08:20:12 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::9) by BLAPR03CA0169.outlook.office365.com
 (2603:10b6:208:32f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 08:20:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 08:20:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 03:20:09 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 03:20:09 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 24 Apr 2026 03:20:03 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 02/10] drm/amdgpu/userq: route SDMA UMQ doorbells through the
 kernel pool
Date: Fri, 24 Apr 2026 16:18:47 +0800
Message-ID: <20260424081955.873090-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260424081955.873090-1-Jesse.Zhang@amd.com>
References: <20260424081955.873090-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DS3PR12MB999218:EE_
X-MS-Office365-Filtering-Correlation-Id: cca2fe30-0d20-45ae-f13e-08dea1da4e77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: +28soWQ5phgO/jSv1vXuM6uEnlJYu51af15DOtNtclZw2+NE5SFElF+h2jBcID8N8/nD5v8lBeHPUpWexEy8oglvQ0ecyWURI3dCABMiAFuHU9syYPZx35s+IZqQonX+gW1Ir4sjy2PoWZVQU9g49fYLo9OiMfHXxy+qPbj3HwF41BXLra4MDIODp0jmLQxteZFrDG+iIfKqDAJ8aZfzCC/pYw2ZCYov5yJiRH28UGqkIT8kb9GUc3jlGYeaWw8RjFReAPlAwMYnj5zFyFjZFk1C/NRQUWzP+zrioRtL04he3aCcXQtNsLfjjNLDLlTWTUsDXSnBIQNcM8Oduf6cA0cldpm1ao0y44CCBx0WeOv3ZfIOFblVHtE93S75tK0tgYnz1oGNa8VD2dmCFrSFWw12+1XWWxMgDZ4QAn+mfpeZTsE8vQMEiarIyeWckSzXKDyvTdyeoz66AXvxppFhZXCLtVmwtJlx1FfK5J+rtu8z4NG+8DsjDlQSBjnK5/bn3ePoPS6Ex+hfcSASt/9z3NoM5zhsuuGSNdMP18VnIs2kET+ffkGXzBfDyLcN/GZ0QfKWaROGSpajGfat4i1R09ITRDX7BYaQQJQ0afPNSf3G6k2fDmEmoLuZNPF24+9Lu9qoz6NJOGHH4Ke6yJZZfmIajXLQL1sfMk105kgPhtaUajPc+4hciHPD5k1WIRb7AqaOv7H2EqxcvS5A7nbXKcxIAl7j4xJsZSmX/eSRo+tqy4NaL5a2WCIAFS7/0SCutc7llIgQjHlpdbeR7+FX5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VReyaDxYJ/lI/op50EnIJ5GokPgJ8X8kcER6GT3WeRi78TQwp+n+XM4B+EC12mjESxzhM/pXqthM3QRaeBhnTSEBb10csRUarHoLi5JRFl0qs1WvZbzz3YGgRtoBIhgjsQvmXkDgEjsnclw9BQpj9sBVwfmUp8g7flJIuQA3Uk5GLzRNwdnHYS2BWnHmhGUYmVtyczltXhGeRpH0ElaawdYxJVVAR0gEv2SGq5cdccBcUK7tqLSoL1bCxIgy1BbmACzKVbjR5tOcS3ac98NIabYSVfcjrNZamsFbaGGkTUYIiPzEYlATmwNqb1GDOZxrigyQIcQN2tn5MjCv6odhNyDSP7/Od03XBHtl3XcxeixZknoz9CG84L9EosfwRYlAbywAiYur7/vD3NVfskop/kCRbvMTGRwsCsy3vyrJ3GZdy2EihKS3o1uQlO25ukSG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 08:20:12.4262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cca2fe30-0d20-45ae-f13e-08dea1da4e77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999218
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

From: "Jesse.zhang" <Jesse.zhang@amd.com>

User-allocated DOORBELL BOs land at BAR offsets outside the
firmware-managed NBIO SDMA decode window and cannot reach the SDMA
back-end.  For AMDGPU_HW_IP_DMA queues, ignore the user-supplied
doorbell index and allocate one from the per-device pool added in the
previous patch.  Track the assigned slot id on the queue so it can be
returned to the bitmap on destroy.

Add a new sdma_doorbell_offset_bytes field to drm_amdgpu_userq_out
that tells userspace where its kernel-allocated qword slot lives
inside the BO it will mmap (the BO handle comes from the
AMDGPU_INFO_SDMA_USERQ_DOORBELL ioctl added later in the series).

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 47 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  7 ++++
 include/uapi/drm/amdgpu_drm.h             |  8 ++++
 3 files changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 8f48520cb822..cea0f9cb59d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -662,6 +662,10 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	amdgpu_bo_unpin(queue->wptr_obj.obj);
 	amdgpu_bo_unreserve(queue->wptr_obj.obj);
 	amdgpu_bo_unref(&queue->wptr_obj.obj);
+
+	if (queue->sdma_userq_db_slot >= 0)
+		amdgpu_sdma_userq_doorbell_free(adev,
+					(u32)queue->sdma_userq_db_slot);
 	kfree(queue);
 
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -762,6 +766,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->sdma_userq_db_slot = -1;
 
 	db_info.queue_type = queue->queue_type;
 	db_info.doorbell_handle = queue->doorbell_handle;
@@ -792,6 +797,38 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto clean_mapping;
 	}
 
+	/*
+	 * SDMA UMQ doorbell override:  user-allocated DOORBELL BOs land at
+	 * BAR offsets outside the firmware-managed NBIO SDMA decode window
+	 * and cannot reach the SDMA back-end.  Replace the user-supplied
+	 * doorbell index with one allocated from the per-device
+	 * sdma.userq_db_obj BO that sits inside the routable window.
+	 * Userspace fetches a GEM handle for that BO via
+	 * AMDGPU_INFO_SDMA_USERQ_DOORBELL and mmap()s it through the
+	 * standard GEM_MMAP path; sdma_doorbell_offset_bytes (returned in
+	 * args->out) tells userspace where inside that mapping its slot
+	 * lives.
+	 */
+	if (queue->queue_type == AMDGPU_HW_IP_DMA &&
+	    adev->sdma.userq_db_obj) {
+		u32 slot_id;
+
+		r = amdgpu_sdma_userq_doorbell_alloc(adev, &slot_id);
+		if (r) {
+			drm_file_err(uq_mgr->file,
+				     "SDMA UMQ doorbell pool exhausted (err=%d)\n",
+				     r);
+			goto clean_mapping;
+		}
+		/*
+		 * Slot id is a qword index inside the routable window;
+		 * convert to absolute BAR dword index.
+		 */
+		index = (u64)(adev->doorbell_index.sdma_engine[0] << 1) +
+			(u64)slot_id * 2;
+		queue->sdma_userq_db_slot = (int)slot_id;
+	}
+
 	queue->doorbell_index = index;
 	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
 	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
@@ -851,6 +888,16 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	amdgpu_userq_init_hang_detect_work(queue);
 
 	args->out.queue_id = qid;
+	if (queue->sdma_userq_db_slot >= 0) {
+		/*
+		 * Tell userspace where inside its mmap of the SDMA UMQ
+		 * doorbell BO (handle returned by
+		 * AMDGPU_INFO_SDMA_USERQ_DOORBELL) the assigned qword slot
+		 * lives.
+		 */
+		args->out.sdma_doorbell_offset_bytes =
+			(u64)queue->sdma_userq_db_slot * sizeof(u64);
+	}
 	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
 	mutex_unlock(&uq_mgr->userq_mutex);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 675fe6395ac8..cdfced627dec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -59,6 +59,13 @@ struct amdgpu_usermode_queue {
 	uint64_t		doorbell_handle;
 	uint64_t		doorbell_index;
 	uint64_t		flags;
+	/*
+	 * For SDMA UMQs whose doorbell came from the kernel-managed pool
+	 * (amdgpu_sdma_userq_doorbell_alloc), record the slot id so it can
+	 * be returned to the bitmap on queue destroy.  -1 means the queue
+	 * is using a user-supplied doorbell BO.
+	 */
+	int			sdma_userq_db_slot;
 	struct amdgpu_mqd_prop	*userq_prop;
 	struct amdgpu_userq_mgr *userq_mgr;
 	struct amdgpu_vm	*vm;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9f3090db2f16..79e8bbda046b 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -421,6 +421,14 @@ struct drm_amdgpu_userq_out {
 	 */
 	__u32	queue_id;
 	__u32 _pad;
+	/**
+	 * For SDMA usermode queues whose doorbell was assigned by the
+	 * kernel from the per-device pool (see AMDGPU_INFO_SDMA_USERQ_DOORBELL),
+	 * this field carries the byte offset of the assigned slot inside
+	 * the routable doorbell window so userspace can write there.
+	 * 0 means the kernel did not override the user's doorbell.
+	 */
+	__u64	sdma_doorbell_offset_bytes;
 };
 
 union drm_amdgpu_userq {
-- 
2.49.0

