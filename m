Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6D3C25B7E
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 07:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE5CA10E0E2;
	Tue,  4 Jun 2024 07:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CGlblC99";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AC1710E0E2
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 07:08:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fs2ebMNAepIhlgddhnBBM/Ol0jGRgCTx39rFKp7x20VZjpXlk3heTXKKSbeOXjc4DvISfPuwFHcup/P7Mmy08YZ600yKE4nzsubqclq0w4wh8hd+qTBAt665nWQs6AuqK1kDNuxoYCcLq0wx6ZS5TGFvxoFHsMi81bT/rPumGL17skjED8PWs/kCpApo+R5E+6rq8qhQigI3KrtYudbdEzvw86BgBCZ6AQoyk9ZPE6sKzi9KMfywkgWQMus1pwAFulXXpN5kuEwwo5t0G87n92eOVLMJTEXdKpXGrvdG3WQ4DcgtGKnaapUUfIl0jwlnDCvTjkMgPv9csSvtwIfwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U65S2pAqIMyHOpxpkEQN1b1la72roxxOfUQd7ZUHV9M=;
 b=dyyJhiWhu6p0VFS2E8eOQvTqlJAXM7IW7O2V4cRBDsbsrwou7Q7pZ/0VWcyQ7ubtpxl9PtYA1i1MYAk/ILLr4vr/xAxpkcwBq8l3jwD7O5m60NJAn19QIYjbLgU5JKvqUvtjgglk4f355oOhuMWtYiDNZHZsyQK10T4vW1aeGvxPIHE9DbKiQQsHSzlg+htlU10RTTE1Vgb9nRE3LUzDX9h5sVY8F8YNtq7u7q6biDQaoR2/cuv+BMNzhfUPM/0lUccu0EcFSfYcpHHB0Bhqol0MHk74k8QFh5J38C7geGC0nUXizdApt3tTqa9V/u7jcSKepavJJXeyxW9ZOwox/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U65S2pAqIMyHOpxpkEQN1b1la72roxxOfUQd7ZUHV9M=;
 b=CGlblC99nG59Jsfhc9L8jp7MA5zBlXd97dpKUo7T8wlchSPbcsCl3ff5OWSw+WvwKfnNo08/Q6uGOf7NsdZNTRiaOfe+5Rgz1JtxJD7R+qEes2glq+p04ErXQ4nZEb2WxyEcI2USUEVVfdFdk0H+lOBJhhFTmzBtK1f91RB4B8E=
Received: from BN8PR07CA0003.namprd07.prod.outlook.com (2603:10b6:408:ac::16)
 by PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 07:08:38 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:ac:cafe::91) by BN8PR07CA0003.outlook.office365.com
 (2603:10b6:408:ac::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.29 via Frontend
 Transport; Tue, 4 Jun 2024 07:08:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 4 Jun 2024 07:08:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 02:08:37 -0500
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 4 Jun 2024 02:08:35 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Tim.Huang@amd.com>,
 <jesse.zhang@amd.com>, <christian.koenig@amd.com>
CC: <alexander.deucher@amd.com>, Bob Zhou <bob.zhou@amd.com>
Subject: [PATCH v2] drm/amdgpu: fix the overflowed constant warning for
 RREG32_SOC15()
Date: Tue, 4 Jun 2024 15:08:29 +0800
Message-ID: <20240604070829.8872-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: bob.zhou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: a308d6fc-2b52-4cf2-a19b-08dc8465285a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?otKHNLDYjXIrtx2KfQUzjDUg8c1aJM4KFkOHJIB4QHz5pijd8a2JAOy4+Tf9?=
 =?us-ascii?Q?wViot8rcSOkHQ3UNAvW3VkGKXMpB+8WmSP7xeBqrgmn234WelQCywu6F6EP1?=
 =?us-ascii?Q?BaqBI0wvIV5egFeAWD2hh2smEfqsU3plD33DAWnIEynR4qo390x0GifVCni2?=
 =?us-ascii?Q?0qaduDwYn55i7umy2vzxjo985ysUzi7WCega1IN0gg7TB3LO1fciwY9dgYTU?=
 =?us-ascii?Q?M+WaDLdZQLnzS1p5i/b2BQLOs60MATuK5bKz4vJGLYQU/XnoXAFIisEyEVKz?=
 =?us-ascii?Q?ybr+G5MZCsPC3LbJucTg3p1vPdzoUMMBixaoEQr0/Ce+Kh+o4frc5VaO7kSA?=
 =?us-ascii?Q?JlSHtupWFz+c5yvep3KMIPS98HlB2dRdiXJnOk7CU4qhSROZRGe0qr5JrLFU?=
 =?us-ascii?Q?nzSe6IfG1lb1fAFgmRpNK7lrk3VJ3qmwq1Tm0xlnNDQ7pTp9qhbbJuosN5x2?=
 =?us-ascii?Q?znQzN5DmN86/ndEHl6T15oAyyexAu1ArffcWYkAR7d9RM3y8FYqzjfLqt5mI?=
 =?us-ascii?Q?O2dWHG2nn2WftOqle4TE6rqohrxjZURzyWmSzzqBjKsI21krq/sBX2EtX6aQ?=
 =?us-ascii?Q?du9znjpnJ1u+qhbIbna9xXmzliGv5dldAKRzl9/AF8Nh074ZnX/6nrLo7g5S?=
 =?us-ascii?Q?9FoQn4e5K3Xckarbk7icgzyXqujn2OhYue2YCOeSSXnbh29NMgmurJ8WEyXH?=
 =?us-ascii?Q?MzF2AUpXwxXYLI9VUdbmoG5MoSSbmjH1HPFWU5seVtp8TyQADen7mRRxVC0P?=
 =?us-ascii?Q?6k5CRx9jA9O2/bz3oqfs+dKN8iVjuwUmqSqmlbq8Z/UNgXPbJLh9EyZCUrUR?=
 =?us-ascii?Q?aGHzEPM3C8dC9yoVjgXupJYR7hDH8k5D7tJBTq5kAH7+na3NirwXNXH2qi9F?=
 =?us-ascii?Q?SR6luqeRaVGvHqNqGf083Zp/15KRPRjji/6w272/YZxfFPWEdQMQt3OQJSKn?=
 =?us-ascii?Q?Roau3dPgLjTKk1Kgk8hPadLjt7FYkCyIxUmS8pnHug+uzsqpkCkW/wyfWTsl?=
 =?us-ascii?Q?pCY5RDjxaNJIFd/G9wrrEEtOrLaj4YaEGcZeqh+CuLlKZEp9mtZLr4LdhC6f?=
 =?us-ascii?Q?hwNWgwsQPPGIlVr9EVNQfvVvTvRnR6qi8K2MkuJZW6CkYUK2P963uOlnuGzw?=
 =?us-ascii?Q?SJWbL+saX9p+Dm4T1bSR30SQddVxFRwmUrJjgKBJI1jfBitGCQUEuvmqzLVl?=
 =?us-ascii?Q?h45VDN1fGCy9qHOqIUHVqS/PNem0xfXu5VphzXkdb7h86WnE4ux8x8N14v0O?=
 =?us-ascii?Q?adGuVWAOu6b9+hgAQmWiFfghk8Bs8hfYSq3pbuuSzVssVlB2d2Ms3HptY52+?=
 =?us-ascii?Q?FBflgNnszBo4OTzqz5LjQ0vZf3eVLSBGi0GMGSW0lObwFXM90OPtS2A7s+KP?=
 =?us-ascii?Q?gPFHFfNOT98ShDjEMYANIeBXSdGx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 07:08:38.2890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a308d6fc-2b52-4cf2-a19b-08dc8465285a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699
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

To fix potential overflowed constant warning reported by Coverity,
modify the variables to uint32_t.

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/imu_v12_0.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
index 0c8ef908d112..74999f29d0a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
@@ -119,7 +119,8 @@ static int imu_v12_0_load_microcode(struct amdgpu_device *adev)
 
 static int imu_v12_0_wait_for_reset_status(struct amdgpu_device *adev)
 {
-	int i, imu_reg_val = 0;
+	uint32_t imu_reg_val = 0;
+	int i;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_GFX_RESET_CTRL);
@@ -138,7 +139,7 @@ static int imu_v12_0_wait_for_reset_status(struct amdgpu_device *adev)
 
 static void imu_v12_0_setup(struct amdgpu_device *adev)
 {
-	int imu_reg_val;
+	uint32_t imu_reg_val;
 
 	WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_ACCESS_CTRL0, 0xffffff);
 	WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_ACCESS_CTRL1, 0xffff);
@@ -157,7 +158,7 @@ static void imu_v12_0_setup(struct amdgpu_device *adev)
 
 static int imu_v12_0_start(struct amdgpu_device *adev)
 {
-	int imu_reg_val;
+	uint32_t imu_reg_val;
 
 	imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_CORE_CTRL);
 	imu_reg_val &= 0xfffffffe;
-- 
2.34.1

