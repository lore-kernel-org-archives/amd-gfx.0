Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413B7C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Nov 2022 14:52:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 350ED10E563;
	Wed, 23 Nov 2022 14:52:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E454610E213
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Nov 2022 14:52:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iopjenm2N011SGQy1KcJIJgoEw5eyRSUFIdBl71Cih2YTVQ/EgrL4pRSeR6RNV583j59asMMv4Peb0ieaBh6MdfxKs88D8bMjlDinTrJWvBOWsbfE4dv7T4OciQWk7ZOrHYHouJy7tkvGUu+PE7q42j51zumT22QJbisf/2FP3HZ8Tgk3j4mzs06ztnNtvA6J6H3O1JS40dKjvY0oUZKPu4NhJ/KW3W5SRoGrYDinOZ3TR7oWgemx+4UT8o5/wS8Y4Q+9onWGo92o8C8xt7P15IE1aTrXVr7FfVDCAv0nzcwImOal8EPvgkGiPXR0qyUtZtyj8AbLTQIbDEanIPMzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7zk/7rHGaCtHRlVE8J+BKvhTnK7X9QI9MsU/uJKrog=;
 b=lKRyZ+8AxtZKUoOBTiJNiMpTvuSmeRw1ly7kc2siFhRs2NMgNgtYNPB/13IWtNEko/uOtezMW1j7apU6n+B7a19tnr6/EpethVCLYznCW7nSQFQDNEL2IxxkReVs7ncagrbIcQN2byogdgylPC1fyqCwgU890QeIVUrc7aQvZhEWHSBLGwxrXAFrfrTso7WpvaLsKC4XUo5FG6WbIKXXAZNtuFVAtL6cU0Z8gTkve/hPa40n4B8/NIXX+N+/dZHYJEl04t2rbkQrLKBE80MHQrNLVakOcsivk/UbOODqrkdQNqkUlNxd2GXrImliLXk9+/jLIt4TOIkjsr5/bAjm2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7zk/7rHGaCtHRlVE8J+BKvhTnK7X9QI9MsU/uJKrog=;
 b=qHxXs312fZG+BGs5WcZwSwIlAIutNFJdb1IzyEqwVWbFyvXrNUCt0DkF/AtxqloFKMHJ9MWBSAsw8PbSHOBA+cF7nuwUsv2PPnwZzE4lD6CnOlbcfTL20N5mRPM4B1Bbykdcm4okKBkH07ieU7a9vtMo0QQ4LVB2p3K9dHWvY7E=
Received: from BN9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::7)
 by SA1PR12MB6702.namprd12.prod.outlook.com (2603:10b6:806:252::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 14:52:00 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::3f) by BN9P223CA0002.outlook.office365.com
 (2603:10b6:408:10b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.16 via Frontend
 Transport; Wed, 23 Nov 2022 14:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Wed, 23 Nov 2022 14:51:59 +0000
Received: from amd2-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 23 Nov 2022 08:51:57 -0600
From: <veerabadhran.gopalakrishnan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] amdgpu/nv.c: Corrected typo in the video capabilities
 resolution
Date: Wed, 23 Nov 2022 20:21:39 +0530
Message-ID: <20221123145139.1944700-1-veerabadhran.gopalakrishnan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT047:EE_|SA1PR12MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f36b89-3182-4972-8353-08dacd62465b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 22bPPfpSb2LJQzFEf9/Cu6JWvg970kR7LnH8ZkScUE+vEvDODJ/B2vngNf20hE17q/DDn6A4I9+iIUQ+nniMG/bhubWoMJHFmdrYfeKWU/Qyu9UcL0vOo7UTeg0pssUgvW4BznJIiYmKSsYoV2GG5bEjnpQKNovzUDwBnFnkxY+TFfBOX9DZxNFsHhTEDqnlsnTViJ6MWswnqo/SDnwQTTBZaq4YSul2i24beJ3TxS5pvInLDK4Pva3IkWpncFgpUG7azLWQ4wR3A3kBN+KZH34ykVw8hDg5geUTaEK+hu87xicnwdhDGKqjlgHPU4HoUDuzSqkxCi3WLCsc0uldv5+PF0GdAUGUXkVAW0QsxHaQh2lhvM3Kq2UeYrsAz7x9WZ5oLHfsJS/1Vc4fi1HfgPYo1Vx1M6SVCeL+8Urd2Ttv+c1ZlVOKX9FMX2rvj0RLWToLuVyr6AFg3iGtMfHmhPsPUDERZWmkClFpEjq7wPYL06KwLbf4U6GxOe2USIHVeEY4zABwRxDibrBM7APZF8PoI33f7qaiDEYmWt2M8rtJuhWGAo0uvayHZSnkbzuq3U6UcXwfte2qqKCPCctDwFfyLv/SwPEY8DIeTn3dy/cT+r5YMwj8KhHElM3T07ZbWzLANfRN5RLNmlt6Cnnu78znblCM/N1+18L8hG6Qnkk9aQbuN3OadNip8B33iWM5imdro64PdzEYsNJSgCURxsqnWlm2A5cjZpL3Gyey4kg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199015)(36840700001)(40470700004)(46966006)(83380400001)(36860700001)(86362001)(2906002)(81166007)(2876002)(8676002)(8936002)(4326008)(5660300002)(82310400005)(70206006)(40480700001)(41300700001)(40460700003)(7696005)(70586007)(356005)(6916009)(26005)(6666004)(426003)(16526019)(1076003)(2616005)(47076005)(54906003)(186003)(336012)(478600001)(316002)(82740400003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 14:51:59.6769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f36b89-3182-4972-8353-08dacd62465b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6702
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
Cc: Boyuan.Zhang@amd.com,
 Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>,
 leo.liu@amd.com, thong.thai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>

Corrected the typo in the 4K resolution parameters.

Signed-off-by: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c    | 28 ++++++++++++++--------------
 drivers/gpu/drm/amd/amdgpu/soc15.c | 24 ++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/soc21.c |  2 +-
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index b3fba8dea63c..6853b93ac82e 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -82,10 +82,10 @@ static const struct amdgpu_video_codecs nv_video_codecs_encode =
 /* Navi1x */
 static const struct amdgpu_video_codec_info nv_video_codecs_decode_array[] =
 {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4906, 3)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4906, 5)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4906, 52)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4906, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
@@ -100,10 +100,10 @@ static const struct amdgpu_video_codecs nv_video_codecs_decode =
 /* Sienna Cichlid */
 static const struct amdgpu_video_codec_info sc_video_codecs_decode_array[] =
 {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4906, 3)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4906, 5)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4906, 52)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4906, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
@@ -125,10 +125,10 @@ static struct amdgpu_video_codec_info sriov_sc_video_codecs_encode_array[] =
 
 static struct amdgpu_video_codec_info sriov_sc_video_codecs_decode_array[] =
 {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4906, 3)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4906, 5)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4906, 52)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4906, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
@@ -149,7 +149,7 @@ static struct amdgpu_video_codecs sriov_sc_video_codecs_decode =
 
 /* Beige Goby*/
 static const struct amdgpu_video_codec_info bg_video_codecs_decode_array[] = {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4906, 52)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 };
@@ -166,7 +166,7 @@ static const struct amdgpu_video_codecs bg_video_codecs_encode = {
 
 /* Yellow Carp*/
 static const struct amdgpu_video_codec_info yc_video_codecs_decode_array[] = {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4906, 52)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index e3b2b6b4f1a6..7cd17dda32ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -103,10 +103,10 @@ static const struct amdgpu_video_codecs vega_video_codecs_encode =
 /* Vega */
 static const struct amdgpu_video_codec_info vega_video_codecs_decode_array[] =
 {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4906, 3)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4906, 5)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4906, 52)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4906, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 4096, 186)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
 };
@@ -120,10 +120,10 @@ static const struct amdgpu_video_codecs vega_video_codecs_decode =
 /* Raven */
 static const struct amdgpu_video_codec_info rv_video_codecs_decode_array[] =
 {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4906, 3)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4906, 5)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4906, 52)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4906, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 4096, 186)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 4096, 4096, 0)},
@@ -138,10 +138,10 @@ static const struct amdgpu_video_codecs rv_video_codecs_decode =
 /* Renoir, Arcturus */
 static const struct amdgpu_video_codec_info rn_video_codecs_decode_array[] =
 {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4906, 3)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4906, 5)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4906, 52)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4906, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index b258e9aa0558..5f19b85ccbb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -61,7 +61,7 @@ static const struct amdgpu_video_codecs vcn_4_0_0_video_codecs_encode =
 
 static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_decode_array[] =
 {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4906, 52)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
-- 
2.34.1

