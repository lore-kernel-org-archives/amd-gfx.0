Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0E6D65C49
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 14:02:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63AB510E721;
	Wed, 17 Dec 2025 14:02:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4m5b1u/y";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94CA710E359
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 14:02:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWa8wFJnVR6PKivoeycv8wSsNlwVZD5mJPbNblG0S3JmUMHdczT5/10ozJAx1IBPpipnghqiamCqljA6LCUeJdxnxL5HCwtut6o6Tbh7iLsQgODBhpfrOCLrNpdFgoAXqlGCm15hRMT864J/7joGTzBEVefecGTH9RoDAP1nR2ZdtxcGceOys2p1FpLOs7JvQoqm3JZeY0hTXlcwQQ3VBTHutziacuk5Fviuzp+PdEyuxaSvWPfxBOitgEuIGzjkNpdJf6IQp9UduWtVhFFUhMyIaibv8+6jPiaugenfuIZ+v1Fg8yudHTC1+lyMmZJPvBVh/GGUG7kmCBGoSLck6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9z1Jd8VPxzfeV65cBraVt+H8uQOy0asZMthjIsVnfY=;
 b=y7ztXJeXALA1LpHr0lqqLqng1zaMf9JwfnG+vcRq1mqzhG4/jbZI5TpFhtIege9Nwk7ttpovWTROzWHX9apOPAn44sO/oeIIUIN6DAfWjxdtj5qMXFlj/8eitZa/IhYXwjNWmyC9P5Fo7MzlfwrdDfIo+d8I+yFJxdDsp0TLsTP2qTxla/3jsD9wwazbSY3KUUhALF0ar1eCgTdhdb4k3nmEIpSuVrFXJgfCPoGc0HkQJXHjCbz9zb2/c/rpjfVpeR3WWLztrZ5k+ge4/lvi3+WCjELk4HveQkgFvSxN3cpOJi7IoSnSGVQnPpZLvRQI5cji9yyMbhF8hfdaUutRVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9z1Jd8VPxzfeV65cBraVt+H8uQOy0asZMthjIsVnfY=;
 b=4m5b1u/y9DKLkdZ38qvavkRsw/23I7GVD80l/xhju/AIa+N2mJ/xfUZR2AUcLhDiVxwpLdpC34qTq0Y8Ju9fOZzWcHG/qXxascj+VECITXa07BFVks0T5Zr34/t5Oc2/iPhmdp7doWhPyrsjQ+iPUeNVVnmC+PbJAZwIsfW+vj8=
Received: from SA9P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::10)
 by SJ1PR12MB6073.namprd12.prod.outlook.com (2603:10b6:a03:488::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 14:02:07 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::9) by SA9P223CA0005.outlook.office365.com
 (2603:10b6:806:26::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 14:02:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 14:02:06 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 08:02:05 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/radeon: Remove __counted_by from
 ClockInfoArray.clockInfo[]
Date: Wed, 17 Dec 2025 09:01:51 -0500
Message-ID: <20251217140151.1984057-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|SJ1PR12MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 20f398b5-e35b-4ef6-cd8a-08de3d74dcbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RwxPySH4/Eq+Ib9aOmOPcNnShJfcwMAftaEvnkZurz+pT6Moxy+XDLe+Hxxt?=
 =?us-ascii?Q?BoHahWCb3eSIiiZxvHqyOhetIJgwSp7/gsrpkjlY/BtREcgUVxaB3KL1txLK?=
 =?us-ascii?Q?lCNsWtyVYdeJJheMYMdS4NwahbeGMfhPnlYfvXq1n15EQWpB3OOKoHTNeFrg?=
 =?us-ascii?Q?17iLAoz7BERjBkdBXn9sLoV818VatIZAo41ksSXi6enssJo530pxJNTyRmm/?=
 =?us-ascii?Q?PynEhXOv31aRs+rfr0YmEcyNPU5/5EVxQwVnpW4ZV7vXRbf1iwA4Ed4YG9cT?=
 =?us-ascii?Q?DvTjwA4UKQD6/RiSPRhM6SGkl4ktu+UDw+X4ZXqJytbShfWovcU6bcfl9llg?=
 =?us-ascii?Q?4wmv3fXC1kVaSH8MuIDUMLsabz8kx8NOIn3sh2cC2J9eY6/bR3TKk55zP4gM?=
 =?us-ascii?Q?9cfHSCvVPJaQmf7b8NNsesfOEfMtlwBpnB4swlUeQeQe7diSUzZqbRtsj+vQ?=
 =?us-ascii?Q?QGoG/tMjgNyA7nGqRkpMSAP33FdnipYfsrJLucLyeTTtRNWmrcOcdKXqR/QZ?=
 =?us-ascii?Q?eb1c5V/hqJfti0qk8RveYvyYR+Y0WrE8eRLh6sKtJGaruEpAwm+6K/S2a8BY?=
 =?us-ascii?Q?kgV2OfHWDrAWueKNWNcWMXDEmmyT1E1fTPPbDWvX81WboXHo5IholgWYDp6j?=
 =?us-ascii?Q?Z7ijacB0gj5J3VrvhtpdelMlpljgd2HW0M28d761eY/lvgbB1XgvE2EfURMB?=
 =?us-ascii?Q?HwSpqEXX/i04AdUVvL8crKprLS9t305UtVFy3QdrKCI5VtdTkiydMyERrvxw?=
 =?us-ascii?Q?o/flcTKZajALvjqs/HhT0MB2iXKXkITM+PQ/5mEaRt5VrVB0EI2AhNF0brps?=
 =?us-ascii?Q?BVI1HF8hix477c2C108naW1M9OOBKrzsy7I3iCvWSiBrMPOzweHWBGsvKLP9?=
 =?us-ascii?Q?FumxIk13TLjoz8d3lCFDFExvBtz2QwzJUjoVBrW81mJT8Pl5+iVZCvTjZu0I?=
 =?us-ascii?Q?wHtYAQT8npB6fXsa0JY+sJCD3KB9IhCKyoF2XXiW5UYCEgUIEUpn4tuY3RTW?=
 =?us-ascii?Q?IXlxB3sGuGTWwPdkWqDpnns5+qX2ru/vZFXHhgEpf+5/9Ey4OhxydEEfUH8z?=
 =?us-ascii?Q?bkzrqws2xZWiUyxX8G8b435Wi5K/iBgZJCrBwsrmlOpcGdjNTte0BNLB3jxq?=
 =?us-ascii?Q?f0jrAK/tpDlzr4P3KYhx2cxha1PRyErBb1DpPOlXsuGXIzXB6OI/FY2yVT54?=
 =?us-ascii?Q?pYbaLyxJKCkrMGnibPVmMpWWLw3kHJobfUBirFsalqawNjuFI3Jr3wmXF/LF?=
 =?us-ascii?Q?i6C6jKrlPqpswCxWbAtlY8zZkjrb48tPsG23En5HZRgAOAlm2c8bOSNsUpxU?=
 =?us-ascii?Q?FwQGFnbh2gCk46i7/kDzSP8TPB083JOJOGVrmF4w07ZG3GxZ25dZvbUQvqur?=
 =?us-ascii?Q?GgZbjHMUqkE5gPObxMJiL44phI5VqIj/udPavHtHepH+H+f4bU+nxGGXIeqY?=
 =?us-ascii?Q?tjsadi8PnjBB1Q4huHZLhPnvmZvCQ0K6rkBSclzkpSpS3H4XMPSNaBELF/fC?=
 =?us-ascii?Q?oGFjxLII+7mfdn8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 14:02:06.1711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f398b5-e35b-4ef6-cd8a-08de3d74dcbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6073
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

clockInfo[] is a generic uchar pointer to variable sized structures
which vary from ASIC to ASIC.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4374
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/radeon/pptable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/pptable.h b/drivers/gpu/drm/radeon/pptable.h
index 969a8fb0ee9e0..f4e71046dc91c 100644
--- a/drivers/gpu/drm/radeon/pptable.h
+++ b/drivers/gpu/drm/radeon/pptable.h
@@ -450,7 +450,7 @@ typedef struct _ClockInfoArray{
     //sizeof(ATOM_PPLIB_CLOCK_INFO)
     UCHAR ucEntrySize;
     
-    UCHAR clockInfo[] __counted_by(ucNumEntries);
+    UCHAR clockInfo[] /*__counted_by(ucNumEntries)*/;
 }ClockInfoArray;
 
 typedef struct _NonClockInfoArray{
-- 
2.52.0

