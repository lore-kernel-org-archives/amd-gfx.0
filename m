Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5C3C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 18:29:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5B5010E463;
	Tue, 26 Apr 2022 18:29:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B4AD10E463
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 18:29:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMRtzznAkS8gC5fG/9NVBsT+i82HHPYxCwN0ebEqtv1OdfmkwDV526o0/rCObkIj4wDDtWKPQZ2uJ9T6iv3XifLrrFeyTgY3ODUvIdx612zj3woAdRZxJL7qe9+9wHCLzT27rC7u5x+miodBa66eTR0lKNIIvdMZPfnEGDt/cjo5deOYOMFG6WKZEYPYinFNzfN9imJZNDWbSdIbzhOGE/AvWO3tkU2NQz3Y3m30eIsA9ikx485Oi9fOPDYf1MmShvuVEI5AauTko/3Al893fJolDI/wa5jA722USWt8v5XH98m0xN0K6mzK38U/fT+//JQDJRa6OZkAokhEuyssIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0K5A3rlM4SvdLxBVqWtazm+LEVqcbD8hv0jol7yVr4=;
 b=MqzOwuBooW/Ti7OAN5kLLlHxa0CBP9+vt4kL5xcyy45NJN3FVpJlFz43/rf7VjhFRFR+VMSN09eR7xlPjlE8xghbWCRIk+z/tX2pY2jOXNXn33sWpfDW+VkTKFW1TU7l7D5ql54HEor3i0CxVBioSbfw5iXGInL5c9UNeB0qRMwjS2SQ5qebxQeHHELdHrrt5KzOqiiIFZhMu7b0RqlcxiU2wPjTNOaNn3TdeVXAbmlLsZSaHmk6R4ZEeirl9C1m3AndRDwmSYkchIdORKi2HuezgdIAIo5zX838b0Qid1OB87TRFdaL1WkGsYbjMRltp5qy7FFDHwYSzn04C9HRrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0K5A3rlM4SvdLxBVqWtazm+LEVqcbD8hv0jol7yVr4=;
 b=vZYojHd7CHnhtMBIzgHWrwDGeSSLdsOfek/bba2uOs/4ct8qBmVj5k4Infzu0oQVi1Sz7+7tNlGA7nUuABJx8c23eMgD1KbRaH1GAw5TH7HkOZYfwi6rb3mX6NPv2QYC6vl4iEESOIhjr2dTxrrWJWJba1ZX17+vgBVzUWLILdc=
Received: from MW4PR03CA0123.namprd03.prod.outlook.com (2603:10b6:303:8c::8)
 by DM6PR12MB3706.namprd12.prod.outlook.com (2603:10b6:5:1cc::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Tue, 26 Apr
 2022 18:29:36 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::e0) by MW4PR03CA0123.outlook.office365.com
 (2603:10b6:303:8c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Tue, 26 Apr 2022 18:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 18:29:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 13:29:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amdgpu: add vram_info v3_0 structure
Date: Tue, 26 Apr 2022 14:29:16 -0400
Message-ID: <20220426182920.3007060-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 770fae24-b67f-4047-4263-08da27b2b7a3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3706:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB37062021B16F1A47033C7769F7FB9@DM6PR12MB3706.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 82NvQTSiuB1+H4z2ddKFsK/RUZdfpJhzA4ENjUTo4tu0+/V6GizTlIf3FTpoPKBc5ahrEiTTNs/UVydkTd0JQ3nzQPf3jcfpw4Jc758tdAXP/DkJ0tm2mszWgebOfJ3nALR6adUFRGipwNRZdmey/s6oA8NbKyUjTcTr+tQoFlEe6LgT7nGXFhRXkLm2I+vbrrKnQ1ntxG7mfsLnt1n3cWHRNNMuNFmCC7E65Y8cd8xjZ6bey5iFLKee81y+DNxlXbMtu36ydVBEgWkE8Y1cEP+bM0xG7c27xcRjC8YFx4BUGKGjG48MdDd7JRCVeAZTMEfNgd24X50grRiw7q+4FkmVCxdNdWLBr9VtrquXFoOHDtRCSzWs82twgkFgeDtUenU5wC/JNu19/ke1bvYlsDOr+9ZxqfFigbNOy35TB3EOF+Ce7+78mMXHk1CDMXELQeC8mE1KCiCgM5qNyNrPmb+S6tS/aoEL0JIWYNFw7POmxA5+IHQjl5Ef4LPtihIkx0YS7JsbiUC9dxJkMgCJyvWH/ulUYafZ0K/LJfHZIR1/mKnNmuyD9X7FmzHgtcj0CG77iSY9IoujrwBMvKT6F/J+v7QNzRGgSpPY6tpqE+O77zVdKUH4tm2eSDCK/w98kziK8FtHMQZvd0hmsHx7dUsHWh1c8pHmwaJQvk4Ii2l8Bmefj0wL5HTPgaE5Y7RfEe+5a0B/9G3C8ZnxAhGtpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6916009)(426003)(54906003)(508600001)(186003)(8676002)(4326008)(70586007)(70206006)(36756003)(8936002)(2906002)(1076003)(2616005)(16526019)(47076005)(26005)(86362001)(5660300002)(83380400001)(82310400005)(40460700003)(36860700001)(316002)(6666004)(7696005)(81166007)(356005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 18:29:36.3063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 770fae24-b67f-4047-4263-08da27b2b7a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3706
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

To support query vram_width, vram_type, vram_vendor
information

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index df52f9101282..b44341d6bcef 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -2792,6 +2792,51 @@ struct atom_vram_info_header_v2_3 {
   struct   atom_vram_module_v9  vram_module[16];         // just for allocation, real number of blocks is in ucNumOfVRAMModule;
 };
 
+/*
+  ***************************************************************************
+    Data Table vram_info v3.0  structure
+  ***************************************************************************
+*/
+struct atom_vram_module_v3_0 {
+	uint8_t density;
+	uint8_t tunningset_id;
+	uint8_t ext_memory_id;
+	uint8_t dram_vendor_id;
+	uint16_t dram_info_offset;
+	uint16_t mem_tuning_offset;
+	uint16_t tmrs_seq_offset;
+	uint16_t reserved1;
+	uint32_t dram_size_per_ch;
+	uint32_t reserved[3];
+	char dram_pnstring[40];
+};
+
+struct atom_vram_info_header_v3_0 {
+	struct atom_common_table_header table_header;
+	uint16_t mem_tuning_table_offset;
+	uint16_t dram_info_table_offset;
+	uint16_t tmrs_table_offset;
+	uint16_t mc_init_table_offset;
+	uint16_t dram_data_remap_table_offset;
+	uint16_t umc_emuinittable_offset;
+	uint16_t reserved_sub_table_offset[2];
+	uint8_t vram_module_num;
+	uint8_t umcip_min_ver;
+	uint8_t umcip_max_ver;
+	uint8_t mc_phy_tile_num;
+	uint8_t memory_type;
+	uint8_t channel_num;
+	uint8_t channel_width;
+	uint8_t reserved1;
+	uint32_t channel_enable;
+	uint32_t channel1_enable;
+	uint32_t feature_enable;
+	uint32_t feature1_enable;
+	uint32_t hardcode_mem_size;
+	uint32_t reserved4[4];
+	struct atom_vram_module_v3_0 vram_module[8];
+};
+
 struct atom_umc_register_addr_info{
   uint32_t  umc_register_addr:24;
   uint32_t  umc_reg_type_ind:1;
-- 
2.35.1

