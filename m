Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2627C83026
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F277610E954;
	Fri, 27 Jun 2025 03:40:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vDkqfumc";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0085110E945
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEb67RswhoIOQYYrxJctKTUBmkpxKdil4/6BMSuNlJU/0pXZMrtwPVO9KKfoVCKewYGm0r/LVXhXAl+I3mmWEzv4SSQv7owbkZjWyEQBnO28GvApz2XkrP4QOHWphyCNJOYI82mHvyhW5A48aM3FSQoYayq0aVli/uYl72fLe/E7neyzQZJzr8UezE9vJOBMPXw1xlT5wCBKhc7ZTXCiVMBuIy6vFt5DkeYgeXlKj+MHWvWVcedfWIiagQFY/3ArsMOx0aKTMmUD8rhS+UpSACvJEXChlicwm72fyH9CGHXmzp4Rmf9mtJ/WWyAKcTXGDZ8z4RIeea6yEhjRfLGMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKra5JSPgZKJaqQ8ouDFDfjsID6k4vQp0phYGWJQGQg=;
 b=CroE9SH8qPs8W2d7zEXkTxWopWbwtJ+OAieJlZkeNakJ270hvvdJ2DwyltV1bA3svB5DC7RHiKERDgO3aALx7gMa5TMPlKjSXqvUJm2rcd/IqcJG4QT8Sfe/QK7fZX2Oxp437nJsAe2lnEmngPa/RmrH2eHsirNwi3mGW0MaHuI2hRYJTN/UBYlM/tw+9KVKrtncezxACRf2rKUOuwm1BUq3Cbog3Z+MxSQ+QQYu6bXr++CO+1kOZOsPFXgyi2OL2Ad74bw2ibIsXdP0KTV+xGSi/L2eOV3/4Qf9sh3Rw3YgL0pLKTbGP9xQdFqMgE9ruXKBgJYAd2tDKOOwmvqZtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKra5JSPgZKJaqQ8ouDFDfjsID6k4vQp0phYGWJQGQg=;
 b=vDkqfumcfgpuI8/XKVtPCLE670vjGkYMllctx8Pa4Y1o2GBWEI7IQ14PJEJOFcLLjwHcjclxjcpnojVZlkVjM/pQ8BwKVTNWZwFjUOIvMoTtNNLFnt66bEvd+mQAJg8xz1/GRIKdyWNcc77PuNZCDDpb0eB6ROPuDx+Mq1H1grE=
Received: from BL1PR13CA0193.namprd13.prod.outlook.com (2603:10b6:208:2be::18)
 by DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Fri, 27 Jun
 2025 03:40:33 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::e4) by BL1PR13CA0193.outlook.office365.com
 (2603:10b6:208:2be::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.9 via Frontend Transport; Fri,
 27 Jun 2025 03:40:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 20/33] drm/amdgpu/jpeg3: re-emit unprocessed state on ring
 reset
Date: Thu, 26 Jun 2025 23:39:49 -0400
Message-ID: <20250627034002.5590-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627034002.5590-1-alexander.deucher@amd.com>
References: <20250627034002.5590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: 159e6d53-bf92-4936-60ef-08ddb52c5f3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6dtOJCPvnx2byMgvpmT/XgZDCFlp1ewQAiQKjKF9tH5ehTkURbfLAj0hLYsN?=
 =?us-ascii?Q?Z0lvPFpgX82YrIipcmQBSVMUTRYZh26m3gil5sckruHQn3CbVvgcMCLHaq4k?=
 =?us-ascii?Q?l0ZLnx/JDo8OoftMBlbwfGa2+Yx7BSftLqKlB+xqNRyQzKYBIgZ136z5ka70?=
 =?us-ascii?Q?eSvlFsOcUd2hZL8jbsGWh7h83EHJDTLGcVV6iDROzLKdQ1eXUFx8wzOiO2Oa?=
 =?us-ascii?Q?kmCLz/mlfG2TWa+DywjOUOcko+p629CqwvhHly4LL1AX5tEKiYNsHSUCP+JR?=
 =?us-ascii?Q?jpbeWTBxaF5MQjfl7056vEuw7dE1ay1HJCCZzZ7xFCoeQ7ZOdaf2yYa6/CKJ?=
 =?us-ascii?Q?38ymN08ZY67NVJ+WuzopxUBxpT6kMz/4OjwfA1F7WOmYgs7tgmNm7Z/Cx+fW?=
 =?us-ascii?Q?gUWi/Rdk9q8fElMVdsjWbXAIChE27Fih/jAL7up6NENH6jxa87SW49BfZLd/?=
 =?us-ascii?Q?jQTibroMPND4Y7RhwZ6F/DsRZBBIOO1krMpzrDkrfWipziJ0bY+POoQxAICf?=
 =?us-ascii?Q?W4EIrE1Ec8HXvg3TqvxuwNRB2dcE4RywhtRThci3qM8PIzWXalweK1zNinXT?=
 =?us-ascii?Q?OgUAyPSqH+Wsx+kO7TdzT0GW65ym+NSkmyNp2aLusyG33g4HyXudAK8Py87E?=
 =?us-ascii?Q?JaxzoXdNF1iYbpzzM3LvV2kEoXJSDR2HkBYMi82dc1tXw0m9pBgnqvEyb8L/?=
 =?us-ascii?Q?ZPfpac9bbEzKRsjFfTOr+Mdvk5W8szWb20cHArXjMKmVa1hs3EVgzK8fKQEI?=
 =?us-ascii?Q?FweGJfbVUwQ5hz3O5l/4AbgaQHhgUKx7OC1CyRnvgTLMV4czeUXwdqKzG15y?=
 =?us-ascii?Q?iYHZD2k0tNZ5d+R983a0ZpuDGhbqWlQmr2j+57u55NyvNSE0QAseaZU/YwZY?=
 =?us-ascii?Q?6i8BoA1l8thYmJEp8wNgIDi8dS9caOYfg5JpH1LvkGIjwUPiiul/3Dx43yH8?=
 =?us-ascii?Q?Cuwv0Z4q9a7pJ4I/0jBjSZLfOlK59bT2KhIPqj7g7KLYfRz4HoznvBAUYMET?=
 =?us-ascii?Q?Ob49MK+B1o4N5ubMm5vSoQJqJ7c9Zhal4f6u/9D0qW0bZRG+3PQjQKzjtfc0?=
 =?us-ascii?Q?/TkO9gRdrFuGm+WVbj3yk8dgnogh+yBmeeEsYh9rvSn357vUKye05gRP7YDs?=
 =?us-ascii?Q?vJF/54srcS7FVAXZAJCRBDeax27atUQxMr+645uzzvZCh4vNFE8AidXXP4Cs?=
 =?us-ascii?Q?yMAJxZVkHPQM5e51Y786ygpmy+fPeLNk/3dSqsZ/VbeL0gwm5bXPqkGMR/K5?=
 =?us-ascii?Q?wJehXp06tXFa0zlZXjtp1VIW9XDvqB7cnrigkFWMcFVuSKYkCLZ5aJRVxvPt?=
 =?us-ascii?Q?q3iSLQbc2VVXX7hV1a4OPnwA41TBjnI9jaexVMYqhrPTW/VC+frNu5/oByIL?=
 =?us-ascii?Q?BEU1STO7Bdw5herJiOE2Wv07xsCuywiII1oNUhXLt9C33YKYsuX+PosHgA5w?=
 =?us-ascii?Q?hUzYaaKR1VibzV1CcpWjF/uXhuUu9NtuVmTEthQ3/Z1ZyFo9MvxOcYGfLaUf?=
 =?us-ascii?Q?nbKKrvu2QhtW73v9ZlpNEPja6SmJldDFP6r5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:33.7007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 159e6d53-bf92-4936-60ef-08ddb52c5f3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
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

Re-emit the unprocessed state after resetting the queue.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index a24bd833d6442..5598fa40764a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -559,17 +559,10 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *timedout_fence)
 {
-	int r;
-
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v3_0_stop(ring->adev);
 	jpeg_v3_0_start(ring->adev);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
-- 
2.50.0

