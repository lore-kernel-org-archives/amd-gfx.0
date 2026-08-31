Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FB8C624C2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 07:29:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8780F10E66A;
	Mon, 31 Aug 2026 07:29:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ja7LZtvc";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012067.outbound.protection.outlook.com
 [40.107.200.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 498DC10E66A
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 07:29:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSEUtpUjh4tU8gBmBL7J0IMfvP6BxQlD+99KN8bBXvrqcJ04svmt1zMGrdKT1wXsRrCwFck3rvKbN/FI8JJkMBrF5TgUvaFNGA2uX0RaVeDl9HVgnaEYJaA2ZDgR24+BlozRXbXcHREC4S50298Uhhm9TtX9l94rzf+uqvzL3vNB6m+Ri3YzttTVN0dsocG3sUyu/SNeWYt0Rwa0n3norP19ltUVgtvTfuH7+v/w4TEs4rWj1iIBKathlGvKLrPb1DSn8l+6eYbtMG4yeJAhvH9BiQqh0p0oioeUzkfEF0u3Ie007nrvwx/tvKNJ8oQZIy4xNU/PUChTKnxUnWG0zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBIdu/PUEy0PmCfIfrD4Twi94vPQynwKgQdfkhQrqqw=;
 b=x3Q6UiEgKiXmREhd/H3IhsZDz4qLrjV1oWY8pgDEuHI3sj0AR5KWcI2DtFy8fIQCDMuIQWkB2inp6iSbbCdaljJHxpbQma1SwllZ7c1jI1Lsv8930IsOq6ViXRNFXtj1PRs7YoHtZVUnBKWVsU3AGp95lRGM7juhypVoSOaL0KAZCA1dmvMomJuNLg9TuGJYW1vOMd6DcKtgDiqNMdTFaRnQBcOnVKXql/mWGvim0USiJ6RANPik/J4I918lyvsx/eWc09310EyorxEQ8Ny/9ewyLIAr0iEjy2QY7zKbiFoC9PIBNAu6uo4/da7F7MCFztUu+7EtCIHZSQdWm8sHhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBIdu/PUEy0PmCfIfrD4Twi94vPQynwKgQdfkhQrqqw=;
 b=ja7LZtvcpvWWuzc54+8TAfHUJ9ocRz9gnq6jOKhMURljVQMHPfGwyZnQn2p56ACcRMFJOdOTxQIeQ7gUresR5/om/cnKX1evSacpmhEUkaJ/Dsqj3oGTVXZIklE58BlhJVLbQgH9dxHgigBOhMuTZnECgwQ8VTcbdW0/BYGMWB8=
Received: from CH0PR03CA0443.namprd03.prod.outlook.com (2603:10b6:610:10e::7)
 by SA1PR12MB6726.namprd12.prod.outlook.com (2603:10b6:806:255::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Mon, 31 Aug
 2026 07:29:13 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::a5) by CH0PR03CA0443.outlook.office365.com
 (2603:10b6:610:10e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 07:29:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 07:29:12 +0000
Received: from main.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 02:29:10 -0500
From: Yuling Li <yulingli@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Yuling Li <Yuling.Li@amd.com>
Subject: [PATCH] drm/amd/display: Fix cursor disable with horizontally split
 planes
Date: Mon, 31 Aug 2026 15:28:41 +0800
Message-ID: <20260831072841.2302952-1-yulingli@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|SA1PR12MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: 01960aa7-bc30-49a1-8d5d-08df07318db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: d28yPm6zaOx+ncEsoGXHlVsiwnfv8b1Fr03naWXUfO8ZP+WLOdAuw9ORsEZmhJxLFYZe3WKXLVSKE7bEe/4JO2IjpZSJljdvjcZBWXqOtkrqI/mRtTD4HRlOcI/kp0gsGCx2c7uB2ZNcxTkTbofZvC5cQiPG3QCfOuJcpIr9xuNsM/IwNIW0Jt6pLn6F8A2rEUkgx6f6phjl9PnIv/KmSybV/iuX+Su7dSGyTlDDOCnyMOPwmiYvZUYjbYe8z0hLnoYqmYJ4Fu1RswaybavobOTwdPBGDZ/ACMXhjkQty0ZV6u30DgRo8s3o5/7EfOGareEWXON1PfQNezFwWF3a0xA186kPCxhcLEtImndRbUwX+7p7dU9q2ipoiy5M2zKzDMYHK23YKa7lBVSxVHvxfRG3Slzu60glTw6LWu9IzecZQVhvmK8GorBWqtWJny1gA1FkVH7SRtA3VN0wQlyI6dPiP4iJU3BjoIa6Yv/SU4hyrLK+Upj4VZ8agujTYXU2zr8EFdA6gN0N3hkf0TUquSZrQ4QgQQAACJ43btyIObNuHc+abcWikzE9JGdebojrDCGQxSo00sO2beexRaD5gk3F2uSTKgYyJagirazaDOrCAiVT/iMv/SlE7fLTilsw0KGpEMB3SEGtTH9g9XU3f6PIl0OHqcGR85l+DsMKoGhxZzGnNhFiBepHUsQKwZ4JaDNaDUlrg59Iu0eBLrhfow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VgtExrWoBl44iJXCjx82NShPhT/lxrpZY1J4wTLLSbizqy6D0x4T5HKEk38v8Z1lvp2e2uFUyWi4Jjq1vQDvkHcLkEy77No3gsvBKlmIL5lJmppEvDqRJhcjzMWaSgNV85WKtnSMWy3n7Dw2j5qGTyrB6jIYHKb6GSeBpxJO4RpLkUQcOFsdU6CoKr95zUPxUF7oxO8GVD08aRJMXl73b0aPAzU8LeqF9B9r4mut3TY0xelttYdS/d+4VkMgGz8BdK4/Wdg+YOWH4Q9FvSYnV/sM/UfLEUR/x9OACQpMoBkfbP8XAsomj8Azf/YdOLZSJpMEATmUCZcZ8Ll8Prsd6NSayE1ihOzJBXZgjOdpsfN0Jneoc2FLohoCdpvtceZOsxmXaz4InM83qy8Xqt+TkhL63xg7NBrPHwuRaNnWEBAnrWKBmI9Y9KWTEKmfblKu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 07:29:12.1764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01960aa7-bc30-49a1-8d5d-08df07318db7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6726
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

From: Yuling Li <Yuling.Li@amd.com>

[WHY]
resource_can_pipe_disable_cursor() disables the hardware cursor on a
pipe when a higher layer fully covers that pipe's recout, to avoid
double-cursor and scaling artifacts.

When merging pipe-split halves of the same overlay layer, the inner
loop walks every pipe above the current one and looks for siblings
sharing test_pipe's layer_index. Because test_pipe itself satisfies
that condition, it can be treated as its own split partner. That
incorrectly doubles r2.width and makes the covering check succeed even
when the overlay does not fully contain the underlying pipe.

On horizontally split or multi-quadrant layouts this causes the cursor
to disappear over overlay regions while input/coordinate mapping remains
correct.

[HOW]
Skip test_pipe when searching for a pipe-split sibling on the same
layer, so only the other half of the split plane is merged into r2.

Signed-off-by: Yuling Li <yulingli@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index ac558e715b72..7bbbe118e365 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1801,7 +1801,10 @@ bool resource_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
 		 * pipe-split, merge together per same height.
 		 */
 		for (split_pipe = pipe_ctx->top_pipe; split_pipe;
-		     split_pipe = split_pipe->top_pipe)
+		     split_pipe = split_pipe->top_pipe) {
+			if (split_pipe == test_pipe)
+				continue;
+
 			if (split_pipe->plane_state->layer_index == test_pipe->plane_state->layer_index) {
 				struct rect r2_half;
 
@@ -1813,6 +1816,7 @@ bool resource_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
 				r2_bottom = min(r2_bottom, r2_half.y + r2_half.height);
 				break;
 			}
+		}
 
 		if (r1.x >= r2.x && r1.y >= r2.y && r1_right <= r2_right && r1_bottom <= r2_bottom)
 			return true;
-- 
2.43.0

