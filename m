Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95491C02194
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3910E10E387;
	Fri, 31 Jan 2025 16:25:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k7jQ15Uy";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2AF110E387
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:25:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtIs3j2GD5RHnelNk8RfXaBvHSqy+0CFnzQT6QjKQwKrYlk3HYg8CoDs1gQMln8DObmSedInBNTRwbYUZidByHipH/676Epu9S4OMSdCTMEUfKrfq2+46Zt3eFFPquLHY8K2ZCGFAadE0Hn02kxWyLpU5M7XXYJaslkoJmKcGESXPbsXOrkvaUxQFErMy3vsYJKLedTkRLUGKJULRilPGI8klKpfbvFQLI2XRxUY40I5R30RuX79h9ZOj1kAHNEIH8r/Y2xpnf8JdSuFZ9XzXTPPMVSqFySJayH1h/LFEIXDz2p4zuw3AQZP+vu5mKSL38xkViUq2IYvbYG5lqe0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBJ2Ftj5BM4ccUg4sdKi2GdEURSd5G3w7sh5P1Ls2TA=;
 b=HPLOLO7uszFKkjGvRjI0U46E5U7qk1LKu7wotSiJfddcgzLE/CcH/5ce10apilimKdmhg/uouV4Ox3EUuDicrgKUPARxPfe2xn3whWbYKbMRRImHjtKLtZqiCmkYSTTx5M7lXsfDVpMl6P2Qnfk4BLSDEa/QfRGG/N09w4S7h3oVrSDgd8OkRGsTkEDMEAFhLCTL9l/qa0hU2ZzM27bQV9oVI3YoMVP7/RKY7thD46Y/W8NR+4OTxKW5x0CMDOdGvcgqscRJGU3uWsfhSU8lCjp04TMar1Fr6jKd6jTGPREA3cpJC+A8zXB4Z8fUTc4CyUwbm4ztgHJP4V6DvT3P+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBJ2Ftj5BM4ccUg4sdKi2GdEURSd5G3w7sh5P1Ls2TA=;
 b=k7jQ15UyipU/X37mRHrW/dwCcQV4EO2k8vUGLLk5DRLRu8YJIxvy/tAI53IAQzvnAmmdMMkdad+g+P0DWs348mqwTdfbgODLY1Wj574XEC15bZPLQgacTfNAEmr/g+cAv1Fgs/qiS0Lxt9X8bYWkV4/GyDodIabf0R7lb2561ig=
Received: from PH8PR20CA0021.namprd20.prod.outlook.com (2603:10b6:510:23c::26)
 by MW4PR12MB6950.namprd12.prod.outlook.com (2603:10b6:303:207::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Fri, 31 Jan
 2025 16:25:16 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::5d) by PH8PR20CA0021.outlook.office365.com
 (2603:10b6:510:23c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Fri,
 31 Jan 2025 16:25:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:25:15 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 Jan 2025 10:25:13 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>, 
 Koenig Christian <Christian.Koenig@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 6/7] drm/amdgpu: Add ring reset callback for JPEG2_5_0
Date: Fri, 31 Jan 2025 21:53:20 +0530
Message-ID: <20250131162321.563314-7-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250131162321.563314-1-sathishkumar.sundararaju@amd.com>
References: <20250131162321.563314-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|MW4PR12MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e7d34e3-3680-4d5d-758b-08dd4213d86e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlVuUzlySHdkMWVGYTNUNjl4bWVPWDZMaUQ1R1Jna0s1QlZSRXNvbjdqZXEz?=
 =?utf-8?B?U3FhcUt3NlBYRWM5bHppU0ZTN3BVdmhZaXluUW9uN0FuR0ZmVmN5Z2pIMy8w?=
 =?utf-8?B?azRqQ1lKRldQc3ZVa2pNaGRQYUF5R3ZWc1BIYXBZb1lQNk5HaVVXVEYwRUNE?=
 =?utf-8?B?KzlsSmdEZTJleG4yU3p6YkNCRUd3bnd2QVdZMXRJdThvYUlsN3RYNEM5S3Bu?=
 =?utf-8?B?bTZkSmpLVmdIUkZ1b2pBdnF1QVc4eDAxRjZlVmVWdGVMZGJhVkpJVjJOajJp?=
 =?utf-8?B?U3AvaEM2VS9BaTVVV0NoQmYybUVlVVAvcDhsamQxN1crRzB6K0RZQWx0NU44?=
 =?utf-8?B?cTZpWGQzeDM1K1pXMFh2bE9oZVhPT3h6S0RqdVdmamFEL3EyZXlkQ2JIVVJS?=
 =?utf-8?B?ZDNBaXZLZlFtMmZoSlhsc1BXa0FnZGpiQ0ZXY0lpMzVQWFprYmtYNk9keHBG?=
 =?utf-8?B?OFY1d3c2WkJoQW5mQTNONk5ESnR0SHRjUHc4QUN1aWhLNk9GMnFqeVE0UzF4?=
 =?utf-8?B?Y2JvSHdreStCdFFJN2VtRU5YaGJjV1B0M2dSYmlmZjBvWGNQaHJGeHhTQW5k?=
 =?utf-8?B?TVJJeEgwbUF2aUw3RGNiUWtoR05GKzdLd0xOc210a3JVNFRTRWxlczVCRkdq?=
 =?utf-8?B?TXJsclVUMDMvRjVES2wvcmRLTm1OSXJrVHpSaG9KdWFCVG9LNVdxcDBSeVJx?=
 =?utf-8?B?eWVzR1FvTkpYN1Zta1lQMmROMnRMSURReU0wdlp0TW8rUmlOWmxjZnNXcHJC?=
 =?utf-8?B?WFdCYnNWQXcwd0JHMWdadkpTcnF6dzZLc1hwZys1NTFxS0VseGlzN2I5bjEr?=
 =?utf-8?B?Z2xVZ2hUdHZDempDVVJjUUVTUW9GV3ZYa01peXdEZTAwVjNsdGRxNnVQTjVR?=
 =?utf-8?B?eWVSQWtXY2QycSt2V1BYWkR2RCszR3M4OXlQR25YUGxCZjVZZ25ZM3hkWUZx?=
 =?utf-8?B?NWNob2Y5aEJrMVc3T0pXWUVyMGhQZi8xaS9yRnU2WWFReTFaNU9kUmh5UmRC?=
 =?utf-8?B?L2hSSTk0a2lCV1JSWnlFemQ4djA1MC8zeko4bTh3ck5qU3V1RXlmZDFLUUxm?=
 =?utf-8?B?QTJzTWN1SmNPWGxjRDVDSS9pSWZsMis2QlRuNnkxa0pDSW8wY24vaTcwS2Iw?=
 =?utf-8?B?VGZxM0o3SlJtWm5IaXpaZExpSFRUMkxuTDFoMTFFTTZWeHIrdUloVlBxN05y?=
 =?utf-8?B?RnE4aFFUL2NRZFFRQ1h0VURIekt1Smw0bFpldnk3WkQ4S212WjlOYVhzdERw?=
 =?utf-8?B?ZGZVMW5QMk5KbDIwUE9NUDJxWFdINGJsNGhLSGpBMHFRdTFXZDFoRFZmWkxW?=
 =?utf-8?B?azQ3RS9iRjY3UFpPYjdCKzNOeGxOdFBrcU05YWEwRDFXamEzMkp2L0JaVmll?=
 =?utf-8?B?UlcvZUxQNHV5T3kyS0VvVWhQOHFqWjh6RkhQRGFNYVJhdGhJcGQ0OEFJVmJZ?=
 =?utf-8?B?Rm9wbHNhSm81MnByUTFxQlBvZ09pVWI1ZDlBZjV4VGwwQTlCQ1dDd3JZaTl5?=
 =?utf-8?B?NURyN2MyM3JYcTd2bkZsbVErTjI3L1lZQlh0b3BoeDgvc1pJdlhTK1VvWHRO?=
 =?utf-8?B?a2ZuaVRpS1dHNlc3OXJ0M1dlWWF4Mm1tRDQwNVVBSGU0SzErUFNyWVZIanBx?=
 =?utf-8?B?dVpYdkVXalUzL2tmZUFObG4wc2VkNGNhMnZiYXJ6KzRRK1BMMDE5dGU4a1ZG?=
 =?utf-8?B?UTZTK29vaGxmS2FrQ3pZNXBEKzRqQVErNDJlWUd3SU81VW5wOXY3ZHdXWFMx?=
 =?utf-8?B?ZUtqSUNiSU5hZ2pJSzFXRXg0V1JtZGxPSUlKKy9mUnE3OWFpYjcrZWs1QWlj?=
 =?utf-8?B?Uk1RQWlELytPU0h4dkpzZnlZK3htaHlZM1FCVFJjUGhtZ0FIM2xNV3MvOTQv?=
 =?utf-8?B?T3JrT1JrNUI5K3pOcTZPWCtnaTJxSFpUSGx1bFBMNTloZEdDR2ptdHljWEJp?=
 =?utf-8?B?UzBod1R6QnBJZXNKeFhBbjRUaERmTXNtMTJlUVhOY3p1U2FBN1VTeldORWJ5?=
 =?utf-8?Q?NJpGab6hy2LhKa+3fXDgvVOayT6dDQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:25:15.7689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7d34e3-3680-4d5d-758b-08dd4213d86e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6950
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

Add ring reset function callback for JPEG2_5_0 to
recover from job timeouts without a full gpu reset.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 0490b672d8d3..a4157f10f91c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -167,6 +167,11 @@ static int jpeg_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_PIPE;
+	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -186,6 +191,8 @@ static int jpeg_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
+
 	r = amdgpu_jpeg_sw_fini(adev);
 
 	return r;
@@ -638,6 +645,20 @@ static int jpeg_v2_5_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int ret;
+
+	jpeg_v2_5_stop_inst(ring->adev, ring->me);
+	jpeg_v2_5_start_inst(ring->adev, ring->me);
+	ret = amdgpu_ring_test_helper(ring);
+	if (ret)
+		return ret;
+	dev_info(adev->dev, "Reset on %s succeeded\n", ring->sched.name);
+	return 0;
+}
+
 static const struct amd_ip_funcs jpeg_v2_5_ip_funcs = {
 	.name = "jpeg_v2_5",
 	.early_init = jpeg_v2_5_early_init,
@@ -700,6 +721,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v2_5_ring_reset,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v2_6_dec_ring_vm_funcs = {
@@ -730,6 +752,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_6_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v2_5_ring_reset,
 };
 
 static void jpeg_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

