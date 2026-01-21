Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C3FC44508
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 22:33:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4920B10E89D;
	Wed, 21 Jan 2026 22:33:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zaFcoUUh";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013065.outbound.protection.outlook.com
 [40.107.201.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F30C10E89D
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 22:33:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3FeUCqmGRwFqAV00BQqc7kbDnX0mSGGTUFTAkhGYv73gJBqEff0uk2+eWr7C69sK8OQmB7tjTn0w0bfVVL3IwCmsRFIsfmz2Yj1WP29jeTiL8EhZMfzrwX7waZZPJM5uf7ib91EBR9edvk5axWE4wVB2t7EhCeVGc4KqDfR2zFARfUHoQMWap+VhtIYgdQkQi9/L9ISbKyhm16GFTG56m1IxIbTh+aNG/J1c8uuwueozc9+DHQsEu5tb6+cp9EuGVMhWBUUMUeCemTRtfh5swwp0la/8T45L5Qvt6gyFLmNu9KRWtIbNblCaOHIIjZs+/eV4KYVYCJ+dBAZ9VxdMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ig55wmi/9nUCaYxrbRs/tPoKKyzQG2/73J82NfZMud8=;
 b=U/zpTy4pbWI5WbnEXJiel+kZf5JQiIdoqNpZd6nzQAURuyK3VpWKNk5nraoNaZDtLaIUONzQkpQ3pCinWwjbiE11V3wl3MlapN6XrDxcISLonKXIUm22TrXTK9x6Y6SRW3D/lBlRQZU/h0rZY8kpR7DZINgg0cWfUjKiQmvLGo0zSSmxS4vAtAZAKatuEP0sfuElm19apQWNq9rmBJY1ZVaVEo4zN3xjbMa8J2ckBgLxlkizIX+Q+VkzOPdkOEhtW9rvSJpMsrwBH/618LS6w1TaIWBdghNDGjdy0QWiMRLqA55WovkZLEZ/u87t/KodbK/jqB8fbnAM4LjtXCjEFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ig55wmi/9nUCaYxrbRs/tPoKKyzQG2/73J82NfZMud8=;
 b=zaFcoUUhca2q0MLoaQYghS24pQy28Df57BgITejKiEFZzIGA6PE6IkCbZi2EuloeQf9ghP00OxWw2czfDQQqhq5o98b6FySrxO5AKmoF/m49xZbF+/Q0jhpz1ADAp24CPMuH1U2HyXMdiU0NBCHJvbMQ2cUaXgHddSyP9lVb6ik=
Received: from SA9PR03CA0009.namprd03.prod.outlook.com (2603:10b6:806:20::14)
 by SJ0PR12MB6854.namprd12.prod.outlook.com (2603:10b6:a03:47c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 22:33:17 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:20:cafe::cf) by SA9PR03CA0009.outlook.office365.com
 (2603:10b6:806:20::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 22:33:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 22:33:17 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 21 Jan
 2026 16:33:11 -0600
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 21 Jan 2026 14:33:11 -0800
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 13/13] drm/amd/display: Promote DC to 3.2.367
Date: Wed, 21 Jan 2026 17:31:49 -0500
Message-ID: <20260121223247.186241-14-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121223247.186241-1-aurabindo.pillai@amd.com>
References: <20260121223247.186241-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|SJ0PR12MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: 02abd843-ff38-4c07-000e-08de593d12f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YntpXlKJr4vGADQ/YfWvZNCjxt5eNa3Ao+sSElPtO7AMKURzUZqWS7eYYWxB?=
 =?us-ascii?Q?G0jCljw+pGJdXrVbuRp4cYugMtjh0lKtu4yPi2QO4xgfK68LRft1gbxOx+k6?=
 =?us-ascii?Q?HaAg4xiecLOZWkjUpgWxabHmoXhIuoYBWLj3nTpHUoLBz2Zloox0rBVvpX0R?=
 =?us-ascii?Q?q54PR8Ml8E39MpjhXNxAptgGrS6vlILpY7hUZrI3nV68q+OHmfL0VWIMAZFy?=
 =?us-ascii?Q?upfipCaa6gdkBaoUkRT39aCeoV6T/xu6VcJFylG8TFbPFEw2Icw5g93fXoGP?=
 =?us-ascii?Q?tlyYr5W31HdVWCt6KC9yxcw1HCM6YW2Jb4wzUMq1F/1xPGHV4649MzBs1yG/?=
 =?us-ascii?Q?LlLT+HiutlG16rLzMRCJE79ij3x2DtMZPLEYS0PVacgukOdpb1qH5C0K8SkD?=
 =?us-ascii?Q?/y19iIuwcLb0YTXkekMAU4bzpbk0Mj6j6DCl0JWI8PECmpLtqkUCsVBGyIve?=
 =?us-ascii?Q?GVDqPBmmhwRUlZhCAE6LWAmcKCOl42rka4ROqZsezIbn7PliA14rfrfm9XtP?=
 =?us-ascii?Q?qM+LvsKbRlhMkiMoY5ll+tKSnspwFr4GCxjzMaEUhE13y12AnaVlQ6huSaQn?=
 =?us-ascii?Q?SvTmBy/CFD4lCrpt6k77I+7C/WCcOrdvKHO0aIFuddrGsnN3eHIKBJljyCHl?=
 =?us-ascii?Q?ZNZOw1c9X0CZNQGYWnZ+dmEXFOgoMN0mY3zS1VpAfDj1r+YQO3cNON/pZgmy?=
 =?us-ascii?Q?Pkl3xpS35UR7NdT/NTZ9B5E1YLgnIm9IlRg4kWrkEJxD6OxwBlKfesdGpCDe?=
 =?us-ascii?Q?TtWadLD1T+59fIV+6aN+mhf4qQWieW6ErynQ9rSHrb4l6P4hOR2MgRstLjjn?=
 =?us-ascii?Q?vkTrF+Z9QfL1wjVvBL9O9x4VEd8f1Zib8pigTfn73nIMDfjsidr6NgamKb3F?=
 =?us-ascii?Q?lluPIS+gRcsG/G6p/n6dqsKe6b28Rz1rdxqH4wt5zctv8iJcwRtdixWueH/S?=
 =?us-ascii?Q?0I02ovMj2nlxKrCVXHZK0F98b6g/uwn5v+dUw26DZHyxUBe4uPEgUTkD5uAb?=
 =?us-ascii?Q?UYYbLJe07UBsUuY3iJ9IZdNRlLMPbWO4HRehLLRnP5RlgP3a6U+QBVPOLDaQ?=
 =?us-ascii?Q?i+tukhu74hVUXQIN1vlLVedF44RkfEi5z2oSGGyBHwC665XbAsPsail97iMd?=
 =?us-ascii?Q?lJlxMQjiKDvDFge3efyAIkei7D/7hRi5hxIuNg3VKh2+L+eifNKjXcYluCXL?=
 =?us-ascii?Q?xFSh3qfBOEG3SIUAykjZ7lG19O7M8b/KZOxaxzUvZN+GtnWgOMwWHRSbdydD?=
 =?us-ascii?Q?VFbPOz6EJz6RXPaqdoFlMAaXl1t/KSNOs8wJC1SZfZ8lZMtHdwLpWDiwcFJC?=
 =?us-ascii?Q?4SWYV1VVIDUhEPl68xm+6h7nc91b1Rq0DIBOySHXmQpFI1wGpcmTrfJ3s1cg?=
 =?us-ascii?Q?HoSkGqfnfjwOcc5rwDi6OU4eQLJHbNj6M+0YMgMXVeSuYi0QFpbesFyVmX8+?=
 =?us-ascii?Q?R9wxpwc5gwW0GzqEEAmuO7OHj8LX/d/igJRdmCL1pOBAyvPI0yhDC6NOmino?=
 =?us-ascii?Q?8oEOLi/RqkB6mqlcTqmnN9qWKrA6hbRwz5aKG5wmWZmJu+lyTeiA8Bxl2vIS?=
 =?us-ascii?Q?btZNNucOTDIYVh0rJu5yFgYsl+4paLLNvv4g/QZwCuGBcq5tZhj+zJB8OVW1?=
 =?us-ascii?Q?0WM5gyUWRWzAmjlQP6INaIqcY10CjG0jH14UmY2nEnAFdWjMs8wdMtMEqC50?=
 =?us-ascii?Q?80Qd6g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:33:17.8526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02abd843-ff38-4c07-000e-08de593d12f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6854
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

* Fw release 0.1.44.0
* Fixes for corruption on platforms older than DCN4x.
* Bug fixes related to USB4 link training
* Fixes related to FP guard
* Debug helpers and other stability fixes.
* Some refactors to improve code quality

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 80fd8f4e4c64..d23ab5cb0ce3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.366"
+#define DC_VER "3.2.367"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.52.0

