Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0585ACA1013
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 08:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 960D610E487;
	Mon,  8 Sep 2025 08:49:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cRQsfNVq";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9065410E491
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 08:49:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfk04hcS5Eswi7yFMWKQ3Wo4OrSsHQSKH6j8O5CezZ2CF6qCEqe8a022B8rk2uYPPksDWYgpQEiT/7SVK9JEPEmEIZbZVDru6XRkfgvVym3Na6icLl7970TCWi97B1KkNBsemxJfCA9aDJneWzW16JYDfgxAP3wKcrtqwEa1IvGHbu/PGLa0Vyg7qm9YUWq2skbUaGIah7mpZU14z5kPWLdEmeA5YhJB5z8sW2BCd59cWpGhmymQ0N/SelrpMJH3Wp04qnBcjNcZBqngZZxMWsokXA9llHshXQUJ2AhGWEes7uAkp1HKaJ/5/SnHWRF47af+cLcXqBL8BMkC2r6g2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xr5e7b8hR9QpAVka6UNATsEy8xOZqa0jZ0FhRwWJy3k=;
 b=GAlZMtP195dGTY5gCD3ZdAwgQM7U5r9XOBYF3upapE1dJr4OjQoaQXLpHc6ia6Tdy8whtg/6rUa2hUxaSRU5uhRxXrJt67fWLrGfEgddUXfSTKyONyByExF+mmrbkgB+NjT0QS5+YMWqIiMU+Z3cqL0tg3jxrgYA31UPXlTtWQyq56eFvZmgoRdwoDyLILqWyYC3s0DhB/S2OUL7AADm3Iq8v/FgWfCKELKP+yWyI8kxowlgojX74bNw7ohKNiTUCS4DWSTJMI51B13TvYrbafgCIMzkBfCx/Wenu5WShdvapnUdtZP8r5kJTaQQDjTDLTeTvZmBQBng32hjskA/dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xr5e7b8hR9QpAVka6UNATsEy8xOZqa0jZ0FhRwWJy3k=;
 b=cRQsfNVq+U0KvxSK1ziv8ZNsCyFQ3j2Ki3HTWcMrV09Xfd+eGTYKPTSbHgPEqODpKlrdQ/iQ+jF2M+nw/r5n84NVNuBb5GWjdMWCC3FWA/fgTyOCfBkLEIGlfnfD63s9JN8vApIqkDC8aEY3mqVwK2X0byY1DqDNWL05CRMR/jM=
Received: from SJ0PR03CA0219.namprd03.prod.outlook.com (2603:10b6:a03:39f::14)
 by SN7PR12MB7449.namprd12.prod.outlook.com (2603:10b6:806:299::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 08:49:17 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::d) by SJ0PR03CA0219.outlook.office365.com
 (2603:10b6:a03:39f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 08:49:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 08:49:16 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 01:49:05 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v10 05/14] drm/amdgpu/userq: extend queue flags for user queue
 query status
Date: Mon, 8 Sep 2025 16:48:37 +0800
Message-ID: <20250908084846.1873894-5-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908084846.1873894-1-Prike.Liang@amd.com>
References: <20250908084846.1873894-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|SN7PR12MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f0873f-6698-41f3-377a-08ddeeb497bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aMRnPakFebUpjQLJ7rG61NrVi+5eFgFro+qP3WDskDlhMs3LzbJDuJRKMr9R?=
 =?us-ascii?Q?280gV1jw90FH4L90lRdNB/BeTZzyZ5BLFAWfJDiNWDWbkxscYQo6MjMQT4mv?=
 =?us-ascii?Q?56SQaFsIGhVjhYiooFpWzujzgRJoOHuS1T2iO9MbU94Ewjc8iotKUxiXnWbq?=
 =?us-ascii?Q?nv3UUNyKq1xSJ+j0Qe+j35q6XdyUUJ9gEwVGoJPctIkQNZBIas5z7+7iu7Ww?=
 =?us-ascii?Q?65IIqWsV0OQ2JO9SSFHP2911695nhvO2TElfHgRwJCMOuj4//Gh9SlwPEcZB?=
 =?us-ascii?Q?9hbtXupeE5mecfa0KQ4Fm2PLDNKjwXWluQxxRFxDt+8fOhuoRG6frY7/6hXH?=
 =?us-ascii?Q?NOEa3tNGQbtfKi8ef1WciEfmAoLj5urQCQ21af5NLWc1eLxb1wq04NOF8JrT?=
 =?us-ascii?Q?6sosajuAJXwijCFj7h6aqgoBfrV37gfIDlUssdMX0okIfzRj8if13WVbguSj?=
 =?us-ascii?Q?SS2SllRSAH+tVfugwNtxqBgODBkOtrkeWqmbk8LTuDUPldhJTkWmS2F+W6tu?=
 =?us-ascii?Q?WhrPwCSYLGD04Bd0aJfbyGF9wuOXuJQlL6c/DB3RP7JYW35kH74JmoD/Nk0X?=
 =?us-ascii?Q?casuJ8zNqskjbfGp5TVfCax2i5Wwo7rzl2fYp2VHytlOTiI05hPxAJVgwxfZ?=
 =?us-ascii?Q?KCqNvztfHhH8dwyXBzSees+1hRSgeuFq1MdmfyjIjnxctjLs01TR07n6Grw2?=
 =?us-ascii?Q?tQqJzfia1kG5m+9/Tt6JyopZ21HxDmTVVBwy5utppAJhsS7RvRPvPpFv7Y9f?=
 =?us-ascii?Q?CxyTVt+OfKQGD88q1a+BVBThq2IclCm/mveqxVKhL/ymXUov4Km5IT2l5ZYz?=
 =?us-ascii?Q?XInJIFnMMg6w6aT5cc2fY3D/RIFVb6LZ3FjeMbP/NySZBYsFW2HXkFeJUfsY?=
 =?us-ascii?Q?6RahrpQMR7dhe6vxKsGTZyxSOMvu+ZzV2ekvnMq+e4xPe6NKeVZ2jblL9wHG?=
 =?us-ascii?Q?0TpWxVWq5XslGmAnK3mq6buYE07xkS2A62+G4e4RXLINrlk5NyIRDbO+q8ju?=
 =?us-ascii?Q?JdUj2lC1l/QhRIdAvg8C9LK9B0KNeUZUZEgezOV0SLXhmqAk5ayskh36/W8W?=
 =?us-ascii?Q?W/cykrkxhLhI9NT4BM0l7Mwlv9miN1tPf+OJjlOLuoFn8Ssjf5C9wtUgympV?=
 =?us-ascii?Q?j5JMejiNrRSx0G++IK8g1l77Pe7Fr8qPATx+8twVWNAzIOFw6j235HMlhGg6?=
 =?us-ascii?Q?XSA9dge3mNTh225n8xm+CMtVxMCJY51xCh//6CNVQL43Mpd5nEX+Qi4XH0ix?=
 =?us-ascii?Q?zXxqaFCkB1qxH7TRlbi8YGEpCQVF4TN7Z/991TkKJsjMpNjwr+Z0ecX4l+/n?=
 =?us-ascii?Q?tSBNMaYiixc5pedoIwqC/ln6ztQKIoJRkxIziKaCU52FPT0Ie5ATNdJ/ITze?=
 =?us-ascii?Q?svqh6dE+D+lvKzMkNlzk9hjdIIdQQ5YJz7oCavcxQlk7zyxG4GXmAKA2XR7a?=
 =?us-ascii?Q?oZg2+o/hDNImV2JLXqZTYrRQ+UTiio1XIkwq9Pl1BUG7LpG4yOaRabeyQ9CE?=
 =?us-ascii?Q?xHzpL6WFuL1im6b9CEZwFJGz4TH/04sST0KZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 08:49:16.2883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f0873f-6698-41f3-377a-08ddeeb497bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7449
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
index efd0d2356077..cb5e62f9298b 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -346,6 +346,8 @@ union drm_amdgpu_ctx {
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
 /* indicate vram lost since queue was created */
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
+/* the invalid userq VA unmapped */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA (1 << 2)
 
 /*
  * This structure is a container to pass input configuration
-- 
2.34.1

