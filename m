Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9F2C5B554
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6191110E787;
	Thu, 29 May 2025 20:08:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xaqqxz6z";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13F3010E76F
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3UKaR/PuA1EtZ7lOKUrxjEgbDUNek+nsDeNnpPq+yyjLzTeOlXeVC3Me5NLUvGb7Ag/35+9gF9/o86vatuBAAmtc7L3v70uLoFY04PhIdZpAJolJNgByuD5bmMPCOdvqrrQmxGoeWU86usgoSHUOv2D5FV/AHT6UW7qcNqZuEtwQHEBSAcQKW6HqZUpfTeGofa1UTUq5nITMQhish4dmViUJ8EekyldoSUIT4R680R2G9wJeUkgXgGdgIM+b5dc9VoR3U++c30woOfXibZeqZNKbVn+y6ga4vn2Uh7hD/6HFBP086g+DZRZ/wS7Kno1Nq4oycakq56emsCWDn9bwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6SKO93GHruJw605bCasSDc+xe3gI4G8n2MhAE3cmWQ=;
 b=Nv1PKcLIqjofwr5XGVjRoM4CgwuSjgHUmU6Qz2Ub+Dp1Ir8kwVxkuUqAau6L17hcWvh4tHUzCjXJDKiazcQSWqz8uYllTkOyGKrpSHBT6Ir8OryqVgbRsXMbA9clUpHcPITYNntjDqEprOXn0fmbYCAHHAcx2MOpeSPVJO//dE2VZTARvXCOMxyvtTppCKzCbRcQmMZVbKjtmLOY2haCegfFZYYbU5rTNyudmUYshg9+Uzx/XXB7G8nfXH2OHw5aNfBKJX1Mq8z3zTefHUZy42aehSiX/x1y1eIC38zuS/3ybnHnzkfplTj+XGb2opaS/0guIo3Kq3vO4iH15J+bTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6SKO93GHruJw605bCasSDc+xe3gI4G8n2MhAE3cmWQ=;
 b=Xaqqxz6zeUpbaNau3GtN4BsTtd4JYYjm3wuKtJ8xj6+D3hNUH7E2xWmc474hhzDSHQtqqPmDsVG10mpM/SFXgOPjSx9nheQQ1fNxrGMKzt+J2aauQRe8PDo0jzG64VUaTL8Mtml7vRv8iQqNIF3kLvBJfuF0MCirnjwYx0n5bdE=
Received: from MW4PR03CA0036.namprd03.prod.outlook.com (2603:10b6:303:8e::11)
 by CH3PR12MB8211.namprd12.prod.outlook.com (2603:10b6:610:125::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Thu, 29 May
 2025 20:08:30 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:303:8e:cafe::e4) by MW4PR03CA0036.outlook.office365.com
 (2603:10b6:303:8e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 29 May 2025 20:08:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 17/28] drm/amdgpu/jpeg2: re-emit unprocessed state on ring
 reset
Date: Thu, 29 May 2025 16:07:47 -0400
Message-ID: <20250529200758.6326-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
References: <20250529200758.6326-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|CH3PR12MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: b7689f68-465b-4cbd-0409-08dd9eec94d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I64YGAeHI5cC0VAkjIIAi9efokzUiPJXhNwIm+1nIUtBwqAjJuDfl4F5DdvX?=
 =?us-ascii?Q?Izju3rqDyToAhecg4Xojm9JYAikgLPJ7pTCWuk8haJ5q+W/2IUUXKh6e+kBU?=
 =?us-ascii?Q?B9if4BHGiuRUWKhfD1GPKIhLy1CJfT2Lgv5c/OeWR/2lmjtbc2eNZYg+4IJL?=
 =?us-ascii?Q?6oGIOyzlfeQDUtNmPt4PEvjeyrAAX4Ep3e22KjkT1DVAMEaem+e4ORZum5WV?=
 =?us-ascii?Q?rnJEK79u1NcUPLQLGEzo2ZFLjaiW39iASMRT3+51YHatMM+g8XYfmSmWisMa?=
 =?us-ascii?Q?3T2jfe8bNoRRwnDVHI9sPRBTzeYG8OsxOK3CWu0lAbxTQMX+3Q/7dygVXYZk?=
 =?us-ascii?Q?bCKJmomFiIgedp8MnmZCm1IKjK64PCzFflfOzaYphuLGX56NFiRTReK3+Mn2?=
 =?us-ascii?Q?qpWpk9k41eFXWrFFKxrl2Lyj+EGzf0lG2LbU3lI09CNAh7FhgrhjJf8aM/i4?=
 =?us-ascii?Q?M8vMRXN2NNfz37udZf9J0MXZEa9Yr+rSPpyiO6K8mZLiswXhHROXZOqpgn7N?=
 =?us-ascii?Q?capJ5JexezHlFacxdNWWqnZ5x8kFYPrlZdEV5/h2WWwKYPTiW+qK64jESSGi?=
 =?us-ascii?Q?9NBWwZDdsNCLyOkvQ2wHdpqLHOp9Fj/9dQcy3akeGQas6Fei8Ke2v1Hz8PNx?=
 =?us-ascii?Q?lrhzi8+G6/UGPW8UMPj6eMxzUigs5J17nwCO6i+lpF4IKd1F7r8DwdQMYXT+?=
 =?us-ascii?Q?neuGKOweZte4Yn0hRZyB220sxYCb0b/rsjEMN/ssg0WVV/cjRavMofs3dDWa?=
 =?us-ascii?Q?5eJSlStNQkpT9ZIkZ4KrIOHp6ODogvAylvPCX1oiw2wKul00PFNO3qMYd00F?=
 =?us-ascii?Q?8NsAVICCnGpN7bKO6bv5ToD5NoV7ac6kowiIhwRshpnvvLVAC3FuSMOyCUGL?=
 =?us-ascii?Q?nhE+Roe7T39tcG4ydLWdrGWggXrMj72sVKqmWgkPywmX3KMDJVyr7WeFSxaH?=
 =?us-ascii?Q?hkimd2jB9q94EvuyWs5W8zpurM8+f8g4ysvmktNDaM3dwXwskqy8lcx9vZgs?=
 =?us-ascii?Q?8s6SB9zMgvdbF012dRNoEOjHH6xTAVQd2+KgjtrvxbFGAh03u5am5KXtseID?=
 =?us-ascii?Q?DbUoIRnxXwINkzvjskU/2Yzt1hxw8vAPD2/puyh9iQVJaQU/SvmUJOMz1PlS?=
 =?us-ascii?Q?8Wcwr64eZ4zffnGJ9nBq1Pg+YQRWh6Ksvr36SmpbL46DCfFkh6hkbumfEQ+L?=
 =?us-ascii?Q?63PYbJSp5Wu04wOV3rfzcmcmKe2ptvlKPqMvK0Gw/tlwggZUGBf9fDv8nsXy?=
 =?us-ascii?Q?6UyPz0175uH8GpCJQLNqzvjlSp79Clm6D3K8GV0uuEM1Xj/A2hoOKBqycTY3?=
 =?us-ascii?Q?/2IugpDufgfAKmZCQ92nvnVd61W98YYzZyTPXBb9/4NOg/dq2S49/Psd2I9d?=
 =?us-ascii?Q?oClp/nuQJ3sY+iKKRwBkGlQ2DOxpyD1nL5uwsJ8QWqY3G96hLzYwvHE2E9nJ?=
 =?us-ascii?Q?ijqBtwiqDuMnHcMyNQ07aaEvN/S8P428eLWimnqVk0XyQI3tm0MYBYK7lBfn?=
 =?us-ascii?Q?XnPSCJLPEvF8tuk5m2IY80YUe2gWSw8w3/FT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:30.1613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7689f68-465b-4cbd-0409-08dd9eec94d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8211
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 336ca44950dfa..aa3f587e2004d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -768,8 +768,8 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	jpeg_v2_0_stop(ring->adev);
 	jpeg_v2_0_start(ring->adev);
-	amdgpu_fence_driver_force_completion(ring);
-	return amdgpu_ring_test_helper(ring);
+
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
-- 
2.49.0

