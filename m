Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3F2C88E64
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 13:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1893310EDF5;
	Mon, 14 Sep 2026 13:07:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iSA2w1Kr";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80B7010EDBB
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 13:07:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQUEzfQdf1GJDexU9LL055JkXNKDULQ7Wgpw42+b/E6KSMmCyyfhIIllXeSEXuS0ro4R025qtgc7Y+vpPfmZWJMRBi60SBYh1S7d0GdgHrkxtsoq5PO1itaUjFLe4g5xbaZLPSi/ley8BOYoqYSQ0zCRlW+JnK5DV1pH3CzVgzIcf2Qb7+jWyU+QJnoY7mTh9c/b4ZGyHkpOoCTvCKnPrgYIQkxMtMEr1nMKxvW5H9j8FjSOBCgTyIkiABEPFt0IlzJQsoGIL8UmHFkBXdVTgYQ0ao/CJhMlriaFbB9Ej7e6cOIX4pQNrIQgl1DfnRq6LDbGG+XFCvrb8xhbdXp1RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTLzS58KjaSWV+ddtx07426NMQ+8eY581FqCPreZxZg=;
 b=wJPrzdhhR4CCav8DTXA0RIKtYucyaHyvhdZQsAvdWMOrxS713ywx8XWbxqfAnOWWufj10ytPd1Cc3/atWuBILR7wSpKE7VRh8xeABvr/CUyA/nGOHp1NboaY00O/PZpR0wcMtuAVOJhHHWejzdCL0hQTzrLWFiYDBw4rb55wFJDCJe2qXCSnT+syeyFrbM/iuSrKU6tpi9Do5ZBDsgkyn5+jL8F8w6RUznCoSfeRn2XlXV2/pOpHdW2UwIMuAgxSinfuiZ/Rw4agGBuSxivXlwgx6YMCfRFukYajvw3YDKJR2ZlGfDITKYPIAa8+csqB+iBLAasjWZ7KYAaix3LHdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTLzS58KjaSWV+ddtx07426NMQ+8eY581FqCPreZxZg=;
 b=iSA2w1KrZVKuVDu+D/liiLUW/E7fK6qYpY8+z+SVziJckUQ/61NgNKqhUXkFnXLZLcjfxxUg7QMevfwBkw0LTKsiz75IvH+xehhavKeaQ88Ky21ZMG3BlNMl8nh9mhlmcS8pJ+iSMq5tHETHbaI9hKFYIdQSAQ8mo7dI0F1wEzY=
Received: from BL1PR13CA0091.namprd13.prod.outlook.com (2603:10b6:208:2b9::6)
 by SJ2PR12MB7823.namprd12.prod.outlook.com (2603:10b6:a03:4c9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 13:07:14 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:208:2b9:cafe::67) by BL1PR13CA0091.outlook.office365.com
 (2603:10b6:208:2b9::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Mon, 14
 Sep 2026 13:07:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 13:07:13 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 08:07:11 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH RESEND 06/10] drm/amdgpu: hold userq kref in MES reset
Date: Mon, 14 Sep 2026 21:07:20 +0800
Message-ID: <20260914130724.130794-7-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914130724.130794-1-lingshan.zhu@amd.com>
References: <20260914130724.130794-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|SJ2PR12MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d35a74-00ae-43b6-2926-08df126117f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: KWCNUyNwYRJrOAyD9wQJGJbUMoQX50I2RKDUf0eVnYm+644oOtpTwYsml/pAT7cKtI5Gt/9F6V8fjBIxeyr83VCUathUdVYi0rLVa1ilX7EA0Ncn+DYcM/eKWvVVw+u+y4I3vK55E+HN12H3645eYe/+Av2tKy9MCPwTWcH63MGFSCI0keDzW8ESuLbr8HBdI9Lrkx3wwmQ8oHw+T9DF2rhRog0ErHfs1pCGqhAAoCUMgiuabEJJzZ2hNr1H5MHCxJn0nPiFPPOrhU+5yP/kfWpw3nr09vb28LL80HUBDj8kSgIyyHAlBDr6ydr29O0k6ocfxD3bHVzsSMSwcyU/mihI8tMYaQ5DCNqAe+o1tUGWejfqaiajCajnboGCcMoDiTOHwREswCAhHZN1BwrRq/85HFGlUIVJkV2wWE9J2+G2NAud+2ikG28qBTHkZWBHs6Mfe5SvIRvwFzAPLmUTVrVG6CRDDav9pkwbCbfCYw/11MRNYx3cEzey/nlBsYHfBbGJa9W3u0TFBUyFMnBrA8MGSomRkQXVr0ebuY+UFxZmBe3vbPZk6hDyLiWWjAoFYbI3UIZjVh2Zu23LdaViCbnBWNrS1gsZ3fHlx+ZUReOX2LT+BvI/NNAzmHDTKTWWvLXQzDEQTl8XLcBKV5cakm3BhLoP7e4fzzd/rbl+Gm3AsS1NqtI1cO2Hz+34i+YEhNc3Az3EX5bk9HPqg9MdVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IpRdgHADO6qaHTqPvEJ3Lldp+RmfPtDKh+8KqQeFhX+dVDb4cyaIqwa6JomDqWg7aw1fFzrHElhhtbsWuhL1JrWlJ+/krbAJecAkYRxu+Rw3FV+hVFiHGEzT+bUWF0DXHCrDGrTp5VxPAf/aYB+EKgrwg3agnS0KZyoliKoBOPXSq+QDZJmU1R1ePECOWB9GB5hv5SwFd4TV7rPH7HXIsAggBD30L4MrTg3xuoydVp9W6w3JjthIGVb+WSosMmaVp4BY874D6Sn0Hs+rn6+aUw3fJAVKSJ5MjDpjULKW63Fy3nSqSN71fRf9B7ZtRIkQPucjKIqkzxP2bd8NK/D4Q71LoHprPPnqPQSf1KgMBp4DWjtu5Km3km5X8Wz2NglFNPw7Z0sIpGG3nsz1VqtM1QaDWrRUiRzKQRp2BMUCc2HCacOdX/JKIegPw0SWGsWl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 13:07:13.2261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d35a74-00ae-43b6-2926-08df126117f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7823
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

Current mes_userq_reset_queue() walks the
user queue doorbell xarray without holding its
spin lock and does not take a queue->kref when
if finds a queue. So the queue could be
unexpectedly deconstructed and casuing an
use-after-free problem.

This commit fixes this problem by using
the helper amdgpu_lookup_queue_by_doorbell()
to properly acquire the spin lock of the xarray,
and hold its kref during processing the queue.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 46 +++++++++++-----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 7f334f718cd8..3de71615cde0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -244,30 +244,30 @@ int mes_userq_reset_queue(struct amdgpu_device *adev,
 {
 	struct amdgpu_usermode_queue *uq;
 	bool use_mmio = adev->gfx.mec.use_mmio_for_reset;
-	unsigned long uq_id;
-	int r;
+	int r = 0;
 
-	xa_for_each(&adev->userq_doorbell_xa, uq_id, uq) {
-		if (uq->queue_type == queue_type) {
-			if (uq == guilty_uq)
-				continue;
-			if (uq->doorbell_index == db) {
-				uq->state = AMDGPU_USERQ_STATE_HUNG;
-				if (use_mmio)
-					r = amdgpu_mes_reset_queue_mmio(adev, queue_type, 0, 1, pipe, queue, 0);
-				else
-					r = amdgpu_mes_reset_user_queue(adev, queue_type, db, 0);
-				if (r)
-					return r;
-				r = mes_userq_unmap(uq);
-				if (r)
-					return r;
-				amdgpu_userq_fence_driver_force_completion(uq);
-				break;
-			}
-		}
-	}
-	return 0;
+	uq = amdgpu_lookup_queue_by_doorbell(&adev->userq_doorbell_xa, db);
+	if (!uq)
+		return 0;
+
+	if (uq == guilty_uq || uq->queue_type != queue_type)
+		goto put_queue;
+
+	uq->state = AMDGPU_USERQ_STATE_HUNG;
+	if (use_mmio)
+		r = amdgpu_mes_reset_queue_mmio(adev, queue_type, 0, 1, pipe, queue, 0);
+	else
+		r = amdgpu_mes_reset_user_queue(adev, queue_type, db, 0);
+	if (r)
+		goto put_queue;
+
+	r = mes_userq_unmap(uq);
+	if (!r)
+		amdgpu_userq_fence_driver_force_completion(uq);
+
+put_queue:
+	amdgpu_userq_put(uq);
+	return r;
 }
 
 static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
-- 
2.53.0

