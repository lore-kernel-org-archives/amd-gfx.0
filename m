Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511C5E77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 20:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0457A10E081;
	Tue,  7 Jan 2025 20:17:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lani+gPe";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2E4910E081
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 20:17:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBHt/O/8Lx/3sJ9tM2Ac0L3fW2RI7/thMK18oVRkvCZGZVqXb4wa0SVpBtOB9b4A5yRD9HJT8/CmF2xi0yJhyRrT/I09D71Q7apU/rxSmzjuVpKxQURWe0Mavet5D6J1YUdfiugTKO/HRdoHOI1fsCSOCjd20tXC2LQzNDB4ZLJq373OQpv5nF8esSd2guOgXukPNGFvZEFNtfjBArEMWhKvUKfwfWlwOZ6xAAp730jpF/ccv4MSWD9OH0imDq2nejcKZsc/zmNCVTvtRp9rJt4O6gGIccveN/AfcJAqorZf1A3+71fhYZp6H+QKSc9FyAuG9EQfoCw0mRood4e7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9KmrLsULGLYhp8dp7bniycHAk9FqBJF3uKLrcSFE6A=;
 b=mY1ZHyDeSq613tS5AbYEsqSdYsnIreT6NRlqoC9KyT6671wFmeodm/yiw43A9NL7LJcS5pjqOsZ10GupiOnP8mkPcoSQEz5g9d211N23rcbraK4erDq3pbv3AkoEZn3BdbY6vTYFB/sSJgAqqnta1QaEMYRANG07KM78gmg1vp5U6M7YZ1xIzHxw2izAYihkganlRrujipoNieCaYjZxOuszVRfuF/wHr7e4G4Hx3+9tkaW71jHGX+jQxtISPC9wBG2RZvgdeRmTpL33vTscF+g4UB1aBgEFv3skSy75du8azfQKxZSnanar3giF6Hq8T4DZXmAjtk7olzyowFjQkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9KmrLsULGLYhp8dp7bniycHAk9FqBJF3uKLrcSFE6A=;
 b=lani+gPepAKgi52DGJj8xMxPyJW+WT066bB37OVNjGZF9iZAL2PsILft0h9mL0TvDOQQZl9pa1lHpP6YmXJpUVwaL8XBpLfwrFDpN8LLQSVvNSO3OhPYCcQom+XpTyppmACq/NBEeIhmc+zSU5GSgeYFPdPqDtOZP7AN3yZQ/ww=
Received: from PH0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::16)
 by CY8PR12MB7732.namprd12.prod.outlook.com (2603:10b6:930:87::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 20:01:54 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::eb) by PH0P220CA0011.outlook.office365.com
 (2603:10b6:510:d3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Tue,
 7 Jan 2025 20:01:53 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 20:01:51 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 14:01:50 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Felix.kuehling@amd.com>
CC: <jamesz@amd.com>
Subject: [RFC PATCH] amd/ttm: test fence->ops->signaled before use
Date: Tue, 7 Jan 2025 15:01:40 -0500
Message-ID: <20250107200140.1568268-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|CY8PR12MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: 54db83ac-0ab9-4685-efff-08dd2f56209f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sdsVe7LGeFUlbf39xTiPHnIhaR34QuugZVnhQOzrEkSCpAbF1D+1CC2UnEZz?=
 =?us-ascii?Q?KBr4PSLP7KRGY4kjXITKOEQSwbTAY7iAVp1256NrGslApMQIDlKtuagGAtdX?=
 =?us-ascii?Q?h7SUi4EmFrUn1+OubZ2ZYwjd+RxKTAWSwXHI8lJ3r4xIOGmGH+GLuzxuukKd?=
 =?us-ascii?Q?KVFIq0pBVWLCGDBOpgggXnPns7baLKyCZAM/m+VFFWToZNPeULchz02rJNZj?=
 =?us-ascii?Q?6yiEegjBwImR0fRpX6OKruN2/NQcnHNeN4OLKRXkBk/4+Np4XP653HwduV2b?=
 =?us-ascii?Q?oXJZauHmfL6IvGnQ9GgWB4z5gEo5E+T9oGg45Zs1xedHU/QFQdJCfDJ+jeBU?=
 =?us-ascii?Q?hxPhKXK2rQCVssQJIY1LKeUlE9wv7Yqu+O/unywGvAohfihLQGPVf8mxxjw2?=
 =?us-ascii?Q?s5lMoXII5cVvKdH8bpL9KWUtqFx8CK2wBfohfPLa7+E9czdIa6psTBZ/zdpC?=
 =?us-ascii?Q?VDzFBu7YmhIF81hD7LkIofWMkkKEPQtP85UUu8wP/Oz7yErlKtmCDum+G1L0?=
 =?us-ascii?Q?EGTdarsvMe751UNnA2q8gClrA/Y61Y2x+LE1NQhCqZMFUqyCIoerV07wtXN2?=
 =?us-ascii?Q?/H/0E1vnG7T/93CoFK8FVlH/KGFD0pqEerB9dHoqpfDne+pvaZxuC9OkuMhs?=
 =?us-ascii?Q?PKtFTKYeKWxoO9L594yYK3T/xMNC/jvUlpzXOv0BSzQ8jgcQZhYT8Oguggf9?=
 =?us-ascii?Q?pxlQmj+vXTbcYOja4GuK8uBxrGX/esomD3JDEsJdOy5etcng3jMTiI27WHfJ?=
 =?us-ascii?Q?+0Xc+X0S2BeoSjSgL+C62SbDq/WziUCwQ1EsxlUxW9tpbAKX9aXklaQ6lg76?=
 =?us-ascii?Q?ukavel9tU9PIf4uHhyDo1MeNgqwWQcn82WegnB2UuOuezMM/8jSgMHZuzybD?=
 =?us-ascii?Q?21MmPQyaf+tK9rlwScVUvHsTdAsrx6tJ2NtVT6qOGegt1izazdnGl7NbumRk?=
 =?us-ascii?Q?sBM2yy2NSw6n12c2Fc8shcpooIIZNePDhBDZHUdaE44n6YdtdsTRgIzwTyS7?=
 =?us-ascii?Q?ob73IgiwCCnOlW1O8QEOSzCJXZxGSZTV97DGlT6pJYU4spxyYEYNhNTASbjw?=
 =?us-ascii?Q?rt43SVar+EzrAEYA1GgdGEMC136T5nmvzFqEZayhpI69Qa2MV5NzHOJFmd5+?=
 =?us-ascii?Q?Nq19ZDSyKmte2hlV8G4iG3fMn5+TKUIxGqHzZfwFujoi7KmK5bWyEFEyppfV?=
 =?us-ascii?Q?xFdT6wFz747aNp6ElROn+GrjA3Vjn0AbT7yWQeknK4mR9zo9xa69QfwflCCa?=
 =?us-ascii?Q?hTTFZ7vr9DWsr9REfcBhr/KyYAeDip2kv9xyoMdqZgxnTZrph3270Jwzc2Qu?=
 =?us-ascii?Q?bcQsHyNVM7HtfUbkv2Ozdf6khRkADqMO60hIuNfq/Gb7aVipnjSJz21LGkfR?=
 =?us-ascii?Q?9GsdUK9/lYSmpqLq9y1Agf5NLiABAO61A1C+zlIVQ3C7VFDAV2yvLc+4pb/7?=
 =?us-ascii?Q?NEa2ZFfX1IBf1PuFavQk+AL3p0CYvmbCcz2uVqqzu1R95ZU7cR+Lcri/fxLK?=
 =?us-ascii?Q?jL4J+BMA00qz5Xc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 20:01:51.6742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54db83ac-0ab9-4685-efff-08dd2f56209f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7732
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

this original test condition is unclear.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 48c5365efca1..d40f07802c4f 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -218,7 +218,7 @@ static void ttm_bo_flush_all_fences(struct ttm_buffer_object *bo)
 
 	dma_resv_iter_begin(&cursor, resv, DMA_RESV_USAGE_BOOKKEEP);
 	dma_resv_for_each_fence_unlocked(&cursor, fence) {
-		if (!fence->ops->signaled)
+		if (fence->ops->signaled && !fence->ops->signaled(fence))
 			dma_fence_enable_sw_signaling(fence);
 	}
 	dma_resv_iter_end(&cursor);
-- 
2.34.1

