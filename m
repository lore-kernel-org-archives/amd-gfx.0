Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D720CCF2DA
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 08:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BF8310E880;
	Mon, 19 Oct 2026 08:34:37 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013054.outbound.protection.outlook.com
 [40.93.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EA3910E87F
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 08:34:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9+yfg3AnA6Xs19fJlSX6esayUpkX/9pp1yYbiZboTpDz4XnTU6aLyB2Py/KL+p98v4q6zwPHkOwyWmW2LW0EBdlEJfrpdTQq244wWZgGVmr0t7Cn3ZyPP4YnbiyOCmICj1oaWt7+HClLcAo1IC5CHAcC761ty0zYBu4M6eoNg2qmyFdJ5xKRguoR2nPUHNlL+wBrWyCb/ekOUd/0Xzsw0CVgDjJJoyjeW4JsONR+zcd8QUKrGmK8FvE5qXbF1v1UNA+DHbQcYVWgHRVR1N2iRJbhNBtt9SPJvPk3XGBUV5NvY8q6OQy+la1IWJ0SP0J2HC0k7xSg9lurWrJFNtlow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59P4kqTjstiM+bhpmL3Qpg/SQa356JZaGeGhkPkK3nE=;
 b=yfr7fsXB56JJzH7hp/v/G4wQDsSMLM6SDvEfIpfhXn1jOmStsQT7fLogi12cclABhlJZiLUZx04HsG5aRNhZCHqqsZNemKqm4+RJn/l0rd7zO9DZgB6WtmCHXO1Y4/LCK5sWpFiRMGdXqrsDajRVgZZJ+JByrNPIyG5i7mA5tKFCpnHkNLOs4qmZDiMGChG36zD3GURaHWUT0v01oE58LYgQs8h+B1Xflh9feMrL7UHvraCmYn8mj+AUjqbTkVkouCBZDYu1EGnrNJ9ZmQDcO2sjrcL/mAfy7HwV28V34MDq3dpcXC5rCrZCO68yA9apU9IGb+i9lVc/UoLedrFdwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59P4kqTjstiM+bhpmL3Qpg/SQa356JZaGeGhkPkK3nE=;
 b=vrgwDt32xySmMUBVhg351Tu3W9UDoBrcsO5MkST7q0AKYh2LPX5GWcS+rBYiHiEq4pjBS9OKWqFgWMMAZ/55w4fvteJF4Z6e3W5m6201mCKZFwV8i7SBIqdA0u5+L8ZbirdKeHYfnaOvCXXSgM0m1wJISg5IyYqJPWfXfm4NLXg=
Received: from MW4PR03CA0097.namprd03.prod.outlook.com (2603:10b6:303:b7::12)
 by SA1PR12MB6945.namprd12.prod.outlook.com (2603:10b6:806:24c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 08:34:24 +0000
Received: from MW2PEPF0001467A.namprd04.prod.outlook.com
 (2603:10b6:303:b7:cafe::a0) by MW4PR03CA0097.outlook.office365.com
 (2603:10b6:303:b7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 08:34:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW2PEPF0001467A.mail.protection.outlook.com (10.167.249.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 08:34:23 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 03:34:09 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 03:34:09 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 03:34:08 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 08/13] drm/amdgpu/gfx: reset the gfx engine when a kernel gfx
 queue reset fails
Date: Mon, 19 Oct 2026 16:33:08 +0800
Message-ID: <20261019083402.2033724-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261019083402.2033724-1-Jesse.Zhang@amd.com>
References: <20261019083402.2033724-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF0001467A:EE_|SA1PR12MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a19b0ab-b8dc-4edd-00ae-08df2dbbc790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iHwYD7eEoqh8U8keKoB+1s2/9GQBz6Xn9fasQtLyu09iLG6ac2IHeDnqAhc0dGPXxmw59jcbpVbur9vf/7l0tn+WEH01QqAtQEdkhvhTo7A/P7sNgNCuj7+sFVDXKoyWFip4eN785wty/i07QBKH75z+x0TVKHeRw3KA6ZQd5tDu6oCsOohO57JzYUResVSzPFQTBQ8WCrss7bke5c9Bj5sq7z9Dn1c2+UrG/if8iwl6AC/89t/iPNe3Jpcsnz5qXTMP+szmORjKHUnFKmaSECLekIfxJ8pjNPGL4FXO39bAY07BZYs3OXEHT0h19qPBpKLBce2eq1r3dd3IjTw8iRpc6MDl46farLb05ORwTjIJXoV9XkEoCgyzcfHPZs0uAoc9k4ewMZ/AwVR1Eab1DA+BYAMOD3eHNdgzkPLLy2EnL36DXf5a2PnmHJcQis2oEei0Ek2xI4pCctfEdU3IC52AC8oDxwkOLNgoah3z1EEQkii4EV6YbJs7v/dB0i5u87x4xg6SrcAs8sJOl5qvQVCxrD6xdtmTuLz3RnfMJ9NQ2oZ3smpAJRtOR4j7kOA3qEYTGMpVnIeOQF+sHPM+ZcaTev6m9Jo4xySpbUB+46fa/scbodEZv1MrKrnxEUKw7o9tAdTW9CgmxYJr6VJDtW7s7JDNngie57v4Q/seemppaw20yk4+m+mH9k0JDEy6Gfh8VmzFj5yv8KaPqZj1Og==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OLOcs79fs+8nl7aH8aNwNaMgfKGw4QQxLMVWDa2jtadfRUIurw+i2ZLfKkVDLBkwMtuyO6+edwoUK4mkgrGjUmD2RmDiu6AYSOcuhq9qmt5TD92bBKynObRgJIiLbKY6hct7pMPHkbWyhlfX4TDAJEc/Kp0cvL/SbVe477my3ZWdQWJex8cj46zM03ZQ9/Gz9484NRp67PqU3HCVLeSNanFYPQHVhPI8p034jcKM89b9PcTI/hxTMIMaTHdCkwBL6AHyQkRB3TUuP0sRxzmIiDYYJKdwwGhVM1wEQWlKlfEb2mmDFGuZiMuMM+TPSWOYEm9OBuzPnQ/olJ5Ppe+aajkGERG66yCtt0FH+XLztpM/VwYF2UZ6PVPo5Us234DLvhX104gfSrGE9+WcOkjOhrgldOyiNcL9c0fcz/8IxkOnskrVVXuQW2JOuLhc7ClU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 08:34:23.9307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a19b0ab-b8dc-4edd-00ae-08df2dbbc790
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2PEPF0001467A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6945
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

When neither the queue nor the pipe reset recovered a kernel gfx queue,
amdgpu_gfx_mes_reset_queue() now falls back to a gfx engine reset, if
the IP supports it. The pipe reset already escalates there, so the job
timeout handler doesn't change.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 5a1774491bda..c512e1e6ec86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2295,13 +2295,18 @@ int amdgpu_gfx_mes_reset_queue(struct amdgpu_ring *ring,
 	if (!amdgpu_gfx_me_pipe_reset_supported(adev)) {
 		r = amdgpu_gfx_mes_reset_queue_start(ring, vmid, timedout_fence,
 						     use_mmio);
-		if (r)
-			return r;
-		return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+		if (!r)
+			r = amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	} else {
+		r = amdgpu_gfx_reset_mes_gfx(adev, ring, timedout_fence, NULL,
+					     vmid, use_mmio);
 	}
 
-	return amdgpu_gfx_reset_mes_gfx(adev, ring, timedout_fence, NULL, vmid,
-				      use_mmio);
+	/* Neither the queue nor the pipe reset recovered it: try the engine. */
+	if (r && ring->funcs->type == AMDGPU_RING_TYPE_GFX &&
+	    adev->gfx.funcs->reset_engine)
+		r = amdgpu_gfx_reset_gfx_engine(adev, ring, timedout_fence);
+	return r;
 }
 
 static DEVICE_ATTR(run_cleaner_shader, 0200,
-- 
2.50.1

