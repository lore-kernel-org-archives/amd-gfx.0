Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C89BC02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 14:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A392010E563;
	Mon, 10 Feb 2025 14:27:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sDEcYmOP";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 661A510E570
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 14:27:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLbVhoOja9IJlWeslbZdoFca3DQJKgopFkfja/xoMpfzGElf8YK1mBNwCcJyog77tyCE+Q2ca/ejBPCz2MiMm6pyFEFigcHkaU1xh2Yuol9SkWUZgfSjj/Z88fzzs6VM+texfzRghrs81FY4TnzcHzSIby9LVF0oz6m0XcrSMG5nzGrohhk/RIlBoOFekZ7Hh0ShHmJHSQWxuU++fjiJ7max1RIOr31FJ132NvYXyxokibmkwYj6q9u8qlh5jSc5AdZ6EIP9x9Af0oWlW9dv6txo4VfGI1QrazYIefdWNWN+taxa93TCqXiQ5cL9HLSNUdi+lTAxjywhjo2j6SXRAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqxVo3RvY8+sBYnAJhdWjxZ67qGaVaZrKbPkJEJjlzU=;
 b=uFtrXP+F3CGlsvvHTCPiTtF79lXbTxWsuU5ff54EFUpYYF8kbbIri7MD+jlM2GsepCyiQHtNAO2Sib7/VAD9WOPuNliryJELqYBtg6sYJIsAv74dvZHAbAa/NM0Vq56pyanpdHlDwPMu9TT1TH4ktF4UdSrf/uI3M1kR6H8P8jbQDUkGqrGWuaBxBiNkl/Ez4lZ51wcKD8OVTUmVe2CSwCPGpsrqgcciM33LXZwUg/bG2+btm0wKjKouu4SSLSSbN+obsAU/qLZNSnHL/un8k7ReoiObKwwt41cfn/J9yziSb8b1lnu93KongIGHJRf4pdDnNpkiCX4E1UtHlfF9Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqxVo3RvY8+sBYnAJhdWjxZ67qGaVaZrKbPkJEJjlzU=;
 b=sDEcYmOP3SmLc/4gVBtnVCWwknrz3NCZGD8liUkVA7ie6xokzgCvwXU74NX0m3cEBsdrrDbyiqHjPKQLzzhik4JFK6Nq7M7Zjv2BDLagJkypSVgp4r/WGoWlihHq3tav7tijJMedmOMu2MfYqWG3rXt0c4dxJU+p0F3DnOVLo4E=
Received: from MW4PR04CA0054.namprd04.prod.outlook.com (2603:10b6:303:6a::29)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 14:27:12 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::68) by MW4PR04CA0054.outlook.office365.com
 (2603:10b6:303:6a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 14:27:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 14:27:11 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Feb 2025 08:27:09 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>, 
 Koenig Christian <Christian.Koenig@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v2 4/7] drm/amdgpu: Add ring reset callback for JPEG3_0_0
Date: Mon, 10 Feb 2025 19:55:45 +0530
Message-ID: <20250210142548.2321625-5-sathishkumar.sundararaju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|IA0PR12MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 57857b67-9b83-49fc-752f-08dd49df021c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0pNUXRUUC9Lc0I4N0JxR3djSmFuK243QzZzYmlLd0dwMlQ2UmN3ZHNnRTQy?=
 =?utf-8?B?by9IV2VRTmRMTmluRXQxcjBFYmRhVnZkUlhYMmkvUk1xVU1VQUkvNlJWSkYx?=
 =?utf-8?B?T25WcHAyQlczaG1JbFJwQVVraUlsaWx4OExIT1JNanhScSttVU1NYzBRMjIr?=
 =?utf-8?B?anRHSy9LM0pIUFlGcXQrenk1aWgrU0tsSklEeUc2TVd0TmxUZjdGNU0vMTlN?=
 =?utf-8?B?TngxMHpVY3E1M2IxckRSK0IyNkRLdU8rajlMelVmcXRaazNTQXZKOUNCU2FL?=
 =?utf-8?B?cjBzamtaUzJRM2hjWmQwQk8rSjNoN2ZZYW1xOURMMGRXUmNqR3Z3Y1lsamlq?=
 =?utf-8?B?ZHZNTGlLaGVmdDNCUEZ6a3dsNGszV3k3SldMZHFTMzBCamFtY3NSajl4Rmxv?=
 =?utf-8?B?WEEya3NKdjNwWDZlRi9wOCtDVjJIUlpoRDNBZFlTYjlIYys4RzU0Y0lnNko5?=
 =?utf-8?B?aVd0VjBSTldPM3ZQRWlLUkhtNkxjL3VBaUllNm4yT1lkc0pTdjFUZ1ROM2Rt?=
 =?utf-8?B?ZFJjcnVPRmJVZ3pzVTRDRW1vL3hlM2hZb3FXWmJFZTZmN0NGZUtEL0dFYXNE?=
 =?utf-8?B?WkxCanlvVTRVK1lRcWtNWUdPb0ZzZVIySVlWRFE1M2svMGVlaHIwUTV0MkJB?=
 =?utf-8?B?c1hRcDNSb0pwdElpc0xEOW9XaEdhK2NrNitaUTF1eVZrT2JwWVhlY2Vub1Zl?=
 =?utf-8?B?Y0tQTUwrTnhrcEVCa255TUtBWDFyUEVKRDQ4ZjliVWRnSWNzc1dJQlJNSDNn?=
 =?utf-8?B?SUxUV2cybm85ZFBPY3ZTUnkwWEZPbkdRaE1Jd1dkVW9XVkxLOFVsY1ZTbk5Z?=
 =?utf-8?B?bU5FUlJRcWthRDdpcmJwNjdBcFRsajU0am05WmJqUFBUOEVmc2kwVWhZZEp1?=
 =?utf-8?B?ZkpTdnZMeEc3dW96dVVWNzJCVzUyKzNNY2ZIbStBZ080bWlHT0lBVU9DRFNo?=
 =?utf-8?B?VFBJSGZDbjhIdFVYWlo4UEhlZHF5OEVSWEd2WGsxNlpDUUIwUU5lKzExenE3?=
 =?utf-8?B?Y2pPVnBMbVlTWVpWRVJvVHV3cEpGdVVycXAxRk52d2lrTk9PNFlNYW1SaGhr?=
 =?utf-8?B?ZFZKRDlONGdXeU51SnhOSG5oczVhZ2dGb1pjU2RqVVBoeWZYNUJWdTNaK0hm?=
 =?utf-8?B?SkNvblBPMW1la3k2NU5jNnNyVTVxdXNrUVIwMW1uV2s0SDFUeGhvM1VxYzlv?=
 =?utf-8?B?VmR2MHpySERCUGFtS2ltTlRpUyt2c3JXMkdqL1FyWXAzZ0ExUTdqYmNiY0sz?=
 =?utf-8?B?WGJpWDh2WXgvaHJNQmdoWmNIWGc2aVlwNmFEQ0o1Z05ObkcwNUlZak9oWXFF?=
 =?utf-8?B?UFovc0c5d1R5RmNRbWZXa3pIYTdHTFArYzNVUFFHbE5qVHVmZE80WWFaRG5x?=
 =?utf-8?B?UDl6RHJ6ZmsrNFMreVNqVlAzdGRHa2xNc1V0VkV5QnhwdnB6a3BwRWZoTXls?=
 =?utf-8?B?bjlpMWRhNTQ5b05JMlo5UGxGYTZmK3YwSG9WMUNMOVhRYm9jU1Q5OFlMajZ1?=
 =?utf-8?B?WVZVL1pUNDFFeEdWYklPZDc5MFpUdU43MWI3aDhSS3dpbkJ6M2xSMk0yNEJu?=
 =?utf-8?B?SksrbFV0Wi83OTRGSlh6Qk9BQ095aUp6ais2U1JnSVl3QmN3Nk84S1Ixb09V?=
 =?utf-8?B?LzFKVjJmbm9WRjBoTE8wZ2FkZjVKL25xNzNIbUdCaUZUcmprTDBORjBnclF6?=
 =?utf-8?B?aVlGL2lxU1FFd0trZGhYM1p2Uko1V3I5NHFlSmNNUlJDTWI4c2hxVFRHRE9B?=
 =?utf-8?B?UjJ0d1FpZTVLdTJhZGIwNm5Fcy9GMjJ4STlZU0hzend0cytwekY5cXIyRjB2?=
 =?utf-8?B?UWZwaGVMOVZKQTVuazlsODk5VlZwZm9OZWk1dGdpSTcvRWtoaHdlZmhnS0RI?=
 =?utf-8?B?MUp2dU9OL0JjaHpmSGkxNlJTRUlxNzhKNHRoNXo3dHN0eWpscHlxUmR1dXJK?=
 =?utf-8?B?UFcxVUxtQmI1VjlkQ3JJWFh0OFhQQWZpclg3QkZ4MUF1cDA2bHVvS2tFM1FC?=
 =?utf-8?Q?5bZznz/DMD9Q2xPlUOw4YykLUvxS+k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 14:27:11.6869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57857b67-9b83-49fc-752f-08dd49df021c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7697
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

Add ring reset function callback for JPEG3_0_0 to
recover from job timeouts without a full gpu reset.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index a4acb7cb7ea0..7d6f0b0e3566 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -132,7 +132,10 @@ static int jpeg_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	return 0;
+	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
+
+	return r;
 }
 
 /**
@@ -151,6 +154,8 @@ static int jpeg_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
+
 	r = amdgpu_jpeg_sw_fini(adev);
 
 	return r;
@@ -550,6 +555,16 @@ static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	int ret;
+
+	jpeg_v3_0_stop(ring->adev);
+	jpeg_v3_0_start(ring->adev);
+	ret = amdgpu_ring_test_helper(ring);
+	return ret;
+}
+
 static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
 	.name = "jpeg_v3_0",
 	.early_init = jpeg_v3_0_early_init,
@@ -595,6 +610,7 @@ static const struct amdgpu_ring_funcs jpeg_v3_0_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v3_0_ring_reset,
 };
 
 static void jpeg_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

