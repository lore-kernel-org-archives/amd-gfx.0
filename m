Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEA4CAC59A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 08:11:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 301B710E961;
	Fri, 19 Sep 2025 08:11:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4XRb4EAU";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011057.outbound.protection.outlook.com [52.101.52.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8756E10E966
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 08:11:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=te85T/SrSKSH4HziWmJPO8tJZ2TJX+EVtk01ip/2IK2w3CBobzqV2tt6aWjt5Uup68XNU937z6wXY+Ayf3Hoh2LxoCJ+67VUIM57vtGBAy5e2shGSHMPR6tjlYKqB/FD3TiKrIUig27AxD/31Epd5DSf8ViLVgblaFpJ9twgzTEfkVjDUocR202gvre2qf4UA3jzlvNTcONHe/5TFS5xtrAHqEhjLaQ4xw78ieIh2OmfNOeSBJTM1gAgjeWZdxnSBb11Tn+NH40fZ3fY87Wse3pVXLQwXe9zdc5/q9GMnK3C3ItbouH2zDYrr8DpS4mta2OgGdDCBoTnMMUtu84+ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3hNWleOiBcscuGW4gaQ6Tuda80w5dF6EC26v05zxSQ=;
 b=quUBd22IroGRAGk8RcqTqr1rDuYv18LOcWO3P2rNTSd99afEsucqcEjOESGUPff9MDcyaqgb5q6Hcg6oV8KmJzy3ww+RsZpVMqwYbazJczpbm2LyoceAzBgZX/rf9Gpobc3otb5B5YoeHZaDfn9lTM7dOXI5l/VJ/QncAUWcD2osY9YNzpWr+Plx/7Q+v8kSgMywIrgvkUwVEdPbmxRwjcgmfxrUCv8MaHFeODmRpUFz1lQLfJ8VbvUfJa+RUnucACy07/7jvFnxqZcQXPHzsot5SUVJfOAjHjWrsZ0B8xY2a4w6QYMWpQvghikiJQHatza7wK7lH6XgNM/FgnKmqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3hNWleOiBcscuGW4gaQ6Tuda80w5dF6EC26v05zxSQ=;
 b=4XRb4EAU0Hh6wwdydzcWD2LwNmVyrrxW2lGO+IUskZlWmxxhfqDmjPo78UcnjLJqAezhUBf/ZwQguoPH2zZ0ig+Eulk0PP/AMV/lnPgR8ZVKEze1LKyrvb3CBAS4PFazBjcp8H9ilg5Jot3r3YNp25LYJPOGbfV3txknNQhCTuw=
Received: from SN7P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::16)
 by DS0PR12MB9421.namprd12.prod.outlook.com (2603:10b6:8:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 08:11:46 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::a) by SN7P220CA0011.outlook.office365.com
 (2603:10b6:806:123::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.15 via Frontend Transport; Fri,
 19 Sep 2025 08:11:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 08:11:46 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 19 Sep
 2025 01:11:37 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v4 09/10] drm/amdgpu/userq: extend queue flags for user queue
 query status
Date: Fri, 19 Sep 2025 16:11:12 +0800
Message-ID: <20250919081113.2797985-9-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919081113.2797985-1-Prike.Liang@amd.com>
References: <20250919081113.2797985-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|DS0PR12MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: 8295810e-7891-4b7d-b60f-08ddf7542d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gLURdpiZQ/QaR/4sUoO58lTeSTfsek7Efi7lafpu5FWlWi9v7LVD8n3H7iI+?=
 =?us-ascii?Q?aSuV6Qp5Ei8YQQTpJrwL4gKN2r3VZ6HEai8IQYuWTkrNiMcuFQfRXx3pWQiX?=
 =?us-ascii?Q?7gPAUoMxfofQi+bZyxzJvYg1AZgM4K9PeJ4qy6RIvSlzIz9oVqBwQE8M3nLM?=
 =?us-ascii?Q?iLP10owAmUJKMUX0728Kqsqfblui9GQl9E0tg1ZJvWVZYfsqRcMwsyknJlmF?=
 =?us-ascii?Q?KqtXjn1kOTLfD4OMgWzTzudBZQxQCRf3N9UhmsXbz2wDPMxKJudycOAStJ4p?=
 =?us-ascii?Q?4qIR3n4jmfv2nFTioiz4ZqtbQbDvEP3doE54nW66+g27LzYSgNbuHvNPeSKZ?=
 =?us-ascii?Q?ja/X/3CUa45h9mv4g+KTmPb/6W2X+5kP6CsQ4JyCTuz2m+7WgtH4IKQLPuB1?=
 =?us-ascii?Q?pFg+YsYX06xBZLk+kJz8hrj1pJK25DC9PsW3YV2nyJgp5XajbU/mc1AUBI6J?=
 =?us-ascii?Q?OPcqTHAXYcvUIrEZhU+9T+RQ3k8EDLAp8vEERalQ1ICWYRrlzFJ+Qj04ODgi?=
 =?us-ascii?Q?PRy4DSLwrjdKe9BugTnYFgISKYNiQoQWN12rsuHg1foUEx/RUuHiCarUj6rq?=
 =?us-ascii?Q?1wejwntz50mD+W2iRZ707qLxuLDQ97IgApwdZ6PVM9hsBIPg+N/my6s+nNux?=
 =?us-ascii?Q?pk4RLPoAkCCMMD3qY96VS3hZYwtLviBAUI+IsyhjNwHqoZy4ZA2cjLyApGZT?=
 =?us-ascii?Q?sZ+fMFZUJLOxoQ2yW/9lY9pBclPs6jSBezRrE/lbgZ1MqooIoJVJbe8fCcmf?=
 =?us-ascii?Q?cKJlwpUXfcZu9iB0DDWJ9A44H7AVDXPEgNVvdQrWnffD0wI8UrOw7cUwDPBy?=
 =?us-ascii?Q?zgylnJMSaS/PzRhT/jQsxrPQVrlDMQaY8EEfMge6KeqX9lJUcQlxG7VYkKSP?=
 =?us-ascii?Q?4FmlA6NHb2XRMq19m5iJoSFOesX4L4LNLI5fIHnsd1q9H6tP69IB2WiZofjW?=
 =?us-ascii?Q?etD46CgcwD38wujOnXDzOQxty3IUSCnhGjleKtFPIj0JCKiYKY8+meRbWoLm?=
 =?us-ascii?Q?iz4ctfDO9s9CD5hnKHangcemNN66VYt88CUI8Vvq1lWQXibTi6CxJSoP1+jr?=
 =?us-ascii?Q?pj1O8ibPbThpRvOzlS0/DBCEsIogV4G8RVooSLMiWWYMR8NTb5szFJdVhUbH?=
 =?us-ascii?Q?ql8R4Hl3MoHyI7embRakhsDvx3FebCxi8Yr0HMjXGteSAoxZGK1Z2RwxEqZj?=
 =?us-ascii?Q?kyAYu7x4y1/ZV2N0vKgwbnumGMcOv0U8LROXylVNWcuaD7TmF2g9Vuf6NWL9?=
 =?us-ascii?Q?AWnUuZB5Yj4bBWg7USxbXijT8yDSlOXcQPTS1bPjHyEFB4TR69flbSF00ge3?=
 =?us-ascii?Q?7GrIYbdqFpTEBt0j0BbYKMGStraz9MkHUllTzdwK6a/uylr0okXu8WUb58fn?=
 =?us-ascii?Q?9SNTwddPHfC4eu3ApgUv8EcBcjYpoGOfKHwNYPffAQrqkWrOYrtFP2Er1afP?=
 =?us-ascii?Q?adCpXebyfrFsgHjty60pu/+L6Hmbij2UIbMKZaeb5dWUv+JBNkXe0s3KtE/x?=
 =?us-ascii?Q?Zfyq9hZEnF2eNjh/CbHXYAEianZAofPpt1g8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 08:11:46.0815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8295810e-7891-4b7d-b60f-08ddf7542d0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9421
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

Add the userq flag to identify the invalid userq cases.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 871e0f56d61e..100ccee37d5c 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -352,6 +352,8 @@ union drm_amdgpu_ctx {
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
 /* indicate vram lost since queue was created */
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
+/* the invalid userq VA unmapped */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA (1 << 2)
 
 /*
  * This structure is a container to pass input configuration
-- 
2.34.1

