Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD79DD1CA3B
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 07:08:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82CDF10E526;
	Tue,  5 Nov 2024 07:08:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bpJtbmz8";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFC0910E526
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 07:08:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eq3rXl/e+d0/9Q/PsomhvFAJ6BJXPX/sdVJGcrWs16W39ZKls5LGdv7+5dkHntQMkgIgtR/r8Jt7TDkr3Wmqr5sJShR659np4+Fx6it1cWICf7QKpyipuaLRcwm3ed3bZJb7BPrUSoP2o1+rbvLPwV4f0F8jLrTnLkWr2kEPTizvn1L4wMy0pZRiaHlXhhnHSo9skq3JxnPfHtm23wUUZJ9NeJfLL/FPXJY2IrVJO2Txq3Luxef9PojO7InYcvOU/XLMjuRsIllLCfqA+Z+qw9Clc7brYmyu5x77zJNHDfR5q/GUiI91c6DXwpppWx0cxoSBzuHyExttZwHBkI266Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHklaQMAnAw/82C7wI9BmXvAIL6OG2ZoXH6PKgvTD4c=;
 b=csC88W1KHQ4DyY2NV7OogGGl0U/ZIkuuTm+uLzIaGMbY8D0ROO/yNJc0VyJohLE33h2Y/BB7FsqF7UrH/MqdLHdHuHZLLEk/bknAeyvNJfrVs5jaqnGReTaSflzK1YUfq3arPCkhUX0mgWev8ZGK+pqI2ASqz5PnwA6qZWTEFmzW/Kt3bXZKrhqKxk7a3SiM176gZT7+UsV0jvJt5NFpWhemiP2q1FTjzhtUOdzXFqG3glcYpJFuSvedJdCVwEAnoEa36H3f+OC247Yn+Rkb9mt+0hkWh6Dpjexl9sdfiNE6ybBmWatHJoA0462fospUJVGy6WWAgiHwiAqJZlqe9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHklaQMAnAw/82C7wI9BmXvAIL6OG2ZoXH6PKgvTD4c=;
 b=bpJtbmz8EK2CLg4siIHHxmu/+MfBtXYMnMC+r8oRsteD8USV+bUkOlbb6DmmylabVANMiosnbKTqCJunpakkIh1oWCGL8wnIn4L3CYsERJyQTIruPlYsr2PZIlnO6PgI8OMDnIudaxxRp25vhK4ePSbBPmuk3hNhhxelx1n40x4=
Received: from SA9PR13CA0162.namprd13.prod.outlook.com (2603:10b6:806:28::17)
 by PH7PR12MB9255.namprd12.prod.outlook.com (2603:10b6:510:30c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 07:08:50 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:28:cafe::8e) by SA9PR13CA0162.outlook.office365.com
 (2603:10b6:806:28::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.15 via Frontend
 Transport; Tue, 5 Nov 2024 07:08:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 07:08:49 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 01:08:47 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: Avoid kcq disable during reset
Date: Tue, 5 Nov 2024 12:38:29 +0530
Message-ID: <20241105070829.3243486-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241105070829.3243486-1-lijo.lazar@amd.com>
References: <20241105070829.3243486-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|PH7PR12MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e01f583-9945-4c9d-634b-08dcfd68b2cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?++k6xTcApUlLE6FNPwf+vvXkh0RW8kfQqacrz7D3U4kMb5OfI63KA7qr/SiW?=
 =?us-ascii?Q?R77asWvyN31+L70DWzf3J66Hr3/Je9meDJnddyV8NDE1D0cgvsNKLDtbHT/f?=
 =?us-ascii?Q?sSaujrZWoHH9djuaAxDvMhLkVWaV+/iO5V/chTOi9gS13h5z2DagUZeN1ZyV?=
 =?us-ascii?Q?yYAif0AdppLsYngSXo/FTWTeKItjCLp5DI8YvQYgEBhLx6kEwRGlRhyLhel0?=
 =?us-ascii?Q?pZK9+a771eU4onvnx/lVvEnXL6/39LjtbmeOdWlphrGfo4//MPh8wAXUwNE5?=
 =?us-ascii?Q?/eMgNoYFZmdq26vGLXqNdcCgdAXJfD4jvyf+eA78s48bzbirkSuERa8sgCWj?=
 =?us-ascii?Q?lG1DTq0V7pBtR8JvOHGb859+btJ3Dap/aueKOvrfaOb/v84eihUFsVTIVWts?=
 =?us-ascii?Q?cDLX5OiPMD5aYtOTL8sujAvaMM4yj7zCYAKqmHmYQR56myXi9l2jIPDeoefJ?=
 =?us-ascii?Q?P9jk+PtHfJC3gh15eK561XeuwgQNEAkX6mdiueXg1Q3tSlBOEqtdnD3vIHi3?=
 =?us-ascii?Q?DnLt4VN/IV+gqy/b0368ZdDYH8OZ4IJSMTiCGZEgKYJGNIdFTvQqwNSukupc?=
 =?us-ascii?Q?EDmN9T93u5ro5ANXw2EeVFqjFXQpj1/XJtvyHyVY6fLz/Eyanpn+yiNMTNiB?=
 =?us-ascii?Q?cOhkg/vrso7zzFH10GoCo050V0J8s8hWdPjggvUnGtgBAgX6acu0UnFeykDg?=
 =?us-ascii?Q?xhiJtLWEGhJYCIn8kBFrknLmhV3zdasFLsz1gL7gcw9KGGsWuOtP37ugEjVs?=
 =?us-ascii?Q?3u5a+zASDLNxUNPMlsO6VNzasq2MNHFgzsK5zERfyV/467DHOLQgoahOWsmm?=
 =?us-ascii?Q?+ES6/3/CgWg/XvZbRheeGQRipgaLK9d8Rb32gvJXJAKYwdurWSc99ynCFk+h?=
 =?us-ascii?Q?FEyB7lD0Nlxf1qdLYBvyu/IGnG2Xw9/V0UEh33uy/B0koOTbRIlPjZyHesli?=
 =?us-ascii?Q?ChY347LEiJi4/3EBmdtz3tBr9sdCyLe6iIMCynHd4WXMzMWaBuyy1PcfK5al?=
 =?us-ascii?Q?1XX0SuHyUAy4gocK+kMD1LswJh8JaMnEMq4D/Rv9kL6CFLJg+FkU0Q3W+pjt?=
 =?us-ascii?Q?jbYpNDIOJuTO6OBdEvS0OImfxoh5+eGPesvUF0xA9m0b9QaNJJ0nC9FvtkJd?=
 =?us-ascii?Q?UZJgBlv1CtAobj0TlBzDFMIboOooa2zvWxzZwUYTY1vRUjzW5WuN1jkie6wj?=
 =?us-ascii?Q?ITxlu8vOXezXwNDmttuIYOJ56NW9oRmNVewE8n6EGdiy459NUocPFXlg9Qy8?=
 =?us-ascii?Q?mc+WV0BfAkuCMwvzqFaKxzUQIImWoGQuF8IUqPRoJoGHbjJkDu6IJOStJFFk?=
 =?us-ascii?Q?VzzGbWTQIGBvRQ04KtgUgFkQjDSliciPGzSt6Nwk0CqGu03SLQd/0S4VXo+G?=
 =?us-ascii?Q?XQvxhgbyUneirGsQuGyrIzkxO4Bz+7Z1DRlgqRBn4g8KjbESwQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 07:08:49.7086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e01f583-9945-4c9d-634b-08dcfd68b2cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9255
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

Reset sequence indicates that hardware already ran into a bad state.
Avoid sending unmap queue request to reset KCQ. This will also cover RAS
error scenarios which need a reset to recover, hence remove the check.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 445220e9773e..d995a1801d2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -515,15 +515,7 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	if (!kiq_ring->sched.ready || adev->job_hang)
-		return 0;
-	/**
-	 * This is workaround: only skip kiq_ring test
-	 * during ras recovery in suspend stage for gfx9.4.3
-	 */
-	if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) &&
-	    amdgpu_ras_in_recovery(adev))
+	if (!kiq_ring->sched.ready || adev->job_hang || amdgpu_in_reset(adev))
 		return 0;
 
 	spin_lock(&kiq->ring_lock);
-- 
2.25.1

