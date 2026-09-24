Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF45AC98324
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FAD010F726;
	Thu, 24 Sep 2026 18:46:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="egP5OgDP";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D9A310F72B
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCG6jBEc+FvWkYaQB46t3L3geet2Hb7Q7oc7dz+9mmcG8zOykgHYq/i/roLvItsP9YAKQI2eBRRtxO4dlF33iz/TSshQMEY7u6eLcZ87y5VTM+BalbqQROZUjg4/GGe+7dziKu/+46J7cDeZV8FeLHkMRe8j8pkDvEBIN0+gZ3osm0Arq/SsRWWJpvGellOEjlKOUE+2WexLwEyB00MzetsomE7NV69MBOizSp0Dsq2CueD19G+nOxmXpar3WWuHYw+HZWY5uKeMGBwZ3JmGwFcr9N2jJEujE6752y0W9SWcbIiLQOtcyT1SWPsibblzpjeORQYWseeHkiuoArh1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dqy73EkIfHy3pG1vHADxnBms6aGu05XPqK5IVVuvifs=;
 b=agfz2+YzmT4icbdorhvZLGS8Zn0Cn/sxQZxpNPeYMMDyjm2bXo9WfB5zTsX+N+QEldOzOKPf0HsJEcX3+KFgqwqlO2oMDzRDJg/VtYiYJjXfRkKOoFYnVKQ/sd0m1SidvfkKZykGFkCT+YZkMfc42dHevyC9NFg63gtXf81WHY96e24o9FSCFJlKeNi6otE0PRQbvtVn4aMXTlQUUs0UUI3H05KOFPM1Dhkf9jmvdWOr3xCvDqY+j1YixLG4BRhPqtx+TCH70KX9MbSWyfTV2MqI7WzgnJFLQWhLoZpw7ssoEmfjEHShZ79FMNe3/NTkYAgXzAdBYVkAsostSR8t9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dqy73EkIfHy3pG1vHADxnBms6aGu05XPqK5IVVuvifs=;
 b=egP5OgDPujp6zb2WPzeVsowmslUFi0ZfFZ/auo9tvYafAeaiUMTe52cRZX8vf2BsjuzRoRW7jgg7R5CXI71dMWSto2hidzu/E1+W0SV6zO75ByFeIfw4mtH3PQBZ6qDiEBsmi4liZy6U0nA5+dwJOf4i8L/IO60CMbuBjNaQk1U=
Received: from SJ0P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::10)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:46:16 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::84) by SJ0P220CA0002.outlook.office365.com
 (2603:10b6:a03:41b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:16 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:05 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dominik Kaszewski <dominik.kaszewski@amd.com>,
 "Dillon Varone" <dillon.varone@amd.com>
Subject: [PATCH 06/34] drm/amd/display: Add missing message to static_assert
Date: Thu, 24 Sep 2026 14:45:19 -0400
Message-ID: <20260924184824.596894-7-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|SJ0PR12MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b58235-cbc0-4e04-db6b-08df1a6c1d63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: N2VFlXzFY5xrO2b6JQ9vqQqy15g5CFB5lc+E4vpcF5TX6Au7mVUcAx3Jc5no+uOgjQSpOVZLJHWruDSMaIL3ciQ8te5K/rZhdTgYMi+0wfQuCtyHzdmE9/p9uw74+XcGGbJnLLtjE2BodTtW8fo3iC4pQin9BV/6164aPcFA/4/fVLjdAKbDtxe8g0zuIi44PmE9P6oiAt87CVQWhi8DPFDpctjY4m6yFAsNSsnvTfncFvZfcdTFdGR2Kxba3TxTxABsbAb8d+vJ6yXZiEoA6VJlPiWjTAgenibW0dB9eAmF3Bn1mSMnU/uijp2qDXZtDeIWPlvfPTxyrSbJ0hp1hlhqAiW31TVYpfEJ7tmR4lK6WI4hjpdfo10r2izjLD2XXvim/bt3WnVQ3UM2gs8U3y4M6JLWFlDPN5wtVeigv5iDfs7MaESX2s4AqW/DObPxLGqyKTBoMwc9j/QUMP/02OV+d0BPDCcwrb6ZeKfUG2XfENOERhsWfR31UmnhFADvSaOJWaSQ8xoCibxEU7ohqeQOalLWOxCq+rYRc5PUtxWMuQOdOvsz4PKm9wmwaMMA9Fb8zR690DdeMqRuhTuWeYH66ZJrQaZA/7a8zVebu+4cULp5lrCDXqPDBkALc8LW5DV6ew0uKCxfJLQDce5ulpAqXLIpfh2Gy8XNG0JEAk1y2W6VDRIBwr/005ZmNkiKzTU6mwslqGMN8Y+Lgr25CQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7/j9UNLMEzDWQywvUDeGoOiH2mUOVbg1WJAnlZVF7+0Wdf69XLyerBKurrG+u3uYnYv9bNhHbCtQUQqrks/qbMW9AEfB3cKWjI546Himg2Y/HCUFHfEPSV0hR9JuhEkQpgEqWwzmFRrGp+ml3s8W6/YC2sp2M9NOUqtXOEWdLwktPYDV746xjMeApCH7o2RViyFSzNNkQbytMlaqBuyv1a/YVccjLNl8qkluflaYyKHqUOUOhtRQxGfef1PX/bDIgk3RMbBiu9D2YZ8nedCWK5mOgNWfryJxhD/1oI+3uv/IQT++KlPaewmeG/B+w+DhqQydba5bIgZgxry9ZLDJyPH173JvC8Bj5PmzFpjMgStgPIcIZK6Wu8yasg/gqUBzvyxuEqfwot2AbgltQv6J7mKnTeFpJmXKzrsoHA3h4UqxB5XdvmQiYupSyA5t/jKC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:16.0501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b58235-cbc0-4e04-db6b-08df1a6c1d63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459
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

From: Dominik Kaszewski <dominik.kaszewski@amd.com>

[Why & How]
static_assert requires a message in older standards.

Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_memory_pool.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_memory_pool.c b/drivers/gpu/drm/amd/display/dc/dc_memory_pool.c
index 904f8c4a4783..6557bc9221f3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_memory_pool.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_memory_pool.c
@@ -58,8 +58,14 @@ struct dc_memory_pool {
 	char _reserved2[PAGE_SIZE - sizeof(atomic64_t)];
 };
 
-static_assert(sizeof(struct dc_memory_pool) == 2 * PAGE_SIZE);
-static_assert(offsetof(struct dc_memory_pool, free_head) == PAGE_SIZE);
+static_assert(
+		sizeof(struct dc_memory_pool) == 2 * PAGE_SIZE,
+		"dc_memory_pool size should be 2 pages"
+);
+static_assert(
+		offsetof(struct dc_memory_pool, free_head) == PAGE_SIZE,
+		"dc_memory_pool free_head should be aligned to page"
+);
 
 static size_t divide_ceiling(size_t x, size_t d)
 {
-- 
2.53.0

