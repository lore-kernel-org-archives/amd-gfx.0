Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A036CD98C6
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 06:25:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7802610E709;
	Thu, 11 Jun 2026 06:25:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2YcII7VV";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011051.outbound.protection.outlook.com [52.101.62.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A395210ECF1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 06:25:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I50YG2n+kp7B4bq7eOf/WOA+z3Bn/8Utzl1anze7wzd27G7eBfUnuQI3ttIgz2D1eQfKDR087ft3AGGahyf+XgbSJLbug/8lcGvVY2Bueaq0pVtyTG7PgW0Ps/RfLThyEIXGn2ws4sj42zB/XrUvq1onRdBDUEYvcyDHfRADUuduJ9FbX1YyO26gwtdmb0qTdgTt36kcKYVgz5LR61HsgiL8ZrUooJAGp/esWFsV5YnnoWgjyhQh3D5Lp6/0dXRGdmUOJNcVY0HRX/A62zMVKuqjG68z1jv152a4+m7Lqgf59s0xw2S+Vv80FCDT3FJjtqEN0bwJrLuD8d7C0QK6rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUFX7AJhdzLKmj2s9AvlRAEjq8rw8+BlGWBtiONSkTw=;
 b=lip1ayNHu5zGUFA96ZvRrDoKU5ktAW1nj91sfWlgawvGWGs7kRfjlDq48keB1sAZU7Lh/8hJix4uCr1Iof54WHPU9hIQipD3Q6H0QEOe/D5hMFJD079y32V5YHLeDbNjjOoXFfZE/MIYahVN7CRQRo7H3dCHisKJipN0NB/ROLXcbgAshNqtV+zazICzcnAr4nkZuJyEuxzXb0eL+xZRXxNoLVPjZU5ARTL9oKfLzkI1Q2uWsIq0RKZfUbcV5Ht62Vy+vlyP9UTm/oNG4UaU0V2t1wfh6AqSjCKd9n1CYMlHieKCicZMBaIwLksgUeW/UghPZDj+v4H3xFUUn6khtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUFX7AJhdzLKmj2s9AvlRAEjq8rw8+BlGWBtiONSkTw=;
 b=2YcII7VV8H8g+qI9OB/lqBdb7J1j/q0+o+K3Lt2s4zLaCx8s8IPJvsz6jQgvYaILQ0iN7muAsp9wQm5KYQscggTDHOy87rnrpRa4+1onsiKEhDFNjWECz+NBus45deA5ATiUc6mXRLWcsImSntZl7XhpdtdDpKW/ogkEd3V4bVI=
Received: from BN9PR03CA0650.namprd03.prod.outlook.com (2603:10b6:408:13b::25)
 by PH0PR12MB8128.namprd12.prod.outlook.com (2603:10b6:510:294::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Thu, 11 Jun
 2026 06:25:43 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:13b:cafe::2b) by BN9PR03CA0650.outlook.office365.com
 (2603:10b6:408:13b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Thu,
 11 Jun 2026 06:25:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 06:25:42 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 01:25:42 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 11 Jun 2026 01:25:35 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: report reset in amdgpu_ctx_query() for per-queue
 resets
Date: Thu, 11 Jun 2026 14:25:14 +0800
Message-ID: <20260611062535.912240-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|PH0PR12MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: ca466e91-223b-416b-23c6-08dec7824397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 73aJCkRY9GBxmkwiLLx4j/+Jfg1Udx/p0CvE4xFgl4HGPzujX/SjB9qtbz0YBcn/M5GikU9n14mHc1HohWnHtNvgmilC27qXBA+LT0dHJlmkmGOHtBiSChBQydGK6JDvTg09V1+nL6oEfqoy60Rq4RbQB52/dyze04WCnMF5+xCytbxEdPKTNiLGhF+fWe/X22vf14IUKyqt4+FJagq0MD6/bf8Ib8hHHbglltib8SaGKPO1kDBFmF80wMkrriK3BSjSS7dAc0q5WyT2hyWb9EmJ7UUrgk3NTY+6RnoWkqJY7vi6BoSm8eoCi6lV9j8TI0X508nY/cjF45i2KXzeTGEsush65HQSkXHtK/KkxYGvL6WxX7FkWf/v8wSQg4MTRDBNWsupz/orVWexSRCX5QOp5XG8yEBh8adLclbJkj8BbDjTj6G3gWPKNibDwhFj+8pmMmI8k5aZU+wVheTS3YrxCD1ljMXw62AfEmU63/P4JNf0hrlv5PQQ00ntIX4xqB6OrMM7X8FLDshG8TRAkbm+o7l8UbQ7qd4naXm5wfhn0LbDngYqVGICjpVf6VydB8yAvd9zeC5IIfJd2k/U9BLtHlsHX69nHx/MP8jeCI59DYO20vw58/TJjCNO1xqE6MAtU+3h/yzAeidCzdIgwloawADDGOWmZPd45m6M1zPCmq0DRhxYPFLjtCusmhHAkTc4wtBbWdS8X6BwMfBm7mpDQ5C0ZKx4a/CYvIXRHTQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 90NbqsgsD397Im6BhU9r+D24fKZ2n4Qct1q7bbp7FOKWWyxAC8y5/V+BWeEk+J7gsG+ElDN7ytcNCZgbhIADNn9Da7UKWJN0ZJy/L0UFnfkx+5+6OpVp2+0ZRLnLP3pBtuDemCFps/pn787x3r631CWa3SFQ57bE0xf2GakfyUf1cUXuvHyF180QFI99+7LF87WKkNNlk0U8Lm0jzQAn8Noi6dHP9wxMhTwKxgQMzeH2xC72XwAVdrhXfWfU8++N9jKHQc/fE16pra+5RNmOg1CVt9nT7KnhXCxrvjrvuG/sG6sTDQ9zB/odQwMXplg6+IuIfllu+8taNOnbO9SVZ3yAGTkyuL6M+pmRQhiakMNH9G6Ob+HxlpJKUqDCw/RMnWdsHoRGUZ7JrCB/9cwxafPrr6agh7c2DLa8SKccUL9RCJEaQuTo4FfCn5mEBnRD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 06:25:42.6417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca466e91-223b-416b-23c6-08dec7824397
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8128
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

amdgpu_ctx_query() (CTX_OP_QUERY_STATE) derives reset_status only from
the global gpu_reset_counter. A per-queue reset recovers the guilty
queue without a full device reset, so the counter is never bumped and
QUERY_STATE keeps returning AMDGPU_CTX_NO_RESET -- while QUERY_STATE2
already reports it guilty via amdgpu_ctx_guilty().

Treat a guilty context as reset in amdgpu_ctx_query() so both ioctls
agree. The reset path sets the fence error (-ETIME) before signalling
it, so a woken client always observes guilty even when the counter has
not changed.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index d54cec3e4a53..351c19d2940e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -542,6 +542,8 @@ static int amdgpu_ctx_free(struct amdgpu_fpriv *fpriv, uint32_t id)
 	return ctx ? 0 : -EINVAL;
 }
 
+static bool amdgpu_ctx_guilty(struct amdgpu_ctx *ctx);
+
 static int amdgpu_ctx_query(struct amdgpu_device *adev,
 			    struct amdgpu_fpriv *fpriv, uint32_t id,
 			    union drm_amdgpu_ctx_out *out)
@@ -568,7 +570,8 @@ static int amdgpu_ctx_query(struct amdgpu_device *adev,
 	/* determine if a GPU reset has occured since the last call */
 	reset_counter = atomic_read(&adev->gpu_reset_counter);
 	/* TODO: this should ideally return NO, GUILTY, or INNOCENT. */
-	if (ctx->reset_counter_query == reset_counter)
+	if (ctx->reset_counter_query == reset_counter &&
+	    !amdgpu_ctx_guilty(ctx))
 		out->state.reset_status = AMDGPU_CTX_NO_RESET;
 	else
 		out->state.reset_status = AMDGPU_CTX_UNKNOWN_RESET;
-- 
2.49.0

