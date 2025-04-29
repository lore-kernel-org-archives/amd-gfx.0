Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95D2C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 15:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CAB510E11F;
	Tue, 29 Apr 2025 15:25:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ic1hhbPM";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54FC410E11F
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 15:25:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Co/ncpOkg5BrxIlCIfkJrikYVECclAnAEhbolLT7aIwrovXfs9tTlamNV/A0dbSt2cf4ql76alx8JU3yeTlbQTolMM+4DKIrgsBig/AUSne8skkm1UPs+tz9Qf4Cf5DCMI7rEoRygoB/4rNy9CJ8TzKOEmfG9yfwaS/gTS2ePSxI5862/7RqegTabwhMBVTiuysjbabcCG20XaD67/xFo68zbs/8sKaRrlXo96mg0C5/TkHpKym+1zsjfKN8h259eH2IQ1sQCLZWYBPV6hN1PFgeFvxq610fnrP5gzVpe2OMdDKAE6w0e6y0hRMfQRCP8dXWUD/rFZOy1zkJvu2yEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQm8d6N6IJgIuAQDiWFadxjXTEEmjLygbHp8yfTfEwk=;
 b=UadY0ud4VsuN9GqxRgIrxp1z+gckpXuCAVZAOc5dU0X/qhXrL78rp3/e1IJlmtzBSevcFcn3uz3C2qgkDsAqh4M95uzjdc0a8UourzvKMzInYby3lAGP3J1RS07BBAG9zVinSaUZ+l5///eBja/X2xl5qM399nRUGVmwqTJF49lfX0W4vqJ0GR2+hLLJJb3VOodWMa7QERcKjIwfrhx30ewm4PjunCNLslqdvBoY/EUk1piwPXFvBhQJSNM5vmJy/BHnqzSqM26ned4cY2Sfugiqkh0xIDhfJIQtW/h2i91eRAZyLNXRxjI8EcHcICERWcAfI9L3cszPrDxbEdFYUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQm8d6N6IJgIuAQDiWFadxjXTEEmjLygbHp8yfTfEwk=;
 b=ic1hhbPMkuMoTQAoglB2rcFqS1PTgxrOXKKzQBbvEZzmCDTELD3Af0I/qQjkvLAQwi7mNIFAQXIhoowVrqwfFlwh6f69NTM+pkGIWDOsSWUJnKMRFQ5oTDHqRJCA3yXXkqR65zeqDVy4BCJlZBk2dNmvUJb7tiI+sgpi54YL96s=
Received: from SJ0PR13CA0106.namprd13.prod.outlook.com (2603:10b6:a03:2c5::21)
 by MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 29 Apr
 2025 15:25:25 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::1) by SJ0PR13CA0106.outlook.office365.com
 (2603:10b6:a03:2c5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Tue,
 29 Apr 2025 15:25:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Tue, 29 Apr 2025 15:25:24 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Apr 2025 10:25:20 -0500
From: Arvind Yadav <Arvind.Yadav@amd.com>
To: <Christian.Koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>, <Arunpravin.PaneerSelvam@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Arvind Yadav <Arvind.Yadav@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu: only keep most recent fence for each
 context
Date: Tue, 29 Apr 2025 20:54:48 +0530
Message-ID: <20250429152448.205212-2-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250429152448.205212-1-Arvind.Yadav@amd.com>
References: <20250429152448.205212-1-Arvind.Yadav@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|MN2PR12MB4301:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ce766d-2c89-4891-48c9-08dd87321049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZArR4kjMzbEDuCDs64GYmKBEcptvK7Vv54i+HEQwZFTfZuu2UHfG3z1d7hHO?=
 =?us-ascii?Q?7xCT1FBo74HJtgKwLNTUq4rtlEreUscaRKguI6GOffgrp0kQK8vAUZ0tcZ4H?=
 =?us-ascii?Q?ASWF6sG/2hALaRieywtEpmCeNxc//6NWfGRcKWwwZAYsx2sY5//MZA/qT6fG?=
 =?us-ascii?Q?ZS/O05026uxDRwoQ7hOF1z5xjDnndwfWusQDG2wrfG8sYwNUk3PE0rk7wa/1?=
 =?us-ascii?Q?52Pk3eN3WUkys9BzymXbkyVV3yU7lzsSIxCpQkG1OdwHqwc1BgSYy0Jsv6QC?=
 =?us-ascii?Q?xVXp6TUZCV5ofOyxHkT4it4qw+M70ygxZMVZ4Vrdy+5e2/bY/Dw7wsSxFtlg?=
 =?us-ascii?Q?LPVK8Whi24429ttzMhMtFAXl/iF2FH2YC2/TFW8+N4tzGKpPowC5nE9RsqWW?=
 =?us-ascii?Q?pUlax2ugnaKt+BVyP5yUbLq1X2G60XVKT25fZ4MZCj8RipM4M4XjgNXRSxhl?=
 =?us-ascii?Q?sG9iRDhCSOxKxGNzO/D/qAXXwJEmjWGrlMuKsEuvnpaKMT9m5W3CWS39CG32?=
 =?us-ascii?Q?Hm+rHiOkcCNUC9vwn9d5jkJYniCuIFzwxX//D2e/HyOSEpJz91PwVssHcMqb?=
 =?us-ascii?Q?D59yBR79orCyMtiytfxpPK1xDaM1guenFyD4sMBCU1NWtbo70IK2J51jNdvL?=
 =?us-ascii?Q?A6Xzn8xsvoB+haxPzx5H+qToN7ms+xHVKytSiKh+dwONaGzVuwcTiKnV4pK9?=
 =?us-ascii?Q?pcKR4T1ZUhBPlWAJNXbNYGptVh7VXmyCG0pIaQnu4Yn3fxEbY32KinhohEFn?=
 =?us-ascii?Q?2uWgf4/iOqmu7R1GuX5UtI5u+pgzgPbaKpKND6DZMd1AI2RzRPHT9dOx2OCX?=
 =?us-ascii?Q?cssGTvekwpTDNjuWDRbD+keWVovbC7QjqQYOi1w7IsHQe4XjMXPdSJWH3EmA?=
 =?us-ascii?Q?fOQnMUWO+UHKQtG3/U5yG7cz4qz+NqKDUSGO4ZlOydJ9H3V2v/hBimle1v8Q?=
 =?us-ascii?Q?ismOwkybgRH6caHyg2p/y9qq6y9q/D8/Q2BTVSDPvBoB2u7aJedfM6EwY6vo?=
 =?us-ascii?Q?TV4B84s6X/CQLCCC7Nrooi7ZVzPhGfJUfWgdX03NUBoM0GXqKu0v6RapopNN?=
 =?us-ascii?Q?VH5jCV3yp2qvSk5EWeSNGTHomXDA/FNyCsAc4d7C4dz3CJ4OV5goODG27GxB?=
 =?us-ascii?Q?H+31tx0BCEitRRSBSi9LTnP/vdKq8luGbLf78tQLggoLneCt8si6SM5czHk2?=
 =?us-ascii?Q?k6Nj3gHzWdQS2AQCwt7K7DjXIGf2xrKsbM8SBbFZrsHEOJHzSjtIJaAlfdD/?=
 =?us-ascii?Q?65W7u39SI6BTAu6jwUTqNGW3VoBGWwloZSSrMUodA7mtb2gy6Q8727yi8ztR?=
 =?us-ascii?Q?x2nHz64G8Yx04gGZJARA8YNZ/tRgiREdhOztHyuLzLJLe6Tq9YlrCW7mLz+Q?=
 =?us-ascii?Q?685pGFMNwIFgNLPb9Y1is2MUGBNFg8Vepc1K2Y9v/QFGlF4D3LewceG/wTNy?=
 =?us-ascii?Q?7EsrzdNL99rc12j1tGQil4cYD6987UmqXF6OvtnbqUOuXnfvQQauv8kPLXCD?=
 =?us-ascii?Q?B4RbQKO+BkFbKoEHgeaoEV6uhEiFz82kR8MP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 15:25:24.6300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ce766d-2c89-4891-48c9-08dd87321049
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301
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

Mesa passes shared bo, fence syncobj to userq_ioctl.
There can be duplicates here or some fences that are old.
This patch is remove duplicates fence and only keep the most
recent fence for each context.

v2: - Export this code from dma-fence-unwrap.c(by Christian).
v3: - To split this in a dma_buf patch and amd userq patch(by Sunil).
    - No need to add a new function just re-use existing(by Christian).

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 3288c2ff692e..0f4233b79a3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -606,6 +606,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	struct drm_gem_object **gobj_read;
 	struct dma_fence **fences = NULL;
 	u16 num_points, num_fences = 0;
+	unsigned int num_shrink_fences = 0;
 	int r, i, rentry, wentry, cnt;
 	struct drm_exec exec;
 
@@ -851,6 +852,13 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			fences[num_fences++] = fence;
 		}
 
+		/*
+		 * Remove duplicates fence and only keep the most recent fence for
+		 * each context.
+		 */
+		dma_fence_unwrap_shrink_array(num_fences, fences, num_shrink_fences);
+		num_fences = num_shrink_fences;
+
 		waitq = idr_find(&userq_mgr->userq_idr, wait_info->waitq_id);
 		if (!waitq)
 			goto free_fences;
-- 
2.34.1

