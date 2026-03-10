Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA28BEB1070
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 15:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D040010E757;
	Tue, 10 Mar 2026 15:32:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UVbgXRmr";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012000.outbound.protection.outlook.com
 [40.93.195.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEDEC10E724
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 15:32:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZV47alJ2jzoF0LbZYJNEG6y/HXJoWtyUBdCMt/KX+bHmLTpC1SzwKDCjMPcSxmKLTbsjGvxCrb2pW61ths/hl/Fx4B3F0s3o6Yf8JVRdmqzjWeNRG+Fg/k8y1pCHvIErEeblRu0XbNJaFOzk38d918aHD0X36x9YdKCo4wN6OfvmEXP1eeY8IVxmjGlCwZilojIqZn7Cecwrzr5jqLabr9gTMifLfe3WI2VjpQP2bmgLb4tF6prHgemftg2TvxIN7YWsdr6EmcqkB50ymom2b8/uIxBBw927boR4e5lVS3dbyde/NlhkY/4yr+8EnRRDrmM0OYDp5klFgXctRSYhUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GaFXCuTt5p6rJcA0u08woB6pn5+nHDaNFx9Sbw3Rc1A=;
 b=Efztfgd+/6K7x+TPUXYVGE9rY58SJ+YyN3dNbNbnGsYpCipggUPqIelIGcCbSLard//1ClMtuT9ySOMw2rJANIL408eOgU2raDgJMsS0lz0c8dII5+S3x7kIXIt7dbcWpFGejcTRppVqYkfjtR6odfN8tSQ5JlZ3USmcY2sInUfHW6WT7l6Sk5hyiFK0LpyG7O2VYMkkAs3DVG479q1g5cDKnNO/SSmV32IfPzUDB+eRMEeTqS8+09+SG3I0zGJT9b/8H+rkPIQrLm/3CJCnon2Us6yHSlbPehJPw/ei9ZT9JWffnVYuvRXDnr3D++ekoELmV9ARFDhAOzFWh8ABxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaFXCuTt5p6rJcA0u08woB6pn5+nHDaNFx9Sbw3Rc1A=;
 b=UVbgXRmr3T9YfFZrWT0q0lHcZJYtxhYOu5Iv232eoH2as1bMrBUdpX/jbEy/0Fe7UrUHTIcP5wgxBA5ESGmJJCw6Cm4P6RtCDQpybKoauhhes9UoSIBo7q4EGjGb+XRoOAhCf7sEp1Bf4NZ/EltQq+PlQKSIFKoct7CwbV4GQbs=
Received: from CYZPR14CA0038.namprd14.prod.outlook.com (2603:10b6:930:a0::26)
 by SN7PR12MB7977.namprd12.prod.outlook.com (2603:10b6:806:340::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 15:32:12 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:a0:cafe::90) by CYZPR14CA0038.outlook.office365.com
 (2603:10b6:930:a0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 15:32:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 15:32:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 10 Mar
 2026 10:32:12 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Mar
 2026 10:32:12 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Mar 2026 10:32:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sonny Jiang <sonjiang@amd.com>, Leo Liu <leo.liu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Add VCN_5_0_2 codecs capabilities support
Date: Tue, 10 Mar 2026 11:32:01 -0400
Message-ID: <20260310153203.2883286-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310153203.2883286-1-alexander.deucher@amd.com>
References: <20260310153203.2883286-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|SN7PR12MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cad59ec-33c5-4191-562c-08de7eba338b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: BtfFnyqqwe5tT02MogJxQRl9ceetWOqVhgVmZmLq+k9BnGb0HePfLzmGWntWXZ/xPz0bazw4ZAzyz5HOY1gI2aNxzoCuKrA6uDXNXSryqDzpFfX9nJya2+XELycbfdmH01FJWLvSs1OjyOOFgDEjZWvGlbt9VvgEK4jm7ofxkEPMul98dzceLCa1wg3XzdNe2HIpCphPzohhp0bMstidKtYOhZ3i3CIev0o/wqK3aEPGng7T6E5crzjFt4J9npcutVbUoDVY5DjdkKa03ii0zVJgi4A0gRHVTXLPEMwT1q8oF/cnKsjvN6jV/XFritKuyzqOZiv5OdVNiHqZxE2HSDQfucmlF7cAReNiSXGoxrvZ77FAyyd2iThYNjNI87yIGw37SXZOecfZ07IZhmy1pXAY3+6yyrWloVw7R2TR7a8d2cfuZ6Qy92RNQQcGxlPsJSeh6UCQvZpLTlMT+ri1pBtmMLRW0vlKOGwC9WQ7hRvLpnxXPW50ChbhKogsfEb+3PFM5sEWzE4OTlsT8HpxISgjbduNqk78U07lkxs9kI4i/Ed8JjdDC8dqsUFVKsab5pscmo8kN8Ghs21izJtXtoD/A/D6mH5mkpFjBRa5w3yVyRUAHfZMQiXB3+eJ1igbXU3hynBmzOiYCHY7bJ+E+lGRsQui6KVT52P5Q4Q8RWuB5Y2+OiPKEI4WjpzlEDE0X3bynbOK70p6Xu2bGXKrxWSTP3WPU5u5bgbZKDlK+9QwUMmjR2BPgLYlUOFxMbgbELdcNYwFzpnkqZwuPlGF7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UUBncSdRHfZW3++1/BbC/POgOArUgR1m43KjlbatHyzY9hH9zw5ANxcRHT6Pt6WRM3p2Y1lpA6N2bA/QYtoLTihQWPs4Xjw+syb1FzOBsGbgJ2mYIzkIzYsZfdh9EMPTvty+9e8cPjIS0oSYp2JXwrXEYXXQHebZq9mXyO4M2M5PbJv5e+dUsqQ4sVL+b0z9rCOQ9tW0WR90KRLTmevO7VBLe1ZTfkul1kyc15KnksFpxYAIH4tyeGY7aBR87EGHEM0wIjURDlsgKT59lUpebBGujC+gEU183rjw5N6K0KqkUTp9+2xHMgV9+HJozAqbPqK9JqTuUM6RBzJZtvpXlPdI2cSve+TECjEknLrKQ+I2mXC+b774HqyEjhDwtNT4hyF428M1oGV/oaSfBAbDBwnS8OiH0rvBFGrN3iZH/Z1Wp4dYMrA7oS7JOpB71G5I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 15:32:12.6307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cad59ec-33c5-4191-562c-08de7eba338b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7977
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

From: Sonny Jiang <sonjiang@amd.com>

Support VCN_5_0_2 codec query

Signed-off-by: Sonny Jiang <sonjiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 34 +++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 37552c91a8781..3952181c077e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -46,6 +46,39 @@
 #define NORMALIZE_MID_REG_OFFSET(offset) \
 		(offset & 0x3FFFF)
 
+static const struct amdgpu_video_codecs vcn_5_0_2_video_codecs_encode_vcn0 = {
+	.codec_count = 0,
+	.codec_array = NULL,
+};
+
+static const struct amdgpu_video_codec_info vcn_5_0_2_video_codecs_decode_array_vcn0[] = {
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
+};
+
+static const struct amdgpu_video_codecs vcn_5_0_2_video_codecs_decode_vcn0 = {
+	.codec_count = ARRAY_SIZE(vcn_5_0_2_video_codecs_decode_array_vcn0),
+	.codec_array = vcn_5_0_2_video_codecs_decode_array_vcn0,
+};
+
+static int soc_v1_0_query_video_codecs(struct amdgpu_device *adev, bool encode,
+					const struct amdgpu_video_codecs **codecs)
+{
+	switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {
+	case IP_VERSION(5, 0, 2):
+		if (encode)
+			*codecs = &vcn_5_0_2_video_codecs_encode_vcn0;
+		else
+			*codecs = &vcn_5_0_2_video_codecs_decode_vcn0;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 /* Initialized doorbells for amdgpu including multimedia
  * KFD can use all the rest in 2M doorbell bar */
 static void soc_v1_0_doorbell_index_init(struct amdgpu_device *adev)
@@ -262,6 +295,7 @@ static const struct amdgpu_asic_funcs soc_v1_0_asic_funcs = {
 	.encode_ext_smn_addressing = &soc_v1_0_encode_ext_smn_addressing,
 	.reset = soc_v1_0_asic_reset,
 	.reset_method = &soc_v1_0_asic_reset_method,
+	.query_video_codecs = &soc_v1_0_query_video_codecs,
 };
 
 static int soc_v1_0_common_early_init(struct amdgpu_ip_block *ip_block)
-- 
2.53.0

