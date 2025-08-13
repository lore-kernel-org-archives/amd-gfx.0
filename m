Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33771C87FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 09:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F7B10E69F;
	Wed, 13 Aug 2025 09:00:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Oo5CkK/O";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8228410E69F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 09:00:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eiDNEn4EZcEFXQ8ynSKHOtWHtjZy/LgCxJYQTasUaIvwi3w5BVofBdQzZuyhYGCDtf9nlijY+QcIYD7jHXU9qHMDT4zDEqVUH8oUKPPeG6BswEsew3gEDcCTJitL1vPLj6NGMyzQnicpZdBlOdL8oTxUUtDbj1kqrCl9KcMvFvgVN8/tUB2MvwdsUcqmP6cAaY6cBXPKKBiEpPUataguUjGQN5/3ugPpxJLfH7VdDlMkJ2pzpDC0ezbsHa1WwcAeae2T9MAlIbZbnkMBHumtzSdLn6vvAlp1HhoIRU22hS5C7dxOTX3jTbQN84rcSYDQXbEVrMdthKV+TN2PjDU71A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9r821jOHZi9HMrIWLjikjj8C8ksokDx7VrXPGdXduW0=;
 b=YDpDHDaTOPbzhA5cU23+xh3TlJJjUWUHKcQglfNEZBIwEbTYgAfKRAfM+BkzlzCNSZL3pFgAxGipedfUSXkl6n9iq4vU9CPsFO2Z7BJovGKW+AO9ooZ7tQAsJc/HTGTVuNoISVPY2QuPRnOxbRqHjHSzzc0cLKcrvMU+EOtRxsg0mpMoU5bhKUNgHBYb/4EV2l/IFAuYXGYJUfwnrBTD6f2BpKwpJpg1YXo33MNnuH9FtOJBHtbtKiqaU2poyMTlqS7WSLKOrJdqLwK1Jzt6P9tJSBkdONaE+jpvXUffKwOXgaJAhqD2B/9qK+Yxt8kZNRMdJSH02wtNhpSwmL/SJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9r821jOHZi9HMrIWLjikjj8C8ksokDx7VrXPGdXduW0=;
 b=Oo5CkK/O1uMO6D434r8bWNFXi5ok+xLpx0WrD3lO9HLVx8/8Bym/63PCdKwkMrqc5Tlp4FfWRWZSX5gvJX4oEqptpgh/c+hCVKbZVL+vG5f3O4kDE54toNz+Puvr+Y0wn04kr2LMu82YeB486Yz2zPY+LFmg5YthyKG02OOtUhM=
Received: from SJ0PR03CA0082.namprd03.prod.outlook.com (2603:10b6:a03:331::27)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 09:00:21 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::e0) by SJ0PR03CA0082.outlook.office365.com
 (2603:10b6:a03:331::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 09:00:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 09:00:20 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Aug 2025 04:00:16 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Alvin Lee <alvin.lee2@amd.com>, Ray Wu <ray.wu@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Roman Li <roman.li@amd.com>, ChiaHsuan Chung
 <chiahsuan.chung@amd.com>, Harry Wentland <harry.wentland@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Jun Lei
 <Jun.Lei@amd.com>
Subject: [PATCH] drm/amd/display: Add NULL pointer checks in dc_stream cursor
 attribute functions
Date: Wed, 13 Aug 2025 14:29:55 +0530
Message-ID: <20250813085955.3648783-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: 7149b86c-c452-4e30-05b8-08ddda47d504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z2SFDBKQfBi9B8FTrYYRDBqurHk8UMMvXKj0WeruxTR0poHS6xeXRCQrgkw0?=
 =?us-ascii?Q?GeUH9zdtiIse/Sa/UqsjkT21qYXO2JIs8NQOUrsYSexpMM6B6jg0fnukH+Jx?=
 =?us-ascii?Q?eyxq2d4wPU+t+uDsW8RS+GyAafd3D6EqgxbLMbqBXMcNic45QQeI9iwUcjRg?=
 =?us-ascii?Q?tUh7uWPyGVb4FpNxuY41RHGMeJjjImu1GQLZlM3/KIgzBjEWZAtn8Wa+efO4?=
 =?us-ascii?Q?m1PG5Ga2B8t/6TzZgFJxgNv5ZlTFM5FJEXwE/+uy6rv3mN5LZWJzu1JVQ3Nz?=
 =?us-ascii?Q?mtTsp8frazlblFIyRDiSj4GvIfksD98vjiY1OBwOeYbGwR324Rd4preVy6EC?=
 =?us-ascii?Q?lEVaVzT2oaC+uigPSNWPr0ddCz4vm6D+i4DAgVI+fypSxhR+w5kjsCbNRkyn?=
 =?us-ascii?Q?etgm5AwRXqPXAKho3TL3pSOWv6pUYLWHmsqEEwlEXsYNF19JiQM+EenpjEaW?=
 =?us-ascii?Q?yXkstkmwV3V5q10DWkmcHT/haA6godMt1TijnEQ5oKzeiysbUp8BeKbnk0NA?=
 =?us-ascii?Q?6H6kBO1EgU80x6a8P/SI9UUE8gaUS5EfQvS4dvDet59/85LvvbqvTZrg6ghx?=
 =?us-ascii?Q?7IqdhCuI5wOLnVHLNLrxfzke9qoX6EbohYzIgIX2ur46YqIzWQE+PThOxQes?=
 =?us-ascii?Q?/dPZXC+Trtb0U5aK1SLnw2R+wanYxPAhhbG/cOy0Adt5tI7rXNv5ILqztiol?=
 =?us-ascii?Q?DUl3xErpZLC9187w8LgVpzQYUDcBdy+61h8BhZYMJT7qqsq/Ib3MDSC84eXZ?=
 =?us-ascii?Q?ob7fi2QChjCT0uZKh0ESQu8sepeA25OlF2UvbTLieQPeoK/GxW+YSzuPjeE0?=
 =?us-ascii?Q?1gm3dgtoE9dpsWxGyZVUJ7x9cdKqgF5efa/sZGORGjp5aJAgRBGqWlKkLJsl?=
 =?us-ascii?Q?oaJvjP9bxkGBq0M9TBB73IhBRUOVPLtmkRcQyCJ/loRKaAQsQuXts3fXL6j0?=
 =?us-ascii?Q?3rr7Rk9GXbHOiaIktayevztK7q/eSsAFvSlzKpf39GT7t54og9nPJigh5oV4?=
 =?us-ascii?Q?P2Lc2sq8sJmXpcWudmJAPA96QKBnzOs3ooBmq+Wfz6xKHB9sWtYSR5e+a7+p?=
 =?us-ascii?Q?yAWgwT3/DQW2vzGEkV1jU3CXUOzXP+AR+Zk7PrlA3R9YDQIs7L0/SGkzZUCf?=
 =?us-ascii?Q?wJqzPWH+rQktm3CAEtp8bCt00y5ZeCILUmFg0a6hcJaP6A7iBkttamvQ1awD?=
 =?us-ascii?Q?9bNNFg/hjWsD+7GrI2EarNLNY6AKV4Ts6qwnxQqAoL2IQQ8w0vP/XPDWogDk?=
 =?us-ascii?Q?4DvbV1TrI1i4BBVTMBbcqBKWB9p6LeMtauqhKGEEBZAde6XlhOKEcfvSa5Ty?=
 =?us-ascii?Q?qrl7QcytOfYzE0sC3VzpkBfGkRI+x05qHjbUnOO2nKqMQ0o5Thu6Bbxr7A9W?=
 =?us-ascii?Q?hKyXzEKUZQUblR9cqGL44aB2csNRlUsUGp4CtrdUnTbFTIYB6BpKUELSKKur?=
 =?us-ascii?Q?t+HgvI/GNAZaLYqKgt3MOkbBW2bvteacvcaTKqH9275MRYM7GL9hMqprdFRB?=
 =?us-ascii?Q?HcsWTcaZpw7fmb3/OWrcJmguVqZv4ZHqo8lf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 09:00:20.6477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7149b86c-c452-4e30-05b8-08ddda47d504
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125
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

The function dc_stream_set_cursor_attributes() currently dereferences
the `stream` pointer and nested members `stream->ctx->dc->current_state`
without checking for NULL.

All callers of these functions, such as in
`dcn30_apply_idle_power_optimizations()` and
`amdgpu_dm_plane_handle_cursor_update()`, already perform NULL checks
before calling these functions.

Fixes below:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:336 dc_stream_program_cursor_attributes()
error: we previously assumed 'stream' could be null (see line 334)

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c
    327 bool dc_stream_program_cursor_attributes(
    328         struct dc_stream_state *stream,
    329         const struct dc_cursor_attributes *attributes)
    330 {
    331         struct dc  *dc;
    332         bool reset_idle_optimizations = false;
    333
    334         dc = stream ? stream->ctx->dc : NULL;
                     ^^^^^^
The old code assumed stream could be NULL.

    335
--> 336         if (dc_stream_set_cursor_attributes(stream, attributes)) {
                                                    ^^^^^^
The refactor added an unchecked dereference.

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c
   313  bool dc_stream_set_cursor_attributes(
   314          struct dc_stream_state *stream,
   315          const struct dc_cursor_attributes *attributes)
   316  {
   317          bool result = false;
   318
   319          if (dc_stream_check_cursor_attributes(stream, stream->ctx->dc->current_state, attributes)) {
                                                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Here.
This function used to check for if stream as NULL and return false at
the start. Probably we should add that back.

'Fixes: 4465dd0e41e8 ("drm/amd/display: Refactor SubVP cursor limiting logic")'
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Alvin Lee <alvin.lee2@amd.com>
Cc: Ray Wu <ray.wu@amd.com>
Cc: Dillon Varone <dillon.varone@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Daniel Wheeler <daniel.wheeler@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Wenjing Liu <wenjing.liu@amd.com>
Cc: Jun Lei <Jun.Lei@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 4d6bc9fd4faa..9ac2d41f8fca 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -316,6 +316,9 @@ bool dc_stream_set_cursor_attributes(
 {
 	bool result = false;
 
+	if (!stream)
+		return false;
+
 	if (dc_stream_check_cursor_attributes(stream, stream->ctx->dc->current_state, attributes)) {
 		stream->cursor_attributes = *attributes;
 		result = true;
@@ -331,7 +334,10 @@ bool dc_stream_program_cursor_attributes(
 	struct dc  *dc;
 	bool reset_idle_optimizations = false;
 
-	dc = stream ? stream->ctx->dc : NULL;
+	if (!stream)
+		return false;
+
+	dc = stream->ctx->dc;
 
 	if (dc_stream_set_cursor_attributes(stream, attributes)) {
 		dc_z10_restore(dc);
-- 
2.34.1

