Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF11C35FFF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 16:16:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FCF210E0CA;
	Thu, 20 Mar 2025 16:16:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YZMAznBU";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38EFE10E0CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 16:16:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUAlayLgeXlfDKSAZUohkzs1tXK5NE+Yg+FO8HcVoAlJv3gzR6GCOoMYv7C7XGjUkbxdKnWNDmRYI70JLZmJP26ylfjPpje6m7FcFdOJ9YNEnPC2DSbtqTm9UHWcsniFg9o180xLXe/MdOM4aBRvgHrPMYxyNNlE6jGgDDg2KFwhCyjoJAsZpRRe8bzXssTQ2vAuRABy0Ot2NCFM1I/NtdZsS9Es6nGsdZNNdzLVHdCd0x6cL4un2oa5mvNeOKvPmJ2xxWtbxiS414jWZk/DdchmgDMTLSt6Y5tGd7Otb+dVztDDIsNVVtvcQvTBykyQrfhgKteopCX1kyrprqr8Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rteljizuRvSEfKjKZbU8sp5ABf1fgOd3FV4Tyw+WN+I=;
 b=NQiGal7Ow3TI9b/prDj2/xNXIBJaowFKjnlMIeGKSg3sjzrqi1NuCA07eVjT6my+y3u/dE4Br33SJHK6KkSVWcsk5GanRv/nGNOjWsWVYynDmFjJlePlblUDTzDRf4nR0WMgIvyfsPiOesEUM8nc73mJAqsSo95ECJm2hD5VDjVOxUM8Jczo6JXHF2gEqHAUstXtdscaKpKcqAznmLGgrHR3F6VujmsC5yHVT/yt5nqYmzp6hvXvTSN/EUzMHhl5hqPpLUJPZf2ycX8ZT+bY2H8t3rjl1iYSDNbLyJQOpTuXjNzXjdLq7FHb2AwB0rTxhk7MTuhwE4PX8xMseB38Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rteljizuRvSEfKjKZbU8sp5ABf1fgOd3FV4Tyw+WN+I=;
 b=YZMAznBUMFPuLHK46owg3XJMXlc2KYKbl5Gw5RnQCma3BN0xW+iYkTvYjmBqolcLb6uwzixC9Myw/BFBiiRv8fSeDN/6vqiHFM+/s4OKIJpDJ6kBFOZu87IXNemCCf/YsFhRql/kkMUKlUGF0x8cRzbeK+3cwzAsz2eh0KG0W5Y=
Received: from PH5P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::15)
 by SA1PR12MB8163.namprd12.prod.outlook.com (2603:10b6:806:332::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 16:15:55 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:510:34a:cafe::cc) by PH5P220CA0005.outlook.office365.com
 (2603:10b6:510:34a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Thu,
 20 Mar 2025 16:15:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 16:15:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 11:15:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gfx12: fix num_mec
Date: Thu, 20 Mar 2025 12:15:40 -0400
Message-ID: <20250320161540.1213501-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|SA1PR12MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f19eb7-92b0-4f51-b6aa-08dd67ca7da2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lVXQoEwA6nUR4ADnEblbSdf6eaGUjn7aGkhY++O7eBHd9+GlV7LRD4taR3qJ?=
 =?us-ascii?Q?51eOU1OZsOD0alUqTaoIDrpTgswhMTVg4wyxPP4TxiNfMERbU0E/eT77BprD?=
 =?us-ascii?Q?9/pxLP4feP1YYeebNZmbZje9upYeqxo4HU6NSwX80GLdAvbm7SCYAvorwEKB?=
 =?us-ascii?Q?bVtvR8zNpKXRn11r9iNI8kwRcpuWY5Z+15NUVSNpzIPlU17MaHl9ehKmkOVM?=
 =?us-ascii?Q?uCtsR6dR+hxtFUgVUIn81rLQpSUZrFiA64I3nSqtDEz7VQ2pXHREHHQqX8zi?=
 =?us-ascii?Q?lkD2B5ghpGkQCNgsJ6nL6StIcug/hPIZDq3Mgc9XCc+ra0wnjVHrTY1jCpfL?=
 =?us-ascii?Q?SsNE2nfPqJwaMERqEvH75j1tGXvLg60O28oma7NhiLCNpeiFK7EBXs1FtuBT?=
 =?us-ascii?Q?0ixANBQmbTilEkjnKQOkZEF84z2vSA4BPJPI1e9qHijppLQ9i8E5JhpwITxv?=
 =?us-ascii?Q?rYjIvSP7x8Gtcbl70ZxDu03lDvYcpJP8s604ldcTRKncSiOEOSoiTug19BFv?=
 =?us-ascii?Q?KBKlOcbPLPZosLlT0p7rxquEeO0pkFQMEgWxRBuMewkOgjzu9AK43WrULZLk?=
 =?us-ascii?Q?fUCN4vKuM+tc7Ha56dkPjyoPTWwxdqSaTZQEhLPalsIeyC5m7AChJnQh+QaF?=
 =?us-ascii?Q?a0p/qostkRcROb+j/sSJFAlWtwS4remvuls91s/BVXGMPLoDxue/ndueCwVa?=
 =?us-ascii?Q?uvNmFW9WTyEVc3UbfqpPAneoONPyZJ1wnRTphrVHdIMN/8NMFMMRq/PNJlop?=
 =?us-ascii?Q?UrzHK0egkqpGqxsl39T8YeQZow8IkZfLSUm4RmAFi0kykTrH0hAHRouDomEx?=
 =?us-ascii?Q?c2lEo4TJ+B0JY/5Dgy4GQHDYfKiEQbNc9P3ZxNc/02e2ZLsI8Q7hBTkgc5M+?=
 =?us-ascii?Q?/kttWi1uzUzH4IVLB3sIkitQgaP2Od1OQMYuV24ClTPAPgiZmiKPCpFvbXod?=
 =?us-ascii?Q?tfkeQIaHGe6H67avxQkuWjbrpwuRPj3lYo1X6QU5YxVlJEvt0Xn0B2OzCW88?=
 =?us-ascii?Q?+B62srUid7vsEeipav+26EfbOoOSjQFAJu8HMlJEtWT1rbeChcKkJ1rA3zxh?=
 =?us-ascii?Q?ATOlD8TQpagULGjrSyi+QKDfo4+iHmXyNbcie9z3c0BbeLe59Oz9FGoBLxa2?=
 =?us-ascii?Q?nc+I4ul39XRJVruK5WUsGjpDcyKVLv3w8udu7xxhFfc1UUjBjsdpuIL4Xmb6?=
 =?us-ascii?Q?7ikPlK6f5jZCMzJl0RcT9G7+0z8ZUGMF5Rz5IhHOt9I4H3S8L54qz5iO0xM0?=
 =?us-ascii?Q?QutS//sUI4yupjnZuWLX73uz8WGn0PIE9KFGnf81eofSfm4oebOJ2PCeFUgR?=
 =?us-ascii?Q?jo6XghZxkA2XndIxFNw6UJr89WMxNaiYOZhgXb0BBJTq1DXGmlZQTYVJF4mO?=
 =?us-ascii?Q?C1h9NB5/wuzXWX2RLrCLd1mwWwX/5xalurwsvJ0ZH08L3Aif4cdPvJEGT5DV?=
 =?us-ascii?Q?uJ3F8HaXDFKpTQk2vrCxUM2S5qK6AePgi1tu8sA7yI8HbJxJCWUln0gpg5sT?=
 =?us-ascii?Q?5+gke10DNNIlHKw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 16:15:54.3785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f19eb7-92b0-4f51-b6aa-08dd67ca7da2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8163
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

GC12 only has 1 mec.

Fixes: 52cb80c12e8a ("drm/amdgpu: Add gfx v12_0 ip block support (v6)")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f4ef81ce36701..ae41c91c9f6a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1398,7 +1398,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
-		adev->gfx.mec.num_mec = 2;
+		adev->gfx.mec.num_mec = 1;
 		adev->gfx.mec.num_pipe_per_mec = 2;
 		adev->gfx.mec.num_queue_per_pipe = 4;
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
-- 
2.49.0

