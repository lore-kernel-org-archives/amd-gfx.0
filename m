Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490B8CD6E60
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 16:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 205ED1120C3;
	Wed,  3 Jun 2026 16:34:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JsnwOEfC";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26F4D1120C1
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 16:34:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3HxHVBuUpmMCMLITzCWR3pU92FdQEVGog0retbWt9ZPrrblEnevha0eRWDIfd+EDKHQno8Vtewg+7Z8mLPd/h5sOZmBpGjmxmn5rVAoKZ+Utn2XJi8FIIWnj61NLnQwiInirbcjz1mvE4wuZiJ2Cn5WWydaRGrNhNaZBt/XHmrEiy1qpx5bYIvrRzBmINDfQLipWOzj5QNblB4hxJ+8IMlqSwZiH6WNeIygVSFt9XGwfk3J96FKfndxSN10t2JwOreaPsjwF/mYq56vrPJyWRXJ6PAE9p8MUvSfExhps8QZ3fvvdig5v37F7Qb4QGMEQ8CGDw3DDP0QWxutgjhqAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eR8U1FGxLGWv02OHPxxblo7GpTItR+JJydbZPCYcLBI=;
 b=fLOpEAKLIknGJSPnbgYoNUTjNx29XxIFOzWs0LLqBPTWKE2xfKUJVjQxJpG9odfC4hGNZJKILc6uLuxEEZnZN6qvwv+Io1W/661D54bh57ck9qO2RcDlCq7Os7CmloUo8eps25FlpAsQLHYpPFNfGgABiP787SM0wQ9114kvkKGHI+2zElkl96XmXS1qIcS4lPER2n6yYqLvgAlWZhqRCLzE/lOYW9QnrSx12WNOm9mST+O6p4nb233pLb0deJq1zw9KblBlWvhS0EuXx5qVzjhooDxFuf44+zbz/Q/zWQEaJ4OV88pf21LBlrJFuF2pY7QLh4llW+GkdbUICJSMJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eR8U1FGxLGWv02OHPxxblo7GpTItR+JJydbZPCYcLBI=;
 b=JsnwOEfCK0T2yLHtbIlEaJ584YQei9KSM+sajWA7rTT5JJF66YkPVyquY3RktIGTo+S195rUtNUOn5pvnM1OaHu3TMyb3aBVP6Zg4D2pzOD14hmm3ykuEKz4x3DuqRC/Td6jK9AmK0AJByRV+ID19SCTTgOSelZlhnsyBClAfcs=
Received: from BL1PR13CA0350.namprd13.prod.outlook.com (2603:10b6:208:2c6::25)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Wed, 3 Jun 2026
 16:34:13 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2c6:cafe::8b) by BL1PR13CA0350.outlook.office365.com
 (2603:10b6:208:2c6::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:34:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 16:34:13 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 11:34:11 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v9 03/11] drm/amdgpu: Wire userq manager to fpriv eventfd
 manager
Date: Wed, 3 Jun 2026 22:03:42 +0530
Message-ID: <20260603163350.2678309-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603163350.2678309-1-srinivasan.shanmugam@amd.com>
References: <20260603163350.2678309-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|DM6PR12MB4236:EE_
X-MS-Office365-Filtering-Correlation-Id: 035a70af-e047-471f-2800-08dec18df283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: YK1VlrqIR5HB+Q9pNc+inK7D/Z3tT8sCpgIR6w+tYjWcOLCI9dOkkr0Ec03mm8wPueSp1v/TQh9LrYrXOklwetQN6caQhNDyEnf6+WUfi/uQeHFlcddh4UO1+O+HhC2iZyHj5qHzwW/zNB2VrACs8L4+zBUdZuLsQWnlU5C3cnv6YZlR2zxwk5gE8K1+Pnf+ZLmookFK2rINPCHc47044L0JBuDBoD6CLOum2WchgaAL+7LA0X2Q2PtT5IvY9VrzmPe0rvw0M5wfs8gAe6iognormrRvEsWHBzeKQGQLGDJ5LWMJaGeAldLps0ZNe/x3JcUK5Eutl0YZTYJijAb8L1zYmk5IFozViKOqxs7PVoOJJxYsdlOXDfS2jno/XKr5VbrRX7BLAGWrpCsXCqEeZoUSeyilPkJJVLZNbWDbD0k/yFCiqQ+IzkQGXhfGsI0MjhjlCDD1fwAHqx1zyHpz2CZXzF8+xGzSbdK35THXXAElky71j4DaAcdIIvWMaXgctqpYa9GH3hbWplv8kmdWE6emFVXNGJYloXeTFFNvEalJfNMUj8HemoTROAs8od6jCHup9mxAUSEV+CkYNDpLu8P+dp89AK7ikfhlYN75hgpdAbQp2iPaDalK7vLCnVjdaceiynizmTQsF9HA2bIaSDffWdg1xh6WNc4f4TKePbXC4KkTbon56vRwYcvHtWeyiRoRhR45LcEyAY7nM/uLR8XDxEToNnKyXwjaR3bAhXc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Wazc9VXfUT2JEu2Qv/9YrCSGWfiN67glqot3tziIkdHGo1Fye01qOIaN9m/p9GkBCx2YAMThXv8I2gIrKGBDw8ILE8Tks2I9r1fnccKDow0o98fIr35vwIqHqyOZq5gQjRuztuIk21WNpeTqfn2p9/v1Ah1udNpF9Yhum+37B6rtREh58RXfa/QZUuP0Lrdn7IJE226McLEy9wT5itCnrbuaemm4gKtuzfZ9hoTNCthasK7SIRHQ+DXcA89KYJsSEwOvUh3mlo74ZWHO2r2TDnmqf/jolItOfgnWVz1gVovix+jUJfPKuHoaTQY2eFanW/JyIiOZ2KkyV8KJQftRiqF+LMeS4QN+rI/HH+SX/C7hbfBVG9OXnv1eqryU5RJuejlN8uwmMYIUU19ALK3g6hDVCglRnh4ThY0asRSUB1yyz7+I07x094ufh/lwwMnD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:34:13.5943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 035a70af-e047-471f-2800-08dec18df283
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236
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
index 99c711ddf71e..93e9cef9856e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1168,10 +1168,13 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr)
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
 	INIT_WORK(&userq_mgr->reset_work, amdgpu_userq_mgr_reset_work);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index d1751febaefe..baafa066097e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -127,6 +127,7 @@ struct amdgpu_userq_mgr {
 	struct amdgpu_device		*adev;
 	struct delayed_work		resume_work;
 	struct drm_file			*file;
+	struct amdgpu_eventfd_mgr       *eventfd_mgr;
 
 	/**
 	 * @reset_work:
-- 
2.34.1

