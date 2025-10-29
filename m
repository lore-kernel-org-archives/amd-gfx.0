Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4401ACCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 03:11:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA3E110E6EC;
	Wed, 29 Oct 2025 03:11:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kYRuPVBH";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 017DE10E6EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 03:11:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0mhKTSH0D7UFJGHlt3Bg/NjwJowFZNSINwsh94EKvILr8XAjZId3HO1cwXP6mqzRDChR78aRuTbccqVG5TVsXve4ash86QH5HR/fE59WhZZSSiD4aJR3wBkDOv/PZGTX6oEY3JeybE6pzUoJONIU3+SwVCxkpyHjU1Oof7IzAgqDaUqbjrpKPuEhoVsJMUGJPA8LdSBXT2l622v+FzNRy0HEsBZlj2MrVF2KdMexADT9tX8qfFTEOgzJkViVMAm1MSCOy0MChmP0uzkpF15DN0VqZNyKcxpiktzlOvxXyWm526wq+jzFIHRoIygIlGSRb0cruCTO7DpjieDMdaauw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbWmBcVz6lTyZzFS/wTUKy4lps6YVaiGNHua1Zml2zg=;
 b=O25UropCGkOivhl9gKD8PCxOwu3IrdDbS5Gq1cov7GXhjq3C4/fduNvgtMbAznlnh59cAJ/j3x9mQJwjm1J4VWW8qjyeM3T/53xBD311KjjsafUV3C/rTMv66hs1kv0iejaLBYeFwyaIhGqzp4En11SerV3MllthtyoifGZelRbwRcX8MZIXzahHP9v0rVXHf3I0HiH4qYgi/OL/WuVidzJUIRxCGI119rdf8cgDM+ximKF92Bu8Ai/buxDne8WN9h/zz8uCH4cp7HLcyv+HNQ3uFVc8fbT9P6c0njIXA8z84SA7P/GRG1OVmuvQU22rx32IWESrQe++YjGBU/Ulkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbWmBcVz6lTyZzFS/wTUKy4lps6YVaiGNHua1Zml2zg=;
 b=kYRuPVBHSrL232d3VExIS5UIn7GhoI5wJFW3vWNS7+MuWNsAzSerKkz+Pqx4b48C0WBnMpS0ObytbO8dqmGOer28GvOCorf6CvF4ivxKJ25e1p5DltkNrYviDPGh9RerEbX8LUS3CBNwb1jnEtLOBIDBWIzbOk07dP+o86LQemc=
Received: from BY5PR20CA0002.namprd20.prod.outlook.com (2603:10b6:a03:1f4::15)
 by LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 03:11:42 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::12) by BY5PR20CA0002.outlook.office365.com
 (2603:10b6:a03:1f4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 03:11:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 03:11:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 20:11:39 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 20:11:39 -0700
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Oct 2025 20:11:31 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Oleh Kuzhylnyi
 <oleh.kuzhylnyi@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 10/13] drm/amd/display: Increase IB mem size
Date: Wed, 29 Oct 2025 11:02:58 +0800
Message-ID: <20251029030935.2785560-11-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029030935.2785560-1-ray.wu@amd.com>
References: <20251029030935.2785560-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|LV2PR12MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 43147d4e-b1aa-4c71-1b2f-08de1698e209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Aoi6ZgPoAbn+FR7ZJ8p3YCvEdg5UdEu+pcL1Atf6TEepR5UNcm2lJrzFZzYv?=
 =?us-ascii?Q?h7F1ncNDyhF3LspDXZrRPyEVBV1lYQlBrEE+Jk25AO79lLemxZyX12vhbD+K?=
 =?us-ascii?Q?Xh2htYVF4bS45G0Qd/SsoU8F36o4R3SP3qOjtiYINWsAlYQ81dqtc1oDxuXg?=
 =?us-ascii?Q?077Azn7EOPD+U6XA/QokWot7W+LZskXOTVLiGYIkfOo6bwVbrcEiM7lcyTMJ?=
 =?us-ascii?Q?nhqvC5fqu2n56IE14RSxQ4by/o6ILPqPwrN5je1j9M/wpyR0VyIChP7rMlml?=
 =?us-ascii?Q?S+dq3E0YLddCNYWbCUzpHy+QJZgRre4Fpcv9UquHXh/biJPVfDM2v7GRD962?=
 =?us-ascii?Q?P/U221kCXY0u5f1TRXcLb725vRaFvTI8Gs05d3ECVEw2/86IC0mv9/L8EYRN?=
 =?us-ascii?Q?T5fIVNlkxD4ZHH9r3TPs4hemW3BpySgWPOaaKerTuuzY+6IpEf99Q1R+Mcx+?=
 =?us-ascii?Q?wXezJfhoxbb3liIxsZaB+lB9FeMqVl22KYP4d/Ye5nrGHlOJr0YyAKqFw/rP?=
 =?us-ascii?Q?ynBAXueEzHiUSKY2VmqQSZj7SiECm6yW+q7PQmYpKXr+UQtRDNtrtgxkrf7h?=
 =?us-ascii?Q?8B9EYSZo9Ldmjab1yrPkolSVPMXeRD7n4I+nHg3oubuCCFEce2lMjaKd3eCe?=
 =?us-ascii?Q?AXC2dKVdFyAmq5+a420+ig0NhLldT4/8w0YE6gbzraS+WP7/ezygSD3heJKL?=
 =?us-ascii?Q?3Dkzsf8jB4QJ5KtpWbWvALRSL3x1+35k9d7VvWEh3rOLW+PcWU1K1xpxsAB6?=
 =?us-ascii?Q?EIkK2AwUMBI77m2IzdPXX4iw0nEz2mMuRoLTBssqo5JyZEA2CS30jKZm+HvK?=
 =?us-ascii?Q?r6UXzHWgb9av336ZqdtO98owK+LVGhMpCrC4ZENP4QBQnkwRh9+tdZTLepvK?=
 =?us-ascii?Q?6OAd3P/8QMTQQpqGzX5Emz0i3hSMTk78342IT+GJ1nzcHMAlI86JP4eiMXe9?=
 =?us-ascii?Q?y5vI5zkVBRjuyq6SlpEBGBdMzpUfdpdqMe+3wakjojjIjgcDEOVv/L8y4eBN?=
 =?us-ascii?Q?orieOYQMtLWVBRs2yMKjdQTuRQsK+ADMVMl7W00e+7sK5uxsmZqURZPeO7T6?=
 =?us-ascii?Q?75qqzIbbGCw4jozI9swLuNzu+0NDwoa6vEK99+zQOU9DJwsatrzGBqcMs38H?=
 =?us-ascii?Q?sYkPqd39wvi5Hkg6VChP+AX4YWaStHrUpCwRTp+Dy0WBolo+Q0fCyz40HFsC?=
 =?us-ascii?Q?dMwOZqNVKppu+627b+bLUfcCOpUii0rAENmhA/wisNVfKTGCNisWTNIFiBGe?=
 =?us-ascii?Q?vDB/17njWMlE20LREuKxr2+dxWGAdGmtqHhkAzfb8s82r1kPvmDqvpy+OXOh?=
 =?us-ascii?Q?rBvGU+TN6fWeIhrcZlkLqomVac6Y6yOvdLv8B5bTxI9jHd2wavivh06RxJpb?=
 =?us-ascii?Q?CDw5q2vv+mmOjWM7NbukuQfowXtLu9TweR7rAEClkhVIFs5RIYaCeJQaRqeq?=
 =?us-ascii?Q?qiJBq/qZc/M/wXxMYw/8UvXPl/g3I6o2l3mSipVXYl8Oo9bTkwNwls/ekmZD?=
 =?us-ascii?Q?sTNXHI305FUYRwfb4A3x+U7QW8lndfw1mxmRZPwW1pk4sJW+1br7pUnrn8LW?=
 =?us-ascii?Q?dldgvPWK0op/pe7sLoU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 03:11:41.4913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43147d4e-b1aa-4c71-1b2f-08de1698e209
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why & How]
Increase IB mem size to match size of largest structure that will
use IB transfer between driver and DMU.

Reviewed-by: Oleh Kuzhylnyi <oleh.kuzhylnyi@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index a657efda89ce..a6ae1d2e9685 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -66,7 +66,7 @@
 #define DMUB_SCRATCH_MEM_SIZE (1024)
 
 /* Default indirect buffer size. */
-#define DMUB_IB_MEM_SIZE (1280)
+#define DMUB_IB_MEM_SIZE (2560)
 
 /* Default LSDMA ring buffer size. */
 #define DMUB_LSDMA_RB_SIZE (64 * 1024)
-- 
2.43.0

