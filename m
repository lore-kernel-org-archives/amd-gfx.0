Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE36F433DD
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 03:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B38210E7FF;
	Thu, 16 Apr 2026 03:44:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MpraiBuc";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0005110E7DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 03:44:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rg0r/nT9WucuYY9XV9LzcOJ9nYym2n5fUBVf5W0zax7QYjpdjhcuBjo5MLujYY2TDnfNITYd3YnrFMuU8ZzdkElRLxcklg1nFul057pSHrF0CjPNTnBrbgW9GwfjEMPQ8wqE2rDwcBYDZDH0wnt1vJrPgJZdZK/ldD3aYgYmtZUsvxJJZa4VTOzAfKZBnlY7GoTVpkvNk/gNCtwbRggZ2Q9n+xyweqg7KGUz09bUPqaAMlrl1WwUjqdFdl6UkQywUAnIYo32dexBMtiLhPhuWA+RJFYyJ/aYdLqltmwdcPke84gsOJ6GB8A4gvvPY1nAjirFcsL3XNe+m78wqjnBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrdFhplxS+uaqxJJxb7oIPIy2hETIpSrd+srsXjAH8w=;
 b=JMYzLL8LdwINjuqoKx9j7ksq+P9IESd9Nrf7M8i+22lvXfa4ibybMU1G6PXAYeAQA8s501wxfGCYHfa3dx0TOgX9A2xLKD9eIwaqpuCc/ijytqPB43Ksbz61KZBu2tvYdYBtDJs7jrhRjDlp1oh14dUBpkmyAPnsp+y0S3Iu3/XMFnjqBBXOv4+JwcIxnAUr64A/7MAFVj7ijIj+QYOh8ZmePemDUdhZQlRzchxKof/0SpXO2RlbX6rEAOibPp0C4VzRFwCHD6jsM9dUgF2bZWmNYf3nDIHJn6XEMu8+esYPKaaDJgrUyn72XVhrdpvm/u7mPesN92smX52UPFKCGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrdFhplxS+uaqxJJxb7oIPIy2hETIpSrd+srsXjAH8w=;
 b=MpraiBuc/+qrsKP41eZi+6tLcsyZGvHXX8XuQkLhc+xWhCo+En8KwGr7qh8V6Q290jyenswpvaZUUwbvLhzcewN1Bf50j2tC5nQw/UqrsgHnZGrjPPoiLBdPiBU2G9lGyEDsrKeOES8O0mZ+J3vN95pnajqoa2Y6m7vfSv+V6uw=
Received: from BL1PR13CA0411.namprd13.prod.outlook.com (2603:10b6:208:2c2::26)
 by BN7PPF48E601ED5.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6ce) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 03:44:49 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:2c2:cafe::d4) by BL1PR13CA0411.outlook.office365.com
 (2603:10b6:208:2c2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Thu,
 16 Apr 2026 03:44:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 03:44:49 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 22:44:47 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v4 04/11] drm/amdgpu/gfx11: Queue USERQ_EOP records for
 WAIT_EVENT
Date: Thu, 16 Apr 2026 09:14:13 +0530
Message-ID: <20260416034420.2368152-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416034420.2368152-1-srinivasan.shanmugam@amd.com>
References: <20260416034420.2368152-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|BN7PPF48E601ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: 8936d0b9-f442-45c7-b9e0-08de9b6a829e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4I05UimkZ/KnemPR2l3giZYcuRDHx0n1iXQ42tRG2nUa7xckECQw/BwCxvmlU/b7gg0Yw5LiMFUjjHeVxJoKzWiZd1ag1rWuX2IPqqV/hg10Zss7WbkniFQq35im80n0Qs2pP8QUNjwNpM9+x6qznlJVAgxYlL+4lpuZtSUUVc00kTq/nwng009UilhciuG4KuLuuZCoOD4LCbMoEL9K47imzLvhRISw9H2qfI7JIeioeusjtC1vFBvJcNY8+iG1aooomKmB8/H9PvLpza6qAnFOE4e6yEBToQ7mMKEX4M5qwk5fWHf47mmaab5oP2Vlg7KfkkKHB7M8yIBHQeT+9sppQFGy0cHveunNfTmD7w+O8ca3JmTYb5o/oLRt75YiYADiuEqgHb3ZQhbHfxarVSg2t7b38n3r3pYQIHIU2dQr3FrBy5NSzyVaelB1Ra+KhSz0G8iIgYF8KaIB842sO6F+Mh5jxPHaGmDdU1HlC8LmvANM9kC/cUYlfR3OalHezU1ew/68wQ8Ue0BGyC7Zw2HcEqTNLAHxdH/jLFf/KRw6i2Qw268xszfwypuPKUTdY8zCxFaJrg8Hguvs8jyQrj1WThdPakhMTJHc/eFn6uTziZhUnPtttD+/I0XNZcPhH4ygxL/d8KqAKJSY6Um2S3ZErKJddFqhBZxFrgGync0360yQtxHBml8EiKYfinqgTs9zopsuQbUtDXQ3yskX3vciAdXMAy8VP1h+hHulDoCFllZrCWp4Dl8RPOiQEK3KNtPSO0pG5rxxjBndfU3Wtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Twg3+rhhR69oC6pUD4IGCaqvVChG7l/weE5CX/VypLuUbKTIVkssyg7fU+E6lZJQta9I1ifGyovZvUfXQPVq/aFvpZvsQmfR5nLc7wIVkjHvmaYo6VHFGaNz2FoP7yeC2VkIvqHLhwUEHT7QBZKVNpgZmDcVmC0UJTH3zixvz9nZp2/tMUspYsy1CI0PWqalbm9xvdRheBCdmJBRYW+L5O6afsmTDOBk3OEwpVnLzoET97+Z85DcWH8kWPaftVHTS5Fc6mZkmp+Cr7gDAhrsGAMQYIcPHdKsEBiEx+Sf49/XiDwnz+MCLKxgPWeEjZLlLv/VbMOF2Az0PxCsyJPEmtntClXsbAB66FoxJRwK3o1uOKf9JnqbYBA359P/k5aHMi4gBA4Q8aETJZfCoPF5bskHhZA3xE0Hob2v6RQRdkR+z4r6nFxpZqxy1cdnxYb+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 03:44:49.3003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8936d0b9-f442-45c7-b9e0-08de9b6a829e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF48E601ED5
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

Queue USERQ_EOP event records into the per-file wait-event manager from
the gfx11 EOP interrupt path.

This wires the first producer into the WAIT_EVENT path.

Use the doorbell offset as the current queue selector for queue-scoped
waiting. This keeps the initial wait path independent of a separate
logical queue id definition.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index ea11070abbd4..29fd98b7ef50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1327,6 +1327,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 	userq_mgr->adev = adev;
 	userq_mgr->file = file_priv;
 	userq_mgr->eventfd_mgr = fpriv ? &fpriv->eventfd_mgr : NULL;
+	userq_mgr->wait_event_mgr = fpriv ? &fpriv->wait_event_mgr : NULL;
 
 	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 8ce039eec2b3..725c33ab5c44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -106,6 +106,7 @@ struct amdgpu_userq_mgr {
 	struct delayed_work		resume_work;
 	struct drm_file			*file;
 	struct amdgpu_eventfd_mgr	*eventfd_mgr;
+	struct amdgpu_wait_event_mgr	*wait_event_mgr;
 	atomic_t                        userq_count[AMDGPU_RING_TYPE_MAX];
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ff43902a9c48..20864d12ab33 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6546,6 +6546,10 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 					      DRM_AMDGPU_EVENT_TYPE_USERQ_EOP,
 					      queue_key);
 
+		if (mgr && mgr->wait_event_mgr)
+			amdgpu_wait_event_push_userq_eop(mgr->wait_event_mgr,
+							 queue_key, 0, 0, 0);
+
 		xa_unlock_irqrestore(xa, flags);
 	} else {
 		me_id = (entry->ring_id & 0x0c) >> 2;
-- 
2.34.1

