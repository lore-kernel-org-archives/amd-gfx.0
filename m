Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EE7C3ABC0
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 15:27:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1A6E10E83D;
	Wed,  7 May 2025 15:27:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lqvVJS6I";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E6DD10E83D
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 15:27:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJF1F9ExfP4lbfzDkL/hUQFWv1A3UnvzW5XZgdOUh5re3MuK4KSoN2kn2KGAZi0iTeIYAt4fTnZeWIv26GKQ8M63GxEKuAhvvHAXef/qQzqa7plTkkME9V/W+iJ1zlyvfsNro89IZS+GHyGZTNas6avAm1VQc4pzV8Adg3mbkhrhPsrtbUIwhGLaBbx7Mu2KwduBJY4FlqqWy20MypqtQ1P92Jf7O1c9CqdHbqK3oJD8hILi9M7BvdpMWu6H8ocG0MVgstPMo6GMbyRO8vpZLnwG9LGfuNidQ9s3Drl57rCD66hg/rfST/e1Rz1kKJAMeeFee3bbdBDfX/BOOI3J4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74syTndZkzMFcscJpw26mD30o9Iu8Rho0BZm9PNN2X8=;
 b=LC1Yf9bSjO4Dd6auzlhJ7NMj3IKJjPZ+O3f8Y7VeuM0m1jqE0DGLGwTrrOp/hZGOraTlw1aAoXLARWBV4MQdLfuTxtRWJh5nS5GbS9S728zsxm3pe6elo0p3G4UErJXe+5OsaTnO5WPYF00C+UTGVfSn2bTsKYN8LMTt3ObLGSHWdCzD50xBlLZHD7XVBJa4ld/9RBihTs700irHdwWQeJ1EuSlSE9X3ynavN7PYOwIchshoueF0CrM9gtj/neAMhF2wYYoDxHZx8/KUQmTk4wdhER6408JFUMN7v02ccu7SXewdvzpXt/4khxXyzTkKq1Oo44hLj2olnC6VdPeeCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74syTndZkzMFcscJpw26mD30o9Iu8Rho0BZm9PNN2X8=;
 b=lqvVJS6IvCIMUEdQ+pp/7G5XyJTkKOrFyheEyRTH0QeWmtdgqgD8knEUL+BUA9xM1iXclgsSpnC/RpOF+04n5ZD4iMtIsBI9DN2p5RKk4m6LzWzrKo3z/We/NCYgpM2b/Dn3QAbJqf+IxW6FwKBk1+2/aBT2XJAuDRVMkEAz/d8=
Received: from PH7PR17CA0029.namprd17.prod.outlook.com (2603:10b6:510:323::23)
 by IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.35; Wed, 7 May
 2025 15:27:28 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::f8) by PH7PR17CA0029.outlook.office365.com
 (2603:10b6:510:323::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Wed,
 7 May 2025 15:27:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 15:27:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 May
 2025 10:27:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Alexey Klimov
 <alexey.klimov@linaro.org>
Subject: [PATCH 3/7] drm/amdgpu/hdp5: use memcfg register to post the write
 for HDP flush
Date: Wed, 7 May 2025 11:27:06 -0400
Message-ID: <20250507152710.234881-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507152710.234881-1-alexander.deucher@amd.com>
References: <20250507152710.234881-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|IA1PR12MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: a935f116-18cc-4d98-db40-08dd8d7bac6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9MIfNqs4XRYJVy0ymcEZYySMi+87cxffE6oA7T/WKEbcaVkvTla+86UfRv8B?=
 =?us-ascii?Q?4jb56OXsCjoPWdUUzc4h/vxyHFh5zwwhgl25PyLuUMh1d+mN9iCGfXISU8X/?=
 =?us-ascii?Q?km2FR7tE2BvqX3HjDO8Dd1jXZ/2q8YNWB3JC6cmowblyDpMytABNhQ2+0FvS?=
 =?us-ascii?Q?bGf+JqmC/Ta7GXXTIs1mvhJZxmKEagHjxYwC990hNsZFjz5vF5fjgxCJkY1X?=
 =?us-ascii?Q?7HetVKMXbqUXkT8vxnHqo9T2vYNYSFuQ0VX5igKJCKka8SfJx8vO0mPaqjLd?=
 =?us-ascii?Q?jcoQEGgG2k+J9ja3DZ8wM/+vaVHZFXWivGMS4VaggqYAfbttDTSBZUBsvSKS?=
 =?us-ascii?Q?fw0PZ6WPzle7qfFEwPCIR34TGpae+3BrSMUrpS7WKIi1kO5PkWHEaJAniS1m?=
 =?us-ascii?Q?s2W16Nd1XThI2CfifHcW5ksR85366D/gTiEaDjYU2JL6Jaos/ZGCNBkRM+gH?=
 =?us-ascii?Q?LUt2suxRNylep14YywONjQSTY+016sXCqA6F3MqD12deoCZdoUm5GoXs+u2b?=
 =?us-ascii?Q?h0oCrLlL5lzBlLGErzCJP8TsoCGj2nbriorb99SQEQu7ghREbdi2ABOxUYXW?=
 =?us-ascii?Q?MfR6ziiiNt/Viz4jQcL789xV3Nc7h5bzTrP9BpbvO11FbPFVPUgWDBi4r2AD?=
 =?us-ascii?Q?Vs4hOow3dsyo1pRAM7z3JqiFC60xdjmI8jsLU4mwVvMkoJTKlOlGDw43FeoN?=
 =?us-ascii?Q?bfMKtn9ZpLofcNqLEbIh/XpAvL8HiKv0JSSRITPJVDiZf80oMFS4l7oW9Bkq?=
 =?us-ascii?Q?J2/34y8Yjr8XwvGDSi8TxyBU4tHEH2J28BN+q/2v3TbmqkFfKTKSRSYkTvQE?=
 =?us-ascii?Q?mTgBCdi/8oZopzo4eYoISADFST2lS37aOAncQA1/ZdSmrdiC+7jkqY1qUZTj?=
 =?us-ascii?Q?v6Ry/V9VGywHBm1gQsDpBwpuHix7UjdPoBNVm+43eUapBUkLRx0DHPNsXKB7?=
 =?us-ascii?Q?vrbZCIiyHICgtaESQWkc+vuPfKx7txPbC1JQ4BrvnRTK1akGaV90iMRRGJyU?=
 =?us-ascii?Q?8L7HRDrReJpcpefxQj+I6B0aPi02Y0HYX/B579KPxuPgyES0Cs7r5PODwbyb?=
 =?us-ascii?Q?hsmx56YpuworI/RT1CiULtpPV8R4aSqZ8WIwZYebr663jc4syJ8Y2Cw3zTyN?=
 =?us-ascii?Q?/kiS+wU0zYguHo3WPVT3Uqn2DVqOQyPJOTlRY/Udcr8btxNRyfdt0POAHyjT?=
 =?us-ascii?Q?xoIh21jkXLOxvBuZEnBsXMZ1wZSTX734SGnNs+Qq56Py48Q30frarI5n3X6v?=
 =?us-ascii?Q?SwcLzyTEgd7iYomYm1hMtTMFpKIyuGB4WoWlLPM5RdSr3Wh75mlMKkzm+0rp?=
 =?us-ascii?Q?2nrbkQIzoYGIZO4IQdbDnrZvZT021g+2hIgXzP6OIYLvr+B/wLiJHGVjreI4?=
 =?us-ascii?Q?rcnaTTzERwVMFBwnZht5Oa4Z4yxoeeCaqBIQfTahHfOXqjvkyRTpoPvYW1Yz?=
 =?us-ascii?Q?fEu1ZFHFsWPwnoxaSr1ZQPQPGt+8/dRMvJU6oAlfVw3ONhh2xmuRiA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:27:26.9221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a935f116-18cc-4d98-db40-08dd8d7bac6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410
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

Reading back the remapped HDP flush register seems to cause
problems on some platforms. All we need is a read, so read back
the memcfg register.

Fixes: cf424020e040 ("drm/amdgpu/hdp5.0: do a posting read when flushing HDP")
Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
Link: https://lists.freedesktop.org/archives/amd-gfx/2025-April/123150.html
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4119
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3908
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
index 43195c0797480..086a647308df0 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
@@ -32,7 +32,12 @@ static void hdp_v5_0_flush_hdp(struct amdgpu_device *adev,
 {
 	if (!ring || !ring->funcs->emit_wreg) {
 		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+		/* We just need to read back a register to post the write.
+		 * Reading back the remapped register causes problems on
+		 * some platforms so just read back the memory size register.
+		 */
+		if (adev->nbio.funcs->get_memsize)
+			adev->nbio.funcs->get_memsize(adev);
 	} else {
 		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
 	}
-- 
2.49.0

