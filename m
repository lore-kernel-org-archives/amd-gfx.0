Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86F4C36017
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 14:10:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 786EC10E1DA;
	Wed,  2 Apr 2025 14:10:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yRMo/Zvs";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5942910E1DA
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 14:10:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fs5ztcL7xTFw5dKRHfb9tNMd+6y9ByHE3r2NQ4pz/3SQRLFg7FLHfPSdGmzm4+PRw1P7oXeluYH2/7ZVim1Wy6n6TVqKoCSVdEMND2nABW70e3EosXJiGMHM9HM0Ku2FEtpemRQ7vUcuBH0Xm3QrOCCjz9zJ6PoO7fZidpUlNSF94pZcVsHZkaemRfYWLLLFWmcEmHnAbG8LhOo4pr8dS13JEfiaycgka2rMs8Zqd6kprCzfGG987NTqW6ilMYJ5a2BpcLN5dkkvttIXNqJiL1MWZZSNBVXXNFfwLhc+Yq3SNTrS/whldQsPbO0YuJpJ3Nq5tudBMfMcuczx3sYoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrE3j6bXFCtnoOhxsMuxvwmRO0DRfWVnaiH5qT853OA=;
 b=SXRCkRGoI16YxgRY1MhD+iJFDqk0hiNoyodKmNxqxpV/uKayyJUt+Ay6E+1x8a4sUnwGOm+meLA3qLDQMJHWv8kc2FfSp+IPdcZTa3mI25UJBR5iitCPeZdYWKs6OVIkpG0ERKAdfP+DdmBsruUxh66MJM+9OSWqGzs68habWY58nAe38jtob5j/lMY3JSIDVfggnKpsjiEGSrrZYQ5WgTeas+6XrmbnRmdzke+T6hsrtr21TTcnk8GKtS2fsZZVdB+y8qhfM8iDjqoTh8sPLA19TdIMuwyTT5mBVMJKsydxsNNaltuHA307S2HP0SAUg0rHqhNjEujqEQ8lEBWUKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrE3j6bXFCtnoOhxsMuxvwmRO0DRfWVnaiH5qT853OA=;
 b=yRMo/Zvs/uoXa92k7xCywQ48vhbHD8AOui7JARAujE4NLWPS3kpX/qWpPHekrLQziV9ZWx6OzBDy12fvjaMB/2gV6DKZd/KhZL4952ivzfVjxdXl3AKZH8lIIoLx5HbLAqGe0Oc3kQDumTRaoNuEM/OSg3tiTCcnCa7VNApIU+g=
Received: from SA1P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::30)
 by IA0PR12MB8646.namprd12.prod.outlook.com (2603:10b6:208:489::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 14:09:53 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:22c:cafe::5d) by SA1P222CA0028.outlook.office365.com
 (2603:10b6:806:22c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.41 via Frontend Transport; Wed,
 2 Apr 2025 14:09:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 14:09:52 +0000
Received: from asrock-1e715-b03-3.mkm.dcgpu (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Apr 2025 09:09:51 -0500
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Victor.Skvortsov@amd.com>, <Ahmad.Rehman@amd.com>, Ellen Pan
 <yunru.pan@amd.com>
Subject: [PATCH] drm/amdgpu: Enable amdgpu_ras_resume for gfx 9.5.0
Date: Wed, 2 Apr 2025 10:09:38 -0400
Message-ID: <20250402140938.7845-1-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|IA0PR12MB8646:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a582743-c0a3-41fa-df1e-08dd71f009b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HyP63RX0SpFhVQV9Iw3oevApFEVfUj13xvNEx9S8U4OgFa1NV7qwHLqo6gSc?=
 =?us-ascii?Q?0AH3aHSFL98fU8TZG2Xv/mC6Is0a1hWUjZfZw0cGCpy6zAWT/ypFNJVsk8Hw?=
 =?us-ascii?Q?WUSnQHe/LHQOKIdmBgGD2BNhpR8eHsQtAT/aQyAuq1QWIOMnjazMdfGgMKMQ?=
 =?us-ascii?Q?hYRbvnWqwr3vdq9agsLzqRf+XRs9q51W00ArVEbZrs6Mxy9TvvrBm21wgnfO?=
 =?us-ascii?Q?+pIoIiuGjW6wRWYiaDapFROFEkZu02/vJyMjUsB/OwjLv/hlzjKPu+DVn/O1?=
 =?us-ascii?Q?UZvG3JSvwZlJfI+JZhc9dP5wYIqituHkMRRTpH1dnqOgnosWSnwa5H6K1HMO?=
 =?us-ascii?Q?SHTb7WBDERp5t4QonjtnvtFU92myUrNp2Z5K5fYBpYsk+Tu29UtnsqAuHIN9?=
 =?us-ascii?Q?WaT+qiPQIQKnA43h7d9qNdX+mz8uMQ5y68aS4qtRt4UPA3DFMActZq/jW5P1?=
 =?us-ascii?Q?nTKMt9Tp2CR9VQywPx1JqMl02rWkj8SDSc7ba0nC9KbXoEN5jgAudehEhCeo?=
 =?us-ascii?Q?WkM0dO04dRcDrvacfnHxWOqPdW1/euJg3TUs2n0Su+VL+O9uQQMFDVBj9Tl3?=
 =?us-ascii?Q?h4fFwkKxhPy2RlQXORbWpfiKVKSrXGQQ1rh4S1y2kONEKHBfFrg75/O3T3xO?=
 =?us-ascii?Q?KS0aEfOYeEAZatooMMlFhRFahQH8NUSSup9lmQZ/60WM2Tvp9s8EICux6IJ8?=
 =?us-ascii?Q?6Bvxx1c36dGHJHMXyBkeF0pCCTYNC2pM4/rTzqJqZ+5qI1YRAG16qpAx0KK1?=
 =?us-ascii?Q?LEtkonFzWVcmvCLjdUnhvzlpfSuXx5CwQasyfE4uNzNUKY7r9iGD4Q/DTVrn?=
 =?us-ascii?Q?MbnbJwXwoktDoxxVIKfR3+67UcmUxAiXIfbL9ryHBJyvwzrdibHy0XLNq2SJ?=
 =?us-ascii?Q?DP1b4nRYRqNgbrGi7av5S/hJ3r6Lopc68QwXUvn7ld9IFTMEr+HX6XoYQ7sH?=
 =?us-ascii?Q?eqgkMo4Sz9Ze0TpycZI1+jOWx7fmX04gcQGoFjZrtQRcS+J1XnSfMd8WxyoG?=
 =?us-ascii?Q?oX+PFa4RT5kC+W3Bkr1LdrlaYvxUPqHo6nSLKv7V4+M8SCyvBbvDU6nLMV6p?=
 =?us-ascii?Q?7ssiU5QbKcOS9fhwqfP2XfSh6X4YLCeMRKcblxV+zL/lNwK3CflEO8Qr8gFa?=
 =?us-ascii?Q?ggnjSEQOdeFZIZU04549UsrHQUtACD/nKJO0TpPNvohvgUuXM9NUMAtNeAXp?=
 =?us-ascii?Q?Yw4AA2e2Ga7TRRqigkECKfqpdG/3y6hEjQtoJajvOgWUfZbTXJB9MABCYD+N?=
 =?us-ascii?Q?lqkwMHWO7QXz3qwy+Y/mqbERSZo0OnCfYbXRyU/t/1P0iRqxUs5wy/EWTIzo?=
 =?us-ascii?Q?9s0N1WoqtE+j8whKS7wm5ZbobY2kx9xT02Nh+FuPIwBAs1J20dkpNAb69ODQ?=
 =?us-ascii?Q?UiB3ICZzIJsb3XfMnkx2Gv1aMUeu8mr1z0PuQ6ExJaCmkhRwBkPvQb5LrP9T?=
 =?us-ascii?Q?W7/nM3+wD5STkutzwFroCH7G26i0ne0/Xl85M7gju856TMhyB6glNLTOTAKK?=
 =?us-ascii?Q?xTaiOFolSABs3zEN9S+3B07aynv2x1yNJGFC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 14:09:52.4595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a582743-c0a3-41fa-df1e-08dd71f009b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8646
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

This enables RAS to be resumed in SRIOV after gpu recovery on gfx_9_5_0.

Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 90c2bc473cb3..07799917b9a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5369,6 +5369,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 0, 3))
 		amdgpu_ras_resume(adev);
 
-- 
2.34.1

