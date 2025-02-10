Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F46C0219D
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 14:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11D5310E569;
	Mon, 10 Feb 2025 14:26:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vuHVFk2j";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E17B010E563
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 14:26:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Duu3uVCb5r1RWKZNQCzKJzj2md3hU8BIad6hDCttkD5HJFJpFqJNxU4Re1fs6Ba+radujrkjKcF+OYJ3/XzPdE/l4ljoy8foT51/zEJL00QRMiJlE13fPt4QlddrkE6lKFLrHUHncb6xB0YivpxqzdyVjiqf+DBS+9S4zz039McdeTq1Kk2jWbeJYMyF5kJiBZZQcgSwiWOT3fVMAWLZTCHS97iOlTKWnVMCIyWdIPWN2zpOn2fShbvX6jnIUC4GsBT+8yBFaqOJhTg9vYOiJ6eMsTM+QIvbKoNqM1/uRplxJfEiQYKzcTUuMjT208NmGAvM7iCaa2UhCRMbNR1PXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jDaRtsWUh3HJnPkuRQe/icDdojIIIfE8/A6+/gNSs4=;
 b=sxhOATTxrx5X3p9aWGNXLWGju5DkuCs26n31fALIUkpxIpzDITMahPbqT7HS9I4r21CveMdCwpB3s2F7W3ROMiGBZivrFs41TXm36N1sHS9yyH7teNyQOVhJugYhXj7e4CirVyT5R7nUam3FDzKQt9fl1uEkUNL8+IszQmcg5mGZukTiaJYkHKYK157GAtPz+Ou1W62DDIBBsxdpsLscFoJVTspDMr3J+US1BIOmk/PuYS49twH9ClCWkDayMaDY5qD+dOTzEXESF1RVdvtdDO3ywZbkdeHeRxofoqBPeXtLFfrIZEVTZp+/oUbz3QaoUUwDjJef3RO4iVAp1RdxUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jDaRtsWUh3HJnPkuRQe/icDdojIIIfE8/A6+/gNSs4=;
 b=vuHVFk2j1cUsgw41p2zOCD3QikAG2rhjlYEZ8YCdLxagaxXi5Ob89OsAfLTy/9nfHjMnSiEox0mFZOT7GaDJJAMWLB45/+UrtOcbRx5mGUgLxKUKhZMQgF38WjsoIZbcOU9dRiXktpanzMRW3I3L3vvEUs5EHxgPeKwjT3xB3XE=
Received: from SJ0PR05CA0181.namprd05.prod.outlook.com (2603:10b6:a03:330::6)
 by SJ2PR12MB9192.namprd12.prod.outlook.com (2603:10b6:a03:55d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 14:26:52 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::b3) by SJ0PR05CA0181.outlook.office365.com
 (2603:10b6:a03:330::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.9 via Frontend Transport; Mon,
 10 Feb 2025 14:26:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 14:26:51 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Feb 2025 08:26:49 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>, 
 Koenig Christian <Christian.Koenig@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v2 3/7] drm/amdgpu: Add ring reset callback for JPEG4_0_0
Date: Mon, 10 Feb 2025 19:55:44 +0530
Message-ID: <20250210142548.2321625-4-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250210142548.2321625-1-sathishkumar.sundararaju@amd.com>
References: <20250210142548.2321625-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|SJ2PR12MB9192:EE_
X-MS-Office365-Filtering-Correlation-Id: 66332ba9-ab09-442e-9243-08dd49def62e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFM0VHlhdkNiT2ZYS1p2TzRLM0M1Y2N6MkY4RlJUVUtWUVFnSVM2UllUdTBw?=
 =?utf-8?B?K0hDTGRra0plaEREL0tnR3h0QzZKcGVCWGZaYk9ZNnBWMUQ5Q1M4ZjVhVDJL?=
 =?utf-8?B?TXNmc0gvTTRQcWlsU2RkV3d3L3FsVTdyT0NzYTdTbXpMa3F1OFBENFZmQUxB?=
 =?utf-8?B?b2RqU0dlbVdhRTYxT0dYa1p6bHJWNXB5SEhhbFZsZHRkQnMvdmRzeloxUVZ1?=
 =?utf-8?B?QWdTS1ZzblhIQm4rb2svWStQQnJyVnZYZ3RTRng4M3hyM05qdGZRb2Q1b2VY?=
 =?utf-8?B?TGRRaE1DZEVqaWU5YnNRSEwvUWEyaUdQam9obnYxOExQbjBXbDRuUE96NHVj?=
 =?utf-8?B?RnRBZXFjbkZlL1U4RitWVGpGVkVobUdDK044TWhWZSsrb29VL0RPc1J3YUJ5?=
 =?utf-8?B?N0Y4SERhbEFNRW52elpCRGMyM3FOMnlmNmVGOE1HMVhldElSaitObFpvb2JZ?=
 =?utf-8?B?MDZmcGN6VFFwZ0JZbDJ4WlNJVHpndUtqdzlzK1FlbTNCdDdtZGExMTRVeU5x?=
 =?utf-8?B?NkZZczBtelZ1eEdwRkY1STRVdFVDUWwwdnFKanl6UHBkcHFzTHB1VWplenJs?=
 =?utf-8?B?dFJhTkRzQUJmc1BRZkRnNXQzbTdFU1ZWdm04WlVST2ZKamk0cnUwUGpwWVkv?=
 =?utf-8?B?NWJySTg1WXkzWVZWbjAwSU9Pdi9iZFpuK1dPRmR3WkMwY3Q3SWM0amFXWFFL?=
 =?utf-8?B?KzcwNlVlZVFPOEpDTTFsd3doTHBya05mSjdXU0crSyt4cmx0SnVjbkJwQ0Vl?=
 =?utf-8?B?TDNRUXdYQ0lZY0ZYeDBDTlk3ZnlzTlZFbTk5V29xdE11K2JFL2JEQzZLUVFL?=
 =?utf-8?B?NjVTVitOSnZoYVJ3Vm5Xdmh3Q2gyRkVwU2k0ZHJKbkduemRLdFFjZGVYOExR?=
 =?utf-8?B?ZTEwT0xiL1l5OVptZVhVS0ZpaGM4dU0xRmNBK2NnN2xxWElYc1VjSTlCT1Zq?=
 =?utf-8?B?TThlTG14MW5lVWxLbFVNWWIrMmhGdGxaUWNBcnQ2d2Y5ZnJYOWpjellEWTlE?=
 =?utf-8?B?M2F3d2hNS1ZNK0lnSy9rSGVHZXMxeGZ4c2ZpS1VicE81ME4xdTdyKzVhajNn?=
 =?utf-8?B?UW1QS3YvdWhaUHEyMnl6NG8rdzR5S3IxZkFsQno5TjFyTHoyY2JHYVlMZkg2?=
 =?utf-8?B?WW1TQU9oQ0JYdWxvdzJVT21UWWIrZ0Z1TnViYlN5MmsrUm9GSmVzcnNoV0hy?=
 =?utf-8?B?a2V4NXlwZFR0TFRhN002cVR6bEtmZ1FyQVY3UU1IQU1ObzEvNk9jN0wxc3pI?=
 =?utf-8?B?bWFUcFdkZFM0dHQycWtBcFVJc09VeVg1VjZCNWFESUVqbXdxSjYrNW1pQ0Vw?=
 =?utf-8?B?ZGExRnRhT1kvTDk4aWh4anJBZ3g4OG03RjF4Y3pZZGFoRmZHOURWMEh0OXh6?=
 =?utf-8?B?SGhLSS8yakVCcmxPZXNYMzZuSzFCWlJZMVI2b0NLWkpxZXdnMG12VzZxRUVU?=
 =?utf-8?B?R210NFZJUG95bFYwZWhQTVVLblh5SHlacEl0ekZHZVB1ek5ESVhacmxMell6?=
 =?utf-8?B?WDdtR0ZlRWJqck9Uc2U0c3o1WFhsRlQyUUFUTUJ4b1A5cWs2aVVhK25rYmJa?=
 =?utf-8?B?dXNXeTRadjRDcjZQT1JhWUtHUVFOcDdwcEU4ZXZEQ01TV3BFQ2NDWHI4d2lF?=
 =?utf-8?B?OTBCZXZGNVgxRHU0dGc1S0JuaGIyeFpnZ3hudWludXRpeUNVRnhCaHV6dmVk?=
 =?utf-8?B?eXhEZDJFd3ErM2I4U0d3Y0hyaGJjcnI5SURkbFhvaVVGdFIweDlFbUpOYzRJ?=
 =?utf-8?B?TklHcEl1cmhVWWtiakJ4QkYwQmRmaFEzeFVSTzdwa3FoTk9uUmVMRFdYK0sr?=
 =?utf-8?B?bExmalVxbG9LTE5sUEpJNG03RytXYTE3cnhDamFOdUovUEZHQ25wb1FGRmFT?=
 =?utf-8?B?VUMrVG5xYlNmczJuL1JiWnZhcWFucjJDV0JiaG5MYmNwOGFJM1VTN21ZQlVj?=
 =?utf-8?B?Y2dZcTB1TjdRNG5FaGxBcXFVSHZuNE1Tdm1kblVXUWd3YWVBamRreFI5VDQw?=
 =?utf-8?Q?xj1SfTiUT19YJuUZPeqHzkg6aNWSQY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 14:26:51.6730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66332ba9-ab09-442e-9243-08dd49def62e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9192
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

Add ring reset function callback for JPEG4_0_0 to
recover from job timeouts without a full gpu reset.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index b0666090f52c..7b6c7aa36ff5 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -143,14 +143,10 @@ static int jpeg_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	/* TODO: Add queue reset mask when FW fully supports it */
-	adev->jpeg.supported_reset =
-		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
+	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
 	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
-	if (r)
-		return r;
 
-	return 0;
+	return r;
 }
 
 /**
@@ -724,6 +720,20 @@ static int jpeg_v4_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int ret;
+
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
+	jpeg_v4_0_stop(ring->adev);
+	jpeg_v4_0_start(ring->adev);
+	ret = amdgpu_ring_test_helper(ring);
+	return ret;
+}
+
 static const struct amd_ip_funcs jpeg_v4_0_ip_funcs = {
 	.name = "jpeg_v4_0",
 	.early_init = jpeg_v4_0_early_init,
@@ -769,6 +779,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v4_0_ring_reset,
 };
 
 static void jpeg_v4_0_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

