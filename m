Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC40BC54E76
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jan 2023 20:00:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77B1710E32F;
	Tue, 17 Jan 2023 20:00:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57BF110E340
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jan 2023 20:00:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=latWD5tgC6yFtAScpDR6tloK96gIJac/u6f9JzMc/t22R3agRHHjbNwp04FF7fk4EApOWPltopq7Vz6auAXPQ1H3SfflVMTK6DBa7F5lsO6IP5AmXjYxvi4DmrdOA4ZzDaNcqBjBmVSfIHnjbjWfMgoypnUD+HW6uisGWaHuS8rYc7d5O4YAyzq/f4Nca4M6VLAlsotCsBxbJaZogVBdTua8/AJIh3aEWjvLRdk9ZfbO4i2zvsClHbg+Lnf1rNWlQAK0kAwZuisCaZOgI2LA0PDU3aqpJhZSv6oq4UGb8rXpN7yVYaaWLmsHNpj+HRipXrWEaIXnVZc14JXIgsRYDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n22Y1sNC3HY4yat1V66JqCrhyjgR90o/cecOc4I1ys4=;
 b=RvRt4cZlkowiC5e+CS6eTK13t0DwFx0n087s/9ZZfsgZsnj48IctmzJmveoDMxtr0Xuflu0O+JUGyHcAB53NrZ4wefYUjEg5IIXtfOiQd+K8xegFfZDAvAKt8mbSpmqG1/jbQ+Z0/rK5xaaC/dExW0gAFFqiLJGm/2rWQ//yC1q1jSjT9sU2974kmbqY7yNL5lxdvtmzl3NBTHW6yad7f/EPlbRncOAqNjIxGAi8uFlwsISsZ2FCT8Oq/nEsIKSa29izcQ3gpCJ2iHAoWZRmPX1DSt7Fp5M8sFgS3lurEcZYUehaijAAyf79Cvhisk+cZOIkLkaCliKPn53DAfjVeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n22Y1sNC3HY4yat1V66JqCrhyjgR90o/cecOc4I1ys4=;
 b=uqZaVSQhfNItctQLlnThLqJ7YZS3MEJxp+OUULOw23EmuPqvyVh2r8KBgP1fNOji5dRWQ4LZmRM+G29mejp5PnyCMJwnojIiTFWw3oG5Vg5FF1spgBEnV57J2N5xou5P+pp8zE5gibZlIYYfv0rxVrox+5LcU5rlnI0cnIJsiys=
Received: from MW4PR04CA0286.namprd04.prod.outlook.com (2603:10b6:303:89::21)
 by CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 20:00:06 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::1) by MW4PR04CA0286.outlook.office365.com
 (2603:10b6:303:89::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Tue, 17 Jan 2023 20:00:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Tue, 17 Jan 2023 20:00:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 17 Jan
 2023 14:00:04 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu/soc21: don't expose AV1 if VCN0 is harvested
Date: Tue, 17 Jan 2023 14:59:48 -0500
Message-ID: <20230117195949.1729608-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230117195949.1729608-1-alexander.deucher@amd.com>
References: <20230117195949.1729608-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT047:EE_|CY8PR12MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b53f3d9-a68d-4433-23d3-08daf8c56db9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AiGNHCWDDOMGd1AdZa5Zkcj+EAiJMC9UPcqb9Udb6N0GBQgiUIzveaITAk/d81Xkro2kzlM7nAkMX1Jy38MHABCFpqK+vPbhlrapPFiqMHDGAFkQBmBWlRMPl7S03P1hALuPQbYLqWFIdM77ss62/syxUezwnZ0xKv2mPTiSnkz18ms7uxhfdIgZaQU6lGUDulOD+wl3NUK/iOaFdBooo3EtX346zPJB+rAlP6ZR6ojeVpYyLjsHnvl0jt15ruDaXPSEyGbPgHxrDdYSICjGwAZSpNcfxCsDeAouaqNuTKCsATajjqc/GyCZlPNt2TjSbuRxDC2x+broPsmK2G7P9vmRPP7R/5+JWpH49JZhUJJXYwO75hcLTIFU33CQev3UtGvVZGfcT+wvfSIfFRWamhVao2C0j7LVCaNBjBszCyCAhb3/cJHcvEw5gTP5Ckrt1+h0QvzVD5S9AYo/fsG/t66rf8dX0ZgZLjnKRX2Soqel7VP/VwNDstqy4S9yH0sa1RwbG0G4luVHmAcqkhHBbTnh1gNPCC376zhiKKeSzqDHyqSFjK86isxmvnhvWBm5tR/OXsP2KtnkQm22QeO7vGqN4c42qKdYFGXj2TVy6A+J/UDXuCsWGrTGkYaBeqCrigk786XKFUh8hzjOXMGOs6UpoX3Q8Iw9SVxamUyfn5YoJwdtA7yQrBRqFU1ZRnEMoteVm4A9OjJAbj38535B1jilUNNoiyVZxemIeNSfplY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199015)(40470700004)(36840700001)(46966006)(36756003)(8676002)(356005)(86362001)(8936002)(4326008)(6916009)(5660300002)(70586007)(70206006)(2906002)(6666004)(82740400003)(83380400001)(36860700001)(81166007)(478600001)(316002)(7696005)(47076005)(40460700003)(40480700001)(82310400005)(41300700001)(1076003)(2616005)(336012)(426003)(26005)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 20:00:05.7879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b53f3d9-a68d-4433-23d3-08daf8c56db9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7099
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Only VCN0 supports AV1.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 61 +++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index bea6b499568a..e03cf7f766c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -48,20 +48,32 @@
 static const struct amd_ip_funcs soc21_common_ip_funcs;
 
 /* SOC21 */
-static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_encode_array[] =
+static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_encode_array_vcn0[] =
 {
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2304, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 2304, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
 };
 
-static const struct amdgpu_video_codecs vcn_4_0_0_video_codecs_encode =
+static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_encode_array_vcn1[] =
 {
-	.codec_count = ARRAY_SIZE(vcn_4_0_0_video_codecs_encode_array),
-	.codec_array = vcn_4_0_0_video_codecs_encode_array,
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2304, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 2304, 0)},
+};
+
+static const struct amdgpu_video_codecs vcn_4_0_0_video_codecs_encode_vcn0 =
+{
+	.codec_count = ARRAY_SIZE(vcn_4_0_0_video_codecs_encode_array_vcn0),
+	.codec_array = vcn_4_0_0_video_codecs_encode_array_vcn0,
 };
 
-static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_decode_array[] =
+static const struct amdgpu_video_codecs vcn_4_0_0_video_codecs_encode_vcn1 =
+{
+	.codec_count = ARRAY_SIZE(vcn_4_0_0_video_codecs_encode_array_vcn1),
+	.codec_array = vcn_4_0_0_video_codecs_encode_array_vcn1,
+};
+
+static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_decode_array_vcn0[] =
 {
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
@@ -70,23 +82,46 @@ static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_decode_array[
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
 };
 
-static const struct amdgpu_video_codecs vcn_4_0_0_video_codecs_decode =
+static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_decode_array_vcn1[] =
+{
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
+};
+
+static const struct amdgpu_video_codecs vcn_4_0_0_video_codecs_decode_vcn0 =
 {
-	.codec_count = ARRAY_SIZE(vcn_4_0_0_video_codecs_decode_array),
-	.codec_array = vcn_4_0_0_video_codecs_decode_array,
+	.codec_count = ARRAY_SIZE(vcn_4_0_0_video_codecs_decode_array_vcn0),
+	.codec_array = vcn_4_0_0_video_codecs_decode_array_vcn0,
+};
+
+static const struct amdgpu_video_codecs vcn_4_0_0_video_codecs_decode_vcn1 =
+{
+	.codec_count = ARRAY_SIZE(vcn_4_0_0_video_codecs_decode_array_vcn1),
+	.codec_array = vcn_4_0_0_video_codecs_decode_array_vcn1,
 };
 
 static int soc21_query_video_codecs(struct amdgpu_device *adev, bool encode,
 				 const struct amdgpu_video_codecs **codecs)
 {
-	switch (adev->ip_versions[UVD_HWIP][0]) {
+	if (adev->vcn.num_vcn_inst == hweight8(adev->vcn.harvest_config))
+		return -EINVAL;
 
+	switch (adev->ip_versions[UVD_HWIP][0]) {
 	case IP_VERSION(4, 0, 0):
 	case IP_VERSION(4, 0, 2):
-		if (encode)
-			*codecs = &vcn_4_0_0_video_codecs_encode;
-		else
-			*codecs = &vcn_4_0_0_video_codecs_decode;
+		if (adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0) {
+			if (encode)
+				*codecs = &vcn_4_0_0_video_codecs_encode_vcn1;
+			else
+				*codecs = &vcn_4_0_0_video_codecs_decode_vcn1;
+		} else {
+			if (encode)
+				*codecs = &vcn_4_0_0_video_codecs_encode_vcn0;
+			else
+				*codecs = &vcn_4_0_0_video_codecs_decode_vcn0;
+		}
 		return 0;
 	default:
 		return -EINVAL;
-- 
2.39.0

