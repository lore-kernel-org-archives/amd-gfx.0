Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D28C02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 14:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC2DC10E567;
	Mon, 10 Feb 2025 14:27:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ii0iCQUs";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10B9E10E567
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 14:27:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rePzQ0oXSrXyxUdzDYFugLttv1uUq6QzsgaZb5ky33KH5idyQOx3UE4wJHK2KO/EOaw84PV/YvdA3b1bcCMjFhkkKrnyihNcV8E4IGChV/X/Z65mSu+6LUXo6Zv/ldPEPrXnqzUajEL2wqxzc/CNRYO043mCEeQFkAia7HbL5diTXYNcgGODj+b57dzT+Nj5+utTbYTI5zdVwXTucZEkQ7VajVW1DKl25+N5peIxlE2FnbE+v73355lo0bZZQQu+0L95qz8aMBni9cdrp01C8xPsJa7BedM2dDRtBXNUsBZFNh3zSjnxPSheLYMRCSTQ217IXwRrljxPjnkAOeSuow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bid/rO+gEucXKpQGNOj9hBIAUeCGBa5zIfEQ+qukUOs=;
 b=Rih3ulPhDeABrii/gJnecKbI9h3Dw1Kg2GPLGazubDeawno9MXmc1sY3MN7OqhdHxlSr8IadCMJyCOUFetlqdd1LzU2Ax51cO97qZUrWbglWSiWdHsXlzz+N8jk5g0U4BTzOD85svh6NrL/q4G1F480fua4mVS7yhpzpjbXE4g3BfDRPT5u8qW3zgGWmT+mC4uU1G5wsM4Dw8aWmnc5mreBpVRCSaxf/D7M/NYLAz87qY1ODfGyZ7wY6t6w9Z7UrsW4gOXdJAJd/FJpjcxsBZmLh46/Rwo7gYP4JlBRWzfTn0nr2VCWhwEdQWF+ow1mPP+Y6OAWHNmIXC9ChaB475Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bid/rO+gEucXKpQGNOj9hBIAUeCGBa5zIfEQ+qukUOs=;
 b=ii0iCQUsQsvKKs54nr2CIqrdez7WrYZfXHo2CcOgqmU1ywJUJKry8ZUdFxdCKKd2OEgRbed69mvJgR83zZ7NmKz+Tw1bxnXnAWac4Bj7EzgVr2JaeQjKvez3t0QHJTe+IH9vE7gfd/w9xXB/BK5ZJa0fLG+ZpQCYRmuUCGiL470=
Received: from SN7PR04CA0080.namprd04.prod.outlook.com (2603:10b6:806:121::25)
 by DS7PR12MB8372.namprd12.prod.outlook.com (2603:10b6:8:eb::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.18; Mon, 10 Feb 2025 14:27:51 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::47) by SN7PR04CA0080.outlook.office365.com
 (2603:10b6:806:121::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 14:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 14:27:49 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Feb 2025 08:27:46 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>, 
 Koenig Christian <Christian.Koenig@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v2 6/7] drm/amdgpu: Add ring reset callback for JPEG2_5_0
Date: Mon, 10 Feb 2025 19:55:47 +0530
Message-ID: <20250210142548.2321625-7-sathishkumar.sundararaju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|DS7PR12MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e9e35a2-c06d-4972-f374-08dd49df189a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzJ2WlhpM3J6b0pNcWc0Vm53TWNrNmZzYXk5OSttWWJJTS9VU0VnVkpUUGlI?=
 =?utf-8?B?VXU5T3NpY1pEN1R0ajRGQ3F1dUNzSi9RR0RlOXd6NmRZNUJOalk3azdLT2lP?=
 =?utf-8?B?ZnIyNk9RdlBVVWJRSzNmeDkra1FleWk3M05WTHZpU1o0UTM2cnFVTDcvL1cw?=
 =?utf-8?B?dThKcUluMmNDOHBwSG8xbGxUWFVZRHk4ZWE2dUtHb3ppZ09uaUxoeDRud3R5?=
 =?utf-8?B?QkxQZ21WM2ZVOXJJSFFTZk8yUGpLVk9ucERmY01sWXhsdzVmUlZMNlE2Mk9K?=
 =?utf-8?B?eUlLc3JFMkIxbXNBdStwQ0FIMWJMdm5tWWFpS0NpVnhlWkFPNUdhSGhXMUdw?=
 =?utf-8?B?OWJCZXRLcWhyYUhHZGYxc3lsdytMQkNqNTNxRmgxQXNwTE9YUzQ1ZHgwbXNy?=
 =?utf-8?B?Vk40RjJTUEhKWGVlSndOaWg5bkczRmVUNTVtVkRHNllJeGJjZm0rNWtQODRn?=
 =?utf-8?B?cFREVUtEb1NDSXBncE1zNW9rUWVncEVrb20vbDZCUVRtM0p3NVJsaTdnQlNF?=
 =?utf-8?B?MVpJM3hSL1VBSjU5NGRVUnhwTlBMckVhQVNMZjVkUmFCMnFVeGU2eUFHa0xY?=
 =?utf-8?B?NlBlZHQ0Qm5zZVBTWHpGQlpOaFl4dWIrL0tkZm5IOS9aYnFiSEVXMDJBRk5h?=
 =?utf-8?B?Tysyd1ovMXhGdmI0dVl3MFFMMU9vK3BydmM3VHI0WTUydXFLK2xNS1FKOTdF?=
 =?utf-8?B?YzJQVWltVmdUNWp5Ykh2UkdwZENvcndrOWxMTWxlT3lYcTFpNHM2amZSeG1J?=
 =?utf-8?B?WVFrOTdGbFJmYU9iYlE0SXppU0EvQk1ubEMxSFovVERuWjBRYjAzaUo2V0Ur?=
 =?utf-8?B?am5CYXlWY3FnL0Q3VXB4a2ZESjFXcWxVVG5Beks4QWI4eVNVTlE4SnBRMml0?=
 =?utf-8?B?TGtqU1dQV1JCSjZUV0VqWmJuZnVjbndMQjR0OXd5QkFNTC9YbHAzK0V0M2RK?=
 =?utf-8?B?WDBiay80Tnppc3ZQT3pmOGNJd1d4eFRPZEZzeXc1eVNDd3ZQenlWaHE3WW81?=
 =?utf-8?B?b1FUcm55Y3QxdjJnRENVb1hXQSthSFNPUlYyUEhLL1dTWUFSc0xML1hJdTJx?=
 =?utf-8?B?VGQ2dU40YkxyYmtzd3o3Vi82UlA3c3AvS3k0Zzg3TnpxdW0zcGRKa3ZLZEMy?=
 =?utf-8?B?Z2lTOTdmamJpUnA1MkxwODVuSWdiT00vR00zMyszUTJ0c3lKeG5HQ0hWWktC?=
 =?utf-8?B?RnFqVzVkRzJKOTQvemZKdjdDb2tJdnVESngrcE41K2RtOGYrWlhqY1RwM0xo?=
 =?utf-8?B?R3EvQmVJYkNQdFdSa25WOU41Z0xsVldrbmd5WG1Xb1RlWmZEaVU3MlZsN1g2?=
 =?utf-8?B?bzc5dHJTRzkzSUZmalBwNHRyYkQwL1BFSE8xeWwwOVJ2MlBpcEZVZXY3dHZo?=
 =?utf-8?B?US81NnZZVFlVUkZFREdGNEk3OUpDYk1IWHl6Uk9WLzB6QVFiZUxTQkVTQktO?=
 =?utf-8?B?MGlDdExBbDBjYm1pWjBwRXIxYnRaNXQwVGEvQ254R2NmY1llc201S3hIU0Nw?=
 =?utf-8?B?bCtsS1hqckJPbVVsYU9tUlptVnlGZjlJVlRZWWg2OUoxVmJmK1N6dHM1cTk3?=
 =?utf-8?B?QWNrNGpWNE52TENzb2MyVllzNGd6MG9UcTFZa0c0M2QxSVVJRGloamRqUEpB?=
 =?utf-8?B?dDBkY0FISHNoZ0NLeW40aXVrL2xVclgreDNwWVZ1UWJxSmdvTHU5ZjZjZTZT?=
 =?utf-8?B?ZHFvK3lrM01yYXNKNnRqMUVzakRQdW1JSjUrMElja2JETjdidWIyOVlqYXRv?=
 =?utf-8?B?UkNhRlU0cllGeEJyMWVURnlsOW1RTzFLMTl0bHcxS2FwTldyWkEwWmF0Y0I4?=
 =?utf-8?B?aDdEOHZqcjBqL0pxUzdPNWppMGxEZW81TWx4aVVISHljT0tCdjBRT3NuVHBF?=
 =?utf-8?B?TkFJeEcrSnVyWU5VanZZTFJsZ2VGdTllOWI5RXE4bkRyTDRXdFFVRys0UGxi?=
 =?utf-8?B?WVZ1OGpqeitQU2c5Q0w3bTMvOEoyMjhiNE5PR3dZSExDZ3dlSGkzZ0MxS2NP?=
 =?utf-8?Q?PFLMERhyRFJ8EAWLMpwnfLUEHg4u94=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 14:27:49.5039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9e35a2-c06d-4972-f374-08dd49df189a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8372
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 0490b672d8d3..245ea404da2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -167,7 +167,10 @@ static int jpeg_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	return 0;
+	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
+
+	return r;
 }
 
 /**
@@ -186,6 +189,8 @@ static int jpeg_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
+
 	r = amdgpu_jpeg_sw_fini(adev);
 
 	return r;
@@ -638,6 +643,16 @@ static int jpeg_v2_5_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	int ret;
+
+	jpeg_v2_5_stop_inst(ring->adev, ring->me);
+	jpeg_v2_5_start_inst(ring->adev, ring->me);
+	ret = amdgpu_ring_test_helper(ring);
+	return ret;
+}
+
 static const struct amd_ip_funcs jpeg_v2_5_ip_funcs = {
 	.name = "jpeg_v2_5",
 	.early_init = jpeg_v2_5_early_init,
@@ -700,6 +715,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v2_5_ring_reset,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v2_6_dec_ring_vm_funcs = {
@@ -730,6 +746,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_6_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v2_5_ring_reset,
 };
 
 static void jpeg_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

