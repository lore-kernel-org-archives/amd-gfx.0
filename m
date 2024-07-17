Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA502C3DA60
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 20:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7029C10E19B;
	Wed, 17 Jul 2024 20:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AJlpYOGi";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1969C10E138
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 20:38:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GeFvjbohyNrkRErhqRpasl0i5VWsd/WGaifSHFlBStmAgNFnNaQ4iRYm0RfY9kbMooecKF2BgMCdTQyeMRploGSnbOq8L/KrO7i5ZKJaPwHDOKXYp5gvX/QHDMNzeziXIkgmX9HODAKnXHbZfyp9pyrN/v0QvgpxeJ7OLHHYgmVupGSZrlcINms4ZNcgDGbubGxi/5bmxpcBdwjJg4/bAfhPMYAB9PP2lIsREtLihAcNs3Y9nW8Pc+zi1Iij2r1mISYNWrd0e8t2fr46TccAkarWU29GuR44rqC4kZmlq++jVThzKPoQFFbl9JSM7UVcDHw+gRcwhl8meEXSFnfaWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyzKvftcoSaH0y6JBYybrVRAgvqmD1RWKoooNvYVMgI=;
 b=ZAqovPypQ/CLeTwtjC+taKWq0SD4ZQj8nadQczV388H0X5VQhtabO9MbynjUjGSUecNr/KG//RIAe2WueoOdqkgqjCvtCTX5M7TIFpLrCONY6zP+DfNlEG1roj4yyMyNNCcO2ghSCSLGD+JlAQ2EET0dyrjWiXGzxvKlXZiY+N4Yn6E6uLbaZ6Hx2rktr2ZAeMlHyeJOgKL4sUM8lGvY/Il3fcAijgkZiJPFu67IgUomA3UVs4HAnOKP4pCvNpBpfTPgoKUjZLclvryJlEDhNeZUhmuhZjIgwGcaJw968JbujLXmCEOqWJSf2KbSQsbhCBPLArqhjugi1dAwuyrL4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyzKvftcoSaH0y6JBYybrVRAgvqmD1RWKoooNvYVMgI=;
 b=AJlpYOGiPXHM9ulfdOOg2CWU0g9RyI02Bw31T5YCorBy5aizCYC2q4PEzdExOm27QpqHDzBlxjGa9ob7KTBSixxpkX+t72UKJ68HPAit05wDg5J8Sq9yQ3GMvS1wxeNgIUxRu7qt44UlGnVyYZiIZNMAAqoMI5ujAAyM+dxfyiw=
Received: from MN2PR18CA0023.namprd18.prod.outlook.com (2603:10b6:208:23c::28)
 by SA3PR12MB9160.namprd12.prod.outlook.com (2603:10b6:806:399::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Wed, 17 Jul
 2024 20:37:56 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:208:23c:cafe::25) by MN2PR18CA0023.outlook.office365.com
 (2603:10b6:208:23c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Wed, 17 Jul 2024 20:37:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Wed, 17 Jul 2024 20:37:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 15:37:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/7] drm/amdgpu/gfx7: enable wave kill for compute queues
Date: Wed, 17 Jul 2024 16:37:34 -0400
Message-ID: <20240717203740.14059-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|SA3PR12MB9160:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf2f17d-d9d4-4aa9-b4bf-08dca6a0569d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rMQVlzLzLQMo7yMjdmV4wf1UN+MGbzdhfrVndSeFvFmnska75eFkPmgFqTJZ?=
 =?us-ascii?Q?n2V5J6x+1pOQnFxgiq9RFOzA7m6OHvQR/4b+IGB+3LvQOryduEtLuolFHisb?=
 =?us-ascii?Q?7VEMPSi4XQ53mRffS62S8j9bdtF+AtTfWCC61STS/RRM+GGBzv1aH82aT+1x?=
 =?us-ascii?Q?xQCFYcYKIjibVonK5f/bFi4jKJ141aY8bRcPxqTX+VNY6wBy3ixZAdeo06sj?=
 =?us-ascii?Q?0qB4jm6P01KvmfTtoh6zmQyZVFgdRwjMjlXpi7QxsFezynT/OieBZWb5j/DH?=
 =?us-ascii?Q?ASnTz6NtvpOBiLFQoFO6APLuKQqe+nRnYK7v7optTE7JaC79Zg1bTy2NtPCS?=
 =?us-ascii?Q?3iKL+H265UhS4uKVgMTb1N76N9wKviYQQAJiEFFMH8/p+2JLXQj+JwAgMRWL?=
 =?us-ascii?Q?25nmt23aO59tgKvP5PL0vWm9hFV10iK40K+5G+gec7yd1J45KM1f378RWQv5?=
 =?us-ascii?Q?zi6s/GWW9M0uzTu8gVyRcmcCpIPvNtIllr//k7BY5GKQ/iCi7iuT7IQoNP+G?=
 =?us-ascii?Q?WJRImNYFaDj/fiujGQ1dQN/VnP0USKU8BUOdUn40DGdH3Q+QP4qPyvnw+ZPQ?=
 =?us-ascii?Q?QHqPfEl+HDbzlbcf0zImThV7TMlnwaCf2y3iY8hIHO8xZrtliRG5zOU0GJ0h?=
 =?us-ascii?Q?krt3pGXElCCmfD0Midv8zD7K6ElouBTnpu8xL7UYJXlcSzdT4Fh5w69thXxA?=
 =?us-ascii?Q?5bGKPB5XpSBmQWPTplgbmMfMVXgbYgRptsT6b32cn5IqCiHHJxUUWRO4jwoo?=
 =?us-ascii?Q?6eL/vp2Y0dv5Wh2jEGIbJ217JbRfdhqXDfgBjF/srYr7tU2TcTH5xe7xDffF?=
 =?us-ascii?Q?+0LFRDp748cfIZhtviFy+k1uv8sqom2YF9Kt+fTjU+1mpD28nYhn/FQiQ/6x?=
 =?us-ascii?Q?AlhMvpnlq/aWFrNlUCnDHh+6QZacpDTISYlku9xtdUdjq1XusurFxTUNgj5z?=
 =?us-ascii?Q?AaST2RdcnJFq7OEZJD6QC5Djarf9thb8JBh5ka1WyOwKu+Tk6Q1cyKIOiFmJ?=
 =?us-ascii?Q?WJuRE+fmv+Vi4uBBmoOQ40Mc57RAXCz6q7a8FndnaenOnfEfCTDRrqWGj4A0?=
 =?us-ascii?Q?kS06QSm33DwurYEpWUbs9skoRLgpMSAHCFvBZ5EMnId9gIjp5ty8U6E9ha6a?=
 =?us-ascii?Q?2ds27EcEZAj4kHT/6I7Y1OLtLrTUe7/IMSqBg4fzO0maBmhYqj5hWWk/T6Ee?=
 =?us-ascii?Q?+TB2KV2m3S3ct+xgBvXANP+OxkdJesnxyQj99CFmYLymNk9xfKkfJscNzqa6?=
 =?us-ascii?Q?ZGQWR9gwaR7mDZOcTWN7BJys9VpqRVX+46XULxKpUcMUBimFpad9Iegw3ZCl?=
 =?us-ascii?Q?7lpJvDRmh4ilPhIXel7Ai7iVjo8JK29caXoClTOqax+5Q5QNiN3X8nQbkG+p?=
 =?us-ascii?Q?x2ggqAm0drCfuwnsRhqkg81plvWq2l6PFl5NjkiSdFbwcGQwjPs8RPZEAJcf?=
 =?us-ascii?Q?X3gDc618qizia7JG/GvvKsbcrWjuFoBX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:37:55.7296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf2f17d-d9d4-4aa9-b4bf-08dca6a0569d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9160
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

It should work the same for compute as well as gfx.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index d84589137df9..5fbdef04c9aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -5002,6 +5002,7 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_compute = {
 	.insert_nop = amdgpu_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_wreg = gfx_v7_0_ring_emit_wreg,
+	.soft_recovery = gfx_v7_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v7_0_emit_mem_sync_compute,
 };
 
-- 
2.45.2

