Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A427EF94CA3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 18:07:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A9AE10E91E;
	Tue, 21 Apr 2026 18:07:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u4GM30dz";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013069.outbound.protection.outlook.com
 [40.93.201.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10FA610E912
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 18:07:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRUX5muC7AEUslXhBadCVb0zx+NH71I8K3b8vuJsKVqMVoNPEwQwdOCYSSxlHRrVzeTAoYYLI6VBgusLcjy6zyYU4h29uGYORbGa3OdTEVhI9KT4yddxk8M32S+R6MdhAEDycDn5YqXdGRY0T1smbo3jAc0P2Caoy8Kimoj5EaJ/wABhFX3DSztk3PdAFFYAJfvTQ/iTLBq1gZgt824Li6+xEq/DX5lSS5MOvhK/LUV2AkXf7PyUu8Q+XRpW0+0QN0ve3806FX6k2ecMbhZvU5aL1VN8hlOS65lA6KlJ7xQI8l2Pm9UACNKaiVdgEXB6xZNL0v3B5r/KLoDYaqdOEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kz+a48AzwgIMjAqSnFIiXfv+JMQg0g3zvfpaWWouEUU=;
 b=IW8/Fi6I4iMLat9yjjiX9O89SiUwAYYlrZ1sgKHpJhT5iDc9gaWgxYQEBlqrQftzTQhSh2pN4kSJpFNaD1EjzQCASl5NatOmEjS7OFMcOVeDPN7B/KTJKaiEKIpcje16ojsAlgZs8HMDOKFU5nOSZDctOt0rIsqf5cjYS45uaFn8XqnfmXsQ9FeLH7qph1uXCYdlAxQRThSr4zWZ612bIPH21dglXoeEBZ+FeZ/o7MMSbmI06H1xrbpn7g3yRX291kVzGGsjn3zM10CrXaL+RRxmOoXL4GI7gz7yQbcjPt3yZYFaG0gqwr7bLGIHpPeMxL8h5vcnffnkNcyTILyvJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kz+a48AzwgIMjAqSnFIiXfv+JMQg0g3zvfpaWWouEUU=;
 b=u4GM30dzb+zLvRYz6Fl9X/UkidyXeECG//wjh6UM45RgY/TpiVQnkc5osBdIy+DXVVd/3eGBgDGZxTVitUfhmAouhHgNRbmcBqKt2aEqjNlAP1W1XqM3Hu2p2fwQ/nOwuWnXmHdcEUDl/GMOOunYZ8pERBbIR2oU9zA72N4w8SU=
Received: from BN0PR08CA0019.namprd08.prod.outlook.com (2603:10b6:408:142::12)
 by SJ2PR12MB8832.namprd12.prod.outlook.com (2603:10b6:a03:4d0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Tue, 21 Apr
 2026 18:07:45 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:408:142:cafe::43) by BN0PR08CA0019.outlook.office365.com
 (2603:10b6:408:142::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 18:07:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 21 Apr 2026 18:07:44 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Apr 2026 13:06:43 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 04/11] drm/amdgpu/gfx11: Queue USERQ_EOP records for
 WAIT_EVENT
Date: Tue, 21 Apr 2026 23:36:20 +0530
Message-ID: <20260421180627.2402093-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421180627.2402093-1-srinivasan.shanmugam@amd.com>
References: <20260421180627.2402093-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|SJ2PR12MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: f78cdeca-edcb-429b-3d25-08de9fd0e33a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: fM0S9BeNKPXbELVHTWIgf1O7fKJCJxszDpNONgP9em6F54KGvQ/czn7IHFQVXwM1x+LQKqAG84g627J5cntWJ/JZ391mlELjwsLaIkJX4mW2qqMWexAhQWhY7l3sOr/xKtUWiz/a8rhIrDu6zAHq34DQLVIfOOzk4Xud/1BDLNQjODOZnFhskXNirW9ahni/feFJAPyV00oXQNxc4e4WyjZqFPhoyHROp+byG5bN5vhnIOOaNNdA1+nXw4ukvohcz6SHpKsbmXtDIFFE3Sy05zSXjV/yGR8U76q1eqFTPYLccWsAj6nEVPjdpC6OdsizSV07pjHmcykcxJUjXJgXO7cu+yM2B9xb5kVCS2cus42zVWujs2YG00dxR/N9Oa+r9cXhYSq+rjBrST2kCX5CwRBp6FsY6kr/qc15KEIhSbR607XcmBCT1b2x9j91x+ugpQS028y7xWiocJg3Z+dgMZJUwC0wMSZUZrhvLOggtYiRqwjdMHkC5c/yEDSOoTj4/vilU/Wh1xPIaSsu60URJVUeGsVHyjuKjm1reShplI2rQGFRLE/076SJfO9NXz+eTZTI50bq8U2RzDbaMpmE8bA9RFkfJH7OTlBT+RBvmVUUwc6OZ9gfy0rq39AZrmJcw2QHWxMNLtqW1LMef/3PzxqH/hNqZn85YEsOPRGtefPMmzd5WyYE53fYOJMDjzfJdteKnIq248Y2VhB2gvRBh46FL4gfalGXjX1qDOYF8BcPHkb3lsA/MYKcDaXJQRmg1wrwjf4yyIYlhlkdecCCFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6pgSmFSi/exIhncdtMRtjTNDf9+XMU4bMPw/YW+bB00xjjRCjnMzyU52HbcnwkIxTM9eMwQbqCcRpATrp2paTUUMl2EYdTKmMP21OtD4yh82Uh8jYaqpW+yllZW7JI+j+0JJUs75hd8w/KUmaSMJRFti70xCsNZdKeUdg4T5mwUhKpheXNkEidVe8DotiIodOXM0BFKDe0E24dC+6+GPXrpfuA1jQPBW4E4efUeQ28+/x1ehkyWH8Vj92BB9+Okv7aBL4QNXdEn3yasQokvB5SsNaLIOjfmSJ2hDXQozfy3uX848+NoZ36hYQLwDjVkqeBOC5YH9dR5igFBv532ZbZnf74EeERLtBcNB7HWFZpIOYkaKw3ZcqiMWr+W/vNxpyBoVksDQo+Etz4In9PybTyjyG08kXBlYaOFR9dm3VoZYEn9qth90g9YSKBkh76NS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 18:07:44.6993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f78cdeca-edcb-429b-3d25-08de9fd0e33a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8832
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
index 2d140d7ee4eb..f0deb44e9845 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1329,6 +1329,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 	userq_mgr->adev = adev;
 	userq_mgr->file = file_priv;
 	userq_mgr->eventfd_mgr = fpriv ? &fpriv->eventfd_mgr : NULL;
+	userq_mgr->wait_event_mgr = fpriv ? &fpriv->wait_event_mgr : NULL;
 
 	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 3728d932e87b..4c67f86984cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -107,6 +107,7 @@ struct amdgpu_userq_mgr {
 	struct delayed_work		resume_work;
 	struct drm_file			*file;
 	struct amdgpu_eventfd_mgr	*eventfd_mgr;
+	struct amdgpu_wait_event_mgr	*wait_event_mgr;
 	atomic_t                        userq_count[AMDGPU_RING_TYPE_MAX];
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 80379530164b..6472c42226d4 100644
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

