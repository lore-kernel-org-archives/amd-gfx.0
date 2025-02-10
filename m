Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02ADC02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 14:28:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B33410E56D;
	Mon, 10 Feb 2025 14:28:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4P883cr7";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFA4910E56D
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 14:28:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wd2Kf73KJTHGiIXVHgAGi3p1DUcTxXItmyNNb2fnmwwIVNkXRls1qJUfU9PCyu5b3m2R7+i6RoR5JJ7iib9r94F651R5lTK8clxnxYcmJBinU10YyFt29iDVAYtdRhIUsbeAFPouN2/izNvlHw2IqpmQpRmes/wFBY/zzBMYpDHy2obo79TcigkfA+SmlIDmomwBtYZcMgQ+d1yPfolaaEDgPT01ofbO7LgMR5vDSRa4ffjx1s4zwvIqTCfgq4vPGJWnN6yUxjvkmzokC+TjIixm8HrcJ2/ciJa7v2SuEQfLEA9z3cJw5lw0T/2CbyPlhrg/7R8blOE/OblPGJnP5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4O/yv1LpUtDBFxaBtLmRfBQF3Tg9RDxk8bQqq8azxI=;
 b=ZYZbqzL19pEloY1BUXryNgXGVKZ1MYh2gJwK0gIHgRN3Eo0lbD3bAbTXGUVPTw9U6LyqUeB9aOenvvT8XUl/7OrPef+5psDkKJ/Tdjf4arNv06ec23e1t3YVY+eva1DNF1D82DsjskM3sFCvLZqN3fvXxdUEq05FMccMkJ3O8IJZKwMqZFPrrGvG1/4lwf4ws8vdZPn/gqDu9MuC8BKCci49AvNsvH+j+nIywCG9adkl0njhyDk8xjHuQzOeRFDKYRYxEKGRUxjQ7OVXjODLoSUg1rhDw0+lWjOsoSgdAmKkyC2VOzVR7pq2Ws10jprIYZCOJr9oCVNkqBd4yQT2Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4O/yv1LpUtDBFxaBtLmRfBQF3Tg9RDxk8bQqq8azxI=;
 b=4P883cr7AHV7kNSPw6KoDlUvuC9nIDCuUnWyDjeJPFJ0mct9rUJiFY0bo68m+fgHuVpCAu0s2erO3hNWFhnxas7U/AKJ0v4pNxH/rqyY8DDVIZUCCktnBT50DFI9mwXnzB46RuC6qXs08I7FZK0kGz3wCW++1EebNxacAxcuoco=
Received: from SN6PR16CA0055.namprd16.prod.outlook.com (2603:10b6:805:ca::32)
 by MN2PR12MB4125.namprd12.prod.outlook.com (2603:10b6:208:1d9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 14:28:35 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:805:ca:cafe::4) by SN6PR16CA0055.outlook.office365.com
 (2603:10b6:805:ca::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 14:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 14:28:35 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Feb 2025 08:28:32 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>, 
 Koenig Christian <Christian.Koenig@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v2 7/7] drm/amdgpu: Add ring reset callback for JPEG2_0_0
Date: Mon, 10 Feb 2025 19:55:48 +0530
Message-ID: <20250210142548.2321625-8-sathishkumar.sundararaju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|MN2PR12MB4125:EE_
X-MS-Office365-Filtering-Correlation-Id: 06be5b30-741d-43b3-5501-08dd49df33c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVFTN2pSeHJ4QmVxWnlLMzFGOEZscUlmMEtjbHBEbXZzeTd5d1pMRE5BNFVq?=
 =?utf-8?B?VmI4Q3hlY1hBZ210SEUzdjkwMC9HQ1dYdlhJOXFsbGNmRitkSjBLTEF3WVJl?=
 =?utf-8?B?eEZYKzl3c1VJa0h1Z2FOYjdnSldHY05mZkFVL284eGx0Rm5CZjJoMFk5Qzkx?=
 =?utf-8?B?dVFMMHA4amVLODBBU3JjYTN3QkNEenk0WEJjTnByN251NFRTbUI0QVRLWDlJ?=
 =?utf-8?B?L1dURDVJenJmb0hCa1NwVkxWNUdoSzVjeENnQnNkU3VUYXg0Ykh1dm10MTdN?=
 =?utf-8?B?YTM1K3hhY0prckFUSlFoK3daOURzd1pSWTZpRXpTM2YrN29JT1B3aFVvNDhi?=
 =?utf-8?B?eUE3Rkl3N003Z0IycGlLNVFMWEMySlpqNWs4L0JOODJsZlRoMEJpZlNGTmdp?=
 =?utf-8?B?Yi9aajkzN2lKdy9oS3ByTC9GQ2toc24vMW8xbklJbE5MamF4QzZhdVkxdkF2?=
 =?utf-8?B?dWt4a2tnaVlhMXFWU2FRTDJOdkVPU3UyNmVpeDVBZGtOUmpwSE5HZkhVWENT?=
 =?utf-8?B?RTRaZ2thRVp5UEZKaitmbW5nMzVTQVFoL2NPMzgxK2hTSUFnajl4ZXFPNzVG?=
 =?utf-8?B?a0hpU0NUbWp1SjlZdDAzTUJjS2s1T2hjQVU0YVA0WkI3bE1yU0pQU09INHA3?=
 =?utf-8?B?MGEvY3hVWVA1TDdzVjArQ3FjWGdQUkhvZzdNbS9xSFVVaE9GT0dJaExCOFBp?=
 =?utf-8?B?Z1Q4aDFZYld4SEFoalYrdWdsdE5GK25lOGRjb3hRREJ5MytIQzUrYWhqVSt3?=
 =?utf-8?B?dFFya3I2OWxJZWxuSEpNMlUyMUpYUnNTT0VhSDFSMXp4U05semYwb3NvUHBz?=
 =?utf-8?B?cGJGWG96bmRtZnQ3R0xnVkZVcFNCbVRzRTRFSFhXNzJqL0ZYNCtybHpIQy80?=
 =?utf-8?B?djRZRXFvdWVzdm5PNCtkQ0JhUmM5bUNnSDZTR3Y1MXJWUmNyYlpQMkNiYmlX?=
 =?utf-8?B?VmdjVVA5STFNQmYzZVlxTVJHQXBPTHdVcWJTNVIzeDVIL0t0N0J4TFlTQlM2?=
 =?utf-8?B?dVh1VjkxdnlzVXdUeFdmRFk0S09VVXBsSHQvNktGbkhtR1R1My84Rjc2OEhB?=
 =?utf-8?B?YldTZXhIYk1IYU9qZHFvOSs0QTZDSHBQQTF1TkJNMTdzWDRPUEtFZkRHN2R2?=
 =?utf-8?B?eDV5V2hiWjZhSWZpSG85R3JNYk96YzN2R3dQM1FPbHZZVGFKWGZGRlNDWXU5?=
 =?utf-8?B?dlZIdG8yMmoyTFFoeFBUK1l4N2lzYWoyRFR1alIzaXFWQ01ObzBUMUFUWFkx?=
 =?utf-8?B?b2lRdUUyZkJNZS9XL0Eza2lUOGxSMmtkb1BGTWwvVFlGTjdtblBPKytpMmgr?=
 =?utf-8?B?aHk0MTBpN3RHdmt0NnFIaUVvRHgxWHk4NldqWmlvWllaSXk5TTYyQ203eWFI?=
 =?utf-8?B?ZE10QTVtaXNvT2dkTzJDeDFwSkRLWVI3RWc3Y1c4MzdwdGJIZmtQUW5hV09E?=
 =?utf-8?B?aGdFalJ4R1B0b2NyMDNZMWhUdG5TWHMxMjBmQ3VvTGkyWVF0Tkl5WW5La2pq?=
 =?utf-8?B?OHF1d0Zha0U1TGRmUjZQTGZTajRKZjM3cVRoS1pYTGFMNjE2WEJuQzA0dklT?=
 =?utf-8?B?OWZVd24wU0N0MWppclNXR3drbDduZGpBRG11WlBSQ0dad2xBMHlPT2Z5eXNV?=
 =?utf-8?B?eUQ2YzByNVNndDVhTHJKWDVOblRVT3dZb0prWVFnWGdsa05GUmZsMlJjU040?=
 =?utf-8?B?d25tdkxVRFV5VGU1WUVJcnhLcWlObktQblZ0V1UweldieFJCSkxuWUxlc1Ez?=
 =?utf-8?B?eDRnREwrRnY2ZWhzM0pOTStYQ2NRK1dablhBOXlVdHRQd0JaUWN6Z2EwZkJC?=
 =?utf-8?B?bmN5alVJTVU4N0Z1S3B4dUZoT2xLMkdNQzlYUWdSSG1HanhZTFdmTUUyakxG?=
 =?utf-8?B?emRGaFJoVDFvMU8xVGEydlorTmsxbTR3V2VyQ0tDdG5RcFlUNlVwSm8rcGtw?=
 =?utf-8?B?dk1Kb0k4ZjNxMXRWVk5ZeDBXbDVIS0F6aUFHWTVLbmRveHFPSm5jLzFwRjVS?=
 =?utf-8?Q?VU0AnmtF8STOZAYXAAtDyFlOR0Q7us=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 14:28:35.0540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06be5b30-741d-43b3-5501-08dd49df33c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125
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

Add ring reset function callback for JPEG2_0_0 to
recover from job timeouts without a full gpu reset.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 8c61081746c6..0519cfa112f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -118,7 +118,10 @@ static int jpeg_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	return 0;
+	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
+
+	return r;
 }
 
 /**
@@ -137,6 +140,8 @@ static int jpeg_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
+
 	r = amdgpu_jpeg_sw_fini(adev);
 
 	return r;
@@ -759,6 +764,16 @@ static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	int ret;
+
+	jpeg_v2_0_stop(ring->adev);
+	jpeg_v2_0_start(ring->adev);
+	ret = amdgpu_ring_test_helper(ring);
+	return ret;
+}
+
 static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
 	.name = "jpeg_v2_0",
 	.early_init = jpeg_v2_0_early_init,
@@ -804,6 +819,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_0_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v2_0_ring_reset,
 };
 
 static void jpeg_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

