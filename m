Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DC4E9126B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 06:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 597AC10E1F1;
	Thu,  5 Feb 2026 06:51:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L0Zmx+lR";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45A9710E1F1
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 06:51:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f46odAhMaDAT/1RcyQmsTYl092t3mFH/n/qcoHGBrxYkw2aRgnPfW6nAuPjcmN1HmPrqCmtHLAr5hF8B0uK68zZF7kANx5zcN2D3oH1OjWZPZQiNXKYZ8IdwXgIpA1iKNZEjJWuS6+vm9Pg9fVBXM35KJXUi2vVbOq5UFNAAKU12BHgDfdpZ4XqT30u+zqRK+YeAKT8tSWnmiJpKYSdUw6dyY6tx4j0lwKOfIzFMii8X66Isc4uFxONTwuMP0FUdew0E/C+RmwoFymIx2d+IYIbrxxct3bHUorI9DuoSaKKRGKmMNLhS30lDLZLgvIOzRNa93uC1UHFnA7ehUR7qZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLG9UqckMSSGUDXr0FMRX5W3adnNIDtCMqEzyaA9vXQ=;
 b=I5Tpg4T+5tno5dDcvL7OO6caFecT+ORsDzeBkSEdYbwkKDT9XjZMlgtFuiRpMspKRVA6mH2AfPPbeW6AsWVkS896jn53ySiVBgQLvT/xmxowUl6JKcSNhUmwMAcmm0fVc+vGjuJqAK8P/lcI3zi+sogUz4cT0UeqTcXhaupVeHUwMirKsuzA86NV06KyIa3gmt8BBIgx3zuuWCh5/4Y6SR93PYWHESPkZsVDoNJkURT0n3ZCskhWPQnroDzZdd+wDqpbvwPaH1k72Lr1XjuLov29yEvewdBP+d7F95h1R2F12IHO7lsV8NLtuoyhlL9aTyYuFI3HK42j0Ux0CPXz0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLG9UqckMSSGUDXr0FMRX5W3adnNIDtCMqEzyaA9vXQ=;
 b=L0Zmx+lRz8GM753OeYWXJdXwK8HQ5FiQpCs1iFdi5E7nXWpY+D+MYnOPACIAv3UUrfSyDoomYQn6poDfLnGQqPiwYEDitbbctILv2CUwgmRrWsmPQKPlwk156Msa3oVSGxCJgkycfTBziHNK5lHHpsm4/J7O1x0FNaHuUObUIP0=
Received: from CY5P221CA0043.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::13) by
 LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 06:51:40 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:4:cafe::f4) by CY5P221CA0043.outlook.office365.com
 (2603:10b6:930:4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 06:51:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 06:51:39 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 00:51:37 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <yifan1.zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH 01/22] drm/amdgpu: add new performance monitor PSP interfaces
Date: Thu, 5 Feb 2026 14:51:09 +0800
Message-ID: <20260205065130.654921-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|LV2PR12MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: e572978f-8b7f-4d7f-014d-08de64830359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gnfqiz3U1u4CEpxkpjAgLOPeaM/QrPhMAAaCZWjMJlq/tx4Cw1VD+qXJkxq4?=
 =?us-ascii?Q?Vb8Yt8sS8v2Au4Gx2Iiu/slQDqm5ZI/EOyAuRUUMD8+sERGbDfL4IARblCFh?=
 =?us-ascii?Q?jkyj+Cb56l3gSR8+bAjFEgWQ+FBYlySxjyIS0EFWUUYbQ92DU1DcCgo0Fzt1?=
 =?us-ascii?Q?I+2b5w9DWsIGZIpWOvDPkR16iSd6Kq8IpnBknsVgb0gZNVDCvoDz4b7RsnfM?=
 =?us-ascii?Q?iOYNKYV+YUouRXcIwJVcAsHPkg3/wNgqDEh9Xo0QNlWI6xNQjErrihX6we86?=
 =?us-ascii?Q?yTdQVHgvSHbFTCVIKJtPOLJ/+KW/5InyDiWUu9PuaqWt6iql3Woj7yqBm55Y?=
 =?us-ascii?Q?/XnLDnUYO3zUJExpGvBMXiSY3Ni3iPnekU9AUydCU2CEEk6DNWYSe7x4tQtR?=
 =?us-ascii?Q?D2xWrX7+lVNooBuhn1bs9N4MSc7AkSTZZPWShkgaAGwYRVT0uD1wWNRr8ylh?=
 =?us-ascii?Q?we/5Ulbl32alXwD3OyBn4/7H7BZ2DHBbJ5lQ81EPXcq/LweOvQOW9oBQL2UL?=
 =?us-ascii?Q?LI2jz1AUn3BQJ9CP0Sta/Kftmsk7FNR8hPfdRejzZH2OnsbhKs+4UevxQITi?=
 =?us-ascii?Q?CNHxMa1AjGz/pUjotG2KVM5zm7+IHQvh/T3KgrMllb0a531n1jDLjOCv//Dn?=
 =?us-ascii?Q?1jPTZHRPN0ePg7hT8ecoSrtpFkpSsRWwzjjlbLyXApk7qnDV7u2rKV7vUz2f?=
 =?us-ascii?Q?MqyW5LSb8cmIaM/X0P4iwIF6Yh95cvFmqA41ZEhu/kCTtK8CZQSzl8SRCq6h?=
 =?us-ascii?Q?X5d3HGJo2+nfRDWqNOVV8AKO3IpG2YTynDU/RC6k4L7jQHmfd1BYcaiEr0Gz?=
 =?us-ascii?Q?ztYTv6o/9cViGg0CoHoizRt0IhpnlQvXPHqLejg3yaIy6UfE4DpNXiPvimFM?=
 =?us-ascii?Q?ziS7DoSmz+IKkDzYyChzUk4Gd0vIkYmPmJIID9WiUKdaJl2LiecPhfz3zpaL?=
 =?us-ascii?Q?MbmnfSTCWXJ6hZaJNLRnVTlQGE0bnhU/+sbr+SRhHxPewgqGT7miPebChuIN?=
 =?us-ascii?Q?CvXfsvfH9kQjeCrwgy8n4BKzrQeOlQRg2I0NyXh348nQf6rkKRyJ6KlYl1Ll?=
 =?us-ascii?Q?HsUQF9E4TSfJ/8cvuphsfW/4PuUPxgySx59FrQTjzB+cHy6kxwH784HQIobn?=
 =?us-ascii?Q?JxYXDAUj4kKRu6THnJTr67H318INogL9BcXtes+eXrqHel5GEA9mFhfVqz3M?=
 =?us-ascii?Q?LjVqUocsA9jkSawGBxxouNOdHB+NiclZKO90n0pXunv7huj6gIjOZ+CVv9gM?=
 =?us-ascii?Q?8GK7rYIMup6DjyKpGyuW6RJnm/pDC6XOnwY6hJZ5IbUlC9KLq3ZCIgNzcI5g?=
 =?us-ascii?Q?uVQU8cti6ArxFxfAPfAiSlmVF++/blH1T9tdxhdANTb4mvitdj6Xw/GO9bt1?=
 =?us-ascii?Q?EgOAjo/fmU3g//1Fpr4lx/zacq7QGtZA1u6ECVtiSBIY77+EhYqmsBmEsoSZ?=
 =?us-ascii?Q?VZqPxh3zZJoft4oyrT8Yd+DPsqiHLtfvqbPU/AcnsIzfyxjhFZE9+1i3a7Dm?=
 =?us-ascii?Q?0nKr2zV0opQK+I1Zhw87rVHLAMuNBG3/dJChFd15V/x6/kCYQi5YXwYQ2iFy?=
 =?us-ascii?Q?coGrpCA0FlOe4yLmyxCbEj+3Fi7Ol5q9bhQX5/K0YIPmziWxEE0ahJleVXXh?=
 =?us-ascii?Q?mqTOOnZOLZrQ3YRZNzHMhPxuMIXSYyZzXmELlRXnzbe7LUUQP8k4VuX4e2Y7?=
 =?us-ascii?Q?ZgHYig=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kYSjMDeWqKHMFIL5m41/IYKzC5oWWyNnLyeKkkVgLVD9fOSYolJS4oPrG1G7STZ+7aaex72oj2ukFCvFSaYJwoKkPPBPzu/gbRbgXL3ZKQbw3ktnapnuRIkk3UpCQdvI/dPOcI29FYKY8Pae0e8S8fD5BggeXav7OF+HaqCXHRAPR5H81zz4K5/8JJ+AGiF6HpykIiqTopOQwPF2+tmGlEhsgMeF/0iduXiIb9BxmmC3gtNp81ofCgOaCavixIS9+IWfo8Y77ZPF+S2P+IMmyYC/Bz3zyCsbhvV/orkf+Cr4VCYgGcbGx6cCv1JVy8Efqd3BDKU15PWAnNNdsFlv53sGPIFv4HpmzL1EjOUYoyKulIYEdoRpI4t7enP+Tm0E4GSnZ2YxZZ3jMHXLYEa/481ljYu/rUIIrPUyH5NQ9h/2tzP3m8dzWggmH9RhPQx2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:51:39.1982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e572978f-8b7f-4d7f-014d-08de64830359
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942
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

Introduce new psp interfaces and structures for performance
monitoring hardware control.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 22 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h | 18 ++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 79a49cba8d40..90df8e29f532 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -359,6 +359,28 @@ struct spirom_bo {
 };
 #endif
 
+enum psp_ptl_cmd {
+	PSP_PTL_PERF_MON_QUERY = 0xA0000000,
+	PSP_PTL_PERF_MON_SET = 0xA0000001,
+};
+
+enum psp_ptl_format_type
+{
+	GFX_FTYPE_I8          = 0x00000000,
+	GFX_FTYPE_F16         = 0x00000001,
+	GFX_FTYPE_BF16        = 0x00000002,
+	GFX_FTYPE_F32         = 0x00000003,
+	GFX_FTYPE_F64         = 0x00000004,
+	GFX_FTYPE_INVALID     = 0xFFFFFFFF,
+};
+
+struct psp_ptl_perf_req {
+	enum psp_ptl_cmd req;
+	uint32_t ptl_state;
+	uint32_t pref_format1;
+	uint32_t pref_format2;
+};
+
 struct psp_context {
 	struct amdgpu_device		*adev;
 	struct psp_ring			km_ring;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index e8f768638fd5..323518da450c 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -107,6 +107,7 @@ enum psp_gfx_cmd_id
     GFX_CMD_ID_CONFIG_SQ_PERFMON  = 0x00000046,   /* Config CGTT_SQ_CLK_CTRL */
     /* Dynamic memory partitioninig (NPS mode change)*/
     GFX_CMD_ID_FB_NPS_MODE        = 0x00000048,  /* Configure memory partitioning mode */
+    GFX_CMD_ID_PERF_HW            = 0x0000004C,   /* performance monitor */
     GFX_CMD_ID_FB_FW_RESERV_ADDR  = 0x00000050,  /* Query FW reservation addr */
     GFX_CMD_ID_FB_FW_RESERV_EXT_ADDR = 0x00000051,  /* Query FW reservation extended addr */
 };
@@ -373,6 +374,13 @@ struct psp_gfx_cmd_fb_memory_part {
 	uint32_t resvd;
 };
 
+struct psp_gfx_cmd_req_perf_hw {
+	uint32_t req;
+	uint32_t ptl_state;
+	uint32_t pref_format1;
+	uint32_t pref_format2;
+};
+
 /* All GFX ring buffer commands. */
 union psp_gfx_commands
 {
@@ -389,6 +397,7 @@ union psp_gfx_commands
     struct psp_gfx_cmd_sriov_spatial_part cmd_spatial_part;
     struct psp_gfx_cmd_config_sq_perfmon config_sq_perfmon;
     struct psp_gfx_cmd_fb_memory_part cmd_memory_part;
+    struct psp_gfx_cmd_req_perf_hw     cmd_req_perf_hw;
 };
 
 struct psp_gfx_uresp_reserved
@@ -415,12 +424,21 @@ struct psp_gfx_uresp_fw_reserve_info {
     uint32_t reserve_size;
 };
 
+struct psp_gfx_uresp_perf_hw
+{
+    uint32_t resp;
+    uint32_t ptl_state;
+    uint32_t pref_format1;
+    uint32_t pref_format2;
+};
+
 /* Union of command-specific responses for GPCOM ring. */
 union psp_gfx_uresp {
 	struct psp_gfx_uresp_reserved		reserved;
 	struct psp_gfx_uresp_bootcfg		boot_cfg;
 	struct psp_gfx_uresp_fwar_db_info	fwar_db_info;
 	struct psp_gfx_uresp_fw_reserve_info	fw_reserve_info;
+	struct psp_gfx_uresp_perf_hw		perf_hw_info;
 };
 
 /* Structure of GFX Response buffer.
-- 
2.34.1

