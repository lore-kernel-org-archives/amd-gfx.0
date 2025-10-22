Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC28CCD1BE
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 20:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CABC10E855;
	Wed, 22 Oct 2025 20:45:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zCW6dTYV";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010068.outbound.protection.outlook.com
 [52.101.193.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B6A010E842
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 20:45:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYuf0cH/x3O9OweS8nLsSLRrRyvd1uFybbr7XSGUEuo+Cnh1Dwnoe/4EvJg9h04ek3L+pv7v0vNMvCycnkgfXAsNFQMmcePeRyg1zyYCgTE5cuRRTJabDG/eKC7lqjdi9j00G87ZsUv7x7dIX7XeoObDPTwOtNzt1Bpe+RteG3MUiVEbHV2tGsXwAoE2l5+d04I6FXMdSw9UoNiXdXd+WbQ9UFZ8qiKDfVp3/p6Ow/t9k89uKyRI8T4IKgAHA3NIv/QXEPvcOH4wfp7+qG0HCrf4Zs8G5/YRAbcbJ5iDLFjOPKMzu5DYBw23I0ih2/gztHEAzwzz6glPLWuMmWlZmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAMMKmSkLkwMKYn2oDnwTEh6ym54ScKE7LOMpZSOIwM=;
 b=o14MhMROQWVUnJSGiPq2RxaY9QtVhrmFfIav70csAVcUHOigqv7O3aKJ5DoGMFr2Y7H8OQCmT9E9WwJds75ZFuyoLrVoMaCuRo6Kj0sMt0VV/2L8Nd5zmaa8kaZaQ1bZ+wtiLB5JUL2yktd9+/VsZfkbhk0OnLCUI5B6DHDIiPIu6ueqz2jGGOifNU46oD8LPY3xhsmV8xDfjOewlf4UrwDbFpi50CiSEGCK5pK48MbpTedJzdG4IYXxW9sWyAQK0HovBv/cRkIllZIDEAue7QCqZnk5IP+ZfP6lrvUdKk9CbyGWirykHVK9Y66oWUow2D28sJ8iAGB9gNuSxj3kKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAMMKmSkLkwMKYn2oDnwTEh6ym54ScKE7LOMpZSOIwM=;
 b=zCW6dTYV8L/HHA+0PYmmBFobmw6gsyEvjb1oJIz9nkyr/w21MhhGAvyiQNgPtHqdmQ6dnVjftSL44DYyTsI8eSUZkYjBPrUIPmSp4wktssJwMKNRlq+t+SyNu1FhlTxbYksOLRxujneDZpTbAs2K44oYMW9MLGCkqw+g0fIuNa8=
Received: from DS7P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::28) by
 IA0PR12MB8205.namprd12.prod.outlook.com (2603:10b6:208:400::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 20:45:35 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:2e:cafe::96) by DS7P222CA0029.outlook.office365.com
 (2603:10b6:8:2e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Wed,
 22 Oct 2025 20:45:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 20:45:35 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 13:45:34 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix leak when we don't use the vm_fence
Date: Wed, 22 Oct 2025 16:45:07 -0400
Message-ID: <20251022204507.1782776-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|IA0PR12MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ea5d3a1-deff-4aa1-52cf-08de11abf349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gt9ojIE+fE0VJoalbtuFvnWENbEV0A4kk58O9MHFNURby3U5KVrhi6hFm2nB?=
 =?us-ascii?Q?lSmC+mGDoP4Yfu0K1ScID3hk2O825K0lyMA08VRCn/kUnfo03gb5cEJDggSE?=
 =?us-ascii?Q?wfNlW1fI9gxuIn91/61/ED0mFM7qStRqYCRdY3NZsSA00rWx1LMYGGencZxb?=
 =?us-ascii?Q?fVAoYI7CdVNLj6Q4y4FeEV50vJvQFPNqFi1wzj6V4YjHVPmN6doe+T+5IlTA?=
 =?us-ascii?Q?jrC8aJWgpKXGuaSiiCs0EvT1/y8ZVkhdemwNcUkdgPLlTRUeTIEGi7nG/P6u?=
 =?us-ascii?Q?eLKzL12psaKkTdv29da3byBCnNi/6cXnqYbjAG15qdxTASXysglmmI5sJK4y?=
 =?us-ascii?Q?IBaugVQT6mCMx2w27jKQlabp9+77yV2XekfcfVE/svSYTnNQbq0Aw/QOCTy0?=
 =?us-ascii?Q?SPhHUyvNY12FPKEm1+MICFm525q5BynNX4O9EL88geV/mZ8Cxit0AlVWV8t6?=
 =?us-ascii?Q?v/QNJehF+rInxrKsvxSss3+i7L62DnkH9Bo7ID1BqfPQbYEn8ZnYO0OznE5s?=
 =?us-ascii?Q?N5hRn60innIbgDZ7gOuNNqldNV+5SxmDHoMImB/cPpuo3PCETtLTTbNcUcpC?=
 =?us-ascii?Q?YMKc9IF6sO8Fxia65nhfAq//ZmEnhFY44lT7JGz/fe8SqFYy+OMEmBuEc5lu?=
 =?us-ascii?Q?7Dq12IZbk9DodYMEiNKYIa1rtR15YsGTPsoj60KPd3UQ9LA7nTrccRB9Z1Mm?=
 =?us-ascii?Q?t5yjFpWC9b/ZLwkfwaiWj1RUy4YPm3QaXqxdRtBTzHdCLDo/qUrvV/5442AY?=
 =?us-ascii?Q?IuZuxGmmxFqlRdKuGa/oQHWZ0T0RoW7bzbpM0QFJPb8sSvk2eIXkOEwGG0bD?=
 =?us-ascii?Q?8s5INyuGzJXfgb0ulz3aeXcv8sxt2w5rT/SwsecR2E5R0ITNdOAVBMFqkjOf?=
 =?us-ascii?Q?k09cPLy8zIaS7I8u/al6y7R0EwtXX2o/wCM2KldYp+pO/eqz0kCnOqQr2OVV?=
 =?us-ascii?Q?JNfCVZz5hzaO6uo44S3fudBqCED9iUpuRCuEtd9zWBWdA97ULMgc4cVOr8rE?=
 =?us-ascii?Q?Zhb8ACA+xVor4prnuUphRx1P6o5oZLvOIFhL7v1POaUbGRlnOwUU4VHieAnb?=
 =?us-ascii?Q?HtsUX4nGwwYq6MORmGv9iqbj0KuOlOcSw73iCT8UL9YKXlC+1x8zs/xdAuiI?=
 =?us-ascii?Q?ZD64TKB1u/+iKWkVuqxRPS54vcZHt12Q+px6yKd1RAQ9SYs5pQDThlGsiEVM?=
 =?us-ascii?Q?kQ8/tthJZXBsthce/g/A2mNnQSpoTVyo0p4jJ+VoNJS/yK7XLxsdxnKBhZ/3?=
 =?us-ascii?Q?/lRrxKgZg7804pclslLIcelhNWAdYgkTGeD2ekMOI9Q2x9a2k9YzskEdIyh9?=
 =?us-ascii?Q?Wcct8roavzba8U+kUCKLy1ctUda3BA+PQBitWzFOoGElBjJA3T3bqHDQscWs?=
 =?us-ascii?Q?9QUN2aaM8Rhf83T4tj7E695a+Ao5Pcx0d6ijmPS5NiTXSV2PwxIXP79g/Hzv?=
 =?us-ascii?Q?CPzBwebc2r2f6PrT/NgMkeDCfjGt0WG4SObhAMx0ek1PkDRyMCRD6CXoFTe2?=
 =?us-ascii?Q?YI7gOvTDukPQAYrAGCCiV3zfZ/C3QDz5ozQfQlb/1u/ciXX1vuylOn+UjTbB?=
 =?us-ascii?Q?aD3fP9AlExmrqfjrbOU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 20:45:35.1186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea5d3a1-deff-4aa1-52cf-08de11abf349
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8205
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

If we don't end up using the vm fence, we never initialize it
so it never gets freed.  Free it in that case.

Fixes: db36632ea51e ("drm/amdgpu: clean up and unify hw fence handling")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index db66b4232de02..f3373d5f429f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -845,6 +845,9 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		if (r)
 			return r;
 		fence = &job->hw_vm_fence->base;
+	} else {
+		/* free the vm fence if we are not using it */
+		kfree(job->hw_vm_fence);
 	}
 
 	if (vm_flush_needed) {
-- 
2.51.0

