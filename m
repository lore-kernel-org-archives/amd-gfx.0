Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA55CD98D5
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 14:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 797D310EF5E;
	Thu, 11 Jun 2026 14:34:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bEJCs/Q3";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCE6E10EF5E
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 14:34:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYmJM4mYFdBdXewntzTrfrKhBc1FeCOtbfeBFQfMZKd4hviC6MIq25IxPD9UPyOp5a+mbKMuneQaXl+NlXlWpdRxRGR7gZklUydaOo4lel4fi0XC80hWnDuXGwyvWsHoSKXtvbMqsggT6lzfD82GBhXd20pGXJhnkIROOLevQhPyqGjUMRWlxPgE/ZatObG6Q7SHAGaljBwqWWv0SNyL0+u5A5hq3iVS7iskzxSYxcg85iySfChU+wLYf/SOcgDsMcKKbxXnjHyLEeidQEWz5kWMlcKsYEt1AYEiH3MBz7RCwnPGMUENUempQVId2TBqxcg+VfOW00wi8P3aViNSBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Of2K3kWYj148MtowuCjxuCdGs03fHUmhja6pEH+uwQ0=;
 b=sVPZNO2M4s23L5UCVIKumcoh4p6b1nsaXoVRbtNpjqgZkxLBMa1Sep6E/9Lura8sa0Rm+SrbnX0yCug8n0LDfDvuTZGuT7nvonUGMIEkrWyn9+E9hDM0bSYDVJritUbItUwnbEj4jvTy3afCvmlfC8a7msa4lvETYKODrZVRl0oQDczeMHxLsaaUhK3qMBipVYCoxEeDmpf93mqTXVUUJ/sXeVdIi24PjtbGyt1UKvLD7E6wmYIkFUxMxD1/L2oPhrK1n3uNMLeDJLq69Hawb62YN0ixqS7X4NBVc+so2I1BnMavULh1PGFkLTOcTFgSHpFVQzw4RQUQ1rxom16gfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Of2K3kWYj148MtowuCjxuCdGs03fHUmhja6pEH+uwQ0=;
 b=bEJCs/Q3Tm1va1pDzzPpG9/uakzqeRyQrB0QKttuTryJl3DWHK6gpEkw/lbCfXFMkWHCWdDqSRM/0/DYRmXKOFF99KkrTW5kZvqXdrxfxGcUd8qeSHXcVvt2Muoa8TdpXjiKENFf7LRQ1lxZxVMVKyC6UojQWi+30wJTiJuWouA=
Received: from SJ0PR05CA0034.namprd05.prod.outlook.com (2603:10b6:a03:33f::9)
 by DS7PR12MB9044.namprd12.prod.outlook.com (2603:10b6:8:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 14:34:12 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::2f) by SJ0PR05CA0034.outlook.office365.com
 (2603:10b6:a03:33f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Thu,
 11 Jun 2026 14:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 14:34:11 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 11 Jun 2026 09:33:56 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v12 3/5] drm/amdgpu: Add helper to access the fpriv eventfd
 manager
Date: Thu, 11 Jun 2026 20:03:24 +0530
Message-ID: <20260611143326.2870571-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611143326.2870571-1-srinivasan.shanmugam@amd.com>
References: <20260611143326.2870571-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|DS7PR12MB9044:EE_
X-MS-Office365-Filtering-Correlation-Id: 18adbd2d-0236-4908-347f-08dec7c68157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uGsv0ynXOnKTJkbSzDqTWZAq9QP3CjlfJ7RHm4B4kN+eCb0GUD+Hgw/+zl6Ed7tvEf8XgFTCj/ipjfSKmv6HR4gfyY8G2KbqAu58i1qX6PytldnlQEJt68+zPd3RM/bUIrOdMXhtyhJP9BpNCSbQ0TffdnAKzs0wIObEKmrCq0Gm9/oa1cuNooZ6SDp10jwMkz8xOyx9a+/zP1Yh+fpCBu4jgvw/MHrLVmSIRol8KCE+faiCKqJA9jbEwY6upj6eA+ItzYyZKcIocHkQJ6/INcnVuo4I+OaOfDGV5NoT3KNQMo+mi2Bjia2/U3V4n7hshj11gQw9lrXUIHQPadStRLJ/AKpietIqjRobSsBC7aPaUlrfW04dRyE/f8SYUTq0txeFWwtWbnrG0LwiEUC1r6JKFwl1OR6rbkIqtezugl9Tou/qjzuRhEeZybprWB25ue4BpR7VoWtXhlk0+6jUmGgolcinJ7/dzuUu6fRcBm/CbD1ljrab0gDIb34SpgFrTSJ2FQXkWigpSPTtNUP1KagH1okCb/UI1P1YtMYjh9flF2HIzUknROQ+q1CZivkff31FKYLOLzHy+4uQ1Q5oK6WbKpqhYZA5PwXY2v/WtkY98gt6btIvX6UJpz8iS9f4UAUmzx/ky+/U4crmPXZuI+VF/hMseaJ54OvneGoaD31d99ZYStX81FbgqnkOusvpIWCRwME5b3K1+im6GH6OpwNk+DYRY+2dqhsE0PAmAA4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lgkw8YUhIk2xT7oQvsMa93S9OiwPuPMi8Hq2NvNXJlH3TVN8AI8BpnjrpE9v+6AoppK9mE/yC+3eGQ3MyPZe8TkA6SHLfHTaV2LePMwsoN5ORhlzCMtb5DGVpJggUTJhuRnWpSqTr07gtZExc0Oz1Zq62qwStGcVbfydqldpSeLE5LGGefOsHUa8rAGU2ZTbm3NPM1UxLa9XCcr4R3H2KOJI31W5rQh5yzJs5VWaQ9RZFoP09jQu9WzaaOiIBYERkQ/PjbG7wCydOdI3UCHDoHLK80CfKo2smNaZ3F0+mJsgwCYMKpOsMxFzxql3YLYlxO5hzdi4FYXY2MpYl3qV8tDTTNVz0dTbkoeLoorqgrj85S4tnG5NmlomzJarLcvVZYfSSpKcwx2t9fHTrLzn5p+4O2uamHJQavOOwXB+VP3VJ8EO0dkNsOiqIZYSAb4Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 14:34:11.9501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18adbd2d-0236-4908-347f-08dec7c68157
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9044
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

Provide a helper to retrieve the per-file eventfd manager associated
with a user queue manager.

The helper resolves the eventfd manager through the existing drm_file ->
driver_priv link instead of storing an additional eventfd manager
pointer inside amdgpu_userq_mgr.

This keeps the ownership model unchanged and avoids maintaining
duplicate references between USERQ and EVENTFD state.

v10: (per Christian)
- Remove the extra eventfd_mgr pointer from userq_mgr.
- Use the existing drm_file link to access the eventfd manager when
  needed.

v11:
- Replace defensive NULL checks with WARN_ON() for conditions that
  should never occur. (Christian)

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 99c711ddf71e..427c09c83d6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -34,6 +34,25 @@
 #include "amdgpu_hmm.h"
 #include "amdgpu_userq_fence.h"
 
+/*
+ * Get the per-file eventfd manager associated with this userq manager.
+ */
+struct amdgpu_eventfd_mgr *
+amdgpu_userq_eventfd_mgr(struct amdgpu_userq_mgr *userq_mgr)
+{
+	struct amdgpu_fpriv *fpriv;
+
+	if (WARN_ON(!userq_mgr || !userq_mgr->file))
+		return NULL;
+
+	fpriv = userq_mgr->file->driver_priv;
+
+	if (WARN_ON(!fpriv))
+		return NULL;
+
+	return &fpriv->eventfd_mgr;
+}
+
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 {
 	int i;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index d1751febaefe..8c4b55517a0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -183,4 +183,6 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 
 void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
 					struct amdgpu_bo_va_mapping *mapping);
+struct amdgpu_eventfd_mgr *
+amdgpu_userq_eventfd_mgr(struct amdgpu_userq_mgr *userq_mgr);
 #endif
-- 
2.34.1

