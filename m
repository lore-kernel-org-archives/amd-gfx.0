Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63FBC19776
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 13:25:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B3A310E04D;
	Fri, 28 Feb 2025 13:25:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v27OB8HP";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0849A10E04D
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 13:25:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3uvFAx6OpuX/MPOuzAQHPNtk5W6m1ogB0OZK9/DBfazNuRYc2k30wReyqGMwKQfyxMjs+pNIGUI7+dyRRKIiNEsn1B/59Op4lKAi1Js/SK3g1ezpojujb28HYo9VAwdHl2+2itPeXg+SYjWlrcBGHnXLfJvfmfboee7KEDpEeQkW0GQ9rFbsomWcRAKNPjcVuYQEAWrYjDA2lM7snHddbd7d3SJWTqW1FJIt6e8vQRB7VOhXEGJGGF71H3YWCRmftCum2RejlJofso5l5/+JfML79SpMEiLniblCTw0RkymMSeeVcHqUe91sWuAcUg52992PQkSAh3T/lEmd+8Fqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiZsT0gVUTb3q8px9PSSY7SC46lhxH0Cw5R21Awcmac=;
 b=eOVdLTeXDiHDy29h3tz4O/nKa46uaftpDjGm+HpLuT8P388sDQUa7Bq+f4zweMkHpA901BdVQ/kmoAJM/JSYrYOSgeATj2aoQHnpkw8glCHeimqCn+cDIaTjR5KqGOwdluNEbDG7T96wciQOXWyy/kSPDg8/umRiAbqVF3uNbp+e10/sUyqgMa3PtLrluQt9EB/hHUQjTOm6pJ2mlCNVy9gIql7+HPQbqHqtCFwxl1mFXqm5EcFg7usRrniaA7dbDryiYPxJ2hY8ZJgjSZCrog/b61fH1gIjduJHlph2uscnwV5dv+3D8J8tyvbivdHbDywjDpH5lACgC4mxv/Dh5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiZsT0gVUTb3q8px9PSSY7SC46lhxH0Cw5R21Awcmac=;
 b=v27OB8HPbIcfjPgFO0tCDHbkgGYk9L+mkBzRV/eiXw8bQkLeKg9SO0mLuSxaXL4mp9F3FUtmGIQVu07HgIXKvnbfx5I2JvIDw7H54v2XF1ME292Rti6zRRlVjyMhCJyPipqNlA0vABNFVHw4Bg9G+bWBRJBw6xRiNJ4MwGVFLJ4=
Received: from BY3PR04CA0008.namprd04.prod.outlook.com (2603:10b6:a03:217::13)
 by DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 13:25:50 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::a8) by BY3PR04CA0008.outlook.office365.com
 (2603:10b6:a03:217::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Fri,
 28 Feb 2025 13:25:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 13:25:49 +0000
Received: from work.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 07:25:46 -0600
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Update SRIOV video codec caps
Date: Fri, 28 Feb 2025 14:24:32 +0100
Message-ID: <20250228132429.4842-7-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228132429.4842-4-david.rosca@amd.com>
References: <20250228132429.4842-4-david.rosca@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e61901-34aa-42d8-7c69-08dd57fb6a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cUVnvrHL7sRj6GbZKEBS75AJrTtcRWbV1LtjSarkr//5e7nqMv39sDpM1O3T?=
 =?us-ascii?Q?gwUzYBHwdGBC9xeQGo/0q97HEgOhYZPXpYdgdbT1k+ZzK2GJEQ+3yaWNjtMK?=
 =?us-ascii?Q?oPHFmg3PnjDurJT65sc9dvYwksMcJ9qd0ycUrXkvQjlheAVWQ2mRMjt06en9?=
 =?us-ascii?Q?JRWXMuizmFz65tzNadrukdnmdcmYRkoQCe+qW2wvUxAOhMLXtmGqoxYSkwTo?=
 =?us-ascii?Q?r5WTN89HqRpcQD+ehTzFOd9itG4zEur2rmmhgh5lm/wVZlQHM1EhEP7BcNrY?=
 =?us-ascii?Q?067xu+iFVbFxsaYwgwYIYUmRBTY+QiA2NLW5LV2Y2sqZqRwvBH/Ml63xST1U?=
 =?us-ascii?Q?Cm9BjurZ8orP740oouBjg1TTd6aAwhFpE/ZhGvbf1xbbIl63NMiNndQviDXC?=
 =?us-ascii?Q?H++mmOUyj8OEcpXerjxKeZaAXxh/HU2aleUuLCbkF0QrKZHjYH8E9RTK5b1b?=
 =?us-ascii?Q?92qknD2RHkRfSq7J5DfF5glvOT/vMAOgx6eY4YjpyLh32meKO5ixPCRaHgX0?=
 =?us-ascii?Q?v4jciQbcHXmayF+1usEJ2rYSaQX/cSpxZZPyUF2Rh0BEmSXU4UHkzfdIgr14?=
 =?us-ascii?Q?dDkAZpJJOVrhORf6RdSdZXKBJUS6n7V3P1DRLW5kgVK1s/v/lCmRzn3Gcijp?=
 =?us-ascii?Q?WxFHBVbaRudV9UUyGRHT5z+zv0X42AAzof16AhZ0PqDrw1RJFqrh2e52BuiW?=
 =?us-ascii?Q?82BeyDd8qo4gvbOnEhFEX162NzwTj6n3EN1pif3sYSB6T3bYND2iAz30rtoB?=
 =?us-ascii?Q?xjpXxzGoErw+jfkfoPt4rwZ6GYKImIqodW92zZhihcUo3tm2I6Ijcl1PJ3qq?=
 =?us-ascii?Q?1CShKaOsyu1uXoKPEXpIw0AyU0xRIPqG8Lnnv+Ynti1JLfsFprhSmYq2aIWY?=
 =?us-ascii?Q?DPhv1GjcGwqFbB2/fjzI7H22OjqW6XxMv405r4g+26ZaYd+ZwqrBPFghO3KP?=
 =?us-ascii?Q?WEbs8GL/+JCQRrJzKJO7igeMoJIs/ap6NXgh3GUyK1ZStQLnQOk70OyLiZPG?=
 =?us-ascii?Q?ylNFVfboRk8wVVkC5j9+5MkwdpL9RxvDZ3GHzOnadQMXhqcBbF7+c0u8vhe5?=
 =?us-ascii?Q?madTJC3ZO05ZNPEF6OzKIQ31Tzo2iZPbc8nrQfSIXQVJ4+THPUMGAZJGf5Sm?=
 =?us-ascii?Q?IlFDtiVgIYXaCy9HPn1cRy4nHHzgIcTxI0lc4xQxj2pzxRf8mNX6hEFAVyKL?=
 =?us-ascii?Q?sbst03u8u8nhfvDNWxpZh+/QIdJYNYwySN5XaBxy65hnZqxQMUVs8KiuCf3H?=
 =?us-ascii?Q?TcMECyPcArY0hW3ZBcjwfDoRG7qWe0jxdkLt0eQM9dunIv99WwCNeJMhAD/i?=
 =?us-ascii?Q?PVcBezDCc5dwPeiUiCjvQ/qtJtxfxAR/gewkLz+4dKO62XPM6XY4V1uScaSi?=
 =?us-ascii?Q?+/XyjUi5LQItkE7Wa68GiCP4lyeFhdJ5OGgcPWEqn3RhUCTdCvdXHnO/jZe8?=
 =?us-ascii?Q?oGXIu3GSw8+MRz9UDqRsX1NXjEZcbUr+1+WcAKri1MOUQEXDNVuaowSB6HYX?=
 =?us-ascii?Q?TPIzFBqc3Wtn+qI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 13:25:49.0885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e61901-34aa-42d8-7c69-08dd57fb6a82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399
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

There have been multiple fixes to the video caps that are missing for
SRIOV. Update the SRIOV caps with correct values.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c    | 16 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/soc21.c | 10 ++--------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 32b824c3658f..50e77d9b30af 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -141,23 +141,23 @@ static struct amdgpu_video_codec_info sriov_sc_video_codecs_encode_array[] = {
 };
 
 static struct amdgpu_video_codec_info sriov_sc_video_codecs_decode_array_vcn0[] = {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 1920, 1088, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 1920, 1088, 5)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 1920, 1088, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
 };
 
 static struct amdgpu_video_codec_info sriov_sc_video_codecs_decode_array_vcn1[] = {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 1920, 1088, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 1920, 1088, 5)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 1920, 1088, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index dd5d04c068f9..ad36c96478a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -117,23 +117,17 @@ static struct amdgpu_video_codecs sriov_vcn_4_0_0_video_codecs_encode_vcn1 = {
 };
 
 static struct amdgpu_video_codec_info sriov_vcn_4_0_0_video_codecs_decode_array_vcn0[] = {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
 };
 
 static struct amdgpu_video_codec_info sriov_vcn_4_0_0_video_codecs_decode_array_vcn1[] = {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 };
 
-- 
2.43.0

