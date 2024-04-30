Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4560AC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 18:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9884112E67;
	Tue, 30 Apr 2024 18:58:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a1VOYL0/";
	dkim-atps=neutral
Received: from outbound.mail.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 725B910FB40
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 18:58:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4eQy1u1PZoTXlRbRmsCcfC/hguYPqwPlbWmGtt5a7/QnBPUNcG3BpNNKLJpzShIzXExXeoOeyPBht8b/ny9Y163JL/GVHPqrdQCkteWzFdHNdu/HOL1K2/EGm3xXZqG+8rHEhVYciEGk6Xtv0u17JBMfS+HO86kw20rF6xUJ5dwX5/xWf3i7rKUexMZmAtkSPFm3WwL2B8nw4t9ykdTCwlUniZ7NoLsA0WOnXdr7j0oiDaJ0qiWTVlkfvZ/3PlqRaIEjRNQ2YE7x70nAg0ILKhOI05Rivfxbyx6EaceSdto2+ig8GN/ZbMVp55kMhKooDnRu9kNt4sTi6FGzl4pnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIZSw7DRhD31b2gTU5C7K42nIuOJeblJUAY1jG2k4FA=;
 b=ax+xzp2lQA0VcvT1SSUWuWT1qo33mxp39ToEYK/qbNbFgN4BmAbom/gpS+u+hKRU8SE+WKCESvq3OniO4ru32TeAraSQ2+pgK2C5CCV9zXTOGCjVpqLDJlIzUJPYgCJPQkD9M6VEQUnLpNUNjUaqy4YDll/FtLQ6A6ksRHzSMX3FU+AAhehJMDvWsopin1NhM6rLsxKPa3N06TVXGB1Wwb2OnzQOWY7/D8Eq7GzE6hrKiYri5Stda0F0/bdAe3De9H9XxRcxDhMn4I+D7y83If1Kj9gjnOW/ba4Af5uDXVCCyQ8MsQnl2pe2ETztCKumUGWYG+96tZpm8lfMZr/HNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIZSw7DRhD31b2gTU5C7K42nIuOJeblJUAY1jG2k4FA=;
 b=a1VOYL0/AAIlp5XiIUxMPBoYHIsDxY/rJU+7ST/+wuitc1/8l09QrZJRGO8qcIej32QVK5aQFAkRM3au5xxlfFXLUGd+fuJUiOuEkXu18gN0wHUXTah+ZLK5IKb9F3ec4OrYtqa/GFe3CqERWIEYvME4tuD/fbJKgiFRefhwv4o=
Received: from PH8PR22CA0009.namprd22.prod.outlook.com (2603:10b6:510:2d1::25)
 by SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 18:58:34 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:510:2d1:cafe::de) by PH8PR22CA0009.outlook.office365.com
 (2603:10b6:510:2d1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Tue, 30 Apr 2024 18:58:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 18:58:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 13:58:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sonny Jiang <sonny.jiang@amd.com>, Leo Liu <leo.liu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/vcn5: enable DPG mode support
Date: Tue, 30 Apr 2024 14:58:10 -0400
Message-ID: <20240430185810.750572-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430185810.750572-1-alexander.deucher@amd.com>
References: <20240430185810.750572-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2bbe26-63b2-4328-9d40-08dc694788f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400014|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YH4j+cpKCkgC8LWHD0hug6STMFPBjMfumqVf2OeR5bcVoUA8kgSrkj+HOTRw?=
 =?us-ascii?Q?dysGL0My6zJqTNKywK53RBnTb4K8g7ipx1aw+QEVnMyTv3IwYSDOLZzjqXku?=
 =?us-ascii?Q?fxxk7GoNSlcj5yI3Ozzm24nZoEZokOgVHyhuJSxtcharPtMIbkr7gG1ATjlG?=
 =?us-ascii?Q?M0WstWCi9HQGW9Ic2wTVVPUo1LvtpD+Z9rAplxkjtOCk7ccv9/JkTgQ6gnBz?=
 =?us-ascii?Q?sCm7fIu1FAKizfGJsSEFXHoSfLh2fJBKceS6AyxYYkYIc1XYH7r9iC2oWSM+?=
 =?us-ascii?Q?yrWsPFcJcsQXnHLJ4ikE65kuv2q4v4d9D0tenaKvgnGUOU6+ieduNki8A3UJ?=
 =?us-ascii?Q?aa3NYict+3kFQWCC2kZpGcFwDrfWMKHJbm3/cbvhbn7tnNBdy1QhvV9E1lR6?=
 =?us-ascii?Q?GuevqFbnzcfLOtQtqLf/xfNVmMwk3Iqn7brSWJ6vLZkAD/FyD29MCrSaw6xd?=
 =?us-ascii?Q?gXEW/TjXPQkMItvi7AgOl4HhOFAoIu8V8crJbYxO/0uRsuRNDVzQJDBNiReS?=
 =?us-ascii?Q?7NstuZeOmNKZFSQCLb4sGMoF4W4jIHQJ+SPg4Za8sqcIDFGHBAGlortnRm+U?=
 =?us-ascii?Q?6HT52TY5iKDfroagOqkL97XAOZ+Fvp5aVvoLmaFZY73L1b9ieD9qfHOqwTCQ?=
 =?us-ascii?Q?XBg7yHKJE87NR4hAlOmTvcRL6Jw4zWfU08WVYmFhJ3T8h861PiFk8yNw16EX?=
 =?us-ascii?Q?oLy4OAqLnHGEeQSDqVhhCnMZu7Y6f5B11Ug6sjltrfb8Vhvbg4uXCji/902q?=
 =?us-ascii?Q?+2WyYsp6D21/GLdeUAPmWQL/dCI9DW5EWoUJ8yPtxKpJ6tLc/vpe3OndstK+?=
 =?us-ascii?Q?9BEPn5A9UrnsmRvUSNxvPaxDbHjxPPw192tt86XStwJ6oFgB34lNPeCqnOS3?=
 =?us-ascii?Q?jDH6PCzo2+qH2BOUY/6+8RYP8g9hkqbh2qC6Er0Qg3s7zODQGux4COSWIuhb?=
 =?us-ascii?Q?A+9M44wH6SRwlH/GITMcptg0EVvBChivNUK8kJN1qxjmyIyRfECepnuvQQwA?=
 =?us-ascii?Q?8qAIQFcOx81KXrT0sExp7EeAEuNTEgucCCm59TUON0pFc5TN/+SR+BmYahAT?=
 =?us-ascii?Q?hJwtJF8q8bJHXOxFCVuWqQi8md4MeeLxkM4hOoC53ZKYnJ6bvd9cOxjoXmzb?=
 =?us-ascii?Q?xIJqgOOIFyk6Gk3oAi2TRViZhTqMFJ+eGZQ1hKT+aiUEbwpyZKPi0GTbnVxS?=
 =?us-ascii?Q?8fjfvf89ysIw+WKacZ90LB3r7D65yJ1YVzip77Z0bRtfkTM1f4uTtrzA4iTt?=
 =?us-ascii?Q?2z9CiFunfh3jgtWTspS423nzXz3qQWHwAKVfCIziwXu5xsGJu5HJ2ihoGXDS?=
 =?us-ascii?Q?zPJnlSs1kajQUfDFWCHbGgYxqFI6OEUkPi2JJFMh+OC85YdDf5LOmiljAROn?=
 =?us-ascii?Q?+7c+8bCMWUrJ3fgY6Y59K3aLoLRS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 18:58:33.9491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2bbe26-63b2-4328-9d40-08dc694788f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791
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

From: Sonny Jiang <sonny.jiang@amd.com>

Enable DPG mode

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc24.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 9c14f81c88a7f..e7929be1a6ff7 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -360,7 +360,8 @@ static int soc24_common_early_init(void *handle)
 	case IP_VERSION(12, 0, 1):
 		adev->cg_flags = 0;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
-			AMD_PG_SUPPORT_JPEG;
+			AMD_PG_SUPPORT_JPEG |
+			AMD_PG_SUPPORT_VCN_DPG;
 		adev->external_rev_id = adev->rev_id + 0x50;
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_CGCG |
 				AMD_CG_SUPPORT_GFX_CGLS;
-- 
2.44.0

