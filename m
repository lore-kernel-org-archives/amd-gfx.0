Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407EAE77188
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 06:32:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2B9A10E059;
	Mon,  6 Jan 2025 06:32:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dl3acRrQ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDE0210E059
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 06:32:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6RuwkSTvg8SdwvsI0OztZ04Yban2NNmsK2sU1crzgFPDMY96CbjeKMBv6tPgBvj5S/hMmItI7zZNnqGy5heVnXpVFpGaXNCc8Q5B9pX0nfREbXsvStww+Ff1WP1RqAbqOnr5x62ZCjCehBFsUazp6seSUwdX6FKQr/3VbY+bxFjw5o2y+oj1BYcHDb7pnOQLG2AnM2Sv4CKjMfst4Z4nq94Wupey/HNncJQgFBcgayIxhbpSDJjdkY9ZBsxfbyrFZNubSTcmphYC+jNQxIPldsKgdIJeCwPYDyW8hayicLyKrPbH3JmINg21wdYOwbA6UjMlTr0J08ysp54sGLJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdGqAteuSr5e5ECyPgi+a05wkvxFPMCxThlXjoMa0Gc=;
 b=j9upIN+i+WDISD2gL1TQ8SIMwDFN1HYhHNk+wmaMFVtIvpZb7MfsDRAk3/8bC0Nro9RqiTvT0XFOHKPfgmmUZxtQw8fOTRGYUDAI5X08v30orBuYx17U1pwDwoLZWuM/jzTYBf4pmkWfI544XlNRaQ6ciyD2NfhaF6pypHjgiS68zH5mGOnv4DSPBpP0zett4KmVG8vTO90fI0abLgHwB0vB4pqibIr+bEpifwhoi6zLuk7Z2yFKJ7SDtEh1muWGdVcqphZwt8Qc5rm2mkTfgJvOS2tXyXJsIYzyaJadavRXW4sFjX9YGQD8n1VltvKQOGF+v8/czepoW1xIQ/vvRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdGqAteuSr5e5ECyPgi+a05wkvxFPMCxThlXjoMa0Gc=;
 b=dl3acRrQrsS+9VvXPuMpVfms/WKL/xZSKho0CpDxP5V4hJzw96Ql8e0m1V/jXslioaMYD9ezfLCWTNu7JEKhC6PbjRxuD2nv7RW6qn+QOHdBVAc6YG353W+1jBd9WO5/uks/BKvjL6nLf3rOiQA33OeYDmB9srru3Xyzp/Hs/H0=
Received: from SN7PR04CA0210.namprd04.prod.outlook.com (2603:10b6:806:126::35)
 by DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Mon, 6 Jan
 2025 05:58:43 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:126:cafe::7c) by SN7PR04CA0210.outlook.office365.com
 (2603:10b6:806:126::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Mon,
 6 Jan 2025 05:58:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 05:58:42 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 5 Jan
 2025 23:58:40 -0600
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>,
 <Xiaojian.Du@amd.com>, Tim Huang <tim.huang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix incorrect number of active RBs for gfx12
Date: Mon, 6 Jan 2025 13:58:09 +0800
Message-ID: <20250106055810.3785461-2-tim.huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250106055810.3785461-1-tim.huang@amd.com>
References: <20250106055810.3785461-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0a58b1-21e6-4a59-51c5-08dd2e172cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rYjlJbM5iipdKSQ7e/amjnxQKk2whCbpq2Hl0X9IC5iFuHKpaXa3esjAThYz?=
 =?us-ascii?Q?hykaQHj2LyTs2IMszipm1ET1RnHfmWVdLcl4AJ+hwKQj58v9TpXeo3YDVzgE?=
 =?us-ascii?Q?WBMf22ah+2c1uOixmv8ZzGeydFFbaeQyioqiNmmeCaFGmOEm6AVMO4g1YZjG?=
 =?us-ascii?Q?rYuwiIFJ0q76wiJU8SPFjsmKBfQ/KtAy3Y4d9becRP9IDXlUTSG8ggp3HszL?=
 =?us-ascii?Q?PTGlkjn/F6NfypkXkIirG2kBdW4Uo6UmH+XDSp2QFBelrGswMbqztGtTtzlU?=
 =?us-ascii?Q?SB+gPwYCb/42TL0QGUccyEDrFuuD8GsMKQFmZkax267CQQ+ce3G9q7gdWyv/?=
 =?us-ascii?Q?/FWQwyTgcZOsFCahyooXBtq7d930OaJEffRkwN9n7jopbrTikgMW/DeRH44V?=
 =?us-ascii?Q?4BOEXyXm4OvqVx1crfECwSWKG0m8BU+Vb/kEbY9xwxkQ/sNEu4x9rlJRpONO?=
 =?us-ascii?Q?L7iYjRmwjQSIIPTgvFKDsEBiqEZgK8O7cxJakQGCbcetYB/YAD9AuAY8min+?=
 =?us-ascii?Q?dBqv+VJs/W1w8WNgi96Il6slLaiEAcLfJg0ReSDvypvw5X5Vjs1U2/OwBx83?=
 =?us-ascii?Q?03PPsVUTcammhjX+E3EsbGUh3LrbKvUAEv1d4bBVkKMx3rDdtXrVrZZJHWj5?=
 =?us-ascii?Q?1PNUOJiffAPBuec2dy/lmoBFRhMBXdVaseD3CO1H43S1C13pNf76876FFbHL?=
 =?us-ascii?Q?R5k7EqGV0RTJEDNB4ku2674fctMqy+NcN4FNV2suRuatoK6HDAiF+FZv/TCT?=
 =?us-ascii?Q?Z5z+9aS14e9Z6+NQW+lk+4t9PZVUP/ifgpJCeBdV1WO3kSxmo9wkWYUJys+U?=
 =?us-ascii?Q?K8CI/p8PZXsHqQHnv58SDcBPtpFWbfH0DpCK292X20P2SlrwKR/I3Oba3RJP?=
 =?us-ascii?Q?LV6H6cJiSLcBPPI09pp89APPgo6IU1lnkkmb0eTwcaQyk+SZOhYElBALEYFY?=
 =?us-ascii?Q?UXQ4SOPLkeKPUvd5iNaErx2FlnMUu/Kuh2fcNmdsOJlqzGkDpZzAYNsg6CJw?=
 =?us-ascii?Q?8ZjuNconErlhL+vMFQH3rHy57PtPzd8n1/6D0a0uxWk8iWkLiqZauHGTwZ2g?=
 =?us-ascii?Q?Mh1m6nGJN/k3sl5o2KET+OS0aqBPHX/wPkwLPjCWJUuz1nDPf2XNscj90Dfv?=
 =?us-ascii?Q?B39o3k53DPHeBChYI/kYnsDFCCrz5/qvhooyENfhVQM1mcLzoIVT7C/fw7iU?=
 =?us-ascii?Q?1o4X4H8KVXen35UHe8l2si7ZEYsk1tgK/pPe3qPsYL9O6+Nc8e9JisHsSNYe?=
 =?us-ascii?Q?7CUuB4TcC1yxDzN1OPU5Vullgz8wOVjn4HE4h1/8gEF9C5BF0QeU5vV935c0?=
 =?us-ascii?Q?C/b+y3u5r5xJpJnso+LsXR7Q7h6V6BZ8SdSJM0V0WMpxUE2sOWwNm9s/c+pr?=
 =?us-ascii?Q?y/HfF/0oSCBKgcVP7x+hoFozTilRmQJAfdC7tw1tkf2iFtoWD3+ySKZypJVN?=
 =?us-ascii?Q?Uks3+lcR3Ou8cvWnlPNVUabnUSvjgr9M+qWSloanSn7mttC50o+SG7A1HQH5?=
 =?us-ascii?Q?VnKa9dgFB9FD46E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 05:58:42.7590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0a58b1-21e6-4a59-51c5-08dd2e172cde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399
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

The RB bitmap should be global active RB bitmap &
active RB bitmap based on active SA.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 3aa34c55554d..f8d46651dbf5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1650,6 +1650,7 @@ static u32 gfx_v12_0_get_rb_active_bitmap(struct amdgpu_device *adev)
 
 static void gfx_v12_0_setup_rb(struct amdgpu_device *adev)
 {
+	u32 rb_bitmap_per_sa;
 	u32 rb_bitmap_width_per_sa;
 	u32 max_sa;
 	u32 active_sa_bitmap;
@@ -1667,12 +1668,14 @@ static void gfx_v12_0_setup_rb(struct amdgpu_device *adev)
 		 adev->gfx.config.max_sh_per_se;
 	rb_bitmap_width_per_sa = adev->gfx.config.max_backends_per_se /
 				 adev->gfx.config.max_sh_per_se;
+	rb_bitmap_per_sa = amdgpu_gfx_create_bitmask(rb_bitmap_width_per_sa);
+
 	for (i = 0; i < max_sa; i++) {
 		if (active_sa_bitmap & (1 << i))
-			active_rb_bitmap |= (0x3 << (i * rb_bitmap_width_per_sa));
+			active_rb_bitmap |= (rb_bitmap_per_sa << (i * rb_bitmap_width_per_sa));
 	}
 
-	active_rb_bitmap |= global_active_rb_bitmap;
+	active_rb_bitmap &= global_active_rb_bitmap;
 	adev->gfx.config.backend_enable_mask = active_rb_bitmap;
 	adev->gfx.config.num_rbs = hweight32(active_rb_bitmap);
 }
-- 
2.43.0

