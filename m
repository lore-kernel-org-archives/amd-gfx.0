Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441A9C83F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 22:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D20D410E73A;
	Tue, 22 Jul 2025 22:47:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GxFiwk5I";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 390E910E73A
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 22:47:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCvy3V1jgL/9c+VdR3tyw48jHAJLLs5gH3Ax/fyQdeUZu1HiC1dQC6+BgMr3LevHsVm7UZZU9vJ3gyjWhUXsHwcOt7wmeLweHEuQqX5+VNRgo/sliYQpzLd3YufbEQvNlwzeLcUGlcowW1uRGgWNpTQlpbmfdNeLSOF29r+5Qh3/jwxjT4tfzL+0EoMr2SqDT1luf0pmJTq0I8jl6WEgz2PQ2n4JRcp0K9y3sKsNdYHdfxypWSNMQ3pmD9781C//E28TG6v8Ff/sBov0+0ysnYwdMRWQQRuZOCpnNbEXs34Zq2IStHmU6VlaGrpnVBHSLRHGooF8STwMZsX6ri1DDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k05sXrFOvGukrPlc1PVvmogKT+jXSZAcYe1cjokL42g=;
 b=ewWKkJ9qKk6feDoa2hH1FQn1L+2CADCb79uXQ0Zkqs0kAEe2ZhUsP16ao86tIpyk2oCEOTbsxM3z4B203U/faArdyNYG5Z7YM2gchc42rygCN/8g0i8/P7Vb1snAH1qf4N2W5g39VCIaljxgX8Guh+Iou/32kVCG4rxrtBHfzAXlsbq341biyg8gAA9SrBkM6xhKmwT4D6N9xFJ06ZczcMb8UZZmA8hiBAMsDSWYJ8HRXlZ1new93fQ1HSd/CJN/+xu461qeDRr9T+uSnyuMZYEfdZsFUZOX2YbFVvxYvXbc+5lrbo30AOwpKNv0DCNF957f5lk6sfJpkiybPzn3Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k05sXrFOvGukrPlc1PVvmogKT+jXSZAcYe1cjokL42g=;
 b=GxFiwk5Is5w53YeOrUenuxwZ+qoKkzk2e/hbRmSro1h096bXP3b8unpHK/DDdQ8gdKXkAL3CvD27SaARFqTsMGkCZyBso6LE1NbhSpu+i1kXsLzbd8vUu0YY+Tx+Dt4fov6TMcp5olEGEYh3bAMiGl2ewZcOmx6IrzplCkjrBTA=
Received: from MW4PR03CA0089.namprd03.prod.outlook.com (2603:10b6:303:b6::34)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 22:47:13 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::f9) by MW4PR03CA0089.outlook.office365.com
 (2603:10b6:303:b6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 22:47:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 22:47:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:47:02 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 17:47:02 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Taimur Hassan
 <Syed.Hassan@amd.com>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH 25/25] drm/amd/display: Promote DAL to 3.2.343
Date: Tue, 22 Jul 2025 18:44:34 -0400
Message-ID: <20250722224514.2655899-25-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722224514.2655899-15-IVAN.LIPSKI@amd.com>
References: <20250722224514.2655899-15-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf5ce6e-0876-43cc-020b-08ddc971b2f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z05Y2oA2zqAfvjD5g/24SuqwR6YQsqG9JZ4McksXjS7r9QgK9QODUTWi7mR8?=
 =?us-ascii?Q?/+qAsp7mTb/52VvPcEEdaWtiwlILDRRKgC/JnjcmAmLkLt2ZZ2ChJcQwuAGz?=
 =?us-ascii?Q?iOAWHWBXOAgdGVzeDatU1uS0wsQiBAr3d3R+s7b7ulUdHQ9ygaNDfD5vKrAL?=
 =?us-ascii?Q?Kj4K6leQKcyvhWjInPgF4TRdZZY+7Qr6nwI/uYusqfoRS+SukkHzuzIn7ScP?=
 =?us-ascii?Q?ulaO+gt8oUDRHQX74qIZXDzsLvMG76KEyoA7kNbhqMNTycp29Z1SdkvrLIe2?=
 =?us-ascii?Q?3DcsuSe5YP3weRpRtADnraGmoiWTiEaJE54DalFSgmoyQ+e9ypAhiMvQotWn?=
 =?us-ascii?Q?JGtsBr9jXveGgHr43vGmaGtorGjBR/gNKmT0Ya57eJbsjt3kAFiDkwR7E0l/?=
 =?us-ascii?Q?i7+In2My2lb4De+PwE5kSdFikr2soltaPKFSJqbwdXzWDNwoAzvR43+szyNj?=
 =?us-ascii?Q?o0W+QaQvizPn9DF4dPt/cCAnncyyjuKqRvoZwWffWzVEie5TDER4tehWyIIv?=
 =?us-ascii?Q?0ipxI03z8BBx2Wg8msMjHHm+39LqaXX5e1qd1WxNcQI1utK0bPjbXYjVq5SZ?=
 =?us-ascii?Q?3AuKzhAwCvQuchOK2HYvEGWJL2AOJ8Inu7u5IH7V+6gIAzrtMfRwEd8VZcSB?=
 =?us-ascii?Q?sxPMe14WlBldNuHwcZGPEtFw2+PohluK744yetfGgAy+yHW0JUdPtS6n9Y7r?=
 =?us-ascii?Q?IYO4qa+b+dIkRzv7+ZL0FO3rpfroz5PUIV1VlT0PwvqxK10+SN8RXQIwhBXc?=
 =?us-ascii?Q?YjwiPkP0vwKW3HEkZOpkJVtuKTSNWt4ru1UmEQ6yU8SAdaUsfNr74YWIhilV?=
 =?us-ascii?Q?dbegqBzDl/HDfJhZSalfizmzuS5WSVSbbjS9nw5X9pWEZ+XZsuYaJPUixJWF?=
 =?us-ascii?Q?8WwLYoiOQ/dpA21yRs76gTXLWnOkxV9tMwVEJWf7fTV2WdTi1392i5kKhCh7?=
 =?us-ascii?Q?2q5n3CnxwEweLpxtDz9iuPmjYQhHZgjyRmAvUjtkLa5XCvHkGDFd2STbaCAG?=
 =?us-ascii?Q?aIyswRl1PmTiZFDJ07AtGaHOJ6PjYWzmQV8p/fAl/D8QvoCpaSQOlpw3xVG7?=
 =?us-ascii?Q?iAF1p2qs+Q6RF1MpJItaaK9vna4Mq/D37gtrKsf+jUPaPx9lKyiUYqQGyqvk?=
 =?us-ascii?Q?Th0dVLxIwuqMb+S2mWxpnwRq7hlhjCQtbtmGTOXP+0DzpQlHMv4U6rfIa7Ih?=
 =?us-ascii?Q?GHb1hxEzzQc2DQeorv0/4GchS5AmJe6Hb5upaToKHQ/UBVMZ/RptnbLDUMg8?=
 =?us-ascii?Q?ishxzLWjnKXSeo341aEsKHut4WkcYnsj6qZ4OaoY/uxq8KDkpfNLJBecbnPE?=
 =?us-ascii?Q?PBSh6OyOqtKp7uv+L/SLGL6H9808219O2vJD6ITulWnVbEmNbyqroDh0m18/?=
 =?us-ascii?Q?PPoafmeTSXp0q6HNhSW/AoCAwBDDndR0jVqGmTa/fiWoe14C+KfrdVNoVdbL?=
 =?us-ascii?Q?JjWPnmcSJcv1Wi4oYdfEADKNoiLkqryntlz1ZIXmpDUpoqpYcZPobpbXyqZ2?=
 =?us-ascii?Q?NI22IN0lSBwaJsjFzUB/gAg/jd/inv2MvsPr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:47:12.6209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf5ce6e-0876-43cc-020b-08ddc971b2f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
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

Summary:
* Fix caching streams for LT automation
* Fix DMUB command alignment
* Disabling DSC power gating on DCN314
* Add debugfs for Replay
* Add debug option for BW allocation mode
* Removal of unnecessary includes for faster compilation
* Refactor of code, including adding SPDX license to amdgpu_dm

Acked-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 57f4a9445b7e..5653c1673aec 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.342"
+#define DC_VER "3.2.343"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

