Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA02FCAC581
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 13:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 664C110E27B;
	Mon,  8 Sep 2025 13:09:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="svvFsmMX";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCBD710E051
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 13:09:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOHisqPco83sahl0z2JAIgZ70rCQB1jxGPIWIbRN9Gfm7YALn+UGRpl9q1boX+2BXd7vOnh743ZpFYStxNZ8OaYkEZbUGWpZjSRd2B5YXlR+5z1dbtsqoTzRE4LZU7cGrdUBNlEOrMc1JmBGaZWtEZry0Y2llwUINQrt4OgSuAhYSE5v63E1kbehaCV4n/8A24IYNjDILHffUGUEi1MGMC8eSHdrVkfbkdj+ivEgQwIN4jGukT94RtWUNNrRZpHcioGdxH654/ndoqoJjE3aYAK65GWmQ/1XLYoWgDgjs8B5Qn6jiacnNYjkUgZWeWupzrHkM1udxZEaMUi5J94KWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9I/43PVq7M2Ori4KkQIhUDe8vxNC5zjf7tAYLn9ugE=;
 b=wCKNUa8FPIW6lA0Z0/vaY/VAFh6jALgeAh/OUqKnbvXq33ylrNIoFldesGRAHxQ1HiSG6/AymIZoP+hfUj18D1d1/4MOpkiiciB5Va0bLxzY1GGyrrNcVjWTmk18nJQ6WIJBLwCSdhwZbVjD6Tp4C4WGZ7wHGyPSEINYMfA7xGXqU7sc2NMuye1OOgZU/WhI80FXaPdxkrFGEYdPgpKmyDCPAYHFkZ4dA2gqwqnRifg3/Gt6wy5J+Hr7+3V2NhhqH1NAKS6IDOAPjSftOc/C4aqSJ6tZ3Fsc4JuLozCA3AK6eCKhsuCQX7OGmIntCxJP/fHricbcigyOZoHiJqvRCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9I/43PVq7M2Ori4KkQIhUDe8vxNC5zjf7tAYLn9ugE=;
 b=svvFsmMXVsdJ9xpDJE5y/L2mtLH6bkVYq/cGu2bv76WxEb3vQvaJsmLrIDzE990BiGo5UL0DhOrfpIPSnFvT9YK+wfeDlx2/O7kx6fZvFmU95sYsMeZCIwfHUJml5waM3uDNV2mTAf/Z7dXXHV4ky0d/LWIJR9/TLU0duSGYfUI=
Received: from BY5PR17CA0004.namprd17.prod.outlook.com (2603:10b6:a03:1b8::17)
 by CH1PPF5EBD457EF.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::610) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 13:09:49 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::5f) by BY5PR17CA0004.outlook.office365.com
 (2603:10b6:a03:1b8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 13:09:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 13:09:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 8 Sep
 2025 06:09:48 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Sep
 2025 08:09:48 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 8 Sep 2025 06:09:42 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH] drm/amd/display: Remove duplicated code
Date: Mon, 8 Sep 2025 21:09:24 +0800
Message-ID: <20250908130928.1215893-1-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|CH1PPF5EBD457EF:EE_
X-MS-Office365-Filtering-Correlation-Id: dd341d79-891c-4f8f-0c65-08ddeed8fdd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FcK5r/8aCSFwUDikidRNhNkp8yq7DWZJOnhtHs1ED0O9JI7Oth6ZOKJPoaZg?=
 =?us-ascii?Q?UOp25Khq8T3ELAmi+I0URwCUvsRwDj5T3avf80c45YZRRk5gX1xs4E3TQyjJ?=
 =?us-ascii?Q?zzsRdfCBOYQ/KKFZD/XGEetDFPQyqeafnW+eWuzbAKnAf3SnuZsEy8orhCqh?=
 =?us-ascii?Q?zFJ4uVK9R6CPkuIcWBAtANEyKBjqpTB15Spnc8nV6tg4LwYzaFjp27Jcvi+t?=
 =?us-ascii?Q?ScBqNB3rRM5zMeATeG7XH19WfRYYh1IfRpqizxBQctnr8wzLUY7JmnLxTmfL?=
 =?us-ascii?Q?uSULcFbUQnHQtH7yrpa5qh5nEuQeKaVqEg36P0JmWRdH3f7YI7D6oa0Dmx4d?=
 =?us-ascii?Q?7/OTffn3RYB0zmWOy9UIxT8DbhHZrPA9dhfvllXYykbQ6lDVehlBwmWImCoM?=
 =?us-ascii?Q?Vcy/nc5v3aHocSjyRFBB6rNU3zZBTtRoaSDNJMKYpkQw+0DNSEcbUbXvt4g2?=
 =?us-ascii?Q?KfKaTxirvYYx9w15AScn1QlUI9EbsMO57EDTK5HpXbbrfrTQ8Zo0zOIGX6Kg?=
 =?us-ascii?Q?01nliCxkvPqj/cdXfjpmN0FyHNEsyN409OmLRBv5mu9CEimSIwHRpT+Fn0p0?=
 =?us-ascii?Q?TUh4IYU2Y4eBTB1jLXsWS883D7411v/kniO0ugsG8p5qJLfyKXKnyZB0Quov?=
 =?us-ascii?Q?6jWmZ+OeF//gC2LyyNILrtgJ8pmUqU7wmEaqQh3rfFoRyLsCl4YMTWEgCiX+?=
 =?us-ascii?Q?R/RGkR3vwgAX8cU0KIJmF9mjgRWNuB4OxaojCQ1npXAzBjiso912chzsAaVZ?=
 =?us-ascii?Q?ZMK0W+8skL3koFiZ++oiiBnasz5QwTbJEr25pa9eM7S33CLjcdZgTY9h0NM8?=
 =?us-ascii?Q?EHEU+QWEd81ytjlMjSEoyojGWU45FBYVVhzTZlMndPPfvpkZGu4g9sV4ggIO?=
 =?us-ascii?Q?BXW8R6Lf6u5R5hlZHNCs4gZXU++LTORFcXH/zKNRa7tqxF+naOz6g6CnhhiK?=
 =?us-ascii?Q?/QKNbxYssmAJCO0nur4iq1Tagbr2bSB+xe8rL4Zhael2fxILtxiEja0q0aRJ?=
 =?us-ascii?Q?zO28bIbDp1kWyxPFboamc4dD03Cpxs/7Yd7E8YFz9UZ/Hpcv/qcJa65zhqFi?=
 =?us-ascii?Q?bTe+3EP2iJTStinm96DBdEUKpKHL+K+46C8JqgEnTOxYgEtfn9jNx6Tw9aOz?=
 =?us-ascii?Q?SUtiKZ15E98qcxK+5+YqlhoOQTMN7CRu1LZJ/kW3kAQGzqTzbiNjcK6az+17?=
 =?us-ascii?Q?ZKSRsYdJr8auWcLvNPhjDfpIRnABWox0B0+65m33PwuA4pTRKHnc6g48h5MC?=
 =?us-ascii?Q?PpbctPngxPf7tjfjP3mm9qJfsV9fdAetx3wt80ooqHEmnqvl+LkWNK6IloQS?=
 =?us-ascii?Q?wufE6xfNbXUP136FVtlwHeu+TolnMQElME+nROrWIKJAn3RWdNDj9L6Fc5QF?=
 =?us-ascii?Q?bO4hf6x8jxwOigYQFGHd5UeZ4Kg40W16rUyTM155KbXlYZ0ipEIcM3iHcH6e?=
 =?us-ascii?Q?wTN/u37VSIlJzOxJOSZqHMgocUj2YRbKM37lep9kUQH1C/EkhuUQoMRKrP/6?=
 =?us-ascii?Q?8ByJ/fiWwYXrMXnGm9dseeEmPSbg1z2Ebieh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 13:09:49.3940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd341d79-891c-4f8f-0c65-08ddeed8fdd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF5EBD457EF
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

[Why&How]
Remove duplicated code

Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c | 3 ---
 .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c   | 3 ---
 drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c | 3 ---
 3 files changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 8475c6eec547..1d1a002f6d54 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1900,9 +1900,6 @@ static bool dcn35_resource_construct(
 	dc->caps.num_of_host_routers = 2;
 	dc->caps.num_of_dpias_per_host_router = 2;
 
-	dc->caps.num_of_host_routers = 2;
-	dc->caps.num_of_dpias_per_host_router = 2;
-
 	/* max_disp_clock_khz_at_vmin is slightly lower than the STA value in order
 	 * to provide some margin.
 	 * It's expected for furture ASIC to have equal or higher value, in order to
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 0971c0f74186..47912e0861a2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1872,9 +1872,6 @@ static bool dcn351_resource_construct(
 	dc->caps.num_of_host_routers = 2;
 	dc->caps.num_of_dpias_per_host_router = 2;
 
-	dc->caps.num_of_host_routers = 2;
-	dc->caps.num_of_dpias_per_host_router = 2;
-
 	/* max_disp_clock_khz_at_vmin is slightly lower than the STA value in order
 	 * to provide some margin.
 	 * It's expected for furture ASIC to have equal or higher value, in order to
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index 8bae7fcedc22..9ba91e214dda 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -1873,9 +1873,6 @@ static bool dcn36_resource_construct(
 	dc->caps.num_of_host_routers = 2;
 	dc->caps.num_of_dpias_per_host_router = 2;
 
-	dc->caps.num_of_host_routers = 2;
-	dc->caps.num_of_dpias_per_host_router = 2;
-
 	/* max_disp_clock_khz_at_vmin is slightly lower than the STA value in order
 	 * to provide some margin.
 	 * It's expected for furture ASIC to have equal or higher value, in order to
-- 
2.43.0

