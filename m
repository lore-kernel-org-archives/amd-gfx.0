Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567A2C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8A8F10F051;
	Fri, 29 Apr 2022 17:36:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BFEF10F04D
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:36:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPdsgJShDdMfIfL9FcFOlngQW39ht+2PeWsfEY7Cp8r/N8Z9YH85NyoIZppe7DGkC87yAol2OwWKfF4vE+6TcENugMvfZjBgdLtMCSrd4ZsZpnkZVLz3HD+To/rY2mToveO++1CMUBlYa2difiavcdzOJJN/J0gxxt9e95dHCcfCesfbnPkei4KMOJPcMHDGRUfNbo137yaK5cqV2jZAaHPxd00lgkN4JtVtlHUdGgbLEAFqJDSdQsih5hw8/LDF9uXWAflvckR7cesdBjkWbyag/Dik+SlnCnyfCgmu6T++JyZTndqilJCWQOXWOJL6sUwBrxzXCBDrVsX0LheEQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liXu3oepxlpn43h3e9Xgd2vsWOy6p4F8NrkioP2kv6I=;
 b=Y2llMForC0lwLZ4I7jmfovCtN0kA2BK5vhNjc6LYoH8QpKXYMTuIjc0Ms7wYEFCQ8Y2q9dzy/NfIjIDPu8gDxCmME6g5JB5NIq9lG5NdbTZ0/DvP5mnNONo9mgJkvI/COLL2bUby+4OmcnSpduEsIJ3IWTpjd3Jp5zrPCyoAjpMVPh4S+MFMnMrC67p8Wi8K7PuJVqr4yllsUk0Ipel38tBWOn1fHXiTi9QILFYTXKc1JDhaTqxrdck4AZk511HcVAzdU10VrOAyow+lnsLXU6Gk5CqsBy6bp7Ae682dhnwqoK6LLp3Dft+bzFWsaMjMQbBmRkB1fwmzSN69pjdvPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liXu3oepxlpn43h3e9Xgd2vsWOy6p4F8NrkioP2kv6I=;
 b=wsfZF+mqdxNxwbFBKQBmSGJjwE7ImCEr63hJgCfmnOttkFqYUexGPn2wkeoLuGq5CV2LUIcG5bcLKlNGBx3UvOXeDUMq3lCvYn9hJFqPLvPNwxt46uXBsHzlPXj1mDF5mWs9pnqmIBqBiDfrnXhodZqSwmebTJKyq6Yg284boMI=
Received: from BN9PR03CA0317.namprd03.prod.outlook.com (2603:10b6:408:112::22)
 by BN8PR12MB3236.namprd12.prod.outlook.com (2603:10b6:408:9a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 17:36:40 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::2b) by BN9PR03CA0317.outlook.office365.com
 (2603:10b6:408:112::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 17:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:36:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:36:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/6] drm/amdgpu: add imu fw structure
Date: Fri, 29 Apr 2022 13:36:17 -0400
Message-ID: <20220429173617.433334-6-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8b8b0d43-1d2f-4920-8690-08da2a06d180
X-MS-TrafficTypeDiagnostic: BN8PR12MB3236:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB32360BC2BE7C0EE264660D74F7FC9@BN8PR12MB3236.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SigPmwhlF/9q1OWj0bVm1ScZapeWwgP0t6GaFYLhFmJa8cB3Ym+BmxmDAYLYmWtzMLIR2kUmSOzHLNzGg0rIULuWxuknlWGNkAyyxFubfq9nihBi6yPJ1sR5OqgQRkIeb+i+uXwttS7DttIO+TjS7EcJBd0oYl7xCTOUkFFOv58zu+6fDFU5r3KPBSIQTcade6JbSWyGDt2HmPZsrHF+B6iW6P68mioKo/zCk54jlKoChk1NTBkfUEgvhWpRd95XFZp86hdkP7AYbG/6n6slR4v5630wiLs0dG3P+C7HSTYO66jLqeZX6FWykpXw/x8oUrDwX4AppDbOhukApYu0L3czKL0WSsUg3Dl7ZR4u3h/tSs3BWQsQxPCNq351OJdRKc0H3DbTzGAPSRoymIgiYBPaZjypfEbagfN2YzSx4PxA6Vw2nosusjO28JF9UMzoqSF7+kDV7aG/XXgDR8my2cidA64DnzrEQ/Kb/w6rVBTWsC60sMIA14MVx4uQkWQZs6txv/rQDRJQ6wtlOzC9goFPrjdKAfevICmFYhpc5fPvsNDQwi5k7tMLk/4mMUEi2ajnJKBi1jnizMOyIsED1jPOYSVFH9zL1eAro0zLR0sAn0o5ELSZXQ4Blrvy1hxzUorLkB9wjjFvJSfae4pApmuGmLn9agdIBbxidg5U3Mv+duv3Pp1/ISEwbmUHvNEOUV7R5vdjlp4mY+74bFT13g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(7696005)(1076003)(36860700001)(40460700003)(26005)(6666004)(2906002)(36756003)(356005)(5660300002)(2616005)(16526019)(186003)(81166007)(54906003)(8936002)(508600001)(6916009)(426003)(47076005)(336012)(86362001)(82310400005)(4326008)(8676002)(70206006)(70586007)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:36:39.8596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8b0d43-1d2f-4920-8690-08da2a06d180
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3236
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

Add IMU firmware structure.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index f535770f8092..fb88f951fb3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -334,6 +334,15 @@ struct dmcub_firmware_header_v1_0 {
 	uint32_t bss_data_bytes; /* size of bss/data region, in bytes */
 };
 
+/* version_major=1, version_minor=0 */
+struct imu_firmware_header_v1_0 {
+    struct common_firmware_header header;
+    uint32_t imu_iram_ucode_size_bytes;
+    uint32_t imu_iram_ucode_offset_bytes;
+    uint32_t imu_dram_ucode_size_bytes;
+    uint32_t imu_dram_ucode_offset_bytes;
+};
+
 /* header is fixed size */
 union amdgpu_firmware_header {
 	struct common_firmware_header common;
@@ -358,6 +367,7 @@ union amdgpu_firmware_header {
 	struct gpu_info_firmware_header_v1_0 gpu_info;
 	struct dmcu_firmware_header_v1_0 dmcu;
 	struct dmcub_firmware_header_v1_0 dmcub;
+	struct imu_firmware_header_v1_0 imu;
 	uint8_t raw[0x100];
 };
 
-- 
2.35.1

