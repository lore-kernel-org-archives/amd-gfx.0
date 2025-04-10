Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EB6C369A6
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 13:02:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2279E10E99D;
	Thu, 10 Apr 2025 13:02:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nuNX/OcR";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8BD510E9A0
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 13:01:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+TOasecq4VIciEaUEsuEhlkkvvADFT2ZXfGynq38tI9KIJVIWSlrxRVdN+ziWgBBfpONcxLborVa/Vczfsbzj2immqw8q3sNqiGufMBocZyW+Hph8uC1l+zIrG1uWEoyTqF8/7cpiPOz1gVKlIsqlZeVGqYik8Dy7nWg0POHjb5uT1mnfRePyOPklSrp4Maex+sCpaXD58TRQ6Ol8ur4v5PRMFf4gLSggXbS3zm+aSp3ggH2h9ZtJb5XEqd5/eWciYCdun1VlHwz+vxO21QoLqhW527FFPkLpa9CoaHXP6eLd4xvxJj/EVoYjw1harVARFt0yO+b3asAOJx19khkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9U7SdX0vkabIwpSAktTMNMwaWr/6pNfHjCSuE+oQM0=;
 b=l+YmLd3kH/OokaSVPT9MHRvO/1XpsiUAjRfmuht+Q2a/Po34cjewEpm69hPqHehsBcwBlR76Trf+gDz4GnN0rudZfZBd6R15ZnUBy/DyIAvqGxmwLF+e3WBlR9p+mPuuTwzLFhyIKLUR13RCvzyXn49oW3gEf/atjdd/iMucN5rQFOYVtlZMJw/JCxG0F087r4DowkTWda/AdhOf71En13ewyDqVVK0WDW8TRZuxFZGjc709XUJdKj0EzjB0ssQ7JMpJIfqoVwsnZ3hI1tJ6XqYc+zOI9oaWBZElGc3kl47pApj6t5whYwmKMm0oVdRD13oOMgALphj6SDVTSL0h0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9U7SdX0vkabIwpSAktTMNMwaWr/6pNfHjCSuE+oQM0=;
 b=nuNX/OcRyl6XXHJT2BYUA/uYHvsE2XaPHzR6BVimhuv6zWyl43Z1fDSLLqBZRjJPf5MqdQwjPcNpYf05WPQQy39hmPEny2WPNt1AKRG+fSeLxDH6hcS0sci0ibqnmek1yNLbdP0OEN0AlPtoPqUEF0tnp8gjThIFez+mpXYdtdg=
Received: from MN2PR15CA0048.namprd15.prod.outlook.com (2603:10b6:208:237::17)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Thu, 10 Apr
 2025 13:01:54 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::c1) by MN2PR15CA0048.outlook.office365.com
 (2603:10b6:208:237::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.23 via Frontend Transport; Thu,
 10 Apr 2025 13:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 13:01:53 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Apr 2025 08:01:51 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Zhang Hawking <Hawking.Zhang@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Enable doorbell for JPEG5_0_1
Date: Thu, 10 Apr 2025 18:31:13 +0530
Message-ID: <20250410130113.2834113-2-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250410130113.2834113-1-sathishkumar.sundararaju@amd.com>
References: <20250410130113.2834113-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc2257f-f79a-49ef-5308-08dd782fdda3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWxFSWNPWExaNzN3U0NlbTczK1JVOVlqUGJBN3pUQ2dwOE1TVlA0THVXOG5j?=
 =?utf-8?B?VzdRVE43TDJNMVE2aWxjREZiM2lEUkNKNnEvUjFzYXE4NHlRekZRbU5rNkR4?=
 =?utf-8?B?elVUYjhEUEJJWTNLT1FBeWU2aHFuS0k4SUVDTkZiY2RsQ09wZHYwMXF4bU01?=
 =?utf-8?B?UWlEMEF4Umx5Tk5JWUJOMnkvbHdvcy9CVGdCL3hiclJUVWNmdGk0RnFLWXFx?=
 =?utf-8?B?MEQxTFplYkorcEZ1SDBGcUZYZXREMGFTRUtkcHBKdCtUNlVmSjE3TjJJVEJs?=
 =?utf-8?B?TGdIeWpBTUFHbE1wNGlTM0dkTFV1Tkg1M21VOEZSUkg3ZFVVWC9MVDRKWVJu?=
 =?utf-8?B?cXpXb21vQ3hkV3pUOUNMdjRWMm1vVlIwL0o4akZETkhvZkwxZ2hiT1NMZlBH?=
 =?utf-8?B?NWJ5SytnTWNzVU1sYU50ay83aHdyUitpR0duYitLK0lvWHdQdXBlc2lHcDVI?=
 =?utf-8?B?RTFmRit6a0xUWEZ0bGw0bTlab3lTSVlnUVdXSnh5UDFEZGZ0bkVHOXUrZ2E2?=
 =?utf-8?B?K0F1dHZZZm9PVmVDUHRMZXdVaGpXNVNBNFZWb0Z3Y3RoUTVPOGYvTTdaeHFo?=
 =?utf-8?B?Uk8xZTV5TGQxWEFZWTd4QlloZWo1WUNFQ3pNSW1jNkVXYUZVeGVqTzdFaTBk?=
 =?utf-8?B?RjZFM1JHVTdsQnkvVHVnSGI1WXpQWnpJMzQxZDR0QWkvUUFUVGhPVXkwcUxR?=
 =?utf-8?B?ZWVYZ056V3dWbXgxb0pldy90QTAwOTZNeVp6RklCWVpaV3AwRms0SGFjQVBX?=
 =?utf-8?B?bXJsMElRTU1GY3QrelZwZk1xRnBBbnh6VFZHbTBFOXRITmxZaU9LV1V2ZWN6?=
 =?utf-8?B?cTM5Ynd0WDN3YkIrRVdiSWNQRGxZejg1VHJMU21TUXY2QzdBb2RTVDBlNzRZ?=
 =?utf-8?B?ejUyMzNKMmxPc2hVSHJuTDdzU1YrRy9NOS90alE1UTU0QUZncFh4cm5BVW14?=
 =?utf-8?B?KzEzY1V0RStIT0djbTZkazJOaVNkSzFRZXJVM0hWN0ZydE9GQjJNYnRwd0xD?=
 =?utf-8?B?VGpFN2xsckd3VUFGV3V3ZktTVEQ4emVxbXFzaTFyeTB5TnNmc0hEQTJtLzlY?=
 =?utf-8?B?NDRMU3FiNXRzYVZvQ2hrWHpYVm4wNDBZSjFBOE9PdDZoZXV4cDhHVUdrazFM?=
 =?utf-8?B?RTRrUmRKQzlNQmE2Q2FOK3hwS2xMOTRmM0xDWHdxS0tXMURBek4rekczQkg2?=
 =?utf-8?B?eWRJK09yOUVYTXdvNXlXZGM1SndSY1VieHNNeHNseXZOSHhUdmxHYUYzaTk0?=
 =?utf-8?B?UndoU1VVM0Y3L1RnaGJYYmE5ZjJkcFNYNFM4N0lwcSthNTlLeFh1VGZvZE5a?=
 =?utf-8?B?aDV1UU4rMlNQZUl1SEJnNm16cUhUQkZlN3lPTDloMjFzb0MzazN3WTZyUU5B?=
 =?utf-8?B?aEowdy9Xc1cxRSsxNlhHV09vZVRFT0FPcTZKZjY0VXQ2b0Z2K1dxb1dBZCtD?=
 =?utf-8?B?WEloQ1hKb1Y2Q0J1OUdtNDRXMmZoT21QTGNpSWh5WmlpTWxoUFJoWmExTVJ0?=
 =?utf-8?B?aGJZdzMyWFZlRENSU2FGTmpCVG83a0ZhbDczOWpISU5CdFVaVmRGTGlIQW5x?=
 =?utf-8?B?NE1VamJ6U1RuaEpiNlB1dWdGbXpCNnViZTRNRlVZaFFOdkpuSXRtdUt0Vm1t?=
 =?utf-8?B?akZEQWJKVW9HbVFYS2NJWHJXbWNkVEZHLzB1K0p0ZitCT2Z0U016WEI5NlVz?=
 =?utf-8?B?RUcvbzlqNGFrYXdRUWRIL2dKdlo4bEdMMFlUVlhTSHJUamZTZVlrSnNFN0JW?=
 =?utf-8?B?RHZsS2Q1SjdiZDUzZXVVR1V2T0c5Y0Q5WVUxOUtvUERtSHVkYURIWk5VVGdV?=
 =?utf-8?B?d3dDNXhXSXY5VHNBWm1HTTFzMFFuYjVaSjRxV3JqZE9hL0t1VHFtZlRMYnBk?=
 =?utf-8?B?UzcreTRGRFNabDN3RUpBRDl2RkxjcTFGYXRpMFIzTXJ2cFBwNjdzb243RDVY?=
 =?utf-8?B?WUNwOUF2WjdlelRadXlTYUJ6alpIUWt5QWFwdFdJNnNsMVdxYS9Dakt0MHJL?=
 =?utf-8?B?M2lxQ3ovb21Ed1JNaDlnUVU4TGh0dlB4aW5CZTFFU3VlaDRaRzFFc1d1dE0w?=
 =?utf-8?Q?d69jkK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 13:01:53.3274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc2257f-f79a-49ef-5308-08dd782fdda3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955
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

Enable doorbell for JPEG5_0_1 and adjust index for VCN5_0_1.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 218e16b68f1d..6f73033d78b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -156,7 +156,7 @@ static int jpeg_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
 
 		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
 			ring = &adev->jpeg.inst[i].ring_dec[j];
-			ring->use_doorbell = false;
+			ring->use_doorbell = true;
 			ring->vm_hub = AMDGPU_MMHUB0(adev->jpeg.inst[i].aid_id);
 			if (!amdgpu_sriov_vf(adev)) {
 				ring->doorbell_index =
@@ -264,7 +264,7 @@ static int jpeg_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
 			ring = &adev->jpeg.inst[i].ring_dec[j];
 			if (ring->use_doorbell)
 				WREG32_SOC15_OFFSET(VCN, GET_INST(VCN, i), regVCN_JPEG_DB_CTRL,
-						    (ring->pipe ? (ring->pipe - 0x15) : 0),
+						    ring->pipe,
 						    ring->doorbell_index <<
 						    VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
 						    VCN_JPEG_DB_CTRL__EN_MASK);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 581d8629b9d9..4b2e6a033831 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -126,7 +126,7 @@ static int vcn_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
 
 		ring = &adev->vcn.inst[i].ring_enc[0];
 		ring->use_doorbell = true;
-		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 9 * vcn_inst;
+		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 11 * vcn_inst;
 
 		ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[i].aid_id);
 		sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[i].aid_id);
@@ -213,7 +213,7 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
 		if (ring->use_doorbell)
 			adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
 				((adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-				 9 * vcn_inst),
+				 11 * vcn_inst),
 				adev->vcn.inst[i].aid_id);
 
 		/* Re-init fw_shared, if required */
-- 
2.48.1

