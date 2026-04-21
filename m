Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA11F94CA0
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 17:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9C1310E915;
	Tue, 21 Apr 2026 17:59:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EMC3ISoq";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012067.outbound.protection.outlook.com [52.101.53.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EE2B10E89F
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 17:59:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWx26TdU+O3ViHWV899rZnn5d9t1NLDe0ozrAmUrSPxXdk3McjKjpamOkzIFWGGUv8Mi9F5OcUQgG0FeYAkjBeW/s3kyJsROSUdEzQO3joYvdUzWCpg1cokGjPO4vuIl+kolHRyWid5RdQ6tIX8uTkEuM0KshPgDTtLxkdSgkxPLEVvGyDrzafy1EA1Xi1aX8l7QsvpU6dDd3vxu9F5vI0Gbx8J7Ki3Y7HtIZOHn/lAN9/8ANbEbRRy3QJi4WcsZnZmUQzU3qgcmhoLCVHZvgSUnfWE+IwiQNqNzRLvixrEy7hd3zM8uhZ/+1g0Kz0/KlJsWR71QW2pQr2JtBIMbqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSGCyc+KXFSjLYaBuDYUWt4nZ0wP1OKw8hEtaYsm0KE=;
 b=BZEtMPXDm5/FYiNzYli8yLjTcioOm1l4j6fRjZCFerBf/A5QdSL6QmblgTeDYpcRKoensUD/1fu/UTMVwaLfcMPjHF/JfbZiED/4T9FD7PSCFD/2vkqao0Z+5LOwiPzxQAHg/Nf2tvxUXD2Vwq9I8PSxZJ6aAfHeo7tHtQaQCjqVF1umtBVJ0gdYe/z4B5GtRhFFuCqItSPlhQuurb7gZ9p3uLLiDXLw/R7ILkh6Ns3VZnKMkjmw8osac/jToo7HmaD5rl0Nd9d6EidskbOfBKGhKcmrosmCOGMI3c+UcFeAcooVL3SbWTxDWK59K14XPa0bXNC1n4xEp2jGLzMTyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSGCyc+KXFSjLYaBuDYUWt4nZ0wP1OKw8hEtaYsm0KE=;
 b=EMC3ISoqisq39wMTPUP80MROVBOYTYKmrUdgv08K8YK8rbr3zymiDMdRcPgcPEhHv3+yU83RIVNbjHU/pb6tds1uzRjLYsTXgw4P0mJIbOPC405fSsR4MshMyJIaWqERTmPYfdG/ZlGAHYeXKkoaS0wWGry4hZUvWfTnuQS905k=
Received: from CH2PR18CA0025.namprd18.prod.outlook.com (2603:10b6:610:4f::35)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 17:59:33 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::9e) by CH2PR18CA0025.outlook.office365.com
 (2603:10b6:610:4f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 17:59:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 21 Apr 2026 17:59:32 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Apr 2026 12:59:28 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v8 03/11] drm/amdgpu: Wire userq manager to fpriv eventfd
 manager
Date: Tue, 21 Apr 2026 23:29:00 +0530
Message-ID: <20260421175908.2402019-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421175908.2402019-1-srinivasan.shanmugam@amd.com>
References: <20260421175908.2402019-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: e36e2b71-2da5-4af2-9c09-08de9fcfbe21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: h+jQ6OPOzEZvt6blwKAMPi86l2kUzu6Gs11iAgj3oWpzhpwQKhfJZSWmnwG+t1LEw2OjL55CXVt7KMVFQrfL6xLWSSJ3Pbe157AlVTXGSdc8BprzP9A1CkJx4EmPtw54xL3uo2yloA/sRPRQ6TZtsHEdMRwybGTkfll5UDXMxko6jM+ABsa6kx0nAe29SgdZyBQpu1ROeoMPHV3rn4ZfhGyNldpn2lNfrQEQJx8beAs7ly9GcltxlIxsRa16ozaBC/RxuRT0qkKK0gEM/AALewX/x1f+aFYsJrd1WCNMnzARwq2/t9zc/GOTzCaec+j0/HWT7img3bH7oJeDacecWzOEquob/6KuC+xbabCq6sjuI+1cUWeRIPpPb9LVcFggzLRBojxDUrWcNYsUXnclqSznW3dBjVkLP4TdwBBB9k4x23xdiccpDM195BuJvEOLrr8IP4/qXl6wVejwKWzInVkydrS4DNN11zsfWQYWR0QPWpBByEbZbi5f0xyACDKZ2PRab/MGDsSJM/Krs5di/Nm0kjVfF/gUiJ0YHE+Vb42GEJ5AW4rbcN0M2QHFZbFy+b45y8vbkRXluk10By00KCpyi6KiScQgCrBKdGbXTg74y6iblWBXQE3r5qGtPjsAmMY6EI39K4iKe0mfupGyZQgDVDNF7E2akPyzb1eLmElF3bvejuKdftt31xfsDFbBmyQ/82TC1ldRldRYLrW4mMtI9oaQld+jCoFGwnFs8E6oIqDRCxcPJqWs6Sb2+uOHCpd9kfNTgD1a3vCBLgvVsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uw2lLQGpEyKf3vQwCh5Khp24Kb1Kh6cxcwjcbkF+Ylrwm71/LDOLSxMpPPFAsL11XHkxdF3lSKsRorOYM8G3mge2dpHjuNx4U/eM1nzw1MGSXSn5fCANdBbrxDMpTH2CWKMZ5J2N31tFQWW8nB3jiqrtW74Fc4j3tM8A/ukfaV5bR4XyVxVn8LfFE9XL9jD5lwZv5sKcK2tBj82jRnW22R2ZhNRLGEB621W0zeC4Q3B7wGYydwy3/k94guQNf3PPy226bzaGnuPqZfGwYf1pw/0Tc62NxoowF/gWDJlv15moj6n7VgZrTip5AZVRE6xAylwyH2hPIPUNDG3Lq6zXgtUMbguVOEaM5SX1TrJfofwRqgqA8y4tYJYX6okKSnCb/PrloHpKTlNANiqKzGdRomi6i0cIjcmMNHjSS6qELs4f8PI0h7IZQhOljh0Zu2Qm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 17:59:32.9307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e36e2b71-2da5-4af2-9c09-08de9fcfbe21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930
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

