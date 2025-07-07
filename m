Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D932C8303C
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2092910E520;
	Mon,  7 Jul 2025 19:04:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NWc6GoWc";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC3D810E1C1
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDprXIr7FAAYQ/AUgRGfn7m4DdK9nDnTlJZBf5k8IGCGocJ6i12bi1qNXcVh2XvMIRshkXfF7kgAy/lXUVvdBZEf55IA6CU27B9sX68MGRFBNdARmBPl5IkMLW3IYGQ1A/OeDDYRPAE3u+y97qCL7NbuT2zZGXDzYx8D8LYlNtuqjzh33gHw6bNNTqzCFhSGNUIkGVcFd9ig8rtL3OTwpqUkG//uI6RwifteGcrN+op1SMZ6DIyenH3hlAXa+ilWO4ft4w2D0ptD9JO6RWrO4EK8rrLtypJCs0V3g5Uzaf+P78DzRXW/LepDlwWLNp3Kxk64vDr+mCDAB9H0lxhtNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yh4Dd/h0DsNxKNPqSRStNr2zkiGDqb9BTNMCr9my1Os=;
 b=K22mYCyR3ZHZ+Z1KgagyArKAabjQ03zgUgDnJLxC/svsVV7lFMcTzl6GZi+g2osEXuJdswBsGeZXyGazu8cNawZi2M01tHCnUUy+TvwHssdISJd0cSyG5JpXHiidr1WkGDFQ0FfFc2jHPcTioYHqFtmiilTcwNcjRj1bF6u1ZCX1/f/G4ESnCjTEMqfYy6GoD2nmrkdWGcFylQWp6cWDxFPDUZ8XTUNaKYpu7QEkU3oagx5eHnR/MN6FsSd76P8MJEeTHd0LAggwgqIbgly6X7upMkZSnqZNLhTHDNpEPv3NsyUJmx4u5Cay92s7lObOirWZVUY8MvRIKUe1lOl2yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yh4Dd/h0DsNxKNPqSRStNr2zkiGDqb9BTNMCr9my1Os=;
 b=NWc6GoWcSJjhPBaq0h6q5Ll2ajj+Fumw6N447YcEWhNJovan3K9QThppKQx19hxQkuPvJ930F0R3sczMtTdNjG8ZIhDRjeapvGnjI8HlNQMVA6W5JEezNBkhTYzzm+QCdMzaG44rFkGDgYlCKBpcjBRzlp6wthh7m6LQVQyrBak=
Received: from DM6PR11CA0014.namprd11.prod.outlook.com (2603:10b6:5:190::27)
 by DM4PR12MB9070.namprd12.prod.outlook.com (2603:10b6:8:bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 19:04:16 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::ca) by DM6PR11CA0014.outlook.office365.com
 (2603:10b6:5:190::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 07/36] drm/amdgpu/jpeg4: add additional ring reset error
 checking
Date: Mon, 7 Jul 2025 15:03:26 -0400
Message-ID: <20250707190355.837891-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|DM4PR12MB9070:EE_
X-MS-Office365-Filtering-Correlation-Id: 729a60bc-9056-4fa6-29c9-08ddbd891164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LQIFi3L6ovWttjJ1eX+u4NZX8uM8l5y7kMk/CTkeuXqrQWG45BwDnsam/la9?=
 =?us-ascii?Q?vB9usEoSmdzygPUikJTVZq5hdylu1HX44Uh2UYiBhr0hYXhzq2X0A12Vnplr?=
 =?us-ascii?Q?rWecSZVmAgM07H0J6Z6KEiM5AIqlCtyQbTO49bd7X95wajgF7dvNfZ6lbD4f?=
 =?us-ascii?Q?bc0FgkNa1amy8nDy6kp3eVHa6eieMKMBxf9oU9C5a0uoc9XBQzAXKan6gK6q?=
 =?us-ascii?Q?+UzD5gP3ZPmr6UrKZyUdKl9L9uUPG/Om6oaR/bZjiJ0ZIF0JnoSUsItN2VtF?=
 =?us-ascii?Q?EmJzA1gR9EVqqBzzEcn2chh6vQ4T7HAPCfpLD03p9+HLZyIdCogi8D3VrEXO?=
 =?us-ascii?Q?Tx84fuJvwyBMzVX7Ked3/YY2gah37pjGUFpDewfz3a6fzGtnt2wkEkjFCF6K?=
 =?us-ascii?Q?4EZLUsxjsbRZMfjkTBSdJvHyiPGYqj8xf5DHkbVSoHb2sfmCRUMmjbPCb/mT?=
 =?us-ascii?Q?ADGv17kPu+TgCBaMfPmbGxqkobAZkGIPwBV8rwDrjQJuyOAsph4gWGovj6W6?=
 =?us-ascii?Q?57PDnzoGdqauAlc1FxFXBQFHMYodbAB4vbAV3v9x624Ggl7Mgjbjpv0a4G/q?=
 =?us-ascii?Q?Q4n645M0Vvpq3Rf6bbV+5Tap5EQKidU3KDQFlus9t9+jBxmc/nDD1BVLkiuh?=
 =?us-ascii?Q?Y7er2zCG7UejI44ZBCHBsEHSfG4FwTSpBkCiUfkC7v+StVTS6uYldzTHIm55?=
 =?us-ascii?Q?8e4ZihygLmegvvWSAn28hlFJedLemI8Ip/z6icO3jp+vuz2uaOSvp61pThTf?=
 =?us-ascii?Q?LR1PdjIgwf28BjwFbC68c764ZuBG/dv/62Qqiz0o+ZDnxQF5M4BkFNy4pwX4?=
 =?us-ascii?Q?apceuvlIEBw7XzyeYBJabzl1o0nV9j6y01gIUvBqD3075rQxG+uE4Hf3OfLY?=
 =?us-ascii?Q?VpGkd3Z5Z0KDxDwGZ8bxT5nhDq/a55GafQS8y67LgzElMEiPIrxvz7Kuijdp?=
 =?us-ascii?Q?GGrMfp0R/vBnOArH4P76hvihFgVBC7t8QfDq4lK+fz1FMtCuh2aVH+1Ne+Jz?=
 =?us-ascii?Q?yxr0ob1rL+Glvznmg5MJeSDRzpCtER/0iB0Re+1W/Z5bd7oTLT6bxnBK/vju?=
 =?us-ascii?Q?RLh780rrteAts/k126AM0FXy3YCkdIWtnyU8B98n0B4z7SCmtwqIcNx2hzeC?=
 =?us-ascii?Q?Y6WQASUbLn2AuY0mb0JVus+/SBWjweIOUdbySNJKvf1ctamnxTCj4VnOh1Ns?=
 =?us-ascii?Q?usWyTfrpNLFZJWk0hiz0GsgYnbMy5qXuFOubhmEuKVS5FKj0W8a2tG9vfcfj?=
 =?us-ascii?Q?6v0fXuEMqt8vKdusnhO2ywJwnH6JW12rZFtBI7vSt/ypseV+Hj4ezZJ9PogQ?=
 =?us-ascii?Q?ame4zaWltu7A91rzkquFab6Oj4rTGwWXbT5YUkfMBcKb+4vITS/4MYZZJLEF?=
 =?us-ascii?Q?XR6kspoYsVNq+2S1/Rm1G+DDqJHcHPXVOj2Bxnxdqr4M+kJAN9sS59GacnWx?=
 =?us-ascii?Q?6oV7PLuxKNmlcblMhCLg94Ibb7Htkn7VOiOeq8SoA4VrOzxZIDO5lRAWbXJD?=
 =?us-ascii?Q?mqSbMrGlTgaC8xVZi5gDoT64Ku2fjin2JfbO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:15.5463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 729a60bc-9056-4fa6-29c9-08ddbd891164
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9070
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

Start and stop can fail, so add checks.

Fixes: 74894ffc7d0c ("drm/amdgpu: Add ring reset callback for JPEG4_0_0")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 1d4edd77837d0..78fe1924f3cb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -730,8 +730,12 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
 		return -EINVAL;
 
 	drm_sched_wqueue_stop(&ring->sched);
-	jpeg_v4_0_stop(ring->adev);
-	jpeg_v4_0_start(ring->adev);
+	r = jpeg_v4_0_stop(ring->adev);
+	if (r)
+		return r;
+	r = jpeg_v4_0_start(ring->adev);
+	if (r)
+		return r;
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
-- 
2.50.0

