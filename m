Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D6DC0218D
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 08:49:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E767310E765;
	Wed, 29 Jan 2025 08:49:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A0XxcvX+";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCD8E10E765
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 08:49:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k88Ki4L98kM6lnBvPoHxucOxtJ/kV2S8udqVEwJjDntObEPn5hnZRoNFLFovnqMVLMvssSuT3fOX1A/KP0bXMXV8AZfAuDFdesee+5rlTkrUGRjL3iN8GjMq449rF2M0ITyyK/9bbZ1dYIq+MwhkUeEWq07cC9PK81GwEdRSPT7YtN8oc64UdAObKSTgTbWOZd09byybDZXYIfEghwH6fnzWrIWIH890+jXd8jg3OPRrMjr4ZpUVAACT0EYXe6pNnB8PFgdquSbQzIkzZUHuMkcPy4LvOZrqiHoVSKdXjOzNOd4NJdTjhC28hbiq+h6UOiQK6zHMpr89cGpIA4jCXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gU9Qd5kJG1fmuvgqZsmQVq9oAKOhhBTrhhfyjFw4MmY=;
 b=hzW/wD5pGf7UTzdRMofi2UGM2om2Jj/bk2SNa8FQbqEK2bBpS4jtAT4l+Glj5C/bIjW/QCljbE/Her5sGiJy9QgpUKq9HAQjYvZ3I2gczJ4IPGaFh8KAnaW5DxK+SLtzXNbSnsd5qi4SXxnNXl+Zx1ksW6yk1ANo1uN963sgTivFYuGt5+cXFmtL2sT2YYLMZCu3fiPwhKzyAXHl4mPIKyDoKYLkwY2hFjcALhcRJXzIBigyYK2xH0uoQlXj6r/AhFmAfZxwGN++Ga2kT8aSehlaquxOG1+EWWEzfMShQMeTkEk2Ijt+jUJKPPEUTbJFKmEvJxnKQeOEnoV9J74hvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gU9Qd5kJG1fmuvgqZsmQVq9oAKOhhBTrhhfyjFw4MmY=;
 b=A0XxcvX+Oa3rwuh/wNdKCz1jSfYyQvU+dE/VMbjtxxCGy6XFP7JIPLn4hNMnRY4ar4R6iCNEXCkdngam4Iz1G3JrSpV8fzKawFvWKIwIdHlY9p5Wuk6laipyuEb3tMwKSMtkST7OWrWdIdllUL2E4uaay7r8t6DrIT1x9wNKorI=
Received: from SA1PR05CA0003.namprd05.prod.outlook.com (2603:10b6:806:2d2::14)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 08:48:56 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:2d2:cafe::2b) by SA1PR05CA0003.outlook.office365.com
 (2603:10b6:806:2d2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.16 via Frontend Transport; Wed,
 29 Jan 2025 08:48:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 08:48:56 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 Jan 2025 02:48:54 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v2 7/9] drm/amdgpu: Enable devcoredump for JPEG3_0_0
Date: Wed, 29 Jan 2025 14:16:41 +0530
Message-ID: <20250129084643.507727-8-sathishkumar.sundararaju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|MN2PR12MB4111:EE_
X-MS-Office365-Filtering-Correlation-Id: ae7e78a6-b0a4-4b43-9f21-08dd4041c40c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWJRS04xRVlTeTg1SE83b2ZoS0VJZ1Y1OXlnSkREN1hlWWUxTmtYV2ltck9L?=
 =?utf-8?B?OVY0Q0dvY3BwSUxidHNNZFBZblBxWm1IZHlBcU1HK0pRNWNoRVlqbUVTTkVa?=
 =?utf-8?B?eUJVTGNCSjN4bllPbTE3NDRXN1g0TWp4S3lHYnRsUUY0clo0V3NwaGdTS2hi?=
 =?utf-8?B?cWU5SS9jbVV4MnpmZ09YZER0VERUQXFXdkw1L216a2x1M2NVTkh1bWRjSzZK?=
 =?utf-8?B?MnpraS9vY05Vam1Jbk5LSk55WkYzNGdDZitUTmh3VFVDNUI1OEdTOEJnajJ2?=
 =?utf-8?B?WWE3UUZxQWk3T3E2NTh5QW9SSk9vSUptSXFRMFJVV0hxSFFaam9jMS9ES0ox?=
 =?utf-8?B?dEEzLzNNN25UK1IyWFN6d1R4V3kxQW9tTDl4b0RRUURQazM3UzdtMjFEMVNM?=
 =?utf-8?B?eWNKUXd1Rm54MEU5YkdmY01rdEFHdkZ5TFFaWmt6VTBtUHdzUXdjY2NncW9u?=
 =?utf-8?B?aitKd2twbGIvY3RWMjdWNnNHRjkxUDdDSjF0THJYMlh2QkhSR2VXTzdoeWds?=
 =?utf-8?B?U0h2QnBxZk53UXRkd21acmducERsM3hzcUxQNmt6d0YxTUhCYk5IaVNHME9W?=
 =?utf-8?B?cnErSU5BOTRZU0VyT1R3VG1ldVpUYm5mODNrcXNucjM0YmpLWkJjYWtxRWVN?=
 =?utf-8?B?OWZLd3N5THJTSUJHL3FLNjlFN1FnSTRnZ1J2WlgzbFNxZlRVdjlaRFU1N3d5?=
 =?utf-8?B?NGNROHVvbG5KY1NsZzlpWWE2UzV3WTAycDBoZ0JqdUh0NE9CdEgrOXpXb3VV?=
 =?utf-8?B?YnhFT2tqdEo5NjVxeWlPWlBCZTRIK0w3Q1VwKytDUitPNFF0aWcwN01ENU9p?=
 =?utf-8?B?a0h0MytGNzgxek43STF1UHpEejZpR0RBZXlwMFNydEVHUmc2bU1qMFA4aXFj?=
 =?utf-8?B?Y1pCUzBJekVFYXNhOXRRTmQ1L2Y3Rmk3OHF4VEtXWWpTcklReDVwUlM5Tlgz?=
 =?utf-8?B?Uzl3UGxER01OS1JCZXRmU0grSE4va0JKZlJkWmxSWDRlaUcyNlFaeTM4a1Nl?=
 =?utf-8?B?TmVyUEhKYTgwSGF5SU9lMWFMZmtjdFRWbUQvTThLaUhjZDFwQ29NbTZ3b0Iw?=
 =?utf-8?B?VWl3OTJwT3R3cUttQjErRVdJWnRqczlidCsxbzFiNWZ3d0lsMUMraitmMG1I?=
 =?utf-8?B?Wm8waTRpenF4RllWVXcyZHJwTEM4RWY4UDMvbnZhR2k2bThseGswNEROMmpX?=
 =?utf-8?B?M0YrUUxleXlGNGlpLzIzQzdjblJUNE0zS0xXQ3BCQnFEVURJbWV0a2lHNVNr?=
 =?utf-8?B?aTU0dHlqT2UyblFwNVduOXFRaS9ZbU10ZEVRR3hKTUhGVUw4SktycnMxemV0?=
 =?utf-8?B?QU1RNFpVNUZ4b3puZ0VCTHFxWGdFbEpaVXpaeWV4OWE0R1V0RDB3VUVFNGFt?=
 =?utf-8?B?cHNCd1F1TUlEbVYzemZBekU3VEI0NkMxaXNPRFBxR0ZMaDM5cGw5ME5YMGwz?=
 =?utf-8?B?aUQ1UGR5bDRoOGd4dHczVVllM2xMdWRVOWFkTzNIUjIxRkk2dk5VemdvK0Nj?=
 =?utf-8?B?Mmw4SzRZSmlSd0xZL3VYbUNoWXJ5MkgrWlhBeC9UTEVpem5CczQ2blFldFBK?=
 =?utf-8?B?c3Y5cEZpVVpqWnkyVDlyZ0NZRTgzeHpKQyswRUtCeVQxc1pRWGdTMTcxdFZZ?=
 =?utf-8?B?OEdQcXVGdXRnNWdRUzl6M25iYitEMlp2Vi9SMjI3QS9vRW5hS3V6ZFlEa0Vr?=
 =?utf-8?B?VTN4WkgwTGljZFQwOXdFMG1KL3R0d1YvYk1UaXI5MGg1eTY3bFIvWE5sLzBz?=
 =?utf-8?B?NzN4MmFiR1kxSDYyejRlWG9QNnIwZ0NaVEplR3VUNUd6dWErU1Z0eUd4dzhh?=
 =?utf-8?B?TStXeVk4MXRSaG9zNjM1dzlLSTBzRlMvZUxCQWJQaVVlaG9DOEhibkwvRDJm?=
 =?utf-8?B?a283NXYySFcvUTNYSWxxckM2SmovWnd2ZnpoU2g3RmV3cWcrdCtwRFNHRHMx?=
 =?utf-8?B?ODNMR3g0d0ZsYXBkUlQ0Q0JvK2JKQ3VYa283dVdEUWxZUkE4K2E4dlh6anpo?=
 =?utf-8?B?Sk94QTFld0ZRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 08:48:56.2066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7e78a6-b0a4-4b43-9f21-08dd4041c40c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
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

Add register list and enable devcoredump for JPEG3_0_0

V2: (Lijo)
- remove version specific callbacks and use simplified helper functions

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 4eca65ea9053..ee5c30f5718a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -34,6 +34,22 @@
 
 #define mmUVD_JPEG_PITCH_INTERNAL_OFFSET	0x401f
 
+static const struct amdgpu_hwip_reg_entry jpeg_reg_list_3_0[] = {
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
 static void jpeg_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v3_0_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
@@ -112,6 +128,10 @@ static int jpeg_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->jpeg.internal.jpeg_pitch[0] = mmUVD_JPEG_PITCH_INTERNAL_OFFSET;
 	adev->jpeg.inst->external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, 0, mmUVD_JPEG_PITCH);
 
+	r = amdgpu_jpeg_reg_dump_init(adev, jpeg_reg_list_3_0, ARRAY_SIZE(jpeg_reg_list_3_0));
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -133,6 +153,8 @@ static int jpeg_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_jpeg_sw_fini(adev);
 
+	amdgpu_jpeg_reg_dump_fini(adev);
+
 	return r;
 }
 
@@ -543,6 +565,8 @@ static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
 	.wait_for_idle = jpeg_v3_0_wait_for_idle,
 	.set_clockgating_state = jpeg_v3_0_set_clockgating_state,
 	.set_powergating_state = jpeg_v3_0_set_powergating_state,
+	.dump_ip_state = amdgpu_jpeg_dump_ip_state,
+	.print_ip_state = amdgpu_jpeg_print_ip_state,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v3_0_dec_ring_vm_funcs = {
-- 
2.25.1

