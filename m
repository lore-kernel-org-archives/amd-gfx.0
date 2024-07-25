Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AACC52CDA
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56D4210E867;
	Thu, 25 Jul 2024 15:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wgCdj5JC";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2145110E844
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMipZ8XS58J4VhGx2V1oTCEjptgrzWK3M/pr6Oc4B/C4ArXIZq6V6ryHUdTHfpij7HMl9rtt4qNFLcMJ8drdLFGiS12OLCY2Tf2F/X+qxqxtNIhjLx/D//xThriELJXQEVlWMdiQqA/Rd2eZNIUY7hv/OAoLYmKkGdaTKXpQvvR9+Lalzs9dpusqOvH0XpcLcfucOauC/M6IAAPqDNm3UIZBUkzAteJBgVkg0RlGo7ktsLpqduasM89CXcmwMlkaWujz1lJdEj2cPsRdvYlAqTi7S+1mWqqz7+9OHhqU0xsnKE7soWWkL76kee1rIxwnnq3/Ah2yezvJm1jQucN4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVOJCb9tGRGyifTssPeYVwvvAElxqYe3/nbUNdi4jq4=;
 b=aWzcOI5bkSzB2pd/CqB7ZQY9JEgjGCw8J8WxFoib3Wwhl2/ZnpWqYyKSwEBzfpKyAmwNIB9KaQNDqqLDeyI2UOzrqihvzI732mVRszZCjeJILir3jUAgm2I8oSHtiDAEQqRLLGtJD88zlNDsMCqHqo04iZYYXdtdNtu7suAhn3XSlONqWh5uXDZ9LpijLJ9+FJnvEhEQXzTjTcF8rxEroyQ4E0JsccarcWyHvg6PrYBDTYUXEnpmen7QpoqEoA2491E4z6Zu4nPIAEFLoudxsjSd3Fxn0LRo3V6hImS/pDGKQb0Xddw5RvyqcQ4x7JDhv/q9U+/MY/vSvX7IBzpThw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVOJCb9tGRGyifTssPeYVwvvAElxqYe3/nbUNdi4jq4=;
 b=wgCdj5JC8WW7WWVFGwVGdBOjgcQfyx1FoSd5I85L5lWHgXpUOUnZ/wntD1I6BAcrCdzX0O2msgWIy4xySzsAu1mwa6lPrSmx3uBhrTlT3/glOY6GbGqhK9tgqfZAvbetfwLf+Yd5MibVucsIYk5HEpU6qO6TpPOSD1dKBIr/hXo=
Received: from PH7P220CA0042.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::25)
 by MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 25 Jul
 2024 15:01:29 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::ba) by PH7P220CA0042.outlook.office365.com
 (2603:10b6:510:32b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 35/53] drm/amdgpu/gfx11: export
 gfx_v11_0_request_gfx_index_mutex()
Date: Thu, 25 Jul 2024 11:00:37 -0400
Message-ID: <20240725150055.1991893-36-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|MN0PR12MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: 446b8438-e6bb-48da-3beb-08dcacbaa96b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?On93B8644c3CyqXa/KTZAcyXqaSlEB4gjPAj/qn5Hb/FIK62eYFizFPFYFjv?=
 =?us-ascii?Q?x1+WkcWOv3P9mAvtAt9AOdvBy5TW5pIEzRsdsT9JW4INXeNVwOeKIdmPmVyn?=
 =?us-ascii?Q?iXH0yEhsQKXibAliZlR/g2cwdHLQYn9J4uOnUNEGBgO3lwgNSBqAqBKCRg6S?=
 =?us-ascii?Q?woaSptHmcPQ4aG4LxbmQ6OFeF/Rg2q+o3kDnSg2WcqmgpHvr+lFgo7o/Ax9H?=
 =?us-ascii?Q?Y/DAB9VXqUK4rbrzunPXI3ioEQ+tkAv6PxqIuFJ8gTe53vgKp+RrVqHJ3Zr5?=
 =?us-ascii?Q?Y914Ney8a03tIJETP2wow8l4k16j+JKQ8f4K1pFH+KDZPE42hFka8KVSU8jb?=
 =?us-ascii?Q?n8jURfwc3C6W6tj5xTNNMeauzuiAM0joL0h/j/QQQVqvoIvYS1JqKGu51e9k?=
 =?us-ascii?Q?o1DPP0QtZMKr3GhTcMis9Upe+hmT/o6RcPUCPnDlgmZ8Job3J/Kg+nRu8s5D?=
 =?us-ascii?Q?5ipNgBUvK6CiwHBI3tqsa3enDSiiy56rqkCwnLfgTpzNPLVeMBiW5m1FmVp6?=
 =?us-ascii?Q?P+6iA+jccagfGUb9/aBi00HVx91pLmJBtQpPGGvb1xsWWZFuVQWuwB6BFHk7?=
 =?us-ascii?Q?dbWXqVxnzyS/EpJqEpuhASNvUZQJjMshwTpzM/StPQL4mJ1AZCzBMZXCT2KD?=
 =?us-ascii?Q?uF9ElVdn74uWn6/pDLuADU0H0NkRkhuGnZppmmdKp1Ua6ElMoCkizxRTN3hX?=
 =?us-ascii?Q?YPSMn47mPCgRqAMuOthRJXdOzanrDfLXnfvEpb9hvalIExrUjRqvxrmAYxp8?=
 =?us-ascii?Q?xtg4LN5Zybj0RQdYxd0UKOHGhlUwdJGSLgOgiUmZXI3CRFuSQ9LQ2ihhdOWH?=
 =?us-ascii?Q?FHmn+IU8P9mcXpmxrN9GQk3oy5N3hRDjVRmNpDFE5Awv44i9Ais0D95Sz42a?=
 =?us-ascii?Q?eQFxx4zrYsULuWQC0CFmV2Ye7AIFNwLbU+eiDobfrZeqhExIC71VI81BTXeu?=
 =?us-ascii?Q?v9xkTJZ8EPHl2whGWS7YHl6aAmLJ1ainLTuA6HodmveBX5+Lpa4rvBdUCEFS?=
 =?us-ascii?Q?6rZy3zPE+jsPpGaqYHm1pyAeWextTTkiQpAwKCwbps4gw4U7bqSArqol96ID?=
 =?us-ascii?Q?ynIo1/qLSw5LFzLAmqLTU5ilC7LPGj7GlMhHrRmMBwmQLWKMKScCGhZdflI3?=
 =?us-ascii?Q?QWAbWYulp0186ib7iXYrZPyBmFurg92IXZAJUfIKXZGcsPyeVFaFTd65oeVQ?=
 =?us-ascii?Q?m903zSVTbhBSVi82qLmiFX5qAZeQ7gOmbAHmC234408KvFxUiwH2upkDKh9J?=
 =?us-ascii?Q?fniYGYEksiuGz44Zv11aewysYu3Zo6aBPlsQgxZ4tDas1i5/zIMVM8QISTWa?=
 =?us-ascii?Q?ZQqXyo0v/zqjoLcIsxxUUQAX52f2B3yDG/3JzDoRjqvmyLORhA69WusjebUj?=
 =?us-ascii?Q?cTK/x0fveMi0bphKF+UxaxdKEFpojFvTuq+oma5AoGUOHYfnJDQKJjN8ahug?=
 =?us-ascii?Q?jz66SRba4NzVd1A/BvUJGADXM+HVgO9J?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:28.4789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 446b8438-e6bb-48da-3beb-08dcacbaa96b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5761
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

It will be used by the queue reset code.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 6d8f2124b30d..37dd5002e92f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4724,8 +4724,8 @@ static int gfx_v11_0_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int gfx_v11_0_request_gfx_index_mutex(struct amdgpu_device *adev,
-					     bool req)
+int gfx_v11_0_request_gfx_index_mutex(struct amdgpu_device *adev,
+				      bool req)
 {
 	u32 i, tmp, val;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.h b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.h
index 10cfc29c27c9..157a5c812259 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.h
@@ -26,4 +26,7 @@
 
 extern const struct amdgpu_ip_block_version gfx_v11_0_ip_block;
 
+int gfx_v11_0_request_gfx_index_mutex(struct amdgpu_device *adev,
+				      bool req);
+
 #endif
-- 
2.45.2

