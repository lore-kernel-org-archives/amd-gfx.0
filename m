Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA04606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=GzsTFou/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE47A10FA93;
	Wed, 28 Oct 2026 08:58:21 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6777D10FA6C
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 08:58:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXDVyHexIBXUjYfimiA8xkuXk2q8COOgy6ZGN0yJabEe5KjuHL9nDdWsKObJAUtMbcsymSQdHp8QbqStv4cGuSDKqp2Q0ZBOhThxzDFJ5WL1blw3jkaHEV4qajZ7ktmzBuXYvRmKnrtWnIDHpF746L0a9d6nMywudv/3jL9h2SyOaJSa2Gr1o80KrbbJpZ8l/q6r6qM5NO0J7k0nt3bC2C6DBrjW64AcdFsxgxpNi3qadYCzQQMiu7KvVgR0Ojlh/DCOT4k4R3K8CQGkyhub8Ys/mLauYSpmXEcHNDdvA8+6RpR5G2yK/EWI0in9S8KBrdDRthUNuDL2JEYEmgRBkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXEbrVzNi4wkwrV13z7yorTV9EThdsSVcNmx0a3pors=;
 b=wuSf6EkaSy9hCGHYUlDUE2roCg+yEMh8eifILZjAIzqEHH8lEikK5jspPMVY/5bGKGv6zTUScX2PNvXGTQgRCsCo/Et7mI9Hi4ZbQY5bGaBnTFvfy5AD4ikQlPC0GeoaFI1/rX8aAB4eKNUoSIUysa7Ncl+HmBh1piKiBm8YQUd8gMVgvAL7XKhGnnyVGE4OtdtkOFBUy6WgXP+yz0v5tgafWWGh5VGWgfnB9FDfWBd1Had1SuDjOvs+8mGcpZyOu2yEXQ2QRZj6pPING9jQIiXDIoqPZX11P5BjuGeJ77EYhXsbyt7r9NzYGkrUlsK0uuHlMTpvGCO8ffEMSVziIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXEbrVzNi4wkwrV13z7yorTV9EThdsSVcNmx0a3pors=;
 b=GzsTFou/OVXOcqfVBm+RQcX0aSHMFtP6hpbZ4NjQKaB6ayXrkvVQ9S1kzKK4KHTwXJ77iPX3mzMm9s10dkzlYpGYyFzmenIVB/TomYTCkXi+SUT89iAxiYZMtbH1K0so8aTSqE1reriIOaOh4pyBt+RsRcgugh8D3Ax5hzm5ZZo=
Received: from MW4PR03CA0353.namprd03.prod.outlook.com (2603:10b6:303:dc::28)
 by IA1PR12MB8335.namprd12.prod.outlook.com (2603:10b6:208:3fa::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Wed, 28 Oct
 2026 08:58:03 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:303:dc:cafe::a5) by MW4PR03CA0353.outlook.office365.com
 (2603:10b6:303:dc::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 08:58:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 08:58:03 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 03:58:02 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 28 Oct 2026 03:58:00 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v3 10/15] drm/amdgpu/userq: add a helper to signal the fences
 of a queue up to a point
Date: Wed, 28 Oct 2026 16:56:41 +0800
Message-ID: <20261028085736.3808569-10-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|IA1PR12MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: 890b7059-2b7f-41d9-db4f-08df34d19326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|11063799006|56012099006|261021121427099003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hQhvfgxgJk62Y7Vj2Ww6FaS0TGqhJk9x14o7E3ghqXpD7R5r83B0BsvOQ9PCApBEq1WIauRnx4R4ubF4N2cRlk/EmT9v1aRI+gSfFkBjkFBc8OCXzlqSEL1GjAul0Duas8HRauHZ97Dcn6IAj6IRc+33UjAZULj0B/O7fFniT1TJ3DHqu3DG4j6lRlvMUp1lWm+g/5gy4Zk2Bp3TUem1FlNBxD40z9e5s1fKa4SuKwothqTWdnCOmzW006QB1Qic/pus3+Pcmxigfeiy8MSlg+ibkDUvVCyW9v2CTWnSRyI0zFXjW2BlW2NIsgoEIZsaq7trSR32/FfgXsqQmhzMFEd4Er36Nlmkzp2CGwKZod+twe0yaofZxwtfD5IpIxuecSliPOEPL5S7BIwjUeHrsO24CzyenmCjxzZhjZV8e2Cm4CUFoQyop0yR4BLmjM9ZoAEiOcG2ZC/23s0Af1fWLfUkEtSefELaP+YJQXo+QMjxSFOZwFjZnIsERpKSiOYcG20IpkMkpMQVZso6bJQ6bZZaLW1rOhtVDAqU+NDaDrtGRq5hzzJVBSDTsxfAw1i+xNUhq/OgA5l29f5G4iQCgqvKHkITBnc3JaK0psuVk+2DypNriKH0aK2MQ8bs6pyHj7h02orPhFYDaQVZJWXuJiBQ50FOSkZjGpvMrTc28r45ypJ7uDptuUv7OY+G39iZC051bAd98m71BBGeFGQlPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6Pr5WKi8kwcqWZIUMuDDs1mfQe3jEZ38oJPvxzFczLLEMAlCG3GgzzCpnRAb3q4Qw6s8s2kFxr5ly+Mq69Ijnrldfq0B78XAdi3+tAzmv6iXLLWheNN0CHu0f3QH2lw4/bShLFfoZLW125Q/MoBTeDXjKaVvnb3Rh1uUD3/cjC64Wgkpqj28F3a0nponcISPR1JohtjVvJmbsYNnSBKM/7w7OumFkV4BtPHb9JHbeJJ5tcr8O4xBetbRPRlR4d1r7ixcItFrQbF5XJhj6e/OEP5Gt4XfpxFsv32vIbiQ2Oc25GwXYHWINTC7MVKhPtfuQezAbAv7yir50ckrmKZr5Koray+VP7xTLzgBbCcgTAyGZ7Tij2w/bZXA/fvi86v+R+nSMPfJ5zCJDna1wjH5DZvdB2v/VwzXjJcx2RErgUJkLzTq2UL1DFAb2wJ/gOy3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 08:58:03.0248 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 890b7059-2b7f-41d9-db4f-08df34d19326
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8335
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

The fence value of a user queue is the write pointer of the queue when
the work was submitted. amdgpu_userq_fence_driver_force_completion()
signals all the fences of a queue, as after a reset that dropped all its
work.

Add amdgpu_userq_fence_driver_force_completion_with_seqno(), which only
signals the fences of the work up to a write pointer, with an error, for
a reset that drops only part of the work of a queue: the work submitted
after that write pointer still runs.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 31 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a2fa59a9609e..e76249c43b7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -459,6 +459,37 @@ amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq)
 	}
 }
 
+/*
+ * Signal the fences of @userq with a seqno up to @seqno with -ECANCELED, eg.
+ * when a reset dropped the work that would have signaled them.
+ */
+void
+amdgpu_userq_fence_driver_force_completion_with_seqno(struct amdgpu_usermode_queue *userq,
+						      u64 seqno)
+{
+	struct amdgpu_userq_fence_driver *fence_drv = userq->fence_drv;
+	struct amdgpu_userq_fence *fence;
+	unsigned long flags;
+
+	if (!fence_drv)
+		return;
+
+	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
+	list_for_each_entry(fence, &fence_drv->fences, link) {
+		if (fence->base.seqno > seqno)
+			break;
+		spin_lock(dma_fence_spinlock(&fence->base));
+		if (!dma_fence_is_signaled_locked(&fence->base))
+			dma_fence_set_error(&fence->base, -ECANCELED);
+		spin_unlock(dma_fence_spinlock(&fence->base));
+	}
+	if (amdgpu_userq_fence_read(fence_drv) < seqno)
+		amdgpu_userq_fence_write(fence_drv, seqno);
+	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
+
+	amdgpu_userq_fence_driver_process(fence_drv);
+}
+
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index 0bd51616cef1..0407c8c2575f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -65,6 +65,8 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 void amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq);
 int amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
 void amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq);
+void amdgpu_userq_fence_driver_force_completion_with_seqno(struct amdgpu_usermode_queue *userq,
+							   u64 seqno);
 void amdgpu_userq_fence_driver_destroy(struct kref *ref);
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp);
-- 
2.50.1

