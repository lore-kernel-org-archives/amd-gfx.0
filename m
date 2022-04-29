Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E141C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:36:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1613A10F04A;
	Fri, 29 Apr 2022 17:36:38 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2053.outbound.protection.outlook.com [40.107.96.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74BB110F04A
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:36:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWQLdHw1PJLfO1bSRyDZEtyjWiXKtWXeUKdYM6UA7ds1+GHiROgA+8ohSkPJIkuIo9EXdAd40PDXdm6ut21h67bhR6qsynU1eoo/cjmu4mMG0XAd4yfLei+CNpH2FscAh8j5vPYx3fL4bvBbdxxz3WoxESeMuf2BIeKUGC5YSxmO6s8KKYHRDoWQxy3XcYwsSv5jBONLN3XwGOpXP8TcW0kswE7DFRkQ01Lq5bkBh6pe7XdtEtoTOuG5s/AaRFgaCV22+LyFPSa5yMJFTcW7S17QzIgfiTJcDhv7KMupIWpYbkO3xOyfF8MCZIpv2BZoEOoKp4na8JHqhn3Uu4tTsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sSGbCA/u+J4Yf/0MH3foZ7IFkFPpxliYR7Sk4GB6+s=;
 b=ZjJjlYOpiqDa+kQMfIFbRi586v6kuKy7uKupTJjeoGmgU6643gHEbS2vMpFVLD5+0kXSbOjJvmk8Ssw9bXu43bFgtL6I8yT1WZYSX2THPKi0fJiv8RlHOPOsPDrT5XNtrWHd3rSEqqD5Y+qEPkej+q3c4/bBtS5r7ecY7arLSsITbw51rHEWxP+zpcMEVbRKZXOTOkQ1bjedSxlU3KJtU4oSyplrHGwlqaUGfX4vhmGT4AXWX41wz9KmaEChGHMM8dmCK2azjGXl6Cu8U1BAp3G11QHNfUstk+v/dLyKLUfd29PYdD3iChxrjTiOZFyOlGgM2v0qcUVUCAd1GHQagw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sSGbCA/u+J4Yf/0MH3foZ7IFkFPpxliYR7Sk4GB6+s=;
 b=eyxwYZ802oJxLFPJDEmO6akFD+JV6mDsh7j1b+gAnljDflXaV+mmbgKVswdjuVTBGjFIsaS0Aekgs5gXDvcv32+/Y+1Uu+98DtTKBhhdw2vYa7HukOUXd4m6KVrD6EPDQfn2YhP7cXstfIwFtIuv+PN2C+5XB26PWlaGLm9Xi5A=
Received: from BN9PR03CA0304.namprd03.prod.outlook.com (2603:10b6:408:112::9)
 by DM6PR12MB4928.namprd12.prod.outlook.com (2603:10b6:5:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 17:36:32 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::7) by BN9PR03CA0304.outlook.office365.com
 (2603:10b6:408:112::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 17:36:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:36:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:36:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/6] drm/amdgpu: add gfx firmware header v2_0
Date: Fri, 29 Apr 2022 13:36:13 -0400
Message-ID: <20220429173617.433334-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429173617.433334-1-alexander.deucher@amd.com>
References: <20220429173617.433334-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ce4c595-c5b3-4b02-c1b1-08da2a06ccb4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4928:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4928D38D9F932C793DFF4D2EF7FC9@DM6PR12MB4928.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ydjjxz3XECGAV+knFwBjLD5lU6KzUG2MrS+gG1EE57hYlEkstt0/sN9qT05OQQ1FDoobW9alOw80l/p6YVZJRbEvV5zpQ48Y09m6TCcobxqdpyShfDWWif+yNm4ywX9+Wf47Oex9bBCfnYa4ZJeRod340MgwFLGY3s8yStuEwT4fwr0N8Uj0aFktTmxQWvDS0xMEEU5tcYVY5An0EpBLnwaqvGkcKKZCZPXyPliOH6313IRbrFvOUrsqJtPa9MoVlf07XBRa/wtuIsEhmS/huZarGsWaOTkyXT3W2fpdvDml1aqP46ioGMC02Z+lIqzgxniURvZyJoXxpbZkFP5OaZ9YK+wLy0fOCbZnyPOiCbBT7+qAX+RbTJwSwzn+7qkVZZPh9t2hUJh8Dnfsotcq1njIFC+3nxMczQEtFOiALwiZ2WLmIIlJggyRav4CD+nuc9a/jHXrM8GJSuZwgsuYNnmthGUri1tTTYELBkDqx+mjtTALg2rV8FymsPRsC3zI1qJ2XxvkdsDFdSWtVEdGYIFYaVHBy3sFXUM/gK3xBfPTZoCZw7DKoLOQU8bU29Maz/TqQ0x8ToSuqUfsZx/omoS8L88xqXXR41mgCyshzaEzqj8Baw5R1qC/0ZI7aI03bJ/abd3xb2ydau/UlajOOq4BCWKSZX6moOmNc4kKYyGe+CKXi/BztedViEH9VaJseu1Uye5+GeNo16VK3PhfFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(356005)(2906002)(1076003)(16526019)(426003)(47076005)(186003)(26005)(336012)(6666004)(2616005)(7696005)(81166007)(70586007)(8936002)(70206006)(36860700001)(8676002)(4326008)(82310400005)(40460700003)(316002)(86362001)(54906003)(6916009)(508600001)(5660300002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:36:31.8133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce4c595-c5b3-4b02-c1b1-08da2a06ccb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4928
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
 Wenhui Sheng <Wenhui.Sheng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

We need define new firmware header to support
CP RS64 fw.

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 6218bd62d172..b7d575c7bcdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -115,6 +115,12 @@ void amdgpu_ucode_print_gfx_hdr(const struct common_firmware_header *hdr)
 			  le32_to_cpu(gfx_hdr->ucode_feature_version));
 		DRM_DEBUG("jt_offset: %u\n", le32_to_cpu(gfx_hdr->jt_offset));
 		DRM_DEBUG("jt_size: %u\n", le32_to_cpu(gfx_hdr->jt_size));
+	} else if (version_major == 2) {
+		const struct gfx_firmware_header_v2_0 *gfx_hdr =
+			container_of(hdr, struct gfx_firmware_header_v2_0, header);
+
+		DRM_DEBUG("ucode_feature_version: %u\n",
+			  le32_to_cpu(gfx_hdr->ucode_feature_version));
 	} else {
 		DRM_ERROR("Unknown GFX ucode version: %u.%u\n", version_major, version_minor);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 1c2d1f9bf418..bf9ead9c71f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -170,6 +170,18 @@ struct gfx_firmware_header_v1_0 {
 	uint32_t jt_size;  /* size of jt */
 };
 
+/* version_major=2, version_minor=0 */
+struct gfx_firmware_header_v2_0 {
+	struct common_firmware_header header;
+	uint32_t ucode_feature_version;
+	uint32_t ucode_size_bytes;
+	uint32_t ucode_offset_bytes;
+	uint32_t data_size_bytes;
+	uint32_t data_offset_bytes;
+	uint32_t ucode_start_addr_lo;
+	uint32_t ucode_start_addr_hi;
+};
+
 /* version_major=1, version_minor=0 */
 struct mes_firmware_header_v1_0 {
 	struct common_firmware_header header;
@@ -326,6 +338,7 @@ union amdgpu_firmware_header {
 	struct ta_firmware_header_v1_0 ta;
 	struct ta_firmware_header_v2_0 ta_v2_0;
 	struct gfx_firmware_header_v1_0 gfx;
+	struct gfx_firmware_header_v2_0 gfx_v2_0;
 	struct rlc_firmware_header_v1_0 rlc;
 	struct rlc_firmware_header_v2_0 rlc_v2_0;
 	struct rlc_firmware_header_v2_1 rlc_v2_1;
-- 
2.35.1

