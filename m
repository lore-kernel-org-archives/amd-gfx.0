Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E27EE77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 20:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C87C010E527;
	Fri, 10 Jan 2025 20:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KlBpsGZg";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76F6C10E526
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 20:12:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Er4A60+9i2GWEMhrc4f/ELuQsZGYaVrwOFQUGUJbqCKsGNQfEP7pkudOl2Z0BZFa9fTLSnC1MzJeEybT2WlFX12snDHmS2pqztEYfgjcGWw496pWO+o9H76jOYe1RCKuFsekIhZbIp/eansc8Vlk9V0oZVS5DrlTjU0gbyxc4XCEtH/hxDca1C0nAUCj05bhid7OmqfJ9wy2saXA66X4VJdvKrzfQVtV3NzmmqyUjqHdyciqPTUOtRUo8jOEuxqT2HzfLnA6x8oyMpv53qbrG35e025tRUlSYc9SorxK3AcY236fiLDdft8NWm8te/U79n1TexyhgQjyr7vUGnie5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8C05kYR8pjhEROx92tv00duBF2FTgP+0mF7/2Qsu0QU=;
 b=mr8mRLD/rcLCRhIDD9ak/UteYNXKfD+eZs/n1Ua8YKJxCE6//I0HN4AnU66erNidVQqYJrPdLpx2E9Q2NrK4wUORluPOBwis6w2Iwnj0PeATnyxo2OUvI7aCEX7AgqCjsBON68iYpm2ddO6BappCM6xyolqOTT71NcC4PEnufdeO8FeNsPRGaBCudNGHqJZW1uwZMeXXO16LbKGjyRKun6PRHdEwGPuVIyABqZpIzEQgHueErZ4tsNlWxbUcJ2PJWrZXODZ5pQELYF25LwuNlb2l35Dws0z2SpCoxyBn6ll+gEp6sSNtCsUhQNJPNrkJ3Wt6QALsMFRPKb4825GbqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8C05kYR8pjhEROx92tv00duBF2FTgP+0mF7/2Qsu0QU=;
 b=KlBpsGZg1LT6xQXB/q9/lZAmpK/vZo7bw7Iii/izNDqYpxsoEo3WpThEqk+84//iY8aGmgzg8YD11O5GYe9R1F12zV9CITfNee0ndXrnKoiFxXowzcU6a9v+vqFPD1XoTDS0dN1yKA88gQY0h6+fhKlpPRxD5yAT3j1HKLcFPMQ=
Received: from DS7PR03CA0120.namprd03.prod.outlook.com (2603:10b6:5:3b7::35)
 by SJ2PR12MB7943.namprd12.prod.outlook.com (2603:10b6:a03:4c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 20:12:40 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::99) by DS7PR03CA0120.outlook.office365.com
 (2603:10b6:5:3b7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.12 via Frontend Transport; Fri,
 10 Jan 2025 20:12:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 20:12:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 10 Jan
 2025 14:12:39 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: read harvest info from harvest table for
 gfx950
Date: Fri, 10 Jan 2025 15:12:18 -0500
Message-ID: <20250110201219.3826922-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|SJ2PR12MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f45fed5-cebd-4818-2f6b-08dd31b32263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AJLnYzxbVIH0amjpsaP+hAuyYeDuWLKlY8ejqTqdXNnzeq3vEiNhWwh4lEi5?=
 =?us-ascii?Q?Q54uLLrUGsY3JaZywY/whTLEoMANA7+zZpxGy/caYZ+JzvowzAep2SqX7dhG?=
 =?us-ascii?Q?gyYQrBPtesrSOrcdvYxQkBMcae+tZTjWlL/9cq9EJYCqe6vWT4TOs0sYNwA6?=
 =?us-ascii?Q?FpbGUMfGPhhB/ABtpxRNOjgNcpsobd72xCc3u+9IinOg0J5IMjY/2qFKhDds?=
 =?us-ascii?Q?bqCBL0q/ckfnJ6ZBb2S6EpMZF0eDgMN3p0/5yA5eyrhEJqyZEPGb/LEYKv57?=
 =?us-ascii?Q?kUdtPxLD9INAUmxXoQhpmzDsg4x+NjFAidrrMdJoL10prSkMaTxassQBiKox?=
 =?us-ascii?Q?oz4bOpW4hdHycIUn7ObGk3zn1UtpHR8kxQAtNjui+vqM9J2E6SkB8KEVf+OV?=
 =?us-ascii?Q?Sf6Q0/ljA6g/V2vH6qRdNm+JE2vSQR2b5kboVjjE2irTQPyNBkpxPLbiS+NV?=
 =?us-ascii?Q?nYohXjVkiFfMQGXPeOVoS0uFBUtynlIyCxDRDQUxkS1UnfmmfEbIaeygZlqs?=
 =?us-ascii?Q?4yZeLZiQyexbwg2yIoeHRNDpGIXbXZO3D+gpjQLvcp3+ACfZ9+2rY093Xycg?=
 =?us-ascii?Q?QwmRBNfIcjeXi7ivNvFXoI+kW3c5YfeSvPc6JEyocPfYY875CoW96q5lK7fY?=
 =?us-ascii?Q?4U4Vm4KnUQ9QC+qlwHDp1ZgERs8uIvFX3Pu2DsW58J0jJ9huUBuz9p6NZvER?=
 =?us-ascii?Q?uJWfGjr2ea1VO6jSKL0zClsHLfxTjQb5WafAi+3aRLNV2Yl6R3dfth2dzV4d?=
 =?us-ascii?Q?h235rtaMLqAjePIBAgsmLsdOU4bPKdFarHEIgBhOpPvq9d03PIEz36x79A1m?=
 =?us-ascii?Q?/Yh2C31hu8vhPl9fHpQ2JIDXZ2zvWPeyZRJhdCmT1upWvb3mxiyAfI477EKi?=
 =?us-ascii?Q?MiUMD/Pj1k/0TKXy6A+XUnBaJeW0fvbLVZAU0jJyLuLUUJAxAtL8iRdV67QH?=
 =?us-ascii?Q?5aIF5fKpFcCRZgQmj1y1iBE7BDFGTuJyNzy/2ZTETjPQ1pontFNbLVggqvva?=
 =?us-ascii?Q?ih4vmR7VF5wbCh96fP6b3rEmeG5OM9F1QMRy+J3TBO92cPel7/CglxQr+PMW?=
 =?us-ascii?Q?euXHt+apvv8LFaDLp06VMQDd37GUprVPZp619xf+MoiJTvM/TEjgUUzdbB/w?=
 =?us-ascii?Q?e7gPN7OQk5toVw+ilmmrkJvCTXc6yfqba+6LMk37tJLhd+5d2tsq4R/sU7M+?=
 =?us-ascii?Q?LMKaXIEpdrYqW2AIEyJdc2stJBUbSl2BRy6UjINmoQ0CnwgowMQKMXhWpUFq?=
 =?us-ascii?Q?v6FbN7gKCAt3zYngOpwBZNorv1zMMK5w+9EgpGO7hQR0P4lyUS+sy2qfOnXL?=
 =?us-ascii?Q?bm0DOMNqzRN+D3jBX6j6wCj8o9HkKmWrlZe8GmWk1avKlrBFpvQr/uIoRBHp?=
 =?us-ascii?Q?CWdX4f/ZueyZD6gILcgLU96a/59SWHn0FIBx8ioaz4c/vQkuCK0746cjd6JV?=
 =?us-ascii?Q?dIYMCXVd35itLCeie41R6hmP/Ss7ALAQ5WLcCVQZsF9ncUk9GLx52nYRgwQW?=
 =?us-ascii?Q?hzk+rl2Rhlr22Oo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 20:12:40.1217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f45fed5-cebd-4818-2f6b-08dd31b32263
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7943
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

From: Le Ma <le.ma@amd.com>

Harvest table is applied for gfx950.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 949d74eff2946..221c5e61fd332 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1470,7 +1470,8 @@ static void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 	 */
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(10, 2, 0) &&
 	    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 3) &&
-	    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 4)) {
+	    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 4) &&
+	    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 5, 0)) {
 		if ((adev->pdev->device == 0x731E &&
 			(adev->pdev->revision == 0xC6 ||
 			 adev->pdev->revision == 0xC7)) ||
-- 
2.47.1

