Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A0DC77B7F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 09:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76A0710E355;
	Mon, 23 Jun 2025 09:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p/e4N1Ua";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A93310E355
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 09:52:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5DDg4oQL48B0m9n3/AX5dDwlRO0HcAfUuCz5zWaIpERKWCYpjjofblcftUsWQiBR7ecmm35HBhNYwKy3BZc1Bur4kCJmSmNbwX1By4GNU2DTUVV419op52Uu/e/8z5pEgYtUhyN1g3IcpgTszVuyMrHykN0i39F6XVFUBR4WDxEbjOi6oMfQGtCDtGWCAXTlzNRFDaSIvwyApbsusmx0W0z6o73qWsASSZijwOK32LjDekVTmjx9QMBC9tJC79KwGJk/lozmSgZIvvtdscOPTG8MkbQRFf11DxUGO8neejVWsBC8xtarK7oBEubQCwD4nsTmT41OcytzzlV7BtKxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yxoaCzYAl6ecKNzfxJMcuuEdeGLOmnpgenaJBx03OE=;
 b=e5oXHQKE05Y8d757EkaJix7QpP6cwxkAtApld/FOW2D3FHZsqHgs/FbsIqaYYZ2QbOeM2U2qvAuzDgg6kiX+dsB3gC/cwoiVFVy/PV7+J6FSItkMo0rUUM0RgNkZNV1FYDmeHhKfmB/+2B70sPiGR077Ih9bug5ucH2EqxFk+oJovPF1rDBkXtRIH2Eshq2pr58W9PFVqjOkyHGlASoJg0bDQTHfJ9+LgMjGb5Ss3zZxho/a3JocRg9DEB+n5SJdZhhRuEWOp7xc6tVFoanCkoveM0d3cSf7NU4U5W+ZkrR1QIhlxhLCfWiKX8OSsjPJVUYLjMRH9tSjOSWCzp50pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yxoaCzYAl6ecKNzfxJMcuuEdeGLOmnpgenaJBx03OE=;
 b=p/e4N1Ua8VbsfpgDmBfJxECRoQCKqgIZV6hf8sLlNB/urKV7EgDbPvybFZMZCupl+RwJosv5NPYbV10Tw33gEE4kCBRY3OXd7uyi3TJ432BOoPTHIVXwAukKTeZprUrUoDx69Vw2dLl546Tly9qBi4CUrt1unzb64aNu/c8I7lg=
Received: from DS7P220CA0067.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::27) by
 IA1PR12MB8357.namprd12.prod.outlook.com (2603:10b6:208:3ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Mon, 23 Jun
 2025 09:52:23 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:8:224:cafe::10) by DS7P220CA0067.outlook.office365.com
 (2603:10b6:8:224::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Mon,
 23 Jun 2025 09:52:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 09:52:22 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 04:52:20 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v3 11/11] drm/amdgpu: clean up the amdgpu_userq_active()
Date: Mon, 23 Jun 2025 17:51:54 +0800
Message-ID: <20250623095154.1150830-11-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623095154.1150830-1-Prike.Liang@amd.com>
References: <20250623095154.1150830-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|IA1PR12MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c9ff8a-bdf0-41c2-de1f-08ddb23ba6aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ELf+xHaxVPn34ZbJOMrKkQzi04crH41uZeNZbgga55o6nBMuQG4+f62ODu5i?=
 =?us-ascii?Q?5MCz32ctoVLPUQPXY4tOEsTuLFFO66IEczYmSs+SYST5LtYlNgaHHZAhJN9e?=
 =?us-ascii?Q?mMJN2X/Tnay2UC7f/EFJA+csGGECV5SJUqg+3kDMn1wu1GLte3qHuXxDIJhn?=
 =?us-ascii?Q?zABXwK+buvh4aZxhOVSDHDmPMSSgD9Xjx+g03dBJQsvpfswFDdrYBeza1cW9?=
 =?us-ascii?Q?XCQnk4XMRlXxK0TFsct5BTHg7Fc94ThRA7ogadizobHzdeVaEtm1d/A6wPBe?=
 =?us-ascii?Q?YGH1F0GGIJ29w0xScicVjd6QYzgc5w/RnDrILNESPMJRwYfwgF03fDKm+QXC?=
 =?us-ascii?Q?FsHSOi/xB+en484Fvu08F6eZpCnJJjx1dNxMs9+nNitYS5oa8K1iiciXL/LA?=
 =?us-ascii?Q?r4X4/E5qLkZzBX/FZlBQimZCCCExSBMaGVtGjbpCsqh14L5X7W32dKiVjtt3?=
 =?us-ascii?Q?KDu2GLH+neycXRJ+SvU7ZH32kBbpWCeO0ixfepQFyUaduy45fmVAHLkunBEt?=
 =?us-ascii?Q?Z/z+Vlvjrt0yri5ObkDQi9IINKoWltfB168wKYxBif096yAqKKDbvZ2RV3cy?=
 =?us-ascii?Q?6XTf6q/DPxILSVE5Fn/TpLmmAIsOjZjJ+XAE88EfYFPXsMl6VqDFci/EeBwC?=
 =?us-ascii?Q?XZjeZevSsiqnR2d9eO82crpA7qJ6HE0aJuWJQ+SHTdM2gEBhJ5Q6tYOfeGJO?=
 =?us-ascii?Q?FyRNcAAU1UmZEF3AnnI8S8zZ5Rg8okEXstF8zYkjgjkOGCgGBPrUOFcJiLRD?=
 =?us-ascii?Q?J6HeAv2O+QEkwD53GKNm8lJvDjSYQ0gW/ajnFHym1A/kfSdYOoPPzk6DsKsp?=
 =?us-ascii?Q?kO+ZQnqfpUx8Xg9BL0eYfLDVgaQiYY2zoMP15O6NC8+BspoB6RUb8keZD47s?=
 =?us-ascii?Q?nQsceoDi2fs6s9FzkuzHeEwtpHbvMPUiD5R2dFX9XxUJz++eN0IqHTf1JR+j?=
 =?us-ascii?Q?eMzI7uxsxNP3xZWCjLdfCSSl4/R40IaxpGqOxvAMad7L/rHaONYJ4Gxv6rOI?=
 =?us-ascii?Q?8JPQ/CcaiU22sfvt7ITqeYZfdHG8SUWqTHOOAkt7Dp4xkftE+1PaV2hC8ai4?=
 =?us-ascii?Q?Tt86Lsg0gGpX+OzwthH/p8DK6bCYXjgweW1IHkeHKS+E7cGeq3JNz0gt+u4q?=
 =?us-ascii?Q?ifShWKOKs08ks9Cnr4QpHjzQoHFj5xgxIGxJircsPINtRRxrmHsKpQjnve2o?=
 =?us-ascii?Q?GoLbL6DgojA/dlDQsWVyz6cdcCVdS46hLG9CKv+uEBEKyDC9+f8VHmJeQJlY?=
 =?us-ascii?Q?VxqxjCapHwfmmlcHlEZx3ZEyibwcgh/XmOBsT3keNvxCO4OxPLbRA65Ud5IM?=
 =?us-ascii?Q?pQhhw1eXdS5eqQ/OZYvl6Y0zBHOVcpaJYazf+vwyoVtCHMXsHBugxWkRuO9i?=
 =?us-ascii?Q?5wZBglVsV5mUPItDIJKQQCTqR3wV4tNihlFy+i8trXjwIOD/YiE8TkUeVM9O?=
 =?us-ascii?Q?ACGgD5pEb3uliZZ6HperTwVdwX5qmEmndd3x45kCDr8LgYIlTBg9RnFfesF7?=
 =?us-ascii?Q?92xgLtEOAY1jTZWUbwB77jS0YHTlMqNV3rAF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 09:52:22.4709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c9ff8a-bdf0-41c2-de1f-08ddb23ba6aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8357
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

This is no invocation for amdgpu_userq_active().

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 ----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 --
 2 files changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 5243512c9cec..d5d95864d0d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -276,22 +276,6 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	kfree(queue);
 }
 
-int
-amdgpu_userq_active(struct amdgpu_userq_mgr *uq_mgr)
-{
-	struct amdgpu_usermode_queue *queue;
-	int queue_id;
-	int ret = 0;
-
-	mutex_lock(&uq_mgr->userq_mutex);
-	/* Resume all the queues for this process */
-	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id)
-		ret += queue->state == AMDGPU_USERQ_STATE_MAPPED;
-
-	mutex_unlock(&uq_mgr->userq_mutex);
-	return ret;
-}
-
 static struct amdgpu_usermode_queue *
 amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 08c49d738ec1..687583688c6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -121,8 +121,6 @@ void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
 void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
 			struct amdgpu_eviction_fence *ev_fence);
 
-int amdgpu_userq_active(struct amdgpu_userq_mgr *uq_mgr);
-
 void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
 				  struct amdgpu_eviction_fence_mgr *evf_mgr);
 
-- 
2.34.1

