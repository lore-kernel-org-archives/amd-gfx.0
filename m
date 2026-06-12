Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BAACD8CA8
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 05:53:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DA4710E932;
	Fri, 12 Jun 2026 05:53:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i5hutBfY";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F038C10E5A8
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 05:53:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOESjM1aqSdHhgmTlxHMishzre89xsl5LWlK1Z++v0QMMXz8BPUWRtEOA78j+xQgU3CDwS5NCs378UYodtqPgaOjslK27pS3wny5pr1iTYDyqAwpZecuCzTi7i5IWYH6nkzon0AZZ2jjo8pq8j7zlHCaBYaUO7lbra4XiTmgRcOBlGgsZdWjSBFEm03yNTU6VgT4GISUIDlOXLjPNOHEH+AoeqvZnBAbQvoQOZNCO/eNTkfmsIV4gwMm9iKhYRNaC2u7Y0FrdQJ5joep3YphiLmXReuSSKIkMjz5hdyK9OG3YkbCw4xYVEFG4fiEy8L31E3pIWLhWgvBMGZ1vnno3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLFQ0J3Ucmos8eEWb+NT25uj8Ur2I8HuJpAcQy7y4Dg=;
 b=nK3HPbMw5Xx0W151zxJztx1m+IHX8uTqQ25SwQh44+KUszy1KLxVVf0RoQUYLGyi67A446rErbMXQ1vRJKx3IGPGHLJiGe7Sb7aTpBeuDpPo2DIz/tNNNHtkImYBwkqRDReGBbLHAeh+/tYS+72ZIbJnODtd2S8p2ehxDkqPZ8a0Df2yxhV+65HEPrS9i6cfwUuNHfkrU9uMKEpUQJjV0zHgUa0sCCgX62+rEAqT5p7NSmlzHrT4VA7tavKHJHWliQR+xBuuZbj8/ksb7tRwIoK9Kpxb1i7sdN41oTmH/nER7T/GyhkzfmmmRacllfaxWNs59t1cR+P6SvzmD/pByw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLFQ0J3Ucmos8eEWb+NT25uj8Ur2I8HuJpAcQy7y4Dg=;
 b=i5hutBfY4lctFNksdwPgwHug0ra/RC8/Rz1nqfBsgWHjujOreGvpM5fxR/XK5tqvhEe3CeJWtK5rbNMuCOm2EEVbek/+9a3oIli/apbjbseilfeo9K+/2mA5+TxJEGa5KjlzuuSHA26yfYBeZ+YuOMtMlOY2rXJfmdJ7SlGvMpQ=
Received: from BY3PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:39a::6)
 by CH3PR12MB7521.namprd12.prod.outlook.com (2603:10b6:610:143::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 05:53:03 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:a03:39a:cafe::5c) by BY3PR03CA0001.outlook.office365.com
 (2603:10b6:a03:39a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 05:53:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.1 via Frontend Transport; Fri, 12 Jun 2026 05:53:02 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 12 Jun 2026 00:52:58 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: Signal SCRATCH EVENTFD notifications
Date: Fri, 12 Jun 2026 11:22:24 +0530
Message-ID: <20260612055226.2879270-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612055226.2879270-1-srinivasan.shanmugam@amd.com>
References: <20260612055226.2879270-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|CH3PR12MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: c2096bb8-d5e2-4e4e-3b8e-08dec846ddf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IJIQ9FiOf9MftewhjbS81vSmf20o7nz2T64qMoHQL2RZr4XkRxxD2M2ZzfsyZ1LLONG7H36mvbNlPsIRzhU9fA7AyBlK1NPgCzSf3fwz5C8ImmEYtidLPat/OagsgbHnV8rLYZ0+E30NtMi2rnyicH4g5azUbqTFFU8Nmp4zl5zvq48qeXYRQbnVPRC2XjtjAxa1zENj0vvBeolMHWrK6ImkuJUrDNMSPmV8OKsMeduVCtkJNa0wDX5j7NVjYtetm8c9e07f6hfLggbduyPT8n5pS5hGn8yShqYrFs+9oeDDq4i9To5X+T8EHCO8zwyX9Gs2HzerKdBqfLMn7tOAtGk+Y4KGAWzK/YwnEIbOSwWOWiF9ylz+x6iSHWedeemXosUwfk81a+6PPQH3Xx0g0FDQKOPKJCqWZo6pBnqv+s1IFd7jKTKoLkXlZUEnvmmqOd1c++5NPwn+F2c2wRCR9nVAjqVsmYFe3wfWqe7rOVnGg4Sc/DO5dTdBHR4Vc58MEmOSDfcnnpHzBXGXnQg5dpU5clJwbzJg7SkWkeZrR91F1wJaxd79JZscqdafLxlkmHGZX0tkfRRgQf7pr2OaMNPnCd06FSrzE+xdWjzbqO3SR1W8eelT1Xiy8j0/kNM7JSHPNt08bCvRbmViRUUgBrTM8/Ru/SvKBiHuUMLYZwtMq7dy3WwQ0bhbveCDgrH1LL5g2kF9j+YmYjtsKu+45BvHBHW0ORtyT6I6KIjVPnY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ImMr2kmEL/Rnbt59nh3ifOpZSn3pRJBSwVxCMu/YcOIiDJY0BnUfZ3sQiULsQ9R1EiWAoOOtEtX9yZSECLnmBN/8UceF2tGWogDVpCi17J/UratO3JY8IIDdXr1Ujb21v43ax5vas8Qwx7IC+NO4usIyHAA+dXFqyHIRq4ZCbDAhLa3cbbIamP5mRHGhRQh3gb1MEUKhieVDJSsHt4HYMLn+lromaj7+clERbuI7NMsUdeBbGN33XVpYTsGSqV9VAL5IPfHpFiVGzHYiTyBqI0JKRQiz6iEfLmLEaWU4fpJV5sLbO1dGWSIVLzdxAciL2XhRChhrHh9x2Ujr02EQq3cik9YxwVorYUXdFhDEC/a7vai95UJPVJZHB93wgfd4gZKhPFOBODeTEir1Ag6ZFIpw0jUfqUxzdJFYrOc+jUAStb6U3UBF8r7QkYAgeUsL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 05:53:02.9582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2096bb8-d5e2-4e4e-3b8e-08dec846ddf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7521
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

Signal SCRATCH EVENTFD subscriptions when user queue restore detects
missing VA mappings.

The restore path already identifies the affected user queue. Use that
queue object to wake up the matching EVENTFD subscribers.

SCRATCH is queue-scoped, so the queue object is used for signaling.

EVENTFD remains notification-only.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index b77385e35e4e..7f605501c84c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -896,7 +896,6 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 	unsigned long queue_id;
 	int ret = 0, r;
 
-
 	if (amdgpu_bo_reserve(vm->root.bo, false))
 		return false;
 
@@ -905,9 +904,17 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
 
 		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
+			struct amdgpu_eventfd_mgr *eventfd_mgr;
+
 			drm_file_err(uq_mgr->file,
 				     "trying restore queue without va mapping\n");
 			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
+
+			eventfd_mgr = amdgpu_userq_eventfd_mgr(queue->userq_mgr);
+			amdgpu_eventfd_signal(eventfd_mgr,
+					      DRM_AMDGPU_EVENT_TYPE_SCRATCH,
+					      queue);
+
 			continue;
 		}
 
-- 
2.34.1

