Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB089C25B78
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 16:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F27EF10E17C;
	Tue, 21 May 2024 16:49:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r3+Q2NBf";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCC9C10E18C
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 16:49:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTyEhmTZ1543jLMV4W/d/vKljBxC5aAa12QYmXnUwv6xDzEMP/RJ4Y/eLdR5ua1Pw8qHN/ze2m+uF15F+QXLYEretDWZSFZf1ijCXQZ0XCMd6jc+enN8Nmj+kPwY3MaV1+ktQPPHpV5Nd3dLki1oBe7em0d4pMjallOAQ39+XcoDYRh3exsJx308xyyK4lfUw/dAH+s24BEFhrChMTM414VZn9i5U4yU0M890wMjNtXg19Ab6jxhA3OVsqFvi1sjRnmz41Nt5m4qggFWEbzEVjAIO8ek65oxn7/gCtt6NrYxm39Ssu7bI1og2f0n8kuzZJln4iDdro1aJwUltbravA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXlmczztTq8wEDxLON3OiSZy4WV6FNaxnyC80I4DPzk=;
 b=YDhGZ8pB0A+NwZ7rpTch/RMJWLv9SakhJIsXMyxYTRIxy34VGYLAfeMzGmqQpsnqC4rM9exHlibFnaVhEZr5rre4FCplPixmdU3A+jRXSD7u3hS08AZ3X0bCNO152+sxtlHoHzLd72IEdhxbfMLjJmgyiH1aWjug5sHdI5tVH43/wIbgBPGTZm4TfH7RJbHaKkILrF3nGzJBj0lWfsgJvwNsidSds2pVSYYwTWZlxa+HFNyX11f4ZTsxqmaKTH87RXiZYovaYN7Se++8zpAiT1wmTr+99C1r3idsCdAp9XB4eB9ECrwpZI67PLuJRmLk5BtBgBuq5WooNwS28gOSTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXlmczztTq8wEDxLON3OiSZy4WV6FNaxnyC80I4DPzk=;
 b=r3+Q2NBfePC6SOs4/ofx9dAlB8coG1sWojbEVDuvKifF9xSj1tTKL5uooocTGR6MSvFa4tlPLGgQuSA9jVNsCBfEV3EiQDrAn2DEm6EzRnK05fSmY0fF17veXOLRNodRSl4g4exZHI3gDOYPohoavzdjOUht0gBNLvXssYxTraM=
Received: from BYAPR05CA0038.namprd05.prod.outlook.com (2603:10b6:a03:74::15)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Tue, 21 May
 2024 16:49:04 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::87) by BYAPR05CA0038.outlook.office365.com
 (2603:10b6:a03:74::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.18 via Frontend
 Transport; Tue, 21 May 2024 16:49:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 16:49:03 +0000
Received: from birman-stx1-09-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 21 May
 2024 11:49:00 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <mlimonci@amd.com>, <benjamin.chan@amd.com>, <king.li@amd.com>,
 <bin.du@amd.com>, Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH v1 3/3] drm/amd/amdgpu: Disable MMHUB prefetch for ISP v4.1.1
Date: Tue, 21 May 2024 12:48:41 -0400
Message-ID: <20240521164841.36101-4-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521164841.36101-1-pratap.nirujogi@amd.com>
References: <20240521164841.36101-1-pratap.nirujogi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c09680-a511-45b3-8244-08dc79b5ec2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mmd6j3ClWNoMt+buZaiZautlTPGsZ4GEiYrWhsQO7TdQz5uzgSDG+Or0vw0H?=
 =?us-ascii?Q?qV0aY7ReFWLhgBdv84MAE0pRBz1JVHUTREb6hyMhwlHW4ZmVOq2PbGKltu/p?=
 =?us-ascii?Q?6z2eBL3MZjqT6j9ICpCWgV5Xk1f1mHt/vovy2ume154ozS84tkG0eRw8euUO?=
 =?us-ascii?Q?lyNTKGc9OV2BdTYJaUYCG7PutcywKXCxTrimrZ4WjYfozlQsZ2fphYBTMxl5?=
 =?us-ascii?Q?UvYkW7F6UNhNyDPyY1A8dtwTNFNIiDCAPINIq8zzxASIa0Mc43raQM02Ul0O?=
 =?us-ascii?Q?qKfXuJ5SPvWQ/s1BnAjKsa9OWYoj4/psvxVbEEYOiAB5FIGZ3NZ5fAGzFMk3?=
 =?us-ascii?Q?oQnXhGlYmHOZmIdfAw10qHr3V8zcWV1sC051j/C1La7De3x+1R81ooY5rmbV?=
 =?us-ascii?Q?UtGyFken667xMehtH1JfrYkGvLfYaRKEV8xK45iu5Cl4xDJp/RnhUs9nC1MF?=
 =?us-ascii?Q?6GdN60leR3r4T1wmj2QCukKGRyn30ZxoGNjGNhhKJ8U29Z6xRIKiy8b9piIe?=
 =?us-ascii?Q?/1wv27n+0hUbopzDNZ0q5iu4wmLmbe7MoUX7f/nTM1QE/wt1TTE9AlaP8H0/?=
 =?us-ascii?Q?CLyDKJuz0jKrmj3EDn+Ty4ldm6zjCYdBvD4ZM4+R+ZRNIdXWVCWUlH6v+Y7z?=
 =?us-ascii?Q?EfcUJJO8w4uJlMc1FwO6QRvpoD8G4IyzVKqzozt5v4SuRvvo9nrBjIbfIyrI?=
 =?us-ascii?Q?n+RSs4+j0mnoM8E6G7Vbpvqv1v+3BwmObiJVgFSnL4Pq1PUaAq+zG1AAZieC?=
 =?us-ascii?Q?eT6EnstVaawpoGhnFvkP7OxbfkkkuaZW5xQvUACXFXiuv3zsWE/EJvKmaO8i?=
 =?us-ascii?Q?kKvgtEBdExwOfwxAEIXxzw3eZEZ6asjVr+MVXCzfA0uzSthCC38/gvb9tP1+?=
 =?us-ascii?Q?TZLd6LGc6EYeQ/2YeXEaRVvFtSwPYlDlina0TmpEvOhBMKXwcoDaDzjLIuzw?=
 =?us-ascii?Q?Wgaua7ObNHZM6YJqqhz/3yvIaIZnbxKTGhH/z9aU9wxvWFSQKbdO3Abq8lKm?=
 =?us-ascii?Q?HgdRt8e6SRC5lBFztIzVbnQ81pioCjN+zP0zm/XKQmq36SW+zJ8ud31RGGVh?=
 =?us-ascii?Q?wdYnsHDqyQuC33B2NUGiY0bAzOyDUWED+WCBaRq1UsZJLQcRg3lXGWPRF65E?=
 =?us-ascii?Q?AFKXX3h447+ZwIDDBx5qx1yvGyRcZ6pwvbAy7RQ5iuqYKRjCxOItzM2f0xM0?=
 =?us-ascii?Q?VfkcslRp0eSHryK/aYlIK4YQ+t7bGdKPKAUIs7Tj6Jdn1oxgopufvAqWgmNt?=
 =?us-ascii?Q?/2AT+Enk3PuIZjPlpuB3hKWRffay6ZV1TBT4KqeaaSUhfiXmKfoUg/TofW0T?=
 =?us-ascii?Q?r9qEWtLZ8pDopfmfpsQtgH4YG312KNw6F7CEtoRxww51juogarg92Vh8P1/t?=
 =?us-ascii?Q?hKk7dYr0PLU0564W75GO2XQZimeu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 16:49:03.6677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c09680-a511-45b3-8244-08dc79b5ec2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726
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

Disable MMHUB prefetch for ISP v4.1.1 as a temporary WA until
the GART supports MMHUB TLSi and SAW for ISP HW to access
GART memory using the TLSi path.

Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
index 4e17fa03f7b5..67f95f05ecca 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
@@ -104,6 +104,18 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 		goto failure;
 	}
 
+	/*
+	 * Temporary WA added to disable MMHUB TLSi until the GART initialization
+	 * is ready to support MMHUB TLSi and SAW for ISP HW to access GART memory
+	 * using the TLSi path
+	 */
+	WREG32(mmDAGB1_WRCLI5_V4_1_1 >> 2, 0xFE5FEAA8);
+	WREG32(mmDAGB1_WRCLI9_V4_1_1 >> 2, 0xFE5FEAA8);
+	WREG32(mmDAGB1_WRCLI10_V4_1_1 >> 2, 0xFE5FEAA8);
+	WREG32(mmDAGB1_WRCLI14_V4_1_1 >> 2, 0xFE5FEAA8);
+	WREG32(mmDAGB1_WRCLI19_V4_1_1 >> 2, 0xFE5FEAA8);
+	WREG32(mmDAGB1_WRCLI20_V4_1_1 >> 2, 0xFE5FEAA8);
+
 	return 0;
 
 failure:
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
index dfb9522c9d6a..6bfb1de191a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
@@ -32,6 +32,13 @@
 
 #include "ivsrcid/isp/irqsrcs_isp_4_1.h"
 
+#define mmDAGB1_WRCLI5_V4_1_1   0x68420
+#define mmDAGB1_WRCLI9_V4_1_1   0x68430
+#define mmDAGB1_WRCLI10_V4_1_1  0x68434
+#define mmDAGB1_WRCLI14_V4_1_1  0x68444
+#define mmDAGB1_WRCLI19_V4_1_1  0x68458
+#define mmDAGB1_WRCLI20_V4_1_1  0x6845C
+
 #define MAX_ISP411_INT_SRC 8
 
 void isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp);
-- 
2.34.1

