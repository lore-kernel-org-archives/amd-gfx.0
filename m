Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A087FC71150
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA79810EA67;
	Fri, 13 Jun 2025 21:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vRVW7kVb";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E978010EA64
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8MGg7yJppNSSi7iUTY6mxY5mAdKvpDdulIQkGJQbKpdetYRiasgnhH0aQlX0UU9ibnPCAjspmNaBCnJ+1NnNfHFd8qYDUeJeDlnfzroqaEMFT7POO3pZbfAr/4Vh2k8lbvHSshBRel4IqhF9+s0rG5trkew8KMCwuIVNEhv+1jUD7C57nxdH9t0EPDDaUBj1okn24tg2i6TsF87FeyjcAVlYp0ZelzBYE9wPpzRogUJM+kN23mcQht3Zo0kqhnvzL6/32rCdMgbTBJi6qYj828DHwzgOWemOv2tFtp281YnNni2zfq1ocXCKdf6JSZvYz19cb1y8NsAHEMpPfy8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnWcZI2xg/35kObSQTagzzdRA2rgJekMUh+rb2YMISc=;
 b=TyThVR2+gsj72EamAeGDPmeMLK0brVrmMEQEVulUwajcyrDLXDGq5OLDdvkB8mnb5q8oAkEVP4iKaanr0Yg/LfqmFs2Nj185dKRs4TAYxTsQ1UuQoNEKWN5h2YFWy2031i3JknICm29nNNadObumx55CpZy9qtU+NEImK/DOu0Cu3OcfJ2V728pc3eP+vQJ7B1qqhgcnYpERxy2Y6ev/6wVuDdmY7le6uiDsAxoXlEPrbpM4p5Qsrq8s0FJFacEfdDGkLdPfRqwQtA4YuVx2jO6b2OL3msBpunad1g3DnjJxDRrHb0A2HoNAEGwAibKECeGaraupK+AD5IuU8l027Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnWcZI2xg/35kObSQTagzzdRA2rgJekMUh+rb2YMISc=;
 b=vRVW7kVbOu/sNKvVf7Bs0RgiCCc9okq3jPxn+muMXl5SKOTNtWByukDlqJRXNqQO+oo1LPb86UpgdH2kU8zeFxJVvZn/RAACvgjboGWLazra13KFJLUFVJDbcpBBXLVmqhIBZDMHsiLdUZbh6u42Nmvnw3i9+HqyPh9iVuSgH3A=
Received: from CH3P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::12)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 21:48:15 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::d4) by CH3P221CA0022.outlook.office365.com
 (2603:10b6:610:1e7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Fri,
 13 Jun 2025 21:48:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 20/27] drm/amdgpu/jpeg4.0.3: re-emit unprocessed state on ring
 reset
Date: Fri, 13 Jun 2025 17:47:41 -0400
Message-ID: <20250613214748.5889-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613214748.5889-1-alexander.deucher@amd.com>
References: <20250613214748.5889-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: ff544391-7eb3-454f-e529-08ddaac4004a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TBCY+4h4NYuunTg9i5yb69sA512yuXdi9SGgoqk3y8mdGgg/jsbcsbiJyPOg?=
 =?us-ascii?Q?ehl3x2grFT46rSvqmP0bANFNA+loy1yjZ0kZqSBp79nR+7UvFDteLXhPjQLG?=
 =?us-ascii?Q?tLV6Gw29p3lJuKogBKUes1ZBRaTcb+5y7TXe8KDSwY0J4Sar6PLmKfYakn8j?=
 =?us-ascii?Q?YZzmAi1VVb1Sxn37dmWyYhHlwwRl5TgU6V3Q/wYJc3stZnh9EgRUj7bdx7Ew?=
 =?us-ascii?Q?X3tZeQxzY3JmRCYNXk0Eewe0jPY3wA579sWzA4J3FPqMowqFG1dssDwaAIvs?=
 =?us-ascii?Q?Y70otgt/H3nfXv2HazCI2VZfT7Ka86JLDP/hlg0du2GEwaD1dYR83ywlWiWp?=
 =?us-ascii?Q?AYXOQpkQB4jfY2h6HkcOIupGCnXsKQRqDGRQvPt8iuaW5CeowCxo7pCLjidp?=
 =?us-ascii?Q?LGk0wyK/MNZtJlpR7vZElSnH6gx57YPphyYp2E/aLFo4PyurcD5dugFhhdwq?=
 =?us-ascii?Q?u8bYEtkrfARuFdzCUkLupcKy/0aWyCKWVqZKFzUiAxDUDQOkKZ02qU3NNS3o?=
 =?us-ascii?Q?oKtB5+HxWIEFRD6pMrllBa2uSJSlCw65HHMaut+jkHOouLrZmH2Jyi2NFMib?=
 =?us-ascii?Q?0SK3ihlwZYNuE4TIwjOMJNakp3IHpFUfZHfGNPtrlYY9akpArGpNaExKLIKa?=
 =?us-ascii?Q?d0A/Er3fXNlRUlny92Ii9USdDJ7UEApEkWMdkjV1mYViFn9G9HwWvCjFq6aW?=
 =?us-ascii?Q?nzK7OAQAHHrGznkCc8o1W2p41ea3lDN2CNAlxLRFMcKtn+oVpkqEEa+a35gd?=
 =?us-ascii?Q?naSfXZCnzmK3aVYMcCh9CUXvkhKWzsd14bnTpjcF9zefwKCsC/t3vSvIzjeV?=
 =?us-ascii?Q?lm5NVhEnUXm6qdnd5ph0/9vHyRpuEE+4TlvbEMu/zqurS2T+BC8nO31noYC3?=
 =?us-ascii?Q?w4eaKDeCssbrRsmT9Vawpy6NDHPRMJOoXTlG39R8ksNBekf4aLnMrLOzRjNp?=
 =?us-ascii?Q?U+FcsFZZxmDKi4hDQPp7e9AT3lslvJS4u/gehnkVfFAjO22fdE8KT3av7yKl?=
 =?us-ascii?Q?TgLCsAaRs46EGL7DYWou6UOQgSt++oacI59GVEf5j9mCfFCTGUd7GXNQB9vZ?=
 =?us-ascii?Q?Dp+LrpWBNNvYztnpaUhDHkllf1q+/KocrkSOtCyXIFC7BvTbAsAnXoK0DJtO?=
 =?us-ascii?Q?Zhd8mwQs4q284WTYIrStN2rNGdU+Ih6Z+OZhuAlcU9lmg/F/mv0MlmVj2KYn?=
 =?us-ascii?Q?ocX32NhPlaT+VGfvrwKlMMXuPr+N+f4+WpSyS6iu1b1L5sqJmF0xKrg8kAru?=
 =?us-ascii?Q?VzXl3B6K+2x0tPyHm6OQLAmUymoOr7XPnvQLqtTB3rVmjbuSGPGwcPQfrSMK?=
 =?us-ascii?Q?sLzidsbc2pPIsf+DafpanGIU7bOOoYtjy9GY9uwx6QQKS5Xwz/lesaRMMYe+?=
 =?us-ascii?Q?zfN1jGHpnnh2Tkko23U5nSGBzf+3reLZVrtB67OUhnQ3wpsX4fV17wroVoYS?=
 =?us-ascii?Q?VJfXT+eL921DJ+bjH2k2kxokaPPcynWsn3jSCJ7+DzA+88ACDoJaP+fefMir?=
 =?us-ascii?Q?JEId4ajPACYT/HAZvGv7xOiAwkpZkSIgmmHg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:15.1150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff544391-7eb3-454f-e529-08ddaac4004a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 4fd9386d2efd6..913162d9930d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1152,13 +1152,21 @@ static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
 	jpeg_v4_0_3_core_stall_reset(ring);
 	jpeg_v4_0_3_start_jrbc(ring);
-	r = amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
+
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(guilty_fence);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
-- 
2.49.0

