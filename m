Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65266C369DC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 13:56:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1851A10E55C;
	Mon, 28 Apr 2025 13:56:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n6kWxgVx";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 571FA10E55C
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:56:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4BWqr+t5ad7gvtQJ4PT9853T0LIw4/KhBtBMwwN8FAAK1uVNVljEYB/FFTM57hyVhihi2SBKKVgdaXttovlRG0ovTvfMt+/q8WMWLbYbXz9jvuKSoWvZ6aBk6wk6G8SgtC1zqOQKXvYuy2N0lJL0CumI0AfCJeMvh43SChZQTpS5qGQ7kfQscGYfjzzQaSOoItospNAYjW4byIw26V546s5FgW8pyC1YeS2cgw6MuC6IaueXG+AoebJwlD/8nlHsobcGB1leXIfoIDHD22I56IhubKmQbWRkCUmHhk0WyNVYYHTgXZpO5mC6a6euRP0PnppE5jRz5Ta2JqIaJUm3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suqJgqVpgPx2CMYGDj0j1J6sGxF2lbXjdEQSwXSQwr8=;
 b=eVIx9DjN2aHlD/t5VyYw180ObZyjpOfIl7PhEiNb6RHIX7E/sjgZaIJ7mTNEr5FXjCZhojjF3NDCdSh74ynnfQe4qO7EfZstyAdBerMiuwkMjNq7U84l8HtYRASghc0W7s87m0/zQwy2/rxJa05sVWowX1B4DVuAXI3cOAOPcGye8HKz5+YLhSdnIZdKrEa2UR7H67yBXf+T0pW1ZMENsipRS7TQ8zV6L8NtS9fAucImRKmxHLcswRuRM0FOtXPlWofUameKsXcPQ3HM4Fz0o8oRcyN44J5YNoNXkeLD57lM8V2rzYdUqu7Jo77ZSL5OlAA4/1QJfrXOLdT5JKPt7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suqJgqVpgPx2CMYGDj0j1J6sGxF2lbXjdEQSwXSQwr8=;
 b=n6kWxgVxIj+6JFtkHsZ/yZxirlwm5IeyFM+2PQa6yQYduv4aQq3NxsTu9HilJ/+ah3oEY7EVY/fOQbeI5T8Y0udbQpBHlL2ZVNAnV8ndOPf/Wy713lOpc4g+4RwwZaZfsjmxNCSN4MxZ6/nMh/OyQ2CKZHImBuA25yhDjWyEy6E=
Received: from MN0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:208:52f::7)
 by DS0PR12MB7654.namprd12.prod.outlook.com (2603:10b6:8:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 13:56:38 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::f9) by MN0PR03CA0010.outlook.office365.com
 (2603:10b6:208:52f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Mon,
 28 Apr 2025 13:56:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:56:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:56:37 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 08:56:34 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Taimur
 Hassan" <Syed.Hassan@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 13/28] drm/amd/display: Promote DAL to 3.2.331
Date: Mon, 28 Apr 2025 21:50:43 +0800
Message-ID: <20250428135514.20775-14-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428135514.20775-1-ray.wu@amd.com>
References: <20250428135514.20775-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|DS0PR12MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: ea37d3a0-5184-4e64-cd2e-08dd865c7f1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MsCBHQzcCAYNL560OiBwkiQU/v84xtlDX85G5QTL9hJewANOqlY6oHgzr2t+?=
 =?us-ascii?Q?rvoRBhYoyubZOLB2JJ1Sxu8/o247ELAXgJj2XKVuMrPbVbt7salgTM4sWxQI?=
 =?us-ascii?Q?ZMOg2PXKa/ugrQYkB9uPdGQblO6V6+VaQAHq1JduEKwykVQalasg7UvFBDxK?=
 =?us-ascii?Q?oxp7j4p9PohEtvL/2AHRdg0DFnqs5kP2TgehSWP0T/XeuUfyY7WiFiCbrAnc?=
 =?us-ascii?Q?8nJuai06zZXL1ltsGzMXcpnOMLcAacoR72EABiv1JzPo4gk72A9kvGlIpFYD?=
 =?us-ascii?Q?D/omrhWGezUP9WMn49xbIy1iXEt7N4dKmSZqzHV89Wjyl04v4Hx6krXByCLV?=
 =?us-ascii?Q?QcFcGfCtHh9FbrE1bAY/VdNFkly7WlxF1ddwvN1RrPuZqj4RaWGwRqeWhd9I?=
 =?us-ascii?Q?FkZqI5YRqWaRUhmEkicTfzO1GSWpMgvhMGpAeuUwbPC4ATKe09My8P0Iyqca?=
 =?us-ascii?Q?g0NUkG8RArZTxj19+xyKpPOwYGSIHmvEOrndRJAyusCX0C14/YTQ7zIoXPEX?=
 =?us-ascii?Q?hpM/3wd7Bad5pboJaMg6OWskcWy6OA6j1q9YnwcX41j96/zQnKMyusIhx9/o?=
 =?us-ascii?Q?/yNDL6j72MkB6e1LpSPliXNrIg9Sl3hH7QdP9fpDMU+A2c2krnDsS3TgCVkh?=
 =?us-ascii?Q?s6SFsPUREZwZOYX+VQMmJaKUOwCLZ8cw9WOZqs6g7lIEF8v8/QdccooN8peL?=
 =?us-ascii?Q?008fEduVk/t6+FwzWzZeQBtDZa2VJqY9Q1UTTSY5Tgy9aEueVwG+0y8jBTON?=
 =?us-ascii?Q?8YakUwfcaCqh+nhk80az+X+yQw6lBj5h2s67HAiWGfk/us7rWtwDrbxQ+fGF?=
 =?us-ascii?Q?6pRTiKHQ3xZU4JkjQ0ehrIkUHZqnl0/aqrapvf4V7ALuocWKPFGwXbCBuOy7?=
 =?us-ascii?Q?MEc0A97af+wQ9SB1VzWk+0zL1LxVoqappe9YMIHXjwQ7xyUwrrlEaS17av3P?=
 =?us-ascii?Q?wvKHgs9k7f+YIUtDIuK9cbpdIYA09/EjZ9sKj/S9v2m7iiyOGn1scjLOFd7t?=
 =?us-ascii?Q?BKtDNA+IF+uUug3kEA0+Z6mu8iO6CvbJPOIjGcijHD6peq2QUO2nXNySraUq?=
 =?us-ascii?Q?cR44y710jkMoN1k444gnu8VVrXa1VY63qLE+LbRbVPfK96c1tGJfLyr2vxRs?=
 =?us-ascii?Q?FwxmxFDTZj1mF7XjGgVGrkJjDJ5EjRHkOSOgDWysnDvQyHDDjV4o04I1q3Sr?=
 =?us-ascii?Q?1WsbdAqLMwstIlknYXRdqJw07jZu3CMMKPwQFQ08xXtkNVMs8Ghfa5qSfdO2?=
 =?us-ascii?Q?NdVYTwZ+uuOo2hRsXAWD1Er1szzVydkxYXLS1D+TuOQSsPgVcoptW3almQdo?=
 =?us-ascii?Q?MtdYyUAfL3yXgI50+a/o+SmJSY39jK0qB6j3voAItbtLm+pzOtz+8DzF+XhH?=
 =?us-ascii?Q?6xX3J3XSqovfU4Eyg1pGAwujN91RJphoYKD0kcRW8KsDRgrdkfWKnxBXY/iv?=
 =?us-ascii?Q?8p8nkdgpuSNN5sgcrZGevzwrG51V5mEgQQmpsKtac1KEEVGHgCIE5PqYDSgl?=
 =?us-ascii?Q?0PUsdX6m2f1vGDeewnHVJBs30bvQ+bw4XU1j?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:56:38.3828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea37d3a0-5184-4e64-cd2e-08dd865c7f1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7654
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Summary

* Remove redundant NULL check
* Fix invalid context error in dml helper
* Prepare for Fused I2C-over-AUX
* Allow DSCClock disable
* Vmax / Vmin update for Vsync

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ca879f27b0dd..a5cbbee02380 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -53,7 +53,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.330"
+#define DC_VER "3.2.331"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

