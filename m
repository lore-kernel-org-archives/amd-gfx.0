Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D599D1CA38
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 06:36:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A8F410E51C;
	Tue,  5 Nov 2024 06:36:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NAalhFmv";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 528FE10E51C
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 06:36:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvN6j+U27PQpHs7I7ZGXO7SBBkgEsWu2ROaMjn7Kyvc3ttEg2puyJ9umSB1IKh1W6KAvMnsPW0tl8QQzfHsRV5xIh7F6cs5dqxNRCRF081ew1FC4RUmE3E3mGg4sLOFoc2B36ZTKja0QygrzoP2PMquKE67KEKN7OwLs/SUHOFHNshh8QmlQsjmnQ5gdHdqaFZFHWinu22mUVHr4v+VEp1vhUIRbQnarKUntQ4wBjE371nlbr9WLNDxiKJIH+qzZjBLAIvqVK4ETtGAroVHbK35AcPfLIbhhf+NkWGzsfX2rkk7iSPmYSyyz6taA1SdDC/E7cOUL777FpTqa8snwKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTyMIhDx19nTBzJ1d403lwn8pTYvkQOc2mtngAemgRI=;
 b=NgsFMZSQvCftJZeYYKqS3mSojfHzCl8YEtOkz8YPxRWF1hLJOkw1JTN2b9mizLAmvpbg9C4QGRtI0DLpZStQ6CHZbrLou0KYCJFj428HBB1aVRbr4GN+avmkLjeRgTI8H824T18R0BmHW/X7yl6MknqIb2dvBRGX/l72wZdkaJLwpG1FqPvbDuad7FY+6d255/Obo1oAAmtap3lW29leYw9xyAf34GNM6OXowRIQYUkjPFfXlsRv0/LSfRoZe7IY9On8FuC1cJ2o1XXwUwOSU6ZEJB19fR/5tNHxge061uuwlux0mC9VhOCC3m8INCOZr77f+xPeK1PMY38tjCHjyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTyMIhDx19nTBzJ1d403lwn8pTYvkQOc2mtngAemgRI=;
 b=NAalhFmvMiBX0ddBgNavP8AkINHV2xfRqru2DU4jzSdUuIhZQ1xi9mrWXOa4AslVnabdjJ4bybj6tqj2Red8h+dLhx+g1qM8ljn40Lk+HaX8qCySme8lxXTxsOqh5Ap45rqv5iVj8ajqSjdoePbRNZGNi9GdOAYXeaHJCOgKku8=
Received: from SA1PR03CA0003.namprd03.prod.outlook.com (2603:10b6:806:2d3::14)
 by BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Tue, 5 Nov
 2024 06:36:31 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:2d3:cafe::ac) by SA1PR03CA0003.outlook.office365.com
 (2603:10b6:806:2d3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 06:36:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 06:36:31 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 5 Nov 2024 00:36:29 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH] drm/amdgpu: Normalize reg offsets on VCN v4.0.3
Date: Tue, 5 Nov 2024 12:06:12 +0530
Message-ID: <20241105063612.519691-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|BL3PR12MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: 559e85eb-b906-4717-997b-08dcfd642f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a25QVWxvYThML0lQdWo3aEF0UjJCenRoRDJFVUJJNzg2MHBWZSszTGhtWWw3?=
 =?utf-8?B?ckxqNFZ0ek5hSjB6NS8zS2ZldDF1ZU9SWTBzNS9sckd0azErcjJVSGhEbkdI?=
 =?utf-8?B?WFh5V1V4NjRXRVZmN0I5N25hdXlKMGVwSTRpVGZCTDVuR3FhL2VRdlM1OGJL?=
 =?utf-8?B?Wk5Fcjd5WTB6YjdKYXFMWXk5ZHBMbmE1TjNHSjlmdUN1U2dLcFFnVCs3STJF?=
 =?utf-8?B?UklkeU5zak81cW1SVFdlUkVGZDNqVDhIVUM4aHpiTHdtZFhlQlFOUWtON25G?=
 =?utf-8?B?ZVlqVVZKdlFxbmF6L2JnVVEvaFh5Y281ZDZQUGQvNjlwVm5DV0VtVDFKdFZo?=
 =?utf-8?B?ZnNGYi85Q2xNdUlBam1yVEkwTXdqWkl2Tlpyemk0bFZJdFdpYnlWOEZsdjVR?=
 =?utf-8?B?cm9yd001QTgzVy9adk1manlPRm11SXp0R3gyVkxUQklPL3Y4UHkxbFgxTkdh?=
 =?utf-8?B?MWpscTQwSHU3UTdKeWcycWxqN09DSFRLdW9xc2FWVGRkQTRNdUJPVTVtclA5?=
 =?utf-8?B?V3RGODNsVDJYMjZ0ZVJvTm5OcEF1OGRTNStRMlBYSTI5eTV1MlpBWS83SCsr?=
 =?utf-8?B?ZW5HQVNBOUpHSnBxUDVNYlJoZEI5QmQvU3hzcm8rZEx5M05Ud3d2MmIrVmtp?=
 =?utf-8?B?ZWFSSGxscWEyOW9Wcmk2Tkd6cGtDM2NQU3p0eUc5dm5qa04zMmFiZ0I5TEtG?=
 =?utf-8?B?OXR1U3VJcE1HRkxCVEExQUtNbTNER2wvRjlSKzBhNnF3c2d4aDU5cFY0Nk9S?=
 =?utf-8?B?NHF6ajZhRjZPYSthSUtVaENIcVhTZWl2ZUFHTUlJaG9TZlJWL2dRUkViYjJM?=
 =?utf-8?B?V3p3RllreGdGVFlUcHJJZVF3R0hoMkZZVjZyM0xBY2ZOMmt2OUlYR29GTlpC?=
 =?utf-8?B?T1BzZDMzbUUweE5SbGtEUzB0UFVpUkM2ZXhDVnFOQ3h4ZEhxN3VPLzFkaGMw?=
 =?utf-8?B?U0szOTZEM05hc0UyRlVETTkzREFZUlN6elAwRFBJZFhOckhwbXZTNDAzWlF5?=
 =?utf-8?B?MEpXSVZBTlEzM3ByZHJOeURoeHRhV25NSEtyd3RyUVhnN0Y2WnE0UWgycnRp?=
 =?utf-8?B?dmJRL1RzZG5La0lnWkxhMjRVRXhjR085YVJQTFFGTks0QnNBa2xqbldDWDNS?=
 =?utf-8?B?dUs2TWUwVVhNRDBMdXJrR25pZlE1Q3d2SVB4KzNFZFJsU3MxTGVBbTVFdnIx?=
 =?utf-8?B?eWJnTkxDOWNnZVVnT1o4TmJURUFYUmo2dVZScDJhL1h3ZWY5RUNBemQ3YnNk?=
 =?utf-8?B?MnkrbnBqMUhWdVdxUkd4V0N2cTEzVlo0QmkrdE0vWGY1SFRuU295YnFBaXlK?=
 =?utf-8?B?bHVvQi8yRkVzUGZoT1VOazIzcmVXSmtwdEVMRGZvaVptTXpDd0sxVWEvbnF6?=
 =?utf-8?B?ZmV0SkRsUEVRWDRSTVhqOUh1WFk3ZHVQNnErdVJZWlowbEpEem1HbXpWT3hL?=
 =?utf-8?B?eUpoY1hzaE5NUnpnemgwRWduT1FjNUdVd0lGYXIzUGhYNjBuNk1ibDVTemxn?=
 =?utf-8?B?V3VXVkpMaFNvSWswWU9uMU1qV0hrU0M5ekN2OHBwVmhkbWdOUzlpazZNV1Fk?=
 =?utf-8?B?SXdCUHdvY0gwSlo5M2luei9MU1FIdzVXMDAwRTJlenpIZDhLc1ZWK0psLzVZ?=
 =?utf-8?B?SlQ5THd2OXJHbzAvV3RQT2NEMGVSUklIdVM0RDBIUVFFcGJYSkJ6bFFVV3RO?=
 =?utf-8?B?OG9VK2FuYU9tc0c3Vm9oZStYTVNlZW5FMExsRHRobFNpdDFUOWtSUUxaRUor?=
 =?utf-8?B?QlZMdUU0aEsxdUtCTFJnNFZ5RFlFQ0VTU0pybllnMWhncjVYT1VsUjdha3Uw?=
 =?utf-8?B?VEt0L1QxTXFZMEtkSHBZRndzeDFKM0lMdTBJelhjdmlvaWxRczV6a040bXJy?=
 =?utf-8?B?NDN3VXpHYkI5cHU1TnRJdEFnM0NNeXpIaERIaG9FeUlSK3c9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 06:36:31.5418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 559e85eb-b906-4717-997b-08dcfd642f8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6571
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

Remote access to external AIDs isn't possible with VCN RRMT disabled
and it is disabled on SoCs with GC 9.4.4, so use only local offsets.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 8a1db8b33ea0..96263afb3fd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -95,6 +95,13 @@ static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring);
 static void vcn_v4_0_3_set_ras_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_3_enable_ras(struct amdgpu_device *adev,
 				  int inst_idx, bool indirect);
+
+static inline bool vcn_v4_0_3_normalizn_reqd(struct amdgpu_device *adev)
+{
+	return (amdgpu_sriov_vf(adev) ||
+		(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)));
+}
+
 /**
  * vcn_v4_0_3_early_init - set function pointers
  *
@@ -589,6 +596,7 @@ static void vcn_v4_0_3_disable_clock_gating(struct amdgpu_device *adev, int inst
 		| UVD_CGC_GATE__LRBBM_MASK
 		| UVD_CGC_GATE__WCB_MASK
 		| UVD_CGC_GATE__VCPU_MASK
+
 		| UVD_CGC_GATE__MMSCH_MASK);
 
 	WREG32_SOC15(VCN, vcn_inst, regUVD_CGC_GATE, data);
@@ -1432,8 +1440,8 @@ static uint64_t vcn_v4_0_3_unified_ring_get_wptr(struct amdgpu_ring *ring)
 static void vcn_v4_0_3_enc_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
 				uint32_t val, uint32_t mask)
 {
-	/* For VF, only local offsets should be used */
-	if (amdgpu_sriov_vf(ring->adev))
+	/* Use normalized offsets when required */
+	if (vcn_v4_0_3_normalizn_reqd(ring->adev))
 		reg = NORMALIZE_VCN_REG_OFFSET(reg);
 
 	amdgpu_ring_write(ring, VCN_ENC_CMD_REG_WAIT);
@@ -1444,8 +1452,8 @@ static void vcn_v4_0_3_enc_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t
 
 static void vcn_v4_0_3_enc_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val)
 {
-	/* For VF, only local offsets should be used */
-	if (amdgpu_sriov_vf(ring->adev))
+	/* Use normalized offsets when required */
+	if (vcn_v4_0_3_normalizn_reqd(ring->adev))
 		reg = NORMALIZE_VCN_REG_OFFSET(reg);
 
 	amdgpu_ring_write(ring, VCN_ENC_CMD_REG_WRITE);
-- 
2.25.1

