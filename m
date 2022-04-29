Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066F4C43217
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 18:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 855DE10F8C0;
	Fri, 29 Apr 2022 18:02:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFA7A10F89B
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 18:02:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFvPc52eLUWi6apZEYubMmklsGw3uFUR92xWTe5v4g1D+nLGpmiw3wAaie6lRI+fL40N63nNQoETjdOWIIQNBmapkOJ9Qs5OLY6btiDW+Mjj2ZZ47vEn6UAaqsfq60ESrV+JP7RP117YPKJzOGROZyx45/nGNwy3cPMhPFOE/FNGmuIckXbL/m+f/vAJlSxV1q1FIVBrA30aeUQ4bydYrF6A8O42axKoDjUzflmrvjNFpNy1GlV7RJQuPIe5Gx9+5qeV4r+7OjqXzDDgsth0a7L799lDTwXlAeHeOp4QZV3Ludcn3+I2PgvNh4Ar0rbhmGPDB/UFgA53GcNwH0AAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMab0OpTUf+scsm5/b9L4ze3OM/NkTpEygMcwHm2VjY=;
 b=aw2eQLfDcn01W/lSf+WXwbKGNfl9YOO3copSsdYIoojQeiADoK9obRCpTmHg2Ry5bRsgGnB3me8fxLIu5xfAQT5lxDvU+xJG9bYrLnzi/zro8WNqolpqmiun/RGSq/DA6aeAj0yNyCObdhQ2VmHSv/hI5P5yrBvLcIeOOx3sS0t0qC0ppzkvdNNiWQyIDM8rs+XBl2FlCqAeQOH51MKxxb3fVLR1v9oKSt+zLeg2ciZ7hgKoMgsElFXoCGQ/6sca9m8xwjayWc94sW8n0SxrNUVJvlODah4VMl9BFs4OwHP//cxSkgRrap6BCkfowlEaMRW/oQ+OkAAHcHjE5fKDww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMab0OpTUf+scsm5/b9L4ze3OM/NkTpEygMcwHm2VjY=;
 b=jAveyWa+WD6+qpcWbdftJKrAO3NDlz8rLjYK2AeDe5nwtJwXCrHrRICsM2jR/BigaQzAQMcf2h4SVOVyuLl/G9qG5twSjaHE9Xk1hqWYToZ2bEX2cC30vlCPvx+4xuadbiOZW8Pyc8GCx3AsX2z9pfpDH9DatltU9fFOK7CN3AY=
Received: from MW2PR16CA0063.namprd16.prod.outlook.com (2603:10b6:907:1::40)
 by DM5PR1201MB0138.namprd12.prod.outlook.com (2603:10b6:4:56::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 18:02:49 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::a4) by MW2PR16CA0063.outlook.office365.com
 (2603:10b6:907:1::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 18:02:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 18:02:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 13:02:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/29] drm/amdgpu: renovate sdma fw struct
Date: Fri, 29 Apr 2022 14:02:13 -0400
Message-ID: <20220429180226.536084-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429180226.536084-1-alexander.deucher@amd.com>
References: <20220429180226.536084-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 998e686c-0ef5-44e3-96fb-08da2a0a78b9
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0138:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01388ED5A0EBD8FB7458D3C8F7FC9@DM5PR1201MB0138.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9sazh5ajzkZVg8axUO3lppKDWuLPT2f6eXZxw1c88OwS8f296ght1W7su1xSTI5202iyr7o0IqxjHu9LY5znOwD6zG72XYzj+6NnYWWH1YSCaekJaXzlEa98h0pjLdJRjFUD7nCN+xWrbKoI1kYgijSvpXueKJIZb3KcdhyZGKUOdVsGhK/NxXVWiDGrBmG99tcW/r9OYyhnifgaGmLQQTjWStS+qNc8m1Yb5SB05kL7k1nGQiYmV1aI+qYGm385nONsz5vfSOe57jSowVInfcshD4Bi494oJDPFyKEf5Sry6qZK5z/s3Wlt+1k+xbgQ3xAvi0MFmSxUAj+C5gSo7UAcPIyOyUMvXL0GcPE0ENyfUtWXEW0QkPg7xznXnlSPEcj/Wf8AfpJanJOE/F2ZjaKjOUpUZgG+MimUTQza8UZGfwoXHaeEAg8fm14MugONkZPmx6XzI7Srmb6/vJOi78dE/V8NbthZExHNb8NsrMKoHfsoB/jDdFSpswyTT6IsB7KXA7MLNaNzHYwdxn13x03OIl6EJmX49o+2lNoXOjPWf9MXI/1D5H5KhYkFtTjIwf9RARJdfzZ9VFXv3NTWy6LnSXNcaxjm3JoDFTDzEokjA62b3rFdBvZDHtkYGgQ7ZekEdbZPQ5pem8m0z5bhJ0BDRiJnAYC6U6mGTTcYyx+LimjUEYUuD6fwNo8zEZN+fmDcY3XKi2tdsBoqXgVH8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(54906003)(508600001)(70206006)(6916009)(6666004)(356005)(2906002)(7696005)(36756003)(316002)(81166007)(86362001)(4326008)(8676002)(2616005)(70586007)(1076003)(186003)(16526019)(47076005)(426003)(336012)(5660300002)(8936002)(26005)(82310400005)(40460700003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 18:02:48.7939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 998e686c-0ef5-44e3-96fb-08da2a0a78b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0138
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add sdma firmware struct version 2 to support new SDMA v6 and forward
firmware version.

v2: squash in fix

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 14 ++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index f8ff9128c15b..3d1258fec48e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -244,6 +244,17 @@ void amdgpu_ucode_print_sdma_hdr(const struct common_firmware_header *hdr)
 				container_of(sdma_hdr, struct sdma_firmware_header_v1_1, v1_0);
 			DRM_DEBUG("digest_size: %u\n", le32_to_cpu(sdma_v1_1_hdr->digest_size));
 		}
+	} else if (version_major == 2) {
+		const struct sdma_firmware_header_v2_0 *sdma_hdr =
+			container_of(hdr, struct sdma_firmware_header_v2_0, header);
+
+		DRM_DEBUG("ucode_feature_version: %u\n",
+			  le32_to_cpu(sdma_hdr->ucode_feature_version));
+		DRM_DEBUG("ctx_jt_offset: %u\n", le32_to_cpu(sdma_hdr->ctx_jt_offset));
+		DRM_DEBUG("ctx_jt_size: %u\n", le32_to_cpu(sdma_hdr->ctx_jt_size));
+		DRM_DEBUG("ctl_ucode_offset: %u\n", le32_to_cpu(sdma_hdr->ctl_ucode_offset));
+		DRM_DEBUG("ctl_jt_offset: %u\n", le32_to_cpu(sdma_hdr->ctl_jt_offset));
+		DRM_DEBUG("ctl_jt_size: %u\n", le32_to_cpu(sdma_hdr->ctl_jt_size));
 	} else {
 		DRM_ERROR("Unknown SDMA ucode version: %u.%u\n",
 			  version_major, version_minor);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 4439e0119f19..f510b6aa82ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -281,6 +281,19 @@ struct sdma_firmware_header_v1_1 {
 	uint32_t digest_size;
 };
 
+/* version_major=2, version_minor=0 */
+struct sdma_firmware_header_v2_0 {
+	struct common_firmware_header header;
+	uint32_t ucode_feature_version;
+	uint32_t ctx_ucode_size_bytes; /* context thread ucode size */
+	uint32_t ctx_jt_offset; /* context thread jt location */
+	uint32_t ctx_jt_size; /* context thread size of jt */
+	uint32_t ctl_ucode_offset;
+	uint32_t ctl_ucode_size_bytes; /* control thread ucode size */
+	uint32_t ctl_jt_offset; /* control thread jt location */
+	uint32_t ctl_jt_size; /* control thread size of jt */
+};
+
 /* gpu info payload */
 struct gpu_info_firmware_v1_0 {
 	uint32_t gc_num_se;
@@ -364,6 +377,7 @@ union amdgpu_firmware_header {
 	struct rlc_firmware_header_v2_3 rlc_v2_3;
 	struct sdma_firmware_header_v1_0 sdma;
 	struct sdma_firmware_header_v1_1 sdma_v1_1;
+	struct sdma_firmware_header_v2_0 sdma_v2_0;
 	struct gpu_info_firmware_header_v1_0 gpu_info;
 	struct dmcu_firmware_header_v1_0 dmcu;
 	struct dmcub_firmware_header_v1_0 dmcub;
-- 
2.35.1

