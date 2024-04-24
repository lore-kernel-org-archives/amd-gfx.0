Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E541C19F4F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 15:29:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6386D113C13;
	Wed, 24 Apr 2024 15:29:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pDWm+ECc";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F421113C13
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 15:29:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrRLdY1qXyJRZAgwPntvFSlFZ2exg2yFI7z7LF/aVppcjIQaeDQypSMlTCe6MoyHV3HeqDGfnKdDcLoTJK5ViiGtewyyc49LOC5vwhnrP5dO5iTsQeWv1+RktQrEGbEHm2mvw1rohqCQTU+sZSttIeIFB02aF729yNPURtBgAjrDXeXyigVPPphmaYMvfyNMup/+uc/Rd1U+h/G/0kzIsIM/AM1vOKandUR7RNw8hXGnOzKjQyX/K4vPlkNyqlkM/XXnaUD04UpHtrBEzqhNmoVCQIEuLS2cUZ5hZVcA4OmP/wRcZ1Tm+KZGqqx7PqLTul2k4EtAQfC7urAUEpInbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McyKaJN2MPwGHVvVpONqstsooNbSDnCqbbBTbeXpNmM=;
 b=ZMKmckJwWMyh+ffrQ5L6brP1UJYVHIL7Ro+a/4M6vJs0d3V4k6XJ9XUZGbd/P+QDcRDv1hXkcy5OAsP6rOQW7z9tF+6tXiHknQxWvpGMC4JvZwugdUT4KVJiJ/wNLvMGP2oQ9uzyGa1pM7TK72SLd0fKEOzPq6Uzwa1XphDd8aUI0nSF6SFE9yvlvXUDXHpmmDe8V73mrLVI5yOuaypAZ0PUejxL/qKbFXl58eOhEHr8M8/RgGmxG4AvHJ6sk2TWKwBukxCeFUVnK7gvjUilJOwnO/Fpa5cZKkIi91J/eMnw2C7LFZMw7Tpb3ll/7B+ziPAUaZWQ0EnOVJgTIXV8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McyKaJN2MPwGHVvVpONqstsooNbSDnCqbbBTbeXpNmM=;
 b=pDWm+ECcYqgFZAJMPkNryX6aqSBxAAKIthKvw6DGaNyPqbF4k6+nPHA6NlVonJ6+Hd8pQmmiW/Vl2qbtduyEBM3QM6F1lf+7Iy0JcdVuugIOz3sQeK6clW0vdQH4pvYL3ENqIsRqAGpif39oCbZsSwcUcPw+Jxpb5LQaRU+oeCc=
Received: from BY5PR13CA0015.namprd13.prod.outlook.com (2603:10b6:a03:180::28)
 by SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 15:29:32 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::60) by BY5PR13CA0015.outlook.office365.com
 (2603:10b6:a03:180::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 15:29:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:29:31 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 10:29:28 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>
Subject: [PATCH v6 3/5] drm/amdgpu: Evict BOs from same process for contiguous
 allocation
Date: Wed, 24 Apr 2024 11:27:47 -0400
Message-ID: <20240424152814.9608-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240424152814.9608-1-Philip.Yang@amd.com>
References: <20240424152814.9608-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|SN7PR12MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: d87e5c62-c774-4254-569f-08dc647356e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9T4QE6wLI/hs1N4QrR+C5R1bMr48JBcMo4RW8xar74IbMTX+2ZO2+neW61FD?=
 =?us-ascii?Q?41FLYJ4r9GotfJJVk3c0tA5UxF/rSxq1HZ5Xz0HIw5UyytX6C1wIUI/sWlMu?=
 =?us-ascii?Q?Hjk3p1gpmBfyjji1arTjkC5u633ZkeBAEnVsDtVDoT9dHHq/O4Y23gO+76a8?=
 =?us-ascii?Q?WmblpYfMKy8I6kiunI2kB31p00XvkJcFFOnNvm92nkDxgNqnu/rjpilsD+WK?=
 =?us-ascii?Q?hWysRmK66EJwVh6lHnCf2CZsPtjCItWrcw926lW6tJRioyT+WXE1N1SjiqO9?=
 =?us-ascii?Q?eiVXo3Hq/+xTNMoNfjGTXhdN7vIi1xU4g860D+i5nb5tbK8e7c9ETuXz8BhR?=
 =?us-ascii?Q?tkKOU90V6+Q+hWU5RqB2vPg68F2zsWlxg/ftFbq5LszKhufuzPugQLDgxqEk?=
 =?us-ascii?Q?zLp3EU1LiiNP9iBGJDXrTMurU+DpAvJYDsmg7Ka8SyI1kfi88/eEZcECGBmm?=
 =?us-ascii?Q?INOWOxmNkBmaCeLs4mfkYPaDpo5sjWlSuRe4Ma0b/l7QmDpuvvYRWQQ8o03G?=
 =?us-ascii?Q?eQ1udWcCbaWWp0NciTBiCGmbzMDF4HNOzJA4Y0gJHlSDWFg3JZO1tYxEYZXc?=
 =?us-ascii?Q?QSbHySRK+mo5EC0+hI3du7HPU5CYm0DkwS6E4v39IDhlC8JJhYgqr+t1P5hY?=
 =?us-ascii?Q?oYGnGGPQjEOOJ6KL2C5xhmoQcL+EauNnZpgN5wRhfhhjIa/QgezmcHn/hlvL?=
 =?us-ascii?Q?SZyhIofSm8b2uQKX8TjHfodt8FWYQA449A+lJe9ZCWVpL5tjkgtha+h5cGah?=
 =?us-ascii?Q?QrfBm9zfySu5xqEFGj9/RRZXKvovunlpWplSy8GRM8bybr8S2tZ4h/XQuF/a?=
 =?us-ascii?Q?BgSqo0USjPgbVWd+Qj5lBnpWe86yn4pVb4apMfhOn5ZWPQTq4MEO6oRirqdA?=
 =?us-ascii?Q?titfX0dd/4yl4jAkVsOgfTcPO7IMyBYv+cUuO/doyxCmWt4LLq4OW7L/EPuO?=
 =?us-ascii?Q?N6Wi4d3YZIYRH6VzESodCII8gkJPkgHlECAr/05Hz2g3UN+pvfmQXUJQOurF?=
 =?us-ascii?Q?CatoCNElEy5b2rYLtmEbdjYeu/h02W6s09Lqh6DyeVmy5tyu5UE7LOU99FhK?=
 =?us-ascii?Q?0bao0gzVcwyRhKxtpcaICgoPlQlQkWOTTC2vPhiGd9dN363Dde3+2T082L5a?=
 =?us-ascii?Q?z6mluEwPqS7vadaxf33OV+kaa8jtRTIZdN1jPSr6I/PzN6LCiRTExC1WsA/w?=
 =?us-ascii?Q?wneszTb/vZmQUM32Pr5MypbaSR8RLARfYyAfkEa6YSDSWlw9h5g8XX7aVchL?=
 =?us-ascii?Q?WwT1y+AtuibWZIeAYUxaSlaj22dtJ1td4yfddZNb1x9DCO8RKXm1dcUmIE7S?=
 =?us-ascii?Q?Uq9vn1V3CkMop6fGSStmiXONNxvx1nxAYiTBK+yL3BfKZFa9i7v/9LZgmxFF?=
 =?us-ascii?Q?ObDRJyjVtkzWNGkxpNFvEyavhziA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:29:31.9845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d87e5c62-c774-4254-569f-08dc647356e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8147
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

When TTM failed to alloc VRAM, TTM try evict BOs from VRAM to system
memory then retry the allocation, this skips the KFD BOs from the same
process because KFD require all BOs are resident for user queues.

If TTM with TTM_PL_FLAG_CONTIGUOUS flag to alloc contiguous VRAM, allow
TTM evict KFD BOs from the same process, this will evict the user queues
first, and restore the queues later after contiguous VRAM allocation.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 64f5001a7dc5..c21ea808f931 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1403,7 +1403,8 @@ static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
 	 */
 	dma_resv_for_each_fence(&resv_cursor, bo->base.resv,
 				DMA_RESV_USAGE_BOOKKEEP, f) {
-		if (amdkfd_fence_check_mm(f, current->mm))
+		if (amdkfd_fence_check_mm(f, current->mm) &&
+		    !(place->flags & TTM_PL_FLAG_CONTIGUOUS))
 			return false;
 	}
 
-- 
2.43.2

