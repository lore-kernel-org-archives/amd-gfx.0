Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEBEF433DD
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 03:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EAE010E7D7;
	Thu, 16 Apr 2026 03:27:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uTuIwd1q";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011026.outbound.protection.outlook.com
 [40.93.194.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78F0510E7D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 03:27:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhH1d90xpu9hzAF7QUx3AZe5WQoS+HUDUba7ECZOvEWElNZfE32mSD0EAg/tzijeYW7TcsJyOY9rpxMtM5Q86aIF+pozXhSXIMeEJRbQCU2DHuoO27m8HvYr6L1ftjkqJsQUYjjNLRkkfOO9MzN3ROBSYP22+IsZRCoIKoSUQi20844ubNy8TEec/cRX5cJFUPPor95uAmsjUgg50scobgaaYKzkwlWZiodfKvQ67BITRCrkqVd2dnzND+AukbyQIXU0WY5cbnVXU9tkFUGImU0F5wwbkOZlyp1UIurY1Zi1yfHy9zTirOlcceyB7pHHW1QhgEI50O1yJ9DBI+Unzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSGCyc+KXFSjLYaBuDYUWt4nZ0wP1OKw8hEtaYsm0KE=;
 b=sqy5f92Q+PMHF5b5waip8NRZYtX0fZMDjqDtivXmlnjUexSunMtCFjWd8DaKFhLOSwUN3CTXXwo53Cn7nxf6vBi92La8Rb/8FrqCoORXly4FUXdYIXlnAI9k7pT9A3Y8uUm1blMzrsf9wivZk04dIOdq+zUeC3Y7KjGHH3TpvLALp35ZsUZMCNTvDHOXdx0V99TRJN+09HNWMu59hfJBmxqjIQzqXJG2+hzNCBuL2OjWzFTWDyKLQPW1/OIFB9NrbQgcrH5eIbg+yWUAE148dHHsbJLpfN9l4NZuCAo5Rwfq2RYLXTx6dxHVauGA0Ge2ZMZS7Q5pdULJZfM3IHUYKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSGCyc+KXFSjLYaBuDYUWt4nZ0wP1OKw8hEtaYsm0KE=;
 b=uTuIwd1qFFfoSY/dMGo8iHWBefy+QM9XOPQh7/NZXyzTlj8DqEXvIrKNr/l1yi4rE7t+Llry0iLhe1DP/D0IyOenSMFf+ZSML6eTaJBaxpLAaNdfWRyaHnHwEy3tjrzpp45vs3B7FrzA/7JjNer7ROmafmm8nPmp1xcU66Phs24=
Received: from DM6PR06CA0088.namprd06.prod.outlook.com (2603:10b6:5:336::21)
 by BL3PR12MB6426.namprd12.prod.outlook.com (2603:10b6:208:3b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 03:27:25 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:336:cafe::3f) by DM6PR06CA0088.outlook.office365.com
 (2603:10b6:5:336::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Thu,
 16 Apr 2026 03:27:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 03:27:25 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 22:27:23 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v7 03/10] drm/amdgpu: Wire userq manager to fpriv eventfd
 manager
Date: Thu, 16 Apr 2026 08:56:52 +0530
Message-ID: <20260416032659.2368054-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416032659.2368054-1-srinivasan.shanmugam@amd.com>
References: <20260416032659.2368054-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|BL3PR12MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: 8031b61d-7b3b-4d58-4723-08de9b681462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: J4+eGrIyUUmjGISuaPXEdZ1MS4FRltWRLL96G25XpKJhWRghZW1RkAXuZxfzSqasWGedDBSxPMtSTt+BX/TWzfelKs/4HkyB74rWCCPKL/DvTc5Iw6dC1TjBt8rrGUO+z2ffY4XFZb1yJWAonjPtcB0cPJZU6RsHasXeqPm+n8NY+c+R0CpvtvXvXQL2jHVQP/zC6mMGtvSgELBpBEFUTrbPTA1Q3jzKzOZeyXJUhZscjsl6D/kW6M0F8kfVm74uGKaa1vFY5ps5K67+5X+cq5o0QpM3rTYw+RqjKEGtIsKiosVM/tOFEe1mPSOYtRgUUhWio0eSev3E82sk9DIRSgwmOJajIQyUZF6sBoBoxUgpxaaY1G5pQgVbuGLRpKsY6bNP4iM2V4UXF8530S6+2wQqeWvIb9q9HohgrSR4vtrkZASGZLCIES1VmV5yC1diPh5XJSemBTvIUm+4mRw6HqyTv5WNnpZ+J4EW02Z69yfSHWJXJD2bveLthaDhJ92VdIZanuATBS0ZiJqyEmRYqEIIlCR3J830pEdLjUJjSWG/SxlhlBYiVUsJFfNdzQZb1DKx7epSRzGP1kSMMU0xovg5DNBK2QjYj3QDjixAbDUmuiCROE4OVZnkn28y3+J7hsYpcsc39YCR4THipNb5sBxlzNTPx64NMzVQIZgrTGxLSDz4UA6tTpeACcz8JzDct9G6yWUYT7Spua9FHwMJW5XKJxRm40i9TlUy5xDpQRduQSptnItMRJyOnLEDwfvxq3/FEIK6T6cCaYwBXmKS+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A6/fBxNx6+6ljTLYeY0qLsvnPXXZXZ7Nvzl4Nx/UhOTs0YFbf9vYiiYVU+OnSWwfm1iuH0ezEMnP/YUrsffrADxZXezb2nI7ZP5VxKHMFQ9xfJveOQCXvEIw44oKZVdnX9BsSRnYQdIMFMattzsFWKu1Zz7lIshVicu6TbscFvGPuHzX7UReDe7nNOBsEe1UvLCN7MyjqP+gZwDMuUUSW+oiPi3ADArGFMCTOqElcPJ8UGK0tK1hLcs6lJaOQJFQqo/gdfog3E3j7ZgfaS/u9WwV1/uAOGXEufqFiylv+egothl0GTGvDxeVEq/TjsfX47ivJc1bId2Ffcv+YxvL+lJMRiPXP1jxhp7Mu6e5PUTOtjyzcBqC0VxPZFvJmihdNkj/+zKjV7KjDs4gJGmNNwWKS9IAU3riSYB6Qvn8mrg7ety4rBdAOizZTRaUBT9T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 03:27:25.3701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8031b61d-7b3b-4d58-4723-08de9b681462
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6426
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

Store a direct pointer from amdgpu_userq_mgr to the per-file eventfd
manager embedded in amdgpu_fpriv.

This lets IRQ-side paths signal the correct render-node eventfd manager
directly, without walking back through drm_file -> driver_priv.

The pointer is optional and may be NULL until the manager is initialized.

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 8f48520cb822..00e9a265c9a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1312,10 +1312,13 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr)
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
 			  struct amdgpu_device *adev)
 {
+	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
+
 	mutex_init(&userq_mgr->userq_mutex);
 	xa_init_flags(&userq_mgr->userq_xa, XA_FLAGS_ALLOC);
 	userq_mgr->adev = adev;
 	userq_mgr->file = file_priv;
+	userq_mgr->eventfd_mgr = fpriv ? &fpriv->eventfd_mgr : NULL;
 
 	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 675fe6395ac8..8ce039eec2b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -105,6 +105,7 @@ struct amdgpu_userq_mgr {
 	struct amdgpu_device		*adev;
 	struct delayed_work		resume_work;
 	struct drm_file			*file;
+	struct amdgpu_eventfd_mgr	*eventfd_mgr;
 	atomic_t                        userq_count[AMDGPU_RING_TYPE_MAX];
 };
 
-- 
2.34.1

