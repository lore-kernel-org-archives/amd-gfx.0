Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BF4C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 10:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A70AA11A350;
	Thu, 25 Apr 2024 10:00:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xTs/YRSN";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BB6811A350
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 10:00:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lijPEoejwNP1RPPPqzOI8pNMhYBasO20HHAHoQGZrVfVFztCUS2t7h6WrFySLIivwE6/GKHWQDY52HuVkYs5AbMktU3jgOMs/xMOD9+aTwLvylgUSFNFy16gVrqiG0HTHLqiYxscCvSzledGcyhGC3E4Fx2pDov/HLOIMdg2Ag49ltW8Lmgvn7TbkTZHbUged3n4mvFNqXutamDWFEYFUJZp0a8lmepsSUJAB/DdQE985isz5Z5lSjV5a9i/AnvmbItPEc3+TTJMJbXUxfyuqAB2ycMN8ICHyMiu5Mu2XaERVd5a4Ir7IDkiKp2riLQ0r/EtAh7P56MgZiSd8yOx4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXZZljAKP0zPOvkFAsS1HKOKOhqiqTNbspIf+TLXZpA=;
 b=ZeGOvcl4ddC/2imzsfuh8mYrIFlVpEWm1J8cDJrTu9daAFQcN1R5HI3J+2PzD0KqE/yQR0dE5gP+CCZKE1rvHLdIaTYksNqcQ4zoe+W7pCkcdde1w/D9GsJo2j2jlsoex2HBj1Lxcx1ru7zX0NnjGuSYUfg4EclTJDKJDuG906HZ2p3qyIs2RWVuJ2FXjknA0QDQIjH2ijQSIpWujw8WHFz1uCyVnUifBrmJvmwJbAjAA0C72SByVhrJVugNHlJnlQrycKEzd4XMaGfta/GOX/xvYKtAnMMSgrnySInn2frisP8NYmAFkIprlDBYX0iiX1tp3MBjDMibRzlzPwfF6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXZZljAKP0zPOvkFAsS1HKOKOhqiqTNbspIf+TLXZpA=;
 b=xTs/YRSNYGt8xi2+mYXj1rsIBg+P8qcC/IsKdTQhvKnOVZck7OjoVV0m2o0nGvYYVUWN/1hPKSR8VRnXmCSHIPMJxi5h2SoqQxD+GDIKRHHRnUjYogkJ7FQWE4lxVjrJxQTF6ZWtALiWor+P92IjOX4lMCf+mIngtXFnAiC4sME=
Received: from DS7PR06CA0009.namprd06.prod.outlook.com (2603:10b6:8:2a::28) by
 DS0PR12MB6389.namprd12.prod.outlook.com (2603:10b6:8:cf::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.22; Thu, 25 Apr 2024 10:00:45 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::51) by DS7PR06CA0009.outlook.office365.com
 (2603:10b6:8:2a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.27 via Frontend
 Transport; Thu, 25 Apr 2024 10:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 10:00:44 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 05:00:42 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
CC: Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu: Fix uninitialized variable warning in
 amdgpu_afmt_acr
Date: Thu, 25 Apr 2024 18:00:26 +0800
Message-ID: <20240425100027.637016-2-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425100027.637016-1-Jun.Ma2@amd.com>
References: <20240425100027.637016-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DS0PR12MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: c4e9df41-e2b3-481c-a6f9-08dc650e92fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400014|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4TtL2ZlsCFxU5fibHYZ7JPj8C6cto/p1ZvbddSznYQnOyooh0Aed78jI8RIk?=
 =?us-ascii?Q?vpNOSggoSZLZFXmEl4h34QNqhxoB+x+OlYFmF1LVD8jHbAzf7dopMB6yNeVB?=
 =?us-ascii?Q?1yoE5/QqlzqJF6lg6/V0KU7CoZq+R/5a2JCu8dEir4XthdANXVOkVeTFPUX8?=
 =?us-ascii?Q?el71hJKfkW83sCBjhZsenDEktxhTyOXIf6RKh+QBammVjR5/8oPHzpgs4Jwj?=
 =?us-ascii?Q?V3GInrAZSl9hQ9dOKpeb/Q9e5arsGZC3SjsHzcxFXjz8p6eNwQQ8apJPkS2j?=
 =?us-ascii?Q?lGozBw/tnpCE5vaHdjaH8aLtbnLTGEE6gzutzCpSy9QrvPxKg4g07QJ0ht/h?=
 =?us-ascii?Q?jCr2/H/iWigjHOKI6fgJ/iplXwKVkiSzajS/El5E/V6nIQV6fhTHdIlmNba/?=
 =?us-ascii?Q?zePmeDnmexBe7ZFGbLujxJjfGqPeMBca0XCfnyKG4Q2k5r0HfzSsEdoxzrDc?=
 =?us-ascii?Q?2P2uF04lwlm8mF8levqB7K+18qjgwNrOG+Qod74PYpEwN1Ua3XJrjfLt+y4w?=
 =?us-ascii?Q?96gbvtHRmDGWObDhoLtcKaeqvCvZM3z0kBEdTiKMee9BsHFfevEZj99gn4lJ?=
 =?us-ascii?Q?wgeom9z6+bzBsBfIZFhOJ9QqDDQUGbP6Vdm5SXGW5+UKorPrJaksS3raj91V?=
 =?us-ascii?Q?V7qZMPdXgYwfjuZffS7wJNOmY9vdHri1yPPfPgECqks2Cb368Gi4ue5BRUo8?=
 =?us-ascii?Q?DgN2GZi5naCE/Xm5KY1zDYXew6REZGkx9kCNR99+EFq8c5Zc2vL2Pu0CFbLb?=
 =?us-ascii?Q?gPDADjNcDyG7Xs6QdqggpzyCSCOWyqLl9QSVtMeuh1ucx7iDaU01U/KLY2r6?=
 =?us-ascii?Q?XVxaV2UIrWkZiXlQqjd0RYKx8ziLYHH372F8bbgzZk/KkDJ1s9Xiky6TKTcz?=
 =?us-ascii?Q?aWmFLGkc+Re5pnKwK1adTSdx0xSkADuDi2XUtqSqQIuinjogYzRDrL8Rztvi?=
 =?us-ascii?Q?R/71om98Xhy/NHlaut2diLR+5CCjnDmAbooPTKOV9cr9MursoLE5mvryqupi?=
 =?us-ascii?Q?WrGV9foPy81lLztkiiGtoHWRWCj3pxk42IgPpO2yz1pX9JVhDpFf5N0B9Y7K?=
 =?us-ascii?Q?u5/aKzLhR8T29X8zT3ptJ226DxYXoVxZIxW1DvI8Lu3sEKRWcTVLasMRQERD?=
 =?us-ascii?Q?bXtpCtu+PdMYgZ4Hb5CV/Nmy0QMV4xCqZio8JcBtDqRq1NHYtf4KdtW+o5FX?=
 =?us-ascii?Q?R7jCjcpjDKfY/ti/rYlUYH5EeB0PCVTuZl0iSwFnvBcLq2NVBMXoTSFdhcu+?=
 =?us-ascii?Q?JvVVKa++KlQx6bjMVPiGh71alfL39jZP1Iak7LpK4o6dNVH+/K+4ilHIgrXw?=
 =?us-ascii?Q?atInfgvKOQkN1NCoGpYvnZAOAu67ASLBwyYBLqs3rS0/4R2+vIpJoQdjsfr2?=
 =?us-ascii?Q?mEJEv6DI8noqbQjxU7pJ3ZL/kZgX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 10:00:44.8521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e9df41-e2b3-481c-a6f9-08dc650e92fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6389
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

Assign value to clock to fix the warning below:
"Using uninitialized value res. Field res.clock is uninitialized"

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c
index a4d65973bf7c..80771b1480ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c
@@ -100,6 +100,7 @@ struct amdgpu_afmt_acr amdgpu_afmt_acr(uint32_t clock)
 	amdgpu_afmt_calc_cts(clock, &res.cts_32khz, &res.n_32khz, 32000);
 	amdgpu_afmt_calc_cts(clock, &res.cts_44_1khz, &res.n_44_1khz, 44100);
 	amdgpu_afmt_calc_cts(clock, &res.cts_48khz, &res.n_48khz, 48000);
+	res.clock = clock;
 
 	return res;
 }
-- 
2.34.1

