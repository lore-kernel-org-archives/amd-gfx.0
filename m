Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E167C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 18:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 010CB112E6B;
	Tue, 30 Apr 2024 18:59:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LRy8NT+q";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3617F112E6A
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 18:59:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nT6CyDHBCqYm6Xq1po5Ts06ZihHHVNIWSLt6NmtVytrvKSSTIsm0Si8LbuI0luScWsCt6lKeteRFqe5A6Yms42/+CbMrH8zM4O40yPPMoLEu2nqhNjlLDEW33IrXCOOxZW6mSRc+4V/IANA/MuJ/oFo70PPxIIi9RZGrrMR4w0NP9/nctB0osAFPx7E997KokSHzhMjAvomchicwLvt0Z43K8++Ga/ycNA49IM+aJ1CGwJrEnt6ssn+tmTUvPxNCWIgtuC04Xokfvft2js06uC9yzF89mfueluRb/liiISY9NwfJwWg+GXW5ZoyTQkc4t9QvGwSdHVEm1Hr7HrPUMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaVpS4wOoujPKuzwvSwxLXU5/zMUz1vNq2GuVtU2A78=;
 b=NGgnhmKP9wNCq0Ngq/ocWbcB2UvXZdzpJdpvdTmtqhpiMv7YPybRqqB4CV7CcmiCRNhKlA0evwBBh+KSxW1LlRGRzzaAzEpK2RB5qD+z832JG1TnBsYALsiX3uoywJGg1Fu2NANHdV8s1QbOiz05BRIijXGTAfA/mlbEM3D1HiE1FA8dpkd4BqEFydE2hSEhUJCrFx6AubA2XOU+BdBQ0J0PNzC4g8+oo2zHSPol7zXYKwPTqAfNrOl6KdxbfAXzpuP1/j7ypNBS216sKm5Ir7zy9w4d1ommLoKeYOIvtQ7swFQac/DyBRWZmgSOIVUnMXMEHbV0yyqL6ScKxachrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaVpS4wOoujPKuzwvSwxLXU5/zMUz1vNq2GuVtU2A78=;
 b=LRy8NT+qiofR7ax378NAlYsqMpXbJzMbUAGNQ7hhvgN/nRPTl5pGgC64JDTf4gs5Ca6CeLc8m1Bc0WuTLZPokJKGwdfaPFsrI3RU+NTae0IMlqQoQsnq0xG+m2R4cPEpLpYSJ+UxIUbcM8SO5GQ+Uj44gY2M5SnByy9iUBTbJaA=
Received: from PH0PR07CA0042.namprd07.prod.outlook.com (2603:10b6:510:e::17)
 by SJ2PR12MB8941.namprd12.prod.outlook.com (2603:10b6:a03:542::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 18:59:40 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:510:e:cafe::b4) by PH0PR07CA0042.outlook.office365.com
 (2603:10b6:510:e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Tue, 30 Apr 2024 18:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 18:59:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 13:59:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, Leo Liu <leo.liu@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/vcn5: Add VCN5 capabilities
Date: Tue, 30 Apr 2024 14:59:20 -0400
Message-ID: <20240430185920.753947-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|SJ2PR12MB8941:EE_
X-MS-Office365-Filtering-Correlation-Id: 8984bb5c-a22d-413f-42ea-08dc6947b026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400014|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ypQiolTsIHc33s0bxgHUs5L4yCh8W3rSj+YmY7sjJNAZSJNZtAziZAa4glwA?=
 =?us-ascii?Q?xAlQ5YzgZaeWTV3THHs6MJ+nN3tj29axfSh54XM8wqhWcrDfh7YWqTO9GSlK?=
 =?us-ascii?Q?X35nk8gH7Z2TXzgWAwWKi8e+AqeSukQcaLcvtNf5otjkITSeTAxttjuLcNRc?=
 =?us-ascii?Q?t9OsW8EKVGyo2o35A+P6SThJ9OxmYPgq4q17fVlUyYS2BkzYspmDeZ0ZJuHW?=
 =?us-ascii?Q?bcSLw0cEhxqYleawvs6KtROe4iPuA+9ro6CU0PcQJrHIU4IGPmFYmnzHeKBd?=
 =?us-ascii?Q?RQTsYKqPn4+U+1XN56VmXCQ3M+NTRx49+hO+QrkfLGKKoZ1MC73anA0gPmlu?=
 =?us-ascii?Q?Apx7ER/qaFHJHZHBVPqZ/buPKh9VAc70E0rbLoIXepOoz3ZxLIw+53MrE+kJ?=
 =?us-ascii?Q?+Y9Ww6UwO3kNcJRq4ZcHzbM85MJNCnnCKiCXl//iE5HfCorL3CkCqFm0X0t8?=
 =?us-ascii?Q?ttudm4Sw1SMaVkFZUtOb+qRX5cRd2vwxgQoHKItQfLRg4NNvE6WIgNhz4enO?=
 =?us-ascii?Q?WEhHMacg5USYd1PMjKuYxODn/xL9U0AuefFLZD7VuJpGxPcJQx/z7hQ3Bpnb?=
 =?us-ascii?Q?K7TGp9CGy1ezX4i0EU+BxVX7sEcwVTttbAkNoyf5OBA2Pi61pvXI+mI9OFTi?=
 =?us-ascii?Q?JNEG+3arrLR+JtMZmzUDPXIREzkZ6uL9SUUaEaV8NUSwa5+VXhBYdloRXWHv?=
 =?us-ascii?Q?EkU0H8M6x8x23xdta/RUmRZHcmdowEC7oDhsG9xfzrZ95jtJK6lsCMQeTbtK?=
 =?us-ascii?Q?EG2EpF86VIKj97lP7K43G/zQrSd4QzWTj1gtZMWlZZSd8wXagRrLsxnm7b13?=
 =?us-ascii?Q?kOXT49YLEOmpxDMV3PnY5O+SQYhlzDsujjTVM66BAigD3XxOteuIxlJuX5NR?=
 =?us-ascii?Q?I/SwV3oPfC933N+4ycfAv7dG3u0YclC1fEikPE6rufXkcbys6BNcGB8R5VO4?=
 =?us-ascii?Q?cQn1fwfGDbuEFmCNHljwCV8xIFUQaUogHXEaTuXMDe8xHfPCuZWxVgXuKVVf?=
 =?us-ascii?Q?ukZqK6Bc5tfZK2VpyAj4t6w3h5JI/9StLAl4pmsXj3FyvHfqddmEeMUZCJRd?=
 =?us-ascii?Q?ArDI5B1k40j+uS/rYgcI9P7JpLMVg1Byvw/9Y2Q6VuA24Zh4ycXi5mdY15Js?=
 =?us-ascii?Q?J6kcznqr7AiGdgmhnM54gmzgIOVnX4SmSddCos/5cid1KOF2EetkPbb18ulm?=
 =?us-ascii?Q?bsrkeWZMH0H97uVU60KnRHU487z8KiT2Srq0ZWD8HGcVYizsWZp/DlzxDDRl?=
 =?us-ascii?Q?6g9vT1uXjTIVEPLmiYXmLqXsp+RpSyZhOab3QS5TrImZUgFd4/dIO7yG4Kjm?=
 =?us-ascii?Q?X03T1eu5ssAz5z0ei/eEqUb+novv8uIzI3ZR9hyqpgDomGkTknQk+v7LsVd8?=
 =?us-ascii?Q?7UUS69fc9b00115F7jxoYHbX7c7l?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 18:59:39.7253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8984bb5c-a22d-413f-42ea-08dc6947b026
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8941
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

From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>

Add VCN5 encode and decode capabilities support

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc24.c | 43 ++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index e7929be1a6ff7..0979dffe37424 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -47,6 +47,48 @@
 
 static const struct amd_ip_funcs soc24_common_ip_funcs;
 
+static const struct amdgpu_video_codec_info vcn_5_0_0_video_codecs_encode_array_vcn0[] = {
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 3840, 2160, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 7680, 4320, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 7680, 4320, 0)},
+};
+
+static const struct amdgpu_video_codecs vcn_5_0_0_video_codecs_encode_vcn0 = {
+	.codec_count = ARRAY_SIZE(vcn_5_0_0_video_codecs_encode_array_vcn0),
+	.codec_array = vcn_5_0_0_video_codecs_encode_array_vcn0,
+};
+
+static const struct amdgpu_video_codec_info vcn_5_0_0_video_codecs_decode_array_vcn0[] = {
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2160, 52)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4320, 183)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
+};
+
+static const struct amdgpu_video_codecs vcn_5_0_0_video_codecs_decode_vcn0 = {
+	.codec_count = ARRAY_SIZE(vcn_5_0_0_video_codecs_decode_array_vcn0),
+	.codec_array = vcn_5_0_0_video_codecs_decode_array_vcn0,
+};
+
+static int soc24_query_video_codecs(struct amdgpu_device *adev, bool encode,
+				 const struct amdgpu_video_codecs **codecs)
+{
+	if (adev->vcn.num_vcn_inst == hweight8(adev->vcn.harvest_config))
+		return -EINVAL;
+
+	switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {
+	case IP_VERSION(5, 0, 0):
+		if (encode)
+			*codecs = &vcn_5_0_0_video_codecs_encode_vcn0;
+		else
+			*codecs = &vcn_5_0_0_video_codecs_decode_vcn0;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static u32 soc24_get_config_memsize(struct amdgpu_device *adev)
 {
 	return adev->nbio.funcs->get_memsize(adev);
@@ -323,6 +365,7 @@ static const struct amdgpu_asic_funcs soc24_asic_funcs = {
 	.get_pcie_replay_count = &soc24_get_pcie_replay_count,
 	.supports_baco = &amdgpu_dpm_is_baco_supported,
 	.pre_asic_init = &soc24_pre_asic_init,
+	.query_video_codecs = &soc24_query_video_codecs,
 	.update_umd_stable_pstate = &soc24_update_umd_stable_pstate,
 };
 
-- 
2.44.0

