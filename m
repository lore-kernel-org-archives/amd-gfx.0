Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40617C3DA6F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E711D10E8DD;
	Thu, 18 Jul 2024 14:08:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PSlZQy16";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CBB310E8D4
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4XTfJv7dNaHkiUlGuq27hMw5eFcwEVvSTBdKt5HTz4TclvIO/Jk0kDeuSu9C5+8XqJfKREdFlWDGWlw8TA99crTqjWYj7i9Id51qPXT2pWaG8c+BT3tvmzdIaOQV4Cs5ysToEu6fY5GcJIDieFJJYn/4cqTytgEiYuIltoK9V6ifgTFwcrBzq9nLgA8h08phN1SO5MijIj4jnPSBhA9a1P/y/aQjruIJ0rSlTOSUpg6eSCg97301oTlRKS6MJDkKwthtWPY/w/fUWeoegKHcXFMX4hZUQ1NFHionrwhDVziGNDmGhRR72EgjND6wL5kw3QZYzD8e7Cx69gVb3vS0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lBsMJZrZO0O8mfQ/tZ3CefNkF6xL+0Km/0qrBq5jI4=;
 b=QBTOlry95ee8Oru3HJjO7101jm6VFEe3uGDpDeVVxEYkFnXkcQcF0yj+pbwEJgIkxDVj31PamQBzVdIWVsHe+hInIdKDz0eJq4W50NZS7Q4OS0tuLz02ElsBWjzZ7HSEdI0FNxBlpCGcZ62uIMP/i4WxidLb3lEa0Ucb4sJytlCRtMyJ/lqnWtSV9udDlzOI59nQOIO/RjahakCrjjhj+6VQgmA/ZlUNKeEdHKhxbo27nhgqT4/EVVRxKrFj9bp6pKaTdZL7yLmA+TAC/xa2l86gDlmhoPresl64jPw3EIw2gMQ6Ol+IUiFP9IOxr72fc5Ba0OSK1jfb01uDotenwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lBsMJZrZO0O8mfQ/tZ3CefNkF6xL+0Km/0qrBq5jI4=;
 b=PSlZQy16XIcte5lps1m7dGP/z4/vaNDQKmAf7Zc1YjN+Hrtxr3fE0eyPb0s1exTogwmSsBCe/ggAu22et1h38advTdOutk+VvBluC1H/tnDiToM+84Wf/WlGdYDXDN+rct89Z3hPcQXoXRMndXHFI18N1DdsK8lVaw1XIOCIfvU=
Received: from BL0PR02CA0014.namprd02.prod.outlook.com (2603:10b6:207:3c::27)
 by CH3PR12MB7715.namprd12.prod.outlook.com (2603:10b6:610:151::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Thu, 18 Jul
 2024 14:08:01 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:207:3c:cafe::7f) by BL0PR02CA0014.outlook.office365.com
 (2603:10b6:207:3c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Thu, 18 Jul 2024 14:08:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:08:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:07:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/34] drm/amdgpu/gfx11: wait for reset done before remap
Date: Thu, 18 Jul 2024 10:07:12 -0400
Message-ID: <20240718140733.1731004-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|CH3PR12MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: a8c7ef53-84da-4a11-e723-08dca733092b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q8fcP4AyeDwODSej/rDvAJHugrZ0Pn4u5hbqHbVdCX77r1NiJ88+AF2i3Hbh?=
 =?us-ascii?Q?15ShNMo1aZjkjVJcxN+e0OEFHsu0UbMPkso9E5A4G2K5cTESPm2Vo9C1vC86?=
 =?us-ascii?Q?w1uSx3nNO4oiGLPj0z75fvo6vxWxQ06LDGo3q5lz0Od2C9qNr875NrRhwkmA?=
 =?us-ascii?Q?06XWwOVDxUhBO2+KKo8JUt24lHyzs77ahg1KIPMcusE9s160huKyaJG/IlLw?=
 =?us-ascii?Q?IjWuN9eq3s94jmIpdeO40xHFin+jFcxTuib65B788zMe0Tk5XiqjeigUmUwJ?=
 =?us-ascii?Q?srGxrhd+8w/Qz0fzScZ7ovfVaALm2m/rL2UNgVqkPTGf6aF4I2gom4DkIyMd?=
 =?us-ascii?Q?epR+xh1RSPjqJJAMvKeO+M5EY7Lo3QFZLDEKKEyYuoZ7W4rfDvjOxRTa9ia5?=
 =?us-ascii?Q?9+1onPzQ+1aiHcskS5UKKD2wEuD11oluB5ldn2kUGI6wnIbrhrI4dxmr+y6j?=
 =?us-ascii?Q?6HrTrpCeGssVkdi2+7UA9e02qpZwbuIivQJcLuugcCMqb6V4cGBYjHjZlb7J?=
 =?us-ascii?Q?BBQQSyEeYo9vRbMZPXc4t8zysevdQAylIRsJQlIOCiTQeMlsQyAjNYnVv5kD?=
 =?us-ascii?Q?m3OUsuLc6E1ikwCaPpWHL/9Y0UHTAqGYgr2ElchL5QVBebQU8grNez16gUuo?=
 =?us-ascii?Q?sg84O/9+O8P8GXrfFlyXIy5FWsWq8/YqO12NOgaQPaa24fIHYYb6Qoc1YEy/?=
 =?us-ascii?Q?Hergg3VU05Qq3w5eHhCtRWvSucuH34wEulL+ErsGQ7jZ8nwuYu8eo/KYSSkR?=
 =?us-ascii?Q?HN58NGIRImwApoerHGDyCIM3OTa3vSVSBpqShEblw/5/emm7A68xk7k/b4ep?=
 =?us-ascii?Q?zZtcHe6gzwsaXC6aJInZGBY2spwo0vKutvhIKMcD9wfKQnvBmCShl0wsmZrR?=
 =?us-ascii?Q?TT93XKXvk7/QBb6wKNBmOQCGXAwrDSqHUAVZOJYufljb19YIRaRFEgTWMBwT?=
 =?us-ascii?Q?S5A6zm7PXWU5JUPup0oqWsTCizyyj2MMnj8Gwrqf/r5EsgUahw4Ue3ob7hlz?=
 =?us-ascii?Q?kAudW60jaNMlfWOg2t0UHvCL/e0JQzX+AKGh+T+s86ApfT0BUHbECohg8X76?=
 =?us-ascii?Q?91KFbwcRXXgT7xi4kq8K+d3FfzxAE+R13N7ezxjMEPhqUmrrZjv3Nfbv/sJA?=
 =?us-ascii?Q?tEU6di3dUbK7matrU52bE/BsgG8x1EUH34VKHoARD215kHevdfMhg+ZjDian?=
 =?us-ascii?Q?oAaNcQltsubbNKmePTYOgvvxbL0kChg/RM/6n/K/Iidu0ZWXR4tSEXruXM07?=
 =?us-ascii?Q?h4+kiFGbd8CHLm9UXE/pdq/kU0JtU1CHWNhvqVQIDv+dPXqYoO9M5avD+OwT?=
 =?us-ascii?Q?wDzsAiTh4zWls1/x39HkcJsKMfQm2NjdEOngepH89AJ9O8iFCA6U97yUbsQk?=
 =?us-ascii?Q?Ab492w7cWHTgCTcMSg3hkdYU9ITNSFtIkxY2Y9eaTgtX5IKVm5N0XJtl9zZP?=
 =?us-ascii?Q?IXF5urCwQFpq+VS7H4KUZ1aTIoNY7TBs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:01.8186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c7ef53-84da-4a11-e723-08dca733092b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7715
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

There is a racing condition that cp firmware modifies
MQD in reset sequence after driver updates it for
remapping. We have to wait till CP_HQD_ACTIVE becoming
false then remap the queue.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 9be58725c251..1b2de8e81ccd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6558,16 +6558,29 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int r;
+	int i, r = 0;
 
 	gfx_v11_0_set_safe_mode(adev, 0);
 	mutex_lock(&adev->srbm_mutex);
 	soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
 	WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0x2);
 	WREG32_SOC15(GC, 0, regSPI_COMPUTE_QUEUE_RESET, 0x1);
+
+	/* make sure dequeue is complete*/
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
+			break;
+		udelay(1);
+	}
+	if (i >= adev->usec_timeout)
+		r = -ETIMEDOUT;
 	soc21_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
 	gfx_v11_0_unset_safe_mode(adev, 0);
+	if (r) {
+		dev_err(adev->dev, "fail to wait on hqd deactive\n");
+		return r;
+	}
 
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
 	if (unlikely(r != 0)){
-- 
2.45.2

