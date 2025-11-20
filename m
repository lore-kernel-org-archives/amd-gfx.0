Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAADCCF9C7B
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 18:22:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5089210E7C3;
	Thu, 20 Nov 2025 18:22:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tDVUfR4n";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013038.outbound.protection.outlook.com
 [40.93.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2442810E7C3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 18:22:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbbtqH9yG+hhvY5TP505lWMXnhmKeJFyKkdsCL2CVN8V3/X/HKvrEn60kGflwypOklL4RevOILD1iPw5m3Hq/r0qyLOcM62y0ySq9dCT4MM+xdEzdhYUl3teiZiu6CMPEAgEjlDOBrvbJ5BZe7SHANRycRzGT+bVIE2kIQQ1hqgPPdw7/SoiN2fV4wlrMWdzWVL/2og8L1iI4cGCBvIbXk/2QU0m1VoPaUAzKT+6v8XMoB1ewqDQq24kKRzyLrPYkKIRjj0TAvks0AOYqGvKkylvXa1ntlNz2dSU+xP79IllBPYgDN45zu6+ktLazalNjGorPoEASjWY4cCry1FoNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHyYsRd4gwQaXz7WhRlpSnf7m+BoX+eb5lnGKBUcRo0=;
 b=yRm3qjbKWobR0Svq9wExwdQg3/Am/Zit49HRx/y7Y2vydVW7nAX52jXXZYuE6LjYwKO7m91WZu7xxQLWiJ8Niir/AVX/Xjulb8YiteBsgEKYrFgv4zZi3OpgP3BTlDHjbsT7Lu6Y78DmCL5+DODK+TCjxpR6ssl/ltj91GY9p3Sc5hPvPWepaXzxt3Re/Rr10exKrZB+iHmrLDAbo2vZFj3peKtuak5Il/cNcNZj4kXW+TIMr2/xnDmSM8jcZ1l93fOMJ786FKgf+RPBs93U9iwA0mkSbYunFDmNSaFEbFZKZ24l564wSDZ+F2AvxJLhppG+pKbaShDgfXc6rFzQWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHyYsRd4gwQaXz7WhRlpSnf7m+BoX+eb5lnGKBUcRo0=;
 b=tDVUfR4nkZxFGB+FnlMjeK4rItM1w4b4WUOaBgAORtkEDBzThhWzqNxAP6WI2tCRvoUAJve5f2kXf9eouk+cs11BzbmEaEURQ9aY8BO0wujSwb6pOTUiSf4HduFbsEAyU7KAOSzsOqVEpuNIeqlliq4Y31EixGmcY3wqpS6sxQI=
Received: from BY3PR05CA0051.namprd05.prod.outlook.com (2603:10b6:a03:39b::26)
 by CY3PR12MB9653.namprd12.prod.outlook.com (2603:10b6:930:ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 18:22:50 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::2c) by BY3PR05CA0051.outlook.office365.com
 (2603:10b6:a03:39b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.4 via Frontend Transport; Thu,
 20 Nov 2025 18:22:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:22:50 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 10:22:47 -0800
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, Charlene Liu
 <charlene.liu@amd.com>
Subject: [PATCH 24/26] drm/amd/display: Add additional checks for PSP footer
 size
Date: Thu, 20 Nov 2025 11:03:20 -0700
Message-ID: <20251120181527.317107-25-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120181527.317107-1-alex.hung@amd.com>
References: <20251120181527.317107-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|CY3PR12MB9653:EE_
X-MS-Office365-Filtering-Correlation-Id: 3905774f-edcd-49ec-4f86-08de2861d044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XWYt+q6m+M9eyLW69VB+w+yJWz+EerkLWKlJInVNu1fvXRp2kCx2iaBpf3vP?=
 =?us-ascii?Q?S71XmntnJVWVLMSi1n3ed3Z3r0t5qxP9Jp4qZCfatceK7n0OmFsUafny1n2r?=
 =?us-ascii?Q?47UaNs5qHOi6OL/CBL3byCIX0abyV5TQOtVMkIvVA2kk+uTmJ40evC+0BpN0?=
 =?us-ascii?Q?9zGDXElfKjhMu3Z4Fqhn4/j0+6Y48TCh16GjvuxcMUnixfsFc0Vwpj+Jcy2n?=
 =?us-ascii?Q?h9gL4Z3h4q8o4IhVZKUdq6Jm+6nL6xVTv0HvM8w3scv0214fhvSS5Eq9Aca7?=
 =?us-ascii?Q?YWx3qJWQXMe4h/Uxwps5QUXdNfljooBDJ3LDfoqdpglqk7ohwL8HS2KRiIWj?=
 =?us-ascii?Q?L7ZCr7YOvsMJieOWV89u176TzndqXpH61uQvK3d9MbuW618MXuvX2/J9ocMU?=
 =?us-ascii?Q?g6aF5/B0Xby70155tUw122fT+XYN4PscyiJ8g1bK3NUZ6exZSOt9Dp4+Ka7u?=
 =?us-ascii?Q?QyLMmkEP9svD5xZdyF5VgZ1g/8+KiSQjFkY4q9vMsJmDfQZsnur4MIUVQq1B?=
 =?us-ascii?Q?8lopgHwctw2Abywzuqn5jmJXrfeptKCW/CW0rwtrMj/oas1SrKyPLQvvZfD0?=
 =?us-ascii?Q?mcuOpQkSKznHAj4iNMIUECdN/hFGU7KsujOqqNlFDPKdwSgpYXznzAVakW9Y?=
 =?us-ascii?Q?cwhI0r6F4uuUjQXUeRlLCvKKulTr+Lpx7SBoTAmwF4dN2Nm7/wcU9yswei4R?=
 =?us-ascii?Q?U67NLmTlbtrKEGCAEsHjSjOxBhQMahkw1fxuLsZ0oQFYmc3lo5WJcTmyKb+R?=
 =?us-ascii?Q?Dn3UB+8YRxOhITOkm0x7hKc8kkmMh2mEKQn9IYbvit5aur+C4gGkIiSMGaJ0?=
 =?us-ascii?Q?+2m9IXnPDR3Mzqt1kBJ4UB9GIZ95qmsq5fkPFf+9K5jM5HA+sIIc1jOhr8XZ?=
 =?us-ascii?Q?i+tvr2LYkfOXTGnH6CJs1b8s0CYvmZJYNVDtQXSZrJxJ9v2BASCbG358Zn6T?=
 =?us-ascii?Q?VzSkbZ75OyokNkz36zg9MhoOqjqF4GqcqGjxS7G4bSVQ4Pgvr+QpnTCaILjk?=
 =?us-ascii?Q?mwPumIV4Ds2lZY5XyCTtfn2ziizchD8dkz8pmK+7w9S6RVFSX/j6rhDG3VRF?=
 =?us-ascii?Q?xyfAZIwO6qlyqGM2QXDFvDP0O5eT9ON4g5h2rMWcycSf/mRvhgLntCzNql9H?=
 =?us-ascii?Q?EMXmBU6Nsx6XlZzyshWQQjsk3Sb02XkozGLpeuEU+uMD6dkBlAmQ4vhr118i?=
 =?us-ascii?Q?fKVxZQ897w+0NXWVuDpvbe7gfL1x9TmJB8e9YHJktaNyP0LcGVLFAEJNwEql?=
 =?us-ascii?Q?qz0jMmmfHT40Jn95+ztDOOgdWLXJzaMwUbdtb3nRlxxYSWp5MJ1hcW9tokgc?=
 =?us-ascii?Q?htj796keX4c7tsE5+Tqy2ixEmAuTrtHln9Arwz1KED7jWpqGrWz0CS1UY8OA?=
 =?us-ascii?Q?8b9I4sJ66d7mn2anOSy6hyE3ERfR3/HMwM1vJFi8jFzdDHv6+akkVBn5IiBK?=
 =?us-ascii?Q?73V2Ks9o+i/UrKbzyxlWH0u9lEZkt0iF0ZJuU8gKZaBnJm81ZVud6ja9H6RR?=
 =?us-ascii?Q?iFBYQ2wiKQhjVvdJ3JnKRL9RW7QycIktiVKwrxMWLzmnATe9PH3h1OLiQ7MO?=
 =?us-ascii?Q?kpeopIWXa1CJwceI3xI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:22:50.2927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3905774f-edcd-49ec-4f86-08de2861d044
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9653
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

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[WHY & HOW]
Newer ASICs have different PSP footer sizes which lead to driver
failing to locate the DMCUB FW meta info, which in turn causes
improper DMCUB FW loading and causes DMCUB to crash.

Add support for custom PSP footer sizes and check 512B by default
as well.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 51 ++++++++++-------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 +++
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 33 +++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 57 +++++++++++++++----
 5 files changed, 119 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 424020c0756d..580a5e1e37f7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -152,12 +152,6 @@ MODULE_FIRMWARE(FIRMWARE_DCN_36_DMUB);
 #define FIRMWARE_DCN_401_DMUB "amdgpu/dcn_4_0_1_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_DCN_401_DMUB);
 
-/* Number of bytes in PSP header for firmware. */
-#define PSP_HEADER_BYTES 0x100
-
-/* Number of bytes in PSP footer for firmware. */
-#define PSP_FOOTER_BYTES 0x100
-
 /**
  * DOC: overview
  *
@@ -1298,15 +1292,14 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 
 	fw_inst_const = dmub_fw->data +
 			le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
-			PSP_HEADER_BYTES;
+			PSP_HEADER_BYTES_256;
 
 	fw_bss_data = dmub_fw->data +
 		      le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
 		      le32_to_cpu(hdr->inst_const_bytes);
 
 	/* Copy firmware and bios info into FB memory. */
-	fw_inst_const_size = le32_to_cpu(hdr->inst_const_bytes) -
-			     PSP_HEADER_BYTES - PSP_FOOTER_BYTES;
+	fw_inst_const_size = adev->dm.fw_inst_size;
 
 	fw_bss_data_size = le32_to_cpu(hdr->bss_data_bytes);
 
@@ -2437,9 +2430,11 @@ static void amdgpu_dm_dmub_reg_write(void *ctx, uint32_t address,
 static int dm_dmub_sw_init(struct amdgpu_device *adev)
 {
 	struct dmub_srv_create_params create_params;
+	struct dmub_srv_fw_meta_info_params fw_meta_info_params;
 	struct dmub_srv_region_params region_params;
 	struct dmub_srv_region_info region_info;
 	struct dmub_srv_memory_params memory_params;
+	struct dmub_fw_meta_info fw_info;
 	struct dmub_srv_fb_info *fb_info;
 	struct dmub_srv *dmub_srv;
 	const struct dmcub_firmware_header_v1_0 *hdr;
@@ -2547,22 +2542,37 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
+	/* Extract the FW meta info. */
+	memset(&fw_meta_info_params, 0, sizeof(fw_meta_info_params));
+
+	fw_meta_info_params.inst_const_size = le32_to_cpu(hdr->inst_const_bytes) -
+					      PSP_HEADER_BYTES_256;
+	fw_meta_info_params.bss_data_size = le32_to_cpu(hdr->bss_data_bytes);
+	fw_meta_info_params.fw_inst_const = adev->dm.dmub_fw->data +
+					    le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
+					    PSP_HEADER_BYTES_256;
+	fw_meta_info_params.fw_bss_data = region_params.bss_data_size ? adev->dm.dmub_fw->data +
+					  le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
+					  le32_to_cpu(hdr->inst_const_bytes) : NULL;
+	fw_meta_info_params.custom_psp_footer_size = 0;
+
+	status = dmub_srv_get_fw_meta_info_from_raw_fw(&fw_meta_info_params, &fw_info);
+	if (status != DMUB_STATUS_OK) {
+		/* Skip returning early, just log the error. */
+		drm_err(adev_to_drm(adev), "Error getting DMUB FW meta info: %d\n", status);
+		// return -EINVAL;
+	}
+
 	/* Calculate the size of all the regions for the DMUB service. */
 	memset(&region_params, 0, sizeof(region_params));
 
-	region_params.inst_const_size = le32_to_cpu(hdr->inst_const_bytes) -
-					PSP_HEADER_BYTES - PSP_FOOTER_BYTES;
-	region_params.bss_data_size = le32_to_cpu(hdr->bss_data_bytes);
+	region_params.inst_const_size = fw_meta_info_params.inst_const_size;
+	region_params.bss_data_size = fw_meta_info_params.bss_data_size;
 	region_params.vbios_size = adev->bios_size;
-	region_params.fw_bss_data = region_params.bss_data_size ?
-		adev->dm.dmub_fw->data +
-		le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
-		le32_to_cpu(hdr->inst_const_bytes) : NULL;
-	region_params.fw_inst_const =
-		adev->dm.dmub_fw->data +
-		le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
-		PSP_HEADER_BYTES;
+	region_params.fw_bss_data = fw_meta_info_params.fw_bss_data;
+	region_params.fw_inst_const = fw_meta_info_params.fw_inst_const;
 	region_params.window_memory_type = window_memory_type;
+	region_params.fw_info = (status == DMUB_STATUS_OK) ? &fw_info : NULL;
 
 	status = dmub_srv_calc_region_info(dmub_srv, &region_params,
 					   &region_info);
@@ -2609,6 +2619,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 	}
 
 	adev->dm.bb_from_dmub = dm_dmub_get_vbios_bounding_box(adev);
+	adev->dm.fw_inst_size = fw_meta_info_params.inst_const_size;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index d683b710181b..7065b20aa2e6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -408,6 +408,13 @@ struct amdgpu_display_manager {
 	 */
 	uint32_t dmcub_fw_version;
 
+	/**
+	 * @fw_inst_size:
+	 *
+	 * Size of the firmware instruction buffer.
+	 */
+	uint32_t fw_inst_size;
+
 	/**
 	 * @cgs_device:
 	 *
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a1fb5ed653a9..531d4a4c9326 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1188,6 +1188,7 @@ struct dc_debug_options {
 	bool enable_pg_cntl_debug_logs;
 	bool disable_stutter_for_wm_program;
 	bool enable_block_sequence_programming;
+	uint32_t custom_psp_footer_size;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 9d0168986fe7..12c1f9f7115a 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -72,6 +72,9 @@
 /* Default tracebuffer size if meta is absent. */
 #define DMUB_TRACE_BUFFER_SIZE (64 * 1024)
 
+#define PSP_HEADER_BYTES_256 0x100 // 256 bytes
+#define PSP_FOOTER_BYTES_256 0x100 // 256 bytes
+
 /* Forward declarations */
 struct dmub_srv;
 struct dmub_srv_common_regs;
@@ -227,6 +230,23 @@ struct dmub_srv_region_params {
 	const uint8_t *fw_inst_const;
 	const uint8_t *fw_bss_data;
 	const enum dmub_window_memory_type *window_memory_type;
+	const struct dmub_fw_meta_info *fw_info;
+};
+
+/**
+ * struct dmub_srv_fw_meta_info_params - params used for fetching fw meta info from fw_image
+ * @inst_const_size: size of the fw inst const section
+ * @bss_data_size: size of the fw bss data section
+ * @fw_inst_const: raw firmware inst const section
+ * @fw_bss_data: raw firmware bss data section
+ * @custom_psp_footer_size: custom psp footer size to use when indexing for fw meta info
+ */
+struct dmub_srv_fw_meta_info_params {
+	uint32_t inst_const_size;
+	uint32_t bss_data_size;
+	const uint8_t *fw_inst_const;
+	const uint8_t *fw_bss_data;
+	uint32_t custom_psp_footer_size;
 };
 
 /**
@@ -249,6 +269,7 @@ struct dmub_srv_region_info {
 	uint32_t gart_size;
 	uint8_t num_regions;
 	struct dmub_region regions[DMUB_WINDOW_TOTAL];
+	uint32_t verified_psp_footer_size;
 };
 
 /**
@@ -1098,4 +1119,16 @@ enum dmub_status dmub_srv_update_inbox_status(struct dmub_srv *dmub);
  */
 bool dmub_srv_get_preos_info(struct dmub_srv *dmub);
 
+/**
+ * dmub_srv_get_fw_meta_info_from_raw_fw() - Fetch firmware metadata info from raw firmware image
+ * @params: parameters for fetching firmware metadata info
+ * @fw_info_out: output buffer for firmware metadata info
+ *
+ * Return:
+ *   DMUB_STATUS_OK - success
+ *   DMUB_STATUS_INVALID - no FW meta info found
+ */
+enum dmub_status dmub_srv_get_fw_meta_info_from_raw_fw(struct dmub_srv_fw_meta_info_params *params,
+						       struct dmub_fw_meta_info *fw_info_out);
+
 #endif /* _DMUB_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index a6ae1d2e9685..be893531ae7d 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -134,7 +134,7 @@ dmub_get_fw_meta_info_from_blob(const uint8_t *blob, uint32_t blob_size, uint32_
 }
 
 static const struct dmub_fw_meta_info *
-dmub_get_fw_meta_info(const struct dmub_srv_region_params *params)
+dmub_get_fw_meta_info(const struct dmub_srv_fw_meta_info_params *params)
 {
 	const struct dmub_fw_meta_info *info = NULL;
 
@@ -159,6 +159,46 @@ dmub_get_fw_meta_info(const struct dmub_srv_region_params *params)
 	return info;
 }
 
+enum dmub_status
+dmub_srv_get_fw_meta_info_from_raw_fw(struct dmub_srv_fw_meta_info_params *params,
+				      struct dmub_fw_meta_info *fw_info_out)
+{
+	const struct dmub_fw_meta_info *fw_info = NULL;
+	uint32_t inst_const_size_temp = params->inst_const_size;
+
+	/* First try custom psp footer size, if present */
+	if (params->custom_psp_footer_size) {
+		params->inst_const_size -= params->custom_psp_footer_size;
+		fw_info = dmub_get_fw_meta_info(params);
+		if (fw_info) {
+			memcpy(fw_info_out, fw_info, sizeof(*fw_info));
+			return DMUB_STATUS_OK;
+		}
+		params->inst_const_size = inst_const_size_temp;
+	}
+
+	/* Try 256-byte psp footer size */
+	params->inst_const_size -= PSP_FOOTER_BYTES_256;
+	fw_info = dmub_get_fw_meta_info(params);
+	if (fw_info) {
+		memcpy(fw_info_out, fw_info, sizeof(*fw_info));
+		return DMUB_STATUS_OK;
+	}
+
+	/* Try 512-byte psp footer size - final attempt */
+	params->inst_const_size -= PSP_FOOTER_BYTES_256; // 256 bytes already subtracted, subtract 256 again
+	fw_info = dmub_get_fw_meta_info(params);
+	if (fw_info) {
+		memcpy(fw_info_out, fw_info, sizeof(*fw_info));
+		return DMUB_STATUS_OK;
+	}
+
+	/* Restore original inst_const_size and subtract default PSP footer size - default behaviour */
+	params->inst_const_size = inst_const_size_temp - PSP_FOOTER_BYTES_256;
+
+	return DMUB_STATUS_INVALID;
+}
+
 static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 {
 	struct dmub_srv_hw_funcs *funcs = &dmub->hw_funcs;
@@ -524,7 +564,6 @@ enum dmub_status
 		const struct dmub_srv_region_params *params,
 		struct dmub_srv_region_info *out)
 {
-	const struct dmub_fw_meta_info *fw_info;
 	uint32_t fw_state_size = DMUB_FW_STATE_SIZE;
 	uint32_t trace_buffer_size = DMUB_TRACE_BUFFER_SIZE;
 	uint32_t shared_state_size = DMUB_FW_HEADER_SHARED_STATE_SIZE;
@@ -538,14 +577,12 @@ enum dmub_status
 
 	out->num_regions = DMUB_NUM_WINDOWS;
 
-	fw_info = dmub_get_fw_meta_info(params);
-
-	if (fw_info) {
-		memcpy(&dmub->meta_info, fw_info, sizeof(*fw_info));
+	if (params->fw_info) {
+		memcpy(&dmub->meta_info, params->fw_info, sizeof(*params->fw_info));
 
-		fw_state_size = fw_info->fw_region_size;
-		trace_buffer_size = fw_info->trace_buffer_size;
-		shared_state_size = fw_info->shared_state_size;
+		fw_state_size = params->fw_info->fw_region_size;
+		trace_buffer_size = params->fw_info->trace_buffer_size;
+		shared_state_size = params->fw_info->shared_state_size;
 
 		/**
 		 * If DM didn't fill in a version, then fill it in based on
@@ -555,7 +592,7 @@ enum dmub_status
 		 * pass during creation.
 		 */
 		if (dmub->fw_version == 0)
-			dmub->fw_version = fw_info->fw_version;
+			dmub->fw_version = params->fw_info->fw_version;
 	}
 
 	window_sizes[DMUB_WINDOW_0_INST_CONST] = params->inst_const_size;
-- 
2.43.0

