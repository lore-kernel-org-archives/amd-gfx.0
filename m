Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC0CC8303F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA36E10E630;
	Tue,  1 Jul 2025 18:45:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UvNtIwuf";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BF1810E627
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jl71NXCK7eY1f1qjduFbxNAu4ye2z2d3XvH6FzG6mwifOvSy8Tqlu/QIzTfajQd1iHPgJVpmKmDzm7HH6VO7xMqyLMaNjbHauyq8tLENahHNlhNcfzST843YmJUVTMUp+8Be06TUiekDd7TSSuVoYo3yWYAcKGYx/Mk4EzgJOOm4q4Xz7rzalcpHOQ5wkNbJu4qnQNGZc6b7LqnTlohDEVfpQGxnJ4KvoXOaeCaFQG0SF8/Wi/zsTjoM6DWW9H/EaQVEe3vmpPnK1l19SuHrgKSikvQH8GV7ubLYFlx2xwc7svai+I2b2v6oblTe0BnjlgnuTeehrzP7u1D+fKDS1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1aE+n6vOIIcTyD0tJb3qdXNZ8hyo7zb6YRzBI5AR1A=;
 b=fWr1fJAMzPQnizC6oAq4octpvx31/VNEkIqe0oB+LbnOVRMy8iHyQp9uUhUazEG1iia3IpQnU1ZOVrpCT0N66nSFcGbuw7ffTT/71mMfngro31tnVWIldP/gnIGPUGWbE//LSix4V+PwFzLYeAexnS7o6kmok0s2blUsvLrJBpl9jrwD9kPv+72bgvG6otOJFPDi3CZ+vUNPxwLiFgFea12whhJUEZ8H0EjFaipS1moO0wgqQ6feC+gSPakE+oGap4hMmy8AGseoARGLfh9L6OL00SBbX2j3o/c+VXI5q+R79ecOeHusUb8EDoy5os5M3IeHRTVS7BtnOjJesc7sMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1aE+n6vOIIcTyD0tJb3qdXNZ8hyo7zb6YRzBI5AR1A=;
 b=UvNtIwuf0dxyEml78aK0yWAT/ytR1Ll4cpbIm2DVmwsYHaSMtZJPXvlcmuPZKkNAKlUoJ6hViXqnrK/8xyTyotEuWl0P77xtvlByZrBqSTU4urFvWC5/hNMNsZfd4KvS0jbnbHD3eCrwC9SYLhvEPjAkvidad48FX2CI59vOK1U=
Received: from SA0PR11CA0026.namprd11.prod.outlook.com (2603:10b6:806:d3::31)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Tue, 1 Jul
 2025 18:45:17 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::59) by SA0PR11CA0026.outlook.office365.com
 (2603:10b6:806:d3::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Tue,
 1 Jul 2025 18:45:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 19/28] drm/amdgpu/jpeg5: add queue reset
Date: Tue, 1 Jul 2025 14:44:42 -0400
Message-ID: <20250701184451.11868-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701184451.11868-1-alexander.deucher@amd.com>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 278fcc84-8e42-4b4d-4686-08ddb8cf6c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tYZAIGGPIYCtYYiFNlHESmdH1MqanFvzw87S6/sD4VoT7cW0Re+c33spD9JQ?=
 =?us-ascii?Q?QOG9Y9vceOjntOsg2i13kkyWOLizRN129yXo7oQLj/elvcP+vEqcLQ6AzKKq?=
 =?us-ascii?Q?w2+mypvzUhNMlBT93mF+F1SyFi8ueaaptKHmIWFZAIWGGy02/WNDSKBSEvtT?=
 =?us-ascii?Q?+eJtF6d4BXbs0iM5Bh/7+FOdzmBtVgxDDP2rwArIAYxUwd5YunjwwHu9gGXM?=
 =?us-ascii?Q?GsMfvrPXVpAff68GandLkmVYo93XCcq3jq2ZSCPlEi5Q2WhMZ7Rbfg+vP+1M?=
 =?us-ascii?Q?irYDmB/TnyPsGmYLGY2m2agxe13SnHG4pIjyRf7l51I+SozyIFOxqKQcj4LA?=
 =?us-ascii?Q?VQYJNE4sKY8fpeinMlCDthqOljbdyyeUPjWjU8Pk4WtckIIUb+yjiUT95Q0+?=
 =?us-ascii?Q?Jz+p2SGfo5q81AP+xfSTZWuNPoThTmKINL9gGq3yYxDiq0rvPXPXlw2/2gFA?=
 =?us-ascii?Q?qHW743vNfggguooHFRIDFBOjVOlf4zURddK3V0o2HKt0ggJ5iIJf+epuIwKX?=
 =?us-ascii?Q?foHWFt+vtJ5IKkak8MUbi8Iarlxh9mIyP5mHdh+on8H8V1bvDxanMteRMpkH?=
 =?us-ascii?Q?8YBBlfF6tWAXg2ksDqRtCFmD2JEGKL2I/gorzMWujYr8tXLbIRl72iSfE8GP?=
 =?us-ascii?Q?DJeE6+FaDkuvINv6B6MMaL15LzvYsjagBqEOlzYviroNAO4BWGRpqzp46X7u?=
 =?us-ascii?Q?RwdHUb8NQCc8s0XTdLFB7ufXYyu0lgcbGSJJ99lj8CDp8Eouue2CmuC2hYIm?=
 =?us-ascii?Q?QGAs3HUcF0KfpeFkSO2YnPLlC+RF6axNJQL8SRjWhCgdyzgOgufQLqn8XxwU?=
 =?us-ascii?Q?5mZAkE3jf3/sDhYYpZPB4A8X0ZRDC8fiSqk9ujUopBC0nkvTaKXogyGBvElN?=
 =?us-ascii?Q?KuO+7BohD8vMZh79DjwCPdRI19tUYCJbKLr1xStN8sAs6F+1tX08bRRH/yvw?=
 =?us-ascii?Q?iZ854I6pzm2GkuEE1ZItyUnLQHo29T8u2KoRibD/b3Yc5X7fRJAlg/i6gY1h?=
 =?us-ascii?Q?yfA9AKiNiy/ygq3yzGfIsjGokytXhg/Z5c8oTejc2cHRijfqYb2ti0xFkWrW?=
 =?us-ascii?Q?cxP4cu0Gwqjlhbrt2gCTWETgA5xGanh4fKlNB0MGBrXp8n+0TSulEa0txX8L?=
 =?us-ascii?Q?AK38jNxqt6Qtgs3Y9/AVN1cFPr60vHxnPtO4MbwQOig/eeylraVjEl+KDhIj?=
 =?us-ascii?Q?U9OQ7Ob+UqH7zlJEIfXgPW5wFbO3L8eT2/Za9UQbmnlbifbCmzR8x5hIs4YE?=
 =?us-ascii?Q?RxX7eXo1fNjZIrQcG+1JSItn2zJKhyXKgrDO8Qvk5YpIHyOYE23LiecDgyC+?=
 =?us-ascii?Q?6YvhA5EgmFHIr0uV3O7iXqv2lQGWvrvhZ2pmwher7Y33QCVJbEogHmeDUR/V?=
 =?us-ascii?Q?S/KoZkmfZyHvE/QE3vn5zTyo6hyuWgxQB6LRzQl/eksvmcPDOUYI7XONQX92?=
 =?us-ascii?Q?H8u0HUKKr1R8JWZjbtWRmBpg2O4eYcwl/i336RfbyIQ8bWrqhz6AHEJJdguD?=
 =?us-ascii?Q?j7UN74Brvk3DJR5oRg4qWMisSp64fywDC2xV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:17.4686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 278fcc84-8e42-4b4d-4686-08ddb8cf6c8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
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

Add queue reset support for jpeg 5.0.0.
Use the new helpers to re-emit the unprocessed state
after resetting the queue.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 31d213ccbe0a8..351e21494365d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -644,6 +644,19 @@ static int jpeg_v5_0_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v5_0_0_ring_reset(struct amdgpu_ring *ring,
+				  unsigned int vmid,
+				  struct amdgpu_fence *timedout_fence)
+{
+	if (amdgpu_sriov_vf(ring->adev))
+		return -EINVAL;
+
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+	jpeg_v5_0_0_stop(ring->adev);
+	jpeg_v5_0_0_start(ring->adev);
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+}
+
 static const struct amd_ip_funcs jpeg_v5_0_0_ip_funcs = {
 	.name = "jpeg_v5_0_0",
 	.early_init = jpeg_v5_0_0_early_init,
@@ -689,6 +702,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v5_0_0_ring_reset,
 };
 
 static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.50.0

