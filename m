Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F50C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  2 May 2022 19:08:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E619F10F17D;
	Mon,  2 May 2022 19:08:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7EE010F231
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 May 2022 19:08:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfDnGBifNoGY6QXEqC+ym6KEKjUbUHk8nftgWFdllz0psdFKgdl/GdPLWNp6RURmwt4ypblvxLuD3nSWKnB2F93FnouTUbiuCebEMb6h9BNE9sxRTb9o16H6dQTkPSeDme7tkrjbWiEJaTVJPggpTykAkvG7jLam3c5VIANR7GECMVFOAqoBXATg3++z2jCsIgb1mreZlC5YYDYWFtgT1K3I4wCnfXGBsU1m2SQlIaYMXVcUE6dluWCRxPnvZZsXDe+UoAnSC806ycy2ePM0+8tddGP+87tNSyTUKKmS0YAaZapyRY6WguF+wR7dW/1eh/qmgsKoJXtb8GQNi7ijXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLf3WUKoHv5x3H0qABflCHEQ8Zm6PW1bnFrTFAxCshc=;
 b=ILcseTOE95FQzRBMhpBdYSfxz2sVZCTwOikzu2+d3H/uVBuva4juu4/4pleJk2ZjROKpNctVurg/ONgaESYtr3t93WufUcmW+fZItFXEAjsqx4y3/HIBngR8+cH/aCwMcH0JxhK88DsTRxr2/TccczZhLwvrpAHnAX3eUZbz6nPQUGlwZV7lQmI/GYhY/8ZvVFqsTuYDkZkrBg6zPczHA9tQPm+FWO4V602GHAuPgli8nXmiJra0HJk1eG/nwaMcUpS7K+/2gBPat7g7Sz25PLToSGdLh2n+sUjFAGoQk2TDumiZsheBx72IHLspZc8T+9C6Smv5gd57mCB4h2HgGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLf3WUKoHv5x3H0qABflCHEQ8Zm6PW1bnFrTFAxCshc=;
 b=eiIf833XPY1aTdGPJziUz8EvHXSb9IwNF6ZAI8XZbdU/kAs+J80xgHj3cJwiO4O1WRfjJ1NdZN4Vg6s7ItKKu9k4Uydo91lYprMcKHz88pEQxR8hyfG983lTDNgRUwmz1vfAPNnkWF/l9j8Sj9vwVuca+jwWZxPQ44dKj2nDvNA=
Received: from MW4PR03CA0047.namprd03.prod.outlook.com (2603:10b6:303:8e::22)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Mon, 2 May
 2022 19:08:24 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::1) by MW4PR03CA0047.outlook.office365.com
 (2603:10b6:303:8e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Mon, 2 May 2022 19:08:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Mon, 2 May 2022 19:08:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 2 May
 2022 14:08:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/11] drm/amdgpu: add vcn_4_0_0 video codec query
Date: Mon, 2 May 2022 15:08:03 -0400
Message-ID: <20220502190804.784271-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502190804.784271-1-alexander.deucher@amd.com>
References: <20220502190804.784271-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 232da57b-df70-43e5-9292-08da2c6f21e7
X-MS-TrafficTypeDiagnostic: MW3PR12MB4460:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB44608397E87834BAA1AAC500F7C19@MW3PR12MB4460.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2cHcp/Fog56ctoIRzkt3AyuyUK2rad4rGNqlA7p5eh88UJjU4QYNwe4BCCUFs9TqdpWdC0P8tKd020UmXAb6mTbvXqZ4fyDnkUYixzjLQu3FnQWZduC5LWjAX8krNeZeCTTxRS4Vdq4owFSEpflWxegjiP4UR1vWxOfEsmctBxVKmhx0UjfOKKB79vUbmuZfNiclh1mIR82JLGLcnRJp1uJF+gWPD6PLiFy/7WmQW37LQE7YHjLXZSjEezll5+9qayElBRdpcNPsQbU1TBjfnru/VX0SN66grx/VQ7CKy5iLw9xL+eh7xlwrCjM2goGbe8H8+WKFmc4p7Y2lJga2Dp2jBAxEFxrqxHgy4nz3y/DqfRmC321+hfWaRe8wMGpjOs4xnC4zIHlXF7VDckE2OkYTGPHDsrNvT6A8FTwdxRPn+1Hw0VVo/VaOmbGGPu/TYFxmMO0qLo4ICRYG+5uSRAPpKqnXzPZrGPSA+jAeKt7a0RaHileIua7dHnridQtX78m+4QqLFVVUVrMfWMkKcFNdPOYej6kuXF6L5nhtcGsgxp4Koy8E7FVCB2xvhEDem5N0QHPNQ+0w3VXDyTXp2+2vCkJzzZRpcOSM6kxjh8y+IX2OIICPKQ3m4htin5/PqAB69+MwL7dBiG9OcBTVYfRElQXlxj8Ip/rBiv7HN4vG3w/VXkNIAUYrZT3X16f/zDhVSm3vkuz8s3DZ8mCAZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(356005)(47076005)(82310400005)(4326008)(36756003)(36860700001)(83380400001)(70206006)(70586007)(54906003)(5660300002)(2906002)(6666004)(26005)(7696005)(8936002)(86362001)(8676002)(508600001)(186003)(1076003)(336012)(81166007)(426003)(2616005)(16526019)(6916009)(40460700003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 19:08:24.6444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 232da57b-df70-43e5-9292-08da2c6f21e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Add vcn_4_0_0 video codec query.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 44 ++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 6b06f8f61e2e..9e689a1f2ea4 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -45,6 +45,49 @@
 
 static const struct amd_ip_funcs soc21_common_ip_funcs;
 
+/* SOC21 */
+static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_encode_array[] =
+{
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2304, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 2304, 0)},
+};
+
+static const struct amdgpu_video_codecs vcn_4_0_0_video_codecs_encode =
+{
+	.codec_count = ARRAY_SIZE(vcn_4_0_0_video_codecs_encode_array),
+	.codec_array = vcn_4_0_0_video_codecs_encode_array,
+};
+
+static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_decode_array[] =
+{
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4906, 52)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
+};
+
+static const struct amdgpu_video_codecs vcn_4_0_0_video_codecs_decode =
+{
+	.codec_count = ARRAY_SIZE(vcn_4_0_0_video_codecs_decode_array),
+	.codec_array = vcn_4_0_0_video_codecs_decode_array,
+};
+
+static int soc21_query_video_codecs(struct amdgpu_device *adev, bool encode,
+				 const struct amdgpu_video_codecs **codecs)
+{
+	switch (adev->ip_versions[UVD_HWIP][0]) {
+
+	case IP_VERSION(4, 0, 0):
+		if (encode)
+			*codecs = &vcn_4_0_0_video_codecs_encode;
+		else
+			*codecs = &vcn_4_0_0_video_codecs_decode;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
 /*
  * Indirect registers accessor
  */
@@ -451,6 +494,7 @@ static const struct amdgpu_asic_funcs soc21_asic_funcs =
 	.get_pcie_replay_count = &soc21_get_pcie_replay_count,
 	.supports_baco = &amdgpu_dpm_is_baco_supported,
 	.pre_asic_init = &soc21_pre_asic_init,
+	.query_video_codecs = &soc21_query_video_codecs,
 };
 
 static int soc21_common_early_init(void *handle)
-- 
2.35.1

