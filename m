Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF28CC77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 22:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA19510F323;
	Fri, 31 Mar 2023 22:39:46 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD4DE10F32F
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 22:39:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F83r/MFfigTpQdSu+u+7aLBCEel9h30PasL7/EPSz/wMW2OPZcU5in6YVB2D96c7rtHScseml0gzELfVCNbvVLdxubukEcEKMWZBwuEPm2BWtr32Lt62vAk7XPK4l1jvVursihsffhgXNdWBsg08rKjEmBc7pLi2HXWb920Hp56Y9CCqIxB8SIKwHFod9O/jgaD1OKJhXBfk942qVxlUxv+oNdKfzDCwKQkHruY2rFPjiY5b3Ruvw3WMirPoCJzKntD489qY6WFY5hOUBUtiwWM4UUQit1cyJDYqtxQtPDbSVnfZMdlqeXkZ9u1yZbRr9qtCCKun4xxw0ZCyO+3KoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSJfgwWCr17/WotAxMBE18OInJPtH3FJ/i7xqNU7G38=;
 b=KWm5L+qJCPOBJ6UxVRpA9On45+CNdRV1sm9nYyN11GGXismgC0+5nJEKQEFrIxBUgCuwZXErwjBnuPIhU3CGVgWqtCiN3/N7+JjMC+5VT+HyNp4aZ6unfccsIwID8cJeBFIuVV5ZzNOq/zCxF5DfcE9wWWh5oC+z1Khcz5kfcurxAy16X4NAmMA9/0yXguvPkg7GPV4FcgEowYSEpw7WSiwEIp/pBRyb5CEFQqvv+TQY1q6m2gPkiNx5Onw1j9nPxhYNe6aV6GppdRku4z3NwosCO9f+2hJpPNnL8qnU9NjBUXfs1KLRHWxA7zw5k0eAEwjzF85jjUTem9zBpOvhzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSJfgwWCr17/WotAxMBE18OInJPtH3FJ/i7xqNU7G38=;
 b=pTAUAPnKBgqHHPPTQn1uqHXxK5guML1UCOZXoUnHuSoYp10C1oIVk7+ADccaC+nM627vINBwXpoay6MECufnJfbZF2ZmVCtTDSndHm8M+vlyalDWKAdcuwNOmw/KPG0DX4uR7a3Cwxn66zHormlNZi9ji2BVtf+c+Eqe7boZrMQ=
Received: from CY8PR22CA0009.namprd22.prod.outlook.com (2603:10b6:930:45::16)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Fri, 31 Mar
 2023 22:39:43 +0000
Received: from CY4PEPF0000C97C.namprd02.prod.outlook.com
 (2603:10b6:930:45:cafe::d3) by CY8PR22CA0009.outlook.office365.com
 (2603:10b6:930:45::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Fri, 31 Mar 2023 22:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97C.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Fri, 31 Mar 2023 22:39:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 17:39:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add vcn_4_0_3 codec query
Date: Fri, 31 Mar 2023 18:39:25 -0400
Message-ID: <20230331223927.8388-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331223927.8388-1-alexander.deucher@amd.com>
References: <20230331223927.8388-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97C:EE_|BL0PR12MB4865:EE_
X-MS-Office365-Filtering-Correlation-Id: cf87ef28-3fce-4c1f-acda-08db3238d1fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bN4ZXc1kQxi0yTfCbOD2xoDeeohLkQ2H9frkQzwSSWBkSjiLR/7hmJWCeTkwkGiPwVEvkh53VQSOqodb/ZX6wNIuy1hCOjnB2hNum3lSbFtNmUtyAL58LjoTkw+QTefYqU7AgS/2VVzrdA2rQK9irj/roGxeh0/PcGefggLVE+po1cg7/IPOBBkAkSbD8VY3Ieb5ta6RRLDuLvHaibNzZQBhkkEXfNJ2k4ygJwq7iXZZAyJf6eS/Rbm62hfvP/1dLlrP+X+raB2HaEcRv69B+vTtqUhPuQcJytYnvCFSjsc2HYnwjSFHiyh2i3Fi5AVCAtn8ZBVXfW67OzFyI2o0JskSgRG+UzEg1JNxPC+tuZzEcbWrdAm1pEzOXtIvQ5Jy79TVsjQ1Ua3NDXT22iDzI3HjbdrsX6iKg59T2XkKYhBxIpsacP7VDb8v/FLHOne0mYJ2YtocZ06146v2CCK9m0Eqvj6EdreQ+T0NuyQf4/ky2q9ePwSd+LqCKpfe26Q79xvvF8UOtULe96hMqTyVZ4apAi6ACh9g9r38U+GwWZA1H2z7ZhA7YrmmsDAosZb5Z4K3pW4H9y4s+P6tCcrmAa46QHMQEfu/l2oUTApnPaxP6lLIsnn30YwcgyfJf1lLpBRIVfNO7M3Msc5sX/Q8rLJJuogvo0/HbFI/sXJRruWFURHSJZDRR0yYnuJwc7CQygSEemSLa+9D2B7XluxrCIc+0bzOR6AX9gpBErhM9pk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(6916009)(41300700001)(2616005)(8676002)(70206006)(70586007)(40460700003)(2906002)(36756003)(47076005)(86362001)(82740400003)(82310400005)(356005)(81166007)(36860700001)(5660300002)(40480700001)(336012)(26005)(426003)(54906003)(7696005)(8936002)(4326008)(16526019)(478600001)(186003)(6666004)(1076003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 22:39:42.4543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf87ef28-3fce-4c1f-acda-08db3238d1fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
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
Cc: Sonny Jiang <sonny.jiang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sonny Jiang <sonny.jiang@amd.com>

Add support for vcn_4_0_3 video codec query

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index d767a8834ef1..4626cae7eb18 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -153,6 +153,24 @@ static const struct amdgpu_video_codecs rn_video_codecs_decode =
 	.codec_array = rn_video_codecs_decode_array,
 };
 
+static const struct amdgpu_video_codec_info vcn_4_0_3_video_codecs_decode_array[] = {
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
+};
+
+static const struct amdgpu_video_codecs vcn_4_0_3_video_codecs_decode = {
+	.codec_count = ARRAY_SIZE(vcn_4_0_3_video_codecs_decode_array),
+	.codec_array = vcn_4_0_3_video_codecs_decode_array,
+};
+
+static const struct amdgpu_video_codecs vcn_4_0_3_video_codecs_encode = {
+	.codec_count = 0,
+	.codec_array = NULL,
+};
+
 static int soc15_query_video_codecs(struct amdgpu_device *adev, bool encode,
 				    const struct amdgpu_video_codecs **codecs)
 {
@@ -185,6 +203,12 @@ static int soc15_query_video_codecs(struct amdgpu_device *adev, bool encode,
 			else
 				*codecs = &rn_video_codecs_decode;
 			return 0;
+		case IP_VERSION(4, 0, 3):
+			if (encode)
+				*codecs = &vcn_4_0_3_video_codecs_encode;
+			else
+				*codecs = &vcn_4_0_3_video_codecs_decode;
+			return 0;
 		default:
 			return -EINVAL;
 		}
-- 
2.39.2

