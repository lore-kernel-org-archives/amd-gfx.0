Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AA4FF8869
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 15:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DC6010E7B4;
	Mon, 27 Apr 2026 15:24:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RxZc+njt";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 864A410E7B3
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 15:24:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQOAS/1OayVatUA6LqHplonwA/9Aaufbq2CuKpSg+vf2bruhmFB1a5NDCbxoQhl9+S/pA2T8nUfRDUMlmZhT21I1pzJB9xDVye+22dBjRgojRZ+5YaA1PxVyQO5QkKTA1sa0iAQyEtMOz2ZUBn3Gr9xE7z5KXX0sSs8CP5ZB0G1fxLUznUgVqJ6Ucjb+RRx5Vt4o2YblVPOyiMCZoLTBL0LprnAX3EVKIHwWN0d50ScT1lUXv3IiCmWKc3nWLkDwYL+grbDyLNd9cvpiXpoE8MlwW5PWBq//iEGhrP9i4QXPxVewgDKh+CZ6Xvrle2VROQT9heb3wWtwNMD05aDdrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2hV+Gwi63rqCcxZ3+Eu9UqWyFqsYVUjUoOvZVBuBPc=;
 b=zKsShsMjRxioheEYrMoEibdC41WpL9bINo5x6HqCfTjw5sZ5K+aTcTi308tfG03CEPVYDXrzY77ZAbuMygax12OON6SfCqwFeRoyyJZU86zB/97lijzMfCC2E5FJE/caUovAjbuXzxxUaJlz+O0wWWFXv4BHwJBOTiVfA1YOFY/UPOnGcHQkeFr4TVHPu6rJubD2EgYxzOlQBccI1CF0NkAAGruCUYmEw3t2s/Q/tsWw80112rARUtCVP4fFubBFOHgM/SOGsSYHFzSBeMwTvsnsXH18c4UT0RCbZO6QO8+npqIPnPcNgZmElR/QxiDNhCEn98Xs/e7L7Gbdi6mXIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2hV+Gwi63rqCcxZ3+Eu9UqWyFqsYVUjUoOvZVBuBPc=;
 b=RxZc+njtWyqnew8MuxdXRDfAAhQBunU8mpiFUeEBbNTMEYF42/dZz8OnkUiYju0vr0hQTWaGBpapYXRkvlvNOI3TX+6kXNTS2gp6BDCh1D1WXyWKhUV7wG8gPm6+mIkEDU7T28y+AxszVHx5+dVpiQhQRsUg99y6lXhr3r01s1k=
Received: from MW4PR03CA0330.namprd03.prod.outlook.com (2603:10b6:303:dd::35)
 by SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 15:23:55 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::eb) by MW4PR03CA0330.outlook.office365.com
 (2603:10b6:303:dd::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 15:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E65.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 15:23:52 +0000
Received: from yinjiyao-dev24.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 10:23:52 -0500
From: Yinjie Yao <yinjie.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Leo.Liu@amd.com>, <Alexander.Deucher@amd.com>, <Ruijing.Dong@amd.com>,
 <Christian.Koenig@amd.com>, Yinjie Yao <yinjie.yao@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/vcn: set no_user_fence for VCN v2-v5 enc/dec
 rings
Date: Mon, 27 Apr 2026 11:22:47 -0400
Message-ID: <20260427152248.1349143-1-yinjie.yao@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|SJ2PR12MB8784:EE_
X-MS-Office365-Filtering-Correlation-Id: 375bd672-b3cb-43da-9573-08dea470fd75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: RRpHUcMWsU19hr9zr3skMnR4JOwwYaK0nNm6+AIklwteAdcMgSufZp0EXf8a0SZ9r7zeO6KDMuaLqxZemrwdwAO6bdICTVIxpXhu3kOjRgCVoyDWuBQfiTklCWm2deqRhYbSIfxrBoviMpqpotPtIU1sds+3H1feSMY0LmVUHX0fwNA1PlN6HAN+s7VAK0ggx9tx0+9lKnMIylAkdIzStjwv8RrRMFH1/wnR+Yh1U2wjh5/RiSUXulVG3i5D/91U47o6ATOqkMExJ9rue/BHw7XsM5wN1Tht/luzzyTIVsopchNp0bAEpZkGmbVGl9y9XirfHABvZdWwUlQQSAD0KtL5oW9qQ0E+tJFHlZHaSDnJFIa/N/+3Ksj0RW+3r7Kfe9/TOYhXy2k4kCM3v0zooYJ0znCUKwmoPceFkk/UzVcFN0MYn6ibRLw52EIdx6kkUuPVNqu4QKIWFh8YWrcU0EiTytP0VsVRpqDhWHNS3070jCtiC0/TgC4kAIgGoIP+I8W98OHNgl10ZJ31FV5EtI3O3wFYsKcaEj1bEIhLZxjsNO+3fDB9pl/0YsPybK8HmacFxtxJMHTaMpN4eLo+sxN9caFQqGzWk0y1tLXSm1zH7x2kyQ3PShLfhye4e48xiVg7N/1OiLJe+ljRdHiJ9tPOYxnCELPRc4ZOsN3ayIlXpdluOAP2X1sdLtg6OzrgznCUuH4/rC67kDaGWdLXgvByg3uHeDE8DatXmppcOYfq0s/FqK/ACgAXDpwtWenl/Yx54eU9WzpOzeOvFbZ2KQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kWkBDO+r6ZmUOQd+sppuH66MywksAAuNePcZrEVPNbw3GxFAXJnUV+zNbZhELYCObpJEATc0d+pIJ/JrneFWJiE0iebGWPOh124GFYGUG3jOJea+QJIEwNKNQsRtHwqOxUTKlpXDB/hZv9g5HEJJ8wwYijLzuwhcFVv2MKhocdgkufs3ppUsWcbqSp6hvnAce9eDJBsKQYtpMSMXIgjFpUw4V77KmB0UFGfgFcYATVDFPB3HIAFgAT+zaT1ah/cSbtgDfRyEBMbR2X8lggjwkI/jtYzKYZsPfhV3haPeo+jzUHtna8LjPknNwuGkKQ/7Y5ijrC58vBsSxiiPKdR+s6NLIodUi/RjzB79hbvEhJOdnH7cEGntaVeWmkxplEsu5ZuUvLetDkq/JJTE6rkh0qT84UG/2Ev8ghXl9rnKmwCWP8k8xs6SEOIKIfl4pkNg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 15:23:52.8061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 375bd672-b3cb-43da-9573-08dea470fd75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8784
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

VCN encoder and decoder rings do not support 64-bit user fence writes,
reject CS submissions with user fences.

Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 2 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 2 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 3 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c | 1 +
 9 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index e35fae9cdaf6..0442bfcfd384 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -2113,6 +2113,7 @@ static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
 static const struct amdgpu_ring_funcs vcn_v2_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.secure_submission_supported = true,
 	.get_rptr = vcn_v2_0_dec_ring_get_rptr,
 	.get_wptr = vcn_v2_0_dec_ring_get_wptr,
@@ -2145,6 +2146,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_enc_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.no_user_fence = true,
 	.get_rptr = vcn_v2_0_enc_ring_get_rptr,
 	.get_wptr = vcn_v2_0_enc_ring_get_wptr,
 	.set_wptr = vcn_v2_0_enc_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 006a15451197..8b8184fe6764 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1778,6 +1778,7 @@ static void vcn_v2_5_dec_ring_set_wptr(struct amdgpu_ring *ring)
 static const struct amdgpu_ring_funcs vcn_v2_5_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.secure_submission_supported = true,
 	.get_rptr = vcn_v2_5_dec_ring_get_rptr,
 	.get_wptr = vcn_v2_5_dec_ring_get_wptr,
@@ -1879,6 +1880,7 @@ static const struct amdgpu_ring_funcs vcn_v2_5_enc_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.no_user_fence = true,
 	.get_rptr = vcn_v2_5_enc_ring_get_rptr,
 	.get_wptr = vcn_v2_5_enc_ring_get_wptr,
 	.set_wptr = vcn_v2_5_enc_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 6fb4fcdbba4f..4924da5af5e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1856,6 +1856,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_sw_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0x3f,
 	.nop = VCN_DEC_SW_CMD_NO_OP,
+	.no_user_fence = true,
 	.secure_submission_supported = true,
 	.get_rptr = vcn_v3_0_dec_ring_get_rptr,
 	.get_wptr = vcn_v3_0_dec_ring_get_wptr,
@@ -2036,6 +2037,7 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 static const struct amdgpu_ring_funcs vcn_v3_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.secure_submission_supported = true,
 	.get_rptr = vcn_v3_0_dec_ring_get_rptr,
 	.get_wptr = vcn_v3_0_dec_ring_get_wptr,
@@ -2138,6 +2140,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_enc_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.no_user_fence = true,
 	.get_rptr = vcn_v3_0_enc_ring_get_rptr,
 	.get_wptr = vcn_v3_0_enc_ring_get_wptr,
 	.set_wptr = vcn_v3_0_enc_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 5dec92691f73..bbdd017cbafb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1994,6 +1994,7 @@ static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.no_user_fence = true,
 	.extra_bytes = sizeof(struct amdgpu_vcn_rb_metadata),
 	.get_rptr = vcn_v4_0_unified_ring_get_rptr,
 	.get_wptr = vcn_v4_0_unified_ring_get_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index ff3013b97abd..10e8fc2821f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1775,6 +1775,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.no_user_fence = true,
 	.get_rptr = vcn_v4_0_3_unified_ring_get_rptr,
 	.get_wptr = vcn_v4_0_3_unified_ring_get_wptr,
 	.set_wptr = vcn_v4_0_3_unified_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 1f6a22983c0d..1571cc5a148c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1483,6 +1483,7 @@ static struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.no_user_fence = true,
 	.get_rptr = vcn_v4_0_5_unified_ring_get_rptr,
 	.get_wptr = vcn_v4_0_5_unified_ring_get_wptr,
 	.set_wptr = vcn_v4_0_5_unified_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 6109124f852e..d5f49fa33bee 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1207,6 +1207,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.no_user_fence = true,
 	.get_rptr = vcn_v5_0_0_unified_ring_get_rptr,
 	.get_wptr = vcn_v5_0_0_unified_ring_get_wptr,
 	.set_wptr = vcn_v5_0_0_unified_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index c28c6aff17aa..54fbf8d73ca6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -1419,6 +1419,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_1_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.no_user_fence = true,
 	.get_rptr = vcn_v5_0_1_unified_ring_get_rptr,
 	.get_wptr = vcn_v5_0_1_unified_ring_get_wptr,
 	.set_wptr = vcn_v5_0_1_unified_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
index c3d3cc023058..bbc172db91a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
@@ -994,6 +994,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_2_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.no_user_fence = true,
 	.get_rptr = vcn_v5_0_2_unified_ring_get_rptr,
 	.get_wptr = vcn_v5_0_2_unified_ring_get_wptr,
 	.set_wptr = vcn_v5_0_2_unified_ring_set_wptr,
-- 
2.43.0

