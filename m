Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04F7C02190
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EBD610E382;
	Fri, 31 Jan 2025 16:24:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q8kZGsFN";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1A2310E382
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:24:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nljNVmzEVmOOiGiKCDCS9XU2VU15keUvsawrYxA1D+dWxiZREhyXZhtki6vmzrn6S9WGFpxoalOMhxSq6PxpYUxQE0VxLFkSR392+lVSeJ49nPezR4aVhTKwks3ewEk5rAJqpfi9p/e+6CY5ZtS3zrWge6qf7FtoJbyfmQO/j5JNx+psdjmjDaMtqhFv9yWNY1b3ORlO9OE375BhUHcFsK9/65tNf++Lgz4/Qq5xA3apM/xbCfv9wKW7lkoR3gtMxB4TGX6WLrhCuC1hsn2s/UcrRqQaqthMyOhSG3u1zzvsm75wIudSFzGoXZTy6sEklh0Fp7P3nwqIb9szqsJUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHpXlnc1MYTyU0eqcshzZCoBP+xSg53pWC+V+Rlod18=;
 b=D6SHH+VZVhMB8ARNZQ3Wy3QUmrU//q84Ob9lx+ymjH3tvUckSFd5EYq3LVXwbXkFHA705WS8Xjp5H+vmuXxq3CVOt9VTHBuX6rZD5O+1gMUsbrBKV5Szxb36VOiZLPExjQu/iIVcKIIDZHX5yTZkXqRfdW3acWLEllR7rqiU37bk71isUknIhgR+czQhUQO+5pwK/xVnZ9hFVRreS1GREXVsy+c/wrLZdgUlpqgVcXnvdcOTQZSFABgi/ihl9spTIl7frPWMEgJV5diIU1dWl11SEqaRwDN5ImUVta4GHxaqDDbxt6awnjIHkLFp8Dnr7DK5FfOREuAeqSOCXVrxrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHpXlnc1MYTyU0eqcshzZCoBP+xSg53pWC+V+Rlod18=;
 b=Q8kZGsFN8g5Hj0ybQ7vX9VvyzmbxbQxO33Ut7l3Th87kf7s/vq5YbhICPVERSEnJk03v9gMGclzRKZhajB9v++9eNh4fE1hEoYSliro/92MC6zHa7hcJOs3TvAfI4D8lddTRNTBouKFgiEruHoCOkmQXFri71rRPC9H6M4UcD1s=
Received: from DS7PR03CA0283.namprd03.prod.outlook.com (2603:10b6:5:3ad::18)
 by SN7PR12MB7936.namprd12.prod.outlook.com (2603:10b6:806:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Fri, 31 Jan
 2025 16:24:26 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::cb) by DS7PR03CA0283.outlook.office365.com
 (2603:10b6:5:3ad::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Fri,
 31 Jan 2025 16:24:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:24:26 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 Jan 2025 10:24:24 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>, 
 Koenig Christian <Christian.Koenig@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 3/7] drm/amdgpu: Add ring reset callback for JPEG4_0_0
Date: Fri, 31 Jan 2025 21:53:17 +0530
Message-ID: <20250131162321.563314-4-sathishkumar.sundararaju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|SN7PR12MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: c6614b34-c43e-44d0-c522-08dd4213bb08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2UvNmxRdGkzVUdzcEV3VHhPWXZMQzdKZVZaMUcwazM1SmpLSU5XaGdBYmNx?=
 =?utf-8?B?VmhjMmd1dGs4azMrRjFldzVaYW82ZS9tblpYTmtBRjR0QTZIcWJrcTdrZXFO?=
 =?utf-8?B?WU9KYzBSdFhUNGVyb2FNSFRMTTZmQnd5NS8yaURHemtlOERqYmlwMGhuMDNT?=
 =?utf-8?B?VzIxMW52ZWs5cmtZcGs1RmhtV0FuSWZvdy9QUkpnU0JnU3dLQlplRVZGb3hE?=
 =?utf-8?B?aVZUUjNCbXJzdVdSWlNhWFU1clFXci9TeGRIMnd5RDUxZ0JQZUZCTXJha0VO?=
 =?utf-8?B?dllxck1RNzhEUjN4YXdzZURKUFpVMUpLT3RvdGFPdFVGWlVIdUc1S3o4QmdN?=
 =?utf-8?B?bUNPWTZwelFBbE9BZ2FFMmplY0V1clZNdkt3WlZQaGJZL3A0UGtzaFRvUlV5?=
 =?utf-8?B?SXFLc2dOeEU1cThYOXdteGdoNENza29BQUVZUkdQdFpOcTh3TmdpbXVuY05Q?=
 =?utf-8?B?enJjSFRxWEVPZFJxWEl2UmM5UlprNDBvWndDcjFrMCsyaGN2aVRSdjhWS1JB?=
 =?utf-8?B?c01CYTZxdzZhVWY3RXJxWjJUWWtTZUVVOVBsMFBrdnZoODkxaXVhNEx0Z2F6?=
 =?utf-8?B?cWYyRjlncGptUHphTWxkMllFNDkzb3ZiNURaVWxWcWhtKzF3dEdGdExvK0Z5?=
 =?utf-8?B?eHhFK0huKzJoZjN6WGUvaktQYkhIaXo4UUo2UlQ3Uy8zdWpMM1BRQlR2cnR4?=
 =?utf-8?B?ckxKSURYcyt3UC9NcE5oVStqdlZ4YWJyMmwwbFlLdXd3cEx3MmFnZDVTZUVp?=
 =?utf-8?B?TW41eTNJb3NkNVMxYjBsbmtWNHZTdjdDdEI0aER5TnZzVHBGclRvRWdjb1lK?=
 =?utf-8?B?TzdrTTFiSlpRcEVZb3Nvak5EVWEzSjJFVGxQU05zUjdKTmdCK09weDFzU09o?=
 =?utf-8?B?OXA2ZVFJWjZiRUk0Q3FJTTAzR3ZYcTdqT3hEN3k0VlQ2TC9sYy8vcWkzcGg1?=
 =?utf-8?B?MHp6ejFUMmZUSXFsVHhoTWMrOGtJZkRZNkprR0hZZ3kzL1NncnE2dmVXMk9C?=
 =?utf-8?B?RFYzaXlxcGJpSGNYbG9oN2c1VUxBS0RSNXFEUDZadmQwT0U4MGJHWi9POXBL?=
 =?utf-8?B?WkhORXYvaHAzMEc4SSt4SGhaSEMrRjBMWHRjK21aR1pieEVML2QxL1puS3N4?=
 =?utf-8?B?OXJ0VW9NcytWcUhCT2g3VEsrbmczdDRTOWFYcFFKSDhKYmZBN3ZleUl2WTZ6?=
 =?utf-8?B?NmZqTnM4YnRlZzdOdG9oZmpKL0w1VGZieVFSdlpRcXdtUkQwSVJZTDQvS3Fq?=
 =?utf-8?B?dERWdUE4R2dMeEw0VkorL2F2eEh1WklQMkJSSGVaa29ZNk16dmpUNEc1VSs1?=
 =?utf-8?B?YUdrNlo2cjFQKytPTzIrL0dnNlNHdDIxcVE2d1ZXcm52Sm9iclc5RzJVZkt5?=
 =?utf-8?B?cmRjdGtUL0VYTzJYbFRvbEJ4MWtQN3pyYU95T2lmc2twS2NaWkMreVZPa254?=
 =?utf-8?B?dlNqNU13WjhLSk05Zi9qUS9HWS9vU0hxYko5Y2NyQnRZTEpDZmVieXdpT216?=
 =?utf-8?B?OWhxNGJVd2RQcVRjcHBmZ3MzYVc0RDJUTHE5NFl0WVZmalRnL0lGTUZjTEpB?=
 =?utf-8?B?YVRmTDk3VDhZRnNZY2V6cFNZallmdk1STnR5RDNpYnJ3djJHRVNBWFN6U2pw?=
 =?utf-8?B?YUQwU0JMRW1GWG15UkJJRTdURGU1RGtPMXBSc3I3MVEwOU4rODdiUmk3MHVh?=
 =?utf-8?B?NVRreTdCYUdrRFdLYk9yQm42L01KckczeGVpcExXOHBrVmQ4aS95S3JhM0R6?=
 =?utf-8?B?Nmp1c2xBZ3BVanIxS2N6c29UaFY3eURqL3Q5anVHU2pNUlpFNWFBbTA5dDBY?=
 =?utf-8?B?bUR4YXByVng3b3hmRVFHaWVuUzZwRElDVmU0YUZjbkNJdXAvcGFKSzY2eE5v?=
 =?utf-8?B?cW01NEJtamdDaVRaWmozYzJWOXFuMytJcENuZU1yaE5mT3dZOW5yUHl5elB1?=
 =?utf-8?B?YjluODA0ai9QNFFiUnlyZnlvRlBCc2hJeThneFJKcEpidU1BNkVhS3hqVDNR?=
 =?utf-8?Q?bRKArW5x8+W8LDSEz02XAyX2OrF0wo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:24:26.4798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6614b34-c43e-44d0-c522-08dd4213bb08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7936
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index b0666090f52c..00d7415f4945 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -143,9 +143,7 @@ static int jpeg_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	/* TODO: Add queue reset mask when FW fully supports it */
-	adev->jpeg.supported_reset =
-		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
+	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_PIPE;
 	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
 	if (r)
 		return r;
@@ -724,6 +722,23 @@ static int jpeg_v4_0_process_interrupt(struct amdgpu_device *adev,
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
+	if (ret)
+		return ret;
+	dev_info(adev->dev, "Reset on %s succeeded\n", ring->sched.name);
+	return 0;
+}
+
 static const struct amd_ip_funcs jpeg_v4_0_ip_funcs = {
 	.name = "jpeg_v4_0",
 	.early_init = jpeg_v4_0_early_init,
@@ -769,6 +784,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v4_0_ring_reset,
 };
 
 static void jpeg_v4_0_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

