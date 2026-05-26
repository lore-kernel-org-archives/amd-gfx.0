Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF39CD5BB4
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8BB310E517;
	Tue, 26 May 2026 07:21:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2bhBkdlX";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013057.outbound.protection.outlook.com
 [40.107.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E68B10E517
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:21:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLgcsUyWI0F8EBoJhU4g7LDsE+e6LfP4jo7Qq+N8Om/x1Kd39pSs8DRyxY4vGTJOgmwV02W2FcLE+Zu/0GY8n0vRuYeRvbThwj5PNYA9R1ZVbPWkfkOjrShG3Y59cZSllTPoaugshe65VFFXFD68VoUXgvKygycOFTm41+hly6XSShXe15FJFFA7WFCK01WnKuNS1CmnGFmV4dcbtWWX83Q4+NTA5j3IaRDHhmpPDjh1hX++ZrW08L7rvivSKPaHvzRym+7ecHc1zrerxGdoXJNUjvM9zql2Ff7/WoFA3Ex5BxOntmb/WlbTQUK0tpMgI1GmpJKT3x3yU95xkKCxJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLbOzpS5To/TMyoTH4xtcnOuzy1pqMQnXyy8hDcyPIE=;
 b=dPqdaDpGKgSBCbydZBy6p3Uds4KPoIU7ppoMR3mC0sOKP7GiF17NBrGG+S0QNro5Ii+/xInSprpHCCC0PxXfNPede3Y66ri2D/QAFB0BRaU6Knjd13AGyjZEfOu/w9C8uxacNgHY3mj/AHJBMIa8+ia+lzPeznJ0LuzDatIhZZwkubBy5+EY1XI5DvXnfJquh7m06KjRNMM37lSVQniEsjYCTqyPoVj/+BTvoA0YuQWTfwA8R5yc5KxFVKSTij9idriCEvlZDXCfeDr2eDYSP/EthSJ9T+rW3zFNjaxVgbohG8zU9V6xXVf7Q+vDdXka9pl7SxC+rWB0zyyBKxhqWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLbOzpS5To/TMyoTH4xtcnOuzy1pqMQnXyy8hDcyPIE=;
 b=2bhBkdlXiD7zxzy5v+koAyvhJmrjqaCnYqUs+mM17nInXdZwrupvHhJZninapCfkBceAXB19kGi28eSTgjzRbLuSKGhwX+ZTncFPCGiIIpFFZ6PFrE6fZB0Vvii8X2V/cNjNJnZ3UwSLeJKg3xkber7KIvYwzKeeOw8KlOHGAOM=
Received: from BLAPR03CA0162.namprd03.prod.outlook.com (2603:10b6:208:32f::22)
 by PH7PR12MB5975.namprd12.prod.outlook.com (2603:10b6:510:1da::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 07:20:59 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::62) by BLAPR03CA0162.outlook.office365.com
 (2603:10b6:208:32f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:20:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:20:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:20:56 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:20:47 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 41/41] drm/amd/display: Promote DC to 3.2.384
Date: Tue, 26 May 2026 15:02:04 +0800
Message-ID: <20260526071413.2181251-42-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|PH7PR12MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: ae52363a-80d6-457a-4d7c-08debaf75554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|22082099003|18002099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: GdOeFC++x1ooJyFbP0FwUkKO+oRcKQ9E1uSX8ZyPi4W2MRekYRvVzXOVd426j1hj7x8+Za2uTXtEYf0fAlXBp0/rfEIOe49xjTTsFkMjUdy/GrF1OMr52cql04YYmUSq69H+tYrE9pKWGfXoLDT7PeeBjJt01DvMmOnSMoyWH7cCAoTzRArQVWvLI3UJ4cJ6JHFFllhy/cZl5GbgC7bRwy0yfZ0g861zPI77DTB6HPDC1anCWtCHL37lpoF/Q2DPW2yKc4UqGwfQwlc4dwj8IzbO1adADKk5sqz9Zi6FZV5R6VG3urXxAua4dEG+VXBpkYqZP3gjrLcD8+8POjI5CeURo/GBQ09J2V69H6KuC5Xzfo7m2hz2UlxdtIWAB4uExLUUX55jy+wEYT0CMEsGoaCu/flEAwUDIw8NyiTg5Pp22eCW7A9M2hJNlIhnUDgt/yaFAFnUvaFanTmJvZeagmrWD6/Nl/RZUBxFtBrqBtkNqequYnYgQU7i8pxql07qNN4Gpq8OLIl7IJ0SwCPAo2Q7qSA6Xh+R9BAN1pZ1h4j6tgHRUg9pe6d/U/NPVQhhc9nTm/gpBReAokxM88Hg8rs+IuSMfN9++EznfQnWtzE+qiwIwNa6iDzG0rZqcqpqyoVJ/j43lueyoaAPlTeYLh9+MYXyEd5tm9RJMBZFdLtFSnwHoJp1PPMmD80YNJi1NyyyBElbh8XcS+ENItgEjmmDn26UQhxBnpPWmM8cNnQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(22082099003)(18002099003)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kwal63krFlxRyccUtoFP9NAjVFt0sa82glbBdV0+YH2NJZejQ4Y6dMnAPY4wTn+tklNDCipfknHJ6OxHvW34FdniD17iyRDxmHdzY9jQMkGI1wg9LxCMjeKQ0POIN07mIcImpcSOQ3hKyUNCbal6yQVw+H15V5hptfC98xkB++FkC1YkKmlmCZ3YuiemGrVYcjAfdbBHJ2avyyKtVZXW1wKcTg+0IYO6Xl6UU5ckTGPb1NG4cKwTxB8XK4UsuQf+gMfMONGH29oZfZdukmducWN6KRqMJfTa3winMNHL5Wi9ZJq8VrV1ohptwm6I0ZSzRp/aAwHRg6+0CqjkVz5xaDFT8Xl9cuuJdJtxdHngThYDwvRon4xh353PCOvPzDu37XExkLfw8BYA7gfQDHpfCmkrnnd6bCV1FVzKrBOYv7LoCPDK5MzuROTfTE6Klo+z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:20:58.3948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae52363a-80d6-457a-4d7c-08debaf75554
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5975
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along the following updates:

 - Enable DCN 4.2.1:
   * Add register header files for DCN42B
   * Add DCN42B DC resource files
   * Add DCN42B DMUB support
   * Add DCN42B code to DC and dcn42b_soc_bb to DML2
   * Add DCN42 PMO init_for_pstate_support
   * Enable DCN42 PMO policy and pstate pmo
   * Enable DCN 4.2.1 in amdgpu_dm
   * Enable DM for DCN 4.2.1
 - Add no_native_i2c codepath
 - Add amdgpu_dm KUnit tests for:
   * amdgpu_dm_psr_set_event
   * dm_ism_dispatch_next_event and additional ISM functions
   * amdgpu_dm_colorop
   * color LUT functions and transfer function helpers
 - Enable gcov coverage for amdgpu_dm KUnit builds
 - Extract dm_ism_dispatch_next_event and transfer function helpers
 - Refactor amdgpu_dm_initialize_default_pipeline
 - Clean up PSR helper functions
 - Fix gamma 2.2 colorop TF direction in tests
 - Handle aux_inst for connectors without DDC pin
 - Fix DP_PIXEL_FORMAT fields & update clk_src for DCN4x
 - Avoid DPMS-on for phantom stream
 - Change default driver setting for "Force ODM2:1 for eDP" policy
 - Add DC_VALIDATE_MODE_AND_PROGRAMMING condition check for force odm2:1
 - Check for sharpening case when calculating max vtaps for scaler
 - Add DRAM table fields to clk_mgr_internal
 - Enable frame skipping in 0x37B
 - Bound VBIOS record-chain walk loops
 - Clamp HDMI HDCP2 rx_id_list read to buffer size
 - Clamp VBIOS HDMI retimer register count to array size
 - Reject gpio_bitshift >= 32 in bios_parser_get_gpio_pin_info()
 - Use krealloc_array() in dal_vector_reserve()
 - Fix NULL deref and buffer over-read in SDP debugfs
 - Fix out-of-bounds read in dp_get_eq_aux_rd_interval()
 - FW Release 0.1.61.0

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 3ffcb74552c4..7b356bf95a67 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.383"
+#define DC_VER "3.2.384"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

