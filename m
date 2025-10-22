Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC117CCD1BB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 13:24:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A949B10E783;
	Wed, 22 Oct 2025 13:23:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KJDYjtHJ";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012020.outbound.protection.outlook.com [52.101.48.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4398F10E780
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 13:23:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVniyMMbEpljfrmwDldjEm86/h0eyq4lmdJSHzjCosXaCebBdc5LvN3XDqhlc6ZWBcPpjBneqKxe7v8as11M2QnVJLJ7wpk0G1RxiUfIv3ddRVNF6wG9cSVf4tEAQotFUQX0Ez+Wy0zgY3bCXi1yw4jXRHxWY6wy9SteEJy4Fpq/13tErngs9WcPpYxTwYtCdZ+ideAJtkBqHy8YRxEGst4HrhRZ8Dhq96CBZT14VHPzTI0q7uJn8E1JzyGMPEmlIY8glWyh1uf6BBD2L2m4/UsR0sGt8myc/oxGpxFWZvkeL1jd1BbyYU6esNFH6T5NYMrpUzipsPPHVWpxfiolKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGKX9S8Y/CcpB8qXfPWzTXEl7TkSxZ7XJefKhsw8I50=;
 b=sfrut3nJeQO3VAGnJOpC060cWFGSqx71KC+uP0Z0jLzOujKf+FpJkbV8fC07sKNtLZAon2N4EPgk6jFV7GILhGK8YcxR3Bz6yHZ140+JRWZpWSEu440zjLCiT5amjovfUcit/uXHFzd8oWSnemHNZ52p96BkTd51+5xm9bReepTKbZoB+brQOnnRkm+/owlkjCnxvLIuXC8lsI/VLuz66AG71XU0Ddgp0WnU6LW9n94Jn8RBPJiIE50swoTH4v2v2eQRNNg1qy17QKPe4lFqeh8yeSOjhOYma2wbZ/jhxRMJU3XjilM/bZPU7hLSnLSTXFbm1jioodqbYehnILQsUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGKX9S8Y/CcpB8qXfPWzTXEl7TkSxZ7XJefKhsw8I50=;
 b=KJDYjtHJSpChYPS0ny796hz6RUrUC7mQr/73GfuwJz2/KnqjweeF9AkAZT1Fhor4d/PQoEakzBpzRW//VZotDj1CGrPPvbAGuMOk9rQUYNTCFM4BMb1DNfSjYqPo5aTLjUN0fGI/gTY/ZdLTXEvIkEvsvaKw7Bh2jQDn1+bpDU0=
Received: from BYAPR11CA0084.namprd11.prod.outlook.com (2603:10b6:a03:f4::25)
 by PH7PR12MB8795.namprd12.prod.outlook.com (2603:10b6:510:275::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 13:23:54 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::e5) by BYAPR11CA0084.outlook.office365.com
 (2603:10b6:a03:f4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Wed,
 22 Oct 2025 13:23:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 13:23:54 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 06:23:51 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: fix SPDX header on irqsrcs_vcn_5_0.h
Date: Wed, 22 Oct 2025 09:23:33 -0400
Message-ID: <20251022132334.977886-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022132334.977886-1-alexander.deucher@amd.com>
References: <20251022132334.977886-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|PH7PR12MB8795:EE_
X-MS-Office365-Filtering-Correlation-Id: e18d5ee0-39a0-47f9-fc2a-08de116e3fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jqn63O77utGOitn7/UlArVeP/+DrdIwZ0FGfPnPK8ih+7GJhTdLKpCsfOUBk?=
 =?us-ascii?Q?fx5RbdsjIxlZ6SVGKxDUp/f1asxUlbPXdzmRgm6Z/kFWTxFoY7aYLtFAuNN3?=
 =?us-ascii?Q?8ED4IYJ4B7v1geX4F8/YaY6mp1JITJ4yKYR8iT3KiNDhraEFJbXDhHAjs5h1?=
 =?us-ascii?Q?rK9ucUCKtyOCKT04OqVkosX6KUddOxRTXoqwWdmrpJc9w37RrMBga8ZO28Gp?=
 =?us-ascii?Q?YwP/oewO1BrguDzkaUXTzZ9xpEJEjB8M1bbRYi1Chn3nSOtaLWWKNDDucBhK?=
 =?us-ascii?Q?lN//XNa4fI1q3QDYiysAOO8N+XoeO2A/0sKIjLC9mcNaFRqnRN6AD8JEYHja?=
 =?us-ascii?Q?cETW5/ffjV0naWzLAHcTsn4SZFtOAN2uamcyPHtUk0vdeRxMAfTyPKCjP7M8?=
 =?us-ascii?Q?HfBu9kY1JlVxVZ66D7Lc42VsM+HsV7RkWXPHnyWhoIj4YviGq0sqsPuHD1sZ?=
 =?us-ascii?Q?FqfOGmYqdes4fuJMYzMxepnS9QoyWLHLb6XzGi+fNJx2LOH2usnlonHo+QAv?=
 =?us-ascii?Q?wyzUItEWJdTXGuTOAz5Q//vGNaCZ+hTiFv1BziN4EYpTpPP54TtfNpFUWDyy?=
 =?us-ascii?Q?oMaiE7yQIo1aWbLAHbmQZMfPPhW17IueMx7MGuH0PmIWOZRxXPDKA5Mwzf2t?=
 =?us-ascii?Q?ftZk1XliyLG9TwrX+4eTYHDgxOXG36Of1706RT+VZgLXkY4Y88LB1orlXDc2?=
 =?us-ascii?Q?ksM/FG9OqWD/m1rp7CvIZ/YbiCwBfX2WODIfBCihqjL43w/C/ERgVWoP4dvS?=
 =?us-ascii?Q?jttFl7VfShZAjUOQ998nyLsvor/JS+oljKpSirOU1eaYucSMZ31FnJloQz82?=
 =?us-ascii?Q?XcEtJOIwMFvoL9m+tGvqoE3uJaUec1RGIpdnb9vwgIWjqeYpIPFNg9jOMG+/?=
 =?us-ascii?Q?GDdkGsl2XGB3yQaIYnDQ+y3ewrT2xUtJHFmYew3zberfMGEeHkgeJbppNrjN?=
 =?us-ascii?Q?rLOgonwAK31oyCOx6hqz4j9HRdvK1u+W/rmTiOfzuGqikzsIrXtcmHRL+GyY?=
 =?us-ascii?Q?vId9yFTJczslEwto67lkMoGctNVES4RRqOHygtDDfwU79AuZt3ofesJrdbRy?=
 =?us-ascii?Q?NC/8DB39dyISOXTfipsEJpNIdTTlURAmbyEyko86qcAdAFTgaTskD9n794wL?=
 =?us-ascii?Q?PgR9y3raNFHa0IOzrj8Et/Jmoui2MM37bzYsR4fGciCtTpsMEaSWXFqnL6wl?=
 =?us-ascii?Q?j4+q4s2J6Hkc7YhlPecCRrOMPgXoAcCXLki1dgLKbGyh+mPILPJDEBJnBsmx?=
 =?us-ascii?Q?19hZLmBvL8LF193dZ9DO+wJE40P0q+Z0nNkyfDg4VqAKO/LUm9Pv1yA5ZXVP?=
 =?us-ascii?Q?nUUnJ5z8ou1/wO4Tc893yDsRA6E1DqaYcTht458+jLzanByHBJEOaE2Hi3DU?=
 =?us-ascii?Q?vly6lQnShh6E8Ft8ao8/OYZuE0/eLOVLwjrLutPiPKJs/qCGpm5jhkggKIc6?=
 =?us-ascii?Q?eDBfO1gmMdPSxXUduhisUatxsNEv6W2fIm1JMz+2YyHlzBDO9JpwnfJpApti?=
 =?us-ascii?Q?OSmsKA03ifdWeKI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 13:23:54.5996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e18d5ee0-39a0-47f9-fc2a-08de116e3fc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8795
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

This should be MIT.  The driver in general is MIT and
the license text at the top of the file is MIT so fix
it.

Fixes: d1bb64651095 ("drm/amdgpu: add irq source ids for VCN5_0/JPEG5_0")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4654
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_5_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_5_0.h b/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_5_0.h
index 64b553e7de1ae..e7fdcee22a714 100644
--- a/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_5_0.h
+++ b/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_5_0.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: MIT */
 
 /*
  * Copyright 2024 Advanced Micro Devices, Inc. All rights reserved.
-- 
2.51.0

