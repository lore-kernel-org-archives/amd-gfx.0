Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06227C531D0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 07:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9710A10E657;
	Thu, 30 Jul 2026 07:20:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1B9hnLW3";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011051.outbound.protection.outlook.com [52.101.57.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8701A10E657
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 07:20:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7TPWdEtB/3aC7Qy9l7YWFwF7AJQXYn+zSdXPWoPaihNpuM6IcW70syjKz4PONAGrb7X00cJIGW4fduzlkKtbAkyCjy2dSuPanXe4hHtAJuIj55DZLWU4T+GOEu7XcouWNm2L5JkQoL5kL8RXcW6cqOj27FfVW1weX3WqGbbhv29I69e2hkZ5n2eXiwUFXM2QJi2jeNCVsn4pAMbTH2eD1v03SFz6kh75GpDBDiNbkHNWk0cT4bIAJfj2PYaTZ1XS4ZLMcVfxxuFYy6rbvB72EsgLpBqZcVNLZ2eHlv1YC0SN9V/iLwbnPCp36N2SwWKiOhRR7uYAzuyIaII0T1L8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=regh2U4MCzUP6auVkpEesdbvNvOHq9X4AoPyfn3SUV0=;
 b=qJ+NL/ISSbeC8nu95ezLcgJ7ffc6TpZP4HV0m5zUTFIIdtWfu3c4f+b4X1wtdvNhl/nDIEs1wUdf4cjTZGGGw5rl2Nh/I9z3TZ9Sy8AtGdaisfBuZ+Du5OSv+pjxbWu1WBOJ083gnhXBViHzYlmS+q+neCVF9ZcIlGol6YXL2bq2n2U7Vn0zm+pQlmz2U1s21rPUkNJT8RZAfZV73ujkIaA/xwUVhcXY4Rt8Npz3VQk8sZaxl9V2mqkfcyxz2dSvhn3O9mWwYPjJhN3KCr6LH+nUSL9172oU54Cq6xGFplkLUYcXrBUJSHb83WJfTtpFlJUruJD3CNswIM4q/EzcAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=regh2U4MCzUP6auVkpEesdbvNvOHq9X4AoPyfn3SUV0=;
 b=1B9hnLW3Ejk2oiC0FuIzqTJeCWgV6BPReaO9KfN3Tz17sBOx1rA66m7JgwsSM5Wx6bxe347NLiV4z/UKijmq6nZelvGUAzo2od72Yb/uhYKsQj3xW/awZO629lDp9Emsm/a/8F8DuqUWq0ucLB6zW+DzZvvzzXaav5kxuM9o+pQ=
Received: from BN0PR10CA0002.namprd10.prod.outlook.com (2603:10b6:408:143::16)
 by IA1PR12MB9522.namprd12.prod.outlook.com (2603:10b6:208:594::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 07:20:16 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:143:cafe::a4) by BN0PR10CA0002.outlook.office365.com
 (2603:10b6:408:143::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Thu,
 30 Jul 2026 07:20:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 07:20:16 +0000
Received: from work.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 02:20:15 -0500
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH] drm/amdgpu: Drop UVD buffer size checks in
 amdgpu_uvd_ring_parse_cs
Date: Thu, 30 Jul 2026 09:19:31 +0200
Message-ID: <20260730071930.5613-2-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|IA1PR12MB9522:EE_
X-MS-Office365-Filtering-Correlation-Id: 050b897c-9f97-491d-4912-08deee0b0121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: /8bBhDdw5Rz1HSkYQqv3gxSEOUsha0TxU+AykOtFrVBgMzotnpU7O2L9P/bFzUadXNjrTwHGJj1Ex/aDgs20LVlZGnhWb0CwEnQJYF1pcT4s3dD08hRSZ7ZYFmyFuvAyKSPDTbvTi52lEOLpOzQI3jt43wbG9chWESyEt+GGm7g+75lqP8KgMVBxrz6BD+9t5ZiiY9/KXQT1dpRWObanWlQFqwDeeb+jqvYuQgkgtOcldjbXaWUtdgmBtpo2nDdwo9cXtAKLB3D8HgKNb5Yzupgel8jGg+FtGmWqo+ak4ZanpX+7U4AraevJbYqrF+dqVibbWyziPEHJ3lhXiUGScx/EFCK8+RwXBxrYcSG7TDiNOi4Ph9kn0kn6SUZ3NR4DQKk0veeeROonUxqqKFhgUUj+3ueIgzNLMGVIx6MWlJ0EsPi2XFAHI9B1s4uaG1R0bBRKt1mPr5lhGndVej3uWvdvI+hMGOI/B0SnXJrcPULOnn8VJiWk5rJiqFb9qiMAbPAN/6lA4Or1y6bfM9U6RubAufZfOc2pnZUpDQs4ERBQfirhP6PPm7mKMnQvnE+Jd6vOEufMq9OApBgdZKW0jrPbn310mHTy43Y6upjLjeuyeoeN7yXSdcZX3QmI+kk3qv+1XJYYtsV6I9t1n8uWzn4nl7xtBhKfSvusdnfGqnKya5kYZlYNT4GwOj7CcavyZjn7LqWumlpKnp7qGAbNdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GDql8hlzkmy/zwX/P88XWHgtpVT/+Q8+dGUDBkFn0WNRfsp8O9NaotEEh9alZex7y3a2lSm0+kHc4gDS9/rOR1r7fz9zGrUavrXS+lKp+JFe6FcTZ0HLUFb4AGkWI8FjFdHdnz9KSpNz+dLbbn/4vmq29tfl4Lr4kvXNOB2vmwXBbvTy8pH2rfCYIBW0LJcDKOAObsWqFcBLhxX+laF6eYyJxjXJN87L9WS3iCBYZ1TFy8MugC+8zjOe0RRgN7Weeot3Nex3EJHK8R4wryi3KWY7s31Km3iLohxrnPpacrw2Ano5d3q3tp77vpB+tDVlZ2egNTQOGKZ/HeCrU2MO/TQGwQSetuJMkedZZlvMAjMvag/wXYTslAg6j58nNrgK623OgY0dxignLwQqZ9jMJUuiPjYeuIAKVKTeoektvxKpiqWsc96rsSKLU3DC7ZAz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 07:20:16.3801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 050b897c-9f97-491d-4912-08deee0b0121
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9522
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

This isn't doing anything useful. For H264/H265 DPB size it also incorrectly
forces lower bound on number of reference frames, but UVD FW only needs
as many slots as the decoded stream actually uses.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 239 +-----------------------
 1 file changed, 4 insertions(+), 235 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index e8b0c62f72be..f410a16a4f53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -103,9 +103,6 @@ struct amdgpu_uvd_cs_ctx {
 
 	/* does the IB has a msg command */
 	bool has_msg_cmd;
-
-	/* minimum buffer sizes */
-	unsigned int *buf_sizes;
 };
 
 #ifdef CONFIG_DRM_AMDGPU_SI
@@ -629,209 +626,6 @@ static int amdgpu_uvd_cs_pass1(struct amdgpu_uvd_cs_ctx *ctx)
 	return r;
 }
 
-/**
- * amdgpu_uvd_cs_msg_decode - handle UVD decode message
- *
- * @adev: amdgpu_device pointer
- * @msg: pointer to message structure
- * @buf_sizes: placeholder to put the different buffer lengths
- *
- * Peek into the decode message and calculate the necessary buffer sizes.
- */
-static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
-	unsigned int buf_sizes[])
-{
-	unsigned int stream_type = msg[4];
-	unsigned int width = msg[6];
-	unsigned int height = msg[7];
-	unsigned int dpb_size = msg[9];
-	unsigned int pitch = msg[28];
-	unsigned int level = msg[57];
-
-	unsigned int width_in_mb = width / 16;
-	unsigned int height_in_mb = ALIGN(height / 16, 2);
-	unsigned int fs_in_mb = width_in_mb * height_in_mb;
-
-	unsigned int image_size, tmp, min_dpb_size, num_dpb_buffer;
-	unsigned int min_ctx_size = ~0;
-
-	/* Reject invalid dimensions to prevent division by zero */
-	if (width < 16 || height < 16) {
-		dev_WARN_ONCE(adev->dev, 1,
-			      "Invalid UVD decoding dimensions (%dx%d)!\n",
-			      width, height);
-		return -EINVAL;
-	}
-
-	image_size = width * height;
-	image_size += image_size / 2;
-	image_size = ALIGN(image_size, 1024);
-
-	switch (stream_type) {
-	case 0: /* H264 */
-		switch (level) {
-		case 30:
-			num_dpb_buffer = 8100 / fs_in_mb;
-			break;
-		case 31:
-			num_dpb_buffer = 18000 / fs_in_mb;
-			break;
-		case 32:
-			num_dpb_buffer = 20480 / fs_in_mb;
-			break;
-		case 41:
-			num_dpb_buffer = 32768 / fs_in_mb;
-			break;
-		case 42:
-			num_dpb_buffer = 34816 / fs_in_mb;
-			break;
-		case 50:
-			num_dpb_buffer = 110400 / fs_in_mb;
-			break;
-		case 51:
-			num_dpb_buffer = 184320 / fs_in_mb;
-			break;
-		default:
-			num_dpb_buffer = 184320 / fs_in_mb;
-			break;
-		}
-		num_dpb_buffer++;
-		if (num_dpb_buffer > 17)
-			num_dpb_buffer = 17;
-
-		/* reference picture buffer */
-		min_dpb_size = image_size * num_dpb_buffer;
-
-		/* macroblock context buffer */
-		min_dpb_size += width_in_mb * height_in_mb * num_dpb_buffer * 192;
-
-		/* IT surface buffer */
-		min_dpb_size += width_in_mb * height_in_mb * 32;
-		break;
-
-	case 1: /* VC1 */
-
-		/* reference picture buffer */
-		min_dpb_size = image_size * 3;
-
-		/* CONTEXT_BUFFER */
-		min_dpb_size += width_in_mb * height_in_mb * 128;
-
-		/* IT surface buffer */
-		min_dpb_size += width_in_mb * 64;
-
-		/* DB surface buffer */
-		min_dpb_size += width_in_mb * 128;
-
-		/* BP */
-		tmp = max(width_in_mb, height_in_mb);
-		min_dpb_size += ALIGN(tmp * 7 * 16, 64);
-		break;
-
-	case 3: /* MPEG2 */
-
-		/* reference picture buffer */
-		min_dpb_size = image_size * 3;
-		break;
-
-	case 4: /* MPEG4 */
-
-		/* reference picture buffer */
-		min_dpb_size = image_size * 3;
-
-		/* CM */
-		min_dpb_size += width_in_mb * height_in_mb * 64;
-
-		/* IT surface buffer */
-		min_dpb_size += ALIGN(width_in_mb * height_in_mb * 32, 64);
-		break;
-
-	case 7: /* H264 Perf */
-		switch (level) {
-		case 30:
-			num_dpb_buffer = 8100 / fs_in_mb;
-			break;
-		case 31:
-			num_dpb_buffer = 18000 / fs_in_mb;
-			break;
-		case 32:
-			num_dpb_buffer = 20480 / fs_in_mb;
-			break;
-		case 41:
-			num_dpb_buffer = 32768 / fs_in_mb;
-			break;
-		case 42:
-			num_dpb_buffer = 34816 / fs_in_mb;
-			break;
-		case 50:
-			num_dpb_buffer = 110400 / fs_in_mb;
-			break;
-		case 51:
-			num_dpb_buffer = 184320 / fs_in_mb;
-			break;
-		default:
-			num_dpb_buffer = 184320 / fs_in_mb;
-			break;
-		}
-		num_dpb_buffer++;
-		if (num_dpb_buffer > 17)
-			num_dpb_buffer = 17;
-
-		/* reference picture buffer */
-		min_dpb_size = image_size * num_dpb_buffer;
-
-		if (!adev->uvd.use_ctx_buf) {
-			/* macroblock context buffer */
-			min_dpb_size +=
-				width_in_mb * height_in_mb * num_dpb_buffer * 192;
-
-			/* IT surface buffer */
-			min_dpb_size += width_in_mb * height_in_mb * 32;
-		} else {
-			/* macroblock context buffer */
-			min_ctx_size =
-				width_in_mb * height_in_mb * num_dpb_buffer * 192;
-		}
-		break;
-
-	case 8: /* MJPEG */
-		min_dpb_size = 0;
-		break;
-
-	case 16: /* H265 */
-		image_size = (ALIGN(width, 16) * ALIGN(height, 16) * 3) / 2;
-		image_size = ALIGN(image_size, 256);
-
-		num_dpb_buffer = (le32_to_cpu(msg[59]) & 0xff) + 2;
-		min_dpb_size = image_size * num_dpb_buffer;
-		min_ctx_size = ((width + 255) / 16) * ((height + 255) / 16)
-					   * 16 * num_dpb_buffer + 52 * 1024;
-		break;
-
-	default:
-		DRM_ERROR("UVD codec not handled %d!\n", stream_type);
-		return -EINVAL;
-	}
-
-	if (width > pitch) {
-		DRM_ERROR("Invalid UVD decoding target pitch!\n");
-		return -EINVAL;
-	}
-
-	if (dpb_size < min_dpb_size) {
-		DRM_ERROR("Invalid dpb_size in UVD message (%d / %d)!\n",
-			  dpb_size, min_dpb_size);
-		return -EINVAL;
-	}
-
-	buf_sizes[0x1] = dpb_size;
-	buf_sizes[0x2] = image_size;
-	buf_sizes[0x4] = min_ctx_size;
-	/* store image width to adjust nb memory pstate */
-	adev->uvd.decode_image_width = width;
-	return 0;
-}
-
 /**
  * amdgpu_uvd_cs_msg - handle UVD message
  *
@@ -875,7 +669,7 @@ static int amdgpu_uvd_cs_msg(struct amdgpu_uvd_cs_ctx *ctx,
 
 	switch (msg_type) {
 	case 0:
-		/* it's a create msg, calc image size (width * height) */
+		/* it's a create msg */
 		amdgpu_bo_kunmap(bo);
 
 		/* try to alloc a new handle */
@@ -896,11 +690,9 @@ static int amdgpu_uvd_cs_msg(struct amdgpu_uvd_cs_ctx *ctx,
 		return -ENOSPC;
 
 	case 1:
-		/* it's a decode msg, calc buffer sizes */
-		r = amdgpu_uvd_cs_msg_decode(adev, msg, ctx->buf_sizes);
+		/* it's a decode msg */
+		adev->uvd.decode_image_width = msg[6];
 		amdgpu_bo_kunmap(bo);
-		if (r)
-			return r;
 
 		/* validate the handle */
 		for (i = 0; i < adev->uvd.max_handles; ++i) {
@@ -965,22 +757,7 @@ static int amdgpu_uvd_cs_pass2(struct amdgpu_uvd_cs_ctx *ctx)
 	amdgpu_ib_set_value(ctx->ib, ctx->data1, upper_32_bits(start));
 
 	cmd = amdgpu_ib_get_value(ctx->ib, ctx->idx) >> 1;
-	if (cmd < 0x4) {
-		if ((end - start) < ctx->buf_sizes[cmd]) {
-			DRM_ERROR("buffer (%d) to small (%d / %d)!\n", cmd,
-				  (unsigned int)(end - start),
-				  ctx->buf_sizes[cmd]);
-			return -EINVAL;
-		}
-
-	} else if (cmd == 0x206) {
-		if ((end - start) < ctx->buf_sizes[4]) {
-			DRM_ERROR("buffer (%d) to small (%d / %d)!\n", cmd,
-					  (unsigned int)(end - start),
-					  ctx->buf_sizes[4]);
-			return -EINVAL;
-		}
-	} else if ((cmd != 0x100) && (cmd != 0x204)) {
+	if ((cmd >= 0x4) && (cmd != 0x100) && (cmd != 0x204) && (cmd != 0x206)) {
 		DRM_ERROR("invalid UVD command %X!\n", cmd);
 		return -EINVAL;
 	}
@@ -1109,13 +886,6 @@ int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser *parser,
 			     struct amdgpu_ib *ib)
 {
 	struct amdgpu_uvd_cs_ctx ctx = {};
-	unsigned int buf_sizes[] = {
-		[0x00000000]	=	2048,
-		[0x00000001]	=	0xFFFFFFFF,
-		[0x00000002]	=	0xFFFFFFFF,
-		[0x00000003]	=	2048,
-		[0x00000004]	=	0xFFFFFFFF,
-	};
 	int r;
 
 	job->vm = NULL;
@@ -1127,7 +897,6 @@ int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser *parser,
 	}
 
 	ctx.parser = parser;
-	ctx.buf_sizes = buf_sizes;
 	ctx.ib = ib;
 
 	/* first round only required on chips without UVD 64 bit address support */
-- 
2.43.0

