Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAB0C0218A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 09:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1736310E603;
	Tue, 28 Jan 2025 09:11:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BvZNRKMr";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3149E10E603
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 09:11:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5XcPacQMOhdF39wCrBESWa/nyzEAZB3O6+JrQ0nZBJtMXp45cg1Oq5l3NDMzG22EPQc0W47oxDtKo1YNk804Fs5m7loEOWDjTlj8ifAO4mRvDQHO8Drl2dmPeWdkto61dPl7b/VcEb1FOL451o3RoIAqFrQ6yweBIO6PmbcoHkvF4r+jgVPEZ2ln3u2WbjLgYO4aasIv1lmRKnmNgYoscDlPnDj9YSbT1JUnWm/G9W7A0S8gslJug4swRIc8La2QxnueTqTfOwGrbkZVJWGN3GRVHPd5BwVEL61gNfu+agY0qAlbtxAYjtaFBxwBa/kRN/pRQZVj4DZttfo5NJpgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shjc3PBawx0L2oyyy3qW1u/lBCsip9rl0O50jsalTv4=;
 b=YKpWznyGDJOTbukIM/BduU3LIDye37oeN0zKkBDjO18HpkdpD9hQGGlei3LfmOQ3Cg3U8bNSgdIV6gVKx5lrcanZ2Gb6NvsybMAxNyAJAk3r9xtrf9Du+WuiFO86NW0dSQivm+83HhFJe2m5+ZkfXB7+OGzU5KvoxEZlmTtJZdt1BCWFHekwVMCHLOoY8vB+I6HOmbnFe/3+zpzPf28rDBZuXOVPOulf/hcu1PRNfMbVphaSV021Y1tWNnsvGU9A6YxBJpt6fWfAd6oYv5pR0HEZAKHO4W+nbSGfuxBgdI8tCERdcMvLARZr5CDjJAK2ORuOXwF5Vbjx2ZQlJZxP2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shjc3PBawx0L2oyyy3qW1u/lBCsip9rl0O50jsalTv4=;
 b=BvZNRKMrXP0SU1NNjhPRmikdjORJb3tEvWH/Vg4TxVKg3Sb+WhBjRdzRuUcFWdcRw5pfEqT4deBv8GGr2dt/JVbD+hi7i8YYt82uI8DFHDdT/MtZqHkNWK2NzllPntRC7oaOLsFJVPuOap3WoRpDxOD5HSnbyXZ/FzvV3yJzuyY=
Received: from DS7PR03CA0002.namprd03.prod.outlook.com (2603:10b6:5:3b8::7) by
 MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 09:11:28 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::6c) by DS7PR03CA0002.outlook.office365.com
 (2603:10b6:5:3b8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.23 via Frontend Transport; Tue,
 28 Jan 2025 09:11:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 28 Jan 2025 09:11:27 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 Jan 2025 03:11:25 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 4/9] drm/amdgpu: Enable devcoredump for JPEG5_0_1
Date: Tue, 28 Jan 2025 14:39:45 +0530
Message-ID: <20250128090950.461291-5-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250128090950.461291-1-sathishkumar.sundararaju@amd.com>
References: <20250128090950.461291-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|MW4PR12MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 155e1a14-bea7-4300-42a8-08dd3f7bbeec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHlrV2xUckdpYUt4TjNsV1VONmJRSXpLZ2JWUS9xWWpTaUU0c281ODFMVEJz?=
 =?utf-8?B?RFhxenVRWldoZXR4RTBqaXhmZzgzOUs2b2FablJMUnZHSko5d3ZCdmhUQUNj?=
 =?utf-8?B?ZE8xU3pxY2dNWk16b1I3UkZrK0FYam5rc25OWGZhUHQwRStRS0tLYmh4eTFq?=
 =?utf-8?B?b2lxZTNYdlV2ZCtyMStyQlJoN0VPRGM3blVPWkZMV3BQK00zbTdmanRPUlhU?=
 =?utf-8?B?d0RZQjlEZ2xRdDlVZkhKcVF1cWxjb2N6ZTJIZkUrWUtPcDg0dmYyQm45YTNM?=
 =?utf-8?B?TEpHb3V2eXF0NDc5T3Fzdlg2M2dLQ3RRQ2pmSzZRY3VUQWhGdFlIUnY1b3lI?=
 =?utf-8?B?ZTc5dDJ0YkV6TGhQK0RsMGpwYW5NenlzR29HTnBqKzI3WW5TRnhEajJMQnFB?=
 =?utf-8?B?eHBOam16OUlkRzhkVW5lV0lpeGhVMzVBTUxlRU1Vd3RIR3pwL2JYTWlCb3dl?=
 =?utf-8?B?bnZKTnZEOG50cnZFK0toY21US3ovdU9rVGxkU0ZmSEVIcHJPK1UzQ1dWcjZF?=
 =?utf-8?B?NnppbUZpWWllR1FYUzFDRVdoeHlxVzdBV0VUeGMrdGZ5NmxIdkZ5eExCR0Qz?=
 =?utf-8?B?dGc0alpUa3MwUXFLbmM0NFlzVTBJc3czSS8xMnBPUDIvb2dreTZPZWtnb25Q?=
 =?utf-8?B?MXI1T0p5a3NTVVNjWkg4WHdaWTZYY2R3ckk1bk1ZKy9wWkkrb2hPc0wrM1ZZ?=
 =?utf-8?B?UGNpY085OWFmaGpqRm5rZUVnN0lPTTZ1Y2RiZ1I3eGFDTzd3dVN6b2F2WE00?=
 =?utf-8?B?SXUzZkVQK05vU1h0R0dNZFFSLytTdW84TzJybmVEV0liNk1XV0lRYllteUpP?=
 =?utf-8?B?UkxlK2JKeFNNUDJZb3lRUmV1NUxFbWtHbFNiVk81UVpmazFoa1JIZjFrQTda?=
 =?utf-8?B?OFpYY01oVGpya0NwaWtZWE5PQnpIZDdGSUxsbXNMS3ZOcEtTMzBHNElYMWJP?=
 =?utf-8?B?aXk1YWlyUmhweG5QV29XcFlIZ2tnTVduaHNIaUREZEhkdFRHRjVmTEl4d200?=
 =?utf-8?B?dmFrOCs3OU9MOVBrejk3QmpyS09DOEhjYnJqK3F1Y2RTNkl0UjJxU24yWXg1?=
 =?utf-8?B?cWhSbEpuam1iSW9mRWlobXpldjgrNEZZM3ArTjJvV0I2ZkJLSHdFalU3RGZi?=
 =?utf-8?B?czNHWTAxRERaeXkrNW1FNFlKbWpFYnVreVdwSGNBcytTV0Q5S1pDZk8xZEs0?=
 =?utf-8?B?K0ZrQnpPOTBHRGloNFRBRnhyZmpmRUw1bDBoMGVvT1VzblJDVnhoWTh3L1Uz?=
 =?utf-8?B?RE5nNHU3eXYxMmRIY3ZjYmxpZFpvbG94NFRSRnErYUdraFh1V3BLSW1hSVR2?=
 =?utf-8?B?U3NybDdPOHlldWJodXdMamgxbHNvTithNVJubFN6QXQxeEN6cWZ6R3RpVVZz?=
 =?utf-8?B?N25nNy9GNDhuR2xWWXdPZk0yOUdhYjVsMnltYi9MWEpVMWFrQVVQTDErY2l1?=
 =?utf-8?B?R1hheUlOZWJPWmZmZTcvTVljVWFlZHRKUFhtWDhHVGFtUVlyOElSaHlXc1Ur?=
 =?utf-8?B?MWcrNkhTc2NsQjZrK2k1UXhyNHdzN1gzaTF6NW9WcFE1YUZ2eEUwYWJxOFdS?=
 =?utf-8?B?YWNscVUrT2xXbnU0MERHdGllU1g0cVJSYUJEZi84OGV3S2FKdW9FemtNUTN0?=
 =?utf-8?B?ZmNYNlA0YnJnRVlYU2Zma1k0cWlBQ25HN2hGNy9jNkVSVW55Zm1aaXJqZlRn?=
 =?utf-8?B?L0o4Y1BjVDJPbW9pZXo3VUswMGlBS2o5dHRKbTViWmJjWmVLY0p3QUFCVnJD?=
 =?utf-8?B?MGN3Mk5lcFh1dWhIODBmOWI5M0l0Q3ZJcTlZMTRYOVgwOE5rUGR2dVo1dG1U?=
 =?utf-8?B?YkJhRWdWc0Zxbmg2M3c3OVNvcmhRSXZieWt2OFV4RDc1aHlvYWk0amkrd2xG?=
 =?utf-8?B?RSs0dHBvZHJwK0ZqUnFDMGJWaFpqdldNWEZsRDFpc2drWlJYZ2JYcy94UjZB?=
 =?utf-8?B?bHB4U3FjZ2VFc2UrS3BvTDZtUGp0Nm9RejhTL2xoZXpMVys2VXB4Nm1Yaitt?=
 =?utf-8?B?Mzd5Mmp0UXVBPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 09:11:27.2222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 155e1a14-bea7-4300-42a8-08dd3f7bbeec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165
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

Add register list and enable devcoredump for JPEG5_0_1

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 65 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h | 61 ++++++++++++++++++++++
 2 files changed, 124 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 40d4c32a8c2a..e7879a826147 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -38,6 +38,8 @@ static void jpeg_v5_0_1_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					     enum amd_powergating_state state);
 static void jpeg_v5_0_1_dec_ring_set_wptr(struct amdgpu_ring *ring);
+static void jpeg_v5_0_1_dump_ip_state(struct amdgpu_ip_block *ip_block);
+static void jpeg_v5_0_1_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p);
 
 static int amdgpu_ih_srcid_jpeg[] = {
 	VCN_5_0__SRCID__JPEG_DECODE,
@@ -52,6 +54,47 @@ static int amdgpu_ih_srcid_jpeg[] = {
 	VCN_5_0__SRCID__JPEG9_DECODE,
 };
 
+static const struct amdgpu_hwip_reg_entry jpeg_reg_list_5_0_1[] = {
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JPEG_POWER_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JPEG_INT_STAT),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC0_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC0_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, regJPEG_DEC_ADDR_MODE),
+	SOC15_REG_ENTRY_STR(VCN, 0, regJPEG_DEC_GFX10_ADDR_CONFIG),
+	SOC15_REG_ENTRY_STR(VCN, 0, regJPEG_DEC_Y_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(VCN, 0, regJPEG_DEC_UV_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JPEG_PITCH),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JPEG_UV_PITCH),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC1_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC1_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC1_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC2_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC2_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC2_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC3_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC3_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC3_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC4_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC4_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC4_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC5_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC5_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC5_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC6_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC6_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC6_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC7_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC7_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC7_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC8_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC8_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC8_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC9_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC9_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC9_UVD_JRBC_STATUS),
+};
+
 static int jpeg_v5_0_1_core_reg_offset(u32 pipe)
 {
 	if (pipe <= AMDGPU_MAX_JPEG_RINGS_4_0_3)
@@ -145,6 +188,11 @@ static int jpeg_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
+	adev->jpeg.ip_dump = kcalloc(adev->jpeg.num_jpeg_inst * ARRAY_SIZE(jpeg_reg_list_5_0_1),
+				     sizeof(uint32_t), GFP_KERNEL);
+	if (!adev->jpeg.ip_dump)
+		DRM_ERROR("Failed to allocate memory for JPEG IP Dump\n");
+
 	return 0;
 }
 
@@ -166,6 +214,8 @@ static int jpeg_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_jpeg_sw_fini(adev);
 
+	kfree(adev->jpeg.ip_dump);
+
 	return r;
 }
 
@@ -617,6 +667,17 @@ static int jpeg_v5_0_1_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void jpeg_v5_0_1_dump_ip_state(struct amdgpu_ip_block *ip_block)
+{
+	amdgpu_jpeg_dump_ip_state(ip_block, jpeg_reg_list_5_0_1, ARRAY_SIZE(jpeg_reg_list_5_0_1));
+}
+
+static void jpeg_v5_0_1_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
+{
+	amdgpu_jpeg_print_ip_state(ip_block, p, jpeg_reg_list_5_0_1,
+				   ARRAY_SIZE(jpeg_reg_list_5_0_1));
+}
+
 static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
 	.name = "jpeg_v5_0_1",
 	.early_init = jpeg_v5_0_1_early_init,
@@ -635,8 +696,8 @@ static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
 	.post_soft_reset = NULL,
 	.set_clockgating_state = jpeg_v5_0_1_set_clockgating_state,
 	.set_powergating_state = jpeg_v5_0_1_set_powergating_state,
-	.dump_ip_state = NULL,
-	.print_ip_state = NULL,
+	.dump_ip_state = jpeg_v5_0_1_dump_ip_state,
+	.print_ip_state = jpeg_v5_0_1_print_ip_state,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v5_0_1_dec_ring_vm_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
index 8ce146c00bb6..9de3272ef47f 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
@@ -26,4 +26,65 @@
 
 extern const struct amdgpu_ip_block_version jpeg_v5_0_1_ip_block;
 
+#define regUVD_JRBC0_UVD_JRBC_RB_WPTR             0x0640
+#define regUVD_JRBC0_UVD_JRBC_RB_WPTR_BASE_IDX    1
+#define regUVD_JRBC0_UVD_JRBC_STATUS              0x0649
+#define regUVD_JRBC0_UVD_JRBC_STATUS_BASE_IDX     1
+#define regUVD_JRBC0_UVD_JRBC_RB_RPTR             0x064a
+#define regUVD_JRBC0_UVD_JRBC_RB_RPTR_BASE_IDX    1
+#define regUVD_JRBC1_UVD_JRBC_RB_WPTR             0x0000
+#define regUVD_JRBC1_UVD_JRBC_RB_WPTR_BASE_IDX    0
+#define regUVD_JRBC1_UVD_JRBC_STATUS              0x0009
+#define regUVD_JRBC1_UVD_JRBC_STATUS_BASE_IDX     0
+#define regUVD_JRBC1_UVD_JRBC_RB_RPTR             0x000a
+#define regUVD_JRBC1_UVD_JRBC_RB_RPTR_BASE_IDX    0
+#define regUVD_JRBC2_UVD_JRBC_RB_WPTR             0x0040
+#define regUVD_JRBC2_UVD_JRBC_RB_WPTR_BASE_IDX    0
+#define regUVD_JRBC2_UVD_JRBC_STATUS              0x0049
+#define regUVD_JRBC2_UVD_JRBC_STATUS_BASE_IDX     0
+#define regUVD_JRBC2_UVD_JRBC_RB_RPTR             0x004a
+#define regUVD_JRBC2_UVD_JRBC_RB_RPTR_BASE_IDX    0
+#define regUVD_JRBC3_UVD_JRBC_RB_WPTR             0x0080
+#define regUVD_JRBC3_UVD_JRBC_RB_WPTR_BASE_IDX    0
+#define regUVD_JRBC3_UVD_JRBC_STATUS              0x0089
+#define regUVD_JRBC3_UVD_JRBC_STATUS_BASE_IDX     0
+#define regUVD_JRBC3_UVD_JRBC_RB_RPTR             0x008a
+#define regUVD_JRBC3_UVD_JRBC_RB_RPTR_BASE_IDX    0
+#define regUVD_JRBC4_UVD_JRBC_RB_WPTR             0x00c0
+#define regUVD_JRBC4_UVD_JRBC_RB_WPTR_BASE_IDX    0
+#define regUVD_JRBC4_UVD_JRBC_STATUS              0x00c9
+#define regUVD_JRBC4_UVD_JRBC_STATUS_BASE_IDX     0
+#define regUVD_JRBC4_UVD_JRBC_RB_RPTR             0x00ca
+#define regUVD_JRBC4_UVD_JRBC_RB_RPTR_BASE_IDX    0
+#define regUVD_JRBC5_UVD_JRBC_RB_WPTR             0x0100
+#define regUVD_JRBC5_UVD_JRBC_RB_WPTR_BASE_IDX    0
+#define regUVD_JRBC5_UVD_JRBC_STATUS              0x0109
+#define regUVD_JRBC5_UVD_JRBC_STATUS_BASE_IDX     0
+#define regUVD_JRBC5_UVD_JRBC_RB_RPTR             0x010a
+#define regUVD_JRBC5_UVD_JRBC_RB_RPTR_BASE_IDX    0
+#define regUVD_JRBC6_UVD_JRBC_RB_WPTR             0x0140
+#define regUVD_JRBC6_UVD_JRBC_RB_WPTR_BASE_IDX    0
+#define regUVD_JRBC6_UVD_JRBC_STATUS              0x0149
+#define regUVD_JRBC6_UVD_JRBC_STATUS_BASE_IDX     0
+#define regUVD_JRBC6_UVD_JRBC_RB_RPTR             0x014a
+#define regUVD_JRBC6_UVD_JRBC_RB_RPTR_BASE_IDX    0
+#define regUVD_JRBC7_UVD_JRBC_RB_WPTR             0x0180
+#define regUVD_JRBC7_UVD_JRBC_RB_WPTR_BASE_IDX    0
+#define regUVD_JRBC7_UVD_JRBC_STATUS              0x0189
+#define regUVD_JRBC7_UVD_JRBC_STATUS_BASE_IDX     0
+#define regUVD_JRBC7_UVD_JRBC_RB_RPTR             0x018a
+#define regUVD_JRBC7_UVD_JRBC_RB_RPTR_BASE_IDX    0
+#define regUVD_JRBC8_UVD_JRBC_RB_WPTR             0x01c0
+#define regUVD_JRBC8_UVD_JRBC_RB_WPTR_BASE_IDX    0
+#define regUVD_JRBC8_UVD_JRBC_STATUS              0x01c9
+#define regUVD_JRBC8_UVD_JRBC_STATUS_BASE_IDX     0
+#define regUVD_JRBC8_UVD_JRBC_RB_RPTR             0x01ca
+#define regUVD_JRBC8_UVD_JRBC_RB_RPTR_BASE_IDX    0
+#define regUVD_JRBC9_UVD_JRBC_RB_WPTR             0x0440
+#define regUVD_JRBC9_UVD_JRBC_RB_WPTR_BASE_IDX    1
+#define regUVD_JRBC9_UVD_JRBC_STATUS              0x0449
+#define regUVD_JRBC9_UVD_JRBC_STATUS_BASE_IDX     1
+#define regUVD_JRBC9_UVD_JRBC_RB_RPTR             0x044a
+#define regUVD_JRBC9_UVD_JRBC_RB_RPTR_BASE_IDX    1
+
 #endif /* __JPEG_V5_0_0_H__ */
-- 
2.25.1

