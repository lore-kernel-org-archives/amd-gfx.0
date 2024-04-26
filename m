Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B19C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 18:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E2B511A8D1;
	Fri, 26 Apr 2024 18:50:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mFxMydfy";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0999211A8D1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 18:50:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XH8YBF6LSF1JHBl09WqBoQU2aH62jmqShwjDBLnm2MmRMmM+XoR13tS/laox+skoIJgCxJDf4m23l1/SupKt3YWv6gel5o0GvF/8RJop8Ycij3zeaW1wuaxLWWjKMR51P9zTXi7DbPpQMxQrd8xIKWLW/pSuvlyT00V9RcMW6oPw9z6LHHYEazGMzhAsagS9zxgZ3QgfzEfuJ8zKQnAUXn/rZufg0ihvvCZl4Z1vlBrsNs9OilHhLoOFVMvTopZR9o31GiBr4rHLhNRCxJreoYSVU47PWmTGTt7hwmyPqgI7TfJvPJj1gLlunvrO2my6Hq66FNhqWBnKflYP6SDQbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jgQ46hvCqzp/kXMF1X4XiW80KbIiRfMxycuPwEBA5M=;
 b=ZQbnBBAbuO3aGsrBRJ2+YgdBrP6A0GyrCIMxdd1jhaFHkPfUDUCFC1fNXbp6Mtr4YPIcUnR0j5hHg48D3SwXttx1iXwoscENvhUtzWNyvfC4AW/n20E3WNQzVSMr4D4Szn5yEx0FPCz4+pc1z5AoYcbn2Vrwm2Ef/w1VIFfO43xdSPx7Ar2rpmUwIUexFwfi7yysjmNwwsTSUPgXdRLQ8x+piCY4YMSFGp2GxyTZn6i+qk3+gqIVBk/H0vvgB/hhw0NMz3x2gU4cdlYQsPMH9s+0bUrKvJsgClX+ZEayA+NOyehHAMeGk54XTqbHQecKXqyiAAOkat7/APLBDEUWmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jgQ46hvCqzp/kXMF1X4XiW80KbIiRfMxycuPwEBA5M=;
 b=mFxMydfy3fdO6laSMyas+j39tWGz/TEhnI+GvokrZxZzKPkvY1nGUHTNen2xkNGYZBmvJajJGtO5ZtC30aJzZDxTQWVe0hIHRXgUZXKXAdIMN2wqhuCYggFCcsBVpiR7sEyWuNv+IuvZZb7dh6l8kQ0JpWKm0W3lOHhZWameGVM=
Received: from MW4PR03CA0054.namprd03.prod.outlook.com (2603:10b6:303:8e::29)
 by CH3PR12MB9145.namprd12.prod.outlook.com (2603:10b6:610:19b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 18:50:37 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::f7) by MW4PR03CA0054.outlook.office365.com
 (2603:10b6:303:8e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24 via Frontend
 Transport; Fri, 26 Apr 2024 18:50:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 18:50:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 13:50:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 5/7] drm/amdgpu: support SDMA v3 struct fw front door load
Date: Fri, 26 Apr 2024 14:50:15 -0400
Message-ID: <20240426185017.660146-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426185017.660146-1-alexander.deucher@amd.com>
References: <20240426185017.660146-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|CH3PR12MB9145:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a67b6d-a1b7-4765-13c6-08dc6621c34b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zqbT1i+/0zkmFXIZ/YCICGJS2JOynNvYItRgsCm4UIPlOWLmMKf4C0DPNMlS?=
 =?us-ascii?Q?O1AqcMRjGKHDNPGzypNOtV1FYPr9TpIAA5xcGDhr1vrS5KhMV/jE7QyiWBQw?=
 =?us-ascii?Q?9/a5EK35wHIi/sMXFdaYmb45t8JsGR18yStRG0SA5gtvKQY018OkGnu0nR68?=
 =?us-ascii?Q?Ff6dhHscoxsqPC/8u6CHXQ/TrQam0yyExAd92MJWe2hR9S9SlUcGUtbjotqr?=
 =?us-ascii?Q?XqlwSa+277qSCaLEqhVugQAQBlPIMOdVI2rks5yajxN3uowpRc/wyjuxVQFc?=
 =?us-ascii?Q?K+h2h/9dloHo3TduHd/XEwi6TncYAGzPMCNz6+xQMvxX4vxysImXTLU6Bkem?=
 =?us-ascii?Q?ejmgReLIirjMN4eFaX5lzk1bE0a21TKib3Wc6iPorZoswo7wbzMu3+HNcgz9?=
 =?us-ascii?Q?urCJYxeFdc8I7IOOwtIYgFothZpo/OBh3HHneDDxajSFiRhRJJmaB1084zr9?=
 =?us-ascii?Q?ho3QRLt/uN7psLPn+1yXtfouWf7spahz6zF+7aBuAyXrHLGJw4G+8biinJae?=
 =?us-ascii?Q?i8g1rVC8AibWsSnYjiUxCSg47lSuzaAAGjlf0IVf6Z1uTdjnUL/Y6elfQjjM?=
 =?us-ascii?Q?Nq/K7BTsgPOI1+6/Rhp4W9aCdlWDbuLYpzE5GLsQMdEo3/9Ult2RG82iMdIE?=
 =?us-ascii?Q?BfXU3/Y2cGaGVVQtlQ0Du08VUm7A+1QIbdDgE7sgUEn7TE32GI+T3koeQwCL?=
 =?us-ascii?Q?NIyuZzCNvh3cxeMMmQwaX1xZockgFJnSPEuM91R4Q7Xwmacu2ROpCTQtIBun?=
 =?us-ascii?Q?VIHyCNTHIHpxegJg85Z8QrBG64ouNaV6uAuH1F4OOTKdWYVJPVDlD5a0aYLR?=
 =?us-ascii?Q?BMdyvK6suvKJLs+m1XWHlraRRaSMYBjuurNEwSdSFa7ebXQxqT/lx/JVCCJz?=
 =?us-ascii?Q?STtj9QR438MVsfNKY0Hrh06i8yYFILv8bjrB1mtc4A8LBP4XI/Px/fJyYlZR?=
 =?us-ascii?Q?gjmi4lLNeuFELTmybexxybCEKhsktAI4E0+6HNb4KLVEKS6MbC0QeBcdfgc/?=
 =?us-ascii?Q?gRa0Zhx+38zygKNZ0eN5RvH8C0CjWo8vYQrvRTfMdGFjUfP6XBcdETTd3vxL?=
 =?us-ascii?Q?8GaaYoFzHHQFp1DbjPWhcd7HlCGs6f0SY4SANUj0z7/+i2dedjgmC9zyFCIM?=
 =?us-ascii?Q?5asdjBoCn+XvL766+MGjH5c7cCDxw/DphnXHIexbjp+Ysht3JX2EB3hC3NND?=
 =?us-ascii?Q?jLFdDS8gMyVjxz8dS3NycTj6zN/suEP7eTw+y6SJYb3ImT4vtWXyWSAIGjXN?=
 =?us-ascii?Q?o96kNB+ybJFQyN8Uhptl6fm2aCi0ADX64zL0MNkwoJhCfXMldBRPJy+9LEY+?=
 =?us-ascii?Q?YODl0xLUjyCOStGPbVZxv/Xc+BRhCe0VI6nA5gN9i/9CvvTBBbywFBI7p9Iy?=
 =?us-ascii?Q?7/Ig+fM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 18:50:37.4011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a67b6d-a1b7-4765-13c6-08dc6621c34b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9145
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

From: Likun Gao <Likun.Gao@amd.com>

Add support for new SDMA firmware struct (V3) with PSP
front door load type.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c  | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  1 +
 4 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 4bd4602d11b1..a551c5b67fdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2464,6 +2464,7 @@ static int psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 		*type = GFX_FW_TYPE_DMUB;
 		break;
 	case AMDGPU_UCODE_ID_SDMA_UCODE_TH0:
+	case AMDGPU_UCODE_ID_SDMA_RS64:
 		*type = GFX_FW_TYPE_SDMA_UCODE_TH0;
 		break;
 	case AMDGPU_UCODE_ID_SDMA_UCODE_TH1:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index f0aac8ced4dc..6d23588ef2a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -212,6 +212,7 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
 	const struct common_firmware_header *header = NULL;
 	int err, i;
 	const struct sdma_firmware_header_v2_0 *sdma_hdr;
+	const struct sdma_firmware_header_v3_0 *sdma_hv3;
 	uint16_t version_major;
 	char ucode_prefix[30];
 	char fw_name[52];
@@ -287,6 +288,15 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
 			adev->firmware.fw_size +=
 				ALIGN(le32_to_cpu(sdma_hdr->ctl_ucode_size_bytes), PAGE_SIZE);
 			break;
+		case 3:
+			sdma_hv3 = (const struct sdma_firmware_header_v3_0 *)
+				adev->sdma.instance[0].fw->data;
+			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_SDMA_RS64];
+			info->ucode_id = AMDGPU_UCODE_ID_SDMA_RS64;
+			info->fw = adev->sdma.instance[0].fw;
+			adev->firmware.fw_size +=
+				ALIGN(le32_to_cpu(sdma_hv3->ucode_size_bytes), PAGE_SIZE);
+			break;
 		default:
 			err = -EINVAL;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 42794b1bbe5a..f7e69f5e6d73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -797,6 +797,7 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 	const struct dmcub_firmware_header_v1_0 *dmcub_hdr = NULL;
 	const struct mes_firmware_header_v1_0 *mes_hdr = NULL;
 	const struct sdma_firmware_header_v2_0 *sdma_hdr = NULL;
+	const struct sdma_firmware_header_v3_0 *sdmav3_hdr = NULL;
 	const struct imu_firmware_header_v1_0 *imu_hdr = NULL;
 	const struct vpe_firmware_header_v1_0 *vpe_hdr = NULL;
 	const struct umsch_mm_firmware_header_v1_0 *umsch_mm_hdr = NULL;
@@ -818,6 +819,7 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 	dmcub_hdr = (const struct dmcub_firmware_header_v1_0 *)ucode->fw->data;
 	mes_hdr = (const struct mes_firmware_header_v1_0 *)ucode->fw->data;
 	sdma_hdr = (const struct sdma_firmware_header_v2_0 *)ucode->fw->data;
+	sdmav3_hdr = (const struct sdma_firmware_header_v3_0 *)ucode->fw->data;
 	imu_hdr = (const struct imu_firmware_header_v1_0 *)ucode->fw->data;
 	vpe_hdr = (const struct vpe_firmware_header_v1_0 *)ucode->fw->data;
 	umsch_mm_hdr = (const struct umsch_mm_firmware_header_v1_0 *)ucode->fw->data;
@@ -834,6 +836,11 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 			ucode_addr = (u8 *)ucode->fw->data +
 				le32_to_cpu(sdma_hdr->ctl_ucode_offset);
 			break;
+		case AMDGPU_UCODE_ID_SDMA_RS64:
+			ucode->ucode_size = le32_to_cpu(sdmav3_hdr->ucode_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(sdmav3_hdr->header.ucode_array_offset_bytes);
+			break;
 		case AMDGPU_UCODE_ID_CP_MEC1:
 		case AMDGPU_UCODE_ID_CP_MEC2:
 			ucode->ucode_size = le32_to_cpu(header->ucode_size_bytes) -
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 9a061c7b86ee..a3c04f711099 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -464,6 +464,7 @@ enum AMDGPU_UCODE_ID {
 	AMDGPU_UCODE_ID_SDMA7,
 	AMDGPU_UCODE_ID_SDMA_UCODE_TH0,
 	AMDGPU_UCODE_ID_SDMA_UCODE_TH1,
+	AMDGPU_UCODE_ID_SDMA_RS64,
 	AMDGPU_UCODE_ID_CP_CE,
 	AMDGPU_UCODE_ID_CP_PFP,
 	AMDGPU_UCODE_ID_CP_ME,
-- 
2.44.0

