Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2C8C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 12:28:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36F1910EF28;
	Tue, 18 Oct 2022 12:28:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85C8210EF27
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 12:28:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFmeS1OiwzsLp/TgQPyL405ngIcw3nKrRZ2neN6kSNyOZQWmu9gnP8FZnzqCvujUjfA5wNYmzWRBwP5DrBhu4DxVofCfzoWJXlnAT4DOjNQr0EoAalnibkX17Fet4DCTnCZz1XHSiige1b4G2tmqhaJpfDQcsHu+1EzHV0pipHneDQ0aRrdi7zW2DWd0yntu+E5Mm2nDD+hpk/k/wtF9w9CLenwYDq190Rol9ZXp5LyDdJxJVNhOFVq/DJamqjCBM6b6c99oModzDRrIiEbpNR8zDMFpCanxRMIFMN2CqsIByVhar1trm/3971lwKdqLBA/hpm87q8mV4+ZFFsPSuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nS1SEPQuKxXY/RRjjlhVuLAULhIYPXKHvUhKMndCisc=;
 b=ArVueF4GLINa59Vh/tWRJxJkDMAOgqNSDuOyehPs5zLA6tgF6k/TpZGskEvODOF1Kzr6612B8dDd080cdPruBf6TGETWx1CglFrjVb0YcwGj5b0qGL1wyEm7CmAhTJbu92GOcYQAYA0lE0Y5yV6RyUY49A9BBwmgVo/0NZGeFPDXPJ8SfDy3XN3qoBSsZjv5Jsyih/qoz9fLK/8V12s+qcA8ZE/AYN35POaT+xRxXVLLw/nm2Wjz2MwklFswbWTlhurlssqqBhd9JYwFn2fOhedMG0uU08r+/kB/j/WkOhu18ev1nXMMzXnv+nUw391s/YlqB1rePRmxM2NpUZFTHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nS1SEPQuKxXY/RRjjlhVuLAULhIYPXKHvUhKMndCisc=;
 b=XyWGegn0tAg0BXVtSbXZSFIfj7iqASuWugjAtjbOfuDls8H1QMXL99UNYY+4+iEBgyHFAQqn6rD9P5xBpurhTr5kSLmjiSIHOHrpyt+U6YAVIGK9VIUbVtfgs6VxKb87TyBJ6EfjGXUc/Jthzo2Epp9mnYIGCUbE2Rzr7oojOZs=
Received: from DM6PR18CA0009.namprd18.prod.outlook.com (2603:10b6:5:15b::22)
 by MN0PR12MB6318.namprd12.prod.outlook.com (2603:10b6:208:3c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 12:28:09 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::10) by DM6PR18CA0009.outlook.office365.com
 (2603:10b6:5:15b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.28 via Frontend
 Transport; Tue, 18 Oct 2022 12:28:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 12:28:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 07:28:08 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via
 Frontend Transport; Tue, 18 Oct 2022 07:28:03 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 04/12] drm/amd/display: Copy DC context in the commit
 streams
Date: Tue, 18 Oct 2022 08:28:18 -0400
Message-ID: <20221018122826.1790114-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
References: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT046:EE_|MN0PR12MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 4afb3fe6-fa44-4321-9672-08dab104377d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jlEN7eYtcZtMSFWv4y8J+zYnMZylc8GQIheaB6eLFeLOSvsSa7VwNls/VI3QXbMZxU/smjBWH6ge6+ckHfdFWtrUlc1IHGFvzOHEX3RpmyO7e9ljgbBiEtSTz99R/4EESJizALUliCtfUnr4BMKy0hjpORoyJ4UvCp65joQo+UhhTuTWrqdqPidHmhv7haVAnGZvi7DKeExrayCIlPMR2uonMntefG5sAqS8YClp1pJsdQgrjn/X0/lNE+ZntcUJxptQiOJnwnH6UGlGvMEtGgYaCNAu2ZO2vaklh7cLhOmLL2J5jwy9aVHZk6LSM7EPn4CIGvNbLwhM5bcRZNPZUAnldPWLHcA+5bEoTVcG5shPWM0qbIvZm7ndWT9ZQk3ANNm+RswMOwFkaZeCUuI5s4WcErGGnu0Upumy8UTevIqHqIdb7UMirxTpaZCsLWKeEc8ox73G9Af+CWtBHnLKmSXbLZiRluLFySjYX2IVJ/cIWmr+5JTvY1ICnSco3hZ6cSslJ07PJhylHQ7ioLnp+7NAVo7mxOYRCQCwap6L+5vNKC6Ys8dGZzzvAIqAa2o5FXQS/fTW8q3pSPvwBcoH0Rqa6z2KLE96PqyRbIyPKx/6DxeDgcsb+JZV84QonqKknjRv1jYdl/NdVhoWhuCfea9gy/v98CLkoe3I+3S3QnL0vki4q4KO2/UHQanvHmuhgzyloHqxIlV23q/xGS/OTVWUNhmLZtsHwFmL9NZtrvF5NUIdH7pIi8NJb7LnSjFTtnNG7LO5y5sS/6J1hs+r9fMt9K/RppWHe5h/E4/0m++EAlqNv31ymNegknBP0hx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(2616005)(26005)(36860700001)(1076003)(186003)(426003)(336012)(83380400001)(478600001)(47076005)(5660300002)(40480700001)(40460700003)(6666004)(6916009)(54906003)(4326008)(316002)(2906002)(8676002)(70206006)(41300700001)(8936002)(82310400005)(70586007)(86362001)(36756003)(81166007)(82740400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 12:28:09.4684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afb3fe6-fa44-4321-9672-08dab104377d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6318
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DC adds an instance of DML (which contains VBA) to each context, and
multiple threads might write back to the global VBA resulting in data
overwriting. To keep the consistency with other parts of the DC code,
this commit changes dc_commit_streams to copy the current DC state, and
as a result, it also changes the function signature to expect streams
instead of a context.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 41 +++++++++++++++++++-----
 drivers/gpu/drm/amd/display/dc/dc.h      |  4 ++-
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5d9e9e8f87d3..af81c2835738 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1890,23 +1890,44 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	return result;
 }
 
-enum dc_status dc_commit_streams(struct dc *dc, struct dc_state *context)
+/**
+ * dc_commit_streams - Commit current stream state
+ *
+ * @dc: DC object with the commit state to be configured in the hardware
+ * @streams: Array with a list of stream state
+ * @stream_count: Total of streams
+ *
+ * Function responsible for commit streams change to the hardware.
+ *
+ * Return:
+ * Return DC_OK if everything work as expected, otherwise, return a dc_status
+ * code.
+ */
+enum dc_status dc_commit_streams(struct dc *dc,
+				 struct dc_stream_state *streams[],
+				 uint8_t stream_count)
 {
-	enum dc_status res = DC_OK;
 	int i;
+	struct dc_state *context;
+	enum dc_status res = DC_OK;
 
-	if (!streams_changed(dc, context->streams, context->stream_count))
+	if (!streams_changed(dc, streams, stream_count))
 		return res;
 
-	DC_LOG_DC("%s: %d streams\n",
-				__func__, context->stream_count);
+	DC_LOG_DC("%s: %d streams\n", __func__, stream_count);
 
-	for (i = 0; i < context->stream_count; i++) {
-		struct dc_stream_state *stream = context->streams[i];
+	for (i = 0; i < stream_count; i++) {
+		struct dc_stream_state *stream = streams[i];
 
 		dc_stream_log(dc, stream);
 	}
 
+	context = dc_create_state(dc);
+	if (!context)
+		goto context_alloc_fail;
+
+	dc_resource_state_copy_construct_current(dc, context);
+
 	/*
 	 * Previous validation was perfomred with fast_validation = true and
 	 * the full DML state required for hardware programming was skipped.
@@ -1922,6 +1943,10 @@ enum dc_status dc_commit_streams(struct dc *dc, struct dc_state *context)
 
 	res = dc_commit_state_no_check(dc, context);
 
+context_alloc_fail:
+
+	DC_LOG_DC("%s Finished.\n", __func__);
+
 	return (res == DC_OK);
 }
 
@@ -1937,7 +1962,7 @@ bool dc_commit_state(struct dc *dc, struct dc_state *context)
 	 * we get more confident about this change we'll need to enable
 	 * the new sequence for all ASICs. */
 	if (dc->ctx->dce_version >= DCN_VERSION_3_2) {
-		result = dc_commit_streams(dc, context);
+		result = dc_commit_streams(dc, context->streams, context->stream_count);
 		return result == DC_OK;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2e71781f155b..6adecb62e534 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1321,7 +1321,9 @@ void dc_resource_state_destruct(struct dc_state *context);
 
 bool dc_resource_is_dsc_encoding_supported(const struct dc *dc);
 
-enum dc_status dc_commit_streams(struct dc *dc, struct dc_state *context);
+enum dc_status dc_commit_streams(struct dc *dc,
+				 struct dc_stream_state *streams[],
+				 uint8_t stream_count);
 
 /* TODO: When the transition to the new commit sequence is done, remove this
  * function in favor of dc_commit_streams. */
-- 
2.38.0

