Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD37C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 18:46:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8311810EA72;
	Thu,  6 Mar 2025 18:46:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ws3vc5ZE";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDF6A10E329
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 18:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSJjNb7ltTQlgSuXh9yCUlxxI3FkdSf9N6ZdDPpqnLFQEs15Q4EyLGFOfbqXG2sLuv2es6lHZG9gnHchInof/lkiNxhU7SIogAiVKl+LgPwIzaT6KokqiU4bVMHehV9XYNuKPvsgwtlgINy8bD76RwHipFVStDt1wDcw9SzGbzwfOK640lhXBSsbokUHOwsdDxwr6yy4/LW7ysY1LIprgz8OSJz/leeMwlKE1EnxuChmsIKjkP74seq++WBLpVKUT9s2iYjrzSPIJus8/zAbeSup36GssVGjMW0TBgfVVU3hEpPIgyuOyOk1brlkGOI5jPMsS2O4HEfKqDoC/2Pa9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvr37PfbO4ml4tLBDtFb3mZZtAg2FY2VfuI3iZ9K+Ns=;
 b=KsIHaurQ11p76dHTuODC87semR+jPdpiFFYQkVBjcItn9osuPXWGk/rhyDZsNoSYrv/cPbD+4CsQRUR0czHcMmBoUE0L3P+6wxvhvCoRM4eP5VSmekhMvliZ6sOBh9YQzksCbI8sN+TIqCekafWD+ldQAMlRj9Yikk+LzT5aeSNzxy62jfKbmFzK1DzW+BOzF2XpFThyJx9YpKcllkUmz5MuzPErS/GS158Zl8THxU2uZW6tMosw8ZNWfLkKO22Bq5h4t4dLbWBVYLYOv8YnJ5IcAwshnHLHb0pb0exlXMS7O7sHVN1++hlsPYWvU2XVnasLF1hJZWqviEKJidRvYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvr37PfbO4ml4tLBDtFb3mZZtAg2FY2VfuI3iZ9K+Ns=;
 b=ws3vc5ZEzauDxaV7V5i985U+Jt+sLbIQo8WBEUBGfGDs2W6eKD8NXgptUxtXgpKuKbibJq9PDqOhzjHyPIh8gzShbLUtI5VtCG8VcN4kSLn3zWdL98518k4Fi+CFtlowDXd0TB9ES4lwWSRyoFQ2l2znBjWIFDqf1CK5uy4O8Hg=
Received: from BL0PR02CA0025.namprd02.prod.outlook.com (2603:10b6:207:3c::38)
 by CY5PR12MB6456.namprd12.prod.outlook.com (2603:10b6:930:34::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 18:46:32 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::e3) by BL0PR02CA0025.outlook.office365.com
 (2603:10b6:207:3c::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Thu,
 6 Mar 2025 18:46:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 18:46:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 12:46:29 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 09/11] drm/amdgpu/sdma: add flag for tracking disable_kq
Date: Thu, 6 Mar 2025 13:46:09 -0500
Message-ID: <20250306184612.8910-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306184612.8910-1-alexander.deucher@amd.com>
References: <20250306184612.8910-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|CY5PR12MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e80117-5dff-4943-b42f-08dd5cdf36cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q71ut+/dMmqfBSuJUJC7rZdONJoUcAeVMknHgDBC9SKfxaiFoCQv99ybmFsH?=
 =?us-ascii?Q?qX7wMdji9RY/K1J/EONsVL4XzdluPqA+91qXczGA0Pr/jgP1pge/UZUMbif2?=
 =?us-ascii?Q?OaZ1SdoF+7o7ck59srk4nxvh33LCOHY0saUDAALcM7NgkT522mImMrWE9MKw?=
 =?us-ascii?Q?B/if/7DwnzmiqL/gBEAFTW7Rx1Fv5ZT/FOVORcW7YukDgFPde9WJkLZkyhkY?=
 =?us-ascii?Q?fXR9XWJd69+dKTsKOJd22/etixDKzut548fd2JEQQKcGW1DtU1SQpv+kTtgQ?=
 =?us-ascii?Q?lZOqpbK5XzC0C7FHCiTYMsA4iFeVewUQZ9OHl305cFC9HRCmPqIaXRACdDbw?=
 =?us-ascii?Q?MRhgKVbsQpZTVclezYnjUu90bzrhv/P2jwn9nE77NM9vw7Ac9hfukOcmMvrN?=
 =?us-ascii?Q?sbOL/VRWnzAHgH1S1fhN4k5QBPqCnVTTOEFpW93gK6Dw0duj6HVZ+MB06Opd?=
 =?us-ascii?Q?u0dj5So7sw/TpiGO7Fo9wuxIc0H2vGLJii7+omnlTrN1YtTnANtg9Kt0nwRd?=
 =?us-ascii?Q?RPMbsXPW+TAGIJtOmsVuTkA7m/tNAJnmHic7Ccq94O3MtAGUs7OiMNC5MQxS?=
 =?us-ascii?Q?DqM9HjN6RsF1to/pLBS0ZRrjldI6eI19iNEt42ST2vNNL1dg0RT4XRIS4uN5?=
 =?us-ascii?Q?q/8UT+4+JXqh5LRwqd25le4+/lVROFCzECAgwk8tl8xt/nAOnTNnH4+Fj2OP?=
 =?us-ascii?Q?08iPv3DG5gC1Tn9DcAiPb4Bb/M70MW/EWEzVX/MSvXvlDBd15UhWapEp9Yol?=
 =?us-ascii?Q?nJPsBR1WY8nSRSfeYhDTDhjq/O8cr0ReYizgJbamB4UwbooofaK3oE+hASar?=
 =?us-ascii?Q?naa1uWNNjnO+HsOZybJkWoPBmUDZCgr+n1ovlVxjdQPF/xkqf72u+jjUqsX/?=
 =?us-ascii?Q?tw7w3aUdORbKoZHj/zASiZCuWhBqG/kGE7VKCEeNFZELvyCZa7Y9IOKRQIRk?=
 =?us-ascii?Q?doCkDotp7qXFKkahQfgzyDFslkBXzdktm8unZTML/wSyGRc/m0Dql0j3YeC3?=
 =?us-ascii?Q?puNZdx90mYW0qJxDIbzV+5U0t8Yz/45FkSJjkq0lnBH6GHL9cpQulAynI3Pe?=
 =?us-ascii?Q?LwCNEEI64Ru2cO9RevgpsHYIcoXGMpEINcifM59dbitgwD90cIA0UoVlSEtu?=
 =?us-ascii?Q?M20unq6qhufRfO/34fy36UWAhfcfDcNQ7lHpagWloIF5TVnH+8WRfQQqvFR5?=
 =?us-ascii?Q?vudOrY60cPD5z+sPdeIroQgjFZ7zNB6zpmDLz37rigqvDGS1DutqLsg1s0cQ?=
 =?us-ascii?Q?4uQgh3l0fDecO94F6BZQ+y2w7UQqVFik+yb5E0ZcKL78PAXuUtsjMBwzJCt9?=
 =?us-ascii?Q?byWh/O0MQ1JT+cpF7oF85eiBjhb60ZaW7gswu5bO2ClTm77OyHKYasf052v4?=
 =?us-ascii?Q?rT2rHGCf2oF4Jpo9JdBQ4HVjGlrhgol83/sDkNyHutGe7AXtsQ5+sJjJrLjr?=
 =?us-ascii?Q?YhYEPZMtSqduDfKGHdhY+0pJOQ8w7xhrqDnWo8/zyendrfvRW8ZtweQBN4h5?=
 =?us-ascii?Q?9FLZvOqD0w4Fs+Q=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:46:32.2857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e80117-5dff-4943-b42f-08dd5cdf36cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6456
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

For SDMA, we still need kernel queues for paging so
they need to be initialized, but we no not want to
accept submissions from userspace when disable_kq
is set.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 9651693200655..edc856e10337a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -129,6 +129,7 @@ struct amdgpu_sdma {
 	/* track guilty state of GFX and PAGE queues */
 	bool gfx_guilty;
 	bool page_guilty;
+	bool			no_user_submission;
 };
 
 /*
-- 
2.48.1

