Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D74E7717F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 22:09:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AB0410E306;
	Thu, 12 Dec 2024 22:09:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t2YPHsTf";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5899610E306
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 22:09:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHjMc53dPz8nUp9CyOkUOMr1JdiBUwk+8aatLGo3FzVP6M5pWI5wdqcKvPpvu1MXLDuMpUvgC6AAbK7IcYPKqc3Ufs7OB/Z2jzO3/wC6MO1DfIFqVxGqlBGn36z9MeFzB0h+ICEWNbMR7AYXTlco0fHryNgYfIbbR2nUJNVFQq5ZQiy6F+Wz42GJPolDJLxvVA2V9+JAQtiSrtrnQ3Kw8QBQoCV5IVf69tnfDA4FCMSBYNT1cnAi2yZ34WHv7pLADdPPt+HwmsNNRpEV0jhg3yUf+d9nJm/ja9vdCHqTVBSPvsfLFpy9ZLCTUoFB/vAIbPFUJbuQ0TtrsoGUbbhVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3wa28sOS8qeQeqsX8YXiky20aEbo4Iiq4mHSG9cxW4=;
 b=FH29ROnN5dY4zu/M1A3INMuDrue/9f3q8zZW7jq7cIW1Y/W4EyJ9escgmZ/bz++Wd2gkMwd/ruSNKho2n7gwB49hGeHslFu+CsR3h7yRwRFaxphl92bvl22TUrhMNx2c1Y0gDwndpH4irXo+gBePGcmxOJE5WXSvd7JWLL7kneyy6/jK4UnA0rpuJHxMaW+CAb9Qtp3WLIlhDNlzp60V3gvFoaqjBQywHbRB3s4W3aGf2UFG4NGpnYKlyfpDQxazJ4Oaq8LOYzXb419CypWawoSN1YExQgyGJy50lYT8b8jhw63cyzA9ZrHWYftxaaR3Qt1ustL794eKfQ7ez3L4kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3wa28sOS8qeQeqsX8YXiky20aEbo4Iiq4mHSG9cxW4=;
 b=t2YPHsTfz67QivlPLK56Gw5TD1c9SwWO29x1eJgoScJfBb9Y4MX2HkNDNP1DKAgPc6/dvWpydYp0/nnhp4O178DMH8yB2I5cJ6fxwy61pRWyY6jhxuATgMxlHl8GalkrJfRs6ohn+YKJr6BYXEK9GH1BJ35HOjRvhHLdTJ2GTGE=
Received: from BL1PR13CA0253.namprd13.prod.outlook.com (2603:10b6:208:2ba::18)
 by IA1PR12MB7687.namprd12.prod.outlook.com (2603:10b6:208:421::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 22:09:13 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::e6) by BL1PR13CA0253.outlook.office365.com
 (2603:10b6:208:2ba::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.9 via Frontend Transport; Thu,
 12 Dec 2024 22:09:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 22:09:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 16:09:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/6] drm/amdgpu/gfx12: fix IP version check
Date: Thu, 12 Dec 2024 17:08:54 -0500
Message-ID: <20241212220855.790502-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212220855.790502-1-alexander.deucher@amd.com>
References: <20241212220855.790502-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|IA1PR12MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff8eb3d-db3a-411d-3f0a-08dd1af99c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xBXJtmJpz0bwlIKcs2s1xo7hWlLFsWbxEe06xv32wv/KJfKjPfd6PnEgg7Di?=
 =?us-ascii?Q?d7HK7O4YjAxJ2rCrKcy30d86X1QiN/2cSTlhA5YbV+6b+hdZ3LzwMK1Jl8Dk?=
 =?us-ascii?Q?KtvM1mGa7LFc3HzNPwrIjdBpkaW6+5rTT3GlmufKVow8JEWU5s64frEF0sbR?=
 =?us-ascii?Q?LbIcJpzb1MyWrjGdZ8NmeBQ54kNHez1mvI9cOifocYxzWaDlO3C9c/TVljGl?=
 =?us-ascii?Q?MSrL7UVBOpI5VDoXrYcZObNT9p2ClEdJTj9tRljASxAfDj78lQJAR9joxMqm?=
 =?us-ascii?Q?iGX7uqiczd/9Yp2Dc0zPJX3fSwogpNdK76+4UHpu8fEitpncnyqAJ3kiDSR5?=
 =?us-ascii?Q?Xq+wkrincQJjEUTrZOFVWuM26R/h1T2vVhsIpJh02PqeogO1BQUe2Bar2mM/?=
 =?us-ascii?Q?WQsmq7psgTjazXIjjjL33fkCt6SyMD4AWLc62GWywf3wiNGlgGq46WAcpj3T?=
 =?us-ascii?Q?cmd8cqLCeW08m18YD55VX1eeStfZrKRIA5IXvRKtpT9splQshx9ZdyNULzGW?=
 =?us-ascii?Q?YcN9VCHX3sq0GevgaNvT5v8WDhPmsiSwedbHpDtZoFdruXYZE5o4jh+U9q9o?=
 =?us-ascii?Q?jKC0sCkmHpD76u8epcG1IMPUARgLQQSIgqxJ2wISosXharTSvu8icwiVO4Ks?=
 =?us-ascii?Q?YBe1cs7lYfAhQ2/V6CrJ21kZ3DdeQeMAkVNJAgsKW9GcTmSGOXV1PyebN9TW?=
 =?us-ascii?Q?Up5F3i660cpb5rdb1CU40OhyOlAwS1z4J5lzXXTlZwEvJWl4xG38O4slD03g?=
 =?us-ascii?Q?GBG4f1wYt5ZqAzErskSSYKcdllPvwB8Lu9Yl2dPdDT6zeqMXJaBbqvAeYeAM?=
 =?us-ascii?Q?V5/dRWvfF2fxV2Sataa8GSeDrzVrq/wk+vx7wsV68lng9HtadttMFCgYuy51?=
 =?us-ascii?Q?C1HwkqIyGaz4vpoz4OjO9jenXnTxy1xUnoYJDNzru9SLZN/DVWzh5SO8zCsL?=
 =?us-ascii?Q?nSWvQsKdREh14kdoJXxpht7G/vCXGYpn8PCiW0LKUT00jwX0PMbDxyx2GASu?=
 =?us-ascii?Q?Qe1zweI0prEYCettO1Jy4rKJBPRL49lEN3F538qBMK/KJZCVEljL/ZFqojFn?=
 =?us-ascii?Q?DyOaUmP/FSxOztLKsYK5+plPx1YQrsY9Yvz9z+bSKyobcPwo1a4brMLrTFSK?=
 =?us-ascii?Q?qzPoMuGOVHpppX9xpdn14S0nGcIwuANvoqY57eoudLeluwR0byzbQqQjfv7b?=
 =?us-ascii?Q?q6KfmpmY7mP+eYAVU3iNnmLHOOEkSUsnZjN12C/twEqirEF2Nl23jTJ+228U?=
 =?us-ascii?Q?81fhbBwH5bCWMjliAA6ELTKj21CBptW28+cR52yoBZzdQrufmeh9aGn5UXAu?=
 =?us-ascii?Q?0eyb9RY5LgdkeN0hS86PUet+z7jwToANUg986w/ntzV9uuvFVU4LE6lEKkWL?=
 =?us-ascii?Q?RFbpSJAd4PxQaTFbinO8Q/xJKISgejo5CQkYK9J2Szozzrh7Z/u4ti3jS3c/?=
 =?us-ascii?Q?+r3rkzwHMrkElJy36UwvG5ba8AyCiCmz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 22:09:13.1469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff8eb3d-db3a-411d-3f0a-08dd1af99c8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7687
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

Use the helper function rather than reading it directly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 035fc392526d3..fd23213df60e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4169,7 +4169,7 @@ static int gfx_v12_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	switch (adev->ip_versions[GC_HWIP][0]) {
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(12, 0, 0):
 	case IP_VERSION(12, 0, 1):
 		gfx_v12_0_update_gfx_clock_gating(adev,
-- 
2.47.1

