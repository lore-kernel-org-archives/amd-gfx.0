Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B28C10F1A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 21:37:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D1EB10F5FC;
	Thu,  9 May 2024 21:37:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fjyDJYdZ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EA6810F5FC
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 21:37:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcpS6X0YJXU410ePwumjP9VA/zLwOz5lXgpAmp7gZ/ywyYd0pAW9g+NNP9vPstIR3DTtFkjdwenmn3EOSovWAJYP0RldESgKbt9LWb2iGmwOPbBoLKQvAgG9ME60zCO7LQOJtMu5uWDqhYR/FJTbJdZj1qGkTNId+S9I8L9Xudp4bVp4GLgFJ15jgmghDYyWqNKWsBfEP8C0Eqz0aQRF8jRfmw5mknOk25/bfCGrN0wy7CD/9aRhWiMZ3xP4ox7LF/sSODNXPpyaz33sYilAgRKjjFCHmoPwGejDADnblAYmRRAtPK5cgVjeRnV+3QDGeaj38Imy7Fdr/+pjLkSyDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pco7yx5uvO4kjI0lVnvfR9XrPUNW6yOP6NxareGM/zI=;
 b=c3J2i/d83NzKy+ri9+tckOTvsiHr+24aZLfqP6xaBGtjCzZvRxnxOeb1UxQaENGWUVx6lgT5JEKXPe5Gn2U5gVivnBAXmwqOyeO4wgTX7PdxNm4R7ax7PKBAkM4M/hMSpqc/nMoVvmju3mPEABqBsKyK05X3hoY9stqvkhdjv219cUgG7e1m4SEOil2AXy79KWMrgbN3do1MeswqG0/NIcxVAPpW4zlthajMJNP1JsbPMtD++ASNmaf0XBpCyYJt1If6vP0dRPm0mTeqwz9CMd5fgpwmxKJMICOmzGm97CKSGZRQEdJLrBqIKGMo4Zn/E8DQqm77ntdl0NhNUAvG6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pco7yx5uvO4kjI0lVnvfR9XrPUNW6yOP6NxareGM/zI=;
 b=fjyDJYdZzgoCIkU9Xwsz8W+aFTNKDRaXSa2m4eMVIdGUftbow/NErM0Z19SlTl5ELuturLy2v1mW6TVa/VnGIwNatG2KBUGQFtQyi8oSAgyb+UJLuLPzzIaG9Ids46ajbqmpFkUfBr9v1nPHb9nVgp36VowJ5r4r6lxP42+AiIg=
Received: from CH0PR03CA0402.namprd03.prod.outlook.com (2603:10b6:610:11b::23)
 by DM4PR12MB5891.namprd12.prod.outlook.com (2603:10b6:8:67::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Thu, 9 May
 2024 21:37:23 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::38) by CH0PR03CA0402.outlook.office365.com
 (2603:10b6:610:11b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48 via Frontend
 Transport; Thu, 9 May 2024 21:37:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 21:37:23 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 16:37:22 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Christian.Koenig@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>
Subject: [PATCH] drm/amd/amdgpu: update jpeg 5 capability
Date: Thu, 9 May 2024 17:37:09 -0400
Message-ID: <20240509213709.1495007-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|DM4PR12MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: df30d2ed-6db8-49d2-9e3e-08dc707036a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8dP0yp0OUork27Oieu8KMfoDwSInDnjJx6MebwhU4lV4kDP/FQ5FhgFxxr0Y?=
 =?us-ascii?Q?qXljLq5jPu9O7SUsu3EcMeUeBC2l4rPPa69PhnKv5HzjWBkrQ+cQJl0eM/fp?=
 =?us-ascii?Q?7o2pv22AymA/XTPLJYGUdrtYdubT/dPu+5+WTOAi2ecweYY3eUr/L+iWhfvJ?=
 =?us-ascii?Q?nwDT961D4iuk0B8t5cIqNKluTSV3Fc3kglJToLrHGIfJ7bLVW3KtBN8xFQ0Z?=
 =?us-ascii?Q?uXL5k25jCB3L/t2e7ojnhVoPWVGcqgOar+Rhy2/xz5rNAsYBXf4HYVuKQw63?=
 =?us-ascii?Q?wPWq0uyWzrkoUmVAIIE5liAoESSomzpGPS0o0UWYqPHFc/FuMCmADEz+1/Jt?=
 =?us-ascii?Q?BWv5F5MrNyQGMjuaawIxJlZgvHdAl1enxm2RG1SnogT2ai49VM45JvKmCjjN?=
 =?us-ascii?Q?gW9BdQfMDna5/MkWgIREoBqsW9eY/9lVLMQ97y7oJqbKg7uHAiqhQwGWUH3v?=
 =?us-ascii?Q?KqZnNJP90K3rWRqeYFOdqaQKfl9B8Vau2wd2XEnNhhMV3T65BHSpQXaZ/ePQ?=
 =?us-ascii?Q?/Rym/LlzNGVCpqMOZaTm6j0yqtEcW+8NHV3wRhzfLBEQaSmZqMAKkXB9d5lp?=
 =?us-ascii?Q?Db3OwzSj8L4XExakJNw8k6O7r8d3C211nwmQQTkyEcXIOYBq8LdsSmLKfYXz?=
 =?us-ascii?Q?tdu4twm6hQMhbMFvCTbeGNQpklGtqN+SaejDCDUcaGT1mZx9JgRaToejjay0?=
 =?us-ascii?Q?ZbgfUACFVJg2NIHN4dulzM4sw4DR0CtdfxIy9AEV7l080AknLFzN2CTRmCzi?=
 =?us-ascii?Q?JsUiy3r6i+REbL/54AHqW4N1RZjAuRCi8mhnOfCS8bqefIodVdU2RJ+jEZus?=
 =?us-ascii?Q?46bShIz6sS1ZpVvqwA7+WZ9a+RbAQR2r+vTAM70eLYuwHvw+rF8X6pV3D/pz?=
 =?us-ascii?Q?Np9yHPXjqcIH/pUMv5v/TkErGldbmBn1XUhhBfLo32H26cCfPdk0oGPbau9J?=
 =?us-ascii?Q?atAdNCDl4wjODNaxR3p86S4JRNWdToL82rU9n0F2HrN6P+VLyavhDOfZEQ0p?=
 =?us-ascii?Q?94xOakoUvW7RSEsgLQkt+C1zZQuQSAAMh5j+5tWyX+08DN7cMFnw7Av6ic66?=
 =?us-ascii?Q?cToB8Nmo0LO67FUyx3d1wCeZmLuM+pPMGPVuVZskJEs0MuvO9gYkL+1nCVRi?=
 =?us-ascii?Q?Vd0sIY1Xxy4ZbPXCAhJnGEBOfgqnUCliRse7HLUI2Ght/17dmw79yfi83aGq?=
 =?us-ascii?Q?qCwYFL6fT5kksnDFm3XEn3WKO5a2mAGM0gOjLuUrZviOecXeclSeA7QyyDQs?=
 =?us-ascii?Q?btuA4B3ofrQ+aiPhChpMqwLYNk9VVd7UQyydQF5vb1/UkdcLLrziS9DyCAPx?=
 =?us-ascii?Q?iDMGvdpyt+JwF5MeFzrKVcvqqqDgqHGFg5f+dIHc8oT70mOddwZNdHzEAR9V?=
 =?us-ascii?Q?g2tpcF8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 21:37:23.4327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df30d2ed-6db8-49d2-9e3e-08dc707036a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5891
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

Based on the documentation the maximum resolustion should
be 16384x16384.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc24.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 12900488dd61..285d6af10f62 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -61,7 +61,7 @@ static const struct amdgpu_video_codecs vcn_5_0_0_video_codecs_encode_vcn0 = {
 static const struct amdgpu_video_codec_info vcn_5_0_0_video_codecs_decode_array_vcn0[] = {
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2160, 52)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4320, 183)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
 };
-- 
2.34.1

