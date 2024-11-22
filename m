Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A7CE6917E
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2024 16:27:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4073310EC09;
	Fri, 22 Nov 2024 16:27:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eZ7aU7IO";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB0BE10EC09
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 16:27:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gX4cEODqiWH0XcHjEtnJugkLegEHfunacc+fiSyn1u26o4DMRDo6Cp8BVGo8QQYFB+sA/1mKJcVebcniGUOzbV89hPxqmtFlcm6cJnUCWSlMnm3Vi2FXD26sZxZ1kGdcH/xD/oF9yCJuclD6fEWBbZJ2Ut2OrT1LnVfsNEhP+7ZDlcUnsW1puBDsQGdl6r8mFlJkDsiBhVwLW2GRka/3YOrGeL5lVt6gCZdI7qxaG+QKeW6Pf4ntU5DTIR1h/zlM6laZnNI/7p1bg70uMSMmDkvf45/jGsA2aLMpGWXs1Gt8nuK6QAmUeQ3R0rVgIsUXUR5NPuHFUVHxdUhBaluAlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hq9bvqgYzkFf6hjbE2RdCIfsAhWxIZ0IUH4MrOV2lU=;
 b=hSSesNPDycvQ2eVeT0mcCs33GdoWPq0XM0KT/5iOXIkzjW5wlT4NVhD/LUPmPUAZtTDuda8Ks8HoljVs3ATtTMe6rIq7WqD8zoxHqzpapvyaX06wBvLEDyic8swaPVPv0snsGWtFvwD8cx6wdbRxt9PfFyvnWkIxNKfh9OnX00rhNcZDjVOtMj/A/Lp7E2WjKB9A/p1yEM0Uzso6LtIrrDF8RTnKeEx+PesQINnpFVGSvwHmt4PG47hEUuH9d+4Za5zsX0PSzIMAGE1fHNI4Y43E4BgLkibhWlFLGBjgjBrf6fJKFuZsqyEz8/7oERZe1EmI+RQR2cKfX8O3RIpyrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hq9bvqgYzkFf6hjbE2RdCIfsAhWxIZ0IUH4MrOV2lU=;
 b=eZ7aU7IOIVUl9P5R3BYs3bRCcMN04kNJrVlV0W63dCA5XgaZMZm+6uqjaYjLCCDPCZgHGEJMGQ/8kZ3jH40+BuxLeCl5YAP0Vi7bGG8psogKKrraytGa/OvBQ4eRsF8f725j32LSQkbcy/C5MKiLr/4b5+i1L+gT0K4Lf0cICSA=
Received: from BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::9)
 by MW4PR12MB6801.namprd12.prod.outlook.com (2603:10b6:303:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Fri, 22 Nov
 2024 16:27:18 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::99) by BY1P220CA0014.outlook.office365.com
 (2603:10b6:a03:59d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17 via Frontend
 Transport; Fri, 22 Nov 2024 16:27:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 16:27:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 10:27:16 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, David Belanger
 <david.belanger@amd.com>
Subject: [PATCH 2/5] drm/amdgpu/hdp5.0: do a posting read when flushing HDP
Date: Fri, 22 Nov 2024 11:26:54 -0500
Message-ID: <20241122162657.1056489-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122162657.1056489-1-alexander.deucher@amd.com>
References: <20241122162657.1056489-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|MW4PR12MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: 804f6092-1113-4f5f-c822-08dd0b12888c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eXcN0bGhrWEjQrXbEY2V1zwObTljfKS+y8DNEqihWolW4aNWMeb3dGcBSHqq?=
 =?us-ascii?Q?67St6PQvlvGJJvtRIhAuyHT3RwmiCcP34HYqeMyyLiYanDlfwGVeseT5HhiU?=
 =?us-ascii?Q?1DvOXhDUWonPSkzSSZobNXMyFlxBMF7Po+OymSTu5kB858N606+sSQlCAXvV?=
 =?us-ascii?Q?xN6iF0Dkm4wWUzHZ9ozMh6du6BgUEOfXqD21PMpRZ6N481HXNgOrvvceGAzZ?=
 =?us-ascii?Q?tUod9AjF171p2XDnd3fLoZamsbYlWu1SmgJBPCaLqsDDt1VSNNyLW+adhsfT?=
 =?us-ascii?Q?Y3rpsRWnTrxU6qu+9cxYl3cKM7oD/Q60GMVA+Wr+qGC43HV7ezqaLUc10Wcf?=
 =?us-ascii?Q?QRhcVEhQkpJ3OL6T82A5jh8Zfe9FhuNDRx1NQz3J05MjR3v8nmE/YpdKfA0z?=
 =?us-ascii?Q?i6jOHtXOgFPkB9+T/hODW7q9eW8MtH+JVFZQkZm7ZvCP7fU15QwSkTxOn540?=
 =?us-ascii?Q?IQA1mVjCYyJ0D//nj3tigLHFAmjhoa/HFAlxNejOw3j+NMyWtF2/Ox4AwlyY?=
 =?us-ascii?Q?Z7th9TEziXEyVt675bo1r+1+KHzQ94a5jaZG3vw5ILYU5Rpi25KqMYMDQN2r?=
 =?us-ascii?Q?Htx5VPfuC73TEhg3+iPIEfvGDmnnRy9kwOFbYJppwbOMPuPMktJbsBfL2+2V?=
 =?us-ascii?Q?XJTErIEPX7/NbI007U9mjBLFvvt7RIVDkvPRkKc3xrMztvcyDgKUdk1DI1jC?=
 =?us-ascii?Q?Hoi01u79iqcKlV00feXBzWNN61Nh1YkYFVn84BKE/ekrQovxPLUdvqp2s6u1?=
 =?us-ascii?Q?WYr5MaKt2GqefGUHj1zNildhAptqd3Ea4T3Lrp3jW/tVd+d7lCrClJh3HYlE?=
 =?us-ascii?Q?f8MhcWW25qZnGSGsMzrLWA0sZgVTrVhF4G01OGVnVonTPlhFvJeZgT6LMoMT?=
 =?us-ascii?Q?fnd87tEEs5zTk4Dvpv61bK0g0ouel0mdozNzlN+Kam/dAc727fJRt6elVqj5?=
 =?us-ascii?Q?lyjgFZk01lgIQQy0TLU9+ju3SXJGAahCtRhAnjt46qJ9CXy0XkDIkfZKejZz?=
 =?us-ascii?Q?i33HsoDUcLKyTLzhxWBl/Wn1SizRGuNeHpdtp5fWDH07ChCvEd2JXZ4HJLzz?=
 =?us-ascii?Q?PZLdfJuQhYL82pLQtJWkoSb3KBWMCCEH9qAgl37qM7E5hmm5+uBZITdYrWyL?=
 =?us-ascii?Q?iR1XkLnA0rCiNbyFIyUk3kxMIqxsFpiVYdpEA2RiHWGyxs7jEcLwVkH/Hd5f?=
 =?us-ascii?Q?I/7dxYbWdb59a8ZU+wBLDzgNRm7tNE/AZaoB40Klm+XWqwqbYmWt991JzHig?=
 =?us-ascii?Q?P6+Ml2LaONP3UD+eae1iWXl8HCP/gvhbBRRVuMnag6xKt/QEqg5CaXjunGvQ?=
 =?us-ascii?Q?uw8zGc3iXW2iv5gOJs1TwwL4dxZCjbPCE38w3P9U67h83Kee/Ed/QZFw6z6/?=
 =?us-ascii?Q?YSk3IkwnAk85wIJq3HfI/6JiaxVKuj/+9HfsT9LdzibUFoAV3Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 16:27:18.3160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 804f6092-1113-4f5f-c822-08dd0b12888c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6801
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

Need to read back to make sure the write goes through.

Cc: David Belanger <david.belanger@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
index ed7facacf2fe..d3962d469088 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
@@ -31,10 +31,12 @@
 static void hdp_v5_0_flush_hdp(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring)
 {
-	if (!ring || !ring->funcs->emit_wreg)
+	if (!ring || !ring->funcs->emit_wreg) {
 		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	else
+		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+	} else {
 		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+	}
 }
 
 static void hdp_v5_0_invalidate_hdp(struct amdgpu_device *adev,
@@ -42,6 +44,7 @@ static void hdp_v5_0_invalidate_hdp(struct amdgpu_device *adev,
 {
 	if (!ring || !ring->funcs->emit_wreg) {
 		WREG32_SOC15_NO_KIQ(HDP, 0, mmHDP_READ_CACHE_INVALIDATE, 1);
+		RREG32_SOC15_NO_KIQ(HDP, 0, mmHDP_READ_CACHE_INVALIDATE);
 	} else {
 		amdgpu_ring_emit_wreg(ring, SOC15_REG_OFFSET(
 					HDP, 0, mmHDP_READ_CACHE_INVALIDATE), 1);
-- 
2.47.0

