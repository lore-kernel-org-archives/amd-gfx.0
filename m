Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497D9D6409B
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 15:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E082310ED0F;
	Wed, 17 Dec 2025 15:35:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d++sXwk/";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013026.outbound.protection.outlook.com
 [40.93.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E123910ED0F
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 15:35:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jt0/PEluimocudVZQ2XUY7ZeYs1Qs6Dr97AVnJXdtCGPPvYD9zN19dPXZoF2m24Hl7QH4nV4Dnbu8GGMe/WBBilbNrlk9A52IpQjAs6+Qvenb3nJN8YupgJ3TiXvVQIotc4xDmrmIl8uMfS/4lkwji5Ulqe71QPpAlh9TO4nsZPm9KXqHbJ/Glg5Lr4ahhx25wS8qMavJXKuI0He1FJE/bEFsnY7Y3RbJvTN7FdGmicDf9foX/H+y0ss8kgPcJMaNouImh5XLhYntxtq4DaZJnc7a30LvKnHZpC8xRwhcU6rdd9rqc4x7fO7jTBcbWsQV1qea/iRLKlSF+07eTJUEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEtnJ9m718Hi5Vc26uD1JWKO+3w69CIuO5dBzDXdLyc=;
 b=whrmZ0lYdgZrYlHXeBL6ipcXKK3b5VX6DWvpZIkWiQ9uYiqNn9G5lMgFnh4SzSxMJ536c72hS6vP8tl7vISz+ae1d6SuKyvo/Zcj+0m7CLC4ke4BTeCkaQmj3DwwlRaDGyNKX6f3DTbCum5ZTI0bSZdmefLbJ10cBS7P5Nungx0Oo0h2oEwzvtkPlnFtwG2FTZpPG37T5Fbi2xWGMVWYmcTzUs7xnprqL9vmimkKOxCw1KkHFsRFyV4ytp2ifD1WF2fvW3qjfnwV2wy5RD1r7k1sQiTuLSOQ9euu1M7/e1dtFLf04sommybWQ+D5bsvM9ezBUhbN2toZxxxk1lMlQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEtnJ9m718Hi5Vc26uD1JWKO+3w69CIuO5dBzDXdLyc=;
 b=d++sXwk/QAxUC/pt4jIyHU+Hvu2LTDWf05Dw95VRlsvrV/kkaxxHkdOfkUEbdl9MdlAeKt2Gqo2Br/B+ciTzP1MlA+TC465XiAQd5p5z2tGItGtuM3/mNUjUhbxU+CHvPKlh7vTn6zE+kIX8g6WOubvlKD3uXoKkji4a0XIIA9I=
Received: from BN9PR03CA0401.namprd03.prod.outlook.com (2603:10b6:408:111::16)
 by SA5PPF9D25F0C6D.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Wed, 17 Dec
 2025 15:35:42 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:111:cafe::cd) by BN9PR03CA0401.outlook.office365.com
 (2603:10b6:408:111::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 15:35:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 15:35:40 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 09:35:38 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu/discovery: add vcn and jpeg ip block
Date: Wed, 17 Dec 2025 10:35:19 -0500
Message-ID: <20251217153521.2018841-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217153521.2018841-1-alexander.deucher@amd.com>
References: <20251217153521.2018841-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|SA5PPF9D25F0C6D:EE_
X-MS-Office365-Filtering-Correlation-Id: 419bacd1-b189-4026-874e-08de3d81ef36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L9suNdYZ+szmB+y0D/T+0CG81HQAzgwuxUeEirYkySl8ZfFVvWFsi78Y4sI4?=
 =?us-ascii?Q?ZEBi38JaihzAw2SS0rewnZEC5ZIjT5ZXLAMLgYFFEf3YyjmxeLoOLkb6NinL?=
 =?us-ascii?Q?GsUH6A5b2LubLLYY/HaNOYQrhD7xsx9v0B4dbPHHT4Xu4vR1n1dcCCqB6kKt?=
 =?us-ascii?Q?oKA9EMUyNmv0TA+AadyqpyQNVNwKp8GyGsgdDnLfa9suUgKW3JxiQpDu553z?=
 =?us-ascii?Q?a3RhOis1esIywrZCkI345DJ8M/8DuZHnJUQsHSAOdG3VIYKjOyJGSYRG9N4S?=
 =?us-ascii?Q?6bt+Zw4g2dvd1D9bpf9NnrJcep53gi3UCGSHuM3LGOaFROtsmKASoTEzAUvs?=
 =?us-ascii?Q?WZobQFqLUvMFkRzA7JmU4GqBNwJZkrXYYuxZwjBF8LhepKKxfjngSdmZyTet?=
 =?us-ascii?Q?fu7cjvEYK3PR7eO4THxAYFRAzh9D6YOlljnJf7/xSjAbh6GgZp9a4ZTh3l8D?=
 =?us-ascii?Q?fXpSRHAeiJ0uJS2CO4yzOkWkOsMt5IE4p7/lYU9oe6Ww03thhIY9qUjeB6DO?=
 =?us-ascii?Q?0jcm07OPs8LcSclph91emjW7L05mZy+7ExmQsGq5M+l2ah9KTnjzFtYY+lE7?=
 =?us-ascii?Q?X16qahAmZgMsmvmOA0koscHnWbgD6okpoE4mN1GitOVGuk3epL1tt5+nE2Xy?=
 =?us-ascii?Q?e0uj5K0MnwFPFz5NxsCu0KnAOGeAoUWEDsURZN1c1yh5tLXO+LkoV+tUhL5i?=
 =?us-ascii?Q?52LPJfOsafQeVUBAbviJ2hhUbgyRxa1bj9cs4kzm56PzLIFUOvp3kvJg8zSh?=
 =?us-ascii?Q?yb89HNqYwmw4y7MFf0pix2fC5CnqC5S9xJsUZMvtLAp65e4lDF97Qe8PA5/A?=
 =?us-ascii?Q?Wve12eDxOq1mb7ADB8kIvHaoNfyazxKFhUlJbiLP6CoOxoqeKmZ8ht00wLvu?=
 =?us-ascii?Q?McNngFX/yXDPUhQ+IVjlfB95aAloyLQIuuiRSJEIOaC0CCLzoqbi7qCpXJSP?=
 =?us-ascii?Q?7XDAhxjtFH9SIPifjzw0NCagNjdF4ULzvlXG5Hz58TCQUXKA8mJRI2BCaM5A?=
 =?us-ascii?Q?RMJxYlo9eeVVNZp+UXvLjgvcBW9Kdf0i3LWrWruULLypAYpcAU29fdf7azxY?=
 =?us-ascii?Q?LHt5bUbgaSbaf/gNlycKOJqEUG68sFN4SuZlx8IWTbMu3M1FlFl+AIWZtEic?=
 =?us-ascii?Q?w9GrDslbPd17czgGVFFn04cOSBvqxGN+BLhh32siURN54Z/iGXJ40I+NkHlT?=
 =?us-ascii?Q?p156G3CPi/XDCrSohSAr06RY1PmPfHoTV8GShymyNzWnBUt+aN8eW17DfIE+?=
 =?us-ascii?Q?Uz0VszGuKdarsxyXAjNY4WGz+IHP9hhulObcnTxRxkXqceVEysULS0zEr3Ro?=
 =?us-ascii?Q?ndvUcNfsvsNvDXpB5cslfHVQl/XPuGVeqObB2dDXpoL2ZGOkxxwAcTipWO+S?=
 =?us-ascii?Q?+mTfnWn+jflUczHf/UR3BOe+dMOoOWaByeTLe/A+S4XO16pVvGiMj8Ci7mep?=
 =?us-ascii?Q?aM5FiopCoPNxOrH9l5LGgMxMpV4P04P5udatQ3ECam1oDwUUHrm19aevQgK5?=
 =?us-ascii?Q?8jN0DWaTcYiACJIyUGdNH0GHPklYPL4/X26UZOU3k9Nxyvkmi3FDS5SaXmtF?=
 =?us-ascii?Q?KgK/R78kw8jgncFE+d8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:35:40.6164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 419bacd1-b189-4026-874e-08de3d81ef36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9D25F0C6D
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

From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>

Add VCN and jpeg IPs v5_3_0 blocks.

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  6 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  2 +
 drivers/gpu/drm/amd/amdgpu/soc21.c            | 39 +++++++++++++++++--
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ac1b95b9a4f6a..43e6216ca30f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -112,6 +112,8 @@
 #include "vcn_v5_0_1.h"
 #include "jpeg_v5_0_0.h"
 #include "jpeg_v5_0_1.h"
+#include "jpeg_v5_3_0.h"
+
 #include "amdgpu_ras_mgr.h"
 
 #include "amdgpu_vpe.h"
@@ -2538,6 +2540,10 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &vcn_v5_0_0_ip_block);
 			amdgpu_device_ip_block_add(adev, &jpeg_v5_0_0_ip_block);
 			break;
+		case IP_VERSION(5, 3, 0):
+			amdgpu_device_ip_block_add(adev, &vcn_v5_0_0_ip_block);
+			amdgpu_device_ip_block_add(adev, &jpeg_v5_3_0_ip_block);
+			break;
 		case IP_VERSION(5, 0, 1):
 			amdgpu_device_ip_block_add(adev, &vcn_v5_0_1_ip_block);
 			amdgpu_device_ip_block_add(adev, &jpeg_v5_0_1_ip_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 5e0786ea911b3..75ae9b429420e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -63,6 +63,7 @@
 #define FIRMWARE_VCN4_0_6_1		"amdgpu/vcn_4_0_6_1.bin"
 #define FIRMWARE_VCN5_0_0		"amdgpu/vcn_5_0_0.bin"
 #define FIRMWARE_VCN5_0_1		"amdgpu/vcn_5_0_1.bin"
+#define FIRMWARE_VCN5_3_0		"amdgpu/vcn_5_3_0.bin"
 
 MODULE_FIRMWARE(FIRMWARE_RAVEN);
 MODULE_FIRMWARE(FIRMWARE_PICASSO);
@@ -90,6 +91,7 @@ MODULE_FIRMWARE(FIRMWARE_VCN4_0_6);
 MODULE_FIRMWARE(FIRMWARE_VCN4_0_6_1);
 MODULE_FIRMWARE(FIRMWARE_VCN5_0_0);
 MODULE_FIRMWARE(FIRMWARE_VCN5_0_1);
+MODULE_FIRMWARE(FIRMWARE_VCN5_3_0);
 
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
 static void amdgpu_vcn_reg_dump_fini(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 4e24aeecd9efb..2da733b45c21a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -141,6 +141,31 @@ static struct amdgpu_video_codecs sriov_vcn_4_0_0_video_codecs_decode_vcn1 = {
 	.codec_array = sriov_vcn_4_0_0_video_codecs_decode_array_vcn1,
 };
 
+static const struct amdgpu_video_codec_info vcn_5_3_0_video_codecs_encode_array_vcn0[] = {
+        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 0)},
+        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 0)},
+        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
+};
+
+static const struct amdgpu_video_codecs vcn_5_3_0_video_codecs_encode_vcn0 = {
+        .codec_count = ARRAY_SIZE(vcn_5_3_0_video_codecs_encode_array_vcn0),
+        .codec_array = vcn_5_3_0_video_codecs_encode_array_vcn0,
+};
+
+static const struct amdgpu_video_codec_info vcn_5_3_0_video_codecs_decode_array_vcn0[] = {
+        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
+        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
+        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
+        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
+        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
+};
+
+static const struct amdgpu_video_codecs vcn_5_3_0_video_codecs_decode_vcn0 = {
+        .codec_count = ARRAY_SIZE(vcn_5_3_0_video_codecs_decode_array_vcn0),
+        .codec_array = vcn_5_3_0_video_codecs_decode_array_vcn0,
+};
+
+
 static int soc21_query_video_codecs(struct amdgpu_device *adev, bool encode,
 				 const struct amdgpu_video_codecs **codecs)
 {
@@ -185,6 +210,12 @@ static int soc21_query_video_codecs(struct amdgpu_device *adev, bool encode,
 		else
 			*codecs = &vcn_4_0_0_video_codecs_decode_vcn0;
 		return 0;
+	case IP_VERSION(5, 3, 0):
+		if (encode)
+			*codecs = &vcn_5_3_0_video_codecs_encode_vcn0;
+		else
+			*codecs = &vcn_5_3_0_video_codecs_decode_vcn0;
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -800,9 +831,11 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
 		adev->external_rev_id = adev->rev_id + 0x50;
 		break;
 	case IP_VERSION(11, 5, 4):
-               adev->cg_flags = 0;
-               adev->pg_flags = 0;
-               adev->external_rev_id = adev->rev_id + 0x1;
+		adev->cg_flags = AMD_CG_SUPPORT_VCN_MGCG |
+			AMD_CG_SUPPORT_JPEG_MGCG;
+		adev->pg_flags = AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_JPEG;
+		adev->external_rev_id = adev->rev_id + 0x1;
                break;
 	default:
 		/* FIXME: not supported yet */
-- 
2.52.0

