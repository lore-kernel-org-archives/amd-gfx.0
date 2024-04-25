Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0271EC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 10:00:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42BCF11A353;
	Thu, 25 Apr 2024 10:00:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OgQiLHR7";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8EB811A351
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 10:00:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtsCtq9JFQ6df9r/pZY1719kjIaVd2pc97CSLWD54hUq3pZ2lVereqnzn9KTPWWMehVUuY0GjaCwXi24gBKEnwIBbWUnq0WNHnARBd0WXUbgaJPUxxmZTqeTElc3ZBJSdpoWEkokIXeb5MZIHEFF2VTq9LVf0Ifv3KkNlTeiP07PVPn4dUdo/U7VU2bkVVVMfcxcve5CHHpwkxEtAJWJuHvmmV0pV2aIKxe0syZK7Z+INtrH4z+lTQt7UC4MSEZ6gquHiCxHsM3DS4YmlfeA+wpd11vROjHhYB9+YGqovNaCBvXsbl65HkLv2BaLVdiBZFn3EKRQ3/JHSSjLlLMBug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUCsaLhtfBFGuJjjv2eEqMuCrZ9FxkCG9ws8B4LHybE=;
 b=IKt0wtujpqobwmJMY18jfvXrXVJm37MLCJeQwskLgZIhGBJBzh+fXxeyPq5dZINtOOsIvms8bPRfE2TJTgOJLUqFewNpOXpIwHHXqLReL2JnNnXyoUHNOBfF98+L7FsRxifEQBoogj5cLNS39/YUwaaV6XZVpnXbyg1NTAo5Zdexo9W25/qEj8BSoRttE9LyLPIRzR4K+wFsYOK1t2EUvgV5O73Qy5u9E4LvDtLKjNnUgxTiz1asmDmCHOqZpyMnzIqhW4Ju0ASlw+Dg6QuZgMqDiabTJwfUfI+XIk3X+j1uw2Z4GpzZ4StU2Msk8PBqazuVbdLKx5lLu5rLehx3jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUCsaLhtfBFGuJjjv2eEqMuCrZ9FxkCG9ws8B4LHybE=;
 b=OgQiLHR7YoZa8lbuAycM6m+NLAX+nh6gWl3ffz3xUfrQJTI/Yuok4WHfn6Bc6kokGWB8gtLHOKaxh5FI0EAgWeVvP88iG3Wj0koqV2HFfpkKq5JjWJXjRUL+JE8nW5Pe3hxzx+GW2TjY6GcKN0M+wdPK2HXLttkF+dGD/tspHYY=
Received: from DS7PR06CA0002.namprd06.prod.outlook.com (2603:10b6:8:2a::16) by
 PH0PR12MB5679.namprd12.prod.outlook.com (2603:10b6:510:14f::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.22; Thu, 25 Apr 2024 10:00:43 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::3e) by DS7PR06CA0002.outlook.office365.com
 (2603:10b6:8:2a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.29 via Frontend
 Transport; Thu, 25 Apr 2024 10:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 10:00:43 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 05:00:40 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
CC: Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amdgpu: Fix out-of-bounds write warning
Date: Thu, 25 Apr 2024 18:00:25 +0800
Message-ID: <20240425100027.637016-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|PH0PR12MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c89c3b2-068c-428e-5121-08dc650e91e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400014|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GBqTcxuk3CHoO2UC6UjLowRloP+s8Ry2xeq8YdRX2EFUtsacdrpaZX+8MGrP?=
 =?us-ascii?Q?ZXI6YYWqvvkzhqdc+t+T/9gTKVqvD2Doh+bwalRWKUwrvNouvLYlc+zP+/S3?=
 =?us-ascii?Q?hh9mrEz/D8MKR6neiUAXwcqlI3vfrOttuoTiX+rAljoQ5+Ac8tNo8cca/Xvs?=
 =?us-ascii?Q?ebNnhVEVd0WdKeb9CYNwCirrkv+7JwiSPtWNx15AkKKscuUsvBTGneLmZfRP?=
 =?us-ascii?Q?4CMQae5GXVSNpcQzDxhvQenK8Nv90P3klicLtGx4gY36/ooQE3AJfSjRyc/K?=
 =?us-ascii?Q?2o40GcPeo/Jzzcac4R/aiFME7iTaW8STC7tXI7+ZLBKYPz+2nBKGX6k7ZrDv?=
 =?us-ascii?Q?8TF3W+KKZpXQZoLEWtNJjQSYDB6HUErM7qVny5r5gW2AA0YPjPfZLTfFX6mk?=
 =?us-ascii?Q?rnX+JRBOXBFR8QwU6+RQE6miKQclejB42X9EaSkanC95DZ6O45mXs1FK3o3x?=
 =?us-ascii?Q?/jtHr4E9dLlaGSdjeU1oqs75VhjpuLqAJwbfUyj2kqRCx35NsUzh7Ap3KSiW?=
 =?us-ascii?Q?gUFVWwm9n9AXTi4Kg097MQwU9YtcDLeVWm7bMBj1oiF599juGQwS2DLNd5BH?=
 =?us-ascii?Q?eJrFqLqH0VdfBUbqkoTaUN33mhcJv727wYPokA9HQt9fFVXpT/WP4bHbc6r3?=
 =?us-ascii?Q?sqm4YR+FpZC7P18j7URQu+yv/bzuAWPZAKFUi3LyiCftNyT8APbRjuWnYjki?=
 =?us-ascii?Q?1dbm+YovbSDBAL79ZJxOZTGxoksMLFKM1xI7+73E7KVQw2s1Hv+dCqOfq6HD?=
 =?us-ascii?Q?Akz8rRkmrLqazOJWJXkA0dfkyAFhZFG5NmNdg2o/XjhRk+bd2YNlKSZ57vIo?=
 =?us-ascii?Q?TlG/X+O7kzUl98lziHp6fIH8D1ie/O22uDUaoAV9T/MRwtuYBT6nBYUyWfnp?=
 =?us-ascii?Q?2IHgrkfAIq5lgijppUsA0JU6Tt2+kI/ZJ5oBoyRI14xyjDwWWVXnPJgrsoDI?=
 =?us-ascii?Q?/hsOs4kPW6tH7aSx6xC3/GcLpdy6PpjAVIEFvAf8qhBdMLHh/NE2agc16ZJm?=
 =?us-ascii?Q?jpLpALRMOWK1jIq9fzjJ0kP7Y92C2z9Er7tQn9DHppNQq6GdrJwWIIeKh68n?=
 =?us-ascii?Q?OMa3Po1HZUWLs4upoJnRdm9VQ8s2IcLJOFR1vnCCqS+Z4qumv0inC/rCXcAV?=
 =?us-ascii?Q?N0tcvKkp06ustlC0y8vKfFxt51k5pI23LhspbWanK9mrBWult2qRuXCnm+IK?=
 =?us-ascii?Q?KtnKyn9aACNp4SfiVhnZvVz7K2JKdINCwjrCIqBt/sBYJuEy3Kl/51+CoEfz?=
 =?us-ascii?Q?Y+/SCnSlvDGHCNM6PSuWKdvYHu6ohE3eo39KrQXlaQPyF2bPrD8Hb+2qLkRV?=
 =?us-ascii?Q?M66d53Nvu7O8ZESSRNyypz/yYJzyZLt+oFtENk9ydejReaZd6lMvDz2IG9oW?=
 =?us-ascii?Q?gcZVS18=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 10:00:43.0084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c89c3b2-068c-428e-5121-08dc650e91e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5679
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

Check the ring type value to fix the out-of-bounds
write warning

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 06f0a6534a94..1e0b5bb47bc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -353,6 +353,11 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	ring->hw_prio = hw_prio;
 
 	if (!ring->no_scheduler) {
+		if (ring->funcs->type >= AMDGPU_HW_IP_NUM) {
+			dev_warn(adev->dev, "ring type %d has no scheduler\n", ring->funcs->type);
+			return 0;
+		}
+
 		hw_ip = ring->funcs->type;
 		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
 		adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] =
-- 
2.34.1

