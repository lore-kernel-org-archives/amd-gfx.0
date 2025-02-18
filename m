Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD1FC021A9
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 03:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18A8710E067;
	Tue, 18 Feb 2025 03:09:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ffGbMCRw";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 155B710E067
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 03:09:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCRke+zhJYsRg16fYsVBcuR1lvDQjNaHz5p/Tw7k8MEl6H3Qtgc2jj4bLi7VuttGOLnIIv4Eg2q62t0ChCzGIa+O5YPGgxJW38rAHs5+LQI4760bZErXES0XaQysp5RZyU/Lp7hD+xtjJMrsUUahi9JezHhwY0Q+9atdyNJWeR91/C1v/2wXcbu5eLkGwXTgX1Dsm1/BS4tO1Rvyoe7R8dtcnMVVRc9iV/5KfD+J5kRGA+KjqvyIGJbGQyND2rUVj6qtZMZHRnsoW3bJKsVi0jQDfXQsBXx9kUMAJKc7tqoOpK6SmJ5RuztD1Bipa6TBWAcuXFFXx7d6DMlz3PR0Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hB6Yt0VycUMt3OcWUFE2n7tgw6BvKVbreB/Je7rc9cw=;
 b=A+K936pqPuDtD7QC6otMXhccWQyb1p+o84Tu3paxAXMUaszex8wRa1z9TzxwJJkX8XnXQ6MwDezIDGJdMtP9RSw0PzNl/Fnztb6kqLHUX5J4hQHiIJeWaMZ/ccEFx2V5TnjQLE/QA/aNduHx1lk6hfIrTyUVTH2ucJaOXadRiu1DopklO+RA9hT90tcBG473Vp0rg/udy86XhODT2nhVZcdA4b6b5Mb3RpuuU8tGWJMaj69PnfKDUCkdVGFidukmPuc4wh2cgbKm3+Lj6wEj5JpncIOCyZWJu5el+ILnFNkPBSdmM3A34Wej2w2cCqmUYm6YsR/5XdyRej3yVN30rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hB6Yt0VycUMt3OcWUFE2n7tgw6BvKVbreB/Je7rc9cw=;
 b=ffGbMCRwSK5AqAgXB8MjRrDDTyOVrYt2xht6hhkxZkp/BQTu1iZv/y04838n4bIWu1dJ6yA+DSsmmFGjV38VYTfsS7RSrUP5x3zVGUU/ePwXpF4zK5RvLzHMp9abU2DrzqtNhPteUonacv61N80A+eCru00+hhlF5P0KCgRmCaQ=
Received: from BN9PR03CA0909.namprd03.prod.outlook.com (2603:10b6:408:107::14)
 by DM4PR12MB6422.namprd12.prod.outlook.com (2603:10b6:8:b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 03:08:56 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:408:107:cafe::e) by BN9PR03CA0909.outlook.office365.com
 (2603:10b6:408:107::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.18 via Frontend Transport; Tue,
 18 Feb 2025 03:08:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 03:08:55 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Feb 2025 21:08:23 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Leo Liu
 <leo.liu@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu: Add ring reset callback for JPEG4_0_3
Date: Tue, 18 Feb 2025 08:36:52 +0530
Message-ID: <20250218030652.2472681-2-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250218030652.2472681-1-sathishkumar.sundararaju@amd.com>
References: <20250218030652.2472681-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|DM4PR12MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: f36d3da4-b1c1-4362-35e1-08dd4fc994c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUhjUGNBekVXcDgyS0gxV0JNcTJvSkVYMkUwZnJCbEk0dWhRaU1ld1VLVTZE?=
 =?utf-8?B?QTNNUG4zV2JROVgvTldoVWVvUmtQQ2VPalhpNUVISjkwNHdsZllJc1p1YXpq?=
 =?utf-8?B?THBRS052c3lzYnZzTEJWdkZ3L29UQ3JxWmJpdGZqalJIajQxNmpkeU5vSTNv?=
 =?utf-8?B?cysxRUgxNWd2VVJ2WHBtOEttOGl1eVZvT3FqV0xFL2RJNlNzblpVVzRSbzEx?=
 =?utf-8?B?bGgyU2RoT3l4c3ZGYU5kZi9IdzFEZk1jT1pNRHUyeWc2eVh6OXFzYnNSQXNZ?=
 =?utf-8?B?cjlWVXNOVUNlWVcraVB4bUlTdmRrSE9GVHBQYXZ3UnBOV2wwSTVGM0tJSDRx?=
 =?utf-8?B?VFptNkRyTlVzNmM0ZVBIcThxRTY5UU5zVWppVEZuNGw0WW0vTExsTTRTN3hR?=
 =?utf-8?B?bjU0RGI1YXVTU3RTaUQyZ2NMSFZxQXNpaHRFNlQxU1JJTHVvZlZXYS9sZzlu?=
 =?utf-8?B?NWlNWExDeWVGaFZoOHBFU3BUVkpXS1ErTDIzZ1Baa0NxaVUrN1Jib2Z4elhr?=
 =?utf-8?B?Zmdub1RWQS93Nko4bzRmU3hSQ3FWSlVVYTdYd3YrQ2FKaHpQcmJXRXNmeWpk?=
 =?utf-8?B?eC90UUI5dm5qd1pzZ1l6UzNVL25nTjFYUjZBaW1NTVY3M1NSZDM0Z3dhWWFC?=
 =?utf-8?B?czQvbmw2L3NhbzBvUlNBUlNiNTlURVdSRlJBNW1ydk9ZL3NuRjVkcXBDSEo2?=
 =?utf-8?B?eWd5c1A3WW5pbmtONlhScE1BbHU2dEZWNU5GaVhwOXVUbHlrZnBwVDdEdjlJ?=
 =?utf-8?B?cUFDOWhEK1BJM2FaREJyK2F3cGxZYThYcFpNZE9KeklBbmdnU0hRbkxRQ1Fq?=
 =?utf-8?B?eFk5QzBmTmE0d0RJUUFIbjFiUWNBczQ2eDNVcTZwUlNoYW5zbVplVVlMeHlk?=
 =?utf-8?B?M2JPSlo4R09SS1NlNUJWbGVkbkwrRnlFTUtQMUMvU1MrRE1ldytoaitoTHp4?=
 =?utf-8?B?RWd2akRYam5qOTNqMjFJaGhjVkViZmxIa3lYQVZpa1MvTUFqakZnZytBRmN1?=
 =?utf-8?B?Q3pqS1dVRDJDOHBjWWZoYlJZeGZsQ2FDTitmTnAzSm1KKzZIZzRqK1FBUkJ4?=
 =?utf-8?B?RDU0a1oySDBBdDJiNDZyKzgyYlJtWlYyMzYwTThUMXJvOGlOUnFEdHRFaVJn?=
 =?utf-8?B?WHByVlBLcHBqWG96SEY4bWRqTGJrdmNYWG9yeXM5ZGVubFZ3d2d5cnBNak1M?=
 =?utf-8?B?VlFIWnB6OWJMUU9NdHhPR3M0YWp6NnlGZmY0aGNMOHQ5b2JHcmVNM3l5dktQ?=
 =?utf-8?B?MkJkMFhCY2JMY3AyeVo1OCtnNytmNXFGZEJIdXR3NmlITS9KOWxQNTFNK2ZN?=
 =?utf-8?B?VW9kWENFYkUwUzVLNFVWd3ZVait0YTF4WC9qbldBRUdJQkp2WVlVTmpoOU5U?=
 =?utf-8?B?K3ZpS3RnckJIS2s5ckRKMkMyQ3VxSFNEQ3FpQTZrYzd3azRrWTgwc0RSRmRh?=
 =?utf-8?B?ZCtlNmR1R0ppNDZ4K3gydFhzVitpMDFuZUhpd0Q2em1CemJLY1JtdzJ0MWda?=
 =?utf-8?B?UmYxZnBVSEZpOUY1R0hwOURkK2FjQVQyU0RiM09Ca3RZSjNXUXZGWGovS2J5?=
 =?utf-8?B?aEpUS0RtcDBSR2h0YkFHdUZQUzhuVlREVlF1cGw4cHkzOFJ1bVdTQ2xFSjJm?=
 =?utf-8?B?R3UxVTI3V3A4RlI0cWVNTUpITG9YTVdmTnNoWjZJSlJYTERUN0tQeXA5ZVp1?=
 =?utf-8?B?OE12VEx1bWxTOGNjdUhPQkpFNUxuWFJsU09GOUlVbXZxOHduaDE4R044Z0Fi?=
 =?utf-8?B?UjhJYjd2WUZkRUNoazV3K3JUMk5Dd1hmWmtqMGhYeTVhbGxmdjlZVkVOaDNk?=
 =?utf-8?B?SE8vSFhOTnVnTUFNR1RvL2k4OHVWWXMzU05rUGpDaG5raHZGVlJ1TGVjYmRR?=
 =?utf-8?B?SEZRR3BoWUZ1RGFXRWxTWHpWMEtoam1yS1h5a2dWbEZYcGptdEZIeGx5R1l6?=
 =?utf-8?B?aGIzYzV2eFRKVTM4SWI4WjF3b1IxUklDeElTTmI1SzF1STIrUVlwcEtDTTFa?=
 =?utf-8?Q?Bvxyf/1GDAPuKVMxlHav+KT+04O9/o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 03:08:55.9023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f36d3da4-b1c1-4362-35e1-08dd4fc994c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6422
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

Add ring reset function callback for JPEG4_0_3 to
recover from job timeouts without a full gpu reset.

V2:
 - sched->ready flag shouldn't be modified by HW backend (Christian)

V3:
 - Dont modifying sched/job-submission state from HW backend (Christian)
 - Implement per-core reset sequence

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 49 +++++++++++++++++++++---
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index c67ba961de91..f10231c22c15 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -204,14 +204,10 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
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
@@ -231,6 +227,7 @@ static int jpeg_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
+
 	r = amdgpu_jpeg_sw_fini(adev);
 
 	return r;
@@ -1099,6 +1096,45 @@ static int jpeg_v4_0_3_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void jpeg_v4_0_3_core_stall_reset(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int jpeg_inst = GET_INST(JPEG, ring->me);
+	int reg_offset = jpeg_v4_0_3_core_reg_offset(ring->pipe);
+
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JMI0_UVD_JMI_CLIENT_STALL,
+			    reg_offset, 0x1F);
+	SOC15_WAIT_ON_RREG(JPEG, jpeg_inst,
+			   regUVD_JMI0_UVD_JMI_CLIENT_CLEAN_STATUS,
+			   0x1F, 0x1f);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JMI0_JPEG_LMI_DROP,
+			    reg_offset, 0x1F);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regJPEG_CORE_RST_CTRL,
+			    reg_offset, 1 << ring->pipe);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JMI0_UVD_JMI_CLIENT_STALL,
+			    reg_offset, 0x00);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JMI0_JPEG_LMI_DROP,
+			    reg_offset, 0x00);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regJPEG_CORE_RST_CTRL,
+			    reg_offset, 0x00);
+}
+
+static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	if (amdgpu_sriov_vf(ring->adev))
+		return -EINVAL;
+
+	jpeg_v4_0_3_core_stall_reset(ring);
+	jpeg_v4_0_3_start_jrbc(ring);
+	return amdgpu_ring_test_helper(ring);
+}
+
 static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
 	.name = "jpeg_v4_0_3",
 	.early_init = jpeg_v4_0_3_early_init,
@@ -1145,6 +1181,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v4_0_3_ring_reset,
 };
 
 static void jpeg_v4_0_3_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

