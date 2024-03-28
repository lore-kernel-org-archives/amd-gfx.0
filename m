Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCB5CD128D
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45A6711253C;
	Thu, 28 Mar 2024 19:52:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BGxLzV9j";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC84510F751
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:52:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHRbP2BYakoUrd/OPtIWNj/TiD9v1jRaQCJq6a81vLX0Bw3OHf+FBmctaCiVHTBaYTVaXskqrYg1R+eZMeKNJl2NtEGtxLlyDwI3NKFkFKZe+7XBR2lIQ7LDxfPi2PTWEb0TE4bY92prPn4WrO92K8LxO47dUYijuz5mqBjzp//6l+tKQCSuxZarJsARuIFZxcSfhw0bPUG22djFJn4NSCJw9EUpcB1XFiwfS3EFwOQi5wPZS9s1NrgxvJ6Qc7TIZrmmbGMqwdyJolgGAUp5LZMvgP3CusDSlflainE+4q8U97j+RIeQ3oRazGC43cNbymYHj4hOpWtf8zEBFmGhIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypVBwriFQUP8XeWFlCz63bo3V3cQA8babSrZ2ZUb420=;
 b=cbYxWShPfYrN5UMVQo3XcvojBJMR3Af3zCN/N47+Ml0PiwhleiEFDyb0VeU7SxU+Xlm2B7imXr5enizlMSKEnkCruC9133WZVTgWnRA+c5eQ3ZrFUHcsLScQUWMC42UhmejjYRjgN4s00YRgjCiDPlJx45EctP//enlj0qCrtz3pkPjd6xYsFeNAuQ/TPzqiJ5WAZ6CDVMig2bwKbMwF9Otr/QQ8K5tby1hyqtv8UK9RASb1tZc20gSBoGtzR0C1/zzHc6gIhytNM2i0BQr77C5Y69fBherBadudhiXAoHZrMKzhjga4bt3de/rGeXeGX8y6bOLn6xtV2sDkVws40w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypVBwriFQUP8XeWFlCz63bo3V3cQA8babSrZ2ZUb420=;
 b=BGxLzV9jGG77OZg+ZHzvmbYrx+Crkdhh4bxB7EKW/onWe8K8un3+hdyMgZ52vFvd7xlUUgEBCfNc/tcEj1DXfF7y5juCZSJMW1E7Vx5X3VbZYaUnEIdjtgKy5DAeP4oKXstNfuVj16OOMZiT6F9eC2wHLSWge0yNyN4+1kWODj0=
Received: from SJ0PR03CA0345.namprd03.prod.outlook.com (2603:10b6:a03:39c::20)
 by SJ0PR12MB8166.namprd12.prod.outlook.com (2603:10b6:a03:4e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.30; Thu, 28 Mar
 2024 19:51:57 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::5f) by SJ0PR03CA0345.outlook.office365.com
 (2603:10b6:a03:39c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 19:51:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:51:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:54 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:51:53 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, Joshua Aberback
 <joshua.aberback@amd.com>, Jun Lei <jun.lei@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 22/43] drm/amd/display: remove context->dml2 dependency from
 DML21 wrapper
Date: Thu, 28 Mar 2024 15:50:26 -0400
Message-ID: <20240328195047.2843715-23-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|SJ0PR12MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: f06dd3ea-ffa5-43fe-2949-08dc4f6085be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oHAm5OH6X6In9fLtnF/la2oZvwY2/chdA5sNBPSur6vEFBMuZWtGRE9cF8p93B52jQAcvBhJj5FgL+/gI6b9s1NwRKQfnrtxKBvTaU9WFxwyL6QfV9PVsOW3DSwcp0cjekRYKdicWfbc+xgWwla5/ZzLBv8GpQDJVL+olJf5Y1MXjRKBCduVIlybbOSpHp68ltBNbhvU3qKdhPi48dWwU3rXl4mRxYAM3MiiGVGCTQFFqRlYfR8ZhxWLMHM84wfNnLFr7nDCAtoEnAviNpPvhnv2nphO9CynjtF2D2za2F9V5p+LXG9X4wuK9X+Ah0u4jLuxkFkt9Ips29JVoE0oGE24a3qJbW24dTj2fLxfYiYl6v/SFq0aypvcxykcCC5RRJWREd9W/yW5r5TOjsbv769xpI1+wQE68QQCWyo1V46j7KnonWuAfwu5wLldnYtwz+4wIaf/hAMUzxhiwQAt0KO6SuQE1uGSU5ix+ZyQZdRp9XYwUsT33WJrgsC3vG5eCrNtAmlrQzTHsBq4MIrg5yMSR8oZKJzBIg5EkI2Qdtn0/5qfTfKnTHfX9oriCUYQL2Zee6Ta+bDZRr5sYAmjZT2uTgf6f1+q7oF31RSB81hNkMpFZMfmmNG4V05bUmFQVU4P7XCKbaiPGXDT3wl3VYO7hUYUIZ1ApcvfblCKE3QMpSAtwlHS2sU/9lzNya3gYVmjuKIyU6fV4m/vc4Og+Bpza0VykGVm9CoYvJ0mt+r9mml1XsLEc0YLC1WiUYA3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:51:55.6867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f06dd3ea-ffa5-43fe-2949-08dc4f6085be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8166
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

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
When the DML2 wrapper explicitly accesses context->dml2, that creates a
dependency on where dc saves the DML object. This dependency makes it
harder to have multiple co-existing DML objects, which we would like to
have for upcoming functionality.

[How]
 - make all DML21 interfaces take in a DML2 object as parameter
 - remove all references to context->dml2, use parameter instead

Reviewed-by: Jun Lei <jun.lei@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c          | 6 +++---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h          | 1 +
 .../gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c  | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c  | 2 +-
 .../drm/amd/display/dc/resource/dcn351/dcn351_resource.c    | 2 +-
 5 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index e2489eaabb20..abf946f089b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -690,13 +690,13 @@ static void dml2_apply_debug_options(const struct dc *dc, struct dml2_context *d
 	}
 }
 
-bool dml2_validate(const struct dc *in_dc, struct dc_state *context, bool fast_validate)
+bool dml2_validate(const struct dc *in_dc, struct dc_state *context, struct dml2_context *dml2, bool fast_validate)
 {
 	bool out = false;
 
-	if (!(context->bw_ctx.dml2))
+	if (!dml2)
 		return false;
-	dml2_apply_debug_options(in_dc, context->bw_ctx.dml2);
+	dml2_apply_debug_options(in_dc, dml2);
 
 
 	/* Use dml_validate_only for fast_validate path */
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index 54aff9beb73a..20fd5b8e5117 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -268,6 +268,7 @@ void dml2_reinit(const struct dc *in_dc,
  */
 bool dml2_validate(const struct dc *in_dc,
 				   struct dc_state *context,
+				   struct dml2_context *dml2,
 				   bool fast_validate);
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 0c8dd71148b4..61fd0f2e69fe 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1799,7 +1799,7 @@ bool dcn32_validate_bandwidth(struct dc *dc,
 	bool out = false;
 
 	if (dc->debug.using_dml2)
-		out = dml2_validate(dc, context, fast_validate);
+		out = dml2_validate(dc, context, context->bw_ctx.dml2, fast_validate);
 	else
 		out = dml1_validate(dc, context, fast_validate);
 	return out;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 479641fedcd4..e0544484e8c0 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1734,7 +1734,7 @@ static bool dcn35_validate_bandwidth(struct dc *dc,
 {
 	bool out = false;
 
-	out = dml2_validate(dc, context, fast_validate);
+	out = dml2_validate(dc, context, context->bw_ctx.dml2, fast_validate);
 
 	if (fast_validate)
 		return out;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 07ac9f3130b7..690e1ade361e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1714,7 +1714,7 @@ static bool dcn351_validate_bandwidth(struct dc *dc,
 {
 	bool out = false;
 
-	out = dml2_validate(dc, context, fast_validate);
+	out = dml2_validate(dc, context, context->bw_ctx.dml2, fast_validate);
 
 	if (fast_validate)
 		return out;
-- 
2.34.1

