Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009E7C02194
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 08:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63B6A10E770;
	Wed, 29 Jan 2025 08:49:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kv90fTvO";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0355B10E769
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 08:49:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEMqFllJVuQTaVo3uAZdjd3FWb+vHlrjTRAedsWeua/qyMs+0QRTYm0SEGPdVlr2arOiwQc21jENGHx5MBuuC3JVl9b+D65BQ0KhCeuOjrPmB+CiFma6RPT4iRTvvYD7BIx1HSaJ5Fs3Bc2Ju+JkeCzSvS2w3d0wzltT5JtzRPMWzsNwhnsmo4KM2/fOFuygskXsbjtjj9F3e52PbJCfAyzs2X4mrzayS5AedEMYFMnnaKcgvR8qqrOxHj16ykPAoUmul21u1ZvoEBv5jTJN9UKw+M/NHRPodYgr6rytUKuSoWrc25aOAK0v15NJF21OtDZkmHcVzyCciff3gkKQzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=In2T3RlhATt1bcERf801htoF4n7btoBu0H9NqOIcdrY=;
 b=FhhoNpgiLqaUr7U1XWWT5bIpw2605og2P9QLoRABkJi+qYHpQ2vDSZ+kjW2nQSm6QTZ7FhModJnB0r6+J+1Rs+7pgET22XhzGr9JJbDr5mhvF4XsKz+AUb/W15+RroavcmG4DUmeTPJjb1HZRE0ZYBPamVjvqXjBpepXRvDZdOLCGJ4hfayomye+ncmdbbUjUCwiRoEP1Q7+nU+fSg+v9prvmgINu5RzTyuRP9KVpqXd6GnSGBwf0l/FDk0dfFlHcdpYb7aiUU3z0BQ1psJZ822VR9bjwbJq48c0jOxyStxHfdW3wtS9pzSLGsoarMvAkuhXI9aqkC0bmP7F3yZbrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=In2T3RlhATt1bcERf801htoF4n7btoBu0H9NqOIcdrY=;
 b=kv90fTvOFOuJaZZZrIncui5HqX4SqlCTeoDxohcwQjYe9Akwe1SDaSzLxcoIOeyYWmbZlvEl89iEyp3/lq+mBtUPdWivY8xWcLopwnkMBn4b94+oBxgoIydVe4oSsSrtGcQQAT0cDysZ1LQ1aVZxjCmMRLN4xq/QSbArEgTZRe4=
Received: from SN7PR04CA0157.namprd04.prod.outlook.com (2603:10b6:806:125::12)
 by PH0PR12MB7816.namprd12.prod.outlook.com (2603:10b6:510:28c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 08:49:13 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:125:cafe::aa) by SN7PR04CA0157.outlook.office365.com
 (2603:10b6:806:125::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.23 via Frontend Transport; Wed,
 29 Jan 2025 08:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 08:49:12 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 Jan 2025 02:49:10 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v2 8/9] drm/amdgpu: Enable devcoredump for JPEG2_0_0
Date: Wed, 29 Jan 2025 14:16:42 +0530
Message-ID: <20250129084643.507727-9-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250129084643.507727-1-sathishkumar.sundararaju@amd.com>
References: <20250129084643.507727-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|PH0PR12MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: 818e3ef7-e9c1-4c7f-2450-08dd4041cdb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzdxTlBZSERKRFhXMlBlaVNzTVhQTzhkQWh1Y3NPWk04aGxDVVQ2VzBhb2JJ?=
 =?utf-8?B?YmROQTVyYnZlOTY3SFE3Ujh4alFhc3ozYnRudjZlSTVlQ0hDcC8vRXF0SU5z?=
 =?utf-8?B?NVExcENWaXNPOHlkcFFRKzJod2x1a0RXNmNTT0VqOXJvMFJZNmNURUtTMUhR?=
 =?utf-8?B?UW9RZUZSMFkwVGhjcCtoSWdqUXN3aXZMK0VnaHVDbGdweUlseFMwai9oTGtY?=
 =?utf-8?B?cFhYTXVCRFhSa0pZNTRXdmx6TjZwbndEWjVLck9HL05sVHlDYVJZMlRQUUFa?=
 =?utf-8?B?MDdONHBxYlAzek5DOEwvUTdlbEZRcGthSjNuc3h0OVFURzFBR3ZzSzZWVVZF?=
 =?utf-8?B?OEY2a2YwajBwV0ZCOGVXYi9zWVk1OUZDN1Fad3dib0ljelZKZXlBbFBSdWdm?=
 =?utf-8?B?WmJKMjZuT24rems1ZE5uQTNDcjBpNWtCTE0rNERWaDFkNEVpMVA2bGhWc2hQ?=
 =?utf-8?B?a1N4RCtYczBZUlJXRWl5ZFBiYlpLOTlUVk9xb0RuV2ZSRG9jeDlKWWlGenpE?=
 =?utf-8?B?RWdXRnBhSFJtdnBWem80K1ZoN3pUQkpxYmJUUkZpTjJSNXlYZ0dWVmN0dVZp?=
 =?utf-8?B?L3VZRUVzMGRGRU44SzZIWkZqWjNZeXI3QkdvbE43enI1SGhjVkozVDBsT3dm?=
 =?utf-8?B?dktvejJ4QSswMllrc3Uxcy9lcE11L1JrREtQUm9BWXFVdHVscW9zSkgveW03?=
 =?utf-8?B?YVBVWTBHbnRUdFZ5NU9QdDFmWkxWTjVPZysxcVZEZ3g0aXIycGV0bHhVOHFw?=
 =?utf-8?B?VXJDV0pDQlNFdkZDZ1RuSVpBcnpDaEdhNnBldldDODVweS9sZklYMFpEQTM1?=
 =?utf-8?B?RTVCMmFCWnp6MTR2d2djeGQ4ekIva245NXJ5UXFRT1pHbE9UaWxhN090d1Qv?=
 =?utf-8?B?Q3VhM1Fhc21jVnc0MDRML2w4aFRjejVXSk03L2xBREJmaGw2SkM3N0NlK1Uz?=
 =?utf-8?B?RnBmbTFOclZNa3dZckVqTk9nSlh6alp6OU1YakQvQ25vdnhvYUJ0UFE4YmRn?=
 =?utf-8?B?QkNKYUNaRW1XdXFORERQM09KMFJSRk1BNzVuSkJkWldzRGFQZDdVenI5ZGtr?=
 =?utf-8?B?eWtVeDRCcnpLOUJQOFI3MllFcnBNSmFqTmVKK2cvN2U1cVk2Zmk2TTB4L2Iw?=
 =?utf-8?B?dmRUdHlDbm9KRitYTWcrSnNQZllUMXNxZ3BZbTBKcUVKYjN2aE9BdHp1V210?=
 =?utf-8?B?QTl5N1p0UGp6eEJJdWxjN0RQQjIyTGR6cU42M0JHQWJGaGNqWVZQYW0yVXk4?=
 =?utf-8?B?NDE5cG9UOTUra2Ywb3M0MUlrZzJXT0F6NTJEaFhTMmNJdlNBMTBuUVdEUktr?=
 =?utf-8?B?SXV2Z1krS0t1eDNlYS9Gc0k0aGl6U3ZuU0dKVlF2MWQrTlAyUExXak8zYmNy?=
 =?utf-8?B?RUw3RHBOT3EwTXBxTGJTNnlldlpoQ3N2SGo1VFZPREtUMFprVHN0MDBpWW1O?=
 =?utf-8?B?Vjh5N3VRL2lHdFNJRm9MOVNabUQvNWEreWxsZDVmNm1NM2ltSlQzVk1XUTh0?=
 =?utf-8?B?dnpNbjIvaWcvUHRuUEhzN2llUWhHbFFxZVcwSFoyTWlNV2cwVHROWFhPaFI5?=
 =?utf-8?B?K3FCWThGZ3BmalBaY00zM1R2bUJiY05ablJwTG5nSnhTNVJvMW9QUUxZWVJO?=
 =?utf-8?B?bkFvZEZrYkkwbU9NUHVnWGlpQkMzZkNKQWtTaW41L1VXeDlRVjB5ZXhLTWdr?=
 =?utf-8?B?djRibHhxQW5mZHE2cmtKUCtVYk82dXBtOTZob202aUF6Rjc3cTlJb0tzYVE4?=
 =?utf-8?B?VGNIdzl2NjdOVW9iM0VtbGxZQWIrckRKZFNyMEF4V0ZoR3I3UklTa0tydFM2?=
 =?utf-8?B?aTZHb21RNHp3TEpqWkNVMGZpRkpYS2JKL0l4UGlXUk91KzNENkU3dmxwTDVp?=
 =?utf-8?B?bWtnbEx0MUM4dC9EV0pLTVpJZHAxNC9sT3o5RlBwakJTTkJIUllQQm5hMFNY?=
 =?utf-8?B?WUlTNFplVm1nbUk4NjA4NUpPUFZPVmpyNmxaditqay9zZmEwVWlIWjE2UllX?=
 =?utf-8?B?SWJQSUp4dDNRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 08:49:12.3818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 818e3ef7-e9c1-4c7f-2450-08dd4041cdb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7816
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

Add register list and enable devcoredump for JPEG2_0_0

V2: (Lijo)
- remove version specific callbacks and use simplified helper functions

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 7c9251c03815..29bdab1c50c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -33,6 +33,22 @@
 #include "vcn/vcn_2_0_0_sh_mask.h"
 #include "ivsrcid/vcn/irqsrcs_vcn_2_0.h"
 
+static const struct amdgpu_hwip_reg_entry jpeg_reg_list_2_0[] = {
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_POWER_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_INT_STAT),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_RB_CNTL),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_RB_SIZE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmJPEG_DEC_ADDR_MODE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmJPEG_DEC_GFX10_ADDR_CONFIG),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmJPEG_DEC_Y_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmJPEG_DEC_UV_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_PITCH),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_UV_PITCH),
+};
+
 static void jpeg_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v2_0_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
@@ -98,6 +114,10 @@ static int jpeg_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->jpeg.internal.jpeg_pitch[0] = mmUVD_JPEG_PITCH_INTERNAL_OFFSET;
 	adev->jpeg.inst->external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, 0, mmUVD_JPEG_PITCH);
 
+	r = amdgpu_jpeg_reg_dump_init(adev, jpeg_reg_list_2_0, ARRAY_SIZE(jpeg_reg_list_2_0));
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -119,6 +139,8 @@ static int jpeg_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_jpeg_sw_fini(adev);
 
+	amdgpu_jpeg_reg_dump_fini(adev);
+
 	return r;
 }
 
@@ -752,6 +774,8 @@ static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
 	.wait_for_idle = jpeg_v2_0_wait_for_idle,
 	.set_clockgating_state = jpeg_v2_0_set_clockgating_state,
 	.set_powergating_state = jpeg_v2_0_set_powergating_state,
+	.dump_ip_state = amdgpu_jpeg_dump_ip_state,
+	.print_ip_state = amdgpu_jpeg_print_ip_state,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v2_0_dec_ring_vm_funcs = {
-- 
2.25.1

