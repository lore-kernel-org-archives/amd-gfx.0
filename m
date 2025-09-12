Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBB9CA101F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 05:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C78B010E43B;
	Fri, 12 Sep 2025 05:55:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Roz4KCEh";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 142EF10E43B
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 05:55:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ji5PNUYv4qEpFDqKVBEz0D3V0caCfyDBA21OkOawoSomUR6fuSvpgj+592ySNRnS0uFLigKw9u/6R5mBApe1sn7783cuEoU4RbESVr0YbE5E9p6RXw84mr5I4GBVitcaDABoAVVhDQa8lnFP/uLcDH9SH6hO6ZW4TtKQljEGi4SZdv0wPxhHX/i3jphd0M7SHYs5g73RUckYbuwKJUK//gDDCJLCvLIBNgNfGUzTlTsZ+3CqGxprptBH0O7AB4q3LNGm7G+q3DDjRhwwUT7aURKMEStVrNQs98rpFygx6v1up/WmmE+BuTWXpyzzYGsbeEflk1RLsppk5R4R7F10vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+blpBr/kjZhhITExUYUnAA9nb5frLnKoDBa3u6xAa+4=;
 b=Fn+hp6yD9L7APOJONo7rj5/FpIg8STt6EFl39HD3twAGdK26zJ10QdIxLg4EIWW+s27gtAKAfzRRwfQKCd7Y5LuEJ5D9JE5ZAOqwCvdyQXdlBf0dQgoIBIztDXKOn7d+r/EdpHtbG6GgUuouubiandUK5hTeYKp14doFKhq3qjQNraLlDLUABV+a3mf3j7SuUSg7m+GX5JEn7ptrB5DhSXfzfaGN6a7Lk7AgMCbZDq+2enFjoJmMLIEk51p7YLRJBoLVjaEgG9TpbprmohLTmYMUXTm8Nv/l4WTsYhCe6uQ8Z1F16AH33LpptlL3h4mj2NeoSasy/2FJ99Nyrpn4Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+blpBr/kjZhhITExUYUnAA9nb5frLnKoDBa3u6xAa+4=;
 b=Roz4KCEhppmYNdCcBPiwyp/k3Qdl38faszTKLMAKhbFbIAgBsa+2FbzmxRIhaM5mKSaAraRIz68Mvj/7tUUHhHTvpPnRIYsbomvM/LJKEPHkaUiOF/K4EJcGypVw8b0Pms7zhf0XcRlqqbSUnddjxTjoUEPfw23xwMnLWoCsyPo=
Received: from BLAPR03CA0109.namprd03.prod.outlook.com (2603:10b6:208:32a::24)
 by SA0PR12MB4368.namprd12.prod.outlook.com (2603:10b6:806:9f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.33; Fri, 12 Sep
 2025 05:55:41 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:208:32a:cafe::b1) by BLAPR03CA0109.outlook.office365.com
 (2603:10b6:208:32a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Fri,
 12 Sep 2025 05:55:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Fri, 12 Sep 2025 05:55:40 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 22:55:38 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2 7/9] drm/amdgpu: keeping waiting userq fence infinitely
Date: Fri, 12 Sep 2025 13:55:16 +0800
Message-ID: <20250912055518.2719533-7-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912055518.2719533-1-Prike.Liang@amd.com>
References: <20250912055518.2719533-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|SA0PR12MB4368:EE_
X-MS-Office365-Filtering-Correlation-Id: fb2a6a54-abc6-4fc5-f913-08ddf1c100e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fJJ+I+yGQuoLXTDotuYfcfSYQcAuRODg5o+wzAwu5WoEqdKsLtpRuX2nfT39?=
 =?us-ascii?Q?bK6v443TCR96ezIPPx1w70YNwCO7YwfCN8ZnSMgWIl1DYuP05/8WuC2goHnJ?=
 =?us-ascii?Q?nsi+TDnnqhWU5R6dXW+JQtHzDeaNiy41Uq19pp7f3RyNYfS76MfBKEqAF9p9?=
 =?us-ascii?Q?7yjqwmWxVQp2ttqyRc+Mn2sxZ1ghwNEZl7z02W/3nlr1m6MZFYQAj09gF4vh?=
 =?us-ascii?Q?CHLJ1tg8jvwIisLeXBWYjtTVxow/cyObN3wfwLSCyR/STCXoQKc7Stt6wT8G?=
 =?us-ascii?Q?vFcLwifdfKIoPWIBuvvbT0+sabMdMxjqijNhsNnSwVRUZhp8PHE4FFUSXzJo?=
 =?us-ascii?Q?CLpM5oySQ1imExJOpZFEzTwgykxDOy8MfwGEC7o79BKlRPvIBe2X+m3rpFdP?=
 =?us-ascii?Q?MB+ofmx7vX4dvKWLC3qR609zqbhK4c3lQEMsPpDMkG6wH5chYiKddR0Y+RFt?=
 =?us-ascii?Q?pBqWChmUeMHgP58jYC0ukYoEgEYhS+pau3Wci1wOxSrd/QBZ9uuFZHfWOw4b?=
 =?us-ascii?Q?s25vhUoCwqlHnwvQzbSnPfU04gUOcxPHhEB1wPlAYqMLVNAVY5lroHneK9xj?=
 =?us-ascii?Q?nDned18voUiYvKrMZyJ7A+PHfQD3u6NJEwZmAL29HsTW+fWNLIiXuLhbSNyH?=
 =?us-ascii?Q?KJxOCkdHc5gPufCv4jodSQRbhb1Q4SgKdXeDiwQ5tj/8DAGrBNoGVrcWLMbZ?=
 =?us-ascii?Q?67AuArjBLy5TJJnkrB/1Q4fhKGq4ImAGpXyiU5/SYr7yuh2wAHsCY1TCJru1?=
 =?us-ascii?Q?VJh0Nx5NEE532ju1QC3tewlHtbbkyKE07fXWNpcmiWDMW4vCHBB3Tzzvidjc?=
 =?us-ascii?Q?EwN84IjWbuMgo9yFrzM7LbkS2sDgFdQUZkKOqIGHz5aew5zYxOLpLC0jvA9r?=
 =?us-ascii?Q?eKY7YRSFb3IJErDwCwZmVMTcJBWiQ65wQt8OQXKcpS8FvSbIQyXOCSbcT4Ex?=
 =?us-ascii?Q?v98o5tY9LSLdP1r1glTTPGSbHpHI+/zbxAINZBTzfaC/C7iQO7Q22PYik8h0?=
 =?us-ascii?Q?EJkQbkWPDyhBaIZnv07OH8NH+C7qJUVe+coC5RF5zeHZAg0CyCSXcpFKjpFm?=
 =?us-ascii?Q?Kq0UFfteNEPcTW/80fRE3rx3xMUy2xNJXv9VxdZIGCx3eD3mxdYGVCJRhRIa?=
 =?us-ascii?Q?8vM0psSiZQ29G0ERPd3Kwydlwe2V6144YL4onUAPJsKmu13WHVjAXQc2g7ih?=
 =?us-ascii?Q?DLg2iIaJit0hrdtBH7e3ERG1fqoIhPA9ZJS7/Ai17YJXG5k3lXSpfhLRcKc1?=
 =?us-ascii?Q?cgMqOH4KnMU17MEZFSeynXH6GiZVwl81QZtwYlGKl1odjl6I6wA3xm4HUYLU?=
 =?us-ascii?Q?lM8g7JkpmbnYm7IkwiyejilS1FY9fno2K37rawKlbgEGt9ZVGuGTOyORrYUh?=
 =?us-ascii?Q?IuhAjpkA6EfyZ3MK2r7RbpiMTbNegalXotW7Z4n0wQjztvKh9V58tP2UcuYM?=
 =?us-ascii?Q?n9bwg3/OvX2wkoQbTLtym5cyd31bAfnGBWWht7ptdJ8Y8qVwyV2aRyIjawOp?=
 =?us-ascii?Q?7EghlGv8zzyopSAHSSqy/eVIW0Oh7o2Av/NH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 05:55:40.2188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2a6a54-abc6-4fc5-f913-08ddf1c100e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4368
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

Keeping waiting the userq fence infinitely untill
hang detection, and then suspend the hang queue and
set the fence error.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index cdcab71248d6..957b26ca2eb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -193,7 +193,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
-static void
+static int
 amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 				 struct amdgpu_usermode_queue *queue)
 {
@@ -201,11 +201,16 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 	int ret;
 
 	if (f && !dma_fence_is_signaled(f)) {
-		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
-		if (ret <= 0)
+		ret = dma_fence_wait_timeout(f, true, MAX_SCHEDULE_TIMEOUT);
+		if (ret <= 0) {
 			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
 				     f->context, f->seqno);
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			return -ETIME;
+		}
 	}
+
+	return ret;
 }
 
 static void
-- 
2.34.1

