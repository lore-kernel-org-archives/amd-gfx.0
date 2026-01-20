Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1380FD2ED11
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 04:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A92DA10E070;
	Tue, 20 Jan 2026 04:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5aDkYEzr";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 446C710E070
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 04:04:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6qgy9VLJYnLveQnPSKh5Ccz9mJ1j5pAAK+6+CYZ09uMW+oGTHdZZoQvpam61VZN1yf6GhXDSqLREPLOO+UI7t8YzpOzh3mF2JXC8LzmgRFQMz1Eia8BEj3ezV0I+LfUK4ntOBNRD9a7L0AllKkxAHSOxWW+RSYZS1hfbHUEnfHT1oOaF9HARqYNxmg/0+gbFdMYiCINbeM5kGlY4eqd9ZiFDqJha1MqqT7txGE9MS2v6ZJlDetk8jQcg8/zYBuxqCAphwxbyFDgw4ldHhz/WrYYFFOY/+295HwgufW474GQCdoZufO4Y0Or3ccr9sCBhkLt7wPKNAiQWq40lMRvIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tv2jJeVqCvph1pjXUP1mCzIoGX0IyoxbiTj4Q4CFVek=;
 b=BzzPr9ABLi1gx3lXnFUyZlFPaYmpwuA8eGwxi/3XwkLLIyuEz2yt8vtnCqla+a7qWoMrFrulFqGqwzkRBWB4P0Y5QiY0yNJJSx5RTwYM4z3VjSQZv4gJ7so207dX3/x6glzU8oYMuUEx9Mb0waFWBHiIkRQAJ++d9GJ4GE2Uz0A6/el/zCbZ885MaPJMFA/nqdK7j799oT7zf2sfQUPjrZaf3c/T/SLdXNJmXx/LGXC/3I/bQ01LwHglFmZNFtGrLCrJx0EoD2Mph7y3ceNnPSPoHb8YDV49T6iQEzGTs1TTEh+NFHYisENyEMGb9jPsuRMM0IHLW2hgBaL8Kkfqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tv2jJeVqCvph1pjXUP1mCzIoGX0IyoxbiTj4Q4CFVek=;
 b=5aDkYEzr9h5JdIQRaAbQW5F9lvuRzvsdwqRbooy7/AoBWdsHG5ICDrMRgAKjMzts4wQxXT7JZQKM7UljpPUayfI1KILPgsrodwf5N0AS34vsluevMPiLVeOANo1VEgXn4S+51QCdPLe10xvhr1GHRnwDMOquP7jB4xbr5pIPQQ4=
Received: from CH5PR04CA0011.namprd04.prod.outlook.com (2603:10b6:610:1f4::27)
 by SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 04:03:59 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::5a) by CH5PR04CA0011.outlook.office365.com
 (2603:10b6:610:1f4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 04:03:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 04:03:58 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 19 Jan 2026 22:03:57 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH] drm/amdgpu: mark invalid records with U64_MAX
Date: Tue, 20 Jan 2026 12:03:39 +0800
Message-ID: <20260120040339.1086611-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 5225d70e-d961-42c1-1e6e-08de57d8f01c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DG/YL4pxj9G5DManOXXBqcLuR2I3mcPt0YroSXufflZ2Pc65oRZU3lGEE/6d?=
 =?us-ascii?Q?6FP3gcBHptl8uSgqWxY9r5BbXmPEDF51OXuxmmDJxqKV6xJm7Tr8AqLuv2tZ?=
 =?us-ascii?Q?fGaLjGWImk2vPbA/KxIA3f6bKt9CeH1I93JX+HsFpVjC3nBCWL+g2UOn1qVT?=
 =?us-ascii?Q?JNODitGOQVm+zjZJanFWa7FeWBYj1M/5yvbVtRPJRQPw/mRhHFUsUTmKx5u2?=
 =?us-ascii?Q?/a1ZiFHspe74JmzM8KF48EU3OjKettWH3QdZIoThsPdBgb57ohix3Z/Yvg/b?=
 =?us-ascii?Q?TqPuZj5PjnK7m6/uxx7yeEBUMa1NsyRTnQ61Kxy2vicqEzzBiOXOlI+68+en?=
 =?us-ascii?Q?EFLOuskCGJoEE+EdhGbA7sH+0fCUJj52ACdIJ7g3O8qDl1h/wLCteoOoid3o?=
 =?us-ascii?Q?h+IKsNp4xOdz0geMO1x1DPNl2w6LWS75PfW+lZO4wASijb+hJucEGJoZefiU?=
 =?us-ascii?Q?LZdm/gCuKh2sB+vERT8HLwwY6jjMyLweSbqlpd/CiYBg40mBWrH06MxsA8Ck?=
 =?us-ascii?Q?r1HdNYszI6vGXeUEfFJbzb1LGVWN8hYHJU0alLBIbgFLOjP9CgxoVeqcUMUw?=
 =?us-ascii?Q?GjH5n77Sk9f4cHgeg4kkqNHgbc7NK99vZxHJcJSQ8b6VBr9bIgRcZFY3ADMK?=
 =?us-ascii?Q?yFUTjugzZLLoQXw0lED3oNliWNnyZ6qpUkjiKrUll6mPtt1JeJ2EznwDP8a/?=
 =?us-ascii?Q?aZE+TKH5oPfdLtojWocUoeeIZ5JARt+ClrG+9vddhFIMC41vZBSKjc6fx9I1?=
 =?us-ascii?Q?KqxSHMaBgqPlR2DeumGzWJUugzyB28mm9ABncGQ2s8TYrvYXBPl8fEO/TSD+?=
 =?us-ascii?Q?rw1JOMWns3bzqS64SWPWjLA6QbzbsXGbUZRfNzSTmcncnJiwpbAe45m5WYbu?=
 =?us-ascii?Q?BO8tc9kpICY2Of/nz+lb8UHLXyF9dOP4JFalsIJvAsl5kuo4tCvDPwKdSjeO?=
 =?us-ascii?Q?+Z9S5BbLyAoagDYAuCpnFY5am3xIHo5pXMH2rj/Ei0m5xqZBaV5DbyOqmO8Y?=
 =?us-ascii?Q?r+t105aBBpibaLrhMCBQs+TSrQGe8XSiGnDM5y3aOuu4pKCGuTAAJknj2IjE?=
 =?us-ascii?Q?N8BM/5/3Q3Y5TVxJ3/EncqbexxLDwt6SYJqFTBOR0yKf+qLou8my7Q8vHks4?=
 =?us-ascii?Q?hSD75dbEjx8WJO/rjfmJvAqFyT9xvukEqa1DrvTlRxVvtqw3pFM1guXw6r4o?=
 =?us-ascii?Q?rD6voRBJfbr0jMNRxHMcWppxLEjAj8aI3pG0629R8nCXtxl/KoFj5RVTCrcf?=
 =?us-ascii?Q?Ej52rU1RrgIkenNK4Mz5596Wz3jMoCPzGM7SVf1kx6UI3CZ721Kb4FQMaf/x?=
 =?us-ascii?Q?67BAHk43a58ThVdrJwasqIAIhpgAym7vUXXCcde4NIiWdDfbm3JjWfMvOoHF?=
 =?us-ascii?Q?EvSF1wJKDVE3tb0OYMRLJsRTaWAPo1ZSB5zbKpdON8quWWOblyA9eRNenGes?=
 =?us-ascii?Q?s5wGm+IWFAXypM2PoSZiT09vomDaYdwX7TWGt9lqbjGVtyvRHtOaoZKGVFTp?=
 =?us-ascii?Q?/PLo1PJgZ+Bho7/9MReuWqExiqI6fi8RIUwwTAUaB4PPVoeYapaucbv3Raaf?=
 =?us-ascii?Q?f8SVnJ1ayAiaXApqDMEkEUUDJKrpGIaBp+XcfyH2sQBwmtRbjFhjF5vBchP2?=
 =?us-ascii?Q?SpsZDHHduURnTfoFN1ZhpqyRmzofytDWLDuxkf4YLlm4gezEFUgGP53XSMHl?=
 =?us-ascii?Q?sCWbaA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 04:03:58.5810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5225d70e-d961-42c1-1e6e-08de57d8f01c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991
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

set retired_page of invalid ras records to U64_MAX, and skip
them when reading ras records

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 0c84c7ab36d1..13d901c0ed6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2784,6 +2784,9 @@ static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
 			if (!data->bps[i].ts)
 				continue;
 
+			if (data->bps[i].retired_page == U64_MAX)
+				continue;
+
 			bps[r].bp = data->bps[i].retired_page;
 			r++;
 			if (r >= count)
@@ -3090,6 +3093,7 @@ static int __amdgpu_ras_restore_bad_pages(struct amdgpu_device *adev,
 
 		if (amdgpu_ras_check_bad_page_unlock(con,
 			bps[j].retired_page << AMDGPU_GPU_PAGE_SHIFT)) {
+			data->bps[data->count].retired_page = U64_MAX;
 			data->count++;
 			data->space_left--;
 			continue;
-- 
2.34.1

