Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C133CE77170
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2024 17:36:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57FC110E5BF;
	Thu,  5 Dec 2024 17:36:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v+e39d2R";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F54D10E5DE
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2024 17:36:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FaplsNP4muJQ3Kn5WBmgwpsqwo57ew5D0c6WpxDTQVeCrZYZp16PkuavYqAF4PFoekwm/WAv8YlmG2Wxcdz7CbqgZv5R12O7Hv261EMw2chVom1saW3X0pylu44WDHNfPTCYZI0tPB7IZ+BkitaAZGoCCE1esuV5qiCoobuwZgUA5a6XyWIwYMObRbrbfFw+jh7dnjPvGkHFtaGY9qFplZu/7Y30Kp75U3GVaVOyAUGJXpx72yiE9cRvCEsurmJGcn050s3jvycoN1yyTbz51fBxNMUxDJKGTpDHbKMCNtps+Hi+kZHBv5bbQFXJILTbHJ/oFaM1bfIhOthjjpK0SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nktdCbtc5Mz4Ptx/RnsZJy6K57O0a5ESNKkstfw1Aw=;
 b=QMut0/6RPctutVMpTUyog/G8FPSxrm1HIDst0i0E3sbXovWyzFXuQFDeREmRBd/kzc3xrzyXXmMlRcXw1pWObdVm1ipGJw1MtLxQimQmonQpqb/60/xuPyt2RE58ixZ7bX/RLvFGVECZoxO+HjFol370jbwVTS/Q0Pw9PaPliKL00InBOpmHu+8Gii3UXLiwTdf7QisblEqvZlDJqOooQca94p6OzKQJ/9xCaN4NJm/5HoJ6piZgJSZKNHV7LkZGm+LfH9+ifnUDY9mgxtKwMmSqabypnP5y4R1/pIPGJQ2pByENAM1i5xdWRKw5CkNEvpZq8JpnvTKJetIxzFCl7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nktdCbtc5Mz4Ptx/RnsZJy6K57O0a5ESNKkstfw1Aw=;
 b=v+e39d2Rk3DeshxOtBM79gIa2ElFR/Nt7PMH0Tn3eO1ZJjpg9/lBFqdIK5xWRUIQ/sV0aLDFK3Iq5BGOZf4v69NpSDyAdUNUwydaLsNfKkAS2kpXEndMLXu2JbXMRWZqTzj9OFLfUUms6m0hEbbYg8AjzFyRA+h4KLmm51cDUkI=
Received: from BN9PR03CA0462.namprd03.prod.outlook.com (2603:10b6:408:139::17)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.23; Thu, 5 Dec
 2024 17:36:28 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::2e) by BN9PR03CA0462.outlook.office365.com
 (2603:10b6:408:139::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Thu,
 5 Dec 2024 17:36:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 17:36:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 11:36:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sonny Jiang <sonjiang@amd.com>, Leo Liu <leo.liu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 06/10] drm/amdgpu: Add VCN_5_0_1 codec query
Date: Thu, 5 Dec 2024 12:36:06 -0500
Message-ID: <20241205173610.334358-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205173610.334358-1-alexander.deucher@amd.com>
References: <20241205173610.334358-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e36ed2-366a-4d5d-8f9e-08dd155359ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HdYJm8N0RRKCxxT4wC6lwJc/YcvPUS4Qn0HMs7P9TldXOBIokfaNeguGWR2Z?=
 =?us-ascii?Q?T3Kj1F8w7Q5tnItw9lTirF6DYRyXI+1xKaeg56KeNgI2wkQfbADyv90q7o61?=
 =?us-ascii?Q?C8ZCHXFcxkzh3pEAdr6HRX5gAGHYc5/BlvN4ZqYhyRQ7MWHWVDFJRmxpn2q3?=
 =?us-ascii?Q?hd7Gniqnp3ZVfyxUoRUyevH2d037VebW1hDpeG6zxZiJg5Zx7jLPwoWxFlLG?=
 =?us-ascii?Q?YVRtZXrt6Yk6c+efc1Ah5W2E/Eux3W8qX24+CcbZQ4Ir5y9HkCQQcke3slj8?=
 =?us-ascii?Q?9hgYoAYIIAlR3VzbO+PMESYgceVkLyIQNsDoSDw1lXL75n82JQRcxWWIt7NH?=
 =?us-ascii?Q?/yQkvEiQyNQhTUPmFYDEcawwWnZh5b36bcrknwIZU5kF5tFyP/nCrH3Heb/A?=
 =?us-ascii?Q?tPL2x+APvMeo/x9dW+LzhLTTb0dUm3QQXz6t4aW1dlGUTNCoke9rwE6jD0+v?=
 =?us-ascii?Q?JKQ1hNiLkgtag/pLvOSNtByZkSuCIERf4+EiHPbA/DLP/tlegtIhnnFfQpCl?=
 =?us-ascii?Q?1GCJUqpMAQ1trd++ISYG5RoRESaHVhMfxQCxnJd+9sXHp+b4Qfkq5f6CovOc?=
 =?us-ascii?Q?vEDt98qiPn7sRnJL7Rmig82xbMHUjBvW8C65NMXBaW8rQWblApgG/Qxn4u/S?=
 =?us-ascii?Q?1ocB5wFY4aEPYKJRKvKAuJhNHsjm/+YCdkT4YHeealLPtHaUyNV6x9auGEIS?=
 =?us-ascii?Q?j6sHZIzPMtpahlJBggxFI7hL02fk7J0tJzTnT2huKBNtv168QQYlu5E2HBhT?=
 =?us-ascii?Q?GRINdCttd2SNDPqG5ST/JDqw9Mlk7MXMIKHfeCtHBgO0GZL/vTr5c50C70KO?=
 =?us-ascii?Q?bsom+lfus3H0/gUCA0N4Zx8ucL2XyNvrzPbbK07R/4lr8ngKK4pDPASasaLO?=
 =?us-ascii?Q?tBq6/7abNjXnp5+FIDAwycU0VVxqaeG44/xzn7q+wuPZMYHKBXZj7MD9DGQ+?=
 =?us-ascii?Q?C1qkbN13TF+K19wjQOt/rf3nSMPnhxG5swYuIE+3VVhx8UPDyMoR106WczPk?=
 =?us-ascii?Q?CKfCU/BqzJySMPqSU5z5ImeUhv6tnCdTXLndR9zSw1ZCXYyqsnVFje524627?=
 =?us-ascii?Q?wxIHwvuX39HRLzAtHjIdonSS75jAk24SJCpd4yRrYFFtVfqlQMo6sSkd/FXQ?=
 =?us-ascii?Q?gZVsWsiWM4vGm0hyAL0vajUTUqURdpZ0OhtD94ZOJeaYbzrlkAaa3Zr0cer3?=
 =?us-ascii?Q?yi8XyTwJ8JgtuOA8rE7PTjvo3itXgDkFxCHspO1JJlgJyQH3iPcWjO5v8ePn?=
 =?us-ascii?Q?8+SPvYFNIENt3cCzsRvrmk2BAjzz/B4DamZmGiif0cW0u3eiskU/hL8XoSXx?=
 =?us-ascii?Q?0giONGFEKqelenUxuE9LX5poZ6NmEgui+tVUTnxLqIvYEpI1Cgl1+8GEGaJv?=
 =?us-ascii?Q?5N5M0ULvDZdETaW7Db8s6ZyIu0T+Qcsb61IbZdYs3cIbU30JqqmgZkw1sCBh?=
 =?us-ascii?Q?PH2i0vrfjQWUw5CRWXPtJlGPOsSBFeZN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 17:36:28.6647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e36ed2-366a-4d5d-8f9e-08dd155359ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750
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

Support VCN_5_0_1 codec query

v2: squash in updates

Signed-off-by: Sonny Jiang <sonjiang@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 3bb4a573e07b2..a59b4c36cad73 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -171,6 +171,24 @@ static const struct amdgpu_video_codecs vcn_4_0_3_video_codecs_encode = {
 	.codec_array = NULL,
 };
 
+static const struct amdgpu_video_codecs vcn_5_0_1_video_codecs_encode_vcn0 = {
+	.codec_count = 0,
+	.codec_array = NULL,
+};
+
+static const struct amdgpu_video_codec_info vcn_5_0_1_video_codecs_decode_array_vcn0[] = {
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
+};
+
+static const struct amdgpu_video_codecs vcn_5_0_1_video_codecs_decode_vcn0 = {
+	.codec_count = ARRAY_SIZE(vcn_5_0_1_video_codecs_decode_array_vcn0),
+	.codec_array = vcn_5_0_1_video_codecs_decode_array_vcn0,
+};
+
 static int soc15_query_video_codecs(struct amdgpu_device *adev, bool encode,
 				    const struct amdgpu_video_codecs **codecs)
 {
@@ -209,6 +227,12 @@ static int soc15_query_video_codecs(struct amdgpu_device *adev, bool encode,
 			else
 				*codecs = &vcn_4_0_3_video_codecs_decode;
 			return 0;
+		case IP_VERSION(5, 0, 1):
+			if (encode)
+				*codecs = &vcn_5_0_1_video_codecs_encode_vcn0;
+			else
+				*codecs = &vcn_5_0_1_video_codecs_decode_vcn0;
+			return 0;
 		default:
 			return -EINVAL;
 		}
-- 
2.47.0

