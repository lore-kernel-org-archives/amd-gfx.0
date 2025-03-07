Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE878C3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 15:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50D5E10EBC4;
	Fri,  7 Mar 2025 15:16:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YD86F05W";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB37D10EBCA
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 15:16:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mt1/1/O4/llXEG8+ds1kx+cqD2r4u3v8emYdWCK2dByyWa7sJbFjZVw/cZ6QdDa4cL3xOlLnDoqazPGJ5AY1HknMgcbm8t8enIzHc647yd8iy5HxfCrl1p7vtkNLfOyZS6DJznSIi/sHjVK7DrFzKmT+QXEtGBs+caGyYzGJkH3yqUOIG0tBxO3gAqtMMYawu7Fd0VhJ7G27azEtGAfiCPSDMBKrXMxN1LpVDfPzFB+GRboVOz2pNnWzXyz6tBCVvhrp5dIaygdbg8H+dsztmKb4oZFmc38jwtI2wHygiR7zQrOz8GWQaWuoNDEHGGuOvn4jl3t9BFv3H8UrileqLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9dU/GklxPGXzK6dlb/uYfQ5XlrRY/EgWGCiYKEN4+E=;
 b=mxfd4hwuMfswUGXYl0auJiuDY86BKn8N/skareR8bU2KLiE7r/zjAn0IZWRbQpygtTmTJHeYDg/ha3EGMux6M+BsNJ1TmsMXquaaZcoBvFb5v0GtqACZ8VmNNNLZ3QqotuEQQujn/u/iObJsdIQhSKLtWQoH0A9j1NfqpL2ygOkgtDIGScQX+YC7IZU0jVu9XPjsQn43fl5Y4wSJhEZEmpdG8yGkI51/rl2k3JuYA3NBHNedGDicC+qu9b+LKJnB66hBZJJ5BDPcMBGC6HHjxhlDwBzYPCVX5ZFMtAhWcSSit0GE9j2srgJL6yIgQyk0q+N+bswhlztBdzxYeP837w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9dU/GklxPGXzK6dlb/uYfQ5XlrRY/EgWGCiYKEN4+E=;
 b=YD86F05WGwwwhXi5B70U/56fFhBoYQa8RFGIBL1iSQXqId7GNpuPjecSqEG9Rl3/ST+z0ts3t3v8DXjP5frxSKETnb1zCmKGkOjnRxyjwg1OmQl2QXR/CAnY+rzX3GcfBfkuHZzjAYoa8WzckEso/g7InkwX5cQxbMP95uKI9HY=
Received: from DS7PR07CA0003.namprd07.prod.outlook.com (2603:10b6:5:3af::11)
 by MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 15:16:21 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::8e) by DS7PR07CA0003.outlook.office365.com
 (2603:10b6:5:3af::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 15:16:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 15:16:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 09:16:19 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/11] drm/amdgpu/gfx: add generic handling for disable_kq
Date: Fri, 7 Mar 2025 10:15:57 -0500
Message-ID: <20250307151605.946109-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307151605.946109-1-alexander.deucher@amd.com>
References: <20250307151605.946109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|MN2PR12MB4128:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d64fb36-a902-4f58-371d-08dd5d8b0460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vKCwTfT1UmWuQqtImB7lbtM11eBfApk169mYgMn4XMLIlJoeT5Tds1pFxM7k?=
 =?us-ascii?Q?vWDqVy53/nlhqs1vGcrAp7eziGGW4SQ7i6ptQqwSJXzITv65jlCOm9RtrduM?=
 =?us-ascii?Q?9QF5gR3GHShHkV893lLC49cIpEtEKPMYSIOpT3RHTE7WaS2JREDucUTPaY2+?=
 =?us-ascii?Q?F5QTXkK7WaHRylCQtowGDuHXTNnjLiVDvzVGWR8hSfWMVc0VBKVaGfxmHIQW?=
 =?us-ascii?Q?6U+UGqAGLG5X9oVAMCpWr1s6m1kwDV7JBK5iD+vIe8SqCNzN3zYBrXiGr3vz?=
 =?us-ascii?Q?bMG7ksZiZGOAea0oJFkioa8ENyRr+0mc2VBzit592OWWBIuIAxlZrbPwcYbT?=
 =?us-ascii?Q?AwCHyigKbt5j8c2tD2rtEiM23tFyANqEm0bcjkEsmHrieE1ZqMQ/BFHc7dw+?=
 =?us-ascii?Q?LcVZFAroP3rWYHno6goz4KHhIM7/bSeLOsuNv85hNFbXapKLfUfzbBXzI7qx?=
 =?us-ascii?Q?MI8LBF576Vpi0fpmYT5alSRiF697C+QXi+gSkmtP23VwL8OVT8QOUpEimm4n?=
 =?us-ascii?Q?ljcp4ZsigR6lZtMpS17SdCnMw2uOGJx+02IpgJeKwItAKEATtOHuJI21RSnv?=
 =?us-ascii?Q?m3sbVTB6tmPH0a+tdTqrfwVt8OLNmh8n8HQFCERafumZvyDg8qFaTJtH0Yx1?=
 =?us-ascii?Q?Dn1nVkmnRyplsmGt+D7WMLzPAu5kpi9DvraoWaL1baNgFi2gQ/qmvEzKzxoV?=
 =?us-ascii?Q?z1lcEuggBfZUTnN0RjR1nxmnccXWEktALd6GsPFk6lJtfyhpSj3YWdJr0uKd?=
 =?us-ascii?Q?YTT7ubJ4Xpq24VU5y/qW/kSHpfhIzh4ICfBpe01AyCA2tLNcTSvIC0ahCW+p?=
 =?us-ascii?Q?Hq/xvt5HZkkxKpqN5YIfEYGG243xRrprrsYtlUYITREfWBW91j3NChOdSSL4?=
 =?us-ascii?Q?IQFnzeINor66CO1iXucNG5+sD57dXuos1DroTB9bRZzDfFuzra+Nl9YOC753?=
 =?us-ascii?Q?q4fGwx8umugdf65705UuMrkLM1NqFhqn1XdbwfyvQp232lNl+ixQd6pN3907?=
 =?us-ascii?Q?lSchRObvpNKwg/JcThnj6OsKs/t7Qx5f6rx1iWDEqyJdwpv+GvTgLRlIUdmk?=
 =?us-ascii?Q?Bc9fE1HJzQbPIct6KJUVLNctvRkMHQasnLf2Cjmw0ySVev3mK4QSHP9v4UpH?=
 =?us-ascii?Q?5MnqY5QPMdVVjBHastcUNQuQxrZHiMis/oCEhFAyLltDrHWcviz+CjKUd45o?=
 =?us-ascii?Q?EvdtxXjvIYJ9qTXKq54dMRfTxwO5NsAPKUJCywLs0aCh60Ispa58mJIXbE1I?=
 =?us-ascii?Q?ZZymFStSvqJf1q9YW16hhAy+0m5JZ2DfaznjQOimnAPQbr9rA4K30zIDycw3?=
 =?us-ascii?Q?XchuE36r+3KBaxsvqCyASe+8/P5BqhkEU1mV0nbeIirkV2IQ04bF39gEpRRF?=
 =?us-ascii?Q?ll3m2n3mlOPxiMKrfmdyE5GRaxZprJSssi+Ml/VMFQJkk8aW8uTrrWT/YQ3U?=
 =?us-ascii?Q?IjCHFtE7POZ/Hjc/mW5X+lbinyKMfusPy/MNYn7Sn2B/aX+igxub3bo8wMac?=
 =?us-ascii?Q?uAwkjX0HEldg/bw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:16:21.0792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d64fb36-a902-4f58-371d-08dd5d8b0460
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128
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

Add proper checks for disable_kq functionality in
gfx helper functions.  Add special logic for families
that require the clear state setup.

v2: use ring count as per Felix suggestion
v3: fix num_gfx_rings handling in amdgpu_gfx_graphics_queue_acquire()

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a194bf3347cbc..2c78185a33218 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -258,8 +258,9 @@ void amdgpu_gfx_graphics_queue_acquire(struct amdgpu_device *adev)
 	}
 
 	/* update the number of active graphics rings */
-	adev->gfx.num_gfx_rings =
-		bitmap_weight(adev->gfx.me.queue_bitmap, AMDGPU_MAX_GFX_QUEUES);
+	if (adev->gfx.num_gfx_rings)
+		adev->gfx.num_gfx_rings =
+			bitmap_weight(adev->gfx.me.queue_bitmap, AMDGPU_MAX_GFX_QUEUES);
 }
 
 static int amdgpu_gfx_kiq_acquire(struct amdgpu_device *adev,
@@ -1544,6 +1545,9 @@ static ssize_t amdgpu_gfx_set_run_cleaner_shader(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
+	if (adev->gfx.disable_kq)
+		return -ENOTSUPP;
+
 	ret = kstrtol(buf, 0, &value);
 
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index ddf4533614bac..8fa68a4ac34f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -483,6 +483,8 @@ struct amdgpu_gfx {
 
 	atomic_t			total_submission_cnt;
 	struct delayed_work		idle_work;
+
+	bool				disable_kq;
 };
 
 struct amdgpu_gfx_ras_reg_entry {
-- 
2.48.1

