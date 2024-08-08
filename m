Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94315C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 16:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 346C010E751;
	Thu,  8 Aug 2024 16:08:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t/ya4PoC";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB16E10E751
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 16:08:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXJnipHizIOcGhJykMuycMuO0ifp0g0Uzn/nrhVwlfOP3j7X/Q+p+P7gZZJy1VfSBzzST/F/kG3mSk6gBdDn9yXtKHhf2XgYKEX5WMOFYs/Y13b7dKQRDgrx98+EkLJj49EWBngMGIRvM34ZRiBYX5jOHGhBD9WVhXUQcHa8q9pg9NlGgHGxWbNUauQhfeTXUfoARK9+wC0iEbr1QS8zchVmfGJoI/+QWk2FULqscAet4m6QCmurksZ+8OsT+ivD+oyn1L6oo1Ob98CH+7ggLzVZ5v4XFTHTx9YsAQurga0gp21eR9zTSKUZpVhCRelFtLiDrPdv6RdEgLCD2ZXo8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKSZy29rlEK6B1pFKxDq/lgCo7NpGZnuZ2TrDJW42X8=;
 b=pTk273gX3Omhksw3b1NOBAtPwiv0G/btQpkI1On4mjP72Bt/D+ZPNmU1erIpcGXP76MHEdMv7XeUdVMFwHcqY9nlzY0eGWnga6D448rneR1gXIypwSZeFGYKoErLCb6ekw9BB18NSIWS+dXRhQVOzuvK28EXgcFbIPUO+NgX1D/jDp+EFM3E8vNRTctqbne54fOtWepIcLabLtqSJ1/7JQFhexgvKopbAkEiJivJIXaBVsbEi4hvL0rcSI9koxSOJI8oq13dkDQ+Xh1LQHFMKaWVke+zvrEFjU0GFRKSjlruOXHbe3YLNTZ/Uwr0k20+BcI08rKwVw6D2RjOO6Dklw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKSZy29rlEK6B1pFKxDq/lgCo7NpGZnuZ2TrDJW42X8=;
 b=t/ya4PoCayRLqKAKui1zEVXvZyhgONAVUbZMfCEDBznFCrFMGnAvXmcnVXEPf4WxSGJ1RYuEkrsPhT+0qJkACmwtZCIOEMw43eyV/3FFi1sYc2c9zqR2VX9J+8AL+ZtHCZYvk0vbBDzCTp7r4lYw8XVmfnYaqLRyVColRTkZ5Is=
Received: from CH0PR03CA0420.namprd03.prod.outlook.com (2603:10b6:610:11b::25)
 by DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.31; Thu, 8 Aug 2024 16:08:48 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::b3) by CH0PR03CA0420.outlook.office365.com
 (2603:10b6:610:11b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31 via Frontend
 Transport; Thu, 8 Aug 2024 16:08:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 16:08:48 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Aug
 2024 11:08:46 -0500
From: Jonathan Kim <Jonathan.Kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, <Felix.Kuehling@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: fix partition query when setting up recommended
 sdma engines
Date: Thu, 8 Aug 2024 12:08:39 -0400
Message-ID: <20240808160839.1886946-1-Jonathan.Kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|DM4PR12MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: 636757c1-3f55-4e63-a8a7-08dcb7c462fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s38OO4DWLZGIZoa/0cWzF4wUMxEM/9fg+innYq1NDA476rtnfuQ+AuTEyhP+?=
 =?us-ascii?Q?bsXxnPS/nrF0lboODudit3zj72Z4ArxKttbk6oLSdXIcCdCN7XFTWJDpgl2f?=
 =?us-ascii?Q?EWzMejbdt74oYEkPlMaN4dNaY+azZkG47LWhG1ggVp16CL8DHYtZWQ1GJmTS?=
 =?us-ascii?Q?NILTK0RSxyvskNbbox+LT22DlenEaTgy8LFkR5WQhsjL4E6E8CAlmuuhmhKf?=
 =?us-ascii?Q?GilvoOg/bIIDddxjajFCVUYcxo0Ql3adFp5zk1W82YQDv/XRg2vvyQOptpuD?=
 =?us-ascii?Q?MQtn8njQQboIfspS7ehxX3Q1Szmb9DKGyCp4iZzh3L2gFFNlc5q4U1gkSV/f?=
 =?us-ascii?Q?ecbduZwlT+X2ptV+X5+nk8p2QTA842R/a2ZNd0Nr9247iW6XoUU8yf0HdcAE?=
 =?us-ascii?Q?Bp1tMgKY5UOb2Hpdm1A3Xn/fu6cbhuuwpykMujn5MABTngF4fRGc7QzfSLNK?=
 =?us-ascii?Q?V35QdhK1zrOmI4EMc6dB4YP2vI6HpB6Bd/V3/HbddLGmY97/gEM7l8kJJ8UG?=
 =?us-ascii?Q?oF9EWe3+GfeWO3d7iOQ6F0+gKnFm3pe0NEKnTzsohAq3lxLPL/xIk5KmQHXz?=
 =?us-ascii?Q?bEXlmtxFWaVcd1V7YCJp6Y/yGLAB3qQKIqo/tjmFQMGlaes4Sxv8L2fqqdJI?=
 =?us-ascii?Q?GLfdJzsd5t4ImQyOdn0MnRBp9cGc2hIkNDQ2FBgNAjIJ88uJdL9q4VJrLR80?=
 =?us-ascii?Q?T6TLdzA7af7fM79og0x0iWr+ltl9/lqbm9kJ3t5NJOE04kNNsae6MpUuhn62?=
 =?us-ascii?Q?bfFIwS1W8tPQo6oun/xGORKNW6ubPq+G3TQVLMWp4D6ecaI7ADwrM/nZoXME?=
 =?us-ascii?Q?kuYdjxMXTKllzx8dymOZop8PaLTQGwZxrJU8ZXwUG+EJPLEMqpfY/IfVuC/V?=
 =?us-ascii?Q?s7ckIidTMBVTgsocEL+X3EBn4/dZAbF2ZCM034ZMfaMov2fFvga16U5ktHKe?=
 =?us-ascii?Q?QYPscGAvzAuAV2oalpT3xLQt487WGOB6MZryG6oSgS6EBTKrOqTuX6nk5+QU?=
 =?us-ascii?Q?hVeoaFJYjI9R5/4v08W/uQZD6JsImKSVbL5iE74HEyc/wGNknxZXHXMj3oyD?=
 =?us-ascii?Q?mrAx0ND38UX58naQU/e0N9Hshxe8YVlg40P45cL0casHz2HxEJ1EmssDsQx1?=
 =?us-ascii?Q?knMO1VqGpikq16eVGrYhWug8e/Kc8/a4yVA/JG979Gu1Mvs7j1ZdhA64w97x?=
 =?us-ascii?Q?Ld3ymCUrRnN02P9BghfLB4La9XTMb/DKM4kOstzd1aRk9uIN6Ede9n78QLHS?=
 =?us-ascii?Q?Q/cIw3hqSWRZKKQZXQr+Bbspma064TvzexPlDNs9e2od7TvhGMF7z+K3AXqX?=
 =?us-ascii?Q?GOvF62z4hEddxVvWD9XHjpjUX1gw+rOHUKhePr+FHU5wvvB8mQ/FoX+IM0AC?=
 =?us-ascii?Q?nO9foA3fUtFUr4dqFmzOMQO51EmKcjA4QUts8hirWpUBGaDaV6+Rn9BsKR6k?=
 =?us-ascii?Q?CrsfISysc72Aeru/TrfXwtHTaUSfklzS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 16:08:48.0741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 636757c1-3f55-4e63-a8a7-08dcb7c462fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5769
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

When users dynamically set the partition mode through sysfs writes,
this can lead to a double lock situation where the KFD is trying to take
the partition lock when updating the recommended SDMA engines.
Have the KFD reference its saved socket device number count instead.
Also ensure we have enough SDMA xGMI engines report the recommended
engines in the first place.

v2: fixups in description

Fixes: a0f548d7871e ("drm/amdkfd: allow users to target recommended SDMA engines")
Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 40771f8752cb..27d452e50ca9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1286,9 +1286,8 @@ static void kfd_set_recommended_sdma_engines(struct kfd_topology_device *to_dev,
 	struct amdgpu_device *adev = gpu->adev;
 	int num_xgmi_nodes = adev->gmc.xgmi.num_physical_nodes;
 	bool support_rec_eng = !amdgpu_sriov_vf(adev) && to_dev->gpu &&
-		adev->aid_mask && num_xgmi_nodes &&
-		(amdgpu_xcp_query_partition_mode(adev->xcp_mgr, AMDGPU_XCP_FL_NONE) ==
-		      AMDGPU_SPX_PARTITION_MODE) &&
+		adev->aid_mask && num_xgmi_nodes && gpu->kfd->num_nodes == 1 &&
+		kfd_get_num_xgmi_sdma_engines(gpu) >= 14 &&
 		(!(adev->flags & AMD_IS_APU) && num_xgmi_nodes == 8);
 
 	if (support_rec_eng) {
-- 
2.34.1

