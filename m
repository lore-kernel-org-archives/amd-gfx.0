Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF938C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 03:48:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30AA310E549;
	Thu, 30 May 2024 03:48:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0Je29nrk";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 287E410E549
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 03:48:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEKrXunCZxe0KJpXPlugcqB4j7CgqUqQY/GvWmEDIVxP0YtH8luJIRKbdDAR2qY1/Luk6ckZjD97/yz/uptSSZi8x8lmAlBTqW4+mAY7apQq+1CgJnz4NSTPOoVUP+jBkniMiXFqL2peLbvxgnAXGPvjtJa1VQuK8smBlxFMw3Jm0cnivPslFSpOxGVBtIFn1gbecN9ci4ooTMRqP4c3uAeGpNpmerQJK+bozyCpvhcsWLcPbd0yIAu/8bhEO4Tl/VJqDUhFyx438c6UTPbhpCuMmpCZaEh3ZB/QbW+JJyi7UjCjHK4n/Irw3WpU1mKBr7S+jJeMP8IuraUYK4pYGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmRqTLR5KltdKl2//AsjZgrXOsHxysSzmbIamurRzb8=;
 b=nR3BmN5YC7GYFTFVdA3N0EB3jNEZTAFpovSGnMWPH6fHy3mggOXEnAXyYjjZGrpdmHwVKZZRH+pnnu1q4mjiywg37jVOgo3QkZ1gTzYUtJ3ozGS7at+flc3ys8EdZqN176dbvwfBWUQSBZVRHFV3eBJ/Rpk8zuujfcEm0wnPoNdSYsOULbapECv1keO6owFuWdFEhD6Si4zdIlc6OghuhiAJld2wKkVgVjq/6vgWU8sFrBspuFGtyhH2OimX9HD6PsvKLJOvdr1S3vvKXhXX3nO9UJivabW9jX1WDDkYAYcksi9CHJpLXd1z4jNJEEonpzDHb7oPVcTlUwDj9DPGoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmRqTLR5KltdKl2//AsjZgrXOsHxysSzmbIamurRzb8=;
 b=0Je29nrkuunZdXvZbdNHGIqmCDbDNR+vpT6G5saWp6aSULfcbrUhb9CAu0Gxoh2v3Yu0PYiuejVvisUYGg5LFi7wknrpNIuZU+QkjPBfj8D6hJvWiT0peHvaGM3M4dteTZfY9OfMVo0d15ALrk1g2FvA7YqSj1EMgaAXc3+DsfU=
Received: from MW4PR03CA0278.namprd03.prod.outlook.com (2603:10b6:303:b5::13)
 by SJ2PR12MB9211.namprd12.prod.outlook.com (2603:10b6:a03:55e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 03:48:38 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:b5:cafe::bb) by MW4PR03CA0278.outlook.office365.com
 (2603:10b6:303:b5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Thu, 30 May 2024 03:48:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 03:48:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 May
 2024 22:48:35 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 29 May 2024 22:48:02 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, <jonathan.kim@amd.com>,
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 4/8] amd/amdkfd:fix overflowed constant in the function
 svm_migrate_copy_to_ram
Date: Thu, 30 May 2024 11:48:01 +0800
Message-ID: <20240530034801.2341277-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|SJ2PR12MB9211:EE_
X-MS-Office365-Filtering-Correlation-Id: 20a27f14-57a7-4ec5-bebd-08dc805b63ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qgm/5XkbGbpUa55P6PZkDGXhzwELmGjZJXBGQ9Wti8RVYKEGrOdCB02Xfopb?=
 =?us-ascii?Q?HqpIFxadexdqWqhO0vbGLdf1T9DhDs0VKTz2CgEM03guhXFqaA9LBQw+Ufsy?=
 =?us-ascii?Q?0C2Xo2VRFUcEOuIx0RwA/rFeLzzURtIB5kxQpRGTypJEgeqVPABvAEdGyeTA?=
 =?us-ascii?Q?L5LyMt2OsH8bg29WfF1CX+xLgGYYb6ieBEwzOPedu3H5yaMIgsLShltSrdso?=
 =?us-ascii?Q?BWu4QZtLMygaFWwyusCvIXEuiSbZG2O3Ds/aIVxeyCorrGWww/E97ADVmOsm?=
 =?us-ascii?Q?97e3N8AjrIpvFEOjsghrj5kYunlnTkizJCH1az9rYT9lE0OYcBEUheIZlEvu?=
 =?us-ascii?Q?+s9zocgptLbydFckZXJccIAjR1OJxXs9/rTmlQbNhFP3KpaV8cD0JVbkg3FG?=
 =?us-ascii?Q?wLp6UYS5d4nEp1sn10P9kE6h0nSMx0avZa++oEQUwTY6glvWbmYkdi2D3/GR?=
 =?us-ascii?Q?Rwoc6cAiAyzEOycBppwsJYLBJWziHgxiqS5CrTwrhDm4NRxB+K/rOCxO/KFM?=
 =?us-ascii?Q?aLAnCfNYmWpqTRNVxrRTxfqOL1QCBWIbw5tZz7Fn1hRyXSuM7KwTmt0VwNAq?=
 =?us-ascii?Q?ew4zvLehNHmnddD/9Qotp4pv+9yusfATjrYYUD5epGc3ud1auI1a+LHyqnxo?=
 =?us-ascii?Q?EMPtkyrpXRv7x1BmMDAprpICEke9AXjJpMMz9Wmm3ZQL4rW97S03zqI4sD8E?=
 =?us-ascii?Q?krl4wQiNlmVgqcoi8cMLR0Zd+Lg2N9MPXGs0f2K9W7/CP5kXPD37hQRvxCu4?=
 =?us-ascii?Q?FIAyvyMOBGXlnY7iLy9SkvfK8MSS8jm/qXmWwC3oN1GK921dHQxTFCNagEbL?=
 =?us-ascii?Q?sqX0Ts6g+wP163+syaeuQaz3eAVhMO6mcmBXAI19wsJmBnnQYOApGM8FttbQ?=
 =?us-ascii?Q?FTfGQtp4maen1H74ts5TEFupbiSwEyLSgrpXb8AzZ9g4rs3hlzcibiXn+xAa?=
 =?us-ascii?Q?EJZIRceNJmflNCeIMKSBgQNDAeoM3/U3AiCCbSpci+KNPtXni0HNI45ZjSTs?=
 =?us-ascii?Q?eeEs0nJjJUh/hqgNUjArgsu7D+mxbVAUXut/DzfA2rMoVi06hEW7BFMfpYhg?=
 =?us-ascii?Q?Fnu1oyn9aWHYX1hmOa2Pl9pVwrcI8T5Ps2KRZzlOqCw91QyCkiDwIz1U3F64?=
 =?us-ascii?Q?drT0h7tpV0NshmgjG2+XWw/RI6WJuPx4Y19camx2AEolRzKUv/fPJG9xVZO9?=
 =?us-ascii?Q?KwCX2Ii1umqBf2bGaqhnAab3ACo3w54c6sqPBI4PTrxV43AhsajGX3Di7VG+?=
 =?us-ascii?Q?quYdSvwK/KvH8Ax1WGW0ci1Lc3ITJ2BLps0VdhxMUJxTtszrx+vC+DLr6ZHo?=
 =?us-ascii?Q?gsWHAan1GpUoq6MHajxaM9vqX6EQGEkDc/9ADkWZkZrL2n6/01RW/xfkJN2/?=
 =?us-ascii?Q?ouAP3L3fBf7Jl3J5ktaJJ9QDN68N?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 03:48:38.5331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a27f14-57a7-4ec5-bebd-08dc805b63ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9211
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

If the svm migration copy memory gart fails or the dma mapping page fails for the first time.
But the variable i is still 0, and executing i-- will overflow.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 8ee3d07ffbdf..3620eabf13c7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -650,9 +650,10 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 out_oom:
 	if (r) {
 		pr_debug("failed %d copy to ram\n", r);
-		while (i--) {
+		while (i) {
 			svm_migrate_put_sys_page(dst[i]);
 			migrate->dst[i] = 0;
+			i--;
 		}
 	}
 
-- 
2.25.1

