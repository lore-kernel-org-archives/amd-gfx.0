Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439F5C54E76
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jan 2023 20:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0C8710E1C1;
	Tue, 17 Jan 2023 20:00:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EC3A10E340
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jan 2023 20:00:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7WaeAgPAyGsNQT29kHkIgCCMDzT2jVeHr4oAA63ZvOS4Frp/JMI2Ynk/cqhyOVePla5iOL9flP4GnhK0yKMPTUUnNathRpHgZRTUsrcJK3YQg9NzoHN8BJZ1W1P8dRB9+37+GH3/NzMRJVW48pflwumOMtRZbH6Bd56qri+Cn6ErWl/LxL/aq8utBuRocr2Z9q2ui6b9XPSpLxCPUoidBfyBrHfAxkP0g+C3vE49kfudEBGafl1tNQvGWGYPlu5jO9BQXOo5C2QbOCHOxp37K2VWqo8BnFwj3obAE1Wku/MGjXvGLV2z3Ph8EoZltH34Eu3BcEPgj+zT743p9dvrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrgDZeMbtSVJaDqn5QxPmBTcdWK+tSiVbIxNg0x6SSU=;
 b=L+q3Qc/JzpxxhRpHwCMXKTMmMYQjm7+czYrVXcyrnyeB+J4j2EhV/+NO6dkKfbOVU/fB6YGe2GaMp+6Pr27nG/2WyleyM58dKWn4hcbo75BGJspt8/7m3tY4cOa3alod3WVht/+UGDyRY6RlhzP/UUSiEm+etW2k/HiRNXNGJkp/SH6AvzVHI1QX0oFnD7FqpQt0ZjDk0c20FgnwdLLxTj4HhB6y+2c7/WJ64cRwNjle2eXybz8MLIH7qp3DHkCQJbODb7MYVPTg4zV0A3qqB67Vfc1SvYKKzVEYlsgOiPAbtbsi9gIewPUY5wxOyg64PrYcuAwhGDQ/tIxg6tvwlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrgDZeMbtSVJaDqn5QxPmBTcdWK+tSiVbIxNg0x6SSU=;
 b=EZnIk8D6O+/Agvl2dQvAaJYZeO4W6dhLkeyCC8dTHHFbFwxIEb/cBQliYJC0yGGFiqaJq5U/fl/OzTuEFKfW/LVRkKi2ESdVh6WlnJR2KFOhWlp5J9X6OVP9E7mP1YIOsmeB8ABe1NgoXcTSl4YdaIQIvzD+cKxzL/D8UOoxOAI=
Received: from MW4PR04CA0286.namprd04.prod.outlook.com (2603:10b6:303:89::21)
 by BN9PR12MB5145.namprd12.prod.outlook.com (2603:10b6:408:136::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 20:00:04 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::c0) by MW4PR04CA0286.outlook.office365.com
 (2603:10b6:303:89::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Tue, 17 Jan 2023 20:00:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Tue, 17 Jan 2023 20:00:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 17 Jan
 2023 14:00:02 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu/nv: don't expose AV1 if VCN0 is harvested
Date: Tue, 17 Jan 2023 14:59:46 -0500
Message-ID: <20230117195949.1729608-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT047:EE_|BN9PR12MB5145:EE_
X-MS-Office365-Filtering-Correlation-Id: 09ee5a69-e3b0-4f7b-a8dd-08daf8c56cb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRlwIS73yVTy0iJ8JcoFZntmHKumHjNE35xTxjI0pBDkvwG75+NxuNX/r2AshKCmrleabh4kr7Knqp6Hc0t3nnqVhb+iwrTjrUnDLIsgn4uqCNGlDMkORsR8XamEgj/Wi66xcV2udNi2mddjQ+Nlr1HCUtlIU5P5+8Toa+VQR1Pb93pjAWdm3Z9qbRcCq5p1fYTPBOxH7FUToM0hus1YGzW9T1kVEJGAIrsi/uTHvR7nKd+iDVtTzDd44dfBZ4X8jxM52ZRxJ5neDsDKpIa8WRwdUI7HstXUdEXd77eZR2pZWkhlF6Ks4GkUXWVpbbkqNd1KetGpU4tRVQW4avBWWgiE+DOTJe+IXXLQDEFiPhXY1XNsCUophZJ18aeiuZowzlpC1QtFCxm9LU+b9MFtRZeJm/B1P04zAGd8If0s7EvkjkHfq1TEnQqJcbX7i3ObMkVB1I4p2z4mDL/aMN/KOv+pRlt/luoB38R0u094ZNM43c6t7R0hx5gQIAwR6e4G6zTnLjGDzgedAdRyeBo3WAnw9l6oAuwTrjJW/sMoEiRpQu9daqZXgjqosDTiIY6yhggAwl68VTwnoIwVr+Ajh1dQG/d6TzNE/LZIO5Ff9tkZR6MwZOJdyfkWMFw7psVzFSwmMlP+BIOPnxR5Nr8BFuFA19gFQwf2oCn5kT2Csl0aMoyNr1mrz78obBitMvv0arvR2YVcj/NW2YZrDd0jTSx/UTD1gKn0dZ1FRJ8ETQ0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(83380400001)(82310400005)(40460700003)(16526019)(7696005)(40480700001)(36756003)(478600001)(186003)(81166007)(356005)(36860700001)(2616005)(82740400003)(1076003)(47076005)(336012)(86362001)(426003)(2906002)(26005)(6666004)(70206006)(8936002)(8676002)(6916009)(70586007)(4326008)(316002)(5660300002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 20:00:04.1161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ee5a69-e3b0-4f7b-a8dd-08daf8c56cb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5145
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
 drivers/gpu/drm/amd/amdgpu/nv.c | 101 +++++++++++++++++++++++++-------
 1 file changed, 81 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 6853b93ac82e..d972025f0d20 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -98,7 +98,7 @@ static const struct amdgpu_video_codecs nv_video_codecs_decode =
 };
 
 /* Sienna Cichlid */
-static const struct amdgpu_video_codec_info sc_video_codecs_decode_array[] =
+static const struct amdgpu_video_codec_info sc_video_codecs_decode_array_vcn0[] =
 {
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
@@ -110,10 +110,27 @@ static const struct amdgpu_video_codec_info sc_video_codecs_decode_array[] =
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
 };
 
-static const struct amdgpu_video_codecs sc_video_codecs_decode =
+static const struct amdgpu_video_codec_info sc_video_codecs_decode_array_vcn1[] =
 {
-	.codec_count = ARRAY_SIZE(sc_video_codecs_decode_array),
-	.codec_array = sc_video_codecs_decode_array,
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
+};
+
+static const struct amdgpu_video_codecs sc_video_codecs_decode_vcn0 =
+{
+	.codec_count = ARRAY_SIZE(sc_video_codecs_decode_array_vcn0),
+	.codec_array = sc_video_codecs_decode_array_vcn0,
+};
+
+static const struct amdgpu_video_codecs sc_video_codecs_decode_vcn1 =
+{
+	.codec_count = ARRAY_SIZE(sc_video_codecs_decode_array_vcn1),
+	.codec_array = sc_video_codecs_decode_array_vcn1,
 };
 
 /* SRIOV Sienna Cichlid, not const since data is controlled by host */
@@ -123,7 +140,7 @@ static struct amdgpu_video_codec_info sriov_sc_video_codecs_encode_array[] =
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 2304, 0)},
 };
 
-static struct amdgpu_video_codec_info sriov_sc_video_codecs_decode_array[] =
+static struct amdgpu_video_codec_info sriov_sc_video_codecs_decode_array_vcn0[] =
 {
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
@@ -135,16 +152,33 @@ static struct amdgpu_video_codec_info sriov_sc_video_codecs_decode_array[] =
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
 };
 
+static struct amdgpu_video_codec_info sriov_sc_video_codecs_decode_array_vcn1[] =
+{
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
+};
+
 static struct amdgpu_video_codecs sriov_sc_video_codecs_encode =
 {
 	.codec_count = ARRAY_SIZE(sriov_sc_video_codecs_encode_array),
 	.codec_array = sriov_sc_video_codecs_encode_array,
 };
 
-static struct amdgpu_video_codecs sriov_sc_video_codecs_decode =
+static struct amdgpu_video_codecs sriov_sc_video_codecs_decode_vcn0 =
 {
-	.codec_count = ARRAY_SIZE(sriov_sc_video_codecs_decode_array),
-	.codec_array = sriov_sc_video_codecs_decode_array,
+	.codec_count = ARRAY_SIZE(sriov_sc_video_codecs_decode_array_vcn0),
+	.codec_array = sriov_sc_video_codecs_decode_array_vcn0,
+};
+
+static struct amdgpu_video_codecs sriov_sc_video_codecs_decode_vcn1 =
+{
+	.codec_count = ARRAY_SIZE(sriov_sc_video_codecs_decode_array_vcn1),
+	.codec_array = sriov_sc_video_codecs_decode_array_vcn1,
 };
 
 /* Beige Goby*/
@@ -181,20 +215,37 @@ static const struct amdgpu_video_codecs yc_video_codecs_decode = {
 static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
 				 const struct amdgpu_video_codecs **codecs)
 {
+	if (adev->vcn.num_vcn_inst == hweight8(adev->vcn.harvest_config))
+		return -EINVAL;
+
 	switch (adev->ip_versions[UVD_HWIP][0]) {
 	case IP_VERSION(3, 0, 0):
 	case IP_VERSION(3, 0, 64):
 	case IP_VERSION(3, 0, 192):
 		if (amdgpu_sriov_vf(adev)) {
-			if (encode)
-				*codecs = &sriov_sc_video_codecs_encode;
-			else
-				*codecs = &sriov_sc_video_codecs_decode;
+			if (adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0) {
+				if (encode)
+					*codecs = &sriov_sc_video_codecs_encode;
+				else
+					*codecs = &sriov_sc_video_codecs_decode_vcn1;
+			} else {
+				if (encode)
+					*codecs = &sriov_sc_video_codecs_encode;
+				else
+					*codecs = &sriov_sc_video_codecs_decode_vcn0;
+			}
 		} else {
-			if (encode)
-				*codecs = &nv_video_codecs_encode;
-			else
-				*codecs = &sc_video_codecs_decode;
+			if (adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0) {
+				if (encode)
+					*codecs = &nv_video_codecs_encode;
+				else
+					*codecs = &sc_video_codecs_decode_vcn1;
+			} else {
+				if (encode)
+					*codecs = &nv_video_codecs_encode;
+				else
+					*codecs = &sc_video_codecs_decode_vcn0;
+			}
 		}
 		return 0;
 	case IP_VERSION(3, 0, 16):
@@ -202,7 +253,7 @@ static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
 		if (encode)
 			*codecs = &nv_video_codecs_encode;
 		else
-			*codecs = &sc_video_codecs_decode;
+			*codecs = &sc_video_codecs_decode_vcn0;
 		return 0;
 	case IP_VERSION(3, 1, 1):
 	case IP_VERSION(3, 1, 2):
@@ -993,9 +1044,19 @@ static int nv_common_late_init(void *handle)
 
 	if (amdgpu_sriov_vf(adev)) {
 		xgpu_nv_mailbox_get_irq(adev);
-		amdgpu_virt_update_sriov_video_codec(adev,
-				sriov_sc_video_codecs_encode_array, ARRAY_SIZE(sriov_sc_video_codecs_encode_array),
-				sriov_sc_video_codecs_decode_array, ARRAY_SIZE(sriov_sc_video_codecs_decode_array));
+		if (adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0) {
+			amdgpu_virt_update_sriov_video_codec(adev,
+							     sriov_sc_video_codecs_encode_array,
+							     ARRAY_SIZE(sriov_sc_video_codecs_encode_array),
+							     sriov_sc_video_codecs_decode_array_vcn1,
+							     ARRAY_SIZE(sriov_sc_video_codecs_decode_array_vcn1));
+		} else {
+			amdgpu_virt_update_sriov_video_codec(adev,
+							     sriov_sc_video_codecs_encode_array,
+							     ARRAY_SIZE(sriov_sc_video_codecs_encode_array),
+							     sriov_sc_video_codecs_decode_array_vcn1,
+							     ARRAY_SIZE(sriov_sc_video_codecs_decode_array_vcn1));
+		}
 	}
 
 	return 0;
-- 
2.39.0

